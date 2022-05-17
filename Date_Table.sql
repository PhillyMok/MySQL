SELECT 
*
 FROM (
/*NEXT*/
select
n.c_next_date as n_date,
LPAD(YEAR(n.c_next_date),4,0) as n_year,
LPAD(MONTH(n.c_next_date),2,0) as n_month,
MONTHNAME(n.c_next_date) as n_month_name,
lpad(quarter(n.c_next_date),2,0) as n_quarter,
MAKEDATE(YEAR(DATE_ADD(n.c_next_date, INTERVAL -1 DAY)), 1) + INTERVAL QUARTER(DATE_ADD(n.c_next_date, INTERVAL -1 DAY)) QUARTER - INTERVAL 1 QUARTER as n_quarter_start_date,
LPAD(DAY(n.c_next_date),2,0) as n_day_of_month,
DAYNAME(n.c_next_date) as n_day_name,
LPAD(DAYOFWEEK(n.c_next_date),2,0) as n_day_of_week,
LPAD(DAYOFYEAR(n.c_next_date),3,0) AS n_day_of_year,
CASE WHEN LPAD(WEEK(n.c_next_date),2,0) = 00 THEN 52
ELSE LPAD(WEEK(n.c_next_date),2,0) END as n_week,
DATE_ADD(n.c_next_date, INTERVAL(1-DAYOFWEEK(n.c_next_date)) DAY) as n_firstdayofweek,
LPAD(YEAR(DATE_ADD(n.c_next_date, INTERVAL(1-DAYOFWEEK(n.c_next_date)) DAY)),4,0) as n_firstdayofweekyear,
LPAD(MONTH(DATE_ADD(n.c_next_date, INTERVAL(1-DAYOFWEEK(n.c_next_date)) DAY)),2,0) as n_firstdayofweekmonth,
LPAD(DAY(DATE_ADD(n.c_next_date, INTERVAL(1-DAYOFWEEK(n.c_next_date)) DAY)),2,0) as n_firstdayofweekday,
DATE_ADD(n.c_next_date, INTERVAL(7-DAYOFWEEK(n.c_next_date)) DAY) as n_lastdayofweek,
LPAD(YEAR(DATE_ADD(n.c_next_date, INTERVAL(7-DAYOFWEEK(n.c_next_date)) DAY)),4,0) as n_lastdayofweekyear,
LPAD(MONTH(DATE_ADD(n.c_next_date, INTERVAL(7-DAYOFWEEK(n.c_next_date)) DAY)),2,0) as n_lastdayofweekmonth,
LPAD(DAY(DATE_ADD(n.c_next_date, INTERVAL(7-DAYOFWEEK(n.c_next_date)) DAY)),2,0) as n_lastdayofweekday,
CASE WHEN DAYNAME(DATE_ADD(n.c_next_date, INTERVAL 0 DAY)) IN ('Sunday', 'Saturday') THEN 'Weekend'
WHEN DAYNAME(DATE_ADD(n.c_next_date, INTERVAL 0 DAY)) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 'Weekday'
END AS n_weekendorweekday,
CASE WHEN DAYNAME(DATE_ADD(n.c_next_date, INTERVAL 0 DAY)) IN ('Sunday', 'Saturday') THEN 1
ELSE '0' END AS n_weekend_count,
CASE WHEN DAYNAME(DATE_ADD(n.c_next_date, INTERVAL 0 DAY)) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 1
ELSE '0' END AS n_workday_count,
'1'AS n_day_count,
CASE
WHEN substring(DATE_ADD(n.c_next_date, INTERVAL 0 DAY),6,2) = 01 
AND substring(DATE_ADD(n.c_next_date, INTERVAL 0 DAY),9,2) = 01 THEN 'New Years Day'
WHEN substring(DATE_ADD(n.c_next_date, INTERVAL 0 DAY),6,2) = 12 
AND substring(DATE_ADD(n.c_next_date, INTERVAL 0 DAY),9,2) = 25 THEN 'Christmas Day'
ELSE 'Regular Day'
END AS n_holiday,
DATE_ADD(n.c_next_date, INTERVAL -1 DAY) AS n_previous_date,
DATE_ADD(n.c_next_date, INTERVAL 1 DAY) AS n_next_date,
n.*

from (
/*PREVIOUS*/
select 
p.c_previous_date as p_date,
LPAD(YEAR(p.c_previous_date),4,0) as p_year,
LPAD(MONTH(p.c_previous_date),2,0) as p_month,
MONTHNAME(p.c_previous_date) as p_month_name,
lpad(quarter(p.c_previous_date),2,0) as p_quarter,
MAKEDATE(YEAR(DATE_ADD(p.c_previous_date, INTERVAL -1 DAY)), 1) + INTERVAL QUARTER(DATE_ADD(p.c_previous_date, INTERVAL -1 DAY)) QUARTER - INTERVAL 1 QUARTER as p_quarter_start_date,
LPAD(DAY(p.c_previous_date),2,0) as p_day_of_month,
DAYNAME(p.c_previous_date) as p_day_name,
LPAD(DAYOFWEEK(p.c_previous_date),2,0) as p_day_of_week,
LPAD(DAYOFYEAR(p.c_previous_date),3,0) AS p_day_of_year,
CASE WHEN LPAD(WEEK(p.c_previous_date),2,0) = 00 THEN 52
ELSE LPAD(WEEK(p.c_previous_date),2,0) END as p_week,

DATE_ADD(p.c_previous_date, INTERVAL(1-DAYOFWEEK(p.c_previous_date)) DAY) as p_firstdayofweek,
LPAD(YEAR(DATE_ADD(p.c_previous_date, INTERVAL(1-DAYOFWEEK(p.c_previous_date)) DAY)),4,0) as p_firstdayofweekyear,
LPAD(MONTH(DATE_ADD(p.c_previous_date, INTERVAL(1-DAYOFWEEK(p.c_previous_date)) DAY)),2,0) as p_firstdayofweekmonth,
LPAD(DAY(DATE_ADD(p.c_previous_date, INTERVAL(1-DAYOFWEEK(p.c_previous_date)) DAY)),2,0) as p_firstdayofweekday,
DATE_ADD(p.c_previous_date, INTERVAL(7-DAYOFWEEK(p.c_previous_date)) DAY) as p_lastdayofweek,
LPAD(YEAR(DATE_ADD(p.c_previous_date, INTERVAL(7-DAYOFWEEK(p.c_previous_date)) DAY)),4,0) as p_lastdayofweekyear,
LPAD(MONTH(DATE_ADD(p.c_previous_date, INTERVAL(7-DAYOFWEEK(p.c_previous_date)) DAY)),2,0) as p_lastdayofweekmonth,
LPAD(DAY(DATE_ADD(p.c_previous_date, INTERVAL(7-DAYOFWEEK(p.c_previous_date)) DAY)),2,0) as p_lastdayofweekday,

CASE WHEN DAYNAME(DATE_ADD(p.c_previous_date, INTERVAL 0 DAY)) IN ('Sunday', 'Saturday') THEN 'Weekend'
WHEN DAYNAME(DATE_ADD(p.c_previous_date, INTERVAL 0 DAY)) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 'Weekday'
END AS p_weekendorweekday,
CASE WHEN DAYNAME(DATE_ADD(p.c_previous_date, INTERVAL 0 DAY)) IN ('Sunday', 'Saturday') THEN 1
ELSE '0' END AS p_weekend_count,
CASE WHEN DAYNAME(DATE_ADD(p.c_previous_date, INTERVAL 0 DAY)) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 1
ELSE '0' END AS p_workday_count,
'1'AS p_day_count,
CASE
WHEN substring(DATE_ADD(p.c_previous_date, INTERVAL 0 DAY),6,2) = 01 
AND substring(DATE_ADD(p.c_previous_date, INTERVAL 0 DAY),9,2) = 01 THEN 'New Years Day'
WHEN substring(DATE_ADD(p.c_previous_date, INTERVAL 0 DAY),6,2) = 12 
AND substring(DATE_ADD(p.c_previous_date, INTERVAL 0 DAY),9,2) = 25 THEN 'Christmas Day'
ELSE 'Regular Day'
END AS p_holiday,
DATE_ADD(p.c_previous_date, INTERVAL -1 DAY) AS p_previous_date,
DATE_ADD(p.c_previous_date, INTERVAL 1 DAY) AS p_next_date,
p.*

from(
/*CURRENT*/
SELECT 
DATE_ADD(gen_date, INTERVAL 0 DAY) AS c_date,
LPAD(YEAR(DATE_ADD(gen_date, INTERVAL 0 DAY)),4,0) as c_year,
LPAD(MONTH(DATE_ADD(gen_date, INTERVAL 0 DAY)),2,0) as c_month,
monthname(DATE_ADD(gen_date, INTERVAL 0 DAY))  as c_month_name,
lpad(quarter(DATE_ADD(gen_date, INTERVAL 0 DAY)),2,0) as c_quarter, 
MAKEDATE(YEAR(DATE_ADD(gen_date, INTERVAL 0 DAY)), 1) + INTERVAL QUARTER(DATE_ADD(gen_date, INTERVAL 0 DAY)) QUARTER - INTERVAL 1 QUARTER as c_quarter_start_date,
LPAD(DAY(DATE_ADD(gen_date, INTERVAL 0 DAY)),2,0) as c_day_of_month,
DAYNAME(DATE_ADD(gen_date, INTERVAL 0 DAY)) as c_day_name,
LPAD(DAYOFWEEK(DATE_ADD(gen_date, INTERVAL 0 DAY)),2,0) as c_day_of_week,
LPAD(DAYOFYEAR(DATE_ADD(gen_date, INTERVAL 0 DAY)),3,0) AS c_day_of_year,
CASE WHEN LPAD(WEEK(DATE_ADD(gen_date, INTERVAL 0 DAY)),2,0) = 00 THEN 52
ELSE LPAD(WEEK(DATE_ADD(gen_date, INTERVAL 0 DAY)),2,0) END as c_week,
DATE_ADD(gen_date, INTERVAL(1-DAYOFWEEK(gen_date)) DAY) as c_firstdayofweek,
LPAD(YEAR(DATE_ADD(gen_date, INTERVAL(1-DAYOFWEEK(gen_date)) DAY)),4,0) as c_firstdayofweekyear,
LPAD(MONTH(DATE_ADD(gen_date, INTERVAL(1-DAYOFWEEK(gen_date)) DAY)),2,0) as c_firstdayofweekmonth,
LPAD(DAY(DATE_ADD(gen_date, INTERVAL(1-DAYOFWEEK(gen_date)) DAY)),2,0) as c_firstdayofweekday,
DATE_ADD(gen_date, INTERVAL(7-DAYOFWEEK(gen_date)) DAY) as c_lastdayofweek,
LPAD(YEAR(DATE_ADD(gen_date, INTERVAL(7-DAYOFWEEK(gen_date)) DAY)),4,0) as c_lastdayofweekyear,
LPAD(MONTH(DATE_ADD(gen_date, INTERVAL(7-DAYOFWEEK(gen_date)) DAY)),2,0) as c_lastdayofweekmonth,
LPAD(DAY(DATE_ADD(gen_date, INTERVAL(7-DAYOFWEEK(gen_date)) DAY)),2,0) as c_lastdayofweekday,
CASE WHEN DAYNAME(DATE_ADD(gen_date, INTERVAL 0 DAY)) IN ('Sunday', 'Saturday') THEN 'Weekend'
WHEN DAYNAME(DATE_ADD(gen_date, INTERVAL 0 DAY)) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 'Weekday'
END AS c_weekendorweekday,
CASE WHEN DAYNAME(DATE_ADD(gen_date, INTERVAL 0 DAY)) IN ('Sunday', 'Saturday') THEN 1
ELSE '0' END AS c_weekend_count,
CASE WHEN DAYNAME(DATE_ADD(gen_date, INTERVAL 0 DAY)) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 1
ELSE '0' END AS c_workday_count,
'1'AS c_day_count,
CASE
WHEN substring(DATE_ADD(gen_date, INTERVAL 0 DAY),6,2) = 01 
AND substring(DATE_ADD(gen_date, INTERVAL 0 DAY),9,2) = 01 THEN 'New Years Day'
WHEN substring(DATE_ADD(gen_date, INTERVAL 0 DAY),6,2) = 12 
AND substring(DATE_ADD(gen_date, INTERVAL 0 DAY),9,2) = 25 THEN 'Christmas Day'
ELSE 'Regular Day'
END AS c_holiday,
DATE_ADD(gen_date, INTERVAL -1 DAY) AS c_previous_date,
DATE_ADD(gen_date, INTERVAL 1 DAY) AS c_next_date
from 
	(select adddate('2013-12-29',t4*10000 + t3*1000 + t2*100 + t1*10 + t0) gen_date from
	(select 0 t0 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
	(select 0 t1 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
	(select 0 t2 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
	(select 0 t3 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
	(select 0 t4 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v
where gen_date between '2013-12-29' and '2024-12-31'
)p
)n
)a