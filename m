Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD16AC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD00807C0;
	Wed, 15 Jan 2025 14:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e0bLf8nz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0865807E1; Wed, 15 Jan 2025 14:31:27 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59B1680714
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-84a1ce51187so218853139f.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947883; x=1737552683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAviW5DOI2QYxgn9F4B9DXNrnQCTGcL/Rh547mgwWlM=;
 b=e0bLf8nzX5hmw8fSm1xx58SV4B7rVRHMnC1dXfdrf3sTFoolC4DS08bgX/IWGhgT+G
 zT65cDml4f+XTswlaKwbgcX7VvU5/q+XHjwMZ7pVCPjn9gRn+SelpqhD5EKN4p9rJl2b
 8hftfQ06dFUWKr/aXmdfd9YcO/PrR5YvM95b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947883; x=1737552683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LAviW5DOI2QYxgn9F4B9DXNrnQCTGcL/Rh547mgwWlM=;
 b=J9qGnFE9WguWDY66SeW8yr+VqWBbnhvkyCDIousO0pFbeUgS9jDJczoxB6onNKtjoJ
 XRke6Yscklee0pRSiChh4dXE7e8YhfCZyxsCxB1lMUzFJnbcfAR8QtMAUiWcYAQl1IBX
 jKhTGt23TAyTyPx0c/oTgGh1ctevEWjljjnkmQs4A0KVav7kDt1ZIGHrmdhdpC0fkdk9
 OujJbxk0IrchBIeIT3p6OrKLXS/+pfaw59qWjTe2I/eAysvwBexJo61dmTrUup1/gi/L
 4paCD10CJUUC2TDxqkhj81GeHwbJA6PIQnRQpLywwidVDMwky4ijkc0HLBjEesx3i5kv
 3BRA==
X-Gm-Message-State: AOJu0YxgqstYjSDut5Q/MYaHIHn/qUaFIy18GDFbFQ0mHZI1somUTruS
 RUKT0hlEHYTMaZ3q7QrwzNYWFl3l+3q0xBbLjGDWlyVTxk0pAeyUwsB/erBb9iaOCEi7fhLfhkM
 =
X-Gm-Gg: ASbGncv2k0dZvVAYL4AfJCSWePwHyavIVeNjk7GQsxsvm1vDpKTRZ1+FlbwiS/XiU8f
 I2+R5ozmQ4HC54zK49Nm+hFBVXyym7F75PoIdBg2SUTNDc7Bi5pHtoKUWXmXCF6os9lW02oLRLa
 vRibG/4fcwHN0LxTxgx2VsrjhS2XdLMC+fm+GAhxXscQRx8QQqnGeowWmRuWm0TrIrB1mT/QNgb
 dfBgsF7gKQfzlfV2PfCV+E3ghc+XtktgoKYx0b/8ktaGIu6ro+GMm0kwYq7Td05oJWTfU5nekbv
 IMg6//dbJe16peN0Vw==
X-Google-Smtp-Source: AGHT+IGWUBK7mekQ3zzYJrtOZpV6MPgR8etV+FVzyEhWAPdzfvreNcQT4oUEkbqQj8JaXvSXJH1PXQ==
X-Received: by 2002:a05:6e02:219e:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3ce3a9a6308mr224082265ab.1.1736947883450; 
 Wed, 15 Jan 2025 05:31:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/43] test: Rename test_get_state() to ut_get_state()
Date: Wed, 15 Jan 2025 06:30:32 -0700
Message-Id: <20250115133114.590375-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

Rename this function and test_set_state() so use the same ut_ prefix as
other functions in ut.h

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/ut.h     |  8 ++++----
 test/dm/test-driver.c | 10 +++++-----
 test/dm/test-uclass.c |  8 ++++----
 test/test-main.c      |  8 ++++----
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/test/ut.h b/include/test/ut.h
index c8838dad096..2e4d8edf826 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -466,18 +466,18 @@ void ut_unsilence_console(struct unit_test_state *uts);
 void ut_set_skip_delays(struct unit_test_state *uts, bool skip_delays);
 
 /**
- * test_get_state() - Get the active test state
+ * ut_state_get() - Get the active test state
  *
  * Return: the currently active test state, or NULL if none
  */
-struct unit_test_state *test_get_state(void);
+struct unit_test_state *ut_get_state(void);
 
 /**
- * test_set_state() - Set the active test state
+ * ut_set_state() - Set the active test state
  *
  * @uts: Test state to use as currently active test state, or NULL if none
  */
-void test_set_state(struct unit_test_state *uts);
+void ut_set_state(struct unit_test_state *uts);
 
 /**
  * ut_run_tests() - Run a set of tests
diff --git a/test/dm/test-driver.c b/test/dm/test-driver.c
index 851177c3018..759de3a5f77 100644
--- a/test/dm/test-driver.c
+++ b/test/dm/test-driver.c
@@ -35,7 +35,7 @@ static const struct test_ops test_ops = {
 
 static int test_bind(struct udevice *dev)
 {
-	struct unit_test_state *uts = test_get_state();
+	struct unit_test_state *uts = ut_get_state();
 
 	/* Private data should not be allocated */
 	ut_assert(!dev_get_priv(dev));
