Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EB9CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 19:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08E5836D1;
	Mon,  3 Nov 2025 20:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timmermann.space
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43AED838CE; Mon,  3 Nov 2025 20:15:18 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D308331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 20:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=timmermann.space
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uboot@timmermann.space
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d0h9w02vZz9tGx;
 Mon,  3 Nov 2025 20:15:16 +0100 (CET)
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of uboot@timmermann.space designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=uboot@timmermann.space
From: Lukas Timmermann <uboot@timmermann.space>
To: u-boot@lists.denx.de
Cc: Lukas Timmermann <uboot@timmermann.space>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 2/2] pinctrl: exynos: Add exynos5250 driver
Date: Mon,  3 Nov 2025 20:10:36 +0100
Message-ID: <20251103191427.2410755-3-uboot@timmermann.space>
In-Reply-To: <20251103191427.2410755-1-uboot@timmermann.space>
References: <20251103191427.2410755-1-uboot@timmermann.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4d0h9w02vZz9tGx
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

Adds the needed files for using the new pinctrl driver with exynos5250
SoCs.

Signed-off-by: Lukas Timmermann <uboot@timmermann.space>
---

Changes since v1:
- Renamed to lower case letters in constants (@Hendrik)
- Removed co-author line and declared myself as author (@Hendrik)

 MAINTAINERS                                 |  5 ++
 drivers/pinctrl/exynos/Kconfig              |  8 ++
 drivers/pinctrl/exynos/Makefile             |  1 +
 drivers/pinctrl/exynos/pinctrl-exynos5250.c | 99 +++++++++++++++++++++
 4 files changed, 113 insertions(+)
 create mode 100644 drivers/pinctrl/exynos/pinctrl-exynos5250.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c7d0e0ab2f..b82911d0d58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -609,6 +609,11 @@ F:	drivers/clk/exynos/clk-exynos850.c
 F:	drivers/phy/phy-exynos-usbdrd.c
 F:	drivers/pinctrl/exynos/pinctrl-exynos850.c
 
+ARM SAMSUNG EXYNOS5250 SOC
+M:	Lukas Timmermann <uboot@timmermann.space>
+S:	Maintained
+F:	drivers/pinctrl/exynos/pinctrl-exynos5250.c
+
 ARM SAMSUNG SOC DRIVERS
 M:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
diff --git a/drivers/pinctrl/exynos/Kconfig b/drivers/pinctrl/exynos/Kconfig
index 1b7fb62bc4b..18503ce112e 100644
--- a/drivers/pinctrl/exynos/Kconfig
+++ b/drivers/pinctrl/exynos/Kconfig
@@ -1,6 +1,14 @@
 config PINCTRL_EXYNOS
 	bool
 
+config PINCTRL_EXYNOS5250
+	bool "Samsung Exynos5250 pinctrl driver"
+	depends on ARCH_EXYNOS && PINCTRL_FULL
+	select PINCTRL_EXYNOS
+	help
+	  Support pin multiplexing and pin configuration control on
+	  Samsung's Exynos5250 SoC.
+
 config PINCTRL_EXYNOS7420
 	bool "Samsung Exynos7420 pinctrl driver"
 	depends on ARCH_EXYNOS && PINCTRL_FULL
diff --git a/drivers/pinctrl/exynos/Makefile b/drivers/pinctrl/exynos/Makefile
index 3abe1226eb7..7ef8d90cb59 100644
--- a/drivers/pinctrl/exynos/Makefile
+++ b/drivers/pinctrl/exynos/Makefile
@@ -4,6 +4,7 @@
 # Thomas Abraham <thomas.ab@samsung.com>
 
 obj-$(CONFIG_PINCTRL_EXYNOS)		+= pinctrl-exynos.o
