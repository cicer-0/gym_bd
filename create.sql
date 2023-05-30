-- -- Create a new database called 'DBgym'
-- -- Connect to the 'master' database to run this snippet
-- USE master
-- GO
-- -- Create the new database if it does not exist already
-- IF NOT EXISTS (
--     SELECT [name]
--         FROM sys.databases
--         WHERE [name] = N'DBgym'
-- )
-- CREATE DATABASE DBgym
-- GO
CREATE TABLE [dbo].[Tipo_disciplina] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [nombre]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_Tipo_disciplina] PRIMARY KEY CLUSTERED ([id] ASC)
);
CREATE TABLE [dbo].[Ejercicio] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [nombre]       VARCHAR (50)  NOT NULL,
    [descripcion]  VARCHAR (200) NOT NULL,
    [series]       INT           NOT NULL,
    [repeticiones] INT           NOT NULL,
    [peso_extra]   INT           NOT NULL,
    CONSTRAINT [PK_Ejercicios] PRIMARY KEY CLUSTERED ([id] ASC)
);


CREATE TABLE [dbo].[Tipo_disciplina_Ejercicio] (
    [idEjercicio]       INT NOT NULL,
    [idTipo_disciplina] INT NOT NULL,
    CONSTRAINT [PK_Tipo_disciplina_Ejercicios] PRIMARY KEY CLUSTERED ([idEjercicio] ASC, [idTipo_disciplina] ASC),
    CONSTRAINT [FK_Tipo_disciplina_Ejercicios_Ejercicios] FOREIGN KEY ([idEjercicio]) REFERENCES [dbo].[Ejercicio] ([id]),
    CONSTRAINT [FK_Tipo_disciplina_Ejercicios_Tipo_disciplina] FOREIGN KEY ([idTipo_disciplina]) REFERENCES [dbo].[Tipo_disciplina] ([id])
);



CREATE TABLE [dbo].[Tipo_area_muscular] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [nombre]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_Tipo_area_muscular] PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[Tipo_area_muscular_Ejercicio] (
    [idEjercicio]          INT NOT NULL,
    [idTipo_area_muscular] INT NOT NULL,
    CONSTRAINT [PK_Tipo_area_muscular_Ejercicios] PRIMARY KEY CLUSTERED ([idEjercicio] ASC, [idTipo_area_muscular] ASC),
    CONSTRAINT [FK_Tipo_area_muscular_Ejercicio_Ejercicio] FOREIGN KEY ([idEjercicio]) REFERENCES [dbo].[Ejercicio] ([id]),
    CONSTRAINT [FK_Tipo_area_muscular_Ejercicio_Tipo_area_muscular] FOREIGN KEY ([idTipo_area_muscular]) REFERENCES [dbo].[Tipo_area_muscular] ([id])
);



CREATE TABLE [dbo].[Direccion] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [ciudad]         VARCHAR (100) NOT NULL,
    [codigo_postal]  VARCHAR (15)  NOT NULL,
    [pais]           VARCHAR (50)  NOT NULL,
    [especificacion] VARCHAR (300) NOT NULL,
    CONSTRAINT [PK_Direccion] PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[Instructor] (
    [id]                 INT           IDENTITY (1, 1) NOT NULL,
    [nombre]             VARCHAR (100) NOT NULL,
    [apellido_materno]   VARCHAR (100) NOT NULL,
    [apellido_paterno]   VARCHAR (100) NOT NULL,
    [telefono]           VARCHAR (20)  NOT NULL,
    [correo_electronico] VARCHAR (100) NOT NULL,
    [idDireccion]        INT           NOT NULL,
    CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_Instructor_Direccion] FOREIGN KEY ([idDireccion]) REFERENCES [dbo].[Direccion] ([id])
);

CREATE TABLE [dbo].[Membresia] (
    [id]                INT           IDENTITY (1, 1) NOT NULL,
    [nombre_plan]       VARCHAR (100) NOT NULL,
    [fecha_inicio]      DATE          NOT NULL,
    [fecha_vencimiento] DATE          NOT NULL,
    [precio]            MONEY         NOT NULL,
    CONSTRAINT [PK_Membresia] PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[Miembro] (
    [id]                 INT           IDENTITY (1, 1) NOT NULL,
    [telefono]           VARCHAR (20)  NOT NULL,
    [correo_electronico] VARCHAR (100) NOT NULL,
    [apellido_materno]   VARCHAR (100) NOT NULL,
    [apeliido_paterno]   VARCHAR (100) NOT NULL,
    [nombre]             VARCHAR (100) NOT NULL,
    [fecha_nacimiento]   DATE          NOT NULL,
    [fecha_inscripcion]  DATE          NOT NULL,
    [dni]                VARCHAR (10)  NOT NULL,
    [idMembresia]        INT           NOT NULL,
    [idDireccion]        INT           NOT NULL,
    CONSTRAINT [PK_Miembro] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_Miembro_Direccion] FOREIGN KEY ([idDireccion]) REFERENCES [dbo].[Direccion] ([id]),
    CONSTRAINT [FK_Miembro_Membresia] FOREIGN KEY ([idMembresia]) REFERENCES [dbo].[Membresia] ([id])
);

