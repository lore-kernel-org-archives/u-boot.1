Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA50C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E680260A98;
	Fri,  7 Aug 2026 14:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z7WrQBS6151D; Fri,  7 Aug 2026 14:30:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D692260A77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786113059;
	bh=zOmcAQclXNysBcWGN3elRU1xgEAma1qDbqb3Zad4Cjw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nQLIMbxCajmGy1MnBVK3oqvqv+LBy06TY7jebb/CBUi7TNE3A/NaSkr8B2H7jDT9Q
	 NAr4hn7WHPQKwm9rZw0ExxIElnTmdMdRGoTXygD6b39IqC8xAJ/OpP4MWXNeA7j7j0
	 OjQTH6c3kVcfrofFozWMqk5glV+hAUC00AoPEMKLkKM9j30M9yBND9j/4nahDga+ma
	 JFj62mgsFTSSwAjI/jelPyUvLg15JzGNgxOEjw8jxRZNdFX+dJ5fLwj81aaM2LkK2h
	 UTJg+2TrKt/3bJR9AwKy9j4kM0NUmc23ADP2dTsqRUSMWy9C8AQoBder9JkRdghCGo
	 Td+u+n9Hw+7HA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D692260A77;
	Fri,  7 Aug 2026 14:30:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E37C7282
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9FFD40244
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XPk-pXbOpuBj for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 14:30:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5C37E40074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C37E40074
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C37E40074
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IN2cHwnDt9rX/iobge05qImoSeqHrPrt1VHZsqu55gPFCJZet0Cpys7f+R18q/cZlLwzKg0myHMxXoXBRbdhb0EO+qneSTsuoB80K1ZVeUndWQVQs3xFKjvAMxOB+Nyd5DeIgBnheFGhpW8MP8EAflUHBmvYO8z87RUl/Klh68Xjxcc5x2guW9Uh4QhzRH8dbYfWgwaWNzcXQYpTAPurbgQu7pPG/r/7k1tIpeVNWQM/x3CBwLI3D0tXex7/MWD6jhJFdBRwvQ741dtTCOSFuwPU2x7VJRkKygTNOV4x1mff6aVrz/kh24O0HC6gylk/Jyrb5qVtz/LjxWNwnCbOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOmcAQclXNysBcWGN3elRU1xgEAma1qDbqb3Zad4Cjw=;
 b=QFQtQELvo6ok/i+pH77dJNuhnAxmqNfJPycx5QneSZ/L8mMk41ydyBDiSK3NOOgDnCdkIfMYAloo4/hzPJTku9RcfysoabswQYXalQUVHu3nWJORVlP4SYrv82+euo0galyzpgow9ft9aYEesWFqYuP0eKAHpDeqZayP2qxOtFHCpzHDpGMpreKQ2YA8QrXLh8K+K7KPh5A6LVPOcsiHgzYZ44xPJd1wkRS2jnDMfLTXqZAakK915k/cV5/RzIpv6oQCKQrbiQzcql7kTxOiKrB5uzlU7e0+O5Uh7BVi/uVG5PKdbBwL6IgetpHnbTBlLvqiLBdZVMXNnkCWW/QT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AS8PR04MB8579.eurprd04.prod.outlook.com (2603:10a6:20b:426::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 14:30:49 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 14:30:48 +0000
Message-ID: <e1ce88fa-31f3-4907-bcb8-f2774d3e2e51@cherry.de>
Date: Fri, 7 Aug 2026 16:30:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] clk: rockchip: pll: Limit special rk3588_pll
 handling to RK3588
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-6-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0007.eurprd05.prod.outlook.com
 (2603:10a6:803:1::20) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AS8PR04MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f384aa4-e005-484b-3900-08def490797a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 8X708jhaoHNX3KuSNjQ01BxSTQsUY1ZRy+sbE1n931qtAhPBJFngVTF7s5rx1ciO0fYT9B7Zmel3P1GyJO8shsBPdQNh0n+dPPbRhErWwRCycqTqwweq83UpoOXEe2hpySRKDzBhzCVwvW3gRpS1sE/KVYUpm/6tGmZ78DMc1k7GVlRKU24BtR28URxCjxI05K0GNC4dH7KxHSqgNRHSWrbORIGnDxd9lSyeM7+d/s7yt5sNwGS13uh+IaG6WFMQqjXjXZcrxKYJpe5yOWCDVZbPQXdwu9K3zNP03Q6WvnZ82y45NnGdXF2c2wmxvUp1WN5zxmN5gnurB8wqRbiCCchhX5WnYuzPsN7JFlIQCREj5fGsJ/fO/80Uu/OaQCugkbA+x1eZMQLFG0+kR8ptfboWmQS+uh7I3m+J7s73sPgnYE04xLVtBt2oW8aIyfDZmLZfgKpiJAHU5YEDQ4FaKGNQ2fv0l4ViZpdf2htWE7tftBitOXCPSgrkvPJWhPUS9Zhd0LQ+HjEL6HqV5Hwp4ztpQZ1FsZ/pygBiPpyTZFp722BfbUUCVkL8TkGy6WAYuOGHYP1igvCQKH9O924sKXXZyuzVxHWz0w767ddoIhvMMG/foGRCWb3jZG7c1ZlnqbtPUF/u+HXVlYWL3iErboXUnv5oos1nyauI9Dyo/wI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGFCYXNvSHNoOG1mM0ROWFllbmFUL25nQmE1bjVONUsyUko1Mi84SVhqZDFp?=
 =?utf-8?B?VWFta1FQRStNL3h5OG1XQXlZQ0xRcGxHVnRFOGdVeFJtR3hiS1dkZW93cGIv?=
 =?utf-8?B?RXJIV2NwT2dtWmdYYmQvVmd1bUd4a1k5aVdLdkxMTkdXb3A4YVhBRTc0bThh?=
 =?utf-8?B?T3QvOHViM2NYODl4SUVsbm9JcE5xdUE4dWlONlFyTjFONkRHV0FYWi96UlQy?=
 =?utf-8?B?R3ZieWlYSko2eUVLcHl4MXNpSW1YL3Q5L2Uxc2IySEczWm5GQmUrNlRCS1FM?=
 =?utf-8?B?SlAxSTIzdCswT2VpWmovZUw4ekhhTzRXTGZSTXllRnZBbGcrakdETGRQZkkw?=
 =?utf-8?B?TlFSZzE5ZFphU1MxcElJaEdmbWJFMGtCa0hqUE1rVzBvL0lRWVBLSW9VLzZP?=
 =?utf-8?B?UGg0NUd2MzAzMWppQ1Bnc1BiNkQxODBNbXB3VnFlMjVrZkg2MEsreXh3L0hW?=
 =?utf-8?B?QUwyaDJoVFFDOGlxSWNyeEVuNGg5N2N6aFNReU5GVDdjWWdaYnhJZjVCclkw?=
 =?utf-8?B?MFQzTW5wMDd2ZktXTkh3WFp3K1BEWDBLeUFFUi90NGxvdnliVTBxR1prQlQw?=
 =?utf-8?B?dmlRQVhtQzI0ZWpxMHhSYk16dmtGMVRGUUJiNkVEOHNvUGV0WHpzTExmOFA2?=
 =?utf-8?B?MkI4a1pJRllkQkQ5dWsySEU4RjlGeHFvb0h5c0JBTWdaRk91dnBiV3VGUmJi?=
 =?utf-8?B?ZFk2Y3JWZXV4RVBXMnZRVmlNYjM0Zkt4RXpndlBhUE5pNkdQMDBRaWsvSHNr?=
 =?utf-8?B?WGFzK3pPUjlSQTRYOEZVYndwVDdPbnlnbUNjdnlRZVhkTW4xRTNsZ2twYVJn?=
 =?utf-8?B?SitVdmZWbVdrMHZHYllBWURNNVdTTFozY3JCYUlvZHFmZGtBSHBGZE53cUd4?=
 =?utf-8?B?ZTZ0R1BvRUtoTUxuVXdKMzVocjVEVUtmelpNVFVSKzB6Uk9GR3N1dW1LMTVt?=
 =?utf-8?B?VEtxZGMzSmhXZW4vNzNzKzRPMXhRSGxtSFdOcXdNb3daT1ZRd0dicWNXZ1cx?=
 =?utf-8?B?Yjd4M2VKbXZScWo4WHhQT2NFbTNMQWtTTWZ6WmFYS3hwcVlFR1JWekNqQzFG?=
 =?utf-8?B?Q011alEwQkJKc3cwZXZVS2J6YVc0ZUwzeFlJNE1nVHRPSEIrN1I2NEJ0bFly?=
 =?utf-8?B?ZGthclpTSU16VXFRVEhQeUljT09nNW5kSmlEamg1RnlJOHIxQ1hOVGJhamI4?=
 =?utf-8?B?c2w3MnNCWHdvK1B1cFFnOWRNbHBZVm51NWlPUzFmTGlHbU83ZGJBZ0JRdG9O?=
 =?utf-8?B?Rld6amVmWlJVaHJyVXBQSUFnK3BBWnpCUWZ0VGJFS3V1SWtLSS9TWS9kRUps?=
 =?utf-8?B?QTNtRFBQQU9vbjlRRDVtTmVtcmhvWXkwZzVTNyt1THMrU3dsVW55b08wdDc2?=
 =?utf-8?B?OU5TaFZhWDJsOGRaemFvZTdWeG1yTjJNWUVMcnhJR0t5UE1BaHFSTHNRSzVk?=
 =?utf-8?B?K0k5SWthQzQ1ZFlBUGJ2dkp0bkN4c3VZZlB3MG91TTlDbmJsZko4djlaL1hS?=
 =?utf-8?B?S2RiVzlzQldMc2crdzVNdStPa3VaaXNORk80Q0dYcUlrREFROGdpeDdsOVBM?=
 =?utf-8?B?YkVmNWR5bTdxU1Q2cmVjMjNINnRYY0s5WGt1SHFtaHF2TEY4aklnd3M2TlRM?=
 =?utf-8?B?bjIyTlhleU5TT3d5aEpQeHRmVXYvTVJrTnpwT1RYUzAxbVlHZThaZk5PQ09P?=
 =?utf-8?B?cU0vL1FMTkV4WnJoYzhNbkpBaFRSWHJFUklDeEVEdlNuVTZhT3JDQkF1aUtx?=
 =?utf-8?B?eFY5TWNKY2ltZ2hKNE5LWjF5YkNrcXM2dWVkbXlpdUg5ellYM2oyYzd2WVN2?=
 =?utf-8?B?QXlDRXVyWVJZR2ZTa2VyOTAwQzgrRmtpUDZlK0dqNmpwUXlPL0JTTmlWUzNH?=
 =?utf-8?B?cWhlSjZCb09EWkY4Wm1QZ3lCQWl2TmFDNnpYTlFFaTE1Y2d5UkJMZzV6NE1l?=
 =?utf-8?B?akd0U0ozYU1lSm1CWG9ISzYyaVZMV3NHa2FVZHpCd1phcUhENG5oVG8wanlS?=
 =?utf-8?B?VlgyMWg1QllSK29lZ2Q0azRTNFgxVTloOHRNZys0Sm1URjBBdERBd004TXRh?=
 =?utf-8?B?Z29IN1ZWTWVwSWorK0tUbVdvSTI4SVh2MGJQbTBpNHQrMTRqZU5EWGo3QXAy?=
 =?utf-8?B?b0NMakZJWXEvekFocStmTG1FenBrWU9GRlJuajdvMmJFOC9NcWdOWVpWOE4w?=
 =?utf-8?B?T2VDQnp2c1NuQUVGVFZaa1M2RCtyUnZIRENPMlhHN1o4UE9ZYldUT3Q0b2Z1?=
 =?utf-8?B?QnUvNDJLalJZN2hWaC95R3lGVUlLUnY0SHBLUVhrU0I1REFQcEVDWUJmZFhW?=
 =?utf-8?B?SDJvTTdsQ3phUTJiTjhQeHhGOFo0VVN2dlpMaE1NWjVnNEdMVDU2Vkh2QnIy?=
 =?utf-8?Q?mN5E4lI5D09Gso/oR1b9Bo7/rlyLxpVQXBzOzmRbBEud8?=
