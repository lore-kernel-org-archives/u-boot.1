Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEFBE64019
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 11:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8B138352B;
	Sun,  5 Apr 2026 13:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XLQpYuoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC0B8413A; Sun,  5 Apr 2026 13:12:44 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 964AA84020
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 13:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-470145d7e6cso855239b6e.1
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775387558; x=1775992358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RHGXNRZou735kTQ298HxD8pKMu9DSY2KQ9df84X3d0g=;
 b=XLQpYuoKlkqQ/GpJUqmQbBpIUDF+fuR8GVQ/19IOMZZsQ26UWSD5uinJfejmeQHmXR
 gRsNtQhy2cvBHpR63DLIp82LQr6bU6B6WNfz/sM/MNZg5GDD3VU3k6lY++T0+631mf+5
 y5LTLpsgrGH2zUdH2aUD0aKNCl/BSEYKpZC5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775387558; x=1775992358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RHGXNRZou735kTQ298HxD8pKMu9DSY2KQ9df84X3d0g=;
 b=Zysi8Guh74mbBQO/LSs793/3CMNP1cPzBnjBsv4XAKSSUx6zg5eR+L0K55LMky3PcM
 MwQrOA5JJWRWMjzT9RHGpYN8AtZWVMX0GGEFulFi5ctv/EBIAfow84bHNGRxBrjBX/eK
 MJ9ksvqxHT7SfezumcLt6glPB98JBJ5stHU7Hoo4dhmlkThOJv6P5a86JJR3oDzckcF7
 IsmoZCgS65hpFcNo9UWT57Bp3VovcIGAjSp2ajZ5KRsUkijrMwzxwxB/qkFAKGNlkk3t
 krrRBKBYYiG4nyVDPq/DmDM04FYyi77278Jy3yPqw9AplxMHnqITc/tJ5WFe/IEJGVug
 +jqQ==
X-Gm-Message-State: AOJu0YzWof1zIgZiemzG1ph3qNDuYbH2afBbwVv+khkWvMQwIjGaMq+t
 c+Mjl8nAY9mNCYvahs61SQDqAWTMCQgDvKN6IAcLXRyb7ekHxmBZw+FRnpsDd9An5FBYICuzmM1
 b6snO5w==
X-Gm-Gg: AeBDieuqDMK64IDZSInWiv7XaSO5z4NXQN+wD5sc8Uczp3l0tjlMnuqPBV3e2dJOtsb
 D5KKkkE5UaWAyd49nH71MA4qtKQY5Kg0CergkS6OzeWDtjUo7vu9MnYM1kUCmdFiw7mxyQcomEz
 7NoxH4m8ViHdxPHabHNZPg5f3Kgjnk+69ujRuZXLPtbnFakvUt+extHjFFZOV5fD3oBTLIrdCHr
 Po0LzjEzqWFB87bK2+xmQaQFv4Mx9F2MfqYDzIyB6iTjZzvBYZrEpUgOPSmXWkSZ2CGOwIsOWUo
 EELRORJ5xgPg49VSKaaExu2R61XGOm4qGvwWN8vePF0+vJXTZr+e4DlZXFsXjaws0rUABklvqUC
 sMiQT2OSed1pcXwpKcCvpxHi9+Xa+p3uyKVH+gAVQiX7D4iq1PYNdwSxWdXFJWS3FJLt4/ploGC
 NcaGn8CDLKWTs8yFDFfw==
X-Received: by 2002:a05:6808:2518:b0:467:19:d00d with SMTP id
 5614622812f47-46ef21106dcmr5081273b6e.0.1775387557612; 
 Sun, 05 Apr 2026 04:12:37 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d8d109b69sm6414382b6e.0.2026.04.05.04.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 04:12:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 6/8] test: Convert FIT test to use a class
Date: Sun,  5 Apr 2026 05:11:51 -0600
Message-ID: <20260405111206.945185-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405111206.945185-1-sjg@chromium.org>
References: <20260405111206.945185-1-sjg@chromium.org>
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

Move this test over to use a class instead of a function, so we can
easily split it into some related tests.

Move the TODO so it is part of the comment for the class.

Tidy up some function comments while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Remove doctest examples from find_matching() to fix Sphinx warnings

 test/py/tests/test_fit.py | 244 ++++++++++++++++++++------------------
 1 file changed, 128 insertions(+), 116 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 6a8649792cf..aec52985c65 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -11,7 +11,7 @@ import fit_util
 import utils
 
 # Define a base ITS which we can adjust using % and a dictionary
