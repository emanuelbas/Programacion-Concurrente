//No esta corregido

program elPorteroConCoordinador
var
	chan pedir_entrar();
	chan esperando_puerta[N]();
	puerta_abierta();
	llegaron_todos();
begin
	procedure corredor[c:1..N]
		begin
			send pedir_entrar();
			receive esperando_puerta[c]();
			//El corredor pasa a la pista	
		end;

		procedure portero
		begin
			receive llegaron_todos();
			//El portero abre la puerta
			send puerta_abierta();
		end;

		procedure coordinador
		begin
			for i:=1 to N
				receive pedir_entrar();
			send llegaron_todos();
			receive puerta_abierta();
			for i:=1 to N
				send esperando_puerta[i]();
		end;
end;

program elPorteroSinCoordinador
var
	chan pedir_entrar();
	chan esperando_puerta[N]();
begin
	procedure corredor[c:1..N]
		begin
			send pedir_entrar();
			receive esperando_puerta[c]();
			//El corredor pasa a la pista	
		end;

		procedure portero
		begin
			for i:=1 to N
				receive pedir_entrar();
			//El portero abre la puerta
			for i:=1 to N
				send esperando_puerta[i]();
		end;
end;