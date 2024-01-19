Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCD0C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 18:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 019EA87CF8;
	Fri, 19 Jan 2024 19:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="rnbhYybf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37BFF87B98; Fri, 19 Jan 2024 19:06:55 +0100 (CET)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01olkn2082e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feae::82e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 093BB87CF8
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 19:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iuy0lTYxuvfqCz+zQk/5/j4XsD/zdstiueAb7YRfhzMJeKJ48o6R9mkMm490o2bTBjlVQvXlgapL58CN+TzbMtDI2zMdGr7AzqVWa0k4SNo/064YxFqQxYgtaqVFprjjA7YrQvsxjsf35QgCl/lnS0dqvT+ZovKvxHvKIJFiru2Ldjb1Cbvp+NjZ6jKjHgT6noHjh/8dfemupc0KibTDvays32HYOvWgGOSRFH8Ma+jQOsEy/JLNphfr1hl52TkvboofgBA51LKq5q+av4mrVFUO/eu/RT6tZVx+u4kratgCBSzcNGrUmGy3GHP+j9qdJ+FjRyL37j6x+PZzwzvsNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Szi2kibWm1B/yOplf7S296FkjCkf7OsBONF6xGyz7CI=;
 b=OQX4ZYckfC0zcBMKvlAJBPNnL0oLy+ynL8BCjSRxhyTHBviDvSJSilcDOaoVE3BaSNmcvASpQ0oKrLweDuTNMif+e+ZKJZgUHPHkQ46mPtMleyFslzo8yWJNMzQxdXSwkScGtNJ9+EX+7rjYftgn/hBsmP/TRPZHCjoYaMf8kdx1JvXTQ5PmQKxS2ueT+ye7D3YlXWVsIxNL7HbvezkbWoY6ktv1kTa3ZBGWJMah8u0qgSDyT9TlxLN7MHeGd0K3Cm2FkbLRgVpaftFNrML0lxDG/PpkfKI9JgiB+paKOtLWbHonPUWT2IIdwk4braXcDu1SH1RX461OoQi87IYYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Szi2kibWm1B/yOplf7S296FkjCkf7OsBONF6xGyz7CI=;
 b=rnbhYybfSClFLdaqcvUij9fqMdIRkdfj0oedW6z6MM2tO5rrpTs+JCG3+9JTuhNaaWj6dQT64Y5ElsKmPj+DS0sERg0Pz10HFjtJbi7HQVTwjemQp0YvoRR60PZnaYrjuhNItzimLcUjxjY+Pc+U8yGLud/RzlOuXE8Gj7PeZfyZMcT3A4iMUCh0jU/N3DOVYS7X97k3/zpV6US0xWVnN3r680DM7XsnazaDfGmYkvF4DsR9GJIPP08lEYLXkpn2p4b3v+UHtURA8NrIsEpQHejENXDjabgPhBZFVW7A0bj+B4Y7se79KF+fGQ+N4X/1nCnX9XwCsFzzSSkBMSvfNg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB7141.apcprd06.prod.outlook.com (2603:1096:405:b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 18:06:49 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::22e1:47ec:6e00:4900]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::22e1:47ec:6e00:4900%4]) with mapi id 15.20.7202.027; Fri, 19 Jan 2024
 18:06:49 +0000
