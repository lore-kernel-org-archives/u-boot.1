Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9841C47077
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8824C8791A;
	Sun, 31 Dec 2023 16:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hkiYZkR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BCB48788A; Sun, 31 Dec 2023 16:26:23 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB4908786C
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7ba9c26e14aso178467439f.0
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704036375; x=1704641175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+B3uLAhyXE4TIjHSBsOxBQuvNrYgEv+hAt85AUcgrg=;
 b=hkiYZkR3fSRSnuetZJuRiYAoleEl3O1z3fAIxNSofIJwyQTlauA3hAIUyzdoSTjU0h
 YjpFVp9x2ZSQZoGzbqBKn4nx7raI15hRBmHZjaJAJkeY98mAmaTKcjbSIW/mxzkGRwex
 yO1iPSFagWO2XPRwSTkMe5ai96tvXMR+ZO9p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704036375; x=1704641175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+B3uLAhyXE4TIjHSBsOxBQuvNrYgEv+hAt85AUcgrg=;
 b=qvL5QpMvSpG3LCm2AfSvkcveStaHy+wsJU7vhp/Q5nnYYcONPezTxK+xVbnTsuwJ5f
 ovlBOwKhx0jjohcWaRhC0uXkde0IU9K7YFtZj+kb3EDB388j80OwS7gZtWBSZTUo99hq
 bpDzqtuLNQbvS50PU1MMUvO1tisXtM/gwbzM49LcrMabjwvsh//+eZzIlbwk2WYDnQAp
 Wc178CIvXLzp8rkN5YalDDsOqWpTbgtUnAGkiT3CDTGXqiNgoJfUImFI7SAW4TQUkS4q
 TU6Dc3W5K/MT7ISTfHkKoF866E9fvhZ3/wUz3lCNhT8mKR6b+MtrVbFf4Lq7cPQNLhOL
 c90w==
X-Gm-Message-State: AOJu0YwyEBnciMz0RhkYIILDXzah4R9FQUoTZq9L5JiKkeG7wDSHCajK
 sJz3zwacFhLKlxKzGfjAatl/7e5nOfJ8fO8SwV7qk1N2ddZb
X-Google-Smtp-Source: AGHT+IGQMCFEQGu1QLvLVXiNW9o9ZNFPH/IJSANdeVkoTh1M4vp+xAgEreNg1Pb/D88UGi9T8RyUXA==
X-Received: by 2002:a5d:9bc9:0:b0:7ba:7d6a:652c with SMTP id
 d9-20020a5d9bc9000000b007ba7d6a652cmr10395175ion.3.1704036375506; 
 Sun, 31 Dec 2023 07:26:15 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cz9-20020a0566384a0900b0046b482039ecsm5632625jab.55.2023.12.31.07.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 07:26:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v5 08/12] smbios: Drop support for SMBIOS2 tables
Date: Sun, 31 Dec 2023 08:25:51 -0700
Message-Id: <20231231152555.464874-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231231152555.464874-1-sjg@chromium.org>
References: <20231231152555.464874-1-sjg@chromium.org>
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

These tables are a pain since there is no way to handle memory above
4GB. Use SMBIOS3 always.

