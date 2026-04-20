Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F708F5A8BC
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFDDC844E7;
	Tue, 21 Apr 2026 00:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="St5oKQxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 327FE84496; Tue, 21 Apr 2026 00:08:10 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1526D844EB
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 96ED940A2D; 
 Mon, 20 Apr 2026 22:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776722886;
 bh=edDvIAaoqdGpD3dtk6qcSzrrhdVXUPgpKOlUsuaTObo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=St5oKQxoPQyf+vABzhRPYVeQP7ECXoPoSpcd7WsyZEwIQSzDv5EebMcuIMF7UJIRd
 ouYbgV0+tC7hcSwIxkdwjaMh4+SEj8odikSaIIivfqjqXsiidbBnmnLQmfHar9cWrN
 FO4KiLlv3itXMpEJx2DoLm5vD1kxDfle+A5m7JNVc3IlJ5OLGbcXZ4Ssj2fjFgQr6Z
 Ga+kbjmoLmMYrtTFJx5f2FEQnz0++8S+xhLAZcdm5fWuMhYBTuIvGpRhZH95gm5mRZ
 3RllY2Od0vtd6gWsXP4RfsMtNQlq0icmdGcI/i0ZaR23myLhss/J6XZuow33zALsaA
 ERBSBez6CjuK/imLrdw01ZRftGxWcs5eP7RDmJJ7LCV0VB5e9g3BcnXODTiiIeLvKy
 ndLEmUyLRW6es6I2Fjp1ofIbIeWsu/XzC5AX5HsM5ehlng+utG86jQK+wDhYdpCJzo
 XeMcruXBvaZATFD6Ez/J+euHvqVOJdGT3x2U1FN3aZ9IyT4RWtU2Tq6lVhuWgza3p5
 tfZUvN6GTqSugdfegq2HTMKKS57YoMCW8e7AcXIg0hBdQkJmbbOjFZFH/NLaZP6dax
 G7QPP/sdIYfYMdcI+BOZkvmG+8bGp6+vEWm4zBWRbAz0z5Nx9frT3KtQ2VT01xU1gZ
 iqszoBsOyyM2is2JpCXv/N0k=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/4] acpi: add index parameter to acpi_find_table
Date: Tue, 21 Apr 2026 00:08:01 +0200
Message-ID: <20260420220804.71564-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420220804.71564-1-heinrich.schuchardt@canonical.com>
References: <20260420220804.71564-1-heinrich.schuchardt@canonical.com>
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

ACPI tables like SSDT may have multiple indexs.

Add an index parameter to acpi_find_table() to allow finding the n-th
instance of an ACPI table with the same signature.

Update all callers to pass index 1.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/acpi.c                       |  2 +-
 drivers/serial/serial_coreboot.c |  2 +-
 include/acpi/acpi_table.h        |  3 ++-
 lib/acpi/acpi.c                  | 21 ++++++++++++++++-----
 test/dm/acpi.c                   | 18 +++++++++---------
 5 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/cmd/acpi.c b/cmd/acpi.c
