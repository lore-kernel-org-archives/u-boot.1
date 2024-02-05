Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65558C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 07:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB64876FA;
	Mon,  5 Feb 2024 08:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qvtuYi0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E883D8775F; Mon,  5 Feb 2024 08:40:27 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03C4B875E9
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 08:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a358ec50b7cso485946166b.0
 for <u-boot@lists.denx.de>; Sun, 04 Feb 2024 23:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707118825; x=1707723625; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HJ0xdkGtRFQDb/otS7sNwRSS9n7PsHRyxlHO/e2IxOo=;
 b=qvtuYi0LdVOLpL829XBhToC1ZGXODnWFEzMFAtTP3Ng8TgTX8rfdBRNTmoXm0oCfFh
 +0M73VIcvO5xmHZTWqEGG3KiaPDyDy6HqC4/79dzhuqc+S7wkhHfLY9uMi6HGWE4DHlp
 6v9Iq5LeZIwNeNLkxCWAeUXRr01NgVY/X81nBIMSNGDeZ7eqZeLA9RH05BoJ7ZTN/iw4
 t82Sr3kb5M7EX6LCjXvT7GywUksHxoDRGY/PRHPerqYM70h9V/fGVpU4hVQhPbaKxAjC
 x8IVolrBMJ/R2D9Ylre0O4vhs1pGLaQcCQL6PQ2JXSgI/sFB+zK/arVxtfUmHNKjWV9B
 v9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707118825; x=1707723625;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJ0xdkGtRFQDb/otS7sNwRSS9n7PsHRyxlHO/e2IxOo=;
 b=JfMY1tG80EAGDFTS//Fv1uAxEHKJdqFogWKVqk8d3Pp3/f8MdBiQnJ7Ik9GkvPce3R
 78mNL3VLqoF8laticCxQBLg18m0atvhWW128Hkt1xD57Kh4RyQaxh3Ab77JS4it7N1tZ
 nxrbno8k/FIiZKxspsRNC42ek/2fomXduoed+JNJ6XIpTTSUSvzIKUDhSbtsGltmv4EZ
 QUnZdlr+aZ2bu1HgB0WlW3ovXc59c60j+BW7IeM7UkfeSMEcBmqMP6N8wHRpfqp6qtvW
 0QT38pXobh6u4HQbY/W2pVMTyn4nJz0uYO7PQ2uX4RcY1h1FnJE1W5tMpSTLru2Pa/Ug
 CYKQ==
X-Gm-Message-State: AOJu0YwrBogIC53N7aamHOxc4kx+D+ZDzTc/sNrPSq8O2nawSGGopH6K
 GYxRIcNVYCnfU//T+8zFv/yzal5hIrnbIZO0QD5mZDa/Tk2VDV59KPmyae/fGIvhNfMLsVl41l+
 u
X-Google-Smtp-Source: AGHT+IEIqSVaNKFp5w8dtYnOHxqhbLRc8VBhICubnnCMiFLfxboTACU+tAXP+sxUDrj2JML0PDWjNw==
X-Received: by 2002:a17:906:a848:b0:a37:ca18:8b17 with SMTP id
 dx8-20020a170906a84800b00a37ca188b17mr1263019ejb.12.1707118825454; 
 Sun, 04 Feb 2024 23:40:25 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWwMTNTM7DCQp9Ae+HKyldonxQTPuHpqSTpKsc+Qbwuz9fiSOWs46pbgCPKCcz3xQpXPKc9suubQrF8L4sm3UNZ9KKrHQ9rg+R6RTtM+kI97l6e2RnVPefnbdPbg+Z9WhC0Fn9gAo5BkoAOxFBEAYxN6I0/izRSGtGDUh6S3ZhGi0SSn2HkdZstHokF29WuZ4CRHmIxfkbJH1UJ00T5A/b2wZzIj5kGY281y5cSsRGY67Q4IA==
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 y20-20020a17090629d400b00a36c499c935sm3996120eje.43.2024.02.04.23.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 23:40:24 -0800 (PST)
Date: Mon, 5 Feb 2024 10:40:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: belouargamohamed@gmail.com
Cc: u-boot@lists.denx.de, f.lahoudere@technologyandstrategy.com,
 eugen.hristev@microchip.com,
 BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Subject: Re: [PATCH] net: macb: Add support for fixed link
Message-ID: <5ff40e0f-2504-49a9-b929-9b0492dd4df7@moroto.mountain>
References: <20240203180652.239915-1-m.belouarga@technologyandstrategy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203180652.239915-1-m.belouarga@technologyandstrategy.com>
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

On Sat, Feb 03, 2024 at 07:06:52PM +0100, belouargamohamed@gmail.com wrote:
> @@ -1276,6 +1297,30 @@ int __weak macb_late_eth_of_to_plat(struct udevice *dev)
>  static int macb_eth_of_to_plat(struct udevice *dev)
>  {
>  	struct eth_pdata *pdata = dev_get_plat(dev);
> +	struct macb_device *macb = dev_get_priv(dev);
> +	void *blob = (void *)gd->fdt_blob;
> +	int node = dev_of_offset(dev);
> +	int fl_node, speed_fdt;
> +
> +	/* fetch 'fixed-link' property */
> +	fl_node = fdt_subnode_offset(blob, node, "fixed-link");
> +	if (fl_node != -FDT_ERR_NOTFOUND) {

Why not check for if (fl_node >= 0)?  The fdt_subnode_offset() function
can return a variety of error codes.

regards,
dan carpenter

> +		/* set phy_addr to invalid value for fixed link */
> +		macb->phy_addr = PHY_MAX_ADDR + 1;
> +		macb->duplex = fdtdec_get_bool(blob, fl_node, "full-duplex");
> +		speed_fdt = fdtdec_get_int(blob, fl_node, "speed", 0);
> +		if (speed_fdt == 100) {
> +			macb->speed = 1;
> +		}
> +		else if (speed_fdt == 10) {
> +			macb->speed = 0;
> +		}
> +		else {
> +			printf("%s: The given speed %d of ethernet in the DT is not supported\n",
> +					__func__, speed_fdt);
> +			return -EINVAL;
> +		}
> +	}
>  

