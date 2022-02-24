
/*
1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
*/

SELECT `students`.*, `degrees`.`name` AS 'degree_name' 
FROM `students`
INNER JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id`
WHERE degrees.name = 'Corso di Laurea in Economia';

/*
2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
*/

SELECT `degrees`.*, `departments`.`name` AS 'department_name'
FROM `degrees`
INNER JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
WHERE `departments`.`name` = 'Dipartimento di Neuroscienze';


/*
3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
*/

SELECT `courses`.*, CONCAT(`teachers`.`name`," ",`teachers`.`surname`) AS `teacher_fullname`
FROM `courses`
INNER JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
INNER JOIN `teachers` ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `teachers`.`name` = 'Fulvio'
AND `teachers`.`surname` = 'Amato';
 


/*
4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il
relativo dipartimento, in ordine alfabetico per cognome e nome
*/

SELECT `students`.surname, `students`.name, `students`.registration_number, `degrees`.*, `departments`.`name` as 'department'
FROM `students`
INNER JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id`
INNER JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
ORDER BY `students`.`surname`, `students`.`name` ASC;



/*
5. Selezionare tutti i corsi di laurea con i relativi corsi ed insegnanti
*/

SELECT `degrees`.`name`, `degrees`.`level`, `courses`.`name`, `courses`.`year`, CONCAT(`teachers`.`surname`," ",`teachers`.`name`) as `teacher_fullname`
FROM `degrees`
INNER JOIN `courses` ON `courses`.`degree_id` = `degrees`.`id`
INNER JOIN `course_teacher` ON `course_teacher`.`course_id` = `courses`.`id`
INNER JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id`
ORDER BY `degrees`.`name`, `courses`.`year` ASC;




/*
6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
*/
SELECT CONCAT(`teachers`.`surname`," ",`teachers`.`name`) as `teacher_fullname`, `departments`.`name`
FROM `teachers`
INNER JOIN `course_teacher` ON `teachers`.`id` = `course_teacher`.`teacher_id`
INNER JOIN `courses` ON `course_teacher`.`course_id` = `courses`.`id`
INNER JOIN `degrees` ON `courses`.`degree_id` = `degrees`.`id`
INNER JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
WHERE `departments`.`name` = 'Dipartimento di Matematica'
ORDER BY `teachers`.`surname`, `teachers`.`name` ASC;




/*
7. BONUS:  Selezionare per ogni studente quanti tentativi di esame ha sostenuto per superare ciascuno
dei suoi esami
*/

SELECT CONCAT(`students`.`surname`," ",`students`.`name`) as `student_fullname`,  `exam_student`.`exam_id`, COUNT(`exam_student`.`vote`) AS `attempts`, MAX(`exam_student`.`vote`) AS "max_vote"
FROM `students`
INNER JOIN `exam_student` ON `students`.`id` = `exam_student`.`student_id`
INNER JOIN `exams` ON `exam_student`.`exam_id` = `exams`.`id`
GROUP BY `exam_student`.`student_id`, `exams`.`course_id`
HAVING  `max_vote` >= 18;

