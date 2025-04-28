Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4742C369D3
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A1782786;
	Mon, 28 Apr 2025 12:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CpZLjKYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F15382145; Mon, 28 Apr 2025 12:39:41 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8EE682905
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUa2Ify3Lgfr4F8cV5LtXkjLwg48K7CvCDaaisIHk7MDSKxwMrs7ggFyqx1ep6LvEFVSzxHHikOOhctcpDfPOQa4uEmeXblweFe/XkZqHRa5nscFV9cwxzA9EJOGWRlF5w2pTejgBeXJ/gvRVT8Z8JuqW6YeiVNtGDZCrZxMLR0eOVTA6uBkEo9BK3ZtRKfZIT8uEdpwX7GbJXI8V8dlI7oSwgHxLx8SCefRx4Mwa4GMbFwgpnDOFuG7ZK5wYOj3A0TI7ceexx8WcSVxHu8uolDCJGh0KqICHoDidwmIEZfQKfRFIsI1A6G+4bENnBEcDPGsxn4RqqIwZFXdiEo2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKl8J0d5zTpvtomJ//rF2TLAfp0nZ4qBCJG0OxCcboA=;
 b=BdtvaE8dGZu+sE71rWZ8iuN0IvKyKRZB1In1Y/iUg8kFN0HyFms2leqQknVL0RFOg7f3O+jojpNlrkz5i05TkGtoEfqo4S2/eZdWCfaSAovBey8QdBGbL4xx2pxL47+O0I92KWKLA/VFLjEwI1ydbfEn90LjTn8oDXk1h3B33VTqdmM5hw42I32mpHqPuAPZC39/za4v0rMSSZQuJMwzPApL3VzZpWhEYQPPy208S9G24FFjcOqJDXJsTs2xhBMN9I1JtlN2xVJqqid9t+3ry097LFiRzQJ8CvMplYsthgekhh57BUut5r3scnSuyy96toF9wyFeeXO4Zjk6JhASCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKl8J0d5zTpvtomJ//rF2TLAfp0nZ4qBCJG0OxCcboA=;
 b=CpZLjKYvbo2puQ11b5mjxUMr1CuDOJZbGsDN1kzENiphYu/vDNXYsd5p0VlHlR1b4/lGmjOsi3nNq0sWhGGodQjxS9SxybDxF3cut3f0P+q1tAK9cTuPvl8e3DiDSiWfHgR0aVXm1NStQbjHE1I1aBvLyVKeeV2yZJcw6CuKm5Wxw2oaL+fmc62DaPsRXBknfecHdm8GmOO3XzTl5Ygq3dksE2xFxwpeJrkGztFVMARzKddXUXxiZ9NEaXVnTLyGwdi/iG3itazDmbqJ0tjBEZjDhrSD/JYc3CtcNJgdxOlOUaJ6O6FF64/N3Ef6s8OdJpUftTRC7tpJSXKeYf4noQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:39:37 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:39:37 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:40 +0800
