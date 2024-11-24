Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248D5E668AD
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 13:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C538950E;
	Sun, 24 Nov 2024 14:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=motor-comm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ADC489070; Sun, 24 Nov 2024 08:39:13 +0100 (CET)
Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com
 [115.124.28.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1DB58852D
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 08:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=motor-comm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Frank.Sae@motor-comm.com
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com
 fp:SMTPD_---.aKqrfC5_1732433928 cluster:ay29) by smtp.aliyun-inc.com;
 Sun, 24 Nov 2024 15:39:02 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 trini@konsulko.com, ycliang@andestech.com, tekieli.lukasz@gmail.com,
 frattaroli.nicolas@gmail.com
Cc: yuanlai.cui@motor-comm.com, xiaoyong.li@motor-comm.com,
 suting.hu@motor-comm.com, jie.han@motor-comm.com,
 Frank Sae <Frank.Sae@motor-comm.com>
Subject: [PATCH v1 1/2] net: phy: Add driver for Motorcomm YT8531S Gigabit
 ethernet phy
Date: Sat, 23 Nov 2024 23:38:43 -0800
Message-Id: <20241124073844.7785-1-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
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

Add driver for Motorcomm YT8531S Gigabit ethernet phy.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 drivers/net/phy/motorcomm.c | 96 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 4d67203ee7..a1d5eac7bf 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Motorcomm 8531 PHY driver.
+ * Motorcomm YT8511/YT8531/YT8531S/YT8821 PHY driver.
  *
- * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Copyright (C) 2024 Motorcomm Electronic Technology Co., Ltd.
  */
 
 #include <config.h>
@@ -13,6 +13,7 @@
 #define PHY_ID_YT8511				0x0000010a
 #define PHY_ID_YT8531				0x4f51e91b
 #define PHY_ID_YT8821				0x4f51ea19
+#define PHY_ID_YT8531S				0x4f51e91a
 #define PHY_ID_MASK				GENMASK(31, 0)
 
 /* Extended Register's Address Offset Register */
@@ -1114,6 +1115,86 @@ static int yt8821_startup(struct phy_device *phydev)
 	return 0;
 }
 
+static int yt8531s_config(struct phy_device *phydev)
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
+		mask = YT8531_SCR_SYNCE_ENABLE;
+		val = 0;
+		break;
+	case YTPHY_DTS_OUTPUT_CLK_25M:
+		mask = YT8531_SCR_SYNCE_ENABLE | YT8531_SCR_CLK_SRC_MASK |
+			   YT8531_SCR_CLK_FRE_SEL_125M;
+		val = YT8531_SCR_SYNCE_ENABLE |
+			  FIELD_PREP(YT8531_SCR_CLK_SRC_MASK,
+				     YT8531_SCR_CLK_SRC_REF_25M);
+		break;
+	case YTPHY_DTS_OUTPUT_CLK_125M:
+		mask = YT8531_SCR_SYNCE_ENABLE | YT8531_SCR_CLK_SRC_MASK |
+			   YT8531_SCR_CLK_FRE_SEL_125M;
+		val = YT8531_SCR_SYNCE_ENABLE | YT8531_SCR_CLK_FRE_SEL_125M |
+			  FIELD_PREP(YT8531_SCR_CLK_SRC_MASK,
+				     YT8531_SCR_CLK_SRC_PLL_125M);
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
+static int yt8531s_startup(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_update_link(phydev);
+	if (ret)
+		return ret;
+
+	ret = yt8531_parse_status(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 U_BOOT_PHY_DRIVER(motorcomm8511) = {
 	.name          = "YT8511 Gigabit Ethernet",
 	.uid           = PHY_ID_YT8511,
@@ -1145,3 +1226,14 @@ U_BOOT_PHY_DRIVER(motorcomm8821) = {
 	.startup	= &yt8821_startup,
 	.shutdown	= &genphy_shutdown,
 };
+
+U_BOOT_PHY_DRIVER(motorcomm8531S) = {
+	.name		= "YT8531S Gigabit Ethernet Transceiver",
+	.uid		= PHY_ID_YT8531S,
+	.mask		= PHY_ID_MASK,
+	.features	= PHY_GBIT_FEATURES,
+	.probe		= &yt8531_probe,
+	.config		= &yt8531s_config,
+	.startup	= &yt8531s_startup,
+	.shutdown	= &genphy_shutdown,
+};
-- 
2.34.1

