Combat by Monster Framework begins here.

current-monster is a monster that varies.

To check attack of (M - a monster):
	if M is released, now the alert of the player is 1;
	if M is delayed:
		now the last-interaction of M is 1;
		compute correct delay of M;
	otherwise if the paralyze-status of M is 1:
		now the last-interaction of M is 1;
		if a random number between 1 and 2 is 1:
			now the paralyze-status of M is 0;
		compute paralysis of M;
	otherwise:
		compute attack of M.

To compute correct delay of (M - a monster): [Default behaviour of delayed monster]
	if diaper quest is 1, compute DQ delay of M;
	otherwise compute delay of M.

To compute DQ delay of (M - a monster): 
	say "The [M] doesn't do anything, as if waiting to see what you do next.".

To compute delay of (M - a monster):
	say "The [M] doesn't do anything, as if waiting to see what you do next.".
	
To compute paralysis of (M - a monster):
	say "The [M] doesn't seem able to move!";

To compute attack of (M - a monster):
	now current-monster is M;
	if the poison-status of M is 1 and health of M > 1:
		decrease health of M by 4;
		if health of M < 1:
			now health of M is 1;
		if a random number between 1 and 3 is 1:
			now the poison-status of M is 0;
	follow the monster attack rules.

The monster attack rules is a rulebook.
[In each rule in this rulebook, we write 'if the rule succeeded, rule succeeds.'  In this way rule succeeds is used for finishing up completely. Rule fails is used for exiting a rulebook and moving to the next rulebook in the sex rules. Obviously if a rulebook ends with neither, then we also continue as if we had encountered a rule fails.]

Chapter 1 Continue and Finish Sex

This is the continue sex rule:
	follow the continue sex rules of current-monster;
	if the rule succeeded, rule succeeds. 
The continue sex rule is listed last in the monster attack rules. [Listed 1st]

This is the default check for spanking rule:
	if current-monster is spanking the player:
		compute spanking of current-monster;
		rule succeeds.
The default check for spanking rule is listed last in the default continue sex rules.

This is the default check for changing rule:
	if current-monster is changing the player:
		compute diaper change of current-monster;
		rule succeeds.
The default check for changing rule is listed last in the default continue sex rules.

This is the default check for masturbating rule:
	if current-monster is masturbating the player:
		compute masturbation of current-monster;
		rule succeeds.
The default check for masturbating rule is listed last in the default continue sex rules.

This is the default check for enema rule:
	if current-monster is enema-filling the player:
		compute enema of current-monster;
		rule succeeds.
The default check for enema rule is listed last in the default continue sex rules.

This is the default check for feeding rule:
	if current-monster is feeding the player:
		compute forcefeed of current-monster;
		rule succeeds.
The default check for feeding rule is listed last in the default continue sex rules.

This is the default check for sex rule:
	unless current-monster is penetrating a body part, rule fails.
The default check for sex rule is listed last in the default continue sex rules.

This is the default finish sex rule:
	if the rounds of sex left of current-monster <= 0:
		follow the end of sex rules of current-monster;
		orgasm current-monster;
		rule succeeds.
The default finish sex rule is listed last in the default continue sex rules.

[The following rules should be considered BLAND EXAMPLES and if they are called during runtime that is bad because they are boring. Replace either the compute clauses, or the entire end of sex rulebook for any monster you create.]

This is the reset chosen orifice rule:
	now the chosen-orifice of current-monster is nothing.
The reset chosen orifice rule is listed first in the default end of sex rules.

[!<OrgasmMonster>+

This function runs any code that needs to be executed whenever the player finishes having sex with a monster. If the player can have sex without triggering the default finish sex rule for a given monster, this function needs to be called manually.

@param <Monster>:<M> The monster the player just had sex with

+!]
To orgasm (M - a monster):
	if the class of the player is priestess and (the virgin of the player is 0 or the player is male):
		compute priestessBlessing of M;
	if the class of the player is princess, follow the betrothal rule;
	[if there is a held notebook, now study-buddy is M;]
	if M is intelligent, compute refactoryReset of M;
	if there is a worn notebook:
		compute studying 0 of M;
	if the player is in the woods and giant-statue is active:
		say "You feel a strange tingle near the back of your neck, like a lot of pressure lifted all at once.";
		ChargeUp giant-statue by 60;

To compute refactoryReset of (M - a monster):
	now the refactory-period of M is the refactory time of M;
	if there is a worn royal scepter:
		if the charge of a random worn royal scepter > 2, increase the refactory-period of M by (the refactory time of M + 4);
	if there is a worn enhancing book of anal:
		FavourUp M;
		increase the refactory-period of M by the intelligence of the player.

To compute priestessBlessing of (M - a monster):
	say "You can feel a surge in your holy aura and a voice appears in your head: 'Dutiful Sister, there is still more work to be done!'";
	decrease the charge of the dungeon altar by 150.

To say sleeping tip:
	if tutorial is 0, say "[one of][item style]Newbie tip: The enemy has fallen asleep!  However in this game you can't just kill sleeping enemies, you have to attack them like normal. Usually, this results in them waking back up again, so you'll still have a fight on your hands![roman type][line break][or][stopping]".

To compute replacement of (T - a thing) in (O - an orifice):
	unless O is actually occupied or current-monster is not intelligent:
		say "The [current-monster] pushes the [T] back into place in your [variable O].";
		now T is worn by the player;
		now T is penetrating O;
		now current-monster is not retaining T;
		if O is fuckhole, ruin O.

[!<DominateUpMonster>+

With this function, current-monster moves a given piece of clothing back into place

@param <Clothing>:<D> The clothing to be replaced

+!]
To compute replacement of (D - a clothing):
	if current-monster is intelligent:
		if D is worn:
			unless there is a worn tail plug:
				if D is crotch-displaced:
					say "The [current-monster] puts your [ShortDesc of D] back in place before letting you go.";
					replace D;
				otherwise if D is crotch-unzipped:
					say "The [current-monster] zips your [ShortDesc of D] back up before letting you go.";
					now D is crotch-zipped;
		otherwise if D is actually summonable:
			say "The [current-monster] puts you back into your [ShortDesc of D] before letting you go.";
			now D is worn by the player; [If we summon it, it will have all its stats reset.]
		otherwise:
			say "The [current-monster], unable to replace your [D], just drops it onto the ground.";
			now D is in the location of the player;
		now current-monster is not retaining D.

This is the default facial climax rule:
	if current-monster is penetrating face, compute facial climax of current-monster;
	if the sleep of current-monster is 0, replace any gags.
The default facial climax rule is listed in the default end of sex rules.

To replace any gags:
	repeat with G running through ballgags retained by current-monster:
		compute replacement of G in face.

To TimesFuckedUp (M - a monster) by (N - a number):
	DirectTimesFuckedUp M by N.

To DirectTimesFuckedUp (M - a monster) by (N - a number):
	repeat with X running from 1 to N:
		TimesFuckedUp M.

To TimesFuckedUp (M - a monster):
	if M is unfriendly:
		increase the times-fucked of M by 1;
		increase the fucked-count of the player by 1;
	increase the sex-count of the player by 1;
	if there is a worn tethering lipstick collar, end tethering.
	
