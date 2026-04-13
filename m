Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED0EF34C51
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F274184198;
	Mon, 13 Apr 2026 15:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eZjNSMGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C03C84198; Mon, 13 Apr 2026 15:01:46 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D9E1841BE
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d9b21d1461so4331762a34.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776085301; x=1776690101; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARBnx5q5EInHL6IUi4Hcrbs4zz/mwXJcLbMsF4TmrCE=;
 b=eZjNSMGBMPNVEJGTGo3aThflE9qROM4DOflFy7TJ72QhU48kfTp+eagryzyVplCxHy
 4iXiybRXz43FA+ew63frxV0h5AbKXFHpOlAqJU4ZM3FsUu7Pngq4vpiPnLAgMrpfy8G2
 6oinIM7GNSlJbMerKF3ffvKneJGK3JPj3501I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776085301; x=1776690101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ARBnx5q5EInHL6IUi4Hcrbs4zz/mwXJcLbMsF4TmrCE=;
 b=XLkN7iHBAFNXoXi+njX5LweMWMBpzW7O5q0rt8do94Dn0LruKHyyn916va6G13KgTJ
 68oeUQ6dISI5eVEozGy8kPOdsij/L7ZUBAR6fOKM/YAag9Lvq4wLpbHjj2y8lA6iG1bA
 O4hxS7Mee4cWfkfMOmYms+oSvMOS1nPihvgg2DVbNgq+JvBibt9Ro5ImR7Rji9u9K6G+
 bf+nI7VqqPyZGMjYIQTjXKTM6Mfau0QAq9a48aniSgVesRrWD7v5kTubViJFJo4mBQMp
 R7F8Vf+pdvN/CmyFGJvXDflZ+Xzm/OfB4Hjt6HqiukWaNPtt+AnOoFKybVZLME81R9RA
 av8A==
X-Gm-Message-State: AOJu0YzGtunhCgW/Zw7XIUyfE06q5xwuBPGWAA6xiwxGhfKnELPfBgpn
 hbW+VvQKmtbjHoxiGxvbh++o52WnFDBZHh2c+B1JTCv8zyI45/FreySSE6Un+A/oIlErI/UmfMY
 OjfOVnA==
X-Gm-Gg: AeBDiet2cEJSy/FOtMiLBsprBXoRcJazJzk1M5vslUsnk2AdlrrjmK+P7Jp6NSdFE+V
 mB60C9tnZRx3PYvY102LmMx6w12lreu5u/Xp+8cpZXSOqlC0Rz8ahtQQdO39XgKVXyChwclWpFm
 y3qTTdKveuAnijWTOc9XGWZ47x/UxpQPBAh8C9HjS4RSWgSziJ5lTlGGBObKu2P0XIXGLMAN4+Y
 fzD/WVg0rhcDpAJ/uc5LxZ51gNoaBwVVw1by8FZz3g5hjIyoochI3ydYaXOQ/cm8BAw1IL0LXNM
 tVdu02KLB0ovyH2khA7jyigbTj7rsSMdBthx8gJhcohSGkyqLF0Y8S6V7giRYbGa/0qUo0v+uva
 KxZrWVULnfE+EiJyXz7Vr9C6lnCK84/gNo958phd77F7Ax9vWYnN0C4rGfOK3zF6YqnwYiiP5ro
 GBTGMxpnghc8OZxHwF4Q==
X-Received: by 2002:a05:6830:3497:b0:7d7:ecee:af6b with SMTP id
 46e09a7af769-7dc28c5e001mr6731885a34.2.1776085300581; 
 Mon, 13 Apr 2026 06:01:40 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696532bsm8369144a34.21.2026.04.13.06.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 06:01:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 7/8] test: Add fsetup fixture and prepare helper for FIT
 test
Date: Mon, 13 Apr 2026 06:59:58 -0600
Message-ID: <20260413130007.1987326-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413130007.1987326-1-sjg@chromium.org>
References: <20260413130007.1987326-1-sjg@chromium.org>
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

Create an 'fsetup' fixture which sets up files and parameters, and a
prepare() helper which builds a FIT with given parameter overrides.

Update check_equal() and check_not_equal() to look up filenames from a
params dict by key, reducing the number of local variables needed.

