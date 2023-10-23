Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549C1C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6883878A5;
	Mon, 23 Oct 2023 09:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dFS2QcgW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B745878AB; Mon, 23 Oct 2023 09:03:54 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C9F18789B
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso2113653b3a.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698044628; x=1698649428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ew8iyvONTBHFSzqJUE4yKUd2xpp+xzmJ00KQ5dr6eF0=;
 b=dFS2QcgWhJaU/44Y0L84QCEUZsSfQm+THPvJaGxBVMrDZPrT7hhBvjMizxlJGI1aN+
 VIZE2fjQwpneYaIfXqCx7tsatcwBdk1Eae2U2goVPsTmV+sIS7od1A4l4p87s5yqelfp
 dydsJU1TAGhKyYg4SR3SVL0bufi9GDaltshdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044628; x=1698649428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ew8iyvONTBHFSzqJUE4yKUd2xpp+xzmJ00KQ5dr6eF0=;
 b=XSsodXgq9oYJHLlh9Bj0f3ECa+HlX3Sv1YVfvz6bRwxlkwBdRv3a0Hk6Q50oVnGlmr
 EogrCQLi/RHVt+gd0kqzgVCwC1CXq8kIvlV29CNwiVntTgicTce8IDpb2aFDOFwE7btt
 DSJWpCOQukBbK5mUMR8spnflJoYw88mlabP6bVqDnzBx0t1dx1IIlXCULX7bUAMMvjys
 eG7xlu6eaXdsr0lHuC4Jhrrbg5kO+FtYU2PXtLxWsgkvL29cDdkv80SwOH+Bl77AlCin
 nKZpPUTCfohZ4frbdpiXONQAd6BPqhyAKAkv7oYtEeMA7B1d1jLjdgJxT98x5UZUjv+j
 qb4Q==
X-Gm-Message-State: AOJu0YwDHvpPduZaqqXn3Mo4FeFqQWaD8ZIsIhNOtR3/EvGt1965BItK
 NB6H+sGoMEbOk0AeJsjMcjece7rs5NX+eAqHUpZncw==
X-Google-Smtp-Source: AGHT+IFQ4m2/05nGDwTdrQEhD5vTCy18EhQK42X//d8JWEYrNIxgMIK3seaMQ6RrpCQvJqSgsMhNKw==
X-Received: by 2002:a05:6a00:1c8c:b0:68f:cdb8:ae33 with SMTP id
 y12-20020a056a001c8c00b0068fcdb8ae33mr16183446pfw.10.1698044628418; 
 Mon, 23 Oct 2023 00:03:48 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 u187-20020a6279c4000000b006bde8e1f0adsm5910841pfc.98.2023.10.23.00.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 00:03:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume Gardet <Guillaume.Gardet@arm.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/4] Revert "bootstd: Scan all bootdevs in a boot_targets
 entry"
Date: Mon, 23 Oct 2023 00:02:10 -0700
Message-ID: <20231023070216.394709-2-sjg@chromium.org>
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

This commit was intended to allow all bootdevs in each boot_targets
entry to be scanned. However it causes bad ordering with bootdevs, e.g.
scanning Ethernet bootdevs when it should be keeping to mmc.

Revert it so we can try another approach.

This reverts commit e824d0d0c219bc6da767f13f90c5b00eefe929f0.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootdev-uclass.c |  3 +--
 boot/bootflow.c       | 21 ++-------------------
 test/boot/bootdev.c   | 10 ----------
 3 files changed, 3 insertions(+), 31 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 44ae98a9269c..974ddee5d2fa 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -469,11 +469,10 @@ int bootdev_find_by_label(const char *label, struct udevice **devp,
 			 * if no sequence number was provided, we must scan all
 			 * bootdevs for this media uclass
 			 */
-			if (seq == -1)
+			if (IS_ENABLED(CONFIG_BOOTSTD_FULL) && seq == -1)
 				method_flags |= BOOTFLOW_METHF_SINGLE_UCLASS;
 			if (method_flagsp)
 				*method_flagsp = method_flags;
-			log_debug("method flags %x\n", method_flags);
 			return 0;
 		}
 		log_debug("- no device in %s\n", media->name);
diff --git a/boot/bootflow.c b/boot/bootflow.c
index e03932e65a74..6ef62e1d1896 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -260,25 +260,8 @@ static int iter_incr(struct bootflow_iter *iter)
 		} else {
 			log_debug("labels %p\n", iter->labels);
 			if (iter->labels) {
-				/*
-				 * when the label is "mmc" we want to scan all
-				 * mmc bootdevs, not just the first. See
-				 * bootdev_find_by_label() where this flag is
-				 * set up
-				 */
-				if (iter->method_flags & BOOTFLOW_METHF_SINGLE_UCLASS) {
-					uclass_next_device(&dev);
-					log_debug("looking for next device %s: %s\n",
-						  iter->dev->name,
-						  dev ? dev->name : "<none>");
-				} else {
-					dev = NULL;
-				}
-				if (!dev) {
-					log_debug("looking at next label\n");
-					ret = bootdev_next_label(iter, &dev,
-								 &method_flags);
-				}
+				ret = bootdev_next_label(iter, &dev,
+							 &method_flags);
 			} else {
 				ret = bootdev_next_prio(iter, &dev);
 				method_flags = 0;
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index c5f14a7a1323..6b29213416db 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -221,16 +221,6 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[1]->name);
 	bootflow_iter_uninit(&iter);
 
-	/* Make sure it scans a bootdevs in each target */
-	ut_assertok(env_set("boot_targets", "mmc spi"));
-	ut_asserteq(0, bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
-	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(3, iter.num_devs);
-	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
-	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
-	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
-	bootflow_iter_uninit(&iter);
-
 	return 0;
 }
 BOOTSTD_TEST(bootdev_test_order, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
-- 
2.42.0.655.g421f12c284-goog

