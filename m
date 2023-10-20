Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BABC001E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 00:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EDE886F7C;
	Fri, 20 Oct 2023 02:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="XHjJjyjE";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="lWhAWroI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C339D86F7D; Fri, 20 Oct 2023 02:01:34 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D2786A3C
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 02:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id BC6F75C02B2;
 Thu, 19 Oct 2023 20:01:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Thu, 19 Oct 2023 20:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1697760091; x=1697846491; bh=TxE85Savx1MmjXfVS1gR929mUOPPIXfFFJI
 rBsNBusY=; b=XHjJjyjEvjZxS9wLTN+z8mscmdQ7Kpj8WgZyULE6O40AbnNyUtP
 0d40aNP4ZApVkWrj2vFipZ6psCP+wGv66ndaue8vL3/Lx1/1zLsJDfIbX/Yz2j/K
 mFyHRqOi3xCgqw/d8u8O6+jxPvE+a0bkczFzhvmq/tS7jLCaAa0PC+AROiSyBFGn
 HMAEy280az2TeLLMu5Ng50qb6DGB2RzWpwNEEk1WTVB8RYAiRGSLnNH1QXCJ5P79
 6YP+fJTzsHJUxpw5r2qwXqQZrv1sJEGfGUSwbyr2STKM+bG7xehQ6yFMm8Fxei2+
 VLHBLPz20altDYtWLEOUYMox3sjlEp8LtBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1697760091; x=1697846491; bh=TxE85Savx1MmjXfVS1gR929mUOPPIXfFFJI
 rBsNBusY=; b=lWhAWroIR9c34TfQg8eddn01XYKqiI+8emO7CGVxhdgg/eSCoiW
 FO+gDJTu3hKAgxZJ1+1P8sSZIXIGGIgDfXcIHAyi+e85Fz4XZ78DMShPmm0Ei8b1
 0zn+viht6XbbNA4SLsCL7fynw+w9fEvObOTP8c9hslhH1vhwJAkz3v4P7+PnkU44
 TZ6VU/WheptR+TQELSrPZXaAoB7j27Z4eufCB8fjaYjlyJMRHbbz32gLYgbJCw9l
 3zrpnBLrIYfWNcJpMpbzh+dvlDPPWKJt+DmykBiSXe9BkiPWllrPC13Juxjs1ifQ
 z2iCRRf6fGtD18iHmSanMJVtTgKNVHjMw6w==
X-ME-Sender: <xms:W8MxZaiVX8j5nDz9y3BP6G9XzoCUiceWFp2pf40Y5UgsWVxqEAqM8Q>
 <xme:W8MxZbDE_R8udYorTQ4nBMIJ1NPyiyCySryrPAZmdUt3ltMQNYlsTblFDGskW0ORO
 8aNqHo4PWaKOc3v4A>
X-ME-Received: <xmr:W8MxZSE3Y4eEknCnixa1uTH3xsY4z7oBo7jswSQCVT5AfuLEn6_YYuUDaJq4afUmfpU6DUEyN8hx_FqzmcPIOWbA5EDSzn1eOND3q0uJbyVDJNCSRHDaEgLA7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeejgddvlecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
 tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:W8MxZTSLFX7R0L0oozzB2CciM-zXIXlK8tUMXr9AR1XCH5_g8S9Zjw>
 <xmx:W8MxZXzBcLJ7EO--lDMLVgmgJXI0SHILzmwf2PHzj_ar_-GTBzSGKw>
 <xmx:W8MxZR5mDq80QJJ3kcCfywauJtoOnANZkIccniI7aNwKXC8hshkpLQ>
 <xmx:W8MxZekpQrn68rlqbUyL_BPQNH0-T5kgYQ1dhiW7NWZG3jeQTcOvNw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Oct 2023 20:01:30 -0400 (EDT)
Message-ID: <b8ab813d-790c-f1e4-bf77-29c7a2030464@sholland.org>
Date: Thu, 19 Oct 2023 19:01:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 02/22] net: sunxi_emac: chase DT nodes to find PHY
 regulator
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng
 <uwu@icenowy.me>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>, Okhunjon Sobirjonov
 <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@foss.arm.com, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-3-andre.przywara@arm.com>
