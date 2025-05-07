Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982A5C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 14:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26B8482958;
	Wed,  7 May 2025 16:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RW923aqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E7BF8294C; Wed,  7 May 2025 16:45:44 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2EAB8269F
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 16:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so7893839b3a.2
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746629140; x=1747233940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5suRMPKLtm2JxMF1fBKHNRlVzibeqq5ITEGVsziCqac=;
 b=RW923aqZ++NXmRaSJSv/cZk0bR4Z8XbtH1e+LpQ48VRdBrMqOUXbdhQ/7K+aND0b0y
 xgoJHxkPayP/mK4HH62+u/EKnAUlZ4rpLbZ5/Hmu2gW1r+Z9BjNzEfuCSFkkcb3GCZJv
 QKJOYKHO0JL0BqN00AGXfabbVYjN5aVzOE1W0gUCFjwJAy8rrhEuLjclV7Jd9TZCGGOr
 Y4jCieaRnyjmgf8/pPSRf+ZhmLr1cEhiwXRpaepXyudSq9FT6b/W2lFtwMLG7b+jCXRu
 TjqAr9UZ2ChOR6ADV/7jGoQEO8Y3yHkPZCs1okGXmDdbxhszeZFlsgMYiQRDnBA+iSGn
 F0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746629140; x=1747233940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5suRMPKLtm2JxMF1fBKHNRlVzibeqq5ITEGVsziCqac=;
 b=lfPx4Mvu7Xbj903uBSeFKHxweERoGzoErepMEkOi77bMD4POeG0bW3n5ngEutFzh5O
 oOCF4NjmqHpPE65DyXOHpOZRPVIkiqcdUe6Zof38QgfU7f1yy0YQT3xMsOEEyEajuEBR
 O/Cza54UeONWt5VUqv6fYZKaLh9ZlZq1GR9TwqmbavxVgpM33CLM3IVGfqJVlOfoMrQk
 JMHtaKWRTq0DNHZw3K+8mcp7zFJ7Wa1m2eWTxP4EeMmpfpxrrvC1NsmaY5eeDAIEgrqH
 Race3NpLIZHExcd3hXc4S+6TO9UDoU8ufRiaiyVUK/A4P+aKpJ0lxIX0qq0hICBLp9j1
 ntPA==
X-Gm-Message-State: AOJu0YxvzTISO7SKYWRL72hQ/dHePfKIjUeSx9T4lqaK7Zvfw6S+MFSz
 7lc5GsKwtJEzjXYl4jZ4AcYWuBNhHnAsNadjMsntIAoKwaP72XqZ1XB34BJQzfM=
X-Gm-Gg: ASbGncsZf5BMx3r5yU1xhMlMvT2c21eifvUDErgkB3i2/CPy/FKb9mbSMgwMKrGOjb3
 GI3TAkUdjju5xIEyEHdS12fakA95rkmQUySa9PraDRLOniKV3WLjtNsI4VdINOSLPCfG8/PgxxK
 pwuI8pUUeXGstIDfPPAvrVae1sogIoFgdYO6jGcCAkm2y4dhC0+Liw6dVsSE4UxP2Nu2crg7OfH
 UNaz1+5nQDpDeBUhmudNw20ftREctLcvY5HSeJsbX9azU6xwfVjtb+HO3QmOmOT3vOD/afeRFI7
 ttblutRjf3+if9Gayd9VKxtG7dVoT8Km9XN+N8i4EtXu8FN2ZosyqqwPgMGO
X-Google-Smtp-Source: AGHT+IGZyjoufxI6uzN9QJKVYBjgzgEbvGCEnN6XxRBDdJczZHFhZHsDIDQ9Ztuu5z96ttixdXe1cQ==
X-Received: by 2002:a05:6a00:8f0c:b0:736:34a2:8a23 with SMTP id
 d2e1a72fcca58-7409cfb0be4mr4335585b3a.15.1746629139833; 
 Wed, 07 May 2025 07:45:39 -0700 (PDT)
