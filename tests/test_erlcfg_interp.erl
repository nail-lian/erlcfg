-module(test_erlcfg_interp).
-include_lib("eunit/include/eunit.hrl").


new_test() ->
    ?assertEqual([], erlcfg_interp:new()).

eval_val_with_empty_interp_test() ->
    Interp = erlcfg_interp:new(),
    Expected = {Interp, foo},
    ?assertEqual(Expected, erlcfg_interp:eval(Interp, {val, foo, nil})).

eval_val_with_nonempty_interp_test() ->
    Interp = [{foo, bar}, {bar, baz}],
    Expected = {Interp, 5},
    ?assertEqual(Expected, erlcfg_interp:eval(Interp, {val, 5, nil})).
