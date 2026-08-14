Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F08C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 234E740C87;
	Fri, 14 Aug 2026 22:44:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OoL5m4WESr0w; Fri, 14 Aug 2026 22:44:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A0FB40CA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747455;
	bh=IhI1Mem/nw0hMxVV8kUMpN8HCmdrYk3pDlMrgn0m8Dw=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=y5Soy3hG41mGqSbC7xehfXTrKK2l28dl9qEhdo9BBOWLGSFWh3pnjFQJbgAl/NVhF
	 u9Y1emL8+28jpwRbIKzXmaZ/ZFrezjvWZISdjyPHO6ILA9MoZB60IzB87L0jmzxCBT
	 rne029d0PI3xaYOhh5niJm1pwHASeEA+ww15YHG2Iw2EZ3gW3xtBM8HIgBDgtlSg6W
	 yIo40bqIIVqcbnVsNCHTuZxxcE/yY4+EGBtx8hR1EKwlU+feoaHKShnkXNIwa+bGx1
	 8mrMNtFelDGdCISpFXWX5Y+CWxeX3QN2p6TSpg/ttBmzZGgv97wYJ9DTkpv9IKVh0e
	 5lsWdUg+qgVdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A0FB40CA0;
	Fri, 14 Aug 2026 22:44:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DE98194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D5E880C63
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d3F1NGDXT9y5 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 890BE80AC6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 890BE80AC6
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 890BE80AC6
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:10 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hMHMr1jSkzKvvc;
 Sat, 15 Aug 2026 00:44:08 +0200 (CEST)
Message-ID: <be6669ff-b45c-441e-8dec-d878cddd191a@mailbox.org>
Date: Sat, 15 Aug 2026 00:14:53 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] net: add r9a06g032 A5PSW switch driver
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, David Lechner <dlechner@baylibre.com>
References: <20260814-rzn1-2026-10-net-v2-0-ff03583dc2b0@linaro.org>
 <20260814-rzn1-2026-10-net-v2-1-ff03583dc2b0@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-net-v2-1-ff03583dc2b0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: skrfjya57issj8xbzz67wtc1xxfygnib
X-MBO-RS-ID: b139fa4160695f0dd58
X-Rspamd-Queue-Id: 4hMHMr1jSkzKvvc
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/14/26 8:30 PM, Ralph Siemsen wrote:

[...]

> +++ b/drivers/net/Kconfig
> @@ -880,6 +880,12 @@ config RENESAS_RAVB
>   	  This driver implements support for the Ethernet AVB block in
>   	  several Renesas R-Car and RZ SoCs.
>   
> +config RZN1_A5PSW

RENESAS_RZN1_A5PSW to be consistent with the other network hardware 
prefixes used here .

> +	bool "Renesas RZ/N1 A5PSW ethernet switch"
> +	help
> +	  Support the Advanced 5-Port ethernet switch (A5PSW) found in
> +	  the Renesas RZ/N1 SoC.
> +

[...]

> +++ b/drivers/net/rzn1_a5psw.c
> @@ -0,0 +1,377 @@

[...]

