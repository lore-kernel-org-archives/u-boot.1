Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4779ECDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 08:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64AA9849F7;
	Sun, 21 Jun 2026 10:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZhR9/E6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EB4E84844; Sun, 21 Jun 2026 10:19:27 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3593849D2
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 10:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-176-006-085-155.176.6.pool.telefonica.de
 [176.6.85.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 199183F1E4; 
 Sun, 21 Jun 2026 08:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782029963;
 bh=0K6DHjvydbA2QrGWltSXUrShH0wL6InnGwq0duiCxvU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ZhR9/E6PgggzW29nofhqoG7RF0rkMYUW9j+a3Tc1jk/DfOX7dwJSbIDlfG/OLadKr
 dj0APD0T3+f91oA47ZYC+7kOPrWMHnWU2K67N0GEeavftHEgmAykA9CLHOFlkwcDIi
 Pd6WTo+izxQmDGozbs5sjKYfOtpNVGS0wvFIdbu9V3adOH76U01ELaVHkiy7iVuCcy
 00E/E3M/2TWqATHnYmYvWjn7fZa0VIeFyYumo9pzoX4TquK2r/RuEwG400tuED26I9
 1oGQpyh3FrH2hYqqDZDwmKWdMbZeqC4QUgvHgmVcm6hWdOdhqWjLLOHYYQ+oO9w3sf
 qVQs3gKYslIZChf813+pkrlE/RPXyXWXfHfWQJBG3zQ5PN9JXdUfMPNB6Pd/qHGArR
 uXTvEukioGAyDQu2sI4PNiLjknxCT7nANxZ/FT0pWq6sJnj9Z1twTbY/BIpEkK8gsn
 FLKhfz9HzyqStebGecOydizbfuCDaaGXhTSlCZIQI2Ely459DUXvHfxBmVd/5B4+zg
 wRRDmeH3G5vl4JcC/ReAn5CC+n68AHpVzCoW+Q1F3M7vLIj7zoSO3zqXL4Tbnb0Wkj
 pTk/p42rqVnZqhggsJfyy0Nj18icjc6ytqkJioS8/3cNk4oBOvaF6RnRsd2VlIKKQd
 lUDsXq2pSEmWc69DayZT+49k=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 07/11] efi_loader: move string helpers to efi_app_common
Date: Sun, 21 Jun 2026 10:19:11 +0200
Message-ID: <20260621081915.19154-8-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
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

Move the shared string-processing helper to efi_app_common:

* skip_whitespace() - advance past leading whitespace

Remove the now-duplicate static definition from dtbdump, initrddump,
smbiosdump and dbginfodump.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 lib/efi_loader/dbginfodump.c    | 13 -------------
 lib/efi_loader/dtbdump.c        | 13 -------------
 lib/efi_loader/efi_app_common.c |  7 +++++++
 lib/efi_loader/efi_app_common.h |  8 ++++++++
 lib/efi_loader/initrddump.c     | 13 -------------
 lib/efi_loader/smbiosdump.c     | 13 -------------
 6 files changed, 15 insertions(+), 52 deletions(-)

diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
index 8fa60a7f48e..4808fe254fe 100644
--- a/lib/efi_loader/dbginfodump.c
+++ b/lib/efi_loader/dbginfodump.c
@@ -82,19 +82,6 @@ static void printp(void *p)
 	print(str);
 }
 
-/**
- * skip_whitespace() - skip over leading whitespace
- *
- * @pos:	UTF-16 string
- * Return:	pointer to first non-whitespace
- */
-static u16 *skip_whitespace(u16 *pos)
-{
-	for (; *pos && *pos <= 0x20; ++pos)
-		;
-	return pos;
-}
-
 /**
  * do_help() - print help
  */
diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
index 716daf4a90f..559c64be7f7 100644
--- a/lib/efi_loader/dtbdump.c
+++ b/lib/efi_loader/dtbdump.c
@@ -87,19 +87,6 @@ static void *get_dtb(struct efi_system_table *systable)
 	return dtb;
 }
 
-/**
- * skip_whitespace() - skip over leading whitespace
- *
- * @pos:	UTF-16 string
- * Return:	pointer to first non-whitespace
- */
-static u16 *skip_whitespace(u16 *pos)
-{
-	for (; *pos && *pos <= 0x20; ++pos)
-		;
-	return pos;
-}
-
 /**
  * do_help() - print help
  */
diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
index 406cd236f6f..6bd52e08d28 100644
--- a/lib/efi_loader/efi_app_common.c
+++ b/lib/efi_loader/efi_app_common.c
@@ -96,6 +96,13 @@ void error(u16 *string)
 	color(EFI_LIGHTBLUE);
 }
 
+u16 *skip_whitespace(u16 *pos)
+{
+	for (; *pos && *pos <= 0x20; ++pos)
+		;
+	return pos;
+}
+
 bool starts_with(u16 *string, u16 *keyword)
 {
 	if (!string)
diff --git a/lib/efi_loader/efi_app_common.h b/lib/efi_loader/efi_app_common.h
index 4498607ef07..ff37f3413eb 100644
--- a/lib/efi_loader/efi_app_common.h
+++ b/lib/efi_loader/efi_app_common.h
@@ -55,6 +55,14 @@ void cls(void);
  */
 void error(u16 *string);
 
+/**
+ * skip_whitespace() - skip over leading whitespace
+ *
+ * @pos:	UTF-16 string
+ * Return:      pointer to first non-whitespace
+ */
+u16 *skip_whitespace(u16 *pos);
+
 /**
  * starts_with() - check if string starts with keyword
  *
diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
index 52562be048d..0a025c1a841 100644
--- a/lib/efi_loader/initrddump.c
+++ b/lib/efi_loader/initrddump.c
@@ -45,19 +45,6 @@ static const struct efi_lo_dp_prefix initrd_dp = {
 	}
 };
 
-/**
- * skip_whitespace() - skip over leading whitespace
- *
- * @pos:	UTF-16 string
- * Return:	pointer to first non-whitespace
- */
-static u16 *skip_whitespace(u16 *pos)
-{
-	for (; *pos && *pos <= 0x20; ++pos)
-		;
-	return pos;
-}
-
 /**
  * do_help() - print help
  */
diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
index 100e03294e5..351e103fb97 100644
--- a/lib/efi_loader/smbiosdump.c
+++ b/lib/efi_loader/smbiosdump.c
@@ -25,19 +25,6 @@ static const efi_guid_t guid_simple_file_system_protocol =
 					EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
 static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
 
-/**
- * skip_whitespace() - skip over leading whitespace
- *
- * @pos:	UTF-16 string
- * Return:	pointer to first non-whitespace
- */
-static u16 *skip_whitespace(u16 *pos)
-{
-	for (; *pos && *pos <= 0x20; ++pos)
-		;
-	return pos;
-}
-
 /**
  * open_file_system() - open simple file system protocol
  *
-- 
2.53.0

