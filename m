Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA61C369A2
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 09:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBCE78359F;
	Wed,  9 Apr 2025 11:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="STLu/i+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 922ED835C1; Wed,  9 Apr 2025 11:28:48 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E57D83577
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 11:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xE9E8IbCmZYx2wU2ox6JTDgcYKbn5AGWM6yVaWVmxWXviCXTZ0q/8Rad7z3T3onoGYfi/QDc+IgAAfVCuBBVsNg+EYL9tZILasVBtQplltQ0XE2s401hAnIWJ7U/qfBeZHTSeXUpjRYHbNUVC5291wN6/xZvyhxgZxoB+8gVjqLBHspg6eo2v8pTlsNvpM7WK6dQTDbizh3//V4YUl5biOn6SWZ3v1HoGrFihZbONMTd3F191aDoKUkj6rsINEV5GYpj8HV1JgdttERmi22zuGHPgr15B8wpsP7Wb2cp03xiuznKHzO+GUfQ8oHUyk2q6ny72T22E+xVPyh4IsFMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEv579LkMkXjlmEjnYdsulYpOSlO4VYA8yJr3STQGLg=;
 b=Jr5ihOltvOy5iuzQB8rLkj/n5Shyxi4pvsyn8QPkEOumggIy4WKpz6YyxZ5C6zj3z88zFcrPhn061Lh6Uic63D1VVThDvtgaJr2xdma9/vQzXk83e7VvCzv5zSzVHwkx+MU4KjKH493m4w14c3908ZbfRCS3c8gWs6CXVWfBhNYv7ugPSsoTYINdqWjkhpdf6rfTU35Tr09aInD1M+Mbj9t1O+/xONBj8aD/nixAxI/VNA9hMsg/E6+mFIvvgttQJStjNu0gAXWsh6eGmWUT/uQUPnxphk3BDBBLMY9Yo7j+XgXXOiJR+kVokrrq9DL95EpNL89zHRRzkkCwMSbn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEv579LkMkXjlmEjnYdsulYpOSlO4VYA8yJr3STQGLg=;
 b=STLu/i+YrC4HQd5JVLz5olkjOpLeTHLmEcFQwhfrlfGM7nqVVTdodnC/QE/n3Ql7ikbS5G+Jg3otJo4OxlbGhu+U3HpBUhvVrXmaJTtT2W1tHDeY5eovbT1mulkTNF+ffoh6fJdflYF+D1Emwk5eab2+rr1Os7Y+lO40eZOWPM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10099.eurprd04.prod.outlook.com (2603:10a6:102:45d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 09:28:44 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 09:28:44 +0000
Message-ID: <cc9d923d-2635-41d8-bdf9-9eab0fa78249@cherry.de>
Date: Wed, 9 Apr 2025 11:28:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] rockchip: binman: Factor out arch and compression
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250329150626.2879942-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10099:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6563bd-8888-4189-acfa-08dd7748ec14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXEzSGJwb3FWR01maFEyejdMbWJ4dnROWVhuYmtmcE9zVUhRVUExSFg4RUVa?=
 =?utf-8?B?Y2dPdWJsdlRzcGQ1U0t4UmdnbERCcFlONGZ2M2JYbmczQ1oyaXg2WnBGY2ty?=
 =?utf-8?B?RVB1RnV0RUNGSVhsdTFjMC9paUEwMlRrSGxPVWMwb2x1VXpLQ0FUa1lZKzFk?=
 =?utf-8?B?LzdhZkdMMC8rNUVZNHBnS3IrUXdobzBBajVpaHhPdXNESzh3VUxzZ011NVRV?=
 =?utf-8?B?dVI3dmx3WTcxWHhVR2NiWFAwaldBUEpxN2ltams3N3FQQWUwMTNYR0RCQy9j?=
 =?utf-8?B?T09IZVZFUlVaTE9QY3hoNjg1QW8xRGJMNW43elNOWE4yZ1ovT051VWY4aFBa?=
 =?utf-8?B?VEJPZUtFaWRRckRzUmVkZVh1c1E2UG9JUVgyd0RPSG1FVkJnd2o3NUtpckRQ?=
 =?utf-8?B?bHlLSjlXMEFOU2lCNTBLUUZXZXAzWW9IbDdIa0ZmVmkwUUV5Tm9HallKcVlY?=
 =?utf-8?B?U0Fob1JGSHhKa0l6aXZjZndFUlFwaWJkbXFJT1BySE9KM3R6OFdDY3dUQnVx?=
 =?utf-8?B?cEs3SFFhcFJOUm9sS3BHUTRwZ0VIdkVIZW9oNWR4T25qM3BuMnFpVGZ5Sm5t?=
 =?utf-8?B?MTdBNVA1Z3pjOFRsM0t3TWtLMDhmaWtpTFpVNkhMWVVoV3FBa0t3c3c3MEZQ?=
 =?utf-8?B?MDRLcysxc1RKT2EvOG5sN3k1Vmx2aU1Vb1YrMkM3eDB2S2FyUWpzQUtXNGZT?=
 =?utf-8?B?aEUzTlp1YXRzWm5oM0hBb0hzUWJsSGkrRVQ2TUg4bE16ckhWL0x4ODVWOXFF?=
 =?utf-8?B?bkVUSnpUWk1JcXp1WXhMblVUTW1hSm5NRlBobFVGU1VmdUkyVnFHYW9tSlBz?=
 =?utf-8?B?WXZIMzVoVSt5dU9May9jZnFmVXZ2NFJzbkk3VWc4UW80c1RxVDVRdjM4NUVG?=
 =?utf-8?B?ZjVkcTcraU9laGE2ZVNqZDZ4bWFXa3NXQ0MrTE94UzBBMG8yQTJBMy9KUGgv?=
 =?utf-8?B?V0IzZE1CWnpocmZ5Si82a2EzZjQvM25nTnpPOUc3T0Y4WktLLzlBbGhhZUtx?=
 =?utf-8?B?T1JxaEV0SDExVWlwbHFsa3kwWUZYQlhuTzJxd1FaYzdOREhWMjN0K3RZTUU5?=
 =?utf-8?B?RVZxU3pHYW81RFgrcWVvbFUxeGxQdFBWWFJxUVhwOUQxVnRsWDZISFY0R3ly?=
 =?utf-8?B?eG5mMUxmWnR0ZHY5aW5yNmxzK0pqK1pYV3IvMjE0dzJ5WFM3SlZkMWxQZE1F?=
 =?utf-8?B?N0RxUER5SGFSMXp3TjR3YUFud1hzWkVxRVM3UjJPeGpRSzBkdmpHekdqMWhZ?=
 =?utf-8?B?Wk5jejFPOG9XNWZTanFQZUVQVzN0ODlzQmNvYVlxVzV3TnVCK0NJZHhIYWVQ?=
 =?utf-8?B?WC9kTWRId2RUL3hxRGVVK05jbzg1NWRiVzRxbzlFYXROclhxYUpBL3ZzQ2FJ?=
 =?utf-8?B?ZENTdU1BMjhlQ3BVQkV3ejQwTnR2eEZQc0VLUnNSSkpaSGZuOTdlT2M1Z3o2?=
 =?utf-8?B?SVEzbUN5NU16TjNtWjJPaVdGZzFCbjJSSHRwS053QnpDQzQzd0JzUTBsTnZk?=
 =?utf-8?B?WVNDZ0ZPNzQzT0VkbUlDckdPcVJVVlIrM2VVZlM1TTZwdXF4TjhjWEZCK2Zl?=
 =?utf-8?B?Nm54VjJsbXBhTmFTNVd6UUxBMnhvY0c1T2UyOSt1U1JYWDFPYU1VOER4V3Vi?=
 =?utf-8?B?a2krekU3dUduV2FDM2RIU3REbUZVM0JrWEU5dmNsQUFqcElwcHRzTUJrWWFS?=
 =?utf-8?B?M3pISjFYNzllbWo3czE1L2ZwWFoxZFIyNVJ1bDRWOEUwNnBCRGdQZDg4NUhs?=
 =?utf-8?B?K01yek9NZ240QzhpS29uV2lHdDk1cW9CZnk5TlVLNW5Ld3V0c09JM2tCRERy?=
 =?utf-8?B?VXp6MjNIdXlpTUtYMlBPWW1NeGZwUDMxamwxUHd1S1lDVlhrNDlrWHFGK1V3?=
 =?utf-8?Q?NYID3TCaJVBo/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhoOVEyZlVZQngyWmFRYWF0eWFXUUhqMk5CZEVDMnhuLzBHM0J4TTdmQkFv?=
 =?utf-8?B?RFlFOFliYk1HVU05T0t3YUxyQ2JJWlg4Vmk2ZkQ3K2o0L0xnNElyNnFWbmFR?=
 =?utf-8?B?aDlzT1pMd3c1d3lOY3JlY3F4ZGZBbkYwMEltZWkyc2NCd1hneFdQK250Y0h0?=
 =?utf-8?B?RDRMSjhTL3lnbWhlbGsrcmU4d1daUDVKNCtKYXZSMHFBS0NRUHhUdUFnMXRC?=
 =?utf-8?B?emJsTkYvbS9pbmtuVlFHSkVPSjBLbHd1WThoUXdSMXhSSitXZGRrR0hHRUUz?=
 =?utf-8?B?YTdjQTIrSnM4OWV6UzZIV2VJWmVGenNkM2NENlhqNnBhQkJGTXlIZ0FzRFMx?=
 =?utf-8?B?emlyUFM1MGhCZ2pTenlXekxhcU93djNVZDFhSzduWEVPbG1PMm11RC82N21C?=
 =?utf-8?B?MkhSVWpKNWxpT2VkeWlSOFVndU8zQ05kMDhEV1RFZ0JJQWQ4TEJNdkxsY1dj?=
 =?utf-8?B?bkZXSGpodGZTWHlyQUJycTlENmppKzVoeG1wbHV5bHRURGhvRzhQZnBtYktW?=
 =?utf-8?B?U0pNTjJHdnFvUXNJU0RIQ3FaVk1jM2lITmxRbWNIZGJGTmJVdEpOQVNuMTdu?=
 =?utf-8?B?Y2w2UlQ3bXFaV1g3TkZOTjlIeUR1clRtYm1BQ2wyY09IRUVFTG0rcEhFR3ZZ?=
 =?utf-8?B?alJiM1hGRkJldCtGcEdjdXIzV1lDLzVCaDhURmJ3cDZKdkZIcDF1cDlUL0xu?=
 =?utf-8?B?Z1hVTFlQZ1lnUE42Njl0MVhFaVAvd3V6c0l1K0dQZDRGWU1iNmtHWEo4Zzl0?=
 =?utf-8?B?cTJ0UHBCbFZ0OG9acHQ5OFdKMDZ4ZGlJRTdkZ0VCaGRpZGtScEY0ZDhjdHVO?=
 =?utf-8?B?Y0R0VXI2YWRHWkVseGxhOW5HeUZtRk5tNFh6dUhGcG1ZbUZFWnE5L05RcEMw?=
 =?utf-8?B?TlBwbTM3VXNTWk91MUhuNGszRG5ZSE5xUXhkSEVsWTE2Y1QwMG83U3kvUUtl?=
 =?utf-8?B?dWpSaW5heTU2d0xyVUwyTFUrNDBza0Z0MzRQSWpKWDdXQXl1UWgyUnhmNDdY?=
 =?utf-8?B?NTB3UlRsSmFGVkxTeC9GQitiaXZHYzJ3eWNMZ3RpeTllVXRkOFlReDR3UXk0?=
 =?utf-8?B?cHh3ODJFUTRHajhmdzJoZm1UcG9NTm5HT1JORXhQSUZtNmZuaE94UmxTVmpW?=
 =?utf-8?B?U2puNmwzOENVeHVPZFZhTkxHYm1zL3cxNnFpemtmRWVBa1daaDFSRis1NUx5?=
 =?utf-8?B?QUYyTHJqaHpsaWhyWnhTNks4UnZhVVJncUM2dmphb2ZUODh2KzE0TDU2UHdq?=
 =?utf-8?B?cVNsbHc3NGc3Tnl6c1VrV3ZVcnk4L3VXeDVYUmhrNlUrcXR6eXZMQmR3UzlU?=
 =?utf-8?B?ZlVyVTZTcVkvMU1pcTBEUUdCWTF4bXV0SlhuM0tFZ3RuVnRSTWpPU1BQWURn?=
 =?utf-8?B?cjFwcUVUUGZValRnYWJlV0RNUTBJaForci9lVXdrOHpqeWVoVHF6ampzRzlU?=
 =?utf-8?B?NURJUmFzSWVvUmFYV1Q2VXpaV1N3UHRPRXlLczFqM3hJV2dOU2s3WDlrbCtz?=
 =?utf-8?B?SDY1YnFSWlE5MU9jc2x2UFhOc3BVanM2VWlDOHp4RFlmM1pIWkd0dURWZTZ0?=
 =?utf-8?B?Z09zUmpjM1ZPQnQzN2toK1VmRWI3MXVwc3gzbDZmbUZVSFFkd00yMnJzdEZP?=
 =?utf-8?B?TDRMNWlTR1ZiVzIyMEkxREdVZ01yQW9VaUZxK3BvN1kxSG81NE5BS0VQb3hS?=
 =?utf-8?B?em1Gb3VVMUIxanJYTCt1N3p3QzdDK0R1dmV4RW9iWEFqTi9GQjVGcWN6d3dG?=
 =?utf-8?B?YVlOZ0FubnFIVFFCK3d0a1RVckZtREtmTm9LN0dqSWtyYlpvSVRKWHp5L2ky?=
 =?utf-8?B?Ym9tYVBtd2IvVUk4K2llTUtyZzFQZmpPcEZGR1NDZnFXYVo2eDVaMFFIUzJ4?=
 =?utf-8?B?aGFLNXdvWUNvNlQ4ZFJkVVdReHhrb0pxWFM4MVZNR3UvQ0g0TUFFbEZUUWY0?=
 =?utf-8?B?MlZWNXdWOTVkazdmd2dWc21BdC9LQUNmTVRuM2txMUZZc3lSWllndFM5Y25l?=
 =?utf-8?B?ME9zblNVNWFoOWZ0b2ZocjE5L0JYQ2E1QTRlTmJwYi9UTUlmcWoydm00ZTlo?=
 =?utf-8?B?RlFPTUFJRWthcUllYmtKVCtuWDU1TmxHWU9rV2t1L0VHYUJVRTZRQVRCQ09Y?=
 =?utf-8?B?UWVWZXpzMDdWblBxdDRsMm9MdEpnT0NEUnlYQWNrUTlyc0tUV2NzYnIwVDU1?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6563bd-8888-4189-acfa-08dd7748ec14
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 09:28:43.9994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/JgV9b0eEM7tzhwDCU3UqR6n2WNCEA7eDCKs/Ib2So8dR+LMDgGUMLqjNcFoROxRaCfLGL6AsjgTaDbK/U7V6QxYBbtQA6lnF4ahezgsLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10099
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

