Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C36E7E0D9
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 19:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACD128388D;
	Mon,  9 Feb 2026 20:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wFuW6jXh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7831C83C29; Mon,  9 Feb 2026 20:51:01 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6A20802C1
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 20:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so101853f8f.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 11:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770666658; x=1771271458; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6zPbU+9IJ0q3daaTyKoV8vmukbgkjV9Jsmxy7qUsu7I=;
 b=wFuW6jXhU2AwreUGK5XBTaOk3vSMaI/PP/MDjzTV7pwwX1/XOxTQcjx7iQXo/HkOvf
 Gc0HsAGbyMuQCKfZI01MZROUVeGO6I5PrSDFUcB54IbOneso8rOrOaeUCPbG2a9Q5Aqe
 zVYPUyfHhurTuhTkyjVGnxS8gMnVmkCT9+vYX0fjnOXKQ7uxWypJkrLvU4i5XMd24kbL
 cKMOfFwZ+H9oECiwdEQLSJamkNz8XwIuOEyamMNFlkVKskt5nMl6wD/mS/Mh9w1mNZtl
 eAzexguNL3V0i4yN7GBsfTr5B1bJavn/mIrI9D/IrLxe134EsLZoB6SmqhU5UfG0EVDc
 hPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770666658; x=1771271458;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6zPbU+9IJ0q3daaTyKoV8vmukbgkjV9Jsmxy7qUsu7I=;
 b=vtUsJE8wQ+Zd4Usxe0ze4OTAcCSdfn3kNA4b1T6IZUSsdlMANsMctI4fK31I7nmkM2
 VgzKtP/cRNFd/9nb3syJQ9YjoDA8Fwq1Gmbh+oqzzsgsPUdKNbntT3cU2hIIih6OPVzy
 q7qAPHVmCkpXD9r3U/lbBrdZtgM0bQbs7Bw3U4VV0COkwx5gIzLdl6ZnMTF68b+arC5V
 NZdeD3/+EsuURdy3VqaFt0aCySXrxNc9aFsaPYIOJyyeeHlQln9DsFhNHJTkZ0rMIctk
 D1aV/mMWpP4EGarc/T5YTkApBrd29PoZkdVtngVYGFZJN3cgBU3BCmlNUfpyUUCmuH0l
 I9SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQQRFgLS6k0MXXrrdF2jEKdnca+FEZceW6PKg5jz7uvF2Rnu+EVpfz9MTBnrd4S4eRqnMowIc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+xwB5TfGyMrw+65pWF+VhrSNk1Vepj+4tOj5IYtGanMeaxJJt
 I0KEQEWJhI8hwPT3WNgIa2P2YcCf3l2MBLKL0imixKHR6xCE4fnSGSTP3tZzHGUivIs=
X-Gm-Gg: AZuq6aITIdoEPqlFx/okExvp8mILBetvGi/lG5Kr2DQsTKLUXgGOFbvtaXkUmkA+oFS
 xFTnutGlS0lHjIWmfk6UeTZy0RJ1Pw5Mrk7weDqEzNQZdAQ16RwgI2qn+Ka7RuouYI2oRf7cbha
 AZMTWAD24blJdjemaujcS8QrS17qTxOQXlh1zBuBCUkfXPMxe7lpl8b+cxThd9/Q5ysqbbSOyyX
 JmgmB309roVH1nIRDB72omgCwNLC1RYg0njhNYPMekZZRPOCihfl1oaQARNrhRfjKdAoWsDTO2c
 CjFGs7EDkT2sjTGdUcZ6nrDn3pNYLiXQn3ad6UF9DBKSbvZXKyWBwEHqPQAIvW9N61E59AeFNfS
 2yTK59i6CxNmsnZaXEGq6VKOILDavNnvJTqgTha8eU7EufOwQv03f9H69Hkd0WzSGqGZcjOdKbY
 kxfak9x+OJK0DpT/mYXyzcyxKjT+QD939I7AZ5rW8WLM3YxZLnww==
X-Received: by 2002:a05:6000:381:b0:437:6dfe:1b89 with SMTP id
 ffacd0b85a97d-4376dfe1cf2mr8335775f8f.61.1770666658078; 
 Mon, 09 Feb 2026 11:50:58 -0800 (PST)
