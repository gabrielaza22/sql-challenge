CREATE TABLE "titles" (
    "title_id" VARCHAR(10)   NOT NULL,
    "title" VARCHAR(20)   NOT NULL,
    "last_updated" Timestamp DEFAULT Localtimestamp  NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "salaries" (
    "id" SERIAL   NOT NULL,
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "last_updated" Timestamp DEFAULT Localtimestamp  NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(10)   NOT NULL,
    "birth_date" Timestamp   NOT NULL,
    "first_name" VARCHAR(100)   NOT NULL,
    "last_name" VARCHAR(200)   NOT NULL,
    "sex" VARCHAR(5)   NOT NULL,
    "hire_date" Timestamp   NOT NULL,
    "last_updated" Timestamp DEFAULT Localtimestamp  NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_manager" (
    "id" SERIAL   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" INT   NOT NULL,
    "last_updated" Timestamp DEFAULT Localtimestamp  NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "dept_emp" (
    "id" SERIAL   NOT NULL,
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL,
    "last_updated" Timestamp DEFAULT Localtimestamp  NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "deparments" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(20)   NOT NULL,
    "last_updated" Timestamp DEFAULT Localtimestamp  NOT NULL,
    CONSTRAINT "pk_deparments" PRIMARY KEY (
        "dept_no"
     )
);

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "deparments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "deparments" ("dept_no");


--List the employee number, last name, first name, sex, and salary of each employee
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	e.sex,
	s.salary
	
FROM employees e
join salaries s on s.emp_no = e.emp_no

--List the first name, last name, and hire date for the employees who were hired in 1986

SELECT
e.first_name,
e.last_name,
e.hire_date

FROM employees e
WHERE EXTRACT (YEAR FROM e.hire_date)= 1986

--List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT 
	d.dept_name as departments,
	d.dept_no,
	dm.emp_no,
	e.first_name,
	e.last_name


FROM employees e
   JOIN
   dept_manager as dm
   ON dm.emp_no = e.emp_no
   JOIN
   deparments as d
   ON dm.dept_no = d.dept_no

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT 
	d.dept_no,
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name as departments

FROM employees e
   JOIN
   dept_emp as de
   ON de.emp_no = e.emp_no
   JOIN
   deparments as d
   ON de.dept_no = d.dept_no

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT 
	e.first_name,
	e.last_name,
	e.sex
FROM employees e
WHERE first_name= 'Hercules'
AND last_name like 'B%'


--List each employee in the Sales department, including their employee number, last name, and first name.
	
SELECT 
	d.dept_name as sales_department,
	e.emp_no,
	e.first_name,
	e.last_name


FROM employees e
   JOIN
   dept_emp as de
   ON de.emp_no = e.emp_no
   JOIN
   deparments as d
   ON de.dept_no = d.dept_no
WHERE dept_name= 'Sales'


--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT 
	d.dept_name as departments,
	e.emp_no,
	e.first_name,
	e.last_name


FROM employees e
   JOIN
   dept_emp as de
   ON de.emp_no = e.emp_no
   JOIN
   deparments as d
   ON de.dept_no = d.dept_no
WHERE dept_name= 'Sales'
OR dept_name= 'Development'





