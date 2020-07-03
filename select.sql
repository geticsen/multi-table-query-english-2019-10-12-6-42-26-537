# 1.Query the existence of 1 course
select * from student where id in (select studentId from student_course where courseId = 1);

# 2.Query the presence of both 1 and 2 courses
select * from student where id in (select t1.studentId from 
(select studentId from student_course where courseId = 1) as t1,  
(select studentId from student_course where courseId = 2) as t2 
where t1.studentId = t2.studentId);

# 3.Query the student number and student name and average score of students whose average score is 60 or higher.
SELECT student.id, student.name,AVG(student_course.score) AS avg FROM student_course, student
WHERE student.id = student_course.studentId
GROUP BY student_course.studentId HAVING avg>=60

# 4.Query the SQL statement of student information that does not have grades in the student_course table
select * from student where id not in (select DISTINCT studentId from student_course);

# 5.Query all SQL with grades
select * from student_course;

# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2
select * from student where id in
(select t1.studentId from (select * from student_course where courseId = 1) as t1,
(select studentId from student_course where courseId = 2) as t2 
where t1.studentId = t2.studentId);

# 7.Retrieve 1 student score with less than 60 scores in descending order
select * from student where id in(select  DISTINCT studentId from student_course where score<60 order by score desc);

# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.
SELECT courseId, AVG(score) as a FROM student_course GROUP BY courseId ORDER BY a DESC, courseId ASC;

# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60
select t2.name,t1.score from 
(select * from student_course where courseId = (SELECT id from course where `name` = "Math") and score<60) as t1
,(select * from student) as t2 where t1.studentId = t2.id;