This should hopefully not create problems on x86 devices, since SMBIOS3
was released seven years ago (2015).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Add new patch to drop support for SMBIOS2 tables

 lib/smbios.c | 76 ++++++++++++----------------------------------------
 1 file changed, 17 insertions(+), 59 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index cfd451e4088..d9d52bd58d7 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -545,13 +545,12 @@ ulong write_smbios_table(ulong addr)
 {
 	ofnode parent_node = ofnode_null();
 	ulong table_addr, start_addr;
+	struct smbios3_entry *se;
 	struct smbios_ctx ctx;
 	ulong tables;
 	int len = 0;
 	int max_struct_size = 0;
 	int handle = 0;
-	char *istart;
-	int isize;
 	int i;
 
 	ctx.node = ofnode_null();
@@ -565,12 +564,8 @@ ulong write_smbios_table(ulong addr)
 
 	start_addr = addr;
 
-	/*
-	 * So far we don't know which struct will be used, but they both end
-	 * up using the same amount of 16-bit-aligned space
-	 */
-	addr += max(sizeof(struct smbios_entry), sizeof(struct smbios3_entry));
-	addr = ALIGN(addr, 16);
+	/* move past the (so-far-unwritten) header to start writing structs */
+	addr = ALIGN(addr + sizeof(struct smbios3_entry), 16);
 	tables = addr;
 
 	/* populate minimum required tables */
@@ -592,59 +587,22 @@ ulong write_smbios_table(ulong addr)
 	 * We must use a pointer here so things work correctly on sandbox. The
 	 * user of this table is not aware of the mapping of addresses to
 	 * sandbox's DRAM buffer.
-	 *
-	 * Check the address of the end of the tables. If it is above 4GB then
-	 * it is sensible to use SMBIOS3 even if the start of the table is below
-	 * 4GB (this case is very unlikely to happen in practice)
 	 */
 	table_addr = (ulong)map_sysmem(tables, 0);
-	if (sizeof(table_addr) > sizeof(u32) && addr >= (ulong)UINT_MAX) {
-		struct smbios3_entry *se;
-		/*
-		 * We need to put this >32-bit pointer into the table but the
-		 * field is only 32 bits wide.
-		 */
-		log_debug("WARNING: Using SMBIOS3.0 due to table-address overflow %lx\n",
-			  table_addr);
-		se = map_sysmem(start_addr, sizeof(struct smbios_entry));
-		memset(se, '\0', sizeof(struct smbios_entry));
-		memcpy(se->anchor, "_SM3_", 5);
-		se->length = sizeof(struct smbios3_entry);
-		se->major_ver = SMBIOS_MAJOR_VER;
-		se->minor_ver = SMBIOS_MINOR_VER;
-		se->doc_rev = 0;
-		se->entry_point_rev = 1;
-		se->max_struct_size = len;
-		se->struct_table_address = table_addr;
-		se->checksum = table_compute_checksum(se,
-						sizeof(struct smbios3_entry));
-	} else {
-		struct smbios_entry *se;
-
-		se = map_sysmem(start_addr, sizeof(struct smbios_entry));
-		memset(se, '\0', sizeof(struct smbios_entry));
-		memcpy(se->anchor, "_SM_", 4);
-		se->length = sizeof(struct smbios_entry);
-		se->major_ver = SMBIOS_MAJOR_VER;
-		se->minor_ver = SMBIOS_MINOR_VER;
-		se->max_struct_size = max_struct_size;
-		memcpy(se->intermediate_anchor, "_DMI_", 5);
-		se->struct_table_length = len;
-
-		se->struct_table_address = table_addr;
-
-		se->struct_count = handle;
-
-		/* calculate checksums */
-		istart = (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
-		isize = sizeof(struct smbios_entry) -
-			SMBIOS_INTERMEDIATE_OFFSET;
-		se->intermediate_checksum = table_compute_checksum(istart,
-								   isize);
-		se->checksum = table_compute_checksum(se,
-					      sizeof(struct smbios_entry));
-		unmap_sysmem(se);
-	}
+
+	/* now go back and write the SMBIOS3 header */
+	se = map_sysmem(start_addr, sizeof(struct smbios_entry));
+	memset(se, '\0', sizeof(struct smbios_entry));
+	memcpy(se->anchor, "_SM3_", 5);
+	se->length = sizeof(struct smbios3_entry);
+	se->major_ver = SMBIOS_MAJOR_VER;
+	se->minor_ver = SMBIOS_MINOR_VER;
+	se->doc_rev = 0;
+	se->entry_point_rev = 1;
+	se->max_struct_size = len;
+	se->struct_table_address = table_addr;
+	se->checksum = table_compute_checksum(se, sizeof(struct smbios3_entry));
+	unmap_sysmem(se);
 
 	return addr;
 }
-- 
2.34.1

