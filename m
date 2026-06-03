Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FC3CD6E60
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 23:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 767748486A;
	Thu,  4 Jun 2026 01:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YtWufxmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8656C8486D; Thu,  4 Jun 2026 01:50:15 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76ED483EF9
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 01:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-beb2063b149so1547466b.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 16:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780530613; x=1781135413; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HUsuul6n5wcluFruo5ju/pVKgwV40LeJjvNd6otuyUs=;
 b=YtWufxmDh8k1z3pwi+Gp9OMKDsHyayCYMHIVFBjixrHbbWB+9fRrMuCHS3+MvwxV8p
 3CJWybJpDWZLWI4d9lfQ3DdzG1ciyd5u0HOyfwUGspnrWFPw7LttOhuy0nKcnr1a3kwA
 dK4qZ8exLxDNl9D5u8jSG+xLjaL0MDdPQaPLYYCRuXj3MPUxJP20KQd91paTKWplSkYQ
 q7uoQIbkcbpb34XRCmEBke7tCVm1tLppqxuH3IkO6x7imbVtHp4CBPdpnug4ezScssnl
 +gBdbSoLZRzzGnHAheQPwftQ8UuWfvo5bFnsg2e+tGcqr6swhRodjY98BTrMDuB7n/wP
 XLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780530613; x=1781135413;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HUsuul6n5wcluFruo5ju/pVKgwV40LeJjvNd6otuyUs=;
 b=dHJiQ34gVNOtU72u1lAX+dhienzeAI4XH238kRhnlKlAUlwsikE12BwQZsSXZjxydE
 xXetIdGMrnW9A9EOaPDADLWA444BvYrbrdf/WxPLa4wCfNd4bCRtuSmlo7MXwbgiAidv
 x1E84phGNCAaymNvCXEJ5S0mhrMS0McBJyqeEBPvj8+YmDxoP7nQaO+tPtjL4QxD3QQZ
 5Y87VTXUD7AF9Y3DcirqjvwbkJDaak0XWIQeK69GnhHFBkohjJsO0R/t5M/F9SA/hQ46
 SfO7+gIgKmobAVCFKRiPLEQyfs3fqMXSDmV5TV0ifl/MTWUmi7tCaT16Cuh3+fvIkPuU
 1ZFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EyoJY8KUsTLwNbswqfBCvCjK+FeHQUwEDQXoRszG3UoEv5th3zoH7AX4EFJOJbb6GO3PGPK8=@lists.denx.de
X-Gm-Message-State: AOJu0YyqLG1J1P/eptvYnik6t8CV44w5kDWxs2gGkzMKAjzY4NL2mNEs
 GooM2n0B0CUOqPaPHKsMYQsFyCAeZkRRH9mZYnVLgDdQKWIxGO0Evtn/
X-Gm-Gg: Acq92OGP3R3LiUYMVjBRzjVGb6neBmKBcBVxaux04I3CSfK5liu6xp8WAnKA2MeVqMK
 bVgvfCzAhHD7oI1R71EHDFnyw1JUctUMQivvxglcys0Csus9p9FbZz1aJxCZu4Sx5UONwjJ4tij
 /lJhhfiF9qY5yj+YzShXrpHhI3Yp+/ihDIRAHzrCKNXxB43pOQpsuSr7VLV5fc7LYxrp8bv/E5S
 9HTgIxuDgLfjeSFenYMXKQtqD4wPq/Mq2V1d20c0eJaz2uvupMe9Z4c+5eblOG2eI5uinLvMQOj
 LyocPy3q+aAYDmuq/unB410p6XysZ3MLmzuWfPy+3RMYA05Kh5EmStSF1ITJjzL2lNkzvphnuJr
 PZU/ksNSu0qSO4G1pXTwXrl8fOdKChd/Y3JeapHlqGMcYvD0UuFJ1ms9ijVosf0Lf9h+DunOoeI
 6tevODCy6Kt7QdsJFeDR8P9CCxtqG660uus2ifLUEoQI6On1SLGsxez/eRm3XzU2+BFl9vGgCe
