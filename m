Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D21C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA5BC81422;
	Tue, 28 Jul 2026 12:29:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R8nzF6Zp4Zni; Tue, 28 Jul 2026 12:29:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 156CE813FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241794;
	bh=4eJy+Qe/iGExL15aVpfdPpoqPFVxNlKDa0Uz8VHfxCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s9fZdgZZOWDs6wnpUkZ9+qTNyMOnCewno+60cFxNSqzvTP386DclbQXan5u2oJvOw
	 XolrShoW7vZ8+d6Gd/YFzyML8vBGtxJ8YpzOcrwvSv+qn99zJq748vxuis9xON1ygH
	 FTdW3P7KbQZDCywOr8pUsCawPzr+slSMcX5bLyv1qUlf6Du//0HfupZywf1yah7v6g
	 lv0f+jqUr038cBfQv0xNlZ1yWPGplj/aEtJV4ZmCpb8uUAq2JeMx/x+Zbzu+NnQJXw
	 waaMtzSKldNQkJGb8Gncf2HcjeqKvxtlDtDsT34GbzTfGrvshbESvwgJAYrJN9kLUg
	 nJhDlwFP/H96A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 156CE813FF;
	Tue, 28 Jul 2026 12:29:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D50B4BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3BDB481357
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9TyUUdXjKQKy for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:29:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C108281347
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C108281347
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C108281347
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:40 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so3213456f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241779; x=1785846579;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4eJy+Qe/iGExL15aVpfdPpoqPFVxNlKDa0Uz8VHfxCo=;
 b=KiTl5fC/1rdDMXyBNqIRNYRpJMyQDJ5e8zxcTfWaIK6unDvQKqpyqRzFt7k/V1KR6D
 uK2apcJXEkUZZWWwjv0EtIb6EGVWRgI4WKE6HITem8nWVFluqqNR2VAf/RD4TSTLYjht
 HqLYpWkSSWHHm69cPts4K8rGWwUQ+rDdfbmF7o1rTfzVA1SO2zFay398rvTSOHfDeL10
 zfMxAjSN//BnIeFy5EP/dK2lveXg+tFoAXBtfULzNwlp3rxLE1hd/Kd76l+KcKT4Ty5T
 mWNIhFCGeKgr+t3ipOazqszRX5kzQkU0l7aUEGhCgGuDSnuj7sJH5S2IAMNfmrweUcis
 jTcQ==
X-Gm-Message-State: AOJu0YzXLBKHfP164x4N+xK0krM5k+5BGFCv1pMXIPtCmBd1bnwxUfLI
 geIBYCY672pNqDnyyJgfYIwlTswq6zu5+hCciEFVN+nenW571QqckAVIgMjFNtPcwzI=
X-Gm-Gg: AR+sD112u4Qr3FjjHtVUpyZu9oS3tf6Pmeq/t6V6gX6FMzNQalPJe53K+IBekTbRrcm
 a1DVSFsQIjZBjl5QdEryVIZQCGmRaqeaRzY9K18yxvkJ767hIC9krN75tPe4xWVobdX7qN+mtwI
 xvsY5mM6yWCDByZPrR2VnE09J7PJdOV8LxNTwvfNbOhh+3s72qxQ0HiCm0vMqasqJS998PNABwA
 6m72e0FUMgjxL7S0v/b2wLRVDidw0NWcHzjnyT1IOtDVDD0CcHCh0iaFZA0tEJpGKU5tTqln/e7
 XxCmk6X5iuEsR5HQWfsL1NdkAP4rZIhveaE5sSO+VyIANNNofIYrhizfpntf4Yn13QL2ZxL1dLg
 s9hBrLPk9W9H/1YN2gZWCtY3qNpBZhEI+4k4BkkiAMSgB2bafjebL0wbdz1lI8fGwaRvX1tQd5p
 pJtdYkNYIA/e+3uH02j9bmzl9So0tNAkr+pLcVLG1EWtNiOR+qmyda2oRuQuybbJG8yIgQYcpLd
 zfnHzlbGFPBWB12A1X4Dp9L0UFcbN9RKQguGMpiTXjFtjkdnDkUT9L1xDgh9nA=
X-Received: by 2002:a05:6000:4b1b:b0:47f:8fb6:c32f with SMTP id
 ffacd0b85a97d-47fb1e74cb1mr2510826f8f.24.1785241778609; 
 Tue, 28 Jul 2026 05:29:38 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm58324766f8f.27.2026.07.28.05.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:29:38 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 14:29:41 +0200
