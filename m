Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446B3C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 12:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71C4888365;
	Mon, 22 Jul 2024 14:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721649802;
	bh=cqa8bVcZCGLyvQki2mQhvnB54Y9rrc+B+mVtnncPyF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s1nR3MuogLRRWVkkWQ9C0vV5LFCivuREJDJz0jUrkXvR7Pk1ayMDnXFZB/tmwHvJ+
	 X6436c93+RrhLmTO9mcIKaQiRFV8NQSKlIEcsc1LRkUcrS8exkSSq3U9ixKILe6SWe
	 IJjd6O08ii6pbDBnKNvAAwr9LKMTBhUXiwW0RDGWf+P3/X2R3a/pdK7h1FKscNbo6c
	 OdCxTWax6JRZYyN8Ome9jTXHwjuJ+nzmkoKUP2y+dxGrgzYE8b2kWxE5u8ji7NWDe4
	 uVAD+R0O6Ee43SyfC3/qDHFzSRiSVO7y5uVtVXVCKh+9YPCL5wDeWLYh/Yf0Hi0uOA
	 S2xNGjAnVdaRA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6810988005;
 Mon, 22 Jul 2024 14:03:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721649800;
 bh=cqa8bVcZCGLyvQki2mQhvnB54Y9rrc+B+mVtnncPyF0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ax/9zVA8NXhEzWXymhVC/vIuOzuy51ZVt7G4XzgTGaZ9hXqz1P8jPXx/eV0OJRcJ4
 Y8YXcb0HcB6ubNmTFk8gVmacFHv1HPm5aHPJD2uN2kd7zTQ3RADFru45e8VQYd4e7T
 YPb6UFbYkhY2v+1d1gcDQXCT3/UIcriYPEhTwylt4ucaTp1UPyeX7ebMwUzbTKOACq
 L1aULEF7bNLkLtLL3gIefC9w7SKPyqsf/fQB9DEnWpAtV2H+Zh4c5p7Qe8/M9+3521
 yxPopuXo9gl/gFsRgGorCMHRnugJAPZL/SvzaLVDpWp/vR18JV5oAuUCM0xDjSsrXk
 qMvANCbw89sWA==
Message-ID: <467e34b2-592a-444e-abc0-fb3dffb2e9fb@denx.de>
Date: Mon, 22 Jul 2024 13:43:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] usb: gadget: atmel: Add DM_USB_GADGET support
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
References: <20240722084721.96627-2-zli@ogga.fr>
 <20240722084721.96627-6-zli@ogga.fr>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240722084721.96627-6-zli@ogga.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/22/24 10:47 AM, Zixun LI wrote:
> Add driver model support by using the uclass UCLASS_USB_GADGET_GENERIC.
> 
> Disable local usb_gadget_register_driver()/usb_gadget_unregister_driver()
> implementation which is implemented in udc-core.c when DM_USB_GADGET
> is enabled.
> 
> Compared to Linux driver only supported devices' DT bindings are included
> (sorted as Linux driver)
> 
> Signed-off-by: Zixun LI <zli@ogga.fr>
> ---
>   drivers/usb/gadget/atmel_usba_udc.c | 128 ++++++++++++++++++++++++++++
>   1 file changed, 128 insertions(+)
> 
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index 48d66d9774..664d33f525 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -8,10 +8,13 @@
>    */
>   
>   #include <clk.h>
> +#include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <asm/gpio.h>
>   #include <asm/hardware.h>
> +#include <dm/device_compat.h>
> +#include <dm/devres.h>
>   #include <linux/bitops.h>
>   #include <linux/errno.h>
>   #include <linux/list.h>
> @@ -19,6 +22,10 @@
>   #include <linux/usb/gadget.h>
>   #include <linux/usb/atmel_usba_udc.h>
>   
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +#include <mach/atmel_usba_udc.h>
> +#endif /* CONFIG_IS_ENABLED(DM_USB_GADGET) */
> +
>   #include "atmel_usba_udc.h"
>   
>   static struct usba_udc *controller;
> @@ -1200,6 +1207,7 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>   	return usba_udc_irq(udc);
>   }
>   
> +#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
>   int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>   {
>   	struct usba_udc *udc = controller;
> @@ -1245,6 +1253,49 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>   
>   	return 0;
>   }
> +#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
> +
> +static int usba_gadget_start(struct usb_gadget *g,
> +			     struct usb_gadget_driver *driver)
> +{
> +	struct usba_udc *udc = controller;
> +
> +	if (!driver || !driver->bind || !driver->setup) {
> +		log_err("bad parameter\n");

This check is unnecessary, please remove.

> +		return -EINVAL;
> +	}
> +
> +	if (udc->driver) {

This check is unnecessary, please remove.

> +		log_err("UDC already has a gadget driver\n");
> +		return -EBUSY;
> +	}
> +
> +	usba_enable(udc);
> +
> +	udc->driver = driver;
> +
> +	return 0;
> +}

The rest looks pretty good, thanks !
