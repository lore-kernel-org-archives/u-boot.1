Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAAFC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 21:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A04849F0;
	Fri,  3 Jul 2026 23:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AUTPsdkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0392C84A0F; Fri,  3 Jul 2026 23:33:42 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83FEA8488D
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 23:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-43bfe209e45so486423fac.0
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 14:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783114418; x=1783719218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5gUw9QBXbyUVvQKCDh7GDI0Or6o7i785gL5VIbC6WqY=;
 b=AUTPsdkrVmQnLsw1JJGphHNKI405qkQnaY9n0huSsjiv1D8NdM94yw95KS/byQglc4
 mpxrU/csw3VOcN97A0C8jc4ddV3ei5bEfOaMK1r7YPuhl+gdM90EeGPtINPNug63E3Qx
 AxqD9DfRrJEqLOCCAEdJ4AWnJNd3H1kn2ZzRFaSvoaBHahQkOiuBop1q2Z9LFf2Shdfh
 5tIn226zGGPZYj5DEhE7BWQCso7snukgJ/QnGlhalXwT5oR021OKiY+7OtKzr1428XpM
 i4nOsCoPDOLBRuwE1VQfBMiEQY3J8H7sMbVwaJpHgr7uQ6CSucQwPtC7Ac++VkbyPOZy
 VE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783114418; x=1783719218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5gUw9QBXbyUVvQKCDh7GDI0Or6o7i785gL5VIbC6WqY=;
 b=rs3lYPi0RZSzRzQktF91ReNt38TnY1oDXEAJdvRxxkzvgacpEAyNiiua0N4WZ9SL+I
 Ey1nDWHKSQbB9EZ0d1hCUZ+WgrlnWFrfQODG+MHok/6d2stL8ty1Tl9ZVKohEPMqaahK
 +d/M7A80paJMZIOgzNVsv0mfBeb/11dliJ/BccrpeZY+Dw3ejDeUORqYyy0HZBdQxoqm
 bG6SCz2rxLW/H7MnAFiG3GZFuTvhZWFZgk9H11LOtLTrh2cAZxwoXwMkH/KwRdrBMdx/
 vdnx6gdO8ZjZZfaROZXeOgwBM0b39sx+dZF6CGiv52Yq6VH5obIdxm/4mn09mtckfYzo
 bWxA==
X-Gm-Message-State: AOJu0YzjU5YvoYpC2SPAXk50qttRuorPW9YXyAZeOXn9aPovkodn20Qn
 c7AE8dEHtgR7Tdxo446feDH3MShQG+Obc+7/XkBvln4rPfQHb/nPbgmnS0DYpGVPR7M=
X-Gm-Gg: AfdE7ck8tq8RNSYVpfp3OuYGz7NelI6HFJLPP0Z0oO2Cqm3WDunieDyI3C20CjHM8j2
 FLWS3bs5GF7UwDLKPFedERPxcExq4QaZzZY5KCP8/kxbh1rXJSR5gT5gGdPm+lgfYD3OTrXovxu
 /1Ir1paiHlNT6NZHiAE0cz8ZP7GTFmjmR2KlnRRH7iRBfmkeqLi6w/mpEsRPWCCZAeFW+WE7eSq
 OIzH1e4lusAdcemckI4N5Ulkt/aziBzYaS56I4ijTa5i9xQdopBJHFYFsvq1fBwlICQ/6lOKt7m
 VemKwUlqgRT0zvHqiwVG+3xb2n79z4QPeEVm4aDXmz/CvgXOoAoUQH560Vvp+PkkquyBui3vKdq
 6JkZ1kQojBwUe+nAoSI+wDecQjHcbYsdvl9lgPptPfeFz3W454ahTaBMPm+w+xigLysgRBFLxrD
 pDCiYdnd5nD4VbCCAuTLzuLv5+5LkN26CW/GqJiNHulbzllv8GpZgcWnl4syRh2Yi76nz761luo
 CltjEuSdsOlSk5ozfY0FJ2x0IC7k5SbsQkgPLqPcasai/CS6dqJDuNbkEGccETud7mRXi8YiApB
 G69+2D3+whI62Sg=
X-Received: by 2002:a05:6870:3921:b0:448:558c:d8ca with SMTP id
 586e51a60fabf-44d184477bfmr624880fac.40.1783114418097; 
 Fri, 03 Jul 2026 14:33:38 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm3195185fac.17.2026.07.03.14.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 14:33:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Chukun Pan <amadeus@jmu.edu.cn>, Yannic Moog <y.moog@phytec.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Aristo Chen <jj251510319013@gmail.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Subject: [PATCH] tools: binman: add build key directory option
