Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C26DE743C3
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 16:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D70786B71;
	Mon,  2 Oct 2023 18:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DHFrcJEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0590186DDA; Mon,  2 Oct 2023 18:02:15 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF50C85DE0
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 18:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392G1uQf053081;
 Mon, 2 Oct 2023 11:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696262516;
 bh=YaZNDtEZLHHV2Z+KU7fEAzkeWCH4OT4JQ9X0CC7U6go=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=DHFrcJEASrOxvghNULOOmk+HraCD/tA8GLouo7Seyb0WPtVz5jNeP99MalpC9EIj9
 HElwHfP6dOu3awkTbW6x9Lr+ypGVV7dK7YxOUJAk5r4aUMboCLfRcorcxODYnxMpO7
 u4S8Wub7I0t93eh6Q6mD9d6C0prNIt1Zxq9K8GFo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392G1uv9002045
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 11:01:56 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 11:01:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 11:01:56 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392G1ulm026993;
 Mon, 2 Oct 2023 11:01:56 -0500
Date: Mon, 2 Oct 2023 11:01:56 -0500
From: Nishanth Menon <nm@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v4 02/16] arm: mach-k3: Add basic support for J784S4 SoC
 definition
Message-ID: <20231002160156.pacy7j53bbtx766e@reboot>
References: <20231001165545.494212-1-a-nandan@ti.com>
 <20231001165545.494212-3-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231001165545.494212-3-a-nandan@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 22:25-20231001, Apurva Nandan wrote:
