Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA06AC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DE298883E;
	Wed, 22 May 2024 16:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 863C888840; Wed, 22 May 2024 16:18:53 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 913608883A
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i5e860cd9.versanet.de ([94.134.12.217] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1s9mnn-000174-6d; Wed, 22 May 2024 16:18:47 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: lukma@denx.de, seanga2@gmail.com, quentin.schulz@theobroma-systems.com,
 zhangqing@rock-chips.com, jonas@kwiboo.se, u-boot@lists.denx.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH RESEND] clk: rockchip: rk3588: Set SPLL frequency during
 SPL stage
Date: Wed, 22 May 2024 16:18:46 +0200
Message-ID: <9330720.rMLUfLXkoz@diego>
In-Reply-To: <f04e4d06-82ec-43ab-a077-592685fd7d56@cherry.de>
References: <20240522121559.1024535-1-heiko@sntech.de>
 <f04e4d06-82ec-43ab-a077-592685fd7d56@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Hi Quentin,

Am Mittwoch, 22. Mai 2024, 15:59:24 CEST schrieb Quentin Schulz:
> On 5/22/24 2:15 PM, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > 
> > All parts expect the SPLL to run at 702MHz. In U-Boot it's the SPLL_HZ
> > declaring this rate and in the kernel it's a fixed clock definition.
> > 
> > While everything is expecting 702MHz, the SPLL is not running that
> > frequency when coming from the bootrom though, instead it's running
> > at 351MHz and the vendor-u-boot just sets it to the expected frequency.
> > 
> > The SPLL itself is located inside the secure-BUSCRU and in theory
> > accessible as an SCMI clock, though this requires an unknown amount
> > of cooperation from trusted-firmware to set at a later stage, though
> > during the SPL stage we can still access the relevant CRU directly.
> > 
> > The SPLL is for example necessary for the DSI controllers to produce
> > output.
> > 
> > As the SPLL is "just" another rk3588 pll, just set the desired rate
> > directly during the SPL stage.
> > 
> > Tested on rk3588-rock5b and rk3588-tiger by reading back the PLL rate
> > and also observing working DSI output with this change.
> > 
> > Fixes: 6737771600d4 ("rockchip: rk3588: Add support for sdmmc clocks in SPL")
> > Suggested-by: Andy Yan <andy.yan@rock-chips.com>
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > Cc: Jonas Karlman <jonas@kwiboo.se>
> > ---
> > Resend, because I forgot the u-boot list
> > 
> >   .../include/asm/arch-rockchip/cru_rk3588.h    |  1 +
> >   drivers/clk/rockchip/clk_rk3588.c             | 26 ++++++++++++++++---
> >   2 files changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> > index a4507e5fdd7..85b4da0bc2c 100644
> > --- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> > +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> > @@ -29,6 +29,7 @@ enum rk3588_pll_id {
> >   	V0PLL,
> >   	AUPLL,
> >   	PPLL,
> > +	SPLL,
> >   	PLL_COUNT,
> >   };
> >   
> > diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> > index 4c611a39049..5384b3213f5 100644
> > --- a/drivers/clk/rockchip/clk_rk3588.c
> > +++ b/drivers/clk/rockchip/clk_rk3588.c
> > @@ -37,6 +37,7 @@ static struct rockchip_pll_rate_table rk3588_pll_rates[] = {
> >   	RK3588_PLL_RATE(786000000, 1, 131, 2, 0),
> >   	RK3588_PLL_RATE(742500000, 4, 495, 2, 0),
> >   	RK3588_PLL_RATE(722534400, 8, 963, 2, 24850),
> > +	RK3588_PLL_RATE(702000000, 3, 351, 2, 0),
> >   	RK3588_PLL_RATE(600000000, 2, 200, 2, 0),
> >   	RK3588_PLL_RATE(594000000, 2, 198, 2, 0),
> >   	RK3588_PLL_RATE(200000000, 3, 400, 4, 0),
> > @@ -65,6 +66,11 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
> >   		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
> >   	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
> >   		     RK3588_MODE_CON0, 10, 15, 0, rk3588_pll_rates),
> > +#ifdef CONFIG_SPL_BUILD
> > +	/* SBUSCRU MODE_CON has the same register offset as the main MODE_CON */
> > +	[SPLL] = PLL(pll_rk3588, 0, RK3588_PLL_CON(136),
> > +		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
> 
> FYI, it seems the rk3588 clock driver doesn't lock the PLL with the 
> lock_shift member, so 15 here is useless. Maybe we should switch 
> RK3588_PLLCON6_LOCK_STATUS to (1 << lock_shift) there for it to make 
> sense. Anyway, nothing specific to your patch.
> 
> RK3588_PLL_CON(136) is unreadable :/ Though I understand where it's 
> coming from as we have the same issue from V0PLL to PPLL. Can't we have 
> something a bit more proper here, e.g.
> 
> #define RK3588_SBUSCRU_SPLL_CON(x) ((x) * 4 + 0x220)
> 
> and then use RK3588_SBUSCRU_SPLL_CON(0) here?

sounds doable ;-)


> I'm also a bit wary of defining SPLL (and for that matter also V0PLL to 
> PPLL) with offsets relative to a different base than CRU (SBUSCRU for 
> SPLL for example) while all the others seem to have offsets relative to 
> CRU, c.f. RK3588_B0_PLL_CON(x). Specifically, it seems we are calling 
> rockchip_pll_set_rate with priv->cru which is the base of CRU. I am now
> not entirely sure anything from V0PLL to PPLL is actually working since 
> we use offsets relative to some xCRU but call the function with the 
> CRU_BASE.
> 
> So... wondering if we shouldn't have:
> 
> #define RK3588_SBUSCRU_BASE        0x18000
> #define RK3588_SBUSCRU_SPLL_CON(x) ((x) * 4 + 0x220 + RK3588_SBUSCRU_BASE)
> 
> and then in the probe of the scru driver, use CRU_BASE as the base, 
> otherwise we're doing some mixing and I don't like that too much. Or.... 

At least for the SPLL we're calling

ret = rockchip_pll_set_rate(&rk3588_pll_clks[SPLL],
                                   (void *)BUSSCRU_BASE, SPLL, SPLL_HZ);

so no mention of priv->cru there at all and the pll-function internally
only hand down that iomem pointer. The scru-clock driver also is
very specific to the SPL, as it the whole thing will be inaccessible
after TF-A has run.

Doing some janky maths on top of a different base definitly sounds
a lot worse than just having a comment above the PLL definition
stating that it belongs to the SBUSCRU ;-) .


> What about making this handled the same way as other clocks in SCRU, 
> without actually using the table? Or... Have another table just for SCRU 
> in SPL and migrate existing clocks to use rockchip_pll_set_rate with 
> that new table?

The rk3588-pll getter/setter relies on the pll id to do even more special-
case handling. See all the pll_id == x checks in clk-pll.c, hence the PLL-id
is sort of global over the whole set of PLLs

> 
> > +#endif
> >   };
> >   
> >   #ifndef CONFIG_SPL_BUILD
> > @@ -2044,6 +2050,7 @@ U_BOOT_DRIVER(rockchip_rk3588_cru) = {
> >   
> >   #ifdef CONFIG_SPL_BUILD
> >   #define SCRU_BASE			0xfd7d0000
> > +#define BUSSCRU_BASE			0xfd7d8000
> 
> Can you please rename to SBUSCRU_BASE to match the TRM?

ok


Heiko


