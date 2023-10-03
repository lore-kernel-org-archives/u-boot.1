Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEEFE75432
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 07:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B2F86DD3;
	Tue,  3 Oct 2023 09:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZqYyPr+s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37798723B; Tue,  3 Oct 2023 09:25:01 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8FE486DD3
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 09:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so636556f8f.1
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696317899; x=1696922699; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XcLN8dO/VlbnaKnnDbYOL6x9VTYmz7ZSfkgHj3t2Esk=;
 b=ZqYyPr+s6bAZvJr3tJEphpMiGNnHGFSyCkBtgqxIpuWfI9FGKQu5lCtVm9afzBEbwr
 uEQlPP2hwOKZG7K1X/uw1iZZxvMbTMQ3LVPo0NRZu93skQzW4xuMzgkR5/I/jxWs4NJd
 CWbHVJojEnuHAftuuRGAkjf13k9Rq/ybqrkPviIVJvjKyzEHbS8uc88He6hbF8XSu5s4
 0VzOmEAZ1P/n9+ksq0wPYPJzeBIkyqnUEdo53LbbrvODAugzNxnW/NtKHxG/m55FGCIA
 XA4w26FAWnw5GxEwXQ24ZKpT7WL/x2JgO+Fqbag9dnv3e0kqNac6d+sh6Jnveef8SEtQ
 UtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696317899; x=1696922699;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XcLN8dO/VlbnaKnnDbYOL6x9VTYmz7ZSfkgHj3t2Esk=;
 b=GBWvMqFpoVusKd5ErEjrSCWFaihHcyD44I0GJ4UGmSn+Tek/tMeN9p1kp3YXnWrsNa
 mrw2zaWRKuJGSu1kOKy64rAwOEoNOzGaDwf95JlMgGDDH0tywiyOC4YVdAQhQDjkuNae
 Y5gJi6dEGbetPUH1mPGfD1muLPQcW/34WYVIXPMdBcmD9nzlhX4G55R5dF4O64IR3far
 D0BWtlMN9D3zSSc+XlMOW6jsEHa/nRmJcCc8QmtpH3Q5tBuZm9Tb+hNNq55lyQJ+P995
 xR86q79JmC9QSjScYsHYVBuy+NIbcKw/sb9NBB1WVkP+n8fAnCVkzC8BdaQWfd7mQCH3
 ywZg==
X-Gm-Message-State: AOJu0Ywfm8fz/MOdb301BS9cj7xMhQ9BcWL3mN5E2YGE/TZUItOwNTaZ
 pKVHN+yyeh2axbNy7UWufK95fw==
X-Google-Smtp-Source: AGHT+IGKLylPctvk93Ca/DuchLeJFECL3AZTrVSZzqv0u2gavXqHO7Nq9W4vpTlVtfVPKQ/pxW7Tow==
X-Received: by 2002:a5d:5547:0:b0:320:a16:7028 with SMTP id
 g7-20020a5d5547000000b003200a167028mr12099108wrw.31.1696317899331; 
 Tue, 03 Oct 2023 00:24:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858?
 ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a5d444f000000b0031c5e9c2ed7sm865579wrr.92.2023.10.03.00.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 00:24:58 -0700 (PDT)
Message-ID: <6046140a-48fd-4c28-873c-44adb3bb479c@linaro.org>
Date: Tue, 3 Oct 2023 09:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/8] dt-bindings: reset: add Meson A1 reset bindings
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-2-avromanov@salutedevices.com>
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
In-Reply-To: <20231002165857.19512-2-avromanov@salutedevices.com>
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

On 02/10/2023 18:58, Alexey Romanov wrote:
> Get this from Linux 6.6-rc3.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   .../reset/amlogic,meson-a1-reset.h            | 76 +++++++++++++++++++
>   1 file changed, 76 insertions(+)
>   create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h
> 
> diff --git a/include/dt-bindings/reset/amlogic,meson-a1-reset.h b/include/dt-bindings/reset/amlogic,meson-a1-reset.h
> new file mode 100644
> index 0000000000..2c749c655e
> --- /dev/null
> +++ b/include/dt-bindings/reset/amlogic,meson-a1-reset.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + * Author: Xingyu Chen <xingyu.chen@amlogic.com>
> + *
> + * Copyright (c) 2023, SberDevices, Inc.
> + * Author: Alexey Romanov <avromanov@salutedevices.com>
> + */
> +
> +#ifndef _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
> +#define _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
> +
> +/*	RESET0					*/
> +/*					0	*/
> +#define RESET_AM2AXI_VAD		1
> +/*					2-3	*/
> +#define RESET_PSRAM			4
> +#define RESET_PAD_CTRL			5
> +/*					6	*/
> +#define RESET_TEMP_SENSOR		7
> +#define RESET_AM2AXI_DEV		8
> +/*					9	*/
> +#define RESET_SPICC_A			10
> +#define RESET_MSR_CLK			11
> +#define RESET_AUDIO			12
> +#define RESET_ANALOG_CTRL		13
> +#define RESET_SAR_ADC			14
> +#define RESET_AUDIO_VAD			15
> +#define RESET_CEC			16
> +#define RESET_PWM_EF			17
> +#define RESET_PWM_CD			18
> +#define RESET_PWM_AB			19
> +/*					20	*/
> +#define RESET_IR_CTRL			21
> +#define RESET_I2C_S_A			22
> +/*					23	*/
> +#define RESET_I2C_M_D			24
> +#define RESET_I2C_M_C			25
> +#define RESET_I2C_M_B			26
> +#define RESET_I2C_M_A			27
> +#define RESET_I2C_PROD_AHB		28
> +#define RESET_I2C_PROD			29
> +/*					30-31	*/
> +
> +/*	RESET1					*/
> +#define RESET_ACODEC			32
> +#define RESET_DMA			33
> +#define RESET_SD_EMMC_A			34
> +/*					35	*/
> +#define RESET_USBCTRL			36
> +/*					37	*/
> +#define RESET_USBPHY			38
> +/*					39-41	*/
> +#define RESET_RSA			42
> +#define RESET_DMC			43
> +/*					44	*/
> +#define RESET_IRQ_CTRL			45
> +/*					46	*/
> +#define RESET_NIC_VAD			47
> +#define RESET_NIC_AXI			48
> +#define RESET_RAMA			49
> +#define RESET_RAMB			50
> +/*					51-52	*/
> +#define RESET_ROM			53
> +#define RESET_SPIFC			54
> +#define RESET_GIC			55
> +#define RESET_UART_C			56
> +#define RESET_UART_B			57
> +#define RESET_UART_A			58
> +#define RESET_OSC_RING			59
> +/*					60-63	*/
> +
> +/*	RESET2					*/
> +/*					64-95	*/
> +
> +#endif

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
