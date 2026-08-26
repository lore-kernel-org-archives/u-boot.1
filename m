Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386A5C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 17:11:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEA1180984;
	Wed, 26 Aug 2026 17:11:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ErEUI7CNsBvi; Wed, 26 Aug 2026 17:11:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787764294;
	bh=U6y0vXAVNrTnDpA4dmmh55oFlmyGoo8wFvWsEz6/l90=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hDc2qYXJQk58/3MK4F29b0wgSsxaeITY84jw9lvknac/8gvPoTkbN6Fjiegsv/jzX
	 jHohLmGt+NgMcKBMpBRU0CAV5C7Rmp2Hxoc5LLb9f90XmBD82KdAaTltIu1zjDgJvi
	 GOqNjyoIEcYJKnAeRjM4sPfe36UkG+8UKYaZ1yVhYCzF9HfEBJBSj9ewONzc083q/l
	 FkI/weyScFE1opXeF39mvTzqJoVWFaY37CuyE+0ZgOMzT9Mjva1sasRvgxjt006dYy
	 xT6otIqs2bXdrt4wWxC4qhOWsKa5pNbrPRIE8jfMhCuVem0MOGLv84A4qAGb1l0e4l
	 WBClEm8ecbtLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95F9F80992;
	Wed, 26 Aug 2026 17:11:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B4994230
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A626180992
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:11:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7xPBmKfxLTED for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 17:11:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XGyVocOI
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51F9A80984
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:11:29 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-495c49f8eccso1266852b6e.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787764288; x=1788369088;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U6y0vXAVNrTnDpA4dmmh55oFlmyGoo8wFvWsEz6/l90=;
 b=XGyVocOIqOCfOcpMliMzajh+JYf4WDQCkXrpPofQibpaFWn3eyKvyygvZW1TYaVgp1
 2ZxKSRIQgEHP5TeV+onx7433ZdIQYBMxzTLmX9vGZdM/NWe+1qG7qBC9MI3iE1h+/0Hu
 9EqWfWJJcLyrYRDxfOPwVp1azsdOC2JjBjGnyyhwRD++Zq9KOqjuK+Z2S1PiMX7n53L+
 l3kCqea05gRINJmJysFkDTaRXGtxpQAJE5F3t4J2xDMVXueIlk1CWlZA19ser5WnmbEj
 SC0aIQ0At3Q7ARL5yAvuWDlZ1Qd21tDYBXJmvXRcwDH4EYQwwYhCpcY27Jd8LGt/pfEY
 gr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764288; x=1788369088;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U6y0vXAVNrTnDpA4dmmh55oFlmyGoo8wFvWsEz6/l90=;
 b=PN2mhyvcxkpwUY2JXI+RqLD2rq0IQ+NsM0xbe3jsd1k6w1H3kHcfi4UK4Qg6/AhfOB
 5tVYUhwzV6iIETjos3u3AY7FdooptPeFn0fMNP15BBlqm2bGvZ9SJ/PiFNtAz6lw3uiR
 H3m/QWK9YEFWrdZ3l6Z9ul3Lmhg8l8c6gEKT9Oj9dvR9aRrAiNgnQ6UxewLEIFRIR4b3
 EXi4Ikdy3X+SDDYVnoc1vPCeGHuB3embLXmfKJA3K7xsdV66zTu23sX6lFrld2TdyACV
 pX25jwe+u4QecZUCpDIJYTWi9zPKdyJVUQq+LUK1uVLuGymP/UxbfAEu7Ouv2l9SDrX/
 scpw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpigETRxU6NS12EX/p0hBNgpsbWbwFlRdX4eOtII3S6mSYZw0U0llTFh1GOPY/0miqTbVOzteA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nXMw7UA+oeemtdwNPHjrplJ2X9QfuqZdpqRYW3HrYrnhe53f+m
 xro0PTMRAshhCiG2YXX86FlBeVC+0HF1flEvYPfIv6dpPHi0wa634ZfKiAXEnqIcMEc=
