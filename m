Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECB1C3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 041BA886E7;
	Sat, 27 Jul 2024 09:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="cjl6zc8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F73F88667; Sat, 27 Jul 2024 09:20:13 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB408860C
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7a8553db90so312922966b.2
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064810; x=1722669610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DwgMuUQ6Bq5I2zSoeHjZhSg+T1e41EpQfMnisX69Oc=;
 b=cjl6zc8/nn57rBTwUlT2T1tfnXpNdFCfWuuSkzSzU4zhua+ptYbgGzCjyM4AqRWSr1
 SqihXRph7ARkdO58/aV0+jGNyYpoSlrlYiW1FoeoqcgLLE3fQbcw+HguzFOSKh/mLjwS
 zr1IDLWq//75pseWbDKOIlOjd1jpvL4AxXvu65EOIXBG9eOjjf/BEd1PGtuXe4TDDbfE
 aJn/I8KSC/mykOWXIW6Wjg+6HQ4CSjpPXa8JCtyXfABrN+Ui7VcLUL+elHZuX393gFOV
 SM1sFg4cCZdCeOMFozyWr4UwehapXALaoIBTNNbVrEwi5xzvVhO9yM5vyNnuTWojlQSZ
 5wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064810; x=1722669610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DwgMuUQ6Bq5I2zSoeHjZhSg+T1e41EpQfMnisX69Oc=;
 b=VBPePbTfSoO7CQu37L7+JVL9CVSnZ4UnkZoTEglgo44PdrlIvpPmx6eRXsTTT8WfEL
 NRqp9rJ89195os4N78IQoayQyxPCDDMhGGBCFVjpDOPSiZ3DO0e0cY22WzXk0uryflZQ
 4Pe49A7WPN7e9HXIr3FqShAMKixV0hmRTRNfZ5NxftQiAB637RwCCQHtmr7SW939p0gb
 oVab+S3X4ztywdI3XDLlzuFzPX1jKSeccswuRUaRgrLbHCWdGeJkmuIwCxmbbYSF4TGx
 V78uwlNmUFr65oYNGLBFbhF2KFeyed+Tr0pnLkkZ+7E5kClYfTumbj6WccZXOVcijb6z
 Mz+w==
X-Gm-Message-State: AOJu0YyiA97ByQjEslEzFe+Gk4Ejk4HDZvqbYr1cEyb+RJy/y1Zh63Be
 tO92K7ss2XGVVbx00kMfrsyyx0bzyIlQqsUHUMyi5f2nJ1B9egJxH+xTllyT5QRv/S30tyluk4x
 3jIY=
X-Google-Smtp-Source: AGHT+IHb8t5lv1ihIp2sg1bVejAtEShB3QRNA6vpHkjcPuD9u2FlcJ9FdpC3Y4inLKiHe4U61zQQfA==
X-Received: by 2002:a17:907:7d92:b0:a77:cdaa:88a3 with SMTP id
 a640c23a62f3a-a7d3ffe6873mr131357266b.27.1722064810609; 
 Sat, 27 Jul 2024 00:20:10 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:10 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com,
 bmeng.cn@gmail.com, Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 03/17] acpi: x86: Move MADT to common code
Date: Sat, 27 Jul 2024 09:17:04 +0200
Message-ID: <20240727071742.1735703-4-patrick.rudolph@9elements.com>
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

Write MADT in common code and let the SoC fill out the body by
calling acpi_fill_madt() which must be implemented at SoC level.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 arch/sandbox/lib/Makefile         |  9 +++---
 arch/sandbox/lib/acpi_table.c     |  7 +++++
 arch/x86/cpu/intel_common/acpi.c  | 20 +++++++++-----
 arch/x86/cpu/tangier/acpi.c       |  6 +++-
 arch/x86/include/asm/acpi_table.h |  3 +-
 arch/x86/lib/acpi_table.c         | 46 ++++++-------------------------
 include/acpi/acpi_table.h         | 11 ++++++++
 lib/acpi/acpi_table.c             | 31 +++++++++++++++++++++
 8 files changed, 81 insertions(+), 52 deletions(-)
 create mode 100644 arch/sandbox/lib/acpi_table.c

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
new file mode 100644
index 0000000000..6d05ae7a49
--- /dev/null
+++ b/arch/sandbox/lib/acpi_table.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <acpi/acpi_table.h>
+
+void *acpi_fill_madt(struct acpi_madt *madt, void *current)
+{
+	return current;
+}
diff --git a/arch/x86/cpu/intel_common/acpi.c b/arch/x86/cpu/intel_common/acpi.c
index 29676b4abf..dc58a8103e 100644
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
@@ -80,33 +81,38 @@ static int acpi_sci_irq(void)
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
+void *acpi_fill_madt(struct acpi_madt *madt, void *current)
 {
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
index 1c73a9dbfe..9e5e6c57aa 100644
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
@@ -31,8 +32,11 @@ void acpi_fill_fadt(struct acpi_fadt *fadt)
 	fadt->minor_revision = 2;
 }
 
-u32 acpi_fill_madt(u32 current)
+void *acpi_fill_madt(struct acpi_madt *madt, void *current)
 {
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
index ff02ce80d1..4eca435e55 100644
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
@@ -100,23 +100,26 @@ int acpi_create_madt_lapic_nmi(struct acpi_madt_lapic_nmi *lapic_nmi,
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
+__weak void *acpi_fill_madt(struct acpi_madt *madt, void *current)
 {
+	madt->lapic_addr = LAPIC_DEFAULT_BASE;
+	madt->flags = ACPI_MADT_PCAT_COMPAT;
+
 	current += acpi_create_madt_lapics(current);
 
 	current += acpi_create_madt_ioapic((struct acpi_madt_ioapic *)current,
@@ -127,39 +130,6 @@ __weak u32 acpi_fill_madt(u32 current)
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
index 03b69854bf..904c54e38e 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -935,6 +935,17 @@ int acpi_fill_csrt(struct acpi_ctx *ctx);
  */
 void acpi_fill_fadt(struct acpi_fadt *fadt);
 
+/**
+ * acpi_fill_madt() - Fill out the body of the MADT
+ *
+ * Must be implemented in SoC specific code.
+ *
+ * @madt: The MADT to update
+ * @current: Pointer to the MADT body
+ * @return Pointer to the end of tables, where the next tables can be written
+ */
+void *acpi_fill_madt(struct acpi_madt *madt, void *current);
+
 /**
  * acpi_write_dbg2_pci_uart() - Write out a DBG2 table
  *
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 56c1bcd691..d94e454018 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -244,6 +244,37 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 
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
+	current = (void *)madt + sizeof(struct acpi_madt);
+	current = acpi_fill_madt(madt, current);
+
+	/* (Re)calculate length and checksum */
+	header->length = (uintptr_t)current - (uintptr_t)madt;
+
+	header->checksum = table_compute_checksum((void *)madt, header->length);
+	acpi_add_table(ctx, madt);
+	acpi_inc(ctx, madt->header.length);
+
+	return 0;
+}
+
+ACPI_WRITER(5madt, "MADT", acpi_write_madt, 0);
+
 static void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
 			     int port_type, int port_subtype,
 			     struct acpi_gen_regaddr *address, u32 address_size,
-- 
2.45.2

