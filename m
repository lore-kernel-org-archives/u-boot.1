Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3AB1112246
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 01:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFCED83D8A;
	Thu,  2 Apr 2026 03:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CbtOQGzf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E7F83F7D; Thu,  2 Apr 2026 03:32:33 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CD5680517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 03:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-66a87f29614so68761a12.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 18:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775093551; x=1775698351; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lLkAFOgsZZx2THCGIorQ5aZlMSxba6nPnHjhixmmauI=;
 b=CbtOQGzf4LcfChjum6mtRjj690AG2yYOpfK5k72x2rpUBNOnEkFlnU6E/uhOLuY0Qd
 fuv1RbTMV3T/iKVfIqTvfYU2cGcAlDtD6q22Z/TI+fiJVZ928YsET/5jc61ws0UE68lH
 UzKliOEO2hR8KTYp3m3oD3ljsFT3Pskw9V03cd4s3pHaYwTVbCxUEouNRN8q/EM7Ekfq
 g7FWapsPllNpf4H2jcr+8DFURfV/28CvbXq9ps9Fe6/1+1ff6r7KTw6HQJrqk2yit3SR
 XsFVwxXGSpAhVpp4jzjqV3x0PY1OJlTOuA2CJ5UTzUZg/wsizgSqqAiY8jvjuPxnhbNB
 0+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775093551; x=1775698351;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lLkAFOgsZZx2THCGIorQ5aZlMSxba6nPnHjhixmmauI=;
 b=Qk37Wci0p4dRHvekiULa/bZaw/vurlv9HNj/FPWRxRZ29WSfug19w+wOMpTKfXawyi
 nh+922sLiWsSxvHIoI6pxbDFYlE1JJteko+UDfdPe8gabGBJYN+72Dq0UxWYZntvpQT2
 FLZWf5KagYdp/MsaIVjggUAdXxwmw2ywWwCVTkVqqlPW/nzFdRC4HcDH8zdVnTULcsbd
 djdR6h5V+TsJy+L8gFjdsD2FHZ5u9pG1G1pSIMAQfpoKHzPrZUQV5VMwTYJhivXBexPI
 O5dZzbqchXRYsWknN5k3dGF1oVpED7hoTKwV+2GtbU5YuExfGsb3tiG/LR0GxP1AMvo8
 jF9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm7oexAS86VgB78EMQ8CcnS9LNEQOhraYrIsPTXhzKrmf1+daUU5zTBQJqxJH50iShICGanRU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7ufprzL6aLLxdLbVIQOvOaJrTkZv860Axw57u1eLqkj5clUIb
 UDhADFxXTpBVbpibtBh+x7Rsdw1nE5XcRrXHdxl6RPad5biYcfSEr8eq
X-Gm-Gg: ATEYQzxukWmPDvW0pE2WYO3oyonpJWOEhjWy9LpNIiO/N3by/U3oVZu19EBvzo2g1Ec
 vH5f3Ce15TQEIOpRpgqH0ymnb6TVrbcPxlTB+XRfngqS9b0iuHG8L/cnTw+v/gF1RQ9M/y8wkse
 wHPP8mUkKlag4W2/46mTN5HpC2BbATw6XfMBY/0e/lRdwsu5L7Iq/R9RGKHZSJZdArX5cwm4Fhi
 XbQVgB5wElfMlzwxoCYBQqQcuVKKk6GWTyAL6i5Wo9X1b79VgdJS6MQDUvJb1f8IpoGs04F9SB5
 EicGOXOnHNfDsR7n+gVKYZ6NJ9Xthqf/TVqvySNC8E/n+jO6XiAxFCthrFh7P103JcZBcdFHeSx
 tAs5kEtUr51cbDrRA/1MBv0uTpu724MDK4V5Vnn8n+Ko3lhsZYAEXH3suRekc/17WgTqlha6OKi
 g2jPdQPuC1pam+wKVq4StTiy5FWxQa2bAry018Ib7Dp7Hu2f5QgrucUpZAZ42SiiZCVl1Ezpc0
X-Received: by 2002:a17:907:6d05:b0:b9b:52d4:40fb with SMTP id
 a640c23a62f3a-b9c13cc2521mr142418566b.5.1775093550181; 
 Wed, 01 Apr 2026 18:32:30 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3c97218esm39367666b.9.2026.04.01.18.32.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 18:32:27 -0700 (PDT)
