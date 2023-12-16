Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D842C38147
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 08:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C476A87AD2;
	Sat, 16 Dec 2023 09:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GvLj09fA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEC8F87AD2; Sat, 16 Dec 2023 09:12:13 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2E6787A5F
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 09:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A9305401C3; 
 Sat, 16 Dec 2023 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702714329;
 bh=WVxSn8XqSmDkIWnFLMNY5JfcA7y+WFcmItx70Vzlg1I=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=GvLj09fAPMd3wleC22+WZiB/6M1ORa7hoU3enxRPQiftvDKdzmpOV5lPjWbW8jnPn
 v7bLzIqR2Ni8YEsH2ewgB+BB0nMUDRzX197dCOA+EW6kTZ1mCfDHFrazFxb8dGW3S/
 Xa6RUnutXWM6wBbKiWCmnBk2dlPNTwJzvZfHpC9eoJBXyD9QufVQ9xHD7Ty0ILSDI9
 dZ7KZneXZOfEB0U+4RwF1bceleSTB6vh3O1F2Rs+enqjkQ1fh1BrEjSs4Ru3Qj226t
 J6MPSHitWYDUJeFiEaWC1MjwXFlBn0YatJ2wXBv/L8EeqXw63IoHsH8Cfv7CiyMYUw
 oN8tevkqoAtDw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/4] acpi: use 64-bit addresses in FADT table
Date: Sat, 16 Dec 2023 09:11:57 +0100
Message-Id: <20231216081200.7677-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
References: <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
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

Fields X_FIRMWAE_CTRL and X_DSDT must be 64bit wide. Convert pointers to
to uintptr_t to fill these.

If field X_FIRMWARE_CTRL is filled, field FIRMWARE must be ignored. If
field X_DSDT is filled, field DSDT must be ignored. We should not fill
unused fields.

See the field definitions in chapter "5.2.9 Fixed ACPI Description Table
(FADT)" of the ACPI Specification 6.5.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/x86/cpu/baytrail/acpi.c | 9 +++------
 arch/x86/cpu/quark/acpi.c    | 9 +++------
 arch/x86/cpu/tangier/acpi.c  | 9 +++------
 arch/x86/lib/acpi_table.c    | 9 ++-------
 include/acpi/acpi_table.h    | 6 ++----
 5 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/arch/x86/cpu/baytrail/acpi.c b/arch/x86/cpu/baytrail/acpi.c
index 4378846f8b..ccc4851b18 100644
--- a/arch/x86/cpu/baytrail/acpi.c
+++ b/arch/x86/cpu/baytrail/acpi.c
@@ -7,6 +7,7 @@
 #include <cpu.h>
 #include <dm.h>
 #include <log.h>
+#include <mapmem.h>
 #include <acpi/acpi_s3.h>
 #include <acpi/acpi_table.h>
 #include <asm/io.h>