Subject: [PATCH v11 17/21] tools: imx8image: add i.MX95 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-17-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: d891136a-b8fd-4f6c-598c-08dd8640f905
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejB6M2xkRHArRmFmTUVsZDYwT20ycTNNd0lrdE82NmZlZ0tFbERsZnZWc0wr?=
 =?utf-8?B?Z0dSZEIwZG5vbDcwUTZpRlZsNThnVi84aXNkamxwYk5GUHE1aXh5d2JtNzR0?=
 =?utf-8?B?bUVXTGM4QVRQVGM1QUtJMmdENHVaR01IS2VQSWNub3U3ZHB3TlRkdUtWRXBs?=
 =?utf-8?B?TlFZaUVaV0RnQjRqV2VmbGhRbk5iVlhHSktXZXpZeXcxdEhsWVROekZJcVVh?=
 =?utf-8?B?bjhHdXVSUjJUYU5BVytmQkJYVkJIMmcwOERGMG4vaXJpS0l0ZEIwUGYwZTU2?=
 =?utf-8?B?elFnaXIzenArUnRMVkNQa2Zya2VsV2hYUVQ5UGM2WWNUQWJ4NWorUTdWOUFQ?=
 =?utf-8?B?aEE5cEU2SmhvbUZFL0QyZ3hucUxQUkpCRzkyYlRwTWtTc2xaUWMvdG9GSDNM?=
 =?utf-8?B?d1Z5VSszYWtMT0diSlY4RzgrdE1jMUlJbExmbXd6Rnc2WVYrWmx4VXhhaWlt?=
 =?utf-8?B?dXFZcFc1V2JGbDNwb29icVh0ejVUTy9uc0E2cmxGdEd3RzAzcUNqRHFLamlO?=
 =?utf-8?B?NDFXbGx5ZzcxYWJrVTA5N0x4NEhsWVlqUGZCM3crRWkzK2V6SXBYWkQ4bHpE?=
 =?utf-8?B?ME1ucW0vQ0l5eG5IYTR4UGpGSFhibUUvNHp0TnBCN0ErcVBmZVBtakpFRklJ?=
 =?utf-8?B?emE1dHlZYUVHY0dnYkV6b2syZEV2eU9ZTEpZYUk3LzhmUE0rYVpoT0FxYUtK?=
 =?utf-8?B?WFZJb1lNajVOQ0hiS3FIY0RWZmViZnRhVklsT21GdTRRbG1VbDhabFMzYnBw?=
 =?utf-8?B?RUZpVDBMM2xwQ2tnS2VkNjdPOGo3MVhYUHlVQ0poMUlPdVdEZ0E2eFRpalVJ?=
 =?utf-8?B?VXFyR2t5aGdmZUd5OEdIVUdYZnE1dFozc3hUQkNsclNpb3hjQlhFM211a1Js?=
 =?utf-8?B?TXRDY3UrVXhpV2dPOW1HN1VpUkN4cU9wYXV4cDR4WkFXVGZJajBwR0pWNG5i?=
 =?utf-8?B?TStBR1RWUjQ0V08rUnk0aFd5L3FvMHhNTzBzL1h1RzhUMy9Kek1aa0VVMEM3?=
 =?utf-8?B?MWNQODhTb3JSOWo1YWkwU0F0a3Q3YzlObnZYcWNHZk9CV0dzaUNTN1o3emdp?=
 =?utf-8?B?VGZnWXNld29tb3Y3SXAwVG5iRVljM2M0RC8vWjJSN29yRWx6Tzh4Z2xGVWhM?=
 =?utf-8?B?WmFGcFptU01sZmlwNWIzL1VFdEd3R3lmTUNlclh0M2pvNXBMNWxZZzNyUnZI?=
 =?utf-8?B?VGwwNTFjMG12MDE2RTlWdS9BOHZIclkydEczdFpTVW5ZMjl1MTJOYXpzcEFn?=
 =?utf-8?B?SUdjZ2ZSRFZWSmdHZzdIT0NBMUdXbUtFQ2JET056WWRnSHpMbVN0R3dHQ0hT?=
 =?utf-8?B?USs2TlFMQnhlT2VkR1gxUVR1VG56aXg2aHUzazMzQnErS1kxY2VCSVhxN1pN?=
 =?utf-8?B?TWpFWWJhNzRIdWFPNzNCZVg3V1JzbWJhLzlVaXBpdHk1TlljTUs3SDY3NEdL?=
 =?utf-8?B?d0FwTVVqV2Y2cjVZbTcvMTJVWWoxL2NHUGwyV0hJZ1l4Qkh4dE92NytmWnhR?=
 =?utf-8?B?c2tibHplWTBzenVoa2k4bXdqVWpyRmg1QlovRUFxY0NYS0dFeCtRcUVMdjJQ?=
 =?utf-8?B?Z3MvWnBJUUlUODhwcy91OVB5d04wN3ZGQ2pNQ3EvU3B0Y0M2aVZzUzJwSVN4?=
 =?utf-8?B?Q2dCUkhUYUpoalBib2dmS0xiZ1UyWG8xZi9hL2xKVlJwb3dpSnBZekxZM2tV?=
 =?utf-8?B?OUk2WHl2R1VLU2t3clJTc0daQWxMcG1rV0toR0ZCaE9xbm4xWTIzZXhFcWho?=
 =?utf-8?B?RDBmcWRwS2tlMVZoNUFXMGhGRjN6dmt6aFBtVzdDV1JEbU11ZGd5TnlQbkF6?=
 =?utf-8?B?ZjdtbnhlTCsxK0NlL1Zzd1p2WU8vWTM0TU1rY3I4TFU0ZTRtZUxtOStWVXdr?=
 =?utf-8?B?dEhmajYza3AvQXg2cHp0Q3U3MXdTZ2NqUCtnazZMWmc3Y3NTUzlHYjg2cTZY?=
 =?utf-8?B?aDVndlFHcUFGSEhDNnFLdWtpeHBYOGxPVUNQbEp0Um1OcE5XVjVZakdGbi9W?=
 =?utf-8?B?L1VWVDB2N21nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?My9ZbW1PUFMvUTFtbG1sVnlNdjlXNnBuOGIzWmR2ei9tUk9pRjlYY1J3Y0Nt?=
 =?utf-8?B?TWhQK1I1TnN3QWZwNGVXNk9KcUkwWXpkRzJ6blBvMlltMXl2bnl3YUw3WTc5?=
 =?utf-8?B?bm5EYThndURCWW5VSzRqL3Z0NXRrZ09lWHdXUXJzbVE5MjRIL05JenBRSjNP?=
 =?utf-8?B?L2RoMHpyUlpWSjRXTVRLeElCSU53Z1pYMkhzVU9Za2txSnRpTGdubU1kdXYx?=
 =?utf-8?B?Tk40SnBMRUZMMnoxdjVtbFdDYjQva2xyM2V6RW51RkFMWDUyWXJhZmI0R2R6?=
 =?utf-8?B?QmxjckR6dVQ3MC8wVHc5K2t3am96Q1B6Y2Z2NkFRaG5iTHJPYWdWRTJNK3Mx?=
 =?utf-8?B?MklneVJIYmJGWGVjQnFqT3lDNERyYVdwVzNDTDYzd0RkWnpudklTdkZ4MUV5?=
 =?utf-8?B?bEdJeVRtTW80NUtObGtrTDErWmg4UGhzNlpXNER1WlptUE51c0pCSGlGV3V6?=
 =?utf-8?B?Q2Y3akdZNVdPdEFsYUhhbTZ0SDkyb1dJZ05DRlBJOC9RdzNCa0xTRHRuUW9O?=
 =?utf-8?B?QXB5ekNsM0Rrc3NvVTViVkJ5Zkxpb3FHdURLckRFTEt4S213VWdIYWtvSkJX?=
 =?utf-8?B?czJuNTVkT21GaFlUM2tRVzc5cHpkdFNnWmc1UEN4K1ovQVZNMDMxbzNmcjVH?=
 =?utf-8?B?d2R6ZGl5VmNiRS9tK2l0a3dBMG0yT0diTTJDa0pHOW9VSE1yQmhyTDlCRDhL?=
 =?utf-8?B?YVYwWVM2Y0hiRC9ONmNUczcwUWhYdloxYkRSeVRlcWlLdkVJQzRyVXE2Ty81?=
 =?utf-8?B?NjA4R1c2akZpbkpWVHVhT3NpV000ekw0aEIzMjB3WG9SNTRrY2hDdnZCVzFu?=
 =?utf-8?B?UUQvc2RVUjBpWVVaMlIxdGtzNXhLc2hIc0hnMmhSZXRkZW03cEViUHNPWlJy?=
 =?utf-8?B?NGVyY1Q4WnpOTFBFZHNhNURTNHFEcUpDdlVtaVZnd20wOEdpK2dtSDlKdTRv?=
 =?utf-8?B?OVhZYkxLQXFWemxHSERodld0cnlPYm1waGdwOWM0eTJQbXFoUWZWTnk5R3Fu?=
 =?utf-8?B?MHlub3lacGRQLzRWMHJ4cHJ5T0Q5VHAzcm1CRHZBOXRZQUcyaHdYTXZZSTcr?=
 =?utf-8?B?R3gzVGhGL29UbDlIY3NBVTVBZm1TZjJwaE1uSzk4ODBqRTlOVnkwUFNpUGJj?=
 =?utf-8?B?YVRwakFOa1lSS3RLUkhqMDFEL3g0VjE3WG9YVnRzVjRqakZERS9uVVdXQVd4?=
 =?utf-8?B?ZjZGalIrWjcwQ2grLys2S0RmUnFCSW9EUjVvN1JnQWYzdEMyTkk3QXFLbU1v?=
 =?utf-8?B?ZXN5VHI1aXdnYTV6RURFemVUVy85QXZpMWtSVVY3TVZPUGw1OW9GajBKZTJy?=
 =?utf-8?B?SzZpd3pzMHJnb05KbFVhdjloSTVhNkdrazdQSXRVZFppdXV2SUlDWEQxNE1t?=
 =?utf-8?B?aEx5c2xvaExsRzd3WFFPQmp1UURhbGhDMVluUG4xVkVUWlVHZkN5QkozYStO?=
 =?utf-8?B?VGlZOHhzZkVNaFMzRzhnMHYrMVR5YURzOG5Mck1maklvNW1HK3l0RnhrZEhR?=
 =?utf-8?B?ZVcvMm1XQ2VYMVlxQmdybDk3UGI1ekwxNGxLZzljc3RDb280SFlSVE5peEVj?=
 =?utf-8?B?eXBUUWdPREhIK1JiNU5Ic2E1Q01nQ0cvek9zVnFYYTM4V3FENFQyUXA4QjAy?=
 =?utf-8?B?QUl4MjkxMElad2ZJU2VrcVBnL08xK0s1KzBlT01yVjVsbzhsNE1ndm03S016?=
 =?utf-8?B?aWxGN29Xam50ME5CSWxhQTRxUzU4Q1lFUVljTDd4QlJKSHRlTXB1a3lvUkxh?=
 =?utf-8?B?ZXhsaUpFOGpIUHF6aHJBQTQ4LzhGUnkzd3ZFanQ1Q3JZNmx2ZUQyNHBXK3ZO?=
 =?utf-8?B?Z3Y3TzBDcXNTL2FzRjg1b2ZDeEZIYndxN0xURU5tR1hXdFpYTjBwd3RsU1pO?=
 =?utf-8?B?M2tXbHRETXFjRnVkMGpmekFzeFM3KzVCSUFySE1UZisydmQ0NHVLQlkwZVhR?=
 =?utf-8?B?dzJzbHc0dXZBb2lTbEpxTHY3VkNBaUo4aDdiWjREeWMwSWlEaHE4VmNEcUV3?=
 =?utf-8?B?ekV5RkZrRXdFSDJ3dFljcTBGa1UyMTVSdEpyM2tzdm4yY3RKR25JNzNXRndK?=
 =?utf-8?B?N1N6a0NtK1RON2UrMDBDMnQvcVJjYStYdDc1TDNldy9CNlFTVWUxd0VUeWVs?=
 =?utf-8?Q?nIkMJ+1cjdfaKbzHqCpAt31/s?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d891136a-b8fd-4f6c-598c-08dd8640f905
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:39:37.1675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6FqkuGgKzXW5438mSaGE/YdFCVkHylR+PpAIvGkeHcjv4HHnHUXL4cg7elEFDr4dKtQ0pAcOj5tk4BGnaMOQQ==
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 uses binman to invoke mkimage to create image container. 2 image
containers are needed currently. The first one is composed of
ahab-container.img, LPDDR firmware images, OEI images, System Manager
image and u-boot-spl.bin. The second one is consisted of ARM Trusted
firmware and u-boot.bin.

