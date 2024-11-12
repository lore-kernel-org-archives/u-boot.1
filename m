Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67ECD3ABFB
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E796D89383;
	Tue, 12 Nov 2024 14:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FZ04ivQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB2E6893C3; Tue, 12 Nov 2024 14:13:29 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B59518910B
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso48128405e9.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731417207; x=1732022007; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LV2nbfrBdzsTy47x5jlXo58EgXtIn+YrL696ZrBSKBA=;
 b=FZ04ivQ7SyLbR3KchwwSXZ3vcjVo94Y1DSmf0rRcV4xdHSLEiMqg9D7+rJ9xUyPyFL
 dY/+3oS/QQRDKYfjbkrJ7DObDO1uGXOCI4gs5sA/blwsSW2/qKKpJYfq41glexT3YCXL
 VoRawiAoWM0+5Nh1vX8v8TRJsG9xR4ph38Y6LIUoqm4MxBzx0F+Dd5Ubs3o/YvTjNExW
 UlDBbcGn8iQEgxzVACTMNJPCH2FmQgxpQXeB+7jR0DEROD3WQ2x1iJb10YZykWEBVPPT
 qhdAEqwx4hCbKeQVcWklEV66V+UbeBVBh7KympPOiArn8UknYWlooHC8/N79yIADZbz8
 0qTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731417207; x=1732022007;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LV2nbfrBdzsTy47x5jlXo58EgXtIn+YrL696ZrBSKBA=;
 b=Rg6CQnGW581qe+opREvULEJ2cklf4qCNF7wIHK2wmNCgZqQxDnHrEszqdUw/IUpoAn
 RL1H/5TEEUb235VpBKa4XSQRwuISeOckd8TLlW48At4nDzUrwFjyIyIkDr6RgJyJB9q9
 cMieUG9DAuEqhPQDqbG+FTeMGm1O4PWsbULg4MpSSkmCPrBMIaelo5n+ezUVp+jS6VR+
 sinIzCe+TmaUR+frxaC1qJWCO3uvV7ICMQdErRjsw+W7WBCuf5DcGZWwqV8QsyD7b0xX
 jFVIFmEjOK2VzaSh9W6V6JVt5gxL9axS1AdhKpbCG93drgWxKATZ+jPDBhpmgzgY8xJE
 y57Q==
X-Gm-Message-State: AOJu0YxWMV7ib2pr2snTuta4u1ZxRJR0PGHKHOZg1fIRgklSlwpRl6T2
 LOkOPlFDMpa7yyWTbVsFAvRZ8Kk0UMZoxVypyXjPl8EqL/sHOOLnWhmpW0XwIwj8fXeZO+4/yf5
 D
X-Google-Smtp-Source: AGHT+IEawtOQF7DkNDVcT8+TagoeahXrXx1vzUNG757pC4TlwpnOZTNPvU9gD/eLZKkRFzws6xfDDA==
X-Received: by 2002:a05:600c:4ecf:b0:430:563a:b20a with SMTP id
 5b1f17b1804b1-432b7505786mr131928535e9.11.1731417207111; 
 Tue, 12 Nov 2024 05:13:27 -0800 (PST)
Received: from [192.168.0.187] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05319aesm206542815e9.8.2024.11.12.05.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 05:13:26 -0800 (PST)
Message-ID: <2637a7bd-fdc6-4102-80c1-43d0d058cd97@linaro.org>
Date: Tue, 12 Nov 2024 15:13:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gpio: at91: Implement GPIOF_FUNC in get_function()
To: Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20241018202715.283011-1-admin@hifiphile.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20241018202715.283011-1-admin@hifiphile.com>
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
> This patch adds support for determining whether a gpio pin is mapped as
> peripheral function.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  drivers/gpio/at91_gpio.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/at91_gpio.c b/drivers/gpio/at91_gpio.c
> index 1409db5dc1..64a6e8a4a5 100644
> --- a/drivers/gpio/at91_gpio.c
> +++ b/drivers/gpio/at91_gpio.c
> @@ -220,6 +220,15 @@ static bool at91_get_port_output(struct at91_port *at91_port, int offset)
>  	val = readl(&at91_port->osr);
>  	return val & mask;
>  }
> +
> +static bool at91_get_port_pio(struct at91_port *at91_port, int offset)

The name get_port_pio is a bit confusing, can you rename it to something
more meaningful, like maybe is_periph_func or something ?

> +{
> +	u32 mask, val;
> +
> +	mask = 1 << offset;
> +	val = readl(&at91_port->psr);
> +	return val & mask;
> +}
>  #endif
>  
>  static void at91_set_port_input(struct at91_port *at91_port, int offset,
> @@ -550,7 +559,9 @@ static int at91_gpio_get_function(struct udevice *dev, unsigned offset)
>  {
>  	struct at91_port_priv *port = dev_get_priv(dev);
>  
> -	/* GPIOF_FUNC is not implemented yet */
> +	if (!at91_get_port_pio(port->regs, offset))
> +		return GPIOF_FUNC;
> +
>  	if (at91_get_port_output(port->regs, offset))
>  		return GPIOF_OUTPUT;
>  	else

