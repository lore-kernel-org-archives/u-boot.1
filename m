Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07823CAC583
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 05:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F78683236;
	Thu, 11 Sep 2025 07:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EOn5tQtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D25F83280; Thu, 11 Sep 2025 07:11:25 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2C508319C
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 07:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58B5BKKN730398;
 Thu, 11 Sep 2025 00:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757567480;
 bh=/RUBP3/igT8JfoJGXsM5nWOqrSaOOTKrivedaQkv8v8=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=EOn5tQtlWPzIJs1iuXGgeS1/hWGqhGrrtyLcZ9iZ94RyC1nmqNmJY5T0a9XKfvm0c
 TXY+GZ0UuTPBptRMOKgFNmwjLGhJM11hyh+mXDgDr4suTKb69VgwwHKvqJ+ee5Imes
 ZiOuxSzA4dribfuU9RXk6pOHFlPKuut6ixRr30Ak=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58B5BJQN257430
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 00:11:20 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 00:11:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 00:11:19 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58B5BIYD1595869;
 Thu, 11 Sep 2025 00:11:18 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 11 Sep 2025 10:41:17 +0530
Message-ID: <DCPPO8O0GIVD.1CWNDWAKDGVEC@ti.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Vaishnav Achath" <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, "Moteen Shah" <m-shah@ti.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/4] arm: mach-k3: Fix MMC macros
From: Anshul Dalal <anshuld@ti.com>
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250910214514.1848847-1-jm@ti.com>
 <20250910214514.1848847-2-jm@ti.com>
In-Reply-To: <20250910214514.1848847-2-jm@ti.com>
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

On Thu Sep 11, 2025 at 3:15 AM IST, Judith Mendez wrote:
> For all K3 SoC's eMMC boot and MMCSD boot modes are supported. The macros
> however, mix MMC device with the two bootmodes. Decouple the two types
> of macros so that bootmodes can be identified with:
> - BOOT_DEVICE_MMCSD
> - BOOT_DEVICE_EMMC
> according to devstat parsed boot mode values and on-board devices can be
> identified with:
> - BOOT_DEVICE_MMC1
> - BOOT_DEVICE_MMC2
> - BOOT_DEVICE_MMC2_2
> according to arbitrary numbers mainly used to differentiate between eMMC
> and SD card.
>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---

I guess the confusion here is how we are calling boot modes from devstat
as well as the boot device as BOOT_DEVICE_*. Perhaps we should rename
the former to DEVSTAT_BOOT_MODE_* or something along those lines.

That would make the difference between a boot *mode* and a boot *device*
more clear, DEVSTAT_BOOT_MODE_MMCSD or DEVSTATE_BOOT_MODE_EMMC would
distinguish between SD or EMMC boot modes with BOOT_DEVICE_MMC*
indicating the MMC port used.

This would also allow use to only have the respective
DEVSTAT_BOOT_MODE_* defined in each soc's headers with BOOT_DEVICE_*
coming from arch/arm/include/asm/spl.h.

Regards,
Anshul

