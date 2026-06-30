Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A46C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 10:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB2C84A30;
	Tue, 30 Jun 2026 12:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BqQgO9RO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57BC084A4B; Tue, 30 Jun 2026 12:54:15 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07A3084A1F
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 12:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4745492ed3aso1205716f8f.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782816852; x=1783421652; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mOyXt0CZPCRxAVhenVbKievVQ2Xhu2ZVYVWXK8I+HfY=;
 b=BqQgO9ROu80jrUe6Pvl+w2A/uMFK5QloDk9cZTx13i8U7e2cVu+IgOLpbRWdejHGuY
 UO8MnBSLWOb+pz0IGVi8371VvGQaDlHvjvwh0TAoSHKQMohClcZIHvZUZ4sAcP0W3nHQ
 V68aGZFsiLAnQ5E0adx2+68co/VyiXQr55PcDjanA9exOLzLnMDfPGVlzugUugCZkS39
 /QoIVpZ0KMuPttZPSL3IyuumETRX7wc/+sVH0vvHbI8uoocRpP/UxJ3mZ6ZFIhtRt0in
 S+8F0uMZJDq8cSSD3mU8/W80yViJo4mgxxbaoVsvdgybdJejlfD7uahGIQpUA+A5AOG5
 N12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782816852; x=1783421652;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mOyXt0CZPCRxAVhenVbKievVQ2Xhu2ZVYVWXK8I+HfY=;
 b=U3pOjtMLOqGRNEcLdo+zC29/vp3iMTR9H34j1+UEdvuU4OApWKhlM+v12I2H00si4g
 5UO8Jt7Sh2aLM/+v7mS+BNfv8Pt547kZlNFaW5P/bGp9I5/ibzKroAr7iYWAv+OedLuc
 Zq93Hm1FKTFOGWrd4/6f8Bf+hlLie4Vuiyc/WQlQX651+pmuFses4WZpqItXfVazFI0L
 c6KT/yRS6KsimUWAF3kg6jrT3zCvgILm54UYtPHSUykb7CUpuILUgRmvhBEYNZ7HIb1X
 B/ob6MzZcnOX070ikfufosaXMcj7b/NcfJm1XALodO9rjUE0ovNUX/u3yhql1GLd80mW
 eylg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoS00spReG2MH9PQ+JJ2wlh44ZQhqFiaqw23MwVGCN19IipmUbKfxKHU1NOSHK98SPWCd8mXb0=@lists.denx.de
X-Gm-Message-State: AOJu0YyWO2tnZK0tVXo9GPDpaEIb6TNBCufP/nEcAEKQFXSnqtUEcbiC
 HL5Xag37UdrZjiejSMBaW2oLeavBSJQyZ+l3IAHSu4LE+gtXxkYrUtaDY7RCynGDbiY=
X-Gm-Gg: AfdE7cnGyNSInWEItKrFs0x9XKm6wxoxViNJM6KHT1OVbdZcOF4arGul+0DBvrgGYJu
 l/FZVumHgDdnCW8EAM9NqOYudzISs+x1NpJU1TKBj9nYcLFO8xbN8fK8XB0pNXNeDXJFWF2BVkq
 JTSdmaG8WIcChEV4m0/+ZW0ZubLDnyTuIZOYtgMHJ5lVc9lYLmKD4R2cVXzdTegQHASHfH9Fwil
 5i+D/g9FA20/vTnHhy+eViPEOXknHRRS19E0UyTLxJG8wkRS+LMm0UjMmjmIb51uP+wm0soWjFW
 FFRfKcvOsjsL7fDu8Klm6h/uyhDytWxf6PRefBLV4yZnBJVMzqmBVrQ0BVG6woGtlWFm8cpe2Be
 jMU5eH+ndkFpV7vJ1ZmNz/mpBRqpHjy+hQRhp1qVXl8ESVUIUv0PwROT/wAq2VkWtvA+cBVt4jL
 Qq03stnGZI9ZsG9rd07Ul9OZXWYlY=
X-Received: by 2002:a5d:5d06:0:b0:475:f100:3605 with SMTP id
 ffacd0b85a97d-475f10037d6mr1902368f8f.52.1782816852384; 
 Tue, 30 Jun 2026 03:54:12 -0700 (PDT)
