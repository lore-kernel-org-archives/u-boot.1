Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B744CC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 516F282D3B;
	Wed, 18 Jun 2025 09:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VdZUej1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5754482BF6; Wed, 18 Jun 2025 09:30:34 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B61782CFD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbUXQa1YuaHLya6JyFoM3FwSC8wE31EZCjJk5PRdcIlybI6fHm1bb+1dC8ckRy3M6rIVy2jxrGLTn0MY8XmaLaodqNsF6MXrJBtzkOVwp9ZActmkLM9XCF0meJMEzfdMkXC1JGahD1MNWDHCAPcnJpQ9ImMDkcdeYQDU0sQtrEQ809wG35I7Xi7tSwnLZ05YP6iWXF0oP48M/O+6uZfTmAUfmF3BLjBLfNPS38PSFUxaarZqek2uy6MhsHGOzUSKEp4Yb7AFCELTAQh3cs9OnqAF7h1YsWuuNRDA7NoLCx/RZ2elTqO9jnod93wm745bYVFcsLJREHJtgUvILMmLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n84HywnvZsZcKyKotky/N4IG/bqfQ9dfMEhGdXvyoew=;
 b=hyeXg8LAMw32qy3ApI4bC53DVSMwYoxH0aM6gUkfIs70uAKyZz1hGqccjjwhsCNO1UQwEcdXdyRsMQX1Yi/Dipr8+o44QyZm8RccBnbNfOrrdjyGGtvKJGHG/2Yj0ORoqy9bzFMcZeDvJyrY6WtyIrfkMX3FinvibZHimYQ7PLQPWLDp0VUZPdSAvxDftp2tUPTssN8gNBNxPR654cTwLy8IOozVY5gkgR3x9BzQXOvO4e8oovefsCXHv8tm+jyeGKhl7XriERbYTTsXkjvLHbbMdXVJi70y2eSQ4IGdNChOe3HauvKQU/Vke6+ds7ruA1707+A8X5pmWMdPKf8c2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n84HywnvZsZcKyKotky/N4IG/bqfQ9dfMEhGdXvyoew=;
 b=VdZUej1EBa/9XvT9klA8HrQXXSQiM56b6lsKKhh+y/HPWMqmUkl8xFqfEqJ1G+aq7H25XTmMsqIYZevDHDi8pFw9L/6/dSpCnOjl9swWG+OE59Dl5bFRafqf7o9+3cpqd7/ouU1JZQyxgsH/TGTtypEYy4DQijoZ9NA+UngF8qJsIdqLC08heFcrwTsvn9PwIQ5p9PbtcVdOFKEu/pWAuPGmviwXUoCNJDyQ6c7TW6C0OzupL5GPC6dJTyt6NbwIE8kuwO+UmN5FN+42ICc31wu9n8RFqCNQDN/t1J3S6S0ooyuJgrj90MJzaxxlX5GKqMiqS09NxrtHuRst4Wg0zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9408.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 18 Jun
 2025 07:30:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 07:30:29 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 18 Jun 2025 15:30:16 +0800
