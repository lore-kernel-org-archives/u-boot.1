Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6BCC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AA6580E90;
	Sun,  9 Feb 2025 17:33:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M9CjPd4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8655680821; Sun,  9 Feb 2025 17:08:03 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F9080BAE
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3d13e4dd0f2so21499015ab.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739117272; x=1739722072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzRS5IRULI+XU3ZHADCkaCNAFP00tZb8hUdF267bNPY=;
 b=M9CjPd4TO+6aMJ3eQqKxT5/50QYXa2wv8W6nrZy6IRscC2T5j9GtXPFc8LkRkEkTY9
 xlPFGA8teAlXyFj2AxSWVGUsTNAAXcky/QZ2Uqz5jGVZAZ1qZ6fffGODoJ+H+1EcPnsn
 IQS3cZm8jEQhHC+zy4K2ARjN+8p6BEcOj8eVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739117272; x=1739722072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzRS5IRULI+XU3ZHADCkaCNAFP00tZb8hUdF267bNPY=;
 b=D7VKV2s+LQGmzy23T8Ez6pLQq2gPmHyTiGkj3hQAsciw3fn2MlS2oLjrosiUVIv+AX
 cEBehZxav7/342atZ3GHu9Q0Ul2p7V12TgkqycofpqBcX7cmKlLQe+P0zEA5T+hpE699
 Oe1aunZnfpuVFbRptuiq4RwK/S/vXZN2xWfBkt61en8RPpwkEu1FW4nNm7qoTZCOvSXq
 sa9TJ2oMBMeRLX0QMD1PTKqQBanXkNMgrOlAh7Vgmw2DXplaIPdAKNk4vlEuBLErD3Qh
 K3DhIBIhY4Ytrm7Fa0cFhfrQwvKZ6UL4qV3CVjvqrZJU8ZYFfbQVw01vHGge2GJX7pKl
 Dbmg==
X-Gm-Message-State: AOJu0YwFbt7BGYjKyZnywtpiOLB+8vpx+Nm6Anc3wb6YOASGuj0x4IFW
 R/tUynBnbCfN1QsSqalbHbBN97lRszaPTH13qdhqAJdiJs1CEhVmSppGBl1sGeeXjMF1+qKljxI
 =
X-Gm-Gg: ASbGncuGwlmYltGULGf5+VXpJOYliL+LwqAqifk+dh9ihpabroMJuAI4+/HIYg5kMvA
 b5e5Ge/+58EZGa91Jrb6R1rXl7yfBsKWteHqLT7iaDXmXGNBy5WHmFMrEEhVsijFELqw9YeAkz+
 GZ44+DCV4LY1SOitzywqEBUzQ40DByp5CZRzkMga4KTD4Sb24y0yXXSWDEjI+EU5N1n/xz9kTuq
 CD6nqJ9VYbQHNqS/mjocnez1LU1BIhoVII3YBhGo4OUMsTaR4cpkY2rTEO9t5+MLKh7knApQXav
 AwodMK7dMOIZMPahp6Jfu+z51IisPu2CNuJZtZkC5M9Tpslr5SvB
X-Google-Smtp-Source: AGHT+IErk9mJR/WybACpl+aJD84bpbdnrBJWpKGEbeHK+a7EuyJ4zXpN6IADVjwxeFVLjZ3p8yGyuA==
X-Received: by 2002:a05:6e02:3201:b0:3ce:8ed9:ca94 with SMTP id
 e9e14a558f8ab-3d13df0fb76mr74947045ab.14.1739117270238; 
 Sun, 09 Feb 2025 08:07:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ecf2d08b0dsm354812173.59.2025.02.09.08.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 08:07:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>, Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 4/6] test/py: Drop assigning ubman to cons
Date: Sun,  9 Feb 2025 09:07:17 -0700
Message-ID: <20250209160725.1054845-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209160725.1054845-1-sjg@chromium.org>
References: <20250209160725.1054845-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 09 Feb 2025 17:33:22 +0100
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

Now that we have a shorter name, we don't need this sort of thing. Just
use ubman instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to drop assigning ubman to cons

 test/py/tests/test_android/test_abootimg.py |  43 +++---
 test/py/tests/test_efi_fit.py               |  81 +++++-----
 test/py/tests/test_env.py                   |  12 +-
 test/py/tests/test_event_dump.py            |   5 +-
 test/py/tests/test_fit.py                   |  63 ++++----
 test/py/tests/test_fit_auto_signed.py       |  27 ++--
 test/py/tests/test_fit_ecdsa.py             |  25 ++--
 test/py/tests/test_fit_hashes.py            |  23 ++-
 test/py/tests/test_handoff.py               |   3 +-
 test/py/tests/test_help.py                  |  14 +-
 test/py/tests/test_kconfig.py               |   6 +-
 test/py/tests/test_log.py                   |  14 +-
 test/py/tests/test_mmc.py                   |   8 +-
 test/py/tests/test_of_migrate.py            |  27 ++--
 test/py/tests/test_ofplatdata.py            |   7 +-
 test/py/tests/test_sandbox_opts.py          |   6 +-
 test/py/tests/test_source.py                |  41 +++--
 test/py/tests/test_spl.py                   |   5 +-
 test/py/tests/test_suite.py                 |  68 ++++-----
 test/py/tests/test_tpm2.py                  |   4 +-
 test/py/tests/test_trace.py                 |  57 ++++---
 test/py/tests/test_upl.py                   |  11 +-
 test/py/tests/test_ut.py                    | 158 ++++++++++----------
 test/py/tests/test_vbe.py                   |  15 +-
 test/py/tests/test_vbe_vpl.py               |  21 ++-
 test/py/tests/test_vboot.py                 | 146 +++++++++---------
 test/py/tests/test_vpl.py                   |   5 +-
 27 files changed, 432 insertions(+), 463 deletions(-)

diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
index c31fb466ec7..2aadb692b30 100644
--- a/test/py/tests/test_android/test_abootimg.py
+++ b/test/py/tests/test_android/test_abootimg.py
@@ -232,38 +232,37 @@ def test_abootimg(abootimg_disk_image, ubman):
 def test_abootimgv4(abootimgv4_disk_image_vboot, abootimgv4_disk_image_boot, ubman):
     """Test the 'abootimg' command with boot image header v4."""
 
