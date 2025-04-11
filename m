Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61881C369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 10:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D358D829D4;
	Fri, 11 Apr 2025 12:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="S9QfccNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB69D83E81; Fri, 11 Apr 2025 12:37:57 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B6848291D
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+WhBMnE+zj91Nb4JpngFO1FnfgqdnMddYNoH3AfBxOP4YHT/3z8r7C7E0mxzAknO/RgjVUNG66WJitfGZ/1JEuuiAYZGvQbJy+AhsKDPkLPW81reLa8AbKU79NXg6bjHoA56GZpNl3MZ9ZxUXJYhyjGWnVRnb0Leis2rS38RAQJPV9A18RSSPWEom1Kx3MlUlvaRJPI53iGbiGzN/10mKrd9PtwUTsZw9dX0YRbBmiCtkf287gU2OIgm8m7yz0VTn7EUWi4szStM04G7DXgBW+IAcHFtmC1lV1GndSX0IA18N41P2lDiuYqKL4SSCTaBqzEmcwTeBkjvDv/qw9yBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoUozn6b7a53tkHIw8m5aI+6EGO+yDzDM8uiEdYF88E=;
 b=QJbsaFX0gGa6OGyxbu8RoGPCctRCQrLzmhRClhmNHDz1T0Y42ChTUVWkmF8YDbEPwkn0XXgATV1Nb7btYmmIGiYOgbB8MCgci8XYCJbgtdoKDA9oVYGFKbonma0jSOUFcPnD4XtzFGVp7pxWtW61GLWOpBGGkeiFx03bq9q7wGyWtvRNUO3mHCaZoLbCNPSCo3mZx72jQlaVUuk9Rd2S4zjEdhamcou30DFeS2yXVbWD3hwQQRAMf+Y7JDtTJxelLQz3Z+XslFuxN0q1kBWbKrdFFlqAAktRzs1V5piipoERWteRpBptL9pTwV+li0OFXp1+l7McQogB23C3T742Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoUozn6b7a53tkHIw8m5aI+6EGO+yDzDM8uiEdYF88E=;
 b=S9QfccNKB4EuFoykQTGYFcjYP7OzTj3MPj8gVQqxvbF42Ze79kRHIwpd49A4T9w/Law0PldxZTN9flf8Bf4DNrUhkdPDdeNWQ74PPJFEVcTVlGN0DFEj9fHxsXC4QuiaujVXqBK95B6+YEjOZDrYgUPY1lxfNOsAbf4U8hinxfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 10:37:49 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 10:37:49 +0000
