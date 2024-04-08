Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82517C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E37BB8810E;
	Mon,  8 Apr 2024 15:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jVphqmKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1491488118; Mon,  8 Apr 2024 15:14:08 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E978B87BA8
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a51addddbd4so295125566b.0
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712582045; x=1713186845; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gr8exj3MADmarQxyGZ2PsOGXrpJuCB1uJDlLoDoKlyM=;
 b=jVphqmKYoerDf8sduHIxsOcHbYPBurDzZfSbjVxtk1HavAgY2LdXDUe+VUM6VCC7so
 HBZG8Q+N3c3As3Onx7QICmqmCk+Vd9JH4uqpvQVvHca88/KJoAAhfs/6QvPEIcn/ohux
 0RIWNwXPud9/MPM4elon8KjCBmnhSpwTL+/IUp4mhoHX1WIJV6P5a1aIC+drTSJV7uGE
 UD74Ph1CpGrMTdXk2EbFywwK8w1CGqpahRbWWJsvi6m4u8VOjsFWDLiYwESS512nDlYC
 erGnbY3UPUeqMvUObmnXSRt0HC9YbidUmu/la+cGLBZDJnl6EnBOKhKzptPl60OFBoXy
 YsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712582045; x=1713186845;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gr8exj3MADmarQxyGZ2PsOGXrpJuCB1uJDlLoDoKlyM=;
 b=nlGkpUN/oS+P8JKovkTNm/XAGGmBv3BTX4zB2sqKeCKw4ACX19l9NNjNCrNwg4n2qF
 2jhX3uXNM1fnNtYx/Vw0s7zqnpTHYTNL9DiHJd+ekf8Als7aRpoDkMKJdkQ60MtsMAH5
 AGoYW4jhH0ZPBH3GLWxQUnGaTSQxRXvLDs/0oIhdfrGTi8IbKJmaEE/s+Q3aX3a/1xKf
 qI8GE157ETrxAD6YD9Ufqmfx+W3Hrv9eRyCwKMw+kLu0Ba/7VCf9IPa2IKq5HvGlm2Tq
 8dK6SoEoUn6YqRp4cw5X7/DjweAyD4ktm8c8kdkuMjvpC6ed+ynGwm0wlEi5Ox2CnWFL
 4eFQ==
X-Gm-Message-State: AOJu0Yxly08BIBP7MKu3LEnjq4JGdMsTG1QBZJoeKGgUFr0hpPhT+RF3
 005c+sJeKgexq2jcf90xKIgMIBuIG9e6JpbHP8diWcoPYqYXgpOHFd7jGklQVzk=
X-Google-Smtp-Source: AGHT+IG4ZbboO3BbA7gj0coNqPydnrKSXHFYI8/kokOr0PaKe/FX/OWZRGK17SS6WDGD1jV/pY8q2A==
X-Received: by 2002:a17:906:11da:b0:a4e:146c:ff09 with SMTP id
 o26-20020a17090611da00b00a4e146cff09mr5636412eja.7.1712582045297; 
 Mon, 08 Apr 2024 06:14:05 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::570d? ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a056402428700b0056e664f732dsm812414edc.43.2024.04.08.06.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 06:14:04 -0700 (PDT)
Message-ID: <e9dcc5f1-238f-4949-9ef5-86a2b4955a4b@linaro.org>
Date: Mon, 8 Apr 2024 15:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] pinctrl: qcom: add sm8250 pinctrl driver
To: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org>
 <20240408-b4-qcom-rbx-soc-v1-3-900db37b8bdf@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
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

Not sure what happened here.

Also this patch is missing the special pins configuration. will fix both 
in v2.
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
> +
> +U_BOOT_DRIVER(pinctrl_sm8250) = {
> +	.name = "pinctrl_sm8250",
> +	.id = UCLASS_NOP,
> +	.of_match = msm_pinctrl_ids,
> +	.ops = &msm_pinctrl_ops,
> +	.bind = msm_pinctrl_bind,
> +};
> 

-- 
// Caleb (they/them)
