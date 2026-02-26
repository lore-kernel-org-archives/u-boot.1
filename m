Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DFAFC590A
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 07:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCBB783C54;
	Thu, 26 Feb 2026 08:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="kxKuaYKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 663AC83AA9; Thu, 26 Feb 2026 08:58:59 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B7AF83AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 08:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thECbFOp3z15/tWanaFHM8ORcjzcT3PZgdILB3NFBQTGSlMKDcF5lapULIppN6CdD3U86kE4jhliOsISiP8y5NrqagiHkmGFMj6Yt8HIpwcBE3/x0OCk58kB87KU1JwiTVuUC7k/5mZI/ykFUFo3m0KWTCKF8CNyfmJOXFVp37UB8z+VSJXqcImDkdsXVLBxWkXeZawFOr4UPiHTaTm6IgI0Kh0sbdkFTx8CV/SODvx3TOl+06rVk6Ch6TWVK+fP+qXaMIgnvOKKa14c+Q3PjdNfuG+PPm+1Ft9ECqbTBPATLyB05Zvhlwgs6FOW2AC8Hw70SQJrwDNaxC84grauLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7K0UQO3JHu/NygLHGfoksXbm1LwHrxODw7XMcSzTnpA=;
 b=gNIsk3SB9KvVeNuhV6m+dm+sgrAOZlPNidNqeITsT/x7jSEAyzR2RzAOvSHR7lyF0tQg4rCQxq0OWKcicgf6IOUMEKzVAevmczieuIbbCCa+Hl/FY4d6btkLIAHNZEXf2DX+fdFr3sFbVp/B8Iq87aoNSnc/F0m88ao9Q997X54VCewbvrpDbt/AcudnaO9yRpy8TgPVurJDRToJTsxusACuAA95WB8CHAx6ERC6QJbRMqARg+EDDB1D8cd8zV+EmFM2wQRKCbYw2RD1RqJ11JxfWU3eDty59QZWdoils84OnYMxTmT4ySkAfxfLRWWZLwel/6mwUELbi9+7ivxxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7K0UQO3JHu/NygLHGfoksXbm1LwHrxODw7XMcSzTnpA=;
 b=kxKuaYKotJe5uMXWlRyFF9WSfpTEdj9V1aecKAh+ytD83hy/mRHP4ilAg17YZGlF+Dd0QcRLrJzi+1m7bPjRKLrbOBxMdqeTm6MvCmTJoVdVsvmr3vaTgkg3q6NIoqsBDyHGd1M39I37Bs6RWVHR/CrQV3eoqZGErcDlbBChub4SSA5eVKtm3E1xR4U7AaZLHjWR1BX+g1Zps11vrAxjfEJHVV47Ez7LNyOWjZe70AB2xJV++tGXGoJ2Gg3BWR5rVFB1VIt2T/XCeSFatKSma65I9GPbUPq353+Rwb/mCCtCNaXn09p/t5GlOKoN5QQVZQjtE01AOBLAiArewzSdDQ==
