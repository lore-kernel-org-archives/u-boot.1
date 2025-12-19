Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB558D78776
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 13:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D71080077;
	Fri, 19 Dec 2025 14:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eGGYf2ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF53E8042F; Fri, 19 Dec 2025 14:58:17 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88F2180050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 14:58:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DF27543B3A;
 Fri, 19 Dec 2025 13:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B99C4CEF1;
 Fri, 19 Dec 2025 13:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766152693;
 bh=KJiqT3PSab0Dc2WcXOfyGZxxQ2zsByR14G7Rvn9xes4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eGGYf2ruaxvVfDfwBdjpIz6b2fTl6TvLM3INlPzcMlCkHOp3QfhO3BRD+fuFidGg6
 xly5V/WXfyNTqvKw33jbMiISO6FI2KiVXKr8M0K6MG8UdT1ndj6DNbQE7OsEpOT3I+
 18lGXouxmjvXu78UAvqVXJoUZDDGZcBbFwlldosIJS25L3ttIAkeuSQt5lRwWw5giP
 CYqr25asaPZEFQiGK+HgS3+NmRtSfk8kaVcCKwvow1S+hLT76ZR1sS/Jlde5bIQbkN
 YKfP29ph41Gc6xt7Sim75v7bwPt8X+cLqJfeuvbdvPMGIc1iRHJY1rpDGKg5KShevz
 I1oWPSoiINY6g==
Date: Fri, 19 Dec 2025 19:28:05 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [RESEND v2 1/6] clk/qcom: Add USB related clocks for IPQ9574
Message-ID: <aUVZ7VQrcjPV4Ftu@sumit-xelite>
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
 <20251218061557.1999367-2-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218061557.1999367-2-varadarajan.narayanan@oss.qualcomm.com>
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

On Thu, Dec 18, 2025 at 11:45:52AM +0530, Varadarajan Narayanan wrote:
> Add the USB controller and phy related clocks.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clock-ipq9574.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/clk/qcom/clock-ipq9574.c b/drivers/clk/qcom/clock-ipq9574.c
> index b0af4036059..1f5146b29a1 100644
> --- a/drivers/clk/qcom/clock-ipq9574.c
> +++ b/drivers/clk/qcom/clock-ipq9574.c
> @@ -25,6 +25,9 @@
>  #define GCC_SDCC1_AHB_CBCR			0x33034
>  #define GCC_SDCC1_APPS_CMD_RCGR			0x33004
>  #define GCC_SDCC1_ICE_CORE_CBCR			0x33030
> +#define GCC_USB0_MASTER_CMD_RCGR		0x2c004
> +#define GCC_USB0_MOCK_UTMI_CMD_RCGR		0x2c02c
> +#define GCC_USB0_AUX_CMD_RCGR			0x2C018
>  
>  static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
>  {
> @@ -39,6 +42,17 @@ static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
>  		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CMD_RCGR,
>  				     11, 0, 0, CFG_CLK_SRC_GPLL2, 16);
>  		return rate;
> +	case GCC_USB0_MASTER_CLK:
> +		clk_rcg_set_rate(priv->base, GCC_USB0_MASTER_CMD_RCGR,
> +				 4, CFG_CLK_SRC_GPLL0);
> +		return rate;
> +	case GCC_USB0_MOCK_UTMI_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, GCC_USB0_MOCK_UTMI_CMD_RCGR,
> +				     0, 0, 0, CFG_CLK_SRC_CXO, 8);
> +		return rate;
> +	case GCC_USB0_AUX_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, GCC_USB0_AUX_CMD_RCGR, 0, 0, 0,
> +				     CFG_CLK_SRC_CXO, 8);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -50,6 +64,14 @@ static const struct gate_clk ipq9574_clks[] = {
>  	GATE_CLK(GCC_SDCC1_AHB_CLK,		0x33034, 0x00000001),
>  	GATE_CLK(GCC_SDCC1_APPS_CLK,		0x3302C, 0x00000001),
>  	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK,	0x33030, 0x00000001),
> +	GATE_CLK(GCC_SNOC_USB_CLK,		0x2e058, 0x00000001),
> +	GATE_CLK(GCC_USB0_MASTER_CLK,		0x2c044, 0x00000001),
> +	GATE_CLK(GCC_ANOC_USB_AXI_CLK,		0x2e084, 0x00000001),
> +	GATE_CLK(GCC_USB0_SLEEP_CLK,		0x2c058, 0x00000001),
> +	GATE_CLK(GCC_USB0_MOCK_UTMI_CLK,	0x2c04c, 0x00000001),
> +	GATE_CLK(GCC_USB0_PHY_CFG_AHB_CLK,	0x2c05c, 0x00000001),
> +	GATE_CLK(GCC_USB0_AUX_CLK,		0x2c048, 0x00000001),
> +	GATE_CLK(GCC_USB0_PIPE_CLK,		0x2c054, 0x00000001),
>  };
>  
>  static int ipq9574_enable(struct clk *clk)
> @@ -67,6 +89,10 @@ static int ipq9574_enable(struct clk *clk)
>  }
>  
>  static const struct qcom_reset_map ipq9574_gcc_resets[] = {
> +	[GCC_USB_BCR] = { 0x2c000 },
> +	[GCC_QUSB2_0_PHY_BCR] = { 0x2c068 },
> +	[GCC_USB0_PHY_BCR] = {0x2c06c, 0},
> +	[GCC_USB3PHY_0_PHY_BCR] = {0x2c070, 0},
>  	[GCC_SDCC_BCR] = { 0x33000 },
>  };
>  
> @@ -75,6 +101,8 @@ static struct msm_clk_data ipq9574_gcc_data = {
>  	.num_resets = ARRAY_SIZE(ipq9574_gcc_resets),
>  	.enable = ipq9574_enable,
>  	.set_rate = ipq9574_set_rate,
> +	.clks = ipq9574_clks,
> +	.num_clks = ARRAY_SIZE(ipq9574_clks),
>  };
>  
>  static const struct udevice_id gcc_ipq9574_of_match[] = {
> -- 
> 2.34.1
> 
