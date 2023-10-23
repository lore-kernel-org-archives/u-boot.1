Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A384DC25B41
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A36A87880;
	Mon, 23 Oct 2023 09:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g7MVFEGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EC9687897; Mon, 23 Oct 2023 09:04:03 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1B5887880
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3af604c3f8fso2266068b6e.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698044639; x=1698649439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQHdVZoqu6vL//0Rc8e1SX1+2VK3djq3hW1NDOA/VUc=;
 b=g7MVFEGdmwlVgYbQvsUlLUH8u5YdqRAZZ7IGvJkKw+t9TgR7CBLAz6FTbcUqCf7ix3
 ka6wz36z3I7e9+8Vu/XxtfjMh+FsE2MmR1pR8WtODlM2rNTfjAL7SzMzFwNNdBolnbaF
 YEgrsCKckVERiDmY6ZcR1st7af2v4Zd3IMEjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044639; x=1698649439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQHdVZoqu6vL//0Rc8e1SX1+2VK3djq3hW1NDOA/VUc=;
 b=dmetYCxcqOdjG06nNcEgNsHTXN2i2yJe2yaTu9+igYWthZh3jBPskXE+lqfItnIeWl
 7Ti/qjE0EfHZfEfg2qVDuxSbj3zUqB8FRtcGV9rNXUn6NCsu3+zbWL03hsVUpc3vryFx
 jWRyDrV2iQXJFbTcXuutCHCXNMwcCuHwGgN1nSfK/4Dxxw4T8y/c0y2O8gb1V3cURCB4
 iIUvgFjuI6Cr+EVLkWuTmm292mJryz7Wnj14Gvh1f3kgdWqfDOCJHBmSu2DImC0KGlsU
 5OwVzpagMZfWwuofbsHzRRvhzjEWAFhbwaIB7TeQMQBQfO+eAJ4ItsCll1m4KCusAJtm
 fq2w==
X-Gm-Message-State: AOJu0YyL+7DxZXljBQhaS2gWBuhvR5uESsc040WsnLpteLMvL8txONvN
 ASxmZ+0rltdSHxuUUw73ZNSNctboaLQkz2ygO4kSZg==
X-Google-Smtp-Source: AGHT+IEn4DDw7VvfhcVhjZx6AfZZp+iDzM6s6RxSA4wM8oGRbEEwrJxjkMtDfxGtuPQjJkuiEWQW+w==
X-Received: by 2002:a05:6808:4d4:b0:3a7:44da:d5e6 with SMTP id
 a20-20020a05680804d400b003a744dad5e6mr9586643oie.38.1698044639506; 
 Mon, 23 Oct 2023 00:03:59 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 u187-20020a6279c4000000b006bde8e1f0adsm5910841pfc.98.2023.10.23.00.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 00:03:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume Gardet <Guillaume.Gardet@arm.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Date Huang <tjjh89017@hotmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Ivan Ivanov <ivan.ivanov@suse.com>
Subject: [PATCH 4/4] bootstd: Scan all bootdevs in a boot_targets entry (take
 2)
Date: Mon, 23 Oct 2023 00:02:13 -0700
Message-ID: <20231023000211.4.Ie4e7ba290d4957a88bebf306ca39f46618d9c363@changeid>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231023070216.394709-1-sjg@chromium.org>
References: <20231023070216.394709-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When the boot_targets environment variable is used with the distro-boot
scripts, each device is included individually. For example, if there
are three mmc devices, then we will have something like:

   boot_targets="mmc0 mmc1 mmc2"

In contrast, standard boot supports specifying just the uclass, i.e.:

   boot_targets="mmc"

The intention is that this should scan all MMC devices, but in fact it
currently only scans the first.

