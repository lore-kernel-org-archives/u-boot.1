Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35171CA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 01:53:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0310160727;
	Tue, 13 Oct 2026 01:53:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V4zwwMro-fxW; Tue, 13 Oct 2026 01:53:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3343660730
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791856431;
	b=TUVDAXOzeKXxbb6Dje6JOyCxm+gx2DkSvKAYayVJx4zum570akTHs0e82MI3xT5DHs5x
	 YtnYj5czMbNDoCv0yE8kH6JcXKISN/JHSw23vkteh9ZUvsI8QtUO5NQL2bg4FRSAG/9iH
	 UtMPKSA26U/obARlvG3VjPGfRBHd3QYJSTgiaqLQ5kuT/Uz9z/GsFsaWPLHxe8ZhdFia2
	 ehSlPj2mHr8qoNdIjU0FQQIerR2C9QO5YWAVHjvufTSG4vXq7bSXRr6kNgCV5PDsA4X+m
	 kqUupCpv3zDVDHoY1lRIR35VCbLqfYyoXB7Wl45m7EDxTInal5p1qpC7mz3NKVpZw0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791856431;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eg9r2ojAFoYBAyWlHUgAfB/IExsUzAsGpuK5TGL0crI=;
	b=E5YNydr2E5YKKbl04CoVXUdUOEOB922Qu/o7sIBc7M49PbkrmmS+E8Xe6/ki2KU7m5aT
	 kGlsG8N1Z8Gs/rUT0EqhUvM76Q+RRr6+vYyNQJF5izfmi3r6lelkWvZNhRGyzuprKLYaE
	 JbKSiKvGfnfFfbE37kLosYOygecqFAhDUHKfX7rtP/teTr21G1IxjSH12t1AXc+Js89zr
	 55ylQyKzjg13n7mIYTyqQRIxNyhIlk4hIP7BbY2KrD5Q3HVTW78RTBs2Ra7NJi0UNeJGT
	 x+ZBy4XmnBA5H4oVL/2tA6vMyRbQhJvuJAquty9LCAFRGdtsPmARjv7PoLxcTbrqOlg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791856431;
	bh=eg9r2ojAFoYBAyWlHUgAfB/IExsUzAsGpuK5TGL0crI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sIze/VflQD8xCvbw4qVhgtRyuyreqwipNn27eRnPS/MkdZzLBJ8tVJsoRc7NMlbkb
	 l8eTZR70qrU1iH1UYcf8pu+kHfXXgID4d2ky5Mlizu5eF6PnwHf1kGlChRHOzEZfBk
	 1p51cRiz61S8+8h+xRgAwnF/r7sojV95f1sGZO2pPsW+CsLBvO0lhYbckh4I8Ehnle
	 YEl2LnjlX5R6tLvfjMbCYJHfwOL5M1Hhd/3FcnzOm+f0QCF9iBVUx/E/IYjE+jJHfm
	 lVYgszqiKg01PvI3fwExXU2o9QWhuD1YqVCm7fAQt4x5AfXzR0+Ofe7up+7Jw8pIPb
	 VbCir60C24p4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3343660730;
	Tue, 13 Oct 2026 01:53:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8494E1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A95E80C33
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0NoYhAFCvauc for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 01:53:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A92C180BEA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791856428;
 b=rQthI0TAbjWQSuhfT0sBLtzHr0J5KtiQ8HO6aRxOBHpJThwGwIJAnm2H2nuBga/KbH5O
 XvicYvgqu4zUlFPa0YKRxSo6FUYMctsf4v1WMwi3WU6L9Mxe0J/48F8xUZyjxf+DnY120
 uwd0BG+9jEaDeiD9JnUoxnST5NkJPkjCcNKQQckixpxWk9lfnAWzKyXCZNWIgJbm1TZ4w
 tKIKJ32ouVpp86idGxdV+dVg6U7ViMMK7oWRAoPWFK4L+TwqXyaVuWpPqXv9y2Tp/tjvk
 ZiXncMA0avMqu2cd+p/EZePbktkKzyoOrA38AWFrF0ON7lMHYtplUPs3XwmuKZizXmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791856428;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=eg9r2ojAFoYBAyWlHUgAfB/IExsUzAsGpuK5TGL0crI=;
 b=pyK2bTogYCCSuT11rh90wxXSYv7Fw03v7A0fEhHM7kR/o5bjmw5tGK1uuGz94NqR4ByT
 reLhtXWTa4t8nKerHD6yMHgo4Qx+RMG47QditgxEWLPW008Q87ewoL5jvkAmbbjq+jvqx
 nyyhwt3/Uk55mQwNsrzDGHG0/oSSGDxzZ/tvCEIq+SWlvPe3kwS6ofC9rjcTckefiI4Om
 H0PMYgsNXXiWW9oIpnPk4PNfrIKEf7A/RB7P21NWnq94U7Zm8AP8G4j7NqliJaE9WQ+tx
 1sS8HGkDPkbpMvql8/D3Z3l3aYXs+maWsEVZVBk1wTEHTV+TQ5cFiA06d5XWV1A0q9g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NMvB1Psr; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QeqFSBOf; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=NMvB1Psr; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QeqFSBOf
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A92C180BEA
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:48 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMc5mQ498051
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eg9r2ojAFoYBAyWlHUgAfB/IExsUzAsGpuK5TGL0crI=; b=NMvB1PsrbEi2inPq
 lxWVem3DSWUXgyaYLfz2NX40I828xGE6PRSt9drqrpNgxkzZ7TuXRCcvVJDMqdkn
 EuOMZFaKNmAxPg1qqBHFlfUSXy3uK/ajHCOLVL+thRtNqMzonNCP4n6hgYxMhNos
 K6A4zXeOGYeVLCSOfnENxdV81aGyH7LNS8mTPpQxwkjIz3veYaPtyyPqWfUFSo7A
 gjUP1t6dPKXuEnzqFSubNbsHfNKEB6IXhnu2Z2KJBJxMudX43A+5RI4JCxP63HVa
 5l+W3VsnZ9aw/NPzoH2ggbLFzkYD0v7fdeXULoah8TaSgVV28OXPdBx5or1YUrGD
 Qw+JKA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1rgh8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso5013026eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791856426; x=1792461226;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eg9r2ojAFoYBAyWlHUgAfB/IExsUzAsGpuK5TGL0crI=;
 b=QeqFSBOfiYkjxOl1K8QHx3Fg1LbV8a7BRBPvm2fKBWKXmaTobvxSOtZS5mQh2aXKpp
 nRJC0Ms5wc7c3wPe+30A/ymGbCU+LBePifPa7yrhz5fLSn6Z9/KVuHonryJdEFYkMOxs
 xuMj5LsC3a/LyK5l1RJbV3Jis03b8X9oPU6RKmFBAq2WIEprwluP1KgAL2efKG2UiKy/
 m/2qEA7CTa9AIOppKzUcxiQhL4fRoCFL+3zDcY9CQxKZCaABKzjW/TGiohtvQJYEjoy/
 lqKt9PGNPvQmEcB/CHCL6GKYYqPkG1GPj9ryDYobEiVwGaIKxPhxmFQkFkR2hwR5XDEI
 4G5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791856426; x=1792461226;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eg9r2ojAFoYBAyWlHUgAfB/IExsUzAsGpuK5TGL0crI=;
 b=wQy6plJFLjlFKMHajCO/f6QpnsH7pOvN13diIYjxNehAB7wVz1ZXrRSIui1ARCCeDf
 hWTNTA5j05MbRo5TXY/pktNfa64gK4MtubHSpHyxkTUsn8oX42liziG6cj0STKjMhhZp
 n6wMqTt9fHhaGxujN5Sjex3kih8PQfpARRuzlXKMZGR0QdD8SJtNYWTWTpXVtoDNBjyG
 8QI9e+biW7ewDOyTNBW4vtBfKYT+S8MK58gidt1pLoDSMKajVN78ykRy152Mm4y23KQ/
 qkhUIPDxPkdvsxhYmZYrHw5Q70mr6MMqFTOt1s30d1jIBioFse0H6D3wmaH9E8hHont8
 ihEA==
