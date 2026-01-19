Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDCCD29C2D
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 14:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A69FF8389A;
	Mon, 19 Jan 2026 15:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF3D48397A; Mon, 19 Jan 2026 15:10:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 71380802C1
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 15:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 104AE497;
 Mon, 19 Jan 2026 06:10:21 -0800 (PST)
Received: from orionap.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED4383F632;
 Mon, 19 Jan 2026 06:10:23 -0800 (PST)
Date: Mon, 19 Jan 2026 14:10:20 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Andrey Skvortsov
 <andrej.skvortzov@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Dinesh Maniyam
 <dinesh.maniyam@intel.com>, Anand Gore <anand.gore@broadcom.com>, Linus
 Walleij <linus.walleij@linaro.org>, david regan <dregan@broadcom.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 05/24] mtd: rawnand: sunxi: remove usage of struct
 sunxi_ccm_reg
Message-ID: <20260119141020.729d70b0@orionap.fritz.box>
In-Reply-To: <20251028091256.600992-6-richard.genoud@bootlin.com>
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
 <20251028091256.600992-6-richard.genoud@bootlin.com>
Organization: ARM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 28 Oct 2025 10:12:26 +0100
Richard Genoud <richard.genoud@bootlin.com> wrote:

Hi Richard,

many thanks for doing this change.

> The sunxi_ccm_reg is legacy, drop its usage from nand related code
> 
> For that, CCU_NAND0_CLK_CFG and CCU_AHB_GATE1 are added to the clock
> files when missing.
> And clock code in sunxi_nand{,_spl}.c and board.c are changed to use the
> new scheme.
> 
> Moreover, drop AHB_DIV_1 in favor of the more readable CCM_NAND_CTRL_M/N
> 
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  arch/arm/include/asm/arch-sunxi/clock_sun4i.h      |  1 +
>  arch/arm/include/asm/arch-sunxi/clock_sun6i.h      |  1 +
>  arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h |  1 +
>  arch/arm/include/asm/arch-sunxi/clock_sun9i.h      |  2 ++
>  board/sunxi/board.c                                | 11 ++++++-----
>  drivers/mtd/nand/raw/sunxi_nand.c                  | 11 +++++------
>  drivers/mtd/nand/raw/sunxi_nand_spl.c              | 13 +++++++------
>  7 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
> index 00bdd5f938df..caa4b62b3e2d 100644
> --- a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
> @@ -11,6 +11,7 @@
>  #define _SUNXI_CLOCK_SUN4I_H
>  
>  #define CCU_AHB_GATE0		0x60
> +#define CCU_NAND0_CLK_CFG	0x80
>  #define CCU_MMC0_CLK_CFG	0x88
>  #define CCU_MMC1_CLK_CFG	0x8c
>  #define CCU_MMC2_CLK_CFG	0x90
> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun6i.h b/arch/arm/include/asm/arch-sunxi/clock_sun6i.h
> index 28c3faccbbcf..bdb08a32d01b 100644
> --- a/arch/arm/include/asm/arch-sunxi/clock_sun6i.h
> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun6i.h
> @@ -11,6 +11,7 @@
>  #define _SUNXI_CLOCK_SUN6I_H
>  
>  #define CCU_AHB_GATE0		0x060
> +#define CCU_NAND0_CLK_CFG	0x80

Just a nit, but can you please change this to 0x080, to align with the
other numbers?

>  #define CCU_MMC0_CLK_CFG	0x088
>  #define CCU_MMC1_CLK_CFG	0x08c
>  #define CCU_MMC2_CLK_CFG	0x090
> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h b/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h
> index 5ad2163926ad..70cd0ca00d21 100644
> --- a/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h
> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h
> @@ -14,6 +14,7 @@
>  #define _SUNXI_CLOCK_SUN8I_A83T_H
>  
>  #define CCU_AHB_GATE0		0x060
> +#define CCU_NAND0_CLK_CFG	0x80

Same here.

>  #define CCU_MMC0_CLK_CFG	0x088
>  #define CCU_MMC1_CLK_CFG	0x08c
>  #define CCU_MMC2_CLK_CFG	0x090
> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun9i.h b/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
> index 8d696e533f8f..3448f3fb3225 100644
> --- a/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
> @@ -12,11 +12,13 @@
>  #include <linux/bitops.h>
>  #endif
>  
> +#define CCU_NAND0_CLK_CFG	0x400
>  #define CCU_MMC0_CLK_CFG	0x410
>  #define CCU_MMC1_CLK_CFG	0x414
>  #define CCU_MMC2_CLK_CFG	0x418
>  #define CCU_MMC3_CLK_CFG	0x41c
>  #define CCU_AHB_GATE0		0x580
> +#define CCU_AHB_GATE1		0x584
>  #define CCU_AHB_RESET0_CFG	0x5a0

