Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AECCC3ABC3
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 14:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28ED180C83;
	Sun, 11 May 2025 16:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JDZ8OC/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6403980ADF; Sun, 11 May 2025 16:18:44 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 664E582977
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 16:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad23db02350so203887066b.1
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746973121; x=1747577921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxbJhkcZz5IHCuzx+gCPzBIH3Ho9q/5eJ1Ijb6UTigg=;
 b=JDZ8OC/VvMMhB1H31TowQxZzs8HHVG2C7rHs9RlWcd9RN/TYKbhwZL6tGL+rmG8F6J
 jKEhKrtdZDZXXo8etEB/glrIVFfTlqBDlJQEiv474CX6P+HY9l64Yh9bAW5FgFJzhVed
 vlUydWhSEQEX8oMnYrbqmytnfW9JawuE9x85o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746973121; x=1747577921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxbJhkcZz5IHCuzx+gCPzBIH3Ho9q/5eJ1Ijb6UTigg=;
 b=tOul0fiLzVjO93xv1+llprG2cuaFlJF7A1F2Lk59C6+Y440hylsuwIipTxa8deOtB2
 fvH4mmUd3oB+y00r3C/Eh6lQwT5XSZX6ZFPA9/nw+061dezJuJjKrSPU2UBQBk/CtIhD
 GGZhJgk67EQmKo4yKWQfxjLjwv2BLGQsf23Lg26CeTBtM3SDU+ugfiH+y29RzpRNFy96
 2afhXVfkfz8pF+W+uIjO/8OyPWVJ7VkDdVJr/AH+02K2z0Fs/2hhEPEP8FhDHqdJmRt2
 nRFqwUv1P9biq0KgwbuI93NOAT7u0gUb/FY0LAPPEazFZfVUxl2g0TNn7HAB+yayAg83
 jKsA==
X-Gm-Message-State: AOJu0YzuBmE9T/EKZz8wGY+2JvCmQ9cVZAgycmisCT8t8N/mLEEjAsnE
 7KgMvu24AAwM/Vu0d4U88bsuEood3f7zMw8w2gr0OpXY43ZtcOvPQeCASlFbgQIjAb5r0ZLqWQ7
 hMjUxXtuU6g==
X-Gm-Gg: ASbGncvnSLW/JogBfmtzroLCiWhBjrSNKsbYys5QsW+g8Iaw5oNHUHf3ciG1bRDXaOk
 JPH7bjaS0xTwNffPbos9i+aUcESNWpT3mSDjvjY8x6tQbL4dsXLpvvumsPjkJsAUm0fIq0m0p8p
 7AAqgGAfyRaP8DIknH9VJRqFcG8qlRZ/sxyA32VJbXNYyBypoI6lc1j+ZW+JBr7/Qt/jJmqCuz+
 yCW2lgTsQJXC4EC5NlmVZ3XTZD7iLqG4m7o5w3S3DRJfjabwy5j50uYayIJSayQFojcXJQB8CR3
 1NByce8eZu3W4ep3S9mTUx1O/Pjvp6zLE/yuSCbB9TUHlgk=
X-Google-Smtp-Source: AGHT+IHDNk2oWs48NQhbKtRhNF7w3iokfE1QVjp7OVG+kuTId12dnQ/OUeOxC5dmEJaaYpkh89a0/Q==
X-Received: by 2002:a17:906:c155:b0:ac7:e5c4:1187 with SMTP id
 a640c23a62f3a-ad218e54dc7mr881028166b.11.1746973121268; 
 Sun, 11 May 2025 07:18:41 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad21985858asm477789266b.176.2025.05.11.07.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 07:18:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] scripts: Create a common settings file for QEMU scripts
Date: Sun, 11 May 2025 16:18:19 +0200
Message-ID: <20250511141828.2367318-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511141828.2367318-1-sjg@chromium.org>
References: <20250511141828.2367318-1-sjg@chromium.org>
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

Move the settings into a common file so they can be used by all tools.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-efi       | 53 ++++-----------------------------
 scripts/build_helper.py | 65 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 47 deletions(-)