X-Gm-Message-State: AFq9FYIRR1fchUfuUAstFcTwWB60qhauZKPKhxPM1RExyAszQIwSzf1u
 85Kfr2Ep4CzW/CFKGRVUOUezabbHAnsyNAwbWD92eSLlZzq4brlA3/Yj13iVCWOz/AptRzhJu63
 9kvtkfnRnvM7oaN7U7Zf+BrgbTtUVX3nWKc6HeQzh8dUWnGKiHW4o35yGMJeT5hZlXAb6Ovs=
X-Gm-Gg: AYBFou2g/n3CDDdwQVyXhg/xhZhIziLP7y4ozyAMEtIUEWzJLvAHf23POJ3nUHubx8f
 6+BIjZvYi2ZRMdzdizWaRP27nPeTKMdO2O1vZs3wc2yygGvxwhdnOFWDwX+VNrQ2R4UsicX1qCc
 zzoaCnuL0dqi+K5Th7H3V8bJ51QnpyUmqXHNArUzuDWHkPDYR0ANgJfsYG6GTjL6Znj/GM9DdTC
 3fzMNMdKGzruRAnl2BUW/+CJjROcCMX206pMaXQd7k8nuc6lJQh18ga/16WTGgGZRErBCGgQUKF
 OxIbzSzUxDqIOUVZG/Hy/AnjxjprhVRxnstYvXaaEZl+w7+MTfQ6cnIH/fC4DdvkIr7TaSxb297
 ywUWxEZYD6MvD9Tlmon2Tbrl3FMiP99M/wgIzgBnhJvMnUAf/kMSlH0td2pmwzss4VtLAhoV9gZ
 IalxJzc4wnT//RBOz2WLDshN1NK/g=
