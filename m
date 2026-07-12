Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D545C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 07:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 943258467B;
	Sun, 12 Jul 2026 09:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dMBSN3kQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88ADC8497A; Sun, 12 Jul 2026 09:48:27 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 363AE844F6
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 09:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hehongbo918@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-848882fdb18so1263834b3a.0
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 00:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783842504; x=1784447304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Toboz86njZVU2D2cQOq8PuDc4pSS+hl3UYna91q0zQY=;
 b=dMBSN3kQC1FAPkNY17KFQammEP/dRHuf75emdrYgxBdXikVKIAbRRpUg0XRPVqhQLZ
 BEWodvYFW6hSfv06Nd61jgrz3NVfVKGXikfambe9w/6iH0KSSEfcZV3WE+q0blSp4uiW
 XYtfxnkS/4s6dviv5MR7vk+a89YCg/RBAgVgU7tq8aqOtSv11w17MMlJ4joHnDgk3XqW
 ved3NW/fhDF1uWlu47oYeD9Tz+z77+YCd04bs9pqPJI0pKxD/7M/+iuJoNIk2JpjV5PJ
 vNwGY5zeSt7AUzcEEpMHV98jJMm4+mcixj+ecQKY6q/WS49IhRL1WmdOat9oF/64InmN
 ojMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783842504; x=1784447304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Toboz86njZVU2D2cQOq8PuDc4pSS+hl3UYna91q0zQY=;
 b=XeA4i4JbCJ6vUIkPVAH2dN2LsJe3bVH2tT6TpNdwezd1v1UhLmKfaRRQ0mlLV/8HV5
 xpMTmqYTg1/YBDo3cC9M9zTVeeeEfFcH9aPJG2ETlQJUsAxOeRvM3difRN9Ra+wrAhKS
 h2JqN1zMcejZa7jWyDLfp2zoZPIxjYbyCF5qSkBYj4WwUYKXe0/3/jocH8o/TrPDAMRR
 H1LxJe9aYODaqwTnMINgw2KwESR0kWEb5eI8nXcAwJ7Fdiv08iwGu/fjW+8KG7D32qPC
 y+17tm7n3uz3IGMTgrfacBnJbKfHIR9r9vC9D8TxcvUqDA43Rw93C7s1zniUNvfagi9K
 X6/A==
X-Gm-Message-State: AOJu0YwIE1MJ2N7hToJmpFqpgPPtDxOLpTdzsvNeMDFhgqR84DWVdILX
 TefDMSEVPd0tQJDm2TbJfNMnvanfl7w157HsZLAlNHmbxoyGEz09TOS4V8NAAHMBuMo=
X-Gm-Gg: AfdE7cnW4gfVC5gneuA5070W5WsUqK3rFChCINh/Zu6eto8MLa6+LazkdI/WcaRcBX0
 fMeIIMftjI9YsZw7FIRyD/mgcCCb/LQkEAF9gR/v64fe8goC4Nr5OBz6YPQK+3awRQ91YEIvtic
 W8eZuHdNxzgrR7y2icyiji042P4b8q33Igh+aSjkG62xg+zmyRfnz0NZqU9NGpb9CvJDK1SGqGb
 jzQ2kUy3wsOX2/fnu9tBk8M3uinvv2BsEcxBpiIsnXMBV/dLbTq4dK+/7h5swatSaToucKRteX4
 MfcfdnZxBNv/BpihF8FgrEe4Jf4v5s7sO5cal5hSH1yCuW0oGsrV0oGOblKFzDSsB3fLZqKFe3D
 yeepbGCYl+0atVtd22ziK6ICMKStWpibLIX+rlSQKjdw5ek00xy5K1KfwTs8gaY/BSnva390eQr
 7PpKAC0OxDsXLGF6HOTWU=
X-Received: by 2002:a05:6a00:228f:b0:848:469b:3d19 with SMTP id
 d2e1a72fcca58-84889661524mr4804974b3a.29.1783842503552; 
 Sun, 12 Jul 2026 00:48:23 -0700 (PDT)
Received: from localhost ([39.182.9.207]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d7a96fsm12328652b3a.46.2026.07.12.00.48.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jul 2026 00:48:23 -0700 (PDT)
From: hehongbo918@gmail.com
To: u-boot@lists.denx.de
Cc: Honbo He <hehongbo918@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH] sysreset: esp32: add driver for esp32 series chips
Date: Sun, 12 Jul 2026 15:48:16 +0800
Message-ID: <20260712074817.18856-1-hehongbo918@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Honbo He <hehongbo918@gmail.com>

