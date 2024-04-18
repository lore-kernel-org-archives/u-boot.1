Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BB1C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 03:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 517D588526;
	Thu, 18 Apr 2024 05:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OOaekKkA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2136988560; Thu, 18 Apr 2024 05:11:26 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 100CD884E9
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 319023F0FA; 
 Thu, 18 Apr 2024 03:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713409883;
 bh=WgtPQ/yHX/YoxWcA345UIfLjUU2hbjcb0n0HEAd4/Nw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=OOaekKkAZtL5SRa4Ufn263pkUFMBv9uAL70MlDkLmm55wZP2dMWo4M1f5+j8FIl3D
 ylnpwBpHxA++jIyqF/vGmdzxZmv5+3oNnCLxoe9AePEJUfM+qshl+Tv0O4WBAaRZhN
 W8zfVQqWcv9/MlMVNYdKTTTKjtdVzOcrgL7WYj1IWn91aszADdDdd+N4+7p+NgeGLJ
 rY/m4aFV2IM/xeKPusqCMQ8xjZA+PF8YqpcQPxJViu5VTcC+QQ6s19I5vpBwisUQJY
 4YwejqS1l6qWtL+/+Pqi8Z5vr3aheAaUYSQuBmhVQ+4SlBD0w9Uv2y4Xqam4NdjA3P
 0co4X24Ft1RpQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] acpi: set creator_revision in acpi_fill_header
Date: Thu, 18 Apr 2024 05:11:13 +0200
Message-ID: <20240418031113.52277-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

We should have a single place where we write the default value to the
creator revision field. If we ever will have any table created by another
tool, we can overwrite the value afterwards.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/x86/lib/acpi_table.c | 2 --
 lib/acpi/acpi_table.c     | 2 +-
 lib/acpi/ssdt.c           | 1 -
 test/dm/acpi.c            | 3 +--
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index a5683132b01..06997948880 100644
--- a/arch/x86/lib/acpi_table.c
+++ b/arch/x86/lib/acpi_table.c
@@ -479,7 +479,6 @@ static int acpi_create_hpet(struct acpi_hpet *hpet)
 	/* Fill out header fields. */
 	acpi_fill_header(header, "HPET");
 
-	header->creator_revision = ASL_REVISION;
 	header->length = sizeof(struct acpi_hpet);
 	header->revision = acpi_get_table_revision(ACPITAB_HPET);
 
@@ -570,7 +569,6 @@ void acpi_fadt_common(struct acpi_fadt *fadt, struct acpi_facs *facs,
 	memcpy(header->oem_id, OEM_ID, 6);
 	memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
 	memcpy(header->creator_id, ASLC_ID, 4);
-	header->creator_revision = 1;
 
 	fadt->x_firmware_ctrl = map_to_sysmem(facs);
 	fadt->x_dsdt = map_to_sysmem(dsdt);
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index c16ead6a6ec..6dbfdb22dec 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -117,6 +117,7 @@ void acpi_fill_header(struct acpi_table_header *header, char *signature)
 	memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
 	header->oem_revision = OEM_REVISION;
 	memcpy(header->creator_id, ASLC_ID, 4);
+	header->creator_revision = ASL_REVISION;
 }
 
 void acpi_align(struct acpi_ctx *ctx)
@@ -219,7 +220,6 @@ void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
 
 	header->revision = acpi_get_table_revision(ACPITAB_DBG2);
 	acpi_fill_header(header, "DBG2");
-	header->creator_revision = ASL_REVISION;
 
 	/* One debug device defined */
 	dbg2->devices_offset = sizeof(struct acpi_dbg2_header);
diff --git a/lib/acpi/ssdt.c b/lib/acpi/ssdt.c
index e032e266b3c..df1d739d117 100644
--- a/lib/acpi/ssdt.c
+++ b/lib/acpi/ssdt.c
@@ -23,7 +23,6 @@ int acpi_write_ssdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 
 	acpi_fill_header(ssdt, "SSDT");
 	ssdt->revision = acpi_get_table_revision(ACPITAB_SSDT);
-	ssdt->creator_revision = 1;
 	ssdt->length = sizeof(struct acpi_table_header);
 
 	acpi_inc(ctx, sizeof(struct acpi_table_header));
diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index f14b3962f84..48cf3af1f8f 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -237,7 +237,6 @@ static int dm_test_acpi_fill_header(struct unit_test_state *uts)
 	hdr.length = 0x11;
 	hdr.revision = 0x22;
 	hdr.checksum = 0x33;
-	hdr.creator_revision = 0x44;
 	acpi_fill_header(&hdr, "ABCD");
 
 	ut_asserteq_mem("ABCD", hdr.signature, sizeof(hdr.signature));
@@ -249,7 +248,7 @@ static int dm_test_acpi_fill_header(struct unit_test_state *uts)
 			sizeof(hdr.oem_table_id));
 	ut_asserteq(OEM_REVISION, hdr.oem_revision);
 	ut_asserteq_mem(ASLC_ID, hdr.creator_id, sizeof(hdr.creator_id));
-	ut_asserteq(0x44, hdr.creator_revision);
+	ut_asserteq(ASL_REVISION, hdr.creator_revision);
 
 	return 0;
 }
-- 
2.43.0

