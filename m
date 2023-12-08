Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C19C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 01:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC1038743A;
	Fri,  8 Dec 2023 02:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65FEA8745E; Fri,  8 Dec 2023 02:41:19 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1EB048726C
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 02:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2061711FB;
 Thu,  7 Dec 2023 17:42:02 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B0C13F762;
 Thu,  7 Dec 2023 17:41:15 -0800 (PST)
Date: Fri, 8 Dec 2023 00:33:48 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, Icenowy
 Zheng <icenowy@aosc.io>, Jesse Taube <Mr.Bossman075@gmail.com>, Simon Glass
 <sjg@chromium.org>
Subject: Re: [PATCH v3 2/4] sunxi: binman: Move BL31 and SCP firmware
 addresses to Kconfig
Message-ID: <20231208003348.0ab40d80@slackpad.lan>
In-Reply-To: <20231031051805.62430-3-samuel@sholland.org>
References: <20231031051805.62430-1-samuel@sholland.org>
 <20231031051805.62430-3-samuel@sholland.org>
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

On Tue, 31 Oct 2023 00:17:39 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi Samuel,

> This is easier to read than the #ifdef staircase, provides better
> visibility into the memory map (alongside the other Kconfig
> definitions), and allows these addresses to be reused from code.

This is indeed much nicer, and simplifies adding more SoCs.
I checked that the addresses are the same:

> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>  - New patch for v2, split from the .dtsi changes
> 
>  arch/arm/dts/sunxi-u-boot.dtsi | 24 +++++++-----------------
>  arch/arm/mach-sunxi/Kconfig    | 17 +++++++++++++++++
>  2 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
> index a0c8abb7033..7a8764e463b 100644
> --- a/arch/arm/dts/sunxi-u-boot.dtsi
> +++ b/arch/arm/dts/sunxi-u-boot.dtsi
> @@ -1,15 +1,5 @@
>  #include <config.h>
>  
> -#ifdef CONFIG_MACH_SUN50I_H6
> -#define BL31_ADDR 0x104000
> -#define  SCP_ADDR 0x114000
> -#elif defined(CONFIG_MACH_SUN50I_H616)
> -#define BL31_ADDR 0x40000000
> -#else
> -#define BL31_ADDR  0x44000
> -#define  SCP_ADDR  0x50000
> -#endif
> -
>  / {
>  	aliases {
>  		mmc0 = &mmc0;
> @@ -69,8 +59,8 @@
>  					os = "arm-trusted-firmware";
>  					arch = "arm64";
>  					compression = "none";
> -					load = <BL31_ADDR>;
> -					entry = <BL31_ADDR>;
> +					load = <CONFIG_SUNXI_BL31_BASE>;
> +					entry = <CONFIG_SUNXI_BL31_BASE>;
>  
>  					atf-bl31 {
>  						filename = "bl31.bin";
> @@ -78,13 +68,13 @@
>  					};
>  				};
>  
> -#ifdef SCP_ADDR
> +#if CONFIG_SUNXI_SCP_BASE
>  				scp {
>  					description = "SCP firmware";
>  					type = "firmware";
>  					arch = "or1k";
>  					compression = "none";
> -					load = <SCP_ADDR>;
> +					load = <CONFIG_SUNXI_SCP_BASE>;
>  
>  					scp {
>  						filename = "scp.bin";
> @@ -106,10 +96,10 @@
>  				@config-SEQ {
>  					description = "NAME";
>  					firmware = "atf";
> -#ifndef SCP_ADDR
> -					loadables = "uboot";
> -#else
> +#if CONFIG_SUNXI_SCP_BASE
>  					loadables = "scp", "uboot";
> +#else
> +					loadables = "uboot";
>  #endif
>  					fdt = "fdt-SEQ";
>  				};
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index a10e4c06b6a..b0fbda0aa09 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -155,6 +155,23 @@ config SUNXI_RVBAR_ALTERNATIVE
>  	for all other SoCs, so the content of the SRAM_VER_REG becomes
>  	irrelevant there, and we can use the same code.
>  
> +config SUNXI_BL31_BASE
> +	hex
> +	default 0x00044000 if MACH_SUN50I || MACH_SUN50I_H5
> +	default 0x00104000 if MACH_SUN50I_H6
> +	default 0x40000000 if MACH_SUN50I_H616
> +	default 0x0
> +	help
> +	  Address where BL31 (TF-A) is loaded, or zero if BL31 is not used.
> +
> +config SUNXI_SCP_BASE
> +	hex
> +	default 0x00050000 if MACH_SUN50I || MACH_SUN50I_H5
> +	default 0x00114000 if MACH_SUN50I_H6
> +	default 0x0
> +	help
> +	  Address where SCP firmware is loaded, or zero if it is not used.
> +
>  config SUNXI_A64_TIMER_ERRATUM
>  	bool
>  

