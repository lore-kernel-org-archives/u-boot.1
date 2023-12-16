Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCDEC46CCD
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 15:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 550BE876D9;
	Sat, 16 Dec 2023 16:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KbAI1ft0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 874D9876DC; Sat, 16 Dec 2023 16:37:16 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71217876D7
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 16:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-42588e94019so21685691cf.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 07:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702741033; x=1703345833; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z2+8KRsXDVuM2xEoqWJPj7RASMpUO6KuYGXqt5Su3+E=;
 b=KbAI1ft0wwwTrg/43Kfkc6QqCpvEs8YY0M93W1mKxoxe/DVqapUg+VcHerOIL/FuMm
 iyhokDJ99WxsrswYso7DXC0/vcaVHB3ekV0C1AbdXLJC+XxVE+JomoERb6KQ95M++QSV
 skoJopMV9ixVL6A3iAbjNnsXfFKY5Wqa4uQU0pIrUVBi5bRKp4ao0fi7ou4HhzNtwEVJ
 H3KRjDutKpdpiXH2k9IYUDNminf3E2GX/Z98nuI7RfYqJpzl4fk0PPyPMDcesa8KRwl/
 OgqeU8jfP8fntNLxRGu8KkJcic4aSkY+XjuezuWZi10ymX9NbwxO58IMnUTGCiNm4VCX
 pMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702741033; x=1703345833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z2+8KRsXDVuM2xEoqWJPj7RASMpUO6KuYGXqt5Su3+E=;
 b=e75CyeMRHEYX7i79Wz7YgiAN23bLOucnQun7/1FyLNe4OJx04uzZWMqhcpdH0zKmwp
 xx5m7Iu0GSFYwdGI+wMZhqu5IWDu5WQrSGV6undO7o3E4K0cIV8WNRkVeV9v7l9n0kAA
 JPwHtFTDTd25SMtrtTdBuzLjOM6aQ6Ow6kKDsj/PMNjU6IvbqU4gkLMM55MpxVBztgJa
 QjvHyg0jUsIU3ErXZ9sgw0O31q6A1J8RQye0RKh8vPJEP56kSS/rT8yVH01NHFEWfhP/
 1I4M8UnRT2REOM25Y5yBGtBOR1xfsvCnJ5ZY07ZpPlqya5iIQyrUjDl+2NXScmalkQcj
 7PnQ==
X-Gm-Message-State: AOJu0YxBMgVrGqDOTRzxDIHtf7BTS2z4UtGKqy3+FnjvC31VqaerSIV7
 TCZPa/4yT8SWuTq/5DPgprM=
X-Google-Smtp-Source: AGHT+IH8nNC3gRp0gTmdUL5Pvakj0icGWxizC0ot7C+GPs9Wms446KuNxZJsnyZgStutRJIHYEetfw==
X-Received: by 2002:a05:622a:1828:b0:418:11c9:ddb5 with SMTP id
 t40-20020a05622a182800b0041811c9ddb5mr20248718qtc.25.1702741033200; 
 Sat, 16 Dec 2023 07:37:13 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 v17-20020ac873d1000000b0042561f6a902sm7557710qtp.91.2023.12.16.07.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 07:37:12 -0800 (PST)
Message-ID: <e53a31db-aea2-fe0e-daf6-f1338c59b2a8@gmail.com>
Date: Sat, 16 Dec 2023 10:37:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] clk: clk-gpio: add actual gated clock
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>
References: <20231216084838.19403-1-clamor95@gmail.com>
 <20231216084838.19403-2-clamor95@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231216084838.19403-2-clamor95@gmail.com>
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

On 12/16/23 03:48, Svyatoslav Ryhel wrote:
> Existing gpio-gate-clock driver acts like a simple GPIO switch without any
> effect on gated clock. Add actual clock actions into enable/disable ops and
> implement get_rate op by passing gated clock if it is enabled.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/clk/clk-gpio.c | 44 ++++++++++++++++++++++++++++++++++--------
>   1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
> index 26d795b978..72d9747a47 100644
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
> -	struct gpio_desc	enable;
> +	struct gpio_desc	enable;	/* GPIO, controlling the gate */
> +	struct clk		*clk;	/* Gated clock */
>   };
>   
>   static int clk_gpio_enable(struct clk *clk)
>   {
>   	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
>   
> +	clk_enable(priv->clk);
>   	dm_gpio_set_value(&priv->enable, 1);
>   
>   	return 0;
> @@ -26,21 +30,45 @@ static int clk_gpio_disable(struct clk *clk)
>   	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
>   
>   	dm_gpio_set_value(&priv->enable, 0);
> +	clk_disable(priv->clk);
>   
>   	return 0;
>   }
>   
> +static ulong clk_gpio_get_rate(struct clk *clk)
> +{
> +	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
> +
> +	return clk_get_rate(priv->clk);
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
>   {
>   	struct clk_gpio_priv *priv = dev_get_priv(dev);
> +	int ret;
>   
> -	return gpio_request_by_name(dev, "enable-gpios", 0,
> -				    &priv->enable, GPIOD_IS_OUT);
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		log_debug("%s: Could not get gated clock: %ld\n",
> +			  __func__, PTR_ERR(priv->clk));
> +		return PTR_ERR(priv->clk);
> +	}
> +
> +	ret = gpio_request_by_name(dev, "enable-gpios", 0,
> +				   &priv->enable, GPIOD_IS_OUT);
> +	if (ret) {
> +		log_debug("%s: Could not decode enable-gpios (%d)\n",
> +			  __func__, ret);
> +		return ret;
> +	}
> +
> +	return 0;
>   }
>   
>   /*
> @@ -59,7 +87,7 @@ U_BOOT_DRIVER(gpio_gate_clock) = {
>   	.name		= "gpio_clock",
>   	.id		= UCLASS_CLK,
>   	.of_match	= clk_gpio_match,
> -	.probe		= clk_gpio_probe,
> +	.of_to_plat	= clk_gpio_of_to_plat,
>   	.priv_auto	= sizeof(struct clk_gpio_priv),
>   	.ops		= &clk_gpio_ops,
>   	.flags		= DM_FLAG_PRE_RELOC,

+CC Marek
