Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDA0D16260
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 957B8891A5;
	Mon, 14 Oct 2024 15:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="eE+bdCii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FD1189170; Mon, 14 Oct 2024 15:13:00 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C39C891A2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d50fad249so2707533f8f.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911577; x=1729516377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DC95t5GPfTmNij5pCtZnFPlv0bP1Igw/23w2Y91uqeY=;
 b=eE+bdCiiOBbllztSykyWw4L9sjBjy5Jg9h1HmCRW5pbzqQv6etJkJmn1ihQ/Ef92nG
 Ju0puKu3hzgb4HEhUS2Fl8OqrlpHCiWUteQ5yybjzEw3P18wqWPbTPVXAczi1+gfIlkG
 FZjA7b3VZR734s3jXFgvjl4VF78rjAXQtwSF1gJhRZ/EG26GrmOQpB5mwjEl5d6+tldp
 1UeK2VJJYsPrd9SynNtRdNmDGnuvNHlkd8md8EckJ9Qyn2bQ9Bhb3CNUkeg86eIbVSYL
 m/DNB15JudH50lcOdPbyKtY8MHs2SMfvYAZ1HZed0vusLYy9yBoUvCu7IvN16mbo2d6V
 hFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911577; x=1729516377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DC95t5GPfTmNij5pCtZnFPlv0bP1Igw/23w2Y91uqeY=;
 b=r7xHYsXwvvWHQExzUfogEFdAC06CGrlxeZOFWDNL2Is7NRAen77VkZhJDkZ3xzhg8r
 a46yZf9cfdu4ppk5JHB1krMHB5YGtgsxNnO2AoVvZIWo80IzSUJXCkOJp7+w+vwwGkLk
 H9rbXQUoteoCSLXkbltTa4Co48qi/afvItmyuL0MNmmB9yQ9T6H3UHpVaPkAd90J4YtN
 kOzTwtiX9MpJ01Xh25mOCd1D/r9YEuWay11UC7cxfM2c6q3tfSiTExaCn2Gnd3FNbHea
 K148F16XJqnxAXHFF3aFHdzjB+5bIbSlL/GWj2A8lnRYZDrgoXSHhQdgsgonz+ujyDjT
 2Lmg==
X-Gm-Message-State: AOJu0YzegM96bRS3KHubmW0iMToTqtmsxhOXf/1aYBTgU5dSEvuVJ0k2
 OfqAwNQYbzjThkE+VdPeFJAfaectOZYzAorfST4EmMcmysTRZs9c7BWF9KnGO4sTlt8mBYY/LSC
 B
X-Google-Smtp-Source: AGHT+IHYx0Y285Th57Az2/PBN7iA59TmkAiQaMP1N/7y2iY/N3hesiW7Z2vPM7oLeb8iyH/LbqMhyg==
X-Received: by 2002:a05:6000:10e:b0:37d:2de4:d64 with SMTP id
 ffacd0b85a97d-37d5520cf07mr8693963f8f.35.1728911577557; 
 Mon, 14 Oct 2024 06:12:57 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:57 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 28/37] arm: bcm283x: Generate ACPI tables
Date: Mon, 14 Oct 2024 15:10:44 +0200
Message-ID: <20241014131152.267405-29-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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
- FADT
- PPTT
- GTDT

Board specific tables like DSDT and SSDT are added in a separate patch.

MADT is already properly generated from the FDT.

When ACPI is enabled for a different SoC compliation will fail by
design, indicating the required functions that needs to be implemented.
When ACPI is not enabled the added code does nothing, keeping existing
behaviour.

TEST: Booted on RPi4 with only ACPI enabled, providing no FDT to the OS.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
Changelog v2:
- Drop duplicated code to generate ACPI tables. Is now part of efi loader.
Changelog v4:
- Drop acpi_fill_madt() as it's now generated by drivers
Changelog v6:
- Update header order

---
 arch/arm/mach-bcm283x/Makefile       |   4 +
 arch/arm/mach-bcm283x/bcm2711_acpi.c | 128 +++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)
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
index 0000000000..79b283353c
--- /dev/null
+++ b/arch/arm/mach-bcm283x/bcm2711_acpi.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2024 9elements GmbH
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ */
+
+#include <string.h>
+#include <tables_csum.h>
+#include <acpi/acpi_table.h>
+#include <asm/acpi_table.h>
+#include <asm/armv8/sec_firmware.h>
+#include <asm/arch/acpi/bcm2711.h>
+#include <dm/uclass.h>
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
2.46.2

