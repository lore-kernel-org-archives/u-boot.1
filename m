Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5226DC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 14:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7928987BE1;
	Fri, 19 Jan 2024 15:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="3wuMJaQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A2F987BB4; Fri, 19 Jan 2024 15:50:16 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F9D87BF6
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 15:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=17487c629f=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40JDZa1j028640; Fri, 19 Jan 2024 15:50:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=oiCTDR5NjZt3M37SDqZelyP+cjxXkHjSjojP+oIAv/c=; b=3w
 uMJaQtU44wfsQgqI59B4Q6NpTKEBmAjSXbvqni9Lj90a7hiqELy22TI7gvsk7FQT
 c3PHndzB+Ha0aWXMC95nHzY0ZEyflrAv6iIN9wRxOROUk+zobw8FxLvaDjh2ZwG4
 geKga1C/bQE8+Jn/TttMR7VCTmyCkDiw0TnCj9tF401kW2KA4tDj4mVyplxn7+YD
 5v9tdaP83h4HhCXsLq0bDNPXF6DsIAtGQ/V8zxrjwWYNLPCRVvDkZxE3KfQKmwyl
 E0TFQ1juHMtfwtzoJHjFgi6d9QdxYjbbVDZxfvxPuckT/0ZrcJF2+dTlUMNPDC4J
 iHeLA22EyxjZHF0D+ftw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmfyxpdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 15:50:13 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 83683100081;
 Fri, 19 Jan 2024 15:50:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 78F3825E53B;
 Fri, 19 Jan 2024 15:50:12 +0100 (CET)
Received: from [10.252.4.250] (10.252.4.250) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Jan
 2024 15:50:12 +0100
Message-ID: <ee90da1b-0b59-47a7-9aa7-6dd1f0231f29@foss.st.com>
Date: Fri, 19 Jan 2024 15:50:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp2: Fix CONFIG_STM32MP25X flag usage
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Igor Opaniuk
 <igor.opaniuk@foundries.io>, Marek Vasut <marex@denx.de>, Oleksandr Suvorov
 <oleksandr.suvorov@foundries.io>
References: <20240109140018.2015396-1-patrice.chotard@foss.st.com>
 <ea333297-abc4-4807-bd52-506b44703aa8@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ea333297-abc4-4807-bd52-506b44703aa8@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.4.250]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_08,2024-01-19_02,2023-05-22_02
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



On 1/19/24 15:45, Patrick DELAUNAY wrote:
> Hi
> 
> On 1/9/24 15:00, Patrice Chotard wrote:
>> "#if" was used instead of "#ifdef"
>>
>> Fixes: 01a701994b05 ("stm32mp2: initial support")
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/mach-stm32mp/include/mach/stm32.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
>> index 46d469881b3..175f2a88490 100644
>> --- a/arch/arm/mach-stm32mp/include/mach/stm32.h
>> +++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
>> @@ -157,7 +157,7 @@ enum forced_boot_mode {
>>   #endif /* __ASSEMBLY__ */
>>   #endif /* CONFIG_STM32MP15X || CONFIG_STM32MP13X */
>>   -#if CONFIG_STM32MP25X
>> +#ifdef CONFIG_STM32MP25X
>>   #define STM32_RCC_BASE            0x44200000
>>   #define STM32_TAMP_BASE            0x46010000
>>   
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/master

Thanks
Patrice
