Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D05C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 00:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB5F82A25;
	Mon,  2 Jun 2025 02:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ABC382A59; Mon,  2 Jun 2025 02:41:28 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B6E648291D
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 02:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B09791515;
 Sun,  1 Jun 2025 17:41:08 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48CF93F673;
 Sun,  1 Jun 2025 17:41:24 -0700 (PDT)
Date: Mon, 2 Jun 2025 01:40:43 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 6/6] net: sun8i-emac: Add support for active-low leds
 with internal PHY
Message-ID: <20250602014043.42c96b4f@minigeek.lan>
In-Reply-To: <20250601153943.2690123-7-contact@paulk.fr>
References: <20250601153943.2690123-1-contact@paulk.fr>
 <20250601153943.2690123-7-contact@paulk.fr>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun,  1 Jun 2025 17:39:43 +0200
Paul Kocialkowski <contact@paulk.fr> wrote:

Hi,

> A device-tree property is already defined to indicate that the internal
> PHY should be used with active-low leds, which corresponds to a
> specific bit in the dedicated syscon register.
> 
> Add support for setting this bit when the property is present.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/net/sun8i_emac.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> index 8433e7db2654..990a184e4b1f 100644
> --- a/drivers/net/sun8i_emac.c
> +++ b/drivers/net/sun8i_emac.c
> @@ -176,6 +176,7 @@ struct sun8i_eth_pdata {
>  	u32 reset_delays[3];
>  	int tx_delay_ps;
>  	int rx_delay_ps;
> +	bool leds_active_low;
>  };
>  
>  static int sun8i_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
> @@ -287,7 +288,8 @@ static void sun8i_adjust_link(struct emac_eth_dev *priv,
>  	writel(v, priv->mac_reg + EMAC_CTL0);
>  }
>  
> -static u32 sun8i_emac_set_syscon_ephy(struct emac_eth_dev *priv, u32 reg)
> +static u32 sun8i_emac_set_syscon_ephy(struct sun8i_eth_pdata *pdata,
> +				      struct emac_eth_dev *priv, u32 reg)
>  {
>  	if (priv->use_internal_phy) {
>  		/* H3 based SoC's that has an Internal 100MBit PHY
> @@ -295,6 +297,10 @@ static u32 sun8i_emac_set_syscon_ephy(struct emac_eth_dev *priv, u32 reg)
>  		*/
>  		reg &= ~H3_EPHY_DEFAULT_MASK;
>  		reg |=  H3_EPHY_DEFAULT_VALUE;
> +
> +		if (pdata->leds_active_low)
> +			reg |= H3_EPHY_LED_POL;

That might be nitpicking, since it worked before, but I wonder if we
should either explicitly clear the bit in an else branch, or follow the
recent Linux change to build the register up from scratch:
https://lore.kernel.org/linux-sunxi/20250423095222.1517507-1-andre.przywara@arm.com/

Cheers,
Andre

> +
>  		reg |= priv->phyaddr << H3_EPHY_ADDR_SHIFT;
>  		reg &= ~H3_EPHY_SHUTDOWN;
>  		return reg | H3_EPHY_SELECT;
> @@ -314,7 +320,7 @@ static int sun8i_emac_set_syscon(struct sun8i_eth_pdata *pdata,
>  
>  	reg = readl(priv->sysctl_reg);
>  
> -	reg = sun8i_emac_set_syscon_ephy(priv, reg);
> +	reg = sun8i_emac_set_syscon_ephy(pdata, priv, reg);
>  
>  	reg &= ~(SC_ETCS_MASK | SC_EPIT);
>  	if (priv->variant->support_rmii)
> @@ -859,6 +865,10 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
>  		printf("%s: Invalid RX delay value %d\n", __func__,
>  		       sun8i_pdata->rx_delay_ps);
>  
> +	sun8i_pdata->leds_active_low =
> +		fdtdec_get_bool(gd->fdt_blob, dev_of_offset(dev),
> +				"allwinner,leds-active-low");
> +
>  	if (fdtdec_get_bool(gd->fdt_blob, dev_of_offset(dev),
>  			    "snps,reset-active-low"))
>  		reset_flags |= GPIOD_ACTIVE_LOW;

