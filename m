Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24A0C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 09:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C15D80214;
	Thu, 16 Jan 2025 10:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ACxPKdC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0068B80283; Thu, 16 Jan 2025 10:21:42 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA73B801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nj6FmCUVtJxyaW+YOOjVR00bkMITwZxmAxpckAjc9z9mgZ5HZr8HVyesOoM/BGUWRsV+xA0kiD1f974XDoyrMq63enIA93lCo1H+coOgbEgxzd3DpL+uwLHzY3VgIFobdffE1LlqD1MWltRa7sHuT2Mtmwubf3av0a6NR6FLHPoAU59M7aTnTW8jVxg39+BCixWRy69aEUNWv0TMFu9GtoUBrrlgC/ApKKGWlQ23X2bDeENn3KoTcjoTh4h0KlAgQpWFJyPYJUvnuucQG0GWjzbgwUEYmFpvg/czJWqxHl7ersLN4YM/jePcUNWfSEprmm5glpt49RmZPzBed45wdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S6ySPoZApQ/6GDnDsHLFd5T8g4JJJLxV+VR/Vsbw44=;
 b=R8WkNX7BY5+egvfsjcn4O9dym1WTHvsLAzwLA8HLOZ5v4FR0dJxBsfsEv9NoGFuhFgTPGezS6nH0Ogt5U2BNW83Kit78WyBDb/FMmt5NzB78Tga86p62dvwC9tN8J8MyDWQutTBbgNjtjWdx9sf4acm4IdV9dWETGo00PXpetXzZ7AyhKBB6ojoeZIZfV7j7I3ZF63b+pPTSF4b6u6jDXB1QTVcg3Nsu1S9SCA3tXPl94FPByslo8S6sECpPE+x4kyFB9YX6x1N9K+l5jcmOqgeyAc89FyluvYyc7XPLSEYlqaMzVn+04X/FM+A72Y6ZV5Y6I7TSaARsXJ/WzuyyoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S6ySPoZApQ/6GDnDsHLFd5T8g4JJJLxV+VR/Vsbw44=;
 b=ACxPKdC67ndh5uagFBDdJeaNSrB/bi8xgU6fEt2M7/etwOImiVNA/P+4igBOmM2Zn2s82VFyfISfg1P3WWbjyN00lxhFW2MQH7WT80B6GisJvaz/ou6fxR7imPts29BB+hlgIFIRNbgXl96nRDZrkS20b2Y3C76Ol+rKKYYkXEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA2PR04MB10237.eurprd04.prod.outlook.com (2603:10a6:102:401::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 09:21:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Thu, 16 Jan 2025
 09:21:37 +0000
Message-ID: <240a9f89-2374-46eb-b780-a628c08e2a3e@cherry.de>
Date: Thu, 16 Jan 2025 10:21:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] block: Remove "select BLK" from non-block drivers
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-7-trini@konsulko.com>
 <2b3e1050-7cbe-4dde-a298-5efb63cb4ebd@cherry.de>
 <20250114165914.GN3476@bill-the-cat>
 <4cb564bb-8c0d-43bf-bd91-04668a1deab2@cherry.de>
 <20250115202029.GC3476@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250115202029.GC3476@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0236.eurprd08.prod.outlook.com
 (2603:10a6:802:15::45) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA2PR04MB10237:EE_
