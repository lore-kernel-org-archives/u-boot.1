Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711C5C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 20:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52BB084A12;
	Wed,  8 Jul 2026 22:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Rou2dbk4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 381D784A51; Wed,  8 Jul 2026 22:37:26 +0200 (CEST)
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4A508496E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 22:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783543039; x=1783802239;
 bh=wfPaxdhMgu6ngSXG05iNg5pj0ZEadvu4Su5WcEC4TgU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Rou2dbk4INqP8kvfDu6Mbmkc7TbyjS7K3YYB0iTQtq+c3nVuuwb535nyqo+nEiAc5
 Ija64DSba8y37aGuvx07XciGtd7NR1HXHSTEVEowqdi7CNbJt+PozXobOTw7Il3S77
 rvOwWYrqxvtLIrJHG1XANHGgJ5fdgIbqDWkEkgtboIwZtYC1zNof81d+xfc6u9UYUt
 bIK5EmYx8AV4kz554k/mlFtH1eIuDmtkHtUAo7DHTmNkmzIU6w27C/mS9VrYnTqaq/
 bW/epgC59uQR5CVMmMhZ4zACPL+kzMLhTB+sezRQ/BjTEy3mTg4PkK9kUk4c4pKviq
 8QPstvZbvEV1Q==
X-Pm-Submission-Id: 4gwVJZ1VDjz2ScND
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 01/10] sh: clean up asm/string.h
Date: Wed,  8 Jul 2026 22:37:02 +0200
Message-ID: <20260708203711.849489-2-rv@rasmusvillemoes.dk>
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

First, remove the !__KERNEL__ block, since U-Boot is always compiled
with -D__KERNEL__.

Second, remove the mention of the non-existing file
arch/sh/lib/strcasecmp.c and the redundant declaration of strcasecmp()
If sh did have a strcasecmp.c file, presumably the header would have
had to #define __HAVE_ARCH_STRCASECMP.

Third, remove the explicit #undefs of various __HAVE_ARCH_* and
redundant declarations of standard functions, which are anyway
declared in linux/string.h. In the linux source tree, those are all
#defines, and indeed linux does have asm implementations of those functions.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 arch/sh/include/asm/string.h | 51 ------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/arch/sh/include/asm/string.h b/arch/sh/include/asm/string.h
index 999febcb6b7..12a9a8f796c 100644
--- a/arch/sh/include/asm/string.h
+++ b/arch/sh/include/asm/string.h
@@ -8,8 +8,6 @@
  * from linux kernel code.
  */
 
-#ifdef __KERNEL__               /* only set these up for kernel code */
-
 #define __HAVE_ARCH_STRCPY
 static inline char *strcpy(char *__dest, const char *__src)
 {
@@ -81,53 +79,4 @@ static inline int strcmp(const char *__cs, const char *__ct)
 	return __res;
 }
 
-#undef __HAVE_ARCH_STRNCMP
-extern int strncmp(const char *__cs, const char *__ct, size_t __n);
-
-#undef __HAVE_ARCH_MEMSET
-extern void *memset(void *__s, int __c, size_t __count);
-
-#undef __HAVE_ARCH_MEMCPY
-extern void *memcpy(void *__to, __const__ void *__from, size_t __n);
-
-#undef __HAVE_ARCH_MEMMOVE
-extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
-
-#undef __HAVE_ARCH_MEMCHR
-extern void *memchr(const void *__s, int __c, size_t __n);
-
-#undef __HAVE_ARCH_STRLEN
-extern size_t strlen(const char *);
-
-/* arch/sh/lib/strcasecmp.c */
-extern int strcasecmp(const char *, const char *);
-
-#else                           /* KERNEL */
-
-/*
- * let user libraries deal with these,
- * IMHO the kernel has no place defining these functions for user apps
- */
-
-#define __HAVE_ARCH_STRCPY      1
-#define __HAVE_ARCH_STRNCPY     1
-#define __HAVE_ARCH_STRCAT      1
-#define __HAVE_ARCH_STRNCAT     1
-#define __HAVE_ARCH_STRCMP      1
-#define __HAVE_ARCH_STRNCMP     1
-#define __HAVE_ARCH_STRNICMP    1
-#define __HAVE_ARCH_STRCHR      1
-#define __HAVE_ARCH_STRRCHR     1
-#define __HAVE_ARCH_STRSTR      1
-#define __HAVE_ARCH_STRLEN      1
-#define __HAVE_ARCH_STRNLEN     1
-#define __HAVE_ARCH_MEMSET      1
-#define __HAVE_ARCH_MEMCPY      1
-#define __HAVE_ARCH_MEMMOVE     1
-#define __HAVE_ARCH_MEMSCAN     1
-#define __HAVE_ARCH_MEMCMP      1
-#define __HAVE_ARCH_MEMCHR      1
-#define __HAVE_ARCH_STRTOK      1
-
-#endif /* KERNEL */
 #endif /* __ASM_SH_STRING_H */
-- 
2.55.0

