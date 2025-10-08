Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F10CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 13:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0450839B9;
	Wed,  8 Oct 2025 15:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r1+ZY42G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F165B83E21; Wed,  8 Oct 2025 15:31:13 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEB998394A
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 15:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso45583865e9.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759930270; x=1760535070; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=oDh0lRX8+hZOTqS5Bp2oT/xfNgwI1WJoX/Z+c1xFIMg=;
 b=r1+ZY42GM6g0vgRyq0o/ZggSngyBa5IF+sFqRghM2uycjJCKcHChW5sqaHQirIIMEO
 dSADVFzZD3yYcYZjOpVcNq7ItkNsXQCHPCBZEqg00RUwb6XO4gLlTMs3W+FhMl6IT2VT
 VeM15yLwQpw2lGcNSmtMTiEtBtdOU5X0jv1RWAO4Nz56oIatOMiTAM3J1wCrXTs8jPVa
 DNVKNldfuGgtRMuzbbuth71Y1UHiekVXGP6rGv1WdlujETcpiSr5irXKCaHGclY9byW4
 58SocSKrAfwRthf1rPKDYje3bqbrdmiUfTUZg2DE2AWayo/CHv0tlMMpEkbkWNfcrvbp
 KL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759930270; x=1760535070;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oDh0lRX8+hZOTqS5Bp2oT/xfNgwI1WJoX/Z+c1xFIMg=;
 b=e6ppLufz95axPz9gv3UoLXW32rk58EZJkY21BgoEPUCGrhUZNQEJShYU+XDFwb2lMX
 fSxSXyanpw84QS5qVBoukigtInnyVRBZCnLNJY8DnAmGaJympOEfho8dxpPpLbNdMrvj
 xviFsRIUKQ93OO2TDDzjkMW/3KoDe+dspegzDWRGYnbK5WYbJ+ne3hHte/zlskDgxVG/
 QBz5gi5w0ksE0kO4skDsDiZd6ndGiBZ1nOrr1RBJBecQSGPyV89I51VchySWJzO2UYTx
 Sj2JMf1+1XhSoJOgSEyaJCeK1buNO8K5Nun9XT1F+PmzbnRhA4OL5006dTlLKQ+d4+gR
 Ps/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrqirWCOjviL/Fmny84RqAn1h8RckRQCEbV4VqYHs6jWHI1QT6XPC8F+jp9SCmFzsbviov4ag=@lists.denx.de
X-Gm-Message-State: AOJu0YxdaC3JR9+4ABDlkXY0RNqGj+UVIQGVOkpg+2ggAKkMMT2k7KLL
 4VoiSHBfqM8QI31xdCXCL+kNARBA05YADH7n81+q4D4/AtiOfi88sv3RN3j7/iTRP6w=
X-Gm-Gg: ASbGncvVtPkYw+kVc/mi0q58FML6DcJdDvTg6zzz/KVpVA+RQqe7Zjnv2J5pC4Iz250
 qkaovKMjh7v3Z0VJzGCte1ie4EtKP+QmfprbLQBW+/9f6o9OHzxQ9MVcMG00+x2tHHYahh/cRHB
 KM9sODlhaRb4I6u0/0YqIyn0YcFFUvP0lchnTDPeMI8Tc453BMWTykTLxCX9bHrIZgKecYxFoFc
 bk34N3G+kLMAs5GZY7+RMhXEkvBZ4h4LnNTeR9tGYvs7zSB1NZ8RXXej14/QPNkpqASMs47X009
 4LCepcSOFGBg7B4lVjto6e2/aPG1BzTALZprhWWqOpsOkkIKgKp15Khu4czqhEqqtfkoezWLxmX
 2rFKyqnv5lIJ75ErSVXZOw4YROL54W7h/6AE+Z8/9eBvT204tzn6Dq2vmDDaVNUTm/Y27ctYUY6
 SSKuH/f2RnW6Kyi4Y3cfU=
X-Google-Smtp-Source: AGHT+IEiVSoC0qkB4ss4tHl06E/3yzS/aomHsh77+KTpAKRlZq0pW/04ZpCkvA8bBQqWd21fpejApQ==
X-Received: by 2002:a05:600d:416a:b0:46e:3f75:da49 with SMTP id
 5b1f17b1804b1-46fa9b11794mr21038735e9.37.1759930269893; 
 Wed, 08 Oct 2025 06:31:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b264:afbc:dee:3d?
 ([2a01:e0a:3d9:2080:b264:afbc:dee:3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9b622cdsm38082805e9.0.2025.10.08.06.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 06:31:09 -0700 (PDT)
Message-ID: <9ca9f483-16dc-462b-93bf-22197e890886@linaro.org>
Date: Wed, 8 Oct 2025 15:31:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC v3 3/8] serial: serial_meson: add minimal non-DM driver
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
 <20251008-spl-gx-v3-3-5999637df4b9@postmarketos.org>
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
In-Reply-To: <20251008-spl-gx-v3-3-5999637df4b9@postmarketos.org>
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

On 10/8/25 12:00, Ferass El Hafidi wrote:
> It is very limited and minimal, only implements putc/puts.
> This minimal driver is intended to be used in SPL, and other
> size-constrained situations.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   drivers/serial/serial.c       |   2 +
>   drivers/serial/serial_meson.c | 119 +++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 120 insertions(+), 1 deletion(-)
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
> index bb79b9729579a661084425d6b3c5357da31dc3c0..cc71381f87e1e2d192e5f4450f881c2a69511ca3 100644
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
> @@ -25,6 +27,15 @@ struct meson_serial_plat {
>   	struct meson_uart *reg;
>   };
>   
> +#if !CONFIG_IS_ENABLED(DM_SERIAL)
> +/* UART base address */
> +#if defined(CONFIG_MESON_GX)
> +#define AML_UART_BASE	0xc81004c0
> +#else /* G12A, AXG, ... */
> +#define AML_UART_BASE	0xff803000
> +#endif
> +#endif
> +
>   /* AML_UART_STATUS bits */
>   #define AML_UART_PARITY_ERR		BIT(16)
>   #define AML_UART_FRAME_ERR		BIT(17)
> @@ -51,6 +62,7 @@ struct meson_serial_plat {
>   #define AML_UART_REG5_USE_NEW_BAUD	BIT(23) /* default 1 (use new baud rate register) */
>   #define AML_UART_REG5_BAUD_MASK		0x7fffff
>   
> +#if CONFIG_IS_ENABLED(DM_SERIAL)
>   static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
>   {
>   	/*
> @@ -245,6 +257,111 @@ U_BOOT_DRIVER(serial_meson) = {
>   	.plat_auto	= sizeof(struct meson_serial_plat),
>   };
>   
> +#else
> +
> +static int meson_serial_init(void)
> +{
> +	struct meson_uart *const uart = (struct meson_uart *)AML_UART_BASE;
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
> +	struct meson_uart *uart = (struct meson_uart *)AML_UART_BASE;
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
> +	struct meson_uart *const uart = (struct meson_uart *)AML_UART_BASE;
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
> +	struct meson_uart *const uart = (struct meson_uart *)AML_UART_BASE;
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
