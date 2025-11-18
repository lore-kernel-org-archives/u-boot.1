Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6DECED63D
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C27683B95;
	Tue, 18 Nov 2025 19:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ykc9Dzf6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96A2483E48; Tue, 18 Nov 2025 19:46:24 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E89183B8B
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-656b0bd47b8so1052864eaf.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763491580; x=1764096380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AQYg54wEM4fAT07Q2hMI5Qr4vQZmKwLNQJdvDFLB7kU=;
 b=Ykc9Dzf6RMLzMVFK1buJF4Hy7sPTOWQNuVtDi1D5AK9a7FLeYGEp2wpAwPU6ouOvW+
 bct3aWFer6MDp46h0IY+9fYb/2OqN+a1g1jFJz/QPk5zYlesYr3udZuuLuD4I9TBND9Z
 EdTC30Qyz1ZCLpscBAhQ0rjMRSwAQ6TOR/MXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763491580; x=1764096380;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AQYg54wEM4fAT07Q2hMI5Qr4vQZmKwLNQJdvDFLB7kU=;
 b=TpYelQACEWpAhhB7qHTv8t0xzzHIZlyQ9Dv4PvfNg/OY4u7FPiiEmCFfpRQNZvLFKE
 MLUKTjEsKupcVJKMRBYUpiGPR2OwekIPVeWq2+krsPQaK1wQMgS7xCGNLrTakf24Qjmk
 FkfaOmJNaUbXSM3m2sftCPRZMMCX2SPYuCzuiEYcWlE78ryoQFMrXdSo+ZLMhTFOYI5X
 fMIHTUbOyQZyvbMVoekhlUBOzB0ROn/0U0p3s9meBl42p7h2RSps4a1Tgit+g7pNJ7dJ
 jvIVEIr/nubpAHvmCDYNs3RD8yB9MdmnAFUZYDdqQQtQEDDor1EywurnMXSknNpX9GDE
 X4Xg==
X-Gm-Message-State: AOJu0YxMvgsCkd173mAikclsJKcAtIMkW0vkLfu8J0sHRHFeUA8jRVJl
 yjuvokknuW7+AU+3OdVb84hv4d7wRHkq6JHVER1+6QUlBRgBGb0vd0wx4F2V01yAd+u09GHw5/2
 q66wOUcsQgg==
X-Gm-Gg: ASbGncssHOVUhKQt2E7HNKaWWfF0Bml6WZ9q8lNsNHHbA6zVdCy+Qihso90IKvAIlUE
 6ZC9fcvqXSdL9mtRGvFR39j4IZazQXZdB6X8NZsqfQHaemn4ffSotOWw2SkRa7LTh/6PoTyetSO
 iDIAjtU6a/JKMBCZHPhwLyc+3mqdBQrtYqE/FFvxDFOfxEBl05EaPUewldcg1qQCAIHGD4imE4B
 SrqodzXL8W+Z6u6tp4opVDnrjEhOI8nehUE9taAbYidQfmgsQR0KMmxpU0gQSdCGW+60CrY+DGy
 y8xiKcIbK0IM0n9D128MJMcRj5urryOX2V2XePzzu2j+4YlOMKUnSPz1Y4b2lpt80zh+ZeKp8Vu
 C3UcFOOjwEv7ogv5cItNnu5SUbx7fqexncRd8SyxDp5juPmgjZEYVfzSaOJ/ewZOKtd9nl83u/7
 h8ZHDA5jafscBXPbkldPe1vmnDNYPXcIZ0MFky+b3JKBm+i8f/4W/j6Z5BXmqvNj8=
