Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32985C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 12:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 918A982116;
	Mon,  2 Jun 2025 14:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UfT4gLeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2619082145; Mon,  2 Jun 2025 14:09:26 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9819E81F6B
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 14:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEqhEM/UuwkzUW7RC0VDuS8T0aImQK1zj3Ftph0e2bNM1OURHw+XY+cX5Q0VPB/rWbJTKRu4q3pZXaqB5VkeFCOXkWkfhPjPhJ8eTHZ0+kdEN6lf3s3/bjrlST645GMXYL4gFQ42YV6/xNVCkAsyRYB2Yxwm9wryjRfiwlzG0yu/m+KybNG7AEXhLCApKuaPrOtTopf3rzZxQJga9wGhFWuzfGgFz3iqAburHEkrBEVGh4ZizMxoEUGREgl34bKsVb5vS4+ZcCs5cLeqZ866KjX8bqvlw1amjsN35n+bKfSxXlEx5idR8fKiIFz4GboojQ7FjA9uG7lAu09NyV2b6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXv+fy4FbqWttjuPPzkEG7PSJsAh9dnuZDx3v9hBXvA=;
 b=o9foVF+4gqwmWW4q8bO12Xba5mP7ah1FEWM4ft8mpTiHnRgJF9nuV1kJWpS5rOUnlm+01EmoBAxfVIRjxgSumgbG5+kW85SXZe5TiSngr+KiM02C06DR9X0lO8x8PRrMhqOeBKjYA8fWcXh0T7yYtZkzfs1551ASkYQ8toF7m8bI8qcDJvyMhchzS3QA/P14/KO0vWp8BNcp3yBxnB5zJJQfEMeFTN5FvE6cNYukeYbvYOkR9jjmrCtiF3cISLRkCfcDo9Q12FJl/lTkGUDsy/hZ0ALVK6D3d2IhX5HArTB9AfiULqelRBmpDQTKZ9s3ceuLzbMm5KEAckv5kjK6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXv+fy4FbqWttjuPPzkEG7PSJsAh9dnuZDx3v9hBXvA=;
 b=UfT4gLeqHd8kZ0NmKxHFvf5dIhoIZW1b5aMXNS4IyL9kvP1wwq7al5lMuMYOLPrsxJLrKIL4LljSbnH7O7pJCGf2Jfo+ovlnTXCL1nixvDoZirg5jQZUEkMqnRxlTMngi1ydL8WZwbmiglUxBSitEFCUCFv0GvK5cb77IJ6QkLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10691.eurprd04.prod.outlook.com (2603:10a6:800:26d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Mon, 2 Jun
 2025 12:09:20 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 12:09:20 +0000
Message-ID: <25cd60e2-5585-4c43-8914-8d763123f319@cherry.de>
Date: Mon, 2 Jun 2025 14:09:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "booti/bootm: riscv: Verify image arch type"
To: Mayuresh Chitale <mchitale@ventanamicro.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20250529033052.399573-1-mchitale@ventanamicro.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250529033052.399573-1-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0469.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10691:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8935f1-c6b5-41e0-8a12-08dda1ce4de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MSthYmRlR2k5U3Uvd08vUDBzSzl1UlBxbXRSQnBDZkhGZmxMNS9xaUxFMllq?=
 =?utf-8?B?anR5UFFaN0lTZGV2cFRiVERHYUhHbU90eklkdXdBQ1c1cnZFY3kvNUIyaXh1?=
 =?utf-8?B?UzBGMmNtQnNxQW00V1VzR1dVemk0SjNQTlVzcFdLSXh5c0dnNVdBQUlwSWpY?=
 =?utf-8?B?b3EzWFJFZGxqY2hqL25OalVKMFBOK3JaSC96TzdZb2ZEdGh0d25iVHZ6UTBn?=
 =?utf-8?B?V1hWZ0JseFl0UkdkZzNiZ1Fyc1NxSG1waE1TUm9idHU2dzdHVTJCa3FPN3lL?=
 =?utf-8?B?cUs1K0h3WXA2TWxVd1BNWFhYTERmSlRCQktneVlHaGlVdGZHRHduWnNyZ1Yw?=
 =?utf-8?B?WTdjTTV6N0ptUHBmdjMwZm5teE9TUHI2OHlqMGJ5S29jaThkYWtYekJGdjlu?=
 =?utf-8?B?aTZkVzJ6NTJpNTJHZDRnWGo3RldyM2duV1lBWTBES2hDR0diWkdWQm8vWUV1?=
 =?utf-8?B?SDltZUZTYUhXZUhieTlyUklsY3FrT1ZZSXNEY0oyVW5EaVFnTGtqY3ZGcm1X?=
 =?utf-8?B?YTZhaFpFTlZhVXFKVWk5aVB6akhXNUJyRGRvdjdqcnJid3ZsbndvMlVMdjFt?=
 =?utf-8?B?YXpmd1RLa21YcE1FWmc4QXYrQmxNdzJCQncwZDZNL2tpM3BNZHBaZEhmYW9t?=
 =?utf-8?B?NnZVLzBVcTRRbnNjS0hXRjcwVzl0emZvWDRBQ0RKQi95L3VsZUFad05xZnBr?=
 =?utf-8?B?eWhhNU9IckdYY1BNS1lZcmNZMG9TSlB4Z3F3V3BZNmdaemozT0FFVUR3dnAv?=
 =?utf-8?B?bkJFbmNiYzJnNEd0VUJmeWtmOEVJd05ZdlYrcUxIUWJkZ3ExcEYyM2dnVnN0?=
 =?utf-8?B?Uk9haVRHb0RFVWlGNnFGS1BxWUM1SmZ4KzJKc3FSc2VTT3h4QytQaEpkaEww?=
 =?utf-8?B?T3BnTndkaEdXTHBTSTJSeW9Fa1I3VEZXVzVHOTZJenZrbktRYWZGWndCSndp?=
 =?utf-8?B?eWtTOTRFS0wxL3FDMmNBZDkwZDM3cG1sdUZVU0lDWWhJQ3dFUkVpWElLYVJz?=
 =?utf-8?B?TmpXTFppdVJtbnpBS0txYmJ2Z2QwdDhLcXZURXpNVFgxSlh5T0xpWENSYnVj?=
 =?utf-8?B?cmZMbHJETFR0UzVEV1l2NlJJanB5dVFFMlJSc2Exak1pZ1pDNlZ1RjBXU2xC?=
 =?utf-8?B?WTFKanFNbnB0ZWdMMnJtVDNPSGxabjFqcUFINHJLYXhBaUxGMW1Dc25zWXpn?=
 =?utf-8?B?bE9VVUg1K2U3OVg2UWRMaGM3SmtBSmJtZmRDbG95ZUZqOXNIOEtWdmcyWjM3?=
 =?utf-8?B?ZWM0NVVpc2FXQ3Z1bHM3dERSMkZUa0NRazN6elB4Q2FuS1VzaEJYbnhndml6?=
 =?utf-8?B?N2dvRFo3NHYvY0I4TWdZSUFldGVaaHhOMmZ5NXJOYjJ2WWRMRE85T0YwcXoy?=
 =?utf-8?B?WGVvSjhGbG9yaXU2d3ovbHY0TWYrQjFYRmhaREk1Y1d2ZDYvazlNcHhKcTZ0?=
 =?utf-8?B?VUN4dEhPaGlEZXpYZEcrYzAwbEsvd0EwTkVNYnJ2OWhrVHdUYzE2WkdSVk5O?=
 =?utf-8?B?YkFOUEZXaXlLeFNXV1BwNTJXVFYzangvUXJjK3pOdVlwelZJeUluOXBrdHo3?=
 =?utf-8?B?bDhxU3Bray9wVjV5YnZjbkRVYUR4d1VKbzducjV4ZmVOUHpsVGxkR0FMNHRX?=
 =?utf-8?B?QzFnSWNteFV1akJRcmtkUnNJWER1R3grRmloQ0dVTjh0NUUvUDZwbjZXQXpn?=
 =?utf-8?B?RWxxQzUremxOMmpGZG9OSHVwUzY3RThKdFU5RTlBVDFRcjRrYjYzZWhzeDli?=
 =?utf-8?B?RWU2YlRVeGxMa0d3d2ltcXRWcE15ZFBkdXlCekdSQmYwK3pKYUtGUXVISjgw?=
 =?utf-8?Q?PDOm9M7aGEcCQ27KVVyuJNVR8ON2w2eGVmuYU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MitVUkU1aEgycmxnTUcvNVRKYjM2UUlSeUtoVEhzVXlaSXJJRk0wMHdzb212?=
 =?utf-8?B?MTRjNTRjemlvUUtDZ0IzQTRzejdGclp6U1h0V3Z0K0pxQkpvdlJza1Y5K29B?=
 =?utf-8?B?UjlBVXlmY3JHUFhYM2p6R05FK1I4RDB5L0Zhc3hMb3JwTERBS24vREVsaEZO?=
 =?utf-8?B?OUVNaEs0Um0wVzcrY3BjTlpCUGI1NjZFZVBEdlpJOVhENnpZcEVVcTJ6WXho?=
 =?utf-8?B?L0Y5Vnh4eFlsUEl6SW9nZ2FUeXNObll5V3pwUHhjZ1VEQVpLQ3VMcVk4OGc3?=
 =?utf-8?B?RHMvMS9mN2xPT0lLYTlweWxtcTM1L0FaQmcwVHhWVEJGZ3NJOXBqMUJBVzNN?=
 =?utf-8?B?Sk0rcmI5SXVYdUFsbDVzMTZ6MGhpSlU4b3ZsSnIvVUZHcWZGTVh2TzIrQ295?=
 =?utf-8?B?Y0F4Y2JoTlA1L29OQm1jVE53YVhqNXA2eWJHSTlMN3ZLZUhCeFdiWUF4VDNy?=
 =?utf-8?B?aFo1MjU2NWlxZlhjdDk4aE9DZWt4S1grUStIa3d2UVNtSktRV0w3dUdnMGpU?=
 =?utf-8?B?SlpQbU9FSWV1Q2ZZbTZOTytoWmhHVnF3aHdaWlRQSEE4eDhSaTNCTjhoU2VH?=
 =?utf-8?B?MlQrRG1ZL0NmUUR0MjZSWFVQZjNXMHMvb09raytjaTE5Qm93SW9OampwbEFy?=
 =?utf-8?B?cnVPdlU2QkFRUGxZcHhNdkRtaTBjbU5WQWk1UDBKbzVCUkl0N3NhT1AySllC?=
 =?utf-8?B?UER3SUl6QXRqK3VDYW1vaEtJaWNTa2lOUUZmTHNxQmpVMnVmaFI3NW8xaGdm?=
 =?utf-8?B?SXhMOUI2V3haU2FXZWVyamU3S3pZcHI3MzBxMys0cTh2MGpQcERLZmJyckc0?=
 =?utf-8?B?T3UzaHN4UGQ3K1lPQmdGUUN3cG1uQ3dzUldxODNCY1dnR0VMY0F2cGVuU3N6?=
 =?utf-8?B?QlpyekV2S2N4U2JRRE04OHlIYk5YRTM3WENBaloxU2VoT2xIN2lQa01sU2JN?=
 =?utf-8?B?N3k0QkNoa2NjeW12MFJIRExxRXpPNG40eld4V3dTZ2FaVVFmZGNzd3BNYXV0?=
 =?utf-8?B?cjlraE5nUVJUOEgyUWlQUllONWIxTjBBTm9kK3F3UEZpTERjR095M3EvVHhU?=
 =?utf-8?B?aEhjN2h0dmxkN3UwcGJZQXlhdExKSHNjWHlTQVJ6OEYrSmltb1JQaEQrTE05?=
 =?utf-8?B?Mmdnd3FzMXRYMHlqNzdnbHdLQlF0TXFia2lDMUhOQWRGdy9hd01wWTlpcTNh?=
 =?utf-8?B?MERTbDU0d2R2dlZWM2h1NGlnQWhhcUlkMVc4MVJDSjlsSE9rcEhJQ01mV3Bu?=
 =?utf-8?B?bURFL1FudG1QdnNLU2RTRjFCdUs4cmlQRFhQdmxWejdsQUVtamFubm5Zc01x?=
 =?utf-8?B?S3l0cEMyOHJScVRrVjBUV1hSczM5Zk0xNHlSbnQxczJlaFZpKzhwcEF6ZHlm?=
 =?utf-8?B?THNUeDhmeVBhZjA1NGRNRXFuREExbTBRTG9reG9BdUwwWGl6WU96V25FUjlS?=
 =?utf-8?B?Y2RPTlRIdHloS3gwaWozODgySElhQUl5amJyS25aQUVPS1N2a1VRRklKTWJH?=
 =?utf-8?B?OVlqQVVYU0p2di9uOTRLNmlObDBoTzdYdGptWG9nZ0xJZSt6cjNvSXJhcjVs?=
 =?utf-8?B?UjFBZjI5Qmw1cWNIWGM4a0kvNTVuSWJ2QXl4Um5OUHVWR1d3Mm1QZGFMR3Rw?=
 =?utf-8?B?d3MzN1hzdVRaSW44WEpDaVpJVWd5RW5yZmFkejY4MlkwaTQ5WEsvNlIyVmx5?=
 =?utf-8?B?M0hJOW5RREp1YkxONzhMR0xVOFZoL3JHTm10UXRUTmIrck5nSVhtU3A5b0lD?=
 =?utf-8?B?MW5rLzQ4MXFuQkNmUU9wSjdyOXJTR0Z4RlJFS20yYnBvKy9mdnBITklGd3pT?=
 =?utf-8?B?RTZydDJzL1c5VGpBRnZaeXhieE8yQzZKSjFRWno3UWNUaVNMTmllcU02ZmhT?=
 =?utf-8?B?WCtMdkZyVUYxQldGdzB5d1E3Mi9GZWFsQ093REwzRXh0cnZ4WmxNdXl0QlM1?=
 =?utf-8?B?TTVrS1RRZ2dYMDI3dFZLdDAxTkVSZTVNREFScG1Uc0x3cE9OWFN0R1dRa2tj?=
 =?utf-8?B?dngyd1RTbHNVWDVuWW9yZmJJbW9xZHpQQTU1eFpQM3pZTmpaTjBiQ0xlS0tz?=
 =?utf-8?B?Z0d6eWx4Vzkxa1hlZmdiS0FQNUhPajNJcEtnR1gvSEkveHAwRVUyS3dVQkxE?=
 =?utf-8?B?WFVxdFgxTkkzbTB0dGJtZE0xQUliOEoxL0EyakpFRFN3eUhpU2pyZnhLSFNv?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8935f1-c6b5-41e0-8a12-08dda1ce4de6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 12:09:20.0197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wAV+K2OScKBuFalNw3ALo6gXPWhG8/LGBBqz3i6AfadwEKTnbzyi6pbzLEbgeJAhg1k2Gq8RjNpspwZxlN13QF9gGU8V5wjVSkgSrLMSGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10691
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

Hi Mayuresh,

On 5/29/25 5:30 AM, Mayuresh Chitale wrote:
> This reverts commit 37b0b22d8b7bbed6aa95b6daed06dcbf4a66f211 as
> discussed in [1].
> 
> [1] https://lists.denx.de/pipermail/u-boot/2025-May/590841.html
> 

I would recommend to add a little bit of context instead of simply 
pointing at some mail (which also is only Tom saying it's fine to revert 
as people shouldn't have shipped anything with this patch, not the 
reasons for reverting it). Also because links notoriously disappears or 
get broken (though I do have faith lists.denx.de is probably here to 
stay :) ).

Same remark for the other patches. No other feedback from me, I'm not 
involved with RISC-V architecture.

Cheers,
Quentin
