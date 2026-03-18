Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBC3103E18F
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9CBC8403D;
	Wed, 18 Mar 2026 15:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="Gb7tghi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0253F8419E; Wed, 18 Mar 2026 13:47:01 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 684DB8419E
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 13:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so1132917566b.2
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773838019; x=1774442819; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JSJPZzUcJBVbx8kploVhsYJY78LHaYG+gipSt893ODI=;
 b=Gb7tghi6hFa5w40pTtD0vDhqdjG25xtTG2VGXtwN1+Z8j6ZEaXb7jSmiCsWoDzb+E6
 MlzofMqEep07adivp+hpWjxwDClIQQizPj4nvj8h8yAnQ2lsYIrAv+JL5PEIkW1xZp2T
 rK4AICV6R7RoYxMwkptqZamSIlAuo4qiPvz9BGMPvQuoVcex0IyDTKlGsuSSOYQzaV2A
 9qFo2dNmllRgASQEEQQyiTwV0X03lBiTRdHdxvWBMn1OFG++VvmSGDO4SFuJUsRlxuAg
 ptGXNGTv8j7h7hOKu1JWVZuioDwV0xN0kGGjqNvesffZBlFN6L1/Mg0yxlebwrdn96ld
 8H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773838019; x=1774442819;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JSJPZzUcJBVbx8kploVhsYJY78LHaYG+gipSt893ODI=;
 b=gXiVCHaFHKWA4T/528LmEmMHK0V6MJqot3cesJDDVAg57EYHaygS7S66umlpoMQiyl
 PvZcvYlhiKdauj5zyhSnQ9W+oz+pzpHFiaSYzncRhnzmB522qTU1A+Gc0H6BCiHxIDw9
 JiB4TH/Wt9oj/XAHZMLTsMg5qytzyBWBkaFLgGY8rKUfbT+Va1u7E2OJ1csIVGUz+wHr
 FlfLF/uIWV9dYF7lhi7oJib3tO40OR7P6WcJDqqjux1aPEDzcNvOA2EeAmLSgX+TkqiK
 yi701ILkBRqdvoTM5y4/5bKU93dDUChIySuLHYAoBPDdN11tJukKzOW50RUzL6ZR4zH6
 9wSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP3ZUYSqpyB8qE/c11Ny8r5QALISYYRmgw+9WGl8I1beH9R+fOdAXYu6vr6DIksg0J9FLEmBI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2dnR0n7xabTqIa0H3mGO+IlTo5EnyOX2e3BI8FhR/Ub1hKRKR
 yAoZiXobUHlYk+I1Y1xG6hN920KAh//qvUVwIZXsego65tL83zoa6X8IFXw6yiTFUB4=
X-Gm-Gg: ATEYQzweBau1CzDbPZ3otTJu5IIrFn4En7TwqKJBPdpaIMq1DCc85uHMkq9hhOcJk/r
 Gy7vSzfgBsZHQd4pVm0H4tsCom0EvaFodsm8xtGYhyI2N2uAfYEX+VQuh0lNaoT9TZPHK9VD/uY
 VFxLB4+idjASRo8j0tk9jIE5TnsxsxbTVBWXRagNcEsdV2/1GCzXDRt01VyqfhGeYRc39Bbr28s
 WQNVAKigo/mqO6dGn8GH9qrC19XyHsG35ZC0oKJnMU+03eIg+UbzZFzUZ4WGfPxTnIiqHQo+eY+
 UHFw0Y22a7F7TjOjihfNEej6Qfiue3lKoy2uuHCabN1ocq9DuHj47X1saDqdD+fU3FMHxfWO3Oo
 2R+CuK28hU0Ah0ahLsa4yUESF4hHGliKIdXU3oDN+rc76ptGdXFg4kwEwFq+m+DSb3PKmnbZGAS
 C6bXhaPTCAv6r4DYZ3UkCb2biI22o6Ji8D9tanTRlPTI29yq2qlv5Pr/Z09EsSnnw7F9eFyLDyA
 e3r0w==
X-Received: by 2002:a17:907:20e2:b0:b97:2a5:8a48 with SMTP id
 a640c23a62f3a-b97f4a84451mr172819266b.37.1773838018695; 
 Wed, 18 Mar 2026 05:46:58 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f142cf16sm206080366b.20.2026.03.18.05.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 05:46:58 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Mar 2026 13:46:29 +0100
Subject: [PATCH v2 3/7] phy: qcom: Add Milos to QMP UFS PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-milos-bringup-v2-3-650b91dd75d8@fairphone.com>
References: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
In-Reply-To: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
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
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773838014; l=5497;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=cttBk3qdP3mo8VutXIN61Mj3cIbznskwGzW3hZMGPTw=;
 b=cDhQXTAePpZCaEV6MnHnSc5NVUz3Iqns+cA3YOyZh7hwfXv8QSXnveZ647o33/BVV/Cpu/L2Y
 3OpA7FA6CPsA2TO3yy93wxZNXSkUJnxaoqfu+SutYgG6tibQO6tPX5n
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:14 +0100
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

Import the configuration for the Milos SoC from Linux (tag v7.0-rc4).

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
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

