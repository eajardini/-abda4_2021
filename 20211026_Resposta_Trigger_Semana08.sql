Questão: tr003

Desenvolva um trigger que:

Evento: antes

Operação: insert ou update

Tabela: cursa

Regra de negócio: os atributos da tabela cursa_nota1, cursa_nota2, cursa_nota3 e cursa_nota4 não podem ter valores abaixo de 0 (zero) nem acima de 10 (dez).


CREATE or REPLACE FUNCTION f_verifica_nota()
    RETURNS trigger
    LANGUAGE 'plpgsql'
     NOT LEAKPROOF
AS $$
begin
	IF NEW.cursa_nota1 < 0 or NEW.cursa_nota1 > 10 THEN
		raise 'Nota abaixo de 0 ou acima de 10' using ERRCODE = 'EHO01';
	end if;
	
	IF NEW.cursa_nota2 < 0 or NEW.cursa_nota2 > 10 THEN
		raise 'Nota abaixo de 0 ou acima de 10' using ERRCODE = 'EHO02';
	end if;
	
	IF NEW.cursa_nota3 < 0 or NEW.cursa_nota3 > 10 THEN
		raise 'Nota abaixo de 0 ou acima de 10' using ERRCODE = 'EHO03';
	end if;
	
	IF NEW.cursa_nota4 < 0 or NEW.cursa_nota4 > 10 THEN
		raise 'Nota abaixo de 0 ou acima de 10' using ERRCODE = 'EHO04';
	end if;
	
	return NEW;
end;
$$;

-- drop function f_verifica_nota();
create trigger t_verifica_nota
before insert or update
on cursa for each row
execute procedure f_verifica_nota();


-- Teste
INSERT INTO public.cursa(
	cursa_alu_id, cursa_alu_discip, cursa_nota1, cursa_nota2, cursa_nota3, cursa_nota4)
	VALUES (101, 1, 8, 0, 0, 11);


Questão 02)

(ENADE) Em um Banco de Dados PostgreSQL, Joana precisa criar uma trigger para inserir dados na tabela
de auditoria chamada AGENTE_AUDIT todas as vezes que um registro da tabela AGENTE for efetivamente
excluído. Para isso, considerando que a função "agente_removido()" já esteja implementada, Joana utilizará o comando:
Resposta:
CREATE TRIGGER audit_agente AFTER DELETE ON agente FOR EACH ROW EXECUTE PROCEDURE agente_removido();
