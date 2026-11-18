Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE36606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CUH5hAZC;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gSldaijP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZYi+vt3B
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5BDB60829;
	Wed, 18 Nov 2026 06:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MAR4Ybu-n1V1; Wed, 18 Nov 2026 06:14:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0A1D16077B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794982475;
	b=s5lMxrWnlR/MDjpvLcbvYIUdy49f9e7s2OUiMV8+dPzeFrAxL9gmOYCHPijpFHiUcZOC
	 038JL1WfPzXof/9AYVe7C/MH8KnJwrL4+rStCK3fyXQnzI1YikGaM9W8cxj6n7p7Nhsaw
	 SZ/PYAbJJSHQYEB4BQJi2dl8JEjkKMkh3uq+Oltn5vFVX1sqjWm9q7Jp19gDZfHjN43Pz
	 4kgPJsycGKDJj04uBimxpTgPMXX8+ipevrZCUXgqo116n2pgccgBB95sd9ljikDisZas9
	 isW3sXF0/cd54mYmy//Jj8FlDF8NLuOb3DDmzyLwGu7V1/aZrJRr2XHtFXMsTVZxizw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794982475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hPpBIXSowUWDFwX13Jp1QkFuBg6yk7l6hPB2Es46Gwg=;
	b=Q4T2iyy5rHS/YwXIhdjd4nZ96QbYGcFm/wOwvlfnyXARKqWT3sIo2/9iudZz+hUO5RlG
	 74LEbAf1Kk0Dq6yHwBLyjFrFhF3NGFdoHtVU5wgQT9pnBC6LM+Yro8m+Yee6GIgqGrfM3
	 PF+LL1D4iIpoNx2rPhjKOQbRZEEyo965oAH8QCfOf7HZckLvYfb7ozAzjrUU5E3kKzMpj
	 kS5Gx3Annmi5+aVmX5jZNS/WjZk//r+ylqD+CfCUXoE3VuORvTqQwe7E6mUEAuAxwHvfm
	 COeatzwYC1ipIbX6UyiV06xupf00IqnRCpc70D1S5MJaVRkRSOqvdfUuxYCrI1N/hgQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gSldaijP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZYi+vt3B;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794982475;
	bh=hPpBIXSowUWDFwX13Jp1QkFuBg6yk7l6hPB2Es46Gwg=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CUH5hAZCm0JmkhJVdk6b5am6c5nktI0tmw1Cb0CkLNxc23/Uaznssd9AqbK3MSupA
	 SG93urc6WaIhvq1+phNUkIBq5j5SqsT6+6DBKpa3kgAE4uMptkCdnzJEyxCycmfAFm
	 grtHSsBBWv8HEtfb7JB1iUTkxVZhdTO03/E4ZttGn7G+v2qRM9lYD22/v9xlPekGTd
	 gTADPDEYiF3nc8KcWYsfKy57ghtbBo/4DDsvDC9HZdJfTONfXbtGY58Qi/Obbi2veo
	 YWgodZXhcPHW6Ya/2HBXWWN5uAJC0uFGfRaMtVKxlcU6iuvlaepun8P9eVr4JZuU8j
	 AjYSlLyR3bbBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A1D16077B;
	Wed, 18 Nov 2026 06:14:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E26E49B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F9266081A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:14:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhGoGuFlC5K8 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 06:14:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A2B47605E6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gSldaijP; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZYi+vt3B
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2B47605E6
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:14:31 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI2UujE2453531
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hPpBIXSowUWDFwX13Jp1Qk
 FuBg6yk7l6hPB2Es46Gwg=; b=gSldaijPe3/3oz2agR2rnA2biTYPyrpmEfMzE4
 tnEicHkfatOYOJJf5UOw2Ujn6sedmFK3KgZ4NqLBhfpWopF8+nG/04OL52wHnNam
 HCQAk82+t0UuOEV0bCersCKTKI84U75yjpj2HiIcmZ0Qkv0Jabb9ufNqLlKzAytu
 ieHpBDBuqvYVrGSujyBRyhv6rrerjC9GkYp9UXmvzfVSpfaDefbU/sgV6PpAfBIh
 SZNbOybeDhs1NjcPj5YTq44OFblToWqmjNeKmRrGuLDIx3D4MRuRpsef49oqT9qd
 7QR9svJR1gcU8zbpg0920f0aTZYO8BLSmbgeKZwjXuAO6z1A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv99g0b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:14:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36ecd5db581so1747674eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794982470; x=1795587270;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hPpBIXSowUWDFwX13Jp1QkFuBg6yk7l6hPB2Es46Gwg=;
 b=ZYi+vt3Bccd29X38pvCiicWvwREjOkRCHu+4fQUi7mZl4oWgVij6nfTLr6yqgY2dTb
 cxPESssjHNDIcayUVq11xtyylaI+9ooAcJKGG4Rf7vqdHYadxhH5/eD9mcq/L89//U8K
 RalVGuf1ykHLDVjje7kNwTvWdnKhALw9OMVIfEeJzCysopChR2en1Xv0wGgN/pGuTbUn
 mX5Fsdtvy1gH+VaUTfE1ovAUzW1xi48XfmAI5fg+I8CaYYoZFBA8WDO6tAXl/6gLjgQX
 gZCepgYVZ8BbEeDG7VThObp13wgGBDXleWAIjGv1ny5LKtyrJncdit31CSriydv7FC3s
 r+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794982470; x=1795587270;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hPpBIXSowUWDFwX13Jp1QkFuBg6yk7l6hPB2Es46Gwg=;
 b=HIYyqZRadOg+wN7nkRbB/9BrCwGDJe5d2DiSZcaqnGxKYh5g7BrmpNkvykrtvkeEiS
 txjgxCNeukbY0ylkbOGs9iw9BmE4IHMf648M38Xs7yx1Qich6cVa/Yi6emU96k31Ngxb
 Nku68FZNZJKEtqrmBTeRC9jZyb/RrUeeV6K/7hfQjGPqqN+6T7gVzdWPUK51Bvjl9Y2e
 1h6j2SoE6RbQAq7PnyiH32bWx74riKN0XLdBHwkXn7hJt1pOqbJT7efkUFvvOlWjM3nO
 7kVBw1ER9DjpXWazsVZzCxcoLLwlpbF402sr4CSDhhr4QHKgSgiwtac8uLp16dpDk1Aw
 tpUw==
