Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9E8E6B271
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 13:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C9B7892A2;
	Fri,  1 Nov 2024 14:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yp6qrkG7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F119892DB; Fri,  1 Nov 2024 14:03:31 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C88389287
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 14:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43168d9c6c9so15686795e9.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730466209; x=1731071009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5miTQ+tzSnPBKkENx7Q93bOMKqAg7gUkwuBRCGboYqA=;
 b=Yp6qrkG7Fg+qHpzX5VRJkEwPxzr4JGKWVdBwEJWHhYHc5l5ZG5XqteJoy5gTSVuZnI
 443BoB8GOhlaL7PFLau3+foEFHexcGp7e3EyxeCpIdR5PvU/cQ2udel25uLmOELhrQaN
 jZtbXKSft8Hn5gtyuVIackel71BcBwHb+IHWjXx98cd3Gqq9hVFo2Bku94F0aQTzlhR4
 qMdk7YWj2NFBwSj2JTuraEgy+K6DtJWB48KJfUYpZN4uqQtxnaMxeYeQxAsYy1m9OZ0A
 +WGudSzqe0Vqubb6zx1aYXgAxfwJ7i1yI0usyS/mtccGUnaDFzaHrcvS8K8Mn3k57Vsu
 wnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730466209; x=1731071009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5miTQ+tzSnPBKkENx7Q93bOMKqAg7gUkwuBRCGboYqA=;
 b=KxoboWrnq4W6ClylK0QY36f6OV0j/LzxDHjywYWLF/p28F4aX3pSwL7F19vLExCDeH
 4MCzqzGVhu6KJ4ZobjYUdid/oZHkyjfAW+0D8TnhDvMe3S9IvOorjBo+gFRDqFu/niip
 73f5cfzwgJN4ZtC+ZVxp8EGsV5AOPAE3vMRR8cxPn+RDoQcm1SKlYKGPmjAYbIfbR7ZO
 Kb6awh/GRnF05ifAJYAevV+5iH52bn0bIP6lScZGu5Fo5Ymw0NxWkkY/Bw01ntQByG+u
 Woc/MbUC95giGbBXa7/lJ3eP44ksLRN+O35IDPPYIoxpUJanWMRgW2XE7nESxv6KqpRI
 Zwew==
X-Gm-Message-State: AOJu0YwGlc88O7QrU9k5mFY8c79yHRtbC3H9+BMMUV7Aul3ck/acnYny
 s/m7vK6E4x2MJd3sFTaDMRnVmyCU9Ohbm9pDZoiPfYBOb9l/S3/rJgiCDcpfzSCMMdcvzqe86wF
 rarQ=
X-Google-Smtp-Source: AGHT+IEltT06dtUqRATQhErzOjDja3jKeP6VqG95p6L2I6adqUdOic7qulnJOggZQ7PjW2BKrwijJQ==
X-Received: by 2002:a05:600c:46c8:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-4319acb17a9mr216425485e9.16.1730466208726; 
 Fri, 01 Nov 2024 06:03:28 -0700 (PDT)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:7dcf:21b3:7ed8:3010])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d685287sm62986385e9.35.2024.11.01.06.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 06:03:28 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] test: bootm: Ensure GD_FLG_SILENT is reset
Date: Fri,  1 Nov 2024 13:02:54 +0000
Message-Id: <20241101130254.473017-3-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101130254.473017-1-andrew.goodbody@linaro.org>
References: <20241101130254.473017-1-andrew.goodbody@linaro.org>
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

Some bootm tests expect that GD_FLG_SILENT is reset in order
to work as expected. This is the state if the test is run with
'pytest --verbose' but not if run from, say, the sandbox command
line.
So reset the flag for those tests that rely on it being reset. This
has to be done in each test as the test infrastructure will set it
again before every test when not invoked with 'pytest --verbose'.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

 test/bootm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/test/bootm.c b/test/bootm.c
index 5f57ecb337..52b83f149c 100644
--- a/test/bootm.c
+++ b/test/bootm.c
@@ -26,6 +26,9 @@ static int bootm_test_nop(struct unit_test_state *uts)
 {
 	char buf[BUF_SIZE];
 
+	/* This tests relies on GD_FLG_SILENT not being set */
+	gd->flags &= ~GD_FLG_SILENT;
+
 	*buf = '\0';
 	ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
 	ut_asserteq_str("", buf);
@@ -43,6 +46,9 @@ static int bootm_test_nospace(struct unit_test_state *uts)
 {
 	char buf[BUF_SIZE];
 
+	/* This tests relies on GD_FLG_SILENT not being set */
+	gd->flags &= ~GD_FLG_SILENT;
+
 	/* Zero buffer size */
 	*buf = '\0';
 	ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, 0, BOOTM_CL_ALL));
@@ -70,6 +76,9 @@ static int bootm_test_silent(struct unit_test_state *uts)
 {
 	char buf[BUF_SIZE];
 
+	/* This tests relies on GD_FLG_SILENT not being set */
+	gd->flags &= ~GD_FLG_SILENT;
+
 	/* 'silent_linux' not set should do nothing */
 	env_set("silent_linux", NULL);
 	strcpy(buf, CONSOLE_STR);
-- 
2.39.5

