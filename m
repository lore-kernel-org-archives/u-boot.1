Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E80C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 13:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E40B784053;
	Fri, 11 Apr 2025 15:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="welqxR7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8962084054; Fri, 11 Apr 2025 15:38:50 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D05E984051
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 15:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso1263428f8f.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744378727; x=1744983527; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1hrSWzq9fVF6bPZ/EufkyrPBmJEKzCABk/JEg4Jyens=;
 b=welqxR7Asp9ArK+GQ8zaCpnNlnMfZA2bgpYweOzXPODcTa9f3ZKjpMHhaCh/mRnCD3
 buYvy1ZIyNfL8B5H0mmifgvJ5Zypey4UbvLYK39JA72Lx+i/YHcq90SHHaJyakkZnqyr
 X46kKFlVpe5PDDmZYc99s627QEcl6HFY/47sThO/YE2L6n/E/6PKIBYz5d6Vy6Zasndl
 Pk2L8MMiVFiA96ao63NJE9TI/leF4MAcZm9kJCad5/uPSoN7xiBtK9n/9eOk+/+tdzv+
 HT7Kdisd+kBPL7nn6ZNYdkEPpopR5a/DpegJDv6CowOdGb6uB9ZLVXDD8HYpmsxknatL
 ypfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744378727; x=1744983527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1hrSWzq9fVF6bPZ/EufkyrPBmJEKzCABk/JEg4Jyens=;
 b=ehAbSFacl8/PqLwYkc60JDBNajWmtkYTh14hIjnC6YwEAzKhPm2L0bQ0gOfkpcDvlG
 Sm4OisUOXZaiKS0NRGKKM+dPPnm1JQHuM5LQJ3W86kngj9111qcVQ9M1e8GPViLp9qOD
 oQr32Cr3IRvx7bJAblXau0m+UJHzQp05lAO6RCDt3H/XfxXedq3nw/viibJ1zeSnksuO
 onvAU19X62iTxDTQF+t0iiANURzLIpl83Q0szfTtA4yyV3OObFB9oYamx/fAFP4sNXWO
 Tceu8jaco1AH5PMqbMXAkEcr8Mmmt349C9BPYxuJvjNTDCEI2RokJpgUnmdR0FQRll8k
 BpdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy1/NW35+Jdck7vjN2fxQOfi7GiY3SKpS1UEPrNU/FmJfOvNxVGRRkDMBpwEtjOZFq7LmVaNk=@lists.denx.de
X-Gm-Message-State: AOJu0YwkG5kxFmvynfzV/rU77l1+qbkzCnpzhCoAKh498XMZAH3+rzTb
 hV3vtaxfur5Ig8xerGIYodlBHkl4msSTmbGhcENmbmhtDspdb3whc9KMo7wNE5g=
X-Gm-Gg: ASbGncsEwlIH3sFxsGB5t3D19vbHlDWIArWvhJ9VpXdYl6RbJ9qs3pyX59wO5MT4iGC
 1b0typ6NL/MOnI5QwdyqCIZ9kOXF9iDAIygF2FiqO6dy/K+qMmSqVv+MQvzbvnOQK5JsLw3dl51
 KxLmO6c2zR54oY52TfZL4VkKmPV3w4Z5b53YrehWLgoLE70b6XTNkW/ye0RTL7ZOV6Xe1mPDvu1
 MQaJVmrovdvdbLwzCC2YKzFUXCd/P/4fOnj8qlVygxqZiZTdDeqJvgTv2iSjoHOLI4Y89Z2OSSt
 iKc2CwLI74O/eKVdwvMW1fYykm+yvkV/eT1+torT8O0NoHzNByQKQ77AvRSQsTuVTQCLtTeDYq9
 WCel8
X-Google-Smtp-Source: AGHT+IFISMpOGGZbgzYj2N27/QNDRyXMcQe3JaavGCYAEafPatCbaHP8Y+1fk1pzZ4koFW1bGnJoWg==
X-Received: by 2002:a5d:64e3:0:b0:390:f6aa:4e72 with SMTP id
 ffacd0b85a97d-39ea5200a39mr2190838f8f.18.1744378726941; 
 Fri, 11 Apr 2025 06:38:46 -0700 (PDT)
Received: from [192.168.1.47] (35-60-142-46.pool.kielnet.net. [46.142.60.35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c184sm2078461f8f.30.2025.04.11.06.38.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 06:38:46 -0700 (PDT)
Message-ID: <58b62c9f-0d88-4da6-9abe-e3bd5a760f07@linaro.org>
Date: Fri, 11 Apr 2025 15:38:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: pinctrl: Add Qualcomm SDM630/660 TLMM driver
To: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
References: <20250331155531.3638165-1-alexeymin@postmarketos.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250331155531.3638165-1-alexeymin@postmarketos.org>
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



On 3/31/25 17:55, Alexey Minnekhanov via groups.io wrote:
> Add support for TLMM pin controller block (Top Level Mode
> Multiplexer) on SDM630/660 SoCs, with support for special pins.
> 
> Correct pin configuration is required for working debug UART
> and eMMC/SD cards.
> 
> SDM630 and SDM660 TLMM blocks are the same.
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Thanks, this got merged in 
https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/b4420a0c9ed446a9dbb5439d543d7c74344a5099> 

> ---
> 
> v2: Fixed sdm660_get_function_mux() signature to return an int
>      and check validity of the selector passed in.
> ---
>   drivers/pinctrl/qcom/Kconfig          |   7 +
>   drivers/pinctrl/qcom/Makefile         |   1 +
>   drivers/pinctrl/qcom/pinctrl-sdm660.c | 226 ++++++++++++++++++++++++++
>   3 files changed, 234 insertions(+)
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
> index 00000000000..646d848ffa4
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm660.c
> @@ -0,0 +1,226 @@
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
> +static int sdm660_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
> +{
> +	if (selector >= 0 && selector < ARRAY_SIZE(sdm660_pinctrl_functions))
> +		return sdm660_pinctrl_functions[selector].val;
> +	return -EINVAL;
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

