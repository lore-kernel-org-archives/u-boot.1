Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B67CE7B1E
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 15:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0D7A84141;
	Fri, 14 Nov 2025 16:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RKtQEfNO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF908414B; Fri, 14 Nov 2025 16:13:07 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4468584137
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 16:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1467160174;
 Fri, 14 Nov 2025 15:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0779C116B1;
 Fri, 14 Nov 2025 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763133183;
 bh=Wpldo3HVLfjFqSwFw02NgNuCH9TrQfw3sOIBVepyX98=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RKtQEfNOmLiGIdJnSFYlpL4jFgqaE7GBJSOZMWiQQRh+BJqU2KaAVsENFgrMcpPj4
 OfKkBgFRRuvYU2VQYbwvXUvir65BJ+bnGs+4DkVK2EVfO852dNHcAR/YhYsgw2mcLE
 nGJK1S/Mv91NNJCVJIv/Dsfu8hIB3U4o/KLpHAm/4q3Vxqhpdr9Wodq1wn0cWNPMD/
 K771aSyMROxLexLfpxTj8EUHtXe6HR+QtCaJHgIQn5LwSUgblXxPgY0Yv2EFRvoEvS
 1GuaxwpWhQ2T9oOYRJwP/+XQ3mIqvd0t1bEV/1ZNfNs0S2gygoPsI+GHHTJfYL0K4C
 DpbAHjrrlhBew==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 2/2] drivers: rtc: add RV3032 support
Date: Fri, 14 Nov 2025 16:12:48 +0100
Message-ID: <20251114151255.2008694-3-mwalle@kernel.org>
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

Add support for the Microcrystal RV3032 RTC.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/rtc/Kconfig  |   7 +++
 drivers/rtc/Makefile |   1 +
 drivers/rtc/rv3032.c | 121 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 drivers/rtc/rv3032.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 2336f2e57c9..c6c6a02221a 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -194,6 +194,13 @@ config RTC_RV3029
 	  This driver supports reading and writing the RTC/calendar and the
 	  battery-baced SRAM section.
 
+config RTC_RV3032
+	bool "Enable RV3032 driver"
+	depends on DM_RTC
+	help
+	  If you say yes here you get support for the Micro Crystal RV3032
+	  RTC.
+
 config RTC_RV8803
 	bool "Enable RV8803 driver"
 	depends on DM_RTC
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 9d84aa836a1..9df373d5148 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_RTC_PL031) += pl031.o
 obj-$(CONFIG_RTC_PT7C4338) += pt7c4338.o
 obj-$(CONFIG_RTC_RV3028) += rv3028.o
 obj-$(CONFIG_RTC_RV3029) += rv3029.o
+obj-$(CONFIG_RTC_RV3032) += rv3032.o
 obj-$(CONFIG_RTC_RV8803) += rv8803.o
 obj-$(CONFIG_RTC_RX8025) += rx8025.o
 obj-$(CONFIG_RTC_RX8010SJ) += rx8010sj.o
diff --git a/drivers/rtc/rv3032.c b/drivers/rtc/rv3032.c
new file mode 100644
index 00000000000..87ff5204e73
--- /dev/null
+++ b/drivers/rtc/rv3032.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Micro Crystal RV3032 I2C RTC driver
+ *
+ * Copyright (c) 2025 Kontron Europe GmbH.
+ */
+
+#include <dm.h>
+#include <i2c.h>
+#include <rtc.h>
+#include <dm/device_compat.h>
+
+#define RV3032_REG_SEC			0x01
+#define RV3032_REG_STATUS		0x0d
+#define RV3032_REG_STATUS_VLF		BIT(0)
+#define RV3032_REG_STATUS_PORF		BIT(1)
+
+static int rv3032_get_time(struct udevice *dev, struct rtc_time *tm)
+{
+	int ret, status;
+	u8 regs[7];
+
+	status = dm_i2c_reg_read(dev, RV3032_REG_STATUS);
+	if (status < 0)
+		return status;
+
+	if (status & (RV3032_REG_STATUS_PORF | RV3032_REG_STATUS_VLF)) {
+		dev_err(dev, "Power loss detected, Invalid time\n");
+		return -EINVAL;
+	}
+
+	ret = dm_i2c_read(dev, RV3032_REG_SEC, regs, sizeof(regs));
+	if (ret)
+		return ret;
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
+static int rv3032_set_time(struct udevice *dev, const struct rtc_time *tm)
+{
+	u8 regs[7];
+	int ret;
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
+	ret = dm_i2c_write(dev, RV3032_REG_SEC, regs, sizeof(regs));
+	if (ret)
+		return ret;
+
+	return dm_i2c_reg_clrset(dev, RV3032_REG_STATUS,
+				 RV3032_REG_STATUS_PORF | RV3032_REG_STATUS_VLF,
+				 0);
+}
+
+static int rv3032_read(struct udevice *dev, unsigned int offset, u8 *buf,
+		       unsigned int len)
+{
+	return dm_i2c_read(dev, offset, buf, len);
+}
+
+static int rv3032_write(struct udevice *dev, unsigned int offset,
+			const u8 *buf, unsigned int len)
+{
+	return dm_i2c_write(dev, offset, buf, len);
+}
+
+static int rv3032_reset(struct udevice *dev)
+{
+	/*
+	 * There is no reset, but the "date reset" command needs this op to
+	 * actually set the default time
+	 */
+	return 0;
+}
+
+static const struct rtc_ops rv3032_rtc_ops = {
+	.get = rv3032_get_time,
+	.set = rv3032_set_time,
+	.read = rv3032_read,
+	.write = rv3032_write,
+	.reset = rv3032_reset,
+};
+
+static int rv3032_probe(struct udevice *dev)
+{
+	i2c_set_chip_flags(dev, DM_I2C_CHIP_RD_ADDRESS | DM_I2C_CHIP_WR_ADDRESS);
+
+	return 0;
+}
+
+static const struct udevice_id rv3032_of_id[] = {
+	{ .compatible = "microcrystal,rv3032" },
+	{ }
+};
+
+U_BOOT_DRIVER(rtc_rv3032) = {
+	.name	= "rtc-rv3032",
+	.id     = UCLASS_RTC,
+	.probe  = rv3032_probe,
+	.of_match = rv3032_of_id,
+	.ops    = &rv3032_rtc_ops,
+};
-- 
2.47.3

