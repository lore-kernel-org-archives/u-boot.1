Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F6EC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D6AD884A7;
	Thu,  6 Jun 2024 14:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PnQy3Cjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB58B88395; Thu,  6 Jun 2024 12:55:52 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::71d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6130088308
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 12:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP+Sxi8xm+ELSsGXnng9PeGURAFVhubkyiRqR+jkPpkZqAXOvy9AQ/Yveh+SqyZVVbgl6N59XRUjWdbxShXltFQ/ej39XcxSt32WcSmY86nD/GzIDoV+WS6TC4BQ96R3Mc1fgDlMGnAXGi6taxkXQznjF9mLz6oJn7E7jQAIL1MybbPr+UA8p38omWD+PTL4d7+H2++Kg/rEnVpdsWfRK53er1LeHN56Nun1qgk65ct1+VYmso7JoAJoWgKIwJn7UllKfqaHDW25Rl6Gk2IoLjaliTj0kybLCLMc5onFkrNanx4wMwLrkmKwPmoWkrlp8COhzHNZlZmKANguuTdEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKm9s2XFjWw1uLIl4OISdXLyjvZUbfgWugIzbwhC1t4=;
 b=CPDWg8Xyw9RF4tBkcrwYbvPpP87PZIaOT+R7PsNFSEOwSQpiXcH4Ei2SQfbAloIErRmShFJRN5vqo4k88q4eerTbknV6JdMLmw0A8RLsbVDxxoQ1E73dQUQOi6Q27eWdF0IM+s9vlFSgr7JlXD8a1xUSh6iTp9MVgKlluZusOeBYCSemfshLWOC0BKtxZ2ZVyskRFv3XaYil9i1F6VVmew63Jwa8Hu9o64uXrwWeJ84zqPClItHO/WaSNSFFLgfGhw35J7UURoXmewgpGH6svNom1szt7vXiFnEOgIeRUsiJ5DEldMKMxpJGAtZKU0JxEbFTNj6DXOI0m/4LXLv6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKm9s2XFjWw1uLIl4OISdXLyjvZUbfgWugIzbwhC1t4=;
 b=PnQy3Cjqmugjm6igDbAw9NbgJXOrhXQMblfApqv9i0B4IEZycNxsY2+8TuaoOgUsFO894aNz0rFD2YUEQ5irqg5VmkN24AIKgPz1nHwB6j/k7PaWxYQJL3wcTHKjRynLh603h2FNn+oG9aOVasKOaP5AYKznP76+GN7LvZsCvZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AS1PR04MB9456.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Thu, 6 Jun
 2024 10:55:47 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 10:55:41 +0000