Message-ID: <SEZPR06MB6959615AC438A73759EACE5B96702@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sat, 20 Jan 2024 02:06:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] wdt: add HiSilicon watchdog driver support
Content-Language: en-US
To: Stefan Roese <sr@denx.de>
Cc: David Yang <mmyangfl@gmail.com>, u-boot@lists.denx.de
References: <20240119-b4-wdt-v1-1-b117901385d7@outlook.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240119-b4-wdt-v1-1-b117901385d7@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [lj6c7YD8A12+F4Jq0kglnpqMzdQ8oJ/Icxch1Mkz9Os=]
X-ClientProxiedBy: TYCP301CA0017.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::8) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID: <26b6795c-c1df-ab07-64e2-add7b262e0de@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8b67f4-bf6f-49df-1d9a-08dc1919663b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1D/cd4IgA6mve1AR+QIADw75P9Y1pLUZToDmjOaemQXR2CxvS1Lmy/Qe7uJlPb0165hqNKHzByHl/NAw+B24m0+UxRz3KfigTYxgUlKLGTS+3pCsAefbBsPBTPqkHAiDJyQ5hWcEwl59K0+y/Njo+hhh0th/JtDnJ3arppeIEdIOfjr2Q6OtecMlSlWNE++M18DZ/IGXFxvrLWfSOpTfUpusFTtQht3OmGxp89ziWAcDsozA0vmp9z26diwMBBmabt9oxGCcEhIrc/EJ4Gpb6m72l/FmOmmOUud9dCEemyzivR2YcOCl1LO5eGIlr7op++RPtRxLf1/KlmQ3p0xlhffWsOaxaMEfo4BcBmxPqtqjj1mD9IoRGEA2+S4m/2857MsjhzQ0p3Y/EefWqAPl55vc37nG07rX11PRi2nqPdmcqYUHLRi+RspxTpZXKw2bKbTeqp46t8cL3Qnzt8YQfmx3Oj+dPQbNkL6XQ/HOEteKUoYMWrh2QN3zm9cOeiUtKkoZ+4qm+OZLzpggxUBjs9u2kpoIjkKAEwZY+lVEXOmEgUnPKvjayhqQ4fa6tqIT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TExOSzl4ejRnaDNlb3lFNDRscC9sZjM1QjJmclNJOXV3V2ptbTlRM3Q2bWth?=
 =?utf-8?B?eXFYajFMVG5sNEhDTG94cm45ZlNxTHdEbmNYSmwyM1pqc2YzdktMcTNjbDhW?=
 =?utf-8?B?MU9pVjJIRExxSjNiTDlPV2dUYTZGTExpK2VGcFQrRFlZeThvV25xTTZuWHhK?=
 =?utf-8?B?YlY1WGUzbUdXblNKMWRKK3BoVmJtNHdKTzQ0MTFYQWowZEpnaGVtb3lXaW16?=
 =?utf-8?B?eENSbGhlbG5YTjhjSUErem01elhCR2N5VzBuKzV2dVVUKzEwN0VSMmhPbExy?=
 =?utf-8?B?Z3ZKWVhmSlpmL0c5N3NFczdBZnM5cW9DYlRyU2NreEpVclcrT0dyTUxoejNK?=
 =?utf-8?B?Wk1CcU5IcllTNzJmVHgxWXQzRTA4aVFmNGx2YzNsNDJzbmV2WFUyeHJqMGVW?=
 =?utf-8?B?cnA5aG1wekxRQnBPUHFndjZUWGZIUWpBQVY2WnR1cXVtbWdQdVZxRTVaRUtO?=
 =?utf-8?B?U1FwaUo4MWxBcjQzZUVCekoyYzNvZkkxWGdXc05aS1MxVmQ1T2ZaaUJmL2Rq?=
 =?utf-8?B?RkRkQ2JOaFNGNlE3N1RJb2ZEaGpJNUZZZXlEcHpPNVVTc3VtTGhGUUtlZVJj?=
 =?utf-8?B?bTJ3Mm1nYksxYTdyWTRqRERJbVhlN2Vqb3gwcTZ0MThGMWlzdmhSR0s3MnBY?=
 =?utf-8?B?MW56TkRLZmZJVDBKZHJyWEZFamRtSjZtM2JlUTNPWXZXRzNaVEVTMWgxRWdp?=
 =?utf-8?B?aWVBZVMvYnhsbHdHYmZQQWI1MGh0YURnbGczc2M2Z2cwcTFHelVFTEFJcXcw?=
 =?utf-8?B?UUNCNGxlaTJLTHY5YmhIY3daVm1DdjkyYmxkbExQVVZIei9jRHJjeFRrNGRk?=
 =?utf-8?B?cDZMQ01hV25TUE1PWDZwbnlQYXFuMUhFZkxackY1RnExZmR0elNJS0l5TnZR?=
 =?utf-8?B?bnQrcmZudU04OHlBYmRyRGptcUpXVyt4QXJxa05jeXErUDdncVk4V0hCVkty?=
 =?utf-8?B?TC9UaXFSUmI5VWw0Skl4eW5QRUgyRlN4VExLUkswSjM0VzBVZ0tmY3JIN0hh?=
 =?utf-8?B?eXkwMzErVEkzOS9yeWg1N09VclV4YmVJSVVPclZFWEk2WHpZdkhXRUlyVFZo?=
 =?utf-8?B?Z0h0ZERDWldwSXFHZHpLSjhXL0gyUDlmVXR6V1k2dWxQRTVmSXJNOUF3aWpF?=
 =?utf-8?B?Wm5MMDhxUUpCbXB2QjFpblhpZlU4THNZS2syQ2E5RmsvZk5Gbk1qRG55V29E?=
 =?utf-8?B?UEFlQVdQUVh5emFxYmE4aU5VOVJlb1B1ZUowQUZEZlQzb3U3dVpOb2NiL3h4?=
 =?utf-8?B?TGhrZ3B0dVA5allIbkdtZ01aeWxCbXp6QjBvOXBFTDhrZkYyWXVaa1Z0YzNv?=
 =?utf-8?B?Nk85SGdBQTU4Z1duS0JpWUV6OWI1SzdWbVM3WG9JaHJRVy93NStSWUloMEhF?=
 =?utf-8?B?MTFVYTJLSHRQK1BCYWRCYVBkY3IyZENXaVJUTDQ2ZlN3MzM0cjdXV1hWQ1hW?=
 =?utf-8?B?MFB0VE9LRWQ4YXJpY3V2R3Q1SjlvVGN4N2syREsyU0Z1VlQ3L0dJZkFqR0pH?=
 =?utf-8?B?Z1RUVlNqdzY0TXNoQ2FSSlltUzlGTDlhRmVkU1ViS2V0amFYVzBvaTdQRGFh?=
 =?utf-8?B?bXJ6bUgvWTFDdGc0a1BOY0h5MWM4bkNubDBKWTBGdlZhQms4RkFHUHFCYTdJ?=
 =?utf-8?Q?5xesPrBThc0VxYzd37PSB5W6mR437F6Xu3QXv2CnyOCc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8b67f4-bf6f-49df-1d9a-08dc1919663b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:06:48.6688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7141
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

