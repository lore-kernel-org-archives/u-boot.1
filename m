Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF30C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A982088B9C;
	Thu, 22 Aug 2024 15:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EcGqHKyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94B4788AB9; Thu, 22 Aug 2024 15:58:24 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4443E8882C
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-39d4a4e4931so2640635ab.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335101; x=1724939901; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+de/Hrz2/BFE5QAajnrAqyinOWzg+IdUJyhMKd0Z/8=;
 b=EcGqHKyIVjgcpRWG+yNKldihPdgxDUk+/B3AFHmQRWYL4/HmSWyJtDaCw13eqenc5p
 Mr2MC/bSsNfDvMenks1QyEZaUX3ZJXITxJ4wnGtlJAwf7puofHNBPgjzPAOHU+PGwbbN
 SX7guY7De/cuxtQlz4q8tueMJUhclhDOWPfVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335101; x=1724939901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+de/Hrz2/BFE5QAajnrAqyinOWzg+IdUJyhMKd0Z/8=;
 b=oHTWzJcPEkydhQmQJxh2hSa1V/BbYNH3QUpvUwNrr6YPVB7FGfz4FV9gb9uApVF+68
 oj/lT81OmLm7cGAGwn72ISreo7yaxRWoWrXmHOjFziz5gdn1S3LMDWVFr6EcGhW9HliB
 Z6k7PSPdf6EoMWJegzMC4hQfhWI2DRE56btaLEo7hDJ5YloMKXnSbWm/t74zhjyb5mrM
 qepwLIVOnHAMK5n2BLC0ok+oNXys+Rt35AcFa+BsCYIs/cnjN/GahEL5c5SpA6yIvCVl
 734FjEGgxQCzcEqAAyLcS1CHldW41y4XKXVGA0DewNfDjifocTI6rdPiRGRNKX6j2XhB
 b0rw==
X-Gm-Message-State: AOJu0YyYQgsHV5X7qMLV503P7TkNfQvdVbEcvugkB90ET417fwa0CeVP
 mFQGq/z7QZxgj4EiBUJz8rnn+espbJWg4NG7sTavhRASZTdFpFbo6Rh5+DggGawmBA9f0HOg7jo
 =
X-Google-Smtp-Source: AGHT+IFRT6RT+EkZgmYfNkV7Cg8kCWjQ85W7wEOqWlQbbHCfD9JvWwWMyhNK7zwZiHSCcvl89MQA1A==
X-Received: by 2002:a05:6e02:138f:b0:397:d9a9:8769 with SMTP id
 e9e14a558f8ab-39d6c3c6f15mr71754155ab.24.1724335100816; 
 Thu, 22 Aug 2024 06:58:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 07/19] test: Update NAND test to avoid extra macros
Date: Thu, 22 Aug 2024 07:57:52 -0600
Message-Id: <20240822135804.2375959-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135804.2375959-1-sjg@chromium.org>
References: <20240822135804.2375959-1-sjg@chromium.org>
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

Write out the tests in full to allow the test to be found more easily
when there is a failure. We could use a single test function with a
for() loop but this would stop at the first failure, and some variations
might while other pass.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rewrite as separate functions to avoid the macro

 test/dm/nand.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/test/dm/nand.c b/test/dm/nand.c
index 397cc88567c..c7e09850503 100644
--- a/test/dm/nand.c
+++ b/test/dm/nand.c
@@ -12,7 +12,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 
-static int dm_test_nand(struct unit_test_state *uts, int dev, bool end)
+static int run_test_nand(struct unit_test_state *uts, int dev, bool end)
 {
 	nand_erase_options_t opts = { };
 	struct mtd_info *mtd;
@@ -88,17 +88,34 @@ static int dm_test_nand(struct unit_test_state *uts, int dev, bool end)
 	return 0;
 }
 
-#define DM_NAND_TEST(dev) \
-static int dm_test_nand##dev##_start(struct unit_test_state *uts) \
-{ \
-	return dm_test_nand(uts, dev, false); \
-} \
-DM_TEST(dm_test_nand##dev##_start, UTF_SCAN_FDT); \
-static int dm_test_nand##dev##_end(struct unit_test_state *uts) \
-{ \
-	return dm_test_nand(uts, dev, true); \
-} \
-DM_TEST(dm_test_nand##dev##_end, UTF_SCAN_FDT)
-
-DM_NAND_TEST(0);
-DM_NAND_TEST(1);
+static int dm_test_nand0_start(struct unit_test_state *uts)
+{
+	ut_assertok(run_test_nand(uts, 0, false));
+
+	return 0;
+}
+DM_TEST(dm_test_nand0_start, UTF_SCAN_FDT);
+
+static int dm_test_nand1_start(struct unit_test_state *uts)
+{
+	ut_assertok(run_test_nand(uts, 1, false));
+
+	return 0;
+}
+DM_TEST(dm_test_nand1_start, UTF_SCAN_FDT);
+
+static int dm_test_nand0_end(struct unit_test_state *uts)
+{
+	ut_assertok(run_test_nand(uts, 0, true));
+
+	return 0;
+}
+DM_TEST(dm_test_nand0_end, UTF_SCAN_FDT);
+
+static int dm_test_nand1_end(struct unit_test_state *uts)
+{
+	ut_assertok(run_test_nand(uts, 1, true));
+
+	return 0;
+}
+DM_TEST(dm_test_nand1_end, UTF_SCAN_FDT);
-- 
2.34.1

