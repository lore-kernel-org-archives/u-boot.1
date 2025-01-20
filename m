Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E9DC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D113C80885;
	Mon, 20 Jan 2025 22:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kDiCwhcu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D024E8081A; Mon, 20 Jan 2025 22:54:21 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99DAE8032B
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-84a012f7232so191493039f.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410057; x=1738014857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJFEr7kA5O+Is6WalzbkKO7BeoC4uA3biBUvNJwlKhQ=;
 b=kDiCwhcuSLp380F70KvJ+dNnSdYMe68Ljj3ynlaj7Zu1IFWXxJrRqLtr9vi4AW0Jrc
 G7s6OcLqEHCz0Qf6/wVlEJCnQGiTe2S3Z5OnIboFw0pr6BRGp4PzW2RRKEWInptPpeIj
 DrZzfTjy3dm5z+ZZJF6X/eHjNWzuY+lTz79LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410057; x=1738014857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJFEr7kA5O+Is6WalzbkKO7BeoC4uA3biBUvNJwlKhQ=;
 b=Rl1dyxmVTPIDcqJYe/ELa3UIFe7bz6wpmvCHWweZDBvUrpAcMrr4HMqY70lY0LRSZD
 /jSu0lM/ztQOh0HIUobNg8W3qzE7tua+5ZJ3K/5ilntbEIkBWCtzc/nsnGLBPiu5+MR3
 ticRc8Vb29MQN+pVJdVKVmJWxU1ilH0e9tZ/9gx7RNQeQ7DYztcIfBpvldoZHkMSKUdf
 tTkXFI/dLCqlQ26LyQ3xJprz2tj2mqCC3X6jOnA1wtbtoCZ++5gO7lyl/9xZFXLUfKSz
 UQN34FqhMW2gf9e/55Dopj8CeUT+Sxxoest6G6WxaDeoep4jVcXJ6QNw8Muhh31wizSQ
 ZxEg==
X-Gm-Message-State: AOJu0Yz1tgkIUSkS9/XxrWw0PgRriot8kL+ZeB4Dbiggv30smeO67zue
 F01srsBInTJn1OItcPoSlqoaZZ2gMOaaQJT+Al7JFyw5Szgwi0atrPJ/iqE9yW56PmCsvyNH8dA
 =
X-Gm-Gg: ASbGnct+kbjyv1QONqBQRW4sIB5mNvPUnYAX2nK1yiduB1oJR7k6ob0VUMPH0M302QI
 c71g8GgHl2UO43B25mj4Z6qInC1eHd05b9xJLNrpeuhGXugEOErj33FaMTpWi7ZRsxC6+s4N+SJ
 QH0JKvnF7hLtbLXDAdcpSpdzjpRmUobHBiW1nJuSpyGIFEpCTwPw+NtR7rpCoPOC0CjU0yQCNsm
 IOUiims66hU0aG9HJi+FcYxDWxOPBQltibqbIWPb5XMUg0DUYc0sqoe+EUlUPsz+ZeVfKAYn4/9
 gw/9tSJMLEMYj1CWcnHmHxG8FYQW1SA=
X-Google-Smtp-Source: AGHT+IERCvHAfQ/0jKj8hriXlB4BATe/rLFV+O6hx+kgM/0mYjCnvf7hIr6Z6fK3nRtrCC0NkoXUfw==
X-Received: by 2002:a05:6602:187:b0:82c:ec0f:a081 with SMTP id
 ca18e2360f4ac-84f673f6673mr1615738939f.4.1737410057431; 
 Mon, 20 Jan 2025 13:54:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/28] test: Update bootstd to do init from tests
Date: Mon, 20 Jan 2025 14:53:16 -0700
Message-ID: <20250120215340.617194-17-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/bootstd_common.c | 18 +++++++++---------
 test/boot/bootstd_common.h | 10 +---------
 test/boot/vbe_simple.c     |  3 ---
 3 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/test/boot/bootstd_common.c b/test/boot/bootstd_common.c
index 724e3d9bdd2..e28cae7f374 100644
--- a/test/boot/bootstd_common.c
+++ b/test/boot/bootstd_common.c
@@ -21,8 +21,14 @@
 /* tracks whether bootstd_setup_for_tests() has been run yet */
 bool vbe_setup_done;
 
-/* set up MMC for VBE tests */
-int bootstd_setup_for_tests(void)
+/**
+ * bootstd_setup_for_tests() - Set up MMC data for VBE tests
+ *
+ * Some data is needed for VBE tests to work. This function sets that up.
+ *
+ * @return 0 if OK, -ve on error
+ */
+static int bootstd_setup_for_tests(struct unit_test_state *uts)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(u8, buf, MMC_MAX_BLOCK_LEN);
 	struct udevice *mmc;
@@ -55,6 +61,7 @@ int bootstd_setup_for_tests(void)
 
 	return 0;
 }
+BOOTSTD_TEST_INIT(bootstd_setup_for_tests, 0);
 
 int bootstd_test_drop_bootdev_order(struct unit_test_state *uts)
 {
@@ -99,13 +106,6 @@ int do_ut_bootstd(struct unit_test_state *uts, struct cmd_tbl *cmdtp, int flag,
 {
 	struct unit_test *tests = UNIT_TEST_SUITE_START(bootstd);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(bootstd);
-	int ret;
-
-	ret = bootstd_setup_for_tests();
-	if (ret) {
-		printf("Failed to set up for bootstd tests (err=%d)\n", ret);
-		return CMD_RET_FAILURE;
-	}
 
 	return cmd_ut_category(uts, "bootstd", "bootstd_",
 			       tests, n_ents, argc, argv);
diff --git a/test/boot/bootstd_common.h b/test/boot/bootstd_common.h
index ea3ecd1166c..c61698adc02 100644
--- a/test/boot/bootstd_common.h
+++ b/test/boot/bootstd_common.h
@@ -13,6 +13,7 @@
 
 /* Declare a new bootdev test */
 #define BOOTSTD_TEST(_name, _flags)	UNIT_TEST(_name, _flags, bootstd)
+#define BOOTSTD_TEST_INIT(_name, _flags) UNIT_TEST_INIT(_name, _flags, bootstd)
 
 #define NVDATA_START_BLK	((0x400 + 0x400) / MMC_MAX_BLOCK_LEN)
 #define VERSION_START_BLK	((0x400 + 0x800) / MMC_MAX_BLOCK_LEN)
@@ -35,15 +36,6 @@ struct unit_test_state;
  */
 int bootstd_test_drop_bootdev_order(struct unit_test_state *uts);
 
-/**
- * bootstd_setup_for_tests() - Set up MMC data for VBE tests
- *
- * Some data is needed for VBE tests to work. This function sets that up.
- *
- * @return 0 if OK, -ve on error
- */
-int bootstd_setup_for_tests(void);
-
 /**
  * bootstd_test_check_mmc_hunter() - Check that the mmc bootdev hunter was used
  *
diff --git a/test/boot/vbe_simple.c b/test/boot/vbe_simple.c
index 4fe4323b401..2fe74e1f6c6 100644
--- a/test/boot/vbe_simple.c
+++ b/test/boot/vbe_simple.c
@@ -33,9 +33,6 @@ static int vbe_simple_test_base(struct unit_test_state *uts)
 	ofnode node;
 	u32 vernum;
 
-	/* Set up the VBE info */
-	ut_assertok(bootstd_setup_for_tests());
-
 	/* Read the version back */
 	ut_assertok(vbe_find_by_any("firmware0", &dev));
 	ut_assertok(bootmeth_get_state_desc(dev, info, sizeof(info)));
-- 
2.43.0

