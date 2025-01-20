Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF94C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D8B980AE5;
	Mon, 20 Jan 2025 22:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MZwiSYSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6ACB80763; Mon, 20 Jan 2025 22:27:30 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD91880818
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844e55a981dso134264239f.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408447; x=1738013247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwe3seP/0l5AHmC7UbV4+u/BX7zbtGNlzecqAKj4wxk=;
 b=MZwiSYSFNUjeLMbRBySS0Fg9Xg+eN9Yx2cC+72K6XlpmKNV/6tI4/UQ40p23T9fdc1
 aaod0SmifkBjK5pI+vtebiJSlZcc1zn1k9SbWAGdU/mAQmnEOsTkiuCjLwHqvzavnJ+s
 TvJO3C+1i0Zq8qTbK7mDGfkjS79Sb1ZnHDrpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408447; x=1738013247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iwe3seP/0l5AHmC7UbV4+u/BX7zbtGNlzecqAKj4wxk=;
 b=ouBxhJXV+AL8MndDmtJLZnsnWpw+P08GA64RhqyWIBLPeViuD2UXrNwXdgAytryneB
 /etCFsTriKOKkUahwcbOM5ujjR9vt0Bs04JUQuTrGOECC/j2vQTA3j1m6iAKuyO4evLF
 GLJwMkskzb7+gEfsHqraKDcUnYK6TQ86ec5B6mkO1jecVSJdC6/SEsNrC8dTklvOFmGI
 TfN0UIOUvMMeqqGPEdu4HYsPHtxTVwt9Rx0DrBz0Y5WnIfA3VNRCW4wwvpJOXqNu8bC5
 i4HyaWkbpqyezygPMIsOV/yrtRlTyb5ERdavHH1ip1zDzdvuPefdbafQTIj6ulEA/Bt4
 XEjg==
X-Gm-Message-State: AOJu0YwckpDkwL+Im3GkQl7G98WZ72t/nLTwOvjrcT1kzc7qkahavQRR
 fe1egAWtHFzr83cqzITSnLG5Zz+tpw1aMICjf38VIPYLGO4Wf9JQtY6YZz7baxWklZFEyOAnyVg
 =
X-Gm-Gg: ASbGncta/JUKevvc/o1l7F0CIBSamAzgszQ1ILylR67Peo/Jzrxu58qko+TBbeO3Vbx
 Oi4R2kCP/26jlar8Xi8eEfe/v/dhATgKsQx2e4zOx49gO3vCk85I5epDVcwhKeWII3Rx+aeO+hy
 S6twXY+75dhjXmCFT8B0S49AdR1UpTk2MqHwbZXMi/UJQfTCvheqgcCTBvmWAd0elN7BS35OW/e
 M/AeAYP1VBJbHbCTmzdRqHfrApMiE3r4cuyoEdZnOcWPjtzOmdRjwGgViSq9nUyuBDrrexj87Gk
 04UGF5w5AxBOz4eq3vi9nn2cY+vPiT8=
X-Google-Smtp-Source: AGHT+IFL02DZESCTIwcG7/4h/Wm4DCHZ+J+JULFy62rzXYr8Pu8YkLQdx8lEXwZeqruTLg0KbNQBVw==
X-Received: by 2002:a05:6602:29d4:b0:841:a80a:f536 with SMTP id
 ca18e2360f4ac-851b62b394dmr1147528839f.14.1737408446981; 
 Mon, 20 Jan 2025 13:27:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Linus Walleij <linus.walleij@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 32/44] test: Drop the function for running seama tests
Date: Mon, 20 Jan 2025 14:25:54 -0700
Message-ID: <20250120212613.516664-33-sjg@chromium.org>
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

It is not clear that these actually work, since they are not enabled on
sandbox for some reason.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/suites.h | 1 -
 test/cmd/seama.c      | 9 ---------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 49c18ebf456..cd758b8c464 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -35,7 +35,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_seama(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __TEST_SUITES_H__ */
diff --git a/test/cmd/seama.c b/test/cmd/seama.c
index 39590d162ac..1edc3fcac5a 100644
--- a/test/cmd/seama.c
+++ b/test/cmd/seama.c
@@ -56,12 +56,3 @@ static int seama_test_index(struct unit_test_state *uts)
 	return 0;
 }
 SEAMA_TEST(seama_test_index, UTF_CONSOLE);
-
-int do_ut_seama(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(seama);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(seama);
-
-	return cmd_ut_category("seama", "seama_test_", tests, n_ents, argc,
-			       argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 080a36a909c..ed6bc3a9a49 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -187,7 +187,7 @@ static struct suite suites[] = {
 	SUITE(pci_mps),
 #endif
 #ifdef CONFIG_CMD_SEAMA
-	SUITE_CMD(seama, do_ut_seama),
+	SUITE(seama),
 #endif
 #ifdef CONFIG_CMD_UPL
 	SUITE_CMD(upl, do_ut_upl),
-- 
2.43.0