> Add J784S4 initialization files for initial SPL boot.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> [ add firewall configurations and change the R5 MCU scratchpad ]
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  arch/arm/mach-k3/Kconfig                      |  16 +-
>  arch/arm/mach-k3/Makefile                     |   3 +
>  arch/arm/mach-k3/arm64-mmu.c                  |  52 +++
>  arch/arm/mach-k3/include/mach/hardware.h      |   4 +
>  .../mach-k3/include/mach/j784s4_hardware.h    |  60 ++++
>  arch/arm/mach-k3/include/mach/j784s4_spl.h    |  47 +++
>  arch/arm/mach-k3/include/mach/spl.h           |   4 +
>  arch/arm/mach-k3/j784s4_fdt.c                 |  15 +
>  arch/arm/mach-k3/j784s4_init.c                | 332 ++++++++++++++++++
>  9 files changed, 526 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/mach-k3/include/mach/j784s4_hardware.h
>  create mode 100644 arch/arm/mach-k3/include/mach/j784s4_spl.h
>  create mode 100644 arch/arm/mach-k3/j784s4_fdt.c
>  create mode 100644 arch/arm/mach-k3/j784s4_init.c
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 9168bf842d..0af2ec6ddb 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -22,6 +22,9 @@ config SOC_K3_AM625
>  config SOC_K3_AM62A7
>  	bool "TI's K3 based AM62A7 SoC Family Support"
>  
> +config SOC_K3_J784S4
> +	bool "TI's K3 based J784S4 SoC Family Support"
> +
>  endchoice
>  
>  config SYS_SOC
> @@ -30,7 +33,7 @@ config SYS_SOC
>  config SYS_K3_NON_SECURE_MSRAM_SIZE
>  	hex
>  	default 0x80000 if SOC_K3_AM654
> -	default 0x100000 if SOC_K3_J721E || SOC_K3_J721S2
> +	default 0x100000 if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
>  	default 0x1c0000 if SOC_K3_AM642
>  	default 0x3c000 if SOC_K3_AM625 || SOC_K3_AM62A7
>  	help
> @@ -42,7 +45,7 @@ config SYS_K3_NON_SECURE_MSRAM_SIZE
>  config SYS_K3_MAX_DOWNLODABLE_IMAGE_SIZE
>  	hex
>  	default 0x58000 if SOC_K3_AM654
> -	default 0xc0000 if SOC_K3_J721E || SOC_K3_J721S2
> +	default 0xc0000 if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
>  	default 0x180000 if SOC_K3_AM642
>  	default 0x38000 if SOC_K3_AM625 || SOC_K3_AM62A7
>  	help
> @@ -52,15 +55,14 @@ config SYS_K3_MAX_DOWNLODABLE_IMAGE_SIZE
>  config SYS_K3_MCU_SCRATCHPAD_BASE
>  	hex
>  	default 0x40280000 if SOC_K3_AM654
> -	default 0x41cff9fc if SOC_K3_J721S2
> -	default 0x41cff9fc if SOC_K3_J721E
> +	default 0x41cff9fc if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
>  	help
>  	  Describes the base address of MCU Scratchpad RAM.
>  
>  config SYS_K3_MCU_SCRATCHPAD_SIZE
>  	hex
>  	default 0x200 if SOC_K3_AM654
> -	default 0x200 if SOC_K3_J721E || SOC_K3_J721S2
> +	default 0x200 if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
>  	help
>  	  Describes the size of MCU Scratchpad RAM.
>  
> @@ -68,7 +70,7 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
>  	hex
>  	default 0x41c7fbfc if SOC_K3_AM654
>  	default 0x41cffbfc if SOC_K3_J721E
> -	default 0x41cfdbfc if SOC_K3_J721S2
> +	default 0x41cfdbfc if SOC_K3_J721S2 || SOC_K3_J784S4
>  	default 0x701bebfc if SOC_K3_AM642
>  	default 0x43c3f290 if SOC_K3_AM625
>  	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
> @@ -172,7 +174,7 @@ config K3_ATF_LOAD_ADDR
>  
>  config K3_DM_FW
>  	bool "Separate DM firmware image"
> -	depends on SPL && CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
> +	depends on SPL && CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_J784S4) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
>  	default y
>  	help
>  	  Enabling this will indicate that the system has separate DM
> diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
> index fd77b8bbba..6fe36c265c 100644
> --- a/arch/arm/mach-k3/Makefile
> +++ b/arch/arm/mach-k3/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_SOC_K3_J721E) += j721e/ j7200/
>  obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
>  obj-$(CONFIG_SOC_K3_AM625) += am62x/
>  obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
> +obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
>  obj-$(CONFIG_ARM64) += arm64-mmu.o
>  obj-$(CONFIG_CPU_V7R) += r5_mpu.o lowlevel_init.o
>  obj-$(CONFIG_ARM64) += cache.o
> @@ -16,6 +17,7 @@ obj-$(CONFIG_SOC_K3_AM654) += am654_fdt.o
>  obj-$(CONFIG_SOC_K3_J721E) += j721e_fdt.o
>  obj-$(CONFIG_SOC_K3_J721S2) += j721s2_fdt.o
>  obj-$(CONFIG_SOC_K3_AM625) += am625_fdt.o
> +obj-$(CONFIG_SOC_K3_J784S4) += j784s4_fdt.o
>  endif
>  ifeq ($(CONFIG_SPL_BUILD),y)
>  obj-$(CONFIG_SOC_K3_AM654) += am654_init.o
> @@ -24,6 +26,7 @@ obj-$(CONFIG_SOC_K3_J721S2) += j721s2_init.o
>  obj-$(CONFIG_SOC_K3_AM642) += am642_init.o
>  obj-$(CONFIG_SOC_K3_AM625) += am625_init.o
>  obj-$(CONFIG_SOC_K3_AM62A7) += am62a7_init.o
> +obj-$(CONFIG_SOC_K3_J784S4) += j784s4_init.o
>  obj-$(CONFIG_K3_LOAD_SYSFW) += sysfw-loader.o
>  endif
>  obj-y += common.o security.o
> diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
> index f8087d2421..c060920d7c 100644
> --- a/arch/arm/mach-k3/arm64-mmu.c
> +++ b/arch/arm/mach-k3/arm64-mmu.c
> @@ -318,3 +318,55 @@ struct mm_region am64_mem_map[NR_MMU_REGIONS] = {
>  
>  struct mm_region *mem_map = am64_mem_map;
>  #endif /* CONFIG_SOC_K3_AM642 */
> +
> +#if defined(CONFIG_SOC_K3_J784S4)
> +#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 5)
> +
> +struct mm_region j784s4_mem_map[NR_MMU_REGIONS] = {
> +	{
> +		.virt = 0x0UL,
> +		.phys = 0x0UL,
> +		.size = 0x80000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		.virt = 0x80000000UL,
> +		.phys = 0x80000000UL,
> +		.size = 0x20000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		.virt = 0xa0000000UL,
> +		.phys = 0xa0000000UL,
> +		.size = 0x21000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
> +			 PTE_BLOCK_NON_SHARE
> +	}, {
> +		.virt = 0xc1000000UL,
> +		.phys = 0xc1000000UL,
> +		.size = 0x3f000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		.virt = 0x880000000UL,
> +		.phys = 0x880000000UL,
> +		.size = 0x80000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		.virt = 0x500000000UL,
> +		.phys = 0x500000000UL,
> +		.size = 0x400000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* List terminator */
> +		0,
> +	}
> +};

Why not reuse CONFIG_SOC_K3_J721S2 or adopt it?

> +
> +struct mm_region *mem_map = j784s4_mem_map;
> +
> +#endif /* CONFIG_SOC_K3_J784S4 */
> diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
> index 65742c4b7c..03b18f6bad 100644
> --- a/arch/arm/mach-k3/include/mach/hardware.h
> +++ b/arch/arm/mach-k3/include/mach/hardware.h
> @@ -33,6 +33,10 @@
>  #include "am62a_qos.h"
>  #endif
>  
> +#ifdef CONFIG_SOC_K3_J784S4
> +#include "j784s4_hardware.h"
> +#endif
> +
>  /* Assuming these addresses and definitions stay common across K3 devices */
>  #define CTRLMMR_WKUP_JTAG_ID	(WKUP_CTRL_MMR0_BASE + 0x14)
>  #define JTAG_ID_VARIANT_SHIFT	28
> diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> new file mode 100644
> index 0000000000..a34ca6db23
> --- /dev/null
> +++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * K3: J784S4 SoC definitions, structures etc.
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +#ifndef __ASM_ARCH_J784S4_HARDWARE_H
> +#define __ASM_ARCH_J784S4_HARDWARE_H
> +
> +#include <config.h>
> +#ifndef __ASSEMBLY__
> +#include <linux/bitops.h>
> +#endif
> +
> +#define WKUP_CTRL_MMR0_BASE				0x43000000
> +#define MCU_CTRL_MMR0_BASE				0x40f00000
> +#define CTRL_MMR0_BASE					0x00100000
> +
> +#define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
> +#define MAIN_DEVSTAT_BOOT_MODE_B_MASK			BIT(0)
> +#define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT			0
> +#define MAIN_DEVSTAT_BKUP_BOOTMODE_MASK			GENMASK(3, 1)
> +#define MAIN_DEVSTAT_BKUP_BOOTMODE_SHIFT		1
> +#define MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK	BIT(6)
> +#define MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT		6
> +#define MAIN_DEVSTAT_BKUP_MMC_PORT_MASK			BIT(7)
> +#define MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT		7
> +
> +#define CTRLMMR_WKUP_DEVSTAT				(WKUP_CTRL_MMR0_BASE + 0x30)
> +#define WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK		GENMASK(5, 3)
> +#define WKUP_DEVSTAT_PRIMARY_BOOTMODE_SHIFT		3
> +#define WKUP_DEVSTAT_MCU_OMLY_MASK			BIT(6)
> +#define WKUP_DEVSTAT_MCU_ONLY_SHIFT			6
> +
> +/* ROM HANDOFF Structure location */
> +#define ROM_EXTENDED_BOOT_DATA_INFO			0x41cfdb00
> +
> +/* MCU SCRATCHPAD usage */
> +#define TI_SRAM_SCRATCH_BOARD_EEPROM_START	CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
> +
> +#if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
> +
> +#define J784S4_DEV_MCU_RTI0			367
> +#define J784S4_DEV_MCU_RTI1			368
> +#define J784S4_DEV_MCU_ARMSS0_CPU0		346
> +#define J784S4_DEV_MCU_ARMSS0_CPU1		347
> +
> +static const u32 put_device_ids[] = {
> +	J784S4_DEV_MCU_RTI0,
> +	J784S4_DEV_MCU_RTI1,
> +};
> +
> +static const u32 put_core_ids[] = {
> +	J784S4_DEV_MCU_ARMSS0_CPU1,
> +	J784S4_DEV_MCU_ARMSS0_CPU0,     /* Handle CPU0 after CPU1 */
> +};
> +
> +#endif
> +
> +#endif /* __ASM_ARCH_J784S4_HARDWARE_H */
> diff --git a/arch/arm/mach-k3/include/mach/j784s4_spl.h b/arch/arm/mach-k3/include/mach/j784s4_spl.h
> new file mode 100644
> index 0000000000..35c6fa8f1c
> --- /dev/null
> +++ b/arch/arm/mach-k3/include/mach/j784s4_spl.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + *	David Huang <d-huang@ti.com>

Does'nt appear in the sign-offs etc..

> + */
> +#ifndef _ASM_ARCH_J784S4_SPL_H_
> +#define _ASM_ARCH_J784S4_SPL_H_
> +
> +/* With BootMode B = 0 */
> +#include <linux/bitops.h>
> +
> +#define BOOT_DEVICE_HYPERFLASH		0x00
> +#define BOOT_DEVICE_OSPI		0x01
> +#define BOOT_DEVICE_QSPI		0x02
> +#define BOOT_DEVICE_SPI			0x03
> +#define BOOT_DEVICE_ETHERNET		0x04
> +#define BOOT_DEVICE_I2C			0x06
> +#define BOOT_DEVICE_UART		0x07
> +#define BOOT_DEVICE_NOR			BOOT_DEVICE_HYPERFLASH
> +
> +/* With BootMode B = 1 */
> +#define BOOT_DEVICE_MMC2		0x10
> +#define BOOT_DEVICE_MMC1		0x11
> +#define BOOT_DEVICE_DFU			0x12
> +#define BOOT_DEVICE_UFS			0x13
> +#define BOOT_DEVIE_GPMC			0x14
> +#define BOOT_DEVICE_PCIE		0x15
> +#define BOOT_DEVICE_XSPI		0x16
> +#define BOOT_DEVICE_RAM			0x17
> +#define BOOT_DEVICE_MMC2_2		0xFF /* Invalid value */
> +
> +/* Backup boot modes with MCU Only = 0 */
> +#define BACKUP_BOOT_DEVICE_RAM		0x0
> +#define BACKUP_BOOT_DEVICE_USB		0x1
> +#define BACKUP_BOOT_DEVICE_UART		0x3
> +#define BACKUP_BOOT_DEVICE_ETHERNET	0x4
> +#define BACKUP_BOOT_DEVICE_MMC2		0x5
> +#define BACKUP_BOOT_DEVICE_SPI		0x6
> +#define BACKUP_BOOT_DEVICE_I2C		0x7
> +
> +#define BOOT_MODE_B_SHIFT		4
> +#define BOOT_MODE_B_MASK		BIT(4)
> +
> +#define K3_PRIMARY_BOOTMODE		0x0
> +#define K3_BACKUP_BOOTMODE		0x1
> +
> +#endif
> diff --git a/arch/arm/mach-k3/include/mach/spl.h b/arch/arm/mach-k3/include/mach/spl.h
> index 356cd89210..683b1ae880 100644
> --- a/arch/arm/mach-k3/include/mach/spl.h
> +++ b/arch/arm/mach-k3/include/mach/spl.h
> @@ -30,4 +30,8 @@
>  #include "am62a_spl.h"
>  #endif
>  
> +#ifdef CONFIG_SOC_K3_J784S4
> +#include "j784s4_spl.h"
> +#endif
> +
>  #endif /* _ASM_ARCH_SPL_H_ */
> diff --git a/arch/arm/mach-k3/j784s4_fdt.c b/arch/arm/mach-k3/j784s4_fdt.c
> new file mode 100644
> index 0000000000..125f55c9a6
> --- /dev/null
> +++ b/arch/arm/mach-k3/j784s4_fdt.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * J784S4: SoC specific initialization
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + *	Apurva Nandan <a-nandan@ti.com>
> + */
> +
> +#include "common_fdt.h"
> +#include <fdt_support.h>
> +
> +int ft_system_setup(void *blob, struct bd_info *bd)
> +{
> +	return fdt_fixup_msmc_ram_k3(blob);
> +}
> diff --git a/arch/arm/mach-k3/j784s4_init.c b/arch/arm/mach-k3/j784s4_init.c
> new file mode 100644
> index 0000000000..e3c2a9e171
> --- /dev/null
> +++ b/arch/arm/mach-k3/j784s4_init.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * J784S4: SoC specific initialization
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + *	Hari Nagalla <hnagalla@ti.com>
> + */
> +
> +#include <common.h>
> +#include <init.h>
> +#include <spl.h>
> +#include <asm/io.h>
> +#include <asm/armv7_mpu.h>
> +#include <asm/arch/hardware.h>
> +#include "sysfw-loader.h"
> +#include "common.h"
> +#include <linux/soc/ti/ti_sci_protocol.h>
> +#include <dm.h>
> +#include <dm/uclass-internal.h>
> +#include <dm/pinctrl.h>
> +#include <mmc.h>
> +#include <remoteproc.h>
> +
> +struct fwl_data infra_cbass0_fwls[] = {
> +	{ "PSC0", 5, 1 },
> +	{ "PLL_CTRL0", 6, 1 },
> +	{ "PLL_MMR0", 8, 26 },
> +	{ "CTRL_MMR0", 9, 16 },
> +	{ "GPIO0", 16, 1 },
> +}, wkup_cbass0_fwls[] = {
> +	{ "WKUP_PSC0", 129, 1 },
> +	{ "WKUP_PLL_CTRL0", 130, 1 },
> +	{ "WKUP_CTRL_MMR0", 131, 16 },
> +	{ "WKUP_GPIO0", 132, 1 },
> +	{ "WKUP_I2C0", 144, 1 },
> +	{ "WKUP_USART0", 160, 1 },
> +}, mcu_cbass0_fwls[] = {
> +	{ "MCU_R5FSS0_CORE0", 1024, 4 },
> +	{ "MCU_R5FSS0_CORE0_CFG", 1025, 3 },
> +	{ "MCU_R5FSS0_CORE1", 1028, 4 },
> +	{ "MCU_R5FSS0_CORE1_CFG", 1029, 1 },
> +	{ "MCU_FSS0_CFG", 1032, 12 },
> +	{ "MCU_FSS0_S1", 1033, 8 },
> +	{ "MCU_FSS0_S0", 1036, 8 },
> +	{ "MCU_PSROM49152X32", 1048, 1 },
> +	{ "MCU_MSRAM128KX64", 1050, 8 },
> +	{ "MCU_MSRAM128KX64_CFG", 1051, 1 },
> +	{ "MCU_TIMER0", 1056, 1 },
> +	{ "MCU_TIMER9", 1065, 1 },
> +	{ "MCU_USART0", 1120, 1 },
> +	{ "MCU_I2C0", 1152, 1 },
> +	{ "MCU_CTRL_MMR0", 1200, 8 },
> +	{ "MCU_PLL_MMR0", 1201, 3 },
> +	{ "MCU_CPSW0", 1220, 2 },
> +}, cbass_rc_cfg0_fwls[] = {
> +	{ "EMMCSD4SS0_CFG", 2400, 4 },
> +}, cbass_hc2_fwls[] = {
> +	{ "PCIE0", 2547, 24 },
> +}, cbass_hc_cfg0_fwls[] = {
> +	{ "PCIE0_CFG", 2577, 7 },
> +	{ "EMMC8SS0_CFG", 2579, 4 },
> +	{ "USB3SS0_CORE", 2580, 4 },
> +	{ "USB3SS1_CORE", 2581, 1 },
> +}, navss_cbass0_fwls[] = {
> +	{ "NACSS_VIRT0", 6253, 1 },
> +};
> +
> +static void ctrl_mmr_unlock(void)
> +{
> +	/* Unlock all WKUP_CTRL_MMR0 module registers */
> +	mmr_unlock(WKUP_CTRL_MMR0_BASE, 0);
> +	mmr_unlock(WKUP_CTRL_MMR0_BASE, 1);
> +	mmr_unlock(WKUP_CTRL_MMR0_BASE, 2);
> +	mmr_unlock(WKUP_CTRL_MMR0_BASE, 3);
> +	mmr_unlock(WKUP_CTRL_MMR0_BASE, 4);
> +	mmr_unlock(WKUP_CTRL_MMR0_BASE, 6);
> +	mmr_unlock(WKUP_CTRL_MMR0_BASE, 7);
> +
> +	/* Unlock all MCU_CTRL_MMR0 module registers */
> +	mmr_unlock(MCU_CTRL_MMR0_BASE, 0);
> +	mmr_unlock(MCU_CTRL_MMR0_BASE, 1);
> +	mmr_unlock(MCU_CTRL_MMR0_BASE, 2);
> +	mmr_unlock(MCU_CTRL_MMR0_BASE, 3);
> +	mmr_unlock(MCU_CTRL_MMR0_BASE, 4);
> +
> +	/* Unlock all CTRL_MMR0 module registers */
> +	mmr_unlock(CTRL_MMR0_BASE, 0);
> +	mmr_unlock(CTRL_MMR0_BASE, 1);
> +	mmr_unlock(CTRL_MMR0_BASE, 2);
> +	mmr_unlock(CTRL_MMR0_BASE, 3);
> +	mmr_unlock(CTRL_MMR0_BASE, 5);
> +	mmr_unlock(CTRL_MMR0_BASE, 7);
> +}
> +
> +void k3_mmc_stop_clock(void)
> +{
> +	if (IS_ENABLED(CONFIG_K3_LOAD_SYSFW)) {
> +		if (spl_boot_device() == BOOT_DEVICE_MMC1) {
> +			struct mmc *mmc = find_mmc_device(0);
> +
> +			if (!mmc)
> +				return;
> +
> +			mmc->saved_clock = mmc->clock;
> +			mmc_set_clock(mmc, 0, true);
> +		}
> +	}
> +}
> +
> +void k3_mmc_restart_clock(void)
> +{
> +	if (IS_ENABLED(CONFIG_K3_LOAD_SYSFW)) {
> +		if (spl_boot_device() == BOOT_DEVICE_MMC1) {
> +			struct mmc *mmc = find_mmc_device(0);
> +
> +			if (!mmc)
> +				return;
> +
> +			mmc_set_clock(mmc, mmc->saved_clock, false);
> +		}
> +	}
> +}
> +
> +/*
> + * This uninitialized global variable would normal end up in the .bss section,
> + * but the .bss is cleared between writing and reading this variable, so move
> + * it to the .data section.
> + */
> +u32 bootindex __section(".data");
> +static struct rom_extended_boot_data bootdata __section(".data");
> +
> +static void store_boot_info_from_rom(void)
> +{
> +	bootindex = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
> +	memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
> +	       sizeof(struct rom_extended_boot_data));
> +}
> +
> +void board_init_f(ulong dummy)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	/*
> +	 * Cannot delay this further as there is a chance that
> +	 * K3_BOOT_PARAM_TABLE_INDEX can be over written by SPL MALLOC section.
> +	 */
> +	store_boot_info_from_rom();
> +
> +	/* Make all control module registers accessible */
> +	ctrl_mmr_unlock();
> +
> +	if (IS_ENABLED(CONFIG_CPU_V7R)) {
> +		disable_linefill_optimization();
> +		setup_k3_mpu_regions();
> +	}
> +
> +	/* Init DM early */
> +	ret = spl_early_init();
> +
> +	/* Prepare console output */
> +	preloader_console_init();
> +
> +	if (IS_ENABLED(CONFIG_K3_LOAD_SYSFW)) {
> +		/*
> +		 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
> +		 * regardless of the result of pinctrl. Do this without probing the
> +		 * device, but instead by searching the device that would request the
> +		 * given sequence number if probed. The UART will be used by the system
> +		 * firmware (SYSFW) image for various purposes and SYSFW depends on us
> +		 * to initialize its pin settings.
> +		 */
> +		ret = uclass_find_device_by_seq(UCLASS_SERIAL, 0, &dev);
> +		if (!ret)
> +			pinctrl_select_state(dev, "default");
> +
> +		/*
> +		 * Load, start up, and configure system controller firmware. Provide
> +		 * the U-Boot console init function to the SYSFW post-PM configuration
> +		 * callback hook, effectively switching on (or over) the console
> +		 * output.
> +		 */
> +		k3_sysfw_loader(is_rom_loaded_sysfw(&bootdata),
> +				k3_mmc_stop_clock, k3_mmc_restart_clock);
> +
> +#ifdef CONFIG_SPL_OF_LIST
> +		if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT))
> +			do_board_detect();
> +#endif
> +
> +		if (IS_ENABLED(CONFIG_SPL_CLK_K3)) {
> +			/*
> +			 * Force probe of clk_k3 driver here to ensure basic default clock
> +			 * configuration is always done for enabling PM services.
> +			 */
> +			ret = uclass_get_device_by_driver(UCLASS_CLK,
> +							  DM_DRIVER_GET(ti_clk),
> +							  &dev);
> +			if (ret)
> +				panic("Failed to initialize clk-k3!\n");
> +		}
> +
> +		remove_fwl_configs(cbass_hc_cfg0_fwls, ARRAY_SIZE(cbass_hc_cfg0_fwls));
> +		remove_fwl_configs(cbass_hc2_fwls, ARRAY_SIZE(cbass_hc2_fwls));
> +		remove_fwl_configs(cbass_rc_cfg0_fwls, ARRAY_SIZE(cbass_rc_cfg0_fwls));
> +		remove_fwl_configs(infra_cbass0_fwls, ARRAY_SIZE(infra_cbass0_fwls));
> +		remove_fwl_configs(mcu_cbass0_fwls, ARRAY_SIZE(mcu_cbass0_fwls));
> +		remove_fwl_configs(wkup_cbass0_fwls, ARRAY_SIZE(wkup_cbass0_fwls));
> +		remove_fwl_configs(navss_cbass0_fwls, ARRAY_SIZE(navss_cbass0_fwls));

