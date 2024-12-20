Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D365AE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 19:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31F6680384;
	Fri, 20 Dec 2024 20:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UnsCIvC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C068803A9; Fri, 20 Dec 2024 20:45:29 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34CB980381
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 20:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BKJjPaO209482
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Dec 2024 13:45:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734723925;
 bh=5mtsKnNQG3rr6/HfWR+8ugsplbaSF7ZaDJWUmS/fa0Y=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=UnsCIvC3bAGVBT6Meog3kR6v1bibFqzr3qWydhvblsTURuMjeUjhbZIYelevHCFdD
 UkUadK3YBkOIRbIEzoRoiGSKHbbM2XJcQSesFT9dputI+469KHZsVw0as/CdMDz86t
 7Mtyxtmm5jFmTxzViZDLvQhc8Z7+1WqA+70LCzzs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BKJjPsB006890
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 20 Dec 2024 13:45:25 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 13:45:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 13:45:24 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BKJjOHB052868;
 Fri, 20 Dec 2024 13:45:24 -0600
Date: Fri, 20 Dec 2024 13:45:24 -0600
From: Bryan Brattlof <bb@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/7] mach-k3: am62a7_init: Add FS and raw mode for eMMC
Message-ID: <20241220194524.2tv7xm4sdanpmp4h@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20241220192220.2029543-1-jm@ti.com>
 <20241220192220.2029543-2-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20241220192220.2029543-2-jm@ti.com>
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

Hi Judith!

On December 20, 2024 thus sayeth Judith Mendez:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> This adds FS and raw boot mode support for eMMC similar to other K3
> platforms
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm/mach-k3/am62ax/am62a7_init.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Hmmm Are you on -next? this doesn't seem to apply :/

~Bryan

> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
> index 0f62f39075b..abf04970a2b 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -171,6 +171,25 @@ void board_init_f(ulong dummy)
>  	debug("am62a_init: %s done\n", __func__);
>  }
>  
> +u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
> +{
> +	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
> +	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
> +				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
> +	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
> +			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
> +
> +	switch (bootmode) {
> +	case BOOT_DEVICE_EMMC:
> +		return MMCSD_MODE_EMMCBOOT;
> +	case BOOT_DEVICE_MMC:
> +		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> +			return MMCSD_MODE_RAW;
> +	default:
> +		return MMCSD_MODE_FS;
> +	}
> +}
> +
>  static u32 __get_backup_bootmedia(u32 devstat)
>  {
>  	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
> -- 
> 2.47.1
> 
