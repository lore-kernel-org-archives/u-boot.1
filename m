Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFECACCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 15:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5496683A03;
	Mon, 10 Nov 2025 16:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pAozupYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C1C183A56; Mon, 10 Nov 2025 16:42:33 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D243D83980
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 16:42:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6da42fbd4so1446772a34.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 07:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762789349; x=1763394149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=T8y8aw+J49Z9O75PNjdy3LOjZUZX9UEvwdRkpq85o5M=;
 b=pAozupYVrerZ+g9YA0/l+jp8jlIy8Zp7/7cwUDSjSI7WRe2dtRMSS69NkGpy9w5mZM
 j98JbVBIz4q9dfJd4yQNg+gILRlIC/il/s2uxxki+mk1ou0ajTUGUKGM81G0RfuevBI8
 00VsX8fXU/AT2ViLjF7tqZ4dPdyPotu0ElfWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789349; x=1763394149;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T8y8aw+J49Z9O75PNjdy3LOjZUZX9UEvwdRkpq85o5M=;
 b=w3xHBw4ixWRn2gyEvgLOWN3paiYKrIKScVenYgRWQ6Wp4SH2EbNjOqQTKcJFpPLQ1k
 kmkf2Axo+vU0etaY04uhScob9m7axUk+LZKZeNUw1nkPECWJWW4xPI5x0so2Zwj0Drqu
 xXEKb6Wh321M5qTaRwz4OZivSLSZd8eNv7aEzxipIArAlzB7tn2k85CAPtwQo0Gj14cM
 q/vDDRmeCvl2iYWoiJJujNEL57VLJNW51fLrzYpkp1TMGBXJ01mFvE7av2Ll+4DTqtgL
 vMmmMYsYxulHyXe4L3n/OzrHPJeGWFiZ4FiZr2yAX2FeyIYuJs7Nlwg4/nUdhNTp0yhu
 e7dA==
X-Gm-Message-State: AOJu0YzMl3q5M0FR9SfSXmDdz9zNI9MTXGIBKkMwUzUBccu60G62V/9j
 wSk7PSHetwq02r3bCbmx/y327gCLLv58T5IWKX9voMoF/M4SHR2otT2y65IMnkB5ojk1vctEieP
 iw/N0AdumSg==
X-Gm-Gg: ASbGncvy3TpA92ZSz3lcoxYq3qB6N3e4H0jJATATNHRcN8UOLLupHmgd/XDJRSjHdqK
 fmuKAsLjBQgvViubCu2dq9O8C7+8ND4Q31BPCEDDtCpSoPfNaAb8qKpnw/+6GwVDSmZcugY6OXp
 oTRejnNSv6Gl6XaMl+yQ+zJ6x2WHZ2JN0J+a6NhHv46KkeIt8eXTbwqFwghG+ufAinmozjelcrT
 fReRLVNShYPIvW6Smlr+FF6Z1U8m1z8vSiyqdVJqrQWlOK8Jd9UmVlnotzg1Lrda7vaH7XpkPZg
 uor5lki0MwT/LsWrwDn48FWKeHJeBXD31xp7ST/Dn0nHorl7jOPlm8DTBRvbG0iLc9Nwz6iUThT
 TAJWvvslnHZjcsuHvqUrIa8dEDXnpQh5NYFmwwqpTFNdZOpBYRsUtDzFvnd+SMV+S/eiImdNvgH
 y1p9iXlCzPAGzEM+Ozf2H/GcEHmHhOZsLkdVDNXwkGHg==
X-Google-Smtp-Source: AGHT+IGqE5i4AXpn2qU7LuseXzvCUwKFzdOCKKSVhI6UCEYd2bOKjG75e2c1XcLGp+9Oscf/WA8Utg==
X-Received: by 2002:a05:6808:22a3:b0:450:5e3a:6f0c with SMTP id
 5614622812f47-4505e3a7725mr49324b6e.5.1762789349241; 
 Mon, 10 Nov 2025 07:42:29 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45038ffad27sm2388506b6e.9.2025.11.10.07.42.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:42:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [u-boot-test-hooks][PATCH] labgrid: sage: Add new lab
