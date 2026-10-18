Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72EDCCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 20:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D7F760738;
	Sun, 18 Oct 2026 20:51:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GTlzSX274IVf; Sun, 18 Oct 2026 20:51:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4385F60730
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792356678;
	b=jqJC9elMyKAjNuFNJPHDp8Q3He+XxCsmTbdS3SJnH0PCj5v7/c3iOGYdWJY/N8D5cHav
	 CXSuOZMuPPwZ1R33Sg8y8Uvl1oYI7SbW+pYNgHQrOJ/9/pH7DQ0dRoKFXn8g5vz8GZ3Ph
	 rCk7E6eGjJDbxfwu9J0GKT7oHI8vCrXaTPKupyZPtxdjiiFM79f5fuJNZDbNNQf7bG1Xr
	 daVPgNGa+/CGnKv2o7Ac020XrpkssqSU8O50BsfZP8vv3jlKESZBLgqMRZurdoLR0FfW4
	 dEVc1c5dEl+v8xS2nxMJ+UJiiOCAYBVg43bpvpkYZiuiZM0vVlEKWaxgubPOuLJNmKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792356678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OMSdix9ngV8s27yZSHrcLBZ0vET+NEkq+PaqYivwL3E=;
	b=Xr1ornQx8lEH77jUhgKpKPLFc+jGX/HnUaAwCGnNaj7nWM98hVS3VGsx/PG+yCo+2YFw
	 YQsaqMfw5m6ZC3sG2sqclu12NqGJx7kUmt7sInNlSdsx6yMrbz+2za/YYNExjg7pVoxYU
	 5Mi7lCnP8AKJDXOKuPX3i6WFoRi8QUljHZKmaX6ooox1TEBx8ut7rPDfPLZ0np0+yeRQS
	 B8ryfJvUDMXrpfJq7o6jc1Y734X/AFywWBvaZWdAb+1HBxm+E0UwYyw5ENb+Jy2LJshmf
	 UL/xOvFBaDVzWTYwar+lN4OuD/aGf7dr+P3KwaV0pbF2k1XTFz9EzgzYj7i8/M4vUcw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792356678;
	bh=OMSdix9ngV8s27yZSHrcLBZ0vET+NEkq+PaqYivwL3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xnkEimgkrqgEux/gdWXqxzQ7kTBNwfs0WnDq7G5pmfqS61MizqJiVOzi+OG1cs00k
	 bznLb1R0hwRTQZKZl7SoT3wZ8+ATmW49NqxQhylFOWgatf8zLhWmtMyU4vFJEtSM/J
	 Q8p0Jv1MAjwyIqvoQG4NOdMv1TczPCAa1JQNQdzGR0jSPOnWEyvYX+4JCre4w9D4HS
	 qpfkZ12GJtk0rjSY3Q4hHlXzotoEyVU1t36osCFs6NLe5trfibDVNOaaBdhpJzD9RX
	 3OEiPHS69tjBTAx+OJcHfHJ1sYcEuJPETh8GVrn+Wmp5NHAN+f39n5lAehH4C2xWy/
	 OE1hIm/KiN8+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4385F60730;
	Sun, 18 Oct 2026 20:51:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E82F0769
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CD72E80F59
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y0IBya8IWJf9 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 20:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 87FEB80F58
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792356674;
 b=HNWl25sT9nQf7e5dblOW5UImRXfp++lHg4XtWZ1oH8mcsZaw/aP0KT6SgCliI9CQZ+KC
 Aienzz2412AeH108upzedY0a72djOG2J0qlsxUNCTyUsOEIYN+r4PFEAtXMLXrtYcy+1H
 Hit+jnWL0s7qU5ly9WJREqtWxKNO5BKRUiSc9rCG4l06qME58z+De/0Dyy6J9l5ugwmlR
 auZBBRQJcwAjw3tzX856kpTx7laPRPUPrZG6SQE3ue+lsiGN8HWcitIkj2pCPo8hinZEb
 zYLxqzVDIa0Bf0rUBlDw61N77ODpU8qmMXTbu+RYnUPgua3kx4wThZIAUCMMGGP3U8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792356674;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=OMSdix9ngV8s27yZSHrcLBZ0vET+NEkq+PaqYivwL3E=;
 b=Zv/CDsfyXKFzDR5LbqpJDgLKsTvjiLqWuu1Jmkra7toVjgMRbY97vOvUvI2T+MNbqs9R
 ghZI/pIqtWx8a1P9mFxIPMUZl7AMksCTdNBDMeMOq9YrA9JZC0hATtuCPCdcHcnwP0hjw
 x/sK0Me7STmwAysRe2DsuWOzcJBAhOMIsTzYUfSCkc1fYjb79C6qPZLqBHzLkotoXV/PV
 UouzSDCqBjnTj/XftjWpdUqHAHxAmCa+cBI/OKE1YkoOvfBmkVwImAWETes3GlPvEBk6k
 hWArnfd7cBYXWxr37FqS9p/xsCeFsrKyoDXCyp9cBKvQl1xuTjZi5wXAnPvyNNDtviw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=DWWmDc8e; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fr00m4+3; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=DWWmDc8e; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fr00m4+3
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87FEB80F58
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:14 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69IKBFTK120381
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OMSdix9ngV8
 s27yZSHrcLBZ0vET+NEkq+PaqYivwL3E=; b=DWWmDc8eqGPodRPk4LSOLuGGxzy
 RjmICSBNAeDBLvlZHAUAv7roH3+A5WWbdFSN2ajOVmFiYRpW5oN61SId63eJNrrc
 VhYR1QjikiLc4e0pGxeigJj1IOHMlBUfu9e43VvEKIcE/BwCsatqAf2BvFp2E+R/
 3NQw1y/aM1E8G1Jn/zzZcz7hB6vx/Qe7Y1y/756Z5CPx84U3V9+wyqa8Z3ZA1/sz
 ZWOxaboO4+l6itCXcO3Ffrp976rE6Puk7XthqIrN6XLpwr7mNPPIrrqmmmxrZw1K
 sWejXlJVVlNIehC7uJ0IEYmkl8/t5bA7IbY1nmIz6NtUMsSr+Wejk83pTzQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc1se3t2m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so336245285a.0
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792356673; x=1792961473;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OMSdix9ngV8s27yZSHrcLBZ0vET+NEkq+PaqYivwL3E=;
 b=fr00m4+3tFm9788TjEbSCy1jYh7IDOF2L9efK8d+yl/UxPI9FBQ5hH7J0zOo4L23q7
 I637XPMIDGyhw45vpnoBQb8x8NS7HgUid1ljeVoHiBXGH/VhR27x5BrCqQ3suZwU8kvi
 Lt2DLh4zkvD3JWlhKP6mfpOs8Xwi6L2AuAp1FeSU8cTTObW2ISHmGIvV5uti4Xwwb2x0
 vvjw3v0YaTEcW3YnQRq7nDTmDK+KesRsbWjiVnf/Od492kFgctCretzPE4zUaLmK/crC
 jFDJO0ife1jC8HRO7gKhCfBnK0cGUIpvjV17Qb7A0WjsflcMs2SJXVerK3HH3a11J4oH
 HP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792356673; x=1792961473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OMSdix9ngV8s27yZSHrcLBZ0vET+NEkq+PaqYivwL3E=;
 b=ZSiKzQp5TpGcl4vAobaF71tdCKHFfEFQYPRTQRMEJ0eyQW/gwYTY5lK9hW/La5y+m6
 OWW65vQ5xfQMwwRZE3QAVhYDjQ7zZZYWWb57WGTb8M4El1QVaI1BEX+szmmCc++gYDt/
 QXwlO/SMHPZKRH+RNXHhh2uCZORr1SnJdFBAtXVR57PsNoKL6Mkt8m3Xs9m+ON3vZLEu
 L9pRPoCciEzGG/6vJnPjaTUZ2kOoDBvroA258MllElaQj20W9i8WgXjbULAMXQ+PuYFV
 bnkymYsXNemkdNOKlbgvMW1oZ5bizHV3MYzjHUZ4nH9e64FJcuVFNdt8UYyWoJ0Z2cef
 G3bA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgfc9tNCpXGtEIMxcmh/ef4G8eoydQjr+/OZC8RmNlPPTY9aqvLySz5YYQ1bM9s8kuBM7K75s=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK40hQv5K3VMj1pwYUiwMfCbC0AAD+8mci87uqwrpAkNtQhw4i5
 ESjwL7KAOGdhIdZsYzWU82zvQ7f7Be0w7/Oq4pVjkA8NKyXR8d22rcp+AhEh7hFLHGtV/vAYboX
 x3lGgQHjlFYFqAm9Sdf0cHh1WJQX3C/hmkAGp95kHEArMlnnsZ1YsucUZuUeSb6qN1fTwdP0=
