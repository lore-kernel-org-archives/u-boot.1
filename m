Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A870606A334
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q4FMRzX6;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dbMHAX+Q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LesTMMCk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23E20607BC;
	Sun, 15 Nov 2026 06:27:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8lRiq8LrHk5A; Sun, 15 Nov 2026 06:27:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D02EF6073D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794724028;
	b=rW/TbHP32jbIMmYPYtO+1VX0lLxoxk2f56/ElNy/M9hz+9cspAHVG2hzHfHXitVdNITg
	 LJh/ZaQy2J0C7ZujxfAp8bcOT/wK/5hjK//d06AQ+uOop2XUhKhO+5OvARA3E6fzglAL+
	 cBzTfkQXTrk3XKYT9oYT1InVMB9lPeQwIKLL9KzsKfzic0mkDuA/axXGhwaVuNQ69fhVT
	 Z5LA/BECue1ATiFcF8+fEYv4SXD1Y3SjH7/QsvTq+AwJPxMFEoP61qcuIOyiiTB/vKwc9
	 gvuBEndc5WauGnZs2nEb3j5kRzOuDszqh3c5f9k/xx2M0lUMz23ChKCiADeK9Wo4Zeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794724028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=17N0JLAXi077/D9iqFihA4CMJgO8qBCvE+YvEfXvoQ0=;
	b=CI/sSCgSLwASrDUIgBBfKW8pdxlfZrKQZjwiRLMK0BLJ3UiiGXsv5zewLl+/9FOzTob5
	 zH0tt21G/s0OCCRngVRRScomzBKxWWacTvSKhewkp/F+LfPqjGwy295gwW7WCJax/GaF9
	 WnFHfy9NquQ5Sh2uKvs1a6D1p0HXzPwq4zctVdpbfwDK11ncNr6FpTHFkDxxRd7dFkQOI
	 g4HybrkhDrTt1dBhpZD10UyevFR4FF5rR3FFbvy7OISUZ18mco0byvUrhdb54IdFwhZOp
	 3/tf67iankWVZDDVQEjr7HoYkyPj9ztatFoEsph3923HR8QFxl12+QPmgD2UN8kZzTg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794724028;
	bh=17N0JLAXi077/D9iqFihA4CMJgO8qBCvE+YvEfXvoQ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q4FMRzX6KXrp3328nQmu6htvFhSqDFTAPx1dtMM/CJFoxJN+HiiJuhtgXxZUNFdeJ
	 /zztLNeDCMzTogt2VKw/Znx/Mq9azhBgVkraFYjeGP8IDoRi4cZqi0bOKlsAyUQeR3
	 nOyB3gEYNuwt0T7h2bYsDJUUE84QfFgUfxC0QiK7QCyOxbUD8p7h8qaws8cDbZElYC
	 Qd4/aCVsvGB8OJdWafVb4epGhOrZy1r9ugKhgScCwqYYQqkiJqsCDKRGJR+vsylH1L
	 6pyy+uXomidTXTJy7ABumDXhx3BXsv1dv6hJbd/o01J0dgk8F6WCEfOA+OaqfaEF9j
	 n41YhC+/CWrqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D02EF6073D;
	Sun, 15 Nov 2026 06:27:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AF1DFD7
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95DF181099
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:27:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vEKCgyHGEoHl for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 06:27:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0AADE81096
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=dbMHAX+Q; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LesTMMCk
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AADE81096
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:27:05 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4THqf1234881
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 17N0JLAXi077/D9iqFihA4CMJgO8qBCvE+YvEfXvoQ0=; b=dbMHAX+Qdnsjlgjs
 2+auufM9GT6634VPh0f4AuCRPh9Yo7aUoRj6EnNVz8jlovv4Sk6Uap847IdjV6dU
 5yjFuVlwvKsTMuH8BO+P6mzZF1YylEdjkgZE2B7+gXEAk3WaLLqneJohzAV0etYF
 yIxSA14Qxg0zEQtiZpSaxtIcpGcwpnAO8TWsrFLmDhUrXWDTJFNIs/veCqlRguha
 CQB+diwckM7uPO9qGAm8YW7KStJsZKxi6Hgq0VItz2RRrGYbmAOXtCBXYp7FvIn3
 uRHRW8nBZTtFYENLTIJl6nzXauaBCpDNG7TN98FQYeCBCNHslU+rksfA4GpSXnv5
 279SYg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhkwabjk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:27:05 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so2842102c88.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 22:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794724024; x=1795328824;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=17N0JLAXi077/D9iqFihA4CMJgO8qBCvE+YvEfXvoQ0=;
 b=LesTMMCk8XeDuPrjfJkTc26vojCjvL44iWmsysjFUiPG6ukNZb3ZXiMGAUcQxRv+Qe
 xW82jF3AR90DiDfKLPCyhsnXDRvK4KD43M2C/cPUUfXPV+2+nnAERMfi70rdHCi/n+1w
 uK3pLkh2MAc9Lf4PrSm0Z54JAVOgog3fDuVGJRGG8ljKMn1vhhGHgzILxpqI9C0BQW3S
 2IcdtkhwdPuuMzcPv6MA3hxFvi7z63aZ6186lE0o0LCNfyeeiG0nWOY0FUl3kH/t307W
 uxR+aHq8e4ICHGAeAPsZFGwlBhc7tFKre2+BpRbQArHpymbok96/vqaexdFcNwPvTYjN
 hgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794724024; x=1795328824;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=17N0JLAXi077/D9iqFihA4CMJgO8qBCvE+YvEfXvoQ0=;
 b=Jz/n3o0W+IWbSKEY5Fr4Xb+s9MShgGjvlo2sVFNWhvFU9alXos6TztbpgtbESEfWKH
 SRFJCz+mqJbOaF4nM76Pc0QdpEGj3lTxQiMvDT5KnMQ5MARtsHh8xpry7BsQ0Zn5EU1b
 QX0e6eQcmtxbYL1tPhlIVvGuXQTDxh99V6xZISsCwLxX9NhbwaI6lpvTLVzD/BGiQy5w
 Tyh5OCQzmlxrXnsXu+BdOhS6TF9xoTdVpPrLJTfcQyPSAEpKVOgst3eSlMgRBTVu3DXU
 yt8JrQEp4MPRpUoRt6Lgs6ugSdvGBYt/5Tc8b/aemmg5XMr02gz7v5VQAMbPMMu7R7jy
 FN8A==
