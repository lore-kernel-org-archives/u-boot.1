Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD90BC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 12:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3248D8122F;
	Mon, 24 Mar 2025 13:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="L7vjF5Sk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C0E78122F; Mon, 24 Mar 2025 13:50:27 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6F2C80107
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 13:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNHJES588qPkPxli3UZrjgd3faJh+VYVgUikimM0HQH5UP52qwI7JUlEa2Bsd5i0Ap9ROIzR9Kbcw4ijqrAgrGywilnUxnpbk5upGeepSOvElgT2U3JogTElH81vA09DUIy1zde2ihp/OPlniHVR/NmmhVMdRPKt8yI8u7KGv6SRrqF7/rQyPni76bI+dGWIYynAkfvJwLm9EMdwZFqRr+T/z9MWY1X+jDhogz5GdmY8lonRk/0SIYmhKikC+0WByaFISw4m0LWNtVvy2pb2Abny0hG/0hUt6qUdCtn4e0m3rXVGYoycUuC3FC8dvR6o3L7PKUfvwia2aQugRhWvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Yyl1sY3anDsSHWjsoRq0PAoBJxGOo5TPXm2Swb+mpQ=;
 b=AbSJlP44y7tt9HxABdJOF5G/ssZzTKd3y39Lmi5Dd6sYX2aX0Rw+zgvmS0888wdE0amSy4t4rWkhDRPJINnc5eJnQ41dBjFTJv1hg5JD7TUnbuTjmPnGFEPzdXJVlTcrUvxAkfHbvdWG16f0t5wxeq3M60Gu2zRkmBPoFaGap99WylHg+83MVVJgNIn094qJmA+7pVAdMYdUWYglREWGYZxdLCIq3tfZYqPiLLRoflyRILqLygwbYXe0kKDdE7suxeaQPSk4G51zDE4vikf3KZjdAAuCdAaBEexhXGJKKkzw9kj1SprMgSkPjoPsnS3uWqpbcsBBR8glx+8TDEJ7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Yyl1sY3anDsSHWjsoRq0PAoBJxGOo5TPXm2Swb+mpQ=;
 b=L7vjF5SkPqYR8Jr/6mDJcyzK90vZde1ks0EXj5/WHIKkzbnVEdN6PhxUOgiXgmp28lzba0OKmBkY+dNwiFCoklOQORD41ijazW3i/0aSiWLgl2N+8QAFerYSj9RWc/S/NB2aZQ0xjVgn/LgxNRzFg3/P8v6uORnJprWrQTmQc1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB9859.eurprd04.prod.outlook.com (2603:10a6:800:1d9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 12:50:22 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 12:50:22 +0000
Message-ID: <2ff8e7ba-82fe-4026-b856-31a58ce47b41@cherry.de>
Date: Mon, 24 Mar 2025 13:50:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] env: Rename ENV_MMC_PARTITION to
 ENV_SDMMC_SW_PARTITION
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
 <20250322215624.18994-6-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250322215624.18994-6-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB9859:EE_
