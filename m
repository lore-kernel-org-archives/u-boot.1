Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89626C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 11:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B23B488096;
	Tue,  2 Jul 2024 13:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GJPvbULV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8BD08824C; Tue,  2 Jul 2024 13:37:10 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22128803A
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 13:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs1xK2++3BWkFgwtMrazQ5QtrM/1S66mMSs0o0yEcgDnPLswznbBmuD8HacKfxXyKtCeENag59XHZlBq0TsJKphidI5/hCAyAzabv9qD1LQYukVtfxbgdSYSJo+EqeUzhg3vrGcLy7rFz+tPueMI6DDe7GVqy8YuXqUn41EwLYrKj13HpgwNh4Ut9Sdo+FM5Pq4wVJD1+iteDt61NLVBZMUs7bojTg6LLyE42rC8rYDurDsPRuxYpn5t/p1H/g/6gxGQ91kyAJtPEXq/bpAhic/6tA4Dk0S3EYmWf1wX1922XCkrdMCWHex7hu+VJTeZ4jDmrxyjsgX8LPLsVZirmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi8O41PGLBGisFtzpy9LlrY1FVy0S3FkACokYeanULk=;
 b=noCKc5Ie+Hqioa5OhujXqzfXiE6rHU39VOsPpRHZbqSWpV+ljMKa/FHR+FQvq0OLaBfNoIGqeqWM4tlNPT5pC3Q+pNbhjPlsvJjOpe4cmBSB3VTetqPj/U06ML2vWMZ8vV76xbN+8GDDp6XjD+ZE0owKfSCUorrnj/lYzdbLZXdUL2wiSHtNElkGDdCCUZi1KLlCjx47m2u0LS8FUrib2yb2ZbiTC6YDnuJ7tmb628ZEC8825bC+QpS9xQde6n4Wwda8peIERKhKJbhQkzAIp0JZK6zjErwrMEKWuJ5gH4HzkD0zEOpV24WF1uofIjJ2CC9LeyIpBujtvL2GeHxUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi8O41PGLBGisFtzpy9LlrY1FVy0S3FkACokYeanULk=;
 b=GJPvbULV//zrs6Cv828ovmt4q9gHzvWBcjOe2rl3fc17YERqOHJ9Xn66ysJqFS+fJov+Gf5LUMly7D+ysdZFvrWZyE2j6MCu3XDKToYH0cZSajt90slw6XaPkKVUPzMvSu4Y9+BS8n+dHfUVoxJfJEfeCt1yBAHGP0U7ldzDnnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 11:37:06 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 11:37:06 +0000
