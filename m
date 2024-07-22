Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284C4C3DA70
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 953E9884B2;
	Tue, 23 Jul 2024 01:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721692685;
	bh=yEML4uxKcfl/YpL5l+etP79MhYo+MzERGrge2cHVAkc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p3fIw1tD67rLEycNxTRB+7Fk9GTs5OLLzQVujnn02/1cfFlXuB5RcIpVIv7dds4e5
	 YGhe0+e5p/TUdIheX/hSY8POo+5Q9PJnqgKh2Ej2mjThzr8zB9w4YuJq+wVKFANphf
	 cniq6iWxBtDB/2wHxFifmkjv32+PestM8tMCVtftaIs4BbVRKcFxvnPeNyVv7uCpKC
	 yDd18lx4Byqbf+e4cT4OFVEWd8EqNiglXjr8Xnb+OoniQ69IgM+AfvXQjLz6PS/+Yt
	 QHZle8iwl/eGsrp5qUDK1yLxuSarYzlsTCyna0fsTurUhBCbSSiukzhcAX6qAKnXH2
	 WZuUsh/ekchkA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2DFF887E64;
 Tue, 23 Jul 2024 01:58:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721692684;
 bh=yEML4uxKcfl/YpL5l+etP79MhYo+MzERGrge2cHVAkc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sIAXMQ2eJbQtcZeIIJ/LhF8lkiXpcawJf1EgvVZ1Sj2gXTp94v3KO2Xpj6/V1Uyua
 j6EuEBDdN24JNs749gqC/U6K+WXiKmNByroZ/EXzRg8x/i9z53HRkE0IQct8oiqdhn
 QBDmqUDgnv90ngCn9peH3Bvk0jDQqpeY3H5nbRzHVc2Od0/JiD81XCDig2A/0uGWKV
 IBNbonv4SmrExvLhT6RWS168c3ta90CmtIdHm6VQPJg34X15udQds3hstprWoJMTmX
 0RM50V0IUhiS2Z+Il/uZuDjo1IFus9ktISMazMGlkz4dpZewby57UxLnha9hcS9tbp
 KnEcQwh0qxqSA==
Message-ID: <3f20db95-543b-495a-a0fd-c0457fd4325d@denx.de>
Date: Tue, 23 Jul 2024 01:39:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] usb: gadget: atmel: Code refactor part 1
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
References: <20240722202426.190986-1-zli@ogga.fr>
 <20240722202426.190986-2-zli@ogga.fr>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240722202426.190986-2-zli@ogga.fr>
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

On 7/22/24 10:23 PM, Zixun LI wrote:
> - Sort includes
> - Forward declare controller structures

Please pick some more descriptive subject for this patch than "refactor 
part 1". If this was only sorting includes as a singular patch doing one 
change, the subject could well be "usb: gadget: atmel: Sort the 
includes", but this patch mixes two types of changes, so that makes it 
harder. You can always split the patch in two ...

> Signed-off-by: Zixun LI <zli@ogga.fr>
> ---
>   drivers/usb/gadget/atmel_usba_udc.c | 59 +++++++++++++++--------------
>   1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index f99553df8d..476e7ed619 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -7,19 +7,22 @@
>    *			   Bo Shen <voice.shen@atmel.com>
>    */
>   
> -#include <linux/bitops.h>
> -#include <linux/errno.h>
> +#include <clk.h>
> +#include <log.h>

clk.h and log.h was added. It seems this patch does more than sort includes.

> +#include <malloc.h>
>   #include <asm/gpio.h>
>   #include <asm/hardware.h>
> +#include <linux/bitops.h>
> +#include <linux/errno.h>
>   #include <linux/list.h>
> -#include <linux/printk.h>

It seems printk.h is no longer included ?

>   #include <linux/usb/ch9.h>
>   #include <linux/usb/gadget.h>
>   #include <linux/usb/atmel_usba_udc.h>
> -#include <malloc.h>
>   
>   #include "atmel_usba_udc.h"
>   
> +static struct usba_udc *controller;
> +
>   static int vbus_is_present(struct usba_udc *udc)
>   {
>   	/* No Vbus detection: Assume always present */
> @@ -506,12 +509,6 @@ usba_udc_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
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
> @@ -1179,28 +1176,16 @@ static int atmel_usba_stop(struct usba_udc *udc)
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
> -
>   int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>   {
> -	struct usba_udc *udc = &controller;
> +	struct usba_udc *udc = controller;
>   
>   	return usba_udc_irq(udc);
>   }
>   
>   int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>   {
> -	struct usba_udc *udc = &controller;
> +	struct usba_udc *udc = controller;
>   	int ret;
>   
>   	if (!driver || !driver->bind || !driver->setup) {
> @@ -1228,7 +1213,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>   
>   int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>   {
> -	struct usba_udc *udc = &controller;
> +	struct usba_udc *udc = controller;
>   
>   	if (!driver || !driver->unbind || !driver->disconnect) {
>   		pr_err("bad paramter\n");
> @@ -1244,6 +1229,24 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>   	return 0;
>   }
>   
> +static const struct usb_gadget_ops usba_udc_ops = {
> +	.get_frame		= usba_udc_get_frame,
> +	.wakeup			= usba_udc_wakeup,
> +	.set_selfpowered	= usba_udc_set_selfpowered,
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
>   static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
>   				      struct usba_udc *udc)
>   {
> @@ -1286,11 +1289,9 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
>   
>   int usba_udc_probe(struct usba_platform_data *pdata)
>   {
> -	struct usba_udc *udc;
> -
> -	udc = &controller;
> +	controller = &udc_controller;
>   
> -	udc->usba_ep = usba_udc_pdata(pdata, udc);
> +	controller->usba_ep = usba_udc_pdata(pdata, controller);
>   
>   	return 0;
>   }

Where is the forward declaration ?
