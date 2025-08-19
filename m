Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1A8CA0EE9
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF82802C1;
	Tue, 19 Aug 2025 09:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="R63FlwuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE27B809A5; Tue, 19 Aug 2025 09:13:55 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B6DE8006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNWfBPe0JQgyUpttYQvLMvBPb71w6duXbau5nn22Meo+vylbZEPBVIALWKHy+w+wxeIaqjHE88uDzry+jCYKng5793O2AjEWwTQT5nelBgxTLn5uvtO/Sz/7ZEe9Eq5dn8LNgJwRivioPogthTRvUW5Nm8/fDML7Pac8eL5sfKt6AXkNUb2FnQBfTB46GrzfJI60NuX7IleiigQvEDjuEMIl0XFSzo+y83nFoAFQvkGf1Pm5bWGPwptfSCfcaXad+WTlf1ww1aNauriWHnRUJ+vyvcmZHr/WV04vZoQZvpBTvQgzTnxdZQDVcqwa14ACk20Q9023SDxNF2IyL6pkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yW56LpoHSybcDFeggclnjIrf9uoBq08YUhLGTAQfBBw=;
 b=nsRb79KzIWFB7S2zRCoqoxU7YM4FyN0g2Bq/4nee6X7PMkrb8YUe+M3C5oHQZC3jwn5hotfrFiKOw/+PiQq0S7P6xxMIVLqx/OdBzISMkNzOR1Jx5D24nLm2u1t4ihskfCsWwvPGKxQjqUE3RKMr3rg5yFEdHYELgWlqr0gilIc/2VRMVUYsg97cMdOirfUAdCKZNd7zHJzUczLqDDUaCi5zKxr0qsnbMVW4riz9oRb+MBd+A/K3Hhu94y8GbO017kpTELAstzysadVsYyBS3XBhM6EUubX09cKh9KAZtgW9XJ6N6lIgEWHu7QzJvIUSSWeUlM5Dg2LiXsmOtwO90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yW56LpoHSybcDFeggclnjIrf9uoBq08YUhLGTAQfBBw=;
 b=R63FlwuSUlNKxBtxaMDKmEOLKPWU1xqbq/4y8tDRqXnhDAlApP17UPgiJzCxMiNQILbx2Xfs5rgHb4hltMlnCDmhQVXnBHdpFc2Pmz7zHpuEVBg6GyhFmxBfmPPK5TwC1GIbNGdIBy6BEVzLrRbgUvYV/zceYFnOHYBcoDsqX9WzN9B0hUfrVtOWhe/Fje2LS3ICSpsOnsN+wMc2SgAK/yoOasd7XP+J4iR3/vtdcV9GqMRpTdYjP7B9FbYBZjlkpum++st6o59lFBAJbLb2YBqs1em57svCR9iHGHg7aU5n4TNKjS62ld8U2moaxSpnIDKi6FEI1P/keUI0+AVgtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA1PR10MB8596.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:13:52 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 07:13:52 +0000
