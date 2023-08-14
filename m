Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36015C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 16:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47BB186679;
	Mon, 14 Aug 2023 18:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A49F866DC; Mon, 14 Aug 2023 18:37:21 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 399D686637
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 18:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CA2A1063;
 Mon, 14 Aug 2023 09:38:00 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40F4E3F762;
 Mon, 14 Aug 2023 09:37:17 -0700 (PDT)
Date: Mon, 14 Aug 2023 17:37:14 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Samuel
 Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Icenowy Zheng <uwu@icenowy.me>, Maksim Kiselev <bigunclemax@gmail.com>
Subject: Re: [PATCH 1/3] sunxi: psci: clean away preprocessor macros
Message-ID: <20230814173714.61bd09a2@donnerap.manchester.arm.com>
In-Reply-To: <20230812003055.74527-2-CFSworks@gmail.com>
References: <20230812003055.74527-1-CFSworks@gmail.com>
 <20230812003055.74527-2-CFSworks@gmail.com>
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

On Fri, 11 Aug 2023 18:30:53 -0600
Sam Edwards <cfsworks@gmail.com> wrote:

Hi Sam,

many thanks for that cleanup, that's very much welcome!

I am still comparing the outcome for the different SoC families, and
testing this on the boards I have, but two things I stumbled upon already:

