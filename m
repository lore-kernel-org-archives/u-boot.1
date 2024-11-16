Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A299BD68BE7
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 20:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D133D88E41;
	Sat, 16 Nov 2024 21:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YLM6/Azl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D8BB88EC9; Sat, 16 Nov 2024 21:09:12 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C47188E3F
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 21:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 107033FDE7; 
 Sat, 16 Nov 2024 20:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731787749;
 bh=aICu0haS2soXNd9IQ0hmdOoFoQwQ0n5TaqE/89Aqke8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=YLM6/AzlGJO3OMSIOUXriIZWlS7sP1aGbAsCUqxEpfNy06tbNI/Y3RrQf983rJlB8
 ycORWBPAhD5SOucjroCbAisJYMfVnpe0YkSQxaJHYoaFnWEafQY/oMnJFpcMZc+w2v
 PJcEnVkVWs2nquEsrTU+cSEKOCnHV6djKPOD9FU+n5+ND/wcgdkISDMV3qxQeR/Oxw
 k4ZM8Dej5YfxGfnowOaRyOgzwhTBLVuliaCis5yHFfKaKD3R1LM524+Sr++cQS6n/f
 8SlHUZl88vyag+hzAaSSdirzvl3lmPXPAyNw/x+PswvAfOaXifsUuHjIA2z4mS8UHS
 ZiYACPIryDqlw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: cmd/hash: check return value of
 ut_check_console_line
Date: Sat, 16 Nov 2024 21:08:22 +0100
Message-ID: <20241116200822.27160-1-heinrich.schuchardt@canonical.com>
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

ut_check_console_line() does include an assert.
Pass the result to ut_assertok().

Addresses-Coverity-ID:  514958 Error handling issues
Fixes: 7dfafcd65ef3 ("test: unit test for hash command")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/hash.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/test/cmd/hash.c b/test/cmd/hash.c
index 2fcec9cadcd..296dd762b31 100644
--- a/test/cmd/hash.c
+++ b/test/cmd/hash.c
@@ -33,11 +33,13 @@ static int dm_test_cmd_hash_md5(struct unit_test_state *uts)
 			strstr(uts->actual_str, "md5 for "));
 	ut_assert(strstr(uts->actual_str,
 			 "d41d8cd98f00b204e9800998ecf8427e"));
-	ut_check_console_line(uts, "d41d8cd98f00b204e9800998ecf8427e");
+	ut_assertok(ut_check_console_line(uts,
+					  "d41d8cd98f00b204e9800998ecf8427e"));
 
 	if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
 		ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
-		ut_check_console_line(uts, "hash - compute hash message digest");
+		ut_assertok(ut_check_console_line(
+				uts, "hash - compute hash message digest"));
 
 		return 0;
 	}
@@ -77,12 +79,13 @@ static int dm_test_cmd_hash_sha256(struct unit_test_state *uts)
 			strstr(uts->actual_str, "sha256 for "));
 	ut_assert(strstr(uts->actual_str,
 			 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"));
-	ut_check_console_line(uts,
-			      "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
+	ut_assertok(ut_check_console_line(
+			uts, "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"));
 
 	if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
 		ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
-		ut_check_console_line(uts, "hash - compute hash message digest");
+		ut_assertok(ut_check_console_line(
+				uts, "hash - compute hash message digest"));
 
 		return 0;
 	}
-- 
2.45.2

