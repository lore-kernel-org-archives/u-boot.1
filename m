Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06734C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 14:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC7C8056A;
	Thu, 24 Apr 2025 16:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BsoUlSi3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A74FB80194; Thu, 24 Apr 2025 16:26:37 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5AE80194
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 16:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53OEQWaR2654975
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Apr 2025 09:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745504792;
 bh=Z97rLpeICltiR5HBDukfdmyh6rGjRFcUnv7g4vYhRtM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=BsoUlSi3xJDa9tJWhS+4zxroWjEcTLLhplcBDfQnhPaN3Kj+MYQSDc4Yy0cf+OYYF
 UOOhWbDd0kGD/VyhWPHoa/z4nK9Ri/iSVsWHkVTdouhhNvRiYuLtg3afiqhG2Y5ECA
 0OZFMgcQCcGikesdKQ15cl6aghaBAFtdsCK8tdb4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53OEQWjQ020194
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Apr 2025 09:26:32 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Apr 2025 09:26:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Apr 2025 09:26:32 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53OEPN1O063356;
 Thu, 24 Apr 2025 09:25:27 -0500
Message-ID: <d441dc51-92b8-492b-89fa-0912b7675d0b@ti.com>
Date: Thu, 24 Apr 2025 19:55:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm: mach-k3: r5: common: Add support to boot HSM M4
 core
To: Beleswar Prasad Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-boot@lists.denx.de>
References: <20250422095430.363792-1-b-padhi@ti.com>
 <20250422095430.363792-5-b-padhi@ti.com>
 <18e01808-499d-4690-995a-45ac5fd727d9@ti.com>
 <226f38ab-b4b0-4283-b951-9ef4f1fc8ad3@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <226f38ab-b4b0-4283-b951-9ef4f1fc8ad3@ti.com>
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


On 4/24/2025 3:17 PM, Beleswar Prasad Padhi wrote:
> Hi Udit,
>
> On 22/04/25 20:14, Kumar, Udit wrote:
>> Hello Beleswar
>>
>> On 4/22/2025 3:24 PM, Beleswar Padhi wrote:
>>> The tispl.bin fit image is packed with the HSM firmware image. Populate
>>> the "os" info of the image so that it can be detected and loaded at
>>> corresponding DDR address. Further, invoke the load and boot of HSM core
>>> at R5 SPL stage. Boot flow for HSM M4 core is as below:
>>>
>>> 1. Request control of HSM M4F remote processor.
>>> 2. Assert Reset on the HSM M4F remote processor.
>>> 3. For HS devices, Request Secure Entity to Authenticate and Load HSM
>>>      firmware into core's internal SRAM memory region. For GP devices,
>>>      load the unsigned firmware manually.
>>> 4. Deassert Reset on the HSM M4F remote processor.
>>> 5. Release control of HSM M4F remote processor.
>>>
>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>> ---
>>>    arch/arm/mach-k3/r5/common.c | 84 +++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 83 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
>>> index fd188e7c90e..1af0f70d8d3 100644
>>> --- a/arch/arm/mach-k3/r5/common.c
>>> +++ b/arch/arm/mach-k3/r5/common.c
>>> @@ -15,11 +15,17 @@
>>>    #include <spl.h>
>>>    #include <remoteproc.h>
>>>    #include <elf.h>
>>> +#include <cpu_func.h>
>>>      #include "../common.h"
>>>    +#define PROC_BOOT_CTRL_RESET_FLAG_HSM_M4    0x00000001
>>> +#define HSM_SRAM0_0_ADDR            0x43C00000
>>> +#define PROC_ID_HSM_M4F                0x00000080
>> PROC_ID_HSM_M4F seems to have extra tab
>
> Will fix in revision.
>
>>> +
>>>    #if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
>>>    enum {
>>> +    IMAGE_ID_HSM,
>>>        IMAGE_ID_ATF,
>>>        IMAGE_ID_OPTEE,
>>>        IMAGE_ID_SPL,
>> Do you see possibility to have HSM char and enum at last .
>
> Thanks for the help in debug. A separate fix needs to be sent first, before putting new firmware at the end of the enum. I will include the fix in revision.
>
>>
>>> @@ -32,6 +38,7 @@ enum {
>>>      #if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
>>>    static const char *image_os_match[IMAGE_AMT] = {
>>> +    "hsm",
>>>        "arm-trusted-firmware",
>>>        "tee",
>>>        "U-Boot",
>>> @@ -136,6 +143,73 @@ void release_resources_for_core_shutdown(void)
>>>        }
>>>    }
>>>    +#if IS_ENABLED(CONFIG_K3_HSM_FW)
>>> +static int boot_hsm_core(void)
>>> +{
>>> +    struct ti_sci_handle *ti_sci = get_ti_sci_handle();
>>> +    struct ti_sci_proc_ops *proc_ops = &ti_sci->ops.proc_ops;
>>> +    u64 hsm_image_addr;
>>> +    u32 hsm_image_size;
>>> +    int device_type, ret;
>> ^^ may be in alphabetic order
>
> Other functions in & around the same file define structs before than int and char.
>
> Let me know if you have a preference for the other way around.

No preference but just suggestion, if you want to take it


>
>>
>>> +
>>> +    hsm_image_addr = (u64)fit_image_info[IMAGE_ID_HSM].image_start;
>>> +    hsm_image_size = (u32)fit_image_info[IMAGE_ID_HSM].image_len;
>>> +
>>> +   [..]
>>>
>>> Sure, will address in revision.
>>>
>>
>>> +
>>> +  [..]Should we go in hang state, if secure fw is not started correctly ?
>
> We can. But I am thinking of the cases when people are running some demo applications in HSM core. In that case, if HSM boot fails, it is kind of expensive to hang the entire system boot.
>
> What do you think?

This is not default option. people wants to use HSM fw they need to 
purposefully enable this option

which shall work, So hang is justified.


>
> Thanks,
> Beleswar
>
>>
>>> +
>>>        /*
>>>         * It is assumed that remoteproc device 1 is the corresponding
>>>         * Cortex-A core which runs ATF. Make sure DT reflects the same.
>>> @@ -342,7 +424,7 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
>>>         * Only DM and the DTBs are being authenticated here,
>>>         * rest will be authenticated when A72 cluster is up
>>>         */
>>> -    if ((i != IMAGE_ID_ATF) && (i != IMAGE_ID_OPTEE)) {
>>> +    if (i != IMAGE_ID_ATF && i != IMAGE_ID_OPTEE && i != IMAGE_ID_HSM) {
>>>            ti_secure_image_check_binary(p_image, p_size);
>>>            ti_secure_image_post_process(p_image, p_size);
>>>        } else {
