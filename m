Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553D7CD5BC5
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 13:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B1C88CA8;
	Thu,  5 Sep 2024 15:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ty2p0Lwv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F11988C8A; Thu,  5 Sep 2024 13:50:19 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9118C88C87
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 13:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 485BoEe2024188;
 Thu, 5 Sep 2024 06:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725537014;
 bh=kyNG1KbqOnjhJRx6Ok5fH0LtEYgvArTPdpSoCk/wfvU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Ty2p0LwvekFWuZKdsgiry7h4i5h+EaVhCh2a4Tnu2rn0OdOLmtET7sMHMZ2PN3kvn
 DGC2hIpffd9+rqeM5L+n/t7+ApwLHu0GIEij2QEhR6ZjdTsRAhD2+U+NlZe8sCbbxw
 vgrVpMAd40tpLPB8adqVwR177pY+9OWDHWveCrQU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 485BoEpq008745;
 Thu, 5 Sep 2024 06:50:14 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Sep 2024 06:50:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Sep 2024 06:50:13 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 485Bo9eV097638;
 Thu, 5 Sep 2024 06:50:10 -0500
Message-ID: <6819502c-0120-4bdd-bee9-049403463dac@ti.com>
Date: Thu, 5 Sep 2024 17:20:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] drivers: misc: k3_bist: Add K3 BIST driver
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20240903114402.2155740-1-n-francis@ti.com>
 <20240903114402.2155740-5-n-francis@ti.com>
 <586db467-5524-42cd-9742-3a673bb02039@ti.com>
 <5198dbc7-19bc-419e-83b7-e7216269abd1@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <5198dbc7-19bc-419e-83b7-e7216269abd1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 05 Sep 2024 15:17:52 +0200
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


On 9/5/2024 3:11 PM, Neha Malcom Francis wrote:
> On 04/09/24 10:35, Kumar, Udit wrote:
>>
>> On 9/3/2024 5:14 PM, Neha Malcom Francis wrote:
>>> Add a driver for the BIST module which currently includes support for
>>> BIST IPs that trigger PBIST (Memory BIST).
>>>
>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>> ---
>>>   drivers/misc/Kconfig               |   8 +
>>>   drivers/misc/Makefile              |   1 +
>>>   drivers/misc/k3_bist.c             | 507 ++++++++++++++++++++++++++
>>>   drivers/misc/k3_bist_static_data.h | 551 
>>> +++++++++++++++++++++++++++++
>>>   4 files changed, 1067 insertions(+)
>>>   create mode 100644 drivers/misc/k3_bist.c
>>>   create mode 100644 drivers/misc/k3_bist_static_data.h
>>>
>>> [...]
>>> +
>>
>>
>> In general, few macro's name are too long
>>
>> many places hard-coded values are used, please consider to move to macro
>>
>> driver looks to be j784s4 specific including header files  ,
>>
>> please see, if we can make this generic driver.
>
> I've put SoC specific (J784S4 right now) data protected with SoC 
> specific configs in k3_bist_static_data.h; the hardcoded values are a 
> sequence for triggering a specific test, whatever is generic and known 
> I have put as a macro, however I'll try to better understand the 
> sequence if I can put them as macros.
>
>>
>>
>>> +#include "k3_bist_static_data.h"
>>> +
>>> [...]
>>
>> Please consider to rename function name as per description above 
>> something like
>>
>> check_pbist_results_of_mcu_domain,, if you agree
>>
>> Also give more context, I believe, ROM runs BIST on MCU domain, 
>> Please consider to mention, if you want
>
> Yes will do!
>
>>
>>> +{
>>> +    bool is_done, timed_out;
>>> +    u32 mask;
>>> +    u32 post_reg_val, shift;
>>> +
>>> +    /* Read HW POST status register */
>>> +    post_reg_val = readl(WKUP_CTRL_MMR0_BASE + 
>>> WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT);
>>> +
>>> +    /* Check if HW POST PBIST was performed */
>>> +    shift = 
>>> WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_DONE_SHIFT;
>>> +    is_done = (((post_reg_val >> shift) & 0x1u) == 0x1u) ? 
>>> (bool)true : (bool)false;
>>> +
>>> +    if (!is_done) {
>>> +        /* HW POST: PBIST not completed, check if it timed out */
>>> +        shift = 
>>> WKUP_CTRL_MMR_CFG0_WKUP_POST_STAT_POST_MCU_PBIST_TIMEOUT_SHIFT;
>> Too long macro name
>>> +        timed_out = (((post_reg_val >> shift) & 0x1u) == 0x1u) ? 
>>> (bool)true : (bool)false;
>>> +
>>> +        if (!timed_out) {
>>> +            debug("%s: PBIST was not performed at all on this 
>>> device for this core\n",
>>> +                  __func__);
>>> +            return -EINVAL;
>>
>> This is error no ? , move to dev_err instead of debug
>>
>
> The return in k3_bist_probe throws a dev_err saying HW POST failed to 
> run successfully. So these were added as debugs in case the end user 
> wants to know exact cause of failure, I can move it as a dev_err as well.

ok, thanks


>
>>
>>> +        } else {
>>> +            debug("%s: PBIST was attempted but timed out for this 
>>> section\n", __func__);
>>> +            return -ETIMEDOUT;
>>
>> This is error no ? , move to dev_err instead of debug .
>>
>> What next, reboot SOC or just continue booting in case of error
>
> This is also something I wanted this RFC to address, I prefer 
> rebooting SoC if HW POST fails. HW POST is performed by ROM based on 
> certain switch settings, which implies that an end-user wants this 
> check done if selected. And if it fails on the MCU domain itself, I do 
> not think we should continue.

Ok, if you are saying BIST in MCU domain in done based upon some switch 
settings, then please put that switch logic here .

Reading code above looks, BIST run always

if (!is_done) {
+		/* HW POST: PBIST not completed, check if it timed out */
+	} else {
+		/* HW POST: PBIST was completed on this device, check the result */

So now have three conditions,
1) BIST not attempted
2) BIST ran and passed
3) BIST ran and failed

For 1) condition, please see if you can read some register or switch 
settings or so.

For 3) , as default we should hang.. In case users wants to continue on 
failure they can modify u-boot source to do so :)


