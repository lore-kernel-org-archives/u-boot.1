Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AB5E7AD5E
	for <u-boot@archiver.kernel.org>; Thu, 25 Dec 2025 16:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1046842A2;
	Thu, 25 Dec 2025 17:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="msr/RnWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6EB842C7; Thu, 25 Dec 2025 17:14:41 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACE4842A2
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 17:14:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-65b3d3ac90fso2417050eaf.1
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766679278; x=1767284078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nsSdI3QPgamghJoaUbNkXk3+JQF4J+vAkSeOssn8g3M=;
 b=msr/RnWX02a+fgS8JSX3RpQbVnPqHr4rUI03N1fAXMw8YH8cyv0I4GE1lgD3tcFqXl
 VLpHVJw2sxXALIzXnFXYVEqXW7NpI50ldWQ6c4lCkZfh3keWpJgdBy4d+UGii8U18TcG
 zMhzxmyKqxsrErIgmbVI5QNtrn3WlLXQQlda0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766679278; x=1767284078;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nsSdI3QPgamghJoaUbNkXk3+JQF4J+vAkSeOssn8g3M=;
 b=kP/rkZ9JMfosbn/N0x97QS1w2QclI47HKNta1YTiO3cjCl9TnXPmva04CloGzi5SwJ
 0KKTBelrdiMkgJ7uso5kuE5QAk8/i9MChmK7sy+EGCI/nuaPiJNT5Sdtg2BQELyizFaB
 LcNL1vnYto4xChraGf6Cwg2mxqj4Sg1QLQ+6zGqCfGh7erMVBpCFit6VV+a4gHHWAgHb
 NGP98cDHxMzAUqPwcg0eejjKN6oWDLy/zlnw+k9Fl9UsTU0Kb4+KpLiooN21lLIZ9SzC
 62ZaSjF4Lbii6v65bT+blbaD0FFrLAh+Z+d5fDCTxEJ4muazHMj3MsZRcKC8xL6eDQpU
 XZ7A==
X-Gm-Message-State: AOJu0YzG5QRlWaLwOJthEXzMcoz44p2tM2NpKgbEAszAiVpBGWQVMu4m
 en2QrGtaEgUgIO4r6fuYClQ5HVL2ZnCCJRR48t5eF2ELiCogIb4KM7q9akHhL743N3vvF50CqrZ
 pZ1r67Jo=
X-Gm-Gg: AY/fxX4Ro3T5nEXHgSv3FLyxDWsJR39U5o5or9p4vkkzw1X4egR/gHySBkUNr5856wP
 2WKSEYqfpEvpaq2rF3/l89/MzGu1QoVOJOH+7vrZQsVhdeXhPYAUhbvvVOh7dSRJflgb2tGndIn
 hQsuraZJJCRznPwl1yE+ZoodekdX67Xg08GhL98tL4HP7KVLIPhLJZa1glyGvW9TqqlrO2pfygd
 eiX8lYDczXLEKdRDwdF9FvW0jLK89TqFyED8j8HbfObDhcPZOOUXimL/bbQeLAovVpTkBiXhlyA
 qaFejl8m7NuJWz4Elij5WEHlkcPQSYTXwyOlRszAPZMYEmBru2exx87d5AN8mfNwXWNjZHKC69a
 mYmyQUNbudAy1qY+otI4GaOPsFBehbNBEFQf6nE25fm+PBOaH9JxXrQvXUiQiLQf4KMKkwG74KH
 2dcWYw2gYn79m8aEXr4Js2oTPkRi2PAytEaFKBzo5CIM5N/HwPCGuK
X-Google-Smtp-Source: AGHT+IF+7X2FsWg0KFNwD1HsNBS24wNDc+Mh0hnxHugOinXbbF1Vmf0WgNyT/tb15znKaFGA8RLNbA==
X-Received: by 2002:a4a:e20f:0:b0:659:9a49:908f with SMTP id
 006d021491bc7-65d0e9235d1mr6474127eaf.14.1766679278009; 
 Thu, 25 Dec 2025 08:14:38 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f3fb710sm12229893eaf.2.2025.12.25.08.14.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Dec 2025 08:14:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [u-boot-test-hooks][PATCH] labgrid: sage: Add BeagleBone Black
Date: Thu, 25 Dec 2025 10:14:36 -0600
Message-ID: <20251225161436.1224502-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This adds support for a BeagleBone Black board, which is supported under the
am335x_evm configuration.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
For the moment, this uses snmpset to manage power on the board. The relevant
changes have been submitted upstream, but rather than use a local wheel (which
is doable but complicated for all custodian repositories) we go with this option
instead for now.
---
 bin/sage/conf.am335x_evm              | 24 +++++++++
 bin/sage/labgrid-sage-env.yaml        | 37 +++++++++++++
 py/sage/u_boot_boardenv_am335x_evm.py | 76 +++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 bin/sage/conf.am335x_evm
 create mode 100644 py/sage/u_boot_boardenv_am335x_evm.py

