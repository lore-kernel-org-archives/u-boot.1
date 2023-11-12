Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5976BC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 07:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F1387015;
	Sun, 12 Nov 2023 08:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="a/6hrZ7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 132D28700A; Sun, 12 Nov 2023 08:03:28 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F4C86F3D
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 08:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3C98143693; 
 Sun, 12 Nov 2023 07:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699772604;
 bh=oSHhcNF9gdc/wZ0QD/kY4dw7CahjhNUALJ62yybF/LA=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=a/6hrZ7tMzxBlTaNFD4BSoHpODlgXYQWGsiG1FS8oOmX4CYY7zN5R0uHx/fCoW4eL
 Ga6bpfpEsOj4IKiolS1blyhu8fjPHXwPkfVajeBFqMkXgf/cPupZXA4bm+kqM4Qb4H
 yT7HAgAZt7vh5z710QcYEhEjAupivRki5rxECJk8fpmxYSDmxqvsha6H9mn2Wa7KCa
 JAbvkypWLDPfEa2hfmn41AGQjJRDCVM161gVHY5qt30fGwfli/jZr4F5d+Bg7QBMVK
 4OY8gtGxEQ4BjGuo/47px7o2tbiW8kQQpj+XK6JL/PewUmsQGtpho72trvhX7tb9pY
 CJHPX0MYURnag==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/2] cmd: acpi: fix acpi list command
Date: Sun, 12 Nov 2023 08:03:16 +0100
Message-Id: <20231112070316.17982-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231112070316.17982-1-heinrich.schuchardt@canonical.com>
References: <20231112070316.17982-1-heinrich.schuchardt@canonical.com>
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

ACPI tables may comprise either RSDT, XSDT, or both. The current code fails
to check the presence of the RSDT table before accessing it. This leads to
an exception if the RSDT table is not provided.

The XSDT table takes precedence over the RSDT table.

Addresses in the XSDT table are 64-bit. Adjust the output accordingly.

As the RSDT table has to be ignored if the XSDT command is present there is
no need to compare the tables in a display command. Anyway the
specification does not require that the sequence of addresses in the RSDT
and XSDT table are the same.

The FACS table header does not provide revision information. Correct the
description of dump_hdr().

Adjust the ACPI test to match the changed output format of the 'acpi list'
command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	add unit test for offset of field Entry in RSDT, XSDT
	merge patch 2 and 3
	remove leading zeros from address output
---
 cmd/acpi.c     | 48 +++++++++++++++++++++++++++++-------------------
 test/dm/acpi.c | 18 +++++++++---------
 2 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/cmd/acpi.c b/cmd/acpi.c
index 7e397d1a74..bf3fd08857 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -17,7 +17,8 @@ DECLARE_GLOBAL_DATA_PTR;
 /**
  * dump_hdr() - Dump an ACPI header
  *
- * If the header is for FACS then it shows the revision information as well
+ * Except for the Firmware ACPI Control Structure (FACS)
+ * additionally show the revision information.
  *
  * @hdr: ACPI header to dump
  */