Subject: [PATCH 09/13] video: mediatek: add new hdmi driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-add-genio-510-and-genio-700-hdmi-v1-9-ac54bd75f960@baylibre.com>
References: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
In-Reply-To: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
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
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785241779; x=1785846579;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4eJy+Qe/iGExL15aVpfdPpoqPFVxNlKDa0Uz8VHfxCo=;
 b=Gdn+b3Ejac8p1B1pGoPkRiImvgAfT/OMUtQidOcwNY0CVZ5rwK5dl+5V1ZKTH7hLRe
 f59xmUKuieKC5yeuazHDTY91r60mXSjAK+6pAZqkU5z3XI3cs+F70fSzTR6FadufcK0V
 NN5R66kD58RnaGQpYFELmh6MoAOAz20hPsgnZ1EtKV+Gki6HyUH8V3bdLSKNDaZdtJoF
 ldVk9XRcBNveNOxbJ3U5vJ4664aX6CJXZpJevSxG5FL2yt7Gt8RqUoxLeonfhCNeOtm9
 KR191BYUk6tFyer1iPq/JdeudJ2xr/13I/vV6mj9GYVNiQ4Cijy2u9jlvh6SDNXqbeCJ
 uXFQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Gdn+b3Ej
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
 drivers/video/Kconfig                         |   1 +
 drivers/video/Makefile                        |   1 +
 drivers/video/mediatek/Kconfig                |  21 +
 drivers/video/mediatek/Makefile               |  16 +
 drivers/video/mediatek/mtk_hdmi.c             | 919 ++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_mt8188_hdmi_regs.h | 103 +++
 6 files changed, 1061 insertions(+)

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
index 00000000000..427d7e36b90
--- /dev/null
+++ b/drivers/video/mediatek/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2022 BayLibre, SAS
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
index 00000000000..af54450a836
--- /dev/null
+++ b/drivers/video/mediatek/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 MediaTek Inc.
+#
+# Author: Julien Stephan <jstephan@baylibre.com>
+
+obj-$(CONFIG_VIDEO_MEDIATEK_HDMI) += \
+	mtk_hdmi.o \
+	mtk_disp_comp.o \
+	mtk_dpi_mt8188.o \
+	mtk_mdp_rdma_mt8188.o \
+	mtk_disp_merge_mt8188.o \
+	mtk_disp_mixer_mt8188.o \
+	mtk_disp_mutex_mt8188.o \
+	mtk_disp_padding_mt8188.o \
+	mtk_vdosys1_mt8188.o
diff --git a/drivers/video/mediatek/mtk_hdmi.c b/drivers/video/mediatek/mtk_hdmi.c
new file mode 100644
index 00000000000..e174585fcbb
--- /dev/null
+++ b/drivers/video/mediatek/mtk_hdmi.c
@@ -0,0 +1,919 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 BayLibre, SAS
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <asm/io.h>
+#include <asm/system.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <edid.h>
+#include <errno.h>
+#include <generic-phy.h>
+#include <i2c.h>
+#include <linux/delay.h>
+#include <video.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_merge_mt8188.h"
+#include "mtk_disp_mixer_mt8188.h"
+#include "mtk_disp_mutex_mt8188.h"
+#include "mtk_disp_padding_mt8188.h"
+#include "mtk_dpi_mt8188.h"
+#include "mtk_mdp_rdma_mt8188.h"
+#include "mtk_mt8188_hdmi_regs.h"
+#include "mtk_vdosys1_mt8188.h"
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
+#define BYTES_TO_UINT32(msb, b1, b2, lsb)	\
+	((((msb) & 0xff) << 24) + (((b1) & 0xff) << 16) + (((b2) & 0xff) << 8) + \
+	 (((lsb) & 0xff)))
+
+enum hdmi_color_depth {
+	HDMI_8_BIT,
+	HDMI_10_BIT,
+	HDMI_12_BIT,
+	HDMI_16_BIT,
+};
+
+enum hdmi_colorspace {
+	HDMI_COLORSPACE_RGB,
+	HDMI_COLORSPACE_YUV422,
+	HDMI_COLORSPACE_YUV444,
+	HDMI_COLORSPACE_YUV420,
+	HDMI_COLORSPACE_RESERVED4,
+	HDMI_COLORSPACE_RESERVED5,
+	HDMI_COLORSPACE_RESERVED6,
+	HDMI_COLORSPACE_IDO_DEFINED,
+};
+
+enum hdmi_colorimetry {
+	HDMI_COLORIMETRY_NONE,
+	HDMI_COLORIMETRY_ITU_601,
+	HDMI_COLORIMETRY_ITU_709,
+	HDMI_COLORIMETRY_EXTENDED,
+};
+
+struct mtk_hdmi {
+	struct udevice *dev;
+	struct udevice *ddc_bus;
+	struct udevice *dpi1;
+	struct udevice *vdosys1;
+	struct udevice *merge3;
+	struct udevice *merge5;
+	struct udevice *mixer;
+	struct udevice *mutex;
+	struct udevice *padding4;
+	struct udevice *padding5;
+	struct udevice *rdma4;
+	struct udevice *rdma5;
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
+static void mtk_hdmi_mask(struct mtk_hdmi *hdmi, u32 offset, u32 val, u32 mask)
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
+	if (enable)
+		mtk_hdmi_mask(hdmi, TOP_CFG00, HDMI_MODE_HDMI, HDMI_MODE_HDMI);
+	else
+		mtk_hdmi_mask(hdmi, TOP_CFG00, HDMI_MODE_DVI, HDMI_MODE_HDMI);
+}
+
+static void mtk_hdmi_hw_vid_black(struct mtk_hdmi *hdmi, bool black)
+{
+	if (black)
+		mtk_hdmi_mask(hdmi, TOP_VMUTE_CFG1, REG_VMUTE_EN, REG_VMUTE_EN);
+	else
+		mtk_hdmi_mask(hdmi, TOP_VMUTE_CFG1, 0, REG_VMUTE_EN);
+}
+
+static void mtk_hdmi_hw_reset(struct mtk_hdmi *hdmi)
+{
+	mtk_hdmi_mask(hdmi, HDMI_CONFIG, 0x0 << HDMITX_SW_RSTB_SHIFT,
+		      HDMITX_SW_RSTB);
+	udelay(5);
+	mtk_hdmi_mask(hdmi, HDMI_CONFIG, 0x1 << HDMITX_SW_RSTB_SHIFT,
+		      HDMITX_SW_RSTB);
+}
+
+static inline void mtk_hdmi_set_sw_hpd(struct mtk_hdmi *hdmi, bool high)
+{
+	if (high)
+		mtk_hdmi_mask(hdmi, HDMI_CONFIG, 0x1 << HDMITX_SW_HPD_SHIFT,
+			      HDMITX_SW_HPD);
+	else
+		mtk_hdmi_mask(hdmi, HDMI_CONFIG, 0x0 << HDMITX_SW_HPD_SHIFT,
+			      HDMITX_SW_HPD);
+}
+
+static void mtk_hdmi_set_deep_color(struct mtk_hdmi *hdmi, bool is_hdmi_sink)
+{
+	unsigned int deep_color = 0;
+
+	/* ycbcr422 12bit no deep color */
+	if (hdmi->csp == HDMI_COLORSPACE_YUV422) {
+		deep_color = DEEPCOLOR_MODE_8BIT;
+	} else {
+		switch (hdmi->color_depth) {
+		case HDMI_8_BIT:
+			deep_color = DEEPCOLOR_MODE_8BIT;
+			break;
+		case HDMI_10_BIT:
+			deep_color = DEEPCOLOR_MODE_10BIT;
+			break;
+		case HDMI_12_BIT:
+			deep_color = DEEPCOLOR_MODE_12BIT;
+			break;
+		case HDMI_16_BIT:
+			deep_color = DEEPCOLOR_MODE_16BIT;
+			break;
+		default:
+			dev_warn(hdmi->dev, "Unsupported color depth %d\n",
+				 hdmi->color_depth);
+		}
+	}
+
+	mtk_hdmi_mask(hdmi, TOP_CFG00, deep_color, DEEPCOLOR_MODE_MASKBIT);
+
+	/* GCP */
+	mtk_hdmi_mask(hdmi, TOP_CFG00, 0, DEEPCOLOR_PAT_EN);
+	if (is_hdmi_sink && deep_color != DEEPCOLOR_MODE_8BIT)
+		mtk_hdmi_mask(hdmi, TOP_MISC_CTLR, DEEP_COLOR_ADD,
+			      DEEP_COLOR_ADD);
+	else
+		mtk_hdmi_mask(hdmi, TOP_MISC_CTLR, 0, DEEP_COLOR_ADD);
+}
+
+static void mtk_hdmi_yuv420_downsample(struct mtk_hdmi *hdmi, bool enable)
+{
+	if (enable) {
+		mtk_hdmi_mask(hdmi, HDMI_CONFIG,
+			      HDMI_YUV420_MODE | HDMITX_SW_HPD,
+			      HDMI_YUV420_MODE | HDMITX_SW_HPD);
+		mtk_hdmi_mask(hdmi, VID_DOWNSAMPLE_CONFIG,
+			      C444_C422_CONFIG_ENABLE, C444_C422_CONFIG_ENABLE);
+		mtk_hdmi_mask(hdmi, VID_DOWNSAMPLE_CONFIG,
+			      C422_C420_CONFIG_ENABLE, C422_C420_CONFIG_ENABLE);
+		mtk_hdmi_mask(hdmi, VID_DOWNSAMPLE_CONFIG, 0,
+			      C422_C420_CONFIG_BYPASS);
+		mtk_hdmi_mask(hdmi, VID_DOWNSAMPLE_CONFIG,
+			      C422_C420_CONFIG_OUT_CB_OR_CR,
+			      C422_C420_CONFIG_OUT_CB_OR_CR);
+		mtk_hdmi_mask(hdmi, VID_OUT_FORMAT,
+			      OUTPUT_FORMAT_DEMUX_420_ENABLE,
+			      OUTPUT_FORMAT_DEMUX_420_ENABLE);
+	} else {
+		mtk_hdmi_mask(hdmi, HDMI_CONFIG, 0 | HDMITX_SW_HPD,
+			      HDMI_YUV420_MODE | HDMITX_SW_HPD);
+		mtk_hdmi_mask(hdmi, VID_DOWNSAMPLE_CONFIG, 0,
+			      C444_C422_CONFIG_ENABLE);
+		mtk_hdmi_mask(hdmi, VID_DOWNSAMPLE_CONFIG, 0,
+			      C422_C420_CONFIG_ENABLE);
+		mtk_hdmi_mask(hdmi, VID_DOWNSAMPLE_CONFIG,
+			      C422_C420_CONFIG_BYPASS, C422_C420_CONFIG_BYPASS);
+		mtk_hdmi_mask(hdmi, VID_DOWNSAMPLE_CONFIG, 0,
+			      C422_C420_CONFIG_OUT_CB_OR_CR);
+		mtk_hdmi_mask(hdmi, VID_OUT_FORMAT, 0,
+			      OUTPUT_FORMAT_DEMUX_420_ENABLE);
+	}
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
+	return tmds_clk >= 340000000 && hdmi->csp != HDMI_COLORSPACE_YUV420;
+}
+
+static inline void mtk_hdmi_enable_scrambling(struct mtk_hdmi *hdmi,
+					      bool enable)
+{
+	udelay(150);
+
+	if (enable)
+		mtk_hdmi_mask(hdmi, TOP_CFG00, SCR_ON | HDMI2_ON,
+			      SCR_ON | HDMI2_ON);
+	else
+		mtk_hdmi_mask(hdmi, TOP_CFG00, SCR_OFF | HDMI2_OFF,
+			      SCR_ON | HDMI2_ON);
+}
+
+static void mtk_hdmi_disable_abist(struct mtk_hdmi *hdmi)
+{
+	mtk_hdmi_mask(hdmi, TOP_CFG00, 0, ABIST_ENABLE);
+}
+
+static void mtk_hdmi_change_video_resolution(struct mtk_hdmi *hdmi)
+{
+	bool is_over_340M = false;
+	bool is_hdmi_sink = true;
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
+	mtk_hdmi_mask(hdmi, TOP_CFG01, NULL_PKT_VSYNC_HIGH_EN,
+		      NULL_PKT_VSYNC_HIGH_EN | NULL_PKT_EN);
+
+	is_over_340M = mtk_hdmi_tmds_over_340M(hdmi);
+	dev_dbg(hdmi->dev, "is_over_340M: %d\n", is_over_340M);
+
+	mtk_hdmi_enable_scrambling(hdmi, is_over_340M);
+
+	if (hdmi->csp == HDMI_COLORSPACE_YUV420)
+		mtk_hdmi_yuv420_downsample(hdmi, true);
+	else
+		mtk_hdmi_yuv420_downsample(hdmi, false);
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
+static int mtk_hdmi_setup_spd_infoframe(struct mtk_hdmi *hdmi, u8 *buffer,
+					size_t bufsz, const char *vendor,
+					const char *product)
+{
+	u8 checksum = 0;
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
+	/* Vendor name (8 bytes, padded with spaces) */
+	strlcpy((char *)&buffer[4], vendor, 8);
+	for (i = 4; i < 12; i++) {
+		if (buffer[i] == '\0')
+			buffer[i] = ' ';
+	}
+
+	/* Product description (16 bytes, padded with spaces) */
+	strlcpy((char *)&buffer[12], product, 16);
+	for (i = 12; i < 28; i++) {
+		if (buffer[i] == '\0')
+			buffer[i] = ' ';
+	}
+
+	/* checksum over the full frame, so that the total sums to zero */
+	for (i = 0; i < HDMI_SPD_INFOFRAME_SIZE; i++)
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
+	u8 checksum = 0;
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
+	buffer[4] = 0x00; /* RGB by default */
+	if (hdmi->csp == HDMI_COLORSPACE_YUV422)
+		buffer[4] |= 0x20;  /* YCC422 */
+	else if (hdmi->csp == HDMI_COLORSPACE_YUV444)
+		buffer[4] |= 0x40;  /* YCC444 */
+	else if (hdmi->csp == HDMI_COLORSPACE_YUV420)
+		buffer[4] |= 0x60;  /* YCC420 */
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
+	buffer[6] = 0x00;  /* No specific colorimetry */
+	if (hdmi->colorimetry == HDMI_COLORIMETRY_ITU_709)
+		buffer[6] |= 0x80;
+	else if (hdmi->colorimetry == HDMI_COLORIMETRY_ITU_601)
+		buffer[6] |= 0x40;
+
+	/* Data byte 5: Pixel repetition */
+	buffer[8] = 0x00;  /* No pixel repetition */
+
+	/* checksum over the full frame, so that the total sums to zero */
+	for (i = 0; i < HDMI_AVI_INFOFRAME_SIZE; i++)
+		checksum += buffer[i];
+	buffer[3] = 0x100 - checksum;
+
+	return 0;
+}
+
+static void mtk_hdmi_hw_avi_infoframe(struct mtk_hdmi *hdmi, u8 *buf, u8 len)
+{
+	/* Disable AVI InfoFrame first */
+	mtk_hdmi_mask(hdmi, TOP_INFO_EN, AVI_DIS_WR | AVI_DIS,
+		      AVI_EN_WR | AVI_EN);
+	mtk_hdmi_mask(hdmi, TOP_INFO_RPT, AVI_RPT_DIS, AVI_RPT_EN);
+
+	/* Write AVI InfoFrame header */
+	mtk_hdmi_write(hdmi, TOP_AVI_HEADER,
+		       BYTES_TO_UINT32(0, buf[2], buf[1], buf[0]));
+
+	/* Write AVI InfoFrame data packets */
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT00,
+		       BYTES_TO_UINT32(buf[6], buf[5], buf[4], buf[3]));
+
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT01,
+		       BYTES_TO_UINT32(0, buf[9], buf[8], buf[7]));
+
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT02,
+		       BYTES_TO_UINT32(buf[13], buf[12], buf[11], buf[10]));
+
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT03,
+		       BYTES_TO_UINT32(0, buf[16], buf[15], buf[14]));
+
+	/* Clear remaining packets */
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT04, 0);
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT05, 0);
+
+	/* Enable AVI InfoFrame */
+	mtk_hdmi_mask(hdmi, TOP_INFO_RPT, AVI_RPT_EN, AVI_RPT_EN);
+	mtk_hdmi_mask(hdmi, TOP_INFO_EN, AVI_EN_WR | AVI_EN,
+		      AVI_EN_WR | AVI_EN);
+}
+
+static void mtk_hdmi_hw_spd_infoframe(struct mtk_hdmi *hdmi, u8 *buf, u8 len)
+{
+	/* Disable SPD InfoFrame first */
+	mtk_hdmi_mask(hdmi, TOP_INFO_EN, SPD_DIS_WR | SPD_DIS,
+		      SPD_EN_WR | SPD_EN);
+	mtk_hdmi_mask(hdmi, TOP_INFO_RPT, SPD_RPT_DIS, SPD_RPT_EN);
+
+	/* Write SPD InfoFrame header */
+	mtk_hdmi_write(hdmi, TOP_SPDIF_HEADER,
+		       BYTES_TO_UINT32(0, buf[2], buf[1], buf[0]));
+
+	/* Write SPD InfoFrame data packets */
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT00,
+		       BYTES_TO_UINT32(buf[6], buf[5], buf[4], buf[3]));
+
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT01,
+		       BYTES_TO_UINT32(0, buf[9], buf[8], buf[7]));
+
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT02,
+		       BYTES_TO_UINT32(buf[13], buf[12], buf[11], buf[10]));
+
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT03,
+		       BYTES_TO_UINT32(0, buf[16], buf[15], buf[14]));
+
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT04,
+		       BYTES_TO_UINT32(buf[20], buf[19], buf[18], buf[17]));
+
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT05,
+		       BYTES_TO_UINT32(0, buf[23], buf[22], buf[21]));
+
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT06,
+		       BYTES_TO_UINT32(buf[27], buf[26], buf[25], buf[24]));
+
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT07, buf[28]);
+
+	/* Enable SPD InfoFrame */
+	mtk_hdmi_mask(hdmi, TOP_INFO_RPT, SPD_RPT_EN, SPD_RPT_EN);
+	mtk_hdmi_mask(hdmi, TOP_INFO_EN, SPD_EN_WR | SPD_EN,
+		      SPD_EN_WR | SPD_EN);
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
+	mtk_hdmi_write(hdmi, TOP_INT_MASK00, 0x00000000);
+	mtk_hdmi_write(hdmi, TOP_INT_MASK01, 0x00000000);
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
+		udelay(100);
+	} while (get_timer(start) < MTK_HDMI_HPD_TIMEOUT_MS);
+
+	return -ETIMEDOUT;
+}
+
+static bool mtk_hdmi_mode_valid(void *priv, const struct display_timing *timing)
+{
+	return timing->hactive.typ < MTK_HDMI_MAX_WIDTH &&
+	       timing->vactive.typ < MTK_HDMI_MAX_HEIGHT;
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
+	ret = edid_get_timing_validate(edid, sizeof(struct edid1_info),
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
+static int mtk_hdmi_get_component(struct udevice *dev, const char *name,
+				  struct udevice **compp)
+{
+	int ret;
+
+	ret = uclass_get_device_by_phandle(UCLASS_MISC, dev, name, compp);
+	if (ret) {
+		dev_err(dev, "cannot get %s: %d\n", name, ret);
+		return ret;
+	}
+
+	return mtk_disp_comp_enable(*compp);
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
+		return ret;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_I2C,
+					  dev_read_subnode(dev, "i2c"),
+					  &hdmi->ddc_bus);
+	if (ret) {
+		dev_err(dev, "failed to get DDC I2C bus: %d\n", ret);
+		return ret;
+	}
+
+	mtk_hdmi_reset_colorspace_setting(hdmi);
+
+	ret = mtk_hdmi_wait_for_hpd(hdmi);
+	if (ret) {
+		dev_err(dev, "display is not connected\n");
+		return ret;
+	}
+
+	ret = mtk_hdmi_get_display_timing(hdmi, &timing);
+	if (ret) {
+		dev_err(dev, "failed to get display timing from EDID: %d\n",
+			ret);
+		return ret;
+	}
+
+	hdmi->mode = timing;
+	/* CEA-861: SD modes use ITU-601 colorimetry, HD modes ITU-709 */
+	hdmi->colorimetry = timing.vactive.typ >= 720 ?
+			    HDMI_COLORIMETRY_ITU_709 : HDMI_COLORIMETRY_ITU_601;
+
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
+		return ret;
+	}
+
+	plat->base = ofnode_get_addr_size(args.node, "reg", &fb_region_size);
+	if (plat->base == FDT_ADDR_T_NONE) {
+		dev_err(dev, "failed to decode framebuffer region\n");
+		return -EINVAL;
+	}
+
+	if (fb_region_size < plat->size) {
+		dev_err(dev, "framebuffer region too small: %llu < %u\n",
+			(unsigned long long)fb_region_size, plat->size);
+		return -EINVAL;
+	}
+
+	ret = mtk_hdmi_get_component(dev, "mediatek,dpi1", &hdmi->dpi1);
+	if (ret)
+		return ret;
+	mtk_dpi_hw_enable(hdmi->dpi1);
+	mtk_dpi_config(hdmi->dpi1, &timing,
+		       hdmi->csp == HDMI_COLORSPACE_RGB);
+
+	ret = mtk_hdmi_get_component(dev, "mediatek,rdma4", &hdmi->rdma4);
+	if (ret)
+		return ret;
+	mtk_mdp_rdma_config(hdmi->rdma4, plat, &timing, false);
+
+	ret = mtk_hdmi_get_component(dev, "mediatek,rdma5", &hdmi->rdma5);
+	if (ret)
+		return ret;
+	mtk_mdp_rdma_config(hdmi->rdma5, plat, &timing, true);
+
+	ret = mtk_hdmi_get_component(dev, "mediatek,vdosys1", &hdmi->vdosys1);
+	if (ret)
+		return ret;
+	mtk_vdosys1_configure_hdmi(hdmi->vdosys1);
+
+	ret = mtk_hdmi_get_component(dev, "mediatek,merge3", &hdmi->merge3);
+	if (ret)
+		return ret;
+	mtk_disp_merge_config(hdmi->merge3, priv->xsize / 2, priv->ysize,
+			      priv->xsize / 2, priv->ysize,
+			      priv->xsize, priv->ysize);
+
+	ret = mtk_hdmi_get_component(dev, "mediatek,merge5", &hdmi->merge5);
+	if (ret)
+		return ret;
+	mtk_disp_merge_config(hdmi->merge5, priv->xsize, priv->ysize, 0, 0,
+			      priv->xsize, priv->ysize);
+
+	ret = mtk_hdmi_get_component(dev, "mediatek,mixer", &hdmi->mixer);
+	if (ret)
+		return ret;
+	mtk_disp_mixer_config(hdmi->mixer, priv->xsize, priv->ysize);
+
+	ret = mtk_hdmi_get_component(dev, "mediatek,mutex1", &hdmi->mutex);
+	if (ret)
+		return ret;
+	mtk_disp_mutex_config(hdmi->mutex);
+
+	ret = mtk_hdmi_get_component(dev, "mediatek,padding4",
+				     &hdmi->padding4);
+	if (ret)
+		return ret;
+	mtk_disp_padding_config(hdmi->padding4);
+
+	ret = mtk_hdmi_get_component(dev, "mediatek,padding5",
+				     &hdmi->padding5);
+	if (ret)
+		return ret;
+	mtk_disp_padding_config(hdmi->padding5);
+
+	video_set_flush_dcache(dev, true);
+
+	return 0;
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
diff --git a/drivers/video/mediatek/mtk_mt8188_hdmi_regs.h b/drivers/video/mediatek/mtk_mt8188_hdmi_regs.h
new file mode 100644
index 00000000000..bcee2d1985d
--- /dev/null
+++ b/drivers/video/mediatek/mtk_mt8188_hdmi_regs.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Copyright (c) 2025 BayLibre, SAS
+ */
+
+#ifndef _MTK_MT8188_HDMI_REGS_H
+#define _MTK_MT8188_HDMI_REGS_H
+
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
+#define HDMITX_SW_HPD_SHIFT			(29)
+#define HDMITX_SW_RSTB				BIT(31)
+#define HDMITX_SW_RSTB_SHIFT			(31)
+
+#define HDMI_MODE_DVI				(0)
+#define HDMI_MODE_HDMI				BIT(3)
+
+#define HDMI_YUV420_MODE			BIT(10)
+#define HDMI_YUV420_MODE_SHIFT			(10)
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
+#define ABIST_VIDEO_FORMAT_MASKBIT		(0x3F << 16)
+#define ABIST_VIDEO_FORMAT_720x480P		(0x2 << 16)
+#define ABIST_VIDEO_FORMAT_720P50		(0xC << 16)
+#define ABIST_VIDEO_FORMAT_1080P60		(0xA << 16)
+#define ABIST_VIDEO_FORMAT_3840x2160P30		(0x19 << 16)
+
+#define HDCP_TOP_CTRL				0xC00
+#define HDMI_CONFIG				0xEA0
+
+#endif /* _MTK_MT8188_HDMI_REGS_H */

-- 
2.54.0

