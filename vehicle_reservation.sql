-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.3.8-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for vehicle_reservation
DROP DATABASE IF EXISTS `vehicle_reservation`;
CREATE DATABASE IF NOT EXISTS `vehicle_reservation` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `vehicle_reservation`;

-- Dumping structure for table vehicle_reservation.company
DROP TABLE IF EXISTS `company`;
CREATE TABLE IF NOT EXISTS `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.company: ~1 rows (approximately)
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` (`id`, `name`, `deleted`) VALUES
	(1, 'Telegroup', 0);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.expense
DROP TABLE IF EXISTS `expense`;
CREATE TABLE IF NOT EXISTS `expense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` decimal(8,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  `expense_type_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `vehicle_id` int(11) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `R_17` (`expense_type_id`),
  KEY `R_18` (`company_id`),
  KEY `R_19` (`vehicle_id`),
  CONSTRAINT `R_17` FOREIGN KEY (`expense_type_id`) REFERENCES `expense_type` (`id`),
  CONSTRAINT `R_18` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `R_19` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.expense: ~0 rows (approximately)
/*!40000 ALTER TABLE `expense` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.expense_type
DROP TABLE IF EXISTS `expense_type`;
CREATE TABLE IF NOT EXISTS `expense_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.expense_type: ~3 rows (approximately)
/*!40000 ALTER TABLE `expense_type` DISABLE KEYS */;
INSERT INTO `expense_type` (`id`, `name`) VALUES
	(1, 'Gorivo'),
	(2, 'Servis'),
	(3, 'Ostalo');
/*!40000 ALTER TABLE `expense_type` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.location
DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `company_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `R_11` (`company_id`),
  CONSTRAINT `R_11` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.location: ~0 rows (approximately)
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.location_has_vehicle
DROP TABLE IF EXISTS `location_has_vehicle`;
CREATE TABLE IF NOT EXISTS `location_has_vehicle` (
  `start_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_date` timestamp NULL DEFAULT NULL,
  `vehicle_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`start_date`,`vehicle_id`,`location_id`),
  KEY `R_23` (`vehicle_id`),
  KEY `R_24` (`location_id`),
  CONSTRAINT `R_23` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`),
  CONSTRAINT `R_24` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.location_has_vehicle: ~0 rows (approximately)
/*!40000 ALTER TABLE `location_has_vehicle` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_has_vehicle` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.logger
DROP TABLE IF EXISTS `logger`;
CREATE TABLE IF NOT EXISTS `logger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_type` varchar(128) NOT NULL,
  `action_details` varchar(128) NOT NULL,
  `table_name` varchar(128) NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `atomic` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `R_9` (`user_id`),
  KEY `R_10` (`company_id`),
  CONSTRAINT `R_10` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `R_9` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.logger: ~0 rows (approximately)
/*!40000 ALTER TABLE `logger` DISABLE KEYS */;
/*!40000 ALTER TABLE `logger` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.manufacturer
DROP TABLE IF EXISTS `manufacturer`;
CREATE TABLE IF NOT EXISTS `manufacturer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `R_14` (`company_id`),
  CONSTRAINT `R_14` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.manufacturer: ~0 rows (approximately)
/*!40000 ALTER TABLE `manufacturer` DISABLE KEYS */;
/*!40000 ALTER TABLE `manufacturer` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.model
DROP TABLE IF EXISTS `model`;
CREATE TABLE IF NOT EXISTS `model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `manufacturer_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `R_12` (`manufacturer_id`),
  CONSTRAINT `R_12` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.model: ~0 rows (approximately)
/*!40000 ALTER TABLE `model` DISABLE KEYS */;
/*!40000 ALTER TABLE `model` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.notification_type
DROP TABLE IF EXISTS `notification_type`;
CREATE TABLE IF NOT EXISTS `notification_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.notification_type: ~3 rows (approximately)
/*!40000 ALTER TABLE `notification_type` DISABLE KEYS */;
INSERT INTO `notification_type` (`id`, `name`) VALUES
	(1, 'Isključena'),
	(2, 'Za lokaciju'),
	(3, 'Za kompaniju');
/*!40000 ALTER TABLE `notification_type` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.reservation
DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_mileage` int(11) NOT NULL,
  `end_mileage` int(11) DEFAULT NULL,
  `direction` varchar(512) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `company_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `R_25` (`company_id`),
  KEY `R_26` (`vehicle_id`),
  KEY `R_27` (`user_id`),
  CONSTRAINT `R_25` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `R_26` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`),
  CONSTRAINT `R_27` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.reservation: ~0 rows (approximately)
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.role
DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.role: ~3 rows (approximately)
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`id`, `name`) VALUES
	(1, 'Administrator sistema'),
	(2, 'Administrator kompanije'),
	(3, 'Korisnik');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.status
DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.status: ~3 rows (approximately)
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` (`id`, `name`) VALUES
	(1, 'Aktivan'),
	(2, 'Na čekanju'),
	(3, 'Neaktivan');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `password` char(128) DEFAULT NULL,
  `first_name` varchar(64) DEFAULT NULL,
  `last_name` varchar(64) DEFAULT NULL,
  `photo` binary(1) DEFAULT NULL,
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `token` char(64) DEFAULT NULL,
  `email` varchar(64) NOT NULL,
  `role_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `notification_type_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `R_5` (`role_id`),
  KEY `R_6` (`status_id`),
  KEY `R_7` (`company_id`),
  KEY `R_28` (`notification_type_id`),
  KEY `R_29` (`location_id`),
  CONSTRAINT `R_28` FOREIGN KEY (`notification_type_id`) REFERENCES `notification_type` (`id`),
  CONSTRAINT `R_29` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `R_5` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `R_6` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  CONSTRAINT `R_7` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.user: ~0 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.vehicle
DROP TABLE IF EXISTS `vehicle`;
CREATE TABLE IF NOT EXISTS `vehicle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `model_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `registration` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `R_15` (`model_id`),
  KEY `R_16` (`company_id`),
  CONSTRAINT `R_15` FOREIGN KEY (`model_id`) REFERENCES `model` (`id`),
  CONSTRAINT `R_16` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.vehicle: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