X-MS-Exchange-AntiSpam-MessageData-1: wH/fmm7mXz+u4w==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f384aa4-e005-484b-3900-08def490797a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:30:48.9033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKR6tBHHdwkXeKRmpQ1lRnRlOGj8jmcCrW/QVr/hBFaffLRK6JS6euXHItqzoji+znDrmiyMsNVvLvrv4zytStqo7yG2VdJ3DjJtmfRER7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8579
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOmcAQclXNysBcWGN3elRU1xgEAma1qDbqb3Zad4Cjw=;
 b=bP1UVpW7021+caiYo+wyL1Ia+zAXlA5zd6BnfT2nWe1ZBCUNeHJiZoDxJzRWWd2wnlKLKcf86OBsoVFCP8w51I5OKM9URH4MIVNypckus2dd3fzzEfLFzNmTBXyxSOnO13DDI5BMO7NRVsnXZSoszgTjTtW+oAf9hhRwptKyQV4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bP1UVpW7
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/30/26 4:12 PM, Jonas Karlman wrote:
> The rk3588_pll_set_rate() function contains special handling intended
> only for PLLs on RK3588 that are also applied to PLLs on RK3576.
> 
> This special handling should ideally be moved from the common pll funcs
> into the clk_rk3588 driver. Add IS_ENABLED() guards as an initial step
> to limit this special handling to PLLs on RK3588 targets.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")

Thanks!
Quentin
