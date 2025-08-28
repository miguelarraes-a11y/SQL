
CREATE DATABASE db_revenda_miguel;
CREATE TABLE clientes (
    cliente_id serial PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    data_cadastro DATE DEFAULT now()
);

CREATE TABLE veiculos (
    veiculo_id INT  PRIMARY KEY,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano INT NOT null,
    preco varchar NOT null, 
    placa VARCHAR(7) NOT NULL UNIQUE
);

CREATE TABLE vendedores (
    vendedor_id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    data_admissao DATE NOT NULL
);

CREATE TABLE vendas (
    venda_id INT PRIMARY KEY,
    cliente_id INT NOT NULL,
    vendedor_id INT NOT NULL,
    data_venda DATE ,
    valor_total int  NOT null,
    forma_pagamento VARCHAR(50) NOT null,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (vendedor_id) REFERENCES vendedores(vendedor_id)
);

CREATE TABLE estoque (
    veiculo_id INT PRIMARY KEY,
    quantidade INT NOT NULL CHECK (quantidade >= 0),
    local_armazenamento VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Disponível',
    data_ultima_atualizacao DATE ,
    FOREIGN KEY (veiculo_id) REFERENCES veiculos(veiculo_id)
);

CREATE TABLE venda_veiculo (
    venda_id INT NOT NULL,
    veiculo_id INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(12,2) NOT NULL CHECK (preco_unitario > 0),
    PRIMARY KEY (venda_id, veiculo_id),
    FOREIGN KEY (venda_id) REFERENCES vendas(venda_id),
    FOREIGN KEY (veiculo_id) REFERENCES veiculos(veiculo_id)
);


CREATE VIEW view_vendas_detalhes AS
SELECT 
    v.venda_id,
    c.nome AS cliente_nome,
    c.cpf,
    vd.nome AS vendedor_nome,
    v.data_venda,
    v.valor_total,
    v.forma_pagamento
FROM vendas v
JOIN clientes c ON v.cliente_id = c.cliente_id
JOIN vendedores vd ON v.vendedor_id = vd.vendedor_id;

CREATE VIEW view_estoque_veiculos AS
SELECT 
    ve.veiculo_id,
    ve.marca,
    ve.modelo,
    ve.ano,
    e.quantidade,
    e.status,
    e.local_armazenamento,
    ve.placa
FROM estoque e
JOIN veiculos ve ON e.veiculo_id = ve.veiculo_id;

INSERT INTO clientes (nome, cpf, telefone, email, data_cadastro) VALUES
('Ana Silva', '12345678901', '11987654321', 'ana.silva@email.com', '2023-01-15'),
('Bruno Santos', '10987654321', '21987654322', 'bruno.santos@email.com', '2023-02-10'),
('Carla Lima', '23456789012', '31987654323', 'carla.lima@email.com', '2023-03-05'),
('Diego Souza', '34567890123', '41987654324', 'diego.souza@email.com', '2023-04-12'),
('Elisa Martins', '45678901234', '51987654325', 'elisa.martins@email.com', '2023-05-22'),
('Fabio Rocha', '56789012345', '61987654326', 'fabio.rocha@email.com', '2023-06-30'),
('Gisele Nunes', '67890123456', '71987654327', 'gisele.nunes@email.com', '2023-07-15'),
('Hugo Ferreira', '78901234567', '81987654328', 'hugo.ferreira@email.com', '2023-08-19'),
('Isabela Costa', '89012345678', '91987654329', 'isabela.costa@email.com', '2023-09-10'),
('João Pedro', '90123456789', '101987654330', 'joao.pedro@email.com', '2023-10-01');


