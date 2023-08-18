Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB485C7112F
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 14:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25AC586E72;
	Fri, 18 Aug 2023 16:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0337086E74; Fri, 18 Aug 2023 16:27:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0888286E6E
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 16:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCB2AD75;
 Fri, 18 Aug 2023 07:28:12 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 460F63F64C;
 Fri, 18 Aug 2023 07:27:31 -0700 (PDT)
Date: Fri, 18 Aug 2023 15:27:28 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Samuel
 Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Icenowy Zheng <uwu@icenowy.me>, Maksim Kiselev <bigunclemax@gmail.com>
Subject: Re: [PATCH 3/3] sunxi: psci: implement PSCI on R528
Message-ID: <20230818152728.49dd6e4f@donnerap.manchester.arm.com>
In-Reply-To: <1522f5e0-bdf6-cff6-3300-2bcbc3853457@gmail.com>
References: <20230812003055.74527-1-CFSworks@gmail.com>
 <20230812003055.74527-4-CFSworks@gmail.com>
 <20230814151642.6f47f6b5@donnerap.manchester.arm.com>
 <225be7f9-558e-4695-0b38-b30b0229cdcd@gmail.com>
 <20230815235946.0c8b0dce@slackpad.lan>
 <1522f5e0-bdf6-cff6-3300-2bcbc3853457@gmail.com>
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

On Tue, 15 Aug 2023 18:48:49 -0700
Sam Edwards <cfsworks@gmail.com> wrote:

Hi Sam,

> On 8/15/23 15:59, Andre Przywara wrote:
> > Hi Sam,  
> 
> Hi Andre,
> 
> > So that's a bit more nasty indeed. I don't even know if R_CPUCFG really
> > makes sense here, as the _R_ term typically refers to the management
> > processor, which the D1/R528 don't have. Or at least the always-on power
> > domain, but then again this hardly relates to the secondary entry
> > point. I think the name was just used because the address matches the
> > one used in the H6.  
> 
> Oh, no. That was my doing (and my reasoning) by suggesting that for 
> inclusion in your series. Yours is good reasoning to be rid of it.
> 
> > So taking a step back, I wonder if we should actually just define a
> > CONFIG_SUNXI_CPU_SOFT_ENTRY (or so) *Kconfig* symbol, which holds that
> > address, and let the per-SoC definition be solved in Kconfig instead.
> > Because SUNXI_R_CPUCFG_BASE and also SUNXI_RTC_BASE seem to be just
> > used as the base address for that purpose, with some magic offset
> > added, across all of U-Boot (ARMv8 FEL and v7 PSCI).  
> 
> Mmh, since this is a block of soft registers for managing several 
> functions of both cores, I think I'd rather point to the base of the 
> block and still use an offset to get to the specific soft register. 
> Allwinner may keep this layout for a 4-core chip in the near future or 
> U-Boot may want to add code that sets the CPU0 hotplug flag, for example.

That's a neat idea, but I gave up hoping that there is some real pattern,
especially about the memory map. In the past (up to A64/H5) that was
pretty stable, but changed wildly multiple times already afterwards.
So I don't know about the future, and we can always fix that should the
need arise.
What I do see though now is the following:
R40: SUNXI_SRAMC_BASE + SUN8I_R40_SRAMC_SOFT_ENTRY_REG0
R528: SUNXI_R_CPUCFG_BASE + SUN8I_R528_SOFT_ENTRY
rest: SUNXI_CPUCFG_BASE + SUNXI_PRIV0
so three totally different base addresses plus different offsets. That
comes close to random for me.
And that continues if you look into the ARMv8 fel_utils.S:
==================
#ifdef CONFIG_MACH_SUN50I_H616
        ldr     w2, =(SUNXI_R_CPUCFG_BASE + 0x1c0)
        str     w0, [x2], #0x4
#elif CONFIG_MACH_SUN50I_H6
        ldr     w2, =(SUNXI_RTC_BASE + 0x1b8)   // BOOT_CPU_HP_FLAG_REG
        str     w0, [x2], #0x4
#else
        ldr     w2, =(SUNXI_CPUCFG_BASE + 0x1a4) // offset for CPU hotplug base
	str     w0, [x2, #0x8]
==================
Again different entry points for each new SoC.
So instead of trying to derive some pattern from where there is none, I'd
rather do: config SUNXI_CPU_HOTPLUG_ADDRESS
	hex
	default 0x01c000bc if MACH_SUN8I_R40
	....
	default 0x01c25da4
and then use that symbol in both places (v7 PSCI + v8 FEL).
As mentioned, I can fix the pieces that break when naively doing so in the
FEL code. That has also the rewarding property of allowing to remove both
SUNXI_R_CPUCFG_BASE and SUNXI_RTC_BASE from the code base completely.

What do you think?

Cheers,
Andre


> I'm not unwilling to do the Kconfig route, but just out of curiosity, 
> what would your fallback plan be?
> 
> > So can you try to work on that base? I will take care of
> > armv8/fel_utils.S, which uses some post-increment assembly trick to
> > keep the code small, which wouldn't work anymore. But I have an idea
> > how to solve this.  
> 
> Before that, I think now might be a good time for me to send in the v2 
> that I have so far; I doubt the final patch of my v2 series will pass 
> review, but I'd like to keep us synced up (and clear away any patches in 
> that series that do pass review off from my mental desktop).
> 
> > Cheers,
> > Andre  
> 
> Likewise,
> Sam

