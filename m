Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2763C7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 08:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E12F282CF4;
	Fri, 20 Jun 2025 10:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FEs6S+1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99FC782D39; Fri, 20 Jun 2025 10:55:49 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A7FA82CBC
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 10:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45362b7adc9so5892195e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750409747; x=1751014547; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=N9BwvrT47BhaR4PI2tE7A3DY5f6hcwsLbaZizXD46lE=;
 b=FEs6S+1Nw2JpHWG/AFjbsJ68GN4zX/fBLDVZOZiqLGirdaQLB/OIstGOrW+iFhjloi
 6Y8XwXapcD0EttfmSRGZQ9nxWBbgXnTSq+3Bj7orHuW8oQ9NS75KbY+eV3XRpUBenh6W
 rTkcSjks7Jd6u3rFgjdxod1eeZuMS45erMvoFnW4ZQGjZ5+cNmz4MCwj0a8dvZPFVJZD
 i3GoJgkrTizFzlF1Ww8SkpaLP7jBqsKFY/7TAs8SmVpueKz6BRNj9jpzBVZZYZVH9Sui
 2KtVL1VceZAooykOiNarrNcPrzlk4UJYqmldKqBPU/hWNwk1Bb1whUs9ZA/V2qCZx566
 +uTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750409747; x=1751014547;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=N9BwvrT47BhaR4PI2tE7A3DY5f6hcwsLbaZizXD46lE=;
 b=k9R5g4STyFmRtsKcd9fmccHI/BUNveeeG8AiLmmI5diUsAOjvnAmSBIMHkJGr4kNwL
 g93+8QCyDAmvlFtkciqgw3LZn1G82BZPjt+IKteKgP8JCD+TuDT2QqjWZOGIatZeRacR
 43ejOTbNwkq5aV92wrLeEx+0eSqWkToHMX3QWWt+y5tto8fWw5VHjddbofg5Tkr2Goq/
 iP+mgX35X2Lzzo3YokHSfzKhkKwz2dswn0V6jJPXQkmzv5guakK/hYeFhoOvzmVJOHd7
 szB1c8LJCMH/JSc7A0saGYrwk2K8b3ftTSyx179+njG0LlIvF4lDB3fgbjm4KWbxIa3P
 6q1g==
X-Gm-Message-State: AOJu0YxIWnSmDJfpDfoHJk/RP6qRkmrMT5w+f1oAHdSduPL4mpirvhf8
 KOToalfwfINB5rULm+jv57ehBa3mLaQa48qSl8TrAxp/B3sbPcSVAASOUWKh37LKGTc=
X-Gm-Gg: ASbGnct7o/7HFnJxqWMhznrGU9aFkP6WV+1W1HkIHhcOnbGIrfUIbxN/oJ6n82jF3FQ
 rMMqXnHyWb5rpWGsf5jJiXZE3iaxrO+o2nfHxBXGSIPSd71Zvc5xVG++B6AqSd1QisKju9cZJBb
 KWrxBaLd3IoXRru03ZQ7ya7Qum294LHcDJ62qdxxGY+4Nn0IrEYGRlgdLcUyFKVqeVRWIVMulIh
 tpUIAPI1z86CIemc+DbzIFe5lRiYMLCVM+HnuABce7eIDHrWMcdyXd7uctVVzFlJNJ3Uq6j7j75
 ipUjMA7ByrDzCFzdtn+j91lOC45xOrm1+7EpePkJIvTkidNvluCMS1XB83H7pFW1tn64p+YEMBC
 3aMfxrZ4J+BoJrSlH7WIoxdWyw7MJmgyh7WkYjqA=
