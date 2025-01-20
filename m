Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F96DC02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA9A8077F;
	Mon, 20 Jan 2025 22:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JGzWN+q6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E57D801CF; Mon, 20 Jan 2025 22:27:20 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 470F1801CF
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3ce85e37887so50062645ab.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408436; x=1738013236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRjIcoRIXJSD8G3caPKdEKg2vpmV/eA1T7DHQK7JUTk=;
 b=JGzWN+q6rhVmxK3gEfSk94gez8TBgh39OCsPxODZbcsh10beBZFqB5OooSmHycWLXj
 15I6/O3EgHsEOE86sk0CGncnNJILGXbKmCLHwTiA4HoSxZ4YlG0p/iRKglrUqD5aKQ4q
 M6H2KYLrMeUdD0D+w6NG8RpWAnlhLgzuHkZy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408436; x=1738013236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRjIcoRIXJSD8G3caPKdEKg2vpmV/eA1T7DHQK7JUTk=;
 b=gPl4LVjIO4Qx6+7r4TC1bVJrpcAikYmCOQniFGF4YQEKypMYCX4QGQot71MaYgx/dw
 xzJGqu9TM8BM8D7eGwz3fzGxljeFENxBun4rvrKer/x2SC731lQKuLStLHWpG57BxOwc
 XowPKF5WLvexPv4R9H1+NoAZ5vCotu2uOXYAK7gBHVMyZHkIpR+qpZ2w7QBvxGE2EY4b
 qVxTzLIeP71GqI+vZJeQua4YK1n8ZykLylFFvL8YHpklHL2tFS1jxDKCV+Rs+4LonJ1y
 MzObecemeadbLwx3ZjAB92ISskxpm5i7jsPoDN9xAIbgH4sou0aBC4fkWSAxoSzwtAUy
 3duw==
X-Gm-Message-State: AOJu0YzAAkq6vMeB2KbuahziZAaZe8DSzshdivyxKJP4283jid9OW4+O
 E6zMLAhkT0pfN/kGIAyuZm4dQ/ApCYCDRC5YmMdw52NrJ7tVpzzy8V7f6TLr6g9EwUS4AyMMqts
 =
X-Gm-Gg: ASbGncvUoZxCO8ZZfIk56ALva+BOd8XE+VTW/QA+TySGD3pdVr4aTXACQLqGE0HS6YG
 ggX7IZU+b+o2drcAV42h7oeumwsx9D8p1RfYL0NW1UImQLqIzl/naZxEE62mQvTQyGZuAkPg47r
 Qe2umncWl5NInQ0+n8Kiz+x/8AeAP2+BFGQFUSYPVzImydl2Ribxbwx8ddL5H3afv8+ZErHTMVb
 f+rwPmFsKSgH8m1RFRE7RI6RlD+8ItEBTLLpR0tZk/cBx/aKgdUnX3O1bdsPAsMGoZC/t4HYBFp
 N6OGLeVp0U/1ee/HObyLO4PWs11tqr8=
X-Google-Smtp-Source: AGHT+IETzM9n6AtVSeTMMC0ZhWeRDqDNKorqehRbNfRZFdVB9KdgqCIADJ2fep4RfQ4Xi+kmcUS7sg==
X-Received: by 2002:a05:6e02:1a04:b0:3ce:8031:3e with SMTP id
 e9e14a558f8ab-3cf74495abcmr102724285ab.16.1737408436146; 
 Mon, 20 Jan 2025 13:27:16 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 26/44] test: Drop the function for running bloblist tests
Date: Mon, 20 Jan 2025 14:25:48 -0700
Message-ID: <20250120212613.516664-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

(no changes since v1)

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
index ff9976cb98a..93bcc5efc74 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -170,7 +170,7 @@ static struct suite suites[] = {
 #endif
 #ifdef CONFIG_SANDBOX
 #if CONFIG_IS_ENABLED(BLOBLIST)
-	SUITE_CMD(bloblist, do_ut_bloblist),
+	SUITE(bloblist),
 	SUITE_CMD(bootm, do_ut_bootm),
 #endif
 #endif
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
2.43.0

