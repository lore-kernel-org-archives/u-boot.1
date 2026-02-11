Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89028ECD6F7
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 22:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B14783B64;
	Wed, 11 Feb 2026 23:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LOJxhHgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 793ED83C4B; Wed, 11 Feb 2026 23:26:06 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADE6E8388D
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 23:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-79639c2d2b5so46978917b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 14:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770848762; x=1771453562; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ostaqLHmuJ1oihm6hGVRvgopdHHXf5uomdaJmlqEFok=;
 b=LOJxhHguy6sloG/QB773A1wWR6pXCLFO8AZPahzrY5CkUiMSPvkcXOFEkAi8qShLvu
 /bQUnKEG6vlzfQokCtftWBQv37eSX0QoGPeat8iCVlTyOZqu48xVg6QTbw931xb0aNog
 Ts00x4v7svbZM8AkBVlxfdEBeMXxupHOXwlUNQ1ncnjELeDYQwdOLwdTa9xAkXxIQjiD
 9fBdkQPmXjVAYWC3+QRWeaon3T5j2HrNakTjMtcfFhUZvocudn66pZjC3XzBygHwY6EV
 0uxJjy54kpye75dIjFE037M4EliT3S+bZC30srMJWAnJsDIQ3UjRad0cnStvxDh9GBAK
 MP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848762; x=1771453562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ostaqLHmuJ1oihm6hGVRvgopdHHXf5uomdaJmlqEFok=;
 b=JBycuLtjr9r52HaEWKBL2ZWFsSKxPBEqHHJhizBdRnf2oP7u7ErE3wtxxaNQgX/4g0
 3CrkQVvSZjJpwDQrtfWxgDpvF1ESUfNGlE98A1Us0TataJaPNB64zlcQe6LoZguLyc3K
 9EYrR/NQ2vZ5fBWzKtBfqPuiqrsAlgbyK0CANkafvcFQoHbTltMykaCQDf8aNCyDl1OD
 8KqpBTkl+1w3DgMruI1Irbo95bXvmKp5ivbOJlW0zIWsy7x9jCEGwa2II1mSe8h2EsoY
 CBMbE2nbN+P+22rFpQJUi7HGdTo8nP2I8qAwgtKfRdEdj8FXn5akX6XiGACHpLkO94Gj
 0u5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKxx4NB/OGFBuLEd+OfIBKnE8mX05xS2TWv/It3jcGbjUWGfBkXe77aSu0anNyebNXSHsC5vI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3PG9eGmx3AMdGN3uEXVNI8dmvKGNND37joN4wNyzqzlgHqQ3r
 Mnt+LgadHLAMD1KQnDXf+Su7Vto9EWg6ZlBRCRzrIgEk6ORfEMyR3kfo
X-Gm-Gg: AZuq6aJmDKjzyLKpBSDfMp9O+6PzfLA1D/46J6pbrLWiVXYoNm7V/4kZw74KVYnMPjK
 KYnQmXZ478yZ1F7TRYtakuLAKQBd9WwEia8V+ok/oYAgMu8mnNVx3IwarbmpmQlMPQ65zYBFAZK
 U6bNktu9uYRXZQC/c2TBk5uUN66LDDEXfFh3LcvJkLsrZq4xYRigJ7PkLo0RVMEFoZdzSEBTw0s
 HI9HN2q1Io1Q9qsst13JDY5onlEasQDnk8XPDypzlf8dMpbESYlgHVCa9oWS2YRzGWxrSFUqq4f
 mCak2y4h3a3dbm1DLrg8HdGuVuKY2MVwYdjL/REU7vrCMJmuRiD3SdPAJZlLD/Pwmhib1z8HjkQ
 MhLc9V7R3a9SJMWn8Gxsb8pvDcXV500Dk5JCNyX1UoQ7AFz6NKauZfq7LBHMA1Dve47F1/DxpPm
 j/RM8+ylBwM7AYKTF+JGunIXhBkkOwGVZBxKM=
X-Received: by 2002:a05:690c:4a03:b0:794:747b:b6a6 with SMTP id
 00721157ae682-7972f0de723mr11281937b3.13.1770848762395; 
 Wed, 11 Feb 2026 14:26:02 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:485:4ffb:e36d:8763:a188:5dcb])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7966c18fd06sm28833867b3.17.2026.02.11.14.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:26:01 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: michael@amarulasolutions.com
Cc: dinesh.maniyam@altera.com, jonas@kwiboo.se, trini@konsulko.com,
 u-boot@lists.denx.de, Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH] spl: Add generic SPL MTD loader support
Date: Wed, 11 Feb 2026 19:25:50 -0300
Message-Id: <20260211222550.739727-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add support for loading the next stage from an MTD device in SPL.

Introduce CONFIG_SPL_MTD_LOAD and a generic SPL MTD loader
implementation that uses the MTD subsystem to read the U-Boot payload.

The loader works with any MTD-backed storage, including raw NAND and
SPI NAND, without being tied to a specific NAND type.

The payload offset defaults to CONFIG_SYS_MTD_U_BOOT_OFFS and can be
overridden via the device tree property:

    u-boot,spl-payload-offset

To support both raw NAND and SPI NAND boot flows, the loader is
registered for BOOT_DEVICE_NAND and BOOT_DEVICE_SPI. This allows it
to operate correctly on platforms where the ROM reports either NAND
or SPI as the boot source while using the same MTD-based loading
infrastructure.

