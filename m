Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF92C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 08:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2A9284659;
	Fri, 10 Jul 2026 10:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KInGlAYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36D18846D3; Fri, 10 Jul 2026 10:51:54 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C69428407E
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 10:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKrUD+5HE6KCF9Wc7jlYDG5Co7aNN9I/49KyxppB3xiCMRIfTN3+SBZqfSruqKwBLvOUrtR/nIlPK29o5JBYbQmFajvvAE/3yu3sdHuqBcOcCAtDB6orepR1lzwPqmdkBGtAY6VmZTEPUwu36EzuW6yIZo9fkmczNJTSUnhEDZXkPKUb+FF+GYQHIfg+nSo8iATc9Z8aC+LRsOtlDv5GtBvVVki8O52EhfZZr2zBWR3a0f1W8eGKoSd7oFqCeFZZY3WjjgkQA+qYpPMN91tsXQHaZTEqZ5NOx2kz3odU7nS5/ygZ0XZPDXYpSb+EtlgSnKnUqxPmAaFaAJDb9NjLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDNHKq6OvKep2vBaOY+oVl9xHWRQaBy40GGevaEuJFM=;
 b=qo3BfESQJPPnbQ4hHWkSZvrmUoLcA4JL5wTZVJqS/fi9+CukmDw27IyWxbcjOX66UJ7XX+raLMR9AaSxLffCh67s4uwvqY6Ew7vSzB9OtwENWONPm7lt7D7pvl+wvCiaZrK+YtvXw1SZVMnH3QQ/GtO3j7sjDNvycWrpCS8lUtYf3L6SCxgDDV7FL+2hvZgJLk9hbHRFXJ4a9rBqhed1UH9YaSKfh4VGzHGcqMWIvBJNSOHcSWhAhpUrIDiKAkElNEk1IBdaFenurI0a8yHBw2zrsQMu+vKrZWOMIIz1ggkV7WoamUPowKhBnRpjbPCi5LVQA8Kmd/87IQ5J6+7ELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDNHKq6OvKep2vBaOY+oVl9xHWRQaBy40GGevaEuJFM=;
 b=KInGlAYnkANpuQ9ecoX/L4dkV6B5fhWGSkDHHZXX4AlljM3AQoT+jO6tZdutyp5wdH1XOoMwyRKUICylG3EOwVfjnljI9Bz6BAiHOkFSvaSunnjtYRzxq2m5mdQr+86bjwjA3DuO+IKkZOBBK4+YyXBSqjxL2SIARMGSy7KU6Ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DB9PR04MB8089.eurprd04.prod.outlook.com (2603:10a6:10:247::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:51:48 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 08:51:48 +0000
Message-ID: <cf43de1a-b2ef-4e98-ab06-fa78f299e3f0@cherry.de>
Date: Fri, 10 Jul 2026 10:51:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] board: rockchip: Add support for 9Tripod X3568 v4
To: Coia Prant <coiaprant@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20260709185101.2149485-1-coiaprant@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260709185101.2149485-1-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0099.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:351::9) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DB9PR04MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 04190a3f-2cd4-45b1-4b63-08dede607a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4133799003|5023799004|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +Ze3bDZgYDpD3qlYEPllHeN2AcG7phnHQJn1W1OIhA/Tykftim68d2r4eUakHGNw8wNqfdq/7m4zM0j9uPeOMgPVPErdnaLAvZic1Zjp1PANGgGekHio2RYWGQO5IXtfk6SzPB8ECVFjs30MqGYRdo3Co6cJgeRDsxdVE7LAwsQt/CGBRNLVYhM8v/D4qWdW2eFxS0k9XSLCiUM+bpAr1teURFb1LcaxT5Q+oqRD1lTUQfaAWTMH1CGjLiMFfOAqu1EN8nn148pCeplFv+FVuWenYXSlCYQTgtXYs3HZ3+DihEX26irFouhmZujSDh/zyZVtI6tCgyzJzGSlu6D7budyiWpXfsBlDnkX62QyYme21NGIZSOmBy32OuKSZ25/05FBzsfIUgQXt1RJu8xfnOUgoGc61FN0lnPyFJI9l+3YhYqIat2Pq4nGnBMbHHUeIk/NI7fNrBZjFhGl5RUTDOOdgaGfPCDymPAVuoOksFim4USpG6fn1txdyKjDmc5kx+NU32jX5RoEUDkljp57bQkKkWDwEd8v8FeK7u0GPugku73j9/xKsNv72f7W84MrJ/G1qzSI/k/HEqvo81sYRv5z/xEIQGgX7feA1iiJDhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4133799003)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGo1c2dIb240STl3WGxiNUpySnRUN2o1b2V6My9qM0ZieWZZWXhLYzIwSnVz?=
 =?utf-8?B?UldzNkVLeVJHMGJkR0tNdHVNSXUzRytRWjlwK3VOK3pvYlBQNWUxUjRudk5l?=
 =?utf-8?B?TWlIZmFFUnczK3FxVGRyKzBUWjRud25kNG5vT0ZqeGVEamwzcHNwUDBXRDJV?=
 =?utf-8?B?clMzalhXYUEvWXczTncvSWx1VmFGMm9mQm1IaERCSEZhL29ISFV5SENlRE1Q?=
 =?utf-8?B?a2U0bEM1WVVyQnFMVElSRGdzdk9LVjVvcmNsVVVKVzU4anVZOTVxejhwTEF5?=
 =?utf-8?B?YUd2SFF0dFFVNjJGWUJXSWFEVmU1MDhxL2dXQ2pyUXppQUQxMElQWFNsdzNr?=
 =?utf-8?B?NzEybXpacmVDQWEvajdiWHZjSXR3WU1rakNnTkowMjZUZUVoaEhkZmM4S0RL?=
 =?utf-8?B?VUp2MlVaQXI0elFPQ2I4Nm5pM3NLQjFFblNWeklnd1hRdTVJK09mckszem1m?=
 =?utf-8?B?bHE3WXorNDlFdDJVQzZ2OXlXU0JYbXJwRmZDNFJmRjZmOW5PTDFlQWRsakRN?=
 =?utf-8?B?TWJqdGNZbjR6bEkzWmk1czhoOGg5NnRRN0FUYXB5K0d3cGNSSjBXTEgvTTVX?=
 =?utf-8?B?cWU4VGRtRGRoV1NQTTRVN2FXZWpBSXRmcUJWOUtERE9rU2NLdXFmQ3k2M0VT?=
 =?utf-8?B?MjJTb21sQnhpc3FocGxXTXdHNnhoWitqQVBVZjU5emdrWFIyd2IxNHpxY21E?=
 =?utf-8?B?dDMwQVJ1R1hZMENiSkR4UGxhM3FSSmhsRWpYeXVTSmxzK3ZGT01xU2x0ZlBa?=
 =?utf-8?B?bE5DRklCS0Y3dDI5SHN5RDFqSThVTnRSbExySzl2TVBnYVc4SzNBYVZEZkxY?=
 =?utf-8?B?MkFKc3BXTGxOYWZxS2FvRmE2RUJhck5tdVFQSytvUEt0YUNDZGJDTE9JTHBi?=
 =?utf-8?B?N3YrYkE0RDJXVEltTThXa1ZCRXlmTUlPUFU3ZkJQaXF4NjhobVltaE1OWjZR?=
 =?utf-8?B?OEVxTVV6R01ZTVZWZ051Vm9ML1I0MUxuc3JNWFNMR09mR2s1UEt1NFJvMjdK?=
 =?utf-8?B?RGNLOElITHEvRHJoaVo5R1ZNdm5qMWdBTEZxWUJ6cjFsZ21TTjVmUFJnODNp?=
 =?utf-8?B?a2E2Z3U5dXF3VTNmbGorKzFiYnhIOU1rc3ZhUHVPdXRjR0Nmdkx5biszeWpD?=
 =?utf-8?B?UlZOdUpNNU1WMkxQRGg3RmNNM3BBYldmdUQ1S280aDFOa3kvSkhGYVZMbXlM?=
 =?utf-8?B?SWFjc3N1K0k0ZmgvUGpyUExCSlZwQ1VSemc3UTFzUHY0Y21jYmR3eXVXY04v?=
 =?utf-8?B?WjUwSm4ra1FhSnl1ZXJMWTlvRUJQalNnZlZzTnZLVlJjaGU4MXZaZXVwTFp6?=
 =?utf-8?B?dm5oK1V5NWZIVFM5aGFLWUR3U1c2dEhMckw4eUFxWFhNdzZYRDV0VFI1L2JI?=
 =?utf-8?B?UXBjeFhNSnRPdkpxaHovYmIxRVlHWWJLVXFoUjllWDhnc2hhSUZ5UzlKOEJK?=
 =?utf-8?B?Zkk3S0dtS1NpSjZvclM3OWpGdnFRWVpqUXdYVXZlSEtDcllGNzhSQVJ4QXBD?=
 =?utf-8?B?WTJuN3hVL3ViTkJScFNOZGQxYUpGSno3R09HSldqdnRmVHVEd0ltcGtVakFQ?=
 =?utf-8?B?a0tFYTBtQ3A5QWZNK1ZmNG5BZ0Z0Z3BxcDNxMXl1ZUVOT1c3UW9MM2tLQjgr?=
 =?utf-8?B?UnpxM0hCbmdDWU9kbWtJYWJTTHBUWHB5ejIyYUs0WURBS09HVGZHRmVjaGRG?=
 =?utf-8?B?OEhzcFEzMTY5cTZ2byt4QStQeVlEV1Bwck4wOXQzV2ZwZzB3U3RmSmd1YWZj?=
 =?utf-8?B?eFVVT1hWSFZwcFZNMXBvL1JaZXhrN2tzTG9PNHhkS0RISDI5R3N5SWREemRq?=
 =?utf-8?B?dTBpR3lxbDhjNjQrNW1JZEtMeXZwSnVibTU3VTRhS0NuK0F6cXU2dWwxdnlX?=
 =?utf-8?B?bWo2aGZ1NGpjOUFmNUdONkJvL1U5OFZUMFpVbHFHVlRHVXdOcW14TGU3bkpX?=
 =?utf-8?B?YlRqakdBMThzNTJNa2IvNjhGenA2eURxeDVkV3ZvREpQbzM4amdFTlZNejRn?=
 =?utf-8?B?NG5XUHFZS3czZVRNaFRGOWRjKzJUSnVMWE55KzdUMkhnMWNNV0VhSGZncEJD?=
 =?utf-8?B?eW0vMzNsVXllMUMwZnl4NTFELy9GeWdyWElHU3Z3WVZvYzc4d2xCTjlIQ3BR?=
 =?utf-8?B?bmVkY0w5K3hYajlCQkJycFUzdjd6Zlp0eC94YkJrVnBlblRLQktzcGVZYzJJ?=
 =?utf-8?B?UiszM0orZnVJWURsYlhIUGl1SWdoK3BWcVl2b2t1dy9xT3NMNjZqT3JsZXd3?=
 =?utf-8?B?R0JwL3NqY2wxL3R0VnFMcEY1NmdLYkkyN2NSM0cwRGxaTCtJVi94eVZLSnRW?=
 =?utf-8?B?b0dZK08ySEt0MTQwSEtIRUI3MnlQRWtnVGJUNEQ3Zk1oeHVndVVWUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 04190a3f-2cd4-45b1-4b63-08dede607a25
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:51:48.2295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25PUOG0Ht2FTNPQbdTEDCPyIXqVQl6ASZabMy1tmdMhokV7bFvCO5Ki26Ic1oU79iWgVWPw2YrA4BMkJvBgnQoRIe8lKBzLJvold+GUL0So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8089
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

On 7/9/26 8:51 PM, Coia Prant wrote:
> The 9Tripod X3568 v4 is an RK3568-based SBC, just like the RK3568-EVB.
> It always uses soldered connections between the X3568CV2/X3568CV3/X3568CV4 core board
> and the X3568bv4 I/O board.
> 
> The differences between the core boards
> - PCB size, layout
> - CPU (RK3568B2/RK3568J)
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
> - PCIe: 1x PCIe 3.0 x2 (x4 connector) [power/clock/slot may not install]
> 
> Link:
> - https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf
> - https://blog.gov.cooking/archives/research-ninetripod-x3568-v4-and-flash.html
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
