package ca.uqac.gomoku.aspect;

import ca.uqac.gomoku.core.Player;
import ca.uqac.gomoku.core.model.Spot;

public aspect FinJeu {
	
	Boolean over = false;
	
	// End announce
	void around(Player p): call(* gameOver(Player)) && args(p) {
		if(!over) System.out.println(p.getName()+" has won, the game is over!");
		over = true;
	}
	
	// Can't play after the game is over
	void around(): call(* stonePlaced(Spot)) {
		if(!over) proceed();
	}

}