X-Received: by 2002:a05:7301:241c:b0:358:45f5:daf with SMTP id
 5a478bee46e88-35845f511eemr14041071eec.29.1791856426425; 
 Mon, 12 Oct 2026 18:53:46 -0700 (PDT)
X-Received: by 2002:a05:7301:241c:b0:358:45f5:daf with SMTP id
 5a478bee46e88-35845f511eemr14041030eec.29.1791856425723; 
 Mon, 12 Oct 2026 18:53:45 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb68e56sm34612666eec.29.2026.10.12.18.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 18:53:43 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 07:23:13 +0530
Subject: [PATCH v7 4/8] arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-snagboot-v7-4-fc296a32836a@oss.qualcomm.com>
References: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
In-Reply-To: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791856396; l=2033;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=qLdprNDhOi9V9pcY+jz841++7Y3Y0V/PMAuRJ97cSUQ=;
 b=5k9DGQ9+zPTilecIrTHbsUDRiqQeMQjX1fTeC/KdNHme3XPVBQTXOuBZzxumX8ShyBTsspRH7
 2cFnGKsC1mDDtOjYrwIT6ShB8E1khQW1WwUKMUNPjQ/PFmJTw/h/GaQ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6acd8f2b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ZHSanarjU4c6-wJI9dcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: JXzzr-MntuMkinxnLriiOc7wyh-I8jNm
X-Proofpoint-ORIG-GUID: JXzzr-MntuMkinxnLriiOc7wyh-I8jNm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX4g90C2a0t/jB
 9UfDvLWNJ9PfBciltkpP9q2tpg12MA//rKBZDUJD7teoOKWCfFGcpqeYMCbaCST2Yph7CuQ1Y1K
 a9cuy1UdPB//7WTrIbIJ1vQpDhNHEIo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX7n2WZ61m5in1
 JNQc5P+0gJSdgQH7PCGLMxSn66J0uVE8CdWV4KrOfdb3qabohi6wBQKG4KllrX+uZkQ8qcYgWle
 1E8DyUHDXtCuo4SXDwrCn+H2RhC1syCfevKSg2czF+ZXGz7/6SNUcfz8Be0FJ1t5WNXg4nF3U0w
 bbyHUKgL/wowc5ouAl1QlZBuLzS4LphOt4rXhttInepfYe0JUesQk5NfkpViD030ipbdam5Bkc0
 SYeI62EqST1ueyHS2252N5IfG0KMUazYsapHmGuD0DxFJZfFqgaiuiiesVIsn7eOhyK639UAzq2
 ifROyCvhIxCUk5kBGb/BrPgXRBswu6yBycK+OKUdgfUx0oEnQueXBLpjMihKoaipaSiRMk2XLcj
 ir2RCTq2sX8ai0LjwzLB4ssmtzWQlbtMgtptxnzRbFFOGzQstjfjSjtxvP0rycaksxp6GRvQ8Vw
 l/nmbvs7XkoOpV692wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130007
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

Add CONFIG_QCOM_SNAGBOOT_MODE to enable snagboot mode on Qualcomm
platforms. This config automatically selects the required dependencies.
Express the platform-specific requirements and configs that must be
selected and disabled in snagboot mode.

Add QCOM_BOOT0_SNAGBOOT_MODE as a hidden boot0.h config, selected
automatically by QCOM_SNAGBOOT_MODE. This boot0.h config is for
disabling MMU at the start of U-Boot execution.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes in v5:
- Made QCOM_BOOT0_SNAGBOOT_MODE dependent on QCOM_SNAGBOOT_MODE so
  it is not exposed to users
- Add dependencies for QCOM_SNAGBOOT_MODE explicitly as "depends"

Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Added QCOM_BOOT0_SNAGBOOT_MODE for boot0.h which gets selected by
  QCOM_SNAGBOOT_MODE
- Document the platform-specific requirements and configs that must be
  disabled in snagboot mode.

Changes in v3:
- Newly introduced in v3
---
 arch/arm/mach-snapdragon/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ddded0029ef..237395e1d6a 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -82,4 +82,24 @@ config BOOT0_SDM845_WORKAROUND
 
 endchoice
 
+config QCOM_BOOT0_SNAGBOOT_MODE
+	bool
+	depends on QCOM_SNAGBOOT_MODE
+
+config QCOM_SNAGBOOT_MODE
+	bool "Build U-Boot for Snagboot mode loading"
+	select QCOM_BOOT0_SNAGBOOT_MODE
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	select SKIP_RELOCATE
+	select ENV_IS_NOWHERE
+	depends on !ENV_IS_IN_SCSI
+	depends on !PSCI_RESET
+	depends on !IOMMU
+	depends on !SAVE_PREV_BL_INITRAMFS_START_ADDR
+	depends on COUNTER_FREQUENCY != 0
+	depends on TEXT_BASE != 0
+	help
+	  Build U-Boot to be loaded in Snagboot mode on Qualcomm platforms
+	  for device/factory provisioning using fastboot.
+
 endif

-- 
2.34.1

