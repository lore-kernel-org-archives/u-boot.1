Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C6DCEBF61
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 00:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1377B83C2B;
	Tue, 18 Nov 2025 01:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6EF683C2B; Tue, 18 Nov 2025 01:56:01 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E384383C16
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 01:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F5F0FEC;
 Mon, 17 Nov 2025 16:55:51 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A69A3F66E;
 Mon, 17 Nov 2025 16:55:58 -0800 (PST)
Date: Tue, 18 Nov 2025 00:55:51 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Tom Rini
 <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Paul
 Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 02/11] sunxi: a733: config TF-A load address
Message-ID: <20251118005551.0756cbc5@minigeek.lan>
In-Reply-To: <20251116-01-a733-soc-support-v1-2-fb4c8db78e75@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
 <20251116-01-a733-soc-support-v1-2-fb4c8db78e75@gentoo.org>
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

On Sun, 16 Nov 2025 14:43:53 +0000
Yixun Lan <dlan@gentoo.org> wrote:

Hi,

> To support running TF-A on A733 SoC, config 0x62000 of SRAM as
> the load and run address.

I don't think there is a reason to split those Kconfig entries up in
multiple patches. You could group them as SPL related and U-Boot
proper related, for instance.

Cheers,
Andre


> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> 
> ---
> Note, the address can be altered to other value, for example,
> moving it to the DDR address space. The only requirement is that
> load and run address should be matched.
> ---
>  arch/arm/mach-sunxi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index c0b4fdaa370..d16ffddf482 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -259,6 +259,7 @@ config SUNXI_BL31_BASE
>  	default 0x40000000 if MACH_SUN50I_H616
>  	default 0x00104000 if SUN50I_GEN_H6
>  	default 0x00054000 if MACH_SUN55I_A523
> +	default 0x00062000 if MACH_SUN60I_A733
>  	default 0x0
>  	help
>  	  Address where BL31 (TF-A) is loaded, or zero if BL31 is not used.
> 

