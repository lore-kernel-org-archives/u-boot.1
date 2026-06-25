Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D065CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 10:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BAD7846F4;
	Thu, 25 Jun 2026 12:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kvgcomyc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AA0F84704; Thu, 25 Jun 2026 12:30:53 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47FCF8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 12:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgtcOQnc6+3sz43NIdEbPuEPMbkz+/tfgXUd6meSyLFE/sOK0Hvffm+Pt82bf0/06AhzH3+MC8O5tRwmM1z98R3OSOscL1QPpGEqBrKOItC+FhIe3gIZpH3W/1JV9WGauQwVUux9q9AfCJT4Q1sWX5OwUDl1wAzLfYS0V7ja6JXoybRLFo/7JTaIbuZtkNq6uDP0M/XQvvMpPRpGNOI/x6ysGw18V7KHbksN+MAKrGosyYumNGmLAHMLm3lxaOdIBPf4MJZa123ZHD3ETiiIxJOYVgHOW3b0QA0ENIn0m649/PfZrwnA5lBjBjZQxHQHG7y5bA1TdvtstRJDTD/ecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6roi5bcFbP8i49WQ2NC/QjlWbMc68jd3ZzOQMIubIM=;
 b=hRprnyLUHfwhX+jhiDzuCACfrKuUy57K+LXBgKGBr2CvSLBkOHiJQdWPjZ3b8s5cNFADRbkEtDKVbnEsGt8MgUUcCDQDf/K8Cbnv5dbkTmoyl+PA18bgdC1OXglsuExL+6KpyDLpgPTllTS2IYuH/+kIaV7m8Nq87pPU489aAdt7LzjuJSHApCV5K0iXAaIidrQBtVMOxZNGkTYsGlH6b6LDpckVK0njDzn2lt4RbTTql26C3MBiTi+eE2Ly/2x4GbFLNKLUjRk5g5F+CsQTvCxOhWSDwFXMFg5QG1eGYq7xTnuZ6Wgn30C3ShedzbG+l4k8RxZvIE5IJKHIKYKyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6roi5bcFbP8i49WQ2NC/QjlWbMc68jd3ZzOQMIubIM=;
 b=kvgcomycqW85aiSo2BeKml0pK5FGJ4cr37JlZS/P3qeDavV90Di0uPzT9LMLbBDle3cgzd4r50UZytq0vFvJ8S9oiEzXF0j9s1FttAYDaqGQoqrTaM+SpGIwdGJOWVgM3d15zbGVfiwC6b1stqmXWce5yJaG3nhE7UUP+9dxeVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM7PR04MB7078.eurprd04.prod.outlook.com (2603:10a6:20b:121::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 10:30:47 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 10:30:47 +0000
Message-ID: <ece19d41-5f22-44b8-af6c-b2b57909b678@cherry.de>
Date: Thu, 25 Jun 2026 12:30:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add for 9Tripod X3568 v4
To: Coia Prant <coiaprant@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20260527112922.554052-1-coiaprant@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260527112922.554052-1-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::13) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM7PR04MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 94006bfb-7246-470a-15a3-08ded2a4d204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|5023799004|56012099006|11063799006|6133799003|22082099003|18002099003|4133799003;
X-Microsoft-Antispam-Message-Info: /4j4BaczQ8bCq8NFWSHwuIHAXn/LOvbk2vfIm7BXbqjVXbyH9fzCe5WaGI72IL0k5PjZyuF1IR6EL4+IDNO7z1y2SaBtKub03PkEeuii3Mf4uu9GvVIhsnV2WuJ1e957wbGkgQaQH/43w+6z3kr9EJ+45gCJlZSsgB80wOuED+2dc6xTG5EK5N4C0gyFMVy9o/DbIpMTf4+FiK2eCBoq00pujSigpL1ywah7F/s3+l+csMk3JjYJz8TS+X+wEotKId5xNUx/guv+xoRcUP27+xDNxd8IdjYe8NAS/npbDBlbyCnVrzUTrYr8tCM1KMRh0ke9vlkL9B3mhm9P3eZRzvDL8RTeSBqC0fl1iWqJDcXt8+WrEljKKGX3+JTq7kJplrAacxnA4dKvVMUtFUQahQoU+NpcIkb1FO3ofTWUmgla62K4LaChtnC7mVhyC4EafXKcAsp6s4nGdmH67BduNqGW6IbNBa/BU9hUk0OjUpQKZKLKTxQUy4dOfIzUP5WwAQtfnxrsnQZDgbuumfpQzwoGTPSgvhVqaMnPNEbruaAbnHgjyiVNZJgdRQcidSYrN5I6uBFAwQgPzYwwnzHrkwOnJzPT+MLRNl677Xbuorku76wZ2M+L+Q8giNEWFwy+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(5023799004)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlRWNDM3bUVCVGRMMzVOZ3lkQUNVQmVTM1NQandKbVpRMjRwc0x0VUlpZk1m?=
 =?utf-8?B?N2pFRkNvcmJRL0R4K1o2RlNpb1FvK3JwL2ZXMGVtSzd0M0hwR3l1bm5sSklw?=
 =?utf-8?B?M0tNK2VsMHpRaWU3TEI2QXZxV01WVFhnOW5YV0xDUWh5ZFR2Ynp1elBEeldw?=
 =?utf-8?B?L2NKV2wrd0JQbUhPcUwxUUhpZ3l3UHUzWHhjRXlnbS9jKzJJNXNTWVhKRGo1?=
 =?utf-8?B?L0dwZmNkbGhQVjRoeWZxRFdzMWZtbmN4MXJOMVVLbmpmMy9xNlIzeURMWkRh?=
 =?utf-8?B?dy9lK0VJaUxTUGJFS296NCtGNzduV3Z1eTdRN1VSQlZ3YWY1R25wNGUrUVBV?=
 =?utf-8?B?U0o3R0llM1RDQzRWc3l3eVREMFlKSUZ1NFA2K29RaVM3MTBVcmlOc1drazgy?=
 =?utf-8?B?SkRPSFlqNktmdHdLRWNwU1k1cWhxbWJibEVVVWs1VWNiY25PckFHWThuTUlk?=
 =?utf-8?B?NW9mdDk1Q0ZvQVZEZW5wbCtjemQzQnZVWWY1bkhGWXVIVXlETHdBNXZDNkhP?=
 =?utf-8?B?V1FwRUJ4MU5mS0VYWWF6ZWVIM2dmdEtydGd2YXJSRzVESWkxcWtEbHgyRjlC?=
 =?utf-8?B?NUVXUEd4Z1NkVmtDaVBwMTY0cms1b1BXSEF5Y3pmQlVhaS9sendiT3lycjFn?=
 =?utf-8?B?Z1FIRmIxNlB4VnFBRkFaaVpRSmdzTlhrRTArVjk2SGZlR2p2Q0xoQ1lOTkt2?=
 =?utf-8?B?b3owODFBK216eVlJRmZVUko5eTNRR2hEYzQzOEwxMXY5a2tvYXZMWklEZXdW?=
 =?utf-8?B?OXA5WUhiZG1aM0ROOXFxc1RKRHF6Z0FLMjhpSGs4M2cyQUtUaEFBMjlCaHFq?=
 =?utf-8?B?WUh5OXNySnlPVkZScU1WR1A4L0ZGREVHZHA0cCt4d0xFVk9UaG8wOERQQnM3?=
 =?utf-8?B?M1cvMXBxOVlrby9uQ3E4eHZlTGFZUG9Jd1hINnExN0F6VkxHdCttV3UzeFhl?=
 =?utf-8?B?OTBHcStqOUVnRHdDWm1GKzYwaHRaRFN0RW5KLzV1MnZBWDhTWXZvaVBmQlpW?=
 =?utf-8?B?bG94OEhJMXdyM1RvZmU2Y2dxN3lBYlJXUzZiQ09vYWlyYXdnODhYWWpKR2hI?=
 =?utf-8?B?citUMnBGTjg0ZUl4cFk3OExmZjFMS3dteTI1ektpcG82eE4wY3FMNUQ1cWM3?=
 =?utf-8?B?d3p6bjNLSEg4bTk0T1BZUFUyeGlsTCs1S0xGUEptWlBoZlVucFloTjNQOGF5?=
 =?utf-8?B?KzFVd3JMTjBxbHZydGp4YUUrWk1WcWtCeVBCWGFzNmd0dXJZVnV6MGpPNmZq?=
 =?utf-8?B?ME85M1kydFFJL1Fxa2xIb29mamx0L2xsaHcya0N4QzlMWTB3RStQSG1Icmt1?=
 =?utf-8?B?NmVJSFBQR21iNjNYSFBEK2JoeE5UeEFTdkFVK2tpTDM2VnRZL21PaStLZkF1?=
 =?utf-8?B?bVFCd0FMand2YWZ0K1hmc29Mb1hLYXp1ZGJEaG1HVDNhL2ZqZDJVNEJIQnBj?=
 =?utf-8?B?ci9lR2ZERWJiemRNTEswWXIzV1lwRnEveElmM3V2L2w3eFNpWktodXgxSWVM?=
 =?utf-8?B?Rk9Mc3lUWHBzaTQvTWhoTEpoOFdXWWtsZnBub0gwbm1QK3ZxUVMxQi9TRlp0?=
 =?utf-8?B?SXI2aVFDdUEyYVNwYlhoRUdnZXpmdHg0N2w5OVVuU2ozakVOQUV6bWlYWlZr?=
 =?utf-8?B?N1huQzRlcmNmbjZYTzA1bUdrbmk5K2NnUHNmZ2NzMU54a2VwR1JHbXNlVG8y?=
 =?utf-8?B?RzhhVkFsSThaWGRDZUhwNUdZN2ZUVEJEMlRvbVN3WnBHMW5BaGVacFVMK1hD?=
 =?utf-8?B?cGZQbUlnZVhZS3V4SmRESG5ONThFRkh5MzFyc3ZrTms4SnA0ZGJrblJlTkNR?=
 =?utf-8?B?N2dKNDJSMW5scGtvMTJYaDNPZWFvWU5nbjlGd1dmZUllT2ppNkZTZXYzM3FX?=
 =?utf-8?B?L1dkQlZrVkJQditUbVZXRE9LVzk0MUZJbmR4ZGVXODM2cHRVYldPYWYrOFZ5?=
 =?utf-8?B?UGgyTnY2QTRhOFpLVmNWY1BXM3JyNVovSmxRUmxabEZuUjluNlNCRHoveEZK?=
 =?utf-8?B?eG8wRTNzOE91N2lVdVkxUFA3Wnd0NmpjNmhXamJzdkxUUDdNQk5rOEVZUzBv?=
 =?utf-8?B?UDdqN0Rha2c5MHF4cDZjOEsyRXNYRDRTOWJQNmNSakFsOCtxSG9YMFFWQVgv?=
 =?utf-8?B?OCtxMHZCUmhTdVpicFJqUm5FTi9ybEdTRWVsTlJMdFgyV0ZjT1FEV1d4VnEv?=
 =?utf-8?B?RlJNUEdLbjdvTXcvSUlxbmhpMFpwVzdGZUNZdXBzQ3JUbWJDekFxbnp1N25I?=
 =?utf-8?B?Mm1TRHE0aVJBWUJSVDkzMTJjdUJ1ZTY5ekRpRDlyNWJQaFBCclNMRm16Mndn?=
 =?utf-8?B?R0ZCTjRnTW1pS0RFRTV5MGVhTmdxOXdYa1gyM1N6aEgxTDVzRmZRQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 94006bfb-7246-470a-15a3-08ded2a4d204
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:30:47.4289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oWFXf/4738KTdXrlsM4rnOY1F5bYR44d+X+piEJTEbekIHmImtEwZ8t6HbQFvRzh+9vXndSYqd6iTEyAHJCotxzn44f7fiIxyDyKLSGKKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7078
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

