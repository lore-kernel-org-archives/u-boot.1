Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E69C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A300081F59;
	Sat, 15 Mar 2025 15:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WL3TSzNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B2EE810F4; Sat, 15 Mar 2025 15:28:54 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B382F81FAA
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso3801295e9.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048930; x=1742653730; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ITKQZf+piHJR0BdhtaXm4xV9Vg08T1s+jF46nVTD3k=;
 b=WL3TSzNCxFsS9IsgCiN4GLVKAXlCv95Gx1hgiyREqsGIKPLll00zIZ5LpxQazV3LYZ
 i/8VAtb39Eyciwhv6JC5/S/BejvNCBCc411eRqU6tG2YrMj2ew8BR4aVxKwBPWBUTQsj
 axG9J+xGzjiQgUv0lmATIE+vp4yrWjI6Clx0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048930; x=1742653730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ITKQZf+piHJR0BdhtaXm4xV9Vg08T1s+jF46nVTD3k=;
 b=SzqPILyxlA5db0xmafvOzYCOZ0t28UnladjNHOArnGqEae9nZXxyD9NJRrmqYawwxY
 eQtsyhJrEPfcaxpdqLGbKb5EVoVKyVf7c0KcNvpSn5IRJvbkx6ITCKtZRpG3IZIpCFgu
 bGGBjK+x5lptW55g48QJ9ElBKBkHGCaKNNWmqbZGe1ZsjwSwka6xgmleRA9X7KihGIE1
 SFx+xw0Wpj68S/GAKT0cMhV0dvWjMwCJ03lhdpusA6nLKRwd6F1x8WMqDG/9X2qwoXuD
 lI0gHJ/VwNlM+Y3IqvV1Goc4cTUBx573eUBlh5v1BEn7QI50eE4+zxZiJSQFYSJ50xkP
 W0mg==
X-Gm-Message-State: AOJu0YzMqxg7B7NSeh/3mlKB/G1e4gmct9H7yU8YqrPeB5vtfjdvNEzz
 8zVKR/kwVftXlIAVabmxrt/JsQsfWZB6qiceGp/HSXnfvYiW0/vcpNLqcDpd17ZIpzPKNm1C3ex
 7GA==
X-Gm-Gg: ASbGncswZkjQNA1DPFUV6Y9PcGvcAyN7voT3UjncmYll5taacAqXM1FR4en/BH5MwEd
 DftGtB6OKuBYsHg0ahavCp/R0SaWbsPHBN4Xb6+5bQvcDBkqTITG0wM136wCwXmVX9wAUlKD49s
 JAS9uhq0SZHJL7lscm0g8bWcQkXalf4SK6pluKoyVbEWvK1j510SC1nO280xGBRPvYGqBBre3Ba
 v8/DlNkz2Ik6iTv3S4B/2ePqWe9K1RWVKNsCeKog+cJdhrtwDxqEnag0gkXw70SM9bPOB6l1lwo
 EjGEj6CQcxLKRNoAhP241nB/23fK9fgbOqbf9C4REQ==
X-Google-Smtp-Source: AGHT+IGUBe65RGzZuDjgjshhOwSP44mejPrIa6i6okv6GwmvEYoufSIkBxYDatW/F8Ou9VOn9rkuMg==
X-Received: by 2002:a05:600c:4690:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-43d1ec765b7mr83997015e9.7.1742048929582; 
 Sat, 15 Mar 2025 07:28:49 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 45/46] acpi: Support checking checksums
Date: Sat, 15 Mar 2025 14:26:05 +0000
Message-ID: <20250315142643.2600605-46-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

When the ACPI tables come from an earlier bootloader it is helpful to
see whether the checksums are correct or not. Add a -c flag to the
'acpi list' command to support that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to support checking checksums with ACPI command

 cmd/acpi.c             | 57 +++++++++++++++++++++++++++---------------
 doc/usage/cmd/acpi.rst | 20 ++++++++++++++-
 test/dm/acpi.c         | 46 ++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 21 deletions(-)

