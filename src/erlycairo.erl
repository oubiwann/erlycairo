%% @author Roberto Saccon <rsaccon@gmail.com> [http://rsaccon.com]
%% @copyright Roberto Saccon 2007
%%
%% @doc ErlyCairo: Erlang bindings for the Cairo 2D graphics library.
%%
%% This module contains functions for starting a c-node which binds
%% a subset of the cairo 2D graphics functions

%% For license information see LICENSE.txt

-module(erlycairo).

-define(CNodeNumber, 1).

-export([start/1,
         new_image_blank/2,
         write_to_png/1,
         close_image/0,
         save/0,
         restore/0,
         set_line_width/1,
         set_source_rgba/4,
         set_operator/1,
         move_to/2,
         line_to/2,
         curve_to/6,
         rel_move_to/2,
         rel_line_to/2,
         rel_curve_to/6,
         rectangle/4,
         arc/5,
         arc_negative/5,
         close_path/0,
         paint/0,
         fill/0,
         fill_preserve/0,
         stroke/0,
         stroke_preserve/0,
         translate/2,
         scale/2,
         rotate/1,
         select_font_face/3,
         set_font_size/1,
         show_text/1]).
 

%%=====================================================================
%%  API Functions
%%=====================================================================

 start(CNodeBinaryPath) -> 
   Number = integer_to_list(?CNodeNumber),
   Cookie = atom_to_list(erlang:get_cookie()),
   Node = atom_to_list(node()),
   Port = open_port({spawn, CNodeBinaryPath ++ " " ++ Number ++ " " ++ Cookie ++ " " ++ Node}, []),
   loop(Port).


%% @doc Creates a blank image.
%%
%% @spec new_image_blank(Width::integer(), Height::integer()) ->
%%     (ok | {error, Reason})
new_image_blank(Width, Height) ->
    call_cnode({new_image_blank, {Width, Height}}).

%% @doc Saves image as PNG file.
%%
%% @spec write_to_png(Filename::string()) ->
%%     (ok | {error, Reason})
write_to_png(Filename) ->
    call_cnode({write_to_png, {list_to_atom(Filename)}}).

%% @doc Closes image.
%%
%% @spec close_image() ->
%%     (ok | {error, Reason})
close_image() ->
    call_cnode({close_image, {}}).

%% @doc Saves current drawing context to stack.
%%
%% @spec save() ->
%%     (ok | {error, Reason})
save() ->
    call_cnode({save, {}}).

%% @doc Resores last drawing context from stack.
%%
%% @spec restore() ->
%%     (ok | {error, Reason})
restore() ->
    call_cnode({restore, {}}).

%% @doc Sets the current line width within the cairo context.
%%
%% @spec set_line_width(Width::integer() | Width::float()) ->
%%     (ok | {error, Reason})
set_line_width(Width) ->
    call_cnode({set_line_width, {Width}}).

%% @doc Sets the current line width within the cairo context.
%%
%% @spec set_source_rgba((Red::integer() | Red::float()),
%%                       (Green::integer() | Green::float()),
%%                       (Blue::integer() | Blue::float()),
%%                       (Alpha::integer() | Alpha::float())) ->     
%%     (ok | {error, Reason})
set_source_rgba(Red, Green, Blue, Alpha) ->
    call_cnode({set_source_rgba, {Red, Green, Blue, Alpha}}).

%% @doc Sets the current operator within the cairo context.
%%
%% @spec set_operator(Opertor::integer()) ->
%%     (ok | {error, Reason})
set_operator(Operator) ->
    call_cnode({set_operator, {Operator}}).

%% @doc Starts a new subpath, current point will be (X, Y).
%%
%% @spec move_to((X::integer() | X::float()),
%%               (Y::integer() | Y::float()))) ->
%%     (ok | {error, Reason})
move_to(X, Y) ->
    call_cnode({move_to, {X, Y}}).

%% @doc Adds a line to the path from the current point to position (X, Y)
%%
%% @spec line_to((X:integer() | X::float()),
%%               (Y::integer() | Y::float()))) ->
%%     (ok | {error, Reason})
line_to(X, Y) ->
    call_cnode({line_to, {X, Y}}).

