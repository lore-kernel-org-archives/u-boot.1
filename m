Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9446CD2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 15:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2515683A6A;
	Tue, 20 Jan 2026 16:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="W9jRazsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DE2B83A8D; Tue, 20 Jan 2026 16:06:39 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 785D183A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hv1I/2X99AX0LkA3Wyaj7pX2qdDBxMRPBuoNTsZ7y+uqnF/BkJ2AT54fQq6NoBnglVyHEA83IDaVdxXFZHJDm/6Dvd9s1OGsAkboae2udLzHwkbbXBpeS0bqBYrxRFF1jyXO59WfH36/hDp2/414seMPmkySgwJUOI4b0FaKtcVZatlMGZnp19HJQrSeQOL9//NZPDHX4Hu3ZVaGFipGL29sv9voPWIfV/x2PBQt2eivmvKTkWxwF0fWXSRYB52Cxx44LWpxEEsr48plh2vbwPxxmnELhxd3fl7utNv5yw5AFcVUBog9W97faKBSMFfiNuTh8asVwWiJT5zxksxjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpC9ekYlC/1jvX+0LvFcTsUKWrkVaJSKWjPyeM/fmZM=;
 b=rT7+cXj3Nol47Hf3DCMp/0VMG8JVNtHhAwmUkfqholSFEUrNrvCsgVpU+kEy8zQuoCz/wfqSxK7otR8ccHE9ojRmpBfxyFybjoixkdXG1NvT7aoiwZ7tyR8XKpwe7Xe+MzPeK83/K1F6a584MD4udklNHhHfMpImt2FlEnCgNMdJoNAjZlRfOkoETrLQL50lS/fhdyxy+OnafBw3Zgz2YROQgQTygNLAWA2m5mVij3NSbVGVVP96Gq4FNwm0XbYakshtJtC7XU0IiOoy/vtymRq25CX+G8owuOFBoQp3zFBDZ5LUSbZUghSRqQPHTkqq1vrDr70lY3MGG7/6xZDZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpC9ekYlC/1jvX+0LvFcTsUKWrkVaJSKWjPyeM/fmZM=;
 b=W9jRazsuVLSVcHWU0Vl5X1281LXwfS7yWMX9KLxwVEofmiyLaAE6e7Sg7PfWyIjM0Scb2tPwCI8it2IkaLhF+IxJsRxc4qOL1N4Z5NbYHBdTAfZR7ZNU8mNTkoXn5ATNLIn6m5xjNf8ai3MB0BKxes1WwABIrskCDWyOJctvp6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB8718.eurprd04.prod.outlook.com (2603:10a6:102:21d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 15:06:35 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 15:06:35 +0000
Message-ID: <03efe992-ea6f-414a-8a8b-f584e57880b9@cherry.de>
Date: Tue, 20 Jan 2026 16:06:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] binman: Add dump signarture option to mkeficapsule
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, simon.glass@canonical.com
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
 <20260120081206.251544-5-Wojciech.Dubowik@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120081206.251544-5-Wojciech.Dubowik@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::6) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 7058c9f1-5d48-4a07-d743-08de583580e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzF4Mm40aTNnYUs1WGdFQmpRSklVOEg2VDRWdDdmRFAxbTVtVUhKaittQTd6?=
 =?utf-8?B?aWRBMDFGcG9tRHp4VTdIeXd3bm5jYVpSRlA0SStScGIyQ1NyczlCTzdmRlkv?=
 =?utf-8?B?eTZ3TnVKaDZlQWliTHVBUEVZNmVvQ3kyeS92Vmp5a0pOQjdPOElMM2h3VDdR?=
 =?utf-8?B?RDI0VEV1RGdlTnZOenpHRWFJTGVYWjZNb09JYmxqQTdqR0huQTZ2MGRsbWRF?=
 =?utf-8?B?TEVxeXF3MHJmanZ4aHVLdWlSNlNnOUtndSsyZ1pOSkcxM0tOaXNzOFVYb2hh?=
 =?utf-8?B?QXpkdDRmYWtZc3dleVhVYWhtMFZBZm1MSS9TQ0lzelh5emNyWXh4SzZpL3V3?=
 =?utf-8?B?UTVhVjNuYTVPRHVJRVQ1UERaSEltblRod1lZRDhIQlFwcGRIYU43bjZiNll6?=
 =?utf-8?B?Vm1OZlJBbTlvZmVyL0MrcnZMOWRCb1c1UFI5MkJ0QVJRWk8wOHRWRWwrbVZo?=
 =?utf-8?B?TjkrMS9oZHZCZHJwU2dHUktDQ0FJN0pMbm8vSkZpc2dtb0wyaGVJYkh5R3or?=
 =?utf-8?B?WjNsQ3dvRWJZMGgrb1B4YTRzMEtEdXF2LzlsSFRFcnUrVHFPeTVsekhPOUhF?=
 =?utf-8?B?RGR0U2J5ZGJjeGdhZ2RqZG1LRE9DK0ZhTXcvS2VhMGY5YUZsOWFTZ1dFVE5x?=
 =?utf-8?B?ekpkdi9PTXRxdzBodVpSaFUyR0xOU2lYVkRqTGZsUUdud014TTVmeEFSSlVq?=
 =?utf-8?B?VHVOTnBqTDRINzZkWW50MkY0Mk8xUUpDK3BzUzJqWnNZN29MZlA1bXdiZG5G?=
 =?utf-8?B?RTkxWTB3QUFBeGlhYzBlTVcvOE92U0FUdFR2WG5zRDJQWHZxcGpBckdDNlpl?=
 =?utf-8?B?UW1jYlMwTWhIdGQzeExUSWcyYUMvSnlkeFlmcmI0NW9Va2JxcE1PRUFqejZr?=
 =?utf-8?B?ZjM5L0lCTUV3ZW1DNHB5OTFiVU52dVc3OVVhOS8yWlBiZ0UxSzRmK3RGTzhP?=
 =?utf-8?B?a0pWaDB5Mk9yWkx0SzBNakpGTnNmZ2JzaFE1ZDQxUGFWNm9CZFR2RSsyZ3pD?=
 =?utf-8?B?eDJwNEh5cTV3dlNhUVlvb2RUTGcxcHl4ajVuanp5OTJHZi9Kd3FxM29DYW9X?=
 =?utf-8?B?SDBVYVpPUis4elJvc3A5eU0zT1lsUUd1UFZGREcyeWZQTXBhQmx3SzNTbDBM?=
 =?utf-8?B?WWphSTBranJqVUw2eVBVK0RzNDhTM3RIMmdEaFZ5T1Y0dEU2RzE3KzJjMnFl?=
 =?utf-8?B?ZW0vdVYyVE5OTnFWNHh5VW9OWlRGQWpiQjNFdTBvdEhQQ0xZOU9VTGJWekNl?=
 =?utf-8?B?cW5DV1h0ZUpYb3Y4eUFBSytDVm5jeEV0c1BGaklNdkdZTDM2blFaNzd4YXcv?=
 =?utf-8?B?UzlJak8wck5PSzRpbHN3aExWZHcxa3JWbXhFTG5tMWkzbk1jSTU2RkxaREtx?=
 =?utf-8?B?N1FTMnUrVHZ3N2JRYVV2MzNVVGlDSkpnRm8xU092YmVqV21NdGZVSU9DUjBQ?=
 =?utf-8?B?UW93dy9sYWFtZHN5WlVPY3JORGZEOGRMbXFlUW5xSXFiYWJiR3BxOVM0eE14?=
 =?utf-8?B?bHNKT2R4cDN0ZHBJdWVnRGxWcXpkK2s2OW1EbkgvNU40MElNTXFuWVN0QUhw?=
 =?utf-8?B?UENxMkprV1M3ZnI4R2k3Z3hpNzY1bXZCekhRVEdlQWEvRlF6SHpudkZFZ3dN?=
 =?utf-8?B?M2JSMU9yVjdBRlhxM0NWbzg2QVBxZ0F2K3NOOURramU1YTZydVRQWmY1K3FP?=
 =?utf-8?B?bVB0KzVMc1BxSW1MMXE2OE1UemJsTWJRcTg5MGZmSXUzU1JjN1pvYTlVWmtH?=
 =?utf-8?B?YWttRXBhQUk2UndIMkZtdlErN1V4T3QyWWkwalNzL3Q0TVZIcFJUYTN5TG15?=
 =?utf-8?B?S3g2T2R2TWRjZ0hsRit6dW91Q3FvZkRjOW5mRDAyZ29BV2tPcFprQ1BDRUpa?=
 =?utf-8?B?UkIweG9MM0E1bWpEb1dtZmxBMjE4bTZIZGpZcXZkUzIvNUM5VXdnYStjWlhR?=
 =?utf-8?B?SGhuVVM4UkZlNFZ3a1NWc28wS1JrSzdUaElVRS9ka1JuM3JZc1hvc0R0dEMv?=
 =?utf-8?B?OW9naFVtWXJSTFJGaytlNFBqSCtkYWdHWDFIeHNTbit6MWJYU1dmV0xrR0x6?=
 =?utf-8?B?VmZrMWdFZHgyM1hybTZ3SS8ydHIyclVvUU1jQkV1NThtQWY0REhYdFUyMHVS?=
 =?utf-8?Q?0ueQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjdhMFQ4aE1ReW9GYm96OFZOcUROc01iMzdtQUdCSTJwUmI0M2twNndNb0xT?=
 =?utf-8?B?dG94eG9xRlpLOGRjdHF1OW4rdnhiZlE2ei9GZGxyQ2Q4N1dmWDBNZTROZXZh?=
 =?utf-8?B?dnRRaFJkQ3BEOVNlSzVUaGlRVjE2dEgrOGc4WXhsUEJuci9uNUp2Y0wzSWNi?=
 =?utf-8?B?RGVQS1orY0lFUWEwUTNPRDlDdVR3ZTF0c1lNSjY0Q2RueDJTcDJlSjl4eWQ4?=
 =?utf-8?B?dWxIdWFkUmV5TlJBNW1SMmVLWmUwR0VtME5sRWphN2lDQWcrZUFtUDN0TExK?=
 =?utf-8?B?RGh0NHZhbkovNGdEUHAxRnQ1d1pMMWd6cGNLNFQ3VEFEbXpCTmppOFFMWmlv?=
 =?utf-8?B?d2dyN2kyR2x5bE9KSW4xQVVTT1daWGVHbS9xRUNQc01SK3N0V1d3K2haY1ZK?=
 =?utf-8?B?dlJobllhQ3dHMTdNWTZDd1cwdEFmeXY2TTJSd3Flb1BRS1RUNUpuL3ZPOTlq?=
 =?utf-8?B?MDlOblkvOU4yaUx0eHgzZ0Y2cHRGVkpvNm5ZcFE1SG5vdlRMZmYrUGtLWlJJ?=
 =?utf-8?B?dnREdUlkQXBuUFlORUJxZ2ZVSDliMmpqaS94VzBKR2tlSXQrQk84ZlgzQjFQ?=
 =?utf-8?B?M1ZoaGI5SEhWUE1mSThvVmpxNUtoTHdPN3hjQ3dncEYyOWUyc0xhNHVEMENv?=
 =?utf-8?B?aXE2VFlpUVQweXNXTGRaV0hwTi9HdnU5eVZEQVFVRlBtTldva0xyWk9CcUNu?=
 =?utf-8?B?a1RzZ04wZmsxaExxSkk2bi9GeDA3UWhQYytIWEVNcUM4NVNQUGZNb2tYVytF?=
 =?utf-8?B?enZrL3JoZEtMYkRvcy9UbmUrSmRYRVYrQml3eHpoL1NDTWJhZUx0MlhVUUJX?=
 =?utf-8?B?QjRwN0Q2aitkSkxWeHV4a2hKeFZPYlpqcUFqQWJxRmk0cDl0ZTBvOVNkS2Y1?=
 =?utf-8?B?VFloSDU2M0FkYnJ6U1ZQTXJTVjdDVVNqQ1I0WUsxVDMwQWFQZ2pnMUpSRG1P?=
 =?utf-8?B?eldCcjR3NGEyZ3ZWdlY0a0g2QVdFUGl3VmJETkVsZ3VtU1pDbkIzVlBoN0dx?=
 =?utf-8?B?WlE0ZWVFZy9VVEc2anJyRVgxQ09ULzkwMnhIejlhODQ1NlZIOFpUSWFKanRm?=
 =?utf-8?B?NDhXSyttMDZPdEtYL3hIdVYra2hPU0xXMjZHTkMwK0FXbloxOC9uTVo4cnFt?=
 =?utf-8?B?eEdvY1pCQ2tiUnluSTZIYTJuS3dDMklZYmJPbmg2SjRFaW9hTWpyOXl6NDYr?=
 =?utf-8?B?NHBYNWdyOHg3d2taSGVkNG9FQm1kYS9lTE9ZMlpETUM5OEt6bndWMWEvZjJv?=
 =?utf-8?B?MWtEcE5hK2hMTnJMbG44RXZ4UnFtdjd3bWkyZVJCYmtPVjQwQ0ZhZkhaTGVR?=
 =?utf-8?B?NVdhQW9tT0FpUmZmVnduY2c1TENJNVBqcUhTazlRaWQ3UGlVMjJkaWcxR3pr?=
 =?utf-8?B?Q0hEKzFsU3NWRXp6ZG80UVROTDMxYnpZQ1lTWEdBQ1BacXZMaDBYeTlSUHNP?=
 =?utf-8?B?cVZ3UHI2MDhwYzh3bUsyYVB2b0xmS0R2Sm00MEhUMzA1KytsSmdKKzBRQ0w5?=
 =?utf-8?B?U0dxRVRoZDV2S2tGSlczUktka21hZFd5NlFPc1Y3RjhiWnNxRlhBcGVRZEtW?=
 =?utf-8?B?Y3lRc0p2V3lpeVRrVTJsNU9DTkU3cDIvTTdUMXVIWFdFUWpadlFhaWxrLzdQ?=
 =?utf-8?B?STdJS2swVjg1Nkh5LzNCTUxRSzVqZjYrTEpxb3l4YzhxUjNhdTdIOElKQ0xT?=
 =?utf-8?B?SWVtRDRZeFBKaU5FSGFrcTRJL0wwNkhiOC8xOGFSWTZMYWNtc2VaRUdlTnQ2?=
 =?utf-8?B?QkRGWWkrVXRBcytRNTlsRDlnamlMOXVpeUQ0eWJaN2dIZ1Q1dFBMRk5GR1Zu?=
 =?utf-8?B?TTBrRW16dlY3UmZLMjJ1VXJKV3FnQzVzRkowcnhLY1JGencyV1dVMzBqazRz?=
 =?utf-8?B?Z0o0U3p0eFdOSnhWbitQN2hEYXZpNXNSUWRNRUlXV1RoU1JVUkd6dkg5NmNx?=
 =?utf-8?B?MmxKR1lSaktwOE9kTEkwYTV2WHNLOHMxcTdtTGZKRGVaekNCSmpKaGxyTGhS?=
 =?utf-8?B?bGlQRVlPM2lFNndmcEdqOEdjOUNlajByc0lpRTlqaGEvYVdjQVVLS2lvaTdE?=
 =?utf-8?B?Uldxa2tHdjdFY3RZc3l2UXhsWldxWDViQ212Q3NyTzJtYjNsRy9lWFloNjRC?=
 =?utf-8?B?R0dEL2xKMDh5Rm5ES0dObTJIQ01sVHVQWlFQdnJvVG9QQ1lKQU5vYnN5UUpD?=
 =?utf-8?B?U05KTHNPSlRpSmg0ZE9ra2Z2MmJyRWNvbVI3R1dydjZQWUdQekg0WUlCaEdX?=
 =?utf-8?B?bVV3cU9NZ1E4OTNFcEV0dkp3OWFybTB1TGNXYjFFRXRaOEt4cmNsV1FHK0Zk?=
 =?utf-8?B?cFNHM0dmZDVjMXRwY1V2cmxZdURqeHBZVkhqdkc3OVlLc0RGVnEvOVE1b2RZ?=
 =?utf-8?Q?EJSp9nxePOEDyOFeYWuyzAAUccLk3ylBWIji3?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7058c9f1-5d48-4a07-d743-08de583580e6
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:06:35.4104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67NmOBELvuDvjwJ3JRLl1yJzsKgIS//UWhj04yAnPTRUlAvHcFZ8LrMoujLgag2nrVXVGqNT08c93Sg1PMhPceCBnfLXfN018jdFqw0/jrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8718
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

