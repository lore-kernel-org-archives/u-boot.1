Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363E9CA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 18:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CD0F80B9B;
	Thu, 21 Aug 2025 20:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Y/zmkrQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE43D81D5D; Thu, 21 Aug 2025 20:30:20 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD4AD8004F
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 20:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57LIUDuF542870;
 Thu, 21 Aug 2025 13:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755801013;
 bh=Rg+xDMqtUWZi7RtxU2L+8+HXwU0AbuW36OYrNFU1Qks=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Y/zmkrQPa4XE30Xe7ry/mBingQASx10qVnYPTWDYYyGm6kKl5O8ZSo7jaM8Bwb0UR
 VH6LpRGUXD4OMnGYoMfMUvAKmdMA7ZACQPgMiACjpH42urpSlsi0JbxGNnNWsadVgw
 JU4bIYv5/gTjwvTG1rQw+oDkr5c5sG9cNbz+8muA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57LIUDkc3011985
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 21 Aug 2025 13:30:13 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 21
 Aug 2025 13:30:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 21 Aug 2025 13:30:12 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57LIUCFl2292554;
 Thu, 21 Aug 2025 13:30:12 -0500
Date: Thu, 21 Aug 2025 13:30:12 -0500
From: Nishanth Menon <nm@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, Bryan
 Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Michael Trimarchi <michael@amarulasolutions.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] mach-k3: am62*: am62*_init: Prohibit boot from UDA w/
 eMMC boot
Message-ID: <20250821183012.ps6ygzebsxoi2hoj@dolphin>
References: <20250710171135.669838-1-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250710171135.669838-1-jm@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 12:11-20250710, Judith Mendez wrote:
> This removes support from booting from UDA when in eMMC boot.
> 
> When user selects eMMC boot [0], that is, boot from eMMC boot0 or
> boot1 HW partitions, we should not boot from eMMC UDA. The current
> logic confuses the end user and mixes two different boot modes.

Wrong! what ROM uses to boot has no bearing as to what bootloader needs
to do for rest of the system.

https://docs.u-boot.org/en/latest/board/beagle/am62x_beagleplay.html#flash-to-emmc

There is a reason we chose this flow in BeaglePlay and other Beagle
platforms - U-boot and other components keep growing and our emmc's boot
partition is too small to handle things.


NAK if you are trying to bring the old problems we solved back.
> 
> The logic was added for AM62A/AM62P with commit: 3b7893145e36, but
> this is not a clean solution and fix will come later for falcon boot.
> 
> Logic was also added for AM62X with commit: 664593464634, but this
> logic is incorrect according to TRM [0] under Primary Boot Mode Selection
> for 'eMMC Boot'.
> 
> Fixes: 3b7893145e36 ("mach-k3: add eMMC FS boot support for am62[ap]")
> Fixes: 664593464634 ("arm: mach-k3: am625: Relax emmc boot condition")
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  arch/arm/mach-k3/am62ax/am62a7_init.c | 4 ----
>  arch/arm/mach-k3/am62px/am62p5_init.c | 4 ----
>  arch/arm/mach-k3/am62x/am625_init.c   | 4 ----
>  3 files changed, 12 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
> index edd43a1d78d..1d8644bd073 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -217,10 +217,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>  
>  	switch (bootmode) {
>  	case BOOT_DEVICE_EMMC:
> -		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
> -			return MMCSD_MODE_EMMCBOOT;
> -		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
> -			return MMCSD_MODE_FS;
>  		return MMCSD_MODE_EMMCBOOT;
>  	case BOOT_DEVICE_MMC:
>  		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
> index 6e3c66e5107..01e47deca94 100644
> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
> @@ -262,10 +262,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>  
>  	switch (bootmode) {
>  	case BOOT_DEVICE_EMMC:
> -		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
> -			return MMCSD_MODE_EMMCBOOT;
> -		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
> -			return MMCSD_MODE_FS;
>  		return MMCSD_MODE_EMMCBOOT;
>  	case BOOT_DEVICE_MMC:
>  		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
> index a422919fab1..eb7e245843c 100644
> --- a/arch/arm/mach-k3/am62x/am625_init.c
> +++ b/arch/arm/mach-k3/am62x/am625_init.c
> @@ -316,10 +316,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>  
>  	switch (bootmode) {
>  	case BOOT_DEVICE_EMMC:
> -		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
> -			return MMCSD_MODE_EMMCBOOT;
> -		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
> -			return MMCSD_MODE_FS;
>  		return MMCSD_MODE_EMMCBOOT;
>  	case BOOT_DEVICE_MMC:
>  		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> -- 
> 2.49.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