Definition: a monster (called M) is coercing a swallow:
	if the player is desperate to drink semen, decide yes;
	if a random number between 10 and 20 < the delicateness of the player, decide yes;
	decide no.

[!<OrgasmMonster>+

This function handles the oral "climax" of a monster. By default, this can end in one of four ways. First, a resisting player can escape at the last second, avoiding semen on their face or in their mouth, which should trigger the angry punishment function for this monster. Second, the monster can ejaculate on the player's face. Third, the monster can ejaculate in the player's mouth, prompting them to swallow. If they don't, we should call the angry punishment function. Fourth, the monster can deepthroat the player so they swallow automatically

@param <Monster>:<M> The monster the player just had oral relations with

+!]
To compute facial climax of (M - a monster):
	compute default facial climax for M.

To compute default facial climax for (M - a monster):
	TimesFuckedUp M by 1;
	if bukkake fetish is 1 and M is willing to bukkake:[cumshot outside;TODO "willing to pull out" function for orifices]
		if the reaction of the player is 0:[Player rolls to see if they]
			compute facial dodging of M;
		otherwise: [the player submitted]
			compute facial accepting of M;
	otherwise: [Internal cumshot]
		if the reaction of the player is 0:
			compute oral creampie of M;
		otherwise: [submitted, deepthroat]
			compute deepthroat creampie of M;
	satisfy M.[dislodges him automatically]

[!<OrgasmMonster>+

This function handles the climax of a monster (M) in a given fuckhole (F). First we call TimesFuckedUp for M, then we look at the "unique climax" for M in F, which may be replaced with special functionality depending on the monster. The post climax effect handles anything that should happen after the climax has happened, specific to that monster. Lastly, we dislodge the monster after making sure that the monster actually needs to be dislodged(some monsters might want to go for another round after they climax, and other monsters may have their own rules for making the monster pull out.) Satisfy M makes the monster forgive the player and calls the "dislodge M" function by default.

@param <Monster>:<M> The monster having the climax
@param <Fuckhole>:<F> The fuckhole the monster is having the climax in

+!]
To compute climax of (M - a monster) in (F - a fuckhole):
	TimesFuckedUp M by 1;
	compute unique climax of M in F;
	compute post climax effect of M in F;
	if M is interested and the rounds of sex left of current-monster <= 0:
		satisfy M.

This is the default anal climax rule:
	if current-monster is penetrating asshole, compute anal climax of current-monster;
	if the sleep of current-monster is 0:
		replace any buttplugs;
		replace any diapers.
The default anal climax rule is listed in the default end of sex rules.

To replace any buttplugs:
	repeat with G running through sex toys retained by current-monster:
		unless current-monster is withholding G, compute replacement of G in asshole.
	
To replace any diapers:
	repeat with D running through diapers retained by current-monster:
		unless current-monster is withholding D, compute replacement of D.

