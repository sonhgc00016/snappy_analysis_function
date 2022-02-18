defmodule BenchmarkFunctionTest do
  use ExUnit.Case
  doctest BenchmarkFunction

  test "greets the world" do
    assert BenchmarkFunction.hello() == :world
  end
end
