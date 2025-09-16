Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2DBCAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 12:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABEB8803CC;
	Tue, 16 Sep 2025 14:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aJDoern3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 731608318E; Tue, 16 Sep 2025 09:25:16 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA0A583071
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=v-singh1@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58G7OxCa1315290;
 Tue, 16 Sep 2025 02:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758007499;
 bh=WogfzcEkq13d6ShP5QWnZljzsZM6fM9p3ff9fS6vT3Q=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=aJDoern3xOa+S33RcO7zKI0Qeoffybh0u4Xmblgn8bojD7BGdM22JQ9mImQ1oQx99
 N2R49+uRYmof8brzzH0G/UyOMFvnTTAE9AsSI7PS/bUPChlSawnXrmfRfKM+ZWkpO3
 USaRnSurmIcoZLZQMSo0UkXdYkkb7LAV68EeaUWY=
Received: from DFLE213.ent.ti.com (dfle213.ent.ti.com [10.64.6.71])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58G7Oxfd1347243
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Sep 2025 02:24:59 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Sep
 2025 02:24:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 02:24:59 -0500
Received: from [10.24.69.90] (uda0513920.dhcp.ti.com [10.24.69.90])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58G7OvWG944335;
 Tue, 16 Sep 2025 02:24:58 -0500
Message-ID: <499d9781-5f7e-41ff-96ec-3dc8c0c9820c@ti.com>
Date: Tue, 16 Sep 2025 12:54:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] bootstage: stash boot records to reserved mem before
 kernel handoff
To: Tom Rini <trini@konsulko.com>
CC: <mkorpershoek@kernel.org>, <j@jannau.net>, <u-boot@lists.denx.de>
References: <20250822040523.1803792-1-v-singh1@ti.com>
 <20250822144759.GO124814@bill-the-cat>
Content-Language: en-US
From: Vishnu Singh <v-singh1@ti.com>
In-Reply-To: <20250822144759.GO124814@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Tue, 16 Sep 2025 14:47:22 +0200
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


On 22/08/25 20:17, Tom Rini wrote:
> On Fri, Aug 22, 2025 at 09:35:23AM +0530, vishnu singh wrote:
>
>> From: Vishnu Singh <v-singh1@ti.com>
>>
>> U-Boot now stashes its bootstage buffer into a reserved memory region
>> whenever CONFIG_BOOTSTAGE_STASH is enabled, just before exiting to the
>> kernel. This allows a post boot parser to read a unified timeline
>> (SPL→U-Boot→Kernel→MCU/DSP) directly from DDR, enabling standardized
>> and repeatable boot-time profiling across releases and SoCs.
>>
>> Change summary:
>>   Call bootstage_stash_default() in announce_and_cleanup()
>>    when CONFIG_BOOTSTAGE_STASH is set.
>>
>> Reference boot-time parser utility:
>>   https://github.com/v-singh1/boot-time-parse
>>
>> Sample boot time report:
>>      +--------------------------------------------------------------------+
>>                       am62xx-evm Boot Time Report
>>      +--------------------------------------------------------------------+
>>      Device Power On         : 0 ms
>>      SPL Time                : 843 ms
>>      U-Boot Time             : 2173 ms
>>      Kernel handoff time     : 462 ms
>>      Kernel Time             : 2522 ms
>>      Total Boot Time         : 6000 ms
>>      +--------------------------------------------------------------------+
>>
>>      +--------------------------------------------------------------------+
>>                       Bootloader and Kernel Boot Records
>>      +--------------------------------------------------------------------+
>>      BOOTSTAGE_AWAKE                =      0 ms (+  0 ms)
>>      BOOTSTAGE_START_UBOOT_F        =    843 ms (+  0 ms)
>>      BOOTSTAGE_ACCUM_DM_F           =    843 ms (+  0 ms)
>>      BOOTSTAGE_START_UBOOT_R        =   1951 ms (+1108 ms)
>>      BOOTSTAGE_ACCUM_DM_R           =   1951 ms (+  0 ms)
>>      BOOTSTAGE_NET_ETH_START        =   2032 ms (+ 81 ms)
>>      BOOTSTAGE_NET_ETH_INIT         =   2053 ms (+ 21 ms)
>>      BOOTSTAGE_MAIN_LOOP            =   2055 ms (+  2 ms)
>>      BOOTSTAGE_START_MCU            =   2661 ms (+606 ms)
>>      BOOTSTAGE_BOOTM_START          =   2959 ms (+298 ms)
>>      BOOTSTAGE_RUN_OS               =   3016 ms (+ 57 ms)
>>      BOOTSTAGE_BOOTM_HANDOFF        =   3016 ms (+  0 ms)
>>      BOOTSTAGE_KERNEL_START         =   3478 ms (+462 ms)
>>      BOOTSTAGE_KERNEL_END           =   6000 ms (+2522 ms)
>>      +--------------------------------------------------------------------+
>>
>>      +--------------------------------------------------------------------+
>>                       MCU Boot Records
>>      +--------------------------------------------------------------------+
>>      MCU_AWAKE                      =   2661 ms (+  0 ms)
>>      BOARD_PERIPHERALS_INIT         =   2661 ms (+  0 ms)
>>      MAIN_TASK_CREATE               =   2661 ms (+  0 ms)
>>      FIRST_TASK                     =   2662 ms (+  1 ms)
>>      DRIVERS_OPEN                   =   2662 ms (+  0 ms)
>>      BOARD_DRIVERS_OPEN             =   2662 ms (+  0 ms)
>>      IPC_SYNC_FOR_LINUX             =   6636 ms (+3974 ms)
>>      IPC_REGISTER_CLIENT            =   6636 ms (+  0 ms)
>>      IPC_SUSPEND_TASK               =   6636 ms (+  0 ms)
>>      IPC_RECEIVE_TASK               =   6636 ms (+  0 ms)
>>      IPC_SYNC_ALL                   =   6787 ms (+151 ms)
>>      +--------------------------------------------------------------------+
>>
>> Signed-off-by: Vishnu Singh <v-singh1@ti.com>
> In that it looks like x86 already does a similar thing, this is a good
> idea and I wonder if some tooling already exists to read it.
>
>> ---
>>   arch/arm/lib/bootm.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
>> index 7eb764e1f4e..b01e763ff28 100644
>> --- a/arch/arm/lib/bootm.c
>> +++ b/arch/arm/lib/bootm.c
>> @@ -57,6 +57,9 @@ static void announce_and_cleanup(int fake)
>>   #ifdef CONFIG_BOOTSTAGE_FDT
>>   	bootstage_fdt_add_report();
>>   #endif
>> +	if (IS_ENABLED(CONFIG_BOOTSTAGE_STASH))
>> +		bootstage_stash_default();
> You don't need to guard the call, the default bootstage_stash_default()
> is a return 0 call when CONFIG_BOOTSTAGE_STASH isn't set.
Will update and send the patch
