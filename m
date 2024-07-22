Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92B3C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 12:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AEA088348;
	Mon, 22 Jul 2024 14:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721649802;
	bh=LoHbl2LSpKD83yOFVE/72zEeUZ3rZ9QODr4dlQOKvY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JNQGraLt1NsThE+/nx4VQKx09rSbCiQMMFRf8xRK92hoDsmUs1au8TUFjbyadUm1y
	 650+44tgG3GdDviHJDrb783JYzxLJgrplg+qnDmPQO74xSOHuNSYF9Yj+F9hA0xcq7
	 vmgaUCzVygov/WO/DWuamsMqUBC7AU3UuOumUXVjn2GgtNv/G9v74b1cnpKd3TPIWN
	 /9n+q+qd/+5gIAirU0ikKDtD7XjZXsYmYVuIPH2x3VYfykaXdxMCtC3C2HnJlBUtdp
	 jyB4r3a9zXA4B/+fMLQjf+JtjO7YkUpDysFj7KjDZfaAnY8Sppr1Ypo5JFjfaFOfwY
	 PzZux2zgY7StQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CCA8687F82;
 Mon, 22 Jul 2024 14:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721649800;
 bh=LoHbl2LSpKD83yOFVE/72zEeUZ3rZ9QODr4dlQOKvY4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=smfXvq42qlhYXE8Q7HYsRCcGixDa6XesLCE57ia4PpFTxNoL7Qh+eQ60Q4RmMc9JH
 Pul/dDf4gIiIAjMjLGFseVOz4/uiGUfPXQG35O8BxAIqfj13JCr+imd7jQ3tmDgRY1
 lcJ56nG6Dp/fQpPpvCEYP/3esSV4hxKpkwMzS2FnIibGParN763q8ZKolh7P+ubkHu
 M5bHdLXOC2IikvUahYVHedJ+KO1703WjjDGa+Lcbu2xsAZyfIQ3FHO1OE3z2sDV5h/
 Ke0PJ9k/oeQwLCLDrfJeaFobp1jBVlu/5VKqJ1m80e80L8D469xvSkGbcH3r/pGkkw
 5XHtEJB8E6p/Q==
Message-ID: <e939f336-1273-44f1-a06f-0739f7f3c736@denx.de>
Date: Mon, 22 Jul 2024 13:42:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] usb: gadget: atmel: Add attach/detach support
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
References: <20240722084721.96627-2-zli@ogga.fr>
 <20240722084721.96627-4-zli@ogga.fr>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240722084721.96627-4-zli@ogga.fr>
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
> Add controller attach/detach support by using
> usb_gadget_ops.pullup() method.
> 
> Signed-off-by: Zixun LI <zli@ogga.fr>
> ---
>   drivers/usb/gadget/atmel_usba_udc.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index 327e90a786..48d66d9774 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -1176,6 +1176,23 @@ static int usba_disable(struct usba_udc *udc)
>   	return 0;
>   }
>   
> +static int usba_gadget_pullup(struct usb_gadget *g, int is_on)
> +{
> +	struct usba_udc *udc = controller;
> +	u32 ctrl;
> +
> +	ctrl = usba_readl(udc, CTRL);
> +
> +	if (is_on)
> +		ctrl &= ~USBA_DETACH;
> +	else
> +		ctrl |= USBA_DETACH;
> +
> +	usba_writel(udc, CTRL, ctrl);
> +
> +	return 0;
> +}
> +
>   int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>   {
>   	struct usba_udc *udc = controller;
> @@ -1273,6 +1290,7 @@ static const struct usb_gadget_ops usba_udc_ops = {
>   	.get_frame		= usba_udc_get_frame,
>   	.wakeup			= usba_udc_wakeup,
>   	.set_selfpowered	= usba_udc_set_selfpowered,
> +	.pullup			= usba_gadget_pullup,

The function should probably be called usba_udc_pullup() to be 
consistent with the names of the other functions.
