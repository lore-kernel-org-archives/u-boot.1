Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A384E6F060
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 14:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B89889324;
	Fri,  1 Nov 2024 15:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99FB788F3D; Fri,  1 Nov 2024 15:20:43 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 84E68892FF
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 15:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C48591BC0;
 Fri,  1 Nov 2024 07:21:10 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.26.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 683C63F528;
 Fri,  1 Nov 2024 07:20:40 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Subject: [PATCH 8/8] arm_ffa: sandbox: Add FFA_MEM_RECLAIM tests
Date: Fri,  1 Nov 2024 14:20:17 +0000
Message-Id: <20241101142017.79311-9-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
References: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
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

Add FFA_MEM_RECLAIM positive and negative test cases

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
---
 test/dm/ffa.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/test/dm/ffa.c b/test/dm/ffa.c
index 4fd21ac3d72..c481964c758 100644
--- a/test/dm/ffa.c
+++ b/test/dm/ffa.c
@@ -179,6 +179,27 @@ static int  test_ffa_memory_share(bool test_ack, struct unit_test_state *uts)
 	return 0;
 }
 
+static int  test_ffa_memory_reclaim(bool test_ack, struct unit_test_state *uts)
+{
+	int ret;
+	u64 g_handle;
+	struct udevice *dev;
+
+	ut_assertok(uclass_first_device_err(UCLASS_FFA, &dev));
+
+	if (test_ack) {
+		g_handle = PACK_HANDLE(SANDBOX_MEM_HANDLE, SANDBOX_MEM_HANDLE);
+		ut_assertok(ffa_memory_reclaim(dev, g_handle, 0));
+	} else {
+		/* Provide a wrong handle */
+		g_handle = PACK_HANDLE(SANDBOX_MEM_HANDLE, 0);
+		ret = ffa_memory_reclaim(dev, g_handle, 0);
+		ut_asserteq(-EINVAL, ret);
+	}
+
+	return 0;
+}
+
 static int dm_test_ffa_ack(struct unit_test_state *uts)
 {
 	struct ffa_priv *uc_priv;
@@ -236,6 +257,9 @@ static int dm_test_ffa_ack(struct unit_test_state *uts)
 	/* Test FFA_MEM_SHARE */
 	test_ffa_memory_share(true, uts);
 
+	/* Test FFA_MEM_RECLAIM */
+	test_ffa_memory_reclaim(true, uts);
+
 	return 0;
 }
 DM_TEST(dm_test_ffa_ack, UTF_SCAN_FDT | UTF_CONSOLE);
@@ -297,6 +321,9 @@ static int dm_test_ffa_nack(struct unit_test_state *uts)
 	/* Test FFA_MEM_SHARE */
 	test_ffa_memory_share(false, uts);
 
+	/* Test FFA_MEM_RECLAIM */
+	test_ffa_memory_reclaim(false, uts);
+
 	return 0;
 }
 DM_TEST(dm_test_ffa_nack, UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.25.1

