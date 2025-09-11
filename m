Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2CCCAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 14:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C60833AD;
	Thu, 11 Sep 2025 16:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="en5NcA9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ADD8833C0; Thu, 11 Sep 2025 16:59:19 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C32B48334F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 16:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BExE6B769725;
 Thu, 11 Sep 2025 09:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757602754;
 bh=gWAwCvySlAJkcA6dUcySI9XhWp1/N1vv3CnCL3ae9Ig=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=en5NcA9LGWVzQUs5XWSSdkrtSd7sQSQ7BAeK13KreWCsdYxQTtElu5rgwxKJOTJgg
 qU4sLFdJYs5rQFuXk8ZZiFj+gKoMubiwCfnSDujsdnOTqPgNPE8tOkqE/WpYjwInbs
 zJbtoeyhm2TAw2c4ZNac0heTq7FhCNJFUJWZi8yE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BExDIK1134591
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 09:59:14 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 09:59:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 09:59:13 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BExDYq2293762;
 Thu, 11 Sep 2025 09:59:13 -0500
Message-ID: <b61c7f41-6e1d-4d90-a8b8-e446bc32e3a6@ti.com>
Date: Thu, 11 Sep 2025 09:59:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: mach-k3: Fix MMC macros
To: Anshul Dalal <anshuld@ti.com>, Tom Rini <trini@konsulko.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Vaishnav Achath" <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, "Moteen Shah" <m-shah@ti.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
References: <20250910214514.1848847-1-jm@ti.com>
 <20250910214514.1848847-2-jm@ti.com> <DCPPO8O0GIVD.1CWNDWAKDGVEC@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <DCPPO8O0GIVD.1CWNDWAKDGVEC@ti.com>
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

Hi Anshul,

On 9/11/25 12:11 AM, Anshul Dalal wrote:
> On Thu Sep 11, 2025 at 3:15 AM IST, Judith Mendez wrote:
>> For all K3 SoC's eMMC boot and MMCSD boot modes are supported. The macros
>> however, mix MMC device with the two bootmodes. Decouple the two types
>> of macros so that bootmodes can be identified with:
>> - BOOT_DEVICE_MMCSD
>> - BOOT_DEVICE_EMMC
>> according to devstat parsed boot mode values and on-board devices can be
>> identified with:
>> - BOOT_DEVICE_MMC1
>> - BOOT_DEVICE_MMC2
>> - BOOT_DEVICE_MMC2_2
>> according to arbitrary numbers mainly used to differentiate between eMMC
>> and SD card.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
> 
> I guess the confusion here is how we are calling boot modes from devstat
> as well as the boot device as BOOT_DEVICE_*. Perhaps we should rename
> the former to DEVSTAT_BOOT_MODE_* or something along those lines.
> 
> That would make the difference between a boot *mode* and a boot *device*
> more clear, DEVSTAT_BOOT_MODE_MMCSD or DEVSTATE_BOOT_MODE_EMMC would
> distinguish between SD or EMMC boot modes with BOOT_DEVICE_MMC*
> indicating the MMC port used.
> 
> This would also allow use to only have the respective
> DEVSTAT_BOOT_MODE_* defined in each soc's headers with BOOT_DEVICE_*
> coming from arch/arm/include/asm/spl.h.


Right, I guess if

BOOT_DEVICE_MMCSD
BOOT_DEVICE_EMMC

Is still not clear enough, it would be a good idea to use:
DEVSTAT_BOOT_MODE_MMCSD
DEVSTAT_BOOT_MODE_EMMC

Its only a real problem for MMC since we have the confusion with eMMC
boot and MMCSD boot and we mix the two as a result in
spl_mmc_boot_mode() and spl_boot_device().


Its not really an issue for other boot modes to warrant renaming all the
bootmodes, but I would like to make these macros as clear as possible in
this series since I plan to refactor spl_mmc_boot_mode() next.

So lets hear if any one else has a strong opinion on this before
deciding on:

DEVSTAT_BOOT_MODE_MMCSD
DEVSTAT_BOOT_MODE_EMMC

~ Judith
...