diff --git a/scripts/build-efi b/scripts/build-efi
index a2b5540ad29..2f4b916c49b 100755
--- a/scripts/build-efi
+++ b/scripts/build-efi
@@ -16,7 +16,6 @@ Use ~/.build-efi to configure the various paths used by this script.
 """
 
 from argparse import ArgumentParser
-import configparser
 import os
 import shutil
 
@@ -63,55 +62,15 @@ def parse_args():
     return args
 
 
-def get_settings():
-    """Get settings from the settings file
-
-    Return:
-        ConfigParser containing settings
-    """
-    settings = configparser.ConfigParser()
-    fname = f'{os.getenv("HOME")}/.build-efi'
-    if not os.path.exists(fname):
-        print('No config file found ~/.build-efi\nCreating one...\n')
-        tools.write_file(fname, '''[build-efi]
-# Mount path for the temporary image
-mount_point = /mnt/test-efi
-
-# Image-output filename
-image_file = try.img
-
-# Set ubdir to the build directory where you build U-Boot out-of-tree
-# We avoid in-tree build because it gets confusing trying different builds
-build_dir = /tmp/b
-
-# Build the kernel with: make O=/tmp/kernel
-bzimage = /tmp/kernel/arch/x86/boot/bzImage
-
-# Place where OVMF-pure-efi.i386.fd etc. are kept
-efi_dir = .
-''', binary=False)
-    settings.read(fname)
-    return settings
-
-
 class BuildEfi:
     """Class to collect together the various bits of state while running"""
-    def __init__(self, settings, args):
+    def __init__(self, args):
         self.helper = Helper()
-        self.settings = settings
-        self.img = self.get_setting('image_file', 'try.img')
-        self.build_dir = self.get_setting("build_dir", '/tmp')
+        self.helper.read_settings()
+        self.img = self.helper.get_setting('efi_image_file', 'efi.img')
+        self.build_dir = self.helper.get_setting("build_dir", '/tmp')
         self.args = args
 
-    def get_setting(self, name, fallback=None):
-        """Get a setting by name
-
-        Args:
-            name (str): Name of setting to retrieve
-            fallback (str or None): Value to return if the setting is missing
-        """
-        return self.settings.get('build-efi', name, fallback=fallback)
-
     def run_qemu(self, bitness, serial_only):
         """Run QEMU
 
@@ -120,7 +79,7 @@ class BuildEfi:
             serial_only (bool): True to run without a display
         """
         extra = []
-        efi_dir = self.get_setting("efi_dir")
+        efi_dir = self.helper.get_setting('efi_dir')
         if self.args.arm:
             qemu_arch = 'aarch64'
             extra += ['--machine', 'virt', '-cpu', 'max']
@@ -210,5 +169,5 @@ class BuildEfi:
 
 
 if __name__ == "__main__":
-    efi = BuildEfi(get_settings(), parse_args())
+    efi = BuildEfi(parse_args())
     efi.start()
diff --git a/scripts/build_helper.py b/scripts/build_helper.py
index 15177a48e80..923270c95c7 100644
--- a/scripts/build_helper.py
+++ b/scripts/build_helper.py
@@ -4,6 +4,7 @@
 
 """
 
+import configparser
 import contextlib
 import os
 import shutil
@@ -28,6 +29,70 @@ class Helper:
     def __init__(self):
         self.settings = None
 
+    def read_settings(self):
+        """Get settings from the settings file"""
+        self.settings = configparser.ConfigParser()
+        fname = f'{os.getenv("HOME")}/.u_boot_qemu'
+        if not os.path.exists(fname):
+            print('No config file found: {fname}\nCreating one...\n')
+            tools.write_file(fname, '''# U-Boot QEMU-scripts config
+
+[DEFAULT]
+# Image-output filename
+image_file = try.img
+
+# Image directory (for prebuilt UEFI-images)
+image_dir = ~/dev/uefi
+
+# Set ubdir to the build directory where you build U-Boot out-of-tree
+# We avoid in-tree build because it gets confusing trying different builds
+build_dir = /tmp/b
+
+# Build the kernel with: make O=/tmp/kernel
+bzimage = /tmp/kernel/arch/x86/boot/bzImage
+
+# Directory where OVMF-pure-efi.i386.fd etc. are kept
+efi_dir = ~/dev/efi
+
+# Directory where SCT image (sct.img) is kept
+sct_dir = ~/dev/efi/sct
+
+# Directory where the SCT image is temporarily mounted for modification
+sct_mnt = /mnt/sct
+
+# Directory containing Tianocore builds (e.g. OVMF-pure-efi.x64.fd)
+tianocore_dir = ~/dev/efi/tianocore
+
+''', binary=False)
+        self.settings.read(fname)
+
+    def get_setting(self, name, fallback=None):
+        """Get a setting by name
+
+        Args:
+            name (str): Name of setting to retrieve
+            fallback (str or None): Value to return if the setting is missing
+        """
+        raw = self.settings.get('DEFAULT', name, fallback=fallback)
+        return os.path.expandvars(os.path.expanduser(raw))
+
+    def stage(self, name):
+        """Context manager to count requests across a range of patchwork calls
+
+        Args:
+            name (str): Stage name
+
+        Return:
+            _Stage: contect object
+
+        Usage:
+            with self.stage('name'):
+                ...do things
+
+            Note that the output only appears if the -N flag is used
+        """
+        return self._Stage(name)
+
     @contextlib.contextmanager
     def make_disk(self, fname, size_mb=20, fs_type='ext4', use_part=False):
         """Create a raw disk image with files on it
-- 
2.43.0

