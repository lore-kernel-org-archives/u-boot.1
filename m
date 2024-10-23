Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C045CF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FAEA892E3;
	Wed, 23 Oct 2024 15:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="C6rdtcQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD4589309; Wed, 23 Oct 2024 15:28:47 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC1A8926F
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d538fe5f2so5091570f8f.2
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690116; x=1730294916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ta6Wbbyrzm+pJxQbERXeag/mqMvX6hJPh2osguEEK1s=;
 b=C6rdtcQP1Ea6WjfORJva3TlxJsy8y7kNgLBO3iEg7l0az17jtwZ/u1b+nIgfjqw75t
 cjZ8pX6//nx9u1mfjAF58fTbbhsVjxeLE9htdTpVD2vKVIcRRzutyAM45jhdGSE/hTh8
 GLLa34THdkonx09No/Ko28UFvljjiJHC4rrh3WJGi++4zEpSqt0aYRFTUivf0TX3yoBu
 /4C5H4LnO4Lkfb78Ie3sBKw8MLn/7u706GXZJNkyddpH3lGFFDlYEIA0BmQ64uLmwFTI
 /ivYbGpES7p/moaoxtImzp/AhP8TfxFDwyRw2prOz7Q8xiUNq6KRJF2+x8R/jTY6PY/B
 G19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690116; x=1730294916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ta6Wbbyrzm+pJxQbERXeag/mqMvX6hJPh2osguEEK1s=;
 b=V/1bBFJAlZOhmvOG55aorHxVIG7MqtxYdK8sfGW8oyPmNQgfMK9EGVRmj7+EgaPJXv
 Y2G+lU/hbX49VG5emprah0O8M/4Imp+FxMLc7x67NiQuT8YJvbfNBxXyq6/363wJ+OzX
 CtRBdcUoXsMVmBTQX7JjAuhB81Vz3eRshhLX3kiokOct9jRQPFv3nzLvomsQtIxTxfqs
 7Ja2hmmaxgVFG3b3kQCqqh7rg6+zhiem6K7j89Fsz0T1HTqwtOBUVSXBMDFdShXq9oYJ
 W/HgXtc8txzdebdYmKNak85eBqys9iSUHifQMcLm+yrcTa0sqbpjijpiksDt+aLUmYFA
 YW9g==
X-Gm-Message-State: AOJu0YzaA11WV+DOO0touLBebflY2hgu0o+/HEF4YNHU/ph0j0dGyRa5
 LdKeYmRoC0zWsMGLlgQ9901m2I2ysRXS7rg9NH9Po7LLgz1P2HDnmpnyLUz1NVnJsuxS9gcrsu6
 7
X-Google-Smtp-Source: AGHT+IH9g2xBkvWtBCpP49Vda5TUpTsTeb8jFQvYacrTDq1B5cXS7HAXzlwOxNROMhW+nChJJ2VawQ==
X-Received: by 2002:a05:6000:e90:b0:37d:47b3:7b82 with SMTP id
 ffacd0b85a97d-37efcf92af2mr1421315f8f.57.1729690115599; 
 Wed, 23 Oct 2024 06:28:35 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:28:35 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 03/37] acpi: x86: Move MADT to common code
Date: Wed, 23 Oct 2024 15:19:46 +0200
Message-ID: <20241023132116.970117-4-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

Write MADT in common code and let the SoC fill out the body by
calling acpi_fill_madt() which must be implemented at SoC level.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
Changelog v3:
- Pass ACPI context to acpi_fill_madt
---
 arch/sandbox/lib/Makefile         |  9 +++---
 arch/sandbox/lib/acpi_table.c     |  7 ++++-
 arch/x86/cpu/intel_common/acpi.c  | 22 +++++++++-----
 arch/x86/cpu/tangier/acpi.c       |  8 +++++-
 arch/x86/include/asm/acpi_table.h |  3 +-
 arch/x86/lib/acpi_table.c         | 48 +++++++------------------------
 include/acpi/acpi_table.h         | 11 +++++++
 lib/acpi/acpi_table.c             | 31 ++++++++++++++++++++
 8 files changed, 86 insertions(+), 53 deletions(-)

