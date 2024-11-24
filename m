Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AB8E668AB
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 13:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B148952D;
	Sun, 24 Nov 2024 14:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=motor-comm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3C468912A; Sun, 24 Nov 2024 08:39:20 +0100 (CET)
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com
 [115.124.28.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3479F88EC9
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 08:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=motor-comm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Frank.Sae@motor-comm.com
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com
 fp:SMTPD_---.aKqrfT2_1732433942 cluster:ay29) by smtp.aliyun-inc.com;
 Sun, 24 Nov 2024 15:39:06 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 trini@konsulko.com, ycliang@andestech.com, tekieli.lukasz@gmail.com,
 frattaroli.nicolas@gmail.com
Cc: yuanlai.cui@motor-comm.com, xiaoyong.li@motor-comm.com,
 suting.hu@motor-comm.com, jie.han@motor-comm.com,
 Frank Sae <Frank.Sae@motor-comm.com>
Subject: [PATCH v1 2/2] net: phy: Add driver for Motorcomm YT8521S Gigabit
 ethernet phy
Date: Sat, 23 Nov 2024 23:38:44 -0800
Message-Id: <20241124073844.7785-2-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241124073844.7785-1-Frank.Sae@motor-comm.com>
References: <20241124073844.7785-1-Frank.Sae@motor-comm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 24 Nov 2024 14:05:49 +0100
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

Add driver for Motorcomm YT8521S Gigabit ethernet phy.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 drivers/net/phy/motorcomm.c | 90 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index a1d5eac7bf..40fde86c45 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Motorcomm YT8511/YT8531/YT8531S/YT8821 PHY driver.
+ * Motorcomm YT8511/YT8531/YT8531S/YT8821/YT8521S PHY driver.
  *
  * Copyright (C) 2024 Motorcomm Electronic Technology Co., Ltd.
  */
@@ -14,6 +14,7 @@
 #define PHY_ID_YT8531				0x4f51e91b
 #define PHY_ID_YT8821				0x4f51ea19
 #define PHY_ID_YT8531S				0x4f51e91a
+#define PHY_ID_YT8521S				0x0000011a
 #define PHY_ID_MASK				GENMASK(31, 0)
 
 /* Extended Register's Address Offset Register */
@@ -34,6 +35,17 @@
 #define YTPHY_DTS_OUTPUT_CLK_25M		25000000
 #define YTPHY_DTS_OUTPUT_CLK_125M		125000000
 
+#define YT8521S_SCR_SYNCE_ENABLE		BIT(5)
+/* 1b0 output 25m clock   *default*
+ * 1b1 output 125m clock
+ */
+#define YT8521S_SCR_CLK_FRE_SEL_125M		BIT(3)
+#define YT8521S_SCR_CLK_SRC_MASK		GENMASK(2, 1)
+#define YT8521S_SCR_CLK_SRC_PLL_125M		0
+#define YT8521S_SCR_CLK_SRC_UTP_RX		1
+#define YT8521S_SCR_CLK_SRC_SDS_RX		2
+#define YT8521S_SCR_CLK_SRC_REF_25M		3
+
 #define YT8511_EXT_CLK_GATE	0x0c
 #define YT8511_EXT_DELAY_DRIVE	0x0d
 #define YT8511_EXT_SLEEP_CTRL	0x27
@@ -1115,6 +1127,71 @@ static int yt8821_startup(struct phy_device *phydev)
 	return 0;
 }
 
+static int yt8521s_config(struct phy_device *phydev)
+{
+	struct ytphy_plat_priv *priv = phydev->priv;
+	u16 mask, val;
+	int ret;
+
+	ret = genphy_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+
+	ytphy_dt_parse(phydev);
+	switch (priv->clk_out_frequency) {
+	case YTPHY_DTS_OUTPUT_CLK_DIS:
+		mask = YT8521S_SCR_SYNCE_ENABLE;
+		val = 0;
+		break;
+	case YTPHY_DTS_OUTPUT_CLK_25M:
+		mask = YT8521S_SCR_SYNCE_ENABLE | YT8521S_SCR_CLK_SRC_MASK |
+			   YT8521S_SCR_CLK_FRE_SEL_125M;
+		val = YT8521S_SCR_SYNCE_ENABLE |
+			  FIELD_PREP(YT8521S_SCR_CLK_SRC_MASK,
+				     YT8521S_SCR_CLK_SRC_REF_25M);
+		break;
+	case YTPHY_DTS_OUTPUT_CLK_125M:
+		mask = YT8521S_SCR_SYNCE_ENABLE | YT8521S_SCR_CLK_SRC_MASK |
+			   YT8521S_SCR_CLK_FRE_SEL_125M;
+		val = YT8521S_SCR_SYNCE_ENABLE | YT8521S_SCR_CLK_FRE_SEL_125M |
+			  FIELD_PREP(YT8521S_SCR_CLK_SRC_MASK,
+				     YT8521S_SCR_CLK_SRC_PLL_125M);
+		break;
+	default:
+		pr_warn("Freq err:%u\n", priv->clk_out_frequency);
+		return -EINVAL;
+	}
+
+	ret = ytphy_modify_ext(phydev, YTPHY_SYNCE_CFG_REG, mask,
+			       val);
+	if (ret < 0)
+		return ret;
+
+	ret = ytphy_rgmii_clk_delay_config(phydev);
+	if (ret < 0)
+		return ret;
+
+	if (priv->flag & AUTO_SLEEP_DISABLED) {
+		/* disable auto sleep */
+		ret = ytphy_modify_ext(phydev,
+				       YT8531_EXTREG_SLEEP_CONTROL1_REG,
+				       YT8531_ESC1R_SLEEP_SW, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (priv->flag & KEEP_PLL_ENABLED) {
+		/* enable RXC clock when no wire plug */
+		ret = ytphy_modify_ext(phydev,
+				       YT8531_CLOCK_GATING_REG,
+				       YT8531_CGR_RX_CLK_EN, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int yt8531s_config(struct phy_device *phydev)
 {
 	struct ytphy_plat_priv *priv = phydev->priv;
@@ -1237,3 +1314,14 @@ U_BOOT_PHY_DRIVER(motorcomm8531S) = {
 	.startup	= &yt8531s_startup,
 	.shutdown	= &genphy_shutdown,
 };
+
+U_BOOT_PHY_DRIVER(motorcomm8521S) = {
+	.name		= "YT8521S Gigabit Ethernet Transceiver",
+	.uid		= PHY_ID_YT8521S,
+	.mask		= PHY_ID_MASK,
+	.features	= PHY_GBIT_FEATURES,
+	.probe		= &yt8531_probe,
+	.config		= &yt8521s_config,
+	.startup	= &yt8531s_startup,
+	.shutdown	= &genphy_shutdown,
+};
-- 
2.34.1

