Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02A3C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0953184C33;
	Wed,  1 Jul 2026 19:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Eqy0KCHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 234ED84C33; Wed,  1 Jul 2026 19:15:54 +0200 (CEST)
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E10484BC8
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1782926151; x=1783185351;
 bh=1NcOXsXXbKIJgs7TJ7X0Pmm1mHbhhR2a4/ksymOFFR0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Eqy0KCHYaoYyKQebULMQisdGcdNXiR/CsipqC8P/ceGDplMFvYde0w8CJ8V7UJSI6
 3y72uBIFTdvHyIjgEKk7p5mO88t0Nqme06aXf/o5fYsQXZK57FEFe7QPpGTnhAGmTq
 hZuF3i4SwVONjZojMM/JBZrFqxR1Sk7mRnS6kB2HHyR1xu/ZZ75D4TG1XY6k9FxXNz
 T4AJHmuC5fybg5FM2TBMytsR20oE2LOSU86DKlYbWKu/vDGWNqg0X9niOjVi2TJsoW
 LgaVbsMh1L0SxgU0hem3msjT8qp2jpsCrJWc6y7OLcRcukNfEIa6XTmV4YeiGRgRyG
 K+K18+NcgA2Ag==
X-Pm-Submission-Id: 4gr69K6s9kz1DDny
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 4/8] string: remove unused strswab() function
Date: Wed,  1 Jul 2026 19:15:31 +0200
Message-ID: <20260701171535.906272-5-rv@rasmusvillemoes.dk>
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

The last use of this function with rather peculiar semantics[*] vanished
in 2021 with 0a527fda782 ("Fix IDE commands issued, fix endian issues,
fix non MMIO"). It has no tests, and should a need for something
similar ever appear, it is better done with some proper
utf16le/utf16be/utf16 abstractions rather than cluttering code with
'#ifdef __LITTLE_ENDIAN'.

[*] The byte-swapping itself is weird enough. But why is an input string
of odd length ok, while the empty string is not allowed?

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
2.54.0

