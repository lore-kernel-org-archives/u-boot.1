Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A89CAC58E
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 07:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0E968343F;
	Mon, 15 Sep 2025 09:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZwAJj3XM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF4B83443; Mon, 15 Sep 2025 09:27:53 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A943083429
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 09:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWuq1KlY5XiCW9Gqy92PU/2y4BSW++4p49zVZyVvpS8x/NuRs4XQP1Umb/UpRHfK+jNXYVVnqyQ3gB9TTRnYef1A+u4OoJG4zJ9LPIsdcMFDqzRy+giSN04UIGuPZq/8AE5FgPfVzdAseysBSQbwLn8uF4afvqmyhiZa74USCE1bmGAcABTMedMyE96GZgY2NkLOny1Bwh0/L1uvi3hEsz5xVVZvAVu2wqcj1yd3Vz5cAI8auMp65hRAiMmF219xrJ2Be4QohBJjivGAo5nWZMrBuU1HCyN0jg6daZulygo7vNB3YE6q7l1JEc/aVRkW/ijYpueAhA4WRNvhWsrh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10tyZ1sIP78n6TJ5s5x85V1eP/LT9rEdhIMSL/dXIBg=;
 b=NLdGbpXCk1qQW6xasvdep/WRe6qfgqsPn7eQnFN311x+Hzifmt827hUTR2FERu8/ZJMznXUP+m5S4H0fkjzh8KAdhnP+iDQ1dKKOhNDzJP1ntRAxNrHXH0OhcwIRryfsS5hMNMOZJZEotgP6ryn5rM3CBH0VEhdeAxSQYO7ocfTXQgaD99n1feOpbtMwR39OYMJHdnkb4iWOapzmgPqwig3YkT6IlTp2hPIMaJ8VH01F3G8aV/s/ftnQVraTnr23lXz1Akk5yGVKKDxFMo6V5kJr4yTuknlBdZ+FR9rNEluu0bFSpT+Pp4W9lAtmRJ3t7LeW+Ft1sw5F65zvlebvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10tyZ1sIP78n6TJ5s5x85V1eP/LT9rEdhIMSL/dXIBg=;
 b=ZwAJj3XMVObf+Ks+ns580IVEQWND1QRpHjZjEouK5MfaFi+SgEnA1A/qaMuLTnk+WjU/2WB+eL3VLc2DBSNmwkuxmQONx9E3r2uH01Fb1oZzh/BsHT8z5x08p/xG1gmQ/XacvrtFozSrNqcbiA6h8fafBNIUgCaYLNykgN1ayCQ9MLDwXMudB6BsnKrITh6/g4BEUTrPBGEYiZbXeQwKMQaMuPiURM7Mh3+/8pgyNOOuwU6ZoRZ4taaJQ7rGoWDIz8iq38LNwGLc3l19J7LoKnKmdq4IKfC3ZGKbGjCw7vgqzG4UKJBkHZc6fihJn06UAhorExYOjk/rbvznUeIwpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 07:27:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 07:27:46 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Sat, 06 Sep 2025 02:22:04 +0800
