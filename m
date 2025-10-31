Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F79CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 19:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2690583ACD;
	Fri, 31 Oct 2025 20:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nlvk7SYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F383783AD1; Fri, 31 Oct 2025 20:53:00 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7986C83AC5
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 20:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9F37D3FB67; 
 Fri, 31 Oct 2025 19:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761940377;
 bh=SF1J8ji5f2YvegcMQjol2G6jewgMiy9ZRcF5PrQmLuY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=nlvk7SYCurHC1/Okx6zGw/vvG9eGG+o/X/waU4CnhX691MvBiO7Dj92hcqOaTR8rU
 JAmCyq+g8TJGT5BqnKNtECcgKKulGAk8i3m+Qj2rodGAks3X4Q1LDUusxwJXgD7Y+Y
 7Jd7mpNABuif0EF62Za6ByLdPr2H2gRaJF/wX8YXQeKp+o5eIPniV3Fw/ofUL3w3qn
 +k2SripArL1UbA3jsFvWQbkQn9DpY2MEB44p0o7VjqWRTZWDyuG68GDmNDQ2rzvsPh
 bsFCBZPim5RP86kIVuupuKd247NHrZecay9QBHCJ7pxpqcMQ05ZF/xbAkK3v45+yD5
 mV9IHMa0JOeUNfGBB680qRHQIPsRHLsoLyhy88cKtZPbgbM4stsLorN/WA2TwmY09p
 kvm8sWGv4HQrjoG2aOgFftMwcR/LSqDm0LPbabjDnN4mv8movZXphPoHI9EbeekUKl
 IYMseJ61hAbjsz62peJjIeEkIS1vtF/6BFPkog7lqC02DJtiQohwMFLUKqTWxpkyyO
 uJB7mD25G7ZVEQ3KQciePi2Mm/EGyDtIrt8kdQLngOb+6JZttRrGVQ4QivCCmx60Ww
 BVLB8beGcJoYDOK01l5hP1RTGBwT9RZ0iPqDdso7AQ4VVKOp0NijD4grpBaebK36cz
 7hok49zTjj9KxsCBoUYEa1+E=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] acpi: use U-Boot ACPI vendor ID
Date: Fri, 31 Oct 2025 20:52:53 +0100
Message-ID: <20251031195253.621971-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

The U-Boot project has been assigned the vendor ID 'UBOO' [1]. Use this
vendor ID and our release version in the ACPI table headers.

[1] ACPI ID Registry
    https://uefi.org/ACPI_ID_List

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/x86/lib/acpi_nhlt.c  |  2 +-
 arch/x86/lib/acpi_table.c |  2 +-
 include/acpi/acpi_table.h | 20 +++++++++++---
 lib/acpi/acpi_table.c     |  6 ++---
 test/dm/acpi.c            | 55 +++++++++++++++++++++++----------------
 5 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/arch/x86/lib/acpi_nhlt.c b/arch/x86/lib/acpi_nhlt.c
index 8aae5fa5af7..4ffce589d7a 100644
--- a/arch/x86/lib/acpi_nhlt.c
+++ b/arch/x86/lib/acpi_nhlt.c
@@ -408,7 +408,7 @@ int nhlt_serialise_oem_overrides(struct acpi_ctx *ctx, struct nhlt *nhlt,
 		memcpy(header->oem_table_id, oem_table_id, oem_table_id_len);
 	}
 	header->oem_revision = oem_revision;
-	memcpy(header->creator_id, ASLC_ID, 4);
+	memcpy(header->creator_id, ACPI_CREATOR_ID, 4);
 
 	cur.buf = (void *)(header + 1);
 	cur.start = (void *)header;
diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index b13292c4150..6bd7ad799bf 100644
--- a/arch/x86/lib/acpi_table.c
+++ b/arch/x86/lib/acpi_table.c
@@ -224,7 +224,7 @@ static int acpi_write_tpm2(struct acpi_ctx *ctx,
 
 	/* Fill out header fields. */
 	acpi_fill_header(header, "TPM2");
-	memcpy(header->creator_id, ASLC_ID, 4);
+	memcpy(header->creator_id, ACPI_CREATOR_ID, 4);
 
 	header->length = sizeof(struct acpi_tpm2);
 	header->revision = acpi_get_table_revision(ACPITAB_TPM2);
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 05b6385544e..4895366a618 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -13,15 +13,29 @@
 #ifndef __ACPI_TABLE_H__
 #define __ACPI_TABLE_H__
 
+#include <version.h>
 #include <dm/acpi.h>
 
 #define RSDP_SIG		"RSD PTR "	/* RSDP pointer signature */
 #define OEM_ID			"U-BOOT"	/* U-Boot */
 #define OEM_TABLE_ID		"U-BOOTBL"	/* U-Boot Table */
-#define ASLC_ID			"INTL"		/* Intel ASL Compiler */
 
-/* TODO(sjg@chromium.org): Figure out how to get compiler revision */
-#define ASL_REVISION	0
+/**
+ * define ACPI_CREATOR_ID - ACPI creator ID
+ *
+ * This is the ACPI assigned vendor ID for the U-Boot project.
+ * It is used in the ACPI tables created by U-Boot.
+ */
+#define ACPI_CREATOR_ID		"UBOO"
+
+/**
+ * define ACPI_CREATOR_REVISION - ACPI creator ID
+ *
+ * This encodes the U-Boot version.
+ * It is used in the ACPI tables created by U-Boot.
+ */
+#define ACPI_CREATOR_REVISION \
+	(U_BOOT_VERSION_NUM << 4 | U_BOOT_VERSION_NUM_PATCH)
 
 #define ACPI_RSDP_REV_ACPI_1_0	0
 #define ACPI_RSDP_REV_ACPI_2_0	2
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 43b71182133..52b05efd62d 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -134,8 +134,8 @@ void acpi_fill_header(struct acpi_table_header *header, char *signature)
 	memcpy(header->oem_id, OEM_ID, 6);
 	memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
 	header->oem_revision = OEM_REVISION;
-	memcpy(header->creator_id, ASLC_ID, 4);
-	header->creator_revision = ASL_REVISION;
+	memcpy(header->creator_id, ACPI_CREATOR_ID, 4);
+	header->creator_revision = ACPI_CREATOR_REVISION;
 }
 
 void acpi_align(struct acpi_ctx *ctx)
@@ -248,7 +248,7 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	header->revision = acpi_get_table_revision(ACPITAB_FADT);
 	memcpy(header->oem_id, OEM_ID, 6);
 	memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
-	memcpy(header->creator_id, ASLC_ID, 4);
+	memcpy(header->creator_id, ACPI_CREATOR_ID, 4);
 	header->creator_revision = 1;
 	fadt->minor_revision = 2;
 
diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index db012b6d2f1..559ea269de2 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -261,8 +261,8 @@ static int dm_test_acpi_fill_header(struct unit_test_state *uts)
 	ut_asserteq_mem(OEM_TABLE_ID, hdr.oem_table_id,
 			sizeof(hdr.oem_table_id));
 	ut_asserteq(OEM_REVISION, hdr.oem_revision);
-	ut_asserteq_mem(ASLC_ID, hdr.creator_id, sizeof(hdr.creator_id));
-	ut_asserteq(ASL_REVISION, hdr.creator_revision);
+	ut_asserteq_mem(ACPI_CREATOR_ID, hdr.creator_id, sizeof(hdr.creator_id));
+	ut_asserteq(ACPI_CREATOR_REVISION, hdr.creator_revision);
 
 	return 0;
 }
@@ -415,22 +415,27 @@ static int dm_test_acpi_cmd_list(struct unit_test_state *uts)
 	ut_assert_nextline("RSDP  %16lx  %5zx  v02 U-BOOT", addr,
 			   sizeof(struct acpi_rsdp));
 	addr = ALIGN(addr + sizeof(struct acpi_rsdp), 16);
