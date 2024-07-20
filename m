Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012C6C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C03AF88C80;
	Sat, 20 Jul 2024 12:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OplirMXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D4888BFD; Sat, 20 Jul 2024 12:50:21 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F0288C42
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3687fb526b9so854164f8f.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472617; x=1722077417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eUl77nOmYVSNKaUw8cpOiIDFHcbvvbkjH+iRoppC/I=;
 b=OplirMXi3w3tDLfdRcTwTDonwS7DSHAZVomwFOYWb09jFAYe6dcuxsKa/Z7glv5Ri9
 aYLctBXJ4qaHIk3GCRGZwNeLaNeD56m7LamjHYMZ+TBvNu/gOKuOLzRugGuQ1Sm5fc7d
 n4tkUNGaSrnJCJeEhwj5JyiKO9JgyoVU4R8nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472617; x=1722077417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5eUl77nOmYVSNKaUw8cpOiIDFHcbvvbkjH+iRoppC/I=;
 b=oVIIxQ3yhw/wSydgx3hzM/IY4tMjWwu83/Lb3AtuxbL+w0WwRtxREWLt8mWMcrrImt
 XJl4nPjSLsPkLj76kIa/nFGQd3BlTSobpw1nGyC4L2W/jf9S3tl/ueDBQ+o46PjnKNrQ
 +bWWi7Ej/OAEaikvPh2RF8g6FdtdZTHL/O/ngL7Fc9GVdIyXch+BfLEgbzOtMAInfdxf
 GyCyj5clBRjsCc6fPIi2e6JegOyrw6WYTxk2A4UzJ2HpTIfpRLxIM6yNe10UYrGDMJWc
 YastzmgcQNL0lQEgEtx1gLY1t7/gTQhVDw17mpmOc5paNHz96S075F/9z02qztTOLjH+
 kEqg==
X-Gm-Message-State: AOJu0Yz7pdQFHjSot8uOMF7C6ntvtUia7KQsLkA1QwIPuXWlEv/o/C4N
 vTtnercBtDGiZRLRwy3Xqw/SFRR+g1znfxo7HZ34Z2zotReyErvGo8X05O7SZLikM11acE9nvPs
 =
X-Google-Smtp-Source: AGHT+IH28yT+oYh4NQUqiu8KZwEcwzfKX6Ni5KeorTKWyPDyzjsDQl2ZG0ZSL9o0kbcJ+fTd4EMZdA==
X-Received: by 2002:adf:f709:0:b0:367:9903:a79 with SMTP id
 ffacd0b85a97d-369bae70456mr759395f8f.48.1721472617023; 
 Sat, 20 Jul 2024 03:50:17 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/20] binman: fit: Allow running fdtgrep on devicetree blobs
Date: Sat, 20 Jul 2024 11:49:48 +0100
Message-Id: <20240720104950.2730773-19-sjg@chromium.org>
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

When using FIT to load firmware builds for multiple models, the FIT must
include a common binary along with a number of devicetree blobs, one for
each model. This is the same mechanism as is used for loading an OS.

However, SPL builds do not normally use the full devicetree, but instead
a cut-down version which various nodes and properties removed.

Add a new fit,fdt-phase property to allow binman to produce these
devicetree blobs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/spl.rst                     |  2 +
 tools/binman/entries.rst                | 29 +++++++++++
 tools/binman/etype/fit.py               | 69 +++++++++++++++++++++++--
 tools/binman/ftest.py                   | 35 +++++++++++++
 tools/binman/main.py                    |  2 +
 tools/binman/test/335_fit_fdt_phase.dts | 61 ++++++++++++++++++++++
 6 files changed, 193 insertions(+), 5 deletions(-)
 create mode 100644 tools/binman/test/335_fit_fdt_phase.dts

diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
index 0a3e572310a..4bb48e6b7b3 100644
--- a/doc/develop/spl.rst
+++ b/doc/develop/spl.rst
@@ -121,6 +121,8 @@ Use `spl_phase()` to find the current U-Boot phase, e.g. `PHASE_SPL`. You can
 also find the previous and next phase and get the phase name.
 
 
+.. _fdtgrep_filter:
+
 Device tree
 -----------
 The U-Boot device tree is filtered by the fdtgrep tools during the build
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index fd8edc64fa2..12482703782 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -953,6 +953,35 @@ The 'fit,compatible' property (if present) is replaced with the compatible
 string from the root node of the devicetree, so that things work correctly
 with FIT's configuration-matching algortihm.
 
