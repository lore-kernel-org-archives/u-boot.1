Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADD3C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 17:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 902CC87C24;
	Fri, 15 Dec 2023 18:25:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DKO6i7/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F82B87BCB; Fri, 15 Dec 2023 18:25:51 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2462587B28
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 18:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-77f3c84e0f6so65172285a.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 09:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702661148; x=1703265948; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fDcKv0gDXD56LvLtcnfxUXhhn6H8z343ODgflLto/jY=;
 b=DKO6i7/zpRzoboPK7aLj+tg1B8KMaYS8gOqfZc3TqHL3aKfIeASx8QnYDGXRmck5KG
 5uKn1MYREkD/67duVT7C3tq4+IERSv8KXd5kOP5MK1+pa18gWd9qF6uxA+WuCvoH/+UA
 UHGdXD3LaWYFxPO46O6cjo7ajNmx6vJBXLmkQWWRbCVofwMrz4s87M4oQTe1JFioJUgB
 rzQ4yBGZa6UdZC74Zkm2uskRkH6igiX1UcQ9mE/AaLMTXPfKNvuw43gsVHxjswxmYfRg
 GS3Nmy8vT452/znvZ00+6l1YPcusFob9fNdrV3FPdVqnXbZaNCMAQjSGXQbFUdTc7Ik9
 oZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702661148; x=1703265948;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fDcKv0gDXD56LvLtcnfxUXhhn6H8z343ODgflLto/jY=;
 b=rxFJ+6cegYxlXbIqXfzwwZYGe/tbZ6ScFu1GwczK+q05/6QMyveRTpCWyoIVqz03pI
 9puoPgXwl7Ad69P9SScV8SSJHdpwXhzrCfP1SgA1tk2pKptt5j90NWkQgLfzVe/sEs+5
 x12jKmMO3hTv14bioAkGWZaxJBXRGrj7A497c8jv+7KJoUKfUdYuThpSvp9vLWcFe5GZ
 gE/rf0a56JpWKmse0Gw9K1YQ0E0A5ZkdlRfp9j8VGisry6Wu5MsVtcbUYUxhec39CbIl
 vPYsfSNjAn5662ipNluzw8kcWGNKZnBWwVNzqcs+F5W+CRfNuqKZ3tLFlgHB8CSRJeZK
 75eQ==
X-Gm-Message-State: AOJu0Ywa+UomxWJs0b/78PZAjln+Fz7Iuu4SbMpVzkaQITXS162YUEz3
 2j/tDfXn0LB5irhAgAGtR6qoHNCXm/E=
X-Google-Smtp-Source: AGHT+IFF+cBnQayEgkzTJLI28snF179d8kF7el+dgj1bCOUrNbgUKuU+Ee517iQmXT0EANk5Psci+A==
X-Received: by 2002:a05:620a:1242:b0:77f:314e:b543 with SMTP id
 a2-20020a05620a124200b0077f314eb543mr11982703qkl.126.1702661147843; 
 Fri, 15 Dec 2023 09:25:47 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 re22-20020a05620a8e1600b0077891d2d12dsm6221925qkn.43.2023.12.15.09.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 09:25:47 -0800 (PST)
Message-ID: <af9d8670-a99b-5ad3-712b-49ccf31cdea0@gmail.com>
Date: Fri, 15 Dec 2023 12:25:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/1] clk: clk-gpio: add actual gated clock
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20231117075240.15741-1-clamor95@gmail.com>
 <20231117075240.15741-2-clamor95@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231117075240.15741-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/17/23 02:52, Svyatoslav Ryhel wrote:
> Existing gpio-gate-clock driver acts like a simple GPIO switch without any
> effect on gated clock. Add actual clock actions into enable/disable ops and
> implement get_rate op by passing gated clock if it is enabled.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/clk/clk-gpio.c | 47 +++++++++++++++++++++++++++++++++++-------
>   1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
> index 26d795b978..a55470cfbf 100644
> --- a/drivers/clk/clk-gpio.c
> +++ b/drivers/clk/clk-gpio.c
> @@ -3,19 +3,23 @@
>    * Copyright (C) 2023 Marek Vasut <marek.vasut+renesas@mailbox.org>
>    */
>   
> -#include <asm/gpio.h>
> -#include <common.h>
> -#include <clk-uclass.h>
> +#include <clk.h>
>   #include <dm.h>
> +#include <clk-uclass.h>
> +#include <linux/clk-provider.h>
> +
> +#include <asm/gpio.h>
>   
>   struct clk_gpio_priv {
>   	struct gpio_desc	enable;
> +	struct clk		*clk;

Please name this "parent".

>   };
>   
>   static int clk_gpio_enable(struct clk *clk)
>   {
>   	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
>   
> +	clk_prepare_enable(priv->clk);

Just clk_enable is fine. We don't have a separate prepare stage line Linux.

>   	dm_gpio_set_value(&priv->enable, 1);
>   
>   	return 0;
> @@ -26,21 +30,50 @@ static int clk_gpio_disable(struct clk *clk)
>   	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
>   
>   	dm_gpio_set_value(&priv->enable, 0);
> +	clk_disable_unprepare(priv->clk);
>   
>   	return 0;
>   }
>   
> +static ulong clk_gpio_get_rate(struct clk *clk)
> +{
> +	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
> +	int ret;
> +
> +	ret = dm_gpio_get_value(&priv->enable);
> +	if (ret)
> +		return clk_get_rate(priv->clk);
> +	else
> +		return -EINVAL;

This should always return the parent rate.

> +}
> +
>   const struct clk_ops clk_gpio_ops = {
>   	.enable		= clk_gpio_enable,
>   	.disable	= clk_gpio_disable,
> +	.get_rate	= clk_gpio_get_rate,
>   };
>   
> -static int clk_gpio_probe(struct udevice *dev)
> +static int clk_gpio_of_to_plat(struct udevice *dev)

This change should be a separate commit.

>   {
>   	struct clk_gpio_priv *priv = dev_get_priv(dev);
> +	int ret;
>   
> -	return gpio_request_by_name(dev, "enable-gpios", 0,
> -				    &priv->enable, GPIOD_IS_OUT);
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		log_err("%s: Could not get gated clock: %ld\n",
> +			__func__, PTR_ERR(priv->clk));
> +		return PTR_ERR(priv->clk);
> +	}
> +
> +	ret = gpio_request_by_name(dev, "enable-gpios", 0,
> +				   &priv->enable, GPIOD_IS_OUT);
> +	if (ret) {
> +		log_err("%s: Could not decode enable-gpios (%d)\n",
> +			__func__, ret);

Use dev_dbg for probe errors to reduce binary size.

> +		return ret;
> +	}
> +
> +	return 0;
>   }
>   
>   /*
> @@ -59,7 +92,7 @@ U_BOOT_DRIVER(gpio_gate_clock) = {
>   	.name		= "gpio_clock",
>   	.id		= UCLASS_CLK,
>   	.of_match	= clk_gpio_match,
> -	.probe		= clk_gpio_probe,
> +	.of_to_plat	= clk_gpio_of_to_plat,
>   	.priv_auto	= sizeof(struct clk_gpio_priv),
>   	.ops		= &clk_gpio_ops,
>   	.flags		= DM_FLAG_PRE_RELOC,

--Sean
