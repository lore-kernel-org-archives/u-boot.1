Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10846CD6E55
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 22:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 657D88039B;
	Mon,  1 Jun 2026 00:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TBluUqiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E32F68405A; Mon,  1 Jun 2026 00:00:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4CCE80077
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 00:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cd95=D5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1780264814;
 bh=ETrPfIpmAoYge5bLKM/qy5XFCOGESMuRQpqLDuUmXSg=;
 b=TBluUqiEnvB+sGIMCtx8FDl/dUWlhbvQikD9TRzfImBsEyJEEFI4jXdSnZpyI5ePNRwlCzPjX
 A4n+FWEpI/4f4FMxk9brn8axYouN6ON3pz48PUWMIC9JarD87IMBbJ6mgpIPKzdBR8suJWvfuhg
 CYghZvmyaWw0EyrNTLrE4uJk0ZaBT/PkTCCkDDoBn4nZXhMuYwLO4Ws8WmTa9CIiL5mktRsPVG+
 0OqmgVqDNPVcnt9Z9I36UGr1o5s/5gV+fq16SoWqBuogKeC0Qdz9YzQvJZ6j5O/iMJO6KgnhjUW
 bhqf4FBNKmZ6wGi0k10gNSMYUxtbRU/pC0sEkZ4YUbUQ==
X-Forward-Email-ID: 6a1caf69ebb34a99f1068e87
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <797984f4-a92e-4f0b-bde9-c67fe6cfc640@kwiboo.se>
Date: Mon, 1 Jun 2026 00:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] phy: rockchip: add phy-rockchip-usb2.c
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 trini@konsulko.com, hl@rock-chips.com, jernej.skrabec@gmail.com,
 w.egorov@phytec.de, jagan@amarulasolutions.com, heiko@sntech.de,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
 <e2d9f689-d54f-4cbf-b388-2a3c504d2565@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e2d9f689-d54f-4cbf-b388-2a3c504d2565@gmail.com>
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

Hi Johan,

On 5/31/2026 11:02 PM, Johan Jonker wrote:
> Add phy-rockchip-usb2.c driver with support
> for RK3066, RK3188 and RK3288 pdata.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V2:
> add DM_FLAG_PROBE_AFTER_BIND
> restyle
> ---
>  drivers/phy/rockchip/Kconfig             |  28 +-
>  drivers/phy/rockchip/Makefile            |   5 +-
>  drivers/phy/rockchip/phy-rockchip-usb2.c | 371 +++++++++++++++++++++++
>  3 files changed, 392 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-usb2.c
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index 80128335d52f..745e0ea67b8d 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -27,7 +27,7 @@ config PHY_ROCKCHIP_INNO_USB2
>  	  Support for Rockchip USB2.0 PHY with Innosilicon IP block.
> 
>  config PHY_ROCKCHIP_NANENG_COMBOPHY
> -	bool "Support Rockchip NANENG combo PHY Driver"
> +	bool "Rockchip NANENG combo PHY Driver"
>  	depends on ARCH_ROCKCHIP
>  	select PHY
>  	help
> @@ -41,26 +41,34 @@ config PHY_ROCKCHIP_PCIE
>  	  Enable this to support the Rockchip PCIe PHY.
> 
>  config PHY_ROCKCHIP_SNPS_PCIE3
> -	bool "Rockchip Snps PCIe3 PHY Driver"
> -	depends on PHY && ARCH_ROCKCHIP
> +	bool "Rockchip SNPS PCIe3 PHY Driver"
> +	depends on ARCH_ROCKCHIP
> +	select PHY
>  	help
>  	  Support for Rockchip PCIe3 PHY with Synopsys IP block.
>  	  It could support PCIe Gen3 single root complex, and could
>  	  also be able splited into multiple combinations of lanes.
> 
> -config PHY_ROCKCHIP_USBDP
> -	tristate "Rockchip USBDP COMBO PHY Driver"
> +config PHY_ROCKCHIP_TYPEC
> +	bool "Rockchip TYPEC PHY Driver"
>  	depends on ARCH_ROCKCHIP
>  	select PHY
>  	help
> -	  Enable this to support the Rockchip USB3.0/DP
> -	  combo PHY with Samsung IP block.
> +	  Enable this to support the Rockchip USB TYPEC PHY.
> 
> -config PHY_ROCKCHIP_TYPEC
> -	bool "Rockchip TYPEC PHY Driver"
> +config PHY_ROCKCHIP_USB2
> +	bool "Rockchip USB2 PHY"
>  	depends on ARCH_ROCKCHIP
>  	select PHY
>  	help
> -	  Enable this to support the Rockchip USB TYPEC PHY.
> +	  Support for Rockchip USB 2.0 PHY.
> +
> +config PHY_ROCKCHIP_USBDP
> +	tristate "Rockchip USBDP COMBO PHY Driver"
> +	depends on ARCH_ROCKCHIP
> +	select PHY
> +	help
> +	  Enable this to support the Rockchip USB3.0/DP
> +	  combo PHY with Samsung IP block.

