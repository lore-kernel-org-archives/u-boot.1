Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D828CDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 13:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79ABF84A45;
	Thu, 25 Jun 2026 14:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="lpkVeQ18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8503B84704; Thu, 25 Jun 2026 14:20:10 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED2EF84949
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=629d8e15b=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782390008; x=1813926008;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TQaM6g1Is//HeRsnzIC34pz2v854GiibpjoYyw1UxIc=;
 b=lpkVeQ18PahKQtzrZ8oYyn8kOR+gWq1sePhJANFqWrPjs3sa/Wn8R0cP
 1a67RDNqZ2DlHqHNRIGNUXHBWdLCW6qoJPJPQbQrs2z0FHsP7uKt8FqR3
 gs3simpPv2Vn0b2nHRhUbVxoenpmIJdqnLzR0xgFiZM3QCYBeWW1SXih0
 +HVhGGEl+DO/8xZjMpgmGdxJYb/exWgUkL8xtzAUc3nFWdSD1JhjVbhaO
 CYeP1NP/+V46rdoWqZ0tkWVkxGu4yLvDyURh/UbzBKtUDld3mVUZtNXIP
 MejHCdfICtTd1OAvzm99+vimmoT+PiH6QqW9+1a4ecHisRvaoTd6nM97U A==;
X-CSE-ConnectionGUID: z1rB1lSLSwK6JbYAHu8RnA==
X-CSE-MsgGUID: jPhzq41wTA2Z8xS7uHpsgw==
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="68857385"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 05:20:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Thu, 25 Jun 2026 05:20:05 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 25 Jun 2026 05:20:02 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Martin Herren <sputnik@on-the-web.ch>,
 Michal Simek <michal.simek@amd.com>, Adriana Nicolae <adriana@arista.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, <jamie.gibbons@microchip.com>
Subject: [PATCH 4/8] rng: add Microchip PolarFire SoC hardware RNG driver
Date: Thu, 25 Jun 2026 13:23:21 +0100
Message-ID: <20260625122325.834568-5-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625122325.834568-1-jamie.gibbons@microchip.com>
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

Add a U-Boot RNG driver for Microchip's PolarFire SoC (MPFS). The
hardware RNG is accessed indirectly via the MPFS system controller using
the mailbox interface.

The driver implements the UCLASS_RNG interface, requesting random data
from the system controller and returning it to the caller.

This allows use of the PolarFire SoC hardware RNG via the
standard 'rng' command and DM RNG API.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 configs/microchip_mpfs_generic_defconfig |   1 +
 drivers/rng/Kconfig                      |   7 ++
 drivers/rng/Makefile                     |   1 +
 drivers/rng/mpfs_rng.c                   | 106 +++++++++++++++++++++++
 4 files changed, 115 insertions(+)
 create mode 100644 drivers/rng/mpfs_rng.c

diff --git a/configs/microchip_mpfs_generic_defconfig b/configs/microchip_mpfs_generic_defconfig
index 973ed09fa87..66acaad7e9b 100644
--- a/configs/microchip_mpfs_generic_defconfig
+++ b/configs/microchip_mpfs_generic_defconfig
@@ -30,3 +30,4 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_DM_MTD=y
 CONFIG_SYSRESET=y
+CONFIG_DM_RNG=y
diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index 19b2b707677..856ffda2f5e 100644
--- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -23,6 +23,13 @@ config RNG_MESON
 	  Enable support for hardware random number generator
 	  of Amlogic Meson SoCs.
 
+config RNG_MPFS
+	tristate "Microchip PolarFire SoC Random Number Generator support"
+	depends on DM_RNG && MPFS_SYSCONTROLLER
+	help
+	  Enable support for hardware random number generator
+	  of Microchip's PolarFire SoCs.
+
 config RNG_SANDBOX
 	bool "Sandbox random number generator"
 	depends on SANDBOX
diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
index 30c58272d41..50622d4705f 100644
--- a/drivers/rng/Makefile
+++ b/drivers/rng/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(PHASE_)DM_RNG) += rng-uclass.o
 obj-$(CONFIG_RNG_MESON) += meson-rng.o
