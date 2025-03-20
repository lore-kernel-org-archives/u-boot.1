Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D214C35FFF
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E071A81CFD;
	Thu, 20 Mar 2025 15:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XWITC87w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 631CF8001F; Thu, 20 Mar 2025 15:00:41 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 091B080540
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-300f92661fcso1357025a91.3
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742479237; x=1743084037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tJ2milIbxDjst9EkRnyM7TazyI1kNRKz08/wP0e4mUY=;
 b=XWITC87wA4kI4yFXGo4IgvNwP7dZlaDTot9s3Rt2PFkxUhxYbPyYp6jccWpIgK2Qoa
 EcYjCIhQCv0z5lgbO+MkHRR0ndCLpPq229ZIqzGX159lFZxTyHrJUFwFiHr4gwwnJJ1S
 cVO9YVCZWU17xJvIX5zXbVX0ySzNaBswPJz4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742479237; x=1743084037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJ2milIbxDjst9EkRnyM7TazyI1kNRKz08/wP0e4mUY=;
 b=N+hLrJifFuTdiUUvFQVja3/J3F+XaHHiNu7HdSr3QVKtpr/q0fbD4dYlagWheoZcTr
 hn+11pgDBLElSlt2puduCRB/28FzNydDQY6iyjucan0INra5qIauIPDNKAT1QVUnZBs7
 gOrXTt1lx9tn6sc7GHq2oe8VY802Jt+q31Yyw6x8DCQdHzq8NINkLUsgKLe5ZgwGaNEA
 GF0C5Mwpy0ntoZ6LFqVZaRIWxfH4IPvlPODk+SxsyQ7ai91lQKxc3viT8f5GflOXqqCZ
 /YZmQRE1Nu23Osn8N0LzRCDrbJv54altheKfbKEJ0kh/wXOHffc7jXb6tknTnjUwLriZ
 ZuZg==
X-Gm-Message-State: AOJu0YzTpSCxKekW/vnc0UMNgKaxCiocq9pTonL80+XNTN8ERdO0kCJ5
 fRUFv2Cbo86UPGMb4jft6vCUsvM7fNAlRkdw+Xz0f2WrdwEh86BNRY/67I6OtTk75FbhwIKK6BD
 y
X-Gm-Gg: ASbGncvi56bEGSo/uiONXxZzxdV0tXLVg836aQZMJ0vq+5eWf92pUQIvFJtRh1G2Fpr
 Y3gQynQyahe6Dv7BOenrtrEBkjQYjGixEdc+/i6tGjlv5s/uSSEqiwtw9A4oT6bx7QgMAwOJPcm
 KUKHryOWPSyywqBSvbBtKI+DAkFFosN+Jngu94ypocH8bfw3EuwZciqGRJ92fQ2Y+PMCa8i8Lq9
 9FQ9Nwgay7CYR2SeN/qD+7jUkLcFFTRQGk5arqdca7nN/f+YwCoB4D/b0z2jGYM721LFWkKzDyZ
 M0AoU1SSb8sDaLEzdT28Drb9f9GTsVx4QOrLfvVgU+ZTl8qm
X-Google-Smtp-Source: AGHT+IF97r3SXVaHJnGxNR1Y4xTtqqNg2dAypo6Kyb+R6+igmIieUlitC9qHvJyJOxNITrnRBjtC6Q==
X-Received: by 2002:a17:90b:1f86:b0:2ea:5dea:eb0a with SMTP id
 98e67ed59e1d1-301d5076050mr5076116a91.4.1742479236520; 
 Thu, 20 Mar 2025 07:00:36 -0700 (PDT)
Received: from bill-the-cat.. ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf59cd49sm3857532a91.22.2025.03.20.07.00.35
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:00:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 02/10] test/py: Rework test_xxd to not use virt-make-fs
Date: Thu, 20 Mar 2025 07:59:23 -0600
Message-ID: <20250320140030.2052434-3-trini@konsulko.com>
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
 test/py/tests/test_xxd.py          | 40 ++++++++++++++++++++++++++++++
 test/py/tests/test_xxd/conftest.py | 36 ---------------------------
 test/py/tests/test_xxd/test_xxd.py | 23 -----------------
 3 files changed, 40 insertions(+), 59 deletions(-)
 create mode 100644 test/py/tests/test_xxd.py
 delete mode 100644 test/py/tests/test_xxd/conftest.py
 delete mode 100644 test/py/tests/test_xxd/test_xxd.py

