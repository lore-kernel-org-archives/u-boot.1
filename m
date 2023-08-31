Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200F4C83F15
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E925586553;
	Thu, 31 Aug 2023 05:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xak6yCi/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C9AE86551; Thu, 31 Aug 2023 05:13:51 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F9CC86553
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-792623074edso37479539f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693451626; x=1694056426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IgN/mHDxjLI3n3oSWHkqvaJSGYK0DsNfpUBHvxLmfzU=;
 b=Xak6yCi/bxZx0rPwjDqbUZ9YVuQ6X1gcmkYju7+0C9g2OegJV883JGbpw0ys55Wksw
 Q/5C4rCSb3/WRkxZXj0AIGxTgKP0pfMFpndz1AoNDZe7rQjWfRR3FV24Oxhr6hSq886Q
 5Y7nNDrTxB6SWheQR8WZ1zm7tI7L68QC2yKR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693451626; x=1694056426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IgN/mHDxjLI3n3oSWHkqvaJSGYK0DsNfpUBHvxLmfzU=;
 b=Qti1hzE6RcNJK93JVxC7VyYTePuC6qgRirdcGY52FRQ7mAVJShZ34DyTkw/cu1XnXV
 3rierS7Xz2lPDjJiuaYd1kOW/QSaz8A2rVZZgMLAdbmnmEbd18cPGyQWUtaifs+aUekR
 eVBBT+nTcZLYeMX1I/0V5IImfUg58hKID3fmirKIu/QW+1NypgEnvUs8h1Md+K+WGn/q
 j1BHBcJTNitZSGfY/Xdm2YsMBC1WOuVDA1F7ofboQNLDPs9k0LGONtPWnxfk3phOoUmR
 sD4LyNrJL4YWaf8Oub57Hl1xD3BlelusAaZVw6EHBQdQyDiXfcV2BAOUgsI+uRiuL867
 b+qw==
X-Gm-Message-State: AOJu0YztfMcxAs3BLR3rW9MviOmhEGnsaK8OJARe9Y6oBqQ3pqls+VLl
 ZIM1C10WeYsiIvIc2dmFTClsXVemQvbvLDH0QTc=
X-Google-Smtp-Source: AGHT+IH7Noc+0LVx3yvmM6EzqN2G9BWboRDksnSZmY5OFW8HLwd//rrYo8qsuonrDcCev8Qts46pyQ==
X-Received: by 2002:a05:6e02:12c5:b0:34d:fac9:bf1b with SMTP id
 i5-20020a056e0212c500b0034dfac9bf1bmr1191406ilm.1.1693451625939; 
 Wed, 30 Aug 2023 20:13:45 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a02ac8a000000b0042bbfe3dc42sm142879jan.173.2023.08.30.20.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:13:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/2] Reland "x86: Move FACP table into separate functions""
Date: Wed, 30 Aug 2023 21:13:34 -0600
Message-ID: <20230831031341.2657786-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
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

Each board has its own way of creating this table. Rather than calling the
acpi_create_fadt() function for each one from a common acpi_write_fadt()
function, just move the writer into the board-specific code.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
(Now fixed - thank you Andy!)

Make another attempt to land this. It apparently breaks Edison but I
cannot test that board, nor can I work out what is wrong with the code.

Previous test report is here:

   https://lore.kernel.org/all/Yga9Z7sBFAeV64FV@smile.fi.intel.com/

Looking at the image, the method is definitely present:

   $ nm /tmp/b/edison/u-boot |grep acpi_writer
   0115fde0 D _u_boot_list_2_acpi_writer_2_0base
   0115fdf0 D _u_boot_list_2_acpi_writer_2_1facs
   0115fe00 D _u_boot_list_2_acpi_writer_2_3dsdt
   0115fe10 D _u_boot_list_2_acpi_writer_2_4gnvs
   0115fe20 D _u_boot_list_2_acpi_writer_2_5csrt
   0115fe30 D _u_boot_list_2_acpi_writer_2_5fadt
   0115fe40 D _u_boot_list_2_acpi_writer_2_5mcfg
   0115fe50 D _u_boot_list_2_acpi_writer_2_5spcr
   0115fe60 D _u_boot_list_2_acpi_writer_2_5tcpa
   0115fe70 D _u_boot_list_2_acpi_writer_2_5tpm2
   0115fe80 D _u_boot_list_2_acpi_writer_2_5x86
   0115fe90 D _u_boot_list_2_acpi_writer_2_6ssdt
   0115fea0 D _u_boot_list_2_acpi_writer_2_8dev