X-Forwarded-Encrypted: i=1;
 AL+hErE3XXJDFvA9UtqWdvJk4RffzgYkyjA3ZYdCXJSUNbGGYi/Yr+FnSFYt+R6B/8QRI/kfnkDBrU8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/dMQRd8Dv9ON1vPCO99q61OODifA2jrQIssrlk5zECgLx0ZBql
 AQK45zrjM4CvwGw4kDl5YmW+SOAIGCwq6DIAat5Os+s/+yAlQWghqoB6BBE0wjC3NqfvPhWm9B4
 8L0Gv9aL5FdH4Rd83iv/xHWa45k8THzIJLYM7G6dldGDlKvd3RIh8s6ccZ5d7u35YCFaFC3c=
X-Gm-Gg: AZFdTZfRjKwNfBrX8xAnTlgMBdlVwtQgEF+EKF+dGswlsyIUniBLIUB53iGeLTMO1oP
 tDxMHCVXRMC+HujoT0LB/tU3db6oC/5UwtdDZrCOvmpPZbu2+IDgoXOw8fSa3Um/015ng9+duOg
 5WoZXg5YmF89f/UWIel2LRupgYkvjyrXMUgsfV/rbYxXr3Nlk4cNVKtp8ezWRHCyEWdU83p7/gM
 toYOzgCwBESfl7xJZRoepZ1OC6Rqm6WOLPKiiBMNBt6Yo2qO1AEmQ6oD5CJagK7TAuIyXamngSV
 dJrvUBVkomWj3iJKsJJ21EKzeKt9OCZmH8hSD1Px1ziXjwgg34JlqCk0eWDv0D4TZCOBKkftQCN
 g3mK360UXfaAQFdkZWvPLzAmGe98yjQHbsRM4ShPUfM+zsEbEWZr0QuIP5qr6O9B3XFSFjza9Sj
 T2Pa62dsxqPN2qML27UdJ5yzOSF7V08AWB8yGzu+0pNNOhZAXO4cB4QMxoP67xUYrSCczu0f7oK
 UAs
X-Received: by 2002:a05:7300:148f:b0:36a:1f8:a5a4 with SMTP id
 5a478bee46e88-3828171b242mr2239728eec.38.1794982469647; 
 Tue, 17 Nov 2026 22:14:29 -0800 (PST)
X-Received: by 2002:a05:7300:148f:b0:36a:1f8:a5a4 with SMTP id
 5a478bee46e88-3828171b242mr2239697eec.38.1794982469099; 
 Tue, 17 Nov 2026 22:14:29 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a63054ddsm4339229eec.4.2026.11.17.22.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 22:14:28 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 11:44:22 +0530
Subject: [PATCH] common: usb-hub: Wait for port reset to complete before
 power on
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-usb-hub-wait-port-reset-v1-1-3d1cd9a1cfc3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAD1C/WoC/x3MPQqAMAxA4atIZgO2FRGvIg62Rs2iktQfkN7d4
 vgN772gJEwKXfGC0MXK+5ZhygLCOm4LIU/ZYCvbGGNaPNXjenq8R4547BJRSCmicyE0tfNz8BZ
 yfQjN/PznfkjpA55GeglpAAAA
