Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF91CFA3725
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 00:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C5183D0B;
	Fri,  2 Jan 2026 01:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C64F2840A2; Fri,  2 Jan 2026 01:41:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 88B3483B91
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 01:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F10BE497;
 Thu,  1 Jan 2026 16:41:03 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FE433F694;
 Thu,  1 Jan 2026 16:41:09 -0800 (PST)
Date: Fri, 2 Jan 2026 01:40:19 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev, Jagan Teki
 <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Paul Kocialkowski <contact@paulk.fr>, Samuel
 Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 01/10] sunxi: sun60i: initial support for A733 SoC
Message-ID: <20260102014019.36db66d4@minigeek.lan>
In-Reply-To: <20251130-01-a733-soc-support-v2-1-18bdd4376fad@gentoo.org>
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
 <20251130-01-a733-soc-support-v2-1-18bdd4376fad@gentoo.org>
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

On Sun, 30 Nov 2025 21:45:10 +0000
Yixun Lan <dlan@gentoo.org> wrote:

Hi Yixun,

thanks for updating this series, and sorry for the delay in the review.

As for this patch: it should go to the end of the series, since it
already introduces the possibility to select the new SoC, even though
the rest of the code isn't ready yet. And I think we should drop the 
"select SUPPORT_SPL", since it's not really supported, without the DRAM
code. If we rely on FEL to load U-Boot anyway, we can much simpler load
TF-A and U-Boot proper directly, no need for any FIT image.
And thanks for using the SUNXI_GEN_NCAT2 symbol, btw!

One small thing below...

> Add basic support for Allwinner A733 SoC.
> 
> - Include some basic register definitions
> - Introduce a new SUN60I A733 Kconfig option
> - Ssetup RVBAR register properly according to docs
> - Config max DDR size 16GB
> - Config SRAM 0x62000 for TF-A
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> 
> ---
> Note, Address for TF-A can be altered to other value, for example,
> moving it to the DDR address space. The only requirement is that
> load and run address should be matched.
> ---
>  arch/arm/mach-sunxi/Kconfig    | 14 ++++++++++++++
>  arch/arm/mach-sunxi/cpu_info.c |  2 ++
>  include/configs/sun60i.h       | 11 +++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index e979ee4a2cc..e6b4ac3688b 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -215,6 +215,7 @@ config SUNXI_SRAM_ADDRESS
>  	hex
>  	default 0x10000 if MACH_SUN9I || MACH_SUN50I || MACH_SUN50I_H5
>  	default 0x44000 if MACH_SUN55I_A523
> +	default 0x47000 if MACH_SUN60I_A733
>  	default 0x20000 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
>  	default 0x0
>  	---help---
> @@ -228,6 +229,7 @@ config SUNXI_RVBAR_ADDRESS
>  	depends on ARM64
>  	default 0x08100040 if MACH_SUN50I_A133
>  	default 0x08000040 if MACH_SUN55I_A523
> +	default 0x08001004 if MACH_SUN60I_A733
>  	default 0x09010040 if SUN50I_GEN_H6
>  	default 0x017000a0
>  	---help---
> @@ -257,6 +259,7 @@ config SUNXI_BL31_BASE
>  	default 0x40000000 if MACH_SUN50I_H616
>  	default 0x00104000 if SUN50I_GEN_H6
>  	default 0x00054000 if MACH_SUN55I_A523
> +	default 0x00062000 if MACH_SUN60I_A733
>  	default 0x0
>  	help
>  	  Address where BL31 (TF-A) is loaded, or zero if BL31 is not used.
> @@ -339,6 +342,7 @@ config MACH_SUNXI_H3_H5
>  config SUNXI_DRAM_MAX_SIZE
>  	hex
>  	default 0x100000000 if MACH_SUN50I_H616 || MACH_SUN50I_A133 || MACH_SUN55I_A523
> +	default 0x400000000 if MACH_SUN60I_A733
>  	default 0xC0000000 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN50I_H6
>  	default 0x80000000
>  
> @@ -553,6 +557,14 @@ config MACH_SUN55I_A523
>  	select SPL_LOAD_FIT if SPL
>  	imply OF_UPSTREAM
>  
> +config MACH_SUN60I_A733
> +	bool "sun60i (Allwinner A733)"
> +	select ARM64
> +	select SUNXI_GEN_NCAT2
> +	select FIT
> +	select SPL_LOAD_FIT if SPL
> +	select SUPPORT_SPL
> +
>  endchoice
>  
>  # The sun8i SoCs share a lot, this helps to avoid a lot of "if A23 || A33"
> @@ -870,6 +882,7 @@ config SYS_CONFIG_NAME
>  	default "sun50i" if MACH_SUN50I_H616
>  	default "sun50i" if MACH_SUN50I_A133
>  	default "sun55i" if MACH_SUN55I_A523
> +	default "sun60i" if MACH_SUN60I_A733
>  
>  config SYS_BOARD
>  	default "sunxi"
> @@ -1186,6 +1199,7 @@ config SPL_STACK_R_ADDR
>  	default 0x4fe00000 if MACH_SUN50I
>  	default 0x4fe00000 if SUN50I_GEN_H6
>  	default 0x4fe00000 if SUNXI_GEN_NCAT2
> +	default 0x4fe00000 if MACH_SUN60I_A733

This is not needed, since the same address is already selected by NCAT2.

Cheers,
Andre

>  config SPL_SPI_SUNXI
>  	bool "Support for SPI Flash on Allwinner SoCs in SPL"
> diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_info.c index c3a51d9956e..f0b33bb9097 100644
> --- a/arch/arm/mach-sunxi/cpu_info.c
> +++ b/arch/arm/mach-sunxi/cpu_info.c
> @@ -108,6 +108,8 @@ int print_cpuinfo(void)
>  	puts("CPU:   Allwinner A133 (SUN50I)\n");
>  #elif defined CONFIG_MACH_SUN55I_A523
>  	puts("CPU:   Allwinner A523 (SUN55I)\n");
> +#elif defined CONFIG_MACH_SUN60I_A733
> +	puts("CPU:   Allwinner A733 (SUN60I)\n");
>  #else
>  #warning Please update cpu_info.c with correct CPU information
>  	puts("CPU:   SUNXI Family\n");
> diff --git a/include/configs/sun60i.h b/include/configs/sun60i.h
> new file mode 100644
> index 00000000000..70649366c1c
> --- /dev/null
> +++ b/include/configs/sun60i.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Placeholder wrapper to allow addressing Allwinner devices with Cortex-A55
> + * cores separately. Please do not add anything in here.
> + */
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#include <configs/sunxi-common.h>
> +
> +#endif /* __CONFIG_H */
> 

