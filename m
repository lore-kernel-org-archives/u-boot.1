Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE9CC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A8FF80A09;
	Wed, 29 Jan 2025 18:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hPQOp2OV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Btmy6AsI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E5380B9B; Wed, 29 Jan 2025 18:03:57 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E993C80843
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YjpQf3K3Qz9sR8;
 Wed, 29 Jan 2025 18:03:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1n+zAIlF46UZWAAHcxO/zkOQx1VmLchcTRcyrZEqC4=;
 b=hPQOp2OVkyMMfC1xW/63mDfZLKLIYqANUfXTSm5/oZBHimCqVwoSd4bofvkttsjQzhC0Qy
 OobfaBPIrWg92GdJ9Bc/TJ6+JftuYaPWvhW0OHzQheDpPYscnxp9KnoJACTIq7zTa/cfu7
 8Mdl5yKfBRsgFWP7k60nS2GkuET4CA4oNJ3y+LCVMf78hJoG8muCyJn+mbhgo1P+5vmf44
 ItTUSDB2KV2+kqHI/lx5Kgb2NNCpNIq8cJFf/TTpN/ubztlevOVvAjLvFuIrzzse7EE1SG
 GCIDLRLJxxnpUVyMLJmyPE+IyeVOAidqngB6hWDA068sUTFaRPuKc+kwBJxWYA==
Message-ID: <c2187455-fb1b-4622-9433-692f75fb0af8@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1n+zAIlF46UZWAAHcxO/zkOQx1VmLchcTRcyrZEqC4=;
 b=Btmy6AsIBTVtVOhEgaURqb7Nb5VcqI+mglKbD4AFOUjo+9bMbvCd71cuuw6+5MMk2GFipY
 dfGPbfiYSXOhsseniW6HmAGuLfMQAd3zllKYuvh1D5vQ8abliCxOSFOLseZQE9AKCPMT0A
 VTa3uHtR92vRinxcDl0ArEljcNN2ex4FRVkyjmYwIf367CThdIldlK5gZxAvjj1J2qIg4S
 AMvwj5y8XYf+k4BhiXet9/VMukmgk3msTBO3E0Q/Ad4AmEj8sS0y8MlRg9CpJBLcJGsfpo
 gMm9V9oImDYi279i8/BfLafNwOyRfaBPRjIIW3+r/sRv6/uJoX41GSTZ4LVzbw==
Date: Wed, 29 Jan 2025 18:03:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] arm64: renesas: Add TFA BL31 handoff support
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-3-marek.vasut+renesas@mailbox.org>
 <8409fd39-3816-4686-9b9c-56785209ed37@cherry.de>
 <fb463ad1-70c6-4c7b-b04a-db44556609d3@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <fb463ad1-70c6-4c7b-b04a-db44556609d3@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6d6575a2746ac7e2f5d
X-MBO-RS-META: dy9o93fxc14bmdhxou99tkbmcjgo8iyi
X-Rspamd-Queue-Id: 4YjpQf3K3Qz9sR8
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

