Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE14DC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9F26807F9;
	Wed, 15 Jan 2025 14:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eiaQb4D4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05FA6809A6; Wed, 15 Jan 2025 14:31:52 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9F8B8083B
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3ce87d31480so1838455ab.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947907; x=1737552707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrI1jwAPKU7x2ex0m4Pcx+2xBk6yvfzm1POf3LOn/pw=;
 b=eiaQb4D4SjsRtEiz0iryfiML77WGVIHIFPUu1ttJJwuuNVwLNgLhVVVtfj1HJVAzUZ
 EdC75hpY16ipEFY0kzf1JIiIK6dbcK6ILFvWkLMesQQp2Ya+zACGFn2m1TsckrYIEE79
 DSckmf49ouILDnym+2n1KK40IIfZyIOC89PXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947907; x=1737552707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrI1jwAPKU7x2ex0m4Pcx+2xBk6yvfzm1POf3LOn/pw=;
 b=AvyoLeNXNscjM+XTPL2klUgMn+cJYw87XAI9FtLcOeiOMUKhQTLyeT8wrC4CxSqszC
 Hry07OZICOwr6iHfmxghQNgRStJvfWn6jzKz9vjIk6rqoK/4ffG4sV/iHuAxgdEW/WPb
 qOdxDZM2lUGKJOZasML2KyW1TUJ3cHp52Onj5tbfVc9EWb34c1E4TGfV1RjVVNWGNxTO
 AY6rE67fWlY6zrEGDPOfaCap0yH+sMTb9s/u0PDCrax7Z5cogrSgFbTxFFGR6RkKPa9C
 HrXrkHR2ihJUtodD5bjLpS8YOBBEwPILF/RGJj5CJ1qDONhWKsykCIsLrJbwNX52oD9j
 c0jg==
X-Gm-Message-State: AOJu0YxdPKyciTQA57ZVfea/mICaGtlplYavKKN5t7e2P3+LaFgFlVgM
 avhQAg4STAXBfl9AJE5pr46owHVXoY2lEC1Aa5DwRnRxFwyC5i2uxXoO4GT6lOOLwQ2dJ4/Ij34
 =
X-Gm-Gg: ASbGnctzP+XBUGa2gAq93PtM8XL13JyWSDrs4jGr231UNYpDmWqWfaVLRQPCUEaonYq
 nh5nxJAZQrA/NnSUgh9a4xv5VDlrOcO3O9MUs//L8W8I9MmqB58RohbRlhp5mEBiX8AR922CoUU
 p6McEixDaSSDSAQv/gEHv1CE95O+LlWpqm8bPfyaHW6qSH6bsXWuHa0NTyx5w2eWC4Qxo955vGN
 oZ40WAtwZSQ+4xV6XXndopNzuWUctu29w3v67VDcRRdV7uBqAYfju6v6FRb+Jci2utnktKN25rz
 5P+hNE589F65kAKNTg==
X-Google-Smtp-Source: AGHT+IH2Wj6ICuxDB+KNAnVfxDFSsLxKGwS+1ibbmpwEMf8UdNNFhOwR6Mvvui30bb2EOWr1ohpJ9Q==
X-Received: by 2002:a05:6e02:20e4:b0:3ce:8b1b:2f with SMTP id
 e9e14a558f8ab-3ce8b1b0258mr9650975ab.17.1736947907454; 
 Wed, 15 Jan 2025 05:31:47 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ravi Minnikanti <rminnikanti@marvell.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/43] test: Drop the function for running env tests
Date: Wed, 15 Jan 2025 06:30:46 -0700
Message-Id: <20250115133114.590375-17-sjg@chromium.org>
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
 test/cmd_ut.c         | 2 +-
 test/env/cmd_ut_env.c | 9 ---------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 414613c593e..b78436fe2b2 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -37,7 +37,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
-int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index a3dcbef1740..a34998605cc 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -136,7 +136,7 @@ static struct suite suites[] = {
 	SUITE(dm),
 #endif
 #if defined(CONFIG_UT_ENV)
-	SUITE_CMD(env, do_ut_env),
+	SUITE(env),
 #endif
 	SUITE_CMD(exit, do_ut_exit),
 #ifdef CONFIG_CMD_FDT
diff --git a/test/env/cmd_ut_env.c b/test/env/cmd_ut_env.c
index 332139bb803..81d1bb2f80d 100644
--- a/test/env/cmd_ut_env.c
+++ b/test/env/cmd_ut_env.c
@@ -4,7 +4,6 @@
  * Joe Hershberger, National Instruments, joe.hershberger@ni.com
  */
 
-#include <command.h>
 #include <test/env.h>
 #include <test/suites.h>
 #include <test/ut.h>
@@ -74,11 +73,3 @@ static int env_test_env_cmd(struct unit_test_state *uts)
 	return 0;
 }
 ENV_TEST(env_test_env_cmd, UTF_CONSOLE);
-
-int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(env);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(env);
-
-	return cmd_ut_category("env", "env_test_", tests, n_ents, argc, argv);
-}
-- 
2.34.1