Subject: [PATCH v5 2/2] imx95_evk: Restore support for i.MX95 A0 silicon
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-imx95-v1-2-f2a5231c1d0f@oss.nxp.com>
References: <20250906-imx95-v1-0-f2a5231c1d0f@oss.nxp.com>
In-Reply-To: <20250906-imx95-v1-0-f2a5231c1d0f@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Tim Harvey <tharvey@gateworks.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR03CA0089.apcprd03.prod.outlook.com
 (2603:1096:4:7c::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7d005d-f11b-4305-4d11-08ddf4295d9b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|52116014|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1d0WWRpMHhpTnRIeUN2dm02M1lMRnIvWWVESTJqdEJHZUR1M09ROThCVGk0?=
 =?utf-8?B?Y3pUaFBSVnJ6VHIzMEhDeU1tWm1YOFFpV3ExRXlEV21ZNFlwN2hyOHorL3NW?=
 =?utf-8?B?U0RPKzlQSUtDNWtmbThIcFhpdEZoM2RhS01uem96SEdUUUtOVFUrcjJGSUxx?=
 =?utf-8?B?c244Ny9WMXJlQUcvSjloL0YraFE4RGhzOGhCZTJhOGhsZWM5c1VHbER3dzIr?=
 =?utf-8?B?eUNMVTVrZ1ludjZmNHJiN1Uwa1lLd0tJTUQxQ0NqNXRhR3NXaVpBdDBHaXph?=
 =?utf-8?B?OGNKNzIzTEd1V2NuNHR0b1hveDBkU0lta3hxY1ZYbWpPQnJTWldXQ2JlTnpK?=
 =?utf-8?B?M0E4WWorUFc1SVNnbGM5UTliUDZvTFpETHg1bW9QRmF1TDNNZjVPbGxIM09t?=
 =?utf-8?B?TVlyZjhkN1NwN3JoaDN5eEtUVU5VOTdZQ0ROMkoxZVUwbGFabW5xLzJOVUkx?=
 =?utf-8?B?SWhkaVRlVlhBVnN1WXRLelgzcE1kTm5CNjVtcHcxNmxMcmg5cWtTWkdXZWdU?=
 =?utf-8?B?ZGdnMmJpNHlzMjlCakZRbEh6RS9RYTRhOFpobVpsVFY0OXZRWEdBWDA2V1Jr?=
 =?utf-8?B?ejB5WWtGYWFIZDU1OHlFbDg2aVRmMlYyais1dDVneFZIK3V5bVdubFJyTXh4?=
 =?utf-8?B?UmhhYzFqZEltaFlISDkzU3ppaVl5eW9FVno0R2tMYWZKa0VDczQvSkZadkZR?=
 =?utf-8?B?YnJ1V1lZOFhNTHJ3ZWNoZGg5VytEWjFGSjZTZ015UUZhWmF4RWRhUXR1TkRq?=
 =?utf-8?B?NzFTNHRYR1ljWDE3cExTSXJoZmJhUFRZK2VWWmJOZHpOZUppcGNlSkhPVzFY?=
 =?utf-8?B?UHcwSXAvMU5jYndTN3lnZHBqaEExakhQNFNyL2hnRE9kSjhBa2lhMUNEVTZu?=
 =?utf-8?B?MUd0OTFCeVJnSncwbGtIVS9wZnFjcllhaEFwazhTY241N3JVYk1QVEVsa0lN?=
 =?utf-8?B?TDZmUkRzYVdpcGxaVjNNS3RVWDFyVndXeUlKOXZaV1ZpMU8zQUZoRk9qM2x1?=
 =?utf-8?B?Q2k5NHlua3FDV1cvb2hCckVUUHVVQUR6Y08xODVic2VIL3JhdVJpdi90RXI1?=
 =?utf-8?B?aTVNeHhlMndmWlRWRUQ3enRzb0VtcCtNOERTQWZnWFN5b2UyaFlYWGx1NG9D?=
 =?utf-8?B?RmZ5TThtZWM0cTJ1MmVUNjkxdFp3U0pWMTFlQkJRK0J1b3JmZGZFdkRXU2ZK?=
 =?utf-8?B?eGZybkh5VHYwVENHMVc5Mk85V1VnOVUvMXNpSWtSKzZJWWszUVgxdUl0Skt1?=
 =?utf-8?B?VVJQNDJVZjFVSkMyWlkrY1BCMXR0Y0JxTVpDcFRXRmdMMk1iejB3WjJWUVcz?=
 =?utf-8?B?QmdOdldRQTV2KzBEQklKQzVLNjVKVk9pR0VWVHA2M09keUF1Y2lKUGNZdHFY?=
 =?utf-8?B?ZzF4emwrSm9wbUs2MUNUNllERTBxR3ZSZFloczIwdjRUYkVYcUdPRUxPa3M2?=
 =?utf-8?B?K2FzTHRxd1JDS0tCWWpyU0hNYWhDaUJwYUhXbTl5T2RQdXJremNOUzkyNTRx?=
 =?utf-8?B?REYxUXk1NHNmRFlhK0pGN005SU5Zdko0NnE0UFdIemhMdVVaSUtsejhNRGZn?=
 =?utf-8?B?ZVdIUVBMUGFHSnFKbWREWWlVWmEvTzNwM1U4WVJ1Rzd3Sy9NaUE3a0t1Y1Rr?=
 =?utf-8?B?d1NNaUFseVlybnVGZDNwSVVVeXVRWmh6VEVld0xaUm9XQWd4WHFXZUV2VFBt?=
 =?utf-8?B?Yk9sWk16aXBNYkFDY0JLTmQ4TkFSRTVtcHRieGFrNU9OSWtiaWRsQ2xwUmpj?=
 =?utf-8?B?YWZMbWowTUgzRFJPOWFEU25kZmVqbDQ1eE9uZENVMXZxaXlzcDhBTmg1L3FF?=
 =?utf-8?B?USt6Z3p3MWFyY3lLNlBhSGZFMDAyQ3ovMEgxNnNDREY3MDN6NTV5UStRUWpI?=
 =?utf-8?B?ZXljUUFQc0ZWakgyWDdCMm1zVDBDcGtqTE1CcjJ3LzFrWWFEQi8zQlgyNm5T?=
 =?utf-8?B?b2xFR0grM3ZVeUlrZ2ppRnVNR3R5QXBLcGVZRzNoUGpQb3U1dzVTWUdlZFl2?=
 =?utf-8?Q?XcyL85ihPIlHzaFKxT1yV6thpxp2N4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(13003099007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDdSVElZc1B6TUhMTjBoYklWN3FISEdvSlpUeG93QmtjQzVIWVhRWnFuWWlH?=
 =?utf-8?B?dGllSHlrK3ViNnNURVdOM3Vwd2VndzZlTFJUMkoxUWhuWUhSeXlxZ21mNUFI?=
 =?utf-8?B?WnBEQWgvTHhMbTlGMm9nVUwvc3l6bzVmSHlHdHVwbGJHc1YwVDNyWUN2Wmw2?=
 =?utf-8?B?cXdnckJrUEZKYjYwSmdmbFNKM3l5SWZLTXNhZWNjWnVGWERreWpXSU5oNHJ3?=
 =?utf-8?B?ZXJZK1lQWlB5Und2ODNrcG1YbmFEVEZ5UlNtNC9GczlMcDhaZXNpcC9WNStu?=
 =?utf-8?B?MXVqc0VnQ3dXdU9CVHVXUzlVVEZtcVBCejU0OElweFNpNkhRSTZKNWZtUkRZ?=
 =?utf-8?B?NHB0Mms0MzZETDFnWFJtdjBzL00xU3JCMk11SVRFNGhRVW1LenhTRk5MRkRk?=
 =?utf-8?B?R3VMcDg0ejRsR0wrQ3VzYzlQcHNKOXppU0d5ZDBSUldoZUpsTGNUQjZ2bndK?=
 =?utf-8?B?Mkd5dXZ6NkY3QzAxelllUVRYNWhaM1d6K1RIb05pazVtSUZXbnVEODcvdHBH?=
 =?utf-8?B?d0oxSkxBSDBNZDlHV1llS3FsL2RIMVlBVUxWaS9aOWhGWDF6cU1JMHdNbk5w?=
 =?utf-8?B?ZG9haElJaEN6WTdpY0JIMC9xZDRyeHF5T2xaWDgzbFpSVUdmZ2MwYUN4YUVK?=
 =?utf-8?B?QTVEMFhsS2l6QXhFeFMzelBVUkdsY3k4dTRkNW5Cc2dEL1EwZUlqTWxlRVgv?=
 =?utf-8?B?Q28zYkllOUF4dlVaTHpyUG5ONmxxdFhFOGo0QmszNjJrOTkxSDM4QXlDV3FY?=
 =?utf-8?B?TzZHK2M2UGsxcERZUmdqbmo2T2Jvb2xybG1GMTRpNFJnTHJtNWNkY1FJaWk5?=
 =?utf-8?B?Q0xseFhra3hTaHpNN0piQjZxZ1Vqall0ZDI4RzNaaDNwaTdRaGN5SWpxVEQ0?=
 =?utf-8?B?VS9YaVp4OUtJQXVZai85aWpLTXJxSitqQktxK2xWN1ZydC9lS2o5VGxNaVo0?=
 =?utf-8?B?L0xtMUxiWkxnRmNxZVhEVFM3VkNLUHR1RklCRk4weUJxK0NOS0FIM01pYWVM?=
 =?utf-8?B?TkhuVFlpQjVTWVcvc0lDRWt4aW1ZQXRCMmlqR3dWODZzd0ppZVIyN1pQVzhE?=
 =?utf-8?B?aUxiNDE5dEpidnlKWGJyY2FnUGswSGJ5Y2NFenFpRU9YMEFHMk5oMXNzclVw?=
 =?utf-8?B?MUpSRG0yWTU2b0ZUR3ByeElKSDJranV1M25pVU51NTNSZTAvV2lYNGtqdTNQ?=
 =?utf-8?B?ZWk4QzRxemEyVTM2Z3NxUW4xTWVyU09hS0hHQmVwV2g3b3dxcTR5bFptZzZ2?=
 =?utf-8?B?TTU2eXZGL2pGZXYzSnVqWkFFd2xHTDRWV0N3c2FlSjlXdEsraTduNXdEcmVV?=
 =?utf-8?B?RlJmOWhDZTM5L3lJc3I5ZG1yaDVpRGZETEI2bjA5UTg5U09YMWd0RGZCbE1W?=
 =?utf-8?B?ZmpldFl1RGNmMmZVV21mYVg5VUJkMUdsZVpzd1luVFBvTEVvcFpWdXlYVW5F?=
 =?utf-8?B?SEdyK205RVpwa0pCSVBGK0JrUUNjVlB0MDVJYm5oNWhQTWNtYkxWY3NjTENv?=
 =?utf-8?B?Mm0zcW1vdlVBQVFiMXV4VXFsKzJIamVzUXVsU0RqcSthc3FxZnFHTkdKNmV6?=
 =?utf-8?B?Z3JmdmxrUWh6dFNWYmlpQzFueVF4Z0lGTzRrTHVFQXBBR0s4dDgvWnhQOG9T?=
 =?utf-8?B?VjR3Z2YySEt2TEh3dEoybEY4bTBNbTBUYVZBSXc4QjcxWHVLVmJndDBJUUJV?=
 =?utf-8?B?M2Z1WGNUd1RXSVVwdjU0bHNUemdwaG5JdGdIYkpVVE9DenVQU2xacDFiamFs?=
 =?utf-8?B?QlpiU0ZWT1MvbGFOUU1GR1ZPN0IydFZiVG5ZY0U0ZC8vNDBSekJsRnlOZkRj?=
 =?utf-8?B?STBPWEJ0Vko5U01ITloveXhJaWZoOTJMdFlxdlZIUDd4SHdDbG42amdjSnNW?=
 =?utf-8?B?RHc1OFhqWk16bkhHb0E4L2NDSWwyeXlQUWhXQm9HNlJLaGVUNHR5d3NIU1NY?=
 =?utf-8?B?ZlFKQkdxdFFCdFpFMVNwTUl1QU9ZL0d3SkxMNmp6OGxCa0dpOTg5MUxsQ2Ns?=
 =?utf-8?B?b1M4TmVhbWNobkZWRDVqQmxONE1JZWtyMUxwTTB2Mk5nLy9LWU44UWdqd3hU?=
 =?utf-8?B?dmxhaHV6MFV0V1cwblRqVktIcldjb3h6emJwbEpPWHZYNGlKSWdCaStIUnNQ?=
 =?utf-8?Q?ww/dgOXXq/K4Yw73ZJ0IJm6rx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7d005d-f11b-4305-4d11-08ddf4295d9b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 07:27:46.0522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2dlp1WsV5FsYZzitfb32SCokuGs2T7pGVBjLPR0dG6wxPc6v2z5VdPbttSliwTZTIkqgl3iSkunzLmMXiGetQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326
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

This patch is used to restore support for i.MX95 A0 silicon. To avoid
duplicating defconfig, imx95.config is added and can be shared between
imx95_a0_19x19_evk_defconfig and imx95_19x19_evk_defconfig.

container.cfg and imximage.cfg are used to created .cfgout files that
are be passed to mkimage with -n to build flash.bin. Now they have been
deleted and replaced by adding their content to properties of node which
type is nxp-imx9image under binman node.

Fixes: 9936724aa9b ("imx95_evk: Add i.MX95 B0 support")

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Tested-By: Tim Harvey <tharvey@gateworks.com> # imx95-19x19-evk (rA0)
---
 Makefile                                  |   3 +-
 arch/arm/dts/imx95-u-boot.dtsi            |  44 +++++++--
 arch/arm/mach-imx/Makefile                |   5 +
 arch/arm/mach-imx/imx9/Kconfig            |   5 +-
 arch/arm/mach-imx/imx9/scmi/container.cfg |  11 ---
 arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  16 ----
 board/freescale/imx95_evk/MAINTAINERS     |   1 +
 configs/imx95_19x19_evk_defconfig         | 153 +-----------------------------
 configs/imx95_a0_19x19_evk_defconfig      |   2 +
 configs/imx95_evk.config                  | 150 +++++++++++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst               |  42 +++++++-
 11 files changed, 241 insertions(+), 191 deletions(-)

diff --git a/Makefile b/Makefile
index 9d2ac0c726d..3381f5b3739 100644
--- a/Makefile
+++ b/Makefile
@@ -2469,7 +2469,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
 	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
-	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot
+	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot \
+	       imx9image* m33-oei-ddrfw*
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 9bf8f9834c9..de74398fdfe 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -52,15 +52,47 @@
 			pad-byte = <0x00>;
 
 			spl {
-				align = <0x400>;
-				align-size = <0x400>;
-				type = "mkimage";
-				args = "-n spl/u-boot-spl.cfgout -T imx8image";
+				type = "nxp-imx9image";
+				cfg-path = "spl/u-boot-spl.cfgout";
+				args;
+
+#ifndef CONFIG_IMX95_A0
+				cntr-version = <2>;
+#endif
+				boot-from = "sd";
+				soc-type = "IMX9";
+#ifdef CONFIG_IMX95_A0
+				append = "mx95a0-ahab-container.img";
+#else
+				append = "mx95b0-ahab-container.img";
+#endif
+				container;
+#ifndef CONFIG_IMX95_A0
+				dummy-ddr;
+#endif
+				image0 = "oei", "m33-oei-ddrfw.bin", "0x1ffc0000";
+				hold = <0x10000>;
+#ifdef CONFIG_IMX95_A0
+				image1 = "oei", "oei-m33-tcm.bin", "0x1ffc0000";
+#endif
+				image2 = "m33", "m33_image.bin", "0x1ffc0000";
+				image3 = "a55", "spl/u-boot-spl.bin", "0x20480000";
+				dummy-v2x = <0x8b000000>;
 			};
 
 			u-boot {
-				type = "mkimage";
-				args = "-n u-boot-container.cfgout -T imx8image";
+				type = "nxp-imx9image";
+				cfg-path = "u-boot-container.cfgout";
+				args;
+
+#ifndef CONFIG_IMX95_A0
+				cntr-version = <2>;
+#endif
+				boot-from = "sd";
+				soc-type = "IMX9";
+				container;
+				image0 = "a55", "bl31.bin", "0x8a200000";
+				image1 = "a55", "u-boot.bin", "0x90200000";
 			};
 		};
 	};
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 8bd85e889ab..fa2cdaba144 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -223,6 +223,10 @@ endif
 
 ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
 
