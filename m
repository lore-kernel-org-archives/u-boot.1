Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C88EC8748
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 12:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 467D086A21;
	Fri,  8 Sep 2023 14:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9BD786A24; Fri,  8 Sep 2023 14:00:52 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5D206866AA
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 14:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDD8CD75;
 Fri,  8 Sep 2023 05:01:26 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 669FF3F67D;
 Fri,  8 Sep 2023 05:00:46 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 8/8] binman: capsule: Add support for generating EFI empty
 capsules
Date: Fri,  8 Sep 2023 17:30:02 +0530
Message-Id: <20230908120002.29851-9-sughosh.ganu@linaro.org>
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

Add support in binman for generating EFI empty capsules. These
capsules are used in the FWU A/B update feature. Also add test cases
in binman for the corresponding code coverage.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Note: Simon, I have not forgotten your comment on the earlier series
to add support for dumping the contents of a capsule. I will be
working on that task once I am done with these patches.


 tools/binman/etype/efi_empty_capsule.py       | 91 +++++++++++++++++++
 tools/binman/ftest.py                         | 52 +++++++++++
 tools/binman/test/320_capsule_accept.dts      | 16 ++++
 tools/binman/test/321_capsule_revert.dts      | 14 +++
 .../test/322_capsule_accept_missing_guid.dts  | 14 +++
 .../binman/test/323_capsule_accept_revert.dts | 17 ++++
 6 files changed, 204 insertions(+)
 create mode 100644 tools/binman/etype/efi_empty_capsule.py
 create mode 100644 tools/binman/test/320_capsule_accept.dts
 create mode 100644 tools/binman/test/321_capsule_revert.dts
 create mode 100644 tools/binman/test/322_capsule_accept_missing_guid.dts
 create mode 100644 tools/binman/test/323_capsule_accept_revert.dts

diff --git a/tools/binman/etype/efi_empty_capsule.py b/tools/binman/etype/efi_empty_capsule.py
new file mode 100644
index 0000000000..d2c781627b
--- /dev/null
+++ b/tools/binman/etype/efi_empty_capsule.py
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2023 Linaro Limited
+#
+# Entry-type module for producing an empty  EFI capsule
+#
+
+import os
+
+from binman.entry import Entry
+from binman.etype.section import Entry_section
+from dtoc import fdt_util
+from u_boot_pylib import tools
+
+class Entry_efi_empty_capsule(Entry_section):
+    """Generate EFI empty capsules
+
+    The parameters needed for generation of the empty capsules can
+    be provided as properties in the entry.
+
+    Properties / Entry arguments:
+    - image-guid: Image GUID which will be used for identifying the
+      updatable image on the board. Mandatory for accept capsule.
+    - accept-capsule - Boolean property to generate an accept capsule.
+      image-type-id
+    - revert-capsule - Boolean property to generate a revert capsule
+
+    For more details on the description of the capsule format, and the capsule
+    update functionality, refer Section 8.5 and Chapter 23 in the `UEFI
+    specification`_. For more information on the empty capsule, refer the
+    sections 2.3.2 and 2.3.3 in the `Dependable Boot specification`_.
+
+    A typical accept empty capsule entry node would then look something like this
+
+    empty-capsule {
+            type = "efi-empty-capsule";
+            /* Image GUID for testing capsule update */
+            image-type-id = SANDBOX_UBOOT_IMAGE_GUID;
+            accept-capsule;
+    };
+
+    A typical revert empty capsule entry node would then look something like this
+
+    empty-capsule {
+            type = "efi-empty-capsule";
+            revert-capsule;
+    };
+
+    The empty capsules do not have any input payload image.
+
+    .. _`UEFI specification`: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
+    .. _`Dependable Boot specification`: https://git.codelinaro.org/linaro/dependable-boot/mbfw/uploads/6f7ddfe3be24e18d4319e108a758d02e/mbfw.pdf
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.accept = 0
+        self.revert = 0
+
+    def ReadNode(self):
+        super().ReadNode()
+
+        self.image_guid = fdt_util.GetString(self._node, 'image-guid')
+        self.accept = fdt_util.GetBool(self._node, 'accept-capsule')
+        self.revert = fdt_util.GetBool(self._node, 'revert-capsule')
+
+        if self.accept and not self.image_guid:
+            self.Raise('Image GUID needed for generating accept capsule')
+
+        if self.accept and self.revert:
+            self.Raise('Need to enable either Accept or Revert capsule')
+
+    def BuildSectionData(self, required):
+        def get_binman_test_guid(type_str):
+            TYPE_TO_GUID = {
+                'binman-test' : '09d7cf52-0720-4710-91d1-08469b7fe9c8'
+            }
+            return TYPE_TO_GUID[type_str]
+
+        uniq = self.GetUniqueName()
+        outfile = self._filename if self._filename else 'capsule.%s' % uniq
+        capsule_fname = tools.get_output_filename(outfile)
+        guid = self.image_guid
+        if self.image_guid == "binman-test":
+            guid = get_binman_test_guid('binman-test')
+
+        ret = self.mkeficapsule.generate_empty_capsule(self.accept, self.revert,
+                                                       guid, capsule_fname)
+        if ret is not None:
+            return tools.read_file(capsule_fname)
+
+    def AddBintools(self, btools):
+        self.mkeficapsule = self.AddBintool(btools, 'mkeficapsule')
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 654af2c617..dbb3e3f1f8 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -124,6 +124,9 @@ TEE_ADDR = 0x5678
 FW_MGMT_GUID = 'edd5cb6d2de8444cbda17194199ad92a'
 # Image GUID specified in the DTS
 CAPSULE_IMAGE_GUID = '52cfd7092007104791d108469b7fe9c8'
+# Empty capsule GUIDs
+EMPTY_CAPSULE_ACCEPT_GUID = '4660990cc0bc044d85ece1fcedf1c6f8'
+EMPTY_CAPSULE_REVERT_GUID = '4b8bd5ace8c05f4799b56b3f7e07aaf0'
 
 class TestFunctional(unittest.TestCase):
     """Functional tests for binman
