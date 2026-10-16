Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14060CCF2C2
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 19:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33B6380F40;
	Fri, 16 Oct 2026 19:53:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5RZ2Gs4c1Htr; Fri, 16 Oct 2026 19:53:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 669E580F42
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792180438;
	b=MiYYKQci7D4GzSOU1oFIgYCFa2elg9YCUnBSd3YtPw04zdpLhJzHRTnlIiTGxegOlUgo
	 sEdC7U8/QSFJKOlHRbydSD1MaD1WPgxMiaAR4/WS9HSmNvXSrvotsFxCkX66uxOqqBJBa
	 +0+KO3A8/L8HX0H6Uoc/hrszoeVWQGVTkY4g5p6Po0cuFVetQqoHOmxWqM9ccUE0hmgl8
	 2qEIhEQxHFZliEHpW0nB24pzJWyA03XhE6AwxHdNtuybTH0XKjNGSAVl6JDmqhpbyamrc
	 0/TRA0QoPBLwtx7cBjb6OSsTCnJYTuHpTtNltn61OsnNtJ8mp/YxOdgstFs/fBYqA8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792180438;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Provags-ID:UI-OutboundReport:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v3Yaz6P9KwJyyf5DrXJ7E5Li2LPz8ahlJCQ2H7o2HOw=;
	b=NtSbD2LFaCD5C+vkmo0qJBLaNQgUczHo6ENJwAl+FxC/dp2+LfpU58MoV/oa1SK4SvFP
	 wlVaQWmKjYQO/HxQRT30B48UWdjQCD2dJaRV+BPprpjVbtCw9V02OpOOyqlV2TsV+FWRw
	 Ha5mP4ZtTM4u1kdh11H59aKkJczomNiauKgFzzPcP9VfNu7vlOwgOW0jjgkPAAH0EYeKh
	 e3d+sI0wfKe1NZIzrQtKul+X3Z9QHH96MwoG8ykcej+IsXYBep4LYmRlO0vh9AYJWYH+/
	 Ljed2+JWJKKgKJl+8HCXoStr3UFJiAVbgy5Ct6i8aLrO+i+wmfh7klSvj1Qe6PPoVCw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792180438;
	bh=v3Yaz6P9KwJyyf5DrXJ7E5Li2LPz8ahlJCQ2H7o2HOw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PdMiSNtBpmEauJ57jqvIi6D5b2YiNI6h9lce6LKHsSB6o+vNts2uVD1zoCqZhsmvu
	 2jmezDbtyXrr2MR2ByunQJ0OxGG/90RFSIcMoyy40K65Mn0zemUrjnvLJpenEP+2jW
	 ytV8wl2UFOHeTjpMW173HDR1jKKrgdhKKRkW74+/9DZjuYxizfy5HwOry2rZELJ2HK
	 R/28TlzK+uuftuES1U6VQ4Dq/Em2Vjr+c7bf3GpLPvRWU5YYhzgQy22EHm9Bb3IHsj
	 XHlZkpgPdT9EWVD3DjOT4WoOBi5/seX8QuWRk8uXZvsSHpeuT7XgW59TOd63anhgxj
	 0yAvmsFj7NjJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 669E580F42;
	Fri, 16 Oct 2026 19:53:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B2F17AD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 712F4607EB
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:53:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26DOA99qxniY for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 19:53:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60F8D607BB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792180436;
 b=ST1v+cDAD3eV2nE8i5HHvSi6ZPhLDjsucqfKWR5It4g+SUMB4b0csR5YXmRO4UANuPQi
 mCfCuPqBVhv0mVaciDdB5WmgytdrgGmEimaIKM5pauiedcyWX6FIeRaC6dLn3RYDZbVnw
 FJVKf45vmaAecb+Tca6uQGDAlllEWrxAbWH8OfqfH0pP9jz1RPDgb31Cp8tJbENSE8KMh
 DBkx4LijEH8KnE+weyZlggDdeGARE3J6wyI1nMJwTcWDzIA5tp5I1bYPrhRAU79O5t5yL
 HnnCoSmSeNm2EHHz2DaDEPWAOo0TPBxRgxCqIgCL/6ShhFfaTGy3WUx9bOFcZJ0ngjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792180436;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=v3Yaz6P9KwJyyf5DrXJ7E5Li2LPz8ahlJCQ2H7o2HOw=;
 b=dpwmmD0h1n1mvyDcV+HmJMccu8l+bNc+ckJ7xq9SvwwXIcLIJO46QEpU+Uy1XSwQ/zrM
 tReKz/+ubb0mlzDe/CmcBXS6MywLHml2hmFCQs8pllFbVSMs2953q1iWC9r+PZf4ODSmY
 UjFKdu8ieCzYvOfYhQsVGxaRVW/UYHK/hyn8ubRuptpcQnEzJUuyE/xneifzj6WZb/44+
 peFh10AgHeVe3SQ6k6hlokHDcrpnXiKj3btBMR4rjuM8BDqSa8x7mftUy1rDOgCJnzjPH
 XlJZ3LDXAczs7HODaUE84OhFfEI8K+NiCzWWS4Jia4HpfnJ0vz2w0c9gA9JUo/yJYPw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=PMgXVMMJ; 
 arc=none smtp.remote-ip=212.227.17.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.21;
 helo=mout.gmx.net; envelope-from=fiona.klute@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=PMgXVMMJ
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60F8D607BB
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792180430; x=1792785230; i=fiona.klute@gmx.de;
 bh=v3Yaz6P9KwJyyf5DrXJ7E5Li2LPz8ahlJCQ2H7o2HOw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=PMgXVMMJvxeAmW5MgD4iGFAkYGo/R4rnRZH40pmB8qEjII0MwBwxqBljav6oPh9R
 vCT9EMeZYWhdlstnKVDh8oSKwF73DJ4cccIShzO6t7/JnM/7AAxgAdhYCvP+W0IBy
 UEnvqkumlsmzn2jAJDUnguLvkuAL93p4VKKdytnikq02Ysi+u7LmC8JqRFCJD3RIa
 YRtHVkR2HGluyq2olWCSWLlNvez8pEL+cQAyIeWkCaYImz1af2HVfSrAsvxChIc5Y
 I5ovK483OHpbGzsM+xSVQiHr7J1LCAkAYhnPfb56OmkigHXTtAYyUGdehMoQO5bq1
 P8wE+x6TpGwN7jkPjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McY8T-1wm3gB2CtR-00aUjZ; Fri, 16
 Oct 2026 21:53:50 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.u-boot-project.org
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH] env: document -guid option for "env set -e"
Date: Fri, 16 Oct 2026 21:53:39 +0200
Message-ID: <20261016195339.3630271-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:e1Xc77sPNJ16L5WNL5skpYKtV2M1fTvhr8iQnL3+PBpwPY/oNnd
 hzSm5lROeazEj7X678lzgEUOAq8G+3BEueunjWQMBvw23ZsNZqb7TnwoNCfu0oXibHIKujW
 uUWH5SKahYCvR6ncXMLUNUMNZdG8b9Nbeh6x7RsHJau/fW5Vl8bpMOpNaVuMfh3NtTXWT8k
 7otvLSLnr6n3k2fQe4x0Q==
