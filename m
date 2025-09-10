Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1449CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 11:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C97D8318E;
	Wed, 10 Sep 2025 13:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ns5laDkh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDBD831D5; Wed, 10 Sep 2025 13:32:30 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5418830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 13:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ABWQEw127997;
 Wed, 10 Sep 2025 06:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757503946;
 bh=u0O4vlfEHZx8ZYnHqBtkHbh064I1gdbAKkuCogtgXIU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ns5laDkhewZsFzijqbXv7W2rjrimdJCdrDK3dzQfM9jmNsaUUyGme91lwkK5h+RpM
 0m2zj6TQlB0Nm43u12F6Jkasri/lC2ddpjurTBbh4qhdcbUwIFKLWIdlXKmgJBA8JQ
 Nk4ltPfV26dyz5oyw3ZUVoRnqlXKGNJ3IQJIHayk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ABWPjG1116245
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 06:32:25 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 06:32:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 06:32:25 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ABWOWh410515;
 Wed, 10 Sep 2025 06:32:24 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Sep 2025 17:02:23 +0530
Message-ID: <DCP35HMEZQAI.30XSASDC8234E@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>, <trini@konsulko.com>, <afd@ti.com>,
 <n-francis@ti.com>, <s-k6@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: Re: [RFC 1/1] arm: mach-k3: Rework spl/get_boot_device()
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250813102948.2426361-1-w.egorov@phytec.de>
 <20250813102948.2426361-2-w.egorov@phytec.de>
In-Reply-To: <20250813102948.2426361-2-w.egorov@phytec.de>
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

Hello Wadim,

The direction of your patch looks good to me, thanks for taking the time
to refactor!

A few comments below:

On Wed Aug 13, 2025 at 3:59 PM IST, Wadim Egorov wrote:
> The current implementation requires every K3 SoC to provide its own
> get_boot_device()/get_*_bootmedia() functions which look very identical.
> Rework it using table lookups for SoC data and reduce code duplication.
>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  arch/arm/mach-k3/Makefile                     |   2 +-
>  arch/arm/mach-k3/am62x/boot.c                 | 129 +++++-------------
>  arch/arm/mach-k3/boot-device.c                | 109 +++++++++++++++
>  arch/arm/mach-k3/boot-device.h                |  27 ++++
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
> index a3a6cda6bdb..6d458f546a6 100644
> --- a/arch/arm/mach-k3/am62x/boot.c
> +++ b/arch/arm/mach-k3/am62x/boot.c
[snip]
> @@ -141,3 +44,33 @@ const char *get_reset_reason(void)
> =20
>  	return "UNKNOWN";
>  }
> +
> +struct k3_boot_map am62_boot_device_primary_table[] =3D {
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
> +struct k3_boot_map am62_boot_device_backup_table[] =3D {
> +	{ BACKUP_BOOT_DEVICE_UART, 0, 0, 0, BOOT_DEVICE_UART },
> +	{ BACKUP_BOOT_DEVICE_USB, 0, 0, 0, BOOT_DEVICE_USB },
> +	{ BACKUP_BOOT_DEVICE_ETHERNET, 0, 0, 0, BOOT_DEVICE_ETHERNET },
> +	{ BACKUP_BOOT_DEVICE_MMC, MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK, MAIN_D=
EVSTAT_BACKUP_BOOTMODE_CFG_SHIFT, 0, BOOT_DEVICE_MMC1 },
> +	{ BACKUP_BOOT_DEVICE_MMC, MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK, MAIN_D=
EVSTAT_BACKUP_BOOTMODE_CFG_SHIFT, 1, BOOT_DEVICE_MMC2 },
> +	{ BACKUP_BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
> +	{ BACKUP_BOOT_DEVICE_I2C, 0, 0, 0, BOOT_DEVICE_I2C },
> +	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK, MAIN_D=
EVSTAT_BACKUP_BOOTMODE_CFG_SHIFT, 0, BOOT_DEVICE_DFU },
> +	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK, MAIN_D=
EVSTAT_BACKUP_BOOTMODE_CFG_SHIFT, 1, BOOT_DEVICE_USB },
> +};
> +
> +unsigned int am62_boot_device_primary_table_count =3D ARRAY_SIZE(am62_bo=
ot_device_primary_table);
> +unsigned int am62_boot_device_backup_table_count =3D ARRAY_SIZE(am62_boo=
t_device_backup_table);

It might be better to have boot-device.h export an extern that the
boards can set. Something like this:

boot-device.h:

	extern struct k3_boot_device_info *info;

am62x/boot.c:

	static const struct k3_boot_device_info am62_map =3D {
			.boot_device_primary_table =3D am62_boot_device_primary_table,
			.boot_device_primary_count =3D ARRAY_SIZE(am62_boot_device_primary_table=
),
			.boot_device_backup_table =3D am62_boot_device_backup_table,
			.boot_device_backup_count =3D ARRAY_SIZE(am62_boot_device_backup_table),
			.main_devstat_reg =3D (void __iomem *)CTRLMMR_MAIN_DEVSTAT,
			.wkup_devstat_reg =3D 0,
			.bootmode_addr =3D (void __iomem *)K3_BOOT_PARAM_TABLE_INDEX_OCRAM,
	};

	struct k3_boot_device_info *info =3D &am62_map;