Message-ID: <487cf4de-9fb5-4e91-b178-227e9e3923c1@cherry.de>
Date: Fri, 11 Apr 2025 12:37:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] rockchip: binman: Support use of crc32 hash for
 FIT images
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250410214506.3575404-1-jonas@kwiboo.se>
 <20250410214506.3575404-8-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250410214506.3575404-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::13) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|GV1PR04MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: bb492275-87e7-4396-cf99-08dd78e4e7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXBrbmIyOHBSalVtR2c1L2N5ZmtyWDdYbjkraURNZDIvcW42ZzVtQkhtTENP?=
 =?utf-8?B?cFJNVjBwSVhCTWY5VENzTkh5N2hUTnBVa1M5WEc4ZzJzQUZXY29sWUpIL1dh?=
 =?utf-8?B?OGdCcW1xRTBFL2t3TS9US0lZYnJwck1zcjJmSWgxTUZ1Z0N1Zzl5NXluVm9N?=
 =?utf-8?B?eExDS1lmT3h3WFJFcm5adDFnOXFzNWE0c1BkUzVDR3QvYXYvSkhLSGEzTmor?=
 =?utf-8?B?QjdhZG85RTJwVVk0di8yOEV0T3lqdS80TmZsOEJwZkJsQzBXYkc3RXAyemVM?=
 =?utf-8?B?aVMrL0VVek5jclo1c0M0di9aaTFzMTJMZ2dwVXlkckgwSGVieDhTOU5ld1c1?=
 =?utf-8?B?TnkwcGtPU0s3Wm1hQ3NPSTVDTU1ac2prQWlxV0ErSlF1SERyRWFXbWtOMzJl?=
 =?utf-8?B?REhSVmpjSWp4eUw5SnlhRzNmSkRDWW9HTk5BV09qeGlxT3pteEdHZXlxMFFy?=
 =?utf-8?B?bGhZYU5zUWlCc2lzY0lEVHdWQ1h3emJyOEk0czh4SVBUSThBaVdHdjUydEZi?=
 =?utf-8?B?UTRWVndoYk0yWTZJUlgyQmF6aGRoQ2h5Y1NDMUtiZytWUG1vQU5RRnZWMnA1?=
 =?utf-8?B?cUVsVkdJYzIwSTg1T0pXL2hDSXZBbVJoa2s0WnNFNFh4MGVsRWV3WUMxSVBY?=
 =?utf-8?B?dytydzBMbjM0T3FVMm9uV0h1bzExMnQ1MXNESTlxdjcrNTlSbmt1cHpYcUwv?=
 =?utf-8?B?UFcyWHd4MVZHcmREaWJDKzhsUlJBYnJDNmp5cE9kNWZkNEJVTmtEQnR0YzI2?=
 =?utf-8?B?U2k2YXlKa2c1NWtZYVZaRE1DYlFSUTFuRUd6ZkVadXYwWmZwOGNmVGo5bXFO?=
 =?utf-8?B?dFFQb29hcy9vYWRBSkpDMytaeEt4SFlBTlNJSzA5WmNmV1JnKzJRaXNSbXVa?=
 =?utf-8?B?WTdEOHM0eDAwcit3WEtWcG9YWkZrcFVpWVpDWWpVeDFhWEZTWHo1MmdVSFE4?=
 =?utf-8?B?dWRhNGRDZkdWK2duV1lZdm9VcXJiSjdVTWdKSmh1TEMwV3BxL3BzNFJ1czJV?=
 =?utf-8?B?TjhheitvTDNhNEhRSzAyT0tMRFpvRDZBSDlJV29RWDl6YkFIVUQ4bm1sUkY4?=
 =?utf-8?B?VllJRThFZWgzM21uNlRnVHJjUk5YV3BaWlFlY3BlVURyejBBVGNNY2U4WFI5?=
 =?utf-8?B?Umtwdmd4Qlk1RlZyTnA5Z0ptdEl1bTc1alVnM2JGSnJoZVlnMHgwcUZaT2pT?=
 =?utf-8?B?UkgrdjRXdTdhRnhNYWhzMCt0aS9GaWx1NmZrRXY3d2p2Y0hPNGJycWFwVGxB?=
 =?utf-8?B?b0QvZ2VVT1B5ZGt6dmZScDh0YzRadGVML3RZYTBtb0c4dVJXcFRYRVNsU0Q4?=
 =?utf-8?B?WERPNSs3R291SXhTSGJ3b3FoR3J6aGkxUUlZdTdRajlXdjgzTzRUMHR6MFg2?=
 =?utf-8?B?a2ZBcS8rWUpHRVRka201VXdMb1lnSTBsY09KNUJIUmtTcGpnalpnNmtZUTNs?=
 =?utf-8?B?c2dtVlJ4dUs0Rnc5N250cysrYmdLOWprWEZaaXlLYVZHdHZvbXNBWHNLYXZF?=
 =?utf-8?B?bFpncGpxd1c3ZWNFeXpvanN6S2VpRUpVTFhtWTMwTWV4dHNOVTVpS0RvU2M1?=
 =?utf-8?B?V0twTitOYitLMHZoNUl1NUY3eTdJc1hTSWpoejI1YzdLbDE5bCs0V2I5VWZY?=
 =?utf-8?B?ZlBEQkNudXZvei9ocE1LUWdqNS9ZaGFUTjh4enhEMWpGd2N4VFpjZ29hMmVS?=
 =?utf-8?B?b2M3cmk0VFF2d0YzaURjc3NDejZaTWZFNnNhcGdNQVVlejRYc1QwaWI3clRl?=
 =?utf-8?B?M2NQbnROS3MwY1J6ZjVwYnBHRzlnbTBsbEdFMFRxaDhkQkhJL2dLK3FPMmZP?=
 =?utf-8?B?dm1PU0ZUNU9IT2ZkeWNzOW9HUHdGL3ZzcWN0aVlqR2VwWEFPOWhJSnU5ZjNr?=
 =?utf-8?B?RGJ3aVBCNGRTSjRMbCtEOVBYajBVMFBaL1d1RWFaQ1FaejJxQUFSMXkvQ2xx?=
 =?utf-8?Q?1XkAAasLPys=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGRIcnpJaFhRYVkwdW5HYlNYalM1Z3o2cTkrZ2U4VW9nNkJzZndTNVFHQ25F?=
 =?utf-8?B?WnNYamt5MkpJdVp3REt3aUhiKy9jLytZeUtCQmNwWGVwcitWKzJ2MWg2RnBC?=
 =?utf-8?B?Y2pZUGh1V2xRVnF3c3NLQzJCRS92bjFPUUpmd3FFOXkwZlVYY2ZrQzBTR1JL?=
 =?utf-8?B?WWpuc05oZDVnVU1KZTdZYTRqN2VwVnBXU0pjVkJSUGQ5WHVIM2FNN25vU1pi?=
 =?utf-8?B?RXJ3VERDWFREMm4ybmdKamxvajlaa0xlUVFmb2lNY0ZvbkxyTU10MU5nUExS?=
 =?utf-8?B?dDNhdmxETEtuV2RoSUhManR2dWxiWHhKSkYvWU5ObkR5M2dQMnRmUDBaTDJN?=
 =?utf-8?B?T3BwQmFZUmR3alphcEFOVytXckJrQktBcmNsYlZJbU5vZ1BQMGErNFBzSXNJ?=
 =?utf-8?B?QWt4aS9tR0w1TUc2aGlyVWp4ajRFV3p1dUZna2JadEVMQnJYbEF3ZWNZWHZ1?=
 =?utf-8?B?SEhvK2txbGFUSW54TFZIUmpQSk9ZNTZ3S2JnTGkzQjdnbUxZTWdGN1JQajRj?=
 =?utf-8?B?bDFsYWU1bjU0UC80aTU1Nnp1ck8rTEowY3FtVDYxTFhkbnR6d3l4dmkwTU9v?=
 =?utf-8?B?ZTVPcTllV2NLZUwyTFFOR2M4SVJBQll3VDFWSGFBK1Y2Y3Y1SnRVc3FKMkV0?=
 =?utf-8?B?MUI1ZE04dVJyaVpjcGhtN01qMEhlcFJoUVpTU3p3OENOTnVKanhBR2VtTk9I?=
 =?utf-8?B?TG94alNNZy9KZEFkTURHc0xPeS92VkMvZkpoMVRpclZDZGloK3JkTmdjUlhN?=
 =?utf-8?B?MWFXLzlrTjkydzNsVTRVVFdFWDFCQWsrSkszMk9xdzAzVE8xRk9vVUVPeXJL?=
 =?utf-8?B?WmxoVHhRbXpaczRrd0liSTdZeUJsR0pxalhIRWFQNW11VVZYWUdLdWNVV2R6?=
 =?utf-8?B?MlZ1d2JSZ2VXMWlwZEl1ZklUZGUvbmc1VU9zL1pHQTVtby9WY0ZJQXpQcmJB?=
 =?utf-8?B?NUJ1SlV1WXNyWitYbWN5clJVcE8yVjdZcUlSMVdLclpQQzlNRk51YjNseGUv?=
 =?utf-8?B?K28xMExQT09FTE5RNjR3czA0NE9wdkR3WWp1Q3Q5U2cwTWxiM2doYlZuNFRv?=
 =?utf-8?B?RXFrcG9PVFRpVTFBK2JHRmY0YVZweFZkWGgvS0I0eFE0Uk92bmQ0b204V2E4?=
 =?utf-8?B?SEp2SUZVUjJoUU9DOUJIV1lrZ1lUY09YQkJubmZ3cjVzWm5Gbk1pMmRJOExX?=
 =?utf-8?B?d0RCekZVUkVLT1c5RkdGOGpDeDdNZmJ1cHRBN0RWTldYWlBKZlpuMWRnaTlV?=
 =?utf-8?B?ZGI1Yi90QWNLMlp4OGFTZFZxUmxaYitPL2lZS0V2RkVXWE4rTERKWGdUV3lI?=
 =?utf-8?B?YWVEMG1zVDR0NTdxNkh5UlNkZEtmWkpMTmowcFhESUxaVXBJOXdHaUZFSzNp?=
 =?utf-8?B?Ti85aUd2SnozVnc1SExBMXl4TUFJcEFaZkVXekZ4dEpKMGM4WCttMTdNanZS?=
 =?utf-8?B?aGd5NVE2RkxjTFZVMDkrRHcyN0JTWWRVeTBKZXhpZFhlSTBJK1R1TDBzNE4x?=
 =?utf-8?B?eVI1L1dhWVFYL0owbGh4REViZ3hieUp5Qm4zdmVSN2RoUm1tWmhiYjQ2TVlh?=
 =?utf-8?B?OTJ0M3pmTVFnVjdnTUdwNk95TWNzR2tVSHgweXZtRnRLZGpuTG5rOWtubEIw?=
 =?utf-8?B?YmhMOUJHWnRUckxvUjc3TXBDMllsNzY4V0RvQ2swUjNNUXJFTk5ZTXBFTmp3?=
 =?utf-8?B?NUYzcDhjUCs1ZlloQ1NQR3BUUzdWZUxRRmRnN05OZklkS3NkUVRBL2JDZEl0?=
 =?utf-8?B?V2Y0VFhhYmxsb3Q1OXdJTVBtZVQwUllBVzVJTWpON2pkZFVOODQvUEJadThj?=
 =?utf-8?B?SzIyeE5CVDhlK21HR2ZBeWR6d0d0Z1FXUHBTanZVNE4vT2tYamUrYzVyV2FF?=
 =?utf-8?B?VHVNK1U1RnErVXo4aGZQcUpJd2wzclBkelBYT3hNNGN4U1dlTW9Lb3gxRExz?=
 =?utf-8?B?bllUeXFUejhsdW50VHlqc1BRMnRsZnJSSG9pYW42aGNLOWh4ODYzeVRSU3hl?=
 =?utf-8?B?KytoYXh1VkF6MmN1VHB4aHNBQmNKS2NIKzJwbGRSN01UMGIzNHBDK3pNVHNp?=
 =?utf-8?B?LzVXZG13bGQ3UHhQTWVUV3M2US94S005NGNTaFNyU09YOW5jYWthNEZNYXNm?=
 =?utf-8?B?Nm9EU3pjMEpDdndRZUNVNENZeTlIVXBSWVdoTFJuUGlHd1NwVDhGSnJJdzlr?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bb492275-87e7-4396-cf99-08dd78e4e7bc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:37:49.3679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exwbAKc6aaKDzzBDv06G1arDreImSO/2Z/QraDqj5aHtEXZVEwIzR/w1tN9itEkIzCgkxjSdtmNiQ6OFjR81r9YMOSPmW1pc/zftNI/5Aho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9183
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