I wonder if the code in quark_write_fadt() is not being called?

'acpi list' shows what tables are installed. On minnowmax there is no
difference with or without this patch. Perhaps someone with sharper eyes
than me can figure this out?

The mechanism is that the functions to be called are put in a linker list,
each element being declared using ACPI_WRITER(function_name).

Then acpi_write_all() is called to write each one. Debugging could be
added to that function, perhaps?

Changes in v2:
- Squash in the fix from Andy Shevchenko

 arch/x86/cpu/apollolake/acpi.c    | 17 +++++++++++++----
 arch/x86/cpu/baytrail/acpi.c      | 27 +++++++++++++++++++--------
 arch/x86/cpu/quark/acpi.c         | 27 +++++++++++++++++++--------
 arch/x86/cpu/tangier/acpi.c       | 27 +++++++++++++++++++--------
 arch/x86/include/asm/acpi_table.h |  2 --
 arch/x86/lib/acpi_table.c         | 15 ---------------
 6 files changed, 70 insertions(+), 45 deletions(-)

diff --git a/arch/x86/cpu/apollolake/acpi.c b/arch/x86/cpu/apollolake/acpi.c
index fd21c0b4968..16aaed7238a 100644
--- a/arch/x86/cpu/apollolake/acpi.c
+++ b/arch/x86/cpu/apollolake/acpi.c
@@ -146,16 +146,25 @@ void fill_fadt(struct acpi_fadt *fadt)
 	fadt->x_pm_tmr_blk.addrl = IOMAP_ACPI_BASE + PM1_TMR;
 }
 
-void acpi_create_fadt(struct acpi_fadt *fadt, struct acpi_facs *facs,
-		      void *dsdt)
+static int apl_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 {
-	struct acpi_table_header *header = &fadt->header;
+	struct acpi_table_header *header;
+	struct acpi_fadt *fadt;
 
-	acpi_fadt_common(fadt, facs, dsdt);
+	fadt = ctx->current;
+	acpi_fadt_common(fadt, ctx->facs, ctx->dsdt);
 	intel_acpi_fill_fadt(fadt);
 	fill_fadt(fadt);
+	header = &fadt->header;
 	header->checksum = table_compute_checksum(fadt, header->length);
+
+	acpi_add_table(ctx, fadt);
+
+	acpi_inc(ctx, sizeof(struct acpi_fadt));
+
+	return 0;
 }
