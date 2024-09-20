Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04012CF58CD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA5A8933A;
	Fri, 20 Sep 2024 08:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LhaNDaX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D278933C; Fri, 20 Sep 2024 08:03:06 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0920689329
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c42e7adbddso2059045a12.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812183; x=1727416983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6w+vCz3Khe4wx7HAE7P/6ArhEY0L3lZFzeAjpvqqlY=;
 b=LhaNDaX4TtuoSAvYehl65aaw9vncXmB1CqPYRF+gsPKSZQHaQI23Ru4wecXkCQFZ0z
 I8OlLHAU65ejnNrhPEW133lrhTo7QfsZ6o+zGbgs6lMC+wuNsDAnlnRBO/8D+gHTYUU4
 3lhzsL4Qgee/F/5MYDmKyZHxkwFd8TG+26UtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812183; x=1727416983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6w+vCz3Khe4wx7HAE7P/6ArhEY0L3lZFzeAjpvqqlY=;
 b=ctQd5B9fh4VenYQ1RO/6eZJawgTAcUD/wqgk9X/3qiGj6X/yJV8Hr7tZlHIKp5qkiv
 0gE1/8Arxx2lSmEk0fL2Y7igYddWiaSOwk6S7wA9D1xMeSgZEaHb+3YdZfY+nqw5NKPy
 W2wD1e1DaQAZO5lwLdzcRl3GV29sfiY+mrcdr5k2p6+Dd/ITbJCjfHA3ExeCGTrpDD7u
 Jdt9p679sO4U4Ek1tSnXfULT8/q5fk2LeqHnlemn3m/AHgWV13xfIKRr8d7V8XJmxLcU
 L/tB+7rN01OmDhmX4NTPBhDoaS0B55H5HuE+jJySJWj6M3aI6u3tSLtpNUTSaNEXRTUC
 3iWQ==
X-Gm-Message-State: AOJu0YyPAh8GGRYWoA3lMlTKC6rufDKvoHxwRsIODhCjaCBcz2stik+5
 ar0N3qXzUfaOlnERNk1tIj0rVP3oyWTvQFTPrUnLB/MYj8y6N5yQ4r2ArHQI0SNZkuE9lGXtXY0
 GHEX8
X-Google-Smtp-Source: AGHT+IEool2gEaT5lpik2kc7LhZFMPYYa29lx8P7xhx56fds1PdCMMwpX1e1fHabws0aQ3fdz1j/6A==
X-Received: by 2002:a17:907:d59c:b0:a86:799d:f8d1 with SMTP id
 a640c23a62f3a-a90d50d1160mr112734366b.47.1726812183149; 
 Thu, 19 Sep 2024 23:03:03 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 05/19] test: Avoid failing skipped tests
Date: Fri, 20 Sep 2024 08:01:40 +0200
Message-ID: <20240920060158.106612-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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

When a test returns -EAGAIN this should not be considered a failure.
Fix what seems to be a problem case, where the pytests see a failure
when a test has merely been skipped.

We cannot squash the -EAGAIN error in ut_run_test() since the failure
count is incremented by its caller, ut_run_test_live_flat()

The specific example here is on snow, where a test is compiled into the
image but cannot run, so returns -EAGAIN to skip:

    test/py/tests/test_ut.py sssnow # ut bdinfo bdinfo_test_eth
    Test: bdinfo_test_eth: bdinfo.c
    Skipping: Console recording disabled
    test/test-main.c:486, ut_run_test_live_flat(): 0 == ut_run_test(uts,
    test, test->name): Expected 0x0 (0), got 0xfffffff5 (-11)
    Test bdinfo_test_eth failed 1 times
    Skipped: 1, Failures: 1
    snow # F+u-boot-test-reset snow snow

The fix is simply to respect the return code from ut_run_test(), so do
that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Expand the commit message

 test/test-main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/test/test-main.c b/test/test-main.c
index b3d3e24cdce..b613fc6a4d3 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -486,7 +486,7 @@ static int ut_run_test(struct unit_test_state *uts, struct unit_test *test,
 static int ut_run_test_live_flat(struct unit_test_state *uts,
 				 struct unit_test *test)
 {
-	int runs;
+	int runs, ret;
 
 	if ((test->flags & UTF_OTHER_FDT) && !IS_ENABLED(CONFIG_SANDBOX))
 		return skip_test(uts);
@@ -496,8 +496,11 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
 	if (CONFIG_IS_ENABLED(OF_LIVE)) {
 		if (!(test->flags & UTF_FLAT_TREE)) {
 			uts->of_live = true;
-			ut_assertok(ut_run_test(uts, test, test->name));
-			runs++;
+			ret = ut_run_test(uts, test, test->name);
+			if (ret != -EAGAIN) {
+				ut_assertok(ret);
+				runs++;
+			}
 		}
 	}
 
@@ -521,8 +524,11 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
 	    (!runs || ut_test_run_on_flattree(test)) &&
 	    !(gd->flags & GD_FLG_FDT_CHANGED)) {
 		uts->of_live = false;
-		ut_assertok(ut_run_test(uts, test, test->name));
-		runs++;
+		ret = ut_run_test(uts, test, test->name);
+		if (ret != -EAGAIN) {
+			ut_assertok(ret);
+			runs++;
+		}
 	}
 
 	return 0;
-- 
2.43.0

