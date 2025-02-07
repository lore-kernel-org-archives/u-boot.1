Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574FEC02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CED6580B98;
	Fri,  7 Feb 2025 19:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LXvEkztE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 594DC80AE6; Fri,  7 Feb 2025 19:32:09 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F8380BA4
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-854e5dd5cf7so70124439f.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953125; x=1739557925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S3r+Ar7absdXRoAyAeyEOqxjMTRnnM6vWeQAeghQ/B8=;
 b=LXvEkztEZoVHQCESVGBNYEONUHPYydPRmtF9rJ6gzqpQ9he9Qe96Lq4eEaf6wkwJHT
 7PdbWb1y84Ks+7iCojsW+l9cBPFu9fUEoqDzF4iwx/YxibiYhzN6VI0Wkqwu0rAh8bvE
 o0sRo/LzWHcUpfPrr+KAOhW92eEGF6G8HCWvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953125; x=1739557925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3r+Ar7absdXRoAyAeyEOqxjMTRnnM6vWeQAeghQ/B8=;
 b=Z0gzWx6CNRnVXD35kMCfGQe5rUM/JevDEfTnC9tr4QHUqkKlRuS3NJ11t2xhX37RWc
 TcSXaj5dWWN7fUP6TzUa2MuLmuzDNMBHkwVSZFr7Xdv1W22D3H/YJMryuCHL8glcsboU
 c6jFpXuYczS1gD7gXYnEZwNizeLNV7o1R+knLizZYgEQ+NK6035Vo8mr+nC9J/XUMIoB
 TcxXZnFx8YRqS3uVNyhmhFbCH+juZy8+t4I9sZ85RIPT/WjvpsXj+RwOWfQBjAdCVb/T
 6r0EfV4U2BrF9122WVCMJrTkAG3C/RovDZoiHBbLE6qnPbwZgFATcSKHmWsjxcz25iNo
 y4oQ==
X-Gm-Message-State: AOJu0YwKk1ibjurmb+MEo73Uv28JDN0/D3U+SdbKonZkvWLg61I1llWx
 UYwy+egDa+ZwEDyZZ5zA08RiJrZz6MS2fIG8S86xW4VGZWOZy/JzV8h9n6UPMWqCKSejLab7Ssw
 =
X-Gm-Gg: ASbGncs3FjBjKCvB+1S4PQQQhVL8ETD7qzEuxT+K3llt1fwWpCZ7aloNrjQYNzmCFmA
 h4jCLdMC58cYS4Y5nnA0BdzcL2JXfNoSo2Ez0iRCRVR0ADFoqhFfzzYN2oVvYG0w8jqzSx17ELF
 m3mKogmQPR9zOyF99eZzMe8r7RKP8pFAooappYBcO+QRaHK4lYcNyKGTTpFcqfz1zPR2pMnY4Ov
 wXj82+zJxckaB+DYuUbvDCSB8aHHnnXa1oKAB3T1U8fV1NmvqkpH1O3cpw/NUIvEyssMN7IaUHd
 ArfuwKY21FYb8gxj+18ErQdCMlYBXZbGf5wLDgkSSMBEtsLB+uCa
X-Google-Smtp-Source: AGHT+IE9+iLL/OeCxuoBtjEJ52aB2fBBMhf/CZWv95cATDYQkM4hslQJC9y3y+nFzpomQguJ/0owfw==
X-Received: by 2002:a05:6602:610b:b0:84f:5637:8dff with SMTP id
 ca18e2360f4ac-854fd89a760mr562490139f.4.1738953125324; 
 Fri, 07 Feb 2025 10:32:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 16/29] test: Drop the function for running fdt_overlay tests
Date: Fri,  7 Feb 2025 11:30:47 -0700
Message-ID: <20250207183121.117663-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

 include/test/suites.h                 |  2 --
 test/cmd_ut.c                         |  4 +---
 test/fdt_overlay/cmd_ut_fdt_overlay.c | 15 ---------------
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index dce720b4e78..78f5cdb4bdf 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -36,8 +36,6 @@ int cmd_ut_category(struct unit_test_state *uts, const char *name,
 
 int do_ut_bootstd(struct unit_test_state *uts, struct cmd_tbl *cmdtp, int flag,
 		  int argc, char *const argv[]);
-int do_ut_fdt_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
-		      int flag, int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __TEST_SUITES_H__ */
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 958b591c605..c4a42ee2e20 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -134,9 +134,7 @@ static struct suite suites[] = {
 	SUITE(env, "environment"),
 	SUITE(exit, "shell exit and variables"),
 	SUITE(fdt, "fdt command"),
-#ifdef CONFIG_UT_FDT_OVERLAY
-	SUITE_CMD(fdt_overlay, do_ut_fdt_overlay, "device tree overlays"),
-#endif
+	SUITE(fdt_overlay, "device tree overlays"),
 	SUITE(font, "font command"),
 	SUITE(hush, "hush behaviour"),
 	SUITE(lib, "library functions"),
diff --git a/test/fdt_overlay/cmd_ut_fdt_overlay.c b/test/fdt_overlay/cmd_ut_fdt_overlay.c
index c716c6bd6b0..3244f2d3582 100644
--- a/test/fdt_overlay/cmd_ut_fdt_overlay.c
+++ b/test/fdt_overlay/cmd_ut_fdt_overlay.c
@@ -236,18 +236,3 @@ static int fdt_overlay_test_stacked(struct unit_test_state *uts)
 	return CMD_RET_SUCCESS;
 }
 FDT_OVERLAY_TEST(fdt_overlay_test_stacked, 0);
-
-int do_ut_fdt_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
-		      int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(fdt_overlay);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(fdt_overlay);
-	int ret = -ENOMEM;
-
-	ret = cmd_ut_category(uts, "fdt_overlay", "fdt_overlay_test_", tests,
-			      n_ents, argc, argv);
-
-	free(fdt);
-
-	return ret;
-}
-- 
2.43.0

