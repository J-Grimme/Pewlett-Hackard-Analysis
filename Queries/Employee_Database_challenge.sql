-- Deliverable 1
-- Creating a table for the number of retiring employees by title
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       t.title,
       t.from_date,
       t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

-- Removing duplicates and only keeping the most recent title of each employee
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO Unique_titles
FROM retirement_titles
WHERE (retirement_titles.to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- The number of employees by their most recent job title who are about to retire
SELECT COUNT(Unique_titles.emp_no), Unique_titles.title
INTO retiring_titles
FROM Unique_titles
GROUP BY title
ORDER BY count DESC;

-- Deliverable 2 
-- Creating a Mentorship Eligibility table that holds all of the employees who are eligible to participate in a mentorship program
SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
        employees.first_name,
        employees.last_name,
        employees.birth_date,
        department_employees.from_date,
        department_employees.to_date,
        titles.title
INTO mentorship_eligibility
FROM employees
    INNER JOIN dept_emp
    ON (employees.emp_no = dept_emp.emp_no)
    INNER JOIN titles
    ON (employees.emp_no = titles.emp_no)
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY employees.emp_no;