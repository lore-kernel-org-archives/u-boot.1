Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED7DC47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 03:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12BB987BDF;
	Tue, 30 Jan 2024 04:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EdzQj7Id";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD16E875EB; Tue, 30 Jan 2024 04:31:45 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C3C87BDF
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 04:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-42a9f0f1d40so13233741cf.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 19:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706585502; x=1707190302; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IdcFI6JU6sV3iXcy9SQdD6vCzbjo6IdZpfj26Hy3rkE=;
 b=EdzQj7IdF8hXCxe4CJUxsvXkj78NyxLGaK/PWNHlZkW/IejtwIwZNRLk2buEXabwWu
 LnfjR9m6W++Kv6pxGIPuUj6Q/sTtl2XXh/7WGI6MEck43qIQwqg533EtnS1IHPckfQT7
 tN69D91qK14uhtrkI1ReH/iCBEHgiCuKNvQx1wLO3Z9bAni2Wa07agNAe5hCrI4JHFHE
 GPxw1HYNbTcjCQgLJdtl7IQvrHpfvHPv17pkUmfAXNhc5XjeN0jy8Pe023WllX4ZL/zT
 /WV+olXPRwBC+n8nhLgNocj/qqMNQy8gaLUPT4v51urQqoAJmKkkD2T1LyIa89VniUKa
 GfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706585502; x=1707190302;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IdcFI6JU6sV3iXcy9SQdD6vCzbjo6IdZpfj26Hy3rkE=;
 b=ZvuNGz2W19GJclgw6wgQELPegn57rP3lGdtwx6dBxbzGgvSN65UY3gKLBFPfYlAvAn
 SkDWXDc0hAXziVOqbCTZ2ESrRUg591XlSqd6ihELy+TfdsoJfIW+R9fOAB08en1AalDF
 kpLeRfckT8JzR6k4unH175V/U5b+Xry9vIQgRCD0Rlb5NpGehzEUWvsgd/O4jI53oLuo
 ziKBUCmXdeOhpOL/QV6mkfu7D9boL8UNKQBSiRFZhMPTMwjQZAugNF2BDy2s4UvHqFKV
 Zv0QNwOij8cn3UD5/1/sHYWg1cNDkZU5tZ8OUnyWhDJCwj5NiH6umZzQ/XPzPt6CS9QB
 XgTQ==
X-Gm-Message-State: AOJu0YwlHWxgyUCmxGq1EHUR0KMM3nNupAt0mGXj9TpEEBhl9treWrsM
 y/o+8JdZkjYSEC0m1zvz7bABKM6j4eokKXTIy63OWoEnf80x8SRa
X-Google-Smtp-Source: AGHT+IEEL3ScrDaHA0HqbSPN66TKjdmiy4so+KKe7Mx/xAJWkc1qi2DXi2gIhwvkTSBGSWQRJvhQ5A==
X-Received: by 2002:a05:622a:94:b0:42a:a824:77de with SMTP id
 o20-20020a05622a009400b0042aa82477demr2521374qtw.4.1706585502235; 
 Mon, 29 Jan 2024 19:31:42 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 cr7-20020a05622a428700b0042a31bc98b9sm4145091qtb.24.2024.01.29.19.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 19:31:41 -0800 (PST)
Message-ID: <02448429-5554-6aa0-3d4b-a8ea04192c01@gmail.com>
Date: Mon, 29 Jan 2024 22:31:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/1] clk: clk-gpio: add actual gated clock
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
References: <20240110160956.4476-1-clamor95@gmail.com>
 <20240110160956.4476-2-clamor95@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240110160956.4476-2-clamor95@gmail.com>
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

On 1/10/24 11:09, Svyatoslav Ryhel wrote:
> Existing gpio-gate-clock driver acts like a simple GPIO switch without any
> effect on gated clock. Add actual clock actions into enable/disable ops and
> implement get_rate op by passing gated clock if it is enabled.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/clk/clk-gpio.c | 40 ++++++++++++++++++++++++++++++++++------
>   1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
> index 26d795b978..d2dd8070fa 100644
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

this is out of order, but I will fix it when applying

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
>   static int clk_gpio_probe(struct udevice *dev)
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

Reviewed-by: Sean Anderson <seanga2@gmail.com>
