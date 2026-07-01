Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9946EC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C849384C23;
	Wed,  1 Jul 2026 19:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Mm3KbJNA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D14E84BC8; Wed,  1 Jul 2026 19:15:51 +0200 (CEST)
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch
 [79.135.106.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCAC084BC8
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1782926149; x=1783185349;
 bh=Gq26lSq7znEwXDPZa4xrSoIujUVGHkTFEdg6kYrbGNA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Mm3KbJNAyAplC1y8cUE0LxSY5856fq0H4wuLmhugn2xOM5FCuJu7oEZ0vOOqc3KIc
 kcHBEegM05b8+pbm80ixOSFSD9rihcu87aHvQJNYta0Z964PsaxEP6ATYDQrKPpGDu
 VCtG7qVWzlSQKyvsu0Bz8/mVGWeZw6H9XjF6K6ympVCVINmLUtTwPHLJWKM63596p3
 h3bAwDg9mGZyRlVnVdzLtUCmcK2/1p/gEEIgNtngmpyfpAOt4om4wrL6DHBnWaIXhr
 lZp6ud2/ly+LS9Xi1pLHdblT7jSOG8gvnwacMjCzUIKfKu159pgEBdHQyPBUxk5hqv
 3hPCPCG/pZ+qQ==
X-Pm-Submission-Id: 4gr69H2bK7z1DDr1
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 3/8] string: correct documentation for strstr and strnstr
Date: Wed,  1 Jul 2026 19:15:30 +0200
Message-ID: <20260701171535.906272-4-rv@rasmusvillemoes.dk>
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

The len parameter for strnstr() concerns the maximum size of the
haystack to consider, not the length of the needle being searched for.

strstr() obviously has no len parameter, so remove the copy-pasta.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 lib/string.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index a76dcd48d20..45f0f5f8d09 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -702,7 +702,7 @@ void *memdup(const void *src, size_t len)
  *
  * @s1:		string to be searched
  * @s2:		string to search for
- * @len:	maximum number of characters in s2 to consider
+ * @len:	maximum number of characters in s1 to consider
  *
  * Return:	pointer to the first occurrence or NULL
  */
@@ -728,7 +728,6 @@ char *strnstr(const char *s1, const char *s2, size_t len)
  *
  * @s1:		string to be searched
  * @s2:		string to search for
- * @len:	maximum number of characters in s2 to consider
  *
  * Return:	pointer to the first occurrence or NULL
  */
-- 
2.54.0

