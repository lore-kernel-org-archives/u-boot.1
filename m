Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7911DEBFD20
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6803839DF;
	Mon, 13 Apr 2026 11:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="adzizg67";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A2C84198; Mon, 13 Apr 2026 11:36:03 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38021839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F004860172;
 Mon, 13 Apr 2026 09:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEB8C116C6;
 Mon, 13 Apr 2026 09:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776072958;
 bh=r1pbBtBIh6EVc++wpzvOaPa+Vr08o+TGK+Wip+I2FEk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=adzizg67x0r4Jbjiy6x0NHMx9onAtjsaaSNT9HrvAibaTJtkZUp4OeURPCq22EbsJ
 vfD4b7fMX3v0sq71ID99MJcPsH1SxFfhkU9HW9Zmb0Ul/HAE6ngOy9tfnsOw4H0EmH
 LVrj5FTINKiK9cxv7hDRb6nz9eiYQJmOgGZkvmWYPlzBbLneNqi7V7mBCsAHxNJVEa
 gpLrzJ/j01JI0Ua2UuX+ueNqZwIvhCCYLjSrBCWtuwoEvZk0r7J1SvvZzumRPieRKp
 54C2O/hpfFNvDONJXv09ilCvJg0GSr/rCuwifisgPdoaRIuFrY8pTSBZ2Q6fbOj1jx
 FNjFjgLSP5chA==
Date: Mon, 13 Apr 2026 15:05:49 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] clk: qcom: qcs615: Add SDCC1 and SDCC2 clock support
Message-ID: <ady49cgq57C94ixM@sumit-xelite>
References: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
 <20260324-emmc_sd-v1-1-883a45538b6e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-emmc_sd-v1-1-883a45538b6e@oss.qualcomm.com>
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

On Tue, Mar 24, 2026 at 11:22:34AM +0530, Balaji Selvanathan wrote:
> Add clock support for SDCC1 (eMMC) and SDCC2 (SD card) controllers
> on QCS615 platform. This enables proper clock configuration for both
> storage interfaces.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clock-qcom.h   |  2 ++
>  drivers/clk/qcom/clock-qcs615.c | 46 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 47 insertions(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 3a4550d8536..9899cd28aad 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -14,6 +14,8 @@
>  #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
>  #define CFG_CLK_SRC_GPLL2 (2 << 8)
>  #define CFG_CLK_SRC_GPLL2_MAIN (2 << 8)
> +#define CFG_CLK_SRC_GPLL6_OUT_MAIN (2 << 8)
> +#define CFG_CLK_SRC_GPLL8 (2 << 8)
>  #define CFG_CLK_SRC_GPLL9 (2 << 8)
>  #define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
>  #define CFG_CLK_SRC_GPLL6 (4 << 8)
> diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
> index 4700baba8c9..cea7e7f43f3 100644
> --- a/drivers/clk/qcom/clock-qcs615.c
> +++ b/drivers/clk/qcom/clock-qcs615.c
> @@ -19,6 +19,34 @@
>  #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0xf01c
>  #define USB3_PRIM_PHY_AUX_CMD_RCGR		0xf060
>  
> +#define SDCC1_APPS_CLK_CMD_RCGR			0x12028
> +#define SDCC2_APPS_CLK_CMD_RCGR			0x1400c
> +
> +/*
> + * Frequency tables for SDCC clocks
> + */
> +static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
> +	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(20000000, CFG_CLK_SRC_GPLL0_AUX2, 5, 1, 3),
> +	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 1, 2),
> +	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
> +	F(192000000, CFG_CLK_SRC_GPLL6_OUT_MAIN, 2, 0, 0),
> +	F(384000000, CFG_CLK_SRC_GPLL6_OUT_MAIN, 1, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 12, 0, 0),
> +	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
> +	F(202000000, CFG_CLK_SRC_GPLL8, 2, 0, 0),
> +	{ }
> +};
> +
>  #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
>  #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
>  #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
> @@ -36,6 +64,7 @@
>  static ulong qcs615_set_rate(struct clk *clk, ulong rate)
>  {
>  	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
>  
>  	if (clk->id < priv->data->num_clks)
>  		debug("%s: %s, requested rate=%ld\n", __func__,
> @@ -52,6 +81,16 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
>  				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
>  		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
>  		return rate;
> +	case GCC_SDCC1_APPS_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_SDCC2_APPS_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
>  	default:
>  		return 0;
>  	}
> @@ -79,7 +118,12 @@ static const struct gate_clk qcs615_clks[] = {
>  	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK, 0x5200c, GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT),
>  	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK, 0x5200c, GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT),
>  	GATE_CLK(GCC_DISP_HF_AXI_CLK, 0xb038, BIT(0)),
> -	GATE_CLK(GCC_DISP_AHB_CLK, 0xb032, BIT(0))
> +	GATE_CLK(GCC_DISP_AHB_CLK, 0xb032, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x12008, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x12004, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x1200c, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0))
>  };
>  
>  static int qcs615_enable(struct clk *clk)
> 
> -- 
> 2.34.1
> 
