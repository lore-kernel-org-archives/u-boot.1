Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A75BCA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 09:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0030D86E63;
	Tue, 12 Sep 2023 11:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Popj5cHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B51B086B33; Tue, 12 Sep 2023 11:47:38 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 51E0986E2F
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 11:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 42AD9212BC12;
 Tue, 12 Sep 2023 02:47:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42AD9212BC12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1694512052;
 bh=2Ik9eFgMq0SCtK4Le5N0CtoMIHPouPns8LnTViJgg+U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Popj5cHDONpzJQkmXUSQDDUT+w8tdMyZmw/Fhl6FWbddr8dfF0XaQtmAnszGkuT4t
 cQdSI2wrqPGLSkCCqdYjCqeDGtzwoKCmpcvBdgSWwz8LmDdb8F42+uJXYyWzvv8mAM
 fACmxglxKSdGNym40QRzeafHi2YiUA2Vk526nfJs=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, stcarlso@linux.microsoft.com, ilias.apalodimas@linaro.org
Subject: [PATCH 1/8] drivers: rollback: Add rollback devices to driver model
Date: Tue, 12 Sep 2023 02:47:24 -0700
Message-Id: <20230912094731.51413-2-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
References: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
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

From: Stephen Carlson <stcarlso@linux.microsoft.com>

Rollback devices currently implement operations to store an OS
anti-rollback monotonic counter. Existing devices such as the Trusted
Platform Module (TPM) already support this operation, but this uclass
provides abstraction for current and future devices that may support
different features.

- New Driver Model uclass UCLASS_ROLLBACK.
- New config CONFIG_DM_ROLLBACK to enable security device support.
- New driver rollback-sandbox matching "rollback,sandbox", enabled with
  new config CONFIG_ROLLBACK_SANDBOX.

Signed-off-by: Stephen Carlson <stcarlso@linux.microsoft.com>
Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 MAINTAINERS                         |  9 ++++
 drivers/Kconfig                     |  2 +
 drivers/Makefile                    |  1 +
 drivers/rollback/Kconfig            | 25 +++++++++++
 drivers/rollback/Makefile           |  6 +++
 drivers/rollback/rollback-sandbox.c | 65 +++++++++++++++++++++++++++++
 drivers/rollback/rollback-uclass.c  | 30 +++++++++++++
 include/dm/uclass-id.h              |  1 +
 include/rollback.h                  | 42 +++++++++++++++++++
 9 files changed, 181 insertions(+)
 create mode 100644 drivers/rollback/Kconfig
 create mode 100644 drivers/rollback/Makefile
 create mode 100644 drivers/rollback/rollback-sandbox.c
 create mode 100644 drivers/rollback/rollback-uclass.c
 create mode 100644 include/rollback.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bf851cffd6..de14724c27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1438,6 +1438,15 @@ F:	cmd/seama.c
 F:	doc/usage/cmd/seama.rst
 F:	test/cmd/seama.c
 
+ROLLBACK
+M:	Stephen Carlson <stcarlso@linux.microsoft.com>
+M:	Sean Edmond <seanedmond@microsoft.com>
+S:	Maintained
+F:	drivers/rollback/Kconfig
+F:	drivers/rollback/Makefile
+F:	drivers/rollback/rollback-sandbox.c
+F:	drivers/rollback/rollback-uclass.c
+
 SEMIHOSTING
 R:	Sean Anderson <sean.anderson@seco.com>
 S:	Orphaned
diff --git a/drivers/Kconfig b/drivers/Kconfig
index a25f6ae02f..faa7cbb72b 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -116,6 +116,8 @@ source "drivers/rtc/Kconfig"
 
 source "drivers/scsi/Kconfig"
 
+source "drivers/rollback/Kconfig"
+
 source "drivers/serial/Kconfig"
 
 source "drivers/smem/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index efc2a4afb2..f6cfb48cb6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_PCH) += pch/
 obj-$(CONFIG_DM_REBOOT_MODE) += reboot-mode/
 obj-y += rtc/
 obj-y += scsi/
+obj-y += rollback/
 obj-y += sound/
 obj-y += spmi/
 obj-y += watchdog/
