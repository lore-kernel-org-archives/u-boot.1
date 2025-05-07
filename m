Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE623C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 23:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE998212F;
	Thu,  8 May 2025 01:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="suISbLoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871F88288D; Thu,  8 May 2025 01:25:10 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB0138212F
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 01:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3f8ae3ed8f4so271918b6e.3
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746660307; x=1747265107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ZOvZqJ1mJBUkfssfjyPN4jDq1nejNwMUapDE3ssTKQ=;
 b=suISbLoK+yEeoZIlzdf/ybQiDLfuQjoJ61R5SSL1ByMOSjkcMAmvxLu6iXyhe1z3NV
 55wlkzvjYCIlmfR8OmMjgrFK8WXf7cgmLBndRsBA+GG5a2lar+XkJF3w/3p6JqusCKEx
 W59xNexr6v/8ZP9vfmqkUB3ZyuqvKDALlklnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746660307; x=1747265107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ZOvZqJ1mJBUkfssfjyPN4jDq1nejNwMUapDE3ssTKQ=;
 b=nJJbiOWMrW1En2iHlBBs2SLWKxBhRO8E4jm0Mgfy3thHRAO2WoX0ChBp4FrY7IsuYR
 yrF/1e+PAuaQEJRKSmRhETp4Qtai68McbjPlYhj1Jxi0MA1jwVjgFsBo4KMBDzS0zBJV
 /Cz/lbl7Okcli4GBMBYZCoDHyVl6BapAIgQ9q6Y47VXA8b1lcw6MnSswZY38Qg2+07vH
 SlaQiZURjY1oCmRyKeMuhroN7WMb0aiSDjYbTAtvYwCCm4IqntWODGu4uNNsSxsLkf4R
 l0u/SoHW2UZWvzexuYqOdLKVb/USE5HzeIphS/BY6dsVFPK0i6Z2PTulm0pgmHNUT1LV
 Mv9w==
X-Gm-Message-State: AOJu0YyAv3UmClSpHwLd6ebIxRUiNzOrh9IBXvP5JI9hlN5C6J5wPvDB
 8YQe4ohLQL6QgsP926/eSryss7Suvna+XxloBlt18FI7e+ngtbao9zhYsMPbCjjHDoygAYhq5Z7
 n
X-Gm-Gg: ASbGncummV0DP883bHY57gRx/a3r9FZ61F01yKH2vjocbZr1y1O9ClAR0Ffl1HqbiSp
 7J229APCFXBiHXtev58T7PKuoTX40ZdaM4bubfz61N21bFCM0+XMIRUTbDMO16/nS4k86QioUAi
 C3mbdYLMGDiiS1r3/fVwTe4FfLZwTumxywkYaOiPkLV7rkolsAiK6a2rFceDcqW2FiuIsckn+QM
 Z3ApwwVk//W31Qx8aOGweyS1hb3WXZniX0465keTJ/7sRavgUJ9PcL2fxTguBjy7p/jGV14k4aq
 RKIHhvDS3uvHoPKmJJoOIj1qixqdQJ+PG0YknWuAU5qxGkw5xs9rZZcNc/lDyZvkjT4ZYZt2xIJ
 NBkl3tJ6gsyP/oQE=
X-Google-Smtp-Source: AGHT+IEMpLgQyDkTXw7sXjFMD1LiVxqIS35mut096hdHqZFcvmcnNTNqITcU7JLhCsUh5ipHkwD3bQ==
X-Received: by 2002:a05:6808:140a:b0:3f8:1df6:3fc with SMTP id
 5614622812f47-4036f0c0f4fmr2656795b6e.29.1746660306615; 
 Wed, 07 May 2025 16:25:06 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4036f3af356sm831979b6e.46.2025.05.07.16.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:25:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/3] doc: pytest: Document the test_net test
Date: Wed,  7 May 2025 17:23:00 -0600
Message-ID: <20250507232500.527782-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507232500.527782-1-trini@konsulko.com>
References: <20250507221112.518041-1-trini@konsulko.com>
 <20250507232500.527782-1-trini@konsulko.com>
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

Add this test to the documentation. While the diff appears large at
first, the only changes within the test are to move the imports to
follow the pydoc comment and then to code-block and indent the example
configuration.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
---
 doc/develop/pytest/index.rst    |   1 +
 doc/develop/pytest/test_net.rst |   8 ++
 test/py/tests/test_net.py       | 152 ++++++++++++++++----------------
 3 files changed, 86 insertions(+), 75 deletions(-)
 create mode 100644 doc/develop/pytest/test_net.rst

diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
index 36083882584f..e2131a2f4a68 100644
--- a/doc/develop/pytest/index.rst
+++ b/doc/develop/pytest/index.rst
@@ -18,4 +18,5 @@ Individual tests
    :maxdepth: 1
 
    test_000_version
+   test_net
    test_net_boot
diff --git a/doc/develop/pytest/test_net.rst b/doc/develop/pytest/test_net.rst
new file mode 100644
index 000000000000..571179f7b9dc
--- /dev/null
+++ b/doc/develop/pytest/test_net.rst
@@ -0,0 +1,8 @@
+test_net
+========
+
+.. automodule:: test_net
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index 4732e4b57f8a..27cdd73fd49c 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -4,12 +4,6 @@
 # Test various network-related functionality, such as the dhcp, ping, and
 # tftpboot commands.
 
