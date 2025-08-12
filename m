Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E322BC87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432338309D;
	Tue, 12 Aug 2025 11:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="r7b+y75i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B0F5830B5; Tue, 12 Aug 2025 11:40:20 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D279E83087
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iabKVJIeTV0Ps63Z279kF7fMvWGXOsc95A2K8OXkjhqbi1PWQHbXIaT6X6VHy0HikAbxy0cpmExbyjfcDbn4x7l1pg5KA3zd3GPO7PVs56DY2VQ7mvMqagIVi3RH4CSLWEV+VWGb79BEXCu1zCdY+IUirdPyn79cBAoFzx5Kma+hNcYFUIpv5OzDsEnox0wIqd5L8K80TjLXLET6smr2RwImyGMk6MQReDC2JnSiBzG+cCMRBkxN9+ah3EZDjLowczSMWFLg48PeT4yV+nz22JJZ03wzwzJP9PjAo9Ur8AKJ7HYoaQDgFbNu9p6MwNdi8HJwV0LjdxkDzx+Ur2EYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oM0L6Fc8vL1ew7W7TljthlOReisMeiaHBXV9ydbrJk=;
 b=IHDQALtggn42pSOn+/FYk4YJQ3l/QmACpTOuWXEGhqb8+B/g2HUEd9kiTOpQ0qWu835Nx3vU9Ac6fLQ1jwAAZD0WTCNVCVE1xOlj6kQ8PC5hYpRVg41M8BH9k/+qfRUfUX5SyEMESgcaRIcdkyGeRkSb4bomMDhtNfERNaQQv07+L9C/T9gF9mxvgDzD7M94Fzpy0f/XjyCD9eMFuX3PGi6vqpT7czEN2uWTePPMfzeIft03R6u+nVWTfmrwrhR7UjwVX6y73+xTO7ugY24aHySpiI+MRxhlNz02H/85unX37RDv0jGxGxCrihCip0cUHXn9iuLN5SG8PAFMrvdmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oM0L6Fc8vL1ew7W7TljthlOReisMeiaHBXV9ydbrJk=;
 b=r7b+y75imK8fDBG/IsZtAMpCCB5dYdle88jvml6PTOkuayTt53+D2mb5NRp0H1CVJLJUnlt+j2SwKlB/5UJodELkUDBbaxUMeUcXKx+SAOFcxNcvTfVrEnhGApSJUbtwLk90Lhr2r3MCsJfxli9Cf1jJSrNd8mZLSigDb0jFx6W+LRkM+TYDVtzVVfUKOSoudmF2BRhDRe8dUyip7UePfhtf6Hz0KHM+fkmjL6hiZo3tMx1C3cL+F3X9NkT2St6eaz2o1Tzi++ogUZrHTa6MdteR2wjluSMb6n+8bY+FUVxyekvxH/ucQ4fCQ88Xw7pVo9SrwTfnMzRuSCdswIqpxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB6950.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 09:40:15 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 09:40:15 +0000
