Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D2DEFD209
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 08:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7AA183AA9;
	Wed, 25 Feb 2026 09:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lemv6Wm1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A853483D8A; Wed, 25 Feb 2026 09:24:04 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 624F082A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfspB6dD3hAKfhzQqmsYQ4pAiwiqWy61mrWF+z4WdGHJ3dtz8FRCCZOWM5UiakxJ7r/9ANo/zP9hQm7Oo11Ki9UX2EC5thhMTIMdITMgMgcdxCB1uzhQKHD436qnI7CH616kyYX6k+wqxYzJ/W5ya2bAlzwiCoKcXuIdvPDS3MQaXr+db16ec+zNK7XqV+Bmazsa9TEo/n9e/x/yPS43DYbLZIfDSfS9Q/Xwbo68BGxnm23gZGXzPpdgbjhb8F0mHx8VgXUfansMZoukgWpuMizqLo/dVmYhMdCC8ffd1eRaSEzEAJ4jErbgrBLWh5E0tAAsr/ReHNpSF+OpGoFKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E45i5JHQ75IXjIN0QNYEVcDntKsHgHHH9sPKrJ8BMKw=;
 b=W+HurXY96v4y70bfer4BsQiIVsG9sw4CCOJaHTCv7417ZrRNkMIkeEGU8vmXK+M4kKrPM/esRhccEv/e7HAmK5o89jQkwZf/OXq3drlJPJ6bLhxT8UMXRwaJE1TFM6l4eGDXkBMy3/ZXKuPcP/v/0kWnmRd0n/jeMuVIjrug/X7suw04oKwBEIt85G4isJJ/sbU8N3PdIChesvlkExjL1YjsAqgH3A3OfxV6FZt1G0nHCdGFp9gBfYl+KCPZ5QP5DH4jbvTa6AIeuj9JBKJR85w1T3KLo533/BkDNUZop8JsJNtPgyBD2YBlxHZYdQu5UGicRpkLtJ04t0P2PvhdMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E45i5JHQ75IXjIN0QNYEVcDntKsHgHHH9sPKrJ8BMKw=;
 b=lemv6Wm1a28mfvwj9OnRuE0azTkCrqWL4sE9QL9D+WdAP51oIUHCwxHVhUbytx89reB6WVp5OnEZTikB3/QDhw+mL363eZWCA9PkYMAKT17V0irloLth9PTW9p/VM/jKz4W2kmW551OCEkrHAiTimbiyhtGwmoj9rIrc1N6sP/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB8750.eurprd04.prod.outlook.com (2603:10a6:102:20c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 08:24:00 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:23:59 +0000
Message-ID: <071e86ce-5a0e-4963-bf35-6df3be6d0abb@cherry.de>
Date: Wed, 25 Feb 2026 09:22:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm: rockchip: don't use non-existent
 CONFIG_TPL_TINY_FRAMEWORK
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, u-boot@lists.denx.de
References: <20260225072817.50994-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260225072817.50994-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::46) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: e9dec911-eb19-42ac-e844-08de744739ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlQwTlFHbUxvczBZS1pDaU1ERnpSVTdpbm9LUG0venlRa25MTHpCcHlZbU5j?=
 =?utf-8?B?ZkQ3NCsvci8vaVNoTUNjU1d1UmlHbU94R2JRc1habG9QeGJRN3JUVEdxcjRC?=
 =?utf-8?B?YkkvOWhFUEs5VkNZQWlsbk1aMm5qRTNJUWlkL1ZVM3ZmZzR4RkVvSSswQXpi?=
 =?utf-8?B?K0NLRi9Yb3lMMGlYam5Qd3U5VjJJS1JZQjVPWXlpdDB1YVlBd2k2QmVROWxx?=
 =?utf-8?B?NTliZkdvL1FwUzRsbWpQd2MvVjlzWm9CY2NLNlR6cUlINWZLVlFWSllLYVdF?=
 =?utf-8?B?dDNDUXVydGhMUWlzSEtVM2FmdFlGRjBoaS83VWpwOERsUUZabi9vOHF5cUM2?=
 =?utf-8?B?QVpweFNkeHltOElWdGpvcmRVWVZQTy9zYzI4MWY3MmRBNXRwUGJRcUhMaE8v?=
 =?utf-8?B?bk9veFVlcHgySXAwQlNZSUs3V1NmOVhyVkZCbHl1OFVLWWxYaUUwYXNmMDR6?=
 =?utf-8?B?Y1p5MHNDUG5BdDQzaEZObEpOcVNtTG1qOHYzVS9TS25nTy9TK2ViaG1NdEpy?=
 =?utf-8?B?VFlZYnY5WTAxZlEvb3RJaXZMT1lWVFMybVZvNTEzS0I3aHlsTms1VE5Cb1dM?=
 =?utf-8?B?UXBxNmh0ZENsWWoxeCtma3pNQll3bUsxdmk3OFJSV1RCWnhSZWIzNTV3ZG9u?=
 =?utf-8?B?Mkdhak9Dc084Q1FSUXR5bWxnZ2NkcnpxaHJmaEtHVlJHOVZHZjBUdG1HMHh1?=
 =?utf-8?B?aXgvSzZFbmlwb3JUdWJUVEwxWGd5NGw2WUdOVTg4elNBSnBqc3dJWGdwYUo4?=
 =?utf-8?B?WjF0TS9BWmtyWWptRjl5NDVhc0UzSFp2UG9ROGJKc04yTDQwSWd1bEViTXhG?=
 =?utf-8?B?S1JUeTRmRko0b2V5RXhyTzNPRmpJQU5tOHk4OEpoQ0h1T01TRDUwTWJTM3FO?=
 =?utf-8?B?aUZva2trUENoTWI2WUM3WmQ1emFsaWs3VkpjTzBvNDRCM3hOYm9PL0NOb25p?=
 =?utf-8?B?M1JwaXhNN2hxNFp3M2NLQ2lTUHB4M0w2RVNJa2tWKzR1cytUQlQrRi9TZW1r?=
 =?utf-8?B?N1prVk9KUCtTZFIvUXFrbHlZOTVJdFZ6UjB3TkpHQmsyRUk5S1N0SldNQ3BF?=
 =?utf-8?B?dlpUaExnRHRGRW9SRTdJZUZSSEtOWSt1b0MxMmtjYnVFaVlhK3VEd2Z0Umh0?=
 =?utf-8?B?SFo4WjdidlZaakNzOTJxQWNyWHlWWmpFb2hHYTRvaXdzeUo3VHRwT1pqQ08v?=
 =?utf-8?B?WDAzWGtQVksrVC8rRXVaU2tjaUhLVi9Wb0JIYjZFKzJxK1ZjSmJrWkhhLzQz?=
 =?utf-8?B?OFNDU3pjK3FkZEJJbnBicTcyVkhFd2lUQS9FNXRZTEVYeG1sb2NHdHNXcTV1?=
 =?utf-8?B?ajlSeCtSbFZlNWdpbUdOemhBeTVZTkV3WTh2Yk5aRlZGOHJtdnd1ZXhONS8r?=
 =?utf-8?B?Y3NacVFDTUVVN01EaVhINkE5Ukg5TEdJclJjOUc1OUVkQzlpa1ZjbzZSQnJQ?=
 =?utf-8?B?eU9vZGkyUE1FT3lwbDcxdlpHblIwZk1EU3JpTmZFL0x4YXI2ZU9MWVlQNWZ0?=
 =?utf-8?B?SWttUGxmQ3hwd2xIa09QREwzVlhoYWR3ZmZaNGoveFVMSnd1TW43RHZyT2cr?=
 =?utf-8?B?S3dPNFdaSGJRdGl3eVpxZUl0a3A5ait4SVg4cXdnMWdZWTI1Q0luZ29WVi9R?=
 =?utf-8?B?NXRTemhPa1lhMWQ1aWZpQmIvZ3ZSendGM09KaExNN1dWREd2Y1RKSGxPNEhO?=
 =?utf-8?B?bUhpaHVkbnZ4YUo2dUZKc05jeC9KVzJQSHVndE9ZSWdDblJlRDlPYTNMTEQ2?=
 =?utf-8?B?SFVFMmxPRmRySkt5VlJOT2VPS3JJT0IvNkYzU295a1RVWWlmdHFUQWdnYytm?=
 =?utf-8?B?ME9GWjQrZHprcWsvODhnK2tDRnZjc2ViR2RvRWJHa2E4cFFPRk1QdlVRNndu?=
 =?utf-8?B?T0V6dWZ6ZDlLbjFEbU1HTUJYa011TTJib00vYXNJTmUxbW9BazJkYlNKbSsw?=
 =?utf-8?B?bllzc20zWDZwb1JxdGp4UE5mMmUrbDdJS1llcDBMa2tXcVp4eGRrVnV5R05R?=
 =?utf-8?B?ZnpaVHJIMkRRQnlRdVhjM1B4R0NGMUJuL3ZiMWR4ZmliTS91dlBMbWlibkpt?=
 =?utf-8?B?bHY0SjMwbm1Od2FrWDRuVjVtNVd6Nm1XdGhvQXpJenNyU2VBc05zZVM3ODYv?=
 =?utf-8?Q?cMMU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVoWml5WHBEWmsxNGl0S1Y2eE5EekNHTHBVSkwxejdPRWtSUGI0QzdGRXJu?=
 =?utf-8?B?NTRtUmZKWS92WXgzMll6bDhvRkx4K3hJRGtZb0QvQi9pVVNuM1NRelVnZVFO?=
 =?utf-8?B?K1pPQ0tERmg1NXBnRFMra1o2ZlpZWUFSQk82aGxJVWsra0hoNXRJVk9FeXY4?=
 =?utf-8?B?QmRyRG5aWXBHMVJlQit6dVlKMkwwbk4ybVA1TkxUUlpwOHFzcVhFdzcxZ1FK?=
 =?utf-8?B?VUltMW80dDNUcUpSK3BwVkJhQ2hISXRFOXpKWW9OVC9kUGhGdVNMZGdUTkty?=
 =?utf-8?B?LzdFUU8xSHNOSkxtVEk4VVNGUlZIdjBYenpmNVQ5ZmYrb2sxWUNacWlmeFJG?=
 =?utf-8?B?SDVYdGpQV0lmSGtocUhyLzFIMmtibTFMS291QmwyYm1WWjVRSWpSQjJ3Tk5o?=
 =?utf-8?B?OHlLUVVFellIS0FzYXNXZW0xaUx2ZGpqdFdQTU40cG01ZzM4K0kvWlBESk02?=
 =?utf-8?B?NnJvU2RuZ0Vsb3VhOXNOdHBHMlhqTm1MODhPaHpkRmF0dHVvS3JpenVWVjBQ?=
 =?utf-8?B?b1FWelkvaGJXOEs3SVlLbXlBdXYrUkVMVmNyV3ZxMHphR0Nqc1hNVlJpOWJh?=
 =?utf-8?B?U0llckdLa05VMXYvRDlwT01GMHZINkdPb1ZuN1lhQ1M3VCtRWTNxdzROVjZR?=
 =?utf-8?B?MHI2ME1yV1FCaUZ2T0xvNjVudDQ4b0xRc0h6b2Y1QjVTaEpKZ3FSYVViYnRQ?=
 =?utf-8?B?MWs1RHRGUEljYloxN1JoSCt3TFU4ZDNqNHJpMXk5UmJkTVFCd21GODVZTVBu?=
 =?utf-8?B?Z01XekFsR2wyUGVoWnZKeFNHNksrdWkzUFlDTUgxclZHMXJVRUtyRHBWNUN0?=
 =?utf-8?B?YS9RbS9xYTdRYXl5cVRJY1pXVndyVWlBMzh0R0padlpvYzQ5WU5rZWtDU3cr?=
 =?utf-8?B?VEcrV0lheVh0RUVzR2dFbnJpL0RPVEpWOXRUb1l1V0hybEs5YW9wdFg2VEtD?=
 =?utf-8?B?ZCs4WUE5RHdpaXlRMWdOM3ZmRlhqTzFqT25WMlVRM3JzTk1oenpaa3g2SVJ4?=
 =?utf-8?B?WEFNdjd4a0VwOEpLcHZMVUhBZjVENjlKSElydWZNZytYUkoxeUZBQzROREx0?=
 =?utf-8?B?MVIyc1RMclpBN3NIa1E1YXlIMWNteUNXaytjSGoxTzBNNHZ2blJHaEtxUmxq?=
 =?utf-8?B?TVhCQkxFTFp0SWpRc0RUWkM4K2lCNEE1S0NJeE5xamlYV2x6dG5RTEFJRFpq?=
 =?utf-8?B?SC9wUklOeHdnOStOYytHcDNXMTJJVndnc09WRGVLUWZqTjFEU1NEMW50VmFw?=
 =?utf-8?B?S2Q0L1ZLRzRyOUFqekR0aEwxMy9qTWlEcUhMR2hyZE43QU5DZkU0OURmNFpv?=
 =?utf-8?B?UVkxYVo1NWM2N21CTFY1MndNVXhSVHFJZWpwQi9ZVVcxVTYwdnhaV3BwcUl6?=
 =?utf-8?B?eEs1TjR6WDFKQ1o2TWNxbmxrUHlJeUk4eVU2Mk1ZVVh4Rk03d0M1dUdXbXQr?=
 =?utf-8?B?bDlqRjBKS2dMVDlEaWtkTVJTQU12eHZSaUxsVzJlK1RKVy9UeGZkcTI5ZWxK?=
 =?utf-8?B?cnhxZGtzRkk1RVpDZVo0ZnhqSWJFVW1jaHQ0ZVRFZXlxU0Q1cGhzQXY1MXIv?=
 =?utf-8?B?TTN1R0RnRXVBVGJkMEE1ekpUMHh4MUpBYlJWb09uSW1HdjZBRHdIOERCTXoz?=
 =?utf-8?B?SE1DMkdhakxWTHpKbkF1TXoyczJPRGNnS3VTdTQrcEdpMENORGlLNlJ0OU9k?=
 =?utf-8?B?WmZOQmh3Q2pKN3J0aUlYZDVxcUJmcHZESDBBamZuUVRmTWdaMFhnKzlIK1Vz?=
 =?utf-8?B?MURrM2N2bDBQalVvNnRoSjVUUW81dmprUTI1VXRmbkZGZXdrc3Zpb21wZzRU?=
 =?utf-8?B?K0NCNDJYODRrQnQ0QnZiUzMxc2xkajhPRlVaVUNkMVlEdk9vdTY4QjhCVnJI?=
 =?utf-8?B?Sm9EZUdTdHo3bnl4Y1hWK1RzVU5JNmxuSCsrRDE3dzdlRnJXVEVDY1JHdXBG?=
 =?utf-8?B?ZytMYjZpM1NNYmxibXhlaVJiWVpObnQ4cnhyT1Mva0ErQnVOSWhVRnFnU3hF?=
 =?utf-8?B?VGVsbDVKZ1hQV1dlK1I2bTdzTVIrQ3UzcXdJZFd6eEFEcHYyN0lTRkt4MWVX?=
 =?utf-8?B?d01jeGNxWmtqVkwwTDN5ZE92Vk96Wi85NnFDcElYeC9EMzhwMXFPR1FlUVht?=
 =?utf-8?B?RDY1S09iZGJ1OTRjeTkycGlGYTJ0TFlaaWE2N0FzZjRlWUhzTVNnc3R6a2VM?=
 =?utf-8?B?d29SSHJYMUhuSkl5ZmlMa1JIWjhMQXFSL2FXYm5xWGc1bVQ0WVR3SWI2SEJp?=
 =?utf-8?B?VEszODcxUzZsekpGdjRlZFpVTTdzRW9Vc3ZZRENKZEFmYlF0c0tMTS9EZ1BO?=
 =?utf-8?B?MlU1ckh3WnBmeXRlWkdwS2hnbzJFd0hCSngzL250bGF1WUxudFRXQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dec911-eb19-42ac-e844-08de744739ce
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:23:59.6457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jd56XORZ5UkXizoybNCJmYah8WXxQNphEggEn/8WxitGG5RBOwkie/uXZkjR98HAIvjpSBHPeCa42V+EGbEBIS6p0D0ytQmps68HvpddjjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8750
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

Hi Heinrich,

On 2/25/26 8:28 AM, Heinrich Schuchardt wrote:
> Symbol CONFIG_TPL_TINY_FRAMEWORK does not exist.

Never existed in the first place it seems like.

> Don't select it.
>

Fixes: e9ccb2f526ed ("rockchip: add px30 architecture core")

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
