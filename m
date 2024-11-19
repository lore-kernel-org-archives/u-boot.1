Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E01D6C2BA
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4998089649;
	Wed, 20 Nov 2024 01:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aSdjE9d8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD3488DB2; Tue, 19 Nov 2024 23:47:03 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 298E588D7E
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3824a646667so297519f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732056415; x=1732661215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KeAduFPWr2ikKTjftpTJV5pNhlNpnBW6QC7+sd5A7k=;
 b=aSdjE9d8K6EhB6IrMGQWt1DjJpoXJ2G24TR2pNeswbSF9eL2QSGc6EM13oZJRNxAGF
 qfsWPix+EaTJyYpLCN6n8dp56y9K0ll+M7Kc9BeaNLIuG0iZ8xd5xVRwm/66GBYvWIrp
 v8/qdTAoB1zvhA6nS/3aoMlQTMmR1yll0Idv6sDt26PigCVLoTqD3LGUUPeHalyTs3ev
 BrVh6Lvwbl7lV5Wohkf4eX2o3UojNIPzWBsYo02EkAAuNfQScTLjJFnOdkv7NupWGGKa
 tdcdCdWKq0M7YwUo8/24Js90+2HPrtiB0CZVgkPEpDVaJHv4aiQHPZAuLTOjeA/DKkR9
 zbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732056415; x=1732661215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9KeAduFPWr2ikKTjftpTJV5pNhlNpnBW6QC7+sd5A7k=;
 b=ANMx36RdTx9wbZ7YwnjrB2jB5lZQoobcOHRwAaKtOYcxNUtArtrFOhZYaSOvWPnI0H
 9kmydnr+vCISG2X6qQtAXfSjgXqE4GoRAxNxB3eN7GB0CSTWu+O3xnc2ZkR+yfwoDCqk
 TMV+2Don8+sCt8qPjWV6F1ViC/Hz5tHoUriQoXPN+QpUZwY7B1tu+R5J5boqdkmbaPBq
 Q99jFcFIRck3FMSB6VJI3m3+Jv5GbjvzcbHsMPbSMkB9N25KB2LrVQl5FV3c1Aeehgdi
 vT+j1UOEMkmUpF8/Ov5VT2gV3MXlXKI/BijYEP8veoafqp7nV5BilAKgn333bo5pWm1u
 bO7Q==
X-Gm-Message-State: AOJu0Ywufv3Xrb0jAZQM3P6XViVFAZbZormPpH4q6JnEeEaAYjpHp12r
 iju6pZTg5stIWFscWifKF2F48ehZ8vQ6vQVcDOrO/ldCxIOru3tlfBTzH3GR
X-Gm-Gg: ASbGncta4gccFzx4Em9/8VRbwhmCpGVduRZHJoBa4KYu2jMEUY9knnT4k7jwXLQoHUB
 iDsUqzOOr13qncfp2wCjGk9B97esKSc0zC+JFs/FIta67Mqo+K9+3hns4MmI1l5q37tBGM2xYYe
 eTi+bOu/C8IngPZ2yBfBpF9cyF2oS3B0S8td+OOwivQUtk/yw608dbAM/fdk6oGDqtC9J1r05kG
 XcdJ5CInXQkKn50ZwE3VbyfPYIR28TzDvE38KWJtbesAczdSNHfgB+dZIUPoQODCX5cVVKhs5SW
 gBbhyQS6zWPbmmb2g/AM38cINLwg
X-Google-Smtp-Source: AGHT+IFghRo58/rw6+TnXr7fymOaH0vDPHBeXWRAlPX3a3Mi6Q8nsCXt5p9wU57RZQxo+dIh70jdUA==
X-Received: by 2002:a05:600c:4f82:b0:431:558c:d9e9 with SMTP id
 5b1f17b1804b1-4334f01d8c0mr2182325e9.5.1732056415512; 
 Tue, 19 Nov 2024 14:46:55 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27fc8esm216979795e9.21.2024.11.19.14.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:46:55 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 v5 06/10] ARM: socfpga: AA1: support MAC from secure eeprom
