Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DB4C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B64D878D6;
	Thu, 21 Dec 2023 17:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lO8fX14L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556658786E; Thu, 21 Dec 2023 17:41:58 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6868E878D6
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cc6d9b4c6aso11542181fa.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703176914; x=1703781714; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=zoUEY+7YOdLkP1xS2UY8HLhwMhwqtWp4bhC0R9FGOJc=;
 b=lO8fX14Ldpvd5w/+2WU4dhi7kAvmyzmFLoAZvodmh4rKS1K0D8KiyUkSI2Dg4dFaNr
 4f0U+bDoaoR9CMxor2a8TQaZ7ovX+ONrImAeiwHHuY6jYspmEYQWbzx01Ob9NHH/fGI5
 MKhfISldDCm9GXL4tts6brCSDxJBxHUefVUXmg3hL2pk8bv8zqApr0Ppa1h4OZLwPvlC
 1edtNpeXtyBmquuwaBgZPfCQ9fdurKR0ENHAmVZr2Dok1YXFiBF4pBfbr6agxs4MbKk9
 Je/ujHEJwHObobUfQi+vez44igORpM+MDZAVB9TNPb7GYJATt6m55RaWlg8Mgcp0iIAV
 TXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703176914; x=1703781714;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zoUEY+7YOdLkP1xS2UY8HLhwMhwqtWp4bhC0R9FGOJc=;
 b=mGMZNrSVSgg5D90xnQ+2GKz/5MF5VNBosVSBxKoHBEBIqVjoS8qNnCxAt5GXGGO9Ps
 iTOkFFJjy3gXN78zUaXUCwtRkt1XtlxrAHuYuVEAhwLj9k4StlYAqDPTLDJ4YA5Z8GEl
 mOZaGbMNDVrpYd55aWt112YyNGAtBB6reNPdX+nbCTGUqkwYLEjEACcTVfnyDWl1znG6
 7ypuxwNck4pHyJNFlNkE3KJtEGA9lT953CH6dkiniuCm2P1Mk9JwJv4cALPATwYT9D4J
 52BAOtQQQYFU1Do7tcRH0ykwxRs7xLM8i9BaUxPu7Jz1+PlvbtKJHB6iF35g5rQEpzdb
 nGgA==
X-Gm-Message-State: AOJu0YxW0c1bWPsI0fpnJ8Wz72X2MqfsZIaSVDiwf4RDRgHsNcbBJ9+a
 7r+rAUuyXOhwpaYd+mvidASzWg==
X-Google-Smtp-Source: AGHT+IFHsgTAkpgfe/AamsGuJYhozYe7IgFjL5HO6DZeYOxTa7KUx4+8lc7i4MD0z51YyYlYT21fzw==
X-Received: by 2002:a2e:8516:0:b0:2cc:6bb3:d4d with SMTP id
 j22-20020a2e8516000000b002cc6bb30d4dmr4363760lji.76.1703176913661; 
 Thu, 21 Dec 2023 08:41:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 d17-20020adfe2d1000000b0033673ddd81csm2372633wrj.112.2023.12.21.08.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:41:53 -0800 (PST)
Message-ID: <50899154-6527-4c61-81cd-c7bd72ecc6bd@linaro.org>
Date: Thu, 21 Dec 2023 17:41:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 06/32] serial: msm: add debug UART
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-6-b6dd9704219e@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20231219-b4-qcom-common-target-v2-6-b6dd9704219e@linaro.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 19/12/2023 17:04, Caleb Connolly wrote:
> Introduce support for early debugging.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/serial/Kconfig      |  8 ++++++++
>   drivers/serial/serial_msm.c | 32 ++++++++++++++++++++++++++++++++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 81fdac047824..20713812c839 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -304,6 +304,14 @@ config DEBUG_UART_S5P
>   	  will need to provide parameters to make this work. The driver will
>   	  be available until the real driver-model serial is running.
>   
> +config DEBUG_UART_MSM
> +	bool "Qualcomm QUP UART debug"
> +	depends on ARCH_SNAPDRAGON
> +	help
> +	  Select this to enable a debug UART using the serial_msm driver. You
> +	  will need to provide parameters to make this work. The driver will
> +	  be available until the real driver-model serial is running.

I'm confused, perhaps the config should be named DEBUG_UART_MSM_QUP ?

> +
>   config DEBUG_UART_MSM_GENI
>   	bool "Qualcomm snapdragon"
>   	depends on ARCH_SNAPDRAGON
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index a22623c316ed..19a5a3a788f7 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -253,3 +253,35 @@ U_BOOT_DRIVER(serial_msm) = {
>   	.probe = msm_serial_probe,
>   	.ops	= &msm_serial_ops,
>   };
> +
> +#ifdef CONFIG_DEBUG_UART_MSM
> +
> +static struct msm_serial_data init_serial_data = {
> +	.base = CONFIG_VAL(DEBUG_UART_BASE),
> +	.clk_bit_rate = UART_DM_CLK_RX_TX_BIT_RATE,
> +};
> +
> +#include <debug_uart.h>
> +
> +static inline void _debug_uart_init(void)
> +{
> +	uart_dm_init(&init_serial_data);
> +}
> +
> +static inline void _debug_uart_putc(int ch)
> +{
> +	struct msm_serial_data *priv = &init_serial_data;
> +
> +	while (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY) &&
> +	       !(readl(priv->base + UARTDM_ISR) & UARTDM_ISR_TX_READY))
> +		;
> +
> +	writel(UARTDM_CR_CMD_RESET_TX_READY, priv->base + UARTDM_CR);
> +
> +	writel(1, priv->base + UARTDM_NCF_TX);
> +	writel(ch, priv->base + UARTDM_TF);
> +}
> +
> +DEBUG_UART_FUNCS
> +
> +#endif
> 

