Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88C1CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A2D7834D4;
	Tue, 30 Sep 2025 20:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fJwW5lRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7AB8352B; Tue, 30 Sep 2025 20:44:12 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 977A8800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so44473885e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257850; x=1759862650; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=J9zi4EpVYL41I8Is1EeDZEGN5nRi4tSkQJ0lqIG5lHQ=;
 b=fJwW5lRCJZQspLgzUeQmuOu1MrpRFa+BdI9uvB7bkOS8C9ushjFkpyq6Doqp58NIEh
 uM4Y8fVvHohG5vEiigoH2ExOvRSHtTMRj7amff7rgVw0z0SDKIt9Z6Y8WGmKjA7X+mdg
 W+WGic48324UWrsHtrJ2/swOoOB2DMOVW19Pvtd1/xwKqFnb+DWvBETmgoQ7+3WHX0ja
 z/2a9+NKXYEa8smEdgBCkmHGIcDdkZlqikOCr0ywYilOleuvxqAneBS3P81PdaUDvTeN
 McEJXqCOxUP4iWP7Eci6xHMFNdA7oOiN50AcbLHZBavoLLCQrzXhWs/vp2QvRsAcoh5S
 A4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257850; x=1759862650;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=J9zi4EpVYL41I8Is1EeDZEGN5nRi4tSkQJ0lqIG5lHQ=;
 b=pROkvJvHCGr1+XnYG3+76FXccwIoaDHn2GONCfM8xfxmfbALPp+4NQ8VnwJBSLYSUA
 4/t3DdbhWWjLo0oND5WIWwPcKrrO3TA/LeuQGJsClTpJz/B6gMMMMJQWgkouT1/NPe/A
 jhly5iPaUFjBYHbpHuQzmHt8B1/bcYTxRzJrhPupwdM8MZ91hL/Upry7zh4odJem6GxS
 v4xmNTLziroQPQts+ErPUawzHBYaJJoQnYby5ZnWYNDcGujj1JLBjbtpVi86XMQor88Y
 q9z4zbIsN9hQ0vr0K7417jdTsWRZD9cP0sPACcZk+1v11n31SiJ/CwCT8P/zY236r/8U
 5Uvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV5TfEvTKlgvIiGZzBK/NbdZvuoNH0enznKm8UAEybzDe6buJ4Ky31g61dBjXVVBhZrY/agg8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxv5LcRC8RSfSS3fY1v88OAdKly6ml0sNySQGq0OEq8mLmADSG3
 zjs9pADA0DO9TP3Lldm9LRnHf11WGMdu5+Jl5VPMEOvp83tGkROejzPJO8gKymwJyhM=
X-Gm-Gg: ASbGncseyd9AdABWsh+e7LpTLGbE6doBDyDGkAtGlvoDTDiNVBKRBvchRFy2F0pr71T
 /yrftvuoWDekn5XPjhspIsszVjX9VZLJhtRU4RzweLXc57hH3PAJxjEyH8Ck5Rk5/1icOPusKLW
 rRPOYCGv3RJiTKCxMHGU8EdpVvXxe8Wi8NgDNYfWkQKR86V+aJ/oYXnNo+SOAYooohNemv3ciBI
 nm2Nu6D2n2+Lsk5Sjw3phmoMcQmMcXdHCDzoxD6EHWNz9DB6o0WPU8Nz82qtb4Ny2Z/cdV+gc3G
 gIwBihSjFEefnO+BupPourcScTmgdKuQNPBGHNeO1I6omGupcGonKnb0ISDpqb3PkJhKErakzM4
 ApOeSId4NI1khX7OaTt4aYndVeJ8U80oi97DrdWC4n/tde6M57tWwT0biYOds1YHVbQLhsc0zut
 GyTaO4NxcNpGqR8epwD/3RM4fJLfEUlk6Ppg==
