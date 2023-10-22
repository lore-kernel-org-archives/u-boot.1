Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB85C001E0
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 00:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB5DA87024;
	Sun, 22 Oct 2023 02:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3C4087675; Sun, 22 Oct 2023 02:50:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3DDB385C98
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 02:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98CF2C15;
 Sat, 21 Oct 2023 17:51:34 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B9EE3F64C;
 Sat, 21 Oct 2023 17:50:52 -0700 (PDT)
Date: Sun, 22 Oct 2023 01:49:49 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Samuel
 Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Icenowy Zheng <uwu@icenowy.me>, Maksim Kiselev <bigunclemax@gmail.com>,
 Kevin Amadiva <kevin.amadiva@mec.at>
Subject: Re: [PATCH v4 4/4] sunxi: psci: implement PSCI on R528
Message-ID: <20231022014949.58fa1bc0@slackpad.lan>
In-Reply-To: <20231012014756.2573473-5-CFSworks@gmail.com>
References: <20231012014756.2573473-1-CFSworks@gmail.com>
 <20231012014756.2573473-5-CFSworks@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Wed, 11 Oct 2023 19:47:56 -0600
Sam Edwards <cfsworks@gmail.com> wrote:

> This patch adds the necessary code to make nonsec booting and PSCI
> secondary core management functional on the R528/T113.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> Tested-by: Maksim Kiselev <bigunclemax@gmail.com>
> Tested-by: Kevin Amadiva <kevin.amadiva@mec.at>

