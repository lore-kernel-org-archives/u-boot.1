Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608CFC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30997884A4;
	Tue, 18 Jun 2024 09:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QgLb05R4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8124D884B8; Tue, 18 Jun 2024 09:20:21 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D0D884A4
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ec0f3b9cfeso45031771fa.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718695219; x=1719300019;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=y8gNrylDSHByEiEVo7laqMObD9NUxWD3U289qArAJfo=;
 b=QgLb05R4U4W2n4zp38wdZDRzn8AJIFxonl3zI6pntJEnRHzWAczpDJR2Wq/3iOhT6r
 mpBu6P6yy67l3MjraJ/yQ+dERP2t7oPA4/l6v6maON/QgN8waSyeZHbhpAHZUr5ZtBMa
 EKF3dC3S4UrCFn1VJPTVsVBUombQpPzPitFR2AWTp9HHoHY9ZMUd/DFRmLU5fcyoIYt0
 CP41coxFSxrVZ96QBVMzde9+74xdZ7JFyLffGBEnVHXt3O+MAxsbiUZTx6CsFBcIpRdG
 gX04IgND1cY0Qzv48itSZzjH++pSMd0eJDVFC/uBfp3cl9hMAg7z9SwPdakp2DH/7qn5
 U9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718695219; x=1719300019;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y8gNrylDSHByEiEVo7laqMObD9NUxWD3U289qArAJfo=;
 b=XY2iqvWwLfv35ASlj1Q/+z8WL2U4RVvo61wOSkAfrUZPkaEHeAXFG9Gz1vfY1F0bsO
 JjGD/tOby7Rh6mvBTVH9aC73Zbx0KKU4tBbAxgATw2vC8M+IYs/GJLuEA1MgikY6u0u1
 hQsZbTdbHA/1oarGPnaW5DNlkrsifNQxAlJKHbqJ5atNGj+O4g3qTnoYfnpsNyFsGYFL
 N0xwPXGwKGZ83NOr/jhUSePcrufgYEBT8SPQB6mMFlQJHek/uB3i+oVJUTzLazA70yG1
 5YUtR0V5kkPvLU61VCjEQ+bJ0iCOWKP4r9ijSv7tHVyzWh0IZCn72GvTmqe3hrqefwJf
 5Fug==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1N3dmJWfdQdNk1FMzXDhdkZVanLMYF2VC9+g1UuGbEJJq3lowFPwU0kz5otw4Omn7MnXOW7GuRhpD9xozMslcYcTz1w==
X-Gm-Message-State: AOJu0YzaQrzojgIt9qQr5buuiGyLXoAkJq8E70fUVkALyrp456gp8GKO
 SzD9yk4X3GiRYQDg2Zz5RQUJsy0851azfpb6ecPjuaWVbVK7JCgiAN8DVgtVuqI=
X-Google-Smtp-Source: AGHT+IH4g9zw0Mgmbufnr1zYBcEq5drEsghzXY7SnRKBn73FP6WI3IUHtyTBgbqsO1naU5Ka8rycNw==
X-Received: by 2002:a2e:8188:0:b0:2ec:2ccb:8efb with SMTP id
 38308e7fff4ca-2ec2ccb8f7amr27426601fa.38.1718695218670; 
 Tue, 18 Jun 2024 00:20:18 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42307d5b78fsm132457605e9.6.2024.06.18.00.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:20:18 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 03/11] usb: gadget: dwc2: Convert interrupt handling to
 usb_gadget_generic_ops
In-Reply-To: <20240614005309.34433-4-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
 <20240614005309.34433-4-marek.vasut+renesas@mailbox.org>
Date: Tue, 18 Jun 2024 09:20:12 +0200
Message-ID: <874j9qk98z.fsf@baylibre.com>
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
>  drivers/usb/gadget/dwc2_udc_otg.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
> index 6bd395a6235..7e9dd6f4268 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -941,11 +941,6 @@ int dwc2_udc_handle_interrupt(void)
>  	return 0;
>  }
>  
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	return dwc2_udc_handle_interrupt();
> -}
> -
>  #if CONFIG_IS_ENABLED(DM_USB_GADGET)
>  struct dwc2_priv_data {
>  	struct clk_bulk		clks;
> @@ -1173,6 +1168,15 @@ static int dwc2_udc_otg_remove(struct udevice *dev)
>  	return dm_scan_fdt_dev(dev);
>  }
>  
> +static int dwc2_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	return dwc2_udc_handle_interrupt();
> +}
> +
> +static const struct usb_gadget_generic_ops dwc2_gadget_ops = {
> +	.handle_interrupts	= dwc2_gadget_handle_interrupts,
> +};
> +
>  static const struct udevice_id dwc2_udc_otg_ids[] = {
>  	{ .compatible = "snps,dwc2" },
>  	{ .compatible = "brcm,bcm2835-usb" },
> @@ -1185,6 +1189,7 @@ U_BOOT_DRIVER(dwc2_udc_otg) = {
>  	.name	= "dwc2-udc-otg",
>  	.id	= UCLASS_USB_GADGET_GENERIC,
>  	.of_match = dwc2_udc_otg_ids,
> +	.ops	= &dwc2_gadget_ops,
>  	.of_to_plat = dwc2_udc_otg_of_to_plat,
>  	.probe = dwc2_udc_otg_probe,
>  	.remove = dwc2_udc_otg_remove,
> @@ -1200,4 +1205,9 @@ int dwc2_udc_B_session_valid(struct udevice *dev)
>  
>  	return readl(&usbotg_reg->gotgctl) & B_SESSION_VALID;
>  }
> +#else
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	return dwc2_udc_handle_interrupt();
> +}
>  #endif /* CONFIG_IS_ENABLED(DM_USB_GADGET) */
> -- 
> 2.43.0
