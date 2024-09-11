Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB68EE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CE37891D2;
	Wed, 11 Sep 2024 08:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="V1qI9W9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C71F89161; Wed, 11 Sep 2024 08:26:08 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D4C489184
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8a7cdfdd80so554169566b.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035966; x=1726640766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/aL8cQ4JgE8ErEimZWUc2zLmL69zCm7+T3vxBaw/Jvw=;
 b=V1qI9W9v4zueKX0uJIfxcbE4td2nVJ1GLeWyQJos/sFFfDMQ+VgHb9UVePNctTMsQS
 QW9v3oGSo4N60ILgyv7kJjTe1zfsNOFEfx7nWs3iTg9QcXKmR9o9qzZx+LxygRIaCFbL
 peVXtMVo73uxjFvSUizpfe/zpdrVGzOjCHTnEUjHnQiANnfLZJ7/It3a6HeQtRVjm906
 Vve7r7RhOSV+/0g/OL3XpicZ6lg9fzMdW5HTgp0nnq0X7/r3b3ug8xnEZ+lBqED3/xe2
 p6iOI5Ra3kml6V20FdJxogKTC4C4JZHG5gNNIIFdhLBfC5C03JNOSMoG6G3dqRChRf1f
 Ag5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035966; x=1726640766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/aL8cQ4JgE8ErEimZWUc2zLmL69zCm7+T3vxBaw/Jvw=;
 b=VqAqM4iAIzMxIuVwiJkfB/x1KyIbyzrMy1wPzEiHNxSRd+QE7zBleYa9khHP+Ur+8o
 JWDGVVUFBbrzDcTzy+KF1uA5To9f0uQLnMYxZ9LAOXvehqpfsFCssl8Hyys5WdJuWMsL
 ByoydhFHPwqcCbecZMatxkf2BYQ7JKsUy7/vQUIuFqrZDGNbR4oUBhSVAzX2+sw9g432
 i/vV05kI/tq5mUdOu1NRvI9QXUUe2S3VFLT9DCffu/zbMKJ0QbxbqKtCuWAOQKo9UEM5
 TyRg+hulZwObNv4qJNQxaOR5B9xq4G92Ja1OBiImBpAGdIBCp1dTvZMragQqZ4y5Hi5b
 iMcg==
X-Gm-Message-State: AOJu0YxNbFstgbGV7tHJYEFKUTnN1Q+BGo4x4MVJJkwlH0hwWLMLyjW8
 umvB6whHDqr2kBwG+tmzppEaPtULZCQbEcsEQ8Xs1CQHkKqA3DtytT/pPth4ZpeaztBY8fx0NxI
 +wVU=
X-Google-Smtp-Source: AGHT+IFurhOCs9AWSSJEmPKVfkVbRknMr2MhVnfLH/sxB9OJiiWHGrhGJWSxd2lz1sv8Q0vJr8b7LQ==
X-Received: by 2002:a17:906:730b:b0:a86:9041:a42a with SMTP id
 a640c23a62f3a-a8ffae24c2bmr314414266b.62.1726035965857; 
 Tue, 10 Sep 2024 23:26:05 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:26:05 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 25/30] arm: bcm283x: Generate ACPI tables
Date: Wed, 11 Sep 2024 08:24:15 +0200
Message-ID: <20240911062511.494855-26-patrick.rudolph@9elements.com>
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

Generate SoC specific ACPI tables for BCM2711:
- MADT
- FADT
- PPTT
- GTDT

Board specific tables like DSDT and SSDT are added in a separate patch.

When ACPI is enabled for a different SoC compliation will fail by
design, indicating the required functions that needs to be implemented.
When ACPI is not enabled the added code does nothing, keeping existing
behaviour.

TEST: Booted on RPi4 with only ACPI enabled, providing no FDT to the OS.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
Changelog v2:
- Drop duplicated code to generate ACPI tables. Is now part of efi loader.

---
 arch/arm/mach-bcm283x/Makefile       |   4 +
 arch/arm/mach-bcm283x/bcm2711_acpi.c | 150 +++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 arch/arm/mach-bcm283x/bcm2711_acpi.c

