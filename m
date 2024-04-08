Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321ADC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 960A687F78;
	Mon,  8 Apr 2024 15:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sqtk8zYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC6D18808D; Mon,  8 Apr 2024 15:16:42 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC7887D08
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41693741eceso1412925e9.3
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712582200; x=1713187000; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=qKuT+usC2O0AihMVxRuPc/+uJFqGIXBIcRmUiK8iyfA=;
 b=Sqtk8zYz6mGhRjV0CE2bt/WFCRdJQmVBxC+k+W29HuDuWS6gQJj4GEpNU5+eH49iYI
 HjNICdojUfLX6P+QnoAAE6OpwAEYxnogSIrb2O69IEm80WgRMTLntvIi/JHtQd6SzdsM
 DqGU50NhRsJ4VmvCZ2r2y/98dgHnpmrMdhf4ue0BUIGCiPu10h4GXvZFLmchAkF9RPwF
 eg+17ghL2U8TH+gcsHCOFd9nCLtF0Bezi5BkNFZAOc7DSyHobVaZXewEr3f3PfmtxHeU
 FVJ6rSCRHOPv9SCfiIY6FilFRXDn+ODF6Q6KIkuL3kRfCd+qehiKkGI81Dv8YIpB1Z/P
 IXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712582200; x=1713187000;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qKuT+usC2O0AihMVxRuPc/+uJFqGIXBIcRmUiK8iyfA=;
 b=XJ9lXkEJQ38STfOMhdBFMV+L+csWc2dgjajTwGj1IoU2B9Px8SK9iyNqiG/H4TMQG0
 ACUSPAdUpom9tLY1wQYuChnr/Tod5Ekoa9rQGAXC1/hkIRBDiX92BINJDtBK+XjI5VNd
 zuKIGCyoBRIfKl8z70+EGgopVzEQB6PHV8JdPan3zQ7Ir5fNU6AxXTjoY9EmssgUSD4T
 6FrVjWtH04DP88iu+gfTlF0ustJ/9TqSETMAOibTZbDHDJ2LVEK2sbhJbMWi+dUkIMpx
 c8Ktntn+1uDnMC9AsvwNMJOph7pvvBQqQ7hfErLwJbMuzw7qPG4ZQj4ASUwcxkCo3wQ/
 XcMw==
X-Gm-Message-State: AOJu0Yxoc/GJtSYwvSO+v7O6BA6OhkhmzcvP9tcbZO1vK5zC0GHi2IKZ
 x/GFuakRN/TKWVQcxC80sB1N0Jf4k3zLMW+t6WkVKp8BSxzlQZHWdr2sFPzIeT4=
X-Google-Smtp-Source: AGHT+IEnXeT1nY3fk9ulLGYBWWC7RIpu4XO9f/EkimPmLgS5aPpnqFAOGYWKb99cTZEat5bZ2u6xAQ==
X-Received: by 2002:a05:600c:3b97:b0:416:6a35:cd1a with SMTP id
 n23-20020a05600c3b9700b004166a35cd1amr1940754wms.13.1712582199842; 
 Mon, 08 Apr 2024 06:16:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b0c8:7091:4315:491e?
 ([2a01:e0a:982:cbb0:b0c8:7091:4315:491e])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a05600c3b0600b0041668162b45sm4462643wms.26.2024.04.08.06.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 06:16:39 -0700 (PDT)
Message-ID: <e7383615-8a11-4d7e-bd3f-e7a6c68aeabe@linaro.org>
Date: Mon, 8 Apr 2024 15:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/4] pinctrl: qcom: add sm8250 pinctrl driver
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org>
 <20240408-b4-qcom-rbx-soc-v1-3-900db37b8bdf@linaro.org>
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
In-Reply-To: <20240408-b4-qcom-rbx-soc-v1-3-900db37b8bdf@linaro.org>
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

