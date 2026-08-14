Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D88C5CFDB
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 12:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8008940987;
	Fri, 14 Aug 2026 12:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VRs7MT5qhrOo; Fri, 14 Aug 2026 12:46:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0DC3408ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786711593;
	bh=V6yzlgcXrCpiy5m1AtdUErZ7Hsy1jJwTBCmPbdl6Ltg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KverdoF38mt6QF92peamv3Jmk15WREXS3Qp0Eyc079uY/X5vsw3cm55LrJt4ljHhX
	 fjWG7pTBsF/H2wt4SULhChTuyM9qI6OTlsBEW9SmPIzZfsEh3kaln8nbLFum9NNm2m
	 hzMJhjw69pHnzuA9nVYR6NUoqeFJg2DymdD8o3QQFphs3XZArtLY1QOkLl8Yjtkp16
	 nRVcqWdKn2g4ijGkowChSN/oSPIXJ1gOFrPOGd3UlyuEytKLVtHkeN2HJZGtvONCVP
	 2eursnI9lvezl9JcmZNwIrHpNDxM3i5MeQOEUZgg3k2O0Ne83lnLqv0uuzynmqcLM0
	 sGpEnnvq7C7ZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0DC3408ED;
	Fri, 14 Aug 2026 12:46:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 27F1A139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1980680EC8
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:38:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oc1YBn97sJQ6 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 08:38:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 51AD380E94
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 51AD380E94
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bfjYZZiw
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51AD380E94
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:38:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 03A4D4023D;
 Fri, 14 Aug 2026 08:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2B11F000E9;
 Fri, 14 Aug 2026 08:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786696682;
 bh=V6yzlgcXrCpiy5m1AtdUErZ7Hsy1jJwTBCmPbdl6Ltg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bfjYZZiwfQkjLg14n6F6bYKL/okGcG3ADoR1+bpvNw+MEMwlSEJudDSkhIesRBn4f
 zYKZmDaEg610/3tRgi5sFB9cDY4xXHNutXheo4uICnkSBlTDgQoSYgigEYhG0MZqrH
 pha9KnuliPSCZB3iU0l6sh1rBFMaJdGLDdh7AlzXpPO6QWy8QpHyms8UwGKIpSMamV
 QSQeSZd24W3fwP/RMUMNnd1QWs3mvPJ6mdpiyARrT/InHTo2XEmIu5y0Uc8O+eSzm5
 XfssHNbs1r02hxZ8f3C2Fc7nB7CBI3GKtGLk1Qxb9TH/wwqa+VVOvJ4RAEcZ92kOrp
 rkXM7+yMEBTjw==
Date: Fri, 14 Aug 2026 08:38:00 +0000
From: Yixun Lan <dlan@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Guodong Xu <guodong@riscstar.com>, Heiko Schocher <hs@nabladev.com>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@riscstar.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH 2/2] i2c: k1: enable all clocks for I2C controllers
Message-ID: <20260814083800-GKA318749@kernel.org>
References: <20260814-k1-i2c-fix-v1-0-f2e19cbe0af6@pigmoral.tech>
 <20260814-k1-i2c-fix-v1-2-f2e19cbe0af6@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814-k1-i2c-fix-v1-2-f2e19cbe0af6@pigmoral.tech>
X-Mailman-Approved-At: Fri, 14 Aug 2026 12:46:31 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 09:46 Fri 14 Aug     , Junhui Liu wrote:
> The K1 clock driver modeled the bus clock enable bit as part of the
> functional clock for regular TWSI controllers. The I2C driver then only
> enabled the functional clock, ignoring the separate bus clock described
> by the device tree. Although this happened to work, it did not match the
> hardware clock topology or the device tree binding.
> 
> Model the functional and bus clocks separately and make the I2C driver
> acquire and enable all clocks provided by the device tree. Also add the
> TWSI2 and TWSI8 bus clocks, together with their APB clock dependencies,
> to the SPL clock tree.
> 
> Keep the combined functional and bus gate for TWSI8, whose clock control
> register is write-only, and retain its bus clock as a fixed-factor
> placeholder.
> 
> The clock-provider and I2C-consumer changes should be applied together,
> as either change on its own would leave I2C unusable.
> 
> Fixes: 3aa2882a3e1a ("clk: spacemit: Add support for K1 SoC")
> Fixes: 271546fb8e54 ("i2c: k1: add I2C driver support")
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  drivers/clk/spacemit/clk-k1.c | 41 +++++++++++++++++++++++++++++++++--------
>  drivers/i2c/k1_i2c.c          | 10 ++++------
I'd suggest to have separate patch for clock and i2c changes, as they
belong to different subsystem

