Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC4D606A337
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rZ6F70qe;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m9ObnjCs;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Iev9Lbl9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CE656086C;
	Tue, 24 Nov 2026 16:48:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O72vzr2B6s8R; Tue, 24 Nov 2026 16:48:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1FC56081A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795538880;
	b=DHjgYjVHnf9y1totDYTif9fAfe7EKKiftNXIXYdF/kqxnIZUcBtaRyRycjZq2Fg0Vc5A
	 N+nK3Y68GFf8Y+G14JjQDX4Vxbp8b6jp2X4FKwYTajUOntu6ZtcHWJqrhxWHGSNay6HDi
	 Prsrs3uJwF5IGg6rHSDHzs4N+xeNIt4oXXpKxn+3bImVmLChc5lwqNq6ryxTwsI4NwBmh
	 X6W49vP9V3vkMWAfVcRaQp8mm8oWgyReMqbpJMZ4JGtedNjlIfmRHn5VKS4PnJUbJOw0P
	 W9MTxjAtpRHB83Lf1m0leVBhNIycZZuacTAWZgRTVhLRGnph4KlBCQufDRaO3DO8jaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795538880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
	b=BUT54lSeAcJskpG9KIFM267BT9B6AS/jekWD7HGSKsgZVMAXBQxZChGypwSOIGP2r8Gs
	 oSxotYG2k8ez9sdKp56FD3EOI3lMneP4CvWCzEv/obRHaLyEmsZcAF+ANHAcEvrWmo3IE
	 cnN3+5jTpavuOOKxR5GcQbsl+KD+UBp0Md6lsBb2GCWcJJDJHyNVLUbpPQvTYr5df/YGO
	 s5N7YyWMosnhIj660H9ICZfZFiFm/e2ljyDeFNor7TAOqIcoB8Rpm+WfA949bDitUY7KY
	 OX7h2xazsP/JCYVdidsqKwXmkt1We8gpBKlWAxXKbINIkfw1zC0AdwrDtcsWPDYT1Hw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795538879;
	bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rZ6F70qe07wjoAKBaQI2cd7+OiF9NsnWEH9Zp/U83zP+PckQpasj6agJEEXLfm1ct
	 8ROq1Gj/T5gCC4TniHkZTaUwgOVfFMA3SX1hw13RaxSaP+zpZE8TF8CkistsTnFD7I
	 VusHlCjuYbJIYxTx0KrFFBwFXSae+FD+Tua7Qh2hbXgFeZlrOFw8x90KWaYpRkttWS
	 GpVg/vijv8J42cRgtZxvkeFEAkTdG3Z85El6QOegXF3HydD0+QaNPAakoEIMh5EsDZ
	 Q+zpJXj+r0pZOOFeiOjhEmGhIUKnoECW3Z20D0dTdfti9OzoQy/fpT6M0YZhr1w5rZ
	 uZQe99BC0JpOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1FC56081A;
	Tue, 24 Nov 2026 16:47:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 98E67371
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E94380BBD
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id epH9iCVSV6Hm for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:47:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F222480DD1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=m9ObnjCs; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Iev9Lbl9
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F222480DD1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:57 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFtnV41684117
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6HJlZOyIZNy
 v1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=; b=m9ObnjCsekpGftV6W07xE5zpz+r
 IvbmrojLmkhMMuC5woGaeRakvyvl6tcuwcBeFunQQ9QxHt5xfpWjqVJ114OZl8yp
 TaM69Mbtwai9QWg53D0W1tmzXxCvJEpZ/RygxBiffmtlE0iHFpwUTj1RsPGPNtD7
 zGnqFVsF6yJws22/O5BLgT0Dq/MIzFlb3cGkahSa1n9FporX/OxthaS49I1hDMsJ
 BwR4T1eulY1Y7jbWqC9Qo8cqJbK9aCZR0KqAKyP8Tb3g1HeuBuwNwdMejbGr34u2
 fK5Kqrlr2RBa04g1n73MKvApyTxnnvCFKKahoYhiUcI/mUV+1h1ffWGwjMg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5dngg82s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-386a65fca25so3553081eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795538876; x=1796143676;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
 b=Iev9Lbl9jpkXk+n6ktw0tKLuDucHO/9TulHQG2gVKB0+kH0D0Vxj6r+M7uMYIS6P/m
 gQsX930xPibVk9lFQ2KsBMxVE4Q7UgwVPERNDP8ZOahxo2XcglvdRvaED+Lyf806V3Pe
 glSvfXaq5xmT2AxZzuqR+yX+jgiS9Ejkx0Sllv7pVfdsYJE6TKFHXN8729wWhDsOEXo2
 Wziup3oZaA4uPhU17tEQYYY/uZ0nEZ65YuPuVpUp5+wTi4EW77kDPSs1NkXF5Uizs6zx
 ybjnWKARTXH10nNtu+vSM522D/ta4VZju4eykav/WibfIUAES/Idynq5niiz1SfOGW3P
 M7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795538876; x=1796143676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
 b=lkGtFrCuN5zwWg4rz0ovLkn7xuybV7qYsUWOEytLwrmS/WDmjmvP24B4YfC3F/xYoy
 8uix4R1UJuc6Yl91XLx6yk/NRx7H60JRa448FrTTRiUTPwTMy8G+/5IFvXv1/EM1Z3fa
 RrwqFb5usnfPYp4BRdlRzOxsU1xSzewp1/DiR+IanL7nVmLKz4CV3xTkAeeJJyPrDVql
 KbjqJud3NI58jbS8mprX2Kdc8TIr43PQj7lIEDCvmfSfJFCRixIu0srj198jlh1gBSay
 Y9nvvRWAXAWxXiVuJcvwVTTRFLVNGZvJT1r7XrGIp4S80dNeb712TKvEKjI8PKS2FE1q
 W0fA==
