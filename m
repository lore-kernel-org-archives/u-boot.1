Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E14C3600B
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B64681DED;
	Tue, 25 Mar 2025 15:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="jP3fAqQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12D8C80F70; Tue, 25 Mar 2025 09:37:45 +0100 (CET)
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com
 [95.215.58.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB101808B6
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 09:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1742891862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=h8Poz1bdNpPRgKNI9TYobhfRffrx+2CuTJ2/IKOer8g=;
 b=jP3fAqQb18XZ7oI/yWdVbr8nAAi+9ZugU279gypKnSz1nKq20LJoHWxfMWb3KSBntf506p
 Kh1zdt0SI+pwhFlcFGPq3fchc6++1Bv+MAOpg/V+4lPn7vp3oDs/xoLCBq7OmrGRWvv0LM
 0fbnX1Yvf7divaAfEbNs/L+g3mIrlBsf6vtRt6thN7MCaEUWMp3bkJ9Mrl2Pd62UGvgSCf
 JjcxTj043LxsBI6nRoLULf8QEZqW7URqUO7LxN1RrFJwklVoZGu7Prbef7chSsnQDxfV3T
 Iwcm4t2pXrp7xVdlYs/8yJCn7rbz2auo14ZJhXS+a780Q8wECrkerHidnRSCgg==
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: [PATCH] phy: Add SDM660 support to Qualcomm QUSB2 phy
Date: Tue, 25 Mar 2025 11:37:13 +0300
Message-ID: <20250325083713.2425430-1-alexeymin@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 25 Mar 2025 15:56:16 +0100
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

Imported from Linux driver.

Note that already existing but previously unused member of
struct qusb2_phy::has_se_clk_scheme is now utilized for it's
purpose.

Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
---
 drivers/phy/qcom/phy-qcom-qusb2.c | 42 ++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index c91ba18c4ab..cabd05bf5a6 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -122,6 +122,9 @@ struct qusb2_phy_cfg {
 
 	/* true if PHY has PLL_CORE_INPUT_OVERRIDE register to reset PLL */
 	bool has_pll_override;
+
+	/* true if PHY default clk scheme is single-ended */
+	bool se_clk_scheme_default;
 };
 
 /* set of registers with offsets different per-PHY */
@@ -173,6 +176,19 @@ static const unsigned int sm6115_regs_layout[] = {
 	[QUSB2PHY_PORT_POWERDOWN] = 0xb4, [QUSB2PHY_INTR_CTRL] = 0xbc,
 };
 
+static const struct qusb2_phy_init_tbl msm8996_init_tbl[] = {
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xf8),
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
@@ -219,6 +235,18 @@ static const struct qusb2_phy_cfg sm6115_phy_cfg = {
 	.autoresume_en = BIT(3),
 };
 
+static const struct qusb2_phy_cfg sdm660_phy_cfg = {
+	.tbl = msm8996_init_tbl,
+	.tbl_num = ARRAY_SIZE(msm8996_init_tbl),
+	.regs = sm6115_regs_layout,
+
+	.has_pll_test = true,
+	.se_clk_scheme_default = false,
+	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
+	.mask_core_ready = PLL_LOCKED,
+	.autoresume_en = BIT(3),
+};
+
 static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
 	.tbl = qusb2_v2_init_tbl,
 	.tbl_num = ARRAY_SIZE(qusb2_v2_init_tbl),
@@ -316,8 +344,18 @@ static int qusb2phy_power_on(struct phy *phy)
 	/* Required to get phy pll lock successfully */
 	udelay(150);
 
+	/*
+	 * Not all the SoCs have got a readable TCSR_PHY_CLK_SCHEME
+	 * register in the TCSR so, if there's none, use the default
+	 * value hardcoded in the configuration.
+	 */
+	qphy->has_se_clk_scheme = cfg->se_clk_scheme_default;
+
 	if (cfg->has_pll_test) {
-		val |= CLK_REF_SEL;
+		if (!qphy->has_se_clk_scheme)
+			val &= ~CLK_REF_SEL;
+		else
+			val |= CLK_REF_SEL;
 
 		writel(val, qphy->base + QUSB2PHY_PLL_TEST);
 
@@ -413,6 +451,8 @@ static const struct udevice_id qusb2phy_ids[] = {
 	{ .compatible = "qcom,qusb2-phy" },
 	{ .compatible = "qcom,qcm2290-qusb2-phy",
 	  .data = (ulong)&sm6115_phy_cfg },
+	{ .compatible = "qcom,sdm660-qusb2-phy",
+	  .data = (ulong)&sdm660_phy_cfg },
 	{ .compatible = "qcom,sm6115-qusb2-phy",
 	  .data = (ulong)&sm6115_phy_cfg },
 	{ .compatible = "qcom,qusb2-v2-phy", .data = (ulong)&qusb2_v2_phy_cfg },
-- 
2.48.1

