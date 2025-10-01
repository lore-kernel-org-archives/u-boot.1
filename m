Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F5ECCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E8683692;
	Wed,  1 Oct 2025 23:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TgqGUQyr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A7BA836B4; Wed,  1 Oct 2025 23:29:52 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2312180107
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-42d888f6b3bso3279855ab.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354188; x=1759958988; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mk38M5oiz2y5YkOtiWPWPDcRMHY6LMiR2w+5FeUfelM=;
 b=TgqGUQyrgYtHIn4eOD9CdCfhMd4EmeYfXFT5tLN/S2sh9nracC//CeDM/qZzhlvZo7
 i4vnhmSksOByUVc7I6SAiwawpfFWu4PsuoBcP/QzhtFJa2exEY9TgsPogOoeHHpS5kec
 xtmOQNcqjXxRoF+ZyWLzwHmOEweuB/7GajlZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354188; x=1759958988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mk38M5oiz2y5YkOtiWPWPDcRMHY6LMiR2w+5FeUfelM=;
 b=YaUgIhHkhBmCkmXvrusBfAWUUu5Wv/PokSKXJjDPo0X57xTnNDtIazaIEJe0MR/JuX
 NOhtG4N0UoNh0Y+JPN9Cf9+IVMFV0V+65k912smttttzl95ZVfKBpK5c0aCbE88zhDFx
 gM9ovcVj4OCm1aoKhAxPaRnATHJp2HmYSge1yah7Xrv5dhbQG4CeHZXm3LwZ3WWfzPI2
 g4ffZ2qdQK01J/tPwb1/DHyW2s9vR0RHtoVfCp12eXys0Fk2JZST832g4DNiAZPcDtjz
 lIsO+OR6z4gKf86Ho77oQxiPfpGXg89od7+BKnzdmm7+GqMo7UnXbDd0qqLPlAevvu0f
 gU8w==
X-Gm-Message-State: AOJu0Yxu0o2w0fpO1XtEdB9SawnnRLUJvOR9UbNqWMLYn1b4MPRt6qUf
 OJaLZfw0EXZcmsIhrSmsI0RPcbh7y0mrJYFZlDGQBO3UmXTrNkn8W1SA/H3gC9EfDi03xyEzyRK
 qXcoX0oiY
X-Gm-Gg: ASbGnctI7NXu2fu4KXz0iXVMhNuoYMHbaM8Ci4jYe8vT4E1L/exG2NvyRZAk/wjV4Gy
 Mk28bxSOUAuan/if2KUa6hMmjH/yWKD3M1oz836hmlaFIg3WM1MUqM3Tzl6gtekQt6/pGFGqljH
 c/m1Sx5n/QVmUC4oEFkh7VLpvK5ySO9JwKkIpqKE03UCyVZAfQ2sWWeCPfdbUDho3DgtSBEBz8b
 wSy4wENavT+jZQoXBVD2d4wObDnBVciEvgyjBtZTpkYn08AyhfunsQYszlH93b2nYj2gmW9S4JR
 yqsFjMuw/wOaYEsI31nvEs5w0hRGZFoy+bbi+4zFxcq78iIUGZcnn5CzGMNi/pKnC6OQiZ0IaeZ
 GKwO3XfB5aoHqrb7jEPb1TtMXYKJ5+JtAjKcBVZpN
X-Google-Smtp-Source: AGHT+IG7a74CcpSkvuPDfhhtQV4c92ESaRy4TT6aV+V60/7eQcrOKyVGf6nKcMg97lg7riXgycLNpQ==
X-Received: by 2002:a05:6e02:2147:b0:42d:8b1c:570c with SMTP id
 e9e14a558f8ab-42d8b1c5d42mr12582665ab.5.1759354187788; 
 Wed, 01 Oct 2025 14:29:47 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/17] boot: Keep track of which bootmeths have been used
Date: Wed,  1 Oct 2025 15:26:34 -0600
Message-ID: <20251001212649.3263574-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
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

Add a bitfield which tracks when bootmeths have been used. This will be
needed when global bootmeths can be used later in the iteration.

Fix a missing bootflow_free() while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c        | 13 +++++++++++++
 boot/bootmeth-uclass.c | 10 ++++++++++
 include/bootflow.h     | 10 +++++++++-
 test/boot/bootflow.c   |  8 +++++++-
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index cf7a3befe8d..60f3498e2b9 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -18,6 +18,10 @@
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 
+/* ensure BOOTMETH_MAX_COUNT fits in method_flags field */
+static_assert(BOOTMETH_MAX_COUNT <=
+	      (sizeof(((struct bootflow_iter *)NULL)->method_flags) * 8));
+
 /* error codes used to signal running out of things */
 enum {
 	BF_NO_MORE_PARTS	= -ESHUTDOWN,
@@ -489,6 +493,10 @@ int bootflow_scan_first(struct udevice *dev, const char *label,
 		bootflow_iter_set_dev(iter, dev, method_flags);
 	}
 
+	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)) {
+		iter->methods_done |= BIT(iter->cur_method);
+		log_debug("methods_done now %x\n", iter->cur_method);
+	}
 	ret = bootflow_check(iter, bflow);
 	if (ret) {
 		log_debug("check - ret=%d\n", ret);
@@ -516,6 +524,11 @@ int bootflow_scan_next(struct bootflow_iter *iter, struct bootflow *bflow)
 			return log_msg_ret("done", ret);
 
 		if (!ret) {
+			if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)) {
+				iter->methods_done |= BIT(iter->cur_method);
+				log_debug("methods_done now %x\n",
+					  iter->cur_method);
+			}
 			ret = bootflow_check(iter, bflow);
 			log_debug("check - ret=%d\n", ret);
 			if (!ret)
diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index e95a8a801c4..115570178ed 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -210,6 +210,16 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 		iter->doing_global = true;
 		iter->have_global = true;
 	}
+
+	/*
+	 * check we don't exceed the maximum bits in methods_done when tracking
+	 * which global bootmeths have run
+	 */
+	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && count > BOOTMETH_MAX_COUNT) {
+		free(order);
+		return log_msg_ret("tmb", -ENOSPC);
+	}
+
 	iter->method_order = order;
 	iter->num_methods = count;
 
diff --git a/include/bootflow.h b/include/bootflow.h
index 157a16d44b9..6437a6ef5e4 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -11,7 +11,8 @@
 #include <bootdev.h>
 #include <image.h>
 #include <dm/ofnode_decl.h>
-#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/build_bug.h>
 
 struct bootstd_priv;
 struct expo;
@@ -213,6 +214,10 @@ enum bootflow_meth_flags_t {
 	BOOTFLOW_METHF_SINGLE_UCLASS	= 1 << 3,
 };
 
+enum {
+	BOOTMETH_MAX_COUNT	= 32,
+};
+
 /**
  * struct bootflow_iter - state for iterating through bootflows
  *
@@ -260,6 +265,8 @@ enum bootflow_meth_flags_t {
  *	happens before the normal ones)
  * @method_flags: flags controlling which methods should be used for this @dev
  * (enum bootflow_meth_flags_t)
+ * @methods_done: indicates which methods have been processed, one bit for
+ * each method in @method_order[]
  */
 struct bootflow_iter {
 	int flags;
@@ -282,6 +289,7 @@ struct bootflow_iter {
 	bool have_global;
 	bool doing_global;
 	int method_flags;
+	uint methods_done;
 };
 
 /**
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index c766bfcf683..505aa095b56 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -310,6 +310,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 	ut_assert(!iter.doing_global);
 	ut_assert(!iter.have_global);
 	ut_asserteq(-1, iter.first_glob_method);
+	ut_asserteq(BIT(0), iter.methods_done);
 
 	/*
 	 * This shows MEDIA even though there is none, since in
@@ -318,6 +319,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 	 * know.
 	 */
 	ut_asserteq(BOOTFLOWST_MEDIA, bflow.state);
+	bootflow_free(&bflow);
 
 	ut_asserteq(-EPROTONOSUPPORT, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(2, iter.num_methods);
@@ -327,6 +329,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 	ut_asserteq_str("efi", iter.method->name);
 	ut_asserteq(0, bflow.err);
 	ut_asserteq(BOOTFLOWST_MEDIA, bflow.state);
+	ut_asserteq(BIT(0) | BIT(1), iter.methods_done);
 	bootflow_free(&bflow);
 
 	/* The next device is mmc1.bootdev - at first we use the whole device */
@@ -338,6 +341,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 	ut_asserteq_str("extlinux", iter.method->name);
 	ut_asserteq(0, bflow.err);
 	ut_asserteq(BOOTFLOWST_MEDIA, bflow.state);
+	ut_asserteq(BIT(0) | BIT(1), iter.methods_done);
 	bootflow_free(&bflow);
 
 	ut_asserteq(-ENOENT, bootflow_scan_next(&iter, &bflow));
@@ -348,9 +352,10 @@ static int bootflow_iter(struct unit_test_state *uts)
 	ut_asserteq_str("efi", iter.method->name);
 	ut_asserteq(0, bflow.err);
 	ut_asserteq(BOOTFLOWST_MEDIA, bflow.state);
+	ut_asserteq(BIT(0) | BIT(1), iter.methods_done);
 	bootflow_free(&bflow);
 
-	/* Then more to partition 1 where we find something */
+	/* Then move to partition 1 where we find something */
 	ut_assertok(bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(2, iter.num_methods);
 	ut_asserteq(0, iter.cur_method);
@@ -380,6 +385,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 	ut_asserteq_str("extlinux", iter.method->name);
 	ut_asserteq(0, bflow.err);
 	ut_asserteq(BOOTFLOWST_MEDIA, bflow.state);
+	ut_asserteq(BIT(0) | BIT(1), iter.methods_done);
 	bootflow_free(&bflow);
 
 	bootflow_iter_uninit(&iter);
-- 
2.43.0

