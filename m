Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC24CD4F5E
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 06:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39010844CF;
	Wed, 20 May 2026 08:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="Uod08Z2j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A4CA8460E; Wed, 20 May 2026 08:03:08 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2947843B6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 08:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1779256970; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZVEFzccIQw5a0kBkuszWSCHqW0jH1BKNLcTWpEPa/61bArbt2v1PB33obF7UnRJfd3qsIwG0Ck5A+UqGgWZRvlS7DvvMmhFRNV0zbqt+nF4Ydp6EirFq3FJIaTBgTAGSiY6nYymSoed0BWvDLM7LG79ujX+wPBchEZuLuXcu9s0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779256970;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=jwresEwlssgASm1EuCYMKZ/5SrT5YgcCyPEMaREf1Rk=; 
 b=kcXZi3xfnaJKrwnjbV96gDXTOXzaecmnGjIlSUfgcdJV53/rmFTmkTNO6Y588BwvNu02Ss+uofYS4mPgJsQ/Aak0LBAoRg38nxoZmOsaxVaNq5M1unauInsYqXuAjd5QpJe7bCX/9HpO6XQ2R8VCMz7YNiJEEsOgHe2O6xMJWZU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779256970; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=jwresEwlssgASm1EuCYMKZ/5SrT5YgcCyPEMaREf1Rk=;
 b=Uod08Z2j/aB8H2f0vWNg6CSdrq08i4TZTW4KIS3ajMWc7l/AfMY6YAgovY0l9Kk5
 v0Zp2CkCOPy/+GRXvTzqAn+XGe1Py6nLjToF34jpVBfSpQV1ZDb41RYqNpYuweuy1cC
 If7JYMwZnM1nQT/+mTk4dkUTf73aCgSPy2tKBTdg=
Received: by mx.zohomail.com with SMTPS id 1779256967764318.0947474084335;
 Tue, 19 May 2026 23:02:47 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Wed, 20 May 2026 14:02:23 +0800
Subject: [PATCH] net: dwc_eth_qos_sunxi: add support for sun60i platform
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-a7a-gmac0-v1-1-ee076cb71e64@pigmoral.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBCF4VeRWXdKxmuVUvoexcUYJxqolyZWC
 uK7N+jyPxy+Dbw4Kx6qaAMnq/V2GkPQJQLd89gJ2jY0xCrOVRYr5IKxG1grpNaY5pYWOlUE4T8
 7MfZ3WK/6bCefbyCXc4RBvOeDrKL7KVKJnMkhEq6ECnVCVOQqaUrTPGfbDZPj93UR3T+g3vc/n
 ciLuLIAAAA=
X-Change-ID: 20260520-a7a-gmac0-1dffb847c401
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Andre Przywara <andre.przywara@arm.com>, Yixun Lan <dlan@gentoo.org>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779256954; l=6869;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=RbRa+rlrtkoPmeKfTlh/NcflkOxTcb7vRbKxMwFswcw=;
 b=KCH01JfWM1zrrJmWjgKw/IhwmzoboiL32zY2TULYHPrpn6f7+cmvjSxwAG9TsTVgFItFsVmC8
 gqZ3S+laa/MDXyCxAzpvddYw6XHsDy+XRgIQwdLmL876LzinwRz8ZHm
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
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

The Allwinner sun60i (A733) platform features a Synopsys DesignWare
Ethernet QOS IP, referred to as GMAC210 by the vendor. Extend the driver
to support the new variant.

The GMAC210 controller is largely compatible with the GMAC200 on the
sun55i platform, but moves the syscon registers from an external syscon
node into the device's internal memory space. It also adds two high bits
for the ETXDC field at bits 17:16, extending the TX delay value from 3
bits to 5 bits.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
This is based on the sun55i gmac1 support series [1].

A test branch is available at [2]. It is based on Yixun's A733 test
branch [3] and can be tested by following doc [4].

