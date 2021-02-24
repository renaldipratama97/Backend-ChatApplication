require('dotenv').config()
const http = require('http')
const express = require('express')
const socket = require('socket.io')
const morgan = require('morgan')
const bodyParser = require('body-parser')

const app = express()
const server = http.createServer(app)
const io = socket(server, {
    cors: {
        origin: '*'
    }
})
const PORT = process.env.PORT
const cors = require('cors')
const routerMain = require('./src/router/index')
const {insertMessage} = require('./src/models/message')
const {insertMessageGroup} = require('./src/models/chatRoom')
const {update} = require('./src/models/user')
const { v4: uuidv4 } = require('uuid')

app.use(cors())
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())
app.use(morgan('dev'))
app.use('/upload', express.static('./uploads'))

// const users = []
io.on('connection', (socket) => {
    console.log('connection', socket.id)

    //status online
    socket.on('online', async userLogin => {
        const id = userLogin.idUser
        const status = 'offline'
        const data = {}
        if (status) {data.status = status}
        const updateStatus = {
            status: 'online'
        }
        console.log(updateStatus)
        await update(updateStatus, id)
        .then((result) => {
            const resultMessage = result
            if (resultMessage.length === 0) {
                console.log('Update status online failed')
            }
            console.log('Update status online success')
            })
        .catch((err) => {
            console.log('ngga bisa update status', err)
        })
    })

    //status offline
    socket.on('offline', userLogout => {
        const id = userLogout.idUser
        const updateStatus = {
            status: 'offline'
        }
        console.log(updateStatus)
        update(updateStatus, id)
        .then((result) => {
            const resultMessage = result
            if (resultMessage.length === 0) {
                console.log('Update status offline failed')
            } 
            console.log('Update status offline success')
            })
    })

    //user login
    socket.on('initialUser', (data) => {
        console.log('id user login ' + data.senderId)
        socket.join(data.senderId)
    })

    //private chat
    socket.on('receiverMessage', (data) => {
        console.log(data)
        // callback(data)
        const id = uuidv4()
        const formatMessage = {
            id: id,
            message: data.message,
            senderId: data.senderId,
            receiverId: data.receiverId,
            time: new Date()
        }
        console.log(formatMessage)
        console.log('isi time', formatMessage.time)
        insertMessage(formatMessage)
        .then(result => {
            const resultMessage = result
            if (resultMessage.length === 0) {
                console.log('insert message failed')
            }
            console.log('insert message')
        })
        .catch(err => {
            console.log('ada error? ', err)
        })
        io.to(data.senderId).emit('kirimkembali', formatMessage)
        socket.to(data.receiverId).emit('kirimkembali', formatMessage)
    })

    //location
    socket.on('newLocation', (location) => {
        console.log(location)
        const updateLocation = {
            lat: location.lat,
            lng: location.lng
        }
        update(updateLocation, location.id)
        .then(result => {
            const resultMessage = result
            if (resultMessage.length === 0) {
                console.log('Update location failed')
            } 
            console.log('Update location success')
        })
        .catch(err => {
            console.log('ada error? ', err)
        })
    })

    socket.on('disconnect', () => {
        console.log('User Logout')
    })
})

app.use('/v1', routerMain)

app.use((req, res, next) => {
    const err = new Error('URL Not found')
    err.status = 404
    next(err)
})
  
app.use((err, req, res, next) => {
    res.status(500)
    res.send({
      error: {
        status: 500,
        message: err.message
      }
    })
})

server.listen(PORT, () => console.log(`Server running in port: ${PORT}`))