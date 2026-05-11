Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD83CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63CBD83C5E;
	Mon, 11 May 2026 14:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FdHBuJeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8160C84706; Mon, 11 May 2026 10:59:11 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C043846A5
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 277E53F427
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 08:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1778489949;
 bh=S6S3tmCtghAcRufgbPHFJ9gmk8ioXC1goBcILuNfLMI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=FdHBuJeCtMEVsXi1SRZ0sGWz5VGi3MGPrPUBKU8Dh4wO8MKxaEW2LvInxpDPXIguk
 5wPxhHgThLoWtbBUxjbULYLMgFJ2oge0lcHXu2PXArjaN1N0aChiCf3RcQ2HWpMm1n
 38O13XrlGG2AywHmOTVRrQzJyAwzA9QQM6eiPzfLo+1UgidhiOx6yNecSE8V0iUzOg
 nOJSHNRP8Xm9m9hBKJF/Q5M2q1oHicHkg2GkhCSVHLABYHDtgALYX8ldfkM6lspMkq
 maa9xUyDfc44eoCXHv+qVcAwJVimVcMy3AF0nSubIiPIxZQX1SQmuE8/Q52CDXIb+c
 AhXtvK/kW66BNqZCbOMORbF3JARTGOasbivCEW4QKgENjokxmCNBBGT+aF4yRAS+7A
 c3D3BWxbJnm8k1qycSF+wpi6FiCUw+p/F8PBrS19btJtteg/zcd74BhoTu47FGknEv
 Dj7uXEyb4HDkbHLEJxBF99b1IYkzRbSE3QinhZtQi7JLardqU99nhr5ItHmxnyqD4A
 BNBBmX+s7AEEkH5BV3JHoZYnDBbFxX6zn/YI5eJ1iXSnGapM2M1xB8d8VwLVplqaPB
 jkPyweILNTbcnWlJFhjl/RmDRPG98n4aw8iU/0trpX4eYL8i83IiBQF6U+yLx/XyuY
 P5S0gpE/bJzBz5vObQkZBJEQ=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-83565161a6eso2313495b3a.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 01:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778489947; x=1779094747;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6S3tmCtghAcRufgbPHFJ9gmk8ioXC1goBcILuNfLMI=;
 b=cYgiVUjeuWlkrnd0An/cqospRgIVkC3nO9UIz/itsHPRRGKqJF1MrBVK9EEOM3iJAC
 GIZhzyPxNBOL0F1qAhZY5TqEvxabA8g5jPjHs43uHiFxeVhkofww9t5CSd9L3J1TyUcO
 2hf9PDE5+B16PK7GjkwtQb9e9i5WOxkJddu7exgO43ndqxatwaJWgteeJEYKcvr41YqX
 VM38fUZuprdox48WwSlmAw3OHVCaedxG77OCr+lGePG9dryiznVpZqN/Z1wZzP+l6Yl0
 +qPOkOM8WgwgLWFECH91gv+LHo+5813svC/KXIC7b/ezpCoZFTjVTaYBxl0l749eClUr
 vb9A==
X-Gm-Message-State: AOJu0YztnUoey9ISycB+hxWW47DcEPEt4sM73lWDEFfQRSBOoYNQP9hE
 RRCx3fL9jhSq/FxOx6zlt20ElGVXGoQv7/nYJTXQ0BQvAX45g7eJNPZscssNm7TYwec5ggJzdBy
 g2X9/+mmghsp54DYfFjeuyljkghh9sIjCMN19tmlc+N/TiDTdCTdxI25xDKI9sojCwnTt5svVYo
 mvnRq1gicD
X-Gm-Gg: Acq92OHsTNha4Iav7WIgMHtlkt1nO4WRsrJZUPZ5flU2IcV+L4u8eN1cAXZlCusru6E
 LFhpdO7ClS9X8d+YgXSRd961DWJA/wTzKl8WllsdO4C6maOwgjEvauNjVGHgHV9zPlpTJLUUKvb
 V7bHYhO0BwFaZn5xRh02qt0HMQ4ukVLd56kR3fmLMaHuL9l444NFChtn71SzLlxiboJ/XYi0xt/
 WpZhsAg28ps7EHOWed6PFBLvTq/2FjeA2jEQDEtO/ne7L47d5j1ja63s9oEu6NEOWxwK8cSb9yf
 9v2dwgFaTYO/VvS5Xnq780QQfWAiYEGAKhhq9TipyWkAgkazUHicP0HXY+647ukkxsqyO3Yo73I
 Ih2J6kGoLZHMJqtdUgQl+T8YNQmjDrtcU3XMyA+ie6JQm5+vZKgftqbJu9D6PLbTI0+dnT4nTHG
 3Z4MVH49NUjaxdjD+K2+QjS1xNug==
X-Received: by 2002:a05:6a00:3e22:b0:82f:7888:e2fa with SMTP id
 d2e1a72fcca58-83bb7fb5438mr14346691b3a.17.1778489947350; 
 Mon, 11 May 2026 01:59:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e22:b0:82f:7888:e2fa with SMTP id
 d2e1a72fcca58-83bb7fb5438mr14346660b3a.17.1778489946868; 
 Mon, 11 May 2026 01:59:06 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839679c80e7sm24034367b3a.31.2026.05.11.01.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 01:59:06 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Huang Jianan <jnhuang95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-erofs@lists.ozlabs.org
