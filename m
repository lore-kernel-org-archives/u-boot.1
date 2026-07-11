Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D02C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 13:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E15FF846F8;
	Sat, 11 Jul 2026 15:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="CkiZo+FC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91EEC848A1; Sat, 11 Jul 2026 15:40:14 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A81C841F2
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 15:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 69C90119775; Sat, 11 Jul 2026 15:40:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783777211; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=OSJeYdXArYTqiVPdultmo5juTKo9p5bJY8ATjIlL+5Y=;
 b=CkiZo+FC/KjTeINy8cnrI7xhbp9xRAJg6NEd4kM0R9pyL01a2+OFGXrwAi+MsVB6X/dCpo
 UH+RaA5psse5cRF+ru2g5vzMXVENVyQwG+W31kH0J17oWzq4R64Mzewx6FS5/8228RLtNt
 MJiDT/hH8Ygbs+cpnyB/s9Xz+kXKPQKlMQEUmhwOYfrNnSORYDd5W2ugnhyZmZ6lVXbpXK
 RaGmAgxJdodxd6h9BW5oESTDCvSHbCGEYf6eG/XfHY8eucJ8U0Z9HaUuz2x/rEd7pLv57R
 YdCZbRBaiREh1RJ+tsHVLe701Aky8Rmq6cA4uIFAsrSRxqWgdFJSdEG2LO2Q6Q==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Alexander Koch <akoch@initse.com>, Marek Vasut <marex@nabladev.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Johan Jonker <jbx6244@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] rtc: snvs: Add i.MX SNVS RTC driver
Date: Sat, 11 Jul 2026 15:39:33 +0200
Message-ID: <20260711134007.106745-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Alexander Koch <akoch@initse.com>

Add simple driver for i.MX SNVS RTC IP present in NXP i.MX SoCs.

Signed-off-by: Alexander Koch <akoch@initse.com>
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>
Cc: Alexander Koch <akoch@initse.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/rtc/Kconfig    |   7 +++
 drivers/rtc/Makefile   |   1 +
 drivers/rtc/snvs-rtc.c | 118 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 drivers/rtc/snvs-rtc.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 6fb3019a644..5b44cc99c97 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -296,6 +296,13 @@ config SPL_RTC_SANDBOX
 	  emulator and is used to test the RTC uclasses and associated code,
 	  as well as the I2C subsystem.
 
+config RTC_SNVS
+	bool "Enable i.MX SNVS RTC driver"
+	depends on DM_RTC
+	help
+	  Enable i.MX RTC driver. This driver supports the RTC that is present
+	  on various NXP i.MX SoCs.
+
 config RTC_STM32
 	bool "Enable STM32 RTC driver"
 	depends on DM_RTC
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 782f5a3bc3d..742481ce185 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_RTC_RV8803) += rv8803.o
 obj-$(CONFIG_RTC_RX8025) += rx8025.o
 obj-$(CONFIG_RTC_RX8010SJ) += rx8010sj.o
 obj-$(CONFIG_RTC_S35392A) += s35392a.o
+obj-$(CONFIG_RTC_SNVS) += snvs-rtc.o
 obj-$(CONFIG_RTC_STM32) += stm32_rtc.o
 obj-$(CONFIG_$(PHASE_)RTC_SANDBOX) += sandbox_rtc.o
 obj-$(CONFIG_RTC_ABX80X) += abx80x.o
