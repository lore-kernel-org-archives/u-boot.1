Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0C4C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86CC988881;
	Wed, 24 Jul 2024 12:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IUaK3wKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D5A8883E; Wed, 24 Jul 2024 12:14:52 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AAD1888D7
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4266fd395eeso47734485e9.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721816088; x=1722420888;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=90Ii16dGfA4/Mbpr7D6QpmRNFg8K9o7U5/arTaDp/+I=;
 b=IUaK3wKiPA5z+XMMKe+jcQu/WuT7CNpWZ9x711b51KOT/MrjB7noa/8hArQygMys8q
 kIW7t4P1likYatleu8eYozSG+LK6d1dTtk6vUqRCEoovIjs7JMkNHyuKFkP5+GVN6wPZ
 sxUcnDJY1hzMy+xyE7p5HjEdL8GUzMPUrnO6ROvjteUQXf5LJcroaW2xctMAXG3T3Inp
 mlXk9Be2kcPad4VJt13Kp8RJ1Ov6meLtHC2PXCjt/z881Qgd0vudH97/yDCWoqd97ZJq
 q97ySh2BeH06qOk12A8nFxFUhQg8t/CrVKj+uJjaJjtCArQM2bdf1SkOiOkLBtxP1hgG
 30BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721816088; x=1722420888;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=90Ii16dGfA4/Mbpr7D6QpmRNFg8K9o7U5/arTaDp/+I=;
 b=l2/tL9e5S5XpGoxL8JKH4pBVm+FddF4PilNSCnTxgHEC91uFt43VVCk7YGHSeTBIl0
 XFVg2Xnr8YtvsIAyLvso0EXPDB1IzXrr2AmPRZEGdXFey8/OPLx7l2T68NnfLLcD46Ky
 UuUqY7J/pcFDsuxkGD8UZZefii2hQh+VYexZDooaQEP4GCS/HEYxa/m9uLb/K+q/sr14
 xZh/N/ZzXpZFCvQchEJ5G8LaMP40mezQWgnYLiTGcFy3wtXXLeIsaWs2mCV9wL9cAETE
 VhMv7Y1scZ7LGWqRkSX9sKreP1Wx90wvtAYyq7HFshH2E9pYWgQybfyq0anxp+DtlRx8
 z5HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwemp9gTmS6UABTZH9M3MEhODMpALtJMcSOJkI5nvJxLQOj/We1+s1K1bFC52AO4MuS/ptXkBySBsaQawCfCSiStjfig==
X-Gm-Message-State: AOJu0Ywy0kOhabbfVpj7zRQkmjdqOg9Ft7owtjd4pZFjpGFOITe7PTEl
 rJXUTA6qqDepgyCeR/VCMyb/VH/rYHnsQblWexWIk0RlRCnpEHAhq5PSMNcbkXU=
X-Google-Smtp-Source: AGHT+IECG21oeVzh6qD10umUYjp0k+vsHfQGTTPZP6WEyCQAnV8eIRrS31zKIe9Ms+w/a2Fqfx+/LA==
X-Received: by 2002:a05:600c:3b90:b0:426:6ed5:fd5 with SMTP id
 5b1f17b1804b1-427dc53b5c9mr86112265e9.6.1721816087722; 
 Wed, 24 Jul 2024 03:14:47 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93aba72sm22089095e9.37.2024.07.24.03.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 03:14:47 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 3/7] usb: gadget: atmel: Fix typo in
 usb_gadget_register_driver()
In-Reply-To: <20240723131817.262596-4-zli@ogga.fr>
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-4-zli@ogga.fr>
Date: Wed, 24 Jul 2024 12:14:46 +0200
Message-ID: <87cyn35c6h.fsf@baylibre.com>
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

> Replace "paramter" by "parameter".
>
> Signed-off-by: Zixun LI <zli@ogga.fr>

Same remark on checkpatch warning:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Zixun LI <admin@hifiphile.com>' != 'Signed-off-by: Zixun LI <zli@ogga.fr>'


> ---
>  drivers/usb/gadget/atmel_usba_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index 83fdc36870..2e3d8f36a2 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -1204,7 +1204,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>  	int ret;
>  
>  	if (!driver || !driver->bind || !driver->setup) {
> -		log_err("bad paramter\n");
> +		log_err("bad parameter\n");
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.45.2
