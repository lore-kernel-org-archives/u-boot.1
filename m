Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDC0C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 15:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7613F8215F;
	Wed, 30 Apr 2025 17:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="tngqP1yr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4715482B9D; Wed, 30 Apr 2025 17:41:47 +0200 (CEST)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45A5382153
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 17:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2a48V20KBUOWtfGmG3CR4NogX8eQqWpwfV+3CpEG0CYmQza62TciPh2rukpLDPmxrf0Na4xqVeAXj8jE2PHaGrnLiWcDBWXFwUSr+18exxvPAXlJeGN1bbbwZKX3H2sn/etmBMk3WJEEtDm+S8OJsOxMf7NXjrkaCVD3/1yMkR4nt9ztRH2A1Dsd2w9zESqahWOa4mcMTj7hu+TCSIXaX6U0a8qry10hzRg2St2QSRkgC6FNqlfyKCBvzWdofoe3fjXh2oUX4QsTXfaMhBX2yMLaqllsatOxbkDe3j+Lr3NrqSW8o1eszA5jp75tcyhD3OGlLy/sKhNsAQmOGrzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbwN21aRWEM5S5nqgSC5bzoDSdpdDKJ2eCzjAYhPZEs=;
 b=q9qmoKxWepA2fl5TNE9bEtdSGpGrvTabQuy8/a2uZ3UKnp2WoOB9yL4QJF1oe6xCXAgYdxoyjhYbmAkblSguIlkYJx7P9krit7hlvJxfiCkKpSUhQBooJJXrBx1trjkGdVsZTYs9Lk1lUxu6wCveN3FkBQIYm7fNnBiAw49Nks94JXqrWxIDHMOjdyzVVwyB9U4qsrOzF9JdJit6bvfwlwUTWuYweMVRpZ4Fn9BHOGCqgjURIO79/DWkeoCc8aUe7mzuDknd/qxIQZm1jidsqjV4dyVYu9hRgf9M7ud5zcp5soPrrXLeDwzT46pTMkRUKtLxZHf8KSZiKFNbHDKlxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbwN21aRWEM5S5nqgSC5bzoDSdpdDKJ2eCzjAYhPZEs=;
 b=tngqP1yrFUAHQ+fI45QPLUNseXjS+zKiqa9kXVoIsVcUw4nIMhU+JNTqk2yJDiGSvg/pWgw6+vZt6t2qofhz6KJq0QkPp07FV7GYOXgvk/aU8yC/N6Uu5/RR33q6nR11EiD30zhFm25EQUj7vWb2tvQGW9AzLU7F23PmHKnxGZ2mBNkZ+I73D/DOjww4UJ831H88rkLRe4rz43Cv1hc4wu3cRpndIpFOM9aDXVrOlRdwf6XunVSZv7pkbJ2pcK0hqkDJcGKrdQtzWwixRolUwCN0+zAf3h0bG56SOYSbTbl+PiY8+cQzJrw82BfgAgaVKWMfxOhl9M8uYzftS12ONg==
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com (2603:1096:101:52::6)
 by TYSPR02MB7704.apcprd02.prod.outlook.com (2603:1096:405:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 15:41:39 +0000
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f]) by SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f%3]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 15:41:39 +0000
Message-ID: <SEYPR02MB5557F4318C70B2215FD506E696832@SEYPR02MB5557.apcprd02.prod.outlook.com>
Date: Wed, 30 Apr 2025 23:41:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] watchdog: qcom: introduce qcom-wdt driver
To: Paul Sajna <hello@paulsajna.com>, u-boot@lists.denx.de,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To SEYPR02MB5557.apcprd02.prod.outlook.com
 (2603:1096:101:52::6)
