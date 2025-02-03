Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707CFC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A28F2807A7;
	Mon,  3 Feb 2025 10:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mGOSVXsi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1957480763; Mon,  3 Feb 2025 10:12:13 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E8B8806DC
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-108-254.46.114.pool.telefonica.de
 [46.114.108.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 13AC841EB8; 
 Mon,  3 Feb 2025 09:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738573929;
 bh=hoiD4vRj3BW6PLcbRtUFb7+KQ3id1YCT3x41wpxRz5o=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=mGOSVXsij2c1qhkM7ivr4Q8RW8xe7Se3uHu92wUuyhtDtA8Cw9Buaul12xcQhwLAD
 AvKe4HvLMiDelNPZ8pVzjjqsNl2urTQ0sveIN88lSsS90dG5Tc4JqdF8SJx0mCLWRE
 pBjb0/GAbHxzHAzuHIf+mfXv0M91vAwbkAogJvvcFP5MSwooMjRMBuHXdKZN80ltuz
 kXu7ODoGMGsuh6qs2N3pxXfok3aRH//nUY/tl9cpj2X7vwjMm3WcW9bmXGPzrOC9cb
 pRKR+tcGGs2LufnLMRnGNdgB1hz+sDGqRiiUdYXn8X2+qfZwTm3usvLH/kK1gHv6Ci
 edhsjVJ1cX6fg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 2/4] lib: implement strnstr()
Date: Mon,  3 Feb 2025 10:12:00 +0100
Message-ID: <20250203091203.47590-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250203091203.47590-1-heinrich.schuchardt@canonical.com>
References: <20250203091203.47590-1-heinrich.schuchardt@canonical.com>
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

Implement library function strnstr().
Implement strstr() using strnstr().
Sort the includes.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	no change
v2:
	no change
---
 include/linux/string.h |  3 +++
 lib/string.c           | 49 +++++++++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 27b2beb9ddb..d943fcce690 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -72,6 +72,9 @@ extern char * strrchr(const char *,int);
 #ifndef __HAVE_ARCH_STRSTR
 extern char * strstr(const char *,const char *);
 #endif
+#ifndef __HAVE_ARCH_STRNSTR
+extern char *strnstr(const char *, const char *, size_t);
+#endif
 #ifndef __HAVE_ARCH_STRLEN
 extern __kernel_size_t strlen(const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index feae9519f2f..691c9985692 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -16,11 +16,12 @@
  */
 
 #include <config.h>
+#include <malloc.h>
+#include <stdint.h>
 #include <linux/compiler.h>
+#include <linux/ctype.h>
 #include <linux/types.h>
 #include <linux/string.h>
-#include <linux/ctype.h>
-#include <malloc.h>
 
 /**
  * strncasecmp - Case insensitive, length-limited string comparison
@@ -678,30 +679,48 @@ char *memdup(const void *src, size_t len)
 	return p;
 }
 
-#ifndef __HAVE_ARCH_STRSTR
+#ifndef __HAVE_ARCH_STRNSTR
 /**
- * strstr - Find the first substring in a %NUL terminated string
- * @s1: The string to be searched
- * @s2: The string to search for
+ * strnstr() - find the first substring occurrence in a NUL terminated string
+ *
+ * @s1:		string to be searched
+ * @s2:		string to search for
+ * @len:	maximum number of characters in s2 to consider
+ *
+ * Return:	pointer to the first occurrence or NULL
  */
-char * strstr(const char * s1,const char * s2)
+char *strnstr(const char *s1, const char *s2, size_t len)
 {
-	int l1, l2;
+	size_t l1, l2;
 
+	l1 = strnlen(s1, len);
 	l2 = strlen(s2);
-	if (!l2)
-		return (char *) s1;
-	l1 = strlen(s1);
-	while (l1 >= l2) {
-		l1--;
-		if (!memcmp(s1,s2,l2))
+
+	for (; l1 >= l2; --l1, ++s1) {
+		if (!memcmp(s1, s2, l2))
 			return (char *) s1;
-		s1++;
 	}
+
 	return NULL;
 }
 #endif
 
+#ifndef __HAVE_ARCH_STRSTR
+/**
+ * strstr() - find the first substring occurrence in a NUL terminated string
+ *
+ * @s1:		string to be searched
+ * @s2:		string to search for
+ * @len:	maximum number of characters in s2 to consider
+ *
+ * Return:	pointer to the first occurrence or NULL
+ */
+char *strstr(const char *s1, const char *s2)
+{
+	return strnstr(s1, s2, SIZE_MAX);
+}
+#endif
+
 #ifndef __HAVE_ARCH_MEMCHR
 /**
  * memchr - Find a character in an area of memory.
-- 
2.47.1

