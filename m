Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EDFC369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43BC183253;
	Fri, 18 Apr 2025 15:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mk3n2a2K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA2683264; Fri, 18 Apr 2025 15:52:33 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CFF58328D
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StsW0dM+Aw0kOopOBUXIjBjmvA4stdi4yEu2Ce849CGwY0oUKrxJ7w/VX5CxXlOnJkIdlb0yHws7ChWjcYl9Ss6uve27itidwcUwl7UCl5igCrmX/aj28ZVvyGoy/sKvXecEicIjlD5kxXXHec2o+Q907k5LbloBDgU2WSI7Fv6q24CFSWu8ZW+FA7E80seoDa3Q2wLot3mLtNbM177fOXSB1ghykVfnz/LrzIDnQFHYFFh0/1kuwOXRshOi4uVtsU2XZrIguNd61mrGHMorWLdXh7dO4E6oQW0VYpJFSv3AD8eNJlGltTVcBQ/W9XlGIzVZLlzjYXE9weaA/Oj+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKDs3WCVVuhhG8DdTPRXrCfgop82z6j1fDxX5DknOEc=;
 b=DF3ZlHlig8Rb3Bw2aCcOagZyo4ZX40WugKqGBy2t9sGgyZGsVG78ZIQ9NHXLUITbjLgimkEIeajssAhJ42nIhtdIrzKUUlG16VsThD0Zu1pjaL1JpGOOCY0rbVRAqPIl1VkU+bAUNEfZzf3ltXRvwF2a2MFBBOIUBNUZY7FV3gjOihzN6QnZ1E33ZKLNFkyV5IGBYG0t31QfDhOm/U4EUbs/uP4/qJk5btYaBp78rqB6cHmQiMPBYtygGbwKbtesU9+MJYQVVA/AKb5/3qvtIfT13U9ebiQckqpzg93LfGZGG9dEJf2Af1D7DMyIGXsY+6uOUG4smLbqi/Yd2Z3/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKDs3WCVVuhhG8DdTPRXrCfgop82z6j1fDxX5DknOEc=;
 b=mk3n2a2KYRy+iT+9CZo+2v6ooJOFni3uX11GGC8g9FioegSF20C3rJeeIhek8RYkxj/NqEXtMgEgvIo7kAlduWPT4sHIO9aP6fp292Vr/qRjyqatTNMSUKZGsaa/dP81LsCkmDS3Wn89DxeBcFiTFsuz8zOh2Wa9WS8zKiy2EZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA1PR04MB10359.eurprd04.prod.outlook.com (2603:10a6:102:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 13:52:30 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 13:52:30 +0000
Message-ID: <3148f171-8bf5-4412-97d4-684c6c456499@cherry.de>
Date: Fri, 18 Apr 2025 15:52:26 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 1/3] buildman: allow specifying configuration fragments
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
 <d8f9a58a-10cd-4366-bd6f-85f4effc747c@cherry.de>
 <CAFLszThDLbf3fQySO_8u6OD3-BK2abE6NFVhvviRtrNs=PKdsA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFLszThDLbf3fQySO_8u6OD3-BK2abE6NFVhvviRtrNs=PKdsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA1PR04MB10359:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ddf3d8-c237-451a-6953-08dd7e8042db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djk4Mm11K0E2eElPRjZWU3ZqN1VVZWRycThRcUEzakYxd0N0aUZSUzBac20y?=
 =?utf-8?B?YUMyYW9ETEZxR1RmQTh5cGN1bjY4VTUvcHhpTFNuUHVFbEJZN2Q0WFRDWU1n?=
 =?utf-8?B?eVBJazlLa0owajdneWVkS29BSzdGYVdUeW1yQUR3ZW4raXVOWVdYd1krSEVw?=
 =?utf-8?B?TWJ1c1BrQVVKdTNKWDUwQWJZSmRGVllmQmIyNU9JclFpb0VuMlFLT2pPbGU1?=
 =?utf-8?B?dzRlMlF3M0Q1T0NFY0E4YmpqK1ExeFUwdzRCbEtlODNJTGJoK2NqRTFSdjk2?=
 =?utf-8?B?M0hEaVFzUGxUMTVqSDhzQnlSM2dTRnJsWWxLQUs3WGxDbEdZNTg5Lys5VXNZ?=
 =?utf-8?B?T3FpWkhvRjFxbVJDRnlNR3prLzZNMDFSMVd6aWhYQWJCUDNzNWpLOFg4NjNN?=
 =?utf-8?B?R3IrYmNzbHBRcWVSM1cydDR1YUo0Ti9aSnI1M1dPMi9JOXdJMzVxNVJBMjlG?=
 =?utf-8?B?bE5OM2MxelVHRk5jd0xUSkJoRTFYUFFYZzJCKzMzaHFYNlpuaVlWbHBlMDVx?=
 =?utf-8?B?WEtwenRUempmY2ZJQnVRU2R4M29VYlV1cU1BWFZIbExyUjdsQm1NSnh6YVkv?=
 =?utf-8?B?YjV6RnNXbnVCVjNUY2lRcTFGVWFnL1oxVGNqYmlPa2tMUzQ2NXFSaUJ5anlO?=
 =?utf-8?B?bjNFYVh6Y1l4ZXV5UzJMRjlIWVpBYWFwVktOeUdyR0xLZEpaQ2ZsZ0xTOTNU?=
 =?utf-8?B?Mk9uaFl6SWVSdks3cnV5R2dJNDhDOGpyZGR0dlpOTHN5TS9KOTVmYmFCTE9Z?=
 =?utf-8?B?TzNBRlFRcWVqNXUyc0dhVjlEeitDNzNaMkNOUFBQUGI4OGp3NjJrb0x3UFB1?=
 =?utf-8?B?OVdjT0t4Vjc0UU9lMkFPMmgzRnV0cVpHOUxUKzlWTlJxRTJmcllvQTFwSnFB?=
 =?utf-8?B?cG0rNEtQVVNEcXpyeXhRTXZ2ZkVWTkxhRlpOTjd5SVNFL3k5ZVdQV3Z0RzhG?=
 =?utf-8?B?SktrU1FWcDBUV0dXWm15OC9wSEdqdU5RSGxJcGFFY2lObHhENDkzRElNb3ly?=
 =?utf-8?B?Z1JFYXc4M0Qvd0hvMnlTRjcycjZzRjVWVmdTME5ZR2pqWVZxQW0rN2tyL1lq?=
 =?utf-8?B?NUNOQWhuc2VjRHhhdk1NaDd5SldEZVhpUU8zWWZwS0RJMjRNbG5oZm1zaFNT?=
 =?utf-8?B?N3JNRFpMNmJoN2dMcXgwU1dMeFdkVW9YZVFZV0l0R1BuSWxiSWFKVDFEWGp6?=
 =?utf-8?B?MEwwaXpYZFYwd01scUpJZjhYakV2TGQwTEFxSkJZd1dzZC9nT25FUlZTWHkw?=
 =?utf-8?B?NEhIdTg2ZWpTb0dXMkdUV2lKdGJCbGtFSUFOaUo5anZWUnJlalBHWU5Dck1u?=
 =?utf-8?B?dXdzYzlYMnJJUytNTjZubjlMMmJ2RE5mTWFjZUExWDVtcmRzbmt5Y1BuVUto?=
 =?utf-8?B?a3lBRUNId2YwRjArWmZqZ05DbDlsY3VrNHg3cUFnQklYNnpDWVVycnRwMFdW?=
 =?utf-8?B?dDhZMlRuSmc5dE95VW5SSm9hV2J3K1I4MXZ2MmVoUFBlcGpwYzMyalJtVmJ5?=
 =?utf-8?B?Z2lHZmUreXlYQUtjUk1Rc1lQMXhRbk1BcG8zT3ZVMTUwY3R5d3drSjBtNXR3?=
 =?utf-8?B?dWNteVdLL2pzNW9ueUVITDcyRktzNFk2RzJPeWlwT2UrU1Z5NnROeFNpajZo?=
 =?utf-8?B?RmlxWGtSWDZLQzNwMkZLOTNIS0RIRkNVQ0o4cEV5VkNGNy96ZFBwSUhEOTZu?=
 =?utf-8?B?cmVhRC9Ib01aOSs1c2EvMGlBSFhKR3V1MXBKVzQ5N2t3elB6aE8zUEhDcDZI?=
 =?utf-8?B?QXoyZXE5b2pjTEpSQ0xXRTBjZzZjVnMyZHdTSEVlNnpKOUhyTDJycitFc1hw?=
 =?utf-8?B?QldVWjQ5aGpOcUZZdDdVNjA4aEpXWHZXZTBEOXVHZldEWktvOFk5NUZ1cmFa?=
 =?utf-8?B?M1Q2eFNlOFB5UjFJRDA0R056TzVwcjVBTTZaN2lJY0p1NUxTTmorVEhqank2?=
 =?utf-8?Q?N7Td7rJW4qU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVloWTM1RXdZK3QwYU5ud2ZMcVJXYWhBK0NVQnVabzUrTDBiN3M4aTV3WUg1?=
 =?utf-8?B?OFM4QU4rWWVMdUFXVmlObUY3WFczK055b1JBNlQ3TTlMdmtVWTZBY0hCdUdB?=
 =?utf-8?B?dkhmTDNiMldKSkp5UkVxUlZsb1MvaTNXTFFGNWVZeG9teURrZE9XTFVRcHMx?=
 =?utf-8?B?NFJrNHY3TVlwMFh0bjA0MUU5SGVLaE42UkZBMk9SdWpSaDlDTnVFcDRGOHhq?=
 =?utf-8?B?QThqc0xjRmxTWGZwRTZvdWJ6UkRkb3pVTE9WS2k1dVYwSStBWExaMVhjK2Vz?=
 =?utf-8?B?MEVuMmZCdjhqdXVKOCtJNUdtYjkrTEI2RysxNms3NHRPbjIwVUNnbmc0NXZp?=
 =?utf-8?B?TURFSEwreE5DenBWNTluSGNZZWc3L1V5bndLaTFPU2RyMStsQXo3dDFZeklG?=
 =?utf-8?B?eHY3SjIvVHdNVHJDNXhJZVk0Si81aFVYZG5oNngyNlpHSS93VitPU3ZubUFN?=
 =?utf-8?B?ZDRQNS9lcDh3ZmdHMW1uSkdsMmlqU0MrcTRyYURXd2hCMHFYcnM2QUJnT2ZX?=
 =?utf-8?B?b1FIdjQ2TWNjYTB6K0tPV1NkK3d2Q2FGemwxN3pkbWJ5N2g5dExkbzFEUlBa?=
 =?utf-8?B?OGl0b01DT1VMMG5Hd09xSGx2ZG11NEZqVGFTdW01S2pHNm1aUGZPc3YySG1Y?=
 =?utf-8?B?RG0vNUNrbk1sR2RoNWg5dUgvczcvcFZFNjRmV1E3RXdjWWVVT2puZVE5UlFS?=
 =?utf-8?B?dmdaL2o3SGNUZTdVaVFTMTdlQnZCOEJ4U1lVZmx3QmRVU0VXbWNiVHNBQUZD?=
 =?utf-8?B?LzBWWERIVWxrUy8zYWVhODNiUUpUTDNab2tTL1R0STVKMVJmd09OVWJ2V2Qr?=
 =?utf-8?B?L1Jpajc3OUJnWjR3a1c0Ty96VDgyS2JWK0ROK3RSZTJXYTlWWFNtOElocmlz?=
 =?utf-8?B?YWZ0SGF2QmFTc21rV2tudkVOUGJkVlVMYVVPbFdjd0U4Q1lxS1BBQXM4RVQ5?=
 =?utf-8?B?VkJDWVdHcktpcndUNVdYMkM4R1IwdkJXL085N1paa3BTcTBCUTZJK1dMUkJx?=
 =?utf-8?B?WWtqSzMxYW9aVGlHY01FWU85MGNMdkhuMXRRNHdZTnlKdU93MTMwMnhQVkhT?=
 =?utf-8?B?c3lYc0JBSHJVYTgwMmgyV0EyNUJQQ3lmb1k3dHJoT2VJdmUzMDRLZmN3Wlpj?=
 =?utf-8?B?UW4yaFZ1eEd3d28wUHB0THA1TUxKVUh0Nnp6REJ3RnVKMTE4QytoTWg4WmRO?=
 =?utf-8?B?VFQvRTZEN3cvYU11R0tmT2FPYk1BUjFxOW5BdzQ4cHdGQlNQZEhFQWhId0FY?=
 =?utf-8?B?eGZtMDd0V2pEUTBPWTNZVEtWN1Bxc1BsVkp2eDIxYk9sQWJxaFAwVnlBam9r?=
 =?utf-8?B?ZWU5Z3RZN3J0MWw3Y00zZEJua2N5VjY0ekM5RlI0Uzd3Q3RPNE90Tm9EVkR4?=
 =?utf-8?B?bHJLSzNSVm54SVdyNDkzVWJDTVhMVzhqNWg5aTdWNDJZeTFzZnNuOFR3Sjkr?=
 =?utf-8?B?L2NpU0FuVXFFLytpdzdnQTIwZi9QaG04Q1NXL2VrdVJWQnpHMCtJQkdzaDJF?=
 =?utf-8?B?SlN6Z2dmT3NnbEJGL0x1cEJaMlBJblNPTHBhazhRSjFJanJQSWs5bFVLQ3h0?=
 =?utf-8?B?Q2x0UWxwYnYwS09vcDhHdzFLZU40M3g5eGxEQWE5cnpxY0s3VWZUV2Nhb0ZP?=
 =?utf-8?B?RjdIR3ZNeFhWTVJrb0VOeUV1MVBTRHZjbkUrZ0x4RDJTTGt4N0dZM1ZBMUF3?=
 =?utf-8?B?b0NUYzlhclltb2Uvb1NiLzdERGJDL01FcjIwTzE1RE1nRzU2T0lIWCszYmhh?=
 =?utf-8?B?VDQrWXhVaGE4TFNhdHJLTmR3U0lCNE9NSHQxUWRGNUpBaDZmeDVtbUhueGlr?=
 =?utf-8?B?RkgvWVlTRzJBR3BrcS9UUjV6dG5LMzQ2WmxwMENRaVF5b1lyQVFmOUZsMG1G?=
 =?utf-8?B?MmV3U29BR1Z5ZEFQTC9ESjRZRC93UzdzYkJsN0JIMzJOc3VzTFplU1hvK1VP?=
 =?utf-8?B?cTlMVlpoQWdaeU1YeU1QSlg3T0pFZWp0T2lVdFJ5cXFLeFJMWDViMmpYUjJG?=
 =?utf-8?B?OEpvaGR6SVYyQk5jNHI2cmM0OHEvUlI5N2pFVENtT3A4d1ZBYTBVM1hpS0lS?=
 =?utf-8?B?eEIwYjZCalAzdDhBV1pFT3UyOHhtZ3ZQMUVMekIrblpJM1ZKMFdwM3dybHk1?=
 =?utf-8?B?MVRINjd0YzN5UWhKNTJxYzNGN0pYWnlESUJXQzB0aExMckNVdlZTaDFzdEVR?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ddf3d8-c237-451a-6953-08dd7e8042db
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 13:52:30.0351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vx4fYrek/HJkk0KmC9TSVvIikhiUZ7D5Yc8u/ejMznR34XzGpTxrMeTRiFJmxRhnyBUcbhmALkUxseLZ2jBDBdR/J4i6VJu4132LTY5vDgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10359
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

Hi Simon,

On 4/18/25 1:39 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Fri, 18 Apr 2025 at 05:27, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Heinrich,
>>
>> On 4/17/25 12:40 AM, Heinrich Schuchardt wrote:
>>> Currently we are no able to build with configuration fragments in our CI.
>>> With this patch buildman gets a new argument --fragments for passing a
>>> comma separated list of configuration fragments to add to the board
>>> defconfigs, e.g.
>>>
>>>       tools/buildman/buildman \
>>>       -o build \
>>>       -k qemu-riscv64_smode \
>>>       --fragments acpi.config
>>>
>>
>> What about using:
>>
>> --fragment acpi.config --fragment fragment2.config
>>
>> ?
> 
> Yes that could be useful. It would also allow wildcards, although the
> code would need to drop the config/ directory prefix. Also, I see that
> -z is available so perhaps that could be a (bad) short option?
> 

I really dislike short options, but whatever floats your boat :)

> Another idea would be to also allow specifying the fragment name
> without the '.config' suffix. Less to type.
> 

It's actually a fair point, we do already strip the _defconfig suffix, 
and it seems config fragments are necessarily suffixed by .config, so I 
believe this is fair.

Cheers,
Quentin
