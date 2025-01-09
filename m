Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314CAE77188
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F9C80634;
	Thu,  9 Jan 2025 03:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LLPvTRjH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13145806B7; Thu,  9 Jan 2025 03:23:28 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BFB3806C6
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2whnQeTiKlfifZN/DvPG+zQ5SbBNer6RSnVladq0Cjr9hIP9vmlBPG+gIzkSDvnkaNFWp2nAmsCzsa7H/UMOtxIbBi0KFgDd5R1J8LfzrO0insPpWXFdOJzKc2bIgPkwTG7JyBvJd8HEOLZ2+6WSJuNBj8SAjKaE+4vmahaZRHeNVkGr7niFn4Sbdw+OBwEYCisb+EXuQaRC8j4s3AYt8yGfY7qNhjauMabqIIgvgwCVDkHDJC3fK9aKy0cwP5o+JNMpkqxlcE5hrbNDl7LMpmmB/P4b1ThdfMA/K6ZY3p3l/d48XgAsCU5E3o2fq3433LD32vAGEzmLsW/xcLsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emBEL3ekI3aGopspqQQZRD9YTflM+apJPcijTiuOJ5w=;
 b=uEDuWd1Ep4obl5+VO75RTNERrQe3Yzy/is9hNJ/1sjDJynTYKViCa+74cMpeEoAbreGaVBfqNp7Pc29JaZ8tXgRG09vmsS9YonVAtRIoyJF6AxWc3Qxu8QtgMWfW/PaqHrchj0gSFo4xazPM3nV3OaYnQt3ivevvSzII+Eo4mxH1jXIbq1SRSeXCBPl5v8EsF336rljVDDypPm1gUp9KDVhbp4GfR/1Z5rO1xa30kY0cRRJE3Cid60QmP+6MT58bMmtqNhUGmyNnaK3MgFxJ3mDQt6pCtWnYmL2YZW4/j6r7Ph5kGlVGiBxsmYK7rD1ymZdx7RaYqpUdMcKN8VWQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emBEL3ekI3aGopspqQQZRD9YTflM+apJPcijTiuOJ5w=;
 b=LLPvTRjHLnGqsTL4ari0o+dYrF7RABrPTnqDKdED0YGN3tkEcXpM0Vu57IQw5PXTj+wspBC4F7U+hiEVmVg2se+idB/R/c2zc4Wwph0/YAb57whhVa8figd/+52nyGbV4akhhc6lwBXCNUNYW2860EFDdBdEURZ6OADLP5hCpoUgSoFA3dg6WQ0G/tnUnjgBdWePDiv+9gkh72xpnVNDkcdI7el1DBb6ALEZrDIsZxrwK7nhbZBKbcibcXrtB4MmWB8bs5IzuiFPolMF8TvxpZV4B8DjYMuZXmgG/jntnPa9OvZz0YGPXkl7Kb26EQuvky6VUCsgD+SHeXMkKhOSDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:24 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:07 +0800