diff --git a/arch/sandbox/lib/Makefile b/arch/sandbox/lib/Makefile
index d7d15a50bb..5d7beb250c 100644
--- a/arch/sandbox/lib/Makefile
+++ b/arch/sandbox/lib/Makefile
@@ -5,7 +5,8 @@
 # (C) Copyright 2002-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-y			+= fdt_fixup.o interrupts.o
-obj-$(CONFIG_PCI)	+= pci_io.o
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
-obj-$(CONFIG_CMD_BOOTZ) += bootm.o
+obj-y				+= fdt_fixup.o interrupts.o
+obj-$(CONFIG_PCI)		+= pci_io.o
+obj-$(CONFIG_CMD_BOOTM)		+= bootm.o
+obj-$(CONFIG_CMD_BOOTZ)		+= bootm.o
+obj-$(CONFIG_$(SPL_)ACPIGEN)	+= acpi_table.o
diff --git a/arch/sandbox/lib/acpi_table.c b/arch/sandbox/lib/acpi_table.c
index 10b7ce441a..90bb96d1e3 100644
--- a/arch/sandbox/lib/acpi_table.c
+++ b/arch/sandbox/lib/acpi_table.c
@@ -3,4 +3,9 @@
 
 void acpi_fill_fadt(struct acpi_fadt *fadt)
 {
-}
\ No newline at end of file
+}
+
+void *acpi_fill_madt(struct acpi_madt *madt, struct acpi_ctx *ctx)
+{
+	return ctx->current;
+}
diff --git a/arch/x86/cpu/intel_common/acpi.c b/arch/x86/cpu/intel_common/acpi.c
index 29676b4abf..982149b394 100644
--- a/arch/x86/cpu/intel_common/acpi.c
+++ b/arch/x86/cpu/intel_common/acpi.c
@@ -19,6 +19,7 @@
 #include <asm/global_data.h>
 #include <asm/intel_acpi.h>
 #include <asm/ioapic.h>
+#include <asm/lapic.h>
 #include <asm/mpspec.h>
 #include <asm/smm.h>
 #include <asm/turbo.h>
@@ -80,33 +81,40 @@ static int acpi_sci_irq(void)
 	return sci_irq;
 }
 
-static unsigned long acpi_madt_irq_overrides(unsigned long current)
+static void *acpi_madt_irq_overrides(void *current)
 {
 	int sci = acpi_sci_irq();
 	u16 flags = MP_IRQ_TRIGGER_LEVEL;
 
-	if (sci < 0)
-		return log_msg_ret("sci irq", sci);
+	if (sci < 0) {
+		log_err("sci irq %d", sci);
+		return current;
+	}
 
 	/* INT_SRC_OVR */
-	current += acpi_create_madt_irqoverride((void *)current, 0, 0, 2, 0);
+	current += acpi_create_madt_irqoverride(current, 0, 0, 2, 0);
 
 	flags |= arch_madt_sci_irq_polarity(sci);
 
 	/* SCI */
 	current +=
-	    acpi_create_madt_irqoverride((void *)current, 0, sci, sci, flags);
+	    acpi_create_madt_irqoverride(current, 0, sci, sci, flags);
 
 	return current;
 }
 
-u32 acpi_fill_madt(u32 current)
+void *acpi_fill_madt(struct acpi_madt *madt, struct acpi_ctx *ctx)
 {
+	void *current = ctx->current;
+
+	madt->lapic_addr = LAPIC_DEFAULT_BASE;
+	madt->flags = ACPI_MADT_PCAT_COMPAT;
+
 	/* Local APICs */
 	current += acpi_create_madt_lapics(current);
 
 	/* IOAPIC */
-	current += acpi_create_madt_ioapic((void *)current, 2, IO_APIC_ADDR, 0);
+	current += acpi_create_madt_ioapic(current, 2, IO_APIC_ADDR, 0);
 
 	return acpi_madt_irq_overrides(current);
 }
diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
index 1c73a9dbfe..3d11787861 100644
--- a/arch/x86/cpu/tangier/acpi.c
+++ b/arch/x86/cpu/tangier/acpi.c
@@ -10,6 +10,7 @@
 #include <mapmem.h>
 #include <acpi/acpi_table.h>
 #include <asm/ioapic.h>
+#include <asm/lapic.h>
 #include <asm/mpspec.h>
 #include <asm/tables.h>
 #include <asm/arch/global_nvs.h>
@@ -31,8 +32,13 @@ void acpi_fill_fadt(struct acpi_fadt *fadt)
 	fadt->minor_revision = 2;
 }
 
-u32 acpi_fill_madt(u32 current)
+void *acpi_fill_madt(struct acpi_madt *madt, struct acpi_ctx *ctx)
 {
+	void *current = ctx->current;
+
+	madt->lapic_addr = LAPIC_DEFAULT_BASE;
+	madt->flags = ACPI_MADT_PCAT_COMPAT;
+
 	current += acpi_create_madt_lapics(current);
 
 	current += acpi_create_madt_ioapic((struct acpi_madt_ioapic *)current,
diff --git a/arch/x86/include/asm/acpi_table.h b/arch/x86/include/asm/acpi_table.h
index 3988898f66..3254bbc380 100644
--- a/arch/x86/include/asm/acpi_table.h
+++ b/arch/x86/include/asm/acpi_table.h
@@ -24,14 +24,13 @@ struct acpi_table_header;
 
 /* These can be used by the target port */
 
-int acpi_create_madt_lapics(u32 current);
+int acpi_create_madt_lapics(void *current);
 int acpi_create_madt_ioapic(struct acpi_madt_ioapic *ioapic, u8 id,
 			    u32 addr, u32 gsi_base);
 int acpi_create_madt_irqoverride(struct acpi_madt_irqoverride *irqoverride,
 				 u8 bus, u8 source, u32 gsirq, u16 flags);
 int acpi_create_madt_lapic_nmi(struct acpi_madt_lapic_nmi *lapic_nmi,
 			       u8 cpu, u16 flags, u8 lint);
-u32 acpi_fill_madt(u32 current);
 int acpi_create_mcfg_mmconfig(struct acpi_mcfg_mmconfig *mmconfig, u32 base,
 			      u16 seg_nr, u8 start, u8 end);
 
diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index ff02ce80d1..3186e48d63 100644
--- a/arch/x86/lib/acpi_table.c
+++ b/arch/x86/lib/acpi_table.c
@@ -40,7 +40,7 @@ static int acpi_create_madt_lapic(struct acpi_madt_lapic *lapic,
 	return lapic->length;
 }
 
-int acpi_create_madt_lapics(u32 current)
+int acpi_create_madt_lapics(void *current)
 {
 	struct udevice *dev;
 	int total_length = 0;
@@ -100,23 +100,28 @@ int acpi_create_madt_lapic_nmi(struct acpi_madt_lapic_nmi *lapic_nmi,
 	return lapic_nmi->length;
 }
 
-static int acpi_create_madt_irq_overrides(u32 current)
+static int acpi_create_madt_irq_overrides(void *current)
 {
 	struct acpi_madt_irqoverride *irqovr;
 	u16 sci_flags = MP_IRQ_TRIGGER_LEVEL | MP_IRQ_POLARITY_HIGH;
 	int length = 0;
 
-	irqovr = (void *)current;
+	irqovr = current;
 	length += acpi_create_madt_irqoverride(irqovr, 0, 0, 2, 0);
 
-	irqovr = (void *)(current + length);
+	irqovr = current + length;
 	length += acpi_create_madt_irqoverride(irqovr, 0, 9, 9, sci_flags);
 
 	return length;
 }
 
-__weak u32 acpi_fill_madt(u32 current)
+__weak void *acpi_fill_madt(struct acpi_madt *madt, struct acpi_ctx *ctx)
 {
+	void *current = ctx->current;
+
+	madt->lapic_addr = LAPIC_DEFAULT_BASE;
+	madt->flags = ACPI_MADT_PCAT_COMPAT;
+
 	current += acpi_create_madt_lapics(current);
 
 	current += acpi_create_madt_ioapic((struct acpi_madt_ioapic *)current,
@@ -127,39 +132,6 @@ __weak u32 acpi_fill_madt(u32 current)
 	return current;
 }
 
-int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
-{
-	struct acpi_table_header *header;
-	struct acpi_madt *madt;
-	u32 current;
-
-	madt = ctx->current;
-
-	memset(madt, '\0', sizeof(struct acpi_madt));
-	header = &madt->header;
-
-	/* Fill out header fields */
-	acpi_fill_header(header, "APIC");
-	header->length = sizeof(struct acpi_madt);
-	header->revision = ACPI_MADT_REV_ACPI_3_0;
-
-	madt->lapic_addr = LAPIC_DEFAULT_BASE;
-	madt->flags = ACPI_MADT_PCAT_COMPAT;
-
-	current = (u32)madt + sizeof(struct acpi_madt);
-	current = acpi_fill_madt(current);
-
-	/* (Re)calculate length and checksum */
-	header->length = current - (u32)madt;
-
-	header->checksum = table_compute_checksum((void *)madt, header->length);
-	acpi_add_table(ctx, madt);
-	acpi_inc(ctx, madt->header.length);
-
-	return 0;
-}
-ACPI_WRITER(5x86, NULL, acpi_write_madt, 0);
-
 /**
  * acpi_create_tcpa() - Create a TCPA table
  *
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 19cf0fb43c..c356df72ba 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -963,6 +963,17 @@ int acpi_fill_csrt(struct acpi_ctx *ctx);
  */
 void acpi_fill_fadt(struct acpi_fadt *fadt);
 
+/**
+ * acpi_fill_madt() - Fill out the body of the MADT
+ *
+ * Must be implemented in SoC specific code.
+ *
+ * @madt: The MADT to update
+ * @ctx: ACPI context to write MADT sub-tables to
+ * @return Pointer to the end of tables, where the next tables can be written
+ */
+void *acpi_fill_madt(struct acpi_madt *madt, struct acpi_ctx *ctx);
+
 /**
  * acpi_get_rsdp_addr() - get ACPI RSDP table address
  *
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 9eb0b507a0..639d78125f 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -240,6 +240,37 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 
 ACPI_WRITER(5fadt, "FADT", acpi_write_fadt, 0);
 
+int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
+{
+	struct acpi_table_header *header;
+	struct acpi_madt *madt;
+	void *current;
+
+	madt = ctx->current;
+
+	memset(madt, '\0', sizeof(struct acpi_madt));
+	header = &madt->header;
+
+	/* Fill out header fields */
+	acpi_fill_header(header, "APIC");
+	header->length = sizeof(struct acpi_madt);
+	header->revision = ACPI_MADT_REV_ACPI_3_0;
+
+	acpi_inc(ctx, sizeof(struct acpi_madt));
+	current = acpi_fill_madt(madt, ctx);
+
+	/* (Re)calculate length and checksum */
+	header->length = (uintptr_t)current - (uintptr_t)madt;
+
+	header->checksum = table_compute_checksum((void *)madt, header->length);
+	acpi_add_table(ctx, madt);
+	ctx->current = (void *)madt + madt->header.length;
+
+	return 0;
+}
+
+ACPI_WRITER(5madt, "MADT", acpi_write_madt, 0);
+
 void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
 		      int port_type, int port_subtype,
 		      struct acpi_gen_regaddr *address, u32 address_size,
-- 
2.46.2