+Dealing with phases
+~~~~~~~~~~~~~~~~~~~
+
+FIT can be used to load firmware. In this case it may be necessary to run
+the devicetree for each model through fdtgrep to remove unwanted properties.
+The 'fit,fdt-phase' property can be provided to indicate the phase for which
+the devicetree is intended.
+
+For example this indicates that the FDT should be processed for VPL::
+
+    images {
+        @fdt-SEQ {
+            description = "fdt-NAME";
+            type = "flat_dt";
+            compression = "none";
+            fit,fdt-phase = "vpl";
+        };
+    };
+
+Using this mechanism, it is possible to generate a FIT which can provide VPL
+images for multiple models, with TPL selecting the correct model to use. The
+same approach can of course be used for SPL images.
+
+Note that the `of-spl-remove-props` entryarg can be used to indicate
+additional properties to remove. It is often used to remove properties like
+`clock-names` and `pinctrl-names` which are not needed in SPL builds.
+
+See :ref:`fdtgrep_filter` for more information.
+
 Generating nodes from an ELF file (split-elf)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index ab827d52066..38358292ece 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -171,7 +171,7 @@ class Entry_fit(Entry_section):
                 firmware = "atf";
                 loadables = "uboot";
                 fdt = "fdt-SEQ";
-                fit,compatible;
+                fit,compatible;    // optional
             };
         };
 
@@ -181,9 +181,38 @@ class Entry_fit(Entry_section):
     Note that if no devicetree files are provided (with '-a of-list' as above)
     then no nodes will be generated.
 
-    The 'fit,compatible' property is replaced with the compatible string from
-    the root node of the devicetree, so that things work correctly with FIT's
-    configuration-matching algortihm.
+    The 'fit,compatible' property (if present) is replaced with the compatible
+    string from the root node of the devicetree, so that things work correctly
+    with FIT's configuration-matching algortihm.
+
+    Dealing with phases
+    ~~~~~~~~~~~~~~~~~~~
+
+    FIT can be used to load firmware. In this case it may be necessary to run
+    the devicetree for each model through fdtgrep to remove unwanted properties.
+    The 'fit,fdt-phase' property can be provided to indicate the phase for which
+    the devicetree is intended.
+
+    For example this indicates that the FDT should be processed for VPL::
+
+        images {
+            @fdt-SEQ {
+                description = "fdt-NAME";
+                type = "flat_dt";
+                compression = "none";
+                fit,fdt-phase = "vpl";
+            };
+        };
+
+    Using this mechanism, it is possible to generate a FIT which can provide VPL
+    images for multiple models, with TPL selecting the correct model to use. The
+    same approach can of course be used for SPL images.
+
+    Note that the `of-spl-remove-props` entryarg can be used to indicate
+    additional properties to remove. It is often used to remove properties like
+    `clock-names` and `pinctrl-names` which are not needed in SPL builds.
+
+    See :ref:`fdtgrep_filter` for more information.
 
     Generating nodes from an ELF file (split-elf)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -368,8 +397,14 @@ class Entry_fit(Entry_section):
         self._fdts = None
         self._fdt_dir = None
         self.mkimage = None
+        self.fdtgrep = None
         self._priv_entries = {}
         self._loadables = []
+        self._remove_props = []
+        props, = self.GetEntryArgsOrProps(
+            [EntryArg('of-spl-remove-props', str)], required=False)
+        if props:
+            self._remove_props = props.split()
 
     def ReadNode(self):
         super().ReadNode()
@@ -505,6 +540,19 @@ class Entry_fit(Entry_section):
         rel_path = node.path[len(self._node.path) + 1:]
         self.Raise(f"subnode '{rel_path}': {msg}")
 
