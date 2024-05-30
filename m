Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE10C25B78
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 04:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E075886A0;
	Thu, 30 May 2024 06:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WihImSHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762BE886A0; Thu, 30 May 2024 06:59:05 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6858886B6
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 06:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U4wtDw054697;
 Wed, 29 May 2024 23:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717045135;
 bh=366FbVXJrU5U2TZhMCmwyP9EfZOPjGnS8qWFJ3SChCg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=WihImSHmZPi9GoaT1QESW/oIxyQG1HbZBfen06mTj1peqdA7psp6+5W1r5zZlqAe6
 iYzZRxxeZNdxos+1SVsRBtKH0mV04gLvfr6EXRGPvPVgIaSWYInhEhbZUUjc0EMVY9
 C40Ce/HOVa4hU4mIAQCKQGHaLO7G2jWqvnI2Td2M=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U4wtaO031935
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 23:58:55 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 23:58:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 23:58:55 -0500
Received: from [172.24.227.102]
 (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U4woUq020389;
 Wed, 29 May 2024 23:58:51 -0500
Message-ID: <5f2591c5-31ec-4ae7-a8c3-7f7151b017d6@ti.com>
Date: Thu, 30 May 2024 10:28:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] arm: mach-k3: Sort CONFIG_SOC* and K3_SOC_ID entries
To: Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, <trini@konsulko.com>,
 <jh80.chung@samsung.com>, <lukma@denx.de>, <seanga2@gmail.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
References: <20240529132448.459330-1-j-choudhary@ti.com>
 <20240529132448.459330-2-j-choudhary@ti.com>
 <dc9b4030-c48d-49cc-b40b-a2c4edcf0c13@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <dc9b4030-c48d-49cc-b40b-a2c4edcf0c13@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hello Andrew,

On 29/05/24 20:35, Andrew Davis wrote:
> On 5/29/24 8:24 AM, Jayesh Choudhary wrote:
>> Sort CONFIG_SOC* and K3_SOC_ID alphabetically.
> 
> Why? I kinda like the chronological order we have today, helps me remember
> what are the newer/older parts. Which then helps in seeing where the line
> is between when features are added, all parts after have it, etc..
> 
> No issue with alphabetical either, just looking for a "why" in the
> commit message, otherwise,

TI SoC J784S4-EVM UBOOT series had few such cleanups.
So while posting this series, for files which I was touching,
if such generic cleanups seemed appropriate, I did it.

> 
> Reviewed-by: Andrew Davis <afd@ti.com>
> 
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm/mach-k3/include/mach/hardware.h | 37 ++++++++++++------------
>>   1 file changed, 19 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/include/mach/hardware.h 
>> b/arch/arm/mach-k3/include/mach/hardware.h
>> index c724450638..c3aaded8dc 100644
>> --- a/arch/arm/mach-k3/include/mach/hardware.h
>> +++ b/arch/arm/mach-k3/include/mach/hardware.h
>> @@ -8,37 +8,38 @@
>>   #include <asm/io.h>
>> -#ifdef CONFIG_SOC_K3_AM654
>> -#include "am6_hardware.h"
>> +#ifdef CONFIG_SOC_K3_AM625
>> +#include "am62_hardware.h"
>>   #endif
>> -#ifdef CONFIG_SOC_K3_J721E
>> -#include "j721e_hardware.h"
>> +#ifdef CONFIG_SOC_K3_AM62A7
>> +#include "am62a_hardware.h"
>>   #endif
>> -#ifdef CONFIG_SOC_K3_J721S2
>> -#include "j721s2_hardware.h"
>> +#ifdef CONFIG_SOC_K3_AM62P5
>> +#include "am62p_hardware.h"
>>   #endif
>>   #ifdef CONFIG_SOC_K3_AM642
>>   #include "am64_hardware.h"
>>   #endif
>> -#ifdef CONFIG_SOC_K3_AM625
>> -#include "am62_hardware.h"
>> +#ifdef CONFIG_SOC_K3_AM654
>> +#include "am6_hardware.h"
>>   #endif
>> -#ifdef CONFIG_SOC_K3_AM62A7
>> -#include "am62a_hardware.h"
>> +#ifdef CONFIG_SOC_K3_J721E
>> +#include "j721e_hardware.h"
>> +#endif
>> +
>> +#ifdef CONFIG_SOC_K3_J721S2
>> +#include "j721s2_hardware.h"
>>   #endif
>>   #ifdef CONFIG_SOC_K3_J784S4
>>   #include "j784s4_hardware.h"
>>   #endif
>> -#ifdef CONFIG_SOC_K3_AM62P5
>> -#include "am62p_hardware.h"
>> -#endif
>>   /* Assuming these addresses and definitions stay common across K3 
>> devices */
>>   #define CTRLMMR_WKUP_JTAG_ID    (WKUP_CTRL_MMR0_BASE + 0x14)
>> @@ -63,14 +64,14 @@ static inline bool soc_is_##id(void) \
>>           JTAG_ID_PARTNO_MASK) >> JTAG_ID_PARTNO_SHIFT; \
>>       return soc == JTAG_ID_PARTNO_##ID; \
>>   }
>> -K3_SOC_ID(am65x, AM65X)
>> -K3_SOC_ID(j721e, J721E)
>> -K3_SOC_ID(j7200, J7200)
>> -K3_SOC_ID(am64x, AM64X)
>> -K3_SOC_ID(j721s2, J721S2)
>>   K3_SOC_ID(am62x, AM62X)
>>   K3_SOC_ID(am62ax, AM62AX)
>>   K3_SOC_ID(am62px, AM62PX)
>> +K3_SOC_ID(am64x, AM64X)
>> +K3_SOC_ID(am65x, AM65X)
>> +K3_SOC_ID(j7200, J7200)
>> +K3_SOC_ID(j721e, J721E)
>> +K3_SOC_ID(j721s2, J721S2)
>>   #define K3_SEC_MGR_SYS_STATUS        0x44234100
>>   #define SYS_STATUS_DEV_TYPE_SHIFT    0
