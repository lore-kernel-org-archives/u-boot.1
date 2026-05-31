Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52EFCD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D60F8039B;
	Sun, 31 May 2026 23:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o0mx+Pqs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D7E846FA; Sun, 31 May 2026 23:02:55 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6718280077
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-68d05f6b3cbso155158a12.1
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780261372; x=1780866172; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RYISJucFD1VF+t5iC3jOKIc27BgCSYz6GAnvjQq4m3c=;
 b=o0mx+PqsOBdlFbNcCoq7mNLJl6paoTRBbN2V/A3sz0jLlKUV8pdut4LQk7WS6ZY4AT
 BzayD9oBz+JycAIxmSWaAFmz0PNLA1DaDDOO1IxMVoeMSQPNDbTexkXONqua1ZqdsHXH
 fgM0aI5TJdvKpeJBPsNXNmBfvXsl8Uggb89gPVAohUWREBMnBAiB28q+XCXqsRVL4fzw
 0SOyqJ0UyoQc2OzpBe+/wr0Jklw2PYxn9B20H8zqxV4eAyHnFBwmOrXr0Bc4H6RtFMsl
 2ajxUAXlSm1RnrG3vIwVy0JIb1nk9FSs9XKGk9WFD8TQiWtCI5v7TPeUntLPxb3zEW/t
 KNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780261372; x=1780866172;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RYISJucFD1VF+t5iC3jOKIc27BgCSYz6GAnvjQq4m3c=;
 b=me/SLHR6GA7BpdLYFslNWeqzPTY77c9i0ob5spZCksAqRB4n52WjzgFW6Re6kMVH14
 iloeZ9bAwjVhO9/JeyLueWyLIaD90lZgHB+zio65msNH6iMHaO8Zqd0TOceKbPmKlpJ4
 HJt1M6+ziMLynfQvrzpfO2yFzTlwnnWeGtZq2iLRqDOdGwW1JL16bog3G9xRRdM3wMjL
 naMD/89EW+XpGQk/3AoeREi51Gw1oFdls5mo22r7fk3sGGRYNFY4QRHPDMd0e+7E88eG
 FguSwRMXCaBp6maILYRjo84KSHBo25cjgqU5oG8KN/f+tzmBC6csNaA4Cmr//6jAkGPp
 J5QA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZC1BlQcDlG50aqTNnfW19jzJG6awZP6iL5bpKK2Fl3xUBHJt7mNxvnkepUlmz1DGOHeie3PI=@lists.denx.de
X-Gm-Message-State: AOJu0YzjRbKw8vlM1OtlmfeMtjC0QAyWI88tuuO/xxN/NrjxA4Y/km87
 0PAhvZE6dcyaU/kelVJj+bzr4iRV5hz7Tiaw1gRob59/i16MNgsKPR9Q
X-Gm-Gg: Acq92OGLuWzzPDa8b80J+Hq8Q1tLy+IMveHe+aNvDrBUy3KEjkyGto7m1aXXsF3hNAn
 vdrgCkiQvsurnXaMCCdyYxMaXOgBSZmx21z014jghDAbylDOX5OBKHgbSKUg10SEl4ZAKVDBCdn
 8RybCW0JOFyPYO634NAg1w4XEsjjsX42v29F4c/MP+bK4B6AeKxS3D21BnGRFHzpxAfoktgOnGF
 HvFupmkEVGoY9DNXWAsf1tKAO9K1trGmhfZydCE2szMbi9D/RZEmvN7omQEHN+90ZREcO9pctpr
 9f7nKsKC/SxrQj76ga8wn9UcRR39ejmnYxL6kdBK0DctRqB8bbHGO8XHpSQ1IyFSku+RQLMgvJg
 8L/FW/+uZD/OrRRh+QVp2b5S+We9+A177w8Nox8/T8jqWAW0BBnCJ08xvsLU/t6GI+f1QvuAlQf
 FVL1knbX8a5EFSxT9v5xIdmZ650iXetGBR89FwEaypduI93A/x7Cq70KLKmqc32lQc8/XHSsIY
X-Received: by 2002:a05:6402:1cc2:b0:676:e693:27db with SMTP id
 4fb4d7f45d1cf-68c87d85b34mr1454519a12.0.1780261371669; 
 Sun, 31 May 2026 14:02:51 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68ceb79179fsm1236756a12.2.2026.05.31.14.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:02:50 -0700 (PDT)
Message-ID: <e2d9f689-d54f-4cbf-b388-2a3c504d2565@gmail.com>
Date: Sun, 31 May 2026 23:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 05/12] phy: rockchip: add phy-rockchip-usb2.c
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
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

Changed V2:
add DM_FLAG_PROBE_AFTER_BIND
restyle
---
 drivers/phy/rockchip/Kconfig             |  28 +-
 drivers/phy/rockchip/Makefile            |   5 +-
 drivers/phy/rockchip/phy-rockchip-usb2.c | 371 +++++++++++++++++++++++
 3 files changed, 392 insertions(+), 12 deletions(-)
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
index 000000000000..89a847ceaa05
--- /dev/null
+++ b/drivers/phy/rockchip/phy-rockchip-usb2.c
@@ -0,0 +1,371 @@
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
+	priv->port_cfg = port_cfg;
+
+	priv->usb_phy = kcalloc(port_cfg->num_phys, sizeof(struct rockchip_usb_phy), GFP_KERNEL);
+	if (!priv->usb_phy)
+		return -ENOMEM;
+
+	priv->grf_regmap = syscon_get_regmap(dev_get_parent(dev));
+	if (IS_ERR(priv->grf_regmap))
+		return PTR_ERR(priv->grf_regmap);
+
+	dev_for_each_subnode(node, dev) {
+		if (!ofnode_is_enabled(node))
+			continue;
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
+	ofnode node;
+	int ret;
+
+	dev_for_each_subnode(node, dev) {
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		ret = device_bind_driver_to_node(dev, "rockchip_usbphy_port",
+						 ofnode_get_name(node), node, NULL);
+		if (ret) {
+			debug("cannot bind rockchip_usbphy_port\n");
+			return ret;
+		}
+	}
+
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
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

