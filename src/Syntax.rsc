module Syntax

extend lang::std::Id;
extend lang::std::Layout;

//start syntax Script
//  = {Statement  ";"}* body
//  ;
//  



keyword Keywords
  = "void" | "setup" | "draw" | "int" | "background" | "boolean" | "char" | "byte" | "color"
  | "double" | "float" | "long" | "clear" | "PGraphics" | "hint" | "clip" | "blendMode" | "beginDraw"
  | "endDraw" | "noClip" | "String" |"ARROW" | "CROSS" | "HAND" | "MOVE" | "TEXT" | "WAIT" | "delay"
  | "cursor" | "fullScreen" | "frameRate" | "size" | "noCursor" | "smooth" | "noSmooth" | "pixelDensity"
  | "height" | "width" | "mouseX" | "mouseY" | "fill" | "noFill" | "colorMode" | "noStroke" | "PImage"
  ;
  
syntax Phrase
  = //Expression ";"
  //| VarDecl
   Statement
  | assoc Phrase Phrase
  ;

syntax SetupFunction
  = "void" "setup" "(" ")" Statement 
  ;
  
syntax DrawFunction
  = "void" "draw" "(" ")" Statement 
  ;
  
syntax FunctionDecl
  = "void" Id "(" {Parameter ","}* ")" Statement
  ;  
  
syntax Parameter
  = Type tipo Id id
  ;

syntax Expression
  = BuiltInFunction builtinFunctions
  //| VarDecl varDecls
  //| Id id \ Keywords
  | bracket "(" Expression ")"
  > left Expression "*" Expression
  > left Expression "/" Expression
  >
  left (
      add: Expression "+" Expression
    | sub: Expression "-" Expression
  )
  > non-assoc Expression "\<" Expression
  > non-assoc Expression "\>" Expression
  > left Expression "&&" Expression
  > left Expression "!=" Expression
  //> left Expression "." Expression
  > Value val
  //| Expression "." Id "(" {Expression ","}* ")"
  ;

syntax Statement
  = "{" Statement* "}"
  | FunctionDecl
  | Expression ";"
  | \while: "while" "(" Expression ")" Statement
  | \for: "for" "(" Expression init ";" Expression test ";" Expression update ")" Statement
  | \if: "if" "(" Expression test ")" Statement ifBody 
  | ifElse: "if" "(" Expression test ")" Statement ifBody "else" Statement elseBody
  | assign: Id "=" Expression ";"
  | VarDecl ";"
  //| \switch: "switch"  "(" Expression ")" SwitchBlock
  ;

syntax BuiltInFunction
  = ColorSetting 
  | ColorCreating
  | Rendering
  | Shape
  | Environment
  | Input
  | Transform
  ;
  
syntax Transform
  = pushMatrix: "pushMatrix" "(" ")"
  | popMatrix: "popMatrix" "(" ")"
  | translate2d: "translate" "(" Expression x "," Expression y ")"
  | translate3d: "translate" "(" Expression x "," Expression y "," Expression z ")"
  ;  
  
syntax Input
  = mouseX: "mouseX"
  | mouseY: "mouseY"
  ;
  
syntax ColorCreating
  = color: "color" "(" Expression gray ")"
  | color2: "color" "(" Expression gray "," Expression alpha ")"
  | color3: "color" "(" Expression v1 "," Expression v2 "," Expression v3 ")"
  | color4: "color" "(" Expression v1 "," Expression v2 "," Expression v3 "," Expression alpha ")"
  ;  
  
syntax Environment
  = size: "size" "(" Expression width "," Expression height ")" 
  | frameRate: "frameRate" "(" FloatValue fps")"
  | fullScreen: "fullscreen" "(" ")"
  | cursor: "cursor" "(" CursorType typ "," IntegerValue x "," IntegerValue y ")"
  | delay: "delay" "(" IntegerValue napTime ")"
  | noCursor: "noCursor" "(" ")"
  | smooth: "smooth" "(" IntegerValue level")"
  | noSmooth: "noSmooth" "(" ")"
  | pixelDensity: "pixelDensity" "(" IntegerValue density ")"
  | width: "width"
  | height: "height"
  | focused: "focused"
  ;
  
syntax CursorType
  = "ARROW"
  | "CROSS"
  | "HAND"
  | "MOVE"
  | "TEXT"
  | "WAIT" 
  ;
  
