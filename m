Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF08ACE7AB8
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF5DF88D08;
	Fri,  6 Sep 2024 09:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="A3AZ9rIl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EDA788D21; Fri,  6 Sep 2024 09:22:44 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0182E88D10
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8a16c53d3cso234169366b.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607359; x=1726212159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUYWHCmnZWhfOLtBQ8uqkKQApcjWwr3XZLgtsTbrM2o=;
 b=A3AZ9rIlL1vPDMAX9N94yrR5A9m9n9JQ6j6vY0jz5LeJXaok31ZhRbA3L04+G61EM8
 shfAHrDFO/z9qntuoJ/etmsKG1jLL+vL9WkqgJIGlSpIwagQ1GlTSGGt1sXjCbKdgQP/
 JYBnF6NUx7ziHAn0yLev9bNhx1R2BLeRM1Hkb6KiwJuAwZoW9ldzj+YszkpoxazmMPA/
 dnH3N6kxtz7KmWv633YWsDe/jiM8WN0NwwGUHrFJ8ZvmhgGg+qziIlVUVF4if+1eTwhG
 i/kg5IX3Xu2XzbEMgG8RlTKf2mwywGQfvavT7SZ1o/KgBl6yBI3SDl6xbljmFXE2oA+z
 Rtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607359; x=1726212159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aUYWHCmnZWhfOLtBQ8uqkKQApcjWwr3XZLgtsTbrM2o=;
 b=P7KIybFHm7WSYkcszlYqx8Tk9yVa85l2PnjgbroeR3lHKNknpgavLo2IIlfXi5bqz6
 1ur9ayIwFPrFk9WUdcGiQIU7Mivwv1fxhsKcFJzF1bg13K/lQgFfvJ3LFoEVl8NA0cuK
 AL17c1mFRGgkREhq8rAl2IUasSVFJ5juv2bJlE92+biiL7llkdes+ryVhUl7Z11j064U
 r+3bqZ4p8Z4XEhADsoE35FxDDP2VjMjOHlo9zfquRE56kQ1WmqrZfMetyQbYR5tCQs49
 1yZkQt0/V2fGDHM4MYdyrqFHZqD/Y1ONZo/wjnTOBSWiEGvnAouacnOYRP5pjmmfMWxp
 bMsw==
X-Gm-Message-State: AOJu0YwBvkB3SRpGf0pABuduEdNVn9wwqlqwenVDkCKwwFKKQVaxn1Lr
 SooekD7iqntsNhbuoCVqqvJ+ahBooua+4hYtEd5gjCgO0oVl09Q2vNYf/7+FWFMa/Xk/+rwPDBx
 Z
X-Google-Smtp-Source: AGHT+IFvY4jVc3UgOqtGByES4I2Dd0uydTRRIQEgmpHyJNIWzrX5mWJUmCeO8LF0kf6EBuijIjp5Bg==
X-Received: by 2002:a17:907:1c16:b0:a7d:a680:23b5 with SMTP id
 a640c23a62f3a-a897f8d5179mr2102722866b.33.1725607359226; 
 Fri, 06 Sep 2024 00:22:39 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:38 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 03/28] acpi: x86: Move MADT to common code
Date: Fri,  6 Sep 2024 09:22:05 +0200
Message-ID: <20240906072231.2531491-4-patrick.rudolph@9elements.com>
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
index aa79e61084..58630b3c4c 100644
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
+ * @current: Pointer to the MADT body
+ * @return Pointer to the end of tables, where the next tables can be written
+ */
+void *acpi_fill_madt(struct acpi_madt *madt, void *current);
+
 /**
  * acpi_get_rsdp_addr() - get ACPI RSDP table address
  *
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 1b25fe1b9c..823af43045 100644
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
 void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
 		      int port_type, int port_subtype,
 		      struct acpi_gen_regaddr *address, u32 address_size,
-- 
2.45.2

