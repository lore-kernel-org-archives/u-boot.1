Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3050CAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 22:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 218C98319C;
	Wed, 17 Sep 2025 00:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y5Hya0Sn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6235583280; Wed, 17 Sep 2025 00:35:39 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C6B8318E
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 00:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GMZXBm1370216;
 Tue, 16 Sep 2025 17:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758062133;
 bh=UrU0ch+rIqNR7yoHYMgVPv5TdmrBdC73o+aDmCzixLs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=y5Hya0SnTN03FtyhdGlWzVvutoopkzCOtsnLTFxNJ9MjeHEvzwBaCDgD9zCIUwq4p
 6BPTl2GMLqd2pJU9tWLqs/QzbWUfRvIM47XJJ3BkW18mWbO58zOG/85tFYcdCWILGs
 JrQpSE4MUy9Q0ZX1GnmRCF0iyr/pRMbWS9ogpe/U=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GMZXW71052674
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 17:35:33 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 17:35:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 17:35:33 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GMZXZF2010137;
 Tue, 16 Sep 2025 17:35:33 -0500
Message-ID: <c9b5d045-e719-40b3-acf4-cf887e0ce51b@ti.com>
Date: Tue, 16 Sep 2025 17:35:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: mach-k3: Fix MMC macros
To: Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>, Tom Rini
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
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <9c1b1344-b6fb-4ad4-aaec-1b187e1cd27d@ti.com>
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

Hi Andrew, Anshul,

On 9/16/25 11:22 AM, Andrew Davis wrote:
> On 9/11/25 9:59 AM, Judith Mendez wrote:
>> Hi Anshul,
>>
>> On 9/11/25 12:11 AM, Anshul Dalal wrote:
>>> On Thu Sep 11, 2025 at 3:15 AM IST, Judith Mendez wrote:
>>>> For all K3 SoC's eMMC boot and MMCSD boot modes are supported. The 
>>>> macros
>>>> however, mix MMC device with the two bootmodes. Decouple the two types
>>>> of macros so that bootmodes can be identified with:
>>>> - BOOT_DEVICE_MMCSD
>>>> - BOOT_DEVICE_EMMC
>>>> according to devstat parsed boot mode values and on-board devices 
>>>> can be
>>>> identified with:
>>>> - BOOT_DEVICE_MMC1
>>>> - BOOT_DEVICE_MMC2
>>>> - BOOT_DEVICE_MMC2_2
>>>> according to arbitrary numbers mainly used to differentiate between 
>>>> eMMC
>>>> and SD card.
>>>>
>>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>>> ---
>>>
>>> I guess the confusion here is how we are calling boot modes from devstat
>>> as well as the boot device as BOOT_DEVICE_*. Perhaps we should rename
>>> the former to DEVSTAT_BOOT_MODE_* or something along those lines.
>>>
>>> That would make the difference between a boot *mode* and a boot *device*
>>> more clear, DEVSTAT_BOOT_MODE_MMCSD or DEVSTATE_BOOT_MODE_EMMC would
>>> distinguish between SD or EMMC boot modes with BOOT_DEVICE_MMC*
>>> indicating the MMC port used.
>>>
>>> This would also allow use to only have the respective
>>> DEVSTAT_BOOT_MODE_* defined in each soc's headers with BOOT_DEVICE_*
>>> coming from arch/arm/include/asm/spl.h.
>>
>>
>> Right, I guess if
>>
>> BOOT_DEVICE_MMCSD
>> BOOT_DEVICE_EMMC
>>
>> Is still not clear enough, it would be a good idea to use:
>> DEVSTAT_BOOT_MODE_MMCSD
>> DEVSTAT_BOOT_MODE_EMMC
>>
>> Its only a real problem for MMC since we have the confusion with eMMC
>> boot and MMCSD boot and we mix the two as a result in
>> spl_mmc_boot_mode() and spl_boot_device().
>>
>>
>> Its not really an issue for other boot modes to warrant renaming all the
>> bootmodes, but I would like to make these macros as clear as possible in
>> this series since I plan to refactor spl_mmc_boot_mode() next.
>>
>> So lets hear if any one else has a strong opinion on this before
>> deciding on:
>>
>> DEVSTAT_BOOT_MODE_MMCSD
>> DEVSTAT_BOOT_MODE_EMMC
> 
> This looks like the correct way to label these as they are the content
> of the DEVSTAT register, this would also keep them from being confused
> with the U-Boot internal definitions for BOOT_MODE_* and BOOT_DEVICE_*.
> 
> But you should do it for all the DEVSTAT register defines, not just
> MMC and not just for Sitara, do it for all our K3 boards. It should
> be a simple rename patch to start. Then you can work to detangle
> "mode" from "device" for the MMC case as you are doing here.

I take it back, seems like this cannot be done, u-boot source requires
all the macros:
BOOT_DEVICE_SPI
BOOT_DEVICE_RAM
BOOT_DEVICE_UART
etc...

in order to even build.

Simply renaming the macros to style:
DEVSTAT_BOOT_MODE_SPI
DEVSTAT_BOOT_MODE_RAM
DEVSTAT_BOOT_MODE_UART

will not work without creating a duplicate:
#define BOOT_DEVICE_SPI		DEVSTAT_BOOT_MODE_SPI
#define BOOT_DEVICE_RAM		DEVSTAT_BOOT_MODE_RAM
#define BOOT_DEVICE_UART	DEVSTAT_BOOT_MODE_UART
or similar logic

So basically we would be doubling the size of all spl.h files.

In reality there is only confusion with MMC device/bootmodes,
we do not to rename every single boot modes/boot device since
there is no real confusion there.

~ Judith


-
