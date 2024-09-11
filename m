Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6CBEE499D
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 12:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE124892A8;
	Wed, 11 Sep 2024 14:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PEgcL2Zm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87E6E8898B; Wed, 11 Sep 2024 14:15:33 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E80892AB
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 14:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a8d56155f51so228019566b.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 05:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056928; x=1726661728; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CTdFvdtXjbkd6rR6yH3xrsvEOpZPAe6Oue97laKa804=;
 b=PEgcL2ZmNyu/0W+jfH5X0GIQ8TBoXnIP4KfKXWAnH7NLU4UQRZqb27HdcCvZ47K3hL
 sxLWhwNN78hjub7zQbgwI18EEbAJMYvmSbbms/bVDhejSlHQTxDXCsY0v9caCcEzYA4i
 +q3R+htD5cxYzR8kHKXCpebRJ72zoSrNJ+qKqpkbQ+SKVChzQ/2gjQ8dCUkQV4OqlDhJ
 gXlxh+L2x6qv52SuThAExPAny+jA5av3dL6xDGf1/Tg6GkC8STNuu+5GcDBJRYvToVGk
 hQII9NwY5KfUKY4WtuF4hKzcikZ8ZToAK6puME4H/6YVYLdkhttOtKXw36g6gqfjGS9J
 HHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056928; x=1726661728;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CTdFvdtXjbkd6rR6yH3xrsvEOpZPAe6Oue97laKa804=;
 b=dtFjZwpSDsFCmioElCHuZ3HHdOhCO1jXvLRpdLoyaNUMBW7stuL6l0WT7zdQHsQoWt
 MQXpoYU+zshfw4JUwPllf0yMnUIp+F6WNcIz6KyaBDQQWNgtRaX6cJZFi//xe9SA/FdV
 PRJ6tUY2OEA704FzM9A2sGozGZAF+NF+8XO8Yg5DaZDRSmv/qtiPfgAPiNEed+8b+P7Y
 Pq/qAvaNarY3YdU5ITEi47mIrTtqiNupNi7F8cBueSby1xpgL0R00VAwr1C+WNJZDh35
 b9Oa1sFFOy5HVnnTiGg+2E+TAQ5jMKDqMffysHYhSUXIEeE4RBcsEgzYquJb3ig7dfSj
 B7FA==
X-Gm-Message-State: AOJu0YwYG2lcP3g9OKTJXe8QgrjA8rBvsK2wkUpnLag67r4dLxGEMBhv
 cxKVMvjrBcv3uIkMWezzk5sJ9cmaKR+qnJlqCZ6oc4FayaoWqZN5TuqqUEj0MVXhO3zGEu7bOCp
 i
X-Google-Smtp-Source: AGHT+IFABVoRDlDe4UQsaAei3UmiaxGIEO23YQzCVqEv2JmdOLNFiHmgJVxRcDYjqRdMuLD458/QhA==
X-Received: by 2002:a17:906:7949:b0:a86:8f7b:9f19 with SMTP id
 a640c23a62f3a-a9004a46f6dmr283498366b.52.1726056927673; 
 Wed, 11 Sep 2024 05:15:27 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8db? ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a902298d682sm5641166b.59.2024.09.11.05.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 05:15:27 -0700 (PDT)
Message-ID: <c4ff30a8-3cf7-4546-9458-a2a7d56439b0@linaro.org>
Date: Wed, 11 Sep 2024 14:15:25 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 1/3] clk: qcom: add driver for SM8150 SoC
Content-Language: en-US
To: Julius Lehmann <lehmanju@devpi.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
References: <20240911-sm8150-patches-v2-0-0a32c6b6db1a@devpi.de>
 <20240911-sm8150-patches-v2-1-0a32c6b6db1a@devpi.de>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240911-sm8150-patches-v2-1-0a32c6b6db1a@devpi.de>
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

Hi Julias,

