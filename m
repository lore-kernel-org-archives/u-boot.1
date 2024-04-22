Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE98C07E8E
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 14:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F8EA88417;
	Mon, 22 Apr 2024 16:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="HX/kbzX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1170887E9; Mon, 22 Apr 2024 16:05:07 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD080883F1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 16:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=48420cdc94=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MCqrJ7017691;
 Mon, 22 Apr 2024 16:04:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=42kzQ5wSvzlCpebnRRBxceh98d5cLCzKEzGRMSDxxNU=; b=HX
 /kbzX96eTWKNKcxXHBmV4ANjqDcdDQ9qiTz4JI85KXlupE/M60Pt4rCTtazIsp13
 Tsyt5RQefteoMlZvSkzDJLG4j7aa7uKslF1fhySgUqQtLlhyfKwOpL+LwJEF1dn3
 W6xk8j5/xF1ALGZIsFKZ+p4dlcnZdRcJGX6d4vMHTlgUyawTlz3EmhNFVUvDuzPD
 bW9ykrzlqU8InY5fOVWIqB0T82h459TenkKMYEQ8hD/j05AnUSLJ6rzeMsrAh6XH
 6YPw2My1mOu115jfnZxL1fI6GCGwET90zboLxFfzyFMhIk8VzmsHLeyEJjTxBmcw
 VKfZk6j2JhEwunrjGMqQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4edq8np-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Apr 2024 16:04:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 52D054004C;
 Mon, 22 Apr 2024 16:04:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3D60521D3CA;
 Mon, 22 Apr 2024 16:04:29 +0200 (CEST)
Received: from [10.48.86.98] (10.48.86.98) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 16:04:28 +0200
Message-ID: <5fa3539a-8bb3-41dd-b5cd-c22d11d20f5d@foss.st.com>
Date: Mon, 22 Apr 2024 16:04:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH] stm32mp: Reserve OPTEE area in EFI memory
 map
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
References: <20240308101230.2595220-1-patrice.chotard@foss.st.com>
 <3512e31e-37db-4e03-b133-1914e29fa7ad@foss.st.com>
 <24c03e51-90f8-4918-8097-2a6ccd6ebf4e@gmx.de>
 <c35863dd-65dc-4f85-ac62-d99c9c6addb1@foss.st.com>
In-Reply-To: <c35863dd-65dc-4f85-ac62-d99c9c6addb1@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.98]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
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



On 4/19/24 09:44, Patrice CHOTARD wrote:
> 
> 
> On 4/17/24 09:45, Heinrich Schuchardt wrote:
>> On 17.04.24 09:25, Patrick DELAUNAY wrote:
>>> Hi,
>>>
>>> On 3/8/24 11:12, Patrice Chotard wrote:
>>>> Since commit 7b78d6438a2b3 ("efi_loader: Reserve unaccessible memory")
>>>> memory region above ram_top is tagged in EFI memory map as
>>>> EFI_BOOT_SERVICES_DATA.
>>>> In case of STM32MP1 platform, above ram_top, there is one reserved-memory
>>>> region tagged "no-map" dedicated to OP-TEE (addr=de000000 size=2000000).
>>>>
>>>> Before booting kernel, EFI memory map is first built, the OPTEE region is
>>>> tagged as EFI_BOOT_SERVICES_DATA and when reserving LMB, the tag LMB_NONE
>>>> is used.
>>>>
>>>> Then after, the LMB are completed by boot_fdt_add_mem_rsv_regions()
>>>> which try to add again the same OPTEE region (addr=de000000 size=2000000)
>>>> but now with LMB_NOMAP tag which produces the following error message :
>>>>
>>>> "ERROR: reserving fdt memory region failed (addr=de000000 size=2000000
>>>> flags=4)"
>>>>
>>>> To avoid this, OPTEE area shouldn't be used by EFI, so we need to mark
>>>> it as reserved.
>>>>
>>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>> ---
>>>>
>>>>   arch/arm/mach-stm32mp/dram_init.c | 12 ++++++++++++
>>>>   1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-stm32mp/dram_init.c
>>>> b/arch/arm/mach-stm32mp/dram_init.c
>>>> index fb1208fc5d5..f67f54f2ae0 100644
>>>> --- a/arch/arm/mach-stm32mp/dram_init.c
>>>> +++ b/arch/arm/mach-stm32mp/dram_init.c
>>>> @@ -7,6 +7,7 @@
>>>>   #include <common.h>
>>>>   #include <dm.h>
>>>> +#include <efi_loader.h>
>>>>   #include <image.h>
>>>>   #include <init.h>
>>>>   #include <lmb.h>
>>>> @@ -75,3 +76,14 @@ phys_addr_t board_get_usable_ram_top(phys_size_t
>>>> total_size)
>>>>       return reg + size;
>>>>   }
>>>> +
>>>> +void efi_add_known_memory(void)
>>>> +{
>>>> +    if (IS_ENABLED(CONFIG_EFI_LOADER))
>>>> +        /*
>>>> +         * Memory over ram_top is reserved to OPTEE.
>>>> +         * Declare to EFI only memory area below ram_top
>>>> +         */
>>>> +        efi_add_memory_map(gd->ram_base, gd->ram_top - gd->ram_base,
>>>> +                   EFI_CONVENTIONAL_MEMORY);
>>
>> With this change the EFI memory map passed to the operating system will
>> not contain any memory above gd->ram_top. Is this really your intent?
>> Don't you have any memory above 0xe0000000?
> 
> Hi Heinrich
> 
> On stm32mp157x-dk and stm32mp135x-dk boards, there is no memory above 0xe0000000.
> But, on stm32mp157x-ed1 or stm32mp157x-ev1, you are right, we got memory above 0xe0000000.
> 
> I will rework this patch to take into account memory that could be present above OPTEE area.

After double checking, this patch is correct but i need to update the commit message.

In fact for stm32mp157x-dk and stm32mp135x-dk boards, there is 512MB of memory (0xc0000000 0x20000000),
OPTEE is located at the end of memory : 0xde000000 0x02000000

But for stm32mp157c-ev1, there is 1GB of memory (0xC0000000 0x40000000), and identically,
OPTEE is located at the end of memory : 0xfe000000 0x2000000

So in both cases, above OPTEE reserved-memory area, there is no more free memory.

Thanks
Patrice

> 
> Thanks for pointing this
> Patrice
> 
>>
>> Best regards
>>
>> Heinrich
>>
>>>> +}
>>>
>>>
>>>
>>> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>
>>> Thanks
>>> Patrick
>>>
>>
> _______________________________________________
> Uboot-stm32 mailing list
> Uboot-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/uboot-stm32
