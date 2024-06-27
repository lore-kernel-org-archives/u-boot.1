Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ADAC30653
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 15:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 382C887FCD;
	Thu, 27 Jun 2024 17:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9078853E; Thu, 27 Jun 2024 17:06:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CDC4D88247
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 17:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4A46367;
 Thu, 27 Jun 2024 08:07:07 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1173D3F766;
 Thu, 27 Jun 2024 08:06:41 -0700 (PDT)
Date: Thu, 27 Jun 2024 16:06:39 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Marek
 Vasut <marex@denx.de>, John Watts <contact@jookia.org>
Subject: Re: [PATCH v2 2/2] usb: musb-new: sunxi: make compatible with
 UDC/DM gadget model
Message-ID: <20240627160639.2353fd1e@donnerap.manchester.arm.com>
In-Reply-To: <20230608195631.55364-3-CFSworks@gmail.com>
References: <20230608195631.55364-1-CFSworks@gmail.com>
 <20230608195631.55364-3-CFSworks@gmail.com>
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

On Thu,  8 Jun 2023 13:56:31 -0600
Sam Edwards <cfsworks@gmail.com> wrote:

Hi,

John asked me have a look at this.

> Since many sunxi boards do not implement a `board_usb_init`, it's

I am confused, what has this have to do with gadget support? *No* sunxi
board build provides board_usb_init(), but apparently this works fine for
now.
I am all for this converting to DM part, but the rationale seems a bit
off.

Also can you give some reason for this patch? What does this fix or
improve? "it's better" is a bit thin, "complying with DM" would already be
sufficient, but maybe there is more?

> better if we just make the sunxi USB driver compatible with the
> DM gadget model, as many other musb-new variants already are.
> 
> This change has been verified working on a T113s.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  drivers/usb/musb-new/sunxi.c | 50 +++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/musb-new/sunxi.c b/drivers/usb/musb-new/sunxi.c
> index 510b254f7d..6658cd995d 100644
> --- a/drivers/usb/musb-new/sunxi.c
> +++ b/drivers/usb/musb-new/sunxi.c
> @@ -444,6 +444,16 @@ static struct musb_hdrc_config musb_config_h3 = {
>  	.ram_bits	= SUNXI_MUSB_RAM_BITS,
>  };
>  
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)

Please no more #ifdef's. Is there any reason to *not* force
DM_USB_GADGET now, for all sunxi boards, in Kconfig?
Either by "select"ing it in the USB Kconfig, or in arch/arm/Kconfig, like
other platforms do.
Then you don't need to care about the !DM_USB_GADGET definition of this
function and can drop the #ifdef.

> +int dm_usb_gadget_handle_interrupts(struct udevice *dev) {

coding style

> +	struct sunxi_glue *glue = dev_get_priv(dev);
> +	struct musb_host_data *host = &glue->mdata;
> +
> +	host->host->isr(0, host->host);
> +	return 0;
> +}
> +#endif
> +
>  static int musb_usb_probe(struct udevice *dev)
>  {
>  	struct sunxi_glue *glue = dev_get_priv(dev);
> @@ -452,10 +462,6 @@ static int musb_usb_probe(struct udevice *dev)
>  	void *base = dev_read_addr_ptr(dev);
>  	int ret;
>  
> -#ifdef CONFIG_USB_MUSB_HOST
> -	struct usb_bus_priv *priv = dev_get_uclass_priv(dev);
> -#endif
> -
>  	if (!base)
>  		return -EINVAL;
>  
> @@ -486,23 +492,31 @@ static int musb_usb_probe(struct udevice *dev)
>  	pdata.platform_ops = &sunxi_musb_ops;
>  	pdata.config = glue->cfg->config;
>  
> -#ifdef CONFIG_USB_MUSB_HOST
> -	priv->desc_before_addr = true;
> +	if (IS_ENABLED(CONFIG_USB_MUSB_HOST)) {
> +		struct usb_bus_priv *priv = dev_get_uclass_priv(dev);
> +		priv->desc_before_addr = true;
>  
> -	pdata.mode = MUSB_HOST;
> -	host->host = musb_init_controller(&pdata, &glue->dev, base);
> -	if (!host->host)
> -		return -EIO;
> +		pdata.mode = MUSB_HOST;
> +		host->host = musb_init_controller(&pdata, &glue->dev, base);
> +		if (!host->host)
> +			return -EIO;
>  
> -	return musb_lowlevel_init(host);
> -#else
> -	pdata.mode = MUSB_PERIPHERAL;
> -	host->host = musb_register(&pdata, &glue->dev, base);
> -	if (IS_ERR_OR_NULL(host->host))
> -		return -EIO;
> +		return musb_lowlevel_init(host);
> +	} else if (CONFIG_IS_ENABLED(DM_USB_GADGET)) {
> +		pdata.mode = MUSB_PERIPHERAL;
> +		host->host = musb_init_controller(&pdata, &glue->dev, base);
> +		if (!host->host)
> +			return -EIO;
>  
> -	return 0;
> -#endif
> +		return usb_add_gadget_udc(&glue->dev, &host->host->g);
> +	} else {
> +		pdata.mode = MUSB_PERIPHERAL;
> +		host->host = musb_register(&pdata, &glue->dev, base);
> +		if (IS_ERR_OR_NULL(host->host))
> +			return -EIO;
> +
> +		return 0;
> +	}

That looks like a good cleanup! Just need to test it briefly, but it seems
like the gist of this patch is fine.

Cheers,
Andre


>  }
>  
>  static int musb_usb_remove(struct udevice *dev)

