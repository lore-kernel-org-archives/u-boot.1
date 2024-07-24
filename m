Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E149C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A09E88886;
	Wed, 24 Jul 2024 12:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qKPXl77I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5BE1888DD; Wed, 24 Jul 2024 12:41:07 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 896D688886
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-367963ea053so4844939f8f.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721817665; x=1722422465;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/wUFjVcCWKVxRXAPFKJdmwKfcQqP4GSwZSAvu2JpNbg=;
 b=qKPXl77I5pDi9hr+O6J/g5lX789nPRQfD8+Sjwlea70JiglYOrtxvjvZA+likDDUA5
 gfQ8w4IXpvKntwXZleKgO03vALzkIOEKXH+gEUCmwzRaTCfXXWdEPGDwKTLbKyYEHVnF
 Q2f33MEMMoE3dFzCd5AdxfVF/o3DlXLMQef/d5mNMJ7GvV4GNkkYwu/19UlLLeyP4pw6
 Xc2W36aFV6zJLsPss2ZSz+Zr2JQbrmJ8MuIm4sUJv2TCpgcwBjs7TBXOfaTLB4VehyKW
 CVc0wrTKJXXqDDdE9eI8dKhUZ6VFAxwlqnbE6mBvjr5pUvyBib+7sBq/+yStyiTfvKvI
 FGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721817665; x=1722422465;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/wUFjVcCWKVxRXAPFKJdmwKfcQqP4GSwZSAvu2JpNbg=;
 b=d7Lj/lP63GEkrgcVgv/vI08Lt98zitVlj8QA7hNZK6+Vc9fI6S5omDt6q1K17NlS3Q
 v0Y4rD5VZAmcKBcDxNbH3QtbrUY03vaAL12zjXdBgc6/6253jXYT3Ul3T+dhgPimrs5h
 J4V0LjeLD4aNsmVKP9A1Fh0LdmVjF117Ne1q6/2K0DzVtV2jHo27dDpHCPmbT337rxOC
 mWE0fzpjC72JlX1JVC2bwxeOb8Bkf1I/cREJgpFqURHfh6kG8AttrniWINN2+NqqWZVY
 UQtejagWoUPMOpc0i9fh5CjX3VwC6Ghmcs9UOTyQ+CYY83PrDuHyamE1o7Sg76SCMJ8L
 ZLfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpJDnc8APdBhtJBsL/dKn3gkxg+ajRCp5arCHdwA4Q/nQcGSE68ruQF9uYHpHvUYqiCBchCt45dFCozTBJzhwmJa4cnA==
X-Gm-Message-State: AOJu0Ywejti6kVrwO0yyPul+C46nSD8aa62rFEwBoypa1yyAQi5w43zu
 3emEQZPlc9u4xmnSsEijkX2qcSUYENNcVunNWCoMqFQIiMUA+Q4ktreZC993S3k=
X-Google-Smtp-Source: AGHT+IGOO741KgkATxEaP1elln55FOivqhK6+LAmTdR25W2cnc7kAFH5U3YufDykGJd4EIbZE4Hr+w==
X-Received: by 2002:a5d:4685:0:b0:368:6596:edba with SMTP id
 ffacd0b85a97d-369f0a7c593mr2090327f8f.39.1721817664626; 
 Wed, 24 Jul 2024 03:41:04 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ed551sm13907325f8f.113.2024.07.24.03.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 03:41:04 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 7/7] usb: gadget: atmel: Add DM_USB_GADGET support
In-Reply-To: <20240723131817.262596-8-zli@ogga.fr>
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-8-zli@ogga.fr>
Date: Wed, 24 Jul 2024 12:41:03 +0200
Message-ID: <87wmlb3we8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Zixun,

Thank you for the patch and doing this very welcome DM_USB_GADGET
addition :)

On mar., juil. 23, 2024 at 15:18, Zixun LI <admin@hifiphile.com> wrote:

