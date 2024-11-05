Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986BDD2B92E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 14:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB1918919F;
	Tue,  5 Nov 2024 15:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="byvlA7si";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEFF888360; Tue,  5 Nov 2024 14:27:51 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D35B88FE2
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 14:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so46773415e9.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 05:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730813268; x=1731418068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCECmMvRU/MD+fY5GchFlAxOHCrOCPenw0SnSwzW67E=;
 b=byvlA7sifduiyk2Zy0jODl2odj7Cv4xD40VCpTn66Glc0WCgFMseQ/sDfPl4YUb+RB
 YZY7o+91E2RarZVg9ybpKFCWoNDuiuPKZfdWCDlN4l2m/aNkDfeHIpTt4E2SFbeUTfl4
 IPglG5ezO/sC07Em0R+KB83MXZh13CPsKgNcOorhvGf21QzxhdBcBcVVTaZSqJ+HrQAM
 tZCjXn/xbUkMHJWMRuN3vaFGmYUExJbBT5E1kplSFQ8UdgeB+bJNx9004VchMfucJCYM
 lCM23Ab83EcZdtqPhOkKa+7B83LI/wVTjjORhesZ3j3HMU7otT440arhgY3+gY9yUZvO
 NYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730813268; x=1731418068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCECmMvRU/MD+fY5GchFlAxOHCrOCPenw0SnSwzW67E=;
 b=JkekLEqAckDN/ttBHNDef8tZIL+5u6YhXU0x09dLcHBt8K3+H3Iv9qzkYCBX7tDFmJ
 LIUPVi9AtP9RgErRd/t82BojE+G07qAJV7rBV8nku3nmhy/wPGD0yf2LFAzRHKl+iMao
 tZU8wC+WcXdraa5qcDEUcdjtAOiZkKmzkLOr8+5fX8MlEGipqGNx6MvXDFSUNed1kuhv
 0cSU/qt9IoLX8FaoqNiDTRJmq59SVwPpTmFp9B1VW24XwW8yCo2IIg7BXS6g1KCofnvL
 eScL7dON6e9MvHeh65SmNbaxCz1ztIiDS/M284+lqpn1Uf+z0akXUP49iMbIwiKdRzEM
 L2hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV21sZhLW7YxoNDZBKpfO6BydXIx2YICoSg1PfXdnPeyLlZ3Y/ehEDKCzurkuFQ+x8XZEZ+qdI=@lists.denx.de
X-Gm-Message-State: AOJu0YzOLkHw41RFpxA+nsjHN3HtfwbmK07+pXQTEzjUprTYS4hdr6KP
 SlvHdDuzBwrmVz8DA1VZTe9gIxn5IvtV0JnmlmCyd91gm/dCOGLx
X-Google-Smtp-Source: AGHT+IF/vAxKHuchAYz3EVaIHu+MXM7FBJp3u0jX8WgSg+zKMw6kq8tAnWQRI4L2ywMG/gSjouOESw==
X-Received: by 2002:a5d:64e7:0:b0:37d:49cc:cadc with SMTP id
 ffacd0b85a97d-381be7c20ebmr16121755f8f.32.1730813267465; 
 Tue, 05 Nov 2024 05:27:47 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:61c2:fa6e:7930:6c92])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-381c113e595sm16267906f8f.77.2024.11.05.05.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 05:27:47 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com, michal.simek@amd.com, hs@denx.de, pro@denx.de,
 sjg@chromium.org
Cc: vasileios.amoiridis@cern.ch,
	u-boot@lists.denx.de
Subject: [PATCH v3 1/1] drivers: bootcount: Add ZynqMP specific bootcount
 support
Date: Tue,  5 Nov 2024 14:27:44 +0100
Message-ID: <20241105132744.1572759-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241105132744.1572759-1-vassilisamir@gmail.com>
References: <20241105132744.1572759-1-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 Nov 2024 15:17:31 +0100
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

From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>

Add native support of the bootcount mechanism in the ZynqMP by
utilising internal PMU registers. The Persistent Global Storage
Registers of the Platform Management Unit can keep their value
during reboot cycles unless there is a POR reset, making them
appropriate for the bootcount mechanism.

Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
Reviewed-by: Heiko Schocher <hs@denx.de>
---
 MAINTAINERS                                  |  1 +
 arch/arm/mach-zynqmp/include/mach/hardware.h |  2 +
 drivers/bootcount/Kconfig                    |  7 +++
 drivers/bootcount/Makefile                   |  1 +
 drivers/bootcount/bootcount_zynqmp.c         | 47 ++++++++++++++++++++
 5 files changed, 58 insertions(+)
 create mode 100644 drivers/bootcount/bootcount_zynqmp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0399ed1dbf..bc27a514e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -860,6 +860,7 @@ M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
 F:	arch/arm/mach-zynqmp/