Message-ID: <7687e15d-c601-4f91-b07f-a4f9d5114362@cherry.de>
Date: Tue, 2 Jul 2024 13:37:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Import environment variables from FIT configuration
To: Lukas Funke <lukas.funke-oss@weidmueller.com>, u-boot@lists.denx.de
Cc: Niko Mauno <niko.mauno@vaisala.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ivan Orlov <ivan.orlov@codethink.co.uk>,
 Joe Hershberger <joe.hershberger@ni.com>, Joshua Watt
 <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Piotr Kubik <piotr.kubik@iopsys.eu>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240702064834.9543-1-lukas.funke-oss@weidmueller.com>
 <d609b656-19db-4dc3-956f-7dbec5de9975@cherry.de>
 <6dc671c5-2f2e-4cd9-817b-5aa50e5a4232@weidmueller.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <6dc671c5-2f2e-4cd9-817b-5aa50e5a4232@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::14) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: aded957c-14cf-4e31-8d9c-08dc9a8b4cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmtYU0N0U3REM2tNc1ExdFBsUEhOMy9sZUhaWDQ4bjZ0ejRPZHJIajVtWXMr?=
 =?utf-8?B?dlRyK3RJRGI3UnJOR3RKeGlIWUtPcjRzNDI5bjN2QkJLejUrOXVINCtWTmJH?=
 =?utf-8?B?NEJNd0lYTWxRUjl5RFZhY2RtOVFhY3dDMHlNQlIxTm9yU2RicnhlZGhVS3k2?=
 =?utf-8?B?SnNlSUNJeGhPQVFxdzhjeDJrY3dqU3AxczR6NS8vWklINTNGcDVINnpKS0pz?=
 =?utf-8?B?R0J6NVpaMG1Kc2VoMHRtS0V3SGtMNVhuQjJqcFNiUytBS0RzNktneURDWmdK?=
 =?utf-8?B?T2hsa3QvWDB1bGI2MEwwMVVHdHBFMXRRdy94T3NyRXpJdnNLczR1UWNnajZC?=
 =?utf-8?B?K1hQNGpTNnJiU2d0VTBTRzVkekMzZ1Y1eThMR3FDem5yVmUvN29ucXBRK1V1?=
 =?utf-8?B?YXVMcUx1QU5XOEdYM05QV1FoODBKVU9Xd090MDJnUTBMWS9vVmkzUXFrcWN6?=
 =?utf-8?B?U0dSUnAyeHZ4d2xKSDVEemJLL2FJN3JtWmwxRzVlbG5FOENwOGdDT0VUa0VQ?=
 =?utf-8?B?cFR5Vld3dlZsT092YTlJTUdOUHlQc3VzdEpaK24zQ3JWNkNnQ0ZiUTBwTThD?=
 =?utf-8?B?aUV4dUJzUGhSTFNCenNVaTlmUVNmSW9NSVVIcXNKTTRHVzVJL01WWm5QV2pm?=
 =?utf-8?B?SDhSQ21Nc3EwQWdzY0ozU1VxaytWK0hhU2FEd1dUOHdQUjVxc1J2dk1yQmFF?=
 =?utf-8?B?dkJ3YVViaEhrUUM1MEJkMVFVWS9yTnRYY2tWTjJEMm9tWWxTajJkQk9kdzky?=
 =?utf-8?B?b3dCalFDTXZmamlqdExmSEwreUthR2lKc2k2dnhoRHVnaE9ZL1Z4NkJ6VVlo?=
 =?utf-8?B?U1U5Z2V3dXdOczNNU094dWtnNnYwS3U0cmFHaTNLcFN2T0laYmowNEh0YVpK?=
 =?utf-8?B?dytlRUdhc0JuN0YxdEV1MkN6Y2paU2hjNXJrbGdyWU9EcU5nMEpsTWVVYnBx?=
 =?utf-8?B?WFNuMEN4Zk42RGt1dnFaVEZ1eGtjQXhyWTZzRTV2VUcwdjZaY3YzQkl5cm9E?=
 =?utf-8?B?WUlobi9FNy9STUw2SFhtVTgzQzRndmJZNnlPYzJwZUZaZGF1OEdzVVhDcDRu?=
 =?utf-8?B?UG1xdzJKRkF0b1dKMlhrK1RnRjdrVityT1Y1L1pVRHROdHZzbU0wU29pMUVK?=
 =?utf-8?B?QlJMeHFZT3ltNzNnbkpjcTgyMlhoM1VmbjVCeE9Ic25JYkFSTXdsVVBaZk1x?=
 =?utf-8?B?ZjBmazVIQ0hhbm43UTBWSGZndVRoK3ZKUVkxVFU0VWdqMXFzRGJnOHdxOWdU?=
 =?utf-8?B?cDkwOW00Z1BwOU1rNDlrc0krQ1ZoSm16NlV2M0hTcUJpdGlFK3lTVlFsc1kw?=
 =?utf-8?B?a05lZUJGdkt5dWNzb25KdFl6SVpON1dVNWJ3UWFYWmFDK0xQZStTQUpKaUZQ?=
 =?utf-8?B?UXI1bFkwTFBaOGFJNGNCN25rcXViUkFEVWNWeVBaREc5TWs0TThCQVVsanFR?=
 =?utf-8?B?UlY1TjVOR3BURFJpV2RVRFMxbmp6UG9FSFgxRVlrcjRkd29JbDVkUGkvVUg3?=
 =?utf-8?B?c2M1N0dvc1dFYXhha2hUS0ZTNDNHa1A0RW80WGlIWVloczFYVTVzTEVIVjMr?=
 =?utf-8?B?Q3ljbzJqYjhoZk5aRVo0eGlRTmVYdFY5cmp2cm5HT1hkRzZqYjIzekRoSkpB?=
 =?utf-8?B?QjJ4ajV0NTJBNWNwUTdkalVkWHd2Y3hJeVpTdGVIaTJJZGNEa2tocWNyY0Y5?=
 =?utf-8?B?cUJsL0FBSnBBcERWTmVBUVRUVkZaZ0c1Rk1YLzhpMm1oVnBJQzZkZ2VTZ092?=
 =?utf-8?B?MEo4d0l4YVRQSjZLUmYxNzBNektvK3VWamJsbzZzZTd3cVVWVFR6ZFNYbG1P?=
 =?utf-8?B?UDAvNDRzMTZkOVUyanJLUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlNyOHo2eFphc1lRWXRJM0pTSUE1eWtIU3puQ0YxdGVGR1hCbTdKOEFvNFZq?=
 =?utf-8?B?L29jeDVGSkkzS0x0WVlMWml4RktGUFQvbTlhSmJiMFVxVlFueHozSlpYNHVE?=
 =?utf-8?B?UUpJbHpEYkFYUFAyMEJLeFdaTUhYNVpja3o4M1lkU2RkZmdLOVplMERxck5w?=
 =?utf-8?B?VUZxK3llYXpuZk5md2hacGJRSUZLbXlzekJMZHNBTjhwTW1CcHJZRUlGQS9E?=
 =?utf-8?B?QVZtQ1ZaVzBJZzNteHdsci8rcDZ1VnVTYnZEa0xQd1JTeElTc21JQndYUEtW?=
 =?utf-8?B?Vm5WUEIwZkIyWkFCTTJJcVBHNlRNZGgvblF2MTVJSTk2ZnFaMk51T3ZZbmJI?=
 =?utf-8?B?YmRuRlhDbVVlbVdFdkpOVUJ3NUNCcU1WUURnaW5jNUdESWk0Q0wwTjV3TFpD?=
 =?utf-8?B?VExhM0NlSjVZT04vRjIzWEYvZlNONWwveTBBOGEvTTdoUmRzblNrUEdJL0FT?=
 =?utf-8?B?cFhrSHJsOHBQU3RaUE1Cd1A2bW96ZXQva096WE5HOFBZRlA5dmRVR01NL2dJ?=
 =?utf-8?B?RnlNRzdTL0xwWHg0MkN2RjFkQkdMeFZ6dnFoZFg4V29PWWJla1FIT2tYNktG?=
 =?utf-8?B?RFNYYjBSdkkwVW43U3IxSnVrbnkyaTV4amo3SkZROUlKcEs0VW1CRzhLRDJv?=
 =?utf-8?B?MzVEbHJlcnI2Nkx0Q01EbVM3ZWNaSFQyaWNjRmk0RFBPY3dEYnVkSnhOVTBu?=
 =?utf-8?B?NkRsYjJLNFNmYS9XRGhCS1hteEo3RmhMeEpOTnVMTmRJSU5uNHNBTjdraGdZ?=
 =?utf-8?B?NklCL1YvdUFCcElkelVrd3lHNURLZU40YW1CY2wwR1lOSHpHUk91WXNhOEdI?=
 =?utf-8?B?ZE53UUJjK2dIWlpEV0FhTXhCdHVJMk1WVEJJMVRyVFdjNGV0WnBjbnlxR1Nm?=
 =?utf-8?B?QkFRMXVBSGw1M29rTzkrTkF6a1lOSTZCdi9lVStrM01TcE12Q09xU3c3ZUJZ?=
 =?utf-8?B?d3JuTjFabXNXZkRIQ2dJc2R4bld6Z3JXc05laTl1WkJnTDFBTU9SMTF4bHdx?=
 =?utf-8?B?c1BOY3RuQXlIamRhTmdqK05zYzlmRGZYakNHeHV5WDFhMzgvclJBc0pPZ0JO?=
 =?utf-8?B?UGxOVjVjZnVEUHBPK0lzRWtWTjIybGdEdGJ6RDhXQjFJaFVoYW40c0R2OXFB?=
 =?utf-8?B?VW1ibXNzK3ZIWXVQSSsvSUpILzJwSnBiLzhXb3RlK2Z0V1cxc0R6b3JaY3N6?=
 =?utf-8?B?OGx5blNSRWRIS2dEbXBYMVF4Mys5VDB2RzNIQmZwU2thMDQ4SlhrYTVLcE4x?=
 =?utf-8?B?UUw3Rm84YkJ6WUhxWFhKNFpkN0tVa2IvU0V1cFZGK1RWQ0JBWnJFRGhJa1N1?=
 =?utf-8?B?QzBqeGFVdlZ0NSt6c1dSa04za1hvbTl0VjFVMjljaC9zRVhQODRnRkRoWEhn?=
 =?utf-8?B?UnFzbTNzRXJpcUlublE4Y2tZbkZORkNIeW1XNFQzMHRwWWlaTlRBSGVqbDQz?=
 =?utf-8?B?MkVaZFhxZFRibVR3WEFYUzFiN1BNTW1wdXp0WlBWWDk1dFlRNStBalo4RjlK?=
 =?utf-8?B?U0Z5ZldvRmNReEQyUW9zYXg0Ujh6MGNmQjhlUm1LMS9mKytqSXFNdWIxWE9K?=
 =?utf-8?B?a25BSzlmQ0pkcU5kanBPTVU3MGRnVGhCcUNkTW0wUkdZek04bXZxTkFIeDNa?=
 =?utf-8?B?NCtXRVp5Vmk3SGV2U2tma0pBSkUyVDh6bElVTDN4UnozUW85em1HeDVJeWZl?=
 =?utf-8?B?M3dNZXJ1T1M1R2FjVDA2cVFZMHBUWFhPa1lLWnVkcUpzUmtQYm1WNTc3Skx6?=
 =?utf-8?B?Slg4NU42ZUdadGNuc1hTdTdSbzRtV3hSMHBwZ1FkcFlCdTc1R2ZWOS9BNjkr?=
 =?utf-8?B?WG1QNEJ5cmMvTGFjVUVVOVl6QnNBTy9HUHQyNzZCbDY0dmVWVXZVaFhUa2Vl?=
 =?utf-8?B?OCtQSEdBMDJkbEpEbVdjN0JURjRiaktuRmhGUkxTR240RXV1c043enp1VEpX?=
 =?utf-8?B?QzhKbU9oYTdZV1JibVRtOWRvSlZDak1xZ0ExYzNlWEo0ZkJZRmdVMWl0Yy92?=
 =?utf-8?B?RVVmc0h1WXA2djFIV0c0UXFVbUNKcHRIQjZ4c0dmTDV4MU5VWndWSHVIbERP?=
 =?utf-8?B?d1hWclNXN2tuVldJZU1lWFpSWUJMUTFGN2xRaTg0M1RYbmVFYzRzSmxISk93?=
 =?utf-8?B?TTYza1ovYkowQ3Q3ZGxMa1BoQ0NoR3RLYjNoTTdjaDBEbzBjc3B2cjVTek54?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aded957c-14cf-4e31-8d9c-08dc9a8b4cf4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 11:37:06.3413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqKCGgNFKp6y+nypDLRYXXZuWjaPe6fPBy5l9votA6fz2SiI4EEpMzJSsil2ogXy5wCDRldn56YbLljqoSqIeLME000llkmjM+612n35B3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514
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

