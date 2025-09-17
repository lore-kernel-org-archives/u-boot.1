Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD2ACAC5A0
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C04836A4;
	Wed, 17 Sep 2025 18:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hCN78HAX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F150836A6; Wed, 17 Sep 2025 18:06:51 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86ED8365C
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 18:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58HG6kPO1553516;
 Wed, 17 Sep 2025 11:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758125206;
 bh=CnhPX/iebRiuW4cEmZMHAN2TFU4wnsB7p6LlIDFn15A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=hCN78HAXHV7y8szA/RqOMUngwYPPY6lPpQoOvLXZHWeQXMKVN1x4zbDyTPht8JRDa
 KT40l+Y/g4Ts3vFLzaqtvW6xKny20juBrttL+yNkY75kDIARShYgkvJYYbc0fmDM1A
 Q/G/BxEJgpyqcYv9duLa860O4lknj2tZgok7amDw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58HG6kBC1664168
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 17 Sep 2025 11:06:46 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 11:06:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 11:06:45 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58HG6jFv3621731;
 Wed, 17 Sep 2025 11:06:45 -0500
Message-ID: <4deb9bf9-f1d7-472c-93d2-5ccaf96ba4f0@ti.com>
Date: Wed, 17 Sep 2025 11:06:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: mach-k3: Fix MMC macros
To: Anshul Dalal <anshuld@ti.com>, Andrew Davis <afd@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Vaishnav Achath" <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, "Moteen Shah" <m-shah@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250910214514.1848847-1-jm@ti.com>
 <20250910214514.1848847-2-jm@ti.com> <DCPPO8O0GIVD.1CWNDWAKDGVEC@ti.com>
 <b61c7f41-6e1d-4d90-a8b8-e446bc32e3a6@ti.com>
 <9c1b1344-b6fb-4ad4-aaec-1b187e1cd27d@ti.com>
 <c9b5d045-e719-40b3-acf4-cf887e0ce51b@ti.com>
 <DCURIP1YMD3G.2JMJP9EN3EE2K@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <DCURIP1YMD3G.2JMJP9EN3EE2K@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/16/25 10:41 PM, Anshul Dalal wrote:
