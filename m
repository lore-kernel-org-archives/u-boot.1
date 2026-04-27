Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2670FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AFDD83C14;
	Mon, 27 Apr 2026 14:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UEWdhqlo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E34BC83FDB; Mon, 27 Apr 2026 14:22:13 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B9580433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 14:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8Kp0e+VBnFwY9kTSeR+Xr7k/M656Pc38Otd0Ilx/4hy1XbM/r/6EPG3wSasTKP/OMKhvaEpoY9+Z9aIMgFzD0PZCWQZ4xyaDJ53Lg1gs6n7kzYDgGpLwMiQ0i7/M3HRCnu1SH+pZr1prM9EuoHM/KqkSYHvxBXHJ+VCvrfjbbHN2McHN4TiP+IN7Goi8ONEe8JWpNt8acBJDZbkWa6/rSRM9EGFAJEMDfiReMup5NM4So//53bAdIVnVUBDpQrCYL6hVEcTOE+mpiAtBdcAGx2wMyDq/kBR/x1/+TsWJXQqBAZ7KJH03I8Mo0rVAew4qP80GRw6ootMnk13gdz9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh55B0H1/9anFHifl9NnuH5Mzw02eM9vCQDCfpaUR7o=;
 b=BsFW8da42tL5ToZ0ToUBGXYbn1OGDCuhKygUYfZdn/Xpm8QadHGRgbvoyVn/2hdcMsPv9V2BoSqYHTG5TJ6Se69K1MifigYqgp4LIHHbMyy45r0VqHzy289n+hT/Rgnsp39AKahBJlqNbPkxaEkv7RSayYMm2FBAKii+bicEY6oBkw3kO33eollJ8tIvhdKbhS/4Se7iTHbaoBDpyb7vGc6FIe74JEcNEENbXGsbakowRVvN6BQOVOg/J+/oGzpH0+frvapqkLDwpFClepa/oPLXi6qkypN29SiSo7dLJMeGOG2v3Ynau3eKBwF+A0LU79uPR0gRAUmO2UTV80rUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh55B0H1/9anFHifl9NnuH5Mzw02eM9vCQDCfpaUR7o=;
 b=UEWdhqloV3U+iXdTshUrmpXFuME7X+S3oiN83mzLlYwUFYmncxgcd9dS8J1kxN/Lc/haxjv+buB8HL9DButEeP80yTHZmQIvckdrmzxYkPKAM4eajdxq6Nt+xbBPmPQZ/ygl5R51WF6msuaKt+31pXmB6fsuPgtdLnPbAgVSCIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DU0PR04MB9348.eurprd04.prod.outlook.com (2603:10a6:10:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 12:22:08 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 12:22:08 +0000
Message-ID: <5a27f1b5-c876-4daf-9394-ec1377ae3ee7@cherry.de>
Date: Mon, 27 Apr 2026 14:22:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fdtgrep: Add option to reserve free space in the output
 FDT
To: Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260422023131.2813748-1-sjg@chromium.org>
 <04536c1e-c732-4d55-a98d-c14acf2d8336@cherry.de>
 <7edd2c18-4f09-42c0-98be-1dfcb23b755b@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <7edd2c18-4f09-42c0-98be-1dfcb23b755b@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::11) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DU0PR04MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fd9ef6-0d76-4b5e-7f2b-08dea45799bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: D3T/C1zL9U9QVIw/Js0WIpNnrgiuFSe6u4gCmchIoVfQX3hwEN2FXG33P7hnQcWGts4uJChUid7r05JE48q+3Iu1uUUcY3y5xgxVZdpehYYbsBABY3Cfk7UPQq/pXh8l6GIrgMNg19PLO4MPaerPzys31fA4MNlMgdPkfbPSk6tZKjo6LCnbH9XpYCn/Um7wHiEXFnBqzniGfsRlVvhjaE6vbrkBWvsK1/7EnT4qeO+EFOgUYCZ7wsQhkTiLGIVqwJMCYOM1jpLzJHE2uxHK6lHYNXi9T0hZz/9l5wKDQfG5l0RQh+9s+hLptWvnxDe0b4oUF+sBGrbZ7dsMEcmTFOxz0ipFeRQObVeZJYuu7W8CrqyAKdhWRYzX9gv1sJSWnghfBhcPlymsM06RTYrkKkKxHwxX1lPYtSM9GqUjf5o23wJsLIv2srUmITVyU1jbG3U+1cveA3JIpuhPPqrTLdBdwEAzbE8cs2Rt1PV3bLDRxgaVNiLNG7ke4rKo3cWHNZiTZpXIdceSB2JE+3FL9nmKo5zUGDJDSFo6xdUPWF1K13sOc1iWKhQ87h8krOXdb6SJHjl19RCKg8pP8olxYZcc9ujHTD+8A/oQzveGP4mIu9STISCLKgy51+pZVO7kyxIfC11Cf/OcpBWjX1P+nExPbeqChhU1HzZgrjHjkPC+/rgV+wnTRAYKAdqpMgHIbHZjjqn2tonwlqlcdfsXE3TY/6yp5TyFB2zhayCxcmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzBaeHJwdFFid1hFOXFQbzIrZEFFZENsNFZqZFVBOE5kc2ZRTUdaejIxRGl3?=
 =?utf-8?B?UGlaZTdaenFMQ2dTUkhmMC9ocXo5b2crTXc2V2lQRkxjOXhrdW1TeWFNSXor?=
 =?utf-8?B?Nzl6UjBvcjJRMk5Hb1cyc05NclRiYzRSU29UZWV2VFUrQUxDczk2bmV1TjhM?=
 =?utf-8?B?cEhNUHExRVRBZ2JNZ3o4Uk1GSkUxdGJpdXkzODRZTDczU0hqcHhKY2ZLTUxL?=
 =?utf-8?B?L2dKVDlZTElTQjJZWXZyK3ZlZmN2QkMwNWhhUHllRHJTR0JQZFBmb1hwSm95?=
 =?utf-8?B?OU5OOGptdmlqM1Nud0VTQjdqRlUwd1ZzbDJIOXNzeFNHQ09tQjF6MDd3aGRO?=
 =?utf-8?B?VzliMHRhdThDd1pqeVVxVXdsL053Q2NiVUJ4Q0M1SGRNNk8yZGR5OG9NVHFZ?=
 =?utf-8?B?WEdFUzJnTlBWMmYzUTNwQlNiNkZZbU0rM0lTaWY3aFBwRDJDTVpDeTVxSU0w?=
 =?utf-8?B?RkpnNmxWZmJkWFlNMy9HanRUc0JPa0t4Rjk2Qjk4Y2gyV2NGbGZkdUhLZFV4?=
 =?utf-8?B?T2NlanZ0OGoyVk1JTnZ2Z2RhV3ZZMHBzVXhFSVRHVDJaa0g5djFQc3RiWkpT?=
 =?utf-8?B?LytuYlhRK3BGZklZU0daa2xnQVBvTUJtRGdobUp0VU9nL0w3ckNpMkhnYmFx?=
 =?utf-8?B?Zzk4U3NWK2E3ZlNmUU0wYzY2UTRVNlZ1WTVaekwzbUF1anpFRC9sckk2aFJ5?=
 =?utf-8?B?QUVuMXNmQVl1b1lKS0F1TTdCSGc3bnIvT1dYcmFVWHl3VUpJeHVPUGRCYk1D?=
 =?utf-8?B?V2RDVjI4MnJFN2ZVV2tvSksxTjRJaWd3blk1U0lhcUFWZFBITkxGbWtmYzB1?=
 =?utf-8?B?MFhuVlFrMURNNHhkY1dXUE04QUVTZDdWWEl2YXM2Tld6a3ZaTDg4L1JuOUlF?=
 =?utf-8?B?NDluMlJtSlVHc3RxYjVDR1pheUdZK2FxbGUrSklPWlM2Y3F5RnZnbW1yekU3?=
 =?utf-8?B?RCtGTXJDcWVNVjBoTEhIL2FOSDhTRS9ab0lnUisrSWU3RGpDYnRpSzFmOVZq?=
 =?utf-8?B?UkM4ZE1uanZNUWc4VlFXWEVtdFppazVLZTFiRUFLdUV6bys2R3ZkcmE5a1lh?=
 =?utf-8?B?ais1T1E5eUwyU0lLTVRrNXptUWZCRTI3S2w3ekthL3V6QTVQbjE3RGZlRk0v?=
 =?utf-8?B?VERBTW0vU0R1c2txWXF1cjFWODZvOGY3ZUVwQWo3YjlmdWJML2hSc01TVU5C?=
 =?utf-8?B?cGNHSDdMSmpDRmZwWk0wYzFuMjlHNVk3ZmErOVAvZ0JsZ0hOTFFjZW9CbHpL?=
 =?utf-8?B?QlFUQjAxdy80Y2lqVHZaM0Q2ZlhpL1huTWdrZGVTMHZpUExZZ2l4akppS29F?=
 =?utf-8?B?QlJFZkNxWVRwV2hZL0NFbVM1NS9DTkxhdUEvd3BOYk56NURNc1VIeG12S0dj?=
 =?utf-8?B?L2hicFlsemJLQ1d6RmRrWUhRWStHR0wyaGJnZ1FZOTl4L29GSUgvK2ZZdno5?=
 =?utf-8?B?TTBFcEU2UW1OSzk5eUMwNStZRHFTdjFLQ1pxMXhsaEhyNWtzSGRlRnp1OXZM?=
 =?utf-8?B?Y3BaZFluL1V2L0Y5amtQenJ3dnNuVXprby8wL3JFQjhKTnVRczMzdWdpREk1?=
 =?utf-8?B?cm1TZXpJVW95OWlOSmtOWWRZT0hEaU5zV1ZPNXowbU9xNmppQ01NeUV3M0tz?=
 =?utf-8?B?cmVhbWo5bm9HWXJQT2dkWGFYaGR6VjlobWNDSXg5VGowNCthb3R2NGl0ZGhZ?=
 =?utf-8?B?elBPSEdidFROd0tGRmU0U3NQUGpTMERibXpZeFVyQVpWdkJSZHMvc2xLcmdI?=
 =?utf-8?B?VlMyTVpZVDdISUxXaXAzemt6OWNsK1VXYVh1eG01enNCemR1bGJldWpZYzFl?=
 =?utf-8?B?SSs5U08rMUt4VFJheFVjaENhTXZxY1V2V3ByVDlHVUJEQ0FlSkU3Y0pMcFJk?=
 =?utf-8?B?SWNEUWJ3bmVCVXFhUTl0UXkreHlVQ1RqYW95dUE1UjlTeGtWZzg2YXl2bzAy?=
 =?utf-8?B?bTZZQ2NINWdmdnA3NEVMTk92WGhyaEtmNG0zeitxYkEyZExjWDhwakpWakZl?=
 =?utf-8?B?Qi9uZVE3TWp6SUI4STcrUU5DVGVodzh2ZTBGaDhQQWVENjZzTEVaY2w2aGdJ?=
 =?utf-8?B?dFQ3WHRPNHFWYjIyZmw2QllhL3hSbEl6ZHBHMkk4Q2ppY0JGanZlZDhzeWUx?=
 =?utf-8?B?UytFdWQwV1RUMTdacW1odmR0MlVWNklCQXovdmsxWFA4a1dVMFg1cmxzUXRo?=
 =?utf-8?B?U2U1MVF4Q3dXQXVjNDh3NUkvM3IremRRd2VKdjZoeUIyczlRTDYyeUM3QVFs?=
 =?utf-8?B?WCtIWDJQUHNvY2NZN2NlUmgxSVFYY2hIMXBQQU5yaW1ab1RMaDYvTHcwaGNs?=
 =?utf-8?B?THhtQnljaDJsNU5DeXMyZWNzaVJCeVNTM1ZCa1dkVS9Fa0xnQ01qRnZHS1ZR?=
 =?utf-8?Q?Wbc2DMuFKBMSfzWDhRqlhhdNTIDC/Q7syKRsX?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fd9ef6-0d76-4b5e-7f2b-08dea45799bb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 12:22:08.3332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBxHtm1M5WtTbuR4Tl48+2RJ+X15P2jfFPpghtG0ZfVWcfNc08V5EncCeltveQAeTMpHnZENztVCd7NN3FOcuxJOJp65KJMLDfcUVAfkyQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9348
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

