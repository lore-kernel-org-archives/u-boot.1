Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CC4E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 16:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 103CB8022E;
	Tue, 14 Jan 2025 17:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="N2Clas9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AC9D8060C; Tue, 14 Jan 2025 17:43:42 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3B3F8007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxWb+UZu+L+NEg+Y2FHR5Hp44ep/ahfkr04cbGf3sQ3eAuIRuuSq88d8tGT0VBEj4wsacsC0Jam4svoSIGSh3rjdkD+DNb4EQDioDOkVwyohE90Nx7p3nURCd1rSn6d1J/3TlDbixxjdKdA+z+IxL+d92dug68blqX/ZdvbvaHx6jYTPDu6KLPdUfk8QEDZlepzcGuQwlBNV8oBpTs9geLw8iWNYcl1FdHXLgawds2zS5B4uibxfl1BteVVM+x23wiIi1lX23iAl0fnuAQ/BJePjpJy9fp9AZrUiC8svOU/fmTjFMNNW99G3xuBkJZHut4M8B1/ek/i3C6HYlymhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGK518OelucMGhcXY35IbPAXve46LWEzB+bW5gq3j9s=;
 b=RUUsAYbXUnqMj3ZOphZTJ4Tv7UcwQj90eItPm6lTQm72Hpx3sdWox7ml3mbcxlB1UJDnRA/qsp5ZeAcRVC4QinpXQpkTtMMzE4DvsfNzSVrdijpqEnMdedBO5pszLNqfcNgqXJWDXTaHyuv5oRoMD32NvfcEhmFWIUoBA/enGFLqqgaEEnqII1ZVCbHZ/oYIhi3dS8lWR7js9hRi62/ltIzXDMm2gvU4X+1zYwCSkY84GOMeDMjrBpoKVNU5QxaX1x5ZvsB+AHmhXsXJbYis7s5HxnVtvREQ1R0aTRfa6cMjDB7qVm8nqdrXzul/QcEWEnd9yRiTgNavuWxf/UWWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGK518OelucMGhcXY35IbPAXve46LWEzB+bW5gq3j9s=;
 b=N2Clas9anigumvTRG0twuEaoQrO67tH8hgOzLJ+peTio6I00SlNsAY6WM/0smYKTQGM2zJrk2u9O/Ywuz/DhlJgVYumTF2HVsTBjpXnAHNjG6RCVLnJERgcfuCiJEsxlk1nXy99YTmeo36YD85PXJQd0Z/VduL2zmgInZ6pOH+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10882.eurprd04.prod.outlook.com (2603:10a6:800:27a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Tue, 14 Jan
 2025 16:43:36 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 16:43:36 +0000
Message-ID: <75df4e27-bd92-46c2-8e60-633c1a200302@cherry.de>
Date: Tue, 14 Jan 2025 17:43:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/20] rockchip: mkimage: Add rk3576 support
To: Kever Yang <kever.yang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 sjg@chromium.org, philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com, Xuhui Lin <xuhui.lin@rock-chips.com>
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-10-heiko@sntech.de>
 <421a8aa9-4f7b-4d63-8f5e-34eae97b8b06@cherry.de>
 <a1b48fbd-6870-42e0-a9c9-9617a0ee2d01@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <a1b48fbd-6870-42e0-a9c9-9617a0ee2d01@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10882:EE_
