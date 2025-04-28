Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA60C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0618682757;
	Mon, 28 Apr 2025 12:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X7WKzcRr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3348277D; Mon, 28 Apr 2025 12:38:55 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF56E8272A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bm1k4bwVr2ui9S+DePcbxHcDmw0OxWQcG2+Zz8G1uHzeQmMAvo0B9ooUUEHtrYH3DbZ22IejRka0DrJiRZwsTrb5f+YbtTOXuv+Q0t2So8C7C9AeEbbiVhnKgRAzb3iGKE+2i2o5Tb/hXrBXQgjc+mNdPOg9LAZpLX8LQwN6nutfCr8fCSyRx4ZryUU1i45VZTh7vwbA9Mq7y1pnjQ7+Amstdw3NfSpGtAmNymUnQDUor5yuWMP9KX7eBkuEGCNFLQeqqkQRhnG8RTfepwrIo5OuCWzTh3+xFoIt/sonqb7a42zBnaV6jNZ2U16089bsppcLqpRJE6Hgz4Q8lkG+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOa6C6cDueoCMh0NQmygPBAy7dCnDS1dDmRXy1Fp/mc=;
 b=LhHTM1ZUp9CSpvBjHZbeh01YHBpZ3/5/Irj0/NPOA3avXs2M/TlQrKZYvrpqFseNH5i+9g4aBWDiGcOEN+wbjgH2ZhGISyFvuqppLUbMO1oi0YD5vz5qnWPvDfvMwOwfSxM+kw9yd6UiDVqSVET64q6VZMJnT5jF1kROSMCoPbGMksWjTzUVlVpe/J+cSQKeZ4H9vc40NWW1qgyXduOLvcvusRt9NirWr9FiQ90jzp+RWhtlI93OjDOpWNtgxQVdGW3rKXjL6p+LwElaYd7T7aE6w64nkrgyOHoGL18IdyjTHQVwz+07SRpvrtkxRKa/6l0YT+G5d8bZiJ1CLlfTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOa6C6cDueoCMh0NQmygPBAy7dCnDS1dDmRXy1Fp/mc=;
 b=X7WKzcRrheoGqYLhzTXC6Pf9H7qukHAopZC3QKv+yrOApOpJn8nztFkqIgZwnVijVRRikl6pgH892NbBfEbz4B81ZNBW6aGCyExcBWMvIL1vJsS2ptzTZfDghtaaC0IlZ4etq7rBzwxGtYVau3cohU2BxgE7QJKEeh6wORfgAEiUooYbXr63sC70K83nlvYZ+sxpfb8jCHoxmloczRZnEww3nEN/pZeFTi+F0H0lssznjcXhTFeSHMjrSxugQo/526fwujaKpcTVdBMS/UGfCGTJgnmpwGxZx9kvuJzMZNkwQsBWNBa28ufkSSItLOMh7oxZl9cMznMzupS7tJ28fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:38:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:38:52 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:30 +0800
