Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3DDEE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8612389171;
	Wed, 11 Sep 2024 08:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Qp04Z7vn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05CAC89167; Wed, 11 Sep 2024 08:25:23 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5E0389165
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8d100e9ce0so635566666b.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035920; x=1726640720; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4O+ZSyNWVCuYlHBwR75PNFHBbOyaDACFAZxJd8qS7Jo=;
 b=Qp04Z7vndsShX976OEU/PVBL0ny4ln7Fo9G4M3XYRBH10+g4620NYoC/BNpbAr5RDZ
 CZy1bu8ZgUBvFFHepUyYAWIBK5dwHr6z7lMQx2lZUanOEs8C21YFSoyglPROMEIotswf
 O07hMD44fhHQ5Xo6lDZlwdOS3JWPwCcsdTzgRdEtfhhK8eXzCLu0vohH89J5lqb2gJ16
 9Bb09g9aPhjiUAyqXVFtzR9lMdHmNe2WagHNPmhYQrGEQbo7XeThp8OcU8kSKpxcl+2n
 uPSdq6qxVN5NDsQoT3pJKNf++IcwfADxzrhFsxTcFLzXDp6e+278JgZJF2a5qGwmsAjb
 rKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035920; x=1726640720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4O+ZSyNWVCuYlHBwR75PNFHBbOyaDACFAZxJd8qS7Jo=;
 b=tYiIdkAaTrs3v4ce4PXVCirUu9gUJnTpTlvjcYhzVgLZnpevBiJHTpv2PXl4diSFld
 xNLoKCd6oCfAfaj6O6a+yu4PMseqtO+RGZRxAakxySeEQ22j3x2bY2nUOifqL0qFT87K
 FhrdPQKEnO4h1iGodxhrEHIbCOxce3X+4A2YJyqYoYGGuk3ErQyuY/7CfB7sRlFecmKI
 bCak7SW6N7aI3fBMtYFKbIZsS9H19zr+8zgGtDr9nZPeT65z0AJKbJS9Mr9X9MTO551/
 KFB6ijBoUoCaIT20r1xnkpF368pYQwt2q5lt1LY19eLJbSC3jApY//ooAc0Pyt6sd/Hs
 tzIg==
X-Gm-Message-State: AOJu0YxCRrZ4n1G8L42ScxALO3N40jS99I4BMjua4PJk14F0ZyUV1zTC
 EA101qcz1v+7wiINqP9xTA2T8HjFbTfDYB6SxBwiI6YGiHkDq1aVJt0zudmajVYdwPGIusyvpFQ
 Z
X-Google-Smtp-Source: AGHT+IEiUNC3BUm2wFTWuW75vdBlpFfm/OrY8BQedzlGZfyDFojy7Uy3186qL8zzsRn6ESAzg5XzyQ==
X-Received: by 2002:a17:907:3e92:b0:a8d:61ca:271e with SMTP id
 a640c23a62f3a-a8ffaaa2698mr325647366b.6.1726035920178; 
 Tue, 10 Sep 2024 23:25:20 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:19 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Maximilian Brune <maximilian.brune@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 02/30] acpi: x86: Write FADT in common code
Date: Wed, 11 Sep 2024 08:23:52 +0200
Message-ID: <20240911062511.494855-3-patrick.rudolph@9elements.com>
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

From: Maximilian Brune <maximilian.brune@9elements.com>

Write the FADT in common code since it's used on all architectures.
Let the cpu code fill out the FADT body by introducing a new weak
function acpi_fill_fadt().

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 arch/x86/cpu/apollolake/acpi.c    | 20 +++------------
 arch/x86/cpu/baytrail/acpi.c      | 17 +------------
 arch/x86/cpu/quark/acpi.c         | 19 +-------------
 arch/x86/cpu/tangier/acpi.c       | 25 ++----------------
 arch/x86/include/asm/acpi_table.h | 12 ---------
 arch/x86/lib/acpi_table.c         | 23 -----------------
 include/acpi/acpi_table.h         |  9 +++++++
 lib/acpi/acpi_table.c             | 42 +++++++++++++++++++++++++++++++
 8 files changed, 59 insertions(+), 108 deletions(-)

diff --git a/arch/x86/cpu/apollolake/acpi.c b/arch/x86/cpu/apollolake/acpi.c
index 76230aea83..93040e7bb3 100644
--- a/arch/x86/cpu/apollolake/acpi.c
+++ b/arch/x86/cpu/apollolake/acpi.c
@@ -128,8 +128,10 @@ int arch_madt_sci_irq_polarity(int sci)
 	return MP_IRQ_POLARITY_LOW;
 }
 