X-Google-Smtp-Source: AGHT+IFW+emqdIn4Rkpm7AaW+vxTtjnE4UXhbO5znTRDTljNHYDjpLscKaLQIixGK/zn0b55HPW0gA==
X-Received: by 2002:a05:600c:4510:b0:46e:330a:1762 with SMTP id
 5b1f17b1804b1-46e612bc400mr6531745e9.22.1759257849815; 
 Tue, 30 Sep 2025 11:44:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619ae806sm4885325e9.17.2025.09.30.11.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:44:09 -0700 (PDT)
Message-ID: <73d636a6-bab6-461f-80bc-f31f508e522b@linaro.org>
Date: Tue, 30 Sep 2025 20:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/5] pinctrl: qcom: add sdm670 pinctrl driver
To: David Wronek <david.wronek@mainlining.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250914-sdm670-v1-0-a344024062ab@mainlining.org>
 <20250914-sdm670-v1-3-a344024062ab@mainlining.org>
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
In-Reply-To: <20250914-sdm670-v1-3-a344024062ab@mainlining.org>
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

On 9/14/25 11:42, David Wronek wrote:
> Add a pinctrl driver for the TLMM block found in the SDM670 SoC.
> 
> Signed-off-by: David Wronek <david.wronek@mainlining.org>
> ---
>   drivers/pinctrl/qcom/Kconfig          |   7 +
>   drivers/pinctrl/qcom/Makefile         |   1 +
>   drivers/pinctrl/qcom/pinctrl-sdm670.c | 252 ++++++++++++++++++++++++++++++++++
>   3 files changed, 260 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 21f81b6609910c06b83941633481d69c7b0a491f..45f900e93833a0bac900f60e0577fc1b8c8b630c 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -68,6 +68,13 @@ config PINCTRL_QCOM_SC7280
>   	help
>   	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
>   
> +config PINCTRL_QCOM_SDM670
> +	bool "Qualcomm SDM670 Pinctrl"
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the Snapdragon SDM670 SoC,
> +	  as well as the associated GPIO driver.
> +
>   config PINCTRL_QCOM_SDM660
>   	bool "Qualcomm SDM630/660 Pinctrl"
>   	select PINCTRL_QCOM
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 6cb53838e71b8075b359cf7890e5174223d54b5c..f43868363d633c45ff14471d016a1e4768a7f77c 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
>   obj-$(CONFIG_PINCTRL_QCOM_SA8775P) += pinctrl-sa8775p.o
>   obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
>   obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
> +obj-$(CONFIG_PINCTRL_QCOM_SDM670) += pinctrl-sdm670.o
>   obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm670.c b/drivers/pinctrl/qcom/pinctrl-sdm670.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ec3ae226141ed73c8dc7605626e10488da54d420
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm670.c
> @@ -0,0 +1,252 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm SDM670 pinctrl
> + *
> + * (C) Copyright 2025 David Wronek <david.wronek@mainlining.org>
> + */
> +
> +#include <dm.h>
> +#include "pinctrl-qcom.h"
> +
> +#define NORTH	0x00500000
> +#define SOUTH	0x00900000
> +#define WEST	0x00100000
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +static const struct pinctrl_function sdm670_pinctrl_functions[] = {
> +	{ "gpio", 0 },
> +	{ "blsp_uart2", 3 }, /* gpio 4 and 5, used for debug uart */
> +};
> +
> +static const unsigned int sdm670_pin_offsets[] = {
> +	[0] = SOUTH,
> +	[1] = SOUTH,
> +	[2] = SOUTH,
> +	[3] = SOUTH,
> +	[4] = NORTH,
> +	[5] = NORTH,
> +	[6] = NORTH,
> +	[7] = NORTH,
> +	[8] = WEST,
> +	[9] = WEST,
> +	[10] = NORTH,
> +	[11] = NORTH,
> +	[12] = SOUTH,
> +	[13] = WEST,
> +	[14] = WEST,
> +	[15] = WEST,
> +	[16] = WEST,
> +	[17] = WEST,
> +	[18] = WEST,
> +	[19] = WEST,
> +	[20] = WEST,
> +	[21] = WEST,
> +	[22] = WEST,
> +	[23] = WEST,
> +	[24] = WEST,
> +	[25] = WEST,
> +	[26] = WEST,
> +	[27] = WEST,
> +	[28] = WEST,
> +	[29] = WEST,
> +	[30] = WEST,
> +	[31] = WEST,
> +	[32] = WEST,
> +	[33] = WEST,
> +	[34] = WEST,
> +	[35] = NORTH,
> +	[36] = NORTH,
> +	[37] = NORTH,
> +	[38] = NORTH,
> +	[39] = NORTH,
> +	[40] = NORTH,
> +	[41] = SOUTH,
> +	[42] = SOUTH,
> +	[43] = SOUTH,
> +	[44] = SOUTH,
> +	[45] = SOUTH,
> +	[46] = SOUTH,
> +	[47] = SOUTH,
> +	[48] = SOUTH,
> +	[49] = NORTH,
> +	[50] = NORTH,
> +	[51] = NORTH,
> +	[52] = NORTH,
> +	[53] = NORTH,
> +	[54] = NORTH,
> +	[55] = NORTH,
> +	[56] = NORTH,
> +	[57] = NORTH,
> +	[65] = NORTH,
> +	[66] = NORTH,
> +	[67] = NORTH,
> +	[68] = NORTH,
> +	[75] = NORTH,
> +	[76] = NORTH,
> +	[77] = NORTH,
> +	[78] = NORTH,
> +	[79] = NORTH,
> +	[80] = NORTH,
> +	[81] = NORTH,
> +	[82] = NORTH,
> +	[83] = NORTH,
> +	[84] = NORTH,
> +	[85] = SOUTH,
> +	[86] = SOUTH,
> +	[87] = SOUTH,
> +	[88] = SOUTH,
> +	[89] = SOUTH,
> +	[90] = SOUTH,
> +	[91] = SOUTH,
> +	[92] = SOUTH,
> +	[93] = SOUTH,
> +	[94] = SOUTH,
> +	[95] = SOUTH,
> +	[96] = SOUTH,
> +	[97] = WEST,
> +	[98] = WEST,
> +	[99] = NORTH,
> +	[100] = WEST,
> +	[101] = WEST,
> +	[102] = WEST,
> +	[103] = WEST,
> +	[105] = NORTH,
> +	[106] = NORTH,
> +	[107] = NORTH,
> +	[108] = NORTH,
> +	[109] = NORTH,
> +	[110] = NORTH,
> +	[111] = NORTH,
> +	[112] = NORTH,
> +	[113] = NORTH,
> +	[114] = WEST,
> +	[115] = WEST,
> +	[116] = SOUTH,
> +	[117] = NORTH,
> +	[118] = NORTH,
> +	[119] = NORTH,
> +	[120] = NORTH,
> +	[121] = NORTH,
> +	[122] = NORTH,
> +	[123] = NORTH,
> +	[124] = NORTH,
> +	[125] = NORTH,
> +	[126] = NORTH,
> +	[127] = WEST,
> +	[128] = WEST,
> +	[129] = WEST,
> +	[130] = WEST,
> +	[131] = WEST,
> +	[132] = WEST,
> +	[133] = NORTH,
> +	[134] = NORTH,
> +	[135] = WEST,
> +	[136] = WEST,
> +	[137] = WEST,
> +	[138] = WEST,
> +	[139] = WEST,
> +	[140] = WEST,
> +	[141] = WEST,
> +	[142] = WEST,
> +	[143] = WEST,
> +	[144] = SOUTH,
> +	[145] = SOUTH,
> +	[146] = WEST,
> +	[147] = WEST,
> +	[148] = WEST,
> +	[149] = WEST,
> +};
> +
> +#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
> +{							\
> +	.name = pg_name,				\
> +	.ctl_reg = ctl,					\
> +	.io_reg = 0,					\
> +	.pull_bit = pull,				\
> +	.drv_bit = drv,					\
> +	.oe_bit = -1,					\
> +	.in_bit = -1,					\
> +	.out_bit = -1,					\
> +}
> +
> +#define UFS_RESET(pg_name, offset)			\
> +{							\
> +	.name = pg_name,				\
> +	.ctl_reg = offset,				\
> +	.io_reg = offset + 0x4,				\
> +	.pull_bit = 3,					\
> +	.drv_bit = 0,					\
> +	.oe_bit = -1,					\
> +	.in_bit = -1,					\
> +	.out_bit = 0,					\
> +}
> +
> +static const struct msm_special_pin_data sdm670_special_pins_data[] = {
> +	UFS_RESET("ufs_reset", 0x99d000),
> +	SDC_QDSD_PINGROUP("sdc1_rclk", NORTH + 0x99000, 15, 0),
> +	SDC_QDSD_PINGROUP("sdc1_clk",  NORTH + 0x99000, 13, 6),
> +	SDC_QDSD_PINGROUP("sdc1_cmd",  NORTH + 0x99000, 11, 3),
> +	SDC_QDSD_PINGROUP("sdc1_data", NORTH + 0x99000, 9,  0),
> +	SDC_QDSD_PINGROUP("sdc2_clk",  NORTH + 0x9a000, 14, 6),
> +	SDC_QDSD_PINGROUP("sdc2_cmd",  NORTH + 0x9a000, 11, 3),
> +	SDC_QDSD_PINGROUP("sdc2_data", NORTH + 0x9a000, 9,  0),
> +};
> +
> +static const char *sdm670_get_function_name(struct udevice *dev, unsigned int selector)
> +{
> +	return sdm670_pinctrl_functions[selector].name;
> +}
> +
> +static const char *sdm670_get_pin_name(struct udevice *dev, unsigned int selector)
> +{
> +	static const char * const special_pins_names[] = {
> +		"ufs_reset",
> +		"sdc1_rclk", "sdc1_clk", "sdc1_cmd", "sdc1_data",
> +		"sdc2_clk", "sdc2_cmd", "sdc2_data",
> +	};
> +
> +	if (selector >= 150 && selector <= 157)
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 150]);

