Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62E9C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 20:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC3584A8D;
	Wed,  8 Jul 2026 22:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="lgpJcDtT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA17084A77; Wed,  8 Jul 2026 22:37:35 +0200 (CEST)
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch
 [109.224.244.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFC684A6F
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 22:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783543045; x=1783802245;
 bh=NUjgMtnyzCZT98JYalidQLM43Uts79bogqvMqUwq9uM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=lgpJcDtTr42STwcLf6CmSEjhUrnwHamaBDO73onOB0HmVTsgf5AhI3C6pnmGDJwXj
 tUScRNN4cAxyEAN8/SZuaB4RXYPp2zf2thxR3PHOZmCkj6WV5cfl1P2aWMWPfDz+i7
 jE6ucIevyNBCaS9Cz7+9pt5hAfU/uOpDSiRYEVvY87aJozdcklr+TbatqqfB8UBUyb
 bikd4DMGj3i7TkXMG7t9gBcJ09snoLrSVBeiHF3Ei9Pf3CVW85pukvHi3+JpODNO2S
 oZvbaMNP7i6Dbzp60Q2SL3Y+SIYSqkbkQZ0hrCqrYespDHSxu5oSQNMcTKD70uVxtJ
 DVQWWtUsx2XsQ==
X-Pm-Submission-Id: 4gwVJh4Jyfz1DFGQ
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 04/10] string: remove unused strswab() function
Date: Wed,  8 Jul 2026 22:37:05 +0200
Message-ID: <20260708203711.849489-5-rv@rasmusvillemoes.dk>
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

The last use of this function with rather peculiar semantics[*] vanished
in 2021 with 0a527fda782 ("Fix IDE commands issued, fix endian issues,
fix non MMIO"). It has no tests, and should a need for something
similar ever appear, it is better done with some proper
utf16le/utf16be/utf16 abstractions rather than cluttering code with
'#ifdef __LITTLE_ENDIAN'.

[*] The byte-swapping itself is weird enough. But why is an input string
of odd length ok, while the empty string is not allowed?

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 include/linux/string.h |  4 ----
 lib/string.c           | 28 ----------------------------
 2 files changed, 32 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 488a459ed99..5bcbf72a89b 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -107,10 +107,6 @@ extern char * strndup(const char *, size_t);
 extern const char *strdup_const(const char *s);
 extern void kfree_const(const void *x);
 
-#ifndef __HAVE_ARCH_STRSWAB
-extern char * strswab(const char *);
-#endif
-
 #ifndef __HAVE_ARCH_MEMSET
 extern void * memset(void *,int,__kernel_size_t);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 45f0f5f8d09..82d0b6a9caa 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -503,34 +503,6 @@ char * strsep(char **s, const char *ct)
 }
 #endif
 
-#ifndef __HAVE_ARCH_STRSWAB
-/**
- * strswab - swap adjacent even and odd bytes in %NUL-terminated string
- * s: address of the string
- *
- * returns the address of the swapped string or NULL on error. If
- * string length is odd, last byte is untouched.
- */
-char *strswab(const char *s)
-{
-	char *p, *q;
-
-	if ((NULL == s) || ('\0' == *s)) {
-		return (NULL);
-	}
-
-	for (p=(char *)s, q=p+1; (*p != '\0') && (*q != '\0'); p+=2, q+=2) {
-		char  tmp;
-
-		tmp = *p;
-		*p  = *q;
-		*q  = tmp;
-	}
-
-	return (char *) s;
-}
-#endif
-
 #ifndef __HAVE_ARCH_MEMSET
 /**
  * memset - Fill a region of memory with the given value
-- 
2.55.0

