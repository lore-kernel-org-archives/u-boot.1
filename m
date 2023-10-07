Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AA7E95A6B
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CE0A86EBC;
	Sat,  7 Oct 2023 23:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WvxXHkqC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="f5c5DvVj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A19EB8691E; Sat,  7 Oct 2023 23:41:37 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADB086DFC
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S2zJN3fwvz9sW5;
 Sat,  7 Oct 2023 23:41:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZC4HjIsXvblmFY7BN1mhtCHhw0HO/ma0psnYGT6/G2I=;
 b=WvxXHkqCtAGYo1QT1tf5D7x4MD76ryH+1PMOChAF8EraAQP4LQyoOHjIBZK2FeJGCFsWUX
 AXnKU/DnvdJGw8dRQLpGLm30v5QfrrHPGWyXQXX4DnUmHvUOQEzBps0e4JUqzg8hi6NhUc
 7KQMHCjzqfb+Dt2RtrpCtTdN8/pVVPaNKvIyPwOuGNDzgvezpSBI9bNyuXMHFlHz9D9Ruo
 j5rpc63m2XjvVJnjKRrRqFLe5QnW3RVhX3wRRMaL7HZtS8+ujSmAr2eqegoGAJ4AbqyPfo
 NvIv4kUuDb64Q61JrfEGksgqLIGW1lEJAJFpewRja3baUEngLIRHTSLxL3+C1g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZC4HjIsXvblmFY7BN1mhtCHhw0HO/ma0psnYGT6/G2I=;
 b=f5c5DvVjdDTku2mch4XX56OL9zDcihwVt+r8HK8IiPvVmBOWk74b0KtRhJD2g0W2muwP0k
 5gAihqzErjX/sjSufqB79N6MXnRVsZ2DJwgUmnGh5CFEiP3MVfr7Bm4T3bqrVSDqMxhVt9
 y0eM+LERDXdfTeKm2wMfXPXbGjsEmF/kgzL3W7C59EPsu6GbDxRFU+dVK9Zr2myNlFoIPy
 f5aME0oJXzlbgsgnsm6uSF3StbgP7GIfKk4c0ZRKz/MSb+ag80iexLY3OY7MNRYwCHECH8
 pvBdj7r7HG5Rerm/ojK3SlA5bF+HXvby8+G2Fa+RinhZl26MZWKHCIkuPPYGqQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Nikhil M Jain <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 8/9] test: bdinfo: Test bdinfo -m
Date: Sat,  7 Oct 2023 23:41:05 +0200
Message-Id: <20231007214106.15744-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
References: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: r7rwrm6phft4bf98z4a55gjkfwatckjg
X-MBO-RS-ID: 0ffe897bdac9fefe59d
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

The bdinfo -m should print only the board memory layout.
Test the expected output.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: Rename bdinfo_test_mem() to bdinfo_check_mem()
---
 test/cmd/bdinfo.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 2f34d877e5c..c9be182e370 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -130,13 +130,11 @@ static int lmb_test_dump_all(struct unit_test_state *uts, struct lmb *lmb)
 	return 0;
 }
 
-static int bdinfo_test_all(struct unit_test_state *uts)
+static int bdinfo_check_mem(struct unit_test_state *uts)
 {
 	struct bd_info *bd = gd->bd;
 	int i;
 
-	ut_assertok(test_num_l(uts, "boot_params", 0));
-
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; ++i) {
 		if (bd->bi_dram[i].size) {
 			ut_assertok(test_num_l(uts, "DRAM bank", i));
@@ -147,6 +145,15 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 		}
 	}
 
+	return 0;
+}
+
+static int bdinfo_test_all(struct unit_test_state *uts)
+{
+	ut_assertok(test_num_l(uts, "boot_params", 0));
+
+	ut_assertok(bdinfo_check_mem(uts));
+
 	/* CONFIG_SYS_HAS_SRAM testing not supported */
 	ut_assertok(test_num_l(uts, "flashstart", 0));
 	ut_assertok(test_num_l(uts, "flashsize", 0));
@@ -243,6 +250,19 @@ static int bdinfo_test_help(struct unit_test_state *uts)
 
 BDINFO_TEST(bdinfo_test_help, UT_TESTF_CONSOLE_REC);
 
+static int bdinfo_test_memory(struct unit_test_state *uts)
+{
+	/* Test BDINFO memory layout only print */
+	ut_assertok(console_record_reset_enable());
+	ut_assertok(run_commandf("bdinfo -m"));
+	ut_assertok(bdinfo_check_mem(uts));
+	ut_assertok(ut_check_console_end(uts));
+
+	return 0;
+}
+
+BDINFO_TEST(bdinfo_test_memory, UT_TESTF_CONSOLE_REC);
+
 int do_ut_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct unit_test *tests = UNIT_TEST_SUITE_START(bdinfo_test);
-- 
2.40.1