> +static int rzn1_phy_wait(struct udevice *dev)
> +{
> +	struct rzn1_a5psw_plat *plat = dev_get_plat(dev->parent);
> +	struct regmap *regmap = plat->regmap;
> +	u32 timeout = 100;
> +	int ret;
> +	u32 val;

regmap_read_poll_timeout()

> +	do {
> +		ret = regmap_read(regmap, MT5PT_MDIO_CFG_STATUS, &val);
> +		if (ret == 0 && (val & BIT(0)) == 0)
> +			return 0;
> +
> +		mdelay(1);
> +	} while (--timeout);
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int rzn1_a5psw_mdio_read(struct udevice *dev, int addr, int devad, int reg)
> +{
> +	struct rzn1_a5psw_plat *plat = dev_get_plat(dev->parent);
> +	struct regmap *regmap = plat->regmap;
> +	int ret;
> +	u32 val = BIT(15) | ((addr & 0x1f) << 5) | (reg & 0x1f);
> +
> +	/* Clause 22 only */
> +	rzn1_switch_write(regmap, MT5PT_MDIO_COMMAND, val);
> +
> +	ret = rzn1_phy_wait(dev);
> +	if (ret) {
> +		dev_warn(dev, "PHY read timeout\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_read(regmap, MT5PT_MDIO_DATA, &val);
> +	if (ret) {
> +		dev_warn(dev, "PHY read error\n");
> +		return ret;
> +	}
> +	val &= 0xffff;
> +
> +	// TODO: check CFG_STATUS for READERR

This should be addressed it seems ?

> +	dev_dbg(dev, "addr=0x%x reg=0x%x read 0x%04x\n", addr, reg, val);
> +
> +	return val;
> +}
> +
> +static int rzn1_a5psw_mdio_write(struct udevice *dev, int addr, int devad,
> +				 int reg, u16 val)
> +{
> +	struct rzn1_a5psw_plat *plat = dev_get_plat(dev->parent);
> +	struct regmap *regmap = plat->regmap;
> +	int ret;
> +	u32 cmd = ((addr & 0x1f) << 5) | (reg & 0x1f);
> +
> +	dev_dbg(dev, "addr=0x%x reg=0x%x write 0x%04x\n", addr, reg, val);
> +
> +	/* Clause 22 only */
> +	rzn1_switch_write(regmap, MT5PT_MDIO_COMMAND, cmd);
> +	rzn1_switch_write(regmap, MT5PT_MDIO_DATA, val);
> +
> +	ret = rzn1_phy_wait(dev);
> +	if (ret) {
> +		dev_warn(dev, "PHY write timeout\n");

Include the error code in the message, it makes debugging easier.

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mdio_ops rzn1_a5psw_mdio_ops = {
> +	.read = rzn1_a5psw_mdio_read,
> +	.write = rzn1_a5psw_mdio_write,
> +};
> +
> +static int rzn1_a5psw_mdio_bind(struct udevice *dev)
> +{
> +	char name[32];
> +	static int num_devices;

Reverse xmas tree, but don't you have ethernet-ports {} subnode in DT 
node for the switch, from which you could derive the MDIO bus address(es) ?

Example
dts/upstream/src/arm64/freescale/imx8mn-vhip4-evalboard-ksz8794-common.dtsi

15         ksz8794: ethernet-switch@1 {
16                 compatible = "microchip,ksz8794";
...
24                 ethernet-ports {
...
28                         port@0 {
29                                 reg = <0>;
30                                 label = "lan1";
31                         };

> +	sprintf(name, "rzn1-a5psw-mdio-%d", num_devices++);
> +	device_set_name(dev, name);
> +
> +	return 0;
> +}
> +
> +U_BOOT_DRIVER(rzn1_a5psw_mdio) = {
> +	.name		= "rzn1_a5psw_mdio",
> +	.id		= UCLASS_MDIO,
> +	.ops		= &rzn1_a5psw_mdio_ops,
> +	.bind		= rzn1_a5psw_mdio_bind,
> +	.plat_auto	= sizeof(struct mdio_perdev_priv),
> +};
> +
> +static int rzn1_a5psw_port_probe(struct udevice *dev, int port, struct phy_device *phy)
> +{
> +	/* Called once when switch is probed */
> +	return phy_config(phy);
> +}
> +
> +void rzn1_rgmii_rmii_conv_speed(struct udevice *dev, int phy,
> +				int full_duplex, int speed);
> +
> +static int rzn1_a5psw_port_enable(struct udevice *dev, int port, struct phy_device *phy)
> +{
> +	struct rzn1_a5psw_plat *plat = dev_get_plat(dev);
> +
> +	/* CPU port is already enabled */
> +	if (port == 4)

4 needs to be a macro, not a magic number directly in the code.

> +		return 0;
> +
> +	/* Get speed/duplex from PHY */
> +	genphy_update_link(phy);
> +	if (!phy->link) {
> +		dev_err(dev, "PHY %s no ethernet link\n", phy->dev->name);
> +		return 0;
> +	}
> +	genphy_parse_link(phy);
> +
> +	/* Program the converter accoringly */
> +	dev_info(dev, "MIIC = %p\n", plat->miic);
> +	rzn1_rgmii_rmii_conv_speed(plat->miic, 4 - port, phy->duplex, phy->speed);
> +
> +	/* Program the switch port accordingly */
> +	dev_info(dev, "%s port=%d using speed=%d\n", __func__, port, phy->speed);
> +	rzn1_switch_port_speed_duplex(dev, port, phy->speed, phy->duplex);
> +	rzn1_switch_port_enable(dev, port);
> +	return 0;
> +}
> +
> +static void rzn1_a5psw_port_disable(struct udevice *dev, int port, struct phy_device *phy)
> +{
> +	/* CPU port is already enabled */
> +	if (port == 4)
> +		return;
> +
> +	rzn1_switch_port_disable(dev, port);
> +}
> +
> +static const struct dsa_ops rzn1_a5psw_dsa_ops = {
> +	.port_probe = rzn1_a5psw_port_probe,
> +	.port_enable = rzn1_a5psw_port_enable,
> +	.port_disable = rzn1_a5psw_port_disable,
> +};
> +
> +static int rzn1_a5psw_probe_mdio(struct udevice *dev)
> +{
> +	struct udevice *mdev;
> +	const char *name;
> +	ofnode node;
> +	int ret;
> +
> +	/* bind phy ports of mdio child node to rzn1_a5psw_mdio device */
> +	node = dev_read_subnode(dev, "mdio");
> +	if (!ofnode_valid(node))
> +		return 0;
> +
> +	name = ofnode_get_name(node);
> +	ret = device_bind_driver_to_node(dev,
> +					 "rzn1_a5psw_mdio",
> +					 name, node, NULL);
> +	if (ret) {
> +		dev_err(dev, "failed to bind %s: %d\n", name, ret);

return ret;
}

> +	} else {

Drop the else {} .

> +		/* need to probe it as there is no compatible to do so */
> +		ret = uclass_get_device_by_ofnode(UCLASS_MDIO, node, &mdev);
> +		if (ret)
> +			dev_err(dev, "failed to probe %s: %d\n", name, ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int rzn1_a5psw_probe(struct udevice *dev)
> +{
> +	struct rzn1_a5psw_plat *plat = dev_get_plat(dev);
> +	int ret;
> +
> +	dev_dbg(dev, "%s:%d\n", __func__, __LINE__);
> +
> +	/* Enable clocks */
> +	ret = clk_get_bulk(dev, &plat->bulk);
> +	if (ret) {
> +		dev_err(dev, "Failed to get clocks\n");
> +		return ret;
> +	}
> +	ret = clk_enable_bulk(&plat->bulk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable clocks\n");

"Failed to enable clocks (%d)\n", ret);

Please fix globally.

> +		return ret;
> +	}
> +
> +	/* Access the registers */
> +	ret = regmap_init_mem(dev_ofnode(dev), &plat->regmap);
> +	if (ret) {
> +		dev_err(dev, "Failed to get regmap\n");
> +		return ret;
> +	}
> +
> +	/* Find the MIIC driver */
> +	ret = uclass_get_device_by_name(UCLASS_MISC, "eth-miic@44030000", &plat->miic);
> +	if (ret) {
> +		dev_err(dev, "Failed to get MIIC\n");
> +		return ret;
> +	}
> +	dev_dbg(dev, "got MIIC %p <%s>\n", plat->miic, plat->miic->name);
> +
> +	/* Upstream port is always 1Gbps */
> +	rzn1_switch_port_speed_duplex(dev, 4, SPEED_1000, DUPLEX_FULL);
> +	rzn1_switch_port_enable(dev, 4);
> +
> +	/* Some extra resets are located in system controller */
> +	plat->syscon = syscon_regmap_lookup_by_phandle(dev, "syscon");
> +	if (IS_ERR(plat->syscon)) {
> +		dev_err(dev, "No syscon node found\n");
> +		return PTR_ERR(plat->syscon);
> +	}
> +
> +	/* Clear ETH and CLK25 resets */
> +#define RZN1_SYSCTRL_PWRCTRL_SWITCH 0x188

This goes to the beginning of this file.

> +	regmap_update_bits(plat->syscon, RZN1_SYSCTRL_PWRCTRL_SWITCH,
> +			   BIT(4) | BIT(3), BIT(4) | BIT(3));
> +
> +	/* Reset all PHYs */
> +	struct gpio_desc phy_reset_gpio;
> +	u32 phy_reset_delay;

This goes to the beginning of the function ; didn't the compiler 
complain about this ?

> +	ret = gpio_request_by_name(dev, "phy-reset-gpios", 0,
> +				   &phy_reset_gpio, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> +	if (ret) {
> +		dev_err(dev, "failed to get phy-reset-gpios: %d\n", ret);
> +		return ret;
> +	}
> +
> +	phy_reset_delay = dev_read_u32_default(dev, "phy-reset-duration", 15);
[...]