X-Microsoft-Original-Message-ID: <9be9cd55-ba34-47ef-a1af-ae8f24ffe27e@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB5557:EE_|TYSPR02MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 97081b81-ed4d-4bba-2dc8-08dd87fd7f25
X-MS-Exchange-SLBlob-MailProps: Om8TgR6f4EABJHob1MM8IpvaMUQUvxYEOUJv+L4Z/y0bewwzI+a3AznZ3oS7JahUm/WZ4EcBO+byobJlW26zN1ENFPILmUVyHvdZSOSd3Z0Cmqncsf6QsrzzrFVo3oPZefsvMY4ZrCkEsq/TAdp4YLU5FSOwzjttcOpuNh0bI2V+NI2uw34LurCzgxnBvZAW0nU0gIayg01kCigYJiqkdPJpUcEr4XT5ZJRkxqSkdkhzg2besLLAtNBAH7urVW1EUu5vhM64/ENVW/ZEeVIHMWvFiJu6QaFQsJkdBfU77AjA8XtUqVxwrN4ZKo2fcN25Boh9TmT1/ATSdgrP48aOtJoHt3bKKzyo0r7kGT2e7i2fiv0/9fzqjHTBpbnJ6PrujSQqRfD0wormYoQ6AiMV9k9gfjqqoZ28DeuEtX3dx3q2WN1WxBfbu3HvxaNpck0XyCyyZAc0+P1lynM08PFPl/94lNScXhq6gU1FAP1sywbdueOfS+5ATCRMT5HrOV1zlEAUmy5Y+39+CaXDny8fs/sFr5jashWneOS29am75X9l1YpYAnTSsMo823NDAMhMMn4hhUDa5Vq8+/PrVVp8iGpDxfxqgqVTPybytItR/hmFwG/Fz8ccbjAZx0g1iWEGw4Y1c7FxIZ1tuPCmDlfbPazG6TZ2N7un2hdwoHFIx4JBRgUM1NtnwxOEDTbaKY0v2lp1NmrzU1dCTPe9DoLFPSEcFlnc9jHab79YTOsIeZaP5FDhhPydbaw1TAXcflWD/HgZqv7WJV6qS7/IoFhGsKD+YT1FHDiqVKjkA/TZEAlguGiOLQNZwGI6fJNXa3hwqk/pMS02mKbhPJFUCF07hyIuJ4kyAf1J
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|6090799003|8060799006|19110799003|461199028|5072599009|10035399004|4302099013|440099028|3412199025|41001999003|1602099012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkZKbERYQUFZRVRLWWp0bEZWK25CaGlkeHlIWUkrQ1VaYWFKSFNBTWRCdy8w?=
 =?utf-8?B?N0dKaVkwb0x3NEJrQnYydnpqT0JtcSswVDdRcjRzNnNuN0I4TXovSVVkV0xa?=
 =?utf-8?B?RjdtR2xNQU41cHNiUEFORWRDelk5ekdKdnhrZzJHcEFLMlVYQ3dMMjJjSGoz?=
 =?utf-8?B?SURJTURPRUFwYlhVWjVBMmk3UDVjUCtCUFlYRUpZazNzN1QySE1zaGlYSVhH?=
 =?utf-8?B?dDZ3UW9SUGNwOFdJOUs2R21DZVl4YnJQTk1OQ3BiNGdRL1MyRk1hWnhtQUF1?=
 =?utf-8?B?Tng1WGpMSXo3cjFUSCtHUk1UYnR3QTFubVI4Zm5VYnNiQmpTYkNJU2VIV0oz?=
 =?utf-8?B?NEFiWnhJVmk3OTVPN2x3dkxraXBuVW5JZ1Fob1BIbCtjMzBUNCs0MXRrQnYz?=
 =?utf-8?B?NVVSVzFwUDhQVFFsbzBkVVFhbXZRd0ZnRFJFOUJmT2RkTEx4RnVxOC9jcnQz?=
 =?utf-8?B?eTRiTmEvOVljWW11Y3JWRUI2VkYvdTEwY1k0eEU4TVF1emgwQkRzZmxCbzZh?=
 =?utf-8?B?Q0k1alJxQUphNEhXVVUxa3gwWFBrRG8yK3N6b2Z4L2UrZmR2dm14UmFKNkJX?=
 =?utf-8?B?MWNQR0owdDN0WDREdmFsSlR1cGZJekhRZmdXS1cyMWNHYUp5V2szdy9HWXUr?=
 =?utf-8?B?M3pqTXkzUUYvZWcyY0dtTk9jcnJWOG56Z3A3ZzlyVm13S2pwMExrYlcrNFR5?=
 =?utf-8?B?eUQ5UkZWaVhHb2pMdEN0VStzbjdWekNGZlM5dXJJVEEvRTZnbmtIUnZIaEhm?=
 =?utf-8?B?V2tuNVlJWUFvblJ5dUExVkl2YWZIdUN3b1RRNjFoSkZGUVpqdDkrRVVtYUM3?=
 =?utf-8?B?RjNpbnhYeXVyZlFKNTV0dklJaDJPK2NKQ0V2dG9sUFltOXQybFhXM1hEbC90?=
 =?utf-8?B?TDZXQ2RiQ2JuV09WakxWVFYvQ3BTK2tvWVlwL2VuaW5BTVI5ZS9sNDlHTmhP?=
 =?utf-8?B?ZFl1MW1PR1UrVWlsWmIyZFgybmRLNDhxVG1RSk1hb09XTG9jcVVPRmxkdVRR?=
 =?utf-8?B?WmlZYU1aTEVHNUVSNGcxN2FaTHVwR2FCY2J6ZWJGSjZMSkFlV0ZKdGhVc29T?=
 =?utf-8?B?aWcyejN0cG5UT3NjVWkrWFovVmZCK0tuWGphRGJDY01GNWIxMk4wQUhWeEFN?=
 =?utf-8?B?WGEwaW1EdWlibmp2ZnFiVEM1dXJOczVMcWxXZmYzcXVzWGJXUWN1MkZnSit0?=
 =?utf-8?B?SFFxOGhHSnhVY0hjamlweUVOaW1XSHhndXZ5SWc4QVR6WVp6bGJyYThNNUUr?=
 =?utf-8?B?VFJ3cWpZbWMwVFNWU1k4NjdpZ3lWWk9wWmZuSEowQXgwQjlUUnhRN25ZZStY?=
 =?utf-8?B?ejNjYncra28wN2JvK3l5WHpxTmIzY1BDOEx5eXQxWG1WY0xoYm1LV2w5UmJu?=
 =?utf-8?B?SGx6Q3FHM2c3V0dlOCtVTkJtSUtLVFRUY2tId05CU2EvaGZqYlYwT0doZWxq?=
 =?utf-8?B?M2hvN1lwTUpVd3BsWkVqQTlTNklpTXlnWmdsZnVDbkp0WWNNS2lSUnFPQnRa?=
 =?utf-8?B?WEEvMGJqNis5cHIvZ2ltRy9Db0p4dStwS2hsbDU4N1IxczZoUTVWNUpnaFp6?=
 =?utf-8?B?RWhNcXJVcHZyK01vdWQwci95NWJUdG5TcXZNWndreUVFUWcxN0pKR1RrdTg0?=
 =?utf-8?B?WlpmVUpJbFhXMHhKNGlRcWlINEt4RzkvU1VKcTNkQU5rbjlBMmVtbER6YkJa?=
 =?utf-8?Q?YxXwvpZCFo4EeXJrL4eB?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVJkSThIUCthdXNSeEpaRlF3STNmbjVCSEVhTGN5eU5rS0s3eUVjUFJJNHBB?=
 =?utf-8?B?SSt6UkFNR3BzNGM4VTN1bU40RUNtNEMzR2lkMHhrVHN5OUx4MUNnbTRKV21Y?=
 =?utf-8?B?azNXVHhsWnF0OFdjQXR6RXhNZVM0THhqaHZDaEtrOENBVzh0WDQ5UWQwbG82?=
 =?utf-8?B?WEVIQTNLaDFsK2NvYmpJSU00b0QyOEU2WWNac2UrTkJmRXBBNE8xRFByZ3ZB?=
 =?utf-8?B?bHFoOFpseHdJNCtaQm0yejlvNFlYUFd0VkYzNm1DRHV2YUpHMFhhTno3NGR3?=
 =?utf-8?B?ZVkxOGY3dyttNHJESnpQRHhhMk5BQkR5SFBtZEIyR3pOaHJVSERPMDhUNHh2?=
 =?utf-8?B?UWNJV2RzdzV5V0VOdFRUd0dKaHZobnVvckI1UFR6Z2lOeUdzYmNobHlsMFBK?=
 =?utf-8?B?QkRDUnRYZHdhRGhRQTlmbWc1dkxHSzhRaVZqVVIrZHJ1dWh5QjZpVW15UHoy?=
 =?utf-8?B?cE13c0R0Vnp2dXo4NE41UnhydjdyUnpzdS9SdEFPc3o3NFNJWHRkMUgyaUl3?=
 =?utf-8?B?Uzk5blBwbm54WGhwUDdSSWpRYnN5NEI2WmNwUFNLMlRvMDZnZ3ptbjJ3Nys1?=
 =?utf-8?B?QnBjbEtiM2Vhdm9nNjF2VTc1K1k2NmZqNEUrQjkxaHlpYzMvM1BmR0hkblF3?=
 =?utf-8?B?ZUYrNjI3YVp6Ukh1Q1FRdTA5aHhKZnZGUXdaRHZTRU1haVFabEpCVDQ4a0VG?=
 =?utf-8?B?Mk1iYXlRMnJJVmZKcE56cDl4Y0ovYkRDd09ONHRpbWo4aWdxaDBsbmZWQXNM?=
 =?utf-8?B?V1cva0JQQ3ZCRk01c0VyTjNOa09VN3hYWXFwR0hpTFBCNTZJbyswdWJ0Kzkr?=
 =?utf-8?B?cWZGazIwWnlhd090a1BwdWdURVcyajBrN2ZXQ2hTR3FSaUc4MEMvQmRYRDVa?=
 =?utf-8?B?QUQ1TExZMDNUNjd5M2RiVWswZDFFUlhWZEZ2TU9OcVdRck9oc2ZDallSY1JM?=
 =?utf-8?B?ZkF1MmFCdlE4R0lSUGdHT2ptUEhXd1ZwWmxhNTB5R1l2R2wwLzBFaC9WNG14?=
 =?utf-8?B?V1hEUGpJRlM2UTFheGhKOG9RNWF0QlA2ZjduKzBvWnQ5Q0hValNPVzJrdjBF?=
 =?utf-8?B?b3pNa2lRMnRBQmdXMzJubGZOQzlramJTVWNyWDRsdHZwTDBvNllYSzlRS0dZ?=
 =?utf-8?B?aDZjTzVXOWdGRlhKcjFERWpvV2hRelNLWnZyM2ZVRnBldmVLRmtWWXhaZkgr?=
 =?utf-8?B?eVA0VzJ5eHc2RTk0WFBVSkhaVEZvMWMyVEhITjgyUVJBbjFnUDczZmE0bXBx?=
 =?utf-8?B?UVhDTHVodlZiVGw0ejhjWHdnY2hyQlpGdExsc00xWFJ2MHhOOGJpTFpoUy9S?=
 =?utf-8?B?NWNQaXNRaGVCNVpqRjF5T2tzTXVka08vWkludHFSajBIeXpjTTBjZmxPUGZ5?=
 =?utf-8?B?SGppZ01UR0ZBa1k5ZlBkR21TRisyQjBOdmZWYVRDaElvNnRTRVFwbmJsOENv?=
 =?utf-8?B?dlY5OGtUN3VOUW9PcnZVSUwyMGg2MnZySlAxbmVkSkNWdmRMaUJJeHN4VDR5?=
 =?utf-8?B?bzlmSDkvV0xyRzBUc1JRWUthK3VDQnhsQU1NU3YzZ3NpN256QjJxM0I3dkwx?=
 =?utf-8?B?WHB4RnVyQjY1M2wyYjNVQU9FYkVlSU9GRFNqeFYwUTZjeTJiN1NFcjN2QklC?=
 =?utf-8?B?ZFZQZ29hYVRtNUZuamNHNWEwMlRFREl0OFUraG9STnoraFpzSytNSXN3UHVO?=
 =?utf-8?Q?r8L5+ac8DQKIjyLvJCtb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97081b81-ed4d-4bba-2dc8-08dd87fd7f25
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5557.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:41:39.3424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7704
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

