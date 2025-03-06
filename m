Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A9FC282EC
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A4B8171B;
	Fri,  7 Mar 2025 00:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X8yzQoOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB5E810F5; Fri,  7 Mar 2025 00:23:18 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2020981249
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6fd8be1e534so12370457b3.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 15:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741303389; x=1741908189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYE4won8IECfVnpBSuGXv4sbW+CpKk3SeH/UELBCwiw=;
 b=X8yzQoObEllTjhfja/4qMf0GNiCMYJP5KfrmbLqdLaQ5dmTwsLf759wSo35fFKluJ9
 yRzIi+9f8s7v1GFZ52UkF0NiClfHit6hdIKR7goLVeLrjxjbH+mhYv5JDOHKx3OBtqV8
 rlfZxEwMHGAzj0h8VP2nAT1raapU865J5IqRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303389; x=1741908189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYE4won8IECfVnpBSuGXv4sbW+CpKk3SeH/UELBCwiw=;
 b=w1KLWh9gQC0Dhre3bzJ4fZKMHKGdfSfoZ+pub6Be1WYFNisnJoX1qWN8gnRz3vRk+s
 7ARia1K4Tnz5B3Q4SYShKQX9opD2d7o9Jp774qAN9e2N3jYeuU3xLq1PlZB5ExfXF3R8
 uWkAdW3wnNp8YM5BWsVJy8RqW3RaUElHpJ8msJXPBS70yZh7JP4Q1UJ+8mMq5Wk+tOZq
 AMr2wZbpKQoHBk+IdZmQIPSTMRgWTqTWIYi52VzfZsxIYNDgTuZudIo6ugYdrPXpi06+
 erVFPireE1FbQSxqyGZQFgqPX6iRQHnpIY8Lxf1lqCsQ6szzoi/laIFsL7G+alyDxdEe
 Gmpw==
X-Gm-Message-State: AOJu0Yzjycr0d1aGJzwsBml7Fxh4Hkhp8u/rh2DIGa2QNxZN72TCHBuH
 5NuHgSo/4HYgDxac9Y4Wnr7+dN9m4CfZCwlu9RVHzSDNDdENeKekRmepwz+26JdnfV8aZSPtjxk
 M
X-Gm-Gg: ASbGnct6ngQsn0JCXlIBP3iu2s4SK0JKC4d0YkB7rHEepnd73EonTammMag84TEuEuu
 LwMM/r09006qoyBgPhIcw8BDJ8V7gNXeSRu8esGBxll6Lj4Zw4IOGQ4SUrxeSRNs76qk0mv2U2F
 XZExW9Kaf4Zy7x4D776cK0557T5R7k5hmnzPYZsr3BcMnxAJb9SYkQkrVsYG2/03EkkaQKOVmS3
 yA/sBJynj9DTg6/ldfdXojBIhmNl1FaCctXj+ZoGzRPQjECbS9UJNaPMFsSPPSxDgI3V3PcxWiJ
 ad3KtIvCsWaNOmf8Xw/yBlm+ZuyxEu/xJw2FLQe+1VfxVZcJ
X-Google-Smtp-Source: AGHT+IHEOoXhD0vh3M28Tc+VPlOj2ZoLGZE3OJ+GLCcBc0VLZqqJOkF5P1/+sAoFAh6YB7KtvS9QVA==
X-Received: by 2002:a05:690c:d19:b0:6f9:e45d:8a32 with SMTP id
 00721157ae682-6febf39bb68mr22100337b3.23.1741303388837; 
 Thu, 06 Mar 2025 15:23:08 -0800 (PST)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c260sm4820617b3.6.2025.03.06.15.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 15:23:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 05/10] test/py: Rework test_efi_bootmgr to not use virt-make-fs
Date: Thu,  6 Mar 2025 17:17:07 -0600
Message-ID: <20250306232256.4150882-6-trini@konsulko.com>
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

