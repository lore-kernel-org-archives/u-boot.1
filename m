Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1622EE82CAF
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 16:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87C6386BE2;
	Wed, 27 Sep 2023 18:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC5986BE1; Wed, 27 Sep 2023 18:31:11 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6588786D53
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 18:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCF091FB;
 Wed, 27 Sep 2023 09:31:46 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4E153F59C;
 Wed, 27 Sep 2023 09:31:07 -0700 (PDT)
Date: Wed, 27 Sep 2023 17:31:05 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Samuel
 Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Icenowy Zheng <uwu@icenowy.me>, Maksim Kiselev <bigunclemax@gmail.com>
Subject: Re: [PATCH v2 4/5] sunxi: psci: implement PSCI on R528
Message-ID: <20230927173105.217f79cc@donnerap.manchester.arm.com>
In-Reply-To: <20230816173420.83232-5-CFSworks@gmail.com>
References: <20230816173420.83232-1-CFSworks@gmail.com>
 <20230816173420.83232-5-CFSworks@gmail.com>
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

On Wed, 16 Aug 2023 10:34:19 -0700
Sam Edwards <cfsworks@gmail.com> wrote:

Hi Sam,

> This patch adds the necessary code to make nonsec booting and PSCI
> secondary core management functional on the R528/T113.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> Tested-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  arch/arm/cpu/armv7/sunxi/psci.c | 48 ++++++++++++++++++++++++++++++++-
>  arch/arm/mach-sunxi/Kconfig     |  2 ++
>  include/configs/sunxi-common.h  |  8 ++++++
>  3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
> index 6ecdd05250..b4ce4f6def 100644
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
> @@ -103,10 +116,13 @@ static void __secure clamp_set(u32 *clamp)
>  
>  static void __secure sunxi_cpu_set_entry(int __always_unused cpu, void *entry)
>  {
> -	/* secondary core entry address is programmed differently on R40 */
> +	/* secondary core entry address is programmed differently on R40/528 */

I think that's somewhat obvious now from the code, so you can remove this
comment.

>  	if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
>  		writel((u32)entry,
>  		       SUNXI_SRAMC_BASE + SUN8I_R40_SRAMC_SOFT_ENTRY_REG0);
> +	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
> +		writel((u32)entry,
> +		       SUNXI_R_CPUCFG_BASE + SUN8I_R528_SOFT_ENTRY);
>  	} else {
>  		writel((u32)entry, SUNXI_CPUCFG_BASE + SUNXI_PRIV0);
>  	}
> @@ -124,6 +140,9 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
>  	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
>  		clamp = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWR_CLAMP(cpu);
>  		pwroff = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWROFF;
> +	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
> +		/* R528 leaves both cores powered up, manages them via reset */
> +		return;
>  	} else {
>  		if (IS_ENABLED(CONFIG_MACH_SUN6I) ||
>  		    IS_ENABLED(CONFIG_MACH_SUN8I_H3))
> @@ -151,11 +170,27 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
>  
>  static void __secure sunxi_cpu_set_reset(int cpu, bool reset)
>  {
> +	if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
> +		if (reset) {

I think you can lose the brackets here, since it's a single statement
branch, even if it spans multiple lines. The indentation should make this
clear.

> +			clrbits_le32(SUNXI_CPUCFG_BASE + SUN8I_R528_C0_RST_CTRL,
> +				     BIT(cpu));
> +		} else {
> +			setbits_le32(SUNXI_CPUCFG_BASE + SUN8I_R528_C0_RST_CTRL,
> +				     BIT(cpu));
> +		}
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
> @@ -164,11 +199,22 @@ static void __secure sunxi_cpu_set_locking(int cpu, bool lock)
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
> index 0a3454a51a..d46fd8c0bc 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -355,6 +355,8 @@ config MACH_SUN8I_R40
>  config MACH_SUN8I_R528
>  	bool "sun8i (Allwinner R528)"
>  	select CPU_V7A
> +	select CPU_V7_HAS_NONSEC
> +	select ARCH_SUPPORT_PSCI

Please add
	select CPU_V7_HAS_VIRT
here, as the cores are perfectly capable of virtualisation. Granted,
support for KVM is long gone from Linux, but at least Xen still supports it.
And I believe you also need:
	select SPL_ARMV7_SET_CORTEX_SMPEN
At least this is what the other cores do. The PSCI code sets this bit for
the secondaries, but for the primary core we need to set it as early as
possible. Probably not a biggie on an A7, in reality, but good to have,
and be it for correctness and consistency's sake.

>  	select SUNXI_GEN_NCAT2
>  	select SUNXI_NEW_PINCTRL
>  	select MMC_SUNXI_HAS_NEW_MODE
> diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-common.h
> index b8ca77d031..67eb0d25db 100644
> --- a/include/configs/sunxi-common.h
> +++ b/include/configs/sunxi-common.h
> @@ -33,6 +33,14 @@
>  
>  /* CPU */
>  
> +/*
> + * Newer ARM SoCs have moved the GIC, but have not updated their ARM cores to
> + * reflect the correct address in CBAR/PERIPHBASE.
> + */
> +#if defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
> +#define CFG_ARM_GIC_BASE_ADDRESS	0x03020000
> +#endif

I feel this should go into Kconfig. I can make a patch, unless you want to
beat me to it.

Cheers,
Andre

> +
>  /*
>   * The DRAM Base differs between some models. We cannot use macros for the
>   * CONFIG_FOO defines which contain the DRAM base address since they end

