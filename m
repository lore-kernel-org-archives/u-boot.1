Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8639C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 30 Dec 2023 23:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942AE87719;
	Sun, 31 Dec 2023 00:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="m8N0xrkn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88C248747A; Sun, 31 Dec 2023 00:53:15 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8336D876DB
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 00:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6B8E041677; 
 Sat, 30 Dec 2023 23:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703980392;
 bh=TGY36uu1wPW1OWydW9JffPSHp5T/qLlU7nkryE9L1CI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=m8N0xrknmEjOhgdAWXotjvzD1NujPVAmZpexbp2BhLBTHd2A7oLcrWBuBdb6MukLI
 0blipyCx3ENjXz/r5e9aaNmxS5Kk6WyZ5RteqGyOOFidR2tKjib4OBsEobieTkiAOE
 HGBZVFkTQif7CoSWrBe6RwOJpLPDVejDY7fU6FXKeFFpUbFj5rPAcWQBsj+zqfF1PF
 PEqgqhk7onZfcfAPVe4YWRxoQ/bO20gmRBuc15YuNhaYvRyYVFKiNTyGxED2uJpKxs
 HG+JOF6c8smkAeHuuw8+N+rlq6f3+wUXa2O2dWUeNM+3pyhmvJa0DoaZwnFeCvwluW
 WsO5qj1LO+b8Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sergei Antonov <saproj@gmail.com>, Chris Packham <judge.packham@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] rtc: driver for Goldfish RTC
Date: Sun, 31 Dec 2023 00:53:00 +0100
Message-ID: <20231230235301.236868-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230235301.236868-1-heinrich.schuchardt@canonical.com>
References: <20231230235301.236868-1-heinrich.schuchardt@canonical.com>
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

The Goldfish RTC is a virtual device which may be supplied by QEMU.
It is enabled by default on QEMU's RISC-V virt machine.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/rtc/Kconfig        |   7 +++
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/goldfish_rtc.c | 105 +++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/rtc/goldfish_rtc.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 23173139e0..7fc53a6d61 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -122,6 +122,13 @@ config RTC_EMULATION
 	  CONFIG_BOOTP_NTPSERVER. The RTC time is advanced according to CPU
 	  ticks.
 
+config RTC_GOLDFISH
+	bool "Enable Goldfish driver"
+	depends on DM_RTC
+	help
+	  The Goldfish RTC is a virtual device which may be supplied by QEMU.
+	  It is enabled by default on QEMU's RISC-V virt machine.
+
 config RTC_ISL1208
 	bool "Enable ISL1208 driver"
 	depends on DM_RTC
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 308fab8da9..03a424c31a 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_RTC_DS1374) += ds1374.o
 obj-$(CONFIG_RTC_DS3231) += ds3231.o
 obj-$(CONFIG_RTC_DS3232) += ds3232.o
 obj-$(CONFIG_RTC_EMULATION) += emul_rtc.o
+obj-$(CONFIG_RTC_GOLDFISH) += goldfish_rtc.o
 obj-$(CONFIG_RTC_HT1380) += ht1380.o
 obj-$(CONFIG_$(SPL_TPL_)RTC_SANDBOX) += i2c_rtc_emul.o
 obj-$(CONFIG_RTC_ISL1208) += isl1208.o
diff --git a/drivers/rtc/goldfish_rtc.c b/drivers/rtc/goldfish_rtc.c
new file mode 100644
index 0000000000..99bbe9eaaf
--- /dev/null
+++ b/drivers/rtc/goldfish_rtc.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2023, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ *
+ * This driver emulates a real time clock based on timer ticks.
+ */
+
+#include <div64.h>
+#include <dm.h>
+#include <mapmem.h>
+#include <rtc.h>
+#include <linux/io.h>
+
+/**
+ * struct goldfish_rtc - private data for RTC driver
+ */
+struct goldfish_rtc {
+	/**
+	 * @base: base address for register file
+	 */
+	void __iomem *base;
+	/**
+	 * @isdst: daylight saving time
+	 */
+	int isdst;
+};
+
+/* Register offsets */
+#define GOLDFISH_TIME_LOW	0x00
+#define GOLDFISH_TIME_HIGH	0x04
+
+static int goldfish_rtc_get(struct udevice *dev, struct rtc_time *time)
+{
+	struct goldfish_rtc *priv = dev_get_priv(dev);
+	void __iomem *base = priv->base;
+	u64 time_high;
+	u64 time_low;
+	u64 now;
+
+	time_low = ioread32(base + GOLDFISH_TIME_LOW);
+	time_high = ioread32(base + GOLDFISH_TIME_HIGH);
+	now = (time_high << 32) | time_low;
+
+	do_div(now, 1000000000U);
+
+	rtc_to_tm(now, time);
+	time->tm_isdst = priv->isdst;
+
+	return 0;
+}
+
+static int goldfish_rtc_set(struct udevice *dev, const struct rtc_time *time)
+{
+	struct goldfish_rtc *priv = dev_get_priv(dev);
+	void __iomem *base = priv->base;
+	u64 now;
+
+	if (time->tm_year < 1970)
+		return -EINVAL;
+
+	now = rtc_mktime(time) * 1000000000ULL;
+	iowrite32(now >> 32, base + GOLDFISH_TIME_HIGH);
+	iowrite32(now, base + GOLDFISH_TIME_LOW);
+
+	if (time->tm_isdst > 0)
+		priv->isdst = 1;
+	else if (time->tm_isdst < 0)
+		priv->isdst = -1;
+	else
+		priv->isdst = 0;
+
+	return 0;
+}
+
+int goldfish_rtc_probe(struct udevice *dev)
+{
+	struct goldfish_rtc *priv = dev_get_priv(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	priv->base = map_sysmem(addr, 0x20);
+
+	return 0;
+}
+
+static const struct rtc_ops goldfish_rtc_ops = {
+	.get = goldfish_rtc_get,
+	.set = goldfish_rtc_set,
+};
+
+static const struct udevice_id goldfish_rtc_of_match[] = {
+	{ .compatible = "google,goldfish-rtc", },
+	{},
+};
+
+U_BOOT_DRIVER(rtc_goldfish) = {
+	.name		= "rtc_goldfish",
+	.id		= UCLASS_RTC,
+	.ops		= &goldfish_rtc_ops,
+	.probe		= goldfish_rtc_probe,
+	.of_match	= goldfish_rtc_of_match,
+	.priv_auto	= sizeof(struct goldfish_rtc),
+};
-- 
2.43.0

