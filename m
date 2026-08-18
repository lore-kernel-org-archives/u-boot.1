Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B57C5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 14:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEF0D4088B;
	Tue, 18 Aug 2026 14:12:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O_GUDTlQmW8R; Tue, 18 Aug 2026 14:12:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F9164086F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787062378;
	bh=9CuzwgnNAY/Zonu0aWNcP5PvarWtZI0aDzgCUywTpgQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j51c9/hX7IFFLBAbHGCNwntmSOdcSVhxAybFudH0yfnO+hxAms64rREHVD2lHpqYu
	 DDtU4jNqqik9AA7sBylctzIgvMiyjhDoRaS0XaVWR1tzeVDpUijZEWFpwsB324iZyE
	 VeRrr8ej4uNWLzwqDuCAZ7TPXy3fRhROn7nAyqjVW3wP2NN3e2k3HMZpUeISQOISh2
	 KI8nOtTznvgGB4S1WiD0hIatQg2aHYwrPzl/aTyI/KVMNCz9LqEGZcb4NDYmGQ/vNZ
	 7q5DiLI1IywumyxpdFVX02aUdw2AUu9uKrUJo9AeN+7kF0NfyA8NvZKApsryWWM8UW
	 EMWh9yoqKTmOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F9164086F;
	Tue, 18 Aug 2026 14:12:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9051A237
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 14:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 767CC40173
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 14:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HgQlnRLcyF61 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 14:12:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6C81D40159
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C81D40159
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=K61YYbyG
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C81D40159
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 14:12:54 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-92e5b048375so241979785a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787062373; x=1787667173;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9CuzwgnNAY/Zonu0aWNcP5PvarWtZI0aDzgCUywTpgQ=;
 b=K61YYbyGIbR1KzImq+8cDJ/Wpndxap36j6VNZFG+OY6s9tiXyyZCYwMBzwZVgigRFF
 lCaAJrYXZQMGLtgdwV2RpIypsLb/WfXqSYYA2M70yApTr0LSZv4WBNbfaQlrc53ykkqf
 MwHv0kLShTAtd16Scq3AvObNhTPPl4WeT6SOwL0UEJYZNcPcR+y150j8moV1GMvcRpQi
 f+yAhoIntbwFNIDNUkE63KUMztVE+mSHNzW84lmAlge9QoB4q8oYoEL3W55ccz+MvBPQ
 Vb9j707Ppx6wt+ACwNX6LmLr2GeU42CXE2NFED+7l5swcW93ExaPS7zOlZxQzLAWJU4M
 QGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787062373; x=1787667173;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9CuzwgnNAY/Zonu0aWNcP5PvarWtZI0aDzgCUywTpgQ=;
 b=dHm29IrCreM3fduRTBY+oVh6G//q38TSu2j3Go7yN78VXAIxaMvfnW5KYe3RbM0TS5
 2Bulb4lcAZ93oeoGm1gFXeuSZbQIpmMNP/Ycjs5C0K3B+E2JVD10Hs0NmXNuj4ko3jCA
 H+IW/AsA3+jbAKIebOof7VFZNz4Ri4Xs4Z4JyD/PJUoCC3XjJLyQRq1PtSNgSzD7QoTH
 ZalGKTmjUH/a2+ssttMGH3RWE/pZUk/61k/Lo1BVO2EuuGF8s5jyo2LeYTHho/n4itvp
 Ywhb1C5hmFhN73qIjoWUrPYFANxacnPhN6KbyrBcIJNg2RGVz9wrEnIVHJMROrYHu8aB
 orkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXMuo1LQI6P3EjUfUVTzIC5rWWjlO5f1+tvy4KA+/DiJLn1PZ7K1aro6HKEHFR5U38mdCiK4I=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx251uM1P7yxjm/CNstXeHlCjK3xb0qfAofMqufFPEqzH9ayRc6
 br6dssVLNb299DU9b1g5fmlSfQRYomfQ71KCbnnFp0YxXGlei9amGh5wLS3uqi5VwQo=
