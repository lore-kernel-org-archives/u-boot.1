Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5670CA1013
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF0182AE9;
	Mon,  8 Sep 2025 10:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qu8FrF7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC1D82CF8; Mon,  8 Sep 2025 10:12:04 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5481E800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3e2055ce7b3so2497042f8f.0
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 01:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757319121; x=1757923921; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=dxut2mr22fMNLLRFpScCkRI3WvncvzduqUsDFZJ917o=;
 b=qu8FrF7z/6/4INUIq+G5wLoct75amXXKCuSuvQKNrnYNWIiDH61i6LduLZq0Q0Kr3X
 sz5N2OHWSH9hCocGAHgsBfuYsHcEEXZPSzU449uJ1yKG6RLiGaC5iIjfh5YArOeda5Xs
 IMpp6Hm8KDkqpBbu2JF7J5Y2Q68kp0581m6FZ+JTDTr6X3LO/MrauFDjcJfckD9bTTUV
 xRyX2jWl0iyAznT50dm9X9ORtWYniIZYJPNWdXglVuREFi/ZpSKOJ0IiN+UEnpdVPl0A
 YIscdk9q5C5jXKHwfsPz/1J2e/abf8c9tUD0LCnQ/doMkvLtmMEnNHYMBki9EpVvKWOz
 YY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757319121; x=1757923921;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dxut2mr22fMNLLRFpScCkRI3WvncvzduqUsDFZJ917o=;
 b=BvDqwvpHwCmXf1dmj8GgXXcPvO/AbvIDbcWqZY00OMMDxNNkwP1+PdU+0UXuRlmomR
 ihgPoA7A0BKQ8UzQLuIOkp7c6wgz6GInLMNw0sMOYqplH3M764qYlv8+b93T6pzIRQhn
 vrYJCMazwVkoIirQ2zlmHn3jnb1CRag7cDXerJZso45baLEvrEcPMCyYwZuKPZxOw8UL
 AcfAZ1BhukRLcZVmpVo5WP9KNFi0PfYZSzQG0hB/7EJx3Rnz9fEbV2on6/WeZ3xUkuIl
 JD9vGvMyAIdm8BMDyNAwPLOcMkC6PMK0GowHQ7u1kM+Iz+5MtD36i8Bdvm33PQbICTC/
 WNNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBmTRi7i+u8tv/vaaIFxxheSuIav/0Xdz5wvBxo0mZkX4RWo2d4hBjcc/EwfqlBW44fPKICQc=@lists.denx.de
X-Gm-Message-State: AOJu0YwYgBY/KjbhO/Uz/JRqNS8g/4x18CDocaQ/nDtxsq47H67hGAOw
 GlYCQorm8To0PxDz7YFw23Bf+YfacNedMjCNiJfy9VJhWbbcn3YM6XsifSMcrYtt/Iw=
X-Gm-Gg: ASbGnctdOXJQcZ/wZDfmmXHADC6DPO7JY1Q1CHPYUne6QZNKqS5J1DbFvuVGz3siRwv
 HGzSf2/8HRzjYF/glngLqiTCho2x30dkGNYfrRyhEUCgRKRq/IGhc0F4KHunhtmagrOtKUvBsSz
 1NkuBiaTdSogoMlWFMeTCyFUQ7Og6Sq9u/gzYeIM5FhheaSGu2NBRHkTUaKnGYfAMUBvbi3LmEa
 sVqXN4PuVwiXIpZQYoNobvTWejcCm+y2XIgPoibaThd6y7otnNUEvXRBYLL/zHZgNPZcOvk1J/L
 TvmlhhG13eHncxAsSHpWerufO523QDxWnS3u0UXVjBSiob3JrbBC/QeSqbPseTiGhE2Xt9zqdwf
 wm4o6SsUm1SYzs3td6zlc0Z7m6xNoO505Ug7Tcgu/cPlfsOndVsjHvncXnNJLLVsFM77A4VSCXb
 qV48OLqIj7vg==
X-Google-Smtp-Source: AGHT+IGbcjTrU8k26Mz7v0DR0hcSqrxSHpOMhC6jZ0m+ei0dgoXG1N+GIW6njo5BybsksmmQU+INlA==
X-Received: by 2002:adf:b350:0:b0:3e7:41ac:45f8 with SMTP id
 ffacd0b85a97d-3e741ac4939mr2933540f8f.55.1757319120653; 
 Mon, 08 Sep 2025 01:12:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b?
 ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34493b8csm39799320f8f.59.2025.09.08.01.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 01:12:00 -0700 (PDT)
