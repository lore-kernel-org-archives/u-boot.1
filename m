Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CBBC369D1
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 09:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C43781D5D;
	Thu, 24 Apr 2025 11:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kHbT97Ve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A47A815D1; Thu, 24 Apr 2025 11:47:12 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72CC780F9C
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53O9l6UN2594526
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Apr 2025 04:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745488026;
 bh=YQxACvBb7In7/tYTX4sS4VoSDaRtuRYuIM7M8C3ikOI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=kHbT97VeDbRojLHlFArvD2Z7tH1H67gJaxHdzSmT7xviwuGLd3PerJXIhYrhEHsgp
 1rOHAH0q7dX4e2oSjQB6/xOts7Um9mEv07axzboJ671/GSIQbZxe20ZFpjic5GyRaS
 aLZ1Ugi1vP10u45rzo5icE3YH+g0QTUE671i+U4g=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53O9l6G8107701
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Apr 2025 04:47:06 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Apr 2025 04:47:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Apr 2025 04:47:06 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53O9l3fq008858;
 Thu, 24 Apr 2025 04:47:03 -0500
Message-ID: <226f38ab-b4b0-4283-b951-9ef4f1fc8ad3@ti.com>
Date: Thu, 24 Apr 2025 15:17:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm: mach-k3: r5: common: Add support to boot HSM M4
 core
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-boot@lists.denx.de>
References: <20250422095430.363792-1-b-padhi@ti.com>
 <20250422095430.363792-5-b-padhi@ti.com>
 <18e01808-499d-4690-995a-45ac5fd727d9@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <18e01808-499d-4690-995a-45ac5fd727d9@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Udit,

On 22/04/25 20:14, Kumar, Udit wrote:
> Hello Beleswar
>
> On 4/22/2025 3:24 PM, Beleswar Padhi wrote:
>> The tispl.bin fit image is packed with the HSM firmware image. Populate
>> the "os" info of the image so that it can be detected and loaded at
>> corresponding DDR address. Further, invoke the load and boot of HSM core
>> at R5 SPL stage. Boot flow for HSM M4 core is as below:
>>
>> 1. Request control of HSM M4F remote processor.
>> 2. Assert Reset on the HSM M4F remote processor.
>> 3. For HS devices, Request Secure Entity to Authenticate and Load HSM
>>     firmware into core's internal SRAM memory region. For GP devices,
>>     load the unsigned firmware manually.
>> 4. Deassert Reset on the HSM M4F remote processor.
>> 5. Release control of HSM M4F remote processor.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>   arch/arm/mach-k3/r5/common.c | 84 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 83 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
>> index fd188e7c90e..1af0f70d8d3 100644
>> --- a/arch/arm/mach-k3/r5/common.c
>> +++ b/arch/arm/mach-k3/r5/common.c
>> @@ -15,11 +15,17 @@
>>   #include <spl.h>
>>   #include <remoteproc.h>
>>   #include <elf.h>
>> +#include <cpu_func.h>
>>     #include "../common.h"
>>   +#define PROC_BOOT_CTRL_RESET_FLAG_HSM_M4    0x00000001
>> +#define HSM_SRAM0_0_ADDR            0x43C00000
>> +#define PROC_ID_HSM_M4F                0x00000080
>
> PROC_ID_HSM_M4F seems to have extra tab


Will fix in revision.

