Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0287DC3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 12:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B295C829E7;
	Fri,  9 May 2025 14:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qnuXK9U7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 965178210D; Fri,  9 May 2025 13:07:12 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C8458059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 13:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso9053995e9.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746788830; x=1747393630; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5CKTOfdpQxo+UZwF+Mqfgnkab7QrIvOlAIwuCJJf84M=;
 b=qnuXK9U7gyZRiyy/0Pd86VCgHpMEqZc4qoRlLDWJO/PlL9w1FvhIiWdU5jRf4gLGju
 H/MV5mmcJ9TTdL8+zeoYdcxOalsS2gioXl6ClyhAquhubXn3F8/tUpIRdjrXMPN/1g/P
 ofTT29BS9zuixKef1rDbjuC8vRNm7CTGchD/+hy0IZOSdxbzHreYrRvJJVAI1a1Dxt27
 MDaPLRqJ6vqg9xhEx2BSDMPZZOk61eW3Q7GDwVQk+5Qa8fEpLrd4TVe1epKKaV5EuW8l
 T0uWLFwY8ujQmT4jaY5r+MHyIvxkIUwE/hbu0kVasFYcsvBna5HnnfLp6x+UfvEVe6mK
 M7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746788830; x=1747393630;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5CKTOfdpQxo+UZwF+Mqfgnkab7QrIvOlAIwuCJJf84M=;
 b=LWOjRxe9zb/U8HAnWpwNaQmnk/2RdN9/i7zwo6m0tLaiDRk3+Te7F2QDk/8cqsB6pl
 rr/xjtSiMFQWd2O7ZXYmsJR+LEEaekJbVWQGdk6+hp7ST4jR6qD2KAK9GeqtVoiesHrm
 fOAA2+rlCdiPyfDYLdcwPs5KzrzuUkshPdHYd+5DxLEDlwyZTE/kHoXPrKfwMBfk3mL8
 slz7PJB+/gVu7PY+ZY4b61sBl8t+BhLaN/IkdCmQm2goVf7abKcfBkzSTF4OnNHsOaBx
 pp/6LDZdZa4ic34YpxcK5fKZdwgFprtea98MSWdMJWI5I3HDitaY0PLCP6iCf1p/BOBJ
 ryFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9nYRav5meaa1JbeXMfBFyFoCO6PUw7q5ySPGPHTRpANUhG03AvGODRl00vRQZE2bc+sbzeGs=@lists.denx.de
X-Gm-Message-State: AOJu0YwGdQazmUaliWFSkhmxok3eAlXnLpN27/tc+xwCH7Xq4jzq8xdF
 wvQC0pbtZIYFnF+bMiqb6qmR7pCaWxSESOKMapIXkEe4zSLrEAl42+GpneIUtwc=
X-Gm-Gg: ASbGncub0A5lTCAljXm548MURGZRQTYwtHuWduTCoOAwSn8ks5uRR2eThZNFXPSNFp1
 v4qTmf+pH+K3Cr1ge/XEL/ZgYfbOnKx6JtBhg3iN/AJeHXC1SpRojkQJpCrD3RDuur7luMZ12Tb
 3USVp5r4QaM4OeukuHKrO4kaWV54mLSf0TMtpM3o6AreIbctP+cEPYTN1Mp2z4bXbjmivh5UqPc
 SCfAdptv71WaNss2sCxQqZAUtH1UuSkkbcNWHZMh+ueO9QoVXRSNUiiFExl6XRSJYZVqJol3qAd
 JMj+2Nq4DAW7rGugswdOUKvoenO4chJv7ZG2fXVBaUr4uVDhdemuauqv9l+TDHllLxCM6NlXPf0
 bJtaeF35T9bzmCg==
X-Google-Smtp-Source: AGHT+IHoRwX4a/GpN3MKFtYKbPDNS5CpFJKOMIRHJLi7zad2ij2hxyV7FloEMZCWDEiT4ReM1FkaWA==
X-Received: by 2002:a05:600c:c0d2:20b0:43c:fa3f:8e5d with SMTP id
 5b1f17b1804b1-442d77fa124mr13091095e9.2.1746788829764; 
 Fri, 09 May 2025 04:07:09 -0700 (PDT)
Received: from [172.18.195.54] (ip-185-104-138-77.ptr.icomera.net.
 [185.104.138.77]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67d74b5sm26210095e9.2.2025.05.09.04.07.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 04:07:08 -0700 (PDT)
Message-ID: <39db616a-991c-4a64-aa5e-25c3853ee69d@linaro.org>
Date: Fri, 9 May 2025 13:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] clk/qcom: qcs8300: Add GCC clock driver for QCS8300
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
 <20250508111952.2304578-4-balaji.selvanathan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250508111952.2304578-4-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 09 May 2025 14:39:39 +0200
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



On 5/8/25 13:19, Balaji Selvanathan wrote:
> * Port Linux's gcc-qcs8300.c driver to U-Boot for basic bring-up.
> 
> * Enable QCS8300 clocks in qcom_defconfig.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/clk/qcom/Kconfig         |   8 ++
>   drivers/clk/qcom/Makefile        |   1 +
>   drivers/clk/qcom/clock-qcs8300.c | 146 +++++++++++++++++++++++++++++++
>   3 files changed, 155 insertions(+)
>   create mode 100644 drivers/clk/qcom/clock-qcs8300.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 3ea01f3c969..a226a787af8 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -63,6 +63,14 @@ config CLK_QCOM_SA8775P
>   	  on the Snapdragon SA8775 SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_QCS8300

