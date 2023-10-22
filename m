Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FAEC001E0
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 00:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F198767A;
	Sun, 22 Oct 2023 02:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B1EE8767A; Sun, 22 Oct 2023 02:54:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E7B0885C98
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 02:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F239E2F4;
 Sat, 21 Oct 2023 17:55:10 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E53463F64C;
 Sat, 21 Oct 2023 17:54:28 -0700 (PDT)
Date: Sun, 22 Oct 2023 01:53:25 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Samuel
 Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Icenowy Zheng <uwu@icenowy.me>, Maksim Kiselev <bigunclemax@gmail.com>
Subject: Re: [PATCH v4 0/4] Allwinner R528/T113s PSCI
Message-ID: <20231022015325.28db2090@slackpad.lan>
In-Reply-To: <20231012014756.2573473-1-CFSworks@gmail.com>
References: <20231012014756.2573473-1-CFSworks@gmail.com>
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

On Wed, 11 Oct 2023 19:47:52 -0600
Sam Edwards <cfsworks@gmail.com> wrote:

Hi Sam,

> Hi list,
> 
> This is the third, and hopefully final, version of my patchset for PSCI support
> on R528/T113-s3. This one, as always, depends on Andre Przywara's T113s support
> series (v2), available on the list and also located on a Git branch at:
> https://source.denx.de/u-boot/custodians/u-boot-sunxi.git t113s-v2
> 
> NOTE THAT THIS ALSO depends on the following commit on master:
> 3d5e52bd97 ("ARM: psci: move GIC address override to Kconfig")
> 
> For testing: I can confirm that patch 2/4 results in no change to machine code
> whatsoever on any supported target. Patch 1/4 results in a minor machine code
> change on R40 only. Patch 3/4 will likely require testing on each of the 4
> "special case" sunxi targets (sun6i, sun7i, R40, H3) to ensure that register
> offsets are kept consistent. Patch 4/4 needs testing on R528 only.

For now I have included this series into the T113s support series and
pushed this to sunxi/master, to trigger the CI.

I will do some final testing here on the MangoPi and other boards (for
regressions), but I am hopeful to send a pull request in the next day
to two.

Thanks again for your persistent work on this, much appreciated!

Cheers,
Andre

 > 
> Warm regards,
> Sam
> 
> Changes v3->v4:
> - The GIC base address override is done through Kconfig, instead of in
>   sunxi-common.h
> 
> Changes v2->v3:
> - Fix missing `cpu=0;` for the sun7i power management case.
> - Make sunxi_cpu_power_off() a static function, per feedback on v2.
> - Kevin Amadiva of MEC electronics got in touch with me off-list,
> reported success bringing up CPU1 of a T113 with this patchset, and
> kindly provided me with a Tested-by tag for patch 4/4.
> - Remove a comment about R40/R528 being special, per feedback on v2.
> - Simplify an if statement, per feedback on v2.
> - Add missing 'select' directives to the R528 Kconfig, per feedback
> on v2.
> 
> Changes v1->v2:
> - Power clamp is now adjusted ONLY on sun{6,7}i, H3, R40. The
> previous version was mistakenly doing this EXCEPT on those machines.
> - Flattened sunxi_power_switch() into sunxi_cpu_set_power() for
> simplicity's sake.
> - Moved the "power clamp is not NULL" conditional into
> sunxi_cpu_set_power().
> - Removed unnecessary H6 special-case, since H6 is actually ARM64.
> - Renamed SUNXI_CPUX_BASE to SUNXI_CPUCFG_BASE, to mirror expected
> changes in Andre's v2 of the R528 series (we decided against using a
> new name for this block).
> - Removed sunxi_cpucfg_reg struct, and stopped using the PRCM struct
> in psci.c.
> 
> Sam Edwards (4):
>   sunxi: psci: clean away preprocessor macros
>   sunxi: psci: refactor register access to separate functions
>   sunxi: psci: stop modeling register layout with C structs
>   sunxi: psci: implement PSCI on R528
> 
>  arch/arm/cpu/armv7/Kconfig               |   3 +-
>  arch/arm/cpu/armv7/sunxi/psci.c          | 185
> ++++++++++++++--------- arch/arm/include/asm/arch-sunxi/cpucfg.h |
> 67 -------- arch/arm/mach-sunxi/Kconfig              |   4 +
>  4 files changed, 121 insertions(+), 138 deletions(-)
>  delete mode 100644 arch/arm/include/asm/arch-sunxi/cpucfg.h
> 

