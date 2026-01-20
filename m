Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D460D2ED0F
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 04:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B23983A8D;
	Tue, 20 Jan 2026 05:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EDO/ydsx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ACC7T9Ae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D146C83A8D; Tue, 20 Jan 2026 05:26:14 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B188063E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 05:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60JGg1pF228319
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 04:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2RM0DuaFr+f
 KLpjwPIJeTnl98lX622cZx2rsbJGCJjo=; b=EDO/ydsxQ4KOWusBb4Ns/Tjsaz1
 fOtxjl8cPXD5p1r7a9mxJPDwHz5kNdtpGNj4xsKMFgGkm7i065vP6FImRA/MPAfP
 jfoV2vocY3LDn0lQ7Hu++E/w7YV7BZKtv4sCXWIqj3dfYR9cAgm0mVEJTrdxzULF
 SNyWcfczP0D5rXL6hmLSredpxqpoptEf4dexXRdpci+kgxf7g7wI6Z5skGR7z3xC
 ynqIt/Pg4aKlyCjAQNOyWoJt73GwJlt8UMjTh+HCv4F46WkntmUyjb+H2tJZW/Mh
 3RKz2Fb9HsetxcSzAGyr7wr7awz+8lOw0y66KEyYRPnioAwOZmn8qKAzNvA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsgfrb06x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 04:26:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a76f2d7744so932105ad.3
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 20:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768883169; x=1769487969; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2RM0DuaFr+fKLpjwPIJeTnl98lX622cZx2rsbJGCJjo=;
 b=ACC7T9AeJKSbQwBZmc4UivoIuCRo23VAWpLmxX6MoOMGD/7UbKZ2bbFYydc6G7scdU
 J9+sV2pB1KpzhhMxxFoksm3CZvTh6FIclnRKrB2pI1lYY6B66xKHSAcOD5wml1at/Ukw
 jhQVc9u6CUidlaf/yUDHYZK8LmejcNtXoacSqgusv5EDlvEszP0etDWbSqE4qahZ2Wub
 vVeHYBQB0u6wkNOn2QavQAbdrjVJ4qudRq7jLKL5v/UtBN8u9WcJQJ9R2fxEs2ZrFi/O
 rt2WaImjl1hExWO8utvmln7JpFo5SHfPl3poZN1NqB5gAd42b09wHmJ+JaS1PNkmjpTK
 F7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768883169; x=1769487969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2RM0DuaFr+fKLpjwPIJeTnl98lX622cZx2rsbJGCJjo=;
 b=u+ysCxpMWz3FRbdP7Vp3QpqOAEMUOfZgOfJSvzTGeYigFkTNx0/vhK4KtD2ksC2pAG
 E5lUoK4IzVAOclpb6ChMOkDCHzFENBhYhEkd41LciQZJLHanw0MiOjqddfg9Kh2Mxxf8
 WhEP6u8LWKt+yUtyCtorZvQBwi96TFi7BQapEaBh/YqLBi3qdWqErqz6WeOYDOut20Cb
 1W1EHj+ee4K1Onfo/jlSzklcnH1COdTu2BnKqrHhJ/QMC35nHpwloboaGJ4+/7uiDXvy
 x9IAdn4mKimxC56e++LtgcecT6uZnasS18o05jmHRHXNMWaJIMy1enovmbd/aADRYPNH
 6M/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfCH8xmOEpcnAtqkXSsfM5MqYPPQbyREVApFbizoPOZYOJHEKHFORuvWsFZZLyrAXgT9wxzCg=@lists.denx.de
X-Gm-Message-State: AOJu0YyvPi04Z6hnzcr8qkkpnIV+27gSPtTC8V0Uwzp0hOTGE0Avyb11
 XAwoWXT039wJgKupx4yMiFeskXKBpG5AaBOGitelXC2lHJXLZA9T4xBKqw/27b57K717tcTOTrz
 F4fFvyZIrib8H0P03i11DOO752gOMK5RzY+pVAghEncem0/ZZ1NYSdExU