Message-ID: <96b43c02-aad4-4fd9-b35b-bc4e1d232a47@cherry.de>
Date: Thu, 6 Jun 2024 12:55:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] misc: introduce STATUS LED activity function
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
 <85d02b8a-dee1-42db-a804-d065517391aa@cherry.de>
 <666186d4.050a0220.fbb8b.00ff@mx.google.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <666186d4.050a0220.fbb8b.00ff@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AS1PR04MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 0224d091-1393-4ebb-0787-08dc86173508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vll2eUVMc2dsaExMNnZvZUZ0bVk1TlFTOElJSVJadVg3MUZyN2tTUVZ5TWlF?=
 =?utf-8?B?M2F2UUJmVm1BSGdYU0l5aEJBbjJiYkpWOTRIVS9SKytVckwvb3YzM0dZR21r?=
 =?utf-8?B?VVBZK1Q1NmprdkVxVU50Y2ljRVlQZGkyRDZ0dEhBZnlVTUJaMXBDNGl2OTdo?=
 =?utf-8?B?V3FUd01CaVN0eVA3NzVYYkhTeXZBMmdZRVhFQlBDQzAxS3Mwdzh0dU5uY2lG?=
 =?utf-8?B?OXozM1hmaEd4Lzh6MWZ0THdlSXhRN3VpTE5HU1hzTFJVdDZheEovczVSQ2Jy?=
 =?utf-8?B?M2FEUTArZXVhUmZESHFWTHU2UVpMYmhJanp3ZHJXYldyNEVmQTl2bFhEcHd2?=
 =?utf-8?B?cm9kM2pFS0dOWjF3aENwQnVrV0hpZGhneWc1U25MS2YrWnlqOWl6SHU2VmxH?=
 =?utf-8?B?bGd6cXpiam55UStnM2JEaGFLelNSVHN1dytKd203dXNWMGRjU3ZuaHlZTmxS?=
 =?utf-8?B?a2p3NkptMVRGVURKOVBGendaNW5zSUpkQll0eFEyd0d5TDFmS0tVckttMEZG?=
 =?utf-8?B?TXJYYXhUQ09pTEtXa0ZQNUtOS1liMHUxTDZtcW1zSFJscjJhSlkwRVFPMHdt?=
 =?utf-8?B?bGdkU3VRbjBxdExYcC9tZEdJWDNjalRBRkFORjFKbXIySzBUQ3lWanBMOSt3?=
 =?utf-8?B?NTQzVHZSOHJIeWFOV0p3YnBQWWg2SzQ2bHRrK1ZiU2tZS2hrVGY2SGJwdzVL?=
 =?utf-8?B?MmtNcm5zbUVQQTJwMW16dUtWdWp5dEhGSzNGQjQzY2JSWTRoQkF2dldoSHNq?=
 =?utf-8?B?ZlFLaFFFYUVTWXcxamkwdUw4NDVVek9BcjlhOUJBVzZtZ0EzY1JjSFRFaThh?=
 =?utf-8?B?eis2QlZTRElJa0tWemZPQ0lMcXp6QU5naktldlZwSTF3SHV5VGxSb3V5dFpZ?=
 =?utf-8?B?VnM1eHZLQkh3YTlJU3lvNW5pdWNSN0ZYRkdNaGh1amdUY0FkNTRrT21rRjRG?=
 =?utf-8?B?RXRmd2tnTTczeDVDakJ4a25UL09TRENITVNPbksvRWFRb1VobmFvTDNYQStM?=
 =?utf-8?B?OVEzWEdnM0RLOEtEQ0F0M1BBQ1lzK1p3azZLSit3bFVBaElSNXdGakRtWDBU?=
 =?utf-8?B?cjVXN3FRc1E3aWJjanRjNjZlZFk3NkoraGx6NDlxaVJJeUlKZTBsdzcyL2pu?=
 =?utf-8?B?NXc3WC9GMFgyaXpQOXBQWTRXUGJHd0taK0Z0VkdzSzZmSU9PaWRNLzdBUVZy?=
 =?utf-8?B?bEs2QnMyS0w2aTZvM3kvai9oSnFLWTl1YlBGYnJMZnhYMGJHWUJCSWhHR2ND?=
 =?utf-8?B?SVpwTklBazkrN0ZWMmU5dDEweGNlblBmQ2drS3kvclpZR0J0eWNtdUFuRFFu?=
 =?utf-8?B?S2RoWTBzb01FeVF6eEdsRFEyUXdZWDRvTlVzemxtU09PSUVLWkZiYjZSbWZu?=
 =?utf-8?B?NDRNRklnY3JlSUJLY3ZxQkduTUkrUWVRb0J1bTZMYk5EU1dqc2pLZVAwWW55?=
 =?utf-8?B?U00yVmRqTmJRU2g4QnYvK0RheGR1Yi9sUks4UlJ5SFdLb01CKzgxWm5haWpz?=
 =?utf-8?B?UHpubnBrNkh2UysyQmtMa2cvdmhjSk8zZ3RaNWRmQm8vekdFeVJWSml3blpX?=
 =?utf-8?B?eEpSTGRoMVpneUJuRElVMHlDN2RlazVwY2xrd2J4RUJCVDNPWWtiWGEvbmcr?=
 =?utf-8?B?VkJCandZbEdqeDFyZjJ4TVVkTVFIVnYxcHk3aTQzZkFpSjhpeDZ2MUl1NVo0?=
 =?utf-8?Q?kfJzWY0hzD6Qkb2lfJxZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(7416005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2M0alVlK0NOSHVxMHJaRW5LVzZiOFlONllWSHN6K0ZQTGdHL1IyRER2Yk00?=
 =?utf-8?B?d3VIWkx6MzB3dk5uUkYrWVM0ZGRBWmsyU0EwM1duajFmd3N0ajB3blhYUTJ6?=
 =?utf-8?B?aGhTcjkrcnFLTTRoejVsbFJweHVwU21CWGlmRkJlTDlxN0VNdkQ5eHN3RC9h?=
 =?utf-8?B?THR6WHdRVWdLeWtoZ01tMEhSUGhwY0hKc1NOekVVVHdEZ3ZjWllva20wMXQy?=
 =?utf-8?B?bjRFbmZzbkVMM00zMmRUNVBqYXNuYWtJT0tGOHdiVGVvcjVCTlhjQnp1ZXdV?=
 =?utf-8?B?eUpWQisvMjFKbWNMY3o3aWc5YTJrdnVQUDdoNUdYbTJyL2NNeFhyUmpKaVdN?=
 =?utf-8?B?MTJmN0NSbE1lcW4rSWNxQ2l3MWdHODlHUjVldVdUejVVTzRlVGJ2SXphUEVU?=
 =?utf-8?B?bjhpOEloNFZJNC9jOGMzVWl4SnEyM0JhY05pdlRkK0VWTzkrZCtXZk1yajFu?=
 =?utf-8?B?QXlCUzdWd1kvb1hmOXFGV1B3ckdHZVJFNzY3amNYRlBDVWZaYnU4ZmIyMmlv?=
 =?utf-8?B?SE9ZQjhzN3BkSUtKTE5qSW8wRzdDYmdjWWlBVFJsZnZHVWZIZDNWSnFWbjlQ?=
 =?utf-8?B?YWJZcDB0MitlZXEyVUFNb29PTTlCRFdhdFNwOWs5MlA0VE1wZ1dDdi9HZUQ0?=
 =?utf-8?B?Z2NtcFhoVFRsRk1HM1VZRHNrR0hkcnN5NjVzdGFnd1ErL25jRWxzTE04MExF?=
 =?utf-8?B?SGR0cGg3c09XTFh1MlZPeUU3eWlITDd1RURia2JHYnpjUUVqZ1o2ZjFPT3lK?=
 =?utf-8?B?OUR5ZDRaWEtHKzdTR3pPem1Rc09Ock1BZjgrK3R1S1hJREVCYXhrcnJxS0JL?=
 =?utf-8?B?M2dWbmp3ZS83K0prRzI2MDdSbGU5YTNxc2pNS1BESVgvTDZNeFZCOXVOZUdk?=
 =?utf-8?B?Q0ZmUW0zSXpkbHFrNTQvVTFSRUkreWNTU09qYXJ2eFE0VzNIQ3ZtU205RWxF?=
 =?utf-8?B?VkpEdVlyKy8xTGlzOGV2V2hoYlA2TW40UFAwYmZkYStzVTFvUzZkUGRGbTNM?=
 =?utf-8?B?WWJjdXpzUlBlT0g0WVNnMWoxNEFISWJKREl5N3pKNjNFaFN1YnhLSnpreHZG?=
 =?utf-8?B?ZXoxK2poblNuVFV4QThwZjVjYmRmSDcvcXcydWdXWmNuQjBncXN0Sk1Gd0xa?=
 =?utf-8?B?M1JmQy9PT1l3Zms0MHdYSHRweGd0N3BXei9lQ3R2UGU4bU0xVTIvM3M2Vzhp?=
 =?utf-8?B?N1B5VzlpcWMzM09aUFZ0aTZnN1JEZnRmRnZKbWtHZ0RJL3VrWUxJVFg4WElj?=
 =?utf-8?B?eDVpdWNNdy9laDhRWXBhWkc3SGlWdzdmaERHVkx5YWhaZ2ZjOEozaEFGQndN?=
 =?utf-8?B?V2pzckRmOXFTNzB2T0xwUzEzR2MzYnpUbFdLNGJiM2FYdEVvVWE5K01hejJv?=
 =?utf-8?B?Ky9DZTJCNGdicXNualhtQmErbEdBbEY2ZWxuL0lNeEtiT1FBbFJOd2NUT1M3?=
 =?utf-8?B?OXFlTDFIZlo1L2lHdTNHYnBkVDNNYU9RK1NmVER3cHRqcDYyU012N2o3Nk1P?=
 =?utf-8?B?Ym5EaU5uNm5XT1FjN1kwU2s5aXFicmhKNVMxQ3NESi9CamhPSHJtR0FwUWx4?=
 =?utf-8?B?RTJwYUNBbVM5cmFZLzVCdlRPTlVjU3hEMnM0RmZ1UiszRXNRYmRNMFp4UE5T?=
 =?utf-8?B?STlQTnlkM1VKbXJzS3BOc2lrbmpnZFdKOTVTUEhDSkhobEhCWWIxNlJ3TW1H?=
 =?utf-8?B?cTVjdlZFUmpXMzlYYmxzbmorNEFGZGlwSFlSVGZrWU9xMzhRdkd5K3ljNUVD?=
 =?utf-8?B?RlpHVU5UU1M0c0pGbzJRaUMyUHhoMGxkZkdhdVRUWXVFSXVkN25mREtPNUda?=
 =?utf-8?B?NTdCUnRlZDdMd3NrVGlOaERRNFROUzVhV0RFOWpXMjlxTkdYZjlXaTRST2hN?=
 =?utf-8?B?Q2NmcWUxQUhQamc2YjJsVlcxMXZKR2M5b0lYTjZjS0doUHd4aStEUGM5bThi?=
 =?utf-8?B?cVpaZ0JZQWhpMSs0dWVQMXUrUjhFQ0o0bitzL1JPWkdKanM0NnZCcC94MDRt?=
 =?utf-8?B?RzVmSFcxUjdaSWo4d0l1ZVNqY01KVU5NbTdnTnFPUXZwaW9WVlBVWkZmUUZG?=
 =?utf-8?B?QzYzU01PcDFCMWtvVW0yYTRMcTVoYjkyaytyenA2Yy9pZnc1cmwrQktyZGtX?=
 =?utf-8?B?OUFLd3VEbHJsL2VaNjJvOFd1ajM0MUtSeHRodnlSREU1S1EzYUJIaUs0WHAr?=
 =?utf-8?Q?IE2K1IRYvDgPgYuupGC5uUc=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0224d091-1393-4ebb-0787-08dc86173508
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 10:55:41.3436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcbZTMQQrYcbd50rg/I69nByoTcqTrOKuPzmD5iP9kYmkgjFzPC91yxymouOxnGSv6TFwUkD3jebeJCanM58FZ5231DH0tjck7Y92Bs/Ahk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9456
X-Mailman-Approved-At: Thu, 06 Jun 2024 14:31:15 +0200
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

On 6/6/24 11:52 AM, Christian Marangi wrote:
> On Thu, Jun 06, 2024 at 11:12:11AM +0200, Quentin Schulz wrote:
>> Hi Christian,
>>
>> On 6/5/24 9:21 PM, Christian Marangi wrote:
>>> This series expand the STATUS LED framework with a new color
>>> and a big new feature. One thing that many device need is a way
>>> to communicate to the user that the device is actually doing
>>> something.
>>>
>>> This is especially useful for recovery steps where an
>>> user (for example) insert an USB drive, keep a button pressed
>>> and the device autorecover.
>>>
>>> There is currently no way to signal the user externally that
>>> the bootloader is processing/recoverying aside from setting
>>> a LED on.
>>>
>>> A solid LED on is not enough and won't actually signal any
>>> kind of progress.
>>> Solution is the good old blinking LED but uboot doesn't
>>> suggest (and support) interrupts and almost all the LED
>>> are usually GPIO LED that doesn't support HW blink.
>>>
>>
>> I haven't used it yet but we do have a cyclic framework now for things
>> happening in the background. I think this is a good use-case for this
>> framework? Something would set the blinking frequency (could be from CLI
>> directly, or as part of board files, or architecture, etc...) and the LED
>> would just blink then. This would allow to highlight stages in the boot
>> process, though that is not like an activity LED so if you're stuck in a
>> stage, you wouldn't know if something is still happening or if you're really
>> stuck (e.g. no packet on TFTP or TFTP very slow). The benefit is that it
>> would be way less intrusive than patching all commands that could make use
>> of that LED. Right now, this only adds support to MTD, SPI and TFTP, but
>> what about MMC, NVMe, USB, other net stuff (e.g. wget), etc...
>>
> 
> Can you hint me on where is this framework? Checking the tftp code i
> couldn't find extra call to it. Maybe it's attached to the schedule()
> function?
> 

https://docs.u-boot.org/en/latest/develop/cyclic.html

> Also notice that it's really not a one setting since almost all device
> have GPIO LEDs and doesn't have a way to support HW Blink so the
> "activity" function needs to be called multiple time to increase the
> counter and toggle the LED.
> 

Cyclic callback would be called twice per expected blink period, where 
you would toggle the GPIO (essentially making it 50% duty cycle, but 
could be more fine-grained if you want a different duty cycle).

> Also this have the extra feature that you can check if something gets
> stuck in the process. The lifecycle is:
> - Turn on the ACTIVITY LED at the start of the thing
> - Blink once in a while (for very little task this might not happen)
> - Turn off the ACTIVITY LED at the end of the thing
> 
> Soo if something goes wrong the LED would never turn OFF but would stay
> solid ON.
> 

Yes, that's something that wouldn't be covered by cyclic framework here. 
It all depends what you want to do, if it's an activity LED, then we 
need to hook ourselves deep into frameworks where stuff is actually 
happening. If it's just to specify which stage of the boot we reached, 
then cyclic would be good enough probably (register for stage 1, 
unregister stage1+register for stage2 for different frequency, etc...).

> More than happy to rework this to a less intrusive implementation.
> 
> Maybe this can be generalized to some generic API like task_start(),
> task_processing() and task_end()? Might make more sense than having to
> add specific LED function to each function?
> 

This also likely would introduce a hit in performance if we need to 
toggle the GPIO in the same thread that we do TFTP/storage medium 
reading/writing? I assume we could still adapt cyclic to make it spawn a 
one time event instead of looping (e.g. by unregistering itself at the 
end of its own callback?).

> (AFAIK linux kernel have something similar used for all the trace
> framework so having something in uboot to trace these kind of operation
> might be interesting)
> 

Indeed, that's what's being done with ledtrig_.* functions, they are 
however scheduled on a workqueue and called from the subsystem directly.

I'm a bit confused also as to why we control the LED blinking from the 
cmd/ ? E.g. for cmd/mtd.c I would assume that the changes made to the 
mtd subsystem should be enough to handle those? Similarly, since UBI is 
for use over NAND/MTD, shouldn't that already be handled by the MTD 
subsystem, and if not, why not in the UBI subsystem instead of the 
CMD_UBI? One of the issues is that you may not necessarily go through 
the cmd/ to do stuff with storage medium or network (e.g. directly from 
board files).

For the net protocols, why not hook this to the net_[sg]et_*_handler for 
example so it's protocol-agnostic? No clue how difficult this would be, 
or if you'd rather have something like per-protocol activity?

Finally, maybe we also want to have a Kconfig symbol per "type" of 
activity to control what should be "monitored", and I would also suggest 
if we go this route to have a Kconfig symbol for the frequency per 
"type" of activity as well, so that one can know which activity is 
happening right now.

Nothing against this patch series or its current implementation, just 
throwing ideas :)

Cheers,
Quentin
