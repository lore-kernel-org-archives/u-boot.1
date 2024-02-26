Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B58C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE40387842;
	Mon, 26 Feb 2024 09:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="huplXy42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC27187842; Mon, 26 Feb 2024 09:23:57 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5BC28701B
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33ddd1624beso180777f8f.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 00:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708935834; x=1709540634; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ffWuVnoRiCMtZ9PPDq1ogdb7gLMBYEZssC/SOthAJCw=;
 b=huplXy420vqiGsvP/r+i9/HfuRC/GlS7DFJ0v3x/e8mMoHdrbMMTKlvMtDuTylCrQz
 xr6H4GOlvMM/JmOmzcGwKvUKAmhZwegy10lZUf3K/rlITa+/2KZdkEJdP9qGgRv7uRu8
 JrW+uK1Ez9+4L/6RP5tHicEAGFANwJr0tBokL4OjMBPoVqLXiraPZfAmUjZLbg22sCtG
 MFYKz4j5KhOVJV9KiZE1m/+MTs7TadAIChK8pHNE+2TDFgj9NlVvzG0kdQn4uD2abgUy
 vMAiP3GSxSyJcL907DLt9+L8Y234sfcmyK9ZF8LwopsL/0q03EW3tkIf4ahQBQboNLH/
 IlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708935834; x=1709540634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ffWuVnoRiCMtZ9PPDq1ogdb7gLMBYEZssC/SOthAJCw=;
 b=JKMXhhzdEW+SQVGVmaxuvaZm1393CuB0G59o3aEzqRmOeepUzTznI/KSSYMd/z0Hzk
 Ps6VT0nZVen33cUeCPD93ojJizuQ/q+PyM8XSr7xMkxDAKCZ9LW7ltV6r4k1pbmxQ/TF
 5hKCXtXNY9Qu9dHx9IJzX4ao+9GEjtT+hfWAVn5jhGv85qX1WwqNkS90TXILbaDA8gtx
 Hc9VwCHXi0ZhvqzHys9zO03GterMg4uzkVBNSJ6wEBa2pb1957X79VZ/YT+onMMuKUUL
 A3ITO1mJS9Up6mlEte8dlM9oqWCKdfG8SVFB0WLzwz8VGFljIfgAiO9zUvz/sewS4h/n
 Ufjg==
X-Gm-Message-State: AOJu0YzFuS0+9NS3ykx20fpm+H9UiYWwvNOASbMQsHGjbRqYBVwkWA+4
 SZn59xc57cIlntccVPBxWgwYfe6o43jRZAU9LFIswqcmtYazyIce+28RqEjW1zE=
X-Google-Smtp-Source: AGHT+IHq0UQKtn8YaBnehC7RRlvQd7wtDgKjiaVH02GQEIms9+//pjyqndSd60JMnTLgUa+hVxMrvQ==
X-Received: by 2002:adf:e4cc:0:b0:33d:8e93:9524 with SMTP id
 v12-20020adfe4cc000000b0033d8e939524mr5190129wrm.29.1708935833677; 
 Mon, 26 Feb 2024 00:23:53 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 ch12-20020a5d5d0c000000b0033dabeacab2sm7389367wrb.39.2024.02.26.00.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:23:53 -0800 (PST)
Date: Mon, 26 Feb 2024 11:23:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: forbidden405@outlook.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH RESEND] serial: pl01x: set baudrate when probing
Message-ID: <55c3b1b2-f384-44bb-8cf3-d47884124b6f@moroto.mountain>
References: <20240225-b4-pl011-v1-1-2686496c1a17@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225-b4-pl011-v1-1-2686496c1a17@outlook.com>
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

On Sun, Feb 25, 2024 at 08:38:33AM +0800, Yang Xiwen via B4 Relay wrote:
>  #if CONFIG_IS_ENABLED(OF_PLATDATA)
>  	struct dtd_serial_pl01x *dtplat = &plat->dtplat;
> @@ -301,10 +302,14 @@ int pl01x_serial_probe(struct udevice *dev)
>  #endif
>  	priv->type = plat->type;
>  
> -	if (!plat->skip_init)
> -		return pl01x_generic_serial_init(priv->regs, priv->type);
> -	else
> +	if (!plat->skip_init) {
> +		ret = pl01x_generic_serial_init(priv->regs, priv->type);
> +		if (!ret)
                    ^^^^
This if statement seems to be reversed.

regards,
dan carpenter

> +			return ret;
> +		return pl01x_serial_setbrg(dev, gd->baudrate);
> +	} else {
>  		return 0;
> +	}
>  }