From: Samuel Holland <samuel@sholland.org>
In-Reply-To: <20230928215455.28094-3-andre.przywara@arm.com>
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

Hi Andre,

On 9/28/23 16:54, Andre Przywara wrote:
> At the moment the sun4i EMAC driver relies on hardcoded CONFIG_MACPWR
> Kconfig symbols to enable potential PHY regulators. As we want to get rid
> of those, we need to find the regulator by chasing up the DT.
> 
> The sun4i-emac binding puts the PHY regulator into the MDIO node, which
> is the parent of the PHY device. U-Boot does not have (and does not
> need) an MDIO driver, so we need to chase down the regulator through the
> EMAC node: we follow the "phy-handle" property to find the PHY node,
> then go up to its parent, where we find the "phy-supply" link to the
> regulator. Let U-Boot find the associated regulator device, and put that
> into the private device struct, so we can find and enable the regulator
> at probe time, later.

This does somewhat duplicate the logic from dm_eth_connect_phy_handle(),
and putting the regulator in a UCLASS_MDIO device's probe function would
work out cleanly (albeit with the usual DM overhead). But that can be a
later refactoring.

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  drivers/net/sunxi_emac.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/net/sunxi_emac.c b/drivers/net/sunxi_emac.c
> index 4c90d4b4981..f1f0e5bbbb2 100644
> --- a/drivers/net/sunxi_emac.c
> +++ b/drivers/net/sunxi_emac.c
> @@ -17,6 +17,7 @@
>  #include <net.h>
>  #include <asm/io.h>
>  #include <asm/arch/clock.h>
> +#include <power/regulator.h>
>  
>  /* EMAC register  */
>  struct emac_regs {
> @@ -165,6 +166,7 @@ struct emac_eth_dev {
>  	struct phy_device *phydev;
>  	int link_printed;
>  	uchar rx_buf[EMAC_RX_BUFSIZE];
> +	struct udevice *phy_reg;
>  };
>  
>  struct emac_rxhdr {
> @@ -572,6 +574,9 @@ static int sunxi_emac_eth_probe(struct udevice *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (priv->phy_reg)
> +		regulator_set_enable(priv->phy_reg, true);
> +
>  	return sunxi_emac_init_phy(priv, dev);
>  }
>  
> @@ -585,9 +590,43 @@ static const struct eth_ops sunxi_emac_eth_ops = {
>  static int sunxi_emac_eth_of_to_plat(struct udevice *dev)
>  {
>  	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct emac_eth_dev *priv = dev_get_priv(dev);
> +	struct ofnode_phandle_args args;
> +	ofnode mdio_node;
> +	int ret;
>  
>  	pdata->iobase = dev_read_addr(dev);
>  
> +	/* The PHY regulator is in the MDIO node, not the EMAC or PHY node. */
> +	ret = dev_read_phandle_with_args(dev, "phy-handle", NULL, 0, 0, &args);

You can use dev_get_phy_node() here. Either way:

Reviewed-by: Samuel Holland <samuel@sholland.org>

> +	if (ret) {
> +		dev_err(dev, "failed to get PHY node\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * U-Boot does not have (and does not need) a device driver for the
> +	 * MDIO device, so just "pass through" that DT node to get to the
> +	 * regulator phandle.
> +	 * The PHY regulator is optional, though: ignore if we cannot find
> +	 * a phy-supply property.
> +	 */
> +	mdio_node = ofnode_get_parent(args.node);
> +	ret= ofnode_parse_phandle_with_args(mdio_node, "phy-supply", NULL, 0, 0,
> +					    &args);
> +	if (ret && ret != -ENOENT) {
> +		dev_err(dev, "failed to get PHY supply node\n");
> +		return ret;
> +	}
> +	if (!ret) {
> +		ret = uclass_get_device_by_ofnode(UCLASS_REGULATOR, args.node,
> +						  &priv->phy_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to get PHY regulator node\n");
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  

