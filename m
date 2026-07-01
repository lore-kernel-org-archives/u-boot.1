Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAF9C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7573B84C3D;
	Wed,  1 Jul 2026 19:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="FYJ3AEXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47E9484C39; Wed,  1 Jul 2026 19:15:56 +0200 (CEST)
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 614B484BC8
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1782926153; x=1783185353;
 bh=G2eayZZtVodjsRrb0fkv9d9npnwCdiQ6SV8SC439unc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=FYJ3AEXM/BDZBZ5MbodaNdueXmR7J/C024+rL5wp27mMTph8bu9y9sqwI9gqK2b+M
 OBF/HJI6XE9gQqI2LW3s+42BLoBYYOwX/MDsr5qBA2qrUvp8I8c4CEjCIikK8krdCS
 /Oh7xxU9p07T1f+83JpCa41p8LJyMtjtRxsnpUjS8USFdpiPmcMTnfg5pjzIditxbL
 sSVuddSB7jyI5KreEjdPOiYlzm9eXM+aWkMurkyTr6Hp0v52Fe8zk+9Rt4RrBjQ1tK
 C37ZP35oarSM9EoSQt5Aat9yO55W+cbf8UGdrasHvYw2t8qcAfpAZkhf+Ej+lUDPUY
 gMBzWeCUSaDFA==
X-Pm-Submission-Id: 4gr69M4Nyvz2Sd55
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 5/8] string: remove more pointless __HAVE_ARCH_STR*
Date: Wed,  1 Jul 2026 19:15:32 +0200
Message-ID: <20260701171535.906272-6-rv@rasmusvillemoes.dk>
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

None of these six macros are defined by any architecture. Moreover,
the ifndef guard only exists in either string.h or string.c, making them
completely pointless.

I'm not sure whether we have an explicit coding style discouraging the
"extern" qualifier on function declarations, and string.h has a random
mix of everything, but I can't leave it on strncasecmp() now that it
will be immediately after strcasecmp() which doesn't have it.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 include/linux/string.h | 6 +-----
 lib/string.c           | 8 --------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 5bcbf72a89b..5e4594b19df 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -43,12 +43,8 @@ extern int strcmp(const char *,const char *);
 #ifndef __HAVE_ARCH_STRNCMP
 extern int strncmp(const char *,const char *,__kernel_size_t);
 #endif
-#ifndef __HAVE_ARCH_STRCASECMP
 int strcasecmp(const char *s1, const char *s2);
-#endif
-#ifndef __HAVE_ARCH_STRNCASECMP
-extern int strncasecmp(const char *s1, const char *s2, __kernel_size_t len);
-#endif
+int strncasecmp(const char *s1, const char *s2, __kernel_size_t len);
 #ifndef __HAVE_ARCH_STRCHR
 extern char * strchr(const char *,int);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 82d0b6a9caa..20c934c18c3 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -399,7 +399,6 @@ void kfree_const(const void *x)
 }
 
 
-#ifndef __HAVE_ARCH_STRSPN
 /**
  * strspn - Calculate the length of the initial substring of @s which only
  *	contain letters in @accept
@@ -424,9 +423,7 @@ size_t strspn(const char *s, const char *accept)
 
 	return count;
 }
-#endif
 
-#ifndef __HAVE_ARCH_STRPBRK
 /**
  * strpbrk - Find the first occurrence of a set of characters
  * @cs: The string to be searched
@@ -444,9 +441,7 @@ char * strpbrk(const char * cs,const char * ct)
 	}
 	return NULL;
 }
-#endif
 
-#ifndef __HAVE_ARCH_STRTOK
 /**
  * strtok - Split a string into tokens
  * @s: The string to be searched
@@ -473,9 +468,7 @@ char * strtok(char * s,const char * ct)
 	___strtok = send;
 	return (sbegin);
 }
-#endif
 
-#ifndef __HAVE_ARCH_STRSEP
 /**
  * strsep - Split a string into tokens
  * @s: The string to be searched
@@ -501,7 +494,6 @@ char * strsep(char **s, const char *ct)
 
 	return sbegin;
 }
-#endif
 
 #ifndef __HAVE_ARCH_MEMSET
 /**
-- 
2.54.0

