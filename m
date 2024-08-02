Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC23BC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 09:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 013EB88AD3;
	Fri,  2 Aug 2024 11:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D48288B89; Fri,  2 Aug 2024 11:36:02 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 417FD888A4
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 11:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id D981F64C3B29;
 Fri,  2 Aug 2024 11:35:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Kf6uBaufFbzK; Fri,  2 Aug 2024 11:35:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 167EB64C3B27;
 Fri,  2 Aug 2024 11:35:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id ii4oKZ5OeO2h; Fri,  2 Aug 2024 11:35:59 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id C8CE864A3D18;
 Fri,  2 Aug 2024 11:35:58 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: upstream+uboot@sigma-star.at, francis.laniel@amarulasolutions.com,
 glaroque@baylibre.com, mkorpershoek@baylibre.com, sjg@chromium.org,
 christian.taedcke@weidmueller.com, trini@konsulko.com,
 Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/3] test_fs: Rename mount dir to scratch
Date: Fri,  2 Aug 2024 11:33:21 +0200
Message-Id: <20240802093322.15240-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240802093322.15240-1-richard@nod.at>
References: <20240802093322.15240-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Since no mounting happens anymore, rename the "mnt"
directory to "scratch" and the related variables.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 test/py/tests/test_fs/conftest.py | 66 +++++++++++++++----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/co=
nftest.py
index 59342a6e3d..af2adaf164 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -178,13 +178,13 @@ def fs_obj_basic(request, u_boot_config):
     fs_ubtype =3D fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
=20
-    mount_dir =3D u_boot_config.persistent_data_dir + '/mnt'
+    scratch_dir =3D u_boot_config.persistent_data_dir + '/scratch'
=20
-    small_file =3D mount_dir + '/' + SMALL_FILE
-    big_file =3D mount_dir + '/' + BIG_FILE
+    small_file =3D scratch_dir + '/' + SMALL_FILE
+    big_file =3D scratch_dir + '/' + BIG_FILE
=20
     try:
-        check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
+        check_call('mkdir -p %s' % scratch_dir, shell=3DTrue)
     except CalledProcessError as err:
         pytest.skip('Preparing mount folder failed for filesystem: ' + f=
s_type + '. {}'.format(err))
         call('rm -f %s' % fs_img, shell=3DTrue)
@@ -192,7 +192,7 @@ def fs_obj_basic(request, u_boot_config):
=20
     try:
         # Create a subdirectory.
-        check_call('mkdir %s/SUBDIR' % mount_dir, shell=3DTrue)
+        check_call('mkdir %s/SUBDIR' % scratch_dir, shell=3DTrue)
=20
         # Create big file in this image.
         # Note that we work only on the start 1MB, couple MBs in the 2GB=
 range
@@ -253,7 +253,7 @@ def fs_obj_basic(request, u_boot_config):
=20
         try:
             # 3GiB volume
-            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0xc000000=
0, '3GB', mount_dir)
+            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0xc000000=
0, '3GB', scratch_dir)
         except CalledProcessError as err:
             pytest.skip('Creating failed for filesystem: ' + fs_type + '=
. {}'.format(err))
             return
@@ -264,7 +264,7 @@ def fs_obj_basic(request, u_boot_config):
     else:
         yield [fs_ubtype, fs_img, md5val]
     finally:
-        call('rm -rf %s' % mount_dir, shell=3DTrue)
+        call('rm -rf %s' % scratch_dir, shell=3DTrue)
         call('rm -f %s' % fs_img, shell=3DTrue)
=20
 #
@@ -288,13 +288,13 @@ def fs_obj_ext(request, u_boot_config):
     fs_ubtype =3D fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
=20
-    mount_dir =3D u_boot_config.persistent_data_dir + '/mnt'
+    scratch_dir =3D u_boot_config.persistent_data_dir + '/scratch'
=20
-    min_file =3D mount_dir + '/' + MIN_FILE
-    tmp_file =3D mount_dir + '/tmpfile'
+    min_file =3D scratch_dir + '/' + MIN_FILE
+    tmp_file =3D scratch_dir + '/tmpfile'
=20
     try:
-        check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
+        check_call('mkdir -p %s' % scratch_dir, shell=3DTrue)
     except CalledProcessError as err:
         pytest.skip('Preparing mount folder failed for filesystem: ' + f=
s_type + '. {}'.format(err))
         call('rm -f %s' % fs_img, shell=3DTrue)
@@ -302,7 +302,7 @@ def fs_obj_ext(request, u_boot_config):
=20
     try:
         # Create a test directory
-        check_call('mkdir %s/dir1' % mount_dir, shell=3DTrue)
+        check_call('mkdir %s/dir1' % scratch_dir, shell=3DTrue)
=20
         # Create a small file and calculate md5
         check_call('dd if=3D/dev/urandom of=3D%s bs=3D1K count=3D20'
@@ -343,7 +343,7 @@ def fs_obj_ext(request, u_boot_config):
=20
         try:
             # 128MiB volume
-            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000=
, '128MB', mount_dir)
+            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000=
, '128MB', scratch_dir)
         except CalledProcessError as err:
             pytest.skip('Creating failed for filesystem: ' + fs_type + '=
. {}'.format(err))
             return
@@ -354,7 +354,7 @@ def fs_obj_ext(request, u_boot_config):
     else:
         yield [fs_ubtype, fs_img, md5val]
     finally:
-        call('rm -rf %s' % mount_dir, shell=3DTrue)
+        call('rm -rf %s' % scratch_dir, shell=3DTrue)
         call('rm -f %s' % fs_img, shell=3DTrue)
=20
 #
@@ -409,10 +409,10 @@ def fs_obj_unlink(request, u_boot_config):
     fs_ubtype =3D fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
=20
-    mount_dir =3D u_boot_config.persistent_data_dir + '/mnt'
+    scratch_dir =3D u_boot_config.persistent_data_dir + '/scratch'
=20
     try:
-        check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
+        check_call('mkdir -p %s' % scratch_dir, shell=3DTrue)
     except CalledProcessError as err:
         pytest.skip('Preparing mount folder failed for filesystem: ' + f=
s_type + '. {}'.format(err))
         call('rm -f %s' % fs_img, shell=3DTrue)
@@ -420,29 +420,29 @@ def fs_obj_unlink(request, u_boot_config):
=20
     try:
         # Test Case 1 & 3
-        check_call('mkdir %s/dir1' % mount_dir, shell=3DTrue)
+        check_call('mkdir %s/dir1' % scratch_dir, shell=3DTrue)
         check_call('dd if=3D/dev/urandom of=3D%s/dir1/file1 bs=3D1K coun=
t=3D1'
-                                    % mount_dir, shell=3DTrue)
+                                    % scratch_dir, shell=3DTrue)
         check_call('dd if=3D/dev/urandom of=3D%s/dir1/file2 bs=3D1K coun=
t=3D1'
-                                    % mount_dir, shell=3DTrue)
+                                    % scratch_dir, shell=3DTrue)
=20
         # Test Case 2
