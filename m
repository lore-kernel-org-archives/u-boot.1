Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FE0C3DA4B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 00:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 867468890F;
	Tue, 16 Jul 2024 02:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D8DE88912; Tue, 16 Jul 2024 02:07:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D86DA88907
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 02:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D3D71063;
 Mon, 15 Jul 2024 17:08:19 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCDEB3F762;
 Mon, 15 Jul 2024 17:07:52 -0700 (PDT)
Date: Tue, 16 Jul 2024 01:05:41 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] spi: sunxi: drop max_hz handling
Message-ID: <20240716010541.745a6c09@minigeek.lan>
In-Reply-To: <20240712171457.3104804-2-mwalle@kernel.org>
References: <20240712171457.3104804-1-mwalle@kernel.org>
 <20240712171457.3104804-2-mwalle@kernel.org>
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

On Fri, 12 Jul 2024 19:14:56 +0200
Michael Walle <mwalle@kernel.org> wrote:

Hi Michael,

> The driver is trying to read the "spi-max-frequency" property of the
> *controller* driver node. There is no such property. The
> "spi-max-frequency" property belongs to the SPI devices on the bus.

Ah, indeed, good catch! Many thanks for sending this!
 
> Right now, the driver will always fall back to the default value of 1MHz
> and thus flash reads are very slow with just about 215kb/s.

That's even slower, right? I guess around 125 KB/s?
 
> In fact, the SPI uclass will already take care of everything and we just
> have to clamp the frequency to the values the driver/hardware supports.
> Thus, drop the whole max_hz handling.

Looks good to me, I verified this by timing the read, this patch indeed 
significantly increases the performance. Also changing the limit in the
DT gets reflected in the driver and in the read speed. Also verified
that the values read from the SPI flash are the same in all cases.

> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>

I will make this part of the first 2024.10 PR.

Cheers,
Andre


> ---
>  drivers/spi/spi-sunxi.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
> index 13725ee7a2d..bfb402902b8 100644
> --- a/drivers/spi/spi-sunxi.c
> +++ b/drivers/spi/spi-sunxi.c
> @@ -135,7 +135,6 @@ struct sun4i_spi_variant {
>  struct sun4i_spi_plat {
>  	struct sun4i_spi_variant *variant;
>  	u32 base;
> -	u32 max_hz;
>  };
>  
>  struct sun4i_spi_priv {
> @@ -237,6 +236,13 @@ static void sun4i_spi_set_speed_mode(struct udevice *dev)
>  	unsigned int div;
>  	u32 reg;
>  
> +	/*
> +	 * The uclass should take care that this won't happen. But anyway,
> +	 * avoid a div-by-zero exception.
> +	 */
> +	if (!priv->freq)
> +		return;
> +
>  	/*
>  	 * Setup clock divider.
>  	 *
> @@ -401,11 +407,10 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
>  
>  static int sun4i_spi_set_speed(struct udevice *dev, uint speed)
>  {
> -	struct sun4i_spi_plat *plat = dev_get_plat(dev);
>  	struct sun4i_spi_priv *priv = dev_get_priv(dev);
>  
> -	if (speed > plat->max_hz)
> -		speed = plat->max_hz;
> +	if (speed > SUN4I_SPI_MAX_RATE)
> +		speed = SUN4I_SPI_MAX_RATE;
>  
>  	if (speed < SUN4I_SPI_MIN_RATE)
>  		speed = SUN4I_SPI_MIN_RATE;
> @@ -458,7 +463,6 @@ static int sun4i_spi_probe(struct udevice *bus)
>  
>  	priv->variant = plat->variant;
>  	priv->base = plat->base;
> -	priv->freq = plat->max_hz;
>  
>  	return 0;
>  }
> @@ -466,16 +470,9 @@ static int sun4i_spi_probe(struct udevice *bus)
>  static int sun4i_spi_of_to_plat(struct udevice *bus)
>  {
>  	struct sun4i_spi_plat *plat = dev_get_plat(bus);
> -	int node = dev_of_offset(bus);
>  
>  	plat->base = dev_read_addr(bus);
>  	plat->variant = (struct sun4i_spi_variant *)dev_get_driver_data(bus);
> -	plat->max_hz = fdtdec_get_int(gd->fdt_blob, node,
> -				      "spi-max-frequency",
> -				      SUN4I_SPI_DEFAULT_RATE);
> -
> -	if (plat->max_hz > SUN4I_SPI_MAX_RATE)
> -		plat->max_hz = SUN4I_SPI_MAX_RATE;
>  
>  	return 0;
>  }