Message-ID: <22e2a843-53a9-49f7-8dd2-5c926bbcf018@kontron.de>
Date: Tue, 12 Aug 2025 11:40:14 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 01/24] spi-mem: sync a bit with linux-6.16
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250809010457.3125925-2-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20250809010457.3125925-2-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf3dd91-d474-445a-3a48-08ddd9843de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkxtQ09BQ0hlR3lwTjFMKzRpcDhVenN0Q05JaG1yd2ZVejVVazBPeUVqb3Zp?=
 =?utf-8?B?ZzVQTlpmL1Y0UlNJTnRVNFFyRCs2Ulk3OUxlL1pOeUcrQzdwNGw5UWxpYitj?=
 =?utf-8?B?T2UyM2NpK0h2VDFnQnNYSDhhM1NoZkZpSjc5eTlWZUlNU2x6QXVsSGZCQWxF?=
 =?utf-8?B?NVBHMnRqclozanNWak5ic3dOMVZmQnRhRW1rUERZRHJMc09PRG0vMmJiYlMr?=
 =?utf-8?B?WWZLTVZrT0Z5OTdFaU5kY2RObWpRWURtR2dwQkRYMitwZ2lFUHRleExJSCtw?=
 =?utf-8?B?NjlCeE9CZzZHa2E3OE9FTGFrTm1LcEk4R3RWcGcwSk5uVUNNNkptd0phdUs5?=
 =?utf-8?B?dml3NlFzU05NSXkzaXQ2WTBON05vOU1YSHJxeW9PK1p6MW5CblpCT2FHUkxt?=
 =?utf-8?B?eFF3UGMwUEJXd2V0TFVCemtUVHh2akhJOEpLWlVaaXdLMi82a0p1a20reWt6?=
 =?utf-8?B?QWk5TGdQZFJkUTFhMHlaeC83ZDc2TDlzdXdJTjB6cFI1MVlqREkzSVdTZGNs?=
 =?utf-8?B?WVp3eGpZS3FlVGlMdVFGNzMrQlNXK2l1VVA2Vkt0aVpEc09WM1J3ejJNb3Jq?=
 =?utf-8?B?ZENjdDhLL21xZ3FIMk0vTkpNRm16cTQ5VDUvdk9raU5WRWczci9OZEVaemFZ?=
 =?utf-8?B?ZllwMmhSeFNyRXJRRjZDck8zWHNIS29SeUVVM3laSEtqOWtoUmNqdUVOV25C?=
 =?utf-8?B?dEl3SkJzN2FybEdGZDNnM0lhaGkzdFU4TUQ4OGhxWUxScU5uRng2Z3c2VmhL?=
 =?utf-8?B?cEt2S1BtOGF0V2JINEhHa0NNc0NseXJ0dkNmR2trQUlSbGUrVnNONzRTMXpk?=
 =?utf-8?B?ekptb2laTitZejM0N290cXdDcnFaNlQrUGRJK2RqQmo0aktzaTlmOEExdHRy?=
 =?utf-8?B?RUFWZnN5ZmgvOGhMVEcrYmVyTHAxSTU0Z1NlSHRLTk9mbDNETFg4WDgzYzRB?=
 =?utf-8?B?bjgxaEphSFY4THdxczJZbkhhSTVtUnFuc1FrVCt5eU5UZnA5Y0tqdzNFcElF?=
 =?utf-8?B?TGpubGx1Y29ZMTFmNnVRZTdPWEE1aXZyMElha21Vc3V0aHI4aEhlYjQ3clB6?=
 =?utf-8?B?K0thczVrY0orTnRUMFJrZ0U1bHBVZU8rWGhtcUdIbTkxT09vbVZOTzg0Tm1h?=
 =?utf-8?B?MEV4ZktuWUU3ZXEzNTFGTzZ0UW9TdDBqblhXMTlSWHkvNG9Oakk3Mi93dW9V?=
 =?utf-8?B?MWxaU1Z0R3BMMW9jUTNmdzQ2eXhSQW1LbWRVS3gyd2w5V1JmSDhlL2ZTbW55?=
 =?utf-8?B?UnVHY0poNzhTYnladllMSi9KZFFjbEJHdThoOHFmVEhsR1BHM2g5cjFoc25q?=
 =?utf-8?B?MEtnV242eVFiQ1VnekxOTmRYS0lPYzFyMzhDbFYwQlpSbnFQbU9UbXNlTW13?=
 =?utf-8?B?UTh1Ty9iakdabjZ5bzdnSVVpaHNXaGROVk5DK1ZaV3pSYmZQZ0c0bnB1Q2Z2?=
 =?utf-8?B?RFVQZTJXbFk5RnJSUjdvanJGMG0rbnc5R0luZTBiVDJ0RTIrNE85SVhublpB?=
 =?utf-8?B?alRsdHNzVWRjb3JSYUdMc2diakVIamQxalNsWWo2M0JNM2VCdUh3Rjh5NEJn?=
 =?utf-8?B?YmtWVUx6aDlkaE1lVzk0anF5WHBLM280ODZlQlhiSWFEMDRYczVidE1jNGly?=
 =?utf-8?B?czdkTmduY1crVjZTM3VDaE42V1lVUThOaHM4VHkwSWY2STgxSUx3MEdDT3Zq?=
 =?utf-8?B?KzY4VFJUSFBHVDNscnl6SVBJcjFsYk5XT0xsc01BYldEUERxU29ERFhSYzRu?=
 =?utf-8?B?c1dUWjZhQzNlb0Q4WmRQRFd5R0xOQVBsYit5QytQT1phaDd6cnQyT1M3WVlq?=
 =?utf-8?B?T1ZScFFpbFNVSFB1NEtaUWVYc2F5YmN1WG83ajB4RDIrWEJVSUpXZ1RrVUph?=
 =?utf-8?B?ZGVVaGUxZ25UYm9SeHBIZGZxczZ5ZzQyblNrYmhSaEhZMWdPQmltWE41Tkp1?=
 =?utf-8?B?aTRUU3p1bDVCYThwK1JoaHdzYis1dklxbXFaMDZYRnZlOUFjbFFGa1JLWnda?=
 =?utf-8?B?RW16MWliUVlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1JQT2NNRVdacVFyL3dYbjc3bUpwdzdCcXhObk9VSEozSm5QSUJkTHVYNSs1?=
 =?utf-8?B?VVlkTkVySS91RVhBY0xKTktsZVpTYldHZXZ5ODk2NERiWGlvVVd4UU1VeFI1?=
 =?utf-8?B?a0duV09FdEd0cjcyZDVqc21rWUw0enVoOTRSeDBPdEJDNFRQUXRiRjNFL1Yy?=
 =?utf-8?B?Z200bTZBMUwwR0ZZQ1hrNXk3czRycVpTUjV1cG9VMkZFSzFIOXlBTVYvL0xB?=
 =?utf-8?B?d0VWcURKMUgza0ZaYjllUHp1MiszMEt0azZ2RFcraUlhQnpoVEhzNkZSUmJt?=
 =?utf-8?B?dnorZ3FLRmw5UlpyUE16VFIwSFFjNzArTUxZWmd5VXgyeVMyS0VGUi9xSWI5?=
 =?utf-8?B?NVptRnMzcVA5eGhkY2hib1EwOVZMNER2RitJVjYweDduVEVsMS9nWGJ1cVpj?=
 =?utf-8?B?WDMwVWE5WmhtTmxhU1dyYnJhclZRcW9aV3dUdDJIZG9MaGIyLzN2Si84S2Ew?=
 =?utf-8?B?V3BOZVJ0OU9oM0Jxa1dGV1dGL3ZuVHdIb3Nod2JuYUZLRHNDMmdwNG9jZlQy?=
 =?utf-8?B?WTY2aFUyWmNBZ05neE4zNzB2ZCs3SVhWUWlnQjMvbTQvdjlQOHYxTEZ0RzFY?=
 =?utf-8?B?Y0pUNXpPbGkzcXJtNCs1bXZERHNoWjFuSnRuYUNSaHFNVkFxNzZYQjhrSUwv?=
 =?utf-8?B?cG5semx1cTA1ejB4NzRvSjYyaFlBVDRja0tmWWticC9GVm9pUDdKWkg0WkRD?=
 =?utf-8?B?QzJiL2hzYUdPZWxhNlQ5S3VvRDR6djJOOXQyZmJ4Wk90RFlUcHdOM1ZlbEdG?=
 =?utf-8?B?b093MlJxTVZVNklQZDFRaWhYOWFoNkNmN3I3NFZrL1FlR3dySjhDUVFXQVpv?=
 =?utf-8?B?Z254TGRrN1RhTlN5K2ovS2NDOGZ4QUVzQk9CZjJKYkdJRFJicnk4cmh4TVY5?=
 =?utf-8?B?VWI3cXFzZnp3Uzl5WVUrMGMvOVk3Y0t5SWVZK25mbnRQaWtER01iSDJEZW1p?=
 =?utf-8?B?OTFXbzRyT2wvOElBZlFHZXNaQVptU1hUY2I2L2Z3UVdjTENseS82cFpmeTZq?=
 =?utf-8?B?dHBvekhFSlNOWVdUYTFwbFhFdENFNmtHS2k1TkhldzcyWW5IVnZnVXlxWVNB?=
 =?utf-8?B?TDB0Mk1mSjZ5aFJUbkV2Q2QvS0RnS21UenVSdFRNR0VaWlNhT0NuQS8yYVhB?=
 =?utf-8?B?bTBiSnJBMlRiaXRocjJDcUM3d0w4U3lFczN1ejAwNlF2ZWhvb1VMME5ZdVFM?=
 =?utf-8?B?MUJaN1dzYmRmVHE0L3dWVklyMGg4REtiZDFUZE1YWHZIekZwTTBlMStXN0dz?=
 =?utf-8?B?NDhYOTRqMWZUMHR6R1kvSVQ1UWdjVnBwN1h6QndtU29pR0VXL2p4TndEUVBU?=
 =?utf-8?B?akI5aGlaTXNleFhEemY3TklTdDdLY1ZTY24zWmJXTWdmb0daZkxMcmRFVEtV?=
 =?utf-8?B?NkVlaFhrcjJFL0J1eEJTSCtuOGtBcmNrNUt5SHQwN0hGdU55aVo5VStsT0hK?=
 =?utf-8?B?cFdSYk9wM2o0ZTFKQ3h0WkVWUHhmWVJOazRZaVpncTREWWRzNzBYTWYzdmlQ?=
 =?utf-8?B?ejROQ2hOUFNZMy9JaVliZzBQU1dxblhYbnhpNzQ2c0g5VTRLMCtzMld5clBK?=
 =?utf-8?B?QnhtdzFlMFZWUUpGdUc4ZHdQQmtHWXl5QUJDYzI1WDE1STR2UWdsSUFSQW5S?=
 =?utf-8?B?SzZxSlJOaUpaempsOWtnY2FZQkMwRTNIdUxNR0k4OHNmWEdicFNRVnNRMk15?=
 =?utf-8?B?U0czZHVxdmxLVGsyWVd5UUw0VkMzRktuTEZCVE5VYkNWRERRTGRWZDIySzZq?=
 =?utf-8?B?dWVobXFlQkNMNEoyL1NEYUU1RDFDRjg3WjdjWWxqRy9YbFI4aWRaVitWL0Ni?=
 =?utf-8?B?Mk5UT2R6NmpKd1AxeG5XNlNjTldnWUszaG14ajl5QkNlWU01cjZjeHdBV21h?=
 =?utf-8?B?QzhhQ3F3bDNaV0JmZXJRc0xjNmdMYnZYQkpjRWllaHlBSmVIcjdQVm56NVo3?=
 =?utf-8?B?L2l3MUNLSGE5ZFI0N3RwVExuQXBncnFsT29uM1ZLODZScUtqMzVPWW5wQ1dw?=
 =?utf-8?B?QkZmUEtxYWNNNVlSaGZDeWlFVUxjUUh1MWxmSmk0bm9WbjFtVWFFOG11aUxq?=
 =?utf-8?B?M3B6akptK1RUdG5ZNEpVWmZiMDFZVWlHZk1PRmFET3Rva3U0T2daZmlVWkJp?=
 =?utf-8?B?dW1TNjRZNkpOdlA2TlkzQjRjbWorbnJ6THd6Z1RodnIzSzJHbHNoTmlMdnlF?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf3dd91-d474-445a-3a48-08ddd9843de7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:40:15.5160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6dTNeCNXmD/fCFo0bQzMaZeUoLOP7H/3DD2+ZOaFN/q8vSDM0pbBsDWx/W4TEuTUNFd4zrK7En0f7BgwqMrRnthrCNfHmUaND1gBce38xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6950
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

