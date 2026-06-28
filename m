Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3C0C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 17:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D9C0843B6;
	Sun, 28 Jun 2026 19:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="xJqbOpqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7859D84105; Sun, 28 Jun 2026 18:13:05 +0200 (CEST)
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A26805D7
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 18:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=cyberchaos.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yureka@cyberchaos.dev
From: Yureka <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
 s=mail; t=1782663182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EVOBqywYLX0N7a5oUpiaTox1yTeGdVjBuv9bTluJcF0=;
 b=xJqbOpqy/Dr0drHJv0zOL3QO4vPFZDd9by8+cZ4UR7cr5Gbvh3P2JbhyMVDbH5eOVw8ilw
 XGKMcqZzJz1PlNTJkQy+loPXESuctwZrhFFHqGZXrST6Va7hToTYNMt5GZKv4V7nbJAl0u
 N+uJURaT25v7PGga8xxAbeVeL/Q7IWo=
Date: Sun, 28 Jun 2026 18:11:13 +0200
Subject: [PATCH] power: domain: Add Apple PMP reporting driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-apple-pmp-report-v1-1-67b39539d879@cyberchaos.dev>
X-B4-Tracking: v=1; b=H4sIAKBHQWoC/yXMSw6CQBBF0a2QGlsJNAaFrRgG2P3QInwq1WBMC
 Hu31eEZ3LtThAkiNdlOhpdEWeaE4pSRf3bzAywhmVzuqrxyV+5UR7BOygZdbOVzqAP8pUTZO0q
 ZGnp5/5a39u+43Qf49fuh4/gAo1AtXXQAAAA=
X-Change-ID: 20260628-apple-pmp-report-4d9dec73e3f2
To: Janne Grunau <j@jannau.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Yureka <yureka@cyberchaos.dev>
X-Mailman-Approved-At: Sun, 28 Jun 2026 19:41:52 +0200
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

The Power Management Processor (PMP) is a coprocessor found on certain
Apple SoCs.

This is a dummy driver which allows for devices bound to a PMGR domain
through a PMP reporting domain to be powered on.
Powering on the PMP itself is not necessary during boot.

Tested on M3 Max (T6034) with the nvme device tree node using one of
the PMP reporting power domains.

Signed-off-by: Yureka <yureka@cyberchaos.dev>
---
 MAINTAINERS                             |  1 +
 drivers/power/domain/Kconfig            | 13 ++++++++++
 drivers/power/domain/Makefile           |  1 +
 drivers/power/domain/apple-pmp-report.c | 45 +++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af196465..ec0c2abd9c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -148,6 +148,7 @@ F:	drivers/pci/pcie_apple.c
 F:	drivers/phy/phy-apple-atc.c
 F:	drivers/pinctrl/pinctrl-apple.c
 F:	drivers/power/domain/apple-pmgr.c
+F:	drivers/power/domain/apple-pmp-report.c
 F:	drivers/spi/apple_spi.c
 F:	drivers/watchdog/apple_wdt.c
 F:	include/configs/apple.h
diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 4112b777371..06112d33660 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -18,6 +18,19 @@ config APPLE_PMGR_POWER_DOMAIN
 	  This driver is needed to power on parts of the SoC that have
 	  not been powered on by previous boot stages.
 
+config APPLE_PMP_REPORT_POWER_DOMAIN
+	bool "Enable the Apple PMP reporting power domain driver"
+	depends on POWER_DOMAIN
+	default y if ARCH_APPLE
+	help
+	  Enable support for reporting power states to the Apple Power
+	  Management Processor (PMP).
+
+	  This is a dummy driver since the PMP is entirely optional and
+	  enabling is not necessary during boot. However, it allows for
+	  devices bound to a PMGR domain through a PMP reporting domain to be
+	  powered on.
+
 config AGILEX5_PMGR_POWER_DOMAIN
 	bool "Enable the Agilex5 PMGR power domain driver"
 	depends on SPL_POWER_DOMAIN && ARCH_SOCFPGA_SOC64
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 110153d5cf8..3e9711aa430 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(PHASE_)POWER_DOMAIN) += power-domain-uclass.o
 obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) += apple-pmgr.o
+obj-$(CONFIG_APPLE_PMP_REPORT_POWER_DOMAIN) += apple-pmp-report.o
 obj-$(CONFIG_AGILEX5_PMGR_POWER_DOMAIN) += altr-pmgr-agilex5.o
 obj-$(CONFIG_BCM6328_POWER_DOMAIN) += bcm6328-power-domain.o
 obj-$(CONFIG_IMX8_POWER_DOMAIN) += imx8-power-domain-legacy.o imx8-power-domain.o
diff --git a/drivers/power/domain/apple-pmp-report.c b/drivers/power/domain/apple-pmp-report.c
new file mode 100644
index 00000000000..89fd81a7bd8
--- /dev/null
+++ b/drivers/power/domain/apple-pmp-report.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Yureka <yureka@cyberchaos.dev>
+ */
+
+#include <dm.h>
+#include <power-domain-uclass.h>
+
+static const struct udevice_id apple_pmp_report_ids[] = {
+	{ .compatible = "apple,t6000-pmp-v2-report" },
+	{ .compatible = "apple,t6020-pmp-v2-report" },
+	{ .compatible = "apple,t6030-pmp-v2-report" },
+	{ .compatible = "apple,t8112-pmp-v2-report" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(apple_pmp_report) = {
+	.name = "apple_pmp_report",
+	.id = UCLASS_NOP,
+	.of_match = apple_pmp_report_ids,
+	.bind = dm_scan_fdt_dev,
+};
+
+static int apple_pmp_report_entry_of_xlate(struct power_domain *power_domain,
+					   struct ofnode_phandle_args *args)
+{
+	return 0;
+}
+
+static const struct udevice_id apple_pmp_report_entry_ids[] = {
+	{ .compatible = "apple,t6000-pmp-v2-report-entry" },
+	{ .compatible = "apple-pmp-report-entry" },
+	{ /* sentinel */ }
+};
+
+struct power_domain_ops apple_pmp_report_entry_ops = {
+	.of_xlate = apple_pmp_report_entry_of_xlate,
+};
+
+U_BOOT_DRIVER(apple_pmp_report_entry) = {
+	.name = "apple_pmp_report_entry",
+	.id = UCLASS_POWER_DOMAIN,
+	.of_match = apple_pmp_report_entry_ids,
+	.ops = &apple_pmp_report_entry_ops,
+};

---
base-commit: 6902fb4c17faa375003124c451c2550deab5463d
change-id: 20260628-apple-pmp-report-4d9dec73e3f2

Best regards,
--  
Yureka <yureka@cyberchaos.dev>

