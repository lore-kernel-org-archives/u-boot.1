Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31D9CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 10:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B8E783B2C;
	Mon, 17 Nov 2025 11:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qQb5zNID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B5DF83B97; Mon, 17 Nov 2025 11:33:31 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5207783B7F
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 11:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 50862601D8;
 Mon, 17 Nov 2025 10:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E479AC4CEF5;
 Mon, 17 Nov 2025 10:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763375607;
 bh=42Z2xIN6hXp4ZdBF25pOKZnrzu0fVexawwkSutVmznY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qQb5zNIDOeagb891weJwogSB9VqKLNbHHjgZIItxAxLm/hxr1KbfcUL/gcKidXU+D
 yAXjJknwn34a+56CfdCsbCtdEbSUuNKqre37MKxJavv58gQ9aSW9dt6kn6aY5mjFFk
 5xTaDx28FvfB6D9ReWlkrccpbKJJ9fuxYU5vrcHr3SyWnKnYtz5CSiwTq3PFi3dwyS
 Qq1mGyYy9HI2dPsw4M/yTPxV6EXJIJE7MhO7RMl5VlsF/jwYHy+XkJOsSWeDDv56wf
 Oc+cYEL1CycHUK4n4Jt8bbilRvZgiSX1/XQdqau4cX8V/dFnZ2dgmOa9k94AgugBZb
 FFuW5p8RyocFg==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 2/3] drivers: rtc: add PCF85063 support
Date: Mon, 17 Nov 2025 11:32:51 +0100
Message-ID: <20251117103315.2212686-3-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117103315.2212686-1-mwalle@kernel.org>
References: <20251117103315.2212686-1-mwalle@kernel.org>
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

Add support for the Microcrystal RV8263 and compatible RTCs. The
driver's name was taken from linux. It should work with any NXP PCF85063
compatible RTCs. It was tested with a RV8263.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/rtc/Kconfig    |   8 +++
 drivers/rtc/Makefile   |   1 +
 drivers/rtc/pcf85063.c | 107 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 drivers/rtc/pcf85063.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 202daa7bcd6..f8421e3bf58 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -161,6 +161,14 @@ config RTC_MAX313XX
 	  - Temperature sensor
 	  - CLKOUT generation
 
+config RTC_PCF85063
+	bool "Enable PCF85063 driver"
+	depends on DM_I2C
+	depends on DM_RTC
+	help
+	  If you say yes here you get support for the NXP PCF85063 RTC
+	  and compatible chips.
+
 config RTC_PCF8563
 	bool "Philips PCF8563"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index a4ede413cd1..9d84aa836a1 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_RTC_MC146818) += mc146818.o
 obj-$(CONFIG_MCFRTC) += mcfrtc.o
 obj-$(CONFIG_RTC_MV) += mvrtc.o
 obj-$(CONFIG_RTC_MXS) += mxsrtc.o
+obj-$(CONFIG_RTC_PCF85063) += pcf85063.o
 obj-$(CONFIG_RTC_PCF8563) += pcf8563.o
 obj-$(CONFIG_RTC_PCF2127) += pcf2127.o
 obj-$(CONFIG_RTC_PL031) += pl031.o
diff --git a/drivers/rtc/pcf85063.c b/drivers/rtc/pcf85063.c
new file mode 100644
index 00000000000..737d4547aca
--- /dev/null
+++ b/drivers/rtc/pcf85063.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCF85063 and compatible I2C RTC driver
+ *
+ * Copyright (c) 2025 Kontron Europe GmbH.
+ */
+
+#include <dm.h>
+#include <i2c.h>
+#include <rtc.h>
+#include <dm/device_compat.h>
+
+#define PCF85063_REG_CTRL1		0x00 /* status */
+#define PCF85063_REG_CTRL1_SR		0x58
+
+#define PCF85063_REG_SC			0x04 /* datetime */
+#define PCF85063_REG_SC_OS		0x80
+
+static int pcf85063_get_time(struct udevice *dev, struct rtc_time *tm)
+{
+	u8 regs[7];
+	int ret;
+
+	ret = dm_i2c_read(dev, PCF85063_REG_SC, regs, sizeof(regs));
+	if (ret)
+		return ret;
+
+	if (regs[0] & PCF85063_REG_SC_OS) {
+		dev_err(dev, "Power loss detected, Invalid time\n");
+		return -EINVAL;
+	}
+
+	tm->tm_sec = bcd2bin(regs[0] & 0x7f);
+	tm->tm_min = bcd2bin(regs[1] & 0x7f);
+	tm->tm_hour = bcd2bin(regs[2] & 0x3f);
+	tm->tm_mday = bcd2bin(regs[3] & 0x3f);
+	tm->tm_wday = regs[4] & 0x07;
+	tm->tm_mon = bcd2bin(regs[5] & 0x1f) - 1;
+	tm->tm_year = bcd2bin(regs[6]) + 2000;
+
+	return 0;
+}
+
+static int pcf85063_set_time(struct udevice *dev, const struct rtc_time *tm)
+{
+	u8 regs[7];
+
+	if (tm->tm_year < 2000 || tm->tm_year > 2099) {
+		dev_err(dev, "Year must be between 2000 and 2099.\n");
+		return -EINVAL;
+	}
+
+	regs[0] = bin2bcd(tm->tm_sec);
+	regs[1] = bin2bcd(tm->tm_min);
+	regs[2] = bin2bcd(tm->tm_hour);
+	regs[3] = bin2bcd(tm->tm_mday);
+	regs[4] = tm->tm_wday;
+	regs[5] = bin2bcd(tm->tm_mon + 1);
+	regs[6] = bin2bcd(tm->tm_year % 100);
+
+	return dm_i2c_write(dev, PCF85063_REG_SC, regs, sizeof(regs));
+}
+
+static int pcf85063_reset(struct udevice *dev)
+{
+	return dm_i2c_reg_write(dev, PCF85063_REG_CTRL1, PCF85063_REG_CTRL1_SR);
+}
+
+static int pcf85063_read(struct udevice *dev, unsigned int offset, u8 *buf,
+			 unsigned int len)
+{
+	return dm_i2c_read(dev, offset, buf, len);
+}
+
+static int pcf85063_write(struct udevice *dev, unsigned int offset,
+			  const u8 *buf, unsigned int len)
+{
+	return dm_i2c_write(dev, offset, buf, len);
+}
+
+static const struct rtc_ops pcf85063_rtc_ops = {
+	.get = pcf85063_get_time,
+	.set = pcf85063_set_time,
+	.reset = pcf85063_reset,
+	.read = pcf85063_read,
+	.write = pcf85063_write,
+};
+
+static int pcf85063_probe(struct udevice *dev)
+{
+	i2c_set_chip_flags(dev, DM_I2C_CHIP_RD_ADDRESS | DM_I2C_CHIP_WR_ADDRESS);
+
+	return 0;
+}
+
+static const struct udevice_id pcf85063_of_id[] = {
+	{ .compatible = "microcrystal,rv8263" },
+	{ }
+};
+
+U_BOOT_DRIVER(rtc_pcf85063) = {
+	.name	= "rtc-pcf85063",
+	.id     = UCLASS_RTC,
+	.probe  = pcf85063_probe,
+	.of_match = pcf85063_of_id,
+	.ops    = &pcf85063_rtc_ops,
+};
-- 
2.47.3

