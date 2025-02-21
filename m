Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D63C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 20:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FDB380FA6;
	Fri, 21 Feb 2025 21:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FWVZTJR0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57C5C806FE; Fri, 21 Feb 2025 21:32:59 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9565C8001F
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 21:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5fcea7c07fdso1165157eaf.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 12:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740169975; x=1740774775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7v00Mlq9lEPXj31ZT3QGrKzU0OnfmBEl/WpP+MR+rc=;
 b=FWVZTJR0xV6r7xCKzQkfFqQxWQ4UU+QJ2wDPjVShWvjtPsHprFtQDS/xhZjvJF3JeE
 I61+MRkdYbxL309TgIOjboYfF6f84XxcVoPV5EeOG4HFLG5rE9XJYzaGyi0eIsOaL/WO
 n/bmj3zx25uz/TMwiPHlZsRnMp8xoeHpEJSnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740169975; x=1740774775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t7v00Mlq9lEPXj31ZT3QGrKzU0OnfmBEl/WpP+MR+rc=;
 b=KPKc2EkPtx9LMMyOQbxWPH8pxTt1AiPJtgNkZMPipkr+93H7mPU98r6oUhiEnEmjjD
 JSy9vfNozkPnCy2l2VOij2TMJc//+EgT6Lp6+cVA2s6vXvEfhd+F4rTwJBXcVEkwhYaL
 QxZFpOIoAOfFHStZCMfnrjfqh6jdz66mQd4cdXTEX+jsqPUt56dNF7RLZDbRb31G5z/6
 Lx89jBZ0JTZpbuHav19weiBKXhhGWGanQMkdFOx629iH4uLdjz/4Bk6u0bpNMjwxcqS4
 5Lpgsu8RwIGOkhp6mXjHYzSVrtULr46KXHiJdTaCc/kRaI2ifxuB/RdQ4p0pNIagaTK9
 /U1w==
X-Gm-Message-State: AOJu0Yz6OOXUOp+1wjUhV4NZ2uPNeBU8xmwcA//GT1RW8jLt+kR+wLuB
 SBMQqEphf7lPvHF7i82q71lelcVBxt9H+LJ/hE04qhekSl3amrx+/3bq79ahtLsdzFq3CrEYLe0
 =
X-Gm-Gg: ASbGnctNQrE4hdzQw26BGHmNUFrO4T7ttMpVfVgZtXHs1XeJfkZ6hcDBzeZLd2sFQbI
 qvyFCcMfssIq6PSX/DQb4IeumibItJx3jhcXiYtxw9xLKm8+bQ6sAVqiA1swjSjaFfxBy0mbPnT
 +3DbQocdQ4LsVRHBlYJeNDJnHrVLgkUi/pL9ZAC/vvN9Fthnq5QohiuSrOrw9GA/ARRhmwzYu11
 KNyiWsFkLi/W/nD0ewsI++54WvZQIlhc89SQHv9xobnlb5d5O1qIyuWo09cDN8HIZqMC3NP+wNF
 qM9GySBOLaOl3Od0wLphIeMaHQ94X2qWlddDrXk7OhvPewGdu6GkXYzOU8v8Aj8=
X-Google-Smtp-Source: AGHT+IH0f4+MbVkF49GUhPIIlW4n0jPwidpKyb/VTjcOh7vUipgiU9h0SknQ1cfL+45vJv5n/5FpgA==
X-Received: by 2002:a05:6820:619:b0:5fc:d191:b3d with SMTP id
 006d021491bc7-5fd1964f67dmr2952589eaf.7.1740169974815; 
 Fri, 21 Feb 2025 12:32:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fce4c93aaasm2523681eaf.40.2025.02.21.12.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 12:32:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH 3/3] RFC: Add some network info for
 ellesmere lab
Date: Fri, 21 Feb 2025 13:32:42 -0700
Message-ID: <20250221203243.672465-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221203243.672465-1-sjg@chromium.org>
References: <20250221203243.672465-1-sjg@chromium.org>
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

Provide network configuration so that some networking tests can be run
on ellesmere.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 py/ellesmere/ellesmere_tftp.py                | 32 ++++++++++++++++
 py/ellesmere/u_boot_boardenv_qemu_arm64_na.py | 18 +++++++++
 py/ellesmere/u_boot_boardenv_qemu_arm_na.py   | 18 +++++++++
 py/ellesmere/u_boot_boardenv_rpi_3_32b.py     | 38 +++++++++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 py/ellesmere/ellesmere_tftp.py
 create mode 100644 py/ellesmere/u_boot_boardenv_qemu_arm64_na.py
 create mode 100644 py/ellesmere/u_boot_boardenv_qemu_arm_na.py
 create mode 100644 py/ellesmere/u_boot_boardenv_rpi_3_32b.py

