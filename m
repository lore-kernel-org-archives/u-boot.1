Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EECBCE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 20:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5750868D8;
	Sat, 23 Sep 2023 22:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KG3aXwv5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E66458698D; Sat, 23 Sep 2023 22:50:23 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 739828684C
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 22:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79fa4ff8220so82788439f.3
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 13:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695502220; x=1696107020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fcy5WkVBoc7uoRrzJTdjAvllGuUSUwfIiQ5P7MPqanU=;
 b=KG3aXwv5HvtWYkt2G7n3DcwAsa2xdEa6uyrBRWhucS+3OUN5eZ79edhY+dVDuwuEAL
 I/Ci/8cflRdX1s9cv7mPYw2tXHkWnudM3Jwyw+72113wGGZG+e1q9i0wvb+MmxxK4lDM
 ApdxnzfJunDfWMC4zu0PhcdG39ZcuC82Ezgcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695502220; x=1696107020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fcy5WkVBoc7uoRrzJTdjAvllGuUSUwfIiQ5P7MPqanU=;
 b=UNAm2llXUYdkTNewaIJpX2/kKkDsigJYBX1Ch147g7NChNygnu0Glr6Ya3Cw6WpHIG
 OzXCeyakwC/pjiea0NTxHVU01HvJOlAiZwBZoQMMnavjUuSAdMqDCSLIndWzRhOARHfS
 ksVozUDoXyyT/gV0XsaczFQgdgBImzMU7OR4NRnNalhSl2iZqYqt/TJ3Ftciv0KfxrcB
 CrNKVLlJySDCY+svy4oHY0uID6SHsIAGjKBEAE1x9VhZ1jtpTJE4Zzrqa4nrrt+oEgus
 A44BAwUrpks5SSMYfllyvb2A/OavxCiknMLIS7ENPr4izxS2EvAZcqH0KhFUUzD5aDXf
 XmKg==
X-Gm-Message-State: AOJu0YwjY6Rk6HbA8DutFJQwzzA4q1TI/KwnuD1ZteWezSPjeMGyx26P
 qvXFutS0QtYRlcVbGETlNS4BhMXg2YyAsItRSoI=
X-Google-Smtp-Source: AGHT+IE/HwkByEI0cMcKWYghOMoUVXCzjV4a68DB17kNo1TCDUCCFa07idjIRi4hzVA51WQbE/JX/w==
X-Received: by 2002:a05:6e02:19cd:b0:34f:f5a4:3e68 with SMTP id
 r13-20020a056e0219cd00b0034ff5a43e68mr4812478ill.30.1695502219881; 
 Sat, 23 Sep 2023 13:50:19 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i8-20020a056e020ec800b0034fda29890asm691408ilk.10.2023.09.23.13.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 13:50:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Date Huang <tjjh89017@hotmail.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] bootstd: Scan all bootdevs in a boot_targets entry
Date: Sat, 23 Sep 2023 14:50:15 -0600
Message-ID: <20230923205017.1754340-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
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

I believe at least three people reported this, but I found two.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Date Huang <tjjh89017@hotmail.com>
Reported-by: Vincent Stehlé <vincent.stehle@arm.com>
---

 boot/bootdev-uclass.c |  3 ++-
 boot/bootflow.c       | 21 +++++++++++++++++++--
 test/boot/bootdev.c   | 10 ++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index fa52bc3a9c4e..5a60cf223c79 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -460,10 +460,11 @@ int bootdev_find_by_label(const char *label, struct udevice **devp,
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
index 81b5829d5b37..74abf3e17d7e 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -260,8 +260,25 @@ static int iter_incr(struct bootflow_iter *iter)
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
+				if (iter->method_flags & BOOTFLOW_METHF_SINGLE_UCLASS) {
+					uclass_next_device(&dev);
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
index 6b29213416db..c5f14a7a1323 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -221,6 +221,16 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[1]->name);
 	bootflow_iter_uninit(&iter);
 
+	/* Make sure it scans a bootdevs in each target */
+	ut_assertok(env_set("boot_targets", "mmc spi"));
+	ut_asserteq(0, bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
+	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
+	ut_asserteq(3, iter.num_devs);
+	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
+	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
+	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
+	bootflow_iter_uninit(&iter);
+
 	return 0;
 }
 BOOTSTD_TEST(bootdev_test_order, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
-- 
2.42.0.515.g380fc7ccd1-goog

