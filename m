Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01ABC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 768938198A;
	Thu, 20 Mar 2025 15:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kG+IEnn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B6D819B1; Thu, 20 Mar 2025 15:00:46 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA1181101
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3014cb646ecso1050306a91.1
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742479242; x=1743084042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=REF+T9lDwIbbI5t0p2lMLyiFYYS9NkghCyIM3YkmrBg=;
 b=kG+IEnn5zJRbrxgdnSa+tN/dIbYfAVKTxGfq1vJczJWh8ov2N5KLSnHVWF1Gq3MBNF
 mI4l7s4AuOtzG2g33NwcRyw81KjS/mAn6tiqvTlSNZrwZtZVrVdGVreuMo7nReYuCTWf
 v+QbjSxNJ9ZYwykDGgmYru8xDuEUpaVeYRZms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742479242; x=1743084042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REF+T9lDwIbbI5t0p2lMLyiFYYS9NkghCyIM3YkmrBg=;
 b=rRUyAnmI2c4m2QdYRlmZ60ToeLBKCy/metm+E41wlk0vXqCcHp+/A4vKrzUnRkrHXd
 +aHQh1x7d/L4q5Jx1oVI9yrZJIKgrC2FM0DjbSnI1lw1U5psXZIanhqeYJlYOeNsQeOj
 sQx1iZhqedqyPgzv+2RX5khmqhzkyvOKIily3WPs+JsW1RFjT0vlkzGBstJvEx9VLIY2
 MFys6tslcjvGWu0AYAzEh35ElCYE2lRIvGKxZWHTjPhhdeOxdi+NzMvRhgUe7YFsm7RP
 sjff7AfCIjbxOQ64hYDTMJBf3kD5KmsL6Ym6vKcKrcz7eBAIKJGEOgPLmmtmjS/YoTmx
 2I/Q==
X-Gm-Message-State: AOJu0YwabRS82u+BbV2QOajhlzzg5XK/kK9CPA7kawhw9A260TekRMBN
 6xsEqZjzC72Fod5kboz7ETRH0nE3nNH8dC1SU+kHD1iVyjfz6vgtAaLz4mg34ifTi3czPB7zNWU
 t
X-Gm-Gg: ASbGnctwkcv/7sYH4kqIdTfUMMMgiF2VzbzWDbEiz+g6eE3r0gIMo8qMT8K/6XdIXh7
 IzEP2nOREcoY7Kihbje0mU83RI8g8w9pgCKtXHS8/UjeI2To7kBK/LX+8tciZXrIm9jL47kJ95s
 nmXazRJ2usBJ9WeuP3Hkrl5WJKZixS+vAQQbKd5VIyySKRfLRsXGgGE0A7ytKbbnN390+cJvL16
 aMs2gqJ7vWxP4+5Rvn59XhGfbp+OfjH0EGu2NPLYANjERzE68Ys09O2nX9qU/6bQZruqnP6sqEN
 HaKYlavZAFIpP1BQz3/LaH9AvAGwgNF8IfkA5Da/pwJbOdZ5
X-Google-Smtp-Source: AGHT+IFp7f2A+0dnHDiR0UOdEB5EGyYltXo+BYBu332+4bn6Td2E+CkmWoxCx7tm6FEHn2q1FE4ZhQ==
X-Received: by 2002:a17:90b:3b51:b0:2f9:9ddd:689b with SMTP id
 98e67ed59e1d1-301be2020c8mr8617104a91.22.1742479241452; 
 Thu, 20 Mar 2025 07:00:41 -0700 (PDT)
Received: from bill-the-cat.. ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf59cd49sm3857532a91.22.2025.03.20.07.00.40
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:00:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 07/10] test/py: Rework test_efi_capsule to not use
 virt-make-fs
Date: Thu, 20 Mar 2025 07:59:28 -0600
Message-ID: <20250320140030.2052434-8-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320140030.2052434-1-trini@konsulko.com>
References: <20250320140030.2052434-1-trini@konsulko.com>
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

FIXME: Reword more

