Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69164C8303F
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 473C3831D3;
	Wed, 27 Aug 2025 09:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QugIoH3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75FF3831C6; Wed, 27 Aug 2025 09:35:16 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FD5B83189
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOGuRR2Frklv0SaF+3zbmMBsaDpQ6+3Bkcc+FwWyeBjpSfrNU9vWq1xCeKHM3S4POP/fPDFwi9Sp96gTCy4hNYQye9DPklTccBDf62mUXZo9vQ9dr0qw/1q4tTWGOH/l+9cGT7zXIFb+hsY2I3jTYyctDu1VHnLIV91S2HN3zMrTcsXO/pFXpbVQ5REICwbckzqC6Y+IpgydPViUGg9QBZHmfaVKEnj+at9z1DGPvVnpH4SGxE2w8votAuCBNn5sIqfbyvdrbQHWDuAduEgRqrqkYOYKbNqGgKY+cfIGHYQv6yMZkYJzuFQPLi+Tavpmmbbr1LBSeqB8QHPFRsK20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M29mRwzDl47ugFqz5OEK6AYT6SJcUcYFnjP6moRSJiY=;
 b=DgdngpZLA5jLQ7GxLSk1lnSdyiOlcY4eAmdSBuUus96zy69dgnoOGlwueUedMOwBAdWkrwEqFv6psF9LomCKM5UYC6Psub+EGpBflZbueLZBBts9CRZfC0RyPCBpT0UWyqktz3uJYH6R9BCypd8L3k3aRpj5WRSZxpPg6f8+cbsE0GOBimnmiRC9HLoqankByvRfWHbg01d//ssm6zgoAQUOUGA9jInuNl+9XiQMzeytcHi3STVZNsvk3Gj+x2OUUS+njRQt8+U8znbXlJUe2v+VIS5mGjBA+qcUpv2YDgf3EXXbsL8TgwHlndANnlFS6XIbARzCF1sjOuK+suy75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M29mRwzDl47ugFqz5OEK6AYT6SJcUcYFnjP6moRSJiY=;
 b=QugIoH3QyVunxFGV9COuOD+L365ADyb08zzJCF67x3pem/riKYmkBzAYen4v6R8waCNuxnx90uppQ0aKsO1WUuVp6tH75Dhz98TzoVCGo3zULFcvQJ/HmseUvux0TXfQLrWgV64L1ZkkpGGWnDDF7aQqhxgkWuQ5LO46V0vPOEl1sFcOpDtiTpJzzVCglEBvXG+0WUdf8Z4Nw/JzCzRCoJFF9EdWkDFO4Jrgr8J60xBMgelyH42hbMC796hCf734GpudL2GfG0l6O3gTxafgSrOCFycS+82Ev9fipaApwhRmB1K4Vr+hB4BmIwbl4O3ucfA2ZndGHNxy0PAOcVB2iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 07:35:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 07:35:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] ddr: fsl: Provide initial value for zqcs_init
