Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4861C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 09:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC2A58004F;
	Mon, 10 Mar 2025 10:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="i/mKOidC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36E2380017; Mon, 10 Mar 2025 10:00:17 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3BCA811C1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 10:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=5164540d7d=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A8P6xg023789;
 Mon, 10 Mar 2025 10:00:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 216KuYoTMtdPHVpXfA14RmFfMUwL9E8WJDCou5t5dl4=; b=i/mKOidCh6zuQq9X
 dQ7pX2DCqoOYZ7wCURZzUejKhWaVZGebip3r9bZ3f0fjgJRwfafzhZ/AhzK+pOg8
 BesDFpgNcWR9Cr5YYRxn84fbftyhj6FthVhvsSXWEpCUixxJVP4boI4/uh6/3q/Q
 CnUJzR4XR8ry//la5OAHXM4wLKGPlEDssB/+ZBEycW6DOUeDTRQRXh1+Z85Vrm3p
 gs//OqIIt72wuHIZc4mJ+opdIKw/+ggvxX5y5ZXq1xGebcJJHM4bkCFpyJuEMpgd
 6pA7nj+CwogimIkBNsssLV38s0RmFHARFno5i7/ZtEuosYmqWtPIUwS4uXia5tb+
 ZzdvEQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 458exph1f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 10:00:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 639D340052;
 Mon, 10 Mar 2025 09:59:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7413C57A341;
 Mon, 10 Mar 2025 09:58:25 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 09:58:24 +0100
Message-ID: <c4b97740-ea40-44af-b92f-46cf6e62480b@foss.st.com>
Date: Mon, 10 Mar 2025 09:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32mp: Fix dram_bank_mmu_setup() for ram_top=0
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250309020623.1605623-1-marex@denx.de>
 <e31a9e73-75b0-420d-acb5-a706bbddb1be@foss.st.com>
Content-Language: en-US
In-Reply-To: <e31a9e73-75b0-420d-acb5-a706bbddb1be@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_03,2025-03-07_03,2024-11-22_01
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



On 3/10/25 09:24, Patrice CHOTARD wrote:
> 
> 
> On 3/9/25 03:05, Marek Vasut wrote:
>> On STM32MP15xx with 1 GiB of DRAM, the gd->ram_top becomes 0,
>> because DRAM base 0xc0000000 + DRAM size 0x40000000 leads to
>> gd->ram_top overflow which resets it to 0. Handle this special
>> case simply by checking for gd->ram_top being zero, and if it
>> is, assume there is no addr >= gd->ram_top .
>>
>> This fixes boot hang on STM32MP15xx with 1 GiB of DRAM.
>>
>> Fixes: 25fb58e88aba ("ARM: stm32mp: Fix dram_bank_mmu_setup() for LMB located above ram_top")
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Lukasz Majewski <lukma@denx.de>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>  arch/arm/mach-stm32mp/stm32mp1/cpu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> index cb1b84c9af9..d5eaf6711b6 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> @@ -82,7 +82,7 @@ void dram_bank_mmu_setup(int bank)
>>  		option = DCACHE_DEFAULT_OPTION;
>>  		if (use_lmb &&
>>  		    (lmb_is_reserved_flags(i << MMU_SECTION_SHIFT, LMB_NOMAP) ||
>> -		    addr >= gd->ram_top)
>> +		     (gd->ram_top && addr >= gd->ram_top))
>>  		   )
>>  			option = 0; /* INVALID ENTRY in TLB */
>>  		set_section_dcache(i, option);
> 
> 
> Hi Marek
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
> 

Applied to u-boot-stm32/master

Thanks
Patrice
