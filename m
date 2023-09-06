Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D163EE14D6
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 20:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0480865A2;
	Wed,  6 Sep 2023 22:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 487FC865A5; Wed,  6 Sep 2023 22:10:10 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id F081886407
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 22:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robin.murphy@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C3DA106F;
 Wed,  6 Sep 2023 13:10:44 -0700 (PDT)
Received: from [10.57.5.192] (unknown [10.57.5.192])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2A993F67D;
 Wed,  6 Sep 2023 13:10:03 -0700 (PDT)
Message-ID: <9032b524-54f9-d74a-7be4-79b437e65324@arm.com>
Date: Wed, 6 Sep 2023 21:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/5] armv8: fsl-layerscape: create bypass smmu mapping for
 MC
Content-Language: en-GB
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>, Ashish.Kumar@nxp.com,
 priyanka.jain@nxp.com, wasim.khan@nxp.com, meenakshi.aggarwal@nxp.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, peng.fan@nxp.com,
 sjg@chromium.org, sean.anderson@seco.com, ioana.ciornei@nxp.com,
 u-boot@lists.denx.de
Cc: thierry.reding@gmail.com
References: <20230906160152.24185-1-laurentiu.tudor@nxp.com>
 <20230906160152.24185-3-laurentiu.tudor@nxp.com>
 <56c3c58c-e871-5bfc-d256-fff30cc5cbf6@arm.com>
 <1931b72d-8345-73a7-7a2d-8c64a5168047@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1931b72d-8345-73a7-7a2d-8c64a5168047@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2023-09-06 19:10, Laurentiu Tudor wrote:
