Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AD2C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 15:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 981E888A33;
	Tue,  6 Aug 2024 17:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Kl8OFbHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED3A88AC1; Tue,  6 Aug 2024 17:37:05 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDD288A23
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 17:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft3zEkxelNAfF8lcOVxYPtlVrM9zq53HD2ynewPhm2LteI3HD9efJpfrrv0p0rdbV8xPPhsD0dwZmhQTmsUtfx67mRu+qLge52kvku/jNCBtFsXO+JAoWsyh6SecSl2ir1uXXO3sIhnutOhk3EtT8g7UTnDFqGg1N8sXtfZRnIxurHT3iHQ/uUsUN/YsAA6/0iDo/6L6zdMq0Z5B5ULp20/ejYHFAFydDkDSECD7uekrgv2VU1UwqWs814jBHa0GCvZ/RnSZrGsCBLnTeliavz0DW06iT8si7w1ojS+MeqP0cRgij6As682LsfAq620U9ywcaj7ZQE4FAew8HV4TVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ+Ny0rIMxFT+Z2wzdrmoXHbBupOKzEEE3mkGETYGhE=;
 b=vNKMKO0CZGYb1eEmMmCVTjnqwvC2DdPdevNc7izLFSlKdXIAJFB+7FiLo/oxKpSGuQGgqJTQG0P/bY8/7sqgbiXUZVXysTx7xKBW6giQ4Ibi+dxxiQUeawfaAdIQ0iiJ9iF1jb5afLEAsPu3gYoyC+pYKYKkjXDJSXJPsyPnyzt/GiVYFwWXT8uwZFxo7jFu2YIApN393Sc7yvqgROlec2cjkDAdN+7z0PlqLfRm8UZSj74GNyKdsuNe8PE7o9uIK2bIAA3f1aqzFdZh3FS7sSjziWQxGtiuP22oRG5aup0SK8RNnkEQpWh4ADcfC+BpU+QEb/BTcNHPavY7hgI5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ+Ny0rIMxFT+Z2wzdrmoXHbBupOKzEEE3mkGETYGhE=;
 b=Kl8OFbHyRIkS7RduIioDLuJMXnAmFNBbTyS2uTcKaMtkie0tev7Ux9crqoTFKbML3YEsq2ww2FWSPfjV0NStzVLzTAAHu4hANiUROA5IqUPXrRFf6CwJ4oOigfG225JmSDQjF7pkVIp/29oRMj9oHU7nArW+oyLomjID9O3968M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB6979.eurprd04.prod.outlook.com (2603:10a6:208:18b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 15:36:59 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 15:36:59 +0000
Message-ID: <92eea78d-fe80-49d9-8277-382a2c564875@cherry.de>
Date: Tue, 6 Aug 2024 17:36:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] pinctrl: rockchip: Add a pin_to_bank() helper
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240802225705.2640999-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 727ed3d4-4f59-4ece-44a4-08dcb62d9c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djBOai9SNlFmVFNnRjhlMkJNMXV1YTVDd21VYk9STGZrS0I1NVJUUFc1Q1Fy?=
 =?utf-8?B?SDVNRU9WTFZxZG96eHhjekJBOUVPTVdzcG54NVoxaXBLWW1rMGdBNlhWa0hV?=
 =?utf-8?B?NzViVUQ3UlgrdzRzdTdIZ1BJSENLaDlSbzZOeVZkL1pCZ1p3WGtIcGttSlpt?=
 =?utf-8?B?bzhvWkNqVGEycFBXbWlISlFlQWFOTkVoV0EwUitlRFM4MUN2aVRITGNSS0Jq?=
 =?utf-8?B?S01NbnMrUU5ZM1VJOXJjM3BqdTF6T0YzMzhDdFBrYU5vMkNSRjBuZEhFc2xN?=
 =?utf-8?B?OUkwTWpFaXRVdW1CY3czQWVQU0FCSE5FYlZPaTROOGUxV1lWRmhpZUlqd1h2?=
 =?utf-8?B?S05nTndRVVNaVWcrMmRUNG41MmpDZWVCMG5hUGdhV0thY25wN2hhSXlXRGNI?=
 =?utf-8?B?Z3NSL2V4NU04WmRET2JGZ25LdnNVSnFacWlhcyt4V0hQK2d5Ylp6UFlIbWJm?=
 =?utf-8?B?RE1RanNoYnI3M3Z4SmR3aW4rNWpkSHUvL2ZuWFdCNHdSbzJ0aXBNNnBFSFVN?=
 =?utf-8?B?N1IvVzc2RkVyWlNCWHNKSGp4L0VDelpMM25oZ1c2czZPQXRNKyszMW5EOHJZ?=
 =?utf-8?B?OE92Q2ppaXBUZ3lpVmlJTDFOZWFqRktsMFZuZHIyTjdoaW1ORTRVdjg0V1B0?=
 =?utf-8?B?cUxXbGVWNUhuT2xhQnhqYTgxMWt5NlZtdnEzQVFaMHlCOHRWbnlta2RLK1N5?=
 =?utf-8?B?NlFLNG9JcXZvY1dhRjgvRkdCT2F3Z3QrRGxZMXZhS1lCb3lSOEVnMnM5cXdw?=
 =?utf-8?B?N0gwYlNxSy9YN3RadC9NUGhYenV1NzN2a2N2dTRQQkhsVXQ1RlpzVDBuTWN2?=
 =?utf-8?B?U29HWU1xVklWdXJLZmtZREZKRHJUek5kM2IrSFZUTG1ZSWc3dXY4MW1UOUln?=
 =?utf-8?B?bGNkK1c3dFBreDkrODFPTXZMTW5QdzVxeXZ5d1NqK0t0VE5XTSthcThOaVFN?=
 =?utf-8?B?Qzg1QTMxUk1mcDhQRUlKckxWYlE0aVUrSldRMFNDZTZsaWdtd0sxNTNJSnpx?=
 =?utf-8?B?UUV6VCtnazc5YTc3MGJlREFnOEozb2dHYkNwbnNDWldaQ2srVWYyQ2VMK1lQ?=
 =?utf-8?B?cm9JdTR4ZnlWcHkybHhYUFdRY1oxY2VCQ0pzRlJCU2k5VEd0MHdZZUxaaFhS?=
 =?utf-8?B?NTM1ZFp2Q01pRVhPSTBBckZCY3p2QkdNR2I2cjR6cGdDUVVlb3RleGgvOVRy?=
 =?utf-8?B?SUVXblNVNTBOR3E1K1pDMXdzbVhpc2Q3Q0piYlcxaVNscHZFQ2RyQkc0UE5i?=
 =?utf-8?B?MFFYdklkQzRjUU5QbTZaVTY4dkgvV2x0MDRNUjJXTFN2UjhtS3hxSWh5WTdM?=
 =?utf-8?B?R1RBOVBJV3FLWXpyRHlBUWxLc1AremR5aUxtZUpYR3RXSkh1cFB2VVp1SVZQ?=
 =?utf-8?B?RkJ0STVSME9rcFJGem9sYjdiQThHZ1JRVzBtR0xEUGdzNk1Mdml4ZWtwT29J?=
 =?utf-8?B?SkJZdm1VSHpvSEdpTzlhVnV6dmJhSjdvaFVJS3lXaTBaa0g1R3c3ZlNqK0Zp?=
 =?utf-8?B?TlF6eGVGdGhjNGZnc0QrbTAzOWV4V1p3bUFRSXpZaE5FZzFZUktOc1ZBeWR2?=
 =?utf-8?B?MkxnZzRrTzJ5NTI2Q0lUN3Z2WjdmL2tmekRVVmlOMFZoTEVkT0o2NktQeVlF?=
 =?utf-8?B?MHZLM0FIRElHVGhmQzVNQWZyMmljYzhxcTZqdDljT0g4VDgwcDFLclI3WU5V?=
 =?utf-8?B?eXhvRHBzZkljeVFoWXVuQVhaZDQrczRWeS9tR29SRnVVYVIzQ3BvKzBrNHRZ?=
 =?utf-8?B?eDRNcEhBVGVtMVhoMVhZS2pGRHBydzkrLzZYZWVMZENPZlNIaVJzTlU3RHRp?=
 =?utf-8?B?VHVzdUJkQ2g1ejh2WVUzdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU9Gc2Z3RFRlaGI4YlFkdS9OL3NXaE1YdDQ1UE1FMXJjTVdLRlVHbjFOZmNj?=
 =?utf-8?B?cERYdk9ydVRkYUZBTm1lZnJhQ2l6aWJOQVZ6SmpSTHp6djhBNzNqcWlYT3pD?=
 =?utf-8?B?VVl1blhaYTAyMGRhKzVuU3NWWjFORjRzSHBQSGFFTTVBMmMxaU1DL05SZVhY?=
 =?utf-8?B?MXFCRXVraENsOGVqYkVSb1NadDh4anFlN3FWem5IRGJCWjJZQ1dlRUZpdmZl?=
 =?utf-8?B?amtTcTJubHpXU0szTnBQQllyUXdPWTlYeE5hdk1uaEU1S2R3cEdnZXBRZE1T?=
 =?utf-8?B?QjF0SGVBa0JDQklRSnM4WGxLWG51NUEzVHpXbVRCSERkdkRrZTJXT1J1c0hL?=
 =?utf-8?B?V3llTnIzNlhKVVU3OEdsZTVIM0tCTWczV3FEZ3Q1R0kzZmN3ckgzbWFVNEFU?=
 =?utf-8?B?N01hb3hNUFJtTVdIWnpQOWd1dUN6aDVmcUpjY2J4ZDE0Y1M4UzdhUEFrdEZu?=
 =?utf-8?B?dWtzVlNjUHdRMkd3ZzR6cWszQUFCTTFvWlZhSGZLaEpYVDk5bGNtL0Zoa1dR?=
 =?utf-8?B?Q0prK2hDS0lFZ25vY0FMb1FLc09uQVhWb1RMSUhrUjhnYmlpTlpJUUk3NzRG?=
 =?utf-8?B?OHF1S3RCbmJaTnVZV2t3NVlFM1Voa1lwNWNDVU11UWwzOVZxRk4wK2ZsMDlN?=
 =?utf-8?B?YUhvWHg2dkIwV3dzb2Z3Uyt2Kysvc0N1dk52ZlVWamluWGJGYUhPdHNqNDBl?=
 =?utf-8?B?RUdtTEFJdWFsMFpaRnlrdzB1KzZRMXRMVFFqeUdMTHFIb3lxaVZRcndyZ3JZ?=
 =?utf-8?B?UjVGUktxZzlmRGRtckJwRjgvYTFYOWpacCs0NTIxYlRnYUNHbnJmS0RzK0I5?=
 =?utf-8?B?b3p5bmRjbjhEYVZqQUx2bWN2R1N2ZXAxdkJXSWFzelkyOENkeUdmUUdMZGxK?=
 =?utf-8?B?RnJiNjNvVGlDYThvY1BLbE8wWGlLTzhxWVQwbnFpbUdaUko5UHZpMDdRMXR4?=
 =?utf-8?B?WG5nVXh6eUpXM1lQcWcwUGxMZVJMTFZwZ2g0M0RnSDRLQlVWQUI4TTJqTy8v?=
 =?utf-8?B?M2tQQThPcVcwb1JFMkdMTEZaQkhrRlBCM3N3c1B1clBFMUZkZEV3VmFBUzFV?=
 =?utf-8?B?RmhhOFJMV2dOMjFwVHg3VzQvUmEveXRsVitjOG40NllqeDdHNzNVUHpwa29J?=
 =?utf-8?B?S2pKTm5PSE5ZcVIrdExJU3VyTXhKSTVha3c1bzRmQUVaM1pWRVhuejROSGli?=
 =?utf-8?B?Tlo5QlZBYTdyV0g3NkJnL3VMTURzdXVENjBsN1d0S2JmeTlWOVJIN2MrNE5X?=
 =?utf-8?B?Mk5FRStBaXRrTDhzb1FuUU5yWUJzR1o4dElyMk1FOC9zSVY3OFpMa1NkTG80?=
 =?utf-8?B?T1hlUWhmcVJkQVQ1eENIenQveU9vK3JsblRkNzVaYWM3dXR6OHNjcXZRbEhP?=
 =?utf-8?B?ZjNMK1Y4TmhEd3JwWUhBdFdXTE9nTy9EazFvdTNFdWc0Y09IcnJJazNXbFNy?=
 =?utf-8?B?cHdBSVZ5YzZHQ3FVdmEzdmxNVVIxRlpPUUY0Sk1pRU84NndUK1MrNjByU3lS?=
 =?utf-8?B?bHljaU5WeHJZTGE3djNSMUtNZWUwQVhjb0x1N0lYcHd0QnhTMjlSL3lwZEpK?=
 =?utf-8?B?bXlDcmZLQkJrdTNsenl3czZndFNBbFBTb01Od1FuTm44UVE1anR1S3BQUXRK?=
 =?utf-8?B?TVBVaGI1cjJ2LzlvODJwOW9hZ1pscjZHZ2FaMCtpTUVEb0QvbVg1NmtjTGlO?=
 =?utf-8?B?dTU3b0RTNW55cDNJRFRkeTdIdFYreTk2bUhHRGt4MDg4MHRibTZEakZPNzNX?=
 =?utf-8?B?WXovTlJnKzYra3k0R0RSV2tlZ3lnWnltK3JkNWkwZzhxbGJWdURCSVZ1Q0dP?=
 =?utf-8?B?NC9iOVQ4dEZKYi9xeTRTc05ZZDZIRjdYSUdYZ0dLZVgvaG1PUE1rcDRsUWc4?=
 =?utf-8?B?T1BES1N6SXFmRmhtSTQwa1FCTHlZUjh4amZaelgyZjROcFdZTVpGYi9tSlQ3?=
 =?utf-8?B?Z1djNzZiQ2xXTEFGdHZ6ZS9XY1Q2eG9CWndyekFEWnVGL3ZxL2pMQjVsakVO?=
 =?utf-8?B?cEI1THN3UEF1QTBsZkNjZFlLVitSSURMNXRhWlBST0dkdWlLaGJZNFhDQklS?=
 =?utf-8?B?K2JqYmlYY2ZEMjM3S2xnWHA4KzhNZFphaXEzUXUzUVZRbTZqVG5qWWpkVHR4?=
 =?utf-8?B?eDlySGVLK0JKQnpDQ3lZVmp1T1h5WE4xWW5oNk15U0dma1VFa3kzenhRUFlR?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 727ed3d4-4f59-4ece-44a4-08dcb62d9c4b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 15:36:59.2362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hj9sOAwe47jDmpxe2/xR3aTYENwMp97RgdxXWvYA4DXmkedEhSdTiGnpiUNJTnZQ1Gzyp6oPZHzEdgXc3EJj9N0uFXDWTCz3zQ3HWfUlBpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6979
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

