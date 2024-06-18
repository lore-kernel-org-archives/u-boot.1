Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFF7C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB58F8838E;
	Tue, 18 Jun 2024 09:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pYnzAUDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74223882BE; Tue, 18 Jun 2024 09:12:38 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B47E88422
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35f1e35156cso4470518f8f.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718694755; x=1719299555;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=oVEM1I2xNIPCsUpAtdJCqjDfHlaT/uEA2qvAx7SdcBk=;
 b=pYnzAUDtZMUeSZRla4C4t/VOYeOjqEt3G+DsmP/Sx2VI2GTHBD+2Y5qGDPuh+HPn5/
 7s9E0ULrY+6KFeg5g+cqVvnxvH+m4uu/T+xCspCaGMehQ7kxe0ZR3oiIzMCGIFS9ihYR
 d0qhcrbj6Onyue0AMbV0lQWug3ZcNgoWP3yMMzEuAtUO4l1avO1hmirkawvf8+k1B65f
 RHg29mmMcdNW/rMYNK6DW4aKSLT5ObwIEi4oDSpY6nMFdJ0jPGTXoqkso1JNI932muiK
 w2+pDhnZ1cLcp0USUurtYOPJ1wYjnOAVqdJvYKSfa99jpVhtfibsgHzvD4fm/A10fPC6
 fLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718694755; x=1719299555;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oVEM1I2xNIPCsUpAtdJCqjDfHlaT/uEA2qvAx7SdcBk=;
 b=t1R3epASYnctBX/3dMeSnzVW/SB/R6H0O6zGLCGcqNK+mj9s22a/JWsqKqnkQX2AXV
 Lla06tXTmypXYd1bqxfdv8YHc+Pyp+lhIxcVxqC7QLo7LLlsKkoJUJvIAni7X2Z9FEp1
 5e/laYPVmbqJyTMRwhvaHnHR3e3zqM4Sq8oq2ZmL2L3Z2Wr8jLnP7UrJNIzJbR9rKWRb
 XjmkmesMtYv4bEln4tbGFcjR0u+R6TaM5Z88fRzDnCxtWzqYSTIGTZW6iEFw5zVTf0xk
 a/bBxagSMh3hofINVwJh5BrtanTQtvSaBVLnU6+zwb0KQClgRAE3b8rZsO3xmG3zq5eY
 u3Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7nZ+4xOAnD7vC3jgMGycA2zfWBQJmbkl6n67T5AGIYhhSTWGv6LEbY73D+T3KfyKYOWa8JlLDYIYmGfOCg9eXoiRKWg==
X-Gm-Message-State: AOJu0Ywe1TL/gbfAtEI2n8I7yrAjym8M9ufbJWY/9twwxFQ5o7QYHu8M
 WPG9ZaPrdtoLcnFNzovJ1uLvXqYXA5jGMYC/cYketoFNtvZXbAfXLl2+icTpo34=
X-Google-Smtp-Source: AGHT+IGI0vfRhMmj38VuQdBnzT6yyIOmwCklqIcze6KkJaw1w+1acuBqCTBW4XUjqb9rWYnQbDnEbg==
X-Received: by 2002:a05:6000:1b0c:b0:35f:2a44:8aa with SMTP id
 ffacd0b85a97d-3607a7b0fe9mr6775144f8f.4.1718694754847; 
 Tue, 18 Jun 2024 00:12:34 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104a26sm13515032f8f.97.2024.06.18.00.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:12:34 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 01/11] usb: gadget: Introduce handle_interrupts ops to
 USB_GADGET_GENERIC uclass
In-Reply-To: <20240614005309.34433-2-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
 <20240614005309.34433-2-marek.vasut+renesas@mailbox.org>
Date: Tue, 18 Jun 2024 09:12:32 +0200
Message-ID: <87cyoek9lr.fsf@baylibre.com>
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

> Introduce .ops for USB_GADGET_GENERIC uclass. The first new ops is
> .handle_interrupts which must be implemented by DM capable USB gadget
> controller drivers and must implement interrupt handling similar to
> dm_usb_gadget_handle_interrupts(). This patch currently provides weak
> dm_usb_gadget_handle_interrupts() implementation which is overriden by
> the drivers, but this will be removed once conversion to handle_interrupts
> callback is complete.
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
>  drivers/usb/gadget/udc/udc-uclass.c | 24 ++++++++++++++++++++++++
>  include/linux/usb/gadget.h          |  8 ++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc/udc-uclass.c
> index 5dc23a55bb5..2320039fe3b 100644
> --- a/drivers/usb/gadget/udc/udc-uclass.c
> +++ b/drivers/usb/gadget/udc/udc-uclass.c
> @@ -12,6 +12,25 @@
>  #include <linux/usb/gadget.h>
>  
>  #if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +static inline const struct usb_gadget_generic_ops *
> +usb_gadget_generic_dev_ops(struct udevice *dev)
> +{
> +	return (const struct usb_gadget_generic_ops *)dev->driver->ops;
> +}
> +
> +__weak int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	const struct usb_gadget_generic_ops *ops;
> +
> +	ops = usb_gadget_generic_dev_ops(dev);
> +	if (!ops)
> +		return -EFAULT;
> +	if (!ops->handle_interrupts)
> +		return -ENOSYS;
> +
> +	return ops->handle_interrupts(dev);
> +}
> +
>  int udc_device_get_by_index(int index, struct udevice **udev)
>  {
>  	struct udevice *dev = NULL;
> @@ -54,6 +73,11 @@ int udc_device_put(struct udevice *udev)
>  {
>  	return board_usb_cleanup(legacy_index, USB_INIT_DEVICE);
>  }
> +
> +__weak int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #if CONFIG_IS_ENABLED(DM)
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 36572be89e6..cf2161603d6 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -970,6 +970,14 @@ extern void usb_ep_autoconfig_reset(struct usb_gadget *);
>  
>  extern int dm_usb_gadget_handle_interrupts(struct udevice *);
>  
> +/**
> + * struct usb_gadget_generic_ops - The functions that a gadget driver must implement.
> + * @handle_interrupts: Handle UDC interrupts.
> + */
> +struct usb_gadget_generic_ops {
> +	int (*handle_interrupts)(struct udevice *udevice);
> +};
> +
>  /**
>   * udc_device_get_by_index() - Get UDC udevice by index
>   * @index: UDC device index
> -- 
> 2.43.0
