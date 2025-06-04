Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05E3C5B552
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 08:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 454A281E72;
	Wed,  4 Jun 2025 10:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aEgQGjeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FDFA81FEE; Wed,  4 Jun 2025 10:56:02 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C8408006D
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 10:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCL09kzmPDtuOZMuN/E2rWiTnEq5VjDQUo1HyfgMYE2JByIdiJd+tIVsDF34psGXcV8YK8us80irGfYg4DaEEL5jh4cJ3Al2I3v0bqTqDrwzV5k7wG2QJNNRdZ2T+YeTsB+z7Vozh28ch1ae+sxy7a8HHd1dhaF4S0uzpWqgkwmbO7e384m21kBdfwDru+dPHzfnE0KO6EoDzER2/dHGpWoqVg+58PbynkHAf1BvvH4Hh0DCnO7MzZrW079HHpqR+BPAHbKD+rzu/Ay0D10VCZTieAgkESs6cULbWK5DewaeHlY5+bLgaaOd9EyVWWCPxnjEfuH26hGZxZFRcOuzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1NKXvE9iY06AjcdDcdvc+DhSADxA7x3+SuwiovvVvM=;
 b=pKQuMzeQyhPDyY0h/sbGERW5raQJpLt4o7OTbhzbVtifLc9yw9AwkcIRBx8iih9wXLPcqo7qZjVCzJceLe0ejZmQOViYrxSEv9Y6vYJtJbcqV1SVxAPFpN/eCfaoNuDzFJGuEkrUNNNDK5r1wy2GPbj0m7TK3PGVXqJy5xcFtSs3ncJPjafh1+uj19dQGMlr4FL7xTpB9dv0+fQ5DqmpPxoJgGLq4Zo6Tj4TTBE5ldXpJR185EIQjr0cVh6h6x+wz34kNgtxsAJVv0c8f+Q3F9RDjrA5nCiV6KY65oZwwn5j+fvMvkE4o03SdwXMNNWX+nJqKD/ytGJnXtlDrcTwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1NKXvE9iY06AjcdDcdvc+DhSADxA7x3+SuwiovvVvM=;
 b=aEgQGjeqGORybQVtsW2TZ0ax72CR5JIb9vqX7AQ9/oXCkHkJ68dLDEEbsBMWpsoZjwzy+K6IqOaTbevtci4fNFDwgxH6Rzw5Ut6Uekpys2+K/48tEZKvO97xhxQfYxeYxnYTKB1i3m0Eer1pYOT5ytSF39XnxjSEky9MPQZdRXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7712.eurprd04.prod.outlook.com (2603:10a6:102:ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 08:55:58 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 08:55:58 +0000
Message-ID: <ed6b5d78-bb34-4537-9dab-e46287aa381c@cherry.de>
Date: Wed, 4 Jun 2025 10:55:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux/bitfield.h: import FIELD_PREP_CONST macro from
 Linux Kernel
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250603085132.12407-1-ansuelsmth@gmail.com>
 <d272087c-4f0d-406f-9630-57fc1c68b403@cherry.de>
 <683f5d03.df0a0220.437bb.ca9c@mx.google.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <683f5d03.df0a0220.437bb.ca9c@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6cbeae-e4bd-4233-533b-08dda3459f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0l5N2hRVzFJemxmcmZOOUs2azlScmkzRFN4L2kwNC9lNzR6eFFleXM5TVJY?=
 =?utf-8?B?V1c2YktyUUdoYW5qSVVvSHZUUGlpMitsZlpkMW52WmR3MUNFWVVBRWtNWHJ5?=
 =?utf-8?B?d29aVFBPTXg2am9aL1VKNkFWK1F5b0hYTXd1S1FROFphQTNOcVkxVlRNZENx?=
 =?utf-8?B?b1dXTWtxd3JIUTAzajU1Mi9YUHErNGVZM0g1Ujd4ekYyVyt0Q0tjeFZxMTNG?=
 =?utf-8?B?VS8wZlpOTWRBc0FSS3l6b2g5NXVSSmJXYXpTMkE5R2FmOU1XcXhtN0N5Sm1D?=
 =?utf-8?B?VVdrNHBuMFVrcENrdUphMk9Oa3QxeitDckdNWVpBL2dPTHRLeTZtejdrVzc1?=
 =?utf-8?B?T3FvcE14cDZQblM4MHl6RGpXcnZqWUlXZ2lNbGRZaEpyT0tEbENtUDhwUmUx?=
 =?utf-8?B?NHFaais2RnpLbXhaZWc0S1Jxa3FlMElRdXM4RUJhN1dUdjlOYnZJeEtHKzBE?=
 =?utf-8?B?dThITFpGZkFRVUtOa0xVbnNjR1A5VXhFbU10ZDZiUUdLSUVKUGJOT1NVS1J4?=
 =?utf-8?B?bWN2d1lYT1dwUnhzenNOUXZBWG84Tm01UTk3WEhjWkgwTDRJVlJCbHprL3Ju?=
 =?utf-8?B?WHVLWGt5dUdKK3huUW1EVy9haS9ibk4zZjNYN0NyUm5NRUtyc0MzYm55bmZj?=
 =?utf-8?B?YUdFd1VMRVJiYjR3VE1laWFIYTlIZjljRWdkWTIwcmFxNjFZRWt5YnY2UXBI?=
 =?utf-8?B?bEFFWjQ2OFdxNU1uc3dJSER0U0puYkF5Q3h4V0Y5dWdLMjhmajRnT25yd0wv?=
 =?utf-8?B?Zm5HTm0zcVloVVI2VGNaeTlKRW16SFNuS0x6MzBXOGJFRmF6MGl4NzR0SCs4?=
 =?utf-8?B?NHpZNkdURmdSeFlwYnI3aVdScWRjcGtBdGFBVVpKOENXSzhMdmc3N21ZTzh6?=
 =?utf-8?B?cDk0OHVWYkx0ZDZYK2lHZG9JRzQ4WmxaR1VsWndYRFJyVytISmllY3RNUFhp?=
 =?utf-8?B?MERFaHN2WEVhcDJBUWZmMlRlZ24wU1JlaFVtNDkwanVHNEhZVTN4NG1wbCtI?=
 =?utf-8?B?VjJ6QkJLK3dPZFAyb2lpVm5hMnR4YUFpRHFBZ2d1dVJUS3crQ2R3K0gyYkRr?=
 =?utf-8?B?dUJaTmh1cm5ldkdWZkRaTTFIR3czZDdDSzFwd0dMQTVnY1VRZXRnMnpDY3Vl?=
 =?utf-8?B?Yysxd3gvRlhhMHplQ1hKeitpNXdMVkFUVXh6cTMyeHE2Q1N0K0ZHMkRpdlZ4?=
 =?utf-8?B?RzJuUm84NHdYWlFHSTNRdmR0NkQ2QkZxZXczUGdjRHNieHBKOXdqRkRKUEhX?=
 =?utf-8?B?cEwwejk1dTBIdStzNzdlQVZPMDNMYU5wNS9xMnRiKzV4QXdZV2M5SXNYRXdj?=
 =?utf-8?B?aVhuRUtQUzdtbW42ZytIelJmWTYrdzk2dmlWcGZGaFFxRk56U3FSK1JtNjRH?=
 =?utf-8?B?bGJHcE51REhtQlhTNE1lZXdVa2pFSG0wSlBXUHJMLzE0Z3l6b0xoWjV6UURN?=
 =?utf-8?B?b2JhdmlXRmhNdFdDNm1Wb0VST3lQTWNVblNUTmR4Y2JpZDhBcnRCaTFwQnYw?=
 =?utf-8?B?TXhIUGJ1bjdwYmo5VldSMTdLcUIzOHpXRkxPTExYa0FoREdqbjZqbzBEN1lC?=
 =?utf-8?B?R1UvK3o5MVpUOFFVNVJ6VTR4bFZ2dHIrMEZlRWNHMVRnWThBSk5neVM3R25U?=
 =?utf-8?B?dnVJZllINktvL3J5akkxbE1ubkdjelpJYlVDTlQ3em9hSjJZN1RneWJHYVBM?=
 =?utf-8?B?dkxLTU4vMzBSTVJPVit6R3EyOC9jWjdNU1NuUVk0ZFNCbnh0REpBeE5FMVdB?=
 =?utf-8?B?bUI2NXQ5Z05qUTNNSUV3bFpLNXJGTmJGZTd5ckNNVy90NHVhUnNub2h3Qk8x?=
 =?utf-8?B?VWVpc0VkSjh3d1NvNUtyS3FtU0lTVXdaSjFWbnFhTjhKbDBxbk9ENzFwYUJo?=
 =?utf-8?B?dHVELy8zNDQ1NHFSQnlhbmhDcWxlQmxTUjM1cDFiNW1YNVNGZk9TMzljcklx?=
 =?utf-8?Q?GDuOD2+LNH8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFBWMDcrRmJDWU9GUUFkNWdZUGViQlluTW5wYWxiTSt4YWhPd1d5RjlhS2g5?=
 =?utf-8?B?Y20wN3ZpTkhpdVJrZWNoa0V2bTB5dVZkWld4RVoraEkwOWE0K1I0WGR2UGFy?=
 =?utf-8?B?YkRnbXUwN21ZTVJuQXZBTVM5SjBrZDJpRWs3Q3lLR25iVUtRNkZ2TkwzSmlw?=
 =?utf-8?B?K01wLy9FSWVhYjdCa3kzNUR4SmM5VDlNelArZHI5NzZ6NGU4ZEJhellCOWJk?=
 =?utf-8?B?UlBjdG90eU9EcVlmSFRtNDE0aW1ncDlOakpiZHROTnBMMzJVY0QzU0FEY1g4?=
 =?utf-8?B?VHd6L3hqY2p0TFp6WWYzMVRFZW1kRzFIK0t0cDBaZ1N2Vk0wMklGVzBEMHUw?=
 =?utf-8?B?S2pRNUUyRmROam1aVjgyUk8zd3FVRGp6REM1ZEdJMjdVRmloYzRmMlVHOTNs?=
 =?utf-8?B?ZktCWXd1WXN0a2hPcHF4blIzU3YrWStCZlNCb0QvMEVQdzlza1pWVGx5a3Vj?=
 =?utf-8?B?V2VneDFkUjhGNXNGSjM5YWd0enQ4d3FuYlVvWkUwZkhOTVE1ODFTcG84OHlG?=
 =?utf-8?B?cWdlZkFKWXVEUnNETlJxc2J0cTF2MjU2T1dBMFEwa3VrdTM5bHNqSWwrNXZU?=
 =?utf-8?B?alI3S0ZBcWxob3Q4RjVIZWxwMGoweEpSL09nVXJkUzkrZFhWU2Q2WlJNWUJY?=
 =?utf-8?B?U3oxd3dNZVpCdCtsWHlWck9ObHNreUtGNjFBa0MwbTRZemt0dEtsNVVRRnBm?=
 =?utf-8?B?VVQwVFBlUDdqeFZvck5TalJMVElhTUlObFFKU0QrdFROUXJDLzRIRElvS0lB?=
 =?utf-8?B?ak5rdG9aQjJzblVuWTJiN2hWQXZtZVBJZWRML0wvTHUvZVNJT1NiblVFWHZv?=
 =?utf-8?B?WjY5dFVXcThTUzVXUXJOSHh0b2piY3BYR0YySTJqWnJXY0JPdXRkK0NRN2dB?=
 =?utf-8?B?TG91ZnlUcy9lbDdoNGtpNytHbW1nZ0o0ZzlVRUtxYnhyUCtQb21DOFA1WGFo?=
 =?utf-8?B?WjNkSXJ6NUR2dVI3WTRhZHZ6K3ZKd3FpYkxCQjFQUFBoU0Jud21kZUtiOHdK?=
 =?utf-8?B?QUtBZjRLTmE5OXJ1K2hzT1dMVkJvYlRnUVVGdU9Pd3pIY1BENFplelF0MHhW?=
 =?utf-8?B?Z1NIaVZvQXBHTVF1R3ZxMGJodVNsV2hpTHlmS2hFQld2aGNuSXpzbktMakFo?=
 =?utf-8?B?SzBGN0xIV25tTEwxb1FoUXRHNk9tdEg0RXRzUThOejhvcXdBa2V5cGxZdlhR?=
 =?utf-8?B?dHl3QWpBUEVPUzUyMUQ2eVNUUnMxdlF2TDAzM0ZaeEQzdjJTL3pnaHRUQkpL?=
 =?utf-8?B?TXBGQXlFUjhQMGR2YnJxRDVVbzY3OXo4ZisvUTlKTDJodmM5d1NhYzlEUmpw?=
 =?utf-8?B?NW8wcEtlM0N3TFQyeVF5WDBac1ZiT1BMT3UxQmFPdzliUEtFa3UydURtRkRL?=
 =?utf-8?B?aHpOS0MvaStEeElJWFlWelpqS1k1QWlXS0hYVkVSSjgxVXVFcS9zY2tHOGl3?=
 =?utf-8?B?R0xZRXhLaHYyS1VIdHFXQ1pJVlk3ellQbW9EUUJjSUFMSFUvSDg0YXloWXYv?=
 =?utf-8?B?a2JaQnZuNnlkaWxTQmRQZC9KMDRpMEdBekpFUXRRbjErNjVqUUQ4OGxadit6?=
 =?utf-8?B?K2hlZjVaT2ticXRIWHpNLzF0ZmFzUk1GM3FCNFVQaURZNFBjc3Y0cWNHZExW?=
 =?utf-8?B?Nisxa1pVSllqejZTV1VTYkEvdWlaeHNvSW5RbGVEb1ZJMHFES0d1MU9CTkJR?=
 =?utf-8?B?R3NULzJseW9vRkcyN1J5eldhYk5KTzVqNSt1SVZUcVk4Y3BPRmFGdXplWldt?=
 =?utf-8?B?TVcwMG9xd1FMRzdTdllHcTAxVEhKRjR0citvVmN6L1pFeFA4eFA4d0FBZmVE?=
 =?utf-8?B?dzQvWmJXaU1MN0hzSU1wZGdrK2ZRc0ZuZzBxTzZ3VkMxb2JKNEwyYURaTzFU?=
 =?utf-8?B?aytpV1VQTVVUWTdHZ3ZXcGJWZWtrUDZBdGpyMmd5MGFJcWI4VWwrQUVqL2NX?=
 =?utf-8?B?U3ZlaUJCRmZNRTgxUkxkbXhabWMwbDJlRGdkUE42Rmc1b2ROc0QyeUZvaE9i?=
 =?utf-8?B?dEgrK3FITHRRSVFtUEx2OGVHbjk1N083MTROY3Y0ZG02UGJMajJmWkNXYzBu?=
 =?utf-8?B?MElac2JHR284Rlg3K0JGVVhsTVlhWWNqeWFpc0Y2QW9talJSUjdNNUxib0Nj?=
 =?utf-8?B?VnBJZjFDSjdYdGZUVjJvMGhYa1hQTldLQUQxdGVaa1hmaVBpZXNiUGRJcXpV?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6cbeae-e4bd-4233-533b-08dda3459f77
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 08:55:58.1568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEh5YZIUVoDN24ruuvDUUO6W8qr/2JJWPi+SCz4FnobFcGzk8fzn7v7T+qrtRsOeLmbbQblFwQAQt/xYysibAhwbYPnMUQEh4T00v3Frqa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7712
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

Hi Christian,

On 6/3/25 10:37 PM, Christian Marangi wrote:
> On Tue, Jun 03, 2025 at 05:08:13PM +0200, Quentin Schulz wrote:
>> Hi Christian,
>>
>> On 6/3/25 10:51 AM, Christian Marangi wrote:
>>> Import FIELD_PREP_CONST macro from Linux Kernel to permit usage of
>>> FIELD_PREP with scenario where a constant value is needed.
>>>
>>> Refer to commit e2192de59e45 ("bitfield: add FIELD_PREP_CONST()") in
>>> Linux kernel for extensive explaination of why this is useful.
>>>
>>> This is also to better align with the Linux Kernel for easier porting of
>>> driver.
>>>
>>
>> Do you know it it'd be possible to simply copy Linux kernel's bitfield.h
>> instead of "cherry-picking" individual commit(s)?
>>
> 
> Mhhh what do you mean? You mean syncing the full header with latest
> version?
> 
> Isn't that more risky??
> 

Not necessarily, it means it's easier for us to simply sync with newer 
Linux kernel versions or make sure that we're actually importing the 
same macros/constants/etc. And also the review is extremely simple. 
Checkout master U-Boot, checkout the Linux kernel at whatever version 
you're saying you're copying the file from, copy it, check the diff, 
matches patch? Reviewed-by given since it already went through proper 
review in the kernel :)

Also would make it easier to port drivers from the kernel to U-Boot as 
the kernel community encourages more and more uses of macros from that 
header but if we only do cherry-picks (or even partial cherry-picks) 
then things get unnecessarily harder.

The kernel typically gets more eyes on and fixes than U-Boot (or such is 
my gut feeling), so being able to easily know if we need to backport 
something to U-Boot by simply reading the kernel mailing list/scouring 
the git history of the kernel is pretty useful.

Cheers,
Quentin
