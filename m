Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B57DEDF170
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 15:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD1DE83AA9;
	Fri, 13 Feb 2026 16:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="l29Yuq+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25A7483AAB; Fri, 13 Feb 2026 16:09:13 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CFA082A9E
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 16:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXcMA+MX6dfnxqxz9VIHLX0blIDJ9rpwNvM+KkfABSsP/c3H5n6iJD1ki/JTAub0c8KpcWnfgyYMrHi8sq3DEII+Mcn1bh59UfrjgsU5AcnwO4tUsius7A1ual7THelHQE3l1Nm9wcdZ8Ltcy1slMxghTUnKOJlbKH2B9ASkBKDRdFRQMLbYx6FvDLSjZhudTensw0zDOdLkkKeSKg+IMUHa8qCfB6JVcZJdmWLYO2GuSq40J2t/uV+UMCFRlAMM1HDQb4TpBKj7dlDE++tSe8h9pfAEa/jXbh0XMvDq/XLLbKos4uLjimSdPn9EK/jLAIi8t/HBovuDFOEDglVQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QooqpkTiqQenEQUFC8Op9gbZ1/i8iP3m3UeXemDcpk=;
 b=oDhOIW08jyZmJzEk168WkP8ikfMXeiNJjZytIOAJLFku4vrauGXdFLZuCYtYgHkY4yJ2AkR32aMPk+gyZW2UGTEfDGHMy2CINznUPNYL3FAlzID9fQZ9Djim/dyT8uKMvd4036drL/OShUed6GsvbbTAXW1+eu/BlxwLiKEF+3CblxZic5RczJA+MO+IMpTHZlZM6jyjzNGjbYARzMeryXtWWVYtjocTu2PBd2rOaZvz3nJ/6xb3TK3L3vRbE5wZyi/O+bbYdbsXdafbAqt0+xNVxNNqL8YN0lQZo5+UZj6LGOfAnlfA6ZywT62uS5ttVba7owlHvSgj6XStA+yInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QooqpkTiqQenEQUFC8Op9gbZ1/i8iP3m3UeXemDcpk=;
 b=l29Yuq+GXdbuoZXKIeYXfUgcHf0MxfzipLmq9H7JdBiHv3nAGNv3xbZjFYII5v/fv3VV5VyXmVOcjEZXECzm1t8OcJCuMPFSBeojgJMpRzYPrrbfgpOmhEYVmMJ0UVgPT0rjjqp9Gwh0XbO9BjD8X9HjbIIDI3vLTt1i5ZHCvm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 15:09:07 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:09:07 +0000
