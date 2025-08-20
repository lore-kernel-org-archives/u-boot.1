Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9094CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 13:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA2D82B07;
	Wed, 20 Aug 2025 15:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RmCChwoZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F8A82E05; Wed, 20 Aug 2025 15:23:29 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD5C28211F
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 15:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57KDNNd4257273;
 Wed, 20 Aug 2025 08:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755696204;
 bh=Tdu3MzASrJcS37Esuvm1ku4+q06TiW/WB4oqmcLzJjE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=RmCChwoZsS68U6l8ePcVJwgnW+UYV8IHicoNphMRK5x3yjhEKiMabmqB9GIbR2dZE
 GFV92BRDtGa8Rg4qmuUhDNpjaKo5i5Fxeu8YxqnhqY70PCnl7OQHR0yPn4Ds34U01t
 WkPqAeXbq3H3+fFKkF5KUN2blx9kgyFU/E3pED94=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57KDNN6u1380877
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 20 Aug 2025 08:23:23 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 08:23:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 08:23:23 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57KDNNLD277133;
 Wed, 20 Aug 2025 08:23:23 -0500
Date: Wed, 20 Aug 2025 08:23:23 -0500
From: Bryan Brattlof <bb@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] mach-k3: am62*: Fix backup from eMMC boot mode
Message-ID: <20250820132323.57xc7y24qeeyshjl@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250818174015.2879675-1-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250818174015.2879675-1-jm@ti.com>
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

On August 18, 2025 thus sayeth Judith Mendez:
> Currently logic in spl_mmc_boot_mode only lookes at main devstat
> to determine the bootmode to return. Thus, when using: 'eMMC boot'
> as primary boot mode and 'MMCSD boot from eMMC UDA' as backup
> boot mode, 'eMMC boot' is always selected. Add check for bootindex
> to determine if ROM boot via backup boot mode and return MMCSD_MODE_FS
> which is the only supported backup bootmode with eMMC device.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  arch/arm/mach-k3/am62ax/am62a7_init.c | 22 +++++++++++++---------
>  arch/arm/mach-k3/am62px/am62p5_init.c | 24 ++++++++++++++----------
>  arch/arm/mach-k3/am62x/am625_init.c   | 22 +++++++++++++---------
>  3 files changed, 40 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
> index 00173e6836b..fa3570d07ec 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -218,17 +218,21 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>  	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
>  			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
>  
> -	switch (bootmode) {
> -	case BOOT_DEVICE_EMMC:
> -		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
> +	if (bootindex == K3_PRIMARY_BOOTMODE) {
> +		switch (bootmode) {
> +		case BOOT_DEVICE_EMMC:
> +			if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
> +				return MMCSD_MODE_EMMCBOOT;
> +			if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
> +				return MMCSD_MODE_FS;
>  			return MMCSD_MODE_EMMCBOOT;
> -		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
> +		case BOOT_DEVICE_MMC:
> +			if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> +				return MMCSD_MODE_RAW;
> +		default:
>  			return MMCSD_MODE_FS;
> -		return MMCSD_MODE_EMMCBOOT;
> -	case BOOT_DEVICE_MMC:
> -		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> -			return MMCSD_MODE_RAW;
> -	default:
> +		}
> +	} else {
>  		return MMCSD_MODE_FS;

Is any warning given to us when we fall back to the UDA partition? How 
do people know their boot partition is dead? Could we bail out early 
with a message:

    if (bootindex != K3_PRIMARY_BOOTMODE) {
	    pr_alert("using MMC backup in UDA\n")
	    return MMCSD_MODE_FS;
    }

    switch (bootmode) {
    case BOOT_DEVICE_EMMC:

    ... bla bla bla ...

~Bryan
