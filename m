Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F319CC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15BDB80D8C;
	Fri,  7 Aug 2026 16:10:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id usHPbe8LXbZa; Fri,  7 Aug 2026 16:10:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB5E981342
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119027;
	bh=LsAVVS7vrR9N2WAkEQhQeSpjkBpxv5PNzqyucibwtdA=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cGZva816Iwhk3qKzMJuWfeK+C0R/Xd54cpsyz+Svs7PehPX2UJx7eNSnyAZQLeXWg
	 jZXXQD6vrzTwrFOAOejmby+VKqb94crJbHRjvGVrmaLXfZJhU6zUvu3AAl4Y/GNKpd
	 Cj/qdqGzaO3EB2PNIsc3cE++VlrjgX+01FCtfQ4wA664fB28wb7AQu+NbLJQOXJsoe
	 gdOhF+ePxjyreHMrlzn9KBlgjl9bLfHdoavztZdvGuPSYY+mH1h3p/1nuTuwrTNBN8
	 SCpgwOb52O2vKeudQF2i9dg/IUDA6cVuWh1y5roKCyuZi5ryN1XcZubwPHM5U91awj
	 yCsEwtpGctPMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB5E981342;
	Fri,  7 Aug 2026 16:10:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EFF9D198
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:10:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D634C607E4
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UBY_X5xeXmEe for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:10:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.13;
 helo=smtp-bc0d.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BBAE960684
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBAE960684
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBAE960684
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:10:23 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hGpqY5xXsz8KB;
 Fri,  7 Aug 2026 18:04:09 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hGpqX1R9czTTj; Fri,  7 Aug 2026 18:04:08 +0200 (CEST)
Message-ID: <eb0f5e02-bf6d-44ce-abc7-e4af2febc156@0leil.net>
Date: Fri, 7 Aug 2026 18:04:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] clk: rockchip: rk3576: Fix trivial clock
 configuration errors
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-12-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260730141308.1218014-12-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786118649;
 bh=LsAVVS7vrR9N2WAkEQhQeSpjkBpxv5PNzqyucibwtdA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WHmmM+qf++yE8x3DN5R412XESUuAVW7v0pPSxUy77zVjO5LKJFMRsT6ZH4Gu105s7
 de4kCYLRcCso3OfF0wM41sbOTE2Hoh28Wg8hCHZYHdIpRG2GNlYD4x56nOJ+Wl7tq9
 FhYjIx7PtzwOnorjXZv4y69HA2OUilQDgQBHQ0yntHKULlkpyRj06qlv1JT00YEYs0
 8ZbZ7vtM41WceYXz/1Qey2FxmmS12ayUxMQA5YPuxwR+jvQDodT2nA9wqHFSGcm47Q
 P2iwanv43wWiQRHqkWmF89xazmX8DyWz17KW3o1bNIwqXmjnkf4/vh7JR6rMg8Na3z
 Gzc6rpguBCc7Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=WHmmM+qf
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/30/26 4:13 PM, Jonas Karlman wrote:
> The RK3576 clock driver has a few trivial copy-paste mistakes in its
> clock handling.
> 
> Fix the trivial clock configuration errors:
> - use correct VPLL mode reg
> - rename and use PHP_PLL_CON macro
> - set correct parent for ACLK_TOP clocks
> - avoid overriding the selected I2C parent clock
> - stop CLK_I2C8 from falling through into CLK_I2C9
> - use correct SARADC and TSADC clksel regs
> - use correct parent pll rate for UART clocks
> - align BPLL configuration to match other PLLs
> - remove unused BPLL_CON macro
> 