Received: from [192.168.1.36] (p5b29ea02.dip0.t-ipconnect.de. [91.41.234.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362974527fsm30086490f8f.31.2026.02.09.11.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 11:50:57 -0800 (PST)
Message-ID: <9533571a-cc85-4d10-8208-1b4810a0ec9e@linaro.org>
Date: Mon, 9 Feb 2026 20:50:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] clk/qcom: Add SM6125 clock driver
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
 <20260204-sm6125-clk-pinctrl-v1-1-9cf4c556557a@gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260204-sm6125-clk-pinctrl-v1-1-9cf4c556557a@gmail.com>
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

Hi Biswapriyo,

On 04/02/2026 17:10, Biswapriyo Nath wrote:
> Add clock driver for the GCC block found in the SM6125 SoC.
> 
> Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>

Super clean patch, and all the goodies for debugging too! Thanks a lot
for sending this.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>


> ---
>  drivers/clk/qcom/Kconfig        |   8 ++
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/clock-sm6125.c | 260 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 269 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 8504ed5d6..eb0851ef1 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -103,6 +103,14 @@ config CLK_QCOM_SM6115
>  	  on the Snapdragon SM6115 SoC. This driver supports the clocks
>  	  and resets exposed by the GCC hardware block.
>  
> +config CLK_QCOM_SM6125
> +	bool "Qualcomm SM6125 GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon SM6125 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>  config CLK_QCOM_SM6350
>  	bool "Qualcomm SM6350 GCC"
>  	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 82a5b1661..2a934688d 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
>  obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
>  obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
>  obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
> +obj-$(CONFIG_CLK_QCOM_SM6125) += clock-sm6125.o
>  obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
>  obj-$(CONFIG_CLK_QCOM_SM7150) += clock-sm7150.o
>  obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
> diff --git a/drivers/clk/qcom/clock-sm6125.c b/drivers/clk/qcom/clock-sm6125.c
> new file mode 100644
> index 000000000..1fd72d55e
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-sm6125.c
> @@ -0,0 +1,260 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Clock drivers for Qualcomm sm6125
> + *
> + * (C) Copyright 2026 Biswapriyo Nath <nathbappai@gmail.com>
> + *
> + */
> +
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/bug.h>
> +#include <dt-bindings/clock/qcom,gcc-sm6125.h>
> +
> +#include "clock-qcom.h"
> +
> +#define GCC_BASE 0x01400000
> +
> +#define QUPV3_WRAP0_S4_CMD_RCGR 0x1f608
> +#define SDCC1_APPS_CLK_CMD_RCGR 0x38028
> +#define SDCC2_APPS_CLK_CMD_RCGR 0x1e00c
> +
> +#define GCC_GPLL0_MODE 0x0
> +#define GCC_GPLL3_MODE 0x3000
> +#define GCC_GPLL4_MODE 0x4000
> +#define GCC_GPLL5_MODE 0x5000
> +#define GCC_GPLL6_MODE 0x6000
> +#define GCC_GPLL7_MODE 0x7000
> +#define GCC_GPLL8_MODE 0x8000
> +#define GCC_GPLL9_MODE 0x9000
> +
> +static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
> +	F(7372800, CFG_CLK_SRC_GPLL0_AUX2, 1, 384, 15625),
> +	F(14745600, CFG_CLK_SRC_GPLL0_AUX2, 1, 768, 15625),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(29491200, CFG_CLK_SRC_GPLL0_AUX2, 1, 1536, 15625),
> +	F(32000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 75),
> +	F(48000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 25),
> +	F(64000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 16, 75),
> +	F(75000000, CFG_CLK_SRC_GPLL0_AUX2, 4, 0, 0),
> +	F(80000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 15),
> +	F(96000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 25),
> +	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
> +	F(102400000, CFG_CLK_SRC_GPLL0_AUX2, 1, 128, 375),
> +	F(112000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 28, 75),
> +	F(117964800, CFG_CLK_SRC_GPLL0_AUX2, 1, 6144, 15625),
> +	F(120000000, CFG_CLK_SRC_GPLL0_AUX2, 2.5, 0, 0),
> +	F(128000000, CFG_CLK_SRC_GPLL6, 3, 0, 0),
> +	{}
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 12, 0, 0),
> +	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
> +	{}
> +};
> +
> +static const struct pll_vote_clk gpll0_clk = {
> +	.status = 0,
> +	.status_bit = BIT(31),
> +	.ena_vote = 0x79000,
> +	.vote_bit = BIT(0),
> +};
> +
> +static const struct gate_clk sm6125_clks[] = {
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1a084, BIT(0)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x7900c, BIT(9)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_CORE_CLK, 0x7900c, BIT(8)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x7900c, BIT(10)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x7900c, BIT(11)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x7900c, BIT(12)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x7900c, BIT(13)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK, 0x7900c, BIT(14)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x7900c, BIT(15)),
> +	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x7900c, BIT(6)),
> +	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x7900c, BIT(7)),
> +	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x38008, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x38004, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x3800c, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x1e008, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x1e004, BIT(0)),
> +	GATE_CLK(GCC_SYS_NOC_CPUSS_AHB_CLK, 0x79004, BIT(0)),
> +	GATE_CLK(GCC_SYS_NOC_UFS_PHY_AXI_CLK, 0x45098, BIT(0)),
> +	GATE_CLK(GCC_SYS_NOC_USB3_PRIM_AXI_CLK, 0x1a080, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x45014, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x45010, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x45044, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x45078, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x4501c, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x45018, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x45040, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1a010, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1a018, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1a014, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK, 0x80278, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1a054, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1a058, BIT(0)),
> +	GATE_CLK(GCC_AHB2PHY_USB_CLK, 0x1d008, BIT(0)),
> +	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK, 0x8c000, BIT(0)),
> +};
> +
> +static ulong sm6125_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
> +
> +	debug("%s: clk %s rate %lu\n", __func__, sm6125_clks[clk->id].name,
> +	      rate);
> +
> +	switch (clk->id) {
> +	case GCC_QUPV3_WRAP0_S4_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S4_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src,
> +				     16);
> +		return 0;
> +	case GCC_SDCC2_APPS_CLK:
> +		clk_enable_gpll0(priv->base, &gpll0_clk);
> +		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
> +		WARN(freq->src != CFG_CLK_SRC_GPLL0,
> +		     "SDCC2_APPS_CLK_SRC not set to GPLL0, requested rate %lu\n",
> +		     rate);
> +		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src,
> +				     8);
> +		return freq->freq;
> +	case GCC_SDCC1_APPS_CLK:
> +		/* The firmware turns this on for us and always sets it to this rate */
> +		return 384000000;
> +	default:
> +		return rate;
> +	}
> +}
> +
> +static int sm6125_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks < clk->id) {
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %s\n", __func__, sm6125_clks[clk->id].name);
> +
> +	switch (clk->id) {
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
> +		qcom_gate_clk_en(priv, GCC_USB3_PRIM_CLKREF_CLK);
> +		break;
> +	}
> +
> +	return qcom_gate_clk_en(priv, clk->id);
> +}
> +
> +static const struct qcom_reset_map sm6125_gcc_resets[] = {
> +	[GCC_QUSB2PHY_PRIM_BCR] = { 0x1c000 },
> +	[GCC_QUSB2PHY_SEC_BCR] = { 0x1c004 },
> +	[GCC_UFS_PHY_BCR] = { 0x45000 },
> +	[GCC_USB30_PRIM_BCR] = { 0x1a000 },
> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x1d000 },
> +	[GCC_USB3PHY_PHY_PRIM_SP0_BCR] = { 0x1b008 },
> +	[GCC_USB3_PHY_PRIM_SP0_BCR] = { 0x1b000 },
> +	[GCC_CAMSS_MICRO_BCR] = { 0x560ac },
> +};
> +
> +static const struct qcom_power_map sm6125_gdscs[] = {
> +	[USB30_PRIM_GDSC] = { 0x1a004 },
> +	[UFS_PHY_GDSC] = { 0x45004 },
> +	[CAMSS_VFE0_GDSC] = { 0x54004 },
> +	[CAMSS_VFE1_GDSC] = { 0x5403c },
> +	[CAMSS_TOP_GDSC] = { 0x5607c },
> +	[CAM_CPP_GDSC] = { 0x560bc },
> +	[HLOS1_VOTE_TURING_MMU_TBU1_GDSC] = { 0x7d060 },
> +	[HLOS1_VOTE_MM_SNOC_MMU_TBU_RT_GDSC] = { 0x80074 },
> +	[HLOS1_VOTE_MM_SNOC_MMU_TBU_NRT_GDSC] = { 0x80084 },
> +	[HLOS1_VOTE_TURING_MMU_TBU0_GDSC] = { 0x80094 },
> +};
> +
> +static const phys_addr_t sm6125_gpll_addrs[] = {
> +	GCC_BASE + GCC_GPLL0_MODE, GCC_BASE + GCC_GPLL3_MODE,
> +	GCC_BASE + GCC_GPLL4_MODE, GCC_BASE + GCC_GPLL5_MODE,
> +	GCC_BASE + GCC_GPLL6_MODE, GCC_BASE + GCC_GPLL7_MODE,
> +	GCC_BASE + GCC_GPLL8_MODE, GCC_BASE + GCC_GPLL9_MODE,
> +};
> +
> +static const phys_addr_t sm6125_rcg_addrs[] = {
> +	0x0141a01c, // GCC_USB30_PRIM_MASTER_CMD_RCGR
> +	0x0141a034, // GCC_USB30_PRIM_MOCK_UTMI_CMD_RCGR
> +	0x0141a060, // GCC_USB3_PRIM_PHY_AUX_CMD_RCGR
> +	0x01438028, // GCC_SDCC1_APPS_CMD_RCGR
> +	0x0141e00c, // GCC_SDCC2_APPS_CMD_RCGR
> +	0x0141f148, // GCC_QUPV3_WRAP0_S0_CMD_RCGR
> +	0x0141f278, // GCC_QUPV3_WRAP0_S1_CMD_RCGR
> +	0x0141f3a8, // GCC_QUPV3_WRAP0_S2_CMD_RCGR
> +	0x0141f4d8, // GCC_QUPV3_WRAP0_S3_CMD_RCGR
> +	0x0141f608, // GCC_QUPV3_WRAP0_S4_CMD_RCGR
> +	0x0141f738, // GCC_QUPV3_WRAP0_S5_CMD_RCGR
> +	0x01445020, // GCC_UFS_PHY_AXI_CMD_RCGR
> +	0x01445048, // GCC_UFS_PHY_ICE_CORE_CMD_RCGR
> +	0x01445060, // GCC_UFS_PHY_UNIPRO_CORE_CMD_RCGR
> +	0x0144507c, // GCC_UFS_PHY_PHY_AUX_CMD_RCGR
> +};
> +
> +static const char *const sm6125_rcg_names[] = {
> +	"GCC_USB30_PRIM_MASTER_CMD_RCGR",
> +	"GCC_USB30_PRIM_MOCK_UTMI_CMD_RCGR",
> +	"GCC_USB3_PRIM_PHY_AUX_CMD_RCGR",
> +	"GCC_SDCC1_APPS_CMD_RCGR",
> +	"GCC_SDCC2_APPS_CMD_RCGR",
> +	"GCC_QUPV3_WRAP0_S0_CMD_RCGR",
> +	"GCC_QUPV3_WRAP0_S1_CMD_RCGR",
> +	"GCC_QUPV3_WRAP0_S2_CMD_RCGR",
> +	"GCC_QUPV3_WRAP0_S3_CMD_RCGR",
> +	"GCC_QUPV3_WRAP0_S4_CMD_RCGR",
> +	"GCC_QUPV3_WRAP0_S5_CMD_RCGR",
> +	"GCC_UFS_PHY_AXI_CMD_RCGR",
> +	"GCC_UFS_PHY_ICE_CORE_CMD_RCGR",
> +	"GCC_UFS_PHY_UNIPRO_CORE_CMD_RCGR",
> +	"GCC_UFS_PHY_PHY_AUX_CMD_RCGR",
> +};
> +
> +static struct msm_clk_data sm6125_gcc_data = {
> +	.resets = sm6125_gcc_resets,
> +	.num_resets = ARRAY_SIZE(sm6125_gcc_resets),
> +	.clks = sm6125_clks,
> +	.num_clks = ARRAY_SIZE(sm6125_clks),
> +	.power_domains = sm6125_gdscs,
> +	.num_power_domains = ARRAY_SIZE(sm6125_gdscs),
> +
> +	.enable = sm6125_enable,
> +	.set_rate = sm6125_set_rate,
> +
> +	.dbg_pll_addrs = sm6125_gpll_addrs,
> +	.num_plls = ARRAY_SIZE(sm6125_gpll_addrs),
> +	.dbg_rcg_addrs = sm6125_rcg_addrs,
> +	.num_rcgs = ARRAY_SIZE(sm6125_rcg_addrs),
> +	.dbg_rcg_names = sm6125_rcg_names,
> +};
> +
> +static const struct udevice_id gcc_sm6125_of_match[] = {
> +	{
> +		.compatible = "qcom,gcc-sm6125",
> +		.data = (ulong)&sm6125_gcc_data,
> +	},
> +	{}
> +};
> +
> +U_BOOT_DRIVER(gcc_sm6125) = {
> +	.name = "gcc_sm6125",
> +	.id = UCLASS_NOP,
> +	.of_match = gcc_sm6125_of_match,
> +	.bind = qcom_cc_bind,
> +	.flags = DM_FLAG_PRE_RELOC,
> +};
> 

-- 
// Casey (she/her)

