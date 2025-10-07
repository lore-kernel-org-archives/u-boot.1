Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EA6CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 10:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97BBF84020;
	Tue,  7 Oct 2025 12:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cr9a60zB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95B4D8402F; Tue,  7 Oct 2025 12:32:59 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1E28400E
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 12:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 597AWrPP4189777;
 Tue, 7 Oct 2025 05:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759833173;
 bh=AJtfH4vp1pZw/fs4w0QwbrPC29UohkzdNBHOIHOUzjk=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=cr9a60zBc2vFumlNpFsPc8mGJ7WDBB/OpGzqbY07mWRjxQdQ3Tv1UXy0IoTrpuhaA
 EjVlUpSND3kz4gQGpDvmdvi514slMJCHFwJC2irwWwbsQojtZD30UyUbjdZr4V/lQ1
 A5as0YfRFGUKoJ9b6xipaY5aTMqVFnnKh1mkDWuE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 597AWrVO627247
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 7 Oct 2025 05:32:53 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 7
 Oct 2025 05:32:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 05:32:53 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 597AWpnD749685;
 Tue, 7 Oct 2025 05:32:52 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 7 Oct 2025 16:02:51 +0530
Message-ID: <DDC0SM36IAM0.FRMOZ81MG22S@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/3] arm: mach-k3: Rework spl/get_boot_device()
From: Anshul Dalal <anshuld@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>, <trini@konsulko.com>, <afd@ti.com>,
 <n-francis@ti.com>, <s-k6@ti.com>, <bb@ti.com>, <ggiordano@phytec.com>,
 <b-padhi@ti.com>, <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251002130455.1795794-1-w.egorov@phytec.de>
 <20251002130455.1795794-2-w.egorov@phytec.de>
In-Reply-To: <20251002130455.1795794-2-w.egorov@phytec.de>
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

Hi Wadim, I have noted a few comments below but overall the patch set
looks good to me.