index bb243202009..a88cd995460 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -55,7 +55,7 @@ static int dump_table_name(const char *sig)
 {
 	struct acpi_table_header *hdr;
 
-	hdr = acpi_find_table(sig);
+	hdr = acpi_find_table(sig, 0);
 	if (!hdr)
 		return -ENOENT;
 	printf("%.*s @ %16lx\n", ACPI_NAME_LEN, hdr->signature,
diff --git a/drivers/serial/serial_coreboot.c b/drivers/serial/serial_coreboot.c
index b1f69f6998c..e41430a8cd7 100644
--- a/drivers/serial/serial_coreboot.c
+++ b/drivers/serial/serial_coreboot.c
@@ -30,7 +30,7 @@ static int read_dbg2(struct ns16550_plat *plat)
 		return -ENOENT;
 	}
 
-	tab = acpi_find_table("DBG2");
+	tab = acpi_find_table("DBG2", 0);
 	if (!tab) {
 		log_debug("No DBG2 table\n");
 		return -ENOENT;
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 4895366a618..1c5aba9c54d 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -1284,9 +1284,10 @@ ulong write_acpi_tables(ulong start);
  * acpi_find_table() - Look up an ACPI table
  *
  * @sig: Signature of table (4 characters, upper case)
+ * @index: 1-based index number to find
  * Return: pointer to table header, or NULL if not found
  */
-struct acpi_table_header *acpi_find_table(const char *sig);
+struct acpi_table_header *acpi_find_table(const char *sig, ulong index);
 
 /**
  * acpi_update_checksum() - update ACPI table checksum
diff --git a/lib/acpi/acpi.c b/lib/acpi/acpi.c
index 596301a43fe..0cc492b1569 100644
--- a/lib/acpi/acpi.c
+++ b/lib/acpi/acpi.c
@@ -18,7 +18,7 @@ void acpi_update_checksum(struct acpi_table_header *header)
 	header->checksum = table_compute_checksum(header, header->length);
 }
 
-struct acpi_table_header *acpi_find_table(const char *sig)
+struct acpi_table_header *acpi_find_table(const char *sig, ulong index)
 {
 	struct acpi_rsdp *rsdp;
 	struct acpi_rsdt *rsdt;
@@ -46,8 +46,11 @@ struct acpi_table_header *acpi_find_table(const char *sig)
 			hdr = nomap_sysmem(xsdt->entry[i], 0);
 		else
 			hdr = nomap_sysmem(rsdt->entry[i], 0);
-		if (!memcmp(hdr->signature, sig, ACPI_NAME_LEN))
-			return hdr;
+		if (!memcmp(hdr->signature, sig, ACPI_NAME_LEN)) {
+			if (!index)
+				return hdr;
+			--index;
+		}
 		if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN)) {
 			struct acpi_fadt *fadt = (struct acpi_fadt *)hdr;
 
@@ -60,7 +63,11 @@ struct acpi_table_header *acpi_find_table(const char *sig)
 					dsdt = nomap_sysmem(fadt->dsdt, 0);
 				else
 					dsdt = NULL;
-				return dsdt;
+				if (dsdt) {
+					if (!index)
+						return dsdt;
+					--index;
+				}
 			}
 
 			if (!memcmp(sig, "FACS", ACPI_NAME_LEN)) {
@@ -73,7 +80,11 @@ struct acpi_table_header *acpi_find_table(const char *sig)
 					facs = nomap_sysmem(fadt->firmware_ctrl, 0);
 				else
 					facs = NULL;
-				return facs;
+				if (facs) {
+					if (!index)
+						return facs;
+					--index;
+				}
 			}
 		}
 	}
diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index 559ea269de2..8bec09f4e44 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -809,33 +809,33 @@ static int dm_test_acpi_find_table(struct unit_test_state *uts)
 	ut_assert(xsdt);
 
 	/* Find with both RSDT and XSDT */
-	table = acpi_find_table("TST1");
+	table = acpi_find_table("TST1", 0);
 	ut_asserteq_ptr(table1, table);
 	ut_asserteq_strn("TST1", table->signature);
-	table = acpi_find_table("TST2");
+	table = acpi_find_table("TST2", 0);
 	ut_asserteq_ptr(table2, table);
 	ut_asserteq_strn("TST2", table->signature);
-	table = acpi_find_table("TST3");
+	table = acpi_find_table("TST3", 0);
 	ut_asserteq_ptr(table3, table);
 	ut_asserteq_strn("TST3", table->signature);
 
 	/* Find with XSDT only */
 	rsdp->rsdt_address = 0;
-	table = acpi_find_table("TST1");
+	table = acpi_find_table("TST1", 0);
 	ut_asserteq_ptr(table1, table);
-	table = acpi_find_table("TST2");
+	table = acpi_find_table("TST2", 0);
 	ut_asserteq_ptr(table2, table);
-	table = acpi_find_table("TST3");
+	table = acpi_find_table("TST3", 0);
 	ut_asserteq_ptr(table3, table);
 	rsdp->rsdt_address = rsdt;
 
 	/* Find with RSDT only */
 	rsdp->xsdt_address = 0;
-	table = acpi_find_table("TST1");
+	table = acpi_find_table("TST1", 0);
 	ut_asserteq_ptr(table1, table);
-	table = acpi_find_table("TST2");
+	table = acpi_find_table("TST2", 0);
 	ut_asserteq_ptr(table2, table);
-	table = acpi_find_table("TST3");
+	table = acpi_find_table("TST3", 0);
 	ut_asserteq_ptr(table3, table);
 	rsdp->xsdt_address = xsdt;
 
-- 
2.53.0

