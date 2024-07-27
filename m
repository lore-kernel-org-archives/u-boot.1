Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3129CC3DA61
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B86CA886A6;
	Sat, 27 Jul 2024 09:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="ZEF4eFNa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD250886FD; Sat, 27 Jul 2024 09:20:19 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8FBF886BB
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52ed741fe46so2123539e87.0
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064817; x=1722669617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=filpyQkk9f0QR0ZeZDqORBnz2FVGnj0jpfuEwjUBe9U=;
 b=ZEF4eFNah7zktu5rCXNLPnHh3FL7PE/YyNIHp7Qhs+MHWHt6JXDmay2WgQurMIaegV
 nIX2v/WMSUmYgtby0WcOQ8XNgq5ibMMh172l1yXpjnlb0hA3oBVOW12+0lLXIn+znlUQ
 6JBwu73fvmX4dPD3mG2PgsXTV6v31QmIeFrYSzoqei1tBYVmbbTq41cuSegluyoCPT/1
 7+n8GeKa4WzrinU/IQkIyau5DVfE4ZXAMDhSVwOX/XdQtonC/9V0OV0HeTo7rpk+d/Vj
 11zibLpuwmj0B//nUBHGXuN/Ve5qcJAwROhEYYolk0Mj5wl728wAUPWEIGskZ0bAn3iZ
 TiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064817; x=1722669617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=filpyQkk9f0QR0ZeZDqORBnz2FVGnj0jpfuEwjUBe9U=;
 b=D8R3N1R+8N6UlPqTIVvZGqWbtqe1QtXtOkMquwag3cyEaizUA0XBdkD937mmO75AUa
 f80QlXJc+t3jX+AHK8YFmloAeCXn9LdaWJm2GZ/AvOVGDwlxqK16TN4kDon+AkoIuOsE
 bvO8hFyz8Q1xOIVAFUCr8A762VPZq39MqsLLwIgr2Z1peTWy2FnYcecjfTFEMxjIJfZw
 huRbGAAtAEbEr4eMaOCnageuaHhYnOrW0ptXGqwCkd5xUt76I7qQfwFx/hg3AGMIpWUZ
 DxlxDg+ZvHjRv/UHcBb+YR+II2lxh3GM5HUIoofnORuse6GtTPe5CNpd+BnkOSdJ/s3I
 gdwQ==
X-Gm-Message-State: AOJu0Ywsy10cwXW9ZtKX7hxtv0EgpBn4SkTunKs/ZTsyO66RbH4Ivnag
 2l/udDq9LvWE0Oj1y4yNNFPle9y9ZjSTziUasFxOQ16D9fdavIxdmxMLtipOBPopx63XiSRxDUr
 ciCM=
X-Google-Smtp-Source: AGHT+IFDPYDSILZU3rP/sPsaknvIEFg9+E1jfU5/iGH9hRwxbQl+WMz7VJsnbKT21Rw1A48t2VpFvw==
X-Received: by 2002:a19:770c:0:b0:52c:d626:77aa with SMTP id
 2adb3069b0e04-5309b2d9aa9mr1005911e87.58.1722064816895; 
 Sat, 27 Jul 2024 00:20:16 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:16 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com,
 sjg@chromium.org, bmeng.cn@gmail.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 07/17] arm: acpi: Add generic ACPI methods
Date: Sat, 27 Jul 2024 09:17:08 +0200
Message-ID: <20240727071742.1735703-8-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
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

Add generic ACPI code to generate
- MADT GICC
- MADT GICD

as commonly used on arm platforms.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/include/asm/acpi_table.h | 18 +++++++++++++
 arch/arm/lib/Makefile             |  1 +
 arch/arm/lib/acpi_table.c         | 44 +++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 arch/arm/lib/acpi_table.c

diff --git a/arch/arm/include/asm/acpi_table.h b/arch/arm/include/asm/acpi_table.h
index e69de29bb2..8a25e93847 100644
--- a/arch/arm/include/asm/acpi_table.h
+++ b/arch/arm/include/asm/acpi_table.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __ASM_ACPI_TABLE_H__
+#define __ASM_ACPI_TABLE_H__
+
+#ifndef __ACPI__
+
+void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
+			  uint perf_gsiv, ulong phys_base, ulong gicv,
+			  ulong gich, uint vgic_maint_irq, ulong mpidr,
+			  uint efficiency);
+
+void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
+			  ulong phys_base, uint gic_version);
+
+#endif /* !__ACPI__ */
+
+#endif /* __ASM_ACPI_TABLE_H__ */
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 67275fba61..a7efed6771 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -86,6 +86,7 @@ obj-y	+= psci-dt.o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 
 obj-$(CONFIG_BLOBLIST)  += xferlist.o
+obj-$(CONFIG_GENERATE_ACPI_TABLE) += acpi_table.o
 
 # For EABI conformant tool chains, provide eabi_compat()
 ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
diff --git a/arch/arm/lib/acpi_table.c b/arch/arm/lib/acpi_table.c
new file mode 100644
index 0000000000..ea3a6343c9
--- /dev/null
+++ b/arch/arm/lib/acpi_table.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Based on acpi.c from coreboot
+ *
+ * Copyright (C) 2024 9elements GmbH
+ */
+
+#define LOG_CATEGORY LOGC_ACPI
+
+#include <acpi/acpigen.h>
+#include <acpi/acpi_device.h>
+#include <acpi/acpi_table.h>
+#include <string.h>
+
+void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
+			  uint perf_gsiv, ulong phys_base, ulong gicv,
+			  ulong gich, uint vgic_maint_irq, ulong mpidr,
+			  uint efficiency)
+{
+	memset(gicc, '\0', sizeof(struct acpi_madt_gicc));
+	gicc->type = ACPI_APIC_GICC;
+	gicc->length = sizeof(struct acpi_madt_gicc);
+	gicc->cpu_if_num = cpu_num;
+	gicc->processor_id = cpu_num;
+	gicc->flags = ACPI_MADTF_ENABLED;
+	gicc->perf_gsiv = perf_gsiv;
+	gicc->phys_base = phys_base;
+	gicc->gicv = gicv;
+	gicc->gich = gich;
+	gicc->vgic_maint_irq = vgic_maint_irq;
+	gicc->mpidr = mpidr;
+	gicc->efficiency = efficiency;
+}
+
+void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
+			  ulong phys_base, uint gic_version)
+{
+	memset(gicd, '\0', sizeof(struct acpi_madt_gicd));
+	gicd->type = ACPI_APIC_GICD;
+	gicd->length = sizeof(struct acpi_madt_gicd);
+	gicd->gic_id = gic_id;
+	gicd->phys_base = phys_base;
+	gicd->gic_version = gic_version;
+}
-- 
2.45.2

