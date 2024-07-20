Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66E8C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A49488C4A;
	Sat, 20 Jul 2024 12:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WYMgBhuO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF0688B74; Sat, 20 Jul 2024 12:50:17 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1797E88C42
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-36868fcb919so1108937f8f.2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472614; x=1722077414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03KOV2R744f/Nu737PJyiRFIQFfo/8hYR2wMRGZCmeg=;
 b=WYMgBhuOlkyMdD4dqVIFUMZfr4R/LNFA3h67AhNKDEY8l/fmO22VpAIKY7jlnIgitY
 UzjwSxEtYVsmwIweP/wC5LIRHrAyGZGoLs6Ay5PL97rt+yEdFp1+52zmTh9J2M5ZUfoV
 hbgz731HAe74I9qukiDnORjdTzOEu3xOybuAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472614; x=1722077414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03KOV2R744f/Nu737PJyiRFIQFfo/8hYR2wMRGZCmeg=;
 b=hoHBL7N4tPrn/DNIxiX8iHR6SNZJJDKpownJZ2UJtyxGJcAy84w3c3XJLSzG8tItRY
 fTUT+6itmyWrP2vD+FhE+EEgXu4TkN9QPft9NxVS1iS7nBHZUgf4GdCs+DD7ZYtCEwkF
 ENM+VntAu4pFNtAqV4S/JVib2ZxLeptQU9bvFz3mgXl1HQJRIvoOidlSHuG9jiUrsg5Z
 MGpZ9+iuQk+NXWLUimuznOoU9qo8jvttxBSugYjcK5o4yt6o0Ho/ICt78RTke5W6pZrV
 RRtdvYLafzT64IkPtQNRICtLIJLk8DeYTNxRu+xcKi0GXNqPtoOLi+ceV+pOqctj/3aj
 j/Yg==
X-Gm-Message-State: AOJu0YwNT8a/uFBTBhrDDl+t+G3ONeT3xFAV9zX1sL+aSzQ53rmhFwLc
 fSemL3RLHqNKMqdtcGovYtoEXsTVHKixKEuqdN3AMzGe2bW4jy71uNZkfVALw9BIP+tdLWXa8lM
 =
X-Google-Smtp-Source: AGHT+IEoeGp693fao3CCLTMYsARHeovRrkpWay3lw8bBT7AglESjVV3nVkA7/+UnweMYodg9kL+rHA==
X-Received: by 2002:adf:f482:0:b0:367:8fee:443b with SMTP id
 ffacd0b85a97d-369bb2e8f65mr711989f8f.41.1721472614188; 
 Sat, 20 Jul 2024 03:50:14 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/20] binman: Add support for alternative FDTs
Date: Sat, 20 Jul 2024 11:49:45 +0100
Message-Id: <20240720104950.2730773-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
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

FIT provides a way to select between different devicetree blobs
depending on the model. This works fine for U-Boot proper and allows SPL
to select the correct blob for the current board at runtime. The boot
sequence (SPL->U-Boot proper) is therefore covered by the existing
feature set.

The first boot phase (typically TPL) cannot use FIT since SoC boot ROMs
don't currently support it. Therefore the TPL image must be specific to
each model it boots on.

To support booting on mulitple models, binman must therefore produce a
separate TPL image for each model, even if the images for the rest of
the phases are identical.

TPL needs to be packaged as an executable binary along with a reduced
devicetree. When multiple models are supported, a reduced devicetree
must be provided for each model.

U-Boot's build system is designed to build a single devicetree for SPL
builds, so does not support this requirement.

