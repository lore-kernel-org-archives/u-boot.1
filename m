Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5994C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 14:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1992E8144A;
	Mon,  9 Jun 2025 16:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="4uUOOvRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0B5826AA; Mon,  9 Jun 2025 16:40:12 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B2C811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 16:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uci4/nz+cyIqjZlQOlmh9zy82AyCEJIicrxpjuj3tzuQuYX1fCUTQSnPbuIhjwh1gSK5sP3y0NlZzJoX63DGk+2XPrmKbuIffWNLyrdcqpb4vlLb9bcnXgDMdKQzPYHC9j7ErPbAVGhSphPxJk1D9vvoNzo3f37Zh4YtYg/yMT3Lru3h/wqwCGeZlQPBtZDGsJ5ZRcWvqMzN9HxA8wjNssRL1bWLJWjsUViPiSELAIYEEaKnkjkSGVSrvtTa1XP+wJffaowvi+LjIEb/NYixdnfYn1gYPfqrI8wz8VZcZkKW2jD4A0n+MZvki4G3iNpfVs7MSp2+mc7+hclaAs0P9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30vUPLKTio1b0bxsqDLEVDeR40xrc8AJTP/zFteS84M=;
 b=Jnu29+h23VkSvqViYlhcHtxD14sMm5+K4wg2lGcTQdU+K+HQOVqwYHRCas13k/qn902/U66dPkzuxQy+gyt1uGtToWI640mtb1jjvq9h7eniQnYCc1kks+zvWQQAjkuUYk5HP8F3WGWfOVmRktXKhFWkS4ImMkRuExLcJldC32mOG8/S1OWDD17d5iz3mi3cgBd+knseGhUT7pVb6HhiDSjx/MCsfIG3+fwx4eLDmnceoWaRgwghAt8/o7c3foPIk+7Esmiqd1cMCuJoj/9T2cfySDIEQaOMe9vdOOI3p6pl9raDqJQIx1Y9yXXo+nIvpwtJqFH/1y/HXaZle1JpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30vUPLKTio1b0bxsqDLEVDeR40xrc8AJTP/zFteS84M=;
 b=4uUOOvRULdfDHi4559aKpWCSdFPQTRziYHJ1eVzVxn2L4nKmQ8L9pr9P0Jzzf2eI09wiNOc6V3q/iRwUSw4PK6eYT4tx1+yxTxE3mxRh6aH6oy/SBE4nmr9vKgTDElG2Zr+8M2hd7tSyFvmEqN0NDR0pfC7oLXVqaTj7ejS3AuhLYyVT+yw4AR4Pt/5CTIj0X4b5zpml6e0A+ZzUQqZAi5v6ylHPSjOYD1qhWIF540a+ytrHTlD+m8syrtKMa+PjGH0lgjy6yWp6+l9fn+rryTorraMBy6zfjy8ZDtrRzlYDiAj+uQEvrQCozSIeuy4GRFmteb2zP7UPtqDJfRbfug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU2PR08MB10130.eurprd08.prod.outlook.com (2603:10a6:10:493::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Mon, 9 Jun
 2025 14:40:06 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Mon, 9 Jun 2025
 14:40:06 +0000
Message-ID: <1a59a72e-d106-451d-b969-f65392b63358@iopsys.eu>
Date: Mon, 9 Jun 2025 17:40:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] common/spl: handle properly images with bad
 checksum
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards
 <cfsworks@gmail.com>, u-boot@lists.denx.de
References: <20250606205410.GC1382132@bill-the-cat>
 <20250606223109.502055-1-mikhail.kshevetskiy@iopsys.eu>
 <20250606223109.502055-3-mikhail.kshevetskiy@iopsys.eu>
 <82a14d8e-c444-45b1-aa99-ec6ef0fb064b@kwiboo.se>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <82a14d8e-c444-45b1-aa99-ec6ef0fb064b@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF000045CB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::445) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU2PR08MB10130:EE_
