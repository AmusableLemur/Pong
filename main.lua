function love.load()
	math.randomseed(os.time())
	math.random(0, 360)
	
	love.graphics.setFont(love.graphics.newFont(20))
	love.graphics.setColor(0, 255, 0)
	love.graphics.setBackgroundColor(0, 0, 0)
	
	playerX = 10;
	playerY = love.graphics.getHeight() / 2 - 50;
	
	enemyX = love.graphics.getWidth() - 30;
	enemyY = love.graphics.getHeight() / 2 - 50;
	
	ballX = love.graphics.getWidth() / 2 - 10
	ballY = love.graphics.getHeight() / 2 - 10
	
	ballSpeed = 700
	ballDirection = math.rad(math.random(325, 395))
	
	ballSpeedX = math.cos(ballDirection) * ballSpeed
	ballSpeedY = math.sin(ballDirection) * ballSpeed
	
	gameOver = false
	gameStarted = os.time()
end

function love.focus(f)
	gameIsPaused = not f
end

function love.update(dt)
	if gameIsPaused or os.time() < (gameStarted + 1) or gameOver == true then
		return
	end
	
	if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
		if playerY >= 12 then
			playerY = playerY - 300 * dt
		end
	end
	
	if love.keyboard.isDown('down') or love.keyboard.isDown('s') then
		if playerY <= (love.graphics.getHeight() - 112) then
			playerY = playerY + 300 * dt
		end
	end
	
	ballX = ballX + ballSpeedX * dt
	ballY = ballY + ballSpeedY * dt
	
	if ballX < 0 then
		gameOver = true
		ballSpeed = 0
	end
	
	if ballY > playerY and (ballY - 20) < (playerY + 100) and ballX < (playerX + 20) then
		ballSpeedX = -ballSpeedX
	end
	
	if ballX > (love.graphics.getWidth() - 50) then
		ballSpeedX = -ballSpeedX
	end
	
	if ballY < 0 or ballY > (love.graphics.getHeight() - 20) then
		ballSpeedY = -ballSpeedY
	end
	
	if ballY >= 62 and ballY <= (love.graphics.getHeight() - 62) then
		enemyY = ballY - 50
	end
end

function love.draw()
	love.graphics.rectangle('fill', playerX, playerY, 20, 100)
	love.graphics.rectangle('fill', enemyX, enemyY, 20, 100)
	love.graphics.rectangle('fill', ballX, ballY, 20, 20)
	
	if gameOver then
		love.graphics.print('Du är för dålig för att spela pong', love.graphics.getWidth() / 2 - 150, love.graphics.getHeight() / 2 - 30)
	end
end