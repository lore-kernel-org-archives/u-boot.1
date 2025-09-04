Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0C8CA1002
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 13:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3732F83B0B;
	Thu,  4 Sep 2025 15:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qze0dGpR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF1D283B30; Thu,  4 Sep 2025 15:49:10 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC9A83807
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 15:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61cc281171cso1946478a12.0
 for <u-boot@lists.denx.de>; Thu, 04 Sep 2025 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756993747; x=1757598547; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0meOAbd2nyTao70U5yjKmYQH4PUtmwGoJ4RviBCgp24=;
 b=Qze0dGpRirRWAWOYUtkfNJIJi4ppOEB0YwH9rRoA8VBXiXD6ZmfQT9uJAiryIjnts/
 /dpAYSKPnsqYgU27AuDf6IKbxRDYHpxsvM8mpWjdhHMaVv8YgTW/Ijn5+jjQI6eGWkf/
 iFDfUOEj4D0OuU3Qo/mrE7HA7XeMCIFvkRtnKyuTqryu8Md2vIrQcs7LD3/S7mR5OHCM
 vB08eimKKkda0HTJfgeNSsx6u7m0MVyVdDtXKQMWTTTHV7v0UsGdhU+3YqM8Frs2Ty6U
 /uW8sJBoIyr5HH1u955mrSaJGXkiFXXhWdEi2Kf6iMaSrw6aaTeL2aW6ry5Cglhs8B6g
 y/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756993747; x=1757598547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0meOAbd2nyTao70U5yjKmYQH4PUtmwGoJ4RviBCgp24=;
 b=D/jRIMujef2kGlRHLd8iz8xr5IbaFjAG4PrM2H8XFPh/i1vNvMdEjZ2aT7q6eU2XvA
 GroWN3gyOGHxYok6bFCA34muvAojUhNjA94D/H3HaLjkgAkIk5qUvhcPwBxHrLVGcDnp
 8MfACqL6B0KC5/niwO/lqI0KBhBFakiHRPmOj3EjPM6y58LtY5fiNwfBR2YXVURVxUeu
 OVUsKz047xw8doCQAn0U3LyO9qgoeO8TZXoOE28cjae8iAhJtevSOjaOIhWjNioTIK0C
 QtH1OVbt1Ap0yipgZNAeyA83Si5ebwEIxbpHMoHXFS+ZD4ZVzcB6SIbbIOJBpqeX8jp/
 vJdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV82t9KmXdG11sKS3UyFxXRD6MM7sW9/oEF1OQK3LscMw4EFoNakiw4xOQ0dqDKYmhbf2X8qek=@lists.denx.de
X-Gm-Message-State: AOJu0YzOJ49yNnora/ZRAj/zn5tlN7Wyprg6vaK0EeNyjqVhFsmUhIt+
 SphFXZa5uWcpQLsiBUvzq1SXvLpD3es1yMPInl24uvw18dc8ahhSyXAP/r+R3fXn6Fc=
X-Gm-Gg: ASbGncuCRIwFVmJCa7ZvV4v/FmImUzsbATTbxQnxek9tJ2c0ZxlnpEp2Lbfi6whBKu4
 d9gsScbMN0KzFS5by7Zk/5c3xM5LXzrtvbfGeFO2E3dKBVjXqqSq8CEiksNBAfzk1sL4Ugx4585
 +tBiLbNLMOwzQdnovzSxx6tSuwrhEehji4vflucoDrmuD/VL0+gWvLkVqNWN/11jns8VX7A56F1
 iEvZW1HMgI7JPco8uuvv2fp6EYr3yQuuzp2avz6a77CYc7o1e40FdiCSRi63ZoDPJbSp78zLJBm
 3UIpcMtUk2QRXdBtfs8ikSkQE9y6fYwbzqNmj5SQkcdfckDNJRmIRN9Xd8vZcMIoDJh4+WZKJa/
 fyMEfudXXrm1X3Tja9TTgl+bct3XySKmNMDDelPLW3Ah5pbQOEGcc52vt0OVC0AmtI61pcw7n5A
 ZC
X-Google-Smtp-Source: AGHT+IESQg2DQtM78Le9+06wr13YRoDO+wrrCL/keJosSNwqQICZwWSG8gT3W6MyY4A+x4XNiUInbQ==
X-Received: by 2002:a05:6402:2547:b0:61c:8781:d05d with SMTP id
 4fb4d7f45d1cf-61d26eb54bfmr19704801a12.27.1756993746574; 
 Thu, 04 Sep 2025 06:49:06 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd6f.dip0.t-ipconnect.de. [79.195.221.111])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61d330f9f39sm11239057a12.14.2025.09.04.06.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 06:49:05 -0700 (PDT)