@@ -31,8 +32,6 @@ static int baytrail_write_fadt(struct acpi_ctx *ctx,
 	header->length = sizeof(struct acpi_fadt);
 	header->revision = 4;
 
-	fadt->firmware_ctrl = (u32)ctx->facs;
-	fadt->dsdt = (u32)ctx->dsdt;
 	fadt->preferred_pm_profile = ACPI_PM_MOBILE;
 	fadt->sci_int = 9;
 	fadt->smi_cmd = 0;
@@ -79,10 +78,8 @@ static int baytrail_write_fadt(struct acpi_ctx *ctx,
 	fadt->reset_reg.addrh = 0;
 	fadt->reset_value = SYS_RST | RST_CPU | FULL_RST;
 
-	fadt->x_firmware_ctl_l = (u32)ctx->facs;
-	fadt->x_firmware_ctl_h = 0;
-	fadt->x_dsdt_l = (u32)ctx->dsdt;
-	fadt->x_dsdt_h = 0;
+	fadt->x_firmware_ctrl = map_to_sysmem(ctx->facs);
+	fadt->x_dsdt = map_to_sysmem(ctx->dsdt);
 
 	fadt->x_pm1a_evt_blk.space_id = ACPI_ADDRESS_SPACE_IO;
 	fadt->x_pm1a_evt_blk.bit_width = fadt->pm1_evt_len * 8;
diff --git a/arch/x86/cpu/quark/acpi.c b/arch/x86/cpu/quark/acpi.c
index 9a2d682451..0e18ceab68 100644
--- a/arch/x86/cpu/quark/acpi.c
+++ b/arch/x86/cpu/quark/acpi.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <mapmem.h>
 #include <acpi/acpi_table.h>
 #include <asm/processor.h>
 #include <asm/tables.h>
@@ -26,8 +27,6 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
 	header->length = sizeof(struct acpi_fadt);
 	header->revision = 4;
 
-	fadt->firmware_ctrl = (u32)ctx->facs;
-	fadt->dsdt = (u32)ctx->dsdt;
 	fadt->preferred_pm_profile = ACPI_PM_UNSPECIFIED;
 	fadt->sci_int = 9;
 	fadt->smi_cmd = 0;
@@ -74,10 +73,8 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
 	fadt->reset_reg.addrh = 0;
 	fadt->reset_value = SYS_RST | RST_CPU | FULL_RST;
 
-	fadt->x_firmware_ctl_l = (u32)ctx->facs;
-	fadt->x_firmware_ctl_h = 0;
-	fadt->x_dsdt_l = (u32)ctx->dsdt;
-	fadt->x_dsdt_h = 0;
+	fadt->x_firmware_ctrl = map_to_sysmem(ctx->facs);
+	fadt->x_dsdt = map_to_sysmem(ctx->dsdt);
 
 	fadt->x_pm1a_evt_blk.space_id = ACPI_ADDRESS_SPACE_IO;
 	fadt->x_pm1a_evt_blk.bit_width = fadt->pm1_evt_len * 8;
diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
index 1c667c7d56..1d37cc9e2b 100644
--- a/arch/x86/cpu/tangier/acpi.c
+++ b/arch/x86/cpu/tangier/acpi.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <cpu.h>
 #include <dm.h>
+#include <mapmem.h>
 #include <acpi/acpi_table.h>
 #include <asm/ioapic.h>
 #include <asm/mpspec.h>
@@ -31,8 +32,6 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
 	header->length = sizeof(struct acpi_fadt);
 	header->revision = 6;
 
-	fadt->firmware_ctrl = (u32)ctx->facs;
-	fadt->dsdt = (u32)ctx->dsdt;
 	fadt->preferred_pm_profile = ACPI_PM_UNSPECIFIED;
 
 	fadt->iapc_boot_arch = ACPI_FADT_VGA_NOT_PRESENT |
@@ -45,10 +44,8 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
 
 	fadt->minor_revision = 2;
 
-	fadt->x_firmware_ctl_l = (u32)ctx->facs;
-	fadt->x_firmware_ctl_h = 0;
-	fadt->x_dsdt_l = (u32)ctx->dsdt;
-	fadt->x_dsdt_h = 0;
+	fadt->x_firmware_ctrl = map_to_sysmem(ctx->facs);
+	fadt->x_dsdt = map_to_sysmem(ctx->dsdt);
 
 	header->checksum = table_compute_checksum(fadt, header->length);
 
diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index c5b33dc65d..ef738c02a6 100644
--- a/arch/x86/lib/acpi_table.c
+++ b/arch/x86/lib/acpi_table.c
@@ -572,13 +572,8 @@ void acpi_fadt_common(struct acpi_fadt *fadt, struct acpi_facs *facs,
 	memcpy(header->aslc_id, ASLC_ID, 4);
 	header->aslc_revision = 1;
 
-	fadt->firmware_ctrl = (unsigned long)facs;
-	fadt->dsdt = (unsigned long)dsdt;
-
-	fadt->x_firmware_ctl_l = (unsigned long)facs;
-	fadt->x_firmware_ctl_h = 0;
-	fadt->x_dsdt_l = (unsigned long)dsdt;
-	fadt->x_dsdt_h = 0;
+	fadt->x_firmware_ctrl = map_to_sysmem(facs);
+	fadt->x_dsdt = map_to_sysmem(dsdt);
 
 	fadt->preferred_pm_profile = ACPI_PM_MOBILE;
 
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 20ac3b51ba..e67562ef65 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -228,10 +228,8 @@ struct __packed acpi_fadt {
 	u8 reset_value;
 	u16 arm_boot_arch;
 	u8 minor_revision;
-	u32 x_firmware_ctl_l;
-	u32 x_firmware_ctl_h;
-	u32 x_dsdt_l;
-	u32 x_dsdt_h;
+	u64 x_firmware_ctrl;
+	u64 x_dsdt;
 	struct acpi_gen_regaddr x_pm1a_evt_blk;
 	struct acpi_gen_regaddr x_pm1b_evt_blk;
 	struct acpi_gen_regaddr x_pm1a_cnt_blk;
-- 
2.40.1

