Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2820CF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6356588B27;
	Mon, 30 Sep 2024 14:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="duke+0AG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A8E788DD8; Mon, 30 Sep 2024 14:03:46 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 604D688A3C
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKlroeGI20oHAUUOQRf+yo94W765HIFKlWdxIxYEwawZb7TU5tMXjpO7aF6cAzyJQpJ5YZwclnBbq+0vlVWNhPE9PDSAQRqwsWC4AU9Qv/CwHAAQy9OZRzIFvcXLEUn3i6oaGYGl6UWlwV4p5TP1O40IhBYkSGmhFvJQO/MbAAHXSPsnLawYhky5AVtIlLzHkqzatN3dDydndKKK51AKSL/+7tWVsyVqZkhDpmb0qG0SEG1+MCbXsRPP2p90s8dUrD31TR3GnLGc0B92MvFJjPFDWR0ydpOBnyPnosO1dajZjPOgUHw4Y1sXS798bnujViyiI1dWxNiyWmcGbwyz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JE0V8eZXRfj/03dxv/V6MY2iYotUgOANZB4QUVsqUXk=;
 b=r4KnGt+A5p0mMegh5V6bGR+pJazCytn14+4p/HZM8EDu+1fX1DYx9AUptWbwqe/92VJ+YI1y3LBy72BbxYiGPIvENPUNOKTjJpkUtXQaxlBiJHZifI7RlrZTF4Kja/5lJevV6oObL+GL2RKAVYuUtQSthFANSGyQQIXCKf1ZGs55bv4WYKhc/r65cS9HnZjdvSuuO6pCSw9rjzr6VZVR9AWn6C4v2S3YnfPAehNlDH7+XU000waYqTDp5E5tNxMOVwdmnbiNP3uI04S49l8UQ2AbEI2gPEArj9cZ29skniNvOSK4mZhv8HohZ5xwPPBT8JzxCR5MdolbZh2r9Wb7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE0V8eZXRfj/03dxv/V6MY2iYotUgOANZB4QUVsqUXk=;
 b=duke+0AGyLplilopF81J8CIBONtFahd2pHfAldIt9s2Ry4Kuz/dRJAaTKafEuHuR1xUlAieMhOZ6KX+bmOIR7q2WZcs0c1F5X5x3JxJ3gUF7dgEqYvZcomHGX0+FJLqA7cnPTYcWegx6DOdvM5ZgxTKUQJw8aW0/Homu5Xn2ocY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI0PR04MB10616.eurprd04.prod.outlook.com (2603:10a6:800:263::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 12:03:38 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 30 Sep 2024
 12:03:38 +0000
Message-ID: <037f7ab2-1c74-4e65-8774-d2524ba86f05@cherry.de>
Date: Mon, 30 Sep 2024 14:03:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] rockchip: Skip serial pinctrl at pre-reloc phase
To: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240805084350.3895788-1-jonas@kwiboo.se>
 <6df6a6df-f8fc-44c3-9688-6f2ccbd8888d@cherry.de>
 <ea4c0f12-bf49-405a-afdb-3312e1eb8c95@kwiboo.se>
 <4bdb19d3-db99-4456-b7db-a96153a3f7dd@cherry.de>
 <5041bde8-fb1e-4c97-9c71-2007008ad3d0@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5041bde8-fb1e-4c97-9c71-2007008ad3d0@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::20) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI0PR04MB10616:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b13c10-f1a5-4059-c24b-08dce147eb11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjFhNktMMlQ0Vng1Q29BTk1NeFlNZHR3aEhiOGtCMi83S2IwdlJ4SDBjRmpH?=
 =?utf-8?B?N0JoVnlJMEF3OFE0bW1HbEdKdWc2NWg1RmZaaS9FNGQ1QmxCRjhzblMyQ3Qz?=
 =?utf-8?B?ZW9WWno4eGdOcFdsUmlyVGFURDUxekZjbGhaR2QralNWdFJPNmV1YmxqTUNv?=
 =?utf-8?B?YXdUaFJmVXVmeUZNVDdhQXcvNjBWSzByUlVnRXk5LzdIKzltakZUNHNqbEM2?=
 =?utf-8?B?R2NTSUVsbmRPVVFuZTdhekN6VmgrRjRsVFBlN0tOYyt3ay9PWXZyZTU2VUk4?=
 =?utf-8?B?NkVaVEwzNlBocStFY2QvaExrcXVkT0daYytNYXpMcW5PUWk5bGw3SFdkNVJJ?=
 =?utf-8?B?bXkrcGp5NFNDVUx0MTFMeHN1RmprWmNaenRTcEZWNExPVUF5cTRHK0JNbERY?=
 =?utf-8?B?SW9VVnpJTXlJcGF1SS9IL1R4QnZibzFXSW15bzltWWtPajhDR3JqamJvdE9a?=
 =?utf-8?B?QVZRWHk5RU1uRmVObnFVQ05Gb3NWR2plOGNMdWorbU0xM1BEZldNZGhWaXhR?=
 =?utf-8?B?SC9QQ1l5cTRzR0oxelo3alZkbnJ3RllwWTEwc08zbGhSWUdvaWh2NFN4T2cr?=
 =?utf-8?B?eDFoN0wrWE9RWnl4Tk9Yb0c2MXBlNGRHZGR0M1dHNlZVUUt6RFJKdXFjNXE1?=
 =?utf-8?B?bnNUcXl5Szdza21ZOU9Cdk9ZZTBqVHhEdVJBMlpWUGNPVEpJVUlMU3hvMExn?=
 =?utf-8?B?T3plZzdZenJKTThCT0NHaG50MFdtREhsNVMweG54ZmUyQ3UybWhUWEYzeTk0?=
 =?utf-8?B?UEswY1NRbVZkNXpWckduNi9qc1l4R1A4amNWQUF3NG5nZkcySUFOS0pLZHJ3?=
 =?utf-8?B?ckd4cXdaZVdmQVlLbGxQMDNOeWpZUjMxQlBYZlgrVFlYUHpOMlo2SWM0OVdz?=
 =?utf-8?B?dXExNWs2dUNTak0zR3hKNUtqSHJxWXVjVVk4UGpRdnhlVTdwR0ZtZ0dlaDBH?=
 =?utf-8?B?b092L2h0bWdZSmFtbklDaWorQU5yYXJ1ZGdLeG44bnNRNHVjVUxjZDBJVGtr?=
 =?utf-8?B?SHppRGIxK1AzY092M3NyTStxNUVYSnExcFdIWmNUd3FzaDh6S3NJRDhETk10?=
 =?utf-8?B?R2JyUjdYS0VWd294aGpoZHRQQ2hVbHhTSkFOeTJ4NUQyTm1rTUx1eWljNzc4?=
 =?utf-8?B?ZGpGSHVZSGQ2RExxWTdSR2x3NXlxdlcvckNJd1hOYjBRU2pOZHhvTXhTMzF6?=
 =?utf-8?B?OC92dHVUSUZkVWdsUU9jYlFNM0J2dDdZdHpnUHFoNjRXUExwbmJXZXZCL0lK?=
 =?utf-8?B?aGFRbUduZjNwTUNuNzZBdUs0ckZPQ0FORFh3ZkhmSVgyRVY1cHFzbU9YdmFW?=
 =?utf-8?B?d3A4c0I3Ukpza2NncnlUR2Y3OGVkZkdaZnBlNVU3akd3azhUWnV0SVU3ZWMr?=
 =?utf-8?B?NHhLY1ZKVGFGN2FkNFZnRDV3ZFhjMGdyVktRMm1vblRxSlhpcjk0WTJlcEZQ?=
 =?utf-8?B?cGNJcExZbkJ5V1NqaTBiNTBEMVN6eWwrdnFONlA1RTlnRy90dlc1cjUvQkJp?=
 =?utf-8?B?ZVMvZTlWREh2bWl4QlVaM1N0bW9waTZIZXowaFk3TjNVNkNvTmhoZW9kc2c0?=
 =?utf-8?B?LzZPU1k0QWV1Q2xOM3VIaTlnQk5DZHFpVkZ1YTU0cnlTdlh2YTJ6STBrMmUw?=
 =?utf-8?B?SDhYVk93a0FoK2FhVEdWL1VKaWIyNTJMbjJyVjd3R1lzaDkrOGN3SkZRajJn?=
 =?utf-8?B?Q3lIMG5UckNaSm1Ja3RvbjZIMGhOckJKZTFSMjh3UHdlSnlabkhaK1dUWjJI?=
 =?utf-8?B?TVpaZmdRSVl1Y2o4UGhLRlA1S0tVV0lXK2VWeHpFeXg1VmZDL2tkZGRvVVRF?=
 =?utf-8?B?cnJsYTJ0cFdId2hPTEp3Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFDQjlLWDZyWjhIMlMvS1lIQm1RV3kzMVV5NS9JbVo2SVRTYjc5NkhFSzgv?=
 =?utf-8?B?VldLb1pRTnlTZ05rRVFsdExpZEg3NHp0VDhCMmlXR0F4enlYMWFNc2oySlk0?=
 =?utf-8?B?dGRUTVkvUTR6dURNZkxhdzV5blUxdDR3NldmVktxWVJJU1B5dGJ1Ti9nMXly?=
 =?utf-8?B?TWRGODFsOFFuT1hUdER5ODE2QUlwRVlNZFhaa3d3djJuT3JKM3JWeUJTTWFK?=
 =?utf-8?B?eUREYkdaM3BCOGh1OHBUTTF6dCtRdjRBRzBpUDgzZFhReUgrOUs2R2d4Z0xB?=
 =?utf-8?B?ZnZsT053Ryt6a21jRnhuWnZhcHFWSzkzMXU5NU91dStLZk5RR1pBeSsyYTBs?=
 =?utf-8?B?SUQ3bXkvQ1kydHJVUGE2bzlOY1VwZHhlVVJITHUwdG0yOTQ0SDR4dTdYSVVY?=
 =?utf-8?B?bFJaMWI5cG1HbS80K0d2YUpVNUJhVXlUMEorQVpNSkU4WkJZMWFpM1BOQktp?=
 =?utf-8?B?amtmaEY0MVRScDcyNDBVV3dVOEtDM3lGaXVVN21HSXR0ZlpZeTJremlydzNF?=
 =?utf-8?B?QmUySW9nVlZSQmh1NkhiSFFPeHlMNy9RZUkxSXFLd3V2ZEV5Z0lzcVRiVU1R?=
 =?utf-8?B?SWN6TFY5YzRpV2RPZXZ5THk2ZS9Uczdsa1VkZTI4dWNZQy9ENlorLzl2Y1Fw?=
 =?utf-8?B?bCtIM0I4dDZ2U0kxbHJwNHljNnQvMUR5d0JhR0VIc1JKTlJIU1ZRWWNYZjls?=
 =?utf-8?B?TGVVRTFuVGo4SitFMEkrNEt2b3FnUU4wR3g0M2lGMnlwU1MwVFBoQ3dFQUJT?=
 =?utf-8?B?clBkV2M5NllOeGRJNnQwOXdCeSs4T2JNclpmRlp1STV2a1lsdmFzZzNIUW56?=
 =?utf-8?B?cy9nQ0IwWXFsT2dGSzNnaVZRZmJ5WmNpM1NqQTZwS3Q3UnZRcDZyNlJLcENK?=
 =?utf-8?B?MzMwZU1ac1d4Z0NDU3FQNEhNK1RTM0lEOGJNMlJJa2FhYnRISnB2U25XWGkv?=
 =?utf-8?B?c0tUNUwydkFrWkxFL25abHVqc25jU0ptV0dZcVhhdVNUQzFnRzlJUWk4L2Qz?=
 =?utf-8?B?VFFqaWVZL2hlaUhmYXBGTy9ZcE9hdnhNTHJwd3FkRitDS2tsa1RXQ1Z5M1dF?=
 =?utf-8?B?OTBKV1RENThsT21DQS8vVDFweGFJUEpWemNDTE9OamRTMWJxakFLdEhHV2Zs?=
 =?utf-8?B?MXVma0hhbzJLUHRRT1FQMno0MXhzYm5RZ0hNUnZhallLM2JyTjhoNWFBc3BG?=
 =?utf-8?B?NW8xUFYzWE1nNGtYdk5kbnNXMDVjd09seXBjckFMODlrZC9SV0pNSXhJQWNZ?=
 =?utf-8?B?ZnJ6ZVlmcGxtNlhUdmp3OW9UcjZwSDVqUWhMS0sxclBmSjliWmVySUEyZHk5?=
 =?utf-8?B?R09HZ0ZIQ2JQNXlSUUYyWjhlc2JmQWwxQnhJWmcySUZrMzRpbU8rcnQyb21y?=
 =?utf-8?B?YXBhVVQxMFRuM3VIemMyNlk5SElJOFFuU0NWa0FzOWwxU3ZJbFBNS0pCMDJ1?=
 =?utf-8?B?VWJTdGxwa3lNd3pERkVFZzlsN3VVZnFObzJLWTJhSnFGZnR6c2EyOWJSanZ0?=
 =?utf-8?B?bldrdVdybTRoK2llcnR2SnNDWGZqaUFNN2RiWkhTYXAxMy9qcmFUQmg4dmlO?=
 =?utf-8?B?dVJPZFVWKy82UUgyaGZxMW9zbXg1OHVzc1NpSlNNc1VTd1lRdVU4eEhicTRJ?=
 =?utf-8?B?ZWVsREFiSHlpajRWa2J6VEVZc1k3WnBmenV4QW15dXNZV3BiSW16aGlEYllp?=
 =?utf-8?B?NFB4U0dCN2g5NHR6bmNJSldZOFpVSjRlMmE5N1ZGd2p1RmRYVDFkeFJLVisx?=
 =?utf-8?B?K1N2YTNSTVFmZjZwK1ZHUStTQnp3cFlMdWdZL3RnSkVkRWhiM0NkdnBBOTdS?=
 =?utf-8?B?cGt4c2E5ZXdnMjdkU2dNVkQ1dTFHbXNIWHpXNGZWTkZBcEp6WVV4ZjlqRHEz?=
 =?utf-8?B?N2ZDR1Y4UmVvWmthNFNURDJJL09KRGMxTW9rWUNaWi9vK0Q1MG5LWGJGTEpv?=
 =?utf-8?B?V0ZzNFBjRDhkdlNISVdnVlpvdFNqS09PTm16SHRuckRXN1ZNdVQ3ODdlUEN2?=
 =?utf-8?B?dndpVCtHMUg2c3FXQ05NWlU4SEcrK2h1SzI4amYwaE1HMWV0Q2hHVFB0d0FO?=
 =?utf-8?B?UTltVGdDSm5GdzZPZ2NlbzBMc0ZOcFJOVENPQnk5blBJY0NKM00yYmpKS2JL?=
 =?utf-8?B?dHNaUjJ2T28wN1RKRnV1N2lyVElha2pVZk5JcEV2WjQra3h6cHBQMFErUUJv?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b13c10-f1a5-4059-c24b-08dce147eb11
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:03:38.4358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3j4xFn8kxnDqJNBLUOPKBl24DIlJ4GsX/klzfdku9mKqRjq47QhVdWBRtU71f/Duzvrd/5xVEV8EoFBRHdaqyroU4/RGxmfdMRFWCqWV4sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10616
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