>
>> +
>>   #if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
>>   enum {
>> +    IMAGE_ID_HSM,
>>       IMAGE_ID_ATF,
>>       IMAGE_ID_OPTEE,
>>       IMAGE_ID_SPL,
>
> Do you see possibility to have HSM char and enum at last .


Thanks for the help in debug. A separate fix needs to be sent first, before putting new firmware at the end of the enum. I will include the fix in revision.

>
>
>> @@ -32,6 +38,7 @@ enum {
>>     #if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
>>   static const char *image_os_match[IMAGE_AMT] = {
>> +    "hsm",
>>       "arm-trusted-firmware",
>>       "tee",
>>       "U-Boot",
>> @@ -136,6 +143,73 @@ void release_resources_for_core_shutdown(void)
>>       }
>>   }
>>   +#if IS_ENABLED(CONFIG_K3_HSM_FW)
>> +static int boot_hsm_core(void)
>> +{
>> +    struct ti_sci_handle *ti_sci = get_ti_sci_handle();
>> +    struct ti_sci_proc_ops *proc_ops = &ti_sci->ops.proc_ops;
>> +    u64 hsm_image_addr;
>> +    u32 hsm_image_size;
>> +    int device_type, ret;
>
> ^^ may be in alphabetic order


Other functions in & around the same file define structs before than int and char.

Let me know if you have a preference for the other way around.

>
>
>> +
>> +    hsm_image_addr = (u64)fit_image_info[IMAGE_ID_HSM].image_start;
>> +    hsm_image_size = (u32)fit_image_info[IMAGE_ID_HSM].image_len;
>> +
>> +    /* Request Control of Remote Processor */
>> +    ret = proc_ops->proc_request(ti_sci, PROC_ID_HSM_M4F);
>> +    if (ret) {
>> +        printf("Unable to request processor control for core %d\n",
>> +               PROC_ID_HSM_M4F);
>> +        return ret;
>> +    }
>> +
>> +    /* Put the remote processor into reset */
>> +    ret = proc_ops->set_proc_boot_ctrl(ti_sci, PROC_ID_HSM_M4F,
>> +                       PROC_BOOT_CTRL_RESET_FLAG_HSM_M4, 0);
>> +    if (ret) {
>> +        printf("Unable to Halt core %d\n", PROC_ID_HSM_M4F);
>> +        goto release_proc_ctrl;
>> +    }
>> +
>> +    /*
>> +     * Load the HSM firmware into core's internal memory.
>> +     *
>> +     * In case of HS device types, request secure entity to authenticate and
>> +     * load the HSM firmware into the core memory.
>> +     * In case of GP device types, copy the HSM firmware into the core
>> +     * memory manually.
>> +     */
>> +    device_type = get_device_type();
>> +    if (device_type == K3_DEVICE_TYPE_HS_SE ||
>> +        device_type == K3_DEVICE_TYPE_HS_FS) {
>> +        ret = proc_ops->proc_auth_boot_image(ti_sci, &hsm_image_addr,
>> +                             &hsm_image_size);
>> +        if (ret) {
>> +            printf("Unable to Authenticate and Boot HSM image; ret = %d\n",
>> +                   ret);
>> +            goto release_proc_ctrl;
>> +        }
>> +    } else if (device_type == K3_DEVICE_TYPE_GP) {
>> +        debug("Loading HSM GP binary into SRAM0_0\n");
>> +        memcpy((void *)HSM_SRAM0_0_ADDR, (void *)(u32)hsm_image_addr,
>> +               hsm_image_size);
>> +        flush_dcache_range(HSM_SRAM0_0_ADDR,
>> +                   HSM_SRAM0_0_ADDR + hsm_image_size);
>> +    }
>
> since you are doing if- elseif loop then final else you should consider as error case


Sure, will address in revision.

>
>
>> +
>> +    /* Release the reset from the remote processor*/
>> +    ret = proc_ops->set_proc_boot_ctrl(ti_sci, PROC_ID_HSM_M4F, 0,
>> +                       PROC_BOOT_CTRL_RESET_FLAG_HSM_M4);
>> +    if (ret)
>> +        printf("Unable to Run core %d\n", PROC_ID_HSM_M4F);
>> +
>> +release_proc_ctrl:
>> +    /* Release Control of Remote Processor */
>> +    proc_ops->proc_release(ti_sci, PROC_ID_HSM_M4F);
>> +    return ret;
>> +}
>> +#endif
>> +
>>   void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
>>   {
>>       typedef void __noreturn (*image_entry_noargs_t)(void);
>> @@ -157,6 +231,14 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
>>                        &loadaddr);
>>       }
>>   +#if IS_ENABLED(CONFIG_K3_HSM_FW)
>> +    ret = boot_hsm_core();
>> +    if (ret)
>> +        printf("HSM core failed to boot, %d\n", ret);
>> +    else
>> +        printf("Successfully booted HSM core\n");
>> +#endif
>
> Should we go in hang state, if secure fw is not started correctly ?


We can. But I am thinking of the cases when people are running some demo applications in HSM core. In that case, if HSM boot fails, it is kind of expensive to hang the entire system boot.

What do you think?

Thanks,
Beleswar

>
>
>> +
>>       /*
>>        * It is assumed that remoteproc device 1 is the corresponding
>>        * Cortex-A core which runs ATF. Make sure DT reflects the same.
>> @@ -342,7 +424,7 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
>>        * Only DM and the DTBs are being authenticated here,
>>        * rest will be authenticated when A72 cluster is up
>>        */
>> -    if ((i != IMAGE_ID_ATF) && (i != IMAGE_ID_OPTEE)) {
>> +    if (i != IMAGE_ID_ATF && i != IMAGE_ID_OPTEE && i != IMAGE_ID_HSM) {
>>           ti_secure_image_check_binary(p_image, p_size);
>>           ti_secure_image_post_process(p_image, p_size);
>>       } else {
