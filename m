Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51319EFD23D
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 10:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEE3883DCB;
	Wed, 25 Feb 2026 11:34:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="kEaBC63h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41DC383E61; Wed, 25 Feb 2026 11:34:47 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB1FF83D77
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 11:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJMncZaGikFrx1kGTWqahenNaUDG70VCZRBPnkJGBGj7VCpAd03b4lkAl2GPZdrfuXR/qZ+YAWfU8uQRqnGNrytoVdfLrHPA/NNqckcfYDLyDowsrzvzoUVJvpEGpoCK5KwLCBGwIQF1YZ+XM1auoEvQrudIF9f+KHQ38OkPuqgvCyhNMe98pD0D/fYzzNtbaVcJiBL4QFyeErwMXDus4TO0KMWtCK2zgDTdMv5MWVnNxMp+vbngTymXpjYmgzJOOQYeKippSZRLouWp3DmcFqiwMRfyzUclh0Li5i56toueBMyG4t64dVRVIi0ieNz5fL7fXifQVOQZZLmtB7AuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8v+4UmoReGYktwL39AGUqUxYPWHmYDDNQRa53OIqZOU=;
 b=AbcTBx1o1UR6NPasaf6Ddy+cxHSF16rZhW2TUhdOPrXACNAqwYdQv5sWlDTXH+9JGy4lOLtFUABLvp6UR3lqfbdDjqLBwI5rvBOhgrZJ+ct314oOOQjMFOjzWYNyw69FtD2llIgJ7xo3ulzP9dVfTJPUa/qg7m+oF/S8DKzPs1piROjym86D+Za7xY9f7jtCuMtF12MbDrwpnuIVWulJchZl1W5VFq5C6IovctOLDpeWlwJ0waE36DDS5vp+qR8esE5DvQDC7idvsRjh+rmgxX7rUhnpcGO+GHP+DHEUByfbfnYRHsTdm2DO+tUMW7bSR+GO8cWy8Y4tW08sL6VPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v+4UmoReGYktwL39AGUqUxYPWHmYDDNQRa53OIqZOU=;
 b=kEaBC63hpdODI5IZzJQtyE6zL4jHoPY8tca/erie1Su0lnomcsubJAI1+Jlpk8aDBr5ZY7UCAqDyXFbSjkQFaHNEbNE4Yi4b99QK/HnhlkqRkJzDx36TtRpclScJzxaanu2doe3iFPeRSBf3L/J68A78LXwYUEnOim6AgzuVd06oXQTzZLO2IvW6F0f1t/SLzyZ+GxfleeIZCkml+VTFSj09OFa56mpvTuWoQWsyhmvkuf9sxDngxoQ5L7tPU2NbWs1+KB8vCp5QzMgyF2KzmaaGIm0J2QD040+dhTZgWMnqGHPYHwN1iS9/BrD3YVhywGDaMO3omqMYg6DK/M6ZEA==
