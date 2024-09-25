Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92043CCF9E7
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 18:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF997880D8;
	Wed, 25 Sep 2024 20:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="VDMpTUev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1F8086DBD; Wed, 25 Sep 2024 20:21:29 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E7888B63
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 20:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=999876f45b=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PDIxMm025799
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 20:21:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 KcoRiWNU7lAbkR95nhCdx/FoVnT3M6pnY+Gy8VvlfJU=; b=VDMpTUevvzSkS+ow
 +DgkG1JGa4GlsmSspeHOfbvO/29Gpy9EUqgjlO/mMiuGWqR/mPIhG4qyW0hJvImY
 QtOFV4GwDcq8ZYQtdpA1la+VF8/5r92M9b/F8BJn4qKz5AYOwdQuxMjozlhxL/zQ
 4I+lZHVOZ48magpBLqWC3B6Z8C5hYGfvMe4Ssm6dVP3zjTuSBuoerA9YgRoR0e5n
 Jd9d1zID/1HzbkLc7YYW0fX5hjIRNxGVARyHR7Fb59rIj8MYQmlk8dhWFDHdWGH1
 1R9P0zzM/OtKJJ8U3zAXc2lb9KABbFMU43RMO6t8A2xMdU1deLjsNXs5XmEM3eSn
 B7TynA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41sk95p6r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 20:21:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D36FA400B0
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 20:20:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 13E3B2C41E2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 20:19:34 +0200 (CEST)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 25 Sep
 2024 20:19:33 +0200
Message-ID: <bb75da38-8f56-4807-af61-299d1d3f4750@foss.st.com>
Date: Wed, 25 Sep 2024 20:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Fix secure_waitbits() mask check
To: <u-boot@lists.denx.de>
References: <20240708114344.18354-1-marex@denx.de>
 <38cac570-b496-4fde-85ed-9df63db7a99e@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <38cac570-b496-4fde-85ed-9df63db7a99e@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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


On 9/25/24 19:37, Patrick DELAUNAY wrote:
> Hi Marek,
>
> On 7/8/24 13:43, Marek Vasut wrote:
>> Do not apply bitwise AND to register value and expected value, only
>> apply bitwise AND to register value and mask, and only then compare
>> the result with expected value that the function polls for.
>>
>> Fixes: b49105320a5b ("stm32mp: psci: Implement PSCI system suspend 
>> and DRAM SSR")
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   arch/arm/mach-stm32mp/stm32mp1/psci.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/psci.c 
>> b/arch/arm/mach-stm32mp/stm32mp1/psci.c
>> index e99103910d9..ffdafea464d 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/psci.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/psci.c
>> @@ -393,8 +393,7 @@ static int __secure secure_waitbits(u32 reg, u32 
>> mask, u32 val)
>>       asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (start));
>>       for (;;) {
>>           tmp = readl(reg);
>> -        tmp &= mask;
>> -        if ((tmp & val) == val)
>> +        if ((tmp & mask) == val)
>>               return 0;
>>           asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (end));
>>           if ((end - start) > delay)
>
>
>
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Thanks
> Patrick
>



Applied to u-boot-stm/master, thanks!

Regards
Patrick


