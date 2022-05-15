-- ---
-- Proyecto: Hack The Ocean (Launch X - Innovacción Virtual - Microsoft)
-- Equipo: The Ocean Lighthouse
-- Fecha de creación: 2022-05-14
-- Descripción: código DDL para crear la estructura de la base de datos relacional haciendo uso del RDBMS MySQL.
-- ---

-- ---
-- Base de datos 'the-ocean-lighthouse'
-- ---
CREATE DATABASE IF NOT EXISTS `the-ocean-lighthouse`
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_general_ci;

USE `the-ocean-lighthouse`;

-- ---
-- Tabla 'persona'
-- Almacena los datos principales de una persona
-- ---

DROP TABLE IF EXISTS `persona`;
		
CREATE TABLE `persona` (
  `per_id_persona` INTEGER NOT NULL AUTO_INCREMENT,
  `per_id_estado` INTEGER NULL DEFAULT NULL,
  `per_nombre` VARCHAR(200) NOT NULL,
  `per_apaterno` VARCHAR(100) NOT NULL,
  `per_amaterno` VARCHAR(100) NULL DEFAULT NULL,
  `per_fecha_nacimiento` DATE NOT NULL,
  `per_telefono` VARCHAR(25) NULL DEFAULT NULL,
  `per_correo` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`per_id_persona`)
) COMMENT 'Almacena los datos principales de una persona';

-- ---
-- Tabla 'donacion'
-- Almacena los datos de las donaciones recibidas
-- ---

DROP TABLE IF EXISTS `donacion`;
		
CREATE TABLE `donacion` (
  `don_id_donacion` INTEGER NOT NULL AUTO_INCREMENT,
  `don_id_persona` INTEGER NOT NULL,
  `don_id_transaccion` VARCHAR(250) NULL DEFAULT NULL,
  `don_cantidad` DECIMAL(7,5) NOT NULL,
  `don_forma_pago` VARCHAR(100) NULL DEFAULT NULL COMMENT 'crédito, débito',
  `don_fecha_pago` TIMESTAMP NOT NULL,
  PRIMARY KEY (`don_id_donacion`)
) COMMENT 'Almacena los datos de las donaciones recibidas';

-- ---
-- Tabla 'voluntario'
-- Almacena los datos de los voluntarios registrados
-- ---

DROP TABLE IF EXISTS `voluntario`;
		
CREATE TABLE `voluntario` (
  `vol_id_voluntario` INTEGER NOT NULL AUTO_INCREMENT,
  `vol_id_rol` INTEGER NOT NULL,
  `vol_fecha_registro` TIMESTAMP NOT NULL,
  `vol_tipo` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`vol_id_voluntario`)
) COMMENT 'Almacena los datos de los voluntarios registrados';

-- ---
-- Tabla 'rol'
-- Almacena los diferentes roles de los voluntarios
-- ---

DROP TABLE IF EXISTS `rol`;
		
CREATE TABLE `rol` (
  `rol_id_rol` INTEGER NOT NULL AUTO_INCREMENT,
  `rol_nombre` VARCHAR(250) NOT NULL,
  `rol_descripcion` MEDIUMTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`rol_id_rol`)
) COMMENT 'Almacena los diferentes roles de los voluntarios';

-- ---
-- Tabla 'playa'
-- Almacena la información de las playas en las que se trabajan
-- ---

DROP TABLE IF EXISTS `playa`;
		
CREATE TABLE `playa` (
  `pla_id_playa` INTEGER NOT NULL AUTO_INCREMENT,
  `pla_id_estado` INTEGER NOT NULL,
  `pla_id_condicion` INTEGER NOT NULL,
  `pla_nombre` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`pla_id_playa`)
) COMMENT 'Almacena la información de las playas en las que se trabajan';

-- ---
-- Tabla 'estado'
-- Almacena los 32 estados de México
-- ---

DROP TABLE IF EXISTS `estado`;
		
CREATE TABLE `estado` (
  `est_id_estado` INTEGER NOT NULL AUTO_INCREMENT,
  `est_nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`est_id_estado`)
) COMMENT 'Almacena los 32 estados de México';

-- ---
-- Tabla 'condicion'
-- Almacena las diferentes condiciones que pueden tener las playas
-- ---

DROP TABLE IF EXISTS `condicion`;
		
CREATE TABLE `condicion` (
  `con_id_condicion` INTEGER NOT NULL AUTO_INCREMENT,
  `con_nombre` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`con_id_condicion`)
) COMMENT 'Almacena las diferentes condiciones que pueden tener las pla';

-- ---
-- Tabla 'playa_voluntario'
-- Transitiva para almacenar los diferentes voluntarios asignados a las playas
-- ---

DROP TABLE IF EXISTS `playa_voluntario`;
		
CREATE TABLE `playa_voluntario` (
  `pv_id_playa_voluntario` INTEGER NOT NULL AUTO_INCREMENT,
  `pv_id_playa` INTEGER NOT NULL,
  `pv_id_voluntario` INTEGER NOT NULL,
  PRIMARY KEY (`pv_id_playa_voluntario`)
) COMMENT 'Transitiva para almacenar los diferentes voluntarios asignad';

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `persona` ADD FOREIGN KEY (per_id_estado) REFERENCES `estado` (`est_id_estado`);
ALTER TABLE `donacion` ADD FOREIGN KEY (don_id_persona) REFERENCES `persona` (`per_id_persona`);
ALTER TABLE `voluntario` ADD FOREIGN KEY (vol_id_rol) REFERENCES `rol` (`rol_id_rol`);
ALTER TABLE `playa` ADD FOREIGN KEY (pla_id_estado) REFERENCES `estado` (`est_id_estado`);
ALTER TABLE `playa` ADD FOREIGN KEY (pla_id_condicion) REFERENCES `condicion` (`con_id_condicion`);
ALTER TABLE `playa_voluntario` ADD FOREIGN KEY (pv_id_playa) REFERENCES `playa` (`pla_id_playa`);
ALTER TABLE `playa_voluntario` ADD FOREIGN KEY (pv_id_voluntario) REFERENCES `voluntario` (`vol_id_voluntario`);
