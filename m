Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3985BCD6E64
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 13:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C614286D01;
	Wed, 11 Oct 2023 15:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AAFB86D2E; Wed, 11 Oct 2023 15:06:43 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C6D786E00
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 15:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp78t1697029557tax8pyjx
Received: from ubuntu.. ( [111.196.129.4]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Oct 2023 21:05:56 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: Q77qMjlDMfyJcXZa1jYmZdcsPoZI67mB0LjgGk6/W0mCS2ANImRvYUCV7b8aT
 4H0k+o4ABn6mTkg94ArxI832PivK/igvKIi0W7SQn2M4gSLty46ZG37j2glSlMsw3nm+Z2a
 jSOx0CpHHNfEKFDmiWtdO+dWgBOw9Lbels9un3Wh8ZWH/bWv2Tz6z6DdqIUHNpGieqHB72E
 iG7+wUrkjzrjCW/GUjJ2kocahWqMhWiml8U6zHZOw51HE0JortqzfJntMmiKJT/fSp4cbcz
 cKjmPL6D9y3+89QBSQS/7SxDotTR3GdYAynpDYKbQCSu2TZFdr9IiKLQX6dse458laNaYl4
 8saOTNuRfAbKQTuigfYbNg0MYz2qmJFTh/L29v7ICimODeTuck=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7340433847877426673
From: Bin Meng <bmeng@tinylab.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Subject: [PATCH 7/9] ufs: Add a PCI based UFS controller driver
Date: Wed, 11 Oct 2023 21:05:33 +0800
Message-Id: <20231011130535.3964-8-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011130535.3964-1-bmeng@tinylab.org>
References: <20231011130535.3964-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

This adds a simple PCI based UFS controller driver with a QEMU
emulated UFS controller on the PCI bus.

Requiring QEMU v8.2+.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 drivers/ufs/Kconfig   | 11 +++++++++++
 drivers/ufs/Makefile  |  1 +
 drivers/ufs/ufs-pci.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 drivers/ufs/ufs-pci.c

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 0e0cc58e3d..42797ce052 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -15,6 +15,17 @@ config CADENCE_UFS
 	  This selects the platform driver for the Cadence UFS host
 	  controller present on present TI's J721e devices.
 
+config UFS_PCI
+	bool "PCI bus based UFS Controller support"
+	depends on PCI && UFS
+	help
+	  This selects the PCI UFS Host Controller Interface. Select this if
+	  you have UFS Host Controller with PCI Interface.
+
+	  If you have a controller with this interface, say Y here.
+
+	  If unsure, say N.
+
 config TI_J721E_UFS
 	bool "Glue Layer driver for UFS on TI J721E devices"
 	help
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 4f3344fd4e..13f1e689ef 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -6,4 +6,5 @@
 obj-$(CONFIG_UFS) += ufs.o ufs-uclass.o
 obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
+obj-$(CONFIG_UFS_PCI) += ufs-pci.o
 obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
diff --git a/drivers/ufs/ufs-pci.c b/drivers/ufs/ufs-pci.c
new file mode 100644
index 0000000000..bf697106a0
--- /dev/null
+++ b/drivers/ufs/ufs-pci.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 tinylab.org
+ * Author: Bin Meng <bmeng@tinylab.org>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <errno.h>
+#include <pci.h>
+#include <ufs.h>
+#include <dm/device_compat.h>
+#include "ufs.h"
+
+static int ufs_pci_bind(struct udevice *dev)
+{
+	struct udevice *scsi_dev;
+
+	return ufs_scsi_bind(dev, &scsi_dev);
+}
+
+static int ufs_pci_probe(struct udevice *dev)
+{
+	int err;
+
+	err = ufshcd_probe(dev, NULL);
+	if (err)
+		dev_err(dev, "%s failed (ret=%d)\n", err);
+
+	return err;
+}
+
+U_BOOT_DRIVER(ufs_pci) = {
+	.name	= "ufs_pci",
+	.id	= UCLASS_UFS,
+	.bind	= ufs_pci_bind,
+	.probe	= ufs_pci_probe,
+};
+
+static struct pci_device_id ufs_supported[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_UFS) },
+	{},
+};
+
+U_BOOT_PCI_DEVICE(ufs_pci, ufs_supported);
-- 
2.34.1

