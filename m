Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC86D4A605
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 07:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD8D82BF2;
	Fri, 16 Jan 2026 08:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eoHeWBma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D7A983015; Fri, 16 Jan 2026 08:28:54 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CE8980077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 08:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C467260160;
 Fri, 16 Jan 2026 07:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389F4C19421;
 Fri, 16 Jan 2026 07:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768548530;
 bh=zb7L0XbnZ1/CpY3VdDn9kWtK9dumhgSPLYuy1FS8dPI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eoHeWBmaZ+y7Rgw436lV8P1djEqKoid6+KcP88tK8ThOpgh1esKyZcj3mAw5GYSBq
 6PsxqDyFu2PCMn5hoIuxUF9hJxlUPReKs5mL88SBDiirIerkcYgfmiZOLCMiwLvIGv
 UN0negF9dY0qw4t5Vg29x9FLhyAt1ZX1+dtijOziPIB1tRAWLyH9eCyEXlu16P7UCE
 Y03BfAXJe+oCrxoI9cI8FD+cGfoZf8zIBM6fHppUiQBBd3nAA2tzZKDyudD27w0PhU
 rZcLbIFGa/RRPPSK6IpBqUOttoTsg+Zi8an9+l9+jdZ3zNfw68XgE+NCnQg+asucRm
 1rnrP7HUtmvVg==
Date: Fri, 16 Jan 2026 12:58:43 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] clk/qcom: sc7280: add more QUP clocks
Message-ID: <aWnoqwR-lJsVeg3B@sumit-xelite>
References: <20260108195007.3156604-1-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108195007.3156604-1-casey.connolly@linaro.org>
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

On Thu, Jan 08, 2026 at 08:49:55PM +0100, Casey Connolly wrote:
> Add more clocks for UART2, i2c9 and a few others. This is enough to get
> the rubikpi 3 working.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/clk/qcom/clock-sc7280.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Good to see rubikpi 3 support coming in, I suppose the DT will be
available in next U-Boot DT sync.

FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> index 55a233df3945..7b6ed8260236 100644
> --- a/drivers/clk/qcom/clock-sc7280.c
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -62,8 +62,13 @@ static ulong sc7280_set_rate(struct clk *clk, ulong rate)
>  	if (clk->id < priv->data->num_clks)
>  		debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
>  
>  	switch (clk->id) {
> +	case GCC_QUPV3_WRAP0_S2_CLK: /* UART2 */
> +		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s2_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, 0x17270,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 16);
> +		return freq->freq;
>  	case GCC_QUPV3_WRAP0_S5_CLK: /* UART5 */
>  		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s2_clk_src, rate);
>  		clk_rcg_set_rate_mnd(priv->base, 0x17600,
>  				     freq->pre_div, freq->m, freq->n, freq->src, 16);
> @@ -131,11 +136,15 @@ static const struct gate_clk sc7280_clks[] = {
>  	GATE_CLK(GCC_AGGRE_NOC_PCIE_1_AXI_CLK, 0x52000, BIT(11)),
>  	GATE_CLK(GCC_AGGRE_NOC_PCIE_CENTER_SF_AXI_CLK, 0x52008, BIT(28)),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, BIT(10)),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, BIT(11)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x52008, BIT(12)),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, BIT(13)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK, 0x52008, BIT(14)),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x52008, BIT(15)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S6_CLK, 0x52008, BIT(16)),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK, 0x52008, BIT(17)),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK, 0x52008, BIT(23)),
>  	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
>  	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0)),
>  	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0)),
>  	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, BIT(0)),
> @@ -189,8 +198,11 @@ static int sc7280_enable(struct clk *clk)
>  		break;
>  	case GCC_QUPV3_WRAP0_S3_CLK:
>  		clk_rcg_set_rate_mnd(priv->base, 0x173a0, 1, 0, 0, CFG_CLK_SRC_CXO, 16);
>  		break;
> +	case GCC_QUPV3_WRAP1_S1_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, 0x18140, 1, 0, 0, CFG_CLK_SRC_CXO, 16);
> +		break;
>  	}
>  
>  	return qcom_gate_clk_en(priv, clk->id);
>  }
> -- 
> 2.51.0
> 