Hi Wojciech,

On 1/20/26 9:12 AM, Wojciech Dubowik wrote:
> It will be used to capsule signature verification.
> 
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
>   tools/binman/btool/mkeficapsule.py | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
> index f7e5a8868495..f4b594b3faef 100644
> --- a/tools/binman/btool/mkeficapsule.py
> +++ b/tools/binman/btool/mkeficapsule.py
> @@ -38,7 +38,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
>   
>       def generate_capsule(self, image_index, image_guid, hardware_instance,
>                            payload, output_fname, priv_key, pub_key,
> -                         monotonic_count=0, version=0, oemflags=0):
> +                         monotonic_count=0, version=0, oemflags=0,
> +                         dump_sig=0):

This is clearly a boolean flag both in tools/mkeficapsule.c, the 
dump-signature boolean property added in the next patch and how it's 
stored in Entry_efi_capsule object, so please make this a bool.

>           """Generate a capsule through commandline-provided parameters
>   
>           Args:
> @@ -53,6 +54,7 @@ class Bintoolmkeficapsule(bintool.Bintool):
>               monotonic_count (int): Count used when signing an image
>               version (int): Image version (Optional)
>               oemflags (int): Optional 16 bit OEM flags
> +            dump_sig (int): Dump signature to a file (Optional)

Ditto.

Also, specify the default value (false).

Cheers,
Quentin