X-MS-Office365-Filtering-Correlation-Id: 11316e22-b036-4701-d13a-08dd34ba9719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3ExSHJQWnU0WGdrMVJTdi9aZUlKZ29FNjVDbjFMRWxyZnpYanU0OHpHRkxq?=
 =?utf-8?B?YTVEdnVJS1loQVJOVnF1Tmkxa0Z1OWZDc3pseHJwRThGR2NBRTBDQ3ZrMDEw?=
 =?utf-8?B?eU1IYk96YW1ZUmZpNU05WStJQXl0UmV1MFhHNytscksxaGxyRWxwTHdLV1VM?=
 =?utf-8?B?Vktpc2NXK1NoTk1rTitqcU5yVllrODc4czlmZUUwclh3UWJjUldwQ0tOaHRM?=
 =?utf-8?B?TkpPa0V4azBtc2hYR1V2Zngxc2E1cndMVGloZFVoREVZdzBid3dIYWRwaVFI?=
 =?utf-8?B?UXFURjFPVm1hS2dzZlR1SmZtMTNKOGFLOTlPVk84T0xKT0VaWldUc0hKK21v?=
 =?utf-8?B?UG1WQWdUWHUxM0tzYU9VdllqNm1BUnFLY0FyK3JVcFdxS1pVYmwvN1FnRWVL?=
 =?utf-8?B?MXIwQ21Vb0tPOHpqN1hzdWZSVmdmK0kzVGk5dGJ3RWtIRE9kK0hFc1k4ZlZ1?=
 =?utf-8?B?ZWJJVHI5dTdZdzZRMmxSeXo5cDdLV282ays5SXVRS3ZWYUFuS0ZzSldDeGkr?=
 =?utf-8?B?U0pTaVBlSm9tRkJGQVQyMFFHdFlmdDMwcnFkWG9rVERadTJLZG9Nd3czc3d5?=
 =?utf-8?B?WW9Kdnhmcy9rZ25VczhOTytrSFVaMUJBUGFPcXoxM3haOW5mOWpmQnlIU2k0?=
 =?utf-8?B?RWNzU0lJZU1zYmNadEdSZ0h2WWVCSFltaTZLcHFWaWh4TmxoRjUrNDVxNDE0?=
 =?utf-8?B?MGZleC8zMWhPQUp1UGFxR3M3ektWbm1vaitGeEFIU3pEN3Yxa2x6MzJIei9T?=
 =?utf-8?B?YzF0blJJR0hCWmRrd2JzMGd0SXdKS1hXWU9HUXpMRytJVFZuQmFpY05WSlJw?=
 =?utf-8?B?K0VoTzZLakppVmtkZjN5VHlWS0NRekdFc1RLdjVNUEo4NnE4TmxQTUxvZmJs?=
 =?utf-8?B?MVNLWG9KVm9ZQnZCQ0JyZTl3ZEtjQURENHpNWllnWVFCQW80ZXJSejFFK29k?=
 =?utf-8?B?S1UyWTY5YlRYOGJQRzdlTENwRmtDSDBTSk9hWVBFanNVdXQza09uYk9VRGlC?=
 =?utf-8?B?dEc5SXduL3dNTGV2VHE0MlhGRElsTkN6M051QXVEdnI3VzFMMFhsRSsxZUNr?=
 =?utf-8?B?TjBPU2FjSm5TM3U3aXZtZkhkZDhxOHBVMjgwbWhudm5Cb21wVVNER3hLL3JW?=
 =?utf-8?B?UlNpc1RJeU1hUE5xT0xmU0VvUW0wTnoxUTlWbE9aZEF3ZEZwc2l4SmFWeTdt?=
 =?utf-8?B?Y0NsdWZLR1YwRjFUWkJDTmNxaDBaV29MNGtJUGVnbHc4WTFaSGtpK21kOUI3?=
 =?utf-8?B?dytKODBUd3dSM0w2QlpReDBZOEY5UjdMQ2liQTB1U2pOeDArVUl4dXR6Ynoz?=
 =?utf-8?B?QVF1TVpTWmJkajBGb2tXRXdha0h4dGcrTnlDWHdsQmN3bUVnc3pVK0dDeUdF?=
 =?utf-8?B?RmlzKzNjT1h6MzhyUG8yTjgzbmw3aVdXK0pMOTR4djZTUDA2VWIvbXZ3bE1r?=
 =?utf-8?B?UXF3Z2l4MWNuOTFqMUYyQXB0U3R5dGljRnNkOXBRZWhVZTlpTmFyNDFyRzhB?=
 =?utf-8?B?TndHSzRkQzF1eUVkWU5TSnAxczIzaWxwNGJYY1dIeFlydGd1MjdoOEw5TzRh?=
 =?utf-8?B?VmladEE4ODFWbmtSSlUrVGRJYXBteUpKR09mTG8xS2JDdjZRV0dDNVl4YVhn?=
 =?utf-8?B?cXVTRjRrWEQvVHBFSDYxSFFxM29Yc1JpTW9WajBhaUZkdUNubjhXNktZMTVQ?=
 =?utf-8?B?NHFnM2RJOWc4bXNHVHp3NitHTHNiZ3lJSXFOdFNKTVA0cnBBdlNKQ2sxZjVa?=
 =?utf-8?B?c2VOTGQ5VkphTTU5R0YveGE1NWUvdGFDWENwY0lzVk55M1BPQm42Z1Y1eElX?=
 =?utf-8?B?RVZkbitLeHNMaEpTRnJKZU5oQnJlWnRjVUtmcHMxK1IxNGE1RDVYZGtsSmlh?=
 =?utf-8?Q?9R/Ky5uE+cYl4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXVQRjd2QVlPRXRWbEw3Zi9OMlVKWnZYVmd1amxJZ3l6UWUxdFVSTE8wbXZY?=
 =?utf-8?B?RGFrYnl1V0pEYTlvU1hNWGE5Vkg0N1lPeUNsZEt1SCtESGZDYUx6R0ptSllP?=
 =?utf-8?B?QkV6S2I1Y2preUpDS2tTZTkrV09DbWh5a1lvb3JQZklWU2RyeUtNczZGeHFr?=
 =?utf-8?B?a3h0VXBxbmlVMjdOaUtubEJZU25rblRMUWpGZDZzbUlEdkdTZ3FUcXhCS3V4?=
 =?utf-8?B?ZnZiVEZUZWtCbENtNm1GTEZtRWxrdFpMN0dZb1dQeGFlak1tUjVnVzV6Q3Ev?=
 =?utf-8?B?TVFJa0FwUlJxNnFCcFllbUpkTGNtampEcWVhM3hhR1FxdkwySHUzR1ppVE55?=
 =?utf-8?B?M1k1R2RVZ2xBV2dhVkc5azhiTURPTlE2NXVhdys2R2kxL1pUdXJsM0F5b0FT?=
 =?utf-8?B?UTZDd3lEdjk1MjZnc2hEWnZMZWhaSi9qRmdJaFV6aVA4elhYTVJ4a29qNWdL?=
 =?utf-8?B?NXk2N0lMa3NhbGtYUUZqd1F2MHZGZnlaSE1IcW1GNTE3SHJoS002aG1Ca1o1?=
 =?utf-8?B?NXg1OWJPYUNxU2pNQWgxOWdSVjJhSk1MZTNjeWlaMGpQMnVzYmhzditSVlZY?=
 =?utf-8?B?UzE4NGliRXBVSS9URjJ1Zmdqa0czK01iV0V1ODNLQ3NqSThnb2ZMMno0bTZT?=
 =?utf-8?B?UEhJMmNsWkdPeXAzWHR1SjhFQVhrUWhBUXNEeUdXK2FjMWkxTUp5MTV0ZHF2?=
 =?utf-8?B?a29Vd1oyM0svb0NqYkptLzRsWG9vV2pQdktpK1ZiaWF0engzK0JzYWdvN3RS?=
 =?utf-8?B?elFmUkljamhnc0E0N3NEOC81dDNDYlFQdUhBNTh1L3dpZ3c1SWlFdUhtajdZ?=
 =?utf-8?B?VnNLaEtkNGJPa2lrT25MSnFicVQzT3d4LzdEcmJ4UjdGaE40Tk9Tb0cwZkFT?=
 =?utf-8?B?bi83ZWN5a09xTU5GWEhtMEJWUU1FcU81VDhSaE1aT2xkOVNuaWNhc29EOGRa?=
 =?utf-8?B?Q0JhZ0x0UVBrcHQwcnhuKzNMc2VPMWFKdFo2OFg4V3dWanBtdE1KMmIxWjdL?=
 =?utf-8?B?dEpnMmwrcWdFdTlZUmZTUjBqMVdEaUZudlpKRXdwRjdETkY0ZFZyZGdmczdR?=
 =?utf-8?B?WFhaeUoyb3ZyZlBsM3BuZzNlc2p1QjNZSUxpcXQxUmlQcnU1djMxN2NOU1Bp?=
 =?utf-8?B?Y0dZNXdWVDZJTWh4VGtDRlVPNzE2b0hhSER2TVR2Qis1ZVRYd2I2SWdIcFZm?=
 =?utf-8?B?S2x1TUlWb1l5cktDbXFEdHphdmZvRFRUNmJKVDJkaDRRYmE2WUtFWVkxUGkw?=
 =?utf-8?B?R3RNNXFWQVpCUm5ObUphbzhUNXJyYXJVSzQxU2k4S3NzdGJzNDhudUNiOGsw?=
 =?utf-8?B?TUgzZ1JGaHNCaHpWZHpTdXQ2ck90cVJrWG02MFdtcnZCRUdJYk5BQ3ZPdEhB?=
 =?utf-8?B?cmdWeUxNcHVKTFNtUE9adytoU3FuOHgzaTdudFVBN2tjRUUvVVFYeDY5Rkpr?=
 =?utf-8?B?WXJFTzFBZ2taSFJ2dGlUMmJJR1ZUbHlVMGlldkZuUkpyQ1BHYTJtdldoUlNz?=
 =?utf-8?B?aDF1Q1JWaHluUEVDcUE1dDNoS0lkY0x4MUZ1UHZqNHdmUGlQSzFPSDUzOUYw?=
 =?utf-8?B?dzhmVkp4a3cxem4zQWVkcVFUSVZRc0gxbEF6N0JGWXIrN1pUNjdnbkZoM2VC?=
 =?utf-8?B?SlRlc1lOT3g1MzhpN2dxN3ZwUFAxOWFmdTd2UTZEU2xLUlZYbHMrWlltaHBC?=
 =?utf-8?B?aGtEMU9PRCs3NHVEVk1qcmlnS0JYM3pyZmhsZjIrRFhBZ3AvaW9zRkdqNG1F?=
 =?utf-8?B?RjF5U0sxRTZoSG9iMForWFl4aWVraUNPaGROYS9xcGdZNjJmTlFVb2QwVnFh?=
 =?utf-8?B?NHUzdDBKUkErOGV3NDF3aWhSbnBrdjJCL3NZenMyazFCbzRvc2FSTGVTVWxk?=
 =?utf-8?B?TC91eW16cjBtdEEvT2hSdEllTTUyU2RIZnFOVG9EV3hSRFpha1g4d2JHY1VD?=
 =?utf-8?B?NFBwUHg1WVhHb09MNDg3NytHbWYrb0hjbDJHT1NlWTBmcjNONzkyVGhGd1Rl?=
 =?utf-8?B?QllBOXQvcFdsbndVblFJaEdDVlVyb0xXRHlrY2NudmUvRkczOTNqdllqUWVz?=
 =?utf-8?B?d3lmb2Fqb0FqMUhSbmtDL2drTzFseVdVdHFvc0EwSit3VE04WWVVdzNSaEU1?=
 =?utf-8?B?ak5YVkNpMHdIalMzOU82d0VGL1FkK280MEZUWkQvS1lEWHViWmhYUWs0d3Rv?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 11316e22-b036-4701-d13a-08dd34ba9719
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 16:43:36.1672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h84HbY3or2vN4yntHoSlkzdc9a880gUGMni2VJXPcalxHk66oIZicA3WxApH4oTEj7gDJ2KUh73dqpNTly4dRIIwehlv85+MPKpU75NWX30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10882
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

