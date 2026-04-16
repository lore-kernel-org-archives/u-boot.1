Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107A7F433C7
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 04:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6589184105;
	Thu, 16 Apr 2026 06:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="km4yeK0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E925841C2; Thu, 16 Apr 2026 06:22:39 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9CD883B99
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 06:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHFH1/mHGvtIVosHLehUFqeCMT9wJkJ/xpcdvx7EBVxyoH0YBuGe9jCJPMSRDN5pkQzSsv6RNAHGLHDV71Vm6mJ3UkbcgymlJjLPqV9WhnBPcbYBzrKIQpcQlEQEFx6/BG6vmu1N3juy/dKhlGzqI007SdSDN982oDWCegzEEfel3tf9914tmNcuiWUuglLsLx9HCaG6rMQMJcG6nkK1npnn0GRrFmOjC8zoIPU9eEKlVzTY3cgoiZIZq5m5zq0iK72h5yS3OTFFczafoMeW+Ph8JTaN75ax2nGkH5JiJnBekbIDc6OsLZhyeTkstkz8IHrbdGg9NHqSvfLmxuIMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hicBmxljHwHa9IbN/FkRK6Hze7fRgWBgLQKgi0T4a04=;
 b=N8Z38v/XxEaIAFyjH2KeagS4D6tyDIZeBbWqKCfAfYQbL5PHpCkgKM/GnyO5zVWIqLPO3/UGtmhtLVXVmzA2OXq1LpdkT67S9PPJRMCDzgVJMrHR1AY8yKZfJHDOfWo7rzqha6KsFp8XFw248j5HFVZwu715q46eOZkb0Ez25pFMvcFfVfdrmiA5X2cdbS6UUDtBpkftxcuDPRxTOIYrONL6L1Sq66Iujk5JIenvA7vgHXNSJdvMTcm/ttTBRWpCe4cEw4PpE2T3SH7pOEVMwjptZbUJaiXwOu45I0300o3Y3lafM1u5N3F3eN22D3P3EIzMttFXVgL9nNKmsWR7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hicBmxljHwHa9IbN/FkRK6Hze7fRgWBgLQKgi0T4a04=;
 b=km4yeK0ydBl3QAfxCt9NrOvNxsEGM69YpBdxwZBpx7maNeNlVI6l17kPKib4jojUrY4F5ETkZm5LL+f8K1HaOcMpNdrPUykdAjBfSFfKYunqJK9TpRu4oJuQS9VDtvT2YhBI99Al/WnkBETzRDHxhjjcQnEf4cggmHfd0VSzMCyCK2cetfCHMkscAIkxC+WO0b//63bK/R8ySSbbMKM4OLkkYBNpwlZHfkDLlmR25M4RJUy7zhbxTqDx/vL9sH1ztY+VhXaovbr+smKvh3gkmtagqhp3CWklVcotX6s+Gh3nYcrrs08XywyM/L5QWyck6DfYeRpXuNl85D7VSnCa4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH7PR03MB7812.namprd03.prod.outlook.com (2603:10b6:610:24e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 04:22:31 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 04:22:31 +0000
Message-ID: <4cf5a8e9-3d6f-4f35-bca0-e6260e226bd8@altera.com>
Date: Thu, 16 Apr 2026 12:22:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: watchdog: Enhance watchdog support in SPL for N5X
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260304040843.11298-1-dinesh.maniyam@altera.com>
 <16a14964-a42c-4506-b09b-c403a32b9afc@altera.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <16a14964-a42c-4506-b09b-c403a32b9afc@altera.com>
