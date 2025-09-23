Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC509CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 11:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DBA833ED;
	Tue, 23 Sep 2025 13:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WoSIhLJ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6816833E9; Tue, 23 Sep 2025 13:12:10 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D1480050
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 13:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NH9tDjHndoN/OJC1cvM7TlNKv5HHCRSwcy0osgrwbtHGhzspRAp9gM0ad3M9D/5ZgGQ69l5zwrJKlaC/HgemuwUohWaQPotAtcaEaDLGHeQzWAaA8im890sClhfzniNZOPyhU3PG/VvEUzT/EqHV3RjksjRsrSEPcnm5btv2CuPIyCDpwR7iw8sy07sYOjjUNodkQ7Jncndi35vBJS+Tjg5PQW8LDlm8RDqcB3pwx1lRDX1eN7Qq7txODYxvV5Bqu1GKQlsE0PYNg69fCXzeEtN0ldHkSXc7WQliKRO6UyXyNAasovVIh8mHgfbPriEOWDalFAjH7yQZwa+RWO77hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygF9skBTd05ZQgyi7nMGC8Q5koC4Lmgflr3y/36impw=;
 b=hP+6kT+bCED6LrApr4ntwFpd7gqJ/tzuAlRLOSF8IwFD7HwRU58qKs3+G3nqmJYoHH+5Tu5tYEElIf9P0pHpo5b0GLVDzTaopHNqz4K2fY0LoIISWiPU8HD3TWPy1ryBvKvKmX13StQtnsc4OutErNW0OwDDRb1Jp6Lky84v77lIGyoZX1EbvdaNxx0eddo0Z8i5dcVFqTTlCkhV5eltrYYBDE0l8GIBQWFgBrkuwN4+yzpj99T/cBav348pu4s4RMUlOuwOu3BuflC4VJ5BbbiSxslBqCz8HV2LmWdmUMfrElmi4aina9MyUO7Bs9jt0JKWcquFfRz5/XKk2Bg8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygF9skBTd05ZQgyi7nMGC8Q5koC4Lmgflr3y/36impw=;
 b=WoSIhLJ7rCrxlDLUhLEZSMllrCA9x0yxAOtuk06pWi1bwKg7HXi7aGql9Zj1ADahM/HzZbwNun1wxFBEqaqUSt/qnP24z6WtfqrgbR6+P9lTJw/61H1R1lNlBxfIdIQaZdlwDQAeS/HJz7me/o+JmuHmPqwxhnYE3gsFGKrL3gGVZr462ZjXdyjlp6m6+Kf6/QVUfO4hoz/r+yGZfAaxv0pFNobs8zStfla0SiZc+hCETfMyC7CQufmWR2A2k7z/bkMcDI/oGHXXcSqArgdLNnOEtoN6vN2Q6LExkj2AKUrq7hmpwfAhShlhi1nAl+nkW5rhDdswPSUb7El8CxkjNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 11:12:05 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 11:12:05 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH 00/10] Enable USB and ENETC on i.MX943 EVK
