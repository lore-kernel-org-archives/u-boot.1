Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2B6C3DA61
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E55C88648;
	Sat, 27 Jul 2024 09:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="eW7V1E8y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6925788636; Sat, 27 Jul 2024 09:20:11 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40AB087873
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7aa4bf4d1eso287734066b.0
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064809; x=1722669609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73HQ/BaL65dh2urkkq9IaWx9BIlH+ajZ9ajFR4TUWXA=;
 b=eW7V1E8yW/Yu5SV2zfS54BKnqDFQtcG6AYpOoYvG02NwylorH3+4APw/uaVav2uR/N
 9xgYDYOyPG/Qi9H3x2iy+oQwCb+SG+iiZVc/zyvQ2+uIhwHqCXVcLcuJd/7NhvN1k5y8
 2Meb3QLrPRxpUXUm09nAnY9gcQjYAKXWfpbIH5udefl7SUJBqF39Pqq0f7wdExlkyaT5
 DIyEXAu11Q1putPs/98yG26WbtpuQu1faI9V9zjksjssSxY6mQvubbhbuv+87mYEITPF
 tZL+OV25/IewTVoYJ6eSMBf5aLnchnWmdsfue7jMoA5ewo6po+I8FPyRg/YlpPfJ8H4Q
 ODEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064809; x=1722669609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=73HQ/BaL65dh2urkkq9IaWx9BIlH+ajZ9ajFR4TUWXA=;
 b=aKyUFqrCsQyzD5tn7jUccgyuFE88mwfDLu+LDlTwJKM25Iqsp4JkGAL7az2djUY+Gz
 wEtt65WSdUsMlCRnrDQ5rdB3a1mM2oZrd7Bdc4AHemAuz79wZO3eMpAW/03rubIRTVn0
 IgKqWxFO/pPUHgpooJGO2TA04GFW84WSgk8qnjRsfjHZW2UsrK3ltqj8dFOTMP4uNQmC
 +Ellh+dMuSUQ4P7RQGR9G05SVE5dxbprcPzVH+KbmlwxWmgi/hRv6x9o17d3LnZbwipF
 2J+ZuMt16843sryJKL7zCPJk5yE/QonjERt3muLhapO7jc4M0A9DNV+4Vnc2wWUj5uay
 GfEg==
X-Gm-Message-State: AOJu0Yx2LAPZf4py6WaGG73Vg3MfO2BhwVku4rlJQTJJ1/M0epH/Bqam
 RUt0Wwl0h3BeT8cAbafF4GETsmsESp4SRNI1h3wrfit2SMy1Hu2rM4spiMBan3IPYKKj7YD9bhd
 8jcA=
X-Google-Smtp-Source: AGHT+IE8pe+DhazGGyUS0J8vAoudCGqHDJHpK3M6ZsccHNYpfmb+I+dkJJJeRj0mCbd3rzDGEi0fww==
X-Received: by 2002:a17:907:3e1a:b0:a7a:c256:3cf with SMTP id
 a640c23a62f3a-a7d3ff58cc5mr119726066b.24.1722064808701; 
 Sat, 27 Jul 2024 00:20:08 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:08 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com,
 bmeng.cn@gmail.com, Maximilian Brune <maximilian.brune@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 02/17] acpi: x86: Write FADT in common code
Date: Sat, 27 Jul 2024 09:17:03 +0200
Message-ID: <20240727071742.1735703-3-patrick.rudolph@9elements.com>
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
index fa19ea84df..03b69854bf 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -926,6 +926,15 @@ void acpi_fill_header(struct acpi_table_header *header, char *signature);
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
  * acpi_write_dbg2_pci_uart() - Write out a DBG2 table
  *
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index e7e074d25e..56c1bcd691 100644
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
 static void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
 			     int port_type, int port_subtype,
 			     struct acpi_gen_regaddr *address, u32 address_size,
-- 
2.45.2

