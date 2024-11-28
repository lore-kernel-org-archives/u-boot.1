Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46826D3B9BD
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 04:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9430F89372;
	Thu, 28 Nov 2024 05:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hL/u9etj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 908E38937B; Thu, 28 Nov 2024 05:54:52 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DEC88926A
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 05:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AS4smHb696139
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Nov 2024 22:54:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732769688;
 bh=9llCwKUnF2sD9blGSRAdY9ihY868F2SIHWq4WpBJ/qY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=hL/u9etj+eRlhv05zNWtvvMkT7+LuBmavpH0njbOcSw/J/kA+RocHDlqK9q3ALhDr
 U1rsr/O/TNFio6qEZ5Vwl/oR2wjlQaRSZvtJQLk81g1+RwUFRKNg/Ur6UMiSq8lIr4
 /ofVoUFYnrErAtO4f+MxCgtdx1glsGYpEYEwDOTI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AS4sm4I102247
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Nov 2024 22:54:48 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Nov 2024 22:54:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Nov 2024 22:54:47 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AS4siLA105897;
 Wed, 27 Nov 2024 22:54:44 -0600
Message-ID: <0f487b58-c0a9-4de5-9237-a5e4290e30bf@ti.com>
Date: Thu, 28 Nov 2024 10:24:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] DONOTMERGE: arm: mach-k3: j784s4_init: Trigger LBIST
 and PBIST on MAIN R5 2_0
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>
References: <20241127145346.2609868-1-n-francis@ti.com>
 <20241127145346.2609868-5-n-francis@ti.com>
 <cf314732-89c8-4c39-8cbc-3648185000f2@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <cf314732-89c8-4c39-8cbc-3648185000f2@ti.com>
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

On 28/11/24 09:38, Kumar, Udit wrote:
> Thanks Neha.
> 
> On 11/27/2024 8:23 PM, Neha Malcom Francis wrote:
>> Trigger all tests of PBIST and LBIST using appropriate calls to set the
>> core under test (MAIN R5 2_0) to it's required state.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm/mach-k3/j784s4/j784s4_init.c | 48 +++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c 
>> b/arch/arm/mach-k3/j784s4/j784s4_init.c
>> index 07b5d7d7504..f9bd13d962b 100644
>> --- a/arch/arm/mach-k3/j784s4/j784s4_init.c
>> +++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
>> @@ -17,6 +17,7 @@
>>   #include <dm/pinctrl.h>
>>   #include <mmc.h>
>>   #include <remoteproc.h>
>> +#include <k3_bist.h>
>>   #include "../sysfw-loader.h"
>>   #include "../common.h"
>> @@ -233,9 +234,56 @@ void k3_mem_init(void)
>>   void board_init_f(ulong dummy)
>>   {
>> +    struct udevice *dev;
>> +    int ret;
>> +
>>       k3_spl_init();
>>       k3_mem_init();
>> +    if (!IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_BIST)) {
> 
> My suggestion will be , keep this patch to be merged and don't enable the BIST 
> config , patch 3/4 as default

Oh okay, can do that. My reasoning was this patch was to showcase how to run the 
calls on an example PBIST14 on the MAIN2_x cores.

> 
>> +        ret = uclass_get_device_by_driver(UCLASS_MISC,
>> +                          DM_DRIVER_GET(k3_bist),
>> +                          &dev);
>> +        if (ret)
>> +            printf("Failed to run BIST: %d\n", ret);
> 
> in whole of this function, please take care of error handling
> 
> eg if uclass_get_device_by_driver returns error then there is not point to get 
> device_get_ops or so

Okay since I'll not mark this as DONOTMERGE will make it a proper patch.

> 
>> +
>> +        struct bist_ops *ops = (struct bist_ops *)device_get_ops(dev);
>> +        struct ti_sci_handle *handle = get_ti_sci_handle();
>> +
>> +        /* get status of HW POST PBIST on MCU1_x */
>> +        ret = ops->run_pbist_post();
>> +        if (ret)
>> +            panic("HW POST LBIST on MCU1_x failed: %d\n", ret);
>> +
>> +        /* trigger PBIST tests on MCU4_0 */
>> +        prepare_pbist(handle);
>> +        ret = ops->run_pbist_neg();
>> +        deprepare_pbist(handle);
>> +
> 
> Can prepare_pbist and deprepare_pbist be static in driver.

Yes should be possible, will do that.
> 
> 
>> +        prepare_pbist(handle);
>> +        ret |= ops->run_pbist();
>> +        deprepare_pbist(handle);
>> +
>> +        prepare_pbist(handle);
>> +        ret |= ops->run_pbist_rom();
>> +        deprepare_pbist(handle);
>> +
>> +        if (ret)
>> +            panic("PBIST on MCU4_0 failed: %d\n", ret);
>> +
>> +        /* get status of HW POST PBIST on MCU1_x */
>> +        ret = ops->run_lbist_post();
>> +        if (ret)
>> +            panic("HW POST LBIST on MCU1_x failed: %d\n", ret);
>> +
>> +        /* trigger LBIST tests on MCU1_x */
>> +        prepare_lbist(handle);
>> +        ret = ops->run_lbist();
>> +        deprepare_lbist(handle);
>> +        if (ret)
>> +            panic("LBIST on MCU4_0 failed: %d\n", ret);
>> +    }
>> +
>>       if (IS_ENABLED(CONFIG_CPU_V7R))
>>           setup_navss_nb();

-- 
Thanking You
Neha Malcom Francis