X-Gm-Message-State: APuU4Z8OG8jQVc2wzb7PVJcu9VoavVfgLAu/L7GCCU7OnnMKQRaRa2Mh
 NU53a/mMsQkLt33RvVecwNsd/vrxlB0hq6lB7TrXTjMPqLBLGoV5htvtVOrFGV644Z4BA9RXIod
 OOVLXAr0uzLYQzP4IHDuAmN4dwcX5qvaMic4Fu+fa+CjVtKDIdNPJ0SThiFww9zPA6dltVbs=
X-Gm-Gg: AYBFou1rWzF9MJ6hhXOtHns081sABQanRPADaKN6hZ+wFM8b35hoU7Z36uv7pjIH/y0
 BIMp0PsU0h9I/yBS7Srn28oM9aPyZpTwlgp2WgDygrIs3uwWKd+LuMyGR2IpXVQehi5wpDwZaaC
 tQHHBNXmPvUOjlnf9AGwlnoPbHrCpPsmudn3Y7VZ1bzAgXicQLV5rQgVBiCg+D4ScbhiRvhTwLZ
 7mOfO82J8ZoCxFBrPULv5k2AxtMk4rV+LwKo4b2uS0sEQGqxW60w2hdIRBtgzkdWDH+1ZsNJ6PC
 jqKNgJveJkIGl+ERWyTEs7MTL4eT3QuC5IoqpITkLFO10i8hnCvbUSs0LuyOD1DJYXLWJnm/+RS
 qcWNwpTrlxFUZTQyDOmEie2nHAJ77oBnSF1Tox2vOBClfLnfLk5dxCanx26WW1tt8DDsziZxn/N
 qd2ZbY3OdKYAgiaOyxrp7lPVcGhJbHxD4AhPCPloq9hqvqyUo4GPwXxqhrGiJlOg/+GTytcIzaB
 XId
X-Received: by 2002:a05:7022:c44:b0:1b2:558a:d777 with SMTP id
 a92af1059eb24-1b50302b6e4mr6462544c88.2.1794724024072; 
 Sat, 14 Nov 2026 22:27:04 -0800 (PST)
