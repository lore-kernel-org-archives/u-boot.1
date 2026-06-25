Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CD0CDE00A
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 11:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF6BA84704;
	Thu, 25 Jun 2026 13:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WPposEhM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E4C684894; Thu, 25 Jun 2026 13:08:03 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B1C68460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 13:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/WSh42HbURVUIthwGP2KDldnZ+uh6ZI+ZEF7vdf7iSo5cUlooo53Q6OPnezQzTUZfJhkdJhG9DYlvEyDP0X/61zM53ygaMUSwVa0sp9z4nn8Q5qtl0LzGwyFQj5qHTjIPh3GkShmpzDQNXHoyy8D2Nn1tgZQUeLrrkBG0gKYZYiZJdzeEKKoJPYl+lIJ5WtG7WAbuyX+dod55U0EwwfTtYpYmZtR1joFLDr2Pd98w6AoveJCxGg7/vqDcJhtn1dIOO+JXqYe96ghscQElE9fCT33lSvguXlCl+uHMFaRrfSlIV4XCtMtUhI4+snGLUoc3eOTOeG49LKeo0mND4Tvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP/S2MqtzCSmc8fggwotDaQK0Nc5shmkO1WB0hd6ZK0=;
 b=fr+njLF9xM0NZwxoVwIxTDflD1rLLKSqBC2wRencwdeqybsNdIklyUfnR7dmsFNruddqE7+c6wGKVduJQNBWzhogrAh06IKmwhEw2cLHOfO974sbO7qu91LiVEEKI5yC+GQix2RL5wwnw2G9xM2zd6lvtfZfbIeormUJk/LQzDAQ+QgdaESNqc8ZXto14sCQM65h/cHZbWgV8qa1HO5YFoeeVvrMu1+oNvzifLrn0szaHhBIke1lQpdx2YPMXO2EWNU4WNVr/oF6q4A9MuPn+k47ZXBpbe9+aBbJZj95sVjjirjVACb0uk6OMrTuw+Qwk3bFXcpVqhRAIQnaohxGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP/S2MqtzCSmc8fggwotDaQK0Nc5shmkO1WB0hd6ZK0=;
 b=WPposEhM6KUvv1IFiKCihMz6MaTs4G62QbDQXVSUrpCNOsjoXqBNqSDQuWZ0SgIYwoHKgEWc9mXb3Whb/3D49RERRCzH8GemKgyCNH1bhE4usv99r/uGz4Q5YEmKDQwEKM1NSLLZQOR9M13Ek2afDFGN8o0NRePLwBPkOZPNyW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB11528.eurprd04.prod.outlook.com (2603:10a6:150:280::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 11:07:55 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 11:07:55 +0000
Message-ID: <dff17fb4-3113-4d37-9093-efc7304d85d5@cherry.de>
Date: Thu, 25 Jun 2026 13:07:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add for 9Tripod X3568 v4
To: Coia Prant <coiaprant@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20260527112922.554052-1-coiaprant@gmail.com>
 <ece19d41-5f22-44b8-af6c-b2b57909b678@cherry.de>
 <37B2BC58-9F48-4A66-8693-DED174E71325@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <37B2BC58-9F48-4A66-8693-DED174E71325@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0027.eurprd03.prod.outlook.com
 (2603:10a6:803:118::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB11528:EE_
X-MS-Office365-Filtering-Correlation-Id: 434ab917-e613-441c-bcdf-08ded2aa01e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|13003099007|56012099006|4133799003|6133799003|18002099003|22082099003|11063799006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: HorxM1s5TKZkmlXBwx3cB17gq6KTCVURl7QVOQjmZVTb5OQc+Pz/gQQyq376L6Cdf4Xw4nMwTLtzPD0tSVQXV+O9zg3Z3PCa6qyiWYB0DuWxjuNuPEIr5O8t/nQAwQk+N3UBtpwPa2JSImnyioh9Qej/j4c+ZVZ3sJrxbwbuMLTM1Bmdht/P9AUdOPvgPOLaJXNmKBoOzPhpFh888wcxd4u/dq0fqk90aXcqd90bXF2baG+/ZqD9DMXxEgHZXSID/2rPXayNEgyYYfkcVlaBiTZfNtmr4m9LCOsNn/keoX63k6cHP1LmF7Vm9FPKCfVUyEfAqty/CKSA6hJPWTXxxWUv1tp4TGqBulgJLPwWngjJNCaiUtmDKTqdK+cJ+9mkBOy2aXWyJZ5TEBzvuzLr/pAA5pWytVDhx4Fqgyubcx9YiLCZrXWsA8+SIugd2cOg9T+8PiW7ofYWbnfV4+DwKTja7l3pf6+J6nW+xX4UBl+om3jEsPAtbMvyPvxjV7OVnxifxyeM90nUm07ARuavePaBw3Jyvf5BHaxYsJ90fHtXIUtNgd8nNP5eCI2MMO+w7E3KeqDH0ESIH0h8s8ov8iGO+xCkX66pSeoY5pT/Qds3CNUL0BuBtjdmtMIdZ4uc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(13003099007)(56012099006)(4133799003)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEdtdU81US9IMkhSbVQwTVhibGhXMlQ2S0F4SnJuR09DMVhVVUduVkdTZHlH?=
 =?utf-8?B?N1MxQ2hoYnNEMXNiZHJaUUVqZXpWZHltdmZzdW5LTWVXYlhRalNBdGg2Rlgv?=
 =?utf-8?B?OExROGZwMHNWYjUwS1c3WG1pLzV5MENYMncvdkpBa2RNR2FYOTFvaUN4S0Rx?=
 =?utf-8?B?MnI0Rm94eE1TNFl0RXMwZUZGZTdWMVdsS3lBbThEeEFmbjM2UG4wR0VpWlQ3?=
 =?utf-8?B?Wm9wMXJmdkhLVVZnb2FlalQ2d1VnRENTRWVMMWhVVWlNNXc2RTA3UElzQ3d2?=
 =?utf-8?B?UVlxR1hPS3g5WlhlZTQraVdaL3JlQXkxSW9TNU5peW9FWnV1Mk4wNXpoaWV4?=
 =?utf-8?B?V1ZCclp6ZE91MFlrSC9FbjVPQVJjMUFReU9JRS9GRmhHR1RyK2hDMVMvOEVs?=
 =?utf-8?B?V0lXR3NHR0dmUlNkZFdOV2RBaVpycW96SXF1KzZSL29ESDhzbWZHQk1uSGxT?=
 =?utf-8?B?MnJORDgwd2JZVnRKOTlXRnFyRHBLek1NdjRPVS9hd3NveDV3bzdIR1ZKWWNr?=
 =?utf-8?B?OFdjaVQ4Q2YvOTdON3lab0xtSUtxQ0RyQ3J2MDV3VTgrbjZrV29ZUmJFQXZh?=
 =?utf-8?B?clFXcE5PL1RIMmYybWlVYU9VSVJoVFhjQnFCV2ZNVGJ6ZDdlYjNCVGFEeHlM?=
 =?utf-8?B?RTV6NTFpeUtQWWxqdlRkR3BBdGJLZHNkVmsva3ZlVHRvQ3FMc2VHRGcrYW9O?=
 =?utf-8?B?VmFXOWVEeDVDR3M4WE96NVVxaXA1M1NlY0xsVEFHVzNqam1mamo5UFB0YVJh?=
 =?utf-8?B?ZjYzbVRla3lHbURnMks2UnlYTFpYYmtYWGhrWFJlOXhJKzUrSmtZV1B0aVRt?=
 =?utf-8?B?dW0wTlZjRjY5OEw5aERab1ZDMlhTZUw0ZldRZTdNL0R6ekdKaytWaDBmVnpD?=
 =?utf-8?B?M0k1OVFPMEsyN0JEWlBNYWZrNU4rZXRpSXkwQXAxSTJEcXJEV2Nud09idnBZ?=
 =?utf-8?B?aTlDa1VWdHl6cmRDazdkTEpsalYvUFFEcm10dzBiMnpuMjRlUmprZFNoM3do?=
 =?utf-8?B?V254MVB5bk14dUUxVFZwaTdiQ1NQREFwU2c4ZHBtZVhFRWVLaXp0UXVGZERs?=
 =?utf-8?B?QjRRSHJPZzVFdjZhSzJ3bEVkc2ZxcmliZTkvOVRiM09MbUlRRkZEZ2ZzUWR5?=
 =?utf-8?B?Y1ZTLy8wdkRja3crd2YzcEpQb2JYVTl4WEFVQ1lFT0JwK1VmOUlpUnRVbVE0?=
 =?utf-8?B?ZFIzbS9qaFdkbGVWZ0lpalBMVVorYm56R3lBV2pGMWNIS09rNzdpN1ZhMkcx?=
 =?utf-8?B?WWtjVFVkTzM3bVJQLzAvUjV6ZEVTUE5rZjhuUW9PbWRQSHBMclhGR05OaVBV?=
 =?utf-8?B?bXlYcmJDQjhBWWt5bUl1cUsyRG5JeVRQQnRwc3ZndkMwZVNoTEZGdnFQOWZU?=
 =?utf-8?B?cEp6QWhnajI0NG81K09FRlF4dCtuY0FpNzYzZFJXSllCa2NqbS95TXBTTUdP?=
 =?utf-8?B?SmNPTGZuNFdUZmhiTWlGRXZUUUg4Z2M2eE42eUVQbnhLSkpodkh2STMrejdm?=
 =?utf-8?B?NHgwNGo4TEV0d2tjMVJOd1JvcHhpUGVnYW1EdHBsd1Q1bW5ubkxJb2hZR1BF?=
 =?utf-8?B?K0Iza2l2TXYwbDlWd1E4K0RpS1IwRDZvZG8vbGtlTStRcm1lRjRad0dqV1hi?=
 =?utf-8?B?MUcrZDdGc0dRcEZvUEIwV0V5cUp1aWFaNVE2elhRNy9LS2xnUCtiYWZ1V3Fj?=
 =?utf-8?B?VHlidEdDRkFaWFU0SXFtdzBwUURVaTZGK203RXRxc2VGcFJTZDFnbFYrbEZQ?=
 =?utf-8?B?RXZVZWE4VmR3UEsyNTRCS2V1a3YvQVozTHpyeW5TaWRNalQ0b2xBZnJFdnVh?=
 =?utf-8?B?MFowcEFkOENEUXo3a0lxQUFjZ3FFU2V4SmFSczRadnMyRndkYVUyWU5ZNEli?=
 =?utf-8?B?a1J2clIwOHdYcVhXT0VsQjZFcHAvcEFpNW5wMS8zcmRTOHUvZlFRSit3VGN4?=
 =?utf-8?B?Tmc1OTlwbFpNUE0wdllRQXZwbUJmWUNWaVFsdzB4YVBQbncrc1NsUEVYWDBw?=
 =?utf-8?B?QlNROWs0VHNkNnZNZ3pHWjRzb0x4VXBiZEdqaWR0SUlTTEhBT0NkTkRQcGpU?=
 =?utf-8?B?QjA3UlNTenNkc0RyZXBqU2pBNkpHUGxzaVlIOHBGWlovRGx2Nk9GTUM3dDg4?=
 =?utf-8?B?SkYrQ0pmVithWmsrQ1lrWXV2Z2VhZlBqSXBQR1JwOVJ6d2JPc0ZaZ2xvSFVo?=
 =?utf-8?B?V2RhaS9rSk9FaGprS1hiQXpBTUlLbXlvZW1tL0xscERzVWhhZEs0N0Z4RFZa?=
 =?utf-8?B?RlkzbmhsdFcxOGp6UjFMaEhiVjBCVTg1MWIzb3RHVWY1WVNIQWxTdHBjMVBO?=
 =?utf-8?B?VXRrVXVBQi96dTZKeUt5ejM3RjRNajBZTDZYVTJDeFN3NXRxNEtNdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 434ab917-e613-441c-bcdf-08ded2aa01e5
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 11:07:55.2608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lj7q3mTiY8sUFcvOiz6GRT+6vX+KqQu0eMOMegO140gjORV/7D1r2ScINluqkuA3H/CPILogglMwX879jO0cuJxbpIn2XiARe9W6pXozjnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11528
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

On 6/25/26 12:54 PM, Coia Prant wrote:
> [You don't often get email from coiaprant@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On June 25, 2026 6:30:46 PM GMT+08:00, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>> Hi Coia,
>>
>> On 5/27/26 1:29 PM, Coia Prant wrote:
>>> [You don't often get email from coiaprant@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> The 9Tripod X3568 v4 is an RK3568-based SBC, just like the RK3568-EVB.
>>> It always uses soldered connections between the X3568CV2/X3568CV3/X3568CV4 core board
>>> and the X3568bv4 I/O board.
>>>
>>> The differences between the core boards
>>> - PCB size, layout
>>> - CPU (RKK3568B2/RK3568J)
>>> - Memory type (DDR4/LPDDR4/LPDDR4X) and size
>>> - eMMC size
>>> - DSI/EDP resistor values
>>> Although the components vary, they maintain full compatibility.
>>>
>>> The X3568 board has multiple hardware revisions, and we currently support v4 (I/O board).
>>>
>>> Specification:
>>> - SoC: RockChip RK3568 ARM64 (4 cores)
>>> - eMMC: 16-128 GB
>>> - RAM: 2-16 GB
>>> - Power: DC 12V 2A
>>> - Ethernet: 2x YT8521SC RGMII (10/100/1000 Mbps)
>>> - Wireless radio: 802.11b/g/n/ac/ax dual-band
>>> - LED:
>>>     Power: AlwaysOn
>>>     User: GPIO
>>> - Button:
>>>     VOL+: SARADC/0 <35k µV>
>>>     VOL-: SARADC/0 <450k µV>
>>>     Power/Reset: PMIC RK809
>>> - CAN
>>>     CAN/1: 4-pin (PH 2.0)
>>> - PWM
>>>     PWM/4: Backlight DSI/0 DSI/1
>>>     PWM/7: IR Receiver [may not install]
>>> - UART:
>>>     UART/2: Debug TTL - 1500000 8N1 (1.25mm)
>>>     UART/3: TTL (PH 2.0)
>>>     UART/4: TTL (PH 2.0)
>>>     UART/8: AP6275S Bluetooth
>>>     UART/9: TTL (PH 2.0)
>>> - I2C:
>>>     I2C/0: PMIC RK809
>>>     I2C/1: Touchscreen DSI/0 DSI/1
>>>     I2C/4: Camera
>>>     I2C/5: RTC@51 PCF8563
>>> - I2S:
>>>     I2S/0: miniHDMI Sound
>>>     I2S/1: RK809 Audio Codec
>>>     I2S/3: AP6275S Bluetooth Sound
>>> - SDMMC:
>>>     SDMMC/0: microSD (TF) slot
>>>     SDMMC/2: AP6275S SDIO WiFi card
>>> - Camera: 1x CSI
>>> - Video: miniHDMI / DSI0 (MIPI/LVDS) / DSI1 (MIPI/EDP)
>>> - Audio: miniHDMI / MIC on-board / Speaker / SPDIF / 3.5mm Headphones / AP6275S Bluetooth
>>> - USB:
>>>     USB 2.0 HOST x2
>>>     USB 2.0 HOST x3 (4-pin)
>>>     USB 2.0 OTG x1 (shared with USB 3.0 OTG/HOST) [slot may not install]
>>>     USB 3.0 HOST x1
>>>     USB 3.0 OTG/HOST x1
>>> - SATA: 1x SATA 3.0 with Power/4-pin [slot may not install]
>>> - PCIe: 1x PCIe 3.0 x2 (x4 connecter) [power/clock/slot may not install]
>>>
>>> Link:
>>> - https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf
>>> - https://blog.gov.cooking/archives/research-ninetripod-x3568-v4-and-flash.html
>>>
>>> Signed-off-by: Coia Prant <coiaprant@gmail.com>
>>> ---
>>>    .../dts/rk3568-9tripod-x3568-v4-u-boot.dtsi   |  3 +
>>>    board/rockchip/evb_rk3568/MAINTAINERS         |  7 ++
>>>    configs/9tripod-x3568-v4-rk3568_defconfig     | 80 +++++++++++++++++++
>>>    doc/board/rockchip/rockchip.rst               |  1 +
>>>    4 files changed, 91 insertions(+)
>>>    create mode 100644 arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi
>>>    create mode 100644 configs/9tripod-x3568-v4-rk3568_defconfig
>>>
>>> diff --git a/arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi b/arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi
>>> new file mode 100644
>>> index 00000000000..e0cb8e3e7c8
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi
>>> @@ -0,0 +1,3 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +
>>> +#include "rk3568-u-boot.dtsi"
>>
>> This file is not necessary as if rk3568-9tripod-x3568-v4-u-boot.dtsi is not present, rk3568-u-boot.dtsi will be included automatically (due to CONFIG_SYS_SOC being "rk3568").
>>
>>> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
>>> index 030cdbe6f3d..0783fb203c3 100644
>>> --- a/board/rockchip/evb_rk3568/MAINTAINERS
>>> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
>>> @@ -1,3 +1,10 @@
>>> +9TRIPOD-X3568-V4
>>> +M:     Coia Prant <coiaprant@gmail.com>
>>> +R:     Jonas Karlman <jonas@kwiboo.se>
>>
>> I'm not sure Jonas has agreed to do this so please drop him from the Reviewer, except if he publicly asks you to.
>>
>>> +S:     Maintained
>>> +F:     configs/9tripod-x3568-v4-rk3568_defconfig
>>> +F:     arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi
>>> +
>>
>> Since you can remove the file, this line can also be removed.
>>
>>>    BANANAPI-BPI-R2-PRO
>>>    M:     Frank Wunderlich <frank-w@public-files.de>
>>>    S:     Maintained
>>> diff --git a/configs/9tripod-x3568-v4-rk3568_defconfig b/configs/9tripod-x3568-v4-rk3568_defconfig
>>> new file mode 100644
>>> index 00000000000..71c0087d369
>>> --- /dev/null
>>> +++ b/configs/9tripod-x3568-v4-rk3568_defconfig
>>> @@ -0,0 +1,80 @@
>>> +CONFIG_ARM=y
>>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>>> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>>> +CONFIG_COUNTER_FREQUENCY=24000000
>>> +CONFIG_ARCH_ROCKCHIP=y
>>> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-9tripod-x3568-v4"
>>> +CONFIG_ROCKCHIP_RK3568=y
>>> +CONFIG_SPL_SERIAL=y
>>> +CONFIG_DEBUG_UART_BASE=0xFE660000
>>> +CONFIG_DEBUG_UART_CLOCK=24000000
>>> +CONFIG_SYS_LOAD_ADDR=0xc00800
>>> +CONFIG_PCI=y
>>> +CONFIG_DEBUG_UART=y
>>> +CONFIG_AHCI=y
>>> +CONFIG_FIT=y
>>> +CONFIG_FIT_VERBOSE=y
>>> +CONFIG_SPL_FIT_SIGNATURE=y
>>> +CONFIG_SPL_LOAD_FIT=y
>>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-9tripod-x3568-v4.dtb"
>>> +# CONFIG_DISPLAY_CPUINFO is not set
>>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> +CONFIG_SPL_MAX_SIZE=0x40000
>>> +CONFIG_SPL_PAD_TO=0x7f8000
>>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>>> +CONFIG_SPL_ATF=y
>>> +CONFIG_CMD_GPIO=y
>>> +CONFIG_CMD_GPT=y
>>> +CONFIG_CMD_I2C=y
>>> +CONFIG_CMD_MMC=y
>>> +CONFIG_CMD_PCI=y
>>> +CONFIG_CMD_USB=y
>>> +CONFIG_CMD_PMIC=y
>>> +CONFIG_CMD_REGULATOR=y
>>> +# CONFIG_SPL_DOS_PARTITION is not set
>>> +CONFIG_SPL_OF_CONTROL=y
>>> +CONFIG_OF_LIVE=y
>>> +# CONFIG_OF_UPSTREAM is not set
>>> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>>
>> Any reason for removing clock-names from xPL DTB?
>>
>> Looks ok to me otherwise.
>>
>> Cheers,
>> Quentin
> 
> Hi Quentin,
> 
> Thanks for review, this is the first time I've submitted a patch to u-boot.
> 

Welcome to the community :) !

> I referred to some other rk3568 boards that had the clock name removed, so I left it as it was. There was no problem with the board starting, and I don't know why them remove clocks name.
> 

Yeah I guessed, it's what most people do but I don't think it should 
have made it in the first place for other boards, at least not without 
an explanation (maybe we need to fix a bug somewhere else such that we 
don't need to remove it in xPL stages?).

> The board is working fine.
> 

If you remove clock-names from CONFIG_OF_SPL_REMOVE_PROPS?

Cheers,
Quentin
