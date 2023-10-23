Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811A9C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3591D87893;
	Mon, 23 Oct 2023 09:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ft1tNW5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74EC18789D; Mon, 23 Oct 2023 09:03:55 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F22E87874
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b2ea7cca04so2216594b6e.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698044632; x=1698649432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIwvqOWntoH56aVh+uK5vSKMw8BFeAK+5xfygEqOPIs=;
 b=ft1tNW5rHnnlnf552nQnVvJdgHJqUOIPR89PZQ12NUAyrlDzlzOEdzF55vs0bmokXJ
 czzGmRw8FwBvmzO/fekIxGsNzg40U5ypkgqj13Plvj07iGgJvNLbwmOGyYwpTD86eBO8
 HxWQUCwgkoFZldu1VLcZHUzw69U1vUVcLpDqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044632; x=1698649432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIwvqOWntoH56aVh+uK5vSKMw8BFeAK+5xfygEqOPIs=;
 b=AvcWPKPeRESlQnvwva3Yydv23E8Q1GOx+sH830m0arYUvEW4+J/TkXRzyM0Z8amaDR
 4dvztcY+Hh54LqVGw9cD0R65sHvXrvqUPURdBpVFT3yX2LhoN7ZxPD1EcKy9Hqr3ATlJ
 9eOCuyD+UHHeMAIvdTR918uaO5Bja38XSaNAzNV57JBYkDgWJeNK9OBHBuJj2Y2sTNZ1
 poF5sGH839p3nx69X+ImsEwsgz8JIZFnwe4WBsXMMM13hVQ1ZDpdhKzKI7ai1jE67Ixo
 4hOXD6ACVKkBijBRqW8t2V1Wf12AAun1z+mrhyFaq/UgyxuplGyHQHWGmwL7maxTzdVv
 IX4A==
X-Gm-Message-State: AOJu0YwtYv7Lh6kUp+eOTO6dV8tIAMnl+FJU9kPSXGHNBjxPmbWNgo0/
 gEs6R/iZt+vLqxRzuubv1ROzFkNfj6SlCXza5g7l1A==
X-Google-Smtp-Source: AGHT+IHvJm5/lr6rXt08U65SxntTogh09qTfiLs2+CF8IjsSnkkTeqbhy/o2f2YjHn0GHRZ0TtCNpA==
X-Received: by 2002:a05:6808:e85:b0:3b2:d8cb:8e14 with SMTP id
 k5-20020a0568080e8500b003b2d8cb8e14mr11558910oil.28.1698044631920; 
 Mon, 23 Oct 2023 00:03:51 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 u187-20020a6279c4000000b006bde8e1f0adsm5910841pfc.98.2023.10.23.00.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 00:03:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume Gardet <Guillaume.Gardet@arm.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/4] bootstd: Expand boot-ordering test to include USB
Date: Mon, 23 Oct 2023 00:02:11 -0700
Message-ID: <20231023000211.2.I9d49d1e28d3ef75af768dc20bb491e4c82e4ab76@changeid>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231023070216.394709-1-sjg@chromium.org>
References: <20231023070216.394709-1-sjg@chromium.org>
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

Scan the USB bus as well, so we can check that different uclasses work
correctly in boot_targets

update the function comment with more detail.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/bootdev.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 6b29213416db..7228f545e9e6 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -190,12 +190,21 @@ static int bootdev_test_any(struct unit_test_state *uts)
 BOOTSTD_TEST(bootdev_test_any, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
 	     UT_TESTF_ETH_BOOTDEV);
 
-/* Check bootdev ordering with the bootdev-order property */
+/*
+ * Check bootdev ordering with the bootdev-order property and boot_targets
+ * environment variable
+ */
 static int bootdev_test_order(struct unit_test_state *uts)
 {
 	struct bootflow_iter iter;
 	struct bootflow bflow;
 
+	test_set_skip_delays(true);
+
+	/* Start up USB which gives us three additional bootdevs */
+	usb_started = false;
+	ut_assertok(run_command("usb start", 0));
+
 	/*
 	 * First try the order set by the bootdev-order property
 	 * Like all sandbox unit tests this relies on the devicetree setting up
@@ -213,12 +222,14 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	bootflow_iter_uninit(&iter);
 
 	/* Use the environment variable to override it */
-	ut_assertok(env_set("boot_targets", "mmc1 mmc2"));
+	ut_assertok(env_set("boot_targets", "mmc1 mmc2 usb"));
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(2, iter.num_devs);
+	ut_asserteq(3, iter.num_devs);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[1]->name);
+	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
+			iter.dev_used[2]->name);
 	bootflow_iter_uninit(&iter);
 
 	return 0;
-- 
2.42.0.655.g421f12c284-goog

