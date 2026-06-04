Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B6ECD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 04:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 577F3848DF;
	Thu,  4 Jun 2026 06:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nLaCODC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C307C8467E; Thu,  4 Jun 2026 06:21:30 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B718467E
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 06:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nc6f/xGDiwEwgpsitNHMcy0qxu1mRYY1QPGlihzuvFVI3pqzcMutqZzhg3L2prqgjWUAayyvAuN2Xj3CzmxDEp9c7EGufQfeY/GcOP4yqnvGj3110tf/610WzT0y3cy1f8IwClJ4Q9f4Wu10JnT2skxKFzC5czeR0uzveO1PLhKRo+uWUJb1KSzvEbAdFNd1bCy/Q/6e5YOuZHuFvWnSQkPksYSBQd7D2O+7R1B658qwvV7c8pHTR6iahAT29bCnQPPP2ZWxK0/Mzo0E9tnWtyTtiH1/KVQnSCoyKLOYHQw74vLL+DhitjFSjs4arn5HdfsB+ikr5S4Vjib8iBspnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvJVbZ3sMcYxHSgEizHkQEk3uDh/4RB3yxU4ntFuMOM=;
 b=OoRswJ+kqn60VSkkS3Wo8W3Pk4drLvw4VIawhbNSSNjBYopW8CQ21CFb1bed60x9UCIfPHQidc9Gfa/sHFFgo4Qv5/6//7FVDWl6kneAHAR7e+UiWX41GcifwBrByf1JJ+HYxPvE8nUUi62A0Xc1NK+m3zkxxuwPl1MsXEmpkwcLTDGZxoHdzGUtbKkb3TWzhYfp37XefSw7m7yxBHWXPFZpSgJJ9fDbEn8+QOxWbSXjgsdNb5DYUQp35Lx7pbyymmSUBlG5e3lbnXpGppZ0k2uaw8LZreItoqqog2ruYg3bn4PfbxO5gSVBy8BoJrtI4bZPWhF6flAdPlGkqB5rXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvJVbZ3sMcYxHSgEizHkQEk3uDh/4RB3yxU4ntFuMOM=;
 b=nLaCODC7zsc+1VAnfktYt0+P3dSu63XOgHFrcYWudZ/mz1OkDMyYoPEQrDvLumGV5eIktYEkp/rcsl1uXqUQ2bZ6lJX30R2omWoqJHtNA6R1JSEQjA956QMY9TJjSTDg3dZlIOXrt0kSjoYgocz9hPSwpV7T3rpF4KvaUl6LUxIV+LmjV1AAF1AGmJpAQUURD58IeeU4g4VfVFygFFOCb+cA414h1NhrGi8swwTj6aCHvLnOLpcw2LBsVMW8BFL4n4zd+SDfu6K4PtygYtsB00YPWz0YZSUMCOk82IWyPRK3NMXZORkRCwfNxeUTkxWk7K4+Ed7lAjMdwL+asq6kqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by PH0PR03MB989257.namprd03.prod.outlook.com (2603:10b6:510:3bc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 04:21:26 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 04:21:26 +0000
Message-ID: <b159213d-fd7a-438d-b122-a18a3c63878a@altera.com>
Date: Thu, 4 Jun 2026 12:21:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] spl: s10: Enhance watchdog support in SPL for
 Stratix 10
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
 <20260518011245.19083-10-alif.zakuan.yuslaimi@altera.com>
 <bb783124-f47c-4b9b-9619-9bf3da99fec9@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <bb783124-f47c-4b9b-9619-9bf3da99fec9@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|PH0PR03MB989257:EE_