X-Gm-Gg: AZuq6aKzTmCJ5Xx4ngKaQonSYym6v1L5Gq9h5z/tcUq6pOuPYLnEfETr8OgWsEO2T/S
 euSeuCijR/tKnq4DalaEKwC8ExAPsc5MyovqbSZLK2E9WvuEd8qQnSKkrsTxLr0rRzS7Cq0Osox
 3c/Y2gQ4d23UsH75lyiqXhg+NsPoNIRwxeU4Ddw3E/WsJpUTSRqfdzk9wZL3+Rppi273nLyy2Tv
 MRMxzaMYoLZ2K1QtTfWIzfA3i58vdnmeFrMSN8nGkMrfXfHn16f3v5yTf0StmYRZHu8TQMYaxib
 g60zmqWALGfMApu/f+7qOHxk+pLYiMoDHAcpiSzAyAmpnVtVFAM74UpCdYU3MtJ6CkKAVQvVl7W
 ob2AcDmYS4SiD+CbA7FK7EZs0PrRSxCJJGcbn8zZlGRXHtE1Z2C82zDB4555BUP2u2djxT4numi
 +LDcv5tGvjNrKuYVgv1WucYfcOsk8GLWIci7AWCA==
X-Received: by 2002:a17:902:f693:b0:29f:1bf:6424 with SMTP id
 d9443c01a7336-2a76923da28mr6577065ad.18.1768883169296; 
 Mon, 19 Jan 2026 20:26:09 -0800 (PST)
X-Received: by 2002:a17:902:f693:b0:29f:1bf:6424 with SMTP id
 d9443c01a7336-2a76923da28mr6576835ad.18.1768883168735; 
 Mon, 19 Jan 2026 20:26:08 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190eeefasm107929825ad.43.2026.01.19.20.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 20:26:08 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, balaji.selvanathan@oss.qualcomm.com,
 alexeymin@postmarketos.org, nathbappai@gmail.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 3/3] phy: qcom: qusb2: Add QCS615 QUSB2 PHY support
Date: Tue, 20 Jan 2026 09:55:51 +0530
Message-Id: <20260120042551.650113-4-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120042551.650113-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260120042551.650113-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BS9B_XffdHdfNb2CX5feQkq4Ua95tnWI
X-Proofpoint-GUID: BS9B_XffdHdfNb2CX5feQkq4Ua95tnWI
X-Authority-Analysis: v=2.4 cv=c4OmgB9l c=1 sm=1 tr=0 ts=696f03e2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=32XPU3MRu1Wd0bsjkHcA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAzNCBTYWx0ZWRfX8Gz0bOdWz4ZL
 8Aw38KEXMrEQiK+Cn1pnWpx57EbF9oDtTd+W7lIA4GFy4gkhFlOIkqXTLuyhdKJgSq0j9cc4tQu
 4dqBG3FhhOeZKJdqrntHFqNLB01E+uV0WPVQhBUtjtjpgExiSNVXy4ccNPcvW7odckmYPYjgggO
 Omk9vK9nu7+JOLRlcm41DrFjSBr8qH+QX6Arj3S4kstG7swT56idTpa2nJm0VZ/WRZLOelmQNt3
 K7DcB/C3vq7OEbwqagm9QYka+PksGuvZ6rDSyH0wjOuBq9H4ghnp8NZTZMa45aznNHIJsBGxXmc
 9cVZnB+8H2s+mZBAOD8jASdmTsGvuW1jPK9mZB2QEtGCrFZ8uB+m7PhlE1q2urr/fPhY+DOx0SJ
 ZJmVmBAjnFX08Nu/ZhJ9uuSKSn+1CwtyKrmLSjpAggCc1IC40/O+6pkcaAFk7EvdfI+2WRDeds8
 4v3UhYowEWjdmAKJJ4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200034
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

Taken from Linux commit 8adbf20e0502 ("phy: qcom-qusb2: Add support for QCS615")

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Updated to the reference commit for the QCS615 QUSB2 PHY support

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

