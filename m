Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7C6C83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 00:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11039832DD;
	Tue, 22 Jul 2025 02:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54F0A836F0; Tue, 22 Jul 2025 02:16:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3AF93832AD
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 02:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B87C81595;
 Mon, 21 Jul 2025 17:16:34 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61CCC3F66E;
 Mon, 21 Jul 2025 17:16:39 -0700 (PDT)
Date: Tue, 22 Jul 2025 01:14:39 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Mikhail Kalashnikov
 <iuncuim@gmail.com>, Yixun Lan <dlan@gentoo.org>, Paul Kocialkowski
 <paulk@sys-base.io>, linux-sunxi@lists.linux.dev, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 12/20] sunxi: sun50i_h6: add A523 SPL clock setup code
Message-ID: <20250722011439.401e1125@minigeek.lan>
In-Reply-To: <20250717235455.32528-13-andre.przywara@arm.com>
References: <20250717235455.32528-1-andre.przywara@arm.com>
 <20250717235455.32528-13-andre.przywara@arm.com>
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

On Fri, 18 Jul 2025 00:54:47 +0100
Andre Przywara <andre.przywara@arm.com> wrote:

> From: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> ---
>  .../include/asm/arch-sunxi/clock_sun50i_h6.h  | 10 ++++++
>  arch/arm/mach-sunxi/clock_sun50i_h6.c         | 32 ++++++++++++++-----
>  2 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
> index 5881ab88573..699d75f37c4 100644
> --- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
> @@ -108,6 +108,13 @@
>  #define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002
>  #define CCM_AHB3_DEFAULT		0x03000002
>  #define CCM_APB1_DEFAULT		0x03000102
> +
> +#elif CONFIG_MACH_SUN55I_A523				/* A523 */
> +
> +#define CCM_PLL6_DEFAULT		0xe8116310	    /* 1200 MHz */

This value is wrong, it must be 0xe8216310. Bits [22:20] program the 800
MHz sub-clock, divided down from the nominal 2.4GHz base frequency. So
the divider must be 3, encoded as 0b010. This is also the reset value.
Linux will calculate the actual frequency, but won't change the
setting, so it keeps and sees that clock as 1200 MHz, not 800 MHz. So
things might still work correctly, but I guess it's called
PLL_PERIPH0_800M for a reason, so let's keep it at this value.

Cheers,
Andre


> +#define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002	    /* 200 MHz */
> +#define CCM_APB1_DEFAULT		0x03000005	    /* APB0 really */
> +#define CCM_APB2_DEFAULT		0x03000005	    /* APB1 really */
>  #endif
>  
>  /* apb2 bit field */
> @@ -127,6 +134,7 @@
>  /* MBUS clock bit field */
>  #define MBUS_ENABLE			BIT(31)
>  #define MBUS_RESET			BIT(30)
> +#define MBUS_UPDATE			BIT(27)
>  #define MBUS_CLK_SRC_MASK		GENMASK(25, 24)
>  #define MBUS_CLK_SRC_OSCM24		(0 << 24)
>  #define MBUS_CLK_SRC_PLL6X2		(1 << 24)
> @@ -139,10 +147,12 @@
>  #define GATE_SHIFT			(0)
>  
>  /* DRAM clock bit field */
> +#define DRAM_CLK_ENABLE			BIT(31)
>  #define DRAM_MOD_RESET			BIT(30)
>  #define DRAM_CLK_UPDATE			BIT(27)
>  #define DRAM_CLK_SRC_MASK		GENMASK(25, 24)
>  #define DRAM_CLK_SRC_PLL5		(0 << 24)
> +#define DRAM_CLK_M_MASK			(0x1f)
>  #define DRAM_CLK_M(m)			(((m)-1) << 0)
>  
>  /* MMC clock bit field */
> diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
> index 3a4399a9c6c..80004f13a1e 100644
> --- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
> +++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
> @@ -16,15 +16,22 @@ void clock_init_safe(void)
>  	void *const ccm = (void *)SUNXI_CCM_BASE;
>  	void *const prcm = (void *)SUNXI_PRCM_BASE;
>  
> -	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616)) {
> -		/* this seems to enable PLLs on H616 */
> +	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616))
>  		setbits_le32(prcm + CCU_PRCM_SYS_PWROFF_GATING, 0x10);
> +	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
> +		setbits_le32(prcm + CCU_PRCM_SYS_PWROFF_GATING, 0x200);
> +	udelay(1);
> +
> +	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
> +	    IS_ENABLED(CONFIG_MACH_SUN55I_A523))
>  		setbits_le32(prcm + CCU_PRCM_RES_CAL_CTRL, 2);
> -	}
> +	udelay(1);
>  
>  	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
> -	    IS_ENABLED(CONFIG_MACH_SUN50I_H6)) {
> +	    IS_ENABLED(CONFIG_MACH_SUN50I_H6) ||
> +	    IS_ENABLED(CONFIG_MACH_SUN55I_A523)) {
>  		clrbits_le32(prcm + CCU_PRCM_RES_CAL_CTRL, 1);
> +		udelay(1);
>  		setbits_le32(prcm + CCU_PRCM_RES_CAL_CTRL, 1);
>  	}
>  
> @@ -41,9 +48,10 @@ void clock_init_safe(void)
>  	while (!(readl(ccm + CCU_H6_PLL6_CFG) & CCM_PLL_LOCK))
>  		;
>  
> -	clrsetbits_le32(ccm + CCU_H6_CPU_AXI_CFG,
> -			CCM_CPU_AXI_APB_MASK | CCM_CPU_AXI_AXI_MASK,
> -			CCM_CPU_AXI_DEFAULT_FACTORS);
> +	if (!IS_ENABLED(CONFIG_MACH_SUN55I_A523))
> +		clrsetbits_le32(ccm + CCU_H6_CPU_AXI_CFG,
> +				CCM_CPU_AXI_APB_MASK | CCM_CPU_AXI_AXI_MASK,
> +				CCM_CPU_AXI_DEFAULT_FACTORS);
>  
>  	writel(CCM_PSI_AHB1_AHB2_DEFAULT, ccm + CCU_H6_PSI_AHB1_AHB2_CFG);
>  #ifdef CCM_AHB3_DEFAULT
> @@ -55,7 +63,15 @@ void clock_init_safe(void)
>  	 * The mux and factor are set, but the clock will be enabled in
>  	 * DRAM initialization code.
>  	 */
> -	writel(MBUS_CLK_SRC_PLL6X2 | MBUS_CLK_M(3), ccm + CCU_H6_MBUS_CFG);
> +	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523)) {
> +		writel(MBUS_RESET, ccm + CCU_H6_MBUS_CFG);
> +		udelay(1);
> +		writel(MBUS_UPDATE | MBUS_CLK_SRC_OSCM24 | MBUS_CLK_M(4),
> +		       ccm + CCU_H6_MBUS_CFG);
> +	} else {
> +		writel(MBUS_CLK_SRC_PLL6X2 | MBUS_CLK_M(3),
> +		       ccm + CCU_H6_MBUS_CFG);
> +	}
>  }
>  
>  void clock_init_uart(void)

