(* Code generation: translate takes a semantically checked AST and
produces LLVM IR

LLVM tutorial: Make sure to read the OCaml version of the tutorial

http://llvm.org/docs/tutorial/index.html

Detailed documentation on the OCaml LLVM library:

http://llvm.moe/
http://llvm.moe/ocaml/

*)

module L = Llvm
module A = Ast
open Sast 

module StringMap = Map.Make(String)

(* translate : Sast.program -> Llvm.module *)
let translate (globals, functions) =
  let context    = L.global_context () in
  
  (* Create the LLVM compilation module into which
     we will generate code *)
  let the_module = L.create_module context "textPlusPlus" in

  (* Get types from the context *)
  let i32_t      = L.i32_type    context
  and i1_t       = L.i1_type     context
  and float_t    = L.double_type context
  and str_t      = L.pointer_type (L.i8_type context)
  and void_t     = L.void_type   context in

  (* Return the LLVM type for a textPlusPlus type *)
  let ltype_of_typ = function
      A.Int   -> i32_t
    | A.Bool  -> i1_t
    | A.Float -> float_t
    | A.Void  -> void_t
    | A.String -> str_t
  in

  (* Create a map of global variables after creating each *)
  let global_vars : L.llvalue StringMap.t =
    let global_var m (t, n) = 
      let init = match t with
          A.Float -> L.const_float (ltype_of_typ t) 0.0
        | _ -> L.const_int (ltype_of_typ t) 0
      in StringMap.add n (L.define_global n init the_module) m in
    List.fold_left global_var StringMap.empty globals in


  let addPage_t : L.lltype =
      L.function_type i32_t [| |] in
  let addPage_func : L.llvalue =
      L.declare_function "addPage" addPage_t the_module in



  let left_t : L.lltype =
    L.function_type i32_t [| |] in
  let left_func : L.llvalue =
      L.declare_function "left" left_t the_module in
    
  let right_t : L.lltype =
    L.function_type i32_t [| |] in
  let right_func : L.llvalue =
      L.declare_function "right" right_t the_module in

  let center_t : L.lltype =
    L.function_type i32_t [| |] in
  let center_func : L.llvalue =
      L.declare_function "center" center_t the_module in

  let write_t : L.lltype =
    L.function_type i32_t [| str_t |] in
  let write_func : L.llvalue =
      L.declare_function "write" write_t the_module in

  let textOut_t : L.lltype =
    L.function_type i32_t [| i32_t ; i32_t ; str_t|] in
  let textOut_func : L.llvalue =
      L.declare_function "textOut" textOut_t the_module in 

  let moveTo_t : L.lltype =
    L.function_type i32_t [| i32_t; i32_t |] in
  let moveTo_func : L.llvalue =
      L.declare_function "moveTo" moveTo_t the_module in  
  


  let bold_t : L.lltype =
      L.function_type i32_t [| |] in
  let bold_func : L.llvalue =
      L.declare_function "bold" bold_t the_module in
      
    let italic_t : L.lltype =
      L.function_type i32_t [| |] in
  let italic_func : L.llvalue =
      L.declare_function "italic" italic_t the_module in
      
  let regular_t : L.lltype =
      L.function_type i32_t [| |] in
  let regular_func : L.llvalue =
      L.declare_function "regular" regular_t the_module in
      
  let changeColor_t : L.lltype =
    L.function_type i32_t [| float_t; float_t; float_t |] in
  let changeColor_func : L.llvalue =
      L.declare_function "changeColor" changeColor_t the_module in
  
  let changeFontSize_t : L.lltype =
      L.function_type i32_t [| str_t; i32_t |] in
  let changeFontSize_func : L.llvalue =
      L.declare_function "changeFontSize" changeFontSize_t the_module in
      


  let drawLine_t : L.lltype =
      L.function_type i32_t [| i32_t; i32_t; i32_t; i32_t |] in
  let drawLine_func : L.llvalue =
      L.declare_function "drawLine" drawLine_t the_module in    
      
  let drawRectangle_t : L.lltype =
      L.function_type i32_t [| i32_t; i32_t; i32_t; i32_t |] in
  let drawRectangle_func : L.llvalue =
      L.declare_function "drawRectangle" drawRectangle_t the_module in 
  
      

  let pageNumber_t : L.lltype =
    L.function_type i32_t [| i32_t; i32_t |] in
  let pageNumber_func : L.llvalue =
      L.declare_function "pageNumber" pageNumber_t the_module in

  let getTextWidth_t : L.lltype =
    L.function_type i32_t [| str_t |] in
  let getTextWidth_func : L.llvalue =
      L.declare_function "getTextWidth" getTextWidth_t the_module in
 
  let getPageHeight_t : L.lltype =
    L.function_type i32_t [|  |] in
  let getPageHeight_func : L.llvalue =
      L.declare_function "getPageHeight" getPageHeight_t the_module in

  let getPageWidth_t : L.lltype =
    L.function_type i32_t [|  |] in
  let getPageWidth_func : L.llvalue =
      L.declare_function "getPageWidth" getPageWidth_t the_module in
  

  
  let pageTitle_t : L.lltype =
      L.function_type i32_t [| str_t |] in
  let pageTitle_func : L.llvalue =
      L.declare_function "pageTitle" pageTitle_t the_module in
      
  let table_t : L.lltype =
    L.function_type i32_t [| i32_t; i32_t; i32_t; i32_t |] in
  let table_func : L.llvalue =
      L.declare_function "table" table_t the_module in 

  let heading1_t : L.lltype =
    L.function_type i32_t [| |] in
  let heading1_func : L.llvalue =
    L.declare_function "heading1" heading1_t the_module in
  let heading2_t : L.lltype =
    L.function_type i32_t [| |] in
  let heading2_func : L.llvalue =
    L.declare_function "heading2" heading2_t the_module in
  let heading3_t : L.lltype =
    L.function_type i32_t [| |] in
  let heading3_func : L.llvalue =
    L.declare_function "heading3" heading3_t the_module in
  let heading4_t : L.lltype =
    L.function_type i32_t [| |] in
  let heading4_func : L.llvalue =
    L.declare_function "heading4" heading4_t the_module in
  let heading5_t : L.lltype =
    L.function_type i32_t [| |] in
  let heading5_func : L.llvalue =
    L.declare_function "heading5" heading5_t the_module in
  let heading6_t : L.lltype =
    L.function_type i32_t [| |] in
  let heading6_func : L.llvalue =
    L.declare_function "heading6" heading6_t the_module in
  let getCurrentY_t : L.lltype =
  L.function_type i32_t [| |] in
  let getCurrentY_func : L.llvalue =
    L.declare_function "getCurrentY" getCurrentY_t the_module in
  let getCurrentX_t : L.lltype =
  L.function_type i32_t [| |] in
  let getCurrentX_func : L.llvalue =
    L.declare_function "getCurrentX" getCurrentX_t the_module in
  let getCapHeight_t : L.lltype =
  L.function_type i32_t [| |] in
  let getCapHeight_func : L.llvalue =
    L.declare_function "getCapHeight" getCapHeight_t the_module in
  let getLowHeight_t : L.lltype =
  L.function_type i32_t [| |] in
  let getLowHeight_func : L.llvalue =
    L.declare_function "getLowHeight" getLowHeight_t the_module in
  let getTextBytes_t : L.lltype =
  L.function_type i32_t [| str_t; i32_t; i32_t |] in
  let getTextBytes_func : L.llvalue =
    L.declare_function "getTextBytes" getTextBytes_t the_module in
    (***)
  let setRMargin_t : L.lltype =
  L.function_type i32_t [| i32_t|] in
  let setRMargin_func : L.llvalue =
  L.declare_function "setRMargin" setRMargin_t the_module in
  let setLMargin_t : L.lltype =
  L.function_type i32_t [| i32_t|] in
  let setLMargin_func : L.llvalue =
  L.declare_function "setLMargin" setLMargin_t the_module in
  let setTopMargin_t : L.lltype =
  L.function_type i32_t [| i32_t |] in
  let setTopMargin_func : L.llvalue =
  L.declare_function "setTopMargin" setTopMargin_t the_module in
  let setBotMargin_t : L.lltype =
  L.function_type i32_t [| i32_t |] in
  let setBotMargin_func : L.llvalue =
  L.declare_function "setBotMargin" setBotMargin_t the_module in

  (* Define each function (arguments and return type) so we can 
     call it even before we've created its body *)
  let function_decls : (L.llvalue * sfunc_decl) StringMap.t =
    let function_decl m fdecl =
      let name = fdecl.sfname
      and formal_types = 
	Array.of_list (List.map (fun (t,_) -> ltype_of_typ t) fdecl.sformals)
      in let ftype = L.function_type (ltype_of_typ fdecl.styp) formal_types in
      StringMap.add name (L.define_function name ftype the_module, fdecl) m in
    List.fold_left function_decl StringMap.empty functions in
  
  (* Fill in the body of the given function *)
  let build_function_body fdecl =
    let (the_function, _) = StringMap.find fdecl.sfname function_decls in
    let builder = L.builder_at_end context (L.entry_block the_function) in

    (* Construct the function's "locals": formal arguments and locally
       declared variables.  Allocate each on the stack, initialize their
       value, if appropriate, and remember their values in the "locals" map *)
    let local_vars =
      let add_formal m (t, n) p = 
        L.set_value_name n p;
	let local = L.build_alloca (ltype_of_typ t) n builder in
        ignore (L.build_store p local builder);
	StringMap.add n local m 

      (* Allocate space for any locally declared variables and add the
       * resulting registers to our map *)
      and add_local m (t, n) =
	let local_var = L.build_alloca (ltype_of_typ t) n builder
	in StringMap.add n local_var m 
      in

      let formals = List.fold_left2 add_formal StringMap.empty fdecl.sformals
          (Array.to_list (L.params the_function)) in
      List.fold_left add_local formals fdecl.slocals 
    in

    (* Return the value for a variable or formal argument.
       Check local names first, then global names *)
    let lookup n = try StringMap.find n local_vars
                   with Not_found -> StringMap.find n global_vars
    in

    (* Construct code for an expression; return its value *)
    let rec expr builder ((_, e) : sexpr) = match e with
	      SLiteral i  -> L.const_int i32_t i
      | SStrLiteral i -> L.build_global_stringptr i "string" builder
      | SBoolLit b  -> L.const_int i1_t (if b then 1 else 0)
      | SFliteral l -> L.const_float_of_string float_t l
      | SNoexpr     -> L.const_int i32_t 0
      | SId s       -> L.build_load (lookup s) s builder
      | SAssign (s, e) -> let e' = expr builder e in
                          ignore(L.build_store e' (lookup s) builder); e'
      | SBinop ((A.Float,_ ) as e1, op, e2) ->
	  let e1' = expr builder e1
	  and e2' = expr builder e2 in
	  (match op with 
	    A.Add     -> L.build_fadd
	  | A.Sub     -> L.build_fsub
	  | A.Mult    -> L.build_fmul
	  | A.Div     -> L.build_fdiv 
	  | A.Equal   -> L.build_fcmp L.Fcmp.Oeq
	  | A.Neq     -> L.build_fcmp L.Fcmp.One
	  | A.Less    -> L.build_fcmp L.Fcmp.Olt
	  | A.Leq     -> L.build_fcmp L.Fcmp.Ole
	  | A.Greater -> L.build_fcmp L.Fcmp.Ogt
	  | A.Geq     -> L.build_fcmp L.Fcmp.Oge
	  | A.And | A.Or ->
	      raise (Failure "internal error: semant should have rejected and/or on float")
	  ) e1' e2' "tmp" builder
      | SBinop (e1, op, e2) ->
	  let e1' = expr builder e1
	  and e2' = expr builder e2 in
	  (match op with
	    A.Add     -> L.build_add
	  | A.Sub     -> L.build_sub
	  | A.Mult    -> L.build_mul
          | A.Div     -> L.build_sdiv
	  | A.And     -> L.build_and
	  | A.Or      -> L.build_or
	  | A.Equal   -> L.build_icmp L.Icmp.Eq
	  | A.Neq     -> L.build_icmp L.Icmp.Ne
	  | A.Less    -> L.build_icmp L.Icmp.Slt
	  | A.Leq     -> L.build_icmp L.Icmp.Sle
	  | A.Greater -> L.build_icmp L.Icmp.Sgt
	  | A.Geq     -> L.build_icmp L.Icmp.Sge
	  ) e1' e2' "tmp" builder
      | SUnop(op, ((t, _) as e)) ->
          let e' = expr builder e in
	  (match op with
	    A.Neg when t = A.Float -> L.build_fneg 
	  | A.Neg                  -> L.build_neg
          | A.Not                  -> L.build_not) e' "tmp" builder


    | SCall ("addPage", []) ->
      L.build_call addPage_func [| |] "addPage" builder
    
    | SCall ("left", []) ->
      L.build_call left_func [| |] "left" builder
    | SCall ("right", []) ->
      L.build_call right_func [| |] "right" builder
    | SCall ("center", []) ->
      L.build_call center_func [| |] "center" builder

    | SCall ("write", [e]) ->
      L.build_call write_func [| (expr builder e) |] "write" builder
    | SCall ("textOut", [e; y; z]) ->
      L.build_call textOut_func [| (expr builder e); (expr builder y); (expr builder z) |] "textOut" builder
    | SCall ("moveTo", [e; y]) ->
      L.build_call moveTo_func [| (expr builder e); (expr builder y)|] "moveTo" builder	  

    | SCall ("bold", []) ->
      L.build_call bold_func [|  |] "bold" builder
    | SCall ("italic", []) ->
      L.build_call italic_func [|  |] "italic" builder 
    | SCall ("regular", []) ->
      L.build_call regular_func [|  |] "regular" builder 
    | SCall ("changeColor", [e; y; z]) ->
      L.build_call changeColor_func [| (expr builder e); (expr builder y); (expr builder z) |] "changeColor" builder
    | SCall ("changeFontSize", [e ; y]) ->
      L.build_call changeFontSize_func [| (expr builder e); (expr builder y)  |] "changeFontSize" builder
  
    | SCall ("drawLine", [e; y; z; a]) ->
      L.build_call drawLine_func [| (expr builder e); (expr builder y); (expr builder z); (expr builder a)|] "drawLine" builder
    | SCall ("drawRectangle", [e; y; z; a]) ->
      L.build_call drawRectangle_func [| (expr builder e); (expr builder y); (expr builder z); (expr builder a) |] "drawRectangle" builder
  
    | SCall ("pageNumber", [e; y]) ->
      L.build_call pageNumber_func [|(expr builder e); (expr builder y) |] "pageNumber" builder      
    | SCall ("getTextWidth", [e]) ->
      L.build_call getTextWidth_func [| (expr builder e) |] "getTextWidth" builder
    | SCall ("getPageHeight", []) ->
      L.build_call getPageHeight_func [| |] "getPageHeight" builder  
    | SCall ("getPageWidth", []) ->
      L.build_call getPageWidth_func [| |] "getPageWidth" builder      

    | SCall ("pageTitle", [e]) ->
      L.build_call pageTitle_func [| (expr builder e) |] "pageTitle" builder
    | SCall ("table", [e; y; z; a]) ->
      L.build_call table_func [| (expr builder e); (expr builder y); (expr builder z); (expr builder a) |] "table" builder 

    | SCall ("heading1", []) ->
      L.build_call heading1_func [| |] "heading1" builder  
    | SCall ("heading2", []) ->
      L.build_call heading2_func [| |] "heading2" builder  
    | SCall ("heading3", []) ->
      L.build_call heading3_func [| |] "heading3" builder  
    | SCall ("heading4", []) ->
      L.build_call heading4_func [| |] "heading4" builder  
    | SCall ("heading5", []) ->
      L.build_call heading5_func [| |] "heading5" builder  
    | SCall ("heading6", []) ->
      L.build_call heading6_func [| |] "heading6" builder
    | SCall ("getCurrentY", []) ->
      L.build_call getCurrentY_func [| |] "getCurrentY" builder 
    | SCall ("getCurrentX", []) ->
      L.build_call getCurrentX_func [| |] "getCurrentX" builder
    | SCall ("getCapHeight", []) ->
      L.build_call getCapHeight_func [| |] "getCapHeight" builder
    | SCall ("getLowHeight", []) ->
      L.build_call getLowHeight_func [| |] "getLowHeight" builder
    | SCall ("getTextBytes", [x;y;z]) ->
      L.build_call getTextBytes_func [| (expr builder x); (expr builder y); (expr builder z) |] "getTextBytes" builder
    | SCall ("setRMargin", [e]) ->
      L.build_call setRMargin_func [| (expr builder e) |] "setRMargin" builder
    | SCall ("setLMargin", [e]) ->
      L.build_call setLMargin_func [| (expr builder e) |] "setLMargin" builder
    | SCall ("setTopMargin", [e]) ->
      L.build_call setTopMargin_func [| (expr builder e) |] "setTopMargin" builder
    | SCall ("setBotMargin", [e]) ->
      L.build_call setBotMargin_func [| (expr builder e) |] "setBotMargin" builder


	  
      | SCall (f, args) ->
         let (fdef, fdecl) = StringMap.find f function_decls in
	 let llargs = List.rev (List.map (expr builder) (List.rev args)) in
	 let result = (match fdecl.styp with 
                        A.Void -> ""
                      | _ -> f ^ "_result") in
         L.build_call fdef (Array.of_list llargs) result builder
    in
    
    (* LLVM insists each basic block end with exactly one "terminator" 
       instruction that transfers control.  This function runs "instr builder"
       if the current block does not already have a terminator.  Used,
       e.g., to handle the "fall off the end of the function" case. *)
    let add_terminal builder instr =
      match L.block_terminator (L.insertion_block builder) with
	Some _ -> ()
      | None -> ignore (instr builder) in
	
    (* Build the code for the given statement; return the builder for
       the statement's successor (i.e., the next instruction will be built
       after the one generated by this call) *)

    let rec stmt builder = function
	SBlock sl -> List.fold_left stmt builder sl
      | SExpr e -> ignore(expr builder e); builder 
      | SReturn e -> ignore(match fdecl.styp with
                              (* Special "return nothing" instr *)
                              A.Void -> L.build_ret_void builder 
                              (* Build return statement *)
                            | _ -> L.build_ret (expr builder e) builder );
                     builder
      | SIf (predicate, then_stmt, else_stmt) ->
         let bool_val = expr builder predicate in
	 let merge_bb = L.append_block context "merge" the_function in
         let build_br_merge = L.build_br merge_bb in (* partial function *)

	 let then_bb = L.append_block context "then" the_function in
	 add_terminal (stmt (L.builder_at_end context then_bb) then_stmt)
	   build_br_merge;

	 let else_bb = L.append_block context "else" the_function in
	 add_terminal (stmt (L.builder_at_end context else_bb) else_stmt)
	   build_br_merge;

	 ignore(L.build_cond_br bool_val then_bb else_bb builder);
	 L.builder_at_end context merge_bb

      | SWhile (predicate, body) ->
	  let pred_bb = L.append_block context "while" the_function in
	  ignore(L.build_br pred_bb builder);

	  let body_bb = L.append_block context "while_body" the_function in
	  add_terminal (stmt (L.builder_at_end context body_bb) body)
	    (L.build_br pred_bb);

	  let pred_builder = L.builder_at_end context pred_bb in
	  let bool_val = expr pred_builder predicate in

	  let merge_bb = L.append_block context "merge" the_function in
	  ignore(L.build_cond_br bool_val body_bb merge_bb pred_builder);
	  L.builder_at_end context merge_bb

      (* Implement for loops as while loops *)
      | SFor (e1, e2, e3, body) -> stmt builder
	    ( SBlock [SExpr e1 ; SWhile (e2, SBlock [body ; SExpr e3]) ] )
    in

    (* Build the code for each statement in the function *)
    let builder = stmt builder (SBlock fdecl.sbody) in

    (* Add a return if the last block falls off the end *)
    add_terminal builder (match fdecl.styp with
        A.Void -> L.build_ret_void
      | A.Float -> L.build_ret (L.const_float float_t 0.0)
      | t -> L.build_ret (L.const_int (ltype_of_typ t) 0))
  in

  List.iter build_function_body functions;
  the_module