Hi Kever,

On 9/30/24 12:11 PM, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/8/12 18:44, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/5/24 2:22 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 2024-08-05 12:23, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 8/5/24 10:43 AM, Jonas Karlman wrote:
>>>>> UART pinctrl for serial is typically applied multiple times:
>>>>> - in external TPL or in TPL for DEBUG_UART in board_debug_uart_init()
>>>>> - in SPL for DEBUG_UART in board_debug_uart_init()
>>>>> - in SPL using pinctrl from DT
>>>>> - in pre-reloc phase using pinctrl from DT
>>>>> - after relocation using pinctrl from DT
>>>>>
>>>>> This series change bootph props for the UART pinctrl to not include 
>>>>> them
>>>>> in pre-reloc phase to save some boot time:
>>>>>
>>>>
>>>> NACK. I feel like this is a hack for vendor trees only.
>>>
>>> I disagree, this just relaxes the bootph props currently enforced by
>>> <soc>-u-boot.dtsi files. For boards that has special need they can
>>> still add bootph-all or the bootph-some-ram prop to restore prior
>>> behavior.
> 
> The pinctrl setting for the same module for multi times is obviously not 
> a good idea,
> 
> and for SPL, it used to work without pinctrl which is simple and fast 
> and enough for use.
> 
> Because in most case, people use the UART and storage with is the same 
> as the bootrom
> 
> used, so the IO has been already been initialized.
> 