Hi Jonas,

On 4/10/25 11:44 PM, Jonas Karlman wrote:
> Use of SHA256 checksum validation on ARMv7 SoCs can be very time
> consuming compared to when used on a ARMv8 SoC with Crypto Extensions.
> 
> Add support for use of the much faster CRC32 hash algo when SHA256 is
> not supported in SPL. Also use a HAS_FIT_HASH to simplify the ifdefs
> when no known hash algo has been compiled.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> Changes in v5:
> - Update commit message and add comment that CRC32 hash algo should
>    only be used for basic checksum validation.
> - Collect r-b tag
> 
> Changes in v4:
> - New patch
> 
> This patch can be skipped in case there is any objection against adding
> crc32 as a checksum fallback algo, something that will be usefull in a
> future rk3228 related series.
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 34 ++++++++++++++++++++++---------
>   1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index f60cc31fb1a6..18accef8bd44 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -19,10 +19,24 @@
>   #define FIT_UBOOT_COMP		"none"
>   #endif
>   
> +/*
> + * SHA256 should be enabled in SPL when signature validation is involved,
> + * CRC32 should only be used for basic checksum validation of FIT images.
> + */
> +#if defined(CONFIG_SPL_SHA256)
> +#define FIT_HASH_ALGO		"sha256"
> +#elif defined(CONFIG_SPL_CRC32)
> +#define FIT_HASH_ALGO		"crc32"
> +#endif
> +
>   #if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
>   #define HAS_FIT
>   #endif
>   
> +#if defined(CONFIG_SPL_FIT_SIGNATURE) && defined(FIT_HASH_ALGO)
> +#define HAS_FIT_HASH
> +#endif
> +

We could spare a constant (HAS_FIT_HASH) by simply reusing FIT_HASH_ALGO.

Something like:

"""
#if defined(CONFIG_SPL_FIT_SIGNATURE)
#if defined(CONFIG_SPL_SHA256)
#define FIT_HASH_ALGO		"sha256"
#elif defined(CONFIG_SPL_CRC32)
#define FIT_HASH_ALGO		"crc32"
#endif
#endif

[...]

#ifdef FIT_HASH_ALGO
hash {
     algo = FIT_HASH_ALGO;
};
"""

In any case,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