syntax Shape
  = "arc" "(" FloatValue x "," FloatValue y "," FloatValue width "," FloatValue height "," FloatValue start  "," FloatValue stop ")" 
  | "circle" "(" FloatValue x "," FloatValue y "," FloatValue extent ")"
  | "ellipse" "(" FloatValue x "," FloatValue y "," FloatValue width "," FloatValue height ")"
  | "line" "(" FloatValue x1 "," FloatValue y1 "," FloatValue x2 "," FloatValue y2 ")"
  | "line" "(" FloatValue x1 "," FloatValue y1 "," FloatValue z1 "," FloatValue x2 "," FloatValue y2 "," FloatValue z2 ")"
  | "point" "(" FloatValue x "," FloatValue y ")"
  | "point" "(" FloatValue x "," FloatValue y "," FloatValue z ")"
  | "quad" "(" FloatValue x1 "," FloatValue y1 "," FloatValue x2 "," FloatValue y2 "," FloatValue x3 "," FloatValue y3 "," FloatValue x4 "," FloatValue y4 ")"
  | "rect" "(" Expression x "," Expression y "," Expression width "," Expression height ")"
  | "rect" "(" Expression x "," Expression y "," Expression width "," Expression height "," Expression radius ")"
  | "rect" "(" Expression x "," Expression y "," Expression width "," Expression height "," Expression tlradius "," Expression trradius "," Expression brradius "," Expression blradius ")"
  | "square" "(" FloatValue x "," FloatValue y "," FloatValue extent ")"
  | "triangle" "(" FloatValue x1 "," FloatValue y1 "," FloatValue x2 "," FloatValue y2 "," FloatValue x3 "," FloatValue y3 ")"
  ;
  
syntax Rendering
  = "createGraphics" "(" IntegerValue w "," IntegerValue h ")"
  | "createGraphics" "(" IntegerValue w "," IntegerValue h "," StringValue renderer ")"
  | "createGraphics" "(" IntegerValue w "," IntegerValue h "," StringValue renderer "," StringValue path ")"
  | "beginDraw" "(" ")"
  | "endDraw" "(" ")" 
  | "blendMode" "(" IntegerValue mode ")"
  | "clip" "(" FloatValue x"," FloatValue y "," FloatValue width "," FloatValue height")"
  | "hint" "(" IntegerValue hint_mode ")"
  | "noClip""("")"
  ;  
  
syntax ColorSetting
  = Background
  | clear: "clear" "("")"
  | fill: "fill" "(" Expression rgb ")"
  | fill2: "fill" "(" Expression rgb"," Expression alpha")"
  //| fill3: "fill" "(" Expression gray ")"
  //| fill4: "fill" "(" Expression gray "," Expression alpha")"
  | fill5: "fill" "(" Expression v1 "," Expression v2  "," Expression v3")"
  | fill6: "fill" "(" Expression v1 "," Expression v2  "," Expression v3  "," Expression alpha")"
  | noFill: "noFill" "(" ")"
  | colorMode: "colorMode" "(" ColorMode")"
  | colorMode2: "colorMode" "(" ColorMode "," FloatValue max ")"
  | colorMode3: "colorMode" "(" ColorMode "," Expression max "," Expression max2 "," Expression max3 ")"
  | colorMode3: "colorMode" "(" ColorMode "," FloatValue max "," FloatValue max2 "," FloatValue max3 "," FloatValue alpha")"
  | noStroke: "noStroke" "(" ")"
  ;
  
syntax ColorMode
  = rgb: "RGB"
  | hsb: "HSB" 
  ;
  
syntax Background
  = "background" "(" Expression rgb ")"
  | "background" "(" Expression rgb "," Expression alpha")"
  | "background" "(" Expression v1 "," Expression v2 "," Expression v3 ")"
  | "background" "(" Expression v1 "," Expression v2 "," Expression v3 "," Expression alpha ")"
  ;
  
syntax VarDecl
  = Type Id
  | Type Id "=" Expression
  ;
  
syntax Value
  = IntegerValue
  | FloatValue
  | StringValue
  > Id \ Keywords
  ;
  
syntax Type
  = "int"
  | "boolean"
  | "byte"
  | "char"
  | "color"
  | "double"
  | "flot"
  | "long"
  | "PGraphics"
  | "PImage"
  | "String"
  > Id \Keywords
  ;  
  
lexical IntegerValue
  =[+\-]? [0-9]+ !>> [0-9]
  ;
  
lexical FloatValue
  = [0-9]+ "." [0-9]+;
  
lexical StringValue 
  = "\"" ![\"]*  "\"";
  