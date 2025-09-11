Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17793CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 14:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A83B833AD;
	Thu, 11 Sep 2025 16:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uFh1n3TD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6BAA8334F; Thu, 11 Sep 2025 16:48:43 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E93833C6
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 16:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BEmdNk768132;
 Thu, 11 Sep 2025 09:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757602119;
 bh=a+YL+ixNi33A+nFk5xJuwaWFg9qBIUF76yJsVC0BwXI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=uFh1n3TDlKbHCn84NpqggEw4zHPz+vvxthFxE72/qyFEKjpMqajzw324l+AUVKqAo
 xUGWA5fjqDcU1D2xHiE9L6LV9y1aNev6LNl/E53oF/US5YXI08s2WiZOtNW6dj/8bY
 8SgW5bdaBSChviqXseXCfTvinQAMOISWP4UCwdek=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BEmd1M2013823
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 09:48:39 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 09:48:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 09:48:38 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BEmc311986826;
 Thu, 11 Sep 2025 09:48:38 -0500
Message-ID: <c5d62f63-c107-4834-a70e-6a65f25b75c0@ti.com>
Date: Thu, 11 Sep 2025 09:48:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: mach-k3: Fix MMC macros
To: "Kumar, Udit" <u-kumar1@ti.com>, Tom Rini <trini@konsulko.com>, Moteen
 Shah <m-shah@ti.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Moteen Shah <m-shah@ti.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>
References: <20250910214514.1848847-1-jm@ti.com>
 <20250910214514.1848847-2-jm@ti.com>
 <9bb08b19-ca4a-40f2-afcf-92af0a71b51a@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <9bb08b19-ca4a-40f2-afcf-92af0a71b51a@ti.com>
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

Hi Udit, Moteen,

On 9/10/25 11:38 PM, Kumar, Udit wrote:
> 
> On 9/11/2025 3:15 AM, Judith Mendez wrote:
>> For all K3 SoC's eMMC boot and MMCSD boot modes are supported. The macros
>> however, mix MMC device with the two bootmodes. Decouple the two types
>> of macros so that bootmodes can be identified with:
>> - BOOT_DEVICE_MMCSD
>> - BOOT_DEVICE_EMMC
> 
> Few devices already (kind of have this )
> 
> arch/arm/mach-k3/include/mach/j722s_spl.h
> 
> #define BOOT_DEVICE_MMC                 0x08
> #define BOOT_DEVICE_EMMC                0x09
> 
> can we use in same way, BOOT_DEVICE_MMC  as SD instead of adding SD as 
> postfix and
> 
> and add BOOT_DEVICE_EMMC, on devices where this is missing

No, there are two boot modes. MMCSD boot and EMMC boot. That is what I
am trying to make clear with switching:

 > #define BOOT_DEVICE_MMC                 0x08
 > #define BOOT_DEVICE_EMMC                0x09
To:

 > #define BOOT_DEVICE_MMCSD                 0x08
 > #define BOOT_DEVICE_EMMC                0x09

When we say: BOOT_DEVICE_MMC, it is not obvious it is from am62x/j722s
TRM:

MMCSD Boot (SD Card Boot or eMMC Boot using UDA). The goal of these
two specific macros is to mimic the supported boot modes.

> 
> 
>> according to devstat parsed boot mode values and on-board devices can be
>> identified with:
>> - BOOT_DEVICE_MMC1
>> - BOOT_DEVICE_MMC2
>> - BOOT_DEVICE_MMC2_2
> 
> Why you need to change
> 
> #define for BOOT_DEVICE_MMC1 and and BOOT_DEVICE_MMC2

Because the goals is to decouple the bootmodes from the macros used to
distinguish eMMC and SD card devices.

> 
> 
> 
>> according to arbitrary numbers mainly used to differentiate between eMMC
>> and SD card.
> 
> Please check subject line, this is not a fix
> 
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   arch/arm/mach-k3/am62ax/am62a7_init.c          |  4 ++--
>>   arch/arm/mach-k3/am62ax/boot.c                 |  8 ++++----
>>   arch/arm/mach-k3/am62px/am62p5_init.c          | 12 ++++++------
>>   arch/arm/mach-k3/am62x/am625_init.c            |  4 ++--
>>   arch/arm/mach-k3/am62x/boot.c                  |  8 ++++----
>>   arch/arm/mach-k3/am64x/boot.c                  |  8 ++++----
>>   arch/arm/mach-k3/am65x/am654_init.c            | 18 ++++++++++--------
>>   arch/arm/mach-k3/include/mach/am62_hardware.h  |  8 ++++----
>>   arch/arm/mach-k3/include/mach/am62_spl.h       | 10 +++++-----
>>   arch/arm/mach-k3/include/mach/am62a_hardware.h |  8 ++++----
>>   arch/arm/mach-k3/include/mach/am62a_spl.h      | 10 +++++-----
>>   arch/arm/mach-k3/include/mach/am62p_hardware.h |  8 ++++----
>>   arch/arm/mach-k3/include/mach/am62p_spl.h      | 10 +++++-----
>>   arch/arm/mach-k3/include/mach/am64_hardware.h  |  4 ++--
>>   arch/arm/mach-k3/include/mach/am64_spl.h       | 13 +++++++------
>>   arch/arm/mach-k3/include/mach/am6_hardware.h   |  8 ++++----
>>   arch/arm/mach-k3/include/mach/am6_spl.h        | 13 +++++++++----
>>   arch/arm/mach-k3/include/mach/j721e_hardware.h |  6 +++---
>>   arch/arm/mach-k3/include/mach/j721e_spl.h      | 14 ++++++++++----
>>   .../arm/mach-k3/include/mach/j721s2_hardware.h |  6 +++---
>>   arch/arm/mach-k3/include/mach/j721s2_spl.h     | 13 +++++++++----
>>   arch/arm/mach-k3/include/mach/j722s_hardware.h |  8 ++++----
>>   arch/arm/mach-k3/include/mach/j722s_spl.h      | 10 +++++-----
>>   .../arm/mach-k3/include/mach/j784s4_hardware.h |  6 +++---
>>   arch/arm/mach-k3/include/mach/j784s4_spl.h     | 13 +++++++++----
>>   arch/arm/mach-k3/j721e/j721e_init.c            | 14 +++++++++-----
>>   arch/arm/mach-k3/j721s2/j721s2_init.c          | 14 +++++++++-----
>>   arch/arm/mach-k3/j722s/j722s_init.c            | 12 ++++++------
>>   arch/arm/mach-k3/j784s4/j784s4_init.c          | 14 +++++++++-----
>>   29 files changed, 160 insertions(+), 124 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/ 
>> am62ax/am62a7_init.c
>> index 00173e6836b..1fd466bbdfc 100644
>> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
>> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
>> @@ -225,8 +225,8 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 
>> boot_device)
>>           if (IS_ENABLED(CONFIG_SPL_FS_FAT) || 
>> IS_ENABLED(CONFIG_SPL_FS_EXT4))
>>               return MMCSD_MODE_FS;
>>           return MMCSD_MODE_EMMCBOOT;
>> [..]
>> +    if (bootmode == BOOT_DEVICE_EMMC)
>> +        bootmode = BOOT_DEVICE_MMC1;
>> +
> 
> Could you test once, eMMC on J784s4

I do not have J784s4, Moteen, would you be able to test?

~ Judith