X-Gm-Gg: AR+sD10rvTYKvi3qgX74vIevbD2EmghXQ0xc7hHJCfqJJej24XFAlXTMljSAuQEm4Ja
 7jFt3i3iGTqBbNq5R+aOmcTEC2qDWCwm85dQFLFkZDxJ6WakLfdbIlsCv6vw0SgHWOYydP4VDm1
 9Lj3DabbJK0w/C1Z9JksQuWhpPKJSPAUinChHJ9CxktSueZWPZ5BbgyYCabUlC+RPcZPxRVkZW/
 q8O3FDUDSBkIS5rogh/i5MK0mp1503c854vx2MSpHIZOeSbVgxFSxsTTwKlt9hQZWQ1BDnBUwsU
 LHmJmZ3fv63YmO6801nJGoYjFxsnElOPN+J39jXnR82b71/kk1Mn/o+JlLZ7iXsaH9SBCHVCQ+y
 U93wWF7XyM8tQkSOJisDHuzV//6nsT0r8ps5QpSLds47usdrjf/eZ/PZ40ZftswZz9XoMFip4mv
 TCHBbG8g6tAlsy7TstN9n0+s/5HDFqUB758Ncq65lrxRf2tMUFET0ZCvmWz3qH9AhvLLwn/oymD
 2UX105x036C0Wu0Dajgr+/2htqToxKYlZGpazo=
X-Received: by 2002:a05:6808:c297:b0:4b2:e95f:380d with SMTP id
 5614622812f47-4b36698e87fmr10311526b6e.6.1787764288027; 
 Wed, 26 Aug 2026 10:11:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:162c:81fd:da88:2ea6?
 ([2600:8803:e7e4:500:162c:81fd:da88:2ea6])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b36a7b06c2sm2105797b6e.7.2026.08.26.10.11.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:11:27 -0700 (PDT)
Message-ID: <f7af7e3a-f721-48a3-92e9-2fb48c735a3d@baylibre.com>
Date: Wed, 26 Aug 2026 12:11:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] video: mediatek: add new hdmi driver
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
 <20260826-add-genio-510-and-genio-700-hdmi-v2-11-68ebb1bf17df@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-11-68ebb1bf17df@baylibre.com>
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

On 8/26/26 8:09 AM, Julien Stephan wrote:
> Add a UCLASS_VIDEO driver for the HDMI TX v2 IP found on the MT8188.
> 
> On probe, the driver waits for a plugged and powered display, reads
> its EDID through the DDC bus to select the preferred mode, configures
> the HDMI controller and PHY accordingly, and then programs all the
> components of the vdosys1 pipeline (MDP RDMA, padding, VPP merge,
> ETHDR mixer, mutex, DPI1) to scan out the framebuffer. The
> framebuffer lives in a dedicated reserved-memory region referenced by
> the "memory-region" property of the hdmi node.
> 
> Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/video/Kconfig             |    1 +
>  drivers/video/Makefile            |    1 +
>  drivers/video/mediatek/Kconfig    |   21 +
>  drivers/video/mediatek/Makefile   |   16 +
>  drivers/video/mediatek/mtk_hdmi.c | 1102 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 1141 insertions(+)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 15000e21840..cb3ba6a6f63 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -770,6 +770,7 @@ config VIDEO_LCD_SPI_MISO
>  	  option takes a string in the format understood by 'sunxi_name_to_gpio'
>  	  function, e.g. PH1 for pin 1 of port H.
>  
> +source "drivers/video/mediatek/Kconfig"
>  source "drivers/video/meson/Kconfig"
>  
>  config VIDEO_MVEBU
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 082b8967982..a20011b9b17 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -92,5 +92,6 @@ obj-$(CONFIG_VIDEO_SEPS525) += seps525.o
>  obj-$(CONFIG_VIDEO_ZYNQMP_DPSUB) += zynqmp/
>  
>  obj-y += bridge/
> +obj-y += mediatek/
>  obj-y += sunxi/
>  obj-y += tegra/
> diff --git a/drivers/video/mediatek/Kconfig b/drivers/video/mediatek/Kconfig
> new file mode 100644
> index 00000000000..54cf1b11fdf
> --- /dev/null
> +++ b/drivers/video/mediatek/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2026 BayLibre, SAS
> +#
> +# Author: Julien Stephan <jstephan@baylibre.com>
> +
> +config VIDEO_MEDIATEK_HDMI
> +	bool "Video HDMI Support for Mediatek SoCs"
> +	depends on VIDEO && ARCH_MEDIATEK
> +	depends on DM_I2C && PHY && POWER_DOMAIN
> +	select I2C_EDID
> +	select MISC
> +	select PHY_MTK_HDMI
> +	select MTK_POWER_DOMAIN
> +	select SYS_I2C_DDC_MTK
> +	help
> +	  Enable support for the HDMI TX output found on recent MediaTek
> +	  SoCs such as the MT8188. The driver reads the EDID of the
> +	  connected display, selects its preferred mode and drives the
> +	  vdosys1 display pipeline (MDP RDMA, padding, merge, ETHDR
> +	  mixer, DPI) to scan out the U-Boot framebuffer over HDMI.
> diff --git a/drivers/video/mediatek/Makefile b/drivers/video/mediatek/Makefile
> new file mode 100644
> index 00000000000..70da9d9662a
> --- /dev/null
> +++ b/drivers/video/mediatek/Makefile
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2026 MediaTek Inc.
> +#
> +# Author: Julien Stephan <jstephan@baylibre.com>
> +
> +obj-$(CONFIG_VIDEO_MEDIATEK_HDMI) += \
> +	mtk_hdmi.o \
> +	mtk_disp_comp.o \
> +	mtk_dpi.o \
> +	mtk_mdp_rdma.o \
> +	mtk_disp_merge.o \
> +	mtk_ethdr.o \
> +	mtk_disp_mutex.o \
> +	mtk_disp_padding.o \
> +	mtk_smi_larb.o
> diff --git a/drivers/video/mediatek/mtk_hdmi.c b/drivers/video/mediatek/mtk_hdmi.c
> new file mode 100644
> index 00000000000..a37fe44b295
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_hdmi.c
> @@ -0,0 +1,1102 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026 BayLibre, SAS
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +#include <asm/io.h>