Date: Mon, 10 Nov 2025 09:42:27 -0600
Message-ID: <20251110154227.2629695-1-trini@konsulko.com>
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
control a Raspberry Pi 3, a Raspberry Pi 4 and a SolidRun Hummingboard 2.
The board environment files enable additional tests by pointing to content
which is any of:
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
 bin/sage/conf.mx6cuboxi_na              | 24 +++++++
 bin/sage/conf.rpi_3_32b_na              |  1 +
 bin/sage/conf.rpi_3_na                  |  1 +
 bin/sage/conf.rpi_4_32b_na              |  1 +
 bin/sage/conf.rpi_4_na                  |  1 +
 bin/sage/conf.rpi_arm64_na              | 24 +++++++
 bin/sage/labgrid-sage-env.yaml          | 87 +++++++++++++++++++++++++
 py/sage/u_boot_boardenv_mx6cuboxi_na.py | 78 ++++++++++++++++++++++
 py/sage/u_boot_boardenv_rpi_3.py        |  1 +
 py/sage/u_boot_boardenv_rpi_3_32b.py    | 67 +++++++++++++++++++
 py/sage/u_boot_boardenv_rpi_4.py        |  1 +
 py/sage/u_boot_boardenv_rpi_4_32b.py    |  1 +
 py/sage/u_boot_boardenv_rpi_arm64.py    | 79 ++++++++++++++++++++++
 13 files changed, 366 insertions(+)
 create mode 100644 bin/sage/conf.mx6cuboxi_na
 create mode 120000 bin/sage/conf.rpi_3_32b_na
 create mode 120000 bin/sage/conf.rpi_3_na
 create mode 120000 bin/sage/conf.rpi_4_32b_na
 create mode 120000 bin/sage/conf.rpi_4_na
 create mode 100644 bin/sage/conf.rpi_arm64_na
 create mode 100644 bin/sage/labgrid-sage-env.yaml
 create mode 100644 py/sage/u_boot_boardenv_mx6cuboxi_na.py
 create mode 120000 py/sage/u_boot_boardenv_rpi_3.py
 create mode 100644 py/sage/u_boot_boardenv_rpi_3_32b.py
 create mode 120000 py/sage/u_boot_boardenv_rpi_4.py
 create mode 120000 py/sage/u_boot_boardenv_rpi_4_32b.py
 create mode 100644 py/sage/u_boot_boardenv_rpi_arm64.py