Date: Fri,  3 Jul 2026 15:33:03 -0600
Message-ID: <20260703213308.3804461-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

U-Boot's Makefile passes KEYDIR to direct mkimage invocations, but
internal binman builds only received the generic BINMAN_INDIRS search
path. FIT entries with fit,sign or fit,encrypt therefore had to infer
the key directory from include directories before invoking mkimage -k.

Add a binman build -k/--keydir option and pass KEYDIR through with
that option from the top-level Makefile. FIT entries prefer this key
directory over include-dir discovery and then pass it to mkimage -k.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Makefile                  |  1 +
 tools/binman/binman.rst   | 10 +++++++-
 tools/binman/cmdline.py   |  2 ++
 tools/binman/control.py   |  1 +
 tools/binman/etype/fit.py | 24 +++++++++++-------
 tools/binman/ftest.py     | 51 ++++++++++++++++++++++++++++++++++++---
 tools/binman/state.py     | 21 ++++++++++++++++
 7 files changed, 97 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index d8287323c43..27be2a81e83 100644
--- a/Makefile
+++ b/Makefile
@@ -1689,6 +1689,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
 		$(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
 		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
+		$(if $(KEYDIR),-k $(KEYDIR)) \
 		-a atf-bl1-path=${BL1} \
 		-a atf-bl31-path=${BL31} \
 		-a tee-os-path=${TEE} \
diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 366491089ad..8770b279ff8 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1711,7 +1711,7 @@ Usage::
 
     binman build [-h] [-a ENTRY_ARG] [-b BOARD] [-d DT] [--fake-dtb]
         [--fake-ext-blobs] [--force-missing-bintools FORCE_MISSING_BINTOOLS]
-        [-i IMAGE] [-I INDIR] [-m] [-M] [-n] [-O OUTDIR] [-p] [-u]
+        [-i IMAGE] [-I INDIR] [-k KEYDIR] [-m] [-M] [-n] [-O OUTDIR] [-p] [-u]
         [--update-fdt-in-elf UPDATE_FDT_IN_ELF] [-W]
 
 Options:
@@ -1738,6 +1738,9 @@ Options:
     Add a path to the list of directories to use for input files. This can be
     specified multiple times to add more than one path.
 
+-k KEYDIR, --keydir KEYDIR
+    Directory containing keys for signing/encryption.
+
 -m, --map
     Output a map file for each image. See `Map files`_.
 
@@ -2161,6 +2164,11 @@ BINMAN_INDIRS
     Sets the search path for input files used by binman by adding one or more
     `-I` arguments. See :ref:`External blobs`.
 
+KEYDIR
+    Sets the key directory passed to FIT entries by adding a `-k` argument.
+    FIT entries use this directory for mkimage's `-k` argument when `fit,sign`
+    or `fit,encrypt` is enabled.
+
 BINMAN_TOOLPATHS
     Sets the search path for external tool used by binman by adding one or more
     `--toolpath` arguments. See :ref:`External tools`.
diff --git a/tools/binman/cmdline.py b/tools/binman/cmdline.py
index 9632ec115e5..cd4d05dfb69 100644
--- a/tools/binman/cmdline.py
+++ b/tools/binman/cmdline.py
@@ -128,6 +128,8 @@ controlled by a description in the board device tree.'''
             help='Image filename to build (if not specified, build all)')
     build_parser.add_argument('-I', '--indir', action='append',
             help='Add a path to the list of directories to use for input files')
+    build_parser.add_argument('-k', '--keydir', type=str,
+            help='Directory containing keys for signing/encryption')
     build_parser.add_argument('-m', '--map', action='store_true',
         default=False, help='Output a map file for each image')
     build_parser.add_argument('-M', '--allow-missing', action='store_true',
diff --git a/tools/binman/control.py b/tools/binman/control.py
index 816f7c1eba2..84586d1baf1 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -923,6 +923,7 @@ def Binman(args):
             tools.set_input_dirs(args.indir)
             tools.prepare_output_dir(args.outdir, args.preserve)
             state.SetEntryArgs(args.entry_arg)
+            state.SetKeydir(args.keydir)
             state.SetThreads(args.threads)
 
             images = PrepareImagesAndDtbs(dtb_fname, args.image,
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index f28b1e6b4cb..404e33d3022 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -14,6 +14,7 @@ import os
 from binman.entry import Entry, EntryArg
 from binman.etype.section import Entry_section
 from binman import elf
+from binman import state
 from dtoc import fdt_util
 from dtoc.fdt import Fdt
 from u_boot_pylib import tools
@@ -105,18 +106,20 @@ class Entry_fit(Entry_section):
         fit,sign
             Enable signing FIT images via mkimage as described in
             verified-boot.rst.
-            If the property is found and fit,engine is not set, the private
-            keys path is detected among binman include directories and passed to
-            mkimage via -k flag. All the keys required for signing FIT must be
-            available at time of signing and must be located in single include
-            directory.
+            If the property is found and fit,engine is not set, the key
+            directory passed with binman build -k is passed to mkimage via the
+            -k flag. If no key directory is provided, the private keys path is
+            detected among binman include directories. All the keys required for
+            signing FIT must be available at time of signing and must be
+            located in a single directory.
 
         fit,encrypt
             Enable data encryption in FIT images via mkimage. If the property
-            is found, the keys path is detected among binman include
-            directories and passed to mkimage via  -k flag. All the keys
+            is found, the key directory passed with binman build -k is passed
+            to mkimage via the -k flag. If no key directory is provided, the
+            keys path is detected among binman include directories. All the keys
             required for encrypting the FIT must be available at the time of
-            encrypting and must be located in a single include directory.
+            encrypting and must be located in a single directory.
 
             Incompatible with fit,engine.
 
@@ -485,6 +488,8 @@ class Entry_fit(Entry_section):
                 includes 'generator' entries which are used to create the FIT,
                 but should not be processed as real entries. This is set up once
                 we have the entries
+            _keydir (str): Key directory from the binman build -k option, if
+                provided
             _loadables (list of str): List of generated split-elf nodes, each
                 a node name
             _remove_props (list of str): Value of of-spl-remove-props EntryArg,
@@ -500,6 +505,7 @@ class Entry_fit(Entry_section):
         self._fit_list_prop = None
         self._fit_default_dt = None
         self._priv_entries = {}
+        self._keydir = state.GetKeydir()
         self._loadables = []
         self._remove_props = []
         props = self.GetEntryArgsOrProps(
@@ -701,7 +707,7 @@ class Entry_fit(Entry_section):
             args.update({'engine': engine})
             # If no engine, keys must exist locally, find them
             if engine is None:
-                keydir = self._get_keys_dir(data)
+                keydir = self._keydir or self._get_keys_dir(data)
             elif self._fit_props.get('fit,encrypt') is not None:
                 self.Raise('fit,engine currently does not support encryption')
 
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bf98b268ac1..0fc00fade3a 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -385,7 +385,8 @@ class TestFunctional(unittest.TestCase):
                     use_expanded=False, verbosity=None, allow_missing=False,
                     allow_fake_blobs=False, extra_indirs=None, threads=None,
                     test_section_timeout=False, update_fdt_in_elf=None,
-                    force_missing_bintools='', ignore_missing=False, output_dir=None):
+                    force_missing_bintools='', ignore_missing=False,
+                    output_dir=None, keydir=None):
         """Run binman with a given test file
 
         Args:
@@ -419,6 +420,7 @@ class TestFunctional(unittest.TestCase):
             ignore_missing (bool): True to return success even if there are
                 missing blobs or bintools
             output_dir: Specific output directory to use for image using -O
+            keydir: Directory containing keys for signing/encryption
 
         Returns:
             int return code, 0 on success
@@ -438,6 +440,8 @@ class TestFunctional(unittest.TestCase):
         if test_section_timeout:
             args.append('--test-section-timeout')
         args += ['build', '-p', '-I', self._indir, '-d', self.TestFile(fname)]
+        if keydir:
+            args += ['-k', keydir]
         if map:
             args.append('-m')
         if update_dtb:
@@ -518,7 +522,7 @@ class TestFunctional(unittest.TestCase):
     def _DoReadFileDtb(self, fname, use_real_dtb=False, use_expanded=False,
                        verbosity=None, allow_fake_blobs=True, map=False,
                        update_dtb=False, entry_args=None, reset_dtbs=True,
-                       extra_indirs=None, threads=None):
+                       extra_indirs=None, threads=None, keydir=None):
         """Run binman and return the resulting image
 
         This runs binman with a given test file and then reads the resulting
@@ -549,6 +553,7 @@ class TestFunctional(unittest.TestCase):
             extra_indirs: Extra input directories to add using -I
             threads: Number of threads to use (None for default, 0 for
                 single-threaded)
+            keydir: Directory containing keys for signing/encryption
 
         Returns:
             Tuple:
@@ -575,7 +580,7 @@ class TestFunctional(unittest.TestCase):
                     entry_args=entry_args, use_real_dtb=use_real_dtb,
                     use_expanded=use_expanded, verbosity=verbosity,
                     allow_fake_blobs=allow_fake_blobs, extra_indirs=extra_indirs,
-                    threads=threads)
+                    threads=threads, keydir=keydir)
             self.assertEqual(0, retcode)
             out_dtb_fname = tools.get_output_filename('u-boot.dtb.out')
 
@@ -8167,6 +8172,31 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             self.assertIsNotNone(signature)
             self.assertIsNotNone(signature.props.get('value'))
 
+    def testFitSignKeydir(self):
+        """Test that binman build -k is passed to mkimage"""
+        if not elf.ELF_TOOLS:
+            self.skipTest('Python elftools not available')
+        data = tools.read_file(self.TestFile("fit/rsa2048.key"))
+        self._MakeInputFile("keys/rsa2048.key", data)
+
+        test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
+        keys_subdir = os.path.join(self._indir, "keys")
+        entry_args = {
+            'of-list': 'test-fdt1',
+            'default-dt': 'test-fdt1',
+            'atf-bl31-path': 'bl31.elf',
+        }
+        data = self._DoReadFileDtb(
+            'fit/signature.dts',
+            entry_args=entry_args,
+            extra_indirs=[test_subdir],
+            keydir=keys_subdir)[0]
+
+        dtb = fdt.Fdt.FromData(data)
+        dtb.Scan()
+        signature = dtb.GetNode('/configurations/conf-uboot-1/signature')
+        self.assertIsNotNone(signature.props.get('value'))
+
     def testFitSignEngineSimple(self):
         """Test that image with FIT and signature nodes can be signed with an
            OpenSSL Engine"""
@@ -8507,6 +8537,21 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             dec_data = file.read()
         self.assertEqual(U_BOOT_NODTB_DATA, dec_data.encode('ascii'))
 
+    def testSimpleFitEncryptedDataKeydir(self):
+        """Test that encrypted FIT data uses binman build -k"""
+        data = tools.read_file(self.TestFile("fit/aes256.bin"))
+        self._MakeInputFile("keys/aes256.bin", data)
+
+        keys_subdir = os.path.join(self._indir, "keys")
+        data = self._DoReadFileDtb(
+            'fit/encrypt_data.dts',
+            keydir=keys_subdir)[0]
+
+        fit = fdt.Fdt.FromData(data)
+        fit.Scan()
+        node = fit.GetNode('/images/u-boot')
+        self.assertIn('data-size-unciphered', fit.GetProps(node))
+
     def testSimpleFitEncryptedDataMissingKey(self):
         """Test an image with a FIT containing data to be encrypted but with a missing key"""
         with self.assertRaises(ValueError) as e:
diff --git a/tools/binman/state.py b/tools/binman/state.py
index f4d885c772a..15e97f68893 100644
--- a/tools/binman/state.py
+++ b/tools/binman/state.py
@@ -41,6 +41,9 @@ fdt_path_prefix = ''
 # Arguments passed to binman to provide arguments to entries
 entry_args = {}
 
+# Directory containing keys for FIT signing/encryption
+keydir = None
+
 # True to use fake device-tree files for testing (see U_BOOT_DTB_DATA in
 # ftest.py)
 use_fake_dtb = False
@@ -206,6 +209,24 @@ def GetEntryArgBool(name):
     val = GetEntryArg(name)
     return val and val not in ['n', '0']
 
+def SetKeydir(pathname):
+    """Set the key directory to use for signing/encryption
+
+    Args:
+        pathname: Key directory, or None if not provided
+    """
+    global keydir
+
+    keydir = pathname
+
+def GetKeydir():
+    """Get the key directory to use for signing/encryption
+
+    Returns:
+        Key directory, or None if not provided
+    """
+    return keydir
+
 def Prepare(images, dtb):
     """Get device tree files ready for use
 
-- 
2.53.0

