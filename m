Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F13C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 16:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4CF487CD4;
	Thu,  1 Feb 2024 17:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CAD987CDB; Thu,  1 Feb 2024 17:36:43 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2AC6C87CA4
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 17:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AB03DA7;
 Thu,  1 Feb 2024 08:37:22 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 756293F738;
 Thu,  1 Feb 2024 08:36:38 -0800 (PST)
Date: Thu, 1 Feb 2024 16:36:36 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Ludwig Kormann <ludwig.kormann@ict42.de>
Cc: jagan@amarulasolutions.com, trini@konsulko.com,
 jernej.skrabec@gmail.com, iuncuim@gmail.com, cfsworks@gmail.com,
 samuel@sholland.org, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] sunxi: sun4i: Introduce KConfig option
 SPL_SYS_CLK_FREQ
Message-ID: <20240201163636.6536ead1@donnerap.manchester.arm.com>
In-Reply-To: <20240201133014.578083-1-ludwig.kormann@ict42.de>
References: <20240201133014.578083-1-ludwig.kormann@ict42.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Thu,  1 Feb 2024 14:30:14 +0100
Ludwig Kormann <ludwig.kormann@ict42.de> wrote:

Hi,

> This option can be used to modify the initial SPL
> CPU clock frequency.
> 
> This follows an earlier discussion regarding A20
> CPUs dying after reboot in SPL initialization due to
> incompatible CPU clock frequency and core voltage. [1]
> 
> First attempt was to update PLL1_CFG_DEFAULT to a fixed
> lower frequency (144MHz), which fixed the observed issue
> but might not suit all A20 users. A KConfig option
> should be the better solution.

Can you please reword this to include more vital information directly in
the commit message? We had mailing list archives vanish in the past.

Please mention that our default frequency of 384 MHz does not work at
every voltage, and after just a core reset the PMIC might still use a
previously programmed lower voltage, that will hang the SPL, on some
batches of chips.

> [1]
> https://lists.denx.de/pipermail/u-boot/2024-January/544897.html

Please use the Link: tag:

Link: https://lists.denx.de/....

> 
> Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>
> ---
>  arch/arm/include/asm/arch-sunxi/clock_sun4i.h |  4 ++++
>  arch/arm/mach-sunxi/Kconfig                   |  8 ++++++++
>  arch/arm/mach-sunxi/clock_sun4i.c             | 11 ++++++++++-
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
> index 2cec91cb20..11b350824e 100644
> --- a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
> @@ -134,12 +134,16 @@ struct sunxi_ccm_reg {
>  #define CCM_PLL1_CFG_PLL4_EXCH_SHIFT		25
>  #define CCM_PLL1_CFG_BIAS_CUR_SHIFT		20
>  #define CCM_PLL1_CFG_DIVP_SHIFT			16
> +#define CCM_PLL1_CFG_DIVP_MASK			(0x3 << CCM_PLL1_CFG_DIVP_SHIFT)
>  #define CCM_PLL1_CFG_LCK_TMR_SHIFT		13
>  #define CCM_PLL1_CFG_FACTOR_N_SHIFT		8
> +#define CCM_PLL1_CFG_FACTOR_N_MASK		(0x1f << CCM_PLL1_CFG_FACTOR_N_SHIFT)
>  #define CCM_PLL1_CFG_FACTOR_K_SHIFT		4
> +#define CCM_PLL1_CFG_FACTOR_K_MASK		(0x3 << CCM_PLL1_CFG_FACTOR_K_SHIFT)
>  #define CCM_PLL1_CFG_SIG_DELT_PAT_IN_SHIFT	3
>  #define CCM_PLL1_CFG_SIG_DELT_PAT_EN_SHIFT	2
>  #define CCM_PLL1_CFG_FACTOR_M_SHIFT		0
> +#define CCM_PLL1_CFG_FACTOR_M_MASK		(0x3 << CCM_PLL1_CFG_FACTOR_M_SHIFT)
>  
>  #define PLL1_CFG_DEFAULT	0xa1005000
>  
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index fe89aec6b9..85e3a26855 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -705,6 +705,14 @@ config SYS_CLK_FREQ
>  	default 1008000000 if MACH_SUN50I_H616
>  	default 1008000000 if MACH_SUN8I_R528
>  
> +if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I

As Tom already mentioned, please use "depends on".

> +config SPL_SYS_CLK_FREQ
> +	int "sunxi SPL CPU clock frequency"

"sunxi" is redundant here. Please state that this is the early SPL
frequency, since we switch to SYS_CLK_FREQ in the SPL still, only later.

> +	default 384
> +	---help---
> +  A static value for the sunxi SPL CPU frequency, must be a multiple of 24.

Minus sunxi, plus early, as above. Also please mention the safe frequency
(144 MHz) here, as a recommendation if people experience problems.

> +endif
> +
>  config SYS_CONFIG_NAME
>  	default "suniv" if MACH_SUNIV
>  	default "sun4i" if MACH_SUN4I
> diff --git a/arch/arm/mach-sunxi/clock_sun4i.c b/arch/arm/mach-sunxi/clock_sun4i.c
> index 8f1d1b65f0..04623c1d09 100644
> --- a/arch/arm/mach-sunxi/clock_sun4i.c
> +++ b/arch/arm/mach-sunxi/clock_sun4i.c
> @@ -25,7 +25,16 @@ void clock_init_safe(void)
>  	       APB0_DIV_1 << APB0_DIV_SHIFT |
>  	       CPU_CLK_SRC_OSC24M << CPU_CLK_SRC_SHIFT,
>  	       &ccm->cpu_ahb_apb0_cfg);
> -	writel(PLL1_CFG_DEFAULT, &ccm->pll1_cfg);
> +	writel((PLL1_CFG_DEFAULT &
> +		~(CCM_PLL1_CFG_FACTOR_N_MASK |
> +		CCM_PLL1_CFG_FACTOR_K_MASK |
> +		CCM_PLL1_CFG_FACTOR_M_MASK |
> +		CCM_PLL1_CFG_DIVP_MASK)) |
> +		(CONFIG_SPL_SYS_CLK_FREQ / 24) << CCM_PLL1_CFG_FACTOR_N_SHIFT |
> +		0 << CCM_PLL1_CFG_FACTOR_K_SHIFT |
> +		0 << CCM_PLL1_CFG_FACTOR_M_SHIFT |
> +		0 << CCM_PLL1_CFG_DIVP_SHIFT,
> +		&ccm->pll1_cfg);

There is already the PLL1_CFG macro later in that same file, can you reuse
that, maybe?

Otherwise this is indeed what I had in mind, thanks for providing the
patch!

Cheers,
Andre

>  	sdelay(200);
>  	writel(AXI_DIV_1 << AXI_DIV_SHIFT |
>  	       AHB_DIV_2 << AHB_DIV_SHIFT |

