Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F5BC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 13:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0D1F88047;
	Fri,  7 Jun 2024 15:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nwl.cc header.i=@nwl.cc header.b="pdQJDIm6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7BEE87F6F; Fri,  7 Jun 2024 15:45:34 +0200 (CEST)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC81887FCD
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 15:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=phil@nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
 s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U9PFA8eeD5LqrtprDhy6pcKmDoB9Ej2Jtwh8dGdk890=; b=pdQJDIm6n2hlrklglpqlbhhUr5
 WkXeyOH+QYAQbgOinWPMC3aQXzv2eZ0Gl84j4239fLOJghG2PZjpCITkOtH32lPeEUDzJoov+tvhU
 XCHq7yrsurgyRRoPiO8yA249moYnFkVsqeRocYnYLdhhVxhMr8D0L9j/GYMnnv9Ue0Vi9p/YOL02f
 ejOGOqKfwY56OD1rWyetJjYxnVKiL4FX3jGAc1c2xvuCZ0B4yelci3NvG1CTM4fwbxxW9vrmd13Ub
 pDrdhgQbkH1RSDF83ZtNg3HYY/lbgdLRrcmxBgM6+hozB4YOEyXiLGVJUe139e7uw+CCThOV+r/rp
 j+jRdXDw==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
 (envelope-from <phil@nwl.cc>) id 1sFZuN-000000007AV-2qzR;
 Fri, 07 Jun 2024 15:45:31 +0200
Date: Fri, 7 Jun 2024 15:45:31 +0200
From: Phil Sutter <phil@nwl.cc>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm: mvebu: Enable bootstd and other modernization for
 Synology DS414 (Armada XP) board
Message-ID: <ZmMO-yODr9n2X7yD@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Tony Dinh <mibodhi@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
References: <20240606234437.24549-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606234437.24549-1-mibodhi@gmail.com>
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

Hi Tony,

On Thu, Jun 06, 2024 at 04:44:36PM -0700, Tony Dinh wrote:
> - Switch to standard boot (in include/configs/ds414.h and
> configs/ds414_defconfig)
> - Implement board_late_init() to ensure successful enumeration
> of USB3 devices

Oh, this makes the rear USB3 ports usable? I had failed to get there
when working on DS414 support.

> - Remove unnecessary misc_init_r(), since NET_RANDOM_ETHADDR is now
> configured in

So u-boot will assign random MAC addresses to the NICs instead of the
real ones? Won't this potentially break PXE boot setups?

> - Remove unnecessary checkboard()
> - Updated IDENT_STRING to indicate this u-boot supports both Synology
> DS414 and DS214+ boards
> - Add SYS_THUMB_BUILD to reduce binary size
> - Add NET_RANDOM_ETHADDR
> - Add CONFIG_LBA48 and CONFIG_SYS_64BIT_LBA to support >2TB HDD/SDD
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
> 
>  board/Synology/ds414/ds414.c | 15 +++--------
>  configs/ds414_defconfig      | 20 ++++++--------
>  include/configs/ds414.h      | 51 ++++++++++++++++++++++--------------
>  3 files changed, 42 insertions(+), 44 deletions(-)
> 
> diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds414.c
> index abe6f9eb5e..f0b55fa095 100644
> --- a/board/Synology/ds414/ds414.c
> +++ b/board/Synology/ds414/ds414.c
> @@ -181,18 +181,9 @@ int board_init(void)
>  	return 0;
>  }
>  
> -int misc_init_r(void)
> +int board_late_init(void)
>  {
> -	if (!env_get("ethaddr")) {
> -		puts("Incomplete environment, populating from SPI flash\n");
> -		do_syno_populate(0, NULL);
> -	}
> -	return 0;
> -}

This is useful for first boot of flashed vanilla u-boot. Can this be
retained somehow?

[...]
> diff --git a/include/configs/ds414.h b/include/configs/ds414.h
> index 9446acba79..bbefe632e0 100644
> --- a/include/configs/ds414.h
> +++ b/include/configs/ds414.h
[...]
> @@ -38,23 +34,38 @@
>   * L2 cache thus cannot be used.
>   */
>  
> -/* SPL */
> -/* Defines for SPL */
> +/* Keep device tree and initrd in lower memory so the kernel can access them */
> +#define RELOCATION_LIMITS_ENV_SETTINGS  \
> +	"fdt_high=0x10000000\0"         \
> +	"initrd_high=0x10000000\0"
> +
> +/*
> + * mv-common.h should be defined after CMD configs since it used them
> + * to enable certain macros
> + */
> +#include "mv-common.h"
> +
> +#ifndef CONFIG_SPL_BUILD
>  
> -/* Default Environment */
> +#define KERNEL_ADDR_R	__stringify(0x1000000)
> +#define FDT_ADDR_R	__stringify(0x2000000)
> +#define RAMDISK_ADDR_R	__stringify(0x2200000)
> +#define SCRIPT_ADDR_R	__stringify(0x1800000)
> +#define PXEFILE_ADDR_R	__stringify(0x1900000)
>  
> -#define CFG_EXTRA_ENV_SETTINGS				\
> -	"initrd_high=0xffffffff\0"				\
> -	"ramdisk_addr_r=0x8000000\0"				\
> -	"usb0Mode=host\0usb1Mode=host\0usb2Mode=device\0"	\
> -	"ethmtu=1500\0eth1mtu=1500\0"				\
> -	"update_uboot=sf probe; dhcp; "				\
> -		"mw.b ${loadaddr} 0x0 0xd0000; "		\
> -		"tftpboot ${loadaddr} u-boot-with-spl.kwb; "	\
> -		"sf update ${loadaddr} 0x0 0xd0000\0"

Are these dropped or am I missing a generic spot which adds them? IIRC,
the usb*mode and eth*mtu settings are required, is that wrong? Lastly,
that update_uboot macro at least helps preventing people from writing
into wrong spots. What's the cause for dropping it?

Thanks, Phil
