Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D3CD3ABFB
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D368893C2;
	Tue, 12 Nov 2024 14:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gfOTYuuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC3F8942A; Tue, 12 Nov 2024 14:21:45 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6ABA891E4
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso49250885e9.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731417703; x=1732022503; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OMWKdgCmzgZMNiJC3k0P0gXO68y17nm3Qm5rACoxtAQ=;
 b=gfOTYuuF9efqnYhWRL54I9iUOc7tmqav9kiRrHtmrd9KrmdyLF/eFNEsJXI2pm2y5j
 RlmcRgCQsx1G7Nz9vKXgJyyfCUlkjVOjKPBTyniYP2yFzP9tbCqID7GsxynMUm4KFHFB
 yZZ9glxgCxJZNDfkcJidvqeKkWs/h18oAZdJd0bwB3JUahhDiU1Yr2HqUlx5yUQVsH0b
 7AwUT/r9jRvfxCmFKcjhzp27XuS6jKcq14A+LXIqH+WHm6kIhNA76IGg/uYLquBzPGLj
 Pl31rsqdHNlvE1ksfoEopSrCNG00mHH88O0uLRMxbF7cFECCHPvJBlUs9q8VW7yCUbBV
 Armw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731417703; x=1732022503;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OMWKdgCmzgZMNiJC3k0P0gXO68y17nm3Qm5rACoxtAQ=;
 b=nRj4/gs/WCR/y/2M+BBKLnVc5m0ebe9KdTdTRBMsNltvWO5Sahb8CNpXtvGtkaJ2rx
 8SPHDSYXKBnGxsec/YS99agZzbdGUoQv5s7sQZ7fuy7pj2haJh31CbT14zvDbCTReKJe
 gH+GN+G0ewWCKjduTKwLwcBzbKL4FRBLX1m6HMwoiTtQUYowqYhCyEe5p5mRsnyYY7Sp
 bLVbSPsq814ekziXLlaLkMtK6dSFDfS2o78m9pmVJ3+jDYJY9RkLhMRxW5TNpYUTW+rb
 erXshHHhmuaP06Kt5KlSs/oVTcxIj9bgTQJu1d/0/O3lhxUIWLxsdEYcxkBC46Rn9CQj
 ONGQ==
X-Gm-Message-State: AOJu0Yyi3AM6kNVBIX8UKRX+hKbsgNv3hkjR58bYTHytnOtwMcC9fhQh
 r/2Opu5JbWaA7QK6z1u4Uj3Sk62td/fLnaroEY1EYMtEn5UxGoUPs2LjNG2KpRk=
X-Google-Smtp-Source: AGHT+IH2SEENgJuJHzPpqEzo0S1U4p9ktk3oIMz2sZj749XEVjZ3fRUt/sd4zui5xNMc84MnfLvV+w==
X-Received: by 2002:a05:600c:1391:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-432b7506634mr141020105e9.16.1731417703271; 
 Tue, 12 Nov 2024 05:21:43 -0800 (PST)
Received: from [192.168.0.187] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05e5f82sm214105215e9.42.2024.11.12.05.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 05:21:43 -0800 (PST)
Message-ID: <100db945-f3cd-426e-860d-98c01cc6bb41@linaro.org>
Date: Tue, 12 Nov 2024 15:21:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] gpio: at91: Implement ops set_flags
To: Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20241018202715.283011-1-admin@hifiphile.com>
 <20241018202715.283011-2-admin@hifiphile.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20241018202715.283011-2-admin@hifiphile.com>
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

Hello,

On 10/18/24 23:27, Zixun LI wrote:
> Support GPIO configuration with following flags:
> - in, out, out_active
> - open_drain, pull_up
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  drivers/gpio/at91_gpio.c | 41 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/gpio/at91_gpio.c b/drivers/gpio/at91_gpio.c
> index 64a6e8a4a5..7828f9b447 100644
> --- a/drivers/gpio/at91_gpio.c
> +++ b/drivers/gpio/at91_gpio.c
> @@ -229,6 +229,17 @@ static bool at91_get_port_pio(struct at91_port *at91_port, int offset)
>  	val = readl(&at91_port->psr);
>  	return val & mask;
>  }
> +
> +static void at91_set_port_multi_drive(struct at91_port *at91_port, int offset, int is_on)
> +{
> +	u32 mask;
> +
> +	mask = 1 << offset;
> +	if (is_on)
> +		writel(mask, &at91_port->mder);
> +	else
> +		writel(mask, &at91_port->mddr);
> +}
>  #endif
>  
>  static void at91_set_port_input(struct at91_port *at91_port, int offset,
> @@ -568,6 +579,35 @@ static int at91_gpio_get_function(struct udevice *dev, unsigned offset)
>  		return GPIOF_INPUT;
>  }
>  
> +static int at91_gpio_set_flags(struct udevice *dev, unsigned int offset,
> +				ulong flags)
> +{
> +	struct at91_port_priv *port = dev_get_priv(dev);
> +	ulong supported_mask;
> +
> +	supported_mask = GPIOD_OPEN_DRAIN | GPIOD_MASK_DIR | GPIOD_PULL_UP;
> +	if (flags & ~supported_mask)
> +		return -EINVAL;

Does this change the current behavior? there is no set_flag ops
implemented, previously it would use a default that would just return
success regardless of the given flags parameters ?
Btw maybe ENOTSUPP ?

> +
> +	if (flags & GPIOD_IS_OUT) {
> +		bool value = flags & GPIOD_IS_OUT_ACTIVE;

Can you please declare this value at the start of the function, or
inline it below when it's being used

> +
> +		if (flags & GPIOD_OPEN_DRAIN)
> +			at91_set_port_multi_drive(port->regs, offset, true);
> +		else
> +			at91_set_port_multi_drive(port->regs, offset, false);
> +
> +		at91_set_port_output(port->regs, offset, value);
> +
> +	} else if (flags & GPIOD_IS_IN) {
> +		at91_set_port_input(port->regs, offset, false);
> +	}
> +	if (flags & GPIOD_PULL_UP)
> +		at91_set_port_pullup(port->regs, offset, true);
> +
> +	return 0;
> +}
> +
>  static const char *at91_get_bank_name(uint32_t base_addr)
>  {
>  	switch (base_addr) {
> @@ -596,6 +636,7 @@ static const struct dm_gpio_ops gpio_at91_ops = {
>  	.get_value		= at91_gpio_get_value,
>  	.set_value		= at91_gpio_set_value,
>  	.get_function		= at91_gpio_get_function,
> +	.set_flags		= at91_gpio_set_flags,
>  };
>  
>  static int at91_gpio_probe(struct udevice *dev)

