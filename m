Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AD1E64025
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 22:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4160D896EE;
	Thu, 21 Nov 2024 23:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cJzAzOkY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B23489774; Thu, 21 Nov 2024 23:32:32 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BE428975B
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6eeb741c26eso15944537b3.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732228347; x=1732833147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGorsHFlrnP+Z58AdPDX2l7tA6/slTIqaZo9xtiVyi8=;
 b=cJzAzOkYulB+KgD91Ub3fGw86fXk2XzJT+dr9oHdHxx3ZjcJkDpNEnMnu27qNtdRQD
 TTh2r03/keAAIXUsS0mpljxHx1q7xPS3x1VSUO4rEDUABo6QTwgxhjNJwcwVXaYYIUGx
 HlEymhnSLuyOy6CHt4USpE56BiEf/O1FMMNns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732228347; x=1732833147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vGorsHFlrnP+Z58AdPDX2l7tA6/slTIqaZo9xtiVyi8=;
 b=Q4pF+mJ+wq9ZLrEE6HIzh477mRsNvne6K28lobZzvGMcp69ksAKgDJJIf8jxplXN7R
 kgLDIBT/ktqj/hkPKCYcOguV+PpzFdriWyeULTdjWeTNlFqGzIDEqs6kn0jg4IFFyqyY
 ix4b3DzpYsElRw5H/wsDB67Njf8HK4E2kVEnHYqeJdZZUsHxIP5XVVwDSBQytmPSwLha
 CSz+sLZseDEVkB7oRstmB7F0Q/zrZYGy9NH5+C784EItoLpHKXgssbA6BKeqdTElclSQ
 IBIKh6ZokzNaaYF0j869VcCgMOaC51JV3TGqiGO5JhJuTr7pTKrY28dIBLM8UFN9peK7
 SpfA==
X-Gm-Message-State: AOJu0Yxxk0EDj6RMr1xJwVTAe/yP517W56T3ylr2C1nEVo6Hm5mXiEo9
 Qt2vWKYoE3ZIY0tx0R6wL8ua8wTfCieMCO8NW0aSP3QmEhuSoviqm1aniiwyL7YzV7ZWkiMoqyI
 =
X-Gm-Gg: ASbGncvLj1+y6w9AtD//jmTHyTFcsDMS04yuOUPtBF9UJSjlrnLzQL8CqBHUYJQw9p/
 cuhsOFoY3zoKqTdLxm2dwtKAFcuGJQg7MgU2R8N55qkoZHpY5N35hFjlagAebkow7eJeMiNLrHY
 UGjOuWxAeJmaGP6NfRgWM0TLTcLhuX+sKYeN5XpI4M6hCTUFpVVP0EVlgmN23qB1SWHyfc+GCn8
 gCKuVkG/Q54ZC1/Gx0KnOTHUt+YgsXA/bQZ2IP1Zmv+2f0=
X-Google-Smtp-Source: AGHT+IE2UX+QKovfKWlCVuvbEjZlQEQw0gSORdFm2NpBX3pPifvx7dynrmhsgr2ZTHHgXMTreR4aIw==
X-Received: by 2002:a05:690c:6a0a:b0:6e9:ea86:9667 with SMTP id
 00721157ae682-6eee0886615mr14084197b3.9.1732228347471; 
 Thu, 21 Nov 2024 14:32:27 -0800 (PST)
Received: from chromium.org ([12.181.243.100])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6eedfe2a46esm1687507b3.38.2024.11.21.14.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 14:32:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>
Subject: [PATCH v2 2/8] test_fs: Rename mount dir to scratch
Date: Thu, 21 Nov 2024 15:32:08 -0700
Message-ID: <20241121223217.330117-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241121223217.330117-1-sjg@chromium.org>
References: <20241121223217.330117-1-sjg@chromium.org>
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

From: Richard Weinberger <richard@nod.at>

Since no mounting happens anymore, rename the "mnt"
directory to "scratch" and the related variables.

Signed-off-by: Richard Weinberger <richard@nod.at>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_fs/conftest.py | 66 +++++++++++++++----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index 59342a6e3dd..af2adaf1645 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -178,13 +178,13 @@ def fs_obj_basic(request, u_boot_config):
     fs_ubtype = fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
 