Hi Marek,

On 4/27/26 12:11 PM, Marek Vasut wrote:
> On 4/27/26 11:13 AM, Quentin Schulz wrote:
>> Hi Simon, Marek,
>>
>> On 4/22/26 4:31 AM, Simon Glass wrote:
>>> When producing a DTB from fdtgrep, there is no way to reserve extra
>>> space so that more nodes/properties can be added at runtime without
>>> growing totalsize first.
>>>
>>
>> Ok but why is that an issue? What is the actual usecase? What I'm 
>> afraid of is that you pad enough and you hit random bugs because you 
>> forget that adding enough properties can now hit the size limit and 
>> you forgot to add the logic to resize/grow the fdt when it's too small 
>> to fit new properties.
> This is needed to prevent fdtgrep from inhibiting this and stripping the 
> pad bytes again:
> 
> scripts/Makefile.dts:DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
> 
> That ^ is used by early U-Boot stages in place of 'fdt resize' , it 
> provides enough space to add basic modifications to the DT at those stages.

It'd have been soooo nice to explain what CONFIG_SYS_DTC_PAD_BYTES is 
useful for. The default for arm64 is 4096 but it doesn't explain where 
it came from and if we can have more, or less and what's the impact on 
the system.

But ok, the commit log should be updated to add this additional piece of 
information (and also in the same series have whatever's going to use 
this new option). Something like "This is the counterpart to DTC_FLAGS 
+= -p $(CONFIG_SYS_DTC_PAD_BYTES) in scripts/Makefile.dts because xPL 
device trees are passed through fdtgrep which packs the DTB after 
stripping nodes and properties and therefore do not respect this for 
now. In the next commit(s), we'll make use of that new property such 
that xPL devices also respect that."

Now I'm wondering if we want the same value for xPL DTB padding as some 
systems are heavily size-constrained (and next stages may not allow 
enough space for storing the new DTB with that much padding; TF-A on 
Rockchip for example was notorious for only allowing very small DTBs).

Cheers,
Quentin
