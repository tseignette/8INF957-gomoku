package ca.uqac.gomoku.aspect;

import java.util.List;

import javafx.scene.paint.Color;

import ca.uqac.gomoku.ui.App;
import ca.uqac.gomoku.core.Player;
import ca.uqac.gomoku.core.model.Spot;
import ca.uqac.gomoku.core.model.Grid;

public aspect FinJeu {
	
	Boolean over = false;
	Boolean winningStonesDrawn = false;
	List<Spot> winningStones;
	Grid grid;
	
	// End announce
	void around(Player p): call(* gameOver(Player)) && args(p) {
		if(!over) {
			over = true;
			
			System.out.println(p.getName()+" has won, the game is over!");

			Player winPlayer = new Player("Winner", Color.GOLD);
			winningStones.forEach(stone -> {
				grid.placeStone(stone.x, stone.y, winPlayer);
			});
			
			winningStonesDrawn = true;
		}
	}
	
	// Can't play after the game is over
	void around(): call(* stonePlaced(Spot)) {
		if(!over || !winningStonesDrawn) proceed();
	}
	
	// Winning stones color
	after(Grid grid): set(Grid App.gameGrid) && args(grid) {
		this.grid = grid;
	}
	
	after(List<Spot> stones): set(List<Spot> Grid.winningStones) && args(stones) {
		if(stones.size() >= 5 && !over) winningStones = stones;
	}

}
