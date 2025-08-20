Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765C5CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 04:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB9AD808AF;
	Wed, 20 Aug 2025 06:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BU08sItS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 782B7809A5; Wed, 20 Aug 2025 06:04:02 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D528006D
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 06:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57K43uaM161320;
 Tue, 19 Aug 2025 23:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755662636;
 bh=1KqpuVwPIEzSXApX3iPlVDeUagnYL6Z+ZC9hQmOv0Zw=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=BU08sItSxFUj12YF+SewUpyBfImbpdkhfv+8/nGeYsI3p4gXtX2wnS7KZN2JDJZ/f
 voi4SZNjDXYFtyst+dIoH3ysm/KFEC6pPTYfSlLjGbxEvhB4nDI7ty3CByvY1BbuVz
 vZLCQrKtCnC9ASQMexyv+o7C4MAAG8tv6XcfyvrY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57K43uoH1071611
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 19 Aug 2025 23:03:56 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 23:03:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 23:03:55 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57K43sbr3787389;
 Tue, 19 Aug 2025 23:03:55 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Aug 2025 09:32:47 +0530
Message-ID: <DC6YFT34VBJE.1U87BHIUTR8OE@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] mach-k3: am62*: Fix backup from eMMC boot mode
From: Anshul Dalal <anshuld@ti.com>
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250818174015.2879675-1-jm@ti.com>
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

Hi Judith,

On Mon Aug 18, 2025 at 11:10 PM IST, Judith Mendez wrote:
> Currently logic in spl_mmc_boot_mode only lookes at main devstat

Nit: s/lookes/looks

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
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am6=
2ax/am62a7_init.c
> index 00173e6836b..fa3570d07ec 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -218,17 +218,21 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 bo=
ot_device)
>  	u32 bootmode_cfg =3D (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK)=
 >>
>  			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
> =20
> -	switch (bootmode) {
> -	case BOOT_DEVICE_EMMC:
> -		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
> +	if (bootindex =3D=3D K3_PRIMARY_BOOTMODE) {
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
>  	}
>  }

[snip]

Just having a check for bootindex before the switch block would be more
readable imo, like:

if (bootindex !=3D K3_PRIMARY_BOOTMODE)
	return MMCSD_MODE_FS;

switch (bootmode) {
	<Existing code>
}

Regards,
Anshul
