Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A9FC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 15:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB1480AE5;
	Thu,  6 Feb 2025 16:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="C0Fpfihz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AFB080B98; Thu,  6 Feb 2025 16:46:52 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D9B980840
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 16:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/SX6g1SLLzRRrdDF8ax3pld+mo7b+4z6N0ymtFaqWqMpcVQO6l7Rg8QZYfYaHIXD2dYKSpKfE27VpVL66ZOTX9UjEsHG80rn/YTmymeIbgy2OdnzMq00zwTTZHiaHCsN8c6uxOAeHO4luRkxtKQAGSzCQlvcdTFfntwPQuQT0VoXlNUIaVmXI5wB3hOsA8M3BtwccI7v2+z86iDHfPWYAt6UE+pUmLRk+7UrZ7hyxMcIZt/XF/KOELSKscd4YXZ2HdUYx+E/Pm9fPxrClcekQExSbfhklvkqnCZofE5tQ011OtjLlNk4vexu6FdRZEhwMdYTjZeYKk7/eXHbBwC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1+0YPQY5dCiB6Ar6j3CZmACefLO7X+sg/Kc4p/XW1k=;
 b=mUZkl4ZR8G1bhDo4z8JMTxyIDW37kBmfiIPm8X6A2Bi/thzY4hZfJ8+bqySEwQFO6EUB4wUbO+kDTQf83wowTll/RQ8/bCacP8iZcGhXVeNbH/l6aVyUBhyDF1HDwsjI+MWapK0EmeKmINbLfrXcX6LdOVhBElVttv9FkyjviuxUcXbAyfNUor05y2ZOC4hRgjXnAbbf2U8/c2Dz4e/44ecWlzPbaUxLrg/B84JJ0C4rprfBCDVMRradwrL73YYPjphjCkRHTlrFBFzhSYulSTyit0f12RivPHr71jId3tT28oqxkgeey8htPxdjRBFxe99LP+jNN0A3Rl0zCNIfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1+0YPQY5dCiB6Ar6j3CZmACefLO7X+sg/Kc4p/XW1k=;
 b=C0FpfihzFGlE92w0fD+jQV/xHECkFrUdAIBJ36mdWzOqSrBuxgfL0TQNdcfCvPE6Rj9SZ8IjoC8lWc7LsEgB8xDgsUclxPp76ZchEcjFzCceJit0nnsLSVFfRxO68XeL2qgRhosRwGDTSVZxHXna4xhgVHohw0z54sw33FQKXGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10558.eurprd04.prod.outlook.com (2603:10a6:150:20f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 15:46:44 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 15:46:44 +0000
Message-ID: <fb6792e8-97c5-4d0e-8ded-e73ea3a7513c@cherry.de>
Date: Thu, 6 Feb 2025 16:46:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add 'bootsource' /chosen property
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+dt@0leil.net>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, 
 devicetree-spec@vger.kernel.org, u-boot@lists.denx.de
References: <20250205-bootsource-v1-1-95f4ba69ac27@cherry.de>
 <CAFLszThr_vLbhU7A0_0VTLCGW03k6NmtxLVoW7OzrtxGFertZg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThr_vLbhU7A0_0VTLCGW03k6NmtxLVoW7OzrtxGFertZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0270.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::43) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10558:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac93604-7985-46cb-ee35-08dd46c5752c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkZrakhEMlFlVmNZbmF2bGRnYWsrOHY2Y3BrMjE3UmFqNzhrajFhVmJTQXV5?=
 =?utf-8?B?WVNGV25mMTF1eHNqSEhwMnV1VUtWM24xbyttaVlvSkpRTko3dG5BTlVvQ3dK?=
 =?utf-8?B?cEFkSVVkQWhZeXNJN2REQWIrMTJXYXpLZlZCY2VYQkRCM3lqb3FDMWY0RXQy?=
 =?utf-8?B?b0tFeDZRYmJjc1RaS1luZEJJekZ5YUZFWGNVcmF1TmdOaEhHOWtaRnJRQUtB?=
 =?utf-8?B?VEhOelhXbHE3NzIzRkdMRTV6dW1NYS9pMW1pWVhUbEhOWFdQVTZYblM2UnJa?=
 =?utf-8?B?a3d6Rmp6bGxsVDU4U3U1U3hKTTV0MXhsdjB3R1laN053WmJmT2ZZbGdwOGVT?=
 =?utf-8?B?T2hyUExTNThZUkt5dGVnUjFnUk50UldQSm1XbVA0UDZKZi90VGNzSTFaSGFZ?=
 =?utf-8?B?RnQwUlJKVkJlN2lqYytTUGZvNkpieDhYUnlqNkllMk9QeDR2Y3E3MkZQM25s?=
 =?utf-8?B?b01hb0RBeHlpK2UvUlRUbjlDRml0RGxlTVBjdFd1d04waWl5UjVNSU5YSTJE?=
 =?utf-8?B?UHBLbWQ4cG9xa3hwY3o3cEl5NWdRRkEvYk4ydDU3WXRkNUtSVlo4N1lURkU0?=
 =?utf-8?B?M1g2REQrc1ptSjdlM2dwTHdJVm1DeklVelVlY3U1YnFjay9qSmpKVGZaSnIw?=
 =?utf-8?B?Q1dndXpTQzV0eEdIdXNySTdwY2hhdnZMUGtabUxoVlErTFhJOFhCcFVNRUtP?=
 =?utf-8?B?dUNvVDdhQ3R5ODU4OUFZM3duemtlUzBsWEVPYm1NVGRhVUZ5UlBKMDNPMTZD?=
 =?utf-8?B?WGhrTmRvOUw1bkw4czZtelBYQlMrMXMrbkF0eEIrM2ZvZHozVlY1VmRmZWVV?=
 =?utf-8?B?YndPSXMyVlZFeHVqYjNvSHJ6UndkQUxEaEVNTUROanFOWWNPanZzcjJ1Zmhv?=
 =?utf-8?B?aHhHNEJPTTVrdHJJWXZKd0llMk5mcGhMRENta3VBTDJTRVRhZTFIdUFsR29N?=
 =?utf-8?B?dmRHTHFBcm5QalNnMm10M25DeFh5YmM0VlBFZGNtcThaSVRzYmo0ZGV1YlZ5?=
 =?utf-8?B?biszdllmTnFpRVMvTnhzK0xqMllGODdyT0RZUm9XS214b0VQbnFVVXlwckVo?=
 =?utf-8?B?dUtSaXpuVjZZUDh1eW1uNnNuTnNjUzc3bCtjODI0Sld4dG0vWXFtbVFleXlt?=
 =?utf-8?B?VVE2SmJTMmhhbWxZSHhBUjhUbFFMRGZCSCt5M284ZHk0eEFpZGFwWUZrZTlN?=
 =?utf-8?B?K1Y4OXRUcmVuRWRCUy9rNDZqcWMxa01DN2R5S3A1QzN5OStBVHI1eFlzUWpV?=
 =?utf-8?B?WWljT3NmaWdoQzF0bDJrOHIvK2VGM1E1MUYzbUtpU3pnY09nNHJybStiNm9M?=
 =?utf-8?B?VjltR0E3OVQzTCtuUHlvbDlHR1hhN2U4Z3JYbTdxL2k2V3E4a3JhRzlNU1J1?=
 =?utf-8?B?aW1ISTAzT0c2WFliZnI4bGp4WXFpTGdVc1ZZNkNPQXIySStCcTRBSUZDajVh?=
 =?utf-8?B?UGVtWHZNZEdWcE5rL0Q5ZHNITFh2c0xRU3VSbmpwV0xiYk9KZ3pqT0lNeTIx?=
 =?utf-8?B?eGQxVWNrZnZuVXRZc09ZNmRVMVhpTlBLMGpsUXZGNXJEdlFyazhEcFNGK2hE?=
 =?utf-8?B?L0tIeWFhMGRmSDNVOUZTaGFacTBEalAyNVVnNU8vWkVKZW5EQW1JZGlERnhh?=
 =?utf-8?B?OG9GNVQyRmh3SzlWNitPZDZ2MnU3OUxjUlhnczkwTkV4N3BTOGhvak0xL2tx?=
 =?utf-8?B?cUVEZ240Y3dSWEQvdG9pcTdDSEJCV25IYVRGbFYxb3QvR01zdEh6eWdvdHgv?=
 =?utf-8?B?UzhmcE8yZldIVVFrNnFVU1FXZ0IwcDVaYmxnMjVVekpySng0eS9UYkwyRmYr?=
 =?utf-8?B?RFhYOHMyL2g3RXJ3aG1iSmEreWRVZkdZaCtpUmdKRUxxNk9QN2lObERKQVdz?=
 =?utf-8?Q?NuUxBc6+a4Lm2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGRjMjZrelJtd0c5d0xadFkwNFhuY3JDVHl2M3oxUVZLdmYwcitMOEpwNXZ4?=
 =?utf-8?B?aHlUMTVTOTVkeVFCT1UxcG9palhyNGMyb0dmQ012a2oyRUsyNE9ZVFFRZGdQ?=
 =?utf-8?B?WXpLa01NbW5RTG0reHhEVTkvamJLUlp0L09MMGdaNEJhVXVSbU1Sckg2dzl2?=
 =?utf-8?B?K2pqMG1YdHpnK2JUK2lpMFRxcDMvUVkzMHRoKzB0ZVpiOS9IL08vdkhLTk1T?=
 =?utf-8?B?RDBIa0dMMHFIaUdKYXlkK3FBWGU4ZHdoNmRLZEpVKzF4WUppc0Z5R2gyb0Rp?=
 =?utf-8?B?ZXc0K1pkK090OFY1bEVyUWlBbE5VYWV1bzQ1MVB1eDh5dkY0TjBScmtaRXpI?=
 =?utf-8?B?eHFJK1JOVC94dXEzeVRXdWxrYjU2VEhkb1J6ZUZ6cXpyREFsU1FLWWhvNVhk?=
 =?utf-8?B?Z1E2ald0MEs2NElxbVA5Z2RReTNHaGk3TlZmMHZERDNnTDdLdkszTmRROCt4?=
 =?utf-8?B?V0J4Z0ZIWlJqOUlnYjNVNVA5V3VzeWJMTWtYMldEUGdxZGgrVFU4OVhyR0xP?=
 =?utf-8?B?cm84RWEwc3o5dmhiMm95cVluYk45eWdDUUprZjl0amMyaGIvMDN2eGJmTk1i?=
 =?utf-8?B?em1tY0lUcEVkdEhBYnlENTE3cVJjUHpXWTNmeDlZSkx4eEREV1kyMkpQK3hJ?=
 =?utf-8?B?R2FEWElXMS81MGJXeE1iUzBLRlR5SWc1cmZsUE1jVXpGMTRYa0ZHL3pVUC85?=
 =?utf-8?B?b1pKdnBWRUQvbXgzdi92a0VBNi9DMHFlUFJUVUpEMHN4c2Z2NTJQY1J1dC81?=
 =?utf-8?B?TkVLU3FyQWNTRHhTVlZEcTBQeWtjc3FhVjBmQ2k5RnNSdlFodDdRaHozbElr?=
 =?utf-8?B?bVVCTzdwNTJ5cWtZWG1KRm9SeStzUkd2K2czTXdTQVM2TmxSeEpQNVVZSkNm?=
 =?utf-8?B?N25zV2wwdTJzQld1ZnJQd2krTWJKUk5LdU5vbFN1TjF5bURrZjd3RTIydlU4?=
 =?utf-8?B?QUZCdVZFSUdFUHJIYVhRNTdKTThQaFgyU0VJNVF1QlIxREJWRWI3QnVHK0k0?=
 =?utf-8?B?cUNzR3ljR0t1dW4xUW1TSVZuM0I1aW9FdndOc0xlUmkxUnpISWliU1ljcTN2?=
 =?utf-8?B?TjhnMHdYTjdzalVVc21KK0pwTk9rSE1oWkhvQWhXWTdGZWpFby9hUFMxOFpE?=
 =?utf-8?B?WCtaM1JIM2FNUk1oWmRtWEN4V1BTdUJOd0hSQmxUYm8xY3phTGY5UHZaT2N5?=
 =?utf-8?B?R1JQd3JtQ2R1a3NqWTI4S3ZPYVpJTXJia1FQeWZWZVVwWkJEWTFkZ0p1S2k2?=
 =?utf-8?B?RU9PZmpUMFdpM0RKcy9sR0hvSkh5VUs5ZEZGRXRnRTUyN09LcVdTNVJHUEYx?=
 =?utf-8?B?dWxBSlR2UWNyVkYybm9EQ3h4L0JiN1ZqTndrTm1CejlMVXA4cmwweVg5THJL?=
 =?utf-8?B?T1pueHlLcXh3Rkd5a0dBdk0xY1Zrbkw4UDBQUWtJMmNxNUo1a2ZjRGhUYkpV?=
 =?utf-8?B?bHJZdWRzdkJQclNOcFFCVmFVdkZJQ1RMZytOYzFBNUV3QmpKaEhPd3Vua0Fi?=
 =?utf-8?B?dDE4TXgwVk9qeHVVL0tsYVE0L3ZUUnl0Tkt5dVVUL1E1ZkN2anJTNXpGUGd3?=
 =?utf-8?B?WGp3VTV0WGo2RVUxNWlvNVZwVzYvR29QNG1MWHNvbzFZVzVvRHNzZWdPK3pF?=
 =?utf-8?B?QWV3TVBWd1JIZTdTRHh6eHlMNWtjKzhWR00wNTQyNE9GbU1NL1l1YTZVQlM1?=
 =?utf-8?B?OUxKYStkZE5RQ01Fa3V0WHpDTGd6clg2ZGpYWExiamh5WkNvNXFFay9RenBR?=
 =?utf-8?B?a0JPVGJFT1doSmhGWEpKaDZ3d3Npc1d6MWNJSHhqMFZkeU1wa0xaREx3RFhW?=
 =?utf-8?B?NjRtck9uWU1FN3BzMWc4bUowRFRjTisxMUhWK3BlRHdKVWZZUHhXVzhjZDNT?=
 =?utf-8?B?SFZkTi9Sbjk5c05penVJVHk2Q29WaVN4b3pxMkdXMmw1Q1F3YkdoWlFQNmRM?=
 =?utf-8?B?RUM4TUhPZmJpb21yZHhFN0J6MlBnbURFam5KbFdpRDJXb0ZTa0VCTWpxLzBi?=
 =?utf-8?B?dWVBeVl1Unh3L2dtU0wxcVVGaE1lY0ozOGFRUUdQTFdTT1dGd0t1Qzhydjc2?=
 =?utf-8?B?bDVHa1duUUlDS244TlFib2t1bFc0Zk41UW9KNDFOdXhUaW10THpEOGFZRUtS?=
 =?utf-8?B?bTdiSHNuS2UyL2d2dUtwNER2TmJHR2kxNlV3MWZjNzBTNlJBdGlEbVEvSmU0?=
 =?utf-8?Q?Fo1yeCIMYZE1gQNrhBNJ5qM=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac93604-7985-46cb-ee35-08dd46c5752c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 15:46:44.6114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciA6/QvdC8bb68mOuJctdIPzxq2f0PrBUSINiI+CVKOa6GEkoXdB6HLU6K8rIYuzZfdysu+dT3vPq5EYgtABOZ21yhA9Z/BOf40PSLBm46U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10558
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

