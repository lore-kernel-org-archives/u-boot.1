Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C4FCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F6D849EF;
	Wed,  6 May 2026 17:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U+hjR5ND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3DE98468B; Wed,  6 May 2026 17:58:01 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 538DE8493F
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7de431da8fbso5713011a34.1
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778083077; x=1778687877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zjw2fuF6iPBXPQU3ViXCoSKZDFQ14TNanwquxgUJISc=;
 b=U+hjR5NDnDENmJoMI0llBuGFjaSavBBLWzt3+6HgKu/nhgF40rJrJCmYglII43zbSN
 P+Wjd5n3dD8c2HQhGWUqG7RAvZIC+6MfdH8jHOOarybrR91vnvCdhYXHiFI9AVjORBDr
 SU+7XohyveSr6Ob+Te4U8J26wyolZFna0Fb4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083077; x=1778687877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zjw2fuF6iPBXPQU3ViXCoSKZDFQ14TNanwquxgUJISc=;
 b=Fn3WgxvooiIj1TNshLfwEuyme9N6ewD7FZ69GpdqzgEh68ez+Xan64JMISGsKH8caq
 KmJ9S9g0NtifjkuYkaC7xoC4JGk9B+6Y1R3xXoYe0jcd8m4hjg4zHj1yaQzx2mIxV9mT
 lJPK55vxOv2yZ5kbEeuVMPJCEWSJUYv1oG3+Ybs3xx6ejvxtsjlXZkNv9RsrhPrQZTe8
 74/DkAcKh4XWbq2Ys2wcn5m5BwlqlKOWwxkOtbzqZN4XEAgOjSlFMNUTaJFZCyUjxwPs
 G+Z6npMhK9/gnx1rtNA887dls277fzfCvS9zYivVhvcnlPg7eUb4Vgx2bErOSgFSQ/vR
 XnTw==
X-Gm-Message-State: AOJu0YyCGFJcFmbYIsYYpDcwfcIjGJ5CI1We4+/fHvlWuXc12/Fm5lwk
 1cwzLpDRgu/6V3OajgxgC6dp8jUAZU27IGHUi9MVtMU00k+0CGQRY75sUEH6tRvLHlezIkBQjTt
 /PjCg5DVz
X-Gm-Gg: AeBDieuyHvDAHxKJNUwFxmQw8C9z2A8KO6rNuFjOc34zhl6p5IBrcBJoBBivbuXF4FJ
 GmhzINkiJ786BrJdHN89NqbFzr5zxwxYLUcqjMZGC4Ldc081RdQxT6+vqVmlIt3jAVLK+AK68/A
 rwXPIsgG2BuLvi7LCey070DzDBnxn/D/WCiKMVLJJcRLPYelKJmWqZo83FPz1og/ZeQ9CD4NBM3
 yFinyIplNIHySk8TwV7QJNHuLmDOyWgPVNhY9//GTNzdnAAsrPn/Bo/nXE1+3ko3zflVx8j5hAg
 SNiu4fungv/xGUn4ojjIZX5Pco317Bjrdtrd5dXHoXjpue0BmADOgtKTRkTmQn5I+QkKJhSVIFg
 RAt8epTLdujeMmcg8IPARYTEkBZmqwdyC4TWLV7oumwJMVh4kkcEC6tz87KY6j22FsyklwnAWPe
 MdLm6Py5L2dOsSrxRhMM5qhhN7ULoH
X-Received: by 2002:a05:6830:6d09:b0:7dc:18e:b5a4 with SMTP id
 46e09a7af769-7e1def3f732mr2115596a34.11.1778083077436; 
 Wed, 06 May 2026 08:57:57 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decadc2906sm12309095a34.23.2026.05.06.08.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:57:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/10] test: Convert test_efi_capsule fixture to FsHelper
Date: Wed,  6 May 2026 09:56:17 -0600
Message-ID: <20260506155639.1191640-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506155639.1191640-1-sjg@chromium.org>
References: <20260506155639.1191640-1-sjg@chromium.org>
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

Simplify this test-setup fixture by using the helper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_efi_capsule/conftest.py | 156 ++++++++++-----------
 1 file changed, 77 insertions(+), 79 deletions(-)

diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index ad0cda59ebf..83bf026108e 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -7,7 +7,7 @@
 import os
 
 from subprocess import call, check_call, CalledProcessError
-from tests import fs_helper
+from tests.fs_helper import DiskHelper, FsHelper
 import pytest
 from capsule_defs import CAPSULE_DATA_DIR, CAPSULE_INSTALL_DIR, EFITOOLS_PATH
 