-void fill_fadt(struct acpi_fadt *fadt)
+void acpi_fill_fadt(struct acpi_fadt *fadt)
 {
+	intel_acpi_fill_fadt(fadt);
+
 	fadt->pm_tmr_blk = IOMAP_ACPI_BASE + PM1_TMR;
 
 	fadt->p_lvl2_lat = ACPI_FADT_C2_NOT_SUPPORTED;
@@ -143,23 +145,9 @@ void fill_fadt(struct acpi_fadt *fadt)
 	fadt->x_pm_tmr_blk.space_id = 1;
 	fadt->x_pm_tmr_blk.bit_width = fadt->pm_tmr_len * 8;
 	fadt->x_pm_tmr_blk.addrl = IOMAP_ACPI_BASE + PM1_TMR;
-}
-
-static int apl_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
-{
-	struct acpi_table_header *header;
-	struct acpi_fadt *fadt;
-
-	fadt = ctx->current;
-	acpi_fadt_common(fadt, ctx->facs, ctx->dsdt);
-	intel_acpi_fill_fadt(fadt);
-	fill_fadt(fadt);
-	header = &fadt->header;
-	header->checksum = table_compute_checksum(fadt, header->length);
 
-	return acpi_add_fadt(ctx, fadt);
+	fadt->preferred_pm_profile = ACPI_PM_MOBILE;
 }
