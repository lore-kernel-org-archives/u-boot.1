Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DB2C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 562B6406FD;
	Wed, 26 Aug 2026 13:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z5WBO28dIxlx; Wed, 26 Aug 2026 13:09:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749798;
	bh=JvVe42Qmc4JcxuzX9V5/QUYstBtJWk+T8bo+J92YP6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aMory6ioJ3q2/8Ivscr5ohwJ+eu025dtuRKZYaH13S+WQ3+n8kmhSbTjyxW8TBrL3
	 yX+3+ICGIW8lkk24VSJsJjpTPSiruMbV1PA9YrqE6vKeYnDz64M/nmg5cJwk8jGH4t
	 tORZFk5CT0qOKCUDR8pLhwGVb4vLYD6sKMYMJlpzOM8bX8J5HpxL49bdoqwrgeUxJV
	 mOXUzTqQZkpZnXOVtFkMjgcEup2cPcWt/fU8ZLiklTqbj7RY2EvpfmjkNZD7ak8HLJ
	 TeBed1UzlACAz4Q9fkaJsBPnOAgjhGd/Z7YzGzr8YfSh4S3Y/0U5vlVMVLKlwM5s2W
	 9tkNUv37QPTHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45594406D1;
	Wed, 26 Aug 2026 13:09:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C2697396
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA6ED6075E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t7F6tKoUVHiw for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ex9YCY2j
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC31F60771
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:46 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso382295f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749785; x=1788354585;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JvVe42Qmc4JcxuzX9V5/QUYstBtJWk+T8bo+J92YP6I=;
 b=ex9YCY2j7gH1iyu5ASWEOJM+7Y7fUJDs2QhXpk4DngRL7oGpA1/OmYdlGT921KZyue
 qISHL91jJiMhOQXvpkceRfWoQxdEzs7K5CL2KKzijwCS0gm/AHE+GsoKH7DOOa+dYBZU
 kIk6uw7V7wsuyg5RklGOHifjrJf34uOOzp5DqncUSl/ZUXhzgWRIIgY26SrQIq8hy0Au
 bKpUf4sZW1iw/OIGGEu+/DhzS7dXdRxMHN1bnkqp7MSfacX6M3K+y0rIMQB4PTT/3cpS
 eqycOaw/KYHZGwMpe0O7aBvkYCpsoWJuUfVPmW3zkqx3QbqHY+2iu8ORoGLfXXJAv449
 kBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749785; x=1788354585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JvVe42Qmc4JcxuzX9V5/QUYstBtJWk+T8bo+J92YP6I=;
 b=onlKtvToiPIxdjaLWCQOkbNpYe9qYngvgn8osfJIQ1/zeQNINjQXingPHxtNz8CTDp
 Htk39nYvL3RwogPWBs+XAjYQf6yVVrHx7vCAPx1B0qQyUWh9pflrtfxfFuBtWERDzumc
 sD27QP2//tyyfl7wvtxEVwYAOe5wAwzCwMfECmUtt3te2Or5AoJGKsWYU7VFFNeN1lLv
 IyI44ydZfvDW5Ae8bThn5FNJ1jPL4mgREc8ajM90hwCU20w3eH3AXJn5Fr/WmBBQgmzD
 /iruDirAQPV4RHkcS0Uq7Dsn/Zxo0pRqkjpuKHx0QYY3sKqsKS+tmM+XbiE4Kc9JUFwy
 7JaA==
X-Gm-Message-State: AFuF++mgEIWiKZ+Tm6OaRUDLG8wSecBrTWTeQPgngk+HU0/lnFOcjMCl
 yEWZpjyetY8z5mh0xZAZiEB6LuXh6vjAOhS3t1EZY9+hHQQHyqhR8n7yl1701fcyd6Q=
X-Gm-Gg: AR+sD136wCrv76vrgFqGjg8Q+58VfBQGNriYrnOSC9LGuDAG2FvGyo2vJOKh1lp1C+6
 UCGJPQMUErfU8mEEPJO+HaNv8c1bFs/1boZl7kW1Ee7uU2cJYU5TWJACRv+ceyPKtzDdITZrUuI
 gtDKSsndSMvMGtkx2qokbSjW2aVwHmSuU19d+vTBG+LGh1nElrt4k0xOBu5OD3JBgn3g+H7RI1Y
 9gbUBcDrwTzbUP0qKoll0zku4/nxaYdP2IY/sgToWQoLKcUXHu16GHaZvZK6gAi5ZxWduvouGwf
 sWT9WcWFKn3bRDX3x3jjlpz+ofDsB7tEEwEAkMAldOZL2qbkX0D8O7xjv28lQq/PZExkI1VAQau
 4ZDtBlo/II/VO24/YL6G/AqIel/hMwF1dHpmpicMg5InD86Wv34KWOvd5pHlvhuhDOS5Pz8Uh97
 EEilPgqq23DAQQit5yGdWcuWLFW5i0ZGKhxyc7WuNBPEktJxFCBvsvsBhus7iv1P7kD6X77vQ41
 8+0VmBduE1TcO0Opm0vBjlaD9jIGJjhXYwynWuJVi3DvJKy+s2x28zXCAUNFhKytroi4Vff+hpq
 BA9h56+kERW7VZrv/5s2Er7F0w+rQfH6lLj/8wlmwDtNCw==
X-Received: by 2002:a05:6000:653:b0:47f:e886:6dff with SMTP id
 ffacd0b85a97d-482e269d209mr6916419f8f.4.1787749784482; 
 Wed, 26 Aug 2026 06:09:44 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:43 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:38 +0200
Subject: [PATCH v2 11/14] video: mediatek: add new hdmi driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-11-68ebb1bf17df@baylibre.com>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.15.2
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

Add a UCLASS_VIDEO driver for the HDMI TX v2 IP found on the MT8188.

On probe, the driver waits for a plugged and powered display, reads
its EDID through the DDC bus to select the preferred mode, configures
the HDMI controller and PHY accordingly, and then programs all the
components of the vdosys1 pipeline (MDP RDMA, padding, VPP merge,
ETHDR mixer, mutex, DPI1) to scan out the framebuffer. The
framebuffer lives in a dedicated reserved-memory region referenced by
the "memory-region" property of the hdmi node.

Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/Kconfig             |    1 +
 drivers/video/Makefile            |    1 +
 drivers/video/mediatek/Kconfig    |   21 +
 drivers/video/mediatek/Makefile   |   16 +
 drivers/video/mediatek/mtk_hdmi.c | 1102 +++++++++++++++++++++++++++++++++++++
 5 files changed, 1141 insertions(+)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 15000e21840..cb3ba6a6f63 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -770,6 +770,7 @@ config VIDEO_LCD_SPI_MISO
 	  option takes a string in the format understood by 'sunxi_name_to_gpio'
 	  function, e.g. PH1 for pin 1 of port H.
 
