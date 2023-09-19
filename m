Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48DACE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 17:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0159486A38;
	Tue, 19 Sep 2023 19:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CR6OMjGw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0510D86B3F; Tue, 19 Sep 2023 19:39:08 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704C086A2F
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JHcnhW103192;
 Tue, 19 Sep 2023 12:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695145129;
 bh=+Mbrh6kQzcj6/agoKheo4kiHx9t5Jykw7y6aVzeT9dI=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=CR6OMjGw9LzpL7kKsUULjfrwLz3h3LRTG/vmOs0l0OYxU+Z0Pb+ZUJEbaQ44fwrAN
 lYZBwsTPpiysBIzXOkbUO26Dgj/Bw33gyOC8dG+h/E3CyQKBRQ366Y31MxGPssETTQ
 I2OZwl6U8U7UnQIeElYTPyywC8ZRA/seAr4QhjeI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JHcnX2115599
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 12:38:49 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 12:38:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 12:38:48 -0500
Received: from [10.250.64.197] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JHceGp053564;
 Tue, 19 Sep 2023 12:38:41 -0500
Message-ID: <86f19f14-08e6-69fb-407b-df29e67442c3@ti.com>
Date: Tue, 19 Sep 2023 23:08:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 02/16] arm: mach-k3: Add basic support for J784S4 SoC
 definition
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Jason Kacines <j-kacines@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-3-a-nandan@ti.com>
 <958213c7-eefe-9d47-5979-876aadc1d044@kernel.org>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <958213c7-eefe-9d47-5979-876aadc1d044@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 09/09/23 16:18, Roger Quadros wrote:
