Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47508EE499C
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 18:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E4F6892F2;
	Wed, 11 Sep 2024 20:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CRZx1Z27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDDC6892F5; Wed, 11 Sep 2024 20:05:26 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 982C28876E
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 20:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso248825e9.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726077921; x=1726682721; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=4tTWS5EueC6Hfbc7rmgP0c63AKFtwuOlNWJCUo7TKN8=;
 b=CRZx1Z27YCrNnRG+65MrrrrGswOJ1LT+IA6wkAY57tOvEXBA/I2aCNcZ4Smgw8QXqL
 k/wiTNVAighzoCLv2JJJ1PfSXKXvE405W5UFqWH7nDpnpvqPSkLs0aJ4sEaVxLWK5Jdp
 IYTJl0KVlPxJErZYUu1/qKQHeBETONCj+mDEcDb7QghSdqiL/eTD/3SwxCWH4hvZtdB9
 pP8ddu3G9S5Gw1pdKB0GdZUuLI3AUMgCQALYLqaFQASssCyDVPd6shRimcH3tiH6Zo0i
 8KoR2gg+wnYlR7ixhAf53B4r7TbhkDGPf4qB+Lqdy3DJXk0swaMm7xnTXbH+QzThTWUO
 nzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726077921; x=1726682721;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4tTWS5EueC6Hfbc7rmgP0c63AKFtwuOlNWJCUo7TKN8=;
 b=W+plqkTVy0kffC8NZYHwN94ljTTviaqGvpIvdr0PDlusVxM1hyJMLMedj78WKPYC0L
 3kQjO4nH/ea6yIgR2DiQIZPXg0s5D2knFqH8mCjupCx9jIHwQ3SA4skJMxSLCtn67rsf
 JjoARBP5tlnNl99Wf4Jhb7cNCKMGbjN3g9awsM64455UhtUWygnUNBGCM6hUMTcv3dGd
 BuikVRGEWd2xo0KwMNFiN5NHfrQlMbZCtJ+ig2oQ5mCJTgldT8MMu2u4pf/ICPXs1zTC
 aMIousEmlBGjkqVvb2Odz7DxuN0t4Jom80vhYQaVVYJkgWkf09DFkxMVTVAUOjChOryh
 EAOw==
X-Gm-Message-State: AOJu0YwxaoLoZg7FxPMMvuUYoAHWBkDBV5MZORCA1mTKwech0YU0KAE5
 uPO6Kw5ni+Ik8NXKASEGlDw2jHpNMxJCgeyErHOv4IA0Q7v3bKmG3vnBtjAuueY=