> 
> 
> On 9/6/2023 8:21 PM, Robin Murphy wrote:
>> On 2023-09-06 17:01, Laurentiu Tudor wrote:
>>> MC being a plain DMA master as any other device in the SoC and
>>> being live at OS boot time, as soon as the SMMU is probed it
>>> will immediately start triggering faults because there is no
>>> mapping in the SMMU for the MC. Pre-create such a mapping in
>>> the SMMU, being the OS's responsibility to preserve it.
>>
>> Does U-Boot enable the SMMU? AFAICS the only thing it knows how to do 
>> is explicitly turn it *off*, therefore programming other registers 
>> appears to be a complete waste of time.
> 
> No, it doesn't enable SMMU but it does mark a SMR as valid for MC FW. 
> And the ARM SMMU driver subtly preserves it, see [1] (it's late and I 
> might be wrong, but I'll double check tomorrow). :-)

No, that sets the SMR valid bit *if* the corresponding entry is 
allocated and marked as valid in the software state in smmu->smrs, which 
at probe time it isn't, because that's only just been allocated and is 
still zero-initialised. Unless, that is, 
arm_smmu_rmr_install_bypass_smr() found a reserved region and 
preallocated an entry to honour it. But even those entries are still 
constructed from scratch; we can't do anything with the existing 
SMR/S2CR register contents in general since they may be uninitialised 
random reset values, so we don't even look.

Pay no attention to the qcom_smmu_cfg_probe() hack either - that only 
exists on the promise that the relevant platforms couldn't have their 
firmware updated to use proper RMRs.

You're already doing the right thing in patch #2, so there's no need to 
waste code on doing a pointless wrong thing as well.

Thanks,
Robin.

>> All that should matter to the OS, and that it is responsible for 
>> upholding, is the reserved memory regions from patch #2. For instance, 
>> if the OS is Linux, literally the first thing arm_smmu_device_reset() 
>> does is rewrite all the S2CRs and SMRs without so much as looking.
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm/arm-smmu/arm-smmu.c#n894
> 
> ---
> Best Regards, Laurentiu
> 
>>
>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>> ---
>>>   arch/arm/cpu/armv8/fsl-layerscape/soc.c       | 26 ++++++++++++++++---
>>>   .../asm/arch-fsl-layerscape/immap_lsch3.h     |  9 +++++++
>>>   2 files changed, 32 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/soc.c 
>>> b/arch/arm/cpu/armv8/fsl-layerscape/soc.c
>>> index 3bfdc3f77431..870b99838ab5 100644
>>> --- a/arch/arm/cpu/armv8/fsl-layerscape/soc.c
>>> +++ b/arch/arm/cpu/armv8/fsl-layerscape/soc.c
>>> @@ -376,6 +376,18 @@ void bypass_smmu(void)
>>>       val = (in_le32(SMMU_NSCR0) | SCR0_CLIENTPD_MASK) & 
>>> ~(SCR0_USFCFG_MASK);
>>>       out_le32(SMMU_NSCR0, val);
>>>   }
>>> +
>>> +void setup_smmu_mc_bypass(int icid, int mask)
>>> +{
>>> +    u32 val;
>>> +
>>> +    val = SMMU_SMR_VALID_MASK | (icid << SMMU_SMR_ID_SHIFT) |
>>> +        (mask << SMMU_SMR_MASK_SHIFT);
>>> +    out_le32(SMMU_REG_SMR(0), val);
>>> +    val = SMMU_S2CR_EXIDVALID_VALID_MASK | SMMU_S2CR_TYPE_BYPASS_MASK;
>>> +    out_le32(SMMU_REG_S2CR(0), val);
>>> +}
>>> +
>>>   void fsl_lsch3_early_init_f(void)
>>>   {
>>>       erratum_rcw_src();
>>> @@ -402,10 +414,18 @@ void fsl_lsch3_early_init_f(void)
>>>           bypass_smmu();
>>>   #endif
>>> -#if defined(CONFIG_ARCH_LS1088A) || defined(CONFIG_ARCH_LS1028A) || \
>>> -    defined(CONFIG_ARCH_LS2080A) || defined(CONFIG_ARCH_LX2160A) || \
>>> -    defined(CONFIG_ARCH_LX2162A)
>>> +#ifdef CONFIG_ARCH_LS1028A
>>> +    set_icids();
>>> +#endif
>>> +
>>> +#if defined(CONFIG_ARCH_LS1088A) || defined(CONFIG_ARCH_LS2080A)
>>> +    set_icids();
>>> +    setup_smmu_mc_bypass(0x300, 0);
>>> +#endif
>>> +
>>> +#if defined(CONFIG_ARCH_LX2160A) || defined(CONFIG_ARCH_LX2162A)
>>>       set_icids();
>>> +    setup_smmu_mc_bypass(0x4000, 0);
>>>   #endif
>>>   }
>>> diff --git a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h 
>>> b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
>>> index ca5e33379ba9..bec5355adaed 100644
>>> --- a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
>>> +++ b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
>>> @@ -190,6 +190,15 @@
>>>   #define SCR0_CLIENTPD_MASK        0x00000001
>>>   #define SCR0_USFCFG_MASK        0x00000400
>>> +#define SMMU_REG_SMR(n)            (SMMU_BASE + 0x800 + ((n) << 2))
>>> +#define SMMU_REG_S2CR(n)        (SMMU_BASE + 0xc00 + ((n) << 2))
>>> +#define SMMU_SMR_VALID_MASK        0x80000000
>>> +#define SMMU_SMR_MASK_MASK        0xffff0000
>>> +#define SMMU_SMR_MASK_SHIFT        16
>>> +#define SMMU_SMR_ID_MASK        0x0000ffff
>>> +#define SMMU_SMR_ID_SHIFT        0
>>> +#define SMMU_S2CR_EXIDVALID_VALID_MASK    0x00000400
>>> +#define SMMU_S2CR_TYPE_BYPASS_MASK    0x00010000
>>>   /* PCIe */
>>>   #define CFG_SYS_PCIE1_ADDR            (CONFIG_SYS_IMMR + 0x2400000)
