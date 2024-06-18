Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4491C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82747884BA;
	Tue, 18 Jun 2024 09:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ovh66Wai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E204A884C6; Tue, 18 Jun 2024 09:30:04 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D75884BA
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-424720e73e1so2251345e9.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718695802; x=1719300602;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rO8Y2qTYzsWtBUuXJIHqMG49GyRNFxTjs60LoSvvbpQ=;
 b=Ovh66Wai+9RhQW67XDtjmnqEHK1rBllniL1Hd1PdHsxhb0jENxbBKjOf74s+jV2YHm
 K38khSNQuej/pnrqmBBiJKFYh+JsiVs0m6NHIG09VOpZ8lfHVBJhsebBU1DrU/wHG15s
 sG1s1cxAny86ZNdOs4dU7DhDQwfEnKtb8Q0mDdNnuGhymy3F3DEqJJIH6HK7tW95RuZJ
 biSq4l3i3B44Ey4TLhA6fe3AYOMidpAiiCJ6zoXwDc8FMjqZJ9OuLkLDK2tf/HDmQ5MT
 Si+dGfcaEwTcJsWNI4rXVQDtYGKwS5a/ui0ELjXsVObksi8BzYH58DvpdaZcEV6JCXp8
 zoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718695802; x=1719300602;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rO8Y2qTYzsWtBUuXJIHqMG49GyRNFxTjs60LoSvvbpQ=;
 b=ksLcpV5q8y1r4yjA5c/m3dyp/vxlUBuYAxNywT4fsI+mDO3HoGuRE5oO0rvx3Dcnnn
 QX6qWlHaPvtwfaWyHHXy0rEWPM8DS2PmeZnbDiMC7Ke313XTeooKCYiYmW4yLabSkUlb
 rotb3tO3+3ySVlsdJ6U0q4O41DXPKe7lbJpXzrYVFOGIJH2k91L0eQfOngh9ldjpNgNP
 8nNt7H3OPdhgHbapG4RJVzWFUH+N8iX0Iu+PuhC4inQJCZX3+jSkvCuazXI69Bu8L6vx
 kItK2CBlSU4fpaHeicwAS9BDs18T1XrYLpd5NCP7r+gmKZlq0g7cDgQDDeNlW1aLiY5y
 CXyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE93nanGi1bXKoUelJdg/mv3L5q3G8KpChh62lZoJaTE+N1AkY5JarbYzRyADzvXLXJx5380MErDxgjv4ympVk+itXXQ==
X-Gm-Message-State: AOJu0YxQqHtX9QB7ynTlIdhW+Es/nPbYSe9tniHjIpbo+3a5v//t8Agr
 i4sAnV6GvFV914C5MTd0r8wViSPI35DdruzX/YGUkp50OPPxRcZGCOQMLN/N00o=
X-Google-Smtp-Source: AGHT+IGnluWWGVoL2e9R2Zozc0LiECq3ImLZfYimnv3adiUjCBP1toV1fvvMy/DhhZ1uRdSlpUeKcQ==
X-Received: by 2002:a05:600c:444a:b0:422:370a:ca57 with SMTP id
 5b1f17b1804b1-4230485a70amr99008185e9.36.1718695802136; 
 Tue, 18 Jun 2024 00:30:02 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360917c264bsm6238523f8f.56.2024.06.18.00.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:30:01 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 06/11] usb: gadget: mtu3: Convert interrupt handling to
 usb_gadget_generic_ops
In-Reply-To: <20240614005309.34433-7-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
 <20240614005309.34433-7-marek.vasut+renesas@mailbox.org>
Date: Tue, 18 Jun 2024 09:29:59 +0200
Message-ID: <87sexaiu88.fsf@baylibre.com>
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
>  drivers/usb/mtu3/mtu3_plat.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
> index ca86b58dfcd..f8e14eabfb2 100644
> --- a/drivers/usb/mtu3/mtu3_plat.c
> +++ b/drivers/usb/mtu3/mtu3_plat.c
> @@ -223,15 +223,6 @@ static const struct udevice_id ssusb_of_match[] = {
>  };
>  
>  #if CONFIG_IS_ENABLED(DM_USB_GADGET)
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	struct mtu3 *mtu = dev_get_priv(dev);
> -
> -	mtu3_irq(0, mtu);
> -
> -	return 0;
> -}
> -
>  static int mtu3_gadget_probe(struct udevice *dev)
>  {
>  	struct ssusb_mtk *ssusb = dev_to_ssusb(dev->parent);
> @@ -250,10 +241,24 @@ static int mtu3_gadget_remove(struct udevice *dev)
>  	return 0;
>  }
>  
> +static int mtu3_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	struct mtu3 *mtu = dev_get_priv(dev);
> +
> +	mtu3_irq(0, mtu);
> +
> +	return 0;
> +}
> +
> +static const struct usb_gadget_generic_ops mtu3_gadget_ops = {
> +	.handle_interrupts	= mtu3_gadget_handle_interrupts,
> +};
> +
>  U_BOOT_DRIVER(mtu3_peripheral) = {
>  	.name = "mtu3-peripheral",
>  	.id = UCLASS_USB_GADGET_GENERIC,
>  	.of_match = ssusb_of_match,
> +	.ops = &mtu3_gadget_ops,
>  	.probe = mtu3_gadget_probe,
>  	.remove = mtu3_gadget_remove,
>  	.priv_auto	= sizeof(struct mtu3),
> -- 
> 2.43.0