Subject: [PATCH v11 07/21] clk: scmi: add the command CLOCK_PARENT_SET
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-7-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marex@denx.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: c3980331-e95b-457f-85d9-08dd8640de3d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTBPN2NKZFRzVHpTNWpRTDQ0Z2NhdWZrTGxRS2RRR1p1c1ZhUmhuVlF3WkVE?=
 =?utf-8?B?UWhqYkN3OStpaC8zRytoemcyQmlqSTM3Y3dPbWhGM0FKZkVGemNFeHlobkho?=
 =?utf-8?B?S3prR3Fobk5qZVNtenpLWk9IKzVsdVY5RElMbW41ay9SMW5HVG9VV3NQUjlL?=
 =?utf-8?B?VmJyUE5ielNVd2R4YlZIZXQvOHRsaUN4VjdVRUgwa0h1V2xlNDBZcy8rVDdV?=
 =?utf-8?B?eTR6YzltdnAvTDV1WTM1MWhZSERpZnpoQ0FrdTMzNGxneHdVTU1LNVB0aGhD?=
 =?utf-8?B?QUVvZ1lHSGQzQktjejQrV3JhbEtNaWo1Tk50c1diS2JuRDRXczMxQlpEbU5a?=
 =?utf-8?B?SC91cloxS1VLZGdmd1lUZE9KZDVIZmpXcGZ1anRSWnpYV05vVk9FcnVpb2lm?=
 =?utf-8?B?N3J3a0U5Q2kyZUQ2ZVB0M2NaU0JrMGNsOUVHa1hia25UVDBNa29QdmpUKzdt?=
 =?utf-8?B?cjZka0hmajROWjh4S0NSem1BQ1Zxa0dIcnlRcGRsQStweWdaMEFDcHVSNFp6?=
 =?utf-8?B?T0pleWI1YkVicmliTjJkOGpWbUlCOXc3SFE2ZHVYRHVpYVNBUTZYNGFVSE9T?=
 =?utf-8?B?Q3k5L3ZXTU1HczRWSlJyRm1FUkZBRzVOQWtSUGptWUQ2L2Z4TEJmRzh6amFX?=
 =?utf-8?B?d1ZRcGE1K282QnhpWE1GUUdyelVmbkdrTk9DYXd2QldpWFczMk9mNDEyVnl0?=
 =?utf-8?B?TzdLbk1LcUd3MktWTXdRN2U4R0VHajlKdVVBMFJUQU9ZU3JzT2RCcmhVUHZh?=
 =?utf-8?B?V05ZVmovVm9KUG9WMy9UZlh6eTQvVGVVaGhxdXgrdWxVeUhWZ1ZjV2FzMkZr?=
 =?utf-8?B?TnorTXp3T3RTYmwxb3JkbWVaUTB2VmxxWEVtNDhBM084WElGbjh4SXRMdnNH?=
 =?utf-8?B?cnRjMGNkSWU1ekkyQ3FUYU1TcjhRMkJhUTNDenB3c0xZTzQ1c3VKYVVEWCtE?=
 =?utf-8?B?eVA1Z0x4Y2RHTG4rZ0lINnp5VXRxSE9PYmdvbnBOZFhpVWJiampyOUVmbisw?=
 =?utf-8?B?VVQxRjF5M3FicFlBMXhzQUs0eTU0WEZBekZzT0w5dnYxekF4R3k2VEFGVUFQ?=
 =?utf-8?B?cGJsbHArTi8yWjRWTWNDY1F6bXVWNUpKWjU4VDg4K3JLSXRlUTFKQm82VUwy?=
 =?utf-8?B?NVhETlhxa1dRak93YlB6V1lFbzBsb1JzUkc2THdlYjBmR0pFamYzOUd5eGZZ?=
 =?utf-8?B?S2p6cVJ3QXBCUGY4NnMveVorU1RQYzhsWmJ2MXBRb2tvOGVqQXVtdDdxem1m?=
 =?utf-8?B?WlZLUkJtN2Fza1FJd2MvSE4xT0tNd29sN0ZqelQ1Z2ZIWGNqcXpzVlZTcDVN?=
 =?utf-8?B?bDgwRlIrL1VEUVRpVGVTY2tPM2szS1d4TzZUck9kVVNpNW11K3JxY0Y1ekFL?=
 =?utf-8?B?M3ZscmtoY3l5Snp4Mm4rNm56cFdHUm9FRTN2OXZMaThTcCtuNjdvSHJHZGpM?=
 =?utf-8?B?Qmlia2RhQUZPdjZZVVk4ckg2VjcxcHZtSjJkZmk0ZkV2QjRBWktSWkRCNWVi?=
 =?utf-8?B?anR2TjRmWjd1K3lFeEZsWkp2MEdwTVprNC9FTVc3amxFSEFSMUc0K2ZzWlcx?=
 =?utf-8?B?ZlFFdU1lRko0VzBVb0FZVGo2N1BPeVV2aWlOUVcvd2RoYWJGMytzVlY2QnFh?=
 =?utf-8?B?TmtOSVlrQlVjZzhiOFhsazlLS2E2b3JKNlk1VXNmU2FKRmxzRGRtamdqbjEz?=
 =?utf-8?B?eThGKzRQRUVWN1ZLSVc0eEJ6ako5bFMxMnQweE5wVjYyUmVtY2E0TVg2aWNj?=
 =?utf-8?B?N3ZjaEY1Si9KNkNEdzcyL0Z2L291MStwVVRzcFFxZklPZllBN3REV2FaMjRs?=
 =?utf-8?B?RTVsOGx2akJERVlCaGxKNVZ1RWVCdDI1d3dxSzFUL002NTRqMWlYcDVpaGlK?=
 =?utf-8?B?RU5YaUtRbE9lQjNWM0c5aEM1YmdmZDNtQmpVR1p0ekszSDNFeGlXa2E1LzBv?=
 =?utf-8?B?WUdzblZITGw2YzlOQjJRVVdPTlh6T2VydlR2VXYrYjBMblNGV0hqWkk2eWls?=
 =?utf-8?B?eFY4RFU1bjlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3JIby83Wk1lSWN2aTg0eHBqTlhIYjhrenZnZ2lEZERwcDZFaHMxV0Y2YVc3?=
 =?utf-8?B?bHB4QTFpVk5lOTlkZmhhSjRXL09BY2syYW9lNW1KVldyUFFqMUlhT0dyMWlF?=
 =?utf-8?B?M0wrTzlHZjlxNkhKbzJ5ZmhLRm1XOXpuTWVmbmIrOVZpMkdtYUVWbHRwTGZK?=
 =?utf-8?B?UXpGdldaMzF5RG4zd2JCdUZnNjJ3OVJBajVyVDFDY25ReFMzNjVxS0lMVnk2?=
 =?utf-8?B?MVUvMVdNTXUrT1RQSjVJcnpIQ1A4aEliSEVsUzJCNEdyaktNRlRGcWQ4Mi9Y?=
 =?utf-8?B?aER4emI3N3VlMHE5VFR0eGN1UmVlZDdHbzM2eWdINlYxU2ZZUHJhYTUrVXV6?=
 =?utf-8?B?eVB0ejZTdnZ6dzhNWUxhYUxjWE9OTk5CNlA2REpJdTNJdWo0MlI5ZlRaSlN6?=
 =?utf-8?B?MVVMM28vTE5NcmhOd1JMVHJLN2pJMDdRNWZDQzVnTXhpQm13U1pQb2wwQUFP?=
 =?utf-8?B?dDRVdll5ZXZ0RHE3M21CZGFJMWRXdjk1WElyeUE1dmRIOGpSS0VQeU43QU9y?=
 =?utf-8?B?ekx3dFNuOUFFOU5PMVBSQzlGcVVIMGJYc1J5TUMvNGo3THR0Vi9ZUUdwOFN6?=
 =?utf-8?B?SXhobGoxSjMxSGJ3b0k2a3g2VzViYWdLYjIzbDR1VjV4RjF1dktKUU1LMzBs?=
 =?utf-8?B?cjMyNFM4cEVzVUJFL2o1VW5lNmlWNHRnTURkVUdMUnRYR3RVTll4SmMzT0x2?=
 =?utf-8?B?d1pWYUo3M0ZWcnRIVFBsVnREb1AxN2p1dFZNNXVaS2VNN1IvTkl5S3ZXY0hR?=
 =?utf-8?B?YzFBcW9XWUFoR3owdXlwMlV4bWNzNWlNdFhGV0JIc0ZjbUkwVW1LQVgzVG9s?=
 =?utf-8?B?RGRVVzY1KzBlaEkrTFpaQW96TmtlSWFvUUxwNVR0MU43L0xQZjZzRStJNnRp?=
 =?utf-8?B?RFozUndQeEFNMGhWMmQ3RGlvV0UzLzd0MUdPNjIyeVllbDRQeUcwbE1EQWdm?=
 =?utf-8?B?YXNIRlBDMTFNZVlUNDNPc3BQdno1N29yZTh2SGw0M25kdk43RmVlY1p5TjYy?=
 =?utf-8?B?V2k5ZWlWako1V0JBbTcvR0FwOHJGc2s5bWJzL2tNWlBHMmtTdC9CaFBpVXBt?=
 =?utf-8?B?M1R4ZEZuZmZmV3A1MDRQM2VxQnFTbjlPcEJ0RlJjUnFicERtV3dWdGZhU0J5?=
 =?utf-8?B?VkNQVHVXcm4xeFVkZFRHb0NEUGViOWEwY1FaZUtYWjkybzlqSmEwMjA4RXYr?=
 =?utf-8?B?eVZ3RzcvRGxtNmF0TkJxU3FhbWJoVE1taEp3QjZTS2JPNVFrMzZhMDdCbGY5?=
 =?utf-8?B?K00rT29uM1BvNjFubVpMWUx3TmY1dlZOdDRkdVRFM1hPVUpTdEJ3M1B6ejI3?=
 =?utf-8?B?SzZhSUt2T0pQdzJaNmdnZmhjb0ZTSmNSZk5iUUNaeVlkSHlsUzJpdmd3VjlM?=
 =?utf-8?B?ZkZEeDduakZTcFBrc1grb3pWRGJYNWNDWkE3eXo0cGUrKzd4QW5QTW9TSmU2?=
 =?utf-8?B?TytNZVk1NjY3SGhJKzlQdVJENXNDV2p2U1hiZnhHeGUyZUMwMmJnS0puVHMv?=
 =?utf-8?B?ZjdMSzJiQllrNG4zZmF3RGtaUEJKNWx1M2I1blMybEhDSlN5VkQxUXYwOXpw?=
 =?utf-8?B?VGYyRm02QTdvNlBSVTd4allCU1R1MXBrankwTDNqSU9Yc2lJY2tVYytoS1BV?=
 =?utf-8?B?L2tjeC92Rk9KL0VKUStaLzVNZUtTcisyWG5yOVhnOFl0VFhaSzg3ZllvMjEv?=
 =?utf-8?B?cXlCYkl2bFl1TWYyaXM2cXZWamNFaFRqbHNUVFVHZHdxa3pibGR1anZ6NDZJ?=
 =?utf-8?B?Q0JBS0JiZGI0RDJRS0JzRElNM3ZlNlh4SUQ5bHBpS3Z4bVdlZmVkZE1GcHhk?=
 =?utf-8?B?SVVjZmlXUHBtZmx4dGZ2NDkyWUdpYU9Lc2FhbnMxczl5Qmo3UlN3TDIzMjZn?=
 =?utf-8?B?cUVwc28rbWZZbnVwOGZDTDI5MStXM0xITmZPNzhtanN4SC9keEtjVTlmZ2ly?=
 =?utf-8?B?WkRGbU1sdmVzUWxLNWl4TkRGWmwzTGcrOTZ0V0s0U0I0VVdQbDRud0R4Vmdz?=
 =?utf-8?B?dEcvdWZRUUVoVHR3RXdvN1J4UnRBT3hCTXBXUHllaU5ibDhkRVZUMUI5USto?=
 =?utf-8?B?eERyRUVXaWxtRFl0TE1zY0p6MU5Fd2JCSHRDVzBoTFY1ZDd6bFlUL2tqdG1D?=
 =?utf-8?Q?WnH7DjuIdiMUrCyhXlivgtJxl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3980331-e95b-457f-85d9-08dd8640de3d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:38:52.2792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXKJgJ1/e0MkM8hbWEDeygRD8dzn8FbSZAiLCdLc+KEAZ6HbXqSHeDOZyeOW8PKZ5iUjgl0xOpyIb8Xo2O3Mog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
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

