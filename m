Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3F7C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C4DB82B07;
	Mon,  9 Jun 2025 10:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="qt9wF8zH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C532F82B3D; Mon,  9 Jun 2025 10:57:42 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B48E082A36
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82553fdf62=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5597m2FE016947;
 Mon, 9 Jun 2025 10:57:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Z62LuLO4zjdyr0KsdGOGx1v/HdNPv4JYGbquqichOcY=; b=qt9wF8zHyPoFsRtW
 9UzXbOIvMdBRAEJwsgwvjxolpUIwYFbGfRJKuyGv5XUGUpbUd17R4InxRkhWMRR7
 7UC0I5+nF6X8GLOcgm930O6GPZCUtxCuFm1RpO+nSSa0Xbx/822amlrPfpV62j6B
 btsKoTJQQnoOnS0zFe+j1pqw+ITB841Ij6SAqpyECwPNbJouMhvW07biqXqyFDAf
 2aIc5LIiOAcAKx2TeGjKUCSRgAvvoYkksgQ3/2RWEN2perMHEjJ8epQrNukKYIgb
 l/7ajFfW2y+m7i8M4QW+REhMrPCvnUw1Ax8DEQG6lQETMsulxv3QrWEEYNeqWZHj
 0wuc8A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474cahe6k7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 10:57:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 898A640082;
 Mon,  9 Jun 2025 10:56:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 88F2EB6BAC8;
 Mon,  9 Jun 2025 10:54:51 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 10:54:51 +0200
Message-ID: <a6e6b8df-9a46-45fc-8b4b-cff9af1c503b@foss.st.com>
Date: Mon, 9 Jun 2025 10:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Fix DBGMCU macro on STM32MP13xx
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250512164456.147764-1-marek.vasut@mailbox.org>
 <9a39e3d0-315b-43ee-b288-92860e8c4762@foss.st.com>
Content-Language: en-US
In-Reply-To: <9a39e3d0-315b-43ee-b288-92860e8c4762@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_03,2025-06-05_01,2025-03-28_01
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



On 5/21/25 15:59, Patrice CHOTARD wrote:
> 
> 
> On 5/12/25 18:44, Marek Vasut wrote:
>> The DBGMCU block is available at address 0x50081000 both on STM32MP13xx
>> and on STM32MP15xx . There is no reason to limit the DBGMCU macro being
>> set only on STM32MP15xx , remove the ifdeffery.
>>
>> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>  arch/arm/mach-stm32mp/include/mach/stm32.h | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
>> index 47b459b75d1..dfba57e7dc4 100644
>> --- a/arch/arm/mach-stm32mp/include/mach/stm32.h
>> +++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
>> @@ -78,9 +78,7 @@ enum forced_boot_mode {
>>  #define STM32_RCC_BASE			0x50000000
>>  #define STM32_PWR_BASE			0x50001000
>>  #define STM32_SYSCFG_BASE		0x50020000
>> -#ifdef CONFIG_STM32MP15X
>>  #define STM32_DBGMCU_BASE		0x50081000
>> -#endif
>>  #define STM32_FMC2_BASE			0x58002000
>>  #define STM32_IWDG2_BASE		0x5A002000
>>  #define STM32_DDRCTRL_BASE		0x5A003000
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
Applied to u-boot-stm32/next

Thanks
Patrice