X-Gm-Gg: AR+sD12IVJHhjVn2KzmYq4ulSKLe569EYDVQdWYrTE49Co2eBzHr2MdLrL3L4jyGs52
 JyBj3e0XM4sugpdEbN5J+wxM98mhGbfR1yE2gjFVLWcSSuY5PR/do0IPGgXBbe5r/cmaIySoav0
 meimlSoIYiB1CwoT8mpZIxy6Y62joR1P83rkdLLUKhz7i0SR8fYAGMR81d0p6j+gfi3apkN26mI
 VM79a/sLMcNSNGArEN0naYc3aknR7vB/GwvOxNbgiBS7Aq8MGLwEzCrsgI320bmEbA7WMF0l/Tx
 rynP5SmMwCX2Ph9OI329zVUQXgFrIFc0JsPKksGaYL9EKLebLq52q9tQEnED7r7ccNT/iuIm+b1
 yfqlO8vw7VzvtphSz9evl1zwnO2KUj+dEBofrzCiLFvxu/UGROsoAVnL4Ct8Lpxh9krMQ79KJG2
 iSBK+qcUYkqSKlnmwHb8MZb0Kx8jmsJtbOWcAVwqVwH5D50BWkg5tb4+OLz3dmuFqLLR4kLM/Aw
 JFLg40IdqYGNmbkdL4ijOri05oxFYxkSgb1Ct/9PmSB
X-Received: by 2002:a05:620a:450c:b0:92e:8aed:4785 with SMTP id
 af79cd13be357-93704b7d3e5mr868554085a.25.1787062372698; 
 Tue, 18 Aug 2026 07:12:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1cf0:fc72:ac61:29db?
 ([2600:8803:e7e4:500:1cf0:fc72:ac61:29db])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937010c32f8sm334400685a.6.2026.08.18.07.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 07:12:51 -0700 (PDT)
Message-ID: <2d03d467-b828-4fb0-bb11-05fa2bf0e9a9@baylibre.com>
Date: Tue, 18 Aug 2026 09:12:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: panel: Support for startek-kd070fhfid015 MIPI-DSI
 panel
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Rasmus Villemoes <ravi@prevas.dk>
References: <20260806-add-panel-startek-kd070fhfid015-v1-1-7899337feb34@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260806-add-panel-startek-kd070fhfid015-v1-1-7899337feb34@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/6/26 6:53 AM, Julien Stephan wrote:
> This driver support the Startek KD070FHFID015, which is a 7-inch TFT LCD

s/support/supports/

