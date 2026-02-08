Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E525CEF06EC
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 21:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F099283CB1;
	Sun,  8 Feb 2026 22:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hPFYMEVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 763DA83C91; Sun,  8 Feb 2026 22:26:53 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B1E83642
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 22:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-790884840baso34666497b3.0
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 13:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770586010; x=1771190810; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qIcqjMZQVcp74e+YyccAAjSBAEwKwg+ufhESWqdwYSs=;
 b=hPFYMEVNHuJho4syyesF9UVfmx97Xz7h7Ftw7HFR+sBHIfYtdBKB2YkUPZzoSi52XF
 pCp3LDsZRohrRzYJyf0FlCmxSYD5YaEfrtTR2rvWtpMuQ2PGRg0IwvvsmUXSpy+e3XlK
 Tfb6yJxziMl162yDYbjtDcjWuploOv5ILf0rBBdKvY8Q5yDKgMu+hSQiVtNznoNkm6mw
 1CtZGTy9CwbBufy7vQkM5GtCHpzkEUa+Bxu056QDQB05XBjtreabuggfmUYgcS/ihhLU
 5ulu1TLF1jNFYo9tlhlpnX2o1ddpGXxOgLwzEb3TpCYyM7pZLuAG9zz5IMRM9dEU0siF
 VMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770586010; x=1771190810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qIcqjMZQVcp74e+YyccAAjSBAEwKwg+ufhESWqdwYSs=;
 b=rkYRnXfL8Kn2knTPDvCGLq6r/zXPhIeUh/Z8u7TASX5a4kLPXdXkVIyZjv3ASVl1z1
 yKINVTleuftEPDlumxph4bsDqlkTjEVDzU1RzQYw2N4WtAorMB/VpY0IC1JaEeXAx5Dd
 wFS+628AaMK2yt8TpxELR2h4nSH7vishvkRraNroTc4WwPAPmieRmUMhCjmcdOAwU0e0
 nE+zgS7ACV0KCloBaQDAtqg7ZbfnX7QRmUXMUhg5o8DxunRqP9NX7iP3blMmVIxsEGRX
 78mN41G8/F+FPIpO69DtxD0UWx5F6wIrhoqB2xdRLgZgkORawG8rxIR/323sngzl5eyC
 5ZsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8iQ0Xd2puJXZprefx5nSFkOg2kP3+y3DEK47UTE0Q+5w2ZxoSCCkpI/lA2v8g6txL7plgBOs=@lists.denx.de
X-Gm-Message-State: AOJu0YyKbBIXruUysg1N+nWCujiaxsnKXxHJjSjzAHhkz4gKaePHfGYI
 5fixaAQWH2Q9CDgrGabIvf1PlMlP1v6iYtN3QSqJ2rPm4kQmzaCb388cy6H5CQ==
X-Gm-Gg: AZuq6aJ5rN234PIOZ5C/CdQH8di5FrZUkluP40eiXavy6Wd3CjLq++TGwXDliRpy6VB
 bmpYgVKzO3fFKdcAzGbkJ46cnP9LmtuyMPbxG5G/Yd0M/6VS5+ULtt9gexuK1zohoJnVGU/Z3wP
 R1mGsmp3FxvWAFagok/y/UYnS58WbTvmONcU7toD+yg6sOKlIQYr9/ctHt6gfP8UjNmL+UB0WZc
 sp4frZRh12U9ZwPIKEHt3KGUlmWaHIjsdm/rlv3r4tf04IO+fErFvvS5X8PEnhsJGwoZu6XLDye
 bTyyTpXEiLXaitLdZpRWsTTtklt1k2B2NhVibxLcXmikexNy6JL65jtFY/QYf1FR03KlB+qj+vQ
 gfZPo4XkN1eNE4lJqwEvlrriRTEO1Q75Qwr5hLO7z0+lhRXHIUKKTSMOoAS69PAMfzdeu7Nxr9W
 au3C4tw7Zxwu5chkiWpYS2Kj7QEQBX00T9Cnk=
X-Received: by 2002:a05:690c:e3ee:b0:796:3b25:b188 with SMTP id
 00721157ae682-7963b25d22emr32224187b3.34.1770586010009; 
 Sun, 08 Feb 2026 13:26:50 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5d9f:efd7:6c6a:abf8])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7952a085999sm75229377b3.25.2026.02.08.13.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 13:26:49 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, jonas@kwiboo.se, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 6/7] spl: add SPI NAND support via MTD in SPL
Date: Sun,  8 Feb 2026 18:26:23 -0300
Message-Id: <20260208212624.3413494-7-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208212624.3413494-1-festevam@gmail.com>
References: <20260208212624.3413494-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Add support for booting U-Boot SPL from SPI NAND devices
using the MTD subsystem.

 - Introduce CONFIG_SPL_SPI_NAND_LOAD to enable SPL loading
  from SPI NAND flash.
 - Implement spl_spi_nand.c as a dedicated SPL loader that
  reads the FIT image from SPI NAND via MTD.
 - Update common/spl/Kconfig and Makefiles to include the
  new loader in SPL builds.
 - Adjust drivers/mtd/Makefile and drivers/mtd/nand/Makefile
  to build the necessary SPI NAND MTD objects only when
  CONFIG_SPL_SPI_NAND_LOAD is enabled, avoiding size impact
  on other boards.

