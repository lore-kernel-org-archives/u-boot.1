Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EFEF532E4
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 06:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2320D8352B;
	Tue, 24 Mar 2026 07:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yv3eaDwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7125D8366F; Tue, 24 Mar 2026 07:13:06 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 098E682A9E
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 07:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D9C9D600AC;
 Tue, 24 Mar 2026 06:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63481C19424;
 Tue, 24 Mar 2026 06:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774332782;
 bh=GsIWQpNrf0O8ZJeOQAuVodZuP9QLUkBLLlvPcrKcRNM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yv3eaDwpS1KkWPi0NBE5dIP/iSRi3IcrjbsnlYFrBLVZLVHFfKJ12OdK+aBfkzj/S
 TZs3DBgG7bpEOkmCyis6cFfIPLJRfDhQGkxSsvWEvoCocIQpLXa9pRB+KXroOIAd6V
 n363DFxVgJm/fY3ofF1bT4OGrFUywQiMJ4duie4ZZ7Fu49R2fo1B3LvnjpNHIBWVpP
 WVUh7awueaBqY1vS9mOBn6j6DLHCgMJAV5PRYQHEyoSDr0N8EeNVUeUrxGtqdNi799
 PwpV0P0wlE0/oo/7Y+eYgVPyf61540mFLacnFpoX3kx0Rwt/niyZMAtFI4+iRUlen3
 PZ7Uqv+ay7rEw==
Date: Tue, 24 Mar 2026 11:42:53 +0530
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
Subject: Re: [PATCH 2/5] clk: qcom: sa8775p: Add UFS clock support
Message-ID: <acIrZRkJ7zVgFHi8@sumit-xelite>
References: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
 <20260319-ufs_probe_clk-v1-2-08c085d6b15d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-ufs_probe_clk-v1-2-08c085d6b15d@oss.qualcomm.com>
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

On Thu, Mar 19, 2026 at 03:07:39PM +0530, Balaji Selvanathan wrote:
> Add UFS clock support for SA8775P including register definitions,
> rate configuration, and gate clocks.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clock-sa8775p.c | 63 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
> index 4957abf6f58..7eec4aeae48 100644
> --- a/drivers/clk/qcom/clock-sa8775p.c
> +++ b/drivers/clk/qcom/clock-sa8775p.c
> @@ -19,6 +19,11 @@
>  #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
>  #define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
>  
> +#define UFS_PHY_AXI_CLK_CMD_RCGR		0x8302c
> +#define UFS_PHY_ICE_CORE_CLK_CMD_RCGR		0x83074
> +#define UFS_PHY_PHY_AUX_CLK_CMD_RCGR		0x830a8
> +#define UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR	0x8308c
> +
>  #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
>  #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
>  #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
> @@ -44,9 +49,35 @@
>  
>  #define GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT BIT(25)
>  
> +/* UFS AXI clock frequency table */
> +static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
> +	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
> +	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
> +	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
> +	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
> +	{ }
> +};
> +
> +/* UFS ICE CORE clock frequency table */
> +static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
> +	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
> +	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
> +	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
> +	{ }
> +};
> +
> +/* UFS UNIPRO CORE clock frequency table */
> +static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
> +	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
> +	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
> +	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
> +	{ }
> +};
> +
>  static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>  {
>  	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
>  
>  	if (clk->id < priv->data->num_clks)
>  		debug("%s: %s, requested rate=%ld\n", __func__,
> @@ -63,6 +94,24 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
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
> @@ -106,6 +155,20 @@ static const struct gate_clk sa8775p_clks[] = {
>  
>  	/* QUP Wrapper 3 clocks */
>  	GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
> +
> +	/* UFS PHY clocks */
> +	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x83018, 1),
> +	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, 1),
> +	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x83020, 1),
> +	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, 1),
> +	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x83024, 1),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x83028, 1),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x830c0, 1),
> +	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, 1),
> +	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, 1),
> +
> +	/* EDP reference clock (used by UFS PHY) */
> +	GATE_CLK(GCC_EDP_REF_CLKREF_EN, 0x97448, 1),
>  };
>  
>  static int sa8775p_enable(struct clk *clk)
> 
> -- 
> 2.34.1
> 
