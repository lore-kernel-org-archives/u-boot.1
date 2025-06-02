Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CA5C5B555
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 16:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4B681F32;
	Mon,  2 Jun 2025 18:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8505681FEE; Mon,  2 Jun 2025 18:25:22 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FFAD80F9C
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 18:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uM7yQ-007UhY-1Q;
 Mon, 02 Jun 2025 16:25:18 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Vincent Fazio <vfazio@xes-inc.com>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] rtc: add ds1672 driver
Date: Mon,  2 Jun 2025 09:25:15 -0700
Message-Id: <20250602162515.1316263-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add support for Dallas/Maxim ds1672 32bit counter RTC.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/rtc/Kconfig  |   7 +++
 drivers/rtc/Makefile |   1 +
 drivers/rtc/ds1672.c | 117 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 drivers/rtc/ds1672.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 6467f20422be..79b879d68d1b 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -94,6 +94,13 @@ config RTC_DS1374
 	  Support for Dallas Semiconductor (now Maxim) DS1374 and compatible
 	  Real Time Clock devices.
 
+config RTC_DS1672
+	bool "Enable DS1672 driver"
+	depends on DM_RTC
+	help
+	  Support for Dallas Semiconductor (now Maxim) DS1672 compatible
+	  Real Time Clock devices.
+
 config RTC_DS3231
 	bool "Enable DS3231 driver"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 99b5a2a346a9..a4ede413cd17 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_RTC_DS1307) += ds1307.o
 obj-$(CONFIG_RTC_DS1338) += ds1307.o
 obj-$(CONFIG_RTC_DS1337) += ds1337.o
 obj-$(CONFIG_RTC_DS1374) += ds1374.o
+obj-$(CONFIG_RTC_DS1672) += ds1672.o
 obj-$(CONFIG_RTC_DS3231) += ds3231.o
 obj-$(CONFIG_RTC_DS3232) += ds3232.o
 obj-$(CONFIG_RTC_EMULATION) += emul_rtc.o
diff --git a/drivers/rtc/ds1672.c b/drivers/rtc/ds1672.c
new file mode 100644
index 000000000000..4705e5abc932
--- /dev/null
+++ b/drivers/rtc/ds1672.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices DS1672 I2C RTC driver
+ *
+ * Copyright 2025 Gateworks Corporation.
+ */
+#include <dm.h>
+#include <i2c.h>
+#include <rtc.h>
+#include <dm/device_compat.h>
+
+/* Registers */
+#define DS1672_REG_CNT_BASE	0
+#define DS1672_REG_CONTROL	4
+#define DS1672_REG_TRICKLE	5
+
+#define DS1672_REG_CONTROL_EOSC	0x80
+
+static int ds1672_read_time(struct udevice *dev, struct rtc_time *tm)
+{
+	time64_t secs;
+	u8 regs[4];
+	int ret;
+
+	ret = dm_i2c_read(dev, DS1672_REG_CONTROL, regs, 1);
+	if (ret)
+		return ret;
+
+	if (regs[0] & DS1672_REG_CONTROL_EOSC) {
+		dev_err(dev, "Oscillator not enabled. Set time to enable.\n");
+		return -EINVAL;
+	}
+
+	ret = dm_i2c_read(dev, DS1672_REG_CNT_BASE, regs, 4);
+	if (ret)
+		return ret;
+	dev_dbg(dev, "raw read: 0x%02x 0x%02x 0x%02x 0x%02x\n",
+		regs[0], regs[1], regs[2], regs[3]);
+	secs = ((unsigned long)regs[3] << 24) | (regs[2] << 16) | (regs[1] << 8) | regs[0];
+	rtc_to_tm(secs, tm);
+
+	dev_dbg(dev, "read %lld %4d-%02d-%02d (wday=%d) %2d:%02d:%02d\n", secs,
+		tm->tm_year, tm->tm_mon, tm->tm_mday,
+		tm->tm_wday, tm->tm_hour, tm->tm_min, tm->tm_sec);
+
+	return 0;
+}
+
+static int ds1672_set_time(struct udevice *dev, const struct rtc_time *tm)
+{
+	time64_t secs = rtc_mktime(tm);
+	u8 regs[5];
+
+	dev_dbg(dev, "set %4d-%02d-%02d (wday=%d) %2d:%02d:%02d %lld\n",
+		tm->tm_year, tm->tm_mon, tm->tm_mday,
+		tm->tm_wday, tm->tm_hour, tm->tm_min, tm->tm_sec,
+		secs);
+
+	if (tm->tm_year < 2000) {
+		dev_err(dev, "year %d (before 2000) not supported\n",
+			tm->tm_year);
+		return -EINVAL;
+	}
+
+	regs[0] = secs & 0x000000ff;
+	regs[1] = (secs & 0x0000ff00) >> 8;
+	regs[2] = (secs & 0x00ff0000) >> 16;
+	regs[3] = (secs & 0xff000000) >> 24;
+	regs[4] = 0; /* set control reg to enable counting */
+
+	return dm_i2c_write(dev, DS1672_REG_CNT_BASE, regs, 5);
+}
+
+static int ds1672_reset(struct udevice *dev)
+{
+	u8 regs[5] = { 0 };
+
+	return dm_i2c_write(dev, DS1672_REG_CNT_BASE, regs, 5);
+}
+
+static int ds1672_read8(struct udevice *dev, unsigned int reg)
+{
+	return  dm_i2c_reg_read(dev, reg);
+}
+
+static int ds1672_write8(struct udevice *dev, unsigned int reg, int val)
+{
+	return dm_i2c_reg_write(dev, reg, val);
+}
+
+static const struct rtc_ops ds1672_rtc_ops = {
+	.get	= ds1672_read_time,
+	.set	= ds1672_set_time,
+	.reset  = ds1672_reset,
+	.read8	= ds1672_read8,
+	.write8	= ds1672_write8,
+};
+
+static int ds1672_probe(struct udevice *dev)
+{
+	i2c_set_chip_flags(dev, DM_I2C_CHIP_RD_ADDRESS | DM_I2C_CHIP_WR_ADDRESS);
+
+	return 0;
+}
+
+static const struct udevice_id ds1672_of_id[] = {
+	{ .compatible = "dallas,ds1672" },
+	{ }
+};
+
+U_BOOT_DRIVER(rtc_max313xx) = {
+	.name	= "rtc-ds1672",
+	.id     = UCLASS_RTC,
+	.probe  = ds1672_probe,
+	.of_match = ds1672_of_id,
+	.ops    = &ds1672_rtc_ops,
+};
-- 
2.25.1

