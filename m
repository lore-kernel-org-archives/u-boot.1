Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8D6CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E177884855;
	Fri, 15 May 2026 22:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nI+a2GrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 152D58484C; Fri, 15 May 2026 22:33:40 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9C948483C
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-47c7b282d73so239059b6e.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778877216; x=1779482016; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zN3MWntbeEZcytCfgZdOhCe/QkEj+wrxLXJC67jKFfQ=;
 b=nI+a2GrWXgtSu1XHwCdJuCZ+z+lhDLIZpc93c1BKnockmjdcrfUBAs1mB/kHiRVz0O
 //oRdI6uoJuOCwH4dziOTH2WYDFGUwCVv+xb4DYi+Obj9CQcxq12orrfKE5dTOAew5jP
 TmoEu8oD+B3qqOnhls8704iW9SX7AexkpvcNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778877216; x=1779482016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zN3MWntbeEZcytCfgZdOhCe/QkEj+wrxLXJC67jKFfQ=;
 b=dcRqUk/i/MzHlEy6Ydcm3/KMLJqMddRblKLvcvPn0lLObjuBkcbVCKNDdu7pf99FbU
 YuLq1PvkiU/PfxC3sXDZrUTHtMwB5J2zAfNjNofD0CohJxWs8QK/zWoiU/kNhX3WuE4y
 Ts5hIHP7t08KPyrnSoebqf+pEKwcVQxXGnHxDVL7+0w9qsCSAaWzhGaNutDn206l76dk
 38gPeOyw+hTcuiK0CPmzkBdZFYhJSer8cRODO7sT8Eg9HqFpAQeh5VGHYTVjqzICzoBp
 evt5wDVCPz9VktSijiCtAQXMgUZO5kYbAnVCVQhm5y4gyz1Uv5hDdEjwUWUQSPRykUOQ
 AXlw==
X-Gm-Message-State: AOJu0YwiBmZgUon5xa4tk6yfeRxIy93AKZ5d5uuesiaveaqCmcrAX8LY
 g6RpwyLP7GpSHoBgr8Y9+f4tkxhWkamjKvteQdNm6f6WIyeDjUScvZos9MhG3PDSISBsQJ6KLVv
 6I4+YUQ==
X-Gm-Gg: Acq92OH8nc5B/azo/SmvCsbQEzX2B7rV4eqiLMHZWj4f6iz+48E4Glbsw+ZV8+gI39P
 EMdQAKxGuizdF18FfvdhrT51x4diUkyeXhFWWWgfVIHvko2lRFRJ/IvxtrTi/ntp34JuQ7SBtlf
 mNTV+i6I5lvFRTO3GU45i9pzBVPUV70R7DuYgi2m27FYKhev8CefS28jAbAeFyb3jLx9vd5/VY9
 Nzo9HvFjAadzRIjzLTU+HHRIxvPmP773LYyAgf5MdUzNWtP1T9AcEjuEmImJtcdE+bCtT/5DOxx
 lJPek+dsAv9Dx6498tByGFlgR82AZFN+B80IMtpLE4PMzjJNhZqKtqLmT53I7H2nuwgRO3CtLu4
 C0ha7PqOxKyXDcZsip8BJi/Pk1Uj/CY9oFRlEliJmn5DaWfZHbe4jY05pfdOoUP+eOmLCmbVnbK
 iP+F8VJkl7LxrJxtOSk0gtJTecAfNR
X-Received: by 2002:a05:6808:bc7:b0:47c:7c7c:c792 with SMTP id
 5614622812f47-482e5710ad1mr3475890b6e.7.1778877215855; 
 Fri, 15 May 2026 13:33:35 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm2414906a34.12.2026.05.15.13.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:33:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>,
 Daniel Palmer <daniel@thingy.jp>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [RFC PATCH 03/11] fs: fat: Use strlower() to normalise case
Date: Fri, 15 May 2026 14:32:54 -0600
Message-ID: <20260515203311.2555651-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515203311.2555651-1-sjg@chromium.org>
References: <20260515203311.2555651-1-sjg@chromium.org>
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

Drop the local downcase() helper. The two get_name() call sites
operate on buffers that are NUL-terminated before the lowercase
pass, and the trailing FAT-name padding is spaces which tolower()
leaves untouched, so strlower() gives the same result without
needing an explicit length.

Move the 'ptr[3] = '\0'' assignment in get_name() to before the
extension is lowercased so strlower() sees a terminated string.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 fs/fat/fat.c       | 20 ++++----------------
 fs/fat/fat_write.c |  2 +-
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index c1ccf30771a..dd328f948fb 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -26,23 +26,11 @@
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/log2.h>
+#include <linux/string.h>
 
 /* maximum number of clusters for FAT12 */
 #define MAX_FAT12	0xFF4
 
-/*
- * Convert a string to lowercase.  Converts at most 'len' characters,
- * 'len' may be larger than the length of 'str' if 'str' is NULL
- * terminated.
- */
-static void downcase(char *str, size_t len)
-{
-	while (*str != '\0' && len--) {
-		*str = tolower(*str);
-		str++;
-	}
-}
-
 static struct blk_desc *cur_dev;
 static struct disk_partition cur_part_info;
 static int fat_sect_size;
@@ -270,13 +258,13 @@ static void get_name(dir_entry *dirent, char *s_name)
 	while (*ptr && *ptr != ' ')
 		ptr++;
 	if (dirent->lcase & CASE_LOWER_BASE)
-		downcase(s_name, (unsigned)(ptr - s_name));
+		strlower(s_name);
 	if (dirent->nameext.ext[0] && dirent->nameext.ext[0] != ' ') {
 		*ptr++ = '.';
 		memcpy(ptr, dirent->nameext.ext, 3);
-		if (dirent->lcase & CASE_LOWER_EXT)
-			downcase(ptr, 3);
 		ptr[3] = '\0';
+		if (dirent->lcase & CASE_LOWER_EXT)
+			strlower(ptr);
 		while (*ptr && *ptr != ' ')
 			ptr++;
 	}
diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index c98b530f747..ea8d301514c 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -1464,7 +1464,7 @@ static int normalize_longname(char *l_filename, const char *filename)
 	}
 
 	strcpy(l_filename, filename);
-	downcase(l_filename, VFAT_MAXLEN_BYTES);
+	strlower(l_filename);
 
 	return 0;
 }
-- 
2.43.0

