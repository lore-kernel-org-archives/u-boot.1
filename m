Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7350DC4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 05:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B9B387C87;
	Wed,  7 Feb 2024 06:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KaYJdOOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4875A87CAA; Wed,  7 Feb 2024 06:21:04 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B29487BC6
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 06:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-bhatia1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4175KtGD028366;
 Tue, 6 Feb 2024 23:20:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707283255;
 bh=VTfmdUWpFyZn9FuIrABFCMRIQuxl4Wy3/BxhH8aMNfk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KaYJdOOY/UH307zyd2tU7zog65AQMT+jHAH6UMs+kru7mwU7IMqg37hvgr0JFhWIK
 1wynd+rnhgOPRXKqlxTqra+dqIOiJDLrMHCFWTwZ5MdJesQVC7rdfRv1Pp5YhGj+9+
 x5DAREcuhEEvDq1Lk+M/hl9WKtDwlI/S0MTR6+Ek=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4175KtU2014527
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Feb 2024 23:20:55 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 23:20:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 23:20:54 -0600
Received: from [10.249.128.244] ([10.249.128.244])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4175Kagi054093;
 Tue, 6 Feb 2024 23:20:43 -0600
Message-ID: <5604d25b-c4e9-4bd3-99e2-9d4250e6cd38@ti.com>
Date: Wed, 7 Feb 2024 10:50:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: Refactor QoS settings
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Tom Rini <trini@konsulko.com>, Nishanth Menon
 <nm@ti.com>, Bryan Brattlof <bb@ti.com>
CC: u-boot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>, Devarsh Thakkar
 <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>, Aniket Limaye
 <a-limaye@ti.com>
References: <20240206085610.3226136-1-a-bhatia1@ti.com>
 <d6ce0d0b-0116-454a-814c-e037c7a63a44@ti.com>
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <d6ce0d0b-0116-454a-814c-e037c7a63a44@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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



On 06-Feb-24 22:58, Andrew Davis wrote:
> On 2/6/24 2:56 AM, Aradhya Bhatia wrote:
>> Refactor common QoS code into a new common header file, and the soc
>> specific setup_qos functions into a common API.
>>
>> Rename $(soc)_qos_count and $(soc)_qos_data variables to qos_count and
>> qos_data. When QoS settings of more SoCs are added, only one pair will
>> be defined at a time, based on the config SOC_K3_$(soc).
>>
>> This refactoring has been done for 2 major purposes.
>>
>> - The auto-generated $(soc)_qos_data.c and $(soc)_qos.h files cannot
>>    have any code that is specific to any bootloader. Those files have to
>>    remain agnostic of different bootloader implementations and their
>>    header files.
>>
>> - The existing implementation was less than ideal and would have enabled
>>    multiple $(soc)_qos_count and $(soc)_qos_data variables for all SoC
>>    variants.
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>   arch/arm/mach-k3/Kconfig                      |  8 +++++++
>>   arch/arm/mach-k3/am62a7_init.c                | 14 ------------
>>   arch/arm/mach-k3/common.c                     | 12 ++++++++++
>>   arch/arm/mach-k3/common.h                     |  8 +++++++
>>   arch/arm/mach-k3/include/mach/hardware.h      |  9 --------
>>   arch/arm/mach-k3/include/mach/k3-qos.h        | 22 +++++++++++++++++++
>>   arch/arm/mach-k3/r5/am62ax/Makefile           |  2 +-
>>   .../{include/mach => r5/am62ax}/am62a_qos.h   |  0
>>   .../{am62a_qos_data.c => am62a_qos_uboot.c}   |  9 ++++----
>>   9 files changed, 56 insertions(+), 28 deletions(-)
>>   create mode 100644 arch/arm/mach-k3/include/mach/k3-qos.h
>>   rename arch/arm/mach-k3/{include/mach => r5/am62ax}/am62a_qos.h (100%)
>>   rename arch/arm/mach-k3/r5/am62ax/{am62a_qos_data.c =>
>> am62a_qos_uboot.c} (85%)
>>
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index 03898424c954..ffc4a9c29029 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -139,6 +139,14 @@ config K3_DM_FW
>>         bootloader, it makes RM and PM services not being available
>>         during R5 SPL execution time.
>>   +config K3_QOS
>> +    bool "Enable Quality of Service (QoS) Settings for TI K3 SoCs"
>> +    default y if CPU_V7R && SOC_K3_AM62A7
> 
> If this is R5 only, then put it in the arch/arm/mach-k3/r5 Kconfig
> and you can drop the CPU_V7R check.
> 
> Andrew

