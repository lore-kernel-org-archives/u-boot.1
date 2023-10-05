Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD86E9370C
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 12:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A951386AE6;
	Thu,  5 Oct 2023 14:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="18E952Qm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE1286C6A; Thu,  5 Oct 2023 14:33:21 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8253186AE6
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 14:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4056ce55e7eso7866695e9.2
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696509199; x=1697113999;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=onzvcJ1g6UZ8o5CzvZFjBum2BLB9jQgIETRP4zT71VM=;
 b=18E952QmTaFGSlIfmlbsIwF1IJDOjRoRnFojE5fEvudFc5Wd/lg9x09ttIt+LgKWvR
 azeYo4u2kpr2/MG7Ij4fldQ9VdL1Ig5GFeCPC37MuaGyxxAIrZIIgZvPNdcWEXEN1GOD
 2Z1UrceXmQDNJsUy5/2Bi+nXBp34Ndm+kIB46x8Lhki+erC372U9OqUXjDQiGKjoXMi8
 9GJ3jackrrfzuygAd72dJcCedyWMJOQFM+sI5lhj3UjzTiTqFLH28Q+36eqjGTpxVu/y
 pfDOU/ZH9qdMuOeDxi1lljaEz16gNVqYIc/P/4y5REXdJVqz07Lc0ASClhTqv7Nr0MXt
 q8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696509199; x=1697113999;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=onzvcJ1g6UZ8o5CzvZFjBum2BLB9jQgIETRP4zT71VM=;
 b=qGhWIeiWW41rtGLN709y+CbFBAYUt1KjfMg6voNCP+upozSxJtmnKw0jcYCVAX/jps
 mgihhmQWmyRfQQjZe9AdkDpkvRQBzCkim50SQgoQWGwF6oI0NLaTe/bxpl2Jlqg82NQO
 EbEs95b6Aw4/Lhnb7PhG1tojSmquX8BTRPwg6zrINv4dyRl7V9pkq97GJAu6eh67klEC
 4Z+dYNccT6EMDU/cbIbvycXf9l6ejWG3PNwAYjwoT0e5GgnfEhGy36Xf0vfomeGTKfss
 j64LsYN943PM0HvAVrMjG5S9eAYwrSWdYZRWZjGGbL1byO9HIPSg7Ur4/7HD7vb0HFi/
 NjVA==
X-Gm-Message-State: AOJu0YysfZ/QeMnOdG8mK12fbBTkQ6Iw5RLajWtiwNQsWxBrEDGXH+hC
 xOZIHmzubks//U0mU11tNk5f9Xet6kp0s6Egy+c=
X-Google-Smtp-Source: AGHT+IGg2Abp7oHkWZnOItmrAxTZPwEuK/tl6tbi3ZpMig58/rt0/Tn7vL/VuIWyX/wyPdbrc0Gkmw==
X-Received: by 2002:a05:600c:2298:b0:3fe:1af6:6542 with SMTP id
 24-20020a05600c229800b003fe1af66542mr5283715wmf.33.1696509198947; 
 Thu, 05 Oct 2023 05:33:18 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 l17-20020a1ced11000000b0040588d85b3asm3672770wmh.15.2023.10.05.05.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 05:33:18 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH RESEND v2 2/2] usb: udc: Try to clarify an error message
In-Reply-To: <20231002134621.94786-2-miquel.raynal@bootlin.com>
References: <20231002134621.94786-1-miquel.raynal@bootlin.com>
 <20231002134621.94786-2-miquel.raynal@bootlin.com>
Date: Thu, 05 Oct 2023 14:33:17 +0200
Message-ID: <87pm1tb65u.fsf@baylibre.com>
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

On lun., oct. 02, 2023 at 15:46, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> At some point when trying to use USB gadgets, two situations may arise
> and lead to a failure. Either the UDC (USB Device Controller) is not
> available at all (not described or not probed) or the UDC is already in
> use. For instance, as the USB Ethernet gadget remains bound to the UDC,
> the use of any other USB gadget (fastboot, dfu, etc) *after* will always
> fail with the "couldn't find an available UDC" error.
>
> Let's give a more helpful message by making a difference between the two
> cases. Let's also hint people who would get this error and grep it into
> the sources a better explanation of what's wrong with their workflow.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> While doing this I really wanted to add "much more" error comments but I
> faced another reality: often the messages are there but use
> pr_err/log_err which is actually silenced by default with LOGLEVEL=3, so
> I consider this unnecessary, as decreasing the loglevel will make these
> messages appear. I would have expected errors to be displayed, but I
> understand it makes the binaries even bigger.
>
> Resend: no change.
>
> Changes in v2:
> * s/UDC/UDCs/. I kept the sentence as it was as the suggested form did
>   not sound well at all when there is only one UDC.
> ---
>  drivers/usb/gadget/udc/udc-core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
> index 7f73926cb3e..8405b03462e 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -323,6 +323,7 @@ err1:
>  int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
>  {
>  	struct usb_udc		*udc = NULL;
> +	unsigned int		udc_count = 0;
>  	int			ret;
>  
>  	if (!driver || !driver->bind || !driver->setup)
> @@ -330,12 +331,22 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
>  
>  	mutex_lock(&udc_lock);
>  	list_for_each_entry(udc, &udc_list, list) {
> +		udc_count++;
> +
>  		/* For now we take the first one */
>  		if (!udc->driver)
>  			goto found;
>  	}
>  
> -	printf("couldn't find an available UDC\n");
> +	if (!udc_count)
> +		printf("No UDC available in the system\n");
> +	else
> +		/* When this happens, users should 'unbind <class> <index>'
> +		 * using the output of 'dm tree' and looking at the line right
> +		 * after the USB peripheral/device controller.
> +		 */
> +		printf("All UDCs in use (%d available), use the unbind command\n",
> +		       udc_count);
>  	mutex_unlock(&udc_lock);
>  	return -ENODEV;
>  found:
> -- 
> 2.34.1
