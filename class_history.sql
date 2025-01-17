-- MyDAC version: 10.4.3
-- MySQL server version: 5.5.5-10.11.2-MariaDB
-- MySQL client version: 8.0.0 Direct
-- Script date 2023/10/18 오후 11:34:22
-- ---------------------------------------------------------------------- 
-- Server: robotncoding.synology.me
-- Database: class_history

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
-- 
-- Table structure for table `attendance`
-- 
ALTER TABLE attendance AUTO_INCREMENT = 1;
DROP TABLE IF EXISTS `attendance`;
CREATE TABLE `attendance` (
  `attendance_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) DEFAULT NULL,
  `lesson_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`attendance_id`),
  KEY `student_id` (`student_id`),
  KEY `lesson_id` (`lesson_id`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`lesson_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- 
-- Table structure for table `lessons`
-- 
ALTER TABLE lessons AUTO_INCREMENT = 1;
DROP TABLE IF EXISTS `lessons`;
CREATE TABLE `lessons` (
  `lesson_id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_detail_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `lesson_detail` mediumtext DEFAULT NULL,
  `teach_comment` mediumtext DEFAULT NULL,
  `etc` mediumtext DEFAULT NULL,
  PRIMARY KEY (`lesson_id`),
  KEY `subject_detail_id` (`subject_detail_id`),
  CONSTRAINT `lessons_ibfk_1` FOREIGN KEY (`subject_detail_id`) REFERENCES `subject_detail` (`subject_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 
-- Table structure for table `students`
-- 
ALTER TABLE students AUTO_INCREMENT = 1;
DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `student_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `grade_level` int(11) NOT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 
-- Table structure for table `subject_detail`
-- 
ALTER TABLE subject_detail AUTO_INCREMENT = 1;
DROP TABLE IF EXISTS `subject_detail`;
CREATE TABLE `subject_detail` (
  `subject_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_id` int(11) DEFAULT NULL,
  `detail_script` text DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  PRIMARY KEY (`subject_detail_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `subject_detail_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 
-- Table structure for table `subjects`
-- 
ALTER TABLE subjects AUTO_INCREMENT = 1;
DROP TABLE IF EXISTS `subjects`;
CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