-    cons = ubman
-    cons.log.action('Loading disk image to RAM...')
-    cons.run_command('setenv loadaddr 0x%x' % (loadaddr))
-    cons.run_command('setenv vloadaddr 0x%x' % (vloadaddr))
-    cons.run_command('host load hostfs - 0x%x %s' % (vloadaddr,
+    ubman.log.action('Loading disk image to RAM...')
+    ubman.run_command('setenv loadaddr 0x%x' % (loadaddr))
+    ubman.run_command('setenv vloadaddr 0x%x' % (vloadaddr))
+    ubman.run_command('host load hostfs - 0x%x %s' % (vloadaddr,
 	abootimgv4_disk_image_vboot.path))
-    cons.run_command('host load hostfs - 0x%x %s' % (loadaddr,
+    ubman.run_command('host load hostfs - 0x%x %s' % (loadaddr,
         abootimgv4_disk_image_boot.path))
-    cons.run_command('abootimg addr 0x%x 0x%x' % (loadaddr, vloadaddr))
-    cons.log.action('Testing \'abootimg get ver\'...')
-    response = cons.run_command('abootimg get ver')
+    ubman.run_command('abootimg addr 0x%x 0x%x' % (loadaddr, vloadaddr))
+    ubman.log.action('Testing \'abootimg get ver\'...')
+    response = ubman.run_command('abootimg get ver')
     assert response == "4"
-    cons.run_command('abootimg get ver v')
-    response = cons.run_command('env print v')
+    ubman.run_command('abootimg get ver v')
+    response = ubman.run_command('env print v')
     assert response == 'v=4'
 
-    cons.log.action('Testing \'abootimg get recovery_dtbo\'...')
-    response = cons.run_command('abootimg get recovery_dtbo a')
+    ubman.log.action('Testing \'abootimg get recovery_dtbo\'...')
+    response = ubman.run_command('abootimg get recovery_dtbo a')
     assert response == 'Error: header version must be >= 1 and <= 2 to get dtbo'
 
-    cons.log.action('Testing \'abootimg get dtb_load_addr\'...')
-    cons.run_command('abootimg get dtb_load_addr a')
-    response = cons.run_command('env print a')
+    ubman.log.action('Testing \'abootimg get dtb_load_addr\'...')
+    ubman.run_command('abootimg get dtb_load_addr a')
+    response = ubman.run_command('env print a')
     assert response == 'a=11f00000'
 
-    cons.log.action('Testing \'abootimg get dtb --index\'...')
-    cons.run_command('abootimg get dtb --index=1 dtb2_start')
-    response = cons.run_command('env print dtb2_start')
+    ubman.log.action('Testing \'abootimg get dtb --index\'...')
+    ubman.run_command('abootimg get dtb --index=1 dtb2_start')
+    response = ubman.run_command('env print dtb2_start')
     correct_str = "dtb2_start=%x" % (dtb2_addr)
     assert response == correct_str
 
-    cons.run_command('fdt addr $dtb2_start')
-    cons.run_command('fdt get value v / model')
-    response = cons.run_command('env print v')
+    ubman.run_command('fdt addr $dtb2_start')
+    ubman.run_command('fdt get value v / model')
+    response = ubman.run_command('env print v')
     assert response == 'v=x2'
diff --git a/test/py/tests/test_efi_fit.py b/test/py/tests/test_efi_fit.py
index e7d523a77d5..5f352e7efff 100644
--- a/test/py/tests/test_efi_fit.py
+++ b/test/py/tests/test_efi_fit.py
@@ -148,13 +148,13 @@ def test_efi_fit_launch(ubman):
         at the beginning of this file.
         """
 
-        init_usb = cons.config.env.get('env__net_uses_usb', False)
+        init_usb = ubman.config.env.get('env__net_uses_usb', False)
         if init_usb:
-            cons.run_command('usb start')
+            ubman.run_command('usb start')
 
-        init_pci = cons.config.env.get('env__net_uses_pci', False)
+        init_pci = ubman.config.env.get('env__net_uses_pci', False)
         if init_pci:
-            cons.run_command('pci enum')
+            ubman.run_command('pci enum')
 
     def net_dhcp():
         """Execute the dhcp command.
@@ -163,18 +163,18 @@ def test_efi_fit_launch(ubman):
         comment at the beginning of this file.
         """
 
-        has_dhcp = cons.config.buildconfig.get('config_cmd_dhcp', 'n') == 'y'
+        has_dhcp = ubman.config.buildconfig.get('config_cmd_dhcp', 'n') == 'y'
         if not has_dhcp:
-            cons.log.warning('CONFIG_CMD_DHCP != y: Skipping DHCP network setup')
+            ubman.log.warning('CONFIG_CMD_DHCP != y: Skipping DHCP network setup')
             return False
 
-        test_dhcp = cons.config.env.get('env__net_dhcp_server', False)
+        test_dhcp = ubman.config.env.get('env__net_dhcp_server', False)
         if not test_dhcp:
-            cons.log.info('No DHCP server available')
+            ubman.log.info('No DHCP server available')
             return False
 
-        cons.run_command('setenv autoload no')
-        output = cons.run_command('dhcp')
+        ubman.run_command('setenv autoload no')
+        output = ubman.run_command('dhcp')
         assert 'DHCP client bound to address ' in output
         return True
 
@@ -185,18 +185,18 @@ def test_efi_fit_launch(ubman):
         the beginning of this file.
         """
 
-        has_dhcp = cons.config.buildconfig.get('config_cmd_dhcp', 'n') == 'y'
+        has_dhcp = ubman.config.buildconfig.get('config_cmd_dhcp', 'n') == 'y'
         if not has_dhcp:
-            cons.log.warning('CONFIG_NET != y: Skipping static network setup')
+            ubman.log.warning('CONFIG_NET != y: Skipping static network setup')
             return False
 
-        env_vars = cons.config.env.get('env__net_static_env_vars', None)
+        env_vars = ubman.config.env.get('env__net_static_env_vars', None)
         if not env_vars:
-            cons.log.info('No static network configuration is defined')
+            ubman.log.info('No static network configuration is defined')
             return False
 
         for (var, val) in env_vars:
-            cons.run_command('setenv %s %s' % (var, val))
+            ubman.run_command('setenv %s %s' % (var, val))
         return True
 
     def make_fpath(file_name):
@@ -208,7 +208,7 @@ def test_efi_fit_launch(ubman):
             The computed file path.
         """
 
-        return os.path.join(cons.config.build_dir, file_name)
+        return os.path.join(ubman.config.build_dir, file_name)
 
     def make_efi(fname, comp):
         """Create an UEFI binary.
@@ -224,11 +224,11 @@ def test_efi_fit_launch(ubman):
         """
 
         bin_path = make_fpath(fname)
-        utils.run_and_log(cons,
+        utils.run_and_log(ubman,
                           ['cp', make_fpath('lib/efi_loader/helloworld.efi'),
                            bin_path])
         if comp:
-            utils.run_and_log(cons, ['gzip', '-f', bin_path])
+            utils.run_and_log(ubman, ['gzip', '-f', bin_path])
             bin_path += '.gz'
         return bin_path
 
@@ -257,10 +257,10 @@ def test_efi_fit_launch(ubman):
 
         # Build the test FDT.
         dtb = make_fpath('test-efi-fit-%s.dtb' % fdt_type)
-        utils.run_and_log(cons,
+        utils.run_and_log(ubman,
                           ['dtc', '-I', 'dts', '-O', 'dtb', '-o', dtb, dts])
         if comp:
-            utils.run_and_log(cons, ['gzip', '-f', dtb])
+            utils.run_and_log(ubman, ['gzip', '-f', dtb])
             dtb += '.gz'
         return dtb
 
@@ -292,7 +292,7 @@ def test_efi_fit_launch(ubman):
         # Build the test ITS.
         fit_path = make_fpath('test-efi-fit-helloworld.fit')
         utils.run_and_log(
-            cons, [make_fpath('tools/mkimage'), '-f', its_path, fit_path])
+            ubman, [make_fpath('tools/mkimage'), '-f', its_path, fit_path])
         return fit_path
 
     def load_fit_from_host(fit):
@@ -308,9 +308,9 @@ def test_efi_fit_launch(ubman):
 
         addr = fit.get('addr', None)
         if not addr:
-            addr = utils.find_ram_base(cons)
+            addr = utils.find_ram_base(ubman)
 
-        output = cons.run_command(
+        output = ubman.run_command(
             'host load hostfs - %x %s/%s' % (addr, fit['dn'], fit['fn']))
         expected_text = ' bytes read'
         size = fit.get('size', None)
@@ -335,10 +335,10 @@ def test_efi_fit_launch(ubman):
 
         addr = fit.get('addr', None)
         if not addr:
-            addr = utils.find_ram_base(cons)
+            addr = utils.find_ram_base(ubman)
 
         file_name = fit['fn']
-        output = cons.run_command('tftpboot %x %s' % (addr, file_name))
+        output = ubman.run_command('tftpboot %x %s' % (addr, file_name))
         expected_text = 'Bytes transferred = '
         size = fit.get('size', None)
         if size:
@@ -349,10 +349,10 @@ def test_efi_fit_launch(ubman):
         if not expected_crc:
             return addr
 
-        if cons.config.buildconfig.get('config_cmd_crc32', 'n') != 'y':
+        if ubman.config.buildconfig.get('config_cmd_crc32', 'n') != 'y':
             return addr
 
-        output = cons.run_command('crc32 $fileaddr $filesize')
+        output = ubman.run_command('crc32 $fileaddr $filesize')
         assert expected_crc in output
 
         return addr
@@ -384,10 +384,10 @@ def test_efi_fit_launch(ubman):
                            generated content.
         """
 
-        with cons.log.section('FDT=%s;COMP=%s' % (enable_fdt, enable_comp)):
+        with ubman.log.section('FDT=%s;COMP=%s' % (enable_fdt, enable_comp)):
             if is_sandbox:
                 fit = {
-                    'dn': cons.config.build_dir,
+                    'dn': ubman.config.build_dir,
                 }
             else:
                 # Init networking.
@@ -397,7 +397,7 @@ def test_efi_fit_launch(ubman):
                 if not net_set_up:
                     pytest.skip('Network not initialized')
 
-                fit = cons.config.env.get('env__efi_fit_tftp_file', None)
+                fit = ubman.config.env.get('env__efi_fit_tftp_file', None)
                 if not fit:
                     pytest.skip('No env__efi_fit_tftp_file binary specified in environment')
 
@@ -412,8 +412,8 @@ def test_efi_fit_launch(ubman):
                 fit['size'] = os.path.getsize(fit_path)
 
                 # Copy image to TFTP root directory.
-                if fit['dn'] != cons.config.build_dir:
-                    utils.run_and_log(cons,
+                if fit['dn'] != ubman.config.build_dir:
+                    utils.run_and_log(ubman,
                                       ['mv', '-f', fit_path, '%s/' % fit['dn']])
 
             # Load FIT image.
@@ -423,31 +423,30 @@ def test_efi_fit_launch(ubman):
             fit_config = 'config-efi-fdt' if enable_fdt else 'config-efi-nofdt'
 
             # Try booting.
-            output = cons.run_command('bootm %x#%s' % (addr, fit_config))
+            output = ubman.run_command('bootm %x#%s' % (addr, fit_config))
             if enable_fdt:
                 assert 'Booting using the fdt blob' in output
             assert 'Hello, world' in output
             assert '## Application failed' not in output
-            cons.restart_uboot()
+            ubman.restart_uboot()
 
-    cons = ubman
     # Array slice removes leading/trailing quotes.
-    sys_arch = cons.config.buildconfig.get('config_sys_arch', '"sandbox"')[1:-1]
+    sys_arch = ubman.config.buildconfig.get('config_sys_arch', '"sandbox"')[1:-1]
     if sys_arch == 'arm':
-        arm64 = cons.config.buildconfig.get('config_arm64')
+        arm64 = ubman.config.buildconfig.get('config_arm64')
         if arm64:
             sys_arch = 'arm64'
 
     is_sandbox = sys_arch == 'sandbox'
 
     if is_sandbox:
-        old_dtb = cons.config.dtb
+        old_dtb = ubman.config.dtb
 
     try:
         if is_sandbox:
             # Use our own device tree file, will be restored afterwards.
             control_dtb = make_dtb('internal', False)
-            cons.config.dtb = control_dtb
+            ubman.config.dtb = control_dtb
 
         # Run tests
         # - fdt OFF, gzip OFF
@@ -464,5 +463,5 @@ def test_efi_fit_launch(ubman):
     finally:
         if is_sandbox:
             # Go back to the original U-Boot with the correct dtb.
-            cons.config.dtb = old_dtb
-            cons.restart_uboot()
+            ubman.config.dtb = old_dtb
+            ubman.restart_uboot()
diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
index 376ea7b78b8..383e26c03b0 100644
--- a/test/py/tests/test_env.py
+++ b/test/py/tests/test_env.py
@@ -177,9 +177,8 @@ def validate_set(state_test_env, var, value):
 @pytest.mark.boardspec('sandbox')
 def test_env_initial_env_file(ubman):
     """Test that the u-boot-initial-env make target works"""
-    cons = ubman
-    builddir = 'O=' + cons.config.build_dir
-    envfile = cons.config.build_dir + '/u-boot-initial-env'
+    builddir = 'O=' + ubman.config.build_dir
+    envfile = ubman.config.build_dir + '/u-boot-initial-env'
 
     # remove if already exists from an older run
     try:
@@ -187,7 +186,7 @@ def test_env_initial_env_file(ubman):
     except:
         pass
 
-    utils.run_and_log(cons, ['make', builddir, 'u-boot-initial-env'])
+    utils.run_and_log(ubman, ['make', builddir, 'u-boot-initial-env'])
 
     assert os.path.exists(envfile)
 
@@ -560,15 +559,14 @@ def test_env_text(ubman):
             fname = os.path.join(path, 'infile')
             with open(fname, 'w') as inf:
                 print(intext, file=inf)
-            result = utils.run_and_log(cons, ['awk', '-f', script, fname])
+            result = utils.run_and_log(ubman, ['awk', '-f', script, fname])
             if expect_val is not None:
                 expect = '#define CONFIG_EXTRA_ENV_TEXT "%s"\n' % expect_val
                 assert result == expect
             else:
                 assert result == ''
 
-    cons = ubman
-    script = os.path.join(cons.config.source_dir, 'scripts', 'env2string.awk')
+    script = os.path.join(ubman.config.source_dir, 'scripts', 'env2string.awk')
 
     # simple script with a single var
     check_script('fred=123', 'fred=123\\0')
diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
index 52adced17b7..f20e5e1f4fc 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -11,9 +11,8 @@ import utils
 @pytest.mark.boardspec('sandbox')
 def test_event_dump(ubman):
     """Test that the "help" command can be executed."""
-    cons = ubman
-    sandbox = cons.config.build_dir + '/u-boot'
-    out = utils.run_and_log(cons, ['scripts/event_dump.py', sandbox])
+    sandbox = ubman.config.build_dir + '/u-boot'
+    out = utils.run_and_log(ubman, ['scripts/event_dump.py', sandbox])
     expect = '''.*Event type            Id                              Source location
 --------------------  ------------------------------  ------------------------------
 EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index bfc20c4b1ed..619f73153a0 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -127,7 +127,7 @@ def test_fit(ubman):
         Return:
             Temporary filename
         """
-        return os.path.join(cons.config.build_dir, leaf)
+        return os.path.join(ubman.config.build_dir, leaf)
 
     def filesize(fname):
         """Get the size of a file
@@ -165,7 +165,7 @@ def test_fit(ubman):
         return fname
 
     def make_compressed(filename):
-        utils.run_and_log(cons, ['gzip', '-f', '-k', filename])
+        utils.run_and_log(ubman, ['gzip', '-f', '-k', filename])
         return filename + '.gz'
 
     def find_matching(text, match):
@@ -260,10 +260,10 @@ def test_fit(ubman):
           - run code coverage to make sure we are testing all the code
         """
         # Set up invariant files
-        control_dtb = fit_util.make_dtb(cons, base_fdt, 'u-boot')
-        kernel = fit_util.make_kernel(cons, 'test-kernel.bin', 'kernel')
+        control_dtb = fit_util.make_dtb(ubman, base_fdt, 'u-boot')
+        kernel = fit_util.make_kernel(ubman, 'test-kernel.bin', 'kernel')
         ramdisk = make_ramdisk('test-ramdisk.bin', 'ramdisk')
-        loadables1 = fit_util.make_kernel(cons, 'test-loadables1.bin', 'lenrek')
+        loadables1 = fit_util.make_kernel(ubman, 'test-loadables1.bin', 'lenrek')
         loadables2 = make_ramdisk('test-loadables2.bin', 'ksidmar')
         kernel_out = make_fname('kernel-out.bin')
         fdt = make_fname('u-boot.dtb')
@@ -311,16 +311,16 @@ def test_fit(ubman):
         }
 
         # Make a basic FIT and a script to load it
-        fit = fit_util.make_fit(cons, mkimage, base_its, params)
+        fit = fit_util.make_fit(ubman, mkimage, base_its, params)
         params['fit'] = fit
         cmd = base_script % params
 
         # First check that we can load a kernel
         # We could perhaps reduce duplication with some loss of readability
-        cons.config.dtb = control_dtb
-        cons.restart_uboot()
-        with cons.log.section('Kernel load'):
-            output = cons.run_command_list(cmd.splitlines())
+        ubman.config.dtb = control_dtb
+        ubman.restart_uboot()
+        with ubman.log.section('Kernel load'):
+            output = ubman.run_command_list(cmd.splitlines())
             check_equal(kernel, kernel_out, 'Kernel not loaded')
             check_not_equal(control_dtb, fdt_out,
                             'FDT loaded but should be ignored')
@@ -340,7 +340,7 @@ def test_fit(ubman):
                   (fit_offset, real_fit_offset))
 
             # Check if bootargs strings substitution works
-            output = cons.run_command_list([
+            output = ubman.run_command_list([
                 'env set bootargs \\\"\'my_boot_var=${foo}\'\\\"',
                 'env set foo bar',
                 'bootm prep',
@@ -348,63 +348,62 @@ def test_fit(ubman):
             assert 'bootargs="my_boot_var=bar"' in output, "Bootargs strings not substituted"
 
         # Now a kernel and an FDT
-        with cons.log.section('Kernel + FDT load'):
+        with ubman.log.section('Kernel + FDT load'):
             params['fdt_load'] = 'load = <%#x>;' % params['fdt_addr']
-            fit = fit_util.make_fit(cons, mkimage, base_its, params)
-            cons.restart_uboot()
-            output = cons.run_command_list(cmd.splitlines())
+            fit = fit_util.make_fit(ubman, mkimage, base_its, params)
+            ubman.restart_uboot()
+            output = ubman.run_command_list(cmd.splitlines())
             check_equal(kernel, kernel_out, 'Kernel not loaded')
             check_equal(control_dtb, fdt_out, 'FDT not loaded')
             check_not_equal(ramdisk, ramdisk_out,
                             'Ramdisk loaded but should not be')
 
         # Try a ramdisk
-        with cons.log.section('Kernel + FDT + Ramdisk load'):
+        with ubman.log.section('Kernel + FDT + Ramdisk load'):
             params['ramdisk_config'] = 'ramdisk = "ramdisk-1";'
             params['ramdisk_load'] = 'load = <%#x>;' % params['ramdisk_addr']
-            fit = fit_util.make_fit(cons, mkimage, base_its, params)
-            cons.restart_uboot()
-            output = cons.run_command_list(cmd.splitlines())
+            fit = fit_util.make_fit(ubman, mkimage, base_its, params)
+            ubman.restart_uboot()
+            output = ubman.run_command_list(cmd.splitlines())
             check_equal(ramdisk, ramdisk_out, 'Ramdisk not loaded')
 
         # Configuration with some Loadables
-        with cons.log.section('Kernel + FDT + Ramdisk load + Loadables'):
+        with ubman.log.section('Kernel + FDT + Ramdisk load + Loadables'):
             params['loadables_config'] = 'loadables = "kernel-2", "ramdisk-2";'
             params['loadables1_load'] = ('load = <%#x>;' %
                                          params['loadables1_addr'])
             params['loadables2_load'] = ('load = <%#x>;' %
                                          params['loadables2_addr'])
-            fit = fit_util.make_fit(cons, mkimage, base_its, params)
-            cons.restart_uboot()
-            output = cons.run_command_list(cmd.splitlines())
+            fit = fit_util.make_fit(ubman, mkimage, base_its, params)
+            ubman.restart_uboot()
+            output = ubman.run_command_list(cmd.splitlines())
             check_equal(loadables1, loadables1_out,
                         'Loadables1 (kernel) not loaded')
             check_equal(loadables2, loadables2_out,
                         'Loadables2 (ramdisk) not loaded')
 
         # Kernel, FDT and Ramdisk all compressed
-        with cons.log.section('(Kernel + FDT + Ramdisk) compressed'):
+        with ubman.log.section('(Kernel + FDT + Ramdisk) compressed'):
             params['compression'] = 'gzip'
             params['kernel'] = make_compressed(kernel)
             params['fdt'] = make_compressed(fdt)
             params['ramdisk'] = make_compressed(ramdisk)
-            fit = fit_util.make_fit(cons, mkimage, base_its, params)
-            cons.restart_uboot()
-            output = cons.run_command_list(cmd.splitlines())
+            fit = fit_util.make_fit(ubman, mkimage, base_its, params)
+            ubman.restart_uboot()
+            output = ubman.run_command_list(cmd.splitlines())
             check_equal(kernel, kernel_out, 'Kernel not loaded')
             check_equal(control_dtb, fdt_out, 'FDT not loaded')
             check_not_equal(ramdisk, ramdisk_out, 'Ramdisk got decompressed?')
             check_equal(ramdisk + '.gz', ramdisk_out, 'Ramdist not loaded')
 
 
-    cons = ubman
     # We need to use our own device tree file. Remember to restore it
     # afterwards.
-    old_dtb = cons.config.dtb
+    old_dtb = ubman.config.dtb
     try:
-        mkimage = cons.config.build_dir + '/tools/mkimage'
+        mkimage = ubman.config.build_dir + '/tools/mkimage'
         run_fit_test(mkimage)
     finally:
         # Go back to the original U-Boot with the correct dtb.
-        cons.config.dtb = old_dtb
-        cons.restart_uboot()
+        ubman.config.dtb = old_dtb
+        ubman.restart_uboot()
diff --git a/test/py/tests/test_fit_auto_signed.py b/test/py/tests/test_fit_auto_signed.py
index b5f872f3d0f..cdfd341c6f5 100644
--- a/test/py/tests/test_fit_auto_signed.py
+++ b/test/py/tests/test_fit_auto_signed.py
@@ -26,22 +26,22 @@ from Cryptodome.Signature import pkcs1_15
 
 class SignedFitHelper(object):
     """Helper to manipulate a FIT with signed/hashed images/configs."""
-    def __init__(self, cons, file_name):
+    def __init__(self, ubman, file_name):
         self.fit = file_name
-        self.cons = cons
+        self.ubman = ubman
         self.images_nodes = set()
         self.confgs_nodes = set()
 
     def __fdt_list(self, path):
-        return utils.run_and_log(self.cons,
+        return utils.run_and_log(self.ubman,
             f'fdtget -l {self.fit} {path}')
 
     def __fdt_get_string(self, node, prop):
-        return utils.run_and_log(self.cons,
+        return utils.run_and_log(self.ubman,
             f'fdtget -ts {self.fit} {node} {prop}')
 
     def __fdt_get_binary(self, node, prop):
-        numbers = utils.run_and_log(self.cons,
+        numbers = utils.run_and_log(self.ubman,
             f'fdtget -tbi {self.fit} {node} {prop}')
 
         bignum = bytearray()
@@ -133,9 +133,8 @@ def test_fit_auto_signed(ubman):
 
     The test does not run the sandbox. It only checks the host tool mkimage.
     """
-    cons = ubman
-    mkimage = cons.config.build_dir + '/tools/mkimage'
-    tempdir = os.path.join(cons.config.result_dir, 'auto_fit')
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    tempdir = os.path.join(ubman.config.result_dir, 'auto_fit')
     os.makedirs(tempdir, exist_ok=True)
     kernel_file = f'{tempdir}/vmlinuz'
     dt1_file = f'{tempdir}/dt-1.dtb'
@@ -166,29 +165,29 @@ def test_fit_auto_signed(ubman):
     s_args = " -k" + tempdir + " -g" + key_name + " -o" + sign_algo
 
     # 1 - Create auto FIT with images crc32 checksum, and verify it
-    utils.run_and_log(cons, mkimage + ' -fauto' + b_args + " " + fit_file)
+    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + " " + fit_file)
 
-    fit = SignedFitHelper(cons, fit_file)
+    fit = SignedFitHelper(ubman, fit_file)
     if fit.build_nodes_sets() == 0:
         raise ValueError('FIT-1 has no "/image" nor "/configuration" nodes')
 
     fit.check_fit_crc32_images()
 
     # 2 - Create auto FIT with signed images, and verify it
-    utils.run_and_log(cons, mkimage + ' -fauto' + b_args + s_args + " " +
+    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + s_args + " " +
                       fit_file)
 
-    fit = SignedFitHelper(cons, fit_file)
+    fit = SignedFitHelper(ubman, fit_file)
     if fit.build_nodes_sets() == 0:
         raise ValueError('FIT-2 has no "/image" nor "/configuration" nodes')
 
     fit.check_fit_signed_images(key_name, sign_algo, verifier)
 
     # 3 - Create auto FIT with signed configs and hashed images, and verify it
-    utils.run_and_log(cons, mkimage + ' -fauto-conf' + b_args + s_args + " " +
+    utils.run_and_log(ubman, mkimage + ' -fauto-conf' + b_args + s_args + " " +
                       fit_file)
 
-    fit = SignedFitHelper(cons, fit_file)
+    fit = SignedFitHelper(ubman, fit_file)
     if fit.build_nodes_sets() == 0:
         raise ValueError('FIT-3 has no "/image" nor "/configuration" nodes')
 
diff --git a/test/py/tests/test_fit_ecdsa.py b/test/py/tests/test_fit_ecdsa.py
index 63f2f6a44e6..3e816d68eb6 100644
--- a/test/py/tests/test_fit_ecdsa.py
+++ b/test/py/tests/test_fit_ecdsa.py
@@ -19,21 +19,21 @@ from Cryptodome.Signature import DSS
 
 class SignableFitImage(object):
     """ Helper to manipulate a FIT image on disk """
-    def __init__(self, cons, file_name):
+    def __init__(self, ubman, file_name):
         self.fit = file_name
-        self.cons = cons
+        self.ubman = ubman
         self.signable_nodes = set()
 
     def __fdt_list(self, path):
-        return utils.run_and_log(self.cons, f'fdtget -l {self.fit} {path}')
+        return utils.run_and_log(self.ubman, f'fdtget -l {self.fit} {path}')
 
     def __fdt_set(self, node, **prop_value):
         for prop, value in prop_value.items():
-            utils.run_and_log(self.cons,
+            utils.run_and_log(self.ubman,
                               f'fdtput -ts {self.fit} {node} {prop} {value}')
 
     def __fdt_get_binary(self, node, prop):
-        numbers = utils.run_and_log(self.cons,
+        numbers = utils.run_and_log(self.ubman,
                                     f'fdtget -tbi {self.fit} {node} {prop}')
 
         bignum = bytearray()
@@ -55,7 +55,7 @@ class SignableFitImage(object):
             self.__fdt_set(f'{image}/signature', algo='sha256,ecdsa256')
 
     def sign(self, mkimage, key_file):
-        utils.run_and_log(self.cons, [mkimage, '-F', self.fit, f'-G{key_file}'])
+        utils.run_and_log(self.ubman, [mkimage, '-F', self.fit, f'-G{key_file}'])
 
     def check_signatures(self, key):
         for image in self.signable_nodes:
@@ -78,16 +78,15 @@ def test_fit_ecdsa(ubman):
 
     def assemble_fit_image(dest_fit, its, destdir):
         dtc_args = f'-I dts -O dtb -i {destdir}'
-        utils.run_and_log(cons, [mkimage, '-D', dtc_args, '-f', its, dest_fit])
+        utils.run_and_log(ubman, [mkimage, '-D', dtc_args, '-f', its, dest_fit])
 
     def dtc(dts):
         dtb = dts.replace('.dts', '.dtb')
-        utils.run_and_log(cons, f'dtc {datadir}/{dts} -O dtb -o {tempdir}/{dtb}')
+        utils.run_and_log(ubman, f'dtc {datadir}/{dts} -O dtb -o {tempdir}/{dtb}')
 
-    cons = ubman
-    mkimage = cons.config.build_dir + '/tools/mkimage'
-    datadir = cons.config.source_dir + '/test/py/tests/vboot/'
-    tempdir = os.path.join(cons.config.result_dir, 'ecdsa')
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    datadir = ubman.config.source_dir + '/test/py/tests/vboot/'
+    tempdir = os.path.join(ubman.config.result_dir, 'ecdsa')
     os.makedirs(tempdir, exist_ok=True)
     key_file = f'{tempdir}/ecdsa-test-key.pem'
     fit_file = f'{tempdir}/test.fit'
@@ -105,7 +104,7 @@ def test_fit_ecdsa(ubman):
 
     assemble_fit_image(fit_file, f'{datadir}/sign-images-sha256.its', tempdir)
 
-    fit = SignableFitImage(cons, fit_file)
+    fit = SignableFitImage(ubman, fit_file)
     nodes = fit.find_signable_image_nodes()
     if len(nodes) == 0:
         raise ValueError('FIT image has no "/image" nodes with "signature"')
diff --git a/test/py/tests/test_fit_hashes.py b/test/py/tests/test_fit_hashes.py
index bcde045d6c8..07bf0fd5211 100644
--- a/test/py/tests/test_fit_hashes.py
+++ b/test/py/tests/test_fit_hashes.py
@@ -26,20 +26,20 @@ kernel_hashes = {
 
 class ReadonlyFitImage(object):
     """ Helper to manipulate a FIT image on disk """
-    def __init__(self, cons, file_name):
+    def __init__(self, ubman, file_name):
         self.fit = file_name
-        self.cons = cons
+        self.ubman = ubman
         self.hashable_nodes = set()
 
     def __fdt_list(self, path):
-        return utils.run_and_log(self.cons, f'fdtget -l {self.fit} {path}')
+        return utils.run_and_log(self.ubman, f'fdtget -l {self.fit} {path}')
 
     def __fdt_get(self, node, prop):
-        val = utils.run_and_log(self.cons, f'fdtget {self.fit} {node} {prop}')
+        val = utils.run_and_log(self.ubman, f'fdtget {self.fit} {node} {prop}')
         return val.rstrip('\n')
 
     def __fdt_get_sexadecimal(self, node, prop):
-        numbers = utils.run_and_log(self.cons,
+        numbers = utils.run_and_log(self.ubman,
                                     f'fdtget -tbx {self.fit} {node} {prop}')
 
         sexadecimal = ''
@@ -86,17 +86,16 @@ def test_mkimage_hashes(ubman):
 
     def assemble_fit_image(dest_fit, its, destdir):
         dtc_args = f'-I dts -O dtb -i {destdir}'
-        utils.run_and_log(cons, [mkimage, '-D', dtc_args, '-f', its, dest_fit])
+        utils.run_and_log(ubman, [mkimage, '-D', dtc_args, '-f', its, dest_fit])
 
     def dtc(dts):
         dtb = dts.replace('.dts', '.dtb')
-        utils.run_and_log(cons,
+        utils.run_and_log(ubman,
                           f'dtc {datadir}/{dts} -O dtb -o {tempdir}/{dtb}')
 
-    cons = ubman
-    mkimage = cons.config.build_dir + '/tools/mkimage'
-    datadir = cons.config.source_dir + '/test/py/tests/vboot/'
-    tempdir = os.path.join(cons.config.result_dir, 'hashes')
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    datadir = ubman.config.source_dir + '/test/py/tests/vboot/'
+    tempdir = os.path.join(ubman.config.result_dir, 'hashes')
     os.makedirs(tempdir, exist_ok=True)
 
     fit_file = f'{tempdir}/test.fit'
@@ -108,7 +107,7 @@ def test_mkimage_hashes(ubman):
 
     assemble_fit_image(fit_file, f'{datadir}/hash-images.its', tempdir)
 
-    fit = ReadonlyFitImage(cons, fit_file)
+    fit = ReadonlyFitImage(ubman, fit_file)
     nodes = fit.find_hashable_image_nodes()
     if len(nodes) == 0:
         raise ValueError('FIT image has no "/image" nodes with "hash-..."')
diff --git a/test/py/tests/test_handoff.py b/test/py/tests/test_handoff.py
index c0cfa3b3398..becd7d75cf7 100644
--- a/test/py/tests/test_handoff.py
+++ b/test/py/tests/test_handoff.py
@@ -10,6 +10,5 @@ TEST_HANDOFF_MAGIC = 0x14f93c7b
 @pytest.mark.buildconfigspec('spl')
 def test_handoff(ubman):
     """Test that of-platdata can be generated and used in sandbox"""
-    cons = ubman
-    response = cons.run_command('sb handoff')
+    response = ubman.run_command('sb handoff')
     assert ('SPL handoff magic %x' % TEST_HANDOFF_MAGIC) in response
diff --git a/test/py/tests/test_help.py b/test/py/tests/test_help.py
index 72f7282478c..12cb36b7b98 100644
--- a/test/py/tests/test_help.py
+++ b/test/py/tests/test_help.py
@@ -16,10 +16,9 @@ def test_help(ubman):
 @pytest.mark.boardspec('sandbox')
 def test_help_no_devicetree(ubman):
     try:
-        cons = ubman
-        cons.restart_uboot_with_flags([], use_dtb=False)
-        cons.run_command('help')
-        output = cons.get_spawn_output().replace('\r', '')
+        ubman.restart_uboot_with_flags([], use_dtb=False)
+        ubman.run_command('help')
+        output = ubman.get_spawn_output().replace('\r', '')
         assert 'print command description/usage' in output
     finally:
         # Restart afterward to get the normal device tree back
@@ -28,10 +27,9 @@ def test_help_no_devicetree(ubman):
 @pytest.mark.boardspec('sandbox_vpl')
 def test_vpl_help(ubman):
     try:
-        cons = ubman
-        cons.restart_uboot()
-        cons.run_command('help')
-        output = cons.get_spawn_output().replace('\r', '')
+        ubman.restart_uboot()
+        ubman.run_command('help')
+        output = ubman.get_spawn_output().replace('\r', '')
         assert 'print command description/usage' in output
     finally:
         # Restart afterward to get the normal device tree back
diff --git a/test/py/tests/test_kconfig.py b/test/py/tests/test_kconfig.py
index a3796ea7e47..0c261d47975 100644
--- a/test/py/tests/test_kconfig.py
+++ b/test/py/tests/test_kconfig.py
@@ -13,11 +13,10 @@ TMPDIR = '/tmp/test_kconfig'
 @pytest.mark.boardspec('sandbox')
 def test_kconfig(ubman):
     """Test build failures when IF_ENABLED_INT() option is not enabled"""
-    cons = ubman
 
     # This detects build errors in test/lib/kconfig.c
     out = utils.run_and_log(
-        cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
+        ubman, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
                '-a', 'TEST_KCONFIG', '-o', TMPDIR], ignore_errors=True)
     assert 'invalid_use_of_IF_ENABLED_INT' in out
     assert 'invalid_use_of_CONFIG_IF_ENABLED_INT' in out
@@ -26,11 +25,10 @@ def test_kconfig(ubman):
 @pytest.mark.boardspec('sandbox_spl')
 def test_kconfig_spl(ubman):
     """Test build failures when IF_ENABLED_INT() option is not enabled"""
-    cons = ubman
 
     # This detects build errors in test/lib/kconfig_spl.c
     out = utils.run_and_log(
-        cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox_spl',
+        ubman, ['./tools/buildman/buildman', '-m', '--board', 'sandbox_spl',
                '-a', 'TEST_KCONFIG', '-o', TMPDIR], ignore_errors=True)
     assert 'invalid_use_of_IF_ENABLED_INT' in out
 
diff --git a/test/py/tests/test_log.py b/test/py/tests/test_log.py
index 292f5b31675..4558b037e2a 100644
--- a/test/py/tests/test_log.py
+++ b/test/py/tests/test_log.py
@@ -20,18 +20,17 @@ def test_log_format(ubman):
             fmt: Format to use for 'log format'
             expected_output: Expected output from the 'log rec' command
         """
-        output = cons.run_command('log format %s' % fmt)
+        output = ubman.run_command('log format %s' % fmt)
         assert output == ''
-        output = cons.run_command('log rec arch notice file.c 123 func msg')
+        output = ubman.run_command('log rec arch notice file.c 123 func msg')
         assert output == expected_output
 
-    cons = ubman
-    with cons.log.section('format'):
+    with ubman.log.section('format'):
         pad = int(ubman.config.buildconfig.get('config_logf_func_pad'))
         padding = ' ' * (pad - len('func'))
 
         run_with_format('all', f'NOTICE.arch,file.c:123-{padding}func() msg')
-        output = cons.run_command('log format')
+        output = ubman.run_command('log format')
         assert output == 'Log format: clFLfm'
 
         run_with_format('fm', f'{padding}func() msg')
@@ -45,7 +44,6 @@ def test_log_format(ubman):
 def test_log_dropped(ubman):
     """Test dropped 'log' message when debug_uart is activated"""
 
-    cons = ubman
-    cons.restart_uboot()
-    output = cons.get_spawn_output().replace('\r', '')
+    ubman.restart_uboot()
+    output = ubman.get_spawn_output().replace('\r', '')
     assert (not 'debug: main' in output)
diff --git a/test/py/tests/test_mmc.py b/test/py/tests/test_mmc.py
index 4916dcd8529..e751a3bd36a 100644
--- a/test/py/tests/test_mmc.py
+++ b/test/py/tests/test_mmc.py
@@ -32,19 +32,19 @@ devices = {}
 mmc_modes_name = []
 mmc_modes = []
 
-def setup_mmc_modes(cons):
+def setup_mmc_modes(ubman):
     global mmc_modes, mmc_modes_name
-    f = cons.config.env.get('env__mmc_device', None)
+    f = ubman.config.env.get('env__mmc_device', None)
     if f:
         mmc_modes_name = f.get('mmc_modes', None)
 
     # Set mmc mode to default mode (legacy), if speed mode config isn't enabled
-    if cons.config.buildconfig.get('config_mmc_speed_mode_set', 'n') != 'y':
+    if ubman.config.buildconfig.get('config_mmc_speed_mode_set', 'n') != 'y':
         mmc_modes = [0]
         return
 
     if mmc_modes_name:
-        mmc_help = cons.run_command('mmc -help')
+        mmc_help = ubman.run_command('mmc -help')
         m = re.search(r"\[MMC_LEGACY(.*\n.+])", mmc_help)
         modes = [
             x.strip()
diff --git a/test/py/tests/test_of_migrate.py b/test/py/tests/test_of_migrate.py
index e866eebbfd4..ab89332331e 100644
--- a/test/py/tests/test_of_migrate.py
+++ b/test/py/tests/test_of_migrate.py
@@ -14,11 +14,11 @@ TMPDIR1 = '/tmp/test_no_migrate'
 TMPDIR2 = '/tmp/test_no_migrate_spl'
 TMPDIR3 = '/tmp/test_migrate'
 
-def build_for_migrate(cons, replace_pair, board, tmpdir, disable_migrate=True):
+def build_for_migrate(ubman, replace_pair, board, tmpdir, disable_migrate=True):
     """Build an updated U-Boot with a slightly modified device tree
 
     Args:
-        cons (ConsoleBase): U-Boot console
+        ubman (ConsoleBase): U-Boot console
         replace_pair (tuple):
             String to find
             String to replace it with
@@ -26,14 +26,14 @@ def build_for_migrate(cons, replace_pair, board, tmpdir, disable_migrate=True):
         tmpdir (str): Temporary directory to use
         disable_migrate (bool): True to disable CONFIG_OF_TAG_MIGRATE in build
     """
-    srcdir = cons.config.source_dir
-    build_dir = cons.config.build_dir
+    srcdir = ubman.config.source_dir
+    build_dir = ubman.config.build_dir
 
     # Get the source for the existing dts
     dt_dir = os.path.join(build_dir, 'arch', 'sandbox', 'dts')
     orig_fname = os.path.join(dt_dir, 'sandbox.dtb')
     out_dts = os.path.join(dt_dir, 'sandbox_out.dts')
-    utils.run_and_log(cons, ['dtc', orig_fname, '-I', 'dtb', '-O', 'dts',
+    utils.run_and_log(ubman, ['dtc', orig_fname, '-I', 'dtb', '-O', 'dts',
                              '-o', out_dts])
 
     # Update it to use an old tag
@@ -45,7 +45,7 @@ def build_for_migrate(cons, replace_pair, board, tmpdir, disable_migrate=True):
     with open(dts_fname, 'w') as outf:
         print(data, file=outf)
     dtb_fname = os.path.join(dt_dir, 'sandbox_oldtag.dtb')
-    utils.run_and_log(cons, ['dtc', dts_fname, '-o', dtb_fname])
+    utils.run_and_log(ubman, ['dtc', dts_fname, '-o', dtb_fname])
 
     migrate = ['-a', '~CONFIG_OF_TAG_MIGRATE'] if disable_migrate else []
 
@@ -55,7 +55,7 @@ def build_for_migrate(cons, replace_pair, board, tmpdir, disable_migrate=True):
     env['DEVICE_TREE'] = 'sandbox_new'
     env['NO_LTO'] = '1'  # Speed up build
     out = utils.run_and_log(
-        cons, ['./tools/buildman/buildman', '-m', '--board', board,
+        ubman, ['./tools/buildman/buildman', '-m', '--board', board,
                *migrate, '-w', '-o', tmpdir], ignore_errors=True, env=env)
     return out
 
@@ -63,15 +63,14 @@ def build_for_migrate(cons, replace_pair, board, tmpdir, disable_migrate=True):
 @pytest.mark.boardspec('sandbox')
 def test_of_no_migrate(ubman):
     """Test sandbox with old boot phase tags like u-boot,dm-pre-proper"""
-    cons = ubman
 
-    build_for_migrate(cons, ['bootph-some-ram', 'u-boot,dm-pre-proper'],
+    build_for_migrate(ubman, ['bootph-some-ram', 'u-boot,dm-pre-proper'],
                       'sandbox', TMPDIR1)
 
     # It should fail to run, since the lcd device will not be bound before
     # relocation. so won't get its frame-buffer memory
     out = utils.run_and_log(
-        cons, [os.path.join(TMPDIR1, 'u-boot'), '-D', '-c', 'help'],
+        ubman, [os.path.join(TMPDIR1, 'u-boot'), '-D', '-c', 'help'],
         ignore_errors=True)
     assert "Video device 'lcd' cannot allocate frame buffer memory" in out
 
@@ -82,9 +81,8 @@ def test_of_no_migrate(ubman):
 @pytest.mark.boardspec('!sandbox_tpl')
 def test_of_no_migrate_spl(ubman):
     """Test sandbox with old boot phase tags like u-boot,dm-spl"""
-    cons = ubman
 
-    out = build_for_migrate(cons, ['bootph-pre-ram', 'u-boot,dm-spl'],
+    out = build_for_migrate(ubman, ['bootph-pre-ram', 'u-boot,dm-spl'],
                             'sandbox_spl', TMPDIR2)
 
     # It should fail to build, since the SPL DT will not include 'spl-test'
@@ -96,13 +94,12 @@ def test_of_no_migrate_spl(ubman):
 @pytest.mark.boardspec('sandbox')
 def test_of_migrate(ubman):
     """Test sandbox shows a message when tags were migrated"""
-    cons = ubman
 
-    build_for_migrate(cons, ['bootph-some-ram', 'u-boot,dm-pre-proper'],
+    build_for_migrate(ubman, ['bootph-some-ram', 'u-boot,dm-pre-proper'],
                       'sandbox', TMPDIR3, disable_migrate=False)
 
     # It should show a migration message
     out = utils.run_and_log(
-        cons, [os.path.join(TMPDIR3, 'u-boot'), '-D', '-c', 'help'],
+        ubman, [os.path.join(TMPDIR3, 'u-boot'), '-D', '-c', 'help'],
         ignore_errors=True)
     assert "Warning: Device tree includes old 'u-boot,dm-' tags" in out
diff --git a/test/py/tests/test_ofplatdata.py b/test/py/tests/test_ofplatdata.py
index b4d2db03deb..d31fa55f7c7 100644
--- a/test/py/tests/test_ofplatdata.py
+++ b/test/py/tests/test_ofplatdata.py
@@ -8,10 +8,9 @@ import utils
 @pytest.mark.buildconfigspec('spl_of_platdata')
 def test_spl_devicetree(ubman):
     """Test content of spl device-tree"""
-    cons = ubman
-    dtb = cons.config.build_dir + '/spl/u-boot-spl.dtb'
-    fdtgrep = cons.config.build_dir + '/tools/fdtgrep'
-    output = utils.run_and_log(cons, [fdtgrep, '-l', dtb])
+    dtb = ubman.config.build_dir + '/spl/u-boot-spl.dtb'
+    fdtgrep = ubman.config.build_dir + '/tools/fdtgrep'
+    output = utils.run_and_log(ubman, [fdtgrep, '-l', dtb])
 
     assert "bootph-all" not in output
     assert "bootph-some-ram" not in output
diff --git a/test/py/tests/test_sandbox_opts.py b/test/py/tests/test_sandbox_opts.py
index f50302cbe6b..48f5b313870 100644
--- a/test/py/tests/test_sandbox_opts.py
+++ b/test/py/tests/test_sandbox_opts.py
@@ -13,18 +13,16 @@ TMPDIR = '/tmp/test_cmdline'
 @pytest.mark.boardspec('sandbox')
 def test_sandbox_cmdline(ubman):
     """Test building sandbox without CONFIG_CMDLINE"""
-    cons = ubman
 
     utils.run_and_log(
-        cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
+        ubman, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
                '-a', '~CMDLINE', '-o', TMPDIR])
 
 @pytest.mark.slow
 @pytest.mark.boardspec('sandbox')
 def test_sandbox_lto(ubman):
     """Test building sandbox without CONFIG_LTO"""
-    cons = ubman
 
     utils.run_and_log(
-        cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
+        ubman, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
                '-a', '~LTO', '-o', TMPDIR])
diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
index f0437aa15ca..970d8c79869 100644
--- a/test/py/tests/test_source.py
+++ b/test/py/tests/test_source.py
@@ -11,27 +11,26 @@ import utils
 @pytest.mark.buildconfigspec('fit')
 def test_source(ubman):
     # Compile our test script image
-    cons = ubman
-    mkimage = os.path.join(cons.config.build_dir, 'tools/mkimage')
-    its = os.path.join(cons.config.source_dir, 'test/py/tests/source.its')
-    fit = os.path.join(cons.config.build_dir, 'source.itb')
-    utils.run_and_log(cons, (mkimage, '-f', its, fit))
-    cons.run_command(f'host load hostfs - $loadaddr {fit}')
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    its = os.path.join(ubman.config.source_dir, 'test/py/tests/source.its')
+    fit = os.path.join(ubman.config.build_dir, 'source.itb')
+    utils.run_and_log(ubman, (mkimage, '-f', its, fit))
+    ubman.run_command(f'host load hostfs - $loadaddr {fit}')
 
-    assert '2' in cons.run_command('source')
-    assert '1' in cons.run_command('source :')
-    assert '1' in cons.run_command('source :script-1')
-    assert '2' in cons.run_command('source :script-2')
-    assert 'Fail' in cons.run_command('source :not-a-script || echo Fail')
-    assert '2' in cons.run_command('source \\#')
-    assert '1' in cons.run_command('source \\#conf-1')
-    assert '2' in cons.run_command('source \\#conf-2')
+    assert '2' in ubman.run_command('source')
+    assert '1' in ubman.run_command('source :')
+    assert '1' in ubman.run_command('source :script-1')
+    assert '2' in ubman.run_command('source :script-2')
+    assert 'Fail' in ubman.run_command('source :not-a-script || echo Fail')
+    assert '2' in ubman.run_command('source \\#')
+    assert '1' in ubman.run_command('source \\#conf-1')
+    assert '2' in ubman.run_command('source \\#conf-2')
 
-    cons.run_command('fdt addr $loadaddr')
-    cons.run_command('fdt rm /configurations default')
-    assert '1' in cons.run_command('source')
-    assert 'Fail' in cons.run_command('source \\# || echo Fail')
+    ubman.run_command('fdt addr $loadaddr')
+    ubman.run_command('fdt rm /configurations default')
+    assert '1' in ubman.run_command('source')
+    assert 'Fail' in ubman.run_command('source \\# || echo Fail')
 
-    cons.run_command('fdt rm /images default')
-    assert 'Fail' in cons.run_command('source || echo Fail')
-    assert 'Fail' in cons.run_command('source \\# || echo Fail')
+    ubman.run_command('fdt rm /images default')
+    assert 'Fail' in ubman.run_command('source || echo Fail')
+    assert 'Fail' in ubman.run_command('source \\# || echo Fail')
diff --git a/test/py/tests/test_spl.py b/test/py/tests/test_spl.py
index 6b226c256b7..48407399039 100644
--- a/test/py/tests/test_spl.py
+++ b/test/py/tests/test_spl.py
@@ -33,9 +33,8 @@ def test_spl(ubman, ut_spl_subtest):
         ut_subtest (str): SPL test to be executed (e.g. 'dm platdata_phandle')
     """
     try:
-        cons = ubman
-        cons.restart_uboot_with_flags(['-u', '-k', ut_spl_subtest.split()[1]])
-        output = cons.get_spawn_output().replace('\r', '')
+        ubman.restart_uboot_with_flags(['-u', '-k', ut_spl_subtest.split()[1]])
+        output = ubman.get_spawn_output().replace('\r', '')
         assert 'failures: 0' in output
     finally:
         # Restart afterward in case a non-SPL test is run next. This should not
diff --git a/test/py/tests/test_suite.py b/test/py/tests/test_suite.py
index 9ddc883394b..b4bc87d6d0c 100644
--- a/test/py/tests/test_suite.py
+++ b/test/py/tests/test_suite.py
@@ -18,11 +18,11 @@ EXPECTED_SUITES = [
 DEBUG_ME = False
 
 
-def collect_info(cons, output):
+def collect_info(ubman, output):
     """Process the output from 'ut all'
 
     Args:
-        cons: U-Boot console object
+        ubman: U-Boot console object
         output: Output from running 'ut all'
 
     Returns:
@@ -45,15 +45,15 @@ def collect_info(cons, output):
     for line in output.splitlines():
         line = line.rstrip()
         if DEBUG_ME:
-            cons.log.info(f'line: {line}')
+            ubman.log.info(f'line: {line}')
         m = re.search('----Running ([^ ]*) tests----', line)
         if m:
             if DEBUG_ME and cur_suite and cur_suite != 'info':
-                cons.log.info(f'suite: {cur_suite} expected {exp_test_count[cur_suite]} found {test_count}')
+                ubman.log.info(f'suite: {cur_suite} expected {exp_test_count[cur_suite]} found {test_count}')
 
             cur_suite = m.group(1)
             if DEBUG_ME:
-                cons.log.info(f'cur_suite: {cur_suite}')
+                ubman.log.info(f'cur_suite: {cur_suite}')
             suites.add(cur_suite)
 
             test_count = 0
@@ -65,7 +65,7 @@ def collect_info(cons, output):
             test_name = m.group(1)
             msg = m.group(3)
             if DEBUG_ME:
-                cons.log.info(f"test_name {test_name} msg '{msg}'")
+                ubman.log.info(f"test_name {test_name} msg '{msg}'")
             full_name = f'{cur_suite}.{test_name}'
             if msg == ' (flat tree)' and full_name not in tests:
                 tests.add(full_name)
@@ -74,10 +74,10 @@ def collect_info(cons, output):
                 tests.add(full_name)
                 test_count += 1
         if DEBUG_ME:
-            cons.log.info(f'test_count {test_count}')
+            ubman.log.info(f'test_count {test_count}')
     if DEBUG_ME:
-        cons.log.info(f'suite: {cur_suite} expected {exp_test_count[cur_suite]} found {test_count}')
-        cons.log.info(f"Tests: {' '.join(sorted(list(tests)))}")
+        ubman.log.info(f'suite: {cur_suite} expected {exp_test_count[cur_suite]} found {test_count}')
+        ubman.log.info(f"Tests: {' '.join(sorted(list(tests)))}")
 
     # Figure out what is missing, or extra
     missing = set()
@@ -91,11 +91,11 @@ def collect_info(cons, output):
     return suites, tests, exp_test_count, missing, extra
 
 
-def process_ut_info(cons, output):
+def process_ut_info(ubman, output):
     """Process the output of the 'ut info' command
 
     Args:
-        cons: U-Boot console object
+        ubman: U-Boot console object
         output: Output from running 'ut all'
 
     Returns:
@@ -113,7 +113,7 @@ def process_ut_info(cons, output):
     for line in output.splitlines():
         line = line.rstrip()
         if DEBUG_ME:
-            cons.log.info(f'line: {line}')
+            ubman.log.info(f'line: {line}')
         m = re.match(r'Test suites: (.*)', line)
         if m:
             suite_count = int(m.group(1))
@@ -142,45 +142,45 @@ def xtest_suite(u_boot_console, u_boot_config):
        - The expected set of suites is run (the list is hard-coded in this test)
 
     """
-    cons = u_boot_console
+    ubman = u_boot_console
     buildconfig = u_boot_config.buildconfig
-    with cons.log.section('Run all unit tests'):
+    with ubman.log.section('Run all unit tests'):
         # ut hush hush_test_simple_dollar prints "Unknown command" on purpose.
         with u_boot_console.disable_check('unknown_command'):
-            output = cons.run_command('ut all')
+            output = ubman.run_command('ut all')
 
     # Process the output from the run
-    with cons.log.section('Check output'):
-        suites, all_tests, exp_test_count, missing, extra = collect_info(cons,
+    with ubman.log.section('Check output'):
+        suites, all_tests, exp_test_count, missing, extra = collect_info(ubman,
                                                                          output)
-    cons.log.info(f'missing {missing}')
-    cons.log.info(f'extra {extra}')
+    ubman.log.info(f'missing {missing}')
+    ubman.log.info(f'extra {extra}')
 
     # Make sure we got a test count for each suite
     assert not (suites - exp_test_count.keys())
 
     # Deal with missing suites
-    with cons.log.section('Check missing suites'):
+    with ubman.log.section('Check missing suites'):
         if 'config_cmd_seama' not in buildconfig:
-            cons.log.info("CMD_SEAMA not enabled: Ignoring suite 'seama'")
+            ubman.log.info("CMD_SEAMA not enabled: Ignoring suite 'seama'")
             missing.discard('seama')
 
     # Run 'ut info' and compare with the log results
-    with cons.log.section('Check suite test-counts'):
-        output = cons.run_command('ut -s info')
+    with ubman.log.section('Check suite test-counts'):
+        output = ubman.run_command('ut -s info')
 
-        suite_count, total_test_count, test_count = process_ut_info(cons,
+        suite_count, total_test_count, test_count = process_ut_info(ubman,
                                                                     output)
 
         if missing or extra:
-            cons.log.info(f"suites: {' '.join(sorted(list(suites)))}")
-            cons.log.error(f'missing: {sorted(list(missing))}')
-            cons.log.error(f'extra: {sorted(list(extra))}')
+            ubman.log.info(f"suites: {' '.join(sorted(list(suites)))}")
+            ubman.log.error(f'missing: {sorted(list(missing))}')
+            ubman.log.error(f'extra: {sorted(list(extra))}')
 
         assert not missing, f'Missing suites {missing}'
         assert not extra, f'Extra suites {extra}'
 
-        cons.log.info(str(exp_test_count))
+        ubman.log.info(str(exp_test_count))
         for suite in EXPECTED_SUITES:
             assert test_count[suite] in ['?', str(exp_test_count[suite])], \
                 f'suite {suite} expected {exp_test_count[suite]}'
@@ -189,18 +189,18 @@ def xtest_suite(u_boot_console, u_boot_config):
         assert total_test_count == len(all_tests)
 
     # Run three suites
-    with cons.log.section('Check multiple suites'):
-        output = cons.run_command('ut bloblist,setexpr,mem')
+    with ubman.log.section('Check multiple suites'):
+        output = ubman.run_command('ut bloblist,setexpr,mem')
         assert 'Suites run: 3' in output
 
     # Run a particular test
-    with cons.log.section('Check single test'):
-        output = cons.run_command('ut bloblist reloc')
+    with ubman.log.section('Check single test'):
+        output = ubman.run_command('ut bloblist reloc')
         assert 'Test: reloc: bloblist.c' in output
 
     # Run tests multiple times
-    with cons.log.section('Check multiple runs'):
-        output = cons.run_command('ut -r2 bloblist')
+    with ubman.log.section('Check multiple runs'):
+        output = ubman.run_command('ut -r2 bloblist')
         lines = output.splitlines()
         run = len([line for line in lines if 'Test:' in line])
         count = re.search(r'Tests run: (\d*)', lines[-1]).group(1)
diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
index ade102a387e..064651c3e23 100644
--- a/test/py/tests/test_tpm2.py
+++ b/test/py/tests/test_tpm2.py
@@ -50,9 +50,9 @@ def force_init(ubman, force=False):
             ubman.run_command('tpm2 clear TPM2_RH_PLATFORM')
         ubman.run_command('echo --- end of init ---')
 
-def is_sandbox(cons):
+def is_sandbox(ubman):
     # Array slice removes leading/trailing quotes.
-    sys_arch = cons.config.buildconfig.get('config_sys_arch', '"sandbox"')[1:-1]
+    sys_arch = ubman.config.buildconfig.get('config_sys_arch', '"sandbox"')[1:-1]
     return sys_arch == 'sandbox'
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index 3f3105ebf9a..1786d1e0729 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -15,19 +15,19 @@ TMPDIR = '/tmp/test_trace'
 RE_LINE = re.compile(r'.*0\.\.\.\.\.? \s*([0-9.]*): func.*[|](\s*)(\S.*)?([{};])$')
 
 
-def collect_trace(cons):
+def collect_trace(ubman):
     """Build U-Boot and run it to collect a trace
 
     Args:
-        cons (ConsoleBase): U-Boot console
+        ubman (ConsoleBase): U-Boot console
 
     Returns:
         tuple:
             str: Filename of the output trace file
             int: Microseconds taken for initf_dm according to bootstage
     """
-    cons.run_command('trace pause')
-    out = cons.run_command('trace stats')
+    ubman.run_command('trace pause')
+    out = ubman.run_command('trace stats')
 
     # The output is something like this:
     #    251,003 function sites
@@ -48,10 +48,10 @@ def collect_trace(cons):
     assert int(vals['untracked function calls']) == 0
     assert int(vals['maximum observed call depth']) > 30
     assert (vals['call depth limit'] ==
-            cons.config.buildconfig.get('config_trace_call_depth_limit'))
+            ubman.config.buildconfig.get('config_trace_call_depth_limit'))
     assert int(vals['calls not traced due to depth']) > 100000
 
-    out = cons.run_command('bootstage report')
+    out = ubman.run_command('bootstage report')
     # Accumulated time:
     #           19,104  dm_r
     #           23,078  of_live
@@ -62,30 +62,30 @@ def collect_trace(cons):
     # Read out the trace data
     addr = 0x02000000
     size = 0x02000000
-    out = cons.run_command(f'trace calls {addr:x} {size:x}')
+    out = ubman.run_command(f'trace calls {addr:x} {size:x}')
     print(out)
     fname = os.path.join(TMPDIR, 'trace')
-    out = cons.run_command(
+    out = ubman.run_command(
         'host save hostfs - %x %s ${profoffset}' % (addr, fname))
     return fname, int(dm_f_time[0])
 
 
-def check_function(cons, fname, proftool, map_fname, trace_dat):
+def check_function(ubman, fname, proftool, map_fname, trace_dat):
     """Check that the 'function' output works
 
     Args:
-        cons (ConsoleBase): U-Boot console
+        ubman (ConsoleBase): U-Boot console
         fname (str): Filename of trace file
         proftool (str): Filename of proftool
         map_fname (str): Filename of System.map
         trace_dat (str): Filename of output file
     """
     out = utils.run_and_log(
-        cons, [proftool, '-t', fname, '-o', trace_dat, '-m', map_fname,
+        ubman, [proftool, '-t', fname, '-o', trace_dat, '-m', map_fname,
                'dump-ftrace'])
 
     # Check that trace-cmd can read it
-    out = utils.run_and_log(cons, ['trace-cmd', 'dump', trace_dat])
+    out = utils.run_and_log(ubman, ['trace-cmd', 'dump', trace_dat])
 
     # Tracing meta data in file /tmp/test_trace/trace.dat:
     #    [Initial format]
@@ -114,7 +114,7 @@ def check_function(cons, fname, proftool, map_fname, trace_dat):
 
     # Check that the trace has something useful
     cmd = f"trace-cmd report -l {trace_dat} |grep -E '(initf_|initr_)'"
-    out = utils.run_and_log(cons, ['sh', '-c', cmd])
+    out = utils.run_and_log(ubman, ['sh', '-c', cmd])
 
     # Format:
     #      u-boot-1     0.....    60.805596: function:             initf_malloc
@@ -141,11 +141,11 @@ def check_function(cons, fname, proftool, map_fname, trace_dat):
     assert max_delta < 5
 
 
-def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
+def check_funcgraph(ubman, fname, proftool, map_fname, trace_dat):
     """Check that the 'funcgraph' output works
 
     Args:
-        cons (ConsoleBase): U-Boot console
+        ubman (ConsoleBase): U-Boot console
         fname (str): Filename of trace file
         proftool (str): Filename of proftool
         map_fname (str): Filename of System.map
@@ -157,12 +157,12 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
 
     # Generate the funcgraph format
     out = utils.run_and_log(
-        cons, [proftool, '-t', fname, '-o', trace_dat, '-m', map_fname,
+        ubman, [proftool, '-t', fname, '-o', trace_dat, '-m', map_fname,
                'dump-ftrace', '-f', 'funcgraph'])
 
     # Check that the trace has what we expect
     cmd = f'trace-cmd report -l {trace_dat} |head -n 70'
-    out = utils.run_and_log(cons, ['sh', '-c', cmd])
+    out = utils.run_and_log(ubman, ['sh', '-c', cmd])
 
     # First look for this:
     #  u-boot-1     0.....   282.101360: funcgraph_entry:        0.004 us   |    initf_malloc();
@@ -204,7 +204,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
     # Now look for initf_dm() and dm_timer_init() so we can check the bootstage
     # time
     cmd = f"trace-cmd report -l {trace_dat} |grep -E '(initf_dm|dm_timer_init)'"
-    out = utils.run_and_log(cons, ['sh', '-c', cmd])
+    out = utils.run_and_log(ubman, ['sh', '-c', cmd])
 
     start_timestamp = None
     end_timestamp = None
@@ -223,14 +223,14 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
     return int((float(end_timestamp) - float(start_timestamp)) * 1000000)
 
 
-def check_flamegraph(cons, fname, proftool, map_fname, trace_fg):
+def check_flamegraph(ubman, fname, proftool, map_fname, trace_fg):
     """Check that the 'flamegraph' output works
 
     This spot checks a few call counts and estimates the time taken by the
     initf_dm() function
 
     Args:
-        cons (ConsoleBase): U-Boot console
+        ubman (ConsoleBase): U-Boot console
         fname (str): Filename of trace file
         proftool (str): Filename of proftool
         map_fname (str): Filename of System.map
@@ -242,7 +242,7 @@ def check_flamegraph(cons, fname, proftool, map_fname, trace_fg):
 
     # Generate the flamegraph format
     out = utils.run_and_log(
-        cons, [proftool, '-t', fname, '-o', trace_fg, '-m', map_fname,
+        ubman, [proftool, '-t', fname, '-o', trace_fg, '-m', map_fname,
                'dump-flamegraph'])
 
     # We expect dm_timer_init() to be called twice: once before relocation and
@@ -259,7 +259,7 @@ def check_flamegraph(cons, fname, proftool, map_fname, trace_fg):
 
     # Generate the timing graph
     utils.run_and_log(
-        cons, [proftool, '-t', fname, '-o', trace_fg, '-m', map_fname,
+        ubman, [proftool, '-t', fname, '-o', trace_fg, '-m', map_fname,
                'dump-flamegraph', '-f', 'timing'])
 
     # Add up all the time spend in initf_dm() and its children
@@ -279,26 +279,25 @@ check_flamegraph
 @pytest.mark.buildconfigspec('trace')
 def test_trace(ubman):
     """Test we can build sandbox with trace, collect and process a trace"""
-    cons = ubman
 
     if not os.path.exists(TMPDIR):
         os.mkdir(TMPDIR)
-    proftool = os.path.join(cons.config.build_dir, 'tools', 'proftool')
-    map_fname = os.path.join(cons.config.build_dir, 'System.map')
+    proftool = os.path.join(ubman.config.build_dir, 'tools', 'proftool')
+    map_fname = os.path.join(ubman.config.build_dir, 'System.map')
     trace_dat = os.path.join(TMPDIR, 'trace.dat')
     trace_fg = os.path.join(TMPDIR, 'trace.fg')
 
-    fname, dm_f_time = collect_trace(cons)
+    fname, dm_f_time = collect_trace(ubman)
 
-    check_function(cons, fname, proftool, map_fname, trace_dat)
-    trace_time = check_funcgraph(cons, fname, proftool, map_fname, trace_dat)
+    check_function(ubman, fname, proftool, map_fname, trace_dat)
+    trace_time = check_funcgraph(ubman, fname, proftool, map_fname, trace_dat)
 
     # Check that bootstage and funcgraph agree to within 10 microseconds
     diff = abs(trace_time - dm_f_time)
     print(f'trace_time {trace_time}, dm_f_time {dm_f_time}')
     assert diff / dm_f_time < 0.01
 
-    fg_time = check_flamegraph(cons, fname, proftool, map_fname, trace_fg)
+    fg_time = check_flamegraph(ubman, fname, proftool, map_fname, trace_fg)
 
     # Check that bootstage and flamegraph agree to within 30%
     # This allows for CI being slow to run
diff --git a/test/py/tests/test_upl.py b/test/py/tests/test_upl.py
index 24b0a5c634c..b9c84c380f8 100644
--- a/test/py/tests/test_upl.py
+++ b/test/py/tests/test_upl.py
@@ -19,20 +19,19 @@ def test_upl_handoff(ubman):
     The entire FIT is loaded into memory in SPL (in upl_load_from_image()) so
     that it can be inpected in upl_test_info_norun
     """
-    cons = ubman
-    ram = os.path.join(cons.config.build_dir, 'ram.bin')
-    fdt = os.path.join(cons.config.build_dir, 'u-boot.dtb')
+    ram = os.path.join(ubman.config.build_dir, 'ram.bin')
+    fdt = os.path.join(ubman.config.build_dir, 'u-boot.dtb')
 
     # Remove any existing RAM file, so we don't have old data present
     if os.path.exists(ram):
         os.remove(ram)
     flags = ['-m', ram, '-d', fdt, '--upl']
-    cons.restart_uboot_with_flags(flags, use_dtb=False)
+    ubman.restart_uboot_with_flags(flags, use_dtb=False)
 
     # Make sure that Universal Payload is detected in U-Boot proper
-    output = cons.run_command('upl info')
+    output = ubman.run_command('upl info')
     assert 'UPL state: active' == output
 
     # Check the FIT offsets look correct
-    output = cons.run_command('ut upl -f upl_test_info_norun')
+    output = ubman.run_command('ut upl -f upl_test_info_norun')
     assert 'failures: 0' in output
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index d7cf95d461b..ea0c43cd4fc 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -27,12 +27,12 @@ def mkdir_cond(dirname):
     if not os.path.exists(dirname):
         os.mkdir(dirname)
 
-def setup_image(cons, devnum, part_type, img_size=20, second_part=False,
+def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
                 basename='mmc'):
     """Create a disk image with a single partition
 
     Args:
-        cons (ConsoleBase): Console to use
+        ubman (ConsoleBase): Console to use
         devnum (int): Device number to use, e.g. 1
         part_type (int): Partition type, e.g. 0xc for FAT32
         img_size (int): Image size in MiB
@@ -44,26 +44,26 @@ def setup_image(cons, devnum, part_type, img_size=20, second_part=False,
             str: Filename of MMC image
             str: Directory name of scratch directory
     """
-    fname = os.path.join(cons.config.source_dir, f'{basename}{devnum}.img')
-    mnt = os.path.join(cons.config.persistent_data_dir, 'scratch')
+    fname = os.path.join(ubman.config.source_dir, f'{basename}{devnum}.img')
+    mnt = os.path.join(ubman.config.persistent_data_dir, 'scratch')
     mkdir_cond(mnt)
 
     spec = f'type={part_type:x}, size={img_size - 2}M, start=1M, bootable'
     if second_part:
         spec += '\ntype=c'
 
-    utils.run_and_log(cons, f'qemu-img create {fname} 20M')
-    utils.run_and_log(cons, f'sfdisk {fname}',
+    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
+    utils.run_and_log(ubman, f'sfdisk {fname}',
                              stdin=spec.encode('utf-8'))
     return fname, mnt
 
-def setup_bootmenu_image(cons):
+def setup_bootmenu_image(ubman):
     """Create a 20MB disk image with a single ext4 partition
 
     This is modelled on Armbian 22.08 Jammy
     """
     mmc_dev = 4
-    fname, mnt = setup_image(cons, mmc_dev, 0x83)
+    fname, mnt = setup_image(ubman, mmc_dev, 0x83)
 
     script = '''# DO NOT EDIT THIS FILE
 #
@@ -146,16 +146,16 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     with open(cmd_fname, 'w', encoding='ascii') as outf:
         print(script, file=outf)
 
-    infname = os.path.join(cons.config.source_dir,
+    infname = os.path.join(ubman.config.source_dir,
                             'test/py/tests/bootstd/armbian.bmp.xz')
     bmp_file = os.path.join(bootdir, 'boot.bmp')
     utils.run_and_log(
-        cons,
+        ubman,
         ['sh', '-c', f'xz -dc {infname} >{bmp_file}'])
 
-    mkimage = cons.config.build_dir + '/tools/mkimage'
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
     utils.run_and_log(
-        cons, f'{mkimage} -C none -A arm -T script -d {cmd_fname} {scr_fname}')
+        ubman, f'{mkimage} -C none -A arm -T script -d {cmd_fname} {scr_fname}')
 
     kernel = 'vmlinuz-5.15.63-rockchip64'
     target = os.path.join(bootdir, kernel)
@@ -166,20 +166,20 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     if os.path.exists(symlink):
         os.remove(symlink)
     utils.run_and_log(
-        cons, f'echo here {kernel} {symlink}')
+        ubman, f'echo here {kernel} {symlink}')
     os.symlink(kernel, symlink)
 
     fsfile = 'ext18M.img'
-    utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
-    utils.run_and_log(cons, f'mkfs.ext4 {fsfile} -d {mnt}')
-    utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-    utils.run_and_log(cons, f'rm -rf {mnt}')
-    utils.run_and_log(cons, f'rm -f {fsfile}')
+    utils.run_and_log(ubman, f'fallocate -l 18M {fsfile}')
+    utils.run_and_log(ubman, f'mkfs.ext4 {fsfile} -d {mnt}')
+    utils.run_and_log(ubman, f'dd if={fsfile} of={fname} bs=1M seek=1')
+    utils.run_and_log(ubman, f'rm -rf {mnt}')
+    utils.run_and_log(ubman, f'rm -f {fsfile}')
 
-def setup_bootflow_image(cons):
+def setup_bootflow_image(ubman):
     """Create a 20MB disk image with a single FAT partition"""
     mmc_dev = 1
-    fname, mnt = setup_image(cons, mmc_dev, 0xc, second_part=True)
+    fname, mnt = setup_image(ubman, mmc_dev, 0xc, second_part=True)
 
     vmlinux = 'vmlinuz-5.3.7-301.fc31.armv7hl'
     initrd = 'initramfs-5.3.7-301.fc31.armv7hl.img'
@@ -204,12 +204,12 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
     with open(conf, 'w', encoding='ascii') as fd:
         print(script, file=fd)
 
-    inf = os.path.join(cons.config.persistent_data_dir, 'inf')
+    inf = os.path.join(ubman.config.persistent_data_dir, 'inf')
     with open(inf, 'wb') as fd:
         fd.write(gzip.compress(b'vmlinux'))
-    mkimage = cons.config.build_dir + '/tools/mkimage'
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
     utils.run_and_log(
-        cons, f'{mkimage} -f auto -d {inf} {os.path.join(mnt, vmlinux)}')
+        ubman, f'{mkimage} -f auto -d {inf} {os.path.join(mnt, vmlinux)}')
 
     with open(os.path.join(mnt, initrd), 'w', encoding='ascii') as fd:
         print('initrd', file=fd)
@@ -218,27 +218,27 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
 
     dtb_file = os.path.join(mnt, f'{dtbdir}/sandbox.dtb')
     utils.run_and_log(
-        cons, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
+        ubman, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
 
     fsfile = 'vfat18M.img'
-    utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
-    utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
-    utils.run_and_log(cons, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
-    utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-    utils.run_and_log(cons, f'rm -rf {mnt}')
-    utils.run_and_log(cons, f'rm -f {fsfile}')
-
-def setup_cros_image(cons):
+    utils.run_and_log(ubman, f'fallocate -l 18M {fsfile}')
+    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
+    utils.run_and_log(ubman, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
+    utils.run_and_log(ubman, f'dd if={fsfile} of={fname} bs=1M seek=1')
+    utils.run_and_log(ubman, f'rm -rf {mnt}')
+    utils.run_and_log(ubman, f'rm -f {fsfile}')
+
+def setup_cros_image(ubman):
     """Create a 20MB disk image with ChromiumOS partitions"""
     Partition = collections.namedtuple('part', 'start,size,name')
     parts = {}
     disk_data = None
 
-    def pack_kernel(cons, arch, kern, dummy):
+    def pack_kernel(ubman, arch, kern, dummy):
         """Pack a kernel containing some fake data
 
         Args:
-            cons (ConsoleBase): Console to use
+            ubman (ConsoleBase): Console to use
             arch (str): Architecture to use ('x86' or 'arm')
             kern (str): Filename containing kernel
             dummy (str): Dummy filename to use for config and bootloader
@@ -246,10 +246,10 @@ def setup_cros_image(cons):
         Return:
             bytes: Packed-kernel data
         """
-        kern_part = os.path.join(cons.config.result_dir,
+        kern_part = os.path.join(ubman.config.result_dir,
                                  f'kern-part-{arch}.bin')
         utils.run_and_log(
-            cons,
+            ubman,
             f'futility vbutil_kernel --pack {kern_part} '
             '--keyblock doc/chromium/files/devkeys/kernel.keyblock '
             '--signprivate doc/chromium/files/devkeys/kernel_data_key.vbprivk '
@@ -275,9 +275,9 @@ def setup_cros_image(cons):
         disk_data = disk_data[:start] + data + disk_data[start + len(data):]
 
     mmc_dev = 5
-    fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
-    utils.run_and_log(cons, f'qemu-img create {fname} 20M')
-    utils.run_and_log(cons, f'cgpt create {fname}')
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
+    utils.run_and_log(ubman, f'cgpt create {fname}')
 
     uuid_state = 'ebd0a0a2-b9e5-4433-87c0-68b6b72699c7'
     uuid_kern = 'fe3a2a5d-4f32-41a7-b725-accc3285a309'
@@ -317,12 +317,12 @@ def setup_cros_image(cons):
         else:
             size = int(size_str)
         utils.run_and_log(
-            cons,
+            ubman,
             f"cgpt add -i {part['num']} -b {ptr} -s {size} -t {part['type']} {fname}")
         ptr += size
 
-    utils.run_and_log(cons, f'cgpt boot -p {fname}')
-    out = utils.run_and_log(cons, f'cgpt show -q {fname}')
+    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
 
     # We expect something like this:
     #   8239        2048       1  Basic data
@@ -344,14 +344,14 @@ def setup_cros_image(cons):
         parts[int(num)] = Partition(int(start), int(size), name)
 
     # Set up the kernel command-line
-    dummy = os.path.join(cons.config.result_dir, 'dummy.txt')
+    dummy = os.path.join(ubman.config.result_dir, 'dummy.txt')
     with open(dummy, 'wb') as outf:
         outf.write(b'BOOT_IMAGE=/vmlinuz-5.15.0-121-generic root=/dev/nvme0n1p1 ro quiet splash vt.handoff=7')
 
     # For now we just use dummy kernels. This limits testing to just detecting
     # a signed kernel. We could add support for the x86 data structures so that
     # testing could cover getting the cmdline, setup.bin and other pieces.
-    kern = os.path.join(cons.config.result_dir, 'kern.bin')
+    kern = os.path.join(ubman.config.result_dir, 'kern.bin')
     with open(kern, 'wb') as outf:
         outf.write(b'kernel\n')
 
@@ -359,15 +359,15 @@ def setup_cros_image(cons):
         disk_data = inf.read()
 
     # put x86 kernel in partition 2 and arm one in partition 4
-    set_part_data(2, pack_kernel(cons, 'x86', kern, dummy))
-    set_part_data(4, pack_kernel(cons, 'arm', kern, dummy))
+    set_part_data(2, pack_kernel(ubman, 'x86', kern, dummy))
+    set_part_data(4, pack_kernel(ubman, 'arm', kern, dummy))
 
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
 
     return fname
 
-def setup_android_image(cons):
+def setup_android_image(ubman):
     """Create a 20MB disk image with Android partitions"""
     Partition = collections.namedtuple('part', 'start,size,name')
     parts = {}
@@ -388,9 +388,9 @@ def setup_android_image(cons):
         disk_data = disk_data[:start] + data + disk_data[start + len(data):]
 
     mmc_dev = 7
-    fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
-    utils.run_and_log(cons, f'qemu-img create {fname} 20M')
-    utils.run_and_log(cons, f'cgpt create {fname}')
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
+    utils.run_and_log(ubman, f'cgpt create {fname}')
 
     ptr = 40
 
@@ -413,12 +413,12 @@ def setup_android_image(cons):
         else:
             size = int(size_str)
         utils.run_and_log(
-            cons,
+            ubman,
             f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
         ptr += size
 
-    utils.run_and_log(cons, f'cgpt boot -p {fname}')
-    out = utils.run_and_log(cons, f'cgpt show -q {fname}')
+    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
 
     # Create a dict (indexed by partition number) containing the above info
     for line in out.splitlines():
@@ -428,13 +428,13 @@ def setup_android_image(cons):
     with open(fname, 'rb') as inf:
         disk_data = inf.read()
 
-    test_abootimg.AbootimgTestDiskImage(cons, 'bootv4.img', test_abootimg.boot_img_hex)
-    boot_img = os.path.join(cons.config.result_dir, 'bootv4.img')
+    test_abootimg.AbootimgTestDiskImage(ubman, 'bootv4.img', test_abootimg.boot_img_hex)
+    boot_img = os.path.join(ubman.config.result_dir, 'bootv4.img')
     with open(boot_img, 'rb') as inf:
         set_part_data(2, inf.read())
 
-    test_abootimg.AbootimgTestDiskImage(cons, 'vendor_boot.img', test_abootimg.vboot_img_hex)
-    vendor_boot_img = os.path.join(cons.config.result_dir, 'vendor_boot.img')
+    test_abootimg.AbootimgTestDiskImage(ubman, 'vendor_boot.img', test_abootimg.vboot_img_hex)
+    vendor_boot_img = os.path.join(ubman.config.result_dir, 'vendor_boot.img')
     with open(vendor_boot_img, 'rb') as inf:
         set_part_data(4, inf.read())
 
@@ -444,9 +444,9 @@ def setup_android_image(cons):
     print(f'wrote to {fname}')
 
     mmc_dev = 8
-    fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
-    utils.run_and_log(cons, f'qemu-img create {fname} 20M')
-    utils.run_and_log(cons, f'cgpt create {fname}')
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
+    utils.run_and_log(ubman, f'cgpt create {fname}')
 
     ptr = 40
 
@@ -467,12 +467,12 @@ def setup_android_image(cons):
         else:
             size = int(size_str)
         utils.run_and_log(
-            cons,
+            ubman,
             f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
         ptr += size
 
-    utils.run_and_log(cons, f'cgpt boot -p {fname}')
-    out = utils.run_and_log(cons, f'cgpt show -q {fname}')
+    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
 
     # Create a dict (indexed by partition number) containing the above info
     for line in out.splitlines():
@@ -482,8 +482,8 @@ def setup_android_image(cons):
     with open(fname, 'rb') as inf:
         disk_data = inf.read()
 
-    test_abootimg.AbootimgTestDiskImage(cons, 'boot.img', test_abootimg.img_hex)
-    boot_img = os.path.join(cons.config.result_dir, 'boot.img')
+    test_abootimg.AbootimgTestDiskImage(ubman, 'boot.img', test_abootimg.img_hex)
+    boot_img = os.path.join(ubman.config.result_dir, 'boot.img')
     with open(boot_img, 'rb') as inf:
         set_part_data(2, inf.read())
 
@@ -494,16 +494,16 @@ def setup_android_image(cons):
 
     return fname
 
-def setup_cedit_file(cons):
+def setup_cedit_file(ubman):
     """Set up a .dtb file for use with testing expo and configuration editor"""
-    infname = os.path.join(cons.config.source_dir,
+    infname = os.path.join(ubman.config.source_dir,
                            'test/boot/files/expo_layout.dts')
-    inhname = os.path.join(cons.config.source_dir,
+    inhname = os.path.join(ubman.config.source_dir,
                            'test/boot/files/expo_ids.h')
-    expo_tool = os.path.join(cons.config.source_dir, 'tools/expo.py')
+    expo_tool = os.path.join(ubman.config.source_dir, 'tools/expo.py')
     outfname = 'cedit.dtb'
     utils.run_and_log(
-        cons, f'{expo_tool} -e {inhname} -l {infname} -o {outfname}')
+        ubman, f'{expo_tool} -e {inhname} -l {infname} -o {outfname}')
 
 @pytest.mark.buildconfigspec('ut_dm')
 def test_ut_dm_init(ubman):
@@ -541,30 +541,30 @@ def test_ut_dm_init(ubman):
         fh.write(data)
 
 
-def setup_efi_image(cons):
+def setup_efi_image(ubman):
     """Create a 20MB disk image with an EFI app on it"""
     devnum = 1
     basename = 'flash'
-    fname, mnt = setup_image(cons, devnum, 0xc, second_part=True,
+    fname, mnt = setup_image(ubman, devnum, 0xc, second_part=True,
                              basename=basename)
 
     efi_dir = os.path.join(mnt, 'EFI')
     mkdir_cond(efi_dir)
     bootdir = os.path.join(efi_dir, 'BOOT')
     mkdir_cond(bootdir)
-    efi_src = os.path.join(cons.config.build_dir,
+    efi_src = os.path.join(ubman.config.build_dir,
                         'lib/efi_loader/testapp.efi')
     efi_dst = os.path.join(bootdir, 'BOOTSBOX.EFI')
     with open(efi_src, 'rb') as inf:
         with open(efi_dst, 'wb') as outf:
             outf.write(inf.read())
     fsfile = 'vfat18M.img'
-    utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
-    utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
-    utils.run_and_log(cons, ['sh', '-c', f'mcopy -vs -i {fsfile} {mnt}/* ::/'])
-    utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-    utils.run_and_log(cons, f'rm -rf {mnt}')
-    utils.run_and_log(cons, f'rm -f {fsfile}')
+    utils.run_and_log(ubman, f'fallocate -l 18M {fsfile}')
+    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
+    utils.run_and_log(ubman, ['sh', '-c', f'mcopy -vs -i {fsfile} {mnt}/* ::/'])
+    utils.run_and_log(ubman, f'dd if={fsfile} of={fname} bs=1M seek=1')
+    utils.run_and_log(ubman, f'rm -rf {mnt}')
+    utils.run_and_log(ubman, f'rm -f {fsfile}')
 
 @pytest.mark.buildconfigspec('cmd_bootflow')
 @pytest.mark.buildconfigspec('sandbox')
diff --git a/test/py/tests/test_vbe.py b/test/py/tests/test_vbe.py
index 876d22fa809..a1f32f375b6 100644
--- a/test/py/tests/test_vbe.py
+++ b/test/py/tests/test_vbe.py
@@ -91,10 +91,9 @@ ut bootstd -f vbe_test_fixup_norun
 @pytest.mark.boardspec('sandbox_flattree')
 @pytest.mark.requiredtool('dtc')
 def test_vbe(ubman):
-    cons = ubman
-    kernel = fit_util.make_kernel(cons, 'vbe-kernel.bin', 'kernel')
-    fdt = fit_util.make_dtb(cons, base_fdt, 'vbe-fdt')
-    fdt_out = fit_util.make_fname(cons, 'fdt-out.dtb')
+    kernel = fit_util.make_kernel(ubman, 'vbe-kernel.bin', 'kernel')
+    fdt = fit_util.make_dtb(ubman, base_fdt, 'vbe-fdt')
+    fdt_out = fit_util.make_fname(ubman, 'fdt-out.dtb')
 
     params = {
         'fit_addr' : 0x1000,
@@ -108,13 +107,13 @@ def test_vbe(ubman):
 
         'compression' : 'none',
     }
-    mkimage = cons.config.build_dir + '/tools/mkimage'
-    fit = fit_util.make_fit(cons, mkimage, base_its, params, 'test-vbe.fit',
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    fit = fit_util.make_fit(ubman, mkimage, base_its, params, 'test-vbe.fit',
                             base_fdt)
     params['fit'] = fit
     cmd = base_script % params
 
-    with cons.log.section('Kernel load'):
-        output = cons.run_command_list(cmd.splitlines())
+    with ubman.log.section('Kernel load'):
+        output = ubman.run_command_list(cmd.splitlines())
 
     assert 'failures: 0' in output[-1]
diff --git a/test/py/tests/test_vbe_vpl.py b/test/py/tests/test_vbe_vpl.py
index 317a324281e..f011b034f63 100644
--- a/test/py/tests/test_vbe_vpl.py
+++ b/test/py/tests/test_vbe_vpl.py
@@ -11,30 +11,29 @@ import utils
 @pytest.mark.boardspec('sandbox_vpl')
 @pytest.mark.requiredtool('dtc')
 def test_vbe_vpl(ubman):
-    cons = ubman
-    #cmd = [cons.config.build_dir + fname, '-v']
-    ram = os.path.join(cons.config.build_dir, 'ram.bin')
-    fdt = os.path.join(cons.config.build_dir, 'arch/sandbox/dts/test.dtb')
-    image_fname = os.path.join(cons.config.build_dir, 'image.bin')
+    #cmd = [ubman.config.build_dir + fname, '-v']
+    ram = os.path.join(ubman.config.build_dir, 'ram.bin')
+    fdt = os.path.join(ubman.config.build_dir, 'arch/sandbox/dts/test.dtb')
+    image_fname = os.path.join(ubman.config.build_dir, 'image.bin')
 
     # Enable firmware1 and the mmc that it uses. These are needed for the full
     # VBE flow.
     utils.run_and_log(
-        cons, f'fdtput -t s {fdt} /bootstd/firmware0 status disabled')
+        ubman, f'fdtput -t s {fdt} /bootstd/firmware0 status disabled')
     utils.run_and_log(
-        cons, f'fdtput -t s {fdt} /bootstd/firmware1 status okay')
+        ubman, f'fdtput -t s {fdt} /bootstd/firmware1 status okay')
     utils.run_and_log(
-        cons, f'fdtput -t s {fdt} /mmc3 status okay')
+        ubman, f'fdtput -t s {fdt} /mmc3 status okay')
     utils.run_and_log(
-        cons, f'fdtput -t s {fdt} /mmc3 filename {image_fname}')
+        ubman, f'fdtput -t s {fdt} /mmc3 filename {image_fname}')
 
     # Remove any existing RAM file, so we don't have old data present
     if os.path.exists(ram):
         os.remove(ram)
     flags = ['-p', image_fname, '-w', '-s', 'state.dtb']
-    cons.restart_uboot_with_flags(flags)
+    ubman.restart_uboot_with_flags(flags)
 
     # Make sure that VBE was used in both VPL (to load SPL) and SPL (to load
     # U-Boot
-    output = cons.run_command('vbe state')
+    output = ubman.run_command('vbe state')
     assert output == 'Phases: VPL SPL'
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 2b29871b7d4..7a7f9c379de 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -47,7 +47,7 @@ import vboot_forge
 import vboot_evil
 
 # Common helper functions
-def dtc(dts, cons, dtc_args, datadir, tmpdir, dtb):
+def dtc(dts, ubman, dtc_args, datadir, tmpdir, dtb):
     """Run the device tree compiler to compile a .dts file
 
     The output file will be the same as the input file but with a .dtb
@@ -55,30 +55,30 @@ def dtc(dts, cons, dtc_args, datadir, tmpdir, dtb):
 
     Args:
         dts: Device tree file to compile.
-        cons: U-Boot console.
+        ubman: U-Boot console.
         dtc_args: DTC arguments.
         datadir: Path to data directory.
         tmpdir: Path to temp directory.
         dtb: Resulting DTB file.
     """
     dtb = dts.replace('.dts', '.dtb')
-    utils.run_and_log(cons, 'dtc %s %s%s -O dtb '
+    utils.run_and_log(ubman, 'dtc %s %s%s -O dtb '
                       '-o %s%s' % (dtc_args, datadir, dts, tmpdir, dtb))
 
-def make_fit(its, cons, mkimage, dtc_args, datadir, fit):
+def make_fit(its, ubman, mkimage, dtc_args, datadir, fit):
     """Make a new FIT from the .its source file.
 
     This runs 'mkimage -f' to create a new FIT.
 
     Args:
         its: Filename containing .its source.
-        cons: U-Boot console.
+        ubman: U-Boot console.
         mkimage: Path to mkimage utility.
         dtc_args: DTC arguments.
         datadir: Path to data directory.
         fit: Resulting FIT file.
     """
-    utils.run_and_log(cons, [mkimage, '-D', dtc_args, '-f',
+    utils.run_and_log(ubman, [mkimage, '-D', dtc_args, '-f',
                              '%s%s' % (datadir, its), fit])
 
 # Only run the full suite on a few combinations, since it doesn't add any more
@@ -134,7 +134,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             options: Options provided to the compiler.
         """
         dtb = dts.replace('.dts', '.dtb')
-        utils.run_and_log(cons, 'dtc %s %s%s -O dtb -o %s%s %s' %
+        utils.run_and_log(ubman, 'dtc %s %s%s -O dtb -o %s%s %s' %
                           (dtc_args, datadir, dts, tmpdir, dtb, options))
 
     def run_binman(dtb):
@@ -145,7 +145,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         """
         pythonpath = os.environ.get('PYTHONPATH', '')
         os.environ['PYTHONPATH'] = pythonpath + ':' + '%s/../scripts/dtc/pylibfdt' % tmpdir
-        utils.run_and_log(cons, [binman, 'build', '-d', "%s/%s" % (tmpdir,dtb),
+        utils.run_and_log(ubman, [binman, 'build', '-d', "%s/%s" % (tmpdir,dtb),
                                  '-a', "pre-load-key-path=%s" % tmpdir, '-O',
                                  tmpdir, '-I', tmpdir])
         os.environ['PYTHONPATH'] = pythonpath
@@ -167,9 +167,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         """
         if not fit:
             fit = '%stest.fit' % tmpdir
-        cons.restart_uboot()
-        with cons.log.section('Verified boot %s %s' % (sha_algo, test_type)):
-            output = cons.run_command_list(
+        ubman.restart_uboot()
+        with ubman.log.section('Verified boot %s %s' % (sha_algo, test_type)):
+            output = ubman.run_command_list(
                 ['host load hostfs - 100 %s' % fit,
                  'fdt addr 100',
                  'bootm 100'])
@@ -194,8 +194,8 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         args = [mkimage, '-F', '-k', tmpdir, '-K', dtb, '-r', fit]
         if options:
             args += options.split(' ')
-        cons.log.action('%s: Sign images' % sha_algo)
-        utils.run_and_log(cons, args)
+        ubman.log.action('%s: Sign images' % sha_algo)
+        utils.run_and_log(ubman, args)
 
     def sign_fit_dtb(sha_algo, options, dtb):
         """Sign the FIT
@@ -211,8 +211,8 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         args = [mkimage, '-F', '-k', tmpdir, '-K', dtb, '-r', fit]
         if options:
             args += options.split(' ')
-        cons.log.action('%s: Sign images' % sha_algo)
-        utils.run_and_log(cons, args)
+        ubman.log.action('%s: Sign images' % sha_algo)
+        utils.run_and_log(ubman, args)
 
     def sign_fit_norequire(sha_algo, options):
         """Sign the FIT
@@ -228,8 +228,8 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         args = [mkimage, '-F', '-k', tmpdir, '-K', dtb, fit]
         if options:
             args += options.split(' ')
-        cons.log.action('%s: Sign images' % sha_algo)
-        utils.run_and_log(cons, args)
+        ubman.log.action('%s: Sign images' % sha_algo)
+        utils.run_and_log(ubman, args)
 
     def replace_fit_totalsize(size):
         """Replace FIT header's totalsize with something greater.
@@ -278,13 +278,13 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         else:
             rsa_keygen_bits = 2048
 
-        utils.run_and_log(cons, 'openssl genpkey -algorithm RSA -out %s%s.key '
+        utils.run_and_log(ubman, 'openssl genpkey -algorithm RSA -out %s%s.key '
                      '-pkeyopt rsa_keygen_bits:%d '
                      '-pkeyopt rsa_keygen_pubexp:%d' %
                      (tmpdir, name, rsa_keygen_bits, public_exponent))
 
         # Create a certificate containing the public key
-        utils.run_and_log(cons, 'openssl req -batch -new -x509 -key %s%s.key '
+        utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.key '
                           '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
 
     def test_with_algo(sha_algo, padding, sign_options):
@@ -303,12 +303,12 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # Compile our device tree files for kernel and U-Boot. These are
         # regenerated here since mkimage will modify them (by adding a
         # public key) below.
-        dtc('sandbox-kernel.dts', cons, dtc_args, datadir, tmpdir, dtb)
-        dtc('sandbox-u-boot.dts', cons, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
 
         # Build the FIT, but don't sign anything yet
-        cons.log.action('%s: Test FIT with signed images' % sha_algo)
-        make_fit('sign-images-%s%s.its' % (sha_algo, padding), cons, mkimage, dtc_args, datadir, fit)
+        ubman.log.action('%s: Test FIT with signed images' % sha_algo)
+        make_fit('sign-images-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else 'dev-', True)
 
         # Sign images with our dev keys
@@ -316,19 +316,19 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         run_bootm(sha_algo, 'signed images', 'dev+', True)
 
         # Create a fresh .dtb without the public keys
-        dtc('sandbox-u-boot.dts', cons, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
 
-        cons.log.action('%s: Test FIT with signed configuration' % sha_algo)
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), cons, mkimage, dtc_args, datadir, fit)
+        ubman.log.action('%s: Test FIT with signed configuration' % sha_algo)
+        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         run_bootm(sha_algo, 'unsigned config', '%s+ OK' % ('sha256' if algo_arg else sha_algo), True)
 
         # Sign images with our dev keys
         sign_fit(sha_algo, sign_options)
         run_bootm(sha_algo, 'signed config', 'dev+', True)
 
-        cons.log.action('%s: Check signed config on the host' % sha_algo)
+        ubman.log.action('%s: Check signed config on the host' % sha_algo)
 
-        utils.run_and_log(cons, [fit_check_sign, '-f', fit, '-k', dtb])
+        utils.run_and_log(ubman, [fit_check_sign, '-f', fit, '-k', dtb])
 
         if full_test:
             # Make sure that U-Boot checks that the config is in the list of
@@ -341,7 +341,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             with open(ffit, 'w+b') as fd:
                 vboot_forge.write_fdt(root, strblock, fd)
             utils.run_and_log_expect_exception(
-                cons, [fit_check_sign, '-f', ffit, '-k', dtb],
+                ubman, [fit_check_sign, '-f', ffit, '-k', dtb],
                 1, 'Failed to verify required signature')
 
             run_bootm(sha_algo, 'forged config', 'Bad Data Hash', False, ffit)
@@ -352,7 +352,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             vboot_evil.add_evil_node(fit, efit, evil_kernel, 'fakeroot')
 
             utils.run_and_log_expect_exception(
-                cons, [fit_check_sign, '-f', efit, '-k', dtb],
+                ubman, [fit_check_sign, '-f', efit, '-k', dtb],
                 1, 'Failed to verify required signature')
             run_bootm(sha_algo, 'evil fakeroot', 'Bad FIT kernel image format',
                       False, efit)
@@ -364,41 +364,41 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
             msg = 'Signature checking prevents use of unit addresses (@) in nodes'
             utils.run_and_log_expect_exception(
-                cons, [fit_check_sign, '-f', efit, '-k', dtb],
+                ubman, [fit_check_sign, '-f', efit, '-k', dtb],
                 1, msg)
             run_bootm(sha_algo, 'evil kernel@', msg, False, efit)
 
         # Create a new properly signed fit and replace header bytes
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), cons, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
         bcfg = ubman.config.buildconfig
         max_size = int(bcfg.get('config_fit_signature_max_size', 0x10000000), 0)
         existing_size = replace_fit_totalsize(max_size + 1)
         run_bootm(sha_algo, 'Signed config with bad hash', 'Bad Data Hash',
                   False)
-        cons.log.action('%s: Check overflowed FIT header totalsize' % sha_algo)
+        ubman.log.action('%s: Check overflowed FIT header totalsize' % sha_algo)
 
         # Replace with existing header bytes
         replace_fit_totalsize(existing_size)
         run_bootm(sha_algo, 'signed config', 'dev+', True)
-        cons.log.action('%s: Check default FIT header totalsize' % sha_algo)
+        ubman.log.action('%s: Check default FIT header totalsize' % sha_algo)
 
         # Increment the first byte of the signature, which should cause failure
-        sig = utils.run_and_log(cons, 'fdtget -t bx %s %s value' %
+        sig = utils.run_and_log(ubman, 'fdtget -t bx %s %s value' %
                                 (fit, sig_node))
         byte_list = sig.split()
         byte = int(byte_list[0], 16)
         byte_list[0] = '%x' % (byte + 1)
         sig = ' '.join(byte_list)
-        utils.run_and_log(cons, 'fdtput -t bx %s %s value %s' %
+        utils.run_and_log(ubman, 'fdtput -t bx %s %s value %s' %
                           (fit, sig_node, sig))
 
         run_bootm(sha_algo, 'Signed config with bad hash', 'Bad Data Hash',
                   False)
 
-        cons.log.action('%s: Check bad config on the host' % sha_algo)
+        ubman.log.action('%s: Check bad config on the host' % sha_algo)
         utils.run_and_log_expect_exception(
-            cons, [fit_check_sign, '-f', fit, '-k', dtb],
+            ubman, [fit_check_sign, '-f', fit, '-k', dtb],
             1, 'Failed to verify required signature')
 
     def test_required_key(sha_algo, padding, sign_options):
@@ -416,19 +416,19 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # Compile our device tree files for kernel and U-Boot. These are
         # regenerated here since mkimage will modify them (by adding a
         # public key) below.
-        dtc('sandbox-kernel.dts', cons, dtc_args, datadir, tmpdir, dtb)
-        dtc('sandbox-u-boot.dts', cons, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
 
-        cons.log.action('%s: Test FIT with configs images' % sha_algo)
+        ubman.log.action('%s: Test FIT with configs images' % sha_algo)
 
         # Build the FIT with prod key (keys required) and sign it. This puts the
         # signature into sandbox-u-boot.dtb, marked 'required'
-        make_fit('sign-configs-%s%s-prod.its' % (sha_algo, padding), cons, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s-prod.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
 
         # Build the FIT with dev key (keys NOT required). This adds the
         # signature into sandbox-u-boot.dtb, NOT marked 'required'.
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), cons, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit_norequire(sha_algo, sign_options)
 
         # So now sandbox-u-boot.dtb two signatures, for the prod and dev keys.
@@ -440,7 +440,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Build the FIT with dev key (keys required) and sign it. This puts the
         # signature into sandbox-u-boot.dtb, marked 'required'.
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), cons, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
 
         # Set the required-mode policy to "any".
@@ -449,7 +449,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # a dev signature only (sign_fit() overwrites the FIT).
         # Try to boot the FIT with dev key. This FIT should be accepted by
         # U-Boot because the dev key is required and policy is "any" required key.
-        utils.run_and_log(cons, 'fdtput -t s %s /signature required-mode any' %
+        utils.run_and_log(ubman, 'fdtput -t s %s /signature required-mode any' %
                           dtb)
         run_bootm(sha_algo, 'multi required key', 'dev+', True)
 
@@ -459,7 +459,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # a dev signature only (sign_fit() overwrites the FIT).
         # Try to boot the FIT with dev key. This FIT should not be accepted by
         # U-Boot because the prod key is required and policy is "all" required key
-        utils.run_and_log(cons, 'fdtput -t s %s /signature required-mode all' %
+        utils.run_and_log(ubman, 'fdtput -t s %s /signature required-mode all' %
                           dtb)
         run_bootm(sha_algo, 'multi required key', '', False)
 
@@ -473,22 +473,22 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         """
 
         dtb = '%ssandbox-u-boot-global%s.dtb' % (tmpdir, padding)
-        cons.config.dtb = dtb
+        ubman.config.dtb = dtb
 
         # Compile our device tree files for kernel and U-Boot. These are
         # regenerated here since mkimage will modify them (by adding a
         # public key) below.
-        dtc('sandbox-kernel.dts', cons, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
         dtc_options('sandbox-u-boot-global%s.dts' % padding, '-p 1024')
 
         # Build the FIT with dev key (keys NOT required). This adds the
         # signature into sandbox-u-boot.dtb, NOT marked 'required'.
-        make_fit('simple-images.its', cons, mkimage, dtc_args, datadir, fit)
+        make_fit('simple-images.its', ubman, mkimage, dtc_args, datadir, fit)
         sign_fit_dtb(sha_algo, '', dtb)
 
         # Build the dtb for binman that define the pre-load header
         # with the global sigature.
-        dtc('sandbox-binman%s.dts' % padding, cons, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-binman%s.dts' % padding, ubman, dtc_args, datadir, tmpdir, dtb)
 
         # Run binman to create the final image with the not signed fit
         # and the pre-load header that contains the global signature.
@@ -508,15 +508,14 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # Check that the boot fails if the global signature is not provided
         run_bootm(sha_algo, 'global image signature', 'signature is mandatory', False)
 
-    cons = ubman
-    tmpdir = os.path.join(cons.config.result_dir, name) + '/'
+    tmpdir = os.path.join(ubman.config.result_dir, name) + '/'
     if not os.path.exists(tmpdir):
         os.mkdir(tmpdir)
-    datadir = cons.config.source_dir + '/test/py/tests/vboot/'
+    datadir = ubman.config.source_dir + '/test/py/tests/vboot/'
     fit = '%stest.fit' % tmpdir
-    mkimage = cons.config.build_dir + '/tools/mkimage'
-    binman = cons.config.source_dir + '/tools/binman/binman'
-    fit_check_sign = cons.config.build_dir + '/tools/fit_check_sign'
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    binman = ubman.config.source_dir + '/tools/binman/binman'
+    fit_check_sign = ubman.config.build_dir + '/tools/fit_check_sign'
     dtc_args = '-I dts -O dtb -i %s' % tmpdir
     dtb = '%ssandbox-u-boot.dtb' % tmpdir
     sig_node = '/configurations/conf-1/signature'
@@ -535,9 +534,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
     # We need to use our own device tree file. Remember to restore it
     # afterwards.
-    old_dtb = cons.config.dtb
+    old_dtb = ubman.config.dtb
     try:
-        cons.config.dtb = dtb
+        ubman.config.dtb = dtb
         if global_sign:
             test_global_sign(sha_algo, padding, sign_options)
         elif required:
@@ -546,8 +545,8 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             test_with_algo(sha_algo, padding, sign_options)
     finally:
         # Go back to the original U-Boot with the correct dtb.
-        cons.config.dtb = old_dtb
-        cons.restart_uboot()
+        ubman.config.dtb = old_dtb
+        ubman.restart_uboot()
 
 
 TESTDATA_IN = [
@@ -593,8 +592,8 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
         args = [mkimage, '-F', '-k', tmpdir, fit]
         if options:
             args += options.split(' ')
-        cons.log.action('%s: Sign images' % sha_algo)
-        utils.run_and_log(cons, args)
+        ubman.log.action('%s: Sign images' % sha_algo)
+        utils.run_and_log(ubman, args)
 
     def test_add_pubkey(sha_algo, padding, sign_options):
         """Test fdt_add_pubkey utility with given hash algorithm and padding.
@@ -609,34 +608,33 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
         """
 
         # Create a fresh .dtb without the public keys
-        dtc('sandbox-u-boot.dts', cons, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
 
-        cons.log.action('%s: Test fdt_add_pubkey with signed configuration' % sha_algo)
+        ubman.log.action('%s: Test fdt_add_pubkey with signed configuration' % sha_algo)
         # Then add the dev key via the fdt_add_pubkey tool
-        utils.run_and_log(cons,
+        utils.run_and_log(ubman,
                           [fdt_add_pubkey, '-a', '%s,%s' %
                            ('sha256' if algo_arg else sha_algo,
                             'rsa3072' if sha_algo == 'sha384' else 'rsa2048'),
                            '-k', tmpdir, '-n', 'dev', '-r', 'conf', dtb])
 
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), cons, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
 
         # Sign images with our dev keys
         sign_fit(sha_algo, sign_options)
 
         # Check with fit_check_sign that FIT is signed with key
-        utils.run_and_log(cons, [fit_check_sign, '-f', fit, '-k', dtb])
+        utils.run_and_log(ubman, [fit_check_sign, '-f', fit, '-k', dtb])
 
-    cons = ubman
-    tmpdir = os.path.join(cons.config.result_dir, name) + '/'
+    tmpdir = os.path.join(ubman.config.result_dir, name) + '/'
     if not os.path.exists(tmpdir):
         os.mkdir(tmpdir)
-    datadir = cons.config.source_dir + '/test/py/tests/vboot/'
+    datadir = ubman.config.source_dir + '/test/py/tests/vboot/'
     fit = '%stest.fit' % tmpdir
-    mkimage = cons.config.build_dir + '/tools/mkimage'
-    binman = cons.config.source_dir + '/tools/binman/binman'
-    fit_check_sign = cons.config.build_dir + '/tools/fit_check_sign'
-    fdt_add_pubkey = cons.config.build_dir + '/tools/fdt_add_pubkey'
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    binman = ubman.config.source_dir + '/tools/binman/binman'
+    fit_check_sign = ubman.config.build_dir + '/tools/fit_check_sign'
+    fdt_add_pubkey = ubman.config.build_dir + '/tools/fdt_add_pubkey'
     dtc_args = '-I dts -O dtb -i %s' % tmpdir
     dtb = '%ssandbox-u-boot.dtb' % tmpdir
 
diff --git a/test/py/tests/test_vpl.py b/test/py/tests/test_vpl.py
index 735e2c3bbbe..a269c7c262e 100644
--- a/test/py/tests/test_vpl.py
+++ b/test/py/tests/test_vpl.py
@@ -23,9 +23,8 @@ def test_vpl(ubman, ut_vpl_subtest):
         ut_subtest (str): VPL test to be executed (e.g. 'dm platdata_phandle')
     """
     try:
-        cons = ubman
-        cons.restart_uboot_with_flags(['-u', '-k', ut_vpl_subtest.split()[1]])
-        output = cons.get_spawn_output().replace('\r', '')
+        ubman.restart_uboot_with_flags(['-u', '-k', ut_vpl_subtest.split()[1]])
+        output = ubman.get_spawn_output().replace('\r', '')
         assert 'failures: 0' in output
     finally:
         # Restart afterward in case a non-VPL test is run next. This should not
-- 
2.43.0

