Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90E6C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B11C884C9;
	Tue, 18 Jun 2024 09:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v17lrG+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D22884DB; Tue, 18 Jun 2024 09:45:13 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BABCF884C9
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-35f1dc4ab9aso4260121f8f.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718696711; x=1719301511;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=t0QGRpZGLlDg38g4XunIRYZrT/UQxM0xoybKPtshJA8=;
 b=v17lrG+hHRftklIGXRpgXTO7nbv0clc19UBbvNr7PBg5LDOpGgcu8m7gCzXTdB9xD6
 br/WqAVyDU+tP4EtFNcEt57yvagfJu02WASayf3IbDOX1PcJWNN7JJrtHVemvsLrnFmD
 pc81a/eUCEWOEtaX9K9Y+hDlC0lDcUzSOc51h3NPhIF9rWmWsY0TYpR3v01FLoqtFflZ
 KEetNlMGmszSVQ4QMhLl1S1JvpJaS5hl7goYdc3VxUwO8S6LyvMa0PirE9qThh0ajDLO
 G1yWg0oshZ2JNlt0phfoUe38YmNqtzNWqWlazzzvxYUnpxOJYUQC1oStSBLX1jaEhMwo
 hODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718696711; x=1719301511;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t0QGRpZGLlDg38g4XunIRYZrT/UQxM0xoybKPtshJA8=;
 b=b29rWyw49wxtlMSCscsw/UMcQSqv9RM7sJju4ymIopE5kI77j6D6tZVrdWmbxjHa3P
 RFTAk1NdPFm4FqORSMoTu6BoSGWuRAZ5wt+IWE/wTawEdyfGKzYGTt3yq7GXpErsGdj7
 KNxySop59wjDniphnSemPA7OAjptL7p3nTjBUWpiej+9wt0B87LNbnPYU9exXpUQZCXe
 38ZA1JXh8WwnqL4v/E1PF1lKQ0WSRrFjZ5GMNHWrSFTPI3ktUsoLNzhrlYvY+/l1YTee
 PjzJglSIWGZPPq64gKhcOQdwj9A9GoI0lirl5qRjugsXmrkU/L2bZg9dhQWFR2ALa+Sa
 4GxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhwD/fJjSsLc+8e18nr0WTh8JmrDogGuZXNDsdo1NyuC+eROxLK0OCVRJ4wuDPhlSAveh3QR2JZ9zzbxMaw/gXa1vvgQ==
X-Gm-Message-State: AOJu0YwWGeMiUtGWZQ508EhFS8lD2gTIbFa2UB5aOnH0ynUjwUzqxRcu
 C2p8j6LL8cXmyBw5GdlgCIzLKKQjB+TCaAhY9wnvdiANsUTrShsMhbYRTWyAYa4=
X-Google-Smtp-Source: AGHT+IFGmIyhqTqI9yE1fUFfHjpUabzOHSXKFNB8uA5VCji8nXPWhGbAkMyrJMNRuJntv9kKTbtcyg==
X-Received: by 2002:a5d:4a4c:0:b0:35f:1d29:db8d with SMTP id
 ffacd0b85a97d-3607a76374dmr6984446f8f.25.1718696711189; 
 Tue, 18 Jun 2024 00:45:11 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104b7fsm13469275f8f.103.2024.06.18.00.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:45:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 10/11] usb: gadget: sandbox: Drop
 dm_usb_gadget_handle_interrupts()
In-Reply-To: <20240614005309.34433-11-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
 <20240614005309.34433-11-marek.vasut+renesas@mailbox.org>
Date: Tue, 18 Jun 2024 09:45:08 +0200
Message-ID: <87jzimitiz.fsf@baylibre.com>
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

> Drop dm_usb_gadget_handle_interrupts() in favor of empty default
> implementation of the same in drivers/usb/gadget/udc/udc-uclass.c .
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
>  drivers/usb/host/usb-sandbox.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/usb/host/usb-sandbox.c b/drivers/usb/host/usb-sandbox.c
> index e26f0b292ed..f687fe2c430 100644
> --- a/drivers/usb/host/usb-sandbox.c
> +++ b/drivers/usb/host/usb-sandbox.c
> @@ -123,12 +123,7 @@ static int sandbox_submit_int(struct udevice *bus, struct usb_device *udev,
>  	return ret;
>  }
>  
> -#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	return 0;
> -}
> -#else
> +#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
>  int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>  {
>  	struct sandbox_udc *dev = this_controller;
> -- 
> 2.43.0