-    mount_dir = u_boot_config.persistent_data_dir + '/mnt'
+    scratch_dir = u_boot_config.persistent_data_dir + '/scratch'
 
-    small_file = mount_dir + '/' + SMALL_FILE
-    big_file = mount_dir + '/' + BIG_FILE
+    small_file = scratch_dir + '/' + SMALL_FILE
+    big_file = scratch_dir + '/' + BIG_FILE
 
     try:
-        check_call('mkdir -p %s' % mount_dir, shell=True)
+        check_call('mkdir -p %s' % scratch_dir, shell=True)
     except CalledProcessError as err:
         pytest.skip('Preparing mount folder failed for filesystem: ' + fs_type + '. {}'.format(err))
         call('rm -f %s' % fs_img, shell=True)
@@ -192,7 +192,7 @@ def fs_obj_basic(request, u_boot_config):
 
     try:
         # Create a subdirectory.
-        check_call('mkdir %s/SUBDIR' % mount_dir, shell=True)
+        check_call('mkdir %s/SUBDIR' % scratch_dir, shell=True)
 
         # Create big file in this image.
         # Note that we work only on the start 1MB, couple MBs in the 2GB range
@@ -253,7 +253,7 @@ def fs_obj_basic(request, u_boot_config):
 
         try:
             # 3GiB volume
-            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0xc0000000, '3GB', mount_dir)
+            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0xc0000000, '3GB', scratch_dir)
         except CalledProcessError as err:
             pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
             return
@@ -264,7 +264,7 @@ def fs_obj_basic(request, u_boot_config):
     else:
         yield [fs_ubtype, fs_img, md5val]
     finally:
-        call('rm -rf %s' % mount_dir, shell=True)
+        call('rm -rf %s' % scratch_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
 
 #
@@ -288,13 +288,13 @@ def fs_obj_ext(request, u_boot_config):
     fs_ubtype = fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
 
-    mount_dir = u_boot_config.persistent_data_dir + '/mnt'
+    scratch_dir = u_boot_config.persistent_data_dir + '/scratch'
 
-    min_file = mount_dir + '/' + MIN_FILE
-    tmp_file = mount_dir + '/tmpfile'
+    min_file = scratch_dir + '/' + MIN_FILE
+    tmp_file = scratch_dir + '/tmpfile'
 
     try:
-        check_call('mkdir -p %s' % mount_dir, shell=True)
+        check_call('mkdir -p %s' % scratch_dir, shell=True)
     except CalledProcessError as err:
         pytest.skip('Preparing mount folder failed for filesystem: ' + fs_type + '. {}'.format(err))
         call('rm -f %s' % fs_img, shell=True)
@@ -302,7 +302,7 @@ def fs_obj_ext(request, u_boot_config):
 
     try:
         # Create a test directory
-        check_call('mkdir %s/dir1' % mount_dir, shell=True)
+        check_call('mkdir %s/dir1' % scratch_dir, shell=True)
 
         # Create a small file and calculate md5
         check_call('dd if=/dev/urandom of=%s bs=1K count=20'
@@ -343,7 +343,7 @@ def fs_obj_ext(request, u_boot_config):
 
         try:
             # 128MiB volume
-            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB', mount_dir)
+            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB', scratch_dir)
         except CalledProcessError as err:
             pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
             return
@@ -354,7 +354,7 @@ def fs_obj_ext(request, u_boot_config):
     else:
         yield [fs_ubtype, fs_img, md5val]
     finally:
-        call('rm -rf %s' % mount_dir, shell=True)
+        call('rm -rf %s' % scratch_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
 
 #
@@ -409,10 +409,10 @@ def fs_obj_unlink(request, u_boot_config):
     fs_ubtype = fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
 
-    mount_dir = u_boot_config.persistent_data_dir + '/mnt'
+    scratch_dir = u_boot_config.persistent_data_dir + '/scratch'
 
     try:
-        check_call('mkdir -p %s' % mount_dir, shell=True)
+        check_call('mkdir -p %s' % scratch_dir, shell=True)
     except CalledProcessError as err:
         pytest.skip('Preparing mount folder failed for filesystem: ' + fs_type + '. {}'.format(err))
         call('rm -f %s' % fs_img, shell=True)
@@ -420,29 +420,29 @@ def fs_obj_unlink(request, u_boot_config):
 
     try:
         # Test Case 1 & 3
-        check_call('mkdir %s/dir1' % mount_dir, shell=True)
+        check_call('mkdir %s/dir1' % scratch_dir, shell=True)
         check_call('dd if=/dev/urandom of=%s/dir1/file1 bs=1K count=1'
-                                    % mount_dir, shell=True)
+                                    % scratch_dir, shell=True)
         check_call('dd if=/dev/urandom of=%s/dir1/file2 bs=1K count=1'
-                                    % mount_dir, shell=True)
+                                    % scratch_dir, shell=True)
 
         # Test Case 2
-        check_call('mkdir %s/dir2' % mount_dir, shell=True)
+        check_call('mkdir %s/dir2' % scratch_dir, shell=True)
         for i in range(0, 20):
             check_call('mkdir %s/dir2/0123456789abcdef%02x'
-                                    % (mount_dir, i), shell=True)
+                                    % (scratch_dir, i), shell=True)
 
         # Test Case 4
