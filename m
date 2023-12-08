Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A72DC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 01:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D3A874D9;
	Fri,  8 Dec 2023 02:41:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10E0E874D9; Fri,  8 Dec 2023 02:41:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C6E70874EB
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 02:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 176F711FB;
 Thu,  7 Dec 2023 17:42:10 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 671A63F762;
 Thu,  7 Dec 2023 17:41:23 -0800 (PST)
Date: Fri, 8 Dec 2023 01:26:28 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, Icenowy
 Zheng <icenowy@aosc.io>, Jesse Taube <Mr.Bossman075@gmail.com>
Subject: Re: [PATCH v3 3/4] sunxi: binman: Support FIT generation for 32-bit
 SoCs
Message-ID: <20231208012628.690bbdb3@slackpad.lan>
In-Reply-To: <20231031051805.62430-4-samuel@sholland.org>
References: <20231031051805.62430-1-samuel@sholland.org>
 <20231031051805.62430-4-samuel@sholland.org>
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

On Tue, 31 Oct 2023 00:17:40 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi,

> Some 32-bit SoCs can use SCP firmware to implement additional PSCI
> functionality, such as system suspend. In order to load this firmware
> from SPL, we need to generate and use a FIT instead of a legacy image.
> 
> Adjust the binman FIT definition so it does not rely on TF-A BL31, as
> this is not used on 32-bit SoCs. Instead, after loading the firmware,
> U-Boot proper is executed directly.

I like that it removes the artificial restriction to use a FIT image
only on arm64 builds, and indeed hinges that on the relevant
CONFIG_SPL_LOAD_FIT variable.
The changes look alright, even "uboot" being mentioned twice (once as
firmware, once as loadable): the SPL code can cope with that.

> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>  - Rely on binman min-size instead of using explicit offsets
>  - Use Kconfig for firmware addresses instead of an #ifdef staircase
> 
>  arch/arm/dts/sunxi-u-boot.dtsi | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
> index 7a8764e463b..ed1cb91eeb5 100644
> --- a/arch/arm/dts/sunxi-u-boot.dtsi
> +++ b/arch/arm/dts/sunxi-u-boot.dtsi
> @@ -1,5 +1,11 @@
>  #include <config.h>
>  
> +#ifdef CONFIG_ARM64
> +#define ARCH "arm64"
> +#else
> +#define ARCH "arm"
> +#endif
> +
>  / {
>  	aliases {
>  		mmc0 = &mmc0;
> @@ -34,30 +40,32 @@
>  			filename = "spl/sunxi-spl.bin";
>  		};
>  
> -#ifdef CONFIG_ARM64
> +#ifdef CONFIG_SPL_LOAD_FIT
>  		fit {
> -			description = "Configuration to load ATF before U-Boot";
> +			description = "Configuration to load U-Boot and firmware";
>  			#address-cells = <1>;
>  			fit,fdt-list = "of-list";
>  
>  			images {
>  				uboot {
> -					description = "U-Boot (64-bit)";
> +					description = "U-Boot";
>  					type = "standalone";
>  					os = "u-boot";
> -					arch = "arm64";
> +					arch = ARCH;
>  					compression = "none";
>  					load = <CONFIG_TEXT_BASE>;
> +					entry = <CONFIG_TEXT_BASE>;
>  
>  					u-boot-nodtb {
>  					};
>  				};
>  
> +#if CONFIG_SUNXI_BL31_BASE
>  				atf {
>  					description = "ARM Trusted Firmware";
>  					type = "firmware";
>  					os = "arm-trusted-firmware";
> -					arch = "arm64";
> +					arch = ARCH;
>  					compression = "none";
>  					load = <CONFIG_SUNXI_BL31_BASE>;
>  					entry = <CONFIG_SUNXI_BL31_BASE>;
> @@ -67,6 +75,7 @@
>  						missing-msg = "atf-bl31-sunxi";
>  					};
>  				};
> +#endif
>  
>  #if CONFIG_SUNXI_SCP_BASE
>  				scp {
> @@ -95,7 +104,11 @@
>  
>  				@config-SEQ {
>  					description = "NAME";
> +#if CONFIG_SUNXI_BL31_BASE
>  					firmware = "atf";
> +#else
> +					firmware = "uboot";
> +#endif
>  #if CONFIG_SUNXI_SCP_BASE
>  					loadables = "scp", "uboot";
>  #else

