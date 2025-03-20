Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9551DC35FFF
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A0881DF6;
	Thu, 20 Mar 2025 15:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i+lrdqmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A80D81E06; Thu, 20 Mar 2025 15:00:48 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC8CD8197D
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso1731576a91.1
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742479244; x=1743084044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T6oTfLHSuVYR+ug+i18qCbu6v3renwxumYzJsgXYi4g=;
 b=i+lrdqmtEmGTIL6/Tyuny3016Fgb6OUpG6Whxm+DI89QV9xzyaJKsZQ7Hy/z/1Dl0i
 iHVhg13kcV5wdbSC4hMUlQ4Si7kmj6zfE1mO3nNLAG8s3fUs6HdcxzeZ73KkVjjvH/qm
 gDmUrRqdlVLHypU4a+GrV/jxgRf20OyKwWLCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742479244; x=1743084044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T6oTfLHSuVYR+ug+i18qCbu6v3renwxumYzJsgXYi4g=;
 b=f3PgZwFh27W7IsM5i+iILbWZwcVo4OfOmCHc8TXhi1jUyNEC/eVJTmI1N3MY765eNh
 0+wqd5LzzorJDYRVK+3JZjxaYcgT3BJbOe4f+FfnQO69qaG3UpT3khIJT3kmu88U3i+D
 +LugiXtX+urx7M1BkRB9UlXbeODL6gtHQpqdInlmHCiK/OrLwviBVxdxmjzH2EqlzlZD
 VfUpyDYH5eLPZnm2yS/Mq5e2G0YXXrQAr+DLPrtYIahT1HRLzk2oQqTVC0mGC5jITT0P
 Zd1M2PIqKDvmvINRvBIas+ROsoZ2fVf27G9PAsx2QWLNaiscDR8Bo57u3wXJFk4gZDPr
 tWZw==
X-Gm-Message-State: AOJu0Yz7RHrsAEP8tcKMHn1HTgPz0RPYTIisz4m8X3qv+doxT3iSODBN
 +JGAaJxuqPq8BxT7min8Wq8W93H7jkAifHVMCTsjcC0GkEBFHNpEkmXFAnGxPEzctJf+glk/di7
 5
X-Gm-Gg: ASbGnctwrkjflARrXKJ9QUYwHYQnpsnXQVOy9ayxq5EzPSzGbImmfY237Fsd+6q7OBC
 hTC8oCbfBZhNPgfsxWYOoboxwpEZQ6vUUP3CpP1w0BXAgbBavm9mBxpA9+9ygtt4Gzaz2jVs2g/
 Q1nJG9r8gL2GyOGlGTZER59eoa4mI01JxsvYwDaXe2CEOBzW9e14X80jU7thrkRBqwZAeAZbHNu
 +mvo7FZJUkGJqCuO7tGEeqwu+MHnFN5xrOR9l12wDgtauUyFky8Y7dWhNKxGwtwHur9NQ/5w6PA
 M7j9ZIU2iOxdwJKqS8qHWbc0kKNMeeCVTgwZ01iCKH1R9IEa
X-Google-Smtp-Source: AGHT+IHZWx+PFqfDZ2Z5+ZZF9JKj/iD024GR9BBf6RjGnOS0WALJ0HI9P0W4d1RmZxRyUgoDmuRUzg==
X-Received: by 2002:a17:90a:53c7:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-302fc485031mr552080a91.0.1742479242538; 
 Thu, 20 Mar 2025 07:00:42 -0700 (PDT)
Received: from bill-the-cat.. ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf59cd49sm3857532a91.22.2025.03.20.07.00.41
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:00:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 08/10] test/py: Rework test_efi_secboot to not use
 virt-make-fs
Date: Thu, 20 Mar 2025 07:59:29 -0600
Message-ID: <20250320140030.2052434-9-trini@konsulko.com>
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

