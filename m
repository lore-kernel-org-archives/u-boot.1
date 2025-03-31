Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B4BC3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB34282033;
	Mon, 31 Mar 2025 14:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TImoIXsq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D8EE81703; Mon, 31 Mar 2025 14:31:51 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6186A81703
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2318604f8f.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424308; x=1744029108; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRaJm7848vfOJLHvrW3owiUGagnHG2yjnxN7am7SWEk=;
 b=TImoIXsqeXXfOILouqXKqw5nU9DEAtJbvgTL/zrCs1djs6mgkOEWQglHNkCBwV+jM2
 mZ5wC7pHEoG+VAAN293O5dvD9s8D8+Vk7k/iSB1dZPSKGL2lBXlLfkry5+5qG0Z82iY2
 aYT4q6K5SVU3cmtrQvSr8clYn1+uMkJJ4cphpT8IA5aKHnGW9wQF13uIMzVc9nEpfVds
 cyRa/rXgDlACizi7z125/R1hw5+M3hGCFh122Gc9kxAKthoQGqqmvrNF8yeD1uhO4jCR
 5tVH34ICXT/XStCTE+3SnVOS7m6yyCn0ax+uZuzGFqdupm/aCj5qSSNsbvHOtENlif9L
 meGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424308; x=1744029108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRaJm7848vfOJLHvrW3owiUGagnHG2yjnxN7am7SWEk=;
 b=j+DjK7bjl2xYknhRMllOnliqhWPRf04h6KTZoZZro0kKefz4/1ZDfeiLIRrfb54Y5W
 7f+cislwwUJ1oCfl3M9CD/fyjeIMlkheyqE7yRRFJhpQErPc3AoxXxfCUyGm9tfjJmC8
 r0NyZOuJ+2z/CR+MLfd8SHHE/xSDqKsn5CVKE1/9s66f/lR2UCA4JrK4qfbvKcY431Hv
 gJpQnBDJsSaNen/8lDYtYUs/Y5WCXoHKdd0B2HVZtmDSlFWuVSy2XYDiRRFhpGHkXv85
 fdW1yRtTarg3+0B8gFwvpwNH8n4K9HI/FoWwaFLT62/p49QiLYLhjKxZ5YEoNu1djELR
 SOiA==
X-Gm-Message-State: AOJu0YxT/o/eFFW5e29jrWhURN0c7GdFQ1wbKUhk9YDQPE5GRwem4A9o
 Du9Ot20p1ybGEWR7QFWY8IKJ1h9jCXiusPIgfc8vVrxM4y5DmcuqM6pIMuCLxIQqcwfbe18i3yO
 y10TIbg==
X-Gm-Gg: ASbGnctG1IzQXF34jbr+AQK+YDdZruKPuPr4+81ROuyk6pF/cNwztiAtK5KZaP/wf8z
 W8zwlJtEDn2681qJt8EvubpBxB/caTqtgqON66p/3RNsflLSwhjsi7MYHKk9ukuVV/sAygHeIVM
 fHfYRUrp4XlAC8Kw78IvuTJ3e957ZThKBDWYLh9HnEsRa/vOHEajRYkQw/HsrHhn6JEI9smrFwI
 98aPSnUY3bSUMhMzQOUh+uA2LUcGKtjwwo/pNRytvDH3n1H6XS8gRcVNA1z2O8J/glat4wj/9Px
 5orWhleD/DxVRzOQKUM5vgk/VFLBXFCvYmflgAz0nQ+3JkMEBn22
X-Google-Smtp-Source: AGHT+IHgjOhB+SLniLEtx5WVCPpdnmcvREO0AVm8cUhUCSceCdArMneyD0o2+8XkwrTYBPdLyahFwA==
X-Received: by 2002:a05:6000:2910:b0:391:4889:503e with SMTP id
 ffacd0b85a97d-39c120f5923mr6319901f8f.33.1743424308596; 
 Mon, 31 Mar 2025 05:31:48 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:48 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 11/16] test: lib: add uthread_mutex test
Date: Mon, 31 Mar 2025 14:31:05 +0200
Message-ID: <20250331123120.2025062-12-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331123120.2025062-1-jerome.forissier@linaro.org>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
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
 test/lib/uthread.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/test/lib/uthread.c b/test/lib/uthread.c
index 0c0540585e7..d33daa62f6c 100644
--- a/test/lib/uthread.c
+++ b/test/lib/uthread.c
@@ -78,3 +78,69 @@ static int lib_uthread(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_uthread, 0);
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
+	ut_asserteq(EBUSY, uthread_mutex_trylock(args->m));
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
+ * lib_uthread_mutex() - testing uthread mutex operations
+ *
+ */
+static int lib_uthread_mutex(struct unit_test_state *uts)
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
+LIB_TEST(lib_uthread_mutex, 0);
-- 
2.43.0