>  arch/arm/mach-k3/am62ax/am62a7_init.c          |  4 ++--
>  arch/arm/mach-k3/am62ax/boot.c                 |  8 ++++----
>  arch/arm/mach-k3/am62px/am62p5_init.c          | 12 ++++++------
>  arch/arm/mach-k3/am62x/am625_init.c            |  4 ++--
>  arch/arm/mach-k3/am62x/boot.c                  |  8 ++++----
>  arch/arm/mach-k3/am64x/boot.c                  |  8 ++++----
>  arch/arm/mach-k3/am65x/am654_init.c            | 18 ++++++++++--------
>  arch/arm/mach-k3/include/mach/am62_hardware.h  |  8 ++++----
>  arch/arm/mach-k3/include/mach/am62_spl.h       | 10 +++++-----
>  arch/arm/mach-k3/include/mach/am62a_hardware.h |  8 ++++----
>  arch/arm/mach-k3/include/mach/am62a_spl.h      | 10 +++++-----
>  arch/arm/mach-k3/include/mach/am62p_hardware.h |  8 ++++----
>  arch/arm/mach-k3/include/mach/am62p_spl.h      | 10 +++++-----
>  arch/arm/mach-k3/include/mach/am64_hardware.h  |  4 ++--
>  arch/arm/mach-k3/include/mach/am64_spl.h       | 13 +++++++------
>  arch/arm/mach-k3/include/mach/am6_hardware.h   |  8 ++++----
>  arch/arm/mach-k3/include/mach/am6_spl.h        | 13 +++++++++----
>  arch/arm/mach-k3/include/mach/j721e_hardware.h |  6 +++---
>  arch/arm/mach-k3/include/mach/j721e_spl.h      | 14 ++++++++++----
>  .../arm/mach-k3/include/mach/j721s2_hardware.h |  6 +++---
>  arch/arm/mach-k3/include/mach/j721s2_spl.h     | 13 +++++++++----
>  arch/arm/mach-k3/include/mach/j722s_hardware.h |  8 ++++----
>  arch/arm/mach-k3/include/mach/j722s_spl.h      | 10 +++++-----
>  .../arm/mach-k3/include/mach/j784s4_hardware.h |  6 +++---
>  arch/arm/mach-k3/include/mach/j784s4_spl.h     | 13 +++++++++----
>  arch/arm/mach-k3/j721e/j721e_init.c            | 14 +++++++++-----
>  arch/arm/mach-k3/j721s2/j721s2_init.c          | 14 +++++++++-----
>  arch/arm/mach-k3/j722s/j722s_init.c            | 12 ++++++------
>  arch/arm/mach-k3/j784s4/j784s4_init.c          | 14 +++++++++-----
>  29 files changed, 160 insertions(+), 124 deletions(-)
>
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am6=
2ax/am62a7_init.c
> index 00173e6836b..1fd466bbdfc 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -225,8 +225,8 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot=
_device)
>  		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
>  			return MMCSD_MODE_FS;
>  		return MMCSD_MODE_EMMCBOOT;
> -	case BOOT_DEVICE_MMC:
> -		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> +	case BOOT_DEVICE_MMCSD:
> +		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMCSD_FS_RAW_MASK)
>  			return MMCSD_MODE_RAW;
>  	default:
>  		return MMCSD_MODE_FS;
> diff --git a/arch/arm/mach-k3/am62ax/boot.c b/arch/arm/mach-k3/am62ax/boo=
t.c
> index af7fce1e5e9..808224108b9 100644
> --- a/arch/arm/mach-k3/am62ax/boot.c
> +++ b/arch/arm/mach-k3/am62ax/boot.c
> @@ -21,7 +21,7 @@ static u32 __get_backup_bootmedia(u32 devstat)
>  	case BACKUP_BOOT_DEVICE_ETHERNET:
>  		return BOOT_DEVICE_ETHERNET;
> =20
> -	case BACKUP_BOOT_DEVICE_MMC:
> +	case BACKUP_BOOT_DEVICE_MMCSD:
>  		if (bkup_bootmode_cfg)
>  			return BOOT_DEVICE_MMC2;
>  		return BOOT_DEVICE_MMC1;
> @@ -69,9 +69,9 @@ static u32 __get_primary_bootmedia(u32 devstat)
>  	case BOOT_DEVICE_SPI_NAND:
>  		return BOOT_DEVICE_SPINAND;
> =20
> -	case BOOT_DEVICE_MMC:
> -		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
> -				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
> +	case BOOT_DEVICE_MMCSD:
> +		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_MASK) >>
> +				MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_SHIFT)
>  			return BOOT_DEVICE_MMC2;
>  		return BOOT_DEVICE_MMC1;
> =20
> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am6=
2px/am62p5_init.c
> index 44a2d445d24..9574089325c 100644
> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
> @@ -271,8 +271,8 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot=
_device)
>  		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
>  			return MMCSD_MODE_FS;
>  		return MMCSD_MODE_EMMCBOOT;
> -	case BOOT_DEVICE_MMC:
> -		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> +	case BOOT_DEVICE_MMCSD:
> +		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMCSD_FS_RAW_MASK)
>  			return MMCSD_MODE_RAW;
>  		fallthrough;
>  	default:
> @@ -298,7 +298,7 @@ static u32 __get_backup_bootmedia(u32 devstat)
>  	case BACKUP_BOOT_DEVICE_ETHERNET:
>  		return BOOT_DEVICE_ETHERNET;
> =20
> -	case BACKUP_BOOT_DEVICE_MMC:
> +	case BACKUP_BOOT_DEVICE_MMCSD:
>  		if (bkup_bootmode_cfg)
>  			return BOOT_DEVICE_MMC2;
>  		return BOOT_DEVICE_MMC1;
> @@ -346,9 +346,9 @@ static u32 __get_primary_bootmedia(u32 devstat)
>  	case BOOT_DEVICE_SPI_NAND:
>  		return BOOT_DEVICE_SPINAND;
> =20
> -	case BOOT_DEVICE_MMC:
> -		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
> -				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
> +	case BOOT_DEVICE_MMCSD:
> +		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_MASK) >>
> +				MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_SHIFT)
>  			return BOOT_DEVICE_MMC2;
>  		return BOOT_DEVICE_MMC1;
> =20
> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x=
/am625_init.c
> index 8f4ddf59753..46da9ba8850 100644
> --- a/arch/arm/mach-k3/am62x/am625_init.c
> +++ b/arch/arm/mach-k3/am62x/am625_init.c
> @@ -312,8 +312,8 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot=
_device)
>  		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
>  			return MMCSD_MODE_FS;
>  		return MMCSD_MODE_EMMCBOOT;
> -	case BOOT_DEVICE_MMC:
> -		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> +	case BOOT_DEVICE_MMCSD:
> +		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMCSD_FS_RAW_MASK)
>  			return MMCSD_MODE_RAW;
>  	default:
>  		return MMCSD_MODE_FS;
> diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/boot.=
c
> index a3a6cda6bdb..c5f6dcea2b9 100644
> --- a/arch/arm/mach-k3/am62x/boot.c
> +++ b/arch/arm/mach-k3/am62x/boot.c
> @@ -21,7 +21,7 @@ static u32 __get_backup_bootmedia(u32 devstat)
>  	case BACKUP_BOOT_DEVICE_ETHERNET:
>  		return BOOT_DEVICE_ETHERNET;
> =20
> -	case BACKUP_BOOT_DEVICE_MMC:
> +	case BACKUP_BOOT_DEVICE_MMCSD:
>  		if (bkup_bootmode_cfg)
>  			return BOOT_DEVICE_MMC2;
>  		return BOOT_DEVICE_MMC1;
> @@ -66,9 +66,9 @@ static u32 __get_primary_bootmedia(u32 devstat)
>  	case BOOT_DEVICE_EMMC:
>  		return BOOT_DEVICE_MMC1;
> =20
> -	case BOOT_DEVICE_MMC:
> -		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
> -				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
> +	case BOOT_DEVICE_MMCSD:
> +		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_MASK) >>
> +				MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_SHIFT)
>  			return BOOT_DEVICE_MMC2;
>  		return BOOT_DEVICE_MMC1;
> =20
> diff --git a/arch/arm/mach-k3/am64x/boot.c b/arch/arm/mach-k3/am64x/boot.=
c
> index ce8ae941be6..6145c09bab5 100644
> --- a/arch/arm/mach-k3/am64x/boot.c
> +++ b/arch/arm/mach-k3/am64x/boot.c
> @@ -24,7 +24,7 @@ static u32 __get_backup_bootmedia(u32 main_devstat)
>  	case BACKUP_BOOT_DEVICE_ETHERNET:
>  		return BOOT_DEVICE_ETHERNET;
> =20
> -	case BACKUP_BOOT_DEVICE_MMC:
> +	case BACKUP_BOOT_DEVICE_MMCSD:
>  		if (bkup_bootmode_cfg)
>  			return BOOT_DEVICE_MMC2;
>  		return BOOT_DEVICE_MMC1;
> @@ -68,9 +68,9 @@ static u32 __get_primary_bootmedia(u32 main_devstat)
>  	case BOOT_DEVICE_NAND:
>  		return BOOT_DEVICE_NAND;
> =20
> -	case BOOT_DEVICE_MMC:
> -		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
> -		     MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
> +	case BOOT_DEVICE_MMCSD:
> +		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_MASK) >>
> +		     MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_SHIFT)
>  			return BOOT_DEVICE_MMC2;
>  		return BOOT_DEVICE_MMC1;
> =20
> diff --git a/arch/arm/mach-k3/am65x/am654_init.c b/arch/arm/mach-k3/am65x=
/am654_init.c
> index a4f038029d7..9fcea12d243 100644
> --- a/arch/arm/mach-k3/am65x/am654_init.c
> +++ b/arch/arm/mach-k3/am65x/am654_init.c
> @@ -272,7 +272,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot=
_device)
> =20
>  	/* eMMC boot0 mode is only supported for primary boot */
>  	if (bootindex =3D=3D K3_PRIMARY_BOOTMODE &&
> -	    bootmode =3D=3D BOOT_DEVICE_MMC1)
> +	    bootmode =3D=3D BOOT_DEVICE_EMMC)
>  		return MMCSD_MODE_EMMCBOOT;
>  #endif
> =20
> @@ -296,10 +296,10 @@ static u32 __get_backup_bootmedia(u32 devstat)
>  		return BOOT_DEVICE_UART;
>  	case BACKUP_BOOT_DEVICE_ETHERNET:
>  		return BOOT_DEVICE_ETHERNET;
> -	case BACKUP_BOOT_DEVICE_MMC2:
> +	case BACKUP_BOOT_DEVICE_MMCSD:
>  	{
> -		u32 port =3D (devstat & CTRLMMR_MAIN_DEVSTAT_BKUP_MMC_PORT_MASK) >>
> -			    CTRLMMR_MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT;
> +		u32 port =3D (devstat & CTRLMMR_MAIN_DEVSTAT_BKUP_MMCSD_PORT_MASK) >>
> +			    CTRLMMR_MAIN_DEVSTAT_BKUP_MMCSD_PORT_SHIFT;
>  		if (port =3D=3D 0x0)
>  			return BOOT_DEVICE_MMC1;
>  		return BOOT_DEVICE_MMC2;
> @@ -323,12 +323,14 @@ static u32 __get_primary_bootmedia(u32 devstat)
>  	if (bootmode =3D=3D BOOT_DEVICE_OSPI || bootmode =3D=3D	BOOT_DEVICE_QSP=
I)
>  		bootmode =3D BOOT_DEVICE_SPI;
> =20
> -	if (bootmode =3D=3D BOOT_DEVICE_MMC2) {
> -		u32 port =3D (devstat & CTRLMMR_MAIN_DEVSTAT_MMC_PORT_MASK) >>
> -			    CTRLMMR_MAIN_DEVSTAT_MMC_PORT_SHIFT;
> +	if (bootmode =3D=3D BOOT_DEVICE_MMCSD) {
> +		bootmode =3D BOOT_DEVICE_MMC2;
> +		u32 port =3D (devstat & CTRLMMR_MAIN_DEVSTAT_MMCSD_PORT_MASK) >>
> +			    CTRLMMR_MAIN_DEVSTAT_MMCSD_PORT_SHIFT;
>  		if (port =3D=3D 0x0)
>  			bootmode =3D BOOT_DEVICE_MMC1;
> -	} else if (bootmode =3D=3D BOOT_DEVICE_MMC1) {
> +	} else if (bootmode =3D=3D BOOT_DEVICE_EMMC) {
> +		bootmode =3D BOOT_DEVICE_MMC1;
>  		u32 port =3D (devstat & CTRLMMR_MAIN_DEVSTAT_EMMC_PORT_MASK) >>
>  			    CTRLMMR_MAIN_DEVSTAT_EMMC_PORT_SHIFT;
>  		if (port =3D=3D 0x1)
> diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mac=
h-k3/include/mach/am62_hardware.h
> index 2f5655bf24a..94f2208cf52 100644
> --- a/arch/arm/mach-k3/include/mach/am62_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
> @@ -58,10 +58,10 @@
>  #define RST_CTRL_ESM_ERROR_RST_EN_Z_MASK	(~BIT(17))
> =20
>  /* Primary Bootmode MMC Config macros */
> -#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK	0x4
> -#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT	2
> -#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK	0x1
> -#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_SHIFT	0
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_MASK		0x4
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_SHIFT		2
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_FS_RAW_MASK		0x1
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_FS_RAW_SHIFT	0
> =20
>  /* Primary Bootmode USB Config macros */
>  #define MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT	1
> diff --git a/arch/arm/mach-k3/include/mach/am62_spl.h b/arch/arm/mach-k3/=
include/mach/am62_spl.h
> index 2c9139d2cc0..8df53ac38bb 100644
> --- a/arch/arm/mach-k3/include/mach/am62_spl.h
> +++ b/arch/arm/mach-k3/include/mach/am62_spl.h
> @@ -17,7 +17,7 @@
>  #define BOOT_DEVICE_ETHERNET_RMII	0x05
>  #define BOOT_DEVICE_I2C			0x06
>  #define BOOT_DEVICE_UART		0x07
> -#define BOOT_DEVICE_MMC			0x08
> +#define BOOT_DEVICE_MMCSD			0x08
>  #define BOOT_DEVICE_EMMC		0x09
> =20
>  #define BOOT_DEVICE_USB			0x2A
> @@ -29,16 +29,16 @@
> =20
>  /* U-Boot used aliases */
>  #define BOOT_DEVICE_ETHERNET		0x04
> -#define BOOT_DEVICE_MMC2		0x08
> -#define BOOT_DEVICE_MMC1		0x09
> +#define BOOT_DEVICE_MMC1		0xFF0
> +#define BOOT_DEVICE_MMC2		0xFF1
>  /* Invalid */
> -#define BOOT_DEVICE_MMC2_2		0x1F
> +#define BOOT_DEVICE_MMC2_2		0xFF2
> =20
>  /* Backup BootMode devices */
>  #define BACKUP_BOOT_DEVICE_DFU		0x01
>  #define BACKUP_BOOT_DEVICE_UART		0x03
>  #define BACKUP_BOOT_DEVICE_ETHERNET	0x04
> -#define BACKUP_BOOT_DEVICE_MMC		0x05
> +#define BACKUP_BOOT_DEVICE_MMCSD	0x05
>  #define BACKUP_BOOT_DEVICE_SPI		0x06
>  #define BACKUP_BOOT_DEVICE_I2C		0x07
>  #define BACKUP_BOOT_DEVICE_USB		0x09
> diff --git a/arch/arm/mach-k3/include/mach/am62a_hardware.h b/arch/arm/ma=
ch-k3/include/mach/am62a_hardware.h
> index f3fd736f31b..7f715d6a7ab 100644
> --- a/arch/arm/mach-k3/include/mach/am62a_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am62a_hardware.h
> @@ -30,10 +30,10 @@
>  #define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT	13
> =20
>  /* Primary Bootmode MMC Config macros */
> -#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK	0x4
> -#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT	2
> -#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK	0x1
> -#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_SHIFT	0
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_MASK		0x4
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_SHIFT		2
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_FS_RAW_MASK		0x1
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_FS_RAW_SHIFT	0
> =20
>  /* Primary Bootmode USB Config macros */
>  #define MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT	1
> diff --git a/arch/arm/mach-k3/include/mach/am62a_spl.h b/arch/arm/mach-k3=
/include/mach/am62a_spl.h
> index dd0f57714f5..323b9d404aa 100644
> --- a/arch/arm/mach-k3/include/mach/am62a_spl.h
> +++ b/arch/arm/mach-k3/include/mach/am62a_spl.h
> @@ -17,7 +17,7 @@
>  #define BOOT_DEVICE_ETHERNET_RMII	0x05
>  #define BOOT_DEVICE_I2C			0x06
>  #define BOOT_DEVICE_UART		0x07
> -#define BOOT_DEVICE_MMC			0x08
> +#define BOOT_DEVICE_MMCSD			0x08
>  #define BOOT_DEVICE_EMMC		0x09
> =20
>  #define BOOT_DEVICE_USB			0x2A
> @@ -30,16 +30,16 @@
>  /* U-Boot used aliases */
>  #define BOOT_DEVICE_ETHERNET		0x04
>  #define BOOT_DEVICE_SPINAND		0x10
> -#define BOOT_DEVICE_MMC2		0x08
> -#define BOOT_DEVICE_MMC1		0x09
> +#define BOOT_DEVICE_MMC1		0xFF0
> +#define BOOT_DEVICE_MMC2		0xFF1
>  /* Invalid */
> -#define BOOT_DEVICE_MMC2_2		0x1F
> +#define BOOT_DEVICE_MMC2_2		0xFF2
> =20
>  /* Backup BootMode devices */
>  #define BACKUP_BOOT_DEVICE_DFU		0x01
>  #define BACKUP_BOOT_DEVICE_UART		0x03
>  #define BACKUP_BOOT_DEVICE_ETHERNET	0x04
> -#define BACKUP_BOOT_DEVICE_MMC		0x05
> +#define BACKUP_BOOT_DEVICE_MMCSD	0x05
>  #define BACKUP_BOOT_DEVICE_SPI		0x06
>  #define BACKUP_BOOT_DEVICE_I2C		0x07
>  #define BACKUP_BOOT_DEVICE_USB		0x09
> diff --git a/arch/arm/mach-k3/include/mach/am62p_hardware.h b/arch/arm/ma=
ch-k3/include/mach/am62p_hardware.h
> index a310b52b45d..984c10719e1 100644
> --- a/arch/arm/mach-k3/include/mach/am62p_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am62p_hardware.h
> @@ -46,10 +46,10 @@
>  #define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT	13
> =20
>  /* Primary Bootmode MMC Config macros */
> -#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK	0x4
> -#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT	2
> -#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK	0x1
> -#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_SHIFT	0
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_MASK		0x4
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_SHIFT		2
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_FS_RAW_MASK		0x1
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_FS_RAW_SHIFT	0
> =20
>  /* Primary Bootmode USB Config macros */
>  #define MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT	1
> diff --git a/arch/arm/mach-k3/include/mach/am62p_spl.h b/arch/arm/mach-k3=
/include/mach/am62p_spl.h
> index db145a7bc83..0ddcacd912b 100644
> --- a/arch/arm/mach-k3/include/mach/am62p_spl.h
> +++ b/arch/arm/mach-k3/include/mach/am62p_spl.h
> @@ -17,7 +17,7 @@
>  #define BOOT_DEVICE_ETHERNET_RMII	0x05
>  #define BOOT_DEVICE_I2C			0x06
>  #define BOOT_DEVICE_UART		0x07
> -#define BOOT_DEVICE_MMC			0x08
> +#define BOOT_DEVICE_MMCSD			0x08
>  #define BOOT_DEVICE_EMMC		0x09
> =20
>  #define BOOT_DEVICE_USB			0x2A
> @@ -30,16 +30,16 @@
>  /* U-Boot used aliases */
>  #define BOOT_DEVICE_ETHERNET		0x04
>  #define BOOT_DEVICE_SPINAND		0x10
> -#define BOOT_DEVICE_MMC2		0x08
> -#define BOOT_DEVICE_MMC1		0x09
> +#define BOOT_DEVICE_MMC1		0xFF0
> +#define BOOT_DEVICE_MMC2		0xFF1
>  /* Invalid */
> -#define BOOT_DEVICE_MMC2_2		0x1F
> +#define BOOT_DEVICE_MMC2_2		0xFF2
> =20
>  /* Backup BootMode devices */
>  #define BACKUP_BOOT_DEVICE_DFU		0x01
>  #define BACKUP_BOOT_DEVICE_UART		0x03
>  #define BACKUP_BOOT_DEVICE_ETHERNET	0x04
> -#define BACKUP_BOOT_DEVICE_MMC		0x05
> +#define BACKUP_BOOT_DEVICE_MMCSD	0x05
>  #define BACKUP_BOOT_DEVICE_SPI		0x06
>  #define BACKUP_BOOT_DEVICE_I2C		0x07
>  #define BACKUP_BOOT_DEVICE_USB		0x09
> diff --git a/arch/arm/mach-k3/include/mach/am64_hardware.h b/arch/arm/mac=
h-k3/include/mach/am64_hardware.h
> index 105b42986de..67dc4eeb82f 100644
> --- a/arch/arm/mach-k3/include/mach/am64_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am64_hardware.h
> @@ -33,8 +33,8 @@
>  #define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT		13
> =20
>  /* After the cfg mask and shifts have been applied */
> -#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT		2
> -#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK		0x04
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_SHIFT		2
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_MASK		0x04
> =20
>  #define MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT		1
>  #define MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK		0x02
> diff --git a/arch/arm/mach-k3/include/mach/am64_spl.h b/arch/arm/mach-k3/=
include/mach/am64_spl.h
> index a0a517019cb..9bd14d3679d 100644
> --- a/arch/arm/mach-k3/include/mach/am64_spl.h
> +++ b/arch/arm/mach-k3/include/mach/am64_spl.h
> @@ -17,7 +17,7 @@
>  #define BOOT_DEVICE_ETHERNET_RMII	0x05
>  #define BOOT_DEVICE_I2C			0x06
>  #define BOOT_DEVICE_UART		0x07
> -#define BOOT_DEVICE_MMC			0x08
> +#define BOOT_DEVICE_MMCSD			0x08
>  #define BOOT_DEVICE_EMMC		0x09
> =20
>  #define BOOT_DEVICE_USB			0x2A
> @@ -29,16 +29,17 @@
> =20
>  #define BOOT_DEVICE_NOBOOT		0x0F
> =20
> -#define BOOT_DEVICE_MMC2		0x08
> -#define BOOT_DEVICE_MMC1		0x09
> -/* INVALID */
> -#define BOOT_DEVICE_MMC2_2		0x1F
> +/* U-Boot used aliases */
> +#define BOOT_DEVICE_MMC1		0xFF0
> +#define BOOT_DEVICE_MMC2		0xFF1
> +/* Invalid */
> +#define BOOT_DEVICE_MMC2_2		0xFF2
> =20
>  /* Backup BootMode devices */
>  #define BACKUP_BOOT_DEVICE_DFU		0x01
>  #define BACKUP_BOOT_DEVICE_UART		0x03
>  #define BACKUP_BOOT_DEVICE_ETHERNET	0x04
> -#define BACKUP_BOOT_DEVICE_MMC		0x05
> +#define BACKUP_BOOT_DEVICE_MMCSD	0x05
>  #define BACKUP_BOOT_DEVICE_SPI		0x06
>  #define BACKUP_BOOT_DEVICE_I2C		0x07
>  #define BACKUP_BOOT_DEVICE_USB		0x09
> diff --git a/arch/arm/mach-k3/include/mach/am6_hardware.h b/arch/arm/mach=
-k3/include/mach/am6_hardware.h
> index 8169584a372..008f80ae526 100644
> --- a/arch/arm/mach-k3/include/mach/am6_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am6_hardware.h
> @@ -21,12 +21,12 @@
>  #define CTRLMMR_MAIN_DEVSTAT_BOOTMODE_SHIFT		0
>  #define CTRLMMR_MAIN_DEVSTAT_BKUP_BOOTMODE_MASK		GENMASK(6, 4)
>  #define CTRLMMR_MAIN_DEVSTAT_BKUP_BOOTMODE_SHIFT	4
> -#define CTRLMMR_MAIN_DEVSTAT_MMC_PORT_MASK		GENMASK(12, 12)
> -#define CTRLMMR_MAIN_DEVSTAT_MMC_PORT_SHIFT		12
> +#define CTRLMMR_MAIN_DEVSTAT_MMCSD_PORT_MASK		GENMASK(12, 12)
> +#define CTRLMMR_MAIN_DEVSTAT_MMCSD_PORT_SHIFT		12
>  #define CTRLMMR_MAIN_DEVSTAT_EMMC_PORT_MASK		GENMASK(14, 14)
>  #define CTRLMMR_MAIN_DEVSTAT_EMMC_PORT_SHIFT		14
> -#define CTRLMMR_MAIN_DEVSTAT_BKUP_MMC_PORT_MASK		GENMASK(17, 17)
> -#define CTRLMMR_MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT	12
> +#define CTRLMMR_MAIN_DEVSTAT_BKUP_MMCSD_PORT_MASK		GENMASK(17, 17)
> +#define CTRLMMR_MAIN_DEVSTAT_BKUP_MMCSD_PORT_SHIFT	12
>  #define CTRLMMR_MAIN_DEVSTAT_USB_MODE_SHIFT		9
>  #define CTRLMMR_MAIN_DEVSTAT_USB_MODE_MASK		GENMASK(10, 9)
> =20
> diff --git a/arch/arm/mach-k3/include/mach/am6_spl.h b/arch/arm/mach-k3/i=
nclude/mach/am6_spl.h
> index 4c6950ff2b7..b7fa2f8d8b9 100644
> --- a/arch/arm/mach-k3/include/mach/am6_spl.h
> +++ b/arch/arm/mach-k3/include/mach/am6_spl.h
> @@ -12,21 +12,26 @@
>  #define BOOT_DEVICE_HYPERFLASH		0x03
>  #define BOOT_DEVICE_SPI			0x04
>  #define BOOT_DEVICE_I2C			0x05
> -#define BOOT_DEVICE_MMC2		0x06
> +#define BOOT_DEVICE_MMCSD		0x06
>  #define BOOT_DEVICE_ETHERNET		0x07
>  #define BOOT_DEVICE_DFU			0x08
>  #define BOOT_DEVICE_USB			0x408
>  #define BOOT_DEVICE_PCIE		0x09
>  #define BOOT_DEVICE_UART		0x0a
>  #define BOOT_DEVICE_NAND		0x0c
> -#define BOOT_DEVICE_MMC1		0x0d
> -#define BOOT_DEVICE_MMC2_2		0x0e
> +#define BOOT_DEVICE_EMMC		0x0d
> +
> +/* U-Boot used aliases */
> +#define BOOT_DEVICE_MMC1		0xFF0
> +#define BOOT_DEVICE_MMC2		0xFF1
> +/* Invalid */
> +#define BOOT_DEVICE_MMC2_2		0xFF2
> =20
>  #define BACKUP_BOOT_DEVICE_RAM		0x0
>  #define BACKUP_BOOT_DEVICE_USB		0x1
>  #define BACKUP_BOOT_DEVICE_UART		0x2
>  #define BACKUP_BOOT_DEVICE_ETHERNET	0x3
> -#define BACKUP_BOOT_DEVICE_MMC2		0x4
> +#define BACKUP_BOOT_DEVICE_MMCSD		0x4
>  #define BACKUP_BOOT_DEVICE_SPI		0x5
>  #define BACKUP_BOOT_DEVICE_HYPERFLASH	0x6
>  #define BACKUP_BOOT_DEVICE_I2C		0x7
> diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/ma=
ch-k3/include/mach/j721e_hardware.h
> index 5bef309af0a..341e9c28d81 100644
> --- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
> @@ -20,10 +20,10 @@
>  #define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT		0
>  #define MAIN_DEVSTAT_BKUP_BOOTMODE_MASK		GENMASK(3, 1)
>  #define MAIN_DEVSTAT_BKUP_BOOTMODE_SHIFT	1
> -#define MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK	BIT(6)
> +#define MAIN_DEVSTAT_PRIM_BOOTMODE_MMCSD_PORT_MASK	BIT(6)
>  #define MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT		6
> -#define MAIN_DEVSTAT_BKUP_MMC_PORT_MASK			BIT(7)
> -#define MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT		7
> +#define MAIN_DEVSTAT_BKUP_MMCSD_PORT_MASK			BIT(7)
> +#define MAIN_DEVSTAT_BKUP_MMCSD_PORT_SHIFT		7
> =20
>  #define CTRLMMR_WKUP_DEVSTAT			(WKUP_CTRL_MMR0_BASE + 0x30)
>  #define WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK	GENMASK(5, 3)
> diff --git a/arch/arm/mach-k3/include/mach/j721e_spl.h b/arch/arm/mach-k3=
/include/mach/j721e_spl.h
> index aaee6535376..008595b7f26 100644
> --- a/arch/arm/mach-k3/include/mach/j721e_spl.h
> +++ b/arch/arm/mach-k3/include/mach/j721e_spl.h
> @@ -18,22 +18,28 @@
>  #define BOOT_DEVICE_NOR			BOOT_DEVICE_HYPERFLASH
> =20
>  /* With BootMode B =3D 1 */
> -#define BOOT_DEVICE_MMC2		0x10
> -#define BOOT_DEVICE_MMC1		0x11
> +#define BOOT_DEVICE_MMCSD		0x10
> +#define BOOT_DEVICE_EMMC		0x11
>  #define BOOT_DEVICE_DFU			0x12
>  #define BOOT_DEVICE_UFS			0x13
>  #define BOOT_DEVIE_GPMC			0x14
>  #define BOOT_DEVICE_PCIE		0x15
>  #define BOOT_DEVICE_XSPI 		0x16
>  #define BOOT_DEVICE_RAM 		0x17
> -#define BOOT_DEVICE_MMC2_2 		0xFF /* Invalid value */
> +
> + /* U-Boot used aliases */
> +#define BOOT_DEVICE_MMC1               0xFF0
> +#define BOOT_DEVICE_MMC2               0xFF1
> + /* Invalid */
> +#define BOOT_DEVICE_MMC2_2             0xFF2
> +
> =20
>  /* Backup boot modes with MCU Only =3D 0 */
>  #define BACKUP_BOOT_DEVICE_RAM		0x0
>  #define BACKUP_BOOT_DEVICE_USB		0x1
>  #define BACKUP_BOOT_DEVICE_UART		0x3
>  #define BACKUP_BOOT_DEVICE_ETHERNET	0x4
> -#define BACKUP_BOOT_DEVICE_MMC2		0x5
> +#define BACKUP_BOOT_DEVICE_MMCSD		0x5
>  #define BACKUP_BOOT_DEVICE_SPI		0x6
>  #define BACKUP_BOOT_DEVICE_I2C		0x7
> =20
> diff --git a/arch/arm/mach-k3/include/mach/j721s2_hardware.h b/arch/arm/m=
ach-k3/include/mach/j721s2_hardware.h
> index 82f076a45e0..f2a3140e0b6 100644
> --- a/arch/arm/mach-k3/include/mach/j721s2_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
> @@ -20,10 +20,10 @@
>  #define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT			0
>  #define MAIN_DEVSTAT_BKUP_BOOTMODE_MASK			GENMASK(3, 1)
>  #define MAIN_DEVSTAT_BKUP_BOOTMODE_SHIFT		1
> -#define MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK	BIT(6)
> +#define MAIN_DEVSTAT_PRIM_BOOTMODE_MMCSD_PORT_MASK	BIT(6)
>  #define MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT		6
> -#define MAIN_DEVSTAT_BKUP_MMC_PORT_MASK			BIT(7)
> -#define MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT		7
> +#define MAIN_DEVSTAT_BKUP_MMCSD_PORT_MASK			BIT(7)
> +#define MAIN_DEVSTAT_BKUP_MMCSD_PORT_SHIFT		7
> =20
>  #define CTRLMMR_WKUP_DEVSTAT				(WKUP_CTRL_MMR0_BASE + 0x30)
>  #define WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK		GENMASK(5, 3)
> diff --git a/arch/arm/mach-k3/include/mach/j721s2_spl.h b/arch/arm/mach-k=
3/include/mach/j721s2_spl.h
> index 47a61281d94..5ede79b6744 100644
> --- a/arch/arm/mach-k3/include/mach/j721s2_spl.h
> +++ b/arch/arm/mach-k3/include/mach/j721s2_spl.h
> @@ -19,22 +19,27 @@
>  #define BOOT_DEVICE_NOR			BOOT_DEVICE_HYPERFLASH
> =20
>  /* With BootMode B =3D 1 */
> -#define BOOT_DEVICE_MMC2		0x10
> -#define BOOT_DEVICE_MMC1		0x11
> +#define BOOT_DEVICE_MMCSD		0x10
> +#define BOOT_DEVICE_EMMC		0x11
>  #define BOOT_DEVICE_DFU			0x12
>  #define BOOT_DEVICE_UFS			0x13
>  #define BOOT_DEVIE_GPMC			0x14
>  #define BOOT_DEVICE_PCIE		0x15
>  #define BOOT_DEVICE_XSPI		0x16
>  #define BOOT_DEVICE_RAM			0x17
> -#define BOOT_DEVICE_MMC2_2		0xFF /* Invalid value */
> +
> +/* U-Boot used aliases */
> +#define BOOT_DEVICE_MMC1		0xFF0
> +#define BOOT_DEVICE_MMC2		0xFF1
> +/* Invalid */
> +#define BOOT_DEVICE_MMC2_2		0xFF2
> =20
>  /* Backup boot modes with MCU Only =3D 0 */
>  #define BACKUP_BOOT_DEVICE_RAM		0x0
>  #define BACKUP_BOOT_DEVICE_USB		0x1
>  #define BACKUP_BOOT_DEVICE_UART		0x3
>  #define BACKUP_BOOT_DEVICE_ETHERNET	0x4
> -#define BACKUP_BOOT_DEVICE_MMC2		0x5
> +#define BACKUP_BOOT_DEVICE_MMCSD		0x5
>  #define BACKUP_BOOT_DEVICE_SPI		0x6
>  #define BACKUP_BOOT_DEVICE_I2C		0x7
> =20
> diff --git a/arch/arm/mach-k3/include/mach/j722s_hardware.h b/arch/arm/ma=
ch-k3/include/mach/j722s_hardware.h
> index 0c695134c28..77b455af09a 100644
> --- a/arch/arm/mach-k3/include/mach/j722s_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j722s_hardware.h
> @@ -30,10 +30,10 @@
>  #define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT	13
> =20
>  /* Primary Bootmode MMC Config macros */
> -#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK	0x4
> -#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT	2
> -#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK	0x1
> -#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_SHIFT	0
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_MASK		0x4
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_SHIFT		2
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_FS_RAW_MASK		0x1
> +#define MAIN_DEVSTAT_PRIMARY_MMCSD_FS_RAW_SHIFT	0
> =20
>  /* Primary Bootmode USB Config macros */
>  #define MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT	1
> diff --git a/arch/arm/mach-k3/include/mach/j722s_spl.h b/arch/arm/mach-k3=
/include/mach/j722s_spl.h
> index a91cc82448f..aea43eeb23c 100644
> --- a/arch/arm/mach-k3/include/mach/j722s_spl.h
> +++ b/arch/arm/mach-k3/include/mach/j722s_spl.h
> @@ -17,7 +17,7 @@
>  #define BOOT_DEVICE_ETHERNET_RMII	0x05
>  #define BOOT_DEVICE_I2C			0x06
>  #define BOOT_DEVICE_UART		0x07
> -#define BOOT_DEVICE_MMC			0x08
> +#define BOOT_DEVICE_MMCSD			0x08
>  #define BOOT_DEVICE_EMMC		0x09
> =20
>  #define BOOT_DEVICE_USB			0x2A
> @@ -31,16 +31,16 @@
>  /* U-Boot used aliases */
>  #define BOOT_DEVICE_ETHERNET		0x04
>  #define BOOT_DEVICE_SPINAND		0x10
> -#define BOOT_DEVICE_MMC2		0x08
> -#define BOOT_DEVICE_MMC1		0x09
> +#define BOOT_DEVICE_MMC1		0xFF0
> +#define BOOT_DEVICE_MMC2		0xFF1
>  /* Invalid */
> -#define BOOT_DEVICE_MMC2_2		0x1F
> +#define BOOT_DEVICE_MMC2_2		0xFF2
> =20
>  /* Backup BootMode devices */
>  #define BACKUP_BOOT_DEVICE_DFU		0x01
>  #define BACKUP_BOOT_DEVICE_UART		0x03
>  #define BACKUP_BOOT_DEVICE_ETHERNET	0x04
> -#define BACKUP_BOOT_DEVICE_MMC		0x05
> +#define BACKUP_BOOT_DEVICE_MMCSD	0x05
>  #define BACKUP_BOOT_DEVICE_SPI		0x06
>  #define BACKUP_BOOT_DEVICE_I2C		0x07
>  #define BACKUP_BOOT_DEVICE_USB		0x09
> diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/m=
ach-k3/include/mach/j784s4_hardware.h
> index 29a894baed3..e8e2037f804 100644
> --- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> @@ -20,10 +20,10 @@
>  #define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT			0
>  #define MAIN_DEVSTAT_BKUP_BOOTMODE_MASK			GENMASK(3, 1)
>  #define MAIN_DEVSTAT_BKUP_BOOTMODE_SHIFT		1
> -#define MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK	BIT(6)
> +#define MAIN_DEVSTAT_PRIM_BOOTMODE_MMCSD_PORT_MASK	BIT(6)
>  #define MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT		6
> -#define MAIN_DEVSTAT_BKUP_MMC_PORT_MASK			BIT(7)
> -#define MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT		7
> +#define MAIN_DEVSTAT_BKUP_MMCSD_PORT_MASK			BIT(7)
> +#define MAIN_DEVSTAT_BKUP_MMCSD_PORT_SHIFT		7
> =20
>  #define CTRLMMR_WKUP_DEVSTAT				(WKUP_CTRL_MMR0_BASE + 0x30)
>  #define WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK		GENMASK(5, 3)
> diff --git a/arch/arm/mach-k3/include/mach/j784s4_spl.h b/arch/arm/mach-k=
3/include/mach/j784s4_spl.h
> index 3814dc95d01..0871a85d0c5 100644
> --- a/arch/arm/mach-k3/include/mach/j784s4_spl.h
> +++ b/arch/arm/mach-k3/include/mach/j784s4_spl.h
> @@ -19,22 +19,27 @@
>  #define BOOT_DEVICE_NOR			BOOT_DEVICE_HYPERFLASH
> =20
>  /* With BootMode B =3D 1 */
> -#define BOOT_DEVICE_MMC2		0x10
> -#define BOOT_DEVICE_MMC1		0x11
> +#define BOOT_DEVICE_MMCSD		0x10
> +#define BOOT_DEVICE_EMMC		0x11
>  #define BOOT_DEVICE_DFU			0x12
>  #define BOOT_DEVICE_UFS			0x13
>  #define BOOT_DEVIE_GPMC			0x14
>  #define BOOT_DEVICE_PCIE		0x15
>  #define BOOT_DEVICE_XSPI		0x16
>  #define BOOT_DEVICE_RAM			0x17
> -#define BOOT_DEVICE_MMC2_2		0xFF /* Invalid value */
> +
> +/* U-Boot used aliases */
> +#define BOOT_DEVICE_MMC1		0xFF0
> +#define BOOT_DEVICE_MMC2		0xFF1
> +/* Invalid */
> +#define BOOT_DEVICE_MMC2_2		0xFF2
> =20
>  /* Backup boot modes with MCU Only =3D 0 */
>  #define BACKUP_BOOT_DEVICE_RAM		0x0
>  #define BACKUP_BOOT_DEVICE_USB		0x1
>  #define BACKUP_BOOT_DEVICE_UART		0x3
>  #define BACKUP_BOOT_DEVICE_ETHERNET	0x4
> -#define BACKUP_BOOT_DEVICE_MMC2		0x5
> +#define BACKUP_BOOT_DEVICE_MMCSD		0x5
>  #define BACKUP_BOOT_DEVICE_SPI		0x6
>  #define BACKUP_BOOT_DEVICE_I2C		0x7
> =20
> diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e=
/j721e_init.c
> index f9af0288cf6..30087705334 100644
> --- a/arch/arm/mach-k3/j721e/j721e_init.c
> +++ b/arch/arm/mach-k3/j721e/j721e_init.c
> @@ -450,10 +450,10 @@ static u32 __get_backup_bootmedia(u32 main_devstat)
>  		return BOOT_DEVICE_UART;
>  	case BACKUP_BOOT_DEVICE_ETHERNET:
>  		return BOOT_DEVICE_ETHERNET;
> -	case BACKUP_BOOT_DEVICE_MMC2:
> +	case BACKUP_BOOT_DEVICE_MMCSD:
>  	{
> -		u32 port =3D (main_devstat & MAIN_DEVSTAT_BKUP_MMC_PORT_MASK) >>
> -			    MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT;
> +		u32 port =3D (main_devstat & MAIN_DEVSTAT_BKUP_MMCSD_PORT_MASK) >>
> +			    MAIN_DEVSTAT_BKUP_MMCSD_PORT_SHIFT;
>  		if (port =3D=3D 0x0)
>  			return BOOT_DEVICE_MMC1;
>  		return BOOT_DEVICE_MMC2;
> @@ -480,14 +480,18 @@ static u32 __get_primary_bootmedia(u32 main_devstat=
, u32 wkup_devstat)
>  	    bootmode =3D=3D BOOT_DEVICE_XSPI)
>  		bootmode =3D BOOT_DEVICE_SPI;
> =20
> -	if (bootmode =3D=3D BOOT_DEVICE_MMC2) {
> +	if (bootmode =3D=3D BOOT_DEVICE_MMCSD) {
> +		bootmode =3D BOOT_DEVICE_MMC2;
>  		u32 port =3D (main_devstat &
> -			    MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK) >>
> +			    MAIN_DEVSTAT_PRIM_BOOTMODE_MMCSD_PORT_MASK) >>
>  			   MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT;
>  		if (port =3D=3D 0x0)
>  			bootmode =3D BOOT_DEVICE_MMC1;
>  	}
> =20
> +	if (bootmode =3D=3D BOOT_DEVICE_EMMC)
> +		bootmode =3D BOOT_DEVICE_MMC1;
> +
>  	return bootmode;
>  }
> =20
> diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j72=
1s2/j721s2_init.c
> index eee3d0440ac..407040a4c0e 100644
> --- a/arch/arm/mach-k3/j721s2/j721s2_init.c
> +++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
> @@ -373,10 +373,10 @@ static u32 __get_backup_bootmedia(u32 main_devstat)
>  		return BOOT_DEVICE_UART;
>  	case BACKUP_BOOT_DEVICE_ETHERNET:
>  		return BOOT_DEVICE_ETHERNET;
> -	case BACKUP_BOOT_DEVICE_MMC2:
> +	case BACKUP_BOOT_DEVICE_MMCSD:
>  	{
> -		u32 port =3D (main_devstat & MAIN_DEVSTAT_BKUP_MMC_PORT_MASK) >>
> -			    MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT;
> +		u32 port =3D (main_devstat & MAIN_DEVSTAT_BKUP_MMCSD_PORT_MASK) >>
> +			    MAIN_DEVSTAT_BKUP_MMCSD_PORT_SHIFT;
>  		if (port =3D=3D 0x0)
>  			return BOOT_DEVICE_MMC1;
>  		return BOOT_DEVICE_MMC2;
> @@ -402,14 +402,18 @@ static u32 __get_primary_bootmedia(u32 main_devstat=
, u32 wkup_devstat)
>  	    bootmode =3D=3D BOOT_DEVICE_XSPI)
>  		bootmode =3D BOOT_DEVICE_SPI;
> =20
> -	if (bootmode =3D=3D BOOT_DEVICE_MMC2) {
> +	if (bootmode =3D=3D BOOT_DEVICE_MMCSD) {
> +		bootmode =3D BOOT_DEVICE_MMC2;
>  		u32 port =3D (main_devstat &
> -			    MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK) >>
> +			    MAIN_DEVSTAT_PRIM_BOOTMODE_MMCSD_PORT_MASK) >>
>  			   MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT;
>  		if (port =3D=3D 0x0)
>  			bootmode =3D BOOT_DEVICE_MMC1;
>  	}
> =20
> +	if (bootmode =3D=3D BOOT_DEVICE_EMMC)
> +		bootmode =3D BOOT_DEVICE_MMC1;
> +
>  	return bootmode;
>  }
> =20
> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s=
/j722s_init.c
> index 1180c75f551..86e1d29aea4 100644
> --- a/arch/arm/mach-k3/j722s/j722s_init.c
> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
> @@ -224,7 +224,7 @@ static u32 __get_backup_bootmedia(u32 devstat)
>  	case BACKUP_BOOT_DEVICE_ETHERNET:
>  		return BOOT_DEVICE_ETHERNET;
> =20
> -	case BACKUP_BOOT_DEVICE_MMC:
> +	case BACKUP_BOOT_DEVICE_MMCSD:
>  		if (bkup_bootmode_cfg)
>  			return BOOT_DEVICE_MMC2;
>  		return BOOT_DEVICE_MMC1;
> @@ -274,9 +274,9 @@ static u32 __get_primary_bootmedia(u32 devstat)
>  	case BOOT_DEVICE_SPI_NAND:
>  		return BOOT_DEVICE_SPINAND;
> =20
> -	case BOOT_DEVICE_MMC:
> -		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
> -				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
> +	case BOOT_DEVICE_MMCSD:
> +		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_MASK) >>
> +				MAIN_DEVSTAT_PRIMARY_MMCSD_PORT_SHIFT)
>  			return BOOT_DEVICE_MMC2;
>  		return BOOT_DEVICE_MMC1;
> =20
> @@ -319,8 +319,8 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot=
_device)
>  	switch (bootmode) {
>  	case BOOT_DEVICE_EMMC:
>  		return MMCSD_MODE_EMMCBOOT;
> -	case BOOT_DEVICE_MMC:
> -		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> +	case BOOT_DEVICE_MMCSD:
> +		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMCSD_FS_RAW_MASK)
>  			return MMCSD_MODE_RAW;
>  	default:
>  		return MMCSD_MODE_FS;
> diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j78=
4s4/j784s4_init.c
> index 53f152ccd9c..a1cef72bec3 100644
> --- a/arch/arm/mach-k3/j784s4/j784s4_init.c
> +++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
> @@ -352,10 +352,10 @@ static u32 __get_backup_bootmedia(u32 main_devstat)
>  		return BOOT_DEVICE_UART;
>  	case BACKUP_BOOT_DEVICE_ETHERNET:
>  		return BOOT_DEVICE_ETHERNET;
> -	case BACKUP_BOOT_DEVICE_MMC2:
> +	case BACKUP_BOOT_DEVICE_MMCSD:
>  	{
> -		u32 port =3D (main_devstat & MAIN_DEVSTAT_BKUP_MMC_PORT_MASK) >>
> -			    MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT;
> +		u32 port =3D (main_devstat & MAIN_DEVSTAT_BKUP_MMCSD_PORT_MASK) >>
> +			    MAIN_DEVSTAT_BKUP_MMCSD_PORT_SHIFT;
>  		if (port =3D=3D 0x0)
>  			return BOOT_DEVICE_MMC1;
>  		return BOOT_DEVICE_MMC2;
> @@ -381,14 +381,18 @@ static u32 __get_primary_bootmedia(u32 main_devstat=
, u32 wkup_devstat)
>  	    bootmode =3D=3D BOOT_DEVICE_XSPI)
>  		bootmode =3D BOOT_DEVICE_SPI;
> =20
> -	if (bootmode =3D=3D BOOT_DEVICE_MMC2) {
> +	if (bootmode =3D=3D BOOT_DEVICE_MMCSD) {
> +		bootmode =3D BOOT_DEVICE_MMC2;
>  		u32 port =3D (main_devstat &
> -			    MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK) >>
> +			    MAIN_DEVSTAT_PRIM_BOOTMODE_MMCSD_PORT_MASK) >>
>  			   MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT;
>  		if (port =3D=3D 0x0)
>  			bootmode =3D BOOT_DEVICE_MMC1;
>  	}
> =20
> +	if (bootmode =3D=3D BOOT_DEVICE_EMMC)
> +		bootmode =3D BOOT_DEVICE_MMC1;
> +
>  	return bootmode;
>  }
> =20