Link: https://lore.kernel.org/u-boot/20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech/ [1]
Link: https://github.com/pigmoral/u-boot/tree/a733/gmac0 [2]
Link: https://github.com/dlan17/u-boot/tree/allwinner/A733/next [3]
Link: https://github.com/dlan17/a733/blob/main/boot-fel.md [4]
---
 drivers/net/dwc_eth_qos.c       |  4 +++
 drivers/net/dwc_eth_qos_sunxi.c | 78 ++++++++++++++++++++++++++++++++---------
 2 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 362508ec9a2..d52eaf9776f 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1664,6 +1664,10 @@ static const struct udevice_id eqos_ids[] = {
 		.compatible = "allwinner,sun55i-a523-gmac200",
 		.data = (ulong)&eqos_sunxi_config
 	},
+	{
+		.compatible = "allwinner,sun60i-a733-gmac210",
+		.data = (ulong)&eqos_sunxi_config
+	},
 #endif
 	{ }
 };
diff --git a/drivers/net/dwc_eth_qos_sunxi.c b/drivers/net/dwc_eth_qos_sunxi.c
index 91d871dd271..11b198d87b8 100644
--- a/drivers/net/dwc_eth_qos_sunxi.c
+++ b/drivers/net/dwc_eth_qos_sunxi.c
@@ -22,8 +22,7 @@
 
 #include "dwc_eth_qos.h"
 
-#define SYSCON_REG			0x34
-
+#define SYSCON_ETXDC_H_MASK		GENMASK(17, 16)
 #define SYSCON_PHY_SELECT		BIT(15) /* 1: internal, 0: external */
 /* RMII specific bits */
 #define SYSCON_RMII_EN			BIT(13) /* 1: enable RMII (overrides EPIT) */
@@ -37,24 +36,31 @@
 #define SYSCON_ETCS_EXT_GMII		0x1
 #define SYSCON_ETCS_INT_GMII		0x2
 
