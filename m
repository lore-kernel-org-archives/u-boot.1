Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4B0C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 12:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1AC387006;
	Mon, 13 Nov 2023 13:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=poczta.fm header.i=@poczta.fm header.b="wg7t5dnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7454F86B7A; Mon, 13 Nov 2023 08:56:36 +0100 (CET)
Received: from smtpo55.interia.pl (smtpo55.interia.pl [217.74.67.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B3486D12
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 08:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=poczta.fm
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sst@poczta.fm
Received: from nr200 (ipv4-80-68-225-159.net.internetunion.pl [80.68.225.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
 Mon, 13 Nov 2023 08:56:31 +0100 (CET)
Date: Mon, 13 Nov 2023 08:56:30 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 John Clark <inindev@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] rockchip: rk3588: Fix boot from SPI flash
Message-ID: <ZVHWruzw82DBVLQj@nr200>
References: <20231112102705.1180714-1-jonas@kwiboo.se>
 <20231112102705.1180714-2-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112102705.1180714-2-jonas@kwiboo.se>
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
 t=1699862193; bh=IDjIzabbhfaFnrCpzDHIB3Z+aX/IUVXmP9JTwAhQfC0=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
 b=wg7t5dnCMwPAaHFzv4NApksh7NMXDU269ludMk+lDY2mPOgXrAKZyvYGVjyWiJXdP
 Vx0H5RX1AqTD055VyA7LDrnqzNLtWs5iz1r9He7qshdDj1omtvk83DOFuVAxRoJl/5
 vNUHyDR6xj/upMDi5MxjRv/k76G0QO2D9QdP9wAI=
X-Mailman-Approved-At: Mon, 13 Nov 2023 13:26:24 +0100
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

On lis 12, 2023 10:26, Jonas Karlman wrote:
> The commit fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI
> NOR flash") added a new BROM_BOOTSOURCE_SPINOR_RK3588 with value 6.
> 
> At the time the reason for this new bootsource id value 6 was unknown.
> 
> We now know that the BootRom on RK3588 use different bootsource id
> values depending on the iomux used by the flash spi controller, and not
> by the type of spi nor or spi nand flash used.
> 
> Add the following defines and use them for RK3588 boot_devices.
> 
> - BROM_BOOTSOURCE_FSPI_M0 = 3
> - BROM_BOOTSOURCE_FSPI_M1 = 4
> - BROM_BOOTSOURCE_FSPI_M2 = 6

Tested-by: Slawomir Stepien <sst@poczta.fm>

> Fixes: fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI NOR flash")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm/include/asm/arch-rockchip/bootrom.h | 4 +++-
>  arch/arm/mach-rockchip/rk3588/rk3588.c       | 5 +++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
> index 7dab18fbc3fb..f78337397d63 100644
> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> @@ -47,8 +47,10 @@ enum {
>  	BROM_BOOTSOURCE_EMMC = 2,
>  	BROM_BOOTSOURCE_SPINOR = 3,
>  	BROM_BOOTSOURCE_SPINAND = 4,
> +	BROM_BOOTSOURCE_FSPI_M0 = 3,
> +	BROM_BOOTSOURCE_FSPI_M1 = 4,
> +	BROM_BOOTSOURCE_FSPI_M2 = 6,
>  	BROM_BOOTSOURCE_SD = 5,
> -	BROM_BOOTSOURCE_SPINOR_RK3588 = 6,
>  	BROM_BOOTSOURCE_USB = 10,
>  	BROM_LAST_BOOTSOURCE = BROM_BOOTSOURCE_USB
>  };
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index b1f535fad505..322164e9b307 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -39,9 +39,10 @@ DECLARE_GLOBAL_DATA_PTR;
>  
>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe2e0000",
> -	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
> +	[BROM_BOOTSOURCE_FSPI_M0] = "/spi@fe2b0000/flash@0",
> +	[BROM_BOOTSOURCE_FSPI_M1] = "/spi@fe2b0000/flash@0",
> +	[BROM_BOOTSOURCE_FSPI_M2] = "/spi@fe2b0000/flash@0",
>  	[BROM_BOOTSOURCE_SD] = "/mmc@fe2c0000",
> -	[BROM_BOOTSOURCE_SPINOR_RK3588] = "/spi@fe2b0000/flash@0",
>  };
>  
>  static struct mm_region rk3588_mem_map[] = {

-- 
Slawomir Stepien
