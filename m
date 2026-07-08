Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D5CC44501
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 20:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA54784A29;
	Wed,  8 Jul 2026 22:37:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="tzXVuAr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 644E884A6B; Wed,  8 Jul 2026 22:37:31 +0200 (CEST)
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch
 [185.70.43.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D916584A29
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 22:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783543044; x=1783802244;
 bh=ROxMYjgGJCrV7w5Jdc2JLFPAl7He7HDMYU28mVP+n/w=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=tzXVuAr+Hu9salUgjXhq7XU2Y5tRiB/0dIIDqytrnN0ss6tIT6ZADbx72wiq7rkRz
 OkWW7DN2+qmPUtNUDem+REHMEmTSqe5jkyMXfF0oAxFdM/za3OOo2qgGGNrMSSP/en
 k9fCFjkCVXrq2l9qOQUW2H7Q+Orr+fZ8+5tYjJAyTNFaDP3Ky7dZfQB66rs2LX5/fc
 Gpyme4etF4wrkbgiRdpYHTXd/43wDRsyu7MK0r1lZDuTODha98rPEHOjQ83waEweBk
 Oi6dmR1NIPZHRUN4hw/Msxy9+aZ3ORdmG7nQ92woYOV4KJ4pwIY/L6iNXe0quncxc6
 WOajTXb0qTT1Q==
X-Pm-Submission-Id: 4gwVJf4nRtz2Sd4y
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 03/10] string: correct documentation for strstr and strnstr
Date: Wed,  8 Jul 2026 22:37:04 +0200
Message-ID: <20260708203711.849489-4-rv@rasmusvillemoes.dk>
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

The len parameter for strnstr() concerns the maximum size of the
haystack to consider, not the length of the needle being searched for.

strstr() obviously has no len parameter, so remove the copy-pasta.

Reviewed-by: Simon Glass <sjg@chromium.org>
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
2.55.0

