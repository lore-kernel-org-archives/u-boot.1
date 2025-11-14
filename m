Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D443CDE006
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 06:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A21983FF5;
	Fri, 14 Nov 2025 07:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lJsU/uGz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fb+JHarn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DA2983EC8; Fri, 14 Nov 2025 07:38:28 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B7B783FEC
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 07:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ADManUf1484894
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gCI+lZGG2t+
 pnINj15BeBNm/VaY+psicjD4UqrzIYws=; b=lJsU/uGziGiPv4tS4bLhSOYDAdw
 6SHaMROwqZ3Gmwsev6YkWnV29ReUaofLI5EEunkwTsowh1kMcE1FtrNlyOV+7Ig0
 Of7MKw9pn9ispf+Tm+8+9y/78ou5OcdTRZ5IzTzogkKJeCE5mBqBye8Bbdq8UcdX
 cJZuzjz5sD3kA8btD77jyudROM/Is+PdiQkm7DTT+1Pudpld2xjc915DvCAvM3xQ
 YGf49kdFLzHAqjm4/ITjHdJp3NR7H6RIxQcGUZ/b2yK3cMdq/EXExTFzLwBAFWqt
 mXQuZ9stsjQKhViG7j+3iIkm5ZRcqJkubTzqP60IjdQufhvIT0YMV5P+r3A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9ch4pg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:38:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3418ad76023so4114358a91.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 22:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763102302; x=1763707102; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gCI+lZGG2t+pnINj15BeBNm/VaY+psicjD4UqrzIYws=;
 b=Fb+JHarn4d44YSagAaH96ZACKm+VXIIvDy/w3V7oWKygPUGrWCy9Z08sBYzjEMzS/s
 LbxVWDJXKMn/M8a//sOTuKznSu38g769AgTXigX0E9uPsiju1WMXF8itpAjQ1iC9aoIp
 rJmcluTkvpgDHhJIVHiZzG+BANfAij885z8I1MUpPOerKh8az4m5ZtB5tMoFQltR+XHR
 RZOzcN+S3bQblvXNA+fqMyoHtP10sagKDt3XuSe7GDCTrFzJ6cDSuZxvmttyApNFRpnw
 C+fsSxDUO5bKhK45aOp+c7A2gf8cIQfyyfnJCTA7CrZ6xrPnx1+MfrdjpQgMmvCgqGIi
 GT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763102302; x=1763707102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gCI+lZGG2t+pnINj15BeBNm/VaY+psicjD4UqrzIYws=;
 b=EF9gUgSYBWiSY3DKD1Rw6DE16MWDva5dAanQO2JmuGjLsIM0byEKmHsb3D52S0JW8H
 5ljyY3l8lFwHAL5CK0eioORl1/4OfjVWth4vURhTrYX+4Sw0CGifzp9PWQ2mg0FQHhHP
 uuGxXIvJzg5YWo2BhlIH3NRn4eHDBV0fXm0/6msxaEYIskuX1f1SvjiXwajmZnPNGgte
 GTqQf4mzlSsw7Vvt0TgadK2zeWcIkD4Ese83MtMpuuvObhryqQ2CtmqRDEUlOAlZNsSB
 RdaHnOhGxkG62Y53Pc/4aqBObPSqam1Nxw3ClhBLsv9tBUk+w7VONJpgUn3+dcIwKXlP
 jGmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVItP2uU+20lLeewPFA1/YruJQPIvpO5TtshWh4arbgph7493Ol2duiNBIGY/eb+c1SbMK9580=@lists.denx.de
X-Gm-Message-State: AOJu0YwpF6gdaRSr4L7BDp5PMebxp/g/sZeNxZRgBUsRkuhDi6LE0mWd
 nN+lo8HWxXjXXFbbzRPS0mkX3skgwB+D4JK0P5Sit6xxwp6hpHtxS/h2CSVWY9an1LJ22707PdR
 sYMD6wC7uw9ZQuZXyffU7XAxdewIvDgAcajUKiHTcCGD1mJ/5nxt4Yle/
X-Gm-Gg: ASbGncvGq1dU+s80AQdILNZlsCumw6Lirw0ZFH5cqg4MhhAyTk6hPhwV16peT74IsOz
 trzlWiHbHuDS4Fbnv6U+kX4l/V0VEX//H3ywmG3PmCI2O6tvK/VYx2lsdvg46g2QF3JteBHJTTw
 8m8OnIeCN96AIkBJk6/MM2jCDuCKZpHZzrl925Vf3ml+2Xx0Ms7vaFvZdwIGyss5C1kbJEUuvU5
 m26wlBY3lSGGRZTTAdUuFt1VXsZkw8gKqkG6EiGYl9S76rCu5J1mST4dbM8N1SmLzV4bbdv2PUK
 CF2enQKS69hKze3hTtRakgcJ6VnwY5bYhjqX2BID6JJE7aWV7aBhxNLf76u+rkuiztp8aLO9g+m
 kE+tAtFN9pWeEcPJoFrG0n4JSbsAoBnJzEOkye8tXsOAFGSa71WAsl/D0aHg13T8CoHyFq6AkML
 f+oCF2Ob0FHIe1l+N4WNgfNY/f77Z8BTVrR/gh/w==
X-Received: by 2002:a17:90b:2e0b:b0:343:747e:2cac with SMTP id
 98e67ed59e1d1-343fa761482mr2288788a91.31.1763102301947; 
 Thu, 13 Nov 2025 22:38:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqEPEtD6PUechEo5SpnU3GnJzUtWgAJ1wVBO957zaMkcEA6kEICo91XNyw3cnxUghMR+5Sdg==
