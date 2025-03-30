Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FABC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC5CA8144A;
	Sun, 30 Mar 2025 16:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EfOL3Cdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8581881DE3; Sun, 30 Mar 2025 16:53:28 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AD37800C1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso26051355e9.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743346406; x=1743951206; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VsNXD6snzOOT/Slep6kk1ChUpuMJCRZ+pQFn64CYAq4=;
 b=EfOL3CdrZLb03HN2rQAKtcdg3SBGrfuP96v6IUya7TaikHNgxqwHvvWqZZ8sLNXKiS
 Ubw2tRO0OgOp/ev5ID5xXy6tsPDcLEFAsc+zEvC4WmmtKQBBTeQvxCUuA+SFTALdue4l
 qLWKHGCgJ5+sGejlUbYiqtqW5Byuzkd1vvfLaDIw8JIIPVGCFXkgfEJ8WUVTUa9uekWQ
 sVRq+ZnLbQF3Xd4jWvQRnYgao12mQDKDxy8EGfVNkpAui81iDHwn0yjPcO0FyP67zByC
 DQ38rkKejx0Nv5v7chgICWz1v7EJwA1KXdYHqtWEFQ7Wx0kEZqeFFG64PVO+L1YluOS7
 CFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743346406; x=1743951206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VsNXD6snzOOT/Slep6kk1ChUpuMJCRZ+pQFn64CYAq4=;
 b=w2+RUHWX6iUCkGj8SEX0FTXCGMSTH/T+r0B4paCedLzhfHosvHFUkwLs/qka1zhlAA
 7KNnO96Sa7zfhFN9I5cbLNYfJoFBQn8Il+c+iTWfhChRJyzypSgvP3cb6cYageea3s+j
 T1HGdga82ODN7us7ecS0jPZTVmf8iuPD0X8Ep8VSi0smNqyalDrEb77aMJYLLoKJcefL
 9pdTSiulXCgkwNtz/eKqRCH/wR4EF/uULVAhJnRJe70eOxNZgVnIRkpMXNMmEN0T2k0E
 nLGfyEDWRZK6rV1EKMDnMmkRI/blf8+N6qH8TFdIQV4f6ZPzefbTrULhKLPmWPWMLw4g
 SNpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTpPAYmIXcFrac+ahj7rtH0TGAxhOMmohI2zzYtGpYK1FL4cN/fkN695uGsCWGgi/6UbbIqAs=@lists.denx.de
X-Gm-Message-State: AOJu0YzDt+mImbjDx4N36mP9mHcodmFGWiF/a3CgOfUKBHrQQ3/zL4M0
 lLKKGcYDY8oKoW389z0iq6Uvj5tk5eF8clD+brZiuX3NEnPwIYUKCFwuGAbYUZU=
X-Gm-Gg: ASbGncsGx/pudfMlQ6qncPof0CgENnaoDJTmEr0beFlKe6b5T9HbNo0g97n0DtbX7hS
 8ZTYO21xUKcK0tfwc874EHxDev6es251Gh1xxhbjgXntqSaYUJZTwvIpKuXqkrkWWOtdULvvmVo
 gcmwRoSU1A4CEaMV2a7pbga9DpXAY1hNtsZ1PT9Izv44DKWdpkQiHAiDeEYR9ofMZv4nBWQmkzn
 u3rR1eHXKpJxTHRvfLzYcvBLcoi6VQUjKdjCcZZc7HBWkAWKeHCxXKXPInd72rYWd+MaBW/P6vj
 Y37VWqjPz42rAGiIcRvtV73OFmf8LHKQIr3bDKFUtdB9o8hTf7S1H7emx9a8y0pmdJHuIAi1uNU
 =
X-Google-Smtp-Source: AGHT+IHsqYWbMIBPSay8JtL+co//HAb+KNhxUs3ZXr/y2GzQ8sZd0xaLBxbVR+ukOTdn135/s0Hg4A==
X-Received: by 2002:a05:6000:184e:b0:39c:12ce:91f with SMTP id
 ffacd0b85a97d-39c12ce0e13mr4106895f8f.30.1743346405731; 
 Sun, 30 Mar 2025 07:53:25 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0dcsm8796715f8f.64.2025.03.30.07.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 07:53:24 -0700 (PDT)
Message-ID: <e80f269e-cf03-490d-9e57-1047fc9877c5@linaro.org>
Date: Sun, 30 Mar 2025 16:53:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: pinctrl: Add Qualcomm SDM630/660 TLMM driver
To: Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250325081808.2421857-1-alexeymin@postmarketos.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250325081808.2421857-1-alexeymin@postmarketos.org>
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

