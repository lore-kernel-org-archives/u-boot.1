Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27548CAC5AA
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 018C183445;
	Tue, 23 Sep 2025 04:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="of9r6qRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8255583448; Tue, 23 Sep 2025 04:15:20 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4352883211
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjUGPaFj9qAFrZM4All36J7KB8Dr34VbmbthEWfee4tWJ437asojd3dU6sJGdiTmodWrrrGzQXUObCenwkxmSjj876Y1CTRgAuCndUqFuUOgb1jBwXBOyB6l105Gjcsl/SrwtvfaVDkOaj+Qz/ZgAHRJ0nAvDA77r/24IKeeCS/jHBlSPhMNWUd+NxoSOsl013v0HjflfXpbWiRo7SmFclPSG2SX0yQGOv4lbq96CJ92ezgPaXeV+PCF39/xpr6ltSogKiRyWw0ZkD9w05HR0cqZ/MnnibwezA/7qPNWD8No1W4QsZ9ygdqhsQegpUPQbzpULV9g/HVL/hSlE0rXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMKavoSzTd0ArA/DiSZ2h7rv1Rs0ZCBcA1TusA1HmOo=;
 b=umhQeRSKeeFRaViPpejBJeT1gLhW55XIW/HZi4FibGhA4osTdTZPnMiw1hoSs00tFfd9nFO0l9Q9RVB1u6WOBr7jQjgsBesUyAru2O/eCzjcZpLc/T4SobN0Ix9p6vyku0enU+ufd/+YkKBa8fy3U0q/xaBA0/F+HTfkWymEI3YLfp4VXltl0yzNvYt6TIBhlxue2YL1jhlklYuCnhlrjtHTF55mneudh+iZTQg7P9dnpNX74BLeFJ71dqMYatwfHJnnkirp+BLBTEUaoQ9ZIXeTSdGCXjHvJG4MegckW/fcsiox6HRNHdOdOI5ZBmH7XUZbe7xNgM3xS3G0eLeesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMKavoSzTd0ArA/DiSZ2h7rv1Rs0ZCBcA1TusA1HmOo=;
 b=of9r6qRCECvtJnTzEeSPIFC2vB2f6sHvEozlglaHFpLEFbenbN2GnaVaTjV4QmdjnAVH4wQfYJ78oiDHMnvSITLwE3Jbrndt4NHgxE90h7zYvlFlk6jGHlQvR717o/OR/eJLVNrnWMlhFS1FVqheslcYRq4Oo4SbXAFZAWYQSxwjf5AJ8s9ssMqQqtUOfWwxswxgpdPZu24j0Mx2ZVdch1l0cQytjmkG7Yj3GUOByVpqPziGohUHOED2iJVKyJoSpLMFLAZkjC6RAhz5vblVnHsPa2L9NVIPDvlg4naYOrbm3zKopa4TU/L4SzHvjEtcYUscnPUw1B8ZNknHxL85uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 02:15:13 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 02:15:13 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH v3 00/12] imx: add i.MX94 support
