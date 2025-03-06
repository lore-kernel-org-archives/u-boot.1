Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C42C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68ABD812BB;
	Fri,  7 Mar 2025 00:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N+9UsqmR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08FE5812D9; Fri,  7 Mar 2025 00:23:11 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31000810F5
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6f9625c0fccso12374447b3.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 15:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741303385; x=1741908185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RMfZ2dj67fmwiJN6zNAFlaNoTShxWh/Iof3DvhalJfo=;
 b=N+9UsqmRplmcaqhwM3fRV6Df9uM04BncvQY8aVr5P9u24wLmC206G8KxbjmrA4RcJr
 QvD0DZKq7IHQ9i69T0gygoy7nYhaDkDUJxki103/3mVXt/hJJEignOkNGjwd0gpkiSWL
 TuNyGVEqi3gcvd0gsoA+8dnKrfg4eZua8ffoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303385; x=1741908185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RMfZ2dj67fmwiJN6zNAFlaNoTShxWh/Iof3DvhalJfo=;
 b=COMIlk8P512cY8m0MvTC9C1ta1OPhzZ8oqDvzs6cXmLJqQB5GS1j5P+Alhg8XveEJU
 JSmFgoaGJMHMDIWKoQH7MwMsUOZ1/NbIJLFk5oTd0MsUIbjM/8Q3Pw0dfuLUrPIh3iAS
 0EntJngXkufkbGjYm8h1yujcgvDFYegYVygOW1gf0cl6TzkSGMHsGbEKJYosRpJnfzXr
 w00s862ZzSg5zqifrsZqNNbrAVK63T4Wdcr1TaY31UhS9QfmLsKwnjSShLwTpQiaJIV6
 lRU9wJ1WZC3kJsATA2XzgFQ2QajFybGr3LKpLbZdGsQXk+AbPFeCDunWAcltr0zMFRTw
 /HMw==
X-Gm-Message-State: AOJu0YxJpdy1nH09VABywcwruDIwHBvvEGP4OnJkx2wcnCGlRFKzcuKd
 zVBJ0Pd0RZMVRTipE835lOifqHbW/J6h/3+To6e0y370y+jsY812Uh6NuLcxDzqoUwNfd8c42m/
 G
X-Gm-Gg: ASbGncvcdhohLFq+UCV4FkNeZOaHGZUjr+Q6kc3ipO0VKQ0HNEut47lbJ2u8O7fTZqF
 1B+va5sSkIF+GQvJiE8vXFdaOxoEQZJnWJgWCJtcMETobXch2e1y/j9gfCt38UdDYR+Ir/ZbhTk
 ugqv6xipkRr1kDbD1fIK9k30BeVI+/1kAYVry7rZgFVuVa3ENYw66q0ngL2uU7SaSwNKABrprUM
 FSY2qMJb2jri4QJeTAwvp8b8mhdfN2d73xspQI1KUkH2ZD88ofS2Go/rQLW1V+lfklmILPLSYqV
 jiOMb3KQEq6wNbOe0rm1E7AouupZAI4KRnM/TaSy3Emoxd7f
X-Google-Smtp-Source: AGHT+IFmS3EN5yHsgb5qVO3GIB+CFnJBGXUxqmGHuTUQoUykeL9Vj0UPnXjIHmBJIZa4O37jMKz92w==
X-Received: by 2002:a05:690c:4c07:b0:6fb:b3c1:b97b with SMTP id
 00721157ae682-6febf2a7317mr18449987b3.4.1741303385015; 
 Thu, 06 Mar 2025 15:23:05 -0800 (PST)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c260sm4820617b3.6.2025.03.06.15.23.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 15:23:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 02/10] test/py: Rework test_xxd to not use virt-make-fs
Date: Thu,  6 Mar 2025 17:17:04 -0600
Message-ID: <20250306232256.4150882-3-trini@konsulko.com>
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
 test/py/tests/test_xxd.py          | 40 ++++++++++++++++++++++++++++++
 test/py/tests/test_xxd/conftest.py | 36 ---------------------------
 test/py/tests/test_xxd/test_xxd.py | 23 -----------------
 3 files changed, 40 insertions(+), 59 deletions(-)
 create mode 100644 test/py/tests/test_xxd.py
 delete mode 100644 test/py/tests/test_xxd/conftest.py
 delete mode 100644 test/py/tests/test_xxd/test_xxd.py

diff --git a/test/py/tests/test_xxd.py b/test/py/tests/test_xxd.py
new file mode 100644
index 000000000000..287ba0cf0346
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
+def test_xxd(u_boot_console):
+    """ Unit test for xxd
+
+    Args:
+        u_boot_console -- U-Boot console
+    """
+    try:
+        scratch_dir = u_boot_console.config.persistent_data_dir + '/scratch'
+
+        check_call('mkdir -p %s' % scratch_dir, shell=True)
+
+        with open(scratch_dir + '/hello', 'w', encoding = 'ascii') as file:
+            file.write('hello world\n\x00\x01\x02\x03\x04\x05')
+
+        xxd_data = fs_helper.mk_fs(u_boot_console.config, 'vfat', 0x100000,
+                                   'test_xxd', scratch_dir)
+        response = u_boot_console.run_command_list([ f'host bind 0 {xxd_data}',
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
index 06b9cfc00034..000000000000
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
-def test_xxd(u_boot_console, xxd_data):
-    """ Unit test for xxd
-
-    Args:
-        u_boot_console -- U-Boot console
-        xxd_data -- Path to the disk image used for testing.
-    """
-    response = u_boot_console.run_command_list([
-        f'host bind 0 {xxd_data}',
-        'xxd host 0 hello'])
-
-    assert '00000000: 68 65 6c 6c 6f 20 77 6f 72 6c 64 0a 00 01 02 03  hello world.....\r\r\n' + \
-           '00000010: 04 05                                            ..' \
-           in response
-- 
2.43.0