>  2 files changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k1.c
> index 07adc126ee39..20b8595aa3c4 100644
> --- a/drivers/clk/spacemit/clk-k1.c
> +++ b/drivers/clk/spacemit/clk-k1.c
> @@ -154,11 +154,27 @@ CCU_GATE_DEFINE(CLK_PLL1_409P6, pll1_d6_409p6, pll1_d6_409p6, "pll1_d6",
>  		MPMU_ACGR, BIT(0), 0);
>  CCU_GATE_DEFINE(CLK_PLL1_307P2, pll1_d8_307p2, pll1_d8_307p2, "pll1_d8",
>  		MPMU_ACGR, BIT(13), 0);
> +CCU_FACTOR_GATE_DEFINE(CLK_PLL1_102P4, pll1_d24_102p4, pll1_d24_102p4,
> +		       "pll1_d8", MPMU_ACGR, BIT(12), 3, 1);
> +CCU_FACTOR_GATE_DEFINE(CLK_PLL1_51P2, pll1_d48_51p2, pll1_d48_51p2,
> +		       "pll1_d8", MPMU_ACGR, BIT(7), 6, 1);
> +CCU_FACTOR_GATE_DEFINE(CLK_PLL1_25P6, pll1_d96_25p6, pll1_d96_25p6,
> +		       "pll1_d8", MPMU_ACGR, BIT(4), 12, 1);
>  CCU_FACTOR_GATE_DEFINE(CLK_PLL1_31P5, pll1_d78_31p5, pll1_d78_31p5,
>  		       "pll1_d4", MPMU_ACGR, BIT(6), 39, 2);
>  CCU_DDN_DEFINE(CLK_SLOW_UART2, slow_uart2_48, slow_uart2_48,
>  	       "pll1_d4_614p4", MPMU_SUCCR_1,
>  	       CCU_DDN_MASK(16, 13), 16, CCU_DDN_MASK(0, 13), 0, 2, 0);
> +
> +static const char * const apb_parents[] = {
> +	"pll1_d96_25p6",
> +	"pll1_d48_51p2",
> +	"pll1_d96_25p6",
> +	"pll1_d24_102p4",
> +};
> +
> +CCU_MUX_DEFINE(CLK_APB, apb_clk, apb_clk, apb_parents, ARRAY_SIZE(apb_parents),
> +	       MPMU_APBCSCR, 0, 2, 0);
>  #else
>  CCU_GATE_DEFINE(CLK_PLL1_307P2, pll1_d8_307p2, pll1_d8_307p2, "pll1_d8",
>  		MPMU_ACGR, BIT(13), 0);
> @@ -298,7 +314,7 @@ static const char * const twsi_parents[] = {
>  
>  CCU_MUX_GATE_DEFINE(CLK_TWSI2, twsi2_clk, twsi2_clk, twsi_parents,
>  		    ARRAY_SIZE(twsi_parents), APBC_TWSI2_CLK_RST,
> -		    4, 3, BIT(1) | BIT(0), 0);
> +		    4, 3, BIT(1), 0);
>  /*
>   * APBC_TWSI8_CLK_RST has a quirk that reading always results in zero.
>   * Combine functional and bus bits together as a gate to avoid sharing the
> @@ -306,6 +322,9 @@ CCU_MUX_GATE_DEFINE(CLK_TWSI2, twsi2_clk, twsi2_clk, twsi_parents,
>   */
>  CCU_GATE_DEFINE(CLK_TWSI8, twsi8_clk, twsi8_clk, "pll1_d78_31p5",
>  		APBC_TWSI8_CLK_RST, BIT(1) | BIT(0), 0);
> +CCU_GATE_DEFINE(CLK_TWSI2_BUS, twsi2_bus_clk, twsi2_bus_clk, "apb_clk",
> +		APBC_TWSI2_CLK_RST, BIT(0), 0);
> +CCU_FACTOR_DEFINE(CLK_TWSI8_BUS, twsi8_bus_clk, twsi8_bus_clk, "apb_clk", 1, 1);
>  
>  #else
>  static const char * const uart_clk_parents[] = {
> @@ -326,7 +345,7 @@ static const char * const twsi_parents[] = {
>  
>  CCU_MUX_GATE_DEFINE(CLK_TWSI2, twsi2_clk, twsi2_clk, twsi_parents,
>  		    ARRAY_SIZE(twsi_parents), APBC_TWSI2_CLK_RST,
> -		    4, 3, BIT(1) | BIT(0), 0);
> +		    4, 3, BIT(1), 0);
>  /*
>   * APBC_TWSI8_CLK_RST has a quirk that reading always results in zero.
>   * Combine functional and bus bits together as a gate to avoid sharing the
> @@ -448,22 +467,22 @@ CCU_GATE_DEFINE(CLK_RTC, rtc_clk, rtc_clk, "clock-32k", APBC_RTC_CLK_RST,
>  
>  CCU_MUX_GATE_DEFINE(CLK_TWSI0, twsi0_clk, twsi0_clk, twsi_parents,
>  		    ARRAY_SIZE(twsi_parents), APBC_TWSI0_CLK_RST,
> -		    4, 3, BIT(1) | BIT(0), 0);
> +		    4, 3, BIT(1), 0);
>  CCU_MUX_GATE_DEFINE(CLK_TWSI1, twsi1_clk, twsi1_clk, twsi_parents,
>  		    ARRAY_SIZE(twsi_parents), APBC_TWSI1_CLK_RST,
> -		    4, 3, BIT(1) | BIT(0), 0);
> +		    4, 3, BIT(1), 0);
>  CCU_MUX_GATE_DEFINE(CLK_TWSI4, twsi4_clk, twsi4_clk, twsi_parents,
>  		    ARRAY_SIZE(twsi_parents), APBC_TWSI4_CLK_RST,
> -		    4, 3, BIT(1) | BIT(0), 0);
> +		    4, 3, BIT(1), 0);
>  CCU_MUX_GATE_DEFINE(CLK_TWSI5, twsi5_clk, twsi5_clk, twsi_parents,
>  		    ARRAY_SIZE(twsi_parents), APBC_TWSI5_CLK_RST,
> -		    4, 3, BIT(1) | BIT(0), 0);
> +		    4, 3, BIT(1), 0);
>  CCU_MUX_GATE_DEFINE(CLK_TWSI6, twsi6_clk, twsi6_clk, twsi_parents,
>  		    ARRAY_SIZE(twsi_parents), APBC_TWSI6_CLK_RST,
> -		    4, 3, BIT(1) | BIT(0), 0);
> +		    4, 3, BIT(1), 0);
>  CCU_MUX_GATE_DEFINE(CLK_TWSI7, twsi7_clk, twsi7_clk, twsi_parents,
>  		    ARRAY_SIZE(twsi_parents), APBC_TWSI7_CLK_RST,
> -		    4, 3, BIT(1) | BIT(0), 0);
> +		    4, 3, BIT(1), 0);
>  
>  static const char * const timer_parents[] = {
>  	"pll1_d192_12p8",
> @@ -1232,8 +1251,12 @@ static struct clk *k1_ccu_mpmu_clks[] = {
>  	&pll1_d4_614p4.common.clk,
>  	&pll1_d6_409p6.common.clk,
>  	&pll1_d8_307p2.common.clk,
> +	&pll1_d24_102p4.common.clk,
> +	&pll1_d48_51p2.common.clk,
> +	&pll1_d96_25p6.common.clk,
>  	&pll1_d78_31p5.common.clk,
>  	&slow_uart2_48.common.clk,
> +	&apb_clk.common.clk,
>  };
>  #else
>  static struct clk *k1_ccu_mpmu_clks[] = {
> @@ -1288,6 +1311,8 @@ static struct clk *k1_ccu_apbc_clks[] = {
>  	&uart0_clk.common.clk,
>  	&twsi2_clk.common.clk,
>  	&twsi8_clk.common.clk,
> +	&twsi2_bus_clk.common.clk,
> +	&twsi8_bus_clk.common.clk,
>  };
>  #else
>  static struct clk *k1_ccu_apbc_clks[] = {
> diff --git a/drivers/i2c/k1_i2c.c b/drivers/i2c/k1_i2c.c
> index 2c7a1e0d3775..b11f73959a08 100644
> --- a/drivers/i2c/k1_i2c.c
> +++ b/drivers/i2c/k1_i2c.c
> @@ -51,7 +51,7 @@ struct k1_i2c {
>  struct k1_i2c_priv {
>  	int id;
>  	void __iomem *base;
> -	struct clk clk;
> +	struct clk_bulk clks;
>  };
>  
>  /*
> @@ -487,15 +487,13 @@ static int k1_i2c_probe(struct udevice *bus)
>  		return ret;
>  	}
>  
> -	ret = clk_get_by_index(bus, 0, &priv->clk);
> +	ret = clk_get_bulk(bus, &priv->clks);
>  	if (ret)
>  		return ret;
>  
> -	ret = clk_enable(&priv->clk);
> -	if (ret && ret != -ENOSYS && ret != -EOPNOTSUPP) {
> -		debug("%s: failed to enable clock\n", __func__);
> +	ret = clk_enable_bulk(&priv->clks);
I'd suggest to not use bulk api, to align with k1 i2c kernel driver,
also to make it easy to set func frequency if needed (a weak reason)

> +	if (ret)
>  		return ret;
> -	}
>  
>  	priv->base = (void *)devfdt_get_addr_ptr(bus);
>  
> 
> -- 
> 2.55.0
> 

-- 
Yixun Lan (dlan)
