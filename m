Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADB9C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A64158752B;
	Tue, 19 Dec 2023 17:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nwqXfEEu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DB12871B4; Tue, 19 Dec 2023 17:47:18 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50641876E9
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40c31f18274so60458745e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703004432; x=1703609232; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LJ1dbJBqJPfhT3kCSj94Zw04NbqXp5mrseCBda5B9O4=;
 b=nwqXfEEuOcXnvTOozMURYpQng3oxXRdp7msU1uJ3GzpJujT48TPEAiUiVdazCNSiDa
 DPsfhT/EA9cwhahbppfFIx9Od7meTuVPRD2Cp2MDyhOWjKq2eGWQ0rSz54oytGfj33hb
 /rWFk/bD9TAP8s5r4S6ZH6/SsZTwqxFK78DV5QhKbi+b8Ynbf+FRU7ewUjmWEG5qYD8W
 wYGfg/bwoIZNPZAUxww1b/l3Qmx7b8oQZHhDhIAGmoVtQOgoTNqx4efIMOJ8VOzpJVzL
 scgQ+3IOoX4NvFyxo7+3yJr+OZdUWLCxJUvvIFFVwO+kYLXXmAO72F3BbxoRfYnJMYCB
 M27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703004432; x=1703609232;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LJ1dbJBqJPfhT3kCSj94Zw04NbqXp5mrseCBda5B9O4=;
 b=fXP9K/Z1+A3BOd/lcUd9g0EmZXDkz7k+vd04UTzoqJIVLEqjo6myuFV6thJeWtTEFR
 MnS3rLAOrgySYJ4SRdtESQYkT2kA1NOFKPF3JpQmXp+PPcRstOdP1g5lH/GbfHSIUQty
 QYWv1+zrtvRRdXHE8cwK9kMkqP3AZjyA918H0pzUIBt25OHuv7XBNa7Z58nZwX22sQqc
 SyAgqVVCWW66+I5LeFQUuC1ua9nNI9itRY1QZW/Pq2QkqYP4OdBD71vMzSJsnzDaHSpJ
 wAVYLFKa5ceqk9FhfzewQefakr0XveoL8bwYXckwMGTWFJGm9gGvFffxITuDnqAw8nrt
 HWqw==
X-Gm-Message-State: AOJu0YyNKDkh9aq3Ju8YXHTrpN74mHnm0m1W5zxPy8mERffFt3N7z8Ig
 0yRRoJM7ohq2EfEcuBezrnBGgA==
X-Google-Smtp-Source: AGHT+IHFXtiLXU3fYlzHfd3l+w9mCcSk9DE9jwKFBlPnVuydIV7w57gX1wU2fqbF4+CgeqOo6VaS9A==
X-Received: by 2002:a05:600c:474a:b0:40c:6ae0:8cf3 with SMTP id
 w10-20020a05600c474a00b0040c6ae08cf3mr3574698wmo.153.1703004431733; 
 Tue, 19 Dec 2023 08:47:11 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 m12-20020adffe4c000000b003366827c9c6sm5933776wrs.2.2023.12.19.08.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 08:47:11 -0800 (PST)
Message-ID: <3310b183-c0f5-48e9-b92c-5c98508b2b90@linaro.org>
Date: Tue, 19 Dec 2023 16:47:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] serial_msm: Add support for RS232 GPIOs
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, lukma@denx.de, seanga2@gmail.com,
 marex@denx.de, laetitia.mariottini@se.com, pascal.eberhard@se.com,
 abdou.saker@se.com, jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
 <20231218072428.1802969-3-sumit.garg@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231218072428.1802969-3-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

I guess these GPIOs are RTS/CTS? Missing description...

Given that you just set them to their respective values, you should be
able to configure these using pinctrl with this patch [1], so we can
avoid adding these non-standard bindings.

I tested your next patch, setting "MSM_UART_MR1_RX_RDY_CTL" in
uart_dm_init() on db410c and db820c and I don't notice any issues with
setting that bit unconditionally. If it's definitely needed for your
board then I'd be ok with a patch to always set it with a comment
offering some context.

[1]:
https://lore.kernel.org/u-boot/20231219-b4-qcom-common-target-v2-10-b6dd9704219e@linaro.org/

On 18/12/2023 07:24, Sumit Garg wrote:
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/serial/serial_msm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index a22623c316e..43e58595dc2 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -16,6 +16,7 @@
>  #include <serial.h>
>  #include <watchdog.h>
>  #include <asm/global_data.h>
> +#include <asm/gpio.h>
>  #include <asm/io.h>
>  #include <linux/compiler.h>
>  #include <linux/delay.h>
> @@ -210,6 +211,7 @@ static int msm_serial_probe(struct udevice *dev)
>  {
>  	int ret;
>  	struct msm_serial_data *priv = dev_get_priv(dev);
> +	struct gpio_desc rs232_0, rs232_1;
>  
>  	/* No need to reinitialize the UART after relocation */
>  	if (gd->flags & GD_FLG_RELOC)
> @@ -219,6 +221,11 @@ static int msm_serial_probe(struct udevice *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (!gpio_request_by_name(dev, "gpios", 0, &rs232_0, GPIOD_IS_OUT))
> +		dm_gpio_set_value(&rs232_0, 1);
> +	if (!gpio_request_by_name(dev, "gpios", 1, &rs232_1, GPIOD_IS_OUT))
> +		dm_gpio_set_value(&rs232_1, 0);
> +
>  	pinctrl_select_state(dev, "uart");
>  	uart_dm_init(priv);
>  

-- 
// Caleb (they/them)
