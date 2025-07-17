Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41156C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 15:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FC98340C;
	Thu, 17 Jul 2025 17:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wKABMh4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DEA283423; Thu, 17 Jul 2025 17:29:56 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3F25833EC
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 17:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56HFTpkJ510049;
 Thu, 17 Jul 2025 10:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752766191;
 bh=7NxxEsPM2oZe5Jtjm/NjsuWvwmg+RdwxxRMXlECc9+U=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=wKABMh4eWqEWqD7ln97wzmHscwc7C4KiRqhDTwbTUHzxQ/zzVIe4ZL6dLS0lgIZX3
 gOM/J93EbWUvgusPNNCEPdeVSsZNmC09VjGEZQbBQw+lDTw5vtCB5yFNhOqqOf8xiU
 oZ8fLMgtEvjiEItZiyVHKuIVf+qIU3nAxPMK6rlQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56HFTpUS1732286
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 17 Jul 2025 10:29:51 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 17
 Jul 2025 10:29:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 17 Jul 2025 10:29:50 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56HFTo8u2074934;
 Thu, 17 Jul 2025 10:29:50 -0500
Date: Thu, 17 Jul 2025 10:29:50 -0500
From: Bryan Brattlof <bb@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, Andrew Davis
 <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] mach-k3: am62*: am62*_init: Prohibit boot from UDA w/
 eMMC boot
Message-ID: <20250717152950.n5bfcobot66stpz3@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250710171135.669838-1-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On July 10, 2025 thus sayeth Judith Mendez:
> This removes support from booting from UDA when in eMMC boot.
> 
> When user selects eMMC boot [0], that is, boot from eMMC boot0 or
> boot1 HW partitions, we should not boot from eMMC UDA. The current
> logic confuses the end user and mixes two different boot modes.
> 
> The logic was added for AM62A/AM62P with commit: 3b7893145e36, but

If we end up respinning this we should probably use the standard
'commit: <sha> "(<msg>)"' syntax.

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

If we're booting from what ROM calls eMMC boot, which ROM has the 
limitation where we can only boot from MMC0 in 8bit 1v8 and in RAW mode. 
So I see the need to soften this requirement.

>  		return MMCSD_MODE_EMMCBOOT;
>  	case BOOT_DEVICE_MMC:

But it also has what they call MMC/SD mode which gives us the option of 
booting from both MMC0 and MMC1 and in RAW or FS mode by setting the 
PORT and RAW pins which we can read in the WKUP_CTRL_MMR0. And can give 
us the same configuration as the previous boot mode.

I agree if we know the next phases of boot won't fit in the boot 
partition we should be using this bootmode.

But I know this takes away some functionality after people have already 
had their boards made and who cannot realistically change their bootmode 
pins. I wonder if we should mark this as __weak so people can override 
this in the board/ directory if needed?

~Bryan
