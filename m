Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA94C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5A9688477;
	Tue, 18 Jun 2024 09:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oXZafKaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D318839F; Tue, 18 Jun 2024 09:36:49 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2753488477
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35f275c7286so4609419f8f.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718696205; x=1719301005;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=uQS2BIOcHG8WaGo97gD2X8NDPCZ1GXztAUJvMMrxmZQ=;
 b=oXZafKaHjmc0oI3neWAoguAq5AoaM1Oo5XdgWRoRhyIeU5Y9duP8wvDnSa/IsHleLw
 5BZniTULiFrfIE28Z0XrK4zNrbKyj9G5SYmvowSoUQ38C0Tvd4jgiHAmIBKJYbXwIoyS
 ius9bmNRVOX1ffwJXa+iKkpCw66+adJhIyLbN+YmIDC5jBrDz9KOGVsABtQp4bOo8vdg
 KbeEsqrfNJFxTGOxEgr96jja7quNyIg2y2h1GIybMQHppxbogV6NS1vSRKPWuVT94Czt
 270I8t5QKl5NMaeciJBCHMpAP72Azqc1lpR3Yz90+2a2EUlwSRfUvpGE9GGoN6+FL5uq
 26wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718696205; x=1719301005;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uQS2BIOcHG8WaGo97gD2X8NDPCZ1GXztAUJvMMrxmZQ=;
 b=tsV7Y+3zkCXVUop4HPv6MbMwvi+DpmP8t6L5VDRi9R+lWZdbJU0cL18B0wKji1nBBt
 Zd4+0d9a2XPWTV0Y1lC4AUVPiLxI5ekbTcgMp6eA1GkbGylt1wx7lcS3mO9Bq1tVHUoj
 fkNfqC0+nsfdOzkdUEmpEyAJZlRLM9xTywBio/hli4TPjj06+oG6tzTMS2a74AWRFmIN
 TaA/8VvtAMU4YLtwCiFpXNM4wunDm34pWxbUtXZNSE91HYM3HNST5BRkO/jm+JotdKl4
 uu40Nfq3oSbBzoOYIkNlVthnVtX4dicmsldRvihSQYns7608tZLzUcHPNlT3AHx/tSkR
 iwNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGMW4YkPXpucDUX+z6gZMjHrmBpZpE34O9pSZQgSaWikwBf66IKQrB9kHZeSPR62D2Vr3eH+NhK6JaappGKJBCK5u6Zg==
X-Gm-Message-State: AOJu0YwzM8DrfzOEQ33SYgu1BQJ1y8k79NfuWA/cU5V8JqyOm0vNpqnh
 Evluk4EVVdt5+9XNffuEjrPYsdzNuTcKnjgSzsY+QBjVAH1P51LVdN8fMIiJaeQ=
X-Google-Smtp-Source: AGHT+IGVjSjxjujmt6uXEZZ2undUjwoHaroJoL9kM5nGMxQlzw0Jkj5lnYu1megADJrAvD5M/41cHA==
X-Received: by 2002:adf:ecc6:0:b0:361:dde2:87a0 with SMTP id
 ffacd0b85a97d-361dde2881dmr807159f8f.65.1718696205602; 
 Tue, 18 Jun 2024 00:36:45 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c785sm13470681f8f.34.2024.06.18.00.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:36:45 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 08/11] usb: gadget: musb: Convert interrupt handling to
 usb_gadget_generic_ops
In-Reply-To: <20240614005309.34433-9-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
 <20240614005309.34433-9-marek.vasut+renesas@mailbox.org>
Date: Tue, 18 Jun 2024 09:36:42 +0200
Message-ID: <87plseitx1.fsf@baylibre.com>
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

Hi Marek,

Thank you for the patch.

On ven., juin 14, 2024 at 02:51, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Implement .handle_interrupts callback as a replacement for deprecated
> dm_usb_gadget_handle_interrupts() function. The new callback allows
> for each DM capable USB gadget controller driver to define its own
> IRQ handling implementation without colliding with other controller
> drivers.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/usb/musb-new/ti-musb.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
> index 76e8b88369e..ec1baa9337d 100644
> --- a/drivers/usb/musb-new/ti-musb.c
> +++ b/drivers/usb/musb-new/ti-musb.c
> @@ -233,15 +233,6 @@ static int ti_musb_peripheral_of_to_plat(struct udevice *dev)
>  }
>  #endif
>  
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	struct ti_musb_peripheral *priv = dev_get_priv(dev);
> -
> -	priv->periph->isr(0, priv->periph);
> -
> -	return 0;
> -}
> -
>  static int ti_musb_peripheral_probe(struct udevice *dev)
>  {
>  	struct ti_musb_peripheral *priv = dev_get_priv(dev);
> @@ -269,12 +260,26 @@ static int ti_musb_peripheral_remove(struct udevice *dev)
>  	return 0;
>  }
>  
> +static int ti_musb_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	struct ti_musb_peripheral *priv = dev_get_priv(dev);
> +
> +	priv->periph->isr(0, priv->periph);
> +
> +	return 0;
> +}
> +
> +static const struct usb_gadget_generic_ops ti_musb_gadget_ops = {
> +	.handle_interrupts	= ti_musb_gadget_handle_interrupts,
> +};
> +
>  U_BOOT_DRIVER(ti_musb_peripheral) = {
>  	.name	= "ti-musb-peripheral",
>  	.id	= UCLASS_USB_GADGET_GENERIC,
>  #if CONFIG_IS_ENABLED(OF_CONTROL)
>  	.of_to_plat = ti_musb_peripheral_of_to_plat,
>  #endif
> +	.ops	= &ti_musb_gadget_ops,
>  	.probe = ti_musb_peripheral_probe,
>  	.remove = ti_musb_peripheral_remove,
>  	.ops	= &musb_usb_ops,
> -- 
> 2.43.0
