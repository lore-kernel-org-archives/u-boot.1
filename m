Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E584CC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 08:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03188829F5;
	Mon, 14 Jul 2025 10:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aWNP1vlb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E90BB82B07; Mon, 14 Jul 2025 10:57:12 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE16829F5
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 10:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOaXc2N1AAPs9ioFserfguNEzLqJ8er1p7MtcqYv/FC7nE3pJfRuMB9pTtBq37HoP9NyMltyfMQfRgn3rAumqYpA2lLOMwH6WzsvLwyRgytZyEHr15qTvOBzJj6RH54EVgqq28lW1qoRUI1iTi7IB91Ou8UFmHSe19s2ZXlSbYGTToPgpG0nkKa8VSIWMTfDObMHVqVgzmMd/vuo+yThP72vy+EEbPK7DnQxotpPaPYsGl1hnZ8p+HM/UAD63169MNIlxpOMmT6+Yvbyc5NZTcf5XWyG2x8Ok8GHAM2kwEzv16v/YGyGC+xbqEyj2aEvVMbNb8/+AO03bT6hz4Au0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIY4QhjhKAQuU8+Xc348iK+pEhqv7PXZ/6uMYzRf418=;
 b=To457MMUBQrWKDKF24suIdzAa3fVt5Md4zVI7nMM5JRjv6v0OJG/kE8Nz+VKVAKRCSff5dfYdjWvLlXCpmmt3qGMOxmIEghlFwIXSX1NDvwwkEoCUuROoMrwrYo2kfO6kGHaI30BwhNOWQYWUL/Mis2V1+YU4eS+Ix1gLA+Z8ajMW7Aqgw/ucZvjhvufkYCaVUK2dY+EvAYEQ8Cy/8MTAgDUiC23FVJCSu+RtWAoEjv4NWDuggmGnbhV0mziZn8btKKX9yirgoJWv5Dwup7ggZrlgpvr+LuiBQaNbjJ8XUa+aqZ4meTWLB8QLncDn+NYIhJ84aXZuV3X7GpZuv6RVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIY4QhjhKAQuU8+Xc348iK+pEhqv7PXZ/6uMYzRf418=;
 b=aWNP1vlbsL47lAMyvZsMl8Oknn8in6xbjH5CtMmdmjvIM6BGwjGj/+gp4/4xVCS81yyHIZvaHlo0suklvJF4MrGU289OW3j9r6tkOgE7oH4KAA4T4j9chs34srVFql2v9f5dwGGUe02Ya/k2g6IrkG1UU85Xp+2H9kDAkimFNGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 08:57:00 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 08:57:00 +0000
Message-ID: <188f74b4-be61-4e91-a243-6f5c7fc878ea@cherry.de>
Date: Mon, 14 Jul 2025 10:56:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] env: mmc: specify that the address is a block address
 when erasing
