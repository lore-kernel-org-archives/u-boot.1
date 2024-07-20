Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E78C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 20:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9245A88800;
	Sat, 20 Jul 2024 22:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721506843;
	bh=9zzKw/bW+FMDPxBmkl3PJyp73xlSf8j32Pv26LbrJ6c=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WGcUn8rzeo76/495oRIdxhvjV3nO+JkpddyN21XkbT4RzubBiuJKZtjtKfV4wlN/W
	 3UTwgN7OnJOrOvNKun3A6U5a+CbtsOjtjxHDWGbJbqdQ1XSfdsLq/bDomWyoshCgiE
	 qzMRdwXz4CCSQNpnljCu6u3YdjYAdQD8RZPrXX0pNi5GpTpmEoUGg3Rc1xFl0wtq2n
	 nG9tDtirWLhhufO1XoJG1SpcsxyslJtHyKfTMvsKEItfuUoH9LKpGNCRN/sH/seu4h
	 8W2ORL/LVgWKQ3P1WxydljyAYJvB5LSEvhg9i2nJDaN9ITzUJvdJcKrlhBDr5HP47+
	 WvKJGfO20PQ1w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8930B88614;
 Sat, 20 Jul 2024 22:20:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721506841;
 bh=9zzKw/bW+FMDPxBmkl3PJyp73xlSf8j32Pv26LbrJ6c=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=iBlb6RDgoitSrW8waSkUpvRgFVP4NmUjyuA9SztNnXpl1l4egbaLvH2uzoRDnRxlm
 l5Kc2x5bBoahfWaIFxE7arQ8r96nVSSQLQjz39xkwXLQZR2pA3+d6OekG0ndJsx9VG
 zMFifE0c992k59KibKgezyDs/vwToUV4og9fb6JIxmIkvjOMjr4IB9Nk2c+0tomKXs
 j9CLtNR1/ymbEfaF6rBQMYvRkhg7nwiRgxZcTitJUc0Oi0+EaINVPlCL2rXjna+gST
 FNRSHIWhg+wmvDB1XITCCtmqTqAf167nXzLbG2L0PAZ1p6Y0tbg27BsQDbqnJv2zrG
 CSxYeRa1gFzuA==
Message-ID: <97a92b69-bac4-49f5-aeb8-19d5c0d53eb4@denx.de>
Date: Sat, 20 Jul 2024 22:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH RFC] usb: gadget: atmel: Add DM_USB_GADGET support
To: Zixun Li <zli@ogga.fr>, open list <u-boot@lists.denx.de>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <PAZP264MB297470A072D9FA16978B1338B1AD2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PAZP264MB297470A072D9FA16978B1338B1AD2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
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

On 7/20/24 12:35 AM, Zixun Li wrote:
> Add driver model support by using the uclass UCLASS_USB_GADGET_GENERIC.
> 
> Disable local usb_gadget_register_driver()/usb_gadget_unregister_driver()
> implementation which is implemented in udc-core.c when DM_USB_GADGET
> is enabled.
> 
> Compared to Linux driver sam9x60 and sama7g5 DT bindings are not included
> as they are not supported by the driver yet.
> 
> Signed-off-by: Zixun LI <zli@ogga.fr>

+CC Mattijs

> ---
>   drivers/usb/gadget/atmel_usba_udc.c | 196 ++++++++++++++++++++++++----
>   1 file changed, 169 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index f99553df8d..40e8b895a0 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -17,9 +17,19 @@
>   #include <linux/usb/gadget.h>
>   #include <linux/usb/atmel_usba_udc.h>
>   #include <malloc.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/devres.h>

Keep the list sorted

> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +#include <mach/atmel_usba_udc.h>
> +#endif /* CONFIG_IS_ENABLED(DM_USB_GADGET) */
>   
>   #include "atmel_usba_udc.h"
>   
> +static struct usba_udc *controller;
> +
>   static int vbus_is_present(struct usba_udc *udc)
>   {
>   	/* No Vbus detection: Assume always present */
> @@ -506,12 +516,6 @@ usba_udc_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
>   	return 0;
>   }
>   
> -static const struct usb_gadget_ops usba_udc_ops = {
> -	.get_frame		= usba_udc_get_frame,
> -	.wakeup			= usba_udc_wakeup,
> -	.set_selfpowered	= usba_udc_set_selfpowered,
> -};
> -
>   static struct usb_endpoint_descriptor usba_ep0_desc = {
>   	.bLength = USB_DT_ENDPOINT_SIZE,
>   	.bDescriptorType = USB_DT_ENDPOINT,
> @@ -1153,7 +1157,7 @@ static int usba_udc_irq(struct usba_udc *udc)
>   	return 0;
>   }
>   
> -static int atmel_usba_start(struct usba_udc *udc)
> +static int usba_enable(struct usba_udc *udc)

Please factor out such rename (if it is even necessary) into a separate 
preparatory patch, it makes the review easier.

