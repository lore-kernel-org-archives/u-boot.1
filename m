Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FC2C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 11:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE7FF83102;
	Mon, 21 Jul 2025 13:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A8748319C; Mon, 21 Jul 2025 13:18:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1BB9B801DD
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 13:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB362681;
 Mon, 21 Jul 2025 04:18:35 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.26.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EE503F6A8;
 Mon, 21 Jul 2025 04:18:40 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v3 06/24] arm_ffa: sandbox: Add FFA_MEM_SHARE tests
Date: Mon, 21 Jul 2025 12:17:58 +0100
Message-Id: <20250721111816.62340-7-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721111816.62340-1-abdellatif.elkhlifi@arm.com>
References: <20250721111816.62340-1-abdellatif.elkhlifi@arm.com>
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Add positive and negative test cases

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/dm/ffa.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/test/dm/ffa.c b/test/dm/ffa.c
index 593b7177fce..59eea9a57cc 100644
--- a/test/dm/ffa.c
+++ b/test/dm/ffa.c
@@ -2,7 +2,7 @@
 /*
  * Functional tests for UCLASS_FFA  class
  *
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -13,6 +13,7 @@
 #include <asm/sandbox_arm_ffa.h>
 #include <asm/sandbox_arm_ffa_priv.h>
 #include <dm/test.h>
+#include <linux/sizes.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -141,6 +142,43 @@ static int test_partitions_and_comms(const char *service_uuid,
 	return 0;
 }
 
+static int  test_ffa_memory_share(bool test_ack, struct unit_test_state *uts)
+{
+	struct ffa_mem_ops_args args = {0};
+	struct ffa_mem_region_attributes attrs = {0};
+	static u8 buf[SZ_4K];
+	int ret;
+	struct udevice *dev;
+
+	ut_assertok(uclass_first_device_err(UCLASS_FFA, &dev));
+
+	args.attrs = &attrs;
+	args.nattrs = 1;
+	args.address = buf;
+	args.pg_cnt = 1;
+
+	if (test_ack) {
+		args.use_txbuf = true;
+
+		ut_assertok(ffa_memory_share(dev, &args));
+		ut_asserteq(HANDLE_LOW(args.g_handle), SANDBOX_MEM_HANDLE);
+		ut_asserteq(HANDLE_HIGH(args.g_handle), SANDBOX_MEM_HANDLE);
+	} else {
+		/* Do not use the TX buffer as a transaction buffer */
+		args.use_txbuf = false;
+		ret = ffa_memory_share(dev, &args);
+		ut_asserteq(-EPROTONOSUPPORT, ret);
+
+		/* No memory region address given */
+		args.use_txbuf = true;
+		args.address = NULL;
+		ret = ffa_memory_share(dev, &args);
+		ut_asserteq(-EINVAL, ret);
+	}
+
+	return 0;
+}
+
 static int dm_test_ffa_ack(struct unit_test_state *uts)
 {
 	struct ffa_priv *uc_priv;
@@ -195,6 +233,9 @@ static int dm_test_ffa_ack(struct unit_test_state *uts)
 	ut_assertok(sandbox_query_ffa_emul_state(FFA_RX_RELEASE, &func_data));
 	check_rxbuf_release_flag(rxbuf_flag, uts);
 
+	/* Test FFA_MEM_SHARE */
+	test_ffa_memory_share(true, uts);
+
 	return 0;
 }
 DM_TEST(dm_test_ffa_ack, UTF_SCAN_FDT | UTF_CONSOLE);
@@ -253,6 +294,9 @@ static int dm_test_ffa_nack(struct unit_test_state *uts)
 	part_id = uc_priv->partitions.descs[0].info.id;
 	ut_assertok(ffa_sync_send_receive(dev, part_id, &msg, 1));
 
+	/* Test FFA_MEM_SHARE */
+	test_ffa_memory_share(false, uts);
+
 	return 0;
 }
 DM_TEST(dm_test_ffa_nack, UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.25.1

