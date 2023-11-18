Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275B1C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF0287252;
	Sat, 18 Nov 2023 22:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="I4LfmrZf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA99186FE4; Sat, 18 Nov 2023 22:57:37 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D925D870E2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6A20A3FB4A; 
 Sat, 18 Nov 2023 21:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700344653;
 bh=abGl699mmT2HUpZFfLRBw4uFdtFJvrihYUWjl33vd+4=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=I4LfmrZfil+ib4UmmPx6im6S1fR3T11/rKYfmJ+958tTVKtbKs6LGiyBfL+9O43dm
 +t9j19Vehyjcl8dLLGLnb8JSPjni1rAov0Twb1nGTrPilmhoKHG8UW9czy2FMtUx4N
 xZc7ovphYxTq765DJlFCJ8/W0Ww4HiZ74vBj/Si8rSL1gPyF62hdInEtkKiBzM18Po
 scZ80fQrwjUO6j90VfwOm7wAAxjILJMQ1Q5Pql+hPMIoPHcp3L3W1+UjQzFpKIuceW
 CnZnUcGDVb0rXiaRwDkI3D3A4KIaV0WKyrT2QH9f83LrsVPQ7DzqpwgI8fNHxHrBUl
 TLriZoqbmx34Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/2] test: unit test for acpi_find_table()
Date: Sat, 18 Nov 2023 22:57:27 +0100
Message-Id: <20231118215727.95086-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118215727.95086-1-heinrich.schuchardt@canonical.com>
References: <20231118215727.95086-1-heinrich.schuchardt@canonical.com>
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

Provide a unit test for acpi_find_table()

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 test/dm/acpi.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index 5997bda649..58cc6c3474 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -651,3 +651,99 @@ static int dm_test_acpi_cmd_set(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_acpi_cmd_set, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+
+/**
+ * dm_test_write_test_table() - create test ACPI table
+ *
+ * Create an ACPI table TSTn, where n is given by @index.
+ *
+ * @ctx:	ACPI table writing context
+ * @index:	table index
+ * Return:	generated table
+ */
+static struct acpi_table_header
+*dm_test_write_test_table(struct acpi_ctx *ctx, int index)
+{
+	struct acpi_table_header *tbl = ctx->current;
+	char signature[5];
+
+	snprintf(signature, sizeof(signature), "TST%1d", index);
+	memset(tbl, 0, sizeof(*tbl));
+	acpi_fill_header(tbl, signature);
+	acpi_inc(ctx, sizeof(struct acpi_table_header));
+	tbl->length = (u8 *)ctx->current - (u8 *)tbl;
+	tbl->checksum = table_compute_checksum(tbl, tbl->length);
+	acpi_add_table(ctx, tbl);
+
+	return tbl;
+}
+
+/* Test acpi_find_table() */
+static int dm_test_acpi_find_table(struct unit_test_state *uts)
+{
+	struct acpi_ctx ctx;
+	ulong acpi_start, addr;
+	void *buf;
+	struct acpi_table_header *table, *table1, *table2, *table3;
+	struct acpi_rsdp *rsdp;
+	ulong rsdt;
+	ulong xsdt;
+
+	/* Keep reference to original ACPI tables */
+	acpi_start = gd_acpi_start();
+
+	/* Setup new ACPI tables */
+	buf = memalign(16, BUF_SIZE);
+	ut_assertnonnull(buf);
+	addr = map_to_sysmem(buf);
+	ut_assertok(setup_ctx_and_base_tables(uts, &ctx, addr));
+	table3 = dm_test_write_test_table(&ctx, 3);
+	table1 = dm_test_write_test_table(&ctx, 1);
+	table2 = dm_test_write_test_table(&ctx, 2);
+
+	/* Retrieve RSDP, RSDT, XSDT */
+	rsdp = map_sysmem(gd_acpi_start(), 0);
+	ut_assertnonnull(rsdp);
+	rsdt = rsdp->rsdt_address;
+	ut_assert(rsdt);
+	xsdt = rsdp->xsdt_address;
+	ut_assert(xsdt);
+
+	/* Find with both RSDT and XSDT */
+	table = acpi_find_table("TST1");
+	ut_asserteq_ptr(table1, table);
+	ut_asserteq_strn("TST1", table->signature);
+	table = acpi_find_table("TST2");
+	ut_asserteq_ptr(table2, table);
+	ut_asserteq_strn("TST2", table->signature);
+	table = acpi_find_table("TST3");
+	ut_asserteq_ptr(table3, table);
+	ut_asserteq_strn("TST3", table->signature);
+
+	/* Find with XSDT only */
+	rsdp->rsdt_address = 0;
+	table = acpi_find_table("TST1");
+	ut_asserteq_ptr(table1, table);
+	table = acpi_find_table("TST2");
+	ut_asserteq_ptr(table2, table);
+	table = acpi_find_table("TST3");
+	ut_asserteq_ptr(table3, table);
+	rsdp->rsdt_address = rsdt;
+
+	/* Find with RSDT only */
+	rsdp->xsdt_address = 0;
+	table = acpi_find_table("TST1");
+	ut_asserteq_ptr(table1, table);
+	table = acpi_find_table("TST2");
+	ut_asserteq_ptr(table2, table);
+	table = acpi_find_table("TST3");
+	ut_asserteq_ptr(table3, table);
+	rsdp->xsdt_address = xsdt;
+
+	/* Restore previous ACPI tables */
+	gd_set_acpi_start(acpi_start);
+	free(buf);
+
+	return 0;
+}
+DM_TEST(dm_test_acpi_find_table, 0);
-- 
2.40.1

