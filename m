Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D57C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79863884C9;
	Tue, 18 Jun 2024 09:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DPwOEAnD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BECBB88477; Tue, 18 Jun 2024 09:40:40 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C9C884C9
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-421cd1e5f93so36646305e9.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718696437; x=1719301237;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4OoRp/8dSAsqL7OuFkqSk6XliTO1+qLekm9XQPwW7/Q=;
 b=DPwOEAnDB91PlxlP/MAgELXcSY72kZf2NFN0NZRRpAyxZMsy4hATRU/5NokSKIeVGk
 lzq+BK4P7qyjR9PlW4WgdJkJE2bzsMi6y/sxrNd4W+ZVG55vYOYOS/3S6/wh/A/xjP+o
 CLVEy1U8OR7BBHO4yDEbrOg1U9KvpjixqjJui5yxbwTL4qOjDOVNKPPnGaK/pE8+xci9
 eWZ1Xni6RbrtvlANraqQ91p4AbBcpch9t+Myzq1RuDqUqw9SY6/zlkiCNH2xXxkXFzt9
 oICNeJDbSZ/Bis7+a0EZCTLwj2hp+aJOxTWeyAh7rAcn3wJ+At7Z7H4msx3t/H8Cv0cl
 PuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718696437; x=1719301237;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4OoRp/8dSAsqL7OuFkqSk6XliTO1+qLekm9XQPwW7/Q=;
 b=cb/Qxgd6aGFW23eAox+NNlMdOGDKeZmSdERUa3kuGUXnRYiJ7tzk6WNreKn6c7qah8
 dEjdbBq8VIHpa3hnFlnqdYRbZhij21O8f09983FN8RwRUF/JT+fDmxtvaMDhzmTamPRJ
 /rgZRbP/jQQWOhuc8gMPDz7jpawf9ToisKtqNqyfwxYe+1YJK7XTHqrpcEoJR67q7x0i
 Jc6gN6M//6mYw9zESrJfTMdm4syx/gXmQBK0VjB5PH4kTnhUPAvoVr6FGyXUWIDFgaeA
 hUTSM1N+RPJ83s7k06rhNfUQSWiV9h0rcjdSy9B3Kc8u12Bv/MSj/E0UJlXsr0tHl0XA
 31VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYomQ37NFLjeG53iHyPc9tDGQmZAfh+imzKpbhzLLtL5M4Qce/S2g73t6N72T1uMuj72drMF9ZJE2VnwE5Ti7j6ZP5ew==
X-Gm-Message-State: AOJu0Yx1VjiecdfOMBnp/0NWnzGtS1OWgQ0QWTHrJ/lerUspZp3dIWA8
 29urSk+aTTrNdL+SKKmHFC6FBkFetVmCckvWdKeVcBJ50oz7/YtPKgavHvatckQ=
X-Google-Smtp-Source: AGHT+IFpRYUNzGnqqw8ebOefQ6Et+OALDqIPTFqEDU3jIO0tY2F0TUnARxBx5+VZmiRpcuvqr3PLog==
X-Received: by 2002:adf:f902:0:b0:360:727b:8b47 with SMTP id
 ffacd0b85a97d-3607a7e7c15mr9830721f8f.63.1718696436907; 
 Tue, 18 Jun 2024 00:40:36 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075093a4asm13531278f8f.21.2024.06.18.00.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:40:36 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 09/11] usb: gadget: ux500: Convert interrupt handling to
 usb_gadget_generic_ops
In-Reply-To: <20240614005309.34433-10-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
 <20240614005309.34433-10-marek.vasut+renesas@mailbox.org>
Date: Tue, 18 Jun 2024 09:40:34 +0200
Message-ID: <87msniitql.fsf@baylibre.com>
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

nitpick below (up to you if you want to fix it)

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
>  drivers/usb/musb-new/ux500.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/usb/musb-new/ux500.c b/drivers/usb/musb-new/ux500.c
> index 6b4ef3c8578..89dd75b7d05 100644
> --- a/drivers/usb/musb-new/ux500.c
> +++ b/drivers/usb/musb-new/ux500.c
> @@ -91,14 +91,6 @@ static const struct musb_platform_ops ux500_musb_ops = {
>  	.disable	= ux500_musb_disable,
>  };
>  
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	struct ux500_glue *glue = dev_get_priv(dev);
> -
> -	glue->mdata.host->isr(0, glue->mdata.host);
> -	return 0;
> -}
> -
>  static int ux500_musb_probe(struct udevice *dev)
>  {
>  #ifdef CONFIG_USB_MUSB_HOST
> @@ -155,6 +147,19 @@ static int ux500_musb_remove(struct udevice *dev)
>  	return 0;
>  }
>  
> +static int ux500_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	struct ux500_glue *glue = dev_get_priv(dev);
> +
> +	glue->mdata.host->isr(0, glue->mdata.host);
> +
> +	return 0;
> +}
> +
> +static const struct usb_gadget_generic_ops ux500_gadget_ops = {
> +	.handle_interrupts	= ux500_gadget_handle_interrupts,
> +};
> +
>  static const struct udevice_id ux500_musb_ids[] = {
>  	{ .compatible = "stericsson,db8500-musb" },
>  	{ }
> @@ -168,6 +173,7 @@ U_BOOT_DRIVER(ux500_musb) = {
>  	.id		= UCLASS_USB_GADGET_GENERIC,
>  #endif
>  	.of_match	= ux500_musb_ids,
> +	.ops		= &ux500_gadget_ops,

In case of CONFIG_USB_MUSB_HOST=y, ops gets redefined below.
Can we move this assignment below
```
  	.id		= UCLASS_USB_GADGET_GENERIC,
```
?

>  	.probe		= ux500_musb_probe,
>  	.remove		= ux500_musb_remove,
>  #ifdef CONFIG_USB_MUSB_HOST
> -- 
> 2.43.0
