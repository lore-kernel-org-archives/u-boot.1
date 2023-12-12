Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C1BC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 17:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA61877F3;
	Tue, 12 Dec 2023 18:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A2338718A; Tue, 12 Dec 2023 18:39:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 843EF871AA
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 18:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38054FEC;
 Tue, 12 Dec 2023 09:40:27 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 359DF3F762;
 Tue, 12 Dec 2023 09:39:40 -0800 (PST)
Date: Tue, 12 Dec 2023 17:39:36 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de, Sam Edwards <CFSworks@gmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>
Subject: Re: [PATCH v1 2/2] spi: sunxi: Add support for R329/D1/R528/T113
 SPI controller
Message-ID: <20231212173936.3ee24e29@donnerap.manchester.arm.com>
In-Reply-To: <20231111133432.755363-3-bigunclemax@gmail.com>
References: <20231111133432.755363-1-bigunclemax@gmail.com>
 <20231111133432.755363-3-bigunclemax@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Sat, 11 Nov 2023 16:33:08 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

Hi Maksim,

thanks for sending this!

> These SoCs have two SPI controllers that are quite similar to the SPI
> on previous Allwinner SoCs. The main difference is that new SoCs
> don't have a clock divider (SPI_CCR register) inside SPI IP.
> 
> Instead SPI sample mode should be configured depending on the input clock.
> 
> For now SPI input clock source selection is not supported by this driver,
> and only HOSC@24MHz can be used as input clock. Therefore, according to
> the, manual we could change the SPI sample mode from delay half
> cycle(default) to normal.
> 
> This patch adds a quirk for this kind of SPI controllers
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> Tested-by: Sam Edwards <CFSworks@gmail.com>

Compared against the Linux driver:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> ---
>  drivers/spi/spi-sunxi.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
> index c56d82d998..9ec6b359e2 100644
> --- a/drivers/spi/spi-sunxi.c
> +++ b/drivers/spi/spi-sunxi.c
> @@ -117,6 +117,8 @@ enum sun4i_spi_bits {
>  	SPI_TCR_XCH,
>  	SPI_TCR_CS_MANUAL,
>  	SPI_TCR_CS_LEVEL,
> +	SPI_TCR_SDC,
> +	SPI_TCR_SDM,
>  	SPI_FCR_TF_RST,
>  	SPI_FCR_RF_RST,
>  	SPI_FSR_RF_CNT_MASK,
> @@ -128,6 +130,7 @@ struct sun4i_spi_variant {
>  	u32 fifo_depth;
>  	bool has_soft_reset;
>  	bool has_burst_ctl;
> +	bool has_clk_ctl;
>  };
>  
>  struct sun4i_spi_plat {
> @@ -302,7 +305,19 @@ static int sun4i_spi_claim_bus(struct udevice *dev)
>  	setbits_le32(SPI_REG(priv, SPI_TCR), SPI_BIT(priv, SPI_TCR_CS_MANUAL) |
>  		     SPI_BIT(priv, SPI_TCR_CS_ACTIVE_LOW));
>  
> -	sun4i_spi_set_speed_mode(dev->parent);
> +	if (priv->variant->has_clk_ctl) {
> +		sun4i_spi_set_speed_mode(dev->parent);
> +	} else {
> +		/*
> +		 * At this moment there is no ability to change input clock.
> +		 * Therefore, we can only use default HOSC@24MHz clock and
> +		 * set SPI sampling mode to normal
> +		 */
> +		clrsetbits_le32(SPI_REG(priv, SPI_TCR),
> +				SPI_BIT(priv, SPI_TCR_SDC) |
> +				SPI_BIT(priv, SPI_TCR_SDM),
> +				SPI_BIT(priv, SPI_TCR_SDM));
> +	}
>  
>  	return 0;
>  }
> @@ -516,6 +531,8 @@ static const u32 sun6i_spi_bits[] = {
>  	[SPI_TCR_CS_MASK]	= 0x30,
>  	[SPI_TCR_CS_MANUAL]	= BIT(6),
>  	[SPI_TCR_CS_LEVEL]	= BIT(7),
> +	[SPI_TCR_SDC]		= BIT(11),
> +	[SPI_TCR_SDM]		= BIT(13),
>  	[SPI_TCR_XCH]		= BIT(31),
>  	[SPI_FCR_RF_RST]	= BIT(15),
>  	[SPI_FCR_TF_RST]	= BIT(31),
> @@ -526,6 +543,7 @@ static const struct sun4i_spi_variant sun4i_a10_spi_variant = {
>  	.regs			= sun4i_spi_regs,
>  	.bits			= sun4i_spi_bits,
>  	.fifo_depth		= 64,
> +	.has_clk_ctl		= true,
>  };
>  
>  static const struct sun4i_spi_variant sun6i_a31_spi_variant = {
> @@ -534,6 +552,7 @@ static const struct sun4i_spi_variant sun6i_a31_spi_variant = {
>  	.fifo_depth		= 128,
>  	.has_soft_reset		= true,
>  	.has_burst_ctl		= true,
> +	.has_clk_ctl		= true,
>  };
>  
>  static const struct sun4i_spi_variant sun8i_h3_spi_variant = {
> @@ -542,6 +561,15 @@ static const struct sun4i_spi_variant sun8i_h3_spi_variant = {
>  	.fifo_depth		= 64,
>  	.has_soft_reset		= true,
>  	.has_burst_ctl		= true,
> +	.has_clk_ctl		= true,
> +};
> +
> +static const struct sun4i_spi_variant sun50i_r329_spi_variant = {
> +	.regs			= sun6i_spi_regs,
> +	.bits			= sun6i_spi_bits,
> +	.fifo_depth		= 64,
> +	.has_soft_reset		= true,
> +	.has_burst_ctl		= true,
>  };
>  
>  static const struct udevice_id sun4i_spi_ids[] = {
> @@ -557,6 +585,10 @@ static const struct udevice_id sun4i_spi_ids[] = {
>  	  .compatible = "allwinner,sun8i-h3-spi",
>  	  .data = (ulong)&sun8i_h3_spi_variant,
>  	},
> +	{
> +	  .compatible = "allwinner,sun50i-r329-spi",
> +	  .data = (ulong)&sun50i_r329_spi_variant,
> +	},
>  	{ /* sentinel */ }
>  };
>  

