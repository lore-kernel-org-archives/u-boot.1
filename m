Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E15C44501
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 18:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A818984B73;
	Thu,  9 Jul 2026 20:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="e57QGZPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D002684BEF; Thu,  9 Jul 2026 20:23:54 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CB3C83FF5
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZinGTDRc3AXs+b5hSrUSrla2bCsoXLQqoUOfiuDwrVvcEtafrSdlISHiuYVQkxq9ZfTXAPhKFkKK99B5O4Jxj30NrUbj1UaOgT1IXMxaDr7KI7vaTXg9OPgEqgVWY5HS/PP3P6o+tXQ/SGsvmTFImQK3pbv1BduSBt2TThKD/tkUKEz7xZH2tltGXByCWEccm/BofhyarWpl5C4lIvYrpHM3gMy8U2LAp2Iib5LvtPs/bqHrzbaX1ankegX0VfDKsmmLwnDx9/u2asQcsCs5b/j03EE0wx41plBF5cGABDoCL6jcEF/DwJuIgdfpnpGcb14CDQ+0LUxWPtygxXdVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uE9wAYSZH6Qh7ftezBSO85Kn/cfC6XzBA3EpMpOWns=;
 b=oc6CpJNCfvGE9imUCGXaccNn5jswy2FPI3N8yKo9lyaN+LAGU/BjRwHN8NvhJ/kqveQWLVt+v7sFr9+mZDH0RakrlORarmE79zWiPFHSwK2m9clqUA5PuEiowyAMP6tHP850ATZ2dmMGo2OwAFsug8zrzSJnALAIROK4ewMYuqyYNQ+XxprTNieBUJEr4plzrkhO3OY1b+ONZ8wGiP4GIWnBacorozQIpEZGQIfhTkEWeWfxjXKb6g5kEgQBaA9fZvPrIYGeLF6VP3Wj1I/fJnGMkhA1SzjUGiUBMn67skqk0l9R6iaJzfm2EM72V+fg9Y6Q/LolNgLMMMvbaQEv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uE9wAYSZH6Qh7ftezBSO85Kn/cfC6XzBA3EpMpOWns=;
 b=e57QGZPAG91rtBm7GnK/PGPZ+7OvGAj/lANxyZz3l+H9D8Gf+ClTan09baZcdpbmxCUJiJw8dppjTeQ55o9ivgaOHxiln2MMl0wzQ9X8DIfrAxptT7dNU0WAL5bIEhVypsMhnLEfScrEFv6kSQP8adhI8X2RpB3Bk/1JZS8yHA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB11016.eurprd04.prod.outlook.com (2603:10a6:150:206::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 18:23:47 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 18:23:47 +0000
Message-ID: <a71f2d27-4ba0-4abe-af1b-0ac409c2ba74@cherry.de>
Date: Thu, 9 Jul 2026 20:23:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: Add for 9Tripod X3568 v4
To: Coia Prant <coiaprant@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20260625155021.2269190-2-coiaprant@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260625155021.2269190-2-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0003.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::6)
 To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB11016:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c188c6-0da0-4c27-5d57-08dedde73782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|4133799003|56012099006|11063799006|5023799004|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: T9HmhEwCMy/kgj+00gpM3KwWamyj2h0NmBboWhZttOHFuFaqaH2JhKYsT6Hg9dqSJfocLqTOMNth7eIWC3nAqck6NLatnDd9SoE7nT1TUduC5Bdsa/9c13w6Cf/vk97LWAWl5fD4DnlAJrFftjU6UjUK0f6oWLrGISfKxQ0geRgSBW1s9rPHHhE5XE66xmyCRtK7Al3gIFh8mDgPzZC5tn/GhVPkZM+dwfFN2e0KXZ6eKf1cMmOurAmudTt0jEvINbjMLoOXMqx+Gm4Ecsf5fu+SByeLEVtgFNyg64PsCknmuxml2fJhIHf/gxUaqDBCpukZ4DjPQ2vWnywRfSUq62ArHQkXB88IRvVTZv/JuCIcusBIXbERLqbQ7Nk3LHkTZQJaOR74SivLSbbLieJuphA0Peg7E4CLFymH3EkmGQIh98Qn1V5oRAaF/eOFhd5mQiUU7XWWs4WdTRHQ8IPn9V44M23+F5EWnK2mcDz5HUiCU7QMzj6j5GtErAUmpfyXP++nnA8YKvDQPjhYQX8oIFg9NOqN9wqWBOQfW+pjyLxXy1cuVY6BU7kx7otpO7chZ9JiymGrxHUCIt4EW4/Gvg64nQKSz+oR+qWnu7HXy8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(4133799003)(56012099006)(11063799006)(5023799004)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak1sRWtSdGVNS1RIWnNta2RiQVNvbDJtUXVpeWdrUzJSczU0VVd3WDEra1VE?=
 =?utf-8?B?aFdjMFFWa0JHQTVYdlhoOGtsK1FXWDBHVnMzbThldnVwbDJSZ2h1WURvYWV6?=
 =?utf-8?B?c2w5eGZPdHZqbHkvOTZtSktyMUR0NWhERCtVZThNNXhUbGN3WkpNYVFwVGVT?=
 =?utf-8?B?WTJxVDhlUHlaNWdlMTFvZWFQdWp4bDF3TG80N2g4T0NxOURJa3Nqdk93enhU?=
 =?utf-8?B?VU1NcitGUGtVeElWNmcwNThKdGVMbFUvL2RvZHJRWm51NWVQZ3psd3VUMERh?=
 =?utf-8?B?RWN3amtleFFoTUk2MUsxWUxnK1NIdThub3N4eDFIbTB0UGhPV2pZeUpvYlB3?=
 =?utf-8?B?dWdmdVRzTVQ3d3NJQzN6SmQrZW9iSktGMFc4NDVDMzZDamVsbnpXVFF6UWlI?=
 =?utf-8?B?L3lacTViVmJYWWdHQXI1VUJNUkc4b2dJZnEwK1ZHQ2V1a0ZEZWpOL0xFb0Uy?=
 =?utf-8?B?ZllLSVlwa3ZKYStNYklPbHZnUTFDcWUwdWdCeE9IRGY2RGNpcEUyOFNuR1Mw?=
 =?utf-8?B?ZWJDUU5tTXBaUDdvUGZyWXpkaXFDYVRWZDhZb0QvNThjczB6UnNoTTJlOHVY?=
 =?utf-8?B?YlRoL2RPS3pzeUx4MUlUZXFLZStQR2JhOFphZ2czQ2I2MEQyU1JtWERvM0Qv?=
 =?utf-8?B?TXhwWHhzTG9qcG1INE1DYWI1R3diVk82UXhkS3lUS3E4MmU5czRPQ2FFcDI1?=
 =?utf-8?B?VThLWUd6OVVCNS9KbkVXVU1rdFlFaEVzNW44ZU9kOEtEVHF6NEJXNUJISTZt?=
 =?utf-8?B?bjQ0TFliajJHUnZVQWRySjIzMmhkbjREb3lJaTFBM2s0SFNHSlBaY3AzY3ZD?=
 =?utf-8?B?MHhuV1VSV3hUTTdaVExKRnl3ZDhyYmM5WVZoVmlHQ1MxZ3dPcjlWa2tZSGZt?=
 =?utf-8?B?V3hPRkd1TysvQi8wSTZmZHRGS01ScWFKdmUvYnJ3dGtrT2pqR1dPN2VmWlZ2?=
 =?utf-8?B?dXhlU2loRFU5bVh5cjRWUERIYUIwbDZmM0thOWJibU9HYnJndi9FWml4Vmsw?=
 =?utf-8?B?cTdOV1ZsQXNXaHVTWE9mNlRxWXU3SnhQanAxc2grYittL05HQUx3djlrYkto?=
 =?utf-8?B?aXEzd3lRcU9jTkpEMnk2dkRPUjN1NCtqVGl5S2NHSnpMTFIxTS9qZTJGL2pu?=
 =?utf-8?B?dExueDZUZnc3SEpTaUZ4Z3ozNDQvZ2wxSC9pdlcxUDdJbndUckVpNmllRXdH?=
 =?utf-8?B?SDlPR3VCTEJNbDJDcUNyVjV3cXZwMGJycGlQL09OMnBZdyt0aWt1SzRlaXlG?=
 =?utf-8?B?OFRXcyswQ252N1MzWWpWY2RxcG4xaHZFK29mVkVrMGtSVjFqOE5XRG5PQ1Ri?=
 =?utf-8?B?eHZDMlRHMURIbGlVWHdwajhCWTd5VjdtTHI0ZjlZWE94MW44TmoweVdjL0sv?=
 =?utf-8?B?RkxCQWZpZWg4WWMwdDlnQ2tMN0x4bHpPOVh5T0FoL2U5elRjeTB5M0thekFk?=
 =?utf-8?B?VEU2Q3JrVzlnUEVsOGd6cHdxd3BEaUcyTVA0bS9pUnFMeVVqU3VnRkhzUDdC?=
 =?utf-8?B?SmxJdmRReGlibkdnYm5mdFp2dldsdTdGRlFyU0pQZXlrNE1iUEcwUlVHR1ZY?=
 =?utf-8?B?cGtEMDByQUhXNU14YWFjejMxZ2lPTTh0ZU5KTXlrQUFLUnZMRFhmTXV1d1Ji?=
 =?utf-8?B?T09LMEdLNDBkeFlUUUZnWnRCMWlsY3hON28rSVJnUm9DbU1kL3JiSTU1Yjgr?=
 =?utf-8?B?QVZHU2xlQUNqQ3VjMVVBSHc0SUhicXR6OVo2cjRCYVNXU2VwMzhQMFMvZGhB?=
 =?utf-8?B?d3lTeVduMzVYM1pRUEE5NUZCMTgxbExOdGE1NUFTZ1ljaUJDU2JXSE92Mm96?=
 =?utf-8?B?cit1WmNpRjV1QmY4TzRmYkhUSEVBQkJDdGRtTk9GanRiZk9mK3pkeGJBT1dI?=
 =?utf-8?B?ckVGbHFTOFN4UHBydkhMamJtcTAzSUx4dEZTRHdHQ0N3SmdlYUhsUmtNS04y?=
 =?utf-8?B?VVEyNjZqMXBSRVp5c09lTkhaYm5qVFcxem9zUU4zYWI0TGo0SDhwNm94dzB1?=
 =?utf-8?B?UXZRSGZEbkRZNVdDWURwUXNYaEZvcXhBcFVlYkxMTXJVUGFFd2RrSjQwZlg3?=
 =?utf-8?B?TVF3T0drZFBaZW9CRjhnT0ZsQVR2VVkxUGxiUXF6MG9Fd3VGZ2RGYWx3RVRR?=
 =?utf-8?B?SWFVQXhYNHBvUjBrQXZVS01SNmRBRzV0YmdETFREUkpIV3cxTDIwSXVJTlFJ?=
 =?utf-8?B?RUQxRmdoby9WSWU5WGRjTDRRQUEwaVBLNE0xL3YxaldEUkREdmwvQkt6cDN0?=
 =?utf-8?B?YzVPV3FUSjBVOU9ZOFpFc1c1Z0w0cGl1N295VUtkNHFPR2tXekFZeHE3QzVM?=
 =?utf-8?B?QTNtWW1wWi8rV3dlT3NDYnBsTEZRdFV5azVTYTZsNm9rV0NMSXJkdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c188c6-0da0-4c27-5d57-08dedde73782
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 18:23:47.3448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Byk5t1mDov/uCa2/uXAYUevCX0pnVwQ5DKW1xOznQxCYL4e6IXqjvnfMXCu+V/oXlU4qc/qEOHtoFwK/DCSsvrfIp1254LqEMCu3T5kMgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11016
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