Hi Jonas, Simon,

On 3/29/25 4:06 PM, Jonas Karlman wrote:
> From: Simon Glass <sjg@chromium.org>
> 
> Declare arch and compression at the top of the file to avoid needing
> ifdefs in every usage.
> 
> Add a few comments to help with the remaining #ifdefs.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v4:
> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 44 +++++++++++++++----------------
>   1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index e9ed1d4b5738..2b01dc660562 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -5,6 +5,20 @@
>   
>   #include <config.h>
>   
> +#ifdef CONFIG_ARM64
> +#define ARCH	"arm64"
> +#else
> +#define ARCH	"arm"
> +#endif
> +

I would refrain from using ARCH here as it's something we already use to 
specify the architecture to build (e.g. make ARCH=arm64 CROSS_COMPILE=...).

Maybe FIT_ARCH?

> +#if defined(CONFIG_SPL_GZIP)
> +#define COMP	"gzip"
> +#elif defined(CONFIG_SPL_LZMA)
> +#define COMP	"lzma"
> +#else
> +#define COMP	"none"
> +#endif
> +

This is specific to the U-Boot proper image node only, maybe we should 
have this constant named more appropriately, e.g. FIT_PROPER_COMP or 
something like that?

Reading the symbols also, I believe their help text is misleading or 
confusing (at least the _GZIP ones, _ZSTD seems okay).

