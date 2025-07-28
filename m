Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA810C83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 09:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3408B82CA4;
	Mon, 28 Jul 2025 11:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bUAwTrhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0453A8304F; Mon, 28 Jul 2025 11:15:02 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECFA982C84
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 11:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLhvmrN/q8+GFNQTVfT2BbqqndYJ3+H/MOIYWalEhwDqnVdjuBVIoi62OFQbwtFk/LDHj8h5gIMBcCrfvrCTMvGfXwLRBruyxsqtJmB3SxQFXAeuoyYmr1ry2/tLBgbV5vqDJq0f/tJQ7idaRfph8h4LDD2ZKQfQRwovj4FEtsXRd5I2X9j/+G/cinyZWlZ8p1ZuXsjrIVuSvsEKnFeD6AsRNmY0W3mgUHfXySD6VemriEBcHJdfLtwsOE/3ZBwpbWl+nQP0No+U/WaDzi86WqIz2VxBKxPslJ4JfoAQ2JDXkgO8oQdQLBLazQCAknfSAOkGdG+27ZpmCLzyXaROxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJpGvi0SWyFQOK1JPVtmUBb/CxiUJ1QkiMlYy7ACLUs=;
 b=o8ME2tppzzyprNAZWWFQPF9/OZT87IZn09/xMeWAZ9F+ISyjJPMOjmD0Lx83eWSZfRAYisNhSUkgNv54GYLL9Qv5EQzEhT4My9kSRYkFK6cJwQ+DRluu2QOyqr6ywT897/mscYXuSMWQIcr2bI/8kws/XN+A33d0VuLF9TBBNR5+WBM17FPQboRiTkLSV6IsuUPfHAffA4OKqRl5pbSs9c6IZoa9gcgV7yCpf80ODEMOGQDI6SCjBMwWh1gtq2QPPuOHTd+ATjfLyRW3da4o9iQYo9uT4fVdASNLf6t8vp1sxLz59BFzfUCUEFfi2xAYze0t67yoYhiF70kzFtwy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJpGvi0SWyFQOK1JPVtmUBb/CxiUJ1QkiMlYy7ACLUs=;
 b=bUAwTrhqW+NKXluT1UuBwxo2JThh7HTNQvhmC2q50M2llDzSVxPpnJqC2zxrng966pnwzd6Spb+e+ZTULmHKrK7Hg2trcjILijm/Ph2soSfZDw3k1QZV+Fxm7EoaoklqdbxvdQg5pumDETixVSQiiApflGquLy2Zp5jAVLA6DAdG1maKXJwuDXNoMi5uTiy5J+1tpEEBrU1adoLveJRyhpbmpiIEBWPK6J2FnIyhKccDR19Fx6trnm2hzFtya2/Qe/uWAdWacmb+5vo7lNk/RfLP7tbd24iAQBNBwgF1cRjXTLkYG0R8KT5coAG8jqQ6T6kpC0cjmpbz3A18C3a28Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7579.eurprd04.prod.outlook.com (2603:10a6:10:1f5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 09:14:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 09:14:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 28 Jul 2025 18:25:29 +0800
Subject: [PATCH] imx8m: clock: Correct imx8mm_fracpll_tbl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-clock-imx8m-v1-1-1aa0ec77305e@nxp.com>
X-B4-Tracking: v=1; b=H4sIABhQh2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyML3eSc/ORs3czcCotc3dQ0ExOTFEMT86SkVCWgjoKi1LTMCrBp0bG
 1tQAmH+8SXQAAAA==
X-Change-ID: 20250728-clock-imx8m-ef444d147bbe
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MW4PR04CA0331.namprd04.prod.outlook.com
 (2603:10b6:303:8a::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cb98f9-1a6c-486d-827e-08ddcdb73865
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHpFOWErWmJGVXUxZHpHTFhHUGZVblkxL3MvRmQ3ZklIMzV2U1FoNjVlZGdG?=
 =?utf-8?B?dzFUczE1UmZMUjdzYjVRVjVGYkxXbWFXU2FtbHVmN25UcE83azk3SFVWNjBE?=
 =?utf-8?B?alNLdHdSWFBBZVY0eUZLMjN2TmlhUWxxY25DdDBQaDNIQ0tBTFFzcU9rNFky?=
 =?utf-8?B?VHlqMUhNejRMRS9IS1pSVjFJQkZaNDNWRm9jN052MjlJTHlocW5aWHRlZ1Fs?=
 =?utf-8?B?RVVKTkZ2cFF6U2JVbDhVQVV0VHlmWTFoWXdSRGF4Qll6S0tGU2RPeVI5RHpI?=
 =?utf-8?B?K25rNG8vWkkyOTZUb0JiT0FwWXlNZTA3OHVDZlVjMmhwc2Y5Q2paUVZ1c0FV?=
 =?utf-8?B?OVdZOFFSZU9CdHdkUnpoUUdiREN3WG5ldkpHTTdRY1J4TG1LbUhoTTVucDJr?=
 =?utf-8?B?RjV6SGUwYi9aL3ZRdjY1L1lSUThtTDBvOWgyVFA1ZThVcWhUanZYTGdnbng5?=
 =?utf-8?B?MmRWYnJRUE1QT2pndzd4ckMvKy9OeURYMEJFVlNWNEpDanVOVmpscTh3RnVL?=
 =?utf-8?B?MnlGNXQyb0tDRjZrUS8rbENDclA2b1ZhZEQyMnFuZ0cvRDM0U0pOeVpoSTNn?=
 =?utf-8?B?cjRhQmQxMmJqdjdqUFp2eUVsTHhvRFJWR3FpRW90Myt2aTFUZmY1dXhpSXh5?=
 =?utf-8?B?ckF6M0pUM3lOM1lQYTlwRDlqblkrRm9XKy9kV1g1RzQzVGVlNlFtM2RrWjMw?=
 =?utf-8?B?R2RuaXlSemMzUGNTOFVhMytUYXVHcFk0a3VzUmVCRTFsQWhFZ1d0dDJUZUF3?=
 =?utf-8?B?VXdxYTU5eHZCZDlCQ3c1QVZPS1N4WlVDMmxrM2M5ODBFbTBIa0dkdUQzU1Rh?=
 =?utf-8?B?UFRCT3FlTmZxcFU4S2VlUWtibU4xdE9Ca2NvZHV3b2ZZaFpKalJuYlMxQ2lq?=
 =?utf-8?B?bDAxSm83TnpqRExiU0NhR3VoK3d6bWhjRUJKeUJRQ2tNUWphSktRMlpweE5O?=
 =?utf-8?B?N283NXVZUnYyNGU0UmRSYjNMODNvK05ZQWNZUjhDVGZGZjdqbERTdUpiYUp2?=
 =?utf-8?B?V21MbnJpR2JDZys2L2QwQTlwR2FGR1ZYUU1xV2tGb1BnSlZYdjZ1Qnhta3BH?=
 =?utf-8?B?WEJvUXhyUVRWb1FzaTV4T2ZPU2QwTTBJLzg2R0JCMFc1VG8zUGVOcFh6a21S?=
 =?utf-8?B?Lzd4V3d3SWo2d3NENjJmVlp4MEl3eno3eFlDckdodHRyME4yMkxNK2NVcWg1?=
 =?utf-8?B?VEJ5cUVQaXRsOXlhK09oM1NJMmxpclhvakZwSjhpemZNOER2S051Zi9mQmlT?=
 =?utf-8?B?THE2ZGs4bDk1a09HamdYZkVzbnpNZFU1M1pTanRZUXZuZE5iN0hpdTJoVjRU?=
 =?utf-8?B?N2FVenNKV0dzRU9XR0N5Q1d5cXlNdC9CT0xZZ3FYNnpkdm1jZ20rTHg4SzBD?=
 =?utf-8?B?ZGRJaVFzRnlpcCtmU0pNMnNUR2lUZHJRekJ4K0NXT1BmZ29LdzAzMUVxRUxH?=
 =?utf-8?B?RlRrZlVwREQrTStaT0hVaThGQU13VXhiQ0RUS1haaDdxa1VYZFdjWlI3UExp?=
 =?utf-8?B?OW9hWEVsYy81R0ZQL2ZqTkV6SUYrNDJnTCtMK3VJN3B4QTFEUVlrWFgyOUxB?=
 =?utf-8?B?cUxac21DNzZoL3BwYUczU0I2ejBLQm8xR2JFc3hLVGFXUmdLVmpYSVJsOGdm?=
 =?utf-8?B?NXA4ZEYwT3IxRWxYcFpzam5JaktteU1Bbm55elVJbDV2L0FMOHE4QTczcko1?=
 =?utf-8?B?dVBMOE9UOTZHRzlSWGI1WjVuYlFqWTBQV0lqYlhsUkpqMk5sVDF3aVFzQkRS?=
 =?utf-8?B?QXB2UytBZXhHdkZNTHB1UFE0cjVOUjZXdHVOVVRwdkhOT1ZQTWp0bzd1ZGVS?=
 =?utf-8?B?Qk9iRXZaUXllc1V0V0JES2xnSWNZYVVUZkk5dFdiVFkyNjRHcE5jeDVUSVU2?=
 =?utf-8?B?cHJqQXpUUnBlMVlnSktKZHNuejJ4ZXdMdU9rOFdqYUFqdGJFK1pUcEk3SHNh?=
 =?utf-8?B?Q3NtUWloRlovUUZTaXhSNlE2VHNYcVZTYm9yWUZxbUptQUNBWVF2ZkgreE9R?=
 =?utf-8?B?MDRoeHVxTVN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qjc3Mkw1bExkMnBXVzhUSUVDL2Z4UXltbVQ5WE9UQXdpOGszUXRyRks2eHJo?=
 =?utf-8?B?eGl3L3pyb3VpaFlHMmFuOUtZYVNJbE1HLzExN0NKMEVMTGF5SG5Vc1VKKzEv?=
 =?utf-8?B?S0hWWWNHZS85YkdzM1JFN1NOamVzN2hHNUdvRWgwQ05pWGo2MXZwMnRFczhR?=
 =?utf-8?B?Mkt0czBKYThhMjE1bHJGV2oxRUFCSTNsaGhQSXZ4OVVqSDQxQk03V0lobjRa?=
 =?utf-8?B?WFZpZ2w4ZVJIMS9OTlFJWkRKcEUwYnAvUkpyS1lkaHFTT2hybXBpeFRBVlRP?=
 =?utf-8?B?WmwvSUVmS3Y3aW5wTWVoQkhNRUg2dmxKckdQS3RmeFVmNDcwUllqOEdTZ0cy?=
 =?utf-8?B?QXJsOWtycmtpL2JPSzlKY3VsZU8rUkk5Q0pubDFFMW9ENVFqWm5XRUZaUCtP?=
 =?utf-8?B?MHVEbUZhaTNLaGhHTHBRMXhnQkQvblhEa3k1TS8wSWVuNWszS2gwMEhnQk5T?=
 =?utf-8?B?U0dRZFU4MFRuQ3ovNk1jU3BZc25ZWkROdDF6WHBXRHl2V1lDZFptYWVua3dl?=
 =?utf-8?B?TjcxQmEzYjBYZ2tWK1pCOEV0ejBBekNqL0I0VmdwQTYyVkI3U0wwZ3piaGFk?=
 =?utf-8?B?WFY3VmFlTjFHT2N1OWtZZE14TlIwY2Q1OURYM3QxRkt5NWVaSVpoVEJrNkNn?=
 =?utf-8?B?ekZzNENORXc3NVpweEs5cTluY1dzNFdTWkRRMklSa1UyRzlDcXJrcVY2SGtM?=
 =?utf-8?B?NHczK1VUZXRqM1FDSnd4TzF5TktLUGRPMmtLeTh0bXlDTDVGSnBHMmhnNi9K?=
 =?utf-8?B?cnRQdklSRnJxaHFxb2twekNud0k3dzRqR2g2eExQOWJFQk5adVU2aHplblM2?=
 =?utf-8?B?NGhldnkybThRL214N2NhQzE5blQ4V2tzdGtUMkF4T1FkMTc3aTZxcitnMHpD?=
 =?utf-8?B?aVQrdjFMWndaV3YzZkN4TUVTNUl2c0hnZzFBZGJST2pYemxwbkFBSWhoV2Zo?=
 =?utf-8?B?RnZxWndRc0xjWCtLUFNaMldoQ20yUUxvdXJnUHAvM0gvUVJDU3FuVncyNkhV?=
 =?utf-8?B?L0g1cVkwc0V6Z0tYRlRtZTFDa051RFNRazh4b2xHTGdzVXV4Tmc5d0V4OFBW?=
 =?utf-8?B?bk1ydlQ4WUV3MVNRQ3YvdWVzdGlCdEJSMXZ4RlgwcHpyR2xHRDZIbzFraHJI?=
 =?utf-8?B?dC9TeGNFbHN2ZWcrRmJaV29RTUFhcVN1L3ExQTBkaXo0V2l6NzRQOXIrZ3lv?=
 =?utf-8?B?WkxpaktYM0JSdVAwczR3R2dOZ0pNdU1ybkFQNUh2MmpzRDdFQzQrVnNUT0U4?=
 =?utf-8?B?bnNabitNTWxxamlBb1BmNTI0cDJOQmVVQmd1ZVdGeVNJSy9xSTBYVE5Fc2lr?=
 =?utf-8?B?NUZaMlFGLytQdHduVDRxS1BPZHB3MXV0cTZWdTBBRjZKa0JzaUpVVVNES28x?=
 =?utf-8?B?Q0VRb3czNFVwaStzdm1EcktLczg2ZHh4Mk5pSE85WWU5WEhJMjB5WThrM2p2?=
 =?utf-8?B?SlRMVkR4VWd1RkJMNnFZa29yRXNWOGgrTlVDVVFNbnRYR1JVTXJiemVGSER1?=
 =?utf-8?B?aFEvYWxxSTd4d0oxaXk2OFlaUUFWbHowc0dkazVsZE5qcGhzK1pxNUJ4NWhP?=
 =?utf-8?B?WTJiRWhzeklPdnozOXVUVVNBNVpDcWJPWlZObzNzVFg1ZWc2WnhmZzd0NkFy?=
 =?utf-8?B?V25HNVFDbHlLeXdHeis4MlhWcmJJdjY1M2FTd3lwaU9EVkdNM3piZXhUUmR0?=
 =?utf-8?B?WFRXQkorQnJIOVgzTStxWk1FNnp1UlZNYUtNVHBpWXBHUE9KMkljZzlTeFhm?=
 =?utf-8?B?TC9oaXM5VkplK1o1VWY0V2VpVUhINVFZSjdzMGJLVXFEZjhETVdiMTVsa1hH?=
 =?utf-8?B?emFGbjJGUDlJQUdFYUxvUTA2TERJbGlpZ0gwUXFHSjNxVG1kVlcwVjdrT3h2?=
 =?utf-8?B?V0RRdlhxV3l0b0QwVk5VcUMxUjBrTlhBbmhBV2w3WE4wdjUxTDBBSGJSM0hD?=
 =?utf-8?B?THU2bGtyeFd3Rk1GRmlEWTl6SGFsK3ZKZEkvVTExMEhtSHdEUWhKWUtSQUZr?=
 =?utf-8?B?SllmWklKL2NUN1c4UGN6SEdZTXRVTFFkNWtkemtuaHZteWFWanJyOEY0ZFUy?=
 =?utf-8?B?UjhDUjR1UnRTR2lBUTAwSW5aOVpZdGZaNHRFSlVUWmZWY05ML1pFV0hZRU1I?=
 =?utf-8?Q?We53lIF0OYKXPWMZwiT0zEBKF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cb98f9-1a6c-486d-827e-08ddcdb73865
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 09:14:56.7349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wGGAMfa5Gc0hCMktPSK6BLkWNJ3gkM4Rf56hX/7g/wBEF3HUmUnIfrIObve/vtskP7OgezEfRNJ8j7VSxQrcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7579
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

The minimum frequency of Fref (Fin / p) is 6MHz for the PLL AC
Electrical Characteristics. Setting p with 9 or 8 voilates the Spec.

Update the settings to match Spec.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/clock_imx8mm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/clock_imx8mm.c b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
index d5745f67262f31aefc4bcf1a5c462108bdb82bd4..77c8efc7899cc33c0c0be94a20925434e10249cc 100644
--- a/arch/arm/mach-imx/imx8m/clock_imx8mm.c
+++ b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
@@ -55,16 +55,16 @@ int enable_i2c_clk(unsigned char enable, unsigned i2c_num)
 static struct imx_int_pll_rate_table imx8mm_fracpll_tbl[] = {
 	PLL_1443X_RATE(1000000000U, 250, 3, 1, 0),
 	PLL_1443X_RATE(933000000U, 311, 4, 1, 0),
-	PLL_1443X_RATE(900000000U, 300, 8, 0, 0),
-	PLL_1443X_RATE(800000000U, 300, 9, 0, 0),
-	PLL_1443X_RATE(750000000U, 250, 8, 0, 0),
+	PLL_1443X_RATE(900000000U, 300, 2, 2, 0),
+	PLL_1443X_RATE(800000000U, 200, 3, 1, 0),
+	PLL_1443X_RATE(750000000U, 250, 2, 2, 0),
 	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
 	PLL_1443X_RATE(600000000U, 300, 3, 2, 0),
 	PLL_1443X_RATE(594000000U, 99, 1, 2, 0),
-	PLL_1443X_RATE(400000000U, 300, 9, 1, 0),
-	PLL_1443X_RATE(266000000U, 400, 9, 2, 0),
+	PLL_1443X_RATE(400000000U, 400, 3, 3, 0),
+	PLL_1443X_RATE(266000000U, 266, 3, 3, 0),
 	PLL_1443X_RATE(167000000U, 334, 3, 4, 0),
-	PLL_1443X_RATE(100000000U, 300, 9, 3, 0),
+	PLL_1443X_RATE(100000000U, 200, 3, 4, 0),
 };
 
 static int fracpll_configure(enum pll_clocks pll, u32 freq)

---
base-commit: 4c3b5fcd810081bd7f3c51859fe1b5f0c159803c
change-id: 20250728-clock-imx8m-ef444d147bbe

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

