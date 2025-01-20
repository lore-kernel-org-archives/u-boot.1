Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EFBC02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 566B2809D2;
	Mon, 20 Jan 2025 22:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XcBtqUzx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A665E80BA0; Mon, 20 Jan 2025 22:27:40 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8285380A4E
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-844bff5ba1dso384296239f.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408457; x=1738013257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dn8qPUxNXPG+zF3xtd7T3lg+WmHKU9Npt1ZUjttvfbw=;
 b=XcBtqUzxDQA74jW8htB/leQ6I5guqruTXxjtOIg/FYloKr2o8pUpjvc6P2LS0MIHk5
 BtRHfjrXiSpiTBhPWg7jHS+MeQm403TAr09+gkoUo5NCta2gLuU9yv4f01G3DNpUSz07
 B+uJIfomsXO7urqGBRMJAfTRDMNoeQ+Powsi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408457; x=1738013257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dn8qPUxNXPG+zF3xtd7T3lg+WmHKU9Npt1ZUjttvfbw=;
 b=M62GwX4TQ5ZjJTME7FEysFjwp9nowwQLipu3DU3qR3G+W42nZML/FDnSooAhtWr7WN
 LwLriFvgkysfdgI8XCwmFZhKaq7KeeA8YqdSWgBCLzEAbEWE3XnQJ+wx2y8ZiGRC488g
 FU2z2ja/7gn8430OtLnyHz6Qn4Y1z8MH9ZqQsze9r+VclhoOaDEtnBtZ8Uq9AH563L0z
 6jchS+6iGXC8qemwABC2g/EeA9ATF4zgXVFNaX6F2d+ujoB2m+ztDCVyU+2hztPN0006
 YC1F1LMgdCBhioDV42Cqj8CvezGgA5ntoUYyrLspQrVvqZFA4GGEa2D3XEkVK8tEtSVs
 6GKA==
X-Gm-Message-State: AOJu0YyggK5+vmsqURsD1WjzElGxb9QtsmDVDPJNuT8wrM+4U/DKKTxE
 fmAzyUrVTE38k5PqzrLaSmdzpVRhpuLcU2QYXOIOml+Gvc08r33Dq9JgZh+MtUrOCbSP8nXTnDY
 =
X-Gm-Gg: ASbGncvjYzlZS80gTNqunl+gA0yJh8kkCKGyZBgTpW7mJzNCeSJ046HehD5o0iCbeFd
 GFsb9gWJwUCkurjgTLKReGBRp7bbsb+cwgCVhNzK6OHiwkn4D8Xv4zni39y1OXrml3+VkVX/8ST
 AtG1XHi7zVT0jb7XX0P/UtMOQWnp6JHDX4vdJMTNw3QRqdXm+uVVlzPX50ovcZ9cMAQgkHdWrrQ
 hWzXZHCLWoBEksJprxJnArSl+60N6OagFqrmuvBp7HEi0Tw+8/01b6Sgsf0bDUj95THUQuLHUFX
 rmb+Yvg1sjBoIvSRLUxVC5ofZC4Z7UY=
X-Google-Smtp-Source: AGHT+IGTKj7J61z/Ja5VfP0ZJT5Np0OMZa3mwbeHB6iGUbe2Cc94SiYoJyToLLUN1iZiPt+rAJ5Mlg==
X-Received: by 2002:a05:6e02:1feb:b0:3cf:712b:e4e3 with SMTP id
 e9e14a558f8ab-3cf743c6bf1mr129171955ab.1.1737408456769; 
 Mon, 20 Jan 2025 13:27:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 38/44] test: Keep a track of the numbers of tests run
Date: Mon, 20 Jan 2025 14:26:00 -0700
Message-ID: <20250120212613.516664-39-sjg@chromium.org>
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

This is useful information and is not always the same as the 'count' arg
to ut_run_list() so add it as a separate stat.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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
2.43.0

