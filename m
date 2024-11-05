Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A43D1269F
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 12:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E068904A;
	Tue,  5 Nov 2024 13:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H6EgYtXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2829488FAA; Tue,  5 Nov 2024 08:49:27 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C90788FD0
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 08:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c941623a5aso10784045a12.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 23:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730792963; x=1731397763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebLgqSp/hV3Q4+yg6SMcgaRL321DP+0bY2DlyUsrOqU=;
 b=H6EgYtXygZUuRc/a5+1jshJKQFr6xs33KuPTui8YLmRjS9894dp8jodYWTgCnhyFlG
 3gXo/6C5woOdRAekmUypsgnWOovVEZHDpCC2dVR9fEeVtsUrbHVnEg22qqw2yJ4vaorD
 fxo4EU4qLIkslpAx6VcT17srKfdcl/AydDwAe9s1ACoXDqCK1xdEByP6QWsgf8BWpEap
 YqmVbVvA6FPBSb4H/tllvNqLz0UZYmPjCtafSkpwVdGDbLJOlevdAU0vC8YDRX8jPVWt
 LFyYmTGXK9OuVkix8uTgGXCHEhhYYq8ApAxY30WHdk6YpDTUWw1elz0EwOCssCVSkaYp
 VwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730792963; x=1731397763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebLgqSp/hV3Q4+yg6SMcgaRL321DP+0bY2DlyUsrOqU=;
 b=xBh2EmW6fOSe7V16NALJZPWjYIjoFd/eFwnUjT/Jg/fAAukaZOOEeEEeyGVM2BhwMM
 QkaCnk3VZuz8ZxR2ex7vVWunoeC/Q44MBkvU1KPwFjk1xev/Hcu/hBrdCjBIBd9KJCBz
 GPnpXMLqc9zCjeJj2SKK8gqPbIq44l11Fk9mPDV31Mqm2Z2qQscDa9udRSNscvO/dkl0
 iaRkae7U/SKEtvoQ2U5S6HkPPy3DnDHVU4Icd7/tMLq3ySxyQlH5CgsYCiw5vA2cmOrw
 1I/HBOXQ5MlLzRuLEW+Ztva46pmU/aAwzRhDCNKcGXsd0ldkDY9hzqc9N/QLsCzmIKkf
 am2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzAgX7MLq1RRM4rFXFUYghzS6Ucacd0SJbG5aiYSWmUCqWgu2YVaHOM1IVC0FF0M5Sw0XENVM=@lists.denx.de
X-Gm-Message-State: AOJu0YxTB756gdAJxSfA6047PUY1ZT2B+iAHd3yn5NpN0A5eqmhdX4U6
 6Juw8XEDEesRVzkqXMDslqIjvwOhDvBoihqB+C8+RqyBE3ibwGEbOJvBoQ==
X-Google-Smtp-Source: AGHT+IGDac+8RckCsoY6jRj5RgEXU5qCVSkE7QTT4QIK4F81H7rz5ZydovBL2tBbWSnvCaFPIUHqAw==
X-Received: by 2002:a17:907:268a:b0:a9a:f19:8c2a with SMTP id
 a640c23a62f3a-a9e652adedfmr1469525166b.6.1730792962767; 
 Mon, 04 Nov 2024 23:49:22 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:61c2:fa6e:7930:6c92])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a9eb17f4b94sm92372166b.135.2024.11.04.23.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 23:49:22 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com, michal.simek@amd.com, hs@denx.de, pro@denx.de,
 sjg@chromium.org
Cc: vasileios.amoiridis@cern.ch,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/1] drivers: bootcount: Add ZynqMP specific bootcount
 support
Date: Tue,  5 Nov 2024 08:49:17 +0100
Message-ID: <20241105074917.546887-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241105074917.546887-1-vassilisamir@gmail.com>
References: <20241105074917.546887-1-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 Nov 2024 13:47:04 +0100
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
---
 MAINTAINERS                                  |  1 +
 arch/arm/mach-zynqmp/include/mach/hardware.h |  2 +
 drivers/bootcount/Kconfig                    |  6 +++
 drivers/bootcount/Makefile                   |  1 +
 drivers/bootcount/bootcount_zynqmp.c         | 47 ++++++++++++++++++++
 5 files changed, 57 insertions(+)
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
index fa6d8e7128..f91074d5b4 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -164,6 +164,12 @@ config DM_BOOTCOUNT_SYSCON
 
 	  Accessing the backend is done using the regmap interface.
 
+config DM_BOOTCOUNT_ZYNQMP
+	bool "Support ZynqMP PMUFW as a backing store for bootcount"
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
index 0000000000..060bbdbae9
--- /dev/null
+++ b/drivers/bootcount/bootcount_zynqmp.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+// SPDX-FileCopyrightText: 2024 CERN (home.cern)
+
+#include <asm/arch/hardware.h>
+#include <bootcount.h>
+#include <dm.h>
+#include <dm/platdata.h>
+#include <stdio.h>
+#include <zynqmp_firmware.h>
+
+static int bootcount_zynqmp_set(struct udevice *dev, const u32 val)
+{
+	int ret;
+
+	ret = zynqmp_mmio_write((ulong)&pmu_base->pers_gen_storage2, 0xFF, val);
+	if (ret)
+		pr_info("%s mio write fail\n", __func__);
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
+		pr_info("%s mio write fail\n", __func__);
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

