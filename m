Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B59CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A114835FE;
	Wed, 15 Oct 2025 17:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iJJBIBUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71CC5800D7; Wed, 15 Oct 2025 17:44:57 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60C4083621
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5818de29d15so8389504e87.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760543093; x=1761147893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFZplRUKCi2n5MHD6osJAcFSAaoFX/hJwOwV15iwEAY=;
 b=iJJBIBUsawXDwOCgBjQ9dhLnq6zsoQ48DeZkJ+iaFsK/+a4WruABviQiQtMBcMg9PI
 wjH16/Ibxu7+9aw033nr/C+n+cGc5fDhKUzBG4YTSym68nNFEU04MHRnLn5T1aJD0l8T
 jLRgpD8sIQMzaBjr7BJhRwV1VMMZRkIVtZ9aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543093; x=1761147893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFZplRUKCi2n5MHD6osJAcFSAaoFX/hJwOwV15iwEAY=;
 b=oQYwGUXIYGLbWOV2vMp/ouF8uyAfGGSvQ2aVIrHbB5qObG3cKuZKoRsfTU3iJkSb92
 QaSKLAXi5oNSsIlp5InhEMgdgqvRS1ensRDcSyucCHxWlT/nmzsdwd/eyNbQB3B737Vs
 MWZh6tsJ4soM1xMDQtq+AOwUsqRR1qa9vnHUWW+T/WRkBNIq7QmUQ5VlpZtbRtKUG1Vx
 m2LaeiDEVsiqYIujeU2AR3zligHFyYIKRwYMEgvVw22BS13nCNhmN6NE0RTlLiVUxqR8
 urBvmUIv/r62yA4va5k8L4iuIP1w0THcoSR2DpXoADcLOq+Pj/fIQ2RBuCLNvxKjai3q
 /Khg==
X-Gm-Message-State: AOJu0YwJVv5xZ87t4jgo2GD5iesV/3yCGScrFSWV0W+ItVIFaVH0O0u+
 JkAnoCo+R0QgUexvbkFXpAhgsGgL/ggDyJYwEx1GioTCt+iT6luncq3nz6Jw4bLWSlE6OB5wXrP
 EK/GkVSpcf7w=
X-Gm-Gg: ASbGnctGqOLV6mdvl4WCuKyP6fdA59aZTKeC2YTN0xBo3XcFEqhUZgf6z7n6UrUWGUd
 qvKH8shnGJxz3LcMeYzs8wlpr6f3S3Lw+AeehDTQyYJvXAzGNOUjheLKRqdOQ+1xwRX5n76bmRf
 d1A1ZDy5LkN00cBpo1MX7f04R/oqE6WKctaIvgR7sM9KwLLb3a5O9DgoE8UZqIxWnv6q+ziw9oz
 YxICNEfVt3k+acKt7unpLaL2QuZ6P01HJTsUGsuU8eAqRPbWLWM2HlqJwHK4XJuTqu30U153/DA
 Wg/MRI5TzgZjE9O3D9fAxZzzDd1hTW+CddCZ8/OZZlydA/wGFnUl7zQnUx/4nKIL+lAyoo3faDj
 9jcQ3WaQgLfWgNjVa4EonE+sYxbWm/micg8PxdA==
X-Google-Smtp-Source: AGHT+IG4Wge2oY2+Le43ZNBppU5J5hFh1eaH/uH7L3He02hbkX5zhfpppCEeliyMXRQJsaCll+003A==
X-Received: by 2002:a05:6512:3d92:b0:55f:71d2:e5be with SMTP id
 2adb3069b0e04-5906de92758mr8323854e87.52.1760543093487; 
 Wed, 15 Oct 2025 08:44:53 -0700 (PDT)
Received: from chromium.org ([91.209.212.108])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59088563cbesm6363777e87.64.2025.10.15.08.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:44:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 04/11] boot: Add a flag for whether there are global
 bootmeths
Date: Wed, 15 Oct 2025 16:44:07 +0100
Message-ID: <20251015154423.908468-5-sjg@chromium.org>
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

The current 'doing_global' refers to being in the state of processing
global bootmeths. Since global bootmeths are currently used once at the
start, it becomes false once the last global bootmeth has been used.

In preparation for allowing bootmeths to run at other points in the
bootstd interation, add a new 'have_global' flag which tracks whether
there are any global bootmeths in the method_order[] list. It is set up
when iteration starts. Unlike doing_global which resets back to false
after the global bootmeths have been handled, once have_global is set to
true, it remains true for the entire iteration process. This provides a
quick check as to whether global-bootmeth processing is needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth-uclass.c | 1 +
 include/bootflow.h     | 2 ++
 test/boot/bootflow.c   | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index bb2dd8447cf..a0aa6336c9b 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -209,6 +209,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 	    iter->first_glob_method != -1 && iter->first_glob_method != count) {
 		iter->cur_method = iter->first_glob_method;
 		iter->doing_global = true;
+		iter->have_global = true;
 	}
 	iter->method_order = order;
 	iter->num_methods = count;
diff --git a/include/bootflow.h b/include/bootflow.h
index 2ef6eb25cf5..b18baebb4ba 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -255,6 +255,7 @@ enum bootflow_meth_flags_t {
  * @cur_prio: Current priority being scanned
  * @method_order: List of bootmeth devices to use, in order. The normal methods
  *	appear first, then the global ones, if any
+ * @have_global: true if we have global bootmeths in @method_order[]
  * @doing_global: true if we are iterating through the global bootmeths (which
  *	happens before the normal ones)
  * @method_flags: flags controlling which methods should be used for this @dev
@@ -278,6 +279,7 @@ struct bootflow_iter {
 	int first_glob_method;
 	enum bootdev_prio_t cur_prio;
 	struct udevice **method_order;
+	bool have_global;
 	bool doing_global;
 	int method_flags;
 };
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 07bf239485c..83fb646babf 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -308,6 +308,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 	ut_asserteq_str("extlinux", iter.method->name);
 	ut_asserteq(0, bflow.err);
 	ut_assert(!iter.doing_global);
+	ut_assert(!iter.have_global);
 	ut_asserteq(-1, iter.first_glob_method);
 
 	/*
@@ -405,6 +406,7 @@ static int bootflow_iter_glob(struct unit_test_state *uts)
 					BOOTFLOWIF_SHOW, &bflow));
 	ut_asserteq(3, iter.num_methods);
 	ut_assert(iter.doing_global);
+	ut_assert(iter.have_global);
 	ut_asserteq(2, iter.first_glob_method);
 
 	ut_asserteq(2, iter.cur_method);
@@ -421,6 +423,7 @@ static int bootflow_iter_glob(struct unit_test_state *uts)
 	ut_asserteq(2, iter.num_methods);
 	ut_asserteq(2, iter.first_glob_method);
 	ut_assert(!iter.doing_global);
+	ut_assert(iter.have_global);
 
 	ut_asserteq(0, iter.cur_method);
 	ut_asserteq(0, iter.part);
@@ -486,6 +489,7 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 	/* at this point the global bootmeths are stranded above num_methods */
 	ut_asserteq(3, iter.num_methods);
 	ut_assert(!iter.doing_global);
+	ut_assert(iter.have_global);
 	ut_asserteq(3, iter.first_glob_method);
 	ut_asserteq_str("sandbox", iter.method->name);
 	ut_assertok(inject_response(uts));
-- 
2.43.0