> This patch restructures psci.c to get away from the "many different
> function definitions switched by #ifdef" paradigm to the preferred style
> of having a single function definition with `if (IS_ENABLED(...))` to
> make the optimizer include only the appropriate function bodies instead.
> 
> There are no functional changes here.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm/cpu/armv7/sunxi/psci.c | 94 ++++++++++++++-------------------
>  1 file changed, 41 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
> index e1d3638b5c..7809b074f8 100644
> --- a/arch/arm/cpu/armv7/sunxi/psci.c
> +++ b/arch/arm/cpu/armv7/sunxi/psci.c
> @@ -76,28 +76,24 @@ static void __secure __mdelay(u32 ms)
>  	isb();
>  }
>  
> -static void __secure clamp_release(u32 __maybe_unused *clamp)
> +static void __secure clamp_release(u32 *clamp)
>  {
> -#if defined(CONFIG_MACH_SUN6I) || defined(CONFIG_MACH_SUN7I) || \
> -	defined(CONFIG_MACH_SUN8I_H3) || \
> -	defined(CONFIG_MACH_SUN8I_R40)
> -	u32 tmp = 0x1ff;
> -	do {
> -		tmp >>= 1;
> -		writel(tmp, clamp);
> -	} while (tmp);
> -
> -	__mdelay(10);
> -#endif
> +	if (clamp) {
> +		u32 tmp = 0x1ff;
> +		do {
> +			tmp >>= 1;
> +			writel(tmp, clamp);
> +		} while (tmp);
> +
> +		__mdelay(10);
> +	}
>  }
>  
> -static void __secure clamp_set(u32 __maybe_unused *clamp)
> +static void __secure clamp_set(u32 *clamp)
>  {
> -#if defined(CONFIG_MACH_SUN6I) || defined(CONFIG_MACH_SUN7I) || \
> -	defined(CONFIG_MACH_SUN8I_H3) || \
> -	defined(CONFIG_MACH_SUN8I_R40)
> -	writel(0xff, clamp);
> -#endif
> +	if (clamp) {
> +		writel(0xff, clamp);
> +	}
>  }
>  
>  static void __secure sunxi_power_switch(u32 *clamp, u32 *pwroff, bool on,
> @@ -118,53 +114,45 @@ static void __secure sunxi_power_switch(u32 *clamp, u32 *pwroff, bool on,
>  	}
>  }
>  
> -#ifdef CONFIG_MACH_SUN8I_R40
> -/* secondary core entry address is programmed differently on R40 */
>  static void __secure sunxi_set_entry_address(void *entry)
>  {
> -	writel((u32)entry,
> -	       SUNXI_SRAMC_BASE + SUN8I_R40_SRAMC_SOFT_ENTRY_REG0);
> -}
> -#else
> -static void __secure sunxi_set_entry_address(void *entry)
> -{
> -	struct sunxi_cpucfg_reg *cpucfg =
> -		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
> +	/* secondary core entry address is programmed differently on R40 */
> +	if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
> +		writel((u32)entry,
> +		       SUNXI_SRAMC_BASE + SUN8I_R40_SRAMC_SOFT_ENTRY_REG0);
> +	} else {
> +		struct sunxi_cpucfg_reg *cpucfg =
> +			(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
>  
> -	writel((u32)entry, &cpucfg->priv0);
> +		writel((u32)entry, &cpucfg->priv0);
> +	}
>  }
> -#endif
>  
> -#ifdef CONFIG_MACH_SUN7I
> -/* sun7i (A20) is different from other single cluster SoCs */
> -static void __secure sunxi_cpu_set_power(int __always_unused cpu, bool on)
> -{
> -	struct sunxi_cpucfg_reg *cpucfg =
> -		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
> -
> -	sunxi_power_switch(&cpucfg->cpu1_pwr_clamp, &cpucfg->cpu1_pwroff,
> -			   on, 0);
> -}
> -#elif defined CONFIG_MACH_SUN8I_R40
>  static void __secure sunxi_cpu_set_power(int cpu, bool on)
>  {
>  	struct sunxi_cpucfg_reg *cpucfg =
>  		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
>  
> -	sunxi_power_switch((void *)cpucfg + SUN8I_R40_PWR_CLAMP(cpu),
> -			   (void *)cpucfg + SUN8I_R40_PWROFF,
> -			   on, cpu);
> -}
> -#else /* ! CONFIG_MACH_SUN7I && ! CONFIG_MACH_SUN8I_R40 */
> -static void __secure sunxi_cpu_set_power(int cpu, bool on)
> -{
> -	struct sunxi_prcm_reg *prcm =
> -		(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
> +	/* sun7i (A20) is different from other single cluster SoCs */
> +	if (IS_ENABLED(CONFIG_MACH_SUN7I)) {
> +		sunxi_power_switch(NULL, &cpucfg->cpu1_pwroff, on, 0);
> +	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
> +		sunxi_power_switch(NULL, (void *)cpucfg + SUN8I_R40_PWROFF,
> +				   on, cpu);
> +	} else {
> +#if !defined(CONFIG_SUN50I_GEN_H6) && !defined(CONFIG_SUNXI_GEN_NCAT2)

So I think we can get rid of this:
- GEN_H6 never compiles this code here, as both H6 and H616 are arm64.
- We can define SUNXI_PRCM_BASE for NCAT2, I believe Samuel once
mentioned that the D1/T113 does have such a block, actually.
- The non-existing cpu_pwr_clamp member should go away when you switch to
a BASE_ADDR + REG_OFFSET approach, I think.

> +		struct sunxi_prcm_reg *prcm =
> +			(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
>  
> -	sunxi_power_switch(&prcm->cpu_pwr_clamp[cpu], &prcm->cpu_pwroff,
> -			   on, cpu);
> +		u32 *clamp = &prcm->cpu_pwr_clamp[cpu];
> +		if (IS_ENABLED(CONFIG_MACH_SUN6I) ||
> +		    IS_ENABLED(CONFIG_MACH_SUN8I_H3))

Shouldn't that be the opposite? In the existing code, sun6i and H3 DO
program the clamp (see the "-" section above).

Cheers,
Andre

> +			clamp = NULL;
> +
> +		sunxi_power_switch(clamp, &prcm->cpu_pwroff, on, cpu);
> +#endif
> +	}
>  }
> -#endif /* CONFIG_MACH_SUN7I */
>  
>  void __secure sunxi_cpu_power_off(u32 cpuid)
>  {