diff --git a/test/py/tests/test_xxd.py b/test/py/tests/test_xxd.py
new file mode 100644
index 000000000000..c457c54146cd
--- /dev/null
+++ b/test/py/tests/test_xxd.py
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier:      GPL-2.0+
+
+""" Unit test for xxd command
+"""
+
+import pytest
+from subprocess import call, check_call, CalledProcessError
+from tests import fs_helper
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_xxd')
+def test_xxd(ubman):
+    """ Unit test for xxd
+
+    Args:
+        ubman -- U-Boot console
+    """
+    try:
+        scratch_dir = ubman.config.persistent_data_dir + '/scratch'
+
+        check_call('mkdir -p %s' % scratch_dir, shell=True)
+
+        with open(scratch_dir + '/hello', 'w', encoding = 'ascii') as file:
+            file.write('hello world\n\x00\x01\x02\x03\x04\x05')
+
+        xxd_data = fs_helper.mk_fs(ubman.config, 'vfat', 0x100000,
+                                   'test_xxd', scratch_dir)
+        response = ubman.run_command_list([ f'host bind 0 {xxd_data}',
+                                                    'xxd host 0 hello'])
+
+        assert '00000000: 68 65 6c 6c 6f 20 77 6f 72 6c 64 0a 00 01 02 03  hello world.....\r\r\n' + \
+               '00000010: 04 05                                            ..' \
+               in response
+    except CalledProcessError as err:
+        pytest.skip('Preparing test_xxd image failed')
+        call('rm -f %s' % xxd_data, shell=True)
+        return
+    finally:
+        call('rm -rf %s' % scratch_dir, shell=True)
+        call('rm -f %s' % xxd_data, shell=True)
diff --git a/test/py/tests/test_xxd/conftest.py b/test/py/tests/test_xxd/conftest.py
deleted file mode 100644
index 47c7cce1aa9f..000000000000
--- a/test/py/tests/test_xxd/conftest.py
+++ /dev/null
@@ -1,36 +0,0 @@
-# SPDX-License-Identifier:      GPL-2.0+
-
-"""Fixture for xxd command test
-"""
-
-import os
-import shutil
-from subprocess import check_call, CalledProcessError
-import pytest
-
-@pytest.fixture(scope='session')
-def xxd_data(u_boot_config):
-    """Set up a file system to be used in xxd tests
-
-    Args:
-        u_boot_config -- U-Boot configuration.
-    """
-    mnt_point = u_boot_config.persistent_data_dir + '/test_xxd'
-    image_path = u_boot_config.persistent_data_dir + '/xxd.img'
-
-    try:
-        os.mkdir(mnt_point, mode = 0o755)
-
-        with open(mnt_point + '/hello', 'w', encoding = 'ascii') as file:
-            file.write('hello world\n\x00\x01\x02\x03\x04\x05')
-
-        check_call(f'virt-make-fs --partition=gpt --size=+1M --type=vfat {mnt_point} {image_path}',
-                   shell=True)
-
-        yield image_path
-    except CalledProcessError:
-        pytest.skip('Setup failed')
-    finally:
-        shutil.rmtree(mnt_point)
-        if os.path.exists(image_path):
-            os.remove(image_path)
diff --git a/test/py/tests/test_xxd/test_xxd.py b/test/py/tests/test_xxd/test_xxd.py
deleted file mode 100644
index c04bf8b7a258..000000000000
--- a/test/py/tests/test_xxd/test_xxd.py
+++ /dev/null
@@ -1,23 +0,0 @@
-# SPDX-License-Identifier:      GPL-2.0+
-
-""" Unit test for xxd command
-"""
-
-import pytest
-
-@pytest.mark.boardspec('sandbox')
-@pytest.mark.buildconfigspec('cmd_xxd')
-def test_xxd(ubman, xxd_data):
-    """ Unit test for xxd
-
-    Args:
-        ubman -- U-Boot console
-        xxd_data -- Path to the disk image used for testing.
-    """
-    response = ubman.run_command_list([
-        f'host bind 0 {xxd_data}',
-        'xxd host 0 hello'])
-
-    assert '00000000: 68 65 6c 6c 6f 20 77 6f 72 6c 64 0a 00 01 02 03  hello world.....\r\r\n' + \
-           '00000010: 04 05                                            ..' \
-           in response
-- 
2.43.0

