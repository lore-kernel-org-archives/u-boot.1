Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C06AFF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 14:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82ADC83C14;
	Mon, 27 Apr 2026 16:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kUkUoTaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6F683693; Mon, 27 Apr 2026 16:43:42 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B63483693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tvsy/eCp8ZFLCuyd3g1+J8GCjVs06QUQyzAd62lXIyQxW9irlDpruCflogEfcv2tnRsZXZCpE9mq8AIQSJerNBIZ42UR0E1rr1EcHhd6LmDsNUud4xav1tn/X+OeUCI/WV4nQ08FgWx03BuWt+CvFBUOAiZ0BE4JpDuuFJknkxrD7tDtQ05xsnEV7imdISTFeUqo4FDF2V0lvYVhBK0wgNa/rhhb6ECSELmdwgTOL1u4cmumOcmLmgbK1iYFRHdIc/Sc90gb7v6IL/7kCX2TXenRrGQ7yjdRA4ySUv41/4/qmCwMCJKASGDN5xTzHS1IVoXOZAT89QUHZ/K3axWdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WbdgS8PTzamevTSQl8Dnq4H/PBGqn4QYupQMJP8JBE=;
 b=APosCFQbYS4G4sY2yvkdpMkwsiOnAwn7WZkMW6vPj4KYLoaZ1Z0+WNmK/VBMDo6JIsNq0Agxzoz6OkUnwU3rIKEUaHox55YRecfDKODNieQyr69F4QymFaC16kt3CE0frtzfwy/sHdPuX8y5G27kRi6t5H+mwa1A0afVSyo9cYS3tk7kC/oTcN2KA9g+Nvkd+eudrtEXiOG7SMn4fB+0nt7uEJIeawv4H02gQbXw+nSJ8X3gKpT7tkQgjUE+ba4he38hBOuUKL83qX+MWUfN7MUr2QMtDoGvOI/mHcmCmkJpCUHw0KF7bFbGg/0PBaJjtXBYXaXzmwAX0JaE9K8c6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WbdgS8PTzamevTSQl8Dnq4H/PBGqn4QYupQMJP8JBE=;
 b=kUkUoTaWJ7C5/Tqdawr0OurTeAc9s5BTkQ13UVPSgYA+Zx3pmPmU6hAsmdnu5oKinXohZqhnFHO6VZHqaIvYfwn+GiPpX1Bg848bSoVqfpnnqk7xTF3VZ9kjq4BVlKC3p3G+HrMHvvxjo5rU/EaMmkWXXEoGHjZrXa4h1ejKMjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PA1PR04MB10117.eurprd04.prod.outlook.com (2603:10a6:102:454::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 14:43:38 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 14:43:38 +0000
Message-ID: <c2d737f0-a17e-44e4-8e07-53ce3fa0e543@cherry.de>
Date: Mon, 27 Apr 2026 16:43:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3576: Properly handle USB controller takeover
 from BootROM
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Anton Burticica <mouse@ya.ru>, Marek Vasut <marex@denx.de>
References: <20260427-rk3576-usb-gadget-v1-1-982fd1de08db@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260427-rk3576-usb-gadget-v1-1-982fd1de08db@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0122.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::15) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PA1PR04MB10117:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba14ced-e6fc-4186-671f-08dea46b5e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: bmpPM+FVRbRYaC7gYKrpJWnsZI1N/rl0jwhsTi4FM4IMGJn/k4L4Iz8m94tmBUXJ1+xFpnJusAk+XzORKfZV/YjxE7omCcSlfWvwcV0WJQ2iu8/gmsITMvNwIe97StgCM/dDChg5IwLCBw3UFH3WLzTnT0Th+Z9/oLOCQElE+z3Jd9MVAhis6mYEmhnirgM5Mer2gOptyFkTFIDlIbyRRvIe3MfaxdyrSkwjHCxSYKO80wpmmVeByG+7VXLEMcSe+vrqOmnVoJQNZ52R/ZgQ86MKC8A4wixI2XowKvqQYw8iHKOUV7gXe+V/OdWIGre3/KE33AaBgSEDLOG6gXugOrVtqTSaY1/KA8jzxtIv2X+7Ukc15liqguRQaWPsXkr93R+Xe9L783BfBIgtMgPXJ9112C08bTTAATiKeliTq3FK/GOkm6DROZPP5sTOVm13cZWShlws6pFaaEq5wlDhxSDG608OjClrRj2m2NFy9Gumqsm2FIKAeAFEAgYX1T6tzoTnr1CV/k/I40zmRFOUiZZ14pQ+fwSGbsuFCD5aPCGCXWfWeuLf1Jvzvu6sLIr4FEgXMXy5GUnYzHybJhGYegkb8pXX84I6BTOOpA//VTccdFaQkaaFAPNAmtXcXaST3OpE73PlZY1AO8vLMxSSFvIKjYfE16l1Td9xTuAyBgSrYCvGYI6mHmZNcz6FjtyC2UxLef0P/KfxZF4U1d5JmXhYNJGWgzG6fY1lO/bUB84=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R25yZGEwZEZKZkFYQ3UxclR3U2luUDNWRGdlMDcwY2hjTTFpMURoN1lnL1Jt?=
 =?utf-8?B?ZjlGZE9nUzk2N1I4SDVBcEpUbTkvRlh1VUlCK0tWQlFEU3VqaGFBb0lQa3No?=
 =?utf-8?B?NDIzNUVFeHJKV3hxTFBBSnBLWEcwMm85ZVF5TmVES3Vmb1FuaXh1eXhTK08y?=
 =?utf-8?B?VnQrM3hEbjZiY2gvTm44Q1QwWmpWYm1KTVlITjRlSlhvTER3cFVQd21FTWpy?=
 =?utf-8?B?NE1Ybkd4RldvalJkNW9KUGNZTVBOTWFJUno1VVYydHJReWNwVExTN3ZFTmsv?=
 =?utf-8?B?S21IcmQ3ZUZ3MjhRRzg3R01WSVk0bEFzOVJxK2FkajUvQS9aZ3k3eWk5bzZY?=
 =?utf-8?B?M0dlQkdQTldlQ29mVVI0aGZFM1VxVE11MHZuSHp1Rk1qNk9QS0FyVEJiN0cw?=
 =?utf-8?B?Sng3RXVTOTFBMEs5TGVzeERwclc0YWdWRHdkNVZRU2ZpL1NLMkdWcXFsMTlp?=
 =?utf-8?B?dEprcUZOUXZLSEtiNnFXZXBTOXJ1eUFqd1U1dlkwcU5pSDd1SXpzQ0hSUHpR?=
 =?utf-8?B?b2R1SHlwQUFuWlB3YnlEYnhhUEY0S1c4aVZDVUh1Y1FYajFBdWEvV1FTU3lp?=
 =?utf-8?B?NkphdDZsanRORUlrVTRlbWV1ajl3djROTitYSkpTMEI2elpSdHFtNGRDZVBx?=
 =?utf-8?B?dTU5Z3NZdFpBU1pxOXhteTFmamdIRkJsKzN2L1I5aFJuQXArRTBHbEpWSTVq?=
 =?utf-8?B?UHoyNGlvRmdBSXRLMHpiM21NdFVVTmVwQUF0ZnR5VVEwYThUdzZkT0ZGcFFu?=
 =?utf-8?B?bWhZdlNGY0oxMHQ4KzlBNVdteUdRMlJDVzhxTFIzKzJpZTZiYVRNN09MT0dI?=
 =?utf-8?B?TjVuY2wxbzBWNEF4VjMvSzZpNnhoRW9KbGJ4OVlkclRkUUM3WUJtVCtYK09M?=
 =?utf-8?B?TFhzcmJWQVFKVU5Cc1JueW1EMzVDUGVXRWFPV1FOYVl4Y1ZhbTVHVEoyS25H?=
 =?utf-8?B?YVpnb1RPa2NvR2ZZejNrRU9zUnJTSUxLNHppVHg1M0ZCRzdBczBXQTE5ZjNJ?=
 =?utf-8?B?a0tiYTJNcDJJNWptd0VBRWxqWFg0Qnc3Y2k5RklZaGpvYlNQWVdMUUx0WS9G?=
 =?utf-8?B?SEpUYlUyWlUvSG5Uc28wMitnd2lTejJ5S3pVaEM5ald5Vk5oek5rL2Q3VGtw?=
 =?utf-8?B?djZid21xYlV4OEhyZHFSQzhJQnM1ZnhqVHY4R3FoS1RkcmFUNE91UnRXYi9E?=
 =?utf-8?B?TWd1NVgzdkZYdlhpN3VnMkZpeUlUTGpEUXN5VTZCenFCVDhuem5PTnR4bVY4?=
 =?utf-8?B?M1plbzNjS1lFQTljK3orS2dVZ2g3Z1Y3cFRMSGlwQ0tMOUExb3loUlZsbGpM?=
 =?utf-8?B?anp2TEhrRTBaME1YWlNFcU9vM3JUY1p2VW9CVGJqZllHS240eTUxa3NoekZJ?=
 =?utf-8?B?ZHQ0eWh4cm90c0JOWEZlb2RJVDhDV1lKK0ErQWVBMXBvazI4cTVOSGJCRlJ4?=
 =?utf-8?B?d2liajVoQkl1Q3RLSVU1NGw3cEdzMkczQVVjYWhGMjV0NlVuSkVoa3hESDlw?=
 =?utf-8?B?WjZ3cE9NUzcxY21SSmtQaXFReXhKSE5LeHRSVE5BUlMrS2RkNFo4UkMvKzNr?=
 =?utf-8?B?K0RaQkZYSHFiNUh0MWVNaEVqc2lvS0dkQ0VlVWkrd2E3d2F1MVNmSXEweHlw?=
 =?utf-8?B?dHM1cFNKZUp1SWlCbjhLZTJPalp2Ly9CbFVyeC9OZEEzUjlycEtNdmJ0NzJy?=
 =?utf-8?B?WHdpc1J0VGp5bVg5V1I5M0lNaXl2TnJqaWdra2lObkkwNkRJdjBLR2RZTU4z?=
 =?utf-8?B?cE1KYnMxL0JoNFBJZHpON1VlWm1CbW1qWnV0dEg2V1NoRHpuZkc2N29RTHRQ?=
 =?utf-8?B?NlhVNkJ1QlBYTVVmTFdMcmtBMHBtQloxYXpvdXpxcytHMkF6OVJoTktBOS9l?=
 =?utf-8?B?ZVVHc09lc3ZIUEIveWN6TEtlQVZydHRJZ2dMaFpPUit0ZkdoSlhXMjJBSHFU?=
 =?utf-8?B?eGxYQTJOcnBZcUVqY2tyMkViaUc5d3RZTm0wN21qbVdORVBZWEZQYlpiRmhD?=
 =?utf-8?B?ZUlsa1Qyd1FlWW4vRlhrWU1JVlpmUXpLaEYreVE4cEJZUEV3a3hYN3F5T2o3?=
 =?utf-8?B?MXNOUXZGaTFXNVVJc1g4NU1zSTYvaTUyMDBjaENiMWZteUdlVFlRd3B6ZnA1?=
 =?utf-8?B?TzQxRHpDbzJndThQelZrTEhRWUVKTnFBU21ramx3dGwzSEZtREp0QmNKNzdB?=
 =?utf-8?B?bTArZVkrcWZLVHl5b2FYay9kR0pzNEVobnV5Snkwc1JaUnh4QzF6YlgyRmZy?=
 =?utf-8?B?SnB5ZmVZMnc3VXBGL3R0WEdZSFJwZmwwMmNtVkN3UVJQK2IwUEVjWjFkb092?=
 =?utf-8?B?azBXU0M0LytDYlVkY0FiWG4yNmdGWUYwS0s1ZEl5UXV0SkwyNjIxL0dFRndw?=
 =?utf-8?Q?maQByfiSi3Z6JVYZjN22Er9pZq1vVD/4AHZ0c?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba14ced-e6fc-4186-671f-08dea46b5e15
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 14:43:38.2486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzlxTgckANO/NtDoxybYzLpIWA8BKtpLHg5b5Niqc43waCrx9OqDjobHoQXLbqdTke/IUeTyE37nnWrn/xZWLywQ/Uu5WHvrznVU3PdpY5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10117
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

