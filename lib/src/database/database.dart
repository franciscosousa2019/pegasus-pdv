import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';

import 'package:path_provider/path_provider.dart' as paths;
import 'package:path/path.dart' as p;

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/database/migracao.dart';

import 'database_classes.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  if (Biblioteca.isMobile()) {
    final executor = LazyDatabase(() async {
      final dataDir = await paths.getApplicationDocumentsDirectory();
      Sessao.caminhoBancoDados = p.join(dataDir.path, 'pegasus.sqlite');
      final dbFile = File(Sessao.caminhoBancoDados);
      return VmDatabase(dbFile, logStatements: true);
    });
    return executor;
  } else if (Platform.isWindows) {
    final executor = LazyDatabase(() async {
      final dataDir = await paths.getApplicationDocumentsDirectory();
      Sessao.caminhoBancoDados = p.join(dataDir.path, 'pegasus.sqlite');
      final dbFile = File(Sessao.caminhoBancoDados);
      // final dbFile = File('pegasus.sqlite');
      return VmDatabase(dbFile, logStatements: true);
    });
    return executor;
  }
  return LazyDatabase(() async {
    return VmDatabase.memory(logStatements: true);
  });
}

@UseMoor(
  tables: [
    Cfops,
    Clientes,
    Colaboradors,
    CompraPedidoCabecalhos,
    CompraPedidoDetalhes,
    Contadors,
    ContasPagars,
    ContasRecebers,
    EcfAliquotass,
    EcfDocumentosEmitidoss,
    EcfE3s,
    EcfImpressoras,
    EcfLogTotaiss,
    EcfR01s,
    EcfR02s,
    EcfR03s,
    EcfR06s,
    EcfR07s,
    EcfRecebimentoNaoFiscals,
    EcfRelatorioGerencials,
    EcfSintegra60As,
    EcfSintegra60Ms,
    Empresas,
    Fornecedors,
    Ibpts,
    LogImportacaos,
    PdvCaixas,
    PdvConfiguracaos,
    PdvConfiguracaoBalancas,
    PdvConfiguracaoLeitorSerials,
    PdvFechamentos,
    PdvMovimentos,
    PdvOperadors,
    PdvSangrias,
    PdvSuprimentos,
    PdvTipoPagamentos,
    PdvTotalTipoPagamentos,
    PdvVendaCabecalhos,
    PdvVendaDetalhes,
    Produtos,
    ProdutoFichaTecnicas,
    ProdutoPromocaos,
    ProdutoUnidades,
    NfeAcessoXmls,
    NfeCabecalhos,
    NfeCanas,
    NfeCanaDeducoesSafras,
    NfeCanaFornecimentoDiarios,
    NfeConfiguracaos,
    NfeCteReferenciados,
    NfeCupomFiscalReferenciados,
    NfeDeclaracaoImportacaos,
    NfeDestinatarios,
    NfeDetEspecificoArmamentos,
    NfeDetEspecificoCombustivels,
    NfeDetEspecificoMedicamentos,
    NfeDetEspecificoVeiculos,
    NfeDetalhes,
    NfeDetalheImpostoCofinss,
    NfeDetalheImpostoCofinsSts,
    NfeDetalheImpostoIcmss,
    NfeDetalheImpostoIcmsUfdests,
    NfeDetalheImpostoIis,
    NfeDetalheImpostoIpis,
    NfeDetalheImpostoIssqns,
    NfeDetalheImpostoPiss,
    NfeDetalheImpostoPisSts,
    NfeDuplicatas,
    NfeEmitentes,
    NfeExportacaos,
    NfeFaturas,
    NfeImportacaoDetalhes,
    NfeInformacaoPagamentos,
    NfeItemRastreados,
    NfeLocalEntregas,
    NfeLocalRetiradas,
    NfeNfReferenciadas,
    NfeNumeros,
    NfeNumeroInutilizados,
    NfeProcessoReferenciados,
    NfeProdRuralReferenciadas,
    NfeReferenciadas,
    NfeResponsavelTecnicos,
    NfeTransportes,
    NfeTransporteReboques,
    NfeTransporteVolumes,
    NfeTransporteVolumeLacres,
    NfcePlanoPagamentos,
    TributCofinss,
    TributConfiguraOfGts,
    TributGrupoTributarios,
    TributIcmsCustomCabs,
    TributIcmsCustomDets,
    TributIcmsUfs,
    TributIpis,
    TributIsss,
    TributOperacaoFiscals,
    TributPiss,
  ],
  daos: [
    CfopDao,
    ClienteDao,
    ColaboradorDao,
    CompraPedidoCabecalhoDao,
    CompraPedidoDetalheDao,
    ContadorDao,
    ContasPagarDao,
    ContasReceberDao,
    EcfAliquotasDao,
    EcfDocumentosEmitidosDao,
    EcfE3Dao,
    EcfImpressoraDao,
    EcfLogTotaisDao,
    EcfR01Dao,
    EcfR02Dao,
    EcfR03Dao,
    EcfR06Dao,
    EcfR07Dao,
    EcfRecebimentoNaoFiscalDao,
    EcfRelatorioGerencialDao,
    EcfSintegra60ADao,
    EcfSintegra60MDao,
    EmpresaDao,
    FornecedorDao,
    IbptDao,
    LogImportacaoDao,
    PdvCaixaDao,
    PdvConfiguracaoDao,
    PdvConfiguracaoBalancaDao,
    PdvConfiguracaoLeitorSerialDao,
    PdvFechamentoDao,
    PdvMovimentoDao,
    PdvOperadorDao,
    PdvSangriaDao,
    PdvSuprimentoDao,
    PdvTipoPagamentoDao,
    PdvTotalTipoPagamentoDao,
    PdvVendaCabecalhoDao,
    PdvVendaDetalheDao,
    ProdutoDao,
    ProdutoFichaTecnicaDao,
    ProdutoPromocaoDao,
    ProdutoUnidadeDao,
    NfeCabecalhoDao,
    NfeConfiguracaoDao,
    NfeNumeroDao,
    NfeNumeroInutilizadoDao,
    NfcePlanoPagamentoDao,
    TributConfiguraOfGtDao,
    TributGrupoTributarioDao,
    TributIcmsCustomCabDao,
    TributOperacaoFiscalDao,
    TributIcmsUfDao,
    TributIpiDao,
    TributIssDao,
    TributPisDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _popularBanco(this);
          await _popularBancoSchema02(this);
          await _popularBancoSchema03(this);
          await _popularBancoSchema04(this);
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from == 1) {
            await MigracaoParaSchema2(this).migrarParaSchema2(m, from, to);
            await _popularBancoSchema02(this);
            await MigracaoParaSchema3(this).migrarParaSchema3(m, from, to);
            await _popularBancoSchema03(this);
            await MigracaoParaSchema4(this).migrarParaSchema4(m, from, to);
            await _popularBancoSchema04(this);
          }
          if (from == 2) {
            await MigracaoParaSchema3(this).migrarParaSchema3(m, from, to);
            await _popularBancoSchema03(this);
            await MigracaoParaSchema4(this).migrarParaSchema4(m, from, to);
            await _popularBancoSchema04(this);
          }
          if (from == 3) {
            await MigracaoParaSchema4(this).migrarParaSchema4(m, from, to);
            await _popularBancoSchema04(this);
          }
        },
      );
}

Future<void> _popularBancoSchema04(AppDatabase db) async {
  // ---> CONFIGURACAO PDV
  db.customStatement("UPDATE PDV_CONFIGURACAO SET DECIMAIS_QUANTIDADE = '3', DECIMAIS_VALOR = '2' WHERE ID = 1");
  // ---> TIPO PAGAMENTO
  db.customStatement("UPDATE PDV_TIPO_PAGAMENTO SET CODIGO_PAGAMENTO_NFCE = '01' WHERE CODIGO = '01'");
  db.customStatement("UPDATE PDV_TIPO_PAGAMENTO SET CODIGO = '02', CODIGO_PAGAMENTO_NFCE = '02' WHERE CODIGO = '04'");
  db.customStatement("UPDATE PDV_TIPO_PAGAMENTO SET CODIGO_PAGAMENTO_NFCE = '03' WHERE CODIGO = '03'");
  // ---> NFE_NUMERO
  await db.customStatement("INSERT INTO NFE_NUMERO (ID, MODELO, SERIE, NUMERO) VALUES (1, '65', '1', '1')");
  // ---> NFE_CONFIGURACAO
  await db.customStatement("INSERT INTO NFE_CONFIGURACAO " +
      "(ID, FORMATO_IMPRESSAO_DANFE, WEBSERVICE_AMBIENTE, NFCE_MODELO_IMPRESSAO, NFCE_IMPRIMIR_ITENS_UMA_LINHA, NFCE_IMPRIMIR_DESCONTO_POR_ITEM, NFCE_IMPRIMIR_QRCODE_LATERAL, NFCE_IMPRIMIR_GTIN, NFCE_IMPRIMIR_NOME_FANTASIA, NFCE_ID_CSC, NFCE_CSC, NFCE_IMPRESSAO_TRIBUTOS, NFCE_MARGEM_SUPERIOR, NFCE_MARGEM_INFERIOR, NFCE_MARGEM_DIREITA, NFCE_MARGEM_ESQUERDA, NFCE_RESOLUCAO_IMPRESSAO, NFCE_TAMANHO_FONTE_ITEM) " +
      "VALUES (1, '4', '2', '80', 'S', 'N', 'S', 'N', 'N', '0', '0', 'S', '0.80', '0.80', '0.7', '0.7', '280', '7')");
}

Future<void> _popularBancoSchema03(AppDatabase db) async {
  // ---> TRIBUT_GRUPO_TRIBUTARIO
  await db.customStatement("INSERT INTO TRIBUT_GRUPO_TRIBUTARIO (ID, DESCRICAO, ORIGEM_MERCADORIA) VALUES (1, 'PRODUTO DE FABRICACAO PROPRIA', '0')");
  await db.customStatement("INSERT INTO TRIBUT_GRUPO_TRIBUTARIO (ID, DESCRICAO, ORIGEM_MERCADORIA) VALUES (2, 'PRODUTO ADQUIRIDO OU RECEBIDO DE TERCEIROS', '0')");
  // ---> TRIBUT_OPERACAO_FISCAL
  await db.customStatement("INSERT INTO TRIBUT_OPERACAO_FISCAL (ID, DESCRICAO, OBSERVACAO) VALUES (1, 'VENDA DE PRODUCAO DO ESTABELECIMENTO', 'NORMALMENTE ESTA OPERACAO FISCAL SERA VINCULADA AO CFOP 5.101 E PODERA SER VINCULADA A UM OU MAIS CST OU CSOSN')");
  await db.customStatement("INSERT INTO TRIBUT_OPERACAO_FISCAL (ID, DESCRICAO, OBSERVACAO) VALUES (2, 'VENDA DE MERCADORIA ADQUIRIDA OU RECEBIDA DE TERCEIROS', 'NORMALMENTE UTILIZADO COM O CFOP 5.102 EM COMBINACAO COM CST OU CSOSN.')");
  // ---> TRIBUT_CONFIGURA_OF_GT
  await db.customStatement("INSERT INTO TRIBUT_CONFIGURA_OF_GT (ID, ID_TRIBUT_GRUPO_TRIBUTARIO, ID_TRIBUT_OPERACAO_FISCAL) VALUES (1, 1, 1)");
  await db.customStatement("INSERT INTO TRIBUT_CONFIGURA_OF_GT (ID, ID_TRIBUT_GRUPO_TRIBUTARIO, ID_TRIBUT_OPERACAO_FISCAL) VALUES (2, 2, 2)");
  // ---> TRIBUT_ICMS_UF
  await db.customStatement("INSERT INTO TRIBUT_ICMS_UF (ID, ID_TRIBUT_CONFIGURA_OF_GT, CFOP, CSOSN, CST) VALUES (1, 1, 5101, '102', '00')");
  await db.customStatement("INSERT INTO TRIBUT_ICMS_UF (ID, ID_TRIBUT_CONFIGURA_OF_GT, CFOP, CSOSN, CST) VALUES (2, 2, 5102, '102', '00')");
  // ---> TRIBUT_PIS
  await db.customStatement("INSERT INTO TRIBUT_PIS (ID, ID_TRIBUT_CONFIGURA_OF_GT, CST_PIS, MODALIDADE_BASE_CALCULO, ALIQUOTA_PORCENTO) VALUES (1, 1, '99', '0', 0)");
  await db.customStatement("INSERT INTO TRIBUT_PIS (ID, ID_TRIBUT_CONFIGURA_OF_GT, CST_PIS, MODALIDADE_BASE_CALCULO, ALIQUOTA_PORCENTO) VALUES (2, 2, '99', '0', 0)");

  // ---> TRIBUT_COFINS
  await db.customStatement("INSERT INTO TRIBUT_COFINS (ID, ID_TRIBUT_CONFIGURA_OF_GT, CST_COFINS, MODALIDADE_BASE_CALCULO, ALIQUOTA_PORCENTO) VALUES (1, 1, '99', '0', 0)");
  await db.customStatement("INSERT INTO TRIBUT_COFINS (ID, ID_TRIBUT_CONFIGURA_OF_GT, CST_COFINS, MODALIDADE_BASE_CALCULO, ALIQUOTA_PORCENTO) VALUES (2, 2, '99', '0', 0)");
}

Future<void> _popularBancoSchema02(AppDatabase db) async {
  // ---> CONFIGURACAO PDV
  await db.customStatement("INSERT INTO PDV_CONFIGURACAO (ID, MODULO, RECIBO_FORMATO_PAGINA, RECIBO_LARGURA_PAGINA, RECIBO_MARGEM_PAGINA, PERMITE_ESTOQUE_NEGATIVO) VALUES (1, 'G', 'A4', NULL, NULL, 'S')");
}

