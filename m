Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5096BC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 13:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04418877B6;
	Fri, 10 Nov 2023 14:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="lii127Mu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB667877D4; Fri, 10 Nov 2023 14:20:49 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA3A3876E3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 14:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9678822151=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AADAguh002479; Fri, 10 Nov 2023 14:20:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=h0tN4jaMzy51YpPv53zw1WyPFUCEhVuQdZX+TZMTqgk=; b=li
 i127MuXf5gWjKJvYTmzgdxpeyJXyvsT6wa8VuJ9cKKNYOJzkKH2PuOhilOdaNBRy
 cW1Z/U7q5fBupL/1AWV022fzkYXCuHnKFftXbr3pyK7h9L/7Zqj2XpppcdXvxzB9
 JMWvq/oq5HFyAeRSbDlnO8Re8pPQzV8N0uovQHClPxuwebRhdySuRU0aWzOfMcI0
 9yu1eQHmFLpxGSfi0z8foFUpyF54z6paOBvAK9xUFlwbuxzA4hUI7SOHqg1tgXhB
 xHQRn6Qza/Cl15F9o8GhJya6anz7gSeOStRSuBQ7/kFwxF36LIiQ/z1rf8XEjPRx
 /nfLdENqEfU7aiqj8Wmg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w26p8h4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 14:20:41 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 12B9E100056;
 Fri, 10 Nov 2023 14:20:39 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DD3C625E535;
 Fri, 10 Nov 2023 14:20:39 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 10 Nov
 2023 14:20:39 +0100
Message-ID: <ffbd0946-57a5-48bd-9ace-d1ff7b9feab3@foss.st.com>
Date: Fri, 10 Nov 2023 14:20:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] arm: caches: Make DCACHE_DEFAULT_OPTION accessible
 for ARM64 arch
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Andre Przywara
 <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20231027144304.1002307-1-patrice.chotard@foss.st.com>
 <20231027144304.1002307-2-patrice.chotard@foss.st.com>
 <ca42a456-594f-4b7c-b472-8031412055e7@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ca42a456-594f-4b7c-b472-8031412055e7@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.54]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_10,2023-11-09_01,2023-05-22_02
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



On 11/9/23 10:11, Patrick DELAUNAY wrote:
> Hi,
> 
> On 10/27/23 16:42, Patrice Chotard wrote:
>> This fixes the following compilation error in ARM64:
>> arch/arm/mach-stm32mp/dram_init.c: In function ‘board_get_usable_ram_top’:
>> arch/arm/mach-stm32mp/dram_init.c:59:45: error: ‘DCACHE_DEFAULT_OPTION’ undeclared (first use in this function)
>>     59 |  mmu_set_region_dcache_behaviour(reg, size, DCACHE_DEFAULT_OPTION);
>>        |                                             ^~~~~~~~~~~~~~~~~~~~~
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/include/asm/system.h | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
>> index 0eae857e73a..43f7503571d 100644
>> --- a/arch/arm/include/asm/system.h
>> +++ b/arch/arm/include/asm/system.h
>> @@ -513,14 +513,6 @@ enum dcache_option {
>>   };
>>   #endif
>>   -#if defined(CONFIG_SYS_ARM_CACHE_WRITETHROUGH)
>> -#define DCACHE_DEFAULT_OPTION    DCACHE_WRITETHROUGH
>> -#elif defined(CONFIG_SYS_ARM_CACHE_WRITEALLOC)
>> -#define DCACHE_DEFAULT_OPTION    DCACHE_WRITEALLOC
>> -#elif defined(CONFIG_SYS_ARM_CACHE_WRITEBACK)
>> -#define DCACHE_DEFAULT_OPTION    DCACHE_WRITEBACK
>> -#endif
>> -
>>   /* Size of an MMU section */
>>   enum {
>>   #ifdef CONFIG_ARMV7_LPAE
>> @@ -578,6 +570,14 @@ void psci_system_reset(void);
>>     #endif /* CONFIG_ARM64 */
>>   +#if defined(CONFIG_SYS_ARM_CACHE_WRITETHROUGH)
>> +#define DCACHE_DEFAULT_OPTION    DCACHE_WRITETHROUGH
>> +#elif defined(CONFIG_SYS_ARM_CACHE_WRITEALLOC)
>> +#define DCACHE_DEFAULT_OPTION    DCACHE_WRITEALLOC
>> +#elif defined(CONFIG_SYS_ARM_CACHE_WRITEBACK)
>> +#define DCACHE_DEFAULT_OPTION    DCACHE_WRITEBACK
>> +#endif
>> +
>>   #ifndef __ASSEMBLY__
>>   /**
>>    * save_boot_params() - Save boot parameters before starting reset sequence
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
Applied to u-boot-stm32/next

Thanks
Patrice