The problem with using "virt-make-fs" to make a filesystem image is that
it is extremely slow. Switch to using the fs_helper functions we have
instead from the filesystem tests as these can add files to images and
are significantly faster and still do not require root access.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Rebase on next after the ubman series.
- The above required a bit more rework of the changes here as well as
  ubman is a different fixture scope.
---
 test/py/tests/test_efi_secboot/conftest.py | 52 +++++++++++-----------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests/test_efi_secboot/conftest.py
index 0fa0747fc764..aa9a3536296e 100644
--- a/test/py/tests/test_efi_secboot/conftest.py
+++ b/test/py/tests/test_efi_secboot/conftest.py
@@ -5,27 +5,25 @@
 """Fixture for UEFI secure boot test."""
 
 from subprocess import call, check_call, CalledProcessError
+from tests import fs_helper
 import pytest
 from defs import *
 
-@pytest.fixture(scope='session')
-def efi_boot_env(request, u_boot_config):
+@pytest.fixture(scope='function')
+def efi_boot_env(request, ubman):
     """Set up a file system to be used in UEFI secure boot test.
 
     Args:
         request: Pytest request object.
-        u_boot_config: U-Boot configuration.
+        ubman: U-Boot configuration.
 
     Return:
         A path to disk image to be used for testing
     """
-    image_path = u_boot_config.persistent_data_dir
-    image_path = image_path + '/test_efi_secboot.img'
 
     try:
-        mnt_point = u_boot_config.build_dir + '/mnt_efisecure'
-        check_call('rm -rf {}'.format(mnt_point), shell=True)
-        check_call('mkdir -p {}'.format(mnt_point), shell=True)
+        image_path, mnt_point = fs_helper.setup_image(ubman, 0, 0xc,
+                                                      basename='test_efi_secboot')
 
         # suffix
         # *.key: RSA private key in PEM
@@ -101,7 +99,7 @@ def efi_boot_env(request, u_boot_config):
 
         # Copy image
         check_call('cp %s/lib/efi_loader/helloworld.efi %s' %
-                   (u_boot_config.build_dir, mnt_point), shell=True)
+                   (ubman.config.build_dir, mnt_point), shell=True)
 
         # Sign image
         check_call('cd %s; sbsign --key db.key --cert db.crt helloworld.efi'
@@ -111,7 +109,7 @@ def efi_boot_env(request, u_boot_config):
                    % mnt_point, shell=True)
         # Create a corrupted signed image
         check_call('cd %s; sh %s/test/py/tests/test_efi_secboot/forge_image.sh helloworld.efi.signed helloworld_forged.efi.signed'
-                   % (mnt_point, u_boot_config.source_dir), shell=True)
+                   % (mnt_point, ubman.config.source_dir), shell=True)
         # Digest image
         check_call('cd %s; %shash-to-efi-sig-list helloworld.efi db_hello.hash; %ssign-efi-sig-list -t "2020-04-07" -c KEK.crt -k KEK.key db db_hello.hash db_hello.auth'
                    % (mnt_point, EFITOOLS_PATH, EFITOOLS_PATH),
@@ -123,9 +121,9 @@ def efi_boot_env(request, u_boot_config):
                    % (mnt_point, EFITOOLS_PATH),
                    shell=True)
 
-        check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat {} {}'.format(
-            mnt_point, image_path), shell=True)
-        check_call('rm -rf {}'.format(mnt_point), shell=True)
+        fsfile = fs_helper.mk_fs(ubman.config, 'vfat', 0x1000000,
+                                 'test_efi_secboot', mnt_point)
+        check_call(f'dd if={fsfile} of={image_path} bs=1M seek=1', shell=True)
 
     except CalledProcessError as exception:
         pytest.skip('Setup failed: %s' % exception.cmd)
@@ -133,15 +131,16 @@ def efi_boot_env(request, u_boot_config):
     else:
         yield image_path
     finally:
-        call('rm -f %s' % image_path, shell=True)
+        call('rm -rf %s' % mnt_point, shell=True)
+        call('rm -f %s %s' % (image_path, fsfile), shell=True)
 
 #
 # Fixture for UEFI secure boot test of intermediate certificates
 #
 
 
-@pytest.fixture(scope='session')
-def efi_boot_env_intca(request, u_boot_config):
+@pytest.fixture(scope='function')
+def efi_boot_env_intca(request, ubman):
     """Set up file system for secure boot test.
 
     Set up a file system to be used in UEFI secure boot test
@@ -149,18 +148,15 @@ def efi_boot_env_intca(request, u_boot_config):
 
     Args:
         request: Pytest request object.
-        u_boot_config: U-Boot configuration.
+        ubman: U-Boot configuration.
 
     Return:
         A path to disk image to be used for testing
     """
-    image_path = u_boot_config.persistent_data_dir
-    image_path = image_path + '/test_efi_secboot_intca.img'
 
     try:
-        mnt_point = u_boot_config.persistent_data_dir + '/mnt_efi_secboot_intca'
-        check_call('rm -rf {}'.format(mnt_point), shell=True)
-        check_call('mkdir -p {}'.format(mnt_point), shell=True)
+        image_path, mnt_point = fs_helper.setup_image(ubman, 0, 0xc,
+                                                      basename='test_efi_secboot_intca')
 
         # Create signature database
         # PK
@@ -190,7 +186,7 @@ def efi_boot_env_intca(request, u_boot_config):
 
         # TestRoot
         check_call('cp %s/test/py/tests/test_efi_secboot/openssl.cnf %s'
-                   % (u_boot_config.source_dir, mnt_point), shell=True)
+                   % (ubman.config.source_dir, mnt_point), shell=True)
         check_call('cd %s; export OPENSSL_CONF=./openssl.cnf; openssl genrsa -out TestRoot.key 2048; openssl req -extensions v3_ca -new -x509 -days 365 -key TestRoot.key -out TestRoot.crt -subj "/CN=TEST_root/"; touch index.txt; touch index.txt.attr'
                    % mnt_point, shell=True)
         # TestSub
@@ -231,7 +227,7 @@ def efi_boot_env_intca(request, u_boot_config):
         # in SignedData
 
         check_call('cp %s/lib/efi_loader/helloworld.efi %s' %
-                   (u_boot_config.build_dir, mnt_point), shell=True)
+                   (ubman.config.build_dir, mnt_point), shell=True)
         # signed by TestCert
         check_call('cd %s; %ssbsign --key TestCert.key --cert TestCert.crt --out helloworld.efi.signed_a helloworld.efi'
                    % (mnt_point, SBSIGN_PATH), shell=True)
@@ -242,8 +238,9 @@ def efi_boot_env_intca(request, u_boot_config):
         check_call('cd %s; cat TestSub.crt TestRoot.crt > TestSubRoot.crt; %ssbsign --key TestCert.key --cert TestCert.crt --addcert TestSubRoot.crt --out helloworld.efi.signed_abc helloworld.efi'
                    % (mnt_point, SBSIGN_PATH), shell=True)
 
-        check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat {} {}'.format(mnt_point, image_path), shell=True)
-        check_call('rm -rf {}'.format(mnt_point), shell=True)
+        fsfile = fs_helper.mk_fs(ubman.config, 'vfat', 0x1000000,
+                                 'test_efi_secboot_intca', mnt_point)
+        check_call(f'dd if={fsfile} of={image_path} bs=1M seek=1', shell=True)
 
     except CalledProcessError as e:
         pytest.skip('Setup failed: %s' % e.cmd)
@@ -251,4 +248,5 @@ def efi_boot_env_intca(request, u_boot_config):
     else:
         yield image_path
     finally:
-        call('rm -f %s' % image_path, shell=True)
+        call('rm -rf %s' % mnt_point, shell=True)
+        call('rm -f %s %s' % (image_path, fsfile), shell=True)
-- 
2.43.0

