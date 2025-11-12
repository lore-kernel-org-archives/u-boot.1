Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316A7CCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 14:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC4383CA4;
	Wed, 12 Nov 2025 15:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="d0lZ0lDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6233683CAA; Wed, 12 Nov 2025 15:31:26 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1600283C96
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 15:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBzqHogS2RCTq/oFBL7HSHS/EDystYJM+opouOLp8VWUQy5+JfrHbRTyMvgaaiGoMDdTqbQCwKe925ZZqFsyh/mUU2IoCdDUmC2s1KfiNyPBl9rXaQP+ZImB634nNh5sJ83krNZYN90HGS17o22eO2/YvMrxJ7mH8xzyMM1mmNm61sW/Fls5zlmR7c3Ljp69V7FyoZHBfUDjvCsqkJvPgzpNvR3qutLaRTH8BygUSQHBwnZWYlFnAlBEu6bIv+3R2Y5HmBMmzztIlpvwYtSkyA4pjyY1uoLXh+9GcXrJxaNFT739GVNBlAnW+8naCNEPvDP4bWTEMLjKtifSrDXRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6YmlT2RjPJ4qRD3kFruQvakl4NdOXcJpmdeAF4XZTU=;
 b=dC1awyFW0PjGreHVHX97U2xEmgVOfhq6R5EbFDZopIBLVdl83Pf7CaHE+2H3ujFPWqa08gdwS0Jm6exdEjV9A0MGVR96731e+UdLB/s27VxmotUVXKg3BTUPr3YH1nGd7C6jKb9CvDHbfbPneJ8kI1cSpVqraGhJaNSG/Ln0FdwPS93sOsnYavG4QMBTnnpXZv0DkaXtbuMALQWU9fjssFoSH6huCpNYcZAqaPCTNkCqdpgxOjvV1wVJxF8D2GsNiY5w8+nqgaiQxOM/j1vlDZ7dNYAU0icLn8hRiH0mqcxTwaKZYm4pxpPHoRSKTpdsvbLgbL4UjP+/XLMCbVhe1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6YmlT2RjPJ4qRD3kFruQvakl4NdOXcJpmdeAF4XZTU=;
 b=d0lZ0lDIfh5PZ93MxHCrlW9D7Mqw8/jMh6tyP62LevruzXUqzq+68MrwXYWIwr2ByzeFz5dI5c4wGoXGhXyJGSo62CBeZKQwIqpDKW8dBTElwBwmUIFbcsdrSd9mdJuBcKGECZvG7be5pFzkSkQOzSgm4jUcwmCIjmHaeHf0fSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 14:31:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9298.012; Wed, 12 Nov 2025
 14:31:21 +0000