Signed-off-by: Tom Rini <trini@konsulko.com>
---
The default git settings don't detect the rename so well here because of
all of the spacing changes as well. I found I had to use "git show -M05
-w" in order to get something that confirmed the test itself wasn't
changed.

Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 test/py/tests/test_efi_bootmgr.py             | 71 +++++++++++++++++++
 test/py/tests/test_efi_bootmgr/conftest.py    | 38 ----------
 .../test_efi_bootmgr/test_efi_bootmgr.py      | 44 ------------
 3 files changed, 71 insertions(+), 82 deletions(-)
 create mode 100644 test/py/tests/test_efi_bootmgr.py
 delete mode 100644 test/py/tests/test_efi_bootmgr/conftest.py
 delete mode 100644 test/py/tests/test_efi_bootmgr/test_efi_bootmgr.py

diff --git a/test/py/tests/test_efi_bootmgr.py b/test/py/tests/test_efi_bootmgr.py
new file mode 100644
index 000000000000..5d75bce18b77
--- /dev/null
+++ b/test/py/tests/test_efi_bootmgr.py
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier:      GPL-2.0+
+""" Unit test for UEFI bootmanager
+"""
+
+import shutil
+import pytest
+from subprocess import call, check_call, CalledProcessError
+from tests import fs_helper
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_efidebug')
+@pytest.mark.buildconfigspec('cmd_bootefi_bootmgr')
+@pytest.mark.singlethread
+def test_efi_bootmgr(u_boot_console):
+    """ Unit test for UEFI bootmanager
+    The efidebug command is used to set up UEFI load options.
+    The bootefi bootmgr loads initrddump.efi as a payload.
+    The crc32 of the loaded initrd.img is checked
+
+    Args:
+        u_boot_console -- U-Boot console
+    """
+    try:
+        efi_bootmgr_data, mnt = fs_helper.setup_image(u_boot_console.config, 0,
+                                                      0xc,
+                                                      basename='test_efi_bootmgr')
+
+        with open(mnt + '/initrd-1.img', 'w', encoding = 'ascii') as file:
+            file.write("initrd 1")
+
+        with open(mnt + '/initrd-2.img', 'w', encoding = 'ascii') as file:
+            file.write("initrd 2")
+
+        shutil.copyfile(u_boot_console.config.build_dir + '/lib/efi_loader/initrddump.efi',
+                        mnt + '/initrddump.efi')
+
+        fsfile = fs_helper.mk_fs(u_boot_console.config, 'vfat', 0x100000,
+                                 'test_efi_bootmgr', mnt)
+        check_call(f'dd if={fsfile} of={efi_bootmgr_data} bs=1M seek=1', shell=True)
+
+        u_boot_console.run_command(cmd = f'host bind 0 {efi_bootmgr_data}')
+
+        u_boot_console.run_command(cmd = 'efidebug boot add ' \
+            '-b 0001 label-1 host 0:1 initrddump.efi ' \
+            '-i host 0:1 initrd-1.img -s nocolor')
+        u_boot_console.run_command(cmd = 'efidebug boot dump')
+        u_boot_console.run_command(cmd = 'efidebug boot order 0001')
+        u_boot_console.run_command(cmd = 'bootefi bootmgr')
+        response = u_boot_console.run_command(cmd = 'load', wait_for_echo=False)
+        assert 'crc32: 0x181464af' in response
+        u_boot_console.run_command(cmd = 'exit', wait_for_echo=False)
+
+        u_boot_console.run_command(cmd = 'efidebug boot add ' \
+            '-B 0002 label-2 host 0:1 initrddump.efi ' \
+            '-I host 0:1 initrd-2.img -s nocolor')
+        u_boot_console.run_command(cmd = 'efidebug boot dump')
+        u_boot_console.run_command(cmd = 'efidebug boot order 0002')
+        u_boot_console.run_command(cmd = 'bootefi bootmgr')
+        response = u_boot_console.run_command(cmd = 'load', wait_for_echo=False)
+        assert 'crc32: 0x811d3515' in response
+        u_boot_console.run_command(cmd = 'exit', wait_for_echo=False)
+
+        u_boot_console.run_command(cmd = 'efidebug boot rm 0001')
+        u_boot_console.run_command(cmd = 'efidebug boot rm 0002')
+    except CalledProcessError as err:
+        pytest.skip('Preparing test_efi_bootmgr image failed')
+        call('rm -f %s' % efi_bootmgr_data, shell=True)
+        return
+    finally:
+        call('rm -rf %s' % mnt, shell=True)
+        call('rm -f %s' % efi_bootmgr_data, shell=True)
diff --git a/test/py/tests/test_efi_bootmgr/conftest.py b/test/py/tests/test_efi_bootmgr/conftest.py
deleted file mode 100644
index 0eca025058ee..000000000000
--- a/test/py/tests/test_efi_bootmgr/conftest.py
+++ /dev/null
@@ -1,38 +0,0 @@
-# SPDX-License-Identifier:      GPL-2.0+
-
-"""Fixture for UEFI bootmanager test."""
-
-import os
-import shutil
-from subprocess import check_call
-import pytest
-
-@pytest.fixture(scope='session')
-def efi_bootmgr_data(u_boot_config):
-    """Set up a file system to be used in UEFI bootmanager tests.
-
-    Args:
-        u_boot_config -- U-Boot configuration.
-
-    Return:
-        A path to disk image to be used for testing
-    """
-    mnt_point = u_boot_config.persistent_data_dir + '/test_efi_bootmgr'
-    image_path = u_boot_config.persistent_data_dir + '/efi_bootmgr.img'
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
diff --git a/test/py/tests/test_efi_bootmgr/test_efi_bootmgr.py b/test/py/tests/test_efi_bootmgr/test_efi_bootmgr.py
deleted file mode 100644
index 1bb59d8fcf81..000000000000
--- a/test/py/tests/test_efi_bootmgr/test_efi_bootmgr.py
+++ /dev/null
@@ -1,44 +0,0 @@
-# SPDX-License-Identifier:      GPL-2.0+
-""" Unit test for UEFI bootmanager
-"""
-
-import pytest
-
-@pytest.mark.boardspec('sandbox')
-@pytest.mark.buildconfigspec('cmd_efidebug')
-@pytest.mark.buildconfigspec('cmd_bootefi_bootmgr')
-@pytest.mark.singlethread
-def test_efi_bootmgr(u_boot_console, efi_bootmgr_data):
-    """ Unit test for UEFI bootmanager
-    The efidebug command is used to set up UEFI load options.
-    The bootefi bootmgr loads initrddump.efi as a payload.
-    The crc32 of the loaded initrd.img is checked
-
-    Args:
-        u_boot_console -- U-Boot console
-        efi_bootmgr_data -- Path to the disk image used for testing.
-    """
-    u_boot_console.run_command(cmd = f'host bind 0 {efi_bootmgr_data}')
-
-    u_boot_console.run_command(cmd = 'efidebug boot add ' \
-        '-b 0001 label-1 host 0:1 initrddump.efi ' \
-        '-i host 0:1 initrd-1.img -s nocolor')
-    u_boot_console.run_command(cmd = 'efidebug boot dump')
-    u_boot_console.run_command(cmd = 'efidebug boot order 0001')
-    u_boot_console.run_command(cmd = 'bootefi bootmgr')
-    response = u_boot_console.run_command(cmd = 'load', wait_for_echo=False)
-    assert 'crc32: 0x181464af' in response
-    u_boot_console.run_command(cmd = 'exit', wait_for_echo=False)
-
-    u_boot_console.run_command(cmd = 'efidebug boot add ' \
-        '-B 0002 label-2 host 0:1 initrddump.efi ' \
-        '-I host 0:1 initrd-2.img -s nocolor')
-    u_boot_console.run_command(cmd = 'efidebug boot dump')
-    u_boot_console.run_command(cmd = 'efidebug boot order 0002')
-    u_boot_console.run_command(cmd = 'bootefi bootmgr')
-    response = u_boot_console.run_command(cmd = 'load', wait_for_echo=False)
-    assert 'crc32: 0x811d3515' in response
-    u_boot_console.run_command(cmd = 'exit', wait_for_echo=False)
-
-    u_boot_console.run_command(cmd = 'efidebug boot rm 0001')
-    u_boot_console.run_command(cmd = 'efidebug boot rm 0002')
-- 
2.43.0