+source "drivers/video/mediatek/Kconfig"
 source "drivers/video/meson/Kconfig"
 
 config VIDEO_MVEBU
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 082b8967982..a20011b9b17 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -92,5 +92,6 @@ obj-$(CONFIG_VIDEO_SEPS525) += seps525.o
 obj-$(CONFIG_VIDEO_ZYNQMP_DPSUB) += zynqmp/
 
 obj-y += bridge/
+obj-y += mediatek/
 obj-y += sunxi/
 obj-y += tegra/
diff --git a/drivers/video/mediatek/Kconfig b/drivers/video/mediatek/Kconfig
new file mode 100644
index 00000000000..54cf1b11fdf
--- /dev/null
+++ b/drivers/video/mediatek/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 BayLibre, SAS
+#
+# Author: Julien Stephan <jstephan@baylibre.com>
+
+config VIDEO_MEDIATEK_HDMI
+	bool "Video HDMI Support for Mediatek SoCs"
+	depends on VIDEO && ARCH_MEDIATEK
+	depends on DM_I2C && PHY && POWER_DOMAIN
+	select I2C_EDID
+	select MISC
+	select PHY_MTK_HDMI
+	select MTK_POWER_DOMAIN
+	select SYS_I2C_DDC_MTK
+	help
+	  Enable support for the HDMI TX output found on recent MediaTek
+	  SoCs such as the MT8188. The driver reads the EDID of the
+	  connected display, selects its preferred mode and drives the
+	  vdosys1 display pipeline (MDP RDMA, padding, merge, ETHDR
+	  mixer, DPI) to scan out the U-Boot framebuffer over HDMI.
diff --git a/drivers/video/mediatek/Makefile b/drivers/video/mediatek/Makefile
new file mode 100644
index 00000000000..70da9d9662a
--- /dev/null
+++ b/drivers/video/mediatek/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2026 MediaTek Inc.
+#
+# Author: Julien Stephan <jstephan@baylibre.com>
+
+obj-$(CONFIG_VIDEO_MEDIATEK_HDMI) += \
+	mtk_hdmi.o \
+	mtk_disp_comp.o \
+	mtk_dpi.o \
+	mtk_mdp_rdma.o \
+	mtk_disp_merge.o \
+	mtk_ethdr.o \
+	mtk_disp_mutex.o \
+	mtk_disp_padding.o \
+	mtk_smi_larb.o
diff --git a/drivers/video/mediatek/mtk_hdmi.c b/drivers/video/mediatek/mtk_hdmi.c
new file mode 100644
index 00000000000..a37fe44b295
--- /dev/null
+++ b/drivers/video/mediatek/mtk_hdmi.c
@@ -0,0 +1,1102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 BayLibre, SAS
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/unaligned.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <edid.h>
+#include <errno.h>
+#include <generic-phy.h>
+#include <i2c.h>
+#include <linux/delay.h>
+#include <linux/hdmi.h>
+#include <video.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_merge.h"
+#include "mtk_ethdr.h"
+#include "mtk_disp_mutex.h"
+#include "mtk_disp_padding.h"
+#include "mtk_dpi.h"
+#include "mtk_mdp_rdma.h"
+
+/* HDMI TX register definitions */
+#define AVI_DIS					(0)
+#define AVI_DIS_WR				(0)
+#define AVI_EN					(0x1)
+#define AVI_EN_WR				BIT(16)
+#define AVI_RPT_DIS				(0x0)
+#define AVI_RPT_EN				(0x1)
+
+#define C422_C420_CONFIG_BYPASS			BIT(5)
+#define C422_C420_CONFIG_ENABLE			BIT(4)
+#define C422_C420_CONFIG_OUT_CB_OR_CR		BIT(6)
+#define C444_C422_CONFIG_ENABLE			(0x1)
+
+#define DEEPCOLOR_MODE_10BIT			BIT(8)
+#define DEEPCOLOR_MODE_12BIT			GENMASK(9, 8)
+#define DEEPCOLOR_MODE_16BIT			GENMASK(10, 8)
+#define DEEPCOLOR_MODE_8BIT			(0)
+#define DEEPCOLOR_MODE_MASKBIT			GENMASK(10, 8)
+#define DEEPCOLOR_PAT_EN			BIT(12)
+#define DEEP_COLOR_ADD				BIT(4)
+
+#define HDMI2_OFF				(0)
+#define HDMI2_ON				BIT(2)
+
+#define HDMITX_SW_HPD				BIT(29)
+#define HDMITX_SW_RSTB				BIT(31)
+
+#define HDMI_MODE_DVI				(0)
+#define HDMI_MODE_HDMI				BIT(3)
+
+#define HDMI_YUV420_MODE			BIT(10)
+
+#define HPD_DDC_STATUS				0xC60
+#define PORD_PIN_STA				BIT(5)
+#define HPD_PIN_STA				BIT(4)
+
+#define NULL_PKT_EN				BIT(2)
+#define NULL_PKT_VSYNC_HIGH_EN			BIT(3)
+
+#define OUTPUT_FORMAT_DEMUX_420_ENABLE		BIT(10)
+
+#define REG_VMUTE_EN				BIT(16)
+
+#define SCR_OFF					0
+#define SCR_ON					BIT(4)
+
+#define SPD_DIS					0
+#define SPD_DIS_WR				0
+#define SPD_EN					BIT(1)
+#define SPD_EN_WR				BIT(17)
+#define SPD_RPT_DIS				0
+#define SPD_RPT_EN				BIT(1)
+
+#define TOP_CFG00				0x000
+#define TOP_CFG01				0x004
+#define TOP_INFO_EN				0x01C
+#define TOP_INFO_RPT				0x020
+#define TOP_AVI_HEADER				0x024
+#define TOP_AVI_PKT00				0x028
+#define TOP_AVI_PKT01				0x02C
+#define TOP_AVI_PKT02				0x030
+#define TOP_AVI_PKT03				0x034
+#define TOP_AVI_PKT04				0x038
+#define TOP_AVI_PKT05				0x03C
+#define TOP_INT_MASK00				0x1B0
+#define TOP_INT_MASK01				0x1B4
+#define TOP_MISC_CTLR				0x1A4
+#define TOP_SPDIF_HEADER			0x054
+#define TOP_SPDIF_PKT00				0x058
+#define TOP_SPDIF_PKT01				0x05C
+#define TOP_SPDIF_PKT02				0x060
+#define TOP_SPDIF_PKT03				0x064
+#define TOP_SPDIF_PKT04				0x068
+#define TOP_SPDIF_PKT05				0x06C
+#define TOP_SPDIF_PKT06				0x070
+#define TOP_SPDIF_PKT07				0x074
+#define TOP_VMUTE_CFG1				0x1C8
+
+#define VID_DOWNSAMPLE_CONFIG			0x8F0
+#define VID_OUT_FORMAT				0x8FC
+
+#define ABIST_ENABLE				BIT(31)
+
+#define HDCP_TOP_CTRL				0xC00
+#define HDMI_CONFIG				0xEA0
+
+/* VDOSYS1 display routing (SEL_IN / SOUT mux) registers */
+#define SUBDISP_DISP_DPI1_SEL_IN		0xF10
+#define SUBDISP_DISP_MERGE4_MOUT_SEL		0xF18
+#define SUBDISP_MIXER_IN3_SEL_IN		0xF2C
+#define SUBDISP_MIXER_OUT_SOUT_SEL		0xF34
+#define SUBDISP_MERGE2_ASYNC_SOUT_SEL		0xF48
+#define SUBDISP_MERGE4_ASYNC_SEL_IN		0xF50
+#define SUBDISP_MIXER_IN3_SOUT_SEL		0xF60
+#define SUBDISP_MIXER_SOUT_SEL_IN		0xF68
+
+#define OUTPUT_TO_MIXER_IN3_SEL			0x1
+#define INPUT_FROM_MERGE2_ASYNC_SOUT		0x1
+#define OUTPUT_TO_DISP_MIXER			0x0
+#define INPUT_FROM_DISP_MIXER			0x0
+#define OUTPUT_TO_HDR_VDO_BE0			0x0
+#define INPUT_FROM_HDR_VDO_BE0			0x0
+#define OUTPUT_TO_DPI1_SEL			0x4
+#define INPUT_FROM_VPP_MERGE4_MOUT		0x0
+
+#define MTK_HDMI_MAX_WIDTH			3840
+#define MTK_HDMI_MAX_HEIGHT			2160
+
+#define MTK_HDMI_HPD_TIMEOUT_MS			100
+
+/* 4 byte header + 13 byte payload */
+#define HDMI_AVI_INFOFRAME_SIZE			17
+/* 4 byte header + 25 byte payload */
+#define HDMI_SPD_INFOFRAME_SIZE			29
+
+/*
+ * HDMI 2.0 requires TMDS clock scrambling and a 1/40 bit clock ratio for
+ * TMDS character rates above 340 MHz.
+ */
+#define HDMI_TMDS_CLOCK_SCRAMBLE_HZ		340000000
+
+#define RGB444_8bit				BIT(0)
+#define RGB444_10bit				BIT(1)
+#define RGB444_12bit				BIT(2)
+#define RGB444_16bit				BIT(3)
+#define YCBCR444_8bit				BIT(4)
+#define YCBCR444_10bit				BIT(5)
+#define YCBCR444_12bit				BIT(6)
+#define YCBCR444_16bit				BIT(7)
+
+#define YCBCR422_8bit_NO_SUPPORT		BIT(8)
+#define YCBCR422_10bit_NO_SUPPORT		BIT(9)
+#define YCBCR422_12bit				BIT(10)
+#define YCBCR422_16bit_NO_SUPPORT		BIT(11)
+
+#define YCBCR420_8bit				BIT(12)
+#define YCBCR420_10bit				BIT(13)
+#define YCBCR420_12bit				BIT(14)
+#define YCBCR420_16bit				BIT(15)
+
+enum hdmi_color_depth {
+	HDMI_8_BIT,
+	HDMI_10_BIT,
+	HDMI_12_BIT,
+	HDMI_16_BIT,
+};
+
+struct mtk_hdmi {
+	struct udevice *dev;
+	struct udevice *ddc_bus;
+	struct udevice *dpi1;
+	struct udevice *merge3;
+	struct udevice *merge5;
+	struct udevice *ethdr;
+	struct udevice *mutex;
+	struct udevice *padding4;
+	struct udevice *padding5;
+	struct udevice *rdma4;
+	struct udevice *rdma5;
+	struct udevice *larb2;
+	struct udevice *larb3;
+	struct phy phy;
+	fdt_addr_t regs;
+	struct clk_bulk clk_bulk;
+	u64 support_csp_depth;
+	u64 set_csp_depth;
+	enum hdmi_colorspace csp;
+	enum hdmi_color_depth color_depth;
+	enum hdmi_colorimetry colorimetry;
+	struct display_timing mode;
+};
+
+enum hdmi_hpd_state {
+	HDMI_PLUG_OUT = 0,
+	HDMI_PLUG_IN_AND_SINK_POWER_ON,
+	HDMI_PLUG_IN_ONLY,
+};
+
+static u32 mtk_hdmi_read(struct mtk_hdmi *hdmi, u32 offset)
+{
+	return readl(hdmi->regs + offset);
+}
+
+static void mtk_hdmi_write(struct mtk_hdmi *hdmi, u32 offset, u32 val)
+{
+	writel(val, hdmi->regs + offset);
+}
+
+static void mtk_hdmi_update(struct mtk_hdmi *hdmi, u32 offset, u32 val, u32 mask)
+{
+	fdt_addr_t reg = hdmi->regs + offset;
+	u32 tmp;
+
+	tmp = readl(reg);
+	tmp = (tmp & ~mask) | (val & mask);
+	writel(tmp, reg);
+}
+
+static void mtk_hdmi_enable_hdmi_mode(struct mtk_hdmi *hdmi, bool enable)
+{
+	u32 value = enable ? HDMI_MODE_HDMI : HDMI_MODE_DVI;
+
+	mtk_hdmi_update(hdmi, TOP_CFG00, value, HDMI_MODE_HDMI);
+}
+
+static void mtk_hdmi_hw_vid_black(struct mtk_hdmi *hdmi, bool black)
+{
+	if (black)
+		mtk_hdmi_update(hdmi, TOP_VMUTE_CFG1, REG_VMUTE_EN, REG_VMUTE_EN);
+	else
+		mtk_hdmi_update(hdmi, TOP_VMUTE_CFG1, 0, REG_VMUTE_EN);
+}
+
+static void mtk_hdmi_hw_reset(struct mtk_hdmi *hdmi)
+{
+	mtk_hdmi_update(hdmi, HDMI_CONFIG, 0, HDMITX_SW_RSTB);
+	udelay(5);
+	mtk_hdmi_update(hdmi, HDMI_CONFIG, HDMITX_SW_RSTB, HDMITX_SW_RSTB);
+}
+
+static inline void mtk_hdmi_set_sw_hpd(struct mtk_hdmi *hdmi, bool high)
+{
+	u32 value = high ? HDMITX_SW_HPD : 0;
+
+	mtk_hdmi_update(hdmi, HDMI_CONFIG, value, HDMITX_SW_HPD);
+}
+
+static void mtk_hdmi_set_deep_color(struct mtk_hdmi *hdmi, bool is_hdmi_sink)
+{
+	unsigned int deep_color;
+
+	/* ycbcr422 12bit has no deep color */
+	if (hdmi->csp == HDMI_COLORSPACE_YUV422) {
+		deep_color = DEEPCOLOR_MODE_8BIT;
+	} else {
+		switch (hdmi->color_depth) {
+		case HDMI_10_BIT:
+			deep_color = DEEPCOLOR_MODE_10BIT;
+			break;
+		case HDMI_12_BIT:
+			deep_color = DEEPCOLOR_MODE_12BIT;
+			break;
+		case HDMI_16_BIT:
+			deep_color = DEEPCOLOR_MODE_16BIT;
+			break;
+		case HDMI_8_BIT:
+		default:
+			deep_color = DEEPCOLOR_MODE_8BIT;
+			break;
+		}
+	}
+
+	mtk_hdmi_update(hdmi, TOP_CFG00, deep_color, DEEPCOLOR_MODE_MASKBIT);
+
+	/* GCP */
+	mtk_hdmi_update(hdmi, TOP_CFG00, 0, DEEPCOLOR_PAT_EN);
+	if (is_hdmi_sink && deep_color != DEEPCOLOR_MODE_8BIT)
+		mtk_hdmi_update(hdmi, TOP_MISC_CTLR, DEEP_COLOR_ADD,
+				DEEP_COLOR_ADD);
+	else
+		mtk_hdmi_update(hdmi, TOP_MISC_CTLR, 0, DEEP_COLOR_ADD);
+}
+
+static void mtk_hdmi_yuv420_downsample_enable(struct mtk_hdmi *hdmi)
+{
+	mtk_hdmi_update(hdmi, HDMI_CONFIG, HDMI_YUV420_MODE | HDMITX_SW_HPD,
+			HDMI_YUV420_MODE | HDMITX_SW_HPD);
+	mtk_hdmi_update(hdmi, VID_DOWNSAMPLE_CONFIG, C444_C422_CONFIG_ENABLE,
+			C444_C422_CONFIG_ENABLE);
+	mtk_hdmi_update(hdmi, VID_DOWNSAMPLE_CONFIG, C422_C420_CONFIG_ENABLE,
+			C422_C420_CONFIG_ENABLE);
+	mtk_hdmi_update(hdmi, VID_DOWNSAMPLE_CONFIG, 0, C422_C420_CONFIG_BYPASS);
+	mtk_hdmi_update(hdmi, VID_DOWNSAMPLE_CONFIG,
+			C422_C420_CONFIG_OUT_CB_OR_CR,
+			C422_C420_CONFIG_OUT_CB_OR_CR);
+	mtk_hdmi_update(hdmi, VID_OUT_FORMAT, OUTPUT_FORMAT_DEMUX_420_ENABLE,
+			OUTPUT_FORMAT_DEMUX_420_ENABLE);
+}
+
+static void mtk_hdmi_yuv420_downsample_disable(struct mtk_hdmi *hdmi)
+{
+	mtk_hdmi_update(hdmi, HDMI_CONFIG, HDMITX_SW_HPD,
+			HDMI_YUV420_MODE | HDMITX_SW_HPD);
+	mtk_hdmi_update(hdmi, VID_DOWNSAMPLE_CONFIG, 0, C444_C422_CONFIG_ENABLE);
+	mtk_hdmi_update(hdmi, VID_DOWNSAMPLE_CONFIG, 0, C422_C420_CONFIG_ENABLE);
+	mtk_hdmi_update(hdmi, VID_DOWNSAMPLE_CONFIG, C422_C420_CONFIG_BYPASS,
+			C422_C420_CONFIG_BYPASS);
+	mtk_hdmi_update(hdmi, VID_DOWNSAMPLE_CONFIG, 0,
+			C422_C420_CONFIG_OUT_CB_OR_CR);
+	mtk_hdmi_update(hdmi, VID_OUT_FORMAT, 0, OUTPUT_FORMAT_DEMUX_420_ENABLE);
+}
+
+static bool mtk_hdmi_tmds_over_340M(struct mtk_hdmi *hdmi)
+{
+	unsigned long pixel_clk, tmds_clk;
+
+	pixel_clk = hdmi->mode.pixelclock.typ;
+
+	switch (hdmi->color_depth) {
+	case HDMI_8_BIT:
+		tmds_clk = pixel_clk;
+		break;
+	case HDMI_10_BIT:
+		tmds_clk = pixel_clk * 5 / 4;
+		break;
+	case HDMI_12_BIT:
+		tmds_clk = pixel_clk * 3 / 2;
+		break;
+	case HDMI_16_BIT:
+		tmds_clk = pixel_clk * 2;
+		break;
+	default:
+		dev_warn(hdmi->dev, "Unsupported color depth %d\n",
+			 hdmi->color_depth);
+		return false;
+	}
+
+	return tmds_clk >= HDMI_TMDS_CLOCK_SCRAMBLE_HZ &&
+	       hdmi->csp != HDMI_COLORSPACE_YUV420;
+}
+
+static inline void mtk_hdmi_enable_scrambling(struct mtk_hdmi *hdmi,
+					      bool enable)
+{
+	udelay(150);
+
+	if (enable)
+		mtk_hdmi_update(hdmi, TOP_CFG00, SCR_ON | HDMI2_ON,
+				SCR_ON | HDMI2_ON);
+	else
+		mtk_hdmi_update(hdmi, TOP_CFG00, SCR_OFF | HDMI2_OFF,
+				SCR_ON | HDMI2_ON);
+}
+
+static void mtk_hdmi_disable_abist(struct mtk_hdmi *hdmi)
+{
+	mtk_hdmi_update(hdmi, TOP_CFG00, 0, ABIST_ENABLE);
+}
+
+static void mtk_hdmi_change_video_resolution(struct mtk_hdmi *hdmi)
+{
+	const bool is_hdmi_sink = true;
+	bool is_over_340M;
+
+	mtk_hdmi_hw_reset(hdmi);
+	mtk_hdmi_set_sw_hpd(hdmi, true);
+	udelay(5);
+
+	mtk_hdmi_write(hdmi, HDCP_TOP_CTRL, 0x0);
+
+	mtk_hdmi_set_deep_color(hdmi, is_hdmi_sink);
+	mtk_hdmi_enable_hdmi_mode(hdmi, is_hdmi_sink);
+
+	udelay(10);
+	mtk_hdmi_hw_vid_black(hdmi, true);
+
+	mtk_hdmi_update(hdmi, TOP_CFG01, NULL_PKT_VSYNC_HIGH_EN,
+			NULL_PKT_VSYNC_HIGH_EN | NULL_PKT_EN);
+
+	is_over_340M = mtk_hdmi_tmds_over_340M(hdmi);
+	dev_dbg(hdmi->dev, "is_over_340M: %d\n", is_over_340M);
+
+	mtk_hdmi_enable_scrambling(hdmi, is_over_340M);
+
+	if (hdmi->csp == HDMI_COLORSPACE_YUV420)
+		mtk_hdmi_yuv420_downsample_enable(hdmi);
+	else
+		mtk_hdmi_yuv420_downsample_disable(hdmi);
+}
+
+static void mtk_hdmi_output_set_display_mode(struct mtk_hdmi *hdmi,
+					     struct display_timing *mode)
+{
+	unsigned long link_rate = mode->pixelclock.typ;
+	int ret;
+
+	ret = generic_phy_configure(&hdmi->phy, &link_rate);
+	if (ret)
+		dev_err(hdmi->dev, "Setting clock=%u failed: %d\n",
+			mode->pixelclock.typ, ret);
+
+	mtk_hdmi_change_video_resolution(hdmi);
+}
+
+static void mtk_hdmi_convert_colorspace_depth(struct mtk_hdmi *hdmi)
+{
+	switch (hdmi->set_csp_depth) {
+	case RGB444_8bit:
+		hdmi->csp = HDMI_COLORSPACE_RGB;
+		hdmi->color_depth = HDMI_8_BIT;
+		break;
+	case RGB444_10bit:
+		hdmi->csp = HDMI_COLORSPACE_RGB;
+		hdmi->color_depth = HDMI_10_BIT;
+		break;
+	case RGB444_12bit:
+		hdmi->csp = HDMI_COLORSPACE_RGB;
+		hdmi->color_depth = HDMI_12_BIT;
+		break;
+	case RGB444_16bit:
+		hdmi->csp = HDMI_COLORSPACE_RGB;
+		hdmi->color_depth = HDMI_16_BIT;
+		break;
+	case YCBCR444_8bit:
+		hdmi->csp = HDMI_COLORSPACE_YUV444;
+		hdmi->color_depth = HDMI_8_BIT;
+		break;
+	case YCBCR444_10bit:
+		hdmi->csp = HDMI_COLORSPACE_YUV444;
+		hdmi->color_depth = HDMI_10_BIT;
+		break;
+	case YCBCR444_12bit:
+		hdmi->csp = HDMI_COLORSPACE_YUV444;
+		hdmi->color_depth = HDMI_12_BIT;
+		break;
+	case YCBCR444_16bit:
+		hdmi->csp = HDMI_COLORSPACE_YUV444;
+		hdmi->color_depth = HDMI_16_BIT;
+		break;
+	case YCBCR422_12bit:
+		hdmi->csp = HDMI_COLORSPACE_YUV422;
+		hdmi->color_depth = HDMI_12_BIT;
+		break;
+	case YCBCR420_8bit:
+		hdmi->csp = HDMI_COLORSPACE_YUV420;
+		hdmi->color_depth = HDMI_8_BIT;
+		break;
+	case YCBCR420_10bit:
+		hdmi->csp = HDMI_COLORSPACE_YUV420;
+		hdmi->color_depth = HDMI_10_BIT;
+		break;
+	case YCBCR420_12bit:
+		hdmi->csp = HDMI_COLORSPACE_YUV420;
+		hdmi->color_depth = HDMI_12_BIT;
+		break;
+	case YCBCR420_16bit:
+		hdmi->csp = HDMI_COLORSPACE_YUV420;
+		hdmi->color_depth = HDMI_16_BIT;
+		break;
+	default:
+		hdmi->csp = HDMI_COLORSPACE_RGB;
+		hdmi->color_depth = HDMI_8_BIT;
+	}
+
+	dev_dbg(hdmi->dev, "color space: %d, color depth: %d\n",
+		hdmi->csp, hdmi->color_depth);
+}
+
+/*
+ * Copy at most @dst_len bytes of @src into @dst and pad the remainder with
+ * spaces. Unlike strlcpy() this does not NUL-terminate, so the full field
+ * width can be used for the string.
+ */
+static void mtk_hdmi_pad_string(u8 *dst, size_t dst_len, const char *src)
+{
+	size_t src_len = strlen(src);
+
+	if (src_len > dst_len)
+		src_len = dst_len;
+
+	memcpy(dst, src, src_len);
+	memset(dst + src_len, ' ', dst_len - src_len);
+}
+
+static int mtk_hdmi_setup_spd_infoframe(struct mtk_hdmi *hdmi, u8 *buffer,
+					size_t bufsz, const char *vendor,
+					const char *product)
+{
+	u8 checksum;
+	int i;
+
+	if (bufsz < HDMI_SPD_INFOFRAME_SIZE)
+		return -EINVAL;
+
+	memset(buffer, 0, HDMI_SPD_INFOFRAME_SIZE);
+
+	/* SPD InfoFrame header */
+	buffer[0] = 0x83;  /* SPD InfoFrame type */
+	buffer[1] = 0x01;  /* Version */
+	buffer[2] = 0x19;  /* Length (25 bytes) */
+
+	/* Vendor name (8 bytes) and product description (16 bytes) */
+	mtk_hdmi_pad_string(&buffer[4], 8, vendor);
+	mtk_hdmi_pad_string(&buffer[12], 16, product);
+
+	/* checksum over the full frame, so that the total sums to zero */
+	for (checksum = 0, i = 0; i < HDMI_SPD_INFOFRAME_SIZE; i++)
+		checksum += buffer[i];
+	buffer[3] = 0x100 - checksum;
+
+	return 0;
+}
+
+static int mtk_hdmi_setup_avi_infoframe(struct mtk_hdmi *hdmi, u8 *buffer,
+					size_t bufsz,
+					struct display_timing *mode)
+{
+	u8 checksum;
+	int i;
+
+	if (bufsz < HDMI_AVI_INFOFRAME_SIZE)
+		return -EINVAL;
+
+	memset(buffer, 0, HDMI_AVI_INFOFRAME_SIZE);
+
+	/* AVI InfoFrame header */
+	buffer[0] = 0x82;  /* AVI InfoFrame type */
+	buffer[1] = 0x02;  /* Version */
+	buffer[2] = 0x0D;  /* Length (13 bytes) */
+
+	/* Data byte 1: Scan info, bar info, active format info, RGB/YCC */
+	switch (hdmi->csp) {
+	case HDMI_COLORSPACE_YUV422:
+		buffer[4] = 0x20;
+		break;
+	case HDMI_COLORSPACE_YUV444:
+		buffer[4] = 0x40;
+		break;
+	case HDMI_COLORSPACE_YUV420:
+		buffer[4] = 0x60;
+		break;
+	default:
+		buffer[4] = 0x00;
+		break;
+	}
+
+	/* Data byte 4: Video Identification Code (VIC) */
+	if (mode->hactive.typ == 1920 && mode->vactive.typ == 1080)
+		buffer[7] = 16;  /* 1920x1080@60Hz */
+	else if (mode->hactive.typ == 1280 && mode->vactive.typ == 720)
+		buffer[7] = 4;   /* 1280x720@60Hz */
+	else if (mode->hactive.typ == 720 && mode->vactive.typ == 480)
+		buffer[7] = 2;   /* 720x480@60Hz */
+	else
+		buffer[7] = 0;   /* Unknown/unsupported timing */
+
+	/*
+	 * Data byte 2: picture aspect ratio, active portion same as
+	 * picture. VIC 2 is a 4:3 mode, the others are 16:9.
+	 */
+	buffer[5] = buffer[7] == 2 ? 0x18 : 0x28;
+
+	/* Data byte 3: Colorimetry, picture scaling */
+	switch (hdmi->colorimetry) {
+	case HDMI_COLORIMETRY_ITU_709:
+		buffer[6] = 0x80;
+		break;
+	case HDMI_COLORIMETRY_ITU_601:
+		buffer[6] = 0x40;
+		break;
+	default:
+		buffer[6] = 0x00;
+		break;
+	}
+
+	/* Data byte 5: Pixel repetition */
+	buffer[8] = 0x00;  /* No pixel repetition */
+
+	/* checksum over the full frame, so that the total sums to zero */
+	for (checksum = 0, i = 0; i < HDMI_AVI_INFOFRAME_SIZE; i++)
+		checksum += buffer[i];
+	buffer[3] = 0x100 - checksum;
+
+	return 0;
+}
+
+static void mtk_hdmi_hw_avi_infoframe(struct mtk_hdmi *hdmi, u8 *buf, u8 len)
+{
+	/* Disable AVI InfoFrame first */
+	mtk_hdmi_update(hdmi, TOP_INFO_EN, AVI_DIS_WR | AVI_DIS,
+			AVI_EN_WR | AVI_EN);
+	mtk_hdmi_update(hdmi, TOP_INFO_RPT, AVI_RPT_DIS, AVI_RPT_EN);
+
+	/* Write AVI InfoFrame header */
+	mtk_hdmi_write(hdmi, TOP_AVI_HEADER, get_unaligned_le24(&buf[0]));
+
+	/* Write AVI InfoFrame data packets */
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT00, get_unaligned_le32(&buf[3]));
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT01, get_unaligned_le24(&buf[7]));
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT02, get_unaligned_le32(&buf[10]));
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT03, get_unaligned_le24(&buf[14]));
+
+	/* Clear remaining packets */
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT04, 0);
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT05, 0);
+
+	/* Enable AVI InfoFrame */
+	mtk_hdmi_update(hdmi, TOP_INFO_RPT, AVI_RPT_EN, AVI_RPT_EN);
+	mtk_hdmi_update(hdmi, TOP_INFO_EN, AVI_EN_WR | AVI_EN,
+			AVI_EN_WR | AVI_EN);
+}
+
+static void mtk_hdmi_hw_spd_infoframe(struct mtk_hdmi *hdmi, u8 *buf, u8 len)
+{
+	/* Disable SPD InfoFrame first */
+	mtk_hdmi_update(hdmi, TOP_INFO_EN, SPD_DIS_WR | SPD_DIS,
+			SPD_EN_WR | SPD_EN);
+	mtk_hdmi_update(hdmi, TOP_INFO_RPT, SPD_RPT_DIS, SPD_RPT_EN);
+
+	/* Write SPD InfoFrame header */
+	mtk_hdmi_write(hdmi, TOP_SPDIF_HEADER, get_unaligned_le24(&buf[0]));
+
+	/* Write SPD InfoFrame data packets */
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT00, get_unaligned_le32(&buf[3]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT01, get_unaligned_le24(&buf[7]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT02, get_unaligned_le32(&buf[10]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT03, get_unaligned_le24(&buf[14]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT04, get_unaligned_le32(&buf[17]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT05, get_unaligned_le24(&buf[21]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT06, get_unaligned_le32(&buf[24]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT07, buf[28]);
+
+	/* Enable SPD InfoFrame */
+	mtk_hdmi_update(hdmi, TOP_INFO_RPT, SPD_RPT_EN, SPD_RPT_EN);
+	mtk_hdmi_update(hdmi, TOP_INFO_EN, SPD_EN_WR | SPD_EN,
+			SPD_EN_WR | SPD_EN);
+}
+
+static void mtk_hdmi_setup_infoframes(struct mtk_hdmi *hdmi,
+				      struct display_timing *mode)
+{
+	u8 buffer_spd[HDMI_SPD_INFOFRAME_SIZE];
+	u8 buffer_avi[HDMI_AVI_INFOFRAME_SIZE];
+	int ret;
+
+	ret = mtk_hdmi_setup_avi_infoframe(hdmi, buffer_avi,
+					   sizeof(buffer_avi), mode);
+	if (ret) {
+		dev_warn(hdmi->dev, "Failed to setup AVI infoframe: %d\n", ret);
+		return;
+	}
+
+	ret = mtk_hdmi_setup_spd_infoframe(hdmi, buffer_spd,
+					   sizeof(buffer_spd),
+					   "MediaTek", "On-chip HDMI");
+	if (ret) {
+		dev_warn(hdmi->dev, "Failed to setup SPD infoframe: %d\n", ret);
+		return;
+	}
+
+	/* Send the infoframes to hardware */
+	mtk_hdmi_hw_avi_infoframe(hdmi, buffer_avi, sizeof(buffer_avi));
+	mtk_hdmi_hw_spd_infoframe(hdmi, buffer_spd, sizeof(buffer_spd));
+}
+
+static void mtk_hdmi_controller_pre_enable(struct mtk_hdmi *hdmi,
+					   struct display_timing *mode)
+{
+	mtk_hdmi_convert_colorspace_depth(hdmi);
+	mtk_hdmi_output_set_display_mode(hdmi, mode);
+	mtk_hdmi_setup_infoframes(hdmi, mode);
+}
+
+static void mtk_hdmi_controller_enable(struct mtk_hdmi *hdmi)
+{
+	generic_phy_power_on(&hdmi->phy);
+	mtk_hdmi_hw_vid_black(hdmi, false);
+}
+
+static inline void mtk_hdmi_disable_all_int(struct mtk_hdmi *hdmi)
+{
+	/* disable all tx irq */
+	mtk_hdmi_write(hdmi, TOP_INT_MASK00, 0);
+	mtk_hdmi_write(hdmi, TOP_INT_MASK01, 0);
+}
+
+static int mtk_hdmi_read_edid(struct mtk_hdmi *hdmi, u8 *buf, int buf_size)
+{
+	struct udevice *chip;
+	int ret;
+
+	if (!hdmi->ddc_bus || buf_size < EDID_SIZE)
+		return -EINVAL;
+
+	ret = i2c_get_chip(hdmi->ddc_bus, EDID_ADDR, 1, &chip);
+	if (ret)
+		return ret;
+
+	ret = dm_i2c_read(chip, 0, buf, EDID_SIZE);
+	if (ret) {
+		dev_err(hdmi->dev, "failed to read EDID: %d\n", ret);
+		return ret;
+	}
+
+	/* read the extension block, if any */
+	if (buf[0x7e] != 0 && buf_size >= EDID_EXT_SIZE) {
+		ret = dm_i2c_read(chip, EDID_SIZE, buf + EDID_SIZE,
+				  buf_size - EDID_SIZE);
+		if (ret)
+			dev_warn(hdmi->dev,
+				 "error reading extended EDID block\n");
+	}
+
+	return 0;
+}
+
+static enum hdmi_hpd_state mtk_hdmi_hpd_pord_status(struct mtk_hdmi *hdmi)
+{
+	unsigned int hpd_status;
+
+	hpd_status = mtk_hdmi_read(hdmi, HPD_DDC_STATUS);
+	if ((hpd_status & (HPD_PIN_STA | PORD_PIN_STA)) ==
+	    (HPD_PIN_STA | PORD_PIN_STA))
+		return HDMI_PLUG_IN_AND_SINK_POWER_ON;
+	else if ((hpd_status & (HPD_PIN_STA | PORD_PIN_STA)) == HPD_PIN_STA)
+		return HDMI_PLUG_IN_ONLY;
+	else
+		return HDMI_PLUG_OUT;
+}
+
+static int mtk_hdmi_wait_for_hpd(struct mtk_hdmi *hdmi)
+{
+	ulong start = get_timer(0);
+
+	do {
+		if (mtk_hdmi_hpd_pord_status(hdmi) ==
+		    HDMI_PLUG_IN_AND_SINK_POWER_ON)
+			return 0;
+
+		udelay(100);
+	} while (get_timer(start) < MTK_HDMI_HPD_TIMEOUT_MS);
+
+	return -ETIMEDOUT;
+}
+
+static bool mtk_hdmi_mode_valid(void *priv, const struct display_timing *timing)
+{
+	return timing->hactive.typ <= MTK_HDMI_MAX_WIDTH &&
+	       timing->vactive.typ <= MTK_HDMI_MAX_HEIGHT;
+}
+
+static int mtk_hdmi_get_display_timing(struct mtk_hdmi *hdmi,
+				       struct display_timing *timing)
+{
+	u8 edid[EDID_EXT_SIZE];
+	int panel_bits_per_colour;
+	int ret;
+
+	ret = mtk_hdmi_read_edid(hdmi, edid, EDID_EXT_SIZE);
+	if (ret)
+		return ret;
+
+	ret = edid_get_timing_validate(edid, EDID_EXT_SIZE,
+				       timing, &panel_bits_per_colour,
+				       mtk_hdmi_mode_valid, NULL);
+	if (ret)
+		return ret;
+
+	debug("Display timing:\n clock %u Hz\n", timing->pixelclock.typ);
+	debug(" hactive: %d,\thfront_p: %d,\thback_p: %d hsync:\t%d\n",
+	      timing->hactive.typ, timing->hfront_porch.typ,
+	      timing->hback_porch.typ, timing->hsync_len.typ);
+	debug(" vactive: %d,\tvfront_p: %d,\tvback_p: %d vsync:\t%d\n",
+	      timing->vactive.typ, timing->vfront_porch.typ,
+	      timing->vback_porch.typ, timing->vsync_len.typ);
+	debug(" flags: 0x%x\n", timing->flags);
+
+	return 0;
+}
+
+static void mtk_hdmi_controller_initialize(struct mtk_hdmi *hdmi,
+					   struct display_timing *mode)
+{
+	mtk_hdmi_disable_all_int(hdmi);
+
+	mtk_hdmi_disable_abist(hdmi);
+
+	mtk_hdmi_controller_pre_enable(hdmi, mode);
+
+	/* let the new configuration settle before unmuting the output */
+	mdelay(50);
+
+	mtk_hdmi_controller_enable(hdmi);
+}
+
+static void mtk_hdmi_reset_colorspace_setting(struct mtk_hdmi *hdmi)
+{
+	hdmi->set_csp_depth = RGB444_8bit;
+	hdmi->csp = HDMI_COLORSPACE_RGB;
+	hdmi->color_depth = HDMI_8_BIT;
+	hdmi->colorimetry = HDMI_COLORIMETRY_NONE;
+}
+
+static int mtk_hdmi_get_comp_by_alias(struct udevice *dev, const char *alias,
+				      struct udevice **compp)
+{
+	struct udevice *comp;
+	ofnode node;
+	int ret;
+
+	node = ofnode_get_aliases_node(alias);
+	if (!ofnode_valid(node)) {
+		dev_err(dev, "cannot find alias %s\n", alias);
+		return -ENODEV;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_MISC, node, &comp);
+	if (ret) {
+		dev_err(dev, "cannot get %s: %d\n", alias, ret);
+		return ret;
+	}
+
+	ret = mtk_disp_comp_enable(comp);
+	if (ret)
+		return ret;
+
+	/* only publish the handle once its clocks are on, so the error */
+	/* unwind can rely on a non-NULL pointer meaning "enabled" */
+	*compp = comp;
+
+	return 0;
+}
+
+/* disable the pipeline component clocks, in reverse acquisition order */
+static void mtk_hdmi_disable_components(struct mtk_hdmi *hdmi)
+{
+	struct udevice *comps[] = {
+		hdmi->padding5, hdmi->padding4, hdmi->mutex, hdmi->ethdr,
+		hdmi->merge5, hdmi->merge3, hdmi->larb3, hdmi->larb2,
+		hdmi->rdma5, hdmi->rdma4, hdmi->dpi1,
+	};
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(comps); i++)
+		if (comps[i])
+			mtk_disp_comp_disable(comps[i]);
+}
+
+/* program the vdosys1 muxes to route the mixer output to the DPI1/HDMI path */
+static void mtk_hdmi_configure_vdosys1(void __iomem *base)
+{
+	/* MERGE2_ASYNC_SOUT --> MIXER_IN3_SEL */
+	writel(OUTPUT_TO_MIXER_IN3_SEL, base + SUBDISP_MERGE2_ASYNC_SOUT_SEL);
+	writel(INPUT_FROM_MERGE2_ASYNC_SOUT, base + SUBDISP_MIXER_IN3_SEL_IN);
+
+	/* MIXER_IN3_SOUT --> DISP_MIXER */
+	writel(OUTPUT_TO_DISP_MIXER, base + SUBDISP_MIXER_IN3_SOUT_SEL);
+
+	/* DISP_MIXER --> MIXER_SOUT_SEL */
+	writel(INPUT_FROM_DISP_MIXER, base + SUBDISP_MIXER_SOUT_SEL_IN);
+
+	/* MIXER_SOUT_SEL --> HDR_VDO_BE0 */
+	writel(OUTPUT_TO_HDR_VDO_BE0, base + SUBDISP_MIXER_OUT_SOUT_SEL);
+
+	/* HDR_VDO_BE0 --> MERGE4_ASYNC_SEL */
+	writel(INPUT_FROM_HDR_VDO_BE0, base + SUBDISP_MERGE4_ASYNC_SEL_IN);
+
+	/* MERGE4_MOUT_SEL --> DPI1_SEL */
+	writel(OUTPUT_TO_DPI1_SEL, base + SUBDISP_DISP_MERGE4_MOUT_SEL);
+	writel(INPUT_FROM_VPP_MERGE4_MOUT, base + SUBDISP_DISP_DPI1_SEL_IN);
+}
+
+static int mtk_hdmi_probe(struct udevice *dev)
+{
+	struct mtk_hdmi *hdmi = dev_get_priv(dev);
+	struct video_priv *priv = dev_get_uclass_priv(dev);
+	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
+	struct ofnode_phandle_args args;
+	struct display_timing timing;
+	fdt_size_t fb_region_size;
+	struct udevice *vdosys1;
+	void __iomem *vdosys1_base;
+	ofnode node;
+	int ret;
+
+	hdmi->dev = dev;
+
+	hdmi->regs = dev_read_addr(dev);
+	if (hdmi->regs == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	ret = clk_get_bulk(dev, &hdmi->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable_bulk(&hdmi->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	ret = generic_phy_get_by_name(dev, "hdmi", &hdmi->phy);
+	if (ret) {
+		dev_err(dev, "failed to get HDMI PHY: %d\n", ret);
+		goto err_disable_clk;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_I2C,
+					  dev_read_subnode(dev, "i2c"),
+					  &hdmi->ddc_bus);
+	if (ret) {
+		dev_err(dev, "failed to get DDC I2C bus: %d\n", ret);
+		goto err_disable_clk;
+	}
+
+	mtk_hdmi_reset_colorspace_setting(hdmi);
+
+	ret = mtk_hdmi_wait_for_hpd(hdmi);
+	if (ret) {
+		dev_err(dev, "display is not connected\n");
+		goto err_disable_clk;
+	}
+
+	ret = mtk_hdmi_get_display_timing(hdmi, &timing);
+	if (ret) {
+		dev_err(dev, "failed to get display timing from EDID: %d\n",
+			ret);
+		goto err_disable_clk;
+	}
+
+	hdmi->mode = timing;
+	/* CEA-861: SD modes use ITU-601 colorimetry, HD modes ITU-709 */
+	hdmi->colorimetry = timing.vactive.typ >= 720 ?
+			    HDMI_COLORIMETRY_ITU_709 : HDMI_COLORIMETRY_ITU_601;
+
+	/* this powers on the HDMI PHY */
+	mtk_hdmi_controller_initialize(hdmi, &timing);
+
+	/* Set up video private data based on the selected display timing */
+	priv->bpix = VIDEO_BPP32;
+	priv->xsize = timing.hactive.typ;
+	priv->ysize = timing.vactive.typ;
+	priv->line_length = priv->xsize * VNBYTES(VIDEO_BPP32);
+
+	plat->size = priv->ysize * priv->line_length;
+
+	/* the framebuffer lives in a dedicated reserved-memory region */
+	ret = dev_read_phandle_with_args(dev, "memory-region", NULL, 0, 0,
+					 &args);
+	if (ret) {
+		dev_err(dev, "no framebuffer memory-region: %d\n", ret);
+		goto err_power_off_phy;
+	}
+
+	plat->base = ofnode_get_addr_size(args.node, "reg", &fb_region_size);
+	if (plat->base == FDT_ADDR_T_NONE) {
+		dev_err(dev, "failed to decode framebuffer region\n");
+		ret = -EINVAL;
+		goto err_power_off_phy;
+	}
+
+	if (fb_region_size < plat->size) {
+		dev_err(dev, "framebuffer region too small: %llu < %u\n",
+			(unsigned long long)fb_region_size, plat->size);
+		ret = -EINVAL;
+		goto err_power_off_phy;
+	}
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "dpi1", &hdmi->dpi1);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_dpi_hw_enable(hdmi->dpi1);
+	mtk_dpi_config(hdmi->dpi1, &timing,
+		       hdmi->csp == HDMI_COLORSPACE_RGB);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "vdo1-rdma4", &hdmi->rdma4);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_mdp_rdma_config(hdmi->rdma4, plat, &timing, false);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "vdo1-rdma5", &hdmi->rdma5);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_mdp_rdma_config(hdmi->rdma5, plat, &timing, true);
+
+	/* ungate the SMI larbs feeding the display path's DRAM access */
+	ret = mtk_hdmi_get_comp_by_alias(dev, "larb2", &hdmi->larb2);
+	if (ret)
+		goto err_disable_comps;
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "larb3", &hdmi->larb3);
+	if (ret)
+		goto err_disable_comps;
+
+	/*
+	 * The display routing muxes live in the vdosys1 syscon register block.
+	 * It is a clock provider rather than a pipeline component, so resolve
+	 * its alias to the node and grab the register base directly.
+	 */
+	node = ofnode_get_aliases_node("vdosys1");
+	if (!ofnode_valid(node)) {
+		dev_err(dev, "cannot find vdosys1 alias\n");
+		ret = -ENODEV;
+		goto err_disable_comps;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_CLK, node, &vdosys1);
+	if (ret) {
+		dev_err(dev, "cannot get vdosys1 syscon: %d\n", ret);
+		goto err_disable_comps;
+	}
+
+	vdosys1_base = dev_remap_addr(vdosys1);
+	if (!vdosys1_base) {
+		ret = -EINVAL;
+		goto err_disable_comps;
+	}
+
+	mtk_hdmi_configure_vdosys1(vdosys1_base);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "merge3", &hdmi->merge3);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_disp_merge_config(hdmi->merge3, priv->xsize / 2, priv->ysize,
+			      priv->xsize / 2, priv->ysize,
+			      priv->xsize, priv->ysize);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "merge5", &hdmi->merge5);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_disp_merge_config(hdmi->merge5, priv->xsize, priv->ysize, 0, 0,
+			      priv->xsize, priv->ysize);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "ethdr0", &hdmi->ethdr);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_ethdr_config(hdmi->ethdr, priv->xsize, priv->ysize);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "mutex1", &hdmi->mutex);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_disp_mutex_config(hdmi->mutex);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "padding4", &hdmi->padding4);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_disp_padding_config(hdmi->padding4);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "padding5", &hdmi->padding5);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_disp_padding_config(hdmi->padding5);
+
+	video_set_flush_dcache(dev, true);
+
+	return 0;
+
+err_disable_comps:
+	mtk_hdmi_disable_components(hdmi);
+err_power_off_phy:
+	generic_phy_power_off(&hdmi->phy);
+err_disable_clk:
+	clk_disable_bulk(&hdmi->clk_bulk);
+
+	return ret;
+}
+
+static const struct udevice_id mtk_hdmi_ids[] = {
+	{
+		.compatible = "mediatek,mt8188-hdmi-tx",
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_hdmi) = {
+	.name		= "mtk_hdmi",
+	.id		= UCLASS_VIDEO,
+	.of_match	= mtk_hdmi_ids,
+	.probe		= mtk_hdmi_probe,
+	.bind		= dm_scan_fdt_dev,
+	.priv_auto	= sizeof(struct mtk_hdmi),
+};

-- 
2.54.0

