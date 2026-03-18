-- Создание базы данных
CREATE DATABASE IF NOT EXISTS electronic_gradebook;
USE electronic_gradebook;

-- Таблица users (пользователи)
CREATE TABLE users (
    ID_пользователя BIGINT PRIMARY KEY AUTO_INCREMENT,
    Логин VARCHAR(50) NOT NULL UNIQUE,
    Пароль_хэш VARCHAR(100) NOT NULL,
    Фамилия VARCHAR(50) NOT NULL,
    Имя VARCHAR(50) NOT NULL,
    Отчество VARCHAR(50),
    Роль ENUM('STUDENT', 'TEACHER', 'ADMIN') NOT NULL,
    ID_группы BIGINT
);

-- Таблица student_groups (учебные группы)
CREATE TABLE student_groups (
    ID_группы BIGINT PRIMARY KEY AUTO_INCREMENT,
    Название_группы VARCHAR(20) NOT NULL UNIQUE,
    Факультет VARCHAR(100) NOT NULL,
    Курс INT NOT NULL,
    Год_формирования INT NOT NULL
);

-- Таблица disciplines (дисциплины)
CREATE TABLE disciplines (
    ID_дисциплины BIGINT PRIMARY KEY AUTO_INCREMENT,
    Название_дисциплины VARCHAR(100) NOT NULL UNIQUE,
    Часов_всего INT NOT NULL,
    Форма_контроля ENUM('Экзамен', 'Зачет', 'Курсовая') NOT NULL
);

-- Таблица academic_plans (учебный план)
CREATE TABLE academic_plans (
    ID_записи_плана BIGINT PRIMARY KEY AUTO_INCREMENT,
    ID_группы BIGINT NOT NULL,
    ID_дисциплины BIGINT NOT NULL,
    ID_преподавателя BIGINT NOT NULL,
    Семестр INT NOT NULL,
    FOREIGN KEY (ID_группы) REFERENCES student_groups(ID_группы),
    FOREIGN KEY (ID_дисциплины) REFERENCES disciplines(ID_дисциплины),
    FOREIGN KEY (ID_преподавателя) REFERENCES users(ID_пользователя)
);

-- Таблица grades (оценки)
CREATE TABLE grades (
    ID_оценки BIGINT PRIMARY KEY AUTO_INCREMENT,
    ID_студента BIGINT NOT NULL,
    ID_дисциплины BIGINT NOT NULL,
    ID_учебного_плана BIGINT NOT NULL,
    Тип_работы ENUM('ЛАБОРАТОРНАЯ', 'ПРАКТИЧЕСКАЯ', 'КОНТРОЛЬНАЯ', 'ЛЕКЦИЯ', 'ЭКЗАМЕН') NOT NULL,
    Оценка_5_балльная BOOLEAN,
    Зачет BOOLEAN,
    Дата_выставления DATE NOT NULL,
    FOREIGN KEY (ID_студента) REFERENCES users(ID_пользователя),
    FOREIGN KEY (ID_дисциплины) REFERENCES disciplines(ID_дисциплины),
    FOREIGN KEY (ID_учебного_плана) REFERENCES academic_plans(ID_записи_плана)
);