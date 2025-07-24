Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147A1C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 18:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4118D838DD;
	Thu, 24 Jul 2025 20:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XEKK3VHN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9F53838DF; Thu, 24 Jul 2025 20:51:34 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC9783844
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 20:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56OIpRID1557098;
 Thu, 24 Jul 2025 13:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753383087;
 bh=ummnQnzNyXtKkncU5dFqvldbU25dL7efsyRylCj1vnw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=XEKK3VHNm1Tqc8dAVFsmR7jK6gJB+7J60CAi72yWZPztiOLkMomz/i6ctctDTjUaF
 RAHDYw5w+ktkEFBergkBn4q0oizj53l8NK6nYh5iIpgglcm1lFWFEJhxqNaDEzogEQ
 1FZuzIa8qlCOslUdJgJXV5wj5u2tL+mMKoVDRW0g=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56OIpRuF3297883
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 24 Jul 2025 13:51:27 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 24
 Jul 2025 13:51:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 24 Jul 2025 13:51:27 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56OIpRsb592956;
 Thu, 24 Jul 2025 13:51:27 -0500
Message-ID: <314d7869-dd80-423b-8d7a-0599ecea3b51@ti.com>
Date: Thu, 24 Jul 2025 13:51:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-k3: am62*: am62*_init: Prohibit boot from UDA w/
 eMMC boot
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, <u-boot@lists.denx.de>
References: <20250710171135.669838-1-jm@ti.com>
 <20250717152950.n5bfcobot66stpz3@bryanbrattlof.com>
 <20250717160213.gs5m6cdpibkrvtdz@bryanbrattlof.com>
 <a5e4d6d5-4c11-4138-989b-4ef05a6e87de@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <a5e4d6d5-4c11-4138-989b-4ef05a6e87de@ti.com>
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

On 7/17/25 12:12 PM, Andrew Davis wrote:
> On 7/17/25 11:02 AM, Bryan Brattlof wrote:
>> On July 17, 2025 thus sayeth Bryan Brattlof:
>>> On July 10, 2025 thus sayeth Judith Mendez:
>>>> This removes support from booting from UDA when in eMMC boot.
>>>>
>>>> When user selects eMMC boot [0], that is, boot from eMMC boot0 or
>>>> boot1 HW partitions, we should not boot from eMMC UDA. The current
>>>> logic confuses the end user and mixes two different boot modes.
>>>>
>>>> The logic was added for AM62A/AM62P with commit: 3b7893145e36, but
>>>
>>> If we end up respinning this we should probably use the standard
>>> 'commit: <sha> "(<msg>)"' syntax.
>>>
>>>> this is not a clean solution and fix will come later for falcon boot.
>>>>
>>>> Logic was also added for AM62X with commit: 664593464634, but this
>>>> logic is incorrect according to TRM [0] under Primary Boot Mode 
>>>> Selection
>>>> for 'eMMC Boot'.
>>>>
>>>> Fixes: 3b7893145e36 ("mach-k3: add eMMC FS boot support for am62[ap]")
>>>> Fixes: 664593464634 ("arm: mach-k3: am625: Relax emmc boot condition")
>>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>>> ---
>>>>   arch/arm/mach-k3/am62ax/am62a7_init.c | 4 ----
>>>>   arch/arm/mach-k3/am62px/am62p5_init.c | 4 ----
>>>>   arch/arm/mach-k3/am62x/am625_init.c   | 4 ----
>>>>   3 files changed, 12 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c 
>>>> b/arch/arm/mach-k3/am62ax/am62a7_init.c
>>>> index edd43a1d78d..1d8644bd073 100644
>>>> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
>>>> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
>>>> @@ -217,10 +217,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const 
>>>> u32 boot_device)
>>>>       switch (bootmode) {
>>>>       case BOOT_DEVICE_EMMC:
>>>> -        if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
>>>> -            return MMCSD_MODE_EMMCBOOT;
>>>> -        if (IS_ENABLED(CONFIG_SPL_FS_FAT) || 
>>>> IS_ENABLED(CONFIG_SPL_FS_EXT4))
>>>> -            return MMCSD_MODE_FS;
>>>
>>> If we're booting from what ROM calls eMMC boot, which ROM has the
>>> limitation where we can only boot from MMC0 in 8bit 1v8 and in RAW mode.
>>> So I see the need to soften this requirement.
>>>
>>>>           return MMCSD_MODE_EMMCBOOT;
>>>>       case BOOT_DEVICE_MMC:
>>>
>>> But it also has what they call MMC/SD mode which gives us the option of
>>> booting from both MMC0 and MMC1 and in RAW or FS mode by setting the
>>> PORT and RAW pins which we can read in the WKUP_CTRL_MMR0. And can give
>>> us the same configuration as the previous boot mode.
>>>
>>
>> Wait no this is wrong. I think I should point out that this bootmode
>> only works in UDA mode. MMC/SD mode can be configured to use RAW offsets
>> or a FS to find the binary, but will not look in the boot partitions.
>>
>>> I agree if we know the next phases of boot won't fit in the boot
>>> partition we should be using this bootmode.
>>>
>>> But I know this takes away some functionality after people have
>>> already had their boards made and who cannot realistically change
>>> their bootmode pins. I wonder if we should mark this as __weak so
>>> people can override this in the board/ directory if needed?
>>
>> I still tend to agree we don't really want to modify the boodmode for
>> the next phase but with falcon mode and how massive U-Boot can be
>> sometimes. I don't think we can get away from this unless we let
>> individual boards modify this for their own need.
>>
> 
> Core issue is we assume all boot stages are stored on the same boot
> media. Usually this is a good assumption, and without it we would
> have to hard-code where the next boot stage is located at compile
> time. The big exception being the eMMC BOOT partition which is not
> big enough for all stages, so at some point we have to switch
> (usually to the eMMC's UDA partition), but *when* we switch is
> not clear. It could be after R5 SPL, or A53 SPL, or after
> U-Boot proper (only kernel/rootfs need stored on UDA).
> 
> The logic we have in U-Boot now is that you pick when you want to
> switch by disabling CONFIG_SUPPORT_EMMC_BOOT for the stage before
> the stage on the UDA FS partition. But this is confusing, forces
> FS mode, and only works if you don't switch between the two
> A53 stages.
> 
> Some better way to configure when to switch would be useful,
> and not just for eMMC, for instance I test R5 SPL by loading test
> builds over UART, but I want the next stages that I'm not testing
> to be loaded from the SD card, could we make a simple way to encode
> this without overwriting spl_boot_device()?

The goal of this patch was to clean up code due to questions we
get asked: I am booting with eMMC boot, but why is the wrong
image used, eMMC boot doesn't boot from UDA, why is the code returning
MMCSD_MODE_FS, etc... What you are suggesting is to further enhance
the feature that we have atm. If the end-user selects eMMC boot
based-off the TRM boot mode pins and with some flags or bits, we
can select not only MMCSD boot from UDA, but other boot modes, won't
this make the issue worse???

~ Judith




