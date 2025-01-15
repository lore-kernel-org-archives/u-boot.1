Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAE5C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 466B280AE5;
	Wed, 15 Jan 2025 14:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="meLr/zeG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364C480AE4; Wed, 15 Jan 2025 14:32:08 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0903E809A8
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3ce87d31480so1839745ab.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947924; x=1737552724; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3T//WMb0fEFiTp5ZaZGKogBjdrZVXedflJsIxtEuw3k=;
 b=meLr/zeGlfGjGD/Av8k75ie5FqoBZ+WZEYWiOulOpGeOFhFw/j6zLIdLXXaZ7Hrn2c
 9FrzSycQXySrAoeeNeu3WZPrgZ001its7tVS1WzqODDe8XGqu4ZY8Jj/LX2a1Qj+in3S
 g/IZIMbEtIGC3gLljxN9lmH0xQLhF8fmMaIvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947924; x=1737552724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3T//WMb0fEFiTp5ZaZGKogBjdrZVXedflJsIxtEuw3k=;
 b=OKmQ2ADiK9yrWaIp9BTsqw7D83fOhneXUr79IFlQwi2jQ0G3S/SUixlztiO9gty2Pj
 aAVNRPATtgLLnZJSqOrmAg86clKwwKtXpNzZzEmolGx4z8mwTYZ8rranhxOgJrVP9A1g
 4/IX9FMebQoo34hzLQ0mkllfSrEPPunIF1QKVaRjiv0ggR2LJ5a4+t0jITaXbhgvhxdy
 ipLDiIfH5vn5k1rsVeQumAn+bxymCeK/9yVc7MFfrlFreeIKUBOCdT61XPXyxxyKHykS
 FKrY1yyG51/N3lGIRfPl5M+b+HBkN90sKAveEF1qJ/NHgqVjsxAKQLKZY8M3vR+vOIlv
 i09Q==
X-Gm-Message-State: AOJu0YzszayBrC5JnjpXov5CeJcXhlfmv7iR77otwpfGWjBP+j2T7b2c
 WboNMAJapQHQYb/c5SXjxcT2+wNF0y5lSei7ln9dXSIu+t6EPmXZFshhdChTugZxbr4cqmX4lmA
 =
X-Gm-Gg: ASbGncukSiWZAzEwASnXUaV3V0yiYSU5yM6ruPPxWHeBu8Z5QBZ0TltKyCKvsVIG/Zg
 aPBwrk3YBQiDHRDkbZDC/T2f879/VJ9qLwgGUyQzBBZ1+PivrFThjRaWiIjgkvEcP76szSEKIfv
 qcFa7FhE9IsxYghR8arxBdzxDB2ZxcUGs0qBc2ssXpOo2HKSBT2YvWwgOuFTioKeUruFfbmmP7X
 hsHi8rdIa1jHcjaAmdcmWxfFyJpo1TOs/33QWLkyb4GmoZu+UbOm3AhFPEl71kUi57Ud5TP3RPA
 TXZIz88JhBAYdPsayg==
X-Google-Smtp-Source: AGHT+IH45XCl631hwfCZyu/ovkHLl5HTMuG11f+tLWUheBhDZMlHjhyXseeadC6Yz3idc2pkVY2aZQ==
X-Received: by 2002:a05:6e02:388b:b0:3bd:c7f5:41d2 with SMTP id
 e9e14a558f8ab-3ce3a86a560mr227010005ab.4.1736947924175; 
 Wed, 15 Jan 2025 05:32:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 26/43] test: Drop the function for running bloblist tests
Date: Wed, 15 Jan 2025 06:30:56 -0700
Message-Id: <20250115133114.590375-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/suites.h  |  2 --
 test/cmd_ut.c          |  2 +-
 test/common/bloblist.c | 10 ----------
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 1a40af6599a..32b7e8e3d5a 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -35,8 +35,6 @@ int do_ut_addrmap(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_ut_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
-		   char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 6f5aa7e4924..e0e01510016 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -169,7 +169,7 @@ static struct suite suites[] = {
 	SUITE(measurement),
 #endif
 #ifdef CONFIG_SANDBOX
-	SUITE_CMD(bloblist, do_ut_bloblist),
+	SUITE(bloblist),
 	SUITE_CMD(bootm, do_ut_bootm),
 #endif
 #ifdef CONFIG_CMD_ADDRMAP
diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index f5d98774862..9467abfa8e1 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -602,13 +602,3 @@ static int bloblist_test_blob_maxsize(struct unit_test_state *uts)
 	return 0;
 }
 BLOBLIST_TEST(bloblist_test_blob_maxsize, UFT_BLOBLIST);
-
-int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
-		   char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(bloblist);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(bloblist);
-
-	return cmd_ut_category("bloblist", "bloblist_test_",
-			       tests, n_ents, argc, argv);
-}
-- 
2.34.1

