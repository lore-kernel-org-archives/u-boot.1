Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64ED4C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D358E875F7;
	Tue, 21 Nov 2023 15:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VNqeoCTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 786A6870F8; Tue, 21 Nov 2023 15:41:46 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E7F871CD
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D66BF423D3; 
 Tue, 21 Nov 2023 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700577704;
 bh=8WSvtbseGTdg7fN7TVIcVsTXiKCbLSk0WEdn62/M24M=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=VNqeoCTxZAIOpRYt/UrlC1evEWf+M9jhiIAW1gW5JaUZv9XsdyGrv6te3xFe1DRXQ
 vIAnwDA79b3xjpAFm1fbE7BeJnjAOZzcuSMBHpQW+7wloiuQT6MdMAJZs2j61SJzpk
 myTpS42KYhC7eyvqtLXP/MMQHHklB655Ixx2KnAZVM25LS1X8kmzhOAIihQeaWK4cL
 R8LxggJBWl+R2yAptBghUQC11BqfZ5ymWm5CZrKb+TLj5eV4oUN1cb0o7kVMp9pM1q
 teoCll0Hmf0XphQUO1Iejw47yx0jkfj6U2oLqMPxkZhonZSBd9cJlbKQAS8kty2HWq
 xAeLyOYRl2Haw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 1/2] acpi: fix struct acpi_xsdt
Date: Tue, 21 Nov 2023 15:41:27 +0100
Message-Id: <20231121144128.20256-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121144128.20256-1-heinrich.schuchardt@canonical.com>
References: <20231121144128.20256-1-heinrich.schuchardt@canonical.com>
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
v4:
	no change
v3:
	no change
v2:
	add unit test for offset of field Entry in RSDT, XSDT
---
 include/acpi/acpi_table.h |  2 +-
 test/dm/acpi.c            | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index a3b67259e6..20ac3b51ba 100644
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