%% @doc Adds a cubic Bezier spline to the path from the current point 
%% to position (X3, Y3) 
%%
%% @spec curve_to((X1::integer() | X1::float()),
%%                (Y1::integer() | Y1::float())
%                 (X2::integer() | X2::float()),
%%                (Y2::integer() | Y2::float())
%%                (X3::integer() | X3::float()),
%%                (Y3::integer() | Y3::float()))) ->
%%     (ok | {error, Reason})
curve_to(X1, Y1, X2, Y2, X3, Y3) ->
    call_cnode({curve_to, {X1, Y1, X2, Y2, X3, Y3}}).

%% @doc Relative-coordinate version of move_to().
%%
%% @spec rel_move_to((X::integer() | X::float()),
%%                   (Y::integer() | Y::float()))) ->
%%     (ok | {error, Reason})
rel_move_to(X, Y) ->
    call_cnode({rel_move_to, {X, Y}}).

%% @doc Relative-coordinate version of line_to().
%%
%% @spec rel_line_to((X::integer() | X::float()),
%%                   (Y::integer() | Y::float()))) ->
%%     (ok | {error, Reason})
rel_line_to(X, Y) ->
    call_cnode({rel_line_to, {X, Y}}).

%% @doc Relative-coordinate version of curve_to().
%% to position (X3, Y3) 
%%
%% @spec curve_to((X1::integer() | X1::float()),
%%                (Y1::integer() | Y1::float())
%%                (X2::integer() | X2::float()),
%%                (Y2::integer() | Y2::float())
%%                (X3::integer() | X3::float()),
%%                (Y3::integer() | Y3::float()))) ->
%%     (ok | {error, Reason})
rel_curve_to(X1, Y1, X2, Y2, X3, Y3) ->
    call_cnode({rel_curve_to, {X1, Y1, X2, Y2, X3, Y3}}).

%% @doc Adds a closed sub-path rectangle of the given size to the 
%% current path at position (X, Y) 
%%
%% @spec rectangle((X::integer() | X::float()),
%%                 (Y::integer() | Y::float())
%%                 (Width::integer() | Width::float()),
%%                 (Height::integer() | Height::float())) ->
%%     (ok | {error, Reason})
rectangle(X, Y, Width, Height) ->
    call_cnode({rectangle, {X, Y, Width, Height}}).

arc(X, Y, Radius, Ang1e1, Angle2) ->
    call_cnode({arc, {X, Y, Radius, Ang1e1, Angle2}}).

arc_negative(X, Y, Radius, Ang1e1, Angle2) ->
    call_cnode({arc_negative, {X, Y, Radius, Ang1e1, Angle2}}).

close_path() ->
    call_cnode({close_path, {}}).

paint() ->
    call_cnode({paint, {}}).

fill() ->
    call_cnode({fill, {}}).

fill_preserve() ->
    call_cnode({fill_preserve, {}}).

stroke() ->
    call_cnode({stroke, {}}).

stroke_preserve() ->
    call_cnode({stroke_preserve, {}}).

translate(TX, TY) ->
    call_cnode({translate, {TX, TY}}).

scale(SX, SY) ->
    call_cnode({scale, {SX, SY}}).

rotate(Angle) ->
    call_cnode({rotate, {Angle}}).

select_font_face(Family, Slant, Weight) ->
    call_cnode({select_font_face, {list_to_atom(Family), Slant, Weight}}).

set_font_size(Size) ->
    call_cnode({set_font_size, {Size}}).

show_text(Text) ->
    call_cnode({show_text, {list_to_atom(Text)}}).


%% ============================================
%% Internal functions
%% ============================================

loop(Port) ->
   receive
     Anything ->
       io:format("Received from erlycairo: ~p~n", [Anything]),
       loop(Port)
   end.


call_cnode(Msg) ->
    Hostname = string:strip(os:cmd("hostname -s"), right, $\n),
    Nodename = "c" ++ integer_to_list(?CNodeNumber) ++ "@" ++ Hostname,
    {any, list_to_atom(Nodename)} ! {call, self(), Msg},
    receive
	{cnode, Result} ->
	    Result
    end.