X-Forwarded-Encrypted: i=1;
 AL+hErEUIejIq4G3uxUjawAgFiPLe1fJ0/ht2fh4pDXNGueXUYeh5YRaqSo/h9SAi+gV2+TVO1Bkjmw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/vVtCjNBaCECcw5mnbDvbQbRs5H+kkyLzg0r+cOB9aj7WiO9z4
 hlvZ6z6yFo8/O1RWdiVH6lxRcwILvzDN2z7y3wHXvbM1IL+qLE7vPE2eGSmbfkynEsn4tNAoGAn
 yVBfE335jrkhgyykL0YVhTX1/QXGDQ5egKVC8gH+Lnt8EWtsDI6pLI/10oB+v7ZVhbelqxrA=
X-Gm-Gg: AZFdTZc5e7RIfBYCQCnt9AJ5yuPfMJ1Pq0563AdBk0w+UzfYmEmD+fTwuMkzyFadXiu
 2Y6WEmoNUQEYywj7LXsd5LmaHkVwVxtkcJQwvtt1avUBH/AtJeW0mj8QxMnG0skSDzwJhrXbzPm
 JJG3NOqwt1HzXCY8tcDzAy5RaqvvSa3t1lbRJ3Vlh3tqjzJFoWKgqc2gr83xkHovqmOrFa7JM7c
 0JJfSsV0F931R7LangJO+PZePs67E6mjrO6/z51Mo85gYOch/pV8gAo40PvaxFtnjvZYTtY9iOq
 xUA4yF8zVNrvGDoqS1M3O/xmy18oy0do2IBTpb0J/HCSGJZWOC6ni7FZ2Qp0ogamWVPsho8Gh7K
 67YVhfHj7CTFpUU0iJheGJq/b5BfzniksUgq49xkhSsB9aSW6qTN6wK/6jkFLVY4gjHtg8smvLs
 cNBkM1J0FR2Fzhg/tPMwCTbnjj+cGGQP8pqwnFpKP9x6PBpNWagRMmdR4WrPSFt2Vxxdpt
X-Received: by 2002:a05:7301:d183:b0:386:a728:6c11 with SMTP id
 5a478bee46e88-386a72872d3mr9415550eec.17.1795538876057; 
 Tue, 24 Nov 2026 08:47:56 -0800 (PST)
X-Received: by 2002:a05:7301:d183:b0:386:a728:6c11 with SMTP id
 5a478bee46e88-386a72872d3mr9415508eec.17.1795538875376; 
 Tue, 24 Nov 2026 08:47:55 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm55365072eec.10.2026.11.24.08.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:47:54 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, quentin.schulz@cherry.de,
 william.bright@imd-tec.com, nikroks@mainlining.org,
 macpaul.lin@mediatek.com, dlechner@baylibre.com, xerikasxx@gmail.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 8/9] configs: qcom: add debug UART config fragment for
 shikra-evk
Date: Tue, 24 Nov 2026 22:16:59 +0530
Message-Id: <20261124164700.1606518-9-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
References: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfXycq9lkTs6yT2
 eePGwkPIrK8ElTmlI98daccUYWn3WcbHLtfoErW6CObexvW0oRIzZdMG+RTRvQtLsH0yOvWKalk
 6JuyPMdVBtoU5795QWj+Vg+gRjbppSE=
X-Proofpoint-ORIG-GUID: ZIM7_v7eQ7HVmPBqDWbqHnMyKHhvjxxa
X-Proofpoint-GUID: ZIM7_v7eQ7HVmPBqDWbqHnMyKHhvjxxa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX84tbU6qwzSAV
 zEnsGJM6a8j8Hk4Q6fM6gesdMUKfiU6lWnJmme31i7Qo6PWTKiSqZRtsIkeQK53/DFzj9GFMJjF
 1lwLz3ctWoqgJVll9BFWJsqz9hnM2ur6A4JzeDKP+YHEDr86cj2AIgiOcxX0kdNOAOr26LB/n8o
 FZtttylpcKASASy4x0iF6vXg6D0LvlMy3uE1Cm+EJxpIixnaqBuEEb94qL1edrIMrYFMqtByntL
 7Y+S0R953RdIpeuO12UwqAU+9/qMRopbnPeOkT3tYDrYAYIcRveSo1O4NwalBxThNMU1V0jN6xG
 4u0/3aXggeo56HkiK6iBfyKZZcUB/Ld85donlOOgIJGsEUar4BTS1ZBScbfEUganqnQ1Rga6glf
 5IuBtnZpssy6RNBgo5yibMuC4d1thIgsmF6OHTeJSqFRXO8jJtAOjp26asIlDmCqgY1BNBiBkDg
 VvW4uc+9miAfmrwLhHA==
X-Authority-Analysis: v=2.4 cv=U9cHnuru c=1 sm=1 tr=0 ts=6b05bfbc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=3Z-LdhOq5Ikn1NNAXfgA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240065
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable early debug UART support for Shikra

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/debug-shikra-evk.config | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 board/qualcomm/debug-shikra-evk.config

diff --git a/board/qualcomm/debug-shikra-evk.config b/board/qualcomm/debug-shikra-evk.config
new file mode 100644
index 00000000000..034ab3249cd
--- /dev/null
+++ b/board/qualcomm/debug-shikra-evk.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x4a80000
+CONFIG_DEBUG_UART_CLOCK=14745600
+CONFIG_DEBUG_UART_MSM_GENI=y
-- 
2.34.1