To replace any clothes:
	repeat with C running through worn clothing:
		compute replacement of C; [this only does something if it's displaced or unzipped]
	repeat with C running through clothing retained by current-monster:
		unless current-monster is withholding C, compute replacement of C.

To compute anal climax of (M - a monster):
	compute climax of M in asshole.

This is the default vaginal climax rule:
	if current-monster is penetrating vagina, compute vaginal climax of current-monster;
	if the sleep of current-monster is 0:
		replace any cuntplugs;
		replace any diapers.
The default vaginal climax rule is listed in the default end of sex rules.

To replace any cuntplugs:
	repeat with G running through sex toys retained by current-monster:
		compute replacement of G in vagina.

To compute vaginal climax of (M - a monster):
	compute climax of M in vagina.

This is the default cleavage climax rule:
	if current-monster is penetrating breasts, compute cleavage climax of current-monster.
The default cleavage climax rule is listed in the default end of sex rules.

This is the suggestion satisfied rule:
	if current-monster is penetrating face and suggestion-type is 1, now suggestion-tracking is 1;
	if current-monster is penetrating asshole and suggestion-type is 2, now suggestion-tracking is 1;
	if current-monster is penetrating vagina and suggestion-type is 3, now suggestion-tracking is 1;
	if current-monster is penetrating breasts and suggestion-type is 4, now suggestion-tracking is 1.
The suggestion satisfied rule is listed in the default end of sex rules.

To compute cleavage climax of (M - a monster):
	TitfuckAddictUp 1;
	TimesFuckedUp M by 1;
	if M is male:
		say "[CleavageClimaxFlav of M]";
		CumTitsUp the semen load of M;
	if M is interested:
		satisfy M;
	now M is not penetrating breasts.

To say CleavageClimaxFlav of (M - a monster):
	say "The [M] ejaculates, covering your [ShortDesc of breasts] in [his of M] [semen]!".

[Similarly, these are BLAND EXAMPLES of what progress sex might look like for your monster.]

This is the default progress sex rule:
	follow the progress sex rules of current-monster;
	rule succeeds.
The default progress sex rule is listed last in the default continue sex rules.

To decide which number is the rounds of sex left of (M - a monster):
	decide on the sex-length of M. [Default function allows us to rewrite where this isn't true, e.g. witch and demoness]

This is the default facial sex rule:
	if current-monster is penetrating face, compute facial sex of current-monster.
The default facial sex rule is listed in the default progress sex rules.

To compute facial sex of (M - a monster):
	if the oral sex addiction of the player > 6, arouse 200;
	if the sex-length of M is 1:
		say NearingClimaxOral of M;
		decrease the sex-length of M by 1;
	otherwise:
		if the reaction of the player is 0:
			say OralResisting of M;
			say OralResistingResponse of M;
			if a random number between 1 and 2 is 1:
				decrease the sex-length of M by 1;
		otherwise:
			say OralSubmissionResponse of M;[The idea here is that the player and "M" are working together, so we don't uncessarily restrict outselves with two flavour functions]
			decrease the sex-length of M by 1;
		if the sex-length of M > 2 and the lips of face > 2, decrease the sex-length of M by 1.

This is the default anal sex rule:
	if current-monster is penetrating asshole, compute anal sex of current-monster.
The default anal sex rule is listed in the default progress sex rules.

To compute anal sex of (M - a monster):
	if the class of the player is living sex doll:
		say SexDollAnal of M;
	otherwise if M is not intelligent:
		say "The [M] continues to [one of]plow[or]fuck[or]use[or]invade[at random] your [asshole]!";
	otherwise if the reaction of the player is 2:[begging]
		compute begging of M in asshole;	
	otherwise if the reaction of the player is 1:[submitting]
		compute sexSubmit of M in asshole;
	otherwise:[resisting]
		compute sexResist of M in asshole;
	decrease the sex-length of M by 1;
	say "[one of][M sex reaction][or][cycling]".

This is the default vaginal sex rule:
	if current-monster is penetrating vagina, compute vaginal sex of current-monster.
The default vaginal sex rule is listed in the default progress sex rules.

To compute vaginal sex of (M - a monster):
	if M is not intelligent:
		say "The [M] continues to [one of]plow[or]fuck[or]use[or]invade[at random] your [vagina]!";
	otherwise if the reaction of the player is 2:
		compute begging of M in vagina;
	otherwise if the reaction of the player is 1:
		compute sexSubmit of M in vagina;
	otherwise:
		compute sexResist of M in vagina;
	decrease the sex-length of M by 1;
	say "[one of][M sex reaction][or][cycling]".

This is the default titfuck rule:
	if current-monster is penetrating breasts, compute titfuck of current-monster.
The default titfuck rule is listed in the default progress sex rules.

To compute titfuck of (M - a monster):
	humiliate 75;
	if the reaction of the player is 0:
		if M is male and M is intelligent:
			say TitfuckResistFlav of M;
		say TitfuckForceFlav of M;
		if a random number between 1 and 2 is 1, decrease the sex-length of M by 1;
	otherwise:
		say TitfuckReceiveFlav of M;
		decrease the sex-length of M by 1;
	if breasts is pushed over the edge:
		breasts orgasm shamefully;
	otherwise if the sensitivity of breasts >= 2:
		arouse (the square root of (the sensitivity of breasts * 1000)) * 10;
		if the sensitivity of breasts >= 10:
			say "[one of]The nerves in your breasts explode with sensation!  [if the player is female]Your [vagina] gushes with pleasure.[otherwise if the size of penis > 0]Your [player-penis] twitches rapidly.[end if][or]Your entire body shudders with pleasure.[or]Sparks of pure euphoria fly through your brain.[or]Your super sensitive tits cause you to moan with pleasure.[at random]";
		otherwise if the sensitivity of breasts >= 6:
			say "[one of]Your breasts feel amazing. [if the player is female]Your [vagina] gets wetter.[otherwise if the size of penis > 0]Your [player-penis] stirs gently.[end if][or][or][or]You close your eyes and shiver. it feels so good![or][or][or]Your super sensitive tits cause you to moan with pleasure.[or][or][or]You [if there is a worn chastity cage or the player is male and the size of penis is 0]wish you could masturbate![otherwise]can't help but gently play with yourself, eyes rolling to the back of your head with pleasure.[end if][or][stopping]";
		otherwise:
			say "[one of]It actually feels quite pleasurable for you.[or][or][or]You realise you are breathing heavily. Are your breasts somehow getting more sensitive?[or][or][or]You let out an involuntary whimper. It actually feels good![or][or][or]You shiver as a wave of sexual pleasure flows through you.[or][stopping]".

Chapter 2 Priority Attack

[If the monster has any unique actions that it would sometimes rather do than follow normal attack logic, those go here. These should generally not involve the player, so an example would be the giant wasp fertilizing an egg]

This is the priority attack rule:
	follow the priority attack rules of current-monster;
	if the rule succeeded, rule succeeds.
The priority attack rule is listed last in the monster attack rules. [Listed 2nd]

Chapter 3 Taunting

[In this section, monsters tend to taunt the player or wait silently because the player is either immune to combat (e.g. resting in hammock) or the player is stuck in some other way (e.g. flying or stuck on a dildo). It should be very rare that a monster does anything else, but there are exceptions; for example the royal guard can DP a female player on a dildo pole and a demoness can curse a player's heels.]

This is the taunting rule:
	follow the taunting rules of current-monster;
	if the rule succeeded, rule succeeds.
The taunting rule is listed last in the monster attack rules. [Listed 3rd]

This is the flying player taunting rule:
	if the player is flying:
		compute the flying player taunting of current-monster;
		rule succeeds.
The flying player taunting rule is listed last in the default taunting rules.

To compute the flying player taunting of (M - a monster):
	if a random number between 1 and 6 is 1, say "The [M] continues to wait for you to land.". [This should preferably be replaced for all monsters.]

This is the monster fucked player taunting rule:
	if there is a matron grabbing the player and current-monster is not matron: [TODO make a 'player is engaged' rulebook]
		compute the busy waiting of current-monster;
		rule succeeds;
	otherwise if the player is monster fucked or wanking > 0 and the player is prone: [NPCs watch the player wank if they would watch the player having sex.]
		follow the monster fucked taunting rule of current-monster;
		if the rule succeeded, rule succeeds;
	otherwise if wanking > 0: [Nearly all NPCs watch the player wank if standing.]
		compute the default taunting of current-monster;
		rule succeeds.
The monster fucked player taunting rule is listed last in the default taunting rules.

This is the default monster fucked taunting rule:
	do nothing. [This should preferably be replaced for all monsters that don't just blindly join in with sex. If the rule doesn't succeed, then that means that the monster will keep trying other things. So this monsters that do not wish to progress until the player is completely free should have "rule succeeds" here. Remember you can also use this function to have the monster interact with the player while they are fucked, e.g. to urinate on them.]

This is the dildo stuck player taunting rule:
	if the player is dildo stuck:
		compute the dildo stuck taunting of current-monster;
		rule succeeds.
The dildo stuck player taunting rule is listed last in the default taunting rules.

To compute the dildo stuck taunting of (M - a monster):
	if a random number between 1 and 6 is 1, say "The [M] continues to wait for you to get off the dildo.". [This should preferably be replaced for all monsters. Remember you can also use this function to have the monster interact with the player while they are stuck on the dildo.]

This is the trap stuck player taunting rule:
	if the player is trap stuck:
		compute the default taunting of current-monster;
		rule succeeds.
The trap stuck player taunting rule is listed last in the default taunting rules.

To compute the default taunting of (M - a monster):
	say "The [M] watches [if M is intelligent]with a facial expression of a mixture of incredulity and entertainment[otherwise]silently[end if].".

This is the busy waiting rule:
	if busy is 1:
		compute the busy waiting of current-monster;
		rule succeeds.
The busy waiting rule is listed last in the default taunting rules.

To compute the busy waiting of (M - a monster):
	if a random number between 1 and 6 is 1, say "The [M] continues to wait.". [This should preferably be replaced for all monsters.]

Chapter 4 Punishment

The monster punishment rules is a rulebook.

This is the monster punishment rule:
	if the player is prone:
		follow the monster punishment rules;
		if the rule succeeded, rule succeeds.
The monster punishment rule is listed last in the monster attack rules. [Listed 4th]

This is the monster latex punishment rule:
	follow the latex punishment rule of current-monster;
	if the rule succeeded, rule succeeds.
The monster latex punishment rule is listed last in the monster punishment rules.

This is the no latex punishment rule:
	do nothing.

This is the default latex punishment rule:
	if the latex-transformation of the player > 5:
		if current-monster is an intelligent human monster and the player is not top heavy:
			say "[LatexPunishmentFlav of current-monster]";
			BustInflate 2;
		otherwise:
			say SelectionFrustrated of current-monster; 
		bore current-monster for 600 seconds;
		rule succeeds.

To say LatexPunishmentFlav of (M - a monster):
	say "The [M] brings one of your nipples to [his of M] mouth, and blows powerfully for a few seconds. Your rubber tits inflate [one of]in front of your eyes[or]even larger[stopping]!".

This is the monster pulls collar rule:
	if there is a worn pullstring collar:
		follow the pullstring rule of current-monster;
		if the rule succeeded, rule succeeds.
The monster pulls collar rule is listed last in the monster punishment rules.

This is the default pullstring rule:
	if current-monster is intelligent and the collar-pulled of current-monster is 0:
		let P be a random worn pullstring collar;
		say "The [current-monster] notices your [ShortDesc of P]!  After a brief moment of consideration, [he of current-monster] takes hold of the string and pulls it!";
		now monster-puller is current-monster;
		try pulling P;
		now monster-puller is the player;
		if the bimbo of the player < 13, say "[variable custom style]'Uh-oh...'[roman type][line break]";
		now the collar-pulled of current-monster is 1;
		rule succeeds.

This is the monster plays diaper quest rule:
	if diaper quest is 1:
		increase the times-fucked of current-monster by 1; [In DQ, we use this to count the number of times the NPC has treated the player like a baby.]
		follow the diaper quest rules of current-monster;
		rule succeeds.
The monster plays diaper quest rule is listed last in the monster punishment rules.

This is the monster punishes diaper rule:
	if there is a worn diaper:
		follow the diaper punishment rule of current-monster;
		if the rule succeeded, rule succeeds.
The monster punishes diaper rule is listed last in the monster punishment rules.

This is the default diaper punishment rule:
	do nothing. [If the monster does something specific to players wearing diapers, consider replacing this rule with a rule that succeeds.]

This is the unique punishment rule:
	follow the unique punishment rule of current-monster;
	if the rule succeeded, rule succeeds.
The unique punishment rule is listed last in the monster punishment rules.

This is the default unique punishment rule:
	do nothing. [If the monster does something really cool (i.e. not sex) (e.g. the gladiator), replace this with a rule that succeeds. This could even be a rule that follows a whole new rulebook.]

This is the sex attempt rule:
	follow the sex attempt rules;
	rule succeeds. [If we do something here, we always end for the turn]
The sex attempt rule is listed last in the monster punishment rules.

The sex attempt rules is a rulebook.

Section 1 Orifice Selection

This is the selecting an orifice rule:
	follow the selecting an orifice rules;
	if the rule failed:
		compute SelectionFailure of current-monster;
		rule succeeds. [If we couldn't choose an orifice, the monster gives up for this turn and loses interest.]
The selecting an orifice rule is listed last in the sex attempt rules.

The selecting an orifice rules is a rulebook.

This is the monster convinced by player rule:
	follow the monster convinced rule of current-monster;
	if the rule succeeded, rule succeeds.
The monster convinced by player rule is listed last in the selecting an orifice rules.

Definition: a body part (called B) is a potential target:
	decide no.

Definition: face (called B) is a potential target:
	if current-monster is willing to do oral, decide yes;
	decide no.

Definition: vagina (called B) is a potential target:
	if current-monster is willing to do vaginal and the player is female, decide yes;
	decide no.

Definition: asshole (called B) is a potential target:
	if current-monster is willing to do anal, decide yes;
	decide no.

Definition: belly (called B) is a potential target: [Belly is used to target for urination. And since urination can just go on the face and doesn't need to go inside the mouth, we don't need to check 'reasonable target'.]
	if current-monster is willing to urinate and watersports fetish is 1 and the latex-transformation of the player <= 4, decide yes;
	decide no.

Definition: breasts (called B) is a potential target:
	if B is breasts and current-monster is willing to do titfucks and (presented-orifice is breasts or the largeness of breasts > 7), decide yes;
	decide no.

Definition: an object (called O) is an actual target:
	decide no.

[REASONABLE TARGET means that the orifice can be accessed by the NPC, even after taking into account things already inside the orifice, e.g. plugs]
Definition: a body part (called B) is a reasonable target:
	[If you want the monster to ignore buttslut and/or be able to take out plugs, you'll need to define the correct functions for your monster.]
	if B is not a potential target, decide no; [First we check, is it a potential target? (see above)]
	[if debugmode > 0, say "[Shortdesc of B] is a potential target...[line break]";]
	if B is occupied and B is not usable without penetration: [If it's usable without penetration e.g. the mannequin applying makeup, then we will always decide yes even if the player is gagged!]
		if B is fake occupied and current-monster is not concealment immune, decide no; [The NPC has been tricked by magic, it cannot perceive this orifice!]
		if B is actually occupied:
			repeat with T running through things penetrating B:
				if T is insertable or T is ballgag:
					if T is cursed and current-monster is not able to remove cursed plugs, decide no; [There's a cursed thing in the way, so only NPCs that can remove cursed plugs can access this orifice.]
					if current-monster is not able to remove plugs, decide no; [There's a thing in the way, so only NPCs that can remove plugs can access this orifice.]
				otherwise: [e.g. a monster / trap is penetrating]
					decide no;
			[So, if it's insertable and the monster can remove it, we will probably end up deciding yes!]
	decide yes.

Definition: belly (called B) is a reasonable target:
	if B is not a potential target, decide no; [First we check, is it a potential target? (see above)]
	decide yes.

[ACTUAL TARGET means that the orifice can be accessed by the NPC, even after taking into account magical distractions, e.g. butt slut]
Definition: a body part (called B) is an actual target:
	if B is not a reasonable target, decide no; [First we check, is it a reasonable target? (see above)]
	[if debugmode > 0, say "[ShortDesc of B] is a reasonable target...[line break]";]
	if current-monster is butt slut immune, decide yes; [The NPC is not tricked by basic concealment magic!!]
	[if debugmode > 0, say "The desirability of B is [the desirability of B][line break]";]
	if the desirability of B <= 0, decide no;
	[if debugmode > 0, say "[ShortDesc of B] is an actual target...[line break]";]
	decide yes.

Definition: a belly (called B) is an actual target: [We can always piss on a face unless it's being fucked.]
	if B is a reasonable target and the number of monsters filling face is 0, decide yes;
	[if debugmode > 0, say "[ShortDesc of B] is not an actual target...[line break]";]
	decide no.

Definition: a body part (called B) is usable without penetration: [If a monster can use the body part without penetration e.g. a mannequin applying makeup or a dominatrix spanking, then add a rule for the body part and then write "if current-monster is X, decide yes"]
	decide no.

Definition: a monster (called M) is concealment immune: [Can the monster ignore salves of concealment, butt slut, etc.]
	decide no.

Definition: a monster (called M) is butt slut immune: [Can the monster ignore the divine powers that force them to ignore vaginas?]
	if M is concealment immune, decide yes; [If they're immune to it all, they're immune to butt slut!]
	decide no.

Definition: a monster (called M) is able to remove cursed plugs: [Can the monster remove all plugs & ballgags?]
	if the player is diaper focused or the player is a blowjob slut, decide yes;
	decide no.

Definition: a monster (called M) is able to remove plugs: [Can the monster remove uncursed plugs?]
	if M is able to remove cursed plugs, decide yes; [In this way we don't need to redefine this if we've defined them as able to remove cursed plugs]
	if M is intelligent, decide yes;
	decide no.

This is the default monster convinced rule:
	if presented-orifice is a reasonable target:
		if a random number between -1 and the charisma of the player >= 0:
			now the chosen-orifice of current-monster is presented-orifice;[This is on top so flavor can refer to chosen orifice.]
			say "[PresentAcceptanceFlav of current-monster]";
			rule succeeds;
		otherwise if (presented-orifice is face or presented-orifice is belly) and current-monster is intelligent and there is a worn tongue piercing:
			say "The [current-monster] was about to ignore you, but it seems that your tongue piercing made your request extremely convincing!";
			now the chosen-orifice of current-monster is presented-orifice;
			rule succeeds;
		otherwise:
			say "[PresentRejectionFlav of current-monster]";
	otherwise if presented-orifice is not nothing:
		say "[PresentRejectionFlav of current-monster]".

To say PresentAcceptanceFlav of (M - a monster):
	say "The [M] seems convinced by your request!".

To say PresentRejectionFlav of (M - a monster):
	say "The [M] seems to ignore your request.".

This is the monster choosing an orifice rule:
	if debugmode > 0, say "Valid body parts are: [list of actual target body parts].";
	compute the orifice choosing of current-monster;
	if the chosen-orifice of current-monster is a body part, rule succeeds;
	otherwise rule fails.
The monster choosing an orifice rule is listed last in the selecting an orifice rules.

To compute the orifice choosing of (M - a monster):
	increase the selection-frustration of M by 1;
	if the chosen-orifice of M is nothing or the chosen-orifice of M is not an actual target or a random number between 4 and 7 < the selection-frustration of M:
		if debugmode > 0, say "Rerolling sex selection.";
		choose a sex method;
		now the chosen-orifice of M is targeted-body-part;
		now the selection-frustration of M is 0.

To compute SelectionFailure of (M - a monster):
	if the number of monsters penetrating a body part is 0:
		say SelectionFrustrated of M;
	otherwise:
		compute SelectionWaiting of M.

[If you want monsters to wait around forever for their turn, then they should have their own one of these with no random chance.]
To compute SelectionWaiting of (M - a monster):
	if a random number between 1 and 5 is 1, say SelectionFrustrated of M;
	otherwise do nothing. [The monster waits its turn.]

To say SelectionFrustrated of (M - a monster):
	say "The [M] seems to look very frustrated, and then gives up.";
	bore M.

This is the selection frustrated rule:
	say "[SelectionFrustrated of current-monster]";
	rule fails.
The selection frustrated rule is listed last in the default diaper quest rules.

Section 2 Clothing Removal and Insertion

This is the monster insertion rule:
	follow the insertion rules of current-monster. [We don't need "rule succeeds" here because the rule that called the sex attempt rules doesn't check.]
The monster insertion rule is listed last in the sex attempt rules.

To compute (M - a monster) attacking (C - a clothing): [This should change for any special flavour or varied mechanics on how the clothing is removed.]
	if C is crotch-zipped and M is intelligent:
		say "[UnzipFlav of M at C]";
		now C is crotch-unzipped;
	otherwise:
		say "[PullAttempt of M at C]";
		let R be a random number between the difficulty of M and 6 + a random number between the difficulty of M and 6;
		if debugmode is 1, say "Player [the defence of the player].5 | [R] [M][line break]";
		if R > the defence of the player:
			compute M destroying C;
		otherwise if R > the defence of the player - 2 and C is rippable:
			compute M ripping C;
		otherwise if R > the defence of the player - 6 and C is displacable and a random number between -1 and unlucky <= 0: [NPCs rarely displace clothing when unlucky is enabled]
			compute M displacing C;
		otherwise:
			say "[WeakenFlav of M on C]";
			damage C.

To compute (M - a monster) attacking (C - a diaper): 
	say "[PullAttempt of M at C]";
	if C is crotch-zipped and M is intelligent:
		say "[UnzipFlav of M at C]";
		now C is crotch-unzipped;
	otherwise if C is actually strippable:
		say "The [M] effortlessly pulls off your [ShortDesc of C]!";
		if M is intelligent:
			now C is in Holding Pen;
			now M is retaining C;
		otherwise:
			now C is in the location of the player;
	otherwise if C is rippable:
		compute M ripping C;
	otherwise:
		compute M destroying C.

To compute (M - a monster) removing (C - a thing): [This is used for removing insertables]
	if M is intelligent:
		say "The [M] effortlessly pulls out your [ShortDesc of C].";
		now C is in holding pen;
		now M is retaining C;
	otherwise:
		say "The [M] effortlessly pulls out your [ShortDesc of C] and discards it onto the floor.";
		now C is in the location of the player;
	dislodge C.

To say UnzipFlav of (M - a monster) at (C - a clothing):
	say "The [M] pulls down the zipper on your [ShortDesc of C][if the number of ass covering clothing is 1], exposing your [fuckholes][end if]!".

To say PullAttempt of (M - a monster) at (C - a clothing):
	say "The [M] pulls at your [ShortDesc of C] to try and rip it off!".
	
To compute (M - a monster) destroying (C - a clothing):
	say "The [M] rips it off, destroying it completely!";
	destroy C.

To compute (M - a monster) ripping (C - a clothing):
	say "The [M] manages to create a tear in the fabric!  Your [ShortDesc of C] is now permanently ripped.";
	now C is crotch-ripped.

To compute (M - a monster) displacing (C - a clothing):
	say "The [M] [DisplacesFlav of C].";
	displace C.

To say DisplacesFlav of (C - a clothing):
	say "pulls the [if C is hobble-skirted]skirt of your [ShortDesc of C] up, exposing your crotch[otherwise if C is trousers]waistband of your [ShortDesc of C] down to your knees[otherwise]crotch section of your [ShortDesc of C] to one side[end if]".

To compute (M - a monster) replacing (C - a clothing):
	say "The [M] pulls the [if C is hobble-skirted]skirt of your [ShortDesc of C] back down[otherwise if C is trousers]waistband of your [ShortDesc of C] back up to its proper place[otherwise]crotch section of your [ShortDesc of C] back in place[end if].";
	replace C.

To say WeakenFlav of (M - a monster) on (C - a clothing):
	say "The [clothing-material of C] is weakening.".

[!<SetUpSexLengthOfMonsterInBodypart>+

Sets the sex-length property of a monster "M" based on a body part "B". 

@param <Monster>:<M> The monster that is planning to fuck the player
@param <BodyPart>:<B> The bodypart "M" is planning to fuck
+!]
To set up sex length of (M - a monster) in (B - a body part):
	set up sex length 3 of M in B.

[!<ComputeUniquePenetrationEffectOfMonsterInBodypart>+

Defines a unique effect for a monster "M" penetrating the player in bodypart "B". Note that this function is by default called BEFORE M is penetrating B.

@param <Monster>:<M> The monster that is penetrating the player
@param <BodyPart>:<B> The bodypart "M" is penetrating
+!]
To compute unique penetration effect of (M - a monster) in (B - a body part):
	do nothing.

[!<SetUpSexLengthNumberOfMonsterInBodypart>+

Sets the sex-length property of a monster to a given property as long as it is 0 or less. Optionally modified based on the body part the monster is about to have sex with

@param <Integer>:<N> The number to which sex-length will be set
@param <Monster>:<M> The monster that is planning to fuck the player
@param <BodyPart>:<B> The bodypart "M" is planning to fuck
+!]
To set up sex length (N - a number) of (M - a monster) in (B - a body part):[ONLY assigns N to the sex length field if it is 0. If a monster potentially has a special sex length, this function does not do anything. Use "now sex length is X" instead]
	if the sex-length of M <= 0, now the sex-length of M is N.

This is the monster asshole insertion rule:
	if the chosen-orifice of current-monster is asshole, follow the monster asshole insertion rules.
The monster asshole insertion rule is listed in the default monster insertion rules.

The monster asshole insertion rules is a rulebook.

This is the monster attacking ass covering clothing rule:
	let C be a random worn top level ass protection clothing;
	if C is clothing:
		compute current-monster attacking C;
		rule succeeds.
The monster attacking ass covering clothing rule is listed last in the monster asshole insertion rules.

This is the monster removing butt plug rule:
	let C be a random worn insertable thing penetrating asshole;
	if C is a thing:
		compute current-monster removing C;
		rule succeeds.
The monster removing butt plug rule is listed last in the monster asshole insertion rules.

This is the monster penetrating asshole rule:
	if current-monster is male and there is a held condom-providing thing[ and current-monster is not wrapped], compute condom request choice of current-monster;
	compute current-monster entering anally;
	rule succeeds.
The monster penetrating asshole rule is listed last in the monster asshole insertion rules.

To get anal penetration image for (M - a monster):
	do nothing.

To compute (M - a monster) entering anally:
	compute M entering asshole.

To compute (M - a monster) entering (F - a fuckhole):[Generic function that shouldn't realistically come up.]
	if F is not actually occupied:
		set up sex length of M in F;
		say "The [M] forces [him of M]self into your [variable F]";
		now M is penetrating F;
		ruin F;
		compute unique penetration effect of M in F;
	otherwise:
		say "The [M] sees that you are already occupied and loses interest";
		Bore M.

To compute (M - a monster) entering (F - asshole):
	if F is not actually occupied:
		set up sex length of M in F;
		if (M is friendly-fucking or presented-orifice is F) and M is intelligent, say FriendlyAssholePenetrationFlav of M;[You can't really have "friendly" sex with unintelligent monsters anyway]
		otherwise say AssholePenetrationFlav of M; [If you just want to change the text, replace the Flav function. Otherwise replace the entire compute function.]
		now M is penetrating F;
		compute unique penetration effect of M in F;
		ruin F;
		get anal penetration image for M;
		say GangAnnounce;
	otherwise:
		say "The [M] sees that you are already occupied and loses interest.";
		distract M.

This is the monster vagina insertion rule:
	if the chosen-orifice of current-monster is vagina, follow the monster vagina insertion rules.
The monster vagina insertion rule is listed in the default monster insertion rules.

The monster vagina insertion rules is a rulebook.

This is the monster attacking pussy covering clothing rule:
	let C be a random worn top level protection clothing;
	if C is clothing:
		compute current-monster attacking C;
		rule succeeds.
The monster attacking pussy covering clothing rule is listed last in the monster vagina insertion rules.

This is the monster removing cunt plug rule:
	let C be a random worn insertable thing penetrating vagina;
	if C is a thing:
		compute current-monster removing C;
		rule succeeds.
The monster removing cunt plug rule is listed last in the monster vagina insertion rules.

This is the monster penetrating vagina rule:
	if current-monster is male and there is a held condom-providing thing, compute condom request choice of current-monster;
	compute current-monster entering vaginally;
	rule succeeds.
The monster penetrating vagina rule is listed last in the monster vagina insertion rules.

To get vaginal penetration image for (M - a monster):
	if image cutscenes is 1:
		if the latex-transformation of the player > 6:
			if M is male and M is human and M is not dark skinned:
				display figure of latex curse 6.

To compute (M - a monster) entering vaginally:
	compute M entering vagina.

To compute (M - a monster) entering (F - vagina):
	if F is not actually occupied:
		set up sex length of M in vagina;
		if (M is friendly-fucking or presented-orifice is vagina) and M is intelligent, say FriendlyVaginaPenetrationFlav of M;
		otherwise say VaginaPenetrationFlav of M; [If you just want to change the text, replace the Flav function. Otherwise replace the entire compute function.]
		compute unique penetration effect of M in vagina;
		now M is penetrating vagina;
		ruin vagina;
		get vaginal penetration image for M;
		say GangAnnounce;
	otherwise:
		say "The [M] sees that you are already occupied and loses interest.";
		distract M.

This is the monster mouth insertion rule:
	if the chosen-orifice of current-monster is face, follow the monster mouth insertion rules.
The monster mouth insertion rule is listed in the default monster insertion rules.

The monster mouth insertion rules is a rulebook.

This is the monster removing gag rule:
	let C be a random worn clothing penetrating face;
	if C is a thing:
		compute current-monster removing C;
		rule succeeds.
The monster removing gag rule is listed last in the monster mouth insertion rules.

This is the monster penetrating mouth rule:
	compute current-monster entering mouth;
	rule succeeds.
The monster penetrating mouth rule is listed last in the monster mouth insertion rules.

To get facial penetration image for (M - a monster):
	do nothing.

To compute (M - a monster) entering mouth:
	if face is not occupied: [The whole 'face is not occupied' stuff is so that we can try and call this from other areas of the code.]
		set up sex length of M in face;
		if M is friendly-fucking, say FriendlyMouthPenetrationFlav of M;
		otherwise say MouthPenetrationFlav of M; [If you just want to change the text, replace the Flav function. Otherwise replace the entire compute function.]
		now M is penetrating face;
		compute unique penetration effect of M in face;
		get facial penetration image for M;
		say GangAnnounce;
	otherwise:
		say "The [M] sees that you are already occupied and loses interest.";
		distract M.

This is the monster breasts insertion rule:
	if the chosen-orifice of current-monster is breasts, compute current-monster entering breasts.
The monster breasts insertion rule is listed in the default monster insertion rules.

To get breasts penetration image for (M - a monster):
	do nothing.

To compute (M - a monster) entering breasts:
	set up sex length of M in breasts;
	if M is friendly-fucking, say FriendlyBreastsPenetrationFlav of M;
	otherwise say BreastsPenetrationFlav of M; [If you just want to change the text, replace the Flav function. Otherwise replace the entire compute function.]
	now M is penetrating breasts;
	compute unique penetration effect of M in breasts;
	get breasts penetration image for M.

To say BreastsPenetrationFlav of (M - a monster):
	say "The [M] forces [his of M] [manly-penis] in between your [ShortDesc of breasts]!". [This needs changing for every monster!  It's boring and might not even be accurate if the monster isn't male.]
	
	
This is the monster begin urination rule:
	if the chosen-orifice of current-monster is belly, follow the monster begin urination rules.
The monster begin urination rule is listed in the default monster insertion rules.

The monster begin urination rules is a rulebook.

This is the monster removing gag for urination rule:
	let C be a random worn clothing penetrating face;
	if C is cursed clothing:
		if current-monster is able to remove cursed plugs:
			compute current-monster removing C;
			rule succeeds;
	otherwise if C is clothing:
		compute current-monster removing C;
		rule succeeds.
The monster removing gag for urination rule is listed last in the monster begin urination rules.

This is the monster urinating rule:
	compute current-monster urinating;
	rule succeeds.
The monster urinating rule is listed last in the monster begin urination rules.

To compute (M - a monster) urinating:
	say "[UrinationFlav of M]"; [If you just want to change the text, replace the Flav function. Otherwise replace the entire compute function.]
	FacePiss from M;
	satisfy M.

To say UrinationFlav of (M - a monster):
	if M is male:
		if M is intelligent:
			say "[one of]The [M] laughs, taking a handful of your [ShortDesc of hair] and yanking your head back. A golden stream of [urine] shoots out of [his of M] [manly-penis], headed straight for your face![or]The [M] laughs, tilting your chin up and wrapping a hand around the base of [his of M] shaft. A golden stream of [urine] shoots out of [his of M] [manly-penis], headed straight for your face![in random order][if the humiliation of the player < 17500 and the urine taste addiction of the player is 1][line break][first custom style][line break]What the actual fuck.[roman type][line break][end if]";
		otherwise:
			say "The [M] points [his of M] [manly-penis] towards your face. A golden stream of [urine] shoots out, headed straight for you!";
	otherwise:
		if M is intelligent:
			say "[one of]The [M] smiles, taking a handful of your [ShortDesc of hair] and yanking your head back. Pulling apart her pussy lips, she allows a golden stream of [urine] to start to squirt straight at your face![or]The [M] laughs, tilting your chin up and wrapping a hand around the base of [his of M] shaft. A golden stream of [urine] shoots out of [his of M] pussy, headed straight for your face![in random order][if the humiliation of the player < 17500 and the urine taste addiction of the player is 1][line break][first custom style][line break]What the actual fuck.[roman type][line break][end if]";
		otherwise:
			say "The [M] points [his of M] genitals towards your face. A golden stream of [urine] shoots out, headed straight for you!".


Chapter 6 Damaging and Tripping

This is the monster attack rule:
	if the player is upright:
		follow the attack rules of current-monster.
		[if the rule succeeded, rule succeeds.] [By commenting this out, this means that the monster gets to go straight to punishment if the player drops.]
The monster attack rule is listed last in the monster attack rules. [Listed 5th]


[
Tripping rolls:
In general, when checking if a monster trips the player, do this:
Say that the monster is trying to trip the player
Set the monster's tripping roll as a value, we'll use T here
*If the monster is a DECENT TRIPPER, use if the tripping roll of M >= the dexterity of the player to confirm successful trip*
*Otherwise use if the tripping roll of M > the dexterity of the player*
**Further modifications can obviously be made with + and - flat numbers**
**Be aware that text lines can come out here about how the slipperiness of the room is making it hard to stay on your feet**
If successful, say that the trip was successful and try kneeling.
Otherwise say that it was unsuccessful.
]
[The trip roll is usually (difficulty / 2) to difficulty. The number it's rolling against is dex]
To decide which number is the tripping roll of (M - a monster):
	let T be the tripping max of M;
	let D be the dexterity of the player;
	if debugmode is 1, say "Tripping Max of [M] is [T].";
	if T <= 0: [In some cases the player can never fall over, e.g. living belt of sturdiness, or they slapped]
		decide on 0;
	otherwise if T < D: [We want to make sure there is always a slight chance of the trip being successful on super fast players]
		if debugmode is 1, say "This is lower than dex ([D]), so tripping has minimum likelihood (2 in [D]).";
		now T is a random number between 1 and (D + 1);
	otherwise if (T / 2) > D + 3: [We want to make sure there is always a chance of the trip failing against super slow players]
		if debugmode is 1, say "This is really high, so tripping is capped at maximum likelihood ([T - D] in [T + 3 - D]).";
		now T is a random number between T and D - 3; [trip will fail if the RNG hits D - 1 or lower]
	otherwise: [This is the normal calculation]
		if debugmode is 1, say "This is a reasonable number, so tripping has normal roll ([T / 2] to [T]).";
		now T is a random number between T and (T / 2);
	if debugmode is 1, say "Tripping Roll Result of [M] is [T], which needs to be above or equal to dexterity ([D]).";
	decide on T.

To decide which number is the tripping max of (M - a monster):
	if attack-type is 0 or attack-type is 1:
		if the trip hazard of the player <= 0, decide on 0;
		otherwise decide on 1; [if the player slapped or stood still they are not off-balance so tripping is always minimum likelihood]
	if the living belt of sturdiness is worn and the living belt of sturdiness is not cursed, decide on 0;
	let D be the difficulty of M;
	increase D by the trip hazard of the player * 2;
	if the slipperiness of the location of the player > 0, say "The slipperiness of the floor is making it much more difficult to avoid falling!";
	if attack-type is 3, now D is D * 2;
	if D < 1, decide on 1;
	decide on D.

To decide which number is the accuracy roll of (M - a monster):
	let D be the difficulty of M + (a random number between 1 and 6) + (a random number between 1 and 6);
	if the blind-status of M is 1, decrease D by 6;
	if D > the difficulty of M + 7, now D is 9999; [This check means that the right hand side of the normal distribution roll always is a successful hit. i.e. 50% of the time, the monster will hit automatically]
	if debugmode is 1, say "Player [dexterity of the player] | [D].5 [M][line break]";
	decide on D.


A monster has a number called last-tripped.

Definition: a monster (called M) is a tripper:
	if M is intelligent, decide yes;
	decide no.

To say TripChanceFlav of (M - a monster):
	if the last-tripped of M > 4:
		say "The [M] [one of]is blatantly staring at your [feet][or]looks down at your [feet][or][if M is human]bends [his of M] knees[otherwise]aims for your knees[end if][in random order]!  [big he of M] is clearly going to try and trip you soon.";
	otherwise if the last-tripped of M > 2:
		say "The [M] [one of]glances at your [feet][or]seems to be almost purposefully not looking at your [feet][or]eyes your knees[in random order]. There's a chance [he of M] is planning to trip you up.[if newbie tips is 1 and tutorial is 0][one of][item style]This would be a good time to stick to slapping until the NPC makes [his of M] trip attack.[roman type][line break][or][stopping][end if]".

Definition: a jismbodied ghost (called M) is a tripper:
	decide yes.

This is the choice of attack rule:
	if current-monster is a tripper:
		if the last-tripped of current-monster > a random number between 1 and 10 or (tutorial is 1 and the last-tripped of current-monster is 2):
			now the last-tripped of current-monster is 0;
			compute tripping attack of current-monster;
		otherwise:
			increase the last-tripped of current-monster by 1;
			compute striking attack of current-monster;
			if the player is upright and current-monster is a tripper and current-monster is intelligent, say "[TripChanceFlav of current-monster]";
	otherwise:
		compute striking attack of current-monster.
The choice of attack rule is listed last in the default monster attack rules.

To compute tripping attack of (M - a monster):
	say MonsterTripAnnounceFlav of M;
	let D be the tripping roll of M;
	if debugmode is 1, say "Player [dexterity of the player] | [D].5 Monster[line break]";
	if (D >= the dexterity of the player and the blind-status of M is not 1) or tutorial is 1:
		say "[MonsterTrippedFlav of M]";
		try kneeling;
		if the player is prone and tutorial is 0, check attack of M;
	otherwise:
		say "[MonsterFailedTripFlav of M]";
		if the blind-status of M is 1 and a random number between 1 and 2 is 1:
			say "The [M] is no longer blind!";
			now the blind-status of M is 0.

To say MonsterTripAnnounceFlav of (M - a monster):
	say "The [M] tries to trip you up!".

To say MonsterTrippedFlav of (M - a monster):
	say "You flail wildly [if the player is ankle bound]but you can't move your legs far enough apart to maintain your balance. You[otherwise]and[end if] fall to the ground!".

To say MonsterFailedTripFlav of (M - a monster):
	say "You manage to keep your balance.".

To compute striking attack of (M - a monster):
	let B be a random body part;
	if B is a fuckhole or B is penis, now B is hips;
	if B is hair, now B is face;
	if the accuracy roll of M >= the dexterity of the player:
		say "[StrikingSuccessFlav of M on B]";
		compute M striking B;
	otherwise:	
		say "[StrikingFailureFlav of M on B]";
		if the blind-status of M is 1 and a random number between 1 and 2 is 1:
			say "The [M] is no longer blind!";
			now the blind-status of M is 0.

To say StrikingSuccessFlav of (M - a monster) on (B - a body part):
	say "The [M] smacks you [TargetName of B]!  Ouch!!".

To say StrikingFailureFlav of (M - a monster) on (B - a body part):
	say "The [M] tries to smack you [TargetName of B] but you manage to swiftly dodge the blow!".

To say TargetName of (B - a body part):
	if B is face:
		say "in the face";
	otherwise if B is hips:
		say "on the ass";
	otherwise:
		say "on the [printed name of B]".

To compute (M - a monster) striking (B - a body part):
	BodyRuin 1.

To compute (M - a monster) striking (B - breasts):
	let P be a random worn breast covering clothing;
	if P is clothing, compute P protecting B;
	otherwise BodyRuin 2;
	let S be a random worn spikey breast covering clothing;
	if S is clothing:
		compute S damaging M.

To compute (P - a santa corset) protecting (B - breasts):
	if a random number between 2 and 22 > the largeness of breasts, say "The brunt of the blow is absorbed by your [printed name of P]!";
	otherwise BodyRuin 2.
	
To compute (P - a chainmail top) protecting (B - breasts):
	say "Your [printed name of P] blocks the brunt of the force!";
	
To compute (P - a striped top) protecting (B - breasts):
	if total-wasps > 50, say "The blow deflects off the shiny black carapace covering your breasts!";
	otherwise BodyRuin 2.

To compute (P - a clothing) protecting (B - breasts):
	if P is protection and a random number between the magic-modifier of P and 8 > 4:
		say "The [P] protects you from being properly injured by the attack!";
	otherwise if P is possession and a random number between the magic-modifier of P and 8 > 4:
		say "The [P] causes the attack to phase through you completely!";
	otherwise:
		BodyRuin 2.
	

To compute (M - a monster) striking (B - hips):
	let O be the body soreness of the player;
	let S be a random worn skirted clothing;
	let C be a random worn crotch covering clothing;[crotch covering, not crotch protecting.]
	if S is clothing:
		compute S protecting B;
	if C is clothing and O is not the body soreness of the player:
		compute C protecting B;
	otherwise:
		BodyRuin 1.

To compute (P - clothing) protecting (B - body part): [default - no effect]
	BodyRuin 1.	

To compute (P - clothing) protecting (B - hips):
	if P is protection and a random number between the magic-modifier of P and 8 > 4, say "The [P] protects you from being properly injured by the attack!";
	otherwise BodyRuin 1.	

To compute (P - skirted clothing) protecting (B - hips):
	if P is protection and a random number between the magic-modifier of P and 8 > 4:
		say "The [P] protects you from being properly injured by the attack!";
	otherwise if P is possession and a random number between the magic-modifier of P and 8 > 4:
		say "The [P] causes the attack to phase through you completely!";
	otherwise:
		BodyRuin 1.
	
To compute (P - a chainmail skirt) protecting (B - hips):[I.E. all of it.]
	say "Your [random worn chainmail skirt] blocks the brunt of the force!".

To compute (M - a monster) striking (B - arms):
	let P be a random worn arm covering clothing;
	if P is clothing, compute P protecting B;
	otherwise BodyRuin 1.

To compute (P - a clothing) protecting (B - arms):
	if P is protection and a random number between the magic-modifier of P and 8 > 4, say "The [P] protects you from being properly injured by the attack!";
	otherwise BodyRuin 1;

To compute (M - a monster) striking (B - thighs):
	let P be a random worn leg covering clothing;
	if P is clothing, compute P protecting B;
	otherwise BodyRuin 1.

To compute (P - a black-and-yellow striped stockings) protecting (B - thighs):
	if total-wasps > 50, say "The blow deflects off the shiny black carapace covering your legs!";
	otherwise BodyRuin 1.

To compute (P - a clothing) protecting (B - thighs):
	if P is protection and a random number between the magic-modifier of P and 8 > 4:
		say "The [P] protects you from being properly injured by the attack!";
	otherwise if P is possession and a random number between the magic-modifier of P and 8 > 4:
		say "The [P] causes the attack to phase through you completely!";
	otherwise:
		BodyRuin 1.

To compute (S - a clothing) damaging (M - a monster):
	if S is spikey, say "The [M], hitting your [printed name of S], [if M is male and M is intelligent and M is not futanari slutty sister]cries out in pain as the spikes cut into his hand[otherwise]recoils in pain from the spikes[end if]!";
	otherwise say "Somehow, the [M] hurts [himself of M] as [he of M] attacks!";
	if S is spikey and S is a striped top and the poison-status of M is 0:
		say "After striking you, the [M] takes on an unhealthy shade of green!";
		now the poison-status of M is 1;
	decrease the health of M by 4.

To compute (M - a monster) striking (B - face):
	BodyRuin 2;
	if there is a worn wasp-antennae and total-wasps > 50:
		say "Your antennae are clipped by the blow, which causes you even more pain!";
		BodyRuin 1.

To compute (M - a monster) striking (B - belly):
	let P be a random worn belly covering clothing;
	if P is clothing:
		compute P protecting B;
	otherwise:
		BodyRuin 1;
		if the player is able to expel and a random number between -6 and the total squirtable fill of belly > 0 and the latex-transformation of the player < 5 and currently-squirting is 0:
			say "The hit puts pressure on the contents of your belly, and causes you to momentarily lose control of your sphincter!";
			AssSquirt.
			
To compute (P - a clothing) protecting (B - belly):
	if P is protection and a random number between the magic-modifier of P and 8 > 4:
		say "The [P] protects you from being properly injured by the attack!";
	otherwise if P is possession and a random number between the magic-modifier of P and 8 > 4:
		say "The [P] causes the attack to phase through you completely!";
	otherwise:
		BodyRuin 1;
		if the player is able to expel and a random number between -4 and the total squirtable fill of belly > 0 and the latex-transformation of the player < 5 and currently-squirting is 0:
			say "The hit puts pressure on the contents of your belly, and causes you to momentarily lose control of your sphincter!";
			AssSquirt.

To say MonsterAttackError:
	say "[one of][bold type]ERROR - this monster doesn't know how to attack. Some stupid slut forgot to code this right!  Oh dear. I guess it just stands there and does nothing.[roman type][line break][or][stopping]".

To compute (M - a monster) receiving (N - a number) damage from (X - a monster):
	say "[AllyDamageFlav of X on M]";
	decrease the health of M by N.

To say AllyDamageFlav of (X - a monster) on (M - a monster):
	say "The [X] strikes the [M]!".




Combat ends here.