Date: Tue, 23 Sep 2025 19:11:44 +0800
Message-Id: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHCA0mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNj3dLipLzUkmRdMyMDS9MkEwvzVMtEJaDqgqLUtMwKsEnRsbW1ANu
 1fq5ZAAAA
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d18f7b7-056a-4f7e-a437-08ddfa92073c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2hXWjlERGpqUEI0em05b1REQmZQdmpnWEpXMmNyRVVwODZQbzRnQy80bDV1?=
 =?utf-8?B?ajdkYXQ4b0NTckdSZnZWRkRpSlJxRW9VUjhIVFMwR3JIbEZLWFovRVZ5dVpV?=
 =?utf-8?B?MEJCWlo1SVVMTjNRWFVLcDIzR2MwUDdJdk5yNGo1aEpOTXZQd05uWmJlYkxW?=
 =?utf-8?B?cnlWU2JuMzhqS3lGcWkzVlFoeFVCN0ZVU0hab3BFdjQrcVBoWk1CWk5hMDlX?=
 =?utf-8?B?clE5RHY1RTRwYzJUOEdZczh6NnpCcGxSRWsvWkRDYm5ZL3QxRGRXNnJZNUd6?=
 =?utf-8?B?SGhJZTFBbS9HeVBtRjJhYUs3S0NCMlJUQ3RSL2QrRGdBbjVvamdBRWplbnRM?=
 =?utf-8?B?Y2J4R3BOSVJOaWNVOWRrL3VUOExoVVgwNXV0Ull0YnNHViszOWhsYytWZHdr?=
 =?utf-8?B?eGZ3aFBrcFRjSGIyN3ptYVNpUVo1Z0svY3dzc3l4SUhsS2FGelVNWEFnWEFv?=
 =?utf-8?B?SE41NGwvRTJnMlU0SDFOUWpyRDlVM0JjbUdJRG5EWXk1NVJUWnA0bG8zQmps?=
 =?utf-8?B?ZlJSUFh2Sm1LZE9KK1YxOGV5blZEdkpVZXYrUWN5dENteGJDakVwUGduQTIv?=
 =?utf-8?B?TEY3S2d6d3Y5aTkzbERjd0h6YSsyK01yZ0dBUGVtNUlHYytXZ1R2NlRXR3NI?=
 =?utf-8?B?MERzWTZGY25RTFR4dkVkVW1TMCtUcFFYTVdNbHZjVFFoVG0yR1RoRkgvbjVE?=
 =?utf-8?B?ZlEyVUlaS2F4aTJrVjNOTlc0WGkrcnpISmUwbzFvWHk2aDNoNHc3OG5laXlN?=
 =?utf-8?B?a1V3UHBucnZnYlJrTGVtWHo0VCtYSDRDS3ZqRzVzSDFzeFVUTFVoYzZTVG12?=
 =?utf-8?B?KzQ0dVVWQWZyODVLSkc0c0w0aXo5RXRFRldtM1J4Q0N5WlFUTy91eWdqL20w?=
 =?utf-8?B?MTdFVFFScmQwZ2d1dmMxSTNpQmRvdCtqUTVNK1VjZ09aVXU0RktmMTVZa1hO?=
 =?utf-8?B?WlYrU1RGeWpuNjhMY1RtQ3ozcmRGaE10Z2JYV0o5eXQ0ZXR4SW4xZ056dFp0?=
 =?utf-8?B?SStTN0FreDNUaEdyNzVIZ3lOY2JaS2d4ekVwVmpUZ1VYcm9IMWxxZDlua1l4?=
 =?utf-8?B?bjJMaVd0WUtMMjVhb0RIU3hXMmFSK29xUHNJTER1TEthT245bzgwSFZKMEVG?=
 =?utf-8?B?aTFVaHJRK295STc2SzJ3T0c3NHZjbThXek9wVzZkTWR6NmIyZVlSRmxWcWFS?=
 =?utf-8?B?VlBXV1YrVmhkN1JkRGwzS2x4Q3Vwd1ZDUG9DM01Sc0ZVUFNtQzhzcTd1V21v?=
 =?utf-8?B?Mi9nSEN3VlFoV2pwM1NOc20wWmlaaFRkWnNLOFkzaVJWRXk2aENrV1ZiSDdY?=
 =?utf-8?B?T0JWQkwxUmJwaEZwellWU1JZbGhrc2xya2JNYVV6MDlKb2hHS1JVdklWUGhW?=
 =?utf-8?B?Q3VFYnAwSHFOTGlIRzNXRHNRSzJRTG9zdlU4a1VTeWFSemZ0TTh5QXBjcExU?=
 =?utf-8?B?UFRFSTVHWW1nSWh5KzRSWG1Scko3T1ladHJUTzlRQ09JTk5BS1JrUzR1bklt?=
 =?utf-8?B?Y3lIUmtPSElPZFBsM2VDbExIMWp3MmFXNjRkTTNWMnFQMkFkSlJMejNNUGdn?=
 =?utf-8?B?SGR2bDFCdFpSSGpyaXczN29nTm5iUTNCaFhBRlE5OXZpQy91OStEUktGdkZR?=
 =?utf-8?B?OFcxYUVRMmhjRFVKcHQ3VHJ4eS9EMmNSV2xERG9VTTk2Nlh6bTMxNXo1OUgw?=
 =?utf-8?B?TzVRWmJONWdvS1VHRk11ODUrMmhMVGpuYXUwR0lhcWUrRHJnNjFTc0FUQjIy?=
 =?utf-8?B?angzaityaVMvbGUveTd1d3grVlA2Mm5vZDdNQXB0djB6UFpmcGcxRkZVVWlJ?=
 =?utf-8?B?amM5V1k1azVVa3lMT0ttS2Z3M1p3MTlDdVBWWW9FejZ5TVEwTHhJeGNXdnpV?=
 =?utf-8?B?REZMWC9xYVU4MGZ6TTRWOHNKQ0ZQYUhnNHd6czZrQzdMQS9McDBlQU51N2po?=
 =?utf-8?B?UnBhaE9HbE96ZXhmNCtGT1IwQkEreUI4aWlLRmwwNzZrbUhIQ3J2NFVUMEpn?=
 =?utf-8?Q?LrRR72zmdt2/Du1bqv+fd2hN97maw0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXJDeHFzUEdLVkhSUGtpWnlqZytXUWpDZUN3Z3BqYjh1dlhMYVM3REdicEp5?=
 =?utf-8?B?ZUpybGtVRFJuNktveTRpS1RqY1MyVDFVSEdZV1ZnME5lZTNWUkhmaHVBaVhR?=
 =?utf-8?B?VDVuSVRiVjZ3NVFDcWNzcE5DN2NtQjNtT3JBSjdWQlFTd1NWZ1RRSm5CZkZ6?=
 =?utf-8?B?YVIwaTNHeUdBL2hUNmZzanlMbU9yQWhFN3FCTTBGdEt2ZjlQQlhOZ3g0cHRE?=
 =?utf-8?B?SG42aXM2ZVVhMkYwWmREVEVaaHZiSm1TMVJVWS9oQlVKUHdMOEZBemM4TUtq?=
 =?utf-8?B?WGZnUjltR3dwVVJ0SGFuMHNlUkNwQ2FWZkUwVFVrS0FtN3BvWlhNdkQ4TlNa?=
 =?utf-8?B?bGR0eE96bm9qYlpwdGc5OVVqRStPVVFlN01JRFM2bkZwOUdKNzNGbUxObnFj?=
 =?utf-8?B?dW80VTVOMkd4L3I1TEcwVzRxUDkxTm9oYUoyemdVMjQ0S1hPcFhwY3M2VG1q?=
 =?utf-8?B?ZVRJbU04ejlPSStUV3ZabE52bzlHM0FBTnJ1cERrMmt6dGYvV092ckMvRlZs?=
 =?utf-8?B?K1lQL0pCZVVnTXoxWHZDWTEyZENCandqUlFUUEpkMS9ZVVZVVWFiVlIyWVJ1?=
 =?utf-8?B?RnBDcm55Q2pQRWtBam5aUENNbXIzSHJXeHJyRkJ1K1ovVlUvY0U2Um56N2VK?=
 =?utf-8?B?WHl2Tmp6VXFhc1JIblFiaTFVSzFnM2txZEpSWFdLdzgwd2ZIODNraDBQQnQ0?=
 =?utf-8?B?VFJJblB4ak52T2FCMGNJMklXNmNKOGJmVXJUelVjajM5UDR5aWJXRzgvR2Jy?=
 =?utf-8?B?YlR1L1NsdTNqY25YSUt1NWNROUx2QTlaVnRvYmo1aHA1Z2JHeS9qMGdzRUNU?=
 =?utf-8?B?RHBVdHdRNCt1RGNoc1Brc0szWGNpeEhQWmhoSWtzM1pOM085T1RLSFU5WVYx?=
 =?utf-8?B?cHY3NmVhTWM3cGI4NlQwdzFsZTNiaEhLNElYMXJYdnNWcFVpYk9mTU5rMDJB?=
 =?utf-8?B?dUVTTGxUeERxTWJXamZwWG9hMEI4NlpVbWZkR00vL0ZBWkVwTDBNRzdrM0VY?=
 =?utf-8?B?d0NlSW51S0RqWk9ERG13U2l5MGNwcGlHYW5UdEVlY1NtUERMTWdlQlZWN2xo?=
 =?utf-8?B?M2FFZWkyaW1UdkJBbGZoY2JyUGExLzk1WGhlbWh5Q0VPTzBFVHV2bFZqSW5K?=
 =?utf-8?B?UFlSUEVVbjc4MGhTSW1qOW95Q0FXTk9SY2JGUUlpSHRmSnNsOGozbkVGNHNY?=
 =?utf-8?B?cldGc3Z5SEFGSGkvTGkyL01qRGdSVGVHTXhjRWEzbENwN1I2WXpJT1huUjBx?=
 =?utf-8?B?dDVwdHZXK1hKTlpDdUk5UFZROFRYakpJeTgyZ3hJc3RHSzU3V3Exb2hhOFYr?=
 =?utf-8?B?bVVKbExKZjNaQi84MVFzaTg1NG1uYVUrVE0vVmFYeTNraE5VbDJPVjIxd05m?=
 =?utf-8?B?L04xRnU2d2kvaUF4bnpOMEhzNlpkbDFFQ2J4SHdVYkV2akNHdTZZZW1KUlFh?=
 =?utf-8?B?Qjg1NVBmdVFkcExrVHpRejhCVmZYNGwzUllwNUE5NFhKNkxReTFCMHJldW40?=
 =?utf-8?B?dzlBTlNFNmtGV3dBZk5pY1pjcytDNEZ6WjVSclBaR0U4WllEUllNd3V6dXd1?=
 =?utf-8?B?S0NoV0UzbWtIUFhnK1RKVVkrRy92dkN4YmcyQmE5MTJWT2kxRWpJcGc0VnMw?=
 =?utf-8?B?Tm9EVzFNYkxrV3NVQ1pNbzFMMy9XSHFqbHhvL3hUSDBVcldyY2NhVDZQWTBS?=
 =?utf-8?B?TjFpTXMyN1dPWWo2NlVLU3JhR1BPbHcrMmszc1M5Rkl3YjN3d3ZpeTArS2kv?=
 =?utf-8?B?SmNNUkxPR0Z0MWx4YlBVVTlFUjRJdkNhZUF6OCs4TGFVbnRkS1JEQXVBS09a?=
 =?utf-8?B?U09wVHBucDN4dDVQcUx6MVNiU2dHdlpCRmp0QkRLNndUanowbStER294QlQ3?=
 =?utf-8?B?U0JHK1FpbjNLRU1VR1VEUm5MYVZLYWNFY2k1Vi9aWXJ0bDZMYmxXQ08zZjBG?=
 =?utf-8?B?QTBJSmJtQlE3MHdScnVUREcwZVBRS2RYZ0J1K3FsdFprUXh0LzJYV0xmejVy?=
 =?utf-8?B?clFhU0lSekovc3BpajlSTTQ4czdxYjFaWkdmYzNoOXlGVllnSDcxVHVRMjkx?=
 =?utf-8?B?T1gzYzFYdGFzb0ZoWHZqUWhWR0J3dFMyUjRwZGRoRVEzL3o0dGhhc3lKLzlJ?=
 =?utf-8?Q?oplJGCKCJQ1qt+wixGjGPhmNT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d18f7b7-056a-4f7e-a437-08ddfa92073c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:12:05.3054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9n7XlhlDn5w+7hHBlzg6A6a6/+trwtJWuffsZSEQ51LXb+w8A1UWdoZG35f0B7nqGBKyyGA/yz5PAgNeXP7JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7919
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