> +#include <asm/system.h>

Still used?

> +#include <asm/unaligned.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/ofnode.h>
> +#include <edid.h>
> +#include <errno.h>
> +#include <generic-phy.h>
> +#include <i2c.h>
> +#include <linux/delay.h>
> +#include <linux/hdmi.h>
> +#include <video.h>
> +
> +#include "mtk_disp_comp.h"
> +#include "mtk_disp_merge.h"
> +#include "mtk_ethdr.h"
> +#include "mtk_disp_mutex.h"
> +#include "mtk_disp_padding.h"
> +#include "mtk_dpi.h"
> +#include "mtk_mdp_rdma.h"
> +
> +/* HDMI TX register definitions */
> +#define AVI_DIS					(0)
> +#define AVI_DIS_WR				(0)
> +#define AVI_EN					(0x1)
> +#define AVI_EN_WR				BIT(16)
> +#define AVI_RPT_DIS				(0x0)
> +#define AVI_RPT_EN				(0x1)
> +
> +#define C422_C420_CONFIG_BYPASS			BIT(5)
> +#define C422_C420_CONFIG_ENABLE			BIT(4)
> +#define C422_C420_CONFIG_OUT_CB_OR_CR		BIT(6)
> +#define C444_C422_CONFIG_ENABLE			(0x1)
> +
> +#define DEEPCOLOR_MODE_10BIT			BIT(8)
> +#define DEEPCOLOR_MODE_12BIT			GENMASK(9, 8)
> +#define DEEPCOLOR_MODE_16BIT			GENMASK(10, 8)
> +#define DEEPCOLOR_MODE_8BIT			(0)

These are confusing and don't quite match linux. Should be a field with
GENMASK(9, 8) and values 0, 1, 2, 3.

> +#define DEEPCOLOR_MODE_MASKBIT			GENMASK(10, 8)
> +#define DEEPCOLOR_PAT_EN			BIT(12)
> +#define DEEP_COLOR_ADD				BIT(4)
> +
> +#define HDMI2_OFF				(0)
> +#define HDMI2_ON				BIT(2)
> +
> +#define HDMITX_SW_HPD				BIT(29)
> +#define HDMITX_SW_RSTB				BIT(31)
> +
> +#define HDMI_MODE_DVI				(0)
> +#define HDMI_MODE_HDMI				BIT(3)
> +
> +#define HDMI_YUV420_MODE			BIT(10)
> +
> +#define HPD_DDC_STATUS				0xC60
> +#define PORD_PIN_STA				BIT(5)
> +#define HPD_PIN_STA				BIT(4)
> +
> +#define NULL_PKT_EN				BIT(2)
> +#define NULL_PKT_VSYNC_HIGH_EN			BIT(3)
> +
> +#define OUTPUT_FORMAT_DEMUX_420_ENABLE		BIT(10)
> +
> +#define REG_VMUTE_EN				BIT(16)
> +
> +#define SCR_OFF					0
> +#define SCR_ON					BIT(4)
> +
> +#define SPD_DIS					0
> +#define SPD_DIS_WR				0
> +#define SPD_EN					BIT(1)
> +#define SPD_EN_WR				BIT(17)
> +#define SPD_RPT_DIS				0
> +#define SPD_RPT_EN				BIT(1)
> +
> +#define TOP_CFG00				0x000
> +#define TOP_CFG01				0x004
> +#define TOP_INFO_EN				0x01C
> +#define TOP_INFO_RPT				0x020
> +#define TOP_AVI_HEADER				0x024
> +#define TOP_AVI_PKT00				0x028
> +#define TOP_AVI_PKT01				0x02C
> +#define TOP_AVI_PKT02				0x030
> +#define TOP_AVI_PKT03				0x034
> +#define TOP_AVI_PKT04				0x038
> +#define TOP_AVI_PKT05				0x03C
> +#define TOP_INT_MASK00				0x1B0
> +#define TOP_INT_MASK01				0x1B4