On 8/3/24 12:56 AM, Jonas Karlman wrote:
> Add a pin_to_bank() helper that can locate a pin bank based on the pin
> offset, to be used in get_gpio_mux() and gpio_request_enable() ops.
> 
> Reset ctrl->nr_pins to 0 so that pin_to_bank() can locate a bank after
> the second probe in U-Boot proper.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: New patch split from "pinctrl: rockchip: Add gpio_request_enable()
>      ops" of "rockchip: Add gpio request() ops" series
> ---
>   .../pinctrl/rockchip/pinctrl-rockchip-core.c   | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> index f6af22501c36..894ff74aee98 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -176,6 +176,23 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
>   	return ((val >> bit) & mask);
>   }
>   
> +static struct rockchip_pin_bank *rockchip_pin_to_bank(struct udevice *dev,
> +						      unsigned int pin)
> +{
> +	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
> +	struct rockchip_pin_ctrl *ctrl = priv->ctrl;
> +	struct rockchip_pin_bank *bank = ctrl->pin_banks;
> +	int i;
> +
> +	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
> +		if (pin >= bank->pin_base &&
> +		    pin < bank->pin_base + bank->nr_pins)
> +			return bank;
> +	}
> +
> +	return NULL;
> +}
> +
>   static int rockchip_pinctrl_get_gpio_mux(struct udevice *dev, int banknum,
>   					 int index)
>   {	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
> @@ -539,6 +556,7 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(struct udevice *d
>   	drv_pmu_offs = ctrl->pmu_drv_offset;
>   	drv_grf_offs = ctrl->grf_drv_offset;
>   	bank = ctrl->pin_banks;
> +	ctrl->nr_pins = 0;
>   

Please in a separate commit, this seems to be an important bug to fix.

Now, I don't understand why we would probe twice in U-Boot proper. This 
seems very bad, shouldn't one probe be enough?

Further, I assume the issue is that we modify the static struct 
rockchip_pin_ctrl from within the pre-reloc probe and since the content 
won't have changed after relocation, whatever we modify in this struct 
will persist. This is.... bad. I would therefore suggest we migrate to 
const struct instead and have some kind of priv data that is allocated 
and initialized during probe and doesn't persist between probes (though 
I'm still perplexed by the double probe thingy).

Cheers,
Quentin
