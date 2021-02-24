-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 24, 2021 at 10:14 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chat-app`
--

-- --------------------------------------------------------

--
-- Table structure for table `chatmessage`
--

CREATE TABLE `chatmessage` (
  `id` varchar(64) NOT NULL,
  `receiverId` varchar(64) NOT NULL,
  `senderId` varchar(64) NOT NULL,
  `message` text NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chatmessage`
--

INSERT INTO `chatmessage` (`id`, `receiverId`, `senderId`, `message`, `time`) VALUES
('016d661b-da1a-4e88-8f0b-738bf3aef1b0', '88790da6-a4d0-46a2-bf32-94d099b61adc', '77f15576-3ce5-491c-827e-08bfca8c850c', 'Kenapa?', '2021-02-24 20:33:38'),
('2ab732ce-1803-43e8-97ce-2e57832672b0', '88790da6-a4d0-46a2-bf32-94d099b61adc', '77f15576-3ce5-491c-827e-08bfca8c850c', 'Dirumah lek', '2021-02-24 20:33:09'),
('8da690bf-a7ed-4017-a67c-5e1532b934b9', '77f15576-3ce5-491c-827e-08bfca8c850c', '88790da6-a4d0-46a2-bf32-94d099b61adc', 'Oi', '2021-02-24 20:28:58'),
('dbba7f8e-3c92-481c-9f72-838901b81ae5', '77f15576-3ce5-491c-827e-08bfca8c850c', '88790da6-a4d0-46a2-bf32-94d099b61adc', 'Dimana?', '2021-02-24 20:29:11');

-- --------------------------------------------------------

--
-- Table structure for table `chatroom`
--

CREATE TABLE `chatroom` (
  `id` varchar(80) NOT NULL,
  `senderId` varchar(80) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `id` varchar(80) NOT NULL,
  `nameRoom` varchar(255) DEFAULT NULL,
  `userId` varchar(80) DEFAULT NULL,
  `imgRoom` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(130) NOT NULL,
  `username` varchar(60) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `photoProfile` varchar(200) DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT NULL,
  `lat` varchar(255) DEFAULT NULL,
  `lng` varchar(255) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `email`, `password`, `bio`, `phoneNumber`, `photoProfile`, `isActive`, `lat`, `lng`, `status`) VALUES
('77f15576-3ce5-491c-827e-08bfca8c850c', 'fadhilmuhammad', 'Fadhil Muhammad', 'fadhilmuhammad261297@gmail.com', '$2a$10$hYOvcvsxaxLV4XXJOICi9eFXS9JBoFKbewczUgb4GY5VWMPAt43Hm', 'My great bio', '087512346789', 'http://127.0.0.1:1000/upload/1614191105267-Unilak Pas.jpg', 0, '1.0111', '100.4993', 'offline'),
('88790da6-a4d0-46a2-bf32-94d099b61adc', 'naldeee', 'Renaldi Pratama', 'renaldipratama51@gmail.com', '$2a$10$4BGOR3J6JwhLHnqQFdU5B.NPVsucWF8FkD3JMVonpa2uq7eYUadpK', 'Mantap', '085264988916', 'http://127.0.0.1:1000/upload/1614189928268-picture.JPG', 0, '2.1153546999999997', '99.54509739999999', 'offline');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chatmessage`
--
ALTER TABLE `chatmessage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chatroom`
--
ALTER TABLE `chatroom`
  ADD PRIMARY KEY (`id`),
  ADD KEY `senderId` (`senderId`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
