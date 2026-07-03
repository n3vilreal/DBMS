-- Check and create database
show DATABASEs;
CREATE DATABASE lab3;
use lab3;
show TABLEs;

-- Part 1: database setup

-- schema creation
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

-- Create Courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credit_hour INT
);

-- Create Enrollment Table
CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY,
    course_id INT,
    student_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);


-- dummy data insertion 
INSERT INTO Students (student_id, name, age, email, phone_number) VALUES
(1, 'Alice Smith', 20, 'alice@example.com', '555-0101'),
(2, 'Bob Johnson', 22, 'bob@example.com', '555-0102'),
(3, 'Charlie Brown', 19, 'charlie@example.com', '555-0103'),
(4, 'Diana Prince', 21, 'diana@example.com', '555-0104'),
(5, 'Evan Wright', 23, 'evan@example.com', '555-0105');

-- Insert Data into Courses
INSERT INTO courses (course_id, name, credit_hour) VALUES
(101, 'Introduction to Computer Science', 3),
(102, 'Data Structures', 4),
(103, 'Database Management Systems', 3),
(104, 'Web Development', 3),
(105, 'Artificial Intelligence', 4);

-- Insert Data into Enrollment
INSERT INTO enrollment (enrollment_id, course_id, student_id) VALUES
(1001, 101, 1),
(1002, 103, 1),
(1003, 102, 2),
(1004, 104, 2),
(1005, 101, 3),
(1006, 105, 4),
(1007, 103, 5),
(1008, 105, 5),
(1009, 102, 1);

-- part 2: sql practice questions

-- basic selection and filtering
SELECT * from enrollment;
select name, email from students;
select * from students where age>20;
SELECT * from students where name like 'a%';
SELECT * from courses where name like '%science%';
select * from students order by age desc;
select * from students where phone_number='555-0103';

-- CURD OPERATIONS
ALTER TABLE students ADD address VARCHAR(255);
ALTER TABLE students ADD is_active BOOLEAN DEFAULT TRUE;
ALTER TABLE students MODIFY COLUMN phone_number VARCHAR(50);
ALTER TABLE courses RENAME COLUMN name to course_name;
ALTER TABLE students DROP COLUMN age;
ALTER TABLE courses ADD CONSTRAINT check_credit_hour CHECK (3);
UPDATE students set phone_number = "555-9999" where student_id = 1;
UPDATE students set email = "bob.j@newemail.com", age = 23 where student_id = 2;
UPDATE students set email = LOWER(email);
UPDATE courses set credit_hour = 5 WHERE course_name = "Data Structures";
DELETE FROM enrollment WHERE student_id = 5;
DELETE FROM students WHERE name = "Evan Wright";
DELETE FROM courses WHERE credit_hour < 3;
DELETE FROM enrollment WHERE student_id = 3;
DELETE FROM students WHERE student_id = 3;
TRUNCATE TABLE enrollment;
-- Aggregate Functions
SELECT count(*) FROM students;
SELECT MAX(credit_hour) from courses;
SELECT SUM(credit_hour) FROM courses;

-- for rearranging tables
DROP TABLE enrollment;
DROP TABLE students;
DROP TABLE courses;

-- Grouping Data
SELECT count(*), course_id FROM students JOIN enrollment on students.student_id = enrollment.student_id
GROUP BY enrollment.course_id;
SELECT student_id, COUNT(course_id) FROM enrollment GROUP BY student_id;
SELECT student_id, COUNT(course_id) FROM enrollment GROUP BY student_id HAVING COUNT(student_id) > 2;
SELECT student_id, COUNT(course_id) FROM enrollment GROUP BY student_id HAVING COUNT(student_id) = 2;

-- Table relations and join
SELECT students.name, enrollment.course_id FROM students JOIN enrollment on students.student_id = enrollment.student_id;
SELECT students.name, courses.name FROM students JOIN enrollment ON students.student_id = enrollment.student_id
JOIN courses ON courses.course_id = enrollment.course_id;
SELECT * from enrollment;
SELECT courses.name, count(enrollment.student_id) FROM courses left JOIN enrollment ON courses.course_id = enrollment.course_id GROUP BY name;