+ifneq ($(and $(CONFIG_IMX95),$(CONFIG_BINMAN)),)
+SPL: spl/u-boot-spl.bin FORCE
+	$(call if_changed,mkimage)
+else
 quiet_cmd_cpp_cfg_imx9_check = CHECK    $@
 cmd_cpp_cfg_imx9_check = $(CPP) $(cpp_flags) -D__ASSEMBLY__ -x c -o $@ $< && $(srctree)/tools/imx9_image.sh $@
 
@@ -244,6 +248,7 @@ u-boot-container.cfgout: $(IMX_CONTAINER_CFG) FORCE
 flash.bin: spl/u-boot-spl-ddr.bin container.cfgout FORCE
 	$(call if_changed,mkimage)
 endif
+endif
 
 else
 MKIMAGEFLAGS_SPL = -n $(filter-out $(PLUGIN).bin $< $(PHONY),$^) \
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 4e0e194690b..b6acbb20ff0 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -25,6 +25,9 @@ config IMX91
 	select ARCH_MISC_INIT
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95_A0
+	bool "Support for i.MX95 A0 silicon version"
+
 config IMX95
 	bool
 	select ARCH_MISC_INIT
@@ -33,7 +36,7 @@ config IMX95
 	select DM_MAILBOX
 	select SCMI_FIRMWARE
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
-	select IMX_PQC_SUPPORT
+	select IMX_PQC_SUPPORT if !IMX95_A0
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
deleted file mode 100644
index b25f3b726c5..00000000000
--- a/arch/arm/mach-imx/imx9/scmi/container.cfg
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2025 NXP
- */
-
-CNTR_VERSION 2
-BOOT_FROM SD
-SOC_TYPE IMX9
-CONTAINER
-IMAGE A55 bl31.bin 0x8a200000
-IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
deleted file mode 100644
index c2c92174c1c..00000000000
--- a/arch/arm/mach-imx/imx9/scmi/imximage.cfg
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2025 NXP
- */
-
-CNTR_VERSION 2
-BOOT_FROM SD
-SOC_TYPE IMX9
-APPEND mx95b0-ahab-container.img
-CONTAINER
-DUMMY_DDR
-IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
-HOLD 0x10000
-IMAGE M33 m33_image.bin 0x1ffc0000
-IMAGE A55 spl/u-boot-spl.bin 0x20480000
-DUMMY_V2X 0x8b000000
diff --git a/board/freescale/imx95_evk/MAINTAINERS b/board/freescale/imx95_evk/MAINTAINERS
index 5caf763e0cc..9d5c4e41b65 100644
--- a/board/freescale/imx95_evk/MAINTAINERS
+++ b/board/freescale/imx95_evk/MAINTAINERS
@@ -3,4 +3,5 @@ M:	Alice Guo <alice.guo@nxp.com>
 S:	Maintained
 F:	board/freescale/imx95_evk/
 F:	include/configs/imx95_evk.h
