Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5FBC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1188786EB8;
	Sat, 18 Nov 2023 23:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Eq9Ijbg6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66749874B9; Sat, 18 Nov 2023 23:54:21 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEC0B86EB8
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 52D2E3F66F; 
 Sat, 18 Nov 2023 22:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700348046;
 bh=xr11iUOpb+92nB05be3En+KAoMGWurUwiu7V4zd4bb0=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=Eq9Ijbg69xlRB+nr5dzruqoY89aIoj1hzcx98f8ghITR429idvXOVmdjF6bgCBJ3p
 aKRxQH7TYTXliDDLX5oOplGB8Jiiee6+td9WPBvsgGsQD34FgljS2PD9c+HFPm/P2U
 FaUL31M48ZiaCoBdnL1tY9aLjy6OvJiqMNB0jlTnODZYKV/PMYDNWIWdXqtZGKpVJb
 fU77yvTB8S5uLnseek/TySEmaG25WC80xq7h7JOh+J0KRT5vHsLqPF+h+VlUH2rLOL
 vcchL99lMHzGQKjvoaKCdZ2HErjWpt3l+E43DHVTzYW8GJwiEh8V+15WWUyd5Ogw6N
 A5wzjwl54qwug==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/2] acpi: fix struct acpi_xsdt
Date: Sat, 18 Nov 2023 23:52:47 +0100
Message-Id: <20231118225248.105229-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118225248.105229-1-heinrich.schuchardt@canonical.com>
References: <20231118225248.105229-1-heinrich.schuchardt@canonical.com>
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

The size of the ACPI table header is not a multiple of 8. We have to mark
struct acpi_xsdt as packed to correctly access field Entry.

Add a unit test for the offsets of field Entry in the RSDT and XSDT tables.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v3:
	no change
v2:
	add unit test for offset of field Entry in RSDT, XSDT
---
 include/acpi/acpi_table.h |  2 +-
 test/dm/acpi.c            | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 1f85de091d..59ab79ed17 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -80,7 +80,7 @@ struct acpi_rsdt {
 };
 
 /* XSDT (Extended System Description Table) */
-struct acpi_xsdt {
+struct __packed acpi_xsdt {
 	struct acpi_table_header header;
 	u64 entry[MAX_ACPI_TABLES];
 };
diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index 5997bda649..559cf1693b 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -651,3 +651,13 @@ static int dm_test_acpi_cmd_set(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_acpi_cmd_set, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+
+/* Test offsets in RSDT, XSDT */
+static int dm_test_acpi_offsets(struct unit_test_state *uts)
+{
+	ut_asserteq(36, offsetof(struct acpi_rsdt, entry));
+	ut_asserteq(36, offsetof(struct acpi_xsdt, entry));
+
+	return 0;
+}
+DM_TEST(dm_test_acpi_offsets, 0);
-- 
2.40.1