diff --git a/py/ellesmere/ellesmere_tftp.py b/py/ellesmere/ellesmere_tftp.py
new file mode 100644
index 0000000..d2aeb58
--- /dev/null
+++ b/py/ellesmere/ellesmere_tftp.py
@@ -0,0 +1,32 @@
+import os
+import binascii
+
+def file2env(file_name, addr=None):
+    """Create dictionary describing file
+
+    @filename:  name of the file to be described
+    @addr:      address used for loading the file as int (e.g. 0x40400000)
+    Return:     dictionary describing the file with entries
+                * fn    - filename
+                * size  - file size in bytes
+                * crc32 - checksum using CRC-32 algorithm
+                * addr  - loading address, optional
+    """
+    file_full = '/tmp/b/qemu_arm64/' + file_name
+
+    if not os.path.isfile(file_full):
+        print(f'{file_full} not found')
+        return None
+
+    ret = {
+        "fn": file_name,
+        "size": os.path.getsize(file_full),
+    }
+
+    with open(file_full, 'rb') as fd:
+        ret["crc32"] = hex(binascii.crc32(fd.read()) & 0xffffffff)[2:]
+
+    if addr is not None:
+        ret['addr'] = addr
+
+    return ret
diff --git a/py/ellesmere/u_boot_boardenv_qemu_arm64_na.py b/py/ellesmere/u_boot_boardenv_qemu_arm64_na.py
new file mode 100644
index 0000000..23db106
--- /dev/null
+++ b/py/ellesmere/u_boot_boardenv_qemu_arm64_na.py
@@ -0,0 +1,18 @@
+import os
+import ellesmere_tftp
+
+#env__net_static_env_vars = [
+    #('ipaddr', '192.168.4.41'),
+    #('netmask', '255.255.255.0'),
+    #('serverip', '192.168.4.1'),
+#]
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = ellesmere_tftp.file2env('u-boot.bin', 0x40400000)
+env__efi_loader_helloworld_file = ellesmere_tftp.file2env('helloworld.efi', 0x40400000)
+env__efi_loader_grub_file = ellesmere_tftp.file2env('grubaa64.efi', 0x40400000)
+env__efi_fit_tftp_file = {
+    'addr' : 0x40400000,
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/py/ellesmere/u_boot_boardenv_qemu_arm_na.py b/py/ellesmere/u_boot_boardenv_qemu_arm_na.py
new file mode 100644
index 0000000..23db106
--- /dev/null
+++ b/py/ellesmere/u_boot_boardenv_qemu_arm_na.py
@@ -0,0 +1,18 @@
+import os
+import ellesmere_tftp
+
+#env__net_static_env_vars = [
+    #('ipaddr', '192.168.4.41'),
+    #('netmask', '255.255.255.0'),
+    #('serverip', '192.168.4.1'),
+#]
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = ellesmere_tftp.file2env('u-boot.bin', 0x40400000)
+env__efi_loader_helloworld_file = ellesmere_tftp.file2env('helloworld.efi', 0x40400000)
+env__efi_loader_grub_file = ellesmere_tftp.file2env('grubaa64.efi', 0x40400000)
+env__efi_fit_tftp_file = {
+    'addr' : 0x40400000,
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/py/ellesmere/u_boot_boardenv_rpi_3_32b.py b/py/ellesmere/u_boot_boardenv_rpi_3_32b.py
new file mode 100644
index 0000000..9cc2e1f
--- /dev/null
+++ b/py/ellesmere/u_boot_boardenv_rpi_3_32b.py
@@ -0,0 +1,38 @@
+import ellesmere_tftp
+
+env__net_uses_usb = True
+
+env__net_dhcp_server = True
+
+env__tftp_boot_test_skip = False
+
+env__net_tftp_bootable_file = {
+    'fn': 'v6.6/image.fit.nocomp',
+    'addr': 0x00200000,
+    'size': 85984256,
+    'crc32': '754c839a',
+    'pattern': 'Linux',
+    'config': 'conf-852',
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
-- 
2.43.0