> Add driver model support by using the uclass UCLASS_USB_GADGET_GENERIC.
>
> Disable local usb_gadget_register_driver()/usb_gadget_unregister_driver()
> implementation which is implemented in udc-core.c when DM_USB_GADGET
> is enabled.
>
> Replace dm_usb_gadget_handle_interrupts() with handle_interrupts ops
> when DM_USB_GADGET is enabled.
>
> Disable legacy struct usba_udc controller as controller point is extracted
> from udevice private data with DM.
>
> Disable legacy usba_udc_probe() to avoid conflict with DM when it's
> enabled.
>
> Compared to Linux driver only supported devices' DT bindings are included
> (sorted as Linux driver)
>
> Signed-off-by: Zixun LI <zli@ogga.fr>

checkpatch.pl seems to complain about Signed-off-by vs commiter here as
well:

checkpatch.pl: 324: WARNING: From:/Signed-off-by: email address mismatch: 'From: Zixun LI <admin@hifiphile.com>' != 'Signed-off-by: Zixun LI <zli@ogga.fr>'

> ---
>  drivers/usb/gadget/atmel_usba_udc.c | 138 ++++++++++++++++++++++++++++
>  drivers/usb/gadget/atmel_usba_udc.h |   3 +
>  include/linux/usb/atmel_usba_udc.h  |   2 +
>  3 files changed, 143 insertions(+)
>
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index a7b96449f8..b7b2e5196b 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -7,10 +7,14 @@
>   *			   Bo Shen <voice.shen@atmel.com>
>   */
>  
> +#include <clk.h>
> +#include <dm.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <asm/gpio.h>
>  #include <asm/hardware.h>
> +#include <dm/device_compat.h>
> +#include <dm/devres.h>
>  #include <linux/bitops.h>
>  #include <linux/errno.h>
>  #include <linux/list.h>
> @@ -18,6 +22,14 @@
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/atmel_usba_udc.h>
>  
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +#include <mach/atmel_usba_udc.h>
> +
> +static int usba_udc_start(struct usb_gadget *gadget,
> +			  struct usb_gadget_driver *driver);
> +static int usba_udc_stop(struct usb_gadget *gadget);
> +#endif /* CONFIG_IS_ENABLED(DM_USB_GADGET) */
> +
>  #include "atmel_usba_udc.h"
>  
>  static int vbus_is_present(struct usba_udc *udc)
> @@ -528,6 +540,10 @@ static const struct usb_gadget_ops usba_udc_ops = {
>  	.wakeup			= usba_udc_wakeup,
>  	.set_selfpowered	= usba_udc_set_selfpowered,
>  	.pullup			= usba_udc_pullup,
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +	.udc_start		= usba_udc_start,
> +	.udc_stop		= usba_udc_stop,
> +#endif
>  };
>  
>  static struct usb_endpoint_descriptor usba_ep0_desc = {
> @@ -1237,6 +1253,7 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
>  	return eps;
>  }
>  
> +#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
>  static struct usba_udc controller = {
>  	.regs = (unsigned *)ATMEL_BASE_UDPHS,
>  	.fifo = (unsigned *)ATMEL_BASE_UDPHS_FIFO,
> @@ -1312,3 +1329,124 @@ int usba_udc_probe(struct usba_platform_data *pdata)
>  
>  	return 0;
>  }
> +
> +#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
> +struct usba_priv_data {
> +	struct clk_bulk		clks;
> +	struct usba_udc		udc;
> +};
> +
> +static int usba_udc_start(struct usb_gadget *gadget,
> +			  struct usb_gadget_driver *driver)
> +{
> +	struct usba_udc *udc = to_usba_udc(gadget);
> +
> +	usba_udc_enable(udc);
> +
> +	udc->driver = driver;

Nitpick: no need for extra blank line here:

	usba_udc_enable(udc);
	udc->driver = driver;

> +
> +	return 0;
> +}
> +
> +static int usba_udc_stop(struct usb_gadget *gadget)
> +{
> +	struct usba_udc *udc = to_usba_udc(gadget);
> +
> +	udc->driver = NULL;
> +
> +	usba_udc_disable(udc);

Same

> +
> +	return 0;
> +}
> +
> +static int usba_udc_clk_init(struct udevice *dev, struct clk_bulk *clks)
> +{
> +	int ret;
> +
> +	ret = clk_get_bulk(dev, clks);
> +	if (ret == -ENOSYS)
> +		return 0;
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable_bulk(clks);
> +	if (ret) {
> +		clk_release_bulk(clks);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int usba_udc_probe(struct udevice *dev)
> +{
> +	struct usba_priv_data *priv = dev_get_priv(dev);
> +	struct usba_udc *udc = &priv->udc;
> +	int ret;
> +
> +	ret = usba_udc_clk_init(dev, &priv->clks);
> +	if (ret)
> +		return ret;
> +
> +	udc->fifo = (void __iomem *)dev_remap_addr_index(dev, FIFO_IOMEM_ID);
> +	if (!udc->fifo)

I think that at this points &priv->clks are valid and enabled.
Therefore, we should disable/release them (as being done in the remove)

> +		return -EINVAL;
> +
> +	udc->regs = (void __iomem *)dev_remap_addr_index(dev, CTRL_IOMEM_ID);
> +	if (!udc->regs)

Same here

> +		return -EINVAL;
> +
> +	udc->gadget.ops = &usba_udc_ops;
> +	udc->gadget.speed = USB_SPEED_HIGH,
> +	udc->gadget.is_dualspeed = 1,
> +	udc->gadget.name = "atmel_usba_udc",
> +
> +	udc->usba_ep = usba_udc_pdata(&pdata, udc);
> +
> +	udc->driver = NULL;

Why do we assign the driver to NULL ? Maybe this deserves a comment in
the code?

> +
> +	ret = usb_add_gadget_udc((struct device *)dev, &udc->gadget);
> +
> +	return ret;
> +}
> +
> +static int usba_udc_remove(struct udevice *dev)
> +{
> +	struct usba_priv_data *priv = dev_get_priv(dev);
> +
> +	usb_del_gadget_udc(&priv->udc.gadget);
> +
> +	clk_release_bulk(&priv->clks);
> +
> +	return dm_scan_fdt_dev(dev);
> +}
> +
> +static int usba_udc_handle_interrupts(struct udevice *dev)
> +{
> +	struct usba_priv_data *priv = dev_get_priv(dev);
> +
> +	return usba_udc_irq(&priv->udc);
> +}
> +
> +static const struct usb_gadget_generic_ops usba_udc_gadget_ops = {
> +	.handle_interrupts	= usba_udc_handle_interrupts,
> +};
> +
> +static const struct udevice_id usba_udc_ids[] = {
> +	{ .compatible = "atmel,at91sam9rl-udc" },
> +	{ .compatible = "atmel,at91sam9g45-udc" },
> +	{ .compatible = "atmel,sama5d3-udc" },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(atmel_usba_udc) = {
> +	.name	= "atmel_usba_udc",
> +	.id	= UCLASS_USB_GADGET_GENERIC,
> +	.of_match = usba_udc_ids,
> +	.ops = &usba_udc_gadget_ops,
> +	.probe = usba_udc_probe,
> +	.remove = usba_udc_remove,
> +	.priv_auto = sizeof(struct usba_priv_data),
> +};
> +#endif /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
> diff --git a/drivers/usb/gadget/atmel_usba_udc.h b/drivers/usb/gadget/atmel_usba_udc.h
> index f6cb48c1cf..7f5e98f6c4 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.h
> +++ b/drivers/usb/gadget/atmel_usba_udc.h
> @@ -211,6 +211,9 @@
>  #define EP0_EPT_SIZE		USBA_EPT_SIZE_64
>  #define EP0_NR_BANKS		1
>  
> +#define FIFO_IOMEM_ID	0
> +#define CTRL_IOMEM_ID	1
> +
>  #define DBG_ERR		0x0001	/* report all error returns */
>  #define DBG_HW		0x0002	/* debug hardware initialization */
>  #define DBG_GADGET	0x0004	/* calls to/from gadget driver */
> diff --git a/include/linux/usb/atmel_usba_udc.h b/include/linux/usb/atmel_usba_udc.h
> index c1c810759c..37c4f21849 100644
> --- a/include/linux/usb/atmel_usba_udc.h
> +++ b/include/linux/usb/atmel_usba_udc.h
> @@ -20,6 +20,8 @@ struct usba_platform_data {
>  	struct usba_ep_data	*ep;
>  };
>  
> +#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
>  extern int usba_udc_probe(struct usba_platform_data *pdata);
> +#endif
>  
>  #endif /* __LINUX_USB_USBA_H */
> -- 
> 2.45.2
