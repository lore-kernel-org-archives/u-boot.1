Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F87EC197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F999810F1;
	Thu, 27 Feb 2025 13:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WDnMYoK2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4354081026; Thu, 27 Feb 2025 13:10:48 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C95C7801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso5959095e9.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740658245; x=1741263045; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=tniRNlD2IOJpGGQplEDq6Rv7IFxxwvPZ2zkwNEtTKak=;
 b=WDnMYoK2NbzahK6orCInngglaBVgAVld4ILQa6s+k6nlo1KnnV6AmU8CA6ck4iMQnL
 2ruU5seFiTSjildGSUZzVNX7Q+BtdsT7XZ0a6sCn3OMFNBCkuzKE5/CDQTVuflX7Qi/H
 wa5R53dhjtoHPFMC8UrGE0dAWbgG6BeLhGMBAT/+KvxlnBJxY4x/dFRWYkA7H9z1zEJF
 BZ3ILdIPWE+RoWuchV48IMeF2j3v2XeC/yEW/3LWgmbT7mB4b0fdzsFrediT9wbuDJ2j
 25SUf2OXtFpcJCDBDGTmZ0OedUDClcxL6MnX0ePpjnKamu0ZNK/xCcNLCBYvxu9KUPRV
 ohbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740658245; x=1741263045;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tniRNlD2IOJpGGQplEDq6Rv7IFxxwvPZ2zkwNEtTKak=;
 b=ZR5EJH8wHA103KO9TliZhavUwyY/979kscQwDuUwmHXWMhn+sC82jZi1iOAVo8xE1j
 JBJPWLL2Iz8prVa9ZKzuQ0E8p1wn9DYLuJANz/zgmeE/uoc3r4rr06+NnNT8c9vFUExF
 Dg+KXM5mrqSNwB+CjiuJIXNtrg0fGyC7Ndf9qJUSYyr0hFybDNcPel3yx17+azoBz+yh
 29H8VTOeJWxerx3f9JCOptSOvobV2fJcNrHfBiVgJwqKzhtXKys8/ilUdIKahnzO4WIO
 2G52NzrbVSjku+ZLTpIIZJnegkta2BI2ikQB9YI08288QONMInkuD0TpkTL4mRNV8AOq
 2iQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjmd/7E/b+DBsKyk14YXsvD9i0Zxw9G4nyE5H6QJDOnagILQD5ImMGqn2sBMPIYSI3tsM00hk=@lists.denx.de
X-Gm-Message-State: AOJu0Ywjw2tEMBs7/Ag6fEiZrIFG5pymKQOVWUi6wlBFRlSWP961iwjV
 8xi4PHAbj45Aizm547lVk3y6tC3jJNT4yJuYlJSaiSMm3REBr8sca+7ezqP3ejdf65rT/qNDgHh
 C
X-Gm-Gg: ASbGncu7S7fSnwAIUwd1WGQ1w6x0BWYIT0xzslAowVhhWSXsgCrXnRnVy2A8OMkQPZ7
 ZBo/gVf1WmwsLS3mykbOlUH4P5WX9Yrt73fYGxio0+rk/dFZx/JAouNJMofuMno8jrR68uEYUA4
 TUc0Y3F27m/0jqa4Ze4cJSAnBCTfLNVhCdVbq9Qfm5QvsucB9re7h2QuIWVZkiNe1oV0iEU66xB
 tGK9idB0LG1aATB7tB7KrPl/KY4QTFwQzf5n8/nrDMEavA+BSZ6YDggfF/ohg0l3MUWtGWObf5F
 coxpijrEPXmXwaIyAK37eS5/zvdWAcZmI3hIC+EHuMX61bOdfpmlGVzG0rlGwm+SfmSMFyB1WRJ
 DQuI=