@@ -46,7 +46,7 @@ static int test_bind(struct udevice *dev)
 
 static int test_probe(struct udevice *dev)
 {
-	struct unit_test_state *uts = test_get_state();
+	struct unit_test_state *uts = ut_get_state();
 	struct dm_test_priv *priv = dev_get_priv(dev);
 
 	/* Private data should be allocated */
@@ -59,7 +59,7 @@ static int test_probe(struct udevice *dev)
 
 static int test_remove(struct udevice *dev)
 {
-	struct unit_test_state *uts = test_get_state();
+	struct unit_test_state *uts = ut_get_state();
 
 	/* Private data should still be allocated */
 	ut_assert(dev_get_priv(dev));
@@ -70,7 +70,7 @@ static int test_remove(struct udevice *dev)
 
 static int test_unbind(struct udevice *dev)
 {
-	struct unit_test_state *uts = test_get_state();
+	struct unit_test_state *uts = ut_get_state();
 
 	/* Private data should not be allocated */
 	ut_assert(!dev_get_priv(dev));
@@ -121,7 +121,7 @@ static int test_manual_bind(struct udevice *dev)
 
 static int test_manual_probe(struct udevice *dev)
 {
-	struct unit_test_state *uts = test_get_state();
+	struct unit_test_state *uts = ut_get_state();
 
 	dm_testdrv_op_count[DM_TEST_OP_PROBE]++;
 	if (!uts->force_fail_alloc)
diff --git a/test/dm/test-uclass.c b/test/dm/test-uclass.c
index 9a80cc63667..be4108bbecb 100644
--- a/test/dm/test-uclass.c
+++ b/test/dm/test-uclass.c
@@ -28,7 +28,7 @@ int test_ping(struct udevice *dev, int pingval, int *pingret)
 
 static int test_post_bind(struct udevice *dev)
 {
-	struct unit_test_state *uts = test_get_state();
+	struct unit_test_state *uts = ut_get_state();
 	struct dm_test_perdev_uc_pdata *uc_pdata;
 
 	dm_testdrv_op_count[DM_TEST_OP_POST_BIND]++;
@@ -54,7 +54,7 @@ static int test_pre_unbind(struct udevice *dev)
 static int test_pre_probe(struct udevice *dev)
 {
 	struct dm_test_uclass_perdev_priv *priv = dev_get_uclass_priv(dev);
-	struct unit_test_state *uts = test_get_state();
+	struct unit_test_state *uts = ut_get_state();
 
 	dm_testdrv_op_count[DM_TEST_OP_PRE_PROBE]++;
 	ut_assert(priv);
@@ -65,7 +65,7 @@ static int test_pre_probe(struct udevice *dev)
 
 static int test_post_probe(struct udevice *dev)
 {
-	struct unit_test_state *uts = test_get_state();
+	struct unit_test_state *uts = ut_get_state();
 	struct udevice *prev = list_entry(dev->uclass_node.prev,
 					    struct udevice, uclass_node);
 
@@ -100,7 +100,7 @@ static int test_pre_remove(struct udevice *dev)
 
 static int test_init(struct uclass *uc)
 {
-	struct unit_test_state *uts = test_get_state();
+	struct unit_test_state *uts = ut_get_state();
 
 	dm_testdrv_op_count[DM_TEST_OP_INIT]++;
 	ut_assert(uclass_get_priv(uc));
diff --git a/test/test-main.c b/test/test-main.c
index 8d764892fa6..cfb3504941d 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -63,12 +63,12 @@ static enum fdtchk_t fdt_action(void)
 /* This is valid when a test is running, NULL otherwise */
 static struct unit_test_state *cur_test_state;
 
-struct unit_test_state *test_get_state(void)
+struct unit_test_state *ut_get_state(void)
 {
 	return cur_test_state;
 }
 
-void test_set_state(struct unit_test_state *uts)
+void ut_set_state(struct unit_test_state *uts)
 {
 	cur_test_state = uts;
 }
@@ -466,7 +466,7 @@ static int ut_run_test(struct unit_test_state *uts, struct unit_test *test,
 	printf("Test: %s: %s%s\n", test_name, fname, note);
 
 	/* Allow access to test state from drivers */
-	test_set_state(uts);
+	ut_set_state(uts);
 
 	ret = test_pre_run(uts, test);
 	if (ret == -EAGAIN)
@@ -482,7 +482,7 @@ static int ut_run_test(struct unit_test_state *uts, struct unit_test *test,
 	if (ret)
 		return ret;
 
-	test_set_state( NULL);
+	ut_set_state(NULL);
 
 	return 0;
 }
-- 
2.34.1