Please use something like:
		snprintf(pin_name, MAX_PIN_NAME_LEN,
			 sdm670_special_pins_data[selector - 150].name);
And drop the special_pins_names.

Thanks,
Neil

> +	else
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +
> +	return pin_name;
> +}
> +
> +static int sdm670_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
> +{
> +	if (selector >= 0 && selector < ARRAY_SIZE(sdm670_pinctrl_functions))
> +		return sdm670_pinctrl_functions[selector].val;
> +	return -EINVAL;
> +}
> +
> +struct msm_pinctrl_data sdm670_data = {
> +	.pin_data = {
> +		.pin_offsets = sdm670_pin_offsets,
> +		.pin_count = ARRAY_SIZE(sdm670_pin_offsets) + ARRAY_SIZE(sdm670_special_pins_data),
> +		.special_pins_start = 150,
> +		.special_pins_data = sdm670_special_pins_data,
> +	},
> +	.functions_count = ARRAY_SIZE(sdm670_pinctrl_functions),
> +	.get_function_name = sdm670_get_function_name,
> +	.get_function_mux = sdm670_get_function_mux,
> +	.get_pin_name = sdm670_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +	{
> +		.compatible = "qcom,sdm670-tlmm",
> +		.data = (ulong)&sdm670_data
> +	},
> +	{ /* Sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_ssdm670) = {
> +	.name = "pinctrl_sdm670",
> +	.id = UCLASS_NOP,
> +	.of_match = msm_pinctrl_ids,
> +	.ops = &msm_pinctrl_ops,
> +	.bind = msm_pinctrl_bind,
> +};
> 

