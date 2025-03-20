Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44870C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E11D81DDF;
	Thu, 20 Mar 2025 15:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sEIdbFCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDEDA8197D; Thu, 20 Mar 2025 15:00:44 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43DE380540
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so1366634a91.2
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742479241; x=1743084041; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UibomFDQRrajzr2Woq5tns2uEI8GA90OFHkCCLFUYa8=;
 b=sEIdbFCYZad/6S9JGckgXspQY7ijQInJt1zm9y7Wm/Gm2mHPdJD2iP96SPO9pYXzjj
 rcMRe8qaIEN/dW1Q3+BT4FvItiEMIxoIOThg1YH+H7j1OovHqn80oQDm+wzUsIdFG2Wp
 xIbY0/t5KmllqvdX3c5Vmj+Ts6KIVgscFmn+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742479241; x=1743084041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UibomFDQRrajzr2Woq5tns2uEI8GA90OFHkCCLFUYa8=;
 b=ByNCnTK7Mam/y/dbZY/9Efbypu7jawCEUWJk5jdvrWShaorS3hnwEMYTTwY8FhMfDE
 +swhIL6wFSNlU0FNsRLoe8ovoYtut+mlX1ygU0TjelKp4l3UNWj7CcUsInyUXIFWWCE+
 pb41J3z1HKy0Y9UsRFQzVMnG9c1AfTYELBOIGeuLCpzw8Yn+ZS8zCc6gZi/tn11uCivB
 kZc1WYJX6dd4/gRY5r3ZL/KSwKpZD8KciYW+6tDQwNt128eU9ACLH+8XX+XMufDoys6/
 hr92aMmPxL5iiljyX5aaaeVZ/mXBu/T+1B4Nj8VoOnP2QrFZ5fO1HuXx5PWH7TldjSRC
 wJMw==
X-Gm-Message-State: AOJu0YzoaSuBcRn8b9vjGK5ohd7ESe5enIk15HCkGpcArri1gJP6JjUd
 tIEIFLtFcYDaRvg57WWgqM4e7WT1DKdCj+py5CrZyjPIL8i6cGd+ui4MWcT7V2hHou7sJvY7KXo
 S
X-Gm-Gg: ASbGnctS35cR4CwcSmbTZBtMu/T1wopa9vB8Tt5VyVucnK25/J9/FR0IB4Aa4BF8QEf
 ylOhbr0O86gCDu/KvljqWpZYrr4MnHs1is+zf3nCBUBt0Z/uHt7Id9qbfTsCBll5jlGzJhfALey
 JN+tWR8HK0NakXCXfBty1vKws+HeThfRdSvf+Yb24//HIAhDfdyIOiQGhGPmLduue158jL46gtp
 VM8UdJdzZ27OkFNCp2lA9hYcBqggRQ1AIY2NvI7I5wUS2HT1iIyjBXVFCLfHp0n16+6v0WbQSVB
 nXVYujsG/DGwMzDZ9pLU3mkYNN1d3MWh/5H6pYA7PDtTkAxP
X-Google-Smtp-Source: AGHT+IEZNjnoHTi3B6IhXT1zRwkG8UIRs0q8Eggb5O5Jv8XY/z8+CCZF8oKii5WFP/eKTouHw/rC0g==
X-Received: by 2002:a17:90b:4c48:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-301d50b6284mr5699911a91.14.1742479240337; 
 Thu, 20 Mar 2025 07:00:40 -0700 (PDT)
Received: from bill-the-cat.. ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf59cd49sm3857532a91.22.2025.03.20.07.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:00:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 06/10] test/py: Rework test_eficonfig to not use
 virt-make-fs
Date: Thu, 20 Mar 2025 07:59:27 -0600
Message-ID: <20250320140030.2052434-7-trini@konsulko.com>
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

As this test already had a number of internal functions, add a
prepare_image function to do this part of the test.

Signed-off-by: Tom Rini <trini@konsulko.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2:
- Rebase on next after the ubman series.
---
 .../{test_eficonfig => }/test_eficonfig.py    | 53 ++++++++++++++++---
 test/py/tests/test_eficonfig/conftest.py      | 40 --------------
 2 files changed, 46 insertions(+), 47 deletions(-)
 rename test/py/tests/{test_eficonfig => }/test_eficonfig.py (88%)
 delete mode 100644 test/py/tests/test_eficonfig/conftest.py

diff --git a/test/py/tests/test_eficonfig/test_eficonfig.py b/test/py/tests/test_eficonfig.py
similarity index 88%
rename from test/py/tests/test_eficonfig/test_eficonfig.py
rename to test/py/tests/test_eficonfig.py
index 3ca8e27c76ba..ac1600ec252d 100644
--- a/test/py/tests/test_eficonfig/test_eficonfig.py
+++ b/test/py/tests/test_eficonfig.py
@@ -2,13 +2,57 @@
 """ Unit test for UEFI menu-driven configuration
 """
 
