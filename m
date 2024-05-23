Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E73C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 03:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99AEC884EA;
	Thu, 23 May 2024 05:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AFEaQ0+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61D7B8851E; Thu, 23 May 2024 05:45:35 +0200 (CEST)
Received: from mail-m49249.qiye.163.com (mail-m49249.qiye.163.com
 [45.254.49.249])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EA8187FC7
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 05:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=AFEaQ0+qKk5OI4gzPg/1cM0+IzPhLG35O9UHsDwfOxGeS+5yUnteNwCj8CE2UrFBv7POUfvH8+aml1Ftjm2kjSQVi8kjNtTahUP9zQDk4tNNqoqndTxPV07tLSH+x1FCqMu6ESeLIdT0wtUEw1BIODUIk6J0BwWm5WlqCY1o0XI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=P8HEFp7H59XpsRQ5D/DBXebJbAlQFPnfj58JrZDpZqs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 20502900145;
 Thu, 23 May 2024 11:45:16 +0800 (CST)
Message-ID: <e447ad70-2615-4f57-ae8d-4089424851bb@rock-chips.com>
Date: Thu, 23 May 2024 11:45:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: rockchip: rk3588: Set SPLL frequency during SPL
 stage
To: Heiko Stuebner <heiko@sntech.de>, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: lukma@denx.de, seanga2@gmail.com, zhangqing@rock-chips.com,
 u-boot@lists.denx.de, Heiko Stuebner <heiko.stuebner@cherry.de>,
 Andy Yan <andy.yan@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20240522173129.1053395-1-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240522173129.1053395-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRhIHlZMTxhOTkhPTkoZQ0xVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fa38d98c103a9kunm20502900145
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBA6Mzo*PzNWSBw5PxcMETQs
 PxEaCh1VSlVKTEpNT0hOQkpMT09DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNTkNKNwY+
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


On 2024/5/23 01:31, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>
> All parts expect the SPLL to run at 702MHz. In U-Boot it's the SPLL_HZ
> declaring this rate and in the kernel it's a fixed clock definition.
>
> While everything is expecting 702MHz, the SPLL is not running that
> frequency when coming from the bootrom though, instead it's running
> at 351MHz and the vendor-u-boot just sets it to the expected frequency.
>
> The SPLL itself is located inside the secure-BUSCRU and in theory
> accessible as an SCMI clock, though this requires an unknown amount
> of cooperation from trusted-firmware to set at a later stage, though
> during the SPL stage we can still access the relevant CRU directly.
>
> The SPLL is for example necessary for the DSI controllers to produce
> output.
>
> As the SPLL is "just" another rk3588 pll, just set the desired rate
> directly during the SPL stage.
>
> Tested on rk3588-rock5b and rk3588-tiger by reading back the PLL rate
> and also observing working DSI output with this change.
>
> Fixes: 6737771600d4 ("rockchip: rk3588: Add support for sdmmc clocks in SPL")
> Suggested-by: Andy Yan <andy.yan@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> changes in v2:
> - use correct name for SBUSCRU
> - use dedicated constants for SBUSCRU registers
> - add comment to make it explicit that the SPLL is in a different CRU
>
>   .../include/asm/arch-rockchip/cru_rk3588.h    |  4 +++
>   drivers/clk/rockchip/clk_rk3588.c             | 30 +++++++++++++++++--
>   2 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> index a4507e5fdd7..a0e54d39654 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> @@ -29,6 +29,7 @@ enum rk3588_pll_id {
>   	V0PLL,
>   	AUPLL,
>   	PPLL,
> +	SPLL,
>   	PLL_COUNT,
>   };
>   
> @@ -150,6 +151,9 @@ struct pll_rate_table {
>   #define RK3588_DSU_CLKGATE_CON(x)	((x) * 0x4 + RK3588_DSU_CRU_BASE + 0x800)
>   #define RK3588_DSU_SOFTRST_CON(x)	((x) * 0x4 + RK3588_DSU_CRU_BASE + 0xa00)
>   
> +#define RK3588_SBUSCRU_SPLL_CON(x)	((x) * 0x4 + 0x220)
> +#define RK3588_SBUSCRU_MODE_CON0	0x280
> +
>   enum {
>   	/* CRU_CLK_SEL8_CON */
>   	ACLK_LOW_TOP_ROOT_SRC_SEL_SHIFT		= 14,
> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> index 4c611a39049..c41c9be6aa3 100644
> --- a/drivers/clk/rockchip/clk_rk3588.c
> +++ b/drivers/clk/rockchip/clk_rk3588.c
> @@ -37,6 +37,7 @@ static struct rockchip_pll_rate_table rk3588_pll_rates[] = {
>   	RK3588_PLL_RATE(786000000, 1, 131, 2, 0),
>   	RK3588_PLL_RATE(742500000, 4, 495, 2, 0),
>   	RK3588_PLL_RATE(722534400, 8, 963, 2, 24850),
> +	RK3588_PLL_RATE(702000000, 3, 351, 2, 0),
>   	RK3588_PLL_RATE(600000000, 2, 200, 2, 0),
>   	RK3588_PLL_RATE(594000000, 2, 198, 2, 0),
>   	RK3588_PLL_RATE(200000000, 3, 400, 4, 0),
> @@ -65,6 +66,15 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
>   		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
>   	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
>   		     RK3588_MODE_CON0, 10, 15, 0, rk3588_pll_rates),
> +#ifdef CONFIG_SPL_BUILD
> +	/*
> +	 * The SPLL is part of the SBUSCRU, not the main CRU and as
> +	 * such only directly accessible during the SPL stage.
> +	 */
> +	[SPLL] = PLL(pll_rk3588, 0, RK3588_SBUSCRU_SPLL_CON(0),
> +		     RK3588_SBUSCRU_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
> +#endif
> +
>   };
>   
>   #ifndef CONFIG_SPL_BUILD
> @@ -2044,6 +2054,7 @@ U_BOOT_DRIVER(rockchip_rk3588_cru) = {
>   
>   #ifdef CONFIG_SPL_BUILD
>   #define SCRU_BASE			0xfd7d0000
> +#define SBUSCRU_BASE			0xfd7d8000
>   
>   static ulong rk3588_scru_clk_get_rate(struct clk *clk)
>   {
> @@ -2118,15 +2129,28 @@ static ulong rk3588_scru_clk_set_rate(struct clk *clk, ulong rate)
>   	return rk3588_scru_clk_get_rate(clk);
>   }
>   
> +static int rk3588_scru_clk_probe(struct udevice *dev)
> +{
> +	int ret;
> +
> +	ret = rockchip_pll_set_rate(&rk3588_pll_clks[SPLL],
> +				    (void *)SBUSCRU_BASE, SPLL, SPLL_HZ);
> +	if (ret)
> +		debug("%s setting spll rate failed %d\n", __func__, ret);
> +
> +	return 0;
> +}
> +
>   static const struct clk_ops rk3588_scru_clk_ops = {
>   	.get_rate = rk3588_scru_clk_get_rate,
>   	.set_rate = rk3588_scru_clk_set_rate,
>   };
>   
>   U_BOOT_DRIVER(rockchip_rk3588_scru) = {
> -	.name = "rockchip_rk3588_scru",
> -	.id = UCLASS_CLK,
> -	.ops = &rk3588_scru_clk_ops,
> +	.name	= "rockchip_rk3588_scru",
> +	.id	= UCLASS_CLK,
> +	.ops	= &rk3588_scru_clk_ops,
> +	.probe	= rk3588_scru_clk_probe,
>   };
>   
>   static int rk3588_scmi_spl_glue_bind(struct udevice *dev)
