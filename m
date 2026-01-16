Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF73D47CB8
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DD2830E4;
	Fri, 16 Jan 2026 11:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fbKeKy2j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FC48389A; Fri, 16 Jan 2026 11:02:33 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CBDF8309A
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 51D2460167;
 Fri, 16 Jan 2026 10:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F64C116C6;
 Fri, 16 Jan 2026 10:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768557750;
 bh=CjCK3adk2r1QOKyoyQhRy7jRsDgt6KTzip9g9VT347E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fbKeKy2jFK1w7IXoJglPsFmmJ4OHp/sTy46P5TGT30viDtu5A2pHjQe0ClepAr69X
 /C0PQHqHvPkmUOINu0vtygQ5xxMKteQNf/cTUev3aPqtvDDjwvl/4EwMwdLwWNtJqw
 pO7uIDMBMZ3amkWMnwIxHhlVtrpqasOGTLYZufb6D57vP5w4/JELQEtyylcJpSsTCh
 a49h+OrHhqc7bked5lhRe3uYXGdZ+g9LTSG4TCyJs0fsmUWue43tmHVi3ZrB9Fv3VE
 HV2gjDVMKS/2Q0hkgEtxpI8hBZTiBqerHXXcz3k19Dp/N8Goll0CLTJF/zjo9rO+RC
 I/NZsBLT9m0oA==
Date: Fri, 16 Jan 2026 15:32:22 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: lukma@denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, quic_varada@quicinc.com,
 swathi.tamilselvan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] clk: qcom: sa8775p: Add QUP serial engine clock support
Message-ID: <aWoMrjhSlH17VGBt@sumit-xelite>
References: <20260113042213.3107106-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113042213.3107106-1-balaji.selvanathan@oss.qualcomm.com>
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

On Tue, Jan 13, 2026 at 09:52:13AM +0530, Balaji Selvanathan wrote:
> From: Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>
> 
> Add clock gate definitions and entries for QUP (Qualcomm Universal
> Peripheral) serial engine clocks across all four wrappers on SA8775P.
> This enables proper clock management for I2C, SPI, and UART
> peripherals connected to the QUP blocks.
> 
> This resolves the "unknown clock ID 133" error for UART10 and
> provides complete QUP clock infrastructure for the platform.
> 
> Signed-off-by: Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clock-sa8775p.c | 54 ++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
> index 527cecf5c82..5a6fbd417ff 100644
> --- a/drivers/clk/qcom/clock-sa8775p.c
> +++ b/drivers/clk/qcom/clock-sa8775p.c
> @@ -18,6 +18,31 @@
>  #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
>  #define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
>  
> +#define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
> +#define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
> +#define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
> +#define GCC_QUPV3_WRAP0_S3_CLK_ENA_BIT BIT(13)
> +#define GCC_QUPV3_WRAP0_S4_CLK_ENA_BIT BIT(14)
> +#define GCC_QUPV3_WRAP0_S5_CLK_ENA_BIT BIT(15)
> +
> +#define GCC_QUPV3_WRAP1_S0_CLK_ENA_BIT BIT(22)
> +#define GCC_QUPV3_WRAP1_S1_CLK_ENA_BIT BIT(23)
> +#define GCC_QUPV3_WRAP1_S2_CLK_ENA_BIT BIT(24)
> +#define GCC_QUPV3_WRAP1_S3_CLK_ENA_BIT BIT(25)
> +#define GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT BIT(26)
> +#define GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT BIT(27)
> +#define GCC_QUPV3_WRAP1_S6_CLK_ENA_BIT BIT(27)
> +
> +#define GCC_QUPV3_WRAP2_S0_CLK_ENA_BIT BIT(4)
> +#define GCC_QUPV3_WRAP2_S1_CLK_ENA_BIT BIT(5)
> +#define GCC_QUPV3_WRAP2_S2_CLK_ENA_BIT BIT(6)
> +#define GCC_QUPV3_WRAP2_S3_CLK_ENA_BIT BIT(7)
> +#define GCC_QUPV3_WRAP2_S4_CLK_ENA_BIT BIT(8)
> +#define GCC_QUPV3_WRAP2_S5_CLK_ENA_BIT BIT(9)
> +#define GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT BIT(29)
> +
> +#define GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT BIT(25)
> +
>  static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>  {
>  	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -50,6 +75,35 @@ static const struct gate_clk sa8775p_clks[] = {
>  	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, 1),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, 1),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, 1),
> +
> +	/* QUP Wrapper 0 clocks */
> +	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x4b008, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x4b008, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x4b008, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x4b008, GCC_QUPV3_WRAP0_S3_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK, 0x4b008, GCC_QUPV3_WRAP0_S4_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x4b008, GCC_QUPV3_WRAP0_S5_CLK_ENA_BIT),
> +
> +	/* QUP Wrapper 1 clocks (includes uart10) */
> +	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK, 0x4b008, GCC_QUPV3_WRAP1_S0_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK, 0x4b008, GCC_QUPV3_WRAP1_S1_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK, 0x4b008, GCC_QUPV3_WRAP1_S2_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK, 0x4b008, GCC_QUPV3_WRAP1_S3_CLK_ENA_BIT),  /* uart10 */
> +	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK, 0x4b008, GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK, 0x4b008, GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S6_CLK, 0x4b018, GCC_QUPV3_WRAP1_S6_CLK_ENA_BIT),
> +
> +	/* QUP Wrapper 2 clocks */
> +	GATE_CLK(GCC_QUPV3_WRAP2_S0_CLK, 0x4b010, GCC_QUPV3_WRAP2_S0_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP2_S1_CLK, 0x4b010, GCC_QUPV3_WRAP2_S1_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP2_S2_CLK, 0x4b010, GCC_QUPV3_WRAP2_S2_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP2_S3_CLK, 0x4b010, GCC_QUPV3_WRAP2_S3_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP2_S4_CLK, 0x4b010, GCC_QUPV3_WRAP2_S4_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP2_S5_CLK, 0x4b010, GCC_QUPV3_WRAP2_S5_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP2_S6_CLK, 0x4b018, GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT),
> +
> +	/* QUP Wrapper 3 clocks */
> +	GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
>  };
>  
>  static int sa8775p_enable(struct clk *clk)
> -- 
> 2.34.1
> 