-import pytest
-import utils
-import uuid
-import datetime
-import re
-
 """
 Note: This test relies on boardenv_* containing configuration values to define
 which network environment is available for testing. Without this, this test
@@ -17,77 +11,85 @@ will be automatically skipped.
 
 For example:
 
-# Boolean indicating whether the Ethernet device is attached to USB, and hence
-# USB enumeration needs to be performed prior to network tests.
-# This variable may be omitted if its value is False.
-env__net_uses_usb = False
-
-# Boolean indicating whether the Ethernet device is attached to PCI, and hence
-# PCI enumeration needs to be performed prior to network tests.
-# This variable may be omitted if its value is False.
-env__net_uses_pci = True
-
-# True if a DHCP server is attached to the network, and should be tested.
-# If DHCP testing is not possible or desired, this variable may be omitted or
-# set to False.
-env__net_dhcp_server = True
-
-# False or omitted if a DHCP server is attached to the network, and dhcp abort
-# case should be tested.
-# If DHCP abort testing is not possible or desired, set this variable to True.
-# For example: On some setup, dhcp is too fast and this case may not work.
-env__dhcp_abort_test_skip = True
-
-# True if a DHCPv6 server is attached to the network, and should be tested.
-# If DHCPv6 testing is not possible or desired, this variable may be omitted or
-# set to False.
-env__net_dhcp6_server = True
-
-# A list of environment variables that should be set in order to configure a
-# static IP. If solely relying on DHCP, this variable may be omitted or set to
-# an empty list.
-env__net_static_env_vars = [
-    ('ipaddr', '10.0.0.100'),
-    ('netmask', '255.255.255.0'),
-    ('serverip', '10.0.0.1'),
-]
-
-# Details regarding a file that may be read from a TFTP server. This variable
-# may be omitted or set to None if TFTP testing is not possible or desired.
-env__net_tftp_readable_file = {
-    'fn': 'ubtest-readable.bin',
-    'addr': 0x10000000,
-    'size': 5058624,
-    'crc32': 'c2244b26',
-    'timeout': 50000,
-    'fnu': 'ubtest-upload.bin',
-}
-
-# Details regarding a file that may be read from a NFS server. This variable
-# may be omitted or set to None if NFS testing is not possible or desired.
-env__net_nfs_readable_file = {
-    'fn': 'ubtest-readable.bin',
-    'addr': 0x10000000,
-    'size': 5058624,
-    'crc32': 'c2244b26',
-}
-
-# Details regarding a file that may be read from a TFTP server. This variable
-# may be omitted or set to None if PXE testing is not possible or desired.
-env__net_pxe_readable_file = {
-    'fn': 'default',
-    'addr': 0x2000000,
-    'size': 74,
-    'timeout': 50000,
-    'pattern': 'Linux',
-}
-
-# True if a router advertisement service is connected to the network, and should
-# be tested. If router advertisement testing is not possible or desired, this
-variable may be omitted or set to False.
-env__router_on_net = True
+.. code-block:: python
+
+    # Boolean indicating whether the Ethernet device is attached to USB, and hence
+    # USB enumeration needs to be performed prior to network tests.
+    # This variable may be omitted if its value is False.
+    env__net_uses_usb = False
+
+    # Boolean indicating whether the Ethernet device is attached to PCI, and hence
+    # PCI enumeration needs to be performed prior to network tests.
+    # This variable may be omitted if its value is False.
+    env__net_uses_pci = True
+
+    # True if a DHCP server is attached to the network, and should be tested.
+    # If DHCP testing is not possible or desired, this variable may be omitted or
+    # set to False.
+    env__net_dhcp_server = True
+
+    # False or omitted if a DHCP server is attached to the network, and dhcp abort
+    # case should be tested.
+    # If DHCP abort testing is not possible or desired, set this variable to True.
+    # For example: On some setup, dhcp is too fast and this case may not work.
+    env__dhcp_abort_test_skip = True
+
+    # True if a DHCPv6 server is attached to the network, and should be tested.
+    # If DHCPv6 testing is not possible or desired, this variable may be omitted or
+    # set to False.
+    env__net_dhcp6_server = True
+
+    # A list of environment variables that should be set in order to configure a
+    # static IP. If solely relying on DHCP, this variable may be omitted or set to
+    # an empty list.
+    env__net_static_env_vars = [
+        ('ipaddr', '10.0.0.100'),
+        ('netmask', '255.255.255.0'),
+        ('serverip', '10.0.0.1'),
+    ]
+
+    # Details regarding a file that may be read from a TFTP server. This variable
+    # may be omitted or set to None if TFTP testing is not possible or desired.
+    env__net_tftp_readable_file = {
+        'fn': 'ubtest-readable.bin',
+        'addr': 0x10000000,
+        'size': 5058624,
+        'crc32': 'c2244b26',
+        'timeout': 50000,
+        'fnu': 'ubtest-upload.bin',
+    }
+
+    # Details regarding a file that may be read from a NFS server. This variable
+    # may be omitted or set to None if NFS testing is not possible or desired.
+    env__net_nfs_readable_file = {
+        'fn': 'ubtest-readable.bin',
+        'addr': 0x10000000,
+        'size': 5058624,
+        'crc32': 'c2244b26',
+    }
+
+    # Details regarding a file that may be read from a TFTP server. This variable
+    # may be omitted or set to None if PXE testing is not possible or desired.
+    env__net_pxe_readable_file = {
+        'fn': 'default',
+        'addr': 0x2000000,
+        'size': 74,
+        'timeout': 50000,
+        'pattern': 'Linux',
+    }
+
+    # True if a router advertisement service is connected to the network, and should
+    # be tested. If router advertisement testing is not possible or desired, this
+    variable may be omitted or set to False.
+    env__router_on_net = True
 """
 
+import pytest
+import utils
+import uuid
+import datetime
+import re
+
 net_set_up = False
 net6_set_up = False
 
-- 
2.43.0

