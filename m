Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB867606A32F
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=il46tQk2;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZCthCV1j;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hEutNkGS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92ACB404FF;
	Mon, 16 Nov 2026 10:47:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sDJ59BzKhGKw; Mon, 16 Nov 2026 10:47:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C19DC405CD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826076;
	b=m+ZGxxn9Q864wm9FS3PglViI6fuhj0PYf5aBAAspIDeoAUCDtZ54qIqCiDsDsY/xtKms
	 wT2KdP/OZZivGnwztjPAzBILbXQ6/ZoXc3IonMwI7m2mQFNjf5diOqG5FELhrd+Ty3ys3
	 ZOHXupoBGVWLJ1EvKSSpX0L0b4ZyiK0h4ly0t+/zPp5t9SfZZTsYZb7tziVcjtK+tzqbQ
	 zHQzh82SrHtDFyeqjqy9sz2sbKVfTxFE5rasFxxN6CzbjcUJahvFMa9gIqZD+sUpc2if7
	 wJHbdgOc4VJPXh86yCTfjKYoYtqKANE+vpRDeOfJx7oYrMxe5QVSgkoqg8RfEhvoEbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826076;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dOq9+sUeKOdUXqXVJ0hWwKzKMMlQmx3xsMVjg+qYjsE=;
	b=C6gD8mDnQdO/w4X9D2rokTj5Fp6CxgV7coBLK9pC6UpuYsd/5CjqBB2/9chRRc8BNoea
	 EHfzszfMDg7OGEFBBA1j8P/paS+HCEygVw0i13AOb8na3NO3DAvxnMzjtIxaFiqPmwDcn
	 RbIhTlo9R+PZf3g0LhLxp4FvvypUpEdU+3d7UPod+nVOCf+kU8N+2sJgbyAMpEnNsRd91
	 19cZGDbBAWQJuFAO4q5eG+Q40EOH/NKp7LWe07fIRXED8UxyDIOkBKLr/ShOjDP2gst2w
	 b8dR0tLSl9AxKil0jZvOV9HMj8PhxqYljFaJtl4s7txFGisH9r+UHWsRsdxMk1Kooog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZCthCV1j;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hEutNkGS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826076;
	bh=dOq9+sUeKOdUXqXVJ0hWwKzKMMlQmx3xsMVjg+qYjsE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=il46tQk2wtEiKTJ0AlUdWObFcXEY2vn9JdkdB9o9kgVZ1M3Pbrkmgcm0upB0F4E68
	 CUwDnXom/mS7dHX1AWp7DLcSDs3vksBvH/FRzlX8NE9pvZdyJ9/CLLtEAj/j5RAqEZ
	 Z64dPFUKKX6LASj96gbUr6DNNdqQ++Kfo6OfNmz0YDySoWoplYPMkDXyaMU1W9rG1d
	 9Wzbaiqe6DpFIABuNErLu8BqcN64Cn+VbLYiIepdHvhVSJ4hJjuSLYwA1TfPWNZYg2
	 dEF3PexhCWmxG0XvN1yI9ILMc79H8xBDHxSf8jk/G8dEpMDAJ9tG7PwvcFewjccaq0
	 ulbRoAZUGc7qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C19DC405CD;
	Mon, 16 Nov 2026 10:47:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8365128C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:47:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71132405CF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:47:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id seChumFVf-Ee for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:47:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 25E52404FF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ZCthCV1j; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hEutNkGS
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25E52404FF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:47:53 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGAKoZC785049
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dOq9+sUeKOdUXqXVJ0hWwK
 zKMMlQmx3xsMVjg+qYjsE=; b=ZCthCV1jTJVx+oFJ4CscSvT2cvkIpl6ty4jF0P
 wCtyOKO0CmZ2QzHA4O3hSNtQw7TyIaB2xeIavGr5vvYv3iKZa6e/PNTwdoGIwQK1
 z3thn0k2G7P9FB2Twkdt6tErTemADS2bzryVGsPwAOrtSg0iLiR1gZi5bRa7BUAN
 ansm/oopoLiNmpTYpOK+/ir+znTMDzYDSZiItO5kAJ65JiemQZ+loMVXx5+f7HoT
 ZYGCjKkHhclsrTtS3NmCRq6G458rkqlG2nkhGLnqI2JM8qczpu85/E2Kw+xc68WV
 sTk0UrvtWJoU8d3KYixP8L0IzWzOpTt9VBrgoFuB4GUDhX4w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j000g02x5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:47:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so5250435eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794826072; x=1795430872;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dOq9+sUeKOdUXqXVJ0hWwKzKMMlQmx3xsMVjg+qYjsE=;
 b=hEutNkGSBboNKumP0gT0GtZRglsKh5kJcF0pDvuIXOhHnHjMh6Vdlxjb3PrxHB/bsp
 GLregfepe+u5b9BiJ2+XmllpsW5VzGvNid+BpnP2+jE5Jxehhk9LZg31/7qtx+HbJgZI
 vvdhI/c55VlNhzN44m1ES82EVBiYKSQDSGhC2wyRShKewaeS2KNRPrpruvz6jxok5ITM
 GpOWvBFhw5TnBHQu80e7PQCs+cv47PYzsShHhLTFfWRYtxs8pZNk//F3m36PjeL8y/sc
 tDlVihuiAg1SRGqlHebQMmQSklx6+zw4UVD9cCGdv9opbHAPF/spGKKzj3Zw0iNNVCy6
 EIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826072; x=1795430872;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dOq9+sUeKOdUXqXVJ0hWwKzKMMlQmx3xsMVjg+qYjsE=;
 b=d8jHAauhyoi8LFK1egZFvHMu1Jff009I0vm3iBkP8rsnxK9VEV9aQVpG/goV9ffiB1
 Ga1ZNsOP63410arOXhodGgeK4FKxiaH9dBv3XubfZJ62L73Si8bMoxBb0+BmmcawGoOH
 8ICifV72T8mDVihqrO3QBagnZHu9mxtBcyleqwtjYe7ELf8ZkofnqltBx1kV9JhLZnOX
 XEbB4atVgM0eQXPXfDF+YdK5xbZ9Cy0EgVGBxsM39tfoFY90CkJ+qhXWhfa/6p2pBkq8
 s9OzXH8JqhqAC12nuUAyq1+uRl9+7Lr6p8w76BuYLBEuJHzMNUkO3S5H9L2ijjsVNE4z
 np8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFfOJQh/4m+iK58VMRfso2nKAOhdlUUMW1z6jDNSMZTiai9i+PoNfSv2paY0vTft++4SDB7ivs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+aQlGNE7DflQzbtw0u6IjXl6k6QLrQhk+gEMD7nFxAhSf4z/yx
 lNqkeL0J6SPZnFoFDjUI63jGrTzgFXhhDK8rjf3cC/6t9Oiha125qtwQ+axfYUnniPql4FvPj8e
 E0+G2MMT5MQeP3qwkpg5rkBgNXXfRdDUp2/EYHLYiJj4Petc6H1aXpWyirnb/BMBkghvHy0Y=