diff --git a/drivers/rtc/snvs-rtc.c b/drivers/rtc/snvs-rtc.c
new file mode 100644
index 00000000000..c1b4fa0f8da
--- /dev/null
+++ b/drivers/rtc/snvs-rtc.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018-2026 INIT GmbH, Alexander Koch <akoch@initse.com>
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <linux/bitops.h>
+#include <linux/iopoll.h>
+#include <malloc.h>
+#include <rtc.h>
+
+#define SNVS_LPSRTCMR			0x1c
+#define SNVS_LPSRTCLR			0x20
+#define SNVS_LPCR			0x04
+#define SNVS_LPCR_SRTC_ENV		BIT(0)
+#define CNTR_TO_SECS_SH			15
+
+struct snvs_rtc_priv {
+	fdt_addr_t	base;
+};
+
+static int snvs_rtc_enable(struct udevice *dev)
+{
+	struct snvs_rtc_priv *priv = dev_get_priv(dev);
+	u32 val;
+
+	setbits_le32(priv->base + SNVS_LPCR, SNVS_LPCR_SRTC_ENV);
+
+	return readl_poll_timeout(priv->base + SNVS_LPCR, val,
+				  (val & SNVS_LPCR_SRTC_ENV), 1000);
+}
+
+static int snvs_rtc_disable(struct udevice *dev)
+{
+	struct snvs_rtc_priv *priv = dev_get_priv(dev);
+	u32 val;
+
+	clrbits_le32(priv->base + SNVS_LPCR, SNVS_LPCR_SRTC_ENV);
+
+	return readl_poll_timeout(priv->base + SNVS_LPCR, val,
+				  !(val & SNVS_LPCR_SRTC_ENV), 1000);
+}
+
+static int snvs_rtc_get(struct udevice *dev, struct rtc_time *tm)
+{
+	struct snvs_rtc_priv *priv = dev_get_priv(dev);
+	u64 read1, read2;
+
+	/* Require two identical consecutive reads as stated in manual */
+	do {
+		read1 = (u64)readl(priv->base + SNVS_LPSRTCMR) << 32ULL;
+		read1 |= readl(priv->base + SNVS_LPSRTCLR);
+
+		read2 = (u64)readl(priv->base + SNVS_LPSRTCMR) << 32ULL;
+		read2 |= readl(priv->base + SNVS_LPSRTCLR);
+	} while (read1 != read2);
+
+	/* Convert 47-bit counter to 32-bit raw second count */
+	rtc_to_tm((time_t)(read1 >> CNTR_TO_SECS_SH), tm);
+
+	return 0;
+}
+
+static int snvs_rtc_set(struct udevice *dev, const struct rtc_time *tm)
+{
+	struct snvs_rtc_priv *priv = dev_get_priv(dev);
+	u32 time = rtc_mktime(tm);
+	int ret;
+
+	ret = snvs_rtc_disable(dev);
+	if (ret)
+		return ret;
+
+	/* Write 32-bit time to 47-bit timer, leaving 15 LSBs blank */
+	writel(time << CNTR_TO_SECS_SH, priv->base + SNVS_LPSRTCLR);
+	writel(time >> (32 - CNTR_TO_SECS_SH), priv->base + SNVS_LPSRTCMR);
+
+	return snvs_rtc_enable(dev);
+}
+
+static const struct rtc_ops snvs_rtc_ops = {
+	.get	= snvs_rtc_get,
+	.set	= snvs_rtc_set,
+};
+
+static int snvs_rtc_probe(struct udevice *dev)
+{
+	struct snvs_rtc_priv *priv = dev_get_priv(dev);
+	u32 offset;
+	int ret;
+
+	priv->base = dev_read_addr(dev->parent);
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	ret = dev_read_u32(dev, "offset", &offset);
+	if (ret)
+		return ret;
+
+	priv->base += offset;
+
+	return snvs_rtc_enable(dev);
+}
+
+static const struct udevice_id snvs_rtc_ids[] = {
+	{ .compatible = "fsl,sec-v4.0-mon-rtc-lp" },
+	{ }
+};
+
+U_BOOT_DRIVER(rtc_snvs) = {
+	.name		= "rtc-snvs",
+	.id		= UCLASS_RTC,
+	.probe		= snvs_rtc_probe,
+	.of_match	= snvs_rtc_ids,
+	.ops		= &snvs_rtc_ops,
+	.priv_auto	= sizeof(struct snvs_rtc_priv),
+};
-- 
2.53.0

