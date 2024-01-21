Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FD1C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 11:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9B087527;
	Sun, 21 Jan 2024 12:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="n3hzJ2KN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 662CA876B1; Sun, 21 Jan 2024 12:53:04 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92171874BA
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 12:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C20A7429B3; 
 Sun, 21 Jan 2024 11:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705837980;
 bh=wczwLXAfCUU+aujEi3ZnfYcE6EgAHlQzI5XlURgt6eg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=n3hzJ2KNsJwzleybQu9BN/mAM5K1Csmf4k7uhWq7/HE+D0APIz+KnKyDHBybzugoN
 wjTv6KMxklZ/MoMcxX3cQRfA2Ix7ZjIcywJS23+wM0lL+COFC63qTzCFh4Vm1u4t/b
 CkCk2ZX6ru/lZyhmGID8nq2b7gEWJfDmQCSm7vq+/dRlbW9PO0OEgRshDkJwCGJN6L
 ud4vfDDR5olLZyPXtoJ7AIFEAqx5PbmU2m6kNmVWX8iSbeI7n8pt8ZnER9JJAzWrut
 dyo6W81iTA0K1oVnHqkyNsdq4UavK3I0dhYwbP92bEvcHgKqEKaJdSL8k3dtDYdLCe
 HIygJzkIy5hpA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] acpi: rename aslc_id, aslc_revision
Date: Sun, 21 Jan 2024 12:52:48 +0100
Message-ID: <20240121115248.167430-1-heinrich.schuchardt@canonical.com>
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

The fields Creator ID and Creator Revision contain information about the
tool that created an ACPI table. This may be the ASL compiler for some
tables but it is not for others. Naming these fields aslc_id and
aslc_revision is misleading.

It is usual to see diverse values of Creator ID. On a laptop I saw these:
'AMD ', 'INTL, 'MSFT', 'PTEC'. Obviously not all relate to the Intel
ASL compiler.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/x86/lib/acpi_nhlt.c  | 2 +-
 arch/x86/lib/acpi_table.c | 8 ++++----
 cmd/acpi.c                | 2 +-
 include/acpi/acpi_table.h | 6 +++---
 lib/acpi/acpi_table.c     | 4 ++--
 lib/acpi/ssdt.c           | 2 +-
 test/dm/acpi.c            | 6 +++---
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/lib/acpi_nhlt.c b/arch/x86/lib/acpi_nhlt.c
index 6c8cd83e12d..08e13fdea67 100644
--- a/arch/x86/lib/acpi_nhlt.c
+++ b/arch/x86/lib/acpi_nhlt.c
@@ -409,7 +409,7 @@ int nhlt_serialise_oem_overrides(struct acpi_ctx *ctx, struct nhlt *nhlt,
 		memcpy(header->oem_table_id, oem_table_id, oem_table_id_len);
 	}
 	header->oem_revision = oem_revision;
-	memcpy(header->aslc_id, ASLC_ID, 4);
+	memcpy(header->creator_id, ASLC_ID, 4);
 
 	cur.buf = (void *)(header + 1);
 	cur.start = (void *)header;
diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index 5ecd3d4b651..a5683132b01 100644
--- a/arch/x86/lib/acpi_table.c
+++ b/arch/x86/lib/acpi_table.c
@@ -253,7 +253,7 @@ static int acpi_write_tpm2(struct acpi_ctx *ctx,
 
 	/* Fill out header fields. */
 	acpi_fill_header(header, "TPM2");
-	memcpy(header->aslc_id, ASLC_ID, 4);
+	memcpy(header->creator_id, ASLC_ID, 4);
 
 	header->length = sizeof(struct acpi_tpm2);
 	header->revision = acpi_get_table_revision(ACPITAB_TPM2);
@@ -479,7 +479,7 @@ static int acpi_create_hpet(struct acpi_hpet *hpet)
 	/* Fill out header fields. */
 	acpi_fill_header(header, "HPET");
 
-	header->aslc_revision = ASL_REVISION;
+	header->creator_revision = ASL_REVISION;
 	header->length = sizeof(struct acpi_hpet);
 	header->revision = acpi_get_table_revision(ACPITAB_HPET);
 
@@ -569,8 +569,8 @@ void acpi_fadt_common(struct acpi_fadt *fadt, struct acpi_facs *facs,
 	header->revision = 4;
 	memcpy(header->oem_id, OEM_ID, 6);
 	memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
-	memcpy(header->aslc_id, ASLC_ID, 4);
-	header->aslc_revision = 1;
+	memcpy(header->creator_id, ASLC_ID, 4);
+	header->creator_revision = 1;
 
 	fadt->x_firmware_ctrl = map_to_sysmem(facs);
 	fadt->x_dsdt = map_to_sysmem(dsdt);
diff --git a/cmd/acpi.c b/cmd/acpi.c
index 65caaa5c98e..928e5dc525e 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -32,7 +32,7 @@ static void dump_hdr(struct acpi_table_header *hdr)
 	if (has_hdr) {
 		printf("  v%02d %.6s %.8s %x %.4s %x\n", hdr->revision,
 		       hdr->oem_id, hdr->oem_table_id, hdr->oem_revision,
-		       hdr->aslc_id, hdr->aslc_revision);
+		       hdr->creator_id, hdr->creator_revision);
 	} else {
 		printf("\n");
 	}
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index e67562ef654..8256af6d29e 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -57,8 +57,8 @@ struct __packed acpi_table_header {
 	char oem_id[6];		/* OEM identification */
 	char oem_table_id[8];	/* OEM table identification */
 	u32 oem_revision;	/* OEM revision number */
-	char aslc_id[4];	/* ASL compiler vendor ID */
-	u32 aslc_revision;	/* ASL compiler revision number */
+	char creator_id[4];	/* ASL compiler vendor ID */
+	u32 creator_revision;	/* ASL compiler revision number */
 };
 
 struct acpi_gen_regaddr {
@@ -831,7 +831,7 @@ void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
 /**
  * acpi_fill_header() - Set up a new table header
  *
- * This sets all fields except length, revision, checksum and aslc_revision
+ * This sets all fields except length, revision, checksum and creator_revision
  *
  * @header: ACPI header to update
  * @signature: Table signature to use (4 characters)
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 39dd53ec402..c16ead6a6ec 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -116,7 +116,7 @@ void acpi_fill_header(struct acpi_table_header *header, char *signature)
 	memcpy(header->oem_id, OEM_ID, 6);
 	memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
 	header->oem_revision = OEM_REVISION;
-	memcpy(header->aslc_id, ASLC_ID, 4);
+	memcpy(header->creator_id, ASLC_ID, 4);
 }
 
 void acpi_align(struct acpi_ctx *ctx)
@@ -219,7 +219,7 @@ void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
 
 	header->revision = acpi_get_table_revision(ACPITAB_DBG2);
 	acpi_fill_header(header, "DBG2");
-	header->aslc_revision = ASL_REVISION;
+	header->creator_revision = ASL_REVISION;
 
 	/* One debug device defined */
 	dbg2->devices_offset = sizeof(struct acpi_dbg2_header);
diff --git a/lib/acpi/ssdt.c b/lib/acpi/ssdt.c
index b0a96f846e3..e032e266b3c 100644
--- a/lib/acpi/ssdt.c
+++ b/lib/acpi/ssdt.c
@@ -23,7 +23,7 @@ int acpi_write_ssdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 
 	acpi_fill_header(ssdt, "SSDT");
 	ssdt->revision = acpi_get_table_revision(ACPITAB_SSDT);
-	ssdt->aslc_revision = 1;
+	ssdt->creator_revision = 1;
 	ssdt->length = sizeof(struct acpi_table_header);
 
 	acpi_inc(ctx, sizeof(struct acpi_table_header));
diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index c53ebcdb1c1..f14b3962f84 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -237,7 +237,7 @@ static int dm_test_acpi_fill_header(struct unit_test_state *uts)
 	hdr.length = 0x11;
 	hdr.revision = 0x22;
 	hdr.checksum = 0x33;
-	hdr.aslc_revision = 0x44;
+	hdr.creator_revision = 0x44;
 	acpi_fill_header(&hdr, "ABCD");
 
 	ut_asserteq_mem("ABCD", hdr.signature, sizeof(hdr.signature));
@@ -248,8 +248,8 @@ static int dm_test_acpi_fill_header(struct unit_test_state *uts)
 	ut_asserteq_mem(OEM_TABLE_ID, hdr.oem_table_id,
 			sizeof(hdr.oem_table_id));
 	ut_asserteq(OEM_REVISION, hdr.oem_revision);
-	ut_asserteq_mem(ASLC_ID, hdr.aslc_id, sizeof(hdr.aslc_id));
-	ut_asserteq(0x44, hdr.aslc_revision);
+	ut_asserteq_mem(ASLC_ID, hdr.creator_id, sizeof(hdr.creator_id));
+	ut_asserteq(0x44, hdr.creator_revision);
 
 	return 0;
 }
-- 
2.43.0

