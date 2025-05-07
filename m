Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48345C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 22:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF9BA82991;
	Thu,  8 May 2025 00:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UAfhF2Rz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D87828B3; Thu,  8 May 2025 00:11:24 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38FEC822D7
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 00:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2c12b7af278so334297fac.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746655880; x=1747260680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdTCsdFfy5oS/446IwxaRlgg4jpAGUgz2RZ2Eiln4vg=;
 b=UAfhF2RzhbpQZ/YAVPp9drGettw6ow2+/+7TBE24YPtMZjttoJNQxRCFdofMn0Qig6
 Ja0wEShcG8Wp2BpJFVdVLzOXctihcNG5Q2ecDstX2LQk1Q1XaERcRqMn2Us2A7Es+i9n
 qaZYii1EFCAFSd7CN7FZF8jIv3LteRhm7rX4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746655880; x=1747260680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RdTCsdFfy5oS/446IwxaRlgg4jpAGUgz2RZ2Eiln4vg=;
 b=OeCdt48VQ1Kv5EnvxvXLfn97m9gSVx6Lnq/x/h5xgG1/JUPG0sfRG5EvXcwgK0nF/3
 qR3KnxocP9a5xGKjSkom7gvCmpwkLgu5OCrgcW/5cvPypX4CsR40CxzI0unPVWcFe5YU
 s2C1YnRjVgT1ApLEbDXOcXZGJkZ519gjV1M+m6e3ej1wJfbjvqq7R6BRRSOhf603T2TH
 GQRfhYHzyu3/NF8Q6NAzgsxCkRg1pnJtiq4qQGEzfR7hh+028g5/c2vNmy8uwWT1RICQ
 xVDCpf0/MkvzN3U/NokfRAtoGX8DqtvDQCDFo5OGZGCX4KAYF0Uqyj1X+5IKsXEpRJaF
 8F2A==
X-Gm-Message-State: AOJu0YygpE/xJ319x9pRiJtQQDHdsrPS8qDI6ilGq6IDSJggusxXgoCG
 YdrMnEqf62rPvuagYb0XGLJm2y1XZIT84e55YKe0JOFESImqQ2zYOE/0nAxgs5yZCVMURljF32d
 5
X-Gm-Gg: ASbGncv+Xow3U9vd0pMBmFwu/8Ou//w26zyBGvrLC0Ep/5/DMjDFvOeJFjureUM6aaJ
 TnVpsNO/I4HRp3fSvG2Ojc91rX4cp27v9qQrLa54Sr/8T308iO70/ubolgEYrk1G9LYGg+oJZ3u
 FwrDqfQUwyQCq+RIB2IwiHHoU0hVgOkFxqCrDvSmfQVsuZREgXQR+haduvYDaouOMcIWCh/NQLZ
 GUAxuhLLlLs01aRoZhrJHhgwqdlrzXBb0K+G0jTzT4g9ufV85JNea5fWjwgeVJQnxj4eGNuY5bQ
 jaF+257a5z11J8wF+6EZ6ie8JYD6WpkHMtpU+cHRgtO5hnY6nHN0g4WvkvgJYp5dA87Y3QJPKQi
 p4a3V
X-Google-Smtp-Source: AGHT+IGTm4PpT2cVaAX4O8y8qNtUUCQYz7tXKMNqOyEzUjAlTwadP/l3G4Iy7QuJROIAdfCT2dw4mw==
X-Received: by 2002:a05:6870:80d0:b0:2d5:97d0:c03c with SMTP id
 586e51a60fabf-2db80a1121fmr831633fac.18.1746655879834; 
 Wed, 07 May 2025 15:11:19 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2db5cbf16f1sm967181fac.20.2025.05.07.15.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 15:11:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/4] doc: pytest: Document the test_net_boot test
Date: Wed,  7 May 2025 16:08:19 -0600
Message-ID: <20250507221112.518041-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507221112.518041-1-trini@konsulko.com>
References: <20250225205003.2640910-1-trini@konsulko.com>
 <20250507221112.518041-1-trini@konsulko.com>
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