@@ -7270,6 +7273,27 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             # payload offset for non-signed capsule with no version header(184 - 190)
             self.assertEqual(payload_data.hex(), data.hex()[184:190])
 
+    def _CheckEmptyCapsule(self, data, accept_capsule=False):
+        if accept_capsule:
+            capsule_hdr_guid = EMPTY_CAPSULE_ACCEPT_GUID
+        else:
+            capsule_hdr_guid = EMPTY_CAPSULE_REVERT_GUID
+
+        # Empty Capsule Header GUID - offset(0 - 32)
+        self.assertEqual(capsule_hdr_guid, data.hex()[:32])
+
+        if accept_capsule:
+            capsule_size = "2c"
+        else:
+            capsule_size = "1c"
+
+        # size of the capsule header + contents - offset(48 - 50)
+        self.assertEqual(capsule_size, data.hex()[48:50])
+
+        if accept_capsule:
+            # capsule contents - offset(56 - 88)
+            self.assertEqual(CAPSULE_IMAGE_GUID, data.hex()[56:88])
+
     def testCapsuleGen(self):
         """Test generation of EFI capsule"""
         data = self._DoReadFile('311_capsule.dts')
@@ -7363,5 +7387,33 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         if not self.preserve_outdirs:
             shutil.rmtree(self.tmpdir)
 
+    def testCapsuleGenAcceptCapsule(self):
+        """Test generationg of accept EFI capsule"""
+        data = self._DoReadFile('320_capsule_accept.dts')
+
+        self._CheckEmptyCapsule(data, accept_capsule=True)
+
+    def testCapsuleGenRevertCapsule(self):
+        """Test generationg of revert EFI capsule"""
+        data = self._DoReadFile('321_capsule_revert.dts')
+
+        self._CheckEmptyCapsule(data)
+
+    def testCapsuleGenAcceptGuidMissing(self):
+        """Test that binman errors out on missing image GUID for accept capsule"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('322_capsule_accept_missing_guid.dts')
+
+        self.assertIn("Image GUID needed for generating accept capsule",
+                      str(e.exception))
+
+    def testCapsuleGenAcceptOrRevert(self):
+        """Test that both accept and revert capsule are not specified"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('323_capsule_accept_revert.dts')
+
+        self.assertIn("Need to enable either Accept or Revert capsule",
+                      str(e.exception))
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/320_capsule_accept.dts b/tools/binman/test/320_capsule_accept.dts
new file mode 100644
index 0000000000..4d6c005019
--- /dev/null
+++ b/tools/binman/test/320_capsule_accept.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		efi-empty-capsule {
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+			accept-capsule;
+		};
+	};
+};
diff --git a/tools/binman/test/321_capsule_revert.dts b/tools/binman/test/321_capsule_revert.dts
new file mode 100644
index 0000000000..eeaa2793a5
--- /dev/null
+++ b/tools/binman/test/321_capsule_revert.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		efi-empty-capsule {
+			revert-capsule;
+		};
+	};
+};
diff --git a/tools/binman/test/322_capsule_accept_missing_guid.dts b/tools/binman/test/322_capsule_accept_missing_guid.dts
new file mode 100644
index 0000000000..6f7062e83e
--- /dev/null
+++ b/tools/binman/test/322_capsule_accept_missing_guid.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		efi-empty-capsule {
+			accept-capsule;
+		};
+	};
+};
diff --git a/tools/binman/test/323_capsule_accept_revert.dts b/tools/binman/test/323_capsule_accept_revert.dts
new file mode 100644
index 0000000000..c68e76a669
--- /dev/null
+++ b/tools/binman/test/323_capsule_accept_revert.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		efi-empty-capsule {
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+			accept-capsule;
+			revert-capsule;
+		};
+	};
+};
-- 
2.34.1