Message-ID: <bc623037-675f-4a1a-883a-92c38fa2578c@cherry.de>
Date: Fri, 13 Feb 2026 16:08:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] rockchip: board: qnap-ts433: Fix TPL binary in
 build-example
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Daniel Bast <2790401+dbast@users.noreply.github.com>
References: <20260114082822.4007128-1-heiko@sntech.de>
 <20260114082822.4007128-2-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260114082822.4007128-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::20) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: 09dc0393-2719-435f-6b09-08de6b11d575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|7142099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2FzaUxIeWFva1VxWkowZ2RDSWZrSWswUlo1V2NrM2ZLUlpJNGI1bzFsRnpa?=
 =?utf-8?B?TGMvc3Fyd1dwc25XMEkybkZXWVN0S1k2elU5YnRQOE4wdTkwV1B4Zmd4TDkr?=
 =?utf-8?B?a3AwZG1HN01RNHFhTTVIaEVlcWlldzloQ1ZyS21HcFoySVpuUkF5TDJwcFlD?=
 =?utf-8?B?YUhLb3A1dW00MW9qemIzUGlRSVVUMUpsWlA0OHlnWm5NN0VCSWtCaTVHUjBP?=
 =?utf-8?B?VVRIZjhCaEUyeEYyQXRFcUhBSWFCemN4U2VkSGtheVplZXAvNHVVSERFM2ls?=
 =?utf-8?B?VmJCR2FHSmxZSkVodTdoSzhSMStxU1JnU1lOYk5NMDBCRWNyLzF2dVZoSDg1?=
 =?utf-8?B?RkpBWGRGVDRjSlpzbjAxUTQxQ3pwTU52RVdsUkdLTHM0aHpUZ01iTEJBR0hY?=
 =?utf-8?B?RTk5RktpL1dseGg0cXhIOVhIQnNlZjVCYTNKOTluM2tJdU9aeXprQi9MMjJt?=
 =?utf-8?B?ZWo1ZkJQdEdyQlh6c0VIcHBYM0g4MjZqRnB1MkFuNzJlcGh3RUh4M2FNY2d3?=
 =?utf-8?B?NHRlMFUwbGd4eElwNWU4allCa1lEZml0UFNkN0t0MmgxbFZzaS9pV1gzaGt0?=
 =?utf-8?B?QjF6ZVREUG05MWtDVXN6ek11SU91cWVxUHBXNEVrNnpXOGZvQVdraFBjalhW?=
 =?utf-8?B?VHVSdGxQaWkrM2pjVnQwUXBUN2VxenRLM25HR0owZ3crREpBdUY2UkFXdzdB?=
 =?utf-8?B?ODQxOUN2cnlrQ3BKNkE1Ujg0dmdld3ZvSDFZMHdwbTVqczlOSE9YTk1qRzB5?=
 =?utf-8?B?dkhlK0pXQklGYjNMYkx0UlZTK3pTd3Nyb0RXYUsyUXdSSmhMWjVqVEh2b1VF?=
 =?utf-8?B?NEIvSUVDdnVZSHFUMXhzZFgvVlB1ajViUTZJeVVLbE94NDhNQWQycngyNERz?=
 =?utf-8?B?Z2xtK0NPUlN1UkxoV2paMzg3elg1ZTErRUU3dndiYUFjVHNKU0ZmaWppY2hN?=
 =?utf-8?B?VkV4K041SlZtcGZ1ZXFJZVY0anYwTWtsUEMvZHRNSG4zeEtpWlJ2eXhlSVcz?=
 =?utf-8?B?T2haS251SDA2SmEremRLTUdzNnF0MGRTV1phV3Jpa1RPWXlFSUFlWUcvSUVs?=
 =?utf-8?B?NEFRZXlvTDh3ekVWVm5EWnB2K1dCTlpkaEtIQlltY1FwMjhWdFVLSVdaTmQ0?=
 =?utf-8?B?dDI2THAvR3J2S2ZkT3ZIMlpqNXJ0eTdQVSt6Z1UrM1FpOHUwUUp5ZFY4b1ZK?=
 =?utf-8?B?dXhueGRDQjR6UlM3N2pOOEhyb1JVemcrUkVYTDR4RlRtMHBsVG9ITG5PRFVL?=
 =?utf-8?B?NEVRL3Rpc0lPcnY3enpFS3B6N1RlcFVBVklXQzkxSG0ydlRaODB3VXBSRC9W?=
 =?utf-8?B?UWpwdnlPWHAyaG5qMUt1dzZGTTRLQnhvQ0FiLzZmS3ZPUjVxRTY4b0RsZnFy?=
 =?utf-8?B?QlYwU3QzLytHNjBjL25NNXAwcldBaC9zQm9ucnI3WTdCdE53Y3NpZVBweWZs?=
 =?utf-8?B?UVpUdko3dm8zanI3emVmam5YM1czTWJnQTUrQnFyQTdVNTJxTEtwQWJEcFZF?=
 =?utf-8?B?bElwMzBTNGZOQkFRclBpR1R2RnFMcEc2cGpFQ1QwMUJIZjIyeG5qZTNteUNs?=
 =?utf-8?B?L0RHM0xVeThncWJnUldYM3pEVnQwTnZSM1BFWGlzajNKVWJJQWhuU3V0TEw5?=
 =?utf-8?B?b0Vkd3NpeWg2cVJDZC9ZU1BFOTRUWDAyU1hBbndNTXQrSWQwQkR3VFZoVjhi?=
 =?utf-8?B?djV0RTNTejFLNHQ1d3NzN0hiTWdHWVdSUEtNVkFENTh4bGtQNFFTeEdEQkoy?=
 =?utf-8?B?cUhjdHdkaXkxTFNPb3RBUUNSNVdrNWFQZ1dLbU5VNEhXQUxMR1FLWkgrQ2x3?=
 =?utf-8?B?VTBvTFBiangvc2c1eStnNjZJRnphQjJ5OWU2RXJpOFR0aXFKaHF2M3dseUQ1?=
 =?utf-8?B?eVZWNWVRcWovZkRQUW1NTGFDNUk5TW1KU1FyVnBIaWhIVHVRdytGUEVTMUxZ?=
 =?utf-8?B?Zlh5ZzZJemhIUnVzMk1hUW05Zmc4R2lkV0pEdVQvWHdMNkZicnd3cnhRRk0x?=
 =?utf-8?B?NVlNNFVmcDRTNXpoWkw4S2RtaGVVckNYT0Z1WXoyNFg5Nk9FdWVtZldHZ0d3?=
 =?utf-8?B?SGNQNzZ6TlhFVlg3R1VuYVROcXlFeWRka2htR0xPZ1ZWM1RmVGZMajV2NTRa?=
 =?utf-8?Q?gRk4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7142099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWhCM2REMnBSUml4T2ppQ1VLNDZuQjBFdkVaRm9EU2srQ0JWajltc01mQjM0?=
 =?utf-8?B?eXJFc3RjQkpMeEFERkpBYW83bUNtemNCWU5ramNyVmVNcmFQdUVUUUFBM01P?=
 =?utf-8?B?MHZpOUtwOFZJMU0xMUxMK2tRTnBNck4vcXZHWUVzNnhNTmdzS1VrSkMrcWlW?=
 =?utf-8?B?akJwelN0SmRqMWVNYk41Y0R6eEpJdGtNMTF1eUJ2Wml1RVNLdld2Ym51NXIx?=
 =?utf-8?B?Uk1TTzM2NDNqelgrVnd6VENZWi8vc3p6bUVPQk52UlZMZGVhVTN6aEQyNUdE?=
 =?utf-8?B?RWs4aUNuYmUrMXJ4eE9rZHUxNlQ5bDRjb1VFeENXYTdvWk90TlZpbkZaTElB?=
 =?utf-8?B?bHUxbGZIZ2ZmclRkWHJlM1dsVXRxNHRkR0YxQnhwYXVYUy9rajVkbXF3N3g4?=
 =?utf-8?B?eVB4QjVCTHhtcDlrWVdENlpJYUtGK0l5KzVWZHducXhJU3RHaC8xZ3E1aHpH?=
 =?utf-8?B?SGp1UUJkMTJOdmdzMThYSlI5WmdZSnB5OUZEaTR6RktNR3FaT0JLcG5yVHI2?=
 =?utf-8?B?dDd4TXNPdkVOeENscE42Z2lHV1JwUmR1eVMrUllmdm1BM0NsRzcvQ2xLbWhx?=
 =?utf-8?B?aEk4eDR0cExsVXUvTUhzdkZIL3YzSjU2ZXg5ck8wd1dHYmk4bXVmSVdFK1NE?=
 =?utf-8?B?M3VLWGcwYmtESEljY1pUNHVDSXdxUlROWTd0K3FLem5oaDhkYUc5Z1pHRDhI?=
 =?utf-8?B?U3N6WlpZRU5KcnBnb0R1WE5yZ2crVVYwSHJvR0dmaFdWZjNsaXIrZmx0MmFJ?=
 =?utf-8?B?NVpCKy9CaGtmMmdUT0xRSklsdTdMOC9EK2s1bmxKNUE4ZFBla0QrTEU5TjVv?=
 =?utf-8?B?VFcwbVRsRVNFMkJiZ0U1a01BR2V1WU1WVTJtRjFVQitmTzIvTW52TTRXTWg0?=
 =?utf-8?B?OGFFNkIzVmcrZjBCRE01TmZNWkthZU1sai9xV0QvTTh4dVEwck5BNlhQNjJY?=
 =?utf-8?B?R042R0Z1WTBIdGx1ZUx0Q2p1MU82TGlnUjcrbk55M3lUMzVIZkF6RFpmRmZE?=
 =?utf-8?B?elIzNjFGRkpENXdtdGFCcnAwSjRTMUtlODE3YWJrQjBwNkhjeEZwamY1OWZY?=
 =?utf-8?B?Y00rbWxpeUpsY29VY0ZpR215MVhVb3F6bnY3dDlTaVlLZks1OS8zZ3F1ZjRE?=
 =?utf-8?B?Z2Zub3dMeSsxRjRORFhyTUhpc1dXM1YzTGxObHI2MzFPR2ZIcmtMZXd4akhr?=
 =?utf-8?B?anpDQlpmWUx0dnVWemc0RmgrNlk4VW5OWXpHQWxOL2ZMNEErNGMrTGQ1NkZS?=
 =?utf-8?B?bGtKdGtvUE9yaERycVJ5ZVZyNnFFMGhVcHZXd09ZOCt5SWxuOUl6NVgvaHdw?=
 =?utf-8?B?MUVFQmdqdlZqdFhOSUdKRjkyVk9SL0MxZ2Q3VlZjVGsvOXdxdjNPV2NHY2Nw?=
 =?utf-8?B?SXpJL09WREg4ZDJXNjFVZUJaQk10NzVKVUZkeFR0Z3QxS1dzdWd0aXN1ZytO?=
 =?utf-8?B?NkRTY1VIcWFXZElFaElIa2tKWU9QUDk4RFArQ1hMQW5GYlhWSFN3UlVlc043?=
 =?utf-8?B?ODdQay9hb3RyaW5Yc3FWNmZFUDl4ZjR1ZVNjSnRHbkVnMnF2N0Fka0xXQzZ0?=
 =?utf-8?B?anRDTk52M1dvRy9KQ0cvQzlWZHF3UkZ3eC96UnlkTXo2eC9kTlk3UHRSeXMw?=
 =?utf-8?B?SmRyNGF6aVNIN2VhVjZmOEFrQmdrcmlSczhIOXA0WENkSUJsdE85S0RxNlk4?=
 =?utf-8?B?aTBvWFpkL0R3K2VMaTZPMm1zVmE1RE5pUllaa1hZWVd3V3NtTjR5TWJkQ1lD?=
 =?utf-8?B?OS9tNm4rRG5PSlBIVCtOS213NjJSZlJMQjNJQllncjVUc3ZNOG9malVQdHpC?=
 =?utf-8?B?VGNxYy9MVXZteVlTNmxFcnpWT29FSlZWTXVIeGdITHJyVXBBcFdneGpBVXkx?=
 =?utf-8?B?YTQraVU4b2xqbE1pN29DcDMvUkZ5dktMcVh5ZVpYUWFXbFFTSGJSampVR25v?=
 =?utf-8?B?MXRoN1BQZ1dwODh2eDkyTmxWL2dPYXFJd0RtaW9xQmxhZDZBRXUyZk5PVGhH?=
 =?utf-8?B?MHcvSXR5elJMZUFJOUJDeDgwdkZ1R2dtSm11Q1NvT3MxeDRsVVJKVW5pc0hi?=
 =?utf-8?B?MlRzOGIwZ2EvUFU5Qm9TR1VVYkVXQlhPQWt2Tlp0VEEyTmMxcGJCdDIzMysy?=
 =?utf-8?B?SmxzZEZENVZBSjFLL082Vit4amo2dURZbGFjWm9lc0M5UTdIT0YvbStkTUlM?=
 =?utf-8?B?NGQvenhRUC9NQlJPbHR4ZDVoc25jWnRmL0RwcjduZWkyUU0xbFE3QUI1NzNT?=
 =?utf-8?B?VmZVakxpNGJBOC90cm5MZWhQenBmak15bkZZTEgxNjhrM3RJQ3k3SXgzbmxX?=
 =?utf-8?B?RnVyUWR3alBlWWJIREwwM3Zwd3JObWFwdThkZXMxbjhXZkVpRm5JN3loNG54?=
 =?utf-8?Q?MG6W71m1jJ6yoOktBwapaO+OAru/Vaukb1Otv?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dc0393-2719-435f-6b09-08de6b11d575
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:09:07.4065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdPSypJ7AXmEDzeWVsb/3p9JYor9PhzdDy2wb7QuwKS9ZeWhaFXUDTUfS+jAgtv6z6trfOe4xAelOZWw2e9aK37LrSO7bKz9CrK5QmAimdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922
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

