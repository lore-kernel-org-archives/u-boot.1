Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD71C3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD71582153;
	Tue,  6 May 2025 16:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IL96FeMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F2782905; Tue,  6 May 2025 16:36:24 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2D8D820F6
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546EaFfP543065
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 09:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746542175;
 bh=xLLBuAznykA5pQacROAyln6/UbEBwPQYamBBWZt45CM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=IL96FeMNpvapT0XnkJcaWBJRwd8q6bnSXWBhpUMvyNaDE3bSvTMn2Bm1E7hCt3aDY
 LC9b4i6qwupucCCRjEBu8qWCp76Pb829tUvfZ2xnzDK238VbJ/AEo3GVJiHtZugnOc
 s7H7+hOosNSNVcpRgBRwq6nBVt8F3C9LJq5JXu+g=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546EaF0C033558
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 May 2025 09:36:15 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 09:36:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 09:36:14 -0500
Received: from [10.249.140.90] ([10.249.140.90])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546Ea7KW005335;
 Tue, 6 May 2025 09:36:08 -0500
Message-ID: <f9a1437a-1d1f-4a98-98ba-0f262e8c16c4@ti.com>
Date: Tue, 6 May 2025 20:06:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] arm: mach-k3: r5: common: Add support to boot HSM
 M4 core
To: Andrew Davis <afd@ti.com>, <trini@konsulko.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <cfsworks@gmail.com>,
 <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <u-boot@lists.denx.de>
References: <20250506104202.16741-1-b-padhi@ti.com>
 <20250506104202.16741-8-b-padhi@ti.com>
 <d9708e0c-e8a8-4343-b327-6f024ad13f20@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <d9708e0c-e8a8-4343-b327-6f024ad13f20@ti.com>
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

Hi Andrew,