> display using MIPI DSI interface. It is based on kernel commit
> b080a60731ad ("drm/panel: startek-kd070fhfid015: transition to mipi_dsi
> wrapped functions").
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
> This driver support the Startek KD070FHFID015, which is a 7-inch TFT LCD
> display using MIPI DSI interface. It is based on kernel commit
> b080a60731ad ("drm/panel: startek-kd070fhfid015: transition to mipi_dsi
> wrapped functions").
> 
> This panel is used on some Mediatek Genio EVKS, such as Genio-350.
> 
> The full video pipeline series enabling full support will be sent later.
> 
> This series depends on [1], for mipi_dsi_write_seq helpers.
> 
> [1]: https://lore.kernel.org/all/20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com/
> ---
>  drivers/video/Kconfig                       |  10 ++
>  drivers/video/Makefile                      |   1 +
>  drivers/video/panel-startek-kd070fhfid015.c | 267 ++++++++++++++++++++++++++++

Probably should add MAINTAINERS entry.

>  3 files changed, 278 insertions(+)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index cb3ba6a6f63..6de28d78705 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -320,6 +320,16 @@ config PANEL_HX8238D
>  	  It can drive a maximum 960x240 dot graphics on a-TFT panel
>  	  displays in 16M colors with dithering.
>  
> +config PANEL_STARTEK_KD070FHFID015
> +	bool "STARTEK KD070FHFID015 panel"
> +	depends on PANEL && DM_GPIO

&& DM_REGULATOR

> +	select VIDEO_MIPI_DSI
> +	help
> +	  Say Y here if you want to enable support for STARTEK KD070FHFID015 DSI panel.

This line is getting a bit long.

> +	  The panel is a 7-inch TFT LCD display with a resolution of 1200 x 1920
> +	  pixels. It provides a MIPI DSI interface to the host, a built-in LED
> +	  backlight and touch controller.
> +
>  config VIDEO_BOCHS
>  	bool "Enable Bochs video emulation for QEMU"
>  	help
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index a20011b9b17..7a54f1f290d 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_$(PHASE_)VIDEO) += video-uclass.o vidconsole-uclass.o
>  obj-$(CONFIG_$(PHASE_)VIDEO) += video_bmp.o
>  obj-$(CONFIG_$(PHASE_)PANEL) += panel-uclass.o
>  obj-$(CONFIG_PANEL_HX8238D) += hx8238d.o
> +obj-$(CONFIG_PANEL_STARTEK_KD070FHFID015) += panel-startek-kd070fhfid015.o
>  obj-$(CONFIG_$(PHASE_)SIMPLE_PANEL) += simple_panel.o
>  
>  obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.bmp.o
> diff --git a/drivers/video/panel-startek-kd070fhfid015.c b/drivers/video/panel-startek-kd070fhfid015.c
> new file mode 100644
> index 00000000000..c0b3cf1a5ff
> --- /dev/null
> +++ b/drivers/video/panel-startek-kd070fhfid015.c
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2016 InforceComputing
> + * Copyright (C) 2016 Linaro Ltd
> + * Copyright (C) 2026 BayLibre, SAS
> + *
> + * Authors:
> + * - Vinay Simha BN <simhavcs@gmail.com>
> + * - Sumit Semwal <sumit.semwal@linaro.org>
> + * - Guillaume La Roque <glaroque@baylibre.com>
> + *
> + * U-Boot port:
> + * Authors:
> + * - Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +#include <asm-generic/gpio.h>
> +#include <backlight.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <errno.h>
> +#include <linux/delay.h>
> +#include <malloc.h>
> +#include <mipi_dsi.h>
> +#include <panel.h>
> +#include <power/regulator.h>

Not all of these are used, e.g. backlight.h and malloc.h.
And should have explicit mipi_display.h.

> +
> +#define DSI_REG_MCAP	0xb0
> +#define DSI_REG_IS	0xb3 /* Interface Setting */
> +#define DSI_REG_IIS	0xb4 /* Interface ID Setting */
> +#define DSI_REG_CTRL	0xb6
> +
> +struct stk_panel {
> +	const struct drm_display_mode *mode;
> +	struct udevice *dev;
> +	struct gpio_desc *enable_gpio; /* Power IC supply enable */
> +	struct gpio_desc *reset_gpio; /* External reset */
> +	struct mipi_dsi_device *dsi;
> +	struct udevice *iovcc;
> +	struct udevice *power;
> +};
> +
> +static const struct drm_display_mode default_mode = {
> +	.clock = 163204,
> +	.hdisplay = 1200,
> +	.hsync_start = 1200 + 144,
> +	.hsync_end = 1200 + 144 + 16,
> +	.htotal = 1200 + 144 + 16 + 45,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 8,
> +	.vsync_end = 1920 + 8 + 4,
> +	.vtotal = 1920 + 8 + 4 + 4,
> +};
> +
> +static int stk_panel_init(struct stk_panel *stk)
> +{
> +	struct mipi_dsi_device *dsi = stk->dsi;
> +	struct udevice *dev = stk->dsi->dev;

This is the DSI host device. Probably meant st->dev here.

> +	int ret;
> +
> +	ret = mipi_dsi_dcs_soft_reset(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to mipi_dsi_dcs_soft_reset: %d\n", ret);
> +		return ret;
> +	}
> +	mdelay(5);
> +
> +	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set exit sleep mode: %d\n", ret);
> +		return ret;
> +	}
> +	mdelay(120);
> +
> +	mipi_dsi_generic_write_seq(dsi, DSI_REG_MCAP, 0x04);
> +
> +	/* Interface setting, video mode */
> +	mipi_dsi_generic_write_seq(dsi, DSI_REG_IS, 0x14, 0x08, 0x00, 0x22, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, DSI_REG_IIS, 0x0c, 0x00);
> +	mipi_dsi_generic_write_seq(dsi, DSI_REG_CTRL, 0x3a, 0xd3);
> +
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0x77);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write display brightness: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
> +			       MIPI_DCS_WRITE_MEMORY_START);
> +
> +	ret = mipi_dsi_dcs_set_pixel_format(dsi, 0x77);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set pixel format: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mipi_dsi_dcs_set_column_address(dsi, 0, stk->mode->hdisplay - 1);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set column address: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mipi_dsi_dcs_set_page_address(dsi, 0, stk->mode->vdisplay - 1);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set page address: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stk_panel_on(struct stk_panel *stk)
> +{
> +	struct mipi_dsi_device *dsi = stk->dsi;
> +	struct udevice *dev = stk->dsi->dev;
> +	int ret;
> +
> +	ret = mipi_dsi_dcs_set_display_on(dsi);
> +	if (ret < 0)
> +		dev_err(dev, "failed to set display on: %d\n", ret);
> +
> +	mdelay(20);
> +
> +	return ret;
> +}
> +
> +static int stk_panel_enable_backlight(struct udevice *dev)
> +{
> +	struct stk_panel *stk = dev_get_priv(dev);
> +	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
> +	struct mipi_dsi_device *dsi = plat->device;
> +	int ret;
> +
> +	stk->dsi = dsi;
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret < 0)
> +		return ret;
> +
> +	dm_gpio_set_value(stk->reset_gpio, 0);
> +	dm_gpio_set_value(stk->enable_gpio, 0);
> +	ret = regulator_enable(stk->iovcc);
> +	if (ret < 0)