Hi Kever,

On 1/10/25 1:54 AM, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/11/27 00:53, Quentin Schulz wrote:
>> Hi Heiko,
>>
>> On 11/21/24 3:27 PM, Heiko Stuebner wrote:
>>> From: Xuhui Lin <xuhui.lin@rock-chips.com>
>>>
>>> Add support for rk3576 package header in mkimage tool.
>>>
>>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>>> ---
>>>   tools/rkcommon.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>>> index 3e52236b15a..d89c7d3afea 100644
>>> --- a/tools/rkcommon.c
>>> +++ b/tools/rkcommon.c
>>> @@ -135,6 +135,7 @@ static struct spl_info spl_infos[] = {
>>>       { "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
>>>       { "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
>>>       { "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
>>> +    { "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },
>>
>> I don't understand why we remove 0x1000 here from the size of the SRAM.
>>
>> If I go back in git history, I found 
>> 915e09814a83128fee8b87b2ee2e5f4a17e04a01 which states it's total SRAM 
>> - size used by BootROM.
>>
>> Can anyone provide feedback on how one is supposed to find this out? I 
>> think it's not the first time I'm confused by this and I'm not sure 
>> anyone's answered me before, but in any case, documenting this would 
>> be much welcome :)
> If you look this change at vendor U-Boot, you can find below commit msg:
> "Sram total size is 512KB and 4KB is used as bootrom stack."

Somehow this value changed for a couple of SoCs in vendor U-Boot so I'm 
not really trusting it ;)

> This size limit is for the first blob binary which is TPL/DDR init, and 
> after running the DDR init,
> we need to back to bootROM, so we should not touch the bootRom stack to 
> keep the bootRom
> available.
> 

Considering we don't have access to the source code of the BootROM, I 
assume we're in the case of "trust us the BootROM needs that much for 
its stack" and there's nothing we can do to verify it?

Cheers,
Quentin
