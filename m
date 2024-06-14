Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C95EC27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 09:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D44DB889A3;
	Fri, 14 Jun 2024 11:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="hU+Anx6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2C84889A7; Fri, 14 Jun 2024 11:34:06 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E54D3889A4
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 11:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6895721e93=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E7aUih027856;
 Fri, 14 Jun 2024 11:34:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 hIG8v2SrcgkP98b1v9d9rpONwtFSzszjUIpY9UVkL4A=; b=hU+Anx6Ml38ymCRY
 803PixTO1RbKrC9w9+8UG1gnCic/iKFvvPeXW16Nnyuj1WamajUg+9W2TdBcOiGq
 JjIEQe/tQKqlb+Eq+0Nnb7E+rG9Swsqgk0UwgKM1fanau6FRX7q6f29aUznfBO7S
 u3fLlAOH3NEaHEIwML/77e5FEt6vqwFhxys9YuyB0jqJHltWOH9sslgdME22hI2e
 Qo+FU1eR5CGGcuW1biQe5or8tjNwgvCXr3VZ24T+/Ddr46TmnxsUNvCj9EneW0ZC
 4WbDdmqniai8DUgyA4Z6mnAKLyKiZDrcxnoLJaAk7d5ItqU/3JbqwBwXlMAha8Cv
 YUrDYw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp2qv19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 11:34:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9722D40045;
 Fri, 14 Jun 2024 11:33:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D2604210F9D;
 Fri, 14 Jun 2024 11:33:44 +0200 (CEST)
Received: from [10.252.18.60] (10.252.18.60) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 11:33:44 +0200
Message-ID: <983174d3-a99e-4c85-b0d4-9c02971b7cd5@foss.st.com>
Date: Fri, 14 Jun 2024 11:33:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] stm32mp1: spl: Fix compilation warnings
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20240611095239.16026-1-patrice.chotard@foss.st.com>
 <a19faecc-1d0a-4369-b51e-428ffaf00451@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <a19faecc-1d0a-4369-b51e-428ffaf00451@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.18.60]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
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



On 6/14/24 09:59, Patrick DELAUNAY wrote:
> Hi Patrice,
> 
> On 6/11/24 11:52, Patrice Chotard wrote:
>> Fix the following compilation warnings :
>>
>> ../arch/arm/mach-stm32mp/stm32mp1/spl.c: In function 'stm32_init_tzc_for_optee':
>> ../arch/arm/mach-stm32mp/stm32mp1/spl.c:148:37: warning: 'optee_size' may be used uninitialized [-Wmaybe-uninitialized]
>>    148 |         tee_shmem_base = optee_base + optee_size - CFG_SHMEM_SIZE;
>>        |                          ~~~~~~~~~~~^~~~~~~~~~~~
>> ../arch/arm/mach-stm32mp/stm32mp1/spl.c:137:30: note: 'optee_size' was declared here
>>    137 |         uint32_t optee_base, optee_size, tee_shmem_base;
>>        |                              ^~~~~~~~~~
>> ../arch/arm/mach-stm32mp/stm32mp1/spl.c:148:37: warning: 'optee_base' may be used
>> uninitialized [-Wmaybe-uninitialized]
>>    148 |         tee_shmem_base = optee_base + optee_size - CFG_SHMEM_SIZE;
>>        |                          ~~~~~~~~~~~^~~~~~~~~~~~
>> ../arch/arm/mach-stm32mp/stm32mp1/spl.c:137:18: note: 'optee_base' was declared here
>>    137 |         uint32_t optee_base, optee_size, tee_shmem_base;
>>        |                  ^~~~~~~~~~
>>
>> Fix also the following checkpatch "check" :
>>
>> CHECK: Prefer kernel type 'u32' over 'uint32_t'
>> 37: FILE: arch/arm/mach-stm32mp/stm32mp1/spl.c:137:
>> +    uint32_t optee_base = 0, optee_size = 0, tee_shmem_base;
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/mach-stm32mp/stm32mp1/spl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
>> index 6c79259b2c8..10abbed87f0 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
>> @@ -134,7 +134,7 @@ void stm32_init_tzc_for_optee(void)
>>   {
>>       const uint32_t dram_size = stm32mp_get_dram_size();
>>       const uintptr_t dram_top = STM32_DDR_BASE + (dram_size - 1);
>> -    uint32_t optee_base, optee_size, tee_shmem_base;
>> +    u32 optee_base = 0, optee_size = 0, tee_shmem_base;
>>       const uintptr_t tzc = STM32_TZC_BASE;
>>       int ret;
>>   
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
