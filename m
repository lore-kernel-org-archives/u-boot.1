Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013A3CD98CE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88F0384884;
	Mon, 15 Jun 2026 23:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rO+5pshl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47B84848A2; Mon, 15 Jun 2026 23:08:04 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4EDA8484C
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68b5bae70easo589709a12.3
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781557681; x=1782162481; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aQulCecDGMReWZi+YfbbnnGi6qg+Q8vRJXqJS91LQxo=;
 b=rO+5pshlC0X0ULnaRqruVp+v4ktBRjoY6h6vjHJf5m5kyfA/nkVxrvY/QgVHJ+XgU7
 l6YUNu7nMYxp+FVlUmH8yExwm/S0+xS4DYWDqrEJcKF/xg1k5+4Uh640VEE7gc5s8pSR
 67KNu93/YDq0P6J9FBR856c/n0+PqFRnZlvGefo7+RUF620VrIMZ4aX7Y09g5JKtN/VY
 zO0bg7wiTm1E2YEuU0tS5Ii99ghJM94mhkgrZR+5VtCH8wMb0sVEB3+8dwIwm7QKkveg
 GUxDKTznT1bquaQHgLRAVnwzvvlmL+Bj7jkieOJeefguB45kr5D79YLg4V2e/4HdF/jN
 SKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781557681; x=1782162481;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aQulCecDGMReWZi+YfbbnnGi6qg+Q8vRJXqJS91LQxo=;
 b=kuStIXHDpmCKGR1FWOzEmYl+rtXNED5vl+Ag+7dEcNMTBR3pvaNZDT2/xIZTPTinGC
 v5IJ16/vMkdTWbxNejF6tivgRwxqu+g0RoCkqGxooyo6kgRDfUM8yCqNHTLkw3gjZxZR
 cYTeSIq/u5M4EL+FFnnJieEwD4LtBqG3sBqqsdwMNJqn0q+wQWHhroWd1Sgecla+QD3e
 xkwgYJVuEIjUptrR2/ds2Guw/qeA037EhDtZgAOBSH5KJa9yFGlfheaxlTFBPKdZYFEP
 BdAbGxY+MWshNiPXHlvv7/zbGyT5jORMwhXQlf8rMYa6xkjm9OPtFE4i0s17GZfjyzva
 Izlw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9og8fohiyXJZdi+aldF0jnSt2zYhe7O1s0WEwDwjrv+9VlOhVOaJ7H6NDlGRLpja/WbpzUWWk=@lists.denx.de
X-Gm-Message-State: AOJu0YwbUTGZtqhK6xVFV0DwheAI7R3ItmQBhHtt8YclFrZYS9r1la1M
 ueQuJ0yLLzjihnY7XmdzM5ApzA4X/Zz2apnyUNoHSSWmrAM8X69GV6f/
X-Gm-Gg: Acq92OE7FuaUxjyzvYOhqiUwRIyLmAoNZ4vpcPQFMVr/h26SDiqGZLO45Qa/FgQIKei
 KwysHphFE+oQ+LxKk9heWMRCxM73E7BlnG3I2Sl47P9dsaIDF5U0OrdjzO64536d3VoemOumhZb
 pHkAZoy3utTjbOuZ5pmK7Nau/h2xC2olhCdat+dOIJgl/Tf+obC4WkOddn60Ashls+3y6RIPEJA
 wQ5bT5/l2knyWE+4uymj93PtIWaCPgfNVvsmlsaDdCbWuyeuCkgnwobY724rZszLK3ajt72miOR
 b6JV9wZ8mnvamHuu54c2rlMXP+8TWMkZv1uleYvGkQzuWEzWDZf7LXooMub8fLyprSOBaDVaWx+
 uuJDFyzJZuoezkQIu29i3F51Z0Vs6LDigqivLqn3nWMtN/WnQZ/yiGPfmYq3KFkz7kz9Rjb9tYo
 g/vpVH/jxDA6i9qceOnbgzFSyN0IP9gU+33dhH/btBYvjEGs7V/Y9hsZbIcMqI3A==
X-Received: by 2002:a05:6402:528e:b0:689:9d06:be69 with SMTP id
 4fb4d7f45d1cf-69378a4b1ecmr2683114a12.3.1781557681058; 
 Mon, 15 Jun 2026 14:08:01 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937938a145sm4188013a12.15.2026.06.15.14.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 14:07:59 -0700 (PDT)
Message-ID: <a76f98ee-1d62-4404-9df1-946f5a42d91f@gmail.com>
Date: Mon, 15 Jun 2026 23:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 05/10] phy: rockchip: add phy-rockchip-usb2.c
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
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

Changed V5:
remove empty line

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
 drivers/phy/rockchip/phy-rockchip-usb2.c | 234 +++++++++++++++++++++++
 3 files changed, 249 insertions(+)
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
index 000000000000..fc40a4e232d8
--- /dev/null
+++ b/drivers/phy/rockchip/phy-rockchip-usb2.c
@@ -0,0 +1,234 @@
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

