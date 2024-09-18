Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17660CDD541
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A442A88F6D;
	Wed, 18 Sep 2024 17:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="K+KjCtfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54A4688F67; Wed, 18 Sep 2024 17:22:37 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5092188F4D
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8d64b27c45so917222766b.3
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672954; x=1727277754; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGmQNVnwMgqJWw2V9noTFVDpJGX2ko2WHTW4N7XqbjU=;
 b=K+KjCtfMsOALFW+9e7xI22rZL/gwbyJjfjZQ7w8VmEEtIUdQOXvby/N8/dr/W7171b
 0i+EjYpPqpq5bViZSsjnHyqUTGpTsQbeVtUI+vvf5IfmbSykgwZXaqAm+0c4C9PrZ7rV
 RhlHw78rlu6q9Trz9WpRN2U6h4TCN8xYaK3xJLwSxVyw7fPND5ttsX7nSf5YRDbxOOki
 HIk4v3xoS+eMIqnyBkY372G3lBDRtcCBrwPExfzfXStmI+tygR1psvaiThKHHSCpRNJC
 JThOhTz+dAtxK9FJxNiezW7bEFgtdbSFWul/Hm70/04FyFVNOnAQ0PtoeYynDHzTBdyf
 tTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672954; x=1727277754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGmQNVnwMgqJWw2V9noTFVDpJGX2ko2WHTW4N7XqbjU=;
 b=cDbpSogFs7y/dCCHA46a3kt1GGtnRSDj3gpYXjoL+xQr3PzFgVtEolvb72ND7F5Xmu
 kU7BkMiD5IH5OY9qCp/IiNer96CKAdKPXlztL/Y8jg31CLc75itnXQLPec/dHQbj4W2R
 lQF1YmAeZ3iMxH57Bnp/y2mxrhV+T7IEk7c71t39fhxXJw6UF89AQlStx3cjFEfCLtUO
 6w6rmVxUaZq3GZc6XJCait+7oNjD84SEJ+GDbbhGEECmWeeji+TEo6js5VgbQ9zs10ko
 ZUo2jIILrGjR4Udd/EcdPFYqWCnGXnHeTow1pIfWP3BkVIeygD5mzbd5SJ+CI4vGSX/y
 ljJA==
X-Gm-Message-State: AOJu0YxHEArIcpngMhV2+SO5ok7PQ5ctPG/isS7YTmE9BFnk1KmKoyOd
 OKn4ELrtoJbnt6Sch+0csPoV8oR2BYBeLxhNJxc9oSvbhANZfU0jERNSpCLwxbbyk7JyWQcN4P4
 v
X-Google-Smtp-Source: AGHT+IEVkKZATYwuPlnQKLFanbssdMNEpIeaJ9on7H+7vB9fXKPAJ5Q5fYaH65CCoGMNCw9hO1Gz/g==
X-Received: by 2002:a17:907:7ba2:b0:a8d:e49:c505 with SMTP id
 a640c23a62f3a-a9048108047mr1721640266b.45.1726672953691; 
 Wed, 18 Sep 2024 08:22:33 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:33 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 18/35] drivers/cpu: Add generic armv8 cpu driver
Date: Wed, 18 Sep 2024 17:20:22 +0200
Message-ID: <20240918152136.3395170-19-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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

Add a generic driver that binds to armv8 CPU nodes. The generic driver allows
- to enumerate CPUs present in a system, even when no other driver binds it
- generates ACPI SSDT code for each CPU
- Fill the ACPI MADT table (implemented in a follow up patch)

The newly introduced code could also be reused on other CPU drivers that are
compatible with armv8.

TEST: Booted on QEMU sbsa and verify the driver binds to CPU nodes.
      Confirmed with FWTS that all ACPI processor devices are present.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
---
Changelog v4:
- Export armv8_cpu_fill_ssdt to use it in other CPU drivers

---
 drivers/cpu/Kconfig     |  6 ++++
 drivers/cpu/Makefile    |  2 ++
 drivers/cpu/armv8_cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++
 drivers/cpu/armv8_cpu.h | 21 ++++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 drivers/cpu/armv8_cpu.c
 create mode 100644 drivers/cpu/armv8_cpu.h

diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
index 5c06cd9f60..9c0df331d7 100644
--- a/drivers/cpu/Kconfig
+++ b/drivers/cpu/Kconfig
@@ -26,6 +26,12 @@ config CPU_RISCV
 	help
 	  Support CPU cores for RISC-V architecture.
 
