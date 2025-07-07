Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437E1C83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD0F8307F;
	Tue, 15 Jul 2025 08:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sdXcIdlh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92D5B830B5; Tue, 15 Jul 2025 08:41:08 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 291108307F
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 08:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYlSx4CncEBtvQ+WdKO0gqQoDT9ltxhsriObgVkubRJPJO2hGQwZQuhVGrZ3HE6Oh/wPdKPdNhnUSjeJiAJbXzOjzJwN16oh7bDK4/VM/MxfDeaiYVzWD/FvgAmj03M5YTjIcjz8LL9gf6R6V5UmVrITYqX/9z+pZnLgEvd0FYDEVJy6VonwkYD1FM3y6ihvAx9UBd8f5tl+ncL/LDUWE88bKfK7LjJR10OeExPmX+/3GkkrSGft4rLYkW3mEQLPxEAf1zmY9dm0Z8skgkZ/9EHppxQchD83374NL4C9cIlA0gosOf31OZ9KeAaOxz1Bj0Uzl2P7+W9MRsKN0Zw0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WjlrSu0+aYRXY4SCppFd5Nn2zBU3Whl4YRGzsMHcjQ=;
 b=b17BBesHOfS4Pd3iINO5M0onOv6KmMprU5thwaCs9a4w9x+rxWARa18q+Tl+PuErG3uRmWnrbbPxJensSNxT28UgitqmbklAMm15/hex1ytVuJh/Wu8pvBrMgMUWZsbT8e2mFgRccHPEIRFv2/dw+nCiHY6mZWt8wC48m6Xa6FTv5OltQOR1uLLO6QoZZJQylXYX1D9xoVbpeMpoFuopK60TZrOOpxHqYheGeuEQN5PlWfitABLJV57YbZ5gwSsW4Oq5gus2xoGQkLQLINuOKxY7wrNXO2cAgBi2pCoHnC3VIzfPBuVwwboNwnNp8qy7vNcVmnX+lC1bikEQ3lPwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WjlrSu0+aYRXY4SCppFd5Nn2zBU3Whl4YRGzsMHcjQ=;
 b=sdXcIdlhlihKE0kG11c9q0VWBnfnkIeAsnM8Eb9vOEvz72RP3IjsivOevwPeTdA4mckZq8A/AeKCuY5se8AtdjQ44wpjLO1CYz8LW0c3M/f5As+81MT5ldA3/pWhKPkyTvg91X7Swe8M6QdniXZeQ6eNbM3st2UHG4+s4evyVtdXMmD/9HmWyWfks6L7PR7FHaopvK1lgz68x8uU4UnWit83zKJxJL7nft7lCskLivhc0kK4bydNMvshVxqYAPPTGpsoHzqSFTKVHX4zo//TncAoQpNXsbxxkJvwqeez/sThrbgAZTI1GteHohCkQjbp/XKtp/9NTS6T6Hz6lLRnAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8370.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 06:41:04 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 06:41:04 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 08 Jul 2025 04:42:56 +0800