Date: Tue, 23 Sep 2025 10:14:52 +0800
Message-Id: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwC0mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMj3czcCksTXQuDZKO0JAMLU2MjIyWg2oKi1LTMCrA50UplxkqxtbU
 AqfSyX1sAAAA=
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 900af178-77cb-4e0b-0364-08ddfa4707a4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzdoRHlaeWNvaUc0VkZteVpNRStaOTBDYUVua1N5Sys1QzdTM1lrYU9EdVJC?=
 =?utf-8?B?WkJrbzZzbVJ1VVQxVTRDZUxHMmNUQ1c5ck5oSW1WM3RCYkZiejVIZVdSajY4?=
 =?utf-8?B?dmYrN3NaL3ZSUEVqZEp1bkM3SVNmU1BNNHEwTUl1RW1aamN1c0M0SENhK1Vk?=
 =?utf-8?B?MURsbTAwMWpCZjlnZ3BpVkt3ZnE4bGl0S08wOCszUEh1d3VRUU1mT2p5ZjJr?=
 =?utf-8?B?d3JQNGZSdklNSStkdHdzU2xmTmlnYWh0L204RTN2cWZXdnFJeEtEZGRrWVBl?=
 =?utf-8?B?cEpuQnZtbVEzR29mZS8yK3FJbU9wMER3dENPZG11TzlFcjVlYWNJWk0vS0xw?=
 =?utf-8?B?RFR4VDhwcVFtQVpUKzg3eGgzZGZZa0VZd2YzSEUweFVxS3BiRUp2cThqN3lu?=
 =?utf-8?B?RTNOdU9sVVNuTUdXM3lCdFpZTGdSaFpRMG10ZGdpTGJWeW9sZEZJUHRVQnVw?=
 =?utf-8?B?K0JiTlJLQndNeGU4c0JyTzJlNGxPVXB5RU1IME44UFA4a3NYcW5idXBFMHlU?=
 =?utf-8?B?SzlmT0ErelRnYlRYUC9GMWRUTVZ2Q21taUFFR2IwTkI5RHFUQ2o1QSsrSUxh?=
 =?utf-8?B?RUNvZFBFV2dCanByQlU4RGVkSEt0OGxGd2dnU0VtNHA3OHZ5OGh5bEhXTzBr?=
 =?utf-8?B?YTh5eG1aNGZHY2lJSncyWVVCZUVNZUdxUzJKN2lQb0RHcDdUa2VKSEpzMGgw?=
 =?utf-8?B?bXhrNC83ZmdtNUtreVpyR1lVbkdvaWNkRUk0TjJkOTRwZElRVm44bDZqUklq?=
 =?utf-8?B?MENDME9XbFIvZEVhQnZWUWd3Sm90ZWxGRkkwQ256SjJNaUlIb1pQeFp3YjFs?=
 =?utf-8?B?ZWI0c0t3VmpYM3U3R0ZGZy9WbFcwdlFiK1ZrMHVFTGdacnorY3VMMlNubXV0?=
 =?utf-8?B?UWpUYUFBaFR1VE04OC9IVkpXTzdsaGtXZkhsUzJ6TW5qdTFSRVRpSy91aHBT?=
 =?utf-8?B?cHpmUnFzNGNvenllaWJRc21KQVNLZEdUa2pKMDliWWZNZHFOT0xPbDZ1Qm50?=
 =?utf-8?B?V2t3eE5mWVBzeTVOUlJnb2d1MkpOWHlXdisxYnpEakNoYjhpZGRUOXRodW9G?=
 =?utf-8?B?dzZtdTJtZy9yWTd1VXpzZllteWVLZWs5NjVlS21ERjcxWFlicGwzUDUyR3JQ?=
 =?utf-8?B?a3dVdFE4TGlmNko3YVJIMmdmVU1OOTd6dkF0UGdXS2liSTlhVFFoVFZvY0p2?=
 =?utf-8?B?cWkwMWtmWEE3UkdyaDJjcitHVW4veTVRc1hYWnloMURDTGVaNUxtcS9nOEtt?=
 =?utf-8?B?VXJraGJRQ2x1VVFNR0FaeUo4UHU0YSt4MmZtTHZiODREWmI5ZXZoM0N5K0pI?=
 =?utf-8?B?VUpSNlBIUUQwSmJpeTE5eDgrb2hTY1E2SFhEd0F6Q1dRZytwSXIwOGhqcC9S?=
 =?utf-8?B?MUFUNVdBRzhvRTdOdTgrKzZWQ2sxNFdic2NEQ2c1TWxxQUphQ2lIenQ2ZmJZ?=
 =?utf-8?B?MzNGWnNMY3BQMmdaSVlUQlpXMWIxZDQyd0llbHBjb2w3TDgxaWFUK3BmbWF1?=
 =?utf-8?B?Vm15dmFjZG03WEhCRlIwUk1xSzJlckJudjlFY3dyMmhaYUh1QUNlYllqM3ZV?=
 =?utf-8?B?YUtBU0dJWVM1MCtjNExDVkllZWxkNTJXNlpja1hldDJrbVY4OE1KTnNqZFUx?=
 =?utf-8?B?RjNhRThXSzYyV1F4NjczNWhjV3FzaUZoR3JKcHhnSWFqWUk5Y1hXdGpiOUV2?=
 =?utf-8?B?czRhejBFYzhHMFExYkY0U0JPVXU4RDJZR1JXT3VuMmZoc29laXZRSzAwY2Fz?=
 =?utf-8?B?a1JFVExkSmM3NDVLeVJjRFNZWWt3RlFWNm85eDRjcDVzVVQ0M2RLWk9PYzJm?=
 =?utf-8?B?MWwwamNneE1ieU16YXl4YmEzOXZ5QmdocmxkcnNrdWFEWFdwYUNnWEZYbDRQ?=
 =?utf-8?B?bllEcUQxWXhRT0NHTTArTWREczBIYTlpTTQ0OFZPd2dMZlUwdVd5ejk5MlRm?=
 =?utf-8?B?bWk0SithNk9ZWXo1OUJ4ejd4N3J5Z3BnMHA0dERuUVQrQ2tEeUJqbGFSMG91?=
 =?utf-8?Q?V5U7rh4bREGuDZLWQOUAu2CE8k/DM0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YURRTHVNb3llMm1IWGVxNUlKdkVITWl2cC9xYlc3UkhPTEU0OXYzMU5jMkhx?=
 =?utf-8?B?VUFPUHg4cklNcjQwWXFLTlI2aVgvdGpMYTR1Wk5VTFhBZlAyZk04RzdnaGlq?=
 =?utf-8?B?MFVSWlFYZkF5YTZScC9xOUFyMng2VWNLUG9td2VLMGZSQmpJeDJSSGZQdXlw?=
 =?utf-8?B?OW9vdmtQSXF0Sk1wT0NlNmlyQUVwdzM1bnAzSU9KQUpVcEZHYUhnZm43NjFx?=
 =?utf-8?B?dnRSVXozeTQ2SG52SDVULzZUUE5sSVpEdGpnMjRHUmo4eUV0enFaR2hXU210?=
 =?utf-8?B?RVlSNmE2UGc5bHZ5ZkpLRXIybFZaTEx1TmRDd0YrR0tXaUdxQUxLekZ2eHNH?=
 =?utf-8?B?czVPMjdlY1B5S0pmdjRObFc0SWQraWFZeTNXQXQrL1prS091K2VXaDRTZ1pu?=
 =?utf-8?B?QVkvdlVNVmdmS2NQNWVKSm1LcStnamxjVTlGb28yTmViNDJqUk5OWENLeDN2?=
 =?utf-8?B?T1VkbHdmczNxY29sVXhhTVdKNkUzODhPQ0dpOTlKRFpYZEV5ZllPRnFwMTlK?=
 =?utf-8?B?VWo5NlVpQThlZXRMM3cvdEQ0WVI1OXdCMC9BbnowVVFibXByakFxZnUrc3RD?=
 =?utf-8?B?Rjd2Q0l1ZW9Ta3oyZzJHQWU2OHFiTTRFSDdhaFlPTG5uV0pjRnpxRXlYWk1s?=
 =?utf-8?B?RmxUcjY2cEdsLzBoZ29TaDhUSjlwQnRtU0xQT0NSdW9FNUY5emFFTzFpNVFz?=
 =?utf-8?B?QzVHMUNjVW9VQlBXTkcyelRHV0Z2QXdpS210bCtKRVlUQlNjSkpNUXZwQmhN?=
 =?utf-8?B?L1BSQnJSQy83ZkdtdGVDbnRYUnRQOHlwVEt1N3RObjdpMGNuWEZ0VHRodXFI?=
 =?utf-8?B?RUF1TDlBRGpub0Q4MFAxN2oydmhDMkVkMWNia3lEZEI0RGhFeGhFR3FYYjh3?=
 =?utf-8?B?SjkvQW9rcVEySk1CN1Z4N0dvNnlORWYrQzZCS2tSZzY3aHA4ZTdRazlIemEz?=
 =?utf-8?B?aDJhM05STnBhRnEyWjB6ang1elFZWDk5VlEwNXMwVytnNG90QjRhcmVuek5p?=
 =?utf-8?B?a1NodnczTmxOMTNhSVlCL2V4RXFQVWhnOVNoU3pGdFMwQVI3dlBuNnFlaVcy?=
 =?utf-8?B?NVEycjhrNTI4QjdpSTlUWmdOZ1hhdWxQOCtZYWx1QUZIZzE4QzY1NnZoWGxw?=
 =?utf-8?B?RXpPbWNjSzhadGVieVJDZnhZOWorTzJuRHoyNTIySE5uRDdJTFIzdnNzRlpV?=
 =?utf-8?B?dGVNU2l4K2xtN1dPWGNodzcyYzJ3cHkyemZ6dmtwY3FQNmE2L1dKejM0Qy85?=
 =?utf-8?B?SnA4YytiS3FtMnBNYkdRaXp5VEVFazBNMU55SkZPazF3YlFUSUg4ZVowV1pJ?=
 =?utf-8?B?K2hZa2w3NGZJZkMvR1RDT21iRy9nNkNIcC9MRkV0MzVaU3VadDNieW8vT1lJ?=
 =?utf-8?B?dUZ6VnBFeGJFdVRCOVlHenloczNXQnprVHZaR3Nrck5kSndydVhqR3ZBakl5?=
 =?utf-8?B?Q3RITFZkZ3dRMWZaekMvdi9UamRmekxla1Iwd0dsTUp5YUJvR0VoOXUyZ2Qy?=
 =?utf-8?B?ZTdBdzIweXdZQUVlbkVoS0g4VU56QWhlV1orVEZZTVo3RUhCRThiRHNLV0pN?=
 =?utf-8?B?dVFQTkR1RkFwanNKS1JQejRaWVBLS2taQ083eG4zNjhhSUc1SS9pMkNPTjBw?=
 =?utf-8?B?a3R6R0pyYkhZcHZXc3owVEM4MVRhc05Zb25uYnVQclFLNG1NR1BCaG1sUFhw?=
 =?utf-8?B?SFF5ejlsNFUxVzFRRkZEcHFmTGpnL1VTS29SQ3FYZHN6UHlobnNYd1hJUXlq?=
 =?utf-8?B?VSt3dzJ4NTJ0ZFNxMDdaSFp4T1NBVXVDa0hBTW1mb2NncmlEamRoOVpQdHV1?=
 =?utf-8?B?K2crWHc2RGcrQ1B3L2ZUM2lPYm8xbXU4a2huTHpiTEJPcEZFNDNJV1EzMnQx?=
 =?utf-8?B?bmwrZG4zMmF5SWQzYzdNWCsrdjk4NThTUHZudkJPRkk4bzBqTkRSbTVGNngw?=
 =?utf-8?B?bXN2amY5ZzBJeXRXU0x4ekIvbVBoQlErNUN6dEFsN1VQMVZRQ1JGM2dNbzBG?=
 =?utf-8?B?c0FDQmZVdkV0b3JoZDIzNlJ2dGpJUkppckhNbzYxMTkxUU1sZkFzd1Rib2w2?=
 =?utf-8?B?cjRiT25tRWpUbXZvRXV5bEJvOThybDhEb2lZd2x1RnFhcEdUQlZwcVArTTBY?=
 =?utf-8?Q?vRAG7Ej/arrQ7IEdlRcrMxfPN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900af178-77cb-4e0b-0364-08ddfa4707a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:15:13.6670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IIPOXju/homvit7ToGkBVHxlVOAOHe89PYuM1FhFbGS9i5wTA43T/GwVMDBzxODAPtMcFDXEWUaaVIlZgI45Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469
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

