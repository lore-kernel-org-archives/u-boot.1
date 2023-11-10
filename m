Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B9EC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 12:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEEC38777F;
	Fri, 10 Nov 2023 13:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="VNiV3y6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF2B787789; Fri, 10 Nov 2023 13:19:12 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2061F87692
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 13:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9678822151=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAAWj6K030948; Fri, 10 Nov 2023 13:19:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=VVgetucCz+3IoSlydssjrkwesEVrG5/ib2AV6afcaCo=; b=VN
 iV3y6nGc0d5GugB7U0Y6kg5s5aiJcKXZxZOOqk+I6F+4AU3TmPT7wQLjuj4b/tQx
 F9BoB2XmGbkNaZJDhcmEhb+nN82aPWHtYe4LblHnoSlEXOdaWHPU35m7UVr0QIvM
 7nLezqOBpCtXljYA0pxhWrwEhYGEaSxLXj969+y+0nvgVpJW4qa2GT04NUSJfLXb
 QoTgbQqECutYOihoeKCRMqDfkslCJJ06XqEQwGMD3xAQZQN3FhYuLa2gOFthD0mh
 yJhay/A2vNVvn6PyusOJTk6mwJrQJsh0F6CT2LXZWGhSDmYmDHoelnjREpA6wD4y
 ZyNjD4v+FrjdFBeb69cg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w26nyx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 13:19:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3FAB2100056;
 Fri, 10 Nov 2023 13:19:02 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3753427ED5F;
 Fri, 10 Nov 2023 13:19:02 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 10 Nov
 2023 13:19:01 +0100
Message-ID: <587f86cf-7987-4967-bf16-0f227509c712@foss.st.com>
Date: Fri, 10 Nov 2023 13:19:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm: stm32mp: Really fix compilation issue when
 SYS_DCACHE_OFF and/or SYS_DCACHE_SYS are enabled
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>, <u-boot@lists.denx.de>
CC: <sjg@chromium.org>, <trini@konsulko.com>, <bhupesh.linux@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20230822075112.717992-1-bhupesh.sharma@linaro.org>
 <20230822075112.717992-2-bhupesh.sharma@linaro.org>
 <14fb20a4-e394-5035-1a4f-dd3511db7471@foss.st.com>
In-Reply-To: <14fb20a4-e394-5035-1a4f-dd3511db7471@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.54]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_09,2023-11-09_01,2023-05-22_02
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



On 8/25/23 10:53, Patrice CHOTARD wrote:
> 
> 
> On 8/22/23 09:51, Bhupesh Sharma wrote:
>> While 23e20b2fa6 ("arm: stm32mp: Fix compilation issue when
>> SYS_DCACHE_OFF and/or SYS_DCACHE_SYS are enabled") tried fixing
>> this issue, fix it really by adding #if checks for SYS_ICACHE_OFF
>> and SYS_DCACHE_OFF.
>>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>  arch/arm/mach-stm32mp/cpu.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/cpu.c b/arch/arm/mach-stm32mp/cpu.c
>> index e2f67fc423..8ed065b389 100644
>> --- a/arch/arm/mach-stm32mp/cpu.c
>> +++ b/arch/arm/mach-stm32mp/cpu.c
>> @@ -90,10 +90,10 @@ static void early_enable_caches(void)
>>  	if (CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
>>  		return;
>>  
>> -	if (!(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))) {
>> +#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
>>  		gd->arch.tlb_size = PGTABLE_SIZE;
>>  		gd->arch.tlb_addr = (unsigned long)&early_tlb;
>> -	}
>> +#endif
>>  
>>  	/* enable MMU (default configuration) */
>>  	dcache_enable();
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice

Applied to u-boot-stm32/master

Thanks
Patrice
