Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA3BCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3693E84894;
	Wed, 20 May 2026 01:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iryOXg6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A084848AA; Wed, 20 May 2026 01:32:39 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 176D78483C
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7df05fc49e5so4412762a34.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233554; x=1779838354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCgi+t3fFz3mbA1IFZQfO6U01+0OYKlD5L+9VJ/j3Eo=;
 b=iryOXg6qAL6rghqOgD1glGGHTNRr0gbqn8ZpocBjYWsygpzOuzf7G73a+3C19yBrCC
 icoHhALIGirNvIxupPNjnT53+33iChzwtgqLcsAxvKPur9Xb9XIs47n0Y45EwckMWhct
 AlWh/zwafoc2hnYA1Wi1xBsUN9TyGPXk9blyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233554; x=1779838354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FCgi+t3fFz3mbA1IFZQfO6U01+0OYKlD5L+9VJ/j3Eo=;
 b=PoMLVfoXgklKvY0mrm6XXPyr0WuLBKMKzDlnT1b8XisB+a4v25XszYQTM1Juo127hL
 3a7ijU496GQbxAsHY7d+XoJ5yLzzpupC22DAvHB1MDjc6INdDkY8rSQ8lm5GdDQpxm/+
 y1mFHEE8jxMpi6ueFLA8ianLXSJITq6HP7Ldeh6Oeh0jSF1wfaBzHuhnyKo6sQRo0zID
 e3QMFD2FTFuzifnInYOb6P+RMmntl6EJ6jWxxz1srjoYyJF+/NXDdgC9bCVlhL+BACnO
 /WrkmliiLIF6EhCR+ELJk05TrZ8Ge2tU/IxsRxbY9oU2zPDHK9Vfc+nwZ8lWzsubLaiJ
 uwzg==
X-Gm-Message-State: AOJu0YxuJsxSyU6grUO5c3jbTvVOm52rTppM2VMqosejCZVQ2qzwHuPN
 Fk9b7U7erywmqiKOj2CEk/LHwwrcjw6uwkg+nny5AV+ioKbgtygAO3kSYwCO0UvnlNNNSNodhZx
 jR4nGBJGr
X-Gm-Gg: Acq92OE0fDZm+uYng8mgg0fvME33jcblSsHUPu+LpUAtWPXC5Waqa7RGXBwFJZzf99A
 MF7gfY4q+e8C3QM7A/KiPqBQO1W6QIpy+UrIRbpfeK/dc7umye54doNnFOzJyM/aoEbdvs73+sS
 j4BJY1YjVi9T/OrPP3Qhz3vB5nXIW4YtEiegRM/umUkFbuNRCJCfNST1buoveV8i0opZokDJGiu
 j11llKzvzx22GIxaLhLCWNOqlZM8JlIYaTniL7KwQWBfMdaGNaGIAhm1EOZnU7+MuJuC/oEr9yl
 19YjdEw5D+hBjCtKq5qry9uFrkmful2mrCpVyyqrTtRRDYClhKHrA5bSHV9qUku6Ma3S2DN7LU8
 REWzWJugJLhgbUw36BlcB5n/uwltKrHs0Esk6luTXb0UUeiqPuAVoP1Y5nS4HpzIXtdz1ZTylDM
 jSRmP4J4cysQlpsInl8g==
X-Received: by 2002:a05:6820:190a:b0:696:6bc7:696 with SMTP id
 006d021491bc7-69c942d61b3mr14809668eaf.14.1779233554403; 
 Tue, 19 May 2026 16:32:34 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>,
 Daniel Palmer <daniel@thingy.jp>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [RFC PATCH v2 03/17] fs: fat: Use strlower() to normalise case
Date: Tue, 19 May 2026 17:31:29 -0600
Message-ID: <20260519233207.2765755-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519233207.2765755-1-sjg@chromium.org>
References: <20260519233207.2765755-1-sjg@chromium.org>
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

(no changes since v1)

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

