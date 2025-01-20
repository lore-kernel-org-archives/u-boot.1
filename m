Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43059C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8154E80758;
	Mon, 20 Jan 2025 22:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LFVhj28e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E09C8081A; Mon, 20 Jan 2025 22:54:26 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66BEA8091A
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a9caa3726fso14328135ab.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410061; x=1738014861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtfxNGXbYOLkmHm1Pwot8wpDrrpMGO+KVId3EuAMYw8=;
 b=LFVhj28eVRa/4Xle7rzSmwAAc5Voq/lVFN1vGQPRSONHmT7hXwPPrs0eu/KATWCTVY
 /ExZgV4uHwtkzNnixCSOskjku/UTPKtzYDCoiDqu/MpWuJQgdTwjT/YH0GAaHbtNUlsG
 jEWqSIu3OvLd47S25bJyNvMzictzxUI6JY24I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410061; x=1738014861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KtfxNGXbYOLkmHm1Pwot8wpDrrpMGO+KVId3EuAMYw8=;
 b=Nc/osG7OrSOR2MwhOy1a/xF7z0WSH1I4gPT/xXFfP+hbjD1P8upD46GIoPrwFxd5lb
 8YcHu4vFUfQgtP5GGc6gSFjsyp6xGUuH3SDNzRrl95Bd6FBAisxUN6YcvwkTYbC8upZq
 sVDlzvADGRCHgzEFPxkdac0TgvJqglOtKOGMqe/QBPAxQtAOljgJzPCtkMBlXKQjO8gQ
 8eQBp3XWweAWDyolix2xn1PEAEyBBcmqthfzqUH8LWexOKYNdPBf6WmhW3Gj/ao+RgLJ
 vmxU56WJuEyiPVVA93t4QjVn38ivJT232hKhqBHT+ephqya2DyK2hq1vaYdNX9m8S6U2
 lqow==
X-Gm-Message-State: AOJu0Yxjp/7O8rHFt7yUsdELrVGNcFHxmj/LndKjGpXZdBfAkfdaYnMt
 wybqjJoV+z0s36wzVjinScNUFoZNjdjYezB5OnTNl1aBh87k9E30Qqv1vMJ96CNS1YvcLFjfXq4
 =
X-Gm-Gg: ASbGncupSM46S1YoYA2dtUH23uP+Y3jsj3joNbqWiuDNqvZMInoSTJcDkJi0EVTcIHE
 S+JDoEWPDkDAG/BzcUV8WSLfrogrJzQEQK8PaBvfO5ybOR9kOezkXeoO2D4hHusKuJ3IcfWuxBP
 pm3gFGnSsZBj2RKXRHapgNHexmvdqwyB8ZOUMFBzEsbuqB8b0a99vbb/y58NFMcPABQPrb80Ege
 tqCt6kscTy4WMD0GQdK2a0mYEZLrPFnpY5oiwz1G6fekpXSVv8a4nL0oSynAiOMejHYuF9cX7Y1
 FIdgvhzos7gPW+JUppcWhw7WmEp/wm0=
X-Google-Smtp-Source: AGHT+IE7ZY1aH2DpMsQzBOF1gGFGsaKMK0C/J/C3Qsy3qHtj7yKeuNA8+DLSf5IKE5VxAddWmzuqKw==
X-Received: by 2002:a92:dc0e:0:b0:3ce:7a51:c08c with SMTP id
 e9e14a558f8ab-3ce84962b43mr170798515ab.2.1737410061642; 
 Mon, 20 Jan 2025 13:54:21 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jens Wiklander <jens.wiklander@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/28] test: Update optee to do init and uninit from tests
Date: Mon, 20 Jan 2025 14:53:18 -0700
Message-ID: <20250120215340.617194-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