Date: Tue, 19 Nov 2024 22:46:39 +0000
Message-Id: <20241119224643.27692-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241119224643.27692-1-l.rubusch@gmail.com>
References: <20241119224643.27692-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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

Several Enclustra devices store MAC address in a secure eeprom device. In
most cases this is the atsha204a (alternatively DS28). The atsha204a device
is preconfigured accordingly. Reading then is based on u-boot's atsha204a
driver. Add such support for Enclustra's AA1 SoMs.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/mach-socfpga/Kconfig                 |   2 +-
 board/enclustra/common/Kconfig                |  25 +++++
 board/enclustra/common/Makefile               |   3 +
 board/enclustra/common/enclustra_mac.h        |  48 +++++++++
 board/enclustra/common/mac_atsha204.c         | 102 ++++++++++++++++++
 board/enclustra/common/mac_common.c           |  52 +++++++++
 board/enclustra/common/mac_ds28.c             |  93 ++++++++++++++++
 board/enclustra/mercury_aa1/Makefile          |   2 +
 .../mercury_aa1/aa1_board_late_init.c         |  17 +++
 .../socfpga_enclustra_mercury_aa1_defconfig   |   1 +
 10 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 board/enclustra/common/Kconfig
 create mode 100644 board/enclustra/common/enclustra_mac.h
 create mode 100644 board/enclustra/common/mac_atsha204.c
 create mode 100644 board/enclustra/common/mac_common.c
 create mode 100644 board/enclustra/common/mac_ds28.c
 create mode 100644 board/enclustra/mercury_aa1/aa1_board_late_init.c

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index b7de86e934..60d8c889dc 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -297,6 +297,6 @@ config SYS_CONFIG_NAME
 	default "socfpga_stratix10_socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
 	default "socfpga_vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
 
-source "board/enclustra/mercury_aa1/Kconfig"
+source "board/enclustra/common/Kconfig"
 
 endif
diff --git a/board/enclustra/common/Kconfig b/board/enclustra/common/Kconfig
new file mode 100644
index 0000000000..4ba082e5e7
--- /dev/null
+++ b/board/enclustra/common/Kconfig
@@ -0,0 +1,25 @@
+config ENCLUSTRA_EEPROM_MAC
+	bool "Enclustra MAC address"
+	select ATSHA204A
+	depends on TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1
+	default y
+	help
+	  Reads the MAC address out of the EEPROM and configures the MAC
+	  addresses in the environment.
+
+choice
+	prompt "Enclustra EEPROM device"
+	depends on ENCLUSTRA_EEPROM_MAC
+	default ENCLUSTRA_EEPROM_MAC_ATSHA204 if TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1
+	help
+	  Specify the device where the MAC is stored.
+
+config ENCLUSTRA_EEPROM_MAC_ATSHA204
+	bool "MAC stored in 'ATSHA204'"
+
+config ENCLUSTRA_EEPROM_MAC_DS28
+	bool "MAC stored in 'DS28'"
+
+endchoice
+
+source "board/enclustra/mercury_aa1/Kconfig"
diff --git a/board/enclustra/common/Makefile b/board/enclustra/common/Makefile
index 16c8531d74..c83743abe7 100644
--- a/board/enclustra/common/Makefile
+++ b/board/enclustra/common/Makefile
@@ -2,3 +2,6 @@
 # Copyright (c) 2024 Enclustra GmbH
 
 # Common for several Enclustra modules
