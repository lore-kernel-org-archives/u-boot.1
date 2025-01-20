Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389B1C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 032D280BA6;
	Mon, 20 Jan 2025 22:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NExGf7ia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7503A80BA3; Mon, 20 Jan 2025 22:27:44 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D09780BAF
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a8f1c97ef1so16525175ab.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408460; x=1738013260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VorXgMg84Nf17xE9/9HcdqYB0sPbI2mi7AO5UtKlRrw=;
 b=NExGf7iaCYvPKm5z37Mq73+xnbNgGnQeRpk632aBSmO+U6stN4rwxw/XIsDuc4U3D9
 tsGD/GYoMWK5sdNqXxhZMzyD9hH2OJWYtARLQTdYy9DAI2qWIrV/W3gyWXPHl9OZrvtc
 OGHfCok9SK6yLnk5Yymzw0N78heXqFu7bu0CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408460; x=1738013260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VorXgMg84Nf17xE9/9HcdqYB0sPbI2mi7AO5UtKlRrw=;
 b=deQf+Z3Rn0fOt6S67pn3SJlwxlJQ4rA8x2LJykLWVghRbxgPuR0m81ip1MluDf7vyn
 +O2MMWZ9N/hgNRN3Gk1PiWTo6jOjvY3tR2LGzkI8kIzgfx/ERJwdvW2IZldKziOvqbkG
 G5qpumzBYgQTeUtik6/esvNpVHkddJjiAkJwESR2FBN6iqOgPYiHjBY7N5+W3kFk51NY
 pFH9MXWYHZHrn/6i+hsJCK4wu5FOCnt2xTnV2SS+5msKPNO3XnifBPXqYTo8YZ8X+Yfg
 NBw7lCea3voQboyRjTV/Jg6nMbaW8DtudDxoFUJ4TvzV3VwT3okGL+AlwMTfbCjo2jvU
 Gk8Q==
X-Gm-Message-State: AOJu0YyT7b8iNpiFKB24EHEqmSZa725NMHDgDwxj4y07Md66qJIqpRi9
 fV9SS8FrB367EmyhdIIQ9xldQjAphmRDzR1LwPn3RX8v86KJJJAH6rQWW9Isb5Yxgu9grxNgAL8
 =
X-Gm-Gg: ASbGnct+1z2N2RQqsq/t5UsI5bItxkG2c9ghBxe1Re+zRsrQEamsrJL26bokp3xYfHO
 iVFEYB2A9ZL470sUlICxSURmLw2m3PicKdIfcBja6tjKBExBwseaGzYHcXfJ6WEu54BIvPKkJjQ
 gfauZU3PZEvDs3CqjCbeiFKJM/SvxgYDvzxbvO+mjbIG+Y+aVhMMyBGIwCWZPniE/qE5R0aKinR
 DmAFHa2jQzvZOuuAgtN0V75+5lUkNzogzPa5B5I0w90EHWX6s9q66fs4lLJ8c+db+W95tRHIrp0
 frW4hxQ1E6I3yQo8Ek1qHIoHCTgBVB8=
X-Google-Smtp-Source: AGHT+IFNJZLVpeI6xYDehtfzgSwHiQvdUhW6+twwSp7faev8bu5AjcIl41t3/fYH9tRZoO/m3y4mUw==
X-Received: by 2002:a05:6e02:1aa8:b0:3ce:8898:af17 with SMTP id
 e9e14a558f8ab-3cf743ab512mr120949485ab.4.1737408459920; 
 Mon, 20 Jan 2025 13:27:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 40/44] test: Record and show the totals for all test runs
Date: Mon, 20 Jan 2025 14:26:02 -0700
Message-ID: <20250120212613.516664-41-sjg@chromium.org>
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

With 'ut all' multiple test suites are run. Add a way to collect totals
and show them at the end.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add missing comment for 'total'

 include/test/test.h | 4 ++++
 test/cmd_ut.c       | 1 +
 test/test-main.c    | 7 +++++++
 3 files changed, 12 insertions(+)

diff --git a/include/test/test.h b/include/test/test.h
index f7087ab4eea..bac43c81d63 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -27,6 +27,8 @@ struct ut_stats {
  * struct unit_test_state - Entire state of test system
  *
  * @cur: Statistics for the current run
+ * @total: Statistics for all test runs
+ * @run_count: Number of times ut_run_list() has been called
  * @start: Store the starting mallinfo when doing leak test
  * @of_live: true to use livetree if available, false to use flattree
  * @of_root: Record of the livetree root node (used for setting up tests)
@@ -48,6 +50,8 @@ struct ut_stats {
  */
 struct unit_test_state {
 	struct ut_stats cur;
+	struct ut_stats total;
+	int run_count;
 	struct mallinfo start;
 	struct device_node *of_root;
 	bool of_live;
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 80df954694f..0b8bfe603b9 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -206,6 +206,7 @@ static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
 				any_fail = retval;
 		}
 	}
+	ut_report(&uts->total, uts->run_count);
 
 	return any_fail;
 }
diff --git a/test/test-main.c b/test/test-main.c
index d02ab791b5a..22b9b46d9cd 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -694,6 +694,8 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 	bool has_dm_tests = false;
 	int ret;
 
+	memset(&uts->cur, '\0', sizeof(struct ut_stats));
+
 	if (!CONFIG_IS_ENABLED(OF_PLATDATA) &&
 	    ut_list_has_dm_tests(tests, count, prefix, select_name)) {
 		has_dm_tests = true;
@@ -734,5 +736,10 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 	if (ret == -ENOENT)
 		printf("Test '%s' not found\n", select_name);
 
+	uts->total.skip_count += uts->cur.skip_count;
+	uts->total.fail_count += uts->cur.fail_count;
+	uts->total.test_count += uts->cur.test_count;
+	uts->run_count++;
+
 	return ret;
 }
-- 
2.43.0