Subject: [PATCH v1 1/1] test: fs: Use shared generate_file from utils
Date: Mon, 11 May 2026 08:58:50 +0000
Message-ID: <20260511085857.3933053-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 May 2026 14:50:48 +0200
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

test_fs/test_erofs.py and test_fs/test_squashfs/sqfs_common.py both
defined a generate_file() helper that writes a file of a given size
filled with 'x'. The two functions were functionally identical and
differed only in parameter names and docstrings.

Move the helper into the existing test/py/utils.py module, which is
the established home for generic test utilities (md5sum_file,
PersistentRandomFile, attempt_to_open_file). Update both call sites
to use it.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fs/test_erofs.py           | 16 ++++----------
 .../test_fs/test_squashfs/sqfs_common.py      | 22 +++++--------------
 test/py/utils.py                              | 13 +++++++++++
 3 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/test/py/tests/test_fs/test_erofs.py b/test/py/tests/test_fs/test_erofs.py
index a2bb6b505f2..cec803256ac 100644
--- a/test/py/tests/test_fs/test_erofs.py
+++ b/test/py/tests/test_fs/test_erofs.py
@@ -6,19 +6,11 @@ import os
 import pytest
 import shutil
 import subprocess
+import utils
 
 EROFS_SRC_DIR = 'erofs_src_dir'
 EROFS_IMAGE_NAME = 'erofs.img'
 
-def generate_file(name, size):
-    """
-    Generates a file filled with 'x'.
-    """
-    content = 'x' * size
-    file = open(name, 'w')
-    file.write(content)
-    file.close()
-
 def make_erofs_image(build_dir):
     """
     Makes the EROFS images used for the test.
@@ -36,15 +28,15 @@ def make_erofs_image(build_dir):
     os.makedirs(root)
 
     # 4096: uncompressed file
-    generate_file(os.path.join(root, 'f4096'), 4096)
+    utils.generate_file(os.path.join(root, 'f4096'), 4096)
 
     # 7812: Compressed file
-    generate_file(os.path.join(root, 'f7812'), 7812)
+    utils.generate_file(os.path.join(root, 'f7812'), 7812)
 
     # sub-directory with a single file inside
     subdir_path = os.path.join(root, 'subdir')
     os.makedirs(subdir_path)
-    generate_file(os.path.join(subdir_path, 'subdir-file'), 100)
+    utils.generate_file(os.path.join(subdir_path, 'subdir-file'), 100)
 
     # symlink
     os.symlink('subdir', os.path.join(root, 'symdir'))
diff --git a/test/py/tests/test_fs/test_squashfs/sqfs_common.py b/test/py/tests/test_fs/test_squashfs/sqfs_common.py
index d1621dcce3a..b366bde5f49 100644
--- a/test/py/tests/test_fs/test_squashfs/sqfs_common.py
+++ b/test/py/tests/test_fs/test_squashfs/sqfs_common.py
@@ -5,6 +5,7 @@
 import os
 import shutil
 import subprocess
+import utils
 
 """ standard test images table: Each table item is a key:value pair
 representing the output image name and its respective mksquashfs options.
@@ -66,19 +67,6 @@ def init_standard_table():
     for key, value in zip(STANDARD_TABLE.keys(), opts_list):
         STANDARD_TABLE[key] = value
 
-def generate_file(file_name, file_size):
-    """ Generates a file filled with 'x'.
-
-    Args:
-        file_name: the file's name.
-        file_size: the content's length and therefore the file size.
-    """
-    content = 'x' * file_size
-
-    file = open(file_name, 'w')
-    file.write(content)
-    file.close()
-
 def generate_sqfs_src_dir(build_dir):
     """ Generates the source directory used to make the SquashFS images.
 
@@ -107,20 +95,20 @@ def generate_sqfs_src_dir(build_dir):
 
     # 4096: minimum block size
     file_name = 'f4096'
-    generate_file(os.path.join(root, file_name), 4096)
+    utils.generate_file(os.path.join(root, file_name), 4096)
 
     # 5096: minimum block size + 1000 chars (fragment)
     file_name = 'f5096'
-    generate_file(os.path.join(root, file_name), 5096)
+    utils.generate_file(os.path.join(root, file_name), 5096)
 
     # 1000: less than minimum block size (fragment only)
     file_name = 'f1000'
-    generate_file(os.path.join(root, file_name), 1000)
+    utils.generate_file(os.path.join(root, file_name), 1000)
 
     # sub-directory with a single file inside
     subdir_path = os.path.join(root, 'subdir')
     os.makedirs(subdir_path)
-    generate_file(os.path.join(subdir_path, 'subdir-file'), 100)
+    utils.generate_file(os.path.join(subdir_path, 'subdir-file'), 100)
 
     # symlink (target: sub-directory)
     os.symlink('subdir', os.path.join(root, 'sym'))
diff --git a/test/py/utils.py b/test/py/utils.py
index ca80e4b0b0a..e8971502509 100644
--- a/test/py/utils.py
+++ b/test/py/utils.py
@@ -51,6 +51,19 @@ def md5sum_file(fn, max_length=None):
         data = fh.read(*params)
     return md5sum_data(data)
 
+def generate_file(file_name, file_size):
+    """ Generates a file filled with 'x'.
+
+    Args:
+        file_name: the file's name.
+        file_size: the content's length and therefore the file size.
+    """
+    content = 'x' * file_size
+
+    file = open(file_name, 'w')
+    file.write(content)
+    file.close()
+
 class PersistentRandomFile:
     """Generate and store information about a persistent file containing
     random data."""
-- 
2.43.0

