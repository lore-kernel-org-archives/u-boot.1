Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0A9CE8D6B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 01:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D7AB83B99;
	Tue, 18 Nov 2025 02:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FFE283C16; Tue, 18 Nov 2025 02:05:38 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3062C83B91
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4175FEC;
 Mon, 17 Nov 2025 17:05:27 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E2633F66E;
 Mon, 17 Nov 2025 17:05:34 -0800 (PST)
Date: Tue, 18 Nov 2025 01:05:27 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Tom Rini
 <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Paul
 Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 05/11] clock: a733: implement support for mmc/uart
Message-ID: <20251118010527.5eaa302d@minigeek.lan>
In-Reply-To: <20251116-01-a733-soc-support-v1-5-fb4c8db78e75@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
 <20251116-01-a733-soc-support-v1-5-fb4c8db78e75@gentoo.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Sun, 16 Nov 2025 14:43:56 +0000
Yixun Lan <dlan@gentoo.org> wrote:

Hi,

> Add clock initialization support to set UART/I2C/MMC clock frequency.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> 
> ---
> In this version, we create a dedicated clock_sun60i_a733.h file, maybe
> we should further refactor the code to make it merged into exist
> clock_sun50i_h6.h file.
> ---
>  arch/arm/include/asm/arch-sunxi/clock.h            |   2 +
>  .../arm/include/asm/arch-sunxi/clock_sun60i_a733.h | 179 +++++++++++++++++++++
>  arch/arm/include/asm/arch-sunxi/cpu.h              |   2 +
>  arch/arm/mach-sunxi/Makefile                       |   1 +
>  arch/arm/mach-sunxi/clock_sun60i_a733.c            |  80 +++++++++
>  5 files changed, 264 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/clock.h b/arch/arm/include/asm/arch-sunxi/clock.h
> index fcc8966cb0b..105c3804102 100644
> --- a/arch/arm/include/asm/arch-sunxi/clock.h
> +++ b/arch/arm/include/asm/arch-sunxi/clock.h
> @@ -19,6 +19,8 @@
>  #include <asm/arch/clock_sun8i_a83t.h>
>  #elif defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
>  #include <asm/arch/clock_sun50i_h6.h>
> +#elif defined(CONFIG_MACH_SUN60I_A733)
> +#include <asm/arch/clock_sun60i_a733.h>
>  #elif defined(CONFIG_MACH_SUN6I) || defined(CONFIG_MACH_SUN8I) || \
>        defined(CONFIG_MACH_SUN50I) || defined(CONFIG_MACH_SUNIV)
>  #include <asm/arch/clock_sun6i.h>
> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun60i_a733.h b/arch/arm/include/asm/arch-sunxi/clock_sun60i_a733.h
> new file mode 100644
> index 00000000000..819a5c6cf8d
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun60i_a733.h

This new file looks like mostly a copy of clock_sun50i_h6.h. Can you
please merge both, and define differently just the very few register
offsets that actually differ? This includes clock_sun50i_h6.c and
clock_sun60i_a733.c.

Cheers,
Andre