On 1/29/25 5:28 PM, Quentin Schulz wrote:
> 
> 
> On 1/29/25 5:02 PM, Quentin Schulz wrote:
>> Hi Marek,
>>
>> On 1/12/25 11:36 PM, Marek Vasut wrote:
>>> Implement custom U_BOOT_FIT_LOADABLE_HANDLER and 
>>> armv8_switch_to_el2_prep()
>>> handling in case the TFA was loaded. The loadables handler sets up 
>>> custom
>>> handoff structure used by Renesas TFA fork in fixed location in DRAM and
>>> indicates the TFA has been loaded.
>>>
>>> The custom armv8_switch_to_el2_prep() handling tests whether the TFA 
>>> BL31
>>> was previously loaded and the custom handoff structure was set up, 
>>> and if
>>> so, jumps to TFA BL31 which switches from EL3 to EL2 and then returns to
>>> U-Boot just past bl in armv8_switch_to_el2() to finish starting the 
>>> Linux
>>> kernel.
>>>
>>> The jump to Linux through TFA works in such a way that the custom
>>> armv8_switch_to_el2_prep() handler configures the custom handoff 
>>> structure
>>> such that the target jump address of the TFA BL31 on exit is set to the
>>> armv8_switch_to_el2() + 4, which is just past the bl, and just before 
>>> the
>>> U-Boot code which implements the Linux kernel boot from either EL. The
>>> registers passed through the TFA BL31 are all the registers passed into
>>> armv8_switch_to_el2_prep() to assure maximum compatibility with all the
>>> boot modes. The armv8_switch_to_el2_prep() handler jumps to the TFA 
>>> BL31,
>>> which does its setup, drops EL from EL3 to EL2 and finally jumps to the
>>> armv8_switch_to_el2() + 4 entry point, which then allows U-Boot to boot
>>> the Linux kernel the usual way.
>>>
>>> In order to build suitable kernel fitImage, build TFA first, temporarily
>>> from downstream repository:
>>> remote: https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fgithub.com%2Frenesas-rcar%2Farm-trusted- 
>>> firmware.git&data=05%7C02%7Cquentin.schulz%40cherry.de%7C6ab2eb623e32425379f108dd407e5a7c%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638737633628498421%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=DWQfUm5mp9%2FMCUxvFFbO1yfjKlvmtfiOD8VTkN%2BEZKk%3D&reserved=0
>>> branch: rcar_gen4_v2.7_v4x
>>>
>>> ```
>>> $ git clean -fqdx
>>> $ MBEDTLS_DIR=/path/to/mbedtls/ make -j$(nproc) bl31 \
>>>     PLAT=rcar_gen4 ARCH=aarch64 LSI=V4H SPD=none \
>>>     CTX_INCLUDE_AARCH32_REGS=0 MBEDTLS_COMMON_MK=1 \
>>>     PTP_NONSECURE_ACCESS=1 LOG_LEVEL=20 DEBUG=0 \
>>>     ENABLE_ASSERTIONS=0 E=0
>>> ```
>>>
>>> Build Linux kernel Image and device tree from current mainline Linux
>>> kernel repository, obtain 'Image' and 'r8a779g0-white-hawk.dtb' .
>>>
>>> Bundle the files together using provided fit-image.its fitImage 
>>> description:
>>> ```
>>> $ mkimage -f fit-image.its fitImage
>>> ```
>>>
>>> To start the kernel fiImage generated in previous step, load fitImage
>>> to DRAM and use the 'bootm' command to start it:
>>> => load 0x58000000 ... fitImage && bootm 0x58000000
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> ---
>>> Cc: Andre Przywara <andre.przywara@arm.com>
>>> Cc: Caleb Connolly <caleb.connolly@linaro.org>
>>> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Cc: Julien Masson <jmasson@baylibre.com>
>>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>> Cc: Maxim Moskalets <maximmosk4@gmail.com>
>>> Cc: Michael Walle <mwalle@kernel.org>
>>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>> Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
>>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> Cc: Paul-Erwan Rio <paulerwan.rio@gmail.com>
>>> Cc: Peter Hoyes <Peter.Hoyes@arm.com>
>>> Cc: Raymond Mao <raymond.mao@linaro.org>
>>> Cc: Sam Protsenko <semen.protsenko@linaro.org>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: u-boot@lists.denx.de
>>> ---
>>>   board/renesas/common/gen4-common.c | 118 +++++++++++++++++++++++++++++
>>>   1 file changed, 118 insertions(+)
>>>
>>> diff --git a/board/renesas/common/gen4-common.c b/board/renesas/ 
>>> common/gen4-common.c
>>> index 52a0639073b..c7f3f9a30ab 100644
>>> --- a/board/renesas/common/gen4-common.c
>>> +++ b/board/renesas/common/gen4-common.c
>>> @@ -7,11 +7,13 @@
>>>   #include <asm/arch/renesas.h>
>>>   #include <asm/arch/sys_proto.h>
>>> +#include <asm/armv8/mmu.h>
>>>   #include <asm/global_data.h>
>>>   #include <asm/io.h>
>>>   #include <asm/mach-types.h>
>>>   #include <asm/processor.h>
>>>   #include <asm/system.h>
>>> +#include <image.h>
>>>   #include <linux/errno.h>
>>>   #define RST_BASE    0xE6160000 /* Domain0 */
>>> @@ -88,3 +90,119 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>>>   {
>>>       return 0;
>>>   }
>>> +
>>> +/* R-Car Gen4 TFA BL31 handoff structure and handling. */
>>> +struct param_header {
>>> +    u8            type;
>>> +    u8            version;
>>> +    u16            size;
>>> +    u32            attr;
>>> +};
>>> +
>>> +struct tfa_image_info {
>>> +    struct param_header    h;
>>> +    uintptr_t        image_base;
>>> +    u32            image_size;
>>> +    u32            image_max_size;
>>> +};
>>> +
>>> +struct aapcs64_params {
>>> +    u64            arg0;
>>> +    u64            arg1;
>>> +    u64            arg2;
>>> +    u64            arg3;
>>> +    u64            arg4;
>>> +    u64            arg5;
>>> +    u64            arg6;
>>> +    u64            arg7;
>>> +};
>>> +
>>> +struct entry_point_info {
>>> +    struct param_header    h;
>>> +    uintptr_t        pc;
>>> +    u32            spsr;
>>> +    struct aapcs64_params    args;
>>> +};
>>> +
>>> +struct bl2_to_bl31_params_mem {
>>> +    struct tfa_image_info    bl32_image_info;
>>> +    struct tfa_image_info    bl33_image_info;
>>> +    struct entry_point_info    bl33_ep_info;
>>> +    struct entry_point_info    bl32_ep_info;
>>> +};
>>> +
>>> +/* Default jump address, return to U-Boot */
>>> +#define BL33_BASE    0x44100000
>>> +/* Custom parameters address passed to TFA by ICUMXA loader */
>>> +#define PARAMS_BASE    0x46422200
>>> +
>>
>> Shouldn't we rather set those as offset compared to the load/entry 
>> address passed in the ITS?
>>
>>> +/* Usually such a structure is produced by ICUMXA and passed in at 
>>> 0x46422200 */
>>> +static const struct bl2_to_bl31_params_mem blinfo_template = {
>>> +    .bl33_ep_info.h.type = 1,    /* PARAM_EP */
>>> +    .bl33_ep_info.h.version = 2,    /* Version 2 */
>>> +    .bl33_ep_info.h.size = sizeof(struct entry_point_info),
>>> +    .bl33_ep_info.h.attr = 0x81,    /* Executable | Non-Secure */
>>> +    .bl33_ep_info.spsr = 0x2c9,    /* Mode=EL2, SP=ELX, 
>>> Exceptions=OFF */
>>> +    .bl33_ep_info.pc = BL33_BASE,
>>> +
>>> +    .bl33_image_info.h.type = 1,    /* PARAM_EP */
>>> +    .bl33_image_info.h.version = 2,    /* Version 2 */
>>> +    .bl33_image_info.h.size = sizeof(struct image_info),
>>> +    .bl33_image_info.h.attr = 0,
>>> +    .bl33_image_info.image_base = BL33_BASE,
>>> +};
>>> +
>>> +static bool tfa_bl31_image_loaded;
>>> +static ulong tfa_bl31_image_addr;
>>> +
>>> +static void tfa_bl31_image_process(ulong image, size_t size)
>>> +{
>>> +    /* Custom parameters address passed to TFA by ICUMXA loader */
>>> +    struct bl2_to_bl31_params_mem *blinfo = (struct 
>>> bl2_to_bl31_params_mem *)PARAMS_BASE;
>>> +
>>> +    /* Clear a page and copy template */
>>> +    memset((void *)PARAMS_BASE, 0, PAGE_SIZE);
>>> +    memcpy(blinfo, &blinfo_template, sizeof(*blinfo));
>>> +    tfa_bl31_image_addr = image;
>>> +    tfa_bl31_image_loaded = true;
>>> +}
>>> +
>>> +U_BOOT_FIT_LOADABLE_HANDLER(IH_TYPE_TFA_BL31, tfa_bl31_image_process);
>>> +
>>> +void armv8_switch_to_el2_prep(u64 args, u64 mach_nr, u64 fdt_addr,
>>> +                  u64 arg4, u64 entry_point, u64 es_flag)
>>> +{
>>> +    typedef void __noreturn (*image_entry_noargs_t)(void);
>>> +    image_entry_noargs_t image_entry =
>>> +        (image_entry_noargs_t)(void *)tfa_bl31_image_addr;
>>> +    struct bl2_to_bl31_params_mem *blinfo =
>>> +        (struct bl2_to_bl31_params_mem *)PARAMS_BASE;
>>> +
>>> +    /*
>>> +     * Destination address in arch/arm/cpu/armv8/transition.S
>>> +     * right past the first bl in armv8_switch_to_el2() to let
>>> +     * the rest of U-Boot pre-Linux code run. The code does run
>>> +     * without stack pointer!
>>> +     */
>>> +    const u64 ep = ((u64)(uintptr_t)&armv8_switch_to_el2) + 4;
>>> +
>>> +    /* If TFA BL31 was not part of the fitImage, do regular boot. */
>>> +    if (!tfa_bl31_image_loaded)
>>> +        return;
>>> +
>>> +    /*
>>> +     * Set up kernel entry point and parameters:
>>> +     * x0 is FDT address, x1..x3 must be 0
>>> +     */
>>> +    blinfo->bl33_ep_info.pc = ep;
>>> +    blinfo->bl33_ep_info.args.arg0 = args;
>>> +    blinfo->bl33_ep_info.args.arg1 = mach_nr;
>>> +    blinfo->bl33_ep_info.args.arg2 = fdt_addr;
>>> +    blinfo->bl33_ep_info.args.arg3 = arg4;
>>> +    blinfo->bl33_ep_info.args.arg4 = entry_point;
>>> +    blinfo->bl33_ep_info.args.arg5 = es_flag;
>>> +    blinfo->bl33_image_info.image_base = ep;
>>> +
>>> +    /* Jump to TFA BL31 */
>>> +    image_entry();
>>> +}
>>
>> Shouldn't we have a weak implementation that SoC vendor can override 
>> if they feel like it?
>>
>> To me this feels like it could be much quicker adopted if we had some 
>> default people could try out for their boards.
>>
>> We already have a generic spl_invoke_atf() so why not the same for 
>> this mechanism? As far as I could tell, we get the load address of TEE 
>> and U- Boot proper (bl32 and bl33) and pass it the FDT (or nothing if 
>> SPL_ATF_NO_PLATFORM_PARAM symbol set).
>>
>> I am not too sure who and how TEE will be started as it needs to be 
>> executing in EL3 too I believe? So we may still have to provide that 
>> one? BL33 would be the kernel params like you did in this patch. Then 
>> the bl31 param could also be either the fdt or nothing if 
>> ATF_NO_PLATFORM_PARAM is set.
>>
> 
> Actually, I would highly prefer we don't even have this symbol and have 
> instead a property in the TF-A image node in the ITS to say whether 
> we're allowed to pass parameters or not to BL31? The user bundling TF-A 
> inside the linux.itb should know (well, we should probably know also 
> when building BL31 within u-boot.itb....).

This is something user should decide in their own board/arch specific 
implementation of tfa_bl31_image_process()/armv8_switch_to_el2_prep(). 
These two functions are architecture/board specific because of the 
various forks of TFA BL31 and the need to handle those various handoff 
structures.

> We actually need this symbol on all Rockchip boards using the Rockchip 
> blob and not upstream. But this also prevents us from using some 
> featureset of the upstream TF-A if we rebuild without disabling the 
> symbol. It'd be nice if we don't have to rebuild U-Boot depending on 
> which variant of BL31 we use on Rockchip, this info should be stored in 
> the linux.itb is what I'm saying. This doesn't need to be in this 
> introducing commit though I believe, we can work something out later I 
> guess.
Maybe this comment is not really applicable ?
