--Q.1
select s.student_name, c.course_name from students s 
join enrollments e on s.student_id = e.student_id 
join courses c on c.course_id = e.course_id order by s.student_name;

--Q.2
INSERT INTO students
(student_id, student_name, student_major)
VALUES(10, 'Sagar', 'Computer Science');


select s.student_name, c.course_name from students s 
left join enrollments e on s.student_id = e.student_id 
left join courses c on c.course_id = e.course_id order by s.student_name;

--Q.3
INSERT INTO courses
(course_id, course_name, course_description)
VALUES(5, 'English', 'Advanced English Grammar');


select s.student_name, c.course_name from students s 
right join enrollments e on s.student_id = e.student_id 
right join courses c on c.course_id = e.course_id order by s.student_name;

--Q.4
SELECT
    (select student_name from students where student_id = e1.student_id),
    (select student_name from students where student_id = e2.student_id),
    c.course_name
FROM
    Enrollments e1
    JOIN Enrollments e2 ON e1.course_id = e2.course_id AND e1.student_id < e2.student_id
    JOIN Courses c ON e1.course_id = c.course_id
ORDER BY
	c.course_name;


--Q.5
SELECT s.student_id, s.student_name
FROM Students s
JOIN Enrollments e1 ON s.student_id = e1.student_id
JOIN Courses c1 ON e1.course_id = c1.course_id
WHERE c1.course_name = 'Introduction to CS'
  AND s.student_id NOT IN (
      SELECT student_id
      FROM Enrollments
      WHERE course_id = (select course_id from courses where course_name = 'Data Structures')
  );


--Q.6
 SELECT
    s.student_name,
    e.course_id ,
    ROW_NUMBER() OVER (ORDER BY e.enrollment_date ASC) AS row_num
FROM
    Enrollments e
    JOIN Students s ON e.student_id = s.student_id
ORDER BY
    e.enrollment_date ASC;
   
   
--Q.7
SELECT
    s.student_id,
    s.student_name,
    COUNT(e.course_id) AS course_count,
    RANK() OVER (ORDER BY COUNT(e.course_id) DESC) AS rank
FROM
    Students s
    JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY
    s.student_id, s.student_name
ORDER BY
    s.student_id;

   
--Q.8
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS enrollment_count,
    DENSE_RANK() OVER (ORDER BY COUNT(e.student_id)) AS dense_rank
FROM
    Courses c
    JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY
    c.course_id, c.course_name
ORDER BY
    dense_rank, c.course_id;