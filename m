Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA94FED2DD
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 07:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F7D83F9A;
	Thu, 12 Mar 2026 08:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a9mOXIcl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94221840A2; Thu, 12 Mar 2026 08:45:31 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B9083F8A
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 08:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B1E8C43D45;
 Thu, 12 Mar 2026 07:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E94C4CEF7;
 Thu, 12 Mar 2026 07:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773301527;
 bh=tIFuts6ivZLvuiwFU/YXbm7QUtjgOPNa/sUBXLH0Z6Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a9mOXIclymI+GLRs7o8XrZK6NI6LvW2JlDHpLjuMCaA+rFIPhQPWluGXayw561RJm
 /koZuz8G040HgAze3nFRAibRMSV77hPqWqXn2Vj/WlrHhF141X5rjaCtmsnSHSgBFh
 sYqosIKAP/vVJAHDf+W0b1HIQSBJFs+m+k+u17oNNZz5+gF9mqW1atV5MaArLzHvxY
 5Kqs3F/6X0MCgJyKMv+ojJhfvhHDlPNP56UmvRwtwAiyURatejyVNJHhjDwCDKPeGZ
 PJfapEOzA9oHh6JekplQdPqtYKFAp3er4iyzIoOjf0gDfSPlM0v1fJJxt9t2K/XWU0
 VAhmZ3pzvuWNw==
Date: Thu, 12 Mar 2026 13:15:18 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 David Wronek <david.wronek@mainlining.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 2/7] clk/qcom: Add Milos clock driver
Message-ID: <abJvDj6KYKGN7YKs@sumit-xelite>
References: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
 <20260311-milos-bringup-v1-2-eb905c467f10@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-milos-bringup-v1-2-eb905c467f10@fairphone.com>
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

On Wed, Mar 11, 2026 at 03:20:42PM +0100, Luca Weiss wrote:
> Add Clock driver for the GCC block found in the Milos SoC.
> 
> The qcom-snps-eusb2-hsphy driver requires the TCXO frequency ("ref"
> clock), so we need to pass that as well.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/clk/qcom/Kconfig       |   8 ++
>  drivers/clk/qcom/Makefile      |   1 +
>  drivers/clk/qcom/clock-milos.c | 224 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 233 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 8504ed5d656..0a2ce55aaa2 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -47,6 +47,14 @@ config CLK_QCOM_IPQ9574
>  	  on the Snapdragon IPQ9574 SoC. This driver supports the clocks
>  	  and resets exposed by the GCC hardware block.
>  
> +config CLK_QCOM_MILOS
> +	bool "Qualcomm Milos GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon Milos SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>  config CLK_QCOM_QCM2290
>  	bool "Qualcomm QCM2290 GCC"
>  	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 82a5b166196..b96d61b603e 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
>  obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
>  obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
>  obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
> +obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
>  obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>  obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
>  obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
> diff --git a/drivers/clk/qcom/clock-milos.c b/drivers/clk/qcom/clock-milos.c
> new file mode 100644
> index 00000000000..04f46b943c1
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-milos.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Clock drivers for Qualcomm Milos
> + *
> + * (C) Copyright 2024 Linaro Ltd.
> + * (C) Copyright 2025 Luca Weiss <luca.weiss@fairphone.com>

Ditto for copyright update.