X-Received: by 2002:a17:906:730f:b0:bee:a439:87fe with SMTP id
 a640c23a62f3a-bf06afffe1bmr162692766b.7.1780530612849; 
 Wed, 03 Jun 2026 16:50:12 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559f1ac0sm218464066b.62.2026.06.03.16.50.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 16:50:11 -0700 (PDT)
Message-ID: <a200e9f6-44c9-48db-805a-c427056a91f3@gmail.com>
Date: Thu, 4 Jun 2026 01:50:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 05/10] phy: rockchip: add phy-rockchip-usb2.c
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
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

Changed V4:
restyle
remove clk
(Jonas)
split Makefile and Kconfig sort
fixup SPL_PHY_ROCKCHIP_USB2
remove DECLARE_GLOBAL_DATA_PTR
add bind rollback
use device_get_supply_regulator
use regulator_set_enable_if_allowed
use reset_assert_bulk functions
init the port in the port probe function
protect against a blank struct
remove of_xlate
remove RESET_ROCKCHIP

Changed V2:
add DM_FLAG_PROBE_AFTER_BIND
restyle
---
 drivers/phy/rockchip/Kconfig             |  14 ++
 drivers/phy/rockchip/Makefile            |   1 +
 drivers/phy/rockchip/phy-rockchip-usb2.c | 235 +++++++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 drivers/phy/rockchip/phy-rockchip-usb2.c

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 1662aef0b8fe..8b59008a303d 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -56,6 +56,20 @@ config PHY_ROCKCHIP_TYPEC
 	help
 	  Support for Rockchip USB TYPEC PHY.

+config PHY_ROCKCHIP_USB2
+	bool "Rockchip USB2 PHY"
+	depends on ARCH_ROCKCHIP
+	select PHY
+	help
+	  Support for Rockchip USB 2.0 PHY.
+
+config SPL_PHY_ROCKCHIP_USB2
+	bool "Rockchip USB2 PHY in SPL"
+	depends on ARCH_ROCKCHIP && SPL
+	select SPL_PHY
+	help
+	  Support for Rockchip USB 2.0 PHY.
+
 config PHY_ROCKCHIP_USBDP
 	bool "Rockchip USBDP COMBO PHY Driver"
 	depends on ARCH_ROCKCHIP
diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
index b5e4763572bb..725c58cf708b 100644
--- a/drivers/phy/rockchip/Makefile
+++ b/drivers/phy/rockchip/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY)	+= phy-rockchip-naneng-combphy.o
 obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
 obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
 obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
+obj-$(CONFIG_$(PHASE_)PHY_ROCKCHIP_USB2)	+= phy-rockchip-usb2.o
 obj-$(CONFIG_PHY_ROCKCHIP_USBDP)	+= phy-rockchip-usbdp.o