X-Change-ID: 20261118-usb-hub-wait-port-reset-33cc643bfcb2
To: Marek Vasut <marex@nabladev.com>, Shantur Rathore <i@shantur.com>,
 u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794982466; l=2177;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=YVDYHPy6eurPwJ3T+vtHzq21RoZ1CjwRrg1D+2RoPI8=;
 b=2+CQ/jG2Gmhf8vQezqDp81KqQbIvXll1KvDl4IDUwjHeoiS4Uwb6KtaSGvkrbwABW9udUeibc
 dP5hNo+pGUiB6ZAuW/+yWLkABzhEEyjNUYY1uRJLr77AoceJv5OcdHT
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyNCBTYWx0ZWRfX5WIg2RxsrSWL
 bv33hz2sOrUYUyKA7Ec5CX1gFT/Nw1mGPDYf8kErXAvT/AL4H+MliTWSxpV03y4TMSKBYT2pEj3
 7PA6w7SUE/AaYB0YEz+e+sZ7oDMr1+Q=
X-Authority-Analysis: v=2.4 cv=acT0Dhot c=1 sm=1 tr=0 ts=6afd4246 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=GjFhT4j6E_LWE1ql:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=wgsKEKcdHyf_cVU3iK4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyNCBTYWx0ZWRfX4rHRy+zV0R6q
 r3ollxr89ucghSDRf5jsatxnnC20HDo35bVH34Qkrnif1VsVj7EJPO2+J8VbXVb0fropY9Nbp6d
 OwqeCuFiVRYcikje32MYzKvll8optDlLUu7io1QU1plO0cXwHb7NZ0TQ/+6t5zLdHYqyKhi4K3T
 R8PWeLp4DWgBvyVe3hmK1F+FnKL1OZHtGVFJxkqJgbqrLUKnMcS3f+qZviPvT5Z05J1OaKqq557
 LjbcO4EGTCKNseQaGmkld0bQ4WTVDtCM1mnuIFy3cpoJxeKyE7EUMQkJTga4hffTsRKzblMNbce
 x1Rd8MXMow3Vp1dM1xoCiM4udWl2EOebSrFa8kgrgh9+FMUYCSaETX9muB6noBxPnkJ+ZpjWEfF
 tK2xySAe58UYrz8PC2FaWnF+gJ1gXOb6dXh9jEeHhOuedcVCMWQL2i6mxYbstiqpFejOGCHNM+V
 bpUJbws0DqujMijITAQ==
X-Proofpoint-ORIG-GUID: ZMi7oUs9XeaDl348oiW9w1_sW_J7Yoj1
X-Proofpoint-GUID: ZMi7oUs9XeaDl348oiW9w1_sW_J7Yoj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180024
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

usb_hub_power_on() sets USB_PORT_FEAT_RESET on each port of a USB 3.0
hub and then sets USB_PORT_FEAT_POWER right away, without waiting for
the reset to finish.

On Qualcomm Shikra CQS2390, with nothing attached to the DWC3
controller, PORTSC write for USB_PORT_FEAT_POWER on the USB 3.0 root
port happens while PR is still set. This raises an asynchronous SError
and "usb start" resets the board.

Poll the port status until the reset bit clears before powering the
port.

Tested on Qualcomm Shikra CQS2390.

Fixes: 33e06dcbe57a ("common: usb-hub: Reset hub port before scanning")
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 common/usb_hub.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/common/usb_hub.c b/common/usb_hub.c
index 6a4bcec00bc..c03169f9edd 100644
--- a/common/usb_hub.c
+++ b/common/usb_hub.c
@@ -162,6 +162,25 @@ int usb_get_port_status(struct usb_device *dev, int port, void *data)
 	return ret;
 }
 
+/*
+ * Wait for a port reset to complete.
+ */
+static void usb_hub_wait_port_reset(struct usb_device *dev, int port)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(struct usb_port_status, portsts, 1);
+	int i;
+
+	for (i = 0; i < HUB_LONG_RESET_TIME; i++) {
+		if (usb_get_port_status(dev, port, portsts) < 0)
+			return;
+		if (!(le16_to_cpu(portsts->wPortStatus) & USB_PORT_STAT_RESET))
+			return;
+		mdelay(1);
+	}
+
+	debug("port %d: reset did not complete\n", port);
+}
+
 static void usb_hub_power_on(struct usb_hub_device *hub)
 {
 	int i;
@@ -176,6 +195,7 @@ static void usb_hub_power_on(struct usb_hub_device *hub)
 		if (usb_hub_is_superspeed(dev)) {
 			usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
 			debug("Reset : port %d returns %lX\n", i + 1, dev->status);
+			usb_hub_wait_port_reset(dev, i + 1);
 		}
 		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
 		debug("PowerOn : port %d returns %lX\n", i + 1, dev->status);

---
base-commit: 2f83ef8a7dd4a409b534ea68cd13b17b686cc53c
change-id: 20261118-usb-hub-wait-port-reset-33cc643bfcb2

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