> + */
> +
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <errno.h>
> +#include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,milos-gcc.h>
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +
> +#include "clock-qcom.h"
> +
> +/* On-board TCXO, TOFIX get from DT */
> +#define TCXO_RATE	76800000
> +
> +/* bi_tcxo_div4 divided after RPMh output */
> +#define TCXO_DIV4_RATE	(TCXO_RATE / 4)
> +
> +static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s3_clk_src[] = {
> +	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
> +	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
> +	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
> +	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
> +	F(51200000, CFG_CLK_SRC_GPLL0_EVEN, 1, 64, 375),
> +	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
> +	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
> +	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
> +	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
> +	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
> +	F(37500000, CFG_CLK_SRC_GPLL0_EVEN, 8, 0, 0),
> +	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
> +	/* TOFIX F(202000000, CFG_CLK_SRC_GPLL9, 4, 0, 0), */
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
> +	F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
> +	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
> +	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
> +	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
> +	{ }
> +};
> +
> +static ulong milos_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
> +
> +	switch (clk->id) {
> +	case GCC_QUPV3_WRAP0_S5_CLK: /* UART5 */
> +		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s3_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, 0x18500,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 16);
> +		return freq->freq;
> +	case GCC_SDCC2_APPS_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, 0x14018,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, 0x3902c,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
> +		clk_rcg_set_rate(priv->base, 0x39044, 0, 0);
> +		return TCXO_DIV4_RATE;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct gate_clk milos_clks[] = {
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,		0x39090, BIT(0)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK,		0x52008, BIT(27)),
> +	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK,		0x52008, BIT(20)),
> +	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK,		0x52008, BIT(21)),
> +	GATE_CLK(GCC_SDCC2_AHB_CLK,			0x14010, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_APPS_CLK,			0x14004, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,		0x39018, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,		0x39028, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,		0x39024, BIT(0)),
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x3908c, BIT(0)),
> +};
> +
> +static int milos_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	switch (clk->id) {
> +	case GCC_AGGRE_USB3_PRIM_AXI_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB30_PRIM_MASTER_CLK);
> +		break;
> +	}
> +
> +	return qcom_gate_clk_en(priv, clk->id);
> +}
> +
> +static const struct qcom_reset_map milos_gcc_resets[] = {
> +	[GCC_CAMERA_BCR] = { 0x26000 },
> +	[GCC_DISPLAY_BCR] = { 0x27000 },
> +	[GCC_GPU_BCR] = { 0x71000 },
> +	[GCC_PCIE_0_BCR] = { 0x6b000 },
> +	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x6c014 },
> +	[GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0x6c020 },
> +	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
> +	[GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR] = { 0x6c028 },
> +	[GCC_PCIE_1_BCR] = { 0x90000 },
> +	[GCC_PCIE_1_LINK_DOWN_BCR] = { 0x8e014 },
> +	[GCC_PCIE_1_NOCSR_COM_PHY_BCR] = { 0x8e020 },
> +	[GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
> +	[GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR] = { 0x8e024 },
> +	[GCC_PCIE_RSCC_BCR] = { 0x11000 },
> +	[GCC_PDM_BCR] = { 0x33000 },
> +	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x18000 },
> +	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x1e000 },
> +	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
> +	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
> +	[GCC_SDCC1_BCR] = { 0xa3000 },
> +	[GCC_SDCC2_BCR] = { 0x14000 },
> +	[GCC_UFS_PHY_BCR] = { 0x77000 },
> +	[GCC_USB30_PRIM_BCR] = { 0x39000 },
> +	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
> +	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
> +	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
> +	[GCC_VIDEO_AXI0_CLK_ARES] = { 0x32018, 2 },
> +	[GCC_VIDEO_BCR] = { 0x32000 },
> +};

Similar to clocks, we should limit resets to supported peripherals only.
Although I would love to see PCIe and other peripherals support but that
should be functionally complete.

> +
> +static const struct qcom_power_map milos_gdscs[] = {
> +	[PCIE_0_GDSC] = { 0x6b004 },
> +	[PCIE_0_PHY_GDSC] = { 0x6c000 },
> +	[PCIE_1_GDSC] = { 0x90004 },
> +	[PCIE_1_PHY_GDSC] = { 0xa2000 },
> +	[UFS_PHY_GDSC] = { 0x77004 },
> +	[UFS_MEM_PHY_GDSC] = { 0x9e000 },
> +	[USB30_PRIM_GDSC] = { 0x39004 },
> +	[USB3_PHY_GDSC] = { 0x5000c },
> +};

Ditto here.

-Sumit

> +
> +static struct msm_clk_data milos_gcc_data = {
> +	.resets = milos_gcc_resets,
> +	.num_resets = ARRAY_SIZE(milos_gcc_resets),
> +	.clks = milos_clks,
> +	.num_clks = ARRAY_SIZE(milos_clks),
> +	.power_domains = milos_gdscs,
> +	.num_power_domains = ARRAY_SIZE(milos_gdscs),
> +
> +	.enable = milos_enable,
> +	.set_rate = milos_set_rate,
> +};
> +
> +static const struct udevice_id gcc_milos_of_match[] = {
> +	{
> +		.compatible = "qcom,milos-gcc",
> +		.data = (ulong)&milos_gcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_milos) = {
> +	.name		= "gcc_milos",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_milos_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
> +
> +static ulong milos_rpmh_clk_set_rate(struct clk *clk, ulong rate)
> +{
> +	return (clk->rate = rate);
> +}
> +
> +static ulong milos_rpmh_clk_get_rate(struct clk *clk)
> +{
> +	switch (clk->id) {
> +	case RPMH_CXO_CLK:
> +		return TCXO_DIV4_RATE;
> +	default:
> +		return clk->rate;
> +	}
> +}
> +
> +static int milos_rpmh_clk_nop(struct clk *clk)
> +{
> +	return 0;
> +}
> +
> +static struct clk_ops milos_rpmh_clk_ops = {
> +	.set_rate = milos_rpmh_clk_set_rate,
> +	.get_rate = milos_rpmh_clk_get_rate,
> +	.enable = milos_rpmh_clk_nop,
> +	.disable = milos_rpmh_clk_nop,
> +};
> +
> +static const struct udevice_id milos_rpmh_clk_ids[] = {
> +	{ .compatible = "qcom,milos-rpmh-clk" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(milos_rpmh_clk) = {
> +	.name		= "milos_rpmh_clk",
> +	.id		= UCLASS_CLK,
> +	.of_match	= milos_rpmh_clk_ids,
> +	.ops		= &milos_rpmh_clk_ops,
> +	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
> 
> -- 
> 2.53.0
> 
