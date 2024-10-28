Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE167D10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FFAC8915F;
	Mon, 28 Oct 2024 13:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHQQ0pGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC10589164; Mon, 28 Oct 2024 13:42:12 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D7089099
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c99be0a4bbso5851650a12.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119330; x=1730724130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEHyhziWd7Z4hka3w30/BDpLeYFhvgEs4/NDvbyM5r0=;
 b=EHQQ0pGlceb4I6UPNzlWVEAibBFamCpskXM6S6ShnwLgie/t1ttpyYxoORdCNnP0Hj
 qzefrR9+/dtQ+8PjRudkYyYH/lpOK6+xrG0g0V8MssEYw7VVZGcXd+B3MDgUi9cBWZw3
 Jk+HJMky18XZ1bCMv2dkfhIu9FO4mdXMPok2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119330; x=1730724130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hEHyhziWd7Z4hka3w30/BDpLeYFhvgEs4/NDvbyM5r0=;
 b=EZSY5SdzCBbYejouZwBnN4wEnNc/sSd2YssZSkTed6TBorDAttLJWXVFdxIgHt1wAK
 K6yvNjP2+nfu0qS4Qjyd2z00jzuC4tvkHyl0PHGJboY1bSp8R19jhBUygnoFi5h/u/3P
 o7yZlO79zzFLLtMwBIEmr6J1ARiYzsGQhnhIWqlytRC0gx6Nj5s0PYggrViz6308jaDz
 IqqHjALM/K9aB/9smTa1MUmaJdTHmzMwl9bSI59oJ5LBXJusc+xmnpStNeLVYDszMpi7
 UbN9c1M460ULn4DdwJ1/6XcjDHkWqQhGbVTMB4vDPyuR6jzhhjYT0ZrROFoXwhNmYowR
 +wGA==
X-Gm-Message-State: AOJu0YzYKtyqjVUqsnkAX+YXcBUhQS6WTrEJT/9zYVObbYoa9CcD2zAz
 lRyF264PNveV1j5aELSY75DnjEWXYpF8DlAo+iAn+2HWDYgPZQr2eJAgsITgim/7w1g8O2co59h
 /EA==
X-Google-Smtp-Source: AGHT+IEtUTWYgidzhSLJ7jxd2sIExWzF1got7meF8J1kx0F1r6pzxzsBmYttwR0OO7GKa4aAuFsEgw==
X-Received: by 2002:a17:906:f590:b0:a9d:e1d1:bf95 with SMTP id
 a640c23a62f3a-a9de5cea078mr728064166b.25.1730119329884; 
 Mon, 28 Oct 2024 05:42:09 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:42:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 21/21] test: Quote test names
Date: Mon, 28 Oct 2024 13:41:26 +0100
Message-ID: <20241028124130.32072-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

When mentioning a test name, add single quotes to make it easier to see.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/test-main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/test-main.c b/test/test-main.c
index e4f42689da4..c825f9c7797 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -594,14 +594,14 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 			 */
 			len = strlen(test_name);
 			if (len < 6 || strcmp(test_name + len - 6, "_norun")) {
-				printf("Test %s is manual so must have a name ending in _norun\n",
+				printf("Test '%s' is manual so must have a name ending in _norun\n",
 				       test_name);
 				uts->fail_count++;
 				return -EBADF;
 			}
 			if (!uts->force_run) {
 				if (select_name) {
-					printf("Test %s skipped as it is manual (use -f to run it)\n",
+					printf("Test '%s' skipped as it is manual (use -f to run it)\n",
 					       test_name);
 				}
 				continue;
@@ -612,7 +612,7 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 		if (one && upto == pos) {
 			ret = ut_run_test_live_flat(uts, one);
 			if (uts->fail_count != old_fail_count) {
-				printf("Test %s failed %d times (position %d)\n",
+				printf("Test '%s' failed %d times (position %d)\n",
 				       one->name,
 				       uts->fail_count - old_fail_count, pos);
 			}
@@ -622,7 +622,7 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 		for (i = 0; i < uts->runs_per_test; i++)
 			ret = ut_run_test_live_flat(uts, test);
 		if (uts->fail_count != old_fail_count) {
-			printf("Test %s failed %d times\n", test_name,
+			printf("Test '%s' failed %d times\n", test_name,
 			       uts->fail_count - old_fail_count);
 		}
 		found++;
-- 
2.43.0

