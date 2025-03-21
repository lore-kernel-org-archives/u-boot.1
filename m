Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820CAC35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B2181DF6;
	Fri, 21 Mar 2025 08:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FIY/6j0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1AE81DED; Fri, 21 Mar 2025 08:16:51 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A3881DDF
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgAPsaPuvAeh7UbGYTYcuknZ8j8ByrEshDVSHb92GdNrQ2XQBH6YerjJd729Ynm2HDQrmQfowpKx0mjsLoTmlB22Gb4c3McqPLp+kBp7VOFGHSvd2WVehV8q0m2DiJ6tshU2K7LCm6jrC4KYrmy/YLDKu/zldEQkO+GXy71y+rtxzEJHrMp4xlv+nIbTWE7puyf29VC2V0nTwxn0KLM8WnKaUtFhskZWZsfzhBbCzWetDS6sd+mZveULdj2Nd7VXTarp+awWPBjmM2Rf4msbS4IEHLpTkttBIA6eNKMeDAXfXuBGz+iTxCe6XiyOlP/udcqDXcvLYFZb80NGY5of5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqEqlP6/59uTFIlxHQqbci25nISwhqWYBRvf/B1KkmU=;
 b=YKSPORE7SeNoygi3LT0BGnGBOWPiGcjxEQOOeGPhyEtV/RnGi6nTgSCBEHsYbgGFXzp0UYy/cYKX/WgUXniVU0ZbqVky7IX1DvGhd8wcfc5doESOYHqk/6tLLxVzd20B6YDpaFqkoePQBYdjsYKPoY+UIrfvvyyGlXNDB0RAijp1IT4h3nN8U6I3qggvmnz9Ufqupd+S/7auTsFkCHqQFBR72hKXThgIXv5AByARuy2uQ1HzjLLrLTwBs0sejMgwFtAkWMUzqhpOQ609JMpTfyKaeFUOVOskQKNQDn6gGtOxJRxxC+P2fcxiMlgrzre0KonJhpBUOLeZTFMrcGxGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqEqlP6/59uTFIlxHQqbci25nISwhqWYBRvf/B1KkmU=;
 b=FIY/6j0aDDVF6gnfCt4eurp/HzElK/q6dOpyLITlNRbGoH5o2BNqWEO/eLrRCgM3FvvtaUqykp3qe06+0v1dbBZa6WErShaxmcpvVS0MkixpOsXkXxbXmAIjayx+giER5cDO6Kp9/fgO/tKaC5ZtKO1A1QYMdMfsxiUWpC8+ee1OnQRE2BA01WrAww4f+rp2MyH9lctJVu+iflMuuZI8ipXG1mxuqVVioikVbSH/QLk53yg8lGk7xzwCNnMbPr2W4iuyS8mjkM9cgLbTlEtsRdw0Rb8oFMAV5hgPjYqJMqiwJppmY0so/8pzjABdSXKXS9VrDnDiimNFAsCf+9m6nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7421.eurprd04.prod.outlook.com (2603:10a6:800:1b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:16:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:47 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:27 +0800
Subject: [PATCH v8 13/19] imx: Kconfig: IMX8_ROMAPI is not configured for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-13-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ab2987-77cb-4ff4-0207-08dd684857a4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFBxb3gvcFhzZTg4Wk9KWlo0Y3RvbXdINU1BWGtLUnlMRi8yYWp1N0hBRDI4?=
 =?utf-8?B?YjZqNzhSWjl1MHdhL05KazVLYlAyMkd5dE0ybWZqZ0VibmFHblBsVVFSRzZY?=
 =?utf-8?B?K1d5LzZBckxPOWw0MTJzc1FEVlk1REx1TlNIZVRBK0FNdXZRRUhuUWovZVdQ?=
 =?utf-8?B?TDJ3dld5a0JIbStRa3hiSjdkeTF0UGhLU25hbWFNTHNmcGtoMXhwcGcxSEEr?=
 =?utf-8?B?Mmc1M2ZZSWFFT3J5UlNNRVFXU29OUW1CdFdnc0YrYWJCVnlqcTQvTEEzejRT?=
 =?utf-8?B?SzBXVGlxS3lNZkEwcSt5MzM2dEIvbDdQbkNDUS9hL09IU2FsQnovUk9rRHdt?=
 =?utf-8?B?YmV3Q3ROVDF6YlFFOHNUbkwrV1k1d1VWQmxkTHdjWkI2N0ZqU013ampOUTZu?=
 =?utf-8?B?TVNsbE4xWkxkSklQRlJrNk5jV0M3Y2E1d0tvbWVOdFJZN3ArQU9qcDVSaGo0?=
 =?utf-8?B?YXR1cUZuS0MwVDdlL1pOL3RBRmRRL1F5NmRuQzlYZjlyMkZNb01rODFoc0xn?=
 =?utf-8?B?UVp4bFVGZ2JueEw1V3pKZUFhSWpIN3B5YmRrOGV2OWF6OSs5UHFJL0tNTi9k?=
 =?utf-8?B?QUh5bHVCNVdEb2xzMS9ySmV2QUczNThDcEJKaWo2SXFianlCODJwQ2luMEd0?=
 =?utf-8?B?dHpEL3BmVVNodkRNWDA5RlhqQm1uMGZYVm5Ia3FFZzZOVTdNek5xQmZqalEx?=
 =?utf-8?B?Z3BVNVFpUlgrNmtwTGRodlg3bGt3dGVaT2NUUEVkQlpxYjJnNGVkTHFkL2R5?=
 =?utf-8?B?OENZUGtmWVB3QXJDQXJON3FReUtyMGdreU9Gd0ROVnpFbTRHRVljL0NlcnBt?=
 =?utf-8?B?RTJwTHArY21NQVF2OURhVm1TVzFkOER2MDZGUS9sc3pORDFiQStUYkw0dE5Z?=
 =?utf-8?B?OVJDZFN5RC9Wc2Z3aTgwNWxWdkMxUVI2MVhRc2ZLb3VmeXJ5dTQ0c2RwUDdp?=
 =?utf-8?B?ZjBNQlpycWJwc21oWDhsZ05OOENHZlJ4THFxb0U3a2ZXWkZ2d2lVdWdjcm1i?=
 =?utf-8?B?enJsdG1OSGNiNGR0Z1dSKzFxeno3VUJvUEV5Y25DUlRHdXRId0EyWkJtM3Jk?=
 =?utf-8?B?bm9QSU9NY2VVbjNyYkkxaTVLVUFkejFzdmhJUXZZVTE2T25OZWh5am9nWTJ6?=
 =?utf-8?B?MU5Pa0F2TU9vREVsR1hURVJuajBvTkIwanRaYkRrTElDS3BpZkFnM1NlZTBj?=
 =?utf-8?B?ckJBYnJuNHdySk0xUEUzU0tnNjViSWdiTlZoelVyUDZRNnlMMHZ4V0xmVzVJ?=
 =?utf-8?B?bXB0cEcweDVaN2JQa2tyVHdwWDFnMDJXajg1YXdONHNYSjFUV0VvWVlHRFZu?=
 =?utf-8?B?c2J0eUlzSHdHalJrWkQ2NTFqSXlMUUVhaFdhOWVXMytHU2k1bXVLK2JPejU5?=
 =?utf-8?B?RUVDSVpETjc1cnNZdW9xNmV3WkZXTDF3NE5aK2d2ajIvazdVVUFnODV5Q2FX?=
 =?utf-8?B?T04zcnJZUTM3QldTakRpVTFoSE9xUnFRaVRlZklzcksxZDRFcGxtUllzZ2Z5?=
 =?utf-8?B?cVpYRGQ3WHNESVJTQzBGWG83ZUk4Umkrd0FuT2J0aWpmQlR4a2hZMVN4MEFL?=
 =?utf-8?B?THBHNGlCQ0NwdUJ5VzFZT0c1OVlkWnlrbzNxRnFWd3UvU0ZubWcyWFRFTThI?=
 =?utf-8?B?UnhPcktIVzNKTVRtNFRJd1NnOTJVK0dXRGJFOFcxRnJ1blJKb2NkRUhncmFR?=
 =?utf-8?B?M29RbU9VQmdIcFZQMXpzNmFpYnZBRkFyTWJmc3FoaDJOcytkK1IzRnNQVEJN?=
 =?utf-8?B?TUd0ZlZqWWRydzR2VlhWV1FDVDVtZFJFVjA4elNCMmxZMzV0MUM2eTNoZFlK?=
 =?utf-8?B?RlJTK2RFRUdXVjJlT010UlBsK1c3UE1rOUJRN1JrcHdiNTdJaDRjOWUzdms3?=
 =?utf-8?B?RmVSbGpmWWVjczY1R0tkYTVXMngxckhlVlhlcHFsNUJnWW9FSEJCWWJWQnFt?=
 =?utf-8?B?V2tLb3VENFFQU285ZERCeFh1UUdDUHZmVTZTeVFHdXozdy9jY0xlL210TFBJ?=
 =?utf-8?B?VVdaY0J0QTZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aytmc0ZORjhSSEJLUzI0RmxvQUorNnZhOGc5TnJGelNuYjRvMld1dSswbnA4?=
 =?utf-8?B?b3U4N2h2T0IvWmM3Nzh4a29KdjV5N0xmMXVXSTc2TmF0T1oxS2hmOFZUbTMr?=
 =?utf-8?B?TmpRL2xhVWp5Q2RGanYzc3VHZ1oycEJEV2ZJQTV4WWw5TGhLVVpjTXRSTFRP?=
 =?utf-8?B?bkh5Um9PcXRQTEZHM1FBd1l0TnVSeDdHRnJqSVVPSHZWbU9tRWpETWVHUWVS?=
 =?utf-8?B?K0d4YmtQcC9kUzhYYmM2Y3JGYmNDM1JZWlBNUU93UGZrbytqNWVmSnlLNEZS?=
 =?utf-8?B?T0YvOTJ3N3NsUkFUMjZKQ0dwM2d6RWFhS0N6eFVyN0V1Z2JJcTRVU2ZKNFkx?=
 =?utf-8?B?a0F0UkpyeG5UcVFrb0JKdkJLbys1TE9TSk9lOUc2bUFYczh6dy81OGdlQnhx?=
 =?utf-8?B?aVdTTFJtTU4xcW50ZWk3Z1Q3dDVCOHRKMmhiU3ZIWlpyN1J1NDcwcmY1NjFM?=
 =?utf-8?B?amVwNnR3NS9VY0VOTGxsdkRtd3p6WWRtQTdOemNpVlFzU0l2TVQzdzkra2ZZ?=
 =?utf-8?B?bUZtL1VoNE8xU25rSHF1WUxuZTRHdnN2RjlocFowMTIwR2xlOW5WUyt2KzRU?=
 =?utf-8?B?RE9aSThaTm42ZDBzcVlNZWFVeEhuL2JZcjBSS09xMGlJaG0zSGsxbmRiNzRL?=
 =?utf-8?B?L2p6eEo1VWh3TWI4S1NxVUJrQWhMZURjam5HVCtBSjhvd1J2RnN0OThLZko0?=
 =?utf-8?B?QnJHZG56Uit3cmFxWEtRcnY1ZmtEWkhqUUJrVW1ObVlpQ3h6ZVNJUmE3UHEw?=
 =?utf-8?B?WG1iRmZlKzFHOHZzVkZ6b296cWdFcWt4cmsvamdJWDY2UDBDRVViS1RJaktM?=
 =?utf-8?B?UUZqMzBCdnY2YnRPOFhOWmRndXg5VEhUL1RxcFlUWHlHM1hkVUtIVWo2NDBY?=
 =?utf-8?B?THhGUVVYeVZmLzJHUWRyWFZFVjdpanNKOWN0V3pHa1hpYWEyZ3FvNVVPTjkv?=
 =?utf-8?B?cUVLR3RtRTV1SFdxZTlEREZGd2xhUVNzRnBrNHBrdnplZVN4YkJlVVZLVEF5?=
 =?utf-8?B?cm9NWE9TQ0p4NjdJQldIN3BwSjQzZzhENlNvdEVLZ21kdVFXWUdncis3cDNZ?=
 =?utf-8?B?SlVlQkFLa1JIOGZUenlwZTlmR254SVFHL3NaMHRJZWlsSk5hSW1FNzRwQ0pn?=
 =?utf-8?B?K3o0T3liamthd3gydjlzNlZCbGNYbEk5N0NWKzg0L1FtVjAyZXF2aWoyNk1y?=
 =?utf-8?B?NnZRQlA2K1dITnh3eHRJeG5aUXF1NGIvZVl3dks4enlvVitqbCtKMHhHTHE3?=
 =?utf-8?B?UldzdTJHZVdiWXFoMWJpazFCRkw2UGEzdkJJMVE5cXBoTHBjSE5nM2pmWDJK?=
 =?utf-8?B?WDJCMVk4cmtYNjJReUg0UXAwUENNNlNGWTREdExIVVIydUMxemx5TlpMaWtq?=
 =?utf-8?B?NjY3QnloeVR3NEtJcHZuZWtNOGNmbXNHc01VWUdCU1c2aDdnY1JHUWw5c1ZE?=
 =?utf-8?B?Ull0cUtMN0RsQ2EvMTNwNVR2dDlqeW1HY2U3cVdLNnljWGZ6WjRFeWdiQTVr?=
 =?utf-8?B?M1l5RERwaXVzM0ZNdTAvOVN1WDRGYjdudEE2ZGFFVm15VHRQdzRmUW5CKzlp?=
 =?utf-8?B?VGU0eGNud3hPSWhhbThRVVVoZDdvSHdCNllRM3I5eUdsWUVGamN0MUsyWTNH?=
 =?utf-8?B?NU1HSmdmTTlXWVBrWUw4cXVtSTBhcGx2VDl0WVJlLzRWODBjY1JaK3dFSnZH?=
 =?utf-8?B?dlJOR1pnK1pMRXNSU2VyYzhVdmI1b2tQbmRLbTJTcHNqdngzNTlxdUVNOUJh?=
 =?utf-8?B?Umg2d212NFNnYUxXeTZKQi9SbHJQTnN4MmxPRHY2TDQ5dXcxVS8zd0tlVEFh?=
 =?utf-8?B?T2VsdVBNaTdCT3pFdkVRNUhuRVdUM00wckVuUkV0ZzkvVnU1NkNjQnYrNkdV?=
 =?utf-8?B?bVQ2eWRsVys1cEN3ME9JTWU2RTJEcmZ5M3J3OTFjd0ZmQ1p4R3MvakJkVWRO?=
 =?utf-8?B?OENiRGVUeDMzWWk1endaSk5zTFpDNnYweHNOeUxvOStCR2ZoLzd1eVA4a2FL?=
 =?utf-8?B?a0R2UVIwYXFCMkdUUkFKNEI0SjRJTXU5dTl6Q2ZIVDFOYUMwSld4am5KalBP?=
 =?utf-8?B?QURxZGd2S1YzNElYdHlyZDVCMmV3UGY3ZGpiNklaK3ZPdHVGTng4MUhhTG5X?=
 =?utf-8?Q?Ccu5mt07OQit7AjoT7mCxf4GD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ab2987-77cb-4ff4-0207-08dd684857a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:47.4891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKw577zP34+JH28w6dM6mgFOsNMR1lznIkWB0bj5FaXQ+jYZqCKzElR7pqpkhn+Zb3vjZ7LS5FqMZnn95niZZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7421
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

i.MX95 only supports low power boot, which means A55 is kicked by M33.
There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
for i.MX95.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 134e42028c3..f38f3b2d338 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -180,7 +180,7 @@ config DDRMC_VF610_CALIBRATION
 
 config IMX8_ROMAPI
 	def_bool y
-	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
+	depends on IMX8MN || IMX8MP || IMX8ULP || IMX93 || IMX91
 
 config SPL_IMX_ROMAPI_LOADADDR
 	hex "Default load address to load image through ROM API"

-- 
2.43.0