On 08/04/2024 15:07, Caleb Connolly wrote:
> This SoC features a pinctrl block with north, south, and west tiles
> accessible to the AP.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/pinctrl/qcom/Kconfig          |  7 +++
>   drivers/pinctrl/qcom/Makefile         |  1 +
>   drivers/pinctrl/qcom/pinctrl-sm8250.c | 96 +++++++++++++++++++++++++++++++++++
>   3 files changed, 104 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index e7a9853ce47a..33c355ad3b24 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -54,7 +54,14 @@ config PINCTRL_QCOM_SM6115
>   	help
>   	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
>   	  as well as the associated GPIO driver.
>   
> +config PINCTRL_QCOM_SM8250
> +	bool "Qualcomm SM8250 GCC"
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the Snapdragon SM8250 SoC,
> +	  as well as the associated GPIO driver.
> +
>   endmenu
>   
>   endif
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index f00c4e6e10cc..7dce95e5acb2 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -9,4 +9,5 @@ obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
>   obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
>   obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
>   obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
> +obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
> \ No newline at end of file
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250.c b/drivers/pinctrl/qcom/pinctrl-sm8250.c
> new file mode 100644
> index 000000000000..1a9d4534fa12
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8250.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm sm8250 pinctrl
> + *
> + * (C) Copyright 2024 Linaro Ltd.
> + *
> + */
> +
> +#include <dm.h>
> +
> +#include "pinctrl-qcom.h"
> +
> +#define WEST 0x00000000
> +#define SOUTH 0x00400000
> +#define NORTH 0x00800000
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +static const struct pinctrl_function msm_pinctrl_functions[] = { { "qup12", 1 },
> +								 { "gpio", 0 },
> +								 {
> +									 "sdc2_clk",
> +								 } };
> +
> +static const unsigned int sm8250_pin_offsets[] = {
> +	[0] = SOUTH,   [1] = SOUTH,   [2] = SOUTH,   [3] = SOUTH,   [4] = NORTH,   [5] = NORTH,
> +	[6] = NORTH,   [7] = NORTH,   [8] = NORTH,   [9] = NORTH,   [10] = NORTH,  [11] = NORTH,
> +	[12] = NORTH,  [13] = NORTH,  [14] = NORTH,  [15] = NORTH,  [16] = NORTH,  [17] = NORTH,
> +	[18] = NORTH,  [19] = NORTH,  [20] = NORTH,  [21] = NORTH,  [22] = NORTH,  [23] = NORTH,
> +	[24] = SOUTH,  [25] = SOUTH,  [26] = SOUTH,  [27] = SOUTH,  [28] = NORTH,  [29] = NORTH,
> +	[30] = NORTH,  [31] = NORTH,  [32] = SOUTH,  [33] = SOUTH,  [34] = SOUTH,  [35] = SOUTH,
> +	[36] = SOUTH,  [37] = SOUTH,  [38] = SOUTH,  [39] = SOUTH,  [40] = SOUTH,  [41] = SOUTH,
> +	[42] = SOUTH,  [43] = SOUTH,  [44] = SOUTH,  [45] = SOUTH,  [46] = SOUTH,  [47] = SOUTH,
> +	[48] = SOUTH,  [49] = SOUTH,  [50] = SOUTH,  [51] = SOUTH,  [52] = SOUTH,  [53] = SOUTH,
> +	[54] = SOUTH,  [55] = SOUTH,  [56] = SOUTH,  [57] = SOUTH,  [58] = SOUTH,  [59] = SOUTH,
> +	[60] = SOUTH,  [61] = SOUTH,  [62] = SOUTH,  [63] = SOUTH,  [64] = SOUTH,  [65] = SOUTH,
> +	[66] = NORTH,  [67] = NORTH,  [68] = NORTH,  [69] = SOUTH,  [70] = SOUTH,  [71] = SOUTH,
> +	[72] = SOUTH,  [73] = SOUTH,  [74] = SOUTH,  [75] = SOUTH,  [76] = SOUTH,  [77] = NORTH,
> +	[78] = NORTH,  [79] = NORTH,  [80] = NORTH,  [81] = NORTH,  [82] = NORTH,  [83] = NORTH,
> +	[84] = NORTH,  [85] = SOUTH,  [86] = SOUTH,  [87] = SOUTH,  [88] = SOUTH,  [89] = SOUTH,
> +	[90] = SOUTH,  [91] = SOUTH,  [92] = NORTH,  [93] = NORTH,  [94] = NORTH,  [95] = NORTH,
> +	[96] = NORTH,  [97] = NORTH,  [98] = NORTH,  [99] = NORTH,  [100] = NORTH, [101] = NORTH,
> +	[102] = NORTH, [103] = NORTH, [104] = NORTH, [105] = NORTH, [106] = NORTH, [107] = NORTH,
> +	[108] = NORTH, [109] = NORTH, [110] = NORTH, [111] = NORTH, [112] = NORTH, [113] = NORTH,
> +	[114] = NORTH, [115] = NORTH, [116] = NORTH, [117] = NORTH, [118] = NORTH, [119] = NORTH,
> +	[120] = NORTH, [121] = NORTH, [122] = NORTH, [123] = NORTH, [124] = NORTH, [125] = SOUTH,
> +	[126] = SOUTH, [127] = SOUTH, [128] = SOUTH, [129] = SOUTH, [130] = SOUTH, [131] = SOUTH,
> +	[132] = SOUTH, [133] = WEST,  [134] = WEST,  [135] = WEST,  [136] = WEST,  [137] = WEST,
> +	[138] = WEST,  [139] = WEST,  [140] = WEST,  [141] = WEST,  [142] = WEST,  [143] = WEST,
> +	[144] = WEST,  [145] = WEST,  [146] = WEST,  [147] = WEST,  [148] = WEST,  [149] = WEST,
> +	[150] = WEST,  [151] = WEST,  [152] = WEST,  [153] = WEST,  [154] = WEST,  [155] = WEST,
> +	[156] = WEST,  [157] = WEST,  [158] = WEST,  [159] = WEST,  [160] = WEST,  [161] = WEST,
> +	[162] = WEST,  [163] = WEST,  [164] = WEST,  [165] = WEST,  [166] = WEST,  [167] = WEST,
> +	[168] = WEST,  [169] = WEST,  [170] = WEST,  [171] = WEST,  [172] = WEST,  [173] = WEST,
> +	[174] = WEST,  [175] = WEST,  [176] = WEST,  [177] = WEST,  [178] = WEST,  [179] = WEST,
> +};
> +
> +static const char *sm8250_get_function_name(struct udevice *dev, unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].name;
> +}
> +
> +static const char *sm8250_get_pin_name(struct udevice *dev, unsigned int selector)
> +{
> +	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +	return pin_name;
> +}
> +
> +static unsigned int sm8250_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].val;
> +}
> +
> +static struct msm_pinctrl_data sm8250_data = {
> +	.pin_data = {
> +		.pin_offsets = sm8250_pin_offsets,
> +		.pin_count = ARRAY_SIZE(sm8250_pin_offsets),
> +	},
> +	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +	.get_function_name = sm8250_get_function_name,
> +	.get_function_mux = sm8250_get_function_mux,
> +	.get_pin_name = sm8250_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = { { .compatible = "qcom,sm8250-pinctrl",
> +						       .data = (ulong)&sm8250_data },
> +						     { /* Sentinal */ } };


You may also want to fix aligment here and s/Sentinal/Sentinel/

> +
> +U_BOOT_DRIVER(pinctrl_sm8250) = {
> +	.name = "pinctrl_sm8250",
> +	.id = UCLASS_NOP,
> +	.of_match = msm_pinctrl_ids,
> +	.ops = &msm_pinctrl_ops,
> +	.bind = msm_pinctrl_bind,
> +};
> 

