Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775DAC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 16:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F91887C23;
	Fri, 15 Dec 2023 17:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nG88sKjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1727787BEC; Fri, 15 Dec 2023 17:40:26 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D8A287C09
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 17:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6C95B400F2; 
 Fri, 15 Dec 2023 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702658423;
 bh=ZKd4/nfDCTzYvX6ZlClFI/3IPJ+FxqGuZfsLKIvdK8o=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=nG88sKjF2dBhYErcpYuk/Q1kpOmrNAf0bzuqirz9vDhqEjNEDHKgsZYnJWJqSloDn
 rY6SesRXqGDv0InBGBxcs0BKyjrBj71cCmN+vyXfYZQwVLMneragqwq50FTCUKzyQO
 LbvH82jgX3I0fGpIwGyVAWyEI4wYUhgWgQr4tft778XlqTupiKZ/nxLwWmKE4YpF7z
 dpjF9IisVhjc7yowtkxvC2bqO4yu9Ryv7lUVKqKzv9Y6uCqVSWoJIVqIFUA4VSHvWC
 zZDNQ3MmRYEozmiYD0aomc9sE98ioubdiLLgi11hHoM1+LMqkMllwiG18K4PPQNpow
 PO3jsIpsW3dig==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] acpi: fix FADT table
Date: Fri, 15 Dec 2023 17:40:14 +0100
Message-Id: <20231215164016.137794-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215164016.137794-1-heinrich.schuchardt@canonical.com>
References: <20231215164016.137794-1-heinrich.schuchardt@canonical.com>
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/x86/cpu/baytrail/acpi.c | 8 ++------
 arch/x86/cpu/quark/acpi.c    | 8 ++------
 arch/x86/cpu/tangier/acpi.c  | 8 ++------
 arch/x86/lib/acpi_table.c    | 9 ++-------
 include/acpi/acpi_table.h    | 6 ++----
 5 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/arch/x86/cpu/baytrail/acpi.c b/arch/x86/cpu/baytrail/acpi.c
index 4378846f8b..5c28c4d260 100644
--- a/arch/x86/cpu/baytrail/acpi.c
+++ b/arch/x86/cpu/baytrail/acpi.c
@@ -31,8 +31,6 @@ static int baytrail_write_fadt(struct acpi_ctx *ctx,
 	header->length = sizeof(struct acpi_fadt);
 	header->revision = 4;
 
-	fadt->firmware_ctrl = (u32)ctx->facs;
-	fadt->dsdt = (u32)ctx->dsdt;
 	fadt->preferred_pm_profile = ACPI_PM_MOBILE;
 	fadt->sci_int = 9;
 	fadt->smi_cmd = 0;
@@ -79,10 +77,8 @@ static int baytrail_write_fadt(struct acpi_ctx *ctx,
 	fadt->reset_reg.addrh = 0;
 	fadt->reset_value = SYS_RST | RST_CPU | FULL_RST;
 
-	fadt->x_firmware_ctl_l = (u32)ctx->facs;
-	fadt->x_firmware_ctl_h = 0;
-	fadt->x_dsdt_l = (u32)ctx->dsdt;
-	fadt->x_dsdt_h = 0;
+	fadt->x_firmware_ctrl = (uintptr_t)ctx->facs;
+	fadt->x_dsdt = (uintptr_t)ctx->dsdt;
 
 	fadt->x_pm1a_evt_blk.space_id = ACPI_ADDRESS_SPACE_IO;
 	fadt->x_pm1a_evt_blk.bit_width = fadt->pm1_evt_len * 8;
diff --git a/arch/x86/cpu/quark/acpi.c b/arch/x86/cpu/quark/acpi.c
index 9a2d682451..583d4583c0 100644
--- a/arch/x86/cpu/quark/acpi.c
+++ b/arch/x86/cpu/quark/acpi.c
@@ -26,8 +26,6 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
 	header->length = sizeof(struct acpi_fadt);
 	header->revision = 4;
 
-	fadt->firmware_ctrl = (u32)ctx->facs;
-	fadt->dsdt = (u32)ctx->dsdt;
 	fadt->preferred_pm_profile = ACPI_PM_UNSPECIFIED;
 	fadt->sci_int = 9;
 	fadt->smi_cmd = 0;
@@ -74,10 +72,8 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
 	fadt->reset_reg.addrh = 0;
 	fadt->reset_value = SYS_RST | RST_CPU | FULL_RST;
 
-	fadt->x_firmware_ctl_l = (u32)ctx->facs;
-	fadt->x_firmware_ctl_h = 0;
-	fadt->x_dsdt_l = (u32)ctx->dsdt;
-	fadt->x_dsdt_h = 0;
+	fadt->x_firmware_ctrl = (uintptr_t)ctx->facs;
+	fadt->x_dsdt = (uintptr_t)ctx->dsdt;
 
 	fadt->x_pm1a_evt_blk.space_id = ACPI_ADDRESS_SPACE_IO;
 	fadt->x_pm1a_evt_blk.bit_width = fadt->pm1_evt_len * 8;
diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
index 1c667c7d56..19ec6e3390 100644
--- a/arch/x86/cpu/tangier/acpi.c
+++ b/arch/x86/cpu/tangier/acpi.c
@@ -31,8 +31,6 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
 	header->length = sizeof(struct acpi_fadt);
 	header->revision = 6;
 
-	fadt->firmware_ctrl = (u32)ctx->facs;
-	fadt->dsdt = (u32)ctx->dsdt;
 	fadt->preferred_pm_profile = ACPI_PM_UNSPECIFIED;
 
 	fadt->iapc_boot_arch = ACPI_FADT_VGA_NOT_PRESENT |
@@ -45,10 +43,8 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
 
 	fadt->minor_revision = 2;
 
-	fadt->x_firmware_ctl_l = (u32)ctx->facs;
-	fadt->x_firmware_ctl_h = 0;
-	fadt->x_dsdt_l = (u32)ctx->dsdt;
-	fadt->x_dsdt_h = 0;
+	fadt->x_firmware_ctrl = (uintptr_t)ctx->facs;
+	fadt->x_dsdt = (uintptr_t)ctx->dsdt;
 
 	header->checksum = table_compute_checksum(fadt, header->length);
 
diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index c5b33dc65d..f49b6933ab 100644
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
+	fadt->x_firmware_ctrl = (uintptr_t)facs;
+	fadt->x_dsdt = (uintptr_t)dsdt;
 
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

