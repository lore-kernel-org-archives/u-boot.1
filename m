Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8648CD2C548
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F281D881C1;
	Tue, 22 Oct 2024 14:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cxxCfYfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E15C488EBA; Tue, 22 Oct 2024 14:57:44 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACDCF80245
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49MCvfYe013682;
 Tue, 22 Oct 2024 07:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729601861;
 bh=pb+aslfJ2aWkKXgD/2byAU/+jzSJJAEMQEcR6a2GQtk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=cxxCfYfaZrkraHawHZeqXkZJh6IV/iJuzxZFZaXTkY6ujc2Qo6+FV9zAnpndjP0UF
 hz3FIskTvPzqfwuHFc/HZUwsrsyJZXH3eg0ToQcCAJwcT4hYjjnRhsxkkXMAI1U1wQ
 qhdQExPa/yf3SD+hDzkIDX1VxaIRU10p+78Yb9ts=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49MCve0h071688
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Oct 2024 07:57:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Oct 2024 07:57:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Oct 2024 07:57:40 -0500
Received: from [10.249.132.3] ([10.249.132.3])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49MCvavR094219;
 Tue, 22 Oct 2024 07:57:37 -0500
Message-ID: <d2838e7a-4ace-46a9-b40e-6a90b89a5f64@ti.com>
Date: Tue, 22 Oct 2024 18:27:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm: mach-k3: j721e-init.c: J7200: Add support for
 CONFIG_K3_OPP_LOW
To: Neha Malcom Francis <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>
References: <20241017062911.2241167-1-a-limaye@ti.com>
 <20241017062911.2241167-5-a-limaye@ti.com>
 <e05c19c9-47ef-4a39-896b-c8d936c6eca4@ti.com>
Content-Language: en-US
From: "Limaye, Aniket" <a-limaye@ti.com>
In-Reply-To: <e05c19c9-47ef-4a39-896b-c8d936c6eca4@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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



On 10/17/2024 4:10 PM, Neha Malcom Francis wrote:
> Hi Aniket
> 
> On 17/10/24 11:59, Aniket Limaye wrote:
>> From: Reid Tonking <reidt@ti.com>
>>
>> The default j7200 devicetree and k3_avs driver set 2GHz/1GHz frequency
>> for A72/MSMC clks and the OPP_NOM voltage.
>>
>> J7200 SOCs may support OPP_LOW Operating Performance Point:
>> 1GHz/500MHz clks for A72/MSMC and OPP_LOW AVS voltage read from efuse.
>>
>> Hence, add a config check to select OPP_LOW specs:
>> - Check if OPP_LOW AVS voltage read from efuse is valid.
>> - Update the clock frequencies in devicetree.
>> - Program the OPP_LOW AVS voltage for VDD_CPU.
>>
>> Signed-off-by: Reid Tonking <reidt@ti.com>
>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>> ---
>>   arch/arm/mach-k3/j721e/j721e_init.c | 45 ++++++++++++++++++++++++++++-
>>   drivers/misc/k3_avs.c               |  5 ++++
>>   2 files changed, 49 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/ 
>> j721e/j721e_init.c
>> index e9ed8cb267c..0620759c36c 100644
>> --- a/arch/arm/mach-k3/j721e/j721e_init.c
>> +++ b/arch/arm/mach-k3/j721e/j721e_init.c
>> @@ -19,6 +19,7 @@
>>   #include <fdtdec.h>
>>   #include <mmc.h>
>>   #include <remoteproc.h>
>> +#include <k3-avs.h>
>>   #include "../sysfw-loader.h"
>>   #include "../common.h"
>> @@ -147,6 +148,32 @@ static void setup_navss_nb(void)
>>       writel(NB_THREADMAP_BIT1, 
>> (uintptr_t)NAVSS0_NBSS_NB1_CFG_NB_THREADMAP);
>>   }
>> +int fix_freq(const void *fdt)
>> +{
>> +        int node, ret;
>> +        u32 opp_low_freq[3];
>> +
>> +        node = fdt_node_offset_by_compatible(fdt, -1, "ti,am654-rproc");
>> +            if (node < 0) {
>> +                printf("%s: A72 not found\n", __func__);
>> +                return node;
>> +            }
> 
> Indentation seems to be off.
> 

Ahh noted... will correct in v2.

>> +
>> +        /* j7200 opp low values according to data sheet */
>> +        opp_low_freq[0] = cpu_to_fdt32(1000000000); /* 202-2 -> 
>> A72SS0_CORE0_0_ARM_CLK */
>> +        opp_low_freq[1] = cpu_to_fdt32(200000000); /* 61-1 -> 
>> GTC0_GTC_CLK */
>> +        opp_low_freq[2] = cpu_to_fdt32(500000000); /* 4-1 -> 
>> A72SS0_CORE0_MSMC_CLK */
>> +
>> +        ret = fdt_setprop((void *)fdt, node, "assigned-clock-rates",
>> +                  opp_low_freq, sizeof(opp_low_freq));
>> +            if (ret) {
>> +                printf("%s: Can not set value\n", __func__);
>> +                return ret;
>> +            }
>> +
>> +        return 0;
>> +}
>> +
>>   /*
>>    * This uninitialized global variable would normal end up in 
>> the .bss section,
>>    * but the .bss is cleared between writing and reading this 
>> variable, so move
>> @@ -301,8 +328,24 @@ void board_init_f(ulong dummy)
>>   #if defined(CONFIG_CPU_V7R) && defined(CONFIG_K3_AVS0)
>>       ret = uclass_get_device_by_driver(UCLASS_MISC, 
>> DM_DRIVER_GET(k3_avs),
>>                         &dev);
>> -    if (ret)
>> +    if (!ret) {
>> +        if (IS_ENABLED(CONFIG_K3_OPP_LOW)) {
>> +            ret = k3_check_opp(dev, J721E_VDD_MPU, AM6_OPP_LOW);
>> +            if (!ret) {
>> +                ret = fix_freq(gd->fdt_blob);
>> +                if (ret)
>> +                    printf("Failed to set OPP_LOW frequency\n");
>> +
>> +                ret = k3_avs_set_opp(dev, J721E_VDD_MPU, AM6_OPP_LOW);
>> +                if (ret)
>> +                    printf("Failed to set OPP_LOW voltage\n");
>> +            } else {
>> +                printf("Failed to enable K3_OPP_LOW\n");
>> +            }
>> +        }
>> +    } else {
>>           printf("AVS init failed: %d\n", ret);
>> +    }
>>   #endif
>>   #if defined(CONFIG_K3_J721E_DDRSS)
>> diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
>> index 90cd9dfe7f9..932b355a5c1 100644
>> --- a/drivers/misc/k3_avs.c
>> +++ b/drivers/misc/k3_avs.c
>> @@ -121,6 +121,11 @@ static int k3_avs_program_voltage(struct 
>> k3_avs_privdata *priv,
>>       if (!vd->supply)
>>           return -ENODEV;
>> +    if (!volt) {
>> +        dev_err(priv->dev, "Fuse is not set for selected opp %d\n", 
>> opp_id);
> 
> s/Fuse/Efuse

Yep, will update.

Thanks,
Aniket


>> +        return -EINVAL;
>> +    }
>> +
>>       vd->opp = opp_id;
>>       vd->flags |= VD_FLAG_INIT_DONE;
> 

