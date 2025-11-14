Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D9BCDE014
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 06:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD3283FFC;
	Fri, 14 Nov 2025 07:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n1J2OP0S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GxYUOC8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45EAF83EC8; Fri, 14 Nov 2025 07:38:23 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2608883FDB
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 07:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AE41JqP2263228
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZzeBwypfOWe
 XqLYIFAyX/R7FDbso9feaDvX18F4sN5I=; b=n1J2OP0SIAtPPvTM4sTAacvFHcc
 pu0+Q6WL6kKzUpW3bJnTosKnWcheuYzS6W9pKp5GffLPfYREKZ2qM46LV8ABgiRd
 LWS15mWAJJBEjszt9KOkE4/2nJ8X8oJMLyRFMotWU5c7uI2yfy8ubIyDSquoYLgm
 vw0JdT293MODPbHXIqlnslKcit7oLZdEn+S4RW75SrJG/eLBTzD6S20wALsi7xo9
 Hvt3Xj7aklsUhSfQ+bJzmw0xGwmYXZfRbktQLzYWcGOGx8J1W3aNIzZMmBsDXr5D
 8MPo1sdbbXREc9Z8BVeU+dGSn/W559kJDaXNirbiecGJap4DnaILOwP4ssg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adw1j0bq1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:38:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-343bf6ded5cso3919449a91.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 22:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763102299; x=1763707099; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZzeBwypfOWeXqLYIFAyX/R7FDbso9feaDvX18F4sN5I=;
 b=GxYUOC8r4GQVsMvjnQaMaRSD2jHy1GsQXysDye2gA153upBbk/CG33EIKPQqM1tXdb
 gP2dIMRAgTTC3DE8wM2NE87mY1BHZPQyNivfMe7YCGpnSJtu7tsj5ofce7Asm+gPD4aR
 WyBr2q7qpDFg3Lae7cPVZkgWd9SyepVZ861RdAOlOlHjx2BIRRVjMWxN3fXB74tYOJxu
 BMFTSXSwCtieMa8QXzWWnvLVMR28z7tbuDfZSJDYPvJp0mSbN+4thmakqBh7TlWycyRW
 u4ix6b/crHc1jjdPLhh0m8uuimd9Lk51C9x/+FTwJ2MixC61Sf2VnQaLNhgdA0z6ObTT
 BqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763102299; x=1763707099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZzeBwypfOWeXqLYIFAyX/R7FDbso9feaDvX18F4sN5I=;
 b=RkHEDggqVFkkhQDQz3m3ZA5VhF/yXeT6aJa4f4qZ8lFFPTG5FOvrUh1FEPnSuDCJyS
 ry4QYYZTpLXk47muUarV4BpaWXTjVzfkKIGNsCvk5453gLYKC/v6KO6vyNgj5/rtbczA
 /5OHojfwSzWl9v3xhEC6aFQyx2jEfPARGnXpS1d8e68JvM/Kcq4Opio60rVs5afSPa7K
 oztbZu3zgI9HP/sghXRG/+zVVDwle8jv20viLrkt3KfoDTunJGykSFNIrXxbbk08JmFq
 V2HQMl7sVxEGAzQ3U6sEnBVj3jlVm4rSH454yu6grT+4F9nczsETns5//UpGcs/ANNIy
 EzXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvsNWdfFGlNIRjJxru35Z19gkTV42uBUvab/VQtooedaAS01kRm5+5NbNenjZ/lGN6vEVEemA=@lists.denx.de
X-Gm-Message-State: AOJu0YyI3rjvaKjUS5O/CrNK7/zXANz7+nHkqtixKcqJkG0y4alz1WQQ
 wyEfBRvc3UdoyuqAdcJ1uH3ou0/13os54wo+zvVzFwLqkFrBPNQTbZykixscZp/Z/Ek7JxVEYfN
 mpznH9PydJ4duX0pOWt6h8ZeESCmnBdJ3qoxM3TXrJIa/MKB+86vnD6Li
