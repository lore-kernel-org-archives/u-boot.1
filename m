Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2F8CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 14:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0B418490D;
	Wed,  6 May 2026 16:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UCbSq6sa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44D778499C; Wed,  6 May 2026 16:55:05 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F2848490D
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 16:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2y1rDitDWCohzc7xZNPR0csqWLUv7mJPFOI0u6HlkpUHqpdv5EDMxOD/AKaCRYl9we+N36GYAcOX76MSUYy7H4SsvewmnKrsnJLaMrft1WCWXHxxDgdoYYxoUBecOIsYJWhFBT9/zL/zCi8tm4gJICsyRj3FcJgsG2J2aaWfLC/Qw1ez1yOexOdrdBpPb7mDJjGUKch06SXvfV1wl0mgBmy9TUi6OwGdZuBYrGHxA8u2CmdliFKQeXXBLuk4Ia/LOEpv0Tlcc+/cUroHHfBeRRDYQ3sDB2OZntJaEA+awCPr6OOQjBbGjo2TdAncRQs6z8AS2Af4wdu2XNhoHhwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Xxi2y1gVy+m/FChBj467qtfS4+dz1eAb724c7vIX38=;
 b=qievs37R088+vT//JNEOmCl1fBRsLaFvYG+plwDPFp05thUW3WjavFeW5JLTMDLF/9AFdp7j3oNo12XCwUV3AQ+FqWq1t589c1bSzX7Nq7nu1WRTavwhgBEW087kEucfnG79zsB+eF3+HOmKxlv90rxstOE1BSX1aXYlSXOj+aNhONNZtflJABxtUxuLq5R0d9UMfXLw62lCcz9TR3U7Nj9TIsVdf4wVwP9jjjidvqpafcSXdh+whR65cx/vEydlFNAd+iR6/BYSsX/9qath/uxrLYWicqCq+1D55Yzt1yvzijSz1TzsTySCqN30nWm4OBle3m4bjf6FMG6WOV7TJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Xxi2y1gVy+m/FChBj467qtfS4+dz1eAb724c7vIX38=;
 b=UCbSq6salgYK4PjYcp1lCH1UQmC6jqppZH4u6BfOtGxA4Woe25NP5aOi3GgSG9Yr9y0JgOR9pcVrTdluHRZTTlyy5rk26yUOB0e/m2KWKhdwm+AmMfp66oHOCM8D3KpGzdD3L36Kfy7xL5Wc/BZuBySr53zH3tryNWKV11zboVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM9PR04MB7665.eurprd04.prod.outlook.com (2603:10a6:20b:283::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 14:54:58 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:54:58 +0000
Message-ID: <92636434-5381-473a-b495-ea54b93d1d9e@cherry.de>
Date: Wed, 6 May 2026 16:54:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3576: Properly handle USB controller takeover
 from BootROM
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Anton Burticica <mouse@ya.ru>, Marek Vasut <marex@denx.de>
References: <20260427-rk3576-usb-gadget-v1-1-982fd1de08db@flipper.net>
 <c2d737f0-a17e-44e4-8e07-53ce3fa0e543@cherry.de>
 <CAKTNdwGo434ShEsP=e=uUAbJzVxfQPPfNPeTxOOqwbuoCyzRjw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAKTNdwGo434ShEsP=e=uUAbJzVxfQPPfNPeTxOOqwbuoCyzRjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0049.eurprd04.prod.outlook.com
 (2603:10a6:802:2::20) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM9PR04MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 90632bda-ca14-4011-e9bf-08deab7f70f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SieJRxC/F1Sp+7tKmSGAmv2GwBszpI826QwLiBCOTi33eYdsmmTUYaPRYgcQjD9QyiaT+B1QKBQFUwjr/mZvhgcnpu3+PuYZlJjL5wjhOeAPiG8U+47v/1XrmjTleQ6wWMViw+cQ06iSPAXAQNtgotb2uMO4QyuSaszJmEHOtzwohsD3FVgL9U3SMnhRw2xuQeiLSOfUvUc+2PaR2MGO2vTk+mvEA4CpfYB+9tkvQHThhD9KSXLWZcBLzfFMxTgSXPuP6l721hRnX2YbDpZvNYsmtEEYTOENQHvxjaGVcYSzVeZAHsIV45aS5SkVhz92kmo05j607vgRtJ19JbyINrfqAigohOQi9/Dr0u6x5sdKDYXSBwEhRlwNjwAzrHQ57zN4Y8rGlTSZhfNuDEtkhYaiNPg+CJQwFEvvNQDGDCC/qVCkDjF3YVmErBptRBjEdsD5bXGCWFFrJBFpdkehLeiT5DXVW3qkPWVpLuj/XjkYQGToBZZyZQODgrpJur8zHWwozbu4Kggi1a8aFvhhnaVjYDdV56Gzaw3aP7WqBKFViq2TlI6/E2iwAUIFliX+Xb22KCjQOI8eMOjciQ5L4aZY8GrUd34u55r7sfaxXKdspvsbGlRls0W4EQGHi+RCbx3J+9JP126hOEqKm0NGf3udQPC20hDwaxz+yZ6hCmvVX16Rxt6F+lciP7od3I3DWAD/zcN1Q7IbG77ey4qSJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmdnZEloTGUxTWk1ZmdEa3g1Qkpxd2NnYUFhd3RFdnRtTzQ4cndOdDZtWlly?=
 =?utf-8?B?ekhuUW1JeURIQjAxcTNtd3M1U2c0eDBNZVE1NlJQM1NmK2ZsbTlHNmJXb3Qz?=
 =?utf-8?B?QVBqNEdMUTBkT1N5dGFORUtSS2RnelhEbyt6cVVidEtkUnY0NGdLbFFRNmkv?=
 =?utf-8?B?bXRaaUdEVWdIVTV5Y3pQUnR5R2F2eWlsMGVEWEZ2WWFveWVDWERadkd0TkhE?=
 =?utf-8?B?VlROMUdpUWErdXBnZ1hFQUx6VlpTT1JoNTkzVkF3cVZ5NnJCTEluUnd2TjRM?=
 =?utf-8?B?S3EzdUJmTjZXZ3NibUdKMlowR2NCaDJ1dk5qR25hR3gxelFJQ0VCZmtVZCtp?=
 =?utf-8?B?MVA2UXJqZ3ErdzMzaWpqMDNQTWtHSVJ3SGx6MzdLNk94UllNbHB1VkxiQUJF?=
 =?utf-8?B?QTNXdnF5a1YrcDFHNDdXQ0prbjlBZ2QxNFF6VjlnRzlialFuRWV0NTFndGpI?=
 =?utf-8?B?R0VJWHk3TWt1YUFSNFN5UW1SOG5rT3lzOHNLQVk1MDQ0Q0c2Y2tmRlR2UFJD?=
 =?utf-8?B?cnRUT1UvWllpM3Fxd1BxYnFsZGNEZ1A3WlJUOGVCTXNLeHIwUVhMcmozajZ3?=
 =?utf-8?B?MkdBRnZGOGV2WjRkTTZadWU3TUtyQVQwbVBLUmJSWlRiSHBhUENQeGt3elFF?=
 =?utf-8?B?OUhrTWdxa3JmR0JKakdheGgrbTJQUlRvRlhXaWc4bVRuSmU4R2VBdXNkVFBu?=
 =?utf-8?B?Q1JuazA3cUpWT1BXNG1pSkpOaCs1Q0JxZmRhZi93QXdFakx6L3U5WVVKT3Za?=
 =?utf-8?B?MEgrOU9ZOHprVXE2c2ZUaTJYbjJ0bWZHeEtiaHdCY2VtaWZaMC9CdWFNQ0dZ?=
 =?utf-8?B?MjVOOHB4QmxVODV3MEdhdVJsSU16em51QjVFdCtnbkF0a0dZRE1Ia3Nvak9k?=
 =?utf-8?B?WXg2U044QVcxd1lBeFBjL2hYT1Z2Z2l2MHJGZlFXMzF4cVpOVzV1WDhnTEFk?=
 =?utf-8?B?Z2J5ekdOY3N6MWU4bmw3Z3FIWVRxajh1ckQ4ZFBaNXNiRUZNTU8vSUdDU2tG?=
 =?utf-8?B?Q08zR2tVVVNFUTJOYm1neDZoc0RieU1PYS9KUWk3R0pWakNMdW5yZDlJS2Jv?=
 =?utf-8?B?Rm5SSnhYVFMrTG1XYzB1TUlEWnhOQXlzbzRNVUcvM2poWmk5QjZnTlF6Rmxr?=
 =?utf-8?B?QU4vdnQ5TmFhc3ArVURrRXlLVXdLc01mWXIwYktNblNzVXNTNFBCSEVHNkhY?=
 =?utf-8?B?OTA0M21DeUkyRHBTSzl1TTM1S0dMYndwaS9ScGpDUmxVWVgraVdHNVh6Y1Ir?=
 =?utf-8?B?blREbVRCRWVSNDNjWEpKQUFSRWVtTE1qN3dDd3NNNmQ3alZham1rbkZpM3dF?=
 =?utf-8?B?dG4ycmgwODN5TTNiYi9JckhGYWo0eXp1ZVNkUEhaRmFHZXBsZXVIMFJkY09p?=
 =?utf-8?B?R1dUdjhaT043SG9QVXlJVEJKRXBtV2JKTjZEbmdKaVljV2JqdGtXQVF3SThL?=
 =?utf-8?B?SE1VNnBKSU9qRVVubFpJNDlQTXNMM3dLRUV5cW9Fektva1VjeHJiZ3RJcTNj?=
 =?utf-8?B?M080L2o3TGNsaXVaYXBlVzlENU12a3NOMkdNMURZdldEKzJhUU9BazhNbExR?=
 =?utf-8?B?aG1TaGxpQU1teFk3UWpWWFN2OW04R1ByY0NSbUlVeXB3UUJsTnFhU1B6TG1W?=
 =?utf-8?B?ZWxIVFNNQWRHN1I5d0t3V1FXd0xaODdLUWVTaXBhMXQvRGFqVDZGSkY5VGhh?=
 =?utf-8?B?Nyt0bmwxWjV3ZEg3ZHpoZVNFN29jSzE4MVh1aXZ5d0ZPczltbkhvbW1HT2Mr?=
 =?utf-8?B?dlZscExyWkpFVjdsSVU1MlQ4blcxK0FiUWlxOU5QWVQvT2ZLdFMrRlAvZ1dC?=
 =?utf-8?B?WWNVVFUvTk1rSHpkelExV2tZY3Z6OGJyQ3BYRzhzcU9zUDZPK2h2NXFjNGpw?=
 =?utf-8?B?THUycTBTUHVaQ0tRbVI0QTgzbTVyQnVnSjlOSS9oU2QvWSsyY3RWcGVtcktp?=
 =?utf-8?B?RnduZnhVSDBjbmhzSHZESFYwU1YzQk9pQ3kvSkh5T2RPck5HRDE3K01OOG95?=
 =?utf-8?B?QVZodS9rbFZjT2ZsSWRqUUdHcWRXUStWS0hHMlVrSS9RRHhhZlkrZ2V1c0Zy?=
 =?utf-8?B?RFEvQkxCQnI3RXZQVmFCS2dSMUVOcGo0cUVqSW91ZGd5bVQvWUxHS1BsdkRI?=
 =?utf-8?B?V01GSU41YTVOZEx4TE16QTVkRFVoWXRkZkcvU3hjVmRPRnZzRlpVOTU2cHlu?=
 =?utf-8?B?MDVaYitIaEZudjlIalhHelRIVE5uMEhiNm9BL1ZhS2VTT09JcWU2MkVsQXZa?=
 =?utf-8?B?OHQyeGUxZ0ZnQTRuRUQ5bFpoOWUzOUphRDBtUlRHVlZHL0pIblZURGRmQkpD?=
 =?utf-8?B?dlY5elNCMk9iVVRsQmtqUE1jQ0JIdlpoNU45bHFqa0RUQmdRSXV5aHRjSlY1?=
 =?utf-8?Q?Pn/yqf+N56CidBWTLOvYkyvgDtga+tSYaPxmmFlto/ynu?=
X-MS-Exchange-AntiSpam-MessageData-1: rUcmH6cwxNURgbTHYprEg082iVA/YaApU8U=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 90632bda-ca14-4011-e9bf-08deab7f70f9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:54:58.7432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYVQGRejRiVjii1VPp6lGmayjkZnew8/tfElavKK9UJNuW3wvMVZMCwYwhbrkps+EB81qtn0UJtAPcoI2Nx4CHLtmaGpcaVuk4gybFyhbzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7665
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

Hi Alexey, Jonas,

On 4/27/26 6:44 PM, Alexey Charkov wrote:
> Hi Quentin,
> 
> On Mon, Apr 27, 2026 at 6:43 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 4/27/26 2:53 PM, Alexey Charkov wrote:
>>> From: Anton Burticica <mouse@ya.ru>
>>>
>>> When booting via USB download mode (Maskrom), the BootROM leaves the
>>> USB3OTG0 controller in an active state. U-Boot must properly reset
>>> the controller before reinitializing it for fastboot or other USB
>>> gadget functions.
>>>
>>> Without this change, USB gadget mode commands such as fastboot and ums
>>> fail when U-Boot is loaded via Maskrom USB download because the
>>> controller state is inconsistent.
>>>
>>> Signed-off-by: Anton Burticica <mouse@ya.ru>
>>> [Removed unrelated changes, adjusted the commit description]
>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>> ---
>>>    arch/arm/mach-rockchip/rk3576/rk3576.c | 18 ++++++++++++++++++
>>>    1 file changed, 18 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
>>> index c17ba418ced5..84618ad5acb7 100644
>>> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
>>> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
>>> @@ -7,6 +7,8 @@
>>>
>>>    #include <dm.h>
>>>    #include <misc.h>
>>> +#include <linux/bitops.h>
>>> +#include <linux/delay.h>
>>>    #include <asm/armv8/mmu.h>
>>>    #include <asm/arch-rockchip/bootrom.h>
>>>    #include <asm/arch-rockchip/hardware.h>
>>> @@ -39,6 +41,10 @@
>>>    #define USB_GRF_BASE                0x2601E000
>>>    #define USB3OTG0_CON1               0x0030
>>>
>>> +#define TOP_CRU_BASE         0x27200000
>>> +#define TOP_CRU_SOFTRST_CON47        0x0abc
>>> +#define SOFTRST47_ARESETN_USB3OTG0   BIT(5)
>>> +
>>>    enum {
>>>        BROM_BOOTSOURCE_FSPI0 = 3,
>>>        BROM_BOOTSOURCE_FSPI1_M1 = 6,
>>> @@ -189,6 +195,18 @@ int arch_cpu_init(void)
>>>         */
>>>        writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
>>>
>>> +     /* If the controller was left running by the boot ROM, reset it */
>>> +     if (read_brom_bootsource_id() == BROM_BOOTSOURCE_USB) {
>>> +             /* Assert USB3OTG0 reset */
>>> +             writel(RK_SETBITS(SOFTRST47_ARESETN_USB3OTG0),
>>> +                    TOP_CRU_BASE + TOP_CRU_SOFTRST_CON47);
>>> +             udelay(1000);
>>> +             /* De-assert USB3OTG0 reset */
>>> +             writel(RK_CLRBITS(SOFTRST47_ARESETN_USB3OTG0),
>>> +                    TOP_CRU_BASE + TOP_CRU_SOFTRST_CON47);
>>> +             udelay(1000);
>>> +     }
>>> +
>>
>> Uh... Wouldn't the issue rather be that the U-Boot driver doesn't
>> actually reset the device?
>>
>> Can you try with
>>
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c
>> b/drivers/usb/dwc3/dwc3-generic.c
>> index 22b9ef0b24e..1b7d845bc75 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -604,6 +604,9 @@ static int dwc3_glue_reset_init(struct udevice *dev,
>>                   * have slower sleep clocks so we'll play it safe.
>>                   */
>>                  udelay(500);
>> +       } else if (device_is_compatible(dev, "rockchip,rk3576-dwc3")) {
>> +               reset_assert_bulk(&glue->resets);
>> +               udelay(1000);
>>          }
>>          ret = reset_deassert_bulk(&glue->resets);
>>          if (ret) {
>>
>> maybe? Hunch is that every variant of this driver actually needs to do
>> this to avoid to rely on the device being out of reset already, but the
>> delay is likely silicon-implementation-specific? The driver in the Linux
>> kernel doesn't actually assert it either before deasserting it, so who
>> knows. Adding Marek in Cc.
> 
> This snippet doesn't work unfortunately, I'm getting the following
> (the same result as without any patches):
> 

Ah yeah, the issue seems to be with the USB PHY (and likely more the 
PLL) but this does the reset during the USB controller probe, which 
maybe is too late/early/wrong place in the init?

> => ums 0 mmc 0
> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x3a63e00
> rockchip_udphy phy@2b010000: cmn ana lcpll lock timeout
> rockchip_udphy phy@2b010000: failed to init usbdp combophy
> rockchip_udphy phy@2b010000: PHY: Failed to init phy@2b010000: -110.
> rockchip_udphy phy@2b010000: cmn ana lcpll lock timeout
> rockchip_udphy phy@2b010000: failed to init usbdp combophy
> rockchip_udphy phy@2b010000: PHY: Failed to init phy@2b010000: -110.
> No USB device found
> Couldn't init USB controller.
> 

That looks awfully similar to what we've had in the past on RK3588, c.f. 
https://lore.kernel.org/u-boot/20250721220734.1617117-1-jonas@kwiboo.se/ 
and specifically what I wrote in:

https://lore.kernel.org/u-boot/51ed7038-1069-40ed-b572-21e179e650d8@cherry.de/

So I'm wondering if we aren't missing something similar for the PHY on 
RK3576? (even though there's a patch in the series for the RK3576 and in 
the cover letter Jonas specifies this was made while working on RK3576 
OTG). Or maybe we regressed?

Cheers,
Quentin