Why do you need this? firewall configuration was coming in via OIDs in 
https://lore.kernel.org/all/CAPnjgZ14Uy+gBC8kgqVA7m9NXN_WiXFffu5Ob=vz=E76rMDMPQ@mail.gmail.com/


> +	}
> +
> +	/* Output System Firmware version info */
> +	k3_sysfw_print_ver();
> +
> +	if (IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM)) {
> +		ret = uclass_get_device_by_name(UCLASS_MISC, "msmc", &dev);
> +		if (ret)
> +			panic("Probe of msmc failed: %d\n", ret);
> +
> +		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> +		if (ret)
> +			panic("DRAM 0 init failed: %d\n", ret);
> +
> +		ret = uclass_next_device_err(&dev);
> +		if (ret)
> +			panic("DRAM 1 init failed: %d\n", ret);
> +
> +		ret = uclass_next_device_err(&dev);
> +		if (ret)
> +			panic("DRAM 2 init failed: %d\n", ret);
> +
> +		ret = uclass_next_device_err(&dev);
> +		if (ret)
> +			panic("DRAM 3 init failed: %d\n", ret);
> +	}
> +
> +	spl_enable_dcache();
> +}
> +
> +u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
> +{
> +	switch (boot_device) {
> +	case BOOT_DEVICE_MMC1:
> +		return MMCSD_MODE_EMMCBOOT;
> +	case BOOT_DEVICE_MMC2:
> +		return MMCSD_MODE_FS;

See commit 0f1c1e8b368bd598b1c7f4b285f8921665ab62ac

> +	default:
> +		return MMCSD_MODE_RAW;
> +	}
> +}
> +
> +static u32 __get_backup_bootmedia(u32 main_devstat)
> +{
> +	u32 bkup_boot = (main_devstat & MAIN_DEVSTAT_BKUP_BOOTMODE_MASK) >>
> +			MAIN_DEVSTAT_BKUP_BOOTMODE_SHIFT;
> +
> +	switch (bkup_boot) {
> +	case BACKUP_BOOT_DEVICE_USB:
> +		return BOOT_DEVICE_DFU;
> +	case BACKUP_BOOT_DEVICE_UART:
> +		return BOOT_DEVICE_UART;
> +	case BACKUP_BOOT_DEVICE_ETHERNET:
> +		return BOOT_DEVICE_ETHERNET;
> +	case BACKUP_BOOT_DEVICE_MMC2:
> +	{
> +		u32 port = (main_devstat & MAIN_DEVSTAT_BKUP_MMC_PORT_MASK) >>
> +			    MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT;
> +		if (port == 0x0)
> +			return BOOT_DEVICE_MMC1;
> +		return BOOT_DEVICE_MMC2;
> +	}
> +	case BACKUP_BOOT_DEVICE_SPI:
> +		return BOOT_DEVICE_SPI;
> +	case BACKUP_BOOT_DEVICE_I2C:
> +		return BOOT_DEVICE_I2C;
> +	}
> +
> +	return BOOT_DEVICE_RAM;
> +}
> +
> +static u32 __get_primary_bootmedia(u32 main_devstat, u32 wkup_devstat)
> +{
> +	u32 bootmode = (wkup_devstat & WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
> +			WKUP_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
> +
> +	bootmode |= (main_devstat & MAIN_DEVSTAT_BOOT_MODE_B_MASK) <<
> +			BOOT_MODE_B_SHIFT;
> +
> +	if (bootmode == BOOT_DEVICE_OSPI || bootmode ==	BOOT_DEVICE_QSPI ||
> +	    bootmode == BOOT_DEVICE_XSPI)
> +		bootmode = BOOT_DEVICE_SPI;
> +
> +	if (bootmode == BOOT_DEVICE_MMC2) {
> +		u32 port = (main_devstat &
> +			    MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK) >>
> +			   MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT;
> +		if (port == 0x0)
> +			bootmode = BOOT_DEVICE_MMC1;
> +	}
> +
> +	return bootmode;
> +}
> +
> +u32 spl_spi_boot_bus(void)
> +{
> +	u32 wkup_devstat = readl(CTRLMMR_WKUP_DEVSTAT);
> +	u32 main_devstat = readl(CTRLMMR_MAIN_DEVSTAT);
> +	u32 bootmode = ((wkup_devstat & WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
> +				WKUP_DEVSTAT_PRIMARY_BOOTMODE_SHIFT) |
> +			((main_devstat & MAIN_DEVSTAT_BOOT_MODE_B_MASK) << BOOT_MODE_B_SHIFT);
> +
> +	return (bootmode == BOOT_DEVICE_QSPI) ? 1 : 0;
> +}
> +
> +u32 spl_boot_device(void)
> +{
> +	u32 wkup_devstat = readl(CTRLMMR_WKUP_DEVSTAT);
> +	u32 main_devstat;
> +
> +	if (wkup_devstat & WKUP_DEVSTAT_MCU_OMLY_MASK) {
> +		printf("ERROR: MCU only boot is not yet supported\n");
> +		return BOOT_DEVICE_RAM;
> +	}
> +
> +	/* MAIN CTRL MMR can only be read if MCU ONLY is 0 */
> +	main_devstat = readl(CTRLMMR_MAIN_DEVSTAT);
> +
> +	if (bootindex == K3_PRIMARY_BOOTMODE)
> +		return __get_primary_bootmedia(main_devstat, wkup_devstat);
> +	else
> +		return __get_backup_bootmedia(main_devstat);
> +}
> -- 
> 2.34.1
> 

I think there is an opportunity to merge j721s2 and j784s4.. but i am
not expert on either of the chips to better comment.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