diff --git a/cmd/acpi.c b/cmd/acpi.c
index 2273176f106..bb243202009 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -7,6 +7,7 @@
 #include <display_options.h>
 #include <log.h>
 #include <mapmem.h>
+#include <tables_csum.h>
 #include <acpi/acpi_table.h>
 #include <asm/acpi_table.h>
 #include <asm/global_data.h>
@@ -15,6 +16,17 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static const char *show_checksum(void *ptr, uint size, bool chksums)
+{
+	uint checksum;
+
+	if (!chksums)
+		return "";
+	checksum = table_compute_checksum(ptr, size);
+
+	return checksum ? "  bad" : "  OK";
+}
+
 /**
  * dump_hdr() - Dump an ACPI header
  *
@@ -23,16 +35,17 @@ DECLARE_GLOBAL_DATA_PTR;
  *
  * @hdr: ACPI header to dump
  */
-static void dump_hdr(struct acpi_table_header *hdr)
+static void dump_hdr(struct acpi_table_header *hdr, bool chksums)
 {
 	bool has_hdr = memcmp(hdr->signature, "FACS", ACPI_NAME_LEN);
 
 	printf("%.*s  %16lx  %5x", ACPI_NAME_LEN, hdr->signature,
 	       (ulong)map_to_sysmem(hdr), hdr->length);
 	if (has_hdr) {
-		printf("  v%02d %.6s %.8s %x %.4s %x\n", hdr->revision,
+		printf("  v%02d %.6s %.8s %x %.4s %x%s\n", hdr->revision,
 		       hdr->oem_id, hdr->oem_table_id, hdr->oem_revision,
-		       hdr->creator_id, hdr->creator_revision);
+		       hdr->creator_id, hdr->creator_revision,
+		       show_checksum(hdr, hdr->length, chksums));
 	} else {
 		printf("\n");
 	}
@@ -52,22 +65,22 @@ static int dump_table_name(const char *sig)
 	return 0;
 }
 
-static void list_fadt(struct acpi_fadt *fadt)
+static void list_fadt(struct acpi_fadt *fadt, bool chksums)
 {
 	if (fadt->header.revision >= 3 && fadt->x_dsdt)
-		dump_hdr(nomap_sysmem(fadt->x_dsdt, 0));
+		dump_hdr(nomap_sysmem(fadt->x_dsdt, 0), chksums);
 	else if (fadt->dsdt)
-		dump_hdr(nomap_sysmem(fadt->dsdt, 0));
+		dump_hdr(nomap_sysmem(fadt->dsdt, 0), chksums);
 	if (!IS_ENABLED(CONFIG_X86) && !IS_ENABLED(CONFIG_SANDBOX) &&
 	    !(fadt->flags & ACPI_FADT_HW_REDUCED_ACPI))
 		log_err("FADT not ACPI-hardware-reduced-compliant\n");
 	if (fadt->header.revision >= 3 && fadt->x_firmware_ctrl)
-		dump_hdr(nomap_sysmem(fadt->x_firmware_ctrl, 0));
+		dump_hdr(nomap_sysmem(fadt->x_firmware_ctrl, 0), chksums);
 	else if (fadt->firmware_ctrl)
-		dump_hdr(nomap_sysmem(fadt->firmware_ctrl, 0));
+		dump_hdr(nomap_sysmem(fadt->firmware_ctrl, 0), chksums);
 }
 