On 1/19/2024 12:24 PM, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
>
> This watchdog core is found on many HiSilicon SoCs. Add support for it.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>   drivers/watchdog/Kconfig    |  10 +++
>   drivers/watchdog/Makefile   |   1 +
>   drivers/watchdog/hisi_wdt.c | 196 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 207 insertions(+)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 569726119c..ddf44f63d2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -32,6 +32,7 @@ config WATCHDOG_TIMEOUT_MSECS
>   	default 16000 if ARCH_SUNXI
>   	default 5376 if ULP_WATCHDOG
>   	default 15000 if ARCH_BCM283X
> +	range 500 180000 if ARCH_HISI
>   	default 60000
>   	help
>   	  Watchdog timeout in msec
> @@ -171,6 +172,15 @@ config WDT_GPIO
>   	  doc/device-tree-bindings/watchdog/gpio-wdt.txt for
>   	  information on how to describe the watchdog in device tree.
>   
> +config WDT_HISI
> +	bool "HiSilicon watchdog timer support"
> +	depends on WDT
> +	depends on CLK && DM_RESET
> +	imply WATCHDOG
> +	help
> +	  Select this to enable HiSilicon watchdog timer.
> +	  Currently supports Hi3798MV200 only.
> +
>   config WDT_MAX6370
>   	bool "MAX6370 watchdog timer support"
>   	depends on WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 5520d3d9ae..3436aa6389 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_WDT_ORION) += orion_wdt.o
>   obj-$(CONFIG_WDT_CDNS) += cdns_wdt.o
>   obj-$(CONFIG_WDT_FTWDT010) += ftwdt010_wdt.o
>   obj-$(CONFIG_WDT_GPIO) += gpio_wdt.o
> +obj-$(CONFIG_WDT_HISI) += hisi_wdt.o
>   obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
>   obj-$(CONFIG_WDT_MCF) += mcf_wdt.o
>   obj-$(CONFIG_WDT_MESON_GXBB) += meson_gxbb_wdt.o
> diff --git a/drivers/watchdog/hisi_wdt.c b/drivers/watchdog/hisi_wdt.c
> new file mode 100644
> index 0000000000..5be9e90865
> --- /dev/null
> +++ b/drivers/watchdog/hisi_wdt.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Watchdog driver for HiSilicon SoCs
> + *
> + * Copyright 2024 (r) Yang Xiwen <forbidden405@outlook.com>
> + */
> +
> +#include <clk.h>
> +#include <errno.h>
> +#include <log.h>
> +#include <reset.h>
> +#include <wdt.h>
> +#include <dm/device_compat.h>
> +#include <dm/device.h>
> +#include <dm/lists.h>
> +#include <dm/read.h>
> +#include <linux/delay.h>
> +#include <linux/math64.h>
> +#include <linux/types.h>
> +
> +/* CONTROL register definitions */
> +#define HISI_WDG_RES_EN	BIT(1)
> +#define HISI_WDG_INT_EN	BIT(0)
> +
> +/* RIS(Raw Interrupt Status) register definitions */
> +#define HISI_WDG_RIS	BIT(0)
> +
> +/* MIS(Masked Interrupt Status) register definitions*/
> +#define HISI_WDG_MIS	BIT(0)
> +
> +/* LOCK register magic */
> +// Write this value to unlock watchdog
> +#define HISI_WDG_LOCK_MAGIC	0x1ACCE551
> +// Read values
> +#define HISI_WDG_LOCK_WA	0x0
> +#define HISI_WDG_LOCK_RO	0x1
> +
> +struct hisi_wdg_reg {
> +	u32 load; // 0x0000
> +	u32 value; // 0x0004
> +	u32 control; // 0x0008
> +	u32 intclr; // 0x000c
> +	u32 ris; // 0x0010
> +	u32 mis; // 0x0014
> +	u32 reserved[762]; // 0x0018
> +	u32 lock; // 0x0c00
> +};
> +
> +struct hisi_wdt_priv {
> +	struct hisi_wdg_reg __iomem *reg;
> +	struct clk *clk;
> +	struct reset_ctl *rst;
> +};
> +
> +static inline void hisi_wdt_unlock(struct hisi_wdg_reg __iomem *reg)
> +{
> +	reg->lock = HISI_WDG_LOCK_MAGIC;
> +}
> +
> +static inline void hisi_wdt_lock(struct hisi_wdg_reg __iomem *reg)
> +{
> +	// Any value other than HISI_WDG_LOCK_MAGIC would lock the registers
> +	reg->lock = 0;
> +}
> +
> +static int hisi_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +{
> +	struct hisi_wdt_priv *priv = dev_get_priv(dev);
> +	u64 rate;
> +	u64 val;
> +
> +	rate = clk_get_rate(priv->clk);
> +
> +	/* This may overflow */
> +	val = mul_u64_u32_div(timeout_ms, rate, 1000);
> +	if (val > UINT32_MAX) {
> +		dev_warn(dev, "timeout_ms too large, using maximum.\n");
> +		val = UINT32_MAX;
> +	}
> +
> +	hisi_wdt_unlock(priv->reg);
> +
> +	priv->reg->load = (u32) val;
> +	priv->reg->control |= (HISI_WDG_RES_EN | HISI_WDG_INT_EN);
> +
> +	hisi_wdt_lock(priv->reg);
> +
> +	return 0;
> +}
> +
> +static int hisi_wdt_stop(struct udevice *dev)
> +{
> +	struct hisi_wdt_priv *priv = dev_get_priv(dev);
> +
> +	hisi_wdt_unlock(priv->reg);
> +	// disabling interrupt also disables counting
> +	priv->reg->control &= ~HISI_WDG_INT_EN;
> +
> +	hisi_wdt_lock(priv->reg);
> +
> +	return 0;
> +}
> +
> +static int hisi_wdt_reset(struct udevice *dev)
> +{
> +	struct hisi_wdt_priv *priv = dev_get_priv(dev);
> +
> +	hisi_wdt_unlock(priv->reg);
> +
> +	// any value written to INTCLR would result a counter reload
> +	priv->reg->intclr = 0;
> +
> +	hisi_wdt_lock(priv->reg);
> +
> +	return 0;
> +}
> +
> +static int hisi_wdt_expire_now(struct udevice *dev, ulong flags)
> +{
> +	return hisi_wdt_start(dev, 1, flags);
> +}
> +
> +static const struct wdt_ops hisi_wdt_ops = {
> +	.start		= hisi_wdt_start,
> +	.stop		= hisi_wdt_stop,
> +	.reset		= hisi_wdt_reset,
> +	.expire_now	= hisi_wdt_expire_now,
> +};
> +
> +static int hisi_wdt_probe(struct udevice *dev)
> +{
> +	struct hisi_wdt_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clk: %d\n", ret);
> +		return log_msg_ret("clk", ret);
> +	}
> +
> +	ret = reset_assert(priv->rst);
> +	if (ret) {
> +		dev_err(dev, "failed to assert reset: %d\n", ret);
> +		return log_msg_ret("rst", ret);
> +	}
> +
> +	udelay(10);
> +
> +	ret = reset_deassert(priv->rst);
> +	if (ret) {
> +		dev_err(dev, "failed to deassert reset: %d\n", ret);
> +		return log_msg_ret("rst", ret);
> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_wdt_of_to_plat(struct udevice *dev)
> +{
> +	struct hisi_wdt_priv *priv = dev_get_priv(dev);
> +
> +	priv->reg = dev_remap_addr(dev);
> +	if (!priv->reg) {
> +		dev_err(dev, "failed to remap\n");
> +		return log_msg_ret("wdt", -EINVAL);
> +	}
> +
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		dev_err(dev, "failed to get clk: %ld\n", PTR_ERR(priv->clk));
> +		return log_msg_ret("wdt", PTR_ERR(priv->clk));
> +	}
> +
> +	priv->rst = devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(priv->rst)) {
> +		dev_err(dev, "failed to get rst: %ld\n", PTR_ERR(priv->rst));
> +		return log_msg_ret("wdt", PTR_ERR(priv->rst));
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id hisi_wdt_ids[] = {
> +	{ .compatible = "hisilicon,wdt" },
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(hisi_wdt) = {
> +	.name		= "hisilicon_wdt",
> +	.id		= UCLASS_WDT,
> +	.of_match	= hisi_wdt_ids,
> +	.of_to_plat	= hisi_wdt_of_to_plat,
> +	.probe		= hisi_wdt_probe,
> +	.priv_auto	= sizeof(struct hisi_wdt_priv),
> +	.ops		= &hisi_wdt_ops,
> +};
>
> ---
> base-commit: 842c5b501be7fe23f618788002c5e81fd56ac382
> change-id: 20240119-b4-wdt-d51eb3ae62c9
>
> Best regards,

I recently found that this is just a plain sp805 watchdog. Please just 
ignore this patch.

-- 
Regards,
Yang Xiwen

