Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C72CC3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 23:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7259B82162;
	Thu,  8 May 2025 01:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mr2UAy64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B4582162; Thu,  8 May 2025 01:25:12 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2529C8210D
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 01:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-400fa6eafa9so316110b6e.1
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 16:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746660309; x=1747265109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ang7G2/R3sfGgbLnLHhk26MtPFuPo6yGMdjRFDGy4b4=;
 b=mr2UAy64SR7AGmlPqjsU6wRoXKapF3aKC8rWRzAmRZwlsz3w/uQXIW526UpkXbD2c5
 KA/N6GhieBu90Q0062egdy1OEJrLAnIb9D1I11PdVLlLkKIPSDDtvjq9CMFhjzwu6YcQ
 lIXlKmPrJNLnpoGJaDZ0pQvr8bNd5lwuTNJqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746660309; x=1747265109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ang7G2/R3sfGgbLnLHhk26MtPFuPo6yGMdjRFDGy4b4=;
 b=TT72YLG61GPf8kBPXuxZhB8K19Fx3n66Ni9hSdB94JyuENHnI6v8OAKnOC4QQAXoWF
 euQ+NfSenuGZ9k393n+5YUbbPSWNKohB/6SJIBTh34shCp22gSQ29imD4BN5d2eLwVh0
 Q+lOEO8cKha7pSZiUL1Sij/QN+2j6wPWka2wr6xsNiZQJHb9iio0lpw7McmS8h5IB7yd
 8SW9QH+/0R51jcg/GFrK56F5Ocyo8UsnnMO7crrjt4b3yZj5Dxla65XVXxU1T7F9RHdJ
 3w+zNIT01zqaMLY94QpRI1WrDvqhVGkuIA4rWcmlhgP/44GZirZV6uwDAaphRcmqXink
 249g==
X-Gm-Message-State: AOJu0Yy+HJm9V05z2n3HByMnOybQiPaIAPzUTE/UASeP+VQtbi7RxWBX
 4pa2syaYwxJQ4tRCe9XmbIkFOxlFOhvOQhMvnjLoMEFbfa08AH3xArUMJoFfVHJ5NoJY3mYwaZ5
 k
X-Gm-Gg: ASbGncufiMoJzIFzslL4+9eYjSd7vSHbE0ApxfrEFu40zZnxp8GHK3LsEcDTpo2tjIm
 K6dd6TKgM9Eb7+n6zk+7XbGvBwm34+zC20g7vW7k2rI7L+ISN8zA7mu257voSEIg8ntO70bAh9y
 j7N8+M5hdhKtioV4qE8bIySXK/a85QhJWOmFXmZihh2DoDz5pYiZYg131iDTeqiKIMwsu+CZquL
 61yZdMOXvGTqdjAq8Uola1kuOLLH17MEzj8dakeag2g636okJgtc3pwyaLD2+UlVr0QMO/RLraj
 ZmmGWwTOxqe9IylXfSDMLzuWU9NAbERIYFSiw5y1Qe1j+PCvczMBnAJNHwfCs/FZyIDakprpkuF
 3qFie
X-Google-Smtp-Source: AGHT+IEUe7PP3xl66fO18KMIE9RkD3ETAhb86/lPlNtjsk4Maj4WBxmdRXTxKi9U3sVa8guVR6sd6g==
X-Received: by 2002:a05:6808:1818:b0:401:e6c0:3112 with SMTP id
 5614622812f47-4036f0821camr2916100b6e.15.1746660308903; 
 Wed, 07 May 2025 16:25:08 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4036f3af356sm831979b6e.46.2025.05.07.16.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:25:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/3] doc: pytest: Document the test_efi_loader test
Date: Wed,  7 May 2025 17:23:02 -0600
Message-ID: <20250507232500.527782-4-trini@konsulko.com>
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