X-MS-Office365-Filtering-Correlation-Id: b8851378-7b8a-4fc0-baa5-08dd6ad2707b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0c3UlNnSG9DdWpuK2V3Mk1BYnBEayt6SE1GU3Qwbk12MzFTSmROUkQrcDJ6?=
 =?utf-8?B?c0M4UWU2QXhaK09LeGxXbHdiblJGdHR1SThnYkJ0NHIvUXU5RXh0VlN4LzlR?=
 =?utf-8?B?VnkxS0pZMEcvSEJqYTFQUmJkaEcvckE3VEpJSEU3T2gxRlhVbHVTVkt3QlUr?=
 =?utf-8?B?VHZhdlExTit3RzhFcHIzUnBpMXA4YWtUbmMySExCb3BzbUZ1NWYwRDhNbUdM?=
 =?utf-8?B?WlZNdGVvWkxyb3FudDEraklreWN1QVhHamJVVXdJVkJjK1ZlU2x5U0xUdFZJ?=
 =?utf-8?B?UlRnSnNJY0hvZUMyUE1HdHBRRHVPRVlDMGRSNi9ZWVNTTDZVUWNpNkZFSER6?=
 =?utf-8?B?MzdGUjZiNG9xSFA3NjNyaFRhM0tIMjlJTFpLdXlDclFIYVNjN3BwcDNyclBY?=
 =?utf-8?B?V1dQbmpCajBoOGRMUUF1VE5OR1dwSWIvN3Fsd2NLZ0pFditSenNWbVg1My84?=
 =?utf-8?B?UlNJcUlTUHJUWkRCTFo5VkNEQ09lb2RyQlkxVlJXUHVZZlFyUXJzNFJCVmxY?=
 =?utf-8?B?cmpuZFc5UksrMFYwZEhjbktlbTFrOGFaSE5jeVdaZ0V5a0IvNjIzUjNQWFUx?=
 =?utf-8?B?RHB2U2ZtVGo5S0V2ZEhRTURvbExYVmJQdEpYQ1A1bVkvbXAyMU5ob2oyVklk?=
 =?utf-8?B?eEd1d1Nuc2RxUkhFYVlZbDE0NXVLTHFjNXU4NW5WV0VxeTYydjZrY0treTlY?=
 =?utf-8?B?UlgyaDVVbVQ3MExlQmp6aXpDTGR0akRjUHR5V2lvWmhhRUlteFZ1RW9kNWNB?=
 =?utf-8?B?MXJGRnBobWFoZG5rMGtaMmN4STM2VkowTkhoT1pnNXdjbDBJTHJzY0ppa3JT?=
 =?utf-8?B?bkpnTytzTzVScTlhWnZOZlp0QlBLNHhFdmNGSVJaaE5pZ0RDNDJIZU9EMGNE?=
 =?utf-8?B?VzR3M0o5MGlQU3Z2Z21UTHpqM3pKTUliVllldkhlYUxCeTQyV2tUVitIa2lU?=
 =?utf-8?B?cDdhSFg4R0R1SFFncmM0QnZQUVJNRGhiKy9GVmNmY1dCT0dEKzlRZC9tcFdN?=
 =?utf-8?B?akdtOEJUcUlnR3ZSR3ptb0J6UDBGWE95bjRRdTBJR1EwR1dhN01wSjVyaUN5?=
 =?utf-8?B?YjVhYURVWVZYd3hTSEx0SU40TVZjOVFZUU1tdmU4bEJURFN3SlhKcTdvNGdK?=
 =?utf-8?B?MU5qb1B4ODlDUm9uamNWd0lJaWkwdzdwUTh1N21XeTNNeVhHeSs5V0JVZlE5?=
 =?utf-8?B?c1RYQlhrRkRIdkg2YkVqOEJJdGY4Mnl1S3ltNWhod3V5UkxhYUlZaTR0TkVH?=
 =?utf-8?B?d1FBYXc2Zk9XZml6eGdqcUpHVEV5cUR5eDM1NXo5ZHBxMVZJRjZJTy8ycVRB?=
 =?utf-8?B?RnpvOVpHc2pRS2R3b0ovQWE1ckNoRU1uR0NPYlRralVkODRRMFRvVDE5SDdw?=
 =?utf-8?B?cWdNMi80NmVrb0xsZzNCUU1oOXZtM1dENlRxVzNPMmpwNkZJcjVDbjJML25r?=
 =?utf-8?B?ME45QkF1T293S1J1SlR1RkxSTjYyV04wQlpEcllRdGVyN3R1TEduY2dGUVhY?=
 =?utf-8?B?R2R2ZDBXb0VQN0xIdExENTdpcTZBQVBKQ1VvZ3NyU0oxQkljR1VxTWpQZk5N?=
 =?utf-8?B?NFg2b1RlbnBOc1ZOL2pSRWI5emtLM2lHU0YvZUs5bzIybUpyNm5iK0V3UEN4?=
 =?utf-8?B?VzhQNnR4QXlQb3FrVkdSWHkzM0pUbDZDQ2ljRThpV1V3T0RTL3pKNEMvcmZa?=
 =?utf-8?B?S09YZDIxKytlTEFXaWhTK0NxZHhzdHJ3WmcxNGo1VmxpVHRtdnlTaXZ1RUFz?=
 =?utf-8?B?MVRQa2J3bTJWS3FyZ3NhT0NOZzFlaDVVbkNnYWpuSU9oNlRkdG56bSt0d1pV?=
 =?utf-8?B?U29Lbmd5Vm43aE4wZ1JMMDZQWDhWMEMzTXFRbVI2OE1Ob1VlSXc5UmMwMDlG?=
 =?utf-8?Q?3pkvf1a1b9KBJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGVhb1ZLdkNDYUxpcmVDUC9Lc2gxRGpBT2hrMnFxU3QvK0hCZi9rL0NBMkRy?=
 =?utf-8?B?RU5yeWhldzYzVEVHZXc3RkVXTVRHQ1IwYTVDbmkwc0QrRDNoNjZpUTlMUWEr?=
 =?utf-8?B?aFA4UENOYWNOTVZLeCtzRXJJeUZIWFNSek1VU2FOR0FuNUJ3MVczbzRTbnNS?=
 =?utf-8?B?L09VRFk2bW9mZGt0VnZHK2V1QlFPaW0xK0tEN25qR1NCQlNhcGk1cllmcXFn?=
 =?utf-8?B?SzNEV0N5TFAyTDBkaHJxRUdBL3RYdUYzUW0zQ1VkWTlVR0Yyd3A3UGdPN1JU?=
 =?utf-8?B?K2hCUUNQOXI3YitjQS9ndllxRWVIcjY0RnlmMjZ5QndaZzZPamRVYVowUjJu?=
 =?utf-8?B?Y2hlbisxWk9WTXUyUzh5dys2dmhCdFJkTUdFaTNKOFFwRjBMb05MWThVVXdY?=
 =?utf-8?B?aWQ3cUtUT3RHb3F0WXBLN3ZzcVYrR0FndWFidHVXZ0g0cjR1VDVhK2JsaUti?=
 =?utf-8?B?UjI2NkdtQ3dHbWRRV3E2Zll2c0hpeGFsUzhxbkpnKytkWFY2N3ZJWEpqWnA4?=
 =?utf-8?B?VGhrUFhtdVpPSFF5YUQxUG9VRmFta0NqbXZEOEJpQndvUHBXeDJnejkxb3FB?=
 =?utf-8?B?WEt2MmlrVmdiZzEwY3grWmQ1dmw4NjlXbUE4OGhWeUlpaDdZbjV5UTY4KzVI?=
 =?utf-8?B?cEZCdW9jK1JZN1JXUUFra08ybmQzYy8vaUF2ZnZjOGJJZXhHR0k1R2MrUnJT?=
 =?utf-8?B?czg3ZithR0pNVEhtMXpFWXUvZ2ZSdEFtVjlLcTBOQ09FaURHVTdTSlBLcHF3?=
 =?utf-8?B?YjEwT1M3aGU4eGkwcytEZG9Ja1lUQll5Wm14c0UwejVsMFBMOTVkSDZRSHJI?=
 =?utf-8?B?a0s2U1Q4NnBKcysrelA0N2Vya0paa3ZiT3djcVVBUTJNMmd4bC9xVWlORjFQ?=
 =?utf-8?B?K3BLQ2oyZ3Y3cVdoSkJpeUhiZGFSYkVYc0RDcUpleVNhSGZQL0F6S0oxMGdR?=
 =?utf-8?B?d0NHUVplL1dDT3VyWWpxWVZuTVRJb3ErREV5bXZrS1ZjYWhIYUhNOUFGSkNm?=
 =?utf-8?B?LzZlN0VaTWJTcW9lNE55UFhNSnl6SkI5ZDNuYjRZSlRQNTdvRk9KTnZMYVJP?=
 =?utf-8?B?cU9xNzNmaHJaOUtlbkp0d1krdzBFWE94STd4K0daQWN0aW9MaEpmZGc5Wk1C?=
 =?utf-8?B?eEowZ1dpWUVmYitQVVRGdDNUdHo3RGdESmtQL2xEdElZc25ESUxjamZZcFNQ?=
 =?utf-8?B?dzBJdHdEU3FXTWJVZXpHd0k0ZVJTVWVnd2lINTVrVFJnSmpwTUExQS9BZndw?=
 =?utf-8?B?WHN3NFlGSFgzZ1J2RDF3Mi9yYkxZRWtrekJvS2hSeHBvRHJEb1I2RjYxL0dv?=
 =?utf-8?B?NnlhYldtbzBON1JNUVVJVzlSclVhY3B6WVd4RzNRMVovbFc2QzhUblVDRkVI?=
 =?utf-8?B?RU1ra1plekNjMHVZbC83aGVxR3RWZ1cwYVNaZGpkN3I3aHVDd1cvSlN2Ulg1?=
 =?utf-8?B?b3ZXengrZlhGSDE4dXM3QTNEZjVMZXJCZ1NGUTM0QmpBTTEvRVFnMGNtUWov?=
 =?utf-8?B?RHJjOVBhY01oQVMydHpBcDJOdVFHQ0hwTUlKT01aMjk2aHl3MjhGVnZva09m?=
 =?utf-8?B?MkNpa253aWhjR0EyZ2N3UVM1aTgrQUdnOHRXVnJPMG16cWt0NmJzTW9YY2V0?=
 =?utf-8?B?Rm9GSU50Tk1hSFh2SHlnZWVNRzRFR0c1R2lTcmdseGJ3VlFRdlc4a3FjRnFu?=
 =?utf-8?B?V3FLWDVWMFF1ODVUNWRRb2tmdzNvNUZoRlNacEdhYzJEcDByZ0huL0hrWTk0?=
 =?utf-8?B?TU9mZ0lBUWxDcWNlVzFUSmlYZE9BTmE0bjgvN2s2WWdPblpHUTdIb2FLZzV3?=
 =?utf-8?B?Q3RrcUphRXZ4UDV5WFFYWTVBS3daNUhuQmlIT0tBTXhwd1dTVFJ1MXZ2Q2tj?=
 =?utf-8?B?VzFVSzNKTFg4WjJtbGl3YlB2dXZpakJjRWlkYmNlOWh3b0NDTHdKS1ljTlc3?=
 =?utf-8?B?MzQzcmlXU2pReTZVYnMzUjk2ZUw2d0FURXV2MlloYUtJa1I5YmRIQmMwNkli?=
 =?utf-8?B?V3h3YzB3Z3NFc0cwOFFlMms4dnExeUtwdXM3dmlqYzJmeTkzSmJYWFhRblhP?=
 =?utf-8?B?V2NIQ3pGamdibS9vNXNiUnRSRXQvdDRNWG4vVXk4c1VXdU9VRkViRVk4UUdO?=
 =?utf-8?B?QlJVTHNnblpDMXVEQzl4TWtoS20xd3d1b3gwTHJLVXBueXhsdGt6MEdVV1Bs?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8851378-7b8a-4fc0-baa5-08dd6ad2707b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 12:50:22.1922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3VTDSytb4a5KGclgpn1boxwNGJKmBsGsIn4z1St3oFBfJpwh3XsFIn7nn5AK1kOOmEeFwEGiw2U+qqVspUm3HrGjPH4LP9BpPoXWxdlpG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9859
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

