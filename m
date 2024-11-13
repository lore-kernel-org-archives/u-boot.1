Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0280BD637C4
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 21:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81AAA8921F;
	Wed, 13 Nov 2024 22:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dU93nQWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B339789220; Wed, 13 Nov 2024 22:15:17 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C692F890DA
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 22:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-104-190.46.114.pool.telefonica.de
 [46.114.104.190])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 29ABE402ED; 
 Wed, 13 Nov 2024 21:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731532515;
 bh=t18PVQ6pyrFfDoroyrPb1kmPWykEo0tq8Dsn69VcF+M=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=dU93nQWUEm7iRn1zHiDqkJOxnPg2s70G9DsJYCO7LviwEy0zK0a6kbZTvgkGlcnZg
 08awaT+bqSiejZsufc9NYNCcReiwfzeRbJzvpRJi3wCQMwD8Yx/JmzTTyxMp5hojJ8
 MSJ1+ak5u9VC5cROGWgtsiZ/ryEcDWUAPeqL8huw21wZN3a5lXUCURQ/VKCkYKaXru
 i98ZhXft2b3k2vZXpN0CvGqSYhfaFXqjDVVMerczwhDb3bMXSVYLrMmbeo3jYmDfNs
 Z6JQCEgIOYAaQ5bB6YcDONi+/7M9sVQpUZBZviiyN0KUiVL4G+g5wRhFhm2EFeBXuu
 Z6aGMeH24vVuQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: unit test for hextoull()
Date: Wed, 13 Nov 2024 22:15:12 +0100
Message-ID: <20241113211512.93184-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Provide a unit test for the hextoull() function.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/str_ut.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/test/str_ut.c b/test/str_ut.c
index 96e048975d8..1110971d995 100644
--- a/test/str_ut.c
+++ b/test/str_ut.c
@@ -18,6 +18,8 @@ static const char str4[] = "1234567890123 I lost closer friends";
 static const char str5[] = "0x9876543210the last time I was deloused";
 static const char str6[] = "0778octal is seldom used";
 static const char str7[] = "707it is a piece of computing history";
+static const char str8[] = "0x887e2561352d80fa";
+static const char str9[] = "614FF7EAA63009DA";
 
 /* Declare a new str test */
 #define STR_TEST(_name, _flags)		UNIT_TEST(_name, _flags, str_test)
@@ -189,6 +191,22 @@ static int str_hextoul(struct unit_test_state *uts)
 }
 STR_TEST(str_hextoul, 0);
 
+static int str_hextoull(struct unit_test_state *uts)
+{
+	char *endp;
+
+	/* Just a simple test, since we know this uses simple_strtoull() */
+	ut_asserteq_64(0x887e2561352d80faULL, hextoull(str8, &endp));
+	ut_asserteq_64(0x12, endp - str8);
+	ut_asserteq_64(0x614ff7eaa63009daULL, hextoull(str9, &endp));
+	ut_asserteq_64(0x10, endp - str9);
+	ut_asserteq_64(0x887e2561352d80faULL, hextoull(str8, NULL));
+	ut_asserteq_64(0x614ff7eaa63009daULL, hextoull(str9, NULL));
+
+	return 0;
+}
+STR_TEST(str_hextoull, 0);
+
 static int str_dectoul(struct unit_test_state *uts)
 {
 	char *endp;
-- 
2.45.2