-        check_call('mkdir %s/dir2' % mount_dir, shell=3DTrue)
+        check_call('mkdir %s/dir2' % scratch_dir, shell=3DTrue)
         for i in range(0, 20):
             check_call('mkdir %s/dir2/0123456789abcdef%02x'
-                                    % (mount_dir, i), shell=3DTrue)
+                                    % (scratch_dir, i), shell=3DTrue)
=20
         # Test Case 4
-        check_call('mkdir %s/dir4' % mount_dir, shell=3DTrue)
+        check_call('mkdir %s/dir4' % scratch_dir, shell=3DTrue)
=20
         # Test Case 5, 6 & 7
-        check_call('mkdir %s/dir5' % mount_dir, shell=3DTrue)
+        check_call('mkdir %s/dir5' % scratch_dir, shell=3DTrue)
         check_call('dd if=3D/dev/urandom of=3D%s/dir5/file1 bs=3D1K coun=
t=3D1'
-                                    % mount_dir, shell=3DTrue)
+                                    % scratch_dir, shell=3DTrue)
=20
         try:
             # 128MiB volume
-            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000=
, '128MB', mount_dir)
+            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000=
, '128MB', scratch_dir)
         except CalledProcessError as err:
             pytest.skip('Creating failed for filesystem: ' + fs_type + '=
. {}'.format(err))
             return
@@ -453,7 +453,7 @@ def fs_obj_unlink(request, u_boot_config):
     else:
         yield [fs_ubtype, fs_img]
     finally:
-        call('rm -rf %s' % mount_dir, shell=3DTrue)
+        call('rm -rf %s' % scratch_dir, shell=3DTrue)
         call('rm -f %s' % fs_img, shell=3DTrue)
=20
 #
@@ -477,13 +477,13 @@ def fs_obj_symlink(request, u_boot_config):
     fs_ubtype =3D fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
=20
-    mount_dir =3D u_boot_config.persistent_data_dir + '/mnt'
+    scratch_dir =3D u_boot_config.persistent_data_dir + '/scratch'
=20
-    small_file =3D mount_dir + '/' + SMALL_FILE
-    medium_file =3D mount_dir + '/' + MEDIUM_FILE
+    small_file =3D scratch_dir + '/' + SMALL_FILE
+    medium_file =3D scratch_dir + '/' + MEDIUM_FILE
=20
     try:
-        check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
+        check_call('mkdir -p %s' % scratch_dir, shell=3DTrue)
     except CalledProcessError as err:
         pytest.skip('Preparing mount folder failed for filesystem: ' + f=
s_type + '. {}'.format(err))
         call('rm -f %s' % fs_img, shell=3DTrue)
@@ -491,7 +491,7 @@ def fs_obj_symlink(request, u_boot_config):
=20
     try:
         # Create a subdirectory.
-        check_call('mkdir %s/SUBDIR' % mount_dir, shell=3DTrue)
+        check_call('mkdir %s/SUBDIR' % scratch_dir, shell=3DTrue)
=20
         # Create a small file in this image.
         check_call('dd if=3D/dev/urandom of=3D%s bs=3D1M count=3D1'
@@ -513,7 +513,7 @@ def fs_obj_symlink(request, u_boot_config):
=20
         try:
             # 1GiB volume
-            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x4000000=
0, '1GB', mount_dir)
+            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x4000000=
0, '1GB', scratch_dir)
         except CalledProcessError as err:
             pytest.skip('Creating failed for filesystem: ' + fs_type + '=
. {}'.format(err))
             return
@@ -524,7 +524,7 @@ def fs_obj_symlink(request, u_boot_config):
     else:
         yield [fs_ubtype, fs_img, md5val]
     finally:
-        call('rm -rf %s' % mount_dir, shell=3DTrue)
+        call('rm -rf %s' % scratch_dir, shell=3DTrue)
         call('rm -f %s' % fs_img, shell=3DTrue)
=20
 #
--=20
2.35.3

