Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A46CC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39AB086A1B;
	Thu, 24 Aug 2023 21:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eKeAT/m3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC1978683C; Thu, 24 Aug 2023 21:56:16 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F873869B7
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-790cadee81bso7144839f.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906971; x=1693511771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mizC2OAPJO6fTArZqUI/mK2iLWUK4BSF0kUWDprVAXM=;
 b=eKeAT/m37pcogN27hQRYWWjgIorNfhfiuv9WJdznwbP9UP++1BTse9wa/33mxz3x6W
 hRIBq/oNOFaCWSpkPyZxaxGHp1oRw3K+A6FRYU2S3vUogpqXeAGxvuX14YnE4Kax+R22
 /NUoI6F1YGW2JQI1Y4GG8p54gVYfaya4CCug4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906971; x=1693511771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mizC2OAPJO6fTArZqUI/mK2iLWUK4BSF0kUWDprVAXM=;
 b=eS0X3ZvNJbRVo5T2SamKlDe8mZvWWUKo4Otyx1ANolhY0ARf478RyUvTBVZx3pj/eg
 V01Rv7C723vqkPeH+OzWZdqyKcV/xi5CCV51QAZynSFW1IilPJDKkDVAjCx3W2Xtr1Ox
 ysOWki+yNj7CPXEPJHaBqKLlQgMvUgl7R9Zrdf9Se/rSGIgfRHW2O22AdMEAia4ZOMST
 nbD+9H7hu74QMR6ayCroxwxtRktOVhjzGjVYJhTGmSEg2zYVfXOT/Wrio7qkW8rzYvhJ
 1rjDdW0AfvFwFrX9Vp+VvY1L1eFIWbTL+DOjCmzCyc6uXOkFsfvE1ZPZ2nYOh8Y+ad0B
 LpAA==
X-Gm-Message-State: AOJu0Yzbm6nZqtNHzWt7h9A6sgzPh2pJXrt6yjL4jvkeRIN0MFlZSi3R
 tVa2j3izIJ/gpioPChaDAb7yX7Ogv9VQqJS5IEA=
X-Google-Smtp-Source: AGHT+IFQIb6SiywqCk4xI0+1Tb0Y6Okox2DHX+6cLQrJHxHB+xqTizGP1VXa0YOq65bDXWD0srSPWQ==
X-Received: by 2002:a05:6602:276d:b0:790:9460:6304 with SMTP id
 l13-20020a056602276d00b0079094606304mr7036728ioe.5.1692906971690; 
 Thu, 24 Aug 2023 12:56:11 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 15/23] test: Move 1MB.fat32.img and 2MB.ext2.img
Date: Thu, 24 Aug 2023 13:55:38 -0600
Message-ID: <20230824195553.1685996-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

These are currently created in the source directory, which is not ideal.
Move them to the persistent-data directory instead. Update the test so
skip validating the filename, since it now includes a full path.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/dm/host.c             | 44 ++++++++++++++++++++++----------------
 test/py/tests/fs_helper.py |  6 ++----
 test/py/tests/test_ut.py   |  6 ++----
 3 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/test/dm/host.c b/test/dm/host.c
index 355ba7770afa..85f21f9839e2 100644
--- a/test/dm/host.c
+++ b/test/dm/host.c
@@ -8,6 +8,7 @@
 #include <blk.h>
 #include <dm.h>
 #include <fs.h>
+#include <os.h>
 #include <sandbox_host.h>
 #include <asm/test.h>
 #include <dm/device-internal.h>
@@ -15,9 +16,6 @@
 #include <test/test.h>
 #include <test/ut.h>
 
