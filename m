Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50050C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B77FB80711;
	Mon, 20 Jan 2025 22:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LXXJlq/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10183807A7; Mon, 20 Jan 2025 22:26:34 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB07580717
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844d5444b3dso172077639f.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408390; x=1738013190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FOgyRtThnqBZ1W2WfxVri4UXHwYDFV4GDrVz1Giqns=;
 b=LXXJlq/XRN/JM0K7hEX2SJYRX0vAJlz/aCdVceAuu2lU7YYO7xoT8KXRg0PO6zLWta
 BPdJYr0cmI/BWz14s4iKaJxUYtBCann0p0w7yENj0RgvaqTa5yWv573QASlyk/1toKen
 3GmSY0knL/3ghP+USlN6LEOFDPhYSu9oDabk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408390; x=1738013190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9FOgyRtThnqBZ1W2WfxVri4UXHwYDFV4GDrVz1Giqns=;
 b=JZYdD4ZDVIEy0D1s5kl9TObpzXyt18nxZYyQZbM2L8F5SXAkgxL0NlPqPFMSeOQ5PZ
 JR/7pZo7z0QBd11b7+LS2cWhXOZLxa6hJgB8YuL/kmdhMKALZ1VkrhUJnIght/h7zux8
 7Vyr97grSesn63BSfwSmxceRyf5Qt+Eh0RxTtDtDJHmasNjPBeqKH8pOwPgnrMrP4c/p
 faC+pcJq5afviWhFBt7Xl6LjgUSRk92c20ELo66WyexVim+Ea1GxGs5Tdx3QOAtY4mWX
 FoX5wagOIQOrIOaj0cURSeVhsD3pSEoXg9X5e53ahP8/Xz7OtXboM4CtoU9gr6MsE+N7
 GCqw==
X-Gm-Message-State: AOJu0Yz3CwclJrkL6UxleUE81wjFAYJw/9IjssLDMtzLN736KHjlQgE7
 8H8AR8R0BkNTh1rLhnOOYF26wLpeT2dZqbp74BqDbs3cbt8/T4dlJ/PNJFDvaRDD+ceu6cUx23U
 =
X-Gm-Gg: ASbGncsQ1M3KylGiximS9tg1ZJM1M8dnIWMrzyD/qiB3gO98KI/zarIZkGo2XgpoSlT
 XRBZItKg219maIjznW8TdnaoereKpuILo6E0mJ0hCYcO2D2WIwrR/gjpCdfleAU4AVXdFM+ZkDI
 CFAWyu4OPCroFhc7KQU8JQs6C3Ql7I9XmNCYgixK8wAOc14iycmhzbhkD6M1XArJjcv/KnczXK3
 TsrIzZcY32lor2yQmngWSaxrdXHMuUXXkUtoFaVcr3WTKzqY/QwZi1QpOekgByFiDGJh3Wo3b0G
 zu+oGjAQyBpIHCz3Yix6HBiaeIHZJn8=
X-Google-Smtp-Source: AGHT+IHNgRLRcXC5EWYjnbNUKFpQFHgK/9/lOnqbHDj2GAOZsXCIQF6p3tKTNVkaolVpu713AvhAug==
X-Received: by 2002:a05:6602:328d:b0:841:99cb:776f with SMTP id
 ca18e2360f4ac-84f6740ce60mr1729189939f.6.1737408389943; 
 Mon, 20 Jan 2025 13:26:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/44] test: Rename test_get_state() to ut_get_state()
Date: Mon, 20 Jan 2025 14:25:24 -0700
Message-ID: <20250120212613.516664-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

(no changes since v1)

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
2.43.0

