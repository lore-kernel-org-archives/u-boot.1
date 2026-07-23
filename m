Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8087AC531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 09:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39A2A80AD0;
	Thu, 23 Jul 2026 09:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vAt4y9lZxHLY; Thu, 23 Jul 2026 09:39:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2963780982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784799566;
	bh=xSy6/Lpx/+6AYQKBOMoXd0ETY/9dCV517S6UDALxaes=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=IyiHxdUQ+b7nlmWY0vehPkkroQfHrVYk5zReL1cUwmZ0JV/oDxO7kbSsIGNGh6ryT
	 SzNpBi9j4MgQjeJsBs4eHFMwu+8Ucebmy4wxG3PlUafh1Dsb2Jqcq3MIYP2dvzz8mV
	 EiopvUTE48WsAbAj0KLknFH+2TlBbFxuycugruaWaoF8/u1DhRc5HVeS43+rla3bcp
	 FxbfFUFi2btHss60CJs7jFoi0ax12R0vEGYXo/Tch2TeGNRgyYN/kkmcukrNaIxj7e
	 eLkT7pCcir5AdzJX3VVqwLfBF8FhFdlb54E2rrmnOOT+9Vtxw6fZZ9BIOBa5YJfGxY
	 GFC8FyyZZv+ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2963780982;
	Thu, 23 Jul 2026 09:39:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A6746347
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C57C80982
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:39:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6YyDq4s-x8XV for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:39:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9DCCB8097B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9DCCB8097B
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DCCB8097B
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:39:23 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N8qXtC467201
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:39:23 GMT
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk28xud26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:39:22 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so425110a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 02:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784799562; x=1785404362;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xSy6/Lpx/+6AYQKBOMoXd0ETY/9dCV517S6UDALxaes=;
 b=GkUBUb4LIcK+k02uBIYy5S5sC3x0oMzbnAdKhzULit4pSs/NGgqv9vYlGkSk+pUlFJ
 iHoL5jHnB5p5aPttK3yId1NBElECFBVH/jv3qKTXmQDtKxaD/PXGGVzlRO7HuoT6ndCX
 9ncDiho0xGyxlJPZJDYSA1LTTO+EZmNeFHUJO0CtNv1MOZUC04n85I59dds7/Ipa91W5
 STmEY3YEMKaa6OR2BVmfoODdNoxrR0i934t8Orvoyxxa6GSyw/Z60GPCoNuqQnzNLDDl
 WItdfcASV1nCoA6gh8Mv0hFfo75fA2k1RE0JHmIrKE1OL3gTgKj0AGo69FdivsgOrYwM
 AbRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNZbra6yXGuW+qxX2tILa4jlNbjx41D2z9bxkepbDn0Viz9wDUJFRCjo6e26VlL1R35klSH3A=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxZLfg8ArTg/wnEQA40PD/FC96w9FVJchZqLCTrH9+eROVkRZIk
 UHETTK1EKeP7Ffy0DhRFlbHHuIwyAUZUeyMVUjNdnXD+9kYRz5X9Y+0wu2hWrIpzOAaO76NDp7p
 Y0ANL+HQVK1vtXdO3+Veb56UiHRKt3C/3RRf3FXSK3IArz/AqwcaL/ZdaYDYgEpnvbRFiPHSWqt
 nxx44=
X-Gm-Gg: AR+sD13mpF9z2QQ1nsredt7gyiJETSh/Fprp4yCKZKKviLTkOEFUIckmdBsmbV5Eoks
 bZOc+1NA1R3oFVbroGpMRdo6sycXi2wk2NBe8hbbo1U1Yx3noqO3HCE1RVhHRTBlX7+16AtQT2X
 kBPWLnAS024jdP2v7nyKa904203RIUYSEBn2tPwN3N2rsKH1ij9TfAHPlhRUBOG6JqMdFmrFVyX
 BoSesye8DyBnzto20TSAXJ4uPqq68yGA/BUADKTDnp2vVE2Fi0rz/BEAtTRAQsVZsy7qa7Jk9+x
 dburVjHqYcU50p05pmIyB5C8+2phDnpu/PfvI+mUPYdBLOiBEDZvqveyiITAH9Mcvd/5ZCpAp2w
 zYyJqrRgkv3lXTENR9shpVI3ujHu9zcKaL+SidWPwm9ltjpZ+yYl9YF0B0l9XddJe3BTsr7kmMB
 DKC3WIaWsKW5bUhyz61WVENUMpGIuI