Future<void> _popularBanco(AppDatabase db) async {
  // ***
  // DADOS PARA PRODUÇÃO
  // ***
  // ---> TIPO PAGAMENTO
  db.customStatement("INSERT INTO PDV_TIPO_PAGAMENTO (ID, CODIGO, DESCRICAO, TEF, IMPRIME_VINCULADO, PERMITE_TROCO, TEF_TIPO_GP, GERA_PARCELAS) VALUES (1, '01', 'DINHEIRO', 'N', 'N', 'S', 'N', 'N')");
  db.customStatement("INSERT INTO PDV_TIPO_PAGAMENTO (ID, CODIGO, DESCRICAO, TEF, IMPRIME_VINCULADO, PERMITE_TROCO, TEF_TIPO_GP, GERA_PARCELAS) VALUES (2, '04', 'CHEQUE', 'N', 'S', 'N', 'N', 'N')");
  db.customStatement("INSERT INTO PDV_TIPO_PAGAMENTO (ID, CODIGO, DESCRICAO, TEF, IMPRIME_VINCULADO, PERMITE_TROCO, TEF_TIPO_GP, GERA_PARCELAS) VALUES (3, '03', 'CARTAO', 'S', 'S', 'N', '1', 'N')");
  // ---> EMPRESA
  db.customStatement("INSERT INTO EMPRESA (ID, RAZAO_SOCIAL, NOME_FANTASIA) VALUES (1, 'RAZAO SOCIAL DA EMPRESA', 'NOME DE FANTASIA DA EMPRESA')");
  // ---> COLABORADOR
  db.customStatement("INSERT INTO COLABORADOR (ID, NOME) VALUES (1, 'ADMINISTRADOR')");
  // ---> CLIENTE
  db.customStatement("INSERT INTO CLIENTE (ID, TIPO_PESSOA, NOME) VALUES (1, 'Física', 'CLIENTE PF PADRAO')");
  // ---> UNIDADE
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (1, 'KG', NULL, 'S')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (2, 'UND', NULL, 'N')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (3, 'MT', NULL, 'S')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (4, 'M2', NULL, 'S')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (5, 'M3', NULL, 'S')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (6, 'PCT', NULL, 'N')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (7, 'CX', NULL, 'N')");
  db.customStatement("INSERT INTO PRODUTO_UNIDADE (ID, SIGLA, DESCRICAO, PODE_FRACIONAR) VALUES (10, 'PC', 'PACOTE', 'N')");
  // ---> PRODUTO
  db.customStatement(
      "INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (1,1,'3011010827133','30113','01 PRODUTO PARA TESTES','01 PRODUTO PARA TESTES','01 PRODUTO PARA TESTES','10.000000','-168.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'7.000000','000','1900','04T0700','07',NULL,'T','859dba8c255ea32d52d40a880a0a66d0')");
  db.customStatement(
      "INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (2,1,'0312011604499','03129','02 PRODUTO PARA TESTES','02 PRODUTO PARA TESTES','02 PRODUTO PARA TESTES','35.000000','38.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'7.000000','000','1900','04T0700','07',NULL,'T','36b2f8acbf6b3415593761c3375a5376')");

  // ---> CFOP
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (1, 1000, 'ENTRADAS OU AQUISIÇÕES DE SERVIÇOS DO ESTADO', 'Classificam-se, neste grupo, as operações ou prestações em que o estabelecimento remetente esteja localizado na mesma unidade da Federação do destinatário')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (2, 1100, 'COMPRAS PARA INDUSTRIALIZAÇÃO, COMERCIALIZAÇÃO OU PRESTAÇÃO DE SERVIÇOS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (3, 1101, 'Compra para industrialização', 'Classificam-se neste código as compras de mercadorias a serem utilizadas em processo de industrialização. Também serão classificadas neste código as entradas de mercadorias em estabelecimento industrial de cooperativa recebidas de seus cooperados ou de estabelecimento de outra cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (4, 1102, 'Compra para comercialização', 'Classificam-se neste código as compras de mercadorias a serem comercializadas. Também serão classificadas neste código as entradas de mercadorias em estabelecimento comercial de cooperativa recebidas de seus cooperados ou de estabelecimento de outra cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (5, 1111, 'Compra para industrialização de mercadoria recebida anteriormente em consignação industrial', 'Classificam-se neste código as compras efetivas de mercadorias a serem utilizadas em processo de industrialização, recebidas anteriormente a título de consignação industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (6, 1113, 'Compra para comercialização, de mercadoria recebida anteriormente em consignação mercantil', 'Classificam-se neste código as compras efetivas de mercadorias recebidas anteriormente a título de consignação mercantil.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (7, 1116, 'Compra para industrialização originada de encomenda para recebimento futuro', 'Classificam-se neste código as compras de mercadorias a serem utilizadas em processo de industrialização, quando da entrada real da mercadoria, cuja aquisição tenha sido classificada no código 1.922 - Lançamento efetuado a título de simples faturamento decorrente de compra para recebimento futuro.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (8, 1117, 'Compra para comercialização originada de encomenda para recebimento futuro', 'Classificam-se neste código as compras de mercadorias a serem comercializadas, quando da entrada real da mercadoria, cuja aquisição tenha sido classificada no código 1.922 - Lançamento efetuado a título de simples faturamento decorrente de compra para recebimento futuro.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (9, 1118, 'Compra de mercadoria para comercialização pelo adquirente originário, entregue pelo vendedor remetente ao destinatário, em venda à ordem', 'Classificam-se neste código as compras de mercadorias já comercializadas, que, sem transitar pelo estabelecimento do adquirente originário, sejam entregues pelo vendedor remetente diretamente ao destinatário, em operação de venda à ordem, cuja venda seja classificada, pelo adquirente originário, no código 5.120 - Venda de mercadoria adquirida ou recebida de terceiros entregue ao destinatário pelo vendedor remetente, em venda à ordem.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (10, 1120, 'Compra para industrialização, em venda à ordem, já recebida do vendedor remetente', 'Classificam-se neste código as compras de mercadorias a serem utilizadas em processo de industrialização, em vendas à ordem, já recebidas do vendedor remetente, por ordem do adquirente originário.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (11, 1121, 'Compra para comercialização, em venda à ordem, já recebida do vendedor remetente', 'Classificam-se neste código as compras de mercadorias a serem comercializadas, em vendas à ordem, já recebidas do vendedor remetente por ordem do adquirente originário.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (12, 1122, 'Compra para industrialização em que a mercadoria foi remetida pelo fornecedor ao industrializador sem transitar pelo estabelecimento adquirente', 'Classificam-se neste código as compras de mercadorias a serem utilizadas em processo de industrialização, remetidas pelo fornecedor para o industrializador sem que a mercadoria tenha transitado pelo estabelecimento do adquirente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (13, 1124, 'Industrialização efetuada por outra empresa', 'Classificam-se neste código as entradas de mercadorias industrializadas por terceiros, compreendendo os valores referentes aos serviços prestados e os das mercadorias de propriedade do industrializador empregadas no processo industrial. Quando a industrialização efetuada se referir a bens do ativo imobilizado ou de mercadorias para uso ou consumo do estabelecimento encomendante, a entrada deverá ser classificada nos códigos 1.551 - Compra de bem para o ativo imobilizado ou 1.556 - Compra de material para uso ou consumo.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (14, 1125, 'Industrialização efetuada por outra empresa quando a mercadoria remetida para utilização no processo de industrialização não transitou pelo estabelecimento adquirente da mercadoria', 'Classificam-se neste código as entradas de mercadorias industrializadas por outras empresas, em que as mercadorias remetidas para utilização no processo de industrialização não transitaram pelo estabelecimento do adquirente das mercadorias, compreendendo os valores referentes aos serviços prestados e os das mercadorias de propriedade do industrializador empregadas no processo industrial. Quando a industrialização efetuada se referir a bens do ativo imobilizado ou de mercadorias para uso ou consumo do estabelecimento encomendante, a entrada deverá ser classificada nos códigos 1.551 - Compra de bem para o ativo imobilizado ou 1.556 - Compra de material para uso ou consumo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (15, 1126, 'Compra para utilização na prestação de serviço', 'Classificam-se neste código as entradas de mercadorias a serem utilizadas nas prestações de serviços.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (16, 1150, 'TRANSFERÊNCIAS PARA INDUSTRIALIZAÇÃO, COMERCIALIZAÇÃO OU PRESTAÇÃO DE SERVIÇOS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (17, 1151, 'Transferência para industrialização', 'Classificam-se neste código as entradas de mercadorias recebidas em transferência de outro estabelecimento da mesma empresa, para serem utilizadas em processo de industrialização.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (18, 1152, 'Transferência para comercialização', 'Classificam-se neste código as entradas de mercadorias recebidas em transferência de outro estabelecimento da mesma empresa, para serem comercializadas.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (19, 1153, 'Transferência de energia elétrica para distribuição', 'Classificam-se neste código as entradas de energia elétrica recebida em transferência de outro estabelecimento da mesma empresa, para distribuição.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (20, 1154, 'Transferência para utilização na prestação de serviço', 'Classificam-se neste código as entradas de mercadorias recebidas em transferência de outro estabelecimento da mesma empresa, para serem utilizadas nas prestações de serviços.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (21, 1200, 'DEVOLUÇÕES DE VENDAS DE PRODUÇÃO PRÓPRIA, DE TERCEIROS OU ANULAÇÕES DE VALORES', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (22, 1201, 'Devolução de venda de produção do estabelecimento', 'Classificam-se neste código as devoluções de vendas de produtos industrializados pelo estabelecimento, cujas saídas tenham sido classificadas como Venda de produção do estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (23, 1202, 'Devolução de venda de mercadoria adquirida ou recebida de terceiros', 'Classificam-se neste código as devoluções de vendas de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de industrialização no estabelecimento, cujas saídas tenham sido classificadas como Venda de mercadoria adquirida ou recebida de terceiros.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (24, 1203, 'Devolução de venda de produção do estabelecimento, destinada à Zona Franca de Manaus ou Áreas de Livre Comércio', 'Classificam-se neste código as devoluções de vendas de produtos industrializados pelo estabelecimento, cujas saídas foram classificadas no código 5.109 - Venda de produção do estabelecimento, destinada à Zona Franca de Manaus ou Áreas de Livre Comércio.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (25, 1204, 'Devolução de venda de mercadoria adquirida ou recebida de terceiros, destinada à Zona Franca de Manaus ou Áreas de Livre Comércio', 'Classificam-se neste código as devoluções de vendas de mercadorias adquiridas ou recebidas de terceiros, cujas saídas foram classificadas no código 5.110 - Venda de mercadoria adquirida ou recebida de terceiros, destinada à Zona Franca de Manaus ou Áreas de Livre Comércio.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (26, 1205, 'Anulação de valor relativo à prestação de serviço de comunicação', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes de prestações de serviços de comunicação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (27, 1206, 'Anulação de valor relativo à prestação de serviço de transporte', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes de prestações de serviços de transporte.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (28, 1207, 'Anulação de valor relativo à venda de energia elétrica', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes de venda de energia elétrica.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (29, 1208, 'Devolução de produção do estabelecimento, remetida em transferência', 'Classificam-se neste código as devoluções de produtos industrializados pelo estabelecimento, transferidos para outros estabelecimentos da mesma empresa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (30, 1209, 'Devolução de mercadoria adquirida ou recebida de terceiros, remetida em transferência', 'Classificam-se neste código as devoluções de mercadorias adquiridas ou recebidas de terceiros, transferidas para outros estabelecimentos da mesma empresa.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (31, 1250, 'COMPRAS DE ENERGIA ELÉTRICA', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (32, 1251, 'Compra de energia elétrica para distribuição ou comercialização', 'Classificam-se neste código as compras de energia elétrica utilizada em sistema de distribuição ou comercialização. Também serão classificadas neste código as compras de energia elétrica por cooperativas para distribuição aos seus cooperados.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (33, 1252, 'Compra de energia elétrica por estabelecimento industrial', 'Classificam-se neste código as compras de energia elétrica utilizada no processo de industrialização. Também serão classificadas neste código as compras de energia elétrica utilizada por estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (34, 1253, 'Compra de energia elétrica por estabelecimento comercial', 'Classificam-se neste código as compras de energia elétrica utilizada por estabelecimento comercial. Também serão classificadas neste código as compras de energia elétrica utilizada por estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (35, 1254, 'Compra de energia elétrica por estabelecimento prestador de serviço de transporte', 'Classificam-se neste código as compras de energia elétrica utilizada por estabelecimento prestador de serviços de transporte.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (36, 1255, 'Compra de energia elétrica por estabelecimento prestador de serviço de comunicação', 'Classificam-se neste código as compras de energia elétrica utilizada por estabelecimento prestador de serviços de comunicação.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (37, 1256, 'Compra de energia elétrica por estabelecimento de produtor rural', 'Classificam-se neste código as compras de energia elétrica utilizada por estabelecimento de produtor rural.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (38, 1257, 'Compra de energia elétrica para consumo por demanda contratada', 'Classificam-se neste código as compras de energia elétrica para consumo por demanda contratada, que prevalecerá sobre os demais códigos deste subgrupo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (39, 1300, 'AQUISIÇÕES DE SERVIÇOS DE COMUNICAÇÃO', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (40, 1301, 'Aquisição de serviço de comunicação para execução de serviço da mesma natureza', 'Classificam-se neste código as aquisições de serviços de comunicação utilizados nas prestações de serviços da mesma natureza.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (41, 1302, 'Aquisição de serviço de comunicação por estabelecimento industrial', 'Classificam-se neste código as aquisições de serviços de comunicação utilizados por estabelecimento industrial. Também serão classificadas neste código as aquisições de serviços de comunicação utilizados por estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (42, 1303, 'Aquisição de serviço de comunicação por estabelecimento comercial', 'Classificam-se neste código as aquisições de serviços de comunicação utilizados por estabelecimento comercial. Também serão classificadas neste código as aquisições de serviços de comunicação utilizados por estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (43, 1304, 'Aquisição de serviço de comunicação por estabelecimento de prestador de serviço de transporte', 'Classificam-se neste código as aquisições de serviços de comunicação utilizados por estabelecimento prestador de serviço de transporte.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (44, 1305, 'Aquisição de serviço de comunicação por estabelecimento de geradora ou de distribuidora de energia elétrica', 'Classificam-se neste código as aquisições de serviços de comunicação utilizados por estabelecimento de geradora ou de distribuidora de energia elétrica.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (45, 1306, 'Aquisição de serviço de comunicação por estabelecimento de produtor rural', 'Classificam-se neste código as aquisições de serviços de comunicação utilizados por estabelecimento de produtor rural.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (46, 1350, 'AQUISIÇÕES DE SERVIÇOS DE TRANSPORTE', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (47, 1351, 'Aquisição de serviço de transporte para execução de serviço da mesma natureza', 'Classificam-se neste código as aquisições de serviços de transporte utilizados nas prestações de serviços da mesma natureza.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (48, 1352, 'Aquisição de serviço de transporte por estabelecimento industrial', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento industrial. Também serão classificadas neste código as aquisições de serviços de transporte utilizados por estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (49, 1353, 'Aquisição de serviço de transporte por estabelecimento comercial', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento comercial. Também serão classificadas neste código as aquisições de serviços de transporte utilizados por estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (50, 1354, 'Aquisição de serviço de transporte por estabelecimento de prestador de serviço de comunicação', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento prestador de serviços de comunicação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (51, 1355, 'Aquisição de serviço de transporte por estabelecimento de geradora ou de distribuidora de energia elétrica', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento de geradora ou de distribuidora de energia elétrica.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (52, 1356, 'Aquisição de serviço de transporte por estabelecimento de produtor rural', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento de produtor rural.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (53, 1400, 'ENTRADAS DE MERCADORIAS SUJEITAS AO REGIME DE SUBSTITUIÇÃO TRIBUTÁRIA', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (54, 1401, 'Compra para industrialização em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as compras de mercadorias a serem utilizadas em processo de industrialização, decorrentes de operações com mercadorias sujeitas ao regime de substituição tributária. Também serão classificadas neste código as compras por estabelecimento industrial de cooperativa de mercadorias sujeitas ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (55, 1403, 'Compra para comercialização em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as compras de mercadorias a serem comercializadas, decorrentes de operações com mercadorias sujeitas ao regime de substituição tributária. Também serão classificadas neste código as compras de mercadorias sujeitas ao regime de substituição tributária em estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (56, 1406, 'Compra de bem para o ativo imobilizado cuja mercadoria está sujeita ao regime de substituição tributária', 'Classificam-se neste código as compras de bens destinados ao ativo imobilizado do estabelecimento, em operações com mercadorias sujeitas ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (57, 1407, 'Compra de mercadoria para uso ou consumo cuja mercadoria está sujeita ao regime de substituição tributária', 'Classificam-se neste código as compras de mercadorias destinadas ao uso ou consumo do estabelecimento, em operações com mercadorias sujeitas ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (58, 1408, 'Transferência para industrialização em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as mercadorias recebidas em transferência de outro estabelecimento da mesma empresa, para serem industrializadas no estabelecimento, em operações com mercadorias sujeitas ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (59, 1409, 'Transferência para comercialização em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as mercadorias recebidas em transferência de outro estabelecimento da mesma empresa, para serem comercializadas, decorrentes de operações sujeitas ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (60, 1410, 'Devolução de venda de produção do estabelecimento em operação com produto sujeito ao regime de substituição tributária', 'Classificam-se neste código as devoluções de produtos industrializados e vendidos pelo estabelecimento, cujas saídas tenham sido classificadas como Venda de produção do estabelecimento em operação com produto sujeito ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (61, 1411, 'Devolução de venda de mercadoria adquirida ou recebida de terceiros em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as devoluções de vendas de mercadorias adquiridas ou recebidas de terceiros, cujas saídas tenham sido classificadas como Venda de mercadoria adquirida ou recebida de terceiros em operação com mercadoria sujeita ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (62, 1414, 'Retorno de produção do estabelecimento, remetida para venda fora do estabelecimento em operação com produto sujeito ao regime de substituição tributária', 'Classificam-se neste código as entradas, em retorno, de produtos industrializados pelo estabelecimento, remetidos para vendas fora do estabelecimento, inclusive por meio de veículos, em operações com produtos sujeitos ao regime de substituição tributária, e não comercializadas.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (63, 1415, 'Retorno de mercadoria adquirida ou recebida de terceiros, remetida para venda fora do estabelecimento em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as entradas, em retorno, de mercadorias adquiridas ou recebidas de terceiros remetidas para vendas fora do estabelecimento, inclusive por meio de veículos, em operações com mercadorias sujeitas ao regime de substituição tributária, e não comercializadas.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (64, 1450, 'SISTEMAS DE INTEGRAÇÃO', NULL)");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (65, 1451, 'Retorno de animal do estabelecimento produtor', 'Classificam-se neste código as entradas referentes ao retorno de animais criados pelo produtor no sistema integrado.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (66, 1452, 'Retorno de insumo não utilizado na produção', 'Classificam-se neste código o retorno de insumos não utilizados pelo produtor na criação de animais pelo sistema integrado.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (67, 1500, 'ENTRADAS DE MERCADORIAS REMETIDAS COM FIM ESPECÍFICO DE EXPORTAÇÃO E EVENTUAIS DEVOLUÇÕES', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (68, 1501, 'Entrada de mercadoria recebida com fim específico de exportação', 'Classificam-se neste código as entradas de mercadorias em estabelecimento de trading company, empresa comercial exportadora ou outro estabelecimento do remetente, com fim específico de exportação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (69, 1503, 'Entrada decorrente de devolução de produto remetido com fim específico de exportação, de produção do estabelecimento', 'Classificam-se neste código as devoluções de produtos industrializados pelo estabelecimento, remetidos a trading company, a empresa comercial exportadora ou a outro estabelecimento do remetente, com fim específico de exportação, cujas saídas tenham sido classificadas no código 5.501 - Remessa de produção do estabelecimento, com fim específico de exportação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (70, 1504, 'Entrada decorrente de devolução de mercadoria remetida com fim específico de exportação, adquirida ou recebida de terceiros', 'Classificam-se neste código as devoluções de mercadorias adquiridas ou recebidas de terceiros remetidas a trading company, a empresa comercial exportadora ou a outro estabelecimento do remetente, com fim específico de exportação, cujas saídas tenham sido classificadas no código 5.502 - Remessa de mercadoria adquirida ou recebida de terceiros, com fim específico de exportação.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (71, 1550, 'OPERAÇÕES COM BENS DE ATIVO IMOBILIZADO E MATERIAIS PARA USO OU CONSUMO', NULL)");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (72, 1551, 'Compra de bem para o ativo imobilizado', 'Classificam-se neste código as compras de bens destinados ao ativo imobilizado do estabelecimento.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (73, 1552, 'Transferência de bem do ativo imobilizado', 'Classificam-se neste código as entradas de bens destinados ao ativo imobilizado recebidos em transferência de outro estabelecimento da mesma empresa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (74, 1553, 'Devolução de venda de bem do ativo imobilizado', 'Classificam-se neste código as devoluções de vendas de bens do ativo imobilizado, cujas saídas tenham sido classificadas no código 5.551 - Venda de bem do ativo imobilizado.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (75, 1554, 'Retorno de bem do ativo imobilizado remetido para uso fora do estabelecimento', 'Classificam-se neste código as entradas por retorno de bens do ativo imobilizado remetidos para uso fora do estabelecimento, cujas saídas tenham sido classificadas no código 5.554 - Remessa de bem do ativo imobilizado para uso fora do estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (76, 1555, 'Entrada de bem do ativo imobilizado de terceiro, remetido para uso no estabelecimento', 'Classificam-se neste código as entradas de bens do ativo imobilizado de terceiros, remetidos para uso no estabelecimento.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (77, 1556, 'Compra de material para uso ou consumo', 'Classificam-se neste código as compras de mercadorias destinadas ao uso ou consumo do estabelecimento.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (78, 1557, 'Transferência de material para uso ou consumo', 'Classificam-se neste código as entradas de materiais para uso ou consumo recebidos em transferência de outro estabelecimento da mesma empresa.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (79, 1600, 'CRÉDITOS E RESSARCIMENTOS DE ICMS', NULL)");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (80, 1601, 'Recebimento, por transferência, de crédito de ICMS', 'Classificam-se neste código os lançamentos destinados ao registro de créditos de ICMS, recebidos por transferência de outras empresas.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (81, 1602, 'Recebimento, por transferência, de saldo credor de ICMS de outro estabelecimento da mesma empresa, para compensação de saldo devedor de ICMS', 'Classificam-se neste código os lançamentos destinados ao registro da transferência de saldos credores de ICMS recebidos de outros estabelecimentos da mesma empresa, destinados à compensação do saldo devedor do estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (82, 1603, 'Ressarcimento de ICMS retido por substituição tributária', 'Classificam-se neste código os lançamentos destinados ao registro de ressarcimento de ICMS retido por substituição tributária a contribuinte substituído, efetuado pelo contribuinte substituto, ou, ainda, quando o ressarcimento for apropriado pelo próprio contribuinte substituído, nas hipóteses previstas na legislação aplicável.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (83, 1604, 'Lançamento do crédito relativo à compra de bem para o ativo imobilizado', 'Lançamento destinado ao registro da apropriação de crédito de bem do ativo imobilizado.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (84, 1605, '1.605 – Recebimento, por transferência, de saldo devedor de ICMS de outro estabelecimento da mesma empresa. (Ajuste SINIEF 03/04)', 'Classificam-se neste código os lançamentos destinados ao registro da transferência de saldo devedor de ICMS recebido de outro estabelecimento da mesma empresa, para efetivação da apuração centralizada do imposto.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (85, 1900, 'OUTRAS ENTRADAS DE MERCADORIAS OU AQUISIÇÕES DE SERVIÇOS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (86, 1901, 'Entrada para industrialização por encomenda', 'Classificam-se neste código as entradas de insumos recebidos para industrialização por encomenda de outra empresa ou de outro estabelecimento da mesma empresa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (87, 1902, 'Retorno de mercadoria remetida para industrialização por encomenda', 'Classificam-se neste código o retorno dos insumos remetidos para industrialização por encomenda, incorporados ao produto final pelo estabelecimento industrializador.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (88, 1903, 'Entrada de mercadoria remetida para industrialização e não aplicada no referido processo', 'Classificam-se neste código as entradas em devolução de insumos remetidos para industrialização e não aplicados no referido processo.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (89, 1904, 'Retorno de remessa para venda fora do estabelecimento', 'Classificam-se neste código as entradas em retorno de mercadorias remetidas para venda fora do estabelecimento, inclusive por meio de veículos, e não comercializadas.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (90, 1905, 'Entrada de mercadoria recebida para depósito em depósito fechado ou armazém geral', 'Classificam-se neste código as entradas de mercadorias recebidas para depósito em depósito fechado ou armazém geral.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (91, 1906, 'Retorno de mercadoria remetida para depósito fechado ou armazém geral', 'Classificam-se neste código as entradas em retorno de mercadorias remetidas para depósito em depósito fechado ou armazém geral.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (92, 1907, 'Retorno simbólico de mercadoria remetida para depósito fechado ou armazém geral', 'Classificam-se neste código as entradas em retorno simbólico de mercadorias remetidas para depósito em depósito fechado ou armazém geral, quando as mercadorias depositadas tenham sido objeto de saída a qualquer título e que não tenham retornado ao estabelecimento depositante.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (93, 1908, 'Entrada de bem por conta de contrato de comodato', 'Classificam-se neste código as entradas de bens recebidos em cumprimento de contrato de comodato.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (94, 1909, 'Retorno de bem remetido por conta de contrato de comodato', 'Classificam-se neste código as entradas de bens recebidos em devolução após cumprido o contrato de comodato.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (95, 1910, 'Entrada de bonificação, doação ou brinde', 'Classificam-se neste código as entradas de mercadorias recebidas a título de bonificação, doação ou brinde.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (96, 1911, 'Entrada de amostra grátis', 'Classificam-se neste código as entradas de mercadorias recebidas a título de amostra grátis.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (97, 1912, 'Entrada de mercadoria ou bem recebido para demonstração', 'Classificam-se neste código as entradas de mercadorias ou bens recebidos para demonstração.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (98, 1913, 'Retorno de mercadoria ou bem remetido para demonstração', 'Classificam-se neste código as entradas em retorno de mercadorias ou bens remetidos para demonstração.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (99, 1914, 'Retorno de mercadoria ou bem remetido para exposição ou feira', 'Classificam-se neste código as entradas em retorno de mercadorias ou bens remetidos para exposição ou feira.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (100, 1915, 'Entrada de mercadoria ou bem recebido para conserto ou reparo', 'Classificam-se neste código as entradas de mercadorias ou bens recebidos para conserto ou reparo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (101, 1916, 'Retorno de mercadoria ou bem remetido para conserto ou reparo', 'Classificam-se neste código as entradas em retorno de mercadorias ou bens remetidos para conserto ou reparo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (102, 1917, 'Entrada de mercadoria recebida em consignação mercantil ou industrial', 'Classificam-se neste código as entradas de mercadorias recebidas a título de consignação mercantil ou industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (103, 1918, 'Devolução de mercadoria remetida em consignação mercantil ou industrial', 'Classificam-se neste código as entradas por devolução de mercadorias remetidas anteriormente a título de consignação mercantil ou industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (104, 1919, 'Devolução simbólica de mercadoria vendida ou utilizada em processo industrial, remetida anteriormente em consignação mercantil ou industrial', 'Classificam-se neste código as entradas por devolução simbólica de mercadorias vendidas ou utilizadas em processo industrial, remetidas anteriormente a título de consignação mercantil ou industrial.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (105, 1920, 'Entrada de vasilhame ou sacaria', 'Classificam-se neste código as entradas de vasilhame ou sacaria.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (106, 1921, 'Retorno de vasilhame ou sacaria', 'Classificam-se neste código as entradas em retorno de vasilhame ou sacaria.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (107, 1922, 'Lançamento efetuado a título de simples faturamento decorrente de compra para recebimento futuro', 'Classificam-se neste código os registros efetuados a título de simples faturamento decorrente de compra para recebimento futuro.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (108, 1923, 'Entrada de mercadoria recebida do vendedor remetente, em venda à ordem', 'Classificam-se neste código as entradas de mercadorias recebidas do vendedor remetente, em vendas à ordem, cuja compra do adquirente originário, foi classificada nos códigos 1.120 - Compra para industrialização, em venda à ordem, já recebida do vendedor remetente ou 1.121 - Compra para comercialização, em venda à ordem, já recebida do vendedor remetente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (109, 1924, 'Entrada para industrialização por conta e ordem do adquirente da mercadoria, quando esta não transitar pelo estabelecimento do adquirente', 'Classificam-se neste código as entradas de insumos recebidos para serem industrializados por conta e ordem do adquirente, nas hipóteses em que os insumos não tenham transitado pelo estabelecimento do adquirente dos mesmos.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (110, 1925, 'Retorno de mercadoria remetida para industrialização por conta e ordem do adquirente da mercadoria, quando esta não transitar pelo estabelecimento do adquirente', 'Classificam-se neste código o retorno dos insumos remetidos por conta e ordem do adquirente, para industrialização e incorporados ao produto final pelo estabelecimento industrializador, nas hipóteses em que os insumos não tenham transitado pelo estabelecimento do adquirente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (111, 1926, 'Lançamento efetuado a título de reclassificação de mercadoria decorrente de formação de kit ou de sua desagregação', 'Classificam-se neste código os registros efetuados a título de reclassificação decorrente de formação de kit de mercadorias ou de sua desagregação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (112, 1931, 'Lançamento efetuado pelo tomador do serviço de transporte quando a responsabilidade de retenção do imposto for atribuída ao remetente ou alienante da mercadoria, pelo serviço de transporte realizado por transportador autônomo ou por transportador não inscrito na unidade da Federação onde iniciado o serviço. (Ajuste SINIEF 03/04)', 'Classificam-se neste código exclusivamente os lançamentos efetuados pelo tomador do serviço de transporte realizado por transportador autônomo ou por transportador não inscrito na unidade da Federação, onde iniciado o serviço, quando a responsabilidade pela retenção do imposto for atribuída ao remetente ou alienante da mercadoria.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (113, 1932, 'Aquisição de serviço de transporte iniciado em unidade da Federação diversa daquela onde inscrito o prestador. (ajuste sinief 03/04)', 'Classificam-se neste código as aquisições de serviços de transporte que tenham sido iniciados em unidade da Federação diversa daquela onde o prestador está inscrito como contribuinte.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (114, 1933, 'Aquisição de serviço tributado pelo ISSQN.(ajuste sinief 03/04)', 'Classificam-se neste código as aquisições de serviços, de competência municipal, desde que informados em documentos autorizados pelo Estado.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (115, 1949, 'Outra entrada de mercadoria ou prestação de serviço não especificada', 'Classificam-se neste código as outras entradas de mercadorias ou prestações de serviços que não tenham sido especificadas nos códigos anteriores.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (116, 2000, 'ENTRADAS OU AQUISIÇÕES DE SERVIÇOS DE OUTROS ESTADOS', 'Classificam-se, neste grupo, as operações ou prestações em que o estabelecimento remetente esteja localizado em unidade da Federação diversa daquela do destinatário')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (117, 2100, 'COMPRAS PARA INDUSTRIALIZAÇÃO, COMERCIALIZAÇÃO OU PRESTAÇÃO DE SERVIÇOS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (118, 2101, 'Compra para industrialização', 'Classificam-se neste código as compras de mercadorias a serem utilizadas em processo de industrialização. Também serão classificadas neste código as entradas de mercadorias em estabelecimento industrial de cooperativa recebidas de seus cooperados ou de estabelecimento de outra cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (119, 2102, 'Compra para comercialização', 'Classificam-se neste código as compras de mercadorias a serem comercializadas. Também serão classificadas neste código as entradas de mercadorias em estabelecimento comercial de cooperativa recebidas de seus cooperados ou de estabelecimento de outra cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (120, 2111, 'Compra para industrialização de mercadoria recebida anteriormente em consignação industrial', 'Classificam-se neste código as compras efetivas de mercadorias a serem utilizadas em processo de industrialização, recebidas anteriormente a título de consignação industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (121, 2113, 'Compra para comercialização, de mercadoria recebida anteriormente em consignação mercantil', 'Classificam-se neste código as compras efetivas de mercadorias recebidas anteriormente a título de consignação mercantil.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (122, 2116, 'Compra para industrialização originada de encomenda para recebimento futuro', 'Classificam-se neste código as compras de mercadorias a serem utilizadas em processo de industrialização, quando da entrada real da mercadoria, cuja aquisição tenha sido classificada no código 2.922 - Lançamento efetuado a título de simples faturamento decorrente de compra para recebimento futuro.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (123, 2117, 'Compra para comercialização originada de encomenda para recebimento futuro', 'Classificam-se neste código as compras de mercadorias a serem comercializadas, quando da entrada real da mercadoria, cuja aquisição tenha sido classificada no código 2.922 - Lançamento efetuado a título de simples faturamento decorrente de compra para recebimento futuro.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (124, 2118, 'Compra de mercadoria para comercialização pelo adquirente originário, entregue pelo vendedor remetente ao destinatário, em venda à ordem', 'Classificam-se neste código as compras de mercadorias já comercializadas, que, sem transitar pelo estabelecimento do adquirente originário, sejam entregues pelo vendedor remetente diretamente ao destinatário, em operação de venda à ordem, cuja venda seja classificada, pelo adquirente originário, no código 6.120 - Venda de mercadoria adquirida ou recebida de terceiros entregue ao destinatário pelo vendedor remetente, em venda à ordem.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (125, 2120, 'Compra para industrialização, em venda à ordem, já recebida do vendedor remetente', 'Classificam-se neste código as compras de mercadorias a serem utilizadas em processo de industrialização, em vendas à ordem, já recebidas do vendedor remetente, por ordem do adquirente originário.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (126, 2121, 'Compra para comercialização, em venda à ordem, já recebida do vendedor remetente', 'Classificam-se neste código as compras de mercadorias a serem comercializadas, em vendas à ordem, já recebidas do vendedor remetente por ordem do adquirente originário.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (127, 2122, 'Compra para industrialização em que a mercadoria foi remetida pelo fornecedor ao industrializador sem transitar pelo estabelecimento adquirente', 'Classificam-se neste código as compras de mercadorias a serem utilizadas em processo de industrialização, remetidas pelo fornecedor para o industrializador sem que a mercadoria tenha transitado pelo estabelecimento do adquirente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (128, 2124, 'Industrialização efetuada por outra empresa', 'Classificam-se neste código as entradas de mercadorias industrializadas por terceiros, compreendendo os valores referentes aos serviços prestados e os das mercadorias de propriedade do industrializador empregadas no processo industrial. Quando a industrialização efetuada se referir a bens do ativo imobilizado ou de mercadorias para uso ou consumo do estabelecimento encomendante, a entrada deverá ser classificada nos códigos 2.551 - Compra de bem para o ativo imobilizado ou 2.556 - Compra de material para uso ou consumo.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (129, 2125, 'Industrialização efetuada por outra empresa quando a mercadoria remetida para utilização no processo de industrialização não transitou pelo estabelecimento adquirente da mercadoria', 'Classificam-se neste código as entradas de mercadorias industrializadas por outras empresas, em que as mercadorias remetidas para utilização no processo de industrialização não transitaram pelo estabelecimento do adquirente das mercadorias, compreendendo os valores referentes aos serviços prestados e os das mercadorias de propriedade do industrializador empregadas no processo industrial. Quando a industrialização efetuada se referir a bens do ativo imobilizado ou de mercadorias para uso ou consumo do estabelecimento encomendante, a entrada deverá ser classificada nos códigos 2.551 - Compra de bem para o ativo imobilizado ou 2.556 - Compra de material para uso ou consumo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (130, 2126, 'Compra para utilização na prestação de serviço', 'Classificam-se neste código as entradas de mercadorias a serem utilizadas nas prestações de serviços.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (131, 2150, 'TRANSFERÊNCIAS PARA INDUSTRIALIZAÇÃO, COMERCIALIZAÇÃO OU PRESTAÇÃO DE SERVIÇOS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (132, 2151, 'Transferência para industrialização', 'Classificam-se neste código as entradas de mercadorias recebidas em transferência de outro estabelecimento da mesma empresa, para serem utilizadas em processo de industrialização.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (133, 2152, 'Transferência para comercialização', 'Classificam-se neste código as entradas de mercadorias recebidas em transferência de outro estabelecimento da mesma empresa, para serem comercializadas.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (134, 2153, 'Transferência de energia elétrica para distribuição', 'Classificam-se neste código as entradas de energia elétrica recebida em transferência de outro estabelecimento da mesma empresa, para distribuição.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (135, 2154, 'Transferência para utilização na prestação de serviço', 'Classificam-se neste código as entradas de mercadorias recebidas em transferência de outro estabelecimento da mesma empresa, para serem utilizadas nas prestações de serviços.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (136, 2200, 'DEVOLUÇÕES DE VENDAS DE PRODUÇÃO PRÓPRIA, DE TERCEIROS OU ANULAÇÕES DE VALORES', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (137, 2201, 'Devolução de venda de produção do estabelecimento', 'Classificam-se neste código as devoluções de vendas de produtos industrializados pelo estabelecimento, cujas saídas tenham sido classificadas como Venda de produção do estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (138, 2202, 'Devolução de venda de mercadoria adquirida ou recebida de terceiros', 'Classificam-se neste código as devoluções de vendas de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de industrialização no estabelecimento, cujas saídas tenham sido classificadas como Venda de mercadoria adquirida ou recebida de terceiros.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (139, 2203, 'Devolução de venda de produção do estabelecimento, destinada à Zona Franca de Manaus ou Áreas de Livre Comércio', 'Classificam-se neste código as devoluções de vendas de produtos industrializados pelo estabelecimento, cujas saídas foram classificadas no código 6.109 - Venda de produção do estabelecimento, destinada à Zona Franca de Manaus ou Áreas de Livre Comércio.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (140, 2204, 'Devolução de venda de mercadoria adquirida ou recebida de terceiros, destinada à Zona Franca de Manaus ou Áreas de Livre Comércio', 'Classificam-se neste código as devoluções de vendas de mercadorias adquiridas ou recebidas de terceiros, cujas saídas foram classificadas no código 6.110 - Venda de mercadoria adquirida ou recebida de terceiros, destinada à Zona Franca de Manaus ou Áreas de Livre Comércio.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (141, 2205, 'Anulação de valor relativo à prestação de serviço de comunicação', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes de prestações de serviços de comunicação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (142, 2206, 'Anulação de valor relativo à prestação de serviço de transporte', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes de prestações de serviços de transporte.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (143, 2207, 'Anulação de valor relativo à venda de energia elétrica', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes de venda de energia elétrica.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (144, 2208, 'Devolução de produção do estabelecimento, remetida em transferência', 'Classificam-se neste código as devoluções de produtos industrializados pelo estabelecimento, transferidos para outros estabelecimentos da mesma empresa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (145, 2209, 'Devolução de mercadoria adquirida ou recebida de terceiros, remetida em transferência', 'Classificam-se neste código as devoluções de mercadorias adquiridas ou recebidas de terceiros, transferidas para outros estabelecimentos da mesma empresa.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (146, 2250, 'COMPRAS DE ENERGIA ELÉTRICA', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (147, 2251, 'Compra de energia elétrica para distribuição ou comercialização', 'Classificam-se neste código as compras de energia elétrica utilizada em sistema de distribuição ou comercialização. Também serão classificadas neste código as compras de energia elétrica por cooperativas para distribuição aos seus cooperados.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (148, 2252, 'Compra de energia elétrica por estabelecimento industrial', 'Classificam-se neste código as compras de energia elétrica utilizada no processo de industrialização. Também serão classificadas neste código as compras de energia elétrica utilizada por estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (149, 2253, 'Compra de energia elétrica por estabelecimento comercial', 'Classificam-se neste código as compras de energia elétrica utilizada por estabelecimento comercial. Também serão classificadas neste código as compras de energia elétrica utilizada por estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (150, 2254, 'Compra de energia elétrica por estabelecimento prestador de serviço de transporte', 'Classificam-se neste código as compras de energia elétrica utilizada por estabelecimento prestador de serviços de transporte.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (151, 2255, 'Compra de energia elétrica por estabelecimento prestador de serviço de comunicação', 'Classificam-se neste código as compras de energia elétrica utilizada por estabelecimento prestador de serviços de comunicação.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (152, 2256, 'Compra de energia elétrica por estabelecimento de produtor rural', 'Classificam-se neste código as compras de energia elétrica utilizada por estabelecimento de produtor rural.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (153, 2257, 'Compra de energia elétrica para consumo por demanda contratada', 'Classificam-se neste código as compras de energia elétrica para consumo por demanda contratada, que prevalecerá sobre os demais códigos deste subgrupo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (154, 2300, 'AQUISIÇÕES DE SERVIÇOS DE COMUNICAÇÃO', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (155, 2301, 'Aquisição de serviço de comunicação para execução de serviço da mesma natureza', 'Classificam-se neste código as aquisições de serviços de comunicação utilizados nas prestações de serviços da mesma natureza.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (156, 2302, 'Aquisição de serviço de comunicação por estabelecimento industrial', 'Classificam-se neste código as aquisições de serviços de comunicação utilizados por estabelecimento industrial. Também serão classificadas neste código as aquisições de serviços de comunicação utilizados por estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (157, 2303, 'Aquisição de serviço de comunicação por estabelecimento comercial', 'Classificam-se neste código as aquisições de serviços de comunicação utilizados por estabelecimento comercial. Também serão classificadas neste código as aquisições de serviços de comunicação utilizados por estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (158, 2304, 'Aquisição de serviço de comunicação por estabelecimento de prestador de serviço de transporte', 'Classificam-se neste código as aquisições de serviços de comunicação utilizado por estabelecimento prestador de serviço de transporte.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (159, 2305, 'Aquisição de serviço de comunicação por estabelecimento de geradora ou de distribuidora de energia elétrica', 'Classificam-se neste código as aquisições de serviços de comunicação utilizados por estabelecimento de geradora ou de distribuidora de energia elétrica.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (160, 2306, 'Aquisição de serviço de comunicação por estabelecimento de produtor rural', 'Classificam-se neste código as aquisições de serviços de comunicação utilizados por estabelecimento de produtor rural.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (161, 2350, 'AQUISIÇÕES DE SERVIÇOS DE TRANSPORTE', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (162, 2351, 'Aquisição de serviço de transporte para execução de serviço da mesma natureza', 'Classificam-se neste código as aquisições de serviços de transporte utilizados nas prestações de serviços da mesma natureza.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (163, 2352, 'Aquisição de serviço de transporte por estabelecimento industrial', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento industrial. Também serão classificadas neste código as aquisições de serviços de transporte utilizados por estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (164, 2353, 'Aquisição de serviço de transporte por estabelecimento comercial', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento comercial. Também serão classificadas neste código as aquisições de serviços de transporte utilizados por estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (165, 2354, 'Aquisição de serviço de transporte por estabelecimento de prestador de serviço de comunicação', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento prestador de serviços de comunicação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (166, 2355, 'Aquisição de serviço de transporte por estabelecimento de geradora ou de distribuidora de energia elétrica', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento de geradora ou de distribuidora de energia elétrica.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (167, 2356, 'Aquisição de serviço de transporte por estabelecimento de produtor rural', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento de produtor rural.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (168, 2400, 'ENTRADAS DE MERCADORIAS SUJEITAS AO REGIME DE SUBSTITUIÇÃO TRIBUTÁRIA', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (169, 2401, 'Compra para industrialização em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as compras de mercadorias a serem utilizadas em processo de industrialização, decorrentes de operações com mercadorias sujeitas ao regime de substituição tributária. Também serão classificadas neste código as compras por estabelecimento industrial de cooperativa de mercadorias sujeitas ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (170, 2403, 'Compra para comercialização em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as compras de mercadorias a serem comercializadas, decorrentes de operações com mercadorias sujeitas ao regime de substituição tributária. Também serão classificadas neste código as compras de mercadorias sujeitas ao regime de substituição tributária em estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (171, 2406, 'Compra de bem para o ativo imobilizado cuja mercadoria está sujeita ao regime de substituição tributária', 'Classificam-se neste código as compras de bens destinados ao ativo imobilizado do estabelecimento, em operações com mercadorias sujeitas ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (172, 2407, 'Compra de mercadoria para uso ou consumo cuja mercadoria está sujeita ao regime de substituição tributária', 'Classificam-se neste código as compras de mercadorias destinadas ao uso ou consumo do estabelecimento, em operações com mercadorias sujeitas ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (173, 2408, 'Transferência para industrialização em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as mercadorias recebidas em transferência de outro estabelecimento da mesma empresa, para serem industrializadas no estabelecimento, em operações com mercadorias sujeitas ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (174, 2409, 'Transferência para comercialização em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as mercadorias recebidas em transferência de outro estabelecimento da mesma empresa, para serem comercializadas, decorrentes de operações sujeitas ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (175, 2410, 'Devolução de venda de produção do estabelecimento em operação com produto sujeito ao regime de substituição tributária', 'Classificam-se neste código as devoluções de produtos industrializados e vendidos pelo estabelecimento, cujas saídas tenham sido classificadas como Venda de produção do estabelecimento em operação com produto sujeito ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (176, 2411, 'Devolução de venda de mercadoria adquirida ou recebida de terceiros em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as devoluções de vendas de mercadorias adquiridas ou recebidas de terceiros, cujas saídas tenham sido classificadas como Venda de mercadoria adquirida ou recebida de terceiros em operação com mercadoria sujeita ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (177, 2414, 'Retorno de produção do estabelecimento, remetida para venda fora do estabelecimento em operação com produto sujeito ao regime de substituição tributária', 'Classificam-se neste código as entradas, em retorno, de produtos industrializados pelo estabelecimento, remetidos para vendas fora do estabelecimento, inclusive por meio de veículos, em operações com produtos sujeitos ao regime de substituição tributária, e não comercializadas.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (178, 2415, 'Retorno de mercadoria adquirida ou recebida de terceiros, remetida para venda fora do estabelecimento em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as entradas, em retorno, de mercadorias adquiridas ou recebidas de terceiros remetidas para vendas fora do estabelecimento, inclusive por meio de veículos, em operações com mercadorias sujeitas ao regime de substituição tributária, e não comercializadas.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (179, 2500, 'ENTRADAS DE MERCADORIAS REMETIDAS COM FIM ESPECÍFICO DE EXPORTAÇÃO E EVENTUAIS DEVOLUÇÕES', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (180, 2501, 'Entrada de mercadoria recebida com fim específico de exportação', 'Classificam-se neste código as entradas de mercadorias em estabelecimento de trading company, empresa comercial exportadora ou outro estabelecimento do remetente, com fim específico de exportação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (181, 2503, 'Entrada decorrente de devolução de produto remetido com fim específico de exportação, de produção do estabelecimento', 'Classificam-se neste código as devoluções de produtos industrializados pelo estabelecimento, remetidos a trading company, a empresa comercial exportadora ou a outro estabelecimento do remetente, com fim específico de exportação, cujas saídas tenham sido classificadas no código 6.501 - Remessa de produção do estabelecimento, com fim específico de exportação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (182, 2504, 'Entrada decorrente de devolução de mercadoria remetida com fim específico de exportação, adquirida ou recebida de terceiros', 'Classificam-se neste código as devoluções de mercadorias adquiridas ou recebidas de terceiros remetidas a trading company, a empresa comercial exportadora ou a outro estabelecimento do remetente, com fim específico de exportação, cujas saídas tenham sido classificadas no código 6.502 - Remessa de mercadoria adquirida ou recebida de terceiros, com fim específico de exportação.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (183, 2550, 'OPERAÇÕES COM BENS DE ATIVO IMOBILIZADO E MATERIAIS PARA USO OU CONSUMO', NULL)");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (184, 2551, 'Compra de bem para o ativo imobilizado', 'Classificam-se neste código as compras de bens destinados ao ativo imobilizado do estabelecimento.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (185, 2552, 'Transferência de bem do ativo imobilizado', 'Classificam-se neste código as entradas de bens destinados ao ativo imobilizado recebidos em transferência de outro estabelecimento da mesma empresa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (186, 2553, 'Devolução de venda de bem do ativo imobilizado', 'Classificam-se neste código as devoluções de vendas de bens do ativo imobilizado, cujas saídas tenham sido classificadas no código 6.551 - Venda de bem do ativo imobilizado.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (187, 2554, 'Retorno de bem do ativo imobilizado remetido para uso fora do estabelecimento', 'Classificam-se neste código as entradas por retorno de bens do ativo imobilizado remetidos para uso fora do estabelecimento, cujas saídas tenham sido classificadas no código 6.554 - Remessa de bem do ativo imobilizado para uso fora do estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (188, 2555, 'Entrada de bem do ativo imobilizado de terceiro, remetido para uso no estabelecimento', 'Classificam-se neste código as entradas de bens do ativo imobilizado de terceiros, remetidos para uso no estabelecimento.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (189, 2556, 'Compra de material para uso ou consumo', 'Classificam-se neste código as compras de mercadorias destinadas ao uso ou consumo do estabelecimento.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (190, 2557, 'Transferência de material para uso ou consumo', 'Classificam-se neste código as entradas de materiais para uso ou consumo recebidos em transferência de outro estabelecimento da mesma empresa.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (191, 2600, 'CRÉDITOS E RESSARCIMENTOS DE ICMS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (192, 2603, 'Ressarcimento de ICMS retido por substituição tributária', 'Classificam-se neste código os lançamentos destinados ao registro de ressarcimento de ICMS retido por substituição tributária a contribuinte substituído, efetuado pelo contribuinte substituto, nas hipóteses previstas na legislação aplicável.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (193, 2900, 'OUTRAS ENTRADAS DE MERCADORIAS OU AQUISIÇÕES DE SERVIÇOS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (194, 2901, 'Entrada para industrialização por encomenda', 'Classificam-se neste código as entradas de insumos recebidos para industrialização por encomenda de outra empresa ou de outro estabelecimento da mesma empresa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (195, 2902, 'Retorno de mercadoria remetida para industrialização por encomenda', 'Classificam-se neste código o retorno dos insumos remetidos para industrialização por encomenda, incorporados ao produto final pelo estabelecimento industrializador.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (196, 2903, 'Entrada de mercadoria remetida para industrialização e não aplicada no referido processo', 'Classificam-se neste código as entradas em devolução de insumos remetidos para industrialização e não aplicados no referido processo.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (197, 2904, 'Retorno de remessa para venda fora do estabelecimento', 'Classificam-se neste código as entradas em retorno de mercadorias remetidas para venda fora do estabelecimento, inclusive por meio de veículos, e não comercializadas.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (198, 2905, 'Entrada de mercadoria recebida para depósito em depósito fechado ou armazém geral', 'Classificam-se neste código as entradas de mercadorias recebidas para depósito em depósito fechado ou armazém geral.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (199, 2906, 'Retorno de mercadoria remetida para depósito fechado ou armazém geral', 'Classificam-se neste código as entradas em retorno de mercadorias remetidas para depósito em depósito fechado ou armazém geral.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (200, 2907, 'Retorno simbólico de mercadoria remetida para depósito fechado ou armazém geral', 'Classificam-se neste código as entradas em retorno simbólico de mercadorias remetidas para depósito em depósito fechado ou armazém geral, quando as mercadorias depositadas tenham sido objeto de saída a qualquer título e que não tenham retornado ao estabelecimento depositante.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (201, 2908, 'Entrada de bem por conta de contrato de comodato', 'Classificam-se neste código as entradas de bens recebidos em cumprimento de contrato de comodato.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (202, 2909, 'Retorno de bem remetido por conta de contrato de comodato', 'Classificam-se neste código as entradas de bens recebidos em devolução após cumprido o contrato de comodato.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (203, 2910, 'Entrada de bonificação, doação ou brinde', 'Classificam-se neste código as entradas de mercadorias recebidas a título de bonificação, doação ou brinde.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (204, 2911, 'Entrada de amostra grátis', 'Classificam-se neste código as entradas de mercadorias recebidas a título de amostra grátis.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (205, 2912, 'Entrada de mercadoria ou bem recebido para demonstração', 'Classificam-se neste código as entradas de mercadorias ou bens recebidos para demonstração.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (206, 2913, 'Retorno de mercadoria ou bem remetido para demonstração', 'Classificam-se neste código as entradas em retorno de mercadorias ou bens remetidos para demonstração.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (207, 2914, 'Retorno de mercadoria ou bem remetido para exposição ou feira', 'Classificam-se neste código as entradas em retorno de mercadorias ou bens remetidos para exposição ou feira.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (208, 2915, 'Entrada de mercadoria ou bem recebido para conserto ou reparo', 'Classificam-se neste código as entradas de mercadorias ou bens recebidos para conserto ou reparo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (209, 2916, 'Retorno de mercadoria ou bem remetido para conserto ou reparo', 'Classificam-se neste código as entradas em retorno de mercadorias ou bens remetidos para conserto ou reparo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (210, 2917, 'Entrada de mercadoria recebida em consignação mercantil ou industrial', 'Classificam-se neste código as entradas de mercadorias recebidas a título de consignação mercantil ou industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (211, 2918, 'Devolução de mercadoria remetida em consignação mercantil ou industrial', 'Classificam-se neste código as entradas por devolução de mercadorias remetidas anteriormente a título de consignação mercantil ou industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (212, 2919, 'Devolução simbólica de mercadoria vendida ou utilizada em processo industrial, remetida anteriormente em consignação mercantil ou industrial', 'Classificam-se neste código as entradas por devolução simbólica de mercadorias vendidas ou utilizadas em processo industrial, remetidas anteriormente a título de consignação mercantil ou industrial.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (213, 2920, 'Entrada de vasilhame ou sacaria', 'Classificam-se neste código as entradas de vasilhame ou sacaria.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (214, 2921, 'Retorno de vasilhame ou sacaria', 'Classificam-se neste código as entradas em retorno de vasilhame ou sacaria.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (215, 2922, 'Lançamento efetuado a título de simples faturamento decorrente de compra para recebimento futuro', 'Classificam-se neste código os registros efetuados a título de simples faturamento decorrente de compra para recebimento futuro.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (216, 2923, 'Entrada de mercadoria recebida do vendedor remetente, em venda à ordem', 'Classificam-se neste código as entradas de mercadorias recebidas do vendedor remetente, em vendas à ordem, cuja compra do adquirente originário, foi classificada nos códigos 2.120 - Compra para industrialização, em venda à ordem, já recebida do vendedor remetente ou 2.121 - Compra para comercialização, em venda à ordem, já recebida do vendedor remetente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (217, 2924, 'Entrada para industrialização por conta e ordem do adquirente da mercadoria, quando esta não transitar pelo estabelecimento do adquirente', 'Classificam-se neste código as entradas de insumos recebidos para serem industrializados por conta e ordem do adquirente, nas hipóteses em que os insumos não tenham transitado pelo estabelecimento do adquirente dos mesmos.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (218, 2925, 'Retorno de mercadoria remetida para industrialização por conta e ordem do adquirente da mercadoria, quando esta não transitar pelo estabelecimento do adquirente', 'Classificam-se neste código o retorno dos insumos remetidos por conta e ordem do adquirente, para industrialização e incorporados ao produto final pelo estabelecimento industrializador, nas hipóteses em que os insumos não tenham transitado pelo estabelecimento do adquirente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (219, 2931, 'Lançamento efetuado pelo tomador do serviço de transporte quando a responsabilidade de retenção do imposto for atribuída ao remetente ou alienante da mercadoria, pelo serviço de transporte realizado por transportador autônomo ou por transportador não inscrito na unidade da Federação onde iniciado o serviço. (ajuste sinief 03/04)', 'Classificam-se neste código exclusivamente os lançamentos efetuados pelo tomador do serviço de transporte realizado por transportador autônomo ou por transportador não inscrito na unidade da Federação, onde iniciado o serviço, quando a responsabilidade pela retenção do imposto for atribuída ao remetente ou alienante da mercadoria.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (220, 2932, 'Aquisição de serviço de transporte iniciado em unidade da Federação diversa daquela onde inscrito o prestador. (ajuste sinief 03/04)', 'Classificam-se neste código as aquisições de serviços de transporte que tenham sido iniciados em unidade da Federação diversa daquela onde o prestador está inscrito como contribuinte.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (221, 2933, 'Aquisição de serviço tributado pelo ISSQN. (ajuste sinief 03/04)', 'Classificam-se neste código as aquisições de serviços, de competência municipal, desde que informados em documentos autorizados pelo Estado.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (222, 2949, 'Outra entrada de mercadoria ou prestação de serviço não especificado', 'Classificam-se neste código as outras entradas de mercadorias ou prestações de serviços que não tenham sido especificados nos códigos anteriores.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (223, 3000, 'ENTRADAS OU AQUISIÇÕES DE SERVIÇOS DO EXTERIOR', 'Classificam-se, neste grupo, as entradas de mercadorias oriundas de outro país, inclusive as decorrentes de aquisição por arrematação, concorrência ou qualquer outra forma de alienação promovida pelo poder público, e os serviços iniciados no exterior')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (224, 3100, 'COMPRAS PARA INDUSTRIALIZAÇÃO, COMERCIALIZAÇÃO OU PRESTAÇÃO DE SERVIÇOS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (225, 3101, 'Compra para industrialização', 'Classificam-se neste código as compras de mercadorias a serem utilizadas em processo de industrialização. Também serão classificadas neste código as entradas de mercadorias em estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (226, 3102, 'Compra para comercialização', 'Classificam-se neste código as compras de mercadorias a serem comercializadas. Também serão classificadas neste código as entradas de mercadorias em estabelecimento comercial de cooperativa.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (227, 3126, 'Compra para utilização na prestação de serviço', 'Classificam-se neste código as entradas de mercadorias a serem utilizadas nas prestações de serviços.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (228, 3127, 'Compra para industrialização sob o regime de drawback ', 'Classificam-se neste código as compras de mercadorias a serem utilizadas em processo de industrialização e posterior exportação do produto resultante, cujas vendas serão classificadas no código 7.127 - Venda de produção do estabelecimento sob o regime de drawback.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (229, 3200, 'DEVOLUÇÕES DE VENDAS DE PRODUÇÃO PRÓPRIA, DE TERCEIROS OU ANULAÇÕES DE VALORES', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (230, 3201, 'Devolução de venda de produção do estabelecimento', 'Classificam-se neste código as devoluções de vendas de produtos industrializados pelo estabelecimento, cujas saídas tenham sido classificadas como Venda de produção do estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (231, 3202, 'Devolução de venda de mercadoria adquirida ou recebida de terceiros', 'Classificam-se neste código as devoluções de vendas de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de industrialização no estabelecimento, cujas saídas tenham sido classificadas como Venda de mercadoria adquirida ou recebida de terceiros.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (232, 3205, 'Anulação de valor relativo à prestação de serviço de comunicação', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes de prestações de serviços de comunicação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (233, 3206, 'Anulação de valor relativo à prestação de serviço de transporte', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes de prestações de serviços de transporte.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (234, 3207, 'Anulação de valor relativo à venda de energia elétrica', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes de venda de energia elétrica.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (235, 3211, 'Devolução de venda de produção do estabelecimento sob o regime de drawback ', 'Classificam-se neste código as devoluções de vendas de produtos industrializados pelo estabelecimento sob o regime de drawback.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (236, 3250, 'COMPRAS DE ENERGIA ELÉTRICA', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (237, 3251, 'Compra de energia elétrica para distribuição ou comercialização', 'Classificam-se neste código as compras de energia elétrica utilizada em sistema de distribuição ou comercialização. Também serão classificadas neste código as compras de energia elétrica por cooperativas para distribuição aos seus cooperados.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (238, 3300, 'AQUISIÇÕES DE SERVIÇOS DE COMUNICAÇÃO', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (239, 3301, 'Aquisição de serviço de comunicação para execução de serviço da mesma natureza', 'Classificam-se neste código as aquisições de serviços de comunicação utilizados nas prestações de serviços da mesma natureza.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (240, 3350, 'AQUISIÇÕES DE SERVIÇOS DE TRANSPORTE', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (241, 3351, 'Aquisição de serviço de transporte para execução de serviço da mesma natureza', 'Classificam-se neste código as aquisições de serviços de transporte utilizados nas prestações de serviços da mesma natureza.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (242, 3352, 'Aquisição de serviço de transporte por estabelecimento industrial', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento industrial. Também serão classificadas neste código as aquisições de serviços de transporte utilizados por estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (243, 3353, 'Aquisição de serviço de transporte por estabelecimento comercial', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento comercial. Também serão classificadas neste código as aquisições de serviços de transporte utilizados por estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (244, 3354, 'Aquisição de serviço de transporte por estabelecimento de prestador de serviço de comunicação', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento prestador de serviços de comunicação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (245, 3355, 'Aquisição de serviço de transporte por estabelecimento de geradora ou de distribuidora de energia elétrica', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento de geradora ou de distribuidora de energia elétrica.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (246, 3356, 'Aquisição de serviço de transporte por estabelecimento de produtor rural', 'Classificam-se neste código as aquisições de serviços de transporte utilizados por estabelecimento de produtor rural.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (247, 3500, 'ENTRADAS DE MERCADORIAS REMETIDAS COM FIM ESPECÍFICO DE EXPORTAÇÃO E EVENTUAIS DEVOLUÇÕES', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (248, 3503, 'Devolução de mercadoria exportada que tenha sido recebida com fim específico de exportação', 'Classificam-se neste código as devoluções de mercadorias exportadas por trading company, empresa comercial exportadora ou outro estabelecimento do remetente, recebidas com fim específico de exportação, cujas saídas tenham sido classificadas no código 7.501 - Exportação de mercadorias recebidas com fim específico de exportação.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (249, 3550, 'OPERAÇÕES COM BENS DE ATIVO IMOBILIZADO E MATERIAIS PARA USO OU CONSUMO', NULL)");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (250, 3551, 'Compra de bem para o ativo imobilizado', 'Classificam-se neste código as compras de bens destinados ao ativo imobilizado do estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (251, 3553, 'Devolução de venda de bem do ativo imobilizado', 'Classificam-se neste código as devoluções de vendas de bens do ativo imobilizado, cujas saídas tenham sido classificadas no código 7.551 - Venda de bem do ativo imobilizado.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (252, 3556, 'Compra de material para uso ou consumo', 'Classificam-se neste código as compras de mercadorias destinadas ao uso ou consumo do estabelecimento.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (253, 3900, 'OUTRAS ENTRADAS DE MERCADORIAS OU AQUISIÇÕES DE SERVIÇOS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (254, 3930, 'Lançamento efetuado a título de entrada de bem sob amparo de regime especial aduaneiro de admissão temporária', 'Classificam-se neste código os lançamentos efetuados a título de entrada de bens amparada por regime especial aduaneiro de admissão temporária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (255, 3949, 'Outra entrada de mercadoria ou prestação de serviço não especificado', 'Classificam-se neste código as outras entradas de mercadorias ou prestações de serviços que não tenham sido especificados nos códigos anteriores.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (256, 5000, 'SAÍDAS OU PRESTAÇÕES DE SERVIÇOS PARA O ESTADO', 'Classificam-se, neste grupo, as operações ou prestações em que o estabelecimento remetente esteja localizado na mesma unidade da Federação do destinatário')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (257, 5100, 'VENDAS DE PRODUÇÃO PRÓPRIA OU DE TERCEIROS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (258, 5101, 'Venda de produção do estabelecimento', 'Classificam-se neste código as vendas de produtos industrializados no estabelecimento. Também serão classificadas neste código as vendas de mercadorias por estabelecimento industrial de cooperativa destinadas a seus cooperados ou a estabelecimento de outra cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (259, 5102, 'Venda de mercadoria adquirida ou recebida de terceiros', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros para industrialização ou comercialização, que não tenham sido objeto de qualquer processo industrial no estabelecimento. Também serão classificadas neste código as vendas de mercadorias por estabelecimento comercial de cooperativa destinadas a seus cooperados ou estabelecimento de outra cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (260, 5103, 'Venda de produção do estabelecimento, efetuada fora do estabelecimento', 'Classificam-se neste código as vendas efetuadas fora do estabelecimento, inclusive por meio de veículo, de produtos industrializados no estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (261, 5104, 'Venda de mercadoria adquirida ou recebida de terceiros, efetuada fora do estabelecimento', 'Classificam-se neste código as vendas efetuadas fora do estabelecimento, inclusive por meio de veículo, de mercadorias adquiridas ou recebidas de terceiros para industrialização ou comercialização, que não tenham sido objeto de qualquer processo industrial no estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (262, 5105, 'Venda de produção do estabelecimento que não deva por ele transitar', 'Classificam-se neste código as vendas de produtos industrializados no estabelecimento, armazenados em depósito fechado, armazém geral ou outro sem que haja retorno ao estabelecimento depositante.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (263, 5106, 'Venda de mercadoria adquirida ou recebida de terceiros, que não deva por ele transitar', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros para industrialização ou comercialização, armazenadas em depósito fechado, armazém geral ou outro, que não tenham sido objeto de qualquer processo industrial no estabelecimento sem que haja retorno ao estabelecimento depositante. Também serão classificadas neste código as vendas de mercadorias importadas, cuja saída ocorra do recinto alfandegado ou da repartição alfandegária onde se processou o desembaraço aduaneiro, com destino ao estabelecimento do comprador, sem transitar pelo estabelecimento do importador.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (264, 5109, 'Venda de produção do estabelecimento, destinada à Zona Franca de Manaus ou Áreas de Livre Comércio', 'Classificam-se neste código as vendas de produtos industrializados pelo estabelecimento, destinados à Zona Franca de Manaus ou Áreas de Livre Comércio.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (265, 5110, 'Venda de mercadoria adquirida ou recebida de terceiros, destinada à Zona Franca de Manaus ou Áreas de Livre Comércio', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, destinadas à Zona Franca de Manaus ou Áreas de Livre Comércio.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (266, 5111, 'Venda de produção do estabelecimento remetida anteriormente em consignação industrial', 'Classificam-se neste código as vendas efetivas de produtos industrializados no estabelecimento remetidos anteriormente a título de consignação industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (267, 5112, 'Venda de mercadoria adquirida ou recebida de terceiros remetida anteriormente em consignação industrial', 'Classificam-se neste código as vendas efetivas de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, remetidas anteriormente a título de consignação industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (268, 5113, 'Venda de produção do estabelecimento remetida anteriormente em consignação mercantil', 'Classificam-se neste código as vendas efetivas de produtos industrializados no estabelecimento remetidos anteriormente a título de consignação mercantil.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (269, 5114, 'Venda de mercadoria adquirida ou recebida de terceiros remetida anteriormente em consignação mercantil', 'Classificam-se neste código as vendas efetivas de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, remetidas anteriormente a título de consignação mercantil.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (270, 5115, 'Venda de mercadoria adquirida ou recebida de terceiros, recebida anteriormente em consignação mercantil', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros, recebidas anteriormente a título de consignação mercantil.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (271, 5116, 'Venda de produção do estabelecimento originada de encomenda para entrega futura', 'Classificam-se neste código as vendas de produtos industrializados pelo estabelecimento, quando da saída real do produto, cujo faturamento tenha sido classificado no código 5.922 - Lançamento efetuado a título de simples faturamento decorrente de venda para entrega futura.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (272, 5117, 'Venda de mercadoria adquirida ou recebida de terceiros, originada de encomenda para entrega futura', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, quando da saída real da mercadoria, cujo faturamento tenha sido classificado no código 5.922 - Lançamento efetuado a título de simples faturamento decorrente de venda para entrega futura.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (273, 5118, 'Venda de produção do estabelecimento entregue ao destinatário por conta e ordem do adquirente originário, em venda à ordem', 'Classificam-se neste código as vendas à ordem de produtos industrializados pelo estabelecimento, entregues ao destinatário por conta e ordem do adquirente originário.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (274, 5119, 'Venda de mercadoria adquirida ou recebida de terceiros entregue ao destinatário por conta e ordem do adquirente originário, em venda à ordem', 'Classificam-se neste código as vendas à ordem de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, entregues ao destinatário por conta e ordem do adquirente originário.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (275, 5120, 'Venda de mercadoria adquirida ou recebida de terceiros entregue ao destinatário pelo vendedor remetente, em venda à ordem', 'Classificam-se neste código as vendas à ordem de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, entregues pelo vendedor remetente ao destinatário, cuja compra seja classificada, pelo adquirente originário, no código 1.118 - Compra de mercadoria pelo adquirente originário, entregue pelo vendedor remetente ao destinatário, em venda à ordem.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (276, 5122, 'Venda de produção do estabelecimento remetida para industrialização, por conta e ordem do adquirente, sem transitar pelo estabelecimento do adquirente', 'Classificam-se neste código as vendas de produtos industrializados no estabelecimento, remetidos para serem industrializados em outro estabelecimento, por conta e ordem do adquirente, sem que os produtos tenham transitado pelo estabelecimento do adquirente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (277, 5123, 'Venda de mercadoria adquirida ou recebida de terceiros remetida para industrialização, por conta e ordem do adquirente, sem transitar pelo estabelecimento do adquirente', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, remetidas para serem industrializadas em outro estabelecimento, por conta e ordem do adquirente, sem que as mercadorias tenham transitado pelo estabelecimento do adquirente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (278, 5124, 'Industrialização efetuada para outra empresa', 'Classificam-se neste código as saídas de mercadorias industrializadas para terceiros, compreendendo os valores referentes aos serviços prestados e os das mercadorias de propriedade do industrializador empregadas no processo industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (279, 5125, 'Industrialização efetuada para outra empresa quando a mercadoria recebida para utilização no processo de industrialização não transitar pelo estabelecimento adquirente da mercadoria', 'Classificam-se neste código as saídas de mercadorias industrializadas para outras empresas, em que as mercadorias recebidas para utilização no processo de industrialização não tenham transitado pelo estabelecimento do adquirente das mercadorias, compreendendo os valores referentes aos serviços prestados e os das mercadorias de propriedade do industrializador empregadas no processo industrial.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (280, 5150, 'TRANSFERÊNCIAS DE PRODUÇÃO PRÓPRIA OU DE TERCEIROS', NULL)");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (281, 5151, 'Transferência de produção do estabelecimento', 'Classificam-se neste código os produtos industrializados no estabelecimento e transferidos para outro estabelecimento da mesma empresa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (282, 5152, 'Transferência de mercadoria adquirida ou recebida de terceiros', 'Classificam-se neste código as mercadorias adquiridas ou recebidas de terceiros para industrialização ou comercialização e que não tenham sido objeto de qualquer processo industrial no estabelecimento, transferidas para outro estabelecimento da mesma empresa.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (283, 5153, 'Transferência de energia elétrica', 'Classificam-se neste código as transferências de energia elétrica para outro estabelecimento da mesma empresa, para distribuição.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (284, 5155, 'Transferência de produção do estabelecimento, que não deva por ele transitar', 'Classificam-se neste código as transferências para outro estabelecimento da mesma empresa, de produtos industrializados no estabelecimento que tenham sido remetidos para armazém geral, depósito fechado ou outro, sem que haja retorno ao estabelecimento depositante.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (285, 5156, 'Transferência de mercadoria adquirida ou recebida de terceiros, que não deva por ele transitar', 'Classificam-se neste código as transferências para outro estabelecimento da mesma empresa, de mercadorias adquiridas ou recebidas de terceiros para industrialização ou comercialização, que não tenham sido objeto de qualquer processo industrial, remetidas para armazém geral, depósito fechado ou outro, sem que haja retorno ao estabelecimento depositante.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (286, 5200, 'DEVOLUÇÕES DE COMPRAS PARA INDUSTRIALIZAÇÃO, COMERCIALIZAÇÃO OU ANULAÇÕES DE VALORES', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (287, 5201, 'Devolução de compra para industrialização', 'Classificam-se neste código as devoluções de mercadorias adquiridas para serem utilizadas em processo de industrialização, cujas entradas tenham sido classificadas como Compra para industrialização.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (288, 5202, 'Devolução de compra para comercialização', 'Classificam-se neste código as devoluções de mercadorias adquiridas para serem comercializadas, cujas entradas tenham sido classificadas como Compra para comercialização.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (289, 5205, 'Anulação de valor relativo a aquisição de serviço de comunicação', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes das aquisições de serviços de comunicação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (290, 5206, 'Anulação de valor relativo a aquisição de serviço de transporte', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes das aquisições de serviços de transporte.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (291, 5207, 'Anulação de valor relativo à compra de energia elétrica', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes da compra de energia elétrica.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (292, 5208, 'Devolução de mercadoria recebida em transferência para industrialização', 'Classificam-se neste código as devoluções de mercadorias recebidas em transferência de outros estabelecimentos da mesma empresa, para serem utilizadas em processo de industrialização.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (293, 5209, 'Devolução de mercadoria recebida em transferência para comercialização', 'Classificam-se neste código as devoluções de mercadorias recebidas em transferência de outro estabelecimento da mesma empresa, para serem comercializadas.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (294, 5210, 'Devolução de compra para utilização na prestação de serviço', 'Classificam-se neste código as devoluções de mercadorias adquiridas para utilização na prestação de serviços, cujas entradas tenham sido classificadas no código 1.126 - Compra para utilização na prestação de serviço.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (295, 5250, 'VENDAS DE ENERGIA ELÉTRICA', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (296, 5251, 'Venda de energia elétrica para distribuição ou comercialização', 'Classificam-se neste código as vendas de energia elétrica destinada à distribuição ou comercialização. Também serão classificadas neste código as vendas de energia elétrica destinada a cooperativas para distribuição aos seus cooperados.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (297, 5252, 'Venda de energia elétrica para estabelecimento industrial', 'Classificam-se neste código as vendas de energia elétrica para consumo por estabelecimento industrial. Também serão classificadas neste código as vendas de energia elétrica destinada a estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (298, 5253, 'Venda de energia elétrica para estabelecimento comercial', 'Classificam-se neste código as vendas de energia elétrica para consumo por estabelecimento comercial. Também serão classificadas neste código as vendas de energia elétrica destinada a estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (299, 5254, 'Venda de energia elétrica para estabelecimento prestador de serviço de transporte', 'Classificam-se neste código as vendas de energia elétrica para consumo por estabelecimento de prestador de serviços de transporte.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (300, 5255, 'Venda de energia elétrica para estabelecimento prestador de serviço de comunicação', 'Classificam-se neste código as vendas de energia elétrica para consumo por estabelecimento de prestador de serviços de comunicação.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (301, 5256, 'Venda de energia elétrica para estabelecimento de produtor rural', 'Classificam-se neste código as vendas de energia elétrica para consumo por estabelecimento de produtor rural.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (302, 5257, 'Venda de energia elétrica para consumo por demanda contratada', 'Classificam-se neste código as vendas de energia elétrica para consumo por demanda contratada, que prevalecerá sobre os demais códigos deste subgrupo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (303, 5258, 'Venda de energia elétrica a não contribuinte', 'Classificam-se neste código as vendas de energia elétrica a pessoas físicas ou a pessoas jurídicas não indicadas nos códigos anteriores.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (304, 5300, 'PRESTAÇÕES DE SERVIÇOS DE COMUNICAÇÃO', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (305, 5301, 'Prestação de serviço de comunicação para execução de serviço da mesma natureza', 'Classificam-se neste código as prestações de serviços de comunicação destinados às prestações de serviços da mesma natureza.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (306, 5302, 'Prestação de serviço de comunicação a estabelecimento industrial', 'Classificam-se neste código as prestações de serviços de comunicação a estabelecimento industrial. Também serão classificados neste código os serviços de comunicação prestados a estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (307, 5303, 'Prestação de serviço de comunicação a estabelecimento comercial', 'Classificam-se neste código as prestações de serviços de comunicação a estabelecimento comercial. Também serão classificados neste código os serviços de comunicação prestados a estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (308, 5304, 'Prestação de serviço de comunicação a estabelecimento de prestador de serviço de transporte', 'Classificam-se neste código as prestações de serviços de comunicação a estabelecimento prestador de serviço de transporte.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (309, 5305, 'Prestação de serviço de comunicação a estabelecimento de geradora ou de distribuidora de energia elétrica', 'Classificam-se neste código as prestações de serviços de comunicação a estabelecimento de geradora ou de distribuidora de energia elétrica.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (310, 5306, 'Prestação de serviço de comunicação a estabelecimento de produtor rural', 'Classificam-se neste código as prestações de serviços de comunicação a estabelecimento de produtor rural.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (311, 5307, 'Prestação de serviço de comunicação a não contribuinte', 'Classificam-se neste código as prestações de serviços de comunicação a pessoas físicas ou a pessoas jurídicas não indicadas nos códigos anteriores.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (312, 5350, 'PRESTAÇÕES DE SERVIÇOS DE TRANSPORTE', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (313, 5351, 'Prestação de serviço de transporte para execução de serviço da mesma natureza', 'Classificam-se neste código as prestações de serviços de transporte destinados às prestações de serviços da mesma natureza.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (314, 5352, 'Prestação de serviço de transporte a estabelecimento industrial', 'Classificam-se neste código as prestações de serviços de transporte a estabelecimento industrial. Também serão classificados neste código os serviços de transporte prestados a estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (315, 5353, 'Prestação de serviço de transporte a estabelecimento comercial', 'Classificam-se neste código as prestações de serviços de transporte a estabelecimento comercial. Também serão classificados neste código os serviços de transporte prestados a estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (316, 5354, 'Prestação de serviço de transporte a estabelecimento de prestador de serviço de comunicação', 'Classificam-se neste código as prestações de serviços de transporte a estabelecimento prestador de serviços de comunicação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (317, 5355, 'Prestação de serviço de transporte a estabelecimento de geradora ou de distribuidora de energia elétrica', 'Classificam-se neste código as prestações de serviços de transporte a estabelecimento de geradora ou de distribuidora de energia elétrica.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (318, 5356, 'Prestação de serviço de transporte a estabelecimento de produtor rural', 'Classificam-se neste código as prestações de serviços de transporte a estabelecimento de produtor rural.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (319, 5357, 'Prestação de serviço de transporte a não contribuinte', 'Classificam-se neste código as prestações de serviços de transporte a pessoas físicas ou a pessoas jurídicas não indicadas nos códigos anteriores.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (320, 5359, 'Prestação de serviço de transporte a contribuinte ou a não contribuinte quando a mercadoria transportada está dispensada de emissão de nota fiscal. (ajuste sinief 03/04)', 'Classificam-se neste código as prestações de serviços de transporte a contribuintes ou a não contribuintes, exclusivamente quando não existe a obrigação legal de emissão de nota fiscal para a mercadoria transportada.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (321, 5400, 'SAÍDAS DE MERCADORIAS SUJEITAS AO REGIME DE SUBSTITUIÇÃO TRIBUTÁRIA', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (322, 5401, 'Venda de produção do estabelecimento em operação com produto sujeito ao regime de substituição tributária, na condição de contribuinte substituto', 'Classificam-se neste código as vendas de produtos industrializados no estabelecimento em operações com produtos sujeitos ao regime de substituição tributária, na condição de contribuinte substituto. Também serão classificadas neste código as vendas de produtos industrializados por estabelecimento industrial de cooperativa sujeitos ao regime de substituição tributária, na condição de contribuinte substituto.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (323, 5402, 'Venda de produção do estabelecimento de produto sujeito ao regime de substituição tributária, em operação entre contribuintes substitutos do mesmo produto', 'Classificam-se neste código as vendas de produtos sujeitos ao regime de substituição tributária industrializados no estabelecimento, em operações entre contribuintes substitutos do mesmo produto')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (324, 5403, 'Venda de mercadoria, adquirida ou recebida de terceiros, sujeita ao regime de substituição tributária, na condição de contribuinte-substituto', 'Venda de mercadoria, adquirida ou recebida de terceiros, sujeita ao regime de substituição tributária, na condição de contribuinte-substituto.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (325, 5405, 'Venda de mercadoria, adquirida ou recebida de terceiros, sujeita ao regime de substituição tributária, na condição de contribuinte-substituído', 'Venda de mercadoria, adquirida ou recebida de terceiros, sujeita ao regime de substituição tributária, na condição de contribuinte-substituído.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (326, 5408, 'Transferência de produção do estabelecimento em operação com produto sujeito ao regime de substituição tributária', 'Classificam-se neste código os produtos industrializados no estabelecimento e transferidos para outro estabelecimento da mesma empresa, em operações com produtos sujeitos ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (327, 5409, 'Transferência de mercadoria adquirida ou recebida de terceiros em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as transferências para outro estabelecimento da mesma empresa, de mercadorias adquiridas ou recebidas de terceiros que não tenham sido objeto de qualquer processo industrial no estabelecimento, em operações com mercadorias sujeitas ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (328, 5410, 'Devolução de compra para industrialização em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as devoluções de mercadorias adquiridas para serem utilizadas em processo de industrialização cujas entradas tenham sido classificadas como Compra para industrialização em operação com mercadoria sujeita ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (329, 5411, 'Devolução de compra para comercialização em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as devoluções de mercadorias adquiridas para serem comercializadas, cujas entradas tenham sido classificadas como Compra para comercialização em operação com mercadoria sujeita ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (330, 5412, 'Devolução de bem do ativo imobilizado, em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as devoluções de bens adquiridos para integrar o ativo imobilizado do estabelecimento, cuja entrada tenha sido classificada no código 1.406 - Compra de bem para o ativo imobilizado cuja mercadoria está sujeita ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (331, 5413, 'Devolução de mercadoria destinada ao uso ou consumo, em operação com mercadoria sujeita ao regime de substituição tributária.', 'Classificam-se neste código as devoluções de mercadorias adquiridas para uso ou consumo do estabelecimento, cuja entrada tenha sido classificada no código 1.407 - Compra de mercadoria para uso ou consumo cuja mercadoria está sujeita ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (332, 5414, 'Remessa de produção do estabelecimento para venda fora do estabelecimento em operação com produto sujeito ao regime de substituição tributária', 'Classificam-se neste código as remessas de produtos industrializados pelo estabelecimento para serem vendidos fora do estabelecimento, inclusive por meio de veículos, em operações com produtos sujeitos ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (333, 5415, 'Remessa de mercadoria adquirida ou recebida de terceiros para venda fora do estabelecimento, em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as remessas de mercadorias adquiridas ou recebidas de terceiros para serem vendidas fora do estabelecimento, inclusive por meio de veículos, em operações com mercadorias sujeitas ao regime de substituição tributária.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (334, 5450, 'SISTEMAS DE INTEGRAÇÃO', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (335, 5451, 'Remessa de animal e de insumo para estabelecimento produtor', 'Classificam-se neste código as saídas referentes à remessa de animais e de insumos para criação de animais no sistema integrado, tais como: pintos, leitões, rações e medicamentos.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (336, 5500, 'REMESSAS COM FIM ESPECÍFICO DE EXPORTAÇÃO E EVENTUAIS DEVOLUÇÕES', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (337, 5501, 'Remessa de produção do estabelecimento, com fim específico de exportação', 'Classificam-se neste código as saídas de produtos industrializados pelo estabelecimento, remetidos com fim específico de exportação a trading company, empresa comercial exportadora ou outro estabelecimento do remetente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (338, 5502, 'Remessa de mercadoria adquirida ou recebida de terceiros, com fim específico de exportação', 'Classificam-se neste código as saídas de mercadorias adquiridas ou recebidas de terceiros, remetidas com fim específico de exportação a trading company, empresa comercial exportadora ou outro estabelecimento do remetente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (339, 5503, 'Devolução de mercadoria recebida com fim específico de exportação', 'Classificam-se neste código as devoluções efetuadas por trading company, empresa comercial exportadora ou outro estabelecimento do destinatário, de mercadorias recebidas com fim específico de exportação, cujas entradas tenham sido classificadas no código 1.501 - Entrada de mercadoria recebida com fim específico de exportação.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (340, 5550, 'OPERAÇÕES COM BENS DE ATIVO IMOBILIZADO E MATERIAIS PARA USO OU CONSUMO', NULL)");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (341, 5551, 'Venda de bem do ativo imobilizado', 'Classificam-se neste código as vendas de bens integrantes do ativo imobilizado do estabelecimento.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (342, 5552, 'Transferência de bem do ativo imobilizado', 'Classificam-se neste código os bens do ativo imobilizado transferidos para outro estabelecimento da mesma empresa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (343, 5553, 'Devolução de compra de bem para o ativo imobilizado', 'Classificam-se neste código as devoluções de bens adquiridos para integrar o ativo imobilizado do estabelecimento, cuja entrada foi classificada no código 1.551 - Compra de bem para o ativo imobilizado.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (344, 5554, 'Remessa de bem do ativo imobilizado para uso fora do estabelecimento', 'Classificam-se neste código as remessas de bens do ativo imobilizado para uso fora do estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (345, 5555, 'Devolução de bem do ativo imobilizado de terceiro, recebido para uso no estabelecimento', 'Classificam-se neste código as saídas em devolução, de bens do ativo imobilizado de terceiros, recebidos para uso no estabelecimento, cuja entrada tenha sido classificada no código 1.555 - Entrada de bem do ativo imobilizado de terceiro, remetido para uso no estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (346, 5556, 'Devolução de compra de material de uso ou consumo', 'Classificam-se neste código as devoluções de mercadorias destinadas ao uso ou consumo do estabelecimento, cuja entrada tenha sido classificada no código 1.556 - Compra de material para uso ou consumo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (347, 5557, 'Transferência de material de uso ou consumo', 'Classificam-se neste código os materiais para uso ou consumo transferidos para outro estabelecimento da mesma empresa.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (348, 5600, 'CRÉDITOS E RESSARCIMENTOS DE ICMS', NULL)");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (349, 5601, 'Transferência de crédito de ICMS acumulado', 'Classificam-se neste código os lançamentos destinados ao registro da transferência de créditos de ICMS para outras empresas.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (350, 5602, 'Transferência de saldo credor de ICMS para outro estabelecimento da mesma empresa, destinado à compensação de saldo devedor de ICMS', 'Classificam-se neste código os lançamentos destinados ao registro da transferência de saldos credores de ICMS para outros estabelecimentos da mesma empresa, destinados à compensação do saldo devedor desses estabelecimentos.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (351, 5603, 'Ressarcimento de ICMS retido por substituição tributária', 'Classificam-se neste código os lançamentos destinados ao registro de ressarcimento de ICMS retido por substituição tributária a contribuinte substituído, efetuado pelo contribuinte substituto, nas hipóteses previstas na legislação aplicável.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (352, 5605, 'Transferência de saldo devedor de ICMS de outro estabelecimento da mesma empresa. (ajuste sinief 03/04)', 'Classificam-se neste código os lançamentos destinados ao registro da transferência de saldo devedor de ICMS para outro estabelecimento da mesma empresa, para efetivação da apuração centralizada do imposto.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (353, 5900, 'OUTRAS SAÍDAS DE MERCADORIAS OU PRESTAÇÕES DE SERVIÇOS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (354, 5901, 'Remessa para industrialização por encomenda', 'Classificam-se neste código as remessas de insumos remetidos para industrialização por encomenda, a ser realizada em outra empresa ou em outro estabelecimento da mesma empresa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (355, 5902, 'Retorno de mercadoria utilizada na industrialização por encomenda', 'Classificam-se neste código as remessas, pelo estabelecimento industrializador, dos insumos recebidos para industrialização e incorporados ao produto final, por encomenda de outra empresa ou de outro estabelecimento da mesma empresa. O valor dos insumos nesta operação deverá ser igual ao valor dos insumos recebidos para industrialização.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (356, 5903, 'Retorno de mercadoria recebida para industrialização e não aplicada no referido processo', 'Classificam-se neste código as remessas em devolução de insumos recebidos para industrialização e não aplicados no referido processo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (357, 5904, 'Remessa para venda fora do estabelecimento', 'Classificam-se neste código as remessas de mercadorias para venda fora do estabelecimento, inclusive por meio de veículos.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (358, 5905, 'Remessa para depósito fechado ou armazém geral', 'Classificam-se neste código as remessas de mercadorias para depósito em depósito fechado ou armazém geral.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (359, 5906, 'Retorno de mercadoria depositada em depósito fechado ou armazém geral', 'Classificam-se neste código os retornos de mercadorias depositadas em depósito fechado ou armazém geral ao estabelecimento depositante.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (360, 5907, 'Retorno simbólico de mercadoria depositada em depósito fechado ou armazém geral', 'Classificam-se neste código os retornos simbólicos de mercadorias recebidas para depósito em depósito fechado ou armazém geral, quando as mercadorias depositadas tenham sido objeto de saída a qualquer título e que não devam retornar ao estabelecimento depositante.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (361, 5908, 'Remessa de bem por conta de contrato de comodato', 'Classificam-se neste código as remessas de bens para o cumprimento de contrato de comodato.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (362, 5909, 'Retorno de bem recebido por conta de contrato de comodato', 'Classificam-se neste código as remessas de bens em devolução após cumprido o contrato de comodato.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (363, 5910, 'Remessa em bonificação, doação ou brinde', 'Classificam-se neste código as remessas de mercadorias a título de bonificação, doação ou brinde.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (364, 5911, 'Remessa de amostra grátis', 'Classificam-se neste código as remessas de mercadorias a título de amostra grátis.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (365, 5912, 'Remessa de mercadoria ou bem para demonstração', 'Classificam-se neste código as remessas de mercadorias ou bens para demonstração.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (366, 5913, 'Retorno de mercadoria ou bem recebido para demonstração', 'Classificam-se neste código as remessas em devolução de mercadorias ou bens recebidos para demonstração.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (367, 5914, 'Remessa de mercadoria ou bem para exposição ou feira', 'Classificam-se neste código as remessas de mercadorias ou bens para exposição ou feira.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (368, 5915, 'Remessa de mercadoria ou bem para conserto ou reparo', 'Classificam-se neste código as remessas de mercadorias ou bens para conserto ou reparo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (369, 5916, 'Retorno de mercadoria ou bem recebido para conserto ou reparo', 'Classificam-se neste código as remessas em devolução de mercadorias ou bens recebidos para conserto ou reparo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (370, 5917, 'Remessa de mercadoria em consignação mercantil ou industrial', 'Classificam-se neste código as remessas de mercadorias a título de consignação mercantil ou industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (371, 5918, 'Devolução de mercadoria recebida em consignação mercantil ou industrial', 'Classificam-se neste código as devoluções de mercadorias recebidas anteriormente a título de consignação mercantil ou industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (372, 5919, 'Devolução simbólica de mercadoria vendida ou utilizada em processo industrial, recebida anteriormente em consignação mercantil ou industrial', 'Classificam-se neste código as devoluções simbólicas de mercadorias vendidas ou utilizadas em processo industrial, que tenham sido recebidas anteriormente a título de consignação mercantil ou industrial.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (373, 5920, 'Remessa de vasilhame ou sacaria', 'Classificam-se neste código as remessas de vasilhame ou sacaria.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (374, 5921, 'Devolução de vasilhame ou sacaria', 'Classificam-se neste código as saídas por devolução de vasilhame ou sacaria.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (375, 5922, 'Lançamento efetuado a título de simples faturamento decorrente de venda para entrega futura', 'Classificam-se neste código os registros efetuados a título de simples faturamento decorrente de venda para entrega futura.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (376, 5923, 'Remessa de mercadoria por conta e ordem de terceiros, em venda à ordem', 'Classificam-se neste código as saídas correspondentes à entrega de mercadorias por conta e ordem de terceiros, em vendas à ordem, cuja venda ao adquirente originário, foi classificada nos códigos 5.118 - Venda de produção do estabelecimento entregue ao destinatário por conta e ordem do adquirente originário, em venda à ordem ou 5.119')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (377, 5924, 'Remessa para industrialização por conta e ordem do adquirente da mercadoria, quando esta não transitar pelo estabelecimento do adquirente', 'Classificam-se neste código as saídas de insumos com destino a estabelecimento industrializador, para serem industrializados por conta e ordem do adquirente, nas hipóteses em que os insumos não tenham transitado pelo estabelecimento do adquirente dos mesmos.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (378, 5925, 'Retorno de mercadoria recebida para industrialização por conta e ordem do adquirente da mercadoria, quando aquela não transitar pelo estabelecimento do adquirente', 'Classificam-se neste código as remessas, pelo estabelecimento industrializador, dos insumos recebidos, por conta e ordem do adquirente, para industrialização e incorporados ao produto final, nas hipóteses em que os insumos não tenham transitado pelo estabelecimento do adquirente. O valor dos insumos nesta operação deverá ser igual ao valor dos insumos recebidos para industrialização.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (379, 5926, 'Lançamento efetuado a título de reclassificação de mercadoria decorrente de formação de kit ou de sua desagregação', 'Classificam-se neste código os registros efetuados a título de reclassificação decorrente de formação de kit de mercadorias ou de sua desagregação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (380, 5927, 'Lançamento efetuado a título de baixa de estoque decorrente de perda, roubo ou deterioração', 'Classificam-se neste código os registros efetuados a título de baixa de estoque decorrente de perda, roubou ou deterioração das mercadorias.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (381, 5928, 'Lançamento efetuado a título de baixa de estoque decorrente do encerramento da atividade da empresa', 'Classificam-se neste código os registros efetuados a título de baixa de estoque decorrente do encerramento das atividades da empresa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (382, 5929, 'Lançamento efetuado em decorrência de emissão de documento fiscal relativo a operação ou prestação também registrada em equipamento Emissor de Cupom Fiscal - ECF', 'Classificam-se neste código os registros relativos aos documentos fiscais emitidos em operações ou prestações que também tenham sido registradas em equipamento Emissor de Cupom Fiscal - ECF.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (383, 5931, 'Lançamento efetuado em decorrência da responsabilidade de retenção do imposto por substituição tributária, atribuída ao remetente ou alienante da mercadoria, pelo serviço de transporte realizado por transportador autônomo ou por transportador não inscrito na unidade da Federação onde iniciado o serviço', 'Classificam-se neste código exclusivamente os lançamentos efetuados pelo remetente ou alienante da mercadoria quando lhe for atribuída a responsabilidade pelo recolhimento do imposto devido pelo serviço de transporte realizado por transportador autônomo ou por transportador não inscrito na unidade da Federação onde iniciado o serviço.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (384, 5932, 'Prestação de serviço de transporte iniciada em unidade da Federação diversa daquela onde inscrito o prestador', 'Classificam-se neste código as prestações de serviço de transporte que tenham sido iniciadas em unidade da Federação diversa daquela onde o prestador está inscrito como contribuinte.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (385, 5933, 'Prestação de serviço tributado pelo ISSQN. (ajuste sinief 03/04)', 'Classificam-se neste código as prestações de serviços, de competência municipal, desde que informados em documentos autorizados pelo Estado.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (386, 5949, 'Outra saída de mercadoria ou prestação de serviço não especificado', 'Classificam-se neste código as outras saídas de mercadorias ou prestações de serviços que não tenham sido especificados nos códigos anteriores.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (387, 6000, 'SAÍDAS OU PRESTAÇÕES DE SERVIÇOS PARA OUTROS ESTADOS', 'Classificam-se, neste grupo, as operações ou prestações em que o estabelecimento remetente esteja localizado em unidade da Federação diversa daquela do destinatário')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (388, 6100, 'VENDAS DE PRODUÇÃO PRÓPRIA OU DE TERCEIROS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (389, 6101, 'Venda de produção do estabelecimento', 'Classificam-se neste código as vendas de produtos industrializados no estabelecimento. Também serão classificadas neste código as vendas de mercadorias por estabelecimento industrial de cooperativa destinadas a seus cooperados ou a estabelecimento de outra cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (390, 6102, 'Venda de mercadoria adquirida ou recebida de terceiros', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros para industrialização ou comercialização, que não tenham sido objeto de qualquer processo industrial no estabelecimento. Também serão classificadas neste código as vendas de mercadorias por estabelecimento comercial de cooperativa destinadas a seus cooperados ou estabelecimento de outra cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (391, 6103, 'Venda de produção do estabelecimento, efetuada fora do estabelecimento', 'Classificam-se neste código as vendas efetuadas fora do estabelecimento, inclusive por meio de veículo, de produtos industrializados no estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (392, 6104, 'Venda de mercadoria adquirida ou recebida de terceiros, efetuada fora do estabelecimento', 'Classificam-se neste código as vendas efetuadas fora do estabelecimento, inclusive por meio de veículo, de mercadorias adquiridas ou recebidas de terceiros para industrialização ou comercialização, que não tenham sido objeto de qualquer processo industrial no estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (393, 6105, 'Venda de produção do estabelecimento que não deva por ele transitar', 'Classificam-se neste código as vendas de produtos industrializados no estabelecimento, armazenados em depósito fechado, armazém geral ou outro sem que haja retorno ao estabelecimento depositante.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (394, 6106, 'Venda de mercadoria adquirida ou recebida de terceiros, que não deva por ele transitar', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros para industrialização ou comercialização, armazenadas em depósito fechado, armazém geral ou outro, que não tenham sido objeto de qualquer processo industrial no estabelecimento sem que haja retorno ao estabelecimento depositante. Também serão classificadas neste código as vendas de mercadorias importadas, cuja saída ocorra do recinto alfandegado ou da repartição alfandegária onde se processou o desembaraço aduaneiro, com destino ao estabelecimento do comprador, sem transitar pelo estabelecimento do importador.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (395, 6107, 'Venda de produção do estabelecimento, destinada a não contribuinte', 'Classificam-se neste código as vendas de produtos industrializados no estabelecimento, destinadas a não contribuintes. Quaisquer operações de venda destinadas a não contribuintes deverão ser classificadas neste código.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (396, 6108, 'Venda de mercadoria adquirida ou recebida de terceiros, destinada a não contribuinte', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros para industrialização ou comercialização, que não tenham sido objeto de qualquer processo industrial no estabelecimento, destinadas a não contribuintes. Quaisquer operações de venda destinadas a não contribuintes deverão ser classificadas neste código.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (397, 6109, 'Venda de produção do estabelecimento, destinada à Zona Franca de Manaus ou Áreas de Livre Comércio', 'Classificam-se neste código as vendas de produtos industrializados pelo estabelecimento, destinados à Zona Franca de Manaus ou Áreas de Livre Comércio.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (398, 6110, 'Venda de mercadoria adquirida ou recebida de terceiros, destinada à Zona Franca de Manaus ou Áreas de Livre Comércio', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, destinadas à Zona Franca de Manaus ou Áreas de Livre Comércio.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (399, 6111, 'Venda de produção do estabelecimento remetida anteriormente em consignação industrial', 'Classificam-se neste código as vendas efetivas de produtos industrializados no estabelecimento remetidos anteriormente a título de consignação industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (400, 6112, 'Venda de mercadoria adquirida ou recebida de Terceiros remetida anteriormente em consignação industrial', 'Classificam-se neste código as vendas efetivas de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, remetidas anteriormente a título de consignação industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (401, 6113, 'Venda de produção do estabelecimento remetida anteriormente em consignação mercantil', 'Classificam-se neste código as vendas efetivas de produtos industrializados no estabelecimento remetidos anteriormente a título de consignação mercantil.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (402, 6114, 'Venda de mercadoria adquirida ou recebida de terceiros remetida anteriormente em consignação mercantil', 'Classificam-se neste código as vendas efetivas de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, remetidas anteriormente a título de consignação mercantil.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (403, 6115, 'Venda de mercadoria adquirida ou recebida de terceiros, recebida anteriormente em consignação mercantil', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros, recebidas anteriormente a título de consignação mercantil.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (404, 6116, 'Venda de produção do estabelecimento originada de encomenda para entrega futura', 'Classificam-se neste código as vendas de produtos industrializados pelo estabelecimento, quando da saída real do produto, cujo faturamento tenha sido classificado no código 6.922 - Lançamento efetuado a título de simples faturamento decorrente de venda para entrega futura.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (405, 6117, 'Venda de mercadoria adquirida ou recebida de terceiros, originada de encomenda para entrega futura', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, quando da saída real da mercadoria, cujo faturamento tenha sido classificado no código 6.922 - Lançamento efetuado a título de simples faturamento decorrente de venda para entrega futura.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (406, 6118, 'Venda de produção do estabelecimento entregue ao destinatário por conta e ordem do adquirente originário, em venda à ordem', 'Classificam-se neste código as vendas à ordem de produtos industrializados pelo estabelecimento, entregues ao destinatário por conta e ordem do adquirente originário.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (407, 6119, 'Venda de mercadoria adquirida ou recebida de terceiros entregue ao destinatário por conta e ordem do adquirente originário, em venda à ordem', 'Classificam-se neste código as vendas à ordem de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, entregues ao destinatário por conta e ordem do adquirente originário.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (408, 6120, 'Venda de mercadoria adquirida ou recebida de terceiros entregue ao destinatário pelo vendedor remetente, em venda à ordem', 'Classificam-se neste código as vendas à ordem de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, entregues pelo vendedor remetente ao destinatário, cuja compra seja classificada, pelo adquirente originário, no código 2.118 - Compra de mercadoria pelo adquirente originário, entregue pelo vendedor remetente ao destinatário, em venda à ordem.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (409, 6122, 'Venda de produção do estabelecimento remetida para industrialização, por conta e ordem do adquirente, sem transitar pelo estabelecimento do adquirente', 'Classificam-se neste código as vendas de produtos industrializados no estabelecimento, remetidos para serem industrializados em outro estabelecimento, por conta e ordem do adquirente, sem que os produtos tenham transitado pelo estabelecimento do adquirente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (410, 6123, 'Venda de mercadoria adquirida ou recebida de terceiros remetida para industrialização, por conta e ordem do adquirente, sem transitar pelo estabelecimento do adquirente', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros, que não tenham sido objeto de qualquer processo industrial no estabelecimento, remetidas para serem industrializadas em outro estabelecimento, por conta e ordem do adquirente, sem que as mercadorias tenham transitado pelo estabelecimento do adquirente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (411, 6124, 'Industrialização efetuada para outra empresa', 'Classificam-se neste código as saídas de mercadorias industrializadas para terceiros, compreendendo os valores referentes aos serviços prestados e os das mercadorias de propriedade do industrializador empregadas no processo industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (412, 6125, 'Industrialização efetuada para outra empresa quando a mercadoria recebida para utilização no processo de industrialização não transitar pelo estabelecimento adquirente da mercadoria', 'Classificam-se neste código as saídas de mercadorias industrializadas para outras empresas, em que as mercadorias recebidas para utilização no processo de industrialização não tenham transitado pelo estabelecimento do adquirente das mercadorias, compreendendo os valores referentes aos serviços prestados e os das mercadorias de propriedade do industrializador empregadas no processo industrial.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (413, 6150, 'TRANSFERÊNCIAS DE PRODUÇÃO PRÓPRIA OU DE TERCEIROS', NULL)");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (414, 6151, 'Transferência de produção do estabelecimento', 'Classificam-se neste código os produtos industrializados no estabelecimento e transferidos para outro estabelecimento da mesma empresa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (415, 6152, 'Transferência de mercadoria adquirida ou recebida de terceiros', 'Classificam-se neste código as mercadorias adquiridas ou recebidas de terceiros para industrialização ou comercialização e que não tenham sido objeto de qualquer processo industrial no estabelecimento, transferidas para outro estabelecimento da mesma empresa.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (416, 6153, 'Transferência de energia elétrica', 'Classificam-se neste código as transferências de energia elétrica para outro estabelecimento da mesma empresa, para distribuição.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (417, 6155, 'Transferência de produção do estabelecimento, que não deva por ele transitar', 'Classificam-se neste código as transferências para outro estabelecimento da mesma empresa, de produtos industrializados no estabelecimento que tenham sido remetidos para armazém geral, depósito fechado ou outro, sem que haja retorno ao estabelecimento depositante.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (418, 6156, 'Transferência de mercadoria adquirida ou recebida de terceiros, que não deva por ele transitar', 'Classificam-se neste código as transferências para outro estabelecimento da mesma empresa, de mercadorias adquiridas ou recebidas de terceiros para industrialização ou comercialização, que não tenham sido objeto de qualquer processo industrial, remetidas para armazém geral, depósito fechado ou outro, sem que haja retorno ao estabelecimento depositante.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (419, 6200, 'DEVOLUÇÕES DE COMPRAS PARA INDUSTRIALIZAÇÃO, COMERCIALIZAÇÃO OU ANULAÇÕES DE VALORES', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (420, 6201, 'Devolução de compra para industrialização', 'Classificam-se neste código as devoluções de mercadorias adquiridas para serem utilizadas em processo de industrialização, cujas entradas tenham sido classificadas como Compra para industrialização.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (421, 6202, 'Devolução de compra para comercialização', 'Classificam-se neste código as devoluções de mercadorias adquiridas para serem comercializadas, cujas entradas tenham sido classificadas como Compra para comercialização.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (422, 6205, 'Anulação de valor relativo a aquisição de serviço de comunicação', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes das aquisições de serviços de comunicação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (423, 6206, 'Anulação de valor relativo a aquisição de serviço de transporte', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes das aquisições de serviços de transporte.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (424, 6207, 'Anulação de valor relativo à compra de energia elétrica', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes da compra de energia elétrica.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (425, 6208, 'Devolução de mercadoria recebida em transferência para industrialização', 'Classificam-se neste código as devoluções de mercadorias recebidas em transferência de outros estabelecimentos da mesma empresa, para serem utilizadas em processo de industrialização.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (426, 6209, 'Devolução de mercadoria recebida em transferência para comercialização', 'Classificam-se neste código as devoluções de mercadorias recebidas em transferência de outro estabelecimento da mesma empresa, para serem comercializadas.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (427, 6210, 'Devolução de compra para utilização na prestação de serviço', 'Classificam-se neste código as devoluções de mercadorias adquiridas para utilização na prestação de serviços, cujas entradas tenham sido classificadas no código 2.126 - Compra para utilização na prestação de serviço.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (428, 6250, 'VENDAS DE ENERGIA ELÉTRICA', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (429, 6251, 'Venda de energia elétrica para distribuição ou comercialização', 'Classificam-se neste código as vendas de energia elétrica destinada à distribuição ou comercialização. Também serão classificadas neste código as vendas de energia elétrica destinada a cooperativas para distribuição aos seus cooperados.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (430, 6252, 'Venda de energia elétrica para estabelecimento industrial', 'Classificam-se neste código as vendas de energia elétrica para consumo por estabelecimento industrial. Também serão classificadas neste código as vendas de energia elétrica destinada a estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (431, 6253, 'Venda de energia elétrica para estabelecimento comercial', 'Classificam-se neste código as vendas de energia elétrica para consumo por estabelecimento comercial. Também serão classificadas neste código as vendas de energia elétrica destinada a estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (432, 6254, 'Venda de energia elétrica para estabelecimento prestador de serviço de transporte', 'Classificam-se neste código as vendas de energia elétrica para consumo por estabelecimento de prestador de serviços de transporte.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (433, 6255, 'Venda de energia elétrica para estabelecimento prestador de serviço de comunicação', 'Classificam-se neste código as vendas de energia elétrica para consumo por estabelecimento de prestador de serviços de comunicação.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (434, 6256, 'Venda de energia elétrica para estabelecimento de produtor rural', 'Classificam-se neste código as vendas de energia elétrica para consumo por estabelecimento de produtor rural.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (435, 6257, 'Venda de energia elétrica para consumo por demanda contratada', 'Classificam-se neste código as vendas de energia elétrica para consumo por demanda contratada, que prevalecerá sobre os demais códigos deste subgrupo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (436, 6258, 'Venda de energia elétrica a não contribuinte', 'Classificam-se neste código as vendas de energia elétrica a pessoas físicas ou a pessoas jurídicas não indicadas nos códigos anteriores.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (437, 6300, 'PRESTAÇÕES DE SERVIÇOS DE COMUNICAÇÃO', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (438, 6301, 'Prestação de serviço de comunicação para execução de serviço da mesma natureza', 'Classificam-se neste código as prestações de serviços de comunicação destinados às prestações de serviços da mesma natureza.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (439, 6302, 'Prestação de serviço de comunicação a estabelecimento industrial', 'Classificam-se neste código as prestações de serviços de comunicação a estabelecimento industrial. Também serão classificados neste código os serviços de comunicação prestados a estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (440, 6303, 'Prestação de serviço de comunicação a estabelecimento comercial', 'Classificam-se neste código as prestações de serviços de comunicação a estabelecimento comercial. Também serão classificados neste código os serviços de comunicação prestados a estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (441, 6304, 'Prestação de serviço de comunicação a estabelecimento de prestador de serviço de transporte', 'Classificam-se neste código as prestações de serviços de comunicação a estabelecimento prestador de serviço de transporte.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (442, 6305, 'Prestação de serviço de comunicação a estabelecimento de geradora ou de distribuidora de energia elétrica', 'Classificam-se neste código as prestações de serviços de comunicação a estabelecimento de geradora ou de distribuidora de energia elétrica.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (443, 6306, 'Prestação de serviço de comunicação a estabelecimento de produtor rural', 'Classificam-se neste código as prestações de serviços de comunicação a estabelecimento de produtor rural.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (444, 6307, 'Prestação de serviço de comunicação a não contribuinte', 'Classificam-se neste código as prestações de serviços de comunicação a pessoas físicas ou a pessoas jurídicas não indicadas nos códigos anteriores.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (445, 6350, 'PRESTAÇÕES DE SERVIÇOS DE TRANSPORTE', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (446, 6351, 'Prestação de serviço de transporte para execução de serviço da mesma natureza', 'Classificam-se neste código as prestações de serviços de transporte destinados às prestações de serviços da mesma natureza.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (447, 6352, 'Prestação de serviço de transporte a estabelecimento industrial', 'Classificam-se neste código as prestações de serviços de transporte a estabelecimento industrial. Também serão classificados neste código os serviços de transporte prestados a estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (448, 6353, 'Prestação de serviço de transporte a estabelecimento comercial', 'Classificam-se neste código as prestações de serviços de transporte a estabelecimento comercial. Também serão classificados neste código os serviços de transporte prestados a estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (449, 6354, 'Prestação de serviço de transporte a estabelecimento de prestador de serviço de comunicação', 'Classificam-se neste código as prestações de serviços de transporte a estabelecimento prestador de serviços de comunicação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (450, 6355, 'Prestação de serviço de transporte a estabelecimento de geradora ou de distribuidora de energia elétrica', 'Classificam-se neste código as prestações de serviços de transporte a estabelecimento de geradora ou de distribuidora de energia elétrica.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (451, 6356, 'Prestação de serviço de transporte a estabelecimento de produtor rural', 'Classificam-se neste código as prestações de serviços de transporte a estabelecimento de produtor rural.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (452, 6357, 'Prestação de serviço de transporte a não contribuinte', 'Classificam-se neste código as prestações de serviços de transporte a pessoas físicas ou a pessoas jurídicas não indicadas nos códigos anteriores.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (453, 6359, 'Prestação de serviço de transporte a contribuinte ou a não contribuinte quando a mercadoria transportada está dispensada de emissão de nota fiscal. (ajuste sinief 03/04)', 'Classificam-se neste código as prestações de serviços de transporte a contribuintes ou a não contribuintes, exclusivamente quando não existe a obrigação legal de emissão de nota fiscal para a mercadoria transportada.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (454, 6400, 'SAÍDAS DE MERCADORIAS SUJEITAS AO REGIME DE SUBSTITUIÇÃO TRIBUTÁRIA', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (455, 6401, 'Venda de produção do estabelecimento em operação com produto sujeito ao regime de substituição tributária, na condição de contribuinte substituto', 'Classificam-se neste código as vendas de produtos industrializados no estabelecimento em operações com produtos sujeitos ao regime de substituição tributária, na condição de contribuinte substituto. Também serão classificadas neste código as vendas de produtos industrializados por estabelecimento industrial de cooperativa sujeitos ao regime de substituição tributária, na condição de contribuinte substituto.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (456, 6402, 'Venda de produção do estabelecimento de produto sujeito ao regime de substituição tributária, em operação entre contribuintes substitutos do mesmo produto', 'Classificam-se neste código as vendas de produtos sujeitos ao regime de substituição tributária industrializados no estabelecimento, em operações entre contribuintes substitutos do mesmo produto.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (457, 6403, 'Venda de mercadoria adquirida ou recebida de terceiros em operação com mercadoria sujeita ao regime de substituição tributária, na condição de contribuinte substituto', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros, na condição de contribuinte substituto, em operação com mercadorias sujeitas ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (458, 6404, 'Venda de mercadoria sujeita ao regime de substituição tributária, cujo imposto já tenha sido retido anteriormente', 'Classificam-se neste código as vendas de mercadorias sujeitas ao regime de substituição tributária, na condição de substituto tributário, exclusivamente nas hipóteses em que o imposto já tenha sido retido anteriormente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (459, 6408, 'Transferência de produção do estabelecimento em operação com produto sujeito ao regime de substituição tributária', 'Classificam-se neste código os produtos industrializados no estabelecimento e transferidos para outro estabelecimento da mesma empresa, em operações com produtos sujeitos ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (460, 6409, 'Transferência de mercadoria adquirida ou recebida de terceiros em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as transferências para outro estabelecimento da mesma empresa, de mercadorias adquiridas ou recebidas de terceiros que não tenham sido objeto de qualquer processo industrial no estabelecimento, em operações com mercadorias sujeitas ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (461, 6410, 'Devolução de compra para industrialização em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as devoluções de mercadorias adquiridas para serem utilizadas em processo de industrialização cujas entradas tenham sido classificadas como Compra para industrialização em operação com mercadoria sujeita ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (462, 6411, 'Devolução de compra para comercialização em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as devoluções de mercadorias adquiridas para serem comercializadas, cujas entradas tenham sido classificadas como Compra para comercialização em operação com mercadoria sujeita ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (463, 6412, 'Devolução de bem do ativo imobilizado, em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as devoluções de bens adquiridos para integrar o ativo imobilizado do estabelecimento, cuja entrada tenha sido classificada no código 2.406 - Compra de bem para o ativo imobilizado cuja mercadoria está sujeita ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (464, 6413, 'Devolução de mercadoria destinada ao uso ou consumo, em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as devoluções de mercadorias adquiridas para uso ou consumo do estabelecimento, cuja entrada tenha sido classificada no código 2.407 - Compra de mercadoria para uso ou consumo cuja mercadoria está sujeita ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (465, 6414, 'Remessa de produção do estabelecimento para venda fora do estabelecimento em operação com produto sujeito ao regime de substituição tributária', 'Classificam-se neste código as remessas de produtos industrializados pelo estabelecimento para serem vendidos fora do estabelecimento, inclusive por meio de veículos, em operações com produtos sujeitos ao regime de substituição tributária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (466, 6415, 'Remessa de mercadoria adquirida ou recebida de terceiros para venda fora do estabelecimento, em operação com mercadoria sujeita ao regime de substituição tributária', 'Classificam-se neste código as remessas de mercadorias adquiridas ou recebidas de terceiros para serem vendidas fora do estabelecimento, inclusive por meio de veículos, em operações com mercadorias sujeitas ao regime de substituição tributária.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (467, 6500, 'REMESSAS COM FIM ESPECÍFICO DE EXPORTAÇÃO E EVENTUAIS DEVOLUÇÕES', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (468, 6501, 'Remessa de produção do estabelecimento, com fim específico de exportação', 'Classificam-se neste código as saídas de produtos industrializados pelo estabelecimento, remetidos com fim específico de exportação a trading company, empresa comercial exportadora ou outro estabelecimento do remetente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (469, 6502, 'Remessa de mercadoria adquirida ou recebida de terceiros, com fim específico de exportação', 'Classificam-se neste código as saídas de mercadorias adquiridas ou recebidas de terceiros, remetidas com fim específico de exportação a trading company, empresa comercial exportadora ou outro estabelecimento do remetente.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (470, 6503, 'Devolução de mercadoria recebida com fim específico de exportação', 'Classificam-se neste código as devoluções efetuadas por trading company, empresa comercial exportadora ou outro estabelecimento do destinatário, de mercadorias recebidas com fim específico de exportação, cujas entradas tenham sido classificadas no código 2.501 - Entrada de mercadoria recebida com fim específico de exportação.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (471, 6550, 'OPERAÇÕES COM BENS DE ATIVO IMOBILIZADO E MATERIAIS PARA USO OU CONSUMO', NULL)");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (472, 6551, 'Venda de bem do ativo imobilizado', 'Classificam-se neste código as vendas de bens integrantes do ativo imobilizado do estabelecimento.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (473, 6552, 'Transferência de bem do ativo imobilizado', 'Classificam-se neste código os bens do ativo imobilizado transferidos para outro estabelecimento da mesma empresa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (474, 6553, 'Devolução de compra de bem para o ativo imobilizado', 'Classificam-se neste código as devoluções de bens adquiridos para integrar o ativo imobilizado do estabelecimento, cuja entrada foi classificada no código 2.551 - Compra de bem para o ativo imobilizado.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (475, 6554, 'Remessa de bem do ativo imobilizado para uso fora do estabelecimento', 'Classificam-se neste código as remessas de bens do ativo imobilizado para uso fora do estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (476, 6555, 'Devolução de bem do ativo imobilizado de terceiro, recebido para uso no estabelecimento', 'Classificam-se neste código as saídas em devolução, de bens do ativo imobilizado de terceiros, recebidos para uso no estabelecimento, cuja entrada tenha sido classificada no código 2.555 - Entrada de bem do ativo imobilizado de terceiro, remetido para uso no estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (477, 6556, 'Devolução de compra de material de uso ou consumo', 'Classificam-se neste código as devoluções de mercadorias destinadas ao uso ou consumo do estabelecimento, cuja entrada tenha sido classificada no código 2.556')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (478, 6557, 'Transferência de material de uso ou consumo', 'Classificam-se neste código os materiais de uso ou consumo transferidos para outro estabelecimento da mesma empresa.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (479, 6600, 'CRÉDITOS E RESSARCIMENTOS DE ICMS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (480, 6603, 'Ressarcimento de ICMS retido por substituição tributária', 'Classificam-se neste código os lançamentos destinados ao registro de ressarcimento de ICMS retido por substituição tributária a contribuinte substituído, efetuado pelo contribuinte substituto, nas hipóteses previstas na legislação aplicável.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (481, 6900, 'OUTRAS SAÍDAS DE MERCADORIAS OU PRESTAÇÕES DE SERVIÇOS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (482, 6901, 'Remessa para industrialização por encomenda', 'Classificam-se neste código as remessas de insumos remetidos para industrialização por encomenda, a ser realizada em outra empresa ou em outro estabelecimento da mesma empresa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (483, 6902, 'Retorno de mercadoria utilizada na industrialização por encomenda', 'Classificam-se neste código as remessas, pelo estabelecimento industrializador, dos insumos recebidos para industrialização e incorporados ao produto final, por encomenda de outra empresa ou de outro estabelecimento da mesma empresa. O valor dos insumos nesta operação deverá ser igual ao valor dos insumos recebidos para industrialização.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (484, 6903, 'Retorno de mercadoria recebida para industrialização e não aplicada no referido processo', 'Classificam-se neste código as remessas em devolução de insumos recebidos para industrialização e não aplicados no referido processo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (485, 6904, 'Remessa para venda fora do estabelecimento', 'Classificam-se neste código as remessas de mercadorias para venda fora do estabelecimento, inclusive por meio de veículos.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (486, 6905, 'Remessa para depósito fechado ou armazém geral', 'Classificam-se neste código as remessas de mercadorias para depósito em depósito fechado ou armazém geral.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (487, 6906, 'Retorno de mercadoria depositada em depósito fechado ou armazém geral', 'Classificam-se neste código os retornos de mercadorias depositadas em depósito fechado ou armazém geral ao estabelecimento depositante.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (488, 6907, 'Retorno simbólico de mercadoria depositada em depósito fechado ou armazém geral', 'Classificam-se neste código os retornos simbólicos de mercadorias recebidas para depósito em depósito fechado ou armazém geral, quando as mercadorias depositadas tenham sido objeto de saída a qualquer título e que não devam retornar ao estabelecimento depositante.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (489, 6908, 'Remessa de bem por conta de contrato de comodato', 'Classificam-se neste código as remessas de bens para o cumprimento de contrato de comodato.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (490, 6909, 'Retorno de bem recebido por conta de contrato de comodato', 'Classificam-se neste código as remessas de bens em devolução após cumprido o contrato de comodato.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (491, 6910, 'Remessa em bonificação, doação ou brinde', 'Classificam-se neste código as remessas de mercadorias a título de bonificação, doação ou brinde.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (492, 6911, 'Remessa de amostra grátis', 'Classificam-se neste código as remessas de mercadorias a título de amostra grátis.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (493, 6912, 'Remessa de mercadoria ou bem para demonstração', 'Classificam-se neste código as remessas de mercadorias ou bens para demonstração.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (494, 6913, 'Retorno de mercadoria ou bem recebido para demonstração', 'Classificam-se neste código as remessas em devolução de mercadorias ou bens recebidos para demonstração.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (495, 6914, 'Remessa de mercadoria ou bem para exposição ou feira', 'Classificam-se neste código as remessas de mercadorias ou bens para exposição ou feira.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (496, 6915, 'Remessa de mercadoria ou bem para conserto ou reparo', 'Classificam-se neste código as remessas de mercadorias ou bens para conserto ou reparo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (497, 6916, 'Retorno de mercadoria ou bem recebido para conserto ou reparo', 'Classificam-se neste código as remessas em devolução de mercadorias ou bens recebidos para conserto ou reparo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (498, 6917, 'Remessa de mercadoria em consignação mercantil ou industrial', 'Classificam-se neste código as remessas de mercadorias a título de consignação mercantil ou industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (499, 6918, 'Devolução de mercadoria recebida em consignação mercantil ou industrial', 'Classificam-se neste código as devoluções de mercadorias recebidas anteriormente a título de consignação mercantil ou industrial.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (500, 6919, 'Devolução simbólica de mercadoria vendida ou utilizada em processo industrial, recebida anteriormente em consignação mercantil ou industrial', 'Classificam-se neste código as devoluções simbólicas de mercadorias vendidas ou utilizadas em processo industrial, que tenham sido recebidas anteriormente a título de consignação mercantil ou industrial.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (501, 6920, 'Remessa de vasilhame ou sacaria', 'Classificam-se neste código as remessas de vasilhame ou sacaria.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (502, 6921, 'Devolução de vasilhame ou sacaria', 'Classificam-se neste código as saídas por devolução de vasilhame ou sacaria.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (503, 6922, 'Lançamento efetuado a título de simples faturamento decorrente de venda para entrega futura', 'Classificam-se neste código os registros efetuados a título de simples faturamento decorrente de venda para entrega futura.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (504, 6923, 'Remessa de mercadoria por conta e ordem de terceiros, em venda à ordem', 'Classificam-se neste código as saídas correspondentes à entrega de mercadorias por conta e ordem de terceiros, em vendas à ordem, cuja venda ao adquirente originário, foi classificada nos códigos 6.118 - Venda de produção do estabelecimento entregue ao destinatário por conta e ordem do adquirente originário, em venda à ordem ou 6.119 - Venda de mercadoria adquirida ou recebida de terceiros entregue ao destinatário por conta e ordem do adquirente originário, em venda à ordem.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (505, 6924, 'Remessa para industrialização por conta e ordem do adquirente da mercadoria, quando esta não transitar pelo estabelecimento do adquirente', 'Classificam-se neste código as saídas de insumos com destino a estabelecimento industrializador, para serem industrializados por conta e ordem do adquirente, nas hipóteses em que os insumos não tenham transitado pelo estabelecimento do adquirente dos mesmos.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (506, 6925, 'Retorno de mercadoria recebida para industrialização por conta e ordem do adquirente da mercadoria, quando aquela não transitar pelo estabelecimento do adquirente', 'Classificam-se neste código as remessas, pelo estabelecimento industrializador, dos insumos recebidos, por conta e ordem do adquirente, para industrialização e incorporados ao produto final, nas hipóteses em que os insumos não tenham transitado pelo estabelecimento do adquirente. O valor dos insumos nesta operação deverá ser igual ao valor dos insumos recebidos para industrialização.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (507, 6929, 'Lançamento efetuado em decorrência de emissão de documento fiscal relativo a operação ou prestação também registrada em equipamento Emissor de Cupom Fiscal - ECF', 'Classificam-se neste código os registros relativos aos documentos fiscais emitidos em operações ou prestações que também tenham sido registradas em equipamento Emissor de Cupom Fiscal - ECF.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (508, 6931, 'Lançamento efetuado em decorrência da responsabilidade de retenção do imposto por substituição tributária, atribuída ao remetente ou alienante da mercadoria, pelo serviço de transporte realizado por transportador autônomo ou por transportador não inscrito na unidade da Federação onde iniciado o serviço', 'Classificam-se neste código exclusivamente os lançamentos efetuados pelo remetente ou alienante da mercadoria quando lhe for atribuída a responsabilidade pelo recolhimento do imposto devido pelo serviço de transporte realizado por transportador autônomo ou por transportador não inscrito na unidade da Federação onde iniciado o serviço.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (509, 6932, 'Prestação de serviço de transporte iniciada em unidade da Federação diversa daquela onde inscrito o prestador', 'Classificam-se neste código as prestações de serviço de transporte que tenham sido iniciadas em unidade da Federação diversa daquela onde o prestador está inscrito como contribuinte.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (510, 6933, 'Prestação de serviço tributado pelo ISSQN (ajuste sinief 03/04)', 'Classificam-se neste código as prestações de serviços, de competência municipal, desde que informados em documentos autorizados pelo Estado')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (511, 6949, 'Outra saída de mercadoria ou prestação de serviço não especificado', 'Classificam-se neste código as outras saídas de mercadorias ou prestações de serviços que não tenham sido especificados nos códigos anteriores.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (512, 7000, 'SAÍDAS OU PRESTAÇÕES DE SERVIÇOS PARA O EXTERIOR', 'Classificam-se, neste grupo, as operações ou prestações em que o destinatário esteja localizado em outro país')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (513, 7100, 'VENDAS DE PRODUÇÃO PRÓPRIA OU DE TERCEIROS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (514, 7101, 'Venda de produção do estabelecimento', 'Classificam-se neste código as vendas de produtos industrializados no estabelecimento. Também serão classificadas neste código as vendas de mercadorias por estabelecimento industrial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (515, 7102, 'Venda de mercadoria adquirida ou recebida de terceiros', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros para industrialização ou comercialização, que não tenham sido objeto de qualquer processo industrial no estabelecimento. Também serão classificadas neste código as vendas de mercadorias por estabelecimento comercial de cooperativa.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (516, 7105, 'Venda de produção do estabelecimento, que não deva por ele transitar', 'Classificam-se neste código as vendas de produtos industrializados no estabelecimento, armazenados em depósito fechado, armazém geral ou outro sem que haja retorno ao estabelecimento depositante.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (517, 7106, 'Venda de mercadoria adquirida ou recebida de terceiros, que não deva por ele transitar', 'Classificam-se neste código as vendas de mercadorias adquiridas ou recebidas de terceiros para industrialização ou comercialização, armazenadas em depósito fechado, armazém geral ou outro, que não tenham sido objeto de qualquer processo industrial no estabelecimento sem que haja retorno ao estabelecimento depositante. Também serão classificadas neste código as vendas de mercadorias importadas, cuja saída ocorra do recinto alfandegado ou da repartição alfandegária onde se processou o desembaraço aduaneiro, com destino ao estabelecimento do comprador, sem transitar pelo estabelecimento do importador.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (518, 7127, 'Venda de produção do estabelecimento sob o regime de drawback ', 'Classificam-se neste código as vendas de produtos industrializados no estabelecimento sob o regime de drawback , cujas compras foram classificadas no código 3.127 - Compra para industrialização sob o regime de drawback.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (519, 7200, 'DEVOLUÇÕES DE COMPRAS PARA INDUSTRIALIZAÇÃO, COMERCIALIZAÇÃO OU ANULAÇÕES DE VALORES', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (520, 7201, 'Devolução de compra para industrialização', 'Classificam-se neste código as devoluções de mercadorias adquiridas para serem utilizadas em processo de industrialização, cujas entradas tenham sido classificadas como Compra para industrialização.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (521, 7202, 'Devolução de compra para comercialização', 'Classificam-se neste código as devoluções de mercadorias adquiridas para serem comercializadas, cujas entradas tenham sido classificadas como Compra para comercialização.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (522, 7205, 'Anulação de valor relativo à aquisição de serviço de comunicação', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes das aquisições de serviços de comunicação.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (523, 7206, 'Anulação de valor relativo a aquisição de serviço de transporte', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes das aquisições de serviços de transporte.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (524, 7207, 'Anulação de valor relativo à compra de energia elétrica', 'Classificam-se neste código as anulações correspondentes a valores faturados indevidamente, decorrentes da compra de energia elétrica.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (525, 7210, 'Devolução de compra para utilização na prestação de serviço', 'Classificam-se neste código as devoluções de mercadorias adquiridas para utilização na prestação de serviços, cujas entradas tenham sido classificadas no código 3.126 - Compra para utilização na prestação de serviço.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (526, 7211, 'Devolução de compras para industrialização sob o regime de drawback ', 'Classificam-se neste código as devoluções de mercadorias adquiridas para serem utilizadas em processo de industrialização sob o regime de drawback e não utilizadas no referido processo, cujas entradas tenham sido classificadas no código 3.127 - Compra para industrialização sob o regime de drawback.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (527, 7250, 'VENDAS DE ENERGIA ELÉTRICA', NULL)");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (528, 7251, 'Venda de energia elétrica para o exterior', 'Classificam-se neste código as vendas de energia elétrica para o exterior.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (529, 7300, 'PRESTAÇÕES DE SERVIÇOS DE COMUNICAÇÃO', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (530, 7301, 'Prestação de serviço de comunicação para execução de serviço da mesma natureza', 'Classificam-se neste código as prestações de serviços de comunicação destinados às prestações de serviços da mesma natureza.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (531, 7350, 'PRESTAÇÕES DE SERVIÇO DE TRANSPORTE', NULL)");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (532, 7358, 'Prestação de serviço de transporte', 'Classificam-se neste código as prestações de serviços de transporte destinado a estabelecimento no exterior.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (533, 7500, 'EXPORTAÇÃO DE MERCADORIAS RECEBIDAS COM FIM ESPECÍFICO DE EXPORTAÇÃO', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (534, 7501, 'Exportação de mercadorias recebidas com fim específico de exportação', 'Classificam-se neste código as exportações das mercadorias recebidas anteriormente com finalidade específica de exportação, cujas entradas tenham sido classificadas nos códigos 1.501 - Entrada de mercadoria recebida com fim específico de exportação ou 2.501 - Entrada de mercadoria recebida com fim específico de exportação.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (535, 7550, 'OPERAÇÕES COM BENS DE ATIVO IMOBILIZADO E MATERIAIS PARA USO OU CONSUMO', NULL)");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (536, 7551, 'Venda de bem do ativo imobilizado', 'Classificam-se neste código as vendas de bens integrantes do ativo imobilizado do estabelecimento.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (537, 7553, 'Devolução de compra de bem para o ativo imobilizado', 'Classificam-se neste código as devoluções de bens adquiridos para integrar o ativo imobilizado do estabelecimento, cuja entrada foi classificada no código 3.551 - Compra de bem para o ativo imobilizado.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (538, 7556, 'Devolução de compra de material de uso ou consumo', 'Classificam-se neste código as devoluções de mercadorias destinadas ao uso ou consumo do estabelecimento, cuja entrada tenha sido classificada no código 3.556 - Compra de material para uso ou consumo.')");
  db.customStatement(" INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (539, 7900, 'OUTRAS SAÍDAS DE MERCADORIAS OU PRESTAÇÕES DE SERVIÇOS', NULL)");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (540, 7930, 'Lançamento efetuado a título de devolução de bem cuja entrada tenha ocorrido sob amparo de regime especial aduaneiro de admissão temporária', 'Classificam-se neste código os lançamentos efetuados a título de saída em devolução de bens cuja entrada tenha ocorrido sob amparo de regime especial aduaneiro de admissão temporária.')");
  db.customStatement(
      " INSERT INTO CFOP (ID, CODIGO, DESCRICAO, APLICACAO) VALUES (541, 7949, 'Outra saída de mercadoria ou prestação de serviço não especificado', 'Classificam-se neste código as outras saídas de mercadorias ou prestações de serviços que não tenham sido especificados nos códigos anteriores.')");

  // ***
  // DADOS PARA TESTE
  // ***
  // ---> PRODUTO
  /*
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (1,1,'3011010827133','30113','01 PRODUTO TRIBUTADO A 7%','01 PRODUTO TRIBUTADO A 7%','01 PRODUTO TRIBUTADO A 7%','10.000000','-168.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'7.000000','000','1900','04T0700','07',NULL,'T','859dba8c255ea32d52d40a880a0a66d0')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (2,1,'0312011604499','03129','02 PRODUTO TRIBUTADO A 7%','02 PRODUTO TRIBUTADO A 7%','02 PRODUTO TRIBUTADO A 7%','35.000000','38.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'7.000000','000','1900','04T0700','07',NULL,'T','36b2f8acbf6b3415593761c3375a5376')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (3,2,'0001170000005','00015','01 SERVICO TRIBUTADO A 5%','01 SERVICO TRIBUTADO A 5%','01 SERVICO TRIBUTADO A 5%','1200.000000','22.000000','10.000000','1000.000000','A','T','40129010','04',NULL,'5.000000',NULL,NULL,'0.000000','090','1900','01S0500','05',NULL,'S','b91a39fd72ad76bc7a5dea5c86761806')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (4,2,'0001180000002','00012','SERVICO TRIBUTADO A 3%','SERVICO TRIBUTADO A 3%','SERVICO TRIBUTADO A 3%','558.000000','42.000000','10.000000','1000.000000','A','T','40129010','04',NULL,'3.000000',NULL,NULL,'0.000000','090','1900','02S0300','03',NULL,'S','518ed490b056ead636e3ff57d7640b75')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (5,3,'0001190000009','00019','01 PRODUTO TIBUTADO A 12%','01 PRODUTO TIBUTADO A 12%','01 PRODUTO TIBUTADO A 12%','120.000000','35.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'12.000000','000','1900','03T1200','12',NULL,'T','29cd753d019190b64bd2bf55c3353e19')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (6,4,'0001234567898','00018','PRODUTO TRIBUTADO A 17%','PRODUTO TRIBUTADO A 17%','PRODUTO TRIBUTADO A 17%','5.800000','16.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','8a29a9d84d507fd9e2f9a2918859224a')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (7,5,'0407011150500','04070','PRODUTO TRIBUTADO A 25%','PRODUTO TRIBUTADO A 25%','PRODUTO TRIBUTADO A 25%','29.800000','13.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'25.000000','000','1900','02T2500','25',NULL,'T','121944f630e7b552a79f895671a11dd1')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (8,6,'1603041234428','16038','PRODUTO ISENTO','PRODUTO ISENTO','PRODUTO ISENTO','120.000000','35.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'0.000000','040','1900','I1','II',NULL,'I','8c7c178fceea111998be13d20fc57480')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (9,7,'0507021132142','05072','PRODUTO SUBSTITUICAO TRIBUTARIA','PRODUTO SUBSTITUICAO TRIBUTARIA','PRODUTO SUBSTITUICAO TRIBUTARI','30.000000','27.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'0.000000','010','1900','F1','FF',NULL,'F','c456e7cb91bf7c3d2127891a40a63d80')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (10,1,'1','25098','PRODUTO NAO TRIBUTADO','PRODUTO NAO TRIBUTADO','PRODUTO NAO TRIBUTADO','558.000000','41.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'0.000000','041','1900','N1','NN',NULL,'N','b4305c923540d030f45d98ce3b0f38ff')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (11,2,'2608021532487','26087','02 PRODUTO TIBUTADO A 12%','02 PRODUTO TIBUTADO A 12%','02 PRODUTO TIBUTADO A 12%','30.000000','46.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'12.000000','000','1900','03T1200','12',NULL,'T','460ebcb1e29360a7492b3ab7657b0757')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (12,2,'2106021651318','21068','02 SERVICO TRIBUTADO A 5%','02 SERVICO TRIBUTADO A 5%','1','700.000000','21.000000','10.000000','1000.000000','A','T','40129010','04',NULL,'5.000000',NULL,NULL,'0.000000','090','1900','01S0500','05',NULL,'S','4c40bda38afb88a3c69297d499bbbf8e')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (13,1,'1234567894568','12348','PRODUTO PARA DAV POR 350','PRODUTO PARA DAV POR 350','PRODUTO PARA DAV POR 350','350.000000','94.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','9bf519e02b39ad60a8269871035d0aa8')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (14,1,'5488654654665','54885','PRODUTO PARA PRE VENDA POR 90','PRODUTO PARA PRE VENDA POR 90','PRODUTO PARA PRE VENDA POR 90','90.000000','92.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','a009db059cf4c65dd2fb1d90649d88b3')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (15,1,'8797897998555','87985','PRODUTO PARA TESTE VALOR 200','PRODUTO PARA TESTE VALOR 200','PRODUTO PARA TESTE VALOR 200','200.000000','1.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','7ea7b58ecfb223193ea592fa9f49e153')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (16,1,'5555554444564','55554','PRODUTO PARA TESTE VALOR 150','PRODUTO PARA TESTE VALOR 150','PRODUTO PARA TESTE VALOR 150','150.000000','99.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','6a590c5d1e68242fd54db9a15337d7ae')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (17,1,'6465487987999','64659','PRODUTO PARA TESTE VALOR 30','PRODUTO PARA TESTE VALOR 30','PRODUTO PARA TESTE VALOR 30','30.000000','99.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','aa12c8f26747b7045d1b84bbc7a4a16c')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (18,1,'8521479787998','85218','PRODUTO PARA TESTE VALOR 500','PRODUTO PARA TESTE VALOR 500','PRODUTO PARA TESTE VALOR 500','500.000000','90.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','4f0cb6bde3d96dcb765d6d4c86385334')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (19,1,'8798546521325','87985','PRODUTO PARA TESTE VALOR 50','PRODUTO PARA TESTE VALOR 50','PRODUTO PARA TESTE VALOR 50','49.000000','96.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','a5a5d92ef483a3241900464eb8d6b0b1')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (20,1,'2581473698888','25818','PRODUTO PARA TESTE VALOR 20','PRODUTO PARA TESTE VALOR 20','PRODUTO PARA TESTE VALOR 20','20.000000','76.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','05',NULL,'T','29d89983b44756d39a2926f4be6362aa')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (21,1,'9876465431323','98763','PRODUTO PARA TESTE VALOR 140','PRODUTO PARA TESTE VALOR 140','PRODUTO PARA TESTE VALOR 140','140.000000','57.000000','10.000000','1000.000000','A','T','40129010','04',NULL,NULL,NULL,NULL,'15.000000','000','1900','05T1700','17',NULL,'T','3f2338b4a6e906b4547518d4955c7790')");
  db.customStatement("INSERT INTO PRODUTO (ID,ID_PRODUTO_UNIDADE,GTIN,CODIGO_INTERNO,NOME,DESCRICAO,DESCRICAO_PDV,VALOR_VENDA,QUANTIDADE_ESTOQUE,ESTOQUE_MINIMO,ESTOQUE_MAXIMO,IAT,IPPT,CODIGO_NCM,TIPO_ITEM_SPED,TAXA_IPI,TAXA_ISSQN,TAXA_PIS,TAXA_COFINS,TAXA_ICMS,CST,CSOSN,TOTALIZADOR_PARCIAL,ECF_ICMS_ST,CODIGO_BALANCA,PAF_P_ST,HASH_REGISTRO) VALUES (23,1,'2548798532156','25486','PRODUTO DE PRODUCAO PROPRIA','PRODUTO DE PRODUCAO PROPRIA','PRODUTO DE PRODUCAO PROPRIA','10.000000','100.000000','10.000000','1000.000000','A','P','40129010','04',NULL,NULL,NULL,NULL,'17.000000','000','1900','05T1700','17',NULL,'T','342753e90364d1e2e30314c33807527e')");
	*/

  // popular IBPT
}