Add a new 'alternatives' feature to Binman, allowing it to automatically
subset a devicetree to produce the reduced devicetree for a particular
phase for each supported model. With this it is possible to produce a
separate TPL image for each of the models. The correct one can then be
loaded onto a board, along with the common FIT image(s).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/btool/fdtgrep.py                |   2 +-
 tools/binman/control.py                      |   3 +
 tools/binman/entries.rst                     |  42 ++++++
 tools/binman/entry.py                        |   4 +-
 tools/binman/etype/alternates_fdt.py         | 132 +++++++++++++++++++
 tools/binman/ftest.py                        | 121 +++++++++++++++++
 tools/binman/image.py                        |  13 ++
 tools/binman/test/328_alternates_fdt.dts     |  28 ++++
 tools/binman/test/329_alternates_fdtgrep.dts |  29 ++++
 tools/binman/test/330_alternates_vpl.dts     |  29 ++++
 tools/binman/test/331_alternates_spl.dts     |  29 ++++
 tools/binman/test/332_alternates_inval.dts   |  29 ++++
 tools/binman/test/alt_dts/model1.dts         |  24 ++++
 tools/binman/test/alt_dts/model2.dts         |  24 ++++
 14 files changed, 507 insertions(+), 2 deletions(-)
 create mode 100644 tools/binman/etype/alternates_fdt.py
 create mode 100644 tools/binman/test/328_alternates_fdt.dts
 create mode 100644 tools/binman/test/329_alternates_fdtgrep.dts
 create mode 100644 tools/binman/test/330_alternates_vpl.dts
 create mode 100644 tools/binman/test/331_alternates_spl.dts
 create mode 100644 tools/binman/test/332_alternates_inval.dts
 create mode 100644 tools/binman/test/alt_dts/model1.dts
 create mode 100644 tools/binman/test/alt_dts/model2.dts

diff --git a/tools/binman/btool/fdtgrep.py b/tools/binman/btool/fdtgrep.py
index c34d8d8943b..da1f8c7bf4e 100644
--- a/tools/binman/btool/fdtgrep.py
+++ b/tools/binman/btool/fdtgrep.py
@@ -84,7 +84,7 @@ class Bintoolfdtgrep(bintool.Bintool):
         elif phase == 'spl':
             tag = 'bootph-pre-ram'
         else:
-            raise(f"Invalid U-Boot phase '{phase}': Use tpl/vpl/spl")
+            raise ValueError(f"Invalid U-Boot phase '{phase}': Use tpl/vpl/spl")
 
         # These args mirror those in cmd_fdtgrep in scripts/Makefile.lib
         # First do the first stage