+ACPI_WRITER(5fadt, "FADT", apl_write_fadt, 0);
 
 int apl_acpi_fill_dmar(struct acpi_ctx *ctx)
 {
diff --git a/arch/x86/cpu/baytrail/acpi.c b/arch/x86/cpu/baytrail/acpi.c
index 07757b88a30..4c526ff2731 100644
--- a/arch/x86/cpu/baytrail/acpi.c
+++ b/arch/x86/cpu/baytrail/acpi.c
@@ -15,20 +15,24 @@
 #include <asm/arch/iomap.h>
 #include <dm/uclass-internal.h>
 
-void acpi_create_fadt(struct acpi_fadt *fadt, struct acpi_facs *facs,
-		      void *dsdt)
+static int baytrail_write_fadt(struct acpi_ctx *ctx,
+			       const struct acpi_writer *entry)
 {
-	struct acpi_table_header *header = &(fadt->header);
+	struct acpi_table_header *header;
+	struct acpi_fadt *fadt;
+
+	fadt = ctx->current;
+	header = &fadt->header;
 	u16 pmbase = ACPI_BASE_ADDRESS;
 
-	memset((void *)fadt, 0, sizeof(struct acpi_fadt));
+	memset(fadt, '\0', sizeof(struct acpi_fadt));
 
 	acpi_fill_header(header, "FACP");
 	header->length = sizeof(struct acpi_fadt);
 	header->revision = 4;
 
-	fadt->firmware_ctrl = (u32)facs;
-	fadt->dsdt = (u32)dsdt;
+	fadt->firmware_ctrl = (u32)ctx->facs;
+	fadt->dsdt = (u32)ctx->dsdt;
 	fadt->preferred_pm_profile = ACPI_PM_MOBILE;
 	fadt->sci_int = 9;
 	fadt->smi_cmd = 0;
@@ -75,9 +79,9 @@ void acpi_create_fadt(struct acpi_fadt *fadt, struct acpi_facs *facs,
 	fadt->reset_reg.addrh = 0;
 	fadt->reset_value = SYS_RST | RST_CPU | FULL_RST;
 
-	fadt->x_firmware_ctl_l = (u32)facs;
+	fadt->x_firmware_ctl_l = (u32)ctx->facs;
 	fadt->x_firmware_ctl_h = 0;
-	fadt->x_dsdt_l = (u32)dsdt;
+	fadt->x_dsdt_l = (u32)ctx->dsdt;
 	fadt->x_dsdt_h = 0;
 
 	fadt->x_pm1a_evt_blk.space_id = ACPI_ADDRESS_SPACE_IO;
@@ -137,7 +141,14 @@ void acpi_create_fadt(struct acpi_fadt *fadt, struct acpi_facs *facs,
 	fadt->x_gpe1_blk.addrh = 0x0;
 
 	header->checksum = table_compute_checksum(fadt, header->length);
+
+	acpi_add_table(ctx, fadt);
+
+	acpi_inc(ctx, sizeof(struct acpi_fadt));
+
+	return 0;
 }
+ACPI_WRITER(5fadt, "FADT", baytrail_write_fadt, 0);
 
 int acpi_create_gnvs(struct acpi_global_nvs *gnvs)
 {
diff --git a/arch/x86/cpu/quark/acpi.c b/arch/x86/cpu/quark/acpi.c
index 82b776ff65f..92fa5bc30c3 100644
--- a/arch/x86/cpu/quark/acpi.c
+++ b/arch/x86/cpu/quark/acpi.c
@@ -10,20 +10,24 @@
 #include <asm/arch/global_nvs.h>
 #include <asm/arch/iomap.h>
 
-void acpi_create_fadt(struct acpi_fadt *fadt, struct acpi_facs *facs,
-		      void *dsdt)
+static int quark_write_fadt(struct acpi_ctx *ctx,
+			    const struct acpi_writer *entry)
 {
-	struct acpi_table_header *header = &(fadt->header);
 	u16 pmbase = ACPI_PM1_BASE_ADDRESS;
+	struct acpi_table_header *header;
+	struct acpi_fadt *fadt;
 
-	memset((void *)fadt, 0, sizeof(struct acpi_fadt));
+	fadt = ctx->current;
+	header = &fadt->header;
+
+	memset(fadt, '\0', sizeof(struct acpi_fadt));
 
 	acpi_fill_header(header, "FACP");
 	header->length = sizeof(struct acpi_fadt);
 	header->revision = 4;
 
-	fadt->firmware_ctrl = (u32)facs;
-	fadt->dsdt = (u32)dsdt;
+	fadt->firmware_ctrl = (u32)ctx->facs;
+	fadt->dsdt = (u32)ctx->dsdt;
 	fadt->preferred_pm_profile = ACPI_PM_UNSPECIFIED;
 	fadt->sci_int = 9;
 	fadt->smi_cmd = 0;
@@ -70,9 +74,9 @@ void acpi_create_fadt(struct acpi_fadt *fadt, struct acpi_facs *facs,
 	fadt->reset_reg.addrh = 0;
 	fadt->reset_value = SYS_RST | RST_CPU | FULL_RST;
 
-	fadt->x_firmware_ctl_l = (u32)facs;
+	fadt->x_firmware_ctl_l = (u32)ctx->facs;
 	fadt->x_firmware_ctl_h = 0;
-	fadt->x_dsdt_l = (u32)dsdt;
+	fadt->x_dsdt_l = (u32)ctx->dsdt;
 	fadt->x_dsdt_h = 0;
 
 	fadt->x_pm1a_evt_blk.space_id = ACPI_ADDRESS_SPACE_IO;
@@ -132,7 +136,14 @@ void acpi_create_fadt(struct acpi_fadt *fadt, struct acpi_facs *facs,
 	fadt->x_gpe1_blk.addrh = 0x0;
 
 	header->checksum = table_compute_checksum(fadt, header->length);
+
+	acpi_add_table(ctx, fadt);
+
+	acpi_inc(ctx, sizeof(struct acpi_fadt));
+
+	return 0;
 }
+ACPI_WRITER(5fadt, "FADT", quark_write_fadt, 0);
 
 int acpi_create_gnvs(struct acpi_global_nvs *gnvs)
 {
diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
index 3ffba3897aa..ffaa56ab6f8 100644
--- a/arch/x86/cpu/tangier/acpi.c
+++ b/arch/x86/cpu/tangier/acpi.c
@@ -16,19 +16,23 @@
 #include <asm/arch/iomap.h>
 #include <dm/uclass-internal.h>
 
-void acpi_create_fadt(struct acpi_fadt *fadt, struct acpi_facs *facs,
-		      void *dsdt)
+static int tangier_write_fadt(struct acpi_ctx *ctx,
+			      const struct acpi_writer *entry)
 {
-	struct acpi_table_header *header = &(fadt->header);
+	struct acpi_table_header *header;
+	struct acpi_fadt *fadt;
 
-	memset((void *)fadt, 0, sizeof(struct acpi_fadt));
+	fadt = ctx->current;
+	header = &fadt->header;
+
+	memset(fadt, '\0', sizeof(struct acpi_fadt));
 
 	acpi_fill_header(header, "FACP");
 	header->length = sizeof(struct acpi_fadt);
 	header->revision = 6;
 
-	fadt->firmware_ctrl = (u32)facs;
-	fadt->dsdt = (u32)dsdt;
+	fadt->firmware_ctrl = (u32)ctx->facs;
+	fadt->dsdt = (u32)ctx->dsdt;
 	fadt->preferred_pm_profile = ACPI_PM_UNSPECIFIED;
 
 	fadt->iapc_boot_arch = ACPI_FADT_VGA_NOT_PRESENT |
@@ -41,13 +45,20 @@ void acpi_create_fadt(struct acpi_fadt *fadt, struct acpi_facs *facs,
 
 	fadt->minor_revision = 2;
 
-	fadt->x_firmware_ctl_l = (u32)facs;
+	fadt->x_firmware_ctl_l = (u32)ctx->facs;
 	fadt->x_firmware_ctl_h = 0;
-	fadt->x_dsdt_l = (u32)dsdt;
+	fadt->x_dsdt_l = (u32)ctx->dsdt;
 	fadt->x_dsdt_h = 0;
 
 	header->checksum = table_compute_checksum(fadt, header->length);
+
+	acpi_add_table(ctx, fadt);
+
+	acpi_inc(ctx, sizeof(struct acpi_fadt));
+
+	return 0;
 }
+ACPI_WRITER(5fadt, "FADT", tangier_write_fadt, 0);
 
 u32 acpi_fill_madt(u32 current)
 {
diff --git a/arch/x86/include/asm/acpi_table.h b/arch/x86/include/asm/acpi_table.h
index 72e1873d15d..226753b65d6 100644
--- a/arch/x86/include/asm/acpi_table.h
+++ b/arch/x86/include/asm/acpi_table.h
@@ -24,8 +24,6 @@ struct acpi_table_header;
 
 /* These can be used by the target port */
 
-void acpi_create_fadt(struct acpi_fadt *fadt, struct acpi_facs *facs,
-		      void *dsdt);
 int acpi_create_madt_lapics(u32 current);
 int acpi_create_madt_ioapic(struct acpi_madt_ioapic *ioapic, u8 id,
 			    u32 addr, u32 gsi_base);
diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index e3b7e9a4bbe..c5b33dc65de 100644
--- a/arch/x86/lib/acpi_table.c
+++ b/arch/x86/lib/acpi_table.c
@@ -458,21 +458,6 @@ int acpi_write_gnvs(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 }
 ACPI_WRITER(4gnvs, "GNVS", acpi_write_gnvs, 0);
 
-static int acpi_write_fadt(struct acpi_ctx *ctx,
-			   const struct acpi_writer *entry)
-{
-	struct acpi_fadt *fadt;
-
-	fadt = ctx->current;
-	acpi_create_fadt(fadt, ctx->facs, ctx->dsdt);
-	acpi_add_table(ctx, fadt);
-
-	acpi_inc(ctx, sizeof(struct acpi_fadt));
-
-	return 0;
-}
-ACPI_WRITER(5fact, "FADT", acpi_write_fadt, 0);
-
 /**
  * acpi_write_hpet() - Write out a HPET table
  *
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