Do we need to unwind with mipi_dsi_detach() here?

> +		return ret;
> +
> +	mdelay(8);
> +	ret = regulator_enable(stk->power);
> +	if (ret < 0)
> +		goto iovccoff;
> +
> +	mdelay(20);
> +	dm_gpio_set_value(stk->enable_gpio, 1);
> +	mdelay(20);
> +	dm_gpio_set_value(stk->reset_gpio, 1);
> +	mdelay(10);
> +
> +	ret = stk_panel_init(stk);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to init panel: %d\n", ret);
> +		goto poweroff;
> +	}
> +
> +	ret = stk_panel_on(stk);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set panel on: %d\n", ret);
> +		goto poweroff;
> +	}
> +
> +	return 0;
> +
> +poweroff:
> +	regulator_disable(stk->power);
> +iovccoff:
> +	regulator_disable(stk->iovcc);
> +	dm_gpio_set_value(stk->reset_gpio, 0);
> +	dm_gpio_set_value(stk->enable_gpio, 0);
> +
> +	return ret;
> +}
> +
> +static int stk_panel_add(struct stk_panel *stk)
> +{
> +	struct udevice *dev = stk->dev;
> +	int ret;
> +
> +	stk->mode = &default_mode;
> +
> +	ret = device_get_supply_regulator(dev, "iovcc-supply", &stk->iovcc);
> +	if (ret) {
> +		dev_err(dev, "Failed to get iovcc regulator: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = device_get_supply_regulator(dev, "power-supply", &stk->power);
> +	if (ret) {
> +		dev_err(dev, "Failed to get power regulator: %d\n", ret);
> +		return ret;
> +	}
> +
> +	stk->reset_gpio = devm_gpiod_get(dev, "reset",
> +					 GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);

Driving the gpios before enabling the regulators is probably not a good idea.

> +	if (IS_ERR(stk->reset_gpio)) {
> +		ret = PTR_ERR(stk->reset_gpio);
> +		dev_err(dev, "cannot get reset-gpios %d\n", ret);
> +		return ret;
> +	}
> +
> +	stk->enable_gpio = devm_gpiod_get(dev, "enable",
> +					  GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> +	if (IS_ERR(stk->enable_gpio)) {
> +		ret = PTR_ERR(stk->enable_gpio);
> +		dev_err(dev, "cannot get enable-gpio %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stk_panel_probe(struct udevice *dev)
> +{
> +	struct stk_panel *stk = dev_get_priv(dev);
> +	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
> +	int ret;
> +
> +	stk->dev = dev;
> +
> +	/* fill characteristics of DSI data link */
> +	plat->lanes = 4;
> +	plat->format = MIPI_DSI_FMT_RGB888;
> +	plat->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
> +
> +	ret = stk_panel_add(stk);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +int stk_panel_get_modes(struct udevice *dev, const struct drm_display_mode **modes)

static

> +{
> +	struct stk_panel *stk = dev_get_priv(dev);
> +
> +	if (!stk->mode)
> +		return -ENODEV;
> +
> +	*modes = stk->mode;

nit: blank line before return

> +	return 1;
> +}
> +
> +static const struct panel_ops stk_panel_ops = {
> +	.enable_backlight	= stk_panel_enable_backlight,
> +	.get_modes		= stk_panel_get_modes,
> +};
> +
> +static const struct udevice_id stk_of_match[] = {
> +	{ .compatible = "startek,kd070fhfid015", },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(stk_panel_driver) = {

Suggest we make the prefix stk078 in this file instead of stk as this
is not the only startek panel. I used stk015 in the driver I recently
submitted.

> +	.name		= "panel-startek-kd070fhfid015",
> +	.id		= UCLASS_PANEL,
> +	.of_match	= stk_of_match,
> +	.ops		= &stk_panel_ops,
> +	.probe		= stk_panel_probe,
> +	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
> +	.priv_auto	= sizeof(struct stk_panel),
> +};
> 
