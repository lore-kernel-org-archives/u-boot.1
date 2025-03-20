Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E979C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E9F8141E;
	Thu, 20 Mar 2025 15:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TfJQuMAA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D87C81C67; Thu, 20 Mar 2025 15:00:41 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 021FD8001F
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso1731017a91.1
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742479237; x=1743084037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g75aXt1aH5AIFlpvv4f32MF1HPtVtWRZ+XKOeTQjerM=;
 b=TfJQuMAARn47Mpzs6J+AK7gYhJEQJwM5L5+pIlpytypm69G91w9S27/Q6T4ooSphyf
 bKYwrym+niuv9N1D/CNjqJHMbXLj5zJHiIx5SNARa2j090pxPi7/FURkvAojw/R6Y4Yz
 kRx0JQh3Dim4wvNmIca+L+xvIyiP40W/G+TDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742479237; x=1743084037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g75aXt1aH5AIFlpvv4f32MF1HPtVtWRZ+XKOeTQjerM=;
 b=IMG5sAXT6pjDkga6I/jgkY+z9bR2RX0BaUDmqenr6izAtpGaTgsiLtO0FkdIGovngY
 AMgoiFbB6CXJ0pycd8sPBJ9C/PgwRyP1FJme60p682AHjg3m3d5bTxKenRKMxM5Itv3t
 74fiWGgwydBj4IWz8bBdX9UBE6rL9yvJD7cxEvRXojGfyW+9CkYkvB+RFV5YGXWzl/9n
 ysVXg2hX0MrDjxbqABfupRUXkUAiPeB4bNJuZA7ARQdR50gLcCKNps9r0yEwbe4RwB2n
 Y/GHHbxo97k91Q3Vg03aCv4TfZTe1Z0kA7dMsWXGvwFoq3AmMfbuue0bNkKubbbKU+Lu
 mFlA==
X-Gm-Message-State: AOJu0Yz5kpaZYEjMGoKvC/5vNvvI+T8DjOowl6dVOqQsREmqqEaCsjBL
 Fh+hOYcEpGAKeJtuUNn472FbGyclIB+Ar2ddBl+/qzL4OpjUi0DCq7Rv02h+CZ/MY345ECeDNVt
 m
X-Gm-Gg: ASbGncs8wJRwPVH2/D0GqtGz9PKSYMCeRmfi86dfGIdLqh2FU9ppRQAdnqlauyqUjvA
 RQ+I5YBDq3FSdqk1lRPWnGEGeljEXDNrDhN1CBmm5/ekgOuQLPTAaO2r9HvN0A+IytXDDczYm0l
 j38oWuLTb9CLM4nWfQolfQpnlhw+N6Yut1M6dXIAZ1rKzw/1T8akIQSC0A1eJn0VOs+gmZBdoww
 JTqp00HrVmoVgym6KlnGSXEqx8i8L167iU8z6keHpAj6wONzxqRR27avClBfnw3bCgmhL4inPcS
 aBac2NVD2DUq3/8YpUESuT2MxBXAPpTioAq9JHrbF1OPXZNg
X-Google-Smtp-Source: AGHT+IEv+7L2StjKBwW55OTVWAdt2ZTq/y2Zz7hsgE2WDF5wAagya+vJJ+mTv5V94/W5zooqaXmFeA==
X-Received: by 2002:a17:90b:2641:b0:2fa:1e56:5d82 with SMTP id
 98e67ed59e1d1-301d435dcfamr5608043a91.17.1742479235518; 
 Thu, 20 Mar 2025 07:00:35 -0700 (PDT)
Received: from bill-the-cat.. ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf59cd49sm3857532a91.22.2025.03.20.07.00.34
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:00:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 01/10] test/py: Rework test_cat to not use virt-make-fs
Date: Thu, 20 Mar 2025 07:59:22 -0600
Message-ID: <20250320140030.2052434-2-trini@konsulko.com>
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
 test/py/tests/test_cat.py          | 37 ++++++++++++++++++++++++++++++
 test/py/tests/test_cat/conftest.py | 36 -----------------------------
 test/py/tests/test_cat/test_cat.py | 20 ----------------
 3 files changed, 37 insertions(+), 56 deletions(-)
 create mode 100644 test/py/tests/test_cat.py
 delete mode 100644 test/py/tests/test_cat/conftest.py
 delete mode 100644 test/py/tests/test_cat/test_cat.py

diff --git a/test/py/tests/test_cat.py b/test/py/tests/test_cat.py
new file mode 100644
index 000000000000..252c3d50a022
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
+def test_cat(ubman):
+    """ Unit test for cat
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
+            file.write('hello world\n')
+
+        cat_data = fs_helper.mk_fs(ubman.config, 'vfat', 0x100000,
+                                   'test_cat', scratch_dir)
+        response = ubman.run_command_list([ f'host bind 0 {cat_data}',
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
index 883803fece79..000000000000
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
-def test_cat(ubman, cat_data):
-    """ Unit test for cat
-
-    Args:
-        ubman -- U-Boot console
-        cat_data -- Path to the disk image used for testing.
-    """
-    response = ubman.run_command_list([
-        f'host bind 0 {cat_data}',
-        'cat host 0 hello'])
-    assert 'hello world' in response
-- 
2.43.0

