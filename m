Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CA8C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 626EC80C75;
	Wed, 15 Jan 2025 14:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g+7qcnKs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAD2C80C8F; Wed, 15 Jan 2025 14:32:28 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B40A8096D
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-84cdacbc3dbso521271039f.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947945; x=1737552745; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BkFmaOuhQjVWszjPFXj5NKbgQtlK8HbdyApsgBhUZFo=;
 b=g+7qcnKspsciI27oKOrg32BwEtfikyI/H93WC1QYYvOdAjcAVdGwVezqgB3a2IuYYK
 QVbGsyIzMgYOf7Z8EZUgQcyOtVSiEjLfkSEcBTJPaJVfVw+IgUniCFhIYtabjtFwVBCR
 mmErvFMbUWDpCxyNGOjks09BPLrcTmo3sdA6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947945; x=1737552745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BkFmaOuhQjVWszjPFXj5NKbgQtlK8HbdyApsgBhUZFo=;
 b=OCb1M5hBvOzhzUOdRGa1jQOJ6RBWRqVS9EFSVRHUrxjrzJ3gymmfyb1jYVmOT4SQ65
 YT3AdqsEhpQ0ZNzKdxyv5L2I6O9Y0dzuq3SCE234VELxd0cF8X/Mkvp6uk5YLMoFP+6p
 w0qDNN/tvwqnB7QEw6qdE5tXwwDk3Y+723Xr7udilUX5iRwNt+MCd+MmGdbXPyJVTR9N
 w6t97fET/MF/ma8EmdgOiQIVTTSAody8F8Ry3wYfAkOjjiHRC+XKvydjcT8JgB33yC/G
 TXQUnVujY8+YJNn8Mut8GKwLiTFdNgoLyR8o9eavPhfmOcAT+z97hzhGpYO87G3JwKXB
 OFiQ==
X-Gm-Message-State: AOJu0YxU7oRdvjJn7k3bNbnpG9GHenZMabsMCV4qejxXalD03UZkuR+H
 y9tY64KOrsK4LObO5ipmHp6fnPBVFgZVVWH8+/kKu6k3UXQIYkauf38+ZICQT5rOqsLaup5WCCA
 =
X-Gm-Gg: ASbGncvU4AFRNxhhRuGmUyzg3I6labSNEIuA6yByERBGPbAWJEEF1TNX2eRVCUwFBt4
 89sINdqq+qNXXXV28Pif/+K5W2fG8UF4SFAZPxQncA+yYZwbEvo4SOc7FCLxOHw5eG40LbFJIUp
 RvOQwXkwknZKThFs/1aeCHtJo29CsnUnKEKpTuCN2aeLJRkGbudqEoSlp7CMuWurTr+mQLIzJiK
 yYqAhT8wX5ZZMIskQgYvncjunsE68oiwY3snrzqJuge23Or505Lsm4gYnBvaU0wVDOIxaVIJL9F
 0QZ719VVvROdB7O/Fg==
X-Google-Smtp-Source: AGHT+IEjtfWgbzc/wWG/gTfk4n4fvhAEPQrdECNv3gDk5fL2lfANftDVlWqrgmeJYmLt2sIdi4jrdw==
X-Received: by 2002:a05:6602:3685:b0:847:22a7:240e with SMTP id
 ca18e2360f4ac-84ce01a4b45mr2768142739f.13.1736947944816; 
 Wed, 15 Jan 2025 05:32:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 38/43] test: Keep a track of the numbers of tests run
Date: Wed, 15 Jan 2025 06:31:08 -0700
Message-Id: <20250115133114.590375-39-sjg@chromium.org>
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

This is useful information and is not always the same as the 'count' arg
to ut_run_list() so add it as a separate stat.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/test.h | 3 +++
 test/test-main.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/test/test.h b/include/test/test.h
index bc8f0bbe501..f7087ab4eea 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -14,10 +14,13 @@
  *
  * @fail_count: Number of tests that failed
  * @skip_count: Number of tests that were skipped
+ * @test_count: Number of tests run. If a test is run muiltiple times, only one
+ *	is counted
  */
 struct ut_stats {
 	int fail_count;
 	int skip_count;
+	int test_count;
 };
 
 /*
diff --git a/test/test-main.c b/test/test-main.c
index e8aecd267c7..e36bc37d29e 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -643,6 +643,7 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 		}
 		old_fail_count = uts->cur.fail_count;
 
+		uts->cur.test_count++;
 		if (one && upto == pos) {
 			ret = ut_run_test_live_flat(uts, one);
 			if (uts->cur.fail_count != old_fail_count) {
@@ -717,6 +718,7 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 	if (has_dm_tests)
 		dm_test_restore(uts->of_root);
 
+	printf("Tests run: %d, ", uts->cur.test_count);
 	if (uts->cur.skip_count)
 		printf("Skipped: %d, ", uts->cur.skip_count);
 	if (ret == -ENOENT)
-- 
2.34.1