X-MS-Office365-Filtering-Correlation-Id: 319dc97a-0918-4083-f573-08dec1f0be48
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|55112099003|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rGHm+mJVE8IW/wvSYHjDIATx/n3oDAXNIZObzc5heSnZoTD4Z2uuSpX0KfMEr6QRJiX5kPfbu4fiYaHy3kPDuNbEGixt0t5e7Zi9qN2NOl1G5vJZX+u7xTAkjOzBRjt/S34ak+I2FciRUh7HPkU/PL9qgvnLptMQi8rKup6y9kE6vZEePinChox7PjhyrDgqtTOSmBs6tyxH0sojuhXMOv35k1fPfqqC02H8wNX5fU3a3NmvvyIix7dlOs+jGuRA0+GpjNb2GXR4uxbbYYIh/qXLDUOfBVnv6cGZgswtr7FCT6SEwcR/uVACPACy6I7+LPE3ZA7kt0u4PkhYUN/vahp2gv3M573vwE9fwyIA7wfhZxkCdnaHiMatVQ96fsk5MCqE6j6lz+cSuUjkaVwu5RCWtInS1ah70YEHuC2xDdu9hE74Lp1KGWiRBjz6H6VLCMSnBVQtjHHM2B4B+h+hNSc9w8PzhM8d+6L0j4QifDPeroaEJ0Vl9cJU4uXey4qVJvJXB818+2Kbw68SjR0RwEFPh6ImCC0mZfAFhsPTLTUXD0qVno9KUfMmQLxQk7CGqmkf2gFpBt1KPLIvYCTlDEmqieNDMY0RBwzSGS99GmVjHH1ee1v7RipYpLCOsvUJ2PT+zTpprjc1MXTTzc8N9suPJLquvH++YGkAD5q++kNjunJOPgDSOqN/ObGF/KIv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(55112099003)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW1pWUFYNGJKNG04WlFnN25VeEdHdmM0enhuZVNNOXBBbDBSTUIrM05YNGZU?=
 =?utf-8?B?eFhNeHNsVXhadXQ1S1FwTUE2Z0NLWnRoTlpVQ2NVVWRKQjM4K0E3QU03UnNi?=
 =?utf-8?B?Rm10YmxGdU9rUzYweFBwMXV6Zmp6VGE5enVRekIrWG5JUFBrbStTalByYTVM?=
 =?utf-8?B?djdIUzl5VmhZRFl4QUt6VWRMcHFpQnRLYmRPSUVWaU5DSXdDVTV6R3RtUkcv?=
 =?utf-8?B?Q29BRmxqYjMyZ05YTUpDZHAzSk1KVmpWWTF3c0Y5TG9aK0o5ZzJMSkZ4RG9G?=
 =?utf-8?B?NUcyWUgvT2k5Ym01eFRSaGg3a2lXbXc3WXRLVU0xQ3VHMGxaTTBPRWpkVG11?=
 =?utf-8?B?NlMyVUE0NDlSTitrTit4clloOFdhSk9nb3RvbCtVTm94a0VhcW1XdHpQQTV3?=
 =?utf-8?B?VzFBSzAwamYwQzFGcndNRDBBSldlNlY2OG5aT1VYOTNKYk4wK1Vlc1BVWDdO?=
 =?utf-8?B?MVNmRnBBOG1hOGUzV25nSGlEOUovOGpld1dsQjZ6ZGpxYU4vbHVmQkJWK1or?=
 =?utf-8?B?VnRyZUUwZG1hRVY2VHJGUUpBVDRWRE5BM2YzUVNRaGc5Sm54dlNJRVNuVFdQ?=
 =?utf-8?B?SklySG93cFBhclMyYlEwNHE2amlIbFNYdjBITjh3T2NISHFhS1lYMm10NUU5?=
 =?utf-8?B?anI3VGxsOEVhMlFPWkVTVlk2enFUMS9wRDJIeDd0SHZDcVM3N1kyR3BMTThr?=
 =?utf-8?B?TkpiUFcwWnZqUGw0eS9nRnhQdURVVUxNeXdnSWdjSDc3S2xWckpEMmR3d1hB?=
 =?utf-8?B?Z0xTN0hqYlZFR1dWelh2UmNkNDBlK3BSVXJPSE1VaEl3bnRlZEU5UTFrekFr?=
 =?utf-8?B?bzlIZXo2NTlNU3NoVE1Gcm5MRHcrYmRWaTVkOUprcElXakZvY0cyUll1M3Bs?=
 =?utf-8?B?K1czcmNOTHhuODBNQ3MxVVVSaHdyVG9YNW5RTVMxSUtWK2VKNmd5QXF6WTkz?=
 =?utf-8?B?ZzE0U2Z0OWZhNVVrbU9xdk1GenpKeXgwVTltTDhLZkwvRVMyaHdrTnhYbnVo?=
 =?utf-8?B?R0kxb1ZBMXFVOXlINkFwK0dxOCtab2Rkb05FdlF3b0d3OGpTK0RFdy8zY2pn?=
 =?utf-8?B?cURKbGs0QW9SbXA4dFB3eXh0eWVXZVAxb1c5VlB2cnU5RWtFL3grL1hKRnAx?=
 =?utf-8?B?c2dPQUlBdkg0WDJNcFVObTlZSVliU2U4bnFNQk1vbmZBNUFqeXIybUxxemY4?=
 =?utf-8?B?VGpySGk3dGZySlpVZ01xSkhYRUR4WUVkS1FMQ0VNYjN3VXZGNUFDZTRiSUp3?=
 =?utf-8?B?NDVhQUJpN24rTUwzUG1tMm0ybkZIWlc2MGx2dEpZbnBBNEFRS2pzTlVYMFVZ?=
 =?utf-8?B?V3ZobnFMN1ZScFFQOUJMby94eEIwN0pYcmVCUzZRMHVVaUdWanljZ2F3TGxY?=
 =?utf-8?B?YytWZ3Yra0RqTWdTMWlDQ0tkNEFZMWJJQmFGVnl5MlkydEhGQkdMb3hwcTJ1?=
 =?utf-8?B?Nmd0enN1UFNkUUs5SUg4N0F5YmFrVGZGSVRBUnpVbkVCRUwwa3RLSTlLUTR1?=
 =?utf-8?B?dDduVFNmNFBWWnpFczhEWVNORWtQWGF6ODN6c21oWTE3QUs4Q2dmVXREWWdJ?=
 =?utf-8?B?TGh3QjhwZmQ4UzdyYjQ2SDVMVkRRbzc3UDVTeVJZcnNhMWlMSDBQa25RYmw1?=
 =?utf-8?B?b29xZXRJM2NmaVR3UEI4M0MzeHNJN0hxRGNRTy9rc0lkdEk4NTRhWVFib0hH?=
 =?utf-8?B?b2hxK1dJNjZXNEZyZVhwMTBSbUQySXNsSFFiRVpGZzJrSy9xZU5ZZHFISDU3?=
 =?utf-8?B?WkJJQ1NsWHB1ZUNQVHN2dFVkN1k4eEwyMGlSS1lCZVdVMU9KcFNTb3hoV1FH?=
 =?utf-8?B?VjZ5ak1PVm50OCtXWEpPVkZlekh0L2N3Skk5eU9MZlh1TkdzRElIdEUyNllI?=
 =?utf-8?B?VUFCVFc1WmZHUXBIbzBxbyttaGNIR1RKNmdJM1djMnNVZ3dxcWtKYUFEWERI?=
 =?utf-8?B?WFVyRUxQbW5CRGY5dXgwYTdva0g3SDd3bmo4LytEbGhLYTlkRzV0TEwvZlcv?=
 =?utf-8?B?L1FpL1hLR3JvWjVGQU1uMDNyYy83dmM3c2hydUZ3aU84NFVzNFJvd05kQjVK?=
 =?utf-8?B?NDJ1bXpUb0lrYUpVZUw4QzdoMGhWS1habVRtVFhQcjlaL1RRV3BBR1Z2N0po?=
 =?utf-8?B?YTNjblJDS2wxVDRLWXhYWEVqUzVRb0tmYThzZkJydStGWVo4bVBpTEN2MGhI?=
 =?utf-8?B?dVlyN0RreVRkSnp1clI3OEhMVWpLLzBySjRpSU9kdWZrY2hoSGNrUk15bTdS?=
 =?utf-8?B?Y29ZaHd0UnRjNGYvRTB3TWtKMzNmYUkra0RBbTRBSVMreDBzN3h3Vk90L05V?=
 =?utf-8?B?NmQ0ZkRaWUVwR3NjSVNqeVFqMy9hZkdEQThvdkNGNGsvT1JlNHpwaUJ1bisv?=
 =?utf-8?Q?js/1D6VR4LczvUR9niarRr4gw0Zq0GHDkPKES?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319dc97a-0918-4083-f573-08dec1f0be48
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 04:21:26.3321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6sRcfHy1lWWGLq2J+vp+fbgbsaFtk0f6u/q9cV6SGF4sKE6YkpD8+Fc5uScbp6LnWwuB+j/t0glxej1Qdi2pLzDN3Zc3+XCzQ7RMKRhRK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989257
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

