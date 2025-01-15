Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2350AC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D943C80A0C;
	Wed, 15 Jan 2025 14:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lb3uUOLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23B880A0C; Wed, 15 Jan 2025 14:31:56 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D25680771
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844ef6275c5so228292939f.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947912; x=1737552712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ecBEunnlyJmpw9A4gseUNSaP2/Qvzp2qqrupHmDLZk=;
 b=Lb3uUOLBt8hzgqfNWrT1bAHKvVjWEkRQr9UYgB3LpTNqbUkENyeqCSxycXPPk1Hopz
 v+5j2nAgZ38wXOrVlJaEFJRn5dikFmjiyx+Sp368MG7tV7r8GXzqXVfks2MauE46BE7X
 UhKAg1t3G8ebBmbBvQxjSLlpbFwxo6vmydvEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947912; x=1737552712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ecBEunnlyJmpw9A4gseUNSaP2/Qvzp2qqrupHmDLZk=;
 b=jkpejpf8DqurKuoZ8Vg6QEzVLTYXL1BiIZ2oXbjw2A24JY4RXfpncQMgSahnigUPus
 72H3ivkjneqgXt7ORuLtp3a8acXoWDYDyKi8lDrBOKNE0U5plpTJHHal9KbjerVv7hif
 eHxWzmeemAWU8EYyP+NQ+lD21bd6AeCRExwW0nOIR5L3mp+32LJio9q9T8+S9wl7OvaO
 xbyrmaCRI5h5N3WPMWU9l3QDggoEnWdeGi8fq3AzxBO2K6as8NVwDFJbzp9Pw5Hzgwa7
 OV8QEyXL2grZtOHO9DL2eHOscpC71sGzugT6Gxdc5enExpCyfM4N7CywUjtiLa4+HO00
 iJiA==
X-Gm-Message-State: AOJu0YyeoetuZ1tvuP0TZXZSjGr8rvZAOnELO6kvYl+CK6Uq52AA39f0
 syQuHy058IEJsrB8KkFP+7WA8DlbZFyOxVRlfDLCc3qClcdm2DxOZpWOKkqh4+nTGHIzYSx7nQw
 =
X-Gm-Gg: ASbGncvYzWySe+1KrBZ0RiXXUSoGStR5ihuqQQVpSajZ/6aYpyE35rYYYWVuPipKOA3
 RSdE0yc5lP+LxLx8BX7VxnoItP8ddgt78Rqu4bPBwcUMvX8JOf530JcLvcsqJIobLtYXXwGjPhz
 WP4PO7LioyUhbmU2Qg140FEP+8VoLhAg1LEsGXjM89AG9LCmwiBOpzoa0yWmKC1tgvBqStF97YX
 s95iKceItM/6Jm3ToWBN/f2xvqsU1aV9SUKalKWo+c66gtjrIAPLJHepVdryIVFycILP308JASP
 y09VXgsN1yVYAKidGQ==
X-Google-Smtp-Source: AGHT+IFxallVe2/lopctIaaUbOn2zCyCfQnbHg70YOrckPygj38ue4Z9kkeTDQg0fulq/wpqNareeQ==
X-Received: by 2002:a5e:d511:0:b0:84f:44de:9ca7 with SMTP id
 ca18e2360f4ac-84f44de9d23mr925437839f.3.1736947912600; 
 Wed, 15 Jan 2025 05:31:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/43] test: Drop the function for running font tests
Date: Wed, 15 Jan 2025 06:30:49 -0700
Message-Id: <20250115133114.590375-20-sjg@chromium.org>
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
index f6c28c73981..f9cf7b93412 100644
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
2.34.1