>>
>>
>>> [..]
>>> isn't some tisci call are ok to turn off the CPUs.
>>>
>
> DM (Device Manager) firmware, responsible for power management is not 
> up at this point in the boot flow (R5 SPL). Thus TISCI calls that turn 
> on/turn off clocks and power domains are not available and we rely on 
> the primitive clk-k3.c and ti-power-domain.c drivers to do this for 
> us. As seen below, using the uclass functions which internally calls 
> these primitive drivers would be the way to go.
>
But DM is kind implemented by dev-data and dev-clk logic ?

For few calls DM just talk to TIFS, which are available at this point.

I request to check once, if possible


> I could have used the remoteproc framework to do this but currently 
> the rproc driver uses TISCI firmware calls from DM and as mentioned 
> above that's not possible.
>
> We should probably target modifying our remoteproc driver to use these 
> generic uclass APIs instead of direct TISCI calls.

Ok,

>
>>
>>> [...]
>>> +    udelay(1000);
>>> +
>>> +    u32 timeout_count = 0;
>> Please move timeout_count at start of function
>>> +
>>> +    while ((!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) &&
>>> +           (timeout_count++ < PBIST_MAX_TIMEOUT_VALUE))
>>> +        ;
>>
>> Do you want to add some delay instead of just reading in a loop
>>
>
> That is possible... is there any benefit of delay over polling? 
> Eithercase the possible time would be at max be PBIST_MAX_TIMEOUT_VALUE.


You could be definitive in waiting for this register,

Say if hardware specs says, VIM register will be set in max time of 100 
ms. then

keep PBIST_MAX_TIMEOUT_VALUE as 100 and read wait for 1 ms and then read.


>
>>
>>> +
>>> +    if (!(readl(VIM_RAW(intr_num)) & VIM_RAW_MASK(intr_num))) {
>>> +        test_result = false;
>>> +        debug("%s(dev=%p): test failed\n", __func__, dev);
>>
>> Fail is error , no ?
>>
>>
>>> +    } else {
>>> +        debug("%s(dev=%p): test passed\n", __func__, dev);
>>> +    }
>>> +
>>> +    writel(0xffffffff, VIM_STS(intr_num));
>>> +
>>> +    return 0;
>>
>>
>> Caller always will see success
>>
>
> Right, I wasn't sure about what action to take based on the result.


Failure is failure, as default please print and call hang

>
>>
>>> +}
>>> +
>>> +/**
>>> [..]
