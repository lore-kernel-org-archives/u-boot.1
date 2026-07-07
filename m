Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA41C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A6684AD6;
	Tue,  7 Jul 2026 17:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G6BJ8KNX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A7DF84A4A; Tue,  7 Jul 2026 17:32:45 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29878849F6
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-497d6c2d000so2708379b6e.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783438362; x=1784043162; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VcuiF6IAK6t7JCgryhjtoPSZmABEbo83ep/nr7nvX+c=;
 b=G6BJ8KNXiD3bYCrZgsrGmnQWhCMmkxJRuA8yeOUOEM9ABSxhI0irJK0qnzwFqlFA2H
 PvFOrRuQWahEuvhLiOuDCsH30Yo/2tjTklIRVkzVrpq/mKa7tQ+cGyW1PGz25tu/pxWe
 MUZR4lXRTPK3GasLuTlOFA0++MoZf7yOY5yJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438362; x=1784043162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VcuiF6IAK6t7JCgryhjtoPSZmABEbo83ep/nr7nvX+c=;
 b=NmKJC8gpwVdBZTSgujVSfu6JiTcZugPJ9Tzo9ZfUVF0WHi2h+O2mj80Jvg1ocT82a+
 HWBqrXNP5StI1UDSpUeSzC6B7JrpyxTk8mE3Qj1z0yETFbPN6YlDBWwntuvR05GhbsKF
 DWbLQa9pgHOvqRzduNmzsneQjYL5qDTPUXCrfVqcQv6tRpq58b8n9Ifg/VUS9vfpfZfr
 3nmZOJx9s0be8pdHmuzhu7yLRjyS/xYptGdC37Etbwlb1W236qECGHpRhb05qUMeGkXd
 +ALR/LNuLA42eTuI3PEj7AXXKkqtaucE3qeu+QOkpxY69uozLcyFQfXzN26u2JIj9xhG
 3EZQ==
X-Gm-Message-State: AOJu0YwRFEFG7Q52Q/Bmg2ohJTXzFwWDZSJ7/zRiHparr9xd02MB11HW
 hE+bmk+kYHv2GukXZnFWaqvbuETO7Uyov0PwmlTXzf7ZtDjb7/bbN8ZE0oNepYPYFcjiuqSw/UG
 YIQ3R0A==
X-Gm-Gg: AfdE7cn0EjRa2e6lEs2hSizqyda3hy5uGHZB+WOMM5M1d55/yTo7WYojuMN+ObcRRpA
 UcghhK6q4xdTZs2VoKoOTspckd892SJT+Ts4ddZGcKGHiKquW4AJ9BfqlnnaJHKgJ+YuSbtziw0
 bFEEsC4Qi6UXaNx+lK1bMy/glMgIVAxTJNf8YP/YLNyT/qsoOMvqdqTCfrWiBHXdWc/ybEIKA1h
 QjkyP5MVhkwgxmVQekC3wb8e8NlXB1aT5LoPpuy7K0chVCO5SnYPyHffoW7ZS7IImm8ql97xY4d
 NGzdYpYP1jtgn0gPx2x1hyo3gGMD/4nuWdHBzJ6nFQUy1OiHavVqURW62Y1PZGz2F4BCnbEaYTd
 Esi9pFluFFF8XKPDIWK/AcMiryJpKYcnBWUyzjnwC2hhp6L1vUrIVS3N3AuPQbQbwXegF6Rd/Z2
 4zPsqBmPo=
X-Received: by 2002:a05:6808:f8b:b0:48a:a688:4155 with SMTP id
 5614622812f47-49fddad61famr3741493b6e.20.1783438361856; 
 Tue, 07 Jul 2026 08:32:41 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm12052218b6e.14.2026.07.07.08.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:32:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Alexey Charkov <alchark@gmail.com>,
 Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Genoud <richard.genoud@bootlin.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 06/15] spl: Add SPI NAND support via MTD in SPL
Date: Tue,  7 Jul 2026 09:31:04 -0600
Message-ID: <20260707153135.2048115-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707153135.2048115-1-sjg@chromium.org>
References: <20260707153135.2048115-1-sjg@chromium.org>
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

Add support for booting U-Boot SPL from SPI NAND devices using the MTD
subsystem:

- Introduce CONFIG_SPL_SPI_NAND_LOAD to enable SPL loading from SPI
  NAND flash.
- Implement spl_spi_nand.c as a dedicated SPL loader that reads the
  FIT image from SPI NAND via MTD.
- Update common/spl/Kconfig and the Makefiles to include the new
  loader in SPL builds.
- Adjust drivers/mtd/Makefile and drivers/mtd/nand/Makefile to build
  the necessary SPI NAND MTD objects only when SPL_SPI_NAND_LOAD is
  enabled, avoiding a size impact on other boards.

This allows boards like the Omega4 RV1103B to boot SPL directly from
SPI NAND, keeping the SPL small and avoiding unnecessary inclusion of
SPI NOR code.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/Kconfig        | 10 ++++-
 common/spl/Makefile       |  1 +
 common/spl/spl_spi_nand.c | 82 +++++++++++++++++++++++++++++++++++++++
 drivers/mtd/Makefile      |  1 +
 drivers/mtd/nand/Makefile | 13 ++++++-
 5 files changed, 105 insertions(+), 2 deletions(-)
 create mode 100644 common/spl/spl_spi_nand.c

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0618f42c941..0a3b53d0e66 100644
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
index 9c94e8f143e..e8365b69825 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_$(PHASE_)NVME) += spl_nvme.o
 obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += spl_semihosting.o
 obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
 obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
+obj-$(CONFIG_$(PHASE_)SPI_NAND_LOAD) += spl_spi_nand.o
 obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
 obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
 obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += spl_ufs.o
diff --git a/common/spl/spl_spi_nand.c b/common/spl/spl_spi_nand.c
new file mode 100644
index 00000000000..20b877f75a0
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
index ce05e206073..a12d880a9e9 100644
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
index c8169cf7390..7cd2a5f1af9 100644
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
2.43.0