To: E Shattow <e@freeshell.de>, Quentin Schulz <foss+uboot@0leil.net>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250627-env-mmc-erase-blk-v1-1-d4b8fa90f68b@cherry.de>
 <fa087253-3804-4db7-9b4a-49b9a51e4968@freeshell.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <fa087253-3804-4db7-9b4a-49b9a51e4968@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0076.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::29) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bcb8d6b-3511-4751-9fb3-08ddc2b46480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3lJZWNzaXhBVjlreGRvTU8vaXZVQitGalplM25xS0lsV2dJbVFNVURCRUUr?=
 =?utf-8?B?RjdJZFRuSDFtS04vTCtiSkFNdTJYMkxLRTFOSEo0bzQzVElsRVRMVTNDbkRN?=
 =?utf-8?B?bFBna0xweUhSY3p4bFlnUzNnY1RIQkdXT1JRVHZDaG93ejdkc2N0RkpSOThE?=
 =?utf-8?B?TkhGSWlnNllVdUxUdWdWcUlvdFJwbGRoQnNlSHhXWXJNbFpEK21nYWZtU3Zz?=
 =?utf-8?B?SWEvaTBtcllhN2w3eVYvM2pLd3MveTIyZHBJN1BaTjhwMXdId0dWb3VYNWNp?=
 =?utf-8?B?dWx1dE10MEluVzNLNEFDTTMzYmkwanJBOWVYd1JDb2Frc3M2VWZJaXk2cVNT?=
 =?utf-8?B?M1hpOU5Ma29HSit2eFhHRVU2aEdtOXBUUWNQYk9XeURLeTZsUUlWNVdscDdl?=
 =?utf-8?B?Tmd4bFhleW8wRjY5d0JxenZ5ZlQ5SDlSUVFBM1FrRTVrZlBlTFRVbGx4NTVO?=
 =?utf-8?B?QTE5R3IyV08zZGdWSW9icExuRkJDQmdxOVFFaGNQWFVEWGljV242VXNFZDNw?=
 =?utf-8?B?Yk5ZS0E4MHNSQ2JabmdqSUxDRlZrUFBNWFo2dXUwYUhOd0dFdkRtNy9IOWlB?=
 =?utf-8?B?MjdZcllvMjBmdHIvS1RhVTIrU1pTbmZhVFlMdHBZZFdIZ2JuenY4bTNadUVo?=
 =?utf-8?B?T0xTdloxOEM1Q0hyRjl5TXVkVFhlUC9kSXFJa0hFQlpUaytQTmtxS2J4NjA2?=
 =?utf-8?B?N29pL05rOVlOZ0tNMFNKMDBIQkJGaGxBVnArSnh3SEdoMjhLVU5hY1pvb1dp?=
 =?utf-8?B?Z0syRmdPbkw2K201YmU5U1poWGRqTlhCWG9LOGxzMFJkV1UybFpWblZiVGJT?=
 =?utf-8?B?a3M4cFU1K0pEZVBPNUIweVJOaktkSHhoSGRCd0VIZ2V1NngxTGdPTkk2Um04?=
 =?utf-8?B?aFo4QmgrZWU3bFpPSklkNDBaaVBxdGJENmZxTG8wSW9SaUZUcGcrRTZDOElr?=
 =?utf-8?B?dkRiUFVkZllrTUpQUHpTUWdIaWhFZ1ZMM2llQ3MxT21WRktKV1RvU1RZTnZX?=
 =?utf-8?B?SHdCa24rZW9GWVlMSVlrMTNVTkNtdlNnZThPOE9OZVhDdnFMSFBYVlltMEd3?=
 =?utf-8?B?Z29TQ1A1bFFHZnVwOWVuWHZIR0tOWGV2aFNseHY3Q3R4MDRLM1o2d1lYZmJz?=
 =?utf-8?B?WFo5Smh0ZlRkRW1EVHNvUk9FMmJSN1RuSTFiZVh1YmxVcno2YjJqRkdoTUhI?=
 =?utf-8?B?dnY1NUdpMTFQYXgzcDN2bTJUMGxyeVNlRVFrVlltcHRTVzRvZjdpcmV3Tld1?=
 =?utf-8?B?ZzFNSU9HU01EUTI1UTNma2tRQ0lQSGhqMjhybkQrdU1WZUdyVllObzdTS2tw?=
 =?utf-8?B?S3g3dzgrQUIrMGJzWkRnUm1CckhyUkRVV0tVVW1zcjdQdHRObWxLOUwvQ05G?=
 =?utf-8?B?OWo3dWpoN1hEVS8zc1FSbDU2bHR1UmphWHp6VDV1eC9pNDV6bzR5dTRCbHdv?=
 =?utf-8?B?OWVhT2g1USsxUEVQQUg2cDJWZjZ4T0hNa2hlbHF5UGJxUTEwaThaTC8xRTdn?=
 =?utf-8?B?N25mQVFzZGlQQ2RVdkVqbU9oMFZZYjZWVWVBZXRQWGVZMlpzQjJrRUhhbnpI?=
 =?utf-8?B?RktqcGp5T1ZSczIzbjVHUXJBM0xUMGdTdmowOWJEMCtIbjA2U2xwc2JLSm9X?=
 =?utf-8?B?YjNqMlNvMitRYkIzQnBPTHQzWFU2ZWkzYUpmZHhQNkJOVVVkU1FBQTJvNHlE?=
 =?utf-8?B?c0hwdjgvNHRJOHNQOXQ2MjcvV0RkblU2UlFjWTcwSVE0QWltQjQ2M3ZZYmlm?=
 =?utf-8?B?RU1VRDB3ODhiZ2lDK2h2NVFta2JBaEFDcm82elVlczdLTm1vWkp3amFZZ2pE?=
 =?utf-8?B?MW9ueGFFUWZMUCtZRG4xWkRqM1h0TzU4b1Z6WTNHcjBEdlQxTE40TkVlTUo3?=
 =?utf-8?B?R0dnU3dNWU5ISXVOa285eUE5TXozQXhLM1kyVndyUUFRWGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0MwaUdQbjhQaitKZUZDdGFBR2NVa3ZEWWVxeXNmVSthQ0d6Z2JxS3FSVnZV?=
 =?utf-8?B?ZHdYQ29ET3N3UDhuN1hMa1ZUYVNnUU9yd3NJSitCUm51bVdaOTRUZkltdVRn?=
 =?utf-8?B?L3lRbUpXL1JWT0VVeWRWMytESENiZlNJZGxDakhmOTB4bHhNN2hwdVhJME1l?=
 =?utf-8?B?TnhWQkRodVlXQ2JjVEJ1ZG5wZlY1Zkd1MDRLTWdsQ2s0a204K1ZuL0U5Q0Ev?=
 =?utf-8?B?ZHJhbnNGNm1XNlJMMUlFVU9VWXVaVWRuK3VOL1EvTFdUTXppbk1raFREQmZG?=
 =?utf-8?B?dHZITVdlbmZ0ZnJtb091bUpoUU0wVlB2VjNzekpJYTVxS2E1a0VWNVQ0ZnNq?=
 =?utf-8?B?OVJYMGs4MnptK2diWHVZMHB3c0ZpQjFJM3RmaFE1aGlwVFBNRGNGeUt1S0hC?=
 =?utf-8?B?Nkl0TGJZaElUL2JrUE1zVXllNUx5ckliRmYzK0ZuVDRUTmhXU1J0N2hpd09V?=
 =?utf-8?B?SXpLYjVEV0dwY1VERXhja3ZXUG1TZFE1Z01pYjg5QWZ6T2N6ajVGbGRYVy9x?=
 =?utf-8?B?QmFnWjBnVE5OZEs0bzlubElwMnVNYnVEMk9La1FUR29hSmVYZnBNS0FRSURK?=
 =?utf-8?B?RFVPSlpFeUl4VUhzcVBGdE16ZDkxb0pCVWpYT3JVSm9JYlJHaEcyRHFGWFdr?=
 =?utf-8?B?TlkxaitBQ2JmVHZJcEFrNUlBNEFzSWcyNTNPRk1qcW9hLytoaEJQUkJiOGt2?=
 =?utf-8?B?TkQwTncyd2QxQ1JCWFhWSzJCYmwrOThXMkZRdnBEMWdTbWZCMkFadjJRUFVx?=
 =?utf-8?B?bzhOaEpxL05YQXNxWitJeXBHdUI3QmFVb1FNYnVqWkF3cmxEeXd1YklRK21t?=
 =?utf-8?B?N29ETWpWdFZBTFlualdUYzRDRkxMNDVsejZzUS9LYy9VdVR5ZXF1cTlBNy9L?=
 =?utf-8?B?MytKamZvbUFoTW1QZ0tlUUd6aUUrRWdFMWluckUrRVZ2aU5RTHBJNllFKzN5?=
 =?utf-8?B?Vk80UGFLSEUwRkdGNEhqSG5TczNkd0w4QTlTS3llNGZDdFJJVFBqbGVKcWhR?=
 =?utf-8?B?ZEFjR3o5WG1IS1Fmak5UQzNWWGZXMjB1eDArY0R4RVZjS1dvRTF0cUN2WStF?=
 =?utf-8?B?Nk16WjZQdkEzWmRPYmxpZ2U0aXc1eEo0aC9BNlBwckcvZXVpcDlXbWlXQ0dN?=
 =?utf-8?B?akx6bHdRL2QvV3gyQWR6NThqZFRtZGVlQXo1dmdqeitGUER3QnhJVU9QVzJU?=
 =?utf-8?B?T1o0R0hEZWw4aERCdmtiU0NlMU1KVlVzTHhhb3hOeTFvc0FuUlhqcjlhd0Vv?=
 =?utf-8?B?YzZvWkZDcmVGMS80VjN1NjBnWktXWWFxMnpYUVcxL2tMZXovY01hOXFJTUVs?=
 =?utf-8?B?RTdvNWNPTnhGRnJOUys5UlRvMzJnZFlmOXlqaktySy9GRDIyM0YySUozSlpI?=
 =?utf-8?B?V2xkbGhUVHJORmduNVliSVIzbUlkUmZTT1dubm1FRzU4aFRjWUVVa3IvVnlt?=
 =?utf-8?B?cmNXeFBQbWRlUElTdDlZVDRXZlJaa2s0QXl2UzFiVW5PRW5uNHkva0IwbUdv?=
 =?utf-8?B?ZitNdGg5cXN5bWlyMThXUXh5S0xTT2hIQi9zV3ByM1F2TXNuS3AvWlRmaXRa?=
 =?utf-8?B?OWY0OU1PaGpLd3kyT2t3UmxjZjkzdm0wS3c0WXZaS2ViT2twUmM5NGFmY3dz?=
 =?utf-8?B?VXFsN2Q0RW44Q0ppRGlXMTNSV1dNempubENNVHVUYTFsUjkxZHVIcjUzay9T?=
 =?utf-8?B?VzI2aU9tMEo0L2VsaVB0MEIrVWNqTmg1c2pBV0N6WlVWNkN0MjdQZ0ZxU0sv?=
 =?utf-8?B?MjZxckZxb1J4azBrd0ZaVFRNaURjSkJ1amhXcWx3RG5TWTFlS1VXRnp0MWZE?=
 =?utf-8?B?Yy9MU1dmczR4YmFIdmE5T1VvWkx0RzJseXNFOU9ocmhnb1BUcHJ2YTUwbUV4?=
 =?utf-8?B?SlA1TzZFWGduK3lTRXVSN3AyV0QyQjRQNXVsSVViTEpUbDY0a1N2Vlp1TmZH?=
 =?utf-8?B?NTN1SFl4MHhsRmhGVllONnhPazZqbm51eEVKZkpDNlBmMkUwYUp4ejBBUXZl?=
 =?utf-8?B?QWtOT2tzZmYrdXZXanNPam1FV2V3KzVaTnYyYnBSVGduWmlyazJnbVpqbk1H?=
 =?utf-8?B?MlY1WDNwNDZURENDUzE0MHJTZlZSL3BDaUlHQVV6Y3ZXaGR1RkFwKy9XTzlB?=
 =?utf-8?Q?aAT1ouK33LPH6J+FABGEUTcoI?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcb8d6b-3511-4751-9fb3-08ddc2b46480
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 08:57:00.3765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0cUn72xtfiNScR0xpR/RFVTl/57QIUvVHTbaSWmW6Iv99Zz1jGUnGYxtC4fM+KpbpvXq9Xa9WVy7UVDcG8MpKqRBqH1EEiKHmAn+ZIaOi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233
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