X-MS-Office365-Filtering-Correlation-Id: e7418139-0b3c-4ca9-0e63-08dd360f2d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkF1dVZVSXNRWVhJSk5OOFpyMG9iWlB5dEp3eEFscU5pQTJZc2g5OTRYdUpG?=
 =?utf-8?B?NDNkTWtYZnhRbVBxbGVsbFlDWVFpc2EwUEx2OWxtR3pnTm16QVNWNE1zcGl6?=
 =?utf-8?B?bjB3UnhNMHJiZGpOcHluZzFEUW1VUCtBSEUzOGxOUng0cnRPMjhNNnVvSUFv?=
 =?utf-8?B?TUxmWklER213WGgycEF6RzJzenVFVVNaL2FQS2Q4ZVlOYkZZbWZHV2RnNmR2?=
 =?utf-8?B?dGhWY2lTRnFqUUdzVFV6WVdVcGlHSVhvMnM3dFJPeXVQQjlPWU9lM01yeThn?=
 =?utf-8?B?NTlLM24xa00rdGl6TWkxdGxNUHBmUU02YTFXenRldW5kbVRrbnBsZlRaRHUr?=
 =?utf-8?B?NXc4VG9vWGxVYjdOMENxSUVPYTdlTTlHaXp5TmJxVHNWQ1Jyd1R2blJYaVJs?=
 =?utf-8?B?Qm5vWGYrbW9Bd2txYUdlZ1IvbjZHYm1DWXhPc0FJV2RneDQ2WVdpQUhoNUJW?=
 =?utf-8?B?ajRjTWExVnVwQ0dFeVlnSlV2bzBlR3o5WHlrOE44WkpseE42TjhpWDhYN0lt?=
 =?utf-8?B?SXRLbFg5S2EyVkh6VGFhZEFrMThjdjY5dkU5YndETEhNNC9RNi9XZzdsYUdN?=
 =?utf-8?B?TmozanFoZzQ2TXYvdnZCQkxQRHNsdmIvOEVWZGlaY0Z4WWZSRUxDSWkwRWRL?=
 =?utf-8?B?VGJqYXozbzlCcXhXait5MXVtSTdja0d1VzVXUFFPV2JFa1UyNHZXa2JwVnpo?=
 =?utf-8?B?VFcrVUI4M2ZibCtVL0NDbTN3L3RBRUtKakJHNmxrYmkxVVQwbUJ1N3ltSE5x?=
 =?utf-8?B?bFI0Vmp2b29sazMxM2M5TkJlRmVabk5kZUk2U3V6MVJzbS9DTGRpNHE4d0Jv?=
 =?utf-8?B?cHo0Wmd2NUZzRklZcnNkMkFrdS9HOVFoWVhTa3VSUmZ5ZTcyUDczYzc5MUVX?=
 =?utf-8?B?RHo0Q3M5N093cEpRaWFCNy93MlVCTjB2c1Y4U2hvS21SWVU5UFNtQzQ4akNv?=
 =?utf-8?B?bXZweHdBNFBiM2NlNlZxTDFFU0dxai9oeUF2K0ZXaGQzMFllQTF2eUM0Um4y?=
 =?utf-8?B?a0pIa2tsWWxMSHZrQXYxOElkaTgxRFd2WjhlSmJ5R3A0K3BpN09ObjBWbWZR?=
 =?utf-8?B?Y0FHN0dSNXlJb2RZaFFEeXpiRkpqbUFsSmoxL3I5VlJLZGlsWm14aEpkalN0?=
 =?utf-8?B?d3dZWmNzd0wvdDJkS2crMWpVK2JiOVZGUjFVNXpHWW8zL01JNHM3QTVteGNx?=
 =?utf-8?B?bXdCUEtiUGk1SWl5eWU0V0lHbzVEUFEvVk5ta3BOT0E3TEw0Z2tnR3ZRQmFU?=
 =?utf-8?B?bXJBYWh3TGUySG4vK3M1Vmcva05xYlBpU1paVjdLOUFwUnNWZzZwM1dPeGha?=
 =?utf-8?B?SDlaak8wY0tId1NrZ2dqa01YOVl3V01jbUY3L3JYOHg2VlJHemhaZkI2Y3JF?=
 =?utf-8?B?a2FjYVZyNi9NSXJKTUtzNXFkM3NJcU5uUjVySFg0ZHlOc3ZQTGF3eTdPVzl2?=
 =?utf-8?B?L2thcnJFc1Q3SXpRNXZkdi9heFVrMGtQS0luK3d2bEJ5a1FFdkl1RlZlVnl4?=
 =?utf-8?B?cGJmRFd5a3lDUXZhQU5ObE5KOXQ2aFNFVTFsUG53MTdiTG9HR1Z5OVc0ODdH?=
 =?utf-8?B?THBZNzZCYStIV3dOTkhOcVFmdE50bXdIUnhKUFRKRlA4Q1ZsdHJVeEo5ZzRO?=
 =?utf-8?B?blUrVHJyL2NMSkNIdWkvSk4zbkZsa3hqNzd0WFFRWDRpd2VjajU1Z0k1MktN?=
 =?utf-8?B?cFNxTVFZdUdBdGtjdjdaV0NRcC91YTRtbHI3Z1g4bFdQcmpBMDdhUzZTbEQy?=
 =?utf-8?B?REpsbWJ6OStYZVRITkQ5SW9wS0JER290UmFkUk5qbXFTWkpqM2RkY3hGb216?=
 =?utf-8?B?QWZHVE5ReVVFbGRlV2tHRVRlUWJBMUJoUm1PdWVMUzBXSmI0R1VoeG9xcDdk?=
 =?utf-8?Q?EIKHnG/RDE4pO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1c2TTZhdk1SemRYcTVzSy9Bb0JnZ1YwMTdHeHJzZjNETkM5cVdZdEhQVHpK?=
 =?utf-8?B?Qi9Nd01OMm9qNEhvekZrT0pyUXdIclNyOEgvMUhYaXJiSWh2UTdsaTVmbU5Y?=
 =?utf-8?B?elB1S3l0amVzRWV1c2hqUU8xZWpqWSt5Qyt5eUF1ZUdrRTNoWStrdUdMa0dO?=
 =?utf-8?B?WCsvVlRvQmdFN1ZJV3dmWTJreHJ1UWlqQlM0ZHF2VzdxZUZLM3ptQnBWSy9v?=
 =?utf-8?B?d3Ria0E1UFlCTnpYaCtrc2VoL0JQY05JaCs3Z1F0NmhrelMrRk5yVHRDMXZl?=
 =?utf-8?B?bFZQalk0MjBRcU0rMUZzeHlpM0dHOU5NQ2RsaWluUk9NMmVhVHdRNGZ4aDE2?=
 =?utf-8?B?eEE0UUtaUzE5S25TRzBrV2RxYVQxdGVxbXd5eXdrdWNyckU5TXJvTFhFbmxa?=
 =?utf-8?B?Ry82SlZTRUJhTXpOeDMySTJEaXJ4eHN1Y3NUM1RGdU1WZm1NY0RFSDdhb1J1?=
 =?utf-8?B?ZlZnTk9oNXJ0R1AxVW1JeUFnYTljbGc5Tks2NEJoL2tTdzJSUzlhOW5VZTVt?=
 =?utf-8?B?bTMxRFcxT05ub2ErVlhQTGtBRDM0QVhScGx1SmEzYWp3d0RleWFwYmhDajhD?=
 =?utf-8?B?WTgySktxYmFvenpIV000WWpud2EybGhqcmFYWW9Ta2tEcXZqVjhhSVhOZkh1?=
 =?utf-8?B?QTNjcVBsZXhMUWR4NVU2VE9WTWRtL2RUcnRad2IrandncXRDTlZGWldERG1I?=
 =?utf-8?B?ZkJsempmKzVrbHM4UnYzbWFhTnpXVEZEMlpNd1p6OXVJcW1FS1REa0M4UGcy?=
 =?utf-8?B?NFFEQVpIYm9xRHlsL0llK2sxN0VFeHBHZ1F4dWx1WWZTR2VFVmljODgzTlJn?=
 =?utf-8?B?RENSOGNpVkdZcndBNVpFODlNVnJlN3p3TVZTUXBZaldqRFdySXdyOWVtS1Nl?=
 =?utf-8?B?dmtuc0VNM3dMN3ZvRmdOMnRYSllRWG1RbkI3TFl6NmxwNk15RmlxZWxQdFpw?=
 =?utf-8?B?eCtDb252VHo1c2lYYXVnZUwrcmh0cFNGa0p1ODgxcXF4SnYrMFBETGlRMWRq?=
 =?utf-8?B?ZldxNVBJb3Vzdzh1OVhBc3pUSWZEanFZTTJXd0VZMzgzdWlLZG1Eek56Y0g4?=
 =?utf-8?B?N2tiNUlyT0YwYlpESWQwcndYK0JnMEZhdG5iamJzOGhyZ2o5ZUtJTkhhSDlz?=
 =?utf-8?B?K3dXejhmNDRrUUhLNGw5NWlXSE92eW9TV2FmU0ZTQkgwam5CYnpaN0U5NGJJ?=
 =?utf-8?B?c3M3KzAvcm1pNzFBZnFHb0FkQnBvQkh1eGF1akQza2gwa21UczlteHphaXdk?=
 =?utf-8?B?NlV2UXFhak5IcG9hZDY5cmJDUUVaazJLdGQyWFNYODcya2N4dTNVRG9PVk9Q?=
 =?utf-8?B?Z3VhbGNlTVR1L1JtSkMzN0dsV2FiZ2VpdkxoczFiUVRkclVYcHJwd2xWK29S?=
 =?utf-8?B?NU5xUVFNMTRqeTNCOUthV1M2aHowd3EvTGV1TEdPZHpHZ1NrdmFoYk83d3Ju?=
 =?utf-8?B?cG9HWG9Wclo2dTdoQ1VnVVU4YnFodjFRV1JOQ1JXUnF0NnIrTXBneVhwT0ZW?=
 =?utf-8?B?NFpkS0hBb1ZJSmpHbTBQQWN4K2wrL0MycDlad01maW1QRzZGczdIL0UxejA5?=
 =?utf-8?B?dC9SUkw2S0c0SVR4RTYyYndRSjlzeHBsSlhJUGpnbkRONG4rWi9xcVFIdGpW?=
 =?utf-8?B?aklCOERNSVpGQVNCUGVwVndFcmVscXhmbUlEMklUamJHNElZMDJYN3hPdVp1?=
 =?utf-8?B?Q29OSUc2UVh5bEQ2ZGFwR2Z5RllxdGE4aThaNE1zK1F6ZnRlcTEyTGxqTlBM?=
 =?utf-8?B?Zm1ZNkpIV3pXSXc4VXVmVjhwN1lJelhKRkk0TDRucG1yYThob21wUTBOZDJw?=
 =?utf-8?B?TDVNUHJPQXhzOTkvRklGa3cwTk82Y21qcVJpSEdQZERKblkreDhuUGl0M1Rh?=
 =?utf-8?B?bnI1MTlBYjdqMkJRbUJibmtCYklPSS9KNytNVlhHaUlJYVhnaHZiTjdWQS8x?=
 =?utf-8?B?QzhkRVVzZkE4ZGNBcU9xajdCbzJoazdibnpzM1RMQlhjMUd1dzI3TkdtS0J3?=
 =?utf-8?B?MzcyamFCVmdNelJGclNucU1rdnA0MnZ5SUdSSGxOZGJJUVh2UTFFRGVLZXF2?=
 =?utf-8?B?MEZLSkV0bG9EVlgwVksxbloybjdDZCsvRFJwYkRTaGxpTUdBVWlYaTVNdmRX?=
 =?utf-8?B?SnF0djZFQzZ2aStReG51a3hUQjdLRTFjaGR4V1I0SVc5RWxjZlQ3Nkd1dXB4?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e7418139-0b3c-4ca9-0e63-08dd360f2d60
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 09:21:37.7874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAdtTsWDo72pTzpnXl70U16tSWPgGwpO16ve8JdaibgXln7Xu+n5DCA0I+NELdIf6Vwj4eKI89WMLy6iEbHSB0Ucu1asQTkYQnMuFVvYmVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10237
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

