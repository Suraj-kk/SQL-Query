select top 5 * from returns;
select top 5 * from orders; 

--1- write a query to get region wise count of return orders
select o.region,count(distinct o.order_id) return_orders from orders o 
inner join returns r
on o.order_id = r.[Order Id]
group by o.region

--2-write a query to get category wise sales of orders that were not returned
select o.category,sum(o.sales) total_sales from orders o
left join returns r
on o.order_id = r.[Order Id]
where r.[Return Reason] is not null 
group by o.category;

select o.category,sum(o.sales) total_sales from orders o
left join returns r
on o.order_id = r.[Order Id]
where r.[Return Reason] is  null 
group by o.category;

create table employee(
    emp_id int,
    emp_name varchar(20),
    dept_id int,
    salary int,
    manager_id int,
    emp_age int
);
insert into employee values(1,'Ankit',100,10000,4,39);
insert into employee values(2,'Mohit',100,15000,5,48);
insert into employee values(3,'Vikas',100,10000,4,37);
insert into employee values(4,'Rohit',100,5000,2,16);
insert into employee values(5,'Mudit',200,12000,6,55);
insert into employee values(6,'Agam',200,12000,2,14);
insert into employee values(7,'Sanjay',200,9000,2,13);
insert into employee values(8,'Ashish',200,5000,2,12);
insert into employee values(9,'Mukesh',300,6000,6,51);
insert into employee values(10,'Rakesh',500,7000,6,50);
select * from employee;

create table dept(
    dep_id int,
    dep_name varchar(20)
);
insert into dept values(100,'Analytics');
insert into dept values(200,'IT');
insert into dept values(300,'HR');
insert into dept values(400,'Text Analytics');
select * from dept;
select * from employee;

--3- write a query to print dep name and average salary of employees in that dep .
select d.dep_name,avg(e.salary) from employee e 
inner join dept d
on d.dep_id=e.dept_id
group by d.dep_name

--4- write a query to print dep names where none of the emplyees have same salary.
select d.dep_name from employee e
inner join dept d
on d.dep_id=e.dept_id
group by d.dep_name
having count(e.salary) = 1;

select d.dep_name
from employee e
inner join dept d on e.dept_id=d.dep_id
group by d.dep_name
having count(e.emp_id)=count(distinct e.salary)

--5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)

select distinct o.sub_category from orders o 
inner join returns r
on o.order_id = r.[Order Id]
group by o.sub_category,r.[Return Reason]
having r.[Return Reason] = 'Others' or r.[Return Reason] = 'Bad Quality' or  r.[Return Reason] ='Wrong Items';


select distinct o.sub_category from orders o 
join
returns r on o.order_id = r.[Order Id]
--order by o.sub_category,r.[Return Reason]
group by o.sub_category
having count (distinct r.[Return Reason])=3



--6- write a query to find cities where not even a single order was returned.
select city from orders o 
left join returns r 
on o.order_id = r.[Order Id]
group by city,r.[Return Reason]
having r.[Return Reason] is null;

select o.city
from orders o
left join returns r on o.order_id=r.[Order Id]
group by city
having count(r.[Order Id]) = 0

--7- write a query to find top 3 subcategories by sales of returned orders in east region
select top 3 o.sub_category,sum(o.sales) total_sales from orders o
inner join returns r
on o.order_id = r.[Order Id]
where o.region = 'East'
group by o.sub_category
order by  total_sales desc

--8- write a query to print dep name for which there is no employee
select * from dept
select * from employee

select d.dep_name from dept d
left join employee e
on d.dep_id = e.dept_id
where e.dept_id is null

select d.dep_id,d.dep_name
from dept d 
left join employee e on e.dept_id=d.dep_id
group by d.dep_id,d.dep_name
having count(e.emp_id)=0;

--9- write a query to print employees name for dep id is not avaiable in dept table
select e.emp_name from dept d
right join employee e
on d.dep_id = e.dept_id
where d.dep_id is null

--or

select e.emp_name from employee e
left join dept d
on d.dep_id = e.dept_id
where d.dep_id is null
