Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8917EC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE1B888E7;
	Wed, 24 Jul 2024 12:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ghTey7qt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A16D1888DD; Wed, 24 Jul 2024 12:12:54 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 205F988881
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-427d2c8c632so47377325e9.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721815970; x=1722420770;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kex2YIqqBlCoN/SZwbRboF73s8zpl4RDD7n5q9JaFjE=;
 b=ghTey7qtlDTm5B2HAIJ5orR8hfBlwn3rMZj4lHqT9hKIQOHH054O8ajBMrz/4+6XIe
 Q/hIjv5dmI/a2/Kv/OFuzqmgr/HV5wVlhWv7BwlVIysAGgwtsgM+HbqoKC+sIqgd4Nd6
 EKaoWyD3+A2UhpOHFDQiVW8UiFHVORj49hbKnVHWvh+ues/q8FK87qYA0gd35FSwD6XR
 e5JirKihQM5wGPrGX5jmDc0Wvkh2kLEojm4rYN6zocZvMk3WaFDjaP5xYKMiEW5+iR6K
 piClHbvAPcx2Vvr5p1T1YjjoQT/osEqzl9MDzOCFM8tcvSrK+uu2bCUm06xZ8b7clb+4
 BfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721815970; x=1722420770;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kex2YIqqBlCoN/SZwbRboF73s8zpl4RDD7n5q9JaFjE=;
 b=iCgr3HB4cQG9iHxzM+ixx1QNRmhToVV5JHPYFz+NMsBXyZm52MuHpnVNlWxFuNxAUv
 kYXGYXUEho+o8iauqxQ2eJb0tASa7mWYWbD43xCgJbOLVCmgC5Wyb/AiI2Oz+n9PFcTS
 X92z34SlMsvCYGuNpe3MSR/pucIPif9OAWplCUmwZt23N4txyrC/yeRBPfl6Zly1Xeaj
 3xYO6/ssEwiykF31BU/Yc3MUm96uwmrBQ/UpdT7BaoAp6UYfG30BmIwB6ihwf1/leGBu
 3kK8mUWDHelwDrq1UMYPqQ4n+3xnlT78dXIwZKfZVu8z7NLFDwEkDb4IL2I5xihr8qKK
 GTSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4NeZimObi1O7uZkQSHUgz7OCefky0y2Bh5SbIEHgUKIuuk/JQSAc9HjvHJZCsENJ7UiwsS7hlGCZ1MHph9O1mEJ8PNQ==
X-Gm-Message-State: AOJu0Yx5Lb0ouPvN0+WC9K7gt+s/nkUlc0W/W3HyDVUxsRgDPrDIHuxv
 NJRTAUCh6K3g0d8Si8+rqu/fprrsuudqxrWaO57CP0SEUCEoxDgWHmg5XTSMBscOpTTVJ0B2qpL
 R
X-Google-Smtp-Source: AGHT+IFLnpy/5LrkAfSP4YbwZWqu7YFe1Vp7fsxhyvVnaQYDy2gEDvaFjgz8iJBmET6xbZLbmMEV6w==
X-Received: by 2002:a05:600c:198f:b0:426:5fbc:f319 with SMTP id
 5b1f17b1804b1-427dc59eac8mr73066215e9.33.1721815970128; 
 Wed, 24 Jul 2024 03:12:50 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868ba9asm13940267f8f.41.2024.07.24.03.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 03:12:49 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/7] usb: gadget: atmel: Replace printf() and
 pr_err() by log_err()
In-Reply-To: <20240723131817.262596-3-zli@ogga.fr>
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-3-zli@ogga.fr>
Date: Wed, 24 Jul 2024 12:12:48 +0200
Message-ID: <87frrz5c9r.fsf@baylibre.com>
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

> To have a uniform printing function, also drop linux/printk.h as no
> longer used.
>
> Signed-off-by: Zixun LI <zli@ogga.fr>

Checkpatch complains here:

checkpatch.pl: 164: WARNING: From:/Signed-off-by: email address mismatch: 'From: Zixun LI <admin@hifiphile.com>' != 'Signed-off-by: Zixun LI <zli@ogga.fr>'

Please make sure that the commiter matches the Signed-off-by.
This can be done with git commit --reset-author or --author="name <email>"

> ---
>  drivers/usb/gadget/atmel_usba_udc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index 5f78251fdb..83fdc36870 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -7,13 +7,13 @@
>   *			   Bo Shen <voice.shen@atmel.com>
>   */
>  
> +#include <log.h>
>  #include <malloc.h>
>  #include <asm/gpio.h>
>  #include <asm/hardware.h>
>  #include <linux/bitops.h>
>  #include <linux/errno.h>
>  #include <linux/list.h>
> -#include <linux/printk.h>
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/atmel_usba_udc.h>
> @@ -1204,12 +1204,12 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>  	int ret;
>  
>  	if (!driver || !driver->bind || !driver->setup) {
> -		printf("bad paramter\n");
> +		log_err("bad paramter\n");
>  		return -EINVAL;
>  	}
>  
>  	if (udc->driver) {
> -		printf("UDC already has a gadget driver\n");
> +		log_err("UDC already has a gadget driver\n");
>  		return -EBUSY;
>  	}
>  
> @@ -1219,7 +1219,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>  
>  	ret = driver->bind(&udc->gadget);
>  	if (ret) {
> -		pr_err("driver->bind() returned %d\n", ret);
> +		log_err("driver->bind() returned %d\n", ret);
>  		udc->driver = NULL;
>  	}
>  
> @@ -1231,7 +1231,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>  	struct usba_udc *udc = &controller;
>  
>  	if (!driver || !driver->unbind || !driver->disconnect) {
> -		pr_err("bad paramter\n");
> +		log_err("bad parameter\n");

Here we change both:
1. pr_err() to log_err()
2. fix paramter -> parameter

2. should be done in patch 3/7 instead of here.

With the above fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>  		return -EINVAL;
>  	}
>  
> @@ -1252,7 +1252,7 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
>  
>  	eps = malloc(sizeof(struct usba_ep) * pdata->num_ep);
>  	if (!eps) {
> -		pr_err("failed to alloc eps\n");
> +		log_err("failed to alloc eps\n");
>  		return NULL;
>  	}
>  
> -- 
> 2.45.2
