Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF5EFCE081
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 13:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35D4483EAC;
	Thu, 26 Feb 2026 14:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="d2wSdQYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E478C83C54; Thu, 26 Feb 2026 06:35:09 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E4D683E63
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 06:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3CfqnLY3L9JJqr3pxYKvzK2+R3S6psPm1cE4GsXSADZKcL+R6IbzgxY1NiECbDphrFy1yGBkv/qi2c4iHWV3sP5pYriNjJlZEbSjWw0onIs6YOFg//p1kiBZuGuibPg/NptN6MhqdIxZ4xaNCf/OGCCRjU+Qg3v9YxrpRuZ7EnO8len4WAzxQhSkxM4VonU7IBGCmhkm9ifG8ADwqB+b4dMxksnj/e1xywJf6CnuYYW4wsr0taIXWHG3ni0V7+G3/LaN5+SESjyChehWQlHFnR8rSUPVetMirTWXR1res5RYLrYmHnIIvdNmi514OBxcpSeOiYZplmsQV7AzObdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTpjfRbrzBtmVx2eSxgCzirmXMH/SzBjmQNMjn4rSOU=;
 b=gS8r3aBq0nQR73QIa2Wu0+ZmEXNi4iCwr8kAQEpUwSLYSzPzCZvJDSIIUoJ+a9hLbdgOaRywexNVHvyT1Z9TaPMdnHIIZpaMl9DyelbUw9x6GT4LJebI5hASPQ1tcMxq6NIBcQj0iNVGl7u8vvwciu2C7qhd0nmH2De996rPxCZmkWc9hTknqlS9ea5BRR0zkhBfrJ/KogZdoj2FN1n51JTxT/z3+XpxUDqmjozJckYyeSMchqTZ8rbP+ka9aue+mqnuGWTyQcqi5tvN6bA/2AXhpI3I6mOwXRytVjvbt3Bxy10OcRKRG+lj8VaVe69GftpfhxHXnAXxu7oq+c+c9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTpjfRbrzBtmVx2eSxgCzirmXMH/SzBjmQNMjn4rSOU=;
 b=d2wSdQYsK/3+/T5aPbKKz/ycZJbHJxMhypa72lB40JVM1+SpY3+cvb2vw5AvgmJnD2gaA6E9Sje0pCdeizLmVSk3s8D5WyFWGBVkzs6+Ardl7Ze6GQ3lzWblpTsiMyE5QBbymZ2IfwiFPtnXj54QBdWWIJWEAaF7BPstM7tl43cZUR4X94P8Oe+XOC0hVmj5cF1jl+NPO5bo0g6cDWFegoXY+boBhiwhG7yKWsAu0miNBw7q6peMGT9s04cLzRCwUrWwW6OimWfRL85i90HM9DYCL/fLLCJM9GgR7WU6uO5uk0zVaQsMtiyuM1hHW6U8lBoSBYno9PoROAH85Vb6CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH3PR03MB7460.namprd03.prod.outlook.com (2603:10b6:610:199::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 26 Feb
 2026 05:35:03 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 05:35:03 +0000
Message-ID: <9399843b-4d2f-499b-87cb-ff22eae2b78d@altera.com>
Date: Thu, 26 Feb 2026 13:34:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spl: Add generic SPL MTD loader support
To: Sean Anderson <seanga2@gmail.com>, Fabio Estevam <festevam@gmail.com>
Cc: michael@amarulasolutions.com, u-boot@lists.denx.de, trini@konsulko.com,
 a-dutta@ti.com, a-nandan@ti.com, jonas@kwiboo.se,
 Fabio Estevam <festevam@nabladev.com>
References: <20260220031232.1254728-1-festevam@gmail.com>
 <fecf9c20-f5a5-d9f6-ddc0-dc8db483922d@gmail.com>
 <82b70e8b-3adb-5c0e-cf98-d5f501e0bc48@gmail.com>
 <CAOMZO5C9BwWosjdgJFPX8XMsrqo_rQLeTn9PLFi9JRoLw+-yag@mail.gmail.com>
 <1a128389-fe86-5ba5-1e01-4f2d932908f2@gmail.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <1a128389-fe86-5ba5-1e01-4f2d932908f2@gmail.com>
X-ClientProxiedBy: SG2PR06CA0196.apcprd06.prod.outlook.com (2603:1096:4:1::28)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CH3PR03MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e17507-debc-4dc7-3b82-08de74f8ca5e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: Y9aL2nA5NpgbaOVzCfmdxYCB3y1+rf6xf0Qiuze/TW259x6AwEGq8DyS3ZRHo5JnF4X6DUEhLjefctdTJSfGwS1fpjBSWhKoSXmY0F5JeFyuEhR+1oDCIzW+suRdohzpmcCnYQnt7quCWxNVUk9CSwBGl9U9bdc9aZT48cqF8fllITINI4e2RNRtE6kSblIX9ypbTTCHKjcmJB2Ojqw1vbyA4zGQVeuLNIalux72l4AzHBCJeTbTFkpDdITuIZxaztuDkfYcaIca8cNHQA2BTTo2eHW8jMAVJYxFJc74HlrcMquEqLBMp94/D4QXvu7khh2Q65Xc/qAqIOhjFtdlzPAvtVt5fy6D0lBP4PXfhK8Fma4m4j1xHzhYxexpZfRjnTpXiHnWHPT9lZM9+0ePhb7tEAhuAdpZvRaAE4l0UOZNZ/WV8357+3E/Lb0Fp65ej+GSmmVR0NgAuoMWBCwdeOvwxTDRmDBXfQ9829jFdIbpLhQotTEBuWTCBqQPVtkxGWaJ0x4aKgzLOvOQ6T0TiFgtuM7cKoQHe6njx6bKovXyh8owtt+u7iktyfgEgUgyA5twy6sytmgsEhoCmH0RCycDwQFCWz7mldBcKfRYXVpBVNoxl56dcHWlE23pkORrw5bAhb1PwZb+s00MVDgKV7yxa4Dzn4mdJgIVUsDZWcrUHS37h9MHarSEISx4RFOGRWot+6pHkGHIzf3Il8/jRLm/XukNod4SgBgwgLjH0wg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDBSZHF3azlHckRSZkhaYkVlWTMzM2Zxb2JhWUxEVEp5UlY2dU5GdUhNQXFB?=
 =?utf-8?B?OXlnSnBCTWNXUUM1Ti94TkQwVEErbHVxd3kwNndNRHhXRDdvYVpqR1VpVHda?=
 =?utf-8?B?QnZUNTBDcnBDdlMvelJwd2dpWUJZVDZXYjhCQVo3NFFRYTFyNlNMd3J2d3Fh?=
 =?utf-8?B?VjZSSVFBa0dxM2pyRGxCVEthekR4YnFZYmNTQkJCM3ZKb3lIVDMybnFUN0dt?=
 =?utf-8?B?MkU5clg1c0EzZnovaVg2TGJRUXNmNCtjakpKQ0huSDZXek1QeU0reTU1Tzda?=
 =?utf-8?B?RU15THJNSWYxdDhCeDVwR2ZINm9pZjdrbnhWaE1EZ2FXRTNuMGZZT3FaU0lk?=
 =?utf-8?B?QkU2Ym1DLzY1aHRFV05oWkhGNjloQ1EvdzNhTzk2c1ZKeFhwRXpRd2l5N21m?=
 =?utf-8?B?UjZRZ2VBRXRFU1pEUjA4eStYZ3pYdkhvVE5tSUw3ME5tTzAvNTdSUnVKcUQw?=
 =?utf-8?B?eDRlOVpzNkNjMVU0TTc2MnoyNy9Dayt2TFVpdXNleHZBY2dZTVkvQXoxZVNM?=
 =?utf-8?B?MHFwWUNHWDY5YjZFcit0TVlWUFpFUFR4UXc3d1JmSHU3Wm12YUdmNWR2ck5m?=
 =?utf-8?B?VEx1R1RXT2Z5b0h0UlRwK3Fsc2pYQlAxZE5PU00xRnUveTlNZ1M3NWN5TDlj?=
 =?utf-8?B?clZUWDZRMUlsbUZydXREWURTSEc1UlorQkdjK0kycTFNZnFQUm1lM2o0Mzha?=
 =?utf-8?B?Q0hpS1pxdlRkcW5XSUh1WDIvNXFSenF0QWRlUCtjRUNlUmMwU3l0TG1nNWJP?=
 =?utf-8?B?U3ZrdjVZbU1LVWREdzhwSDlNS0dydk85Y0VMQzZrbTdzNEc2blJYY1ZDZmt3?=
 =?utf-8?B?RGlWYS9wNGlYUG5lV1c5V2h5WnRmNzNGYWVwL09hdjNxUDBaa0szYS9zOGh3?=
 =?utf-8?B?ZzZSdVBOdmFybFZDWUpIWVFBU3hRMG9UakkveFk4R0pUODB6V2t4THhtdXdR?=
 =?utf-8?B?blROUVJYVHJpTks4RlRtaUcrc09WL1hJbUk2TVVJUTZMd2F2d05VeVAwZzFt?=
 =?utf-8?B?bE9DbmRZelNtdTlmN01UTUtKejZEK1dpM0JSY0ZKYkdNdjVNTkIxSHZxYjFV?=
 =?utf-8?B?R0hzWUlGTndtVW1VbFBvY2ZqMFR6ZXhEZlpueXZQcHNsamtSeFNQTTJqamQv?=
 =?utf-8?B?YmpDZDhDcmpaUXJ2clVxMzd2VGZPa0lWWVBIRTNURlp6OXNEd2pYYWVYOVdO?=
 =?utf-8?B?cE1tYU9OeDJBMUVKMEV3L3g4V3UwV09XK2xFaWhHcVdjd2Uyd0ozTEZKNHFp?=
 =?utf-8?B?VXFzMnpmOFFUaWNWQmxjaVJGVGR2NExJOHdhb0dHcXB5QzZpTkRYL2tWZHlr?=
 =?utf-8?B?Ni9lcFk1RytiRUorTDd0Mks0Y1BVMHl6MVBoU0loWmpBYXVEUllHTjFLTTBN?=
 =?utf-8?B?UG5zRmNnbUU1QTlsay9SbU1KZW9BNXNqU2NDS1BhY0Nwc2ZXQmI1blZqb3F6?=
 =?utf-8?B?ZTNtNHFpT2dSRHphbWd3cUZpc1JYZWx5NzB6L2hWL1JjMFo3b0lYdEpaNkVG?=
 =?utf-8?B?RVdldFpXYkZKY3B0MTNoRmg1eEJ2cTFMUm5qOUZ1QjY1d1dBcFY5Z3BaaStx?=
 =?utf-8?B?Z2NhMkt0NzFSd2orVjJPMkR4U05XSHprMjVBcjRTSGxGd2wwY2N3dlZEQ0Jq?=
 =?utf-8?B?SlNRMEdzQ3phMHpJTStaNGQ0VTdEaWJ2VDRYaHNOWVJUVVRlcDJ0Y292S1Qr?=
 =?utf-8?B?MkFRSzdTS2RKWEdzL0dVRUhPamsxKzV0RWVUTXM5Wkt6RVJrYjhETDdJdmpP?=
 =?utf-8?B?WlM2eGVGMkxibEU5d01HTmlVOW5nV2Z0d0t5cGJJd0ZuOTVxQVoxZjZEWWp4?=
 =?utf-8?B?a0tFT3ptT3ozaEJyeVlTdkV0dm5VU3pBNGlJQ2dCYVA3THNaM0haS0c2ZUVW?=
 =?utf-8?B?dytpVWNJVWYyVVFieUJ5UkNIdXJkRWE1aDdMOEI2SWl3d3ArM0NVNlB0VnJ1?=
 =?utf-8?B?aTRrblNXUytTODJaMzBpWURDRUlaQXhhV05MazNucjA4QUQ2eEFOL2YzMHVr?=
 =?utf-8?B?d3lRMXllVEhSUTd6Y0hVaUZ0R1NIVEw1SEhCVUlmd3R3RXo3NkJLZGdQZFpr?=
 =?utf-8?B?ZkcvaUM5TDVNVWRJU3ZpWnMra2pJL2dla0o2MmNWSndxTnp1MmxaT1VwSUxC?=
 =?utf-8?B?Sk1qcGlhRWpVOGhLUFNicW1xaUw2ZnRoWVFaR1pNcWcrU1I2ekM3VDNBcGhE?=
 =?utf-8?B?Kzl5MEVva1p4YUphRlNkTXdXK1crL3NScVpUSlVCV2hLbmRmUzhGQUloWFly?=
 =?utf-8?B?ei9DUUdCcHk0RXBJL05MbFk2RzBCWERCY1RLRUxWSGFaWWhNYVQ3UElXbUdl?=
 =?utf-8?B?ZFBKaFpEL2MvWlA0bXkwOHRKVkREV0RUNmhEL3hGbHJWczZJRzBqY2FpTytI?=
 =?utf-8?Q?01/lb6i5K3BUWpFo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e17507-debc-4dc7-3b82-08de74f8ca5e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 05:35:03.2972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0mBgaGSbXBXNWAOKQvczw6aAWsGv7MF72UQ+6AC7sGZsldnDnDw5mI/h23/4HwSlPiFZrsJgxp9tBMCT+JexoFkco0Hpx4pKNHLloj4pTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7460
X-Mailman-Approved-At: Thu, 26 Feb 2026 14:43:22 +0100
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

Hi Fabio,
Thanks for the patch.

On 26/2/2026 1:10 pm, Sean Anderson wrote:
> [CAUTION: This email is from outside your organization. Unless you 
> trust the sender, do not click on links or open attachments as it may 
> be a fraudulent email attempting to steal your information and/or 
> compromise your computer.]
>
> On 2/25/26 19:08, Fabio Estevam wrote:
>> Hi Sean,
>>
>> On Wed, Feb 25, 2026 at 4:45 PM Sean Anderson <seanga2@gmail.com> wrote:
>>
>>> Actually, I don't think this is correct. NAND devices have have 
>>> multiple MTDs for each
>>> CS, and SPI-NOR devices are UCLASS_SPI_FLASH and not UCLASS_MTD. So 
>>> I think it's better
>>> to do something like
>>>
>>>          mtd_probe_devices();
>>>          switch (bootdev->boot_device) {
>>>          case BOOT_DEVICE_NAND:
>>>                  mtd = get_mtd_device_nm(CONFIG_SPL_MTD_NAND_NAME);
>>>                  break;
>>>          case BOOT_DEVICE_SPI:
>>>                  mtd = 
>>> get_mtd_device_nm(CONFIG_SPL_MTD_SPI_FLASH_NAME);
>>>                  break;
>>>          default:
>>>                  mtd = ERR_PTR(-ENODEV);
>>>                  break;
>>>          }
>>>          if (IS_ERR(mtd)) {
>>>                  ret = PTR_ERR(mtd);
>>>                  goto out;
>>>          }
>> ...
>>
>>>> Actually, if CONFIG_SPL_NAND_SUPPORT is enabled then the native 
>>>> nand loader is compiled.
>>>> Maybe we should add a separate Kconfig for it 
>>>> (CONFIG_SPL_NAND_LOAD) defaulting to
>>>> SPL_NAND_SUPPORT. Then users can disable the "native" load method 
>>>> if they want to use MTD.
>>>
>>> I have a patch for this that I will try to send this week.
>>
>> If you would like to prepare a patch for the generic SPL MTD loader,
>> I'll be glad to test it.
>
> I can try, but I can't promise I'll be done with it in any particular 
> timeframe.
>
> But TBH I don't think a spi_nand.c-style loader is the right way to do 
> things when UBI exists.
> Maybe Dinesh can comment, but I don't really see the point except if 
> e.g. you are really short
> on space in SPL, but not so much that you can't fit in MTD.
>
> --Sean
>
> Based on our current design, we rely on the existing NAND framework 
> with only a minimal set
> of additional helper functions provided by the controller, which keeps 
> the SPL implementation simple and NAND-specific.
>
> The SPI-NAND SPL loader expects a broader set of common SPL 
> helpers which lead to compilation failures.
> Adapting to that model would require significant refactoring and 
> extensive testing,
> so for now we plan to continue using and extending the existing 
> |nand_spl_loaders.c|,
> which aligns better with the current SPL design and our constraints.
>
> --Dinesh
>