-static void list_rsdt(struct acpi_rsdp *rsdp)
+static void list_rsdt(struct acpi_rsdp *rsdp, bool chksums)
 {
 	int len, i, count;
 	struct acpi_rsdt *rsdt;
@@ -75,11 +88,11 @@ static void list_rsdt(struct acpi_rsdp *rsdp)
 
 	if (rsdp->rsdt_address) {
 		rsdt = nomap_sysmem(rsdp->rsdt_address, 0);
-		dump_hdr(&rsdt->header);
+		dump_hdr(&rsdt->header, chksums);
 	}
 	if (rsdp->xsdt_address) {
 		xsdt = nomap_sysmem(rsdp->xsdt_address, 0);
-		dump_hdr(&xsdt->header);
+		dump_hdr(&xsdt->header, chksums);
 		len = xsdt->header.length - sizeof(xsdt->header);
 		count = len / sizeof(u64);
 	} else if (rsdp->rsdt_address) {
@@ -100,24 +113,28 @@ static void list_rsdt(struct acpi_rsdp *rsdp)
 		if (!entry)
 			break;
 		hdr = nomap_sysmem(entry, 0);
-		dump_hdr(hdr);
+		dump_hdr(hdr, chksums);
 		if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN))
-			list_fadt((struct acpi_fadt *)hdr);
+			list_fadt((struct acpi_fadt *)hdr, chksums);
 	}
 }
 