The problem with using "virt-make-fs" to make a filesystem image is that
it is extremely slow. Switch to using the fs_helper functions we have
instead from the filesystem tests as these can add files to images and
are significantly faster and still do not require root access.

The main change here is that our mount point directory has changed from
"test_efi_capsule" to "scratch" and so we need to update other functions
too. As the disk image that we get created doesn't have a GPT, invoke
sgdisk to do a conversion first.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Rebase on next after the ubman series.
- This got me to notice I had missed some other parts of the conversion
  before and so drop Ilias' tag.
---
 .../tests/test_efi_capsule/capsule_common.py  |  2 +-
 test/py/tests/test_efi_capsule/conftest.py    | 45 ++++++++++---------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/test/py/tests/test_efi_capsule/capsule_common.py b/test/py/tests/test_efi_capsule/capsule_common.py
index 40b3fca809e9..04dabc176c4d 100644
--- a/test/py/tests/test_efi_capsule/capsule_common.py
+++ b/test/py/tests/test_efi_capsule/capsule_common.py
@@ -136,7 +136,7 @@ def do_reboot_dtb_specified(u_boot_config, ubman, dtb_filename):
         ubman -- A console connection to U-Boot.
         dtb_filename -- DTB file name.
     """
-    mnt_point = u_boot_config.persistent_data_dir + '/test_efi_capsule'
+    mnt_point = u_boot_config.persistent_data_dir + '/scratch'
     ubman.config.dtb = mnt_point + CAPSULE_DATA_DIR \
                                 + f'/{dtb_filename}'
     ubman.restart_uboot()
diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index 61eab5112a17..961d2e0b3c19 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -7,11 +7,12 @@
 import os
 
 from subprocess import call, check_call, CalledProcessError
+from tests import fs_helper
 import pytest
 from capsule_defs import CAPSULE_DATA_DIR, CAPSULE_INSTALL_DIR, EFITOOLS_PATH
 
-@pytest.fixture(scope='session')
-def efi_capsule_data(request, u_boot_config):
+@pytest.fixture(scope='function')
+def efi_capsule_data(request, ubman):
     """Set up a file system and return path to image.
 
     The function sets up a file system to be used in UEFI capsule and
@@ -19,14 +20,14 @@ def efi_capsule_data(request, u_boot_config):
     for testing.
 
     request -- Pytest request object.
