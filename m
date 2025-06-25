Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E08C77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 14:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A06F82D21;
	Wed, 25 Jun 2025 16:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="c+kLhgnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3643F82C4C; Wed, 25 Jun 2025 16:26:17 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A37B82E05
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAoJ/1vgbiKJtsKyXaGMEvucC5FTtb2Vq6NMqzykM6IQ0zpLhASuyz5T3O9ijTH3/ovDxmIO7/aWOVvkmoAFC2xaIG1I+gOqk7a/DLwCn16vjFlwJdG64I6xQ4lmG76BC7lLe7mxvKjOKNIdDg9joiVEaL5/iI191eJHLEGmdPG+/vD5uVmBnUD6qslc9AcqbLcEASD1EJPIe35zoGxNa6dYWrGifsKDumYzK5h1HoZqPffXwyzJkthXtHi3yxedFE5e+C8GC3OUCFXaIx2r/t9p3i+DJcDcdP+eJJIMkVo7JNUkriJGpn664L6k2lOyUBNzuZ2GnZqJFPTMtv7VZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/7/PY6UmximVcj1Eo+j4CECyOYp1ytTJYV1RfxWWTA=;
 b=CtKpFioYPjtD+yoFJ/eGo2DqmAsTr6f/53M+5oWS/rSu1i2YUGIGqDznkMoywf6SXlBSSLkU29awOpvZlqqj9BLUSc0OEr9Xp+xcpoL3f4x1Mn0tfpGCTkzjm32Ec1IlLutAP9YHcoFA5UvVtp4fagdHojE0+msF1qBAS0ftmLQIFVJQqoJZVe6GRjc4ZPs1tpIlJvO1scKU2hzKX5+BYUpeelyLQz4DTvkeNSyfgGrvK5sRpIXCQmVOAfJVuRcXWOvNr8kOpmjF/Oj79cBm069Twc6z7JcPrUHoZcrwxHvNcnVMe0YPv0jjLcd8yW2QKdFdLYc6pmnXyAoov2nUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/7/PY6UmximVcj1Eo+j4CECyOYp1ytTJYV1RfxWWTA=;
 b=c+kLhgnIwxmYQPMBPDQGR3OQ7xNDmbzOTLFSrlrt0FgpYC9AJSAhCSkTK8x53xTxsqL6voUS3UPWgdWNzO7Julx/dBfmsyiksk1aIYoIia5ZBRh3y6KYhlaZT6j60BLpHeqFhLFvNOyb0BVD5xzSy+Wy72YwEp9FBZxSmfqd/fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 14:26:09 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:26:09 +0000
Message-ID: <bef28ca9-b399-4641-93ba-4ef3743a1e14@cherry.de>
Date: Wed, 25 Jun 2025 16:26:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] log: Fix the compilation error for emergency log
To: Akashdeep Kaur <a-kaur@ti.com>, vigneshr@ti.com, praneeth@ti.com,
 nm@ti.com, msp@baylibre.com
Cc: u-boot@lists.denx.de, vishalm@ti.com, sebin.francis@ti.com,
 dhruva.gole@ti.com, k-willis@ti.com
