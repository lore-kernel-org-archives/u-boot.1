Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0897E75426
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 12:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7A3B87259;
	Tue,  3 Oct 2023 14:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="LxCOaF6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54FCC87211; Tue,  3 Oct 2023 13:28:59 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0829C8720D
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 13:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 65A16120006;
 Tue,  3 Oct 2023 14:28:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 65A16120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1696332535;
 bh=C7+SuTThacCbJYxzrUG/Hi2HV6/B48Xufl0SY2iJ6z0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=LxCOaF6n9dF8iFYlN7NiyEMQNvLr+uzRQD3GRMy2kxoj2daIaJW5gm2Lk6QyOO0KB
 tKznvrtgbCrHRr7Idisk5o/8B7eevsiOWHVzARTnzDprRsb3IygYVw2CJzsrEIHweR
 n0Dzz9Rhsy83CKOTde0dmFFNDcRAJw7SgL28zAgbQon/9wfGMffWkg6TvP/ozISitO
 ozhT++GMRQtBaeCbWPElHwNqiDS/ljOgQ6LqfwTQMR5f8z4byuvsJxb1yj721uBhfZ
 ZnQD31RuiMf2tHF2d6DIsSLA5lsAdAxHnWLxzwu9im3P83T61TCLw96L152eKjJ6B1
 UouUphPhojXcA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue,  3 Oct 2023 14:28:55 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 3 Oct 2023 14:28:54 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <lukma@denx.de>, <seanga2@gmail.com>, <marex@denx.de>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 5/8] phy: support Amlogic A1 family
Date: Tue, 3 Oct 2023 14:28:31 +0300
Message-ID: <20231003112838.41503-6-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003112838.41503-1-avromanov@salutedevices.com>
References: <20231003112838.41503-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180316 [Oct 03 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535
 da804c0ea8918f802fc60e7a20ba49783d957ba2,
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/03 10:12:00 #22029534
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 03 Oct 2023 14:12:00 +0200
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

Setting G12A and A1 is similar, so we can use G12A phy
driver with little changes.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/phy/Kconfig           |  2 +-
 drivers/phy/meson-g12a-usb2.c | 79 ++++++++++++++++++++++++++++-------
 2 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index cf4d5908d7..60be62907d 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -190,7 +190,7 @@ config MESON_GXL_USB_PHY
 
 config MESON_G12A_USB_PHY
 	bool "Amlogic Meson G12A USB PHYs"
-	depends on PHY && ARCH_MESON && MESON_G12A
+	depends on PHY && ARCH_MESON && (MESON_G12A || MESON_A1)
 	imply REGMAP
 	help
 	  This is the generic phy driver for the Amlogic Meson G12A
diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
index 7b028784a0..90053dbea3 100644
--- a/drivers/phy/meson-g12a-usb2.c
+++ b/drivers/phy/meson-g12a-usb2.c
@@ -18,6 +18,7 @@
 #include <regmap.h>
 #include <linux/delay.h>
 #include <power/regulator.h>
+#include <power-domain.h>
 #include <reset.h>
 #include <clk.h>
 
@@ -146,18 +147,28 @@
 #define RESET_COMPLETE_TIME					1000
 #define PLL_RESET_COMPLETE_TIME					100
 
+enum meson_soc_id {
+	MESON_SOC_A1,
+	MESON_SOC_G12A,
+};
+
 struct phy_meson_g12a_usb2_priv {
 	struct regmap		*regmap;
 #if CONFIG_IS_ENABLED(CLK)
 	struct clk		clk;
 #endif
 	struct reset_ctl	reset;
+#if CONFIG_IS_ENABLED(POWER_DOMAIN)
+	struct power_domain pwrdm;
+#endif
+	int soc_id;
 };
 
 static int phy_meson_g12a_usb2_init(struct phy *phy)
 {
 	struct udevice *dev = phy->dev;
 	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
+	u32 value;
 	int ret;
 
 #if CONFIG_IS_ENABLED(CLK)
@@ -196,8 +207,7 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
 		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT2, 2) |
 		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT1, 9));
 
-	regmap_write(priv->regmap, PHY_CTRL_R18,
-		FIELD_PREP(PHY_CTRL_R18_MPLL_LKW_SEL, 1) |
+	value = FIELD_PREP(PHY_CTRL_R18_MPLL_LKW_SEL, 1) |
 		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_W, 9) |
 		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_S, 0x27) |
 		FIELD_PREP(PHY_CTRL_R18_MPLL_PFD_GAIN, 1) |
