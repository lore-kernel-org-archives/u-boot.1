Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178E8FD0651
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 376E884109;
	Wed, 11 Mar 2026 15:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="YoiFLYqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7532F84057; Wed, 11 Mar 2026 15:20:52 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 535B384065
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 15:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6611f41eebcso9577295a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 07:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773238849; x=1773843649; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F+u/MrKjgqTgsXkDnQRcygJ+UImGeGfirF9RRiHOQBc=;
 b=YoiFLYqkCUUVcj1EdcPJvX/VSBnvsQXkIyVI9xTmhNNkJwgCYaK42/q+vVpOim2Ko7
 9fQB4HqjqHcSGwAMTqtnFGiCfWFcbp9TtMwwyMIRmds1/QHvTJvL6vpKBhGcnaIInOJn
 g2C1NWKDAyc+CLRCyKHOi9jtI+Y6ah7peeBdGw0EZICP5HeCbIxHphj7IR9RDJw3t/Ce
 Ohf53d9LjtRxKTwk/ZihVvGSVj3/Z+uBg/qtv/uy6n2XDeb3UNZtuUg4eNTP6wouZQJa
 EBr+mxWmza5GbENGzNHRctEQ9hTbkCvBXazO4gg/4INANn7454CDU4Bi7O4tl2w1EkwE
 PNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773238849; x=1773843649;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F+u/MrKjgqTgsXkDnQRcygJ+UImGeGfirF9RRiHOQBc=;
 b=w/ancC+4IAiEMofUVbGn240leuKWTjGdhZzkMkkcqqDYfldCGhJ1DP7epMGwlMkTn7
 gzmnJxQm8BfGSVFp+uQ0BW7fPTx6jOmVHN5h2DH3dXpf12V02LTzvmEbBRLBw2S/+Y7b
 vGsZwxtk8jn9InpQ4uxE6mdtcSB07heRggmPllntVQIPmirjA4vnVgEtOvZr+08bgJUQ
 gK2ZRSAWhviHuYXRdxZQpLmqynIfSKXB79uVqdG2LCkZZUeGThGv3hpMDt31Mwzg67lV
 M8TFdzvMDXCWuwKDp0SSVZk4PzxwoY2m43BrePkxoXusOrwrkJdHYpXJzbJ+sbji+X6H
 +S1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMY2rUZ4DDOjhi1Z5+HJUc0X3dsqJFkJlt64jFXfy43exkstf+ElfFiwgG0P8udBrYjPgG6SI=@lists.denx.de
X-Gm-Message-State: AOJu0YwfeXF0LPawntubRuvebh5t7h0CT+YFiillGHqCwllBMJn8ZeKo
 SXbvrKDzKUIPybotCZRzXhgGgkdWMRLJ4uA3J+0w0adwQo0NJuXOu3Mlm7tdJtsfPA8=
X-Gm-Gg: ATEYQzysK93jRH5Amtsrw6AZOwXloYyMSBcMDG4TDbKECc3iIOiniE/76YhiDAqPUYL
 ipgYcgCl7/eZzJlJZu3Lxw0IZOHxpJbiMM+KEFZmytzlgk/V8stVPhg7Ajyycig8+oKnlnEDEh0
 XkePOOJHvB5IqWkUS2IZ0vCJuVvSX4AnfWjvuzoUtd8GdUZ9/pXvPcbcvyWPB78+Pxlf3t0ii/6
 k7XQzhvxvkyNyLt1JNwDrltEZiuhWem5vHMvguOkxRFp9xu75hpvHooHdrSp/uLxfKFf06eBc54
 H9Li3lpRWsInm1mskQ/kt8ZIFzEWlgAtGA2bxPpEUNy/1pq0irlLy8+iAf1ZzxGT6n7g5aPil9W
 rVMpDsTJ+gshpfnFzVmN6ycAGjhE6nq9OtPjqrX48jHdWFYTjTPYGZRN59TOmdQEj3PMa+Sde56
 u1sBnxbqwXJucAujHRZB+gtwQ2SWD169PCPSyP6OGC++VRasKysrUK9lgdHv01w2Y1EhfBWIY6z
 rw4Zg==
