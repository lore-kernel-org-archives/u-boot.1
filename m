Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A83CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 23:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A7F849C9;
	Wed,  6 May 2026 01:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timmermann.space
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AECA849B8; Wed,  6 May 2026 01:14:09 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 502D58495B
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 01:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=timmermann.space
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uboot@timmermann.space
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g9Dpw1XqLz9vXD;
 Wed,  6 May 2026 01:14:00 +0200 (CEST)
From: Lukas Timmermann <uboot@timmermann.space>
Date: Wed, 06 May 2026 01:13:29 +0200
Subject: [PATCH RFC v3 1/2] pinctrl: exynos: Add exynos5250 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-pinctrl-exyno5250-v3-1-11649fe82210@timmermann.space>
References: <20260506-pinctrl-exyno5250-v3-0-11649fe82210@timmermann.space>
In-Reply-To: <20260506-pinctrl-exyno5250-v3-0-11649fe82210@timmermann.space>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, Minkyu Kang <mk7.kang@samsung.com>, 
 Lukas Timmermann <uboot@timmermann.space>
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
 MAINTAINERS                                 |  5 ++
 drivers/pinctrl/exynos/Kconfig              |  8 +++
 drivers/pinctrl/exynos/Makefile             |  1 +
 drivers/pinctrl/exynos/pinctrl-exynos5250.c | 99 +++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dcc7243124..475000e56da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -625,6 +625,11 @@ F:	drivers/clk/exynos/clk-exynos850.c
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
index 00000000000..8e34f46921a
--- /dev/null
+++ b/drivers/pinctrl/exynos/pinctrl-exynos5250.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Exynos5250 pinctrl driver.
+ *
+ * Copyright (c) 2026 Lukas Timmermann <uboot@timmermann.space>
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
+	.id		= UCLASS_PINCTRL,
+	.of_match	= exynos5250_pinctrl_ids,
+	.priv_auto	= sizeof(struct exynos_pinctrl_priv),
+	.ops		= &exynos5250_pinctrl_ops,
+	.probe		= exynos_pinctrl_probe,
+	.bind		= exynos_pinctrl_bind,
+};

-- 
2.54.0

