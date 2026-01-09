use `hr analytics`;
select * from `hr_1`;
alter table hr_1 add column Emp_attrition int;
SET SQL_SAFE_UPDATES = 0;
update hr_1 set emp_attrition=case when attrition ="yes" then 1 else 0 end;

-- Q1. Average Attrition rate for all Departments
select department,concat(round(avg(emp_attrition)*100,2),"%") as Average_Rate 
from hr_1 group by department;

-- Q2 Average Hourly rate of Male Research Scientist
select gender,jobrole,concat(round(avg(hourlyrate),2),"%") as hourly_rate 
from hr_1 where gender="Male" and 
jobrole ="Research Scientist";

-- Q3 Attrition rate Vs Monthly income stats

SELECT
    income_bucket,
    concat(ROUND(AVG(Emp_attrition) * 100, 2),"%") AS Average_Rate
FROM (
    SELECT
        CASE
            WHEN hr_2.monthlyincome < 20000 THEN 'Below 20K'
            WHEN hr_2.monthlyincome BETWEEN 20000 AND 40000 THEN '20K+ to 40K'
            ELSE 'Above 40K'
        END AS income_bucket,
        hr_1.Emp_attrition
    FROM hr_1
    JOIN hr_2
      ON hr_1.employeenumber = hr_2.`employee id`
) AS t
GROUP BY income_bucket;

-- Q4 Average working years for each Department

select hr_1.department,round(avg(hr_2.totalworkingyears),2) as `Avg workingyears`
 from hr_1 join hr_2
 on hr_1.employeenumber=hr_2.`employee id` group by department;
 
 -- Q5 Job Role Vs Work life balance
select hr_1.jobrole,round(avg(hr_2.worklifebalance),2) as worklinebalance from hr_1 join hr_2
on hr_1.employeenumber=hr_2.`employee id` group by jobrole;

-- Q6 Attrition rate Vs Year since last promotion relation

select * from hr_2;
select hr_2.yearssincelastpromotion,concat(round(avg(hr_1.emp_attrition)*100,2),"%") as `Attrition Rate` from hr_1 join hr_2
on hr_1.employeenumber=hr_2.`employee id` group by yearssincelastpromotion order by yearssincelastpromotion;