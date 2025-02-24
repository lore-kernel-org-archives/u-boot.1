Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A575BC021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99366814A4;
	Tue, 25 Feb 2025 00:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gscdK0SX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 794DB81428; Tue, 25 Feb 2025 00:08:31 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA2C812BE
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-852050432a8so141104139f.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438507; x=1741043307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/LUqR/dnzPUJdP12IgAXd1FnUUGncyu3kp2TSD39r0=;
 b=gscdK0SXb4J9Jtlg3aDyjm5AN8tcu5R8WfvM0/TtbroAQmIrDYuPsYt1VoOZozDFK0
 sko8sFkaZOj73qXk1qNmL7KwyBuG7/QWDS4fjqGRhj9wvJzThwinCuy+QmUyPM223e/9
 PPEtm+KPpz6EejkKyGK3UvK56x6CDk/mOj0p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438507; x=1741043307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/LUqR/dnzPUJdP12IgAXd1FnUUGncyu3kp2TSD39r0=;
 b=YKnoP8xCJsJI3dd7vFZ89kNuCrdrvap0VxkQeuZNABkDMI0St5FJbmtJCnMRFpFDSF
 18xT4HriZ9IWC2T6EOtvzECgSnieoOlWIwBsC++EYrtZf/fqdJDtWkwOYmw9qOa4AKwT
 Hc+m0btDlHHvqX3eEpvvNju9FipwBXLUXmDUtItJmzqy57ZuoH3jhkwl6fKQRv79fbeH
 t2qKmUGnCM32VOCJtUUVsWNpKnDH7T3sDuVF2MATsCQ7mTZStdChIdzXrM4DbHXSNsvv
 iPTWa87RO6bhGTjOVMa5ML6RoN195a5tBYM+GJAXdwLlIDGQwGghXfrdBFyKSE5DHGkI
 alRw==
X-Gm-Message-State: AOJu0YzskQGsryAulP0Pez0EVuekMPeQQaCQRR1Fcurfc6F2H7TZfnGA
 FWbkfGVC1G7+LQ2CgTMJG0E4C4EWAGDaMfHR8YaYLQILOT2NlhTLru/rYaoOIAWg5BE3AJLxMuY
 =
X-Gm-Gg: ASbGncuW2jj6TiA+GkC0U5PHz4eqV8gA4yZlv3Pt2sgp9YZtxo8FCZYpXeSaBmJL0tS
 RNdW5cgv97IecKAlHlWgi5tpJQrF56QEDwN+SWqzSKkyXXLMM49IK0DpLI5Qci+GbPsTYLdjYU1
 mjlBm2guq1rxgR2Cv/WwgfhHv8+/T7m0KrwSmaaQsOkpuVdPIv3lhai5xUivSSIYJJUIuo4PKZL
 U7w0MaYUQpOosTljJbzmy2oKvl23JzPkF3eU/cRifdNxfQb8y6/oOT435uyOT80/NNJKdeysgxZ
 LmO3AvGxcA8DVtya1zRp6y/Mc1CfKopNX7GOAvLi7nBpujzgOAsqk+6Hf0AnLbo=
X-Google-Smtp-Source: AGHT+IFIFSB185swtKk12GWTZeM0rrLvW7PLxRSsXSVeGOoxDNWeSphmeTbt+JFjzcdi+XIqMxCwIg==
X-Received: by 2002:a6b:610d:0:b0:855:a80f:9cfb with SMTP id
 ca18e2360f4ac-855c31caab5mr1689018339f.2.1740438506730; 
 Mon, 24 Feb 2025 15:08:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 42/44] acpi: Support checking checksums
Date: Mon, 24 Feb 2025 16:06:31 -0700
Message-ID: <20250224230640.2665206-43-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

