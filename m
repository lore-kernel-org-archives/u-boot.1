Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C77606A32C
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IKA9xa2G;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lWfv5PLU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bnKPDpD6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E57796064C;
	Sun, 15 Nov 2026 06:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A5eGEXA4StyE; Sun, 15 Nov 2026 06:26:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 301C2606C6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794723996;
	b=eyHENy5qM8FIOVB4uBsHcwTCWYzUk9w/ScHT7+f/TQ+CllktgdTgCiLFYt6Efuibj3Zf
	 W67ygdLKz2VK8Gkx43dCj3/29Bnz+OuO6fK0srHHygtvmUQNhP7tnZaPhB6PKt3di0ct/
	 GneiDwCsI6pgYj0U4uk7tYi9qVl3Rhms1gv4cDyvWxovzQjPxTL/L0X2cYfZ9QWgi5hMr
	 4/Np/ZCrOgr4myRx3xcSk0DuTo3wX08pr/GZUHWEqWSCT6v4gL3rWKrwc0NiuaRPV0t08
	 NEP5RyBjQ6ngaYHGeT2foY+s8/7bxVU5yuNMKHdYn6gVLMxES6a2Bmgkoet3uAbex1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794723996;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bcjMDWqlGzQbxWwUPQcHSPkz9BRS7Yy4Le/3DJ/2cwQ=;
	b=cfInV0PXk3LgP09vnGsomwkbxl8wiN8/T69n7imtzJ6SiiuBzRVYENJzfARGgqsyw4iw
	 SAfffjt/WCqzivS80inY4m8H3V0IyHs13jgV5sdTLTrI41sXWBmAH79OzLb33PUJOd+Xu
	 5/wQ7fgX6NkAkBTEEnuefLhShZoErVytt8GnUdhkKI2kP0kNArnXCnz6o0l0QaeOu2zEF
	 +wLn17oGG2KNqjrkuCN+kk8MZW2LbMC2xCIVBywSJtRYzcQEcA8Rla/cWtaRSO8h4Wb+c
	 eDzI4/evsPZXG66JPv/JxmXyApPHGEYzebRU95Byloz5oRCil3IxXmxOujAqgbzcbFw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794723996;
	bh=bcjMDWqlGzQbxWwUPQcHSPkz9BRS7Yy4Le/3DJ/2cwQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IKA9xa2G/3lPwLbANwk9dxD5fvcAXU7TphOUMmvPE5dFqBhNPaiaFO7qjTqP2ONVy
	 zInsPUxhKHcsO38lP+WrWZcZE4Zfr7VegibFz+S4w/T4/St8ezxJvYrZwMzU14vwmD
	 iS/WTFL5W3a7h54CtIuTdLrkg58Wm0s/Fr0RHL6dXsjCCjXpNZEFxiLQ9LYYHo7qdq
	 EMveFP/MC+W26FLmEvnkNj6V2vXMtbAGFaK8FTQtutTk1ADdC9i+h23NkQFDxV+jF8
	 75fESD3bwJfwuzpdE/i3sTo51dF1o57UGYnlv26ry3dKatOWI+H41xlwSRSD9rNvnv
	 TR46fjKsWaWww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 301C2606C6;
	Sun, 15 Nov 2026 06:26:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 16926109
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F14DF406DA
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ZVUWjpQGySS for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 06:26:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5CAF8406D9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=lWfv5PLU; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bnKPDpD6
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5CAF8406D9
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:31 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4S8Mw772012
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bcjMDWqlGzQbxWwUPQcHSPkz9BRS7Yy4Le/3DJ/2cwQ=; b=lWfv5PLUmkA22q+6
 APPZJFZWBGgXI7MX2n4VIlfdUwHRrNXuSjbMJ0X3lV3qvTrPd1Evj9e4fSLQyrLR
 z5hK96vFJ44B3N4NEza2ZFJtqOXFBoVMr/2/AG1YKknviKXgDG9u0ggn6f90rWkS
 SpMBf+2/+scKNj2KC8CNN1TEc3MJuHHgYAW3gDQe8RM+K3KCXtpI0gPf3tjq8riT
 8y7fhUMKOKzN5PvmmuYEsrBj+Ok7v6fkuDn1+WTGIp3G1bFwVnQijq/jBH34yI4d
 1RcHvhfGIhJH1JuaenL7ppwvS7tQrX23YW85Ricjo3Vxx7jYYJBX41br+XQrauxt
 mlX5Lg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmhjcu2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:26:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3724667bc16so1558808eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 22:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794723990; x=1795328790;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bcjMDWqlGzQbxWwUPQcHSPkz9BRS7Yy4Le/3DJ/2cwQ=;
 b=bnKPDpD6h+qfFhvUSeA+OqKC0yememoZcd01Fzf69KlQIabPNOAk95iT+Lap/U81P0
 Yb9liqAWcU72rjgeRgWOQw42CRun9RC4f5+gms17YCklI24qjzPmwjGS4mlKN3j6fI/k
 1xFwCn6Py5ibLX0w/YVVKFYdOoS4kO/RzUf/zAhLF3l7QbC/rvRAiCkWTAc3G3wSKL/Z
 srpQuFcxh5LKwGH01+8hbKkQn1K5UiTDLPoPXWbTZktOntsheVYrs4C2fTzlPH1UQ3eu
 HC0YHuLU+FRrH+6kslk5kkoZm/5nPEstrUxdP71zYiwruClAv9ivN2jkjO7pi8ufCFsj
 ng1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794723990; x=1795328790;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bcjMDWqlGzQbxWwUPQcHSPkz9BRS7Yy4Le/3DJ/2cwQ=;
 b=l2Jw7siHVFQFX9vskxWqyX4+hhJ/OWPwnWOWFsA/b2cqkrmuPRWVxRAWU7DUYJ0PuT
 p5RcqwueD38IeYEJQdKmdZOFPd3OZjPZ6U6/DC9LBpmn2nvU/Lm1k4YH+cSOFJ2c9X0I
 zrfJgroVJTLWc4MlItHJaXFJGUBwORz5aLbp5mYm8+qv0plnPjjxkQ4ZFN2UbgKz5L/v
 pja61eMSsQIR9wL5ru2S1g+m/97bcXnKhoPc+Xg20inHQbL15CUzQyN/NwHDHr6XMCwW
 Vl+kEvVj4wtg2L/0QjLejBp3SJ4VSnLzRXR55kSfN0+aGvNzYS3L3FDWiLWaBhIWSJt1
 EtRg==
