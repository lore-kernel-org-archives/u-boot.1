Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E953ECCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2FFB8323A;
	Wed, 15 Oct 2025 17:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gsyeNTY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B5D800D7; Wed, 15 Oct 2025 17:44:49 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B104835B0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-57d8ff3944dso7241322e87.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760543085; x=1761147885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+HJIZeu0+7laSLSvMjtjlt9YmM9BBOCW+FfJw6egmo=;
 b=gsyeNTY8Z3zl6la0gUu1muTXJQQnJ+DhiO0C0P2+WN1Hs0Rzeh85rfBM4UoRBoXoXs
 ReOH/aQJVgNaklBQ5KsxyqIAu6JSuUtbwBy78nECqM3cmkbESKzIkOXwiQO5rqaV/Y2g
 00NkRYpoXEiFS8R4OcS68Xzjj0gEm9bxLefT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543085; x=1761147885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+HJIZeu0+7laSLSvMjtjlt9YmM9BBOCW+FfJw6egmo=;
 b=iT9TQgDBxJxjjZP/CSh7abBWys15p+Anf7rn20zhmjUokMOcdaPj8M3u6mOQNTIAB4
 QcWsfiXKiSOE9T4QYSUPfWbrQ6R7wUpJ2laY8GyiwwX280ruuS/d2Mrd7lgL8deT6uMv
 xuuKnslXl5k0C3K06TVHCuYugVGW8c1Zg8PtxqjUpI55BJCoTd0qTHboe7czlmUh1Ja7
 usvGHPd/0mMzbdNZpm9zbMVm5kUp7Sr1gkLetyk0HtYg9Hr84OMAuiFzbu8jVjpRZXEO
 fVa7J2L0pwA9FyXfEBcA4QMwZM/3BWhdvbGQUStMe4yv7ME0LGe9TOCfD1a/MPETrx2V
 a10w==
X-Gm-Message-State: AOJu0Ywlf2hd44i+z04EDuKnxppqONHJ+/3FN+a154lcKFO5EFg9jCks
 UVuMSAQ/w8MI8jjVrB0EQIdpifj6FWbMMkW3sCD5z5epZdNDkaZoUic9cXV3bZ/FMxu+/AexHlq
 3I9zy+nWCKUw=
X-Gm-Gg: ASbGncu+coFxSnYUQ+Yy5jyhJxatTxqMvTVoihmi9fwkZX5TfABkbKpUasePOkzAMl4
 QhNQq1Uaqo6/XCaDxFo/6Od6lN2/xSYjrkzw7xz4sUtA32K5BWidjbiEMzpyRXaQMfnTUPMxMiI
 qopbPs9JsEuKgFmvuaJGRl0SJptoE9H8LHU6A0h4FNWqn7okSH5TxqVQt6NUf3RPQP+3hhmTihS
 lAmNScyqXJfToLIyAKFl0mPoyj/1GE9x5+T4EWmijZyyrY37gw5EnMkfK2QwzFkbDYwUWEY5LUe
 2WUf0dIMgd1M9g3wRGwscehNvHDs0yGm61AX6jL77YLj774+VC4g2C/7QU0Xb23mN5YVvo7w9j9
 q8ciDEYQG64qe6oM9vAk0BKb+3JamPOKjdyMJ1QavEMuxi5XF
X-Google-Smtp-Source: AGHT+IFgTA51oh9t2xOLVdyb16OKG6u1P0ZDyv7NbanSvpvdbM1HHcYVa+uySUSYtUfikNypigN8jA==
X-Received: by 2002:ac2:5e78:0:b0:57d:a4e9:5b00 with SMTP id
 2adb3069b0e04-5906d8e5c65mr5358549e87.30.1760543085248; 
 Wed, 15 Oct 2025 08:44:45 -0700 (PDT)
Received: from chromium.org ([91.209.212.108])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59088563cbesm6363777e87.64.2025.10.15.08.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:44:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v4 02/11] boot: Add a new test for global bootmeths
Date: Wed, 15 Oct 2025 16:44:05 +0100
Message-ID: <20251015154423.908468-3-sjg@chromium.org>
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

These have different behaviour from normal bootmeths and we are about to
enhance it. So add a test and also an extra check in bootflow_iter()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Drop call to bootflow_show()

 test/boot/bootflow.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 7cd83dc7443..f3386a1eb31 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -307,6 +307,8 @@ static int bootflow_iter(struct unit_test_state *uts)
 	ut_asserteq(0, iter.max_part);
 	ut_asserteq_str("extlinux", iter.method->name);
 	ut_asserteq(0, bflow.err);
+	ut_assert(!iter.doing_global);
+	ut_asserteq(-1, iter.first_glob_method);
 
 	/*
 	 * This shows MEDIA even though there is none, since in
@@ -388,6 +390,48 @@ static int bootflow_iter(struct unit_test_state *uts)
 BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
+
+/* Check iterating through available bootflows to test global bootmeths */
+static int bootflow_iter_glob(struct unit_test_state *uts)
+{
+	struct bootflow_iter iter;
+	struct bootflow bflow;
+
+	bootstd_clear_glob();
+
+	/* we should get the global bootmeth initially */
+	ut_asserteq(-EINVAL,
+		    bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_ALL |
+					BOOTFLOWIF_SHOW, &bflow));
+	ut_asserteq(3, iter.num_methods);
+	ut_assert(iter.doing_global);
+	ut_asserteq(2, iter.first_glob_method);
+
+	ut_asserteq(2, iter.cur_method);
+	ut_asserteq(0, iter.part);
+	ut_asserteq(0, iter.max_part);
+	ut_asserteq_str("firmware0", iter.method->name);
+	ut_asserteq(0, bflow.err);
+	bootflow_free(&bflow);
+
+	/* next we should get the first non-global bootmeth */
+	ut_asserteq(-EPROTONOSUPPORT, bootflow_scan_next(&iter, &bflow));
+
+	/* at this point the global bootmeths are stranded above num_methods */
+	ut_asserteq(2, iter.num_methods);
+	ut_asserteq(2, iter.first_glob_method);
+	ut_assert(!iter.doing_global);
+
+	ut_asserteq(0, iter.cur_method);
+	ut_asserteq(0, iter.part);
+	ut_asserteq(0, iter.max_part);
+	ut_asserteq_str("extlinux", iter.method->name);
+	ut_asserteq(0, bflow.err);
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_iter_glob, UTF_DM | UTF_SCAN_FDT);
+
 /* Check using the system bootdev */
 static int bootflow_system(struct unit_test_state *uts)
 {
-- 
2.43.0

