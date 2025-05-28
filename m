Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126C4C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 11:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6CB83A8E;
	Wed, 28 May 2025 13:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XWlcidq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D78783A8A; Wed, 28 May 2025 13:25:22 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31D383A8F
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 13:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad5273c1fd7so883031966b.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 04:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748431519; x=1749036319; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1OQKjpSxAfNoQ63uIKCKFj72YND8/CepL9f0E6KPLfo=;
 b=XWlcidq/TK2CK5QH+/6Z+VWMIc1cvAhni5l1eq3TBmitRmrMRUKP/eP2004/I+VUtR
 hz2sm+7TavJFoF9yxKcMg7egDKsZDFkX1jwYJLQz+YTq43J19qnXYkjwTP6B93Dwy4dv
 NDHwQAO2pFBh+TXnJa1x/wUJpPZYXsHFJPXbx6HvK+jf20Kpj9X1oImT+vlulddR5PWk
 gPs8mXq4wD6rAKM4iDqfaYWkBDV4ph7j1UtPFTD1+Se5EEOGSFmM1v6tTXY/6ulFDP30
 4UuP2MaCArh3DdFqm4987DQNwY2hdLy3wpuh0iBygamy66LOyWs/t4oc+UrvZc6+RVHK
 5BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748431519; x=1749036319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1OQKjpSxAfNoQ63uIKCKFj72YND8/CepL9f0E6KPLfo=;
 b=mwpXC2LonYp0NhgcsxsZsn1+dypzuchOhoqNlItYjeZcSFAx0SVjy+AkVoP3OMeSlj
 MDNeT6+cSOIo9+vS2rwORwLaFQzA5IHsDSvoKbKoLn88Sj22jUKjq+ej3ESqQV4QWLLk
 I6GfE2D8uY+6D46bwW1i1qZmvJYCz97UPm+p0Y6BRF9D7ez73y4CflWvyi6E2bN/QDYr
 qswIWzqUb0651QVt+H8Qas+y627Nrf9lUmqHy3rt0bFDuXrc12gB8/my36XQk75IQK3R
 RlkpGvIe+Cv60ft+5emx7cOHNFFCdO4k1jgIto0NEm9+LsXb8PPm8qFB8GdP4KGJo3oS
 D1Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpHHIKOXqETrSmJShU2c4a8WCvEpl8Ns+YAbTeM595A7vONTURP/AjLkD/FNPCIVhfWMR3JqM=@lists.denx.de
X-Gm-Message-State: AOJu0YytELnqGKgq5tJAO57vcP8QZVmTTGKvrKnAr1iYKp6BiFrlojfI
 Y0q9l6q4cuOrdr7/DWPs/VMATB3jnTmgo3PjGtdas5GRL9V1sOHBBFObSLejm/2fxRw=
X-Gm-Gg: ASbGnctLON/0OGkQGtfj4u9MKujkmVZCr8BzM97/f3M7TTvWSQoU8N/tAinqlVIESKU
 FFrEzePHQNBOiYA8tHqam5S+fXIkbaZb3zmFYzxEd3CgUKltDl79tKLD0YVLDa4hSDha9+WdRi6
 lh4eq4CtfYcSDazFb0cHrLqRtnMH7HWWMYc7Wh/e+C41ERD14knKxDGmVO+3x5mpXL16jyIKsx0
 9B0Cqpcd87Imk/k5zAHxU7QyYLJijG3UjGMKVes0yoyDBsZDNBaxee6pc6dIQvY1tgBi2gosYex
 SR8voC4ivahvHn/snVK1nPULHWPHbGF2fmgY/25DdFhl9OgTS5+kI2lsMNbLrXDTRZeG55e40/P
 BJ0r4zXr0r5dMjMYeWuEyE2kjMw==