Hi Alexey,

On 3/25/25 09:18, Alexey Minnekhanov wrote:
> Add support for TLMM pin controller block (Top Level Mode
> Multiplexer) on SDM630/660 SoCs, with support for special pins.
> 
> Correct pin configuration is required for working debug UART
> and eMMC/SD cards.
> 
> SDM630 and SDM660 TLMM blocks are the same.
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> ---
>   drivers/pinctrl/qcom/Kconfig          |   7 +
>   drivers/pinctrl/qcom/Makefile         |   1 +
>   drivers/pinctrl/qcom/pinctrl-sdm660.c | 224 ++++++++++++++++++++++++++
>   3 files changed, 232 insertions(+)
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm660.c
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index d3eb6998551..29105301c74 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -41,6 +41,13 @@ config PINCTRL_QCOM_QCS404
>   	  Say Y here to enable support for pinctrl on the Snapdragon QCS404 SoC,
>   	  as well as the associated GPIO driver.
>   
> +config PINCTRL_QCOM_SDM660
> +	bool "Qualcomm SDM630/660 Pinctrl"
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the Snapdragon 630/636/660
> +	  SoCs, as well as the associated GPIO driver.
> +
>   config PINCTRL_QCOM_SDM845
>   	bool "Qualcomm SDM845 GCC"
>   	select PINCTRL_QCOM
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 06d3c95f93a..c814e9dec0b 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
>   obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
>   obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
>   obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
> +obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
>   obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
>   obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm660.c b/drivers/pinctrl/qcom/pinctrl-sdm660.c
> new file mode 100644
> index 00000000000..c31c1f0b637
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm660.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm SDM630/660 TLMM pinctrl
> + *
> + */
> +
> +#include <dm.h>
> +#include "pinctrl-qcom.h"
> +
> +#define TLMM_BASE  0x03100000
> +#define SOUTH  (0x03100000 - TLMM_BASE)  /* 0x0 */
> +#define CENTER (0x03500000 - TLMM_BASE)  /* 0x400000 */
> +#define NORTH  (0x03900000 - TLMM_BASE)  /* 0x800000 */
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +static const struct pinctrl_function sdm660_pinctrl_functions[] = {
> +	{ "gpio", 0 },
> +	{ "blsp_uart2", 3 }, /* gpio 4 and 5, used for debug uart */
> +};
> +
> +static const unsigned int sdm660_pin_offsets[] = {
> +	[0] = SOUTH,
> +	[1] = SOUTH,
> +	[2] = SOUTH,
> +	[3] = SOUTH,
> +	[4] = NORTH,
> +	[5] = SOUTH,
> +	[6] = SOUTH,
> +	[7] = SOUTH,
> +	[8] = NORTH,
> +	[9] = NORTH,
> +	[10] = NORTH,
> +	[11] = NORTH,
> +	[12] = NORTH,
> +	[13] = NORTH,
> +	[14] = NORTH,
> +	[15] = NORTH,
> +	[16] = CENTER,
> +	[17] = CENTER,
> +	[18] = CENTER,
> +	[19] = CENTER,
> +	[20] = SOUTH,
> +	[21] = SOUTH,
> +	[22] = CENTER,
> +	[23] = CENTER,
> +	[24] = NORTH,
> +	[25] = NORTH,
> +	[26] = NORTH,
> +	[27] = NORTH,
> +	[28] = CENTER,
> +	[29] = CENTER,
> +	[30] = CENTER,
> +	[31] = CENTER,
> +	[32] = SOUTH,
> +	[33] = SOUTH,
> +	[34] = SOUTH,
> +	[35] = SOUTH,
> +	[36] = SOUTH,
> +	[37] = SOUTH,
> +	[38] = SOUTH,
> +	[39] = SOUTH,
> +	[40] = SOUTH,
> +	[41] = SOUTH,
> +	[42] = SOUTH,
> +	[43] = SOUTH,
> +	[44] = SOUTH,
> +	[45] = SOUTH,
> +	[46] = SOUTH,
> +	[47] = SOUTH,
> +	[48] = SOUTH,
> +	[49] = SOUTH,
> +	[50] = SOUTH,
> +	[51] = SOUTH,
> +	[52] = SOUTH,
> +	[53] = NORTH,
> +	[54] = NORTH,
> +	[55] = SOUTH,
> +	[56] = SOUTH,
> +	[57] = SOUTH,
> +	[58] = SOUTH,
> +	[59] = NORTH,
> +	[60] = NORTH,
> +	[61] = NORTH,
> +	[62] = NORTH,
> +	[63] = NORTH,
> +	[64] = SOUTH,
> +	[65] = SOUTH,
> +	[66] = NORTH,
> +	[67] = NORTH,
> +	[68] = NORTH,
> +	[69] = NORTH,
> +	[70] = NORTH,
> +	[71] = NORTH,
> +	[72] = NORTH,
> +	[73] = NORTH,
> +	[74] = NORTH,
> +	[75] = NORTH,
> +	[76] = NORTH,
> +	[77] = NORTH,
> +	[78] = NORTH,
> +	[79] = SOUTH,
> +	[80] = SOUTH,
> +	[81] = CENTER,
> +	[82] = CENTER,
> +	[83] = SOUTH,
> +	[84] = SOUTH,
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
> +	[97] = SOUTH,
> +	[98] = SOUTH,
> +	[99] = SOUTH,
> +	[100] = SOUTH,
> +	[101] = SOUTH,
> +	[102] = SOUTH,
> +	[103] = SOUTH,
> +	[104] = SOUTH,
> +	[105] = SOUTH,
> +	[106] = SOUTH,
> +	[107] = SOUTH,
> +	[108] = SOUTH,
> +	[109] = SOUTH,
> +	[110] = SOUTH,
> +	[111] = SOUTH,
> +	[112] = SOUTH,
> +	[113] = SOUTH,
> +};
> +
> +/*
> + * Special pins - eMMC/SD related: [114..120], in total 7 special pins
> + */
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
> +/* All SDC pins are in the NORTH tile */
> +static const struct msm_special_pin_data sdm660_special_pins_data[] = {
> +	SDC_QDSD_PINGROUP("sdc1_clk",  NORTH + 0x9a000, 13, 6),
> +	SDC_QDSD_PINGROUP("sdc1_cmd",  NORTH + 0x9a000, 11, 3),
> +	SDC_QDSD_PINGROUP("sdc1_data", NORTH + 0x9a000, 9,  0),
> +	SDC_QDSD_PINGROUP("sdc2_clk",  NORTH + 0x9b000, 14, 6),
> +	SDC_QDSD_PINGROUP("sdc2_cmd",  NORTH + 0x9b000, 11, 3),
> +	SDC_QDSD_PINGROUP("sdc2_data", NORTH + 0x9b000, 9,  0),
> +	SDC_QDSD_PINGROUP("sdc1_rclk", NORTH + 0x9a000, 15, 0),
> +};
> +
> +static const char *sdm660_get_function_name(struct udevice *dev, unsigned int selector)
> +{
> +	return sdm660_pinctrl_functions[selector].name;
> +}
> +
> +static const char *sdm660_get_pin_name(struct udevice *dev, unsigned int selector)
> +{
> +	static const char * const special_pins_names[] = {
> +		"sdc1_clk", "sdc1_cmd", "sdc1_data",
> +		"sdc2_clk", "sdc2_cmd", "sdc2_data",
> +		"sdc1_rclk"
> +	};
> +
> +	if (selector >= 114 && selector <= 120)
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 114]);
> +	else
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +
> +	return pin_name;
> +}
> +
> +static unsigned int sdm660_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
> +{
> +	return sdm660_pinctrl_functions[selector].val;

This API got changed lately (sorry!), it should return a signed int and 
check if selector is invalid (return -ENOENT if not).

With that fixed

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Kind regards,

> +}
> +
> +struct msm_pinctrl_data sdm660_data = {
> +	.pin_data = {
> +		.pin_offsets = sdm660_pin_offsets,
> +		.pin_count = ARRAY_SIZE(sdm660_pin_offsets) + ARRAY_SIZE(sdm660_special_pins_data),
> +		.special_pins_start = 114,
> +		.special_pins_data = sdm660_special_pins_data,
> +	},
> +	.functions_count = ARRAY_SIZE(sdm660_pinctrl_functions),
> +	.get_function_name = sdm660_get_function_name,
> +	.get_function_mux = sdm660_get_function_mux,
> +	.get_pin_name = sdm660_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +	{
> +		.compatible = "qcom,sdm630-pinctrl",
> +		.data = (ulong)&sdm660_data
> +	},
> +	{
> +		.compatible = "qcom,sdm660-pinctrl",
> +		.data = (ulong)&sdm660_data
> +	},
> +	{ /* Sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_ssdm660) = {
> +	.name = "pinctrl_sdm660",
> +	.id = UCLASS_NOP,
> +	.of_match = msm_pinctrl_ids,
> +	.ops = &msm_pinctrl_ops,
> +	.bind = msm_pinctrl_bind,
> +};

-- 
Caleb (they/them)