Message-ID: <35c985dd-a166-4c68-8ec6-86adfce33e8d@linaro.org>
Date: Thu, 4 Sep 2025 15:49:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] clk/qcom: add driver for SM7150 GCC
Content-Language: en-US
To: Jens Reidel <adrian@mainlining.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sam Day <me@samcday.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Julius Lehmann <lehmanju@devpi.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, Luca Weiss <luca@lucaweiss.eu>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250831004602.699953-1-adrian@mainlining.org>
 <20250831004602.699953-2-adrian@mainlining.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250831004602.699953-2-adrian@mainlining.org>
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

Hi Jens,

Thanks! Since the dt-binding headers are already available for this
platform this is all good.

On 31/08/2025 02:45, Jens Reidel wrote:
> From: Danila Tikhonov <danila@jiaxyga.com>
> 
> Add a clock driver for the SM7150 SoC. This driver can enable necessary
> clocks for UART, UFS, USB, and MMC.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Co-developed-by: Jens Reidel <adrian@mainlining.org>
> Signed-off-by: Jens Reidel <adrian@mainlining.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/clk/qcom/Kconfig        |   8 +
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/clock-sm7150.c | 250 ++++++++++++++++++++++++++++++++
>  3 files changed, 259 insertions(+)
>  create mode 100644 drivers/clk/qcom/clock-sm7150.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 34e41461e72..ca913feb2af 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -103,6 +103,14 @@ config CLK_QCOM_SM6115
>  	  on the Snapdragon SM6115 SoC. This driver supports the clocks
>  	  and resets exposed by the GCC hardware block.
>  
> +config CLK_QCOM_SM7150
> +	bool "Qualcomm SM7150 GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon SM7150 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>  config CLK_QCOM_SM8150
>  	bool "Qualcomm SM8150 GCC"
>  	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index b3d95b0faa3..9e8ca2bd69e 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
>  obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
>  obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
>  obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
> +obj-$(CONFIG_CLK_QCOM_SM7150) += clock-sm7150.o
>  obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
>  obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
>  obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
> diff --git a/drivers/clk/qcom/clock-sm7150.c b/drivers/clk/qcom/clock-sm7150.c
> new file mode 100644
> index 00000000000..8fe2076e55e
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-sm7150.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Clock drivers for Qualcomm SM7150
> + *
> + * (C) Copyright 2025 Danila Tikhonov <danila@jiaxyga.com>
> + * (C) Copyright 2025 Jens Reidel <adrian@mainlining.org>
> + *
> + * Based on Linux Kernel driver
> + */
> +
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,sm7150-gcc.h>
> +
> +#include "clock-qcom.h"
> +
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR		0xf01c
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0xf034
> +#define USB3_PRIM_PHY_AUX_CLK_CMD_RCGR		0xf060
> +
> +#define SE8_UART_APPS_CMD_RCGR			0x18278
> +#define GCC_SDCC2_APPS_CLK_SRC_REG		0x1400c
> +
> +#define APCS_GPLL7_STATUS			0x27000
> +#define APCS_GPLLX_ENA_REG			0x52000
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
> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(9600000, CFG_CLK_SRC_CXO, 2, 0, 0),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
> +	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
> +	F(208000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
> +	F(66666667, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
> +	F(133333333, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
> +	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
> +	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb30_prim_mock_utmi_clk_src[] = {
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 15, 0, 0),
> +	F(40000000, CFG_CLK_SRC_GPLL0_EVEN, 7.5, 0, 0),
> +	F(60000000, CFG_CLK_SRC_GPLL0, 10, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb3_prim_phy_aux_clk_src[] = {
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	{ }
> +};
> +
> +static ulong sm7150_clk_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
> +
> +	if (clk->id < priv->data->num_clks)
> +		debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
> +
> +	switch (clk->id) {
> +	case GCC_QUPV3_WRAP1_S2_CLK: /* UART8 */
> +		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, SE8_UART_APPS_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 16);
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
> +		freq = qcom_find_freq(ftbl_gcc_usb3_prim_phy_aux_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB3_PRIM_PHY_AUX_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 0);
> +		return freq->freq;
> +	case GCC_SDCC2_APPS_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_SRC_REG,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct gate_clk sm7150_clks[] = {
> +	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,	0x82024, BIT(0)),
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,	0x8201c, BIT(0)),
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,	0x502c,  BIT(0)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,	0x5200c, BIT(10)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,	0x5200c, BIT(11)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK,	0x5200c, BIT(12)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK,	0x5200c, BIT(13)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK,	0x5200c, BIT(14)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK,	0x5200c, BIT(15)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S6_CLK,	0x5200c, BIT(16)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK,	0x5200c, BIT(17)),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK,	0x5200c, BIT(22)),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK,	0x5200c, BIT(23)),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK,	0x5200c, BIT(24)),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK,	0x5200c, BIT(25)),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK,	0x5200c, BIT(26)),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK,	0x5200c, BIT(27)),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S6_CLK,	0x5200c, BIT(28)),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S7_CLK,	0x5200c, BIT(29)),
> +	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK,	0x5200c, BIT(6)),
> +	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK,	0x5200c, BIT(7)),
> +	GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK,	0x5200c, BIT(20)),
> +	GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK,	0x5200c, BIT(21)),
> +	GATE_CLK(GCC_SDCC1_AHB_CLK,		0x12008, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK,		0x1200c, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK,	0x12040, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_AHB_CLK,		0x14008, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_APPS_CLK,		0x14004, BIT(0)),
> +	GATE_CLK(GCC_SDCC4_AHB_CLK,		0x16008, BIT(0)),
> +	GATE_CLK(GCC_SDCC4_APPS_CLK,		0x16004, BIT(0)),
> +	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK,	0x8c000, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_AHB_CLK,		0x77014, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_AXI_CLK,		0x77038, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,	0x77090, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,	0x77094, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,	0x7701c, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,	0x77018, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,	0x7708c, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,	0x0f010, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,	0x0f018, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,	0x0f014, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK,	0x8c010, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,	0x0f050, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,	0x0f054, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,	0x0f058, BIT(0)),
> +	GATE_CLK(GCC_USB_PHY_CFG_AHB2PHY_CLK,	0x6a004, BIT(0)),
> +};
> +
> +static int sm7150_clk_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks < clk->id) {
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %s\n", __func__, sm7150_clks[clk->id].name);
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
> +	return qcom_gate_clk_en(priv, clk->id);
> +}
> +
> +static const struct qcom_reset_map sm7150_gcc_resets[] = {
> +	[GCC_UFS_PHY_BCR] = { 0x77000 },
> +	[GCC_USB30_PRIM_BCR] = { 0xf000 },
> +	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
> +	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
> +	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
> +	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
> +	[GCC_QUSB2PHY_PRIM_BCR] = { 0x26000 },
> +};
> +
> +static const struct qcom_power_map sm7150_gdscs[] = {
> +	[PCIE_0_GDSC] = { 0x6b004 },
> +	[UFS_PHY_GDSC] = { 0x77004 },
> +	[USB30_PRIM_GDSC] = { 0xf004 },
> +};
> +
> +static const phys_addr_t sm7150_rcg_addrs[] = {
> +	0x10f01c, // USB30_PRIM_MASTER_CLK_CMD_RCGR
> +	0x10f034, // USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR
> +	0x10f060, // USB3_PRIM_PHY_AUX_CLK_CMD_RCGR,
> +};
> +
> +static const char *const sm7150_rcg_names[] = {
> +	"USB30_PRIM_MASTER_CLK",
> +	"USB30_PRIM_MOCK_UTMI_CLK",
> +	"USB3_PRIM_PHY_AUX_CLK",
> +};
> +
> +static struct msm_clk_data sm7150_gcc_data = {
> +	.resets = sm7150_gcc_resets,
> +	.num_resets = ARRAY_SIZE(sm7150_gcc_resets),
> +	.clks = sm7150_clks,
> +	.num_clks = ARRAY_SIZE(sm7150_clks),
> +
> +	.power_domains = sm7150_gdscs,
> +	.num_power_domains = ARRAY_SIZE(sm7150_gdscs),
> +
> +	.enable = sm7150_clk_enable,
> +	.set_rate = sm7150_clk_set_rate,
> +
> +	.dbg_rcg_addrs = sm7150_rcg_addrs,
> +	.num_rcgs = ARRAY_SIZE(sm7150_rcg_addrs),
> +	.dbg_rcg_names = sm7150_rcg_names,
> +};
> +
> +static const struct udevice_id gcc_sm7150_of_match[] = {
> +	{ .compatible = "qcom,sm7150-gcc", .data = (ulong)&sm7150_gcc_data, },
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(gcc_sm7150) = {
> +	.name		= "gcc_sm7150",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_sm7150_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};

-- 
// Casey (she/her)