X-Gm-Gg: AYBFou0Y7RmjuDoWnLLV2Kwiqa8yiEZzMT8C/OAm3Lg8fHMpBOaHGu8nJbDtO2RCkOQ
 CrrblIEmBKrNcnYe+HD8H4vX8vN6Ze6/j2JVqU0J+uf3C/+ok2seNoCKGVuPbVLr2KjZ7YlLr/Y
 SnrsuKPe0wZf8whp/a23uqI26I7Oa1wyRrE2FW6+8Y+gSIcDLTNMCzjmASIC4GZ47ZbnsimUs8+
 IuEH7sYwkLe6YugfX+Fb31q6dnuH3VjDOSVsPSbtda8qavnVKXn6QE0fhyNA5ZfeoESfDO+cpWr
 i0OxAzBObG/zk5ocFDgDTcnSIItJI70zvqaAOo3+qglAKjman8fsb7KTOx7WOsS+1cDbj96TLaT
 Go3edMHKvGUserqpIfrwjD3jCJ88MpswVlpdOzvZsuNxarjFuRG4yJtbRa3MzNbwvK2+EItm9la
 rpte+WNrKJmgcGycRxRNgF6ovY0IPMBegcnNz+XwJwujIncftXSgSu31FKrx3AIFLkeusklVOsz
 JuP
X-Received: by 2002:a05:693c:8115:b0:36a:1008:5815 with SMTP id
 5a478bee46e88-37963372d85mr11027456eec.5.1794826071759; 
 Mon, 16 Nov 2026 02:47:51 -0800 (PST)
X-Received: by 2002:a05:693c:8115:b0:36a:1008:5815 with SMTP id
 5a478bee46e88-37963372d85mr11027438eec.5.1794826071192; 
 Mon, 16 Nov 2026 02:47:51 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm32971481eec.29.2026.11.16.02.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:47:50 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 16:17:46 +0530
