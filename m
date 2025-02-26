Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7166DC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 07:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9078C80077;
	Wed, 26 Feb 2025 08:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QO+HtBd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B1680077; Wed, 26 Feb 2025 08:43:46 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A918006D
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 08:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q7hXV61395986
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 01:43:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740555813;
 bh=GL11mJBRfi7TiqiwDSkc2lQM2cPcpdEpxEWmjVMwJak=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=QO+HtBd06smVsraOf/NbTN0RVLZ4EtQCH6ga+xsSa5fyszvr6xF3+asPEm7UiJPFR
 yRbzSMGZkflE/nPIKwfQahltR01J1fcH/K3wPhNGd1gmYfMMip+xlKhyMPGzekc2ha
 gAACZuPggfOtEwiRJj8cd7SfCPNO9lRTxPogXyIE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q7hXJO030976
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Feb 2025 01:43:33 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 01:43:32 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 01:43:32 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51Q7hPXE120294;
 Wed, 26 Feb 2025 01:43:26 -0600
Message-ID: <e196c090-51ad-470c-9139-cb7f01d845a0@ti.com>
Date: Wed, 26 Feb 2025 13:13:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] arm: mach-k3: j721s2: Update SoC auto-gen data
 to enable Ethernet boot
To: Chintan Vankar <c-vankar@ti.com>, Michael Walle <mwalle@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, MD Danish Anwar
 <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Hari Nagalla
 <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Andreas Dannenberg <dannenberg@ti.com>, "Andrew Davis" <afd@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, "Joao Paulo Goncalves"
 <joao.goncalves@toradex.com>, Kishon Vijay Abraham I <kishon@ti.com>, Wadim
 Egorov <w.egorov@phytec.de>, Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>, "Jayesh Choudhary"
 <j-choudhary@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, "Bryan Brattlof"
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <s-vadapalli@ti.com>, <u-boot@lists.denx.de>
References: <20250225114903.2080616-1-c-vankar@ti.com>
 <20250225114903.2080616-4-c-vankar@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250225114903.2080616-4-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Chintan

On 25/02/25 17:18, Chintan Vankar wrote:
> Update dev-data and clk-data generated using ksswtool-autogen to include

The tool is not publicly available as of now so you can remove the name
and mention that it is auto-generated instead.