+obj-$(CONFIG_PINCTRL_EXYNOS5250)	+= pinctrl-exynos5250.o
 obj-$(CONFIG_PINCTRL_EXYNOS7420)	+= pinctrl-exynos7420.o
 obj-$(CONFIG_PINCTRL_EXYNOS78x0)	+= pinctrl-exynos78x0.o
 obj-$(CONFIG_PINCTRL_EXYNOS850)		+= pinctrl-exynos850.o
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos5250.c b/drivers/pinctrl/exynos/pinctrl-exynos5250.c
new file mode 100644
index 00000000000..4c0d8fad36e
--- /dev/null
+++ b/drivers/pinctrl/exynos/pinctrl-exynos5250.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Linaro Ltd.
+ * Author: Lukas Timmermann <linux@timmermann.space>
+ *
+ * Exynos5250 pinctrl driver.
+ */
+
+#include <dm.h>
+#include <dm/pinctrl.h>
+#include "pinctrl-exynos.h"
+
+static const struct pinctrl_ops exynos5250_pinctrl_ops = {
+	.set_state = exynos_pinctrl_set_state
+};
+
+static const struct samsung_pin_bank_data exynos5250_pin_banks0[] = {
+	EXYNOS_PIN_BANK(8, 0x000, "gpa0"),
+	EXYNOS_PIN_BANK(6, 0x020, "gpa1"),
+	EXYNOS_PIN_BANK(8, 0x040, "gpa2"),
+	EXYNOS_PIN_BANK(5, 0x060, "gpb0"),
+	EXYNOS_PIN_BANK(5, 0x080, "gpb1"),
+	EXYNOS_PIN_BANK(4, 0x0a0, "gpb2"),
+	EXYNOS_PIN_BANK(4, 0x0c0, "gpb3"),
+	EXYNOS_PIN_BANK(7, 0x0e0, "gpc0"),
+	EXYNOS_PIN_BANK(4, 0x100, "gpc1"),
+	EXYNOS_PIN_BANK(7, 0x120, "gpc2"),
+	EXYNOS_PIN_BANK(7, 0x140, "gpc3"),
+	EXYNOS_PIN_BANK(4, 0x160, "gpd0"),
+	EXYNOS_PIN_BANK(8, 0x180, "gpd1"),
+	EXYNOS_PIN_BANK(7, 0x2e0, "gpc4"),
+	EXYNOS_PIN_BANK(6, 0x1a0, "gpy0"),
+	EXYNOS_PIN_BANK(4, 0x1c0, "gpy1"),
+	EXYNOS_PIN_BANK(6, 0x1e0, "gpy2"),
+	EXYNOS_PIN_BANK(8, 0x200, "gpy3"),
+	EXYNOS_PIN_BANK(8, 0x220, "gpy4"),
+	EXYNOS_PIN_BANK(8, 0x240, "gpy5"),
+	EXYNOS_PIN_BANK(8, 0x260, "gpy6"),
+	EXYNOS_PIN_BANK(8, 0xc00, "gpx0"),
+	EXYNOS_PIN_BANK(8, 0xc20, "gpx1"),
+	EXYNOS_PIN_BANK(8, 0xc40, "gpx2"),
+	EXYNOS_PIN_BANK(8, 0xc60, "gpx3"),
+};
+
+static const struct samsung_pin_bank_data exynos5250_pin_banks1[] = {
+	EXYNOS_PIN_BANK(8, 0x000, "gpe0"),
+	EXYNOS_PIN_BANK(2, 0x020, "gpe1"),
+	EXYNOS_PIN_BANK(4, 0x040, "gpf0"),
+	EXYNOS_PIN_BANK(4, 0x060, "gpf1"),
+	EXYNOS_PIN_BANK(8, 0x080, "gpg0"),
+	EXYNOS_PIN_BANK(8, 0x0a0, "gpg1"),
+	EXYNOS_PIN_BANK(2, 0x0c0, "gpg2"),
+	EXYNOS_PIN_BANK(4, 0x0e0, "gph0"),
+	EXYNOS_PIN_BANK(8, 0x100, "gph1"),
+};
+
+static const struct samsung_pin_bank_data exynos5250_pin_banks2[] = {
+	EXYNOS_PIN_BANK(8, 0x000, "gpv0"),
+	EXYNOS_PIN_BANK(8, 0x020, "gpv1"),
+	EXYNOS_PIN_BANK(8, 0x060, "gpv2"),
+	EXYNOS_PIN_BANK(8, 0x080, "gpv3"),
+	EXYNOS_PIN_BANK(2, 0x0c0, "gpv4"),
+};
+
+static const struct samsung_pin_bank_data exynos5250_pin_banks3[] = {
+	EXYNOS_PIN_BANK(7, 0x000, "gpz"),
+};
+
+static const struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
+	{
+		.pin_banks	= exynos5250_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks0),
+	}, {
+		.pin_banks	= exynos5250_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks1),
+	}, {
+		.pin_banks	= exynos5250_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks2),
+	}, {
+		.pin_banks	= exynos5250_pin_banks3,
+		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks3),
+	},
+	{/* list terminator */}
+};
+
+static const struct udevice_id exynos5250_pinctrl_ids[] = {
+	{ .compatible = "samsung,exynos5250-pinctrl",
+		.data = (ulong)exynos5250_pin_ctrl },
+	{ }
+};
+
+U_BOOT_DRIVER(pinctrl_exynos5250) = {
+	.name		= "pinctrl_exynos5250",
+	.id			= UCLASS_PINCTRL,
+	.of_match	= exynos5250_pinctrl_ids,
+	.priv_auto	= sizeof(struct exynos_pinctrl_priv),
+	.ops		= &exynos5250_pinctrl_ops,
+	.probe		= exynos_pinctrl_probe,
+};
-- 
2.51.2