These MASK names don't match Linux.

> +#define TOP_MISC_CTLR				0x1A4
> +#define TOP_SPDIF_HEADER			0x054
> +#define TOP_SPDIF_PKT00				0x058
> +#define TOP_SPDIF_PKT01				0x05C
> +#define TOP_SPDIF_PKT02				0x060
> +#define TOP_SPDIF_PKT03				0x064
> +#define TOP_SPDIF_PKT04				0x068
> +#define TOP_SPDIF_PKT05				0x06C
> +#define TOP_SPDIF_PKT06				0x070
> +#define TOP_SPDIF_PKT07				0x074
> +#define TOP_VMUTE_CFG1				0x1C8
> +
> +#define VID_DOWNSAMPLE_CONFIG			0x8F0

This doesn't match upstream Linux (but does match downstream). We should
confirm which is correct.

> +#define VID_OUT_FORMAT				0x8FC
> +
> +#define ABIST_ENABLE				BIT(31)
> +
> +#define HDCP_TOP_CTRL				0xC00
> +#define HDMI_CONFIG				0xEA0
> +

...

> +struct mtk_hdmi {
> +	struct udevice *dev;
> +	struct udevice *ddc_bus;
> +	struct udevice *dpi1;
> +	struct udevice *merge3;
> +	struct udevice *merge5;
> +	struct udevice *ethdr;
> +	struct udevice *mutex;
> +	struct udevice *padding4;
> +	struct udevice *padding5;
> +	struct udevice *rdma4;
> +	struct udevice *rdma5;
> +	struct udevice *larb2;
> +	struct udevice *larb3;
> +	struct phy phy;
> +	fdt_addr_t regs;

Should be `void __iomem *`?

> +	struct clk_bulk clk_bulk;
> +	u64 support_csp_depth;

Unused field.

> +	u64 set_csp_depth;
> +	enum hdmi_colorspace csp;
> +	enum hdmi_color_depth color_depth;
> +	enum hdmi_colorimetry colorimetry;
> +	struct display_timing mode;
> +};
> +

...

> +static void mtk_hdmi_hw_vid_black(struct mtk_hdmi *hdmi, bool black)
> +{
> +	if (black)
> +		mtk_hdmi_update(hdmi, TOP_VMUTE_CFG1, REG_VMUTE_EN, REG_VMUTE_EN);
> +	else
> +		mtk_hdmi_update(hdmi, TOP_VMUTE_CFG1, 0, REG_VMUTE_EN);

Can we simplify this like mtk_hdmi_enable_hdmi_mode()?

There are a couple more cases like this below too.

> +}
> +

...

> +static inline void mtk_hdmi_enable_scrambling(struct mtk_hdmi *hdmi,
> +					      bool enable)
> +{
> +	udelay(150);

Odd to have a delay before doing something.

Should this be moved to mtk_hdmi_change_video_resolution()?

> +
> +	if (enable)
> +		mtk_hdmi_update(hdmi, TOP_CFG00, SCR_ON | HDMI2_ON,
> +				SCR_ON | HDMI2_ON);
> +	else
> +		mtk_hdmi_update(hdmi, TOP_CFG00, SCR_OFF | HDMI2_OFF,
> +				SCR_ON | HDMI2_ON);
> +}
> +

...

> +static void mtk_hdmi_output_set_display_mode(struct mtk_hdmi *hdmi,
> +					     struct display_timing *mode)
> +{
> +	unsigned long link_rate = mode->pixelclock.typ;
> +	int ret;
> +
> +	ret = generic_phy_configure(&hdmi->phy, &link_rate);
> +	if (ret)
> +		dev_err(hdmi->dev, "Setting clock=%u failed: %d\n",
> +			mode->pixelclock.typ, ret);

Should propagate error or add comment to explain why it is safe to ignore.

> +
> +	mtk_hdmi_change_video_resolution(hdmi);
> +}
> +