UI-OutboundReport: notjunk:1;M01:P0:KbUerkotEUQ=;8DdDrqRSchog7Da6K7PyTzs4Jd6
 x23naJFZ15KGv/eW/yWFUKVzltfKcjFOf/PqSk15zuxO4l5G508fznmQ1RIewHjB69gaVjxT9
 ngDKz+dkuPKN0OwAGJvEL/g9t35P0fzMIhWN2X4ZlwThXTAYEoqWSm08D1eW4wcuytFg3LlL0
 TBne0V0wADQp9Q7O2Fa7i0dQfK4Da4/nniTbYvd9AJNzamUNDVG7EhNn1a9cyo9KhcJqdB57L
 3mGWxtgK/iSsv+VMrmSwUOfBNAMpoRHG8JdYlSwD3z7npQ/a8h5Ax1+4IfloAATTdRF2Cw8l3
 YKcElCXdY2elYbzksrGf0fC9s84WJbb6vMFw77KyfCan+V/hTgt9Fw1IbQQ56awmBpkHbs/BI
 TJBTkygVWxhMqEOTXXjzP5tQStOeXqGGyDxf2Y/tZw4PzFpQdbBr5AqvXKk9epzB1CZi8W++s
 pTM46Ez7OLzE9c8zF5OYbN4SSr/81amh/CDMIEq+UYqJx5prXyZHUD2rgbgrsNJ0CenVHS5Mc
 3d73RVw60qNZDEYX6zZcCtka/D3YchUFh6Sy4LsEspiaUQ/YRSXlXhg7QhTcw2zDIci0j1mK3
 AGrOpCiiub++PD69ObAMBYe9nHe3OW3I/BejAWNWrD5u3ky51QUHHFp9ZEW6VeTM42/XqXyhy
 lgjR1ftK/WF9NKIenP3TNJ2DHelAaYSUe7mkspLrjBdmGQheuMURHzt9N33ZxLKgWWHs2v+tY
 qV44+z93SlRKc63HAj4skr6/EDq7tzdzP5FPf1ujYit/w70MTFk5RB4weH9NWzblAbk3CsOIJ
 K4R9DdTSxbDF9z7MC66ar15Q4x7IBl4a/LzBngN/ITDcui946ZYjurDtvs8ewAMqdiUbjT9ZD
 9Z+DpesHFieaKoVzVINafVIk01c15aRVLsD1YaZuxrUJn/oRSE4+scB25iSCIMqqzA+m+fkXn
 s9TqKBS2WM6ui5Aon39j+IvDrJwUmv/4PCXkJFuSsSp+c8DooO5Vz4dWYEYoecv+1CJqRDYoG
 s3AFdtC5ZT+cp5RRwjrUr8DfA2B/qdKaFuIpk7ORObnpWFjhRdCBKnB8HdKqaXUehOtLgCutd
 8koR5m7Rukhxuq1V9TiL6jlFGtK2WKBhWjNT5YjhUTN95yeU2MUABlI8T0HSdadZGJ5PxcKr2
 OKeAmuTHQKmXl9uBMZ3BD2MvV2MgmK45YyYP0m4jmeq2207WgDbD55wvY4nHjNk5mjRxumvBj
 qye1qLUfkNPAmJZyo/tfeISUksqatvbB+qmSeYTc/lKA7zzcOKTTUwD2BvzUF9F9BMHrGAVwD
 p/ifLuDkJVOcu2EEv8MxdO4bJ5KlxMl8yKjp0FVPnVUo5g4eo6r7vIqWuOXmf8pV0pUNkW9Pd
 kGj45tqxidjbcPNqo3UBqtVl7+eeyWBgmhWGIbwBTiuGe7q+zJsU6gJB4NjojwxbU7VJEZCL9
 GIPI5d6pDz9/7UVpbwRR0TzRWSNGSZFX354q5L8pBtOLx4fYp4v/uhTusl1flQE/z7mK+syER
 M4JtAocsh5jCX1hVq40g/fC0IKwLG6Ms3NxTruPpI0X24S0hhJYhv++2TkRMSgyjFwOfWwpLy
 MugCOqhG4f4HZxiFHgIYSs0PamPdXpfbzx0tlXdBSnHfzvx0UqxABxU58KVy7LnDTwCngMILv
 NtV5J2nwF4X33V9liei3E/KmrccWJSIuuRQ6cnN0jWLeS91+AjTUo8H/jonvU7RGFL6H7OqgW
 NuubiQgq1iPgOWrLcdgCEBWDpBz3DiLgx2nJWYFu805wQmvVWtFYbJCPRCtJiSc+7nGJYvnxL
 xjz0QBXiEsboIiLhWwqeErdmu4kq9sGO1RLXXfFJuuPYvH8RUyXUfAejPCO6fjlB12wcDc/C2
 Dc6wuyIh0YqoYZ2gTmiSG2Gfffcxj81nJukFKWd6A4hgPSIEjbmJa1ZVIhmg+9faXQxkZXbDd
 15eePtvJGeUSky6YSEcQGJGoud/KFH6NPnA3LlGj5vqaHqLXCzAz2awpZoLNXWoJcGt5J9Pr1
 Ca+gcAT6/0vTfDVsnYuyCyWtELmAuLQAGufiRJOkeAeGi8U/f+7NmSolZu0/FSNuR22AI8TzI
 bleIK1QkeLP2fVWABMOw7NqgJSiITWjhev+8AP81WPWe4u926TqiTPO/IWFPPpmA+AeE4JNzs
 +BkuQU2R4Vx1Ok790nZmqBBu7EfUCeEvM6uKeiVFv6ZAmaa1w5BpzVeb6VFWMGwkrc/cW3x+9
 m2eGGvR6uc1ODwb3gDr9T4SmjWmAZPeNUQ5akMkUWLPmWczSBR0P50oZT/MrhnPKgTaId+fKq
 XhaZjVfTYpOlqRoZTaDJmk4FAX7cfEr8I9EufbW7/Cuuwd14qCHaZHz6W31bf09sKqDYxDPF1
 eMWUgaIYgDfHvgF+fifUG/mQtpEUxg4cKKT8Ftw4pnIccifXjLb6TZxP8+p9o4KhOhXKwW7ka
 0+0wUT5h93XsUNbCYwyhhY5lfiNATYH5Km4t5ubBLdctyOIi+Lc92NlwIZtNjh8SmsHOzqaYl
 0TIPGXjzQv23nDmVtl+qE/kQzPsxj3FpQm00TjSiqg6fo9ntfZ0jbhCTWLS+gC9/XQ2mb+A4p
 o08pA5mbnZkkA+jRWJc1xyX3LTQhZlDWyS0p6X+LsaqIg7HdIBYfbaA6E/6eaauUDy9yyarCL
 qsw2RzSpEE040ZNCoEomEYeTT/LOen5+85qsoen2Yg4Dads+/6Sl38xxBcKVCRAbiko8XuAYt
 B43iirIa3+Z6UNIGlRSTK04c5vJ1m7vxcmrHskASP8Qey68x2TBnO03kY7L3hQvrXegmxI76e
 pZ+HYOKFjMgNsLCx7of1kjoO3Q01zpgG75hKlxSPI++ma1ZuQRB/qF2Tyie/Gmpi8eWMdW6LE
 M0dr93m0vIcdGHgZ+yIG3hIZpUrYra0uliRTsgaATB6Rq9fzvUfkTTdNXZfQcUvipM2ST3tN0
 jcnxJfFUv+jPmmUwsS4D//KHopJ82irLKih2VdZ2jXEiwrpHERk1/QRMwED51PkQNlsckVEJt
 +Oz2SApr/iooYgRP2qC/e8H5DlRbZEu+qypdaqsH9fnGEDDEwz+32IlYzR6djl6GH9rjg+DCq
 qVxkQpzuM1teNzX1aafyefO0Q0fJnEa8JVM0wERDpOEdrBEPIkRW10jRAu8TDKg8YmYB0dvBz
 DfHu+JYO3O8lHuunvQ1+khIKojFJSJKZ2XS/K+DRw5GiierQW+VCBtJAJJfgBur4vI2W5E5Qv
 lY5MkEYaG6cmKbncZ/DuTQ5NfKCQOZGfCoDSqvgiYsEs7CP7eo09bFb/41QG0p7WT8ea0zNr3
 lBMsP9h8ujY45v5NydZ+4NDLYflq3Hl7PPYdM6QTC7fzjktI1+o+OQQhjPIROcRS1aLm0UCuU
 bpKjkmd4d3Z0XWIfmMqUrZBZbABq1qlVLmrOSPVXQ98mzIHR/88aW4Lu0OJm0CPzBq2+zMLzg
 tunRg5gDaWm2y+npy2PlDSMNIcrTBXwbEETVT50XHkdBM/oMmjOSVjZJmUT/8SvrSXUHpsABq
 WMdZt0/KWwIj8rIisAqOegNnWyT94QZvOXnBndQlZEuyiS4H6vWagrOz2cIct1PwjyhhnPFlN
 Qg7weg8MnvZ4flWcucueUwOzuwxroxIXqRqX87faxS6nSRvujvqS81Sdfn8j68NBTk1K1UgzP
 ibQ6E//gfdOZegTbQstaCAqnESG6c49sS9hH5MlPCplRJgydADNo82nWIg0MKBCtfNTHwGkJr
 LRFCZmSj8YGkFvPNFHFlaBRSr10/j5xBO3YLymGizYpesuhOgsZi04JSDeGxssIR6gSWK4YHp
 2kGcQc02/TBIQVEvC+apU0pv/eMwrb8HrtaoT72zeEp7z0fDxCkyVeZ3mMYFjZEHmLf3fFh61
 apidwvx+oYsRXKp6p1npTIsIHfl6PudM5xTdOty22WOQugnrCQvPBHyY1t2ZaDtWhOrPTjCOP
 +fqcHW+FAd2wheTpQEa64a0go19ubU6keBBJ1hDdPvww+pejOs9zRTZfx3kF3EoHMj9U6Pko3
 c8Jm4N23BfdScYnVAcLJvTlWanf0oJ4WYiZjmksCL+A5SKo2t933KbScDh1anAJoqOdCxs9Qi
 Ns9+WomfELqHwJ7H/LwtvqAZ8Jhd3HVmwyzcfSOebkR+6wwG8iW2VtkShcj4aDrJEkd13j54c
 wJM5Hmuy2uPR3t7TL7Moa4kZeAc3UrIBQ85zsqqSX17CvKL1WD2Nku8ULjKuiOl3mpQk8HMvf
 f8zOjT7y3Z/1958GJnsDhKF0QN0rq+ZFnDEBmYkKMVVqDkRKlKt1d9YXu3YAsHjAwU7ap/9/B
 5p3mgDzav2+DXIg60izvZ9gMAE1bx2Eh1rXmPH37O61Nv8R3yT9wRPAtfBTFRbia+ihsijNJd
 07KuV0K6W+I1ZVJ2vdGFyYCbkcPIPsMFSMDY9bBW63IT2lqzpvasfGZGsf+opq0c4+3OUdgGp
 siyFd0m72Tx4IT0alFphkUFECrdbCd4rlbh/8AeAa0J3ePxWoH1mfNbzT4Z8u9HAHEmRmzHtd
 uiv1GBgRta3Xhby7OU08ZTIhvNRknkN8vyH69e6r8+uudIem/r4uYaK5/ZzjVLj/f4ZJEaadu
 DSLQsp4EPaBebrb07iNHCT75VPm3ckf4Iw7cjUT5wvFTYE6IWJkJmcywhYOEwg5fde650MUE/
 hMS7o0nVopo9bW6pkNtI+MCOlbsCJpOakJWqqVCKbO/G/5JWReKu62BIFkC7UEXu8GwEqKfZv
 rHTWsIx2XPlRnvF1KZbo0NWjlQ1uyI8bUd5iAFb+JEaDmrJHtIUJ2SHJ7UacrIGWB1PIvFARZ
 AwJEwj6PxLpGn/khabo8h/y/G51pfBupqzwx4tXgik1BTy6ATq5X4rXTEgYDbIP3mlYQodr++
 cOf1BpkYtNbS8Ycc6oqAZp9B80+jHI0t760yNqj7CLQkQxYf4jBBmRNMkksZe+m7DujFgLqFl
 3MEg6mwEnOxnjC+WNy+wIddZF5w8QZs5TGNQr2HfifEWg0IhGjWBPrVfDgHZVFJZZpmBsNSJm
 5IOwf82QZIPN0aVt38saINYI/9U/XQ1UFFTeDFI5drl8y4Nbhp6LaEzEVlfYn4rJBLbN2E760
 TyXdvpuDiuMPt9Rxkt27i7CovpM7J7oW/yov2d9X/ZuV2dV1pb1hk6SE6xmiWbWq+uP0oFbdH
 O+1fa43BWeNBS1f3v1yKS9DNQbEiQY9+CTezhkUaRgnaXPnMYOf6Z6iQdunS6uytAbp2BWp0Q
 KQ2njNnkqKbsN2kKofRgEp7BhOJVFyYRCPBrxk51/6uEe4uWaLvO/R2sYpfEKUc7NpwdIP0fI
 j9qREWT+JqlDj92syJ45MmyXkKB67zSD+7MlbvQ/roMdiPUSsP5vneO9C874AYJF5kxE3i0W/
 ZiejZ0MwAyR9KX46NOB5Kl67DWNzCKH/4T0y+7YZpkEBmcteIr293BwXhKwoNFA7eOCNIogrP
 10111dE6bln/Nim9NvCxp68SNxUoAsmhtOaZFFX6gUKA7nJOFoZez2hNFt8bsQOBwJ+VC5bYh
 G+jwWU/vzwBZpaiFt9iL+JzuqL5aeyu3hU55WQGAXBEA4FoSDv4tL5i68vbRzUMTI4amMv//T
 jGIu92Kl1Cf1TIHPc2wzKChtUxpiS8KbFRqJ+nAwxXDSXyk3YhQigO/A69HQYztp7u4Kdl1lh
 mURHHdoxI3qXoCrN15pb/vSOG41It+BVcP1ewCQAyldXxDYQvmtdxmOHs3YQZJhP8+ybQf06n
 ga35xJSCRn3KDhrB3HKzpdffB51BwWG3ie09VFOL0o0VlTfNUjZeWb/WToyUc4zyEhBSHQb3x
 vEE+T7QqKCRihf4um1Q069EGz4XRjqa7Sp3VSp+CxebEgCPM1euES1vYnZwEMeTxCBYAI3dKX
 Ds+DoX0WDHLrmv9NrjS2dRcXECt5d3+GpZmXGT4vHgXkUzE6oWrbPOnS/J1stiUCx3jakPVex
 qXtYk6zh2i9O3JBZlQrYITCrLQtm70CYjnO6Z+3fLxCNIjYLGhp8npqNUQrsJAgCB/3JlPXEN
 vk4JH6xQlxofCvigE3Cov/aE0Xskg581+EOWvPB+bJQYl7LRbORe+PKt38qvWt4/La1HGcwCS
 O7uQRrDpUeIhgtZLXC8tG3OLyesZZQtQ9Q2B1EKnnVT5MqUXEC3k5eoa7ZXsaOKDO22McwqmD
 zRu6FaJ2W+lVA0fdhBQt1zlzN/3r5vWTQzkSR5bNMpvdiWLOefiiyvPdpzQ6DxT5sGwu+Uaa8
 zHVUydFGXufGyhdm5F77WV+vNj/hZ3mJTk8CRsLgI6ViSeB3QEnQe/6ggAv717fiULLduZrQr
 IQJDF+utKJyvw/8/RRgzDNnauwgnWkNvyQyUXogmwBy0eEzEvSh6SxHbhdP6h3ZNF3dG5bfEP
 MNC/Lnz+Jfd58to948B6Ytd9m3KkW+VYCVBalG2Ok8REXvuXn0l8p7ddpr/9oUB3TVrzSnHvy
 xt+0i8DIy7hLYEIThl8cGnvc8K+kacNmGWRa6F8r/3H6yREuCjV3vU2J3iIMKOM0qkR1+lsZy
 snrz2UnX7dHYxaEZtf4bGWM9iHYqFHBOKoOm5qeJfA6MzvCsNf
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