X-Received: by 2002:a17:90b:2e0b:b0:343:747e:2cac with SMTP id
 98e67ed59e1d1-343fa761482mr2288750a91.31.1763102301503; 
 Thu, 13 Nov 2025 22:38:21 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343eac7fc34sm2706559a91.1.2025.11.13.22.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 22:38:21 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 seanga2@gmail.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 3/3] phy: qcom: qusb2: Add QCS615 QUSB2 PHY support
Date: Fri, 14 Nov 2025 12:08:04 +0530
Message-Id: <20251114063804.3835132-4-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TbL058Yi3rHeJX-Ks6O8A9jCFmRLjgCD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA1MCBTYWx0ZWRfX3B95c4/vvzbd
 TMOEQ/5+wsKokfKr1hea33Fr1dEmHkY6geqwf0LJNpdUKkuGllC0IuSOJ98XwNWemf3XvFNqRLj
 e1Kl/E1GRIEyhWb8fOrsBoyY+uzK8RIbI0QFEWgY+Lkkeq8VzaLOdcsTqr8EFwDHZuoh8ISm7/4
 dCfA/h1b2g97ryCvfz6weoFgVMZIWCeOKM90jNb2NC5yXU1PwJnDDySHFQ2JGMD/vC+/oEh0h2J
 yAwojWxRkCo8c+qgfzb/ul/t2g7P+djioBUMMJW5BsgtdIUrzzDPeqDO3cCs+nmNFM0eTPGij1N
 VMPzMFVIODftyws0hodE6h6QCWy1v8EqkoC0JOYMDWb6cLqk/X/3nXMNd35AnG9V/5tPjQr/34Y
 awyTtMl5odXwDzqM/fOcqVLnQF/gWQ==
X-Authority-Analysis: v=2.4 cv=MNdtWcZl c=1 sm=1 tr=0 ts=6916ce5e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=32XPU3MRu1Wd0bsjkHcA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: TbL058Yi3rHeJX-Ks6O8A9jCFmRLjgCD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140050
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

Add support for QCS615 QUSB2 PHY by introducing platform-specific
initialization table and register layout. The implementation reuses
the IPQ6018 register layout and defines QCS615-specific tuning
parameters for proper USB PHY operation.

This change is based on the upstream Linux kernel implementation:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/qualcomm/phy-qcom-qusb2.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b0

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/phy/qcom/phy-qcom-qusb2.c | 38 +++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index d98f6108e69..a5d724eebd4 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -176,6 +176,19 @@ static const unsigned int sm6115_regs_layout[] = {
 	[QUSB2PHY_PORT_POWERDOWN] = 0xb4, [QUSB2PHY_INTR_CTRL] = 0xbc,
 };
 
+static const unsigned int ipq6018_regs_layout[] = {
+	[QUSB2PHY_PLL_STATUS] = 0x38,
+	[QUSB2PHY_PORT_TUNE1] = 0x80,
+	[QUSB2PHY_PORT_TUNE2] = 0x84,
+	[QUSB2PHY_PORT_TUNE3] = 0x88,
+	[QUSB2PHY_PORT_TUNE4] = 0x8C,
+	[QUSB2PHY_PORT_TUNE5] = 0x90,
+	[QUSB2PHY_PORT_TEST1] = 0x98,
+	[QUSB2PHY_PORT_TEST2] = 0x9C,
+	[QUSB2PHY_PORT_POWERDOWN] = 0xB4,
+	[QUSB2PHY_INTR_CTRL] = 0xBC,
+};
+
 static const struct qusb2_phy_init_tbl msm8996_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xf8),
 	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0xb3),
@@ -189,6 +202,19 @@ static const struct qusb2_phy_init_tbl msm8996_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
 };
 
+static const struct qusb2_phy_init_tbl qcs615_init_tbl[] = {
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xc8),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0xb3),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE3, 0x83),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE4, 0xc0),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TUNE, 0x30),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL1, 0x79),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL2, 0x21),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TEST2, 0x14),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_AUTOPGM_CTL1, 0x9f),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
+};
+
 static const struct qusb2_phy_init_tbl qusb2_v2_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x03),
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
@@ -248,6 +274,16 @@ static const struct qusb2_phy_cfg sdm660_phy_cfg = {
 	.autoresume_en = BIT(3),
 };
 
+static const struct qusb2_phy_cfg qcs615_phy_cfg = {
+	.tbl = qcs615_init_tbl,
+	.tbl_num = ARRAY_SIZE(qcs615_init_tbl),
+	.regs = ipq6018_regs_layout,
+
+	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
+	.mask_core_ready = PLL_LOCKED,
+	.autoresume_en = BIT(0),
+};
+
 static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
 	.tbl = qusb2_v2_init_tbl,
 	.tbl_num = ARRAY_SIZE(qusb2_v2_init_tbl),
@@ -453,6 +489,8 @@ static const struct udevice_id qusb2phy_ids[] = {
 	{ .compatible = "qcom,qusb2-phy" },
 	{ .compatible = "qcom,qcm2290-qusb2-phy",
 	  .data = (ulong)&sm6115_phy_cfg },
+	{ .compatible = "qcom,qcs615-qusb2-phy",
+	  .data = (ulong)&qcs615_phy_cfg },
 	{ .compatible = "qcom,sdm660-qusb2-phy",
 	  .data = (ulong)&sdm660_phy_cfg },
 	{ .compatible = "qcom,sm6115-qusb2-phy",
-- 
2.34.1

