Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74EEC282EC
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4A6E81417;
	Fri,  7 Mar 2025 00:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jCjy1vOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34844805D7; Fri,  7 Mar 2025 00:23:08 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DDB0810DC
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6fd80f30ba5so9348337b3.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 15:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741303384; x=1741908184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=svIwMFZePZWF+6jWXthpiUmpfQHGdbFGIL1DrQOEMJI=;
 b=jCjy1vOsfCNJT1knE1rGLOsnusVADmbYypr21GUYrDZYvEwDuWK4DddSpVa2ZO5hUp
 BmTlJDYdoFiKb8bETdItgztuG0QGCIqqp05W63g3FQR7Yvmxk/c1Nh2EuWIrEDWnRFY/
 xQPftI9isojKULjNNhHvm3fuJN29ouDNSpkx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303384; x=1741908184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=svIwMFZePZWF+6jWXthpiUmpfQHGdbFGIL1DrQOEMJI=;
 b=sS9mbzmk7wNiFleqWAzfw57Qv2dV5HZ05FgOSjyk/4dOkyy8/1Od5ooCH98XMDOXuK
 L9rnVuRODna1e7x8sNbTAl/H4mmh1JdEkFjIHrsFgjfWWj9DcbxX/3jjAiaQr863E4X0
 rmJF+D1AXw//ybsqWn2JeS118Uz7wMPzZJabKAqdEvIEu+cVdN/SyxaZIzMFRslCFnqk
 /8DqhY1gd8yS12MBP4rHdaEIHAfAurgU5R38AOvEChwULCDu4Rho9wxjKLFAoJdjLEzf
 0kxb/jb9yVh4vNOAQcosgRDFmCI4fwieab4pNJz91wlwCUndWxEVa2gI6VBqehl256bW
 HPGw==
X-Gm-Message-State: AOJu0YzBCAN1+8DSy3Qr5GtXh9hx6bES6hc1+6hYRURhOqfpKau1ULc7
 nBAh6fDjgJkq6lkl1nLuaBEtzi+hpksBGpSU7u4meaJ7BhVJhb8sOhsM5EIcZwv7AraWjojBw/h
 4
X-Gm-Gg: ASbGncswGn/LFgjLkns3z1xbjr7Lsbrfwi8hsqj1egKm+kB1jq/awhFOjUO+y2zX5gg
 //SgXcxm9U1KC9RLfvJ6sfz7Xp8QrTJCkZsIz0N0JbrnP/SkY0CZYj75xQiahXHR+3l9dU+zRgC
 wbgXmVWjNF29liTYoXmONUWl1lkqqMopORfkjfpaLGxoW9Ly2zOdWACx2zn1Dl2jdI+28OravB/
 oI7kmfgHicWarkhxtsHHmH6s8KHVWxHHWvIqWAXUsNm/prcggNAZQsda0mzk5gidycWurGplkQJ
 EZw6XdkJ65RZT6y5g7WJvhCSxOmEuQyMcyTqCWNC1uT/z+XV
X-Google-Smtp-Source: AGHT+IEocwnBmYltKarE2TSyfm51fa9XqSR+DZllPARWdmJfS37if/dfM/FN0Z+QISdjiCAkA1+sdg==
X-Received: by 2002:a05:690c:4988:b0:6fb:4648:3425 with SMTP id
 00721157ae682-6febf2b5e12mr22499097b3.16.1741303383914; 
 Thu, 06 Mar 2025 15:23:03 -0800 (PST)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c260sm4820617b3.6.2025.03.06.15.23.03
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 15:23:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 01/10] test/py: Rework test_cat to not use virt-make-fs
Date: Thu,  6 Mar 2025 17:17:03 -0600
Message-ID: <20250306232256.4150882-2-trini@konsulko.com>
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
 test/py/tests/test_cat.py          | 37 ++++++++++++++++++++++++++++++
 test/py/tests/test_cat/conftest.py | 36 -----------------------------
 test/py/tests/test_cat/test_cat.py | 20 ----------------
 3 files changed, 37 insertions(+), 56 deletions(-)
 create mode 100644 test/py/tests/test_cat.py
 delete mode 100644 test/py/tests/test_cat/conftest.py
 delete mode 100644 test/py/tests/test_cat/test_cat.py

diff --git a/test/py/tests/test_cat.py b/test/py/tests/test_cat.py
new file mode 100644
index 000000000000..8b545e9de255
--- /dev/null
+++ b/test/py/tests/test_cat.py
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier:      GPL-2.0+
+
+""" Unit test for cat command
+"""
+
+import pytest
+from subprocess import call, check_call, CalledProcessError
+from tests import fs_helper
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_cat')
+def test_cat(u_boot_console):
+    """ Unit test for cat
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
+            file.write('hello world\n')
+
+        cat_data = fs_helper.mk_fs(u_boot_console.config, 'vfat', 0x100000,
+                                   'test_cat', scratch_dir)
+        response = u_boot_console.run_command_list([ f'host bind 0 {cat_data}',
+                                                    'cat host 0 hello'])
+        assert 'hello world' in response
+    except CalledProcessError as err:
+        pytest.skip('Preparing test_cat image failed')
+        call('rm -f %s' % cat_data, shell=True)
+        return
+    finally:
+        call('rm -rf %s' % scratch_dir, shell=True)
+        call('rm -f %s' % cat_data, shell=True)
diff --git a/test/py/tests/test_cat/conftest.py b/test/py/tests/test_cat/conftest.py
deleted file mode 100644
index 320e7ebd295f..000000000000
--- a/test/py/tests/test_cat/conftest.py
+++ /dev/null
@@ -1,36 +0,0 @@
-# SPDX-License-Identifier:      GPL-2.0+
-
-"""Fixture for cat command test
-"""
-
-import os
-import shutil
-from subprocess import check_call, CalledProcessError
-import pytest
-
-@pytest.fixture(scope='session')
-def cat_data(u_boot_config):
-    """Set up a file system to be used in cat tests
-
-    Args:
-        u_boot_config -- U-Boot configuration.
-    """
-    mnt_point = u_boot_config.persistent_data_dir + '/test_cat'
-    image_path = u_boot_config.persistent_data_dir + '/cat.img'
-
-    try:
-        os.mkdir(mnt_point, mode = 0o755)
-
-        with open(mnt_point + '/hello', 'w', encoding = 'ascii') as file:
-            file.write('hello world\n')
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
diff --git a/test/py/tests/test_cat/test_cat.py b/test/py/tests/test_cat/test_cat.py
deleted file mode 100644
index 132527bd4c29..000000000000
--- a/test/py/tests/test_cat/test_cat.py
+++ /dev/null
@@ -1,20 +0,0 @@
-# SPDX-License-Identifier:      GPL-2.0+
-
-""" Unit test for cat command
-"""
-
-import pytest
-
-@pytest.mark.boardspec('sandbox')
-@pytest.mark.buildconfigspec('cmd_cat')
-def test_cat(u_boot_console, cat_data):
-    """ Unit test for cat
-
-    Args:
-        u_boot_console -- U-Boot console
-        cat_data -- Path to the disk image used for testing.
-    """
-    response = u_boot_console.run_command_list([
-        f'host bind 0 {cat_data}',
-        'cat host 0 hello'])
-    assert 'hello world' in response
-- 
2.43.0