Subject: [PATCH v2 4/4] imx95_evk: Add i.MX95 B0 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-imx95b0-v1-4-01759e9c855f@oss.nxp.com>
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
In-Reply-To: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MA0PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::13) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d72ecb-36cc-4b95-b221-08ddc36a9232
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ei8wZjBRNVppOFVKelFvdk1TN1RhWWd1RUxvN01pZU5FNUlYTHlPa2ZaaFdU?=
 =?utf-8?B?bTczcjRzSVN0NktRNSs5VW9kUnRKUXdlT216ZW9uOFlVNHlGck00K3pKN3p3?=
 =?utf-8?B?dU54WTBqb2FlRStGa3RaR3V2R010ZS9NSEJxMzJIUkF5aGMyZmVQdzlFdjh0?=
 =?utf-8?B?K08yRk1kNEdWU1N6NDRhdklSMlJZaDJBVmwyN2RkeTZaOWJRR0dudE9NZXBT?=
 =?utf-8?B?SXpydDdkVWxZZkVXeVBQMXVwcThHNUdxMmxaSGZWSGlMZzM4b1VnRnRIZVZF?=
 =?utf-8?B?dlFrejNURndtR3pJMXBibjc3UDJpRVVVejZETjJFWWhwSVo4c25vaGh2eVdF?=
 =?utf-8?B?bkY4emVESWp2a2U2OUtMeDZRQUF1UUlyRVZJcUNXem9VK1V0RmF6S2dqcUVp?=
 =?utf-8?B?TzRFeDcyZm8xV0lNOUM5aVh0bDYyNXpjZDRydFhPZHRGZy93cm55UVJ5TE82?=
 =?utf-8?B?c3UxeUZpVzA0L3dNeTE4b2hNK3RnTmlnYUh1Y01TZEhRSHlNenhRRHFZS3lC?=
 =?utf-8?B?NnpRRk5ROGgxM3dsS1pBa2hEUzlCWVBtU0Rzb0s4elhxQlBFTDdnT1hSenRX?=
 =?utf-8?B?K3JqeHVJdlc4MmdWeGUxRVZYK2dLVDhPNTA4cnlNOTNvRVJhM3pCK0FjbXRP?=
 =?utf-8?B?YXo4VFpkZnJEZzBPS3lNRWl4MkRnWGFwUUZUZXR4bmdjZUUrSEh4ZXRZcjVu?=
 =?utf-8?B?UDlTSk4venFqNzN1VlFNZGlBcnQvMzVKYVBRVGZTV1E0UkxBNXBQdGFoM2FO?=
 =?utf-8?B?eVFsTXQ5MktBRm02WUR0aVRiblRLNlpiWTJvRVppUTUxVzV2cmRqZlZTbmgr?=
 =?utf-8?B?b0liZjVuZ2ZDdGdzTGpvNVNleHhlcm5nOVZERWFpaU1zZ1I1UlFiRXo1UlB4?=
 =?utf-8?B?TzJGN2FlTHJQeFJoTFQvelArbkZBTWtPVEFZdUV4ZU5QLys4MFcrR3pWbTBT?=
 =?utf-8?B?MFhJMWQ1am00Uk8vZlJjUkZxY2JXQis0UmFudG1Qa2VlWE5QNDBCSXZxZm9m?=
 =?utf-8?B?RlFzVlF6anRCYjd3czJEV1ZnZkphdWVmSXZVckFWeEY1SDFBNExFc2JwMm1m?=
 =?utf-8?B?a1dsTEVWbms5WmI3cFIwTHV3RmZ2ZWJPRXROMWo0M2wxc2lkeTZPZTZEVE5s?=
 =?utf-8?B?R0xaNHJsZlBSVGFkNXdvT1ltMnF6Z2w2WmpqTkRlZkdvaWlQUW02WGgwMUh1?=
 =?utf-8?B?NWMycjRpZW1UZmcvNWtta3YvRjFUZ2Rqc2ZTT2Z4elNBSldVYmFzRHlyR0Y1?=
 =?utf-8?B?R1JyYWRVdVNkN0VjZWc0MFlEcEh6aWlkc0hqMGJXaFl0WWhKQ09uWXRFaTBv?=
 =?utf-8?B?ZkJaSHo2b3d6YklvTllsQ28vSVdkTDZwaU1oNzFxTGlFN1lvWDVOY0duTHVr?=
 =?utf-8?B?Z0ZSempnU3ZlalVkRHVWMUNqSXN6K1BOcTBDVWxuWFQyZ1NFRXZQOXJnZEl0?=
 =?utf-8?B?eXFDZzVSWmtvZlVxa21DNGJBUUg4dTVxRXN0ZUtaZm9MSU80TWVFajFOT1lF?=
 =?utf-8?B?aGh1T3FqNHc4TTE4NXhpcE1YVmtkOGhSQnk3MTdDaTEzTmVMUlk5K3JPOElj?=
 =?utf-8?B?UkxEQlIxdWZHb1lUQlZyMDdCQmN5VFd5YzE0eTlmRHVDc1ZuazlVdk95OGhS?=
 =?utf-8?B?QllWK0NqcFE1bUdZbGlidzVKSG1zcThaeU1KMS9RRkRkRUlhN2VLK1NNZm92?=
 =?utf-8?B?eWl3bHQzbGZDZXZwdGNvUng5OUxwRS91UXYrSUhMNTZha0JrUXpxcml4TUh0?=
 =?utf-8?B?SnMwOUVXTVAwTkpKMEZuUitGYlZJSUxaZHRodlJtbGlwT0FNa2dFazBtQzZB?=
 =?utf-8?B?eHltRXpHcjZnZVdvMG5weVVPM3d2aVg5Z0hkdUJaOUVOQ1BMR2RIVlppNXUr?=
 =?utf-8?B?UVBlY01WeFNpRmlUbmVzNmtkVHJpSi9JQXdLNEV0QTdPNWllMnVGSmI0aUJJ?=
 =?utf-8?B?UVZWTk84NS9EcnNUaHltU0RTZVZRY1FOMTJOTWltbjVrMVNYR3RnREFhZ2RR?=
 =?utf-8?Q?euYuOfIbTlS2kTdWwL7DmtH60gWtww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRBUmtEOEgwR2hLTmJKRW9PQTZ4YzJzbXNSK2F5ZnFJcTM1bUo3aVNDd1Ay?=
 =?utf-8?B?a0ZDS3M3cHBOTlFmVktHbkpYMWRwZW1Udk9oV0tQUncxWnVKNlp3am9jR1ZN?=
 =?utf-8?B?Y0Yzd25KMGFYb0xOckJRV3BLUjVoS3NTeUsyMUFpK1JOY3lSOFNnWDNjRHdq?=
 =?utf-8?B?Y2lEeGJHWVdKQzNXUVpnZlB3Vytud2tHYlFXTVNKcHlMTk5TSkphZkxUQVhw?=
 =?utf-8?B?L1haRExvWDQvS3ZiV0dTcnBoZXVaWlEveG14NWRtLysxSVRZc0pTbnJlOHJh?=
 =?utf-8?B?WXlTVUU1dC9pek1DVGQxMkVoMzFMdU1aRXUrOTkxOXZLR0JEb3hiNGZocG04?=
 =?utf-8?B?QWp3U2djaDRRNEdlUjRjeHVjRnlhdXNQZGxad0JBOEIvMjBUK2ViMzJuRVBs?=
 =?utf-8?B?RnkzMmlLMHluNklYOFgwYmJCYXRBeVpVcUordUM5bnhDUldMVE9DZU54M0Y2?=
 =?utf-8?B?dUgvN1ovU2FKME9VWTZoNjBIcnM0SktHdjlaSlV0NE9VVzkyUGlBWmhIVEhz?=
 =?utf-8?B?ZDU2ZUdvUXZ5c0p0ZjVwbXArQ2VUMWVXY0czcUlrS0pQNHR2Rmt1ZkliazR5?=
 =?utf-8?B?bE1zRU5rYVRFVDZsUGZnVFFjU2JvYit0VmRuL1o0dlBzcU1EZzQ3MHZ1NTk4?=
 =?utf-8?B?a0cxcklIZVA0WTU0NzVtQ0RTdkRqa0pYTmdXUE9kMmxBa1lXSThrVEprOVlQ?=
 =?utf-8?B?ZGZKNkpZOGVhanRrTU8xZkZnWTNmaXFqNHFBYmtaRHpGcXhjTE9Nd2pRVFNr?=
 =?utf-8?B?NzAyZ1BEVW1Gb1J4eWlkbzIwL3FaYWRxNUZQRWl1KytGWEVDWkUrT0kzM3Jr?=
 =?utf-8?B?WllyYklTL2RGOC9kN281cVdPN2E3emwzaDlnSnk4UUs1LzFRL29sTTNqK2RT?=
 =?utf-8?B?bFNmRmF4TFg5WHlKVmJaM01PTG9waWlkbGlHTE1nRTR0UjRrUW9jSFg2Sldi?=
 =?utf-8?B?L2NnZmNQZm1FS1l3eXpWSzJrVEQrYW1UOXRXTGl6cHhoUWFDMTN5UVV2NkhL?=
 =?utf-8?B?K1dpUmM2ZnUrTWQ4NTFHZklXSjBuLy93L2docVdrRldrWWkvL0hHUmdaVUNT?=
 =?utf-8?B?cnc4cngvZSt5dGhZaGlVY3JDd3Z5bFk2OHZrMG9pazJXV1VwN0dsMTJ2RjRZ?=
 =?utf-8?B?eE5YNDFOWTBSVW1OMHRQZUJ2T05reHBTWElENDJuL2puZFVFUWQxVzBXSjZk?=
 =?utf-8?B?VFBEQmtOcTFtVTU5QUlySXJwWWNCZk8rL1VMOXhWR2svLzNFbU4xUTRQUVJO?=
 =?utf-8?B?ZmhiMnRnQXh0UkFjK2pOR1d4Umkwd3lGbHRHdFBxdklMRFZ1VWozOVVPck03?=
 =?utf-8?B?RVVuMVF6YjFacm41SE1aL0oyZnhtOHJTQ1EyWmJjYU9YbnBzT2ZmMkFkck5u?=
 =?utf-8?B?U3RaQnNCdDFPb3ZDU3FBTy9kOGpQOXlWQ25IOTg1WHJHN2dHU1FZRmJMTkNL?=
 =?utf-8?B?cngxdkNYR2hadm9ud2c2M0N2OFVwZXp6YkVNM1RzSStyU1R4NzkxaHBqZ25P?=
 =?utf-8?B?dHp0R2ppRktEWFdQdU1GQXM1VzVxVVV5T1dMejdYYUNuSS94bnhZdHEwSndt?=
 =?utf-8?B?dDVMdnhnaHVJUDBzUmNORlR1VlFrNVltZzJIYnRSb2VnaU1VR2dhQ0RHd1dJ?=
 =?utf-8?B?NnVkSHFBRXFPR1pVU0I3WnRHakU2dDJROTFQN1hnQkoyMnlBcm15N3V6RWZH?=
 =?utf-8?B?eE5lK29pQkp6a0pGa28rVUFyT3hodzNUNWQzTFRaSmg1MGZVMGFFSVZISTJ2?=
 =?utf-8?B?MzdrY0JpUWNpblZ0NGt4ZDdKa0lOdVJaOGJBZzhGK3QrVXNtcHRlR2F0TUFq?=
 =?utf-8?B?R0krQVZiOUJjRnVrTGtVS3NEUGoyY0YvUU5tcjVUTVJMM1NZdnBiWDhvc3l5?=
 =?utf-8?B?cW5qZzRIM2oyTVRNVEo2aTdEZlZRNjBHRFEzZDVpTmRzakJiMmh4QkpTRjVX?=
 =?utf-8?B?VG1iMEdrcXdWZkxuTkVJbEtVSXFYejE2TGtYNWJRZHRwSFZscXJ0WFhMRWdD?=
 =?utf-8?B?a3MzRHhYZVdzakFWKytZVjl6L1hEdk1KN2lOZmRQdzJFZjBaR0RlUXpVaDNI?=
 =?utf-8?B?V1hubFJoanZOZWU3dml1ZXlnc2k4bFU2QlRGZHltNjJ3SHdrVjMybzZjQmtr?=
 =?utf-8?Q?1ttgb5jrv7RM9qK33EaXWaOat?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d72ecb-36cc-4b95-b221-08ddc36a9232
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:41:04.4879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8jb8JjcK79P30ncEplg6CZQipi0i1W9ctG4TvJn7Mb/csr3AAB8DIIi8yDftMgfKdGRkvR6+rRHg1bX3Ph7dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8370
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 B0 uses image container format v2 and needs DUMMY_DDR so that
update imximage.cfg and container.cfg for it.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx95-u-boot.dtsi            |  8 ++++----
 arch/arm/mach-imx/imx9/Kconfig            |  1 +
 arch/arm/mach-imx/imx9/scmi/container.cfg |  1 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  5 +++--
 doc/board/nxp/imx95_evk.rst               | 12 ++++++------
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 5ec3b1c51d6..9bf8f9834c9 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -22,12 +22,12 @@
 				type = "nxp-header-ddrfw";
 
 				imx-lpddr-imem {
-					filename = "lpddr5_imem_v202311.bin";
+					filename = "lpddr5_imem_v202409.bin";
 					type = "blob-ext";
 				};
 
 				imx-lpddr-dmem {
-					filename = "lpddr5_dmem_v202311.bin";
+					filename = "lpddr5_dmem_v202409.bin";
 					type = "blob-ext";
 				};
 			};
