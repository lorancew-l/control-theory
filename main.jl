using DifferentialEquations
using Plots

m = 0.01
M = 0.1
l = 0.5
T = 5
g = 9.8
F = 0


start_angular_velocity = 0
start_angle = pi / 10
start_positon = 0
start_velocity = 0


b = m / (m + M)

function f(du, u, p, t)
     θ = u[1]
     ω = u[2]
     v = u[4]

     du[1] = ω
     du[2] = (g * sin(θ) + b * l * ω^2 * sin(θ) * cos(θ)) / (l * (1 + b * (cos(θ))^2))
     du[3] = v
     du[4] = (l * ω^2 * sin(θ) - g * sin(θ) * cos(θ)) / (1 + b * (cos(θ))^2)
end


u0 = [start_angle, start_angular_velocity, start_positon, start_velocity]
tspan = (0.0, T)
prob = ODEProblem(f, u0, tspan)
sol = solve(prob)

diff_plot = plot(sol, labels=["θ" "ω" "x" "v"], layout=4)
savefig(diff_plot, "plot.png")