Hi Alexey,

On 4/27/26 2:53 PM, Alexey Charkov wrote:
> From: Anton Burticica <mouse@ya.ru>
> 
> When booting via USB download mode (Maskrom), the BootROM leaves the
> USB3OTG0 controller in an active state. U-Boot must properly reset
> the controller before reinitializing it for fastboot or other USB
> gadget functions.
> 
> Without this change, USB gadget mode commands such as fastboot and ums
> fail when U-Boot is loaded via Maskrom USB download because the
> controller state is inconsistent.
> 
> Signed-off-by: Anton Burticica <mouse@ya.ru>
> [Removed unrelated changes, adjusted the commit description]
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   arch/arm/mach-rockchip/rk3576/rk3576.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
> index c17ba418ced5..84618ad5acb7 100644
> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> @@ -7,6 +7,8 @@
>   
>   #include <dm.h>
>   #include <misc.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
>   #include <asm/armv8/mmu.h>
>   #include <asm/arch-rockchip/bootrom.h>
>   #include <asm/arch-rockchip/hardware.h>
> @@ -39,6 +41,10 @@
>   #define USB_GRF_BASE		0x2601E000
>   #define USB3OTG0_CON1		0x0030
>   
> +#define TOP_CRU_BASE		0x27200000
> +#define TOP_CRU_SOFTRST_CON47	0x0abc
> +#define SOFTRST47_ARESETN_USB3OTG0	BIT(5)
> +
>   enum {
>   	BROM_BOOTSOURCE_FSPI0 = 3,
>   	BROM_BOOTSOURCE_FSPI1_M1 = 6,
> @@ -189,6 +195,18 @@ int arch_cpu_init(void)
>   	 */
>   	writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
>   
> +	/* If the controller was left running by the boot ROM, reset it */
> +	if (read_brom_bootsource_id() == BROM_BOOTSOURCE_USB) {
> +		/* Assert USB3OTG0 reset */
> +		writel(RK_SETBITS(SOFTRST47_ARESETN_USB3OTG0),
> +		       TOP_CRU_BASE + TOP_CRU_SOFTRST_CON47);
> +		udelay(1000);
> +		/* De-assert USB3OTG0 reset */
> +		writel(RK_CLRBITS(SOFTRST47_ARESETN_USB3OTG0),
> +		       TOP_CRU_BASE + TOP_CRU_SOFTRST_CON47);
> +		udelay(1000);
> +	}
> +

Uh... Wouldn't the issue rather be that the U-Boot driver doesn't 
actually reset the device?

Can you try with

diff --git a/drivers/usb/dwc3/dwc3-generic.c 
b/drivers/usb/dwc3/dwc3-generic.c
index 22b9ef0b24e..1b7d845bc75 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -604,6 +604,9 @@ static int dwc3_glue_reset_init(struct udevice *dev,
  		 * have slower sleep clocks so we'll play it safe.
  		 */
  		udelay(500);
+	} else if (device_is_compatible(dev, "rockchip,rk3576-dwc3")) {
+		reset_assert_bulk(&glue->resets);
+		udelay(1000);
  	}
  	ret = reset_deassert_bulk(&glue->resets);
  	if (ret) {

maybe? Hunch is that every variant of this driver actually needs to do 
this to avoid to rely on the device being out of reset already, but the 
delay is likely silicon-implementation-specific? The driver in the Linux 
kernel doesn't actually assert it either before deasserting it, so who 
knows. Adding Marek in Cc.

Otherwise, for sure we do not want to de-assert the signal in the rk3576 
SoC C file, we don't know if the driver is even built and we should let 
it do it if need be.

Cheers,
Quentin
