Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C83BCA0EE9
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 20:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D11B801BE;
	Mon, 18 Aug 2025 22:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="YhqgOnDd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E62EA801DD; Mon, 18 Aug 2025 22:00:54 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 602D580107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 22:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiwi9rqRUIApi3XqHqB2R+yVk2n9fX53/gWwmv9jo2joEG8HdE68MJdNpK/wDuMCt+JYr4+edBUacIUzhFkhBLXzfw4YTvPFK5ixH4bQ0KjP0X2GbWPBFrsNXg7uXUEHyH9Z4pltP8As2Cs4cFj1LftoTjhmDkIMbqga+XIfIFnL3XYJ8VuvgIObFO41RgzNf+rSfUIc1MTOBdOGb/mbsttRebyOKGuCW6LP6PG2+6J8MHItU0eLt47OHa8zbgiBV1K4hFQ6bARzS8whcMbOm0DXW6w/EtC5OsEWmu+9/EMn1LZP0vbbMvOouPB7TFs7kE8CIFR/zpE49bSaUAbkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tS95AEDqhL29fVA+XqPWNv2mafu19wJlsv6uXU3x0k=;
 b=COwmjWRI3ljhUjxnvJyijw2L0Pn/GIrKsV+XVIhnDjHRckaNBe4ZYjbZdzs9r+7YdQQAp/hfAJFxWqqB7UM4vCb0mws1doxtReZsgLkm8TyR4Iq8au1r2iibHqX+9WYvz5uO+YCe4lhZ0wBqBIwRK++tvTbpOSg0zST4ThPog8VnbV0FiFhjA+QilW970Mp7Uh1NsSl5OmVoNiS5UZKI7IsmNizxBBGlGRAA+MX8HNhqHrUxst3Mi/VlXKwWv5NCr6dnto5LZ5JY3hH/oS8knLef9+GaW7ZfXRxidMMBnCmH77wqfr11dn0Aj3RKB1qKoWH6tzKWVbRiAuggUG2NVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tS95AEDqhL29fVA+XqPWNv2mafu19wJlsv6uXU3x0k=;
 b=YhqgOnDdwvGIXYIoaxw5ztjCl4TIIdhEUeNg01cQIpzAAsc3e1RaYklsRikoyb8UJPY4Z9d8msFB+7dKVyDAP+jDevOyt4K+8aiSLSqhQvLcnNv/2FoGWhzsEgpmVaLKYQkVPnrNW1DOdI+3kTDoZOwk35EzbY5m6LGOhEtSVqmdOr2v0RmhmnLhUTlVdAPc+gr8n9UpoRG5rW7vx7XAF0V7mLdqBS5FX0jOzISrOFl8Ru8D0/OqzWeW0LAe9mEvjAfWMuA3x8+LaMT1OYI9L+B8EsPRQq4xx38vVwLVWOxeObGrGlIkI2ZzQmo0rTqBR9B7YNvpKtHoeVR9oUwWVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10003.eurprd08.prod.outlook.com (2603:10a6:20b:63a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Mon, 18 Aug
 2025 20:00:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 20:00:50 +0000
Message-ID: <00e93439-e47a-4ca3-b309-1400b54d8bfa@iopsys.eu>
Date: Mon, 18 Aug 2025 23:00:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/21] mtd: spinand: Enhance the logic when picking a
 variant
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-19-mikhail.kshevetskiy@iopsys.eu>
 <46de0ac5-1777-4f05-a951-ea3cc80bfe26@kontron.de>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <46de0ac5-1777-4f05-a951-ea3cc80bfe26@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0344.eurprd05.prod.outlook.com
 (2603:10a6:7:92::39) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10003:EE_