> Hi,
>
> On 08/09/2023 14:05, Apurva Nandan wrote:
>> Add j784s4 initialization files for initial SPL boot.
> Please be consistent in naming. J784S4 ?
>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> [ add firewall configurations and change the R5 MCU scratchpad ]
>> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
>> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   arch/arm/mach-k3/Kconfig                      |  16 +-
>>   arch/arm/mach-k3/Makefile                     |   3 +
>>   arch/arm/mach-k3/arm64-mmu.c                  |  52 +++
>>   arch/arm/mach-k3/include/mach/hardware.h      |   4 +
>>   .../mach-k3/include/mach/j784s4_hardware.h    |  60 ++++
>>   arch/arm/mach-k3/include/mach/j784s4_spl.h    |  46 +++
>>   arch/arm/mach-k3/include/mach/spl.h           |   6 +-
>>   arch/arm/mach-k3/j784s4_fdt.c                 |  15 +
>>   arch/arm/mach-k3/j784s4_init.c                | 332 ++++++++++++++++++
>>   9 files changed, 526 insertions(+), 8 deletions(-)
>>   create mode 100644 arch/arm/mach-k3/include/mach/j784s4_hardware.h
>>   create mode 100644 arch/arm/mach-k3/include/mach/j784s4_spl.h
>>   create mode 100644 arch/arm/mach-k3/j784s4_fdt.c
>>   create mode 100644 arch/arm/mach-k3/j784s4_init.c
>>
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index 9168bf842d..0af2ec6ddb 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -22,6 +22,9 @@ config SOC_K3_AM625
>>   config SOC_K3_AM62A7
>>   	bool "TI's K3 based AM62A7 SoC Family Support"
>>   
>> +config SOC_K3_J784S4
>> +	bool "TI's K3 based J784S4 SoC Family Support"
>> +
>>   endchoice
>>   
>>   config SYS_SOC
>> @@ -30,7 +33,7 @@ config SYS_SOC
>>   config SYS_K3_NON_SECURE_MSRAM_SIZE
>>   	hex
>>   	default 0x80000 if SOC_K3_AM654
>> -	default 0x100000 if SOC_K3_J721E || SOC_K3_J721S2
>> +	default 0x100000 if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
>>   	default 0x1c0000 if SOC_K3_AM642
>>   	default 0x3c000 if SOC_K3_AM625 || SOC_K3_AM62A7
>>   	help
>> @@ -42,7 +45,7 @@ config SYS_K3_NON_SECURE_MSRAM_SIZE
>>   config SYS_K3_MAX_DOWNLODABLE_IMAGE_SIZE
>>   	hex
>>   	default 0x58000 if SOC_K3_AM654
>> -	default 0xc0000 if SOC_K3_J721E || SOC_K3_J721S2
>> +	default 0xc0000 if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
>>   	default 0x180000 if SOC_K3_AM642
>>   	default 0x38000 if SOC_K3_AM625 || SOC_K3_AM62A7
>>   	help
>> @@ -52,15 +55,14 @@ config SYS_K3_MAX_DOWNLODABLE_IMAGE_SIZE
>>   config SYS_K3_MCU_SCRATCHPAD_BASE
>>   	hex
>>   	default 0x40280000 if SOC_K3_AM654
>> -	default 0x41cff9fc if SOC_K3_J721S2
>> -	default 0x41cff9fc if SOC_K3_J721E
>> +	default 0x41cff9fc if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
>>   	help
>>   	  Describes the base address of MCU Scratchpad RAM.
>>   
>>   config SYS_K3_MCU_SCRATCHPAD_SIZE
>>   	hex
>>   	default 0x200 if SOC_K3_AM654
>> -	default 0x200 if SOC_K3_J721E || SOC_K3_J721S2
>> +	default 0x200 if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
>>   	help
>>   	  Describes the size of MCU Scratchpad RAM.
>>   
>> @@ -68,7 +70,7 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
>>   	hex
>>   	default 0x41c7fbfc if SOC_K3_AM654
>>   	default 0x41cffbfc if SOC_K3_J721E
>> -	default 0x41cfdbfc if SOC_K3_J721S2
>> +	default 0x41cfdbfc if SOC_K3_J721S2 || SOC_K3_J784S4
> Pleas move this to one line along with SOC_K3_J721E
>
>>   	default 0x701bebfc if SOC_K3_AM642
>>   	default 0x43c3f290 if SOC_K3_AM625
>>   	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
>> @@ -172,7 +174,7 @@ config K3_ATF_LOAD_ADDR
>>   
>>   config K3_DM_FW
>>   	bool "Separate DM firmware image"
>> -	depends on SPL && CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
>> +	depends on SPL && CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_J784S4) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
>>   	default y
>>   	help
>>   	  Enabling this will indicate that the system has separate DM
>> diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
>> index fd77b8bbba..6fe36c265c 100644
>> --- a/arch/arm/mach-k3/Makefile
>> +++ b/arch/arm/mach-k3/Makefile
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_SOC_K3_J721E) += j721e/ j7200/
>>   obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
>>   obj-$(CONFIG_SOC_K3_AM625) += am62x/
>>   obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
>> +obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
>>   obj-$(CONFIG_ARM64) += arm64-mmu.o
>>   obj-$(CONFIG_CPU_V7R) += r5_mpu.o lowlevel_init.o
>>   obj-$(CONFIG_ARM64) += cache.o
>> @@ -16,6 +17,7 @@ obj-$(CONFIG_SOC_K3_AM654) += am654_fdt.o
>>   obj-$(CONFIG_SOC_K3_J721E) += j721e_fdt.o
>>   obj-$(CONFIG_SOC_K3_J721S2) += j721s2_fdt.o
>>   obj-$(CONFIG_SOC_K3_AM625) += am625_fdt.o
>> +obj-$(CONFIG_SOC_K3_J784S4) += j784s4_fdt.o
>>   endif
>>   ifeq ($(CONFIG_SPL_BUILD),y)
>>   obj-$(CONFIG_SOC_K3_AM654) += am654_init.o
>> @@ -24,6 +26,7 @@ obj-$(CONFIG_SOC_K3_J721S2) += j721s2_init.o
>>   obj-$(CONFIG_SOC_K3_AM642) += am642_init.o
>>   obj-$(CONFIG_SOC_K3_AM625) += am625_init.o
>>   obj-$(CONFIG_SOC_K3_AM62A7) += am62a7_init.o
>> +obj-$(CONFIG_SOC_K3_J784S4) += j784s4_init.o
>>   obj-$(CONFIG_K3_LOAD_SYSFW) += sysfw-loader.o
>>   endif
>>   obj-y += common.o security.o
>> diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
>> index f8087d2421..c060920d7c 100644
>> --- a/arch/arm/mach-k3/arm64-mmu.c
>> +++ b/arch/arm/mach-k3/arm64-mmu.c
>> @@ -318,3 +318,55 @@ struct mm_region am64_mem_map[NR_MMU_REGIONS] = {
>>   
>>   struct mm_region *mem_map = am64_mem_map;
>>   #endif /* CONFIG_SOC_K3_AM642 */
>> +
>> +#if defined(CONFIG_SOC_K3_J784S4)
>> +#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 5)
>> +
>> +struct mm_region j784s4_mem_map[NR_MMU_REGIONS] = {
>> +	{
>> +		.virt = 0x0UL,
>> +		.phys = 0x0UL,
>> +		.size = 0x80000000UL,
>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>> +			 PTE_BLOCK_NON_SHARE |
>> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>> +	}, {
>> +		.virt = 0x80000000UL,
>> +		.phys = 0x80000000UL,
>> +		.size = 0x20000000UL,
>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +			 PTE_BLOCK_INNER_SHARE
>> +	}, {
>> +		.virt = 0xa0000000UL,
>> +		.phys = 0xa0000000UL,
>> +		.size = 0x21000000UL,
>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
>> +			 PTE_BLOCK_NON_SHARE
>> +	}, {
>> +		.virt = 0xc1000000UL,
>> +		.phys = 0xc1000000UL,
>> +		.size = 0x3f000000UL,
>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +			 PTE_BLOCK_INNER_SHARE
>> +	}, {
>> +		.virt = 0x880000000UL,
>> +		.phys = 0x880000000UL,
>> +		.size = 0x80000000UL,
>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +			 PTE_BLOCK_INNER_SHARE
>> +	}, {
>> +		.virt = 0x500000000UL,
>> +		.phys = 0x500000000UL,
>> +		.size = 0x400000000UL,
>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>> +			 PTE_BLOCK_NON_SHARE |
>> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>> +	}, {
>> +		/* List terminator */
>> +		0,
>> +	}
>> +};
>> +
>> +struct mm_region *mem_map = j784s4_mem_map;
>> +
>> +#endif /* CONFIG_SOC_K3_J784S4 */
>> diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
>> index 65742c4b7c..03b18f6bad 100644
>> --- a/arch/arm/mach-k3/include/mach/hardware.h
>> +++ b/arch/arm/mach-k3/include/mach/hardware.h
>> @@ -33,6 +33,10 @@
>>   #include "am62a_qos.h"
>>   #endif
>>   
>> +#ifdef CONFIG_SOC_K3_J784S4
>> +#include "j784s4_hardware.h"
>> +#endif
>> +
>>   /* Assuming these addresses and definitions stay common across K3 devices */
>>   #define CTRLMMR_WKUP_JTAG_ID	(WKUP_CTRL_MMR0_BASE + 0x14)
>>   #define JTAG_ID_VARIANT_SHIFT	28
>> diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
>> new file mode 100644
>> index 0000000000..b5fd91c038
>> --- /dev/null
>> +++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
>> @@ -0,0 +1,60 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * K3: J784S4 SoC definitions, structures etc.
>> + *
>> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> 2023 here and elsewhere in this series.
>
>> + */
>> +#ifndef __ASM_ARCH_J784S4_HARDWARE_H
>> +#define __ASM_ARCH_J784S4_HARDWARE_H
>> +
>> +#include <config.h>
>> +#ifndef __ASSEMBLY__
>> +#include <linux/bitops.h>
>> +#endif
>> +
>> +#define WKUP_CTRL_MMR0_BASE				0x43000000
>> +#define MCU_CTRL_MMR0_BASE				0x40f00000
>> +#define CTRL_MMR0_BASE					0x00100000
>> +
>> +#define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
>> +#define MAIN_DEVSTAT_BOOT_MODE_B_MASK			BIT(0)
>> +#define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT			0
>> +#define MAIN_DEVSTAT_BKUP_BOOTMODE_MASK			GENMASK(3, 1)
>> +#define MAIN_DEVSTAT_BKUP_BOOTMODE_SHIFT		1
>> +#define MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK	BIT(6)
>> +#define MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT		6
>> +#define MAIN_DEVSTAT_BKUP_MMC_PORT_MASK			BIT(7)
>> +#define MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT		7
>> +
>> +#define CTRLMMR_WKUP_DEVSTAT				(WKUP_CTRL_MMR0_BASE + 0x30)
>> +#define WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK		GENMASK(5, 3)
>> +#define WKUP_DEVSTAT_PRIMARY_BOOTMODE_SHIFT		3
>> +#define WKUP_DEVSTAT_MCU_OMLY_MASK			BIT(6)
>> +#define WKUP_DEVSTAT_MCU_ONLY_SHIFT			6
>> +
>> +/* ROM HANDOFF Structure location */
>> +#define ROM_EXTENDED_BOOT_DATA_INFO			0x41cfdb00
>> +
>> +/* MCU SCRATCHPAD usage */
>> +#define TI_SRAM_SCRATCH_BOARD_EEPROM_START	CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
>> +
>> +#if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>> +
>> +#define J784S4_DEV_MCU_RTI0			367
>> +#define J784S4_DEV_MCU_RTI1			368
>> +#define J784S4_DEV_MCU_ARMSS0_CPU0		346
>> +#define J784S4_DEV_MCU_ARMSS0_CPU1		347
>> +
>> +static const u32 put_device_ids[] = {
>> +	J784S4_DEV_MCU_RTI0,
>> +	J784S4_DEV_MCU_RTI1,
>> +};
>> +
>> +static const u32 put_core_ids[] = {
>> +	J784S4_DEV_MCU_ARMSS0_CPU1,
>> +	J784S4_DEV_MCU_ARMSS0_CPU0,     /* Handle CPU0 after CPU1 */
>> +};
>> +
>> +#endif
>> +
>> +#endif /* __ASM_ARCH_J784S4_HARDWARE_H */
>> diff --git a/arch/arm/mach-k3/include/mach/j784s4_spl.h b/arch/arm/mach-k3/include/mach/j784s4_spl.h
>> new file mode 100644
>> index 0000000000..7f6293e628
>> --- /dev/null
>> +++ b/arch/arm/mach-k3/include/mach/j784s4_spl.h
>> @@ -0,0 +1,46 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>> + *	David Huang <d-huang@ti.com>
>> + */
>> +#ifndef _ASM_ARCH_J784S4_SPL_H_
>> +#define _ASM_ARCH_J784S4_SPL_H_
>> +
>> +/* With BootMode B = 0 */
>> +#include <linux/bitops.h>
> Please add blank line here.
>
>> +#define BOOT_DEVICE_HYPERFLASH		0x00
>> +#define BOOT_DEVICE_OSPI		0x01
>> +#define BOOT_DEVICE_QSPI		0x02
>> +#define BOOT_DEVICE_SPI			0x03
>> +#define BOOT_DEVICE_ETHERNET		0x04
>> +#define BOOT_DEVICE_I2C			0x06
>> +#define BOOT_DEVICE_UART		0x07
>> +#define BOOT_DEVICE_NOR			BOOT_DEVICE_HYPERFLASH
>> +
>> +/* With BootMode B = 1 */
>> +#define BOOT_DEVICE_MMC2		0x10
>> +#define BOOT_DEVICE_MMC1		0x11
>> +#define BOOT_DEVICE_DFU			0x12
>> +#define BOOT_DEVICE_UFS			0x13
>> +#define BOOT_DEVIE_GPMC			0x14
>> +#define BOOT_DEVICE_PCIE		0x15
>> +#define BOOT_DEVICE_XSPI		0x16
>> +#define BOOT_DEVICE_RAM			0x17
>> +#define BOOT_DEVICE_MMC2_2		0xFF /* Invalid value */
>> +
>> +/* Backup boot modes with MCU Only = 0 */
>> +#define BACKUP_BOOT_DEVICE_RAM		0x0
>> +#define BACKUP_BOOT_DEVICE_USB		0x1
>> +#define BACKUP_BOOT_DEVICE_UART		0x3
>> +#define BACKUP_BOOT_DEVICE_ETHERNET	0x4
>> +#define BACKUP_BOOT_DEVICE_MMC2		0x5
>> +#define BACKUP_BOOT_DEVICE_SPI		0x6
>> +#define BACKUP_BOOT_DEVICE_I2C		0x7
>> +
>> +#define BOOT_MODE_B_SHIFT		4
>> +#define BOOT_MODE_B_MASK		BIT(4)
>> +
>> +#define K3_PRIMARY_BOOTMODE		0x0
>> +#define K3_BACKUP_BOOTMODE		0x1
>> +
>> +#endif
>> diff --git a/arch/arm/mach-k3/include/mach/spl.h b/arch/arm/mach-k3/include/mach/spl.h
>> index 356cd89210..82f57347e6 100644
>> --- a/arch/arm/mach-k3/include/mach/spl.h
>> +++ b/arch/arm/mach-k3/include/mach/spl.h
>> @@ -1,6 +1,6 @@
>>   /* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
>> + * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
>>    *	Lokesh Vutla <lokeshvutla@ti.com>
>>    */
>>   #ifndef _ASM_ARCH_SPL_H_
>> @@ -30,4 +30,8 @@
>>   #include "am62a_spl.h"
>>   #endif
>>   
>> +#ifdef CONFIG_SOC_K3_J784S4
>> +#include "j784s4_spl.h"
>> +#endif
>> +
>>   #endif /* _ASM_ARCH_SPL_H_ */
>> diff --git a/arch/arm/mach-k3/j784s4_fdt.c b/arch/arm/mach-k3/j784s4_fdt.c
>> new file mode 100644
>> index 0000000000..86f33f2d8c
>> --- /dev/null
>> +++ b/arch/arm/mach-k3/j784s4_fdt.c
>> @@ -0,0 +1,15 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * J784S4: SoC specific initialization
>> + *
>> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
>> + *	Apurva Nandan <a-nandan@ti.com>
>> + */
>> +
>> +#include "common_fdt.h"
>> +#include <fdt_support.h>
>> +
>> +int ft_system_setup(void *blob, struct bd_info *bd)
>> +{
>> +	return fdt_fixup_msmc_ram_k3(blob);
>> +}
> This file is exactly same as j721e_fdt.c and j721s2_fdt.c.
>
> Can we please consolidate the 3 files into 1 and reuse among all J7 variants?
>
>> diff --git a/arch/arm/mach-k3/j784s4_init.c b/arch/arm/mach-k3/j784s4_init.c
> <snip>
>
Okay, will fix all of these. thanks!

-- 
Thanks and regards,
Apurva Nandan,
Texas Instruments India.

