Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA6CC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB6FE81DCC;
	Thu, 20 Mar 2025 15:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AbRAk6qc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D19AF8197D; Thu, 20 Mar 2025 15:00:43 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53AFD81C64
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:00:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso1368736a91.1
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742479240; x=1743084040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=92hn0JylhIht+PIDwZvxswKIL0u64OT8rpH56p/7Z/s=;
 b=AbRAk6qcxVfljnQVf0u604k7ZVJck8g3n2CcTH/mNHePhs06KvwCeIBHU1Tk6HEJg3
 TkO2QquLxYKptw+D7sYLFS1luoArsvgMdKcKOxyA96YFWoB+jVEhDZFkxOpF/vcatGbN
 mf5gwb7x02Y2r9wnOyrZzSxJooBlm7z5D9Mq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742479240; x=1743084040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=92hn0JylhIht+PIDwZvxswKIL0u64OT8rpH56p/7Z/s=;
 b=R71pPOOuPtix5o5Hr+Am97TKvOyVyhSyxCQ9DjVXyTadukpiwQ4oJIcGKru97S4orx
 MMX5y1y4IUPue/eRaAy/5BbbP1To11Vy2Dh7jgqqKkEood7i3iKfhSBReGlPTOWz5sUM
 tZ7jEgrNuX7WKAmpqesVS6JQ+ORsrpUCyM/b+HgjRALf9SMOdZ+G2QfSI+O05cbQr6s+
 D2tzydzo96BwPZQ48t8C55LtFIFsuairyNghixSltUq6lq6WGjsV8q57Le5M+N2dxduV
 0ld3ATWBiycTBoZsH19/nnSpan9GQ4hZGMTSG/RV+9T1NnmLM77IIBg+/R6Ivrg0TGxj
 HSaA==
X-Gm-Message-State: AOJu0YzvKzYADjweqCpIU88AyB8K/KWt/uUjsE+TKWdyp6u+emRTVoau
 qTPEoTaWuVdtb1JfbK8oX9dWFoSyz8WH+3A9vaMMNiMjr1XYZFsTp+2ar8QPFZ8cPACIgvOtW0Y
 g
X-Gm-Gg: ASbGnctfI6/bwC0kxPGz/dTE2myoodayLP89/aq/Rr/eEmw2Gef5wwaOtLgUzumNd5J
 0IszzmtD3zF6sg0qSOPrBEDensMsxgnGmU7ZWPSJL856QkN5AEcAd5n0dlrdy+9E3TBtmNIhYJp
 y2IE8NcAJQ18kMtGPLUGRnFyh6SHdEhS9w87LRUNbEpZVUZWQf7+KPI7UTxwVmdIlx7OtbRqU+X
 QtXt3imvwuXory9Qcs3kEGy+7avzK3U7GR4wSpFTH1GL4+iKb9Iwcx1Qgr4X6M+11EKadQGShPZ
 LyNAQFudvNmPXh0jBS8Ks/mq/l+Ac521yEuIL2hX+DBdMVNh
X-Google-Smtp-Source: AGHT+IHN0bR/v53YU/qlLgLN/tomPif5rMeDv01ICDBPwel8XpwksALfgBk/9EMeg0LjPFIgWeIi/A==
X-Received: by 2002:a17:90b:1fce:b0:301:1bce:c258 with SMTP id
 98e67ed59e1d1-301d5326e50mr4318727a91.22.1742479239262; 
 Thu, 20 Mar 2025 07:00:39 -0700 (PDT)
Received: from bill-the-cat.. ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf59cd49sm3857532a91.22.2025.03.20.07.00.38
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:00:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 05/10] test/py: Rework test_efi_bootmgr to not use
 virt-make-fs
Date: Thu, 20 Mar 2025 07:59:26 -0600
Message-ID: <20250320140030.2052434-6-trini@konsulko.com>
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
---
 test/py/tests/test_efi_bootmgr.py             | 70 +++++++++++++++++++
 test/py/tests/test_efi_bootmgr/conftest.py    | 38 ----------
 .../test_efi_bootmgr/test_efi_bootmgr.py      | 44 ------------
 3 files changed, 70 insertions(+), 82 deletions(-)
 create mode 100644 test/py/tests/test_efi_bootmgr.py
 delete mode 100644 test/py/tests/test_efi_bootmgr/conftest.py
 delete mode 100644 test/py/tests/test_efi_bootmgr/test_efi_bootmgr.py