X-Google-Smtp-Source: AGHT+IFj8a8HsRwTe6Y8ksV64yk/GUXVk6CaDQFeBbrOsXwDCXel1a0ffpcm27C8AtW1M+Qjsza9sQ==
X-Received: by 2002:a05:600c:19cd:b0:439:8340:637 with SMTP id
 5b1f17b1804b1-43ab0fa248bmr111716445e9.30.1740658245224; 
 Thu, 27 Feb 2025 04:10:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5de:e7f3:73c7:7958?
 ([2a01:e0a:982:cbb0:c5de:e7f3:73c7:7958])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b694524c6sm21891215e9.0.2025.02.27.04.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 04:10:44 -0800 (PST)
Message-ID: <d54aaaa1-953d-4994-ac5d-01d8a73899b2@linaro.org>
Date: Thu, 27 Feb 2025 13:10:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 03/15] pinctrl: qcom: Add driver for sc7180
To: Stephen Boyd <swboyd@chromium.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
References: <20250226221607.1283592-1-swboyd@chromium.org>
 <20250226221607.1283592-4-swboyd@chromium.org>
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
In-Reply-To: <20250226221607.1283592-4-swboyd@chromium.org>
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

Hi,

On 26/02/2025 23:15, Stephen Boyd wrote:
> Add a driver for Qualcomm's sc7180 pinctrl device (TLMM). This is
> largely a copy of a similar driver in U-Boot along with reference to the
> Linux driver to fix up the data properly.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/pinctrl/qcom/Kconfig          |   7 ++
>   drivers/pinctrl/qcom/Makefile         |   1 +
>   drivers/pinctrl/qcom/pinctrl-sc7180.c | 106 ++++++++++++++++++++++++++
>   3 files changed, 114 insertions(+)
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7180.c
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index d3eb69985510..4772daba1ef3 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -41,6 +41,13 @@ config PINCTRL_QCOM_QCS404
>   	  Say Y here to enable support for pinctrl on the Snapdragon QCS404 SoC,
>   	  as well as the associated GPIO driver.
>   
> +config PINCTRL_QCOM_SC7180
> +	bool "Qualcomm SC7180 Pinctrl (TLMM)"
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the Snapdragon SC7180 SoC,
> +	  as well as the associated GPIO driver.
> +
>   config PINCTRL_QCOM_SDM845
>   	bool "Qualcomm SDM845 GCC"
>   	select PINCTRL_QCOM
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 06d3c95f93a6..ac5dfd1feb91 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
>   obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
>   obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
>   obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
> +obj-$(CONFIG_PINCTRL_QCOM_SC7180) += pinctrl-sc7180.o
>   obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7180.c b/drivers/pinctrl/qcom/pinctrl-sc7180.c
> new file mode 100644
> index 000000000000..1edc74e5da95
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sc7180.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm SC7180 pinctrl
> + */
> +
> +#include <dm.h>
> +
> +#include "pinctrl-qcom.h"
> +
> +#define WEST	0x00000000
> +#define NORTH	0x00400000
> +#define SOUTH	0x00800000
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +static const struct pinctrl_function msm_pinctrl_functions[] = {
> +	{"qup12", 1},
> +	{"gpio", 0},
> +};
> +
> +static const unsigned int sc7180_pin_offsets[] = {
> +	[0] = SOUTH, [1] = SOUTH, [2] = SOUTH, [3] = SOUTH, [4] = NORTH,
> +	[5] = NORTH, [6] = NORTH, [7] = NORTH, [8] = NORTH, [9] = NORTH,
> +	[10] = NORTH, [11] = NORTH, [12] = SOUTH, [13] = SOUTH, [14] = SOUTH,
> +	[15] = SOUTH, [16] = SOUTH, [17] = SOUTH, [18] = SOUTH, [19] = SOUTH,
> +	[20] = SOUTH, [21] = NORTH, [22] = NORTH, [23] = SOUTH, [24] = SOUTH,
> +	[25] = SOUTH, [26] = SOUTH, [27] = SOUTH, [28] = SOUTH, [29] = NORTH,
> +	[30] = SOUTH, [31] = NORTH, [32] = NORTH, [33] = NORTH, [34] = SOUTH,
> +	[35] = SOUTH, [36] = SOUTH, [37] = SOUTH, [38] = SOUTH, [39] = SOUTH,
> +	[40] = SOUTH, [41] = SOUTH, [42] = NORTH, [43] = NORTH, [44] = NORTH,
> +	[45] = NORTH, [46] = NORTH, [47] = NORTH, [48] = NORTH, [49] = WEST,
> +	[50] = WEST, [51] = WEST, [52] = WEST, [53] = WEST, [54] = WEST,
> +	[55] = WEST, [56] = WEST, [57] = WEST, [58] = WEST, [59] = NORTH,
> +	[60] = NORTH, [61] = NORTH, [62] = NORTH, [63] = NORTH, [64] = NORTH,
> +	[65] = NORTH, [66] = NORTH, [67] = NORTH, [68] = NORTH, [69] = WEST,
> +	[70] = NORTH, [71] = NORTH, [72] = NORTH, [73] = WEST, [74] = WEST,
> +	[75] = WEST, [76] = WEST, [77] = WEST, [78] = WEST, [79] = WEST,
> +	[80] = WEST, [81] = WEST, [82] = WEST, [83] = WEST, [84] = WEST,
> +	[85] = WEST, [86] = NORTH, [87] = NORTH, [88] = NORTH, [89] = NORTH,
> +	[90] = NORTH, [91] = NORTH, [92] = NORTH, [93] = NORTH, [94] = SOUTH,
> +	[95] = WEST, [96] = WEST, [97] = WEST, [98] = WEST, [99] = WEST,
> +	[100] = WEST, [101] = NORTH, [102] = NORTH, [103] = NORTH, [104] = WEST,
> +	[105] = NORTH, [106] = NORTH, [107] = WEST, [108] = SOUTH, [109] = SOUTH,
> +	[110] = NORTH, [111] = NORTH, [112] = NORTH, [113] = NORTH, [114] = NORTH,
> +	[115] = WEST, [116] = WEST, [117] = WEST, [118] = WEST,
> +};
> +
> +static const char *sc7180_get_function_name(struct udevice *dev,
> +					     unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].name;
> +}
> +
> +static const char *sc7180_get_pin_name(struct udevice *dev,
> +					unsigned int selector)
> +{
> +	static const char * const special_pins_names[] = {
> +		"ufs_reset",
> +		"sdc1_rclk",
> +		"sdc1_clk",
> +		"sdc1_cmd",
> +		"sdc1_data",
> +		"sdc2_clk",
> +		"sdc2_cmd",
> +		"sdc2_data",
> +	};
> +
> +	if (selector >= 119 && selector <= 126)
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 119]);
> +	else
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +
> +	return pin_name;
> +}
> +
> +static unsigned int sc7180_get_function_mux(__maybe_unused unsigned int pin,
> +					    unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].val;
> +}
> +
> +static const struct msm_pinctrl_data sc7180_data = {
> +	.pin_data = {
> +		.pin_offsets = sc7180_pin_offsets,
> +		.pin_count = 127,
> +		.special_pins_start = 119,

Could you implement the special_pins_data so the sdc and ufs pins can be used ?

=> https://elixir.bootlin.com/u-boot/v2025.01/source/drivers/pinctrl/qcom/pinctrl-sm8650.c#L45

> +	},
> +	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +	.get_function_name = sc7180_get_function_name,
> +	.get_function_mux = sc7180_get_function_mux,
> +	.get_pin_name = sc7180_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +	{ .compatible = "qcom,sc7180-pinctrl", .data = (ulong)&sc7180_data },
> +	{ /* Sentinal */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_sc7180) = {
> +	.name		= "pinctrl_sc7180",
> +	.id		= UCLASS_NOP,
> +	.of_match	= msm_pinctrl_ids,
> +	.ops		= &msm_pinctrl_ops,
> +	.bind		= msm_pinctrl_bind,
> +};

