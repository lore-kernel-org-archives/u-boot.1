Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B14CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 18:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A7981E13;
	Wed, 20 Aug 2025 20:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ja2CfPXR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 298BB801DD; Wed, 20 Aug 2025 20:17:24 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A9A782E67
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 20:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57KIHH8R3255309;
 Wed, 20 Aug 2025 13:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755713837;
 bh=AJ2keQZzSGb8rL3ysdZ2kD1pqCFcwn7eBq0jC6BV+Nc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ja2CfPXR9T4vJLLubs43/pWbsMmp4UzogmqRSdH6VEjXdWBRRfvnN/6ZjOzSUd+fb
 vKRgYT4Xjui6par9B8Z0jwPQx46+Dq7Sz6vRSq792Ig+n+IOhCfYr4xsZlNnrd9W+E
 IlzD44lQfm53P/g01WE8nlavshZBPNzPGBSVOu/E=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57KIHHTC1967631
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 20 Aug 2025 13:17:17 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 13:17:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 13:17:17 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57KIHHQl631085;
 Wed, 20 Aug 2025 13:17:17 -0500
Message-ID: <03057904-77c8-4fcf-b096-46636f819922@ti.com>
Date: Wed, 20 Aug 2025 13:17:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-k3: am62*: Fix backup from eMMC boot mode
To: Anshul Dalal <anshuld@ti.com>, Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>
References: <20250818174015.2879675-1-jm@ti.com>
 <DC6YFT34VBJE.1U87BHIUTR8OE@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <DC6YFT34VBJE.1U87BHIUTR8OE@ti.com>
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

On 8/19/25 11:02 PM, Anshul Dalal wrote:
> Hi Judith,
> 
> On Mon Aug 18, 2025 at 11:10 PM IST, Judith Mendez wrote:
>> Currently logic in spl_mmc_boot_mode only lookes at main devstat
> 
> Nit: s/lookes/looks
> 
>> to determine the bootmode to return. Thus, when using: 'eMMC boot'
>> as primary boot mode and 'MMCSD boot from eMMC UDA' as backup
>> boot mode, 'eMMC boot' is always selected. Add check for bootindex
>> to determine if ROM boot via backup boot mode and return MMCSD_MODE_FS
>> which is the only supported backup bootmode with eMMC device.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   arch/arm/mach-k3/am62ax/am62a7_init.c | 22 +++++++++++++---------
>>   arch/arm/mach-k3/am62px/am62p5_init.c | 24 ++++++++++++++----------
>>   arch/arm/mach-k3/am62x/am625_init.c   | 22 +++++++++++++---------
>>   3 files changed, 40 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
>> index 00173e6836b..fa3570d07ec 100644
>> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
>> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
>> @@ -218,17 +218,21 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>>   	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
>>   			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
>>   
>> -	switch (bootmode) {
>> -	case BOOT_DEVICE_EMMC:
>> -		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
>> +	if (bootindex == K3_PRIMARY_BOOTMODE) {
>> +		switch (bootmode) {
>> +		case BOOT_DEVICE_EMMC:
>> +			if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
>> +				return MMCSD_MODE_EMMCBOOT;
>> +			if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
>> +				return MMCSD_MODE_FS;
>>   			return MMCSD_MODE_EMMCBOOT;
>> -		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
>> +		case BOOT_DEVICE_MMC:
>> +			if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
>> +				return MMCSD_MODE_RAW;
>> +		default:
>>   			return MMCSD_MODE_FS;
>> -		return MMCSD_MODE_EMMCBOOT;
>> -	case BOOT_DEVICE_MMC:
>> -		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
>> -			return MMCSD_MODE_RAW;
>> -	default:
>> +		}
>> +	} else {
>>   		return MMCSD_MODE_FS;
>>   	}
>>   }
> 
> [snip]
> 
> Just having a check for bootindex before the switch block would be more
> readable imo, like:
> 
> if (bootindex != K3_PRIMARY_BOOTMODE)
> 	return MMCSD_MODE_FS;
> 
> switch (bootmode) {
> 	<Existing code>
> }
> 

Actually, I like that, thanks, will fix for v2.

~ Judith