X-MS-Office365-Filtering-Correlation-Id: 732ad558-71c1-4a81-e744-08ddde91edb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnFHRFN5L0l4SDlrOWhITkNFVkpkaEFEc29GWFRhZjBrTGl6NWtLQVFIa1V6?=
 =?utf-8?B?YTk3QXdDSjVCSXB1aGVZa1VGSmxMcmdIOVp1NDlGNFZyOE5CKzY5YWppL1hI?=
 =?utf-8?B?OWd6WDBldnBZTC9xbTZxNG1HR0dmWEZMUWtHVW1xdy9lb2R6bXBzY0IxYmQy?=
 =?utf-8?B?VXlmb0RPSi9pNUdoS2dmVTcySmdYVGJKUVJyUC9xM0U5ajV0elJ6aEVOU2Vr?=
 =?utf-8?B?bkRGYkpTc0VyeE44N09wWElLcjRBZ1d1bkNnUjBjRTBRVWdYNXFSVWg3UEp1?=
 =?utf-8?B?b2JqM2JsbXY4blZhNzN3WGFsLzIveHZ0MDl3TjRRbXQwQll0Y0NSd2xnN1Zs?=
 =?utf-8?B?UjhtVExyb0lPK2hDZDQzbU5PYjVydUdzdUkzSWFOeURDaWYyR3hpT1lwUDl1?=
 =?utf-8?B?MlV0SCtCdWE1cXV1MEo0YmhFY3pJaFNibnQra3NlOCt0U1l5em1hemYwRVRi?=
 =?utf-8?B?eWF0bkVwOUs3QVIvRHpQKzZpQjFQbTYwRWs1M1Z0ZlJjdXhhMWl5OXc1Y0Mx?=
 =?utf-8?B?NDE1cTBmNmJBdXI3QmJwOU12L3pHV3hEbDNUOVNETFVTb21oTTNlMU5ieEVi?=
 =?utf-8?B?U3hFM0NxTmVLZ1Z6N1hCbEppblhjam5YUXcvVnpuUFgxWTJsUlN5S2lnYVNY?=
 =?utf-8?B?Vit5bk9oSDlZa3V0VkdBcDh6c1VuelpjYXUrb0hXaTRmRlpJT2p0ZmQzRXdr?=
 =?utf-8?B?enNZTWJJRjZYNkpob0UvQldQaW56WUMybzBsRHo1YXFqOUg2UzhlcUliYVBE?=
 =?utf-8?B?Vk43YWdBZTQ1NjlaYzFDbFcvcmdOaUdFZXZ4dlNuWTBXVVYrTE5GU3JZWDAy?=
 =?utf-8?B?anQveGJza3hDanNzeXFoNEpUbDZsZytSNlhQSFRuQU1NdElaelVqY1cvMndY?=
 =?utf-8?B?MDlIWUw3RHRDbmp4RDVBMUQzdWZmQUYzUnVKVExVUC9QRTdJUVdsZkNjQnha?=
 =?utf-8?B?R3hBeHNkaWFyWUlvTGpET0w3U0FUbC9SUjE4ZElXenIxRjY5Sy91b2w0dllY?=
 =?utf-8?B?UWU4b2dYcE5sdFl4OXBtaGlYMFB4MzBXemp5QnVVZFg2LzZQOFdyWElkeTYw?=
 =?utf-8?B?MVdrTkVOODA0bDNRejFKVVVlYXdNT25zNnJzL0JjWEtuaXNDWUdEVTkzOWZj?=
 =?utf-8?B?OGxyM2x1bTlnU3l3WHI0dTUvMmpoTFhzelZXcGwxYmVkb2dVallsaE9jRytF?=
 =?utf-8?B?c0dCUWpWdFBScUVOdE84MG8rMS9SL0NEM3dza3JqZkd5Zk1MYXhlYTBQK2Vm?=
 =?utf-8?B?UTIxQUI1LzlYeVEzcnR0Qm00c09GK0R5cDNzY3JNTmZjMEVQc1lsbzZBV21j?=
 =?utf-8?B?ZGlOYkM3d25ybWd6QzNaQmh5ekgxUWd1dnVkV3RPZ0JNNnpRWWlDTnhQeDFm?=
 =?utf-8?B?UW1WcGRaYkw0Z0pHVVp2SFEwalB6c1hrUkwrMFgxSkpPK1d5Q2x3Z3RBKzYx?=
 =?utf-8?B?L0cwV01GWkx5Zzh6eW1ubW9LTE1QK1dKWnV3TU8rc3hzSW9wdXAxN2Fadk1h?=
 =?utf-8?B?Y3cwNFRZVWo1RGFRaVNqY1BJSjFSaWkwd0Z6bmFyZUVDdVpmRXVnVUtFWVps?=
 =?utf-8?B?SnorZEdWRFdTZ0gxNGJZeUwwemFYblpRaUREbExLVXgzWjhvYjhNZ1BhWlI5?=
 =?utf-8?B?eDdOYi9tOVMzRTc2SmJDenY4dzlxeEJocDAveUtOV0U2Q0V0dVo5YWdUWU84?=
 =?utf-8?B?U2g1K3VVQzBxa3dpMFFvQ1p6MlU4ak5yWkJVVzdwNHRxcytQMjZpVC9QbnlD?=
 =?utf-8?B?SkxmdGN0TVQ0K0xBeXU5MHdHZEd3MzQxclBrTUdwZ1Y1K2JvbFV5VVRITUg3?=
 =?utf-8?B?ME03NW1OTTdKRG1YMUZzcGxDVnFRM09UZVlaWGZiYTVyVTVIRUZSZENlTEZE?=
 =?utf-8?B?S1VDVlpZOUdFRFJRMDNRc3pZbFdvTm45TUcxMzlJcU0zc1JiVkNkNHJjYVVX?=
 =?utf-8?Q?rBwf6tRzuGENdWj0yGoTvVL2DqFlLcvd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzBRRlNKZ3JaUkpWZ0dlaVB4RkprSG1JL1EvdDdjSDJyb2JmRjhKeFhuQUlE?=
 =?utf-8?B?U3BjdHNicWxwb01GN3RIem9Pa255WitvaTNRTTVzL1ZMYUhyS0FQSnp4Q2dO?=
 =?utf-8?B?V1VYZXVaNy94bnE1Q0NmWWFXTWkvQXBEaEFPL2MvczJYZFJSVE9zY3ZWUGQy?=
 =?utf-8?B?Z0FsTVJxVkpFQ2lIL2ppaDhMa0kzU29UOHB5cC84aFBHNW4remxrLzVOZVJN?=
 =?utf-8?B?bmNNUFA0YmN2VVFqNmNzZThFd0UxVjkvMXY1dG5YVTlYdWZKa1pzMjlaRFp1?=
 =?utf-8?B?L2hLdnkxSGhpbTk2SEFVL3R1d1JZMlpFVUVzNTBuVzZDcW56L3d3SmlKcWN2?=
 =?utf-8?B?TU1PNFBsR29BOXRlRHFQeTJUcmkwZmx5Q0xxb0tnbUt4Q2FiTUpIT2lVM3ZT?=
 =?utf-8?B?Wjl5NDhRc21iWWU0VDhSQXhmQVNtMXhnWjZSZ0hUMENGSXplRGYyZWpsaTJS?=
 =?utf-8?B?UUFCQm8zV2lESW0rV043L0Q1bHZRUmVkWjBydGNDa3hVUXZKMlEwSnd2V2hJ?=
 =?utf-8?B?dU5vd0dWOTk1dEZmMHliZHBNd3NXeWppUE51UjgyR3M0YmhzUFRoYm5hMTRi?=
 =?utf-8?B?VWU3aGRZck1EYWJCdnZscHRGV2tZN1BCTDBvZGdLUm9CUFJ6T0ZzYWZhTWVV?=
 =?utf-8?B?Mi82a1VNcXV5WTI0TEV6YzdBdktKYjhHbTEycVd5Mi8zZnBnUE1Qc0lqemsv?=
 =?utf-8?B?aTNraW5BMTE0OXJCdEoydTcvcHJJd25rNnQrVHJZRXRpNWJvMnp2OGNRS3g0?=
 =?utf-8?B?UEwrNjJLNmtBUFMyQ0NZcFhHNTQrOXo3M1hDYkJwNGxxTEVNVHM4OGQ3RWhz?=
 =?utf-8?B?M1JKOWFic3plQ3RwQndXQW52T242WGtaT1RSTC9MQnkwMC9IVXJINUV3L2Fr?=
 =?utf-8?B?TXBOcW9lYkIyUUxtbGxrbmNVRzdDOVFNRjIwVVEwN2EwczQxaUwxQm5adGJX?=
 =?utf-8?B?RzB1V0x6K1FoUlJmRkZKc3U5RGZta0lnMkFZS2w4MzdQL2EvT1lyN0VoaVQ2?=
 =?utf-8?B?OEh4dVBuNmEvdjB1RG9DWWF1ZVQ1dFNWZG9SUWk2TnZPQUlXU0FmMGxSanRu?=
 =?utf-8?B?T2ZVSVVBN3RyU2V2eWkrbm5rMXQ3bEMwVDlDakZVRlkyWXlOOTRDaUFYa1Rr?=
 =?utf-8?B?YlBjOGcyREU4VVkzcnJyVXMram9BWUZzWTFxK3luZGRFQ2FpRHViQmxqaE1x?=
 =?utf-8?B?Rm1KcnVkOUFVaW5vRi9MT3VhclVHSEhQbjBPZnNWZDZNb2hxcDZCY3R4bkNM?=
 =?utf-8?B?aC93V1VBVW0vaCtnYWhHWkhlamVvOG1jSVJTMFRRaTB4WWpRNThnRVpPTHZs?=
 =?utf-8?B?L3lTZXpBcGFVZzZHM0k4V1NKeEkyY2tJbXpIb2gxQ2hzTmg5R1hTYk1MM2x2?=
 =?utf-8?B?N1RHMU1JdGdFbFpONlpPVSt5QzgyLzQ0aXlrNEZLUC9WbEo1M3ovcmJUUlVH?=
 =?utf-8?B?dE5HZWUwUEpNSTVNWFVzRWtBbHU1OVh2S1Zhd3FlTGkvMVZ4a1o0V3dxWXlO?=
 =?utf-8?B?TDhYNGhaMW8yNHhtVHpCYnZIa2NPMXRCalJZKzl0YW9KTXI1RHdNNmV3TUg4?=
 =?utf-8?B?Q09mZWpiTjdBQ0FPbTR4Q043RG9YeTRMdE5EYzdDMWkzVWJLV2l5Ym5FZmhv?=
 =?utf-8?B?d3M3VXhxbVo0TXdzRXYrSDQyZ1d5WWRRYWZ1WlBTaGhQbzhvLy9LK1ZXTy9n?=
 =?utf-8?B?SG9qWnNyQlNJdkdKUnpjRmpabThvSUprcFFjSlp2YkpGSStldDFyRHV1VE5q?=
 =?utf-8?B?dVF6ZHJ0dHFFM1NGM2ttUDlwb1pVci9PMmZ0bysrbDJvSFJlRGJ4MGdvQXh2?=
 =?utf-8?B?TThvYzBobERFems4M2thZWlxUGdPc3NGVXNBSUNzSU9OQ2hUZklOMmpMWjFp?=
 =?utf-8?B?MzJZUW5JWk8yNVNZb21pZWd0QWQ1eXIvR1loYWVrV3RrUVlPODRyR3F0aW5i?=
 =?utf-8?B?QjZtRVlmOTNNZlo5cXJBNnlWcnlmTlBGRlJHRFEyRXdqeU0zMmJNL2FpOFRr?=
 =?utf-8?B?K1BrZVgwVHNnVm9peGM5VTVvSEFoWm90Y1IxZy8zR0k5K29uRlVqazJBK3Q0?=
 =?utf-8?B?VEJJbWVuMWxvQ2hJWU1qeVcyS2t3YVdsb2VHTmtKMUgvRDdndDlnQUJHNVk0?=
 =?utf-8?B?SDZaTXZ0NDY1QkkreXJtOTRueUtwb2RxMXd1R0h4eFhPeTM2RFlxdGQ1Vmt5?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 732ad558-71c1-4a81-e744-08ddde91edb2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:00:50.0723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SksasEPFiUb21W9PKP432bBxQGqTqAztuGI14a4SPANSOUEtj2Y/QEFeVHfCXfkM07Qq0+tbLVA56frZEKnmiMYsYGzs6GHzxbOCor6/a9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10003
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

Hello Frieder, is there any comments on patches 3, 4, 11, 12, 13, 14,
15, 16, 17, 19, 20 ?

Mikhail

On 18.08.2025 13:11, Frieder Schrempf wrote:
> Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
>> Currently the best variant picked in the first one in the list provided
>> in the manufacturer driver. This worked well while all operations where
>> performed at the same speed, but with the introduction of DTR transfers
>> this no longer works correctly.
>>
>> Let's continue iterating over all the alternatives, even if we find a
>> match, keeping a reference over the theoretically fastest
>> operation. Only at the end we can tell which variant is the best.
>>
>> This logic happening only once at boot.
>>
>> The patch is based on linux commit
>> 666c299be696 (mtd: spinand: Enhance the logic when picking a variant)
>> created by Miquel Raynal <miquel.raynal@bootlin.com>
>>
>> The code was a bit restricted in the functionality since not all
>> required functionality is supported in the u-boot.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
