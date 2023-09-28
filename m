Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9A3E80A8A
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 00:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D47A686DDB;
	Thu, 28 Sep 2023 02:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E901786DED; Thu, 28 Sep 2023 02:36:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 74C9F864EE
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 02:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93D011FB;
 Wed, 27 Sep 2023 17:37:26 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 308973F5A1;
 Wed, 27 Sep 2023 17:36:47 -0700 (PDT)
Date: Thu, 28 Sep 2023 01:35:44 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Samuel
 Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Icenowy Zheng <uwu@icenowy.me>, Maksim Kiselev <bigunclemax@gmail.com>
Subject: Re: [PATCH v2 4/5] sunxi: psci: implement PSCI on R528
Message-ID: <20230928013544.40be76a1@slackpad.lan>
In-Reply-To: <3e7c2548-9fe5-fe49-db24-c52900816fa7@gmail.com>
References: <20230816173420.83232-1-CFSworks@gmail.com>
 <20230816173420.83232-5-CFSworks@gmail.com>
 <20230927173105.217f79cc@donnerap.manchester.arm.com>
 <3e7c2548-9fe5-fe49-db24-c52900816fa7@gmail.com>
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

On Wed, 27 Sep 2023 18:01:40 -0600
Sam Edwards <cfsworks@gmail.com> wrote:

Hi Sam,

> On 9/27/23 10:31, Andre Przywara wrote:
> > On Wed, 16 Aug 2023 10:34:19 -0700
> > Sam Edwards <cfsworks@gmail.com> wrote:
> > 
> > Hi Sam,  
> 
> Hi Andre,
> 
> >> @@ -103,10 +116,13 @@ static void __secure clamp_set(u32 *clamp)
> >>   
> >>   static void __secure sunxi_cpu_set_entry(int __always_unused cpu, void *entry)
> >>   {
> >> -	/* secondary core entry address is programmed differently on R40 */
> >> +	/* secondary core entry address is programmed differently on R40/528 */  
> > 
> > I think that's somewhat obvious now from the code, so you can remove this
> > comment.  
> 
> Done, change will be included in v3.

Thanks!
 
> >>   	if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
> >>   		writel((u32)entry,
> >>   		       SUNXI_SRAMC_BASE + SUN8I_R40_SRAMC_SOFT_ENTRY_REG0);
> >> +	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
> >> +		writel((u32)entry,
> >> +		       SUNXI_R_CPUCFG_BASE + SUN8I_R528_SOFT_ENTRY);
> >>   	} else {
> >>   		writel((u32)entry, SUNXI_CPUCFG_BASE + SUNXI_PRIV0);
> >>   	}
> >> @@ -124,6 +140,9 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
> >>   	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
> >>   		clamp = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWR_CLAMP(cpu);
> >>   		pwroff = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWROFF;
> >> +	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
> >> +		/* R528 leaves both cores powered up, manages them via reset */
> >> +		return;
> >>   	} else {
> >>   		if (IS_ENABLED(CONFIG_MACH_SUN6I) ||
> >>   		    IS_ENABLED(CONFIG_MACH_SUN8I_H3))
> >> @@ -151,11 +170,27 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
> >>   
> >>   static void __secure sunxi_cpu_set_reset(int cpu, bool reset)
> >>   {
> >> +	if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
> >> +		if (reset) {  
> > 
> > I think you can lose the brackets here, since it's a single statement
> > branch, even if it spans multiple lines. The indentation should make this
> > clear.  
> 
> FWIW a lot of reviewers insist on braces surrounding *any* multiline 
> blocks, even if said block is only a single statement. This is to 
> prevent mishaps where another developer comes along later to add another 
> statement to the same block (at the same indentation level), but doesn't 
> think to look for missing brackets because the block is already bigger 
> than one line.
> 
> I could go either way on it, but would like to be sure that your 
> feedback stands in light of that counterpoint.

Yeah, I hear you, but my reflex is to look for that other statement if
I see curly braces. Seeing something without braces matches a pattern
of "just a single statement being different" for me.

And modern compilers actually warn about those indentation issues in
connection with if-statements or for-loops without braces.

But I leave this up to you, checkpatch doesn't seem to care here, so I
am fine either way.

> 
> >> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> >> index 0a3454a51a..d46fd8c0bc 100644
> >> --- a/arch/arm/mach-sunxi/Kconfig
> >> +++ b/arch/arm/mach-sunxi/Kconfig
> >> @@ -355,6 +355,8 @@ config MACH_SUN8I_R40
> >>   config MACH_SUN8I_R528
> >>   	bool "sun8i (Allwinner R528)"
> >>   	select CPU_V7A
> >> +	select CPU_V7_HAS_NONSEC
> >> +	select ARCH_SUPPORT_PSCI  
> > 
> > Please add
> > 	select CPU_V7_HAS_VIRT
> > here, as the cores are perfectly capable of virtualisation. Granted,
> > support for KVM is long gone from Linux, but at least Xen still supports it.  
> 
> Good catch; will be done in v3.
> 
> > And I believe you also need:
> > 	select SPL_ARMV7_SET_CORTEX_SMPEN
> > At least this is what the other cores do. The PSCI code sets this bit for
> > the secondaries, but for the primary core we need to set it as early as
> > possible. Probably not a biggie on an A7, in reality, but good to have,
> > and be it for correctness and consistency's sake.  
> 
> That's already enabled down below:
> # The sun8i SoCs share a lot, this helps to avoid a lot of "if A23 || A33"
> config MACH_SUN8I
>          bool
>          select SPL_ARMV7_SET_CORTEX_SMPEN if !ARM64

Ah, that's the big confusion about that Allwinner naming change:
https://linux-sunxi.org/Allwinner_SoC_Family#2013_naming_scheme_change

So if you look closely, this MACH_SUN8I is more related to that old SoC
generation, not to "anything with an Cortex-A7 in it". And consequently
the R528 support series does NOT enable this symbol, but uses the new
NCAT2 family symbol.
I was checking the generated .config, and didn't find it in there,
hence it needs to be set separately.

> >> diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-common.h
> >> index b8ca77d031..67eb0d25db 100644
> >> --- a/include/configs/sunxi-common.h
> >> +++ b/include/configs/sunxi-common.h
> >> @@ -33,6 +33,14 @@
> >>   
> >>   /* CPU */
> >>   
> >> +/*
> >> + * Newer ARM SoCs have moved the GIC, but have not updated their ARM cores to
> >> + * reflect the correct address in CBAR/PERIPHBASE.
> >> + */
> >> +#if defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
> >> +#define CFG_ARM_GIC_BASE_ADDRESS	0x03020000
> >> +#endif  
> > 
> > I feel this should go into Kconfig. I can make a patch, unless you want to
> > beat me to it.  
> 
> Note that you had previously [1] suggested placing this here, though 
> even then speculated that it belonged in Kconfig. I'm probably holding 
> off on sending a PSCI v3 until you send your R528 v2, so that might be a 
> good place to patch it. I'll remove this hunk if it's unnecessary by then.

Yeah, I remember saying that, just wanted to reiterate that because it
still is (bad!) "old school" U-Boot style, and we shouldn't add to the
mess.

I am doing the final checks on v2 tomorrow, if nothing pops up, that
should go out then. Just as a heads up ...

Cheers,
Andre

> [1]: 
> https://lore.kernel.org/u-boot/20230531161937.20d37f54@donnerap.cambridge.arm.com/
> 
> > Cheers,
> > Andre  
> 
> Likewise,
> Sam