Hi Coia,

On 6/25/26 5:50 PM, Coia Prant wrote:
> The 9Tripod X3568 v4 is an RK3568-based SBC, just like the RK3568-EVB.
> It always uses soldered connections between the X3568CV2/X3568CV3/X3568CV4 core board
> and the X3568bv4 I/O board.
> 
> The differences between the core boards
> - PCB size, layout
> - CPU (RKK3568B2/RK3568J)
> - Memory type (DDR4/LPDDR4/LPDDR4X) and size
> - eMMC size
> - DSI/EDP resistor values
> Although the components vary, they maintain full compatibility.
> 
> The X3568 board has multiple hardware revisions, and we currently support v4 (I/O board).
> 
> Specification:
> - SoC: RockChip RK3568 ARM64 (4 cores)
> - eMMC: 16-128 GB
> - RAM: 2-16 GB
> - Power: DC 12V 2A
> - Ethernet: 2x YT8521SC RGMII (10/100/1000 Mbps)
> - Wireless radio: 802.11b/g/n/ac/ax dual-band
> - LED:
>    Power: AlwaysOn
>    User: GPIO
> - Button:
>    VOL+: SARADC/0 <35k µV>
>    VOL-: SARADC/0 <450k µV>
>    Power/Reset: PMIC RK809
> - CAN
>    CAN/1: 4-pin (PH 2.0)
> - PWM
>    PWM/4: Backlight DSI/0 DSI/1
>    PWM/7: IR Receiver [may not install]
> - UART:
>    UART/2: Debug TTL - 1500000 8N1 (1.25mm)
>    UART/3: TTL (PH 2.0)
>    UART/4: TTL (PH 2.0)
>    UART/8: AP6275S Bluetooth
>    UART/9: TTL (PH 2.0)
> - I2C:
>    I2C/0: PMIC RK809
>    I2C/1: Touchscreen DSI/0 DSI/1
>    I2C/4: Camera
>    I2C/5: RTC@51 PCF8563
> - I2S:
>    I2S/0: miniHDMI Sound
>    I2S/1: RK809 Audio Codec
>    I2S/3: AP6275S Bluetooth Sound
> - SDMMC:
>    SDMMC/0: microSD (TF) slot
>    SDMMC/2: AP6275S SDIO WiFi card
> - Camera: 1x CSI
> - Video: miniHDMI / DSI0 (MIPI/LVDS) / DSI1 (MIPI/EDP)
> - Audio: miniHDMI / MIC on-board / Speaker / SPDIF / 3.5mm Headphones / AP6275S Bluetooth
> - USB:
>    USB 2.0 HOST x2
>    USB 2.0 HOST x3 (4-pin)
>    USB 2.0 OTG x1 (shared with USB 3.0 OTG/HOST) [slot may not install]
>    USB 3.0 HOST x1
>    USB 3.0 OTG/HOST x1
> - SATA: 1x SATA 3.0 with Power/4-pin [slot may not install]
> - PCIe: 1x PCIe 3.0 x2 (x4 connecter) [power/clock/slot may not install]
> 
> Link:
> - https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf
> - https://blog.gov.cooking/archives/research-ninetripod-x3568-v4-and-flash.html
> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> ---
>   board/rockchip/evb_rk3568/MAINTAINERS     |  5 ++
>   configs/9tripod-x3568-v4-rk3568_defconfig | 79 +++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst           |  1 +
>   3 files changed, 85 insertions(+)
>   create mode 100644 configs/9tripod-x3568-v4-rk3568_defconfig
> 
> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
> index 7e17a6a987a..9ae22ce6845 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -1,3 +1,8 @@
> +9TRIPOD-X3568-V4
> +M:	Coia Prant <coiaprant@gmail.com>
> +S:	Maintained
> +F:	configs/9tripod-x3568-v4-rk3568_defconfig
> +
>   BANANAPI-BPI-R2-PRO
>   M:	Frank Wunderlich <frank-w@public-files.de>
>   S:	Maintained
> diff --git a/configs/9tripod-x3568-v4-rk3568_defconfig b/configs/9tripod-x3568-v4-rk3568_defconfig
> new file mode 100644
> index 00000000000..044dfe9452c
> --- /dev/null
> +++ b/configs/9tripod-x3568-v4-rk3568_defconfig
> @@ -0,0 +1,79 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y

This cannot be enabled because you don't have CONFIG_RTL8169 enabled.

There are a bunch of other symbols that are in this defconfig that don't 
need to be or are not applicable. Can you please send a v3 after running 
make savedefconfig and copying defconfig to 
configs/9tripod-x3568-v4-rk3568_defconfig?

If you edited the defconfig by hand, please avoid as it's error-prone, 
simply use make menuconfig and enable the options you want through the 
menu (and save before exiting). Then run make savedefconfig as 
instructed above to get the defconfig to put into the source code.

Cheers,
Quentin