On 2/6/25 1:33 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Wed, 5 Feb 2025 at 02:12, Quentin Schulz <foss+dt@0leil.net> wrote:
>>
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Bootloaders typically can be loaded from different storage media, such
>> as eMMC, SD card, SPI flash, EEPROM, but also from non-persistent media
>> such as USB (via proprietary protocols loading directly into SRAM, or
>> fastboot, DFU, etc..), JTAG, ...
>>
>> This information is usually reported by the SoC-ROM via some proprietary
>> mechanism (some specific address in registers/DRAM for example).
>>
>> It would be useful to know which medium was used to load the first stage
>> of the bootloader. SoC-ROM shall be ignored and not reported in this
>> property.
>>
>> This can allow client programs to detect which medium to write to when
>> updating the boot program, or detect if fallback mechanisms to
>> unexpected medium were used to reach the client program's execution.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> Bootloaders typically can be loaded from different storage media, such
>> as eMMC, SD card, SPI flash, EEPROM, but also from non-persistent media
>> such as USB (via proprietary protocols loading directly into SRAM, or
>> fastboot, DFU, etc..), JTAG, ...
>>
>> This information is usually reported by the SoC-ROM via some proprietary
>> mechanism (some specific address in registers/DRAM for example).
>>
>> It would be useful to know which medium was used to load the first stage
>> of the bootloader. SoC-ROM shall be ignored and not reported in this
>> property.
>>
>> This can allow client programs to detect which medium to write to when
>> updating the boot program, or detect if fallback mechanisms to
>> unexpected medium were used to reach the client program's execution.
>>
>> Note that this property is already set by Barebox and I'm planning on
>> adding it to U-Boot as well, specifically for Rockchip SoCs.
>>
>> I have some doubts about the wording, especially in the case of
>> hypervisors or chained boot programs. I'm not entirely sure what would
>> make the most sense to put in the property for those scenario.
>> ---
>>   source/chapter3-devicenodes.rst | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/source/chapter3-devicenodes.rst b/source/chapter3-devicenodes.rst
>> index 8080321d6e60d6b1e86c81af86c6850246a0223b..defd1a46e4ffaa4bb085306b5e153d38b740ac66 100644
>> --- a/source/chapter3-devicenodes.rst
>> +++ b/source/chapter3-devicenodes.rst
>> @@ -456,6 +456,9 @@ time. It shall be a child of the root node.
>>                                                          the client program. The value could
>>                                                          potentially be a null string if no boot
>>                                                          arguments are required.
>> +   ``bootsource``          O     ``<string>``          A string that specifies the full path to the
>> +                                                       node representing the device the BootROM used
>> +                                                       to load the initial boot program.
> 
> Could/shoud this be a phandle instead? It might be more efficient.
> 

