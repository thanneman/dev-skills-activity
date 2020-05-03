-- MySQL dump 10.13  Distrib 5.7.30, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: craftcms
-- ------------------------------------------------------
-- Server version	5.7.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetindexdata`
--

LOCK TABLES `assetindexdata` WRITE;
/*!40000 ALTER TABLE `assetindexdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `uploaderId` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  KEY `assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransformindex`
--

LOCK TABLES `assettransformindex` WRITE;
/*!40000 ALTER TABLE `assettransformindex` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changedattributes`
--

DROP TABLE IF EXISTS `changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedattributes` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedattributes_siteId_fk` (`siteId`),
  KEY `changedattributes_userId_fk` (`userId`),
  CONSTRAINT `changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changedattributes`
--

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;
INSERT INTO `changedattributes` VALUES (2,1,'fieldLayoutId','2020-05-01 22:13:04',0,1);
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changedfields`
--

DROP TABLE IF EXISTS `changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedfields` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedfields_siteId_fk` (`siteId`),
  KEY `changedfields_fieldId_fk` (`fieldId`),
  KEY `changedfields_userId_fk` (`userId`),
  CONSTRAINT `changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
INSERT INTO `changedfields` VALUES (2,1,1,'2020-05-01 22:28:39',0,1),(2,1,2,'2020-05-01 22:28:39',0,1),(2,1,3,'2020-05-01 22:28:39',0,1),(2,1,4,'2020-05-01 22:28:39',0,1),(2,1,5,'2020-05-01 22:28:39',0,1),(2,1,6,'2020-05-02 17:23:06',0,1),(2,1,7,'2020-05-01 22:28:39',0,1),(2,1,8,'2020-05-01 22:28:39',0,1),(2,1,9,'2020-05-01 22:28:39',0,1),(2,1,10,'2020-05-02 17:06:08',0,1),(2,1,11,'2020-05-02 17:06:08',0,1),(2,1,12,'2020-05-02 17:06:08',0,1),(2,1,13,'2020-05-02 17:06:08',0,1);
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_mainTitle` text,
  `field_step1Title` text,
  `field_step1Details` text,
  `field_step2Title` text,
  `field_step2Details` text,
  `field_step3Title` text,
  `field_step3Details` text,
  `field_step4Title` text,
  `field_step4Details` text,
  `field_step1ImageUrl` text,
  `field_step2ImageUrl` text,
  `field_step3ImageUrl` text,
  `field_step4ImageUrl` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,1,1,NULL,'2020-05-01 21:41:12','2020-05-01 21:41:12','b53714af-dac4-4d9a-afb4-db77552a4f0f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,2,1,'Post','2020-05-01 21:54:23','2020-05-02 17:24:11','fc77d0cf-e08f-45f2-a6b7-96ffe63695db','Your AC repair in four easy steps','Schedule your repair','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Call (800) 555-5555.','Meet your technician','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Get your system working again','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Let us know how we did','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','https://picsum.photos/300/200?random=1','https://picsum.photos/300/200?random=2','https://picsum.photos/300/200?random=3','https://picsum.photos/300/200?random=4'),(3,3,1,'Post','2020-05-01 21:54:23','2020-05-01 21:54:23','fb8ee0ce-290e-420b-ab32-69545e9e472b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,4,1,'Post','2020-05-01 22:13:04','2020-05-01 22:13:04','d9ffdd59-be60-400b-ab94-3950e87c7d22',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,5,1,'Post','2020-05-01 22:25:26','2020-05-01 22:25:26','aa87f46e-178f-4c9d-b684-54ae1df8d656',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,6,1,'Post','2020-05-01 22:28:39','2020-05-01 22:28:39','2a9572a9-5026-47fe-919c-ce4f8605ba2f','Your AC repair in four easy steps','Schedule your repair','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Call (800) 555-5555.','Meet your technician','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Get your system working again','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Let us know how we did','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',NULL,NULL,NULL,NULL),(7,7,1,'Post','2020-05-02 17:05:26','2020-05-02 17:05:26','f9f76e1a-409b-40cf-b679-f6e55d4afbe3','Your AC repair in four easy steps','Schedule your repair','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Call (800) 555-5555.','Meet your technician','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Get your system working again','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Let us know how we did','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',NULL,NULL,NULL,NULL),(8,8,1,'Post','2020-05-02 17:06:08','2020-05-02 17:06:08','84ad61d0-4e6f-42d3-b54c-5e9456b321c7','Your AC repair in four easy steps','Schedule your repair','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Call (800) 555-5555.','Meet your technician','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Get your system working again','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Let us know how we did','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','https://picsum.photos/300/200','https://picsum.photos/300/200','https://picsum.photos/300/200','https://picsum.photos/300/200'),(10,10,1,'Post','2020-05-02 17:08:12','2020-05-02 17:08:12','68408623-9751-44ac-b80c-2fa5b2bee303','Your AC repair in four easy steps','Schedule your repair','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Call (800) 555-5555.','Meet your technician','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Get your system working again','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Let us know how we did','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','https://picsum.photos/300/200?random=1','https://picsum.photos/300/200?random=2','https://picsum.photos/300/200?random=3','https://picsum.photos/300/200?random=4'),(11,11,1,'Post','2020-05-02 17:09:43','2020-05-02 17:09:43','961bf02b-2bad-4fc7-9bb8-4bac5f2e1df9','Your AC repair in four easy steps','Schedule your repair','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Call (800) 555-5555.','Meet your technician','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Get your system working again','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Let us know how we did','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','https://picsum.photos/300/200?random=1','https://picsum.photos/300/200?random=2','https://picsum.photos/300/200?random=3','https://picsum.photos/300/200?random=4'),(12,12,1,'Post','2020-05-02 17:22:42','2020-05-02 17:22:42','7ee068be-2852-45f9-a451-0b672674d162','Your AC repair in four easy steps','Schedule your repair','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Call (800) 555-5555.','Meet your technician','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',NULL,'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Let us know how we did','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','https://picsum.photos/300/200?random=1','https://picsum.photos/300/200?random=2','https://picsum.photos/300/200?random=3','https://picsum.photos/300/200?random=4'),(13,13,1,'Post','2020-05-02 17:23:05','2020-05-02 17:23:05','320d97e5-0b76-45cb-8b8b-2372c4626548','Your AC repair in four easy steps','Schedule your repair','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Call (800) 555-5555.','Meet your technician','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Get your system working again','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Let us know how we did','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','https://picsum.photos/300/200?random=1','https://picsum.photos/300/200?random=2','https://picsum.photos/300/200?random=3','https://picsum.photos/300/200?random=4'),(14,14,1,'Post','2020-05-02 17:24:11','2020-05-02 17:24:11','902c039d-f9f9-4e79-aa60-ded1f6feaeb1','Your AC repair in four easy steps','Schedule your repair','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Call (800) 555-5555.','Meet your technician','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Get your system working again','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Let us know how we did','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','https://picsum.photos/300/200?random=1','https://picsum.photos/300/200?random=2','https://picsum.photos/300/200?random=3','https://picsum.photos/300/200?random=4');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_archived_dateDeleted_draftId_revisionId_idx` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-05-01 21:41:12','2020-05-01 21:41:12',NULL,'28349f49-1aee-400d-aaa3-890865c6f496'),(2,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2020-05-01 21:54:23','2020-05-02 17:24:11',NULL,'66db248e-6914-4793-831c-71c931044f94'),(3,NULL,1,NULL,'craft\\elements\\Entry',1,0,'2020-05-01 21:54:23','2020-05-01 21:54:23',NULL,'28d7e1b2-cc0a-488b-a4e4-63a1dcccc119'),(4,NULL,2,1,'craft\\elements\\Entry',1,0,'2020-05-01 22:13:04','2020-05-01 22:13:04',NULL,'a6225b94-8516-4cb4-98ca-25b50aab5503'),(5,NULL,3,1,'craft\\elements\\Entry',1,0,'2020-05-01 22:25:26','2020-05-01 22:25:26',NULL,'efb03ab3-bfa2-4215-9449-af2f929165fb'),(6,NULL,4,1,'craft\\elements\\Entry',1,0,'2020-05-01 22:28:39','2020-05-01 22:28:39',NULL,'04757675-1efe-4a4e-8d09-37f1ea357bad'),(7,NULL,5,1,'craft\\elements\\Entry',1,0,'2020-05-02 17:05:26','2020-05-02 17:05:26',NULL,'ecb55b93-9457-4688-9634-7985cf839f00'),(8,NULL,6,1,'craft\\elements\\Entry',1,0,'2020-05-02 17:06:08','2020-05-02 17:06:08',NULL,'05ce3359-c8bf-4ec1-9912-c2a1f8d7927a'),(10,NULL,7,1,'craft\\elements\\Entry',1,0,'2020-05-02 17:08:12','2020-05-02 17:08:12',NULL,'420ccdd3-aea9-45fb-b7f5-8b88c2f0c823'),(11,NULL,8,1,'craft\\elements\\Entry',1,0,'2020-05-02 17:09:43','2020-05-02 17:09:43',NULL,'d3510551-4f21-4c28-8d5e-31e6c4b1022a'),(12,NULL,9,1,'craft\\elements\\Entry',1,0,'2020-05-02 17:22:42','2020-05-02 17:22:42',NULL,'35bdd8b1-910b-4149-803d-0697bde46e2a'),(13,NULL,10,1,'craft\\elements\\Entry',1,0,'2020-05-02 17:23:05','2020-05-02 17:23:05',NULL,'b2b1bb2d-cde2-4ad9-af85-e1e5ff75b788'),(14,NULL,11,1,'craft\\elements\\Entry',1,0,'2020-05-02 17:24:11','2020-05-02 17:24:11',NULL,'a124b885-37c4-41c4-94f9-1ff9df13821b');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2020-05-01 21:41:12','2020-05-01 21:41:12','19b2e9c8-1916-47fb-bb67-fac24d70b6bd'),(2,2,1,'post','__home__',1,'2020-05-01 21:54:23','2020-05-01 21:54:23','6916c7f2-4ad6-4ddd-b8c6-7ab30c2cb4a9'),(3,3,1,'post','__home__',1,'2020-05-01 21:54:23','2020-05-01 21:54:23','a0995921-94af-4256-a0e2-75bc1277decb'),(4,4,1,'post','__home__',1,'2020-05-01 22:13:04','2020-05-01 22:13:04','331026a2-c9b5-43f5-8b89-1f093d53269c'),(5,5,1,'post','__home__',1,'2020-05-01 22:25:26','2020-05-01 22:25:26','a2dd258f-20ea-4e2b-adb2-a02a803a5147'),(6,6,1,'post','__home__',1,'2020-05-01 22:28:39','2020-05-01 22:28:39','40684b7b-8312-412f-b321-25a7976a809e'),(7,7,1,'post','__home__',1,'2020-05-02 17:05:26','2020-05-02 17:05:26','81a8e1c3-b936-4547-a4fa-50b2e7467ba5'),(8,8,1,'post','__home__',1,'2020-05-02 17:06:08','2020-05-02 17:06:08','40c10626-3b07-4328-b839-7bf8d1f9998e'),(10,10,1,'post','__home__',1,'2020-05-02 17:08:12','2020-05-02 17:08:12','9360a60b-1ef2-4d62-a2b6-b9c46324b5d2'),(11,11,1,'post','__home__',1,'2020-05-02 17:09:43','2020-05-02 17:09:43','c3dad22f-4fce-4039-add5-4474e3b126dc'),(12,12,1,'post','__home__',1,'2020-05-02 17:22:42','2020-05-02 17:22:42','da786f51-dee3-4166-b666-9ac126af124c'),(13,13,1,'post','__home__',1,'2020-05-02 17:23:05','2020-05-02 17:23:05','b7396ef3-4627-40f3-be5d-56e2021f565b'),(14,14,1,'post','__home__',1,'2020-05-02 17:24:11','2020-05-02 17:24:11','e97ba07d-81c2-4547-b677-7b2aa299d0ae');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
INSERT INTO `entries` VALUES (2,1,NULL,1,NULL,'2020-05-01 21:54:00',NULL,NULL,'2020-05-01 21:54:23','2020-05-01 21:54:23','f3def81a-1a70-4fa1-b487-8f173790fb8d'),(3,1,NULL,1,NULL,'2020-05-01 21:54:00',NULL,NULL,'2020-05-01 21:54:23','2020-05-01 21:54:23','23d43bac-fc4b-4ea7-9d8d-e17c85c97e27'),(4,1,NULL,1,NULL,'2020-05-01 21:54:00',NULL,NULL,'2020-05-01 22:13:04','2020-05-01 22:13:04','213b168a-abf6-4bef-8529-898e2b8fe49c'),(5,1,NULL,1,NULL,'2020-05-01 21:54:00',NULL,NULL,'2020-05-01 22:25:26','2020-05-01 22:25:26','ba344b99-818c-4649-9e56-4e4e9b91164d'),(6,1,NULL,1,NULL,'2020-05-01 21:54:00',NULL,NULL,'2020-05-01 22:28:39','2020-05-01 22:28:39','c2d08a1c-73bd-4473-97b0-fed920d375af'),(7,1,NULL,1,NULL,'2020-05-01 21:54:00',NULL,NULL,'2020-05-02 17:05:26','2020-05-02 17:05:26','a6bfc6f3-7f4e-4996-ad2d-329808998f2c'),(8,1,NULL,1,NULL,'2020-05-01 21:54:00',NULL,NULL,'2020-05-02 17:06:08','2020-05-02 17:06:08','9c082301-bf95-4ea0-a133-3e4453e0201a'),(10,1,NULL,1,NULL,'2020-05-01 21:54:00',NULL,NULL,'2020-05-02 17:08:12','2020-05-02 17:08:12','eb25ff2f-51e0-44bc-b7a4-41d848ee27be'),(11,1,NULL,1,NULL,'2020-05-01 21:54:00',NULL,NULL,'2020-05-02 17:09:43','2020-05-02 17:09:43','b0fef594-3f1f-4877-961a-411409f61794'),(12,1,NULL,1,NULL,'2020-05-01 21:54:00',NULL,NULL,'2020-05-02 17:22:42','2020-05-02 17:22:42','87cb885e-a68a-4f0d-a0f9-683a7b842dcf'),(13,1,NULL,1,NULL,'2020-05-01 21:54:00',NULL,NULL,'2020-05-02 17:23:05','2020-05-02 17:23:05','a5101779-3f4f-499b-8298-68781a2485fe'),(14,1,NULL,1,NULL,'2020-05-01 21:54:00',NULL,NULL,'2020-05-02 17:24:11','2020-05-02 17:24:11','76ee7d1b-e415-431b-99bc-1627b94cc142');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
INSERT INTO `entrytypes` VALUES (1,1,1,'Post','post',0,'','{section.name|raw}',1,'2020-05-01 21:54:22','2020-05-01 22:13:04',NULL,'1eaf83cf-82f1-462d-8fb0-193c9d361cca');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
INSERT INTO `fieldgroups` VALUES (1,'Common','2020-05-01 21:41:11','2020-05-01 21:41:11','c7229376-f033-4781-8c80-2ac92bd923c2'),(2,'Steps','2020-05-01 21:54:53','2020-05-01 21:54:53','52985cde-77d3-49e9-b8c3-8628afd5d8ae');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
INSERT INTO `fieldlayoutfields` VALUES (36,1,4,6,0,9,'2020-05-02 17:24:11','2020-05-02 17:24:11','0064ee3e-63ab-4ba4-b23a-a60994396290'),(37,1,4,9,0,13,'2020-05-02 17:24:11','2020-05-02 17:24:11','ee676e23-af2b-4008-ad35-9928038c2115'),(38,1,4,13,0,11,'2020-05-02 17:24:11','2020-05-02 17:24:11','41b54a09-571f-4b7e-9293-1d1161b51d85'),(39,1,4,10,1,2,'2020-05-02 17:24:11','2020-05-02 17:24:11','7078e866-e58a-4ff2-a0ed-4f254f08d631'),(40,1,4,4,0,6,'2020-05-02 17:24:11','2020-05-02 17:24:11','8e0bbaa2-d12a-465c-bdbc-6cc4c945c722'),(41,1,4,3,1,4,'2020-05-02 17:24:11','2020-05-02 17:24:11','01bb8167-0b61-440b-b12b-67271029660a'),(42,1,4,2,1,3,'2020-05-02 17:24:11','2020-05-02 17:24:11','b57ea032-441d-4bd7-b38f-899847e1776b'),(43,1,4,1,1,1,'2020-05-02 17:24:11','2020-05-02 17:24:11','ea4ae2f5-31da-42a2-810b-4e9f98f422f1'),(44,1,4,5,0,7,'2020-05-02 17:24:11','2020-05-02 17:24:11','1ab708ea-33f8-43f6-863a-f4f5f1d81079'),(45,1,4,12,0,8,'2020-05-02 17:24:11','2020-05-02 17:24:11','1c47def0-1e42-4cd5-98f5-38c58a8556b5'),(46,1,4,7,0,10,'2020-05-02 17:24:11','2020-05-02 17:24:11','8facfc6c-4412-4bf0-a038-3ad6ccd5a61d'),(47,1,4,11,0,5,'2020-05-02 17:24:11','2020-05-02 17:24:11','9a400bc6-507f-4051-a3a8-b94f3dbcc972'),(48,1,4,8,0,12,'2020-05-02 17:24:11','2020-05-02 17:24:11','c504a2ef-6499-4fcb-ae83-e1439e8910dc');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\Entry','2020-05-01 22:13:04','2020-05-01 22:13:04',NULL,'650a7405-4948-4d96-bfdc-b120afaf43d4');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
INSERT INTO `fieldlayouttabs` VALUES (4,1,'Content',1,'2020-05-02 17:24:11','2020-05-02 17:24:11','e64a98a6-5d2f-4cc5-93c1-0a5d4dce4818');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
INSERT INTO `fields` VALUES (1,2,'Main Title','mainTitle','global','Enter the post title',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-05-01 21:55:43','2020-05-01 21:55:43','b4d06d1b-e4b0-46d6-a422-0bcc04b0feac'),(2,2,'Step 1 Title','step1Title','global','Enter the title/header for step #1',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-05-01 21:56:35','2020-05-01 21:56:35','a0c35f96-dc0a-4856-a561-26676dd9f225'),(3,2,'Step 1 Details','step1Details','global','Enter text/copy for step #1',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-05-01 21:57:39','2020-05-01 21:57:39','429833a5-2bd6-4335-b5c8-67ae94413dce'),(4,2,'Step 2 Title','step2Title','global','Enter header/title for step #2',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-05-01 22:00:09','2020-05-01 22:00:09','26dbd475-68b7-44ab-ae25-f79736434f25'),(5,2,'Step 2 Details','step2Details','global','Enter text/copy for step #2',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-05-01 22:00:40','2020-05-01 22:00:40','b8395cf5-5cc5-45be-9314-5d011c0b8678'),(6,2,'Step 3 Title','step3Title','global','Enter header/title for step #3',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-05-01 22:01:23','2020-05-01 22:01:23','0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d'),(7,2,'Step 3 Details','step3Details','global','Enter text/copy for step #3',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-05-01 22:02:05','2020-05-01 22:02:05','c6bb93e4-827a-4fc1-bc2f-0c74d146ad70'),(8,2,'Step 4 Title','step4Title','global','Enter header/title for step #3',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-05-01 22:02:28','2020-05-01 22:02:28','fd491dc0-cd31-4df7-87ca-f223d9c6dbc5'),(9,2,'Step 4 Details','step4Details','global','Enter text/copy for step #4',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-05-01 22:02:52','2020-05-01 22:11:35','1a8f9fec-d772-42bf-89a8-6a1006c7eedc'),(10,2,'Step 1 Image URL','step1ImageUrl','global','Enter the URL of the image for step #1',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"https://picsum.photos/300/200\"}','2020-05-02 17:01:16','2020-05-02 17:01:30','210afeea-b771-40f5-b7cd-341d0dc65c33'),(11,2,'Step 2 Image URL','step2ImageUrl','global','Enter the URL of the image for step #2',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"https://picsum.photos/300/200\"}','2020-05-02 17:02:13','2020-05-02 17:02:13','ceb828a2-ebf2-4e1e-956a-e1bffb675977'),(12,2,'Step 3 Image URL','step3ImageUrl','global','Enter the URL of the image for step #3',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"https://picsum.photos/300/200\"}','2020-05-02 17:02:47','2020-05-02 17:02:47','bc7365a1-44fb-4c7e-85b4-8975746849d1'),(13,2,'Step 4 Image URL','step4ImageUrl','global','Enter the URL of the image for step #4',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"https://picsum.photos/300/200\"}','2020-05-02 17:03:22','2020-05-02 17:03:22','1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gqltokens`
--

DROP TABLE IF EXISTS `gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gqltokens_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `gqltokens_name_unq_idx` (`name`),
  KEY `gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gqltokens`
--

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
INSERT INTO `info` VALUES (1,'3.4.11','3.4.10',0,'[]','zI3JnxbJFrK4','2020-05-01 21:41:11','2020-05-02 17:03:22','18529335-dce4-4416-8879-262540bf9edd');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','25bbb19c-958a-48a4-bc28-cd6cbe1bffc3'),(2,NULL,'app','m150403_183908_migrations_table_changes','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','844635fb-bfdd-43f7-b0c3-b244e3bbb2d6'),(3,NULL,'app','m150403_184247_plugins_table_changes','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','8c164005-6abb-4aa0-bfbf-e0031f8fbc9b'),(4,NULL,'app','m150403_184533_field_version','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','8fc2890c-feac-4526-8f28-1d5740d1661f'),(5,NULL,'app','m150403_184729_type_columns','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','319659ba-db1f-40fe-ae55-88a9782fdc37'),(6,NULL,'app','m150403_185142_volumes','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','12062987-7798-4d9f-b09f-ba2853038662'),(7,NULL,'app','m150428_231346_userpreferences','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','4a41d0f2-4a80-4290-a4f2-5e4b94091b00'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','f358b14d-df45-4a08-9f95-c122451a89f5'),(9,NULL,'app','m150617_213829_update_email_settings','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','6e220430-b53b-4ebd-ae30-e50bca6c6842'),(10,NULL,'app','m150721_124739_templatecachequeries','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','a9b9492d-9b79-4cd8-acee-b1493133f377'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','ffa6c0eb-269b-4f81-94b6-50b4272c918d'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','dc5cd070-800f-4cca-9fcf-a9f57a8c65a4'),(13,NULL,'app','m151002_095935_volume_cache_settings','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','39e2b62d-adac-49f8-9381-c93ec61a169d'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','8e4dbd3e-9b12-4216-b9df-ee5385ac1070'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','e34b5fda-2ee5-481a-a90c-dde27a25e3a6'),(16,NULL,'app','m151209_000000_move_logo','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','c6d626ee-81da-45b7-889f-4738367e1f6a'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','825f3e11-8672-473a-b991-7c9e69d38c3e'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','7a7d6612-d008-47b2-98a3-deac1263548c'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','9930b2ee-63cf-4348-a27a-5cd1b5fe6eab'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','5de8adae-30b3-42b6-ad42-9bc3b2c2735e'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','1d415ab4-5105-4bb8-9b1e-f9af85567c6e'),(22,NULL,'app','m160727_194637_column_cleanup','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','ef3ca5e0-ea27-4401-9544-36088c888a7c'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','8c5f071f-95ef-4323-9e4e-18fd432dd898'),(24,NULL,'app','m160807_144858_sites','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','8b888524-a129-4dad-9907-cddde91a16ec'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','dcf54ded-ce26-47f2-8c2c-ed1496266499'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','2c037bc9-68e9-4c90-8422-b50e43b46104'),(27,NULL,'app','m160912_230520_require_entry_type_id','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','413d7190-f5aa-4795-bd97-67644b4b8437'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','f6d1e7e3-c6d8-41ba-a539-eabaa08edc77'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','445d68ed-0be7-44ee-bac3-216001dd8973'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','fac7f182-a417-4645-ab74-16a443c3d9a8'),(31,NULL,'app','m160925_113941_route_uri_parts','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','ecc48e83-e8f8-4c39-9980-d52dfaa31625'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','c0f3ac76-631f-40a6-9432-95df6d5dd021'),(33,NULL,'app','m161007_130653_update_email_settings','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','ccf3f694-032d-47f6-a9af-2894f44ee3c2'),(34,NULL,'app','m161013_175052_newParentId','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','30ddf41e-87b9-4898-a159-7ccef2e714b4'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','5494de54-a2bf-470b-9d18-93cf2edd357c'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','49f936fe-8483-4e75-9f09-e04d5fc98884'),(37,NULL,'app','m161025_000000_fix_char_columns','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','fb43abbc-3f51-4066-b34a-6bc3c51bd676'),(38,NULL,'app','m161029_124145_email_message_languages','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','0408fc90-f710-4501-82fd-dd421f80b7db'),(39,NULL,'app','m161108_000000_new_version_format','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','e4351ba2-6148-407f-8e87-e604faf9686c'),(40,NULL,'app','m161109_000000_index_shuffle','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','26797950-1d9b-4eca-8bdc-8da07a4df536'),(41,NULL,'app','m161122_185500_no_craft_app','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','ae0541cb-641a-41cc-a986-ad5517ca5a88'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','2cb64d53-b120-4237-9482-2bc142db602d'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','b25c3998-35db-49dd-884c-ddec7584cb04'),(44,NULL,'app','m170114_161144_udates_permission','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','ed1929d5-2ee9-4b0f-a0d1-b6c29de48a4c'),(45,NULL,'app','m170120_000000_schema_cleanup','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','1fd7a6b2-0974-405f-b832-494a887a2dbc'),(46,NULL,'app','m170126_000000_assets_focal_point','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','ed3f9368-4733-4b03-aa96-0b82fc6af6ca'),(47,NULL,'app','m170206_142126_system_name','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','e5067d5f-4bdf-4fdd-be76-839ba9cac4bd'),(48,NULL,'app','m170217_044740_category_branch_limits','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','081891a7-b4e8-43c2-b484-4069ffdb156f'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','02ebb951-cd98-4d40-b211-ab58dbdad111'),(50,NULL,'app','m170223_224012_plain_text_settings','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','6edb633a-751d-46b0-9fa1-5dbb5ac5850c'),(51,NULL,'app','m170227_120814_focal_point_percentage','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','6d334688-0c3b-496a-bb6d-1c6d3e7c712e'),(52,NULL,'app','m170228_171113_system_messages','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','78a3c045-7eed-4d10-9993-a736a4a26b0e'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','3fd6715c-10d2-4bad-b6c9-b951f173014f'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','293b3358-c22d-4aab-83f3-68a0f8ee71d9'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','c103d1ef-ba24-4cdd-ba86-1f0adbb7c2dd'),(56,NULL,'app','m170612_000000_route_index_shuffle','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','a215c960-beca-4084-ab36-84984b5d9c01'),(57,NULL,'app','m170621_195237_format_plugin_handles','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','78d2d316-a955-40c2-b290-fc57d3690b00'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','9e7bdbf7-3bf1-40b9-9d5d-eb2c6969e8ef'),(59,NULL,'app','m170630_161028_deprecation_changes','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','4ccab058-d85b-4490-80cb-55430c9cfbd2'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','0c4d0e8a-9f5c-4d89-95b6-ed5fe9846243'),(61,NULL,'app','m170704_134916_sites_tables','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','8f0e452c-4654-4aca-9696-fe02cf68eed8'),(62,NULL,'app','m170706_183216_rename_sequences','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','2cfff1ca-1747-4933-9313-c8ee1126edc3'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','5120d1ab-e6d6-4bac-81fa-1bb977228483'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','244eba6d-02df-4a8c-8f8c-bf10b732c096'),(65,NULL,'app','m170810_201318_create_queue_table','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','a6fa96ce-85fb-4948-97ce-d8c3a3e7f001'),(66,NULL,'app','m170903_192801_longblob_for_queue_jobs','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','0608af2d-57ed-4de6-9154-4aeec0a16352'),(67,NULL,'app','m170914_204621_asset_cache_shuffle','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','3dd2ccb5-5f86-40c1-8307-72590abcc82d'),(68,NULL,'app','m171011_214115_site_groups','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','04009af8-623e-4b02-8f3e-a300cab203c6'),(69,NULL,'app','m171012_151440_primary_site','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','07b35652-c055-4ec0-a7e9-c643149b2118'),(70,NULL,'app','m171013_142500_transform_interlace','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','f306292f-d76f-42f1-9b55-725a4f733192'),(71,NULL,'app','m171016_092553_drop_position_select','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','d30be868-07f2-4383-9135-0f274c144915'),(72,NULL,'app','m171016_221244_less_strict_translation_method','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','29d8b4a1-ac8d-4150-84ff-78ae4bae57c2'),(73,NULL,'app','m171107_000000_assign_group_permissions','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','139401f9-d842-42bc-88ca-74d85e7e43b0'),(74,NULL,'app','m171117_000001_templatecache_index_tune','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','80766445-049c-4d80-a63a-e0c0ece647a9'),(75,NULL,'app','m171126_105927_disabled_plugins','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','ce3f7203-1d5e-476d-a044-b8e432a578c8'),(76,NULL,'app','m171130_214407_craftidtokens_table','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','42846107-4782-4836-baac-9e1652aacb8f'),(77,NULL,'app','m171202_004225_update_email_settings','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','f36ae837-79e9-462c-a789-f650d4610bc8'),(78,NULL,'app','m171204_000001_templatecache_index_tune_deux','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','c6f4c796-e27b-45a1-b38d-d8b08241e69a'),(79,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','7c25c69f-a464-44dc-b3c4-b56eeda1bc04'),(80,NULL,'app','m171218_143135_longtext_query_column','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','6b493338-1d73-499e-b879-27d62c3c1b11'),(81,NULL,'app','m171231_055546_environment_variables_to_aliases','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','54c6698b-fb7e-4072-9292-2bec81808b73'),(82,NULL,'app','m180113_153740_drop_users_archived_column','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','1548e6c1-289e-4d01-b69a-73cdfbe6af96'),(83,NULL,'app','m180122_213433_propagate_entries_setting','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','d5c9291e-f847-4e77-a63a-c41d55b10616'),(84,NULL,'app','m180124_230459_fix_propagate_entries_values','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','5233a8a5-8e9f-48be-a294-2e91a7eebf79'),(85,NULL,'app','m180128_235202_set_tag_slugs','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','922be334-106c-4494-8874-390f19162d8a'),(86,NULL,'app','m180202_185551_fix_focal_points','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','9634334f-6be5-448c-b3dc-62eec3d7c5f5'),(87,NULL,'app','m180217_172123_tiny_ints','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','79fd0023-1cd3-4ea2-8199-a05bbf87f6bb'),(88,NULL,'app','m180321_233505_small_ints','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','78d67e69-8110-46e9-8647-f9ea17bf53ad'),(89,NULL,'app','m180328_115523_new_license_key_statuses','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','47541d3d-e2a9-4c78-af1d-3d90280f1e82'),(90,NULL,'app','m180404_182320_edition_changes','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','0304b1d2-6795-474a-8ced-aedeb0e94d0d'),(91,NULL,'app','m180411_102218_fix_db_routes','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','67a0fb2b-450b-4ba2-bbe4-257d4398f57f'),(92,NULL,'app','m180416_205628_resourcepaths_table','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','3f1dc730-5caf-4e36-aba8-35526a71b4a1'),(93,NULL,'app','m180418_205713_widget_cleanup','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','40a814a8-e739-4cb2-b31d-b334f27c27fa'),(94,NULL,'app','m180425_203349_searchable_fields','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','1df3abe4-39be-4c81-a3e5-b63f8c262cb8'),(95,NULL,'app','m180516_153000_uids_in_field_settings','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','bd67aade-f888-4144-be4d-eb57cf8fcb04'),(96,NULL,'app','m180517_173000_user_photo_volume_to_uid','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','75582b68-bf13-4645-9fce-0eb92be6819b'),(97,NULL,'app','m180518_173000_permissions_to_uid','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','072af858-f39c-4d7e-a1d5-90b9d542f20a'),(98,NULL,'app','m180520_173000_matrix_context_to_uids','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','a01f30ff-15e5-4933-a58f-2be944135e61'),(99,NULL,'app','m180521_172900_project_config_table','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','3921e4d0-24bc-4612-84c7-72bd5be605b6'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','dd0f7b1f-f467-44c0-a29f-a19bd0058b71'),(101,NULL,'app','m180731_162030_soft_delete_sites','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','bca7b940-971d-4d42-95af-8bc5dbe00410'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','ecf6f4ca-26f4-4b75-b25d-9c0c0ff2fb04'),(103,NULL,'app','m180810_214439_soft_delete_elements','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','3ee0a216-4812-4e39-97c5-69c951c26b5d'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','67892080-2459-4637-8d7c-9391655b2a24'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','1cbce4e4-23b5-4e16-bd11-09ef28edac54'),(106,NULL,'app','m180904_112109_permission_changes','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','7107f893-3160-483c-9dce-f4d558e46952'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','7a934c09-3fcf-48d0-ae54-f72d519a3cd9'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','2b284ca9-de9c-4a75-b3ed-3aa2d62ecd90'),(109,NULL,'app','m181016_183648_set_default_user_settings','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','eb0587f6-c41d-4aaa-add3-56f13878d92f'),(110,NULL,'app','m181017_225222_system_config_settings','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','95fc3b4a-74d2-4d3f-81d2-c18d260b8085'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','84bd1864-9c3a-428b-8e99-c1fd03761492'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','1493ee72-72e2-417c-be02-74c2e59a3ae0'),(113,NULL,'app','m181112_203955_sequences_table','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','455b6d39-ca3c-4f3b-a62f-3c8de5de9dff'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','c9b2abe5-d931-4ac2-be27-cf28a23f5753'),(115,NULL,'app','m181128_193942_fix_project_config','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','870df10e-8f04-4c8b-8c39-7c5d9bda46d9'),(116,NULL,'app','m181130_143040_fix_schema_version','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','3e10372e-ef53-49e0-bccf-b3220c5dfc18'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','46fff8bb-c516-401a-9531-ce1ad5aea1ec'),(118,NULL,'app','m181213_102500_config_map_aliases','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','32bcfec2-8cc4-4df8-991c-3588ddb1740e'),(119,NULL,'app','m181217_153000_fix_structure_uids','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','3ebef54a-c14f-4cb1-bd33-c866344fa040'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','02f2ceae-67e2-4826-80e5-d97d287d8000'),(121,NULL,'app','m190108_110000_cleanup_project_config','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','56faa744-3051-417a-8183-e94baafe5392'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','b8c1c9b8-048f-4cb5-9bde-ff668cf21a19'),(123,NULL,'app','m190109_172845_fix_colspan','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','06efcd70-856a-481c-8892-9987cebf716d'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','34b37967-7098-4616-8591-8050d228e283'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','e2a5e9b2-68c1-46aa-a6a6-83ccdc1d017f'),(126,NULL,'app','m190112_124737_fix_user_settings','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','d361d23e-0d60-44b3-a4c6-e65135765ad1'),(127,NULL,'app','m190112_131225_fix_field_layouts','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','b1365391-8966-4759-8742-ee36355c0e42'),(128,NULL,'app','m190112_201010_more_soft_deletes','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','883e1142-53d5-4f81-949d-fc278576ddf0'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','9cc80b7e-83e6-4176-ad73-e73b3347162c'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','4b94f97c-07eb-408d-80e9-90ba73ada58d'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','1376d8ca-b62c-4365-8038-ca06fd4da321'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','809decb3-d105-4056-b309-daf78ba91778'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','efa4bbe5-c6d6-455e-ab00-94566a19a87c'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','9e3d5290-2dd6-44cd-b3a5-51aa52b58fec'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','dc82d7aa-5681-4418-beeb-635e4eb90447'),(136,NULL,'app','m190312_152740_element_revisions','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','09b6b3b3-5c0e-48e9-bdfb-a282b4636f55'),(137,NULL,'app','m190327_235137_propagation_method','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','7f48f174-b474-441a-87c0-86d551f5a2af'),(138,NULL,'app','m190401_223843_drop_old_indexes','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','0bf868a0-b12c-4da4-a442-c6bb2e54b110'),(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','33b56578-c29d-4d6c-9d37-92b723b789be'),(140,NULL,'app','m190417_085010_add_image_editor_permissions','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','3f87ac4b-d74e-4478-ad16-5cace0390051'),(141,NULL,'app','m190502_122019_store_default_user_group_uid','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','a804e9c3-b40d-48aa-a0c9-0207782879be'),(142,NULL,'app','m190504_150349_preview_targets','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','567e4315-6d39-41ab-ae7a-3f5d8b5c28fc'),(143,NULL,'app','m190516_184711_job_progress_label','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','4e3a3c5b-2ebe-4926-aaec-c56786f87479'),(144,NULL,'app','m190523_190303_optional_revision_creators','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','23b2bff6-c3e3-4e92-9149-88d4e0b53e48'),(145,NULL,'app','m190529_204501_fix_duplicate_uids','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','92341866-dd14-4b03-babf-7188a2224c49'),(146,NULL,'app','m190605_223807_unsaved_drafts','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','9b9c6c17-69c8-4249-9e3d-2ce4c28a2038'),(147,NULL,'app','m190607_230042_entry_revision_error_tables','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','2e260559-bc15-43c1-9367-09e8c2bec11f'),(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','dbc71352-844e-467e-9b6b-29283385ebd9'),(149,NULL,'app','m190617_164400_add_gqlschemas_table','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','d2e35db7-d25e-423f-8596-f2a00ca96793'),(150,NULL,'app','m190624_234204_matrix_propagation_method','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','8842ec6b-1078-4132-af16-d540062a1eed'),(151,NULL,'app','m190711_153020_drop_snapshots','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','91bd198f-5468-4a4c-8758-ab35da41b1cf'),(152,NULL,'app','m190712_195914_no_draft_revisions','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','945205b3-e25c-4b5e-a146-2289125ac1b2'),(153,NULL,'app','m190723_140314_fix_preview_targets_column','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','29cbf1ef-4efd-41b0-9857-27410900a0ca'),(154,NULL,'app','m190820_003519_flush_compiled_templates','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','bcdd6633-e66f-4768-a718-716378a15b0d'),(155,NULL,'app','m190823_020339_optional_draft_creators','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','7ad36702-a745-4558-8386-e56e1a4f3cab'),(156,NULL,'app','m190913_152146_update_preview_targets','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','f00e3e65-d155-4610-b65d-fe1b87728e4b'),(157,NULL,'app','m191107_122000_add_gql_project_config_support','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','c82dbf3d-12db-473c-9306-c47f64670f2c'),(158,NULL,'app','m191204_085100_pack_savable_component_settings','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','1ace8495-c17b-4804-b99f-8cf7aee59ded'),(159,NULL,'app','m191206_001148_change_tracking','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','71963d6a-2530-460e-b22f-e7d3e0bb8f70'),(160,NULL,'app','m191216_191635_asset_upload_tracking','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','aef502db-632e-4320-a568-01a5344d8501'),(161,NULL,'app','m191222_002848_peer_asset_permissions','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','372338e9-7b7a-4cee-96f8-985963d0d629'),(162,NULL,'app','m200127_172522_queue_channels','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','de44522e-b9b4-40c1-a5fe-f24f7e541961'),(163,NULL,'app','m200211_175048_truncate_element_query_cache','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','4598407f-dcf7-44da-9dd1-c28d0218e001'),(164,NULL,'app','m200213_172522_new_elements_index','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','28c7bca8-8113-48e0-97d4-09b5ee35f706'),(165,NULL,'app','m200228_195211_long_deprecation_messages','2020-05-01 21:41:13','2020-05-01 21:41:13','2020-05-01 21:41:13','34e646b1-428a-4351-8020-7235dc8788cf');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectconfig`
--

DROP TABLE IF EXISTS `projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
INSERT INTO `projectconfig` VALUES ('dateModified','1588440251'),('email.fromEmail','\"thanneman1@gmail.com\"'),('email.fromName','\"Server\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('fieldGroups.52985cde-77d3-49e9-b8c3-8628afd5d8ae.name','\"Steps\"'),('fieldGroups.c7229376-f033-4781-8c80-2ac92bd923c2.name','\"Common\"'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.contentColumnType','\"text\"'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.fieldGroup','\"52985cde-77d3-49e9-b8c3-8628afd5d8ae\"'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.handle','\"step3Title\"'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.instructions','\"Enter header/title for step #3\"'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.name','\"Step 3 Title\"'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.searchable','true'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.settings.byteLimit','null'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.settings.charLimit','null'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.settings.code','\"\"'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.settings.columnType','null'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.settings.initialRows','\"4\"'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.settings.multiline','\"\"'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.settings.placeholder','\"\"'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.translationKeyFormat','null'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.translationMethod','\"none\"'),('fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.type','\"craft\\\\fields\\\\PlainText\"'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.contentColumnType','\"text\"'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.fieldGroup','\"52985cde-77d3-49e9-b8c3-8628afd5d8ae\"'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.handle','\"step4Details\"'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.instructions','\"Enter text/copy for step #4\"'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.name','\"Step 4 Details\"'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.searchable','true'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.settings.byteLimit','null'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.settings.charLimit','null'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.settings.code','\"\"'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.settings.columnType','null'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.settings.initialRows','\"4\"'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.settings.multiline','\"\"'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.settings.placeholder','\"\"'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.translationKeyFormat','null'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.translationMethod','\"none\"'),('fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.type','\"craft\\\\fields\\\\PlainText\"'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.contentColumnType','\"text\"'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.fieldGroup','\"52985cde-77d3-49e9-b8c3-8628afd5d8ae\"'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.handle','\"step4ImageUrl\"'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.instructions','\"Enter the URL of the image for step #4\"'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.name','\"Step 4 Image URL\"'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.searchable','true'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.settings.byteLimit','null'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.settings.charLimit','null'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.settings.code','\"\"'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.settings.columnType','null'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.settings.initialRows','\"4\"'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.settings.multiline','\"\"'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.settings.placeholder','\"https://picsum.photos/300/200\"'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.translationKeyFormat','null'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.translationMethod','\"none\"'),('fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.type','\"craft\\\\fields\\\\PlainText\"'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.contentColumnType','\"text\"'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.fieldGroup','\"52985cde-77d3-49e9-b8c3-8628afd5d8ae\"'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.handle','\"step1ImageUrl\"'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.instructions','\"Enter the URL of the image for step #1\"'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.name','\"Step 1 Image URL\"'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.searchable','true'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.settings.byteLimit','null'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.settings.charLimit','null'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.settings.code','\"\"'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.settings.columnType','null'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.settings.initialRows','\"4\"'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.settings.multiline','\"\"'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.settings.placeholder','\"https://picsum.photos/300/200\"'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.translationKeyFormat','null'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.translationMethod','\"none\"'),('fields.210afeea-b771-40f5-b7cd-341d0dc65c33.type','\"craft\\\\fields\\\\PlainText\"'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.contentColumnType','\"text\"'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.fieldGroup','\"52985cde-77d3-49e9-b8c3-8628afd5d8ae\"'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.handle','\"step2Title\"'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.instructions','\"Enter header/title for step #2\"'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.name','\"Step 2 Title\"'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.searchable','true'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.settings.byteLimit','null'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.settings.charLimit','null'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.settings.code','\"\"'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.settings.columnType','null'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.settings.initialRows','\"4\"'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.settings.multiline','\"\"'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.settings.placeholder','\"\"'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.translationKeyFormat','null'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.translationMethod','\"none\"'),('fields.26dbd475-68b7-44ab-ae25-f79736434f25.type','\"craft\\\\fields\\\\PlainText\"'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.contentColumnType','\"text\"'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.fieldGroup','\"52985cde-77d3-49e9-b8c3-8628afd5d8ae\"'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.handle','\"step1Details\"'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.instructions','\"Enter text/copy for step #1\"'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.name','\"Step 1 Details\"'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.searchable','true'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.settings.byteLimit','null'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.settings.charLimit','null'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.settings.code','\"\"'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.settings.columnType','null'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.settings.initialRows','\"4\"'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.settings.multiline','\"\"'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.settings.placeholder','\"\"'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.translationKeyFormat','null'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.translationMethod','\"none\"'),('fields.429833a5-2bd6-4335-b5c8-67ae94413dce.type','\"craft\\\\fields\\\\PlainText\"'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.contentColumnType','\"text\"'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.fieldGroup','\"52985cde-77d3-49e9-b8c3-8628afd5d8ae\"'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.handle','\"step1Title\"'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.instructions','\"Enter the title/header for step #1\"'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.name','\"Step 1 Title\"'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.searchable','true'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.settings.byteLimit','null'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.settings.charLimit','null'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.settings.code','\"\"'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.settings.columnType','null'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.settings.initialRows','\"4\"'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.settings.multiline','\"\"'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.settings.placeholder','\"\"'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.translationKeyFormat','null'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.translationMethod','\"none\"'),('fields.a0c35f96-dc0a-4856-a561-26676dd9f225.type','\"craft\\\\fields\\\\PlainText\"'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.contentColumnType','\"text\"'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.fieldGroup','\"52985cde-77d3-49e9-b8c3-8628afd5d8ae\"'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.handle','\"mainTitle\"'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.instructions','\"Enter the post title\"'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.name','\"Main Title\"'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.searchable','true'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.settings.byteLimit','null'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.settings.charLimit','null'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.settings.code','\"\"'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.settings.columnType','null'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.settings.initialRows','\"4\"'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.settings.multiline','\"\"'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.settings.placeholder','\"\"'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.translationKeyFormat','null'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.translationMethod','\"none\"'),('fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.type','\"craft\\\\fields\\\\PlainText\"'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.contentColumnType','\"text\"'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.fieldGroup','\"52985cde-77d3-49e9-b8c3-8628afd5d8ae\"'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.handle','\"step2Details\"'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.instructions','\"Enter text/copy for step #2\"'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.name','\"Step 2 Details\"'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.searchable','true'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.settings.byteLimit','null'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.settings.charLimit','null'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.settings.code','\"\"'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.settings.columnType','null'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.settings.initialRows','\"4\"'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.settings.multiline','\"\"'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.settings.placeholder','\"\"'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.translationKeyFormat','null'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.translationMethod','\"none\"'),('fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.type','\"craft\\\\fields\\\\PlainText\"'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.contentColumnType','\"text\"'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.fieldGroup','\"52985cde-77d3-49e9-b8c3-8628afd5d8ae\"'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.handle','\"step3ImageUrl\"'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.instructions','\"Enter the URL of the image for step #3\"'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.name','\"Step 3 Image URL\"'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.searchable','true'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.settings.byteLimit','null'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.settings.charLimit','null'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.settings.code','\"\"'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.settings.columnType','null'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.settings.initialRows','\"4\"'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.settings.multiline','\"\"'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.settings.placeholder','\"https://picsum.photos/300/200\"'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.translationKeyFormat','null'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.translationMethod','\"none\"'),('fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.type','\"craft\\\\fields\\\\PlainText\"'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.contentColumnType','\"text\"'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.fieldGroup','\"52985cde-77d3-49e9-b8c3-8628afd5d8ae\"'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.handle','\"step3Details\"'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.instructions','\"Enter text/copy for step #3\"'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.name','\"Step 3 Details\"'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.searchable','true'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.settings.byteLimit','null'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.settings.charLimit','null'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.settings.code','\"\"'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.settings.columnType','null'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.settings.initialRows','\"4\"'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.settings.multiline','\"\"'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.settings.placeholder','\"\"'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.translationKeyFormat','null'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.translationMethod','\"none\"'),('fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.type','\"craft\\\\fields\\\\PlainText\"'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.contentColumnType','\"text\"'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.fieldGroup','\"52985cde-77d3-49e9-b8c3-8628afd5d8ae\"'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.handle','\"step2ImageUrl\"'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.instructions','\"Enter the URL of the image for step #2\"'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.name','\"Step 2 Image URL\"'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.searchable','true'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.settings.byteLimit','null'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.settings.charLimit','null'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.settings.code','\"\"'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.settings.columnType','null'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.settings.initialRows','\"4\"'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.settings.multiline','\"\"'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.settings.placeholder','\"https://picsum.photos/300/200\"'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.translationKeyFormat','null'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.translationMethod','\"none\"'),('fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.type','\"craft\\\\fields\\\\PlainText\"'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.contentColumnType','\"text\"'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.fieldGroup','\"52985cde-77d3-49e9-b8c3-8628afd5d8ae\"'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.handle','\"step4Title\"'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.instructions','\"Enter header/title for step #3\"'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.name','\"Step 4 Title\"'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.searchable','true'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.settings.byteLimit','null'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.settings.charLimit','null'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.settings.code','\"\"'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.settings.columnType','null'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.settings.initialRows','\"4\"'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.settings.multiline','\"\"'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.settings.placeholder','\"\"'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.translationKeyFormat','null'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.translationMethod','\"none\"'),('fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.type','\"craft\\\\fields\\\\PlainText\"'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.enableVersioning','true'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.required','false'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.0de8cbeb-1e2c-46b7-83f9-b7d0ed6e689d.sortOrder','9'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.required','false'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.1a8f9fec-d772-42bf-89a8-6a1006c7eedc.sortOrder','13'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.required','false'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.1e4e8c75-f81c-49a4-bec8-7da8b1bc2f5d.sortOrder','11'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.210afeea-b771-40f5-b7cd-341d0dc65c33.required','true'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.210afeea-b771-40f5-b7cd-341d0dc65c33.sortOrder','2'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.26dbd475-68b7-44ab-ae25-f79736434f25.required','false'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.26dbd475-68b7-44ab-ae25-f79736434f25.sortOrder','6'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.429833a5-2bd6-4335-b5c8-67ae94413dce.required','true'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.429833a5-2bd6-4335-b5c8-67ae94413dce.sortOrder','4'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.a0c35f96-dc0a-4856-a561-26676dd9f225.required','true'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.a0c35f96-dc0a-4856-a561-26676dd9f225.sortOrder','3'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.required','true'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.b4d06d1b-e4b0-46d6-a422-0bcc04b0feac.sortOrder','1'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.required','false'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.b8395cf5-5cc5-45be-9314-5d011c0b8678.sortOrder','7'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.required','false'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.bc7365a1-44fb-4c7e-85b4-8975746849d1.sortOrder','8'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.required','false'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.c6bb93e4-827a-4fc1-bc2f-0c74d146ad70.sortOrder','10'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.required','false'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.ceb828a2-ebf2-4e1e-956a-e1bffb675977.sortOrder','5'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.required','false'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.fields.fd491dc0-cd31-4df7-87ca-f223d9c6dbc5.sortOrder','12'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.name','\"Content\"'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.fieldLayouts.650a7405-4948-4d96-bfdc-b120afaf43d4.tabs.0.sortOrder','1'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.handle','\"post\"'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.hasTitleField','false'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.name','\"Post\"'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.sortOrder','1'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.titleFormat','\"{section.name|raw}\"'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.entryTypes.1eaf83cf-82f1-462d-8fb0-193c9d361cca.titleLabel','\"\"'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.handle','\"post\"'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.name','\"Post\"'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.propagationMethod','\"all\"'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.siteSettings.e8751521-c647-465e-8bda-781b37cfe683.enabledByDefault','true'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.siteSettings.e8751521-c647-465e-8bda-781b37cfe683.hasUrls','true'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.siteSettings.e8751521-c647-465e-8bda-781b37cfe683.template','\"index\"'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.siteSettings.e8751521-c647-465e-8bda-781b37cfe683.uriFormat','\"__home__\"'),('sections.0624b6ae-31f5-4f4f-816a-f7bf248dbc63.type','\"single\"'),('siteGroups.9a82a528-0676-4cd8-a3d5-7f2ad8c02dc3.name','\"Server\"'),('sites.e8751521-c647-465e-8bda-781b37cfe683.baseUrl','\"$DEFAULT_SITE_URL\"'),('sites.e8751521-c647-465e-8bda-781b37cfe683.handle','\"default\"'),('sites.e8751521-c647-465e-8bda-781b37cfe683.hasUrls','true'),('sites.e8751521-c647-465e-8bda-781b37cfe683.language','\"en-US\"'),('sites.e8751521-c647-465e-8bda-781b37cfe683.name','\"Server\"'),('sites.e8751521-c647-465e-8bda-781b37cfe683.primary','true'),('sites.e8751521-c647-465e-8bda-781b37cfe683.siteGroup','\"9a82a528-0676-4cd8-a3d5-7f2ad8c02dc3\"'),('sites.e8751521-c647-465e-8bda-781b37cfe683.sortOrder','1'),('system.edition','\"solo\"'),('system.live','true'),('system.name','\"Server\"'),('system.schemaVersion','\"3.4.10\"'),('system.timeZone','\"America/Los_Angeles\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','\"\"'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true');
/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
INSERT INTO `resourcepaths` VALUES ('2059cd24','@app/web/assets/utilities/dist'),('26a94552','@bower/jquery/dist'),('2973a37b','@app/web/assets/tablesettings/dist'),('2b011dc7','@lib/jquery.payment'),('3726b22f','@lib/velocity'),('3b39c40b','@app/web/assets/feed/dist'),('42228fb5','@app/web/assets/cp/dist'),('5eb3cab6','@lib/vue'),('5f6fa838','@app/web/assets/recententries/dist'),('61d5ea56','@app/web/assets/updateswidget/dist'),('6f474697','@app/web/assets/craftsupport/dist'),('7180b869','@app/web/assets/updater/dist'),('735869c3','@lib/axios'),('77d7ae38','@app/web/assets/installer/dist'),('798f298a','@lib/jquery-ui'),('812fc1f9','@app/web/assets/dashboard/dist'),('825d9a3c','@lib/fabric'),('8648efb7','@app/web/assets/fields/dist'),('939eea7','@lib/element-resize-detector'),('971b4e02','@lib/garnishjs'),('9ed20e88','@app/web/assets/updates/dist'),('a18903f9','@app/web/assets/editentry/dist'),('a4a65984','@lib/d3'),('aa0379d5','@lib/picturefill'),('ada74517','@lib/jquery-touch-events'),('af39064','@app/web/assets/matrixsettings/dist'),('b2eb782b','@lib/fileupload'),('c9db47d2','@app/web/assets/editsection/dist'),('cbee48ae','@lib/timepicker'),('dfea05a9','@app/web/assets/admintable/dist'),('f41110db','@lib/xregexp'),('fe7d5451','@lib/selectize');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
INSERT INTO `revisions` VALUES (1,2,1,1,NULL),(2,2,1,2,NULL),(3,2,1,3,NULL),(4,2,1,4,NULL),(5,2,1,5,NULL),(6,2,1,6,NULL),(7,2,1,7,'Applied “Draft 1”'),(8,2,1,8,NULL),(9,2,1,9,NULL),(10,2,1,10,NULL),(11,2,1,11,NULL);
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' thanneman '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' thanneman1 gmail com '),(1,'slug',0,1,''),(2,'field',13,1,' https picsum photos 300 200 random=4 '),(2,'field',12,1,' https picsum photos 300 200 random=3 '),(2,'field',6,1,' get your system working again '),(2,'field',7,1,' lorem ipsum is simply dummy text of the printing and typesetting industry lorem ipsum has been the industrys standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book '),(2,'field',4,1,' meet your technician '),(2,'field',5,1,' lorem ipsum is simply dummy text of the printing and typesetting industry lorem ipsum has been the industrys standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book '),(2,'field',11,1,' https picsum photos 300 200 random=2 '),(2,'field',10,1,' https picsum photos 300 200 random=1 '),(2,'field',2,1,' schedule your repair '),(2,'field',3,1,' lorem ipsum is simply dummy text of the printing and typesetting industry lorem ipsum has been the industrys standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has survived not only five centuries but also the leap into electronic typesetting remaining essentially unchanged call 800 555 5555 '),(2,'field',1,1,' your ac repair in four easy steps '),(2,'title',0,1,' post '),(2,'slug',0,1,' post '),(2,'field',8,1,' let us know how we did '),(2,'field',9,1,' lorem ipsum is simply dummy text of the printing and typesetting industry lorem ipsum has been the industrys standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,NULL,'Post','post','single',1,'all',NULL,'2020-05-01 21:54:22','2020-05-01 21:54:22',NULL,'0624b6ae-31f5-4f4f-816a-f7bf248dbc63');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'__home__','index',1,'2020-05-01 21:54:22','2020-05-01 21:54:22','e49fab76-1ca5-4149-9dcf-7444f6072f6e');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (3,1,'goFew5bxGlpOd-8J1pOCd7s1L-x6lHjyd24QPJItBxNMk2_bTuPblcWBI5wEF6X7zXWKeGEa2dwaMB6L_0Cgf7Lk46FEDdKmP4tB','2020-05-03 16:09:44','2020-05-03 17:45:09','fb6fd8f2-75f5-4886-a4f5-5e014a7e974c');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
INSERT INTO `sitegroups` VALUES (1,'Server','2020-05-01 21:41:11','2020-05-01 21:41:11',NULL,'9a82a528-0676-4cd8-a3d5-7f2ad8c02dc3');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,1,1,'Server','default','en-US',1,'$DEFAULT_SITE_URL',1,'2020-05-01 21:41:11','2020-05-01 21:41:11',NULL,'e8751521-c647-465e-8bda-781b37cfe683');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecacheelements`
--

LOCK TABLES `templatecacheelements` WRITE;
/*!40000 ALTER TABLE `templatecacheelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecacheelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecachequeries`
--

LOCK TABLES `templatecachequeries` WRITE;
/*!40000 ALTER TABLE `templatecachequeries` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecachequeries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecaches`
--

LOCK TABLES `templatecaches` WRITE;
/*!40000 ALTER TABLE `templatecaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,'JcMIxVfY3ztcdWXIzkDIPzQYCAc4UFT6','[\"preview/preview\",{\"elementType\":\"craft\\\\elements\\\\Entry\",\"sourceId\":2,\"siteId\":1,\"draftId\":1,\"revisionId\":null}]',NULL,NULL,'2020-05-03 17:06:55','2020-05-02 17:06:56','2020-05-02 17:06:56','7433e2a7-233a-4521-ac14-9175ea6f0a56');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'thanneman',NULL,NULL,NULL,'thanneman1@gmail.com','$2y$13$96mmcs5h2M/Ip9UlZGRuTO8KnTiY1TJyiuuu3UB77JTpPxlIy6qNm',1,0,0,0,'2020-05-03 16:09:44',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2020-05-01 21:41:12','2020-05-01 21:41:12','2020-05-03 16:09:44','09b791d4-296f-4dd8-8d82-2a389f8d4d6e');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2020-05-01 21:41:16','2020-05-01 21:41:16','b2f63cf8-97e3-4dd7-8361-1c5564d9f0e2'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-05-01 21:41:16','2020-05-01 21:41:16','23196bac-74da-48b2-baa0-863273aef8ed'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-05-01 21:41:16','2020-05-01 21:41:16','45acdad4-8116-4d50-8864-4e45d6faf65c'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-05-01 21:41:16','2020-05-01 21:41:16','0457cd0a-f7fa-48c3-80e7-c4ebca03bbd3');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-03 19:44:49
