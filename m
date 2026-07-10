Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EEFC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 20:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A8E884B42;
	Fri, 10 Jul 2026 22:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="G5vSBD/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7DE84B48; Fri, 10 Jul 2026 22:22:31 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEAD884AA1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 22:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 79602B0053E;
 Fri, 10 Jul 2026 22:22:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783714947;
 bh=y2fAEbDi2tLHjvPpw/KUow12MeYOk8oQ1rA7y9ZvPAc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G5vSBD/v4XEfT50HomDaT2K0Yk5ycwet8zyzF23BXaeFTUmBjxBXoXI7d5JlbeHUk
 cuBqpibKWyN4nzyQo5DywopE908LMKJmPZCUgh+dBLsvXO9m+cyhCf7JvH+VScxDV6
 Roqaz5Nd+pwvF2BihIngtpMzihraLgHQcPP00Mf7IBHT6AQS5MnTW9xr0bywGidSik
 6DpyMkUKi6NSEdzpDUrVnyNXgyq5h2QsLtGKsxY0EILrlwTw+RibaIXMsymmjsB/Im
 TRJSSSgoPXXZqMPG4JQ5B4RMc97CqbsV6ZYn2WJtPp4u2AtzAa/nIL8jNmOhEvAChS
 ZX3B2t3kSZlaw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 5/7] thermal: pmbus: add PMBus die-temp driver
Date: Fri, 10 Jul 2026 22:16:10 +0200
Message-ID: <20260710201631.2469728-6-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710201631.2469728-1-vjardin@free.fr>
References: <20260710201631.2469728-1-vjardin@free.fr>
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

The driver is a thin UCLASS_THERMAL: its get_temp reads the
temperature of its parent regulator through the pmbus helper
(READ_TEMPERATURE_1), without any chip-specific code.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 MAINTAINERS                     |  1 +
 drivers/thermal/Kconfig         |  8 ++++++++
 drivers/thermal/Makefile        |  1 +
 drivers/thermal/pmbus_thermal.c | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 drivers/thermal/pmbus_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ba9b195c0b..9efc137eb1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1589,6 +1589,7 @@ F:	drivers/power/regulator/mpq8785.c
 F:	drivers/power/regulator/pmbus_generic.c
 F:	drivers/power/regulator/pmbus_helper.c
 F:	drivers/power/regulator/pmbus_helper.h
+F:	drivers/thermal/pmbus_thermal.c
 F:	include/pmbus.h
 F:	lib/pmbus.c
 
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 91c39aa4dee..30bb64ce895 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -55,4 +55,12 @@ config TI_LM74_THERMAL
 	 Enable thermal support for the Texas Instruments LM74 chip.
 	 The driver supports reading CPU temperature.
 
+config PMBUS_THERMAL
+	bool "Generic PMBus temperature"
+	depends on DM_REGULATOR_PMBUS_HELPER
+	help
+	  Expose the die-temperature reading of any PMBus voltage
+	  regulator bound by a pmbus_helper based chip driver
+	  as a UCLASS_THERMAL device.
+
 endif # if DM_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index b6f06c00ed9..25435f43b64 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_RCAR_GEN3_THERMAL) += rcar_gen3_thermal.o
 obj-$(CONFIG_SANDBOX) += thermal_sandbox.o
 obj-$(CONFIG_TI_DRA7_THERMAL) += ti-bandgap.o
 obj-$(CONFIG_TI_LM74_THERMAL) += ti-lm74.o
+obj-$(CONFIG_PMBUS_THERMAL) += pmbus_thermal.o
diff --git a/drivers/thermal/pmbus_thermal.c b/drivers/thermal/pmbus_thermal.c
new file mode 100644
index 00000000000..c251cea8ddf
--- /dev/null
+++ b/drivers/thermal/pmbus_thermal.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Generic UCLASS_THERMAL companion for PMBus voltage regulators.
+ *
+ * Works with any chip bound by a pmbus_helper based regulator driver
+ * (drivers/power/regulator/<chip>.c calling
+ * pmbus_regulator_probe_common()). It auto-spawns one
+ * of these thermal devices per regulator.
+ *
+ * The reading is the chip's READ_TEMPERATURE_1 (PMBus 0x8D), decoded
+ * through the parent's pmbus_driver_info.
+ */
+
+#include <dm.h>
+#include <pmbus.h>
+#include <thermal.h>
+
+static int pmbus_thermal_get_temp(struct udevice *dev, int *temp)
+{
+	return pmbus_regulator_read_temp(dev_get_parent(dev), temp);
+}
+
+static const struct dm_thermal_ops pmbus_thermal_ops = {
+	.get_temp = pmbus_thermal_get_temp,
+};
+
+U_BOOT_DRIVER(pmbus_thermal) = {
+	.name	= "pmbus_thermal",
+	.id	= UCLASS_THERMAL,
+	.ops	= &pmbus_thermal_ops,
+};
-- 
2.43.0

