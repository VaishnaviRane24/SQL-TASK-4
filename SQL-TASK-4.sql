-- Create database
CREATE DATABASE companyDB;
USE companyDB;

-- Departments table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Insert department data
INSERT INTO Departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Finance'),
(4, 'IT');

-- Employees table
CREATE TABLE Employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY ,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT,
    salary DECIMAL(10, 2),
    joining_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- Insert employee data
INSERT INTO Employees (emp_name, dept_id, salary, joining_date) VALUES
('Aarav Sharma', 1, 50000, '2022-05-10'),
('Ananya Iyer', 1, 55000, '2021-03-14'),
('Divya Kulkarni', 2, 60000, '2020-08-25'),
('Rohit Mehta', 2, 62000, '2019-11-30'),
('Sanya Kapoor', 3, 75000, '2021-07-01'),
('Kabir Rao', 3, 72000, '2022-01-15'),
('Priya Nair', 4, 80000, '2020-04-20'),
('Manish Gupta', 4, 85000, '2019-09-12');

-- SUM of salary by department
SELECT D.dept_name, SUM(E.salary) AS total_salary
FROM Employees E
JOIN Departments D ON E.dept_id = D.dept_id
GROUP BY D.dept_name;

-- Average salary by department (rounded)
SELECT D.dept_name, ROUND(AVG(E.salary), 2) AS avg_salary
FROM Employees E
JOIN Departments D ON E.dept_id = D.dept_id
GROUP BY D.dept_name;

-- Count employees by department
SELECT D.dept_name, COUNT(*) AS total_employees
FROM Employees E
JOIN Departments D ON E.dept_id = D.dept_id
GROUP BY D.dept_name;

--  Count employees with non-null salaries
SELECT D.dept_name, COUNT(E.salary) AS employees_with_salary
FROM Employees E
JOIN Departments D ON E.dept_id = D.dept_id
GROUP BY D.dept_name;

--  Departments having more than 1 employee
SELECT D.dept_name, COUNT(*) AS emp_count
FROM Employees E
JOIN Departments D ON E.dept_id = D.dept_id
GROUP BY D.dept_name
HAVING COUNT(*) > 1;

-- Highest salary in each department
SELECT D.dept_name, MAX(E.salary) AS highest_salary
FROM Employees E
JOIN Departments D ON E.dept_id = D.dept_id
GROUP BY D.dept_name;

-- Group by multiple columns (Department & Joining Year)
SELECT D.dept_name, YEAR(E.joining_date) AS join_year, COUNT(*) AS emp_count
FROM Employees E
JOIN Departments D ON E.dept_id = D.dept_id
GROUP BY D.dept_name, YEAR(E.joining_date)
ORDER BY D.dept_name, join_year;

-- Count distinct salaries per department
SELECT D.dept_name, COUNT(DISTINCT E.salary) AS unique_salaries
FROM Employees E
JOIN Departments D ON E.dept_id = D.dept_id
GROUP BY D.dept_name;
