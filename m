Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD81D10BE3
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 06:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 379FC88EC0;
	Sat, 26 Oct 2024 08:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DsIkVtiD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7506C88EC0; Sat, 26 Oct 2024 08:41:20 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB77788D94
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 08:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.c.hoisthospitality.com (unknown [87.215.50.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 586854271F; 
 Sat, 26 Oct 2024 06:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729924862;
 bh=5QbLloR5Gn24dWyT0xnMX3+icKmrCiWrw0izNpIa+LI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=DsIkVtiDxG3zxGsO6LgFlxq9IYPfz3S0vfVAV3aLzBTSzpbd5QqxwODA33YCm7zlb
 fJi6m6MxPhV+rZjnifxQgNMEDLXJgqLfBWwNmcUFoEtxeD5hzDtZrRq1geK/A6Od0w
 4toAWWjyBr89IzcAlfcjlJ2CphIEk+wjSyI7HV3KYz7p3FBQBrUqDQWNELboS6eug7
 UOn4IlezKFrRDgSvgGLb90R8slwl2eaVvfiXfz/80N614RUdlIIi9cijFmt2GDzrxo
 KNvD588Nheuj2qGWpBg++nB5xP3/tgf5bJEQG8dyyq1lMX7WcQIVA5TeBIwmZ6d/vn
 Gs8lkmrzMwnOw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 5/5] fs: ext4: use fs_ls_generic
Date: Sat, 26 Oct 2024 08:40:48 +0200
Message-ID: <20241026064048.370062-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
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

Now that opendir, readir, closedir are implemented for ext4 we can use
fs_ls_generic() for implementing the ls command.

Adjust the unit tests:

* fs_ls_generic() produces more spaces between file size and name.
* The ext4 specific message "** Can not find directory. **\n" is not
  written anymore.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/ext4/ext4_common.c               | 29 -----------------------------
 fs/ext4/ext4fs.c                    | 23 -----------------------
 fs/fs.c                             |  2 +-
 test/py/tests/test_env.py           |  2 +-
 test/py/tests/test_fs/test_basic.py |  5 +----
 5 files changed, 3 insertions(+), 58 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index c1e38978bb9..cc150cf824f 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -2137,35 +2137,6 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, char *name,
 					*fnode = fdiro;
 					return 1;
 				}
-			} else {
-				if (fdiro->inode_read == 0) {
-					status = ext4fs_read_inode(dir->data,
-								   le32_to_cpu(
-								   dirent.inode),
-								   &fdiro->inode);
-					if (status == 0) {
-						free(fdiro);
-						return 0;
-					}
-					fdiro->inode_read = 1;
-				}
-				switch (type) {
-				case FILETYPE_DIRECTORY:
-					printf("<DIR> ");
-					break;
-				case FILETYPE_SYMLINK:
-					printf("<SYM> ");
-					break;
-				case FILETYPE_REG:
-					printf("      ");
-					break;
-				default:
-					printf("< ? > ");
-					break;
-				}
-				printf("%10u %s\n",
-				       le32_to_cpu(fdiro->inode.size),
-					filename);
 			}
 			free(fdiro);
 		}
diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 32693198aeb..dfecfa0b4e8 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -201,29 +201,6 @@ int ext4fs_read_file(struct ext2fs_node *node, loff_t pos,
 	return 0;
 }
 
-int ext4fs_ls(const char *dirname)
-{
-	struct ext2fs_node *dirnode = NULL;
-	int status;
-
-	if (dirname == NULL)
-		return 0;
-
-	status = ext4fs_find_file(dirname, &ext4fs_root->diropen, &dirnode,
-				  FILETYPE_DIRECTORY);
-	if (status != 1) {
-		printf("** Can not find directory. **\n");
-		if (dirnode)
-			ext4fs_free_node(dirnode, &ext4fs_root->diropen);
-		return 1;
-	}
-
-	ext4fs_iterate_dir(dirnode, NULL, NULL, NULL);
-	ext4fs_free_node(dirnode, &ext4fs_root->diropen);
-
-	return 0;
-}
-
 int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp)
 {
 	struct ext4_dir_stream *dirs;
diff --git a/fs/fs.c b/fs/fs.c
index a515905c4c9..1afa0fbeaed 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -220,7 +220,7 @@ static struct fstype_info fstypes[] = {
 		.null_dev_desc_ok = false,
 		.probe = ext4fs_probe,
 		.close = ext4fs_close,
-		.ls = ext4fs_ls,
+		.ls = fs_ls_generic,
 		.exists = ext4fs_exists,
 		.size = ext4fs_size,
 		.read = ext4_read_file,
diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
index 00bcccd65ff..4471db7d9cb 100644
--- a/test/py/tests/test_env.py
+++ b/test/py/tests/test_env.py
@@ -488,7 +488,7 @@ def test_env_ext4(state_test_env):
         assert 'Loading Environment from EXT4... OK' in response
 
         response = c.run_command('ext4ls host 0:0')
-        assert '8192 uboot.env' in response
+        assert '8192   uboot.env' in response
 
         response = c.run_command('env info')
         assert 'env_valid = valid' in response
diff --git a/test/py/tests/test_fs/test_basic.py b/test/py/tests/test_fs/test_basic.py
index 71f3e86fb18..b5f4704172a 100644
--- a/test/py/tests/test_fs/test_basic.py
+++ b/test/py/tests/test_fs/test_basic.py
@@ -33,10 +33,7 @@ class TestFsBasic(object):
             # In addition, test with a nonexistent directory to see if we crash.
             output = u_boot_console.run_command(
                 '%sls host 0:0 invalid_d' % fs_type)
-            if fs_type == 'ext4':
-                assert('Can not find directory' in output)
-            else:
-                assert('' == output)
+            assert('' == output)
 
     def test_fs2(self, u_boot_console, fs_obj_basic):
         """
-- 
2.45.2

