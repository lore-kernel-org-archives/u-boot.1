Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF46D3ABFB
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11EBF8942A;
	Tue, 12 Nov 2024 14:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hAZM8zSI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4765389430; Tue, 12 Nov 2024 14:27:47 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 344E589417
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso44741685e9.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731418065; x=1732022865; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ki5QwggvsLlzX9AG4wynIMuKH0WG9AN06b4Jzav92QQ=;
 b=hAZM8zSI2a+UAy0O0MZYPMF9piendGsjPhfxQ/hHWS674PX9KMdU/LJCU6V8J4Ydbz
 EL/A3uugHKpNWjfDvoXBLNY4+RRRroU9wGJB3hcW0QearzfhhHN3G5VM8n+F+zEj/PLn
 bovf5MLzJIbVqwY5IlK+tqBWI3O0gm4Iy+jDVlMyV7lNXBq+CnCQQFwBPW74nJay6B8p
 WQ3Vq5DWshC1yiHU87K7YqN18hERiWRKrNXjYThHktmcn8+ZlB1m0S0kPZeD8rE7UKtZ
 xs7vIQF4laNcshD2Grf6wJ+1aaSbXXf8trVIdZlCTIIBtVM1CIkrgsIghKyhnBHrDkR/
 wi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731418065; x=1732022865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ki5QwggvsLlzX9AG4wynIMuKH0WG9AN06b4Jzav92QQ=;
 b=a6Z8fIZxFcALH++c4ZPquCZ190y0c/KTbiKSPhWadJpe2th6kt4oK4uww2m7D/GpwU
 UEigqLn3HaDBi8vA5P4hJajkHR/HwGV+9p1GMqpouySzNEqbyd7heD9tOH3RwX94b9uK
 fmSlBBwlkq9Q7Y+qp8ZuYCCOCbAfadoBi7yQIKRMDGu5fi5GDIgdx4yXmGUYez6NMFze
 SGdPIpQqODFS8aazREFmEcKyDy4sVXWAGYrB2NyxIaZlOJROaxWOb5+yjlDYpQw39U3l
 gXYBfo4gsEgyVJYjo7qKSNl7iIwAOyPrZnVY3Bl1ZfIxBEWEEPEtotBWctSrtoAgKKH0
 ShUg==
X-Gm-Message-State: AOJu0YxoRWeAXzz04Va2l0czXE4POdbDlxweG3cR47lS8sdbW64or869
 oqssk14sjPTksT7xQItg5Xa3zQ/iAxahPSR4PPF07sbJxX+D/FINTXFinzwVbUY6AC1Inp51o8l
 g
X-Google-Smtp-Source: AGHT+IHWifDMgatnowmHLvxwDl8hAQEf0zqpAvKK0gHNmuDpd14ESW44WtvGrz2ZFn8E0Y6RPhfY4A==
X-Received: by 2002:a05:600c:4507:b0:431:5c1c:71b6 with SMTP id
 5b1f17b1804b1-432b750a433mr154372595e9.17.1731418064686; 
 Tue, 12 Nov 2024 05:27:44 -0800 (PST)
Received: from [192.168.0.187] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b35b3sm238280015e9.18.2024.11.12.05.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 05:27:44 -0800 (PST)
Message-ID: <f4b1431e-7782-42f5-b480-727eb08e909e@linaro.org>
Date: Tue, 12 Nov 2024 15:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] gpio: at91: Implement ops get_flags
To: Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20241018215751.322145-1-admin@hifiphile.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20241018215751.322145-1-admin@hifiphile.com>
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



On 10/19/24 00:57, Zixun LI wrote:
> Add ops get_dir_flags() to read status from GPIO registers.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> 
> ---
> Changes in v2:
> - Fix pullup read polarity
> ---
>  drivers/gpio/at91_gpio.c | 45 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/gpio/at91_gpio.c b/drivers/gpio/at91_gpio.c
> index 7828f9b447..c44e02cd90 100644
> --- a/drivers/gpio/at91_gpio.c
> +++ b/drivers/gpio/at91_gpio.c
> @@ -240,6 +240,24 @@ static void at91_set_port_multi_drive(struct at91_port *at91_port, int offset, i
>  	else
>  		writel(mask, &at91_port->mddr);
>  }
> +
> +static bool at91_get_port_multi_drive(struct at91_port *at91_port, int offset)
> +{
> +	u32 mask, val;
> +
> +	mask = 1 << offset;
> +	val = readl(&at91_port->mdsr);
> +	return val & mask;

Use clamp (!!) to turn this into a bool.

> +}
> +
> +static bool at91_get_port_pullup(struct at91_port *at91_port, int offset)
> +{
> +	u32 mask, val;
> +
> +	mask = 1 << offset;
> +	val = readl(&at91_port->pusr);
> +	return !(val & mask);
> +}
>  #endif
>  
>  static void at91_set_port_input(struct at91_port *at91_port, int offset,
> @@ -608,6 +626,32 @@ static int at91_gpio_set_flags(struct udevice *dev, unsigned int offset,
>  	return 0;
>  }
>  
> +static int at91_gpio_get_flags(struct udevice *dev, unsigned int offset,
> +				ulong *flagsp)
> +{
> +	struct at91_port_priv *port = dev_get_priv(dev);
> +	ulong dir_flags = 0;
> +
> +	if (at91_get_port_output(port->regs, offset)) {
> +		dir_flags |= GPIOD_IS_OUT;
> +
> +		if (at91_get_port_multi_drive(port->regs, offset))
> +			dir_flags |= GPIOD_OPEN_DRAIN;
> +
> +		if (at91_get_port_value(port->regs, offset))
> +			dir_flags |= GPIOD_IS_OUT_ACTIVE;
> +	} else {
> +		dir_flags |= GPIOD_IS_IN;
> +	}
> +
> +	if (at91_get_port_pullup(port->regs, offset))
> +		dir_flags |= GPIOD_PULL_UP;
> +
> +	*flagsp = dir_flags;
> +
> +	return 0;
> +}
> +
>  static const char *at91_get_bank_name(uint32_t base_addr)
>  {
>  	switch (base_addr) {
> @@ -637,6 +681,7 @@ static const struct dm_gpio_ops gpio_at91_ops = {
>  	.set_value		= at91_gpio_set_value,
>  	.get_function		= at91_gpio_get_function,
>  	.set_flags		= at91_gpio_set_flags,
> +	.get_flags		= at91_gpio_get_flags,
>  };
>  
>  static int at91_gpio_probe(struct udevice *dev)