X-MS-Office365-Filtering-Correlation-Id: 4599dcb7-eb59-420b-8aa5-08dda76386a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXRRTzY0MlA1anBxR3dkUXoyeVRvczNZN3hsTHRRejJBcnVDc3h1Vy83OWIr?=
 =?utf-8?B?Z1VKd3c2TmVSbERLaUNaS1NBTW9BaURzcE9sQ1o0NGNBdUhkTVVLOXF4U3J3?=
 =?utf-8?B?ZXczN2VTcDdBc0ZwMG80OVZPaEl2bXorL2RIUVNZeFRZRDFqSnc2MmtDRzBs?=
 =?utf-8?B?aHZOU1Z1MlcwcWUxRnlRSGttZUliUnlZRXJPQW4yZldaKzZKclhpSWNadTIv?=
 =?utf-8?B?dkQzV0NSZktLWS9KZXhsaDhEYktxMVczMTV5S045RHkvTXp6SUdMTHdlVmxw?=
 =?utf-8?B?NVIvZkNtRDdhNG1SMWtSbGZIOHJEdlFzUzJOYVF0cjNtNDF2cGx1Qk4yNm9m?=
 =?utf-8?B?SE8yRmF3NS9QT3JtTW5XeEZ2dldLSGNncEduU0cvSUlVREFmQm0yYkRRcXJP?=
 =?utf-8?B?WmthT1QrYlVZSnNmcHIwTytDNU9hM0twaHg4SUo1TkpVc3ViUkVmaGk1U3Y2?=
 =?utf-8?B?bHlPRGk4T3R3MERYWTZhRzY4U0RIUVFQQVdzdTB5ekhybHQwbFAvM2trNTBS?=
 =?utf-8?B?UWtLSjg0V3NQaFpQaXY1c1VHQnBVYnZzYmJxN3EyUDdpYXloR1A2WWhJRlBz?=
 =?utf-8?B?WldZWkFTczhBM0xJaDAza1RXeWNrSm5md3V4NFJka0pZS1JJL3hHei9NNmNv?=
 =?utf-8?B?b1ZkME9mcVNnazgwUXduQ0ZhZnBaV0lqMjlwZXRLeitScGtGNG1rVWtHWm5E?=
 =?utf-8?B?b0lNRjZWdlZxRzdhakdZVmFsVmtWUTNpNXpYOG93TEtmbXlmUnB2WjRNOW42?=
 =?utf-8?B?c0phMUhrdWc3UGNJM3p2L3FEYjEwNTQxb2pacEp3MEJ1WkFteGJ5NEdOV0d4?=
 =?utf-8?B?T0pBcEhaRHJReEVSOGEyL3c5YUZEeGdwdSswYnBtZit2N1J0eTBKVWthSzZT?=
 =?utf-8?B?NmVtTVROSmZreEdPZytNVWY0YUF0QjJoYWRBTExrOTg1bEZNVXREdmpZUVNM?=
 =?utf-8?B?RUZQak9Kdy9IMFNKNWJaYm9HeVd6dW9BSmxjSHRvam5odmhaRGNhOGN2amRG?=
 =?utf-8?B?UWp2SWhwMlZsNWZ6ZFc1U095U3ZJaGhXUk40SE5kS2RaWGZ1Z0grWFJYL3Ra?=
 =?utf-8?B?dmVEZEFvRDFKZWNES0k5N01ieDB4d3JGRVVrYmJjUUFzNnkwUENaQmdSVzYy?=
 =?utf-8?B?SXlpRUdsNVhFM0pHYXlRRElWcjczQ3lKWVp5SzZQZUtPSXMwU0dOQUtIRjd4?=
 =?utf-8?B?RHB4QkVxSjI3K0FoN2dpaCsvL3UvclpLSEtrSGN6YzdacXpWVEVrTVo4ZWFr?=
 =?utf-8?B?RkpDZ200SFpSNkZvSnpYVzg3WkdicE54Z2pYdEZ1a0xYR1hDQmwyVHpvUDM5?=
 =?utf-8?B?cVRBaWsrRnhQdE9GeW5sQk5IYUQyV3Nrc2JZTUpKUHNvZW9QR2YrSDhMNTlx?=
 =?utf-8?B?WHdWZ3pzdVNyaTIrSzBJVGRDVlFVSlRNOXNBcDJlRjRGNmFFTXNRZmhrZThX?=
 =?utf-8?B?N1FWLzZpbzcweHAwNm0xZWdTZ041NFloaUkzTHZMaUErVzRWYVU0QTNrcmlD?=
 =?utf-8?B?TXZ4b2Z5c1NUQzNWd3RKakVjTzYzblpDb0FxNTlReW1wQ3FaMnBFN01nWkUz?=
 =?utf-8?B?Mm0yOTN3MzNRNGhtK2tlZzJvVzNJZVR4QWhCYUcrTVVkN0xhVWoxdnJWNUg2?=
 =?utf-8?B?emU5THlvTVJkQVBhWWcvcFBlR0Q4aFpEc0xzSjBuUXVQSlRmNGMvRjhDRytk?=
 =?utf-8?B?bEx1Y2ltZmdrZ01ueStSZ1RiYlhqQk85OWJlRjdlUGdYWG1RTllzMFZGN0I3?=
 =?utf-8?B?K3dtcjloOWs4UHJPL2hldnZmblBGUDhmQTJTa0R5cVNrblc3TmR4c2tqVGMr?=
 =?utf-8?B?YTVzcDQ2MUREcEVLWjZGODBOemxOczVFc29uZ2RZdjlVaDhuSEhQOFBmNDYz?=
 =?utf-8?B?eXFTMkFVeEladVY1NWF3ZXhESTFPVTk4SjFDZHVZS3VZaVErMXpNcTZmQno2?=
 =?utf-8?Q?VJ4RjaqpVW4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWw4VVFIQWVCeGZVL0V5bjNPRTYvT1oxRVRMeEoybnRpT3FxYkV6TjNWTURF?=
 =?utf-8?B?V1Zvem8wRld5ZmRIN0FRNm9qTmsybkdjWHQ3QTNqdDhxV1U4TmRsY3FIZzRJ?=
 =?utf-8?B?b1BUMk9OMFZEVm1yVSs3ckM4aHc2MWE5aXhmR1I2Q0RFRHZDQUd4VkovRjVQ?=
 =?utf-8?B?WFJFYndRZ01ESUxrTkphWEdqZUZZM1JMN1hSWWdVam9sUDdkU1JJaS83cEts?=
 =?utf-8?B?RWJ4ZXhvQ1hnMEVpWVdGUjlJRDBhdWZuTUZxTVJOSzdRNHVYVXU2MzZpTWF4?=
 =?utf-8?B?anJQbGo0YmR0QThzRURTa3B5Vis4NDdhVHU1eHlPR1A4TE9SUDBjMHdEOUtD?=
 =?utf-8?B?aWZ6OVYzNzBhV0V6Z2grVEpXNWFrYzRMMzVGeEp4Y3d2ZkRsZkd0RVRUMGNR?=
 =?utf-8?B?ejRuWEdJSXdhajZSbHgwb1U3cDdxaThPSTNCeWU1N2YvUlhMbm1iWXRxTXpS?=
 =?utf-8?B?dXJsT21xUUJOcmRUbTFjM3FGeFB2MEZwZmg1ZTh0bmlHZ09NSUJwWk5NdklL?=
 =?utf-8?B?b2hDamYwZEZ2VmxodWNod3RjK21CVUdVamtXNzUzNmxrUW9TcG9CcUVacWJL?=
 =?utf-8?B?eXV2RG9ESUwwdzBTbmpyeS9oV2habUpvd3BFbi9xa3YzWGRLckM4SGYvSk9m?=
 =?utf-8?B?Y0hUejVGQ0FCUW1QdTByZ29nZ0ROMklCTnYyQ3VRRHdLSk0wV3gzcDA5US9H?=
 =?utf-8?B?OFA3a21JSWRjaU1hT21jOXQ2Y0hPS1BackQ4TGV0SVFRU2sxYlZKN1VnTFg1?=
 =?utf-8?B?TnExeFJuL3VGNG5kM1hFMk1EYWVncnExSTIzNjdrVXlQWi9tcFlPTXNGU0VS?=
 =?utf-8?B?YlBhTlhjUnZXQjdJanhXL0tOQ0lWUmFHL1ZDWEd2ckV0K2FQZ0dSQ1puL3dZ?=
 =?utf-8?B?V0l2U09xNkJjTTROWFczOXZFZ0t4c2Q0MjJRTXI4enFnMU1lVnUzVHpMdkN0?=
 =?utf-8?B?MG1scHR5RUw3QWZvdEJQdHZxdk9nbkNIN25KS1A3QnVGYisxd1BOM09ieU80?=
 =?utf-8?B?Z1p6M1d3TW5uU2JGaXhxMlNWbUV6TmVPdFVLTGdPRStOSnQ3dEYrYUhCMlh2?=
 =?utf-8?B?UGwvYitZUDlFSXptVTV3bTVWTXozVnVxZVR2Wm02M25IRUhNU015alRod2k5?=
 =?utf-8?B?dWV6MGRNdC9RUVBQU1Exb1pUTkFTTTBiVy9IWVVVS2ZtdW1KcDBibEZibkJY?=
 =?utf-8?B?QW85b3p4VEtmMkx0cE95a0gyTE1HQ3MvTU9XdlM4QmhsVVNrMnRpZXRRa2x1?=
 =?utf-8?B?endINFZvbFZFL0xxUUpkVnpjQjBXUEFUTzZEbGYzQWJFL3VxcWZXa3had0J4?=
 =?utf-8?B?K21yYm1Pbzhzd2dZYzY2SVFRQ3FoRzF5VzVDZVpUZGQ5eXRyWkRMSU9pb2ZJ?=
 =?utf-8?B?dTd0RU0wVzIwUU5pVUNNUjNTbmxRTHJSU1Z5dUYwTHFaZ2RiaVViSHpRK1BZ?=
 =?utf-8?B?M2lmK3I5UDFiWU01dVh4RGlKaVlodTdDQ3JUSWxxZElKSnJmM1Z2K2w4UllC?=
 =?utf-8?B?MVpZVFJYYWRiWGM2elgvRXV5WU5GbE82RHVZOVNIa1dHeVRWRCtEOENqVVFj?=
 =?utf-8?B?blIzdjZlamt4bzlmWUVHdDZ1NWNMQ1FjZWpTdkUxNG5MM2Q4eThldDFEQmtQ?=
 =?utf-8?B?WFBIMjFDZzZ3bDZmVlp5cXBiZmdKTVMzMXFTR1BlbElRQjNvK2dYdTVaVUMx?=
 =?utf-8?B?QjNXQWVJMlp6dEtET2FlSVNLenNOVFp5Tk1wUHFoOG9vdXBUOWxaaDRZSWly?=
 =?utf-8?B?WFpIcy9JaXlkMDJSWG5TRjhVWGdnVXB3cERrUHZhL2dlYjdaK3A5Ry93SlZF?=
 =?utf-8?B?YUFRN0hmRFc0c0pMTmw4Wk9vcHNYWW5IRDBabzVyUmRNSXhwMnUwNFlnVnNL?=
 =?utf-8?B?b1Y2WjY5U1oyb3BUWk9idnhKNGZvUE04b0VHS1lsWjVEZEFJVVFhNWNWZXl3?=
 =?utf-8?B?UjB0aDAreVZ4VEY3Uko2d01qNkUyY1gyR29wM1ZRRnU2WjcrTlkvY2lybXJm?=
 =?utf-8?B?dENwSzRacERFcnZ0bnRqNnJBL01ka0VnMnE3NGErVjgrZW5JNVlwak5rWFl1?=
 =?utf-8?B?RlBLbWxXRWNnNVFLTXVLeGM4b0YxWVVCYlN5dWM1QXRnbmE0WVRUbWx6dU85?=
 =?utf-8?B?Z3gwNisrR01KOTlzai90UkVGV0h6YzdSTUg0SnF0YnltanZLM0s5S1ZPamY5?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4599dcb7-eb59-420b-8aa5-08dda76386a0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:40:06.2892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXkPhjbYg2a1DGMF3IyKNoWaN7BO1XIKTPNOheJYVJgIC1zbHJdb++ZyLPQsWloQF7BqxtYTEu45Aa5pnpZMaVSif1OXpqAiw9kW/9wInKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10130
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