Is the bootrom really initializing the UART? Are you sure you're not 
mixing bootrom and Rockchip's TPL blob? The latter, I know, the former, 
I'm surprised since it doesn't print anything as far as I am aware?

> This change works for most of the boards and for  different design can 
> customize for its
> 
> usage, them the patch is acceptable, this is different default setting 
> instead of hack.
> 

I disagree, this is working around the DT specs to make things faster by 
breaking some other usecases. I believe we shouldn't have to change the 
device tree when we change something in the defconfig for the board to 
still work.

I would be fine with a bunch of ifdefs in -u-boot.dtsi to have the 
appropriate bootph- properties guarded by the appropriate 
CONFIG_SPL_SERIAL/CONFIG_TPL_SERIAL, e.g. something like (not tested)

"""
// Optimize boot time by avoiding to reconfigure pinctrl already 
configured by earlier stages for console
#if IS_ENABLED(TPL_SERIAL)
     bootph-pre-sram;
#elif IS_ENABLED(SPL_SERIAL)
     bootph-pre-ram;
#else
     bootph-all;
#endif
"""

I also don't know what we should be doing with ROCKCHIP_EXTERNAL_TPL as 
we should probably have bootph-pre-ram/bootph-all set if that option is 
set, in case one uses the default blob from Rockchip but a different 
UART controller or mux so that they have console starting from upstream 
U-Boot at least.

What do you think?

Cheers,
Quentin
