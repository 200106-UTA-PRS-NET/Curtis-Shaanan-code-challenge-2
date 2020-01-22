CREATE SCHEMA EMPLOYEE;
USE EMPLOYEE;
CREATE TABLE Department
(
	ID				MEDIUMINT		NOT NULL UNIQUE AUTO_INCREMENT,	-- UNIQUE is implicit but doesn't hurt
    `Name`			CHAR(50)		NOT NULL,
    Location		CHAR(10)		NOT NULL,
    CONSTRAINT		Depo_PK			PRIMARY KEY(ID)
);

CREATE TABLE Employee
(
	ID				BIGINT			NOT NULL UNIQUE AUTO_INCREMENT,
    FirstName		CHAR(50)		NOT NULL,
    LastName		CHAR(50)		NOT NULL,
    SSN				CHAR(9)			NOT NULL,
    DeptID			MEDIUMINT		NOT NULL,
    CONSTRAINT		Emp_PK			PRIMARY KEY(ID),
    CONSTRAINT		Emp_FK			FOREIGN KEY(DeptID)
    REFERENCES		Department(ID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

CREATE TABLE EmpDetails
(
	ID				BIGINT			NOT NULL UNIQUE AUTO_INCREMENT,
    EmployeeID		BIGINT			NOT NULL UNIQUE,
    Salary			DECIMAL(16,6)	NOT NULL DEFAULT 0.00,
    Address1		VARCHAR(255)	NOT NULL,
    Address2		CHAR(30)		NULL,	-- Apt no, PO Box...
    City			CHAR(100)		NOT NULL,
    State			CHAR(2)			NOT NULL,
    Country			CHAR(3)		NOT NULL,
    CONSTRAINT	 	EmpD_PK			PRIMARY KEY(ID),
    CONSTRAINT 	 	EmpD_FK			FOREIGN KEY(EmployeeID)
    REFERENCES		Employee(ID)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
);

INSERT INTO Department(`Name`,Location)VALUES('HR','76010-0001');	-- locations based on zip extended by facility section
INSERT INTO Department(`Name`,Location)VALUES('Technology','76010-0002');
INSERT INTO Department(`Name`,Location)VALUES('Training','76010-0003');

INSERT INTO Employee(FirstName,LastName,SSN,DeptID)VALUES('Bennie','Hanna','001010001',1);
INSERT INTO Employee(FirstName,LastName,SSN,DeptID)VALUES('Shaaann','Xi','189891829',2);
INSERT INTO Employee(FirstName,LastName,SSN,DeptID)VALUES('Natali','Farosh','267178871',3);

INSERT INTO EmpDetails(EmployeeID,Salary,Address1,Address2,City,State,Country)VALUES(1,1000000000.67,'123 First St','Apt. 9','Random Town','NJ','USA');
INSERT INTO EmpDetails(EmployeeID,Salary,Address1,City,State,Country)VALUES(2,999999.00,'8818 Super Dr','Arlington','TX','USA');
INSERT INTO EmpDetails(EmployeeID,Salary,Address1,City,State,Country)VALUES(3,1000000.88,'1234 Streetname St','Somewhere','CA','USA');

INSERT INTO Employee(FirstName,LastName,SSN,DeptID)VALUES('Tina','Smith','888888888',2);

INSERT INTO Department(`Name`,Location)VALUES('Marketing','76010-0004');

-- for listing department example
INSERT INTO Employee(FirstName,LastName,SSN,DeptID)VALUES('Name','Leu','717766776',4);
INSERT INTO Employee(FirstName,LastName,SSN,DeptID)VALUES('Some','Dude','123987651',4);

SELECT * FROM EMPLOYEE WHERE DeptID = 4;

-- for next example
INSERT INTO EmpDetails(EmployeeID,Salary,Address1,Address2,City,State,Country)VALUES(4,109388.18,'89283 Address St','Apt. 8','City Name','AZ','USA');
INSERT INTO EmpDetails(EmployeeID,Salary,Address1,City,State,Country)VALUES(5,8888888.88,'891 Other Place','City Again','SI','CNA');
INSERT INTO EmpDetails(EmployeeID,Salary,Address1,Address2,City,State,Country)VALUES(6,1839.00,'183 Hello','Apt. 7', 'Foursquare','BK','OIO');

SELECT SUM(EmpDetails.Salary) FROM EmpDetails JOIN Employee ON EmployeeID WHERE Employee.DeptID = 4;

SELECT COUNT(*) FROM Employee GROUP BY DeptID;

UPDATE EmpDetails
JOIN Employee ON EmpDetails.EmployeeID = Employee.ID
SET EmpDetails.Salary = 90000.00 
WHERE Employee.FirstName LIKE 'Tina' AND Employee.LastName LIKE 'Smith';

