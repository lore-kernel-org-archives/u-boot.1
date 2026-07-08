Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18368C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 20:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 944D084A85;
	Wed,  8 Jul 2026 22:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="PU8n5kUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC83184A7A; Wed,  8 Jul 2026 22:37:37 +0200 (CEST)
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A77A0847AF
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 22:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783543054; x=1783802254;
 bh=NU6oONhFfP4zB2PrSvqlQ78ImkuHUNhksVaKvNIRnjI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=PU8n5kUNxfpDU64VgRtkhVLPPbcJEc8yVUv45upASn2M/PboS3/mEcDiFO6LRssrt
 e/ZhPSTnSypbNVOu+q0PpA8YYeQHfBPdS8ToNe4C9RRUx4mASBYixGQKvKRDsnZZ/h
 fkhwc8rNkxrXP0GC18LtphVm6ij4yo8ICjgwlQXKesprehXYxvU6NzQtNGsB/SgOLz
 n4FA+n98KJVTfYoymCyqxXYPJme6srrqwyh4zMkCNglMaZEmi+hdv7w8Ieov191RJi
 2Evh6/T++yUCQMX9q4bnuEKrDcXyn748jGijDgbrhzqKVCFDHXm6GF3+QAXNQucm1a
 vjBDz8ZuHfdCw==
X-Pm-Submission-Id: 4gwVJt0Zglz2Scsj
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 07/10] test: string: add test of new strcasestr() function
Date: Wed,  8 Jul 2026 22:37:08 +0200
Message-ID: <20260708203711.849489-8-rv@rasmusvillemoes.dk>
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

Change the existing strstr() test a little so that the substring not
found is "bits", i.e. one that is actually found when doing case
insensitive search.

Then copy all of lib_strstr(), adapt the expectation for the
strcasestr(s1, s3) result, and add another "not found" case.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 test/lib/string.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/test/lib/string.c b/test/lib/string.c
index db6f28dbfdf..d418a40c4d4 100644
--- a/test/lib/string.c
+++ b/test/lib/string.c
@@ -284,18 +284,36 @@ static int lib_strstr(struct unit_test_state *uts)
 {
 	const char *s1 = "Itsy Bitsy Teenie Weenie";
 	const char *s2 = "eenie";
-	const char *s3 = "easy";
+	const char *s3 = "bits";
 
 	ut_asserteq_ptr(&s1[12], strstr(s1, s2));
 	ut_asserteq_ptr(&s1[13], strstr(&s1[3], &s2[1]));
 	ut_assertnull(strstr(s1, s3));
-	ut_asserteq_ptr(&s1[2], strstr(s1, &s3[2]));
-	ut_asserteq_ptr(&s1[8], strstr(&s1[5], &s3[2]));
+	ut_asserteq_ptr(&s1[1], strstr(s1, &s3[2]));
+	ut_asserteq_ptr(&s1[7], strstr(&s1[5], &s3[2]));
 
 	return 0;
 }
 LIB_TEST(lib_strstr, 0);
 
+/** lib_strcasestr() - unit test for strcasestr() */
+static int lib_strcasestr(struct unit_test_state *uts)
+{
+	const char *s1 = "Itsy Bitsy Teenie Weenie";
+	const char *s2 = "eenie";
+	const char *s3 = "bits";
+
+	ut_asserteq_ptr(&s1[12], strcasestr(s1, s2));
+	ut_asserteq_ptr(&s1[13], strcasestr(&s1[3], &s2[1]));
+	ut_asserteq_ptr(&s1[5], strcasestr(s1, s3));
+	ut_asserteq_ptr(&s1[1], strcasestr(s1, &s3[2]));
+	ut_asserteq_ptr(&s1[7], strcasestr(&s1[5], &s3[2]));
+	ut_assertnull(strcasestr(&s1[6], s3));
+
+	return 0;
+}
+LIB_TEST(lib_strcasestr, 0);
+
 static int lib_strim(struct unit_test_state *uts)
 {
 	char buf[BUFLEN], *p;
-- 
2.55.0

