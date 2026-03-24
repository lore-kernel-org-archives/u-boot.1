Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1056F532E6
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 06:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5779E8352B;
	Tue, 24 Mar 2026 07:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="r7Mckd2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6258366F; Tue, 24 Mar 2026 07:25:49 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6365C82A9E
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 07:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F44F600AC;
 Tue, 24 Mar 2026 06:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25F7C19424;
 Tue, 24 Mar 2026 06:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774333546;
 bh=FNoGnV4qh+5/0yLY1RaNzasmWAT4o5Z0SRHX2KxVvLc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r7Mckd2exPLF4IL7Q7AZ35fgfvfUetqwZqhX6p52XvstMXtiUzfpsRyHtssTHKcHJ
 /ZSx8yFQ5PW5tmYwF0JulOUcKspQ5hoH25+0zzkydFa1rTV6WugtUDHHHE3o9Akddx
 /BHJ31vBjtMLI1/Dm9LXgSzQj5ZHjyMqKMWSbhYy9pFnvlGXQQGc3EVsCXh9E4XUEk
 raRxRqvMVKgBAWNLHDmZ4oZ9wutfMeyDSFFD4oS4F0AtpRNmczcj1IuHIdxezUNOBt
 h1gXLCixxhw+vU6A7BUzpyv89faWrA//+yZagf3ULaFbMaynEW5y0ABs0M+wng2pQq
 E1Jc1FcmuYGoQ==
Date: Tue, 24 Mar 2026 11:55:37 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH 3/5] clk: qcom: qcs615: Add UFS clock support
Message-ID: <acIuYThnUNLqGuPX@sumit-xelite>
References: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
 <20260319-ufs_probe_clk-v1-3-08c085d6b15d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-ufs_probe_clk-v1-3-08c085d6b15d@oss.qualcomm.com>
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

On Thu, Mar 19, 2026 at 03:07:40PM +0530, Balaji Selvanathan wrote:
> Add UFS clock support for qcs615 including register definitions,
> rate configuration, and gate clocks.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clock-qcs615.c | 63 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
> index 4700baba8c9..cd097a3cf36 100644
> --- a/drivers/clk/qcom/clock-qcs615.c
> +++ b/drivers/clk/qcom/clock-qcs615.c
> @@ -19,6 +19,11 @@
>  #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0xf01c
>  #define USB3_PRIM_PHY_AUX_CMD_RCGR		0xf060
>  
> +#define UFS_PHY_AXI_CLK_CMD_RCGR		0x77020
> +#define UFS_PHY_ICE_CORE_CLK_CMD_RCGR		0x77048
> +#define UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR	0x77060
> +#define UFS_PHY_PHY_AUX_CLK_CMD_RCGR		0x7707c
> +
>  #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
>  #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
>  #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
> @@ -33,9 +38,37 @@
>  #define GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT BIT(26)
>  #define GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT BIT(27)
>  
> +/* UFS PHY AXI clock frequency table */
> +static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
> +	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
> +	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
> +	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
> +	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
> +	{ }
> +};
> +
> +/* UFS PHY ICE CORE clock frequency table */
> +static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
> +	F(37500000, CFG_CLK_SRC_GPLL0_EVEN, 8, 0, 0),
> +	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
> +	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
> +	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
> +	{ }
> +};
> +
> +/* UFS PHY UNIPRO CORE clock frequency table */
> +static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
> +	F(37500000, CFG_CLK_SRC_GPLL0_EVEN, 8, 0, 0),
> +	F(75000000, CFG_CLK_SRC_GPLL0, 8, 0, 0),
> +	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
> +	{ }
> +};
> +
>  static ulong qcs615_set_rate(struct clk *clk, ulong rate)
>  {
>  	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
>  
>  	if (clk->id < priv->data->num_clks)
>  		debug("%s: %s, requested rate=%ld\n", __func__,
> @@ -52,6 +85,24 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
>  				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
>  		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
>  		return rate;
> +	case GCC_UFS_PHY_AXI_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_AXI_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_UFS_PHY_UNIPRO_CORE_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_ufs_phy_unipro_core_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_UFS_PHY_ICE_CORE_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_ufs_phy_ice_core_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_ICE_CORE_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_UFS_PHY_PHY_AUX_CLK:
> +		clk_rcg_set_rate(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
> +		return 19200000;
>  	default:
>  		return 0;
>  	}
> @@ -79,7 +130,17 @@ static const struct gate_clk qcs615_clks[] = {
>  	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK, 0x5200c, GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT),
>  	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK, 0x5200c, GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT),
>  	GATE_CLK(GCC_DISP_HF_AXI_CLK, 0xb038, BIT(0)),
> -	GATE_CLK(GCC_DISP_AHB_CLK, 0xb032, BIT(0))
> +	GATE_CLK(GCC_DISP_AHB_CLK, 0xb032, BIT(0)),
> +	/* UFS clocks */
> +	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
> +	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770c0, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77014, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x77040, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x77044, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x77018, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x7701c, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x77078, BIT(0)),
> +	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK, 0x8c000, BIT(0)),
>  };
>  
>  static int qcs615_enable(struct clk *clk)
> 
> -- 
> 2.34.1
> 
