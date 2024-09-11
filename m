Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C2AEE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15B3F891B2;
	Wed, 11 Sep 2024 08:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="ZfIrWE9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF01D891B2; Wed, 11 Sep 2024 08:25:53 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB3A48918D
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d29b7edc2so548125866b.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035951; x=1726640751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGJkVoDUw0zvkbGlCYIx1J4whRUd5TwtylIf9yCkL5I=;
 b=ZfIrWE9nVoNWIbKZyHjpqfwsZRxPcWr1meSlHiiW4FOUahTo3QozpN+H1ft8V5LAL4
 DdZt1LEDRtMQQ+4+bV3nGek1JIBjYch1Q8kFp3BKWud+KzaVKJPr1a3PFEHh99ryi7WC
 CrDaQ2iKQRN0Hhb+Y7rMiUkl3qKNXTs0xVS5YkVHTf/iGBhlVhBrlyyxGco8I7/X+5fP
 dV+4g5lylU+iXwvgZm58/xmdWqq5vlDZ1Ao4m/i7pUO7nng8uS+k+s7NAZQqPzSgRFZe
 5o+kRjPbHiZ+5us2iXMpoqSf1tXhdQaPHJoJnouXMLqJLYMsIFtWJQbH3eG7x4bFzhtw
 onfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035951; x=1726640751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qGJkVoDUw0zvkbGlCYIx1J4whRUd5TwtylIf9yCkL5I=;
 b=Pz99qgjm/22I9xh4PrMepw9pWwxs4ZXB6z/3r3mQa3w/xVctp2mQ8Ve3Y3QuZymfuz
 pmoOUrWnxk0quyhGcGMqyId7BpjwrAcZta51Hq9nJYqWHfLhLhwASyHj3jaW6QTweto2
 hz+UKvt3OegMYSsMLNLAwYoBs3BjNsJlBQQF1SEzijbtnSkpC+6TY/kC7z8R0zDI06l8
 NxE99DxxwSh+g59XIqgFJm8bwwkHFnd1csr96PdBDrUcEc1ZR9XPPBZXfwCqcfi/TNqi
 rWXG6ebbofirb3r6WcE0aGXJRbyOAI0e4JPJPgRjmSkZB7Z4UIp2vg+f80mCAjbo+Ycc
 Uh6Q==
X-Gm-Message-State: AOJu0YyyVbETdrcVMhxTgcWOSewzVdxlhZIb+x3K1GuNmXU0qF/WY9o+
 txYm81YIyO0nIuoamTWYBHZ6QUNMow5bKYR1LQzCj8k3w839MH8t/aKQByIedrilb94oMz56IMe
 8
X-Google-Smtp-Source: AGHT+IH67Y4FQFD/320k5qGNmwEHjL7ICaQY7s/xPFN498SuS049dLVB8gAOT5GXiWsiIpA18IAIOg==
X-Received: by 2002:a17:907:7255:b0:a8d:4d76:a75e with SMTP id
 a640c23a62f3a-a8ffab83375mr261302266b.30.1726035951308; 
 Tue, 10 Sep 2024 23:25:51 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:50 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 18/30] drivers/cpu: Add generic armv8 cpu driver
Date: Wed, 11 Sep 2024 08:24:08 +0200
Message-ID: <20240911062511.494855-19-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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

Add a generic driver that binds to armv8 CPU nodes.

TEST: Booted on QEMU sbsa and verify the driver binds to CPU nodes.
      Confirmed with FWTS that all ACPI processor devices are present.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
---
 drivers/cpu/Kconfig     |  6 +++
 drivers/cpu/Makefile    |  2 +
 drivers/cpu/armv8_cpu.c | 90 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/cpu/armv8_cpu.c

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
index 0000000000..08b8d45f6f
--- /dev/null
+++ b/drivers/cpu/armv8_cpu.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 Broadcom.
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
+	ofnode node;
+	int num = 0;
+
+	ofnode_for_each_subnode(node, dev_ofnode(dev->parent)) {
+		const char *device_type;
+
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		device_type = ofnode_read_string(node, "device_type");
+		if (!device_type)
+			continue;
+
+		if (!strcmp(device_type, "cpu"))
+			num++;
+	}
+
+	return num;
+}
+
+#ifdef CONFIG_ACPIGEN
+static int acpi_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
+{
+	uint core_id = dev_seq(dev);
+
+	acpigen_write_processor_device(ctx, core_id);
+
+	return 0;
+}
+
+struct acpi_ops armv8_cpu_acpi_ops = {
+	.fill_ssdt	= acpi_cpu_fill_ssdt,
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
-- 
2.46.0