That would indeed be better. Thanks!

Regards
Aradhya

> 
>> +    help
>> +      This option enables the R5 SPL to apply QoS settings for various
>> +      HW controllers inside the TI K3 SoCs. The files for QoS
>> settings are
>> +      generated from Sysconfig and k3-resource-partitioning tools.
>> +
>>   config K3_X509_SWRV
>>       int "SWRV for X509 certificate used for boot images"
>>       default 1
>> diff --git a/arch/arm/mach-k3/am62a7_init.c
>> b/arch/arm/mach-k3/am62a7_init.c
>> index d72e19936b9b..080274e3af58 100644
>> --- a/arch/arm/mach-k3/am62a7_init.c
>> +++ b/arch/arm/mach-k3/am62a7_init.c
>> @@ -69,20 +69,6 @@ static void ctrl_mmr_unlock(void)
>>       mmr_unlock(PADCFG_MMR1_BASE, 1);
>>   }
>>   -#if (IS_ENABLED(CONFIG_CPU_V7R))
>> -static void setup_qos(void)
>> -{
>> -    u32 i;
>> -
>> -    for (i = 0; i < am62a_qos_count; i++)
>> -        writel(am62a_qos_data[i].val, (uintptr_t)am62a_qos_data[i].reg);
>> -}
>> -#else
>> -static void setup_qos(void)
>> -{
>> -}
>> -#endif
>> -
>>   void board_init_f(ulong dummy)
>>   {
>>       struct udevice *dev;
>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>> index f411366778f0..b54f2ddc4729 100644
>> --- a/arch/arm/mach-k3/common.c
>> +++ b/arch/arm/mach-k3/common.c
>> @@ -28,6 +28,8 @@
>>   #include <elf.h>
>>   #include <soc.h>
>>   +#include <asm/arch/k3-qos.h>
>> +
>>   #if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
>>   enum {
>>       IMAGE_ID_ATF,
>> @@ -595,3 +597,13 @@ int misc_init_r(void)
>>   void __weak do_board_detect(void)
>>   {
>>   }
>> +
>> +#if (IS_ENABLED(CONFIG_K3_QOS))
>> +void setup_qos(void)
>> +{
>> +    u32 i;
>> +
>> +    for (i = 0; i < qos_count; i++)
>> +        writel(qos_data[i].val, (uintptr_t)qos_data[i].reg);
>> +}
>> +#endif
>> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
>> index e9db9fbfb63d..53aa186b31a4 100644
>> --- a/arch/arm/mach-k3/common.h
>> +++ b/arch/arm/mach-k3/common.h
>> @@ -45,3 +45,11 @@ void ti_secure_image_post_process(void **p_image,
>> size_t *p_size);
>>   struct ti_sci_handle *get_ti_sci_handle(void);
>>   void do_board_detect(void);
>>   void ti_secure_image_check_binary(void **p_image, size_t *p_size);
>> +
>> +#if (IS_ENABLED(CONFIG_K3_QOS))
>> +void setup_qos(void);
>> +#else
>> +static inline void setup_qos(void)
>> +{
>> +}
>> +#endif
>> diff --git a/arch/arm/mach-k3/include/mach/hardware.h
>> b/arch/arm/mach-k3/include/mach/hardware.h
>> index a1a9dfbde66c..52ef82e70b07 100644
>> --- a/arch/arm/mach-k3/include/mach/hardware.h
>> +++ b/arch/arm/mach-k3/include/mach/hardware.h
>> @@ -30,7 +30,6 @@
>>     #ifdef CONFIG_SOC_K3_AM62A7
>>   #include "am62a_hardware.h"
>> -#include "am62a_qos.h"
>>   #endif
>>     /* Assuming these addresses and definitions stay common across K3
>> devices */
>> @@ -97,12 +96,4 @@ struct rom_extended_boot_data {
>>       u32 num_components;
>>   };
>>   -struct k3_qos_data {
>> -    u32 reg;
>> -    u32 val;
>> -};
>> -
>> -extern struct k3_qos_data am62a_qos_data[];
>> -extern u32 am62a_qos_count;
>> -
>>   #endif /* _ASM_ARCH_HARDWARE_H_ */
>> diff --git a/arch/arm/mach-k3/include/mach/k3-qos.h
>> b/arch/arm/mach-k3/include/mach/k3-qos.h
>> new file mode 100644
>> index 000000000000..e00e1de5b9cb
>> --- /dev/null
>> +++ b/arch/arm/mach-k3/include/mach/k3-qos.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Quality of Service (QoS) Configuration Header File
>> + *
>> + * Copyright (C) 2024 Texas Instruments Incorporated -
>> https://www.ti.com/
>> + */
>> +#ifndef _K3_QOS_H_
>> +#define _K3_QOS_H_
>> +
>> +#include <linux/kernel.h>
>> +
>> +struct k3_qos_data {
>> +    u32 reg;
>> +    u32 val;
>> +};
>> +
>> +#if (IS_ENABLED(CONFIG_K3_QOS))
>> +extern struct k3_qos_data qos_data[];
>> +extern u32 qos_count;
>> +#endif
>> +
>> +#endif /* _K3_QOS_H_ */
>> diff --git a/arch/arm/mach-k3/r5/am62ax/Makefile
>> b/arch/arm/mach-k3/r5/am62ax/Makefile
>> index 02a941805e9a..e4e55ce5c7dd 100644
>> --- a/arch/arm/mach-k3/r5/am62ax/Makefile
>> +++ b/arch/arm/mach-k3/r5/am62ax/Makefile
>> @@ -4,4 +4,4 @@
>>     obj-y += clk-data.o
>>   obj-y += dev-data.o
>> -obj-y += am62a_qos_data.o
>> +obj-y += am62a_qos_uboot.o
>> diff --git a/arch/arm/mach-k3/include/mach/am62a_qos.h
>> b/arch/arm/mach-k3/r5/am62ax/am62a_qos.h
>> similarity index 100%
>> rename from arch/arm/mach-k3/include/mach/am62a_qos.h
>> rename to arch/arm/mach-k3/r5/am62ax/am62a_qos.h
>> diff --git a/arch/arm/mach-k3/r5/am62ax/am62a_qos_data.c
>> b/arch/arm/mach-k3/r5/am62ax/am62a_qos_uboot.c
>> similarity index 85%
>> rename from arch/arm/mach-k3/r5/am62ax/am62a_qos_data.c
>> rename to arch/arm/mach-k3/r5/am62ax/am62a_qos_uboot.c
>> index 38db4f2f5c8e..9a82944d5fe9 100644
>> --- a/arch/arm/mach-k3/r5/am62ax/am62a_qos_data.c
>> +++ b/arch/arm/mach-k3/r5/am62ax/am62a_qos_uboot.c
>> @@ -5,10 +5,11 @@
>>    *
>>    * Copyright (C) 2022 Texas Instruments Incorporated -
>> https://www.ti.com/
>>    */
>> -#include <asm/arch/hardware.h>
>> -#include "common.h"
>>   -struct k3_qos_data am62a_qos_data[] = {
>> +#include <asm/arch/k3-qos.h>
>> +#include "am62a_qos.h"
>> +
>> +struct k3_qos_data qos_data[] = {
>>       /* modules_qosConfig0 - 1 endpoints, 4 channels */
>>       {
>>           .reg = K3_DSS_UL_MAIN_0_VBUSM_DMA + 0x100 + 0x4 * 0,
>> @@ -43,4 +44,4 @@ struct k3_qos_data am62a_qos_data[] = {
>>       },
>>   };
>>   -uint32_t am62a_qos_count = sizeof(am62a_qos_data) /
>> sizeof(am62a_qos_data[0]);
>> +u32 qos_count = ARRAY_SIZE(qos_data);
>>
>> base-commit: daa3100250839dd30626f7f4b7daf041f1114f1c