X-Google-Smtp-Source: AGHT+IFWWJzpCSwk3oI2JD3keMcuMetFVNE+vKjJNBDboX9B+FyvkPiArm7CywWrFDocygmdSHU9vw==
X-Received: by 2002:a05:600c:37c6:b0:43d:fa5f:7d30 with SMTP id
 5b1f17b1804b1-45365e6e199mr12876655e9.16.1750409746545; 
 Fri, 20 Jun 2025 01:55:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3d60:2fa3:b982:4627?
 ([2a01:e0a:3d9:2080:3d60:2fa3:b982:4627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ebcecdcsm51074805e9.36.2025.06.20.01.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 01:55:46 -0700 (PDT)
Message-ID: <4926a8f5-bf91-42d5-a7b4-e6f7536b8c64@linaro.org>
Date: Fri, 20 Jun 2025 10:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/8] drivers: pinctrl: Add Qualcomm SM6350 TLMM driver
To: Luca Weiss <luca.weiss@fairphone.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
 <20250618-sm6350-bringup-v1-3-3cc22aab7a7a@fairphone.com>
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
In-Reply-To: <20250618-sm6350-bringup-v1-3-3cc22aab7a7a@fairphone.com>
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

On 18/06/2025 16:25, Luca Weiss wrote:
> Add support for TLMM pin controller block (Top Level Mode Multiplexer)
> on SM6350 SoC, with support for special pins.
> 
> Correct pin configuration is required for working debug UART and eMMC/SD
> cards.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/pinctrl/qcom/Kconfig          |   7 +++
>   drivers/pinctrl/qcom/Makefile         |   1 +
>   drivers/pinctrl/qcom/pinctrl-sm6350.c | 104 ++++++++++++++++++++++++++++++++++
>   3 files changed, 112 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index e567cb113a316592c6cfb9f42350fc60291772bc..bfda968299d694ba7db9796e561799ab0195328a 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -82,6 +82,13 @@ config PINCTRL_QCOM_SM6115
>   	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
>   	  as well as the associated GPIO driver.
>   
> +config PINCTRL_QCOM_SM6350
> +	bool "Qualcomm SM6350 Pinctrl"
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the Snapdragon SM6350 SoC,
> +	  as well as the associated GPIO driver.
> +
>   config PINCTRL_QCOM_SM8150
>   	bool "Qualcomm SM8150 Pinctrl"
>   	select PINCTRL_QCOM
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 6ffc6d48c1553a21bdf6aecdaee41c76251fae2d..8a3ad5d39f7869f2dabecc829961a5d7fe9cc596 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
>   obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
>   obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
> +obj-$(CONFIG_PINCTRL_QCOM_SM6350) += pinctrl-sm6350.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm6350.c b/drivers/pinctrl/qcom/pinctrl-sm6350.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1cbed77b55f28ce5f644173dfb3cba5398db504f
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm6350.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm sm6350 pinctrl
> + *
> + * (C) Copyright 2024 Linaro Ltd.
> + * (C) Copyright 2025 Luca Weiss <luca.weiss@fairphone.com>
> + *
> + */
> +
> +#include <dm.h>
> +
> +#include "pinctrl-qcom.h"
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +static const struct pinctrl_function msm_pinctrl_functions[] = {
> +	{"qup13_f2", 1},
> +	{"gpio", 0},
> +};
> +
> +#define SDC_PINGROUP(pg_name, ctl, pull, drv)		\
> +	{						\
> +		.name = pg_name,			\
> +		.ctl_reg = ctl,				\
> +		.io_reg = 0,				\
> +		.pull_bit = pull,			\
> +		.drv_bit = drv,				\
> +		.oe_bit = -1,				\
> +		.in_bit = -1,				\
> +		.out_bit = -1,				\
> +	}
> +
> +#define UFS_RESET(pg_name, offset)			\
> +	{						\
> +		.name = pg_name,			\
> +		.ctl_reg = offset,			\
> +		.io_reg = offset + 0x4,			\
> +		.pull_bit = 3,				\
> +		.drv_bit = 0,				\
> +		.oe_bit = -1,				\
> +		.in_bit = -1,				\
> +		.out_bit = 0,				\
> +	}
> +
> +static const struct msm_special_pin_data sm6350_special_pins_data[] = {
> +	[0] = UFS_RESET("ufs_reset", 0xae000),
> +	[1] = SDC_PINGROUP("sdc1_rclk", 0xa1000, 15, 0),
> +	[2] = SDC_PINGROUP("sdc1_clk", 0xa0000, 13, 6),
> +	[3] = SDC_PINGROUP("sdc1_cmd", 0xa0000, 11, 3),
> +	[4] = SDC_PINGROUP("sdc1_data", 0xa0000, 9, 0),
> +	[5] = SDC_PINGROUP("sdc2_clk", 0xa2000, 14, 6),
> +	[6] = SDC_PINGROUP("sdc2_cmd", 0xa2000, 11, 3),
> +	[7] = SDC_PINGROUP("sdc2_data", 0xa2000, 9, 0),
> +};
> +
> +static const char *sm6350_get_function_name(struct udevice *dev,
> +					    unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].name;
> +}
> +
> +static const char *sm6350_get_pin_name(struct udevice *dev,
> +				       unsigned int selector)
> +{
> +	if (selector >= 156 && selector <= 163)
> +		snprintf(pin_name, MAX_PIN_NAME_LEN,
> +			 sm6350_special_pins_data[selector - 156].name);
> +	else
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +
> +	return pin_name;
> +}
> +
> +static int sm6350_get_function_mux(__maybe_unused unsigned int pin,
> +				   unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].val;
> +}
> +
> +static struct msm_pinctrl_data sm6350_data = {
> +	.pin_data = {
> +		.pin_count = 164,
> +		.special_pins_start = 156,
> +		.special_pins_data = sm6350_special_pins_data,
> +	},
> +	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +	.get_function_name = sm6350_get_function_name,
> +	.get_function_mux = sm6350_get_function_mux,
> +	.get_pin_name = sm6350_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +	{ .compatible = "qcom,sm6350-tlmm", .data = (ulong)&sm6350_data },
> +	{ /* Sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_sm6350) = {
> +	.name		= "pinctrl_sm6350",
> +	.id		= UCLASS_NOP,
> +	.of_match	= msm_pinctrl_ids,
> +	.ops		= &msm_pinctrl_ops,
> +	.bind		= msm_pinctrl_bind,
> +};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
