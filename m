Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7837CF31AE
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 829B288F70;
	Wed,  2 Oct 2024 11:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Trbyez1V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E078588F9B; Wed,  2 Oct 2024 11:51:34 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE8AD88FD4
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42f56ad2afaso71611925e9.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862691; x=1728467491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rajTw/VAx/wKoHrR6gGJwaa29ANo5hsQTIdLVt3EW6s=;
 b=Trbyez1VCJVu73yJxJ+FS8i1cR64ZchcqMM7mWNH+kUthP6/LuyD8hKXKsancLcJVl
 qKlUugoHn/IC1e6L5RvDjamWn66eZicVjT8yBuWFMk/t+wEdXz6NXdxx5TX+gfGEEQPg
 ApVVW/cm1iLiAj64GY4UdMwau4zqMvQACkH+0tjR+HJKh3Wo1mNd+rVi7ANwl2+IFhiO
 XFNPmk0dpVyFwmw9gIP4UI1svFAlY3jTob7deuI1JAucNTjXZ+fNUjbgr91ppInWFgR7
 fXT8+5O7HxAvLS/h8qvk6qAq3Z5TlcqBATLkcxP1B/3RgYR1vCNwdLP3AabS3ykDVg8k
 Kuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862691; x=1728467491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rajTw/VAx/wKoHrR6gGJwaa29ANo5hsQTIdLVt3EW6s=;
 b=OxwAeJPsuSGCSo5l/R3EZtGhzNvyKZe5M7RwjkSgejfECBpQkmXGUslOK7WYG+qPVu
 RRSGeecaHcetGDmVlMDWXY35ascGBW8LG5tY9rT6hsdgLHeOpAHAjyKdmNSb1xXLenAH
 uu9Q2PjHsuVq4dI4clk5JvfTorrbUoxAxjHhTTsWhRv0AjFu0A3AXylQDQ0JrZK95pMd
 g85uRsHBlg8pDLuZSBxvY+7EV4/zE7jVL+lwUYnYEuVTkklDz7dMTSpychQFhvsCyY4x
 wpqKnW38VQuXBV0tNk/KBXGWLwzjKKNK+I+H1JA9arCCwtRAkjzqR+k/JscXHlHwLo/u
 WrKg==
X-Gm-Message-State: AOJu0YwYbVIHsgL7PPwf7nuVLElb73VHgQwspMSodA+2wjytLkxiqye2
 xAyR7OwqUHnxS4jybybBHF7lMKQGjO2kNad1YsrTzVVVuJciGGRDr/yMOlaNowJQ0Rhk9/u4pZi
 /
X-Google-Smtp-Source: AGHT+IEJLSB6VCsNBsGsHMCF9PDsEOpzgGLO7QSOIF2nveW/Uqu+D7YZY1oB+0IGyoL7oPqffxcshg==
X-Received: by 2002:a05:600c:46c9:b0:426:59fe:ac27 with SMTP id
 5b1f17b1804b1-42f777f059bmr22393565e9.26.1727862691165; 
 Wed, 02 Oct 2024 02:51:31 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:51:30 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 03/37] acpi: x86: Move MADT to common code
Date: Wed,  2 Oct 2024 11:46:54 +0200
Message-ID: <20241002094832.24933-4-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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