diff --git a/tools/binman/control.py b/tools/binman/control.py
index a233c778d5e..542c2b45644 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -734,6 +734,9 @@ def ProcessImage(image, update_fdt, write_map, get_contents=True,
         image.WriteMap()
 
     has_problems = CheckForProblems(image)
+
+    image.WriteAlternates()
+
     return has_problems
 
 def Binman(args):
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 38dfe2c7db9..8bfec8b434e 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -11,6 +11,48 @@ features to produce new behaviours.
 
 
 
+.. _etype_alternates_fdt:
+
+Entry: alternates-fdt: Entry that generates alternative sections for each devicetree provided
+---------------------------------------------------------------------------------------------
+
+When creating an image designed to boot on multiple models, each model
+requires its own devicetree. This entry deals with selecting the correct
+devicetree from a directory containing them. Each one is read in turn, then
+used to produce section contents which are written to a file. This results
+in a number of images, one for each model.
+
+For example this produces images for each .dtb file in the 'dtb' directory::
+
+    alternates-fdt {
+        fdt-list-dir = "dtb";
+        filename-pattern = "NAME.bin";
+        fdt-phase = "tpl";
+
+        section {
+            u-boot-tpl {
+            };
+        };
+    };
+
+Each output file is named based on its input file, so an input file of
+`model1.dtb` results in an output file of `model1.bin` (i.e. the `NAME` in
+the `filename-pattern` property is replaced with the .dtb basename).
+
+Note that this entry type still produces contents for the 'main' image, in
+that case using the normal dtb provided to Binman, e.g. `u-boot-tpl.dtb`.
+But that image is unlikely to be useful, since it relates to whatever dtb
+happened to be the default when U-Boot builds
+(i.e. `CONFIG_DEFAULT_DEVICE_TREE`). However, Binman ensures that the size
+of each of the alternates is the same as the 'default' one, so they can in
+principle be 'slotted in' to the appropriate place in the main image.
+
+The optional `fdt-phase` property indicates the phase to build. In this
+case, it etype runs fdtgrep to obtain the devicetree subset for that phase,
+respecting the `bootph-xxx` tags in the devicetree.
+
+
+
 .. _etype_atf_bl31:
 
 Entry: atf-bl31: ARM Trusted Firmware (ATF) BL31 blob
diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 494b1b1278d..6d2f3789940 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -1395,6 +1395,8 @@ features to produce new behaviours.
                 'u-boot-tpl-dtb'
 
         Returns:
-            bytes: Contents of requested FDT
+            tuple:
+                fname (str): Filename of .dtb
+                bytes: Contents of FDT (possibly run through fdtgrep)
         """
         return self.section.FdtContents(fdt_etype)
diff --git a/tools/binman/etype/alternates_fdt.py b/tools/binman/etype/alternates_fdt.py
new file mode 100644
index 00000000000..808f535aa1b
--- /dev/null
+++ b/tools/binman/etype/alternates_fdt.py
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier:      GPL-2.0+
+# Copyright 2024 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+
+"""Entry-type module for producing multiple alternate sections"""
+
+import glob
+import os
+
+from binman.entry import EntryArg
+from binman.etype.section import Entry_section
+from dtoc import fdt_util
+from u_boot_pylib import tools
+
+class Entry_alternates_fdt(Entry_section):
+    """Entry that generates alternative sections for each devicetree provided
+
+    When creating an image designed to boot on multiple models, each model
+    requires its own devicetree. This entry deals with selecting the correct
+    devicetree from a directory containing them. Each one is read in turn, then
+    used to produce section contents which are written to a file. This results
+    in a number of images, one for each model.
+
+    For example this produces images for each .dtb file in the 'dtb' directory::
+
+        alternates-fdt {
+            fdt-list-dir = "dtb";
+            filename-pattern = "NAME.bin";
+            fdt-phase = "tpl";
+
+            section {
+                u-boot-tpl {
+                };
+            };
+        };
+
+    Each output file is named based on its input file, so an input file of
+    `model1.dtb` results in an output file of `model1.bin` (i.e. the `NAME` in
+    the `filename-pattern` property is replaced with the .dtb basename).
+
+    Note that this entry type still produces contents for the 'main' image, in
+    that case using the normal dtb provided to Binman, e.g. `u-boot-tpl.dtb`.
+    But that image is unlikely to be useful, since it relates to whatever dtb
+    happened to be the default when U-Boot builds
+    (i.e. `CONFIG_DEFAULT_DEVICE_TREE`). However, Binman ensures that the size
+    of each of the alternates is the same as the 'default' one, so they can in
+    principle be 'slotted in' to the appropriate place in the main image.
+
+    The optional `fdt-phase` property indicates the phase to build. In this
+    case, it etype runs fdtgrep to obtain the devicetree subset for that phase,
+    respecting the `bootph-xxx` tags in the devicetree.
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.fdt_list_dir = None
+        self.filename_pattern = None
+        self.required_props = ['fdt-list-dir']
+        self._cur_fdt = None
+        self._fdt_phase = None
+        self.fdtgrep = None
+        self._fdt_dir = None
+        self._fdts = None
+        self._fname_pattern = None
+        self._remove_props = None
+        self.alternates = None
+
+    def ReadNode(self):
+        """Read properties from the node"""
+        super().ReadNode()
+        self._fdt_dir = fdt_util.GetString(self._node, 'fdt-list-dir')
+        fname = tools.get_input_filename(self._fdt_dir)
+        fdts = glob.glob('*.dtb', root_dir=fname)
+        self._fdts = [os.path.splitext(f)[0] for f in fdts]
+
+        self._fdt_phase = fdt_util.GetString(self._node, 'fdt-phase')
+
+        # This is used by Image.WriteAlternates()
+        self.alternates = self._fdts
+
+        self._fname_pattern = fdt_util.GetString(self._node, 'filename-pattern')
+
+        self._remove_props = []
+        props, = self.GetEntryArgsOrProps(
+            [EntryArg('of-spl-remove-props', str)], required=False)
+        if props:
+            self._remove_props = props.split()
+
+    def FdtContents(self, fdt_etype):
+        # If there is no current FDT, just use the normal one
+        if not self._cur_fdt:
+            return self.section.FdtContents(fdt_etype)
+
+        # Find the file to use
+        fname = os.path.join(self._fdt_dir, f'{self._cur_fdt}.dtb')
+        infile = tools.get_input_filename(fname)
+
+        # Run fdtgrep if needed, to remove unwanted nodes and properties
+        if self._fdt_phase:
+            uniq = self.GetUniqueName()
+            outfile = tools.get_output_filename(
+                f'{uniq}.{self._cur_fdt}-{self._fdt_phase}.dtb')
+            self.fdtgrep.create_for_phase(infile, self._fdt_phase, outfile,
+                                          self._remove_props)
+            return outfile, tools.read_file(outfile)
+        return fname, tools.read_file(infile)
+
+    def ProcessWithFdt(self, alt):
+        """Produce the contents of this entry, using a particular FDT blob
+
+        Args:
+            alt (str): Name of the alternate
+
+        Returns:
+            tuple:
+                str: Filename to use for the alternate's .bin file
+                bytes: Contents of this entry's section, using the selected FDT
+        """
+        pattern = self._fname_pattern or 'NAME.bin'
+        fname = pattern.replace('NAME', alt)
+
+        data = b''
+        try:
+            self._cur_fdt = alt
+            self.ProcessContents()
+            data = self.GetPaddedData()
+        finally:
+            self._cur_fdt = None
+        return fname, data
+
+    def AddBintools(self, btools):
+        super().AddBintools(btools)
+        self.fdtgrep = self.AddBintool(btools, 'fdtgrep')
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index d091855b8e3..684e960b582 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7,6 +7,7 @@
 #    python -m unittest func_test.TestFunctional.testHelp
 
 import collections
+import glob
 import gzip
 import hashlib
 from optparse import OptionParser
@@ -7484,6 +7485,126 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             err,
             "Image '.*' is missing external blobs and is non-functional: .*")
 