Hi Heiko,

On 1/14/26 9:28 AM, Heiko Stuebner wrote:
> In the example on how to modify the serial-console in the TPL binary
> we already use the v1.21 of the 1560MHz DDR-init binary.
> 
> Yet in the build-example the TPL link goes to v1.13 of the 1056MHz
> DDR-init.
> 

May I suggest to set BL31 earlier, such that one can use $BL31 as 
parameter to tools/ddrbin_tool and we don't need to worry about having 
them out of sync?

Also, both are for versions that are not the latest in rkbin git repo.
May I suggest to provide the commit hash to checkout for this to work, 
or to adapt the instructions to use the latest available binary?
See the instructions for Jaguar for example. Also, there's a sed command 
there which is probably more user-friendly than asking the user to 
manually patch the file with a diff?

Same for BL31 for that matter.

Also the ddbin_tool is now a python script with different arguments, so 
you'll need to update that as well.

And the version of the spl_loader file will probably also be different.

Finally, how about using the usb-471 and usb-472 binaries we now 
generate instead of the output of tools/boot_merger with the default 
binaries from rkbin?

I'm wondering if we shouldn't reverse engineer tools/boot_merger so we 
can generate an image usable with rkdeveloptool straight out of binman 
for example.

Only suggestions (highly recommend either hardcoding the commit hash or 
using globs/logic to find the appropriate file from latest version in 
the repo), thus:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