Received: from AS4PR10CA0026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::20)
 by DB4PR10MB6216.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 07:58:54 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::87) by AS4PR10CA0026.outlook.office365.com
 (2603:10a6:20b:5d8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 07:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 07:58:54 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 26 Feb
 2026 09:01:02 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 26 Feb
 2026 08:58:53 +0100
Message-ID: <22b619fd-e0a7-4901-bbe5-3beb76801e5f@foss.st.com>
Date: Thu, 26 Feb 2026 08:58:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] video: support Rocktech RK050HR345-CT106A panel
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Alexander Graf <agraf@csgraf.de>, "Alper Nebi
 Yasak" <alpernebiyasak@gmail.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Dragan Simic <dsimic@manjaro.org>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Simon Glass <simon.glass@canonical.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
 <20260225161851.2475274-10-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260225161851.2475274-10-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A62:EE_|DB4PR10MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 43145b17-b0f8-439e-3236-08de750ce35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: MBU0i6uEnlhgEGEVJBXTtZRQKRDwGnrHZuGVONnL4rizpU5SYgdQeo+O9ocO/yhJyFgQzeKtHL6wwrWbmUp9S/O4PbqOQdQgE/pwTw6HibHGBGz/nlqbN7sXSKHEcecsQIcchnWHSLCeadm3dzI4prOhVAC/YIzYKk7a44g6weW60zOCcw9MOp6Gqr0GgpEquHJSCK/Qj84NkjLg6OoU3/yt48E8jRtQawKvVcWuHAmG4/Au8oSCj42zIapRtM2V1aYNRnLmXBGZlLhsPd+N+Zt3oyhGU5tDWVljWxN925193iDmIE4GmP2RJgauwJtNzYvKB9M08DL7PXW+m4ZzARZXQ3ZSqRa32lxU9rpZHIVEOv1B4VqgCty2lWrp1noXdltgVWaaJiJUaRocgA2DCTwD+QHoR64upNkLPiAVxzb1hGDrwvws9vdWXye5rDnhrCrEymsA2F+hMPz4ikJQRzw9bSlMUiqOLGDr22uN+wbItg95dpzHU2xt4nmgVCU/iXPQh6raBEvggiO5jjkP5yH5n+xyBjlElIkzl9O4LHIucj6Ev9AthKjejxDWbAE8zvb45PKeru8QKbh3dqzWAYM665Qd+dFgGw+r0aFgWFRbaBa9aZ/w3uIy43NmlhuHtlTrL+RgvPVvtvg92LxW4jnpxvMEe7JNAWvHB0QyZ+TusOQ545NdfMzwV2YtFdegdx2LBalM76J9lmBrSCEtdTXr40lP4exO6TVd6AaCwfNsHARXzuKnoG1Go+46YdlH5JNZkfa/WjoCnFXsEfMkpmuhz4QvSP39PXAuxEDtuhcmcldzK/mmqIHwrzOe/AJmkbUr71/T+vpY35xhL+Ey8w==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NODkZszK80/IhkMWeE2F9XK2eicx1raLyuSZmyDJF7N3l3WQKmFvtRQUhXwyr5Zk9+OIzcJOBszGbjBdAU0HhAgeSIxIDoRXaqLNlf/TXoEqQnRbRZosh7/nw0XNJQSAzAohGUeAOeSTYwhmbpDOMGGpL/7CP09ZMTLlXgHkNF/duFMeScXgw1ptj9JFjuMCOqmcWrjcw4Q6pCAsZ0L6j9DY22DLIPmF0xnQEL9MU5VkP3m6xBa1LRIqvjNm3smH/pSGZNMaVMGhkeHGyisVNXv9aZ45NT/A3NfYSG/gTVx+5oMqeo+bEL5gGqbKpPufVXtebq1wkUjAlLZzuHQrUTmjZCnqLAgPX5qYkQeBuJNKKYNiZAajs70e/iklZevEYrfj9yx7cH3ZVFeP7pk/nxCcaijj1lvbmE0Irc+u0H63A984hhd9w/pG7ZSbhv2w
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 07:58:54.7071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43145b17-b0f8-439e-3236-08de750ce35f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6216
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



On 2/25/26 17:17, Dario Binacchi wrote:
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
> Changes in v3:
> - Insert blank lines to separate code in ilitek-ili9806e.c
> 
> Changes in v2:
> - Rplace tristate with bool in drivers/video/Kconfig
> 
>  drivers/video/Kconfig           |   8 +
>  drivers/video/Makefile          |   1 +
>  drivers/video/ilitek-ili9806e.c | 356 ++++++++++++++++++++++++++++++++
>  3 files changed, 365 insertions(+)
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
> index 000000000000..9ba580639c9a
> --- /dev/null
> +++ b/drivers/video/ilitek-ili9806e.c
> @@ -0,0 +1,356 @@
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
> +
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
> +
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

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

