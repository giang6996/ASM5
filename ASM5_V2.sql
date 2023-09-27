-- Create table Employee, Status = 1: are working

CREATE DATABASE ASM5_1
GO

USE ASM5_1
GO

CREATE TABLE [dbo].[Employee](
	[EmpNo] [int] NOT NULL
,	[EmpName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[BirthDay] [datetime] NOT NULL
,	[DeptNo] [int] NOT NULL
, 	[MgrNo] [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[StartDate] [datetime] NOT NULL
,	[Salary] [money] NOT NULL
,	[Status] [int] NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
,	[Level] [int] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE Employee 
ADD CONSTRAINT PK_Emp PRIMARY KEY (EmpNo)
GO

ALTER TABLE [dbo].[Employee]  
ADD  CONSTRAINT [chk_Level] 
	CHECK  (([Level]=(7) OR [Level]=(6) OR [Level]=(5) OR [Level]=(4) OR [Level]=(3) OR [Level]=(2) OR [Level]=(1)))
GO
ALTER TABLE [dbo].[Employee]  
ADD  CONSTRAINT [chk_Status] 
	CHECK  (([Status]=(2) OR [Status]=(1) OR [Status]=(0)))

GO
ALTER TABLE [dbo].[Employee]
ADD Email NCHAR(30) 
GO

ALTER TABLE [dbo].[Employee]
ADD CONSTRAINT chk_Email CHECK (Email IS NOT NULL)
GO

ALTER TABLE [dbo].[Employee] 
ADD CONSTRAINT chk_Email1 UNIQUE(Email)

GO
ALTER TABLE Employee
ADD CONSTRAINT DF_EmpNo DEFAULT 0 FOR EmpNo

GO
ALTER TABLE Employee
ADD CONSTRAINT DF_Status DEFAULT 0 FOR Status

GO
CREATE TABLE [dbo].[Skill](
	[SkillNo] [int] IDENTITY(1,1) NOT NULL
,	[SkillName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Skill
ADD CONSTRAINT PK_Skill PRIMARY KEY (SkillNo)

GO
CREATE TABLE [dbo].[Department](
	[DeptNo] [int] IDENTITY(1,1) NOT NULL
,	[DeptName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Department
ADD CONSTRAINT PK_Dept PRIMARY KEY (DeptNo)

GO
CREATE TABLE [dbo].[Emp_Skill](
	[SkillNo] [int] NOT NULL
,	[EmpNo] [int] NOT NULL
,	[SkillLevel] [int] NOT NULL
,	[RegDate] [datetime] NOT NULL
,	[Description] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT PK_Emp_Skill PRIMARY KEY (SkillNo, EmpNo)
GO

ALTER TABLE Employee  
ADD  CONSTRAINT [FK_1] FOREIGN KEY([DeptNo])
REFERENCES Department (DeptNo)

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT [FK_2] FOREIGN KEY ([EmpNo])
REFERENCES Employee([EmpNo])

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT [FK_3] FOREIGN KEY ([SkillNo])
REFERENCES Skill([SkillNo])

GO

INSERT INTO Department(DeptName, Note) VALUES
	('IT', 'This is IT department')
	,('PR', 'This is PR department')
	,('ADV', 'This is advertising department')
	,('Media', 'This is media department')
	,('Security', 'This is security department')
	,('Other', 'This is other department')

INSERT INTO Skill(SkillName, Note) VALUES
	('HTML', 'HTML skill')
	,('C++', 'C++ skill')
	,('Python', 'Python skill')
	,('SQL', 'SQL skill')
	,('RUBY', 'RUBY skill')
	,('ReactJS', 'ReactJS skill')
	,('SPSS', 'SPSS skill')
	,('.NET', '.NET skill')
	,('Other', 'Other skill')

INSERT INTO Employee(EmpNo, EmpName, BirthDay, DeptNo, MgrNo, StartDate, Salary, Status, Level, Email) VALUES
	(1,'John Doe', '1992-09-26', 1, 1, '2017-06-06', 100000000 , 0, 6 , 'abc@gmail.com')
	,(2,'Mary Jane', '2005-08-10', 3, 2, '2018-01-25', 90000000, 0, 1, 'abc2@gmail.com')
	,(3,'Edmund Paul', '1993-04-07', 2, 3, '2018-03-06' ,40000000, 1, 2, 'abc3@gmail.com')
	,(4,'Lexi Arias', '1997-11-04', 4, 2, '2022-02-21' ,12000000, 2, 3,  'abc4@gmail.com')
	,(5,'Aleeza Carter', '1992-08-09', 3, 4, '2020-05-15' ,50000000, 1, 4, 'abc5@gmail.com')
	,(6,'Traci Martinez', '1984-08-24', 5, 4, GETDATE(),50000000, 0, 1, 'abc6@gmail.com')
	,(7,'Jill Zimmerman', '1996-07-05', 2, 4, GETDATE(),50000000, 1, 1, 'abc7@gmail.com')
	,(8,'Winston Chandler', '1988-08-22', 3, 4, '2018-03-06',50000000, 1, 2,'abc8@gmail.com')
	,(9,'Hipolito Mitchell', '1990-05-13', 5, 4, GETDATE(),50000000, 0, 3, 'abc9@gmail.com')

	UPDATE Employee SET MgrNo = 4 WHERE EmpNo <> 4
	UPDATE Employee SET MgrNo = 0 WHERE EmpNo = 4
	UPDATE Employee SET Status = 1 WHERE Status = 0

INSERT INTO Emp_Skill (EmpNo, SkillNo, SkillLevel, RegDate, Description) VALUES
	(1, 2, 8, '2017-06-06', 'None')
	,(1, 4, 8, '2017-06-06', 'None')
	,(1, 6, 8, '2017-06-06', 'None')
	,(2, 2, 8, '2018-01-25', 'None')
	,(3, 8, 8, '2018-03-06', 'None')
	,(4, 8, 8, '2022-02-21', 'None')
	,(5, 8, 8, '2017-06-06', 'None')
	,(6, 1, 8, GETDATE(), 'None')
	,(6, 3, 8, GETDATE(), 'None')
	,(7, 4, 8, GETDATE(), 'None')
	,(8, 5, 8, '2018-03-06', 'None')
	,(9, 7, 8, GETDATE(), 'None')

GO

SELECT * FROM Department
SELECT * FROM Skill
SELECT * FROM Employee
SELECT * FROM Emp_Skill

SELECT EmpName, Email, DeptNo, DATEDIFF(MONTH, StartDate, GETDATE()) WorkDuration FROM Employee WHERE DATEDIFF(MONTH, StartDate, GETDATE()) > 6

SELECT E.EmpName, Em.SkillNo, S.SkillName FROM Employee E 
	JOIN Emp_Skill Em ON E.EmpNo = Em.EmpNo 
	JOIN Skill S ON S.SkillNo = Em.SkillNo
	WHERE S.SkillName = 'C++' OR S.SkillName = '.NET'

SELECT E.EmpName, E2.EmpName Manager, E2.Email ManagerEmail FROM Employee E 
	JOIN Employee E2 ON E.MgrNo = E2.EmpNo

SELECT E.DeptNo, E.EmpNo, E.EmpName FROM Employee E 
	WHERE E.DeptNo IN 
	(
		SELECT DeptNo FROM Employee
		GROUP BY DeptNo
		HAVING COUNT(DeptNo) >= 2
	)
	ORDER BY DeptNo ASC

SELECT EM.EmpNo, E.EmpName, E.Email, EM.SkillNo, S.SkillName FROM Employee E 
	JOIN Emp_Skill EM ON EM.EmpNo = E.EmpNo
	JOIN Skill S ON EM.SkillNo = S.SkillNo
	ORDER BY EM.EmpNo ASC

SELECT E.EmpName, E.Email, E.BirthDay, E.Status, COUNT(EM.SkillNo) NumOfSkill FROM Employee E
	JOIN Emp_Skill EM ON EM.EmpNo = E.EmpNo 
	GROUP BY E.EmpName, E.Email, E.BirthDay, E.Status
	HAVING COUNT(EM.SkillNo) > 1 AND E.Status > 0

SELECT E.EmpName, E.Email, E.BirthDay, E.Status, EM.NumOfSkills 
FROM Employee E
JOIN (
    SELECT EmpNo, COUNT(SkillNo) AS NumOfSkills
    FROM Emp_Skill EM
    GROUP BY EmpNo
    HAVING COUNT(SkillNo) > 1
) EM ON E.EmpNo = EM.EmpNo
GROUP BY E.EmpName, E.Email, E.BirthDay, E.Status, EM.NumOfSkills 
HAVING E.Status > 0

GO
CREATE VIEW VW_Qh AS
SELECT E.EmpNo, E.EmpName, EM.SkillNo, S.SkillName, E.DeptNo, D.DeptName FROM Employee E
	JOIN Emp_Skill EM ON E.EmpNo = EM.EmpNo 
	JOIN Skill S ON EM.SkillNo = S.SkillNo
	JOIN Department D ON E.DeptNo = D.DeptNo
	ORDER BY EmpNo ASC
	
GO
