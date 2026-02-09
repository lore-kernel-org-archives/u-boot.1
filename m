Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03C8E7E0D9
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 19:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ACE18388D;
	Mon,  9 Feb 2026 20:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="es09pAod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B6628388D; Mon,  9 Feb 2026 20:51:35 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD702802C1
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 20:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-480142406b3so37524925e9.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 11:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770666692; x=1771271492; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+pOQfWVDFJ8yxBYYSKREsjy8tjZLunA3pf+6QwKHPmU=;
 b=es09pAodNC0T91TplkgAlmB3902Z0I694B2SyC8xFw0EJoSX6wh9ht0LscExK6ejGs
 cnb7gsGqTezObbZ4YGGcQ0yw97omtiAfjmfTOI1KlJkukcHyxxxtGkDOSzhdBtcEYk7T
 EoSqkdAwY8dxXmS5sff0MFAtSgqZe4GGThLpoiE8fRDOmokzxPfXQ7O8pHwSY0qZB93y
 IoK88vo7wOpxg23Jj0rdBGnYMyN5f5zpiPo/VjCcwyddziXF5g7nGhmcADEXNMqMsb6d
 Q1ZqwR/f1y0n8zd1HqW2BpqZmnnuslodCDk6Ip3IUhn2Vdc5skK92mrGZf4BpnyJeaUh
 PKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770666692; x=1771271492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+pOQfWVDFJ8yxBYYSKREsjy8tjZLunA3pf+6QwKHPmU=;
 b=vhjLDgx2wG2cAra79VPuSI5XxsCF1xqqQ0r2bjKp4vQLWFywbsJtHvgxGZ2ucsBxnP
 GNMl2zG17ldTRT504msQzJLC+hBjvzQKuNYJGGkJCX67q4fq+0XakFdPq7dU/FLYeXNb
 Z1VsDdabrwkbV5BM+6mnTdrlqPPTVjN+HxyHEnTGKsTjSHGyhkKou2L4iaKqCUUyL8bk
 7m2ecaDGMOcwu4sNgyY2lyQlP/rqcAYSdELjVP/t5YskOT1/kP5ju4krUgFg/6uVd6cC
 JenlY3pOy1/u5ssrtafx3HmY7npX6okuyHRa1DAwMu1fNYaRIVNkMQ+JkrPzd89HaQvD
 qNNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk7bLuyY/mYUTe2VQaLbhv6XkB1lGb9SAQhlmyNYOmIEvWru8dNl/hOxXqfu7eeiYL5SXYjN0=@lists.denx.de
X-Gm-Message-State: AOJu0Yyc7vwSj4/WX//IJpL3VBBMn0opShwuWM8iihwWpTE29vmkpWSv
 RPpzHMyt1lW77syUDbHOtSkH7Res7KPjKEjF5omWxGTO8kcRjOA2G3/gO1vhEEOo2S8=
X-Gm-Gg: AZuq6aLsdFXLH6WUThGCW0nb3OMtm5OOM4396Fpzs/Nuj7LYUi50BzHSV4NKWeRuy8a
 eWw+iO2w9xr4y2t66phwV8F+BdV3aIRxAndkSnuoA89zvki7jD7XPnonn/Mk4hbBQZTwHjuTTF6
 AHW6cuZbZ0reoUU9jpjeGC5kMuBXlov6VFgACg0GZcacD8OsJmNQDY7T+TS2UOP+MiN7aLQ+9F1
 VLT/AXNta1w6VDy2Gh8ho1yhP3XzMU+K4RkHmU+auJaiUM1F9oF5aezAx4oBipDVzqp20ezeeSR
 ymlaBbMH48uOdT5No7E6GUX61FX+suyhbh4XL0XxDfxhTdV8k22Q0wE8kXeI26p/1NBWx5oUGw0
 +mvFY0uHsPzIfHk7muw4tmEyeOhJPCNjKMdFn/LXrA7wYGJK9///lKz7TcQOf8A5CbflA5aolBs
 oYVgx4CcCYi8kmjAZpNrzg9/3ZK5Qz+Q+XDBs5iIu/YG5h21qI4w==
X-Received: by 2002:a05:600c:8b57:b0:479:35e7:a0e3 with SMTP id
 5b1f17b1804b1-4832021d9b3mr175566125e9.30.1770666692149; 
 Mon, 09 Feb 2026 11:51:32 -0800 (PST)