Please do the reorder and style change in a separate patch, this patch
should just add the new phy driver.

> 
>  endmenu
> diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
> index 04200174254e..f296dc8f3d2a 100644
> --- a/drivers/phy/rockchip/Makefile
> +++ b/drivers/phy/rockchip/Makefile
> @@ -3,11 +3,12 @@
>  # Copyright (C) 2020 Amarula Solutions(India)
>  #
> 
> +obj-$(CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY)	+= phy-rockchip-inno-dsidphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
>  obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY) += phy-rockchip-naneng-combphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
>  obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
>  obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
> -obj-$(CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY)	+= phy-rockchip-inno-dsidphy.o
> -obj-$(CONFIG_PHY_ROCKCHIP_USBDP) += phy-rockchip-usbdp.o
> +obj-$(CONFIG_PHY_ROCKCHIP_USB2)		+= phy-rockchip-usb2.o
> +obj-$(CONFIG_PHY_ROCKCHIP_USBDP)	+= phy-rockchip-usbdp.o

Same here, could possible be in same Kconfig reorder patch.

> diff --git a/drivers/phy/rockchip/phy-rockchip-usb2.c b/drivers/phy/rockchip/phy-rockchip-usb2.c
> new file mode 100644
> index 000000000000..89a847ceaa05
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-usb2.c
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device.h>
> +#include <dm/lists.h>
> +#include <generic-phy.h>
> +#include <power/regulator.h>
> +#include <regmap.h>
> +#include <reset.h>
> +#include <syscon.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;

global data, gd->, is or should not be used in this file.

> +
> +#define BIT_WRITEABLE_SHIFT	16
> +#define usleep_range(a, b) udelay((b))
> +
> +struct usbphy_reg {
> +	unsigned int offset;
> +	unsigned int bitend;
> +	unsigned int bitstart;
> +	unsigned int disable;
> +	unsigned int enable;
> +};
> +
> +struct rockchip_usbphy_port_cfg {
> +	int num_phys;
> +	struct usbphy_reg port_reset;
> +	struct usbphy_reg soft_con;
> +	struct usbphy_reg suspend;
> +};
> +
> +struct rockchip_usb_phy {
> +	ofnode node;
> +	unsigned int reg;
> +	struct clk clock;
> +	struct reset_ctl reset;
> +	struct udevice *vbus_supply;
> +};
> +
> +struct rockchip_usbphy_priv {
> +	struct device *dev;
> +	struct regmap *grf_regmap;
> +	const struct rockchip_usbphy_port_cfg *port_cfg;
> +	struct rockchip_usb_phy *usb_phy;
> +};
> +
> +static void rockchip_usbphy_property_enable(struct phy *phy, const struct usbphy_reg *reg, bool en)
> +{
> +	struct udevice *parent = phy->dev->parent;
> +	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
> +	unsigned int val, mask, tmp;

Please add something like following to protect against a blank struct
usbphy_reg.

	if (!reg->offset && !reg->enable && !reg->disable)
		return;

> +
> +	tmp = en ? reg->enable : reg->disable;
> +	mask = GENMASK(reg->bitend, reg->bitstart);
> +	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
> +
> +	regmap_write(priv->grf_regmap,
> +		     priv->usb_phy[phy->id].reg + reg->offset, val);
> +}
> +
> +static const struct rockchip_usbphy_port_cfg *rockchip_usbphy_get_port_cfg(struct phy *phy)
> +{
> +	struct udevice *parent = phy->dev->parent;
> +	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);

Please do not use same strange setup as inno-usb2 phy driver, bind priv
data to the phy port device, not its parent device. There is really no
need for this port_cfg[phy-id] dance, keep each port independent from
each other.