Subject: [PATCH v1 3/8] imx: imx8qxp: update packing i.MX8QXP MEK flash.bin
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-binman-v1-3-373e66c7a51f@oss.nxp.com>
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
In-Reply-To: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS1PR04MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: b2414d8a-bac0-4e3b-3cf1-08ddae3a005e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ym1wZWY3aVlKUEpNTFBqSnRBNGphVHMxaStneGZDckkzTHV1TmRaR3pvN0JH?=
 =?utf-8?B?OVJodlhob0NxbllaUFBvSTRNR3R4bWllbWpCd2EwVGxlY1BnV3JqVDdMV1M3?=
 =?utf-8?B?bXRPYWh6aEZWeVZkbmZPSzBxNU9UckdjVExJd21odVJyL2s5aUV6OUVBOWdq?=
 =?utf-8?B?RkxBbDh5Q0lEQjkzcytYOFAwT25TNHQrTExIZVpqbHYrT1lsUnh3dGl4aHE1?=
 =?utf-8?B?WGErTk4wdzl6NkpRc3NlUlhKdElQMmNXU0F1bTNuUVU5dVdNUkNlMTFac0Qz?=
 =?utf-8?B?eko3WUhQNFFKVGt5K2JDRU9YRUkyZ2ZWY21yOGtyRzFZQkphZnRZak1yVTAv?=
 =?utf-8?B?Z21xb2lVc1dVY3JqcUNoQmYrdHVGVHlwRHlya1BqTVgzVFN5VjhaWkxYSmV5?=
 =?utf-8?B?a2xuOFBmWEZoWTBxcUFtaWdHUzFlUVh3czZmd3BtMGpuQTZBeUFObS9HSHlx?=
 =?utf-8?B?M1p5SERZVjliME90TnJhWW1jTk9uTlUxQzZacDZMRldZb0Fpcy9oSXcwZUxE?=
 =?utf-8?B?bURMQXBDMEFzY3JwNEY2TTN5N2NEc3o4KzJaZlBiekU5Rk9ZdC95ZlJMeFZH?=
 =?utf-8?B?NEFlS21BanJEQ1k0cHJsNWgxSjNzbWZKelcraXhiZzZNaFgwdllQVDdXU3N3?=
 =?utf-8?B?aVNtMWNmRDFaeStydVNkVFV4WWpSK2NLQkFVaUNLYXV2d1h1Nm5IMEU3SVNw?=
 =?utf-8?B?bSs1QlEzampWdlVuaWZFeGs0RlVqQ29ORGc4akFFTCtJYUlLcVF2eXRHZXlW?=
 =?utf-8?B?RlJxSE9TNlRrK2hqdCt3SG1vbEY5VDNwQi9WcEpia0RsSkt6YXVxQjN1d2RV?=
 =?utf-8?B?VEpVSFdCb0lpdXNQNDgxQndrTTZGMnllWTdOU0QrUnBEa1paS0JXRWR1NCtO?=
 =?utf-8?B?NVpzRjdHcVhjc0M2R1VVSTBVQnVDTzZPdVFIajBBaTlpcjRVMlYrSjZTcnNI?=
 =?utf-8?B?eklRbm01K0NVdEN2M1FVMUtZOFhITUJiL1J2VUsrTkRPeitlVzI4bElyT2d6?=
 =?utf-8?B?c3lIVS85TVhKUmEvQWl6Q2Q5ZzFRdzQ1djdqU3AwamhGai9SaWV3R2gyNVpq?=
 =?utf-8?B?UDF2aEFaQ1QxU0hEcXdVdTJSd1lqMTZ1cXk2S1JxY000RjFFVlNPSXdzVTA1?=
 =?utf-8?B?TUdvZlM5QWhSK0hweHF4MEFIS2JpbmxrM2dXRW14eEh1QTVVR2tTcHd4djVD?=
 =?utf-8?B?R2E5d2xTYUQ1MnVFdUNkMGtLVEwySUt3T0FXamRhcmlBTm42YjNZK0htc2Y5?=
 =?utf-8?B?azAyaDF2ek5LZzNJZm85N25aalRPSWpibnBXT0xVNFIxUkhTYmpmQTVZSEcr?=
 =?utf-8?B?amZ1bloxdEpjM3BzelJMKzZ1UWtublI2SER4OHZsc0Y5QWZsV0xDSHlyQkJt?=
 =?utf-8?B?Rk1MMEFicDZIZWdQdGhYekFzSmhwUTlzV1hUWlcvZ1RFL3lwQnRPeFFldmQv?=
 =?utf-8?B?bmY2bWxRSExpNDdCblBRU2FGUG1Cbi9CSzJETTZHcGRiOERrV1hsQ0dSNEZH?=
 =?utf-8?B?aXo4M1QvUW1zZFArV2lTN3N0SFBCS0JPQ0V3TWVVb2VMeFQyRS82OWpRenYw?=
 =?utf-8?B?UGEyMURiVEpNZHQ5RzE3alNZSFU5V3VOdzNDRFZpUzBoS1lvaUFDZlNFUWFF?=
 =?utf-8?B?TWlXUU5Fc2drRWEzdkJmTEpFU0ZCQTA4b3JXR0c1c1paVUQ0T29KU2g1WGZ6?=
 =?utf-8?B?dUNnY0RZckQ0a3h2ZFVyZ09rTFFTbC8yUzhPZnI3WG8zRWFxV05YN3dLNjln?=
 =?utf-8?B?VmFDcXNzakFLUm5KSWNBV3FCR2M3aXNZeXM1UGxIUXk4U28wK0dleE1oU1kw?=
 =?utf-8?B?SHFTZ28rMHlXTUdLYmVKL0lrM21vUUJOajE0alloVlo0YVV3cFNEd08yZ3pY?=
 =?utf-8?B?aDRZM1U1NVl5Sm80bXZoMHVzaFZpbUNnNDNpd1BXeXAraVlCY3FMbFRiM3I0?=
 =?utf-8?B?a1VzZzBqMmxpdWNhb1piMU5CMjFJUEUrTUE5aHp2dEx1M08rWDdRM1VoUnpF?=
 =?utf-8?B?Zzg3Wi9pN3hnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmtEYVhvNmhsa2hlRnJGK1pvSm1weGNYWjJ5YVJaK0Uxb1NLVlUxREhEMVRM?=
 =?utf-8?B?dm5uZnYwaE9OUVBPNUJiZFZZNXE2eFJQa1VqZ2hhOE5DYmZwbm91T3o5U0t3?=
 =?utf-8?B?WnI2MXcwUFRTZ0c2SU5pbE9yQjUvWkJ5RktYdFg5Y1oxWHFwRWFoa010cjF4?=
 =?utf-8?B?c2svZDRMa01KODltYWpUai95MVJkTGkvQkIwNDVZWW9MdWIvbzA0L1l0Wm1S?=
 =?utf-8?B?bjRxWjJxY0tRMlA2dmNEVG9IeGVCZXVlNG1BZzJ1WExZWjhaMEhYa2ozNWxB?=
 =?utf-8?B?enVvV05BdE9uaFpQckVudUExS2Z0d2o2QUdvbjc1RS9qNkRaS0ZHNGRrNEVT?=
 =?utf-8?B?OGt1aVRrbzNhQTR0VFhoOW02dG1XY29FTzdsWDhkaUlHZ2o1VERzYXk3SkZY?=
 =?utf-8?B?d29naTNxNndPZDRHcjdmVnhTU1NRbmhsa0hNUHREMmFiU1ZMR1M3WnRGSC8z?=
 =?utf-8?B?ZFBkQ0JrRk43aXhmN2RkbzJiSWdvRkVxNHBZUFpyZWVUOGlOTzczZU1vVEhX?=
 =?utf-8?B?bzFJUFBjTElRSG56OUx3M1g1bk42ZnZtNm95L3BxNmRqNjdCOFpaZ201ZkI1?=
 =?utf-8?B?K2NpMVRTdXAvSEZwQ0xtaTBBdEYwSFN2NFhLMUN2cG9nRVNIM0w1SDdCaDBE?=
 =?utf-8?B?dU0zTDBmOGdTeVFGcTB1R1FXRmFuTStCMFFKVitxbkFNRHhYdWMzSzJGZ3dM?=
 =?utf-8?B?dFBlWlQzYXo5UFplM2FDZkdMWW1aUDR0ODJ2NWVpSmJoRUtoMjd3OGphR0VE?=
 =?utf-8?B?K3VvcmtqdXRPQTFLWVVLYnFJN2FRWmQreHQ4RStqVUwwaW45c1FrQThZcWM1?=
 =?utf-8?B?cDY2dDdmWnVjVzJZcEhTZkxwdnZIY0dLQlFXVHV1dWFZSVZSQ3M4cWQrVHZ0?=
 =?utf-8?B?UWZHNFM2d2p6YnlsMGRBZzJRWDEydmNXVlJRbW9OclBHQ2FMMWgzNTFOSE1F?=
 =?utf-8?B?L3JmRWlsT1BacVFIS1pPTzlGSVhsVk9iM0NJdmM1TU5uOG9RREY4UW9KWnRa?=
 =?utf-8?B?aXhmaURHRXkyY0JNZlFicmI3bENrK0NJMVA3Z1d1QklGMjNHeXJnR1BSL3F2?=
 =?utf-8?B?RU9rQ1haRVRPd0hBK2xJMFgwMUdBRzQrSlNNVWFYZVRpR3RQOUdpUFBYR1Mr?=
 =?utf-8?B?VERCTm0xblBaR00zZnVlVnBaL2o2cXBETWRxNmZKV3RZYlBpTlNUUTQ1a0xU?=
 =?utf-8?B?Wm1OSEJyT3k3RFljM1BJV082aER2WktsV0hLOWlMNWFKTGRaekJrbXlxRjdu?=
 =?utf-8?B?TVk2cWJ2cEdCZElINm04RDAxTFdGR0ZQRm1ibGRMZkpzTExYOWpCbnh5a0Zy?=
 =?utf-8?B?ZXZkRXNPNk5jNGhSMm16TVQ3ZWduMVNlUi9qUVJ3cmpiQitEU05TU1R4c0pm?=
 =?utf-8?B?TE8rRytHVStkajVmUWQyZmxWS202NEpTWEtkOTZEdC8vck5QSnl1c0dXcURr?=
 =?utf-8?B?TTdJRGRMN2huQkRyZWU3Q2l4QzRML0g3Q0VsdklkYW1zSVU3NTNpWXlaUGM0?=
 =?utf-8?B?L3ZCOW95QWJGU1BQZWw4Vmk2QzJYL01reWsxQ2dHTG9yTmlWWi9VaXIyalpo?=
 =?utf-8?B?MnVDQ3ZzKzZSV21MZktRQjhzRGZQMzZtc1NYYkxPeHZtSTZsQ3kxcU50QTB1?=
 =?utf-8?B?TFp3enVSTDNQcUN5VlhBTCt4a1JKb2tpbXhPZmpBK3BqazB5NEhzL1E5TUYr?=
 =?utf-8?B?a1hpM0RRaFFrczBod1lIZlJ4TnF6SGRZemNqdU5BS1ZROVZOcFVyTklLcDRT?=
 =?utf-8?B?SS9ybFgyNXdxYUpoWEdnVTZYWlMxT2JrQ2NnUVhnMms2UGx4UWJQSDh5UWNV?=
 =?utf-8?B?UHErRXYrd2lUVXhTdzhWQXVoR3p2ZXVtbnY0UGltZXFpT2FLK2RTY0t2MXhH?=
 =?utf-8?B?TzlLSDcvYTZoS21NclFxN2paS29DWjl0TVNkS1RydzQ0dDRMOVpPWlZKUHk3?=
 =?utf-8?B?NEpLKzBJeUorRGl5ejUyWTNGNy9jY2dlR2RCTHdJaHZLNkVIWDkwSTBBT25H?=
 =?utf-8?B?bWRDQysrcm0ySk9icElqdEJENnI2Q1F6ekRQMDZYMEpuQWhLb0FUcTZpK2Fj?=
 =?utf-8?B?WHdxRkd4S0poQ0VzVVVGbGdqcW94NHhNLzc0T2ZzYVRCZFE2S28rb1l1SUx5?=
 =?utf-8?Q?Ex39vBJFnMYDS8Wr2F1RZsYZR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2414d8a-bac0-4e3b-3cf1-08ddae3a005e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:30:29.5386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0COw1zx3hcIS3h8n6dEPrYAmnnEh8oYUAvI9NJeryl/ZNBRPcI7IeowIGIqHuUxoqE53A6V/Dprgb1BW32Fnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9408
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