In terms of size in DTB, phandle vs string probably much more efficient yes.

 From user's perspective, I'm not too sure?

/aliases does use full paths for example.

Having a full path allows for easy consumption, just cat 
/proc/device-tree/chosen/bootsource and you'll have the actual path. 
Otherwise, we'd need a special tool for that I guess since it'll return 
the phandle number and then you have to traverse the tree to find which 
node has that phandle number?

Also, I could imagine some scenario where:
- a boot source would not be available in DT yet (though we probably 
shouldn't write it in /chosen/bootsource since we wouldn't know the 
proper path to it), e.g. USB loading, this is usually done via a 
proprietary protocol and/or tool (e.g. rockusb/rkdeveloptool for 
Rockchip) but no USB support yet in boot program or kernel (that was the 
case for a long time for RK3588 for example and I still have at least 
one device without the USB node described yet).
- a boot source would be available in EL3 but not EL2, so does not make 
necessarily make sense to have it in kernel DTB for example. If it's not 
there, can't have a phandle.
- a boot source supported only in boot program's DTB and not kernel's 
DTB, we probably still want to provide it to kernel's DTB even if it's 
not a device node in it.
- a boot source doesn't necessarily have a label (though we could use a 
full-path phandle I believe &{/some/path@1f000} probably works). That is 
not uncommon for SPI flashes for example.

And additional argument for full-path: Barebox already uses that.

Cheers,
Quentin