X-Received: by 2002:a05:7022:c44:b0:1b2:558a:d777 with SMTP id
 a92af1059eb24-1b50302b6e4mr6462520c88.2.1794724023375; 
 Sat, 14 Nov 2026 22:27:03 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm22324099c88.14.2026.11.14.22.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:27:03 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 11:56:09 +0530
Subject: [PATCH v5 7/8] configs: Enable partition type GUID for
 QCS9100/QCM6490 boards
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-type-v5-7-79e76209457b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794723969; l=1987;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=61v3Xl4rqi5M/329e4pSbjA6ZXeome9Wfp+cOXMdtRw=;
 b=F6qa7HLss8pOA/xqP9VzKdJRjC3dltzJj4GVS47wTcGM0nUoX4fu+WV/IADFydj7PKDBwVKAu
 BA2esmNjb1EDpAC6qx3T0dqzYfkaT7YMHl1bqMTTWEiDJwiR2ZkD1UL
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfXzzPETXwS6DpV
 /xhjTdZtbTxiGViasgBSHCJ+y1xrd+tIjfkPPpdwRZoF2xgaSqx9pagnU2ouPI9VeXEm2uw5r+8
 04Q5Yq2bQv40S/2BJpU9nbEZFZEHL8hXr6Q7zRmXvBWEdqTHTdB5yFU42/rCDb+YnvaOD6R/1iL
 5WpeGYRu/1mBfERsIyKlPu7/6FVgUPVOGyI5mg8baM1iYUoXktIGPhlXgbpoV0mQ8eSmFRLrDWB
 DeO5C9fITvdjU8YST9oqjHzL28RNXW5CC6jsJSF7Txaf4IArnWjkHWFzc6iLRvHsRjBsVgdCS+U
 sGCzSWguKCBivkkQ+5Ax4WWNR5S/cGC54nEzoKodLnLyjHktihr0T/04vPU7AGCFhQhDOPrQS23
 RXNvF+/OEmFcgN56Sw2dMEl3jTPzf/+luELBSPL7h9E2rvJ8NQOIdMBtW9+h9kH5IFpkLjAQad1
 IAsseUW1PZn9T5/aKgA==
X-Authority-Analysis: v=2.4 cv=YPYKWhGx c=1 sm=1 tr=0 ts=6af950b9 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=44I8hTpN6W2nDu0vvmUA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: UrhhAR1TqbKzug6cZNJ2F60PRNM4iMsm
X-Proofpoint-ORIG-GUID: UrhhAR1TqbKzug6cZNJ2F60PRNM4iMsm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAyNSBTYWx0ZWRfXy4bUI41aZGdv
 w034wNGOkt+7N9vGeK5Rl6UhmRYSCr+QARw+hsEmEq7QnpZe64309laShsuYbOPm1gbXhDzGTIL
 0nPOzkY8Uw2x48ho4SGfQrueMVucxiw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Locate the SCSI environment partition on QCS9100 and QCM6490 by its
GPT type GUID instead of a per-device unique UUID. The type GUID is
that of the logfs partition.

QCM6490 did not store its environment before, so also enable
ENV_IS_IN_SCSI there.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- Drop QCS615, which now stores its environment in the eMMC logfs
  partition and has SCSI disabled
- Name the logfs partition in the commit message

Changes in v4:
- Add type guid configs to QCS9100 defconfig

Changes in v3:
- No changes

Changes in v2:
- Enable above new config in qcom_qcs615_defconfig and qcm6490_defconfig
---
 configs/qcm6490_defconfig      | 4 ++++
 configs/qcom_qcs9100_defconfig | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 7e7739c9d73..17eda8e2e1e 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -20,3 +20,7 @@ CONFIG_PHY_QCOM_QMP_COMBO=y
 CONFIG_FASTBOOT_FLASH_BLOCK=y
 CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
 CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0
+
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
+CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
index 342f128726d..7c509f78a57 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_qcs9100_defconfig
@@ -12,7 +12,8 @@ CONFIG_QCOM_GENERATE_MBN=y
 CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
 CONFIG_ENV_IS_IN_SCSI=y
-CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
+CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
+CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
 # CONFIG_ENV_IS_DEFAULT is not set
 # CONFIG_ENV_IS_NOWHERE is not set
 

-- 
2.34.1