X-Received: by 2002:a05:6a21:a247:b0:3bf:c07b:a9ab with SMTP id
 adf61e73a8af0-3c44b1da5eamr2591163637.55.1784799562222; 
 Thu, 23 Jul 2026 02:39:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:a247:b0:3bf:c07b:a9ab with SMTP id
 adf61e73a8af0-3c44b1da5eamr2591126637.55.1784799561795; 
 Thu, 23 Jul 2026 02:39:21 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e0818e4sm18008502eec.22.2026.07.23.02.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 02:39:21 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:09:17 +0530
Subject: [PATCH v3] clk: qcom: sa8775p: Add SDCC1 clock support with
 frequency table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-lemans_emmc-v3-1-4dfea75e0f78@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEThYWoC/22MQQ6CMBBFr0JmbQm2UoSV9zDEVJjKJLTVjhIN6
 d2trN385P3kvRUYIyFDV6wQcSGm4DOoXQHDZPwNBY2ZQVZSV41UYkZnPF/QuUGoth7xWtuD0Q1
 k4x7R0nurnfvME/EzxM8WX+Tv/d9ZpNgLq1E3LdZHi9UpMJePl5mH4FyZB/qU0hc6DI9RrQAAA
 A==
X-Change-ID: 20260723-lemans_emmc-395deb5f4a67
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784799558; l=2895;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=YT28jvZIxkBTmXmB95fcalmm2P5eCs4lWcZQenHMazY=;
 b=Dfn1PH7Lpc3KBmCtVveiCiR20sO+JXFmmNIcdMFhih6RE0yGMZmPjSZuaVhr/N4QfpLUF8c2X
 Ep6B6m/4HSjAqEER+E2QkTdUhSkacxCHkJjFAoZSdGH8zGeAiKe0KKV
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: R8R93OGPx7b3LxJVYM5xiNmDSIr7vcgg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5NSBTYWx0ZWRfX17Xmrt/gswIs
 5B046eEEhqWFTO9lAb77dMdQKpQbG0bElpFj8Lxg/EueWDRjW17ay9aOZcg9CHrGYhExPhEnfyj
 bzoccrxpNMbPd2eUN8BO7jW3N8vDD2k=
X-Proofpoint-GUID: R8R93OGPx7b3LxJVYM5xiNmDSIr7vcgg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5NSBTYWx0ZWRfXyfiShvMrXgB5
 tL4r9lpgUkg/TRei4KsWhWYGLxTwmyhyyKsPpeF5o9FqSXAKcEqcXZ5YNBMGhSfN1hFgBwP+1id
 LPEJN2nN5nvU1a8zsBSCKHslCQmnrsPl7lERaVt0v7G5UaIMNLsaEbzuJ7r4ytvlzjnt9/uTv5j
 5nZjBoHXrfPwQOLdOA3nbClH8R2+ipq1tSUnmzNUHzLBJHs9RiZ8QGUpewDZhORc39M8XO/Ap6X
 VY634P7thXdRubrFlQjBW9yyJc0/nKJf0m/wSRNjVc6MUti6UKbNJ+FomrNHgHZR5jlTOw6Xk8e
 XyhqVrcW1uM46r+3UFVg5CAlQfl9kp6KIe6R9crEJm6qQzvHYkBUdQz8RimluNjhPz2KK73dXZt
 koh128fKP9iSxzJwIS4qKqCRF38y6atNmlv5JrJvYmOyM9wJCJHf0e+VqH8VXLg8r9TK9Fo6OGr
 M8H+dlo/4afrof9okjg==