+F:	configs/imx95_a0_19x19_evk_defconfig
 F:	configs/imx95_19x19_evk_defconfig
diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
index 73818a82627..542b71f5c07 100644
--- a/configs/imx95_19x19_evk_defconfig
+++ b/configs/imx95_19x19_evk_defconfig
@@ -1,152 +1 @@
-CONFIG_ARM=y
-CONFIG_ARCH_IMX9=y
-CONFIG_TEXT_BASE=0x90200000
-CONFIG_SYS_MALLOC_LEN=0x2000000
-CONFIG_SYS_MALLOC_F_LEN=0x10000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=3
-CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
-CONFIG_SF_DEFAULT_SPEED=40000000
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0x700000
-CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
-CONFIG_TARGET_IMX95_19X19_EVK=y
-CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_TEXT_BASE=0x20480000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x204d6000
-CONFIG_SPL_BSS_MAX_SIZE=0x2000
-CONFIG_SYS_LOAD_ADDR=0x90400000
-CONFIG_SPL=y
-CONFIG_SPL_RECOVER_DATA_SECTION=y
-CONFIG_PCI=y
-CONFIG_SYS_MEMTEST_START=0x90000000
-CONFIG_SYS_MEMTEST_END=0xA0000000
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
-CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
-CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_PBSIZE=2074
-CONFIG_BOARD_EARLY_INIT_F=y
-# CONFIG_BOARD_INIT is not set
-CONFIG_BOARD_LATE_INIT=y
-CONFIG_PCI_INIT_R=y
-CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_BOARD_INIT=y
-CONFIG_SPL_LOAD_IMX_CONTAINER=y
-CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
-CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
-CONFIG_SPL_I2C=y
-CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_POWER=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_SYS_PROMPT="u-boot=> "
-CONFIG_CMD_ERASEENV=y
-CONFIG_CMD_NVEDIT_EFI=y
-CONFIG_CRC32_VERIFY=y
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_CLK=y
-CONFIG_CMD_DFU=y
-CONFIG_CMD_FUSE=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_POWEROFF=y
-CONFIG_CMD_SNTP=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EFIDEBUG=y
-CONFIG_CMD_RTC=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_GETTIME=y
-CONFIG_CMD_TIMER=y
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_HASH=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_NOWHERE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_MMC_DEVICE_INDEX=1
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eth0"
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SYS_RX_ETH_BUFFER=8
-CONFIG_SPL_DM=y
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
-CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_CLK=y
-CONFIG_SPL_CLK=y
-CONFIG_SPL_CLK_CCF=y
-CONFIG_CLK_CCF=y
-CONFIG_CLK_SCMI=y
-CONFIG_SPL_CLK_SCMI=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_RAM=y
-CONFIG_SPL_FIRMWARE=y
-# CONFIG_SCMI_AGENT_SMCCC is not set
-CONFIG_IMX_RGPIO2P=y
-CONFIG_DM_PCA953X=y
-CONFIG_ADP5585_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_IMX_LPI2C=y
-CONFIG_IMX_MU_MBOX=y
-CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS400_ES_SUPPORT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_MT35XU=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_AQUANTIA=y
-CONFIG_PHY_REALTEK=y
-CONFIG_DM_MDIO=y
-CONFIG_MII=y
-CONFIG_FSL_ENETC=y
-CONFIG_PCIE_ECAM_GENERIC=y
-CONFIG_PHY=y
-CONFIG_PINCTRL=y
-CONFIG_SPL_PINCTRL=y
-CONFIG_PINCTRL_IMX_SCMI=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_SCMI_POWER_DOMAIN=y
-CONFIG_DM_REGULATOR=y
-CONFIG_SPL_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_SPL_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_RTC=y
-CONFIG_DM_SERIAL=y
-CONFIG_FSL_LPUART=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_NXP_FSPI=y
-CONFIG_ULP_WATCHDOG=y
-CONFIG_LZO=y
-CONFIG_BZIP2=y
+#include <configs/imx95_evk.config>
diff --git a/configs/imx95_a0_19x19_evk_defconfig b/configs/imx95_a0_19x19_evk_defconfig
new file mode 100644
index 00000000000..9376f11b151
--- /dev/null
+++ b/configs/imx95_a0_19x19_evk_defconfig
@@ -0,0 +1,2 @@
+#include <configs/imx95_evk.config>
+CONFIG_IMX95_A0=y
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
new file mode 100644
index 00000000000..231b42cb377
--- /dev/null
+++ b/configs/imx95_evk.config
@@ -0,0 +1,150 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
+CONFIG_TARGET_IMX95_19X19_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_EARLY_INIT_F=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
index 27cd15eb7c9..709992e016d 100644
--- a/doc/board/nxp/imx95_evk.rst
+++ b/doc/board/nxp/imx95_evk.rst
@@ -25,6 +25,17 @@ Note: srctree is U-Boot source directory
 
    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.2-89161a8.bin
    $ sh firmware-ele-imx-2.0.2-89161a8.bin --auto-accept