Please split those into separate commits. All changes are fine 
individually. See small remark below for a change I believe would help 
with reading the code more easily.

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   .../include/asm/arch-rockchip/cru_rk3576.h    |  5 ++--
>   drivers/clk/rockchip/clk_rk3576.c             | 23 +++++++++----------
>   2 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
> index fb77fbd7307a..41e225245843 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
> @@ -127,24 +127,23 @@ struct pll_rate_table {
>   #define RK3576_SDMMC_CON0		0xC30
>   #define RK3576_SDMMC_CON1		0xC34
>   
> +#define RK3576_PHP_PLL_CON(x)		((x) * 0x4 + RK3576_PHP_CRU_BASE)

Same remark as for the RK3588 patch, please add 0x200 so we can use 
RK3576_PHP_PLL_CON(0) when we want to interact with PHPTOPCRU_PPLL_CON0.

>   #define RK3576_PHP_CLKSEL_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0x300)
>   #define RK3576_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0x800)
>   #define RK3576_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0xa00)
>   
> -#define RK3576_PMU_PLL_CON(x)		((x) * 0x4 + RK3576_PHP_CRU_BASE)
>   #define RK3576_PMU_CLKSEL_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0x300)
>   #define RK3576_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0x800)
>   #define RK3576_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0xa00)
>   
> +#define RK3576_LPLL_CON(x)		((x) * 0x4 + RK3576_CCI_CRU_BASE)

Please add 0x40 so we can do RK3576_LPLL_CON(0) to interact with 
CCICRU_LPLL_CON0.

>   #define RK3576_CCI_CLKSEL_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0x300)
>   #define RK3576_CCI_CLKGATE_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0x800)
>   #define RK3576_CCI_SOFTRST_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0xa00)
>   
> -#define RK3576_BPLL_CON(x)		((x) * 0x4 + RK3576_BIGCORE_CRU_BASE)
>   #define RK3576_BIGCORE_CLKSEL_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0x300)
>   #define RK3576_BIGCORE_CLKGATE_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0x800)
>   #define RK3576_BIGCORE_SOFTRST_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0xa00)
> -#define RK3576_LPLL_CON(x)		((x) * 0x4 + RK3576_CCI_CRU_BASE)
>   #define RK3576_LITCORE_CLKSEL_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0x300)
>   #define RK3576_LITCORE_CLKGATE_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0x800)
>   #define RK3576_LITCORE_SOFTRST_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0xa00)
> diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
> index 92bde425b0ee..75b705ffba2f 100644
> --- a/drivers/clk/rockchip/clk_rk3576.c
> +++ b/drivers/clk/rockchip/clk_rk3576.c
> @@ -44,19 +44,18 @@ static struct rockchip_pll_rate_table rk3576_24m_pll_rates[] = {
>   
>   static struct rockchip_pll_clock rk3576_pll_clks[] = {
>   	[BPLL] = PLL(pll_rk3588, PLL_BPLL, RK3576_PLL_CON(0),
> -		      RK3576_BPLL_MODE_CON0, 0, 15, 0,
> -		      rk3576_24m_pll_rates),
> +		     RK3576_BPLL_MODE_CON0, 0, 15, 0, rk3576_24m_pll_rates),
>   	[LPLL] = PLL(pll_rk3588, PLL_LPLL, RK3576_LPLL_CON(16),
>   		     RK3576_LPLL_MODE_CON0, 0, 15, 0, rk3576_24m_pll_rates),
>   	[VPLL] = PLL(pll_rk3588, PLL_VPLL, RK3576_PLL_CON(88),
> -		      RK3576_LPLL_MODE_CON0, 4, 15, 0, rk3576_24m_pll_rates),
> +		     RK3576_MODE_CON0, 4, 15, 0, rk3576_24m_pll_rates),
>   	[AUPLL] = PLL(pll_rk3588, PLL_AUPLL, RK3576_PLL_CON(96),
>   		      RK3576_MODE_CON0, 6, 15, 0, rk3576_24m_pll_rates),
>   	[CPLL] = PLL(pll_rk3588, PLL_CPLL, RK3576_PLL_CON(104),
>   		     RK3576_MODE_CON0, 8, 15, 0, rk3576_24m_pll_rates),
>   	[GPLL] = PLL(pll_rk3588, PLL_GPLL, RK3576_PLL_CON(112),
>   		     RK3576_MODE_CON0, 2, 15, 0, rk3576_24m_pll_rates),
> -	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PMU_PLL_CON(128),
> +	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PHP_PLL_CON(128),
>   		     RK3576_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,

RK3576_MODE_CON0 is incorrect here, but since ROCKCHIP_PLL_FIXED_MODE is 
set, this won't be used as far as I could tell. I'm wondering whether we 
should have a new macros that wouldn't force us to define something 
necessarily incorrect. Something for later though.

Cheers,
Quentin
