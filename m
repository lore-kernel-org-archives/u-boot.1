Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BCFC54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 00:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66C688296B;
	Mon,  2 Jun 2025 02:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C83882A8B; Mon,  2 Jun 2025 02:40:58 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 79D6B8296B
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 02:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CC241515;
 Sun,  1 Jun 2025 17:40:39 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7A643F673;
 Sun,  1 Jun 2025 17:40:54 -0700 (PDT)
Date: Mon, 2 Jun 2025 01:40:14 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/6] sunxi: Add support for the Lichee Pi Zero with Dock
Message-ID: <20250602014014.0664e6fe@minigeek.lan>
In-Reply-To: <20250601153943.2690123-3-contact@paulk.fr>
References: <20250601153943.2690123-1-contact@paulk.fr>
 <20250601153943.2690123-3-contact@paulk.fr>
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

On Sun,  1 Jun 2025 17:39:39 +0200
Paul Kocialkowski <contact@paulk.fr> wrote:

Hi Paul,

> This adds a U-Boot config and device-tree build for the Lichee Pi Zero
> with Dock. Compared to the Lichee Pi Zero, it has an ethernet port
> (with internal PHY) so the EMAC driver and network support are enabled.

I just realised that there is no difference between the U-Boot versions
of the DT and the kernel ones, so can you please use the opportunity to
upgrade the V3x systems to OF_UPSTREAM (in a separate patch)? This would
involve removing all the redundant .dts* files from arch/arm/dts, see
dc2dd2de0f782860 for an example.

Regardless the defconfig looks alright, but one comment:

> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/dts/Makefile                | 3 ++-
>  configs/LicheePi_Zero_Dock_defconfig | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>  create mode 100644 configs/LicheePi_Zero_Dock_defconfig
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 32b698a7f411..be6867ceae0e 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -650,7 +650,8 @@ dtb-$(CONFIG_MACH_SUN8I_V3S) += \
>  	sun8i-s3-elimo-initium.dtb \
>  	sun8i-s3-pinecube.dtb \
>  	sun8i-v3-sl631-imx179.dtb \
> -	sun8i-v3s-licheepi-zero.dtb
> +	sun8i-v3s-licheepi-zero.dtb \
> +	sun8i-v3s-licheepi-zero-dock.dtb
>  dtb-$(CONFIG_MACH_SUN8I_R528) += \
>  	sun8i-t113s-mangopi-mq-r-t113.dtb
>  dtb-$(CONFIG_MACH_SUN50I_H5) += \
> diff --git a/configs/LicheePi_Zero_Dock_defconfig b/configs/LicheePi_Zero_Dock_defconfig
> new file mode 100644
> index 000000000000..ec172d98b65e
> --- /dev/null
> +++ b/configs/LicheePi_Zero_Dock_defconfig
> @@ -0,0 +1,7 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_SUNXI=y
> +CONFIG_DEFAULT_DEVICE_TREE="sun8i-v3s-licheepi-zero-dock"
> +CONFIG_SPL=y
> +CONFIG_MACH_SUN8I_V3S=y
> +# CONFIG_HAS_ARMV7_SECURE_BASE is not set

IIUC, the V3S does not have (secure) SRAM A2, and no ARISC? Can we
express this in the Kconfig file then, since it's not a board config
option?

Cheers,
Andre

> +CONFIG_SUN8I_EMAC=y