This patch adds the command CLOCK_PARENT_SET that can be used to set the
parent of a clock. ARM SCMI Version 3.2 supports to change the parent of
a clock device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 drivers/clk/clk_scmi.c   | 20 ++++++++++++++++++++
 include/scmi_protocols.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index b8d40cc9653..af5e8679003 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -179,11 +179,31 @@ static int scmi_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clk->id,
+		.parent_clk = parent->id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+
+	ret = devm_scmi_process_msg(clk->dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
 	.get_rate = scmi_clk_get_rate,
 	.set_rate = scmi_clk_set_rate,
+	.set_parent = scmi_clk_set_parent,
 };
 
 U_BOOT_DRIVER(scmi_clock) = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 34f272c448c..342a65ae7f4 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -737,6 +737,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
+	SCMI_CLOCK_PARENT_SET = 0xD,
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -839,6 +840,24 @@ struct scmi_clk_rate_set_out {
 	s32 status;
 };
 
+/**
+ * struct scmi_clk_parent_state_in - Message payload for CLOCK_PARENT_SET command
+ * @clock_id:		SCMI clock ID
+ * @parent_clk:		SCMI clock ID
+ */
+struct scmi_clk_parent_set_in {
+	u32 clock_id;
+	u32 parent_clk;
+};
+
+/**
+ * struct scmi_clk_parent_set_out - Response payload for CLOCK_PARENT_SET command
+ * @status:	SCMI command status
+ */
+struct scmi_clk_parent_set_out {
+	s32 status;
+};
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.43.0