diff --git a/arch/arm/mach-bcm283x/Makefile b/arch/arm/mach-bcm283x/Makefile
index 7cd068832f..38e320307d 100644
--- a/arch/arm/mach-bcm283x/Makefile
+++ b/arch/arm/mach-bcm283x/Makefile
@@ -4,3 +4,7 @@
 
 obj-$(CONFIG_BCM2835) += lowlevel_init.o
 obj-y	+= init.o reset.o mbox.o msg.o phys2bus.o
+
+ifeq ($(CONFIG_GENERATE_ACPI_TABLE),y)
+obj-$(CONFIG_BCM2711) += bcm2711_acpi.o
+endif
\ No newline at end of file
diff --git a/arch/arm/mach-bcm283x/bcm2711_acpi.c b/arch/arm/mach-bcm283x/bcm2711_acpi.c
new file mode 100644
index 0000000000..34adc0aa42
--- /dev/null
+++ b/arch/arm/mach-bcm283x/bcm2711_acpi.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2024 9elements GmbH
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ */
+
+#include <acpi/acpi_table.h>
+#include <asm/acpi_table.h>
+#include <asm/armv8/sec_firmware.h>
+#include <asm/arch/acpi/bcm2711.h>
+#include <dm/uclass.h>
+#include <tables_csum.h>
+#include <string.h>
+
+void acpi_fill_fadt(struct acpi_fadt *fadt)
+{
+	fadt->flags = ACPI_FADT_HW_REDUCED_ACPI | ACPI_FADT_LOW_PWR_IDLE_S0;
+
+	if (CONFIG_IS_ENABLED(SEC_FIRMWARE_ARMV8_PSCI) &&
+	    sec_firmware_support_psci_version() != PSCI_INVALID_VER)
+		fadt->arm_boot_arch = ACPI_ARM_PSCI_COMPLIANT;
+}
+
+void *acpi_fill_madt(struct acpi_madt *madt, struct acpi_ctx *ctx)
+{
+	struct acpi_madt_gicc *gicc;
+	struct acpi_madt_gicd *gicd;
+	void *current = ctx->current;
+
+	madt->lapic_addr = 0;
+	madt->flags = 0;
+
+	gicc = current;
+	for (int i = 0; i < uclass_id_count(UCLASS_CPU); i++) {
+		acpi_write_madt_gicc(gicc++, i, 0x30 + i, BCM2711_GIC400_BASE_ADDRESS + 0x2000,
+				     BCM2711_GIC400_BASE_ADDRESS + 0x6000,
+				     BCM2711_GIC400_BASE_ADDRESS + 0x4000,
+				     0x19, 0, i, 1);
+	}
+
+	gicd = (struct acpi_madt_gicd *)gicc;
+	acpi_write_madt_gicd(gicd++, 0, BCM2711_GIC400_BASE_ADDRESS + 0x1000, 2);
+	return gicd;
+}
+
+#define L3_ATTRIBUTES (ACPI_PPTT_READ_ALLOC | ACPI_PPTT_WRITE_ALLOC | \
+			(ACPI_PPTT_CACHE_TYPE_UNIFIED << \
+			 ACPI_PPTT_CACHE_TYPE_SHIFT))
+#define L3_SIZE 0x100000
+#define L3_SETS 0x400
+#define L3_WAYS 0x10
+
+#define L1D_ATTRIBUTES (ACPI_PPTT_READ_ALLOC | ACPI_PPTT_WRITE_ALLOC | \
+			(ACPI_PPTT_CACHE_TYPE_DATA << \
+			 ACPI_PPTT_CACHE_TYPE_SHIFT))
+#define L1D_SIZE 0x8000
+#define L1D_SETS 0x100
+#define L1D_WAYS 2
+
+#define L1I_ATTRIBUTES (ACPI_PPTT_READ_ALLOC | \
+			(ACPI_PPTT_CACHE_TYPE_INSTR << \
+			 ACPI_PPTT_CACHE_TYPE_SHIFT))
+#define L1I_SIZE 0xc000
+#define L1I_SETS 0x100
+#define L1I_WAYS 3
+
+static int acpi_write_pptt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
+{
+	struct acpi_table_header *header;
+	int cluster_offset, l3_offset;
+	u32 offsets[2];
+
+	header = ctx->current;
+	ctx->tab_start = ctx->current;
+
+	memset(header, '\0', sizeof(struct acpi_table_header));
+
+	acpi_fill_header(header, "PPTT");
+	header->revision = acpi_get_table_revision(ACPITAB_PPTT);
+	acpi_inc(ctx, sizeof(*header));
+
+	l3_offset = acpi_pptt_add_cache(ctx, ACPI_PPTT_ALL_VALID, 0, L3_SIZE,
+					L3_SETS, L3_WAYS, L3_ATTRIBUTES, 64);
+
+	cluster_offset = acpi_pptt_add_proc(ctx, ACPI_PPTT_PHYSICAL_PACKAGE |
+					    ACPI_PPTT_CHILDREN_IDENTICAL,
+					    0, 0, 1, &l3_offset);
+
+	offsets[0] = acpi_pptt_add_cache(ctx, ACPI_PPTT_ALL_VALID, 0, L1D_SIZE,
+					 L1D_SETS, L1D_WAYS, L1D_ATTRIBUTES, 64);
+
+	offsets[1] = acpi_pptt_add_cache(ctx, ACPI_PPTT_ALL_BUT_WRITE_POL, 0,
+					 L1I_SIZE, L1I_SETS, L1I_WAYS,
+					 L1I_ATTRIBUTES, 64);
+
+	for (int i = 0; i < uclass_id_count(UCLASS_CPU); i++) {
+		acpi_pptt_add_proc(ctx, ACPI_PPTT_CHILDREN_IDENTICAL |
+				   ACPI_PPTT_NODE_IS_LEAF |
+				   ACPI_PPTT_PROC_ID_VALID,
+				   cluster_offset, i, 2, offsets);
+	}
+
+	header->length = ctx->current - ctx->tab_start;
+	header->checksum = table_compute_checksum(header, header->length);
+
+	acpi_inc(ctx, header->length);
+	acpi_add_table(ctx, header);
+
+	return 0;
+};
+
+ACPI_WRITER(5pptt, "PPTT", acpi_write_pptt, 0);
+
+static int rpi_write_gtdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
+{
+	struct acpi_table_header *header;
+	struct acpi_gtdt *gtdt;
+
+	gtdt = ctx->current;
+	header = &gtdt->header;
+
+	memset(gtdt, '\0', sizeof(struct acpi_gtdt));
+
+	acpi_fill_header(header, "GTDT");
+	header->length = sizeof(struct acpi_gtdt);
+	header->revision = acpi_get_table_revision(ACPITAB_GTDT);
+
+	gtdt->cnt_ctrl_base = BCM2711_ARM_LOCAL_BASE_ADDRESS + 0x1c;
+	gtdt->sec_el1_gsiv = 29;
+	gtdt->sec_el1_flags = GTDT_FLAG_INT_ACTIVE_LOW;
+	gtdt->el1_gsiv = 30;
+	gtdt->el1_flags = GTDT_FLAG_INT_ACTIVE_LOW;
+	gtdt->virt_el1_gsiv = 27;
+	gtdt->virt_el1_flags = GTDT_FLAG_INT_ACTIVE_LOW;
+	gtdt->el2_gsiv = 26;
+	gtdt->el2_flags = GTDT_FLAG_INT_ACTIVE_LOW;
+	gtdt->cnt_read_base = 0xffffffffffffffff;
+
+	header->checksum = table_compute_checksum(header, header->length);
+
+	acpi_add_table(ctx, gtdt);
+
+	acpi_inc(ctx, sizeof(struct acpi_gtdt));
+
+	return 0;
+};
+
+ACPI_WRITER(5gtdt, "GTDT", rpi_write_gtdt, 0);
-- 
2.46.0