Add system reset driver for Espressif Gen3 and Gen4 RISC-V SoCs.
The reset register base address, offset, and bit mask are read
from the device tree to support different chip variants without
code changes.

Signed-off-by: Honbo He <hehongbo918@gmail.com>
---
 drivers/sysreset/Kconfig          |  9 ++++
 drivers/sysreset/Makefile         |  1 +
 drivers/sysreset/sysreset_esp32.c | 72 +++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_esp32.c

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 16ef434a8d9..40293442e1c 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -64,6 +64,15 @@ config SYSRESET_CV1800B
 	help
 	  Enable system reset support for Sophgo cv1800b SoC.
 
+config SYSRESET_ESP32
+	bool "Enable support for Espressif esp32 System Reset"
+	help
+	  Enable system reset support for Espressif Gen3 and Gen4
+	  SoCs (C5, C6, C61, H2, H21, H4, P4, S31) Reset register parameters
+	  are configured via device tree.
+	  Gen1/Gen2 chips (ESP32, S2, S3, C2, C3) are not supported
+	  as they rely on the boot ROM for system reset.
+
 config POWEROFF_GPIO
 	bool "Enable support for GPIO poweroff driver"
 	depends on DM_GPIO
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index d18a5d52360..ba3ac235658 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -33,3 +33,4 @@ obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
 obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
 obj-$(CONFIG_SYSRESET_QEMU_VIRT_CTRL) += sysreset_qemu_virt_ctrl.o
+obj-$(CONFIG_SYSRESET_ESP32) += sysreset_esp32.o
diff --git a/drivers/sysreset/sysreset_esp32.c b/drivers/sysreset/sysreset_esp32.c
new file mode 100644
index 00000000000..3d4c619f44f
--- /dev/null
+++ b/drivers/sysreset/sysreset_esp32.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026, Honbo He <hehongbo918@gmail.com>
+ *
+ * System reset driver for Espressif SoCs.
+ *
+ * Supported SoCs (Gen3/4):
+ *  ESP32-C5, ESP32-C6, ESP32-C61, ESP32-H2, ESP32-H21, ESP32-H4,
+ *  ESP32-P4, ESP32-S31
+ *
+ * On the unsupported chips(Gen1/2), the system reset logic resides inside the
+ * RTC_CNTL peripheral and is only accessible through the boot ROM function
+ * software_reset_cpu(). The register definitions are not exposed in the SoC headers,
+ * making it impractical to implement a direct register-based reset
+ * in U-Boot without reverse-engineering the ROM code.
+ */
+
+#include <dm.h>
+#include <stdbool.h>
+#include <sysreset.h>
+#include <wait_bit.h>
+#include <linux/io.h>
+#include <linux/errno.h>
+
+struct esp32_sysreset_priv {
+	void __iomem *base;
+	u32 offset;
+	u32 mask;
+};
+
+static int esp32_sysreset_request(struct udevice *dev, enum sysreset_t type)
+{
+	struct esp32_sysreset_priv *priv = dev_get_priv(dev);
+
+	setbits_le32(priv->base + priv->offset, priv->mask);
+
+	return -EINPROGRESS;
+}
+
+static struct sysreset_ops esp32_sysreset = {
+	.request = esp32_sysreset_request,
+};
+
+static int esp32_sysreset_probe(struct udevice *dev)
+{
+	struct esp32_sysreset_priv *priv = dev_get_priv(dev);
+
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	priv->offset = dev_read_u32_default(dev, "offset", 0);
+	priv->mask = dev_read_u32_default(dev, "mask", 0);
+	if (priv->mask == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct udevice_id esp32s31_sysreset_ids[] = {
+	{ .compatible = "esp,esp32-sysreset", },
+	{},
+};
+
+U_BOOT_DRIVER(sysreset_esp32) = {
+	.name = "esp32s31_sysreset",
+	.id	  = UCLASS_SYSRESET,
+	.ops  = &esp32_sysreset,
+	.of_match = esp32s31_sysreset_ids,
+	.probe = esp32_sysreset_probe,
+	.priv_auto = sizeof(struct esp32_sysreset_priv),
+};
-- 
2.34.1