Hi Lukas,

On 7/2/24 1:01 PM, Lukas Funke wrote:
> Hi Quentin,
> 
> On 02.07.2024 11:16, Quentin Schulz wrote:
>> Hi Lukas,
>>
>> On 7/2/24 8:48 AM, lukas.funke-oss@weidmueller.com wrote:
>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>
>>>
>>> This series enables U-Boot to import environment variables from the
>>> selectd FIT configuration. One use-case is that the overall build 
>>> process
>>> enriches the FIT configuration node with dm-verity information which
>>> should be injected into the kernel commandline. U-Boot will then read
>>> these (possibly signed) environment variables and put them into the
>>> actual Kernel commandline using variable replacement
>>> (see CONFIG_BOOTARGS_SUBST).
>>>
>>> Example:
>>>
>>> Config:
>>> CONFIG_BOOTARGS_SUBST=y
>>> CONFIG_ENV_IMPORT_FIT_CONF=y
>>>
>>> FIT:
>>>      configurations {
>>>          default = "conf-1";
>>>              conf-1 {
>>>                  kernel = "kernel-1";
>>>                  fdt = "fdt-1";
>>>                  env,dm-verity-args = "dm-mod.create=...";
>>>                  env,bar = "someothervalue";
>>>              };
>>>      };
>>>
>>> U-Boot cmdline:
>>> => env set bootargs="rootfstype=squashfs root=/dev/xyz 
>>> ${dm-verity-args} ro"
>>> => boot
>>>
>>> Kernel cmdline:
>>> Kernel command line: rootfstype=squashfs ... dm-mod.create= ...
>>>
>>>
>>
>> I think FIT supports storing U-Boot scripts and running those via 
>> `source` command (usually the file extension is .scr).
>>
>> I do not know if there's support for automatically loading this .scr 
>> as part of a config node though, but if there isn't I guess it'd make 
>> more sense to support this case than to come up with yet another 
>> implementation?
>>
>> What do you think?
> 
> I wasn't aware of this, thanks for pointing it out!
> 
> This patch was mainly inspired by the dm-vertiy use-case which requires 
> just env-variables and no (complex) scripts.
> 
> There is currently no mechanism to source/run such scripts automatically.
> 
> How would you distinguish between scripts that should run automatically 
> und scripts which are sourced by a specific board/shell-script 
> implementation? I guess there are good reasons to not run such scripts 

Scripts in conf would be automatically run? Scripts not in conf needs to 
be executed via `source` command for example?

Not sure what to do if you want a script linked to a conf but not run 
automatically though (and what would be the use-case?). I guess you 
could have a script automatically run (so in conf node) that sets a 
variable to know where to look for the other script that isn't 
automatically executed?

> per default. I would also change current behaviour. For env variables I 
> see no harm.
> 

If the env properties in the FIT image are part of the checksum and 
signature of the conf node, which is necessary for secure boot, I guess 
"no harm" fits the bill.

Cheers,
Quentin
