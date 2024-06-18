Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF50C2BD08
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1251288433;
	Tue, 18 Jun 2024 09:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mr4WyGpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B23C884A3; Tue, 18 Jun 2024 09:18:54 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E1C088433
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52c819f6146so6865142e87.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718695132; x=1719299932;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wv0M0mcITW5Qog82JJ4Fn9KPL1qZ8vLgJxjLuyxdQfs=;
 b=mr4WyGpupMFpH2wdiRcA+2c8eeWHxAjeKEgoAKlIIawkMvQ48+C0kkUa+b3Xk0sksJ
 wAAs9HXuJf32qNjnvN5KliZ6wV2Jm4k71Qihqs2T/yzrOfWgxcuMSFub7/6yBodelDHZ
 MAdYOwPYMPm5VqFLpRe3is6DwqkZ56a1ovOBcJIEVr5p6Wbh6FV4cgn2b6n2Wsp5lcye
 XoUYuGPFQLTn94RPeywkJrmnhjgxEFT90ZYMlLJHa/cFTrwaWLoCkG5lGdKPaQr4US5w
 ZDrPa1wz8IGJ7xmv1uc1EgZPx21shupy6+nzoLnJ5ufQBxzieQabJT1TaxefxJjIFxla
 0m1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718695132; x=1719299932;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wv0M0mcITW5Qog82JJ4Fn9KPL1qZ8vLgJxjLuyxdQfs=;
 b=qT4FwRObKPatPukLmsQ+cx69K/lBQ8otAJS/fDqSnKVbN0EP1WwUDvWhiz6id+aphZ
 IqXJ3A+VN2QWN4CSinCZQru9n5L4KcnP+tfzaT2/6NLjl+fYYXDkpxjEGo1nijuBOCqt
 FpPJIz9uZLqXzMO1iKT0BTHb/g3UH9HxBEZafx+pq71KjYjgvgLoxscoh3j7D9nq9eco
 mcEj2AAc28v26bdNmILQK0EMVFZYJEOfy206/wUo93oWEEdYh4U11SwAxXFeCg0SwwfE
 ee4kNnPA8yceWIeyurdaSIS2eVln6P8AxFIjh963XTQMmvhTnmLCDDjQf8XwmsKW4TOw
 +H7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBH6abfAyFSiyfsiXxIePV0DC5pcn7aIpqa66Rxy9nHtYpk31wnJ44L94yCuL3NVUww4sYxj60hmFPn+1qcSEpkyzqww==
X-Gm-Message-State: AOJu0YxhIKCiK1QaIXpd1ZxCdlHYuftwhKr55wBP58zqBAO8DFHVQAig
 +/1BgYhzESKLeMS1KM8ur/TET7RZopp4p1KztP08z5rUW7ydRUt2fdDlvm6ZViM=
X-Google-Smtp-Source: AGHT+IGQYQOpHUT8HFIL1254P5V9TKQNiDOk37kUfyr3Jj71FmzlBwxuYBRxUICWa2bHFKRT1RuMJA==
X-Received: by 2002:ac2:5338:0:b0:52c:39eb:40d2 with SMTP id
 2adb3069b0e04-52ca6e64459mr7414156e87.20.1718695130756; 
 Tue, 18 Jun 2024 00:18:50 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286eef70csm219870945e9.3.2024.06.18.00.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:18:50 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 02/11] usb: gadget: cdns3: Convert interrupt handling to
 usb_gadget_generic_ops
In-Reply-To: <20240614005309.34433-3-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
 <20240614005309.34433-3-marek.vasut+renesas@mailbox.org>
Date: Tue, 18 Jun 2024 09:18:47 +0200
Message-ID: <877cemk9bc.fsf@baylibre.com>
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
> Keep the dm_usb_gadget_handle_interrupts() in this driver for non-DM
> case for now, until this driver gets fully converted to DM USB gadget.
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
>  drivers/usb/cdns3/core.c          | 24 ++++++++++++++++++++++++
>  drivers/usb/cdns3/gadget-export.h |  2 ++
>  drivers/usb/cdns3/gadget.c        | 11 +----------
>  3 files changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index b4e931646b8..cbe06a9e7b6 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -20,6 +20,7 @@
>  #include <linux/bug.h>
>  #include <linux/kernel.h>
>  #include <linux/io.h>
> +#include <linux/usb/gadget.h>
>  #include <usb.h>
>  #include <usb/xhci.h>
>  
> @@ -462,15 +463,38 @@ static int cdns3_gadget_remove(struct udevice *dev)
>  	return cdns3_remove(cdns);
>  }
>  
> +static int cdns3_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	struct cdns3 *cdns = dev_get_priv(dev);
> +
> +	cdns3_gadget_uboot_handle_interrupt(cdns);
> +
> +	return 0;
> +}
> +
> +static const struct usb_gadget_generic_ops cdns3_gadget_ops = {
> +	.handle_interrupts	= cdns3_gadget_handle_interrupts,
> +};
> +
>  U_BOOT_DRIVER(cdns_usb3_peripheral) = {
>  	.name	= "cdns-usb3-peripheral",
>  	.id	= UCLASS_USB_GADGET_GENERIC,
>  	.of_match = cdns3_ids,
> +	.ops	= &cdns3_gadget_ops,
>  	.probe = cdns3_gadget_probe,
>  	.remove = cdns3_gadget_remove,
>  	.priv_auto	= sizeof(struct cdns3_gadget_priv),
>  	.flags = DM_FLAG_ALLOC_PRIV_DMA,
>  };
> +#else
> +int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	struct cdns3 *cdns = dev_get_priv(dev);
> +
> +	cdns3_gadget_uboot_handle_interrupt(cdns);
> +
> +	return 0;
> +}
>  #endif
>  
>  #if defined(CONFIG_SPL_USB_HOST) || \
> diff --git a/drivers/usb/cdns3/gadget-export.h b/drivers/usb/cdns3/gadget-export.h
> index 577469eee96..b3fd7c53039 100644
> --- a/drivers/usb/cdns3/gadget-export.h
> +++ b/drivers/usb/cdns3/gadget-export.h
> @@ -25,4 +25,6 @@ static inline void cdns3_gadget_exit(struct cdns3 *cdns) { }
>  
>  #endif
>  
> +void cdns3_gadget_uboot_handle_interrupt(struct cdns3 *cdns);
> +
>  #endif /* __LINUX_CDNS3_GADGET_EXPORT */
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index d11175dc5b6..32b2c412068 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -2755,19 +2755,10 @@ int cdns3_gadget_init(struct cdns3 *cdns)
>   *
>   * Handles ep0 and gadget interrupt
>   */
> -static void cdns3_gadget_uboot_handle_interrupt(struct cdns3 *cdns)
> +void cdns3_gadget_uboot_handle_interrupt(struct cdns3 *cdns)
>  {
>  	int ret = cdns3_device_irq_handler(0, cdns);
>  
>  	if (ret == IRQ_WAKE_THREAD)
>  		cdns3_device_thread_irq_handler(0, cdns);
>  }
> -
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> -{
> -	struct cdns3 *cdns = dev_get_priv(dev);
> -
> -	cdns3_gadget_uboot_handle_interrupt(cdns);
> -
> -	return 0;
> -}
> -- 
> 2.43.0
