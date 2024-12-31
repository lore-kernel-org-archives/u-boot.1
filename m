Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB89E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 02:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B41880584;
	Tue, 31 Dec 2024 03:34:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oqjhLIVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C65C805C1; Tue, 31 Dec 2024 03:34:22 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63EB2804BA
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 03:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QibEoeNlFMuoDhhP56zLO3vuMlEdYLWr8cDoIDCSevjx3gm4qOeZL+Z++M8PMkWV5V14hi8yXOh4TS5sY7/uiY5Of0Pb6jlrc+hO3hzvhHOGMgff39Dq3nZtBgrAUc6wGRtHwLsZ3n0sLD4b1eovgEkCaNeoRwCDhkjgzl5FscFSLYsZMHwKnuD8U/wZZlZfaPDT8hls8h2myxpOo88ERJNxSlgzPkdK1/i4AMvDveT4zkbQLMNZLKMtWYDGQwhPnQvAgD4O2l0ZIqhS3glKQzht7cjabWiR4w5Vr/n+ByRjhwo6lbO6A01gizP1LJinlpMzGyvNLZq5C1YVNh4GHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjpacHG1ZU0rtJHb3CMYOz55v7URF/gMnHw9+8BiUkI=;
 b=UK62/CMdFyCmJq2wzqG3bHgghDdrpll50J9KS5tNCvFXOiCvmQp1EXKHxJTSSabEG91mt2hgwb70IBzX1ZHHvWEvW1HckW2WIcDPtg6C8X5pyngEVjhv27o2TSYt5dQO7VJOXLBh1au6gRpVgThNo7ji0UjpDSRG8ssgDHzjYLf9GvlDza5OAXDS9f5WE8WBsNuk32MYrptNNo3muKHhN8+O8+eH25FfY+OU3lyk9FbMFmfOmdt5mhUVoyQuXwDPGQdVWBPreaETx3UBdMH6ZpH1FgtXncoqKS3+ojN3xbiPwW3As7c/+raBgHQ19Xlv0KKFnj6JnWtjdKJtB2ZYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjpacHG1ZU0rtJHb3CMYOz55v7URF/gMnHw9+8BiUkI=;
 b=oqjhLIVDOQpUeVaX0ZHwQ/DnGQywDcOFhiZ3rag/MvFArywcfIqqpkb2pvBSa1J1Uq+jInV3/kZTZPRFFGF6LtqRil4WTC2j4h5LWc/aydSy/cUVmqbEK14EBBxQeq3h/aFds9Vb6OCphzun0R12clr2F60DnPev5mOk0o8eyib3KULkuBxLQAERS9CNz4qRCr3EZFzbO8jVMmfQAmbl+1UoAcScg9Ih6kvpMmmpZ/LVGXliTwyGc30VTFqQbYx2XRPYB1VCzF/nlZZ8LZE/yDKZhLOUXTHLrtz6cOS9Du13W3mV3ubxy+ubQYkaYoPWweBCr0FlLad0Apymb13hmQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PR3PR04MB7417.eurprd04.prod.outlook.com (2603:10a6:102:8e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 31 Dec
 2024 02:34:14 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8293.000; Tue, 31 Dec 2024
 02:34:14 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>
CC: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "marex@denx.de"
 <marex@denx.de>, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, Peng
 Fan <peng.fan@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYyIDE2LzE3XSBpbXg5NV9ldms6?=
 =?utf-8?Q?_add_i.MX95_19x19_EVK_board_basic_support?=
Thread-Topic: [EXT] Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board
 basic support
Thread-Index: AQHbUoq3EiCr5MsbS0ytjsh9g3+ir7L63NsAgATUM4A=
Date: Tue, 31 Dec 2024 02:34:14 +0000
Message-ID: <PAXPR04MB964402195A6BCEFE58D850BEE20A2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
 <CAJ+vNU16T8Chsdy0+tHy7tCcfKfVGVFUr9baTCH7U4X9v6dFRg@mail.gmail.com>
In-Reply-To: <CAJ+vNU16T8Chsdy0+tHy7tCcfKfVGVFUr9baTCH7U4X9v6dFRg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PR3PR04MB7417:EE_
x-ms-office365-filtering-correlation-id: 1e20d91b-3d64-436b-44e5-08dd29439df8
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?T2ZpRWhrblBsQ1NsbjNEVjR5V3U3SGF0MVZTL2h1bHRzSmRJZWVzbE4rL0xz?=
 =?utf-8?B?R3BFMHk1anlKUVZnemRaSXY3V3B4Vnh5MlJaSlRDcEM1VUxVWGREUHEvNFI0?=
 =?utf-8?B?THpnR1NUWjBSZ20wS0tRTXBBc1JQWkx0NFh3dldaUDdvR09IQVloUjVqdlBa?=
 =?utf-8?B?VWtmcURKVmsvVStGRXJOeG4wMEJvbDdlbHhOaGRHNFBEWWJwZnJ5OUZCNU5u?=
 =?utf-8?B?NTJIOTBEK2YvM0o4aWZ6VzVOOXl2Mm1NZGd0SGQvblhNWWJ0SjZMQVFGYngx?=
 =?utf-8?B?b1RpeGRyd1NkUDZSbGtwa0FodWpVTHY3MTBqcTlWN0hhNnNUeU8ydStQemph?=
 =?utf-8?B?eDVMZTV2cjNsb0R0RUpPU2s0bndrSGw0R0dLRmtQZE9xMXZNNHh2eTB4ZUov?=
 =?utf-8?B?aUdLWHlBRWxXbDBVam9IZnFERllMQzVINmJvbUhESmhXOGpxTy8vbWZCbmZD?=
 =?utf-8?B?cytXa3ZzUkhzNDg2ckc1emdkRU4ybEFNbEVac0Y3Q21HL2xCUDNrWWZ1UE54?=
 =?utf-8?B?dlYxOTlCQVBlaGh6RWVwQkoxQnZvV0JERmVXSmFoR3prbHl5MlIvQkI2aHNI?=
 =?utf-8?B?RkpPUytBNUdnT0NmY1ZpNVNPeS9naWlSTVRLd1JCdWJLY1JTTTRIUE9qWDBE?=
 =?utf-8?B?WFZxaUl2NUt1WFpTWUJWS2YwZE5TajMwWWd3b2Q4ZWVyeTQ1a1AxSVpVaEJs?=
 =?utf-8?B?d0pGQ0FHQVJ2TmtCSjJwNmJ2Rnd0elNLN0xCY2ZXOUhYbmRtZlJPZWFlQnRD?=
 =?utf-8?B?WGdvbFRRZmtZTDRJVkRJclZLRmJUYTlzQkx3Smk3Wnl3TEtMYnFibkVNZFcw?=
 =?utf-8?B?cXQrVmt6ajY0LzdPWDlGK0dOdFFyUzBMOC9zMjN4Yms2ZmNxKzZ2YlM5RTZD?=
 =?utf-8?B?aWlkRlZ6YlpxT2hZeE1ySGZ0K1I0M1VXSHkvNmdSZkFHckdYVUhFT0FwbEhV?=
 =?utf-8?B?L2hCMUxNSVc5UlpUZUhuSGsvVnZRZCt5S3lkYURWdVpReWg5aWR2a0gyL0c1?=
 =?utf-8?B?ZDBiYWh6dVh6ZUJlNk51ZnVwbE5kUGc4RHhWcnJlV1grQ0RwZ25TOHNXUUF2?=
 =?utf-8?B?UXR6N01TUnN2YUNteWd1WEJWa2VGdzRja2l5UUU2ck1uWTgvME1yeFB2RW5P?=
 =?utf-8?B?QnBZWHpXRE5ZNVlnckJwRzVYaUtCY0JNZzQ2NUd4SmVBeXVGQUZYdWpPUjRY?=
 =?utf-8?B?RjBSMlZwV1gwVHlBMlY3bnRWZ2dremJBVlFSS2pBKzFzRi9lYkxiOUpBSFgw?=
 =?utf-8?B?aUdsWGNDVGpXQjVac3llMUhCRHN6YzVQalVsWm9IK08xRzVMYUk2MlBUc2lQ?=
 =?utf-8?B?Zjd3MUQ1QXpkSWFodFRRdWx1T1AvdGZpR3lpcHdZcGU4cW9ZM1pSOEFEYWZM?=
 =?utf-8?B?V0JPaEMvT2RHSXp4cjV5dzYyU0JoblF4RUZ3dlFqUVFsYzFIZExvY1pxNmtl?=
 =?utf-8?B?MFZpTnBEcitZOHJPQVp4STV0NXNBeC82K040QVp1b1duRy9DTDA0S3p2aVBX?=
 =?utf-8?B?Ulh2UTB4czVPcENva0VrMzNzdFZ2SzRCSnVTMTN1VkJWVUtwWHlwNEdqQTFu?=
 =?utf-8?B?L0pCYmNqQ1Q3MHozanQrWmEzS05UcERsWUY0NGJLL3drT203MHVxc283K2tw?=
 =?utf-8?B?SXpNQTEyL3RBQWZpRzF4KzhvUzRKdDhXamlPejVXdUM1ZGJoWEVEK1B5QWFX?=
 =?utf-8?B?N1dEcGJpTUsveFd5QkgvNWRMeG9DaWZ6ZEdVeTVYTkZwYStnbStlT1FNcXov?=
 =?utf-8?B?a0RUSjYvRWJiU0d0L2RYQWlpVTVyYkFjMU03WmFXb0lUMlhxYm84TlRtS203?=
 =?utf-8?B?KzJWTmE5SU1ndWR4Rm9mUHhtanBIRysrU1NlSW9mdmlUSGJRNlRPbm9OeUQx?=
 =?utf-8?B?cDBIdE9zK3dsbzdTMU1RQitWMDEwSEZOK2pkalBsS05JaEZhY0wzVFVFOHFz?=
 =?utf-8?Q?shP9uty6bonfU8JbIHUoFJpcqvnGnalw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlRldG0raUxUZWRwdEo2OENvN2wrVjNVdjd4cUtyeUMzbHRLR2IvOUpuKzAy?=
 =?utf-8?B?YXp3cWV2aFIvMU83Tlp1U21aYytCWDE1RlMwV1JmSUg0ZG8zTEFTcDVycTdu?=
 =?utf-8?B?QnJQamEwT0Y4WWp4dVhialAwRk0zMnRaczYzWXpmMTRlVjhhRlUrNllTam5l?=
 =?utf-8?B?aitSQ0NKR3IzSmNWK2RpV2xKVXNDR21ZdXNYKzhRWU84TExWTmVHYzVicTY0?=
 =?utf-8?B?emdYNVlzZnlqMTNxT2FuVzBJcEtGU1dOcmd1Y010MkppcnArWmZabkdXZVUv?=
 =?utf-8?B?KzNDV2pheTBZZ3QrdFQ3cE83bTNYcEtiWE1XUWJBZG40eGlzYnhWc2FEOFND?=
 =?utf-8?B?SDhyWmloZ3hoaHlLSkJSODlyeUE2RnF2aldDMDdLU1ZzWXVHZkNjMTEzRnJ1?=
 =?utf-8?B?QzlJM29sVzBadGt0TjBNYkVMam5UY0JKUGZQVjBtN2laMnZzaWN1YmFEVFU0?=
 =?utf-8?B?YXI2blg0Y05WSHBqbG8za09xM2twdHJTRGZaZDdrK2N3eldEWU4yZWhta0VN?=
 =?utf-8?B?eG81WCtwYzFzWTVpZ1JMUlB1dDhzTllQT2w2eXljWUpvdCtvS0cxc2dHbFRZ?=
 =?utf-8?B?eUh0QkxwZmVOYjQ1cHI5RDFGTDRvRGRpcVJ0bGlXbWQ3WGZ4ZzdtL3J4K3BS?=
 =?utf-8?B?SWNKRE1haFhsQXpQclcvNHlmb0l6WndUMW5VMzZ0TWtZSktXeHltR01nV1FE?=
 =?utf-8?B?b28xWmhDeTdKdDdMRUVVSnp5TENnRkdUUkV1Zk5hTjIrQkU4N05kR0N2cGRM?=
 =?utf-8?B?MG1TYkU4VVgzbEIxN21wM0xHd09pTm9yR1lqWG90bHM2ZUF2azdJT0RHOEF2?=
 =?utf-8?B?dU83UzEzVHVoYUo4YUZUM1h6bXdRV2wvR1ZOVUdwdnZrb0o2NHc0UUs2R0l5?=
 =?utf-8?B?aGZtMmdsdjFaM2pMMUJZeWdmOUY5dFRGK0FHSVByN201cmhlNnBSRjliMFRn?=
 =?utf-8?B?MHF1ZmdCbDhyeG0raldERUJtUStmZWd0Z1hVV2xPc1R5R25McW5YMjdaMGZS?=
 =?utf-8?B?ZndaZXhnRHBMTzJSNW1ZTHIxeDJuemtyVnZqcjJ1WFo2ZkNkdnZMQlNMMU9W?=
 =?utf-8?B?YXdVZ3dCckl6MHRGR1c0N0RxVGlWR2hSYVhlL2JPVFYrZTM2ZEd5Y3FSb1gw?=
 =?utf-8?B?U251aE1tSXhzNTRBQnlYZFpNeGRPL1FJZFF4SGJuWWxGT1FVczR4Y1FIZERy?=
 =?utf-8?B?ZXh1eVZ0ZGkxei8yUlRIamU4djI2UVQ4Y2w4U0gzaTBJbExJT0lObGdIWTdi?=
 =?utf-8?B?ajJwWjRWczdPZzR4UEgwSXpHd2RxS2syaURSenprSFFKMThIUmV5WG1ZSVBp?=
 =?utf-8?B?S2d1OExsN0RES1JoS3VUVGQydDRJSWFCbWNIODZtWWQzcDZYR1ZzaWFSZWI4?=
 =?utf-8?B?c1VFWEpDcFVaVzVLZTJHNEZtQVQ4MW4xVGhpMHJzOHhsR0k5S0U2UEtkSUxE?=
 =?utf-8?B?UndGR25pT2EvaEgzbExkWUd0dVV0b29uSitCRUNvZnkrcjgyczdPWWR2aTVZ?=
 =?utf-8?B?U1A4VDNYTG82Wk9aYVdRMk1BOTh2R2t2K1pHZHUvRXNER0RaSW5uSEN5U2RH?=
 =?utf-8?B?cHdIQlREdFB3Y0J5bTdKZ01FNWZhcEVIL0I5aytuNHZsRW02dC9Mb3lHc250?=
 =?utf-8?B?ZDY1UnVkOGYrTVdBWnNzOUxqdnp3cUk0Wlp6bnlHa2oyMTgxajdpZ2JKVXQr?=
 =?utf-8?B?cTByL2FqanUrVWxXcC8wUVVraW5ZdXlla2plZ0Z2RVVTajBmL0pyTnpjeWZo?=
 =?utf-8?B?RWVNcjM2ZTdlV2FGQnhKdTc0UWFLK01Ua3pzVFIwaGswL3dwa2RyMS9Fa1hB?=
 =?utf-8?B?RStKZFRtUExydU1nYnFZbGxRUkVha0ZtOXM1Z1NCcnlja2lOS3NueURqQUtX?=
 =?utf-8?B?VTBQV0JESkNEdkoxOGcwT20wNHF4Um5vWTF5OUIyeDJYOGFFREpYdXZqUG5K?=
 =?utf-8?B?QU1OYVJ3dFdjeFhwNXJ2SXBTNFdpV1hRaVJkQjdrbUZrZ29TMFVwZUc2cFBV?=
 =?utf-8?B?b3U4eEFsaERSZWxla3Z4OFFWaXNqSnVobVhzWjBHSmVTU1RNWTQ3VGc2ZGRm?=
 =?utf-8?B?ZHo0dE43cTB5UTdtVHBzT1dpdmhpN2JMTGkweHZ5WVYvMnQvRFd0ZEh6cU5E?=
 =?utf-8?Q?5Tk0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e20d91b-3d64-436b-44e5-08dd29439df8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2024 02:34:14.6272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddZtLa3fQ5No8y/6nca23DxPe46uxyyhIS7/9auRrG4TyrC1rX7GSHWCy6+7QDU4FuTwf4pVhWPO4fI5Lj/L4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7417
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

PiDkuLvpopg6IFtFWFRdIFJlOiBbUEFUQ0ggdjIgMTYvMTddIGlteDk1X2V2azogYWRkIGkuTVg5
NSAxOXgxOSBFVksgYm9hcmQNCj4gYmFzaWMgc3VwcG9ydA0KPiA+IA0KPiBJIGdhdmUgdGhpcyBz
ZXJpZXMgYSBnbyBvbiB0b3Agb2YgNWNmYmY4YzM2NCBvcmlnaW4vbmV4dCBvbiBhbiBFVksgSSBo
YXZlIGhlcmUNCj4gYW5kIEkgc2F3IG5vIHUtYm9vdCBwcm9wZXIgb3V0cHV0IGFmdGVyIHRoZSBB
VEYuDQo+IA0KPiBIZXJlIGlzIHdoYXQgSSBzYXcgb24gVUFSVDI6DQo+IFUtQm9vdCBTUEwgMjAy
NS4wMS1yYzUtMDAzOTMtZzliMjkyZjdkMzQ3ZiAoRGVjIDI3IDIwMjQgLSAxNjoxMjoyMCAtMDgw
MCkNCj4gRERSTUlYIGlzIHBvd2VyZWQgVVAgTm9ybWFsIEJvb3QgVHJ5aW5nIHRvIGJvb3QgZnJv
bSBNTUMyIFByaW1hcnkgc2V0DQo+IHNlbGVjdGVkIExvYWQgaW1hZ2UgZnJvbSBNTUMvU0QgMHhk
ZWMwMA0KPiBOT1RJQ0U6ICBCTDMxOiB2Mi4xMC4wICAocmVsZWFzZSk6bGYtNi42LjUyLTIuMi4w
DQo+IE5PVElDRTogIEJMMzE6IEJ1aWx0IDogMTY6MDY6MTUsIERlYyAyNyAyMDI0DQo+IA0KPiBV
LUJvb3QgU1BMIDIwMjUuMDEtcmM1LTAwMzkzLWc5YjI5MmY3ZDM0N2YgKERlYyAyNyAyMDI0IC0g
MTY6MTI6MjAgLTA4MDApDQo+IEREUk1JWCBpcyBwb3dlcmVkIFVQIE5vcm1hbCBCb290IFRyeWlu
ZyB0byBib290IGZyb20gTU1DMiBQcmltYXJ5IHNldA0KPiBzZWxlY3RlZCBMb2FkIGltYWdlIGZy
b20gTU1DL1NEIDB4ZGVjMDANCj4gTk9USUNFOiAgQkwzMTogdjIuMTAuMCAgKHJlbGVhc2UpOmxm
LTYuNi41Mi0yLjIuMA0KPiBOT1RJQ0U6ICBCTDMxOiBCdWlsdCA6IDE2OjA2OjE1LCBEZWMgMjcg
MjAyNCBeXl4gbm90aGluZyBhZnRlciB0aGlzDQo+IA0KPiBBbnkgdGhvdWdodHMgb24gd2hhdCBp
cyB3cm9uZyBoZXJlPw0KPiANCj4gQmVzdCBSZWdhcmRzLA0KPiANCj4gVGltDQoNCkhpIFRpbSwN
Cg0KSSB0cmllZCBpdCBvbiBteSBNWDk1IGFuZCBpdCB3b3JrcyB3ZWxsLCBzbyBJIG5vdCBzdXJl
IHdoYXQgY2F1c2VzIHRoaXMgaXNzdWUgb24geW91ciBFVksuDQoNCkJlc3QgUmVnYXJkcywNCkFs
aWNlIEd1bw0K