+    def CheckAlternates(self, dts, phase, xpl_data):
+        """Run the test for the alterative-fdt etype
+
+        Args:
+            dts (str): Devicetree file to process
+            phase (str): Phase to process ('spl', 'tpl' or 'vpl')
+            xpl_data (bytes): Expected data for the phase's binary
+
+        Returns:
+            dict of .dtb files produced
+                key: str filename
+                value: Fdt object
+        """
+        testdir = TestFunctional._MakeInputDir('dtb')
+        dtb_list = []
+        for fname in glob.glob(f'{self.TestFile("alt_dts")}/*.dts'):
+            tmp_fname = fdt_util.EnsureCompiled(fname, testdir)
+            base = os.path.splitext(os.path.basename(fname))[0]
+            dtb_list.append(base + '.bin')
+            shutil.move(tmp_fname, os.path.join(testdir, base + '.dtb'))
+
+        entry_args = {
+            f'{phase}-dtb': '1',
+            f'{phase}-bss-pad': 'y',
+            'of-spl-remove-props': 'prop-to-remove another-prop-to-get-rid-of',
+        }
+        data = self._DoReadFileDtb(dts, use_real_dtb=True, update_dtb=True,
+                                   use_expanded=True, entry_args=entry_args)[0]
+        self.assertEqual(xpl_data, data[:len(xpl_data)])
+        rest = data[len(xpl_data):]
+        pad_len = 10
+        self.assertEqual(tools.get_bytes(0, pad_len), rest[:pad_len])
+
+        # Check the dtb is using the test file
+        dtb_data = rest[pad_len:]
+        dtb = fdt.Fdt.FromData(dtb_data)
+        dtb.Scan()
+        fdt_size = dtb.GetFdtObj().totalsize()
+        self.assertEqual('model-not-set',
+                         fdt_util.GetString(dtb.GetRoot(), 'compatible'))
+
+        pad_len = 10
+
+        # Check the other output files
+        dtbs = {}
+        for fname in dtb_list:
+            pathname = tools.get_output_filename(fname)
+            self.assertTrue(os.path.exists(pathname))
+
+            data = tools.read_file(pathname)
+            self.assertEqual(xpl_data, data[:len(xpl_data)])
+            rest = data[len(xpl_data):]
+
+            self.assertEqual(tools.get_bytes(0, pad_len), rest[:pad_len])
+            rest = rest[pad_len:]
+
+            dtb = fdt.Fdt.FromData(rest)
+            dtb.Scan()
+            dtbs[fname] = dtb
+
+            expected = 'one' if '1' in fname else 'two'
+            self.assertEqual(f'u-boot,model-{expected}',
+                             fdt_util.GetString(dtb.GetRoot(), 'compatible'))
+
+            # Make sure the FDT is the same size as the 'main' one
+            rest = rest[fdt_size:]
+
+            self.assertEqual(b'', rest)
+        return dtbs
+
+    def testAlternatesFdt(self):
+        """Test handling of alternates-fdt etype"""
+        self._SetupTplElf()
+        dtbs = self.CheckAlternates('328_alternates_fdt.dts', 'tpl',
+                                    U_BOOT_TPL_NODTB_DATA)
+        for dtb in dtbs.values():
+            # Check for the node with the tag
+            node = dtb.GetNode('/node')
+            self.assertIsNotNone(node)
+            self.assertEqual(5, len(node.props.keys()))
+
+            # Make sure the other node is still there
+            self.assertIsNotNone(dtb.GetNode('/node/other-node'))
+
+    def testAlternatesFdtgrep(self):
+        """Test handling of alternates-fdt etype using fdtgrep"""
+        self._SetupTplElf()
+        dtbs = self.CheckAlternates('329_alternates_fdtgrep.dts', 'tpl',
+                                    U_BOOT_TPL_NODTB_DATA)
+        for dtb in dtbs.values():
+            # Check for the node with the tag
+            node = dtb.GetNode('/node')
+            self.assertIsNotNone(node)
+            self.assertEqual({'some-prop', 'not-a-prop-to-remove'},
+                             node.props.keys())
+
+            # Make sure the other node is gone
+            self.assertIsNone(dtb.GetNode('/node/other-node'))
+
+    def testAlternatesFdtgrepVpl(self):
+        """Test handling of alternates-fdt etype using fdtgrep with vpl"""
+        self._SetupVplElf()
+        dtbs = self.CheckAlternates('330_alternates_vpl.dts', 'vpl',
+                                    U_BOOT_VPL_NODTB_DATA)
+
+    def testAlternatesFdtgrepSpl(self):
+        """Test handling of alternates-fdt etype using fdtgrep with spl"""
+        self._SetupSplElf()
+        dtbs = self.CheckAlternates('331_alternates_spl.dts', 'spl',
+                                    U_BOOT_SPL_NODTB_DATA)
+
+    def testAlternatesFdtgrepInval(self):
+        """Test alternates-fdt etype using fdtgrep with invalid phase"""
+        self._SetupSplElf()
+        with self.assertRaises(ValueError) as e:
+            dtbs = self.CheckAlternates('332_alternates_inval.dts', 'spl',
+                                        U_BOOT_SPL_NODTB_DATA)
+        self.assertIn("Invalid U-Boot phase 'bad-phase': Use tpl/vpl/spl",
+                      str(e.exception))
+
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/image.py b/tools/binman/image.py
index c1be5cc23a2..702c9055585 100644
--- a/tools/binman/image.py
+++ b/tools/binman/image.py
@@ -193,6 +193,19 @@ class Image(section.Entry_section):
                 os.remove(sname)
             os.symlink(fname, sname)
 
