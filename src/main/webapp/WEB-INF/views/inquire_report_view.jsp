<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>

<html>

<head>
	
<meta charset="UTF-8">
<title>바라는 바다! :: 신고창</title>
<link href="${pageContext.request.contextPath}/resources/css/inquire_report.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#inquire_ban_check").click(function () {
            var id = $("#id").val();
            var ban_inquire_num = parseInt($("#ban_inquire_num").val());
            var category = $("#category").val();
            var content = $("#content").val();

            $.ajax({
                type: "post",
                async: true,
                dataType: "text",
                url: "inquire_ban_check",
                data: {"id": id, "ban_inquire_num": ban_inquire_num, "category": category, "content": content},
                
                success: function (result) {
                    console.log(result); // 응답 값 확인
                    if (result === "ok") {
                    	alert("신고가 접수되었습니다.");
                    	$("#inquire_ban_save").submit();
                    } else if (result === "nope") {
                    	alert("동일한 사유, 동일한 내용의 중복 신고는 불가합니다.");
                    }
                },
                error: function () {
                    alert("오류가 발생했습니다.");
                }
            });
        });
    });
</script>

    
</head>



<body>
	
	<c:choose>
	<c:when test="${loginstate==true}">
	
	<form action="inquire_ban_save" method="post" id="inquire_ban_save">
		
	<div class="container">
	
		<div class="container_title">신고창</div>
		<div class="report_container">
		
			<div class="listbox titles">
				<div id="list_title">제목</div>
				<input type="text" name="title" id="title" value="게시글 [${idto.title}] 신고" required="required">
			</div>
			
			<div class="listbox reportuser">
				<div id="list_title">제보 유저</div>
				<input type="text" name="name" id="name" value="${mdto.name}" readonly="readonly">
				<input type="hidden" name="id" id="id" value="${mdto.id}">
				<input type="hidden" name="ban_user_number" id="ban_user_number" value="${ban_user_number}">
			</div>
			
			<div class="listbox reportwho">
				<div id="list_title">신고 대상</div>
				<input type="text" name="ban_name" id="ban_name" value="${idto.name}" readonly="readonly">
				<input type="hidden" name="ban_id" id="ban_id" value="${idto.id}">
				<input type="hidden" name="ban_inquire_num" id="ban_inquire_num" value="${idto.inquire_num}">
			</div>
		
			<div class="listbox reportreason">
				<div id="list_title">신고 사유</div>
				<select name="category" id="category" required="required">
				<option value="정보통신망법에 의거한 청소년 유해 컨텐츠">정보통신망법에 의거한 청소년 유해 컨텐츠</option>
				<option value="정보통신망법에 의거한 명예훼손, 모욕, 비방">정보통신망법에 의거한 명예훼손, 모욕, 비방</option>
				<option value="정보통신망법에 의거한 불법촬영물">정보통신망법에 의거한 불법촬영물</option>
				<option value="정보통신망법에 의거한 광고성 게시글(스팸, 바이럴)">정보통신망법에 의거한 광고성 게시글(스팸, 바이럴)</option>
				<option value="그 외(아래 문의 내용에 게재)">그 외(아래 '문의 내용'에 게재)</option>
				</select>
			</div>
		
			<div class="listbox reportcontent">
			<div id="list_title">신고 내용</div>
			<textarea cols="50" rows="7" name="content" id="content" placeholder="문의 내용은 1500자 이하로 입력하세요." required></textarea>
			</div>
		
		</div>
	
		<div class="report_btns">
	
			<input type="button" value="신고하기" id="inquire_ban_check" class="btn">
			<input type="button" value="입력취소" onclick="window.opener.location.href='inquire_listout'; window.close();" class="btn">
			
		</div>
	
	</div>			
	</form>
	
	</c:when>
	<c:otherwise>
	
		<script>
			window.onload = function() {
			    alert("로그인한 회원만 신고 기능을 이용할 수 있습니다.");
			    window.location.href = "${pageContext.request.contextPath}/login";
			};
	    </script>
	    
	</c:otherwise>
</c:choose>
	
	
	
</body>



</html>