+import pytest
+import shutil
 import pytest
 import time
+from subprocess import call, check_call, CalledProcessError
+from tests import fs_helper
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_eficonfig')
 @pytest.mark.buildconfigspec('cmd_bootefi_bootmgr')
-def test_efi_eficonfig(ubman, efi_eficonfig_data):
+def test_efi_eficonfig(ubman):
+
+    def prepare_image(u_boot_config):
+        """Set up a file system to be used in UEFI "eficonfig" command
+           tests. This creates a disk image with the following files:
+                 initrd-1.img
+                 initrd-2.img
+                 initrddump.efi
+
+        Args:
+            u_boot_config -- U-Boot configuration.
+
+        Return:
+            A path to disk image to be used for testing
+
+        """
+        try:
+            image_path, mnt_point = fs_helper.setup_image(u_boot_config, 0,
+                                                          0xc,
+                                                          basename='test_eficonfig')
+
+            with open(mnt_point + '/initrd-1.img', 'w', encoding = 'ascii') as file:
+                file.write("initrd 1")
+
+            with open(mnt_point + '/initrd-2.img', 'w', encoding = 'ascii') as file:
+                file.write("initrd 2")
+
+            shutil.copyfile(u_boot_config.build_dir + '/lib/efi_loader/initrddump.efi',
+                            mnt_point + '/initrddump.efi')
+
+            fsfile = fs_helper.mk_fs(ubman.config, 'vfat', 0x100000,
+                                     'test_eficonfig', mnt_point)
+            check_call(f'dd if={fsfile} of={image_path} bs=1M seek=1', shell=True)
+
+            yield image_path
+        except CalledProcessError as err:
+            pytest.skip('Preparing test_eficonfig image failed')
+            call('rm -f %s' % image_path, shell=True)
+        finally:
+            call('rm -rf %s' % mnt_point, shell=True)
+            call('rm -f %s' % image_path, shell=True)
 
     def send_user_input_and_wait(user_str, expect_str):
         time.sleep(0.1) # TODO: does not work correctly without sleep
@@ -57,12 +101,6 @@ def test_efi_eficonfig(ubman, efi_eficonfig_data):
 
     Args:
         ubman -- U-Boot console
-        efi__data -- Path to the disk image used for testing.
-                     Test disk image has following files.
-                         initrd-1.img
-                         initrd-2.img
-                         initrddump.efi
-
     """
     # This test passes for unknown reasons in the bowels of U-Boot. It needs to
     # be replaced with a unit test.
@@ -71,6 +109,7 @@ def test_efi_eficonfig(ubman, efi_eficonfig_data):
     # Restart the system to clean the previous state
     ubman.restart_uboot()
 
+    efi_eficonfig_data = prepare_image(ubman.config)
     with ubman.temporary_timeout(500):
         #
         # Test Case 1: Check the menu is displayed
diff --git a/test/py/tests/test_eficonfig/conftest.py b/test/py/tests/test_eficonfig/conftest.py
deleted file mode 100644
index 0a82fbefd752..000000000000
--- a/test/py/tests/test_eficonfig/conftest.py
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier:      GPL-2.0+
-
-"""Fixture for UEFI eficonfig test
-"""
-
-import os
-import shutil
-from subprocess import check_call
-import pytest
-
-@pytest.fixture(scope='session')
-def efi_eficonfig_data(u_boot_config):
-    """Set up a file system to be used in UEFI "eficonfig" command
-       tests
-
-    Args:
-        u_boot_config -- U-Boot configuration.
-
-    Return:
-        A path to disk image to be used for testing
-    """
-    mnt_point = u_boot_config.persistent_data_dir + '/test_efi_eficonfig'
-    image_path = u_boot_config.persistent_data_dir + '/efi_eficonfig.img'
-
-    shutil.rmtree(mnt_point, ignore_errors=True)
-    os.mkdir(mnt_point, mode = 0o755)
-
-    with open(mnt_point + '/initrd-1.img', 'w', encoding = 'ascii') as file:
-        file.write("initrd 1")
-
-    with open(mnt_point + '/initrd-2.img', 'w', encoding = 'ascii') as file:
-        file.write("initrd 2")
-
-    shutil.copyfile(u_boot_config.build_dir + '/lib/efi_loader/initrddump.efi',
-                    mnt_point + '/initrddump.efi')
-
-    check_call(f'virt-make-fs --partition=gpt --size=+1M --type=vfat {mnt_point} {image_path}',
-               shell=True)
-
-    return image_path
-- 
2.43.0

