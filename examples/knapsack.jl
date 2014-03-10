#############################################################################
# JuMP
# An algebraic modelling langauge for Julia
# See http://github.com/JuliaOpt/JuMP.jl
#############################################################################
# knapsack.jl
#
# Solves a simple knapsack problem:
# max sum(p_j x_j)
#  st sum(w_j x_j) <= C
#     x binary
#############################################################################

using JuMP

# Maximization problem
m = Model()

@defVar(m, x[1:5], Bin)

profit = [ 5, 3, 2, 7, 4 ]
weight = [ 2, 8, 4, 2, 5 ]
capacity = 10

# Objective: maximize profit
@setObjective(m, Max, dot(profit, x))

# Constraint: can carry all
@addConstraint(m, dot(weight, x) <= capacity)

# Solve problem using MIP solver
status = solve(m)

println("Objective is: ", getObjectiveValue(m))
println("Solution is:")
for i = 1:5
    print("x[$i] = ", getValue(x[i]))
    println(", p[$i]/w[$i] = ", profit[i]/weight[i])
end
