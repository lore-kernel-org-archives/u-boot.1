Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262A5C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9296F84C25;
	Wed,  1 Jul 2026 19:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="0jKcaUSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8EFE84C23; Wed,  1 Jul 2026 19:15:49 +0200 (CEST)
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E26B584C11
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1782926146; x=1783185346;
 bh=JgApEbPoh9RykDZKALiFJ/aPceK5WEK6ruDUmT0Hl80=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=0jKcaUSHe2UJRGDXafdG12sMPgkt072YZLz36I8ZalmX6gZts54JYWfD5Xj+7Nvp/
 CWPyi2LPJcCiPZX36P7i9VbVpFXeZdPrOjNUj43TzcilxSM0TQlsmIvKIywsI2gio3
 XtqRejcIt/HfmY1Pg/3oF1JPm20MNVOCy+c7HJ/Ys2DQ7d54QujSJ/ADnU0R2hcj9/
 v2gRYH2/hvzALwlBmIehVBU+X9toY3JvAfNSCLjuUeEFS9WzMzpFtTFGENLqVQaCvZ
 hj2ONmka+NwFdEtJsLmjUefh6MXRCzHUrg0NHtkhLcp8ibbkgAvgj0YB++/HRs46SB
 1Vt4eol3IWXKQ==
X-Pm-Submission-Id: 4gr69D4Cv8z1DDrB
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 2/8] string: correct prototype of strchrnul()
Date: Wed,  1 Jul 2026 19:15:29 +0200
Message-ID: <20260701171535.906272-3-rv@rasmusvillemoes.dk>
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

Both glibc's (where this originated as a GNU extension) and the
kernel's versions of strchrnul() return "char *", not "const
char *". That also makes it consistent with the standard strchr()
function.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 include/linux/string.h | 2 +-
 lib/string.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 850356d7c3f..488a459ed99 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -63,7 +63,7 @@ extern char * strchr(const char *,int);
  * @c: character to search for
  * Return: position of @c in @s, or end of @s if not found
  */
-const char *strchrnul(const char *s, int c);
+char *strchrnul(const char *s, int c);
 
 #ifndef __HAVE_ARCH_STRRCHR
 extern char * strrchr(const char *,int);
diff --git a/lib/string.c b/lib/string.c
index 37ea8c29561..a76dcd48d20 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -263,12 +263,12 @@ char * strchr(const char * s, int c)
 }
 #endif
 
-const char *strchrnul(const char *s, int c)
+char *strchrnul(const char *s, int c)
 {
 	for (; *s != (char)c; ++s)
 		if (*s == '\0')
 			break;
-	return s;
+	return (char *)s;
 }
 
 #ifndef __HAVE_ARCH_STRRCHR
-- 
2.54.0