Received: from adriano.. ([190.215.87.40]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7a30esm11710235b3a.13.2025.05.07.07.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 07:45:39 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 3/3] test/py/test_efi_fit: test fdt and initrd
Date: Wed,  7 May 2025 10:46:19 -0400
Message-ID: <20250507144619.3288456-4-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250507144619.3288456-1-adriano.cordova@canonical.com>
References: <20250507144619.3288456-1-adriano.cordova@canonical.com>
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

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 test/py/tests/test_efi_fit.py | 156 +++++++++++++++++++++++++++-------
 1 file changed, 124 insertions(+), 32 deletions(-)

diff --git a/test/py/tests/test_efi_fit.py b/test/py/tests/test_efi_fit.py
index 5f352e7efff..63ee8e6cef2 100644
--- a/test/py/tests/test_efi_fit.py
+++ b/test/py/tests/test_efi_fit.py
@@ -66,9 +66,29 @@ ITS_DATA = '''
     #address-cells = <1>;
 
     images {
-        efi {
+        helloworld {
             description = "Test EFI";
-            data = /incbin/("%(efi-bin)s");
+            data = /incbin/("%(hello-bin)s");
+            type = "%(kernel-type)s";
+            arch = "%(sys-arch)s";
+            os = "efi";
+            compression = "%(efi-comp)s";
+            load = <0x0>;
+            entry = <0x0>;
+        };
+        dtbdump {
+            description = "Test EFI fdtdump";
+            data = /incbin/("%(dtbdump-bin)s");
+            type = "%(kernel-type)s";
+            arch = "%(sys-arch)s";
+            os = "efi";
+            compression = "%(efi-comp)s";
+            load = <0x0>;
+            entry = <0x0>;
+        };
+        initrddump {
+            description = "Test EFI initrddump";
+            data = /incbin/("%(initrddump-bin)s");
             type = "%(kernel-type)s";
             arch = "%(sys-arch)s";
             os = "efi";
@@ -83,18 +103,33 @@ ITS_DATA = '''
             arch = "%(sys-arch)s";
             compression = "%(fdt-comp)s";
         };
+        initrd {
+            description = "Initial RAM Disk";
+            data = /incbin/("%(initrd-fs)s");
+            type = "ramdisk";
+            compression = "%(initrd-comp)s";
+            os = "efi";
+        };
     };
 
     configurations {
         default = "config-efi-fdt";
+
+        config-efi {
+            description = "EFI FIT w/o FDT";
+            kernel = "helloworld";
+        };
+
         config-efi-fdt {
             description = "EFI FIT w/ FDT";
-            kernel = "efi";
+            kernel = "dtbdump";
             fdt = "fdt";
         };
-        config-efi-nofdt {
-            description = "EFI FIT w/o FDT";
-            kernel = "efi";
+
+        config-efi-initrd {
+            description = "EFI FIT w/ initrd";
+            kernel = "initrddump";
+            ramdisk = "initrd";
         };
     };
 };
@@ -108,7 +143,7 @@ FDT_DATA = '''
     #address-cells = <1>;
     #size-cells = <1>;
 
-    model = "%(sys-arch)s %(fdt_type)s EFI FIT Boot Test";
+    model = "%(sys-arch)s %(fdt_type)s EFI FIT FDT Boot Test";
     compatible = "%(sys-arch)s";
 
     reset@0 {
@@ -120,6 +155,7 @@ FDT_DATA = '''
 
 @pytest.mark.buildconfigspec('bootm_efi')
 @pytest.mark.buildconfigspec('BOOTEFI_HELLO_COMPILE')
+@pytest.mark.buildconfigspec('EFI_LOAD_FILE2_INITRD')
 @pytest.mark.buildconfigspec('fit')
 @pytest.mark.notbuildconfigspec('generate_acpi_table')
 @pytest.mark.requiredtool('dtc')
@@ -137,8 +173,10 @@ def test_efi_fit_launch(ubman):
     The following test cases are currently defined and enabled:
      - Launch uncompressed FIT EFI & internal FDT
      - Launch uncompressed FIT EFI & FIT FDT
+     - Launch uncompressed FIT EFI & internal FDT & FIT initrd
      - Launch compressed FIT EFI & internal FDT
      - Launch compressed FIT EFI & FIT FDT