X-Gm-Message-State: APuU4Z8GQQ1eWDkpn05n435NLxfYtBk69Pw3c6ZBaomaR2YdHN/aae2F
 GopXUAD8Zy0BCVtjo3rhj3K3zwEJ0g6ktZdTZXpVnqft930AUq3kUkyTi+MULje4E5nHz7opdWi
 B4X01A7BspmzgC3Tw/dU98zz5C5BBa7eM6JvILsvCG035jEWn+Tfpl3VtFPIMPzc9qHowCSY=
X-Gm-Gg: AYBFou2Q//eosUf6Id6EDLHBUY9/Vlee+zVbW/N2y6ZGKqizN35O0ch0QqFXCDwdEXD
 h0Pc/fe2TakzSgcpb1EY+M1hO8VKcfbgCpZTp26gCrVM9pvL0nSsz143YlHig+4ioE3KHMLpbMA
 26a4jsRzY8/DGQLulLXCAOIg5ufS+RmzHf45VKnD94KgoqYNpJH3oXeEXByxKoH7UJoxSybNUap
 9JgDBUFYNONPqPt7vNwttkVkdR55ENz/Pr8GpnIQDz0crXyoowQCkIrbuGZzmW1m+ncPxuKO3H1
 WZHMlufEtVal7uXWYkDlIU0VlI+gN0TQ9yRdUI3kRNfM87Qk8fMWlGooccxkaYWn1VnjMYLQLdD
 Aztmb3iVRznKwfXqHfcAycquZMiJVaAjYAuHwCdkJEGWTK5o2FEpf3D+2Sf/IHJpuhhPIwjuD96
 yVBfyYirVCpRabBOQ7qqMEiRIj2oR69W3sPgDGv4tC6SD86UhXT/5YxTbZSY5B6qFG4okCLVtsN
 sRM
X-Received: by 2002:a05:7301:4104:b0:36d:dcdb:70c5 with SMTP id
 5a478bee46e88-377e15f06femr14063030eec.20.1794723990498; 
 Sat, 14 Nov 2026 22:26:30 -0800 (PST)
X-Received: by 2002:a05:7301:4104:b0:36d:dcdb:70c5 with SMTP id
 5a478bee46e88-377e15f06femr14062995eec.20.1794723990001; 
 Sat, 14 Nov 2026 22:26:30 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm22324099c88.14.2026.11.14.22.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:26:29 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 11:56:04 +0530