Received: from [192.168.1.36] (p5b29ea02.dip0.t-ipconnect.de. [91.41.234.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436309ed238sm27457144f8f.19.2026.02.09.11.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 11:51:31 -0800 (PST)
Message-ID: <a02d3102-5e08-4386-948d-8bbae311e834@linaro.org>
Date: Mon, 9 Feb 2026 20:51:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] drivers: pinctrl: Add Qualcomm SM6125 TLMM driver
Content-Language: en-US
To: Biswapriyo Nath <nathbappai@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20260204-sm6125-clk-pinctrl-v1-0-9cf4c556557a@gmail.com>
 <20260204-sm6125-clk-pinctrl-v1-3-9cf4c556557a@gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260204-sm6125-clk-pinctrl-v1-3-9cf4c556557a@gmail.com>
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



On 04/02/2026 17:10, Biswapriyo Nath wrote:
> Add support for TLMM pin controller block (Top Level Mode Multiplexer)
> on SM6125 SoC, with support for special pins.
> 
> Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/pinctrl/qcom/Kconfig          |   8 ++
>  drivers/pinctrl/qcom/Makefile         |   1 +
>  drivers/pinctrl/qcom/pinctrl-sm6125.c | 147 ++++++++++++++++++++++++++++++++++
>  3 files changed, 156 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 580308621..d1c762891 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -125,6 +125,14 @@ config PINCTRL_QCOM_SM6115
>  	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
>  	  as well as the associated GPIO driver.
>  
> +config PINCTRL_QCOM_SM6125
> +	bool "Qualcomm SM6125 Pinctrl"
> +	default y if PINCTRL_QCOM_GENERIC
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the Snapdragon SM6125 SoC,
> +	  as well as the associated GPIO driver.
> +
>  config PINCTRL_QCOM_SM6350
>  	bool "Qualcomm SM6350 Pinctrl"
>  	default y if PINCTRL_QCOM_GENERIC
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index b5a111605..1844f37ed 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
>  obj-$(CONFIG_PINCTRL_QCOM_SDM670) += pinctrl-sdm670.o
>  obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
>  obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
> +obj-$(CONFIG_PINCTRL_QCOM_SM6125) += pinctrl-sm6125.o
>  obj-$(CONFIG_PINCTRL_QCOM_SM6350) += pinctrl-sm6350.o
>  obj-$(CONFIG_PINCTRL_QCOM_SM7150) += pinctrl-sm7150.o
>  obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm6125.c b/drivers/pinctrl/qcom/pinctrl-sm6125.c
> new file mode 100644
> index 000000000..82f8972ff
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm6125.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Pinctrl driver for Qualcomm SM6125
> + *
> + * (C) Copyright 2026 Biswapriyo Nath <nathbappai@gmail.com>
> + *
> + * Based on Linux Kernel driver
> + */
> +
> +#include <dm.h>
> +
> +#include "pinctrl-qcom.h"
> +
> +#define TLMM_BASE 0x00500000
> +#define WEST (0x00500000 - TLMM_BASE) /* 0x0 */
> +#define SOUTH (0x00900000 - TLMM_BASE) /* 0x400000 */
> +#define EAST (0x00d00000 - TLMM_BASE) /* 0x800000 */
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +static const struct pinctrl_function msm_pinctrl_functions[] = {
> +	{ "qup04", 1 },
> +	{ "gpio", 0 },
> +};
> +
> +#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv) \
> +	{                                          \
> +		.name = pg_name,                   \
> +		.ctl_reg = ctl,                    \
> +		.io_reg = 0,                       \
> +		.pull_bit = pull,                  \
> +		.drv_bit = drv,                    \
> +		.oe_bit = -1,                      \
> +		.in_bit = -1,                      \
> +		.out_bit = -1,                     \
> +	}
> +
> +#define UFS_RESET(pg_name, offset)      \
> +	{                               \
> +		.name = pg_name,        \
> +		.ctl_reg = offset,      \
> +		.io_reg = offset + 0x4, \
> +		.pull_bit = 3,          \
> +		.drv_bit = 0,           \
> +		.oe_bit = -1,           \
> +		.in_bit = -1,           \
> +		.out_bit = 0,           \
> +	}
> +
> +static const struct msm_special_pin_data msm_special_pins_data[] = {
> +	[0] = UFS_RESET("ufs_reset", 0x190000),
> +	[1] = SDC_QDSD_PINGROUP("sdc1_rclk", WEST + 0x18d000, 15, 0),
> +	[2] = SDC_QDSD_PINGROUP("sdc1_clk", WEST + 0x18d000, 13, 6),
> +	[3] = SDC_QDSD_PINGROUP("sdc1_cmd", WEST + 0x18d000, 11, 3),
> +	[4] = SDC_QDSD_PINGROUP("sdc1_data", WEST + 0x18d000, 9, 0),
> +	[5] = SDC_QDSD_PINGROUP("sdc2_clk", SOUTH + 0x58b000, 14, 6),
> +	[6] = SDC_QDSD_PINGROUP("sdc2_cmd", SOUTH + 0x58b000, 11, 3),
> +	[7] = SDC_QDSD_PINGROUP("sdc2_data", SOUTH + 0x58b000, 9, 0),
> +};
> +
> +static const unsigned int sm6125_pin_offsets[] = {
> +	[0] = WEST,    [1] = WEST,    [2] = WEST,    [3] = WEST,
> +	[4] = WEST,    [5] = WEST,    [6] = WEST,    [7] = WEST,
> +	[8] = WEST,    [9] = WEST,    [10] = EAST,   [11] = EAST,
> +	[12] = EAST,   [13] = EAST,   [14] = WEST,   [15] = WEST,
> +	[16] = WEST,   [17] = WEST,   [18] = EAST,   [19] = EAST,
> +	[20] = EAST,   [21] = EAST,   [22] = WEST,   [23] = WEST,
> +	[24] = WEST,   [25] = WEST,   [26] = WEST,   [27] = WEST,
> +	[28] = WEST,   [29] = WEST,   [30] = WEST,   [31] = WEST,
> +	[32] = WEST,   [33] = WEST,   [34] = SOUTH,  [35] = SOUTH,
> +	[36] = SOUTH,  [37] = SOUTH,  [38] = EAST,   [39] = EAST,
> +	[40] = EAST,   [41] = EAST,   [42] = EAST,   [43] = EAST,
> +	[44] = SOUTH,  [45] = SOUTH,  [46] = SOUTH,  [47] = SOUTH,
> +	[48] = SOUTH,  [49] = SOUTH,  [50] = SOUTH,  [51] = SOUTH,
> +	[52] = SOUTH,  [53] = SOUTH,  [54] = SOUTH,  [55] = SOUTH,
> +	[56] = SOUTH,  [57] = SOUTH,  [58] = SOUTH,  [59] = SOUTH,
> +	[60] = SOUTH,  [61] = SOUTH,  [62] = SOUTH,  [63] = SOUTH,
> +	[64] = SOUTH,  [65] = SOUTH,  [66] = SOUTH,  [67] = SOUTH,
> +	[68] = SOUTH,  [69] = SOUTH,  [70] = SOUTH,  [71] = SOUTH,
> +	[72] = SOUTH,  [73] = SOUTH,  [74] = SOUTH,  [75] = SOUTH,
> +	[76] = SOUTH,  [77] = SOUTH,  [78] = SOUTH,  [79] = SOUTH,
> +	[80] = SOUTH,  [81] = SOUTH,  [82] = SOUTH,  [83] = SOUTH,
> +	[84] = SOUTH,  [85] = SOUTH,  [86] = SOUTH,  [87] = WEST,
> +	[88] = WEST,   [89] = WEST,   [90] = WEST,   [91] = WEST,
> +	[92] = WEST,   [93] = WEST,   [94] = SOUTH,  [95] = SOUTH,
> +	[96] = SOUTH,  [97] = SOUTH,  [98] = SOUTH,  [99] = SOUTH,
> +	[100] = SOUTH, [101] = SOUTH, [102] = SOUTH, [103] = SOUTH,
> +	[104] = EAST,  [105] = EAST,  [106] = EAST,  [107] = EAST,
> +	[108] = EAST,  [109] = EAST,  [110] = EAST,  [111] = EAST,
> +	[112] = EAST,  [113] = EAST,  [114] = EAST,  [115] = EAST,
> +	[116] = EAST,  [117] = SOUTH, [118] = SOUTH, [119] = SOUTH,
> +	[120] = SOUTH, [121] = EAST,  [122] = EAST,  [123] = EAST,
> +	[124] = EAST,  [125] = EAST,  [126] = EAST,  [127] = EAST,
> +	[128] = EAST,  [129] = SOUTH, [130] = SOUTH, [131] = SOUTH,
> +	[132] = SOUTH,
> +};
> +
> +static const char *sm6125_get_function_name(struct udevice *dev,
> +					    unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].name;
> +}
> +
> +static const char *sm6125_get_pin_name(struct udevice *dev,
> +				       unsigned int selector)
> +{
> +	if (selector >= 133 && selector <= 140)
> +		snprintf(pin_name, MAX_PIN_NAME_LEN,
> +			 msm_special_pins_data[selector - 133].name);
> +	else
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +
> +	return pin_name;
> +}
> +
> +static int sm6125_get_function_mux(__maybe_unused unsigned int pin,
> +				   unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].val;
> +}
> +
> +static struct msm_pinctrl_data sm6125_data = {
> +	.pin_data = {
> +		.pin_offsets = sm6125_pin_offsets,
> +		.pin_count = 141,
> +		.special_pins_start = 133,
> +		.special_pins_data = msm_special_pins_data,
> +	},
> +	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +	.get_function_name = sm6125_get_function_name,
> +	.get_function_mux = sm6125_get_function_mux,
> +	.get_pin_name = sm6125_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +	{ .compatible = "qcom,sm6125-tlmm", .data = (ulong)&sm6125_data },
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_sm6125) = {
> +	.name = "pinctrl_sm6125",
> +	.id = UCLASS_NOP,
> +	.of_match = msm_pinctrl_ids,
> +	.ops = &msm_pinctrl_ops,
> +	.bind = msm_pinctrl_bind,
> +};
> 

-- 
// Casey (she/her)

