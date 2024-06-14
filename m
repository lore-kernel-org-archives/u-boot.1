Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CEAC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D38B9831A1;
	Fri, 14 Jun 2024 13:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZYOk24Bn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9375D83333; Fri, 14 Jun 2024 13:54:17 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 909BF80E9A
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6895721e93=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EBOkuh015671;
 Fri, 14 Jun 2024 13:54:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 8uozvjORJLppsfrnCH1Kki0wqb6RN8oq+zrAv/hg1Gc=; b=ZYOk24BnGZGOHIqL
 3dkMOXjGcDP5MMDDZj42sEiZSsdhs10KMxFcSpcVIRuIRzZSRfo6vsdPZiIlgCAE
 J9htLsDt4fPXV8Xs/gDZzr5hZhkd5GLFDqgebYZ6FxTrE2f9uktyCm0k01Mo0llQ
 MAAvxVcvTREll3HXr3YtVEdG0ZEerVKHvG6baj2Sd/P8Va/tW7rYWKcoXuUoURK/
 6FPwtczfMz2AWco20uiW6iytmEGg6N6Z2gZsiK6zoXVmAj3HAtAYUjPZiqfnitZu
 ur6hkL6Kllcox5s2SEXtSfHaSYnq4dIwjCX9usCxc/UfRM+FDhtR/p2VVZSiX9Hx
 xuhBQA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypub3mk6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 13:54:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 26DA14002D;
 Fri, 14 Jun 2024 13:54:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 590292132D6;
 Fri, 14 Jun 2024 13:53:50 +0200 (CEST)
Received: from [10.252.18.60] (10.252.18.60) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 13:53:49 +0200
Message-ID: <ea1fe5dc-58cb-45f5-8254-b4253aed9986@foss.st.com>
Date: Fri, 14 Jun 2024 13:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] stm32mp: Reserve OPTEE area in EFI memory map
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
References: <20240422150645.1613198-1-patrice.chotard@foss.st.com>
 <2db8ee3c-6734-415f-b06c-e4a9a41ec291@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <2db8ee3c-6734-415f-b06c-e4a9a41ec291@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.18.60]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_09,2024-06-14_03,2024-05-17_01
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



On 6/14/24 10:43, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/22/24 17:06, Patrice Chotard wrote:
>> Since commit 7b78d6438a2b3 ("efi_loader: Reserve unaccessible memory")
>> memory region above ram_top is tagged in EFI memory map as
>> EFI_BOOT_SERVICES_DATA.
>> In case of STM32MP1/STM32MP13 platforms, above ram_top, there is one
>> reserved-memory region tagged "no-map" dedicated to OP-TEE :
>>   _ addr=de000000 size=2000000 for stm32mp157x-dkx and stm32mp135f-dk
>>   _ addr=fe000000 size=2000000 for stm32mp157c-ev1
>>
>> Before booting kernel, EFI memory map is first built, the OPTEE region is
>> tagged as EFI_BOOT_SERVICES_DATA and when reserving LMB, the tag LMB_NONE
>> is used.
>>
>> Then after, the LMB are completed by boot_fdt_add_mem_rsv_regions()
>> which try to add again the same OPTEE region (addr=de000000 size=2000000
>> in case of stm32mp157x-dkx / stm32mp135f-dk or addr=fe000000 size=2000000
>> in case for stm2mp157c-ev1)
>> but now with LMB_NOMAP tag which produces the following error message :
>>
>>   _ for stm32mp157x-dkx / stm32mp135f-dk :
>>    "ERROR: reserving fdt memory region failed (addr=de000000 size=2000000 flags=4)"
>>
>>   _ for stm32mp157c-ev1 :
>>    "ERROR: reserving fdt memory region failed (addr=fe000000 size=2000000 flags=4)"
>>
>> To avoid this, OPTEE area shouldn't be used by EFI, so we need to mark
>> it as reserved.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> ---
>>
>> Changes in v2:
>>   _ update commit message by adding information about memory area
>>     dedicated for OPTEE for various STM32MP1/STM32MP13 boards.
>>
>>   arch/arm/mach-stm32mp/dram_init.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
>> index fb1208fc5d5..f67f54f2ae0 100644
>> --- a/arch/arm/mach-stm32mp/dram_init.c
>> +++ b/arch/arm/mach-stm32mp/dram_init.c
>> @@ -7,6 +7,7 @@
>>     #include <common.h>
>>   #include <dm.h>
>> +#include <efi_loader.h>
>>   #include <image.h>
>>   #include <init.h>
>>   #include <lmb.h>
>> @@ -75,3 +76,14 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>>         return reg + size;
>>   }
>> +
>> +void efi_add_known_memory(void)
>> +{
>> +    if (IS_ENABLED(CONFIG_EFI_LOADER))
>> +        /*
>> +         * Memory over ram_top is reserved to OPTEE.
>> +         * Declare to EFI only memory area below ram_top
>> +         */
>> +        efi_add_memory_map(gd->ram_base, gd->ram_top - gd->ram_base,
>> +                   EFI_CONVENTIONAL_MEMORY);
>> +}
> 
> It seen like a temporary workaround after commit 7b78d6438a2b3
> ("efi_loader: Reserve unaccessible memory") to avoid warnings.
> 
> And it is working because in the default memory mapping
> OP-TEE base address == RAM_TOP and the rest of memory is
> used by OP-TEE tagged "no map" (protected by firewall)
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> FYI: workaround because  the memory above ram_top is
>      "already occupied by firmware" =
>      and it is OP-TEE for STM32MP2 platform.
> 
>     For me the LMB type used by EFI in not correct for OP-TEE usage region
>     with "no-map" tag in device tree=  see boot_fdt_add_mem_rsv_regions()
>     for linux DT parsing
> 
>     and we have no way to indicated this LMB tag= LMB_NOMAP with EFI stack
>     (with enum efi_memory_type ?)
> 
> 
>     EFI_BOOT_SERVICES_DATA => doesn't means NOMAP flag for LMB....
>     so something is missing in EFI side like EFI_BOOT_NOMAP  to be used in board
>     implementation of efi_add_known_memory() ?
> 
> 
> Thanks
> Patrick
> 
> 
> 
> 
> 


Applied to u-boot-stm32/next

Thanks
Patrice