INSERT INTO veiculos (marca, modelo, ano, preco, placa) VALUES
('Toyota', 'Corolla', 2022, 120000.00, 'ABC1234'),
('Honda', 'Civic', 2021, 110000.00, 'DEF5678'),
('Ford', 'EcoSport', 2023, 95000.00, 'GHI9012'),
('Chevrolet', 'Onix', 2020, 75000.00, 'JKL3456'),
('Volkswagen', 'Golf', 2019, 90000.00, 'MNO7890'),
('Renault', 'Sandero', 2021, 65000.00, 'PQR2345'),
('Nissan', 'Kicks', 2022, 85000.00, 'STU6789'),
('Hyundai', 'HB20', 2023, 70000.00, 'VWX1234'),
('Jeep', 'Renegade', 2020, 105000.00, 'YZA5678'),
('Fiat', 'Toro', 2021, 115000.00, 'BCD9012');


INSERT INTO vendedores (nome, telefone, email, data_admissao) VALUES
('Lucas Almeida', '11991234567', 'lucas.almeida@email.com', '2020-03-01'),
('Marina Costa', '21998765432', 'marina.costa@email.com', '2019-07-15'),
('Pedro Gomes', '31987654321', 'pedro.gomes@email.com', '2021-01-20'),
('Fernanda Rocha', '41986543210', 'fernanda.rocha@email.com', '2022-06-10'),
('Ricardo Dias', '51985432109', 'ricardo.dias@email.com', '2018-11-30'),
('Camila Moreira', '61984321098', 'camila.moreira@email.com', '2023-02-25'),
('Thiago Martins', '71983210987', 'thiago.martins@email.com', '2017-09-05'),
('Aline Pereira', '81982109876', 'aline.pereira@email.com', '2020-12-12'),
('Rafael Silva', '91981098765', 'rafael.silva@email.com', '2021-05-18'),
('Bianca Fernandes', '10198765432', 'bianca.fernandes@email.com', '2019-08-22');


INSERT INTO vendas (cliente_id, vendedor_id, data_venda, valor_total, forma_pagamento) VALUES
(1, 1, '2023-08-01', 120000.00, 'À vista'),
(2, 2, '2023-08-03', 110000.00, 'Financiado'),
(3, 3, '2023-08-05', 95000.00, 'À vista'),
(4, 4, '2023-08-07', 75000.00, 'Cartão'),
(5, 5, '2023-08-09', 90000.00, 'Financiado'),
(6, 6, '2023-08-11', 65000.00, 'À vista'),
(7, 7, '2023-08-13', 85000.00, 'Financiado'),
(8, 8, '2023-08-15', 70000.00, 'Cartão'),
(9, 9, '2023-08-17', 105000.00, 'À vista'),
(10, 10, '2023-08-19', 115000.00, 'Financiado');


INSERT INTO estoque (veiculo_id, quantidade, local_armazenamento, status, data_ultima_atualizacao) VALUES
(1, 3, 'Pátio A', 'Disponível', '2023-08-01'),
(2, 5, 'Pátio B', 'Disponível', '2023-08-02'),
(3, 2, 'Pátio A', 'Disponível', '2023-08-03'),
(4, 4, 'Pátio C', 'Disponível', '2023-08-04'),
(5, 1, 'Pátio B', 'Disponível', '2023-08-05'),
(6, 3, 'Pátio C', 'Disponível', '2023-08-06'),
(7, 6, 'Pátio A', 'Disponível', '2023-08-07'),
(8, 2, 'Pátio B', 'Disponível', '2023-08-08'),
(9, 4, 'Pátio C', 'Disponível', '2023-08-09'),
(10, 1, 'Pátio A', 'Disponível', '2023-08-10');

INSERT INTO venda_veiculo (venda_id, veiculo_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 120000.00),
(2, 2, 1, 110000.00),
(3, 3, 1, 95000.00),
(4, 4, 1, 75000.00),
(5, 5, 1, 90000.00),
(6, 6, 1, 65000.00),
(7, 7, 1, 85000.00),
(8, 8, 1, 70000.00),
(9, 9, 1, 105000.00),
(10, 10, 1, 115000.00);


SELECT * FROM view_vendas_detalhes;

SELECT * FROM view_estoque_veiculos;
