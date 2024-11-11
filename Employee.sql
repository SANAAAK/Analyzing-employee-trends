CREATE TABLE EmployeeDetails (
 emp_no INT PRIMARY KEY,
 gender NVARCHAR(10),
 marital_status NVARCHAR(10),
 age_band NVARCHAR(20),
 age INT,
 department NVARCHAR(50),
 education NVARCHAR(50),
 education_field NVARCHAR(50),
 job_role NVARCHAR(50),
 business_travel NVARCHAR(20),
 employee_count INT,
 attrition NVARCHAR(5),
 attrition_label NVARCHAR(20),
 job_satisfaction INT,
 active_employee BIT
 );
 BULK INSERT EmployeeDetails
 FROM'C:\music store data\employee_trends.csv'
 WITH (
 FIELDTERMINATOR = ',',
 ROWTERMINATOR ='\n',
 FIRSTROW = 2,
 KEEPNULLS,
 CODEPAGE='65001'
 );
/* Q1: Count the number of employees in each department */
SELECT department, COUNT(*) AS employee_count
FROM EmployeeDetails
GROUP BY department;
/*Q2:  Calculate the average age for each department*/
SELECT department,AVG(age) AS avg_age
FROM EmployeeDetails
GROUP BY department;
/*Q3:Identify the most common job roles in each department*/
SELECT department,job_role, Count(job_role) as job_count
From EmployeeDetails
Group by department,job_role
Order by department, job_count DESC;
/*Q4:Calculate the average job satisfaction for each education level*/
SELECT education,avg(job_satisfaction) AS avg_job_satisfaction
FROM EmployeeDetails
GROUP BY education;
/*Q5: Determine the average age for employees with different levels of job
 satisfaction*/
 SELECT job_satisfaction, avg(age) as avg_age
 from EmployeeDetails
 group by job_satisfaction;
--Q6:Calculate the attrition rate for each age band--
SELECT age_band, 
    CAST(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5, 2)) AS attrition_rate
FROM EmployeeDetails
GROUP BY age_band;
--2eme sol--
SELECT age_band,
COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS attrition_rate
FROM EmployeeDetails E
GROUP BY age_band;
--Q7: Identify the department with the highest and lowest average job satisfaction--
SELECT department, AVG(job_satisfaction) AS avg_job_satisfaction
FROM EmployeeDetails
GROUP BY department
ORDER BY avg_job_satisfaction DESC
--Q8:Find the age band with the highest attrition rate among employees with a specific educationlevel--
SELECT age_band , 
       CAST(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5, 2)) AS attrition_rate
FROM EmployeeDetails
GROUP BY age_band ;
--Q9:Find the education level with the highest average job satisfaction among employees who travel frequently--
SELECT education, AVG(job_satisfaction) AS avg_job_satisfaction
FROM EmployeeDetails
WHERE business_travel ='Travel_Frequently'
GROUP BY education
ORDER BY avg_job_satisfaction DESC;
--Q10: Identify the age band with the highest average job satisfaction among married employee--
SELECT age ,avg(job_satisfaction) as avg_job_satisfaction
FROM EmployeeDetails
WHERE marital_status ='Married'
GROUP BY age
ORDER BY avg_job_satisfaction DESC;