Thanks, that looks good now. It's debatable whether the Kconfig depends
on should be NCAT2 instead, but we can fix this when the need arises.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm/cpu/armv7/Kconfig      |  3 ++-
>  arch/arm/cpu/armv7/sunxi/psci.c | 47 ++++++++++++++++++++++++++++++++-
>  arch/arm/mach-sunxi/Kconfig     |  4 +++
>  3 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv7/Kconfig b/arch/arm/cpu/armv7/Kconfig
> index f015d133cb..4eb34b7b44 100644
> --- a/arch/arm/cpu/armv7/Kconfig
> +++ b/arch/arm/cpu/armv7/Kconfig
> @@ -61,8 +61,9 @@ config ARMV7_SECURE_MAX_SIZE
>  config ARM_GIC_BASE_ADDRESS
>  	hex
>  	depends on ARMV7_NONSEC
> -	depends on ARCH_EXYNOS5
> +	depends on ARCH_EXYNOS5 || MACH_SUN8I_R528
>  	default 0x10480000 if ARCH_EXYNOS5
> +	default 0x03020000 if MACH_SUN8I_R528
>  	help
>  	  Override the GIC base address if the Arm Cortex defined
>  	  CBAR/PERIPHBASE system register holds the wrong value.
> diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
> index 207aa6bc4b..b03a865483 100644
> --- a/arch/arm/cpu/armv7/sunxi/psci.c
> +++ b/arch/arm/cpu/armv7/sunxi/psci.c
> @@ -47,6 +47,19 @@
>  #define SUN8I_R40_PWR_CLAMP(cpu)		(0x120 + (cpu) * 0x4)
>  #define SUN8I_R40_SRAMC_SOFT_ENTRY_REG0		(0xbc)
>  
> +/*
> + * R528 is also different, as it has both cores powered up (but held in reset
> + * state) after the SoC is reset. Like the R40, it uses a "soft" entry point
> + * address register, but unlike the R40, it uses a newer "CPUX" block to manage
> + * CPU state, rather than the older CPUCFG system.
> + */
> +#define SUN8I_R528_SOFT_ENTRY			(0x1c8)
> +#define SUN8I_R528_C0_RST_CTRL			(0x0000)
> +#define SUN8I_R528_C0_CTRL_REG0			(0x0010)
> +#define SUN8I_R528_C0_CPU_STATUS		(0x0080)
> +
> +#define SUN8I_R528_C0_STATUS_STANDBYWFI		(16)
> +
>  static void __secure cp15_write_cntp_tval(u32 tval)
>  {
>  	asm volatile ("mcr p15, 0, %0, c14, c2, 0" : : "r" (tval));
> @@ -103,10 +116,12 @@ static void __secure clamp_set(u32 *clamp)
>  
>  static void __secure sunxi_cpu_set_entry(int __always_unused cpu, void *entry)
>  {
> -	/* secondary core entry address is programmed differently on R40 */
>  	if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
>  		writel((u32)entry,
>  		       SUNXI_SRAMC_BASE + SUN8I_R40_SRAMC_SOFT_ENTRY_REG0);
> +	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
> +		writel((u32)entry,
> +		       SUNXI_R_CPUCFG_BASE + SUN8I_R528_SOFT_ENTRY);
>  	} else {
>  		writel((u32)entry, SUNXI_CPUCFG_BASE + SUNXI_PRIV0);
>  	}
> @@ -125,6 +140,9 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
>  	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
>  		clamp = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWR_CLAMP(cpu);
>  		pwroff = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWROFF;
> +	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
> +		/* R528 leaves both cores powered up, manages them via reset */
> +		return;
>  	} else {
>  		if (IS_ENABLED(CONFIG_MACH_SUN6I) ||
>  		    IS_ENABLED(CONFIG_MACH_SUN8I_H3))
> @@ -152,11 +170,27 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
>  
>  static void __secure sunxi_cpu_set_reset(int cpu, bool reset)
>  {
> +	if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
> +		if (reset)
> +			clrbits_le32(SUNXI_CPUCFG_BASE + SUN8I_R528_C0_RST_CTRL,
> +				     BIT(cpu));
> +		else
> +			setbits_le32(SUNXI_CPUCFG_BASE + SUN8I_R528_C0_RST_CTRL,
> +				     BIT(cpu));
> +
> +		return;
> +	}
> +
>  	writel(reset ? 0b00 : 0b11, SUNXI_CPUCFG_BASE + SUNXI_CPU_RST(cpu));
>  }
>  
>  static void __secure sunxi_cpu_set_locking(int cpu, bool lock)
>  {
> +	if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
> +		/* Not required on R528 */
> +		return;
> +	}
> +
>  	if (lock)
>  		clrbits_le32(SUNXI_CPUCFG_BASE + SUNXI_DBG_CTRL1, BIT(cpu));
>  	else
> @@ -165,11 +199,22 @@ static void __secure sunxi_cpu_set_locking(int cpu, bool lock)
>  
>  static bool __secure sunxi_cpu_poll_wfi(int cpu)
>  {
> +	if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
> +		return !!(readl(SUNXI_CPUCFG_BASE + SUN8I_R528_C0_CPU_STATUS) &
> +			  BIT(SUN8I_R528_C0_STATUS_STANDBYWFI + cpu));
> +	}
> +
>  	return !!(readl(SUNXI_CPUCFG_BASE + SUNXI_CPU_STATUS(cpu)) & BIT(2));
>  }
>  
>  static void __secure sunxi_cpu_invalidate_cache(int cpu)
>  {
> +	if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
> +		clrbits_le32(SUNXI_CPUCFG_BASE + SUN8I_R528_C0_CTRL_REG0,
> +			     BIT(cpu));
> +		return;
> +	}
> +
>  	clrbits_le32(SUNXI_CPUCFG_BASE + SUNXI_GEN_CTRL, BIT(cpu));
>  }
>  
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index e891e291f1..23b5b27b97 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -355,6 +355,10 @@ config MACH_SUN8I_R40
>  config MACH_SUN8I_R528
>  	bool "sun8i (Allwinner R528)"
>  	select CPU_V7A
> +	select CPU_V7_HAS_NONSEC
> +	select CPU_V7_HAS_VIRT
> +	select ARCH_SUPPORT_PSCI
> +	select SPL_ARMV7_SET_CORTEX_SMPEN
>  	select SUNXI_GEN_NCAT2
>  	select SUNXI_NEW_PINCTRL
>  	select MMC_SUNXI_HAS_NEW_MODE