Message-ID: <22bec0f1-a146-4a89-aa96-f77e22a57477@cherry.de>
Date: Wed, 12 Nov 2025 15:31:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: pxe_utils: Fix memory allocation issues in
 overlay_dir handling
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
References: <20251112131719.98950-1-kory.maincent@bootlin.com>
 <89c8a024-fdd6-40ac-8208-a97dba4f1016@cherry.de>
 <20251112152255.3a7b8ab3@kmaincent-XPS-13-7390>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251112152255.3a7b8ab3@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3d4e58-066a-4fb9-a39e-08de21f82623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2FscGNFOE1qZTl3c1cyZnVMT0ZqSzZ5cmNNNzRVRllRS3BpUWhUR1MwSElU?=
 =?utf-8?B?S0czOUJKQnkvZXMyemg2bEFOc1FZaHg1cDNPanZDRTdMV0F6a2pOdXVkaE9x?=
 =?utf-8?B?RDJMUWJkdXJYc1hwZGhzSjNTR0FnalV3T09NSVRCaW9DMGg5VHZ4WnBPd2RP?=
 =?utf-8?B?aWlYT3ZQOHlsQnk1UW9hYnF6K3RodHp5UVdvT1p3STB1MkFZd3hpTW9aT1pD?=
 =?utf-8?B?VGE0UjJwK2FYaEdqYWZUOThCeUhRekhNdVVqbzJrc0c0NHNvanlOaWlSS1Rl?=
 =?utf-8?B?SGtDS2hYeEdEeXUxaWNvbkRjS3R2bkI3L1FXRlQzdXJkMk96aFBjdThHeEIy?=
 =?utf-8?B?OGhXUFgxSUE4dk9FelZIVUVIWmJXV0tEck9FWk1CUEYvZHV4RFVDM0F1SXpp?=
 =?utf-8?B?Z1JVa3lEOEVXWjBKbys2UzlBWUdVMjFLN1o5T1ZMRGJzNmdSenJ2bnRJZ29T?=
 =?utf-8?B?aEJsdWdwazRhQUV3eU5vSUk5VllHLzFvU09xUFNQc3haUnYwc2JpaVZkSFVP?=
 =?utf-8?B?dWZ3RlQ5NHFlL0F6NS9zUWdzNEtaRDNyaTZBeGk5MjdSa1lleUZuSUJScWQv?=
 =?utf-8?B?RE5ZTm83aENMM3BsTnVwaFZlYTFBaFhtMzRHY3Q3NmU5cS9MOHI4bHMvc252?=
 =?utf-8?B?ampDWkdpc1E1Q3QyVkxadlBQd2JvOTcxS3J6bS84Rk5TRnZtQzFWSG90YUN6?=
 =?utf-8?B?UnU2TERzaGtLQWtGQy83TnhlUnJzazZYVjBTdmIyWGM4QVBtSlR0bzZRV0JK?=
 =?utf-8?B?ZjFzbVd3bHhPdmFIU24xeFA2TXllWFBGT2JxU2FvQzN5ZnV6cVVsUDJ5Q0Vz?=
 =?utf-8?B?dFZFekRKYldvcnA1bWNmbEl6MFAzYTZ6TWRnSXFXa3VISS9ueXNqV2d5Z1pq?=
 =?utf-8?B?dlQ2RDVMZzNpdWdtUThpYUtJNFBBZlcxU0pmV0xla2lOVzhUZW0rcFZldzdp?=
 =?utf-8?B?WW9SWVRULzlkZndpcU1VZ3VONzVoWWRZMCtmcys1cmdrcDdFWWVDbDBpTzhC?=
 =?utf-8?B?Y1l4dklWMWhiVURQMkszbkw5VUpXblhLdVlUb0t3blRBVWJJUmZLUlQ5YnFE?=
 =?utf-8?B?OFg3NXAybURnQnBPVWVhZzV4U2xPaEV3OFZMWTMzSkx4djVsQm13N3VtSkEx?=
 =?utf-8?B?T0ZBRkNqLzV4c0prSHNXSWxwQWxjRXZ5WUFFZGxXSmZ4enVLdGJlQ1JQai9s?=
 =?utf-8?B?R25BZXBmZE1PT2RqejlzYjViSlMrOVNHZkNkMW1YdjZ0dVdjSlBUVGJ1dUFk?=
 =?utf-8?B?L0pqVDYzaW9zNmxTd1VkSzVPbnpBQlhXd2krVVd5WUM2UmRTSEEyaXp1UTZv?=
 =?utf-8?B?TTM3cEZEZnovamN0N2hKUk56RitlTzFmTUsyanRESGFWeEhrQm9tdFJoWnZa?=
 =?utf-8?B?YUZPaUxGb2owQWo5R1ljR3RVQ1ZTS2N2SHVCU3JUYUVDeUJXZXFMV2F3UFBu?=
 =?utf-8?B?bXh0ZkNjeE93OXFEZjhsTHBpNU1pRldqVmNGeEJ0OUZuWjRJY1A1SW5Ld01p?=
 =?utf-8?B?aElCSnlOVXRPWmVnK3BibGk0NUhtUFJLTGh4UU1MQXZVNkhJWk9zQnBNT1N5?=
 =?utf-8?B?ZlZaMzVreHY2ZUF0dGNFOHFiNTV2MndNeGxVVXZTdUlWQ0NyMXd6QWRtUTVI?=
 =?utf-8?B?dGRzWldsU2dvY24zdGVoTkFrcDdCRlJqSGRoY2tXN0srRHZJclUyTGplVXow?=
 =?utf-8?B?SjZBWUl4Nk96Z2NyY3QxamY3WUFzVTZBc3JhVTJ1dEx0YlhvQ09pRVpYTUVU?=
 =?utf-8?B?VVl6aUFncnBpWEhiZWhhVUE3T2ZDOTVFdnNSWFdackFuNGt0eC9tOFBqak1E?=
 =?utf-8?B?TjdUcHNqT0t4cEVZRVpGZll3SldLQ2tXSzQxVE5ranZzZ29EZUJndFJlL2F1?=
 =?utf-8?B?SCt0OUQrQ0tYZFRGSEJPdGdvYzBld3BVaHlzajRSMlA0YWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bld1TUxjL1NiTTVhaFpUWVYrUkU5V1M3Y2pyMGxib0gwYlp5NkUrR3dGanNY?=
 =?utf-8?B?dTg4ZE1JMFpMMVJXRncza0g0NDRsYTk0eHBvMG85Mm1oaHQzMjdlRFUwUjEz?=
 =?utf-8?B?ZVlTdnJiMXBrbUJpRVpCWTZkZERlRUxIWlhNbVlSVGtvT0tYVUM1VmRkOGtZ?=
 =?utf-8?B?SFFXZWNIUlQ4MSs0VUM3UUlJbU5BcVY5aHdnTmV4bGZyS2o3bGNvcGhob2lK?=
 =?utf-8?B?eWVqaERYdERJdHVRTStBRUpNRGxkdjRCVVE4STA4aFl6S2I4TUkvUFI0R1BW?=
 =?utf-8?B?M2tIK2p2SW1BYzd6RzNQblhHZWIvZy9GUkJKMmJmYS9pM1B6VlRuWmc2bytT?=
 =?utf-8?B?QkIrZmJwSmtxbzFrd0pSVXAwNmh3NUdaNERwTmtHMXJUc2JwaHpua0svZHpa?=
 =?utf-8?B?WTVFZHVLM2pybzR6UkhpcGtQV1dWTzR2QmhSYjJBTzh5R25FV2VHZDEySWtj?=
 =?utf-8?B?emtFaXdBSGNtSlJTMVZFeUowR2tUVThmT2dTMU4wdU1UTmZVMlJlajgxOUFI?=
 =?utf-8?B?OHBreFBuS1FZckYvVmtNOUM0Y0FtQUdzeHorUU13WFNPUGg1VHlibzMvTVFY?=
 =?utf-8?B?cW5MN2FYRFVzNlJZNWZwTWo5ZUt5MDVOSEthYzM3MmpqblRXK3REK3RvSW1D?=
 =?utf-8?B?QkhraTQzV09vRHVmdU84Y25MaEwrUnRDRWtGcUt1cVdQTHJIcnhrY0hQWFY2?=
 =?utf-8?B?Z2hXc21Ma3FqVlJPWlhlY1QzM0d0TndITHAyeHNmZW1FK084VHFMTFJCbEdG?=
 =?utf-8?B?T2NWYkZNQUFjNEhERktkUWVOenVqSmtIYWNCUnI5a0VqdnQ1MGh4WXJvUU1Y?=
 =?utf-8?B?NFhMSVZoU1JYK2t4MDM3U2t2R2VNUDVmTEFGTURKaU9FRGZTUDdxUGl2Zzl5?=
 =?utf-8?B?N3UvcmRKRHN1TjlUUlhVNnI4dGRSVE5WdGtOcHV1blR3Qk5QYmV6REJpNkYz?=
 =?utf-8?B?U2xMbFBDbWhpYVd6VnhsV1pERUlsbmtUTGNQdTFGSlk5enZEa1liang3OEZu?=
 =?utf-8?B?LzRVR1NvdFJ4SE9QblAzZlpDbFRoWEtSUUxRdWdIVmpBNjlSa0FmcUduREc0?=
 =?utf-8?B?c2RRNFphcHNmT2Ywb2wzc2NpMjBjMDZJWW4rbUdXYWN4UjNvK0pSckpXMUJT?=
 =?utf-8?B?TjJYL1d2dVBxMUl2SHJNMTdnM0tuV25ySlRWOEVTa3E1NSszZEpRaFRlNC83?=
 =?utf-8?B?eXBoWm5aRVhqbDIwRzcyenV5d0FGYnZDcGhWb1Eva3RpbmZ3TmIzYXBGNlpx?=
 =?utf-8?B?R21DaS9ibE5LMEdjT28zV3d6K2gybjduaHV3SmdjckJwSTBvSGhDcDU0bDVu?=
 =?utf-8?B?TXJGSEMya3VNbWMxVUI2Ly96NWx2dDhnQW5lZVA2bXJ3cEZ4eWNBMWFCT0V1?=
 =?utf-8?B?V09BdmNIZlFzcGpzajhsR3I2VmpHL1JveWVaWVNmaUd6N0RLaTE2eEJwWHF1?=
 =?utf-8?B?S01FQmc2YVE0SXVyV2wxbmk0OC91aFFaYWlRWm9vNHE2MWt5bjU3WldReDJO?=
 =?utf-8?B?OFBTZnhzZmMxcGlyV3duTHZweW1VQWRBRWxoZkVKSWVOV1ExUXBJVnU4OU9K?=
 =?utf-8?B?MUt6b3dYai9uOCtBQjgwZm1mNVI2ek9LQXpTUm5sSWQwcG5KK2NTai9scGxK?=
 =?utf-8?B?NXBKS2NGTWpPR3BlQkZDN0hMOVFEZkh4Z0s1WHE2d2VMV2wyNlZndVFlaFVU?=
 =?utf-8?B?WTdvWGwzN1psK29yc3ZsR3h4QUFsMi9GZlN4THdBZkhhdm1DZURkNFd2K1Yz?=
 =?utf-8?B?eUFyQWt1T3JwZzUxMDBjMURCS1g1R0RHNnFzVTlEWFViODVyb3dHWHNBNkc5?=
 =?utf-8?B?L0hEVUQ3VmdnOTY2REI2bDVsQzdiaUxLcERyM3ByWmhlYmVORlVKVituYWFy?=
 =?utf-8?B?ZkVZUHdTSG9vaXNDcmxRQVJ4Qmtld2hoZFBvYU1pNU8zUDhSQ1Z4MG1yY3E5?=
 =?utf-8?B?RzN3UnVQUjlVOHZjUmZCYm14bjl4SG9hQnpxblM1Mys5d25KWEwzanlCNmZp?=
 =?utf-8?B?S0xoZXRDNUVqUDB0MjZEMzB0QjFrS2VEN3RQajNjVk9xQmF5ZTVvdUlFaHlW?=
 =?utf-8?B?S2lBNDhKaXBXZ1NPdk04NXgwMXBTQ0JzV01FVlBkdDN4WXJkaVBjRjArQXdP?=
 =?utf-8?B?dHJNeGgwK2IxR21QT01BWjAxVHh4R05ma3dySTVsZlo5R051aHdFamQxc2Yz?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3d4e58-066a-4fb9-a39e-08de21f82623
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:31:21.0432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5c55KjorCix8o6eR30b3CxutgR9bvt8F61g89eTwudpnXJrPs/RDcq5gafePwgvgvVHwMkEX7BLIa82SgO6Q6lLl7C+okoGTDBNmhce6K8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9422
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