Add the test_net_boot.py test to the generated documentation. While most
of this was already commented correctly for inclusion the biggest
problem was examples of code without a code-block notation. This in turn
broke parsing. Add the missing notations. We also must have the comment
prior to any import lines or it will not be seen as a comment on the
overall file and thus not included.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
---
 doc/develop/pytest/index.rst         |   1 +
 doc/develop/pytest/test_net_boot.rst |   8 ++
 test/py/tests/test_net_boot.py       | 163 +++++++++++++++------------
 3 files changed, 98 insertions(+), 74 deletions(-)
 create mode 100644 doc/develop/pytest/test_net_boot.rst

diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
index ca45e157d3be..36083882584f 100644
--- a/doc/develop/pytest/index.rst
+++ b/doc/develop/pytest/index.rst
@@ -18,3 +18,4 @@ Individual tests
    :maxdepth: 1
 
    test_000_version
+   test_net_boot
diff --git a/doc/develop/pytest/test_net_boot.rst b/doc/develop/pytest/test_net_boot.rst
new file mode 100644
index 000000000000..369bd3b809cf
--- /dev/null
+++ b/doc/develop/pytest/test_net_boot.rst
@@ -0,0 +1,8 @@
+test_net_boot
+=============
+
+.. automodule:: test_net_boot
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
index abf6dfbaf5e4..6585f0574c01 100644
--- a/test/py/tests/test_net_boot.py
+++ b/test/py/tests/test_net_boot.py
@@ -1,11 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # (C) Copyright 2023, Advanced Micro Devices, Inc.
 
