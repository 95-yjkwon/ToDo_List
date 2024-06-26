<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">오늘의 할 일</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				Todo List 페이지
				<button id="regBtn" type="button"
					class="btn-primary pull-right btn-xs btn">Todo List 등록</button>
			</div>

			<!-- <div class="text-right">
				<a href="/board/register">게시글 등록</a>
			</div> -->
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table width="100%"
					class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>#번호</th>
							<th>해야 할 일</th>
							<th>작성자</th>
							<th>마감일</th>
							<th>수행여부</th>
							<th>등록일</th>

						</tr>
					</thead>

					<c:forEach var="todo" items="${list}">

						<tr>
							<td>${todo.tno }</td>
							<%-- <td><a href="/board/get?bno=${board.bno}">${board.title}</a> --%>
							<!-- 상세 조회에서 페이지 이동을 위한 수정 -->
							<td><a class='move' href="${todo.tno}">${todo.title}</a></td>
							<td>${todo.writer }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${todo.dueDate}" /></td>
							<td>${todo.finished == 0 ? '미완료' : '완료' }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${todo.regdate}" /></td>
						</tr>


					</c:forEach>
				</table>
				<!-- /.table-responsive -->

				<!-- title을 눌렀을 때 상세 페이지로 이동 -->
				<form id="actionForm" action="/todo/list" method="get"></form>

				<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Modal title</h4>
							</div>
							<div class="modal-body">처리가 완료 되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
								<!--  <button type="button" class="btn btn-primary">Save changes</button> -->
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
			</div>

			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>

<script type="text/javascript">
  $(document).ready(
    function() {
        const result = '<c:out value="${result}"/>';

        checkModal(result);

        $("#regBtn").on("click", function() {
            self.location = "/todo/register";
        })

        const actionForm = $("#actionForm");
        $(".move").on("click", function(e){
            console.log("move임");
            e.preventDefault();
            actionForm.append(
                    "<input type='hidden' name='tno' value='" 
                    + $(this).attr("href") + "'>");
            actionForm.attr("action", "/todo/get");
            actionForm.submit();
        })

       

        function checkModal(result) {
            if (result === '') {
                return;
            }

            if (parseInt(result) > 0) {
                $(".modal-body").html(
                        "게시글 " + parseInt(result) + " 번이 등록되었습니다.");
            }
            $("#myModal").modal("show");
        }

    });
</script>

<%@ include file="../includes/footer.jsp"%>

