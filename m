Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A3AC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1937816AB;
	Fri,  7 Mar 2025 00:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a1h3aGS+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9150810F5; Fri,  7 Mar 2025 00:23:17 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B7678141E
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6fd2587d059so9078877b3.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 15:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741303390; x=1741908190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ea2HEkmqyW91TwhNMxIjQ9HHLpzOcEX6nJ9t4mTw9qA=;
 b=a1h3aGS+XjQkoI3wMKX3N1pKIwEf1oWyc9BOxyQWsFwV13kmvaUDdcI5YV3tDy7Lxq
 U0Gd+8o2DqdxyCJpNnE0a6MDRl/YpX+/CNTeK9hidV4L6C2woz8IiuB3ahODqs/jREZK
 ckmpQy+l/JGCQy2cNX7yyKOWtlIk7a2j1F34c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303390; x=1741908190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ea2HEkmqyW91TwhNMxIjQ9HHLpzOcEX6nJ9t4mTw9qA=;
 b=ouX+gC1EiK8LtZrtsizua+K8WlfMqgFiYVoSgwG8rQfD6vYVQjnz9q3mc6PUufkJvU
 05NW7o005MqGGQFoKlPi/0bG4YijFiY7+80tU3L7ogpR49+7hjB5Mt4itSZTNfRhe3Y1
 mfNJxYXEylzjU9tLxDKIavDKwDxXLVIwTtUANCWNeHdKNPRhF9Ehx+NYwFkQYW600YZ7
 qgnLWiFALpksdT/0032yC9seC+wKmjqNqYQjGvvLE+2mh/riNX4BWjQlkTD5CCvR54zr
 nMUGgVMOO5GQ2l+6l821UC7EcXp7fAP/4u/P5RUTB5DoaI8d/nDY8k5BKFz3hDXpZmzn
 fXaw==
X-Gm-Message-State: AOJu0YyVxrO5+qc8V5uEhoRk2SGCkp7Fbf88oCmUWCHlHl98mqKI9PbA
 //ujtzHW5RLP73ULsEXF9ppK0ezeHS7fksemrf6E/v4Qz6vsQK3CE3iGquTDwbQ1RFBBCUmd6Y9
 V
X-Gm-Gg: ASbGncvKkY807sKI2fvGGmUjELMCRd8iFQZ/rrKBjRGdVrbBzGqC8X0Mu2+pmwXcSz8
 Y5EQy8jBxoTZeNECPDNSMj+0cuKaD33a3x+VECpBcCFCzvFd33fy/S1YEewsAHCItlsqrpy96mx
 gMUL04ZJh8iA9LCWeUCdkDE87G+foCDKUdMvsCUwSo6Ze3R2btHzp8+/zvMKgrGoUZQmfHCVNG1
 +ctOhhAxNbDhXCNVOUuuwfwO92Onps/LYxRMtiyCWHSyXX95p/ZW46wbSo1zsNepdh4xaYISbeQ
 EK08xKUOkMpjE/FhS+4COMiKa/2P25qRR3Krefl9nrGRnHNN
X-Google-Smtp-Source: AGHT+IEZ+2nYerYK8b1pBGkR6GOp7PHOyjS/5gf/irijetKjjlf7Ujvgvf/MLtrXkbFKrk9B8GpFsg==
X-Received: by 2002:a05:690c:6902:b0:6fd:a161:ad02 with SMTP id
 00721157ae682-6febf3dff88mr20198717b3.33.1741303390173; 
 Thu, 06 Mar 2025 15:23:10 -0800 (PST)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c260sm4820617b3.6.2025.03.06.15.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 15:23:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 06/10] test/py: Rework test_eficonfig to not use virt-make-fs
Date: Thu,  6 Mar 2025 17:17:08 -0600
Message-ID: <20250306232256.4150882-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306232256.4150882-1-trini@konsulko.com>
References: <20250306232256.4150882-1-trini@konsulko.com>
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
---
I noted to Heinrich in private that this test is currently disabled. I
re-enabled it locally to verify that the disk image is created correctly
still.

Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 .../{test_eficonfig => }/test_eficonfig.py    | 53 ++++++++++++++++---
 test/py/tests/test_eficonfig/conftest.py      | 40 --------------
 2 files changed, 46 insertions(+), 47 deletions(-)
 rename test/py/tests/{test_eficonfig => }/test_eficonfig.py (89%)
 delete mode 100644 test/py/tests/test_eficonfig/conftest.py

diff --git a/test/py/tests/test_eficonfig/test_eficonfig.py b/test/py/tests/test_eficonfig.py
similarity index 89%
rename from test/py/tests/test_eficonfig/test_eficonfig.py
rename to test/py/tests/test_eficonfig.py
index d98de5249dfd..caccd1f42190 100644
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
-def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
+def test_efi_eficonfig(u_boot_console):
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
+            fsfile = fs_helper.mk_fs(u_boot_console.config, 'vfat', 0x100000,
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
@@ -57,12 +101,6 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
 
     Args:
         u_boot_console -- U-Boot console
-        efi__data -- Path to the disk image used for testing.
-                     Test disk image has following files.
-                         initrd-1.img
-                         initrd-2.img
-                         initrddump.efi
-
     """
     # This test passes for unknown reasons in the bowels of U-Boot. It needs to
     # be replaced with a unit test.
@@ -71,6 +109,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
     # Restart the system to clean the previous state
     u_boot_console.restart_uboot()
 
+    efi_eficonfig_data = prepare_image(u_boot_console.config)
     with u_boot_console.temporary_timeout(500):
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

