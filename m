Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEECDC4706F
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 07:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B08878AA;
	Wed, 27 Dec 2023 08:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CL3KVZUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4789D87855; Wed, 27 Dec 2023 08:40:52 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82C2C87855
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40d5336986cso33277965e9.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 23:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703662849; x=1704267649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VhXZNcwRvuX5yDmpXj2zP3PSFGV4siTQBXHsURPbqo=;
 b=CL3KVZUGu9BtfqTKbHNe7RhKmrWq7pVPDfsq/xI+KA9gLy5JlM67sCrPihLxI2CU/u
 ju29vgo83yFiLMtijaBRBMpKiv/6Z4jRhI0HInA12w9YdZalKv8NuzEdYnZdswZU/ols
 +i8Q+1hl+5cdkJRN0iOyaHHSCbKtwhw+ifnhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703662849; x=1704267649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VhXZNcwRvuX5yDmpXj2zP3PSFGV4siTQBXHsURPbqo=;
 b=ceaOmYjZdBuZEdVr6/o9uGGDPDhRZilSPCTGjzt+3Ep7ONJW+Nvvmx4rG7AFfa18H6
 QIf9yigwJME5Ht46oaa+9zUn1hAMeqZYSyKNXj4qweS2r/hPmpR1FRkrzDU6Ege8gFCb
 KQw2KSzalw+9yAgZFBD96Vp14mi5/2kUOsEorLYXcTANMH1TZuRMnl7jPJZNIbpZYXFt
 Apfs5GftMrEYWbEEvqpsnSoR0u6EoJG6zspFNQWFZdn57XuX0KBVGQe9+oXaTVJ7o59l
 L7WZH0MeOEp96QiE+oASmn78k/rI8sY/yjYpE1/97E20jPD5tOdYMzvN0UMuCA1tmqs9
 zD6w==
X-Gm-Message-State: AOJu0Yy8nnDUY186ZP6h36PJL4O9UqY3lUiEDZ30gKbAIa9Qzhu3oqAm
 5R1+2cGaP4gRcJoOZEJAptmaTuLt6j2lnIm8G8JT6DzA4a14
X-Google-Smtp-Source: AGHT+IGp8G8tSqVkYgn26pNyh2pPfm76XtPFFFtFxJloRLMdfE9hZ1ujxKuD7L/Y6EKDQpKcHar7xw==
X-Received: by 2002:a05:600c:450d:b0:40d:5722:2a44 with SMTP id
 t13-20020a05600c450d00b0040d57222a44mr1763466wmo.144.1703662848804; 
 Tue, 26 Dec 2023 23:40:48 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 s23-20020adf9797000000b00336813bb588sm14314426wrb.111.2023.12.26.23.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 23:40:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v4 4/7] smbios: Use SMBIOS 3.0 to support an address above 4GB
Date: Wed, 27 Dec 2023 07:40:21 +0000
Message-Id: <20231227074025.2178825-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227074025.2178825-1-sjg@chromium.org>
References: <20231227074025.2178825-1-sjg@chromium.org>
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

- Use log_debug() for warning
- Rebase on Heinrich's smbios.h patch
- Set the checksum for SMBIOS3

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Check the start of the table rather than the end

Changes in v2:
- Check the end of the table rather than the start.

 include/smbios.h |  6 +++++-
 lib/smbios.c     | 30 +++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/smbios.h b/include/smbios.h
index e601283d293..77be58887a2 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -12,7 +12,7 @@
 
 /* SMBIOS spec version implemented */
 #define SMBIOS_MAJOR_VER	3
-#define SMBIOS_MINOR_VER	0
+#define SMBIOS_MINOR_VER	7
 
 enum {
 	SMBIOS_STR_MAX	= 64,	/* Maximum length allowed for a string */
@@ -80,6 +80,10 @@ struct __packed smbios3_entry {
 	u64 struct_table_address;
 };
 
+/* These two structures should use the same amount of 16-byte-aligned space */
+static_assert(ALIGN(16, sizeof(struct smbios_entry)) ==
+	      ALIGN(16, sizeof(struct smbios3_entry)));
+
 /* BIOS characteristics */
 #define BIOS_CHARACTERISTICS_PCI_SUPPORTED	(1 << 7)
 #define BIOS_CHARACTERISTICS_UPGRADEABLE	(1 << 11)
diff --git a/lib/smbios.c b/lib/smbios.c
index eea72670bd9..7f79d969c92 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -567,7 +567,11 @@ ulong write_smbios_table(ulong addr)
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
 
@@ -590,16 +594,32 @@ ulong write_smbios_table(ulong addr)
 	 * We must use a pointer here so things work correctly on sandbox. The
 	 * user of this table is not aware of the mapping of addresses to
 	 * sandbox's DRAM buffer.
+	 *
+	 * Check the address of the end of the tables. If it is above 4GB then
+	 * it is sensible to use SMBIOS3 even if the start of the table is below
+	 * 4GB (this case is very unlikely to happen in practice)
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
+		log_debug("WARNING: Using SMBIOS3.0 due to table-address overflow %lx\n",
+			  table_addr);
+		se = map_sysmem(start_addr, sizeof(struct smbios_entry));
+		memset(se, '\0', sizeof(struct smbios_entry));
+		memcpy(se->anchor, "_SM3_", 5);
+		se->length = sizeof(struct smbios3_entry);
+		se->major_ver = SMBIOS_MAJOR_VER;
+		se->minor_ver = SMBIOS_MINOR_VER;
+		se->doc_rev = 0;
+		se->entry_point_rev = 1;
+		se->max_struct_size = len;
+		se->struct_table_address = table_addr;
+		se->checksum = table_compute_checksum(se,
+						sizeof(struct smbios3_entry));
 	} else {
 		struct smbios_entry *se;
 
-- 
2.34.1