Simon Glass,  what do you think? What is the best solution from your
point of view?

Mikhail Kshevetskiy

On 07.06.2025 11:00, Jonas Karlman wrote:
> Hi Mikhail,
>
> On 2025-06-07 00:31, Mikhail Kshevetskiy wrote:
>> load_simple_fit() returns -EPERM for the images with broken signatures.
>> Unfortunately this may conflict with image loaging selection on the base
>> of boot phase. See commit 873112db9ce68c38984ff25808dde726f8dd5573
>> ("spl: Support selecting images based on phase in simple FIT").
>>
>> Thus loading of
>>
>> 	configurations {
>> 		uboot {
>> 			description = "u-boot";
>> 			firmware = "atf";
>> 			loadables = "atf", "tee", "uboot";
>> 		};
>> 	};
>>
>> with damaged "tee" image may finish without errors. This may results in
>> board bricking. This should not happen.
>>
>> The simplest way to resolve an issue is returning the different error
>> code for the cases of broken signature.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  common/spl/spl_fit.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>> index ab277bb2baa..783bb84bdb5 100644
>> --- a/common/spl/spl_fit.c
>> +++ b/common/spl/spl_fit.c
>> @@ -322,7 +322,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
>>  		       fit_get_name(fit, node, NULL));
>>  		if (!fit_image_verify_with_data(fit, node, gd_fdt_blob(), src,
>>  						length))
>> -			return -EPERM;
>> +			return -EACCES;
> I think a proper solution would be to fix the bad use of EPERM in the
> commit 873112db9ce6 ("spl: Support selecting images based on phase in
> simple FIT").
>
> That commit should never have used EPERM in the first place, it should
> be reverted or its use of EPERM could be changed to something that is
> currently NOT used to block loading images that fail e.g. a signature
> check.
>
> Regards,
> Jonas
>
>>  		puts("OK\n");
>>  	}
>>  
