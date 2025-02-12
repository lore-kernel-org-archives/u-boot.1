Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C3DC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 15:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8801180BAD;
	Wed, 12 Feb 2025 16:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ac/7N+42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B80C80C69; Wed, 12 Feb 2025 16:14:15 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB26B809D0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 16:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-439307d83f0so29282715e9.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 07:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739373251; x=1739978051; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vAS3pU8jsaQ13UIOZFengtyQpIgbNWgkS4FUXUOp2Vg=;
 b=Ac/7N+42Mco7EtZGjhuEdGQS8lTrUQTI7wKreoo4JEii49y3SNuBegdaibBpBBaWnA
 IPGGOVqQtFPIlb8qa54A2MGnDe+Zb24yEn2/swTi8paE0cUYnXkkLUew1mclXILF95t1
 JEfnljGvLueYRLFZh7NckaUXhGxUmJfKFYS7YjAOZFr9x8+WDmIw4zqQkYz7pCF9i2JX
 eyXro73sLsnH9CnKF5rnMggvNKjKgChhsuB0kMN5ZSLIFNzeTVCKUOM3Sw5UsnOm36JS
 +Ehj9M7y7MveII4CPwPzlEkKLseKQoX619sHsO2iNK6XWDjNuPymuP5Q6Fv6KpYoB9yt
 0z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739373251; x=1739978051;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vAS3pU8jsaQ13UIOZFengtyQpIgbNWgkS4FUXUOp2Vg=;
 b=jTJIASGkI0W+cTR+CVBIeeMqGOK/HlgicBJ0sA7WHCIy/Us07iQ/jP0npNgwe7QTz6
 NoQ7T/W8FF7VEzv1lBeYbweZCpw7cHziKZMrJr48yx+RA6fRAaDtvAOdJWu+0Et5tF50
 jzZUH6B1b5YGmW0XdIe3C8ag6e5SABC7jl5Y5n/45srede3Mizy1P+bpVm4fXCw76qbN
 0UjNFtSspHgW6xn0XZwFMzbhN3zwam04ktsIihKGAEl65M92l/CUREpIgzamQ+2J0Qir
 0DY3D/AyyhnkT4bjHgZGV4xwb92DnfiMELoTNzjQKOOqJNWZBko19tV7ncEp5jdhZKrp
 Czvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3kGaUKDfq9O0IFNUI8blDvA9A7R4IB7RnnPAhic5sH6H+4Yt9fVIt+NPV7mPkVfvzwEz/tKo=@lists.denx.de
X-Gm-Message-State: AOJu0YzVcMkLslydS1TE4Cs0RxOBDrukOYAXYEprgBLAleAtsPDge0c2
 gvtLAPVnNYY547ke3YEfx5rR2rCnJZXJibDr+infJg1vRnQdkzIehUqrf3WLbEY=
X-Gm-Gg: ASbGncv4JpnzGfRBmkP7umfrXv2EUO7LLFWduusmsYHByQKJPtQtzB6J3p4m9hVCBjp
 DNn5lVc+N/hflum4DLbVvtATxyzodnk09eWFH/KpNxwJvfcCpy1dBi0skOj4Pdwa7slrShERq/l
 ktb2s5uEvp0H/NnNebvQina1Af77a8Krov3u3f+QokGvWdT19f3XsH9PqJcO3iIDzQvzxVLhDYI
 KZfmCb1igdNj13Y0P7nThiCgSBrc0MDw83plIEEjqf+ThjQ57s0KzSqg1hb0yevTzAGLkdbsGxS
 9YQTHENv+QFH7KjxF4heZu/xy6ko9TYREdjzggU7cYOw6JI2AUPhpQXhgAX1XSEXA8krlg==
