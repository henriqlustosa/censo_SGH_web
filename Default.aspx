<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Relatorio Internações SGH</title>
	<link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="jquery/jquery.mask.min.js"></script>
    <script src="jquery/jquery.min.js"></script>


<style type="text/css">
.table{
		width: 100%;
		white-space: nowrap;	
	}
</style>
	</head>
<body>
	<form id="form1" runat="server">
	<div class="container">    
	   
		<h2> Censo SGH</h2>
		
		 <div class="form-group col-sm-2">                      
		
		  
		
		   
		
	   </div> 
	   
		<input id="Button2" runat="server" type="button" onclick="gerarTabela()" value="Censo"
			class="btn btn-success" />
		<button onclick="salvaPlanilha();" class="btn btn-success">
			Salva Planilha</button>
			<button onclick="reloadPage();" class="btn btn-success">
			Limpar</button>
	</div>
	<div class="clearfix">
		<table id="tdata1" runat="server" class="table">
			<thead class="thead-dark">
				<tr>
					<th>
						nr_quarto
					</th>
					<th>
						nm_unidade_funcional
					</th>
					<th>
						dt_internacao_data
					</th>
					<th>
						dt_internacao_hora
					</th>
					<th>
						cd_prontuario
					</th>
					<th>
						nm_paciente
					</th>
					<th>
						in_sexo
					</th>
					<th>
						nr_idade
					</th>
					<th>
						dt_nascimento
					</th>
					<th>
						vinculo
					</th>
					<th>
						nm_especialidade
					</th>
					<th>
						nm_medico
					</th>
					<th>
						cod_CID
					</th>
					<th>
						descricaoCID
					</th>
					<th>
						tempo
					</th>
					<th>
						nm_origem
					</th>
					<th>
						nm_origem
					</th>
					<th>
						dt_ultimo_evento_data
					</th>
					<th>
						dt_ultimo_evento_hora
					</th>
					<th>
						nr_convenio
					</th>
					
				</tr>
			</thead>
			<tbody id="tdata">
			</tbody>
		</table>
	</div>
	</form>

	<script type="text/javascript">
	
	
		
        function salvaPlanilha() {
            var htmlPlanilha = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name></x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>' + document.getElementById("tdata1").innerHTML + '</table></body></html>';

            var htmlBase64 = btoa(htmlPlanilha);
            var link = "data:application/vnd.ms-excel;base64," + htmlBase64;

            // Captura a data e hora atual
            var agora = new Date();
            var ano = agora.getFullYear();
            var mes = String(agora.getMonth() + 1).padStart(2, '0'); // Meses começam do 0
            var dia = String(agora.getDate()).padStart(2, '0');
            var horas = String(agora.getHours()).padStart(2, '0');
            var minutos = String(agora.getMinutes()).padStart(2, '0');
            var segundos = String(agora.getSeconds()).padStart(2, '0');

            var timestamp = `${ano}-${mes}-${dia}_${horas}-${minutos}-${segundos}`;
            var nomeArquivo = `Arquivo_${timestamp}.xls`; // Nome do arquivo com data

            var hyperlink = document.createElement("a");
            hyperlink.download = nomeArquivo;
            hyperlink.href = link;
            hyperlink.style.display = 'none';

            document.body.appendChild(hyperlink);
            hyperlink.click();
            document.body.removeChild(hyperlink);
        }


			 //Teste jr
		function gerarTabela() {
		
			dadosMes();
			
			
		}

		function dadosMes() {
		
			
			
			jQuery.support.cors = true;
			$.ajax({
			async: false
				, url: '<%= ResolveUrl("http://intranethspm:5003/hspmsgh-api/censoNepi/") %>'
				, crossDomain: true
			
				, type: 'GET'
				, contentType: 'application/json; charset=utf-8'
				, dataType: 'json'
				, success: function(data) {
					//var data = JSON.parse(data.d);
									console.log("passou");
									data.forEach(function(dt) {
										$("tbody").append("<tr>" +
                                            "<td>" + dt.nr_quarto + "</td>" +
                                            "<td>" + dt.nm_unidade_funcional + "</td>" +
                                            "<td>" + dt.dt_internacao_data + "</td>" +
                                            "<td>" + dt.dt_internacao_hora + "</td>" +
                                            "<td>" + dt.cd_prontuario + "</td>" +                                            
                                            "<td>" + dt.nm_paciente + "</td>" +
                                            "<td>" + dt.in_sexo + "</td>" +
                                            "<td>" + dt.nr_idade + "</td>" +
                                            "<td>" + dt.dt_nascimento + "</td>" +
                                            "<td>" + dt.vinculo + "</td>" +
                                            "<td>" + dt.nm_especialidade + "</td>" +
                                            "<td>" + dt.nm_medico + "</td>" +
                                            "<td>" + dt.cod_CID + "</td>" +
                                            "<td>" + dt.descricaoCID + "</td>" +
                                            "<td>" + dt.tempo + "</td>" +
                                            "<td>" + dt.nm_origem + "</td>" +
											"<td>" + dt.nm_origem + "</td>" +                                            
                                            "<td>" + dt.dt_ultimo_evento_data + "</td>" +
                                            "<td>" + dt.dt_ultimo_evento_hora + "</td>" +
											"<td>" + dt.nr_convenio + "</td>" +
											
										 "</tr>"
										);

									});

								}
								, error: function(xhr, er) {
									console.log("deu erro");
									console.log(er);
									$("#lbMsg").html('<p> Erro ' + xhr.staus + ' - ' + xhr.statusText + ' - <br />Tipo de erro:  ' + er + '</p>');
								}
			});
		}

		function reloadPage() {
			window.location.reload()
		}
		
    </script>
	
   </body>
</html>