Split the single test_fit_operations() into individual test functions so
that each appears separately in the results.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_fit.py | 286 +++++++++++++++++++-------------------
 1 file changed, 146 insertions(+), 140 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 9a51d32bf49..bcaaa6a5fc4 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -241,91 +241,70 @@ class TestFitImage:
         pytest.fail("Expected '%s' but not found in output")
         return '<no-match>'
 
-    def check_equal(self, expected_fname, actual_fname, failure_msg):
+    def check_equal(self, params, expected_key, actual_key, failure_msg):
         """Check that a file matches its expected contents
 
         This is always used on out-buffers whose size is decided by the test
         script anyway, which in some cases may be larger than what we're
         actually looking for. So it's safe to truncate it to the size of the
         expected data.
-
-        Args:
-            expected_fname (str): Filename containing expected contents
-            actual_fname (str): Filename containing actual contents
-            failure_msg (str): Message to print on failure
         """
-        expected_data = self.read_file(expected_fname)
-        actual_data = self.read_file(actual_fname)
+        expected_data = self.read_file(params[expected_key])
+        actual_data = self.read_file(params[actual_key])
         if len(expected_data) < len(actual_data):
             actual_data = actual_data[:len(expected_data)]
         assert expected_data == actual_data, failure_msg
 
-    def check_not_equal(self, expected_fname, actual_fname, failure_msg):
-        """Check that a file does not match its expected contents
-
-        Args:
-            expected_fname (str): Filename containing expected contents
-            actual_fname (str): Filename containing actual contents
-            failure_msg (str): Message to print on failure
-        """
-        expected_data = self.read_file(expected_fname)
-        actual_data = self.read_file(actual_fname)
+    def check_not_equal(self, params, expected_key, actual_key, failure_msg):
+        """Check that a file does not match its expected contents"""
+        expected_data = self.read_file(params[expected_key])
+        actual_data = self.read_file(params[actual_key])
         assert expected_data != actual_data, failure_msg
 
-    def test_fit_operations(self, ubman):
-        """Basic sanity check of FIT loading in U-Boot
-
-        This test covers various FIT configurations and verifies correct behavior.
-
-        Args:
-            ubman (ConsoleBase): U-Boot fixture
-        """
+    @pytest.fixture()
+    def fsetup(self, ubman):
+        """Set up files and default parameters for FIT tests"""
         mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
-
-        # Set up invariant files
         fdt_data = fit_util.make_dtb(ubman, BASE_FDT, 'u-boot')
         kernel = fit_util.make_kernel(ubman, 'test-kernel.bin', 'kernel')
         ramdisk = self.make_ramdisk(ubman, 'test-ramdisk.bin', 'ramdisk')
