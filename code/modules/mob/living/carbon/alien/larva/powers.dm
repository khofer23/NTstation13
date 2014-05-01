/mob/living/carbon/alien/larva/verb/hide()
	set name = "Hide"
	set desc = "Allows to hide beneath tables or certain items. Toggled on or off."
	set category = "Alien"

	if(stat != CONSCIOUS)
		return

	if (layer != TURF_LAYER+0.2)
		layer = TURF_LAYER+0.2
		src << text("<span class='green'>You are now hiding.</span>")
		for(var/mob/O in oviewers(src, null))
			if ((O.client && !( O.blinded )))
				O << text("<B>[] scurries to the ground!</B>", src)
	else
		layer = MOB_LAYER
		src << text("<span class='green'>You have stopped hiding.</span>")
		for(var/mob/O in oviewers(src, null))
			if ((O.client && !( O.blinded )))
				O << text("[] slowly peeks up from the ground...", src)

/mob/living/carbon/alien/larva/verb/evolve()
	set name = "Evolve"
	set desc = "Evolve into a fully grown Alien."
	set category = "Alien"

	if(stat != CONSCIOUS)
		return

	if(handcuffed || legcuffed)
		src << "<span class='warning>You cannot evolve when you are cuffed.</span>"

	if(amount_grown >= max_grown)	//TODO ~Carn
		//green is impossible to read, so i made these blue and changed the formatting slightly
		src << "<span class='notice'><b>You are growing into a beautiful alien! It is time to choose a caste.</b></span>"
		src << "<span class='notice'>There are three to choose from:</span>"
		src << "<B>Hunters</B> <span class='notice'>are strong and agile, able to hunt away from the hive and rapidly move through ventilation shafts. Hunters generate plasma slowly and have low reserves.</span>"
		src << "<B>Sentinels</B> <span class='notice'>are tasked with protecting the hive and are deadly up close and at a range. They are not as physically imposing nor fast as the hunters.</span>"
		src << "<B>Drones</B> <span class='notice'>are the working class, offering the largest plasma storage and generation. They are the only caste which may evolve again, turning into the dreaded alien queen.</span>"
		var/alien_caste = alert(src, "Please choose which alien caste you shall belong to.",,"Hunter","Sentinel","Drone")

		var/mob/living/carbon/alien/humanoid/new_xeno
		switch(alien_caste)
			if("Hunter")
				new_xeno = new /mob/living/carbon/alien/humanoid/hunter(loc)
			if("Sentinel")
				new_xeno = new /mob/living/carbon/alien/humanoid/sentinel(loc)
			if("Drone")
				new_xeno = new /mob/living/carbon/alien/humanoid/drone(loc)
		if(mind)	mind.transfer_to(new_xeno)
		qdel(src)
		return
	else
		src << "<span class='warning'>You are not fully grown.</span>"
		return
