Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95105C0219C
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26BD380A09;
	Fri,  7 Feb 2025 19:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RGw4kB3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C99280BAA; Fri,  7 Feb 2025 19:32:12 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBEF5801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-84ceaf2667aso158871339f.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953128; x=1739557928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnOWpU9KxJvRuCRfNrOT/5cUliyxDIzfa/g0yQuwi5g=;
 b=RGw4kB3Mzno9aoyDVKIlQlHTPs9ZQ7k+tKGo6VGrPnIDA9rPLDob4HjQO0zOm4OMiB
 VRhAi7oILZJNl9jRxnOz6cKx4cELy3T5NaLTkQRjjSaUMGPw3FPcaK7WvlDEAw6Egktb
 H3RmKOP+40wpaWixZ8Nb0aMDdMzR1Z77kILSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953128; x=1739557928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GnOWpU9KxJvRuCRfNrOT/5cUliyxDIzfa/g0yQuwi5g=;
 b=XH2DE67TRNEiL1J/ux5yaZUbylcaItpEZEZuZVsycVOPuYpnxlOCQHCEHYFB4a4YPv
 7HSsjKsCd/fzVD3SvTnkGiCJs+dPEiF+D4R5cFyrl5vWl8R3cOmhOkXm4XSVST7+JsjV
 58HlAJVkrKOoVKfu/iq2DoTvUT6AXyuJuQw8gGWliKnF18jLNxwUD6UdqI4l6Mh1fpGq
 BkfrIhdMwb9ojV6bJx/5l+T4LcmspgGu8U4HZN4K3O9+piZzCoqeJR6eRog2ag7AW0eN
 vAssUaGvRZUA3vRuYysaQ60rKhTWzyVIRgGkHWQzgZ86FcSNQiagAjytTGXi12NH1iFt
 I3Uw==
X-Gm-Message-State: AOJu0YyPvjrJpNT8IyyARAahjXYfDa987ptOxH4oPhfGwcmEiIjv52Rn
 P7DR9ecV47ulurkfiXR1+6Vrtb5OHpeniGGkYkhx+XM/vuXui5iOU/X+3QXS3cIk8svKeas3O3A
 =
X-Gm-Gg: ASbGncvA2v6KQGM+yvOS6YA8oMAVqreyaxzsoRIzndLJunLqueYSo1xxc+Ey8wK94Ma
 znuFKa8sFajVLvIFtitKORYXuduaUJmCLy71FksLY9GBGJd2ml9Wr+jkVBZ5zvFt9a0R2MmCCer
 rSQ5vlbgpWebNVk1nRigk0hS5QYUzrTWH7kQMUgZaCnlnzFRcJvd1alwiEAQKcf4aANOpCqn9Pg
 TMesm807mn4FYbfIAZE1PBEQ3ASXXHjapplSc7iH+q04zpw5NgYbPUAIVX4kfjGuvPiwBmefc91
 1GmJEBHsXAHxCbETt/8U2eO1aTytFGPdNdkCQFVmdn4Qp5Zki+tB
X-Google-Smtp-Source: AGHT+IEeqYjpIOVR1XOXWKpSQ9LlVe0YmRSxjJm8XkOWL5pA14/mUZkxWFFbQS2e3vVPEbo4KFpa0w==
X-Received: by 2002:a05:6602:3a17:b0:854:e5e2:1083 with SMTP id
 ca18e2360f4ac-854fd911e0amr440092139f.13.1738953127993; 
 Fri, 07 Feb 2025 10:32:07 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 17/29] test: Update bootstd to do init from tests
Date: Fri,  7 Feb 2025 11:30:48 -0700
Message-ID: <20250207183121.117663-18-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