-base_its = '''
+BASE_ITS = '''
 /dts-v1/;
 
 / {
@@ -81,7 +81,7 @@ base_its = '''
 '''
 
 # Define a base FDT - currently we don't use anything in this
-base_fdt = '''
+BASE_FDT = '''
 /dts-v1/;
 
 / {
@@ -104,7 +104,7 @@ base_fdt = '''
 # This is the U-Boot script that is run for each test. First load the FIT,
 # then run the 'bootm' command, then save out memory from the places where
 # we expect 'bootm' to write things. Then quit.
-base_script = '''
+BASE_SCRIPT = '''
 mw.b 0 0 160000
 host load hostfs 0 %(fit_addr)x %(fit)s
 fdt addr %(fit_addr)x
@@ -120,45 +120,68 @@ host save hostfs 0 %(loadables2_addr)x %(loadables2_out)s %(loadables2_size)x
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('fit')
 @pytest.mark.requiredtool('dtc')
-def test_fit_base(ubman):
-    def make_fname(leaf):
+class TestFitImage:
+    """Test class for FIT image handling in U-Boot
+
+    TODO: Almost everything:
+      - hash algorithms - invalid hash/contents should be detected
+      - signature algorithms - invalid sig/contents should be detected
+      - compression
+      - checking that errors are detected like:
+            - image overwriting
+            - missing images
+            - invalid configurations
+            - incorrect os/arch/type fields
+            - empty data
+            - images too large/small
+            - invalid FDT (e.g. putting a random binary in instead)
+      - default configuration selection
+      - bootm command line parameters should have desired effect
+      - run code coverage to make sure we are testing all the code
+    """
+
+    def make_fname(self, ubman, leaf):
         """Make a temporary filename
 
         Args:
-            leaf: Leaf name of file to create (within temporary directory)
+            ubman (ConsoleBase): U-Boot fixture
+            leaf (str): Leaf name of file to create (within temporary directory)
+
         Return:
-            Temporary filename
+            str: Temporary filename
         """
         return os.path.join(ubman.config.build_dir, leaf)
 
-    def filesize(fname):
+    def filesize(self, fname):
         """Get the size of a file
 
         Args:
-            fname: Filename to check
+            fname (str): Filename to check
+
         Return:
-            Size of file in bytes
+            int: Size of file in bytes
         """
         return os.stat(fname).st_size
 
-    def read_file(fname):
+    def read_file(self, fname):
         """Read the contents of a file
 
         Args:
-            fname: Filename to read
-        Returns:
-            Contents of file as a string
+            fname (str): Filename to read
+
+        Return:
+            str: Contents of file
         """
         with open(fname, 'rb') as fd:
             return fd.read()
 
-    def make_ramdisk(filename, text):
+    def make_ramdisk(self, ubman, filename, text):
         """Make a sample ramdisk with test data
 
         Returns:
-            Filename of ramdisk created
+            str: Filename of ramdisk created
         """
-        fname = make_fname(filename)
+        fname = self.make_fname(ubman, filename)
         data = ''
         for i in range(100):
             data += f'{text} {i} was seldom used in the middle ages\n'
@@ -166,11 +189,12 @@ def test_fit_base(ubman):
             print(data, file=fd)
         return fname
 
-    def make_compressed(filename):
+    def make_compressed(self, ubman, filename):
+        """Compress a file using gzip"""
         utils.run_and_log(ubman, ['gzip', '-f', '-k', filename])
         return filename + '.gz'
 
-    def find_matching(text, match):
+    def find_matching(self, text, match):
         """Find a match in a line of text, and return the unmatched line portion
 
         This is used to extract a part of a line from some text. The match string
@@ -184,24 +208,14 @@ def test_fit_base(ubman):
         to use regex and return groups.
 
         Args:
-            text: Text to check (list of strings, one for each command issued)
-            match: String to search for
+            text (list of str): Text to check, one for each command issued
+            match (str): String to search for
+
         Return:
-            String containing unmatched portion of line
-        Exceptions:
-            ValueError: If match is not found
+            str: unmatched portion of line
 
-        >>> find_matching(['first line:10', 'second_line:20'], 'first line:')
-        '10'
-        >>> find_matching(['first line:10', 'second_line:20'], 'second line')
-        Traceback (most recent call last):
-          ...
-        ValueError: Test aborted
-        >>> find_matching('first line:10\', 'second_line:20'], 'second_line:')
-        '20'
-        >>> find_matching('first line:10\', 'second_line:20\nthird_line:30'],
-                          'third_line:')
-        '30'
+        Raises:
+            ValueError: If match is not found
         """
         # pylint: disable=W0612
         __tracebackhide__ = True
@@ -213,7 +227,7 @@ def test_fit_base(ubman):
         pytest.fail("Expected '%s' but not found in output")
         return '<no-match>'
 
-    def check_equal(expected_fname, actual_fname, failure_msg):
+    def check_equal(self, expected_fname, actual_fname, failure_msg):
         """Check that a file matches its expected contents
 
         This is always used on out-buffers whose size is decided by the test
@@ -222,59 +236,50 @@ def test_fit_base(ubman):
         expected data.
 
         Args:
-            expected_fname: Filename containing expected contents
-            actual_fname: Filename containing actual contents
-            failure_msg: Message to print on failure
+            expected_fname (str): Filename containing expected contents
+            actual_fname (str): Filename containing actual contents
+            failure_msg (str): Message to print on failure
         """
-        expected_data = read_file(expected_fname)
-        actual_data = read_file(actual_fname)
+        expected_data = self.read_file(expected_fname)
+        actual_data = self.read_file(actual_fname)
         if len(expected_data) < len(actual_data):
             actual_data = actual_data[:len(expected_data)]
         assert expected_data == actual_data, failure_msg
 
-    def check_not_equal(expected_fname, actual_fname, failure_msg):
+    def check_not_equal(self, expected_fname, actual_fname, failure_msg):
         """Check that a file does not match its expected contents
 
         Args:
-            expected_fname: Filename containing expected contents
-            actual_fname: Filename containing actual contents
-            failure_msg: Message to print on failure
+            expected_fname (str): Filename containing expected contents
+            actual_fname (str): Filename containing actual contents
+            failure_msg (str): Message to print on failure
         """
-        expected_data = read_file(expected_fname)
-        actual_data = read_file(actual_fname)
+        expected_data = self.read_file(expected_fname)
+        actual_data = self.read_file(actual_fname)
         assert expected_data != actual_data, failure_msg
 
-    def run_fit_test(mkimage):
+    def test_fit_operations(self, ubman):
         """Basic sanity check of FIT loading in U-Boot
 
-        TODO: Almost everything:
-          - hash algorithms - invalid hash/contents should be detected
-          - signature algorithms - invalid sig/contents should be detected
-          - compression
-          - checking that errors are detected like:
-                - image overwriting
-                - missing images
-                - invalid configurations
-                - incorrect os/arch/type fields
-                - empty data
-                - images too large/small
-                - invalid FDT (e.g. putting a random binary in instead)
-          - default configuration selection
-          - bootm command line parameters should have desired effect
-          - run code coverage to make sure we are testing all the code
+        This test covers various FIT configurations and verifies correct behavior.
+
+        Args:
+            ubman (ConsoleBase): U-Boot fixture
         """
+        mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+
         # Set up invariant files
-        fdt_data = fit_util.make_dtb(ubman, base_fdt, 'u-boot')
+        fdt_data = fit_util.make_dtb(ubman, BASE_FDT, 'u-boot')
         kernel = fit_util.make_kernel(ubman, 'test-kernel.bin', 'kernel')
-        ramdisk = make_ramdisk('test-ramdisk.bin', 'ramdisk')
+        ramdisk = self.make_ramdisk(ubman, 'test-ramdisk.bin', 'ramdisk')
         loadables1 = fit_util.make_kernel(ubman, 'test-loadables1.bin', 'lenrek')
-        loadables2 = make_ramdisk('test-loadables2.bin', 'ksidmar')
-        kernel_out = make_fname('kernel-out.bin')
-        fdt = make_fname('u-boot.dtb')
-        fdt_out = make_fname('fdt-out.dtb')
-        ramdisk_out = make_fname('ramdisk-out.bin')
-        loadables1_out = make_fname('loadables1-out.bin')
-        loadables2_out = make_fname('loadables2-out.bin')
+        loadables2 = self.make_ramdisk(ubman, 'test-loadables2.bin', 'ksidmar')
+        kernel_out = self.make_fname(ubman, 'kernel-out.bin')
+        fdt = self.make_fname(ubman, 'u-boot.dtb')
+        fdt_out = self.make_fname(ubman, 'fdt-out.dtb')
+        ramdisk_out = self.make_fname(ubman, 'ramdisk-out.bin')
+        loadables1_out = self.make_fname(ubman, 'loadables1-out.bin')
+        loadables2_out = self.make_fname(ubman, 'loadables2-out.bin')
 
         # Set up basic parameters with default values
         params = {
@@ -283,32 +288,32 @@ def test_fit_base(ubman):
             'kernel' : kernel,
             'kernel_out' : kernel_out,
             'kernel_addr' : 0x40000,
-            'kernel_size' : filesize(kernel),
+            'kernel_size' : self.filesize(kernel),
             'kernel_config' : 'kernel = "kernel-1";',
 
             'fdt' : fdt,
             'fdt_out' : fdt_out,
             'fdt_addr' : 0x80000,
-            'fdt_size' : filesize(fdt_data),
+            'fdt_size' : self.filesize(fdt_data),
             'fdt_load' : '',
 
             'ramdisk' : ramdisk,
             'ramdisk_out' : ramdisk_out,
             'ramdisk_addr' : 0xc0000,
-            'ramdisk_size' : filesize(ramdisk),
+            'ramdisk_size' : self.filesize(ramdisk),
             'ramdisk_load' : '',
             'ramdisk_config' : '',
 
             'loadables1' : loadables1,
             'loadables1_out' : loadables1_out,
             'loadables1_addr' : 0x100000,
-            'loadables1_size' : filesize(loadables1),
+            'loadables1_size' : self.filesize(loadables1),
             'loadables1_load' : '',
 
             'loadables2' : loadables2,
             'loadables2_out' : loadables2_out,
             'loadables2_addr' : 0x140000,
-            'loadables2_size' : filesize(loadables2),
+            'loadables2_size' : self.filesize(loadables2),
             'loadables2_load' : '',
 
             'loadables_config' : '',
@@ -316,35 +321,35 @@ def test_fit_base(ubman):
         }
 
         # Make a basic FIT and a script to load it
-        fit = fit_util.make_fit(ubman, mkimage, base_its, params)
+        fit = fit_util.make_fit(ubman, mkimage, BASE_ITS, params)
         params['fit'] = fit
-        cmd = base_script % params
+        cmd = BASE_SCRIPT % params
 
         # First check that we can load a kernel
         # We could perhaps reduce duplication with some loss of readability
         with ubman.log.section('Kernel load'):
             output = ubman.run_command_list(cmd.splitlines())
-            check_equal(kernel, kernel_out, 'Kernel not loaded')
-            check_not_equal(fdt_data, fdt_out,
-                            'FDT loaded but should be ignored')
-            check_not_equal(ramdisk, ramdisk_out,
-                            'Ramdisk loaded but should not be')
+            self.check_equal(kernel, kernel_out, 'Kernel not loaded')
+            self.check_not_equal(fdt_data, fdt_out,
+                                 'FDT loaded but should be ignored')
+            self.check_not_equal(ramdisk, ramdisk_out,
+                                 'Ramdisk loaded but should not be')
 
             # Find out the offset in the FIT where U-Boot has found the FDT
-            line = find_matching(output, 'Booting using the fdt blob at ')
+            line = self.find_matching(output, 'Booting using the fdt blob at ')
             fit_offset = int(line, 16) - params['fit_addr']
             fdt_magic = struct.pack('>L', 0xd00dfeed)
-            data = read_file(fit)
+            data = self.read_file(fit)
 
             # Now find where it actually is in the FIT (skip the first word)
             real_fit_offset = data.find(fdt_magic, 4)
             assert fit_offset == real_fit_offset, (
-                  'U-Boot loaded FDT from offset %#x, FDT is actually at %#x' %
-                  (fit_offset, real_fit_offset))
+                    'U-Boot loaded FDT from offset %#x, FDT is actually at %#x' %
+                    (fit_offset, real_fit_offset))
 
-            # Check if bootargs strings substitution works
+        # Check bootargs string substitution
             output = ubman.run_command_list([
-                'env set bootargs \\\"\'my_boot_var=${foo}\'\\\"',
+                'env set bootargs \\"\'my_boot_var=${foo}\'\\"',
                 'env set foo bar',
                 'bootm prep',
                 'env print bootargs'])
@@ -353,56 +358,63 @@ def test_fit_base(ubman):
         # Now a kernel and an FDT
         with ubman.log.section('Kernel + FDT load'):
             params['fdt_load'] = 'load = <%#x>;' % params['fdt_addr']
-            fit = fit_util.make_fit(ubman, mkimage, base_its, params)
+            fit = fit_util.make_fit(ubman, mkimage, BASE_ITS, params)
+            params['fit'] = fit
+            cmd = BASE_SCRIPT % params
             output = ubman.run_command_list(cmd.splitlines())
-            check_equal(kernel, kernel_out, 'Kernel not loaded')
-            check_equal(fdt_data, fdt_out, 'FDT not loaded')
-            check_not_equal(ramdisk, ramdisk_out,
-                            'Ramdisk loaded but should not be')
+            self.check_equal(kernel, kernel_out, 'Kernel not loaded')
+            self.check_equal(fdt_data, fdt_out, 'FDT not loaded')
+            self.check_not_equal(ramdisk, ramdisk_out,
+                                 'Ramdisk loaded but should not be')
 
         # Try a ramdisk
         with ubman.log.section('Kernel + FDT + Ramdisk load'):
             params['ramdisk_config'] = 'ramdisk = "ramdisk-1";'
             params['ramdisk_load'] = 'load = <%#x>;' % params['ramdisk_addr']
-            fit = fit_util.make_fit(ubman, mkimage, base_its, params)
+            fit = fit_util.make_fit(ubman, mkimage, BASE_ITS, params)
+            params['fit'] = fit
+            cmd = BASE_SCRIPT % params
             output = ubman.run_command_list(cmd.splitlines())
-            check_equal(ramdisk, ramdisk_out, 'Ramdisk not loaded')
+            self.check_equal(ramdisk, ramdisk_out, 'Ramdisk not loaded')
 
         # Configuration with some Loadables
         with ubman.log.section('Kernel + FDT + Ramdisk load + Loadables'):
             params['loadables_config'] = 'loadables = "kernel-2", "ramdisk-2";'
             params['loadables1_load'] = ('load = <%#x>;' %
-                                         params['loadables1_addr'])
+                                          params['loadables1_addr'])
             params['loadables2_load'] = ('load = <%#x>;' %
-                                         params['loadables2_addr'])
-            fit = fit_util.make_fit(ubman, mkimage, base_its, params)
+                                          params['loadables2_addr'])
+            fit = fit_util.make_fit(ubman, mkimage, BASE_ITS, params)
+            params['fit'] = fit
+            cmd = BASE_SCRIPT % params
             output = ubman.run_command_list(cmd.splitlines())
-            check_equal(loadables1, loadables1_out,
-                        'Loadables1 (kernel) not loaded')
-            check_equal(loadables2, loadables2_out,
-                        'Loadables2 (ramdisk) not loaded')
+            self.check_equal(loadables1, loadables1_out,
+                             'Loadables1 (kernel) not loaded')
+            self.check_equal(loadables2, loadables2_out,
+                             'Loadables2 (ramdisk) not loaded')
 
         # Kernel, FDT and Ramdisk all compressed
         with ubman.log.section('(Kernel + FDT + Ramdisk) compressed'):
             params['compression'] = 'gzip'
-            params['kernel'] = make_compressed(kernel)
-            params['fdt'] = make_compressed(fdt)
-            params['ramdisk'] = make_compressed(ramdisk)
-            fit = fit_util.make_fit(ubman, mkimage, base_its, params)
+            params['kernel'] = self.make_compressed(ubman, kernel)
+            params['fdt'] = self.make_compressed(ubman, fdt)
+            params['ramdisk'] = self.make_compressed(ubman, ramdisk)
+            fit = fit_util.make_fit(ubman, mkimage, BASE_ITS, params)
+            params['fit'] = fit
+            cmd = BASE_SCRIPT % params
             output = ubman.run_command_list(cmd.splitlines())
-            check_equal(kernel, kernel_out, 'Kernel not loaded')
-            check_equal(fdt_data, fdt_out, 'FDT not loaded')
-            check_not_equal(ramdisk, ramdisk_out, 'Ramdisk got decompressed?')
-            check_equal(ramdisk + '.gz', ramdisk_out, 'Ramdisk not loaded')
+            self.check_equal(kernel, kernel_out, 'Kernel not loaded')
+            self.check_equal(fdt_data, fdt_out, 'FDT not loaded')
+            self.check_not_equal(ramdisk, ramdisk_out, 'Ramdisk got decompressed?')
+            self.check_equal(ramdisk + '.gz', ramdisk_out, 'Ramdisk not loaded')
 
         # Try without a kernel
         with ubman.log.section('No kernel + FDT'):
             params['kernel_config'] = ''
             params['ramdisk_config'] = ''
             params['ramdisk_load'] = ''
-            fit = fit_util.make_fit(ubman, mkimage, base_its, params)
+            fit = fit_util.make_fit(ubman, mkimage, BASE_ITS, params)
+            params['fit'] = fit
+            cmd = BASE_SCRIPT % params
             output = ubman.run_command_list(cmd.splitlines())
             assert "can't get kernel image!" in '\n'.join(output)
-
-    mkimage = ubman.config.build_dir + '/tools/mkimage'
-    run_fit_test(mkimage)
-- 
2.43.0

