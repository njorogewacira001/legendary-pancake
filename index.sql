-- Find employees whose salary is above the average salary
SELECT *
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- Retrieve information about employees and their departments using INNER JOIN
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Salary, Departments.DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;


-- Calculate the total salary expenditure for each department
SELECT Departments.DepartmentName, SUM(Employees.Salary) AS TotalSalary
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
GROUP BY Departments.DepartmentName;


-- Rank employees based on their salary within each department
SELECT EmployeeID, FirstName, LastName, Department, Salary,
       RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
FROM Employees;


-- Use a CTE to find employees with salaries above the average
WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE Salary > (SELECT AvgSalary FROM AvgSalaryCTE);


-- Create an index on the DepartmentID column for better performance
CREATE INDEX idx_DepartmentID ON Employees (DepartmentID);


-- Create a stored procedure to update an employee's salary
DELIMITER //
CREATE PROCEDURE UpdateSalary(IN empID INT, IN newSalary DECIMAL(10, 2))
BEGIN
    UPDATE Employees SET Salary = newSalary WHERE EmployeeID = empID;
END //
DELIMITER ;


-- Create a trigger to log salary changes to an audit table
CREATE TRIGGER SalaryAudit
AFTER UPDATE ON Employees
FOR EACH ROW
INSERT INTO SalaryAuditLog (EmployeeID, OldSalary, NewSalary, ChangeDate)
VALUES (OLD.EmployeeID, OLD.Salary, NEW.Salary, NOW());
