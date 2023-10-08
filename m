Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99103E95A8E
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 21:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EACDE86DC7;
	Sun,  8 Oct 2023 23:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jjs/bbxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF7F686C58; Sun,  8 Oct 2023 23:36:58 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D81C86CBD
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 23:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79fa387fb96so176661339f.1
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696801013; x=1697405813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ei8nqNQymusQupy2fZOz+TmEH6+EYZg9DrXenH7ymJk=;
 b=jjs/bbxW/6shuN3eIJnL68+E62L5ibXqh4ObmHDjUK1yv8f/LqhAVwHUW5S/fATuh2
 wjjXH4bcKGt+jjAYftWW+5ABqO3AWAv1MAiGuB2e5QnH/IQArhr1JSND5n5SroM8Iimv
 DFB0xsNO4+t52ZfWcF3BGh8bvRjqcZHKndnPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696801013; x=1697405813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ei8nqNQymusQupy2fZOz+TmEH6+EYZg9DrXenH7ymJk=;
 b=f3g0tBBGH4kTTTBdG7PmEAWQJ+tm+Xlc99Omx2fCRHpxFl7+KpmzmX3nMKX9XqsGW4
 wA+nlGmTajahVYscbl9uY3LMFBk/yjOnfBkYnPBMUNm6gIm4+L9XZPgZ+UY5nO2xbJ7B
 OiX0L6KaM3YAJEBfIVpDRc+QkTsGPf4nhRcK6ZM7MrswGRZQARumhbtD2fg8tr5dFAsC
 BbJl2UDecOWyl1bKdmQwr/WVM+jcwUVV83Gp8qrjh3ifgaDBvBGgrbjnleojFrvFE2cZ
 omO7a3Ev+QUxcF0HPkze2aQ9NtIBLkqqhaCeHqOYBmL9+6X4lY2FG1pftJ9YmZfP7gbm
 lD5Q==
X-Gm-Message-State: AOJu0YxmPjWCLfO1M+FKTaFrkftMBFrZo7tML6k6OEqYHVqqha4tVtlv
 aOPZqv53OvFv2Tel9wE/Kloucb84+tZzETUhfUY=
X-Google-Smtp-Source: AGHT+IF7a0pdGVDvOiN+ZmB7XPh7oMOGGcF68GaY6TLpot4n+06m3lpLNMzB+WEjljZUI0qA9BIx5A==
X-Received: by 2002:a5e:8919:0:b0:787:34d:f1ea with SMTP id
 k25-20020a5e8919000000b00787034df1eamr15988743ioj.8.1696801012818; 
 Sun, 08 Oct 2023 14:36:52 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 f12-20020a02cacc000000b00430bb70004dsm1751826jap.103.2023.10.08.14.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 14:36:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/5] smbios: Use SMBIOS 3.0 to support an address above 4GB
Date: Sun,  8 Oct 2023 15:36:42 -0600
Message-ID: <20231008213646.622002-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231008213646.622002-1-sjg@chromium.org>
References: <20231008213646.622002-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/smbios.h | 22 +++++++++++++++++++++-
 lib/smbios.c     | 22 ++++++++++++++++++----
 2 files changed, 39 insertions(+), 5 deletions(-)

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
index c7a557bc9b7b..82e259f31791 100644
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
 
@@ -513,13 +517,23 @@ ulong write_smbios_table(ulong addr)
 	 */
 	table_addr = (ulong)map_sysmem(tables, 0);
 	if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulong)UINT_MAX) {
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
2.42.0.609.gbb76f46606-goog