On 3/22/25 10:55 PM, Marek Vasut wrote:
> Rename the variable and add ENV_ prefix, so that all configuration
> options which are related to environment would have an CONFIG_ENV_
> prefix. No functional change.
> 
> Use ENV_SDMMC_SW_PARTITION to clarify this is the SD/MMC software
> partition table entry selector. Update the help text accordingly.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   doc/device-tree-bindings/config.txt |  2 +-
>   env/Kconfig                         | 21 ++++++++++++---------
>   env/mmc.c                           |  4 ++--
>   3 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/doc/device-tree-bindings/config.txt b/doc/device-tree-bindings/config.txt
> index 8584cc6dcf4..44443c92d5d 100644
> --- a/doc/device-tree-bindings/config.txt
> +++ b/doc/device-tree-bindings/config.txt
> @@ -76,7 +76,7 @@ u-boot,mmc-env-partition (int)
>   	precedence. In that case, only if the partition is not found,
>   	mmc-env-offset* will be tried.
>   
> -	Note that CONFIG_ENV_MMC_PARTITION overrides this device-tree setting.
> +	Note that CONFIG_ENV_SDMMC_SW_PARTITION overrides this device-tree setting.
>   
>   u-boot,no-apm-finalize (bool)
>   	For x86 devices running on coreboot, this tells U-Boot not to lock
> diff --git a/env/Kconfig b/env/Kconfig
> index fbc03777040..19bc34f8663 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -677,7 +677,7 @@ config ENV_SDMMC_DEVICE_INDEX
>   	  matches the 'mmc list' command output.
>   
>   config ENV_SDMMC_EMMC_HW_PARTITION
> -	int "mmc partition number"
> +	int "eMMC hardware partition number"