-ACPI_WRITER(5fadt, "FADT", apl_write_fadt, 0);
 
 int apl_acpi_fill_dmar(struct acpi_ctx *ctx)
 {
diff --git a/arch/x86/cpu/baytrail/acpi.c b/arch/x86/cpu/baytrail/acpi.c
index 7821964f1f..7e1c2de3d3 100644
--- a/arch/x86/cpu/baytrail/acpi.c
+++ b/arch/x86/cpu/baytrail/acpi.c
@@ -15,20 +15,13 @@
 #include <asm/arch/iomap.h>
 #include <dm/uclass-internal.h>
 
-static int baytrail_write_fadt(struct acpi_ctx *ctx,
-			       const struct acpi_writer *entry)
+void acpi_fill_fadt(struct acpi_fadt *fadt)
 {
 	struct acpi_table_header *header;
-	struct acpi_fadt *fadt;
 
-	fadt = ctx->current;
 	header = &fadt->header;
 	u16 pmbase = ACPI_BASE_ADDRESS;
 
-	memset(fadt, '\0', sizeof(struct acpi_fadt));
-
-	acpi_fill_header(header, "FACP");
-	header->length = sizeof(struct acpi_fadt);
 	header->revision = 4;
 
 	fadt->preferred_pm_profile = ACPI_PM_MOBILE;
@@ -77,9 +70,6 @@ static int baytrail_write_fadt(struct acpi_ctx *ctx,
 	fadt->reset_reg.addrh = 0;
 	fadt->reset_value = SYS_RST | RST_CPU | FULL_RST;
 
-	fadt->x_firmware_ctrl = map_to_sysmem(ctx->facs);
-	fadt->x_dsdt = map_to_sysmem(ctx->dsdt);
-
 	fadt->x_pm1a_evt_blk.space_id = ACPI_ADDRESS_SPACE_IO;
 	fadt->x_pm1a_evt_blk.bit_width = fadt->pm1_evt_len * 8;
 	fadt->x_pm1a_evt_blk.bit_offset = 0;
@@ -135,12 +125,7 @@ static int baytrail_write_fadt(struct acpi_ctx *ctx,
 	fadt->x_gpe1_blk.access_size = 0;
 	fadt->x_gpe1_blk.addrl = 0x0;
 	fadt->x_gpe1_blk.addrh = 0x0;
-
-	header->checksum = table_compute_checksum(fadt, header->length);
-
-	return acpi_add_fadt(ctx, fadt);
 }
-ACPI_WRITER(5fadt, "FADT", baytrail_write_fadt, 0);
 
 int acpi_create_gnvs(struct acpi_global_nvs *gnvs)
 {
diff --git a/arch/x86/cpu/quark/acpi.c b/arch/x86/cpu/quark/acpi.c
index 80e94600fc..0fe5f2bafb 100644
--- a/arch/x86/cpu/quark/acpi.c
+++ b/arch/x86/cpu/quark/acpi.c
@@ -11,23 +11,14 @@
 #include <asm/arch/iomap.h>
 #include <linux/string.h>
 
-static int quark_write_fadt(struct acpi_ctx *ctx,
-			    const struct acpi_writer *entry)
+void acpi_fill_fadt(struct acpi_fadt *fadt)
 {
 	u16 pmbase = ACPI_PM1_BASE_ADDRESS;
 	struct acpi_table_header *header;
-	struct acpi_fadt *fadt;
 
-	fadt = ctx->current;
 	header = &fadt->header;
-
-	memset(fadt, '\0', sizeof(struct acpi_fadt));
-
-	acpi_fill_header(header, "FACP");
-	header->length = sizeof(struct acpi_fadt);
 	header->revision = 4;
 
-	fadt->preferred_pm_profile = ACPI_PM_UNSPECIFIED;
 	fadt->sci_int = 9;
 	fadt->smi_cmd = 0;
 	fadt->acpi_enable = 0;
@@ -73,9 +64,6 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
 	fadt->reset_reg.addrh = 0;
 	fadt->reset_value = SYS_RST | RST_CPU | FULL_RST;
 
-	fadt->x_firmware_ctrl = map_to_sysmem(ctx->facs);
-	fadt->x_dsdt = map_to_sysmem(ctx->dsdt);
-
 	fadt->x_pm1a_evt_blk.space_id = ACPI_ADDRESS_SPACE_IO;
 	fadt->x_pm1a_evt_blk.bit_width = fadt->pm1_evt_len * 8;
 	fadt->x_pm1a_evt_blk.bit_offset = 0;
@@ -131,12 +119,7 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
 	fadt->x_gpe1_blk.access_size = 0;
 	fadt->x_gpe1_blk.addrl = 0x0;
 	fadt->x_gpe1_blk.addrh = 0x0;
-
-	header->checksum = table_compute_checksum(fadt, header->length);
-
-	return acpi_add_fadt(ctx, fadt);
 }
-ACPI_WRITER(5fadt, "FADT", quark_write_fadt, 0);
 
 int acpi_create_gnvs(struct acpi_global_nvs *gnvs)
 {
diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
index d4d0ef6f85..1c73a9dbfe 100644
--- a/arch/x86/cpu/tangier/acpi.c
+++ b/arch/x86/cpu/tangier/acpi.c
@@ -16,21 +16,8 @@
 #include <asm/arch/iomap.h>
 #include <dm/uclass-internal.h>
 
-static int tangier_write_fadt(struct acpi_ctx *ctx,
-			      const struct acpi_writer *entry)
+void acpi_fill_fadt(struct acpi_fadt *fadt)
 {
-	struct acpi_table_header *header;
-	struct acpi_fadt *fadt;
-
-	fadt = ctx->current;
-	header = &fadt->header;
-
-	memset(fadt, '\0', sizeof(struct acpi_fadt));
-
-	acpi_fill_header(header, "FACP");
-	header->length = sizeof(struct acpi_fadt);
-	header->revision = 6;
-
 	fadt->preferred_pm_profile = ACPI_PM_UNSPECIFIED;
 
 	fadt->iapc_boot_arch = ACPI_FADT_VGA_NOT_PRESENT |
@@ -40,17 +27,9 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
 		ACPI_FADT_POWER_BUTTON | ACPI_FADT_SLEEP_BUTTON |
 		ACPI_FADT_SEALED_CASE | ACPI_FADT_HEADLESS |
 		ACPI_FADT_HW_REDUCED_ACPI;
-
+	fadt->header.revision = 6;
 	fadt->minor_revision = 2;
-
-	fadt->x_firmware_ctrl = map_to_sysmem(ctx->facs);
-	fadt->x_dsdt = map_to_sysmem(ctx->dsdt);
-
-	header->checksum = table_compute_checksum(fadt, header->length);
-
-	return acpi_add_fadt(ctx, fadt);
 }
-ACPI_WRITER(5fadt, "FADT", tangier_write_fadt, 0);
 
 u32 acpi_fill_madt(u32 current)
 {
diff --git a/arch/x86/include/asm/acpi_table.h b/arch/x86/include/asm/acpi_table.h
index e617524617..3988898f66 100644
--- a/arch/x86/include/asm/acpi_table.h
+++ b/arch/x86/include/asm/acpi_table.h
@@ -168,18 +168,6 @@ int acpi_create_dmar_ds_ioapic(struct acpi_ctx *ctx, uint enumeration_id,
 int acpi_create_dmar_ds_msi_hpet(struct acpi_ctx *ctx, uint enumeration_id,
 				 pci_dev_t bdf);
 
-/**
- * acpi_fadt_common() - Handle common parts of filling out an FADT
- *
- * This sets up the Fixed ACPI Description Table
- *
- * @fadt: Pointer to place to put FADT
- * @facs: Pointer to the FACS
- * @dsdt: Pointer to the DSDT
- */
-void acpi_fadt_common(struct acpi_fadt *fadt, struct acpi_facs *facs,
-		      void *dsdt);
-
 /**
  * intel_acpi_fill_fadt() - Set up the contents of the FADT
  *
diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index 08fd1e54ce..ff02ce80d1 100644
--- a/arch/x86/lib/acpi_table.c
+++ b/arch/x86/lib/acpi_table.c
@@ -381,29 +381,6 @@ int acpi_write_hpet(struct acpi_ctx *ctx)
 	return 0;
 }
 
-void acpi_fadt_common(struct acpi_fadt *fadt, struct acpi_facs *facs,
-		      void *dsdt)
-{
-	struct acpi_table_header *header = &fadt->header;
-
-	memset((void *)fadt, '\0', sizeof(struct acpi_fadt));
-
-	acpi_fill_header(header, "FACP");
-	header->length = sizeof(struct acpi_fadt);
-	header->revision = 4;
-	memcpy(header->oem_id, OEM_ID, 6);
-	memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
-	memcpy(header->creator_id, ASLC_ID, 4);
-
-	fadt->x_firmware_ctrl = map_to_sysmem(facs);
-	fadt->x_dsdt = map_to_sysmem(dsdt);
-
-	fadt->preferred_pm_profile = ACPI_PM_MOBILE;
-
-	/* Use ACPI 3.0 revision */
-	fadt->header.revision = 4;
-}
-
 void acpi_create_dmar_drhd(struct acpi_ctx *ctx, uint flags, uint segment,
 			   u64 bar)
 {
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index a372435492..aa79e61084 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -954,6 +954,15 @@ void acpi_fill_header(struct acpi_table_header *header, char *signature);
  */
 int acpi_fill_csrt(struct acpi_ctx *ctx);
 
+/**
+ * acpi_fill_fadt() - Fill out the body of the FADT
+ *
+ * Should be implemented in SoC specific code.
+ *
+ * @fadt: Pointer to FADT to update
+ */
+void acpi_fill_fadt(struct acpi_fadt *fadt);
+
 /**
  * acpi_get_rsdp_addr() - get ACPI RSDP table address
  *
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index c9ddcca8cb..1b25fe1b9c 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -202,6 +202,48 @@ int acpi_add_table(struct acpi_ctx *ctx, void *table)
 	return 0;
 }
 
+__weak void acpi_fill_fadt(struct acpi_fadt *fadt)
+{
+}
+
+int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
+{
+	struct acpi_table_header *header;
+	struct acpi_fadt *fadt;
+
+	fadt = ctx->current;
+	header = &fadt->header;
+
+	memset((void *)fadt, '\0', sizeof(struct acpi_fadt));
+
+	acpi_fill_header(header, "FACP");
+	header->length = sizeof(struct acpi_fadt);
+	header->revision = acpi_get_table_revision(ACPITAB_FADT);
+	memcpy(header->oem_id, OEM_ID, 6);
+	memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
+	memcpy(header->creator_id, ASLC_ID, 4);
+	header->creator_revision = 1;
+
+	fadt->x_firmware_ctrl = map_to_sysmem(ctx->facs);
+	fadt->x_dsdt = map_to_sysmem(ctx->dsdt);
+
+	if (fadt->x_firmware_ctrl < 0x100000000ULL)
+		fadt->firmware_ctrl = fadt->x_firmware_ctrl;
+
+	if (fadt->x_dsdt < 0x100000000ULL)
+		fadt->dsdt = fadt->x_dsdt;
+
+	fadt->preferred_pm_profile = ACPI_PM_UNSPECIFIED;
+
+	acpi_fill_fadt(fadt);
+
+	header->checksum = table_compute_checksum(fadt, header->length);
+
+	return acpi_add_fadt(ctx, fadt);
+}
+
+ACPI_WRITER(5fadt, "FADT", acpi_write_fadt, 0);
+
 void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
 		      int port_type, int port_subtype,
 		      struct acpi_gen_regaddr *address, u32 address_size,
-- 
2.46.0