+obj-$(CONFIG_RNG_MPFS) += mpfs_rng.o
 obj-$(CONFIG_RNG_SANDBOX) += sandbox_rng.o
 obj-$(CONFIG_RNG_MSM) += msm_rng.o
 obj-$(CONFIG_RNG_NPCM) += npcm_rng.o
diff --git a/drivers/rng/mpfs_rng.c b/drivers/rng/mpfs_rng.c
new file mode 100644
index 00000000000..61bd520d8a2
--- /dev/null
+++ b/drivers/rng/mpfs_rng.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Microchip's PolarFire SoC (MPFS) System Controller Driver
+ *
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ *
+ * Author: Jamie Gibbons <jamie.gibbons@microchip.com>
+ *
+ */
+
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/printk.h>
+#include <mailbox.h>
+#include <malloc.h>
+#include <mpfs-mailbox.h>
+#include <rng.h>
+#include <string.h>
+
+#define CMD_OPCODE						0x21
+#define CMD_DATA_SIZE					0U
+#define CMD_DATA						NULL
+#define MBOX_OFFSET						0U
+#define RESP_OFFSET						0U
+#define RNG_RESP_BYTES					32U
+
+/**
+ * struct mpfs_rng_priv - Structure representing System Controller data.
+ * @mpfs_syscontroller_priv:	System Controller
+ */
+struct mpfs_rng_priv {
+	struct mpfs_syscontroller_priv *sys_controller;
+};
+
+static int mpfs_rng_read(struct udevice *dev, void *data, size_t len)
+{
+	struct mpfs_rng_priv *rng_priv = dev_get_priv(dev);
+	u32 response_msg[RNG_RESP_BYTES / sizeof(u32)];
+	size_t count = 0, copy_size;
+	int ret;
+
+	struct mpfs_mss_response response = {
+		.resp_status = 0U,
+		.resp_msg = (u32*)response_msg,
+		.resp_size = RNG_RESP_BYTES,
+	};
+	struct mpfs_mss_msg msg = {
+		.cmd_opcode = CMD_OPCODE,
+		.cmd_data_size = CMD_DATA_SIZE,
+		.response = &response,
+		.cmd_data = CMD_DATA,
+		.mbox_offset = MBOX_OFFSET,
+		.resp_offset = RESP_OFFSET,
+	};
+
+	while (count < len) {
+		ret = mpfs_syscontroller_run_service(rng_priv->sys_controller, &msg);
+		if (ret == -EBUSY)
+			return 0;
+		if (ret)
+			return ret;
+
+		ret = mpfs_syscontroller_recv_response(rng_priv->sys_controller, &msg, 1000);
+		if (ret == -EBUSY)
+			return 0;
+		if (ret)
+			return ret;
+
+		copy_size = (len - count > RNG_RESP_BYTES) ? RNG_RESP_BYTES : (len - count);
+		memcpy((u8 *)data + count, response_msg, copy_size);
+		count += copy_size;
+	}
+
+	return len;
+}
+
+static int mpfs_rng_probe(struct udevice *dev)
+{
+	struct mpfs_rng_priv *rng_priv = dev_get_priv(dev);
+
+	rng_priv->sys_controller = mpfs_syscontroller_get(dev->parent);
+	if (IS_ERR(rng_priv->sys_controller)) {
+		dev_err(dev, "Failed to get system controller\n");
+		return PTR_ERR(rng_priv->sys_controller);
+	}
+
+	dev_info(dev, "Registered MPFS hwrng\n");
+	return 0;
+}
+
+static const struct dm_rng_ops mpfs_rng_ops = {
+	.read = mpfs_rng_read,
+};
+
+U_BOOT_DRIVER(mpfs_rng) = {
+	.name           = "mpfs_rng",
+	.id             = UCLASS_RNG,
+	.probe          = mpfs_rng_probe,
+	.priv_auto	    = sizeof(struct mpfs_rng_priv),
+	.ops            = &mpfs_rng_ops,
+};
-- 
2.43.0

