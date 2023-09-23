; -------------------------------------
; ------Various Objects Needed --------
; -------------------------------------

(deftemplate Vacation (slot vacation))
(deftemplate Weather (slot weather))
(deftemplate Active (slot active)) ; активный отдых?
(deftemplate Relax (slot relax)) ; выбор отдыха?
(deftemplate Instructor (slot instructor))
(deftemplate Equipment (slot equipment))
(deftemplate Route (slot route))
(deftemplate Tickets (slot tickets))
(deftemplate Room (slot room))
(deftemplate Table (slot table))
(deftemplate People (slot people))
(deftemplate Spa (slot spa))


; ------------------------
; ------INPUT-------------
; ------------------------

(defrule GetVacation
   (declare (salience 800))
   =>
   (printout t "Choose your type of vacation (Enter 'Mountain' or 'Beach'): ") 
   (bind ?response (read))
   (bind ?response (lowcase ?response))
   (assert (Vacation (vacation ?response))))

(defrule GetWeather
   (declare (salience 780))
   =>
   (printout t "Choose the weather (Enter 'Good' or 'Bad'): ") 
   (bind ?response (read))
   (bind ?response (lowcase ?response))
   (assert (Weather (weather ?response))))

(defrule GetActive
   (Vacation (vacation mountain))
   (Weather (weather good))
   =>
   (printout t "Choose the active (Enter 'yes' or 'no'): ") 
   (bind ?response (read))
   (bind ?response (lowcase ?response))
   (assert (Active (active ?response))))

(defrule GetRelax1
   (Active (active yes))
   =>
   (printout t "Choose the relax (Enter 'Hike' or 'Cycling'): ") 
   (bind ?response (read))
   (bind ?response (lowcase ?response))
   (assert (Relax (relax ?response))))

(defrule GetRelax2
   (Active (active no))
   =>
   (printout t "Choose the relax (Enter 'Outdoor Museum' or 'Observation tower'): ") 
   (bind ?response (read))
   (bind ?response (lowcase ?response))
   (assert (Relax (relax ?response))))

(defrule GetInstructor
   (Relax (relax hike))
   =>
   (printout t "Choose whether there is an instructor (Enter 'yes' or 'no'): ") 
   (bind ?response (read))
   (bind ?response (lowcase ?response))
   (assert (Instructor (instructor ?response))))

(defrule GetEquipment
   (Instructor (instructor yes))
   =>
   (printout t "Choose whether there is equipment (Enter 'yes' or 'no'): ") 
   (bind ?response (read))
   (bind ?response (lowcase ?response))
   (assert (Equipment (equipment ?response))))

(defrule GetRoute
   (Relax (relax cycling))
   =>
   (printout t "Choose whether you want an easy route (Enter 'yes' or 'no'): ") 
   (bind ?response (read))
   (bind ?response (lowcase ?response))
   (assert (Route (route ?response))))

(defrule GetRoom
   (Vacation (vacation mountain))
   (Weather (weather bad))
   =>
   (printout t "Choose an activity in the room (Enter 'Museum' or 'Restaurant'): ") 
   (bind ?response (read))
   (bind ?response (lowcase ?response))
   (assert (Room (room ?response))))

(defrule GetTickets
   (or (Room (room museum))
       (Relax (relax outdoor)))
   =>
   (printout t "Choose whether there are tickets (Enter 'yes' or 'no'): ") 
   (bind ?response (read))
   (bind ?response (lowcase ?response))
   (assert (Tickets (tickets ?response))))

(defrule GetTable
   (Room (room restaurant))
   =>
   (printout t "Choose whether there are available tables (Enter 'yes' or 'no'): ") 
   (bind ?response (read))
   (bind ?response (lowcase ?response))
   (assert (Table (table ?response))))

(defrule GetPeople
   (Vacation (vacation beach))
   (Weather (weather good))
   =>
   (printout t "Choose if there are a lot of people on the beach (Enter 'yes' or 'no'): ") 
   (bind ?response (read))
   (bind ?response (lowcase ?response))
   (assert (People (people ?response))))

(defrule GetSpa
   (Vacation (vacation beach))
   (Weather (weather bad))
   =>
   (printout t "Choose whether there is an appointment for spa treatments (Enter 'yes' or 'no'): ") 
   (bind ?response (read))
   (bind ?response (lowcase ?response))
   (assert (Spa (spa ?response))))

; ---------------------------
; --------RULES--------------
; ---------------------------

(defrule PostponeHike
   (or (Instructor (instructor no))
       (Equipment (equipment no)))
   =>
   (printout t "Postpone the hike" crlf))

(defrule GoHiking
   (Equipment (equipment yes))
   =>
   (printout t "Go hiking" crlf))


(defrule EasyRouteCycling
   (Route (route yes))
   =>
   (printout t "Easy trails and dirt roads" crlf))

(defrule DifficultRouteCycling
   (Route (route no))
   =>
   (printout t "Challenging mountain trails" crlf))

(defrule ObservationTower
   (Relax (relax observation))
   ; (test (str-compare "Observation tower" ?value))
   =>
   (printout t "Hike to the observation tower" crlf))

(defrule GoMuseum
   (Tickets (tickets yes))
   =>
   (printout t "Going to the museum" crlf))

(defrule ChooseAnotherMuseum
   (Tickets (tickets no))
   =>
   (printout t "Choose another museum" crlf))

(defrule GoRestaurant
   (Table (table yes))
   =>
   (printout t "Going to a restaurant" crlf))

(defrule ChooseAnotheRestaurant
   (Table (table no))
   =>
   (printout t "Choose another restaurant" crlf))

(defrule GoBeach
   (People (people no))
   =>
   (printout t "Go to the beach" crlf))

(defrule ChooseAnotheBeach
    (People (people yes))
   =>
   (printout t "Go to another beach" crlf))

(defrule GoSpa
   (Spa (spa yes))
   =>
   (printout t "Go to the spa" crlf))

(defrule ChooseAnotheSpa
   (Spa (spa no))
   =>
   (printout t "Choose another spa" crlf))