+    def _run_fdtgrep(self, infile, phase, outfile):
+        """Run fdtgrep to create the dtb for a phase
+
+        Args:
+            infile (str): Input filename containing the full FDT contents (with
+                all nodes and properties)
+            phase (str): Phase to generate for ('tpl', 'vpl', 'spl')
+            outfile (str): Output filename to write the grepped FDT contents to
+                (with only neceesary nodes and properties)
+        """
+        return self.fdtgrep.create_for_phase(infile, phase, outfile,
+                                             self._remove_props)
+
     def _build_input(self):
         """Finish the FIT by adding the 'data' properties to it
 
@@ -606,6 +654,7 @@ class Entry_fit(Entry_section):
                 for seq, fdt_fname in enumerate(self._fdts):
                     node_name = node.name[1:].replace('SEQ', str(seq + 1))
                     fname = tools.get_input_filename(fdt_fname + '.dtb')
+                    fdt_phase = None
                     with fsw.add_node(node_name):
                         for pname, prop in node.props.items():
                             if pname == 'fit,firmware':
@@ -623,6 +672,8 @@ class Entry_fit(Entry_section):
                                 fdt.Scan()
                                 prop = fdt.GetRoot().props['compatible']
                                 fsw.property('compatible', prop.bytes)
+                            elif pname == 'fit,fdt-phase':
+                                fdt_phase = fdt_util.GetString(node, pname)
                             elif pname.startswith('fit,'):
                                 self._raise_subnode(
                                     node, f"Unknown directive '{pname}'")
@@ -635,7 +686,14 @@ class Entry_fit(Entry_section):
 
                         # Add data for 'images' nodes (but not 'config')
                         if depth == 1 and in_images:
-                            fsw.property('data', tools.read_file(fname))
+                            if fdt_phase:
+                                phase_fname = tools.get_output_filename(
+                                    f'{fdt_fname}-{fdt_phase}.dtb')
+                                self._run_fdtgrep(fname, fdt_phase, phase_fname)
+                                data = tools.read_file(phase_fname)
+                            else:
+                                data = tools.read_file(fname)
+                            fsw.property('data', data)
 
                         for subnode in node.subnodes:
                             with fsw.add_node(subnode.name):
@@ -863,6 +921,7 @@ class Entry_fit(Entry_section):
     def AddBintools(self, btools):
         super().AddBintools(btools)
         self.mkimage = self.AddBintool(btools, 'mkimage')
+        self.fdtgrep = self.AddBintool(btools, 'fdtgrep')
 
     def CheckMissing(self, missing_list):
         # We must use our private entry list for this since generator nodes
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index d930e353faf..93f3d22cf57 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7655,6 +7655,41 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             self.assertEqual(f'u-boot,model-{expected}',
                              fnode.props['compatible'].value)
 
+    def testFitFdtPhase(self):
+        """Test an image with an FIT with fdt-phase in the fdt nodes"""
+        phase = 'tpl'
+        entry_args = {
+            f'{phase}-dtb': '1',
+            f'{phase}-bss-pad': 'y',
+            'of-spl-remove-props': 'prop-to-remove another-prop-to-get-rid-of',
+            'of-list': 'model1 model2',
+            'default-dt': 'model2',
+            }
+        testdir, dtb_list = self.SetupAlternateDts()
+        data = self._DoReadFileDtb(
+            '335_fit_fdt_phase.dts', use_real_dtb=True, update_dtb=True,
+            entry_args=entry_args, extra_indirs=[testdir])[0]
+        fit_data = data[len(U_BOOT_DATA):-len(U_BOOT_NODTB_DATA)]
+        fit = fdt.Fdt.FromData(fit_data)
+        fit.Scan()
+
+        # Check that each FDT has only the expected properties for the phase
+        for seq in range(1, 2):
+            fnode = fit.GetNode(f'/images/fdt-{seq}')
+            self.assertIsNotNone(fnode)
+            dtb = fdt.Fdt.FromData(fnode.props['data'].bytes)
+            dtb.Scan()
+
+            # Make sure that the 'bootph-pre-sram' tag in /node protects it from
+            # removal
+            node = dtb.GetNode('/node')
+            self.assertIsNotNone(node)
+            self.assertEqual({'some-prop', 'not-a-prop-to-remove'},
+                             node.props.keys())
+
+            # Make sure the other node is gone
+            self.assertIsNone(dtb.GetNode('/node/other-node'))
+
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/main.py b/tools/binman/main.py
index 92d2431aea7..dc817ddcd42 100755
--- a/tools/binman/main.py
+++ b/tools/binman/main.py
@@ -122,6 +122,8 @@ def RunBinman(args):
             ret_code = RunTests(args.debug, args.verbosity, args.processes,
                                 args.test_preserve_dirs, args.tests,
                                 args.toolpath)
+            if args.debug and not test_util.use_concurrent:
+                print('Tests can run in parallel: pip install concurrencytest')
 
     elif args.cmd == 'bintool-docs':
         control.write_bintool_docs(bintool.Bintool.get_tool_list())
diff --git a/tools/binman/test/335_fit_fdt_phase.dts b/tools/binman/test/335_fit_fdt_phase.dts
new file mode 100644
index 00000000000..f8d0740a394
--- /dev/null
+++ b/tools/binman/test/335_fit_fdt_phase.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot {
+		};
+		fit {
+			description = "test-desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+
+			images {
+				kernel {
+					description = "Vanilla Linux kernel";
+					type = "kernel";
+					arch = "ppc";
+					os = "linux";
+					compression = "gzip";
+					load = <00000000>;
+					entry = <00000000>;
+					hash-1 {
+						algo = "crc32";
+					};
+					hash-2 {
+						algo = "sha1";
+					};
+					u-boot {
+					};
+				};
+				@fdt-SEQ {
+					description = "fdt-NAME.dtb";
+					type = "flat_dt";
+					compression = "none";
+					fit,fdt-phase = "tpl";
+					hash {
+						algo = "sha256";
+					};
+				};
+			};
+
+			configurations {
+				default = "@config-DEFAULT-SEQ";
+				@config-SEQ {
+					description = "conf-NAME.dtb";
+					firmware = "uboot";
+					loadables = "atf";
+					fdt = "fdt-SEQ";
+					fit,firmware = "tpl";
+					fit,compatible;
+				};
+			};
+		};
+		u-boot-nodtb {
+		};
+	};
+};
-- 
2.34.1

