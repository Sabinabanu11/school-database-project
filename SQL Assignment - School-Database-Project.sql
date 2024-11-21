CREATE TABLE Students (
    StudentID INTEGER PRIMARY KEY AUTOINCREMENT,
    StudentName TEXT NOT NULL,
    Gender TEXT CHECK(Gender IN ('M', 'F')),
    DOB DATE NOT NULL,
    GradeLevel TEXT CHECK(GradeLevel IN ('A', 'B', 'C', 'D', 'F')),
    EnrollmentDate DATE NOT NULL,
    GPA REAL CHECK(GPA BETWEEN 0.0 AND 4.0)
);
CREATE TABLE Courses (
    CourseID INTEGER PRIMARY KEY AUTOINCREMENT,
    CourseName TEXT NOT NULL,
    Credits INTEGER CHECK(Credits > 0),
    Department TEXT CHECK(Department IN ('Science', 'Arts', 'Commerce'))
);
CREATE TABLE Enrollments (
    EnrollmentID INTEGER PRIMARY KEY AUTOINCREMENT,
    StudentID INTEGER NOT NULL,
    CourseID INTEGER NOT NULL,
    Term TEXT CHECK(Term IN ('Spring', 'Summer', 'Fall')),
    Year INTEGER CHECK(Year >= 2000),
    Grade TEXT CHECK(Grade IN ('A', 'B', 'C', 'D', 'F')),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
WITH RECURSIVE numbers(i) AS (
    SELECT 1
    UNION ALL
    SELECT i + 1
    FROM numbers
    WHERE i < 1000
)
INSERT INTO Students (StudentName, Gender, DOB, GradeLevel, EnrollmentDate, GPA)
SELECT
    'Student ' || i AS StudentName,
    CASE WHEN i % 2 = 0 THEN 'M' ELSE 'F' END AS Gender,
    DATE('2000-01-01', '-' || ABS(i * 7 % 7300) || ' days') AS DOB,
    CASE 
        WHEN i % 5 = 0 THEN 'A'
        WHEN i % 5 = 1 THEN 'B'
        WHEN i % 5 = 2 THEN 'C'
        WHEN i % 5 = 3 THEN 'D'
        ELSE 'F'
    END AS GradeLevel,
    DATE('2020-09-01', '-' || ABS(i * 3 % 3650) || ' days') AS EnrollmentDate,
    ROUND((i % 401) / 100.0, 2) AS GPA
FROM numbers;
INSERT INTO Courses (CourseName, Credits, Department)
VALUES
    ('Mathematics', 3, 'Science'),
    ('Physics', 4, 'Science'),
    ('Biology', 3, 'Science'),
    ('History', 3, 'Arts'),
    ('Literature', 3, 'Arts'),
    ('Philosophy', 2, 'Arts'),
    ('Accounting', 3, 'Commerce'),
    ('Economics', 4, 'Commerce'),
    ('Marketing', 3, 'Commerce'),
    ('Chemistry', 4, 'Science'),
    ('Art History', 3, 'Arts'),
    ('Political Science', 3, 'Arts'),
    ('Programming', 4, 'Science'),
    ('Business Ethics', 2, 'Commerce'),
    ('Statistics', 3, 'Science'),
    ('Sociology', 3, 'Arts'),
    ('Psychology', 3, 'Arts'),
    ('Finance', 3, 'Commerce'),
    ('Data Science', 4, 'Science'),
    ('Geography', 3, 'Arts');

WITH RECURSIVE numbers(i) AS (
    SELECT 1
    UNION ALL
    SELECT i + 1
    FROM numbers
    WHERE i < 5000
)
INSERT INTO Enrollments (StudentID, CourseID, Term, Year, Grade)
SELECT
    ABS(RANDOM() % 1000) + 1 AS StudentID,
    ABS(RANDOM() % 20) + 1 AS CourseID,
    CASE
        WHEN RANDOM() % 3 = 0 THEN 'Spring'
        WHEN RANDOM() % 3 = 1 THEN 'Summer'
        ELSE 'Fall'
    END AS Term,
    2020 + (RANDOM() % 5) AS Year,
    CASE 
        WHEN RANDOM() % 5 = 0 THEN 'A'
        WHEN RANDOM() % 5 = 1 THEN 'B'
        WHEN RANDOM() % 5 = 2 THEN 'C'
        WHEN RANDOM() % 5 = 3 THEN 'D'
        ELSE 'F'
    END AS Grade
FROM numbers;

SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
SELECT StudentName, GPA FROM Students WHERE GPA > 3.5;
SELECT CourseName, Credits FROM Courses WHERE Department = 'Science';
SELECT * FROM Enrollments WHERE Year = 2023 AND Term = 'Spring';
SELECT COUNT(*) AS Total_Students FROM Students;
SELECT StudentName, GPA FROM Students ORDER BY GPA DESC LIMIT 5;
SELECT Term, COUNT(*) AS Enrollment_Count FROM Enrollments GROUP BY Term;
INSERT INTO Students (StudentName, Gender, DOB, GradeLevel, EnrollmentDate, GPA)
VALUES ('Student 1', 'M', '2000-01-01', 'A', '2020-09-01', 3.5);
DELETE FROM Students WHERE StudentID = 12001;
UPDATE Students SET GradeLevel = NULL, GPA = NULL WHERE StudentID = 1000;
UPDATE Students SET GradeLevel = 'A', GPA = 1.98 WHERE StudentID = 1000;

SELECT 
    Enrollments.EnrollmentID,
    Students.StudentName,
    Courses.CourseName,
    Enrollments.Term,
    Enrollments.Year,
    Enrollments.Grade
FROM Enrollments JOIN Students ON Enrollments.StudentID = Students.StudentID JOIN Courses ON Enrollments.CourseID = Courses.CourseID;
SELECT Students.StudentName, Students.GPA
FROM Enrollments Enrollments JOIN Students Students ON Enrollments.StudentID = Students.StudentID WHERE Enrollments.CourseID = 1;
UPDATE Students SET GPA = 3.9 WHERE StudentID = 1;
UPDATE Courses SET Credits = 4 WHERE CourseID = 1;

DELETE FROM Enrollments WHERE Year = 2022;
SELECT * FROM Enrollments;
SELECT AVG(Students.GPA) AS Average_GPA
FROM Enrollments Enrollments
JOIN Students Students ON Enrollments.StudentID = Students.StudentID
JOIN Courses Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Courses.Department = 'Science';