X-Received: by 2002:a05:6402:50c7:b0:660:f1a1:e8dc with SMTP id
 4fb4d7f45d1cf-66319ef0e6cmr1372986a12.25.1773238848715; 
 Wed, 11 Mar 2026 07:20:48 -0700 (PDT)
Received: from [172.16.240.100] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6631503c903sm543467a12.20.2026.03.11.07.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 07:20:48 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 11 Mar 2026 15:20:43 +0100
Subject: [PATCH 3/7] phy: qcom: Add Milos to QMP UFS PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-milos-bringup-v1-3-eb905c467f10@fairphone.com>
References: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
In-Reply-To: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773238844; l=5427;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=WSjEIyYNTUr6O9YrOpnCcNTkx4ApOjVgBgLqcTmeL3M=;
 b=HLC2Z45mlXRFL70wG5F3XVzxSMmMXA6HjcMmE8bWTp8jJyupBzxIUhmLDATTUis7UNmZZJ4Fm
 vwbRc3vAEYaArHRTkR2QB8deMN8gDGwzqigTv6fWnafWkihRoDmWsBY
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:23:27 +0100
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

Import the configuration for the Milos SoC from Linux.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 88 +++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index 907f34744eb..80eba734a63 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -119,6 +119,68 @@ static const unsigned int ufsphy_v6_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_UFS_POWER_DOWN_CONTROL,
 };
 
+static const struct qmp_ufs_init_tbl milos_ufsphy_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0xd9),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IETRIM, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IPTRIM, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x98),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x32),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x0f),
+};
+
+static const struct qmp_ufs_init_tbl milos_ufsphy_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_LANE_MODE_1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_FR_DCC_CTRL, 0xcc),
+};
+
+static const struct qmp_ufs_init_tbl milos_ufsphy_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x3e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xce),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xce),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B2, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B4, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B6, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B3, 0x9e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B6, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B3, 0x9e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B4, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B5, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B8, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_PI_CTRL1, 0x94),
+};
+
+static const struct qmp_ufs_init_tbl milos_ufsphy_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x0b),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x68),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
+};
+
 static const struct qmp_ufs_init_tbl sdm845_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x04),
@@ -982,6 +1044,31 @@ static const struct qmp_ufs_offsets qmp_ufs_offsets_v6 = {
 	.rx2		= 0x1a00,
 };
 
+static const struct qmp_ufs_cfg milos_ufsphy_cfg = {
+	.lanes			= 2,
+
+	.offsets		= &qmp_ufs_offsets_v6,
+
+	.tbls = {
+		.serdes		= milos_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(milos_ufsphy_serdes),
+		.tx		= milos_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(milos_ufsphy_tx),
+		.rx		= milos_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(milos_ufsphy_rx),
+		.pcs		= milos_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(milos_ufsphy_pcs),
+	},
+	.tbls_hs_b = {
+		.serdes		= sm8550_ufsphy_hs_b_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_hs_b_serdes),
+	},
+
+	.vreg_list		= qmp_ufs_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_ufs_vreg_l),
+	.regs			= ufsphy_v6_regs_layout,
+};
+
 static const struct qmp_ufs_cfg sdm845_ufsphy_cfg = {
 	.lanes			= 2,
 
@@ -1651,6 +1738,7 @@ static struct phy_ops qmp_ufs_ops = {
 };
 
 static const struct udevice_id qmp_ufs_ids[] = {
+	{ .compatible = "qcom,milos-qmp-ufs-phy", .data = (ulong)&milos_ufsphy_cfg, },
 	{ .compatible = "qcom,sa8775p-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg, },
 	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
 	{ .compatible = "qcom,sm6350-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },

-- 
2.53.0