@@ -25,7 +26,7 @@ static void dump_hdr(struct acpi_table_header *hdr)
 {
 	bool has_hdr = memcmp(hdr->signature, "FACS", ACPI_NAME_LEN);
 
-	printf("%.*s  %08lx  %5x", ACPI_NAME_LEN, hdr->signature,
+	printf("%.*s  %16lx  %5x", ACPI_NAME_LEN, hdr->signature,
 	       (ulong)map_to_sysmem(hdr), hdr->length);
 	if (has_hdr) {
 		printf("  v%02d %.6s %.8s %x %.4s %x\n", hdr->revision,
@@ -43,7 +44,7 @@ static int dump_table_name(const char *sig)
 	hdr = acpi_find_table(sig);
 	if (!hdr)
 		return -ENOENT;
-	printf("%.*s @ %08lx\n", ACPI_NAME_LEN, hdr->signature,
+	printf("%.*s @ %16lx\n", ACPI_NAME_LEN, hdr->signature,
 	       (ulong)map_to_sysmem(hdr));
 	print_buffer(0, hdr, 1, hdr->length, 0);
 
@@ -62,26 +63,34 @@ static int list_rsdt(struct acpi_rsdt *rsdt, struct acpi_xsdt *xsdt)
 {
 	int len, i, count;
 
-	dump_hdr(&rsdt->header);
-	if (xsdt)
+	if (rsdt)
+		dump_hdr(&rsdt->header);
+	if (xsdt) {
 		dump_hdr(&xsdt->header);
-	len = rsdt->header.length - sizeof(rsdt->header);
-	count = len / sizeof(u32);
+		len = xsdt->header.length - sizeof(xsdt->header);
+		count = len / sizeof(u64);
+	} else if (rsdt) {
+		len = rsdt->header.length - sizeof(rsdt->header);
+		count = len / sizeof(u32);
+	} else {
+		return 0;
+	}
+
 	for (i = 0; i < count; i++) {
 		struct acpi_table_header *hdr;
 
-		if (!rsdt->entry[i])
-			break;
-		hdr = map_sysmem(rsdt->entry[i], 0);
+		if (xsdt) {
+			if (!xsdt->entry[i])
+				break;
+			hdr = map_sysmem(xsdt->entry[i], 0);
+		} else {
+			if (!rsdt->entry[i])
+				break;
+			hdr = map_sysmem(rsdt->entry[i], 0);
+		}
 		dump_hdr(hdr);
 		if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN))
 			list_fadt((struct acpi_fadt *)hdr);
-		if (xsdt) {
-			if (xsdt->entry[i] != rsdt->entry[i]) {
-				printf("   (xsdt mismatch %llx)\n",
-				       xsdt->entry[i]);
-			}
-		}
 	}
 
 	return 0;
@@ -92,10 +101,11 @@ static int list_rsdp(struct acpi_rsdp *rsdp)
 	struct acpi_rsdt *rsdt;
 	struct acpi_xsdt *xsdt;
 
-	printf("RSDP  %08lx  %5x  v%02d %.6s\n", (ulong)map_to_sysmem(rsdp),
+	printf("RSDP  %16lx  %5x  v%02d %.6s\n", (ulong)map_to_sysmem(rsdp),
 	       rsdp->length, rsdp->revision, rsdp->oem_id);
 	rsdt = map_sysmem(rsdp->rsdt_address, 0);
 	xsdt = map_sysmem(rsdp->xsdt_address, 0);
+
 	list_rsdt(rsdt, xsdt);
 
 	return 0;
@@ -111,8 +121,8 @@ static int do_acpi_list(struct cmd_tbl *cmdtp, int flag, int argc,
 		printf("No ACPI tables present\n");
 		return 0;
 	}
-	printf("Name      Base   Size  Detail\n");
-	printf("----  --------  -----  ------\n");
+	printf("Name              Base   Size  Detail\n"
+	       "----  ----------------  -----  ----------------------------\n");
 	list_rsdp(rsdp);
 
 	return 0;
diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index 559cf1693b..89b8ef513a 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -395,26 +395,26 @@ static int dm_test_acpi_cmd_list(struct unit_test_state *uts)
 
 	console_record_reset();
 	run_command("acpi list", 0);
-	ut_assert_nextline("Name      Base   Size  Detail");
-	ut_assert_nextline("----  --------  -----  ------");
-	ut_assert_nextline("RSDP  %08lx  %5zx  v02 U-BOOT", addr,
+	ut_assert_nextline("Name              Base   Size  Detail");
+	ut_assert_nextline("----  ----------------  -----  ----------------------------");
+	ut_assert_nextline("RSDP  %16lx  %5zx  v02 U-BOOT", addr,
 			   sizeof(struct acpi_rsdp));
 	addr = ALIGN(addr + sizeof(struct acpi_rsdp), 16);
-	ut_assert_nextline("RSDT  %08lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
+	ut_assert_nextline("RSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
 			   addr, sizeof(struct acpi_table_header) +
 			   3 * sizeof(u32), OEM_REVISION);
 	addr = ALIGN(addr + sizeof(struct acpi_rsdt), 16);
-	ut_assert_nextline("XSDT  %08lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
+	ut_assert_nextline("XSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
 			   addr, sizeof(struct acpi_table_header) +
 			   3 * sizeof(u64), OEM_REVISION);
 	addr = ALIGN(addr + sizeof(struct acpi_xsdt), 64);
-	ut_assert_nextline("DMAR  %08lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
+	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
 			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
 	addr = ALIGN(addr + sizeof(struct acpi_dmar), 16);
-	ut_assert_nextline("DMAR  %08lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
+	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
 			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
 	addr = ALIGN(addr + sizeof(struct acpi_dmar), 16);
-	ut_assert_nextline("DMAR  %08lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
+	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
 			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
 	ut_assert_console_end();
 
@@ -446,7 +446,7 @@ static int dm_test_acpi_cmd_dump(struct unit_test_state *uts)
 	console_record_reset();
 	run_command("acpi dump dmar", 0);
 	addr = ALIGN(map_to_sysmem(ctx.xsdt) + sizeof(struct acpi_xsdt), 64);
-	ut_assert_nextline("DMAR @ %08lx", addr);
+	ut_assert_nextline("DMAR @ %16lx", addr);
 	ut_assert_nextlines_are_dump(0x30);
 	ut_assert_console_end();
 
-- 
2.40.1

