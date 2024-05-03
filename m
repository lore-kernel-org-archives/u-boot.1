Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E06C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 16:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6FA188283;
	Fri,  3 May 2024 18:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="D1Xi/MyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CE3688285; Fri,  3 May 2024 18:26:11 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9108188282
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 18:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjNfGFDopItuNeS5Nk5eAkAnXny8PUCC2nwzoTEHz80VcUOyzKW1zE6wQeZ2AFsJrnGZk+sBPOKeURl5x67HyY8WcODRbazQYVQMxxizK0FVQE4pBUmSsc2rO1dGtdFt0GzRpAW28B6n17Vs7EgKSphd1Qm8TBpCjZoVGfWlAjQck/ss/wgXmQ4hHG6/AkqoIDl+cBPtTPS1M9lw/jcwICETgtMfAu0nmqRreKGbjn0UsCbvO7QNC1E7pgJs38AEzLboghLrbVIxDRsjCeTbV+LxH92s8mKa51bFibfyOXy4GADIGjpWGysimtjX4J+NntCZkqlDgUF2vcZLd9oN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcJUFmeq4xwTanrQNe9HbSJemAoS+ky+/zgAt8FaYBA=;
 b=XRdoCjLo+2xVaVQ+5NDcAET9p06tDk72l5cucel12FuNeAmbRbD073nhU35tNE717zpOs/QIVyj/Vggs5tFq0QpxrhNT9U0bZyUCtC/telOmmoZKjuhxkd495yq7krQq28IlYVFgkKSFfqiWkUSyxXgj40D0sLE33t5Laj8D9uHfEoO2mI4ji0iUOqQdzHwJJQ00xByTTCZhNqqlLtZvSMfZEXomTU7Vr4A70f2eKKE0ukaiLRJ1pZDTY9/HXx4g9vTWSe06vIu+dDf+FUZo43PKF8vzttI6zY7zd1aFSoI7qJDGr/miviPno6TDDGCfhn6O7YTlexAb42HKz63HpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcJUFmeq4xwTanrQNe9HbSJemAoS+ky+/zgAt8FaYBA=;
 b=D1Xi/MyTHQpVt5zD0DdbA9ZHKAmu0TAiaf7PMfA/3S1pa/lHMeK8f8RJ89Evmziod9iBLGT6zRaLxt7Dr0l8of8E110aaMnSAwzn4USxgiiDvowHJ5YHlf2jcOqyW9FiB0e0QX+jACogNe6TuPTUzsSzD7lnUVdYQyydw3kWs0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by PAWPR04MB9988.eurprd04.prod.outlook.com (2603:10a6:102:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Fri, 3 May
 2024 16:26:06 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 16:26:06 +0000
Message-ID: <f0e18185-d2da-4813-ae02-5725e0ee0a79@cherry.de>
Date: Fri, 3 May 2024 18:26:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] configs: rk3588-turing-rk1: disable SPI flash by
 default
To: Sam Edwards <cfsworks@gmail.com>, Joshua Riek <jjriek@verizon.net>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de,
 Florian Klink <flokli@flokli.de>
