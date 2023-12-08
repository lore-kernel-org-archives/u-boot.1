Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BBFC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 01:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5278087483;
	Fri,  8 Dec 2023 02:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C5E487480; Fri,  8 Dec 2023 02:41:21 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1E27287150
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 02:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B51C139F;
 Thu,  7 Dec 2023 17:42:04 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E15543F762;
 Thu,  7 Dec 2023 17:41:17 -0800 (PST)
Date: Fri, 8 Dec 2023 01:39:45 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, Icenowy
 Zheng <icenowy@aosc.io>, Jesse Taube <Mr.Bossman075@gmail.com>
Subject: Re: [PATCH v3 4/4] sunxi: Enable SPL FIT loading for 32-bit SoCs
Message-ID: <20231208013945.6ac0b9e8@slackpad.lan>
In-Reply-To: <20231031051805.62430-5-samuel@sholland.org>
References: <20231031051805.62430-1-samuel@sholland.org>
 <20231031051805.62430-5-samuel@sholland.org>
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

On Tue, 31 Oct 2023 00:17:41 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi,

> Now that 32-bit SoCs can load U-Boot proper (and possibly other
> firmware) from a FIT, use this method by default. SPL_FIT_IMAGE_TINY is
> required to stay within the 24 or 32 KiB SPL size limit on early SoCs;
> for consistency, enable it everywhere.

Mmh, so that changes the build for an awful lot of boards, especially
old ones that no one can be bothered to test anymore. I am bit scared
of that change there, especially with the limited SRAM size there.

I think the main motivation stems from crust on H3, and since H3 boards
are still in good use and get tested, I'd prefer to enable it just for
H3 boards, at least for now.
If we don't hear anything bad for a while, we could try to enable it
(by default) on the other SoCs as well.

What do you think?

Cheers,
Andre



> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>  - New patch for v2, split from the .dtsi changes
> 
>  arch/arm/Kconfig   | 1 +
>  common/spl/Kconfig | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d812685c984..42781d02f0f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1167,6 +1167,7 @@ config ARCH_SUNXI
>  	imply SPL_GPIO
>  	imply SPL_LIBCOMMON_SUPPORT
>  	imply SPL_LIBGENERIC_SUPPORT
> +	imply SPL_LOAD_FIT
>  	imply SPL_MMC if MMC
>  	imply SPL_POWER
>  	imply SPL_SERIAL
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index a0968ff1065..aebbfbf99d2 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -567,8 +567,7 @@ config SYS_MMCSD_RAW_MODE_EMMC_BOOT_PARTITION
>  config SPL_FIT_IMAGE_TINY
>  	bool "Remove functionality from SPL FIT loading to reduce size"
>  	depends on SPL_FIT
> -	default y if MACH_SUN50I || MACH_SUN50I_H5 || SUN50I_GEN_H6
> -	default y if ARCH_IMX8M || ARCH_IMX9
> +	default y if ARCH_IMX8M || ARCH_IMX9 || ARCH_SUNXI
>  	help
>  	  Enable this to reduce the size of the FIT image loading code
>  	  in SPL, if space for the SPL binary is very tight.