Subject: [PATCH] misc: qcom_geni: load the QUP firmware when a SE is probed
 early
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcom-geni-lazy-fw-v1-1-59cb9896badd@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFHf+moC/x3MywqAIBBA0V+JWTegPST6lWghOtZAWSn0pH9PW
 p7FvQ9ECkwR2uyBQDtHXnyCzDMwo/YDIdtkKEShpJQKN7PMOJBnnPR9oTvQVU2tTSmENQpStwZ
 yfP7Prn/fD3dWxdljAAAA
X-Change-ID: 20261116-qcom-geni-lazy-fw-f485ac300dc6
To: Sumit Garg <sumit.garg@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794826067; l=5240;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=+rbI8Ckz2Mh+d6OV+CBBnUoU4c8057Zn+SZLFolhkwU=;
 b=HlQGBPPmGRuLQTBlII3I0tKGYfTmYuMVblwwwSQBGwlTJkOkX0K6f29NqJm4NcQP8ptygXjdb
 JnwdNCmtZ03D+0OdbfDCDiA5pVjATd8Z4MkyRnK8Xe+o34TxP6b37WE
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0MiBTYWx0ZWRfX2Frux/g6ekOf
 eqAG3LLr8S7kGDv0jW+NNrvun7FDBgDkUu6kHTQVSPfabJbCQt/1vvNp0BOtM21B6X28SZ35hl+
 wiMI+O+OM2piIQkEUZZ08sey+wp4JM1LENVjJzMi0F8hZCLe5ia0hVxcYwh0noQqmTTvnzVcl9p
 AGhhe6VVrB3O/DLubo5cWyLI8JQGIZSXgkEO3fTbU614I0oHYsV1NjX0EyP1blB5Lef83zUMwU5
 NESp5K+eXIbdZXEJZz7tI/LeySySfn0/9Ju0OQYET8KdlZgmedlsHNbsPrgsRNJ159jXieIkMDJ
 lSlO5eyGzRohOXeGcCsPHYy1dJ6Db5V++vChET53EGV+Rgg4oWCw4l/CZmRpmh8kqzAsg9XP9Ym
 l8cMbwed2JYJpioMKqN0HSYo/vmIBFZ6Nw1JjdpiLPluKygLWhOLkuMKnpK6eXP8u24gevkBGMQ
 KkOky3Yi5WKHQzx2Cwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0MiBTYWx0ZWRfX9CsoSij+JADF
 AtaPK+nWyHLb0dkvTqYg0EuvSh5YdzX/hAIxwIno5cQWmLz03bbqfjvyBhJZPEN+kbIYqm/GKs0
 GN7gWxmwad0ZUkk+P73AVIb0MYVm2xo=
X-Proofpoint-GUID: 0iPW-JM3-Meu-wNH-yusjo-pKJ0sS6_2
X-Proofpoint-ORIG-GUID: 0iPW-JM3-Meu-wNH-yusjo-pKJ0sS6_2
X-Authority-Analysis: v=2.4 cv=Vdtir1p9 c=1 sm=1 tr=0 ts=6afadf58 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Rk1x0suLvWUfaH6qI4UA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

qcom_geni_fw_initialise() reads the QUP firmware from storage at
EVT_LAST_STAGE_INIT and sets it as the private data of each GENI
wrapper. A SE probed before that, (for example initr_net does an
I2C probe to read MAC address from EEPROM via I2C), finds no firmware
and qcom_geni_load_firmware() dereferences the NULL pointer.

Move the partition read into qcom_geni_get_fw(). It reads the
partition on the first call and returns the same buffer on later
calls. Call it from qcom_geni_load_firmware() when the wrapper has no
firmware yet, so a SE probed early loads the firmware itself.

Fixes: b95df6ed8c21 ("misc: introduce Qcom GENI wrapper")
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/misc/qcom_geni.c | 91 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index f3133f85885..f29c9050b2c 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -39,6 +39,7 @@ struct geni_se_plat {
 };
 
 static int qcom_geni_fw_initialise(void);
+static int qcom_geni_get_fw(struct geni_se_plat *plat, void **fwp);
 
 /**
  * geni_enable_interrupts() Enable interrupts.
@@ -419,6 +420,15 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 
 	/* The firmware blob is the private data of the GENI wrapper (parent) */
 	fw = dev_get_priv(dev->parent);