-static void list_rsdp(struct acpi_rsdp *rsdp)
+static void list_rsdp(struct acpi_rsdp *rsdp, bool chksums)
 {
-	printf("RSDP  %16lx  %5x  v%02d %.6s\n", (ulong)map_to_sysmem(rsdp),
-	       rsdp->length, rsdp->revision, rsdp->oem_id);
-	list_rsdt(rsdp);
+	printf("RSDP  %16lx  %5x  v%02d %.6s%s%s\n",
+	       (ulong)map_to_sysmem(rsdp), rsdp->length, rsdp->revision,
+	       rsdp->oem_id, show_checksum(rsdp, 0x14, chksums),
+	       show_checksum(rsdp, rsdp->length, chksums));
+	list_rsdt(rsdp, chksums);
 }
 
 static int do_acpi_list(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
 	struct acpi_rsdp *rsdp;
+	bool chksums;
 
+	chksums = argc >= 2 && !strcmp("-c", argv[1]);
 	rsdp = map_sysmem(gd_acpi_start(), 0);
 	if (!rsdp) {
 		printf("No ACPI tables present\n");
@@ -125,7 +142,7 @@ static int do_acpi_list(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 	printf("Name              Base   Size  Detail\n"
 	       "----  ----------------  -----  ----------------------------\n");
-	list_rsdp(rsdp);
+	list_rsdp(rsdp, chksums);
 
 	return 0;
 }
@@ -187,13 +204,13 @@ static int do_acpi_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 U_BOOT_LONGHELP(acpi,
-	"list  - list ACPI tables\n"
+	"list [-c] - list ACPI tables [check checksums]\n"
 	"acpi items [-d]   - List/dump each piece of ACPI data from devices\n"
 	"acpi set [<addr>] - Set or show address of ACPI tables\n"
 	"acpi dump <name>  - Dump ACPI table");
 
 U_BOOT_CMD_WITH_SUBCMDS(acpi, "ACPI tables", acpi_help_text,
-	U_BOOT_SUBCMD_MKENT(list, 1, 1, do_acpi_list),
+	U_BOOT_SUBCMD_MKENT(list, 2, 1, do_acpi_list),
 	U_BOOT_SUBCMD_MKENT(items, 2, 1, do_acpi_items),
 	U_BOOT_SUBCMD_MKENT(set, 2, 1, do_acpi_set),
 	U_BOOT_SUBCMD_MKENT(dump, 2, 1, do_acpi_dump));
diff --git a/doc/usage/cmd/acpi.rst b/doc/usage/cmd/acpi.rst
index 9f30972fe53..e652968d584 100644
--- a/doc/usage/cmd/acpi.rst
+++ b/doc/usage/cmd/acpi.rst
@@ -11,7 +11,7 @@ Synopsis
 
 ::
 
-    acpi list
+    acpi list [-c]
     acpi items [-d]
     acpi dump <name>
     acpi set <address>
@@ -38,6 +38,9 @@ List the ACPI tables that have been generated. Each table has a 4-character
 table name (e.g. SSDT, FACS) and has a format defined by the
 `ACPI specification`_.
 
+The `-c` flag tells U-Boot to verify the checksums and print 'OK' or 'BAD' next
+to each table.
+
 U-Boot does not currently support decoding the tables. Unlike devicetree, ACPI
 tables have no regular schema and also some include bytecode, so decoding the
 tables requires a lot of code.
@@ -259,5 +262,20 @@ pointer::
     WAET  bff76a3b     28  v01 BOCHS  BXPC     1 BXPC 1
     SSDT  bff95040     c5  v02 COREv4 COREBOOT 2a CORE 20221020
 
+This shows checking that the checksums are correct for each table::
+
+    => acpi list -c
+    Name              Base   Size  Detail
+    ----  ----------------  -----  ----------------------------
+    RSDP          bec9a000     24  v00 BOCHS   OK OK
+    RSDT          bec9bd4a     38  v01 BOCHS  BXPC     1 BXPC 1  OK
+    FACP          bec9bb46     74  v01 BOCHS  BXPC     1 BXPC 1  OK
+    DSDT          bec9a080   1ac6  v01 BOCHS  BXPC     1 BXPC 1  OK
+    FACS          bec9a040     40
+    APIC          bec9bbba     78  v03 BOCHS  BXPC     1 BXPC 1  OK
+    HPET          bec9bc32     38  v01 BOCHS  BXPC     1 BXPC 1  OK
+    SRAT          bec9bc6a     b8  v01 BOCHS  BXPC     1 BXPC 1  OK
+    WAET          bec9bd22     28  v01 BOCHS  BXPC     1 BXPC 1  OK
+
 
 .. _`ACPI specification`: https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index f98f9d1e74b..db012b6d2f1 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -439,6 +439,52 @@ static int dm_test_acpi_cmd_list(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_acpi_cmd_list, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
 
+/* Test 'acpi list -c' command */
+static int dm_test_acpi_cmd_list_chksum(struct unit_test_state *uts)
+{
+	struct acpi_ctx ctx;
+	ulong addr;
+	void *buf;
+
+	buf = memalign(16, BUF_SIZE);
+	ut_assertnonnull(buf);
+	addr = map_to_sysmem(buf);
+	ut_assertok(setup_ctx_and_base_tables(uts, &ctx, addr));
+
+	ut_assertok(acpi_write_dev_tables(&ctx));
+
+	run_command("acpi list -c", 0);
+	ut_assert_nextline("Name              Base   Size  Detail");
+	ut_assert_nextline("----  ----------------  -----  ----------------------------");
+	ut_assert_nextline("RSDP  %16lx  %5zx  v02 U-BOOT  OK  OK", addr,
+			   sizeof(struct acpi_rsdp));
+	addr = ALIGN(addr + sizeof(struct acpi_rsdp), 16);
+	ut_assert_nextline("RSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  OK",
+			   addr, sizeof(struct acpi_table_header) +
+			   3 * sizeof(u32), OEM_REVISION);
+	addr = ALIGN(addr + sizeof(struct acpi_rsdt), 16);
+	ut_assert_nextline("XSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  OK",
+			   addr, sizeof(struct acpi_table_header) +
+			   3 * sizeof(u64), OEM_REVISION);
+	addr = ALIGN(addr + sizeof(struct acpi_xsdt), 64);
+	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  OK",
+			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
+	addr = ALIGN(addr + sizeof(struct acpi_dmar), 16);
+	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  OK",
+			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
+	addr = ALIGN(addr + sizeof(struct acpi_dmar), 16);
+	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  OK",
+			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
+	ut_assert_console_end();
+	ut_assert_console_end();
+	unmap_sysmem(buf);
+	free(buf);
+
+	return 0;
+}
+DM_TEST(dm_test_acpi_cmd_list_chksum,
+	UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
+
 /* Test 'acpi dump' command */
 static int dm_test_acpi_cmd_dump(struct unit_test_state *uts)
 {
-- 
2.43.0