Using this patch, a bootable flash.bin can be generated. It contains
seco container image, scfw image, u-boot-spl.bin, atf and u-boot.bin.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx8qxp-u-boot.dtsi                | 40 ++++++-------------------
 board/freescale/imx8qxp_mek/imximage.cfg        |  1 +
 board/freescale/imx8qxp_mek/uboot-container.cfg |  2 +-
 configs/imx8qxp_mek_defconfig                   |  1 +
 4 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/arch/arm/dts/imx8qxp-u-boot.dtsi b/arch/arm/dts/imx8qxp-u-boot.dtsi
index 8058caae9ba..06b697cd732 100644
--- a/arch/arm/dts/imx8qxp-u-boot.dtsi
+++ b/arch/arm/dts/imx8qxp-u-boot.dtsi
@@ -10,32 +10,6 @@
 };
 
 &binman {
-#ifdef CONFIG_XPL_BUILD
-	u-boot-spl-ddr {
-		align = <4>;
-		align-size = <4>;
-		filename = "u-boot-spl-ddr.bin";
-		pad-byte = <0xff>;
-
-		u-boot-spl {
-			align-end = <4>;
-			filename = "u-boot-spl.bin";
-		};
-	};
-
-	spl {
-		filename = "spl.bin";
-
-		mkimage {
-			args = "-n spl/u-boot-spl.cfgout -T imx8image -e 0x100000";
-
-			blob {
-				filename = "u-boot-spl-ddr.bin";
-			};
-		};
-	};
-#endif
-
 	itb {
 		filename = "u-boot.itb";
 
@@ -120,16 +94,20 @@
 		};
 	};
 
