Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF65C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCD1F80C77;
	Fri,  7 Feb 2025 19:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EzPQFgmR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EFDC807FE; Fri,  7 Feb 2025 19:32:16 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ABAF80AE6
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844e6d1283aso99762739f.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953132; x=1739557932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/7LKAcsfbtUvSkf6NOnDSfADVnDp84UuVe5EvxybAw=;
 b=EzPQFgmRs+u//pdQpKeRO+pDPqyKnbbZxcfYVSZgHBmHMxy6utx2uBMBPJu9TxNWBw
 +jB9hTr3o4C694VE45gg0hB5jj5f+QUtzfU/jFoXCK00duD4/clg7G/5ZSyXvfDtGP8X
 KOEUv+xcWxnpAUez7RnmyfGPoVQRXWwnXsTC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953132; x=1739557932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o/7LKAcsfbtUvSkf6NOnDSfADVnDp84UuVe5EvxybAw=;
 b=byJnj4NC95/yJVZQdEE0+eUP3OfsTtcn05phUeCEC/twtn8zJLzS4T9rT/AEfrkLJV
 gcmWJWvF/QfrCpUKCAf38O0cT91BYcHAieEjhQ4XYltYJMVED1TS0TRdz6ty3F+lnXJv
 kaOB4CtfhUwZyEvsOy2zYwi8HLqlzOnLl7qCYQ1q7yS7x9BXxdfvtpMQpbdxqruVYWuG
 710raHj9LAxC/i251EIxkp8Mha6dsPnzgIFy1txUyJ86ID1Jbq6ambSd20jiMvDrgDJ+
 dUKgqeXSwBnqx5U7XSJNwUte3maFxfCR4NgGu557rrz48ajiLt5iL/TUNkEUj0u08Wvg
 HTZw==
X-Gm-Message-State: AOJu0YzrGPdkM7CC4hR34wttoFn3vo+sYhsPrAlmKmrv/7ok7yRzUTI9
 kadtA2ZcugewzlmbtGKExUQx2UDUJ9HrKqTJ3z2SefaI591SuDCx0fOKsMfZ2QEejHDy9Gx5VzA
 =
X-Gm-Gg: ASbGncsw4uvpd8bB/RWw97Hl4FBnIKW2ufSWF7WIyMiBsSSbP12b/XV9+XLrd4qyE8W
 1DeZxGYeq6sxHo8UwAbmuCXXzLUcXBwvf9k7b9FCWTAmy6qLi7dQGZm+F31su6C0kNpvEy9y1yH
 XsjoRK3NNUkFQCaZ8vszoVFBU1UATxQ+bXf2uKLQmXdzR3Qoa4FSO8XDEAxa3Urs5UZD0vXr0Jo
 MYqLKph/COm+BPUSVuTePnH7xX+fz1DhBlcP99468uD5n1AZpmpjnjZRz7Z2TBJOf29dC8+Qb5Y
 Hm1WcbM/6th37WcE6Xth7VxBs9SvE8gQEQ4F5v2sjeAtjB2wQ22N
X-Google-Smtp-Source: AGHT+IH6riLGbRwPAwrDnn3dEnfiZsmJaH/KlCo6YYdfWqiGdExK60rv514/Vjx3KPWFcZfclJdsYA==
X-Received: by 2002:a05:6602:36c8:b0:841:8345:5eed with SMTP id
 ca18e2360f4ac-854fe36b21dmr302983039f.0.1738953132433; 
 Fri, 07 Feb 2025 10:32:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 19/29] test: Update optee to do init and uninit from tests
Date: Fri,  7 Feb 2025 11:30:50 -0700
Message-ID: <20250207183121.117663-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

Rather than having an init function and then running the tests, create a
test-init function to do it. This will allow us to get rid of the
command function.

Fix the comment abotu 'environment' while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/optee.h      |  4 ++-
 test/optee/cmd_ut_optee.c | 55 +++++++++++++++++++++++++--------------
 2 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/include/test/optee.h b/include/test/optee.h
index f4255b39ee3..0a548a59e83 100644
--- a/include/test/optee.h
+++ b/include/test/optee.h
@@ -8,7 +8,9 @@
 
 #include <test/test.h>
 
-/* Declare a new environment test */
+/* Declare a new optee test */
 #define OPTEE_TEST(_name, _flags)	UNIT_TEST(_name, _flags, optee)
+#define OPTEE_TEST_INIT(_name, _flags)	UNIT_TEST_INIT(_name, _flags, optee)
+#define OPTEE_TEST_UNINIT(_name, _flags) UNIT_TEST_UNINIT(_name, _flags, optee)
 
 #endif /* __TEST_OPTEE_H__ */
diff --git a/test/optee/cmd_ut_optee.c b/test/optee/cmd_ut_optee.c
index fc6674764f9..792de304c15 100644
--- a/test/optee/cmd_ut_optee.c
+++ b/test/optee/cmd_ut_optee.c
@@ -26,6 +26,41 @@ extern u32 __dtb_test_optee_no_optee_begin;
 static void *fdt;
 static bool expect_success;
 
+static int optee_test_init(struct unit_test_state *uts)
+{
+	void *fdt_optee = &__dtb_test_optee_optee_begin;
+	void *fdt_no_optee = &__dtb_test_optee_no_optee_begin;
+	void *fdt_base = &__dtb_test_optee_base_begin;
+	int ret = -ENOMEM;
+
+	ut_assertok(fdt_check_header(fdt_base));
+	ut_assertok(fdt_check_header(fdt_optee));
+	ut_assertok(fdt_check_header(fdt_no_optee));
+
+	fdt = malloc(FDT_COPY_SIZE);
+	if (!fdt)
+		return ret;
+
+	/*
+	 * Resize the FDT to 4k so that we have room to operate on
+	 *
+	 * (and relocate it since the memory might be mapped
+	 * read-only)
+	 */
+	ut_assertok(fdt_open_into(fdt_base, fdt, FDT_COPY_SIZE));
+
+	return 0;
+}
+OPTEE_TEST_INIT(optee_test_init, 0);
+
+static int optee_test_uninit(struct unit_test_state *uts)
+{
+	free(fdt);
+
+	return 0;
+}
+OPTEE_TEST_UNINIT(optee_test_uninit, 0);
+
 static int optee_fdt_firmware(struct unit_test_state *uts)
 {
 	const void *prop;
@@ -101,26 +136,6 @@ int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	void *fdt_base = &__dtb_test_optee_base_begin;
 	int ret = -ENOMEM;
 
-	uts = calloc(1, sizeof(*uts));
-	if (!uts)
-		return -ENOMEM;
-
-	ut_assertok(fdt_check_header(fdt_base));
-	ut_assertok(fdt_check_header(fdt_optee));
-	ut_assertok(fdt_check_header(fdt_no_optee));
-
-	fdt = malloc(FDT_COPY_SIZE);
-	if (!fdt)
-		return ret;
-
-	/*
-	 * Resize the FDT to 4k so that we have room to operate on
-	 *
-	 * (and relocate it since the memory might be mapped
-	 * read-only)
-	 */
-	ut_assertok(fdt_open_into(fdt_base, fdt, FDT_COPY_SIZE));
-
 	/*
 	 * (1) Try to copy optee nodes from empty dt.
 	 * This should still run successfully.
-- 
2.43.0

