Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF61C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 14:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 672E8877AF;
	Wed,  6 Mar 2024 15:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qqKdTsI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 904D387971; Wed,  6 Mar 2024 15:40:03 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39042878E2
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 15:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412f988d552so3104155e9.3
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 06:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709735999; x=1710340799; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HAP9tBlP/PinPiIE6u47TJujMmyJre1+scrUWsOzL+8=;
 b=qqKdTsI2X1yTns01kaMV4k5fIw0pXH/cdW94s9JDs2lyAqN/dWhQu8bdUYmbYLT9dg
 GxBcn7Id0+UkLN1GM+IIKFSuKisx2DJ9fs5RQ5kJGd567hmh0vsLKQ+6B7AVtCFZ+4vz
 4dyrC6RAz9/H+oYvhlmlYsevvBq/Wr3eyGTfsXojC3CPyZVc03fpZxCu6WZoYovgyXPE
 A6XjZD2saLO3udrHjnt7Bu3s1LBRKlsttAYSofeqCAgx7MMRWHKlbU201yohKzroNQPm
 l9J36D4xB3ocVgSsQ3Gz3cqK1FhMJL05ynwexDW9iN8lcwJMRreuHEsdDKEiLqQ2MvAq
 KYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709735999; x=1710340799;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HAP9tBlP/PinPiIE6u47TJujMmyJre1+scrUWsOzL+8=;
 b=ewfgkN63XmSyg9IpKs6hXR6RjnRiyrzxJktNuWrzmDtft0cA3YvfRInB8rcerxClpZ
 RxNqnowax1Xd46g/1OUNB7aTiSyCCzVjH9lumjJXZeM0KcmxCzhN7XQAWZCZFhc6hPAq
 rfgDW8Gw/jJ/CYgmq4c2zoQn57WyFqCWcj9+8fWljsIetvu+QkoF9EkZbvkr37aCG3X+
 qNqZNY2Zi7jR0HbehlkwTmes/DSLLwhlUsqJUTMWZOgy4iEkLzO+EFjCjg4Fx9tlMKhP
 jrQWgN1HxGJvYmzj+PsYgt+P8ELmY/S7Qks6hpo06FXhKYirSnEhCkn5a6oTmPFBb70l
 k1Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhJ4HyiLkTEBIct7ANtQNnpBt84O3ndFzmb5QB8LusY7B7RgCl7DK793tMKU2cV2eOgVwyz1BReXqtf+ssqYYEpQxbvQ==
X-Gm-Message-State: AOJu0YyCHkft/gv1ft8ts3rMIQFNLSOvjHz+g/gYu2NX4/dqm4vihmj3
 yAub+1sBkswogvGSd+tVSS+EmoK7oiLezLcj4X6ni7Z0p3ppkIPN1x5mkl5eUlc=
X-Google-Smtp-Source: AGHT+IFjy1OGe1eFeU3nP9CdQf9IqtdWEeohdPwTnKIddaQ3hmtgETqoPvL3XWO3E4JSpkEsUDkOvg==
X-Received: by 2002:a05:600c:4709:b0:412:a206:ad16 with SMTP id
 v9-20020a05600c470900b00412a206ad16mr12826810wmo.12.1709735999571; 
 Wed, 06 Mar 2024 06:39:59 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a05600c350a00b00412f195254csm3037545wmq.36.2024.03.06.06.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 06:39:59 -0800 (PST)
Message-ID: <a6ad3240-0f24-48a0-995c-adaa99851512@linaro.org>
Date: Wed, 6 Mar 2024 14:39:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] clk: qcom: add driver for SM8150 SoC
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-6-volodymyr_babchuk@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240306005230.2638972-6-volodymyr_babchuk@epam.com>
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



On 06/03/2024 00:53, Volodymyr Babchuk wrote:
> Add clock, reset and power domain driver for SM8150. Driver code is
> based on the similar U-Boot drivers. All constants are taken from the
> corresponding Linux driver.
> 
> This driver supports clock rate setting only for the debug UART and
> RGMII/Ethernet modules, because this is all I can test right now.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

Thanks for working on this!

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> ---
> 
> Changes in v2:
>  - Renamed GPLL7_MAIN to just GPLL7 (while I like idea to use Linux
>    naming convention, such rework needs to be done in a separate
>    commit)
>  - Removed unnecessary include
>  - Fixed GDSCR register values for couple of devices
>  - Enable GPLL7 only when RGMII clock is enabled
> 
>  drivers/clk/qcom/Kconfig        |   8 ++
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/clock-qcom.h   |   1 +
>  drivers/clk/qcom/clock-sm8150.c | 237 ++++++++++++++++++++++++++++++++
>  4 files changed, 247 insertions(+)
>  create mode 100644 drivers/clk/qcom/clock-sm8150.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 0df0d1881a..18ccf6a45e 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -47,6 +47,14 @@ config CLK_QCOM_SDM845
>  	  on the Snapdragon 845 SoC. This driver supports the clocks
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
>  endmenu
>  
>  endif
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index cb179fdac5..12c09ba19e 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
>  obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
>  obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
>  obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
> +obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 12a1eaec2b..dd40487e94 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -9,6 +9,7 @@
>  
>  #define CFG_CLK_SRC_CXO   (0 << 8)
>  #define CFG_CLK_SRC_GPLL0 (1 << 8)
> +#define CFG_CLK_SRC_GPLL7 (3 << 8)
>  #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
>  #define CFG_CLK_SRC_MASK  (7 << 8)
>  
> diff --git a/drivers/clk/qcom/clock-sm8150.c b/drivers/clk/qcom/clock-sm8150.c
> new file mode 100644
> index 0000000000..2592eef29b
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-sm8150.c
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Clock drivers for Qualcomm SM8150
> + *
> + * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> + * Copyright (c) 2024 EPAM Systems.
> + *
> + * Based on U-Boot driver for SDM845. Constants are taken from the Linux driver.
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
> +static const struct bcr_regs uart2_regs = {
> +	.cfg_rcgr = 0x1814C,
> +	.cmd_rcgr = 0x18148,
> +	.M = 0x18150,
> +	.N = 0x18154,
> +	.D = 0x18158,
> +};
> +
> +static const struct bcr_regs rgmii_regs = {
> +	.cfg_rcgr = 0x6020,
> +	.cmd_rcgr = 0x601C,
> +	.M = 0x6024,
> +	.N = 0x6028,
> +	.D = 0x602C,
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
> +		clk_rcg_set_rate_mnd(priv->base, &uart2_regs,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 16);
> +		return freq->freq;
> +	case GCC_EMAC_RGMII_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_emac_rgmii_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, &rgmii_regs,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +
> +		return freq->freq;
> +	default:
> +		pr_err("Don't know how to set clk id %ld\n", clk->id);
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct gate_clk sm8150_clks[] = {
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
> +	switch (clk->id) {
> +	case GCC_EMAC_RGMII_CLK:
> +		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
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
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_sm8150_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC,
> +};

-- 
// Caleb (they/them)