Date: Wed, 27 Aug 2025 16:46:06 +0800
Message-Id: <175628406771.4168.1060412649662621686.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250724-ddr_fsl-v1-1-cedcac10dddf@linaro.org>
References: <20250724-ddr_fsl-v1-1-cedcac10dddf@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb712d1-bde2-4b77-fc12-08dde53c418b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3djQ1ZHM0MreHZvMVdmRVhqb1JaUDBCSWpjOVV5U05QMVRsbHZscENRM3N0?=
 =?utf-8?B?eXVFNE90UlRreTAyWUpWbWw2LzQ0dzdzUDRXZWFjTnA5Rzc0ZU5nRGVVUDhQ?=
 =?utf-8?B?OHcrcUYzb2l6SERjUHhKaVJXczNieGNmRWR0UHpNeHVGem0xbFNHVlRNQVRN?=
 =?utf-8?B?QnJtMVMrZVp4aTN5K1FSYmxNYnpGUjQzVUNvWmFUdXFRUmFEakNFcnJ0dkRG?=
 =?utf-8?B?cUxtQXlhOFVSc1hxS3RoNDBDU09vYlZTcnZXTXFXQ3pWUC9vVWVqNk52b2Ra?=
 =?utf-8?B?SGZ6UGNEajJEdUg5NmlZdyswbWxmOTFURXN6QVhxdUlncUg3QVRJSkV3WnE4?=
 =?utf-8?B?bjlaM0UzMGw1cW82TlJldVBDR1Q5U1pHdXA2UUIxQmJ4NjdkdlFJSlU1aHZR?=
 =?utf-8?B?VHkzd1hPUnU4NEc3MGYvWmZjR1pBTlV4azFEL3VaUmtybzJJQXd2RGwzYi9M?=
 =?utf-8?B?ZkEyTVZ1OGJCdHZ3WWdjMDM0dWJiYWFjUVZrcnQzdkkvRVZEMUVNNkllS1kx?=
 =?utf-8?B?T2dzaFhHRzZiSGJNQ1RndTFoQm4zYlNJZStKc2xyZ09kalFuV2I5WVFlY2hK?=
 =?utf-8?B?UEp6R2x3K2dZbHErc3FRVHRhZG9NVVpGVEV6Q1VKT2VuVUVVckNLTCtvaEhY?=
 =?utf-8?B?djNlV05HdmNQa3VTUG83VForV0NIeHdvQU9lcVpzQWlHazBKMkY3SGxWQXc2?=
 =?utf-8?B?L2d6eTFRZVFkek9uZnVLSEs1eUlXZm4wUEFwSTIwcXVOOW0zVnFNU0pjRnFs?=
 =?utf-8?B?bmFFYy96K1oraW9ic3NLMDhXTlJqQXRHRTRWWnU1K05QZkZQY0sxWHhqc2lz?=
 =?utf-8?B?aTJkdmZBWEJEZzhKOXFicWJJRWsrYVV0cDN1ZWJIMG9ISHBTTzV4YTZmSmIy?=
 =?utf-8?B?Q01TSTV0WTd5N25wd2c4TjhPUDU4Smd4b1BndXlTYURYUk5USW5CLzJoMUp0?=
 =?utf-8?B?ZGkxcVR4Sm1iOEcwVHlPVGFONXR6clE3RG03Y1p2VHRmc2lQZjI5K3JUYWUx?=
 =?utf-8?B?amxCelh4L1BmcUlVMmJ6eWtkS0Z4N3VMM2tpSnp4RjlLZThJakNpSXJvbCtB?=
 =?utf-8?B?TmJuZ2RmZTExNW9wNG1OdnJXbXhaY0pnWUloZmFzS0l6bEVRSnFQdTh2dG9K?=
 =?utf-8?B?eFJyS0NpSEdwS1RFcDRZTnRCWkRtQnFFYm9hMXNHT1psWWFTLzlFamlOTWNH?=
 =?utf-8?B?UTZ6SEJTL3NhVGdFS0YwTWJmM2xzbjI1cGY2SDVidHY2UFY2UjBBVHZ5aEp1?=
 =?utf-8?B?dHY3bGs0SGpOMXdHKzVzRDQ4RG94UnN2ZW14VlE1Q20rWUZHRHh2WFhPaFZh?=
 =?utf-8?B?SHlyYktON3R0bXYyNHRiY05xN3djVVdQYkYwNkhQcVhsV0Q5UVI5cG8zNHI2?=
 =?utf-8?B?RWdBTlNFTWpyR3VENjZwdWVzMWhXekJxNHBtQmdLWWNLSmIyQ0R0bWdPVENI?=
 =?utf-8?B?dk50VFNtZTY0MDhkdXAwTTVON3FYY0tZOGd1UHBzWlBhU2U2MU94akFUR2lo?=
 =?utf-8?B?K21tUk1EWWxDbnVCY2o2SVBieWtPa01SeDVVQlNJdVVoWmlsamRqbndVSU43?=
 =?utf-8?B?YVZGOHZDWmN2NEJ6RVdRemxOMlI2Z0dKZEZFRXZOa2NDcTBzV09wa3Rjbjlo?=
 =?utf-8?B?UEJRdGF0VnhaSkh2RXJWaW1TbmNqMm85akhsMmRkanhMbjh4eUNuQUZhNmtE?=
 =?utf-8?B?SlV5cE1TR3ZUNHVkRitKVjdvaVlFa2dHOFBYOEVkU2FPeVRRT0JqZnVRNlJw?=
 =?utf-8?B?a2NKM2s1N2R4bDRJQ3hJdDkzSlJNVGdKWXRwcGRoVTJsdnR0QXl2RDIvN0x6?=
 =?utf-8?B?NDhmY3RjekV0RTBBQWl4djRJSTcwMTBMNDcyV2o4TUJyem9GeHRMUm5wSmFG?=
 =?utf-8?B?MXFod2JKbW52dXNoNDF0Y0RJUnVMUnc0Zm9IaFNvOGtJcWJsWk90Tk02WEhJ?=
 =?utf-8?B?TS8wN24yK2RDVUJhY0xCb3I3NXhBU1VUTXFOREJKQjF1VjkrVnZiTmdaWS9J?=
 =?utf-8?B?TThyM05jYXVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akpCQzA4M01rbVBSTEN5T1FkbUUxellDRlp3MUc5ZC9sOURDb0R2cVpVdmh4?=
 =?utf-8?B?S1JLdDlIUVkzUlVzcVpNaGdveDhkWUh5MkRjczNHVEFPUWlzN1R4S2JlaVJ3?=
 =?utf-8?B?cFFFaTUxVXYzOVNXK0tmWERwMEJiMnJ4cDQ4LzZEV2VGMWZidzU3Q0psMHFY?=
 =?utf-8?B?c3RJeXdRTlY5c3NlL3RMSCt4UE10dzRYdDB3TFVBWmpyN0ltb09SWFNNOUdv?=
 =?utf-8?B?SXB2ckptR2pHZkdnMWhCcGxLaHJnaStTVTV6bm9iVkNYQzZGNWVBeVR2eGVY?=
 =?utf-8?B?OExzbWN6WjRIZGN5YzhjbHR3QkNkNWZjczJyU1BXdDVRcUR0Ui8xWXlPQkJz?=
 =?utf-8?B?Q0FxY2tidjJlUU1RUWJhTWEwY1JaSUxJTnpmYlduZ2REaEc4VzdHWEt2SFRM?=
 =?utf-8?B?am9jRHV6UDFkeU1xaEo5Z2FvTE1wbjRrejVJNGJRT2liWTNNaFdnTVYrYUJa?=
 =?utf-8?B?R3RVaHlUWitMNjdZbzFxUlNLMlRFNFp2d0U5WkRWZ3VkcGNoVS9jcWpUb3gw?=
 =?utf-8?B?eUZEWDk3ZUpwS25NKzdVUHRnREJLeFN2UDZJZG9GOXlVbEJFUFJ3QlE3Q3Q4?=
 =?utf-8?B?N2hMbmc2K3pSejFxaTk4QVNMdkN6TGdRWnlzOHV3bmNkdlMwS0I3Tlc5YVJJ?=
 =?utf-8?B?OTB5NFp4c0lIU1UrT1dLRjBTbFV3bGpWNE1LNENtYU0xaFlTLy9NUWZ1Vy9B?=
 =?utf-8?B?OXoxb2h6cjFBdHhPcGZ4RVV4SjJrZDJkOW5VcXlzQ0JTY1V0aWxQMENUaFhW?=
 =?utf-8?B?OU1oU0VzWWIvOTh5MzR3aFYwTnNmN3NoVnBtWGdXMWE1ZE4zVGhra2hMeGd4?=
 =?utf-8?B?ZEZRRkNMY2tzcWEvU1dhMld1dndXdnFKdTN3NXhYY1JWNWs1cys2QzlBNzJ6?=
 =?utf-8?B?SUJLK1J0c1JtdDRMWmc3K0x4MmhDZjY3eDNDbCszcm55YVBLdklzVUJiVk5t?=
 =?utf-8?B?S0R5OG02ZjI1ZHdObmQyQXlWQVB1a0NvdERDcHpValN3eEVUTURZUmRSUEN4?=
 =?utf-8?B?cEJFNXB4MWsyRnpPcUJxWDhOYkpXTlk0d2xKMldySHQwTTdrRkxXT05KaVhY?=
 =?utf-8?B?TmViQW45MzhMLzRjRzVsRWlXbm9MRlMxeUpuTTVtNDNxWGNFaGJ3aWlQcjls?=
 =?utf-8?B?Y1FmOTdKTkE3MWQxKy9FL1BlVm1OaXRsQUE5RXBJUmMzYk1vM3ZnSXJhVHdp?=
 =?utf-8?B?dVhQMTFnNCtpbFpQY1hQT3lSS1FBSVV2Qzk4U1VYM0JMSSs5dmZIMitUN25B?=
 =?utf-8?B?UmVaNStGVGxJRzFpcWtzUlAxaVB2cDM5a2hVSkYva0VPdW9RWGR2WW1NNWZn?=
 =?utf-8?B?MUZQTVU1bElCa2Y1Yld4S3AxdmFKWFpENmxranBkYzhYK01zZjFyZ1dHTDNm?=
 =?utf-8?B?MHdxRVE4WWUyUDNzMUQ3R1Z1eEE2cFBLd1dMOEV2UnNaYXhSd0d3c1ArV25z?=
 =?utf-8?B?eUlGcktIZnFuSW9IZExNY0FaS2NZNC9YZHVpMXMxYm1NdEdXZTBnV3F1Qmdo?=
 =?utf-8?B?cURZVU1PK21EN0lWVGh6ZkhQZXVtVWtrejRsOGRFSW1RQlVFbFIxakFZcFBC?=
 =?utf-8?B?a2t5YXlSU0NtcWkwNHpmdFpWb3hTNkhRQzFHdzlZS3RMOUV1OSszbE1UNDFr?=
 =?utf-8?B?cUNNMy9oVUFWRTVQdnBZZDJvTHpSazVRL2YvSnVvaGpNKzRYYUNGL0N4Uldk?=
 =?utf-8?B?c2hFRWJ1TkVjYnVpN2xwVE5RbldjU1BNaTVUSTQyaVczOFNHdEdoZ1lscllr?=
 =?utf-8?B?anBVTlJaWGZ5Ty9tQzdZUGxYakJTb3N3Yzg2RE55WXRkQ1FpMnQwU1Bjc21l?=
 =?utf-8?B?NWpCVzdjQTU3NEtnaHZoWmxvY3V3cHBOQmZET0hVMklaV1hBQUxzbm0xb0hq?=
 =?utf-8?B?Z0lSbEZqT3dFSnhLYlhYaFhERGNITWdrSkthWUR0ZXRyTjlldHNRN0pRN3Zr?=
 =?utf-8?B?emhFaU0wai9pWFRSUVR4ek9QYXRGd0t4ZmxYaEhrSFpzUk51QzBVZEJxS0lN?=
 =?utf-8?B?eWJuM3BqU2Q1aDlqblUwVXZvbFRKdWZhaTlVVURSZS9ickJRM2JKQ1Q3ZFBS?=
 =?utf-8?B?NnRYRWhTS3c0bkV0M1BZYWpOSzRCZTVKVnV1dmowQmNROWdZQ2ViN0lMdFU3?=
 =?utf-8?Q?qgIuudD5plzN0sqHIuJLXRt85?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb712d1-bde2-4b77-fc12-08dde53c418b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:35:12.0596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUEJU9uIoKEAcV4fyv8hR8mI7Rf/Qzv33QY5zMOH4Q+xx/0I9JfjDHcv4wo2pUIpQkPLYiD9CmLPmYUJ74x0Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687
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


On Thu, 24 Jul 2025 16:32:55 +0100, Andrew Goodbody wrote:
> In the case of !zq_en zqcs_init is never assigned to although its value
> is used. Correct by initialising zqcs_init to 0.
> 
> This issue was found by Smatch.
> 
> 

Applied, thanks!

[1/1] ddr: fsl: Provide initial value for zqcs_init
      commit: 377159bfb8ee35ce16200818cfa55cdfba8c69e9

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
