Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BCBC54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 10:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4635287DE2;
	Thu, 21 Mar 2024 11:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3cZ1xLwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE84580245; Thu, 21 Mar 2024 11:02:22 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40DB88013
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 11:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-513e14b2bd9so955716e87.2
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 03:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711015339; x=1711620139;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4JG21ru2ltU/2H3Va3LZKQgMHeC+bhoSOuMJEVERDfM=;
 b=3cZ1xLwZZG/+FKW/b05KxsVdLONfNs666mdhF55QZ2cP3Miql0f2PngRvDz9VsZow7
 aaieujTmpKnGabS5R399WQc1ugAJzF3fua/hAhOnmq0LJ5H2YN96mbjKOuP+fTTLmK3Y
 w/BAl/tXenwZHfcVaaG08hxhnVC6at31TGke8m2wVtEj++oIwcK1Hl+PClljPz5/fURC
 uAYxks43hPhjnCLLW2gRyO5dU8hgWrCMnMcRby/7nsoiRQIUXSSdEVom3TS8xEKqd58+
 eNbqxGoaCFAeSE3J32ymQ9Acu3T8frGHf8+Gjnie4orud/IBsqFL7lwmTw9C81TVh+sl
 nTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711015339; x=1711620139;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4JG21ru2ltU/2H3Va3LZKQgMHeC+bhoSOuMJEVERDfM=;
 b=ipXXKbR3MDEI77cScw/ZBMSesbKxJslJzA1rbE8bqTKoJunSQnZuHzz5Ii/twhSVmL
 QNSUPQhA1xVy/nFW6/VEDNS0vXDZS5xfOlDheymPcKgcnVKf5zOF+iMdc4qWwukiZj+t
 PZQWZsarDzERooewTPfrWBXtw6bv4jdENueP19GehMt3UpbQsZxhWh/vsHWb1R64Xrpa
 iNdteP0FzmryWsDoQax9t2iZRFX4+ZGxfs2WcYY/ttydFmVC4g9PKg/v9ekOL8b5dUNn
 93QQrg7MajRoGZbHi3nWs4nhHBCXzmS05h/KsQ+BogTDdyEW+nmNV04lT+n3Uc5ldCwz
 jqlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtADomZo5XAljzA7Z3JT1vnKfGFiRdbLw4RDLnuKldkJWqX5tfPsTy5qef7rb+D8J8gyf64Ox0kpFk1oIeOznbczkQFw==
X-Gm-Message-State: AOJu0YwNERm0xkVN+4ci3BaxP0qWruXCbsaDv+SreCOKPDzAT98ezV2B
 ADhGQ3eHj8RMJxtR/Wmk/Y2dhoYH7aXzflN6CZwuE57Gmax84Rerqvt7xdQvjqc=
X-Google-Smtp-Source: AGHT+IERhQFvzUMjB8RW7SZomKb9z+CUIIjtUDOLkBBKYlH44h6ZjsOC+getMpgT7jjPSC75Cykuig==
X-Received: by 2002:ac2:5042:0:b0:513:22f0:c3af with SMTP id
 a2-20020ac25042000000b0051322f0c3afmr15879044lfm.4.1711015338909; 
 Thu, 21 Mar 2024 03:02:18 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 p17-20020a05600c1d9100b00414774adccbsm191898wms.9.2024.03.21.03.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 03:02:18 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Angus Ainslie
 <angus@akkea.ca>, Caleb Connolly <caleb.connolly@linaro.org>, Eugen
 Hristev <eugen.hristev@collabora.com>, Igor Prusov
 <ivprusov@salutedevices.com>, Nishanth Menon <nm@ti.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, Stefan
 Bosch <stefan_b@posteo.net>, Svyatoslav Ryhel <clamor95@gmail.com>, Tom
 Rini <trini@konsulko.com>, kernel@puri.sm
Subject: Re: [PATCH 2/2] usb: udc: dwc3: Fold dwc3_uboot_handle_interrupt
 into dm_usb_gadget_handle_interrupts
In-Reply-To: <20240317044357.547037-2-marek.vasut+renesas@mailbox.org>
References: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
 <20240317044357.547037-2-marek.vasut+renesas@mailbox.org>
Date: Thu, 21 Mar 2024 11:02:17 +0100
Message-ID: <875xxfoqc6.fsf@baylibre.com>
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

On dim., mars 17, 2024 at 05:42, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> The only call site of dwc3_uboot_handle_interrupt() is the
> dm_usb_gadget_handle_interrupts(), fold the former into the
> later. This makes dwc3_uboot_handle_interrupt() unavailable
> to be called from board code as well.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: Igor Prusov <ivprusov@salutedevices.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Bosch <stefan_b@posteo.net>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: kernel@puri.sm

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Tested that I could scan for usb mass storage and that I can use
fastboot:

=> fastboot usb 0
crq->brequest:0x0
=> usb start
starting USB...
Bus usb@ff500000: Register 3000140 NbrPorts 3
Starting the controller
USB XHCI 1.10
scanning bus usb@ff500000 for devices... 3 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found

=> usb storage
  Device 0: Vendor: SanDisk Rev: 1.00 Prod: Ultra
            Type: Removable Hard Disk
            Capacity: 29328.0 MB = 28.6 GB (60063744 x 512)

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # vim3

> ---
>  drivers/usb/dwc3/core.c | 27 +++++++++++----------------
>  include/dwc3-uboot.h    |  1 -
>  2 files changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 09737be9a9c..96e850b7170 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -988,18 +988,27 @@ MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
>  
> +#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
> +__weak int dwc3_uboot_interrupt_status(struct udevice *dev)
> +{
> +	return 1;
> +}
> +
>  /**
> - * dwc3_uboot_handle_interrupt - handle dwc3 core interrupt
> + * dm_usb_gadget_handle_interrupts - handle dwc3 core interrupt
>   * @dev: device of this controller
>   *
>   * Invokes dwc3 gadget interrupts.
>   *
>   * Generally called from board file.
>   */
> -void dwc3_uboot_handle_interrupt(struct udevice *dev)
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>  {
>  	struct dwc3 *dwc = NULL;
>  
> +	if (!dwc3_uboot_interrupt_status(dev))
> +		return 0;
> +
>  	list_for_each_entry(dwc, &dwc3_list, list) {
>  		if (dwc->dev != dev)
>  			continue;
> @@ -1007,20 +1016,6 @@ void dwc3_uboot_handle_interrupt(struct udevice *dev)
>  		dwc3_gadget_uboot_handle_interrupt(dwc);
>  		break;
>  	}
> -}
> -
> -#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
> -__weak int dwc3_uboot_interrupt_status(struct udevice *dev)
> -{
> -	return 1;
> -}
> -
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	if (!dwc3_uboot_interrupt_status(dev))
> -		return 0;
> -
> -	dwc3_uboot_handle_interrupt(dev);
>  
>  	return 0;
>  }
> diff --git a/include/dwc3-uboot.h b/include/dwc3-uboot.h
> index 5f13f5bcf40..3689d60ae7f 100644
> --- a/include/dwc3-uboot.h
> +++ b/include/dwc3-uboot.h
> @@ -45,7 +45,6 @@ struct dwc3_device {
>  int dwc3_uboot_init(struct dwc3_device *dev);
>  void dwc3_uboot_exit(int index);
>  int dwc3_uboot_interrupt_status(struct udevice *dev);
> -void dwc3_uboot_handle_interrupt(struct udevice *dev);
>  
>  struct phy;
>  #if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
> -- 
> 2.43.0