diff --git a/test/py/tests/test_efi_bootmgr.py b/test/py/tests/test_efi_bootmgr.py
new file mode 100644
index 000000000000..4c10cbdf17de
--- /dev/null
+++ b/test/py/tests/test_efi_bootmgr.py
@@ -0,0 +1,70 @@
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
+def test_efi_bootmgr(ubman):
+    """ Unit test for UEFI bootmanager
+    The efidebug command is used to set up UEFI load options.
+    The bootefi bootmgr loads initrddump.efi as a payload.
+    The crc32 of the loaded initrd.img is checked
+
+    Args:
+        ubman -- U-Boot console
+    """
+    try:
+        efi_bootmgr_data, mnt = fs_helper.setup_image(ubman, 0, 0xc,
+                                                      basename='test_efi_bootmgr')
+
+        with open(mnt + '/initrd-1.img', 'w', encoding = 'ascii') as file:
+            file.write("initrd 1")
+
+        with open(mnt + '/initrd-2.img', 'w', encoding = 'ascii') as file:
+            file.write("initrd 2")
+
+        shutil.copyfile(ubman.config.build_dir + '/lib/efi_loader/initrddump.efi',
+                        mnt + '/initrddump.efi')
+
+        fsfile = fs_helper.mk_fs(ubman.config, 'vfat', 0x100000,
+                                 'test_efi_bootmgr', mnt)
+        check_call(f'dd if={fsfile} of={efi_bootmgr_data} bs=1M seek=1', shell=True)
+
+        ubman.run_command(cmd = f'host bind 0 {efi_bootmgr_data}')
+
+        ubman.run_command(cmd = 'efidebug boot add ' \
+            '-b 0001 label-1 host 0:1 initrddump.efi ' \
+            '-i host 0:1 initrd-1.img -s nocolor')
+        ubman.run_command(cmd = 'efidebug boot dump')
+        ubman.run_command(cmd = 'efidebug boot order 0001')
+        ubman.run_command(cmd = 'bootefi bootmgr')
+        response = ubman.run_command(cmd = 'load', wait_for_echo=False)
+        assert 'crc32: 0x181464af' in response
+        ubman.run_command(cmd = 'exit', wait_for_echo=False)
+
+        ubman.run_command(cmd = 'efidebug boot add ' \
+            '-B 0002 label-2 host 0:1 initrddump.efi ' \
+            '-I host 0:1 initrd-2.img -s nocolor')
+        ubman.run_command(cmd = 'efidebug boot dump')
+        ubman.run_command(cmd = 'efidebug boot order 0002')
+        ubman.run_command(cmd = 'bootefi bootmgr')
+        response = ubman.run_command(cmd = 'load', wait_for_echo=False)
+        assert 'crc32: 0x811d3515' in response
+        ubman.run_command(cmd = 'exit', wait_for_echo=False)
+
+        ubman.run_command(cmd = 'efidebug boot rm 0001')
+        ubman.run_command(cmd = 'efidebug boot rm 0002')
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
index 8800e9de5b4c..000000000000
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
-def test_efi_bootmgr(ubman, efi_bootmgr_data):
-    """ Unit test for UEFI bootmanager
-    The efidebug command is used to set up UEFI load options.
-    The bootefi bootmgr loads initrddump.efi as a payload.
-    The crc32 of the loaded initrd.img is checked
-
-    Args:
-        ubman -- U-Boot console
-        efi_bootmgr_data -- Path to the disk image used for testing.
-    """
-    ubman.run_command(cmd = f'host bind 0 {efi_bootmgr_data}')
-
-    ubman.run_command(cmd = 'efidebug boot add ' \
-        '-b 0001 label-1 host 0:1 initrddump.efi ' \
-        '-i host 0:1 initrd-1.img -s nocolor')
-    ubman.run_command(cmd = 'efidebug boot dump')
-    ubman.run_command(cmd = 'efidebug boot order 0001')
-    ubman.run_command(cmd = 'bootefi bootmgr')
-    response = ubman.run_command(cmd = 'load', wait_for_echo=False)
-    assert 'crc32: 0x181464af' in response
-    ubman.run_command(cmd = 'exit', wait_for_echo=False)
-
-    ubman.run_command(cmd = 'efidebug boot add ' \
-        '-B 0002 label-2 host 0:1 initrddump.efi ' \
-        '-I host 0:1 initrd-2.img -s nocolor')
-    ubman.run_command(cmd = 'efidebug boot dump')
-    ubman.run_command(cmd = 'efidebug boot order 0002')
-    ubman.run_command(cmd = 'bootefi bootmgr')
-    response = ubman.run_command(cmd = 'load', wait_for_echo=False)
-    assert 'crc32: 0x811d3515' in response
-    ubman.run_command(cmd = 'exit', wait_for_echo=False)
-
-    ubman.run_command(cmd = 'efidebug boot rm 0001')
-    ubman.run_command(cmd = 'efidebug boot rm 0002')
-- 
2.43.0

