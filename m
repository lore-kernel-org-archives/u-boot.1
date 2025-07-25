Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A2CC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 15:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F255839DF;
	Fri, 25 Jul 2025 17:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0658C83A15; Fri, 25 Jul 2025 17:50:40 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id ECDC483015
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 17:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81DAB176C;
 Fri, 25 Jul 2025 08:50:30 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.31.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30BA53F66E;
 Fri, 25 Jul 2025 08:50:36 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v4 08/24] arm_ffa: sandbox: Add FFA_MEM_RECLAIM tests
Date: Fri, 25 Jul 2025 16:49:54 +0100
Message-Id: <20250725155010.285831-9-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
References: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
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
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/dm/ffa.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/test/dm/ffa.c b/test/dm/ffa.c
index 59eea9a57cc..f4a6716cfd8 100644
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