This should have been in the previous patch I believe.

>   	depends on ENV_IS_IN_MMC || ENV_IS_IN_FAT
>   	default 0
>   	help
> @@ -687,17 +687,20 @@ config ENV_SDMMC_EMMC_HW_PARTITION
>   	  partition 0 or the first boot partition, which is 1 or some other defined
>   	  partition.
>   
> -config USE_ENV_MMC_PARTITION
> -	bool "use the mmc environment partition name"
> +config ENV_SDMMC_USE_SW_PARTITION
> +	bool "Use SD/MMC environment software partition name"
>   	depends on ENV_IS_IN_MMC
>   
> -config ENV_MMC_PARTITION
> -	string "mmc environment partition name"
> -	depends on USE_ENV_MMC_PARTITION
> +config ENV_SDMMC_SW_PARTITION
> +	bool "SD/MMC environment software partition name"
> +	depends on ENV_SDMMC_USE_SW_PARTITION
>   	help
> -	  MMC partition name used to save environment variables.
> -	  If this variable is unset, u-boot will try to get the env partition name
> -	  from the device-tree's /config node.
> +	  SD/MMC software partition name used to save environment variables.
> +	  This is a software partition name, i.e. one in partition table, not
> +	  an eMMC HW partition (see ENV_SDMMC_EMMC_HW_PARTITION for eMMC HW

s/HW/hardware/

> +	  partition configuration). If this variable is unset, u-boot will

s/u-boot/U-Boot/

> +	  try to get the env partition name from the device-tree's /config
> +	  node.
>   

Should we also have the same (or very similar) help text for 
ENV_SDMMC_USE_SW_PARTITION? The issue is that one would need to use the 
search function to find ENV_SDMMC_SW_PARTITION since it won't be 
displayed until ENV_SDMMC_USE_SW_PARTITION is enabled, a symbol that we 
do not currently document.

>   config ENV_MMC_USE_DT
>   	bool "Read partition name and offset in DT"
> diff --git a/env/mmc.c b/env/mmc.c
> index 4155a5c72f1..f49af88bf5f 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -161,8 +161,8 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
>   	hwpart = mmc_get_env_part(mmc);
>   #endif
>   
> -#if defined(CONFIG_ENV_MMC_PARTITION)
> -	str = CONFIG_ENV_MMC_PARTITION;
> +#if defined(CONFIG_ENV_SDMMC_SW_PARTITION)
> +	str = CONFIG_ENV_SDMMC_SW_PARTITION;
>   #else
>   	/* look for the partition in mmc CONFIG_ENV_SDMMC_DEVICE_INDEX */

This comment seems incorrect no? (unrelated to this patch though).

Cheers,
Quentin
