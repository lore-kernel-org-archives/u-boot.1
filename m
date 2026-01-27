Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677DCD1953D
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 15:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D450284119;
	Tue, 27 Jan 2026 16:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FZpkFin6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7147884113; Tue, 27 Jan 2026 16:04:18 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F6EF840F8
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 16:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 833AD6014F;
 Tue, 27 Jan 2026 15:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D555C2BC86;
 Tue, 27 Jan 2026 15:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769526254;
 bh=vr4YGhUN4DDU8QLv0qcTZZOuR0htOl7/mMNahIbYpNA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FZpkFin6H3ChlqmjBNvBe9jtkNgLUbnrAb2qBw/gq+J4iDzyYRRip2br5cUBpf32H
 iJCHCtqsC9MIU7UqMQzJU4y3WFCUC6w1+XPNcNOZoEROtdmlVLGMYUHq+wQkr/jbSs
 LAvffZP5NDJ6bdp/DYJH7GCUPQeS5sqOhEQqax0r6kiBYls/41ZxaZ9kBGge0oV5cp
 wIkVw69RWLJTMbkMmGIHZg6YxSzsyxeuyWzq1UWnUVtOicYz2tsIWVQWdCVsURVj7K
 6jeLTQKGyh9jY40iaOFKDaEmWtvManJv706eCm+41kEjUN3cwcms8dOSvs4BpErqGC
 wclT6g32WbZaw==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 3/4] sysinfo: add driver for the Kontron SMARC-sAM67 board
Date: Tue, 27 Jan 2026 16:02:32 +0100
Message-ID: <20260127150401.1177176-4-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127150401.1177176-1-mwalle@kernel.org>
References: <20260127150401.1177176-1-mwalle@kernel.org>
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

The board has 3way strapping pins which are used to encode the board
variants. I.e. if it has a second ethernet interface or which RTC is
available.

Add a driver to query that information. The board code will use that
information to skip any unrelated device tree overlay. In the future,
this can also be used to select the correct base device tree.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/sysinfo/Kconfig  |   7 ++
 drivers/sysinfo/Makefile |   1 +
 drivers/sysinfo/sa67.c   | 149 +++++++++++++++++++++++++++++++++++++++
 include/sysinfo/sa67.h   |  21 ++++++
 4 files changed, 178 insertions(+)
 create mode 100644 drivers/sysinfo/sa67.c
 create mode 100644 include/sysinfo/sa67.h

diff --git a/drivers/sysinfo/Kconfig b/drivers/sysinfo/Kconfig
index df83df69ffb..0ba2e249430 100644
--- a/drivers/sysinfo/Kconfig
+++ b/drivers/sysinfo/Kconfig
@@ -31,6 +31,13 @@ config SYSINFO_RCAR3
 	help
 	  Support querying SoC version information for Renesas R-Car Gen3.
 
+config SYSINFO_SA67
+	bool "Enable sysinfo driver for the Kontron SMARC-sA67 board"
+	depends on TARGET_J722S_A53_SA67 || TARGET_J722S_R5_SA67
+	help
+	  Support querying board strapping options for the Kontron SMARC-sa67
+	  board.
+
 config SYSINFO_IOT2050
 	bool "Enable sysinfo driver for the Siemens IOT2050"
 	depends on TARGET_IOT2050_A53
diff --git a/drivers/sysinfo/Makefile b/drivers/sysinfo/Makefile
index 26ca3150999..541a4456b56 100644
--- a/drivers/sysinfo/Makefile
+++ b/drivers/sysinfo/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_SYSINFO_GAZERBEAM) += gazerbeam.o
 obj-$(CONFIG_SYSINFO_GPIO) += gpio.o
 obj-$(CONFIG_SYSINFO_IOT2050) += iot2050.o
 obj-$(CONFIG_SYSINFO_RCAR3) += rcar3.o
+obj-$(CONFIG_SYSINFO_SA67) += sa67.o
 obj-$(CONFIG_SYSINFO_SANDBOX) += sandbox.o
 obj-$(CONFIG_SYSINFO_SMBIOS) += smbios.o