Subject: [PATCH v3 06/17] imx: imx8mn_evk: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-6-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: aa4d16e3-6d31-4903-0507-08dd30549801
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0xYSDU2a29vYlorVU00VlIxL0xXeVRaTEw4K3Zvb1IwR3NROEt5OVg2ZHFS?=
 =?utf-8?B?ZmJQUmdRTFB4MVpFZE5ZZnFOYStqYXJkUHBTRmZ2WGhJSDJpNnpUVDJPYjI1?=
 =?utf-8?B?aHRtVFBSbGtsZ1oyZG1ObnpQOXozN005NmRIR0tUWDBIRVBsR1ZJU25uUzRX?=
 =?utf-8?B?NlAvSS9jQ01CbHR0SlVUYXlZcDdWVHMyTlg1d1g0R1hGYmtPckk0VEVoMlVC?=
 =?utf-8?B?TGtRN0NzcEU4eEFyS1VMcWJZejdCekFYSVlqOStHeUZDMGQ3UFdSYnZaZS9Y?=
 =?utf-8?B?dC9MUXBvMDBhb2p0TlJJNXl4WFJxeHE5WUdRK2ltWStTZldjK0ViQ0EzeGlK?=
 =?utf-8?B?b2VQdk8xWERQYjhETCtCMmhnUkpBZHZIemJzWHIxU0V0L3c3TWppa2lqRUc1?=
 =?utf-8?B?NVV4S1NEVWMweGUvNXNldENWd3F6VWorcVY3SExnMjI0RW9KRk53Z1QwM0V3?=
 =?utf-8?B?c3prY3VydjY0YXgxMXZ3Z0x4THRTTUVUWFJKL0V4MlpWd3hZaStkTHlod2hV?=
 =?utf-8?B?cXRXRlk1VHJXK0xzTUhxVGYvRXFqemNxVDI5c2tDWlMyMXYvdTRpVkpuZUJ2?=
 =?utf-8?B?c0thWHR4RDFxL0d4TXA4UW5CSG1ubXJySEMrT2ViZnV6NlovTldzM3FDQ2lO?=
 =?utf-8?B?aDVEMW5OKzVzTmZWSk5kTHZTUDE5ZWxTd2pNeS9wM1M1VmY1eXNUSkdEK3Bq?=
 =?utf-8?B?UVdib2k1QVVyVlhYeGdLUjlJZ29iMmdldHhENHRlNjFIZDJqZ2dhTm5vdG5s?=
 =?utf-8?B?T1NQYzY2eW1senZORk1PaWpxdmtiRDBPQWxKcUVWS012TDkvVWlqalBNZU9F?=
 =?utf-8?B?RVV2VFB2UUFHai9iN2JTNnkxZFdvV0NPTXZlY0I0TitjV0hiU2lOK2hXNExr?=
 =?utf-8?B?Z3FoNUVWYTRuWjVkdm84TnFBYTFOd3d2bTh6eVJBRWdvay80a1M0OGkwRnJo?=
 =?utf-8?B?ZG1Zd1Q5MlNudnpZdzByV0NMVzJ4akFYa3JZMktRbExtRy91RTc1VlArcklB?=
 =?utf-8?B?dHVRV0NiemVZc09JcUxhblBJUURuSDJKOUt4enBvT1o0ZWh3OEJrVW1kd3dR?=
 =?utf-8?B?TUhKczljVXEzWkM2UmM0Si9PVWRlekw2RlJUV1R3cE0vWHVEMURkNWdEZk5I?=
 =?utf-8?B?MUFZTmVMWkl3KzFCaTVlUHpMZzlvMGxFN2xSUjZ5YXRrMCtUNGYyWGgzRzlG?=
 =?utf-8?B?NWtsRUJkQ1dvYkdNeG1KU0pjVFl5Z3ltVXlZY3BNR3lGWTBjYzNyMklmUjhE?=
 =?utf-8?B?aFZFT05tL0EwVXhxbmNWN3lNUHpTaVV2UTBYU2lhU3F1NkRTakZxeXAxekYv?=
 =?utf-8?B?TlRKTERiMXdZMGM5T0xnK3lyNjk4dEJOOUwwaG5nbi8wR1JsZG0xSlU3ZGdM?=
 =?utf-8?B?K1RPcEZYOHFvUlZoK1BNeEdkTSsyWDBNdGk1U2xuRUh5bWpkUVpyMnR0T3lJ?=
 =?utf-8?B?VzdvMXBPclo4VmpGTk5Eb1ozd0g0UTZHdlZtcnFkdk5nTGZKV1c3RUR2d29w?=
 =?utf-8?B?V3NPWGhJVklsZmFpakhVODdUa2preE9VODN2bXc0RFpzcWpyWlcyNVRIa2tL?=
 =?utf-8?B?dnl3WEM1NzJrUFdiRFZwL096SmhzZmlna1p1b3Zzdzcvc0RuRW5iY0Z5Vkkw?=
 =?utf-8?B?elVqZjFsN2hETnl1UW9lbVhsclZRTURVM0R3NFRnK21kMk1TcWxCMFVlam1V?=
 =?utf-8?B?SkR4SEI1enpOVk1sUU1BbHlIWEVaTTdoVnFUSDdMRmpjb2RVVy9lNWVzcFcy?=
 =?utf-8?B?QjJ4QXNhaTJtMlduWkRleU5nUHVyUVgrdVBGdlQ0dzdCR3dQYmk1T2loaWRD?=
 =?utf-8?B?OW5oUFdvdm9DSmswZjk0YTJSSC8rWE9HYmlreGVZdWZ2eUlIdDYrSGJncEtK?=
 =?utf-8?B?QUd0T3JuN0xDSlFLOWk5K1hDRXpGTDNzMUFVWkpIUjdObmgvSnUxS1gwRFVZ?=
 =?utf-8?Q?EH0eCCrouLfumYj00DEC6gmWz2LSsdZ5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU9ia0NPOGorZXJleWxrUjg1akxKR3ZlekQvd1lvdkl5YUthWS9WWjdhamx0?=
 =?utf-8?B?Yk4rUVM4MHNOcVFCV0FXQVluOVU2QVhibnVGZzlTbUNPUjF5RmJ4bGxWRDli?=
 =?utf-8?B?dTJpZTkwNGxHb0xpYlZMYlUrODZKTkhwcUxJMSt3ZnBiV3FQbHR0cFV2L1Y1?=
 =?utf-8?B?RU5LNUtEUExoQ2xuaGIzRUo3eHVMdTVQV3ZoVFduNU0rcmRjUVRmeXljOUU3?=
 =?utf-8?B?dGhpZVlWQ01FVnRtZENRb1ExWmh0NFdDTUpXV1VpbSs3NzBhazBHbnZmUWg5?=
 =?utf-8?B?SXFoNXkvcVM2L1lzM05jTy9oUHRYa2NzOGcwczNXTm53YTcyZXJkbjQzRlNh?=
 =?utf-8?B?clRieXl3emhyY0piWWUydHRDYkh3THNtZEY4ZHBqWEpBYVUwL05DeFAyQzUw?=
 =?utf-8?B?UWFqTGwxWkdCM2RsY0VWV0pXMk5rZkZ2enRReUJpbnlidTVIdURmZ3Z1RWd0?=
 =?utf-8?B?L3NNbFpTKzBiZ0NmL2F1T0JCQUlxckJxS0RRRE1MYkIvZ1JTa0Jkdk9nT1pv?=
 =?utf-8?B?Y1BYOUdUUHp3akdjOU5GVU14MFZiR0R1VVZ5NGUzTkpjVFpVVDNsQjJaV0lr?=
 =?utf-8?B?Vk14OVNzdExTNEJHTy9ydlorY2VFY3FLcTh3NGk3ZjRFcEk5ZFlOS3JPQ1M0?=
 =?utf-8?B?N2RUMWdIMXk3WkpEVG42RWhlK3JTMzY4Ri9ZVTdSVVBaeHlBckdjVUkzZnZQ?=
 =?utf-8?B?dUdnaUI0NlhISWdSTXk3eFNnNmlBaVpEcFphOVl3WG44RWFYMTJFOTVOOTFo?=
 =?utf-8?B?YytXM01NaXNnUk5PbExWRXdMZmROeXlGK2llMnNRRkFWUWd3N1N2VFEyRGxa?=
 =?utf-8?B?eGF1SWxwVjBKMTYwNHdld1h2d01uTmpyb1FVMzN5Rno1MHlpQjdUc3ZoZFRn?=
 =?utf-8?B?S2J2M2ZlRzEwd0lnUERXUkFiaWplUUxSYndpZjJ6bkp3Rll1MU9RSjZQZmJG?=
 =?utf-8?B?WCs5amM5amdmMHlnSTU2eE1KOFl5Y3lCY2lTNkg0QkNRN3QzeDdjMVltR0xl?=
 =?utf-8?B?VStWeWJKRUwwZ2VrL3FhTHV6UFYxbTBRL1gxT2dRaDFQZmlYSzFsK3FHelZq?=
 =?utf-8?B?TW4vWGZucXV4ak4vb0VyeS9pUUMrQkxRTkV3YjhneHVjdXArS0c3YVA3Yzc3?=
 =?utf-8?B?ZTV6S3ZoU1E1V1FhbEdUSmR4WUxXdkgxYVRCRWF3SzVOY0N5ejZYL1RRN0ZC?=
 =?utf-8?B?eWYrU0FldTVya3NWejlqWXdXNWxCeXY1WisxZE45ZHN2TnFDUUJnOThQbmdU?=
 =?utf-8?B?QURLRXJENmJCODA5QnUrMFkxbUpDeldweWVnUVZsZGFVQTZ1Rzh4aE0xdHlz?=
 =?utf-8?B?OGRlWGhreW9mU1B4QURaWngxdWZQSjVQRXE5T0FwNmRmTyt3cS81MklLY01I?=
 =?utf-8?B?R3FKTkl0Unk0TklHSENqb0RnQ0V1V0hBdDRGRWNqaEN1ZGxDdnhCNDl5dExB?=
 =?utf-8?B?UU9paEVkRHBMeVE3QU5FakNmU2J1OWJKakg3OWI4MDFGVWgxb3VsV1RvZGRa?=
 =?utf-8?B?cFdkWTk5STE0eWI5WDNVMmVENHI2T2ltVHlQeWp6QXIrV2FaNzI0Q3F6T0Uy?=
 =?utf-8?B?SjZmT1M1YW9ZQWVud0hoZ25BRTdqc3hrY2hWZ25mUHBDRndONlI0bnNXSmRE?=
 =?utf-8?B?VGRGUERQaE4xTFNiN2ZPck94eTN3UG5ackFOQzFCMi9Fd1lnaFNUSjFUWDNR?=
 =?utf-8?B?RGhRREh4TXdNNldGQTdDUkNWNUZmT0xlcUFZQXpYRWZQaHBaZ0FpczhQYXc2?=
 =?utf-8?B?bnZOcWNuemZxNFVKcUoxbENEMkM4VUU3MVQ2OC9LVUE1OG91NG5GUTNVNFlC?=
 =?utf-8?B?Yy9zRVZXUGN4aTF5ZjZUNGpob3k2LzFaaC9sbnN2QWpjMnR3YURyYVZtVWRw?=
 =?utf-8?B?a05lUUxXMVFqRlJwcWd4Y0pBaFFpRytuWmY0Q1R5YlMxRHVEWDFCaE1vcGhw?=
 =?utf-8?B?RVI5TlIvaEx4UWxwbnVwT25aTmh2OU1BVVFLRkN1ZUFFVXVSSnV5eXRBdU5U?=
 =?utf-8?B?TUYyVUVUR3lFTlRDK0dNRWRLR3IrS1N0L01IOE5qNTdzZWdTRmYvTStQcVVN?=
 =?utf-8?B?NFBPb25qOG1DWlQ1bmZRNUIrZTAxeXJOVjVSVGZ1WkpjY3dTRk5EcEl3UXdO?=
 =?utf-8?Q?G8rNLaV/nRhiUc7fmAJVhEATh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4d16e3-6d31-4903-0507-08dd30549801
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:24.3247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTyMTT6qqVkMHrdOQxzIdBrfCWCGuQcUtEWS3VJA9BiLrZXj9jBw6zueIS/X1DV4/tuJfYTN7ykTCeExigRH9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

From: Peng Fan <peng.fan@nxp.com>

Drop unused headers and sort them

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mn_evk/imx8mn_evk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.c b/board/freescale/imx8mn_evk/imx8mn_evk.c
index 6b6fb0a7dd2178a20d9869a1b478d5a8b5124ad8..f20ffbc52501a8a5c3ae9603b04847bab2cbd8dc 100644
--- a/board/freescale/imx8mn_evk/imx8mn_evk.c
+++ b/board/freescale/imx8mn_evk/imx8mn_evk.c
@@ -3,12 +3,10 @@
  * Copyright 2019 NXP
  */
 
-#include <env.h>
-#include <init.h>
 #include <asm/global_data.h>
-#include <miiphy.h>
-#include <netdev.h>
 #include <asm/io.h>
+#include <env.h>
+#include <init.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 

-- 
2.35.3

