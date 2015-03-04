/* -----------------------------------------------
----------Logic Programming Coursework 1----------
----------------Stefan Mark Taylor----------------
---------------------s1006260---------------------
------------------------------------------------*/

%-------Best viewed with a tab spacing of 4-------

/*------------------------------------------------
--------------------------------------------------
----****----****    Question 1    ****----****----
--------------------------------------------------
------------------------------------------------*/

suffixes([],[[]]).
suffixes([L|Ls],[[L|Ls] | M]):- suffixes(Ls,M).

/*------------------------------------------------
--------------------------------------------------
----****----****    Question 2    ****----****----
--------------------------------------------------
------------------------------------------------*/

ages(L):-findall(A,age(_,A),L).


%Function to find the sum of all elements in a list
sum([],0).
sum([Head|Tail],Sum):-	sum(Tail,Sum1),
						Sum is Head + Sum1.

%Funtion that counts the number of items in a list
count([],0).
count([_|Tail],Count):-	count(Tail,I),
						Count is 1 + I.

%Zip Function from lecture slides
zip([],[],[]).
zip([X|L], [Y|M], [(X,Y)|N]) :- zip(L, M, N).


aboveaverageage(L):- 	(findall(A,age(_,A),K)), 
						sum(K,SUM),
						count(K,N),
						Avg is SUM / N, 
						findall(B,(age(B,C),C>Avg),L).

/*------------------------------------------------
--------------------------------------------------
----****----****    Question 3    ****----****----
--------------------------------------------------
------------------------------------------------*/

rot13char(X, Y):-	\+member(X,[a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]), Y = X.
rot13char(X, Y):-	member(X,[a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]),
					zip([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z],[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25],Pairs),
					member((X,Num),Pairs),
					A is (Num+13) mod 26,
					member((Y,A),Pairs).
					
rot13list([],[]).
rot13list([Head|Tail],Y):-	rot13list(Tail,Ys),
							rot13char(Head,Y1),
							append([Y1],Ys,Y).

rot13(X,Y):-	atom_chars(X,Z), rot13list(Z,A), atom_chars(Y,A).

/* -----------------------------------------------
--------------------------------------------------
----****----****    Question 4    ****----****----
--------------------------------------------------
------------------------------------------------*/

neighbour_sym(A,B):- neighbour(A,B) ; neighbour(B,A).

test(Doc,Tea,Den,Law,Fir):-	\+Doc = bob,
							male(Tea),
							male(Fir),
							neighbour_sym(Fir,Law),
							neighbour_sym(Den,A),
							female(A).

person(A):- male(A);female(A).


/*Question was unclear as to what exactly I was generating.
I opted to ensure that variables A,B,C,D,E would always be
different, (meaning that 1 person could not be assigned to
multiple jobs). If  it was intended that  one person could
hold multiple jobs, then removing the dif lines (90-93 inc)
from generate would give the desired result.*/

generate(A,B,C,D,E):-	person(A),
						person(B),
						person(C),
						person(D),
						person(E),
						dif(A,B),dif(A,C),dif(A,D),dif(A,E),
						dif(B,C),dif(B,D),dif(B,E),
						dif(C,D),dif(C,E),
						dif(D,E).

solve(A,B,C,D,E):-	generate(A,B,C,D,E),test(A,B,C,D,E).

% some rules commented out to not conflict with any tests you do
/*
age(homer,39).
age(marge,39).
age(bart,10).
age(lisa,7).
age(maggie,1).
male(bob). 
male(charlie).
male(david).
female(alice). 
female(eve).
neighbour(alice, bob). 
neighbour(bob, charlie).
neighbour(charlie, david). 
neighbour(david, eve).
*/
/*

# -------------------------------------------------- #
# *****   ___________   ___ _____  ____ ____   ***** #
# *****  / ___/      | /  _]     |/    |    \  ***** #
# ***** (   \_|      |/  [_|   __|  o  |  _  | ***** #
# *****  \__  |_|  |_|    _]  |_ |     |  |  | ***** #
# *****  /  \ | |  | |   [_|   _]|  _  |  |  | ***** #
# *****  \    | |  | |     |  |  |  |  |  |  | ***** #
# *****   \___| |__| |_____|__|  |__|__|__|__| ***** #
# -------------------------------------------------- #

*/