Hi Tom,

On 1/15/25 9:20 PM, Tom Rini wrote:
> On Wed, Jan 15, 2025 at 06:49:45PM +0100, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 1/14/25 5:59 PM, Tom Rini wrote:
>>> On Tue, Jan 14, 2025 at 02:53:48PM +0100, Quentin Schulz wrote:
>>>> Hi Tom,
>>>>
>>>> On 12/20/24 11:22 PM, Tom Rini wrote:
>>>>> Now that block drivers are all selecting the BLK symbol, there's no need
>>>>> for other options to be select'ing BLK so that other required
>>>>> functionality can be enabled. Remove these places.
>>>>>
>>>>
>>>> We have multiple commands depending on the BLK symbol.
>>>
>>> Yes.
>>>
>>>> BOOTSTD also depends on it, but I assume we should be able to network boot
>>>> without HW block drivers?
>>>
>>> Correct. That's part of the motivation for this series (which I wasn't
>>> clear enough about on its own). Without something like this series if we
>>> remove the BLK dependency from BOOTSTD then some other platforms fail to
>>> build or grow a bunch in size (as BOOTSTD is default y and now it's
>>> enabled on those platforms).
>>>
>>>> CMD_UFETCH wouldn't be usable without those drivers as well.
>>>>
>>>> Should we do something about that by making them not depend on BLK e.g. use
>>>> CONFIG_IS_ENABLED in the right places? Not sure if all devicess based on
>>>> those archs have at least one HW block driver enabled. I guess checking if
>>>> all .config before and after that change are identical would help us figure
>>>> out if this could introduce a regression?
>>>
>>> There's a few options, depending on what the command is. For CMD_UFETCH
>>> it's likely that a small restructure would be needed to not try and
>>
>> My point is that I believe this patch is too hastily removing the select BLK
>> because some symbols have "depends on BLK" and by removing the select, we
>> make those symbols unselectable. This can cascade if other symbols depend on
>> those now unselectable symbols.
>>
>> Also, removing the select BLK from architecture/target symbols can introduce
>> regressions if BLK really is required?
>>
>> I think a reasonable (albeit cumbersome) solution is to migrate all those
>> selects to the impacted defconfigs so that effectively no change is made for
>> existing devices. If maintainers want to remove BLK, they could then do it
>> later.
>>
>> This also makes sure that BOOTSTD and CMD_UFETCH (and others) are still
>> enabled, since BLK would still be enabled, just from a different location.
>> Then another patch series could remove BOOTSTD dependency on BLK by adapting
>> the code, same for CMD_UFETCH (and others).
>>
>> Does this make sense? Am I missing something?
> 
> What you're missing, I believe, is that this patch exists because prior
> to the first patch in the series and also going back to when BLK was
> optional, if something higher level like ARCH_ROCKCHIP didn't select BLK
> then it wouldn't be able to prompt about its MMC driver. This is similar
> to all of the high level places that "select DM" as that used to be
> meaningful but now it's not. As part of testing the series I did my
> world build before/after and the only change is that as noted in the
> cover letter, espresso7420 now has MMC again. Does this help? Thanks.
> 

Please add this to the patch commit log as well. The cover letter 
content doesn't make it to the git history :)

But with the world build you've done, I'm now confident what I was 
worried about will not happen, therefore:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