-    u_boot_config -- U-Boot configuration.
+    ubman -- U-Boot configuration.
     """
-    mnt_point = u_boot_config.persistent_data_dir + '/test_efi_capsule'
-    data_dir = mnt_point + CAPSULE_DATA_DIR
-    install_dir = mnt_point + CAPSULE_INSTALL_DIR
-    image_path = u_boot_config.persistent_data_dir + '/test_efi_capsule.img'
-
     try:
+        image_path, mnt_point = fs_helper.setup_image(ubman, 0, 0xc,
+                                                      basename='test_efi_capsule')
+        data_dir = mnt_point + CAPSULE_DATA_DIR
+        install_dir = mnt_point + CAPSULE_INSTALL_DIR
+
         # Create a target device
         check_call('dd if=/dev/zero of=./spi.bin bs=1MiB count=16', shell=True)
 
@@ -34,9 +35,9 @@ def efi_capsule_data(request, u_boot_config):
         check_call('mkdir -p %s' % data_dir, shell=True)
         check_call('mkdir -p %s' % install_dir, shell=True)
 
-        capsule_auth_enabled = u_boot_config.buildconfig.get(
+        capsule_auth_enabled = ubman.config.buildconfig.get(
                     'config_efi_capsule_authenticate')
-        key_dir = u_boot_config.source_dir + '/board/sandbox'
+        key_dir = ubman.config.source_dir + '/board/sandbox'
         if capsule_auth_enabled:
             # Get the keys from the board directory
             check_call('cp %s/capsule_priv_key_good.key %s/SIGNER.key'
@@ -54,12 +55,12 @@ def efi_capsule_data(request, u_boot_config):
         # Update dtb to add the version information
         check_call('cd %s; '
                    'cp %s/test/py/tests/test_efi_capsule/version.dtso .'
-                   % (data_dir, u_boot_config.source_dir), shell=True)
+                   % (data_dir, ubman.config.source_dir), shell=True)
 
         if capsule_auth_enabled:
             check_call('cd %s; '
                        'cp %s/arch/sandbox/dts/test.dtb test_sig.dtb'
-                       % (data_dir, u_boot_config.build_dir), shell=True)
+                       % (data_dir, ubman.config.build_dir), shell=True)
             check_call('cd %s; '
                        'dtc -@ -I dts -O dtb -o version.dtbo version.dtso; '
                        'fdtoverlay -i test_sig.dtb '
@@ -70,29 +71,33 @@ def efi_capsule_data(request, u_boot_config):
                        'dtc -@ -I dts -O dtb -o version.dtbo version.dtso; '
                        'fdtoverlay -i %s/arch/sandbox/dts/test.dtb '
                             '-o test_ver.dtb version.dtbo'
-                       % (data_dir, u_boot_config.build_dir), shell=True)
+                       % (data_dir, ubman.config.build_dir), shell=True)
 
         # two regions: one for u-boot.bin and the other for u-boot.env
         check_call('cd %s; echo -n u-boot:Old > u-boot.bin.old; echo -n u-boot:New > u-boot.bin.new; echo -n u-boot-env:Old > u-boot.env.old; echo -n u-boot-env:New > u-boot.env.new' % data_dir,
                    shell=True)
 
         pythonpath = os.environ.get('PYTHONPATH', '')
-        os.environ['PYTHONPATH'] = pythonpath + ':' + '%s/scripts/dtc/pylibfdt' % u_boot_config.build_dir
+        os.environ['PYTHONPATH'] = pythonpath + ':' + '%s/scripts/dtc/pylibfdt' % ubman.config.build_dir
         check_call('cd %s; '
                    'cc -E -I %s/include -x assembler-with-cpp -o capsule_gen_tmp.dts %s/test/py/tests/test_efi_capsule/capsule_gen_binman.dts; '
                    'dtc -I dts -O dtb capsule_gen_tmp.dts -o capsule_binman.dtb;'
-                   % (data_dir, u_boot_config.source_dir, u_boot_config.source_dir), shell=True)
+                   % (data_dir, ubman.config.source_dir, ubman.config.source_dir), shell=True)
         check_call('cd %s; '
                    './tools/binman/binman --toolpath %s/tools build -u -d %s/capsule_binman.dtb -O %s -m --allow-missing -I %s -I ./board/sandbox -I ./arch/sandbox/dts'
-                   % (u_boot_config.source_dir, u_boot_config.build_dir, data_dir, data_dir, data_dir), shell=True)
-        check_call('cp %s/Test* %s' % (u_boot_config.build_dir, data_dir), shell=True)
+                   % (ubman.config.source_dir, ubman.config.build_dir, data_dir, data_dir, data_dir), shell=True)
+        check_call('cp %s/Test* %s' % (ubman.config.build_dir, data_dir), shell=True)
         os.environ['PYTHONPATH'] = pythonpath
 
-        # Create a disk image with EFI system partition
-        check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat %s %s' %
-                   (mnt_point, image_path), shell=True)
+        # Create a 16MiB partition as the EFI system partition in the disk
+        # image
+        fsfile = fs_helper.mk_fs(ubman.config, 'vfat', 0x1000000,
+                                 'test_efi_capsule', mnt_point)
+        check_call(f'dd conv=notrunc if={fsfile} of={image_path} bs=1M seek=1', shell=True)
+        check_call('sgdisk --mbrtogpt %s' % image_path, shell=True)
         check_call('sgdisk %s -A 1:set:0 -t 1:C12A7328-F81F-11D2-BA4B-00A0C93EC93B' %
                    image_path, shell=True)
+        call('rm -f %s' % fsfile, shell=True)
 
     except CalledProcessError as exception:
         pytest.skip('Setup failed: %s' % exception.cmd)
-- 
2.43.0