diff --git a/drivers/sysinfo/sa67.c b/drivers/sysinfo/sa67.c
new file mode 100644
index 00000000000..1a3b8cd3dc9
--- /dev/null
+++ b/drivers/sysinfo/sa67.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <log.h>
+#include <sysinfo.h>
+#include <asm/gpio.h>
+#include <sysinfo/sa67.h>
+
+struct sysinfo_sa67_priv {
+	struct gpio_desc brdcfg_gpios[5];
+	struct gpio_desc rev_gpios[2];
+	int revision;
+	int brdcfg;
+};
+
+static int sysinfo_sa67_detect(struct udevice *dev)
+{
+	struct sysinfo_sa67_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = dm_gpio_get_values_as_int_base3_pctrl(dev,
+						    priv->rev_gpios,
+						    ARRAY_SIZE(priv->rev_gpios));
+	if (ret < 0)
+		return ret;
+
+	priv->revision = ret;
+
+	ret = dm_gpio_get_values_as_int_base3_pctrl(dev,
+						    priv->brdcfg_gpios,
+						    ARRAY_SIZE(priv->brdcfg_gpios));
+	if (ret < 0)
+		return ret;
+
+	priv->brdcfg = ret;
+
+	return 0;
+}
+
+static int sysinfo_sa67_get_bool(struct udevice *dev, int id, bool *val)
+{
+	struct sysinfo_sa67_priv *priv = dev_get_priv(dev);
+	int c0 = priv->brdcfg % 9;
+	int c1 = (priv->brdcfg / 9) % 9;
+
+	/*
+	 * This only supports the preconfigured table mode. There are also
+	 * custom board variants on the upper range.
+	 */
+	if (priv->brdcfg >= 81)
+		return -ENOENT;
+
+	switch (id) {
+	case BOARD_HAS_GBE1:
+		*val = c0 & 4;
+		break;
+	case BOARD_HAS_RTC_RV3032:
+		*val = !(c1 & 4);
+		break;
+	case BOARD_HAS_RTC_RV8263:
+		*val = c1 & 4;
+		break;
+	case BOARD_HAS_DP0:
+		*val = c1 & 1;
+		break;
+	case BOARD_HAS_DSI1:
+		*val = (c1 & 3) == 2;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static int sysinfo_sa67_get_int(struct udevice *dev, int id, int *val)
+{
+	struct sysinfo_sa67_priv *priv = dev_get_priv(dev);
+	int c0 = priv->brdcfg % 9;
+
+	if (priv->brdcfg >= 81)
+		return -ENOENT;
+
+	switch (id) {
+	case BOARD_REVISION:
+		*val = priv->revision;
+		break;
+	case BOARD_CFG:
+		*val = priv->brdcfg;
+		break;
+	case BOARD_MEMORY:
+		*val = 1 << (c0 & 3);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static int sysinfo_sa67_get_str(struct udevice *dev, int id, size_t size, char *val)
+{
+	return -ENOENT;
+};
+
+static const struct sysinfo_ops sysinfo_sa67_ops = {
+	.detect = sysinfo_sa67_detect,
+	.get_bool = sysinfo_sa67_get_bool,
+	.get_int = sysinfo_sa67_get_int,
+	.get_str = sysinfo_sa67_get_str,
+};
+
+static int sysinfo_sa67_probe(struct udevice *dev)
+{
+	struct sysinfo_sa67_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = gpio_request_list_by_name(dev, "revision-gpios", priv->rev_gpios,
+					ARRAY_SIZE(priv->rev_gpios),
+					GPIOD_IS_IN);
+	if (ret != ARRAY_SIZE(priv->rev_gpios)) {
+		debug("could not get revision-gpios (err = %d)\n", ret);
+		return ret;
+	}
+
+	ret = gpio_request_list_by_name(dev, "boardcfg-gpios", priv->brdcfg_gpios,
+					ARRAY_SIZE(priv->brdcfg_gpios),
+					GPIOD_IS_IN);
+	if (ret != ARRAY_SIZE(priv->brdcfg_gpios)) {
+		debug("could not get boardcfg-gpios (err = %d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id sysinfo_sa67_ids[] = {
+	{ .compatible = "kontron,sysinfo-sa67" },
+	{}
+};
+
+U_BOOT_DRIVER(sysinfo_sa67) = {
+	.name           = "sysinfo_sa67",
+	.id             = UCLASS_SYSINFO,
+	.of_match       = sysinfo_sa67_ids,
+	.ops		= &sysinfo_sa67_ops,
+	.priv_auto	= sizeof(struct sysinfo_sa67_priv),
+	.probe          = sysinfo_sa67_probe,
+};
diff --git a/include/sysinfo/sa67.h b/include/sysinfo/sa67.h
new file mode 100644
index 00000000000..28b87268e44
--- /dev/null
+++ b/include/sysinfo/sa67.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __SYSINFO_SA67_H
+#define __SYSINFO_SA67_H
+
+#include <sysinfo.h>
+
+enum {
+	BOARD_REVISION = SYSID_BOARD_MODEL,
+	BOARD_CFG = SYSID_USER,
+	BOARD_MEMORY,
+	BOARD_HAS_GBE1,
+	BOARD_HAS_LVDS1,
+	BOARD_HAS_DP0,
+	BOARD_HAS_EDP1,
+	BOARD_HAS_DSI1,
+	BOARD_HAS_RTC_RV3032,
+	BOARD_HAS_RTC_RV8263,
+};
+
+#endif /* __SYSINFO_SA67_H */
-- 
2.47.3

