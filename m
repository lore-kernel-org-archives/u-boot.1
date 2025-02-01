Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D144C0218A
	for <u-boot@archiver.kernel.org>; Sat,  1 Feb 2025 06:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 736F280F56;
	Sat,  1 Feb 2025 07:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="q8mgb/zD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBC8580C77; Sat,  1 Feb 2025 07:22:34 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A55780F56
 for <u-boot@lists.denx.de>; Sat,  1 Feb 2025 07:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-068.46.114.pool.telefonica.de
 [46.114.111.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3F0013FD8D; 
 Sat,  1 Feb 2025 06:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738390948;
 bh=kyQ58SLARvoShLBHfrq8g7y7ZJa4kkmEX+PHcmcGV2s=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=q8mgb/zDPRYujpYy4cuhMkDZFaG2a7/vBBB4DFRhAveWumJMlajGnDEQWLc34uFqZ
 GLk9TeuIpXiBqfe9uxUhtpSKRkfcdJ+Frx3xONCj9izj69hxGR0cJIOyZdtEAuXcZy
 bD5hqUfmmvi2eMwp5mB9kGGxSwI597yjiDX8wXLygMPKzJ2nB0qTHDWDYwkAqthGNV
 v6jDsLQ8tm8F04SjGyS/RvvGcBk46Qjg4dR/dUb3hZlVb2nvbkOIN9/ng8GBuN7ci1
 +dM6qRqa6Z50fhc6JstLf9zBd45Tx+MQSEmqIdJ8wloZFxNQ2JyY4LqSKOcEC9YE+3
 aIozFRQwcRpsA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/4] test: unit tests for strstr() and strnstr()
Date: Sat,  1 Feb 2025 07:22:13 +0100
Message-ID: <20250201062214.56747-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250201062214.56747-1-heinrich.schuchardt@canonical.com>
References: <20250201062214.56747-1-heinrich.schuchardt@canonical.com>
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

Add unit tests for the library functions.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v2:
	no change
---
 lib/string.c      |  2 +-
 test/lib/string.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/lib/string.c b/lib/string.c
index 691c9985692..3a74493d223 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -16,8 +16,8 @@
  */
 
 #include <config.h>
+#include <limits.h>
 #include <malloc.h>
-#include <stdint.h>
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/types.h>
diff --git a/test/lib/string.c b/test/lib/string.c
index 8d22f3fd68f..31391a387b9 100644
--- a/test/lib/string.c
+++ b/test/lib/string.c
@@ -11,6 +11,7 @@
 
 #include <command.h>
 #include <log.h>
+#include <string.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -221,3 +222,42 @@ static int lib_memdup(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_memdup, 0);
+
+/** lib_strnstr() - unit test for strnstr() */
+static int lib_strnstr(struct unit_test_state *uts)
+{
+	const char *s1 = "Itsy Bitsy Teenie Weenie";
+	const char *s2 = "eenie";
+	const char *s3 = "eery";
+
+	ut_asserteq_ptr(&s1[12], strnstr(s1, s2, SIZE_MAX));
+	ut_asserteq_ptr(&s1[12], strnstr(s1, s2, 17));
+	ut_assertnull(strnstr(s1, s2, 16));
+	ut_assertnull(strnstr(s1, s2, 0));
+	ut_asserteq_ptr(&s1[13], strnstr(&s1[3], &s2[1], SIZE_MAX));
+	ut_asserteq_ptr(&s1[13], strnstr(&s1[3], &s2[1], 14));
+	ut_assertnull(strnstr(&s1[3], &s2[1], 13));
+	ut_assertnull(strnstr(&s1[3], &s2[1], 0));
+	ut_assertnull(strnstr(s1, s3, SIZE_MAX));
+	ut_assertnull(strnstr(s1, s3, 0));
+
+	return 0;
+}
+LIB_TEST(lib_strnstr, 0);
+
+/** lib_strstr() - unit test for strstr() */
+static int lib_strstr(struct unit_test_state *uts)
+{
+	const char *s1 = "Itsy Bitsy Teenie Weenie";
+	const char *s2 = "eenie";
+	const char *s3 = "easy";
+
+	ut_asserteq_ptr(&s1[12], strstr(s1, s2));
+	ut_asserteq_ptr(&s1[13], strstr(&s1[3], &s2[1]));
+	ut_assertnull(strstr(s1, s3));
+	ut_asserteq_ptr(&s1[2], strstr(s1, &s3[2]));
+	ut_asserteq_ptr(&s1[8], strstr(&s1[5], &s3[2]));
+
+	return 0;
+}
+LIB_TEST(lib_strstr, 0);
-- 
2.47.1

