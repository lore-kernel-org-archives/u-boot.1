Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FF3CA0EFF
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 05:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A7A838E6;
	Sun, 31 Aug 2025 07:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="iYxLHyRI";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="xkDX6Lm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05DB283447; Sun, 31 Aug 2025 02:51:05 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90AB83447
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 02:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrian@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1756601182; bh=R20UgV9d+ZG2ScN7OEquQ6A
 F48fyFswYZW3vfFpBs/k=; b=iYxLHyRIGL/GXZbnzxbFfcR3Zp7/g0r3kd4qC5uSdimbxmy1QY
 oe5g6j3uDWUj2qYlICOh9oA23JOL9iKuze9V5volj9FTtKgx0NKtnSq88s40afvEgYfT1S3oC+j
 QcqJmAxQGV7Lmb/7mrNEvJUinp3a1O+1dwwwVXA+HL/x6de0IYbTblTr7CarqQUUfjElEC4mnPM
 roiGlldos1jgKDjBOOg6UZXlkW6WQvmYxPnju172kTz9k7Y+o37ldk9LTfKtLQQRanZRqEJ1jHo
 bv91qxq3FrKphPIfkHuaiRSKEv+du2KxotEXuQNS8OND2lfHp+A+Zyh5YwIjtQP2TqQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1756601182; bh=R20UgV9d+ZG2ScN7OEquQ6A
 F48fyFswYZW3vfFpBs/k=; b=xkDX6Lm2VqnU7uA1rhLPRLQDo/AlIs9Glvb2o0W6/dRDc57dtX
 lzLvq074Ia0HXLm/PWSPaad5SLKQSoVgHFBQ==;
From: Jens Reidel <adrian@mainlining.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sam Day <me@samcday.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Julius Lehmann <lehmanju@devpi.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, Luca Weiss <luca@lucaweiss.eu>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Jens Reidel <adrian@mainlining.org>
Subject: [PATCH 3/4] phy: qcom-qmp-ufs: Import SM7150 tables from Linux
Date: Sun, 31 Aug 2025 02:46:01 +0200
Message-ID: <20250831004602.699953-4-adrian@mainlining.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831004602.699953-1-adrian@mainlining.org>
References: <20250831004602.699953-1-adrian@mainlining.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 Aug 2025 07:09:14 +0200
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

From: Danila Tikhonov <danila@jiaxyga.com>

Import the init sequence for the UFS on SM7150.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Signed-off-by: Jens Reidel <adrian@mainlining.org>
---
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 61 +++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index f3c606847fb..a2a0e226f0c 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -221,6 +221,36 @@ static const struct qmp_ufs_init_tbl sm8150_ufsphy_hs_g4_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
 };
 
+static const struct qmp_ufs_init_tbl sm7150_ufsphy_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_LVL, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_INTERFACE_MODE, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_TERM_BW, 0x5b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_HALF, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_QUARTER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x81),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x59),
+};
+
+static const struct qmp_ufs_init_tbl sm7150_ufsphy_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SIGDET_CTRL2, 0x6f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SYM_RESYNC_CTRL, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SIGDET_CTRL1, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_MIN_HIBERN8_TIME, 0xff),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
+};
+
 static const struct qmp_ufs_init_tbl sm8150_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0xd9),
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x11),
@@ -1018,6 +1048,36 @@ static const struct qmp_ufs_cfg sm8150_ufsphy_cfg = {
 	.no_pcs_sw_reset	= false,
 };
 
+static const struct qmp_ufs_cfg sm7150_ufsphy_cfg = {
+	.lanes			= 1,
+
+	.offsets		= &qmp_ufs_offsets,
+
+	.tbls = {
+		.serdes		= sdm845_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_serdes),
+		.tx		= sdm845_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sdm845_ufsphy_tx),
+		.rx		= sm7150_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm7150_ufsphy_rx),
+		.pcs		= sm7150_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm7150_ufsphy_pcs),
+	},
+	.tbls_hs_b = {
+		.serdes		= sdm845_ufsphy_hs_b_serdes,
+		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_hs_b_serdes),
+	},
+	.clk_list		= sdm845_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
+	.vreg_list		= qmp_ufs_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_ufs_vreg_l),
+	.reset_list		= qmp_ufs_reset_l,
+	.num_resets		= ARRAY_SIZE(qmp_ufs_reset_l),
+	.regs			= ufsphy_v3_regs_layout,
+
+	.no_pcs_sw_reset	= true,
+};
+
 static const struct qmp_ufs_cfg sm8250_ufsphy_cfg = {
 	.lanes			= 2,
 
@@ -1593,6 +1653,7 @@ static struct phy_ops qmp_ufs_ops = {
 static const struct udevice_id qmp_ufs_ids[] = {
 	{ .compatible = "qcom,sa8775p-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg, },
 	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
+	{ .compatible = "qcom,sm7150-qmp-ufs-phy", .data = (ulong)&sm7150_ufsphy_cfg },
 	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
 	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
 	{ .compatible = "qcom,qcs8300-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg },
-- 
2.51.0