For the records, I checked the value of the offsets, they look correct.

>  struct sunxi_ccm_reg {
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 2929bc17f084..09b531b7f52a 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -307,15 +307,16 @@ static void nand_pinmux_setup(void)
>  
>  static void nand_clock_setup(void)
>  {
> -	struct sunxi_ccm_reg *const ccm =
> -		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
> +	void * const ccm = (void *)SUNXI_CCM_BASE;
>  
> -	setbits_le32(&ccm->ahb_gate0, (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
> +	setbits_le32(ccm + CCU_AHB_GATE0,
> +		     (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
>  #if defined CONFIG_MACH_SUN6I || defined CONFIG_MACH_SUN8I || \
>      defined CONFIG_MACH_SUN9I || defined CONFIG_MACH_SUN50I

So the usage of #define's for the offsets instead of struct members would
now allow for those preprocessor guards to be replaced by C statements:
	if (IS_ENABLED(CONFIG_MACH_SUN6I) || IS_ENABLED(CONFIG_MACH_SUN8I)
	...

> -	setbits_le32(&ccm->ahb_reset0_cfg, (1 << AHB_GATE_OFFSET_NAND0));
> +	setbits_le32(ccm + CCU_AHB_RESET0_CFG, (1 << AHB_GATE_OFFSET_NAND0));
>  #endif
> -	setbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE | AHB_DIV_1);
> +	setbits_le32(ccm + CCU_NAND0_CLK_CFG, CCM_NAND_CTRL_ENABLE |
> +		     CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));
>  }
>  
>  void board_nand_init(void)
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
> index c6b9b2a4ebac..ba2740ed1876 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -289,8 +289,7 @@ static inline struct sunxi_nfc *to_sunxi_nfc(struct nand_hw_control *ctrl)
>  
>  static void sunxi_nfc_set_clk_rate(unsigned long hz)
>  {
> -	struct sunxi_ccm_reg *const ccm =
> -	(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
> +	void * const ccm = (void *)SUNXI_CCM_BASE;
>  	int div_m, div_n;
>  
>  	div_m = (clock_get_pll6() + hz - 1) / hz;
> @@ -305,14 +304,14 @@ static void sunxi_nfc_set_clk_rate(unsigned long hz)
>  	/* config mod clock */
>  	writel(CCM_NAND_CTRL_ENABLE | CCM_NAND_CTRL_PLL6 |
>  	       CCM_NAND_CTRL_N(div_n) | CCM_NAND_CTRL_M(div_m),
> -	       &ccm->nand0_clk_cfg);
> +	       ccm + CCU_NAND0_CLK_CFG);
>  
>  	/* gate on nand clock */
> -	setbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_NAND0));
> +	setbits_le32(ccm + CCU_AHB_GATE0, (1 << AHB_GATE_OFFSET_NAND0));
>  #ifdef CONFIG_MACH_SUN9I

same here

> -	setbits_le32(&ccm->ahb_gate1, (1 << AHB_GATE_OFFSET_DMA));
> +	setbits_le32(ccm + CCU_AHB_GATE1, (1 << AHB_GATE_OFFSET_DMA));
>  #else
> -	setbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_DMA));
> +	setbits_le32(ccm + CCU_AHB_GATE0, (1 << AHB_GATE_OFFSET_DMA));
>  #endif
>  }
>  
> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> index e90450439e41..2fcf52658008 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> @@ -533,14 +533,15 @@ unsigned int nand_page_size(void)
>  
>  void nand_deselect(void)
>  {
> -	struct sunxi_ccm_reg *const ccm =
> -		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
> +	void * const ccm = (void *)SUNXI_CCM_BASE;
>  
> -	clrbits_le32(&ccm->ahb_gate0, (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
> +	clrbits_le32(ccm + CCU_AHB_GATE0,
> +		     (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
>  #ifdef CONFIG_MACH_SUN9I

and here.

But the actual changes look alright, including the usage of
CCM_NAND_CTRL_N() and CCM_NAND_CTRL_M().

Cheers,
Andre

> -	clrbits_le32(&ccm->ahb_gate1, (1 << AHB_GATE_OFFSET_DMA));
> +	clrbits_le32(ccm + CCU_AHB_GATE1, (1 << AHB_GATE_OFFSET_DMA));
>  #else
> -	clrbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_DMA));
> +	clrbits_le32(ccm + CCU_AHB_GATE0, (1 << AHB_GATE_OFFSET_DMA));
>  #endif
> -	clrbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE | AHB_DIV_1);
> +	clrbits_le32(ccm + CCU_NAND0_CLK_CFG, CCM_NAND_CTRL_ENABLE |
> +		     CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));
>  }

