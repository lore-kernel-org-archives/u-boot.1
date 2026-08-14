Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C087C5DF6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0523D80EA1;
	Fri, 14 Aug 2026 22:44:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F8-Unoy1OMFS; Fri, 14 Aug 2026 22:44:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3421D80DF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747456;
	bh=GPrwLJ4Busskxam3ahar6ll50HSvdZ1g5YGYwxUsRXU=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=BnWfDgu2ooFLUFyS1r1TCQRL4+cEgjn8TYFISr0pb79tw+/0FcIV75h/a/wxIh+ia
	 iIHTrZLHZaS0kJ0pmDyuAtAGACZp0J4nLdZwtx6ZoMnD04O3L1SvD8QahwMaV06cyP
	 co9EdUQVk4sxsMZxqOD0dfLtz20dJzjJy7mQ7K0hhF270Qv5hj3HDhBCKwXcDrNZ+m
	 jiRD2DrZedAN1NcdimRzTvq8b4eGTKgeNdSjSFwVf40PI075PIJOTnZ2X5ZEonJdH2
	 PfLb2KBm5MVJGaf5s8zC2mpcaJ0lgjhm1d0qdqYWu+QiMdmUFRW5Vl0Sf8/dx8IZeS
	 1YeZ55hRlR8NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3421D80DF1;
	Fri, 14 Aug 2026 22:44:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A7E68194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A31940180
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kUvVpzaMMExp for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AB72440080
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB72440080
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB72440080
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:11 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hMHMs4fHdzMlCm;
 Sat, 15 Aug 2026 00:44:09 +0200 (CEST)
Message-ID: <f7f782ee-a2bd-44b3-a83c-0c5949433a05@mailbox.org>
Date: Sat, 15 Aug 2026 00:18:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] net: add r9a06g032 MIIC driver
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, David Lechner <dlechner@baylibre.com>
References: <20260814-rzn1-2026-10-net-v2-0-ff03583dc2b0@linaro.org>
 <20260814-rzn1-2026-10-net-v2-2-ff03583dc2b0@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-net-v2-2-ff03583dc2b0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: xmk8fydoo3kg5wqzebicfde4938a3ak7
X-MBO-RS-ID: 335c16f6069388033b4
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
> @@ -886,6 +886,12 @@ config RZN1_A5PSW
>   	  Support the Advanced 5-Port ethernet switch (A5PSW) found in
>   	  the Renesas RZ/N1 SoC.
>   
> +config RZN1_MIIC

config RENESAS_RZN1_MIIC

> +	bool "Renesas RZ/N1 MIIC ethernet accessory"
> +	help
> +	  Support the MIIC ethernet accessory found in Renesas RZ/N1 SoC.
> +	  These are media converters for MII/GMII/RGMII.
> +
>   config MPC8XX_FEC
>   	bool "Fast Ethernet Controller on MPC8XX"
>   	depends on MPC8xx
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index b8f270ae233..049212b1fd2 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -95,6 +95,7 @@ obj-$(CONFIG_PIC32_ETH) += pic32_mdio.o pic32_eth.o
>   obj-$(CONFIG_RENESAS_ETHER_SWITCH) += rswitch.o
>   obj-$(CONFIG_RENESAS_RAVB) += ravb.o
>   obj-$(CONFIG_RZN1_A5PSW) += rzn1_a5psw.o
> +obj-$(CONFIG_RZN1_MIIC) += rzn1_miic.o
>   obj-$(CONFIG_RTL8139) += rtl8139.o
>   obj-$(CONFIG_RTL8169) += rtl8169.o
>   obj-$(CONFIG_SH_ETHER) += sh_eth.o
> diff --git a/drivers/net/rzn1_miic.c b/drivers/net/rzn1_miic.c
> new file mode 100644
> index 00000000000..491923d8511
> --- /dev/null
> +++ b/drivers/net/rzn1_miic.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MII/GMII/RGMII converter support
> + *
> + * Based loosely on Linux drivers/net/pcs/pcs-rzn1-miic.c
> + * and the older driver in Renesas u-boot.

U-Boot

> + */

[...]

> +static void rzn1_rin_prot_writel(struct udevice *dev, u32 reg, u32 val)
> +{
> +	struct rzn1_miic_plat *plat = dev_get_plat(dev);
> +	struct regmap *regmap = plat->regmap;
> +
> +	/* RIN: Unprotect register writes */

What is "RIN" ?

> +	regmap_write(regmap, PRCMD, 0x00a5);
> +	regmap_write(regmap, PRCMD, 0x0001);
> +	regmap_write(regmap, PRCMD, 0xfffe);
> +	regmap_write(regmap, PRCMD, 0x0001);
> +
> +	/* Do the write */
> +	regmap_write(regmap, reg, val);
> +
> +	/* Re-enable protection */
> +	regmap_write(regmap, PRCMD, 0x0000);
> +}

[...]

> + * RIN RGMII/RMII Converter setup one
> + * RGMII/RMII Converter number: 0..4
> + * if_type: Type of PHY interface, see phy_interface_t
> + */
> +void rzn1_rgmii_rmii_conv_setup(struct udevice *dev, int phy,
> +				u32 if_type, int rmii_ref_clk_out)
> +{
> +	struct rzn1_miic_plat *plat = dev_get_plat(dev);
> +	struct regmap *regmap = plat->regmap;
> +	u32 val = 0;
> +	int speed = SPEED_100;

Reverse xmas tree.

Also, drop = 0 from val assignment and simply assign it below in the 
switch/case statement ...

> +
> +	switch (if_type) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		val |= CONVCTRL_RGMII;

val = CONVCTRL_RGMII;

> +		speed = SPEED_1000;
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		val |= CONVCTRL_RMII;
> +		break;
> +	case PHY_INTERFACE_MODE_MII:
> +		val |= CONVCTRL_MII;
> +		break;

default:
  return -EINVAL;

or some such ?

> +	};
> +
> +	if (if_type == PHY_INTERFACE_MODE_RMII && rmii_ref_clk_out)
> +		val |= CONVCTRL_REF_CLK_OUT;
> +
> +	regmap_write(regmap, CONVCTRL(phy), val);
> +
> +	rzn1_rgmii_rmii_conv_speed(dev, phy, DUPLEX_FULL, speed);
> +
> +	/* reset */
> +	regmap_read(regmap, CONVRST, &val);
> +	val &= ~PHYIF_RST(phy);
> +	rzn1_rin_prot_writel(dev, CONVRST, val);
> +	udelay(1000);
> +	val |= PHYIF_RST(phy);
> +	rzn1_rin_prot_writel(dev, CONVRST, val);
> +}
> +
> +static int rzn1_miic_probe(struct udevice *dev)
> +{
> +	struct rzn1_miic_plat *plat = dev_get_plat(dev);
> +	int ret;
> +
> +	dev_warn(dev, "%s:%d\n", __func__, __LINE__);
> +
> +	/* Enable clocks */
> +	ret = clk_get_bulk(dev, &plat->bulk);
> +	if (ret) {
> +		dev_err(dev, "Failed to get clocks\n");

"Failed to get clocks (%d)\n", ret);

Please fix globally.

> +		return ret;
> +	}

Add newline here.

> +	ret = clk_enable_bulk(&plat->bulk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable clocks\n");
> +		return ret;
> +	}
[...]