+     - Launch compressed FIT EFI & internal FDT & FIT initrd
     """
 
     def net_pre_commands():
@@ -210,7 +248,7 @@ def test_efi_fit_launch(ubman):
 
         return os.path.join(ubman.config.build_dir, file_name)
 
-    def make_efi(fname, comp):
+    def make_efi(fname, efi_file, comp):
         """Create an UEFI binary.
 
         This simply copies lib/efi_loader/helloworld.efi into U-Boot
@@ -218,6 +256,7 @@ def test_efi_fit_launch(ubman):
 
         Args:
             fname -- The target file name within U-Boot build dir.
+            efi_file -- The source .efi application
             comp -- Flag to enable gzip compression.
         Return:
             The path of the created file.
@@ -225,7 +264,7 @@ def test_efi_fit_launch(ubman):
 
         bin_path = make_fpath(fname)
         utils.run_and_log(ubman,
-                          ['cp', make_fpath('lib/efi_loader/helloworld.efi'),
+                          ['cp', make_fpath(f'lib/efi_loader/{efi_file}'),
                            bin_path])
         if comp:
             utils.run_and_log(ubman, ['gzip', '-f', bin_path])
@@ -264,6 +303,27 @@ def test_efi_fit_launch(ubman):
             dtb += '.gz'
         return dtb
 
+    def make_initrd(comp):
+        """Create a sample initrd.
+
+        Creates an initrd.
+
+        Args:
+            comp -- Flag to enable gzip compression.
+        Return:
+            The path of the created file.
+        """
+
+        # Generate a test initrd file.
+        initrd = make_fpath('test-efi-initrd')
+        with open(initrd, 'w', encoding='ascii') as file:
+            file.write('test-efi-initrd')
+
+        if comp:
+            utils.run_and_log(ubman, ['gzip', '-f', initrd])
+            initrd += '.gz'
+        return initrd
+
     def make_fit(comp):
         """Create a sample FIT image.
 
@@ -275,22 +335,35 @@ def test_efi_fit_launch(ubman):
         """
 
         # Generate resources referenced by ITS.
+        hello_bin = os.path.basename(make_efi('test-efi-helloworld.efi', 'helloworld.efi', comp))
+        dtbdump_bin = os.path.basename(make_efi('test-efi-dtbdump.efi', 'dtbdump.efi', comp))
+        initrddump_bin = os.path.basename(make_efi('test-efi-initrddump.efi', 'initrddump.efi', comp))
+        fdt_bin = os.path.basename(make_dtb('user', comp))
+        initrd_fs = make_initrd(comp)
+        initrd_fs = os.path.basename(initrd_fs)
+        compression = 'gzip' if comp else 'none'
+        kernel_type = 'kernel' if comp else 'kernel_noload'
+
         its_params = {
             'sys-arch': sys_arch,
-            'efi-bin': os.path.basename(make_efi('test-efi-fit-helloworld.efi', comp)),
-            'kernel-type': 'kernel' if comp else 'kernel_noload',
-            'efi-comp': 'gzip' if comp else 'none',
-            'fdt-bin': os.path.basename(make_dtb('user', comp)),
-            'fdt-comp': 'gzip' if comp else 'none',
+            'hello-bin': hello_bin,
+            'dtbdump-bin': dtbdump_bin,
+            'initrddump-bin': initrddump_bin,
+            'kernel-type': kernel_type,
+            'efi-comp': compression,
+            'fdt-bin': fdt_bin,
+            'fdt-comp': compression,
+            'initrd-fs': initrd_fs,
+            'initrd-comp': compression,
         }
 
         # Generate a test ITS file.
-        its_path = make_fpath('test-efi-fit-helloworld.its')
+        its_path = make_fpath('test-efi-fit.its')
         with open(its_path, 'w', encoding='ascii') as file:
             file.write(ITS_DATA % its_params)
 
         # Build the test ITS.
-        fit_path = make_fpath('test-efi-fit-helloworld.fit')
+        fit_path = make_fpath('test-efi-fit.fit')
         utils.run_and_log(
             ubman, [make_fpath('tools/mkimage'), '-f', its_path, fit_path])
         return fit_path
@@ -357,7 +430,7 @@ def test_efi_fit_launch(ubman):
 
         return addr
 
-    def launch_efi(enable_fdt, enable_comp):
+    def launch_efi(enable_fdt, enable_initrd, enable_comp):
         """Launch U-Boot's helloworld.efi binary from a FIT image.
 
         An external image file can be downloaded from TFTP, when related
@@ -372,19 +445,20 @@ def test_efi_fit_launch(ubman):
         from the host filesystem.
 
         Once the load address is available on U-Boot console, the 'bootm'
-        command is executed for either 'config-efi-fdt' or 'config-efi-nofdt'
-        FIT configuration, depending on the value of the 'enable_fdt' function
-        argument.
+        command is executed for either 'config-efi', 'config-efi-fdt' or
+        'config-efi-initrd' FIT configuration, depending on the value of the
+        'enable_fdt' and 'enable_initrd' function arguments.
 
         Eventually the 'Hello, world' message is expected in the U-Boot console.
 
         Args:
             enable_fdt -- Flag to enable using the FDT blob inside FIT image.
+            enable_initrd -- Flag to enable using an initrd inside FIT image.
             enable_comp -- Flag to enable GZIP compression on EFI and FDT
                            generated content.
         """
 
-        with ubman.log.section('FDT=%s;COMP=%s' % (enable_fdt, enable_comp)):
+        with ubman.log.section('FDT=%s;INITRD=%s;COMP=%s' % (enable_fdt, enable_initrd, enable_comp)):
             if is_sandbox:
                 fit = {
                     'dn': ubman.config.build_dir,
@@ -420,14 +494,28 @@ def test_efi_fit_launch(ubman):
             addr = load_fit_from_host(fit) if is_sandbox else load_fit_from_tftp(fit)
 
             # Select boot configuration.
-            fit_config = 'config-efi-fdt' if enable_fdt else 'config-efi-nofdt'
+            fit_config = 'config-efi'
+            fit_config = fit_config + '-fdt' if enable_fdt else fit_config
+            fit_config = fit_config + '-initrd' if enable_initrd else fit_config
 
             # Try booting.
+            ubman.run_command('setenv bootargs nocolor')
             output = ubman.run_command('bootm %x#%s' % (addr, fit_config))
+            assert '## Application failed' not in output
             if enable_fdt:
                 assert 'Booting using the fdt blob' in output
-            assert 'Hello, world' in output
-            assert '## Application failed' not in output
+                assert 'DTB Dump' in output
+            if enable_initrd:
+                assert 'Loading ramdisk' in output
+                assert 'INITRD Dump' in output
+            if enable_fdt:
+                response = ubman.run_command(cmd = 'dump', wait_for_echo=False)
+                assert 'EFI FIT FDT Boot Test' in response
+            if enable_initrd:
+                response = ubman.run_command('load', wait_for_echo=False)
+                assert f"crc32: 0x0c77b025" in response
+            if not enable_fdt and not enable_initrd:
+                    assert 'Hello, world' in output
             ubman.restart_uboot()
 
     # Array slice removes leading/trailing quotes.
@@ -449,16 +537,20 @@ def test_efi_fit_launch(ubman):
             ubman.config.dtb = control_dtb
 
         # Run tests
-        # - fdt OFF, gzip OFF
-        launch_efi(False, False)
-        # - fdt ON, gzip OFF
-        launch_efi(True, False)
+        # - fdt OFF, initrd OFF, gzip OFF
+        launch_efi(False, False, False)
+        # - fdt ON, initrd OFF, gzip OFF
+        launch_efi(True, False, False)
+        # - fdt OFF, initrd ON, gzip OFF
+        launch_efi(False, True, False)
 
         if is_sandbox:
-            # - fdt OFF, gzip ON
-            launch_efi(False, True)
-            # - fdt ON, gzip ON
-            launch_efi(True, True)
+            # - fdt OFF, initrd OFF, gzip ON
+            launch_efi(False, False, True)
+            # - fdt ON, initrd OFF, gzip ON
+            launch_efi(True, False, True)
+            # - fdt OFF, initrd ON, gzip ON
+            launch_efi(False, True, True)
 
     finally:
         if is_sandbox:
-- 
2.48.1

