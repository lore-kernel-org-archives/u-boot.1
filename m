Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16984F532D4
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 06:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A04448352B;
	Tue, 24 Mar 2026 07:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rwdjs6Wl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D266838BB; Tue, 24 Mar 2026 07:26:41 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A65B82A9E
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 07:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B67E64322B;
 Tue, 24 Mar 2026 06:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21CFC19424;
 Tue, 24 Mar 2026 06:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774333597;
 bh=dw4eMXBYLStipauRz/Dlif1SImekoIiYEm9pNCeKkXM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rwdjs6Wl2meifHuSgrqkPJZiiZIdak+FXDoGgfo8RQvKewl2ICJxgkGFTCS6H+NGt
 G055DyD7ZEUQhSW3waapRY9wiBcoeRCAgKX+C2WqI/AadY+b5v7T7aQadOMsvQBcOG
 +lM1Caof/Z2eb21aVpGExUKLzIF0H784sEk31vf+Q+dXnGui/gZgLdb0eIL6HF3hA5
 hUGslw7uPTueqcE5OU0Gdh3rvJyx9Ll2BYE4ilxExt8XpkqpN7N2YWTj7v6//AHuOw
 CL++3AWwr8rL4UVUY7rvtXChayYyBHMlJ64ZTkL1inb1GYbW2DqbX4XaIM6jCEiAnb
 KOJo+/5PHz8EA==
Date: Tue, 24 Mar 2026 11:56:29 +0530
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
Subject: Re: [PATCH 4/5] clk: qcom: sc7280: Add UFS clock support
Message-ID: <acIuld4tiNY2UlEG@sumit-xelite>
References: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
 <20260319-ufs_probe_clk-v1-4-08c085d6b15d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-ufs_probe_clk-v1-4-08c085d6b15d@oss.qualcomm.com>
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

On Thu, Mar 19, 2026 at 03:07:41PM +0530, Balaji Selvanathan wrote:
> Add UFS clock support for sc7280 including register definitions,
> rate configuration, and gate clocks.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clock-sc7280.c | 52 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> index 7b6ed826023..2c73c26484f 100644
> --- a/drivers/clk/qcom/clock-sc7280.c
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -23,6 +23,10 @@
>  #define PCIE_1_AUX_CLK_CMD_RCGR 0x8d058
>  #define PCIE1_PHY_RCHNG_CMD_RCGR 0x8d03c
>  #define PCIE_1_PIPE_CLK_PHY_MUX 0x8d054
> +#define UFS_PHY_AXI_CLK_CMD_RCGR 0x77024
> +#define UFS_PHY_ICE_CORE_CLK_CMD_RCGR 0x7706c
> +#define UFS_PHY_PHY_AUX_CLK_CMD_RCGR 0x770a0
> +#define UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR 0x77084
>  
>  static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
>  	F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
> @@ -54,6 +58,33 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s2_clk_src[] = {
>  	{ }
>  };
>  
> +static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
> +	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
> +	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
> +	F(150000000, CFG_CLK_SRC_GPLL0_EVEN, 2, 0, 0),
> +	F(300000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
> +	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
> +	F(150000000, CFG_CLK_SRC_GPLL0_EVEN, 2, 0, 0),
> +	F(300000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_ufs_phy_phy_aux_clk_src[] = {
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
> +	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
> +	F(150000000, CFG_CLK_SRC_GPLL0_EVEN, 2, 0, 0),
> +	F(300000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 0, 0),
> +	{ }
> +};
> +
>  static ulong sc7280_set_rate(struct clk *clk, ulong rate)
>  {
>  	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -103,6 +134,26 @@ static ulong sc7280_set_rate(struct clk *clk, ulong rate)
>  	case GCC_PCIE1_PHY_RCHNG_CLK:
>  		clk_rcg_set_rate(priv->base, PCIE1_PHY_RCHNG_CMD_RCGR, 5, CFG_CLK_SRC_GPLL0_EVEN);
>  		return 100000000;
> +	case GCC_UFS_PHY_AXI_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_AXI_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_UFS_PHY_ICE_CORE_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_ufs_phy_ice_core_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_ICE_CORE_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_UFS_PHY_PHY_AUX_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_ufs_phy_phy_aux_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_UFS_PHY_UNIPRO_CORE_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_ufs_phy_unipro_core_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
>  	default:
>  		return rate;
>  	}
> @@ -147,6 +198,7 @@ static const struct gate_clk sc7280_clks[] = {
>  	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
>  	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0)),
>  	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x77064, BIT(0)),
>  	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, BIT(0)),
>  	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x7709c, BIT(0)),
>  	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x7701c, BIT(0)),
> 
> -- 
> 2.34.1
> 
