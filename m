Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2303CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A6728363D;
	Wed, 15 Oct 2025 17:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sv2NC/Ak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B43308362A; Wed, 15 Oct 2025 17:45:03 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 346878363D
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-586883eb9fbso8690911e87.1
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760543099; x=1761147899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKeuTmF656GPVXQk+taEJNkUuZImnD+EfiZIb7XmEVA=;
 b=Sv2NC/AkDa9JMhUQeTM0KHE8O00bL65pI176tETUjlIitMCVt4kwWBxzTDPPYmQqZK
 dewTOy3RMAQQKgE0XluX/uZnXRbhDX588MQVkctEdeocBmMuNsP4FNEkOPTztJCZDZjk
 +oetRgxGLvW86Vvpv59IPWyBWji/PQw5Ed31g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543099; x=1761147899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKeuTmF656GPVXQk+taEJNkUuZImnD+EfiZIb7XmEVA=;
 b=TJRKfY2d2baxxEKODL70rCrCpomfY3fEMYYBq0Z3Ud1vPHICpcr4QfvOR85SyUEWHB
 2LCj/eCLBDRln28IyyOcO6freouzjSxzGd3eJVhEJA4G5oOLXNwzqfM0R/TvY8CZEXtB
 mjqq5BMnzRlsZrruW4ZowIVaDjER9SLqoVZTbmHKhIGaKuGfnvuDrHYp8N7+R1L5YvJt
 1O1a5rRZ92Xe9t+yyMnPbodjtJsXf+46L/SPKeSUTStpicH8l3X6qn41uddnjSDIY2h7
 r5FVlrX/4tdMabsQ7RQekSL7Yjlle8U+WR0teYCoMJsmKDrEGm+0NpsLbHNj+R5tZvlZ
 Iwew==
X-Gm-Message-State: AOJu0YyetQgeQZ0K8O+7K6onqU1s7LcuW3wsstQlH48gFPPdSayZGTw5
 SVEMXt04KWucCKJe4P6GsJooj0/3WRQmO9PvIspiPdgvMgKsxwF/VBYtGkWRnSdTlASFvtkah8g
 u4gA4xbAcC28=
X-Gm-Gg: ASbGncuQw8VOy62KTvEG4TaSuYYKUg0tbvnleXMh9pkiDCkRDIMZKu/Pr+PDColDJDO
 Lz7kl3RDtZ2zoHREIdW05Y1FtgWSzGBQdRWdfIY74clwY8pIB1Sj0/QHGYTXIv/JcuzNrjRj+t/
 FKI884tS11bWvPjWea0NSlVeoCR3IEz066+jWFGFXJTDXQcfDeNHAaQ9+hv8ECFc1NywC4crLqR
 Banzspuyc0Lr4FNA9/GFnun4V0l9bQyxNYyhVSw4/MZkgyqksl/egDGAgDLH2GHQ5bqJRQ2M3hD
 NGQP0U4M8+w3B//8AE0sbSID6uUorcSpBsTGzug3cBCZ/ZEt8sJpoIWviSLH/elv0ox6h3DZWfX
 ENcmHv1l3q9xeYfxUH8pThQg0+qH9WCTv8nLq/g==
X-Google-Smtp-Source: AGHT+IH2XuB/VHIxCQgaaw1WfOo7avwyaYrQgTUicDfCABjMOZf+4r9RU8D+6pcaTTMEv6Hj1AaF0g==
X-Received: by 2002:a05:6512:2c04:b0:562:c06c:8c03 with SMTP id
 2adb3069b0e04-5906d896d2dmr8212061e87.21.1760543099084; 
 Wed, 15 Oct 2025 08:44:59 -0700 (PDT)
Received: from chromium.org ([91.209.212.108])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59088563cbesm6363777e87.64.2025.10.15.08.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:44:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 05/11] boot: Keep track of which bootmeths have been used
Date: Wed, 15 Oct 2025 16:44:08 +0100
Message-ID: <20251015154423.908468-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015154423.908468-1-sjg@chromium.org>
References: <20251015154423.908468-1-sjg@chromium.org>
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
index 62634a59a94..2e4d1a345cd 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -17,6 +17,10 @@
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 
+/* ensure BOOTMETH_MAX_COUNT fits in method_flags field */
+static_assert(BOOTMETH_MAX_COUNT <=
+	      (sizeof(((struct bootflow_iter *)NULL)->method_flags) * 8));
+
 /* error codes used to signal running out of things */
 enum {
 	BF_NO_MORE_PARTS	= -ESHUTDOWN,
@@ -433,6 +437,10 @@ int bootflow_scan_first(struct udevice *dev, const char *label,
 		bootflow_iter_set_dev(iter, dev, method_flags);
 	}
 
+	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL)) {
+		iter->methods_done |= BIT(iter->cur_method);
+		log_debug("methods_done now %x\n", iter->cur_method);
+	}
 	ret = bootflow_check(iter, bflow);
 	if (ret) {
 		log_debug("check - ret=%d\n", ret);
@@ -460,6 +468,11 @@ int bootflow_scan_next(struct bootflow_iter *iter, struct bootflow *bflow)
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
index a0aa6336c9b..a9709465f6e 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -211,6 +211,16 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
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
index b18baebb4ba..58a4ab9f811 100644
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
index 83fb646babf..8317dee1e20 100644
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