This would allow you to remove the SOC specifics ifdefs from
boot-device.c below.

> diff --git a/arch/arm/mach-k3/boot-device.c b/arch/arm/mach-k3/boot-devic=
e.c
> new file mode 100644
> index 00000000000..9b4f0ae7aa6
> --- /dev/null
> +++ b/arch/arm/mach-k3/boot-device.c
> @@ -0,0 +1,109 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
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
> +struct k3_boot_device_info {
> +	struct k3_boot_map *boot_device_primary_table;
> +	unsigned int *boot_device_primary_count;
> +	struct k3_boot_map *boot_device_backup_table;
> +	unsigned int *boot_device_backup_count;
> +	void __iomem *main_devstat_reg;
> +	void __iomem *wkup_devstat_reg;
> +	void __iomem *bootmode_addr;
> +};
> +
> +static const struct k3_boot_device_info k3_boot_device_info[] =3D {
> +#if defined(CONFIG_SOC_K3_AM625)
> +	{
> +		.boot_device_primary_table =3D am62_boot_device_primary_table,
> +		.boot_device_primary_count =3D &am62_boot_device_primary_table_count,
> +		.boot_device_backup_table =3D am62_boot_device_backup_table,
> +		.boot_device_backup_count =3D &am62_boot_device_backup_table_count,
> +		.main_devstat_reg =3D (void __iomem *)CTRLMMR_MAIN_DEVSTAT,
> +		.wkup_devstat_reg =3D 0,
> +		.bootmode_addr =3D (void __iomem *)K3_BOOT_PARAM_TABLE_INDEX_OCRAM,
> +	},
> +#endif
> +};

Why use an array here? We are only making use of the first entry
anyways.

> +
> +static u32 __get_backup_bootmedia(u32 devstat)
> +{
> +	u32 bkup_bootmode =3D (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
> +			     MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
> +	u32 bkup_bootmode_cfg =3D (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_M=
ASK) >>
> +				 MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
> +
> +	const struct k3_boot_device_info *info =3D &k3_boot_device_info[0];
> +	unsigned int i;
> +
> +	for (i =3D 0; i < *info->boot_device_backup_count; i++) {
> +		struct k3_boot_map *m =3D &info->boot_device_backup_table[i];
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
> +static u32 __get_primary_bootmedia(u32 devstat)
> +{
> +	u32 bootmode =3D (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
> +			MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
> +	u32 bootmode_cfg =3D (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK)=
 >>
> +			MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
> +	const struct k3_boot_device_info *info =3D &k3_boot_device_info[0];
> +	unsigned int i;
> +
> +	for (i =3D 0; i < *info->boot_device_primary_count; i++) {
> +		struct k3_boot_map *m =3D &info->boot_device_primary_table[i];
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
> +u32 get_boot_device(void)
> +{

This might be better kept as a weak function.

> +	const struct k3_boot_device_info *info =3D &k3_boot_device_info[0];
> +	u32 bootmode =3D readl(info->bootmode_addr);
> +	u32 main_devstat =3D readl(info->main_devstat_reg);
> +	u32 bootmedia;
> +
> +	if (!ARRAY_SIZE(k3_boot_device_info)) {
> +		pr_err("%s: no boot-device info for this SoC\n", __func__);
> +		return BOOT_DEVICE_NOBOOT;
> +	}
> +
> +	if (bootmode =3D=3D K3_PRIMARY_BOOTMODE)
> +		bootmedia =3D __get_primary_bootmedia(main_devstat);
> +	else
> +		bootmedia =3D __get_backup_bootmedia(main_devstat);
> +
> +	debug("%s: devstat =3D 0x%x bootmedia =3D 0x%x bootmode =3D %d\n",
> +	      __func__, main_devstat, bootmedia, bootmode);
> +
> +	return bootmedia;
> +}
> diff --git a/arch/arm/mach-k3/boot-device.h b/arch/arm/mach-k3/boot-devic=
e.h
> new file mode 100644
> index 00000000000..351f710151b
> --- /dev/null
> +++ b/arch/arm/mach-k3/boot-device.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + *  Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + *  Author: Wadim Egorov <w.egorov@phytec.de>
> + */
> +
> +#ifndef _K3_BOOT_DEVICE_H
> +#define _K3_BOOT_DEVICE_H
> +
> +#include <linux/types.h>
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
> +extern struct k3_boot_map am62_boot_device_primary_table[];
> +extern unsigned int am62_boot_device_primary_table_count;
> +
> +extern struct k3_boot_map am62_boot_device_backup_table[];
> +extern unsigned int am62_boot_device_backup_table_count;
> +

You wouldn't need these 4 externs per SoC too with the above suggestion.

Regards,
Anshul

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
>  #ifndef __ASSEMBLY__
>  #include <linux/bitops.h>
>  #endif

