Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826E6D25944
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 06:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1D8D83F85;
	Tue, 27 Jan 2026 07:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bw1Dvwon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B45883F8A; Tue, 27 Jan 2026 07:29:08 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 446F283B0B
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 07:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1319D43280;
 Tue, 27 Jan 2026 06:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688ACC116C6;
 Tue, 27 Jan 2026 06:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769495343;
 bh=9ZZ07ExEJWzGquzANFECxT+85BQhEn3Ip8g66e8aKGU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bw1Dvwone1kQIDTZkMPZht0Q39M1b8jARVZWB9k29Wehwq0qaSnfb05OPIrI/4Yy4
 noGWD/oV6827FfMDCHJVsuzEQBJ0UL+/u+YhY2CDwWIkeK32kTcnkPa6MW1F8dZUZ5
 aZmDynxKUrEMFs7a3zSH9EDkbEPWh8lPcRIx6HPcxlst+6/iiD+ibgASoNvia3P2P3
 bRT6ZbWAIH8BPjKca1fNZQNSayllUHW4jStpH9Qh64bInhjhkB9ZNsnKHrmzB9MZSE
 n0HniA2ZBhwQcPTfmvlScJ6P17EmSU4jVzPd556McqSJPHM1Scl2o97Pi7knj3TyKZ
 vnBmjh0Jn/5oQ==
Date: Tue, 27 Jan 2026 11:58:49 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, lukma@denx.de,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 david.wronek@mainlining.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, jorge.ramirez@oss.qualcomm.com,
 stephan.gerhold@linaro.org, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/3] clk: qcom: Add QCS615 SDCC clock support and
 RPMH-CLK compatibility
Message-ID: <aXhbIav5Wk4o466J@sumit-xelite>
References: <20260126155938.2717540-1-balaji.selvanathan@oss.qualcomm.com>
 <20260126155938.2717540-2-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126155938.2717540-2-balaji.selvanathan@oss.qualcomm.com>
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

On Mon, Jan 26, 2026 at 09:29:36PM +0530, Balaji Selvanathan wrote:
> Add SDCC (SD Card Controller) clock support for QCS615 platform to
> enable eMMC functionality. This includes adding SDCC1 and SDCC2 clock
> gates, implementing SDCC1 apps clock rate configuration
> and adding QCS615 RPMH clock compatibility to the stub
> driver to handle device tree clock controller references.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/clk/clk-stub.c          |  2 +-
>  drivers/clk/qcom/clock-qcom.h   |  1 +
>  drivers/clk/qcom/clock-qcs615.c | 10 ++++++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 117266ac778..1bc749e47b3 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -50,6 +50,7 @@ static struct clk_ops stub_clk_ops = {
>  
>  static const struct udevice_id stub_clk_ids[] = {
>  	{ .compatible = "qcom,rpmcc" },
> +	{ .compatible = "qcom,qcs615-rpmh-clk" },
>  	{ .compatible = "qcom,sdm670-rpmh-clk" },
>  	{ .compatible = "qcom,sdm845-rpmh-clk" },
>  	{ .compatible = "qcom,sc7180-rpmh-clk" },
> @@ -69,4 +70,3 @@ U_BOOT_DRIVER(clk_stub) = {
>  	.of_match = stub_clk_ids,
>  	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
>  };
> -
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 3a4550d8536..bc7e0453cba 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -14,6 +14,7 @@
>  #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
>  #define CFG_CLK_SRC_GPLL2 (2 << 8)
>  #define CFG_CLK_SRC_GPLL2_MAIN (2 << 8)
> +#define CFG_CLK_SRC_GPLL6_OUT_MAIN (2 << 8)
>  #define CFG_CLK_SRC_GPLL9 (2 << 8)
>  #define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
>  #define CFG_CLK_SRC_GPLL6 (4 << 8)
> diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
> index 4700baba8c9..483642531ef 100644
> --- a/drivers/clk/qcom/clock-qcs615.c
> +++ b/drivers/clk/qcom/clock-qcs615.c
> @@ -18,6 +18,7 @@
>  #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0xf034
>  #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0xf01c
>  #define USB3_PRIM_PHY_AUX_CMD_RCGR		0xf060
> +#define SDCC1_APPS_CLK_CMD_RCGR			0x12028
>  
>  #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
>  #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
> @@ -52,6 +53,10 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
>  				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
>  		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
>  		return rate;
> +	case GCC_SDCC1_APPS_CLK:
> +		clk_rcg_set_rate(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
> +				 1, CFG_CLK_SRC_GPLL6_OUT_MAIN);
> +		return rate;
>  	default:
>  		return 0;
>  	}
> @@ -66,6 +71,11 @@ static const struct gate_clk qcs615_clks[] = {
>  	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0)),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0)),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x12008, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x12004, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x1200c, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0)),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x5200c, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
>  	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x5200c, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),
> -- 
> 2.34.1
> 
