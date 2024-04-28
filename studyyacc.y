%{
#include <stdio.h>
#include <stdlib.h>
%}

%token NUM
%left '+' '-'
%left '*' '/'

%%

expr: expr '+' expr   { $$ = $1 + $3; }
    | expr '-' expr   { $$ = $1 - $3; }
    | expr '*' expr   { $$ = $1 * $3; }
    | expr '/' expr   { $$ = $1 / $3; }
    | '(' expr ')'    { $$ = $2; }
    | NUM             { $$ = $1; }
    ;

%%

int main() {
    printf("Enter an arithmetic expression: ");
    yyparse();
    return 0;
}

int yylex() {
    int token = getchar();
    if (token >= '0' && token <= '9') {
        ungetc(token, stdin);
        int num;
        scanf("%d", &num);
        return num;
    }
    return token;
}

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}