On 11/09/2024 10:42, Julius Lehmann wrote:
> Add clock, reset and power domain driver for SM8150. Driver code is
> based on the similar U-Boot drivers. All constants are taken from the
> corresponding Linux driver.
> 
> This driver supports clock rate setting only debug UART,
> RGMII/Ethernet modules and USB controller.
> 
> Co-authored-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
> ---
>  drivers/clk/qcom/Kconfig        |   9 ++
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/clock-sm8150.c | 300 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 310 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 0d2c0ac225..d76fca5dba 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -63,12 +63,21 @@ config CLK_QCOM_SM6115
>  	  on the Snapdragon SM6115 SoC. This driver supports the clocks
>  	  and resets exposed by the GCC hardware block.
>  
> +config CLK_QCOM_SM8150
> +	bool "Qualcomm SM8150 GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon 8150 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>  config CLK_QCOM_SM8250
>  	bool "Qualcomm SM8250 GCC"
>  	select CLK_QCOM
>  	help
>  	  Say Y here to enable support for the Global Clock Controller
>  	  on the Snapdragon SM8250 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
>  
>  config CLK_QCOM_SM8550
>  	bool "Qualcomm SM8550 GCC"
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index e223c131ee..c47b9f6f78 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
>  obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
>  obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
>  obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
> +obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
> diff --git a/drivers/clk/qcom/clock-sm8150.c b/drivers/clk/qcom/clock-sm8150.c
> new file mode 100644
> index 0000000000..74e75c86a1
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-sm8150.c
> @@ -0,0 +1,300 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Clock drivers for Qualcomm SM8150
> + *
> + * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> + * Copyright (c) 2024 EPAM Systems.
> + *
> + * (C) Copyright 2024 Julius Lehmann <lehmanju@devpi.de>
> + *
> + * Based on U-Boot driver for SM8250. Constants are taken from the Linux driver.
> + */
> +
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <errno.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,gcc-sm8150.h>
> +
> +#include "clock-qcom.h"
> +
> +#define EMAC_RGMII_CLK_CMD_RCGR 0x601c
> +#define QUPV3_WRAP0_S0_CLK_CMD_RCGR 0x18148
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf01c
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf034
> +#define USB30_PRIM_PHY_AUX_CLK_CMD_RCGR 0xf060
> +#define USB30_SEC_MASTER_CLK_CMD_RCGR 0x1001c
> +#define USB30_SEC_MOCK_UTMI_CLK_CMD_RCGR 0x10034
> +#define USB30_SEC_PHY_AUX_CLK_CMD_RCGR 0x10060
> +
> +static struct pll_vote_clk gpll7_vote_clk = {
> +	.status = 0x1a000,
> +	.status_bit = BIT(31),
> +	.ena_vote = 0x52000,
> +	.vote_bit = BIT(7),
> +};
> +
> +static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
> +	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
> +	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
> +	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
> +	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
> +	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
> +	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
> +	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
> +	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
> +	F(102400000, CFG_CLK_SRC_GPLL0_EVEN, 1, 128, 375),
> +	F(112000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 28, 75),
> +	F(117964800, CFG_CLK_SRC_GPLL0_EVEN, 1, 6144, 15625),
> +	F(120000000, CFG_CLK_SRC_GPLL0_EVEN, 2.5, 0, 0),
> +	F(128000000, CFG_CLK_SRC_GPLL0, 1, 16, 75),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_emac_rgmii_clk_src[] = {
> +	F(2500000, CFG_CLK_SRC_CXO, 1, 25, 192),
> +	F(5000000, CFG_CLK_SRC_CXO, 1, 25, 96),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
> +	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
> +	F(125000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
> +	F(250000000, CFG_CLK_SRC_GPLL7, 2, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
> +	F(33333333, CFG_CLK_SRC_GPLL0_EVEN, 9, 0, 0),
> +	F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
> +	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
> +	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
> +	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb30_prim_mock_utmi_clk_src[] = {
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 15, 0, 0),
> +	F(60000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 0, 0),
> +	{ }
> +};
> +
> +static ulong sm8150_clk_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
> +
> +	switch (clk->id) {
> +	case GCC_QUPV3_WRAP1_S4_CLK: /* UART2 aka debug-uart */
> +		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S0_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 16);
> +		return freq->freq;
> +	case GCC_EMAC_RGMII_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_emac_rgmii_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, EMAC_RGMII_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_mock_utmi_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 0);
> +		return freq->freq;
> +	case GCC_USB3_PRIM_PHY_AUX_CLK_SRC:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_mock_utmi_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_PHY_AUX_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 0);
> +		return freq->freq;
> +	case GCC_USB30_SEC_MASTER_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_SEC_MASTER_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_USB30_SEC_MOCK_UTMI_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_mock_utmi_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_SEC_MOCK_UTMI_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 0);
> +		return freq->freq;
> +	case GCC_USB3_SEC_PHY_AUX_CLK_SRC:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_mock_utmi_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_SEC_PHY_AUX_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 0);
> +		return freq->freq;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct gate_clk sm8150_clks[] = {
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,		0xf07c, 0x00000001),
> +	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK,		0x1007c, 0x00000001),
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0xf078, 0x00000001),
> +	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK,		0x10078, 0x00000001),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,		0x5200c, 0x00000400),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,		0x5200c, 0x00000800),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK,		0x5200c, 0x00001000),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK,		0x5200c, 0x00002000),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK,		0x5200c, 0x00004000),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK,		0x5200c, 0x00008000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK,		0x5200c, 0x00400000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK,		0x5200c, 0x00800000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK,		0x5200c, 0x02000000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK,		0x5200c, 0x04000000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK,		0x5200c, 0x08000000),
> +	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK,		0x5200c, 0x00000040),
> +	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK,		0x5200c, 0x00000080),
> +	GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK,		0x5200c, 0x00100000),
> +	GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK,		0x5200c, 0x00200000),
> +	GATE_CLK(GCC_SDCC2_AHB_CLK,			0x14008, 0x00000001),
> +	GATE_CLK(GCC_SDCC2_APPS_CLK,			0x14004, 0x00000001),
> +	GATE_CLK(GCC_SDCC4_AHB_CLK,			0x16008, 0x00000001),
> +	GATE_CLK(GCC_SDCC4_APPS_CLK,			0x16004, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_AHB_CLK,			0x75010, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_AXI_CLK,			0x7500c, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_CLKREF_CLK,		0x8c004, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_ICE_CORE_CLK,		0x75058, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_PHY_AUX_CLK,		0x7508c, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_0_CLK,		0x75018, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_1_CLK,		0x750a8, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_TX_SYMBOL_0_CLK,		0x75014, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_UNIPRO_CORE_CLK,		0x75054, 0x00000001),
> +	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK,		0x8c000, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_AHB_CLK,			0x77010, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_AXI_CLK,			0x7700c, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,		0x77058, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,		0x7708c, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,		0x77018, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK,		0x770a8, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,		0x77014, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,		0x77054, 0x00000001),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,		0x0f00c, 0x00000001),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,		0x0f014, 0x00000001),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,		0x0f010, 0x00000001),
> +	GATE_CLK(GCC_USB30_SEC_MASTER_CLK,		0x1000c, 0x00000001),
> +	GATE_CLK(GCC_USB30_SEC_MOCK_UTMI_CLK,		0x10014, 0x00000001),
> +	GATE_CLK(GCC_USB30_SEC_SLEEP_CLK,		0x10010, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK,		0x8c008, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,		0x0f04c, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,		0x0f050, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,		0x0f054, 0x00000001),
> +	GATE_CLK(GCC_USB3_SEC_CLKREF_CLK,		0x8c028, 0x00000001),
> +	GATE_CLK(GCC_USB3_SEC_PHY_AUX_CLK,		0x1004c, 0x00000001),
> +	GATE_CLK(GCC_USB3_SEC_PHY_PIPE_CLK,		0x10054, 0x00000001),
> +	GATE_CLK(GCC_USB3_SEC_PHY_COM_AUX_CLK,		0x10050, 0x00000001),
> +	GATE_CLK(GCC_EMAC_AXI_CLK,			0x06010, 0x00000001),
> +	GATE_CLK(GCC_EMAC_SLV_AHB_CLK,			0x06014, 0x00000001),
> +	GATE_CLK(GCC_EMAC_PTP_CLK,			0x06034, 0x00000001),
> +	GATE_CLK(GCC_EMAC_RGMII_CLK,			0x06018, 0x00000001),
> +};
> +
> +static int sm8150_clk_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks < clk->id) {

I hit a bug here on other platforms, this should actually be num_clks <=
clk->id

With that fixed

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Thanks!
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %s\n", __func__, sm8150_clks[clk->id].name);
> +
> +	switch (clk->id) {
> +	case GCC_EMAC_RGMII_CLK:
> +		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
> +	case GCC_AGGRE_USB3_PRIM_AXI_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB30_PRIM_MASTER_CLK);
> +		fallthrough;
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
> +		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
> +		break;
> +	case GCC_AGGRE_USB3_SEC_AXI_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB30_SEC_MASTER_CLK);
> +		fallthrough;
> +	case GCC_USB30_SEC_MASTER_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_AUX_CLK);
> +		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
> +		break;
> +	};
> +
> +	qcom_gate_clk_en(priv, clk->id);
> +
> +	return 0;
> +}
> +
> +static const struct qcom_reset_map sm8150_gcc_resets[] = {
> +	[GCC_EMAC_BCR] = { 0x6000 },
> +	[GCC_GPU_BCR] = { 0x71000 },
> +	[GCC_MMSS_BCR] = { 0xb000 },
> +	[GCC_NPU_BCR] = { 0x4d000 },
> +	[GCC_PCIE_0_BCR] = { 0x6b000 },
> +	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
> +	[GCC_PCIE_1_BCR] = { 0x8d000 },
> +	[GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
> +	[GCC_PCIE_PHY_BCR] = { 0x6f000 },
> +	[GCC_PDM_BCR] = { 0x33000 },
> +	[GCC_PRNG_BCR] = { 0x34000 },
> +	[GCC_QSPI_BCR] = { 0x24008 },
> +	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x17000 },
> +	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
> +	[GCC_QUPV3_WRAPPER_2_BCR] = { 0x1e000 },
> +	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
> +	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
> +	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
> +	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
> +	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
> +	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
> +	[GCC_SDCC2_BCR] = { 0x14000 },
> +	[GCC_SDCC4_BCR] = { 0x16000 },
> +	[GCC_TSIF_BCR] = { 0x36000 },
> +	[GCC_UFS_CARD_BCR] = { 0x75000 },
> +	[GCC_UFS_PHY_BCR] = { 0x77000 },
> +	[GCC_USB30_PRIM_BCR] = { 0xf000 },
> +	[GCC_USB30_SEC_BCR] = { 0x10000 },
> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
> +};
> +
> +static const struct qcom_power_map sm8150_gcc_power_domains[] = {
> +	[EMAC_GDSC] = { 0x6004 },
> +	[PCIE_0_GDSC] = { 0x6b004 },
> +	[PCIE_1_GDSC] = { 0x8d004 },
> +	[UFS_CARD_GDSC] = { 0x75004 },
> +	[UFS_PHY_GDSC] = { 0x77004 },
> +	[USB30_PRIM_GDSC] = { 0xf004 },
> +	[USB30_SEC_GDSC] = { 0x10004 },
> +};
> +
> +static struct msm_clk_data sm8150_clk_data = {
> +	.resets = sm8150_gcc_resets,
> +	.num_resets = ARRAY_SIZE(sm8150_gcc_resets),
> +	.clks = sm8150_clks,
> +	.num_clks = ARRAY_SIZE(sm8150_clks),
> +	.power_domains = sm8150_gcc_power_domains,
> +	.num_power_domains = ARRAY_SIZE(sm8150_gcc_power_domains),
> +
> +	.enable = sm8150_clk_enable,
> +	.set_rate = sm8150_clk_set_rate,
> +};
> +
> +static const struct udevice_id gcc_sm8150_of_match[] = {
> +	{
> +		.compatible = "qcom,gcc-sm8150",
> +		.data = (ulong)&sm8150_clk_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_sm8150) = {
> +	.name		= "gcc_sm8150",
> +	.id             = UCLASS_NOP,
> +	.of_match	= gcc_sm8150_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC,
> +};
> 

-- 
// Caleb (they/them)
