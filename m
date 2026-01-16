Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8457D47CC3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58FFC830E4;
	Fri, 16 Jan 2026 11:04:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d8Qb1W4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3ED783923; Fri, 16 Jan 2026 11:04:45 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C6608309A
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A742D43C03;
 Fri, 16 Jan 2026 10:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C30BC116C6;
 Fri, 16 Jan 2026 10:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768557881;
 bh=qUyMqlCwJRai8XhgcS/eK1EY6dARQ0rpx49106MoC9k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d8Qb1W4SOOVhw3Jnbfq2OSlY9/akX7sIikW9EwVOjGOTdZDRORU2pDL4BStaYJgig
 y5hrpTd3EG/veqwS5/8I8bH+A+L23LawsVayCPXzlh7DSt6K2+Mq3x1PQ0QLWMr8pv
 5kvh8ANhlTJMWLwegrWusWSxbOCT9/LDp5EKrMhHZZb0ZP+pZg4Ze67J11jHVaivZn
 x0OzD+KBxveEEH3Jjueu8HOARu+dq5WWoDoWwG3z6mY6r4ez07R+BrualuGq8HkKdN
 ZwnGSzZW6BKNZBjxIl5wFG0RUd6sz2Um5rJgUwK3CM9eWRNVPQFnEJeEAFrayye/2b
 diSB0iz02kdoA==
Date: Fri, 16 Jan 2026 15:34:35 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: lukma@denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, swathi.tamilselvan@oss.qualcomm.com,
 quic_varada@quicinc.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1] clk: qcom: sa8775p: Fix USB clock configuration and
 add resets
Message-ID: <aWoNM-KZbD04Mu-F@sumit-xelite>
References: <20260113065856.3287772-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113065856.3287772-1-balaji.selvanathan@oss.qualcomm.com>
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

On Tue, Jan 13, 2026 at 12:28:55PM +0530, Balaji Selvanathan wrote:
> Correct USB30 primary clock RCG configuration and add missing
> USB3_PRIM_PHY_AUX_CMD_RCGR RCG configuration.
> Above taken from Linux commit 08c51ceb12f7 ("clk: qcom: add the GCC driver for sa8775p")
> 
> Add missing USB3_PRIM_PHY_PIPE_CLK gate clock definition.
> Extend reset map with USB-related BCR entries and video BCR
> for comprehensive reset control support.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clock-sa8775p.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)

With the indentation fixes, feel free to add:

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
> index 5a6fbd417ff..25c8cd4af9a 100644
> --- a/drivers/clk/qcom/clock-sa8775p.c
> +++ b/drivers/clk/qcom/clock-sa8775p.c
> @@ -15,8 +15,9 @@
>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
>  #include "clock-qcom.h"
>  
> -#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
> -#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
> +#define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
>  
>  #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
>  #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
> @@ -59,8 +60,8 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>  	case GCC_USB30_PRIM_MASTER_CLK:
>  		WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
>  		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
> -				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
> -		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
> +			5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
> +		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
>  		return rate;
>  	default:
>  		return 0;
> @@ -75,6 +76,7 @@ static const struct gate_clk sa8775p_clks[] = {
>  	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, 1),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, 1),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1b064, 1),
>  
>  	/* QUP Wrapper 0 clocks */
>  	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x4b008, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
> @@ -157,6 +159,24 @@ static const struct qcom_reset_map sa8775p_gcc_resets[] = {
>  	[GCC_TSCSS_BCR] = { 0x21000 },
>  	[GCC_UFS_CARD_BCR] = { 0x81000 },
>  	[GCC_UFS_PHY_BCR] = { 0x83000 },
> +	[GCC_USB20_PRIM_BCR] = {0x1c000},
> +	[GCC_USB2_PHY_PRIM_BCR] = {0x5c028},
> +	[GCC_USB2_PHY_SEC_BCR] = {0x5c02c},
> +	[GCC_USB30_PRIM_BCR] = {0x1b000},
> +	[GCC_USB30_SEC_BCR] = {0x2f000},
> +	[GCC_USB3_DP_PHY_PRIM_BCR] = {0x5c008},
> +	[GCC_USB3_DP_PHY_SEC_BCR] = {0x5c014},
> +	[GCC_USB3_PHY_PRIM_BCR] = {0x5c000},
> +	[GCC_USB3_PHY_SEC_BCR] = {0x5c00c},
> +	[GCC_USB3_PHY_TERT_BCR] = {0x5c030},
> +	[GCC_USB3_UNIPHY_MP0_BCR] = {0x5c018},
> +	[GCC_USB3_UNIPHY_MP1_BCR] = {0x5c01c},
> +	[GCC_USB3PHY_PHY_PRIM_BCR] = {0x5c004},
> +	[GCC_USB3PHY_PHY_SEC_BCR] = {0x5c010},
> +	[GCC_USB3UNIPHY_PHY_MP0_BCR] = {0x5c020},
> +	[GCC_USB3UNIPHY_PHY_MP1_BCR] = {0x5c024},
> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = {0x76000},
> +	[GCC_VIDEO_BCR] = {0x34000}
>  };
>  
>  static const struct qcom_power_map sa8775p_gdscs[] = {
> -- 
> 2.34.1
> 
