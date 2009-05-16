-module(test_erlcfg_ast).
-include_lib("eunit/include/eunit.hrl").



erlcfg_traverse_single_set_test() ->
    Ast = [{set, one, 3}, []],
    Expected = {c, '', [
            {d, one, 3}
        ]
    },
    ?assertEqual(Expected, erlcfg_ast:traverse(Ast)).

erlcfg_traverse_single_get_test() ->
    Ast = [{get, one}, []],
    Expected = {not_found, one},
    ?assertThrow(Expected, erlcfg_ast:traverse(Ast)).

erlcfg_traverse_multiple_toplevel_test() ->
    Ast = [{set, one, 3}, [{set, two, {get, one}}]],
    Expected = {c, '', [
            {d, one, 3},
            {d, two, 3}
        ]
    },
    ?assertEqual(Expected, erlcfg_ast:traverse(Ast)).

erlcfg_traverse_nested_blocks_test() ->
    Ast = [[{block, foo, noop}, 
                [{set, foo, moo}, 
                  [{set, foo1, moo1}, 
                   [[{block, foo2, noop}, 
                      [{set, foo, moo}, [{set, foo1, moo1},[]]],
                   {endblock, noop, noop}],[]]]],
           {endblock, noop, noop}],[]],
   Expected = {c, '', [
           {c, foo, [
                   {d, foo, moo},
                   {d, foo1, moo1},
                   {c, foo2, [
                           {d, foo, moo},
                           {d, foo1, moo1}]
                   }
               ]
           }]
   },
   ?assertEqual(Expected, erlcfg_ast:traverse(Ast)).