The required NAND core and SPI NAND drivers are built for SPL when
CONFIG_SPL_MTD_LOAD is enabled.

This provides reusable infrastructure for boards that boot from MTD
devices without relying on SPI-specific or NAND-specific SPL loaders.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Dinesh,

Could you please test this approach on your boards?

Thanks

 common/spl/Kconfig        | 15 +++++++
 common/spl/Makefile       |  1 +
 common/spl/spl_mtd.c      | 88 +++++++++++++++++++++++++++++++++++++++
 drivers/mtd/Makefile      |  1 +
 drivers/mtd/nand/Makefile | 12 +++++-
 5 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 common/spl/spl_mtd.c

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 2998b7acb75f..2aba6da73c10 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1576,8 +1576,23 @@ config SPL_SPI_LOAD
 	  Enable support for loading next stage, U-Boot or otherwise, from
 	  SPI NOR in U-Boot SPL.
 
+config SPL_MTD_LOAD
+	bool "Support loading from a generic MTD device"
+	depends on SPL
+	depends on MTD && DM_MTD
+	help
+	  Enable support for loading next stage, U-Boot or otherwise, from
+	  a generic MTD device (raw NAND, SPI NAND) in U-Boot SPL.
+
 endif # SPL_SPI_FLASH_SUPPORT
 
+config SYS_MTD_U_BOOT_OFFS
+	hex "address of u-boot payload in the MTD device"
+	default 0x0
+	help
+	 Address within the MTD device where the u-boot payload is fetched
+	 from.
+
 config SYS_SPI_U_BOOT_OFFS
 	hex "address of u-boot payload in SPI flash"
 	default 0x8000 if ARCH_SUNXI
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 4c9482bd3096..9f5ddcad17af 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)NVME) += spl_nvme.o
 obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += spl_semihosting.o
 obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
 obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
+obj-$(CONFIG_$(PHASE_)MTD_LOAD) += spl_mtd.o
 obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
 obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
 endif
diff --git a/common/spl/spl_mtd.c b/common/spl/spl_mtd.c
new file mode 100644
index 000000000000..8c6c94e592d0
--- /dev/null
+++ b/common/spl/spl_mtd.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Generic SPL loader for MTD devices.
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
+#include <errno.h>
+#include <image.h>
+#include <log.h>
+#include <spl.h>
+#include <spl_load.h>
+
+#include <dm.h>
+#include <dm/ofnode.h>
+#include <dm/uclass.h>
+#include <mtd.h>
+
+static struct mtd_info *spl_mtd_get_device(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	for (ret = uclass_first_device_err(UCLASS_MTD, &dev);
+	     dev;
+	     ret = uclass_next_device_err(&dev)) {
+		if (ret)
+			continue;
+
+		return dev_get_uclass_priv(dev);
+	}
+
+	return NULL;
+}
+
+static ulong spl_mtd_read(struct spl_load_info *load,
+			  ulong offs, ulong size, void *buf)
+{
+	struct mtd_info *mtd = load->priv;
+	size_t retlen;
+	int ret;
+
+	ret = mtd_read(mtd, offs, size, &retlen, buf);
+	if (ret && !mtd_is_bitflip(ret))
+		return 0;
+
+	if (retlen != size)
+		return 0;
+
+	return retlen;
+}
+
+static int spl_mtd_load_image(struct spl_image_info *spl_image,
+			      struct spl_boot_device *bootdev)
+{
+	struct spl_load_info load;
+	struct mtd_info *mtd;
+	ulong offset;
+
+	mtd = spl_mtd_get_device();
+	if (!mtd) {
+		debug("No MTD device found\n");
+		return -ENODEV;
+	}
+
+	spl_load_init(&load, spl_mtd_read, mtd, mtd->writesize);
+
+	offset = CONFIG_SYS_MTD_U_BOOT_OFFS;
+
+	if (CONFIG_IS_ENABLED(OF_REAL))
+		offset = ofnode_conf_read_int("u-boot,spl-payload-offset",
+					      offset);
+
+	return spl_load(spl_image, bootdev, &load, 0, offset);
+}
+
+/* Priority 1 so boards may override */
+SPL_LOAD_IMAGE_METHOD("MTD-NAND", 1, BOOT_DEVICE_NAND, spl_mtd_load_image);
+SPL_LOAD_IMAGE_METHOD("MTD-SPI-NAND", 1, BOOT_DEVICE_SPI, spl_mtd_load_image);
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index ce05e206073d..0856a8f68732 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -34,6 +34,7 @@ else
 ifneq ($(mtd-y),)
 obj-$(CONFIG_SPL_MTD) += mtd.o
 endif
+obj-$(CONFIG_SPL_MTD_LOAD) += nand/
 obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += nand/
 obj-$(CONFIG_SPL_ONENAND_SUPPORT) += onenand/
 obj-$(CONFIG_$(PHASE_)SPI_FLASH_SUPPORT) += spi/
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index c8169cf73902..cd6eaa87739c 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,10 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 nandcore-objs := core.o bbt.o
+
+ifeq ($(CONFIG_XPL_BUILD),)
+
+# U-Boot proper
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/
 obj-$(CONFIG_MTD_SPI_NAND) += spi/
+
 else
+
+# XPL
+obj-$(CONFIG_SPL_MTD_LOAD) += nandcore.o
+obj-$(CONFIG_SPL_MTD_LOAD) += spi/
+
+# raw NAND still follows the normal SPL rule
 obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += raw/
 endif
-- 
2.34.1

