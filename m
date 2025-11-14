Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA47CE7B1B
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 15:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D1684143;
	Fri, 14 Nov 2025 16:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GegN/oCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30E5D84105; Fri, 14 Nov 2025 16:13:06 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F231284133
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 16:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9421540AB0;
 Fri, 14 Nov 2025 15:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F019C4CEF8;
 Fri, 14 Nov 2025 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763133182;
 bh=xs9vW8JSzBWPTNh/F9Xa9yifS10xEKYKAZl+TH35H4U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GegN/oCPRveB2RDTZwY1P5Nv5T4o8K0rnHWfp/EsIdM0zLer868cyh/bCPiBuX0ft
 NlANR0RoHLLw6mPsz9mv7ZaIur7M09Ne6gsn5butysNFN/BIdph6FYW3fIKkzQPZp7
 EJHxJTvS33fwYeUIKXk5blslFjL0HF1V0uBZoj7l26JpG44lqpIfszfkv1bl3MScb1
 RN4FP4JYssSdGx4x+PxCNIryKsROX23uI2BCAQAqaBpJiWxnROP9C9N/WiSYQ+OhYM
 hCkuB8yLTTlYPV9k7jiPlb62+rhWQK7L6xhw10VZ7bRsQfrNuXoSFp/90+eJClTgfr
 u7TbKri5upRjA==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 1/2] drivers: rtc: add PCF85063 support
Date: Fri, 14 Nov 2025 16:12:47 +0100
Message-ID: <20251114151255.2008694-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114151255.2008694-1-mwalle@kernel.org>
References: <20251114151255.2008694-1-mwalle@kernel.org>
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
index ed903999f06..2336f2e57c9 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -161,6 +161,14 @@ config RTC_MAX313XX
 	  - Temperature sensor
 	  - CLKOUT generation
 
+config RTC_PCF85063
+	tristate "Enable PCF85063 driver"
+	depends on DM_I2C
+	depends on DM_RTC
+	help
+	  If you say yes here you get support for the NXP PCF85063 RTC
+	  and compatible chips.
+
 config RTC_PCF8563
 	tristate "Philips PCF8563"
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

