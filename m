Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A8DC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65C868083F;
	Mon, 20 Jan 2025 22:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mfffna9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F0B80836; Mon, 20 Jan 2025 22:27:27 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E48F80818
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a9c9f2a569so36860445ab.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408443; x=1738013243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xyd7+BSz2GyugIlbUE/gE11LRHQS+xsj4FUvzSxsr94=;
 b=Mfffna9iygZdM+3HlSoN/6Bu4Rvm0sghyb1PMcoqW8L5IYRzft1o43iVj8oyaFxvZE
 mOaOx12es0A3LZo26a87CeM8tmT1XDP8t+k1mfebuFJdbKSxuwZnIvsauEC7Mgio5R4V
 4cUl3AFUxnU8y+k78RJax+68W1ld0Jze5FUUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408443; x=1738013243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xyd7+BSz2GyugIlbUE/gE11LRHQS+xsj4FUvzSxsr94=;
 b=IdG9x1PTp+JVVBR2NZYMsgVrLrw76N7gnH0VFpzYo4SSp59rSOZqv1vvRljicjG3y6
 x6blSI12BHsZqTsBgjP/lZK5dnS7VUjKJ97Uc60+q57OR6lKI81UkSK1XYBG8nOPijsW
 4Gbc9nNUD6RM/CINGffL42Zgpw5xTiyUiAzwX4W1sUTnG9j8nL44wC8tStvQ2qJOhFqu
 nv5ZKMr5pHAUEdH59a3n68DbK8RmG5+IlDyzTfTvmkOsfCQ1LnbxsCNec867nJLf0vye
 GJ07f6xxXZUg9hFIygLPvV8znmjnVYIsi5GuWduSQQXcXgkfC9NjDiagQOgnsT1m6esr
 QcmQ==
X-Gm-Message-State: AOJu0Yz+Es5kfLIPmJD2JYOBYXpE1CP9fK01075ZTO9jVrLiiTSMtTO0
 jsPy8LsYQaZOUHY02dGPTqZcOlEofd07kFmo5ncmOfocoCyZprW6c+KB2pNedpjB3bqQhx8Vgyk
 =
X-Gm-Gg: ASbGncvS1Ui2G128mI3Oy84zzmFATmTiTBSCvLBMv7VpCucBWV0hEjCV1ZVYgKYPY64
 oueL/MXAJe94cnPfwZgX0z4lW21l+aT3CNcjD6QcK+D0HW8kb4D41vXVcgP8AM41xVFIgL2Cq9y
 ZGWPxfy9Ry48BMPxTqPW9ayTi5kT0DeoUWT6t/GVD5xeHXCuub5Iqy0nkdyENY48ydw7sxBLoYU
 aJFI3L+PZkYUTDi0xXVQbRQS1McC5wO0MbPD0xAvV6ywed1BAIuzDFXNUD1crmmivrPNwKc/t6Z
 4s60Qp4PjdeIn1cJ4pD+nS0tYHJ780c=
X-Google-Smtp-Source: AGHT+IE1ZeJ9MupBDoVT1ScK3I+ivdoVkFwO2GBB649b2t87cMBDekT3Wroy50Cu0VT2U7AR0WCnqg==
X-Received: by 2002:a05:6e02:268a:b0:3a7:d7dd:e70f with SMTP id
 e9e14a558f8ab-3cf7443cbeamr149346195ab.12.1737408443728; 
 Mon, 20 Jan 2025 13:27:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 30/44] test: Drop the function for running loadm tests
Date: Mon, 20 Jan 2025 14:25:52 -0700
Message-ID: <20250120212613.516664-31-sjg@chromium.org>
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

 include/test/suites.h | 1 -
 test/cmd/loadm.c      | 9 ---------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index b96a78f7129..f6b33da5a28 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -32,7 +32,6 @@ int cmd_ut_category(const char *name, const char *prefix,
 
 int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
diff --git a/test/cmd/loadm.c b/test/cmd/loadm.c
index 78bb12ce88c..3c623aa655f 100644
--- a/test/cmd/loadm.c
+++ b/test/cmd/loadm.c
@@ -58,12 +58,3 @@ static int loadm_test_load (struct unit_test_state *uts)
 	return 0;
 }
 LOADM_TEST(loadm_test_load, UTF_CONSOLE);
-
-int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(loadm);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(loadm);
-
-	return cmd_ut_category("loadm", "loadm_test_", tests, n_ents, argc,
-			       argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index c892891d6c8..3620be62ce6 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -181,7 +181,7 @@ static struct suite suites[] = {
 	SUITE(hush),
 #endif
 #ifdef CONFIG_CMD_LOADM
-	SUITE_CMD(loadm, do_ut_loadm),
+	SUITE(loadm),
 #endif
 #ifdef CONFIG_CMD_PCI_MPS
 	SUITE_CMD(pci_mps, do_ut_pci_mps),
-- 
2.43.0

