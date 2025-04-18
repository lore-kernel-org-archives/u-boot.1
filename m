Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C5AC369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43CB0832F7;
	Fri, 18 Apr 2025 16:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n2TAe6FM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDBC8331F; Fri, 18 Apr 2025 16:11:45 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2356A832E6
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so1200973f8f.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985501; x=1745590301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkWL1MaiqaXAhXj3hNcPT7tFwLYqRvBzsR/OrfCGyek=;
 b=n2TAe6FMizprySNQzSP0dWNQm2jQ074d4euUjW5aSlc0C31J4dX5qg6eutQ70Zbw7V
 js/BtI+YZ6T9Jzjq/y3fB66kI4D+eVA/gcRBFWIM4qmgSEAViwU6Wucxfy44g242Rd8U
 Bo5WwpniRyPqPg8EXc/xQC7AcXTCS4ScMAupd9YnCYxKRgWVBDkFuHhJp0Kc/FgztLJI
 ZlHZM7G83431qII2obAzLL6xk43FLVw2YtDt3s7bm17yoVHiq3yp96Iqdq68Mx5Od1cK
 oVN1yp17M73TyFf7G/PPCoaEWkjlCzSarThfbnHISlxHl6xpX3EntlDpKnGfutujl/SY
 Gj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985501; x=1745590301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkWL1MaiqaXAhXj3hNcPT7tFwLYqRvBzsR/OrfCGyek=;
 b=DYQ6/KFh1opP2GfNZ8jcSV0Eto/JoNiALv0hBNaALiLT5CpirJ80WsBpZ/RnN3tZLn
 9hZ463gN/oyJKztzqUAOa2iJz52nY3accEBOCNmGwVLBvLYC99rkfrf/ShLX+Nod86B+
 TOVd0wPHzTfz/Gg0QoaZ/54WxMmEpxehhTSqPRaocaapcU3aCsHwqjVhEvGTBE+40u/w
 lILpI6Vok/o8eQk80Ww90xCx2SNrKljfwDW/Fp9zoGBz2uqcXkSdLHs5xid1Z5Iw6mY3
 osLa9crS+0TO72dbLZncmvGENj0y7GREnrSO/Q8TO3Zwdt1REkQU7uRO+7Kbq0uiFRfh
 GtJg==
X-Gm-Message-State: AOJu0YyaM1CpW/tRhSotHlXmKfP7MwV6hToqZajDj+m5BpbGdlUpYTxs
 z0RSsbXyszWS1UzpqomdsOxELnIgi2T6yXMEoQUVT3IqO1Df6nu2EpHsMwuO+GbPZwFD2f1P2OX
 GPLVE9w==
X-Gm-Gg: ASbGnctbqVRuMoUTZFy8GS92s9pNZpeVc1S/ZpO1mcSYSCKiLFYUaBGK961vo4NFN6Z
 WZ+Rxdqg/WFUiAVc8EgW1zIlZW13cLH9pxxXlAwUwvNNKRwAVuwXQIMt1i5wIpfdJQDVuoSiKtm
 Tk2ZuvvlRPYAibhYwoTl6lc9Ls3dL29ORO1x381nAM009f/HnEsA/Fnx8JzwFmCVQ5lVx9pjBms
 osEKQlCSvfSZgkAteBD0xgFnyqwmjfh834OMGoxgryCNTGwQdN1tCRnOjQQU7kA8fJaekXAlkjF
 ZK9V0cGrlZjPJ0f0u5mO0SRBsQNIU+3lES6iDq2PUUY6gDqbfw==
X-Google-Smtp-Source: AGHT+IHxN9aeSN8wdRGVTYjKu7UIVFWFPq5UJn/E4nwc94aUkv4bcE02CYJMWnKz9WsamOov5FRNRw==
X-Received: by 2002:a05:6000:1acb:b0:39c:1258:2dc8 with SMTP id
 ffacd0b85a97d-39efbaf211bmr2256119f8f.57.1744985501438; 
 Fri, 18 Apr 2025 07:11:41 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:41 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 11/17] test: lib: add uthread_mutex test
Date: Fri, 18 Apr 2025 16:09:39 +0200
Message-ID: <20250418141114.2056981-12-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418141114.2056981-1-jerome.forissier@linaro.org>
References: <20250418141114.2056981-1-jerome.forissier@linaro.org>
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

Add a test for uthread mutexes.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v6:
- Rename static function lib_uthread_mutex() to uthread_mutex() so that
the test now shows as ut_lib_uthread_mutex in the test log rather than
ut_lib_lib_uthread_mutex.
- uthread_mutex_trylock() now returns -EBUSY not EBUSY when mutex is not
available

 test/lib/uthread.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/test/lib/uthread.c b/test/lib/uthread.c
index ad0217485dc..10a94d1c560 100644
--- a/test/lib/uthread.c
+++ b/test/lib/uthread.c
@@ -78,3 +78,69 @@ static int uthread(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(uthread, 0);
+
+struct mw_args {
+	struct unit_test_state *uts;
+	struct uthread_mutex *m;
+	int flag;
+};
+
+static int mutex_worker_ret;
+
+static int _mutex_worker(struct mw_args *args)
+{
+	struct unit_test_state *uts = args->uts;
+
+	ut_asserteq(-EBUSY, uthread_mutex_trylock(args->m));
+	ut_assertok(uthread_mutex_lock(args->m));
+	args->flag = 1;
+	ut_assertok(uthread_mutex_unlock(args->m));
+
+	return 0;
+}
+
+static void mutex_worker(void *arg)
+{
+	mutex_worker_ret = _mutex_worker((struct mw_args *)arg);
+}
+
+/*
+ * thread_mutex() - testing uthread mutex operations
+ *
+ */
+static int uthread_mutex(struct unit_test_state *uts)
+{
+	struct uthread_mutex m = UTHREAD_MUTEX_INITIALIZER;
+	struct mw_args args = { .uts = uts, .m = &m, .flag = 0 };
+	int id;
+	int i;
+
+	id = uthread_grp_new_id();
+	ut_assert(id != 0);
+	/* Take the mutex */
+	ut_assertok(uthread_mutex_lock(&m));
+	/* Start a thread */
+	ut_assertok(uthread_create(NULL, mutex_worker, (void *)&args, 0,
+				   id));
+	/* Let the thread run for a bit */
+	for (i = 0; i < 100; i++)
+		ut_assert(uthread_schedule());
+	/* Thread should not have set the flag due to the mutex */
+	ut_asserteq(0, args.flag);
+	/* Release the mutex */
+	ut_assertok(uthread_mutex_unlock(&m));
+	/* Schedule the thread until it is done */
+	while (uthread_schedule())
+		;
+	/* Now the flag should be set */
+	ut_asserteq(1, args.flag);
+	/* And the mutex should be available */
+	ut_assertok(uthread_mutex_trylock(&m));
+	ut_assertok(uthread_mutex_unlock(&m));
+
+	/* Of course no error are expected from the thread routine */
+	ut_assertok(mutex_worker_ret);
+
+	return 0;
+}
+LIB_TEST(uthread_mutex, 0);
-- 
2.43.0