Update the logic to handle this case, without required BOOTSTD_FULL to
be enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Date Huang <tjjh89017@hotmail.com>
Reported-by: Vincent Stehlé <vincent.stehle@arm.com>
Reported-by: Ivan Ivanov <ivan.ivanov@suse.com>
---

 boot/bootdev-uclass.c |  3 ++-
 boot/bootflow.c       | 22 ++++++++++++++++++++--
 test/boot/bootdev.c   | 32 ++++++++++++++++++++++++++++++--
 3 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 974ddee5d2fa..44ae98a9269c 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -469,10 +469,11 @@ int bootdev_find_by_label(const char *label, struct udevice **devp,
 			 * if no sequence number was provided, we must scan all
 			 * bootdevs for this media uclass
 			 */
-			if (IS_ENABLED(CONFIG_BOOTSTD_FULL) && seq == -1)
+			if (seq == -1)
 				method_flags |= BOOTFLOW_METHF_SINGLE_UCLASS;
 			if (method_flagsp)
 				*method_flagsp = method_flags;
+			log_debug("method flags %x\n", method_flags);
 			return 0;
 		}
 		log_debug("- no device in %s\n", media->name);
diff --git a/boot/bootflow.c b/boot/bootflow.c
index 7f5b0e942078..be543c8588cc 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -280,8 +280,26 @@ static int iter_incr(struct bootflow_iter *iter)
 		} else {
 			log_debug("labels %p\n", iter->labels);
 			if (iter->labels) {
-				ret = bootdev_next_label(iter, &dev,
-							 &method_flags);
+				/*
+				 * when the label is "mmc" we want to scan all
+				 * mmc bootdevs, not just the first. See
+				 * bootdev_find_by_label() where this flag is
+				 * set up
+				 */
+				if (iter->method_flags &
+				    BOOTFLOW_METHF_SINGLE_UCLASS) {
+					scan_next_in_uclass(&dev);
+					log_debug("looking for next device %s: %s\n",
+						  iter->dev->name,
+						  dev ? dev->name : "<none>");
+				} else {
+					dev = NULL;
+				}
+				if (!dev) {
+					log_debug("looking at next label\n");
+					ret = bootdev_next_label(iter, &dev,
+								 &method_flags);
+				}
 			} else {
 				ret = bootdev_next_prio(iter, &dev);
 				method_flags = 0;
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 637861748057..0702fccdae60 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -225,7 +225,7 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_assertok(env_set("boot_targets", "mmc1 mmc2 usb"));
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(3, iter.num_devs);
+	ut_asserteq(5, iter.num_devs);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[1]->name);
 	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
@@ -237,7 +237,20 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_assertok(bootflow_scan_first(NULL, "mmc", &iter, 0, &bflow));
 	ut_asserteq(2, iter.num_devs);
 
-	/* Now scan pass mmc1 and make sure that only mmc0 shows up */
+	/* Now scan past mmc1 and make sure that only mmc0 shows up */
+	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
+	ut_asserteq(3, iter.num_devs);
+	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
+	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
+	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
+	bootflow_iter_uninit(&iter);
+
+	/* Try a single uclass with boot_targets */
+	ut_assertok(env_set("boot_targets", "mmc"));
+	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
+	ut_asserteq(2, iter.num_devs);
+
+	/* Now scan past mmc1 and make sure that only mmc0 shows up */
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(3, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
@@ -245,6 +258,21 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
 	bootflow_iter_uninit(&iter);
 
+	/* Try a single uclass with boot_targets */
+	ut_assertok(env_set("boot_targets", "mmc usb"));
+	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
+	ut_asserteq(2, iter.num_devs);
+
+	/* Now scan past mmc1 and make sure that the 3 USB devices show up */
+	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
+	ut_asserteq(6, iter.num_devs);
+	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
+	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
+	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
+	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
+			iter.dev_used[3]->name);
+	bootflow_iter_uninit(&iter);
+
 	return 0;
 }
 BOOTSTD_TEST(bootdev_test_order, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
-- 
2.42.0.655.g421f12c284-goog