@@ -209,6 +219,11 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
 		FIELD_PREP(PHY_CTRL_R18_MPLL_ADJ_LDO, 1) |
 		PHY_CTRL_R18_MPLL_ACG_RANGE;
 
+	if (priv->soc_id == MESON_SOC_A1)
+		value |= PHY_CTRL_R18_MPLL_DCO_CLK_SEL;
+
+	regmap_write(priv->regmap, PHY_CTRL_R18, value);
+
 	udelay(PLL_RESET_COMPLETE_TIME);
 
 	/* UnReset PLL */
@@ -231,13 +246,19 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
 		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_VREF_4_0, 0) |
 		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_DBG_1_0, 0));
 
-	regmap_write(priv->regmap, PHY_CTRL_R4,
-		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_7_0, 0xf) |
-		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_15_8, 0xf) |
-		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_23_16, 0xf) |
-		PHY_CTRL_R4_TEST_BYPASS_MODE_EN |
-		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0, 0) |
-		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2, 0));
+	if (priv->soc_id == MESON_SOC_G12A)
+		regmap_write(priv->regmap, PHY_CTRL_R4,
+			FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_7_0, 0xf) |
+			FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_15_8, 0xf) |
+			FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_23_16, 0xf) |
+			PHY_CTRL_R4_TEST_BYPASS_MODE_EN |
+			FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0, 0) |
+			FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2, 0));
+	else if (priv->soc_id == MESON_SOC_A1)
+		regmap_write(priv->regmap, PHY_CTRL_R21,
+			PHY_CTRL_R21_USB2_CAL_ACK_EN |
+			PHY_CTRL_R21_USB2_TX_STRG_PD |
+			FIELD_PREP(PHY_CTRL_R21_USB2_OTG_ACA_TRIM_1_0, 2));
 
 	/* Tuning Disconnect Threshold */
 	regmap_write(priv->regmap, PHY_CTRL_R3,
@@ -246,10 +267,15 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
 		FIELD_PREP(PHY_CTRL_R3_DISC_THRESH, 3));
 
 	/* Analog Settings */
-	regmap_write(priv->regmap, PHY_CTRL_R14, 0);
-	regmap_write(priv->regmap, PHY_CTRL_R13,
-		PHY_CTRL_R13_UPDATE_PMA_SIGNALS |
-		FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
+	if (priv->soc_id == MESON_SOC_G12A) {
+		regmap_write(priv->regmap, PHY_CTRL_R14, 0);
+		regmap_write(priv->regmap, PHY_CTRL_R13,
+			PHY_CTRL_R13_UPDATE_PMA_SIGNALS |
+			FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
+	} else if (priv->soc_id == MESON_SOC_A1) {
+		regmap_write(priv->regmap, PHY_CTRL_R13,
+			FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
+	}
 
 	return 0;
 }
@@ -281,6 +307,8 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
 	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
 	int ret;
 
+	priv->soc_id = (enum meson_soc_id)dev_get_driver_data(dev);
+
 	ret = regmap_init_mem(dev_ofnode(dev), &priv->regmap);
 	if (ret)
 		return ret;
@@ -297,6 +325,22 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
 		return ret;
 	}
 
+#if CONFIG_IS_ENABLED(POWER_DOMAIN)
+	ret = power_domain_get(dev, &priv->pwrdm);
+	if (ret < 0 && ret != -ENODEV) {
+		pr_err("failed to get power domain\n");
+		return ret;
+	}
+
+	if (ret != -ENODEV) {
+		ret = power_domain_on(&priv->pwrdm);
+		if (ret < 0) {
+			pr_err("failed to enable power domain\n");
+			return ret;
+		}
+	}
+#endif
+
 #if CONFIG_IS_ENABLED(CLK)
 	ret = clk_get_by_index(dev, 0, &priv->clk);
 	if (ret < 0)
@@ -307,7 +351,14 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
 }
 
 static const struct udevice_id meson_g12a_usb2_phy_ids[] = {
-	{ .compatible = "amlogic,g12a-usb2-phy" },
+	{
+		.compatible = "amlogic,g12a-usb2-phy",
+		.data = (ulong)MESON_SOC_G12A,
+	},
+	{
+		.compatible = "amlogic,a1-usb2-phy",
+		.data = (ulong)MESON_SOC_A1,
+	},
 	{ }
 };
 
-- 
2.25.1