diff --git a/drivers/rollback/Kconfig b/drivers/rollback/Kconfig
new file mode 100644
index 0000000000..31f5a3f56d
--- /dev/null
+++ b/drivers/rollback/Kconfig
@@ -0,0 +1,25 @@
+config DM_ROLLBACK
+	bool "Support rollback devices with driver model"
+	depends on DM
+	help
+	  This option enables support for the rollback uclass which supports
+	  devices intended to provide the anti-rollback feature during
+	  boot. These devices might encapsulate existing features of TPM
+	  or TEE devices, but can also be dedicated security processors
+	  implemented in specific hardware.
+
+config ROLLBACK_SANDBOX
+	bool "Enable sandbox rollback driver"
+	depends on DM_ROLLBACK
+	help
+	  This driver supports a simulated rollback device that uses volatile
+	  memory to store secure data and begins uninitialized. This
+	  implementation allows OS images with security requirements to be
+	  loaded in the sandbox environment.
+
+config ROLLBACK_TPM
+	bool "Enable TPM rollback driver"
+	depends on TPM && TPM_V2 && DM_ROLLBACK
+	help
+	  This driver supports a rollback device based on existing TPM
+	  functionality.
diff --git a/drivers/rollback/Makefile b/drivers/rollback/Makefile
new file mode 100644
index 0000000000..4e7fa46041
--- /dev/null
+++ b/drivers/rollback/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2021 Microsoft, Inc.
+
+obj-$(CONFIG_DM_ROLLBACK) += rollback-uclass.o
+obj-$(CONFIG_ROLLBACK_SANDBOX) += rollback-sandbox.o
diff --git a/drivers/rollback/rollback-sandbox.c b/drivers/rollback/rollback-sandbox.c
new file mode 100644
index 0000000000..acbe6d2303
--- /dev/null
+++ b/drivers/rollback/rollback-sandbox.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2021 Microsoft, Inc
+ * Written by Stephen Carlson <stcarlso@microsoft.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <fdtdec.h>
+#include <rollback.h>
+
+static struct rollback_state {
+	u64 rollback_idx;
+};
+
+static int sb_rollback_idx_get(struct udevice *dev, u64 *rollback_idx)
+{
+	struct rollback_state *priv = dev_get_priv(dev);
+
+	if (!rollback_idx)
+		return -EINVAL;
+
+	*rollback_idx = priv->rollback_idx;
+	return 0;
+}
+
+static int sb_rollback_idx_set(struct udevice *dev, u64 rollback_idx)
+{
+	struct rollback_state *priv = dev_get_priv(dev);
+	u64 old_rollback_idx;
+
+	old_rollback_idx = priv->rollback_idx;
+	if (rollback_idx < old_rollback_idx)
+		return -EPERM;
+
+	priv->rollback_idx = rollback_idx;
+	return 0;
+}
+
+static const struct rollback_ops rollback_sandbox_ops = {
+	.rollback_idx_get		= sb_rollback_idx_get,
+	.rollback_idx_set		= sb_rollback_idx_set,
+};
+
+static int rollback_sandbox_probe(struct udevice *dev)
+{
+	struct rollback_state *priv = dev_get_priv(dev);
+
+	priv->rollback_idx = 0ULL;
+	return 0;
+}
+
+static const struct udevice_id rollback_sandbox_ids[] = {
+	{ .compatible = "sandbox,rollback" },
+	{ }
+};
+
+U_BOOT_DRIVER(rollback_sandbox) = {
+	.name	= "rollback_sandbox",
+	.id	= UCLASS_ROLLBACK,
+	.priv_auto = sizeof(struct rollback_state),
+	.of_match = rollback_sandbox_ids,
+	.probe	= rollback_sandbox_probe,
+	.ops	= &rollback_sandbox_ops,
+};
diff --git a/drivers/rollback/rollback-uclass.c b/drivers/rollback/rollback-uclass.c
new file mode 100644
index 0000000000..1fc5486b0d
--- /dev/null
+++ b/drivers/rollback/rollback-uclass.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2021 Microsoft, Inc
+ * Written by Stephen Carlson <stcarlso@microsoft.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <rollback.h>
+
+int rollback_idx_get(struct udevice *dev, uint64_t *rollback_idx)
+{
+	if (!dev || !rollback_idx)
+		return -EINVAL;
+
+	return rollback_get_ops(dev)->rollback_idx_get(dev, rollback_idx);
+}
+
+int rollback_idx_set(struct udevice *dev, uint64_t rollback_idx)
+{
+	if (!dev)
+		return -EINVAL;
+
+	return rollback_get_ops(dev)->rollback_idx_set(dev, rollback_idx);
+}
+
+UCLASS_DRIVER(rollback) = {
+	.id		= UCLASS_ROLLBACK,
+	.name		= "rollback",
+};
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 0432c95c9e..4b8b730d87 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -124,6 +124,7 @@ enum uclass_id {
 	UCLASS_RTC,		/* Real time clock device */
 	UCLASS_SCMI_AGENT,	/* Interface with an SCMI server */
 	UCLASS_SCSI,		/* SCSI device */
+	UCLASS_ROLLBACK,	/* Rollback device */
 	UCLASS_SERIAL,		/* Serial UART */
 	UCLASS_SIMPLE_BUS,	/* Bus with child devices */
 	UCLASS_SMEM,		/* Shared memory interface */
diff --git a/include/rollback.h b/include/rollback.h
new file mode 100644
index 0000000000..60dfd62dea
--- /dev/null
+++ b/include/rollback.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2021 Microsoft, Inc.
+ */
+
+#ifndef _ROLLBACK_H_
+#define _ROLLBACK_H_
+
+#include <stdint.h>
+
+/* Access the rollback operations for a device */
+#define rollback_get_ops(dev)	((struct rollback_ops *)(dev)->driver->ops)
+
+/**
+ * rollback_idx_get() Gets the OS anti-rollback version number
+ *
+ * @dev:     Device to check
+ * @rollback_idx:   The retrieved anti-rollback version
+ * @return   0 if OK, -ve on error
+ */
+int rollback_idx_get(struct udevice *dev, uint64_t *rollback_idx);
+
+/**
+ * rollback_idx_set() Sets the OS anti-rollback version number.
+ *
+ * @dev:     Device to modify
+ * @rollback_idx:   The new anti-rollback version to set
+ * @return   0 if OK, -ve on error
+ */
+int rollback_idx_set(struct udevice *dev, uint64_t rollback_idx);
+
+/**
+ * struct rollback_ops - Driver model rollback operations
+ *
+ * Refer to the functions above for the description of each operation.
+ */
+struct rollback_ops {
+	int (*rollback_idx_get)(struct udevice *dev, uint64_t *rollback_idx);
+	int (*rollback_idx_set)(struct udevice *dev, uint64_t rollback_idx);
+};
+
+#endif
-- 
2.40.0

