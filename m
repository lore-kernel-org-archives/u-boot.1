Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D38AE7D268
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2EEA86A7D;
	Tue, 26 Sep 2023 10:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2479486BEE; Tue, 26 Sep 2023 10:53:02 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D7E86A14
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp84t1695718213tsye2z9k
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:50:12 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: znfcQSa1hKYrRv1WEvIuY+Awpu3ZDmXW3aYw9JOWlY0+y3zkBQFvF2rat2pz1
 EeIftswDvo7VeHkHYNfD47jHPgshsoWDmPL53sTowQra/AXvg29YxDKQLwduSzUGxaBoSgD
 dTPP2CMmkvYSQpipR7EQGG0nWThZX8wxPskuNvfmkdUjHJMBPd+/TAYin/XjZq+IanVx51l
 3ChzRkLlW+bzXIci58zQ9Vkb78VImJpDEhD6NmgKDIZz45KzIn4vAfbSSNNDBAha9Oqn7Qf
 p+5zT0zsi725GLR6zdsTyphOGdOhwkv2EdcH/5/wD0Gi05DGB//D4BGO52V4ZEigZakiocb
 yCTdtiuWjPD9r00/eO2uq3z1tUGNsCwP9CGCtAQ
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8983815718078180391
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: [PATCH 06/15] cmd: host: Print out the block size of the host device
Date: Tue, 26 Sep 2023 16:43:36 +0800
Message-Id: <20230926084346.2237483-7-bmeng@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926084346.2237483-1-bmeng@tinylab.org>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

It's useful if we can print out the block size of the host device
in the "host info" command.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 cmd/host.c     |  7 ++++---
 test/dm/host.c | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/cmd/host.c b/cmd/host.c
index 2334ccd9bc..c33c2a9787 100644
--- a/cmd/host.c
+++ b/cmd/host.c
@@ -160,8 +160,8 @@ static void show_host_dev(struct udevice *dev)
 		return;
 
 	desc = dev_get_uclass_plat(blk);
-	printf("%12lu %-15s %s\n", (unsigned long)desc->lba, plat->label,
-	       plat->filename);
+	printf("%12lu %6lu %-15s %s\n", (unsigned long)desc->lba, desc->blksz,
+	       plat->label, plat->filename);
 }
 
 static int do_host_info(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -179,7 +179,8 @@ static int do_host_info(struct cmd_tbl *cmdtp, int flag, int argc,
 			return CMD_RET_FAILURE;
 	}
 
-	printf("%3s %12s %-15s %s\n", "dev", "blocks", "label", "path");
+	printf("%3s %12s %6s %-15s %s\n",
+	       "dev", "blocks", "blksz", "label", "path");
 	if (dev) {
 		show_host_dev(dev);
 	} else {
diff --git a/test/dm/host.c b/test/dm/host.c
index 19f6c67462..580b14cf79 100644
--- a/test/dm/host.c
+++ b/test/dm/host.c
@@ -114,7 +114,7 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 
 	/* first check 'host info' with binding */
 	ut_assertok(run_command("host info", 0));
-	ut_assert_nextline("dev       blocks label           path");
+	ut_assert_nextline("dev       blocks  blksz label           path");
 	ut_assert_console_end();
 
 	ut_assertok(run_commandf("host bind -r test2 %s", filename));
@@ -126,8 +126,8 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 	ut_asserteq(true, desc->removable);
 
 	ut_assertok(run_command("host info", 0));
-	ut_assert_nextline("dev       blocks label           path");
-	ut_assert_nextline("  0         4096 test2           2MB.ext2.img");
+	ut_assert_nextline("dev       blocks  blksz label           path");
+	ut_assert_nextline("  0         4096    512 test2           2MB.ext2.img");
 	ut_assert_console_end();
 
 	ut_assertok(run_commandf("host bind fat %s", filename2));
@@ -139,9 +139,9 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 	ut_asserteq(false, desc->removable);
 
 	ut_assertok(run_command("host info", 0));
-	ut_assert_nextline("dev       blocks label           path");
-	ut_assert_nextline("  0         4096 test2           2MB.ext2.img");
-	ut_assert_nextline("  1         2048 fat             1MB.fat32.img");
+	ut_assert_nextline("dev       blocks  blksz label           path");
+	ut_assert_nextline("  0         4096    512 test2           2MB.ext2.img");
+	ut_assert_nextline("  1         2048    512 fat             1MB.fat32.img");
 	ut_assert_console_end();
 
 	ut_asserteq(1, run_command("host info test", 0));
@@ -149,8 +149,8 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	ut_assertok(run_command("host info fat", 0));
-	ut_assert_nextline("dev       blocks label           path");
-	ut_assert_nextline("  1         2048 fat             1MB.fat32.img");
+	ut_assert_nextline("dev       blocks  blksz label           path");
+	ut_assert_nextline("  1         2048    512 fat             1MB.fat32.img");
 	ut_assert_console_end();
 
 	/* check 'host dev' */
@@ -186,8 +186,8 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	ut_assertok(run_command("host info", 0));
-	ut_assert_nextline("dev       blocks label           path");
-	ut_assert_nextline("  1         2048 fat             1MB.fat32.img");
+	ut_assert_nextline("dev       blocks  blksz label           path");
+	ut_assert_nextline("  1         2048    512 fat             1MB.fat32.img");
 	ut_assert_console_end();
 
 	return 0;
-- 
2.25.1

