Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF132C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 20:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94EF18496E;
	Wed,  8 Jul 2026 22:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="c8xGuaoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F5E584A67; Wed,  8 Jul 2026 22:37:29 +0200 (CEST)
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A913684A1D
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 22:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783543042; x=1783802242;
 bh=4Hp0omT6Y+mkNUdwYsnMOcDS80uvXfzEwSDCQHxZKfM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=c8xGuaohfVa9tUQJjC+L3cgh6eNUnBomf8BPFx/eCXs8uQzXHaSkqQfbN9oh7rzYr
 BxmJGpgqvezKjx/LdUXKOhdUvkOdNFcoqpJ0qWXVUa50T139/GXSY4uWf06XAxKxo1
 A96m+X/DO/okx0bOHKJRyf1Zm0vJZetAsNSgTsfLN5nEoeB80FGfsZPIEiqJ4jOjMq
 poiChfFO58X2HVlTN14e/cgh2aSvkdTQtrPZmDs/EHxLBAo8tzRaMYpcnv76rl6GDC
 1pMbw79onCbt8ORbqYElMd3/bwIH4VweLGkmLGznV1XddMcDIJk1mVaqZ94keAlW++
 gjSeHaAhGASLw==
X-Pm-Submission-Id: 4gwVJd1mcCz1DFTT
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 02/10] string: correct prototype of strchrnul()
Date: Wed,  8 Jul 2026 22:37:03 +0200
Message-ID: <20260708203711.849489-3-rv@rasmusvillemoes.dk>
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

Both glibc's (where this originated as a GNU extension) and the
kernel's versions of strchrnul() return "char *", not "const
char *". That also makes it consistent with the standard strchr()
function.

Reviewed-by: Simon Glass <sjg@chromium.org>
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
2.55.0

