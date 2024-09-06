Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7530DCE7AB8
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7779488ABE;
	Fri,  6 Sep 2024 09:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="PUmZFBX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A062288D0F; Fri,  6 Sep 2024 09:22:57 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DAF488D40
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8a1acb51a7so194819166b.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607372; x=1726212172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wkxs0IXVgjUKIwhqeOibdEHHkTggR1+Vatp60KxYOKw=;
 b=PUmZFBX7mdt6AY+yVY0gRMG3hY/8xLhp4F/mn987teHOX4qwvtBKlXY+ZPUZP/t7MB
 XUooZx22XZOpcmlJVhqXI8crQwEcBuuIt6d631etPCki25i/vf9Yd6klAFdaZtALMN8s
 Ng3GgcxAKM9nmMqctxFNgMhbtd1L0iGaM8wjjgyYaGkttysCM2n7YM+ePUxB04Xwrbgt
 IVY9j2mVcrXxX5F2O2IsowQCIvFSeI4srd2sP2qtO2WpiZXTT1K+Z5d6nV5qmMEPv7T8
 S/Iuz+jmsyScRhvOqQyNXXijt32jPQlaE9Zsdd5GTKDY6vKLYlpCCr70MAXhvHxFtXeu
 Re3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607372; x=1726212172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wkxs0IXVgjUKIwhqeOibdEHHkTggR1+Vatp60KxYOKw=;
 b=iMxb7r3vxym03kNZ8IiyfjjVuq/y9ZLmM+DY7qPtPC9H3irJNu7K/t3iKFmO7zZwyb
 TvamzNN53vkbnRRHmVo6/eOzhFa/FCphSXOGG053LyfMS6t5LNN5AeJIoXRsmeg6rv5E
 MVV4dnkQxcYTm9oZinpdsfrqyUW2d9U5uzG0jYqiRRZV0Jgf3yMjU7AkTCZhZ8oe21di
 ZjIbae6oKKVvjN00L+K5bJUKhM/QGbWvVO/ZHCq2K/JpwxyMiit1PJ1YI9N0mkPMC0Sw
 7mc+8n35wbBM3JQUTQkUBSNtsW6G9ck30jSquKBrdJmGAf9ygC3SgnaTLJNCwOiy6duc
 4RHw==
X-Gm-Message-State: AOJu0Yz8pmfGbfbpTS7A9g6t8BAUfOFb8oqZ35HokrE0tx+IpLP7S2o5
 mzwQy1VGKPZhE1b1vRHycNmfn+HOCe/sXPgG7dY4MA/MMHB5Sk0SzHScj0Qg3KFK89x7pWhhkqN
 f
X-Google-Smtp-Source: AGHT+IFfPbBsupK0pcybprRONg5CzFIwrZlQE6D8psxWwKcKOdQJfOBfw6XNGKTLz1YI1Ds/jaW8sQ==
X-Received: by 2002:a17:907:a02:b0:a7a:bcbc:f7e1 with SMTP id
 a640c23a62f3a-a8a885f4462mr137481366b.15.1725607371896; 
 Fri, 06 Sep 2024 00:22:51 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:51 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 18/28] drivers/cpu: Add generic armv8 cpu driver
Date: Fri,  6 Sep 2024 09:22:20 +0200
Message-ID: <20240906072231.2531491-19-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
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
2.45.2

