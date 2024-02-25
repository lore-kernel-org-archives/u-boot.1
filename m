Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AC9C47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 23:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7887287E30;
	Mon, 26 Feb 2024 00:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708902716;
	bh=SLtWMaltefxn7ZkfVjRr622XkNc3yzJ2yaCGbeNpkk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZYfiVgLJ+n5H7H+fMfz0zogD9nqwOTksIzwiWl9POxNYvZhR76X+rIchZXsWtS11s
	 zz/zoizpefX30nyxVeaIe/j4T6wfFRxIGjI7ysOU/34xWo8XjyGf0qTRFo1yrnY2D3
	 SS/hQr9MkAnxB3q9mcab7e7oof0O8rcynj7nyPy9GzA0F22JWEg3LXwlHTFYV3TFYc
	 7iNTRq9+HSQO++JG6AbXsiRJ1I0igYWndb6F5RTGlAD6z3ZHUdjLw34z28dgQ/CC5P
	 S97Y6w+HnLfpPwF+kRndYZRLGVQpqiwQe9BRC1yQ/2E8qzBzWn+laJBRUsYxDbZ12O
	 MbIY5RD75PmvA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A6E7B87E0B;
 Mon, 26 Feb 2024 00:11:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708902711;
 bh=SLtWMaltefxn7ZkfVjRr622XkNc3yzJ2yaCGbeNpkk0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ApHSzNjGtCV4KXpZA+dAY0SemKfZEKDTfkNKmmu+epNdS75BFQBHm4iD2UJ0Jsl2q
 D2yMF/Kz5Cjzy5v8LH0nn8vyeWbHfZ6fCpv8+55eCp25eNoL4wnGElrHWgkrqNdVQp
 nqKmteASGHc+XlzfLqT4Sqc72QT+C+Bv2ZdzrZQmYgV93GRRKrsWfgywh7LDLm/jq3
 IcWgdijQG9Eh1wvpl3bpqx1DcQPT//8d0HIlODtZcbRWK2EiEsp3n27SRKx7vgTqXG
 gKA2NlxI+D6BBFEXlA5I+Ogyc22BxH5sxvTvpOMo0yYqHLoYlyGtOyTIZ2RIWVP4Fc
 u8ETCZW1WUm+Q==
Message-ID: <d9d049c8-d498-48ec-87f6-4127dd7a4ae6@denx.de>
Date: Sun, 25 Feb 2024 23:01:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: Fix build errors when USB_DWC3_GADGET
 is disabled
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de
References: <20240225152715.1821613-1-jonas@kwiboo.se>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240225152715.1821613-1-jonas@kwiboo.se>
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

On 2/25/24 4:27 PM, Jonas Karlman wrote:
> Build fail with the following error when DM_USB_GADGET is enabled and
> USB_DWC3_GADGET is disabled:
> 
>    dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_interrupts':
>    dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrupts+0x10):
>      undefined reference to `dwc3_gadget_uboot_handle_interrupt'
> 
> Build also fail with the following error when USB_GADGET_DWC2_OTG +
> DM_USB_GADGET is enabled and USB_DWC3_GADGET is disabled:
> 
>    gadget/dwc2_udc_otg.o: in function `dm_usb_gadget_handle_interrupts':
>    gadget/dwc2_udc_otg.c:947: multiple definition of `dm_usb_gadget_handle_interrupts';
>      dwc3/dwc3-generic.o:dwc3/dwc3-generic.c:197: first defined here
> 
> Fix this by checking for USB_DWC3_GADGET in addition to DM_USB_GADGET.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 6fb2de8a5ace..891d01957619 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -192,7 +192,7 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
>   	return 0;
>   }
>   
> -#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +#if IS_ENABLED(CONFIG_USB_DWC3_GADGET) && CONFIG_IS_ENABLED(DM_USB_GADGET)

Maybe just make USB_DWC3_GADGET depend on (or select?) DM_USB_GADGET , 
since I think the DWC3 code doesn't work without DM anyway .

>   int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>   {
>   	struct dwc3_generic_priv *priv = dev_get_priv(dev);
> @@ -435,7 +435,7 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>   	if (!dr_mode)
>   		dr_mode = usb_get_dr_mode(node);
>   
> -	if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
> +	if (IS_ENABLED(CONFIG_USB_DWC3_GADGET) && CONFIG_IS_ENABLED(DM_USB_GADGET) &&
>   	    (dr_mode == USB_DR_MODE_PERIPHERAL || dr_mode == USB_DR_MODE_OTG)) {
>   		debug("%s: dr_mode: OTG or Peripheral\n", __func__);
>   		driver = "dwc3-generic-peripheral";

+CC Mattijs .