+obj-$(CONFIG_ENCLUSTRA_EEPROM_MAC) += mac_common.o
+obj-$(CONFIG_ENCLUSTRA_EEPROM_MAC_ATSHA204) += mac_atsha204.o
+obj-$(CONFIG_ENCLUSTRA_EEPROM_MAC_DS28) += mac_ds28.o
diff --git a/board/enclustra/common/enclustra_mac.h b/board/enclustra/common/enclustra_mac.h
new file mode 100644
index 0000000000..9631e9d458
--- /dev/null
+++ b/board/enclustra/common/enclustra_mac.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+
+ *
+ * Copyright 2024 Enclustra GmbH, <info@enclustra.com>
+ */
+
+#ifndef ENCLUSTRA_MAC
+# define ENCLUSTRA_MAC               0xF7B020
+#endif
+
+/*
+ * enclustra_mac_is_in_env - Check if MAC address is already set
+ *
+ * @env: name of the environment variable
+ * Return: true if MAC is set, false otherwise
+ */
+bool enclustra_mac_is_in_env(const char *env);
+
+/*
+ * enclustra_get_mac_is_enabled - Test if ethernet MAC is enabled in DT
+ *
+ * @alias: alias for ethernet MAC device tree node
+ * Return: 0 if OK, other value on error
+ */
+int enclustra_get_mac_is_enabled(const char *alias);
+
+/*
+ * enclustra_get_mac_from_eeprom - Get MAC address from eeprom and write it to enetaddr
+ *
+ * @enetaddr: buffer where address is to be stored
+ * @alias: alias for EEPROM device tree node
+ * Return: 0 if OK, other value on error
+ */
+int enclustra_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias);
+
+/*
+ * enclustra_get_mac1_from_mac - Get MAC1 address from MAC and write it to enetaddr
+ *
+ * @enetaddr: buffer where MAC is passed, MAC will be modified to MAC1
+ * Return: 0 if OK, else error value
+ */
+int enclustra_get_mac1_from_mac(unsigned char *enetaddr);
+
+/*
+ * enclustra_setup_mac_address - Try to get MAC address from various locations and write it to env
+ *
+ * Return: 0 if OK, other value on error
+ */
+int enclustra_setup_mac_address(void);
diff --git a/board/enclustra/common/mac_atsha204.c b/board/enclustra/common/mac_atsha204.c
new file mode 100644
index 0000000000..d582bfde0a
--- /dev/null
+++ b/board/enclustra/common/mac_atsha204.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Enclustra GmbH
+ */
+
+#include <dm.h>
+#include <atsha204a-i2c.h>
+#include <net.h>
+
+#include "enclustra_mac.h"
+
+int enclustra_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias)
+{
+	struct udevice *dev;
+	u32 hwaddr_h;
+	u8 data[4];
+	int i, j, eeprom_addr, mac_len, ret;
+
+	ret = uclass_get_device_by_name(UCLASS_MISC, alias, &dev);
+	if (ret) {
+		printf("%s: Failed, cannot find EEPROM! ret = %d\n", __func__, ret);
+		return ret;
+	}
+
+	/* Make sure atsha204a is in a defined state (part of protocol) */
+	ret = atsha204a_sleep(dev);
+	if (ret) {
+		printf("%s(): Failed to bring EEPROM in defined state\n", __func__);
+		return ret;
+	}
+
+	ret = atsha204a_wakeup(dev);
+	if (ret) {
+		printf("%s(): Failed to wakeup EEPROM\n", __func__);
+		return ret;
+	}
+
+	/*
+	 * Read twice portions of 4 bytes (atsha204 protocol). One from address
+	 * 4 the other from address 5 of the OTP zone. Then convert the data to
+	 * the 6 elements of the MAC address.
+	 */
+	eeprom_addr = 4;
+	mac_len = 6;
+	for (i = 0; i < 2; i++) {
+		eeprom_addr += i;
+		if (atsha204a_read(dev, ATSHA204A_ZONE_OTP, false, eeprom_addr, data)) {
+			printf("%s(): Failed to parse ATSHA204A_ZONE_OTP of EEPROM\n",
+			       __func__);
+			return -EFAULT;
+		}
+
+		for (j = 0; j < 4 && j + i * 4 < mac_len; j++)
+			enetaddr[j + i * 4] = data[j];
+	}
+
+	/*
+	 * Check if the value is a valid mac registered for
+	 * Enclustra GmbH
+	 */
+	hwaddr_h = enetaddr[0] | (enetaddr[1] << 8) | (enetaddr[2] << 16);
+	if ((hwaddr_h & 0xFFFFFF) != ENCLUSTRA_MAC) {
+		printf("%s(): Failed, parsed MAC is no Enclustra MAC\n", __func__);
+		return -ENOENT;
+	}
+
+	if (!is_valid_ethaddr(enetaddr)) {
+		printf("%s(): Failed, address read from EEPROM is invalid!\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	printf("ethaddr set to %pM\n", enetaddr);
+
+	return 0;
+}
+
+int enclustra_setup_mac_address(void)
+{
+	unsigned char enetaddr[6];
+	int ret;
+
+	if (enclustra_mac_is_in_env("ethaddr"))
+		return 0;
+
+	if (enclustra_get_mac_is_enabled("ethernet0"))
+		return 0;
+
+	ret = enclustra_get_mac_from_eeprom(enetaddr, "atsha204a@64");
+	if (ret)
+		return ret;
+
+	ret = eth_env_set_enetaddr("ethaddr", enetaddr);
+	if (ret)
+		return ret;
+
+	if (!enclustra_get_mac1_from_mac(enetaddr))
+		return eth_env_set_enetaddr("eth1addr", enetaddr);
+
+	printf("%s(): Failed, unable to set MAC address!\n", __func__);
+	return -ENXIO;
+}
diff --git a/board/enclustra/common/mac_common.c b/board/enclustra/common/mac_common.c
new file mode 100644
index 0000000000..3304a8987c
--- /dev/null
+++ b/board/enclustra/common/mac_common.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Enclustra GmbH
+ */
+
+#include <dm.h>
+#include <atsha204a-i2c.h>
+#include <net.h>
+
+#include "enclustra_mac.h"
+
+bool enclustra_mac_is_in_env(const char *env)
+{
+	unsigned char enetaddr[6];
+
+	return eth_env_get_enetaddr(env, enetaddr);
+}
+
+int enclustra_get_mac_is_enabled(const char *alias)
+{
+	ofnode node =   ofnode_path(alias);
+
+	if (!ofnode_valid(node))
+		return -EINVAL;
+
+	if (!ofnode_is_enabled(node))
+		return -EINVAL;
+
+	return 0;
+}
+
+int enclustra_get_mac1_from_mac(unsigned char *enetaddr)
+{
+	u32 hwaddr_h;
+
+	/* Increment MAC addr */
+	hwaddr_h = (enetaddr[3] << 16) | (enetaddr[4] << 8) | enetaddr[5];
+	hwaddr_h = (hwaddr_h + 1) & 0xFFFFFF;
+	enetaddr[3] = (hwaddr_h >> 16) & 0xFF;
+	enetaddr[4] = (hwaddr_h >> 8) & 0xFF;
+	enetaddr[5] = hwaddr_h & 0xFF;
+
+	if (!is_valid_ethaddr(enetaddr)) {
+		printf("%s(): Failed, address computed from enetaddr is invalid!\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	printf("eth1addr set to %pM\n", enetaddr);
+
+	return 0;
+}
diff --git a/board/enclustra/common/mac_ds28.c b/board/enclustra/common/mac_ds28.c
new file mode 100644
index 0000000000..49c3a05317
--- /dev/null
+++ b/board/enclustra/common/mac_ds28.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Enclustra GmbH
+ */
+
+#include <linux/compat.h>
+#include <dm.h>
+#include <i2c.h>
+#include <net.h>
+
+#include "enclustra_mac.h"
+
+#define DS28_I2C_ADDR 0x5C
+#define DS28_SYS_I2C_EEPROM_BUS 0
+
+int enclustra_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias)
+{
+	struct udevice *dev;
+	u32 hwaddr_h;
+	struct dm_i2c_chip *chip;
+	uint chip_addr = DS28_I2C_ADDR;
+	int alen = 1;
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(DS28_SYS_I2C_EEPROM_BUS, chip_addr,
+				      alen, &dev);
+	if (ret)
+		return ret;
+
+	chip = dev_get_parent_plat(dev);
+	if (chip->offset_len != alen) {
+		debug("I2C chip %x: alen %d does not match offset_len %d\n",
+		      chip_addr, alen, chip->offset_len);
+		return -EADDRNOTAVAIL;
+	}
+
+	ret = dm_i2c_read(dev, 0x10, enetaddr, 6);
+	if (ret) {
+		printf("%s(): Failed reading EEPROM! ret = %d\n", __func__, ret);
+		return ret;
+	}
+
+	/*
+	 * Check if the value is a valid mac registered for
+	 * Enclustra  GmbH
+	 */
+	hwaddr_h = enetaddr[0] | (enetaddr[1] << 8) | (enetaddr[2] << 16);
+	if ((hwaddr_h & 0xFFFFFF) != ENCLUSTRA_MAC) {
+		printf("%s(): Failed, parsed MAC is no Enclustra MAC\n", __func__);
+		return -ENOENT;
+	}
+
+	if (!is_valid_ethaddr(enetaddr)) {
+		printf("%s(): Failed, address read from EEPROM is invalid!\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	printf("ethaddr set to %pM\n", enetaddr);
+
+	return 0;
+}
+
+int enclustra_setup_mac_address(void)
+{
+	unsigned char enetaddr[6];
+	int ret;
+
+	if (enclustra_mac_is_in_env("ethaddr"))
+		return 0;
+
+	if (enclustra_get_mac_is_enabled("ethernet0"))
+		return 0;
+
+	/*
+	 * Note: DS28 is still not available in official DT, so referencing
+	 * here by i2c busnumber and address directly
+	 * preparation for DT access here, though
+	 */
+	ret = enclustra_get_mac_from_eeprom(enetaddr, "");
+	if (ret)
+		return ret;
+
+	ret = eth_env_set_enetaddr("ethaddr", enetaddr);
+	if (ret)
+		return ret;
+
+	if (!enclustra_get_mac1_from_mac(enetaddr))
+		return eth_env_set_enetaddr("eth1addr", enetaddr);
+
+	printf("%s(): Failed, unable to set MAC address!\n", __func__);
+	return -ENXIO;
+}
diff --git a/board/enclustra/mercury_aa1/Makefile b/board/enclustra/mercury_aa1/Makefile
index 53c84d8156..b145254466 100644
--- a/board/enclustra/mercury_aa1/Makefile
+++ b/board/enclustra/mercury_aa1/Makefile
@@ -6,3 +6,5 @@ ifeq ($(CONFIG_SPL_BUILD),)
 obj-y += aa1_set_storage_cmd.o
 
 endif
+
+obj-y += aa1_board_late_init.o
diff --git a/board/enclustra/mercury_aa1/aa1_board_late_init.c b/board/enclustra/mercury_aa1/aa1_board_late_init.c
new file mode 100644
index 0000000000..2e8f8459e3
--- /dev/null
+++ b/board/enclustra/mercury_aa1/aa1_board_late_init.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Enclustra GmbH
+ * <info@enclustra.com>
+ */
+
+#include <env.h>
+#include <init.h>
+#include <dm/uclass.h>
+#include <dm.h>
+
+#include "../common/enclustra_mac.h"
+
+int board_late_init(void)
+{
+	return enclustra_setup_mac_address();
+}
diff --git a/configs/socfpga_enclustra_mercury_aa1_defconfig b/configs/socfpga_enclustra_mercury_aa1_defconfig
index 6a2434fe5a..5f52a30e9d 100644
--- a/configs/socfpga_enclustra_mercury_aa1_defconfig
+++ b/configs/socfpga_enclustra_mercury_aa1_defconfig
@@ -28,6 +28,7 @@ CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
 CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_CLOCKS=y
 CONFIG_SPL_PAD_TO=0x40000
 CONFIG_SPL_NO_BSS_LIMIT=y
-- 
2.39.2

