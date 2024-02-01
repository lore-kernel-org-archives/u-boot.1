Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B73FC47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 00:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EEB687B2D;
	Thu,  1 Feb 2024 01:20:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bZwEu1Jk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8257687B2D; Thu,  1 Feb 2024 01:20:52 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED8B878C9
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 01:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DD8C8419C3; 
 Thu,  1 Feb 2024 00:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706746839;
 bh=ga0ZNx+R6R1683+mEn7bzaksnL41gZoiUT3OKyxDD3M=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=bZwEu1JkfMG+5FjGjL8YQZ4KcN1V9AE8S/xWdVfkfLKvXiBZWccvnP9Y8D1G7kaLu
 gQaXbDAQ1KjIhzHL8Kn+5Th4WlVK0JbrQSEJBghTC05kvpFqOgLbXlvbJ9icAyi+4k
 RP5sJSK8LvU41gi7u1Py1MvSVp4e9pSAk301XMKxXA9nEqg7gwhMlhqS82DPcH7NVf
 wy3eTpdp2CVcNgQTMBoHtybs33fFA25fad7S1caFb7cmDttH0DDiBege95aZ+NUVTl
 XVOs/wx4fjucbsisI14qMOOvHGZLbbHfBuoV8JE99itwyiPIYKP7kwGHA/HQcloOy6
 C6Zdh2W/bwgoQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Eddie James <eajames@linux.ibm.com>, Peter Robinson <pbrobinson@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] smbios: correctly name Structure Table Maximum Size field
Date: Thu,  1 Feb 2024 01:20:22 +0100
Message-ID: <20240201002022.11258-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201002022.11258-1-heinrich.schuchardt@canonical.com>
References: <20240201002022.11258-1-heinrich.schuchardt@canonical.com>
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

In the SMBIOS 3 entry point the Structure Table Maximum Size field was
incorrectly named max_struct_size. A Maximum Structure Size field only
exists in the SMBIOS 2.1 entry point and has a different meaning.

Call the Structure Table Length field table_maximum_size.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/smbios.c                | 2 +-
 drivers/misc/qfw_smbios.c   | 2 +-
 include/smbios.h            | 2 +-
 lib/efi_loader/efi_tcg2.c   | 4 ++--
 lib/efi_loader/smbiosdump.c | 6 +++---
 lib/smbios-parser.c         | 2 +-
 lib/smbios.c                | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index e2d82be163..66f6b76137 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -142,7 +142,7 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
 			 entry3->major_ver, entry3->minor_ver, entry3->doc_rev);
 		table = (void *)(uintptr_t)entry3->struct_table_address;
 		size = entry3->length;
