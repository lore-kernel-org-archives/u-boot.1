Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844C5E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 20:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8781803CE;
	Fri, 20 Dec 2024 21:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KQkzmYBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338FF803D2; Fri, 20 Dec 2024 21:29:25 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5707803CB
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 21:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BKKTKuQ033199;
 Fri, 20 Dec 2024 14:29:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734726560;
 bh=9lZhX5UO90q4ODqXHDHi1e27pQBWXU9Vrpq6JHSlCSA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KQkzmYBsISEt5J/uUBxV+ME8mYJ3WC7LqJQU04jSXxzM49ocXIZxRJAlL2YRruhf0
 4BzKczH8hPuRQdwYIix4mMjeLBbP/MC7wdOUFitAUHCeBubjpFjRQEp/wAssVGeJQt
 8yND41OyaRQItEKw0C4lyqq7wu3Pp+6RztP+FHDY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BKKTK6p089313
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 20 Dec 2024 14:29:20 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 14:29:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 14:29:20 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BKKTKCN057124;
 Fri, 20 Dec 2024 14:29:20 -0600
Message-ID: <95e2b56d-252e-40c9-ad2a-240df1c7afad@ti.com>
Date: Fri, 20 Dec 2024 14:29:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] mach-k3: am62a7_init: Add FS and raw mode for eMMC
To: Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
References: <20241220192220.2029543-1-jm@ti.com>
 <20241220192220.2029543-2-jm@ti.com>
 <20241220194524.2tv7xm4sdanpmp4h@bryanbrattlof.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20241220194524.2tv7xm4sdanpmp4h@bryanbrattlof.com>
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

Hi Bryan,

On 12/20/24 1:45 PM, Bryan Brattlof wrote:
> Hi Judith!
> 
> On December 20, 2024 thus sayeth Judith Mendez:
>> From: Vignesh Raghavendra <vigneshr@ti.com>
>>
>> This adds FS and raw boot mode support for eMMC similar to other K3
>> platforms
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>   arch/arm/mach-k3/am62ax/am62a7_init.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
> 
> Hmmm Are you on -next? this doesn't seem to apply :/

So sorry (: Will rebase, thanks!

~ Judith

> 
> ~Bryan
> 
>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
>> index 0f62f39075b..abf04970a2b 100644
>> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
>> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
>> @@ -171,6 +171,25 @@ void board_init_f(ulong dummy)
>>   	debug("am62a_init: %s done\n", __func__);
>>   }
>>   
>> +u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>> +{
>> +	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
>> +	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
>> +				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
>> +	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
>> +			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
>> +
>> +	switch (bootmode) {
>> +	case BOOT_DEVICE_EMMC:
>> +		return MMCSD_MODE_EMMCBOOT;
>> +	case BOOT_DEVICE_MMC:
>> +		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
>> +			return MMCSD_MODE_RAW;
>> +	default:
>> +		return MMCSD_MODE_FS;
>> +	}
>> +}
>> +
>>   static u32 __get_backup_bootmedia(u32 devstat)
>>   {
>>   	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
>> -- 
>> 2.47.1
>>

