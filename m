Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE66E7C6F6
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 00:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A435B83AEE;
	Sun,  1 Feb 2026 01:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UCstjKsV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD45183BC9; Sun,  1 Feb 2026 01:45:25 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8041083BE1
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 01:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-78fdb90b670so29032877b3.2
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 16:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769906722; x=1770511522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LyE9l8Y07uMoykorusbRQfKfqeV6+TIxYPkysx5a0ag=;
 b=UCstjKsVT22eUtWSG/lOkntAruxGQP8pdImKVUHCWXCQmfoCWEbE/n1Lauy6Ccc9tJ
 h7hgb9nOKZr97KBY+bTBI1Q2iETbjJxbjsvaQXldJ1LgQraAAstf0NonK5Gw5OYPLSxX
 LWeNEiF4zbgqBh3wfWjQIIWgzEHxbnALDAts37nUkqLMXe97vMEl0Hz+jX+rU6mF3kR4
 mXp/2Efp9CZzr2TPviRfHHnuiG3+PU1YyQeHtu7WwHu2zjD+N1omJNqe3wTQVOIA3W/O
 Dy/rs3l0Qcc5flrtwdLtEffs77tiL5SYRRG0h1IvKhKFdKhksBKQL9sbMA/D1kcyy0lx
 WmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769906722; x=1770511522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LyE9l8Y07uMoykorusbRQfKfqeV6+TIxYPkysx5a0ag=;
 b=pBjAc2RpREQOXtxQXW/4Bd0ivRWcO8h5JnuOGjjsqBDLZjg3qrc+EX3p9AAR15XWP5
 o6BxKB4EizILPpTbIPKtblW3LftQD1iBBwdLbdph4VYPkBgL0Z7cNdF0CvbFYZaAkAYI
 YjWznVHPcnqTMXdlDrenreYYcq4z8A5G62TmB8pFtceIZlBgnOerCLn2NG3lf9vTeGpC
 LFyi+kejmBYY8aXrP1E6H4qxh9ZaGkvtEfEhtafGBwWuizWMba+itM2AQDN6pCPs8hnH
 ojkcvyI3+h7/PcgitKUcCfi6JhvdVjuEm2qKwKV5xxXmaiueQMmG3VLNcJNMK5jd8ueO
 tkCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURKYxyzIJVZikOFgUwAMFUta/qa1kPtO0YvbKT8pPHo/ARqxMf9f5jNQGlyLTIkrIFRcgnCuU=@lists.denx.de
X-Gm-Message-State: AOJu0YxG/9PywERYvezW5kR/5YVltDxSR7NdFvB9s9TUWa5cWlDIWvzg
 IAhHa9e9FP2iZ4phhVzOA3yV+g/nUPUP5eoQaLFxczKdtU4yt4e/5fr+N+geSA==
X-Gm-Gg: AZuq6aLJGNyWDFDohATKjD3yg2YpOj/boSG4PbvGFCUocIGVkeFHmd5y3r2cpkP0u/B
 mfNCDziOVftv0tPWNOKXjLRukvCrA1xLnHoRHu+FCQ3AnsqCwPxBCYLlgRCaTN8CbqMtQWazA6m
 07JSLYIrAILMWFcW/TwhlGiu638q/FN4mc64Yylcsdg8DQGdEaFXSq5vEiuGYjuPD3Swj2/TKfb
 YpWJmoHir88zjhzzkTXsDUWJEcW06Sc2Ll1pDUie4JkBSNbYShdQo72/jLfdArYs75i5zouD8OC
 TCjbeXVKxILQR4GaNAsyoeqjk3Gju2dxGZ+hlT5LFMe140GR8zucxGs4SGQhfIDdpXvF7HF4qdC
 5j2RoSfhOwt1RtUfjOFLLyTPhqcXg3TYOMp//Qtc0A9G5gXVCc8iglG0UfmpG700C1ECD7jCE4G
 AuAmBjbSOqMjPZquKorMIBIoaR
X-Received: by 2002:a05:690c:805:b0:794:c624:f4b2 with SMTP id
 00721157ae682-794c624f7b0mr5909007b3.26.1769906722226; 
 Sat, 31 Jan 2026 16:45:22 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:419e:8d46:1302:65da])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-794828ad9cfsm52105097b3.29.2026.01.31.16.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 16:45:21 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 5/7] spl: Add SPI NAND support via MTD in SPL
Date: Sat, 31 Jan 2026 21:44:54 -0300
Message-Id: <20260201004456.763107-6-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201004456.763107-1-festevam@gmail.com>
References: <20260201004456.763107-1-festevam@gmail.com>
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

