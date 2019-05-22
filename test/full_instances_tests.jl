function full_instances_tests()
    @testset "play gap" begin
        data = CLD.GeneralizedAssignment.data("play2.txt")

        coluna = JuMP.with_optimizer(Coluna.Optimizer,# #params = params,
            master_factory = with_optimizer(GLPK.Optimizer),
            pricing_factory = with_optimizer(GLPK.Optimizer))

        problem, x, dec = CLD.GeneralizedAssignment.model(data, coluna)

        JuMP.optimize!(problem)
        @test abs(JuMP.objective_value(problem) - 75.0) <= 0.00001
        @test CLD.GeneralizedAssignment.print_and_check_sol(data, problem, x)
    end

    @testset "gap - JuMP/MOI modeling" begin
        data = CLD.GeneralizedAssignment.data("smallgap3.txt")

        coluna = JuMP.with_optimizer(Coluna.Optimizer,# #params = params,
            master_factory = with_optimizer(GLPK.Optimizer),
            pricing_factory = with_optimizer(GLPK.Optimizer))

        problem, x, dec = CLD.GeneralizedAssignment.model(data, coluna)

        JuMP.optimize!(problem)
        @test abs(JuMP.objective_value(problem) - 438.0) <= 0.00001
        @test CLD.GeneralizedAssignment.print_and_check_sol(data, problem, x)
    end

    @testset "gap with penalties - pure master variables" begin
        data = CLD.GeneralizedAssignment.data("smallgap3.txt")

        coluna = JuMP.with_optimizer(Coluna.Optimizer,# #params = params,
            master_factory = with_optimizer(GLPK.Optimizer),
            pricing_factory = with_optimizer(GLPK.Optimizer)
        )

        problem, x, y, dec = CLD.GeneralizedAssignment.model_with_penalties(data, coluna)
        JuMP.optimize!(problem)
        @test abs(JuMP.objective_value(problem) - 416.4) <= 0.00001
    end

    @testset "gap with maximisation objective function" begin
        data = CLD.GeneralizedAssignment.data("smallgap3.txt")

        coluna = JuMP.with_optimizer(Coluna.Optimizer,# #params = params,
            master_factory = with_optimizer(GLPK.Optimizer),
            pricing_factory = with_optimizer(GLPK.Optimizer)
        )

        problem, x, dec = CLD.GeneralizedAssignment.model_max(data, coluna)
        JuMP.optimize!(problem)
        @test abs(JuMP.objective_value(problem) - 580.0) <= 0.00001
    end

    @testset "gap with infeasible subproblem" begin
    data = CLD.GeneralizedAssignment.data("root_infeas.txt")

    coluna = JuMP.with_optimizer(Coluna.Optimizer,# #params = params,
        master_factory = with_optimizer(GLPK.Optimizer),
        pricing_factory = with_optimizer(GLPK.Optimizer))
    
    problem, x, dec = CLD.GeneralizedAssignment.model(data, coluna)

    JuMP.optimize!(problem)
    # @test abs(JuMP.objective_value(problem) - 75.0) <= 0.00001
    # @test CLD.GeneralizedAssignment.print_and_check_sol(data, problem, x)
    end

    # @testset "gap BIG instance" begin
    #     data = CLD.GeneralizedAssignment.data("gapC-5-100.txt")
    
    #     coluna = JuMP.with_optimizer(Coluna.Optimizer,# #params = params,
    #         master_factory = with_optimizer(GLPK.Optimizer),
    #         pricing_factory = with_optimizer(GLPK.Optimizer)
    #     )

    #     problem, x, dec = CLD.GeneralizedAssignment.model(data, coluna)
    #     JuMP.optimize!(problem)
    #     @test abs(JuMP.objective_value(problem) - 1931.0) <= 0.00001
    #     @test CLD.GeneralizedAssignment.print_and_check_sol(data, problem, x)
    # end

    # To redirect logging output
    io = IOBuffer()
    global_logger(ConsoleLogger(io, LogLevel(-4)))

    @testset "play gap" begin
        data = CLD.GeneralizedAssignment.data("play2.txt")
    
        coluna = JuMP.with_optimizer(Coluna.Optimizer,# #params = params,
            master_factory = with_optimizer(GLPK.Optimizer),
            pricing_factory = with_optimizer(GLPK.Optimizer)
        )

        problem, x, dec = CLD.GeneralizedAssignment.model(data, coluna)
        JuMP.optimize!(problem)
        @test abs(JuMP.objective_value(problem) - 75.0) <= 0.00001
        @test CLD.GeneralizedAssignment.print_and_check_sol(data, problem, x)
    end
end