On Thu Oct 2, 2025 at 6:34 PM IST, Wadim Egorov wrote:
> Introduce a shared boot-device helper that translates DEVSTAT boot
> modes via SoC-specific lookup tables. This replaces the per SoC
> get_boot_device()/get_*_bootmedia() implementations and centralizes
> the logic in boot-device.c while keeping the mapping data SoC-owned.
>
> Start with am62x as a reference implementation.
>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  arch/arm/mach-k3/Makefile                     |   2 +-
>  arch/arm/mach-k3/am62x/boot.c                 | 141 ++++++------------
>  arch/arm/mach-k3/boot-device.c                |  90 +++++++++++
>  arch/arm/mach-k3/boot-device.h                |  34 +++++
>  arch/arm/mach-k3/include/mach/am62_hardware.h |   1 +
>  5 files changed, 169 insertions(+), 99 deletions(-)
>  create mode 100644 arch/arm/mach-k3/boot-device.c
>  create mode 100644 arch/arm/mach-k3/boot-device.h
>
> diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
> index b2fd5810b67..7dc77328e5c 100644
> --- a/arch/arm/mach-k3/Makefile
> +++ b/arch/arm/mach-k3/Makefile
> @@ -6,7 +6,7 @@
>  obj-$(CONFIG_ARM64) +=3D arm64/
>  obj-$(CONFIG_CPU_V7R) +=3D r5/
>  obj-$(CONFIG_OF_LIBFDT) +=3D common_fdt.o
> -obj-y +=3D common.o security.o k3-ddr.o
> +obj-y +=3D common.o security.o k3-ddr.o boot-device.o
>  obj-$(CONFIG_SOC_K3_AM62A7) +=3D am62ax/
>  obj-$(CONFIG_SOC_K3_AM62P5) +=3D am62px/
>  obj-$(CONFIG_SOC_K3_AM625) +=3D am62x/
> diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/boot.=
c
> index a3a6cda6bdb..06bd04da99f 100644
> --- a/arch/arm/mach-k3/am62x/boot.c
> +++ b/arch/arm/mach-k3/am62x/boot.c
> @@ -3,104 +3,7 @@
>  #include <asm/arch/hardware.h>
>  #include <asm/arch/am62_spl.h>
> =20
> -static u32 __get_backup_bootmedia(u32 devstat)
> -{
> -	u32 bkup_bootmode =3D (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
> -				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
> -	u32 bkup_bootmode_cfg =3D
> -			(devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
> -				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
> -
> -	switch (bkup_bootmode) {
> -	case BACKUP_BOOT_DEVICE_UART:
> -		return BOOT_DEVICE_UART;
> -
> -	case BACKUP_BOOT_DEVICE_USB:
> -		return BOOT_DEVICE_USB;
> -
> -	case BACKUP_BOOT_DEVICE_ETHERNET:
> -		return BOOT_DEVICE_ETHERNET;
> -
> -	case BACKUP_BOOT_DEVICE_MMC:
> -		if (bkup_bootmode_cfg)
> -			return BOOT_DEVICE_MMC2;
> -		return BOOT_DEVICE_MMC1;
> -
> -	case BACKUP_BOOT_DEVICE_SPI:
> -		return BOOT_DEVICE_SPI;
> -
> -	case BACKUP_BOOT_DEVICE_I2C:
> -		return BOOT_DEVICE_I2C;
> -
> -	case BACKUP_BOOT_DEVICE_DFU:
> -		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
> -			return BOOT_DEVICE_USB;
> -		return BOOT_DEVICE_DFU;
> -	};
> -
> -	return BOOT_DEVICE_RAM;
> -}
> -
> -static u32 __get_primary_bootmedia(u32 devstat)
> -{
> -	u32 bootmode =3D (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
> -				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
> -	u32 bootmode_cfg =3D (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK)=
 >>
> -				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
> -
> -	switch (bootmode) {
> -	case BOOT_DEVICE_OSPI:
> -		fallthrough;
> -	case BOOT_DEVICE_QSPI:
> -		fallthrough;
> -	case BOOT_DEVICE_XSPI:
> -		fallthrough;
> -	case BOOT_DEVICE_SPI:
> -		return BOOT_DEVICE_SPI;
> -
> -	case BOOT_DEVICE_ETHERNET_RGMII:
> -		fallthrough;
> -	case BOOT_DEVICE_ETHERNET_RMII:
> -		return BOOT_DEVICE_ETHERNET;
> -
> -	case BOOT_DEVICE_EMMC:
> -		return BOOT_DEVICE_MMC1;
> -
> -	case BOOT_DEVICE_MMC:
> -		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
> -				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
> -			return BOOT_DEVICE_MMC2;
> -		return BOOT_DEVICE_MMC1;
> -
> -	case BOOT_DEVICE_DFU:
> -		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
> -		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
> -			return BOOT_DEVICE_USB;
> -		return BOOT_DEVICE_DFU;
> -
> -	case BOOT_DEVICE_NOBOOT:
> -		return BOOT_DEVICE_RAM;
> -	}
> -
> -	return bootmode;
> -}
> -
> -u32 get_boot_device(void)
> -{
> -	u32 devstat =3D readl(CTRLMMR_MAIN_DEVSTAT);
> -	u32 bootmode =3D *(u32 *)(K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
> -	u32 bootmedia;
> -
> -	if (bootmode =3D=3D K3_PRIMARY_BOOTMODE)
> -		bootmedia =3D __get_primary_bootmedia(devstat);
> -	else
> -		bootmedia =3D __get_backup_bootmedia(devstat);
> -
> -	debug("%s: devstat =3D 0x%x bootmedia =3D 0x%x bootmode =3D %d\n",
> -	      __func__, devstat, bootmedia, bootmode);
> -
> -	return bootmedia;
> -}
> +#include "../boot-device.h"
> =20
>  const char *get_reset_reason(void)
>  {
> @@ -141,3 +44,45 @@ const char *get_reset_reason(void)
> =20
>  	return "UNKNOWN";
>  }
> +
> +static const struct k3_boot_map am62_boot_device_primary_table[] =3D {
> +	{ BOOT_DEVICE_OSPI, 0, 0, 0, BOOT_DEVICE_SPI },
> +	{ BOOT_DEVICE_QSPI, 0, 0, 0, BOOT_DEVICE_SPI },
> +	{ BOOT_DEVICE_XSPI, 0, 0, 0, BOOT_DEVICE_SPI },
> +	{ BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
> +	{ BOOT_DEVICE_ETHERNET_RGMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
> +	{ BOOT_DEVICE_ETHERNET_RMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
> +	{ BOOT_DEVICE_EMMC, 0, 0, 0, BOOT_DEVICE_MMC1 },
> +	{ BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, MAIN_DEVSTAT_PRI=
MARY_MMC_PORT_SHIFT, 1, BOOT_DEVICE_MMC2 },
> +	{ BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, MAIN_DEVSTAT_PRI=
MARY_MMC_PORT_SHIFT, 0, BOOT_DEVICE_MMC1 },
> +	{ BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, MAIN_DEVSTAT_PRI=
MARY_USB_MODE_SHIFT, 1, BOOT_DEVICE_USB },
> +	{ BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, MAIN_DEVSTAT_PRI=
MARY_USB_MODE_SHIFT, 0, BOOT_DEVICE_DFU },
> +	{ BOOT_DEVICE_NOBOOT, 0, 0, 0, BOOT_DEVICE_RAM },
> +};
> +
> +static const struct k3_boot_map am62_boot_device_backup_table[] =3D {
> +	{ BACKUP_BOOT_DEVICE_UART, 0, 0, 0, BOOT_DEVICE_UART },
> +	{ BACKUP_BOOT_DEVICE_USB, 0, 0, 0, BOOT_DEVICE_USB },
> +	{ BACKUP_BOOT_DEVICE_ETHERNET, 0, 0, 0, BOOT_DEVICE_ETHERNET },
> +	{ BACKUP_BOOT_DEVICE_MMC, 1, 0, 1, BOOT_DEVICE_MMC2 },
> +	{ BACKUP_BOOT_DEVICE_MMC, 1, 0, 0, BOOT_DEVICE_MMC1 },
> +	{ BACKUP_BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
> +	{ BACKUP_BOOT_DEVICE_I2C, 0, 0, 0, BOOT_DEVICE_I2C },
> +	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_USB_MODE_MASK, 0, 0, BOOT=
_DEVICE_DFU },
> +	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_USB_MODE_MASK, 0, 1, BOOT=
_DEVICE_USB },
> +};
> +
> +static const struct k3_boot_device_info am62_boot_device_info =3D {
> +	.boot_device_primary_table =3D am62_boot_device_primary_table,
> +	.boot_device_primary_count =3D ARRAY_SIZE(am62_boot_device_primary_tabl=
e),
> +	.boot_device_backup_table =3D am62_boot_device_backup_table,
> +	.boot_device_backup_count =3D ARRAY_SIZE(am62_boot_device_backup_table)=
,
> +	.main_devstat_reg =3D (void __iomem *)CTRLMMR_MAIN_DEVSTAT,
> +	.wkup_devstat_reg =3D NULL,
> +	.bootmode_addr =3D (void __iomem *)K3_BOOT_PARAM_TABLE_INDEX_OCRAM,
> +};
> +
> +const struct k3_boot_device_info *k3_get_boot_device_info(void)
> +{
> +	return &am62_boot_device_info;
> +}
> diff --git a/arch/arm/mach-k3/boot-device.c b/arch/arm/mach-k3/boot-devic=
e.c
> new file mode 100644
> index 00000000000..9431dae71fa
> --- /dev/null
> +++ b/arch/arm/mach-k3/boot-device.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + *  Author: Wadim Egorov <w.egorov@phytec.de>
> + */
> +
> +#include "boot-device.h"
> +
> +#include <asm/io.h>
> +#include <asm/arch/hardware.h>
> +#include <asm/arch/am62_spl.h>
> +

We shouldn't be including an am62x specific header in a mach-k3 file
meant for multiple SoCs. Please refactor the macros used below so it's
no longer required.

One idea could be to let the SoC's boot.c handle parsing the devstat and
bootmode (primary or not). With get_boot_device in boot-device.c only
receiving the final bootmode and bootmode_cfg as part of the
k3_boot_device_info struct.

This would also allow Jacinto platforms to easily make use of this
refactor since the handling of wkup and main devstat would be handled as
part of the SoC's boot.c.

> +__weak const struct k3_boot_device_info *k3_get_boot_device_info(void)
> +{
> +	return NULL;
> +}
> +
> +static u32 __get_backup_bootmedia(const struct k3_boot_device_info *info=
, u32 devstat)
> +{
> +	u32 bkup_bootmode =3D (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
> +			     MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
> +	u32 bkup_bootmode_cfg =3D (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_M=
ASK) >>
> +				 MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < info->boot_device_backup_count; i++) {
> +		const struct k3_boot_map *m =3D &info->boot_device_backup_table[i];
> +
> +		if (bkup_bootmode !=3D m->mode)
> +			continue;
> +
> +		if (m->cfg_mask =3D=3D 0)
> +			return m->result;
> +
> +		if (((bkup_bootmode_cfg & m->cfg_mask) >> m->cfg_shift) =3D=3D m->cfg_=
value)
> +			return m->result;
> +	}
> +
> +	return BOOT_DEVICE_RAM;
> +}
> +
> +static u32 __get_primary_bootmedia(const struct k3_boot_device_info *inf=
o, u32 devstat)
> +{
> +	u32 bootmode =3D (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
> +			MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
> +	u32 bootmode_cfg =3D (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK)=
 >>
> +			MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < info->boot_device_primary_count; i++) {
> +		const struct k3_boot_map *m =3D &info->boot_device_primary_table[i];
> +
> +		if (bootmode !=3D m->mode)
> +			continue;
> +
> +		if (m->cfg_mask =3D=3D 0)
> +			return m->result;
> +
> +		if (((bootmode_cfg & m->cfg_mask) >> m->cfg_shift) =3D=3D m->cfg_value=
)
> +			return m->result;
> +	}
> +
> +	return bootmode;
> +}
> +
> +u32 __weak get_boot_device(void)
> +{

Having a k3 specific get_boot_device called by U-Boot's generic
spl_boot_device from SoC's init file is convoluted.

We should probably just replace get_boot_device with spl_boot_device in
a later patch after this series.

> +	const struct k3_boot_device_info *info =3D k3_get_boot_device_info();
> +	u32 bootmode;
> +	u32 main_devstat;
> +	u32 bootmedia;
> +
> +	if (!info) {
> +		pr_err("%s: no boot-device info for this SoC\n", __func__);
> +		return BOOT_DEVICE_NOBOOT;
> +	}
> +
> +	bootmode =3D readl(info->bootmode_addr);
> +	main_devstat =3D readl(info->main_devstat_reg);
> +
> +	if (bootmode =3D=3D K3_PRIMARY_BOOTMODE)
> +		bootmedia =3D __get_primary_bootmedia(info, main_devstat);
> +	else
> +		bootmedia =3D __get_backup_bootmedia(info, main_devstat);
> +
> +	debug("%s: devstat =3D 0x%x bootmedia =3D 0x%x bootmode =3D %d\n",
> +	      __func__, main_devstat, bootmedia, bootmode);
> +
> +	return bootmedia;
> +}
> diff --git a/arch/arm/mach-k3/boot-device.h b/arch/arm/mach-k3/boot-devic=
e.h
> new file mode 100644
> index 00000000000..965a4570710
> --- /dev/null
> +++ b/arch/arm/mach-k3/boot-device.h
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + *  Author: Wadim Egorov <w.egorov@phytec.de>
> + */
> +
> +#ifndef _K3_BOOT_DEVICE_H
> +#define _K3_BOOT_DEVICE_H
> +
> +#include <linux/types.h>
> +#include <asm/io.h>
> +
> +/* Descriptor for mode + optional cfg test -> normalized device */
> +struct k3_boot_map {
> +	u32 mode;	/* Raw PRIMARY_BOOTMODE value */
> +	u32 cfg_mask;	/* Bits in devstat-cfg to test (0 if none) */
> +	u32 cfg_shift;	/* Shift right before comparing */
> +	u32 cfg_value;	/* Desired value after mask+shift */
> +	u32 result;	/* Normalized device to return */
> +};
> +

Nit: This could be better documented following the standard '@' in a
comment above the struct.

> +struct k3_boot_device_info {
> +	const struct k3_boot_map *boot_device_primary_table;
> +	unsigned int boot_device_primary_count;
> +	const struct k3_boot_map *boot_device_backup_table;
> +	unsigned int boot_device_backup_count;
> +	void __iomem *main_devstat_reg;
> +	void __iomem *wkup_devstat_reg;
> +	void __iomem *bootmode_addr;
> +};
> +
> +const struct k3_boot_device_info *k3_get_boot_device_info(void);
> +
> +#endif /* _K3_BOOT_DEVICE_H */
> diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mac=
h-k3/include/mach/am62_hardware.h
> index 2f5655bf24a..084f16bf2d2 100644
> --- a/arch/arm/mach-k3/include/mach/am62_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
> @@ -10,6 +10,7 @@
>  #define __ASM_ARCH_AM62_HARDWARE_H
> =20
>  #include <config.h>
> +#include <asm/io.h>

Why do we need this header here?

>  #ifndef __ASSEMBLY__
>  #include <linux/bitops.h>
>  #endif

Acked-by: Anshul Dalal <anshuld@ti.com>

Regards,
Anshul