On 4/23/2025 10:19 AM, Paul Sajna wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Some Qualcomm device vendors decide to turn the watchdog on in the
> bootloader, resulting in the device being reset if it isn't petted every
> ~30 seconds. Introduce a driver to keep the watchdog happy and prevent this
> annoying behaviour.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Paul Sajna <hello@paulsajna.com>
> Co-authored-by: Paul Sajna <hello@paulsajna.com>
> Tested-by: Paul Sajna <hello@paulsajna.com>
> ---
> This patch introduces a simple watchdog driver for Qualcomm devices.
> 
> Some devices, including one I have been spending a lot of time with,
> the LG G7 ThinQ (codename judyln, arch sdm845) will reset within 30
> seconds if the watchdog is not serviced.
> 
> I have tested this patch from Casey Connolly that is over a year old and has
> not yet been upstreamed, and it is very useful to me. I can hardly use
> u-boot on this device without it. I have received Casey's permission to
> work on upstreaming this patch.
> 
> This is my first contribution to U-Boot, and I am unfamiliar with
> mailing list workflows, so please be patient :)
> ---
> Changes in v3:
> - Squash commit 1 and 2
> - remove duplicated line of code
> - Link to v2: https://lore.kernel.org/r/20250421-b4-qcom-wdt-v2-0-b2250efa0f39@paulsajna.com
> 
> Changes in v2:
> - Add watchdog start
> - Add watchdog reset
> - Remove stop from the probe function
> - Use dev_err instead of printf
> - Update Casey's name
> - Add myself as an author
> -
> - Link to v1: https://lore.kernel.org/r/20250413-b4-qcom-wdt-v1-1-db42cb93dff8@paulsajna.com
> ---
>   configs/qcom_defconfig      |   2 +
>   drivers/watchdog/Kconfig    |   7 +++
>   drivers/watchdog/Makefile   |   1 +
>   drivers/watchdog/qcom-wdt.c | 117 ++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 127 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 537806450dc4a61d3c617cdd2b0cfb8eab1c343c..0232f6d51c552bd06c8ba72b71edb5cb72fe0706 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -144,3 +144,5 @@ CONFIG_VIDEO_FONT_16X32=y
>   CONFIG_SYS_WHITE_ON_BLACK=y
>   CONFIG_NO_FB_CLEAR=y
>   CONFIG_VIDEO_SIMPLE=y
> +CONFIG_WDT_QCOM=y
> +CONFIG_WDT=y
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 1bb67f5035231df9f6ce01adb08d074855393143..808f4e578e28e7812f93b393a7f7d95d9501cdd4 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -335,6 +335,13 @@ config WDT_K3_RTI_FW_FILE
>   
>   endif
>   
> +config WDT_QCOM
> +	bool "Qualcomm watchdog timer support"
> +	depends on WDT && ARCH_SNAPDRAGON
> +	help
> +	  Select this to enable Qualcomm watchdog timer, which can be found on
> +	  some Qualcomm chips.
> +
>   config WDT_SANDBOX
>   	bool "Enable Watchdog Timer support for Sandbox"
>   	depends on SANDBOX && WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index e6bd4c587af6133c405dde6dbada8050debc781c..5eaabd4aba58c815de4165f901aecfba0e0da255 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -54,3 +54,4 @@ obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
>   obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
>   obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
>   obj-$(CONFIG_WDT_ADI) += adi_wdt.o
> +obj-$(CONFIG_WDT_QCOM) += qcom-wdt.o
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..3601ba93774730f78574b2fd74b8c513e7ce22e1
> --- /dev/null
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> + * Copyright (c) Linaro Ltd. 2024
> + *
> + * Authors:
> + *   Casey Connolly <casey.connolly@linaro.org>
> + *   Paul Sajna <hello@paulsajna.com>
> + *
> + * Derived from linux/drivers/watchdog/qcom-wdt.c
> + */
> +
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <wdt.h>
> +
> +#include <asm/io.h>
> +
> +enum wdt_reg {
> +	WDT_RST,
> +	WDT_EN,
> +	WDT_STS,
> +	WDT_BARK_TIME,
> +	WDT_BITE_TIME,
> +};
> +
> +struct qcom_wdt_match_data {
> +	const u32 *offset;
> +};
> +
> +struct qcom_wdt {
> +	void __iomem *base;
> +	const u32 *layout;
> +};
> +
> +static const u32 reg_offset_data_kpss[] = {
> +	[WDT_RST] = 0x4,
> +	[WDT_EN] = 0x8,
> +	[WDT_STS] = 0xC,
> +	[WDT_BARK_TIME] = 0x10,
> +	[WDT_BITE_TIME] = 0x14,
> +};
> +
> +static const struct qcom_wdt_match_data match_data_kpss = {
> +	.offset = reg_offset_data_kpss,
> +};
> +
> +static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
> +{
> +	return wdt->base + wdt->layout[reg];
> +}
> +
> +int qcom_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +{
> +	struct qcom_wdt *wdt = dev_get_priv(dev);
> +
> +	writel(0, wdt_addr(wdt, WDT_EN));
> +	writel(1, wdt_addr(wdt, WDT_RST));
> +	writel(1, wdt_addr(wdt, WDT_EN));
> +	if (readl(wdt_addr(wdt, WDT_EN)) != 1) {
> +		dev_err(dev, "Failed to enable Qualcomm watchdog!\n");
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
> +int qcom_wdt_stop(struct udevice *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_priv(dev);
> +
> +	writel(0, wdt_addr(wdt, WDT_EN));
> +	if (readl(wdt_addr(wdt, WDT_EN))) {
> +		dev_err(dev, "Failed to disable Qualcomm watchdog!\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +int qcom_wdt_reset(struct udevice *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_priv(dev);
> +
> +	writel(1, wdt_addr(wdt, WDT_RST));
> +	return 0;
> +}
> +
> +static int qcom_wdt_probe(struct udevice *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_priv(dev);
> +	struct qcom_wdt_match_data *data = (void *)dev_get_driver_data(dev);
> +
> +	wdt->base = dev_read_addr_ptr(dev);
> +	wdt->layout = data->offset;
> +
> +	return 0;
> +}
> +
> +static const struct wdt_ops qcom_wdt_ops = {
> +	.start = qcom_wdt_start,
> +	.stop = qcom_wdt_stop,
> +	.reset = qcom_wdt_reset,
> +};
> +
> +static const struct udevice_id qcom_wdt_ids[] = {
> +	{ .compatible = "qcom,kpss-wdt", .data = (ulong)&match_data_kpss },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(qcom_wdt) = {
> +	.name = "qcom_wdt",
> +	.id = UCLASS_WDT,
> +	.of_match = qcom_wdt_ids,
> +	.ops = &qcom_wdt_ops,
> +	.probe = qcom_wdt_probe,
> +	.priv_auto = sizeof(struct qcom_wdt),
> +};
> 
> ---
> base-commit: 0eebdd17888005751cd77cf3794c5292d36f481a
> change-id: 20250413-b4-qcom-wdt-e7b913fc375e
> 
> Best regards,

Thanks for your contribution. It'll be awesome if you can implement 
timeout parameter support in the next version with the help of 
https://pages.codelinaro.org/clo/qsdk/oss/boot/u-boot/-/blob/NHSS.QSDK.13.0.0.6/drivers/watchdog/qti_wdt.c?ref_type=heads

-- 
Regards,
Yang Xiwen