X-Google-Smtp-Source: AGHT+IH8oKwFdoE1KR0LG9z1bav9lhOlKhFfCOqr1H96P2Tn85bpYjnOwCsoF0SO+bI2/sk3pmnOGg==
X-Received: by 2002:a05:6000:1042:b0:374:ca4f:bd78 with SMTP id
 ffacd0b85a97d-378c2cfeb64mr45443f8f.10.1726077921282; 
 Wed, 11 Sep 2024 11:05:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1680:3625:e94b:7c21?
 ([2a01:e0a:982:cbb0:1680:3625:e94b:7c21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956dddacsm12058255f8f.107.2024.09.11.11.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 11:05:20 -0700 (PDT)
Message-ID: <655f667a-6d43-4737-b215-35e710b92b48@linaro.org>
Date: Wed, 11 Sep 2024 20:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 2/3] pinctrl: qcom: add driver for SM8150 SoC
To: Julius Lehmann <lehmanju@devpi.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
References: <20240911-sm8150-patches-v3-0-d9164b71316f@devpi.de>
 <20240911-sm8150-patches-v3-2-d9164b71316f@devpi.de>
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
In-Reply-To: <20240911-sm8150-patches-v3-2-d9164b71316f@devpi.de>
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

On 11/09/2024 19:13, Julius Lehmann wrote:
> Add pinctrl and GPIO driver for SM8150. Driver code is based on the
> similar U-Boot drivers. All constants are taken from the corresponding
> Linux driver. This drivers differs from the similar U-Boot drivers,
> because SM8150 SoC have different function IDs for the same functions
> on different pins.
> 
> Co-authored-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
> ---
>   drivers/pinctrl/qcom/Kconfig          |   8 ++
>   drivers/pinctrl/qcom/Makefile         |   1 +
>   drivers/pinctrl/qcom/pinctrl-sm8150.c | 156 ++++++++++++++++++++++++++++++++++
>   3 files changed, 165 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index b326fa8514..4f93a34281 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -55,6 +55,13 @@ config PINCTRL_QCOM_SM6115
>   	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
>   	  as well as the associated GPIO driver.
>   
> +config PINCTRL_QCOM_SM8150
> +	bool "Qualcomm SM8150 GCC"
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the Snapdragon SM8150 SoC,
> +	  as well as the associated GPIO driver.
> +
>   config PINCTRL_QCOM_SM8250
>   	bool "Qualcomm SM8250 GCC"
>   	select PINCTRL_QCOM
> @@ -74,6 +81,7 @@ config PINCTRL_QCOM_SM8650
>   	select PINCTRL_QCOM
>   	help
>   	  Say Y here to enable support for pinctrl on the Snapdragon SM8650 SoC,
> +	  as well as the associated GPIO driver.
>   
>   endmenu
>   
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 4f1d96787b..43d0dd2922 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
>   obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
>   obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
> +obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM8650) += pinctrl-sm8650.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8150.c b/drivers/pinctrl/qcom/pinctrl-sm8150.c
> new file mode 100644
> index 0000000000..1fb2ffb959
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8150.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Qualcomm SM8150 pinctrl and GPIO driver
> + *
> + * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> + * Copyright (c) 2024 EPAM Systems.
> + *
> + * (C) Copyright 2024 Julius Lehmann <lehmanju@devpi.de>
> + *
> + * Based on similar U-Boot drivers. Constants were taken from the Linux driver
> + */
> +
> +#include <dm.h>
> +
> +#include "pinctrl-qcom.h"
> +
> +#define WEST	0x100000
> +#define EAST	0x500000
> +#define NORTH	0x900000
> +#define SOUTH	0xd00000
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +static const struct pinctrl_function msm_pinctrl_functions[] = {
> +	{ "qup2", 1 },
> +	{ "gpio", 0 },
> +};
> +
> +static const unsigned int sm8150_pin_offsets[] = {
> +	[0]   = SOUTH, [1]   = SOUTH, [2]   = SOUTH, [3]   = SOUTH,
> +	[4]   = SOUTH, [5]   = SOUTH, [6]   = SOUTH, [7]   = SOUTH,
> +	[8]   = NORTH, [9]   = NORTH, [10]  = NORTH, [11]  = NORTH,
> +	[12]  = NORTH, [13]  = NORTH, [14]  = NORTH, [15]  = NORTH,
> +	[16]  = NORTH, [17]  = NORTH, [18]  = NORTH, [19]  = NORTH,
> +	[20]  = NORTH, [21]  = EAST,  [22]  = EAST,  [23]  = EAST,
> +	[24]  = EAST,  [25]  = EAST,  [26]  = EAST,  [27]  = EAST,
> +	[28]  = EAST,  [29]  = EAST,  [30]  = EAST,  [31]  = NORTH,
> +	[32]  = NORTH, [33]  = NORTH, [34]  = NORTH, [35]  = NORTH,
> +	[36]  = NORTH, [37]  = NORTH, [38]  = SOUTH, [39]  = NORTH,
> +	[40]  = NORTH, [41]  = NORTH, [42]  = NORTH, [43]  = EAST,
> +	[44]  = EAST,  [45]  = EAST,  [46]  = EAST,  [47]  = EAST,
> +	[48]  = EAST,  [49]  = EAST,  [50]  = EAST,  [51]  = SOUTH,
> +	[52]  = SOUTH, [53]  = SOUTH, [54]  = SOUTH, [55]  = SOUTH,
> +	[56]  = SOUTH, [57]  = SOUTH, [58]  = SOUTH, [59]  = SOUTH,
> +	[60]  = SOUTH, [61]  = SOUTH, [62]  = SOUTH, [63]  = SOUTH,
> +	[64]  = SOUTH, [65]  = SOUTH, [66]  = SOUTH, [67]  = SOUTH,
> +	[68]  = SOUTH, [69]  = SOUTH, [70]  = SOUTH, [71]  = SOUTH,
> +	[72]  = SOUTH, [73]  = SOUTH, [74]  = SOUTH, [75]  = SOUTH,
> +	[76]  = SOUTH, [77]  = SOUTH, [78]  = SOUTH, [79]  = SOUTH,
> +	[80]  = SOUTH, [81]  = SOUTH, [82]  = SOUTH, [83]  = NORTH,
> +	[84]  = NORTH, [85]  = NORTH, [86]  = NORTH, [87]  = EAST,
> +	[88]  = NORTH, [89]  = NORTH, [90]  = NORTH, [91]  = NORTH,
> +	[92]  = NORTH, [93]  = NORTH, [94]  = NORTH, [95]  = NORTH,
> +	[96]  = NORTH, [97]  = NORTH, [98]  = SOUTH, [99]  = SOUTH,
> +	[100] = SOUTH, [101] = SOUTH, [102] = NORTH, [103] = NORTH,
> +	[104] = NORTH, [105] = WEST,  [106] = WEST,  [107] = WEST,
> +	[108] = WEST,  [109] = WEST,  [110] = WEST,  [111] = WEST,
> +	[112] = WEST,  [113] = WEST,  [114] = SOUTH, [115] = SOUTH,
> +	[116] = SOUTH, [117] = SOUTH, [118] = SOUTH, [119] = SOUTH,
> +	[120] = SOUTH, [121] = SOUTH, [122] = SOUTH, [123] = SOUTH,
> +	[124] = SOUTH, [125] = WEST,  [126] = SOUTH, [127] = SOUTH,
> +	[128] = SOUTH, [129] = SOUTH, [130] = SOUTH, [131] = SOUTH,
> +	[132] = SOUTH, [133] = SOUTH, [134] = SOUTH, [135] = SOUTH,
> +	[136] = SOUTH, [137] = SOUTH, [138] = SOUTH, [139] = SOUTH,
> +	[140] = SOUTH, [141] = SOUTH, [142] = SOUTH, [143] = SOUTH,
> +	[144] = SOUTH, [145] = SOUTH, [146] = SOUTH, [147] = SOUTH,
> +	[148] = SOUTH, [149] = SOUTH, [150] = SOUTH, [151] = SOUTH,
> +	[152] = SOUTH, [153] = SOUTH, [154] = SOUTH, [155] = WEST,
> +	[156] = WEST,  [157] = WEST,  [158] = WEST,  [159] = WEST,
> +	[160] = WEST,  [161] = WEST,  [162] = WEST,  [163] = WEST,
> +	[164] = WEST,  [165] = WEST,  [166] = WEST,  [167] = WEST,
> +	[168] = WEST,  [169] = NORTH, [170] = NORTH, [171] = NORTH,
> +	[172] = NORTH, [173] = NORTH, [174] = NORTH,
> +};
> +
> +#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
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
> +#define UFS_RESET(pg_name, offset)        \
> +	{                                 \
> +		.name = pg_name,	  \
> +		.ctl_reg = offset,	  \
> +		.io_reg = offset + 0x04,  \
> +		.pull_bit = 3,		  \
> +		.drv_bit = 0,             \
> +		.oe_bit = -1,             \
> +		.in_bit = -1,             \
> +		.out_bit = 0,             \
> +	}
> +
> +static const struct msm_special_pin_data msm_special_pins_data[] = {
> +	[0] = UFS_RESET("ufs_reset", SOUTH + 0xb6000),
> +	[1] = SDC_QDSD_PINGROUP("sdc2_clk", NORTH + 0xb2000, 14, 6),
> +	[2] = SDC_QDSD_PINGROUP("sdc2_cmd", NORTH + 0xb2000, 11, 3),
> +	[3] = SDC_QDSD_PINGROUP("sdc2_data", NORTH + 0xb2000, 9, 0),
> +};
> +
> +static const char *sm8150_get_function_name(struct udevice *dev,
> +					    unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].name;
> +}
> +
> +static const char *sm8150_get_pin_name(struct udevice *dev,
> +				       unsigned int selector)
> +{
> +	if (selector >= 175 && selector <= 178)
> +		snprintf(pin_name, MAX_PIN_NAME_LEN,
> +			 msm_special_pins_data[selector - 175].name);
> +	else
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +
> +	return pin_name;
> +}
> +
> +static unsigned int sm8150_get_function_mux(__maybe_unused unsigned int pin,
> +					    unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].val;
> +}
> +
> +static struct msm_pinctrl_data sm8150_data = {
> +	.pin_data = {
> +		.pin_offsets = sm8150_pin_offsets,
> +		.pin_count = 179,
> +		.special_pins_start = 175,
> +		.special_pins_data = msm_special_pins_data,
> +	},
> +	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +	.get_function_name = sm8150_get_function_name,
> +	.get_function_mux = sm8150_get_function_mux,
> +	.get_pin_name = sm8150_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +	{ .compatible = "qcom,sm8150-pinctrl", .data = (ulong)&sm8150_data },
> +	{ /* Sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_sm8150) = {
> +	.name		= "pinctrl_sm8150",
> +	.id		= UCLASS_NOP,
> +	.of_match	= msm_pinctrl_ids,
> +	.ops		= &msm_pinctrl_ops,
> +	.bind		= msm_pinctrl_bind,
> +};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