-#ifdef CONFIG_XPL_BUILD
 	imx-boot {
 		filename = "flash.bin";
 		pad-byte = <0x00>;
 
 		spl {
-			filename = "spl.bin";
-			offset = <0x0>;
-			type = "blob-ext";
+			align = <0x400>;
+			align-size = <0x400>;
+			type = "mkimage";
+			args = "-n spl/u-boot-spl.cfgout -T imx8image";
+		};
+
+		u-boot {
+			type = "mkimage";
+			args = "-n u-boot-dtb.cfgout -T imx8image";
 		};
 	};
-#endif
 };
diff --git a/board/freescale/imx8qxp_mek/imximage.cfg b/board/freescale/imx8qxp_mek/imximage.cfg
index 88d6955a9ef..cc21a8c3491 100644
--- a/board/freescale/imx8qxp_mek/imximage.cfg
+++ b/board/freescale/imx8qxp_mek/imximage.cfg
@@ -8,6 +8,7 @@
 
 
 BOOT_FROM	sd
+DCD_SKIP true
 /* SoC type IMX8QX */
 SOC_TYPE IMX8QX
 /* Append seco container image */
diff --git a/board/freescale/imx8qxp_mek/uboot-container.cfg b/board/freescale/imx8qxp_mek/uboot-container.cfg
index b481c98f929..9e550a99e9e 100644
--- a/board/freescale/imx8qxp_mek/uboot-container.cfg
+++ b/board/freescale/imx8qxp_mek/uboot-container.cfg
@@ -9,4 +9,4 @@ BOOT_FROM SD 0x400
 SOC_TYPE IMX8QX
 CONTAINER
 IMAGE A35 bl31.bin	0x80000000
-IMAGE A35 u-boot.bin	CONFIG_TEXT_BASE
+IMAGE A35 u-boot.bin	0x80020000
diff --git a/configs/imx8qxp_mek_defconfig b/configs/imx8qxp_mek_defconfig
index fa36b7b77a1..1120bac752c 100644
--- a/configs/imx8qxp_mek_defconfig
+++ b/configs/imx8qxp_mek_defconfig
@@ -43,6 +43,7 @@ CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONFIG="board/freescale/imx8qxp_mek/imximage.cfg"
 CONFIG_IMX_CONTAINER_CFG="board/freescale/imx8qxp_mek/uboot-container.cfg"
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set

-- 
2.43.0

