Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF7EC5B543
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 00:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14AB28291D;
	Mon,  2 Jun 2025 02:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A642D8296B; Mon,  2 Jun 2025 02:40:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7A43281F6B
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 02:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16D3D1515;
 Sun,  1 Jun 2025 17:40:25 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A10533F673;
 Sun,  1 Jun 2025 17:40:40 -0700 (PDT)
Date: Mon, 2 Jun 2025 01:39:55 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/6] sunxi: Kconfig: Fix default order for V3s DRAM clock
Message-ID: <20250602013955.61191d77@minigeek.lan>
In-Reply-To: <20250601153943.2690123-2-contact@paulk.fr>
References: <20250601153943.2690123-1-contact@paulk.fr>
 <20250601153943.2690123-2-contact@paulk.fr>
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

On Sun,  1 Jun 2025 17:39:38 +0200
Paul Kocialkowski <contact@paulk.fr> wrote:

Hi Paul,

> The V3s (using co-packaged DRAM) runs at 360 MHz, which is specified in
> the common platform Kconfig file. However the value for MACH_SUN8I will
> be picked up instead due to ordering.
> 
> Re-order the defaults to have MACH_SUN8I_V3S before MACH_SUN8I and let
> it select the correct default. Also update the LicheePi Zero Dock
> defconfig to remove the value, which is now correctly selected.

Looks alright, can confirm that all generated .config files are the
same before and after:

> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Andre

> ---
>  arch/arm/mach-sunxi/Kconfig     | 2 +-
>  configs/LicheePi_Zero_defconfig | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 17179593913e..8b43fd176dc0 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -591,9 +591,9 @@ config DRAM_CLK
>  	int "sunxi dram clock speed"
>  	default 792 if MACH_SUN9I
>  	default 648 if MACH_SUN8I_R40
> -	default 312 if MACH_SUN6I || MACH_SUN8I
>  	default 360 if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || \
>  		       MACH_SUN8I_V3S
> +	default 312 if MACH_SUN6I || MACH_SUN8I
>  	default 672 if MACH_SUN50I
>  	default 744 if MACH_SUN50I_H6
>  	default 720 if MACH_SUN50I_H616
> diff --git a/configs/LicheePi_Zero_defconfig b/configs/LicheePi_Zero_defconfig
> index c37c49ccbb16..b2cf0a018c7f 100644
> --- a/configs/LicheePi_Zero_defconfig
> +++ b/configs/LicheePi_Zero_defconfig
> @@ -3,6 +3,5 @@ CONFIG_ARCH_SUNXI=y
>  CONFIG_DEFAULT_DEVICE_TREE="sun8i-v3s-licheepi-zero"
>  CONFIG_SPL=y
>  CONFIG_MACH_SUN8I_V3S=y
> -CONFIG_DRAM_CLK=360
>  # CONFIG_HAS_ARMV7_SECURE_BASE is not set
>  CONFIG_NO_NET=y

