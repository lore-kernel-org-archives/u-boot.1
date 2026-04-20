Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023A3F5A8C5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21602844F4;
	Tue, 21 Apr 2026 00:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="K9Z67P2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE135844EC; Tue, 21 Apr 2026 00:08:12 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4EE1844F4
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
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 392A440D86; 
 Mon, 20 Apr 2026 22:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776722887;
 bh=rxIqISaqCtvCAlVi1tsmnO7fSoTkG2r1MefQ+mB84B0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=K9Z67P2FBgE93cro50d3/OW5ff1XIAQ0CxAUbgGbes7iJChHWRXkYGEfhNJt2B31D
 ejCgsmWcuhxSFvZ6QPzpQthL3H/NksMJ0KL2k1H4Jqx5XlyWdL1rQbegMXZr4in50p
 3ZMk0EqmQtE5RQUVOFXYkA2U6PWyYpNxBZeYw/KqTm/nE4LzRMc3fWIV3l8yWg4yj7
 08WYvJ2URkbwRBbiD4ETr7cU1uqPWZ3dv26+iViLItIf5DxUiTMYLM9c57/uWl8yjD
 Q+cVFxq6Sc/GxKsTjkHL2GCGFBK2MBeL9X6dYJyFUfEfsnd2w4IfRG27A38mYm8YSz
 kDbQo1lQo0orcK2S/YRFXhRIlPCZVtKn38LTQNNpF1dBlxo6S7UVrBzNgz/m4IqKa4
 bqjcD5teEvZ6lU7HEj2/bxanzdhSFYVXyX9saKA3vjOQd3H5vErF8X9NkDNoVjkVAk
 63wMaEJPJTD4iathVgA5v1wdhbsvmfbU/wV69RkBJDKNEOab1TlLCUn+acbiRdFU/e
 OnljUt6k4gptsSIvcMyJtwLNhW2KxrhG9ZpX2i4rdIHYTG3lX+G7WkfEhV8MInh6A8
 bnolZ5iyDx1XufEu5AoBcLwRk4gf1s7VwFSOdbbQTUNaVgsbhav+7W2XfLakHi8i1W
 6PaZ1svg51zjkGZ51ZPTIkN4=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/4] test: consider index parameter in acpi_find_table test
Date: Tue, 21 Apr 2026 00:08:03 +0200
Message-ID: <20260420220804.71564-4-heinrich.schuchardt@canonical.com>
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

* Add a duplicate table.
* Check that both instances can be found.
* Verify index bound checks.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/dm/acpi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index 8bec09f4e44..ba533763d96 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -783,7 +783,7 @@ static int dm_test_acpi_find_table(struct unit_test_state *uts)
 	struct acpi_ctx ctx;
 	ulong acpi_start, addr;
 	void *buf;
-	struct acpi_table_header *table, *table1, *table2, *table3;
+	struct acpi_table_header *table, *table1, *table2, *table3, *table4;
 	struct acpi_rsdp *rsdp;
 	ulong rsdt;
 	ulong xsdt;
@@ -799,6 +799,7 @@ static int dm_test_acpi_find_table(struct unit_test_state *uts)
 	table3 = dm_test_write_test_table(&ctx, 3);
 	table1 = dm_test_write_test_table(&ctx, 1);
 	table2 = dm_test_write_test_table(&ctx, 2);
+	table4 = dm_test_write_test_table(&ctx, 1);
 
 	/* Retrieve RSDP, RSDT, XSDT */
 	rsdp = map_sysmem(gd_acpi_start(), 0);
@@ -812,6 +813,11 @@ static int dm_test_acpi_find_table(struct unit_test_state *uts)
 	table = acpi_find_table("TST1", 0);
 	ut_asserteq_ptr(table1, table);
 	ut_asserteq_strn("TST1", table->signature);
+	table = acpi_find_table("TST1", 1);
+	ut_asserteq_ptr(table4, table);
+	ut_asserteq_strn("TST1", table->signature);
+	table = acpi_find_table("TST1", 2);
+	ut_assertnull(table);
 	table = acpi_find_table("TST2", 0);
 	ut_asserteq_ptr(table2, table);
 	ut_asserteq_strn("TST2", table->signature);
@@ -823,6 +829,10 @@ static int dm_test_acpi_find_table(struct unit_test_state *uts)
 	rsdp->rsdt_address = 0;
 	table = acpi_find_table("TST1", 0);
 	ut_asserteq_ptr(table1, table);
+	table = acpi_find_table("TST1", 1);
+	ut_asserteq_ptr(table4, table);
+	table = acpi_find_table("TST1", 2);
+	ut_assertnull(table);
 	table = acpi_find_table("TST2", 0);
 	ut_asserteq_ptr(table2, table);
 	table = acpi_find_table("TST3", 0);
@@ -833,6 +843,10 @@ static int dm_test_acpi_find_table(struct unit_test_state *uts)
 	rsdp->xsdt_address = 0;
 	table = acpi_find_table("TST1", 0);
 	ut_asserteq_ptr(table1, table);
+	table = acpi_find_table("TST1", 1);
+	ut_asserteq_ptr(table4, table);
+	table = acpi_find_table("TST1", 2);
+	ut_assertnull(table);
 	table = acpi_find_table("TST2", 0);
 	ut_asserteq_ptr(table2, table);
 	table = acpi_find_table("TST3", 0);
-- 
2.53.0