X-Google-Smtp-Source: AGHT+IFT6CMJ0Y0U7qP4qx03rPaRbRLWq9zmdsSEv8fvlHK3/HY6Or3UEFIy+MIDrDYSpCTl/A7+VA==
X-Received: by 2002:a05:6808:3088:b0:450:730e:d11a with SMTP id
 5614622812f47-4509741a74cmr8578712b6e.12.1763491579945; 
 Tue, 18 Nov 2025 10:46:19 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450aadd23ffsm3089300b6e.0.2025.11.18.10.46.19
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:46:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2] labgrid: sage: Add new lab
Date: Tue, 18 Nov 2025 12:46:18 -0600
Message-ID: <20251118184618.599462-1-trini@konsulko.com>
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

This adds support for the "sage" lab, that is utilizing stock labgrid to
control a Raspberry Pi 3, a Raspberry Pi 4, a Pine64 Plus and a SolidRun
Hummingboard 2. The board environment files enable additional tests by
pointing to content which is any of:
- Copy/pasted from the documentation for a test.
- Obvious in its source (e.g. Linux Kernel or GRUB).
- Random content (1MiBtest.bin was created with dd from /dev/urandom).

The file bin/sage/labgrid-sage-env.yaml is the file normally used either in the
LG_ENV environment variable or passed to labgrid-client as the environment to
use. This shows that each of the above targets is attached to its own labgrid
exporter node and so all parts of the system can be power cycled to help clear
transient USB errors.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Add pine64-1 and update the commit message.
- Some updates to better match upstream best practices.
---
 bin/sage/conf.mx6cuboxi_na                |  24 ++++
 bin/sage/conf.pine64_plus_na              |  24 ++++
 bin/sage/conf.rpi_3_32b_na                |   1 +
 bin/sage/conf.rpi_3_na                    |   1 +
 bin/sage/conf.rpi_4_32b_na                |   1 +
 bin/sage/conf.rpi_4_na                    |   1 +
 bin/sage/conf.rpi_arm64_na                |  24 ++++
 bin/sage/labgrid-sage-env.yaml            | 138 ++++++++++++++++++++++
 py/sage/u_boot_boardenv_mx6cuboxi_na.py   |  78 ++++++++++++
 py/sage/u_boot_boardenv_pine64_plus_na.py |  76 ++++++++++++
 py/sage/u_boot_boardenv_rpi_3.py          |   1 +
 py/sage/u_boot_boardenv_rpi_3_32b.py      |  67 +++++++++++
 py/sage/u_boot_boardenv_rpi_4.py          |   1 +
 py/sage/u_boot_boardenv_rpi_4_32b.py      |   1 +
 py/sage/u_boot_boardenv_rpi_arm64.py      |  79 +++++++++++++
 15 files changed, 517 insertions(+)
 create mode 100644 bin/sage/conf.mx6cuboxi_na
 create mode 100644 bin/sage/conf.pine64_plus_na
 create mode 120000 bin/sage/conf.rpi_3_32b_na
 create mode 120000 bin/sage/conf.rpi_3_na
 create mode 120000 bin/sage/conf.rpi_4_32b_na
 create mode 120000 bin/sage/conf.rpi_4_na
 create mode 100644 bin/sage/conf.rpi_arm64_na
 create mode 100644 bin/sage/labgrid-sage-env.yaml
 create mode 100644 py/sage/u_boot_boardenv_mx6cuboxi_na.py
 create mode 100644 py/sage/u_boot_boardenv_pine64_plus_na.py
 create mode 120000 py/sage/u_boot_boardenv_rpi_3.py
 create mode 100644 py/sage/u_boot_boardenv_rpi_3_32b.py
 create mode 120000 py/sage/u_boot_boardenv_rpi_4.py
 create mode 120000 py/sage/u_boot_boardenv_rpi_4_32b.py
 create mode 100644 py/sage/u_boot_boardenv_rpi_arm64.py