...

> +static int mtk_hdmi_setup_avi_infoframe(struct mtk_hdmi *hdmi, u8 *buffer,
> +					size_t bufsz,
> +					struct display_timing *mode)
> +{
> +	u8 checksum;
> +	int i;
> +
> +	if (bufsz < HDMI_AVI_INFOFRAME_SIZE)
> +		return -EINVAL;
> +
> +	memset(buffer, 0, HDMI_AVI_INFOFRAME_SIZE);
> +
> +	/* AVI InfoFrame header */
> +	buffer[0] = 0x82;  /* AVI InfoFrame type */
> +	buffer[1] = 0x02;  /* Version */
> +	buffer[2] = 0x0D;  /* Length (13 bytes) */
> +
> +	/* Data byte 1: Scan info, bar info, active format info, RGB/YCC */
> +	switch (hdmi->csp) {
> +	case HDMI_COLORSPACE_YUV422:
> +		buffer[4] = 0x20;
> +		break;
> +	case HDMI_COLORSPACE_YUV444:
> +		buffer[4] = 0x40;
> +		break;
> +	case HDMI_COLORSPACE_YUV420:
> +		buffer[4] = 0x60;
> +		break;
> +	default:
> +		buffer[4] = 0x00;
> +		break;
> +	}
> +
> +	/* Data byte 4: Video Identification Code (VIC) */
> +	if (mode->hactive.typ == 1920 && mode->vactive.typ == 1080)
> +		buffer[7] = 16;  /* 1920x1080@60Hz */
> +	else if (mode->hactive.typ == 1280 && mode->vactive.typ == 720)
> +		buffer[7] = 4;   /* 1280x720@60Hz */
> +	else if (mode->hactive.typ == 720 && mode->vactive.typ == 480)
> +		buffer[7] = 2;   /* 720x480@60Hz */
> +	else
> +		buffer[7] = 0;   /* Unknown/unsupported timing */

Should we also be validating the refresh rate here instead of assuming 60Hz?

> +
> +	/*
> +	 * Data byte 2: picture aspect ratio, active portion same as
> +	 * picture. VIC 2 is a 4:3 mode, the others are 16:9.
> +	 */
> +	buffer[5] = buffer[7] == 2 ? 0x18 : 0x28;
> +
> +	/* Data byte 3: Colorimetry, picture scaling */
> +	switch (hdmi->colorimetry) {
> +	case HDMI_COLORIMETRY_ITU_709:
> +		buffer[6] = 0x80;
> +		break;
> +	case HDMI_COLORIMETRY_ITU_601:
> +		buffer[6] = 0x40;
> +		break;
> +	default:
> +		buffer[6] = 0x00;
> +		break;
> +	}
> +
> +	/* Data byte 5: Pixel repetition */
> +	buffer[8] = 0x00;  /* No pixel repetition */
> +
> +	/* checksum over the full frame, so that the total sums to zero */
> +	for (checksum = 0, i = 0; i < HDMI_AVI_INFOFRAME_SIZE; i++)
> +		checksum += buffer[i];
> +	buffer[3] = 0x100 - checksum;
> +
> +	return 0;
> +}
> +
> +static void mtk_hdmi_hw_avi_infoframe(struct mtk_hdmi *hdmi, u8 *buf, u8 len)
> +{

len is unused.

> +	/* Disable AVI InfoFrame first */
> +	mtk_hdmi_update(hdmi, TOP_INFO_EN, AVI_DIS_WR | AVI_DIS,
> +			AVI_EN_WR | AVI_EN);
> +	mtk_hdmi_update(hdmi, TOP_INFO_RPT, AVI_RPT_DIS, AVI_RPT_EN);
> +
> +	/* Write AVI InfoFrame header */
> +	mtk_hdmi_write(hdmi, TOP_AVI_HEADER, get_unaligned_le24(&buf[0]));
> +
> +	/* Write AVI InfoFrame data packets */
> +	mtk_hdmi_write(hdmi, TOP_AVI_PKT00, get_unaligned_le32(&buf[3]));
> +	mtk_hdmi_write(hdmi, TOP_AVI_PKT01, get_unaligned_le24(&buf[7]));
> +	mtk_hdmi_write(hdmi, TOP_AVI_PKT02, get_unaligned_le32(&buf[10]));
> +	mtk_hdmi_write(hdmi, TOP_AVI_PKT03, get_unaligned_le24(&buf[14]));
> +
> +	/* Clear remaining packets */
> +	mtk_hdmi_write(hdmi, TOP_AVI_PKT04, 0);
> +	mtk_hdmi_write(hdmi, TOP_AVI_PKT05, 0);
> +
> +	/* Enable AVI InfoFrame */
> +	mtk_hdmi_update(hdmi, TOP_INFO_RPT, AVI_RPT_EN, AVI_RPT_EN);
> +	mtk_hdmi_update(hdmi, TOP_INFO_EN, AVI_EN_WR | AVI_EN,
> +			AVI_EN_WR | AVI_EN);
> +}
> +
> +static void mtk_hdmi_hw_spd_infoframe(struct mtk_hdmi *hdmi, u8 *buf, u8 len)
> +{

ditto

> +	/* Disable SPD InfoFrame first */
> +	mtk_hdmi_update(hdmi, TOP_INFO_EN, SPD_DIS_WR | SPD_DIS,
> +			SPD_EN_WR | SPD_EN);
> +	mtk_hdmi_update(hdmi, TOP_INFO_RPT, SPD_RPT_DIS, SPD_RPT_EN);
> +
> +	/* Write SPD InfoFrame header */
> +	mtk_hdmi_write(hdmi, TOP_SPDIF_HEADER, get_unaligned_le24(&buf[0]));
> +
> +	/* Write SPD InfoFrame data packets */
> +	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT00, get_unaligned_le32(&buf[3]));
> +	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT01, get_unaligned_le24(&buf[7]));
> +	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT02, get_unaligned_le32(&buf[10]));
> +	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT03, get_unaligned_le24(&buf[14]));
> +	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT04, get_unaligned_le32(&buf[17]));
> +	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT05, get_unaligned_le24(&buf[21]));
> +	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT06, get_unaligned_le32(&buf[24]));
> +	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT07, buf[28]);
> +
> +	/* Enable SPD InfoFrame */
> +	mtk_hdmi_update(hdmi, TOP_INFO_RPT, SPD_RPT_EN, SPD_RPT_EN);
> +	mtk_hdmi_update(hdmi, TOP_INFO_EN, SPD_EN_WR | SPD_EN,
> +			SPD_EN_WR | SPD_EN);
> +}
> +