CREATE TABLE [dbo].[Certificado] (
    [id]                   INT           IDENTITY (1, 1) NOT NULL,
    [nombre_certificado]   VARCHAR (50)  NOT NULL,
    [descripcion]          VARCHAR (200) NOT NULL,
    [duracion_aprendizaje] INT           NOT NULL,
    CONSTRAINT [PK_Certificado] PRIMARY KEY CLUSTERED ([id] ASC)
);



CREATE TABLE [dbo].[Instructor_Certificado] (
    [idInstructor]  INT NOT NULL,
    [idCertificado] INT NOT NULL,
    CONSTRAINT [PK_Instructor_Certificado] PRIMARY KEY CLUSTERED ([idInstructor] ASC, [idCertificado] ASC),
    CONSTRAINT [FK_Instructor_Certificado_Certificado] FOREIGN KEY ([idCertificado]) REFERENCES [dbo].[Certificado] ([id]),
    CONSTRAINT [FK_Instructor_Certificado_Instructor] FOREIGN KEY ([idInstructor]) REFERENCES [dbo].[Instructor] ([id])
);


CREATE TABLE [dbo].[Medida_antropometrica] (
    [id]                         INT             IDENTITY (1, 1) NOT NULL,
    [circunferencia_cintura]     DECIMAL (10, 2) NOT NULL,
    [circunferencia_cadera]      DECIMAL (10, 2) NOT NULL,
    [circunferencia_brazo]       DECIMAL (10, 2) NOT NULL,
    [circunferencia_muslo]       DECIMAL (10, 2) NOT NULL,
    [circunferencia_pantorrilla] DECIMAL (10, 2) NOT NULL,
    [ancho_hombros]              DECIMAL (10, 2) NOT NULL,
    CONSTRAINT [PK_Medidas_antropometricas] PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[Progreso_entrenamiento] (
    [id]                       INT             IDENTITY (1, 1) NOT NULL,
    [fecha]                    DATE            NOT NULL,
    [peso]                     DECIMAL (10, 2) NOT NULL,
    [altura]                   DECIMAL (10, 2) NOT NULL,
    [porcentaje_masa_muscular] DECIMAL (10, 2) NOT NULL,
    [porcentaje_masa_grasa]    DECIMAL (10, 2) NOT NULL,
    [objetivos_entrenamiento]  VARCHAR (100)   NOT NULL,
    [idMedida_antropometrica]  INT             NOT NULL,
    CONSTRAINT [PK_Progreso_entrenamiento] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_Progreso_entrenamiento_Medida_antropometrica] FOREIGN KEY ([idMedida_antropometrica]) REFERENCES [dbo].[Medida_antropometrica] ([id])
);

CREATE TABLE [dbo].[Sesion] (
    [id]                       INT           IDENTITY (1, 1) NOT NULL,
    [nota]                     VARCHAR (100) NOT NULL,
    [hora_inicio]              TIME (7)      NOT NULL,
    [hora_fin]                 TIME (7)      NOT NULL,
    [fecha]                    DATE          NOT NULL,
    [idMiembro]                INT           NOT NULL,
    [idInstructor]             INT           NOT NULL,
    [idProgreso_entrenamiento] INT           NOT NULL,
    CONSTRAINT [PK_Sesion] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_Sesion_Instructor] FOREIGN KEY ([idInstructor]) REFERENCES [dbo].[Instructor] ([id]),
    CONSTRAINT [FK_Sesion_Miembro] FOREIGN KEY ([idMiembro]) REFERENCES [dbo].[Miembro] ([id]),
    CONSTRAINT [FK_Sesion_Progreso_entrenamiento] FOREIGN KEY ([idProgreso_entrenamiento]) REFERENCES [dbo].[Progreso_entrenamiento] ([id])
);

CREATE TABLE [dbo].[Ejercicio_Session] (
    [idEjercicio] INT NOT NULL,
    [idSesion]    INT NOT NULL,
    CONSTRAINT [PK_Ejercicio_Session] PRIMARY KEY CLUSTERED ([idSesion] ASC, [idEjercicio] ASC),
    CONSTRAINT [FK_Ejercicio_Session_Ejercicio] FOREIGN KEY ([idEjercicio]) REFERENCES [dbo].[Ejercicio] ([id]),
    CONSTRAINT [FK_Ejercicio_Session_Sesion] FOREIGN KEY ([idSesion]) REFERENCES [dbo].[Sesion] ([id])
);