Changes for v1:
 - Adding USB2 and USB3 device tree nodes with required PHY and
   regulator support.
 - Enabling ENETC1 and ENETC2.
 - Updating Kconfig and DTSI files to support these interfaces.

This series depends on "imx: add i.MX94 support".

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (6):
      usb: ehci-mx6: Extend support to i.MX91, i.MX93, i.MX94, and i.MX95
      arm: arch-imx9: Add USB2.0 and USB3.0 base address definitions
      imx943_evk: Enable USB 2.0 controller host mode
      phy: imx8mq-usb: Add SPL support for i.MX8MQ, i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY
      imx943_evk: Add support for booting from USB SDP on USB3.0
      imx943_evk: Enable ENETC1 and ENETC2

Frank Li (1):
      Add serial# for SPL SDP download

Ye Li (3):
      usb: f_sdp: Update SDP driver to support PQC container
      net: fsl_enetc: Add i.MX94 support to NETC block control driver
      net: fsl_enetc_mdio: Add support for phy-supply property

 arch/arm/dts/imx943-evk-u-boot.dtsi       | 182 ++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi           | 234 +++++++++++++++++++++
 arch/arm/include/asm/arch-imx9/imx-regs.h |   5 +
 arch/arm/mach-imx/spl.c                   |  10 +
 configs/imx943_evk_defconfig              |  30 +++
 drivers/net/Kconfig                       |   5 +-
 drivers/net/fsl_enetc_mdio.c              |  25 +++
 drivers/net/fsl_enetc_netc_blk_ctrl.c     | 338 +++++++++++++++++++++++++++++-
 drivers/phy/Kconfig                       |  14 +-
 drivers/phy/Makefile                      |   2 +-
 drivers/usb/gadget/f_sdp.c                |   2 +-
 drivers/usb/host/Kconfig                  |   6 +-
 12 files changed, 835 insertions(+), 18 deletions(-)
---
base-commit: a82d2da84090eb64cf6f8270ec93380641f32867
change-id: 20250923-usbnetc-62095b487e9a

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