>   {
>   	udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
>   
> @@ -1168,7 +1172,7 @@ static int atmel_usba_start(struct usba_udc *udc)
>   	return 0;
>   }
>   
> -static int atmel_usba_stop(struct usba_udc *udc)
> +static int usba_disable(struct usba_udc *udc)
>   {
>   	udc->gadget.speed = USB_SPEED_UNKNOWN;
>   	reset_all_endpoints(udc);
> @@ -1179,28 +1183,29 @@ static int atmel_usba_stop(struct usba_udc *udc)
>   	return 0;
>   }
>   
> -static struct usba_udc controller = {
> -	.regs = (unsigned *)ATMEL_BASE_UDPHS,
> -	.fifo = (unsigned *)ATMEL_BASE_UDPHS_FIFO,
> -	.gadget = {
> -		.ops		= &usba_udc_ops,
> -		.ep_list	= LIST_HEAD_INIT(controller.gadget.ep_list),
> -		.speed		= USB_SPEED_HIGH,
> -		.is_dualspeed	= 1,
> -		.name		= "atmel_usba_udc",
> -	},
> -};
> +static int usba_gadget_pullup(struct usb_gadget *g, int is_on)
> +{
> +	struct usba_udc *udc = controller;
> +	u32 ctrl;
> +
> +	ctrl = usba_readl(udc, CTRL);


if (is_on)
   ctrl &= ~USBA_DETACH;
else
   ctrl |= USBA_DETACH;

usba_writel(udc, ctrl);

Should help readability.

If this is moved code, do this in a preparatory patch please.

> +	usba_writel(udc, CTRL, is_on ? ctrl & ~USBA_DETACH : ctrl | USBA_DETACH);
> +
> +	return 0;
> +}
>   
>   int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>   {
> -	struct usba_udc *udc = &controller;
> +	struct usba_udc *udc = controller;
>   
>   	return usba_udc_irq(udc);
>   }
>   
> +#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
>   int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>   {
> -	struct usba_udc *udc = &controller;
> +	struct usba_udc *udc = controller;
>   	int ret;
>   
>   	if (!driver || !driver->bind || !driver->setup) {
> @@ -1213,7 +1218,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>   		return -EBUSY;
>   	}
>   
> -	atmel_usba_start(udc);
> +	usba_enable(udc);

Should be in preparatory patch.

>   	udc->driver = driver;
>   
> @@ -1228,7 +1233,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>   
>   int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>   {
> -	struct usba_udc *udc = &controller;
> +	struct usba_udc *udc = controller;

Should be in one of preparatory patches.

>   	if (!driver || !driver->unbind || !driver->disconnect) {
>   		pr_err("bad paramter\n");
> @@ -1239,11 +1244,54 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>   	driver->unbind(&udc->gadget);
>   	udc->driver = NULL;
>   
> -	atmel_usba_stop(udc);
> +	usba_disable(udc);
> +
> +	return 0;
> +}
> +#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
> +
> +static int usba_gadget_start(struct usb_gadget *g,
> +			     struct usb_gadget_driver *driver)
> +{
> +	struct usba_udc *udc = controller;
> +
> +	if (!driver || !driver->bind || !driver->setup) {
> +		printf("bad parameter\n");

Use log_ or dev_err

> +		return -EINVAL;
> +	}
> +
> +	if (udc->driver) {
> +		printf("UDC already has a gadget driver\n");
> +		return -EBUSY;
> +	}
> +
> +	usba_enable(udc);
> +
> +	udc->driver = driver;
> +
> +	return 0;
> +}
> +
> +static int usba_gadget_stop(struct usb_gadget *g)
> +{
> +	struct usba_udc *udc = controller;
> +
> +	if (!udc)
> +		return -ENODEV;
> +
> +	if (!udc->driver)
> +		return -EINVAL;
> +
> +	udc->driver->disconnect(&udc->gadget);
> +	udc->driver = NULL;
> +
> +	usba_disable(udc);
>   
>   	return 0;
>   }
>   
> +#endif /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
> +
>   static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
>   				      struct usba_udc *udc)
>   {
> @@ -1284,13 +1332,107 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
>   	return eps;
>   }
>   
> +static const struct usb_gadget_ops usba_udc_ops = {
> +	.get_frame		= usba_udc_get_frame,
> +	.wakeup			= usba_udc_wakeup,
> +	.set_selfpowered	= usba_udc_set_selfpowered,
> +	.pullup			= usba_gadget_pullup,
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +	.udc_start		= usba_gadget_start,
> +	.udc_stop		= usba_gadget_stop,
> +#endif
> +};
> +
> +static struct usba_udc udc_controller = {
> +	.regs = (unsigned int *)ATMEL_BASE_UDPHS,
> +	.fifo = (unsigned int *)ATMEL_BASE_UDPHS_FIFO,
> +	.gadget = {
> +		.ops		= &usba_udc_ops,
> +		.ep_list	= LIST_HEAD_INIT(udc_controller.gadget.ep_list),
> +		.speed		= USB_SPEED_HIGH,
> +		.is_dualspeed	= 1,
> +		.name		= "atmel_usba_udc",
> +	},
> +};
> +
>   int usba_udc_probe(struct usba_platform_data *pdata)
>   {
> -	struct usba_udc *udc;
> +	controller = &udc_controller;
> +
> +	controller->usba_ep = usba_udc_pdata(pdata, controller);
> +
> +	return 0;
> +}
> +
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +struct usba_priv_data {
> +	struct clk_bulk		clks;
> +};
>   
> -	udc = &controller;
> +static int atmel_usba_udc_clk_init(struct udevice *dev, struct clk_bulk *clks)
> +{
> +	int ret;
>   
> -	udc->usba_ep = usba_udc_pdata(pdata, udc);
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
>   
>   	return 0;
>   }
> +
> +static int atmel_usba_udc_probe(struct udevice *dev)
> +{
> +	struct usba_priv_data *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = atmel_usba_udc_clk_init(dev, &priv->clks);
> +	if (ret)
> +		return ret;
> +
> +	ret = usba_udc_probe(&pdata);
> +	if (ret)
> +		return ret;
> +
> +	controller->driver = 0;
> +
> +	ret = usb_add_gadget_udc((struct device *)dev, &controller->gadget);
> +
> +	return ret;
> +}
> +
> +static int atmel_usba_udc_remove(struct udevice *dev)
> +{
> +	struct usba_priv_data *priv = dev_get_priv(dev);
> +
> +	usb_del_gadget_udc(&controller->gadget);
> +
> +	clk_release_bulk(&priv->clks);
> +
> +	return dm_scan_fdt_dev(dev);
> +}
> +
> +static const struct udevice_id atmel_usba_udc_ids[] = {
> +	{ .compatible = "atmel,at91sam9rl-udc" },
> +	{ .compatible = "atmel,at91sam9g45-udc" },
> +	{ .compatible = "atmel,sama5d3-udc" },

Keep the list sorted.

> +	{}
> +};
> +
> +U_BOOT_DRIVER(ateml_usba_udc) = {
> +	.name	= "ateml_usba_udc",
> +	.id	= UCLASS_USB_GADGET_GENERIC,
> +	.of_match = atmel_usba_udc_ids,
> +	.probe = atmel_usba_udc_probe,
> +	.remove = atmel_usba_udc_remove,
> +	.priv_auto	= sizeof(struct usba_priv_data),
> +};
> +#endif /* CONFIG_IS_ENABLED(DM_USB_GADGET) */

Looks pretty good otherwise, thanks !

Don't forget to CC Mattijs on V2