X-Gm-Gg: AYBFou3LVl+0LJLpfSYsMwzpaYQTzDb7vMyPn/Swj8YxXG9yUA4LYY0M40o7iVSCTmd
 5DRb3Db1G7HyH+boI/03//1qeAD1+PgyAiD2vEF/Dly1YAFb7eB13eMdCB2arrvt/yiX8gKqPuK
 8jYGHjK5Ta/2jw5H4TBcmnIXKfPKzawRXss1DUYqLhqoKa4Kl73juXk5smDHSRCopn+X3MXeGeu
 lZnZackSCUGnJbg2794tWkmjsiqopVangTS9aC1AsBBKhaYOA40DvC+XXl/ZjPeZO8OSuxgKPHM
 MP5tDu9zlnpj18pOHSrS0nkK5EBD41beNR9AT5SoftFqD0GDp7fkbdCBfKI0f4HovYmOVjhEb5r
 525mbFLgLd/ucrfgRrpLXKFtSHIIGmDeBvCgUF3UuU3/Q
X-Received: by 2002:a05:620a:2314:10b0:93f:31bb:e3c with SMTP id
 af79cd13be357-93f31bb153bmr455516485a.68.1792356672438; 
 Sun, 18 Oct 2026 13:51:12 -0700 (PDT)
