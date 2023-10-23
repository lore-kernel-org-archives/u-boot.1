Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FF1C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A279B878A9;
	Mon, 23 Oct 2023 09:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aYxxWBdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231CE878B2; Mon, 23 Oct 2023 09:03:59 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9DE187874
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso2113746b3a.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698044635; x=1698649435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8b4yhHi8HkVDVyxmZZ8a/B9oJfD95880A8O7ScnCUlA=;
 b=aYxxWBdy/wJMQ/tjjK8Fxa3hq2jB+RQ/GZvaC5Z3WX/PHTfrcBBEncxnUjhKGVpRDX
 W+KcG58tqawI84z5bFLFL0b9sW2fogOlQatvQajdAUe47BPNqB6QAhnJi9Kz7r/r9Gs6
 NNgvS1a0l6YIH9C//eL4UL+4CZAI3w/xuJglw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044635; x=1698649435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8b4yhHi8HkVDVyxmZZ8a/B9oJfD95880A8O7ScnCUlA=;
 b=I5RQ7op3C0RGr709+nlAxagLQLSvqp2mbM2boS7Q037eSoibAVpk4mZ4eybB3mgH7s
 CU7QPLmTk89Z+nypz02nbdWiiDUxCGGmjyWllc8F1lpiyjdILqp5njd+8mukVbhujjua
 wbRX/7IaEywz0hp5/4jlTO+cz+b6t8VrLGXFFR8MJNzfchp2hHCRDypg8K/GlpfN9Vrh
 SeZuMbw7X3R9vJf+qkLzCYC4bKuMUFgXrXnL/ZNgq+cmMfXFwT5f92+aIq8MvTuIIJMI
 krBCjES1iIXXHLKw7aF3b1EC0+alfvtIAfIjK8UhAiTW019VbZ/uyxJbG+XG2ZLxkJPB
 QhTQ==
X-Gm-Message-State: AOJu0YxXE6hDpzTCrR02q/+ia8kFUD/3VJLYeldwCaUAM/ZjNFiglRSk
 N+4b2ozl4hRwo7qO57OeOxowm5MFBDGdy9h+8WGPjQ==
X-Google-Smtp-Source: AGHT+IEjnpgei2u9GBHpMxAqISqdKlCrvD572cRfntnploYm1RPfc2ermsDOfWBp72z4zSgZo07dRw==
X-Received: by 2002:a05:6a00:1817:b0:68e:3616:604a with SMTP id
 y23-20020a056a00181700b0068e3616604amr11976822pfa.8.1698044635168; 
 Mon, 23 Oct 2023 00:03:55 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 u187-20020a6279c4000000b006bde8e1f0adsm5910841pfc.98.2023.10.23.00.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 00:03:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume Gardet <Guillaume.Gardet@arm.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/4] bootstd: Correct logic for single uclass
Date: Mon, 23 Oct 2023 00:02:12 -0700
Message-ID: <20231023000211.3.Icefe7db8f3c1ddc3624f95ca5dc89b81ef97eab4@changeid>
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

The current logic for "bootflow mmc" is flawed since it checks the
uclass of the bootdev instead of its parent, the media device. Correct
this and add a test that covers this scenario.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow.c     | 24 ++++++++++++++++++++++--
 test/boot/bootdev.c | 13 +++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 6ef62e1d1896..7f5b0e942078 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -155,6 +155,27 @@ static void bootflow_iter_set_dev(struct bootflow_iter *iter,
 	}
 }
 
+/**
+ * scan_next_in_uclass() - Scan for the next bootdev in the same media uclass
+ *
+ * Move through the following bootdevs until we find another in this media
+ * uclass, or run out
+ *
+ * @devp: On entry, the device to check, on exit the new device, or NULL if
+ * there is none
+ */
+static void scan_next_in_uclass(struct udevice **devp)
+{
+	struct udevice *dev = *devp;
+	enum uclass_id cur_id = device_get_uclass_id(dev->parent);
+
+	do {
+		uclass_find_next_device(&dev);
+	} while (dev && cur_id != device_get_uclass_id(dev->parent));
+
+	*devp = dev;
+}
+
 /**
  * iter_incr() - Move to the next item (method, part, bootdev)
  *
@@ -230,8 +251,7 @@ static int iter_incr(struct bootflow_iter *iter)
 						 &method_flags);
 		} else if (IS_ENABLED(CONFIG_BOOTSTD_FULL) &&
 			   (iter->flags & BOOTFLOWIF_SINGLE_UCLASS)) {
-			/* Move to the next bootdev in this uclass */
-			uclass_find_next_device(&dev);
+			scan_next_in_uclass(&dev);
 			if (!dev) {
 				log_debug("finished uclass %s\n",
 					  dev_get_uclass_name(dev));
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 7228f545e9e6..637861748057 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -232,6 +232,19 @@ static int bootdev_test_order(struct unit_test_state *uts)
 			iter.dev_used[2]->name);
 	bootflow_iter_uninit(&iter);
 
+	/* Try a single uclass */
+	ut_assertok(env_set("boot_targets", NULL));
+	ut_assertok(bootflow_scan_first(NULL, "mmc", &iter, 0, &bflow));
+	ut_asserteq(2, iter.num_devs);
+
+	/* Now scan pass mmc1 and make sure that only mmc0 shows up */
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
2.42.0.655.g421f12c284-goog