+    def WriteAlternates(self):
+        """Write out alternative devicetree blobs, each in its own file"""
+        alt_entry = self.FindEntryType('alternates-fdt')
+        if not alt_entry:
+            return
+
+        for alt in alt_entry.alternates:
+            fname, data = alt_entry.ProcessWithFdt(alt)
+            pathname = tools.get_output_filename(fname)
+            tout.info(f"Writing alternate '{alt}' to '{pathname}'")
+            tools.write_file(pathname, data)
+            tout.info("Wrote %#x bytes" % len(data))
+
     def WriteMap(self):
         """Write a map of the image to a .map file
 
diff --git a/tools/binman/test/328_alternates_fdt.dts b/tools/binman/test/328_alternates_fdt.dts
new file mode 100644
index 00000000000..c913c8e4745
--- /dev/null
+++ b/tools/binman/test/328_alternates_fdt.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2024 Google LLC
+// Written by Simon Glass <sjg@chromium.org>
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	compatible = "model-not-set";
+
+	binman {
+		alternates-fdt {
+			fdt-list-dir = "dtb";
+			filename-pattern = "NAME.bin";
+
+			section {
+				u-boot-tpl {
+				};
+			};
+		};
+
+		blob {
+			filename = "blobfile";
+		};
+	};
+};
diff --git a/tools/binman/test/329_alternates_fdtgrep.dts b/tools/binman/test/329_alternates_fdtgrep.dts
new file mode 100644
index 00000000000..41695281456
--- /dev/null
+++ b/tools/binman/test/329_alternates_fdtgrep.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2024 Google LLC
+// Written by Simon Glass <sjg@chromium.org>
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	compatible = "model-not-set";
+
+	binman {
+		alternates-fdt {
+			fdt-list-dir = "dtb";
+			filename-pattern = "NAME.bin";
+			fdt-phase = "tpl";
+
+			section {
+				u-boot-tpl {
+				};
+			};
+		};
+
+		blob {
+			filename = "blobfile";
+		};
+	};
+};
diff --git a/tools/binman/test/330_alternates_vpl.dts b/tools/binman/test/330_alternates_vpl.dts
new file mode 100644
index 00000000000..5b57069e2ab
--- /dev/null
+++ b/tools/binman/test/330_alternates_vpl.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2024 Google LLC
+// Written by Simon Glass <sjg@chromium.org>
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	compatible = "model-not-set";
+
+	binman {
+		alternates-fdt {
+			fdt-list-dir = "dtb";
+			filename-pattern = "NAME.bin";
+			fdt-phase = "vpl";
+
+			section {
+				u-boot-vpl {
+				};
+			};
+		};
+
+		blob {
+			filename = "blobfile";
+		};
+	};
+};
diff --git a/tools/binman/test/331_alternates_spl.dts b/tools/binman/test/331_alternates_spl.dts
new file mode 100644
index 00000000000..882fefce34a
--- /dev/null
+++ b/tools/binman/test/331_alternates_spl.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2024 Google LLC
+// Written by Simon Glass <sjg@chromium.org>
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	compatible = "model-not-set";
+
+	binman {
+		alternates-fdt {
+			fdt-list-dir = "dtb";
+			filename-pattern = "NAME.bin";
+			fdt-phase = "spl";
+
+			section {
+				u-boot-spl {
+				};
+			};
+		};
+
+		blob {
+			filename = "blobfile";
+		};
+	};
+};
diff --git a/tools/binman/test/332_alternates_inval.dts b/tools/binman/test/332_alternates_inval.dts
new file mode 100644
index 00000000000..8c145dd2449
--- /dev/null
+++ b/tools/binman/test/332_alternates_inval.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2024 Google LLC
+// Written by Simon Glass <sjg@chromium.org>
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	compatible = "model-not-set";
+
+	binman {
+		alternates-fdt {
+			fdt-list-dir = "dtb";
+			filename-pattern = "NAME.bin";
+			fdt-phase = "bad-phase";
+
+			section {
+				u-boot-spl {
+				};
+			};
+		};
+
+		blob {
+			filename = "blobfile";
+		};
+	};
+};
diff --git a/tools/binman/test/alt_dts/model1.dts b/tools/binman/test/alt_dts/model1.dts
new file mode 100644
index 00000000000..01e95e8fabe
--- /dev/null
+++ b/tools/binman/test/alt_dts/model1.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2024 Google LLC
+// Written by Simon Glass <sjg@chromium.org>
+
+/dts-v1/;
+
+/ {
+	model = "Model One";
+	compatible = "u-boot,model-one";
+
+	/* this node remains due to bootph-pre-sram tag */
+	node {
+		some-prop;
+		prop-to-remove;
+		another-prop-to-get-rid-of;
+		not-a-prop-to-remove;
+		bootph-pre-sram;
+
+		/* this node get removed by fdtgrep */
+		other-node {
+			another-prop;
+		};
+	};
+};
diff --git a/tools/binman/test/alt_dts/model2.dts b/tools/binman/test/alt_dts/model2.dts
new file mode 100644
index 00000000000..7829c519772
--- /dev/null
+++ b/tools/binman/test/alt_dts/model2.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2024 Google LLC
+// Written by Simon Glass <sjg@chromium.org>
+
+/dts-v1/;
+
+/ {
+	model = "Model Two";
+	compatible = "u-boot,model-two";
+
+	/* this node remains due to bootph-pre-sram tag */
+	node {
+		some-prop;
+		prop-to-remove;
+		another-prop-to-get-rid-of;
+		not-a-prop-to-remove;
+		bootph-pre-sram;
+
+		/* this node get removed by fdtgrep */
+		other-node {
+			another-prop;
+		};
+	};
+};
-- 
2.34.1