> Hi Judith,
> 
> On Wed Sep 17, 2025 at 4:05 AM IST, Judith Mendez wrote:
>> Hi Andrew, Anshul,
>>
>> On 9/16/25 11:22 AM, Andrew Davis wrote:
>>> On 9/11/25 9:59 AM, Judith Mendez wrote:
>>>> Hi Anshul,
>>>>
>>>> On 9/11/25 12:11 AM, Anshul Dalal wrote:
>>>>> On Thu Sep 11, 2025 at 3:15 AM IST, Judith Mendez wrote:
>>>>>> For all K3 SoC's eMMC boot and MMCSD boot modes are supported. The
>>>>>> macros
>>>>>> however, mix MMC device with the two bootmodes. Decouple the two types
>>>>>> of macros so that bootmodes can be identified with:
>>>>>> - BOOT_DEVICE_MMCSD
>>>>>> - BOOT_DEVICE_EMMC
>>>>>> according to devstat parsed boot mode values and on-board devices
>>>>>> can be
>>>>>> identified with:
>>>>>> - BOOT_DEVICE_MMC1
>>>>>> - BOOT_DEVICE_MMC2
>>>>>> - BOOT_DEVICE_MMC2_2
>>>>>> according to arbitrary numbers mainly used to differentiate between
>>>>>> eMMC
>>>>>> and SD card.
>>>>>>
>>>>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>>>>> ---
>>>>>
>>>>> I guess the confusion here is how we are calling boot modes from devstat
>>>>> as well as the boot device as BOOT_DEVICE_*. Perhaps we should rename
>>>>> the former to DEVSTAT_BOOT_MODE_* or something along those lines.
>>>>>
>>>>> That would make the difference between a boot *mode* and a boot *device*
>>>>> more clear, DEVSTAT_BOOT_MODE_MMCSD or DEVSTATE_BOOT_MODE_EMMC would
>>>>> distinguish between SD or EMMC boot modes with BOOT_DEVICE_MMC*
>>>>> indicating the MMC port used.
>>>>>
>>>>> This would also allow use to only have the respective
>>>>> DEVSTAT_BOOT_MODE_* defined in each soc's headers with BOOT_DEVICE_*
>>>>> coming from arch/arm/include/asm/spl.h.
>>>>
>>>>
>>>> Right, I guess if
>>>>
>>>> BOOT_DEVICE_MMCSD
>>>> BOOT_DEVICE_EMMC
>>>>
>>>> Is still not clear enough, it would be a good idea to use:
>>>> DEVSTAT_BOOT_MODE_MMCSD
>>>> DEVSTAT_BOOT_MODE_EMMC
>>>>
>>>> Its only a real problem for MMC since we have the confusion with eMMC
>>>> boot and MMCSD boot and we mix the two as a result in
>>>> spl_mmc_boot_mode() and spl_boot_device().
>>>>
>>>>
>>>> Its not really an issue for other boot modes to warrant renaming all the
>>>> bootmodes, but I would like to make these macros as clear as possible in
>>>> this series since I plan to refactor spl_mmc_boot_mode() next.
>>>>
>>>> So lets hear if any one else has a strong opinion on this before
>>>> deciding on:
>>>>
>>>> DEVSTAT_BOOT_MODE_MMCSD
>>>> DEVSTAT_BOOT_MODE_EMMC
>>>
>>> This looks like the correct way to label these as they are the content
>>> of the DEVSTAT register, this would also keep them from being confused
>>> with the U-Boot internal definitions for BOOT_MODE_* and BOOT_DEVICE_*.
>>>
>>> But you should do it for all the DEVSTAT register defines, not just
>>> MMC and not just for Sitara, do it for all our K3 boards. It should
>>> be a simple rename patch to start. Then you can work to detangle
>>> "mode" from "device" for the MMC case as you are doing here.
>>
>> I take it back, seems like this cannot be done, u-boot source requires
>> all the macros:
>> BOOT_DEVICE_SPI
>> BOOT_DEVICE_RAM
>> BOOT_DEVICE_UART
>> etc...
>>
>> in order to even build.
>>
>> Simply renaming the macros to style:
>> DEVSTAT_BOOT_MODE_SPI
>> DEVSTAT_BOOT_MODE_RAM
>> DEVSTAT_BOOT_MODE_UART
>>
>> will not work without creating a duplicate:
>> #define BOOT_DEVICE_SPI		DEVSTAT_BOOT_MODE_SPI
>> #define BOOT_DEVICE_RAM		DEVSTAT_BOOT_MODE_RAM
>> #define BOOT_DEVICE_UART	DEVSTAT_BOOT_MODE_UART
>> or similar logic
>>
>> So basically we would be doubling the size of all spl.h files.
>>
>> In reality there is only confusion with MMC device/bootmodes,
>> we do not to rename every single boot modes/boot device since
>> there is no real confusion there.
>>
> 
> Correct me if I'm wrong here but BOOT_DEVICE_* should only be used
> within the common u-boot source. Our job is to just the return the
> correct macro from the SoC's boot.c file and ensure they are all unique
> values.
> 
> If that's true, can we make use of BOOT_DEVICE_* defines from
> arch/arm/include/asm/spl.h?
> 
> That should avoid duplication since we would just rename the existing
> BOOT_DEVICE_* macros to DEVSTAT_BOOT_MODE_* in our board's spl.h while
> relying on BOOT_DEVICE_* from arm's spl.h.

Then we come back in a circle to the first real problem which is
untangling MMC bootmodes from MMC boot devices.

Why are we trying to refactor all the MMC_DEVICE_* ? There is no
real problem for those bootmodes / boot devices since boot device =
boot mode for those. It is only a real problem for MMC since boot device
DOES NOT equal boot mode for MMC.

~ Judith