X-Google-Smtp-Source: AGHT+IG2fQIzYX4jOYvrvF2Bkx23P3QFUmuoBmEz+UKDuICkiYO2lJpXhiMvQTOmlMVkDGWBKLtpbg==
X-Received: by 2002:a05:6000:1445:b0:38d:d9b3:5916 with SMTP id
 ffacd0b85a97d-38dea251e4bmr3173211f8f.1.1739373251459; 
 Wed, 12 Feb 2025 07:14:11 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:416b:3913:893e:bb4?
 ([2a0a:ef40:1d11:ab01:416b:3913:893e:bb4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dde7d3f8asm8357394f8f.21.2025.02.12.07.14.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 07:14:10 -0800 (PST)
Message-ID: <bfc6f1ee-260c-4c47-abda-46dbd12f27e9@linaro.org>
Date: Wed, 12 Feb 2025 15:14:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] clk/qcom: add initial clock driver for ipq9574
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, sjg@chromium.org, Volodymyr_Babchuk@epam.com,
 lehmanju@devpi.de, pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 robert.marko@sartura.hr, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250130053751.3148614-1-quic_varada@quicinc.com>
 <20250130053751.3148614-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250130053751.3148614-3-quic_varada@quicinc.com>
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



On 1/30/25 05:37, Varadarajan Narayanan wrote:
> Add initial set of clocks and resets for enabling U-Boot on ipq9574
> based RDP platforms.

What is RDP?
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Combined driver file and makefile/kconfig changes into one patch
> ---
>   drivers/clk/qcom/Kconfig         |   8 +++
>   drivers/clk/qcom/Makefile        |   1 +
>   drivers/clk/qcom/clock-ipq9574.c | 100 +++++++++++++++++++++++++++++++
>   drivers/clk/qcom/clock-qcom.h    |   1 +
>   4 files changed, 110 insertions(+)
>   create mode 100644 drivers/clk/qcom/clock-ipq9574.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index cb867acc48..3ea01f3c96 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -31,6 +31,14 @@ config CLK_QCOM_IPQ4019
>   	  on the Snapdragon IPQ4019 SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_IPQ9574
> +	bool "Qualcomm IPQ9574 GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon IPQ9574 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>   config CLK_QCOM_QCM2290
>   	bool "Qualcomm QCM2290 GCC"
>   	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 1bc0f15005..e13fc8c107 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
>   obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
>   obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
>   obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
> +obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
>   obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>   obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
>   obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
> diff --git a/drivers/clk/qcom/clock-ipq9574.c b/drivers/clk/qcom/clock-ipq9574.c
> new file mode 100644
> index 0000000000..06f2d2dd45
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-ipq9574.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock drivers for Qualcomm ipq9574
> + *
> + * (C) Copyright 2024 Linaro Ltd.
> + */
> +
> +#include <linux/types.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> +#include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> +
> +#include "clock-qcom.h"
> +
> +#define GCC_BLSP1_AHB_CBCR			0x1004
> +#define GCC_BLSP1_UART3_APPS_CMD_RCGR		0x402C
> +#define GCC_BLSP1_UART3_APPS_CBCR		0x4054
> +
> +#define GCC_SDCC1_APPS_CBCR			0x3302C
> +#define GCC_SDCC1_AHB_CBCR			0x33034
> +#define GCC_SDCC1_APPS_CMD_RCGR			0x33004
> +#define GCC_SDCC1_ICE_CORE_CBCR			0x33030
> +
> +static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	switch (clk->id) {
> +	case GCC_BLSP1_UART3_APPS_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, GCC_BLSP1_UART3_APPS_CMD_RCGR,
> +				     0, 144, 15625, CFG_CLK_SRC_GPLL0, 16);
> +		return rate;
> +	case GCC_SDCC1_APPS_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CMD_RCGR,
> +				     11, 0, 0, CFG_CLK_SRC_GPLL2, 16);
> +		return rate;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ipq9574_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	//printk("--> %s: %d\n", __func__, clk->id);

Remove or demote to debug, with gate_clk you can include the clock name 
as well.
> +	switch (clk->id) {
> +	case GCC_BLSP1_UART3_APPS_CLK:
> +		clk_enable_cbc(priv->base + GCC_BLSP1_UART3_APPS_CBCR);
> +		break;
> +	case GCC_BLSP1_AHB_CLK:
> +		clk_enable_cbc(priv->base + GCC_BLSP1_AHB_CBCR);
> +		break;
> +	case GCC_SDCC1_AHB_CLK:
> +		clk_enable_cbc(priv->base + GCC_SDCC1_AHB_CBCR);
> +		break;
> +	case GCC_SDCC1_APPS_CLK:
> +		clk_enable_cbc(priv->base + GCC_SDCC1_APPS_CBCR);
> +		break;
> +	case GCC_SDCC1_ICE_CORE_CLK:
> +		clk_enable_cbc(priv->base + GCC_SDCC1_ICE_CORE_CBCR);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Please use the gate_clk API for these, refer to clock-sdm845.c for 
reference.

With that:

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Kind regards,
> +
> +	return 0;
> +}
> +
> +static const struct qcom_reset_map ipq9574_gcc_resets[] = {
> +	[GCC_SDCC_BCR] = { 0x33000 },
> +};
> +
> +static struct msm_clk_data ipq9574_gcc_data = {
> +	.resets = ipq9574_gcc_resets,
> +	.num_resets = ARRAY_SIZE(ipq9574_gcc_resets),
> +	.enable = ipq9574_enable,
> +	.set_rate = ipq9574_set_rate,
> +};
> +
> +static const struct udevice_id gcc_ipq9574_of_match[] = {
> +	{
> +		.compatible = "qcom,ipq9574-gcc",
> +		.data = (ulong)&ipq9574_gcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_ipq9574) = {
> +	.name		= "gcc_ipq9574",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_ipq9574_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index ff336dea39..e038dc421e 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -11,6 +11,7 @@
>   #define CFG_CLK_SRC_CXO   (0 << 8)
>   #define CFG_CLK_SRC_GPLL0 (1 << 8)
>   #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
> +#define CFG_CLK_SRC_GPLL2 (2 << 8)
>   #define CFG_CLK_SRC_GPLL9 (2 << 8)
>   #define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
>   #define CFG_CLK_SRC_GPLL6 (4 << 8)

-- 
Caleb (they/them)