+	if (!fw) {
+		/* Not loaded yet: this SE is probed before EVT_LAST_STAGE_INIT */
+		ret = qcom_geni_get_fw(dev_get_plat(dev->parent), &fw);
+		if (ret) {
+			dev_err(dev, "QUP firmware not available\n");
+			return ret;
+		}
+		dev_set_priv(dev->parent, fw);
+	}
 
 	if (IS_ELF(*(Elf32_Ehdr *)fw)) {
 		ret = read_elf(&rsc, fw, &hdr);
@@ -545,45 +555,32 @@ static int probe_children_load_firmware(struct udevice *dev)
 
 #define MAX_FW_BUF_SIZE (128 * 1024)
 
+static void *qup_fw_buf;
+
 /*
- * Load firmware for QCOM GENI peripherals from the dedicated partition on storage and bind/probe
- * all the peripheral devices that need firmware to be loaded.
+ * Get the firmware for the GENI SEs. It is read from the dedicated partition on storage on the
+ * first call and the same buffer is returned to all GENI SE wrappers after that.
  */
-static int qcom_geni_fw_initialise(void)
+static int qcom_geni_get_fw(struct geni_se_plat *plat, void **fwp)
 {
-	debug("Loading firmware for QCOM GENI SE\n");
-	struct udevice *geni_wrapper, *blk_dev;
+	struct udevice *blk_dev;
 	struct disk_partition part_info;
-	int ret;
 	void *fw_buf;
-	size_t fw_size = MAX_FW_BUF_SIZE;
-	struct geni_se_plat *plat;
+	size_t fw_size;
+	int ret;
 
-	/* Find the first GENI SE wrapper that needs fw loading */
-	for (uclass_first_device(UCLASS_MISC, &geni_wrapper);
-	     geni_wrapper;
-	     uclass_next_device(&geni_wrapper)) {
-		if (device_get_uclass_id(geni_wrapper) == UCLASS_MISC &&
-		    !strcmp(geni_wrapper->driver->name, "geni-se-qup")) {
-			plat = dev_get_plat(geni_wrapper);
-			if (plat->need_firmware_load)
-				break;
-		}
-	}
-	if (!geni_wrapper) {
-		pr_err("GENI SE wrapper not found\n");
-		return 0;
-	}
+	if (qup_fw_buf)
+		goto done;
 
 	if (plat->is_mini_core) {
-		fw_buf = qup_mini_cores;
-		goto mini_core;
+		qup_fw_buf = qup_mini_cores;
+		goto done;
 	}
 
 	ret = find_qupfw_part(&blk_dev, &part_info);
 	if (ret) {
 		pr_err("QUP firmware partition not found\n");
-		return 0;
+		return -ENOENT;
 	}
 
 	if (part_info.size * part_info.blksz > MAX_FW_BUF_SIZE) {
@@ -603,10 +600,50 @@ static int qcom_geni_fw_initialise(void)
 	if (ret < 0) {
 		pr_err("Failed to read firmware from partition\n");
 		free(fw_buf);
+		return -EIO;
+	}
+
+	qup_fw_buf = fw_buf;
+done:
+	*fwp = qup_fw_buf;
+
+	return 0;
+}
+
+/*
+ * Load firmware for QCOM GENI peripherals from the dedicated partition on storage and bind/probe
+ * all the peripheral devices that need firmware to be loaded.
+ */
+static int qcom_geni_fw_initialise(void)
+{
+	debug("Loading firmware for QCOM GENI SE\n");
+	struct udevice *geni_wrapper;
+	int ret;
+	void *fw_buf;
+	struct geni_se_plat *plat;
+
+	/* Find the first GENI SE wrapper that needs fw loading */
+	for (uclass_first_device(UCLASS_MISC, &geni_wrapper);
+	     geni_wrapper;
+	     uclass_next_device(&geni_wrapper)) {
+		if (device_get_uclass_id(geni_wrapper) == UCLASS_MISC &&
+		    !strcmp(geni_wrapper->driver->name, "geni-se-qup")) {
+			plat = dev_get_plat(geni_wrapper);
+			if (plat->need_firmware_load)
+				break;
+		}
+	}
+	if (!geni_wrapper) {
+		pr_err("GENI SE wrapper not found\n");
 		return 0;
 	}
 
-mini_core:
+	ret = qcom_geni_get_fw(plat, &fw_buf);
+	if (ret == -ENOENT || ret == -EIO)
+		return 0;
+	if (ret)
+		return ret;
+
 	/*
 	 * OK! Firmware is loaded, now bind and probe remaining children. They will attempt to load
 	 * firmware during probe. Do this for each GENI SE wrapper that needs firmware loading.

---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20261116-qcom-geni-lazy-fw-f485ac300dc6

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