diff --git a/bin/sage/conf.mx6cuboxi_na b/bin/sage/conf.mx6cuboxi_na
new file mode 100644
index 0000000..31989c2
--- /dev/null
+++ b/bin/sage/conf.mx6cuboxi_na
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
+flash_writer=labgrid-trini.imx
diff --git a/bin/sage/conf.pine64_plus_na b/bin/sage/conf.pine64_plus_na
new file mode 100644
index 0000000..3dbe274
--- /dev/null
+++ b/bin/sage/conf.pine64_plus_na
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
+flash_writer=labgrid-trini.sunxi
diff --git a/bin/sage/conf.rpi_3_32b_na b/bin/sage/conf.rpi_3_32b_na
new file mode 120000
index 0000000..d33d959
--- /dev/null
+++ b/bin/sage/conf.rpi_3_32b_na
@@ -0,0 +1 @@
+conf.rpi_arm64_na
\ No newline at end of file
diff --git a/bin/sage/conf.rpi_3_na b/bin/sage/conf.rpi_3_na
new file mode 120000
index 0000000..d33d959
--- /dev/null
+++ b/bin/sage/conf.rpi_3_na
@@ -0,0 +1 @@
+conf.rpi_arm64_na
\ No newline at end of file
diff --git a/bin/sage/conf.rpi_4_32b_na b/bin/sage/conf.rpi_4_32b_na
new file mode 120000
index 0000000..d33d959
--- /dev/null
+++ b/bin/sage/conf.rpi_4_32b_na
@@ -0,0 +1 @@
+conf.rpi_arm64_na
\ No newline at end of file
diff --git a/bin/sage/conf.rpi_4_na b/bin/sage/conf.rpi_4_na
new file mode 120000
index 0000000..d33d959
--- /dev/null
+++ b/bin/sage/conf.rpi_4_na
@@ -0,0 +1 @@
+conf.rpi_arm64_na
\ No newline at end of file
diff --git a/bin/sage/conf.rpi_arm64_na b/bin/sage/conf.rpi_arm64_na
new file mode 100644
index 0000000..a22e62f
--- /dev/null
+++ b/bin/sage/conf.rpi_arm64_na
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
+flash_writer=labgrid-trini.rpi
diff --git a/bin/sage/labgrid-sage-env.yaml b/bin/sage/labgrid-sage-env.yaml
new file mode 100644
index 0000000..97363be
--- /dev/null
+++ b/bin/sage/labgrid-sage-env.yaml
@@ -0,0 +1,138 @@
+# Sage environment
+
+options:
+  coordinator_address: 172.17.0.1:20408
+
+targets:
+  rpi3-1:
+    resources:
+      RemotePlace:
+        name: rpi3-1
+    drivers:
+      power:
+        cls: NetworkPowerDriver
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
+  rpi4-1:
+    resources:
+      RemotePlace:
+        name: rpi4-1
+    drivers:
+      power:
+        cls: NetworkPowerDriver
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
+  hb-1:
+    resources:
+      RemotePlace:
+        name: hb-1
+    drivers:
+      power:
+        cls: NetworkPowerDriver
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
+  pine64-1:
+    resources:
+      RemotePlace:
+        name: pine64-1
+    drivers:
+      power:
+        cls: NetworkPowerDriver
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
+  sage-exporter-rpi3-1:
+    resources:
+      RemotePlace:
+        name: sage-exporter-rpi3-1
+    drivers:
+      power:
+        cls: NetworkPowerDriver
+      ssh:
+        cls: SSHDriver
+  sage-exporter-rpi4-1:
+    resources:
+      RemotePlace:
+        name: sage-exporter-rpi4-1
+    drivers:
+      power:
+        cls: NetworkPowerDriver
+      ssh:
+        cls: SSHDriver
+  sage-exporter-hb-1:
+    resources:
+      RemotePlace:
+        name: sage-exporter-hb-1
+    drivers:
+      power:
+        cls: NetworkPowerDriver
+      ssh:
+        cls: SSHDriver
+  sage-exporter-pine64-1:
+    resources:
+      RemotePlace:
+        name: sage-exporter-pine64-1
+    drivers:
+      power:
+        cls: NetworkPowerDriver
+      ssh:
+        cls: SSHDriver
diff --git a/py/sage/u_boot_boardenv_mx6cuboxi_na.py b/py/sage/u_boot_boardenv_mx6cuboxi_na.py
new file mode 100644
index 0000000..0c7b682
--- /dev/null
+++ b/py/sage/u_boot_boardenv_mx6cuboxi_na.py
@@ -0,0 +1,78 @@
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
+# Fails with "invalid device tree"
+#env__efi_loader_helloworld_file = {
+#    'fn': 'EFI/arm/helloworld.efi',
+#    'size': 2320,
+#    'addr': 0x12000000,
+#    'crc32': 'e37e06d4',
+#}
+#env__efi_helloworld_net_http_test_skip = False
+#
+#env__efi_loader_grub_file = {
+#    'fn': 'EFI/arm/grubarm.efi',
+#    'size': 471040,
+#    'addr': 0x12000000,
+#    'crc32': '4a84b065',
+#}
+
+# No console output from Linux
+#env__tftp_boot_test_skip = False
+#
+#env__net_tftp_bootable_file = {
+#    'fn': 'v6.13/image.fit.arm',
+#    'config': 'conf-577', # SolidRun HummingBoard Solo/DualLite
+#    'addr': 0x12000000,
+#    'size': 22348800,
+#    'crc32': 'cecdd6f1',
+#    'pattern': 'Booting Linux on physical CPU',
+#}
+
+# Details regarding a file that may be read from a TFTP server. This variable
+# may be omitted or set to None if PXE testing is not possible or desired.
+env__net_pxe_bootable_file = {
+    'fn': 'default',
+    'addr': 0x12000000,
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
diff --git a/py/sage/u_boot_boardenv_pine64_plus_na.py b/py/sage/u_boot_boardenv_pine64_plus_na.py
new file mode 100644
index 0000000..fe4ffff
--- /dev/null
+++ b/py/sage/u_boot_boardenv_pine64_plus_na.py
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
+    'addr': 0x42000000,
+    "crc32": "2fa737e0",
+    "fnu": "ubtest-upload.bin",
+}
+
+env__efi_loader_helloworld_file = {
+    'fn': 'EFI/arm64/helloworld.efi',
+    'size': 4528,
+    'addr': 0x42000000,
+    'crc32': '2b466005',
+}
+
+env__efi_loader_grub_file = {
+    'fn': 'EFI/arm64/grubaa64.efi',
+    'size': 724992,
+    'addr': 0x42000000,
+    'crc32': '8db3f0f1',
+}
+
+env__tftp_boot_test_skip = False
+
+env__net_tftp_bootable_file = {
+    'fn': 'v6.13/image.fit.arm64',
+    'config': 'conf-12', # Pine64 PINE A64+
+    'addr': 0x42000000,
+    'size': 28574720,
+    'crc32': '8513595c',
+    'pattern': 'Booting Linux on physical CPU',
+}
+
+# Details regarding a file that may be read from a TFTP server. This variable
+# may be omitted or set to None if PXE testing is not possible or desired.
+env__net_pxe_bootable_file = {
+    'fn': 'default',
+    'addr': 0x42000000,
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
+# For example: If pxe configuration file is not proper to boot
+env__pxe_boot_test_skip = False
diff --git a/py/sage/u_boot_boardenv_rpi_3.py b/py/sage/u_boot_boardenv_rpi_3.py
new file mode 120000
index 0000000..d6f7a63
--- /dev/null
+++ b/py/sage/u_boot_boardenv_rpi_3.py
@@ -0,0 +1 @@
+u_boot_boardenv_rpi_arm64.py
\ No newline at end of file
diff --git a/py/sage/u_boot_boardenv_rpi_3_32b.py b/py/sage/u_boot_boardenv_rpi_3_32b.py
new file mode 100644
index 0000000..da50b32
--- /dev/null
+++ b/py/sage/u_boot_boardenv_rpi_3_32b.py
@@ -0,0 +1,67 @@
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
+env__net_uses_usb = True
+
+env__net_dhcp_server = True
+
+env__net_tftp_readable_file = {
+    "fn": "1MiBtest.bin",
+    "size": 1048576,
+    "crc32": "2fa737e0",
+    "fnu": "ubtest-upload.bin",
+}
+
+env__efi_loader_helloworld_file = {
+    'fn': 'EFI/arm/helloworld.efi',
+    'size': 2320,
+    'addr': 0x00200000,
+    'crc32': 'e37e06d4',
+}
+env__efi_helloworld_net_http_test_skip = False
+
+env__efi_loader_grub_file = {
+    'fn': 'EFI/arm/grubarm.efi',
+    'size': 471040,
+    'addr': 0x00200000,
+    'crc32': '4a84b065',
+}
+
+# Details regarding a file that may be read from a TFTP server. This variable
+# may be omitted or set to None if PXE testing is not possible or desired.
+env__net_pxe_bootable_file = {
+    'fn': 'default',
+    'addr': 0x00200000,
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
+# For example: If pxe configuration file is not proper to boot
+env__pxe_boot_test_skip = False
diff --git a/py/sage/u_boot_boardenv_rpi_4.py b/py/sage/u_boot_boardenv_rpi_4.py
new file mode 120000
index 0000000..d6f7a63
--- /dev/null
+++ b/py/sage/u_boot_boardenv_rpi_4.py
@@ -0,0 +1 @@
+u_boot_boardenv_rpi_arm64.py
\ No newline at end of file
diff --git a/py/sage/u_boot_boardenv_rpi_4_32b.py b/py/sage/u_boot_boardenv_rpi_4_32b.py
new file mode 120000
index 0000000..583f36e
--- /dev/null
+++ b/py/sage/u_boot_boardenv_rpi_4_32b.py
@@ -0,0 +1 @@
+u_boot_boardenv_rpi_3_32b.py
\ No newline at end of file
diff --git a/py/sage/u_boot_boardenv_rpi_arm64.py b/py/sage/u_boot_boardenv_rpi_arm64.py
new file mode 100644
index 0000000..4d164de
--- /dev/null
+++ b/py/sage/u_boot_boardenv_rpi_arm64.py
@@ -0,0 +1,79 @@
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
+env__net_uses_usb = True
+
+env__net_dhcp_server = True
+
+env__net_tftp_readable_file = {
+    "fn": "1MiBtest.bin",
+    "size": 1048576,
+    "crc32": "2fa737e0",
+    "fnu": "ubtest-upload.bin",
+}
+
+env__efi_loader_helloworld_file = {
+    'fn': 'EFI/arm64/helloworld.efi',
+    'size': 4528,
+    'addr': 0x00200000,
+    'crc32': '2b466005',
+}
+env__efi_helloworld_net_http_test_skip = False
+
+env__efi_loader_grub_file = {
+    'fn': 'EFI/arm64/grubaa64.efi',
+    'size': 724992,
+    'addr': 0x00200000,
+    'crc32': '8db3f0f1',
+}
+
+env__tftp_boot_test_skip = False
+
+env__net_tftp_bootable_file = {
+    'fn': 'v6.13/image.fit.arm64',
+    'addr': 0x00200000,
+    'size': 28574720,
+    'crc32': '8513595c',
+    'pattern': 'Booting Linux on physical CPU',
+}
+
+# Details regarding a file that may be read from a TFTP server. This variable
+# may be omitted or set to None if PXE testing is not possible or desired.
+env__net_pxe_bootable_file = {
+    'fn': 'default',
+    'addr': 0x00200000,
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
+# For example: If pxe configuration file is not proper to boot
+env__pxe_boot_test_skip = False
+
+#env__net_pxe_readable_file = env__net_pxe_bootable_file
-- 
2.39.2

