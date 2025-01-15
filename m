Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DC7C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F370280ADE;
	Wed, 15 Jan 2025 14:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FARIytS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665398081E; Wed, 15 Jan 2025 14:32:01 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35AA2807B4
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844e9b83aaaso528284239f.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947917; x=1737552717; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4swxA2KUAbHMejK7I41zJWy1kc7IKJRFAqZOXB7v0EA=;
 b=FARIytS75X6WPjJSMFdfZ1WyXNC2K1Wv+GCvl4idSB0nTMBnKAA583Uu3jscjKwddS
 ttNssFRnrgjGCTXUFOMi4utp7a7RE61oHCFDmKJoGYdSoGn0gCOR3Wjq+XbacTE9mrHI
 syl2tITC7BTy7BUghWgaD25JWzFkzWsjG9rEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947917; x=1737552717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4swxA2KUAbHMejK7I41zJWy1kc7IKJRFAqZOXB7v0EA=;
 b=CqIHpjM4Vya06GYPnQerQCbIoi8kjw+KayyLOQdN/Fa5KzuRSGfG5HV1rwliO7C+3m
 J7eirPeNbzJg/qlWi49JsKjuf/YHsKEHsEciWtfubD0cpXQ525+EjBr/LTMCO0HNbfqO
 T9hUwBsuETzzIZadLlWsNY+1X7D2qOaKMDBW3OJzycD9PHCuKQPLN43sLIZ0kkt2Hmvi
 0i4UD8ueoniZ7lEEJDx4GPk/7BXxfrgvy4eQfRTUz73sVBrVXOsoG/Qlw/JjUsr3ZrKt
 BavkmKQxqJAHuqBDpgdNKHw7MKVxNEzzCLKi0UHFwYt3Y9wmcD36BtqIlxVqT9x4ZR7M
 /PJw==
X-Gm-Message-State: AOJu0YxUPmjhlDpu7AAIaVhMXlw4WnzvsA2HnQXVkWKe4GibDh6aWdvw
 AEojp1Nh0fcqNKz3++l8yLS2DeOK5tLEUlwqqKiChedW+3Vy2rQ0aogi2Ih03ZdOYMiolcJ37xk
 =
X-Gm-Gg: ASbGncu/ynXVecXc2fw4YbUAVIcvN0N+DXflMheS+JruWg4K1JjgPI6IyOH7MBf3O4D
 t757+r78UzASw7QnIZxwlFqkOMyXGIjiMvX7fVCvS7MyjIOaHdkV4QpNbca0WCjqmDZ06tmAW9T
 KULKlErBPBwfSGEBA6mnpbKJNC7/jVk9SI3ffozo5Lj3r0gzyejQOAmatRw08F3DBWIxlkMdzlo
 T5i+TkzaSUat0lmUmO1HRp0DwbiAn17bswr/h4VfF8K6L3MrLjQwp3/sRmC3GCwLmv69Z0XWWpa
 dys58r9eZyfKwINhSQ==
X-Google-Smtp-Source: AGHT+IFvcitewQ/L5sYdWJ8LN8XaaLOTY7T8tqpBnzDiFChvTuxdjFToy/AjzbLTHaMA75uKYdzGOQ==
X-Received: by 2002:a05:6e02:3a87:b0:3ce:394a:ad4c with SMTP id
 e9e14a558f8ab-3ce3a88853dmr232678705ab.14.1736947917413; 
 Wed, 15 Jan 2025 05:31:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 22/43] test: Drop the function for running mbr tests
Date: Wed, 15 Jan 2025 06:30:52 -0700
Message-Id: <20250115133114.590375-23-sjg@chromium.org>
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

 include/test/suites.h | 1 -
 test/cmd/mbr.c        | 8 --------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 72f98eb3558..612167fe053 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -39,7 +39,6 @@ int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index ad859921ce5..45bab04923a 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -471,11 +471,3 @@ static int mbr_test_run(struct unit_test_state *uts)
 
 /* Declare mbr test */
 UNIT_TEST(mbr_test_run, UTF_CONSOLE, mbr);
-
-int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(mbr);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(mbr);
-
-	return cmd_ut_category("mbr", "mbr_test_", tests, n_ents, argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index c490498b4c5..f5fbcf0d686 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -159,7 +159,7 @@ static struct suite suites[] = {
 #endif
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_MBR) && defined(CONFIG_CMD_MMC) \
         && defined(CONFIG_MMC_SANDBOX) && defined(CONFIG_MMC_WRITE)
-	SUITE_CMD(mbr, do_ut_mbr),
+	SUITE(mbr),
 #endif
 	SUITE_CMD(mem, do_ut_mem),
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_SETEXPR)
-- 
2.34.1