Alphabetical order please

> +	bool "Qualcomm QCS8300 GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon QCS8300 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>   config CLK_QCOM_SDM845
>   	bool "Qualcomm SDM845 GCC"
>   	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index e13fc8c1071..7e544bc5407 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
>   obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>   obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
>   obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
> +obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o

Same here

With that:

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

>   obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
>   obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
>   obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
> diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/clock-qcs8300.c
> new file mode 100644
> index 00000000000..f0b9a0b4fd5
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-qcs8300.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024-2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + */
> +
> +#include <linux/types.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,qcs8300-gcc.h>
> +#include "clock-qcom.h"
> +
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
> +
> +static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (clk->id < priv->data->num_clks)
> +		debug("%s: %s, requested rate=%ld\n",
> +		      __func__, priv->data->clks[clk->id].name, rate);
> +
> +	switch (clk->id) {
> +	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
> +		WARN(rate != 19200000, "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
> +		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
> +		return rate;
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
> +				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
> +		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
> +		return rate;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct gate_clk qcs8300_clks[] = {
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, 1),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, 1),
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, 1),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, 1),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, 1),
> +	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x83020, 1),
> +	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x83018, 1),
> +	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, 1),
> +	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, 1),
> +};
> +
> +static int qcs8300_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks < clk->id) {
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %ld: %s\n", __func__, clk->id, qcs8300_clks[clk->id].name);
> +
> +	switch (clk->id) {
> +	case GCC_AGGRE_USB3_PRIM_AXI_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB30_PRIM_MASTER_CLK);
> +		fallthrough;
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
> +		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
> +		break;
> +	}
> +
> +	qcom_gate_clk_en(priv, clk->id);
> +
> +	return 0;
> +}
> +
> +static const struct qcom_reset_map qcs8300_gcc_resets[] = {
> +	[GCC_EMAC0_BCR] = { 0xb6000 },
> +	[GCC_PCIE_0_BCR] = { 0xa9000 },
> +	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0xbf000 },
> +	[GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0xbf008 },
> +	[GCC_PCIE_0_PHY_BCR] = { 0xa9144 },
> +	[GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR] = { 0xbf00c },
> +	[GCC_PCIE_1_BCR] = { 0x77000 },
> +	[GCC_PCIE_1_LINK_DOWN_BCR] = { 0xae084 },
> +	[GCC_PCIE_1_NOCSR_COM_PHY_BCR] = { 0xae090 },
> +	[GCC_PCIE_1_PHY_BCR] = { 0xae08c },
> +	[GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR] = { 0xae094 },
> +	[GCC_SDCC1_BCR] = { 0x20000 },
> +	[GCC_UFS_PHY_BCR] = { 0x83000 },
> +	[GCC_USB20_PRIM_BCR] = { 0x1c000 },
> +	[GCC_USB2_PHY_PRIM_BCR] = { 0x5c01c },
> +	[GCC_USB2_PHY_SEC_BCR] = { 0x5c020 },
> +	[GCC_USB30_PRIM_BCR] = { 0x1b000 },
> +	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x5c008 },
> +	[GCC_USB3_PHY_PRIM_BCR] = { 0x5c000 },
> +	[GCC_USB3_PHY_TERT_BCR] = { 0x5c024 },
> +	[GCC_USB3_UNIPHY_MP0_BCR] = { 0x5c00c },
> +	[GCC_USB3_UNIPHY_MP1_BCR] = { 0x5c010 },
> +	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x5c004 },
> +	[GCC_USB3UNIPHY_PHY_MP0_BCR] = { 0x5c014 },
> +	[GCC_USB3UNIPHY_PHY_MP1_BCR] = { 0x5c018 },
> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x76000 },
> +	[GCC_VIDEO_BCR] = { 0x34000 },
> +};
> +
> +static const struct qcom_power_map qcs8300_gdscs[] = {
> +	[GCC_UFS_PHY_GDSC] = { 0x83004 },
> +	[GCC_USB30_PRIM_GDSC] = { 0x1B004 },
> +};
> +
> +static struct msm_clk_data qcs8300_gcc_data = {
> +	.resets = qcs8300_gcc_resets,
> +	.num_resets = ARRAY_SIZE(qcs8300_gcc_resets),
> +	.clks = qcs8300_clks,
> +	.num_clks = ARRAY_SIZE(qcs8300_clks),
> +
> +	.power_domains = qcs8300_gdscs,
> +	.num_power_domains = ARRAY_SIZE(qcs8300_gdscs),
> +
> +	.enable = qcs8300_enable,
> +	.set_rate = qcs8300_set_rate,
> +};
> +
> +static const struct udevice_id gcc_qcs8300_of_match[] = {
> +	{
> +		.compatible = "qcom,qcs8300-gcc",
> +		.data = (ulong)&qcs8300_gcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_qcs8300) = {
> +	.name		= "gcc_qcs8300",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_qcs8300_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};

-- 
Casey (she/they)

