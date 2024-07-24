Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC791C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72DCF88886;
	Wed, 24 Jul 2024 12:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y8+3ZGXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF5F488908; Wed, 24 Jul 2024 12:16:50 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D294D88886
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso47905875e9.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721816208; x=1722421008;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ez7nLfv7leuQeG8ZI380JVAwQBWp6P7Suev/YbQ2sRs=;
 b=y8+3ZGXmLFmiv56je8tZowwMWXidDhJDWOE3/H12gM3Hr1kVFQEVt0Hb6fl12lhelI
 lh+zV5BW93H9dVerYWdcalmz605zAjlUPrXzbRiQAoYnHIAmgZRCNbxasvbDaGA8MYcU
 Tgi7wtz6Y+rxZ7FmcqSThnIbkttjftXXypP0rOYx6gpO7Tu/UH0JOhs+85OzmNrxTWJs
 EAOu6Uryy2zn68xlkFwJXXt/jS7Ek3OdXTmL+d6j8dYE1yHBp9Tp9qBcmVR/f1tI0k6i
 /WXAqfAV58B9h8D51s17O2Djl8IxRdgCEulEzcXkYWKEoZ6JaEhBjVfkFsbiCzQeF4Bx
 aKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721816208; x=1722421008;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ez7nLfv7leuQeG8ZI380JVAwQBWp6P7Suev/YbQ2sRs=;
 b=oJApJpF0ZpqpFPsk7KE1BqrhdsW5IEhc/w8GUkIJMbCjpmZl4DRRjLLOFNGyEUkLmg
 pUyu+WmYUAefcTkqie389svYMgUMj2MjHBzRX8zqBTrCLYGadGT39FlGnB80nKudHnp8
 RY8o2t+8FdVDIkm+9nTmLVT4BWsYha+og6JIsi9UXREjdDGJdkrqGWNnfkDkvglzbC2D
 v/YdsW3ADMlZWaeaH7dCIwD5WbcFqfjpRduxYeTasiXBcvjsk0VjTz0eQBDEHWjzBmmm
 NmV0pJ9ji9ixYUI1RBv532cdrFJqJloll+7RelZgEKxNAB5YmjNr1UQ/AAYKdU4rSBBo
 LRNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeBUJPugA0oSZP52RMRWE65OuS9QF+/OsI5z0GWNbAhgAVZz9Kxx90aVA1hySDFQzC3pvx9gdXX/XdKevQwmXZ9/6YEA==
X-Gm-Message-State: AOJu0YwDWyTDEfxq1Q7VpLGmEZxUo9HDXEVzDE5PHrwfiNWkontUvTr+
 rvrmiKfWYyxSVC58fISfbsdEAiArjkQD2Ao1NZ8pAEmqi4EMB1RyNDVRH8oG68U=
X-Google-Smtp-Source: AGHT+IEuY/xRFPLJN3LpkT22lGaPSPwgvbQNIYFQHnTipJq58cV2mmCwrs9oOCfTCrsPXR7gPK6cMw==
X-Received: by 2002:a05:600c:4e8c:b0:427:9922:4526 with SMTP id
 5b1f17b1804b1-427dc53b7a0mr86186135e9.7.1721816208009; 
 Wed, 24 Jul 2024 03:16:48 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9413823sm22717775e9.47.2024.07.24.03.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 03:16:47 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 5/7] usb: gadget: atmel: Rename
 atmel_usba_start()/_stop() to usba_udc_enable()/_disable()
In-Reply-To: <20240723131817.262596-6-zli@ogga.fr>
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-6-zli@ogga.fr>
Date: Wed, 24 Jul 2024 12:16:46 +0200
Message-ID: <877cdb5c35.fsf@baylibre.com>
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

Hi Zixun,

Thank you for the patch.

On mar., juil. 23, 2024 at 15:18, Zixun LI <admin@hifiphile.com> wrote:

> Rename atmel_usba_start() / atmel_usba_stop() to usba_udc_enable()
> / usba_udc_disable(), remove atmel_ prefix to be inline with other
> functions. Also avoid confusion with DM start() / stop() functions.
>
> Signed-off-by: Zixun LI <zli@ogga.fr>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/gadget/atmel_usba_udc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index a3d24501ba..ea9ad7585e 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -1153,7 +1153,7 @@ static int usba_udc_irq(struct usba_udc *udc)
>  	return 0;
>  }
>  
> -static int atmel_usba_start(struct usba_udc *udc)
> +static int usba_udc_enable(struct usba_udc *udc)
>  {
>  	udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
>  
> @@ -1168,7 +1168,7 @@ static int atmel_usba_start(struct usba_udc *udc)
>  	return 0;
>  }
>  
> -static int atmel_usba_stop(struct usba_udc *udc)
> +static int usba_udc_disable(struct usba_udc *udc)
>  {
>  	udc->gadget.speed = USB_SPEED_UNKNOWN;
>  	reset_all_endpoints(udc);
> @@ -1253,7 +1253,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>  		return -EBUSY;
>  	}
>  
> -	atmel_usba_start(udc);
> +	usba_udc_enable(udc);
>  
>  	udc->driver = driver;
>  
> @@ -1279,7 +1279,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>  	driver->unbind(&udc->gadget);
>  	udc->driver = NULL;
>  
> -	atmel_usba_stop(udc);
> +	usba_udc_disable(udc);
>  
>  	return 0;
>  }
> -- 
> 2.45.2