-	ut_assert_nextline("RSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
+	ut_assert_nextline("RSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x UBOO %x",
 			   addr, sizeof(struct acpi_table_header) +
-			   3 * sizeof(u32), OEM_REVISION);
+			   3 * sizeof(u32), OEM_REVISION,
+			   ACPI_CREATOR_REVISION);
 	addr = ALIGN(addr + sizeof(struct acpi_rsdt), 16);
-	ut_assert_nextline("XSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
+	ut_assert_nextline("XSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x UBOO %x",
 			   addr, sizeof(struct acpi_table_header) +
-			   3 * sizeof(u64), OEM_REVISION);
+			   3 * sizeof(u64), OEM_REVISION,
+			   ACPI_CREATOR_REVISION);
 	addr = ALIGN(addr + sizeof(struct acpi_xsdt), 64);
-	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
-			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
+	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x UBOO %x",
+			   addr, sizeof(struct acpi_dmar), OEM_REVISION,
+			   ACPI_CREATOR_REVISION);
 	addr = ALIGN(addr + sizeof(struct acpi_dmar), 16);
-	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
-			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
+	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x UBOO %x",
+			   addr, sizeof(struct acpi_dmar), OEM_REVISION,
+			   ACPI_CREATOR_REVISION);
 	addr = ALIGN(addr + sizeof(struct acpi_dmar), 16);
-	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
-			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
+	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x UBOO %x",
+			   addr, sizeof(struct acpi_dmar), OEM_REVISION,
+			   ACPI_CREATOR_REVISION);
 	ut_assert_console_end();
 	unmap_sysmem(buf);
 	free(buf);
@@ -459,23 +464,27 @@ static int dm_test_acpi_cmd_list_chksum(struct unit_test_state *uts)
 	ut_assert_nextline("RSDP  %16lx  %5zx  v02 U-BOOT  OK  OK", addr,
 			   sizeof(struct acpi_rsdp));
 	addr = ALIGN(addr + sizeof(struct acpi_rsdp), 16);
-	ut_assert_nextline("RSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  OK",
+	ut_assert_nextline("RSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x UBOO %x  OK",
 			   addr, sizeof(struct acpi_table_header) +
-			   3 * sizeof(u32), OEM_REVISION);
+			   3 * sizeof(u32), OEM_REVISION,
+			   ACPI_CREATOR_REVISION);
 	addr = ALIGN(addr + sizeof(struct acpi_rsdt), 16);
-	ut_assert_nextline("XSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  OK",
+	ut_assert_nextline("XSDT  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x UBOO %x  OK",
 			   addr, sizeof(struct acpi_table_header) +
-			   3 * sizeof(u64), OEM_REVISION);
+			   3 * sizeof(u64), OEM_REVISION,
+			   ACPI_CREATOR_REVISION);
 	addr = ALIGN(addr + sizeof(struct acpi_xsdt), 64);
-	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  OK",
-			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
+	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x UBOO %x  OK",
+			   addr, sizeof(struct acpi_dmar), OEM_REVISION,
+			   ACPI_CREATOR_REVISION);
 	addr = ALIGN(addr + sizeof(struct acpi_dmar), 16);
-	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  OK",
-			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
+	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x UBOO %x  OK",
+			   addr, sizeof(struct acpi_dmar), OEM_REVISION,
+			   ACPI_CREATOR_REVISION);
 	addr = ALIGN(addr + sizeof(struct acpi_dmar), 16);
-	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0  OK",
-			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
-	ut_assert_console_end();
+	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x UBOO %x  OK",
+			   addr, sizeof(struct acpi_dmar), OEM_REVISION,
+			   ACPI_CREATOR_REVISION);
 	ut_assert_console_end();
 	unmap_sysmem(buf);
 	free(buf);
-- 
2.51.0