Add this test to the documentation. We need to add a code-block
annotation to the example and indent it correctly. We also need to
document the do_test_efi_helloworld_net function and that in turn means
changing the documentation to test_efi_helloworld_net_http and
test_efi_helloworld_net_tftp to reflect what is and isn't done in those
functions themselves now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I honestly wasn't sure if this merits a fixes tag for commit
d2056e2ed03f ("test/py: test_efi_loader: add HTTP (wget) test for the
EFI loader") or not.

Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
---
 doc/develop/pytest/index.rst           |  1 +
 doc/develop/pytest/test_efi_loader.rst |  8 +++
 test/py/tests/test_efi_loader.py       | 87 ++++++++++++++------------
 3 files changed, 55 insertions(+), 41 deletions(-)
 create mode 100644 doc/develop/pytest/test_efi_loader.rst

diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
index 5bcda1f0952c..3265eb97c7ef 100644
--- a/doc/develop/pytest/index.rst
+++ b/doc/develop/pytest/index.rst
@@ -19,5 +19,6 @@ Individual tests
 
    test_000_version
    test_bootstage
+   test_efi_loader
    test_net
    test_net_boot
diff --git a/doc/develop/pytest/test_efi_loader.rst b/doc/develop/pytest/test_efi_loader.rst
new file mode 100644
index 000000000000..da2fa7e6ec2f
--- /dev/null
+++ b/doc/develop/pytest/test_efi_loader.rst
@@ -0,0 +1,8 @@
+test_efi_loader
+===============
+
+.. automodule:: test_efi_loader
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 58f2655191fe..91f151d09cda 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -13,43 +13,45 @@ that rely on network will be automatically skipped.
 
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
-env__efi_loader_helloworld_file = {
-    'fn': 'lib/efi_loader/helloworld.efi', # file name
-    'size': 5058624,                       # file length in bytes
-    'crc32': 'c2244b26',                   # CRC32 check sum
-    'addr': 0x40400000,                    # load address
-}
-
-# False if the helloworld EFI over HTTP boot test should be performed.
-# If HTTP boot testing is not possible or desired, set this variable to True or
-# ommit it.
-env__efi_helloworld_net_http_test_skip = True
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
+    env__efi_loader_helloworld_file = {
+        'fn': 'lib/efi_loader/helloworld.efi', # file name
+        'size': 5058624,                       # file length in bytes
+        'crc32': 'c2244b26',                   # CRC32 check sum
+        'addr': 0x40400000,                    # load address
+    }
+
+    # False if the helloworld EFI over HTTP boot test should be performed.
+    # If HTTP boot testing is not possible or desired, set this variable to True or
+    # ommit it.
+    env__efi_helloworld_net_http_test_skip = True
 """
 
 import pytest
@@ -161,6 +163,11 @@ def fetch_file(ubman, env_conf, proto):
     return addr
 
 def do_test_efi_helloworld_net(ubman, proto):
+    """Download and execute the helloworld appliation
+
+    The helloworld.efi file is downloaded based on the value passed to us as a
+    protocol and is executed using the fallback device tree at $fdtcontroladdr.
+    """
     addr = fetch_file(ubman, 'env__efi_loader_helloworld_file', proto)
 
     output = ubman.run_command('bootefi %x' % addr)
@@ -175,8 +182,7 @@ def do_test_efi_helloworld_net(ubman, proto):
 def test_efi_helloworld_net_tftp(ubman):
     """Run the helloworld.efi binary via TFTP.
 
-    The helloworld.efi file is downloaded from the TFTP server and is executed
-    using the fallback device tree at $fdtcontroladdr.
+    Call the do_test_efi_helloworld_net function to execute the test via TFTP.
     """
 
     do_test_efi_helloworld_net(ubman, PROTO_TFTP);
@@ -187,8 +193,7 @@ def test_efi_helloworld_net_tftp(ubman):
 def test_efi_helloworld_net_http(ubman):
     """Run the helloworld.efi binary via HTTP.
 
-    The helloworld.efi file is downloaded from the HTTP server and is executed
-    using the fallback device tree at $fdtcontroladdr.
+    Call the do_test_efi_helloworld_net function to execute the test via HTTP.
     """
     if ubman.config.env.get('env__efi_helloworld_net_http_test_skip', True):
         pytest.skip('helloworld.efi HTTP test is not enabled!')
-- 
2.43.0