Received: from DU7PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::11) by PA1PR10MB8430.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:445::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 10:34:37 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::48) by DU7PR01CA0016.outlook.office365.com
 (2603:10a6:10:50f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Wed,
 25 Feb 2026 10:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 10:34:37 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 25 Feb
 2026 11:36:54 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 25 Feb
 2026 11:34:36 +0100
Message-ID: <e3e3aa15-0038-4975-8832-ce077f54419f@foss.st.com>
Date: Wed, 25 Feb 2026 11:34:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] video: support Rocktech RK050HR345-CT106A panel
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <linux-amarula@amarulasolutions.com>, Alexander Graf <agraf@csgraf.de>,
 "Alper Nebi Yasak" <alpernebiyasak@gmail.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Dragan Simic <dsimic@manjaro.org>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Simon Glass <simon.glass@canonical.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
 <20260221094252.3103034-9-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260221094252.3103034-9-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D08:EE_|PA1PR10MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2c2537-5ab0-4729-96ec-08de7459799c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: Xcews2tO2wl0dvD7/ZTFXZO4QGrCPptwlk/S8X7C2VxJpcCFzxMe5lbXy3NHmNUHD8RwHz0b+bSb3K1W+KOJIzrhS2DCSh8wTOlsaqwVZIk8Kf0VscLaDSPeocqh4J4asMcRBs8jt8zyxoYDFRvvWyBsZoFaKC8TTBqvBaeqSJvJtn3bWY8TXDaw/LtTpS4CrtpEgt89Rwwg6xZD9egbAIU2Ep/rCoB2OC5qf0nyfujZzd6/NgUa4oSZyzXfTzl/el4P49x7tYCbR2/N3W9UwVnIuQ2wVyxlZzs5y/xtqVcoNlXKDlu2RtlApqvqnIThxHTw8xrw19oqfGHwSvdVVRSfspSIHUq0WBb5IPyl6E7FStu1vR2KXX602mG54I3+OLrSBk2OZ4FVl2uofbkQwQxDvrtPw27n9VFGMito+jRT+UBtfsw301aux2V67PniywINknckOSq18ncNIToK5zPUjAzO18kDbMgJaRmarsQcuvr3JTtukszcAIo9Nkck5ruMhAV0Q0MUzlf2gVO9FALlqXcC8lZ6jvCzCFLv+x48JqOi53UsqauiuLiF1VelSYT9rhRaIRaMlHPo0iIuJRy0Dp7fqxrGIuED8RGqgNFn0smadJbn5B5qvIYi+ZS4FoLuPpRIvp5iZV/HewTbxxj3WVqFlHLGQKNP/ZVMOQUSSxc9LqJXA9kKZ3bR/ObqJTi4gIopTT9oz0WRu44MTLe41aheYrF6SzvbswDfYmmS8lD644xFsNdKIHM8omm9nzkWjhAlHAGVvxYdFEu6+R05SJlLHuC9o2YzQ9Ly7YD1LYC/EwbfCG9akoUDjCN6viBljua3jh4hq4RO6uynyA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YuZbp8p5aXgQXtIfSQ5vAPH/PldocERFoC2X2WOro2oCL42xSjVaMVb6ooVgpvThYIMhYZag9pAHdqV6wh6OZFGF0DBRDRLtQ+UQf0NjUCavHVmG/5FkW6kxyUtQtUIJTpbuqVq28Y+CbRCh2MayWb7XUuxuORz1fvaAgkkW7IY99YleW4tt6KMTTiS3K4FwQwIZ1SBvHj7mInHgB3eeJGAvgIsjuajZEzAmM3TcsiBUO+iHSjEkn0+h8O8+fftTqs4sgfL7IzpxFL3A0y4csGA5xiQ4CW4AJPadc0HcNWQB7095MwEng+2BnrW9dDATN5kArriBWcv17XxHahEAndKrWrRB4TzaHwHAhAreYutTbOctiJCgxc5B0xH1H6S9AnuRdAsuNpFvTGXcv0BTBonVv4PQH94alm0gu4k9tdIiMCqQB9f5YuTIVpud+8IW
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:34:37.3208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2c2537-5ab0-4729-96ec-08de7459799c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8430
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