> @@ -0,0 +1,179 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Allwinner A733 clock register definitions
> + */
> +
> +#ifndef _SUNXI_CLOCK_SUN60I_A733_H
> +#define _SUNXI_CLOCK_SUN60I_A733_H
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/bitops.h>
> +#endif
> +
> +/* Main CCU register offsets */
> +#define CCU_H6_PLL1_CFG			0x000
> +#define CCU_H6_PLL5_CFG			0x010
> +#define CCU_H6_PLL6_CFG			0x0a0 /* PLL_PERI0_CTRL_REG */
> +
> +#define CCU_H6_CPU_AXI_CFG		0x500
> +#define CCU_H6_PSI_AHB1_AHB2_CFG	0x510
> +#define CCU_H6_AHB3_CFG			0x51c
> +#define CCU_H6_APB1_CFG			0x520
> +#define CCU_H6_APB2_CFG			0x524
> +#define CCU_H6_MBUS_CFG			0x540
> +#define CCU_H6_DRAM_CLK_CFG		0x800
> +#define CCU_H6_DRAM_GATE_RESET		0x80c
> +#define CCU_MMC0_CLK_CFG		0x830
> +#define CCU_MMC1_CLK_CFG		0x834
> +#define CCU_MMC2_CLK_CFG		0x838
> +#define CCU_H6_MMC_GATE_RESET		0x84c
> +#define CCU_H6_UART_GATE_RESET		0x90c
> +#define CCU_H6_I2C_GATE_RESET		0x91c
> +
> +/* A523 CPU PLL offsets */
> +#define CPC_CPUA_PLL_CTRL		0x04
> +#define CPC_DSU_PLL_CTRL		0x08
> +#define CPC_CPUB_PLL_CTRL		0x0c
> +#define CPC_CPUA_CLK_REG		0x60
> +#define CPC_CPUB_CLK_REG		0x64
> +#define CPC_DSU_CLK_REG			0x6c
> +
> +/* A733 MISC offsets */
> +#define CCU_A733_APB0_CFG			0x510
> +#define CCU_A733_APB1_CFG			0x518
> +#define CCU_A733_APB_UART_CLK_CFG	0x538
> +#define CCU_A733_UART_GATE_RESET	0xe00
> +
> +/* PLL bit fields */
> +#define CCM_PLL_CTRL_EN			BIT(31)
> +#define CCM_PLL_LDO_EN			BIT(30)
> +#define CCM_PLL_LOCK_EN			BIT(29)
> +#define CCM_PLL_LOCK			BIT(28)
> +#define CCM_PLL_OUT_EN			BIT(27)
> +#define CCM_PLL1_UPDATE			BIT(26)
> +#define CCM_PLL1_CTRL_P(p)		((p) << 16)
> +#define CCM_PLL1_CTRL_N_MASK		GENMASK(15, 8)
> +#define CCM_PLL1_CTRL_N(n)		(((n) - 1) << 8)
> +
> +/* A523 CPU clock fields */
> +#define CPU_CLK_SRC_HOSC		(0 << 24)
> +#define CPU_CLK_SRC_CPUPLL		(3 << 24)
> +#define CPU_CLK_CTRL_P(p)		((p) << 16)
> +#define CPU_CLK_APB_DIV(n)		(((n) - 1) << 8)
> +#define CPU_CLK_PERI_DIV(m1)		(((m1) - 1) << 2)
> +#define CPU_CLK_AXI_DIV(m)		(((m) - 1) << 0)
> +
> +/* pll5 bit field */
> +#define CCM_PLL5_CTRL_N(n)		(((n) - 1) << 8)
> +#define CCM_PLL5_CTRL_DIV1(div1)	((div1) << 0)
> +#define CCM_PLL5_CTRL_DIV2(div0)	((div0) << 1)
> +
> +/* pll6 bit field */
> +#define CCM_PLL6_CTRL_P0_SHIFT		20
> +#define CCM_PLL6_CTRL_P0_MASK		(0x7 << CCM_PLL6_CTRL_P0_SHIFT)
> +#define CCM_PLL6_CTRL_N_SHIFT		8
> +#define CCM_PLL6_CTRL_N_MASK		(0xff << CCM_PLL6_CTRL_N_SHIFT)
> +#define CCM_PLL6_CTRL_DIV1_SHIFT	0
> +#define CCM_PLL6_CTRL_DIV1_MASK		(0x1 << CCM_PLL6_CTRL_DIV1_SHIFT)
> +#define CCM_PLL6_CTRL_DIV2_SHIFT	1
> +#define CCM_PLL6_CTRL_DIV2_MASK		(0x1 << CCM_PLL6_CTRL_DIV2_SHIFT)
> +
> +/* cpu_axi bit field*/
> +#define CCM_CPU_AXI_MUX_MASK		(0x3 << 24)
> +#define CCM_CPU_AXI_MUX_OSC24M		(0x0 << 24)
> +#define CCM_CPU_AXI_MUX_PLL_CPUX	(0x3 << 24)
> +#define CCM_CPU_AXI_APB_MASK		0x300
> +#define CCM_CPU_AXI_AXI_MASK		0x3
> +#define CCM_CPU_AXI_DEFAULT_FACTORS	0x301
> +
> +#ifdef CONFIG_MACH_SUN50I_H6				/* H6 */
> +
> +#define CCM_PLL6_DEFAULT		0xa0006300
> +#define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000102
> +#define CCM_AHB3_DEFAULT		0x03000002
> +#define CCM_APB1_DEFAULT		0x03000102
> +
> +#elif CONFIG_MACH_SUN50I_H616				/* H616 */
> +
> +#define CCM_PLL6_DEFAULT		0xa8003100
> +#define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002
> +#define CCM_AHB3_DEFAULT		0x03000002
> +#define CCM_APB1_DEFAULT		0x03000102
> +
> +#elif CONFIG_MACH_SUN8I_R528				/* R528 */
> +
> +#define CCM_PLL6_DEFAULT		0xe8216300
> +#define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002
> +#define CCM_APB1_DEFAULT		0x03000102
> +
> +#elif CONFIG_MACH_SUN55I_A523				/* A523 */
> +
> +#define CCM_PLL6_DEFAULT		0xe8116310	    /* 1200 MHz */
> +#define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002	    /* 200 MHz */
> +#define CCM_APB1_DEFAULT		0x03000005	    /* APB0 really */
> +#define CCM_APB2_DEFAULT		0x03000005	    /* APB1 really */
> +
> +#elif CONFIG_MACH_SUN60I_A733				/* A733 */
> +
> +#define CCM_PLL6_DEFAULT		0xe8116310	    /* 1200 MHz */
> +#define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002	    /* 200 MHz */
> +#define CCM_APB1_DEFAULT		0x03000005	    /* APB0 really */
> +#define CCM_APB2_DEFAULT		0x03000005	    /* APB1 really */
> +
> +#endif
> +
> +/* apb2 bit field */
> +#define APB2_CLK_SRC_OSC24M		(0x0 << 24)
> +#define APB2_CLK_SRC_OSC32K		(0x1 << 24)
> +#define APB2_CLK_SRC_PSI		(0x2 << 24)
> +#define APB2_CLK_SRC_PLL6		(0x3 << 24)
> +#define APB2_CLK_SRC_MASK		(0x3 << 24)
> +#define APB2_CLK_RATE_N_1		(0x0 << 8)
> +#define APB2_CLK_RATE_N_2		(0x1 << 8)
> +#define APB2_CLK_RATE_N_4		(0x2 << 8)
> +#define APB2_CLK_RATE_N_8		(0x3 << 8)
> +#define APB2_CLK_RATE_N_MASK		(3 << 8)
> +#define APB2_CLK_RATE_M(m)		(((m) - 1) << 0)
> +#define APB2_CLK_RATE_M_MASK            (3 << 0)
> +
> +/* MBUS clock bit field */
> +#define MBUS_ENABLE			BIT(31)
> +#define MBUS_RESET			BIT(30)
> +#define MBUS_UPDATE			BIT(27)
> +#define MBUS_CLK_SRC_MASK		GENMASK(25, 24)
> +#define MBUS_CLK_SRC_OSCM24		(0 << 24)
> +#define MBUS_CLK_SRC_PLL6X2		(1 << 24)
> +#define MBUS_CLK_SRC_PLL5		(2 << 24)
> +#define MBUS_CLK_SRC_PLL6X4		(3 << 24)
> +#define MBUS_CLK_M(m)			(((m) - 1) << 0)
> +
> +/* Module gate/reset shift*/
> +#define RESET_SHIFT			(16)
> +#define GATE_SHIFT			(0)
> +
> +/* DRAM clock bit field */
> +#define DRAM_CLK_ENABLE			BIT(31)
> +#define DRAM_MOD_RESET			BIT(30)
> +#define DRAM_CLK_UPDATE			BIT(27)
> +#define DRAM_CLK_SRC_MASK		GENMASK(25, 24)
> +#define DRAM_CLK_SRC_PLL5		(0 << 24)
> +#define DRAM_CLK_M_MASK			(0x1f)
> +#define DRAM_CLK_M(m)			(((m) - 1) << 0)
> +
> +/* MMC clock bit field */
> +#define CCM_MMC_CTRL_M(x)		((x) - 1)
> +#define CCM_MMC_CTRL_N(x)		((x) << 8)
> +#define CCM_MMC_CTRL_OSCM24		(0x0 << 24)
> +#define CCM_MMC_CTRL_PLL6		(0x1 << 24)
> +#define CCM_MMC_CTRL_PLL_PERIPH2X2	(0x2 << 24)
> +#define CCM_MMC_CTRL_ENABLE		(0x1 << 31)
> +/* H6 doesn't have these delays */
> +#define CCM_MMC_CTRL_OCLK_DLY(a)	((void)(a), 0)
> +#define CCM_MMC_CTRL_SCLK_DLY(a)	((void)(a), 0)
> +
> +#ifndef __ASSEMBLY__
> +void clock_set_pll1(unsigned int hz);
> +unsigned int clock_get_pll6(void);
> +#endif
> +
> +#endif /* _SUNXI_CLOCK_SUN60I_A733_H */
> diff --git a/arch/arm/include/asm/arch-sunxi/cpu.h b/arch/arm/include/asm/arch-sunxi/cpu.h
> index 768c6572d6b..3fd247e75a7 100644
> --- a/arch/arm/include/asm/arch-sunxi/cpu.h
> +++ b/arch/arm/include/asm/arch-sunxi/cpu.h
> @@ -12,6 +12,8 @@
>  #include <asm/arch/cpu_sun50i_h6.h>
>  #elif defined(CONFIG_SUNXI_GEN_NCAT2)
>  #include <asm/arch/cpu_sunxi_ncat2.h>
> +#elif defined(CONFIG_MACH_SUN60I_A733)
> +#include <asm/arch/cpu_sunxi_a733.h>
>  #else
>  #include <asm/arch/cpu_sun4i.h>
>  #endif
> diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
> index 9c79b55abf3..8e37e3315ca 100644
> --- a/arch/arm/mach-sunxi/Makefile
> +++ b/arch/arm/mach-sunxi/Makefile
> @@ -25,6 +25,7 @@ endif
>  obj-$(CONFIG_MACH_SUN9I)	+= clock_sun9i.o gtbus_sun9i.o
>  obj-$(CONFIG_SUN50I_GEN_H6)	+= clock_sun50i_h6.o
>  obj-$(CONFIG_SUNXI_GEN_NCAT2)	+= clock_sun50i_h6.o
> +obj-$(CONFIG_MACH_SUN60I_A733)	+= clock_sun60i_a733.o
>  ifndef CONFIG_ARM64
>  obj-y	+= timer.o
>  endif
> diff --git a/arch/arm/mach-sunxi/clock_sun60i_a733.c b/arch/arm/mach-sunxi/clock_sun60i_a733.c
> new file mode 100644
> index 00000000000..9e07ccefc32
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/clock_sun60i_a733.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <asm/io.h>
> +#include <asm/arch/cpu.h>
> +#include <asm/arch/clock.h>
> +#include <asm/arch/prcm.h>
> +#include <linux/delay.h>
> +
> +#ifndef SUNXI_CPU_PLL_CFG_BASE
> +#define SUNXI_CPU_PLL_CFG_BASE 0
> +#endif
> +
> +#ifdef CONFIG_XPL_BUILD
> +void clock_init_safe(void)
> +{
> +}
> +
> +void clock_init_uart(void)
> +{
> +	void *const ccm = (void *)SUNXI_CCM_BASE;
> +
> +	/* uart clock source is apb2 */
> +	writel(APB2_CLK_SRC_OSC24M |
> +	       APB2_CLK_RATE_N_1 |
> +	       APB2_CLK_RATE_M(1),
> +	       ccm + CCU_A733_APB1_CFG);
> +
> +	/* uart clock source */
> +	writel(APB2_CLK_SRC_OSC24M |
> +	       APB2_CLK_RATE_N_1 |
> +	       APB2_CLK_RATE_M(1),
> +	       ccm + CCU_A733_APB_UART_CLK_CFG);
> +
> +	/* open the clock for uart */
> +	setbits_le32(ccm + CCU_A733_UART_GATE_RESET,
> +		     1 << (CONFIG_CONS_INDEX - 1));
> +
> +	/* deassert uart reset */
> +	setbits_le32(ccm + CCU_A733_UART_GATE_RESET,
> +		     1 << (RESET_SHIFT + CONFIG_CONS_INDEX - 1));
> +}
> +
> +void clock_set_pll1(unsigned int clk)
> +{
> +	/* Do not support clocks < 288MHz as they need factor P */
> +	if (clk < 288000000)
> +		clk = 288000000;
> +
> +	clk /= 24000000;
> +}
> +
> +int clock_twi_onoff(int port, int state)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_XPL_BUILD */
> +
> +/* PLL_PERIPH0 clock, used by the MMC driver */
> +unsigned int clock_get_pll6(void)
> +{
> +	void *const ccm = (void *)SUNXI_CCM_BASE;
> +	u32 rval = readl(ccm + CCU_H6_PLL6_CFG);
> +	int n = ((rval & CCM_PLL6_CTRL_N_MASK) >> CCM_PLL6_CTRL_N_SHIFT) + 1;
> +	int div1, m;
> +
> +	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2) || IS_ENABLED(CONFIG_MACH_SUN60I_A733)) {
> +		div1 = ((rval & CCM_PLL6_CTRL_P0_MASK) >>
> +			CCM_PLL6_CTRL_P0_SHIFT) + 1;
> +		m = ((rval >> 1) & 1) + 1;
> +	} else {
> +		div1 = ((rval & CCM_PLL6_CTRL_DIV1_MASK) >>
> +			CCM_PLL6_CTRL_DIV1_SHIFT) + 1;
> +		if (IS_ENABLED(CONFIG_MACH_SUN50I_H6))
> +			m = 4;
> +		else
> +			m = 2;
> +	}
> +
> +	return 24000000U * n / m / div1;
> +}
> 

