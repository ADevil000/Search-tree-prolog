map_build(List, Tree) :- length(List, L), toIndexArray(List, 1), map_array_build(Tree, 1, L), retractall(ind(_, _)).
toIndexArray([], _).
toIndexArray([H | T], C) :- assert(ind(C, H)), C1 is C + 1, toIndexArray(T, C1).

map_array_build(nil, S, E) :- S > E, !.
map_array_build(node(nil, Root, nil), S, S) :- ind(S, Root), !.
map_array_build(node(LTree, Root, RTree), S, E) :-
	L is E - S,
	HL is div(L, 2),
	El is S + HL,
	ind(El, Root),
	LB is El - 1,
	RB is El + 1,
	map_array_build(LTree, S, LB),
	map_array_build(RTree, RB, E),
	!.

map_get(node(_, (Key, Value), _), Key, Value).
map_get(node(LTree, (RKey, RValue), RTree), Key, Value) :- RKey < Key, map_get(RTree, Key, Value).
map_get(node(LTree, (RKey, RValue), RTree), Key, Value) :- RKey > Key, map_get(LTree, Key, Value).

map_minKey(node(nil, (Key, Value), _), Key).
map_minKey(node(Left, _, _), Key) :-  map_minKey(Left, Key).

map_maxKey(node(_, (Key, Value), nil), Key).
map_maxKey(node(_, _, Right), Key) :-  map_maxKey(Right, Key).