Message-ID: <199ecb7b-4c18-40fc-992a-af7535251112@linaro.org>
Date: Mon, 8 Sep 2025 10:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 07/09/2025 16:36, Ferass El Hafidi wrote:
> It is very limited and minimal, only implements putc/puts.
> This minimal driver is intended to be used in SPL, and other
> size-constrained situations.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   drivers/serial/serial.c       |   2 +
>   drivers/serial/serial_meson.c | 112 +++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 113 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/serial/serial.c b/drivers/serial/serial.c
> index e10ca6eef768502ea32bf39a41ae2e3ccd168c66..c0b1eb3056181b95e1861f1ce08fcd82ff81eb71 100644
> --- a/drivers/serial/serial.c
> +++ b/drivers/serial/serial.c
> @@ -129,6 +129,7 @@ serial_initfunc(pxa_serial_initialize);
>   serial_initfunc(smh_serial_initialize);
>   serial_initfunc(sh_serial_initialize);
>   serial_initfunc(mtk_serial_initialize);
> +serial_initfunc(meson_serial_initialize);
>   
>   /**
>    * serial_register() - Register serial driver with serial driver core
> @@ -167,6 +168,7 @@ int serial_initialize(void)
>   	smh_serial_initialize();
>   	sh_serial_initialize();
>   	mtk_serial_initialize();
> +	meson_serial_initialize();
>   
>   	serial_assign(default_serial_console()->name);
>   
> diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
> index bb79b9729579a661084425d6b3c5357da31dc3c0..981ea5e159062b7d13885325e17b833145281158 100644
> --- a/drivers/serial/serial_meson.c
> +++ b/drivers/serial/serial_meson.c
> @@ -3,9 +3,11 @@
>    * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
>    */
>   
> +#if CONFIG_IS_ENABLED(DM_SERIAL)
>   #include <dm.h>
> -#include <errno.h>
>   #include <fdtdec.h>
> +#endif
> +#include <errno.h>
>   #include <linux/kernel.h>
>   #include <linux/bitops.h>
>   #include <linux/compiler.h>
> @@ -51,6 +53,7 @@ struct meson_serial_plat {
>   #define AML_UART_REG5_USE_NEW_BAUD	BIT(23) /* default 1 (use new baud rate register) */
>   #define AML_UART_REG5_BAUD_MASK		0x7fffff
>   
> +#if CONFIG_IS_ENABLED(DM_SERIAL)
>   static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
>   {
>   	/*
> @@ -245,6 +248,113 @@ U_BOOT_DRIVER(serial_meson) = {
>   	.plat_auto	= sizeof(struct meson_serial_plat),
>   };
>   
> +DM_DRIVER_ALIAS(serial_meson, amlogic_meson_gx_uart);

Why is this needed ?

> +
> +#else
> +
> +static int meson_serial_init(void)
> +{
> +	struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
> +	u32 val;
> +
> +	val = readl(&uart->control);
> +	val |= (AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
> +	writel(val, &uart->control);
> +	val &= ~(AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
> +	writel(val, &uart->control);
> +	val |= (AML_UART_RX_EN | AML_UART_TX_EN);
> +	writel(val, &uart->control);
> +
> +	return 0;
> +}
> +
> +static int meson_serial_stop(void)
> +{
> +	return 0;
> +}
> +
> +static void meson_serial_setbrg(void)
> +{
> +}
> +
> +static void meson_serial_putc(const char ch)
> +{
> +	struct meson_uart *uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
> +
> +	/* On '\n' also do '\r' */
> +	if (ch == '\n')
> +		meson_serial_putc('\r');
> +
> +	while (readl(&uart->status) & AML_UART_TX_FULL)
> +		;
> +
> +	writel(ch, &uart->wfifo);
> +}
> +
> +static void meson_serial_puts(const char *s)
> +{
> +	while (*s)
> +		meson_serial_putc(*s++);
> +}
> +
> +static int meson_serial_getc(void)
> +{
> +	struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
> +	uint32_t status = readl(&uart->status);
> +
> +	if (status & AML_UART_RX_EMPTY)
> +		return -EAGAIN;
> +
> +	if (status & AML_UART_ERR) {
> +		u32 val = readl(&uart->control);
> +
> +		/* Clear error */
> +		val |= AML_UART_CLR_ERR;
> +		writel(val, &uart->control);
> +		val &= ~AML_UART_CLR_ERR;
> +		writel(val, &uart->control);
> +
> +		/* Remove spurious byte from fifo */
> +		readl(&uart->rfifo);
> +		return -EIO;
> +	}
> +
> +	return readl(&uart->rfifo) & 0xff;
> +}
> +
> +static int meson_serial_tstc(void)
> +{
> +	struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
> +	uint32_t status = readl(&uart->status);
> +
> +	if (status & AML_UART_RX_EMPTY)
> +		return 0;
> +	return 1;
> +}
> +
> +struct serial_device meson_serial_device = {
> +	.name	= "meson_serial",
> +	.start	= meson_serial_init,
> +	.stop	= meson_serial_stop,
> +	.setbrg	= meson_serial_setbrg,
> +	.getc	= meson_serial_getc,
> +	.tstc	= meson_serial_tstc,
> +	.putc	= meson_serial_putc,
> +	.puts	= meson_serial_puts,
> +};
> +
> +void meson_serial_initialize(void)
> +{
> +	serial_register(&meson_serial_device);
> +}
> +
> +__weak struct serial_device *default_serial_console(void)
> +{
> +	return &meson_serial_device;
> +}
> +
> +#endif
> +
>   #ifdef CONFIG_DEBUG_UART_MESON
>   
>   #include <debug_uart.h>
> 