X-Gm-Gg: ASbGnctvAo/5oZ7400uP8vy/Y6SuFa9EXSaNXGPrq4xyNcN2a4AMNIuMTV6ZkIgsXC2
 CeKuIkiqV1vGaYMC5XUmsjKURBWA5LT+Gbvt8i32y705lkikI5zUsOjiM0mgvgUH7LnYZt8ONei
 U40q5H4EE4r0CTMoDVMYKjZUyh8+lmd6ZDDWwqjlR+rN2O0cmgX0voZ0HxO2ZyO0jJ8r+0T7xCb
 sfkCkytzwGuXgHzqaSxNfYSJfqpPVP3SZCPpa0BZBiumdSMyYX1PlzHO4X1IE22dxJhbD+QeBnh
 8INMCDDkhxdnvaPa6uj2CTncqqvN1N6/wbh6ez+DtajADMRuzY3RSNgtPkEEfSPt9Y9x5oEmUWn
 rybGQwLzfoCtuuOyaWKBbZ1iNKbkTyWJjzCKofWrToaiaMrtCxvq6a8RahlxPIw2PDpJcqBh4tL
 NIiqiyJFBDo1OhMlmNy4C0a6NwGj28+CnM1NXp/A==
X-Received: by 2002:a17:90b:3d92:b0:33b:6650:57c3 with SMTP id
 98e67ed59e1d1-343fa63269amr2005221a91.21.1763102298645; 
 Thu, 13 Nov 2025 22:38:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1V0qJbDFHa2TBmdRyy9geJLAF8gMLZ9ZiKlCqVdkVr5fP89GF9LU6xI5bE8BrDQ4uxujD4g==
X-Received: by 2002:a17:90b:3d92:b0:33b:6650:57c3 with SMTP id
 98e67ed59e1d1-343fa63269amr2005197a91.21.1763102298171; 
 Thu, 13 Nov 2025 22:38:18 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343eac7fc34sm2706559a91.1.2025.11.13.22.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 22:38:17 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 seanga2@gmail.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 2/3] clk: qcom: qcs615: Add GCC_AHB2PHY_WEST_CLK clock
 support
Date: Fri, 14 Nov 2025 12:08:03 +0530
Message-Id: <20251114063804.3835132-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Jv38bc4C c=1 sm=1 tr=0 ts=6916ce5b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=G1K_gZgz9GLba3hnKCwA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA1MCBTYWx0ZWRfXwLN9hn/6hRH4
 Gg2e4OuusIr0bTgg8vr1eZPdRepVS9PA2lbMnlHqQfMIbpyOzaf+HSNyijgbG39F2dgvsj6vYrZ
 gZeemR20mLFxjYrEtWu8HL/B1RJb84ZEx1lWmp9mso/4UPnakfzQI8un68xTYY99yEeB2gnpND2
 GGW4WS9XN/AGU+5Fm9ilanVFyeXouZP6hSctkkS2GrLin/r7M877/RXOuE68X1tngu6kZ04JfiX
 hPSpHRptdC2B2f8HyTdquKtEqfrvzPG6jROd/7htJFbGuzxEDihAvw+NfqrnY37k0Jwfd4oAXta
 zJiHbRvY/YVaxtflyehhNxCTSXWSrNJf8z6jQyEWgLAl9CIuBeYRRT48Y8ocXLoepfcVgBL9aSa
 rD2xgY8yY0dP9b0z5nlhcrq51aNVLA==
X-Proofpoint-ORIG-GUID: jy9Fp-2U59sw73IxywSUvl4vQjJoCsw0
X-Proofpoint-GUID: jy9Fp-2U59sw73IxywSUvl4vQjJoCsw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511140050
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

Add GCC_AHB2PHY_WEST_CLK gate clock definition to the QCS615
clock driver. This clock is required for proper PHY operation
and eliminates clock-related warnings during USB initialization.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcs615.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index 4700baba8c9..2b59c4d13fd 100644
--- a/drivers/clk/qcom/clock-qcs615.c
+++ b/drivers/clk/qcom/clock-qcs615.c
@@ -66,6 +66,7 @@ static const struct gate_clk qcs615_clks[] = {
 	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0)),
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0)),
 	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
+	GATE_CLK(GCC_AHB2PHY_WEST_CLK, 0x6a004, BIT(0)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x5200c, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x5200c, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),
-- 
2.34.1