On 3/6/2026 3:45 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 18/5/2026 9:12 am, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Watchdog should be primed before longer, failure-prone steps such as
>> firewall, SDRAM or QSPI initialization so that if a hang occurs in one of
>> those steps, it is able to trigger a reset.
>>
>> Switch from the legacy hw_watchdog_init() path to the driver-model WDT
>> (initr_watchdog()). This requires clocks and reset to be valid for
>> the L4 watchdog block, and so it must run after the clock manager
>> (uclass_get_device(UCLASS_CLK)) succeeds.
>>
>> Enabling watchdog immediately after clock init keeps watchdog coverage as
>> early as possible.
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>
>> (no changes since v2)
>>
>> Changes in v2:
>> - Commit message improvement
>>
>>   arch/arm/mach-socfpga/spl_s10.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/ 
>> spl_s10.c
>> index ace029557f3..588dca4fcd3 100644
>> --- a/arch/arm/mach-socfpga/spl_s10.c
>> +++ b/arch/arm/mach-socfpga/spl_s10.c
>> @@ -18,7 +18,7 @@
>>   #include <asm/arch/misc.h>
>>   #include <asm/arch/reset_manager.h>
>>   #include <asm/arch/system_manager.h>
>> -#include <watchdog.h>
>> +#include <wdt.h>
>>   #include <dm/uclass.h>
>>   u32 reset_flag(void)
>> @@ -54,13 +54,6 @@ void board_init_f(ulong dummy)
>>       writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
>>              socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
>> -#ifdef CONFIG_HW_WATCHDOG
>> -    /* Enable watchdog before initializing the HW */
>> -    socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
>> -    socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
>> -    hw_watchdog_init();
>> -#endif
>> -
>>       /* ensure all processors are not released prior Linux boot */
>>       writeq(0, CPU_RELEASE_ADDR);
>> @@ -80,6 +73,13 @@ void board_init_f(ulong dummy)
>>           hang();
>>       }
>> +    /*
>> +     * Enable watchdog as early as possible before initializing other
>> +     * component.
>> +     */
>> +    if (CONFIG_IS_ENABLED(WDT))
>> +        initr_watchdog();
>> +
>>   #ifdef CONFIG_DEBUG_UART
>>       socfpga_per_reset(SOCFPGA_RESET(UART0), 0);
>>       debug_uart_init();
> 
> 
> DM WDT needs clock/reset; ordering after uclass_get_device(UCLASS_CLK) 
> matches spl_agilex.c and commit message rationale.
> 

I agree, the commit message already describes this implementation -

"This requires clocks and reset to be valid for the L4 watchdog block, 
and so it must run after the clock manager 
(uclass_get_device(UCLASS_CLK)) succeeds."

Regards,

Alif

> 
> Best regards,
> 
> Tien Fong
> 