+config CPU_ARMV8
+	bool "Enable generic ARMv8 CPU driver"
+	depends on CPU && ARM64
+	help
+	  Support CPU cores for armv8 architecture.
+
 config CPU_MICROBLAZE
 	bool "Enable Microblaze CPU driver"
 	depends on CPU && MICROBLAZE
diff --git a/drivers/cpu/Makefile b/drivers/cpu/Makefile
index bc75d9b974..773395693a 100644
--- a/drivers/cpu/Makefile
+++ b/drivers/cpu/Makefile
@@ -6,10 +6,12 @@
 
 obj-$(CONFIG_CPU) += cpu-uclass.o
 
+
 obj-$(CONFIG_ARCH_BMIPS) += bmips_cpu.o
 obj-$(CONFIG_ARCH_IMX8) += imx8_cpu.o
 obj-$(CONFIG_ARCH_AT91) += at91_cpu.o
 obj-$(CONFIG_ARCH_MEDIATEK) += mtk_cpu.o
+obj-$(CONFIG_CPU_ARMV8) += armv8_cpu.o
 obj-$(CONFIG_CPU_IMX) += imx8_cpu.o
 obj-$(CONFIG_CPU_MPC83XX) += mpc83xx_cpu.o
 obj-$(CONFIG_CPU_RISCV) += riscv_cpu.o
diff --git a/drivers/cpu/armv8_cpu.c b/drivers/cpu/armv8_cpu.c
new file mode 100644
index 0000000000..1572e087e0
--- /dev/null
+++ b/drivers/cpu/armv8_cpu.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 9elements GmbH
+ */
+#include <acpi/acpigen.h>
+#include <asm/armv8/cpu.h>
+#include <cpu.h>
+#include <dm.h>
+#include <dm/acpi.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/printk.h>
+#include <linux/sizes.h>
+
+static int armv8_cpu_get_desc(const struct udevice *dev, char *buf, int size)
+{
+	int cpuid;
+
+	cpuid = (read_midr() & MIDR_PARTNUM_MASK) >> MIDR_PARTNUM_SHIFT;
+
+	snprintf(buf, size, "CPU MIDR %04x", cpuid);
+
+	return 0;
+}
+
+static int armv8_cpu_get_info(const struct udevice *dev,
+			      struct cpu_info *info)
+{
+	info->cpu_freq = 0;
+	info->features = BIT(CPU_FEAT_L1_CACHE) | BIT(CPU_FEAT_MMU);
+
+	return 0;
+}
+
+static int armv8_cpu_get_count(const struct udevice *dev)
+{
+	return uclass_id_count(UCLASS_CPU);
+}
+
+#ifdef CONFIG_ACPIGEN
+int armv8_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	uint core_id = dev_seq(dev);
+
+	acpigen_write_processor_device(ctx, core_id);
+
+	return 0;
+}
+
+struct acpi_ops armv8_cpu_acpi_ops = {
+	.fill_ssdt	= armv8_cpu_fill_ssdt,
+};
+#endif
+
+static const struct cpu_ops cpu_ops = {
+	.get_count = armv8_cpu_get_count,
+	.get_desc  = armv8_cpu_get_desc,
+	.get_info  = armv8_cpu_get_info,
+};
+
+static const struct udevice_id cpu_ids[] = {
+	{ .compatible = "arm,armv8" },
+	{}
+};
+
+U_BOOT_DRIVER(arm_cpu) = {
+	.name		= "arm-cpu",
+	.id		= UCLASS_CPU,
+	.of_match	= cpu_ids,
+	.ops		= &cpu_ops,
+	.flags		= DM_FLAG_PRE_RELOC,
+	ACPI_OPS_PTR(&armv8_cpu_acpi_ops)
+};
diff --git a/drivers/cpu/armv8_cpu.h b/drivers/cpu/armv8_cpu.h
new file mode 100644
index 0000000000..2c4b0252cf
--- /dev/null
+++ b/drivers/cpu/armv8_cpu.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 9elements GmbH
+ */
+#include <dm/acpi.h>
+#include <dm/device.h>
+
+#ifndef _ARMV8_CPU_H_
+#define _ARMV8_CPU_H_
+
+/**
+ * armv8_cpu_fill_ssdt() - Fill the SSDT
+ * Parses the FDT and writes the SSDT nodes.
+ *
+ * @dev: cpu device to generate ACPI tables for
+ * @ctx: ACPI context pointer
+ * @return:	0 if OK, or a negative error code.
+ */
+int armv8_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx);
+
+#endif
\ No newline at end of file
-- 
2.46.0