Am 09.08.25 um 03:04 schrieb Mikhail Kshevetskiy:
> This also fix 8-wire support a bit.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Please change the subject prefix to "spi: spi-mem:". And I suggest the
following more meaningful commit message:

###
spi: spi-mem: Extend SPI MEM ops to match Linux 6.16

This pulls in multiple changes from the Linux kernel in order to keep
the code in sync. This also fixes octal mode support.
###

Otherwise this looks good to me. Feel free to add:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/spi/spi-mem.c | 13 +++---
>  include/spi-mem.h     | 92 ++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 90 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 3579b7d7db5..6f06650384c 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -120,18 +120,21 @@ static int spi_check_buswidth_req(struct spi_slave *slave, u8 buswidth, bool tx)
>  		return 0;
>  
>  	case 2:
> -		if ((tx && (mode & (SPI_TX_DUAL | SPI_TX_QUAD))) ||
> -		    (!tx && (mode & (SPI_RX_DUAL | SPI_RX_QUAD))))
> +		if ((tx &&
> +		     (mode & (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL))) ||
> +		    (!tx &&
> +		     (mode & (SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL))))
>  			return 0;
>  
>  		break;
>  
>  	case 4:
> -		if ((tx && (mode & SPI_TX_QUAD)) ||
> -		    (!tx && (mode & SPI_RX_QUAD)))
> +		if ((tx && (mode & (SPI_TX_QUAD | SPI_TX_OCTAL))) ||
> +		    (!tx && (mode & (SPI_RX_QUAD | SPI_RX_OCTAL))))
>  			return 0;
>  
>  		break;
> +
>  	case 8:
>  		if ((tx && (mode & SPI_TX_OCTAL)) ||
>  		    (!tx && (mode & SPI_RX_OCTAL)))
> @@ -300,7 +303,7 @@ int spi_mem_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
>  		 * read path) and expect the core to use the regular SPI
>  		 * interface in other cases.
>  		 */
> -		if (!ret || ret != -ENOTSUPP) {
> +		if (!ret || (ret != -ENOTSUPP && ret != -EOPNOTSUPP)) {
>  			spi_release_bus(slave);
>  			return ret;
>  		}
> diff --git a/include/spi-mem.h b/include/spi-mem.h
> index 2eb05a2e5bc..e68e2b50e85 100644
> --- a/include/spi-mem.h
> +++ b/include/spi-mem.h
> @@ -17,16 +17,32 @@ struct udevice;
>  
>  #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
>  	{							\
> +		.nbytes = 1,					\
>  		.buswidth = __buswidth,				\
>  		.opcode = __opcode,				\
> +	}
> +
> +#define SPI_MEM_DTR_OP_CMD(__opcode, __buswidth)		\
> +	{							\
>  		.nbytes = 1,					\
> +		.opcode = __opcode,				\
> +		.buswidth = __buswidth,				\
> +		.dtr = true,					\
>  	}
>  
>  #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
> +	{							\
> +		.nbytes = __nbytes,				\
> +		.buswidth = __buswidth,				\
> +		.val = __val,					\
> +	}
> +
> +#define SPI_MEM_DTR_OP_ADDR(__nbytes, __val, __buswidth)	\
>  	{							\
>  		.nbytes = __nbytes,				\
>  		.val = __val,					\
>  		.buswidth = __buswidth,				\
> +		.dtr = true,					\
>  	}
>  
>  #define SPI_MEM_OP_NO_ADDR	{ }
> @@ -37,22 +53,47 @@ struct udevice;
>  		.buswidth = __buswidth,				\
>  	}
>  
> +#define SPI_MEM_DTR_OP_DUMMY(__nbytes, __buswidth)		\
> +	{							\
> +		.nbytes = __nbytes,				\
> +		.buswidth = __buswidth,				\
> +		.dtr = true,					\
> +	}
> +
>  #define SPI_MEM_OP_NO_DUMMY	{ }
>  
>  #define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
> +	{							\
> +		.buswidth = __buswidth,				\
> +		.dir = SPI_MEM_DATA_IN,				\
> +		.nbytes = __nbytes,				\
> +		.buf.in = __buf,				\
> +	}
> +
> +#define SPI_MEM_DTR_OP_DATA_IN(__nbytes, __buf, __buswidth)	\
>  	{							\
>  		.dir = SPI_MEM_DATA_IN,				\
>  		.nbytes = __nbytes,				\
>  		.buf.in = __buf,				\
>  		.buswidth = __buswidth,				\
> +		.dtr = true,					\
>  	}
>  
>  #define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
> +	{							\
> +		.buswidth = __buswidth,				\
> +		.dir = SPI_MEM_DATA_OUT,			\
> +		.nbytes = __nbytes,				\
> +		.buf.out = __buf,				\
> +	}
> +
> +#define SPI_MEM_DTR_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
>  	{							\
>  		.dir = SPI_MEM_DATA_OUT,			\
>  		.nbytes = __nbytes,				\
>  		.buf.out = __buf,				\
>  		.buswidth = __buswidth,				\
> +		.dtr = true,					\
>  	}
>  
>  #define SPI_MEM_OP_NO_DATA	{ }
> @@ -62,7 +103,7 @@ struct udevice;
>   *			   transfer from the controller perspective
>   * @SPI_MEM_NO_DATA: no data transferred
>   * @SPI_MEM_DATA_IN: data coming from the SPI memory
> - * @SPI_MEM_DATA_OUT: data sent the SPI memory
> + * @SPI_MEM_DATA_OUT: data sent to the SPI memory
>   */
>  enum spi_mem_data_dir {
>  	SPI_MEM_NO_DATA,
> @@ -70,6 +111,9 @@ enum spi_mem_data_dir {
>  	SPI_MEM_DATA_OUT,
>  };
>  
> +#define SPI_MEM_OP_MAX_FREQ(__freq)				\
> +	.max_freq = __freq
> +
>  /**
>   * struct spi_mem_op - describes a SPI memory operation
>   * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
> @@ -80,26 +124,35 @@ enum spi_mem_data_dir {
>   * @addr.nbytes: number of address bytes to send. Can be zero if the operation
>   *		 does not need to send an address
>   * @addr.buswidth: number of IO lines used to transmit the address cycles
> + * @addr.dtr: whether the address should be sent in DTR mode or not
>   * @addr.val: address value. This value is always sent MSB first on the bus.
>   *	      Note that only @addr.nbytes are taken into account in this
>   *	      address value, so users should make sure the value fits in the
>   *	      assigned number of bytes.
> - * @addr.dtr: whether the address should be sent in DTR mode or not
>   * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
>   *		  be zero if the operation does not require dummy bytes
>   * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
>   * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
>   * @data.buswidth: number of IO lanes used to send/receive the data
>   * @data.dtr: whether the data should be sent in DTR mode or not
> + * @data.ecc: whether error correction is required or not
> + * @data.swap16: whether the byte order of 16-bit words is swapped when read
> + *		 or written in Octal DTR mode compared to STR mode.
>   * @data.dir: direction of the transfer
> - * @data.buf.in: input buffer
> - * @data.buf.out: output buffer
> + * @data.nbytes: number of data bytes to send/receive. Can be zero if the
> + *		 operation does not involve transferring data
> + * @data.buf.in: input buffer (must be DMA-able)
> + * @data.buf.out: output buffer (must be DMA-able)
> + * @max_freq: frequency limitation wrt this operation. 0 means there is no
> + *	      specific constraint and the highest achievable frequency can be
> + *	      attempted.
>   */
>  struct spi_mem_op {
>  	struct {
>  		u8 nbytes;
>  		u8 buswidth;
>  		u8 dtr : 1;
> +		u8 __pad : 7;
>  		u16 opcode;
>  	} cmd;
>  
> @@ -107,6 +160,7 @@ struct spi_mem_op {
>  		u8 nbytes;
>  		u8 buswidth;
>  		u8 dtr : 1;
> +		u8 __pad : 7;
>  		u64 val;
>  	} addr;
>  
> @@ -114,28 +168,35 @@ struct spi_mem_op {
>  		u8 nbytes;
>  		u8 buswidth;
>  		u8 dtr : 1;
> +		u8 __pad : 7;
>  	} dummy;
>  
>  	struct {
>  		u8 buswidth;
>  		u8 dtr : 1;
> +		u8 ecc : 1;
> +		u8 swap16 : 1;
> +		u8 __pad : 5;
>  		enum spi_mem_data_dir dir;
>  		unsigned int nbytes;
> -		/* buf.{in,out} must be DMA-able. */
>  		union {
>  			void *in;
>  			const void *out;
>  		} buf;
>  	} data;
> +
> +	unsigned int max_freq;
>  };
>  
> -#define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
> +#define SPI_MEM_OP(__cmd, __addr, __dummy, __data, ...)		\
>  	{							\
>  		.cmd = __cmd,					\
>  		.addr = __addr,					\
>  		.dummy = __dummy,				\
>  		.data = __data,					\
> +		__VA_ARGS__					\
>  	}
> +
>  /**
>   * struct spi_mem_dirmap_info - Direct mapping information
>   * @op_tmpl: operation template that should be used by the direct mapping when
> @@ -143,7 +204,7 @@ struct spi_mem_op {
>   * @offset: absolute offset this direct mapping is pointing to
>   * @length: length in byte of this direct mapping
>   *
> - * This information is used by the controller specific implementation to know
> + * These information are used by the controller specific implementation to know
>   * the portion of memory that is directly mapped and the spi_mem_op that should
>   * be used to access the device.
>   * A direct mapping is only valid for one direction (read or write) and this
> @@ -223,10 +284,12 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
>  /**
>   * struct spi_controller_mem_ops - SPI memory operations
>   * @adjust_op_size: shrink the data xfer of an operation to match controller's
> - *		    limitations (can be alignment of max RX/TX size
> + *		    limitations (can be alignment or max RX/TX size
>   *		    limitations)
>   * @supports_op: check if an operation is supported by the controller
>   * @exec_op: execute a SPI memory operation
> + *           not all driver provides supports_op(), so it can return -EOPNOTSUPP
> + *           if the op is not supported by the driver/controller
>   * @dirmap_create: create a direct mapping descriptor that can later be used to
>   *		   access the memory device. This method is optional
>   * @dirmap_destroy: destroy a memory descriptor previous created by
> @@ -300,13 +363,16 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
>  void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
>  					  const struct spi_mem_op *op,
>  					  struct sg_table *sg);
> +
> +bool spi_mem_default_supports_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op);
>  #else
>  static inline int
>  spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
>  				   const struct spi_mem_op *op,
>  				   struct sg_table *sg)
>  {
> -	return -ENOSYS;
> +	return -ENOTSUPP;
>  }
>  
>  static inline void
> @@ -315,6 +381,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
>  				     struct sg_table *sg)
>  {
>  }
> +
> +static inline
> +bool spi_mem_default_supports_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_SPI_MEM */
>  #endif /* __UBOOT__ */
>  
> @@ -337,7 +410,6 @@ ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
>  			    u64 offs, size_t len, void *buf);
>  ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
>  			     u64 offs, size_t len, const void *buf);
> -
>  #ifndef __UBOOT__
>  int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
>  				       struct module *owner);