Because DDR OEI image and LPDDR firmware images have to be packaged
together and named as m33-oei-ddrfw.bin by binman, so imx9_image.sh does
not check if m33-oei-ddrfw.bin exists.

When using "make imx95_19x19_evk_defconfig; make", imx9_image.sh will
delete the line for u-boot.bin in container.cfg. In fact, binman is
always called after the u-boot.bin is built, so imx9_image.sh does not
check if u-boot.bin exists.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/imx8image.h |  19 +++++--
 tools/imx8image.c   | 147 ++++++++++++++++++++++++++++++++++++++++++++++------
 tools/imx9_image.sh |   8 +++
 3 files changed, 155 insertions(+), 19 deletions(-)

diff --git a/include/imx8image.h b/include/imx8image.h
index 6b95e93fb50..e0d25c5b6c9 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -157,7 +157,9 @@ enum imx8image_cmd {
 	CMD_SOC_TYPE,
 	CMD_CONTAINER,
 	CMD_IMAGE,
-	CMD_DATA
+	CMD_DATA,
+	CMD_DUMMY_V2X,
+	CMD_HOLD,
 };
 
 enum imx8image_core_type {
@@ -169,7 +171,9 @@ enum imx8image_core_type {
 	CFG_A35,
 	CFG_A55,
 	CFG_A53,
-	CFG_A72
+	CFG_A72,
+	CFG_M33,
+	CFG_OEI,
 };
 
 enum imx8image_fld_types {
@@ -208,7 +212,10 @@ typedef enum option_type {
 	FILEOFF,
 	MSG_BLOCK,
 	SENTINEL,
-	UPOWER
+	UPOWER,
+	OEI,
+	DUMMY_V2X,
+	HOLD,
 } option_type_t;
 
 typedef struct {
@@ -227,12 +234,16 @@ typedef struct {
 #define CORE_CA35       4
 #define CORE_CA72       5
 #define CORE_SECO       6
+#define CORE_M33        7
 
 #define CORE_ULP_CM33		0x1
 #define CORE_ULP_CA35		0x2
 #define CORE_ULP_UPOWER 	0x4
 #define CORE_ULP_SENTINEL 	0x6
 
+#define CORE_IMX95_M33P		0
+#define CORE_IMX95_A55C0	2
+
 #define SC_R_OTP	357U
 #define SC_R_DEBUG	354U
 #define SC_R_ROM_0	236U
@@ -246,10 +257,12 @@ typedef struct {
 #define IMG_TYPE_EXEC    0x03   /* Executable image type */
 #define IMG_TYPE_DATA    0x04   /* Data image type */
 #define IMG_TYPE_DCD_DDR 0x05   /* DCD/DDR image type */
+#define IMG_TYPE_OEI     0x05   /* Optional Executable image type */
 #define IMG_TYPE_SECO    0x06   /* SECO image type */
 #define IMG_TYPE_SENTINEL 0x06	/* SENTINEL image type */
 #define IMG_TYPE_PROV    0x07   /* Provisioning image type */
 #define IMG_TYPE_DEK     0x08   /* DEK validation type */
+#define IMG_TYPE_V2X_DUMMY 0x0E /* V2X Dummy image */
 
 #define IMG_TYPE_SHIFT   0
 #define IMG_TYPE_MASK    0x1f
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 0135b190951..a333ded46e2 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -7,6 +7,7 @@
 
 #include "imx8image.h"
 #include <image.h>
+#include <linux/sizes.h>
 
 static int p_idx;
 static int sector_size;
@@ -54,7 +55,9 @@ static table_entry_t imx8image_cmds[] = {
 	{CMD_CONTAINER,         "CONTAINER",            "new container",      },
 	{CMD_IMAGE,             "IMAGE",                "new image",          },
 	{CMD_DATA,              "DATA",                 "new data",           },
-	{-1,                    "",                     "",	              },
+	{CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",                },
+	{CMD_HOLD,              "HOLD",                 "hold",               },
+	{-1,                    "",                     "",	              }
 };
 
 static table_entry_t imx8image_core_entries[] = {
@@ -66,7 +69,9 @@ static table_entry_t imx8image_core_entries[] = {
 	{CFG_A55,	"A55",			"A55 core",	},
 	{CFG_A53,	"A53",			"A53 core",	},
 	{CFG_A72,	"A72",			"A72 core",	},
-	{-1,		"",			"",		},
+	{CFG_OEI,	"OEI",			"OEI", },
+	{CFG_M33,	"M33",			"M33 core", },
+	{-1,		"",			"",		}
 };
 
 static table_entry_t imx8image_sector_size[] = {
@@ -144,6 +149,14 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 			exit(EXIT_FAILURE);
 		}
 		break;
+	case CMD_DUMMY_V2X:
+		param_stack[p_idx].option = DUMMY_V2X;
+		param_stack[p_idx++].entry = (uint32_t)strtoll(token, NULL, 0);
+		break;
+	case CMD_HOLD:
+		param_stack[p_idx].option = HOLD;
+		param_stack[p_idx].entry = (uint32_t)strtoll(token, NULL, 0);
+		param_stack[p_idx++].filename = NULL;
 	default:
 		break;
 	}
@@ -221,6 +234,16 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 				(*cmd == CMD_DATA) ? DATA : AP;
 			param_stack[p_idx].filename = token;
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].option = OEI;
+			param_stack[p_idx].filename = token;
+			param_stack[p_idx].ext = CORE_CM4_0;
+			break;
+		case CFG_M33:
+			param_stack[p_idx].option = M40;
+			param_stack[p_idx].ext = 0;
+			param_stack[p_idx].filename = token;
+			break;
 		}
 		break;
 	case CFG_LOAD_ADDR:
@@ -238,9 +261,15 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 		case CFG_A53:
 		case CFG_A55:
 		case CFG_A72:
+		case CFG_M33:
 			param_stack[p_idx++].entry =
 				(uint32_t)strtoll(token, NULL, 0);
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].dst = (uint32_t)strtoll(token, NULL, 0);
+			param_stack[p_idx].entry = param_stack[p_idx].dst + 1;
+			p_idx++;
+			break;
 		}
 	default:
 		break;
@@ -549,6 +578,7 @@ static void set_image_array_entry(flash_header_v3_t *container,
 				  char *tmp_filename, bool dcd_skip)
 {
 	uint64_t entry = image_stack->entry;
+	uint64_t dst = image_stack->dst;
 	uint64_t core = image_stack->ext;
 	uint32_t meta;
 	char *tmp_name = "";
@@ -558,7 +588,9 @@ static void set_image_array_entry(flash_header_v3_t *container,
 	img->offset = offset;  /* Is re-adjusted later */
 	img->size = size;
 
-	set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	if (type != DUMMY_V2X) {
+		set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	}
 
 	switch (type) {
 	case SECO:
@@ -580,6 +612,27 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->dst = 0xe4000000; /* S400 IRAM base */
 		img->entry = 0xe4000000;
 		break;
+	case OEI:
+		if (soc != IMX9) {
+			fprintf(stderr, "Error: invalid core id: %" PRIi64 "\n", core);
+			exit(EXIT_FAILURE);
+		}
+
+		img->hab_flags |= IMG_TYPE_OEI;
+		if (core == CORE_CM4_0) {
+			img->hab_flags |= CORE_ULP_CM33 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_M33P;
+
+		} else {
+			img->hab_flags |= CORE_ULP_CA35 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_A55C0;
+		}
+		tmp_name = "OEI";
+		img->dst = (dst ? dst : entry);
+		img->entry = entry;
+		img->meta = meta;
+		custom_partition = 0;
+		break;
 	case AP:
 		if (soc == QX && core == CORE_CA35) {
 			meta = IMAGE_A35_DEFAULT_META(custom_partition);
@@ -587,8 +640,10 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			meta = IMAGE_A53_DEFAULT_META(custom_partition);
 		} else if (soc == QM && core == CORE_CA72) {
 			meta = IMAGE_A72_DEFAULT_META(custom_partition);
-		} else if (((soc == ULP) || (soc == IMX9)) && core == CORE_CA35) {
+		} else if ((soc == ULP) && core == CORE_CA35) {
 			meta = 0;
+		} else if ((soc == IMX9) && core == CORE_CA35) {
+			meta = CORE_IMX95_A55C0;
 		} else {
 			fprintf(stderr,
 				"Error: invalid AP core id: %" PRIu64 "\n",
@@ -687,6 +742,15 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			img->entry = 0x28300200;
 		}
 		break;
+	case DUMMY_V2X:
+		img->hab_flags |= IMG_TYPE_V2X_DUMMY;
+		img->hab_flags |= CORE_SC << BOOT_IMG_FLAGS_CORE_SHIFT;
+		tmp_name = "V2X Dummy";
+		set_image_hash(img, "/dev/null", IMAGE_HASH_ALGO_DEFAULT);
+		img->dst = entry;
+		img->entry = entry;
+		img->size = 0; /* dummy image has no size */
+		break;
 	default:
 		fprintf(stderr, "unrecognized image type (%d)\n", type);
 		exit(EXIT_FAILURE);
@@ -709,15 +773,26 @@ void set_container(flash_header_v3_t *container,  uint16_t sw_version,
 	fprintf(stdout, "container flags: 0x%x\n", container->flags);
 }
 
-static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
+static int get_container_image_start_pos(image_t *image_stack, uint32_t align, uint32_t *v2x)
 {
 	image_t *img_sp = image_stack;
 	/*8K total container header*/
 	int file_off = CONTAINER_IMAGE_ARRAY_START_OFFSET;
 	FILE *fd = NULL;
-	flash_header_v3_t header;
+	flash_header_v3_t *header;
+	flash_header_v3_t *header2;
+	void *p;
 	int ret;
 
+	p = calloc(1, SZ_4K);
+	if (!p) {
+		fprintf(stderr, "Fail to alloc 4K memory\n");
+		exit(EXIT_FAILURE);
+	}
+
+	header = p;
+	header2 = p + FIRST_CONTAINER_HEADER_LENGTH;
+
 	while (img_sp->option != NO_IMG) {
 		if (img_sp->option == APPEND) {
 			fd = fopen(img_sp->filename, "r");
@@ -726,7 +801,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 				exit(EXIT_FAILURE);
 			}
 
-			ret = fread(&header, sizeof(header), 1, fd);
+			ret = fread(header, SZ_4K, 1, fd);
 			if (ret != 1) {
 				printf("Failure Read header %d\n", ret);
 				exit(EXIT_FAILURE);
@@ -734,19 +809,27 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 
 			fclose(fd);
 
-			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
+			if (header->tag != IVT_HEADER_TAG_B0) {
+				fprintf(stderr, "header tag mismatched \n");
 				exit(EXIT_FAILURE);
 			} else {
-				file_off +=
-					header.img[header.num_images - 1].size;
-				file_off = ALIGN(file_off, align);
+				if (header2->tag != IVT_HEADER_TAG_B0) {
+					file_off += header->img[header->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+				} else {
+					file_off = header2->img[header2->num_images - 1].offset + FIRST_CONTAINER_HEADER_LENGTH;
+					file_off += header2->img[header2->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+					fprintf(stderr, "Has 2nd container %x\n", file_off);
+					*v2x = true;
+				}
 			}
 		}
 
 		img_sp++;
 	}
 
+	free(p);
 	return file_off;
 }
 
@@ -838,6 +921,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	char *tmp_filename = NULL;
 	uint32_t size = 0;
 	uint32_t file_padding = 0;
+	uint32_t v2x = false;
 	int ret;
 
 	int container = -1;
@@ -861,7 +945,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	set_imx_hdr_v3(&imx_header, 0);
 	set_imx_hdr_v3(&imx_header, 1);
 
-	file_off = get_container_image_start_pos(image_stack, sector_size);
+	file_off = get_container_image_start_pos(image_stack, sector_size, &v2x);
 	fprintf(stdout, "container image offset (aligned):%x\n", file_off);
 
 	/* step through image stack and generate the header */
@@ -870,6 +954,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	/* stop once we reach null terminator */
 	while (img_sp->option != NO_IMG) {
 		switch (img_sp->option) {
+		case OEI:
 		case AP:
 		case M40:
 		case M41:
@@ -892,6 +977,30 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 			file_off += ALIGN(sbuf.st_size, sector_size);
 			break;
 
+		case DUMMY_V2X:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			tmp_filename = "dummy";
+			set_image_array_entry(&imx_header.fhdr[container],
+						soc,
+						img_sp,
+						file_off,
+						0,
+						tmp_filename,
+						dcd_skip);
+			img_sp->src = file_off;
+			break;
+
+		case HOLD:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			file_off += ALIGN(img_sp->entry, sector_size);
+			break;
+
 		case SECO:
 		case SENTINEL:
 			if (container < 0) {
@@ -963,11 +1072,15 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	do {
 		if (img_sp->option == APPEND) {
 			copy_file(ofd, img_sp->filename, 0, 0);
-			file_padding += FIRST_CONTAINER_HEADER_LENGTH;
+			if (v2x)
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH * 2;
+			else
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH;
 		}
 		img_sp++;
 	} while (img_sp->option != NO_IMG);
 
+	fprintf(stderr, "%s: %x %d\n", __func__, file_padding, v2x);
 	/* Add padding or skip appended container */
 	ret = lseek(ofd, file_padding, SEEK_SET);
 	if (ret < 0) {
@@ -980,6 +1093,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		/* Note: Image offset are not contained in the image */
 		tmp = flatten_container_header(&imx_header, container + 1,
 					       &size, file_padding);
+		fprintf(stderr, "error writing image hdr %x\n", size);
 		/* Write image header */
 		if (write(ofd, tmp, size) != size) {
 			fprintf(stderr, "error writing image hdr\n");
@@ -1000,7 +1114,8 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		    img_sp->option == AP || img_sp->option == DATA ||
 		    img_sp->option == SCD || img_sp->option == SCFW ||
 		    img_sp->option == SECO || img_sp->option == MSG_BLOCK ||
-		    img_sp->option == UPOWER || img_sp->option == SENTINEL) {
+		    img_sp->option == UPOWER || img_sp->option == SENTINEL ||
+		    img_sp->option == OEI) {
 			copy_file_aligned(ofd, img_sp->filename, img_sp->src,
 					  sector_size);
 		}
@@ -1031,7 +1146,7 @@ int imx8image_copy_image(int outfd, struct image_tool_params *mparams)
 	fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
 
 	build_container(soc, sector_size, emmc_fastboot,
-			img_sp, dcd_skip, fuse_version, sw_version, outfd);
+			img_sp, false, fuse_version, sw_version, outfd);
 
 	return 0;
 }
diff --git a/tools/imx9_image.sh b/tools/imx9_image.sh
index ca78a57a19a..6523d1a0ad1 100755
--- a/tools/imx9_image.sh
+++ b/tools/imx9_image.sh
@@ -18,6 +18,14 @@ for f in $blobs; do
 		continue
 	fi
 
+	if [ $f = "m33-oei-ddrfw.bin" ]; then
+		continue
+	fi
+
+	if [ $f = "u-boot.bin" ]; then
+		continue
+	fi
+
 	if [ ! -f $tmp ]; then
 		echo "WARNING '$tmp' not found, resulting binary may be not-functional" >&2
 

-- 
2.43.0