-        loadables1 = fit_util.make_kernel(ubman, 'test-loadables1.bin', 'lenrek')
-        loadables2 = self.make_ramdisk(ubman, 'test-loadables2.bin', 'ksidmar')
-        kernel_out = self.make_fname(ubman, 'kernel-out.bin')
-        fdt = self.make_fname(ubman, 'u-boot.dtb')
-        fdt_out = self.make_fname(ubman, 'fdt-out.dtb')
-        ramdisk_out = self.make_fname(ubman, 'ramdisk-out.bin')
-        loadables1_out = self.make_fname(ubman, 'loadables1-out.bin')
-        loadables2_out = self.make_fname(ubman, 'loadables2-out.bin')
-
-        # Set up basic parameters with default values
-        params = {
+        loadables1 = fit_util.make_kernel(ubman, 'test-loadables1.bin',
+                                          'lenrek')
+        loadables2 = self.make_ramdisk(ubman, 'test-loadables2.bin',
+                                       'ksidmar')
+
+        yield {
+            'mkimage' : mkimage,
             'fit_addr' : 0x1000,
 
             'kernel' : kernel,
-            'kernel_out' : kernel_out,
+            'kernel_out' : self.make_fname(ubman, 'kernel-out.bin'),
             'kernel_addr' : 0x40000,
             'kernel_size' : self.filesize(kernel),
             'kernel_config' : 'kernel = "kernel-1";',
 
-            'fdt' : fdt,
-            'fdt_out' : fdt_out,
+            'fdt_data' : fdt_data,
+            'fdt' : self.make_fname(ubman, 'u-boot.dtb'),
+            'fdt_out' : self.make_fname(ubman, 'fdt-out.dtb'),
             'fdt_addr' : 0x80000,
             'fdt_size' : self.filesize(fdt_data),
             'fdt_load' : '',
 
             'ramdisk' : ramdisk,
-            'ramdisk_out' : ramdisk_out,
+            'ramdisk_out' : self.make_fname(ubman, 'ramdisk-out.bin'),
             'ramdisk_addr' : 0xc0000,
             'ramdisk_size' : self.filesize(ramdisk),
             'ramdisk_load' : '',
             'ramdisk_config' : '',
 
             'loadables1' : loadables1,
-            'loadables1_out' : loadables1_out,
+            'loadables1_out' : self.make_fname(ubman, 'loadables1-out.bin'),
             'loadables1_addr' : 0x100000,
             'loadables1_size' : self.filesize(loadables1),
             'loadables1_load' : '',
 
             'loadables2' : loadables2,
-            'loadables2_out' : loadables2_out,
+            'loadables2_out' : self.make_fname(ubman, 'loadables2-out.bin'),
             'loadables2_addr' : 0x140000,
             'loadables2_size' : self.filesize(loadables2),
             'loadables2_load' : '',
@@ -334,101 +313,128 @@ class TestFitImage:
             'compression' : 'none',
         }
 
-        # Make a basic FIT and a script to load it
-        fit = fit_util.make_fit(ubman, mkimage, BASE_ITS, params)
+    def prepare(self, ubman, fsetup, **kwargs):
+        """Build a FIT with given overrides
+
+        Args:
+            ubman (ConsoleBase): U-Boot fixture
+            fsetup (dict): Default parameters from the fsetup fixture
+            kwargs: Parameter overrides for this particular test
+
+        Return:
+            tuple:
+                list of str: Commands to run for the test
+                dict: Parameters used by the test
+                str: Filename of the FIT that was created
+        """
+        params = {**fsetup, **kwargs}
+        fit = fit_util.make_fit(ubman, params['mkimage'], BASE_ITS, params)
         params['fit'] = fit
-        cmd = BASE_SCRIPT % params
-
-        # First check that we can load a kernel
-        # We could perhaps reduce duplication with some loss of readability
-        with ubman.log.section('Kernel load'):
-            output = ubman.run_command_list(cmd.splitlines())
-            self.check_equal(kernel, kernel_out, 'Kernel not loaded')
-            self.check_not_equal(fdt_data, fdt_out,
-                                 'FDT loaded but should be ignored')
-            self.check_not_equal(ramdisk, ramdisk_out,
-                                 'Ramdisk loaded but should not be')
-
-            # Find out the offset in the FIT where U-Boot has found the FDT
-            line = self.find_matching(output, 'Booting using the fdt blob at ')
-            fit_offset = int(line, 16) - params['fit_addr']
-            fdt_magic = struct.pack('>L', 0xd00dfeed)
-            data = self.read_file(fit)
-
-            # Now find where it actually is in the FIT (skip the first word)
-            real_fit_offset = data.find(fdt_magic, 4)
-            assert fit_offset == real_fit_offset, (
-                    'U-Boot loaded FDT from offset %#x, FDT is actually at %#x' %
-                    (fit_offset, real_fit_offset))
+        cmds = (BASE_SCRIPT % params).splitlines()
+        return cmds, params, fit
+
+    def test_fit_kernel_load(self, ubman, fsetup):
+        """Test loading a FIT image with only a kernel"""
+        cmds, params, fit = self.prepare(ubman, fsetup)
+
+        output = ubman.run_command_list(cmds)
+        self.check_equal(params, 'kernel', 'kernel_out', 'Kernel not loaded')
+        self.check_not_equal(params, 'fdt_data', 'fdt_out',
+                             'FDT loaded but should be ignored')
+        self.check_not_equal(params, 'ramdisk', 'ramdisk_out',
+                             'Ramdisk loaded but should not be')
+
+        # Find out the offset in the FIT where U-Boot has found the FDT
+        line = self.find_matching(output, 'Booting using the fdt blob at ')
+        fit_offset = int(line, 16) - params['fit_addr']
+        fdt_magic = struct.pack('>L', 0xd00dfeed)
+        data = self.read_file(fit)
+
+        # Now find where it actually is in the FIT (skip the first word)
+        real_fit_offset = data.find(fdt_magic, 4)
+        assert fit_offset == real_fit_offset, (
+            'U-Boot loaded FDT from offset %#x, FDT is actually at %#x' %
+            (fit_offset, real_fit_offset))
 
         # Check bootargs string substitution
-            output = ubman.run_command_list([
-                'env set bootargs \\"\'my_boot_var=${foo}\'\\"',
-                'env set foo bar',
-                'bootm prep',
-                'env print bootargs'])
-            assert 'bootargs="my_boot_var=bar"' in output, "Bootargs strings not substituted"
-
-        # Now a kernel and an FDT
-        with ubman.log.section('Kernel + FDT load'):
-            params['fdt_load'] = 'load = <%#x>;' % params['fdt_addr']
-            fit = fit_util.make_fit(ubman, mkimage, BASE_ITS, params)
-            params['fit'] = fit
-            cmd = BASE_SCRIPT % params
-            output = ubman.run_command_list(cmd.splitlines())
-            self.check_equal(kernel, kernel_out, 'Kernel not loaded')
-            self.check_equal(fdt_data, fdt_out, 'FDT not loaded')
-            self.check_not_equal(ramdisk, ramdisk_out,
-                                 'Ramdisk loaded but should not be')
-
-        # Try a ramdisk
-        with ubman.log.section('Kernel + FDT + Ramdisk load'):
-            params['ramdisk_config'] = 'ramdisk = "ramdisk-1";'
-            params['ramdisk_load'] = 'load = <%#x>;' % params['ramdisk_addr']
-            fit = fit_util.make_fit(ubman, mkimage, BASE_ITS, params)
-            params['fit'] = fit
-            cmd = BASE_SCRIPT % params
-            output = ubman.run_command_list(cmd.splitlines())
-            self.check_equal(ramdisk, ramdisk_out, 'Ramdisk not loaded')
-
-        # Configuration with some Loadables
-        with ubman.log.section('Kernel + FDT + Ramdisk load + Loadables'):
-            params['loadables_config'] = 'loadables = "kernel-2", "ramdisk-2";'
-            params['loadables1_load'] = ('load = <%#x>;' %
-                                          params['loadables1_addr'])
-            params['loadables2_load'] = ('load = <%#x>;' %
-                                          params['loadables2_addr'])
-            fit = fit_util.make_fit(ubman, mkimage, BASE_ITS, params)
-            params['fit'] = fit
-            cmd = BASE_SCRIPT % params
-            output = ubman.run_command_list(cmd.splitlines())
-            self.check_equal(loadables1, loadables1_out,
-                             'Loadables1 (kernel) not loaded')
-            self.check_equal(loadables2, loadables2_out,
-                             'Loadables2 (ramdisk) not loaded')
-
-        # Kernel, FDT and Ramdisk all compressed
-        with ubman.log.section('(Kernel + FDT + Ramdisk) compressed'):
-            params['compression'] = 'gzip'
-            params['kernel'] = self.make_compressed(ubman, kernel)
-            params['fdt'] = self.make_compressed(ubman, fdt)
-            params['ramdisk'] = self.make_compressed(ubman, ramdisk)
-            fit = fit_util.make_fit(ubman, mkimage, BASE_ITS, params)
-            params['fit'] = fit
-            cmd = BASE_SCRIPT % params
-            output = ubman.run_command_list(cmd.splitlines())
-            self.check_equal(kernel, kernel_out, 'Kernel not loaded')
-            self.check_equal(fdt_data, fdt_out, 'FDT not loaded')
-            self.check_not_equal(ramdisk, ramdisk_out, 'Ramdisk got decompressed?')
-            self.check_equal(ramdisk + '.gz', ramdisk_out, 'Ramdisk not loaded')
-
-        # Try without a kernel
-        with ubman.log.section('No kernel + FDT'):
-            params['kernel_config'] = ''
-            params['ramdisk_config'] = ''
-            params['ramdisk_load'] = ''
-            fit = fit_util.make_fit(ubman, mkimage, BASE_ITS, params)
-            params['fit'] = fit
-            cmd = BASE_SCRIPT % params
-            output = ubman.run_command_list(cmd.splitlines())
-            assert "can't get kernel image!" in '\n'.join(output)
+        output = ubman.run_command_list([
+            'env set bootargs \\"\'my_boot_var=${foo}\'\\"',
+            'env set foo bar',
+            'bootm prep',
+            'env print bootargs'])
+        assert 'bootargs="my_boot_var=bar"' in output, \
+                "Bootargs strings not substituted"
+
+    def test_fit_kernel_fdt_load(self, ubman, fsetup):
+        """Test loading a FIT image with a kernel and FDT"""
+        cmds, params, _ = self.prepare(
+            ubman, fsetup,
+            fdt_load='load = <%#x>;' % fsetup['fdt_addr'])
+
+        ubman.run_command_list(cmds)
+        self.check_equal(params, 'kernel', 'kernel_out', 'Kernel not loaded')
+        self.check_equal(params, 'fdt_data', 'fdt_out', 'FDT not loaded')
+        self.check_not_equal(params, 'ramdisk', 'ramdisk_out',
+                             'Ramdisk loaded but should not be')
+
+    def test_fit_kernel_fdt_ramdisk_load(self, ubman, fsetup):
+        """Test loading a FIT image with kernel, FDT, and ramdisk"""
+        cmds, params, _ = self.prepare(
+            ubman, fsetup,
+            fdt_load='load = <%#x>;' % fsetup['fdt_addr'],
+            ramdisk_config='ramdisk = "ramdisk-1";',
+            ramdisk_load='load = <%#x>;' % fsetup['ramdisk_addr'])
+
+        ubman.run_command_list(cmds)
+        self.check_equal(params, 'ramdisk', 'ramdisk_out',
+                         'Ramdisk not loaded')
+
+    def test_fit_loadables_load(self, ubman, fsetup):
+        """Test a configuration with loadables"""
+        cmds, params, _ = self.prepare(
+            ubman, fsetup,
+            fdt_load='load = <%#x>;' % fsetup['fdt_addr'],
+            ramdisk_config='ramdisk = "ramdisk-1";',
+            ramdisk_load='load = <%#x>;' % fsetup['ramdisk_addr'],
+            loadables_config='loadables = "kernel-2", "ramdisk-2";',
+            loadables1_load='load = <%#x>;' % fsetup['loadables1_addr'],
+            loadables2_load='load = <%#x>;' % fsetup['loadables2_addr'])
+
+        ubman.run_command_list(cmds)
+        self.check_equal(params, 'loadables1', 'loadables1_out',
+                         'Loadables1 (kernel) not loaded')
+        self.check_equal(params, 'loadables2', 'loadables2_out',
+                         'Loadables2 (ramdisk) not loaded')
+
+    def test_fit_compressed_images_load(self, ubman, fsetup):
+        """Test loading compressed kernel, FDT, and ramdisk images"""
+        cmds, params, _ = self.prepare(
+            ubman, fsetup,
+            fdt_load='load = <%#x>;' % fsetup['fdt_addr'],
+            ramdisk_config='ramdisk = "ramdisk-1";',
+            ramdisk_load='load = <%#x>;' % fsetup['ramdisk_addr'],
+            compression='gzip',
+            kernel=self.make_compressed(ubman, fsetup['kernel']),
+            fdt=self.make_compressed(ubman, fsetup['fdt']),
+            ramdisk=self.make_compressed(ubman, fsetup['ramdisk']))
+
+        ubman.run_command_list(cmds)
+        self.check_equal(fsetup, 'kernel', 'kernel_out',
+                         'Kernel not loaded')
+        self.check_equal(fsetup, 'fdt_data', 'fdt_out', 'FDT not loaded')
+        self.check_not_equal(fsetup, 'ramdisk', 'ramdisk_out',
+                             'Ramdisk got decompressed?')
+        self.check_equal(params, 'ramdisk', 'ramdisk_out',
+                         'Ramdisk not loaded')
+
+    def test_fit_no_kernel_load(self, ubman, fsetup):
+        """Test that bootm fails when no kernel is specified"""
+        cmds = self.prepare(
+            ubman, fsetup,
+            fdt_load='load = <%#x>;' % fsetup['fdt_addr'],
+            kernel_config='',
+            ramdisk_config='',
+            ramdisk_load='')[0]
+
+        output = ubman.run_command_list(cmds)
+        assert "can't get kernel image!" in '\n'.join(output)
-- 
2.43.0