On 5/6/2025 4:36 PM, Andrew Davis wrote:
> On 5/6/25 5:42 AM, Beleswar Padhi wrote:
>> The tispl.bin fit image is packed with the HSM firmware image. Populate
>> the "os" info of the image so that it can be detected and used to load
>> the HSM core. Further, invoke the load and boot of HSM core at R5 SPL
>> stage. Boot flow for HSM M4 core is as below:
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
>> v2: Changelog:
>> 1. Hang system boot if HSM firmware failed to boot.
>> 2. __maybe_unused to decrease preprocessor usage.
>> 3. Better error messages with return code.
>> 4. Added Error case in if-elseif-else ladder.
>>
>> Note:
>> #define PROC_ID_HSM_M4F seems to have extra tab in the diff/patch.
>> But when patch gets applied in file, all of them have consistent
>> tabs.
>>
>> Link to v1:
>> https://lore.kernel.org/all/18e01808-499d-4690-995a-45ac5fd727d9@ti.com
>>
>>   arch/arm/mach-k3/r5/common.c | 84 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 83 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
>> index 81fc67a0023..1aa3869cec2 100644
>> --- a/arch/arm/mach-k3/r5/common.c
>> +++ b/arch/arm/mach-k3/r5/common.c
>> @@ -15,9 +15,14 @@
>>   #include <spl.h>
>>   #include <remoteproc.h>
>>   #include <elf.h>
>> +#include <cpu_func.h>
>>     #include "../common.h"
>>   +#define PROC_BOOT_CTRL_RESET_FLAG_HSM_M4    0x00000001
>> +#define HSM_SRAM0_0_ADDR            0x43C00000
>> +#define PROC_ID_HSM_M4F                0x00000080
>> +
>>   #if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
>>   enum {
>>       IMAGE_ID_ATF,
>> @@ -27,6 +32,7 @@ enum {
>>       IMAGE_ID_TIFSSTUB_HS,
>>       IMAGE_ID_TIFSSTUB_FS,
>>       IMAGE_ID_T,
>
> The above line looks to be a typo, must have been meant to be 
> IMAGE_ID_TIFSSTUB_GP.
>
> I know this series didn't introduce this typo, but could you fix it in 
> this series
> since you touch lines around it and use it in patch [6/7]. That way we 
> don't get
> any merge conflicts if fixed in standalone patch.


Sure, I will fix that in PATCH 6/7.

>
>> +    IMAGE_ID_HSM,
>>       IMAGE_AMT,
>>   };
>>   @@ -39,6 +45,7 @@ static const char *image_os_match[IMAGE_AMT] = {
>>       "tifsstub-hs",
>>       "tifsstub-fs",
>>       "tifsstub-gp",
>> +    "hsm",
>>   };
>>   #endif
>>   @@ -136,6 +143,73 @@ void release_resources_for_core_shutdown(void)
>>       }
>>   }
>>   +static int __maybe_unused boot_hsm_core(void)
>> +{
>> +    struct ti_sci_handle *ti_sci = get_ti_sci_handle();
>> +    struct ti_sci_proc_ops *proc_ops = &ti_sci->ops.proc_ops;
>> +    u64 hsm_image_addr;
>> +    u32 hsm_image_size;
>> +    int device_type, ret;
>> +
>> +    hsm_image_addr = (u64)fit_image_info[IMAGE_ID_HSM].load;
>> +    hsm_image_size = (u32)fit_image_info[IMAGE_ID_HSM].image_len;
>> +
>> +    /* Request Control of Remote Processor */
>> +    ret = proc_ops->proc_request(ti_sci, PROC_ID_HSM_M4F);
>> +    if (ret) {
>> +        printf("Unable to request HSM processor control: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    /* Put the remote processor into reset */
>> +    ret = proc_ops->set_proc_boot_ctrl(ti_sci, PROC_ID_HSM_M4F,
>> +                       PROC_BOOT_CTRL_RESET_FLAG_HSM_M4, 0);
>> +    if (ret) {
>> +        printf("Unable to Halt HSM core: %d\n", ret);
>> +        goto release_proc_ctrl;
>> +    }
>> +
>> +    /*
>> +     * Load the HSM firmware into core's internal memory.
>> +     *
>> +     * In case of HS device types, request secure entity to 
>> authenticate and
>> +     * load the HSM firmware into the core memory.
>> +     * In case of GP device types, copy the HSM firmware into the core
>> +     * memory manually.
>> +     */
>> +    device_type = get_device_type();
>> +    if (device_type == K3_DEVICE_TYPE_HS_SE ||
>> +        device_type == K3_DEVICE_TYPE_HS_FS) {
>> +        ret = proc_ops->proc_auth_boot_image(ti_sci, &hsm_image_addr,
>> +                             &hsm_image_size);
>
> Could you use ti_secure_image_post_process() here? It should be able 
> to replace
> a bunch of the surrounding code too. If it returns without modifying 
> &size the
> you can go down the GP path.
>
> ti_secure_image_post_process() also flushes the image out of caches 
> before
> the TI-SCI call, without that there are cases where the image will not be
> readable by the TIFS core.


Thanks, that's cleaner, will do. Will wait for more reviews before 
re-spinning.

Thanks,
Beleswar

>
> Andrew
>
>> +        if (ret) {
>> +            printf("Unable to Authenticate and Boot HSM image; ret = 
>> %d\n",
>> +                   ret);
>> +            goto release_proc_ctrl;
>> +        }
>> +    } else if (device_type == K3_DEVICE_TYPE_GP) {
>> +        debug("Loading HSM GP binary into SRAM0_0\n");
>> +        memcpy((void *)HSM_SRAM0_0_ADDR, (void *)(u32)hsm_image_addr,
>> +               hsm_image_size);
>> +        flush_dcache_range(HSM_SRAM0_0_ADDR,
>> +                   HSM_SRAM0_0_ADDR + hsm_image_size);
>> +    } else {
>> +        printf("Invalid Device Type\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Release the reset from the remote processor*/
>> +    ret = proc_ops->set_proc_boot_ctrl(ti_sci, PROC_ID_HSM_M4F, 0,
>> +                       PROC_BOOT_CTRL_RESET_FLAG_HSM_M4);
>> +    if (ret)
>> +        printf("Unable to Run HSM core: %d\n", ret);
>> +
>> +release_proc_ctrl:
>> +    /* Release Control of Remote Processor */
>> +    proc_ops->proc_release(ti_sci, PROC_ID_HSM_M4F);
>> +    return ret;
>> +}
>> +
>>   void __noreturn jump_to_image_no_args(struct spl_image_info 
>> *spl_image)
>>   {
>>       typedef void __noreturn (*image_entry_noargs_t)(void);
>> @@ -157,6 +231,14 @@ void __noreturn jump_to_image_no_args(struct 
>> spl_image_info *spl_image)
>>                        &loadaddr);
>>       }
>>   +#if IS_ENABLED(CONFIG_K3_HSM_FW)
>> +    ret = boot_hsm_core();
>> +    if (ret)
>> +        panic("HSM core failed to boot, %d\n", ret);
>> +    else
>> +        printf("Successfully booted HSM core\n");
>> +#endif
>> +
>>       /*
>>        * It is assumed that remoteproc device 1 is the corresponding
>>        * Cortex-A core which runs ATF. Make sure DT reflects the same.
>> @@ -388,7 +470,7 @@ void board_fit_image_post_process(const void 
>> *fit, int node, void **p_image,
>>        * Only DM and the DTBs are being authenticated here,
>>        * rest will be authenticated when A72 cluster is up
>>        */
>> -    if ((i != IMAGE_ID_ATF) && (i != IMAGE_ID_OPTEE)) {
>> +    if (i != IMAGE_ID_ATF && i != IMAGE_ID_OPTEE && i != 
>> IMAGE_ID_HSM) {
>>           ti_secure_image_check_binary(p_image, p_size);
>>           ti_secure_image_post_process(p_image, p_size);
>>       } else {