Message-ID: <0e0acf7c-69d6-4f98-80b8-1fcb3dc859f4@gmail.com>
Date: Thu, 2 Apr 2026 03:32:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [RFC PATCH v1 1/2] phy: rockchip: add phy-rockchip-usb2.c
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <1e443ab0-129b-42db-b224-253ba8a2f80f@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <1e443ab0-129b-42db-b224-253ba8a2f80f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Add phy-rockchip-usb2.c driver with support
for RK3066, RK3188 and RK3288 pdata.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/phy/rockchip/Kconfig             |  28 +-
 drivers/phy/rockchip/Makefile            |   5 +-
 drivers/phy/rockchip/phy-rockchip-usb2.c | 379 +++++++++++++++++++++++
 3 files changed, 400 insertions(+), 12 deletions(-)
 create mode 100644 drivers/phy/rockchip/phy-rockchip-usb2.c

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 80128335d52f..745e0ea67b8d 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -27,7 +27,7 @@ config PHY_ROCKCHIP_INNO_USB2
 	  Support for Rockchip USB2.0 PHY with Innosilicon IP block.

 config PHY_ROCKCHIP_NANENG_COMBOPHY
-	bool "Support Rockchip NANENG combo PHY Driver"
+	bool "Rockchip NANENG combo PHY Driver"
 	depends on ARCH_ROCKCHIP
 	select PHY
 	help
@@ -41,26 +41,34 @@ config PHY_ROCKCHIP_PCIE
 	  Enable this to support the Rockchip PCIe PHY.

 config PHY_ROCKCHIP_SNPS_PCIE3
-	bool "Rockchip Snps PCIe3 PHY Driver"
-	depends on PHY && ARCH_ROCKCHIP
+	bool "Rockchip SNPS PCIe3 PHY Driver"
+	depends on ARCH_ROCKCHIP
+	select PHY
 	help
 	  Support for Rockchip PCIe3 PHY with Synopsys IP block.
 	  It could support PCIe Gen3 single root complex, and could
 	  also be able splited into multiple combinations of lanes.

-config PHY_ROCKCHIP_USBDP
-	tristate "Rockchip USBDP COMBO PHY Driver"
+config PHY_ROCKCHIP_TYPEC
+	bool "Rockchip TYPEC PHY Driver"
 	depends on ARCH_ROCKCHIP
 	select PHY
 	help
-	  Enable this to support the Rockchip USB3.0/DP
-	  combo PHY with Samsung IP block.
+	  Enable this to support the Rockchip USB TYPEC PHY.

-config PHY_ROCKCHIP_TYPEC
-	bool "Rockchip TYPEC PHY Driver"
+config PHY_ROCKCHIP_USB2
+	bool "Rockchip USB2 PHY"
 	depends on ARCH_ROCKCHIP
 	select PHY
 	help
-	  Enable this to support the Rockchip USB TYPEC PHY.
+	  Support for Rockchip USB 2.0 PHY.
+
+config PHY_ROCKCHIP_USBDP
+	tristate "Rockchip USBDP COMBO PHY Driver"
+	depends on ARCH_ROCKCHIP
+	select PHY
+	help
+	  Enable this to support the Rockchip USB3.0/DP
+	  combo PHY with Samsung IP block.

 endmenu
diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
index 04200174254e..f296dc8f3d2a 100644
--- a/drivers/phy/rockchip/Makefile
+++ b/drivers/phy/rockchip/Makefile
@@ -3,11 +3,12 @@
 # Copyright (C) 2020 Amarula Solutions(India)
 #

+obj-$(CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY)	+= phy-rockchip-inno-dsidphy.o
 obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
 obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
 obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY) += phy-rockchip-naneng-combphy.o
 obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
 obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
 obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
