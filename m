Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD29D44176
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 15:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2926894C5;
	Tue, 19 Nov 2024 16:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aYCYk6hA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C725289417; Tue, 19 Nov 2024 16:44:58 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABB10894C5
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 16:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3824aef833bso1447715f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 07:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732031096; x=1732635896; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7QhwnByMhViwRFR+kyntf3tTPp6KXgqlnn2wsgVvkJA=;
 b=aYCYk6hAV5AYwP796bHQMiuwYUQ7Lm0M4yz0qsiUOMdcxlGB5UQIQQB5ACuZpV6Pta
 J4TbCIaz9XFq+d+MjpwzKL0+enGTSOdPMHBSF+XX+jMYBb0cDKBPpblnseuaMFU8ce1j
 BJvyl/lk/KEtQ2Q7ozZ+BQzj8V/sumb00iqa1a90dDtQUsWto9b1bHT46aI49dv2Wjrg
 Zn/4b7Y2ZxdY/oaadaQmEhJKrvv1YLGMlasDWnDWCOYi0+Bkz9hhVcZkOeUal3USNyJn
 U/PiTJBTGA4YVKUUa9zFjkb8Ks6zu16BO3YCVMdvNJ7XpX4SZnFY6XUw6T6nmK9eNAWG
 NBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732031096; x=1732635896;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7QhwnByMhViwRFR+kyntf3tTPp6KXgqlnn2wsgVvkJA=;
 b=POVS7UnRfWjqKwegRNY/ZMvjCB/MmowPiW4sT8zjZOb4p69+TkXznrgYD0Tz5eFY7a
 fnxs3o0bJR8bBEfiFpCSJ3YJTcePV0AKTCNJaY520i7Uhcz1D69GRN9VnnHJBoCX9ZvA
 M+JKv6f9q/pSG7bLFMUBtatsxY2hL9zJKBoro9/DXBMPJ5RKuHQq15W46MVKJKI4bXH3
 n5qoRYrgvU0P6vj81xmafZQXI0mjJ4aksjide/upmjVAfDj+iHzW/oI3WRhZfmmzj8A2
 gOYiynQLY0hiy9XkQy4Vkwe9MUH1iJI8Q0urm3jG94gZeP+f0VLmFm6T9Fm94azZyyON
 vuEg==
X-Gm-Message-State: AOJu0YzAJYDvF2H4l7OJTxjp81g2TeqIqz/zmqQMPrgfgfarPaai3Wyh
 ukZUmD7q/DWRmplyStL8W2XWBNq5OfoPKDcvsF2x2n5JXidkGjcaspSBPDt8oEs=
X-Google-Smtp-Source: AGHT+IHlXZu13cG4WuTgADFXM59849zPxzrrdhJiKVAozvNJs+FxzBf+8wBy3M9l6cXOg1oishmUzA==
X-Received: by 2002:a5d:6c6a:0:b0:382:49bb:a5c8 with SMTP id
 ffacd0b85a97d-38249bba9c6mr4946523f8f.32.1732031096102; 
 Tue, 19 Nov 2024 07:44:56 -0800 (PST)
Received: from [192.168.0.71] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da244c69sm204848025e9.2.2024.11.19.07.44.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 07:44:55 -0800 (PST)
Message-ID: <6b6aa851-9874-4d6a-877f-f886ed5c1c9e@linaro.org>
Date: Tue, 19 Nov 2024 17:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] gpio: at91: Implement GPIOF_FUNC in get_function()
To: Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241113101022.2915364-1-admin@hifiphile.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20241113101022.2915364-1-admin@hifiphile.com>
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

Applied patches to u-boot-at91/next, thanks !

Eugen

On 11/13/24 12:10, Zixun LI wrote:
> This patch adds support for determining whether a gpio pin is mapped as
> peripheral function.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
> Changes in v2:
> - Rename function
> ---
>  drivers/gpio/at91_gpio.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/at91_gpio.c b/drivers/gpio/at91_gpio.c
> index 1409db5dc1..173315d45f 100644
> --- a/drivers/gpio/at91_gpio.c
> +++ b/drivers/gpio/at91_gpio.c
> @@ -220,6 +220,15 @@ static bool at91_get_port_output(struct at91_port *at91_port, int offset)
>  	val = readl(&at91_port->osr);
>  	return val & mask;
>  }
> +
> +static bool at91_is_port_gpio(struct at91_port *at91_port, int offset)
> +{
> +	u32 mask, val;
> +
> +	mask = 1 << offset;
> +	val = readl(&at91_port->psr);
> +	return !!(val & mask);
> +}
>  #endif
> 
>  static void at91_set_port_input(struct at91_port *at91_port, int offset,
> @@ -550,7 +559,9 @@ static int at91_gpio_get_function(struct udevice *dev, unsigned offset)
>  {
>  	struct at91_port_priv *port = dev_get_priv(dev);
> 
> -	/* GPIOF_FUNC is not implemented yet */
> +	if (!at91_is_port_gpio(port->regs, offset))
> +		return GPIOF_FUNC;
> +
>  	if (at91_get_port_output(port->regs, offset))
>  		return GPIOF_OUTPUT;
>  	else
> --
> 2.46.2
> 

