Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1926C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 02:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE4680BAE;
	Tue, 18 Feb 2025 03:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cpxHFyvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10A1780F16; Tue, 18 Feb 2025 03:58:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D751880017
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739847492; x=1771383492;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wDVyS5xGrPFV+wBQry8XKBDHVaBaiGot6aF3xhLXQ18=;
 b=cpxHFyvzweseQ1HGGM0fp8EUwShCdflok8xtjzHcT6OVDF7dddB4zEDD
 U+YlB89w6Vdw1C9qQKmyuTOhZf2ADnbkLyNcVsQ7JC1lXz9duXPi2Ii8/
 denEBy8YPEaHgcn8pqZiq2JOiTuBUX54m2QngwTks/BLNkAkd68gjlYhu
 J2h4CLJu1Lxf4TPOtcBTuxSW8vN3lPdOByMmHOSO3l2ASECDSDVt0IV/l
 MOVqpWLBYD3cHhvwyL3j0Y9T0DTTMPqcWPUs0K8aXVDWaKxKXX9/x3Ehp
 hs59nQ/VR/EhxzILJ7Srmgbj2rGS3BFKxcunOmo8a6A6Oxozy5sfz8AYS w==;
X-CSE-ConnectionGUID: EDBF4Y3yRyOOd+c4C0a3sA==
X-CSE-MsgGUID: QcYh60q6R7m1VtoCbThEpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51174374"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="51174374"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 18:57:58 -0800
X-CSE-ConnectionGUID: U74y/5jtSpuCj//KZb3zhg==
X-CSE-MsgGUID: cfh/OSQVQiez1rXCffwdcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="119259284"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2025 18:57:52 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Wang Jie <dave.wang@rock-chips.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 06/10] drivers: i3c: Add i3c uclass driver.
Date: Tue, 18 Feb 2025 10:57:01 +0800
Message-Id: <20250218025705.50051-7-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250218025705.50051-1-dinesh.maniyam@intel.com>
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

Enable i3c general uclass driver. This uclass driver will have
genaral read and write api to call the specific i3c driver.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/i3c/Makefile     |  1 +
 drivers/i3c/i3c-uclass.c | 38 ++++++++++++++++++++++++
 include/dw-i3c.h         |  1 +
 include/i3c.h            | 63 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+)
 create mode 100644 drivers/i3c/i3c-uclass.c
 create mode 100644 include/i3c.h

diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 2d42864d79..d560939145 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+obj-y += i3c-uclass.o
 obj-$(CONFIG_DW_I3C_MASTER) += dw-i3c-master.o
\ No newline at end of file
diff --git a/drivers/i3c/i3c-uclass.c b/drivers/i3c/i3c-uclass.c
new file mode 100644
index 0000000000..644f578889
--- /dev/null
+++ b/drivers/i3c/i3c-uclass.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <i3c.h>
+#include <errno.h>
+#include <log.h>
+#include <dm/device-internal.h>
+#include <linux/ctype.h>
+
+int dm_i3c_read(struct udevice *dev, u8 dev_number,
+		u8 *buf, int num_bytes)
+{
+	struct dm_i3c_ops *ops = i3c_get_ops(dev);
+
+	if (!ops->read)
+		return -ENOSYS;
+
+	return ops->read(dev, dev_number, buf, num_bytes);
+}
+
+int dm_i3c_write(struct udevice *dev, u8 dev_number,
+		 u8 *buf, int num_bytes)
+{
+	struct dm_i3c_ops *ops = i3c_get_ops(dev);
+
+	if (!ops->write)
+		return -ENOSYS;
+
+	return ops->write(dev, dev_number, buf, num_bytes);
+}
+
+UCLASS_DRIVER(i3c) = {
+	.id		= UCLASS_I3C,
+	.name		= "i3c",
+};
diff --git a/include/dw-i3c.h b/include/dw-i3c.h
index e37fd4dc32..920f18bccb 100644
--- a/include/dw-i3c.h
+++ b/include/dw-i3c.h
@@ -7,6 +7,7 @@
 #define _DW_I3C_H_
 
 #include <clk.h>
+#include <i3c.h>
 #include <reset.h>
 #include <dm/device.h>
 #include <linux/bitops.h>
diff --git a/include/i3c.h b/include/i3c.h
new file mode 100644
index 0000000000..6ef4982dcf
--- /dev/null
+++ b/include/i3c.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <linux/i3c/master.h>
+
+/**
+ * struct dm_i3c_ops - driver operations for i3c uclass
+ *
+ * Drivers should support these operations unless otherwise noted. These
+ * operations are intended to be used by uclass code, not directly from
+ * other code.
+ */
+struct dm_i3c_ops {
+	/**
+	 * Transfer messages in I3C mode.
+	 *
+	 * @see i3c_transfer
+	 *
+	 * @param dev Pointer to controller device driver instance.
+	 * @param target Pointer to target device descriptor.
+	 * @param msg Pointer to I3C messages.
+	 * @param num_msgs Number of messages to transfer.
+	 *
+	 * @return @see i3c_transfer
+	 */
+	int (*i3c_xfers)(struct i3c_dev_desc *dev,
+			 struct i3c_priv_xfer *i3c_xfers,
+			 int i3c_nxfers);
+};
+
+#define i3c_get_ops(dev)	((struct dm_i3c_ops *)(dev)->driver->ops)
+
+/**
+ * @brief Do i3c write
+ *
+ * Uclass general function to start write to i3c target
+ *
+ * @udevice pointer to i3c controller.
+ * @dev_number target device number.
+ * @buf target Buffer to write.
+ * @num_bytes length of bytes to write.
+ *
+ * @return 0 for success
+ */
+int dm_i3c_write(struct udevice *dev, u8 dev_number,
+		 u8 *buf, int num_bytes);
+
+/**
+ * @brief Do i3c read
+ *
+ * Uclass general function to start read from i3c target
+ *
+ * @udevice pointer to i3c controller.
+ * @dev_number target device number.
+ * @buf target Buffer to read.
+ * @num_bytes length of bytes to read.
+ *
+ * @return 0 for success
+ */
+int dm_i3c_read(struct udevice *dev, u8 dev_number,
+		u8 *buf, int num_bytes);
-- 
2.26.2

