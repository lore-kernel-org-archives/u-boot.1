Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4D2CCFA0A
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 12:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FAD586A33;
	Fri,  8 Sep 2023 14:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B9E86A24; Fri,  8 Sep 2023 14:00:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B489E86A3A
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 14:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 387D8D75;
 Fri,  8 Sep 2023 05:01:12 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C354C3F67D;
 Fri,  8 Sep 2023 05:00:31 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 3/8] binman: capsule: Generate capsules through config file
Date: Fri,  8 Sep 2023 17:29:57 +0530
Message-Id: <20230908120002.29851-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908120002.29851-1-sughosh.ganu@linaro.org>
References: <20230908120002.29851-1-sughosh.ganu@linaro.org>
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

Add support in binman for generating capsules by reading the capsule
parameters through a config file. Also add a test case in binman for
this mode of capsule generation.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

 tools/binman/entries.rst                   | 35 ++++++++++++
 tools/binman/etype/efi_capsule_cfg_file.py | 66 ++++++++++++++++++++++
 tools/binman/ftest.py                      | 29 ++++++++++
 tools/binman/test/319_capsule_cfg.dts      | 15 +++++
 4 files changed, 145 insertions(+)
 create mode 100644 tools/binman/etype/efi_capsule_cfg_file.py
 create mode 100644 tools/binman/test/319_capsule_cfg.dts

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 801bd94674..a68ea2cb21 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -532,6 +532,41 @@ payload using the blob-ext subnode.
 
 
 
+.. _etype_efi_capsule_cfg_file:
+
+Entry: capsule: Entry for generating EFI Capsule files through config file
+--------------------------------------------------------------------------
+
+This is an entry for generating EFI capsules through a config
+file. The parameters needed for generation of the capsules are
+provided through a config file. This results in generation of one or
+multiple capsules, corresponding to the entries in the config file.
+
+Properties / Entry arguments:
+    - cfg-file: Config file for providing capsule parameters. These are
+      parameters needed for generating the capsules. The parameters can
+      be listed by running the './tools/mkeficapsule -h' command.
+
+For more details on the description of the capsule format, and the capsule
+update functionality, refer Section 8.5 and Chapter 23 in the `UEFI
+specification`_.
+
+A typical capsule entry node would then look something like this::
+
+    capsule {
+            type = "efi-capsule-cfg-file";
+            cfg-file = "path/to/the/config/file";
+    };
+
+In the above example, the entry only contains the path to the config file.
+All parameters needed for generation of the capsule, including the input
+payload image and the output capsule file are specified through the entries
+in the config file.
+
+.. _`UEFI specification`: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
+
+
+
 .. _etype_encrypted:
 
 Entry: encrypted: Externally built encrypted binary blob
diff --git a/tools/binman/etype/efi_capsule_cfg_file.py b/tools/binman/etype/efi_capsule_cfg_file.py
new file mode 100644
index 0000000000..ccf27077ec
--- /dev/null
+++ b/tools/binman/etype/efi_capsule_cfg_file.py
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2023 Linaro Limited
+#
+# Entry-type module for producing a EFI capsule through a
+# config file.
+#
+
+import os
+
+from binman.entry import Entry
+from dtoc import fdt_util
+from u_boot_pylib import tools
+
+class Entry_efi_capsule_cfg_file(Entry):
+    """Entry for generating EFI capsules through config file
+
+    This is an entry for generating EFI capsules through a
+    config file.
+
+    The parameters needed for generation of the capsules are
+    provided through a config file. This results in generation
+    of one or multiple capsules, corresponding to the entries
+    in the config file.
+
+    Properties / Entry arguments:
+    - cfg-file: Config file for providing capsule parameters. These are
+      parameters needed for generating the capsules. The parameters can
+      be listed by running the './tools/mkeficapsule -h' command.
+
+    For more details on the description of the capsule format, and the capsule
+    update functionality, refer Section 8.5 and Chapter 23 in the `UEFI
+    specification`_.
+
+    A typical capsule entry node would then look something like this
+
+    capsule {
+            type = "efi-capsule-cfg-file";
+            cfg-file = "path/to/the/config/file";
+    };
+
+    In the above example, the entry only contains the path to the config file.
+    All parameters needed for generation of the capsule, including the input
+    payload image and the output capsule file are specified through the entries
+    in the config file.
+
+    .. _`UEFI specification`: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
+"""
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.required_props = ['cfg-file']
+
+    def ReadNode(self):
+        super().ReadNode()
+
+        self.cfg_file = fdt_util.GetString(self._node, 'cfg-file')
+        if not os.path.isabs(self.cfg_file):
+            self.cfg_file = tools.get_input_filename(self.cfg_file)
+
+    def _GenCapsule(self):
+        self.mkeficapsule.generate_capsule_cfg_file(self.cfg_file)
+
+    def ObtainContents(self):
+        self._GenCapsule()
+
+    def AddBintools(self, btools):
+        self.mkeficapsule = self.AddBintool(btools, 'mkeficapsule')
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8e419645a6..654af2c617 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7334,5 +7334,34 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn("entry is missing properties: image-guid",
                       str(e.exception))
 
+    def _SetupTmpOutDir(self, outfname):
+        self.tmpdir = tempfile.mkdtemp(prefix='binman.')
+        self.capsule_fname = os.path.join(self.tmpdir, outfname)
+
+    def _BuildCapsuleCfgFile(self):
+        cfg_file = self._MakeInputFile('capsule_cfg_file.txt', b'')
+        payload_fname = self._MakeInputFile('capsule_input.bin', EFI_CAPSULE_DATA)
+        self._SetupTmpOutDir('image.bin')
+
+        with open(f'{cfg_file}', 'w') as fd:
+            fd.write('{\n')
+            fd.write('\timage-index: 0x1\n')
+            fd.write('\timage-guid: 09d7cf52-0720-4710-91d1-08469b7fe9c8\n')
+            fd.write(f'\tpayload: {payload_fname}\n')
+            fd.write(f'\tcapsule: {self.capsule_fname}\n')
+            fd.write('}\n')
+
+    def testCapsuleGenCfgFile(self):
+        """Test generation of EFI capsule through config file"""
+        self._BuildCapsuleCfgFile()
+
+        self._DoReadFile('319_capsule_cfg.dts')
+
+        data = tools.read_file(self.capsule_fname)
+        self._CheckCapsule(data)
+
+        if not self.preserve_outdirs:
+            shutil.rmtree(self.tmpdir)
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/319_capsule_cfg.dts b/tools/binman/test/319_capsule_cfg.dts
new file mode 100644
index 0000000000..3e07bdd962
--- /dev/null
+++ b/tools/binman/test/319_capsule_cfg.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		efi-capsule {
+			type = "efi-capsule-cfg-file";
+			cfg-file = "capsule_cfg_file.txt";
+		};
+	};
+};
-- 
2.34.1