+F:	drivers/bootcount/bootcount_zynqmp.c
 F:	drivers/clk/clk_zynqmp.c
 F:	driver/firmware/firmware-zynqmp.c
 F:	drivers/fpga/zynqpl.c
diff --git a/arch/arm/mach-zynqmp/include/mach/hardware.h b/arch/arm/mach-zynqmp/include/mach/hardware.h
index 49e449ebd6..3c372bd6dc 100644
--- a/arch/arm/mach-zynqmp/include/mach/hardware.h
+++ b/arch/arm/mach-zynqmp/include/mach/hardware.h
@@ -188,6 +188,8 @@ struct pmu_regs {
 	u32 gen_storage4; /* 0x40 */
 	u32 reserved1[1];
 	u32 gen_storage6; /* 0x48 */
+	u32 reserved2[3];
+	u32 pers_gen_storage2; /* 0x58 */
 };
 
 #define pmu_base ((struct pmu_regs *)ZYNQMP_PMU_BASEADDR)
diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index fa6d8e7128..0080d2a165 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -164,6 +164,13 @@ config DM_BOOTCOUNT_SYSCON
 
 	  Accessing the backend is done using the regmap interface.
 
+config DM_BOOTCOUNT_ZYNQMP
+	bool "Support ZynqMP PMUFW as a backing store for bootcount"
+	depends on ARCH_ZYNQMP
+	help
+	  Enable support for the bootcount API by utilising the Persistent
+	  Global General Storage Register 2 of the PMU.
+
 endmenu
 
 endif
diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
index 245f879633..0cf79e428d 100644
--- a/drivers/bootcount/Makefile
+++ b/drivers/bootcount/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_DM_BOOTCOUNT_I2C_EEPROM)	+= i2c-eeprom.o
 obj-$(CONFIG_DM_BOOTCOUNT_I2C)	+= bootcount_dm_i2c.o
 obj-$(CONFIG_DM_BOOTCOUNT_SPI_FLASH)	+= spi-flash.o
 obj-$(CONFIG_DM_BOOTCOUNT_SYSCON) += bootcount_syscon.o
+obj-$(CONFIG_DM_BOOTCOUNT_ZYNQMP)	+= bootcount_zynqmp.o
diff --git a/drivers/bootcount/bootcount_zynqmp.c b/drivers/bootcount/bootcount_zynqmp.c
new file mode 100644
index 0000000000..bc0984e2d2
--- /dev/null
+++ b/drivers/bootcount/bootcount_zynqmp.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+// SPDX-FileCopyrightText: 2024 CERN (home.cern)
+
+#include <bootcount.h>
+#include <dm.h>
+#include <stdio.h>
+#include <zynqmp_firmware.h>
+#include <asm/arch/hardware.h>
+#include <dm/platdata.h>
+
+static int bootcount_zynqmp_set(struct udevice *dev, const u32 val)
+{
+	int ret;
+
+	ret = zynqmp_mmio_write((ulong)&pmu_base->pers_gen_storage2, 0xFF, val);
+	if (ret)
+		pr_info("%s write fail\n", __func__);
+
+	return ret;
+}
+
+static int bootcount_zynqmp_get(struct udevice *dev, u32 *val)
+{
+	int ret;
+
+	*val = 0;
+	ret = zynqmp_mmio_read((ulong)&pmu_base->pers_gen_storage2, val);
+	if (ret)
+		pr_info("%s read fail\n", __func__);
+
+	return ret;
+}
+
+U_BOOT_DRVINFO(bootcount_zynqmp) = {
+	.name = "bootcount_zynqmp",
+};
+
+static const struct bootcount_ops bootcount_zynqmp_ops = {
+	.get = bootcount_zynqmp_get,
+	.set = bootcount_zynqmp_set,
+};
+
+U_BOOT_DRIVER(bootcount_zynqmp) = {
+	.name = "bootcount_zynqmp",
+	.id = UCLASS_BOOTCOUNT,
+	.ops = &bootcount_zynqmp_ops,
+};
-- 
2.34.1