+
+i.MX95 A0 silicon version
+
+.. code-block:: bash
+
+   $ cp firmware-ele-imx-2.0.2-89161a8/mx95a0-ahab-container.img $(srctree)
+
+i.MX95 B0 silicon version
+
+.. code-block:: bash
+
    $ cp firmware-ele-imx-2.0.2-89161a8/mx95b0-ahab-container.img $(srctree)
 
 Get DDR PHY Firmware Images
@@ -53,12 +64,24 @@ branch: master
    $ export TOOLS=$PWD
    $ git clone -b master https://github.com/nxp-imx/imx-oei.git
    $ cd imx-oei
-   $ make board=mx95lp5 oei=ddr DEBUG=1
+
+i.MX95 A0 silicon version
+
+.. code-block:: bash
+
+   $ make board=mx95lp5 oei=ddr DEBUG=1 r=A0 DDR_CONFIG=XIMX95LPD5EVK19_6400mbps_train_timing_a1 all
    $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
 
-   $ make board=mx95lp5 oei=tcm DEBUG=1
+   $ make board=mx95lp5 oei=tcm DEBUG=1 r=A0 all
    $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
 
+i.MX95 B0 silicon version
+
+.. code-block:: bash
+
+   $ make board=mx95lp5 oei=ddr DEBUG=1 r=B0 all
+   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
+
 Get and Build System Manager Image
 --------------------------------------
 
@@ -82,13 +105,14 @@ Get and Build the ARM Trusted Firmware
 
 Note: srctree is U-Boot source directory
 Get ATF from: https://github.com/nxp-imx/imx-atf/
-branch: lf_v2.10
+branch: lf_v2.12
 
 .. code-block:: bash
 
    $ export CROSS_COMPILE=aarch64-poky-linux-
    $ unset LDFLAGS
-   $ git clone -b lf_v2.10 https://github.com/nxp-imx/imx-atf.git
+   $ unset AS
+   $ git clone -b lf_v2.12 https://github.com/nxp-imx/imx-atf.git
    $ cd imx-atf
    $ make PLAT=imx95 bl31
    $ cp build/imx95/release/bl31.bin $(srctree)
@@ -96,6 +120,16 @@ branch: lf_v2.10
 Build the Bootloader Image
 --------------------------
 
+i.MX95 A0 silicon version
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_a0_19x19_evk_defconfig
+   $ make
+
+i.MX95 B0 silicon version
+
 .. code-block:: bash
 
    $ export CROSS_COMPILE=aarch64-poky-linux-

-- 
2.43.0

