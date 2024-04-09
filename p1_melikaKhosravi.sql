create table Employee(
emp_id int primary key,
first_name varchar(25) not null,
last_name varchar(30) not null,
birth_date varchar(12),
sex varchar(1),
salary int,
super_id int,
branch_id int
);

alter table Employee add foreign key(super_id) references Employee(emp_id) on delete cascade;
alter table Employee add foreign key(branch_id) references Branch(branch_id) on delete cascade;


insert into Employee(emp_id,first_name,last_name,birth_date,sex,salary) values(100,'David','Wallace','1967-11-17','M',250000);
insert into Employee(emp_id,first_name,last_name,birth_date,sex,salary) values(101,'Javid','Levinson','1961-05-11','F',110000);
insert into Employee(emp_id,first_name,last_name,birth_date,sex,salary) values(102,'Michael','Scott','1964-03-15','M',75000);
insert into Employee(emp_id,first_name,last_name,birth_date,sex,salary) values(103,'Angela','Martin','1971-06-25','F',63000);
insert into Employee(emp_id,first_name,last_name,birth_date,sex,salary) values(104,'Kelly','Kapoor','1980-02-05','F',55000);
insert into Employee(emp_id,first_name,last_name,birth_date,sex,salary) values(105,'Stanley','Hudson','1958-02-19','M',69000);
insert into Employee(emp_id,first_name,last_name,birth_date,sex,salary) values(106,'Josh','Porter','1969-09-05','M',78000);
insert into Employee(emp_id,first_name,last_name,birth_date,sex,salary) values(107,'Andy','Bernard','1978-07-22','M',65000);
insert into Employee(emp_id,first_name,last_name,birth_date,sex,salary) values(108,'Jim','Halpert','1978-10-01','M',71000);


create table Branch(
branch_id int primary key,
branch_name varchar(25),
mgr_id int,
mgr_start_date varchar(12),
foreign key(mgr_id) references Employee(emp_id)
);


update Employee set branch_id=1 where emp_id=100;
update Employee set super_id=100 ,branch_id=1 where emp_id=101;
update Employee set super_id=100 ,branch_id=2 where emp_id=102;
update Employee set super_id=102 ,branch_id=2 where emp_id=103;
update Employee set super_id=102 ,branch_id=2 where emp_id=104;
update Employee set super_id=102 ,branch_id=2 where emp_id=105;
update Employee set super_id=100 ,branch_id=3 where emp_id=106;
update Employee set super_id=106 ,branch_id=3 where emp_id=107;
update Employee set super_id=106 ,branch_id=3 where emp_id=108;

select *
from Branch;

create table Branch(
branch_id int primary key,
branch_name varchar(25),
mgr_id int,
mgr_start_date varchar(12),
foreign key(mgr_id) references Employee(emp_id)
);

describe Branch;

insert into Branch(branch_id,branch_name,mgr_id,mgr_start_date) values (1,'Corporate',100,'2006-02-09');
insert into Branch(branch_id,branch_name,mgr_id,mgr_start_date) values (2,'Scranton',102,'1992-04-06');
insert into Branch(branch_id,branch_name,mgr_id,mgr_start_date) values (3,'Stamford',106,'1998-02-13');




create table clieent(
client_id int primary key,
client_name varchar(30),
branch_id int ,
foreign key(branch_id) references Branch(branch_id) on delete cascade
);

insert into clieent(client_id,client_name,branch_id)values(400,'Dunmore Highschool',2);
insert into clieent(client_id,client_name,branch_id)values(401,'Lackawana Country',2);
insert into clieent(client_id,client_name,branch_id)values(402,'FedEx',3);
insert into clieent(client_id,client_name,branch_id)values(403,'John Daly Law,LLC',3);
insert into clieent(client_id,client_name,branch_id)values(404,'Scranton Whitepages',2);
insert into clieent(client_id,client_name,branch_id)values(405,'Times Newspaper',3);
insert into clieent(client_id,client_name,branch_id)values(406,'FedEx',2);


create table Works_with(
emp_id int,
client_id int,
total_sales int,
primary key(emp_id,client_id)
);
alter table Works_with add foreign key(emp_id) references Employee(emp_id)on delete cascade;
alter table Works_with add foreign key(client_id) references clieent(client_id)on delete cascade;

insert into Works_with(emp_id,client_id,total_sales) values (105,400,55000);
insert into Works_with(emp_id,client_id,total_sales) values (102,401,267000);
insert into Works_with(emp_id,client_id,total_sales) values (108,402,22500);
insert into Works_with(emp_id,client_id,total_sales) values (107,403,5000);
insert into Works_with(emp_id,client_id,total_sales) values (108,403,12000);
insert into Works_with(emp_id,client_id,total_sales) values (105,404,33000);
insert into Works_with(emp_id,client_id,total_sales) values (107,405,26000);
insert into Works_with(emp_id,client_id,total_sales) values (102,406,15000);
insert into Works_with(emp_id,client_id,total_sales) values (105,406,130000);



create table Branch_supplier(
branch_id int,
supplier_name varchar(30),
supply_type varchar(30),
primary key(branch_id,supplier_name)
);
alter table Branch_supplier add foreign key(branch_id) references Branch(branch_id) on delete cascade;


insert into Branch_supplier(branch_id,supplier_name,supply_type) values (2,'Hammer Mill',130000);
insert into Branch_supplier(branch_id,supplier_name,supply_type) values (2,'Uni-ball',130000);
insert into Branch_supplier(branch_id,supplier_name,supply_type) values (3,'Patriot paper',130000);
insert into Branch_supplier(branch_id,supplier_name,supply_type) values (2,'J.T. Forms & Labels',130000);
insert into Branch_supplier(branch_id,supplier_name,supply_type) values (3,'Uni-ball',130000);
insert into Branch_supplier(branch_id,supplier_name,supply_type) values (3,'Hammer Mill',130000);
insert into Branch_supplier(branch_id,supplier_name,supply_type) values (3,'Stamford Labels',130000);

describe Works_with;





select *
from Employee
order by salary desc ; 


select *
from Employee
limit 5;


select first_name as forname,last_name as surname
from Employee;


select branch_id , count(branch_id)
from Employee
group by branch_id;

select client_id
from Branch natural join clieent
where mgr_id=102
;

select first_name , last_name,emp_id,sum(total_sales) as total
from Employee natural join Works_with
group by emp_id
having total>30000;


select first_name , last_name
from Employee 
where emp_id in (select emp_id 
from Works_with
group by emp_id
having sum(total_sales)>30000 );

select emp_id ,sum(total_sales) as total
from Works_with
group by emp_id
having total>30000;


SELECT *
FROM employee
WHERE sex = 'F' AND birth_date > '1970-01-01';


select emp_id, first_name, last_name, birth_date, sex, salary, super_id, branch.branch_id, branch_name, mgr_start_date
from Employee join branch
on emp_id=mgr_id;

select first_name,last_name,branch_name
FROM employee LEFT JOIN branch
ON emp_id=mgr_id;


select * from employee
where super_id is NULL;