VGhlIC1ndWlkIG9wdGlvbiB3YXMgYWRkZWQgaW4gY29tbWl0IDA1MWFhODlmNDZjYSAoImNtZDog
ZW52OiBleHRlbmQKImVudiBbc2V0fHByaW50XSAtZSIgdG8gbWFuYWdlIFVFRkkgdmFyaWFibGVz
IiksIGJ1dCBub3QgZG9jdW1lbnRlZApmb3IgdGhlICJlbnYgc2V0IC1lIiBjb21tYW5kLgoKU2ln
bmVkLW9mZi1ieTogRmlvbmEgS2x1dGUgPGZpb25hLmtsdXRlQGdteC5kZT4KQ2M6IFRvbSBSaW5p
IDx0cmluaUBrb25zdWxrby5jb20+Ci0tLQogY21kL252ZWRpdC5jICAgICAgICAgIHwgMiArLQog
ZG9jL3VzYWdlL2NtZC9lbnYucnN0IHwgNCArKystCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9jbWQvbnZlZGl0LmMgYi9jbWQv
bnZlZGl0LmMKaW5kZXggNjM2YmRkZWUxYmUuLmIyOWQzZWI1ZWFkIDEwMDY0NAotLS0gYS9jbWQv
bnZlZGl0LmMKKysrIGIvY21kL252ZWRpdC5jCkBAIC0xMTk1LDcgKzExOTUsNyBAQCBVX0JPT1Rf
TE9OR0hFTFAoZW52LAogCSJlbnYgc2VsZWN0IFt0YXJnZXRdIC0gc2VsZWN0IGVudmlyb25tZW50
IHRhcmdldFxuIgogI2VuZGlmCiAjaWYgZGVmaW5lZChDT05GSUdfQ01EX05WRURJVF9FRkkpCi0J
ImVudiBzZXQgLWUgWy1udl1bLWJzXVstcnRdWy1hdF1bLWFdWy1pIGFkZHI6c2l6ZV1bLXZdIG5h
bWUgW2FyZyAuLi5dXG4iCisJImVudiBzZXQgLWUgWy1ndWlkIGd1aWRdWy1udl1bLWJzXVstcnRd
Wy1hdF1bLWFdWy1pIGFkZHI6c2l6ZV1bLXZdIG5hbWUgW2FyZyAuLi5dXG4iCiAJIiAgICAtIHNl
dCBVRUZJIHZhcmlhYmxlOyB1bnNldCBpZiAnLWknIG9yICdhcmcnIG5vdCBzcGVjaWZpZWRcbiIK
ICNlbmRpZgogCSJlbnYgc2V0IFstZl0gbmFtZSBbYXJnIC4uLl1cbiIpOwpkaWZmIC0tZ2l0IGEv
ZG9jL3VzYWdlL2NtZC9lbnYucnN0IGIvZG9jL3VzYWdlL2NtZC9lbnYucnN0CmluZGV4IGI2NWQ4
NWI2NjgxLi42MjgxODRkYjEwOSAxMDA2NDQKLS0tIGEvZG9jL3VzYWdlL2NtZC9lbnYucnN0Cisr
KyBiL2RvYy91c2FnZS9jbWQvZW52LnJzdApAQCAtMzAsNyArMzAsNyBAQCBTeW5vcHNpcwogCWVu
diBzYXZlCiAJZW52IHNlbGVjdCBbdGFyZ2V0XQogCWVudiBzZXQgWy1mXSBuYW1lIFt2YWx1ZV0K
LQllbnYgc2V0IC1lIFstbnZdWy1ic11bLXJ0XVstYXRdWy1hXVstaSBhZGRyOnNpemVdWy12XSBu
YW1lIFt2YWx1ZV0KKwllbnYgc2V0IC1lIFstZ3VpZCBndWlkXVstbnZdWy1ic11bLXJ0XVstYXRd
Wy1hXVstaSBhZGRyOnNpemVdWy12XSBuYW1lIFt2YWx1ZV0KIAogRGVzY3JpcHRpb24KIC0tLS0t
LS0tLS0tCkBAIC0yNzQsNiArMjc0LDggQEAgVS1Cb290IHZhcmlhYmxlIGluIGVudmlyb25tZW50
IG9yIFVFRkkgdmFyaWFibGVzICh3aGVuIC1lIGlzIHNwZWNpZmllZCkuCiAgICAgICAgIGZvcmNp
Ymx5LCBvdmVyd3JpdGUgcmVhZC1vbmx5L3dyaXRlLW9uY2UgVS1Cb290IHZhcmlhYmxlcy4KICAg
ICBcLWUKICAgICAgICAgdXBkYXRlIFVFRkkgdmFyaWFibGVzLgorICAgIFwtZ3VpZCBndWlkCisg
ICAgICAgIHNldCBVRUZJIHZhcmlhYmxlIHdpdGggdGhpcyBHVUlEIChvbmx5IHdpdGggJy1lJykK
ICAgICBcLW52CiAgICAgICAgIHNldCBub24tdm9sYXRpbGUgYXR0cmlidXRlIChVRUZJKS4KICAg
ICBcLWJzCi0tIAoyLjU1LjAKCg==
