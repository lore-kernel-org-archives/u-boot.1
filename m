Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E467C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 13:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3537877E2;
	Fri, 10 Nov 2023 14:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="sg1gws49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3071E876E3; Fri, 10 Nov 2023 14:21:21 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6937F87809
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 14:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9678822151=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AA9mEJw021404; Fri, 10 Nov 2023 14:21:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=47RpwYXIA449T2dbkQsM/YKkKuehk1m2CZaKb5HbWkA=; b=sg
 1gws49INRsMIKdCvPsO/1g75CNxJkU5SqiuBdgxoxtZLmnxG2QgBz/BXH3NhjVOt
 HpIGuOjcx3m6PYMgRz5ZaTgfW6vjiDIGpXFTp4TR5qK7eNiVk1b+cxJTNRvTh5gY
 3vCEqNAdrQtmaLcIcvszErxiMYVKnVqxx9rApCw54Sj07Qa+oXRz0siAtU39olc/
 RV2ZtS4QGMAuFY8/8s19hby4vYd3ZdyFew4/ekncXKtYAwBW4xUelc+uTqt7E+XQ
 G53MPZmwy4dL1iYhQJ0QbHv0hGYZM2sylTvYW7HJAmDCU7MqD8uiKhJXX3ax6/NE
 +2iKQjtSHwYnI5T722NA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u84a5n1h5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 14:21:19 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AD901100056;
 Fri, 10 Nov 2023 14:21:18 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A6F2E25E53D;
 Fri, 10 Nov 2023 14:21:18 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 10 Nov
 2023 14:21:18 +0100
Message-ID: <a0b63137-8d10-4aa9-a012-00d4a99075dd@foss.st.com>
Date: Fri, 10 Nov 2023 14:21:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] stm32mp: dram_init: Limit DDR usage under 4GB
 boundary for STM32MP
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231027144304.1002307-1-patrice.chotard@foss.st.com>
 <20231027144304.1002307-5-patrice.chotard@foss.st.com>
 <6b6b7f17-039b-4e00-8bef-984d762ad98b@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <6b6b7f17-039b-4e00-8bef-984d762ad98b@foss.st.com>
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



On 11/9/23 10:13, Patrick DELAUNAY wrote:
> Hi,
> 
> On 10/27/23 16:42, Patrice Chotard wrote:
>> Limit DDR usage under 4GB boundary on STM32MP regardless of
>> memory size declared in device tree.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/mach-stm32mp/dram_init.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
>> index cb35ed60ca1..fb1208fc5d5 100644
>> --- a/arch/arm/mach-stm32mp/dram_init.c
>> +++ b/arch/arm/mach-stm32mp/dram_init.c
>> @@ -52,9 +52,15 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>>       if (!total_size)
>>           return gd->ram_top;
>>   +    /*
>> +     * make sure U-Boot uses address space below 4GB boundaries even
>> +     * if the effective available memory is bigger
>> +     */
>> +    gd->ram_top = clamp_val(gd->ram_top, 0, SZ_4G - 1);
>> +
>>       /* found enough not-reserved memory to relocated U-Boot */
>>       lmb_init(&lmb);
>> -    lmb_add(&lmb, gd->ram_base, get_effective_memsize());
>> +    lmb_add(&lmb, gd->ram_base, gd->ram_top - gd->ram_base);
>>       boot_fdt_add_mem_rsv_regions(&lmb, (void *)gd->fdt_blob);
>>       /* add 8M for reserved memory for display, fdt, gd,... */
>>       size = ALIGN(SZ_8M + CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE),
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/next

Thanks
Patrice