diff --git a/drivers/phy/rockchip/phy-rockchip-usb2.c b/drivers/phy/rockchip/phy-rockchip-usb2.c
new file mode 100644
index 000000000000..dfeeb0381cd8
--- /dev/null
+++ b/drivers/phy/rockchip/phy-rockchip-usb2.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <generic-phy.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+#include <regmap.h>
+#include <reset.h>
+
+#define BIT_WRITEABLE_SHIFT	16
+
+struct usb_phy_port_reg {
+	unsigned int offset;
+	unsigned int bitend;
+	unsigned int bitstart;
+	unsigned int disable;
+	unsigned int enable;
+};
+
+struct rockchip_usb_phy_port_cfg {
+	struct usb_phy_port_reg port_reset;
+	struct usb_phy_port_reg soft_con;
+	struct usb_phy_port_reg suspend;
+};
+
+struct rockchip_usb_phy_port_priv {
+	void __iomem *reg_base;
+	u32 reg_offset;
+	struct reset_ctl_bulk resets;
+	struct udevice *vbus_supply;
+	const struct rockchip_usb_phy_port_cfg *port_cfg;
+};
+
+static void rockchip_usb_phy_port_property_enable(struct phy *phy,
+						  const struct usb_phy_port_reg *reg,
+						  bool en)
+{
+	struct rockchip_usb_phy_port_priv *priv = dev_get_priv(phy->dev);
+	unsigned int val, mask, tmp;
+
+	if (!reg->offset && !reg->enable && !reg->disable)
+		return;
+
+	tmp = en ? reg->enable : reg->disable;
+	mask = GENMASK(reg->bitend, reg->bitstart);
+	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
+
+	regmap_write(priv->reg_base, priv->reg_offset + reg->offset, val);
+}
+
+static int rockchip_usb_phy_port_power_on(struct phy *phy)
+{
+	struct rockchip_usb_phy_port_priv *priv = dev_get_priv(phy->dev);
+	const struct rockchip_usb_phy_port_cfg *port_cfg = priv->port_cfg;
+	int ret;
+
+	if (priv->vbus_supply) {
+		ret = regulator_set_enable_if_allowed(priv->vbus_supply, true);
+		if (ret)
+			return ret;
+	}
+
+	/* Exit suspend. */
+	rockchip_usb_phy_port_property_enable(phy, &port_cfg->suspend, false);
+	udelay(2000);
+
+	return 0;
+}
+
+static int rockchip_usb_phy_port_power_off(struct phy *phy)
+{
+	struct rockchip_usb_phy_port_priv *priv = dev_get_priv(phy->dev);
+	const struct rockchip_usb_phy_port_cfg *port_cfg = priv->port_cfg;
+
+	/* Enter suspend. */
+	rockchip_usb_phy_port_property_enable(phy, &port_cfg->suspend, true);
+
+	if (!priv->vbus_supply)
+		return 0;
+
+	return regulator_set_enable_if_allowed(priv->vbus_supply, false);
+}
+
+static int rockchip_usb_phy_port_reset(struct phy *phy)
+{
+	struct rockchip_usb_phy_port_priv *priv = dev_get_priv(phy->dev);
+
+	reset_assert_bulk(&priv->resets);
+	udelay(10);
+	reset_deassert_bulk(&priv->resets);
+
+	return 0;
+}
+
+static int rockchip_usb_phy_port_init(struct phy *phy)
+{
+	struct rockchip_usb_phy_port_priv *priv = dev_get_priv(phy->dev);
+	const struct rockchip_usb_phy_port_cfg *port_cfg = priv->port_cfg;
+
+
+	/* Disable software control. */
+	rockchip_usb_phy_port_property_enable(phy, &port_cfg->soft_con, false);
+
+	/* Reset OTG port. */
+	rockchip_usb_phy_port_property_enable(phy, &port_cfg->port_reset, true);
+	mdelay(1);
+	rockchip_usb_phy_port_property_enable(phy, &port_cfg->port_reset, false);
+	udelay(1);
+	return 0;
+}
+
+static int rockchip_usb_phy_port_exit(struct phy *phy)
+{
+	struct rockchip_usb_phy_port_priv *priv = dev_get_priv(phy->dev);
+	const struct rockchip_usb_phy_port_cfg *port_cfg = priv->port_cfg;
+
+	/* Enable software control. */
+	rockchip_usb_phy_port_property_enable(phy, &port_cfg->soft_con, true);
+
+	return 0;
+}
+
+static int rockchip_usb_phy_port_probe(struct udevice *dev)
+{
+	struct rockchip_usb_phy_port_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->port_cfg = (const struct rockchip_usb_phy_port_cfg *)
+				dev_get_driver_data(dev_get_parent(dev));
+	if (!priv->port_cfg)
+		return -EINVAL;
+
+	priv->reg_base = dev_read_addr_ptr(dev_get_parent(dev_get_parent(dev)));
+	if (!priv->reg_base)
+		return -EINVAL;
+
+	ret = dev_read_u32(dev, "reg", &priv->reg_offset);
+	if (ret)
+		return ret;
+
+	ret = device_get_supply_regulator(dev, "vbus-supply", &priv->vbus_supply);
+	if (ret && ret != -ENOENT && ret != -ENOSYS) {
+		dev_err(dev, "device_get_supply_regulator failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_get_bulk(dev, &priv->resets);
+	if (ret && ret != -ENOENT && ret != -ENOTSUPP) {
+		dev_err(dev, "reset_get_bulk failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rockchip_usb_phy_bind(struct udevice *dev)
+{
+	const char *name;
+	ofnode node;
+	int ret;
+
+	dev_for_each_subnode(node, dev) {
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		name = ofnode_get_name(node);
+		dev_dbg(dev, "subnode %s\n", name);
+
+		ret = device_bind_driver_to_node(dev, "rockchip_usb_phy_port",
+						 name, node, NULL);
+		if (ret) {
+			dev_err(dev, "'%s' cannot bind 'rockchip_usb_phy_port'\n", name);
+			goto bind_fail;
+		}
+	}
+
+	return 0;
+
+bind_fail:
+	device_chld_unbind(dev, NULL);
+
+	return ret;
+}
+
+static struct phy_ops rockchip_usb_phy_port_ops = {
+	.init		= rockchip_usb_phy_port_init,
+	.exit		= rockchip_usb_phy_port_exit,
+	.power_on	= rockchip_usb_phy_port_power_on,
+	.power_off	= rockchip_usb_phy_port_power_off,
+	.reset		= rockchip_usb_phy_port_reset,
+};
+
+static const struct rockchip_usb_phy_port_cfg rk3066a_pdata = {
+	.port_reset	= {0x00, 12, 12, 0, 1},
+	.soft_con	= {0x08, 2, 2, 0, 1},
+	.suspend	= {0x08, 8, 3, (0x01 << 3), (0x2A << 3)},
+};
+
+static const struct rockchip_usb_phy_port_cfg rk3188_pdata = {
+	.port_reset	= {0x00, 12, 12, 0, 1},
+	.soft_con	= {0x08, 2, 2, 0, 1},
+	.suspend	= {0x0c, 5, 0, 0x01, 0x2A},
+};
+
+static const struct rockchip_usb_phy_port_cfg rk3288_pdata = {
+	.port_reset	= {0x00, 12, 12, 0, 1},
+	.soft_con	= {0x08, 2, 2, 0, 1},
+	.suspend	= {0x0c, 5, 0, 0x01, 0x2A},
+};
+
+static const struct udevice_id rockchip_usb_phy_ids[] = {
+	{ .compatible = "rockchip,rk3066a-usb-phy", .data = (ulong)&rk3066a_pdata },
+	{ .compatible = "rockchip,rk3188-usb-phy", .data = (ulong)&rk3188_pdata },
+	{ .compatible = "rockchip,rk3288-usb-phy", .data = (ulong)&rk3288_pdata },
+	{}
+};
+
+U_BOOT_DRIVER(rockchip_usb_phy_port) = {
+	.name		= "rockchip_usb_phy_port",
+	.id		= UCLASS_PHY,
+	.ops		= &rockchip_usb_phy_port_ops,
+	.probe		= rockchip_usb_phy_port_probe,
+	.priv_auto	= sizeof(struct rockchip_usb_phy_port_priv),
+};
+
+U_BOOT_DRIVER(rockchip_usb_phy) = {
+	.name		= "rockchip_usb_phy",
+	.id		= UCLASS_NOP,
+	.of_match	= rockchip_usb_phy_ids,
+	.bind		= rockchip_usb_phy_bind,
+};
--
2.39.5