References: <20250625124053.1953344-1-a-kaur@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250625124053.1953344-1-a-kaur@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::49) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1f8d21-0608-4593-f3d0-08ddb3f439d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVBJVVd4aUNSS2ROMkhobERKeVlLYkoyUXBPVFlWOVBLOWVORXJYT3h0c253?=
 =?utf-8?B?OUF5MytaT2oxYWEzMkRXcGhTT1dWNGtGUThzWE54T0JSQkJJejNwT2JpV3V6?=
 =?utf-8?B?dmxtazl0NjRxNGJXT0ZyemJOMUdhVXg4aGh0N2JnRDdPUlZQMk9pK3RWeGJ4?=
 =?utf-8?B?VDVPZUI2ZW5HM1VLMHFaalpIbXNxYUJHYWxKRkxUM24xaFBqSjM1c0ZYRFBa?=
 =?utf-8?B?RVRKT1FtM2Z3SnRlMHBVbjl2b2pjQmNlM2VrVVJNYm5iMmJ1N1UrTWZqcy96?=
 =?utf-8?B?ZFJPZFV1VTg2VmYvY3BwVXo1VHFCK2l1NkJncGlBN29LMkx6TFdNQ1d1UlZn?=
 =?utf-8?B?MmliTUtkbVNxcW1KQ2N0eC93bnNBVEQxYm82RVEvNENWZFY5VUt3T1pLQ2Fh?=
 =?utf-8?B?aThjQ3JZVFRjZUViSWpVVVhrRVVGZmJNeGpFeS9yeXVuMEoxMnhjdmR5aHhO?=
 =?utf-8?B?MzdiTm1UMkpwQ3A0SXZYcEdycXFlRzNabklad3d3elgxN2lkaEV0T2JDTW1h?=
 =?utf-8?B?Z0RndG1sL04vTTVUYzI1ZytoUlVIMVBhU0JUdHRFMTVlSTNYNGYxRnkxYjhz?=
 =?utf-8?B?V3NFRTFaVkhMemJSdzNqT1ErSkE2RVdheGExS1hNajZvTkhibnJNWWhsT3JO?=
 =?utf-8?B?V1ovL3BWaGxiZ3dIZFoxNVFGZ0s5cXN0b0I4cG5NR0ZSL0poclIrQ0diRHhU?=
 =?utf-8?B?UzFvRmJIbERNNEhhY0JJbEcxMjhOd1FmVW9lSVUrUFhucmN0ZWQxQ2J1NDU4?=
 =?utf-8?B?ZTNkcEhGbUNiSER1dE1WZElZUGZZOGVSRVI0UGZuWHRXNjZDbktPU2p1UDZR?=
 =?utf-8?B?bmtHamluSUs4Y0txUENEcTRBc29rQnp2TzZQUGVwNnlMSTM3LzNxRXZUN2RF?=
 =?utf-8?B?d0M1ZWVNQ0g0S292clJOWVVBdGhyNUFRYTF5UDk4S0s1NVF6UGJXMFBwLzBF?=
 =?utf-8?B?UVVCVzl2SUdjYUUzaHc0SlgyYkJhb0dGcTZRRWRoc1Bxa2tySEhaclkyYzNS?=
 =?utf-8?B?czJ4RldyL3F1MzJaMmtHaEU0ai90QUVzcHh1SDU0VUJEMWlsczlROUdCSkt2?=
 =?utf-8?B?MTN4OFB2NGpjYlJuUjFzTzUra3cwdGNlcHBmbnhJenVmWlBHbjY4SzdwUU0w?=
 =?utf-8?B?eFQzcmpzR2NZZ012b3ErRnU4QkZncDhhdWozUHd4U1pKSWw3aU5qVGhvY29N?=
 =?utf-8?B?dlQwVDQ0UUYvdzZ6alRVQ3l3MzFlZFowQWNmcTFqQ2ZKRmE0RXkrWTl4YUZl?=
 =?utf-8?B?aUxVTml5Z3Y1dFFGTXVFMW1mOEpZd3dwTlFFbTJiL0tteGRuN1RyT1dkZ0ZZ?=
 =?utf-8?B?aEFGeEdLOHEwZmlxTnlqaUZwSlJoS1ZPYmZ0MVVKTU9DelhnU3AzSE02a2NQ?=
 =?utf-8?B?Z1pBM2J2MUFvSTRYbUtROXJtWnc3ZE5nTFRURnRWamJDM2FyejI4RnhCSjdJ?=
 =?utf-8?B?Vi9pRkg5cHlmeDJYUHM3VXNERjEzZkYwNnBFSmMvVVAvSk9jUW9SQlBkMlhp?=
 =?utf-8?B?Rm9Ta2pReFl2RG1yVEZqMkF6MTNrZmZaM1FlUmM5SlZEZjRMdXR2SWQyY2Uy?=
 =?utf-8?B?aG9zeDdEd0loL0hLSnRpdFc3NTZJdGFjYis4eWdKQkVNTDRmbDAraldIWTNY?=
 =?utf-8?B?aW15SUttYm1HQ2IzNkg3Z05ISnErUFNoMjlTbzlDZHBNZ3pRZWhaQW85SU9y?=
 =?utf-8?B?VWdBWHZPdUhJcU8wcXVicEI0ODhZWUprOUpNUTNwcStJVzVtdTRmRjFob1hn?=
 =?utf-8?B?T3ZsU0Y4UlFEOE0zNEJyQlpyZEpYSnE3TUd0Qm5raVJ3YWgraHZFc3BlOWtW?=
 =?utf-8?B?aHdXSU43bUlyY1NRUGJlaHJPVUwrWXAyZzl5UEYzb1M3SXc5cDFXMktkTUk1?=
 =?utf-8?B?VTkxSFhQL2dZV241eXkxbERaTjhuQjc5MVhMZkIzMVZtaEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlE5dkRSSGJNakxOSlY1S3cvVjNhem5hcloxRlJCOEdvQnBETmlwbWdZeWpq?=
 =?utf-8?B?bWJMSDZ6OVN3QjFuQzNaRWkxT0pGTFRJcXNNdmRENlg2ck44dHlLTnN1MkJO?=
 =?utf-8?B?dFcrVlVkWjJPdTNaamp0aW1NRHNTUTdEczA4Ym9DZjJteHBUMFFZYWR6WW5G?=
 =?utf-8?B?bVI2SVVpclQ3WC9ROHhJcktpZSt0ZzYwTllnbVZnV2MvRWJtcGx4ZnU2ckxq?=
 =?utf-8?B?TGE2TmlQRmFSVk1lY0ZTVTB2NUdtc2g0dit5T3M5aWN5ZlJ5cjBCVmw5c1hO?=
 =?utf-8?B?ME9VMnRQTHBzWlJGMkw3aXBweTZKdGdYZUNJKzN5Nmw4ZjdES0t6RnlxenRP?=
 =?utf-8?B?OEdBNE5LNWdXL3RvbURxV2dLU0g5RThJZlVyT1lydUVrTTlxdmpQejg5Wkpy?=
 =?utf-8?B?SURiWVFENU5aUzhHeDdzNURjYTJIUVIxNGRiZ25nOU0wWG9hMTR4UnFjdVBR?=
 =?utf-8?B?UVA3SEJzcWwyUVBFeUZma1hLMUF4T29rSnAvemF4czREOUs4TStlTVhFeFhC?=
 =?utf-8?B?RHFSZjA5alA1N1RVMUxVRHQwTTdmeHdxN3NXV0V1eEd6aTJqZkFCY2lEVlhD?=
 =?utf-8?B?TkVCQ1RyMUdTQVpDQ1R3SUMralVubEEveVJPa1IxVzhkZFRoYVVuSDFSQS8v?=
 =?utf-8?B?b2UyeHZ2T0xmcVEvWHdvMW1tc2hsTXgzVkZpTmZhMzNnTTJSelpTWDBnR2tC?=
 =?utf-8?B?andiQXFYZ1gvUGRSQ2VuaXJhQXlyRmd2UEdMTzJQdnpaQ2hmSTQ5ZUtENUQv?=
 =?utf-8?B?QkJOa3RYNWNLSk96emJ6Q1ZveHdXSVFJcXN2azFVUjNuM29ZcnBwSGFBVm5R?=
 =?utf-8?B?Y2MxVWVvVXIzRlVFd1MxZHJqZGlIcHVvdVoxdlZuT0VOUjhNemh6SXRTNUhv?=
 =?utf-8?B?enRiTTg2czl3M0VLL3V3NHoxNXBnK25Ma3A4MGUyeCtuQU9KWHVSMmdsemRW?=
 =?utf-8?B?SHVZbTNLck0vWXpPemNCTGJRaXQ0QUVIdXd1TDVOOHFYakVGTnRWTlhZRG1k?=
 =?utf-8?B?Q1p2V2hUM0tqSHN6YUpzZ3RteGViNWhWamd3MFBjakEzMnNyNGtaMmt1SnVJ?=
 =?utf-8?B?RFZQTkxtYmNRZFlVaTBWTjZFRGY3Q0RrMzVyN1BNaTNPU2RPMXJzMi9BbGdj?=
 =?utf-8?B?clBHZGYvamZYZ0g0eHA1YkdwV296OGdoMDFvSjU2SmlNbEJvNVVrcW1LN1J0?=
 =?utf-8?B?OE5NYnhIMnNnUTYwdGJFT0Z5WkE4ejRBNEpOS3IzZ1J5T256ZzlHbGdnNlpi?=
 =?utf-8?B?cVdvazc4OFJvRitTN2VRbk1pZ2I2ay8yV0lpWmhBL1VhL2F2bk9GbHA0NG5i?=
 =?utf-8?B?VEV6NGRjNGREejRnc2RtanRNNnJxL0djZ1ZYU2pFSkpXUXVHbjcxSWxzYWY0?=
 =?utf-8?B?SzA4UGE4MjJnN29SRkRhaTBoSDBsWVlwRFp6c2dpVTRmK0JEQXllTzFEc1dt?=
 =?utf-8?B?YjlsNWdZVld1UlZrNUx3WkJSbG5aQTNSd0YycVMwTHZBRGFxT3pRNnBTak5K?=
 =?utf-8?B?MnREQTVKRVFCWUdkSCtpVDZ1d1pvbW5NS0hxbEd6dVFFa2lxUnU5aytZZ2Y1?=
 =?utf-8?B?MjludVZ3aXZUOGtuT1FsR2YvZjhudVlRZ21Ybk1rcTFuUEJZbkUwaWJtWlA0?=
 =?utf-8?B?MUV6SDJRM01DUDJoU25lQzJXZWFHdnBrYTlMMlp2NnBJLzZTRjcyMENQekxI?=
 =?utf-8?B?NWRVT2hZWHM0QnJIRDZSSUZQdktqdkw4WWNTOW5lbUJ2cjQ5eTFRay9PcW5l?=
 =?utf-8?B?OVFoVXdNZ2hSNXFkWGZZOTNiRmtVSTJaaTdQZ1FTdHBGbWMrQktXS3B2YXBH?=
 =?utf-8?B?elkybFFRT0hlalByYmtPci9nZThldTcycDF3bHlEMkg2L0VRSGlvUmcwMHZu?=
 =?utf-8?B?MVVtMm82Q2RRUWF0YklMcHJlUk5XSXgrNEhVRHcxM0xvL1o2S2ZyT2FtVFl6?=
 =?utf-8?B?cUhoZURYMElqclBHbVFJQnIrdVFhd2MxdDFHZGVPdGNjVGZwSzRkUk4yUEs2?=
 =?utf-8?B?WE1OL2c4ZTB5ZDgrSDgxR2tuNXp5VVpxNUljL2RiYUh0SHRLRnEzd1JHMCth?=
 =?utf-8?B?bjZ3ZnZNeHhYcjBZSUREWjF2UndHaW9URW1lUzBZQ2pydGdsVWo0QVh0citR?=
 =?utf-8?B?TnZqUEY5NmlCenhHd0ppeVdsTkpWY0dSVkcvMWh5YlpnTExjNnlQcndVbDNl?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1f8d21-0608-4593-f3d0-08ddb3f439d9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 14:26:09.3712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDRJSMDzSdEo35aWl0eV/z3JfEozBZdZNbCmzAMg4pQ6XrYAtpfLv0TP2m5XI3OUrchuzwVGp+xI+Rn4XEFVkJcT4hXtAKHLndabO2/xKrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803
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

Hi Akashdeep,

On 6/25/25 2:40 PM, Akashdeep Kaur wrote:
> [You don't often get email from a-kaur@ti.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The log level "emergency" cannot be used as that results in compilation
> failure. Correct the macro name used to print at this level.
> 
> Fixes: 249679658750 ("log: provide missing macros")
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
