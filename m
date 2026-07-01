Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358ECC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B56A084C40;
	Wed,  1 Jul 2026 19:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="x9rPonqj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FDDF84C40; Wed,  1 Jul 2026 19:15:58 +0200 (CEST)
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E30B84C32
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1782926155; x=1783185355;
 bh=D1+41kul+Srrumddu3cL2Z59Vkzw4dko9WcN9L6yJDE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=x9rPonqjDDm2izo2TMxwMEM84mZzeHSacHDF3IhnuP7FrUl6f64RtPE6wTmQL45Af
 zWFd90GeXa/5m0Ww5IohMOTmwZo3Wt17vExFsDj+/7WrZPxFuXvtw4Niqovm4k2Obh
 Rif0SOgQgsD988mQ9xjLwD5xGTgu2rhJXthvC0mZcfC84B+tywxZogr08TPY98lW4l
 MuiVCUYP9ikV4RX/3KeUmA4gvkSvFz8OajNv7lS/25bDRuxuW49XyjMYRO90Yk9Q/q
 jG/7OfIKQPbkWbl5+qi2Sj1nfJn85YpI26Ba79gSsL79PLg5/X4Mrtik+2qbSfevhE
 vv/El8NVnL3lw==
X-Pm-Submission-Id: 4gr69P6VhHz2Sd56
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 6/8] string: add strcasestr()
Date: Wed,  1 Jul 2026 19:15:33 +0200
Message-ID: <20260701171535.906272-7-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
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

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 include/linux/string.h |  1 +
 lib/string.c           | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 5e4594b19df..93aa4cada66 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -77,6 +77,7 @@ extern __kernel_size_t strlen(const char *);
 #ifndef __HAVE_ARCH_STRNLEN
 extern __kernel_size_t strnlen(const char *,__kernel_size_t);
 #endif
+char *strcasestr(const char *, const char *);
 
 #ifndef __HAVE_ARCH_STRCSPN
 /**
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
2.54.0