Also, I'm wondering if it actually makes sense to force a specific 
U-Boot proper compression algorithm based on a symbol of what 
decompression algorithms are supported in U-Boot SPL. Like, why should 
gzip be picked if I also have lzma enabled? In any case, nothing related 
to this patch.

>   / {
>   	binman: binman {
>   		multiple-images;
> @@ -51,26 +65,12 @@
>   					description = "U-Boot";
>   					type = "standalone";
>   					os = "u-boot";
> -#ifdef CONFIG_ARM64
> -					arch = "arm64";
> -#else
> -					arch = "arm";
> -#endif
> -#if defined(CONFIG_SPL_GZIP)
> -					compression = "gzip";
> -#elif defined(CONFIG_SPL_LZMA)
> -					compression = "lzma";
> -#else
> -					compression = "none";
> -#endif
> +					arch = ARCH;
> +					compression = COMP;
>   					load = <CONFIG_TEXT_BASE>;
>   					entry = <CONFIG_TEXT_BASE>;
>   					u-boot-nodtb {
> -#if defined(CONFIG_SPL_GZIP)
> -					compress = "gzip";
> -#elif defined(CONFIG_SPL_LZMA)
> -					compress = "lzma";
> -#endif
> +					compress = COMP;
>   					};
>   #ifdef CONFIG_SPL_FIT_SIGNATURE
>   					hash {
> @@ -84,7 +84,7 @@
>   					fit,operation = "split-elf";
>   					description = "ARM Trusted Firmware";
>   					type = "firmware";
> -					arch = "arm64";
> +					arch = ARCH;
>   					os = "arm-trusted-firmware";
>   					compression = "none";
>   					fit,load;
> @@ -103,7 +103,7 @@
>   					fit,operation = "split-elf";
>   					description = "TEE";
>   					type = "tee";
> -					arch = "arm64";
> +					arch = ARCH;
>   					os = "tee";
>   					compression = "none";
>   					fit,load;
> @@ -119,11 +119,11 @@
>   					};
>   #endif
>   				};
> -#else
> +#else /* !CONFIG_ARM64 */
>   				op-tee {
>   					description = "OP-TEE";
>   					type = "tee";
> -					arch = "arm";
> +					arch = ARCH;
>   					os = "tee";
>   					compression = "none";
>   					load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;

Wondering if we couldn't put some of the Aarch32 and Aarch64 OP-TEE OS 
node(s) in common?

The change is fine, finding a more appropriate name for COMP and ARCH 
and it's all good.

Cheers,
Quentin
