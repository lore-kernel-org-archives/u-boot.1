Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7332CAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 16:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DF28309A;
	Tue, 16 Sep 2025 18:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wI4sIkod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF488318E; Tue, 16 Sep 2025 18:22:56 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B34A481E13
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 18:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GGMqQ3053220;
 Tue, 16 Sep 2025 11:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758039773;
 bh=Ql5vwZ2gUt999QYbZp52S1GhTTxaNKz+L6Gil4f3hPE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wI4sIkod3LAsJLHggn7eTVY1q70w1XdSg9dSJw6yNjozKoFuWFQtqcqLh2dC7UaIZ
 1+rdfWDonlqf6l67zu6y8xBME/4eudunv8cyoPRSXm0wNKdKW+H9BpFGR5bN0O5BiL
 jT570zN4cGWJcR+e/9J3aEpLZ9+TrbOMxWDrNf84=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GGMq9f853160
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 11:22:52 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 11:22:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 11:22:52 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GGMp091888531;
 Tue, 16 Sep 2025 11:22:51 -0500
Message-ID: <9c1b1344-b6fb-4ad4-aaec-1b187e1cd27d@ti.com>
Date: Tue, 16 Sep 2025 11:22:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: mach-k3: Fix MMC macros
To: Judith Mendez <jm@ti.com>, Anshul Dalal <anshuld@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Vaishnav Achath" <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, "Moteen Shah" <m-shah@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250910214514.1848847-1-jm@ti.com>
 <20250910214514.1848847-2-jm@ti.com> <DCPPO8O0GIVD.1CWNDWAKDGVEC@ti.com>
 <b61c7f41-6e1d-4d90-a8b8-e446bc32e3a6@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <b61c7f41-6e1d-4d90-a8b8-e446bc32e3a6@ti.com>
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

On 9/11/25 9:59 AM, Judith Mendez wrote:
> Hi Anshul,
> 
> On 9/11/25 12:11 AM, Anshul Dalal wrote:
>> On Thu Sep 11, 2025 at 3:15 AM IST, Judith Mendez wrote:
>>> For all K3 SoC's eMMC boot and MMCSD boot modes are supported. The macros
>>> however, mix MMC device with the two bootmodes. Decouple the two types
>>> of macros so that bootmodes can be identified with:
>>> - BOOT_DEVICE_MMCSD
>>> - BOOT_DEVICE_EMMC
>>> according to devstat parsed boot mode values and on-board devices can be
>>> identified with:
>>> - BOOT_DEVICE_MMC1
>>> - BOOT_DEVICE_MMC2
>>> - BOOT_DEVICE_MMC2_2
>>> according to arbitrary numbers mainly used to differentiate between eMMC
>>> and SD card.
>>>
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> ---
>>
>> I guess the confusion here is how we are calling boot modes from devstat
>> as well as the boot device as BOOT_DEVICE_*. Perhaps we should rename
>> the former to DEVSTAT_BOOT_MODE_* or something along those lines.
>>
>> That would make the difference between a boot *mode* and a boot *device*
>> more clear, DEVSTAT_BOOT_MODE_MMCSD or DEVSTATE_BOOT_MODE_EMMC would
>> distinguish between SD or EMMC boot modes with BOOT_DEVICE_MMC*
>> indicating the MMC port used.
>>
>> This would also allow use to only have the respective
>> DEVSTAT_BOOT_MODE_* defined in each soc's headers with BOOT_DEVICE_*
>> coming from arch/arm/include/asm/spl.h.
> 
> 
> Right, I guess if
> 
> BOOT_DEVICE_MMCSD
> BOOT_DEVICE_EMMC
> 
> Is still not clear enough, it would be a good idea to use:
> DEVSTAT_BOOT_MODE_MMCSD
> DEVSTAT_BOOT_MODE_EMMC
> 
> Its only a real problem for MMC since we have the confusion with eMMC
> boot and MMCSD boot and we mix the two as a result in
> spl_mmc_boot_mode() and spl_boot_device().
> 
> 
> Its not really an issue for other boot modes to warrant renaming all the
> bootmodes, but I would like to make these macros as clear as possible in
> this series since I plan to refactor spl_mmc_boot_mode() next.
> 
> So lets hear if any one else has a strong opinion on this before
> deciding on:
> 
> DEVSTAT_BOOT_MODE_MMCSD
> DEVSTAT_BOOT_MODE_EMMC

This looks like the correct way to label these as they are the content
of the DEVSTAT register, this would also keep them from being confused
with the U-Boot internal definitions for BOOT_MODE_* and BOOT_DEVICE_*.

But you should do it for all the DEVSTAT register defines, not just
MMC and not just for Sitara, do it for all our K3 boards. It should
be a simple rename patch to start. Then you can work to detangle
"mode" from "device" for the MMC case as you are doing here.

Andrew

> 
> ~ Judith
> ...
> 