On 2/21/26 10:42, Dario Binacchi wrote:
> Add support for the Rocktech RK050HR345-CT106A RGB panel. This model
> uses an Ilitek ILI9806E controller over the SPI bus for initialization
> and register configuration only.
> 
> The driver is designed to be easily extensible to support other panels
> with different sequences and timings by providing a specific descriptor
> structure for each model.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> Changes in v2:
> - Rplace tristate with bool in drivers/video/Kconfig
> 
>  drivers/video/Kconfig           |   8 +
>  drivers/video/Makefile          |   1 +
>  drivers/video/ilitek-ili9806e.c | 354 ++++++++++++++++++++++++++++++++
>  3 files changed, 363 insertions(+)
>  create mode 100644 drivers/video/ilitek-ili9806e.c
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 08c9b0207884..c2acc13139c0 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -552,6 +552,14 @@ config VIDEO_LCD_HIMAX_HX8394
>  	Say Y here if you want to enable support for Himax HX8394
>  	dsi 4dl panel.
>  
> +config VIDEO_LCD_ILITEK_ILI9806E
> +	bool "Ilitek ILI9806E-based panels"
> +	depends on PANEL && BACKLIGHT
> +	help
> +	  Say Y here if you want to enable support for panels base on
> +	  the Ilitek ILI9806E controller. Currently only the DBI panel
> +	  is implemented.
> +
>  config VIDEO_LCD_MOT
>  	tristate "Atrix 4G and Droid X2 540x960 DSI video mode panel"
>  	depends on PANEL && BACKLIGHT
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 984768ea156d..74846a8106e4 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_VIDEO_LCD_ENDEAVORU) += endeavoru-panel.o
>  obj-$(CONFIG_VIDEO_LCD_HIMAX_HX8394) += himax-hx8394.o
>  obj-$(CONFIG_VIDEO_LCD_HITACHI_TX10D07VM0BAA) += hitachi-tx10d07vm0baa.o
>  obj-$(CONFIG_VIDEO_LCD_HITACHI_TX18D42VM) += hitachi_tx18d42vm_lcd.o
> +obj-$(CONFIG_VIDEO_LCD_ILITEK_ILI9806E) += ilitek-ili9806e.o
>  obj-$(CONFIG_VIDEO_LCD_LG_LD070WX3) += lg-ld070wx3.o
>  obj-$(CONFIG_VIDEO_LCD_LG_LH400WV3) += lg-lh400wv3-sd04.o
>  obj-$(CONFIG_VIDEO_LCD_MOT) += mot-panel.o
> diff --git a/drivers/video/ilitek-ili9806e.c b/drivers/video/ilitek-ili9806e.c
> new file mode 100644
> index 000000000000..e1b27e12dde5
> --- /dev/null
> +++ b/drivers/video/ilitek-ili9806e.c
> @@ -0,0 +1,354 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + */
> +
> +#include <backlight.h>
> +#include <dm.h>
> +#include <mipi_display.h>
> +#include <panel.h>
> +#include <spi.h>
> +#include <asm/gpio.h>
> +#include <dm/device_compat.h>
> +#include <linux/delay.h>
> +#include <power/regulator.h>
> +
> +struct ilitek_ili9806e_priv {
> +	struct udevice *vdd;
> +	struct udevice *backlight;
> +	struct gpio_desc reset_gpio;
> +	const struct ilitek_ili9806e_desc *desc;
> +};
> +
> +struct ilitek_ili9806e_desc {
> +	const struct display_timing timing;
> +	void (*init_sequence)(struct udevice *dev);
> +};
> +
> +static int ilitek_ili9806e_dcs_write(struct udevice *dev, u8 cmd, const u8 *seq, int len)
> +{
> +	u16 data[16];
> +	int i, ret;
> +
> +	if ((len + 1) > ARRAY_SIZE(data)) {
> +		dev_err(dev, "Command length (%d) exceeds buffer size (%lu)\n",
> +			len + 1, ARRAY_SIZE(data));
> +		return -EMSGSIZE;
> +	}
> +
> +	data[0] = cmd;
> +	if (len) {
> +		for (i = 0; i < len; i++)
> +			data[i + 1] = seq[i] | 0x0100;
> +	}
> +
> +	ret = dm_spi_xfer(dev, (len + 1) * 8 * sizeof(u16), data, NULL,
> +			  SPI_XFER_ONCE);
> +	return 0;
> +}
> +
> +#define ilitek_ili9806e_dcs_write_seq(dev, cmd, seq...)		\
> +({								\
> +	static const u8 b[] = { seq };				\
> +	ilitek_ili9806e_dcs_write(dev, cmd, b, ARRAY_SIZE(b));	\
> +})
> +
> +static int ilitek_ili9806e_enable_backlight(struct udevice *dev)
> +{
> +	struct ilitek_ili9806e_priv *priv = dev_get_priv(dev);
> +	const struct ilitek_ili9806e_desc *desc = priv->desc;
> +
> +	desc->init_sequence(dev);
> +
> +	return panel_set_backlight(dev, BACKLIGHT_DEFAULT);
> +}
> +
> +static int ilitek_ili9806e_set_backlight(struct udevice *dev, int percent)
> +{
> +	struct ilitek_ili9806e_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = backlight_enable(priv->backlight);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable backlight\n");
> +		return ret;
> +	}
> +
> +	ret = backlight_set_brightness(priv->backlight, percent);
> +	if (ret)
> +		dev_err(dev, "Cannot set backlight brightness\n");
> +
> +	return ret;
> +}
> +
> +static int ilitek_ili9806e_get_display_timing(struct udevice *dev,
> +					      struct display_timing *timing)
> +{
> +	struct ilitek_ili9806e_priv *priv = dev_get_priv(dev);
> +
> +	memcpy(timing, &priv->desc->timing, sizeof(*timing));

Insert a blank line before return.

> +	return 0;
> +}
> +
> +static int ilitek_ili9806e_of_to_plat(struct udevice *dev)
> +{
> +	struct ilitek_ili9806e_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
> +		ret = device_get_supply_regulator(dev, "vdd-supply", &priv->vdd);
> +		if (ret) {
> +			dev_err(dev, "Cannot get vdd supply\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
> +					   "backlight", &priv->backlight);
> +	if (ret) {
> +		dev_err(dev, "Cannot get backlight\n");
> +		return ret;
> +	}
> +
> +	ret = gpio_request_by_name(dev, "reset-gpios", 0,
> +				   &priv->reset_gpio, GPIOD_IS_OUT);
> +	if (ret) {
> +		dev_err(dev, "Cannot get reset GPIO\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ilitek_ili9806e_hw_init(struct udevice *dev)
> +{
> +	struct ilitek_ili9806e_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
> +	if (ret) {
> +		dev_err(dev, "Cannot enter reset\n");
> +		return ret;
> +	}
> +
> +	ret = regulator_set_enable_if_allowed(priv->vdd, 1);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable vdd-supply\n");
> +		return ret;
> +	}
> +
> +	mdelay(20);
> +
> +	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
> +	if (ret) {
> +		dev_err(dev, "Cannot exit reset\n");
> +		return ret;
> +	}
> +
> +	mdelay(20);
> +
> +	return 0;
> +}
> +
> +static int ilitek_ili9806e_probe(struct udevice *dev)
> +{
> +	struct ilitek_ili9806e_priv *priv = dev_get_priv(dev);
> +	struct spi_slave *slave = dev_get_parent_priv(dev);
> +	int ret;
> +
> +	ret = spi_set_wordlen(slave, 9);
> +	if (ret) {
> +		dev_err(dev, "Cannot set SPI.bits_per_word\n");
> +		return ret;
> +	}
> +
> +	ret = spi_claim_bus(slave);
> +	if (ret) {
> +		dev_err(dev, "Cannot get SPI bus\n");
> +		return ret;
> +	}
> +
> +	priv->desc = (struct ilitek_ili9806e_desc *)dev_get_driver_data(dev);

Add a blank line before return.

> +	return ilitek_ili9806e_hw_init(dev);
> +}
> +
> +static const struct panel_ops ilitek_ili9806e_ops = {
> +	.enable_backlight = ilitek_ili9806e_enable_backlight,
> +	.set_backlight = ilitek_ili9806e_set_backlight,
> +	.get_display_timing = ilitek_ili9806e_get_display_timing,
> +};
> +
> +static void rk050hr345_ct106a_init(struct udevice *dev)
> +{
> +	/* Switch to page 1 */
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xff, 0xff, 0x98, 0x06, 0x04, 0x01);
> +	/* Interface Settings */
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x08, 0x10);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x21, 0x01);
> +	/* Panel Settings */
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x30, 0x01);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x31, 0x00);
> +	/* Power Control */
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x40, 0x15);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x41, 0x44);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x42, 0x03);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x43, 0x09);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x44, 0x09);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x50, 0x78);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x51, 0x78);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x52, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x53, 0x3a);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x57, 0x50);
> +	/* Timing Control */
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x60, 0x07);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x61, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x62, 0x08);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x63, 0x00);
> +	/* Gamma Settings */
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xa0, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xa1, 0x03);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xa2, 0x0b);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xa3, 0x0f);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xa4, 0x0b);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xa5, 0x1b);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xa6, 0x0a);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xa7, 0x0a);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xa8, 0x02);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xa9, 0x07);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xaa, 0x05);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xab, 0x03);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xac, 0x0e);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xad, 0x32);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xae, 0x2d);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xaf, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xc0, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xc1, 0x03);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xc2, 0x0e);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xc3, 0x10);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xc4, 0x09);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xc5, 0x17);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xc6, 0x09);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xc7, 0x07);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xc8, 0x04);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xc9, 0x09);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xca, 0x06);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xcb, 0x06);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xcc, 0x0c);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xcd, 0x25);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xce, 0x20);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xcf, 0x00);
> +
> +	/* Switch to page 6 */
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xff, 0xff, 0x98, 0x06, 0x04, 0x06);
> +	/* GIP settings */
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x00, 0x21);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x01, 0x09);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x02, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x03, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x04, 0x01);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x05, 0x01);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x06, 0x80);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x07, 0x05);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x08, 0x02);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x09, 0x80);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x0a, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x0b, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x0c, 0x0a);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x0d, 0x0a);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x0e, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x0f, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x10, 0xe0);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x11, 0xe4);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x12, 0x04);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x13, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x14, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x15, 0xc0);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x16, 0x08);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x17, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x18, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x19, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x1a, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x1b, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x1c, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x1d, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x20, 0x01);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x21, 0x23);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x22, 0x45);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x23, 0x67);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x24, 0x01);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x25, 0x23);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x26, 0x45);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x27, 0x67);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x30, 0x01);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x31, 0x11);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x32, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x33, 0xee);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x34, 0xff);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x35, 0xbb);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x36, 0xca);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x37, 0xdd);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x38, 0xac);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x39, 0x76);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x3a, 0x67);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x3b, 0x22);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x3c, 0x22);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x3d, 0x22);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x3e, 0x22);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x3f, 0x22);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x40, 0x22);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x52, 0x10);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x53, 0x10);
> +
> +	/* Switch to page 7 */
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xff, 0xff, 0x98, 0x06, 0x04, 0x07);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x17, 0x22);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0x02, 0x77);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xe1, 0x79);
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xb3, 0x10);
> +
> +	/* Switch to page 0 */
> +	ilitek_ili9806e_dcs_write_seq(dev, 0xff, 0xff, 0x98, 0x06, 0x04, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
> +	ilitek_ili9806e_dcs_write_seq(dev, MIPI_DCS_EXIT_SLEEP_MODE);
> +
> +	mdelay(120);
> +
> +	ilitek_ili9806e_dcs_write_seq(dev, MIPI_DCS_SET_DISPLAY_ON);
> +
> +	mdelay(120);
> +}
> +
> +static const struct ilitek_ili9806e_desc rk050hr345_ct106a_desc = {
> +	.timing = {
> +		.pixelclock.typ = 27000000,
> +		.hactive.typ = 480,
> +		.hfront_porch.typ = 10,
> +		.hback_porch.typ = 10,
> +		.hsync_len.typ = 10,
> +		.vactive.typ = 854,
> +		.vfront_porch.typ = 10,
> +		.vback_porch.typ = 10,
> +		.vsync_len.typ = 10,
> +		.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW,
> +	},
> +	.init_sequence = rk050hr345_ct106a_init,
> +};
> +
> +static const struct udevice_id ilitek_ili9806e_ids[] = {
> +	{
> +		.compatible = "rocktech,rk050hr345-ct106a",
> +		.data = (ulong)&rk050hr345_ct106a_desc,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(ilitek_ili9806e) = {
> +	.name		= "ilitek_ili9806e",
> +	.id		= UCLASS_PANEL,
> +	.of_match	= ilitek_ili9806e_ids,
> +	.ops		= &ilitek_ili9806e_ops,
> +	.of_to_plat	= ilitek_ili9806e_of_to_plat,
> +	.probe		= ilitek_ili9806e_probe,
> +	.priv_auto	= sizeof(struct ilitek_ili9806e_priv),
> +	.flags		= DM_FLAG_PRE_RELOC,
> +};