@@ -23,87 +23,85 @@ def efi_capsule_data(request, ubman):
     ubman -- U-Boot configuration.
     """
     try:
-        image_path, mnt_point = fs_helper.setup_image(ubman, 0, 0xc,
-                                                      basename='test_efi_capsule')
-        data_dir = mnt_point + CAPSULE_DATA_DIR
-        install_dir = mnt_point + CAPSULE_INSTALL_DIR
-
-        # Create a target device
-        check_call('dd if=/dev/zero of=./spi.bin bs=1MiB count=16', shell=True)
-
-        check_call('rm -rf %s' % mnt_point, shell=True)
-        check_call('mkdir -p %s' % data_dir, shell=True)
-        check_call('mkdir -p %s' % install_dir, shell=True)
-
-        capsule_auth_enabled = ubman.config.buildconfig.get(
-                    'config_efi_capsule_authenticate')
-        key_dir = ubman.config.source_dir + '/board/sandbox'
-        if capsule_auth_enabled:
-            # Get the keys from the board directory
-            check_call('cp %s/capsule_priv_key_good.key %s/SIGNER.key'
-                       % (key_dir, data_dir), shell=True)
-            check_call('cp %s/capsule_pub_key_good.crt %s/SIGNER.crt'
-                       % (key_dir, data_dir), shell=True)
-
-            check_call('cp %s/capsule_priv_key_bad.key %s/SIGNER2.key'
-                       % (key_dir, data_dir), shell=True)
-            check_call('cp %s/capsule_pub_key_bad.crt %s/SIGNER2.crt'
-                       % (key_dir, data_dir), shell=True)
-
-        # Update dtb to add the version information
-        check_call('cd %s; '
-                   'cp %s/test/py/tests/test_efi_capsule/version.dtso .'
-                   % (data_dir, ubman.config.source_dir), shell=True)
-
-        if capsule_auth_enabled:
+        with DiskHelper(ubman.config, 0, 'test_efi_capsule') as img, \
+                FsHelper(ubman.config, 'vfat', 16,
+                         'test_efi_capsule') as fsh:
+            data_dir = fsh.srcdir + CAPSULE_DATA_DIR
+            install_dir = fsh.srcdir + CAPSULE_INSTALL_DIR
+
+            # Create a target device
+            check_call('dd if=/dev/zero of=./spi.bin bs=1MiB count=16',
+                       shell=True)
+
+            check_call('mkdir -p %s' % data_dir, shell=True)
+            check_call('mkdir -p %s' % install_dir, shell=True)
+
+            capsule_auth_enabled = ubman.config.buildconfig.get(
+                        'config_efi_capsule_authenticate')
+            key_dir = ubman.config.source_dir + '/board/sandbox'
+            if capsule_auth_enabled:
+                # Get the keys from the board directory
+                check_call('cp %s/capsule_priv_key_good.key %s/SIGNER.key'
+                           % (key_dir, data_dir), shell=True)
+                check_call('cp %s/capsule_pub_key_good.crt %s/SIGNER.crt'
+                           % (key_dir, data_dir), shell=True)
+
+                check_call('cp %s/capsule_priv_key_bad.key %s/SIGNER2.key'
+                           % (key_dir, data_dir), shell=True)
+                check_call('cp %s/capsule_pub_key_bad.crt %s/SIGNER2.crt'
+                           % (key_dir, data_dir), shell=True)
+
+            # Update dtb to add the version information
             check_call('cd %s; '
-                       'cp %s/arch/sandbox/dts/test.dtb test_sig.dtb'
-                       % (data_dir, ubman.config.build_dir), shell=True)
+                       'cp %s/test/py/tests/test_efi_capsule/version.dtso .'
+                       % (data_dir, ubman.config.source_dir), shell=True)
+
+            if capsule_auth_enabled:
+                check_call('cd %s; '
+                           'cp %s/arch/sandbox/dts/test.dtb test_sig.dtb'
+                           % (data_dir, ubman.config.build_dir), shell=True)
+                check_call('cd %s; '
+                           'dtc -@ -I dts -O dtb -o version.dtbo version.dtso; '
+                           'fdtoverlay -i test_sig.dtb '
+                                '-o test_ver.dtb version.dtbo'
+                           % (data_dir), shell=True)
+            else:
+                check_call('cd %s; '
+                           'dtc -@ -I dts -O dtb -o version.dtbo version.dtso; '
+                           'fdtoverlay -i %s/arch/sandbox/dts/test.dtb '
+                                '-o test_ver.dtb version.dtbo'
+                           % (data_dir, ubman.config.build_dir), shell=True)
+
+            # two regions: one for u-boot.bin and the other for u-boot.env
+            check_call('cd %s; echo -n u-boot:Old > u-boot.bin.old; echo -n u-boot:New > u-boot.bin.new; echo -n u-boot-env:Old > u-boot.env.old; echo -n u-boot-env:New > u-boot.env.new' % data_dir,
+                       shell=True)
+
+            pythonpath = os.environ.get('PYTHONPATH', '')
+            os.environ['PYTHONPATH'] = pythonpath + ':' + '%s/scripts/dtc/pylibfdt' % ubman.config.build_dir
             check_call('cd %s; '
-                       'dtc -@ -I dts -O dtb -o version.dtbo version.dtso; '
-                       'fdtoverlay -i test_sig.dtb '
-                            '-o test_ver.dtb version.dtbo'
-                       % (data_dir), shell=True)
-        else:
+                       'cc -E -I %s/include -x assembler-with-cpp -o capsule_gen_tmp.dts %s/test/py/tests/test_efi_capsule/capsule_gen_binman.dts; '
+                       'dtc -I dts -O dtb capsule_gen_tmp.dts -o capsule_binman.dtb;'
+                       % (data_dir, ubman.config.source_dir, ubman.config.source_dir), shell=True)
             check_call('cd %s; '
-                       'dtc -@ -I dts -O dtb -o version.dtbo version.dtso; '
-                       'fdtoverlay -i %s/arch/sandbox/dts/test.dtb '
-                            '-o test_ver.dtb version.dtbo'
-                       % (data_dir, ubman.config.build_dir), shell=True)
-
-        # two regions: one for u-boot.bin and the other for u-boot.env
-        check_call('cd %s; echo -n u-boot:Old > u-boot.bin.old; echo -n u-boot:New > u-boot.bin.new; echo -n u-boot-env:Old > u-boot.env.old; echo -n u-boot-env:New > u-boot.env.new' % data_dir,
-                   shell=True)
-
-        pythonpath = os.environ.get('PYTHONPATH', '')
-        os.environ['PYTHONPATH'] = pythonpath + ':' + '%s/scripts/dtc/pylibfdt' % ubman.config.build_dir
-        check_call('cd %s; '
-                   'cc -E -I %s/include -x assembler-with-cpp -o capsule_gen_tmp.dts %s/test/py/tests/test_efi_capsule/capsule_gen_binman.dts; '
-                   'dtc -I dts -O dtb capsule_gen_tmp.dts -o capsule_binman.dtb;'
-                   % (data_dir, ubman.config.source_dir, ubman.config.source_dir), shell=True)
-        check_call('cd %s; '
-                   './tools/binman/binman --toolpath %s/tools build -u -d %s/capsule_binman.dtb -O %s -m --allow-missing -I %s -I ./board/sandbox -I ./arch/sandbox/dts'
-                   % (ubman.config.source_dir, ubman.config.build_dir, data_dir, data_dir, data_dir), shell=True)
-        check_call('cp %s/Test* %s' % (ubman.config.build_dir, data_dir), shell=True)
-        os.environ['PYTHONPATH'] = pythonpath
-
-        # Create a 16MiB partition as the EFI system partition in the disk
-        # image
-        fsfile = fs_helper.mk_fs(ubman.config, 'vfat', 0x1000000,
-                                 'test_efi_capsule', mnt_point)
-        check_call(f'dd conv=notrunc if={fsfile} of={image_path} bs=1M seek=1', shell=True)
-        check_call('sgdisk --mbrtogpt %s' % image_path, shell=True)
-        check_call('sgdisk %s -A 1:set:0 -t 1:C12A7328-F81F-11D2-BA4B-00A0C93EC93B' %
-                   image_path, shell=True)
-        call('rm -f %s' % fsfile, shell=True)
-
+                       './tools/binman/binman --toolpath %s/tools build -u -d %s/capsule_binman.dtb -O %s -m --allow-missing -I %s -I ./board/sandbox -I ./arch/sandbox/dts'
+                       % (ubman.config.source_dir, ubman.config.build_dir, data_dir, data_dir, data_dir), shell=True)
+            check_call('cp %s/Test* %s' % (ubman.config.build_dir, data_dir), shell=True)
+            os.environ['PYTHONPATH'] = pythonpath
+
+            # Create a 16MiB partition as the EFI system partition in the disk
+            # image
+            fsh.mk_fs()
+            img.add_fs(fsh, DiskHelper.VFAT)
+            image_path = img.create()
+            check_call('sgdisk --mbrtogpt %s' % image_path, shell=True)
+            check_call('sgdisk %s -A 1:set:0 -t 1:C12A7328-F81F-11D2-BA4B-00A0C93EC93B' %
+                       image_path, shell=True)
+
+            ubman.restart_uboot()
+            try:
+                yield image_path
+            finally:
+                call('rm -f ./spi.bin', shell=True)
     except CalledProcessError as exception:
         pytest.skip('Setup failed: %s' % exception.cmd)
         return
-    else:
-        ubman.restart_uboot()
-        yield image_path
-    finally:
-        call('rm -rf %s' % mnt_point, shell=True)
-        call('rm -f %s' % image_path, shell=True)
-        call('rm -f ./spi.bin', shell=True)
-- 
2.43.0

