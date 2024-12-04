%{
#include <stdio.h>
#include <ctype.h>

int line_number = 1; // Line counter
%}

%%
"else"      { printf("ELSE "); }
"if"        { printf("IF "); }
"int"       { printf("INT "); }
"return"    { printf("RETURN "); }
"void"      { printf("VOID "); }
"while"     { printf("WHILE "); }

"+"         { printf("PLUS "); }
"-"         { printf("MINUS "); }
"*"         { printf("TIMES "); }
"/"         { printf("DIV "); }
"<="        { printf("LEQ "); }
"<"         { printf("LT "); }
">="        { printf("GEQ "); }
">"         { printf("GT "); }
"=="        { printf("EQ "); }
"!="        { printf("NEQ "); }
"="         { printf("ASSIGN "); }

","         { printf("COMMA "); }
";"         { printf("SEMICOLON "); }
"\("        { printf("LPAREN "); }
"\)"        { printf("RPAREN "); }
"\["        { printf("LBRACKET "); }
"\]"        { printf("RBRACKET "); }
"\{"        { printf("LBRACE "); }
"\}"        { printf("RBRACE "); }

[0-9]+      { printf("NUMBER(%s) ", yytext); }

[a-zA-Z][a-zA-Z0-9]* {
    printf("ID(%s) ", yytext);
}

[ \t]+      { /* Ignore spaces and tabs */ }

\n          { printf("\n"); line_number++; }

"/*"([^*]|\*+[^*/])*\*+\/ { /* Ignore block comments */ }
"//"[^\n]* { /* Ignore single-line comments */ }

.           { fprintf(stderr, "Unknown character: %c\n", yytext[0]); }

%%

int main(int argc, char **argv) {
    // Check if an input file is provided
    if (argc > 1) {
        FILE *input = fopen(argv[1], "r");
        if (!input) {
            perror("Error opening file");
            return 1;
        }
        yyin = input;
    }

    // Start lexical analysis
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}