Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2516C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE854807F3;
	Mon, 20 Jan 2025 22:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MYwF5it0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9E598082A; Mon, 20 Jan 2025 22:27:06 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A863B800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3ce873818a3so49957565ab.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408423; x=1738013223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7s5xVCHHoFOVqrm/3muISoP440UuOBxwpnpxvrSa3Q=;
 b=MYwF5it0eM5FsollZB6Z2vDxPs6KngWlbbF+DQVDSx4w05TG7bGjxxg1wVwH2YG0rJ
 S4ge1toBSiXnz6cxVzuPdHr29Bkgk1Cxvkwpq2mkcS+hKNFFL54lNaF6tcOp45jAeE8k
 X3KxIqVTnlTysTLrzBMUBTErqoupvO7w5BZAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408423; x=1738013223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k7s5xVCHHoFOVqrm/3muISoP440UuOBxwpnpxvrSa3Q=;
 b=GpBrh8MtTsEY3ws4TJW0R9DihjEDN/srZuwrscCaJRXFzxemRcKpuQVTnuFvOXJH+N
 OHzEGwTzDoNEbWd6UjaqrHm2vnAMuJWKEoqqRlqMGGE/6mmj4QrQaNPeJx1OoqBMNT2A
 HAHkTEb/gx1rr1PWdTiWAQewboA6U01WP2+clPORspNRhS1Lmg6xYtW9OFdzuXhGT1Yx
 SEmhM1+nFZnYAt+Red3uL0ykhqXapDmndrGCqnU6ZtqSCM7kjfsLjD+HvY0H6XG/41EX
 QsHbUs+vOAIAxYzhdjcueqqz66O79Mc0nPBr2nKuaTljI5Nb1ob1Xx7nFEZVdzJmnWrr
 UX1A==
X-Gm-Message-State: AOJu0YxytLzV0nIRmxjpbFk0tCg9CDQ4JBsA+8FtlKZjHhbGrr6hbTT6
 J1PYYIMU4tVJfI0iTZGukI6JktNUkGkTvigcsDCLdkRV5MgzRAgQ7pUN8CWeR1Odt/wns0nRcWM
 =
X-Gm-Gg: ASbGnctEkqsZic/rwUAJ39BKHgfedI3s7lh6g4dsr1Qn6gDE5COp8ntQni0Lff+mJoe
 ox1W8rghfxZhzrjoigjqYrFC8i2+7QcUWj+Mo8WH547h2mPuNCZ68PE0wqTDBt5lknsrC0ELH5e
 90GXiG1NN3sDTBZUoP5LbDC64wk1JRY2+POLcTpDT9J2bwH+5HorwWUtqRAA0bIv2edqjLMi0O/
 9dfffiiAgEXHgvJu2DXO7I6dJH+WUacct+UnrGrLSj+mZzZ0Edv5ywGl5lDpr6Vjtj1Iv5uNLRr
 GopVFCgvHt5e1d8ZdLQLye6bUYQPruk=
X-Google-Smtp-Source: AGHT+IGlzmnY6jCJJoPKx1o7uaFh4UrJlbsQhImX/caTDmP4g/YKuQg9n1bAMI7tpWq88g/aY2tJZw==
X-Received: by 2002:a05:6e02:460d:b0:3cf:a0fc:5388 with SMTP id
 e9e14a558f8ab-3cfa0fc5ae8mr21125315ab.19.1737408422982; 
 Mon, 20 Jan 2025 13:27:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 19/44] test: Drop the function for running font tests
Date: Mon, 20 Jan 2025 14:25:41 -0700
Message-ID: <20250120212613.516664-20-sjg@chromium.org>
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
 test/cmd/font.c       | 8 --------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index bf3a9851322..587d6a5b473 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -37,7 +37,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
-int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd/font.c b/test/cmd/font.c
index d860efe8ce5..af88d1b5459 100644
--- a/test/cmd/font.c
+++ b/test/cmd/font.c
@@ -85,11 +85,3 @@ static int font_test_base(struct unit_test_state *uts)
 }
 FONT_TEST(font_test_base, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE |
 	  UTF_DM);
-
-int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(font);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(font);
-
-	return cmd_ut_category("font", "font_test_", tests, n_ents, argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 0babc91d118..db96a4ac2ac 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -143,7 +143,7 @@ static struct suite suites[] = {
 	SUITE(fdt),
 #endif
 #ifdef CONFIG_CONSOLE_TRUETYPE
-	SUITE_CMD(font, do_ut_font),
+	SUITE(font),
 #endif
 #ifdef CONFIG_UT_OPTEE
 	SUITE_CMD(optee, do_ut_optee),
-- 
2.43.0