@@ -36,12 +36,12 @@
 				type = "nxp-header-ddrfw";
 
 				imx-lpddr-imem-qb {
-					filename = "lpddr5_imem_qb_v202311.bin";
+					filename = "lpddr5_imem_qb_v202409.bin";
 					type = "blob-ext";
 				};
 
 				imx-lpddr-dmem-qb {
-					filename = "lpddr5_dmem_qb_v202311.bin";
+					filename = "lpddr5_dmem_qb_v202409.bin";
 					type = "blob-ext";
 				};
 			};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 6af45938edb..95bd1823531 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -33,6 +33,7 @@ config IMX95
 	select DM_MAILBOX
 	select SCMI_FIRMWARE
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
+	select IMX_PQC_SUPPORT
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
index 441d9beedd1..b25f3b726c5 100644
--- a/arch/arm/mach-imx/imx9/scmi/container.cfg
+++ b/arch/arm/mach-imx/imx9/scmi/container.cfg
@@ -3,6 +3,7 @@
  * Copyright 2025 NXP
  */
 
+CNTR_VERSION 2
 BOOT_FROM SD
 SOC_TYPE IMX9
 CONTAINER
diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
index 6af1c4ba628..c2c92174c1c 100644
--- a/arch/arm/mach-imx/imx9/scmi/imximage.cfg
+++ b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
@@ -3,13 +3,14 @@
  * Copyright 2025 NXP
  */
 
