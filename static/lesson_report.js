var table; // Define the table variable outside of the $(document).ready() function
var loadingElement = $('#loading');
$(document).ready(function() {

    table = $('#lessonTable').DataTable({
        "ordering": false,
        "processing": true,
        "serverSide": true,
        "fixedHeader": true,
        "ajax": {
            url: "/api/lessons",
            type: 'POST',
            contentType:"application/json; charset=utf-8",
            data: function (d) {
                return JSON.stringify({ 
                    draw: d.draw,  // Add this line
                    studentName: $('#studentNameSearch').val(), 
                    lesson: $('#lessonSearch').val(), 
                    subjectDetail: $('#lessonDetailSearch').val(),
                    start: d.start,
                    length: d.length,
                    startDate: $('#startDatePicker').val(),  // Add this line
                    endDate: $('#endDatePicker').val(),  // And this line   
                    teachId: $('#teach_id').val(),  // And this line                 
                });
            },
        },
        "columns": [
            { "data": null, "defaultContent": "<input type='checkbox' />", "className": "dt-center" }, // 체크박스
            { "data": 0 }, // 날짜
            { "data": 1 }, // 학생이름
            { "data": 2 }, // 대분류 과목명
            { "data": 3 }, // 과정 상세명 (링크 추가)
            { "data": 4 }, // 레벨
            { "data": 5 }, // 담당교사
            { "data": 6 }, // 수업 내용
            { "data": 7 }, // 교사지도사항 

        ],
        
        createdRow: function(row, data) {
          $('td', row).each(function(i) {
              $(this).attr('title', data[i]);
          });
       },
       initComplete: function() {
           var searchButton = $('<button type="button">검색</button>');
           searchButton.on('click', function() {
               table.ajax.reload();
           });

           $("#lessonTable_filter").html(searchButton);

           $("#studentNameSearch, #lessonSearch, #lessonDetailSearch").on('keypress',function(e) {
               if(e.which == 13) {
                   table.ajax.reload();
               }
           });
            // 체크박스 헤더에 클릭 이벤트 추가
            $('#lessonTable thead').on('click', 'input[type="checkbox"]', function() {
                var checkedStatus = this.checked;
                $('#lessonTable tbody input[type="checkbox"]').each(function() {
                    this.checked = checkedStatus;
                });
                // e.stopPropagation();
            });
       }
    });
});

$('#createReportBtn').on('click', function() {
    // 학생 이름 검사
    var studentName = $('#studentNameSearch').val().trim();
    if (!studentName) {
        alert('학생의 이름을 입력해 주세요.');
        return; // 함수 실행 중단
    }
    var selectedRowsData = [];
    $('#lessonTable tbody input[type="checkbox"]:checked').each(function() {
        var row = $(this).closest('tr');
        var rowData = table.row(row).data();
        selectedRowsData.push(rowData);
    });
    // 체크박스에 체크된 행이 없을 경우
    if (selectedRowsData.length === 0) {
        alert('체크된 내역이 없습니다. 레포트를 생성하려면 최소 하나 이상의 항목을 체크하세요.');
        return; // 함수 실행 중단
    }
    loadingElement.show();
    // loadingElement.show();  // 체크박스 체크 여부 확인 후에 실행

    // Get the dates from the datepickers
    var startDate = $("#startDatePicker").val();
    var endDate = $("#endDatePicker").val();
    $.ajax({
        url: '/api/report',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ data: selectedRowsData, startDate: startDate, endDate:endDate  }),
        // dataType: 'json', // expect JSON response
        success: function(response) {
            loadingElement.hide();
            console.log(response);
            
            // Redirect to report_sample.html page after AJAX request is successful
            window.location.href = '/report_sample';  // Change the URL as per your route configuration
        },
        error: function(error) {
            loadingElement.hide();
            console.log(error);
        }
    });
});


