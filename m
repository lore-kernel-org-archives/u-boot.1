Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D8BC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 20:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE6C384A77;
	Wed,  8 Jul 2026 22:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ttJYLMhF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E3684A85; Wed,  8 Jul 2026 22:37:38 +0200 (CEST)
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E03A843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 22:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783543053; x=1783802253;
 bh=0M2fBsCDrHWAkeO7/cWIvpvR/SM/yTgldq81TRYE0Ns=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ttJYLMhFivo/tIpJFDy30oo4UwJaE9AQ39RHzg5YfpqK4MSJYNFE/ffuzAw3vn5wM
 4cQ1pBiA19V8XrvnVJeJ7hvAAJAwuP1IF7NdElaA0WEjPWoJQT8MJib7+D7HSBaJQ7
 bYCbEXywOxIlOu8FmSWKInbSoktc+6juoWhYRki8+gV+JyzUtUvyE4AyGmk8IrA1by
 bWEftLDPJqU78WHNq889lU1G9qIHcy37RbcH75LwQXoZ0C5De8yVUxjg7VqWuTB8Fj
 xPX978YOotX4lGrHVFmCDIHiw30FyS1BkFgeIc6XPuInI1/cZ5yskFbm7iDAiyR7jJ
 /+Qs4tBYZ8ZSw==
X-Pm-Submission-Id: 4gwVJm3zWrz1DFGQ
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 06/10] string: add strcasestr()
Date: Wed,  8 Jul 2026 22:37:07 +0200
Message-ID: <20260708203711.849489-7-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
References: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
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

While this is not likely needed by any "real" driver code, a later
convenience addition to the "config" command will need this. As usual,
the linker will throw it away if nothing actually uses it, so it
should have no size impact when not used.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 include/linux/string.h |  1 +
 lib/string.c           | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 5e4594b19df..986499dfc70 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -71,6 +71,7 @@ extern char * strstr(const char *,const char *);
 #ifndef __HAVE_ARCH_STRNSTR
 extern char *strnstr(const char *, const char *, size_t);
 #endif
+char *strcasestr(const char *, const char *);
 #ifndef __HAVE_ARCH_STRLEN
 extern __kernel_size_t strlen(const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 20c934c18c3..dbf2ce340df 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -701,6 +701,33 @@ char *strstr(const char *s1, const char *s2)
 }
 #endif
 
+/**
+ * strcasestr() - Case insensitive substring search
+ *
+ * @haystack:	string to be searched
+ * @needle:	string to search for
+ *
+ * Return:	pointer to the first occurrence or NULL
+ *
+ * The case of both strings are ignored.
+ */
+char *strcasestr(const char *haystack, const char *needle)
+{
+	size_t l1, l2;
+
+	l1 = strlen(haystack);
+	l2 = strlen(needle);
+
+	while (l1 >= l2) {
+		if (!strncasecmp(haystack, needle, l2))
+			return (char *)haystack;
+		haystack++;
+		l1--;
+	}
+
+	return NULL;
+}
+
 #ifndef __HAVE_ARCH_MEMCHR
 /**
  * memchr - Find a character in an area of memory.
-- 
2.55.0