diff --git a/bin/sage/conf.mx6cuboxi_na b/bin/sage/conf.mx6cuboxi_na
new file mode 100644
index 000000000000..31989c2eb8fa
--- /dev/null
+++ b/bin/sage/conf.mx6cuboxi_na
@@ -0,0 +1,24 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
diff --git a/bin/sage/conf.rpi_3_32b_na b/bin/sage/conf.rpi_3_32b_na
new file mode 120000
index 000000000000..d33d959874cb
--- /dev/null
+++ b/bin/sage/conf.rpi_3_32b_na
@@ -0,0 +1 @@
+conf.rpi_arm64_na
\ No newline at end of file
diff --git a/bin/sage/conf.rpi_3_na b/bin/sage/conf.rpi_3_na
new file mode 120000
index 000000000000..d33d959874cb
--- /dev/null
+++ b/bin/sage/conf.rpi_3_na
@@ -0,0 +1 @@
+conf.rpi_arm64_na
\ No newline at end of file
diff --git a/bin/sage/conf.rpi_4_32b_na b/bin/sage/conf.rpi_4_32b_na
new file mode 120000
index 000000000000..d33d959874cb
--- /dev/null
+++ b/bin/sage/conf.rpi_4_32b_na
@@ -0,0 +1 @@
+conf.rpi_arm64_na
\ No newline at end of file
diff --git a/bin/sage/conf.rpi_4_na b/bin/sage/conf.rpi_4_na
new file mode 120000
index 000000000000..d33d959874cb
--- /dev/null
+++ b/bin/sage/conf.rpi_4_na
@@ -0,0 +1 @@
+conf.rpi_arm64_na
\ No newline at end of file
diff --git a/bin/sage/conf.rpi_arm64_na b/bin/sage/conf.rpi_arm64_na
new file mode 100644
index 000000000000..a22e62f0f9c0
--- /dev/null
+++ b/bin/sage/conf.rpi_arm64_na
@@ -0,0 +1,24 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
index 000000000000..82b642731c3d
--- /dev/null
+++ b/bin/sage/labgrid-sage-env.yaml
@@ -0,0 +1,87 @@
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
+      serial:
+        cls: SerialDriver
+      mux:
+        cls: USBSDWireDriver
+      storage:
+        cls: USBStorageDriver
+      shell:
+        cls: ShellDriver
+        prompt: 'root@.*:~# '
+        login_prompt: 'login: '
+        username: 'root'
+  rpi4-1:
+    resources:
+      RemotePlace:
+        name: rpi4-1
+    drivers:
+      power:
+        cls: NetworkPowerDriver
+      serial:
+        cls: SerialDriver
+      mux:
+        cls: USBSDWireDriver
+      storage:
+        cls: USBStorageDriver
+      shell:
+        cls: ShellDriver
+        prompt: 'root@.*:~# '
+        login_prompt: 'login: '
+        username: 'root'
+  hb-1:
+    resources:
+      RemotePlace:
+        name: hb-1
+    drivers:
+      power:
+        cls: NetworkPowerDriver
+      serial:
+        cls: SerialDriver
+      mux:
+        cls: USBSDWireDriver
+      storage:
+        cls: USBStorageDriver
+      shell:
+        cls: ShellDriver
+        prompt: 'root@.*:~# '
+        login_prompt: 'login: '
+        username: 'root'
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
diff --git a/py/sage/u_boot_boardenv_mx6cuboxi_na.py b/py/sage/u_boot_boardenv_mx6cuboxi_na.py
new file mode 100644
index 000000000000..0c7b682f5def
--- /dev/null
+++ b/py/sage/u_boot_boardenv_mx6cuboxi_na.py
@@ -0,0 +1,78 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
diff --git a/py/sage/u_boot_boardenv_rpi_3.py b/py/sage/u_boot_boardenv_rpi_3.py
new file mode 120000
index 000000000000..d6f7a632f391
--- /dev/null
+++ b/py/sage/u_boot_boardenv_rpi_3.py
@@ -0,0 +1 @@
+u_boot_boardenv_rpi_arm64.py
\ No newline at end of file
diff --git a/py/sage/u_boot_boardenv_rpi_3_32b.py b/py/sage/u_boot_boardenv_rpi_3_32b.py
new file mode 100644
index 000000000000..da50b3212a70
--- /dev/null
+++ b/py/sage/u_boot_boardenv_rpi_3_32b.py
@@ -0,0 +1,67 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
index 000000000000..d6f7a632f391
--- /dev/null
+++ b/py/sage/u_boot_boardenv_rpi_4.py
@@ -0,0 +1 @@
+u_boot_boardenv_rpi_arm64.py
\ No newline at end of file
diff --git a/py/sage/u_boot_boardenv_rpi_4_32b.py b/py/sage/u_boot_boardenv_rpi_4_32b.py
new file mode 120000
index 000000000000..583f36ea9b3b
--- /dev/null
+++ b/py/sage/u_boot_boardenv_rpi_4_32b.py
@@ -0,0 +1 @@
+u_boot_boardenv_rpi_3_32b.py
\ No newline at end of file
diff --git a/py/sage/u_boot_boardenv_rpi_arm64.py b/py/sage/u_boot_boardenv_rpi_arm64.py
new file mode 100644
index 000000000000..4d164dede744
--- /dev/null
+++ b/py/sage/u_boot_boardenv_rpi_arm64.py
@@ -0,0 +1,79 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
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
2.43.0