-static const char filename[] = "2MB.ext2.img";
-static const char filename2[] = "1MB.fat32.img";
-
 /* Basic test of host interface */
 static int dm_test_host(struct unit_test_state *uts)
 {
@@ -25,6 +23,7 @@ static int dm_test_host(struct unit_test_state *uts)
 	struct udevice *dev, *part, *chk, *blk;
 	struct host_sb_plat *plat;
 	struct blk_desc *desc;
+	char fname[256];
 	ulong mem_start;
 	loff_t actwrite;
 
@@ -40,13 +39,15 @@ static int dm_test_host(struct unit_test_state *uts)
 	ut_assert(label != plat->label);
 	ut_asserteq(0, plat->fd);
 
-	/* Attach a file created in test_host.py */
-	ut_assertok(host_attach_file(dev, filename));
+	/* Attach a file created in test_ut_dm_init */
+	ut_assertok(os_persistent_file(fname, sizeof(fname), "2MB.ext2.img"));
+
+	ut_assertok(host_attach_file(dev, fname));
 	ut_assertok(uclass_first_device_err(UCLASS_HOST, &chk));
 	ut_asserteq_ptr(chk, dev);
 
-	ut_asserteq_str(filename, plat->filename);
-	ut_assert(filename != plat->filename);
+	ut_asserteq_str(fname, plat->filename);
+	ut_assert(fname != plat->filename);
 	ut_assert(plat->fd != 0);
 
 	/* Get the block device */
@@ -79,12 +80,14 @@ static int dm_test_host_dup(struct unit_test_state *uts)
 {
 	static char label[] = "test";
 	struct udevice *dev, *chk;
+	char fname[256];
 
 	ut_asserteq(0, uclass_id_count(UCLASS_HOST));
 	ut_assertok(host_create_device(label, true, &dev));
 
-	/* Attach a file created in test_host.py */
-	ut_assertok(host_attach_file(dev, filename));
+	/* Attach a file created in test_ut_dm_init */
+	ut_assertok(os_persistent_file(fname, sizeof(fname), "2MB.ext2.img"));
+	ut_assertok(host_attach_file(dev, fname));
 	ut_assertok(uclass_first_device_err(UCLASS_HOST, &chk));
 	ut_asserteq_ptr(chk, dev);
 	ut_asserteq(1, uclass_id_count(UCLASS_HOST));
@@ -92,8 +95,10 @@ static int dm_test_host_dup(struct unit_test_state *uts)
 	/* Create another device with the same label (should remove old one) */
 	ut_assertok(host_create_device(label, true, &dev));
 
-	/* Attach a different file created in test_host.py */
-	ut_assertok(host_attach_file(dev, filename2));
+	/* Attach a different file created in test_ut_dm_init */
+	ut_assertok(os_persistent_file(fname, sizeof(fname), "1MB.fat32.img"));
+	ut_assertok(host_attach_file(dev, fname));
+
 	ut_assertok(uclass_first_device_err(UCLASS_HOST, &chk));
 	ut_asserteq_ptr(chk, dev);
 
@@ -109,6 +114,7 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 {
 	struct udevice *dev, *blk;
 	struct blk_desc *desc;
+	char fname[256];
 
 	console_record_reset();
 
@@ -117,7 +123,8 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 	ut_assert_nextline("dev       blocks label           path");
 	ut_assert_console_end();
 
-	ut_assertok(run_commandf("host bind -r test2 %s", filename));
+	ut_assertok(os_persistent_file(fname, sizeof(fname), "2MB.ext2.img"));
+	ut_assertok(run_commandf("host bind -r test2 %s", fname));
 
 	/* Check the -r flag worked */
 	ut_assertok(uclass_first_device_err(UCLASS_HOST, &dev));
@@ -127,10 +134,11 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 
 	ut_assertok(run_command("host info", 0));
 	ut_assert_nextline("dev       blocks label           path");
-	ut_assert_nextline("  0         4096 test2           2MB.ext2.img");
+	ut_assert_nextlinen("  0         4096 test2");
 	ut_assert_console_end();
 
-	ut_assertok(run_commandf("host bind fat %s", filename2));
+	ut_assertok(os_persistent_file(fname, sizeof(fname), "1MB.fat32.img"));
+	ut_assertok(run_commandf("host bind fat %s", fname));
 
 	/* Check it is not removable (no '-r') */
 	ut_assertok(uclass_next_device_err(&dev));
@@ -140,8 +148,8 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 
 	ut_assertok(run_command("host info", 0));
 	ut_assert_nextline("dev       blocks label           path");
-	ut_assert_nextline("  0         4096 test2           2MB.ext2.img");
-	ut_assert_nextline("  1         2048 fat             1MB.fat32.img");
+	ut_assert_nextlinen("  0         4096 test2");
+	ut_assert_nextlinen("  1         2048 fat");
 	ut_assert_console_end();
 
 	ut_asserteq(1, run_command("host info test", 0));
@@ -150,7 +158,7 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 
 	ut_assertok(run_command("host info fat", 0));
 	ut_assert_nextline("dev       blocks label           path");
-	ut_assert_nextline("  1         2048 fat             1MB.fat32.img");
+	ut_assert_nextlinen("  1         2048 fat");
 	ut_assert_console_end();
 
 	/* check 'host dev' */
@@ -187,7 +195,7 @@ static int dm_test_cmd_host(struct unit_test_state *uts)
 
 	ut_assertok(run_command("host info", 0));
 	ut_assert_nextline("dev       blocks label           path");
-	ut_assert_nextline("  1         2048 fat             1MB.fat32.img");
+	ut_assert_nextlinen("  1         2048 fat");
 	ut_assert_console_end();
 
 	return 0;
diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 17151bcd08ec..9882ddb1daa5 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -9,7 +9,7 @@ import re
 import os
 from subprocess import call, check_call, check_output, CalledProcessError
 
-def mk_fs(config, fs_type, size, prefix, use_src_dir=False):
+def mk_fs(config, fs_type, size, prefix):
     """Create a file system volume
 
     Args:
@@ -17,14 +17,12 @@ def mk_fs(config, fs_type, size, prefix, use_src_dir=False):
         fs_type (str): File system type, e.g. 'ext4'
         size (int): Size of file system in bytes
         prefix (str): Prefix string of volume's file name
-        use_src_dir (bool): true to put the file in the source directory
 
     Raises:
         CalledProcessError: if any error occurs when creating the filesystem
     """
     fs_img = f'{prefix}.{fs_type}.img'
-    fs_img = os.path.join(config.source_dir if use_src_dir
-                          else config.persistent_data_dir, fs_img)
+    fs_img = os.path.join(config.persistent_data_dir, fs_img)
 
     if fs_type == 'fat16':
         mkfs_opt = '-F 16'
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index aa1d477cd565..3cc41c2ffb13 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -317,10 +317,8 @@ def test_ut_dm_init(u_boot_console):
         u_boot_utils.run_and_log(
             u_boot_console, f'sfdisk {fn}', stdin=b'type=83')
 
-    fs_helper.mk_fs(u_boot_console.config, 'ext2', 0x200000, '2MB',
-                    use_src_dir=True)
-    fs_helper.mk_fs(u_boot_console.config, 'fat32', 0x100000, '1MB',
-                    use_src_dir=True)
+    fs_helper.mk_fs(u_boot_console.config, 'ext2', 0x200000, '2MB')
+    fs_helper.mk_fs(u_boot_console.config, 'fat32', 0x100000, '1MB')
 
 @pytest.mark.buildconfigspec('cmd_bootflow')
 def test_ut_dm_init_bootstd(u_boot_console):
-- 
2.42.0.rc1.204.g551eb34607-goog