Changes in v1:
 - Addition of i.MX94 CPU type and SoC-level Kconfig entry.
 - Printing of the LM/system last booted/shutdown reasons.
 - Definition of base addresses for WDG3, WDG4, GPIO6 and GPIO7.
 - Support for lifecycle state display.
 - Introduction of daisy register offset specific to i.MX94. 

Changes in v2:
 - Add support for i.MX94 in get_imx_type_str() to ensure correct CPU type reporting.
 - Adjust container header buffer address.
 - Introduce base DTS files for i.MX943 EVK.
 - Add board-level code and defconfig for i.MX943 EVK.

Changes in v3:
 - Add -I$(srctree)/... in the Makefile to specify the path to .h files
   from the Linux.
 - Delete initrd_high=0xffffffffffffffff in imx94_evk.env.

CI:
https://github.com/u-boot/u-boot/pull/815/checks

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      cpu: imx94: Add support for i.MX94 in get_imx_type_str()
      pinctrl: nxp: Add i.MX94 daisy register offset

Peng Fan (1):
      imx95: Add get_reset_reason() to retrieve the LM/system last booted/shutdown reasons

Ye Li (9):
      imx9: Add i.MX94 CPU type and SoC-level Kconfig
      imx9: scmi: Add i.MX94 support to get_reset_reason()
      imx9: scmi: Update the files under arch/arm/mach-imx/imx9/scmi/ to support i.MX94
      imx: container: Add i.MX94 support to get_imageset_end()
      imx9: Change container header temp buffer address
      imx: ele_ahab: Implement display_life_cycle() for i.MX95
      imx: ele_ahab: Add i.MX94 support to display_life_cycle()
      arm: dts: Add i.MX943 EVK board dtsi files
      imx94_evk: Add i.MX943 EVK board support

 arch/arm/dts/imx943-evk-u-boot.dtsi        |  62 +++++++++
 arch/arm/dts/imx943-u-boot.dtsi            | 212 +++++++++++++++++++++++++++++
 arch/arm/include/asm/arch-imx/cpu.h        |   2 +
 arch/arm/include/asm/arch-imx9/imx-regs.h  |  11 +-
 arch/arm/include/asm/arch-imx9/sys_proto.h |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h  |   1 +
 arch/arm/mach-imx/Makefile                 |   2 +-
 arch/arm/mach-imx/ele_ahab.c               |  55 +++++++-
 arch/arm/mach-imx/image-container.c        |   4 +-
 arch/arm/mach-imx/imx9/Kconfig             |  17 +++
 arch/arm/mach-imx/imx9/scmi/Makefile       |   3 +
 arch/arm/mach-imx/imx9/scmi/clock.c        |  29 ++--
 arch/arm/mach-imx/imx9/scmi/common.h       |  41 ++++++
 arch/arm/mach-imx/imx9/scmi/soc.c          | 189 +++++++++++++++++++++++--
 board/freescale/imx94_evk/Kconfig          |  12 ++
 board/freescale/imx94_evk/MAINTAINERS      |   6 +
 board/freescale/imx94_evk/Makefile         |  11 ++
 board/freescale/imx94_evk/imx94_evk.c      |  41 ++++++
 board/freescale/imx94_evk/imx94_evk.env    | 100 ++++++++++++++
 board/freescale/imx94_evk/spl.c            |  81 +++++++++++
 board/freescale/imx95_evk/spl.c            |   3 +
 configs/imx943_evk_defconfig               | 115 ++++++++++++++++
 doc/board/nxp/imx943_evk.rst               | 112 +++++++++++++++
 doc/board/nxp/index.rst                    |   1 +
 drivers/cpu/imx8_cpu.c                     |   2 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c     |   5 +-
 include/configs/imx94_evk.h                |  24 ++++
 include/scmi_nxp_protocols.h               |  55 ++++++++
 28 files changed, 1166 insertions(+), 31 deletions(-)
---
base-commit: e517418252ef11a82e0ce0c34f4d39b0c83067e1
change-id: 20250922-imx94-80c2fb085322

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

