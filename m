Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DA8C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 08:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DDC380F5F;
	Fri, 31 Jan 2025 09:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="qnr3VflJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F37A80F95; Fri, 31 Jan 2025 09:12:55 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE8E80F0E
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 09:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41261629dd=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V80w1f004436;
 Fri, 31 Jan 2025 09:12:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 MKF/Y7Hw35SBgQ6SHtzvHjDxhPtgBlbLDyRRvBOEjnk=; b=qnr3VflJUCnGv9GU
 ikJcWWRKL7jD3orKEN7de5AzNlBfmqAydizJ/34Cvd7UQTyLegbpzND9BNiK6D7C
 UbJArJZm0TtTdIuv0m1BFPdpuX/esbi5+9Ut4z2dOLNO7CquLNOdduCbApW4z9m7
 GGbdOn7M29VOzyNJC4fPlp4DZNiQMQkXIfyAQeKCHTvsn5zpWHNh+HCL+LxioN1V
 MKZUBHBLJvtxcmuB9p0lmDDDrYyh4c3xCz9Vpf5jr6o45+lTFGgTsoU/QWjGx75z
 U0PtS0nuzziVKkHFOm4R3YXmQFXDM/c0ZxO53izAbG6P9p0tmXtxNV2d4SoD6rTJ
 guDkJg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gf7dsugd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 09:12:51 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5E38940044;
 Fri, 31 Jan 2025 09:11:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 549002BB0B4;
 Fri, 31 Jan 2025 09:07:42 +0100 (CET)
Received: from [10.252.27.7] (10.252.27.7) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 31 Jan
 2025 09:07:41 +0100
Message-ID: <1fee5237-6a84-409b-9c7d-df6406904000@foss.st.com>
Date: Fri, 31 Jan 2025 09:07:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] stm32mp: Fix board_get_usable_ram_top()
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250109102148.1733810-1-patrice.chotard@foss.st.com>
 <20250109102148.1733810-2-patrice.chotard@foss.st.com>
 <d160b160-af0f-4803-802b-567174921679@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <d160b160-af0f-4803-802b-567174921679@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.27.7]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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



On 1/30/25 11:51, Patrick DELAUNAY wrote:
> Hi,
> 
> On 1/9/25 11:21, Patrice Chotard wrote:
>> mmu_set_region_dcache_behaviour() parameters must be aligned
>> which is not always the case.
>> For example for STM32MP2, we stayed stuck inside
>> mmu_set_region_dcache_behaviour() in an infinite loop because
>> set_one_region() always return 0 due to start parameter which is
>> not aligned.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/mach-stm32mp/dram_init.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
>> index b06105768b3..34b958d7afd 100644
>> --- a/arch/arm/mach-stm32mp/dram_init.c
>> +++ b/arch/arm/mach-stm32mp/dram_init.c
>> @@ -81,7 +81,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>>       /* add 8M for U-Boot reserved memory: display, fdt, gd,... */
>>       size = ALIGN(SZ_8M + CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE);
>>   -    reg = gd->ram_top - size;
>> +    reg = ALIGN(gd->ram_top - size, MMU_SECTION_SIZE);
>>         /* Reserved memory for OP-TEE at END of DDR for STM32MP1 SoC */
>>       if (IS_ENABLED(CONFIG_STM32MP13X) || IS_ENABLED(CONFIG_STM32MP15X)) {
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
Applied to u-boot-stm32/master

Thanks
Patrice