diff --git a/bin/sage/conf.am335x_evm b/bin/sage/conf.am335x_evm
new file mode 100644
index 0000000..6c84f12
--- /dev/null
+++ b/bin/sage/conf.am335x_evm
@@ -0,0 +1,24 @@
+# Copyright (c) 2025 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=labgrid-trini
+reset_impl=labgrid-trini
+flash_impl=labgrid-trini.sd-mux
+flash_writer=labgrid-trini.ti-omap_mount
diff --git a/bin/sage/labgrid-sage-env.yaml b/bin/sage/labgrid-sage-env.yaml
index 97363be..9fc8b98 100644
--- a/bin/sage/labgrid-sage-env.yaml
+++ b/bin/sage/labgrid-sage-env.yaml
@@ -100,6 +100,32 @@ targets:
         autoboot: 'Hit any key to stop autoboot'
       strategy:
         cls: UBootStrategy
+  bbb-1:
+    resources:
+      RemotePlace:
+        name: bbb-1
+    drivers:
+      power:
+        cls: ExternalPowerDriver
+        cmd_on: 'snmpset -v 2c -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.9 i 1'
+        cmd_off: 'snmpset -v 2c -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.9 i 2'
+      mux:
+        cls: USBSDWireDriver
+      storage:
+        cls: USBStorageDriver
+      serial:
+        cls: SerialDriver
+      shell:
+        cls: ShellDriver
+        prompt: 'root@.*:~# '
+        login_prompt: 'login: '
+        username: 'root'
+      uboot:
+        cls: UBootDriver
+        prompt: 'U-Boot> '
+        autoboot: 'Hit any key to stop autoboot'
+      strategy:
+        cls: UBootStrategy
   sage-exporter-rpi3-1:
     resources:
       RemotePlace:
@@ -136,3 +162,14 @@ targets:
         cls: NetworkPowerDriver
       ssh:
         cls: SSHDriver
+  sage-exporter-bbb-1:
+    resources:
+      RemotePlace:
+        name: sage-exporter-bbb-1
+    drivers:
+      power:
+        cls: ExternalPowerDriver
+        cmd_on: 'snmpset -v 2c -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.13 i 1'
+        cmd_off: 'snmpset -v 2c -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.13 i 2'
+      ssh:
+        cls: SSHDriver
diff --git a/py/sage/u_boot_boardenv_am335x_evm.py b/py/sage/u_boot_boardenv_am335x_evm.py
new file mode 100644
index 0000000..cbd5590
--- /dev/null
+++ b/py/sage/u_boot_boardenv_am335x_evm.py
@@ -0,0 +1,76 @@
+# Copyright (c) 2025 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+env__net_dhcp_server = True
+
+env__net_tftp_readable_file = {
+    "fn": "1MiBtest.bin",
+    "size": 1048576,
+    "crc32": "2fa737e0",
+}
+
+env__efi_loader_helloworld_file = {
+    'fn': 'EFI/arm/helloworld.efi',
+    'size': 2320,
+    'addr': 0x82000000,
+    'crc32': 'e37e06d4',
+}
+env__efi_helloworld_net_http_test_skip = False
+
+env__efi_loader_grub_file = {
+    'fn': 'EFI/arm/grubarm.efi',
+    'size': 471040,
+    'addr': 0x82000000,
+    'crc32': '4a84b065',
+}
+
+# No console output from Linux
+#env__tftp_boot_test_skip = False
+#
+#env__net_tftp_bootable_file = {
+#    'fn': 'v6.13/image.fit.arm',
+#    'addr': 0x82000000,
+#    'size': 22348800,
+#    'crc32': 'cecdd6f1',
+#    'pattern': 'Booting Linux on physical CPU',
+#}
+
+# Details regarding a file that may be read from a TFTP server. This variable
+# may be omitted or set to None if PXE testing is not possible or desired.
+env__net_pxe_bootable_file = {
+    'fn': 'default',
+    'addr': 0x82000000,
+    'size': 64,
+    'timeout': 50000,
+    'pattern': 'Linux',
+    'valid_label': '1',
+    'invalid_label': '2',
+    'exp_str_invalid': 'Skipping install for failure retrieving',
+    'local_label': '3',
+    'exp_str_local': 'missing environment variable: localcmd',
+    'empty_label': '4',
+    'exp_str_empty': 'No kernel given, skipping boot',
+}
+
+# False or omitted if a PXE boot test should be tested.
+# If PXE boot testing is not possible or desired, set this variable to True.
+
+# For example: If pxe configuration file is not proper to boot
+env__pxe_boot_test_skip = False
-- 
2.39.2

