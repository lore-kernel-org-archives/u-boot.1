Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC268C4167D
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 09:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A958D8713C;
	Thu,  9 Nov 2023 10:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="g9zdVF4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD228714A; Thu,  9 Nov 2023 10:11:28 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 608ED87013
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 10:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9677b570d6=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3A95ZWei023669; Thu, 9 Nov 2023 10:11:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=mes6WEkHQA0LThhK0RPfQMEfWhGzU3DNOYaCc3TuD9M=; b=g9
 zdVF4AV9uhUChUQSdQsGXMhYjD4dz6rIQ8upFZlEtUPXUYVkkcZ0T+UNXctMsu0z
 x+njlhGbOWeeIMG9toI6P+H+k7EjHdZ6Apiaz8Vv6NtESZZmpekhQFOoxfEfoHZP
 vN+NALMgc4XHkOMtAZcjMYbOkojWC+ls4Ch14JHVM5i+0O9ceRkwPS7tZHDq/liC
 rWcreLxxg2ztO+cNSic05Oay5IwE9ZVpvx8TN8X7JP7wktmNd+VdQAQSOEWVUNwN
 0fhjbjFDaVk2fM/bMYUSn1Lc1usmnPCkTO/wbo/sBmMDy5l/CwGr15s5ZVxN0MQt
 C2or+N37l5cf322SxzWQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u8sdns072-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 10:11:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A341110005A;
 Thu,  9 Nov 2023 10:11:16 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7CFE42053B5;
 Thu,  9 Nov 2023 10:11:16 +0100 (CET)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 Nov
 2023 10:11:16 +0100
Message-ID: <ca42a456-594f-4b7c-b472-8031412055e7@foss.st.com>
Date: Thu, 9 Nov 2023 10:11:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] arm: caches: Make DCACHE_DEFAULT_OPTION accessible
 for ARM64 arch
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Andre Przywara
 <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20231027144304.1002307-1-patrice.chotard@foss.st.com>
 <20231027144304.1002307-2-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20231027144304.1002307-2-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_07,2023-11-08_01,2023-05-22_02
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

On 10/27/23 16:42, Patrice Chotard wrote:
> This fixes the following compilation error in ARM64:
> arch/arm/mach-stm32mp/dram_init.c: In function ‘board_get_usable_ram_top’:
> arch/arm/mach-stm32mp/dram_init.c:59:45: error: ‘DCACHE_DEFAULT_OPTION’ undeclared (first use in this function)
>     59 |  mmu_set_region_dcache_behaviour(reg, size, DCACHE_DEFAULT_OPTION);
>        |                                             ^~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/include/asm/system.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 0eae857e73a..43f7503571d 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -513,14 +513,6 @@ enum dcache_option {
>   };
>   #endif
>   
> -#if defined(CONFIG_SYS_ARM_CACHE_WRITETHROUGH)
> -#define DCACHE_DEFAULT_OPTION	DCACHE_WRITETHROUGH
> -#elif defined(CONFIG_SYS_ARM_CACHE_WRITEALLOC)
> -#define DCACHE_DEFAULT_OPTION	DCACHE_WRITEALLOC
> -#elif defined(CONFIG_SYS_ARM_CACHE_WRITEBACK)
> -#define DCACHE_DEFAULT_OPTION	DCACHE_WRITEBACK
> -#endif
> -
>   /* Size of an MMU section */
>   enum {
>   #ifdef CONFIG_ARMV7_LPAE
> @@ -578,6 +570,14 @@ void psci_system_reset(void);
>   
>   #endif /* CONFIG_ARM64 */
>   
> +#if defined(CONFIG_SYS_ARM_CACHE_WRITETHROUGH)
> +#define DCACHE_DEFAULT_OPTION	DCACHE_WRITETHROUGH
> +#elif defined(CONFIG_SYS_ARM_CACHE_WRITEALLOC)
> +#define DCACHE_DEFAULT_OPTION	DCACHE_WRITEALLOC
> +#elif defined(CONFIG_SYS_ARM_CACHE_WRITEBACK)
> +#define DCACHE_DEFAULT_OPTION	DCACHE_WRITEBACK
> +#endif
> +
>   #ifndef __ASSEMBLY__
>   /**
>    * save_boot_params() - Save boot parameters before starting reset sequence



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