On 11/12/25 3:22 PM, Kory Maincent wrote:
> On Wed, 12 Nov 2025 14:44:33 +0100
> Quentin Schulz <quentin.schulz@cherry.de> wrote:
> 
>> Hi Köry,
>>
>> On 11/12/25 2:17 PM, Kory Maincent wrote:
>>> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
>>>
>>> Fix two memory allocation bugs in label_boot_extension():
>>>
>>> 1. When label->fdtdir is not set, overlay_dir was used without any
>>>      memory allocation. Add the missing calloc() in the else branch.
>>>
>>> 2. When label->fdtdir is set, the allocation incorrectly used the
>>>      'len' variable instead of 'dir_len'. The 'dir_len' variable is
>>>      calculated to include the fdtdir length plus the trailing slash,
>>>      while 'len' was only for the fdtdir length. This caused incorrect
>>>      memory allocation size.
>>>
>>> These issues could lead to memory corruption or undefined behavior when
>>> processing device tree overlays via PXE boot.
>>>
>>> Closes: https://lists.denx.de/pipermail/u-boot/2025-November/602892.html
>>> Fixes: 935109cd9e97 ("boot: pxe_utils: Add extension board devicetree
>>> overlay support") Signed-off-by: Kory Maincent (TI.com)
>>> <kory.maincent@bootlin.com> ---
>>>    boot/pxe_utils.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
>>> index 038416203fc..7a64b6b97d4 100644
>>> --- a/boot/pxe_utils.c
>>> +++ b/boot/pxe_utils.c
>>> @@ -474,7 +474,7 @@ static void label_boot_extension(struct pxe_context
>>> *ctx, slash = "";
>>>    
>>>    		dir_len = strlen(label->fdtdir) + strlen(slash) + 1;
>>> -		overlay_dir = calloc(1, len);
>>> +		overlay_dir = calloc(1, dir_len);
>>>    		if (!overlay_dir)
>>>    			return;
>>>    
>>> @@ -482,6 +482,10 @@ static void label_boot_extension(struct pxe_context
>>> *ctx, slash);
>>>    	} else {
>>>    		dir_len = 2;
>>> +		overlay_dir = calloc(1, dir_len);
>>> +		if (!overlay_dir)
>>> +			return;
>>> +
>>>    		snprintf(overlay_dir, dir_len, "/");
>>>    	}
>>>      
>>
>> I'm wondering if we couldn't make this easier to maintain by not having
>> two calloc and snprintf calls?
>>
>> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
>> index 038416203fc..6c1bf05cf66 100644
>> --- a/boot/pxe_utils.c
>> +++ b/boot/pxe_utils.c
>> @@ -474,17 +474,17 @@ static void label_boot_extension(struct
>> pxe_context *ctx,
>>    			slash = "";
>>
>>    		dir_len = strlen(label->fdtdir) + strlen(slash) + 1;
>> -		overlay_dir = calloc(1, len);
>> -		if (!overlay_dir)
>> -			return;
>> -
>> -		snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir,
>> -			 slash);
>>    	} else {
>>    		dir_len = 2;
>> -		snprintf(overlay_dir, dir_len, "/");
>> +		slash = "/";
> 
> In fact I think "./" should be the default one here.
> 

It currently is "/" so that would be a third change/fix (to be explained 
in the commit log at least; maybe in separate commits).

>>    	}
>>
>> +	overlay_dir = calloc(1, dir_len);
>> +	if (!overlay_dir)
>> +		return;
>> +
>> +	snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir?: "", slash);
> 
> Yes, that's a good idea!
> 
>> Also, we probably want dir_len = len + strlen(slash) + 1 to avoid a
>> second strlen on label->fdtdir (at the top of the git context here).
> 
> Indeed!
> 
>> Finally, I'm wondering if the snprintf should not be dir_len - 1
>> considering we calloc with enough room for the trailing NUL character?
> 
> No, snprintf second argument is the max size written including the null
> character.
> 

More specifically, it's going to write the NUL character even if not 
present in the input string(s), at the last index, which is something I 
had missed while reading the CPP doc of snprintf (the manpage is a bit 
less clear about that). So never mind about this suggestion :)

Cheers,
Quentin