-        check_call('mkdir %s/dir4' % mount_dir, shell=True)
+        check_call('mkdir %s/dir4' % scratch_dir, shell=True)
 
         # Test Case 5, 6 & 7
-        check_call('mkdir %s/dir5' % mount_dir, shell=True)
+        check_call('mkdir %s/dir5' % scratch_dir, shell=True)
         check_call('dd if=/dev/urandom of=%s/dir5/file1 bs=1K count=1'
-                                    % mount_dir, shell=True)
+                                    % scratch_dir, shell=True)
 
         try:
             # 128MiB volume
-            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB', mount_dir)
+            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB', scratch_dir)
         except CalledProcessError as err:
             pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
             return
@@ -453,7 +453,7 @@ def fs_obj_unlink(request, u_boot_config):
     else:
         yield [fs_ubtype, fs_img]
     finally:
-        call('rm -rf %s' % mount_dir, shell=True)
+        call('rm -rf %s' % scratch_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
 
 #
@@ -477,13 +477,13 @@ def fs_obj_symlink(request, u_boot_config):
     fs_ubtype = fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
 
-    mount_dir = u_boot_config.persistent_data_dir + '/mnt'
+    scratch_dir = u_boot_config.persistent_data_dir + '/scratch'
 
-    small_file = mount_dir + '/' + SMALL_FILE
-    medium_file = mount_dir + '/' + MEDIUM_FILE
+    small_file = scratch_dir + '/' + SMALL_FILE
+    medium_file = scratch_dir + '/' + MEDIUM_FILE
 
     try:
-        check_call('mkdir -p %s' % mount_dir, shell=True)
+        check_call('mkdir -p %s' % scratch_dir, shell=True)
     except CalledProcessError as err:
         pytest.skip('Preparing mount folder failed for filesystem: ' + fs_type + '. {}'.format(err))
         call('rm -f %s' % fs_img, shell=True)
@@ -491,7 +491,7 @@ def fs_obj_symlink(request, u_boot_config):
 
     try:
         # Create a subdirectory.
-        check_call('mkdir %s/SUBDIR' % mount_dir, shell=True)
+        check_call('mkdir %s/SUBDIR' % scratch_dir, shell=True)
 
         # Create a small file in this image.
         check_call('dd if=/dev/urandom of=%s bs=1M count=1'
@@ -513,7 +513,7 @@ def fs_obj_symlink(request, u_boot_config):
 
         try:
             # 1GiB volume
-            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x40000000, '1GB', mount_dir)
+            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x40000000, '1GB', scratch_dir)
         except CalledProcessError as err:
             pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
             return
@@ -524,7 +524,7 @@ def fs_obj_symlink(request, u_boot_config):
     else:
         yield [fs_ubtype, fs_img, md5val]
     finally:
-        call('rm -rf %s' % mount_dir, shell=True)
+        call('rm -rf %s' % scratch_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
 
 #
-- 
2.43.0

