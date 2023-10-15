Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2064CDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2286686F6B;
	Sun, 15 Oct 2023 08:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X3PtB6uk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8E3B86F47; Sun, 15 Oct 2023 08:40:16 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2AE286B68
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4181bd07f25so24835771cf.1
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697351917; x=1697956717; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8ly30ypa44BXOTyIn5L80seUpvyBPGWkgTkAnFmHKA=;
 b=X3PtB6ukhGGZoBtUyHdgfhLHKpi026TvLWklxJ6Ku5h+zfVJ0ilygxBrs8/h78ocWY
 s7+5dXjCzhZjqpvXEzuxGn5eUdYnC9/uqf9AnQIN6mZkhYNHFcRWR7OBzAuCW7vZ1edF
 ocF3WjCyYioOfemuOUM4du5zstpYQ2c9lLZPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697351917; x=1697956717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R8ly30ypa44BXOTyIn5L80seUpvyBPGWkgTkAnFmHKA=;
 b=Cf6c+q0Bcq/6SNRLsdYqJDP4d38c2Ck7kac/1FC6pP2kLejUtKm9KEMQmc2EYssPnY
 phyVBI9XNe03hgNoykvAZbkjvWqAH1IeF6xiJh1MWxFfHXGb4gg8wN1cGJEeeXmzu3Mb
 cO4cjYs5g53nsCiZ5bwWiHeYSyd5aPnpjDbeKYX0mSGeKpY3Y4wMybWTUcCp/6U31xM5
 6lapu2XB2930gsauxX8yMJJuK2bFPKlhvyRFn5RFRaTu/n9EQX2pWLfIrqk5FVnYOcIw
 SF8p+kLJWMtl+JnwIyHqN7gizzI4oNy5Ngp/NDWeW6pR+4Z1I+8/RctfsvefQPmhUnxn
 fQbg==
X-Gm-Message-State: AOJu0YxzbK0kxZoslTp6VrwrnUpy3k2MJMpBHedPbERRr+Ux4nj3nVvc
 23/J93MjteolbmiAunY/lN79pMqg/pCzuOvv36aSWA==
X-Google-Smtp-Source: AGHT+IGE5y9RW4HjAdimo2VAhs1d6pHHBcBYkoE8JApoDVEsu4S1svBVf03p4GBB9jJeT7ADdZhNRA==
X-Received: by 2002:a05:6e02:1253:b0:357:4c17:e697 with SMTP id
 j19-20020a056e02125300b003574c17e697mr9997089ilq.10.1697337917158; 
 Sat, 14 Oct 2023 19:45:17 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a92cd46000000b003497ced3fa1sm2462842ilq.29.2023.10.14.19.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 19:45:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/6] smbios: Use SMBIOS 3.0 to support an address above 4GB
Date: Sat, 14 Oct 2023 20:45:05 -0600
Message-ID: <20231015024511.3995580-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231015024511.3995580-1-sjg@chromium.org>
References: <20231015024511.3995580-1-sjg@chromium.org>
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

When the SMBIOS table is written to an address above 4GB a 32-bit table
address is not large enough.

Use an SMBIOS3 table in that case.

Note that we cannot use efi_allocate_pages() since this function has
nothing to do with EFI. There is no equivalent function to allocate
memory below 4GB in U-Boot. One solution would be to create a separate
malloc() pool, or just always put the malloc() pool below 4GB.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Check the end of the table rather than the start.

 include/smbios.h | 22 +++++++++++++++++++++-
 lib/smbios.c     | 24 +++++++++++++++++++-----
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/smbios.h b/include/smbios.h
index c9df2706f5a6..ddabb558299e 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -12,7 +12,8 @@
 
 /* SMBIOS spec version implemented */
 #define SMBIOS_MAJOR_VER	3
-#define SMBIOS_MINOR_VER	0
+#define SMBIOS_MINOR_VER	7
+
 
 enum {
 	SMBIOS_STR_MAX	= 64,	/* Maximum length allowed for a string */
@@ -54,6 +55,25 @@ struct __packed smbios_entry {
 	u8 bcd_rev;
 };
 
+struct __packed smbios3_entry {
+	u8 anchor[5];
+	u8 checksum;
+	u8 length;
+	u8 major_ver;
+
+	u8 minor_ver;
+	u8 docrev;
+	u8 entry_point_rev;
+	u8 reserved;
+	u32 max_struct_size;
+
+	u64 struct_table_address;
+};
+
+/* These two structures should use the same amount of 16-byte-aligned space */
+static_assert(ALIGN(16, sizeof(struct smbios_entry)) ==
+	      ALIGN(16, sizeof(struct smbios3_entry)));
+
 /* BIOS characteristics */
 #define BIOS_CHARACTERISTICS_PCI_SUPPORTED	(1 << 7)
 #define BIOS_CHARACTERISTICS_UPGRADEABLE	(1 << 11)
diff --git a/lib/smbios.c b/lib/smbios.c
index c7a557bc9b7b..92e98388084f 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -487,7 +487,11 @@ ulong write_smbios_table(ulong addr)
 	addr = ALIGN(addr, 16);
 	start_addr = addr;
 
-	addr += sizeof(struct smbios_entry);
+	/*
+	 * So far we don't know which struct will be used, but they both end
+	 * up using the same amount of 16-bit-aligned space
+	 */
+	addr += max(sizeof(struct smbios_entry), sizeof(struct smbios3_entry));
 	addr = ALIGN(addr, 16);
 	tables = addr;
 
@@ -512,14 +516,24 @@ ulong write_smbios_table(ulong addr)
 	 * sandbox's DRAM buffer.
 	 */
 	table_addr = (ulong)map_sysmem(tables, 0);
-	if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulong)UINT_MAX) {
+	if (sizeof(table_addr) > sizeof(u32) && addr >= (ulong)UINT_MAX) {
+		struct smbios3_entry *se;
 		/*
 		 * We need to put this >32-bit pointer into the table but the
 		 * field is only 32 bits wide.
 		 */
-		printf("WARNING: SMBIOS table_address overflow %llx\n",
-		       (unsigned long long)table_addr);
-		addr = 0;
+		printf("WARNING: Using SMBIOS3.0 due to table-address overflow %lx\n",
+		       table_addr);
+		se = map_sysmem(start_addr, sizeof(struct smbios_entry));
+		memset(se, '\0', sizeof(struct smbios_entry));
+		memcpy(se->anchor, "_SM3_", 5);
+		se->length = sizeof(struct smbios3_entry);
+		se->major_ver = SMBIOS_MAJOR_VER;
+		se->minor_ver = SMBIOS_MINOR_VER;
+		se->docrev = 0;
+		se->entry_point_rev = 1;
+		se->max_struct_size = len;
+		se->struct_table_address = table_addr;
 	} else {
 		struct smbios_entry *se;
 
-- 
2.42.0.655.g421f12c284-goog