-		table_maximum_size = entry3->max_struct_size;
+		table_maximum_size = entry3->table_maximum_size;
 	} else if (!memcmp(entry, smbios_sig, sizeof(smbios_sig) - 1)) {
 		struct smbios_entry *entry2 = entry;
 
diff --git a/drivers/misc/qfw_smbios.c b/drivers/misc/qfw_smbios.c
index a898cb4eea..c3e8c310d0 100644
--- a/drivers/misc/qfw_smbios.c
+++ b/drivers/misc/qfw_smbios.c
@@ -90,7 +90,7 @@ static int qfw_parse_smbios_anchor(struct udevice *dev,
 		entry->length = sizeof(struct smbios3_entry);
 		entry->major_ver = entry2->major_ver;
 		entry->minor_ver = entry2->minor_ver;
-		entry->max_struct_size = entry2->struct_table_length;
+		entry->table_maximum_size = entry2->struct_table_length;
 	} else {
 		ret = -ENOENT;
 		goto out;
diff --git a/include/smbios.h b/include/smbios.h
index e2b7f69584..3df8827b60 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -75,7 +75,7 @@ struct __packed smbios3_entry {
 	/** @reserved: reserved */
 	u8 reserved;
 	/** maximum size of SMBIOS table */
-	u32 max_struct_size;
+	u32 table_maximum_size;
 	/** @struct_table_address: 64-bit physical starting address */
 	u64 struct_table_address;
 };
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index b5d4aa7be5..b07e0099c2 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -1098,7 +1098,7 @@ tcg2_measure_smbios(struct udevice *dev,
 	 */
 	event_size = sizeof(struct smbios_handoff_table_pointers2) +
 		     FIELD_SIZEOF(struct efi_configuration_table, guid) +
-		     entry->max_struct_size;
+		     entry->table_maximum_size;
 	event = calloc(1, event_size);
 	if (!event) {
 		ret = EFI_OUT_OF_RESOURCES;
@@ -1113,7 +1113,7 @@ tcg2_measure_smbios(struct udevice *dev,
 	smbios_copy = (struct smbios_header *)((uintptr_t)&event->table_entry[0].table);
 	memcpy(&event->table_entry[0].table,
 	       (void *)((uintptr_t)entry->struct_table_address),
-	       entry->max_struct_size);
+	       entry->table_maximum_size);
 
 	smbios_prepare_measurement(entry, smbios_copy);
 
diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
index f0b901897e..2f0b91a353 100644
--- a/lib/efi_loader/smbiosdump.c
+++ b/lib/efi_loader/smbiosdump.c
@@ -329,7 +329,7 @@ efi_status_t do_check(void)
 			return EFI_LOAD_ERROR;
 		}
 		table = (void *)(uintptr_t)smbios3_anchor->struct_table_address;
-		len = smbios3_anchor->max_struct_size;
+		len = smbios3_anchor->table_maximum_size;
 	} else {
 		struct smbios_entry *smbios_anchor;
 		int r;
@@ -469,7 +469,7 @@ static efi_status_t do_save(u16 *filename)
 
 	smbios3_anchor = get_config_table(&smbios3_guid);
 	if (smbios3_anchor) {
-		size = 0x20 + smbios3_anchor->max_struct_size;
+		size = 0x20 + smbios3_anchor->table_maximum_size;
 		ret = bs->allocate_pool(EFI_LOADER_DATA, size, (void **)&buf);
 		if (ret != EFI_SUCCESS) {
 			error(u"Out of memory\n");
@@ -480,7 +480,7 @@ static efi_status_t do_save(u16 *filename)
 		memcpy(buf, smbios3_anchor, smbios3_anchor->length);
 		memcpy(buf + 0x20,
 		       (void *)(uintptr_t)smbios3_anchor->struct_table_address,
-		       smbios3_anchor->max_struct_size);
+		       smbios3_anchor->table_maximum_size);
 
 		smbios3_anchor = (struct smbios3_entry *)buf;
 		smbios3_anchor->struct_table_address = 0x20;
diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
index 0d1ac781b3..9a62b3c760 100644
--- a/lib/smbios-parser.c
+++ b/lib/smbios-parser.c
@@ -230,7 +230,7 @@ void smbios_prepare_measurement(const struct smbios3_entry *entry,
 	void *table_end;
 	struct smbios_header *header;
 
-	table_end = (void *)((u8 *)smbios_copy + entry->max_struct_size);
+	table_end = (void *)((u8 *)smbios_copy + entry->table_maximum_size);
 
 	for (i = 0; i < ARRAY_SIZE(smbios_filter_tables); i++) {
 		header = smbios_copy;
diff --git a/lib/smbios.c b/lib/smbios.c
index 327f78c8b0..c83af730a9 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -615,7 +615,7 @@ ulong write_smbios_table(ulong addr)
 	se->minor_ver = SMBIOS_MINOR_VER;
 	se->doc_rev = 0;
 	se->entry_point_rev = 1;
-	se->max_struct_size = len;
+	se->table_maximum_size = len;
 	se->struct_table_address = table_addr;
 	se->checksum = table_compute_checksum(se, sizeof(struct smbios3_entry));
 	unmap_sysmem(se);
-- 
2.43.0