-import pytest
-import utils
-import test_net
-import re
-
 """
 Note: This test relies on boardenv_* containing configuration values to define
 which the network environment available for testing. Without this, this test
@@ -13,77 +8,88 @@ will be automatically skipped.
 
 For example:
 
-# Details regarding a boot image file that may be read from a TFTP server. This
-# variable may be omitted or set to None if TFTP boot testing is not possible
-# or desired.
-env__net_tftp_bootable_file = {
-    'fn': 'image.ub',
-    'addr': 0x10000000,
-    'size': 5058624,
-    'crc32': 'c2244b26',
-    'pattern': 'Linux',
-    'config': 'config@2',
-    'timeout': 50000,
-    'check_type': 'boot_error',
-    'check_pattern': 'ERROR',
-}
-
-# False or omitted if a TFTP boot test should be tested.
-# If TFTP boot testing is not possible or desired, set this variable to True.
-# For example: If FIT image is not proper to boot
-env__tftp_boot_test_skip = False
-
-# Here is the example of FIT image configurations:
-configurations {
-    default = "config@1";
-    config@1 {
-        description = "Boot Linux kernel with config@1";
-        kernel = "kernel@0";
-        fdt = "fdt@0";
-        ramdisk = "ramdisk@0";
-        hash@1 {
-            algo = "sha1";
-        };
-    };
-    config@2 {
-        description = "Boot Linux kernel with config@2";
-        kernel = "kernel@1";
-        fdt = "fdt@1";
-        ramdisk = "ramdisk@1";
-        hash@1 {
-            algo = "sha1";
-        };
-    };
-};
-
-# Details regarding a file that may be read from a TFTP server. This variable
-# may be omitted or set to None if PXE testing is not possible or desired.
-env__net_pxe_bootable_file = {
-    'fn': 'default',
-    'addr': 0x10000000,
-    'size': 74,
-    'timeout': 50000,
-    'pattern': 'Linux',
-    'valid_label': '1',
-    'invalid_label': '2',
-    'exp_str_invalid': 'Skipping install for failure retrieving',
-    'local_label': '3',
-    'exp_str_local': 'missing environment variable: localcmd',
-    'empty_label': '4',
-    'exp_str_empty': 'No kernel given, skipping boot',
-    'check_type': 'boot_error',
-    'check_pattern': 'ERROR',
-}
-
-# False if a PXE boot test should be tested.
-# If PXE boot testing is not possible or desired, set this variable to True.
-# For example: If pxe configuration file is not proper to boot
-env__pxe_boot_test_skip = False
-
-# Here is the example of pxe configuration file ordered based on the execution
-# flow:
+.. code-block:: python
+
+   # Details regarding a boot image file that may be read from a TFTP server. This
+   # variable may be omitted or set to None if TFTP boot testing is not possible
+   # or desired.
+   env__net_tftp_bootable_file = {
+       'fn': 'image.ub',
+       'addr': 0x10000000,
+       'size': 5058624,
+       'crc32': 'c2244b26',
+       'pattern': 'Linux',
+       'config': 'config@2',
+       'timeout': 50000,
+       'check_type': 'boot_error',
+       'check_pattern': 'ERROR',
+   }
+
+   # False or omitted if a TFTP boot test should be tested.
+   # If TFTP boot testing is not possible or desired, set this variable to True.
+   # For example: If FIT image is not proper to boot
+   env__tftp_boot_test_skip = False
+
+
+Here is the example of FIT image configurations:
+
+.. code-block:: devicetree
+
+   configurations {
+       default = "config@1";
+       config@1 {
+           description = "Boot Linux kernel with config@1";
+           kernel = "kernel@0";
+           fdt = "fdt@0";
+           ramdisk = "ramdisk@0";
+           hash@1 {
+               algo = "sha1";
+           };
+       };
+       config@2 {
+           description = "Boot Linux kernel with config@2";
+           kernel = "kernel@1";
+           fdt = "fdt@1";
+           ramdisk = "ramdisk@1";
+           hash@1 {
+               algo = "sha1";
+           };
+       };
+   };
+
+.. code-block:: python
+
+   # Details regarding a file that may be read from a TFTP server. This variable
+   # may be omitted or set to None if PXE testing is not possible or desired.
+   env__net_pxe_bootable_file = {
+       'fn': 'default',
+       'addr': 0x10000000,
+       'size': 74,
+       'timeout': 50000,
+       'pattern': 'Linux',
+       'valid_label': '1',
+       'invalid_label': '2',
+       'exp_str_invalid': 'Skipping install for failure retrieving',
+       'local_label': '3',
+       'exp_str_local': 'missing environment variable: localcmd',
+       'empty_label': '4',
+       'exp_str_empty': 'No kernel given, skipping boot',
+       'check_type': 'boot_error',
+       'check_pattern': 'ERROR',
+   }
+
+   # False if a PXE boot test should be tested.
+   # If PXE boot testing is not possible or desired, set this variable to True.
+   # For example: If pxe configuration file is not proper to boot
+   env__pxe_boot_test_skip = False
+
+Here is the example of pxe configuration file ordered based on the execution
+flow:
+
 1) /tftpboot/pxelinux.cfg/default-arm-zynqmp
 
+.. code-block::
+
     menu include pxelinux.cfg/default-arm
     timeout 50
 
@@ -91,6 +97,8 @@ env__pxe_boot_test_skip = False
 
 2) /tftpboot/pxelinux.cfg/default-arm
 
+.. code-block::
+
     menu title Linux boot selections
     menu include pxelinux.cfg/default
 
@@ -110,6 +118,8 @@ env__pxe_boot_test_skip = False
 
 3) /tftpboot/pxelinux.cfg/default
 
+.. code-block::
+
     label Linux
         menu label Boot kernel
         kernel Image
@@ -117,6 +127,11 @@ env__pxe_boot_test_skip = False
         initrd rootfs.cpio.gz.u-boot
 """
 
+import pytest
+import utils
+import test_net
+import re
+
 def setup_networking(ubman):
     test_net.test_net_dhcp(ubman)
     if not test_net.net_set_up:
-- 
2.43.0