Message-ID: <1a65550b-166f-45d6-bcd9-adb722588016@kontron.de>
Date: Tue, 19 Aug 2025 09:13:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/21] mtd: spinand: Add support for setting plane
 select bits
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-13-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250818100614.432931-13-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::14) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA1PR10MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d0a589-beee-423d-e88c-08dddeeff377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3gwWGMwdWFIV0VJdTNMQ1NhMkp4RjBjRksvM0RHYTdVTEx2eEluZTllWDdS?=
 =?utf-8?B?ZnRVSVNBd3pmZWxCSVVYZ0JnYTNMOW80OHA1OE5yTzFYb2VQTlI3c1BXUDJF?=
 =?utf-8?B?YmFXak14MUo4akFnZjcrNlRXbS9NNGdwVzdyM0hZMDFTNlZIVDIyOXZHTWRQ?=
 =?utf-8?B?MitZQnYreWx4K0JiQmpDbUdIb21iMzhtTmFiZElVN3NOeWJ3R2xSNk8rYTJn?=
 =?utf-8?B?R0tTMXJnZWNpc1NNc0lxZTNaOXYvQ29ONm5ob1phWElsR2NmVm9BNWRJNzR2?=
 =?utf-8?B?d0M5OFhiZmlLVWFKcTFIZjB5ZWI1K1draXZpN3lmN29ETzEzK3d3Z0U1QVBT?=
 =?utf-8?B?cms0eER1a1ZZRm10c3duL2hMVlEzaVB4TFJMaStZbzB1OUdFVXhyeTN5bnVP?=
 =?utf-8?B?T1J3WjV2MVE2cHFPaVVyQzZjMFNiNnZDdzA0a1F2RWdydEJ0Vm1vcWRHNFZn?=
 =?utf-8?B?Q1B1S05tNUJoQXB1Y0ZPWEJJRUo2ZllxemZUNFNUME1KaUMzSU5QTU14NjZh?=
 =?utf-8?B?L1hxcDNrcVR5TFFCNjhHYStlTGc0Y1doYnlTZmpNRUJnM25qMG1TdFJ1U0JV?=
 =?utf-8?B?bFdqT3llc2d6MENURDJGZVcwUGs2bmNvdXRLd2dUb01kamhOWUpUYlRabjF6?=
 =?utf-8?B?U3BYOUJDSCt0M0x4ZTgvWTBUWDdqMDg0eEpFU3ZQNTBhZ3NPZEREZXRTdzY4?=
 =?utf-8?B?dTh0cllYdE03RWNhOVlVbXhnN29LajRHM0NnYjdpdnFIWnJTeE41WHFJNEls?=
 =?utf-8?B?c1FLMFY2cG9ZMHo4VDRvMU5ueWVadGN0aUdaY1pMVDJaMHJrRkh6MzhlYlo4?=
 =?utf-8?B?OUJaVEYrTEMvSW1mcXFpbmlDcXJYSEhZSktORlF2allpZGpTQURwMlU5MlNL?=
 =?utf-8?B?NnQ0Y0tlMFRSRWJ0OWtaYnZDUTExZjdsbWZVWHp0SmZnVnRqcS9DZitTczVm?=
 =?utf-8?B?c0tVQlpBWncwdEdkR0YrQkJrZjhvWHpEWWR3em00a2ZCQ1R4TFJYMWRhR2J5?=
 =?utf-8?B?ZUpBV3BxSk1sZHdwU0tLOHAzNEhUUkxackxLVndSb0U1KzA4RUtVQ3JHVFJx?=
 =?utf-8?B?NHJQRXI4dzNiVXNGVkY3UGtTMVlRQkF0bUNieFY5ZEFWUDQ3ZEE4a1QwQlFP?=
 =?utf-8?B?ZHBiV3NSMnBEMmt3YW5BWVFSRUtuNng2a0JxTUNnRUdyU1pWMFBPbjVzQmVE?=
 =?utf-8?B?RTJFR1lWSWZmVzgzdkNINHdEd0dFOWIwQmxWRncrQU16UXlITnBUdTdsNUNG?=
 =?utf-8?B?MndTNDVKZXkyOTQ4Z0JWOUlKaHRmQkxEWnVaeDBtc0lydWlCTDM2SCsxVlBB?=
 =?utf-8?B?ZEtNYmFNTWhmTXBiMGZ4aGtNMXNldXRTSkZQRFJIY3IzSjZrVjZlTGVnMlVi?=
 =?utf-8?B?eWpFcDZCeGorb1p6MzRDT3FNdFNjL2l4L291SlZwaFpZbDNTWm9rYWRnNGZo?=
 =?utf-8?B?ZlQ4NXh3WW9ibEp3dXdSYTI3VGNPUDFLckI2YlFJeERRQWkxWTBXS0s4Nk95?=
 =?utf-8?B?bGpmUk1lakxmWi85L2g2Q3VTVE5VUlQyU2xDQUU2K2tIY1l1NCt6MkhzL0tY?=
 =?utf-8?B?WUV2U0diQmZKYjdlVFBFRmJVdkZmRWJpWFJMSVJlbmJaZUJKU3JuZDZNL3ZY?=
 =?utf-8?B?bUxtbVFSRG5pQnRwSFU1RUxnUDBmVmhnL1NIYTZxcWoxZFRqL2RHL21XUDBi?=
 =?utf-8?B?ZkM0NkdSdmtsMW1jU01QcmZXam1pU255dlFqSkp2V2w5ckVyU1VxMUh3S1JD?=
 =?utf-8?B?WHZRb3FaK0F0UG05aGJ3dFJwODZLOFpzbFdoMXczbkZRMzNKOVhNYmYwQ0Y1?=
 =?utf-8?B?YmZna0NLckx5SkFIbDEyOHQwZWduL1BzQkVITW9xN3FJdTBJa09ZWVlDSEVJ?=
 =?utf-8?B?N2pObnkvYVBrdUM3VDN5TWJSeVExRUlUc2tsMjRpSFY3TGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkQzWGFmU0cvWkQrOTRpak54U3B5Nnp0eTBVci82Q0NkVWl1ZjhkcXdYajFZ?=
 =?utf-8?B?OXJiL2l3NjdhWERreEthcTM4VUJzd0wxUk1oeDNoeWlyOEE2VkpGSnBHc29l?=
 =?utf-8?B?VHZGR3ArRGJ6Wis0eHlmaTU1TjQyNExCaytxZE5MUFNyWHNBK1VtZHI1cE1p?=
 =?utf-8?B?OThBOHp1c3ZCNVdXajk5SnByYlR4dncwK3Aray8wTVI2d2l6YzV5L0I2ZGNB?=
 =?utf-8?B?QWE0SDd0Z01LakhrNzVMTllKcG41YjQ3Zk5kOVkyVnMvaVFIZk5ucTRlcTdl?=
 =?utf-8?B?N0oxUzZPTk1LdVd6YkdIWms4bFEydXhZY21waUlkR1U0TC9SWGFabXBPRzln?=
 =?utf-8?B?VUgvUTI0MDN4YWpHbGE4UFp3ZmxtMUkraUl5TGoxR1E0SnMxd0puWWRiN3NM?=
 =?utf-8?B?c0dIZGlVL3BrRkE2ZkYybVFmb2cvTmo5OTJreWJmRjBjbXIxV1NZcDVTdWkv?=
 =?utf-8?B?b2dGdVhpNUUxL3p0SlJrT25GODkxYlovQWNxUHBWbDJJUE5tS0IybGtHYjlS?=
 =?utf-8?B?dytNWGdmMlNscmhGSm5vd0RnZlZ5dmdKU1BNTXIwY0xOZkpUZjJ5clNwWTBv?=
 =?utf-8?B?OTIrYmhBWDU1Q0xVWnh0VG8zRm16aVplZEFENGRWMFVoWjcyZUJON0FzOU1k?=
 =?utf-8?B?RUFybitGQzlZQUduRndUc29xNnh2Q1k4ZTlSdkVuRGlrQVZ4TWFMY2tCN3Ey?=
 =?utf-8?B?WnNjT3RrS1BpcVYzZHZxR1VleHIybXRXUXBQc0NiNktweGdmOVFIR1BqM3VP?=
 =?utf-8?B?T0pHTEZ1LzY1ZDJ1dmx5WjBtZ2YxVkRDYkN3bGhDS2NIT3JjTGo2U0NsOEUw?=
 =?utf-8?B?M1RXU2E0c04yNXNSYjVja3hYVzNmckNkekpHSzluMUZtM29oQXNhTE1hUVU3?=
 =?utf-8?B?cHlhZ29CdUNqYTA4ZmxjYW1QeHJ2dXZiR0VXT1dTMGhhdXFReEtjME5JeUZM?=
 =?utf-8?B?cDR6bTFGYU9rZWRVK0xVbmdvYTVjWVFIOUNjRGUxOUkzR1NPUjVzRWpodkJa?=
 =?utf-8?B?Z21oek1pK2FJVzJCejFXTTAzcmI2TjFGVnF5UmZ0Rzd4VlhvQzJwYmdXNXVn?=
 =?utf-8?B?Nm4wZElUMWZoQ0NrQ2xnNHhTWFlGeGljM2xLaENTZTZBT0hXRDR6UTkwQmla?=
 =?utf-8?B?VHBPQUpZU1QxOUVUdnh1TW1vaXRuMGQrYTZUQ0dOMzhhM1o5MWZmYi8xYTht?=
 =?utf-8?B?R2VEREg5R2s2U2QxWHJBZkYxSlFMOU8rSzVCOUlBTjJWNUVXTWFGalJyazI5?=
 =?utf-8?B?V1RwczZFOGpXRkF2V2laYnZlOGIvNzNoSEhielZIRnd1em5TWVdGMm5ENHJz?=
 =?utf-8?B?a0hha3U0MmxXVlRJTDU5NGtod0xFbkUzcE9CMzRTbEtHanBNWWJnTjIvd3dv?=
 =?utf-8?B?Q0JUR0lnK2dvYWREekRYYlFibGM3Z1dpS1E3ZWVkWEFvdnJPUnBjVUFJL0pr?=
 =?utf-8?B?NEdFbjdZWGgzUHY5dDFPem5zVUVob0F5VUIveVRhdHhUL3ovNkJLaUxreFJs?=
 =?utf-8?B?YWJBVVdSaW9JWE5yV2t3WGdRK0orZUNFbUhkRlovSkZ5dUtRbU1LWndrUHlN?=
 =?utf-8?B?Z0EvS3ZaNUZUK0dXMi9VSDIrTzduZFZnZ1V5RXFob2M3QzY4QVJUUGdTOFdT?=
 =?utf-8?B?TW5SS3R6ZDRhK3F1SXJHdHBPNHpyekgrb1cwaTM0TVhZaithTnhIVVk4N24v?=
 =?utf-8?B?SldYeUVNdGxJUkF6TzlGOGRLTFdlcFJFYUYzVUtkMTQrQ0ZwQS9PTTlzcHpV?=
 =?utf-8?B?cnprSG4rMldNUTZ0NkIxODJ5NFRld3VSUzcxV2szNGRIYXVYamRwWlFTR0pS?=
 =?utf-8?B?OWNXaGs3T0JuTnF2TGVMUnVaSUZENVpsTjBvWGVtV3o0U2hNSjRpNTdFa2lJ?=
 =?utf-8?B?dFFpTkg1RVMvbmJwUHViZTJrdGZGN0xZa2RwQ09Pc0ljNGxiTzJYTEg0ZUNi?=
 =?utf-8?B?dGZqT2hhYTdTcVRVSnZEUGFKNnk5VitCcGg0a1JvUEVuMCthWnR4TEtxcVlX?=
 =?utf-8?B?MjJIL1RTYUFFNS9jS2UvdUhoTVpsVUdFUmpFZ1hHSkttV1IvdlV4cEsyTWZp?=
 =?utf-8?B?TXVOdEVuNDdLL05oUGRpOHZUVVg1Z1pzWEpZTHdZSjZxVlhMRUxmenZlRlpE?=
 =?utf-8?B?dXlCVndQN1RMS2JvbDZaSngxYnY2c1VZODFGR2xoVUR3ZUhzM1ZhVWRCQzF3?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d0a589-beee-423d-e88c-08dddeeff377
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:13:52.1036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NQJmGE0xVQ1ZjVGGy/AM4bslPpx8epclKqT78UrvkBJApKrx/2tFBfvLQ7/ReCyK+DZ0+B4g3caFFaWMaVA0jOdADgWzJ3fDr08BhnZllk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8596
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

Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> Add two flags for inserting the Plane Select bit into the column
> address during the write_to_cache and the read_from_cache operation.
> 
> Add the SPINAND_HAS_PROG_PLANE_SELECT_BIT flag for serial NAND flash
> that require inserting the Plane Select bit into the column address
> during the write_to_cache operation.
> 
> Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
> that require inserting the Plane Select bit into the column address
> during the read_from_cache operation.
> 
> This is a port of linux commit
> ca229bdbef29 (mtd: spinand: Add support for setting plane select bits)
> 
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Link: https://lore.kernel.org/linux-mtd/20240909092643.2434479-2-linchengming884@gmail.com
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