+CNTR_VERSION 2
 BOOT_FROM SD
 SOC_TYPE IMX9
-APPEND mx95a0-ahab-container.img
+APPEND mx95b0-ahab-container.img
 CONTAINER
+DUMMY_DDR
 IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
 HOLD 0x10000
-IMAGE OEI oei-m33-tcm.bin 0x1ffc0000
 IMAGE M33 m33_image.bin 0x1ffc0000
 IMAGE A55 spl/u-boot-spl.bin 0x20480000
 DUMMY_V2X 0x8b000000
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
index 9121f7561ab..27cd15eb7c9 100644
--- a/doc/board/nxp/imx95_evk.rst
+++ b/doc/board/nxp/imx95_evk.rst
@@ -23,9 +23,9 @@ Note: srctree is U-Boot source directory
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3.0-17945fc.bin
-   $ sh firmware-ele-imx-1.3.0-17945fc.bin --auto-accept
-   $ cp firmware-ele-imx-1.3.0-17945fc/mx95a0-ahab-container.img $(srctree)
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.2-89161a8.bin
+   $ sh firmware-ele-imx-2.0.2-89161a8.bin --auto-accept
+   $ cp firmware-ele-imx-2.0.2-89161a8/mx95b0-ahab-container.img $(srctree)
 
 Get DDR PHY Firmware Images
 --------------------------------------
@@ -34,9 +34,9 @@ Note: srctree is U-Boot source directory
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.26-d4c33ab.bin
-   $ sh firmware-imx-8.26-d4c33ab.bin --auto-accept
-   $ cp firmware-imx-8.26-d4c33ab/firmware/ddr/synopsys/lpddr5*v202311.bin $(srctree)
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ sh firmware-imx-8.28-994fa14.bin --auto-accept
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr5*v202409.bin $(srctree)
 
 Get and Build OEI Images
 --------------------------------------

-- 
2.43.0