X-Received: by 2002:a05:620a:2314:10b0:93f:31bb:e3c with SMTP id
 af79cd13be357-93f31bb153bmr455513985a.68.1792356671862; 
 Sun, 18 Oct 2026 13:51:11 -0700 (PDT)
Received: from trex (5.red-79-144-193.dynamicip.rima-tde.net. [79.144.193.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d756ce69sm148645925e9.4.2026.10.18.13.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 13:51:11 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, trini@konsulko.com,
 neil.armstrong@linaro.org, ilias.apalodimas@linaro.org,
 jens.wiklander@oss.qualcomm.com, sumit.garg@oss.qualcomm.com,
 dlechner@baylibre.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org
Cc: stanleyjhu@google.com, Macpaul.Lin@mediatek.com,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 3/6] ufs: add RPMB transport over SCSI SECURITY PROTOCOL
Date: Sun, 18 Oct 2026 22:50:53 +0200
Message-ID: <20261018205101.2362593-4-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
References: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pi427swSEqocOD3XTbSqy_GuOG5yLF8Q
X-Authority-Analysis: v=2.4 cv=A4z5rKWG c=1 sm=1 tr=0 ts=6ad53141 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nno+U714v6U58lXnMUU6PQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=VQ2uL-MS0E-bJSoemvUA:9 a=O8hF6Hzn-FEA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: pi427swSEqocOD3XTbSqy_GuOG5yLF8Q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfX7+w1KSi+wjos
 7fi3lcGYGfp2b5fKG/Ew8yFpz7vaXbNCCJ268i0A/g4fjF4EC23bUPWA+WyTzrq5stkS06kQ8XB
 +wc5fUg+uZUJY55diENuJY0gqC1tN2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfX6x6jJtpUqe+H
 /PiCVDqID/mI5BpnUcgzSa/rMb+umxUD+JNvOusule5F7WKUbtPr/y57Udib6w8f0lF8tVG+zUG
 hRqLchpeMj6fH9tIisYMTRcEis9M+tvz6POoUI80SYtr93nYZ0eydaChjQGdOQqEltpkU2/5olW
 5TnxDG/6NfcOJ5k6xbJRn29cc0wkYDToYuD4nBT7ALncVZWfxdZSSq+vXkQghfdM+ahEx0X+6/j
 l3dyebxWxa5ix6fCL2GasXGnpulpvcVkAld8sEGrHcpfFgXUGQvH3zv8hY+upZ9hzT8deqqehzb
 2EFLBTeAp3jQos2Ag1+txn1MP37HtG8HQZ9xisZ3cepGTnGnotGbereIvqK1GoYfxGcvKQGstcB
 gUYRzLdRrBNtTJb/NS0qHY039+llF3WRpvcwbFX2H5Ob0/8Kxzb+gtQhgQnHdjIKulIvFjH6Ha/
 2xvVwsNkvTZq0bhJszA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610180083
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

OP-TEE secure storage (CFG_RPMB_FS) needs RPMB, but on UFS-only platforms
with no eMMC the OP-TEE RPMB supplicant cannot reach the device's RPMB
Well-Known LUN: UFS exposes RPMB through SCSI SECURITY PROTOCOL IN/OUT
rather than an eMMC-style partition. Add that transport so RPMB-backed
secure storage works on UFS platforms.

Reported-by: Stanley Jhu <stanleyjhu@google.com>
Closes: https://lore.kernel.org/u-boot/20260929032920.1391393-1-stanleyjhu@google.com/
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/Kconfig      |  10 +++
 drivers/ufs/Makefile     |   1 +
 drivers/ufs/ufs-rpmb.c   | 186 +++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-uclass.c |   6 +-
 drivers/ufs/ufs.h        |   7 ++
 include/scsi.h           |   2 +
 include/ufs.h            |   4 +
 7 files changed, 213 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ufs/ufs-rpmb.c

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 6dffdc00b32..a0067b1f203 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -92,4 +92,14 @@ config UFS_TI_J721E
 	  This selects the glue layer driver for Cadence controller
 	  present on TI's J721E devices.
 
+config SUPPORT_UFS_RPMB
+	bool "Enable UFS RPMB (Replay Protected Memory Block) support"
+	depends on UFS && OPTEE && !SUPPORT_EMMC_RPMB
+	help
+	  Route OP-TEE RPMB requests to the UFS RPMB Well-Known LUN using
+	  SCSI SECURITY PROTOCOL IN/OUT commands. Required for OP-TEE secure
+	  storage (CFG_RPMB_FS) on UFS-based platforms that have no eMMC.
+	  The OP-TEE supplicant handles a single RPMB transport, so this is
+	  mutually exclusive with the eMMC RPMB supplicant (SUPPORT_EMMC_RPMB).
+
 endmenu
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index e7f3c1d30c4..d60440ca119 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
 obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
 obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
 obj-$(CONFIG_UFS_TI_J721E) += ti-j721e-ufs.o
+obj-$(CONFIG_SUPPORT_UFS_RPMB) += ufs-rpmb.o
diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
new file mode 100644
index 00000000000..97b1c0f82f2
--- /dev/null
+++ b/drivers/ufs/ufs-rpmb.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <scsi.h>
+#include <ufs.h>
+#include <asm/cache.h>
+#include <asm/unaligned.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include "ufs.h"
+
+#define RPMB_REQ_KEY		1
+#define RPMB_REQ_WCOUNTER	2
+#define RPMB_REQ_WRITE_DATA	3
+#define RPMB_REQ_READ_DATA	4
+#define RPMB_REQ_STATUS		5
+
+#define RPMB_FRAME_SIZE		512
+#define RPMB_FRAME_REQ_OFFSET	510
+
+#define UFS_RPMB_UA_RETRIES	3
+
+/* ASC 29h: POWER ON, RESET, OR BUS DEVICE RESET OCCURRED (any ASCQ) */
+#define UFS_RPMB_UA_ASC_POR	0x29
+
+#define SEC_PROTOCOL_UFS		0xEC
+#define UFS_RPMB_SEC_PROTOCOL_ID	0x01
+
+static u8 ufs_rpmb_sense_key(const struct scsi_cmd *pccb)
+{
+	const u8 *sense = pccb->sense_buf;
+
+	if (!pccb->sensedatalen)
+		return SENSE_NO_SENSE;
+
+	/* fixed (0x70/0x71) vs descriptor (0x72/0x73) sense format */
+	if ((sense[0] & 0x7f) == 0x72 || (sense[0] & 0x7f) == 0x73)
+		return sense[1] & 0xf;
+
+	return sense[2] & 0xf;
+}
+
+static u8 ufs_rpmb_sense_asc(const struct scsi_cmd *pccb)
+{
+	const u8 *sense = pccb->sense_buf;
+
+	if (!pccb->sensedatalen)
+		return 0;
+
+	/* fixed (0x70/0x71) vs descriptor (0x72/0x73) sense format */
+	if ((sense[0] & 0x7f) == 0x72 || (sense[0] & 0x7f) == 0x73)
+		return pccb->sensedatalen > 2 ? sense[2] : 0;
+
+	return pccb->sensedatalen > 12 ? sense[12] : 0;
+}
+
+static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
+			    u8 opcode, void *buf, unsigned int nframes,
+			    enum dma_data_direction dir)
+{
+	u16 spsp = (region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
+	u32 len = nframes * RPMB_FRAME_SIZE;
+	struct scsi_cmd pccb;
+	void *dma_buf = buf;
+	void *bounce = NULL;
+	int retries;
+	int ret = 0;
+
+	if (!IS_ALIGNED((uintptr_t)buf, ARCH_DMA_MINALIGN)) {
+		bounce = memalign(ARCH_DMA_MINALIGN,
+				  ALIGN(len, ARCH_DMA_MINALIGN));
+		if (!bounce)
+			return -ENOMEM;
+		dma_buf = bounce;
+		if (dir == DMA_TO_DEVICE)
+			memcpy(bounce, buf, len);
+	}
+
+	memset(&pccb, 0, sizeof(pccb));
+	pccb.lun = UFS_UPIU_RPMB_WLUN;
+	pccb.cmd[0] = opcode;
+	pccb.cmd[1] = SEC_PROTOCOL_UFS;
+	put_unaligned_be16(spsp, &pccb.cmd[2]);
+	pccb.cmd[4] = 0;
+	pccb.cmd[5] = 0;
+	put_unaligned_be32(len, &pccb.cmd[6]);
+	pccb.cmd[10] = 0;
+	pccb.cmd[11] = 0;
+	pccb.cmdlen = 12;
+	pccb.pdata = dma_buf;
+	pccb.datalen = len;
+	pccb.dma_dir = dir;
+
+	for (retries = UFS_RPMB_UA_RETRIES; retries > 0; retries--) {
+		ret = scsi_exec(scsi_dev, &pccb);
+		if (!ret)
+			break;
+
+		/*
+		 * A power-on or reset UNIT ATTENTION (ASC 29h, any ASCQ) is a
+		 * transient condition the device clears once it has been
+		 * reported, so retry it. Any other failure - including other
+		 * UNIT ATTENTION conditions such as 2Ah MODE PARAMETERS CHANGED
+		 * - is final: stop and report it.
+		 */
+		if (ufs_rpmb_sense_key(&pccb) != SENSE_UNIT_ATTENTION ||
+		    ufs_rpmb_sense_asc(&pccb) != UFS_RPMB_UA_ASC_POR)
+			break;
+	}
+
+	if (bounce) {
+		if (!ret && dir == DMA_FROM_DEVICE)
+			memcpy(buf, bounce, len);
+
+		free(bounce);
+	}
+
+	return ret;
+}
+
+static int ufs_rpmb_send(struct udevice *scsi_dev, unsigned int region,
+			 void *frames, unsigned int nframes)
+{
+	return ufs_rpmb_secprot(scsi_dev, region, SCSI_SECURITY_PROTOCOL_OUT,
+				frames, nframes, DMA_TO_DEVICE);
+}
+
+static int ufs_rpmb_recv(struct udevice *scsi_dev, unsigned int region,
+			 void *frames, unsigned int nframes)
+{
+	return ufs_rpmb_secprot(scsi_dev, region, SCSI_SECURITY_PROTOCOL_IN,
+				frames, nframes, DMA_FROM_DEVICE);
+}
+
+int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
+			  void *req, unsigned long reqlen, void *rsp,
+			  unsigned long rsplen)
+{
+	unsigned int n_req = reqlen / RPMB_FRAME_SIZE;
+	unsigned int n_rsp = rsplen / RPMB_FRAME_SIZE;
+	u16 request;
+	int ret;
+
+	if (!scsi_dev || reqlen % RPMB_FRAME_SIZE ||
+	    rsplen % RPMB_FRAME_SIZE || !n_req)
+		return -EINVAL;
+
+	request = get_unaligned_be16((u8 *)req + RPMB_FRAME_REQ_OFFSET);
+
+	switch (request) {
+	case RPMB_REQ_KEY:
+	case RPMB_REQ_WRITE_DATA: {
+		u8 status_frame[RPMB_FRAME_SIZE];
+
+		ret = ufs_rpmb_send(scsi_dev, region, req, n_req);
+		if (ret)
+			return ret;
+
+		memset(status_frame, 0, sizeof(status_frame));
+		put_unaligned_be16(RPMB_REQ_STATUS,
+				   &status_frame[RPMB_FRAME_REQ_OFFSET]);
+		ret = ufs_rpmb_send(scsi_dev, region, status_frame, 1);
+		if (ret)
+			return ret;
+
+		if (n_rsp < 1)
+			return -EINVAL;
+
+		return ufs_rpmb_recv(scsi_dev, region, rsp, 1);
+	}
+	case RPMB_REQ_WCOUNTER:
+	case RPMB_REQ_READ_DATA:
+		ret = ufs_rpmb_send(scsi_dev, region, req, 1);
+		if (ret)
+			return ret;
+
+		if (n_rsp < 1)
+			return -EINVAL;
+
+		return ufs_rpmb_recv(scsi_dev, region, rsp, n_rsp);
+	default:
+		debug("ufs-rpmb: unsupported request 0x%x\n", request);
+		return -EINVAL;
+	}
+}
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 3d96a05281c..2ca4fb2a020 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1458,9 +1458,9 @@ static int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_
  * ufshcd_read_desc_param - read the specified descriptor parameter
  *
  */
