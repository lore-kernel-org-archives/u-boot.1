Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BF0C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 08:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 504A082D21;
	Mon,  7 Apr 2025 10:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="APNIVj6N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92BBC82D0C; Mon,  7 Apr 2025 10:19:41 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7209E82CF8
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 10:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53767hQH016249
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 08:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MgvuP4MCoM1
 PTVmmRLnweQEjtPrj4b6nxP0BCNptroM=; b=APNIVj6NNKX80gX4dY9nchQCul3
 9Sdjy8Ne5byDVTpxmzDQMjmITOe7pKNPGO3DP9npr6wvhK3NO4Ki9fdjpAmum+PR
 Qi7Th+G8RQ0hP1vn7GxtrSBmV7R7IW1T8Pj0CYcdEUJlFyEvMwEgmg2Rn/NFmaqx
 21XVrywzP5m2N04XCXVQkV5/tjBEVorMVdKQeaM/x8R8UeZDPutCJi+ItwhE8jyT
 BFFd1XxoDu7uZWdrMOHr7CMhIUsRPzAzHJEoA8yQbf05FYoAHNHQjqriOzMsA05o
 SRGXgiCVzcGySZDf37Lntg9yfQ0+oqfb4dNkS1uwus84GVcOfizJE8dMe8A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcyuevv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:19:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5ac559cbaso802034685a.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 01:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744013977; x=1744618777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MgvuP4MCoM1PTVmmRLnweQEjtPrj4b6nxP0BCNptroM=;
 b=BOFeMqYQgJ/dmLLKaDGu092qEtBR/hJ5EB0ArnGPV5nNfjP21ZtQ0CKTQtrn/1XXHk
 Oj8k9jH4DAZob6YI+S9XngAswI6eK1n3znQGEQ6ffNjk/tpkM7unzwuyehGIyI920hlY
 tmNBHxVvfj36k0MVtTaYAbRP6+FynRAIItRwuipj3zH1KpeuYGLgNQ4HQ9vIbGF0vHoE
 e+dTuiCmmQr2pZgfYqV+P+VG/xpc321c8cnpGZpdul5NtKDt2XKmeZ4zdW9vjVFzJfmy
 Evo+O54aKAS1Bvf2qWsnUVk7LC00WqNy9SYEzeAxcjGlEUjgkkOk5o414X6/ZUS79zPt
 QEgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4CJZg5SEiRecpXzzNBXtwDeQUfGjaQ2SPoZSMsj+cA0/Epg+W+bFmktOmtT/3IUnbrvF65zA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2T3I7mOAkfoha327VgJKJs/pTiY7ZVy+iUzcDPkRile48kDez
 c62kJ+Oka61/cHPUCjT6w61YJcF6Ue1BnQgDwE+9r05Vr3ypl050r6/27WTbcaF2CFJ/sWymWLj
 oTWKmfMt5GNqkTeO03dUWwu2MA0xVSuAbqhpibvKSzQkEy3Qe8SfH
X-Gm-Gg: ASbGncvQSE/I5IWd8WiwfUeUTVzxQVmZ02ha3yKkJEe7urp2woyDv7FNCN7oSLBz0d3
 +qphv37rHuGVPSGTUmEVFg5Q19YjLgFKX/B5BEmHt2jMLqoKX3+jmXdM6nyCHbdhCXfaOmM60f3
 R2UjvQD8O6FCEvVtgIJJElGj2KHg7Ns4a+2eroNDJc4DOezH8ZU2tKg9VFT2Nt7oZphTEe4Ywnj
 dkpPEvivea5nX6Huf/6jfvKwGz+ohDDjbuH3HIYu6+y1ezDXeRUjwVMa7543KnHH/8dr2Dlm1bX
 nUAu9uDVzDkR/x8un7ZpubBw7mhhOC9Dpiddjrq42Sd0nnjpPVme+iH0KhI0bX89yykpmw==
X-Received: by 2002:a05:620a:1a95:b0:7c5:4750:9302 with SMTP id
 af79cd13be357-7c77dda51d9mr987957385a.34.1744013977309; 
 Mon, 07 Apr 2025 01:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmUQ0b7JG2bp6HnRPnXRVLqe032NoWNOxF7xBG70aGNG/wF1nzrsLpnBwRNxQcLJ1XT0jBAA==
X-Received: by 2002:a05:620a:1a95:b0:7c5:4750:9302 with SMTP id
 af79cd13be357-7c77dda51d9mr987955985a.34.1744013976916; 
 Mon, 07 Apr 2025 01:19:36 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169b4e4sm125815155e9.20.2025.04.07.01.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 01:19:36 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 4/7] clk/qcom: apq8096: fix the sdhci clock
Date: Mon,  7 Apr 2025 10:19:24 +0200
Message-Id: <20250407081927.138915-5-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lk61FTpTc_jjh4SGjinjvLIsvoWVKB3t
X-Authority-Analysis: v=2.4 cv=Q4vS452a c=1 sm=1 tr=0 ts=67f38a9a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=6QLEz_f4mGzVno9vzIgA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: lk61FTpTc_jjh4SGjinjvLIsvoWVKB3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070058
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Select the right clock for sdhci.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-apq8096.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index bc00826a5e8..551f52d5197 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -83,7 +83,7 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
-	case GCC_SDCC1_APPS_CLK: /* SDC1 */
+	case GCC_SDCC2_APPS_CLK: /* SDC2 */
 		return clk_init_sdc(priv, rate);
 		break;
 	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
-- 
2.34.1

