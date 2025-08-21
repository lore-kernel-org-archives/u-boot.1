Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEB5CA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 18:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40C6580422;
	Thu, 21 Aug 2025 20:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CQnwON01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3375D81D5D; Thu, 21 Aug 2025 20:51:23 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58BD78004F
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 20:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57LIpGAp073966;
 Thu, 21 Aug 2025 13:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755802276;
 bh=NPLUjgsJszAEc281B4NZv/oTpJY2R69+d7inMWpms00=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CQnwON01dKM7uXfLgbqcm76VpO8spIemNX2HDWw/paZDzmDQPEsXCMYcX24U5NRiA
 cErl278crlU6oe/Y3TA5H80wN5puM6FaOozoGMwnNdDLzT6Fbx3HJSORAUdPVlndrc
 xZK/cd3N1EDk/wpRP+yg6xvJ1w2C8METdGf+foFQ=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57LIpGJT2724892
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 21 Aug 2025 13:51:16 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 21
 Aug 2025 13:51:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 21 Aug 2025 13:51:15 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57LIpFLb2315053;
 Thu, 21 Aug 2025 13:51:15 -0500
Message-ID: <4d04d2cb-dda0-4bef-805e-191cdc037dbb@ti.com>
Date: Thu, 21 Aug 2025 13:51:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-k3: am62*: am62*_init: Prohibit boot from UDA w/
 eMMC boot
To: Nishanth Menon <nm@ti.com>, Judith Mendez <jm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, Bryan
 Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Michael
 Trimarchi <michael@amarulasolutions.com>, <u-boot@lists.denx.de>
References: <20250710171135.669838-1-jm@ti.com>
 <20250821183012.ps6ygzebsxoi2hoj@dolphin>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250821183012.ps6ygzebsxoi2hoj@dolphin>
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

On 8/21/25 1:30 PM, Nishanth Menon wrote:
> On 12:11-20250710, Judith Mendez wrote:
>> This removes support from booting from UDA when in eMMC boot.
>>
>> When user selects eMMC boot [0], that is, boot from eMMC boot0 or
>> boot1 HW partitions, we should not boot from eMMC UDA. The current
>> logic confuses the end user and mixes two different boot modes.
> 
> Wrong! what ROM uses to boot has no bearing as to what bootloader needs
> to do for rest of the system.
> 

Yes it does, this is how *every* single other boot mode works. We pick
the next stage from the same media we booted this stage from. If I OSPI
boot SPL, it will look for U-Boot on OSPI, UART, DFU, NET, etc..

eMMC boot0 is the *only* exception to this rule. We pivot from boot0 to UDA.

> https://docs.u-boot.org/en/latest/board/beagle/am62x_beagleplay.html#flash-to-emmc
> 
> There is a reason we chose this flow in BeaglePlay and other Beagle
> platforms - U-boot and other components keep growing and our emmc's boot
> partition is too small to handle things.
> 

eMMC's boot partition are 4-8MB, more than enough for tiboot3.bin, tispl.bin
and u-boot.img. Sure it is not big enough to handle the next stages like Kernel,
but that is now located on a different rootfs partition anyway, even for regular
SD card booting.

> 
> NAK if you are trying to bring the old problems we solved back.

You did not solve it, you hacked it for your specific Beagle use-case.
Now if someone instead wants to boot all stages from Boot0 they have no
good option for that. It will switch to UDA after R5 SPL if they like it
or not. The only way to stop it would be to enable "SUPPORT_EMMC_BOOT"
config (confusing why that changes the boot flow), or disable SPL_FS_*
configs (again confusing why filesystem support changes boot media flow).

Plan is to add a clean and explicit config option that signals the
boot0 -> UDA pivot should happen. Since you want your Beagle's to do
that, the option will be enabled for you. For those who want to stick
to all boot stages on boot0, then they disable the option. Simple :)

Judith is working on that now for v2.

Andrew

>>
>> The logic was added for AM62A/AM62P with commit: 3b7893145e36, but
>> this is not a clean solution and fix will come later for falcon boot.
>>
>> Logic was also added for AM62X with commit: 664593464634, but this
>> logic is incorrect according to TRM [0] under Primary Boot Mode Selection
>> for 'eMMC Boot'.
>>
>> Fixes: 3b7893145e36 ("mach-k3: add eMMC FS boot support for am62[ap]")
>> Fixes: 664593464634 ("arm: mach-k3: am625: Relax emmc boot condition")
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   arch/arm/mach-k3/am62ax/am62a7_init.c | 4 ----
>>   arch/arm/mach-k3/am62px/am62p5_init.c | 4 ----
>>   arch/arm/mach-k3/am62x/am625_init.c   | 4 ----
>>   3 files changed, 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
>> index edd43a1d78d..1d8644bd073 100644
>> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
>> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
>> @@ -217,10 +217,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>>   
>>   	switch (bootmode) {
>>   	case BOOT_DEVICE_EMMC:
>> -		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
>> -			return MMCSD_MODE_EMMCBOOT;
>> -		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
>> -			return MMCSD_MODE_FS;
>>   		return MMCSD_MODE_EMMCBOOT;
>>   	case BOOT_DEVICE_MMC:
>>   		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
>> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
>> index 6e3c66e5107..01e47deca94 100644
>> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
>> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
>> @@ -262,10 +262,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>>   
>>   	switch (bootmode) {
>>   	case BOOT_DEVICE_EMMC:
>> -		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
>> -			return MMCSD_MODE_EMMCBOOT;
>> -		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
>> -			return MMCSD_MODE_FS;
>>   		return MMCSD_MODE_EMMCBOOT;
>>   	case BOOT_DEVICE_MMC:
>>   		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
>> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
>> index a422919fab1..eb7e245843c 100644
>> --- a/arch/arm/mach-k3/am62x/am625_init.c
>> +++ b/arch/arm/mach-k3/am62x/am625_init.c
>> @@ -316,10 +316,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>>   
>>   	switch (bootmode) {
>>   	case BOOT_DEVICE_EMMC:
>> -		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
>> -			return MMCSD_MODE_EMMCBOOT;
>> -		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
>> -			return MMCSD_MODE_FS;
>>   		return MMCSD_MODE_EMMCBOOT;
>>   	case BOOT_DEVICE_MMC:
>>   		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
>> -- 
>> 2.49.0
>>
> 

