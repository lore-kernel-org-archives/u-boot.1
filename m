Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE948C4167B
	for <u-boot@archiver.kernel.org>; Sun, 10 Dec 2023 15:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CD1287076;
	Sun, 10 Dec 2023 16:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="i1ltc90D";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LfOSBm99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E48A987232; Sun, 10 Dec 2023 16:02:37 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA9E187045
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 16:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Sp7Qg27fLz9sZq;
 Sun, 10 Dec 2023 16:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702220555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EOG9Eb8AB8q8PwBd1k2vu8hvnQ5kzB4rca3rP22Ou5E=;
 b=i1ltc90DskdRgRkKzoH/SgVil7PuOu/M7ycfPJpi2Mr68tRM2VWtnxtnWWuyRPmaOBhRqk
 l8BPoGg/3YY1aQRBxty+No12JIKzIdYJNAsU0pUWHjwjKdPrC93FcHJWezvb05JqXFO9vQ
 isCtTj3ccvSAOsb5coSJ98NBItEs3XF87CZd0JUwiU1GDUgGNbtQngbszBsaQO/WFRDOlI
 O3lpW4BK0wKpZz2lXwSWc0+hSFSSPdD3tI92LU7Zxo9+R7axEyICmNzej2NyXJK5ZuXt97
 sxddY8wiqAc2bOyHocc7nm7bQ0xntJ9L2yYYHyKaX6vmzE1JxQgqhYynDBIGYA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702220553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EOG9Eb8AB8q8PwBd1k2vu8hvnQ5kzB4rca3rP22Ou5E=;
 b=LfOSBm99nQbKtED7Z8JVcBa8s3EY634GAF8+oJl1XrTbKaIli8fIg4Jor7yyc7KMeMzvlR
 wuBE5Jh+TONsDGjp/GQVehqLnfNwV37E1yz+DrnftD0Q+fX1MdIg+4tyOA6Vyz80cYt3NY
 jUWO/Md7ObEILm1P2EnvW+o9vJO4fOfs5ilnT9UoJLfvf3JpZSnUbpgrOv1iGdUNZeRhs0
 nAmxRtAuYpOUDn9pdwdJUagb17h07lSHa9nrzwIHACz4ii/vxVbsqQM/EyQ9R+Mymwg2eB
 KzvTusO+kxaXudBRvkjiA0u1epIfVUI+GzhZ69RkT+RWgnhR+oL1wpLeNWlDbA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] test: bdinfo: Handle systems without getopt
Date: Sun, 10 Dec 2023 16:01:56 +0100
Message-ID: <20231210150213.124370-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 88d9073237e46c70d30
X-MBO-RS-META: 6dcdayuef5sixshjb7gt3iyo13qzghkq
X-Rspamd-Queue-Id: 4Sp7Qg27fLz9sZq
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

Systems without getopt support fall back to plain full bdinfo print,
handle such a case, which occurs e.g. with sandbox_flattree_defconfig .

Fixes: 8827a3871452 ("test: bdinfo: Test bdinfo -h")
Fixes: 2696f3ab8101 ("test: bdinfo: Test bdinfo -m")
Fixes: 3ff2d796a6f2 ("test: bdinfo: Test bdinfo -e")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 test/cmd/bdinfo.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 9744bd16df9..053f2224919 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -237,12 +237,17 @@ static int bdinfo_test_help(struct unit_test_state *uts)
 {
 	/* Test BDINFO unknown option help text print */
 	ut_assertok(console_record_reset_enable());
-	ut_asserteq(1, run_commandf("bdinfo -h"));
-	ut_assert_nextlinen("bdinfo: invalid option -- h");
-	ut_assert_nextlinen("bdinfo - print Board Info structure");
-	ut_assert_nextline_empty();
-	ut_assert_nextlinen("Usage:");
-	ut_assert_nextlinen("bdinfo");
+	if (!CONFIG_IS_ENABLED(GETOPT)) {
+		ut_asserteq(0, run_commandf("bdinfo -h"));
+		ut_assertok(bdinfo_test_all(uts));
+	} else {
+		ut_asserteq(1, run_commandf("bdinfo -h"));
+		ut_assert_nextlinen("bdinfo: invalid option -- h");
+		ut_assert_nextlinen("bdinfo - print Board Info structure");
+		ut_assert_nextline_empty();
+		ut_assert_nextlinen("Usage:");
+		ut_assert_nextlinen("bdinfo");
+	}
 	ut_assertok(ut_check_console_end(uts));
 
 	return 0;
@@ -255,7 +260,10 @@ static int bdinfo_test_memory(struct unit_test_state *uts)
 	/* Test BDINFO memory layout only print */
 	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("bdinfo -m"));
-	ut_assertok(bdinfo_check_mem(uts));
+	if (!CONFIG_IS_ENABLED(GETOPT))
+		ut_assertok(bdinfo_test_all(uts));
+	else
+		ut_assertok(bdinfo_check_mem(uts));
 	ut_assertok(ut_check_console_end(uts));
 
 	return 0;
@@ -268,7 +276,9 @@ static int bdinfo_test_eth(struct unit_test_state *uts)
 	/* Test BDINFO ethernet settings only print */
 	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_commandf("bdinfo -e"));
-	if (IS_ENABLED(CONFIG_CMD_NET))
+	if (!CONFIG_IS_ENABLED(GETOPT))
+		ut_assertok(bdinfo_test_all(uts));
+	else if (IS_ENABLED(CONFIG_CMD_NET))
 		ut_assertok(test_eth(uts));
 	ut_assertok(ut_check_console_end(uts));
 
-- 
2.42.0

