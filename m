Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6552AC2BA1A
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14F648842C;
	Tue, 18 Jun 2024 09:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b/dZuoyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024AF884BF; Tue, 18 Jun 2024 09:28:48 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E36B58839F
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52bc035a7ccso5393687e87.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718695725; x=1719300525;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NCaHdDIUGmqUI2TCURc64oXAdoX2jCoN+34JjMiecAY=;
 b=b/dZuoyqAKru6HW+nsIVs4K+KYC+7gZU/rQl6a2SDftcDyXyJHq8/zZIvDWPOJKjpb
 VVswWt5HCbvsqK2hpU8QrCr3tP+J3DQvcB4YVTEegY3UGBz+toPKZF1uY8UOXq8+SYdV
 H8q86tf2enyP5tZRzMDsBrlMnPo6hun5tOwQwm4hPmps2SRnXm0OQfsKrzI1cWIT+hlt
 6nJvDji8N/fhu8zKpvN6ES81HZ/ibi4si0GMkcA4c5W6/C+S0YyMu6HGNQ0rKjSlV+ry
 ZYfnVCO/FiWQAfLzUe2G9fTtWmS2/b7lFXGE44eDNnCsbdgXcuYzB3PRqkaAJF4LjBhG
 gbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718695725; x=1719300525;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NCaHdDIUGmqUI2TCURc64oXAdoX2jCoN+34JjMiecAY=;
 b=G+xEJ587Q9CxNfikBB9yaPGtsKD6Ckyxq4SC9rlwLOtMABQatyp8bkjnhbHWvrBbNC
 ChtxkuaB3VW6bcvr4goqGs484Ek7rg+C5feBZDc+sAXffHVbtVVg9GtODDqgFI33wg7g
 +fRSa6NagVWTf3QQWc3WDQ4Qp70K39iafk00oga9SYD2BqwoUPl3VkbWz8z8Q+rDXqnU
 K10RCiyl1H94dUO/Ch+k4yVm2iIaw1cD1nJQo4eC0gKQBdqlEjXUBWSsMhF0kchLp7jz
 xs0SuMoMoXOXQnTHeDXQ2/4snAQDYW5pbVG1kAf70A5Yk/JWt4pUTJUi4ucxaYUQsFNd
 +URw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw9Bk6kY3oSxq0QgXbepI5tg3KmOlKJ/iYo7al/tiMKqDjqFNIks33V0u+k06zq0bxwQhdKDWEylbv3oWYi51+8EBLFQ==
X-Gm-Message-State: AOJu0YxyW6GKYhSuG0R5DG74eWzeJuVvT26Ov1LpGNSDWe/svJSAHLiS
 QQ3kYMqB2X4m8dMPcebz9OTBIlJ/ZQBRYjfwKfHFFyMxil5VxX2vnO4IwjB+O7UfuRpbgsnoA8E
 u
X-Google-Smtp-Source: AGHT+IHS1KKtGudLoVvDZHrsFKrR2McKdIX+khXFiWVNzmK5d/eXES2AXntUGcHuPMK2vVxx5XdW4Q==
X-Received: by 2002:ac2:43d6:0:b0:52c:a9c2:d363 with SMTP id
 2adb3069b0e04-52ca9c316abmr6524795e87.10.1718695725189; 
 Tue, 18 Jun 2024 00:28:45 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286eefa63sm218103825e9.1.2024.06.18.00.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:28:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 05/11] usb: gadget: max3420: Convert interrupt handling
 to usb_gadget_generic_ops
In-Reply-To: <20240614005309.34433-6-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
 <20240614005309.34433-6-marek.vasut+renesas@mailbox.org>
Date: Tue, 18 Jun 2024 09:28:42 +0200
Message-ID: <87v826iuad.fsf@baylibre.com>
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
>  drivers/usb/gadget/max3420_udc.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/gadget/max3420_udc.c b/drivers/usb/gadget/max3420_udc.c
> index 5a227c0ffd9..557a1f0644e 100644
> --- a/drivers/usb/gadget/max3420_udc.c
> +++ b/drivers/usb/gadget/max3420_udc.c
> @@ -808,13 +808,6 @@ static void max3420_setup_spi(struct max3420_udc *udc)
>  	spi_wr8(udc, MAX3420_REG_PINCTL, bFDUPSPI);
>  }
>  
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	struct max3420_udc *udc = dev_get_priv(dev);
> -
> -	return max3420_irq(udc);
> -}
> -
>  static int max3420_udc_probe(struct udevice *dev)
>  {
>  	struct max3420_udc *udc = dev_get_priv(dev);
> @@ -859,6 +852,17 @@ static int max3420_udc_remove(struct udevice *dev)
>  	return 0;
>  }
>  
> +static int max3420_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	struct max3420_udc *udc = dev_get_priv(dev);
> +
> +	return max3420_irq(udc);
> +}
> +
> +static const struct usb_gadget_generic_ops max3420_gadget_ops = {
> +	.handle_interrupts	= max3420_gadget_handle_interrupts,
> +};
> +
>  static const struct udevice_id max3420_ids[] = {
>  	{ .compatible = "maxim,max3421-udc" },
>  	{ }
> @@ -868,6 +872,7 @@ U_BOOT_DRIVER(max3420_generic_udc) = {
>  	.name = "max3420-udc",
>  	.id = UCLASS_USB_GADGET_GENERIC,
>  	.of_match = max3420_ids,
> +	.ops = &max3420_gadget_ops,
>  	.probe = max3420_udc_probe,
>  	.remove = max3420_udc_remove,
>  	.priv_auto	= sizeof(struct max3420_udc),
> -- 
> 2.43.0
