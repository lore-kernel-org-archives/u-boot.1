Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA1ACD4933
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 22:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0874786C73;
	Thu, 21 Sep 2023 00:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Lq5IkQr3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KvFc+YaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A8C286C83; Thu, 21 Sep 2023 00:58:45 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56EE186C55
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 00:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RrYqR220Bz9sl0;
 Thu, 21 Sep 2023 00:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxwqJnlILnBra2OEyGyp3G4dFugWJJUU4zVgdc0K6PA=;
 b=Lq5IkQr3AvBfczahuWAzL/GJ1TVdGeeehzdhrvo5GKImSdLzShcti43Upv/vmC5sVZ+Vds
 Dh9YQIQtiUk9d3rmfLa9E+fSfyv+yOHiywgGlNnNRJIntgf8w4/WwVshXYlQQ3PLa1fvmu
 SCVWy3E9x28YyIhL9NtHiPSl4OE2kEIG8509mL85r+bMi2XEy86klqKLCNitR3Fn8ZgY+h
 H/xL/B4kCLrl3gbZqcIX9rbre7IY1WA26gS35fvSMNWOJb5UxYBGts8VSv0WOOrh6QZ7BD
 cH2K68bCZQBfQFqCpR0sQsZumjHv8hzl9UIzIC/DVHqDslEqffACHRi/e+4fTg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxwqJnlILnBra2OEyGyp3G4dFugWJJUU4zVgdc0K6PA=;
 b=KvFc+YaVvuMn+/fp3escfL0OvV9cs3M84kO/de2u4/PUijmsdZWmtxss3RvNvAluxHfgli
 Dk9jp0BBvTHDLw1sUMhSPmmF+8DROVmPlCNTBWeAuTJepw2zIYWsFg7+2/cHvV/LYjxk75
 E/xBoJN/zOvYtCpeqxvL54MO5j0iNqQnXoIAZV7d0JVAB3LMBFJUgEMsILS8DV49/cvn72
 PWt73otzgDASPamGBCHaGMZPn3lkQnL7qCxwvjmGRiDiFIjWfQIwRCC32jsrnIhHMF8f6E
 pNxa9TF8k/cp8bKu/fHAx977/zNvX0mKKTldqX5164hWsgCXsQUpqfJpKiLQkA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Nikhil M Jain <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 8/9] test: bdinfo: Test bdinfo -m
Date: Thu, 21 Sep 2023 00:58:10 +0200
Message-Id: <20230920225811.153474-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 60904d9055e75d48377
X-MBO-RS-META: mu5a6e4r7ugahk6n6qwrppij9brht1za
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
 test/cmd/bdinfo.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 2f34d877e5c..f090667fb42 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -130,13 +130,11 @@ static int lmb_test_dump_all(struct unit_test_state *uts, struct lmb *lmb)
 	return 0;
 }
 
-static int bdinfo_test_all(struct unit_test_state *uts)
+static int bdinfo_test_mem(struct unit_test_state *uts)
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
+	ut_assertok(bdinfo_test_mem(uts));
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
+	ut_assertok(bdinfo_test_mem(uts));
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