This allows boards like the Omega4 RV1103 to boot SPL directly
from SPI NAND, keeping the SPL small and avoiding unnecessary
inclusion of SPI NOR code.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- None.

 common/spl/Kconfig        | 10 ++++-
 common/spl/Makefile       |  1 +
 common/spl/spl_spi_nand.c | 82 +++++++++++++++++++++++++++++++++++++++
 drivers/mtd/Makefile      |  1 +
 drivers/mtd/nand/Makefile | 13 ++++++-
 5 files changed, 105 insertions(+), 2 deletions(-)
 create mode 100644 common/spl/spl_spi_nand.c

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 2998b7acb75f..126855b804ce 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1576,13 +1576,21 @@ config SPL_SPI_LOAD
 	  Enable support for loading next stage, U-Boot or otherwise, from
 	  SPI NOR in U-Boot SPL.
 
+config SPL_SPI_NAND_LOAD
+	bool "Support loading from SPI NAND flash"
+	depends on SPL
+	depends on MTD && DM_MTD
+	help
+	  Enable support for loading next stage, U-Boot or otherwise, from
+	  SPI NAND in U-Boot SPL.
+
 endif # SPL_SPI_FLASH_SUPPORT
 
 config SYS_SPI_U_BOOT_OFFS
 	hex "address of u-boot payload in SPI flash"
 	default 0x8000 if ARCH_SUNXI
 	default 0x0
-	depends on SPL_SPI_LOAD || SPL_SPI_SUNXI
+	depends on SPL_SPI_LOAD || SPL_SPI_NAND_LOAD || SPL_SPI_SUNXI
 	help
 	 Address within SPI-Flash from where the u-boot payload is fetched
 	 from.
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 4c9482bd3096..4628902e7e31 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)NVME) += spl_nvme.o
 obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += spl_semihosting.o
 obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
 obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
+obj-$(CONFIG_$(PHASE_)SPI_NAND_LOAD) += spl_spi_nand.o
 obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
 obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
 endif
diff --git a/common/spl/spl_spi_nand.c b/common/spl/spl_spi_nand.c
new file mode 100644
index 000000000000..20b877f75a05
--- /dev/null
+++ b/common/spl/spl_spi_nand.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * SPL loader for SPI NAND devices using the MTD subsystem.
+ *
+ * Based on spl_spi.c, which is:
+ *
+ * Copyright (C) 2011 OMICRON electronics GmbH
+ *
+ * based on drivers/mtd/nand/raw/nand_spl_load.c
+ *
+ * Copyright (C) 2011
+ * Heiko Schocher, DENX Software Engineering, hs@denx.de.
+ */
+
+#include <config.h>
+#include <image.h>
+#include <log.h>
+#include <errno.h>
+#include <spl.h>
+#include <spl_load.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <dm/uclass.h>
+#include <mtd.h>
+
+static struct mtd_info *spl_spi_nand_get_mtd(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	for (ret = uclass_first_device_err(UCLASS_MTD, &dev);
+	     dev;
+	     ret = uclass_next_device_err(&dev)) {
+		if (ret)
+			continue;
+		if (device_is_compatible(dev, "spi-nand"))
+			return dev_get_uclass_priv(dev);
+	}
+
+	return NULL;
+}
+
+static ulong spl_spinand_fit_read(struct spl_load_info *load, ulong offs,
+				  ulong size, void *buf)
+{
+	struct mtd_info *mtd = load->priv;
+	size_t retlen = 0;
+	int ret;
+
+	ret = mtd_read(mtd, offs, size, &retlen, buf);
+	if (ret && ret != -EUCLEAN) {
+		printf("SPI NAND read failed offs=0x%lx size=0x%lx ret=%d\n",
+		       offs, size, ret);
+		return 0;
+	}
+	if (retlen != size)
+		return 0;
+
+	return retlen;
+}
+
+static int spl_spinand_load_image(struct spl_image_info *spl_image,
+				  struct spl_boot_device *bootdev)
+{
+	struct spl_load_info load;
+	struct mtd_info *mtd;
+
+	mtd = spl_spi_nand_get_mtd();
+	if (!mtd) {
+		puts("SPI NAND probe failed.\n");
+		return -ENODEV;
+	}
+
+	spl_load_init(&load, spl_spinand_fit_read, mtd, 1);
+
+	return spl_load(spl_image, bootdev, &load, 0, CONFIG_SYS_SPI_U_BOOT_OFFS);
+}
+
+/* Use priority 1 so that boards can override this */
+SPL_LOAD_IMAGE_METHOD("SPI NAND", 1, BOOT_DEVICE_SPI, spl_spinand_load_image);
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index ce05e206073d..a12d880a9e90 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -34,6 +34,7 @@ else
 ifneq ($(mtd-y),)
 obj-$(CONFIG_SPL_MTD) += mtd.o
 endif
+obj-$(CONFIG_SPL_SPI_NAND_LOAD) += nand/
 obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += nand/
 obj-$(CONFIG_SPL_ONENAND_SUPPORT) += onenand/
 obj-$(CONFIG_$(PHASE_)SPI_FLASH_SUPPORT) += spi/
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index c8169cf73902..7cd2a5f1af9b 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,10 +1,21 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 nandcore-objs := core.o bbt.o
+
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+
+# U-Boot proper
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/
 obj-$(CONFIG_MTD_SPI_NAND) += spi/
+
 else
+
+# SPL / XPL / TPL
+# SPL has no MTD_NAND_CORE symbol, so we must key off SPI NAND usage
+obj-$(CONFIG_SPL_SPI_NAND_LOAD) += nandcore.o
+obj-$(CONFIG_SPL_SPI_NAND_LOAD) += spi/
+
+# raw NAND still follows the normal SPL rule
 obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += raw/
 endif
-- 
2.34.1

