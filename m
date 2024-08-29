Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64307C83031
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 10:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C477588B59;
	Thu, 29 Aug 2024 12:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="EtqPExyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECB5E88B64; Thu, 29 Aug 2024 12:23:29 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14CF088B31
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 12:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2Ub/WOvaApOTPqpleqW93glzSxroNIDcIlr+/ftLUKE9TgXL0n0XcC6EU+mt4Z/GarbiMMzAoGrSNUWD/R2c48pc8rCd5EHl2hfNnySX/Xg4BL57ghEKqNi1bISuh4vbwpxeLxAOpVJP+7kfI1HVkiglD9zswcl1HSi2QnKOdY5/oY2rlV24/5qkJ1qN4247L/+eLXU8w9Jlogcmh76LRzx92ydnyU4FObe4vA5FksFgfRtiAdDxElVIaHjlBmIBJQA/P9jxrrHv77Q4yNdmoMQeLRxjP6ALJ1U3uOh+I1moqKPMfG0A9ovkBHevIsHEki0YtodTxOPWxS3c2ILEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTNTVtTOD+vfK1DJpBRf9GU6yYFGm0Ly1BhrOIjGvF4=;
 b=DAZ8QpsElEIfVm91zLtb2rYs5p65v4f98yVvt5K/4SyoQresHf3coWh3BCzkt4w5KICpGKO0+7gepCMe3sLbEBw+XyXeQ6hcaeuVkCHUAkLdLzzzotLCe7zMENDfA1MAG3e2RX0nYBI6XRrpNwMuSJO8EI3SKZWsggbg1/MKZZhOETA5pRt0apPo54lv+wh4sJkctpOJy4zJ9y1J8ekxTXP6kgujQ1w1CdfLSh+U6JI47spb7UwgH1UUW3xwHlSl9St5DOw/MMhhRzj+zQvm72jHkzHWS1smrgUjS0JSLte33lptKZ5DugOeJKZyv0KaUZsLFYYxFK4KgNa4I445gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTNTVtTOD+vfK1DJpBRf9GU6yYFGm0Ly1BhrOIjGvF4=;
 b=EtqPExyif8Fpundi67ESsfrurvbpMcDxAZTDS6hwk89ubyesO+tLzazX1hMRNasoxsHspM5oUkd989lk7brsR5NXeLkcWL7h2nssAon0SwVJGmbYiwdXF8Nvf2zeLRLTDjmWXwlT2Y2oTPonq1vG27iyDE40fJakqbRNZ/s+Mbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10835.eurprd04.prod.outlook.com (2603:10a6:800:27c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Thu, 29 Aug
 2024 10:23:24 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 10:23:24 +0000
Message-ID: <7b1b065b-4bb4-4992-a841-119773de5c85@cherry.de>
Date: Thu, 29 Aug 2024 12:23:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm: rockchip: PX30: Fix hard dependency to
 DEBUG_UART_BOARD_INIT
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com
References: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
 <20240827142058.594556-5-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240827142058.594556-5-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0290.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10835:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad0c7eb-1166-45f4-5f2a-08dcc8149d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmpKUWRqZ1dWUjlsTHN3NU1qd2lJUzFhOEJya2pSV2cvc1RSTWVHRStSdlVV?=
 =?utf-8?B?Q3hzRWpVcFNRc1hWMjVYNWtBT3BaSTljY3FpZGxjNVlqb21Qd3YxZGpzVWFq?=
 =?utf-8?B?Zm1jU3lNRjh4bE5JQUdQSmNvMG1tMUg4SVQzY01iSzJNeWxIbWlVZHdnamVS?=
 =?utf-8?B?cWNHRktQQUkyQlQwQ0lHYmNqMnNpSVhSR3dVZlNuSnJnaG5Xam1Ednl0Z1ZC?=
 =?utf-8?B?YTBqYkNhYXFHT1lTYTZRQU8wZ1BZZllNaXgvZndtbkdEUTMycnBmMkJPRTJz?=
 =?utf-8?B?RVFmTjBYbDZHaXNNQW5SN3RZS0hhOUFpZ1MzNktjSXVUNHVEcU0ydUVBMnVq?=
 =?utf-8?B?MUY3TTFQRUtSeXZhNTEwSTMwMzZhYUd4VlhzZzI5MVhkUkxsSnFNU1QrcHRq?=
 =?utf-8?B?aktkcXptZGVic2pheHVHZDJ0VXpmdEUvTWRGTTVmN0V6UlBoeERLSnNWUnYr?=
 =?utf-8?B?aTd2QmpOOGhUeUROaVF1cGptNEcrZjBaY3hRQy95YkQvSkxOWVZ3Sjc5ZWN3?=
 =?utf-8?B?WnhFVHhzWGhMY3kwOGt5MkszQnFjVk4wbTMxUTRaMHlCS2FpcVFFdk5nZlI1?=
 =?utf-8?B?VGgzQ3NvZ1ZlVldISGFNdTVaRU51d2Erb3hQaysrdkVqRjBUUUthTjVSRHNw?=
 =?utf-8?B?SkVHU0lTRUNZTFdST0lxM2hwMGJ3T005eGIrcU9PS0tvVFVHUDFCT3A0dUlW?=
 =?utf-8?B?a25QR0xDT2ozSFNVUnc2dG1Lb3hZZnhBcERIMnhrd0U3V1pZU0Q5eXRPM0Fp?=
 =?utf-8?B?eGJDaVE0YTBlOXFueU05Zjc1UnkvSDdwaG5TckJGbmNhNTdmMDRjNWVkcnIz?=
 =?utf-8?B?bDIyMzFHaWo1VWFXQzM2OGpjNFdKR2t3MlJVKzNRMStKQTYzTG53d2NmNWQr?=
 =?utf-8?B?T3VBR1dZQzZwY1pSY3ZPclRGTUQ1TVRuaklSTWp5MDRkellvWTRmc3ZPdlg2?=
 =?utf-8?B?U0RTaWcvanF6RWNtNzU5aFNZaFFzSkpHZXhaN2F6a0NtbHAwNi9kUlMxU3Va?=
 =?utf-8?B?VU1EYmRIZWNrQ2FwWkk5Ukx3NFFpczZwcEJ1OTNJeDU5OS9uaDBJdm5OQ1Bp?=
 =?utf-8?B?Z0ZTcUhpSGZ4L0h4SGxUZUpTWGxwWnVKa29vdkFIT2NXQVQwQlJ6Mkt5eTRT?=
 =?utf-8?B?Q29sWHdoaXV5NWh1dzRXR0xFdm95Y3hXeEQ5ZkZzYjRQcHFqcDA0UGd3bHo4?=
 =?utf-8?B?NnFEZ1RUbEw0VElvd1JFSnp2UHh0QjZMcGhSc1ZONkxTZnVmVkovMXBHVTlR?=
 =?utf-8?B?R0hDc2dkVENFelY2c1hhK2ZhSFRmNHc2NDk3c0NENUQ1SWNvZEJBUXJwayt0?=
 =?utf-8?B?VE0za05iOHQ4RTZoaHRSd0M0NVVPN0ZUT0l2MWNUTjc5dXpuQWRuWnVHYUJM?=
 =?utf-8?B?WjZoRjZxUEhyVUx6bDZtTmFSb2ZKWVlMV2tEWjFuTGNXWXFQcHkzbmwzWW90?=
 =?utf-8?B?bGMyN1RpeFlyeVlLTTVkTFgrZlZQMEZZRm1YL1VaeS8zZ3JkQVhod29TUDBV?=
 =?utf-8?B?eHhIbG1MQ1JTeWh5MUVadENQN2piUUdjRjRhcXlqMlhtK2RaR2IyRWJZUTVv?=
 =?utf-8?B?djRoU1BQUlVuZXZmMG9hTGlUZUN1bVkxcENublBIQXVHTHUvY0NEdWp4RWZn?=
 =?utf-8?B?TlQ2dWtHT2hXMldjTmQrczNXc0hBWlZ5T2RpM1dPekFJdWczZ05PQlkvVVBS?=
 =?utf-8?B?ZmpGWFNCK1F3cDZSODlCQkExSWdkN0lROC9KOURZbHpmdWw2ZFJrUGkzQy9V?=
 =?utf-8?B?dmNxa1RnRVZLcGUvZi8zNzZMNFR2M0tkQUJZUU5yQURRTWpPckIybkxCSHlN?=
 =?utf-8?B?OS9jUDV1UEdJc2xEOEFpUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWhMQlIzNEVCN1RYN21CK1lhM2lOVUlabFhMSnNPKzVwTUtPTnZ5dHZyL0x3?=
 =?utf-8?B?U1IvR0M0ZlJrQ3BIQnNjUDZrT3VLZVpQZHJKV1E2M3l6NWs3d1YzMENVWW5x?=
 =?utf-8?B?cEtYV0J3YjhqRThaYlc2VUkyK3Z6MUNvMVN4eFJ2cHgyM25Bb3N5aXliR1RS?=
 =?utf-8?B?SDlsbFh4WGJ4OTA2MEllQzNpbDhneTh4UVY4eFoyVWIvak5Gc0hFakJ5a1Nm?=
 =?utf-8?B?a01oTTBMT3ljaEpiSUN0Zjl2bUxEQVkvWStVVmhuQ3psZ0lRa29RVVRaaEdK?=
 =?utf-8?B?T2YrUHBHMHlVVFlCVG9tS3FUenEycGxPWDRkTUFWSXVkT09MdGVwalo4L2FT?=
 =?utf-8?B?cFhqYWtrdDB3b1oxQWF5RG5CdXpSL2EvMGh3NUpNUWlzM2lEN2dhNXNVU0NB?=
 =?utf-8?B?VjZFQTJIeEwxWWZUYXFhRnhyMi93Y0ZRVStnckxjbmdhMmNqcGZaMjgyUy9T?=
 =?utf-8?B?Si9IWEk3cU1nQmY5ZXlycTJ3TGRueFQ4aEl4TDFucVFDa3pWdjhIeEFVVkZo?=
 =?utf-8?B?M0dJZWI2aVhTNzRYM1dER1BNRFNUV3RadmZyQ0d6NXZpcE42clVhTUhyLzJX?=
 =?utf-8?B?UDFURFg0WWFGUGtqZFhQZ3ZBZjNjNE9xY3RrMXZuVDNNdW40ZloyWGFqNGhF?=
 =?utf-8?B?Qm9NTFZrUGJqbGwrODQwSUNnb1ZuNHBkL1g1aHZUd2lURGJnWE94MEtyVGZ5?=
 =?utf-8?B?VkgrM0g3MVBMNnVPbTIvUUJRY0x6QkNyV0w3WVBUdDZYek0rMEdLbjhDS0ZN?=
 =?utf-8?B?eEFtNWNGemh5NWNCZHRRL1FuMWdPN0VBbThtcy9WRFAxTXJ2L01iTHZhMzA2?=
 =?utf-8?B?b3RuNXdCR1RPaWsxRGdUZFk1c1ZzaEc2cGpzWmlzMFFjUitnMFpWZzZXaDNV?=
 =?utf-8?B?b0hEV2pHc0xJR1NNUUtHalV5blNGOWVzQThmdEdlRndwZ2VsUWt4cm5YSXpG?=
 =?utf-8?B?eVk3TzJtOVBsd2ZhTWVuWTh1U3NmSENHQXJDS0FtTW91VXo3T2hJVmlTd2g1?=
 =?utf-8?B?QWJ6UG51bHhsRWdTcWRWaXkvNy9iOHZQbkhjeUp5dWdRdXZRanVjS3Bzcjdn?=
 =?utf-8?B?d0RYTm1UWkdORnZjL0NKdTR3bDZqdlp1MExiK2F2WWFEc0wvTlE5eE9HOXpU?=
 =?utf-8?B?ekQxTXJVT1o4Tm5ob1d0ZVZ5bzNEaWtkbFcyc0MyT2N6YWNteDdwaDdpT0lm?=
 =?utf-8?B?blpTalIwaGhiczl3S05xOG1LT24ybWtYMHdTTGFTMy9tanRQdEF0djdZUDBa?=
 =?utf-8?B?cmlWSEVJSFVxOWh3dUFYN29vYnlJbGZQNXpoa1JWcCtwcFFjYkdWZWM4MlVP?=
 =?utf-8?B?TjJDOEM3Mkd2bjg0RlhyU25MMVJTMXQ0U21CTmF1cDY1elFrS2MzbGY5YkFO?=
 =?utf-8?B?Z21OMUZZSzNUKzZWZE9uUFRIZ0haTHlBcFNYMll5bk1Gc2srb1owVmNYbWo5?=
 =?utf-8?B?QWZkSFIrQ0hIaTZlTzJPazhKQ2VDZE42SHAwbGw3SXRyWDZ0VWx5KzNqRjU2?=
 =?utf-8?B?bkNvNisraGRhK2VKOHRuVll2UkE2a3NSdTJWNVRybk5HRUtmYS90L051T1VR?=
 =?utf-8?B?bXN4b3VhS3Y1THFsOFhVVG8yd05uRHVJQ2xpTXRhMVlrT0FFUFZWckhLV2ZC?=
 =?utf-8?B?QTNldmFRaTJMWWhWYmRDMXBJWFJqWW5NMTJMTEFvYW05TnRPQm56WjF1MlpJ?=
 =?utf-8?B?Y0c5Sk9WMlFNNk11YldqQllHbnJNRlFGSVpMZnV1MklJS0t0elVaWjlCbmFU?=
 =?utf-8?B?S2k3QmU1amVuVUxRR244OWgyMVV3MHhISFBoZ0YvVFpFOEJUUmhMcVBhU2JV?=
 =?utf-8?B?VG5wSWJtNXZnSUUwazZxeDNDcDNpUGNKWmx6WUg5b2Rhdy9SUHBEZ3Nrd3F6?=
 =?utf-8?B?RFU0NEcxMDR6bVdMNjNHMkxNazlWaSt6eEhqSkxzWm1uZnFsNUtzYlJHUGxm?=
 =?utf-8?B?MUxTZVhwQUJGV2VCZklDWENpMGVFV3VMdWJYK01TMjdTa05yekxTcGlyamRq?=
 =?utf-8?B?QnNlSVUycE92L0YwaXF4ZlhXaGdqMzBHR3EwaklSMGIwZmZqOG8wT1JyZGZT?=
 =?utf-8?B?RnVrakd4R1dOMkJEQ3NLd2thMWJoOUFsVGVxUVVRKytYK3I3WXBwV2hEQzgx?=
 =?utf-8?B?V0JMSVFMTEdUTTdkN1VyOHZqOE52czhUUEF6RUtaNUJyMlhFZ1d2dTVObUVT?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad0c7eb-1166-45f4-5f2a-08dcc8149d66
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 10:23:24.6557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGkCh4vbiX0cB63qQ7F4QOQWNhs/UeQdcm1b3T+dP4+flRYO+cZGD3GDfkr2/MUhcwNclBEdxzsbKBQ7KYKbBK4ildRq5Pw1kNOvVpqfWa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10835
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

Hi Lukasz,

On 8/27/24 4:20 PM, Lukasz Czechowski wrote:
> Because DEBUG_UART_BOARD_INIT depends on DEBUG_UART, hard dependency
> to DEBUG_UART_BOARD_INIT in ROCKCHIP_PX30 can cause warnings if
> DEBUG_UART is disabled.
> The DEBUG_UART_BOARD_INIT is already implied by ARCH_ROCKCHIP entry.
> Remove hard dependency from ROCKCHIP_PX30, so that it will be
> consistent with other rockchip boards.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Same remark for the commit title as for patch 3/4

Change is fine, so

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
