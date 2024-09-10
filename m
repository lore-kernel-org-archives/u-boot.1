Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9FAECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E40268907E;
	Tue, 10 Sep 2024 14:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DwkIoLAk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7FAF8905D; Tue, 10 Sep 2024 14:05:37 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26AD389056
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 14:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8a6d1766a7so83362366b.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 05:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725969927; x=1726574727; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xMj4GoVAVCN/XJPEM6kbjU6w5294+R3SfPyyOb2eEu4=;
 b=DwkIoLAkptHap4cP4w/1zUTFAGlt1bxet2dqUKBr7NJQJouOOhdZEZcB8ziZPTorEj
 RsQfponQZgYW6XVlL1o1ArKL510WD+LPtCs589O3DAxSLbLdI9+z1B/G/UT8ckXRmsWe
 sEhUDR1Raw3gt50gZ1jku5UUBG3IOvINdr+NBYQplz7BD+8cAT/dpuzoBDBMZszqM+Y6
 DfOaNU7911HLtRn7tF4sydyyCsrZ5bttCZc/N9GlBIthl5QYcQLslY8OQUU5YN/Gywer
 qJPD66PtcNZEiCMod/KFYds9CKg7namYsQ0BFS/+RQxdaUp97iUlsVrSIP6be+Uxv2aJ
 +HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725969927; x=1726574727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xMj4GoVAVCN/XJPEM6kbjU6w5294+R3SfPyyOb2eEu4=;
 b=q6wGxBQJ9/7AXTQpPKmuWk8FTaVzgvCSrk1St3kcx1YcyhKS1ntJPvMAWtQ7f1cF2/
 o4SjjnbYQQVkkKb15u5C0A+UGJvxW4Vs3knrN6Jb02eVft4XaGVip4xJamcQCX+//EP5
 cqAfbVINXDVdXrtGP5nzgCMntFX4pH+5sfEiPuvnL9klb378zzA3w0xiJcGCy+cN9YAL
 y02hls3zjSWQA9g4PeW3WHuUYUNY/mkquUC1YpvY2XsNha9e6uBfMbjTtFZbRIVUySEB
 zMNfsBiFUdTpSkz7ao+kHxTZa3JL4EV3xqmCaYRpYtVvcH84r+fyUP4mh+MQ7Fbp9DTw
 t69g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJSzd0H89NqXwzZG5rc35VykqNgBDvYwPT7Jir++MeitAMPFA3DaW9P34Z8M3/E1ByC6+DMfk=@lists.denx.de
X-Gm-Message-State: AOJu0YwFPOGTwa7Uh/4ZTcFBN6BTsWKLuBCSFVVoXhKkATRKrK39GCGD
 Fkr2bJyJcHYO4gj4FU8qfJjPlAGk0HWNhICGU9YwDZxn1UzW5wDrhD5/mqAgwK0=
X-Google-Smtp-Source: AGHT+IF8m/1VRRNO+bts3C1yoG/SzzfyVCdIs5m2+kTw2Jreqh3DJpBbiGDJjJOa3ErTNbBVPlxPTQ==
X-Received: by 2002:a17:907:97cb:b0:a7a:9447:3e8c with SMTP id
 a640c23a62f3a-a8ffaaafb72mr53108666b.3.1725969927315; 
 Tue, 10 Sep 2024 05:05:27 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8db? ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ced1bfsm472329766b.154.2024.09.10.05.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 05:05:26 -0700 (PDT)
Message-ID: <cd9da433-312c-4267-a26a-0d55f2093373@linaro.org>
Date: Tue, 10 Sep 2024 14:05:25 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/3] pinctrl: qcom: add driver for SM8150 SoC
To: Julius Lehmann <lehmanju@devpi.de>, u-boot@lists.denx.de
Cc: Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io
References: <20240909155315.307026-1-lehmanju@devpi.de>
 <20240909155315.307026-3-lehmanju@devpi.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240909155315.307026-3-lehmanju@devpi.de>
Content-Type: text/plain; charset=UTF-8
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

Hi Julius,

Thanks for the patch!

On 09/09/2024 17:53, Julius Lehmann wrote:
> Add pinctrl and GPIO driver for SM8150. Driver code is based on the
> similar U-Boot drivers. All constants are taken from the corresponding
> Linux driver. This drivers differs from the similar U-Boot drivers,
> because SM8150 SoC have different function IDs for the same functions
> on different pins.
> 
> Co-authored-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
> ---
> 
>  drivers/pinctrl/qcom/Kconfig          |   8 ++
>  drivers/pinctrl/qcom/Makefile         |   1 +
>  drivers/pinctrl/qcom/pinctrl-sm8150.c | 119 ++++++++++++++++++++++++++
>  3 files changed, 128 insertions(+)
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8150.c
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index b326fa8514..501939f783 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -74,6 +74,14 @@ config PINCTRL_QCOM_SM8650
>  	select PINCTRL_QCOM
>  	help
>  	  Say Y here to enable support for pinctrl on the Snapdragon SM8650 SoC,
> +	  as well as the associated GPIO driver.
> +
> +config PINCTRL_QCOM_SM8150
> +	bool "Qualcomm SM8150 GCC"
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the Snapdragon SM8150 SoC,
> +	  as well as the associated GPIO driver.
>  
>  endmenu
>  
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 4f1d96787b..cc3660a576 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
>  obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
>  obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
>  obj-$(CONFIG_PINCTRL_QCOM_SM8650) += pinctrl-sm8650.o
> +obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8150.c b/drivers/pinctrl/qcom/pinctrl-sm8150.c
> new file mode 100644
> index 0000000000..c3af3448f6
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8150.c
> @@ -0,0 +1,119 @@
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
> +#define WEST	0x00100000
> +#define EAST	0x00500000
> +#define NORTH	0x00900000
> +#define SOUTH	0x00D00000
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +static const struct pinctrl_function msm_pinctrl_functions[] = { { "qup2", 1 },
> +								 { "gpio", 0 },
> +								{ "sdc4", 0 } };
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
> +	// special pins
> +	[175] = 0, [176] = 0, [177] = 0, [178] = 0,

We have better support for special pins now, you can remove these 0
entries and set .special_pins_start = 175 in pin_data below.

Kind regards,
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
> +	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
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
> +		.pin_count = ARRAY_SIZE(sm8150_pin_offsets),
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

-- 
// Caleb (they/them)