> +
> +	return priv->port_cfg;
> +}
> +
> +static int rockchip_usbphy_power_on(struct phy *phy)
> +{
> +	struct udevice *parent = phy->dev->parent;
> +	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
> +	const struct rockchip_usbphy_port_cfg *port_cfg = rockchip_usbphy_get_port_cfg(phy);
> +	int ret;
> +
> +	if (priv->usb_phy[phy->id].vbus_supply) {
> +		ret = regulator_set_enable(priv->usb_phy[phy->id].vbus_supply, true);

Please use regulator_set_enable_if_allowed(), regulator_set_enable()
should really only be used by core or helper functions.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Exit suspend. */
> +	rockchip_usbphy_property_enable(phy, &port_cfg->suspend, false);
> +	usleep_range(1500, 2000);
> +
> +	return 0;
> +}
> +
> +static int rockchip_usbphy_power_off(struct phy *phy)
> +{
> +	struct udevice *parent = phy->dev->parent;
> +	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
> +	const struct rockchip_usbphy_port_cfg *port_cfg = rockchip_usbphy_get_port_cfg(phy);
> +
> +	/* Enter suspend. */
> +	rockchip_usbphy_property_enable(phy, &port_cfg->suspend, true);
> +
> +	if (!priv->usb_phy[phy->id].vbus_supply)
> +		return 0;
> +
> +	return regulator_set_enable(priv->usb_phy[phy->id].vbus_supply, false);

Please use regulator_set_enable_if_allowed().

> +}
> +
> +static inline int rockchip_usbphy_reset_assert(struct reset_ctl *rst)
> +{
> +	if (rst)
> +		return reset_assert(rst);
> +	else
> +		return 0;
> +}
> +
> +static inline int rockchip_usbphy_reset_deassert(struct reset_ctl *rst)
> +{
> +	if (rst)
> +		return reset_deassert(rst);
> +	else
> +		return 0;
> +}
> +
> +#define reset_control_assert(rst) rockchip_usbphy_reset_assert(rst)
> +#define reset_control_deassert(rst) rockchip_usbphy_reset_deassert(rst)

No, please use correct functions or reset_x_bulk() functions.

> +
> +static int rockchip_usbphy_reset(struct phy *phy)
> +{
> +	struct udevice *parent = phy->dev->parent;
> +	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
> +
> +	if (reset_valid(&priv->usb_phy[phy->id].reset)) {
> +		reset_control_assert(&priv->usb_phy[phy->id].reset);
> +		udelay(10);
> +		reset_control_deassert(&priv->usb_phy[phy->id].reset);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_usbphy_init(struct phy *phy)
> +{
> +	struct udevice *parent = phy->dev->parent;
> +	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
> +	const struct rockchip_usbphy_port_cfg *port_cfg = rockchip_usbphy_get_port_cfg(phy);
> +	int ret;
> +
> +	ret = clk_enable(&priv->usb_phy[phy->id].clock);
> +	if (ret) {
> +		debug("failed to enable phyclk\n");
> +		return ret;
> +	}
> +
> +	/* Disable software control. */
> +	rockchip_usbphy_property_enable(phy, &port_cfg->soft_con, false);
> +
> +	/* Reset OTG port. */
> +	rockchip_usbphy_property_enable(phy, &port_cfg->port_reset, true);
> +	mdelay(1);
> +	rockchip_usbphy_property_enable(phy, &port_cfg->port_reset, false);
> +	udelay(1);
> +	return 0;
> +}
> +
> +static int rockchip_usbphy_exit(struct phy *phy)
> +{
> +	struct udevice *parent = phy->dev->parent;
> +	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
> +	const struct rockchip_usbphy_port_cfg *port_cfg = rockchip_usbphy_get_port_cfg(phy);
> +
> +	/* Enable software control. */
> +	rockchip_usbphy_property_enable(phy, &port_cfg->soft_con, true);
> +
> +	clk_disable(&priv->usb_phy[phy->id].clock);
> +
> +	return 0;
> +}
> +
> +static int rockchip_usbphy_of_xlate(struct phy *phy, struct ofnode_phandle_args *args)
> +{
> +	struct udevice *parent = phy->dev->parent;
> +	struct rockchip_usbphy_priv *priv = dev_get_priv(parent);
> +	int id;
> +
> +	if (args->args_count != 0) {
> +		debug("invalid number of arguments\n");
> +		return -EINVAL;
> +	}
> +
> +	for (id = 0; id < priv->port_cfg->num_phys; id++) {
> +		if (of_live_active()) {
> +			if (args->node.np == priv->usb_phy[id].node.np) {
> +				phy->id = id;
> +				break;
> +			}
> +		} else {
> +			if (args->node.of_offset == priv->usb_phy[id].node.of_offset) {
> +				phy->id = id;
> +				break;
> +			}
> +		}
> +	}

This looks overly complex, you likely do not need this, each port
already has its own node and udevice, so you can just set phy->id = 0 or
use default of_xlate.

> +
> +	if (id >= priv->port_cfg->num_phys) {
> +		debug("failed to get phy id\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_usbphy_get_regulator(ofnode node, char *supply_name,
> +					 struct udevice **regulator)
> +{
> +	struct ofnode_phandle_args regulator_phandle;
> +	int ret;
> +
> +	ret = ofnode_parse_phandle_with_args(node, supply_name,
> +					     NULL, 0, 0,
> +					     &regulator_phandle);
> +	if (ret)
> +		return ret;
> +
> +	ret = uclass_get_device_by_ofnode(UCLASS_REGULATOR,
> +					  regulator_phandle.node,
> +					  regulator);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int rockchip_usbphy_init_port(struct rockchip_usbphy_priv *priv,
> +				     ofnode node, unsigned int id)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	if (ofnode_read_u32(node, "reg", &reg)) {
> +		debug("missing reg property\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->usb_phy[id].node = node;
> +	priv->usb_phy[id].reg = reg;
> +
> +	ret = reset_get_by_index_nodev(node, 0, &priv->usb_phy[id].reset);
> +	if (ret)
> +		debug("failed to get phy-reset\n");
> +
> +	ret = clk_get_by_index_nodev(node, 0, &priv->usb_phy[id].clock);
> +	if (ret) {
> +		debug("failed to get phyclk clock\n");
> +		return ret;
> +	}
> +
> +	ret = rockchip_usbphy_get_regulator(node, "vbus-supply", &priv->usb_phy[id].vbus_supply);

Please use device_get_supply_regulator() instead.

> +	if (ret)
> +		debug("failed to get vbus-supply\n");
> +
> +	return 0;
> +}
> +
> +static int rockchip_usbphy_probe(struct udevice *dev)
> +{
> +	struct rockchip_usbphy_priv *priv = dev_get_priv(dev);
> +	const struct rockchip_usbphy_port_cfg *port_cfg;
> +	int ret, i = 0;
> +	ofnode node;
> +
> +	port_cfg = (const struct rockchip_usbphy_port_cfg *)dev_get_driver_data(dev);
> +	if (!port_cfg)
> +		return -EINVAL;
> +
> +	priv->port_cfg = port_cfg;
> +
> +	priv->usb_phy = kcalloc(port_cfg->num_phys, sizeof(struct rockchip_usb_phy), GFP_KERNEL);
> +	if (!priv->usb_phy)
> +		return -ENOMEM;
> +
> +	priv->grf_regmap = syscon_get_regmap(dev_get_parent(dev));
> +	if (IS_ERR(priv->grf_regmap))
> +		return PTR_ERR(priv->grf_regmap);
> +
> +	dev_for_each_subnode(node, dev) {
> +		if (!ofnode_is_enabled(node))
> +			continue;
> +
> +		if (i >= port_cfg->num_phys) {
> +			debug("subnode max:%d\n", port_cfg->num_phys);
> +			return -ENXIO;
> +		}
> +
> +		ret = rockchip_usbphy_init_port(priv, node, i++);

Please init the port in the port probe function.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_usbphy_bind(struct udevice *dev)
> +{
> +	ofnode node;
> +	int ret;
> +
> +	dev_for_each_subnode(node, dev) {
> +		if (!ofnode_is_enabled(node))
> +			continue;
> +
> +		ret = device_bind_driver_to_node(dev, "rockchip_usbphy_port",
> +						 ofnode_get_name(node), node, NULL);
> +		if (ret) {
> +			debug("cannot bind rockchip_usbphy_port\n");
> +			return ret;

Please add proper rollback, in case first node bind and second fails.

> +		}
> +	}
> +
> +	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);

This should not be needed, please re-work driver to not need it.

> +
> +	return 0;
> +}
> +
> +static struct phy_ops rockchip_usbphy_ops = {
> +	.init		= rockchip_usbphy_init,
> +	.exit		= rockchip_usbphy_exit,
> +	.power_on	= rockchip_usbphy_power_on,
> +	.power_off	= rockchip_usbphy_power_off,
> +	.reset		= rockchip_usbphy_reset,
> +	.of_xlate	= rockchip_usbphy_of_xlate,
> +};
> +
> +static const struct rockchip_usbphy_port_cfg rk3066a_pdata = {
> +	.num_phys	= 2,
> +	.port_reset	= {0x00, 12, 12, 0, 1},
> +	.soft_con	= {0x08, 2, 2, 0, 1},
> +	.suspend	= {0x08, 8, 3, (0x01 << 3), (0x2A << 3)},
> +};
> +
> +static const struct rockchip_usbphy_port_cfg rk3188_pdata = {
> +	.num_phys	= 2,
> +	.port_reset	= {0x00, 12, 12, 0, 1},
> +	.soft_con	= {0x08, 2, 2, 0, 1},
> +	.suspend	= {0x0c, 5, 0, 0x01, 0x2A},
> +};
> +
> +static const struct rockchip_usbphy_port_cfg rk3288_pdata = {
> +	.num_phys	= 3,
> +	.port_reset	= {0x00, 12, 12, 0, 1},
> +	.soft_con	= {0x08, 2, 2, 0, 1},
> +	.suspend	= {0x0c, 5, 0, 0x01, 0x2A},
> +};
> +
> +static const struct udevice_id rockchip_usbphy_ids[] = {
> +	{ .compatible = "rockchip,rk3066a-usb-phy", .data = (ulong)&rk3066a_pdata },
> +	{ .compatible = "rockchip,rk3188-usb-phy", .data = (ulong)&rk3188_pdata },
> +	{ .compatible = "rockchip,rk3288-usb-phy", .data = (ulong)&rk3288_pdata },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(rockchip_usbphy_port) = {
> +	.name		= "rockchip_usbphy_port",
> +	.id		= UCLASS_PHY,
> +	.ops		= &rockchip_usbphy_ops,
> +};
> +
> +U_BOOT_DRIVER(rockchip_usbphy) = {
> +	.name		= "rockchip_usbphy",
> +	.id		= UCLASS_NOP,
> +	.of_match	= rockchip_usbphy_ids,
> +	.probe		= rockchip_usbphy_probe,

The probe should likely be at the port level.

> +	.bind		= rockchip_usbphy_bind,
> +	.priv_auto	= sizeof(struct rockchip_usbphy_priv),
> +};


Below is what I played around with a few weeks/months ago, not fully
working but probed correctly and priv data is tied to each port.


struct rockchip_usb_phy_priv {
	void __iomem *reg_base;
	u32 reg_offset;
	struct reset_ctl_bulk resets;
};

static int rockchip_usb_phy_reset(struct phy *phy)
{
	struct rockchip_usb_phy_priv *priv = dev_get_priv(phy->dev);

	reset_assert_bulk(&priv->resets);
	udelay(10);
	reset_deassert_bulk(&priv->resets);

	return 0;
}

static struct phy_ops rockchip_usb_phy_ops = {
	.reset = rockchip_usb_phy_reset,
};

static int rockchip_usb_phy_probe(struct udevice *dev)
{
	struct rockchip_usb_phy_priv *priv = dev_get_priv(dev);
	int ret;

	priv->reg_base = dev_read_addr_ptr(dev_get_parent(dev_get_parent(dev)));
	if (!priv->reg_base)
		return -EINVAL;

	ret = dev_read_u32(dev, "reg", &priv->reg_offset);
	if (ret)
		return ret;

	return reset_get_bulk(dev, &priv->resets);
}

static int rockchip_usb_phy_bind(struct udevice *dev)
{
	const char *name;
	ofnode node;
	int ret = 0;

	dev_for_each_subnode(node, dev) {
		if (!ofnode_is_enabled(node))
			continue;

		name = ofnode_get_name(node);
		dev_dbg(dev, "subnode %s\n", name);

		ret = device_bind_driver_to_node(dev, "rockchip_usb_phy_port",
						 name, node, NULL);
		if (ret) {
			dev_err(dev,
				"'%s' cannot bind 'rockchip_usb_phy_port'\n", name);
			goto bind_fail;
		}
	}

	return 0;

bind_fail:
	device_chld_unbind(dev, NULL);

	return ret;
}

static const struct udevice_id rockchip_usb_phy_ids[] = {
	{ .compatible = "rockchip,rk3288-usb-phy" },
	{ /* sentinel */ }
};

U_BOOT_DRIVER(rockchip_usb_phy_port) = {
	.name		= "rockchip_usb_phy_port",
	.id		= UCLASS_PHY,
	.ops		= &rockchip_usb_phy_ops,
	.probe		= rockchip_usb_phy_probe,
	.priv_auto	= sizeof(struct rockchip_usb_phy_priv),
};

U_BOOT_DRIVER(rockchip_usb_phy) = {
	.name		= "rockchip_usb_phy",
	.id		= UCLASS_NOP,
	.of_match	= rockchip_usb_phy_ids,
	.bind		= rockchip_usb_phy_bind,
};


Regards,
Jonas