Received: from [172.16.185.106] ([195.76.196.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475671d0403sm7011635f8f.29.2026.06.30.03.53.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 03:54:11 -0700 (PDT)
Message-ID: <d90c6a1a-4bda-495e-9bf8-553d8a8ad8a6@linaro.org>
Date: Tue, 30 Jun 2026 12:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/11] clk/qcom: add initial clock driver for ipq5210
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 peng.fan@nxp.com, lukma@denx.de, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 rayagonda.kokatanur@broadcom.com, sjg@chromium.org, mkorpershoek@kernel.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-3-varadarajan.narayanan@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260623064804.3988799-3-varadarajan.narayanan@oss.qualcomm.com>
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

Initial clock driver? As opposed to what? This is just redundant

As an aside, why does your CC list have a bunch of emails multiple 
times? Please check this.

On 6/23/26 08:47, Varadarajan Narayanan wrote:
> Add initial set of clocks and resets for enabling U-Boot on ipq5210
> based RDP platforms.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
> v4: Add comment for using cbcr_reg instead of reg
>      Return error in ipq5210_enable() for failures
> ---
>   drivers/clk/qcom/Kconfig         |  8 +++
>   drivers/clk/qcom/Makefile        |  1 +
>   drivers/clk/qcom/clock-ipq5210.c | 98 ++++++++++++++++++++++++++++++++
>   3 files changed, 107 insertions(+)
>   create mode 100644 drivers/clk/qcom/clock-ipq5210.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 0a2ce55aaa2..03eace6d8d8 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -31,6 +31,14 @@ config CLK_QCOM_IPQ4019
>   	  on the Snapdragon IPQ4019 SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_IPQ5210
> +	bool "Qualcomm IPQ5210 GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Qualcomm IPQ5210 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>   config CLK_QCOM_IPQ5424
>   	bool "Qualcomm IPQ5424 GCC"
>   	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index b96d61b603e..845587a23cd 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
>   obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
>   obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
>   obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
> +obj-$(CONFIG_CLK_QCOM_IPQ5210) += clock-ipq5210.o
>   obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
>   obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
>   obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
> diff --git a/drivers/clk/qcom/clock-ipq5210.c b/drivers/clk/qcom/clock-ipq5210.c
> new file mode 100644
> index 00000000000..2e6037b6410
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-ipq5210.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock drivers for Qualcomm IPQ5210
> + *
> + * (C) Copyright 2024 Linaro Ltd.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/types.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,ipq5210-gcc.h>
> +#include <dt-bindings/reset/qcom,ipq5210-gcc.h>
> +#include "clock-qcom.h"
> +
> +static ulong ipq5210_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	/*
> +	 * Since GATE_CLK is deprecated and GATE_CLK_POLLED is being used
> +	 * use 'cbcr_reg' instead of 'reg'.

No need to leave comments explaining why a deprecated API is unused> +	 */
> +	switch (clk->id) {
> +	case GCC_QUPV3_WRAP_SE1_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
> +				     0, 2, 217, CFG_CLK_SRC_GPLL0, 16);
> +		break;
> +	case GCC_SDCC1_AHB_CLK:
> +		break;
> +	case GCC_SDCC1_APPS_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
> +				     0, 6, 25, CFG_CLK_SRC_GPLL0, 16);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return rate;
> +}
> +
> +static const struct gate_clk ipq5210_clks[] = {
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP_SE1_CLK,	0x05020, BIT(0),	0x05004),
> +	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK,	0x3303c, BIT(0),	0x3303c),
> +	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK,	0x3302c, BIT(0),	0x33004),
> +	GATE_CLK_POLLED(GCC_IM_SLEEP_CLK,	0x34020, BIT(0),	0x34020),
> +};
> +
> +static int ipq5210_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks <= clk->id) {
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return -ENOENT;
> +	}
> +
> +	debug("%s: clk %s\n", __func__, ipq5210_clks[clk->id].name);
> +
> +	return qcom_gate_clk_en(priv, clk->id);
> +}
> +
> +static const struct qcom_reset_map ipq5210_gcc_resets[] = {
> +	[GCC_SDCC_BCR]			= {0x33000, 0},
> +	[GCC_USB0_PHY_BCR]		= {0x2c06c, 0},
> +	[GCC_USB3PHY_0_PHY_BCR]		= {0x2c070, 0},
> +	[GCC_QUSB2_0_PHY_BCR]		= {0x2c068, 0},
> +	[GCC_USB_BCR]			= {0x2c000, 0},
> +};
> +
> +static struct msm_clk_data ipq5210_gcc_data = {
> +	.resets = ipq5210_gcc_resets,
> +	.num_resets = ARRAY_SIZE(ipq5210_gcc_resets),
> +	.clks = ipq5210_clks,
> +	.num_clks = ARRAY_SIZE(ipq5210_clks),
> +	.enable = ipq5210_enable,
> +	.set_rate = ipq5210_set_rate,
> +};
> +
> +static const struct udevice_id gcc_ipq5210_of_match[] = {
> +	{
> +		.compatible = "qcom,ipq5210-gcc",
> +		.data = (ulong)&ipq5210_gcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_ipq5210) = {
> +	.name		= "gcc_ipq5210",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_ipq5210_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};