Subject: [PATCH v5 2/8] scsi: Add partition lookup by type GUID for SCSI
 devices
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-type-v5-2-79e76209457b@oss.qualcomm.com>
References: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
In-Reply-To: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Denis Mukhin <dmukhin@ford.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Carlo Caione <ccaione@baylibre.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Fiona Klute <fiona.klute@gmx.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794723969; l=2480;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=y5/6jtEZsHPAjFZqUvhNYxdZcLAIlzu9MqzzJgZEfDg=;
 b=f8WUswoXsP89sz+qcO7hJ8gQTOwq9QxiArwT4E/TLh+NmwVAIXkkBEhSE1GWZRaa2NxrnHRy7
 saJKEvww+/5DBQZxXkKe5KrYbgh5xBz09Z+7UOrJaiE6eNC39ThV7T1
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: JFdI2ReVyvkIr2CqKTJ_9Bg6Zm3UTPVJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfX/ox+R+3GIG6e
 d88Zv6QCT2IqFrYsipWfAI2r+emIp5QGvWJlRnfetwrw6hlOdE3oJx8JAOY29qSV6/TneXjN3PR
 9d7YJfsC9002PkApyPUClDieeBdIpck=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfXwLCjOf2yrc3a
 g5Aprj1/LIYfmdGlm9o4DMAipj5PMZQt+aFXPhWlvAnNblVkdTLJEHsk8R6NgeN9rVrTbKty5/6
 RAQvTRXZKBjGWD68i0nOZEpRBxqAISOzc+3p3wmsNHhoQdHtrsHTNQEkisys+1KrQHAVjPZpY/m
 v2Zx7Y0RMLbrAWhVtNy9gMT6llhBrNija61nbl4wQtdXIesmhdPllia9HEBYMULQ10x7sveK3I9
 Lb/fo2IqEAU/9KKwSs7e4rJjB+obtxSkx7TCtuvHN3M0H+rSPNnJZAmddxKUNW3UNMzlM2YHFK8
 zV52dLlrJjqt4hzAtfdD2kkgXM2kX+QU1Y/MVmMpiPa4TC8SARtRMMrFhRhZ6b0cEWVu3DCyb5h
 wUe/mKzOawxEhf5lcl8J/ON9pdcPnQczQZoElIjDSatWBGqZXf5+RYlIBeCHT4p4CqiDkslvCV/
 MPthswR7ybOvHWOo0vQ==
X-Authority-Analysis: v=2.4 cv=e/2T2qp/ c=1 sm=1 tr=0 ts=6af95097 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=4Z9OGKtuVjyKH-hDXNMA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: JFdI2ReVyvkIr2CqKTJ_9Bg6Zm3UTPVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150025
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

Introduce scsi_get_blk_by_type_guid() function to enable SCSI
partition discovery using partition type GUID. This function scans
all available SCSI devices and searches for a partition matching the
specified type GUID.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Kept only scsi_get_blk_by_type_guid related changes
- Removed scsi_get_blk_by_uuid changes

Changes in v3:
- No changes

Changes in v2:
- Compute blk_find_max_devnum(UCLASS_SCSI) only once in scsi_get_blk_by_type_guid()
---
 drivers/scsi/scsi-uclass.c | 23 +++++++++++++++++++++++
 include/scsi.h             | 11 +++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index 39b4c7476d4..cea6d771f7c 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -47,6 +47,29 @@ int scsi_get_blk_by_uuid(const char *uuid,
 	return -ENODEV;
 }
 
+int scsi_get_blk_by_type_guid(const char *type_guid,
+			      struct blk_desc **blk_desc_ptr,
+			      struct disk_partition *part_info_ptr)
+{
+	struct blk_desc *blk;
+	int i, ret, max;
+
+	max = blk_find_max_devnum(UCLASS_SCSI) + 1;
+	for (i = 0; i < max; i++) {
+		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
+		if (ret)
+			continue;
+
+		ret = part_get_info_by_type_guid(blk, type_guid, part_info_ptr);
+		if (ret > 0) {
+			*blk_desc_ptr = blk;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 int scsi_bus_reset(struct udevice *dev)
 {
 	struct scsi_ops *ops = scsi_get_ops(dev);
diff --git a/include/scsi.h b/include/scsi.h
index 17db9707f4a..99b2288e181 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -374,6 +374,17 @@ int scsi_scan_dev(struct udevice *dev, bool verbose);
 int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
 			 struct disk_partition *part_info_ptr);
 
+/**
+ * scsi_get_blk_by_type_guid() - Provides SCSI partition information by type GUID.
+ *
+ * @type_guid:		Type GUID of the partition for fetching its info
+ * @blk_desc_ptr:	Provides the blk descriptor
+ * @part_info_ptr:	Provides partition info
+ * Return: 0 if OK, -ve on error
+ */
+int scsi_get_blk_by_type_guid(const char *type_guid, struct blk_desc **blk_desc_ptr,
+			      struct disk_partition *part_info_ptr);
+
 #define SCSI_IDENTIFY					0xC0  /* not used */
 
 /* Hardware errors  */

-- 
2.34.1