...

> +static int mtk_hdmi_read_edid(struct mtk_hdmi *hdmi, u8 *buf, int buf_size)
> +{
> +	struct udevice *chip;
> +	int ret;
> +
> +	if (!hdmi->ddc_bus || buf_size < EDID_SIZE)
> +		return -EINVAL;
> +
> +	ret = i2c_get_chip(hdmi->ddc_bus, EDID_ADDR, 1, &chip);
> +	if (ret)
> +		return ret;
> +
> +	ret = dm_i2c_read(chip, 0, buf, EDID_SIZE);
> +	if (ret) {
> +		dev_err(hdmi->dev, "failed to read EDID: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* read the extension block, if any */
> +	if (buf[0x7e] != 0 && buf_size >= EDID_EXT_SIZE) {

0x7e should probably be a offsetof() or cast to struct edid1_info * and use
the actual field.

> +		ret = dm_i2c_read(chip, EDID_SIZE, buf + EDID_SIZE,
> +				  buf_size - EDID_SIZE);
> +		if (ret)
> +			dev_warn(hdmi->dev,
> +				 "error reading extended EDID block\n");
> +	}
> +
> +	return 0;
> +}
> +

...

> +static int mtk_hdmi_get_comp_by_alias(struct udevice *dev, const char *alias,
> +				      struct udevice **compp)
> +{
> +	struct udevice *comp;
> +	ofnode node;
> +	int ret;
> +
> +	node = ofnode_get_aliases_node(alias);
> +	if (!ofnode_valid(node)) {
> +		dev_err(dev, "cannot find alias %s\n", alias);
> +		return -ENODEV;
> +	}
> +
> +	ret = uclass_get_device_by_ofnode(UCLASS_MISC, node, &comp);
> +	if (ret) {
> +		dev_err(dev, "cannot get %s: %d\n", alias, ret);
> +		return ret;
> +	}
> +
> +	ret = mtk_disp_comp_enable(comp);
> +	if (ret)
> +		return ret;
> +
> +	/* only publish the handle once its clocks are on, so the error */
> +	/* unwind can rely on a non-NULL pointer meaning "enabled" */

nit: change to single comment

> +	*compp = comp;
> +
> +	return 0;
> +}
> +