On 5/27/26 1:29 PM, Coia Prant wrote:
> [You don't often get email from coiaprant@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
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
>   .../dts/rk3568-9tripod-x3568-v4-u-boot.dtsi   |  3 +
>   board/rockchip/evb_rk3568/MAINTAINERS         |  7 ++
>   configs/9tripod-x3568-v4-rk3568_defconfig     | 80 +++++++++++++++++++
>   doc/board/rockchip/rockchip.rst               |  1 +
>   4 files changed, 91 insertions(+)
>   create mode 100644 arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi
>   create mode 100644 configs/9tripod-x3568-v4-rk3568_defconfig
> 
> diff --git a/arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi b/arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi
> new file mode 100644
> index 00000000000..e0cb8e3e7c8
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3568-u-boot.dtsi"

This file is not necessary as if rk3568-9tripod-x3568-v4-u-boot.dtsi is 
not present, rk3568-u-boot.dtsi will be included automatically (due to 
CONFIG_SYS_SOC being "rk3568").

> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
> index 030cdbe6f3d..0783fb203c3 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -1,3 +1,10 @@
> +9TRIPOD-X3568-V4
> +M:     Coia Prant <coiaprant@gmail.com>
> +R:     Jonas Karlman <jonas@kwiboo.se>

I'm not sure Jonas has agreed to do this so please drop him from the 
Reviewer, except if he publicly asks you to.

> +S:     Maintained
> +F:     configs/9tripod-x3568-v4-rk3568_defconfig
> +F:     arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi
> +

Since you can remove the file, this line can also be removed.

>   BANANAPI-BPI-R2-PRO
>   M:     Frank Wunderlich <frank-w@public-files.de>
>   S:     Maintained
> diff --git a/configs/9tripod-x3568-v4-rk3568_defconfig b/configs/9tripod-x3568-v4-rk3568_defconfig
> new file mode 100644
> index 00000000000..71c0087d369
> --- /dev/null
> +++ b/configs/9tripod-x3568-v4-rk3568_defconfig
> @@ -0,0 +1,80 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-9tripod-x3568-v4"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-9tripod-x3568-v4.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +# CONFIG_OF_UPSTREAM is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"

Any reason for removing clock-names from xPL DTB?

Looks ok to me otherwise.

Cheers,
Quentin