+enum sunxi_gmac_type {
+	SUNXI_GMAC200,
+	SUNXI_GMAC210,
+};
+
+struct sunxi_gmac_variant {
+	u32 syscon_reg;
+	enum sunxi_gmac_type type;
+};
+
 struct sunxi_platform_data {
+	const struct sunxi_gmac_variant *variant;
+	struct regmap *regmap;
 	struct clk_bulk clks;
 	struct reset_ctl_bulk resets;
 };
 
 static int sunxi_gmac_set_syscon(struct udevice *dev,
-				 phy_interface_t interface_type)
+				 phy_interface_t interface_type,
+				 struct sunxi_platform_data *data)
 {
-	struct regmap *regmap;
+	const struct sunxi_gmac_variant *variant = data->variant;
 	u32 val, reg = 0;
 	int ret;
 
-	regmap = syscon_regmap_lookup_by_phandle(dev, "syscon");
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "Unable to map syscon\n");
-		return PTR_ERR(regmap);
-	}
-
 	if (!dev_read_u32(dev, "tx-internal-delay-ps", &val)) {
 		if (val % 100) {
 			dev_err(dev, "tx-delay must be a multiple of 100\n");
@@ -63,12 +69,20 @@ static int sunxi_gmac_set_syscon(struct udevice *dev,
 		val /= 100;
 		dev_dbg(dev, "set tx-delay to %x\n", val);
 
-		if (!FIELD_FIT(SYSCON_ETXDC_MASK, val)) {
-			dev_err(dev, "TX clock delay exceeds maximum\n");
-			return -EINVAL;
+		if (variant->type == SUNXI_GMAC210) {
+			if (!FIELD_FIT(SYSCON_ETXDC_H_MASK, val >> 3)) {
+				dev_err(dev, "TX clock delay exceeds maximum\n");
+				return -EINVAL;
+			}
+			reg |= FIELD_PREP(SYSCON_ETXDC_H_MASK, val >> 3);
+		} else {
+			if (!FIELD_FIT(SYSCON_ETXDC_MASK, val)) {
+				dev_err(dev, "TX clock delay exceeds maximum\n");
+				return -EINVAL;
+			}
 		}
 
-		reg |= FIELD_PREP(SYSCON_ETXDC_MASK, val);
+		reg |= FIELD_PREP(SYSCON_ETXDC_MASK, val & 0x7);
 	}
 
 	if (!dev_read_u32(dev, "rx-internal-delay-ps", &val)) {
@@ -105,7 +119,7 @@ static int sunxi_gmac_set_syscon(struct udevice *dev,
 		return -EINVAL;
 	}
 
-	ret = regmap_write(regmap, SYSCON_REG, reg);
+	ret = regmap_write(data->regmap, variant->syscon_reg, reg);
 	if (ret < 0) {
 		dev_err(dev, "Failed to write to syscon\n");
 		return ret;
@@ -140,7 +154,7 @@ static int eqos_start_resets_sunxi(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	return sunxi_gmac_set_syscon(dev, pdata->phy_interface);
+	return sunxi_gmac_set_syscon(dev, pdata->phy_interface, data);
 }
 
 static int eqos_stop_resets_sunxi(struct udevice *dev)
@@ -151,6 +165,16 @@ static int eqos_stop_resets_sunxi(struct udevice *dev)
 	return reset_assert_bulk(&data->resets);
 }
 
+static const struct sunxi_gmac_variant sun55i_gmac200_variant = {
+	.syscon_reg = 0x34,
+	.type = SUNXI_GMAC200,
+};
+
+static const struct sunxi_gmac_variant sun60i_gmac210_variant = {
+	.syscon_reg = 0x8000,
+	.type = SUNXI_GMAC210,
+};
+
 static int eqos_probe_resources_sunxi(struct udevice *dev)
 {
 	struct eqos_priv *eqos = dev_get_priv(dev);
@@ -171,6 +195,11 @@ static int eqos_probe_resources_sunxi(struct udevice *dev)
 
 	pdata->priv_pdata = data;
 
+	if (device_is_compatible(dev, "allwinner,sun60i-a733-gmac210"))
+		data->variant = &sun60i_gmac210_variant;
+	else
+		data->variant = &sun55i_gmac200_variant;
+
 	pdata->phy_interface = eqos->config->interface(dev);
 	if (pdata->phy_interface == PHY_INTERFACE_MODE_NA) {
 		dev_err(dev, "Failed to get PHY interface mode\n");
@@ -211,6 +240,20 @@ static int eqos_probe_resources_sunxi(struct udevice *dev)
 		}
 	}
 
+	if (data->variant->type == SUNXI_GMAC210) {
+		ret = regmap_init_mem(dev_ofnode(dev), &data->regmap);
+		if (ret) {
+			dev_err(dev, "Unable to map regmap\n");
+			return ret;
+		}
+	} else {
+		data->regmap = syscon_regmap_lookup_by_phandle(dev, "syscon");
+		if (IS_ERR(data->regmap)) {
+			dev_err(dev, "Unable to map syscon\n");
+			return PTR_ERR(data->regmap);
+		}
+	}
+
 	return 0;
 }
 
@@ -222,6 +265,9 @@ static int eqos_remove_resources_sunxi(struct udevice *dev)
 	reset_assert_bulk(&data->resets);
 	clk_disable_bulk(&data->clks);
 
+	if (data->variant->type == SUNXI_GMAC210)
+		regmap_uninit(data->regmap);
+
 	return 0;
 }
 

---
base-commit: 19da5122ca6985782f445fe873f977bf2785e113
change-id: 20260520-a7a-gmac0-1dffb847c401
prerequisite-message-id: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
prerequisite-patch-id: db8b957b36884d29a044206dcf2a8ec0a96f8a59
prerequisite-patch-id: 4c061f669ca8c96f9fe716bf1210357104ff79ea
prerequisite-patch-id: d61042c59cab37b9dbb62255ec6927df9ee37157
prerequisite-patch-id: b76ee0ddca170cc17578c7086cf2603244922486
prerequisite-patch-id: aacecf5d4bf504499bbdfc680d6e50ce8fa3027b

Best regards,
-- 
Junhui Liu <junhui.liu@pigmoral.tech>

