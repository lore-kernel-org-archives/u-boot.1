Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E32C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E1A688912;
	Sat, 13 Jul 2024 15:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="V9vTOvuh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nKdOZyzD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B331E8892A; Sat, 13 Jul 2024 15:21:54 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 889038891A
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WLpym2DSyz9scS;
 Sat, 13 Jul 2024 15:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dugnfrAdWVCYrN3kWmXN2sxDqpt+ffnOzNe+KWb+DcY=;
 b=V9vTOvuh1Osvm1DHMiK1amFj8zjdr+9jF56AubbsAOcfDzEDwf38q6mVkJX5vOZ6fuX3eq
 btqde8rD/tbF+OnNyy2de0jXuJZk8yTDJLCoqqxz5arD6FTUDtn/9GXGUgxqgozAjqyqjy
 AvN9mgaD6PsOkDRe6FFk+u+j2ZfQtrNFISX+JOQoA5gktajkZbEYkVw/x50sPacdd7TJT0
 lXG8EHnPFpgsPIFR/lqPmJbNBcpH1RCtAdePRYQD/Yk6qOGZHDZQBQCENUKrNlEpMCx61i
 RwlS6EIil75UL7TuMjenijfe5ZqW+uCQo/oEYfGAT8WhPSHycBVZkjXf1d6L5Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dugnfrAdWVCYrN3kWmXN2sxDqpt+ffnOzNe+KWb+DcY=;
 b=nKdOZyzD8WILauQeNVweWIAYBxhx41lLI50/dd1BMMWbWNWB/nH4xvakE/LlAQX1C0EyYY
 5G28wx1NofVLHr/KK6OYQcbgO0oj/YH8abUFhS4ARB7fZshXklIEHxhDmonitQRFNpw5Ra
 JGdtAHwQ3M820vUaP7TTo4UkCQ+Iy39xyXKjbqMJh6f0ZotimdQPLJyti8nxeSAaYO+0ss
 f/3cSv0x809mbIx1dvtl69jmO40jdtRQgiksVxpnHC4KpjBskiFpWGXELZj/HNpqr8fJZW
 CuAM1stfLV2CAsqnDoqGy98ygzkw7VaG1M+WT2NQbR4EvGI3dT1vjvoHD4DRrg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 42/45] test: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:33 +0200
Message-ID: <20240713132021.57650-42-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1639a39fd6fc2f4c6c8
X-MBO-RS-META: panm8e143e7mjofzc96cuzgs935p1s6f
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 test/boot/bootdev.c  | 1 -
 test/cmd/setexpr.c   | 1 -
 test/compression.c   | 1 -
 test/dm/devres.c     | 1 -
 test/dm/fwu_mdata.c  | 1 -
 test/dm/remoteproc.c | 1 -
 test/dm/spmi.c       | 1 -
 test/dm/usb.c        | 1 -
 8 files changed, 8 deletions(-)

diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 6e940002f84..1bf5929c396 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -680,7 +680,6 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 BOOTSTD_TEST(bootdev_test_next_label, UT_TESTF_DM | UT_TESTF_SCAN_FDT |
 	     UT_TESTF_ETH_BOOTDEV | UT_TESTF_SF_BOOTDEV);
 
-
 /* Check iterating to the next prioirty in a list */
 static int bootdev_test_next_prio(struct unit_test_state *uts)
 {
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index d50ce5803c3..4c6cc3cf09e 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -329,7 +329,6 @@ static int setexpr_test_str(struct unit_test_state *uts)
 }
 SETEXPR_TEST(setexpr_test_str, UT_TESTF_CONSOLE_REC);
 
-
 /* Test 'setexpr' command with concatenating strings */
 static int setexpr_test_str_oper(struct unit_test_state *uts)
 {
diff --git a/test/compression.c b/test/compression.c
index aa1d38bb7bc..618a1936955 100644
--- a/test/compression.c
+++ b/test/compression.c
@@ -139,7 +139,6 @@ static const char zstd_compressed[] =
 	"\x01\xe4\xf4\x6e\xfa";
 static const unsigned long zstd_compressed_size = sizeof(zstd_compressed) - 1;
 
-
 #define TEST_BUFFER_SIZE	512
 
 typedef int (*mutate_func)(struct unit_test_state *uts, void *, unsigned long,
diff --git a/test/dm/devres.c b/test/dm/devres.c
index 95a470b9f1c..7a3a669ddd4 100644
--- a/test/dm/devres.c
+++ b/test/dm/devres.c
@@ -69,7 +69,6 @@ static int dm_test_devres_free(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_devres_free, UT_TESTF_SCAN_PDATA);
 
-
 /* Test that kzalloc() returns memory that is zeroed */
 static int dm_test_devres_kzalloc(struct unit_test_state *uts)
 {
diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
index 0be7f4519e2..6154480ba83 100644
--- a/test/dm/fwu_mdata.c
+++ b/test/dm/fwu_mdata.c
@@ -129,7 +129,6 @@ static int dm_test_fwu_mdata_write(struct unit_test_state *uts)
 	 */
 	event_notify_null(EVT_MAIN_LOOP);
 
-
 	ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
 
 	ut_assertok(fwu_init());
diff --git a/test/dm/remoteproc.c b/test/dm/remoteproc.c
index ef9e8e5a0df..444c4dce083 100644
--- a/test/dm/remoteproc.c
+++ b/test/dm/remoteproc.c
@@ -28,7 +28,6 @@ static int dm_test_remoteproc_base(struct unit_test_state *uts)
 	/* Ensure we are initialized */
 	ut_asserteq(true, rproc_is_initialized());
 
-
 	/* platform data device 1 */
 	ut_assertok(rproc_stop(0));
 	ut_assertok(rproc_reset(0));
diff --git a/test/dm/spmi.c b/test/dm/spmi.c
index e10ae8db4d3..ee444f3b9b1 100644
--- a/test/dm/spmi.c
+++ b/test/dm/spmi.c
@@ -70,7 +70,6 @@ static int dm_test_spmi_access(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_spmi_access, UT_TESTF_SCAN_FDT);
 
-
 /* Test if it's possible to access GPIO that should be in pmic */
 static int dm_test_spmi_access_peripheral(struct unit_test_state *uts)
 {
diff --git a/test/dm/usb.c b/test/dm/usb.c
index 9a571938b81..0bbea219ec9 100644
--- a/test/dm/usb.c
+++ b/test/dm/usb.c
@@ -423,7 +423,6 @@ static int dm_test_usb_keyb(struct unit_test_state *uts)
 		{0x00, 0x00, "\0"}
 	};
 
-
 	state_set_skip_delays(true);
 	ut_assertok(usb_init());
 
-- 
2.43.0