> CPSW device which is required for Ethernet Boot, also use ARRAY_SIZE()
> MACRO to avoid hard-coding array size.
> 
> Reviewed-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> Link to v2:
> https://lore.kernel.org/r/20250219104831.2315464-5-c-vankar@ti.com/
> 
> Changes from v2 to v3:
> - No changes.
> 
>  arch/arm/mach-k3/r5/j721s2/clk-data.c | 58 +++++++++++++++++++++++++--
>  arch/arm/mach-k3/r5/j721s2/dev-data.c |  3 +-
>  2 files changed, 57 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/r5/j721s2/clk-data.c b/arch/arm/mach-k3/r5/j721s2/clk-data.c
> index 0c5c321c1eb..0130c9c4b86 100644
> --- a/arch/arm/mach-k3/r5/j721s2/clk-data.c
> +++ b/arch/arm/mach-k3/r5/j721s2/clk-data.c
> @@ -5,7 +5,7 @@
>   * This file is auto generated. Please do not hand edit and report any issues
>   * to Dave Gerlach <d-gerlach@ti.com>.
>   *
> - * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  #include <linux/clk-provider.h>
> @@ -55,6 +55,32 @@ static const char * const mcu_ospi_ref_clk_sel_out1_parents[] = {
>  	"hsdiv4_16fft_mcu_2_hsdivout4_clk",
>  };
>  
> +static const char * const wkup_gpio0_clksel_out0_parents[] = {
> +	"k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk",
> +	"k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk",
> +	"j7am_wakeup_16ff_wkup_0_wkup_rcosc_32k_clk",
> +	"j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk",
> +};
> +
> +static const char * const cpsw2g_cpts_rclk_sel_out0_parents[] = {
> +	"hsdiv4_16fft_main_3_hsdivout1_clk",
> +	"postdiv3_16fft_main_0_hsdivout6_clk",
> +	"board_0_mcu_cpts0_rft_clk_out",
> +	"board_0_cpts0_rft_clk_out",
> +	"board_0_mcu_ext_refclk0_out",
> +	"board_0_ext_refclk1_out",
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	"hsdiv4_16fft_mcu_2_hsdivout1_clk",
> +	"k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk",
> +};
> +
>  static const char * const mcu_usart_clksel_out0_parents[] = {
>  	"hsdiv4_16fft_mcu_1_hsdivout3_clk",
>  	"postdiv3_16fft_main_1_hsdivout5_clk",
> @@ -174,7 +200,11 @@ static const struct clk_data clk_list[] = {
>  	CLK_FIXED_RATE("board_0_hfosc1_clk_out", 0, 0),
>  	CLK_FIXED_RATE("board_0_mcu_ospi0_dqs_out", 0, 0),
>  	CLK_FIXED_RATE("board_0_mcu_ospi1_dqs_out", 0, 0),
> +	CLK_FIXED_RATE("board_0_mcu_rgmii1_rxc_out", 0, 0),
> +	CLK_FIXED_RATE("board_0_mcu_rmii1_ref_clk_out", 0, 0),
>  	CLK_FIXED_RATE("board_0_wkup_i2c0_scl_out", 0, 0),
> +	CLK_FIXED_RATE("cpsw_2guss_mcu_0_mdio_mdclk_o", 0, 0),
> +	CLK_FIXED_RATE("cpsw_2guss_mcu_0_rgmii1_txc_o", 0, 0),
>  	CLK_FIXED_RATE("fss_mcu_0_hyperbus1p0_0_hpb_out_clk_n", 0, 0),
>  	CLK_FIXED_RATE("fss_mcu_0_hyperbus1p0_0_hpb_out_clk_p", 0, 0),
>  	CLK_FIXED_RATE("fss_mcu_0_ospi_0_ospi_oclk_clk", 0, 0),
> @@ -199,6 +229,8 @@ static const struct clk_data clk_list[] = {
>  	CLK_DIV("k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk", "k3_pll_ctrl_wrap_wkup_0_sysclkout_clk", 0x42010118, 0, 5, 0, 0),
>  	CLK_MUX("mcu_ospi_ref_clk_sel_out0", mcu_ospi_ref_clk_sel_out0_parents, 2, 0x40f08030, 0, 1, 0),
>  	CLK_MUX("mcu_ospi_ref_clk_sel_out1", mcu_ospi_ref_clk_sel_out1_parents, 2, 0x40f08034, 0, 1, 0),
> +	CLK_MUX("wkup_gpio0_clksel_out0", wkup_gpio0_clksel_out0_parents, 4, 0x43008070, 0, 2, 0),
> +	CLK_MUX("cpsw2g_cpts_rclk_sel_out0", cpsw2g_cpts_rclk_sel_out0_parents, 16, 0x40f08050, 8, 4, 0),
>  	CLK_MUX("mcu_usart_clksel_out0", mcu_usart_clksel_out0_parents, 2, 0x40f081c0, 0, 1, 0),
>  	CLK_MUX("wkup_i2c_mcupll_bypass_out0", wkup_i2c_mcupll_bypass_out0_parents, 2, 0x43008060, 0, 1, 0),
>  	CLK_MUX("main_pll_hfosc_sel_out0", main_pll_hfosc_sel_out0_parents, 2, 0x43008080, 0, 1, 0),
> @@ -275,6 +307,24 @@ static const struct dev_clk soc_dev_clk_data[] = {
>  	DEV_CLK(4, 0, "hsdiv0_16fft_main_8_hsdivout0_clk"),
>  	DEV_CLK(4, 1, "hsdiv0_16fft_main_7_hsdivout0_clk"),
>  	DEV_CLK(4, 2, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
> +	DEV_CLK(29, 3, "cpsw2g_cpts_rclk_sel_out0"),
> +	DEV_CLK(29, 4, "hsdiv4_16fft_main_3_hsdivout1_clk"),
> +	DEV_CLK(29, 5, "postdiv3_16fft_main_0_hsdivout6_clk"),
> +	DEV_CLK(29, 6, "board_0_mcu_cpts0_rft_clk_out"),
> +	DEV_CLK(29, 7, "board_0_cpts0_rft_clk_out"),
> +	DEV_CLK(29, 8, "board_0_mcu_ext_refclk0_out"),
> +	DEV_CLK(29, 9, "board_0_ext_refclk1_out"),
> +	DEV_CLK(29, 18, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
> +	DEV_CLK(29, 19, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
> +	DEV_CLK(29, 20, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
> +	DEV_CLK(29, 21, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
> +	DEV_CLK(29, 22, "board_0_mcu_rgmii1_rxc_out"),
> +	DEV_CLK(29, 26, "board_0_mcu_rmii1_ref_clk_out"),
> +	DEV_CLK(29, 28, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
> +	DEV_CLK(29, 29, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
> +	DEV_CLK(29, 30, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
> +	DEV_CLK(29, 32, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
> +	DEV_CLK(29, 33, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
>  	DEV_CLK(43, 0, "postdiv3_16fft_main_0_hsdivout8_clk"),
>  	DEV_CLK(43, 1, "hsdiv4_16fft_main_0_hsdivout3_clk"),
>  	DEV_CLK(43, 2, "gluelogic_hfosc0_clkout"),
> @@ -367,6 +417,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
>  	DEV_CLK(157, 187, "fss_mcu_0_ospi_1_ospi_oclk_clk"),
>  	DEV_CLK(157, 194, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
>  	DEV_CLK(157, 197, "j7am_ddr_ew_wrap_dv_wrap_main_0_ddrss_io_ck_n"),
> +	DEV_CLK(157, 207, "cpsw_2guss_mcu_0_mdio_mdclk_o"),
>  	DEV_CLK(157, 208, "j7am_ddr_ew_wrap_dv_wrap_main_1_ddrss_io_ck_n"),
>  	DEV_CLK(157, 214, "fss_mcu_0_hyperbus1p0_0_hpb_out_clk_p"),
>  	DEV_CLK(157, 221, "mcu_clkout_mux_out0"),
> @@ -374,6 +425,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
>  	DEV_CLK(157, 223, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
>  	DEV_CLK(157, 225, "emmc8ss_16ffc_main_0_emmcss_io_clk"),
>  	DEV_CLK(157, 231, "fss_mcu_0_hyperbus1p0_0_hpb_out_clk_n"),
> +	DEV_CLK(157, 244, "cpsw_2guss_mcu_0_rgmii1_txc_o"),
>  	DEV_CLK(157, 352, "dpi0_ext_clksel_out0"),
>  	DEV_CLK(180, 0, "gluelogic_hfosc0_clkout"),
>  	DEV_CLK(180, 2, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
> @@ -400,7 +452,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
>  
>  const struct ti_k3_clk_platdata j721s2_clk_platdata = {
>  	.clk_list = clk_list,
> -	.clk_list_cnt = 105,
> +	.clk_list_cnt = ARRAY_SIZE(clk_list),
>  	.soc_dev_clk_data = soc_dev_clk_data,
> -	.soc_dev_clk_data_cnt = 124,
> +	.soc_dev_clk_data_cnt = ARRAY_SIZE(soc_dev_clk_data),
>  };
> diff --git a/arch/arm/mach-k3/r5/j721s2/dev-data.c b/arch/arm/mach-k3/r5/j721s2/dev-data.c
> index df70c5e5d7c..b78550707c5 100644
> --- a/arch/arm/mach-k3/r5/j721s2/dev-data.c
> +++ b/arch/arm/mach-k3/r5/j721s2/dev-data.c
> @@ -5,7 +5,7 @@
>   * This file is auto generated. Please do not hand edit and report any issues
>   * to Dave Gerlach <d-gerlach@ti.com>.
>   *
> - * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  #include "k3-dev.h"
> @@ -47,6 +47,7 @@ static struct ti_lpsc soc_lpsc_list[] = {
>  };
>  
>  static struct ti_dev soc_dev_list[] = {
> +	PSC_DEV(29, &soc_lpsc_list[0]),
>  	PSC_DEV(35, &soc_lpsc_list[0]),
>  	PSC_DEV(108, &soc_lpsc_list[0]),
>  	PSC_DEV(109, &soc_lpsc_list[0]),

-- 
Thanking You
Neha Malcom Francis