X-Authority-Analysis: v=2.4 cv=WNxPmHsR c=1 sm=1 tr=0 ts=6a61e14a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8 a=526cBOim7ay0EJGWx88A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230095
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xSy6/Lpx/+6AYQKBOMoXd0
 ETY/9dCV517S6UDALxaes=; b=faMqQCoYhxEdDEbwsfrcKU6jXW4v8uPi/BwTK9
 LvJLc0v7nRGw6aiNXmUR+mnapUVxf1MJKfB3Cci5V8pNeb3Tk44lyJkZpE9/6sFA
 /Ra3WldtYSBuFLA/xyX+Ryan5djTH1flhY8cSuFEVdIkOwe934uZtiYVXv7JIV1K
 bz9rAPQhfOjJ1Ebck5kVmy58GWZaxr9jK5Ca4NiWqWglh/r715e3CrlIg03pu6F+
 IeXtXGS6xdOn9w0BuotL2kYYFMWU8WKeLVE6x4NWEa5yBQyhDwgtbfZPNwYN0+fb
 RgXwejmJNAOd9Zla9uz5Hg/S3YbnG5kTOoIvKc2dFE61Yfaw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784799562; x=1785404362;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xSy6/Lpx/+6AYQKBOMoXd0ETY/9dCV517S6UDALxaes=;
 b=PBQo6dkJ1duXCIB1C6HK+UGEPH9wm0NAcrEokUhszsuvERABBWAedN0Hirqbzsoa+8
 pMN9Q81LevfRN9DpZBu67tmh18ai2wttLa4G6poEbA6AkFysgkLEm2/BaYFJ6m26neby
 HW8XXLtFXOUouBliUcIp7SOXL153qFS/FA73JOvkxFXO24iT07ywQBXi5A1Er+I5Xoy7
 wTTw4U0cKdjzsjnLd22qkSiDSp7zTTioUyur+BbvzuuvFXei/y9xU+DB1n//l/EV4slh
 r9B4va2aiVfXJc7mZvOcAUlP6YHZu/ohiVfRcYnL+1+RepSgI078Y7OPM7U6JIlqOtks
 Xlsg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=faMqQCoY; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PBQo6dkJ
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add support for SDCC1 (eMMC) clock on SA8775P platform.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- This patch depends on this series:
https://patchwork.ozlabs.org/project/uboot/patch/20260723-clk_gate-v1-1-9549cad4d097@oss.qualcomm.com/
- Use GATE_CLK_POLLED instead of GATE_CLK
---
 drivers/clk/qcom/clock-sa8775p.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index c36b480b300..586b4e1be32 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -74,6 +74,22 @@ static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
 	{ }
 };
 
+#define SDCC1_APPS_CLK_CMD_RCGR			0x20014
+
+/* SDCC1 APPS clock frequency table */
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL9, 4, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL9, 2, 0, 0),
+	{ }
+};
+
 static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -94,6 +110,7 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
 		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
 		return rate;
+
 	case GCC_UFS_PHY_AXI_CLK:
 		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_AXI_CLK_CMD_RCGR,
@@ -112,6 +129,12 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 	case GCC_UFS_PHY_PHY_AUX_CLK:
 		clk_rcg_set_rate(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
 		return 19200000;
+
+	case GCC_SDCC1_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
 	default:
 		return 0;
 	}
@@ -169,6 +192,10 @@ static const struct gate_clk sa8775p_clks[] = {
 
 	/* EDP reference clock (used by UFS PHY) */
 	GATE_CLK_POLLED(GCC_EDP_REF_CLKREF_EN, 0x97448, BIT(0), 0x97448),
+
+	/* SDCC1 clocks */
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0), 0x2000c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x20004, BIT(0), 0x20004),
 };
 
 static int sa8775p_enable(struct clk *clk)

---
base-commit: 2b66f9cf0492b23ac27ca4523151e2bddbab3c4f
change-id: 20260723-lemans_emmc-395deb5f4a67

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

