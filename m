Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF0CC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F0F487F30;
	Mon, 19 Feb 2024 10:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qmGz8uU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D80887D1A; Mon, 19 Feb 2024 10:47:27 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14D0A87DE5
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41262ec677fso6744655e9.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 01:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708336030; x=1708940830; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=cqRd8mmSRTxKLdaGk3pfHlklv+sasvpqbzrD2CZiU80=;
 b=qmGz8uU3G4BO+zSBGFSVzs7EAMWP8FLEkd+kawAqWoHJDz4vhr8EC52Dx2vXcz1xWa
 lgxSfNRjHpCDx05Lm09GTYk8K536DAWzeOH7KndE5qQ/paUJZXw6hr6Qg99+GKD6hhwG
 oo0Yss6KEw/NRybJ13x+zXdD6pxqenwCxvIJf0oRbGI2JMKOvCfv/xrKtyLpq/LzRMoG
 PT3/oFt/NxdeSp50ZQ+KWSmLZs6v6wrABPqKRw7fxxr9Jy6UxQIIcGlyGAGyaL1v+kdh
 b6RnAH2/bfNw7FdsUsHRarx9NOZAlKnATSvVxEWQGIoPX3nUxwmFy25k+7EbCtH1eJZ5
 jBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708336030; x=1708940830;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cqRd8mmSRTxKLdaGk3pfHlklv+sasvpqbzrD2CZiU80=;
 b=Of9hRJ3US5MygrKi14lIe19wHP/x0bbhKvi6EGerwR2vuWKD4MAFCHdn4qFzGemzBr
 moqKfBYUAhbpr5b8S3ZfyM4o6lPatkDPjXH5ZiZ2H0ZjQ1A6vOyyAcuBSf9L2H/GzBl5
 rqcnzllrqWP2W3sXwc+qUolH8RWC3YOfXa0pwaFzkUdeyHzOZkbKBa/dxN+sfwmMXuCx
 yI5AHyF3iOYpp/HotWPurBoLhXM6fY+aPFzw1YFL41aUGSmJG4diaRji9zEtEvVDwOJw
 BDfKGfEq3/NDbrAlR+FrFqpnFBP2X9Vcup8heKRNj9rGHyKu0T5Znus3OadzXoXnK5UR
 ppMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ9yrdr7Mi7od95BboSmWtSKaSoo0vdXJQ0EX32Dmqws6WJaO6+/Wstx1wNXOHqQlOx4nbxYg+JfLW/+k6kd1l30zB1Q==
X-Gm-Message-State: AOJu0YyvtIzZIjcxeQVzC4Uwf0MdGDFEZai2oNFWrkT3tONh+x6Yo+wz
 a9nqhI4AABbmPzGgTNyupcFXiviPpSNy3VUXb/fQLlwr1SaorWk5YgqjIX/gLb8=
X-Google-Smtp-Source: AGHT+IFqifKIiu7HKyVw8vEtlFSPdGiDmjL10su/ikYBEepRPh8PZV3OuZaZ9ZAeVtBmkUWMfayUpw==
X-Received: by 2002:a05:600c:4fc4:b0:410:68e1:d9ca with SMTP id
 o4-20020a05600c4fc400b0041068e1d9camr9124644wmq.2.1708336030009; 
 Mon, 19 Feb 2024 01:47:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f?
 ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a05600c46d100b0041249ea88b9sm10136159wmo.16.2024.02.19.01.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 01:47:09 -0800 (PST)
Message-ID: <1dfb19cf-a446-4b94-a330-04bbe32081e5@linaro.org>
Date: Mon, 19 Feb 2024 10:47:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 07/39] serial: msm: add debug UART
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
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-7-ed06355c634a@linaro.org>
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
In-Reply-To: <20240215-b4-qcom-common-target-v4-7-ed06355c634a@linaro.org>
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

On 15/02/2024 21:52, Caleb Connolly wrote:
> Introduce support for early debugging. This relies on the previous stage
> bootloader to initialise the UART clocks, when running with U-Boot as
> the primary bootloader this feature doesn't work. It will require a way
> to configure the clocks before the driver model is available.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/serial/Kconfig      |  8 ++++++++
>   drivers/serial/serial_msm.c | 37 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 26460c4e0cab..fbd351a47859 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -319,6 +319,14 @@ config DEBUG_UART_S5P
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
> +
>   config DEBUG_UART_MSM_GENI
>   	bool "Qualcomm snapdragon"
>   	depends on ARCH_SNAPDRAGON
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index f4d96313b931..44b93bd7ff21 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -252,3 +252,40 @@ U_BOOT_DRIVER(serial_msm) = {
>   	.probe = msm_serial_probe,
>   	.ops	= &msm_serial_ops,
>   };
> +
> +#ifdef CONFIG_DEBUG_UART_MSM
> +
> +static struct msm_serial_data init_serial_data = {
> +	.base = CONFIG_VAL(DEBUG_UART_BASE),
> +	.clk_rate = 7372800,
> +};
> +
> +#include <debug_uart.h>
> +
> +/* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
> +//int apq8016_clk_init_uart(phys_addr_t gcc_base);
> +
> +static inline void _debug_uart_init(void)
> +{
> +	/* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
> +	//apq8016_clk_init_uart(0x1800000);
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
