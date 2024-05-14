Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B63FC25B75
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 13:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60D5B882D6;
	Tue, 14 May 2024 15:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22F8388232; Tue, 14 May 2024 15:38:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DAEB0882FA
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 15:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D84921007;
 Tue, 14 May 2024 06:38:37 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A8763F7A6;
 Tue, 14 May 2024 06:38:12 -0700 (PDT)
Date: Tue, 14 May 2024 14:38:04 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] sunxi: SPL SPI: add support for the V3s SoC
Message-ID: <20240514143804.167bf448@donnerap.manchester.arm.com>
In-Reply-To: <20240513234319.1966434-1-mwalle@kernel.org>
References: <20240513234319.1966434-1-mwalle@kernel.org>
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

On Tue, 14 May 2024 01:43:19 +0200
Michael Walle <mwalle@kernel.org> wrote:

Hi Michael,

> The V3s is identical regarding register layout, clocks and resets to
> the sun6i variants. Therefore, we can just add the MACH_SUN8I_V3S to
> the sun6i compatible ones.

Interesting, I was a bit surprised that this would be all we need, but
indeed everything else falls into place, when none of the newer SoCs are
used.
Regression-tested on an H616.

> SPI boot was tested on a custom board with a Gigadevice GD25Q64 8MiB
> SPI flash.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm/mach-sunxi/Kconfig         | 2 +-
>  arch/arm/mach-sunxi/spl_spi_sunxi.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index ddf9414b08e..17666814c52 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -1078,7 +1078,7 @@ config SPL_STACK_R_ADDR
>  
>  config SPL_SPI_SUNXI
>  	bool "Support for SPI Flash on Allwinner SoCs in SPL"
> -	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || SUN50I_GEN_H6 || MACH_SUNIV || SUNXI_GEN_NCAT2
> +	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || MACH_SUN8I_V3S || SUN50I_GEN_H6 || MACH_SUNIV || SUNXI_GEN_NCAT2
>  	help
>  	  Enable support for SPI Flash. This option allows SPL to read from
>  	  sunxi SPI Flash. It uses the same method as the boot ROM, so does
> diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
> index 7acb44f52ae..d7abdc2e401 100644
> --- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
> +++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
> @@ -140,7 +140,8 @@ static bool is_sun6i_gen_spi(void)
>  {
>  	return IS_ENABLED(CONFIG_SUNXI_GEN_SUN6I) ||
>  	       IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
> -	       IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2);
> +	       IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2) ||
> +	       IS_ENABLED(CONFIG_MACH_SUN8I_V3S);
>  }
>  
>  static uintptr_t spi0_base_address(void)