X-Google-Smtp-Source: AGHT+IEQQrL+KzEI/MhhKZnbWZKZRNCMUEDgTzoapuakYJD5NHe92X87eXvCtxwq9Iiorv3e69kHnQ==
X-Received: by 2002:a17:907:1b0f:b0:ad5:2e5b:d16b with SMTP id
 a640c23a62f3a-ad85b0ed0e2mr1628346766b.27.1748431518919; 
 Wed, 28 May 2025 04:25:18 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:7b9d:1015:16d5:5c7e?
 ([2a01:170:117e:fc:7b9d:1015:16d5:5c7e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad8a19ca392sm91314166b.70.2025.05.28.04.25.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 04:25:18 -0700 (PDT)
Message-ID: <6fdb5e17-7d9f-4248-9d18-72c4b5582fd9@linaro.org>
Date: Wed, 28 May 2025 13:25:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/28] board: google: Add board_debug_uart_init() for
 Trogdor
To: Stephen Boyd <swboyd@chromium.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
References: <20250523225845.2311989-1-swboyd@chromium.org>
 <20250523225845.2311989-25-swboyd@chromium.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250523225845.2311989-25-swboyd@chromium.org>
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



On 5/24/25 00:58, Stephen Boyd wrote:
> Implement board_debug_uart_init() for Trogdor boards so that the debug
> UART can be used. Initialize the clk to XO speed (19.2MHz) and change
> the pin configuration to mux out the uart hardware on the pins that are
> connected to the closed case debug (CCD) port for the AP. This is enough
> to get the early debug console working on boards like Lazor, but it
> should work for all Google Trogdor boards.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Would you be willing to add a MAINTAINERS file here for the trogdor 
specific bits?

Kind regards,> ---
>   board/google/trogdor/Makefile     |  3 +++
>   board/google/trogdor/debug.config |  6 +++++
>   board/google/trogdor/debug_uart.c | 41 +++++++++++++++++++++++++++++++
>   3 files changed, 50 insertions(+)
>   create mode 100644 board/google/trogdor/Makefile
>   create mode 100644 board/google/trogdor/debug.config
>   create mode 100644 board/google/trogdor/debug_uart.c
> 
> diff --git a/board/google/trogdor/Makefile b/board/google/trogdor/Makefile
> new file mode 100644
> index 000000000000..fd2933cf1e6f
> --- /dev/null
> +++ b/board/google/trogdor/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_DEBUG_UART_BOARD_INIT) += debug_uart.o
> diff --git a/board/google/trogdor/debug.config b/board/google/trogdor/debug.config
> new file mode 100644
> index 000000000000..7d8a6706a92e
> --- /dev/null
> +++ b/board/google/trogdor/debug.config
> @@ -0,0 +1,6 @@
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0xa88000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=36864000
> +CONFIG_DEBUG_UART_BOARD_INIT=y
> diff --git a/board/google/trogdor/debug_uart.c b/board/google/trogdor/debug_uart.c
> new file mode 100644
> index 000000000000..3d15d0d77728
> --- /dev/null
> +++ b/board/google/trogdor/debug_uart.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <asm/io.h>
> +#include <debug_uart.h>
> +#include <linux/delay.h>
> +
> +/*
> + * Enable the UART8 clks and pinctrl settings for SC7180.
> + *
> + * The debug UART goes out over CCD. The debug uart clk setting is 36864000 to
> + * make the buad rate calculation come out properly for the qcom geni serial
> + * driver.
> + */
> +void board_debug_uart_init(void)
> +{
> +	u32 val, mask;
> +	unsigned int timeout = 100;
> +
> +	/* Enable wrap1_s2 clk */
> +	val = readl(0x100000 + 0x52008);
> +	val |= BIT(24);
> +	writel(val, 0x100000 + 0x52008);
> +	/* Wait for enable */
> +	do {
> +		val = readl(0x100000 + 0x18274);
> +		mask = GENMASK(30, 28) | BIT(31);
> +		val &= mask;
> +		if ((val & BIT(31)) == 0 || ((val >> 28) & 7) == 1)
> +			break;
> +		udelay(10);
> +	} while (timeout--);
> +
> +	/*
> +	 * Configure GPIOs
> +	 * Bits: 0-1 = pull
> +	 * Bits: 2-4 = func
> +	 * Bits: 6-8 = drive strength
> +	 */
> +	writel(0x3 | (1 << 2), 0x3900000 + (0x1000 * 44)); // Pin 44 - PULL_UP, func1 (qup12), 2ma
> +	writel(0x3 | (1 << 2), 0x3900000 + (0x1000 * 45)); // Pin 45 - PULL_UP, func1 (qup12), 2ma
> +}

-- 
Casey (she/they)