-obj-$(CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY)	+= phy-rockchip-inno-dsidphy.o
-obj-$(CONFIG_PHY_ROCKCHIP_USBDP) += phy-rockchip-usbdp.o
+obj-$(CONFIG_PHY_ROCKCHIP_USB2)		+= phy-rockchip-usb2.o
+obj-$(CONFIG_PHY_ROCKCHIP_USBDP)	+= phy-rockchip-usbdp.o
diff --git a/drivers/phy/rockchip/phy-rockchip-usb2.c b/drivers/phy/rockchip/phy-rockchip-usb2.c
new file mode 100644
index 000000000000..4f02cd18b302
--- /dev/null
+++ b/drivers/phy/rockchip/phy-rockchip-usb2.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/lists.h>
+#include <generic-phy.h>
+#include <power/regulator.h>
+#include <regmap.h>
+#include <reset.h>
+#include <syscon.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define BIT_WRITEABLE_SHIFT	16
+#define usleep_range(a, b) udelay((b))
+
+struct usbphy_reg {
+	unsigned int offset;
+	unsigned int bitend;
+	unsigned int bitstart;
+	unsigned int disable;
+	unsigned int enable;
+};
+
+struct rockchip_usbphy_port_cfg {
+	int num_phys;
+	struct usbphy_reg port_reset;
+	struct usbphy_reg soft_con;
+	struct usbphy_reg suspend;
+};
+
+struct rockchip_usb_phy {
+	ofnode node;
+	unsigned int reg;
+	struct clk clock;
+	struct reset_ctl reset;
+	struct udevice *vbus_supply;
+};
+
+struct rockchip_usbphy_priv {
+	struct device *dev;
+	struct regmap *grf_regmap;
+	const struct rockchip_usbphy_port_cfg *port_cfg;
+	struct rockchip_usb_phy *usb_phy;
+};
+
+static void rockchip_usbphy_property_enable(struct phy *phy, const struct usbphy_reg *reg, bool en)
+{
+	struct udevice *parent = phy->dev->parent;
+	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
+	unsigned int val, mask, tmp;
+
+	tmp = en ? reg->enable : reg->disable;
+	mask = GENMASK(reg->bitend, reg->bitstart);
+	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
+
+	regmap_write(priv->grf_regmap,
+		     priv->usb_phy[phy->id].reg + reg->offset, val);
+}
+
+static const struct rockchip_usbphy_port_cfg *rockchip_usbphy_get_port_cfg(struct phy *phy)
+{
+	struct udevice *parent = phy->dev->parent;
+	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
+
+	return priv->port_cfg;
+}
+
+static int rockchip_usbphy_power_on(struct phy *phy)
+{
+	struct udevice *parent = phy->dev->parent;
+	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
+	const struct rockchip_usbphy_port_cfg *port_cfg = rockchip_usbphy_get_port_cfg(phy);
+	int ret;
+
+	if (priv->usb_phy[phy->id].vbus_supply) {
+		ret = regulator_set_enable(priv->usb_phy[phy->id].vbus_supply, true);
+		if (ret)
+			return ret;
+	}
+
+	/* Exit suspend. */
+	rockchip_usbphy_property_enable(phy, &port_cfg->suspend, false);
+	usleep_range(1500, 2000);
+
+	return 0;
+}
+
+static int rockchip_usbphy_power_off(struct phy *phy)
+{
+	struct udevice *parent = phy->dev->parent;
+	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
+	const struct rockchip_usbphy_port_cfg *port_cfg = rockchip_usbphy_get_port_cfg(phy);
+
+	/* Enter suspend. */
+	rockchip_usbphy_property_enable(phy, &port_cfg->suspend, true);
+
+	if (!priv->usb_phy[phy->id].vbus_supply)
+		return 0;
+
+	return regulator_set_enable(priv->usb_phy[phy->id].vbus_supply, false);
+}
+
+static inline int rockchip_usbphy_reset_assert(struct reset_ctl *rst)
+{
+	if (rst)
+		return reset_assert(rst);
+	else
+		return 0;
+}
+
+static inline int rockchip_usbphy_reset_deassert(struct reset_ctl *rst)
+{
+	if (rst)
+		return reset_deassert(rst);
+	else
+		return 0;
+}
+
+#define reset_control_assert(rst) rockchip_usbphy_reset_assert(rst)
+#define reset_control_deassert(rst) rockchip_usbphy_reset_deassert(rst)
+
+static int rockchip_usbphy_reset(struct phy *phy)
+{
+	struct udevice *parent = phy->dev->parent;
+	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
+
+	if (reset_valid(&priv->usb_phy[phy->id].reset)) {
+		reset_control_assert(&priv->usb_phy[phy->id].reset);
+		udelay(10);
+		reset_control_deassert(&priv->usb_phy[phy->id].reset);
+	}
+
+	return 0;
+}
+
+static int rockchip_usbphy_init(struct phy *phy)
+{
+	struct udevice *parent = phy->dev->parent;
+	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
+	const struct rockchip_usbphy_port_cfg *port_cfg = rockchip_usbphy_get_port_cfg(phy);
+	int ret;
+
+	ret = clk_enable(&priv->usb_phy[phy->id].clock);
+	if (ret) {
+		debug("failed to enable phyclk\n");
+		return ret;
+	}
+
+	/* Disable software control. */
+	rockchip_usbphy_property_enable(phy, &port_cfg->soft_con, false);
+
+	/* Reset OTG port. */
+	rockchip_usbphy_property_enable(phy, &port_cfg->port_reset, true);
+	mdelay(1);
+	rockchip_usbphy_property_enable(phy, &port_cfg->port_reset, false);
+	udelay(1);
+	return 0;
+}
+
+static int rockchip_usbphy_exit(struct phy *phy)
+{
+	struct udevice *parent = phy->dev->parent;
+	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
+	const struct rockchip_usbphy_port_cfg *port_cfg = rockchip_usbphy_get_port_cfg(phy);
+
+	/* Enable software control. */
+	rockchip_usbphy_property_enable(phy, &port_cfg->soft_con, true);
+
+	clk_disable(&priv->usb_phy[phy->id].clock);
+
+	return 0;
+}
+
+static int rockchip_usbphy_of_xlate(struct phy *phy, struct ofnode_phandle_args *args)
+{
+	struct udevice *parent = phy->dev->parent;
+	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
+	int id;
+
+	if (args->args_count != 0) {
+		debug("invalid number of arguments\n");
+		return -EINVAL;
+	}
+
+	for (id = 0; id < priv->port_cfg->num_phys; id++) {
+		if (of_live_active()) {
+			if (args->node.np == priv->usb_phy[id].node.np) {
+				phy->id = id;
+				break;
+			}
+		} else {
+			if (args->node.of_offset == priv->usb_phy[id].node.of_offset) {
+				phy->id = id;
+				break;
+			}
+		}
+	}
+
+	if (id >= priv->port_cfg->num_phys) {
+		debug("failed to get phy id\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rockchip_usbphy_get_regulator(ofnode node, char *supply_name,
+					 struct udevice **regulator)
+{
+	struct ofnode_phandle_args regulator_phandle;
+	int ret;
+
+	ret = ofnode_parse_phandle_with_args(node, supply_name,
+					     NULL, 0, 0,
+					     &regulator_phandle);
+	if (ret)
+		return ret;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_REGULATOR,
+					  regulator_phandle.node,
+					  regulator);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int rockchip_usbphy_init_port(struct rockchip_usbphy_priv *priv,
+				     ofnode node, unsigned int id)
+{
+	unsigned int reg;
+	int ret;
+
+	if (ofnode_read_u32(node, "reg", &reg)) {
+		debug("missing reg property\n");
+		return -EINVAL;
+	}
+
+	priv->usb_phy[id].node = node;
+	priv->usb_phy[id].reg = reg;
+
+	ret = reset_get_by_index_nodev(node, 0, &priv->usb_phy[id].reset);
+	if (ret)
+		debug("failed to get phy-reset\n");
+
+	ret = clk_get_by_index_nodev(node, 0, &priv->usb_phy[id].clock);
+	if (ret) {
+		debug("failed to get phyclk clock\n");
+		return ret;
+	}
+
+	ret = rockchip_usbphy_get_regulator(node, "vbus-supply", &priv->usb_phy[id].vbus_supply);
+	if (ret)
+		debug("failed to get vbus-supply\n");
+
+	return 0;
+}
+
+static int rockchip_usbphy_probe(struct udevice *dev)
+{
+	struct rockchip_usbphy_priv *priv = dev_get_priv(dev);
+	const struct rockchip_usbphy_port_cfg *port_cfg;
+	int ret, i = 0;
+	ofnode node;
+
+	port_cfg = (const struct rockchip_usbphy_port_cfg *)dev_get_driver_data(dev);
+	if (!port_cfg)
+		return -EINVAL;
+
+	priv->usb_phy = kcalloc(port_cfg->num_phys, sizeof(struct rockchip_usb_phy), GFP_KERNEL);
+
+	priv->port_cfg = port_cfg;
+
+	if (dev_read_bool(dev, "rockchip,grf"))
+		priv->grf_regmap = syscon_regmap_lookup_by_phandle(dev, "rockchip,grf");
+	else
+		priv->grf_regmap = syscon_get_regmap(dev_get_parent(dev));
+	if (IS_ERR(priv->grf_regmap))
+		return PTR_ERR(priv->grf_regmap);
+
+	dev_for_each_subnode(node, dev) {
+		if (!ofnode_valid(node)) {
+			debug("subnode %s not found\n", dev->name);
+			return -ENXIO;
+		}
+
+		if (i >= port_cfg->num_phys) {
+			debug("subnode max:%d\n", port_cfg->num_phys);
+			return -ENXIO;
+		}
+
+		ret = rockchip_usbphy_init_port(priv, node, i++);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rockchip_usbphy_bind(struct udevice *dev)
+{
+	struct udevice *usbphy_dev;
+	ofnode node;
+	const char *name;
+	int ret = 0;
+
+	dev_for_each_subnode(node, dev) {
+		if (!ofnode_valid(node)) {
+			debug("subnode %s not found\n", dev->name);
+			return -ENXIO;
+		}
+
+		name = ofnode_get_name(node);
+		debug("subnode %s\n", name);
+
+		ret = device_bind_driver_to_node(dev, "rockchip_usbphy_port",
+						 name, node, &usbphy_dev);
+		if (ret) {
+			debug("'%s' cannot bind 'rockchip_usbphy_port'\n", name);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static struct phy_ops rockchip_usbphy_ops = {
+	.init		= rockchip_usbphy_init,
+	.exit		= rockchip_usbphy_exit,
+	.power_on	= rockchip_usbphy_power_on,
+	.power_off	= rockchip_usbphy_power_off,
+	.reset		= rockchip_usbphy_reset,
+	.of_xlate	= rockchip_usbphy_of_xlate,
+};
+
+static const struct rockchip_usbphy_port_cfg rk3066a_pdata = {
+	.num_phys	= 2,
+	.port_reset	= {0x00, 12, 12, 0, 1},
+	.soft_con	= {0x08, 2, 2, 0, 1},
+	.suspend	= {0x08, 8, 3, (0x01 << 3), (0x2A << 3)},
+};
+
+static const struct rockchip_usbphy_port_cfg rk3188_pdata = {
+	.num_phys	= 2,
+	.port_reset	= {0x00, 12, 12, 0, 1},
+	.soft_con	= {0x08, 2, 2, 0, 1},
+	.suspend	= {0x0c, 5, 0, 0x01, 0x2A},
+};
+
+static const struct rockchip_usbphy_port_cfg rk3288_pdata = {
+	.num_phys	= 3,
+	.port_reset	= {0x00, 12, 12, 0, 1},
+	.soft_con	= {0x08, 2, 2, 0, 1},
+	.suspend	= {0x0c, 5, 0, 0x01, 0x2A},
+};
+
+static const struct udevice_id rockchip_usbphy_ids[] = {
+	{ .compatible = "rockchip,rk3066a-usb-phy", .data = (ulong)&rk3066a_pdata },
+	{ .compatible = "rockchip,rk3188-usb-phy", .data = (ulong)&rk3188_pdata },
+	{ .compatible = "rockchip,rk3288-usb-phy", .data = (ulong)&rk3288_pdata },
+	{}
+};
+
+U_BOOT_DRIVER(rockchip_usbphy_port) = {
+	.name		= "rockchip_usbphy_port",
+	.id		= UCLASS_PHY,
+	.ops		= &rockchip_usbphy_ops,
+};
+
+U_BOOT_DRIVER(rockchip_usbphy) = {
+	.name		= "rockchip_usbphy",
+	.id		= UCLASS_NOP,
+	.of_match	= rockchip_usbphy_ids,
+	.probe		= rockchip_usbphy_probe,
+	.bind		= rockchip_usbphy_bind,
+	.priv_auto	= sizeof(struct rockchip_usbphy_priv),
+};
--
2.39.5

