FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["eShoping/eShoping.csproj", "eShoping/"]
RUN dotnet restore "eShoping/eShoping.csproj"
COPY . .
WORKDIR "/src/eShoping"
RUN dotnet build "eShoping.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "eShoping.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "eShoping.dll"]