X-ClientProxiedBy: SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CH7PR03MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: efa7f3bb-5f7d-4829-88ed-08de9b6fc6f7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|55112099003|8096899003;
X-Microsoft-Antispam-Message-Info: 7P6QxgVzhBUF2q3ZGdrhu9R7e1bTCDQhUOrv1HZbizC7j45kotoL42W1mW29a1AkiqtPX8szud6Atx7SyROIlkq8AKVc3ikUdaPvgqQ/JJjbnfkTNijoT1yuVmg0HHo2OuFb7EC+HBcDY9tcYakWTAAGz2hlNR53vekDr26FUv1KbAKKZNv4SVGCmDORYLM9fTCgvOBPeMcMCtpRIf0hzi+X9iQBUZgfBgWvQeB6/QpAZCIA0UVhzpixvnYgCGDVwYukaVPND9ZE7nuHvFoInD7vkVtqejVya7E++PUDHXszLGTVTxZ90Rv96kRw83fDD6GUgFnaAgfWsy2ur1xtmqVQtJo7SVemDz7li4Uu5B3n/nkkYIoEHImFeOlAIiUQNJdfr3MjWDDqiG1qpfGxkMxT1+LIeFDNpKgWE4uXyVzO7DsWBasAJR3Afvi1kYIxgpCGkcGNZQ3woRzAoWMesG2P9IUWsQam/iOo/zqZhB4/5bLvqW+sUHf4G1k5qUl7MuBFQdAtZOsUO8hTNclaZFDXWqv7zTFoitgfcMI3gIYztMfkywy2kET13rfhmr64icELJw5F4ir0GQUi+611oabCfno9C+lryNYtsqxPAyQEVIuS1eU94UmPA0wqMuh7n+p9tZ/JGJK75cVqNjcerROBVoun0nfHzXlqLX84n69u52RmX6uQE+NrZuJ5pfhWY/ZpNTu6v0sK4IoQCpowS7ZBkVliadNAt8DoIgZrcV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(55112099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFg2SUJuTVYwR1VyMXlGTzFsd3JaZjVZcnJncitIa0pnMWt2a1hUQjQraUgx?=
 =?utf-8?B?VFRwZFFOUFZaVUFxSnQ4TXZGZmlHQ2toR2x3YTZCYzJNQ0N1Q2xVL1lpUzBS?=
 =?utf-8?B?cWQ0aVhZU2tNWmdiTUc0c1A3UlJyZzVKVjkwRkRUL3hJNWVkSXhwbExDL2kx?=
 =?utf-8?B?UXB6Rk9vRzNkUUJjN2ptOGpPQmJYT2tEMnBzVTd5anhNR0NmdzJVK3JQelR6?=
 =?utf-8?B?VU1MaE95VnFmWDBCaytrZUpLc0hZQkIrWE80QXNiOU1Bam1jU3Z4ek1oekNy?=
 =?utf-8?B?OFFQczZpSkpSK1Bpb0tLUTBiOUg3REkxNGVQSk9yeFhMNGdwTWRZaWkxajNN?=
 =?utf-8?B?TkFuVU1WbXZMTWkvazAyTkhEb3p1QXgvSGJqd25CMGZ1aTRxRllIK3R5ejV1?=
 =?utf-8?B?YWoxMDIvVEtvdmJXTTZTVjdKNW1NOE1MeGVkemdCSHBIYnVOUUU4OGFLRXF4?=
 =?utf-8?B?S2xpSVpFL3B4dW16TmRQN01QVjY5T0lvVlk2Ykl0eTJycldKdy9RYnZVOFo1?=
 =?utf-8?B?c1docGNQa01YbndEMVA3Nk9XVitRWm9BbkFXRERoZDJnT3NJQlhydVB0Q1kr?=
 =?utf-8?B?VlA5c3BONnhRSEJVNzh2TUtWQTJMNHJZSDFyWnlwYmYzUlkxN2VxVno0dXEw?=
 =?utf-8?B?ZTJ3SXh4MklITU9ma1ZqQmxocXdKZ21XZkVwU3NxUWFLbmF1OTR1SGlZdFhj?=
 =?utf-8?B?SjRJWENUMDB2eEIzaC9KMnhIWStFd0tOVFc5TUpNekpQbGZvU3hKTGRQY3lZ?=
 =?utf-8?B?WEMxNWU2a2ZIaXpvU2RrNU5MSG5qZ05STW90eHBKODV3aFlNNWNGbzNOSFdE?=
 =?utf-8?B?aFRWTUJ6d2hTQnlNcTZHTGEyV0NVYnQ1LzFYd1dtWXpVM3VseEpHN0xrMmFu?=
 =?utf-8?B?N3NsaGswc2Y2em1XTGdjekI0c3dubDl4RGJHSWU5U1BtQXZOZjJLY1JWZ0Fk?=
 =?utf-8?B?bW9kUm5rMEhaYlFxUk9YbGF6dVdzNTNycmRnRFpEZERwNWVTdlMwM3NsWEE4?=
 =?utf-8?B?M3RXVXB3YTNDbWhFdC93Z3JHNGg5cFNPdXgvaStwUmpEYkQ0T0JhaG1jODZm?=
 =?utf-8?B?MHFYaE9WbDZMZlVLZm9lWjRPOVhwbDVJSHZtaHp1WkljTlBldTVtdnJnK0c3?=
 =?utf-8?B?UE5lLzBjRHhzWGFjSU1iTVNjRS9LekppL2hrR2Q4MWJyZE0rdjRpTXJzU04x?=
 =?utf-8?B?ZUNiMzh2ZXZCSDJubjArMWh2ZFh4b1V1ZUdmem90c3plc2RzZ2VRZy9PS2R2?=
 =?utf-8?B?L2ZhSVJUMUdaeFdBT0hKRGdxM09aSTVUU2xMejdxbWw1R0FEQXVLZW1FZWpQ?=
 =?utf-8?B?UnRxUW10eklNOGtaNVFVdmFnTHJBZXpTdUM2NjdBSzFadE0ycnAyUFl3QlJ0?=
 =?utf-8?B?czBPZ1pmV29NNDBnUGpBTHd2T1JOOUZMcVlrd3FNU3grS2lVOEVmVW9WcHc1?=
 =?utf-8?B?dm50ZEcxaVJ6WlRweHYzdm9sNkcweGFKS29TbXNveDRtN1d2ZGJ6NEorZ1lB?=
 =?utf-8?B?QzVVLzM1RFlpNU56NTVkMEluam01NTBnWlZ6bEU3ZG9kcGN3OE9oY1NlRkhG?=
 =?utf-8?B?RWx3QUt4MFU2VUtGNzRobzRSNk83OEkxYmdOQlJLcWVvbkFoTXJmaGF1dEJ2?=
 =?utf-8?B?ekNNMm1KOUxET2xORnBnRWVMbmFiaURHdVBqRklMVWRYMUQ5WkM0RFErbnM1?=
 =?utf-8?B?UXZqTlJzRUpZbE5zTlNsKzdiL2V6M2h5RlVvODRQSWJyM1M0czR3MEJ0UitO?=
 =?utf-8?B?L0ZIZVJCNG1yMEF1TERoNjJZTTBrbG9HRTB3dzRJVCtockxnY2k3bzFIUE9T?=
 =?utf-8?B?R1VRV2toZHRSakxvaUx4WjE5bGJrbjN6Y3lOeStjUkJNWWRkcVBXbjZxZWtt?=
 =?utf-8?B?WVRLVGdoU2hKY0pZZTdYUGcrYndwbjMvUzV3ZkdSdDJYM2IyOFZwMFhpN0l0?=
 =?utf-8?B?NmhScUUyb0d3M3F4d0NCa1FwcmV2VitYZEZkOEFzcFNHK0x5RUJqU0RZV0pB?=
 =?utf-8?B?T3ZRcXNHam81K2ZkMjQ4ME1GUEEwNGV1ZDM0QkVQSFdYdWY3ZWttbkNpMVZs?=
 =?utf-8?B?NUNLR3RqSWVKd3RRN1MxUzVnZ1Z5V3JKYlBxRW9PNFZsdVVkQUxwamJublI4?=
 =?utf-8?B?SmJzR1R3cldxa29FTHplT0VsS1FaRElPODl1ZFBkSjhpUmoxajVtLy83bDcz?=
 =?utf-8?B?dyttMzRNR1Z0ZHppY3FtbXlHdmo3eUNneDV1cEVDQ3JYMnNacnRmMEhLbG9C?=
 =?utf-8?B?SXFKc1pCTmJLUjZ3NGRhVkc1NlNvdmdDcjBGbEZEMnRFQXpVdkl3RkZsemRZ?=
 =?utf-8?B?cFV4NjJaV2gxaEt4OWxZZk5JNG15dXFXdUFkT25EWWs3RHZRU0ErZGV6eUxp?=
 =?utf-8?Q?JyQJVOlJubVopmRw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa7f3bb-5f7d-4829-88ed-08de9b6fc6f7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 04:22:31.8148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEuSfoMGtOuXqc+Av6zQA69DOEXNB1CND5EbbqDpHu1a8Jlr/kmnyKdxx4Y0tXVORRnngM6rmZeUZdJn3E85e2UE83CarX6XlqRwG0NuPcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7812
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tien Fong,

On 15/4/2026 5:51 pm, Chee, Tien Fong wrote:
>
> Hi Dinesh,
>
>
> On 4/3/2026 12:08 pm, dinesh.maniyam@altera.com wrote:
>> From: Dinesh Maniyam<dinesh.maniyam@altera.com>
>
>
> commit subject scope mismatch, expect arm: socfpga: spl_n5x: ...
>
>
>> Enable watchdog before initializing other component (example: DDR).
>> Thus, watchdog need to be fully executed in onchip ram.
>
>
> The commit message does not fully describe the actual change which 
> switches from the
>
> legacy CONFIG_HW_WATCHDOG path (hw_watchdog_init()) to
>
> DM watchdog init (initr_watchdog() with CONFIG_IS_ENABLED(WDT)).
>
> Please update the message to clearly state that behavior change and 
> rationale
>
> Wording/grammar Minor wording clean-up would help readability, e.g.:
> “before initializing other components”
> “Watchdog needs to be enabled after the clock driver because it 
> retrieves the watchdog clock frequency.”
>
>
>> Signed-off-by: Dinesh Maniyam<dinesh.maniyam@altera.com>
>> ---
>>   arch/arm/mach-socfpga/spl_n5x.c | 17 ++++++++++-------
>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
>> index 81283ef7162..22c20f89b4b 100644
>> --- a/arch/arm/mach-socfpga/spl_n5x.c
>> +++ b/arch/arm/mach-socfpga/spl_n5x.c
>> @@ -9,6 +9,7 @@
>>   #include <asm/arch/mailbox_s10.h>
>>   #include <asm/arch/misc.h>
>>   #include <asm/arch/reset_manager.h>
>> +#include <asm/arch/smmu_s10.h>
>
>
>  doesn’t appear used by the patch itself
>
>
>>   #include <asm/arch/system_manager.h>
>>   #include <asm/global_data.h>
>>   #include <asm/io.h>
>> @@ -19,6 +20,7 @@
>>   #include <init.h>
>>   #include <spl.h>
>>   #include <watchdog.h>
>> +#include <wdt.h>
>>   
>>   DECLARE_GLOBAL_DATA_PTR;
>>   
>> @@ -37,13 +39,6 @@ void board_init_f(ulong dummy)
>>   	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
>>   	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
>>   
>> -#ifdef CONFIG_HW_WATCHDOG
>> -	/* Enable watchdog before initializing the HW */
>> -	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
>> -	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
>> -	hw_watchdog_init();
>> -#endif
>> -
>>   	/* ensure all processors are not released prior Linux boot */
>>   	writeq(0, CPU_RELEASE_ADDR);
>>   
>> @@ -69,6 +64,14 @@ void board_init_f(ulong dummy)
>>   		hang();
>>   	}
>>   
>> +	/*
>> +	 * Enable watchdog as early as possible before initializing other
>> +	 * component. Watchdog need to be enabled after clock driver because
>> +	 * it will retrieve the clock frequency from clock driver.
>> +	 */
>> +	if (CONFIG_IS_ENABLED(WDT))
>> +		initr_watchdog();
>> +
>>   	print_reset_info();
>>   	cm_print_clock_quick_summary();
>>   
>
> Best regards,
>
> Tien Fong
>

Thanks for the review.

I’ll update the subject to |arm: socfpga: spl_n5x:| and revise the 
commit message to clearly
describe the switch from legacy |CONFIG_HW_WATCHDOG| to DM watchdog 
(|initr_watchdog()|),
including the ordering rationale (after clock init, before DDR, 
SPL/on-chip RAM only).

I’ll also remove the unused |smmu_s10.h| include and do minor wording 
cleanups.

Will resend an updated patch.

Best regards,
Dinesh