-static int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
-				  int desc_index, u8 param_offset,
-				  u8 *param_read_buf, u8 param_size)
+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 param_offset,
+			   u8 *param_read_buf, u8 param_size)
 {
 	int ret;
 	u8 *desc_buf;
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 0f6c93fbce7..9f55735602b 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -10,6 +10,9 @@
 struct udevice;
 
 #define UFS_CDB_SIZE	16
+
+#define UFS_UPIU_RPMB_WLUN		0xC4
+
 #define UPIU_TRANSACTION_UIC_CMD 0x1F
 #define UIC_CMD_SIZE (sizeof(u32) * 4)
 #define RESPONSE_UPIU_SENSE_DATA_LENGTH	18
@@ -809,4 +812,8 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 
 int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
 
+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 param_offset, u8 *param_read_buf,
+			   u8 param_size);
+
 #endif
diff --git a/include/scsi.h b/include/scsi.h
index 93561749b7f..439a7f4fede 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -181,6 +181,8 @@ struct scsi_cmd {
 #define SCSI_WRITE_LONG	0x3F		/* Write Long (O) */
 #define SCSI_WRITE_SAME	0x41		/* Write Same (O) */
 #define SCSI_UNMAP	0x42		/* Write 10-Byte (MANDATORY) */
+#define SCSI_SECURITY_PROTOCOL_IN	0xA2	/* Security Protocol In (O) */
+#define SCSI_SECURITY_PROTOCOL_OUT	0xB5	/* Security Protocol Out (O) */
 
 /**
  * enum scsi_cmd_phase - current phase of the SCSI protocol
diff --git a/include/ufs.h b/include/ufs.h
index f6e27d90e43..1bec3ce73a4 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -20,4 +20,8 @@ int ufs_probe(void);
  */
 int ufs_probe_dev(int index);
 
+int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
+			  void *req, unsigned long reqlen, void *rsp,
+			  unsigned long rsplen);
+
 #endif
-- 
2.54.0