References: <20240502200729.77955-1-CFSworks@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240502200729.77955-1-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|PAWPR04MB9988:EE_
X-MS-Office365-Filtering-Correlation-Id: dae66160-5373-4837-d3ce-08dc6b8dbbf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUJDUVhPZW1MNkI3Z1pQSlhtSXJxM2tpZmhHY2J6SU1KNk0rMkFRV28yQUEy?=
 =?utf-8?B?UkI3MGdocGxWb1U0dzB3ckdkWXFQWUpqQ0Y5aFZYZXpkdUw0VENicDc4Q0ZB?=
 =?utf-8?B?alNzMnUveGMrZ3BOL3VleW54KzRMeU5wRzlWNkxHbU53ODcweG12Y1BZYXhj?=
 =?utf-8?B?Z25jN1BIYzhwWTlwMWpZZG9taTFTWlJ5YmNDNGhIaW5jQzFyODRTMEMySEZh?=
 =?utf-8?B?SjNIWTdjQjVSTDRGQnA5ZXFiNkxDSlc1OG5mNGxTeWY1SHU2NmZoblBFOTN4?=
 =?utf-8?B?a1RDdm9adk9kWVZoUlZRY0hYL0FwZHA0WDhhS25JdjF3M3I1QkVBMlVyUGJV?=
 =?utf-8?B?d2pwSmcxbXQzazI4VDEvZlczaW41WkVBaTkzRmE4aldCZGZySG5kWHlXcVA0?=
 =?utf-8?B?OFdiaTNtY2pXblJsSXM0TjQwcFlTTEdHYTc1MFV4Y09UN3kxN0VRTUg5VTNH?=
 =?utf-8?B?SW1iVThORFZnOWJHcS9GV2lQUzlIRDUwbkxYdVM5TFFDbTlnVmFqK0doVkV1?=
 =?utf-8?B?ZWFqWVZxU2NpNS95QXNYQXBycUkwcVNPTE5XZzVFVHZrdm1RTlFJYUR5UjBK?=
 =?utf-8?B?ZlFyZ0dNZ1dKNktMb2YzcjJNTm05QktLa0JEK0NZZG15cVBVdHNIWU5VQnNr?=
 =?utf-8?B?QklSTnBHTDNsZGdWeGxaZHg3ZmwvV05BaW9jQm5JVGo5YjVSZk1nUmhhNnhI?=
 =?utf-8?B?MzN4UjBEcG1lc3BNUHdRUHNKWlVveVM0VFhvUVN3MkVxZEJsbEVyV3VrMkFC?=
 =?utf-8?B?R3BLQVJ4ZXlXMTdpVWJRR3kxYkFrUDUzZXVwTWlkNGFvejc5U2hwQ3NUQmhz?=
 =?utf-8?B?QjllVWY2WDZ5WDMxczRzZXRWbUVzSE03NENpelc1cGN2cUYyc05OWHYrS25V?=
 =?utf-8?B?MGg0aXlvMU5aUjFvTng5ZjYrZ3FmclpqZFlYYXhPTWJkSlRDTHRQTFZIcmho?=
 =?utf-8?B?ZkdFeEhRQWFSTGpTYnhUTWs1RHU5WmJmc1Fqb0RCNU8wb2FFaG9YSUhWRGRw?=
 =?utf-8?B?ODMzNU51dWZ2Qmk2ZXJDRU9Lc0EwTkxkeEdNL2RnYm9qZE5HT2VUYjh4N2Fs?=
 =?utf-8?B?Mm9oMUxMQ05MMjVxazJBYWwxeWtqUlZndGo3N054aFBwZFJzOGxBWHp4azE1?=
 =?utf-8?B?c1Jib0trU2hZUU05a1ZxZHBLVmkzdFdBQ3hlV1hjQm81RkJRV2lwTDlhaUg4?=
 =?utf-8?B?YXprZEw4NFZQTWNSWjdOaWhyL3pYd3lJTzRaakhDSXpoT2RkK3N5WG52NkZU?=
 =?utf-8?B?ck5qT1pFb29PSWxWVzBESzd4c0Q1aTNOdi9JakUzaC9pdHdKMnpadTU3RDlU?=
 =?utf-8?B?TXlyQ25obXhQUHN6ZVNDZXBmYXZOb3dscEFJSzA0UGZDc3VicGtSNUY3RFBy?=
 =?utf-8?B?NjkrcE5pUHhUeXFISVU4SWQ5ZG5TNzl6KzNjQzVDdFNmODdndmVHMDFxS0k0?=
 =?utf-8?B?cHhiVjk5VFR0b2hHVnhqaGc5a3hyOFFWL1dMUmM0VGdPTHR4S3RZZXF3K1hR?=
 =?utf-8?B?Ym9IMUVJMkMvVWhuZTEya1BwUHRsc3lpNVFSZ0s5eEtnRUJ6QzFCdHByVith?=
 =?utf-8?B?UzU5cHNOR3RjNjBGZDhyNytZZDc0QzlQZzJnemppZ09sa0l5ckxZY0xvWi9L?=
 =?utf-8?B?VW04S1hIdTVwdzg4UDNIREZ3MmhVY2RBNkNJYmNVZ0ZsaXJsRWNtbXNWTnNa?=
 =?utf-8?B?a1NqV0pSb08vYVpjR3ZveFRpUEZ3OXJlNmQyRzhLcWMzNi9jUUFvM3VnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTA2WmZERENhUnpPREo4QU40Vll3SzlhWVE0UWtYem5GdjBUb0p5Um11aEdV?=
 =?utf-8?B?MXJGMVRtZlE4cWhtVG9hbnpTRjdMbjh3L0tzMDlic3pJS3FreExZMER6bStF?=
 =?utf-8?B?OWQyU0ZobVd5eDdiaVRGbE5nbjBSR2RSQWFQWnEvdzNsUGdaK0hMb0p0aEFQ?=
 =?utf-8?B?Wk1hRy9ldFNyVEozYlNFaFNsR3dFVVZlNjBvbVNXVlZCRWhjRVlISmNEenZN?=
 =?utf-8?B?UEduYllEdktnNzcvRWtEbm1Vbmg5akI1eFdDQUZJbk9mVjlzSVFSMXZ2dWJj?=
 =?utf-8?B?Qk4wVHY2WTJhQUZVOFhZTDNKWklvTjE3V0haSjBRYk9Ga0txM205azR5N01j?=
 =?utf-8?B?RjRKamJzWjU3clRhaUF6MGdUYXBTckQvSXU0bldleGhsQ1NDSWhsNGREc1Ex?=
 =?utf-8?B?NGRXREljS0JycDRkdVluYkZnbFZsRDRPdjA2UkcvYTVoa3Z6VUZ5VmoxUHd1?=
 =?utf-8?B?VkpnbVgzRnpWdzdTS1hjVld2S2hCd1JBUUhuZ2M2MWRXT2xpcWFMejgySG9J?=
 =?utf-8?B?ZTdIT3dCRkRpaDVRakpFSDhqV0JQYUZ6UWVTNnQwUFJubmRlVzhSNDl2SkxE?=
 =?utf-8?B?SSs2TWxNUHgvMExKdmdxQ0wzeDZGVEpuSW1Mb2Fjc3p4ckIzWndaK2g0ZktP?=
 =?utf-8?B?VXB3bnFabHp2Tjd5amR4UTczejIyd3J6UXFRd1lSNXlneWJzcnRaODJOSHV0?=
 =?utf-8?B?Wk5WZmxsNXVVd1pzSWpXSnpnVGZ0VVh6eWdjQTJScDNpbGNjbWF5YWtyazN2?=
 =?utf-8?B?SzVHeDRjMWQ0TUxHVW9SbEwzQ3pZZmdsQUdlQXdpbGlqQWVNRkRha0JwTHFD?=
 =?utf-8?B?WTNRS2plRjd0bkMwQndKUnEyQjBKMzdSSGw3Z01PQlpXdG5LTEtBNUx3QzhR?=
 =?utf-8?B?K1poeVVvU1IwYkpnajNDQy9pdFlpeGJ2d3diSUg2TXJtYllZd1BBTHIyeHo3?=
 =?utf-8?B?UXd1Q0doZGREMjd1RVNYK3l0Vk1MMGxnQjFHdTZiMGtmYjJhOWE2bkt1SXpR?=
 =?utf-8?B?UVI3S1c2eGgzaGpkN2lWdXZkMldKSThXaithTVFlTjk4K3Z6Q1dxR0tIa3dk?=
 =?utf-8?B?ZlVBR2hHZTFMRmU4SkdFM1Nac0c2bXAvaXl4OFYvM21VZnQ0YXRRdk9OUEpk?=
 =?utf-8?B?bzd3c1ZjWDRrbTZ2OFJ1ZUxNdnZ5Szk3TUw2c3VJWDBIVkZpREMxbDQyRHNI?=
 =?utf-8?B?RTBnZEpRTWdwVXdOUVY1K3dENEN6NTRpU0I2Q2FQdVp0T2ppNjgvQW5ocXhD?=
 =?utf-8?B?U3BHSU55eTBCMHM1ekJjUis2Y0JNRFFtN2l6cHVWVHk1QitYeUlURHN2Slgw?=
 =?utf-8?B?eklHam1xd256dTVhMEF0NitnMWt5Tkl2c1dBQVVTNjRRejZyeURBWXBtWmVs?=
 =?utf-8?B?V3V0NU5LTlBpajdyeEJoK0JWVkcrLzJ1VC9VcWJsa2RMOTdnc0E4aVVaSUVM?=
 =?utf-8?B?TGF5RldQUk1Mc01UZFlqVFNMZElGMHgwL3p3SVFFYTkya0FQa3RrUDhtekJ2?=
 =?utf-8?B?ZEdFclpyY2d4Q2hZU0s1L1J3ZTZBTWlnYVZ1K2NSdWNEK0dVMU9aVjd5ZXhs?=
 =?utf-8?B?czB3dG5OeGkvQzQwUVlEYjdWN3NjUkZFOW1Ld2RLSDVHVkQ2L1ZBVjB0MHhT?=
 =?utf-8?B?a1FkQm1MbGoyOHR4eE1iZm1SZ3QvbzhEeDJURFBuTEVhWDcvYUhGNzNEaHZK?=
 =?utf-8?B?UVlaN2NsRTNpS0NNOUU2YmkxbG13Tlo0TFkzc1ZhOTFMQWxZa2gzLzZBYVV4?=
 =?utf-8?B?Q3RkNERWTHlnNkREWHFqSG9BemVmczROU2pHc2cwdkJMM2t0cjl3aWJsYURx?=
 =?utf-8?B?eW5kQ21YNjdIdEVZQmtmbW51V25CWVZsNnZ3V2F5K3RtWHhnSnBJR2txQUhJ?=
 =?utf-8?B?cEtpSHNuMEFqYkNORC9nOW9RdEFMVEdSVU5MRkhoVndXUDU3L3F0VlZFTUYv?=
 =?utf-8?B?eWdBNFR2cDM4M04zYXRDTTM5alJjdWpyUGRmRXYrUDFNV3JVZ0IwcHVyK1A1?=
 =?utf-8?B?ZkMvQWpiM0lBY1hvZmZNR3pGbmR3eXJBdTdGS3JET3ZPZFUxOG01K21IQncx?=
 =?utf-8?B?ZTZ6a2FrZEkwM0d6UDBsbHhnVkY4TEx1ODQxRkxGdURJNlozbzRpb2IwcFFp?=
 =?utf-8?B?c3VNd2x3Z1VNRC82WnVYTWFOMG5tWkZramFGYmNZd2ptQjNldEEwT1V1VExM?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dae66160-5373-4837-d3ce-08dc6b8dbbf4
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 16:26:06.9152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTQ+humcEoOmeA6ppqVwghtP1ockS97NTyKOMJa94nvUA2YdoQyg61uqh6ubwSFkaOQpaP8Rav60pVFzMsmfYsVgLAz0nlJ78BHie6dfTME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9988
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

Hi Sam,

On 5/2/24 10:07 PM, Sam Edwards wrote:
> While the Turing RK1 board has a pad on the PCB for SPI flash, it is
> not populated at the factory: supporting SPI flash boot is a user
> modification, not an out-of-the-box feature. The defconfig for this
> board should therefore not be enabling the SPI flash image nor SPI
> support in the SPL, as it causes confusion among downstream users as to
> whether the SPI image needs to be distributed.
> 
> Fixes: 153ac950a599 ("board: rockchip: Add the Turing RK1 SoM")
> Suggested-by: Florian Klink <flokli@flokli.de>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> Acked-by: Joshua Riek <jjriek@verizon.net>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed=by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks,
Quentin
