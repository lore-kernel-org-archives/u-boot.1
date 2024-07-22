Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F32C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 12:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A155287E30;
	Mon, 22 Jul 2024 14:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721649800;
	bh=6GUeVoFxHJX6Br9KEN+vKf33/VK1RMLsFU0IBjXRDog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SlrCMjoMNue9U/myyOY+5D4eXyT4rjOsJODKXRq77qzh2DoFxoRLzni0ck3fjIt/B
	 SQXb90+x5zf5PYNUAAttdk7D1I11oEWDwsaA8w+fB62q9ciKoum7OtDKv2exLUCkFf
	 r+oyFarFDCyo44mDiU+MuGIsItZ3UJiVD3Tt9Hrht2cC7GOdtldQuJKV2yUpFWAH4I
	 GPOA8Jxy+0uebuWn7tQVqDFwiMUPblQMNrUi1i0UpZ6brSb3La30zTFVgCJgkZuSn+
	 tfrwQp+veAmoUKx1bosl/XjHta8Q69ApmAqOCsz2d/Pf18/658ewxR0JYeZICsnMUG
	 37l2Xovp3k8PA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 09AA587E30;
 Mon, 22 Jul 2024 14:03:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721649799;
 bh=6GUeVoFxHJX6Br9KEN+vKf33/VK1RMLsFU0IBjXRDog=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eB9N8zVyr78VBxXLA72H1epYs2b80SZ3dCEc40W54GyM5vRONgWbj8laZYQCyNiw8
 iQqk/FUyeykJgHBMNHATFA/DlVicPQoSj6G/gloOkmrAgW9Ld7iuI/7WjnO2LfMirm
 Tb6S9W+2Bi4iLM//HsZNiL6PzKr7+Lkn0LfGffWTv+whbL/WR5wT4eH++90it+JkX2
 VMW0Q+E5tDxeYKFfSg4yFhnDmX34aYm6QgOL8gsYtZzJelBvhm5nzei+bQPDkZvgUq
 CHr9LVM/iIIjAUcswdzCcMI8cEqRBa4YHDlh4HX7rY85gXA37/21TkPvtTD8a9ezgz
 ZaAVZGsExxcLA==
Message-ID: <77fbc3c5-59e3-43b0-a6ab-bbce2a991f3e@denx.de>
Date: Mon, 22 Jul 2024 13:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] usb: gadget: atmel: Code refactor
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
References: <20240722084721.96627-2-zli@ogga.fr>
 <20240722084721.96627-3-zli@ogga.fr>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240722084721.96627-3-zli@ogga.fr>
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
> - Sort includes
> - Forward declare controller structure
> - Rename _start() /  _stop() to _enable() / _disable() inline with other
>    drivers, avoid confusion with DM start() stop() functions.
> - Replace printf() by log_err()
> - Spelling paramter -> parameter
> 
> Signed-off-by: Zixun LI <zli@ogga.fr>
> ---
>   drivers/usb/gadget/atmel_usba_udc.c | 77 +++++++++++++++--------------
>   1 file changed, 39 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index f99553df8d..327e90a786 100644
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
> +#include <malloc.h>
>   #include <asm/gpio.h>
>   #include <asm/hardware.h>
> +#include <linux/bitops.h>
> +#include <linux/errno.h>
>   #include <linux/list.h>
> -#include <linux/printk.h>
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
> @@ -1153,7 +1150,7 @@ static int usba_udc_irq(struct usba_udc *udc)
>   	return 0;
>   }
>   
> -static int atmel_usba_start(struct usba_udc *udc)
> +static int usba_enable(struct usba_udc *udc)

Is there any specific reason for the removal of this atmel_ prefix from 
the functions ?