Hi E,

On 6/27/25 9:15 PM, E Shattow wrote:
> 
> 
> On 6/27/25 07:04, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> I got very confused by the address printed when erasing the environment
>> because I clearly didn't remember setting it at that location.
>>
>> It turns out, it's the block offset and not the byte offset that is
>> reported, so let's make this a bit more obvious to the user.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> Another option would be to report the byte offset by multiplying
>> blk_start by desc->blksz I guess. The result needs to be stored in a u64
>> though instead of uint otherwise we'll be limited to 4GiB offset (which
>> should be fine in most cases but eh).
>> ---
>>   env/mmc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/env/mmc.c b/env/mmc.c
>> index 8848371eb4f5df58da2be5398f159fdd0a00da21..f16926dc74c594b15f0bc82301aa89e1d4456d59 100644
>> --- a/env/mmc.c
>> +++ b/env/mmc.c
>> @@ -383,7 +383,7 @@ static inline int erase_env(struct mmc *mmc, unsigned long size,
>>   	blk_cnt = ALIGN(size, erase_size) / desc->blksz;
>>   
>>   	n = blk_derase(desc, blk_start, blk_cnt);
>> -	printf("%d blocks erased at 0x%x: %s\n", n, blk_start,
>> +	printf("%d blocks erased starting from block at 0x%x: %s\n", n, blk_start,
>>   	       (n == blk_cnt) ? "OK" : "ERROR");
>>   
>>   	return (n == blk_cnt) ? 0 : 1;
>>
>> ---
>> base-commit: 359e3012921f2fc2d43f3c4e320a752173f82b82
>> change-id: 20250627-env-mmc-erase-blk-7a46a3e63c78
>>
>> Best regards,
> 
> NAK. This is more text on the line and less readable; by doing this here

I can suggest "%d blocks erased from block 0x%x: %s\n" instead which I 
still find more helpful than what we currently have?

> and nowhere else the overall effect is adding to the confusion.
> 
> Look at this (topically related) snippet output:
> 
> "Bytes transferred = 534773760 (1fe00000 hex)
> 
> MMC read: dev # 0, block # 8355840, count 1044480 ... 1044480 blocks
> read: OK
> Total of 534773760 byte(s) were the same"
> 
> What units and packet lengths are these numbers? It's hopeless. All of

dev # 0 is the device number, it is unlikely you'll have more than 10 
MMC devices, so whether it's hex or dec base doesn't matter much as the 
value in both bases would be the same.

Block number doesn't contain any hex character, so I would assume that 
to be dec but as you rightfully reported, we have a mix of hex and dec 
values all over the code base with and without the 0x prefix to 
differentiate which is which. Nothing I can do about that though. MMC 
has a block size of 512B, considering the total transfer size in bytes 
is 534773760 which matches the decimal number in the Bytes transferred 
line, it is decimal and 1044480 is in decimal format as well since 
1044480 * 512 = 534773760.

I didn't read the code and got the information anyway, it's not great UX 
but aside from the block number, it should be fine?

> that output is garbage to me as the user, missing context required to
> make sense of it.  Adding word-qualifiers I suppose attempts to add
> clarity but the result lacks any meaning. The command which does get it
> right about hexadecimal v. decimal units does so with a displaying a
> literal word qualifier "hex" suffix, not consistent with what we're
> doing elsewhere.
> 

There's no consistency in U-Boot's code base AFAIK.

> I do agree with your premise that hex address locations and sizes, and
> block counts, are presented in a confusing mix-and-match to the user.
> Decimal numbering is the exception and not the rule but we somehow all
> decide that it's *not important* to make this obvious to the user who
> will have to input everything (except only some things, some times, but
> non-obviously) as hexadecimal. We insist on showing "0x" prefix but user
> input without this prefix is still considered as hexadecimal which is
> just terrible UX all around.
> 

Again, not consistent across the code base AFAIR, so it's even worse 
than that.

> Instead of this one patch in one place and nowhere else - I suggest to
> fix the problem which is U-Boot code base (and code style) has no
> discernible convention for documenting and displaying these outputs. I
> understand the technical limitations of decimal user input/output
> exceeding the memory type sizes, but...
> 
> 
> #1 rule: DO NOT show me decimal output while only accepting hexadecimal
> at input, it is ridiculous.
> 
> also #1 rule: Packet length not-equal-to-one? Display the packet length
> with the output.
> 
> Our consistency of units in both documentation and display of
> information is the problem - which I really do want to see resolved...
> can we?
> 

Anything that is displayed and not parsed should be ok, but then you'd 
have commands such as

u-boot> commandx bebe
Successfully did something with 48830

Is that really less confusing?

Also, what you are asking is to check and rewrite all printfs, log 
messages, etc... from all drivers, subsystems, commands, etc... which

1) isn't a small feat
2) would require all maintainers to agree on that (and a single one 
disagreeing would still make everything confusing enough as it would be 
rule for thee but not for me)

Also, this is entirely unrelated to this patch as I'm providing the unit 
of the value and not the base (which for once is explicit).

Cheers,
Quentin
