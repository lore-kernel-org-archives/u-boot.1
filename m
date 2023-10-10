Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FB3CD68E5
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 09:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A087486E0B;
	Tue, 10 Oct 2023 11:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E2A086E06; Tue, 10 Oct 2023 11:12:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 16B3B86459
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 11:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 195921FB;
 Tue, 10 Oct 2023 02:12:53 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6F9D3F762;
 Tue, 10 Oct 2023 02:12:09 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 6/6] binman: capsule: Add support for generating EFI empty
 capsules
Date: Tue, 10 Oct 2023 14:40:59 +0530
Message-Id: <20231010091059.375036-7-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010091059.375036-1-sughosh.ganu@linaro.org>
References: <20231010091059.375036-1-sughosh.ganu@linaro.org>
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
Changes since V1:
* Instead of using two separate boolean values, use a 'capsule-type'
  property for indicating generation of an accept/revert capsule.
* Make corresponding changes in the sanity checks, documentation and
  tests based on the above change.
* Use lower case characters for GUIDs.
* Call get_binman_test_guid() from the efi_capsule entry module.
* Add the documentation entry for the empty capsules in entries.rst.
* Remove the #[address,size]-cells properties from the test dts' for
  empty capsules.

 tools/binman/entries.rst                      | 44 ++++++++++
 tools/binman/etype/efi_empty_capsule.py       | 86 +++++++++++++++++++
 tools/binman/ftest.py                         | 57 ++++++++++++
 tools/binman/test/319_capsule_accept.dts      | 13 +++
 tools/binman/test/320_capsule_revert.dts      | 11 +++
 .../test/321_capsule_accept_missing_guid.dts  | 11 +++
 .../test/322_empty_capsule_type_missing.dts   | 12 +++
 .../323_capsule_accept_revert_missing.dts     | 13 +++
 8 files changed, 247 insertions(+)
 create mode 100644 tools/binman/etype/efi_empty_capsule.py
 create mode 100644 tools/binman/test/319_capsule_accept.dts
 create mode 100644 tools/binman/test/320_capsule_revert.dts
 create mode 100644 tools/binman/test/321_capsule_accept_missing_guid.dts
 create mode 100644 tools/binman/test/322_empty_capsule_type_missing.dts
 create mode 100644 tools/binman/test/323_capsule_accept_revert_missing.dts

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 801bd94674..e7b4e9380e 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -532,6 +532,50 @@ payload using the blob-ext subnode.
 
 
 
+.. _etype_efi_empty_capsule:
+
+Entry: efi-empty-capsule: Entry for generating EFI Empty Capsule files
+----------------------------------------------------------------------
+
+The parameters needed for generation of the empty capsules can
+be provided as properties in the entry.
+
+Properties / Entry arguments:
+    - image-guid: Image GUID which will be used for identifying the
+      updatable image on the board. Mandatory for accept capsule.
+    - capsule-type - String to indicate type of capsule to generate. Valid
+      values are 'accept' and 'revert'.
+
+For more details on the description of the capsule format, and the capsule
+update functionality, refer Section 8.5 and Chapter 23 in the `UEFI
+specification`_. For more information on the empty capsule, refer the
+sections 2.3.2 and 2.3.3 in the `Dependable Boot specification`_.
+
+A typical accept empty capsule entry node would then look something
+like this::
+
+    empty-capsule {
+            type = "efi-empty-capsule";
+            /* GUID of the image being accepted */
+            image-type-id = SANDBOX_UBOOT_IMAGE_GUID;
+            capsule-type = "accept";
+    };
+
+A typical revert empty capsule entry node would then look something
+like this::
+
+    empty-capsule {
+            type = "efi-empty-capsule";
+            capsule-type = "revert";
+    };
+
+The empty capsules do not have any input payload image.
+
+.. _`UEFI specification`: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
+.. _`Dependable Boot specification`: https://git.codelinaro.org/linaro/dependable-boot/mbfw/uploads/6f7ddfe3be24e18d4319e108a758d02e/mbfw.pdf
+
+
+
 .. _etype_encrypted:
 
 Entry: encrypted: Externally built encrypted binary blob
diff --git a/tools/binman/etype/efi_empty_capsule.py b/tools/binman/etype/efi_empty_capsule.py
new file mode 100644
index 0000000000..064bf9a77f
--- /dev/null
+++ b/tools/binman/etype/efi_empty_capsule.py
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2023 Linaro Limited
+#
+# Entry-type module for producing an empty  EFI capsule
+#
+
+import os
+
+from binman.entry import Entry
+from binman.etype.efi_capsule import get_binman_test_guid
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
+    - capsule-type - String to indicate type of capsule to generate. Valid
+      values are 'accept' and 'revert'.
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
+            /* GUID of image being accepted */
+            image-type-id = SANDBOX_UBOOT_IMAGE_GUID;
+            capsule-type = "accept";
+    };
+
+    A typical revert empty capsule entry node would then look something like this
+
+    empty-capsule {
+            type = "efi-empty-capsule";
+            capsule-type = "revert";
+    };
+
+    The empty capsules do not have any input payload image.
+
+    .. _`UEFI specification`: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
+    .. _`Dependable Boot specification`: https://git.codelinaro.org/linaro/dependable-boot/mbfw/uploads/6f7ddfe3be24e18d4319e108a758d02e/mbfw.pdf
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.required_props = ['capsule-type']
+        self.accept = 0
+        self.revert = 0
+
+    def ReadNode(self):
+        super().ReadNode()
+
+        self.image_guid = fdt_util.GetString(self._node, 'image-guid')
+        self.capsule_type = fdt_util.GetString(self._node, 'capsule-type')
+
+        if self.capsule_type != 'accept' and self.capsule_type != 'revert':
+            self.Raise('capsule-type should be either \'accept\' or \'revert\'')
+
+        if self.capsule_type == 'accept' and not self.image_guid:
+            self.Raise('Image GUID needed for generating accept capsule')
+
+    def BuildSectionData(self, required):
+        uniq = self.GetUniqueName()
+        outfile = self._filename if self._filename else 'capsule.%s' % uniq
+        capsule_fname = tools.get_output_filename(outfile)
+        accept = True if self.capsule_type == 'accept' else False
+        guid = self.image_guid
+        if self.image_guid == "binman-test":
+            guid = get_binman_test_guid('binman-test')
+
+        ret = self.mkeficapsule.generate_empty_capsule(guid, capsule_fname,
+                                                       accept)
+        if ret is not None:
+            return tools.read_file(capsule_fname)
+
+    def AddBintools(self, btools):
+        self.mkeficapsule = self.AddBintool(btools, 'mkeficapsule')
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 2ea18d2d08..16156b7410 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -126,6 +126,9 @@ FW_MGMT_GUID = '6dcbd5ed-e82d-4c44-bda1-7194199ad92a'
 CAPSULE_IMAGE_GUID = '09d7cf52-0720-4710-91d1-08469b7fe9c8'
 # Windows cert GUID
 WIN_CERT_TYPE_EFI_GUID = '4aafd29d-68df-49ee-8aa9-347d375665a7'
+# Empty capsule GUIDs
+EMPTY_CAPSULE_ACCEPT_GUID = '0c996046-bcc0-4d04-85ec-e1fcedf1c6f8'
+EMPTY_CAPSULE_REVERT_GUID = 'acd58b4b-c0e8-475f-99b5-6b3f7e07aaf0'
 
 class TestFunctional(unittest.TestCase):
     """Functional tests for binman
@@ -7293,6 +7296,27 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         self.assertEqual(payload_data_len, int(hdr['Payload Image Size']))
 
+    def _CheckEmptyCapsule(self, data, accept_capsule=False):
+        if accept_capsule:
+            capsule_hdr_guid = EMPTY_CAPSULE_ACCEPT_GUID
+        else:
+            capsule_hdr_guid = EMPTY_CAPSULE_REVERT_GUID
+
+        hdr = self._GetCapsuleHeaders(data)
+
+        self.assertEqual(capsule_hdr_guid.upper(),
+                         hdr['EFI_CAPSULE_HDR.CAPSULE_GUID'])
+
+        if accept_capsule:
+            capsule_size = "0000002C"
+        else:
+            capsule_size = "0000001C"
+        self.assertEqual(capsule_size,
+                         hdr['EFI_CAPSULE_HDR.CAPSULE_IMAGE_SIZE'])
+
+        if accept_capsule:
+            self.assertEqual(CAPSULE_IMAGE_GUID.upper(), hdr['ACCEPT_IMAGE_GUID'])
+
     def testCapsuleGen(self):
         """Test generation of EFI capsule"""
         data = self._DoReadFile('311_capsule.dts')
@@ -7357,5 +7381,38 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn("entry is missing properties: image-guid",
                       str(e.exception))
 
+    def testCapsuleGenAcceptCapsule(self):
+        """Test generationg of accept EFI capsule"""
+        data = self._DoReadFile('319_capsule_accept.dts')
+
+        self._CheckEmptyCapsule(data, accept_capsule=True)
+
+    def testCapsuleGenRevertCapsule(self):
+        """Test generationg of revert EFI capsule"""
+        data = self._DoReadFile('320_capsule_revert.dts')
+
+        self._CheckEmptyCapsule(data)
+
+    def testCapsuleGenAcceptGuidMissing(self):
+        """Test that binman errors out on missing image GUID for accept capsule"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('321_capsule_accept_missing_guid.dts')
+
+        self.assertIn("Image GUID needed for generating accept capsule",
+                      str(e.exception))
+
+    def testCapsuleGenEmptyCapsuleTypeMissing(self):
+        """Test that capsule-type is specified"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('322_empty_capsule_type_missing.dts')
+
+        self.assertIn("entry is missing properties: capsule-type",
+                      str(e.exception))
+
+    def testCapsuleGenAcceptOrRevertMissing(self):
+        """Test that both accept and revert capsule are not specified"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('323_capsule_accept_revert_missing.dts')
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/319_capsule_accept.dts b/tools/binman/test/319_capsule_accept.dts
new file mode 100644
index 0000000000..d48e59f859
--- /dev/null
+++ b/tools/binman/test/319_capsule_accept.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		efi-empty-capsule {
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+			capsule-type = "accept";
+		};
+	};
+};
diff --git a/tools/binman/test/320_capsule_revert.dts b/tools/binman/test/320_capsule_revert.dts
new file mode 100644
index 0000000000..bd141ef292
--- /dev/null
+++ b/tools/binman/test/320_capsule_revert.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		efi-empty-capsule {
+			capsule-type = "revert";
+		};
+	};
+};
diff --git a/tools/binman/test/321_capsule_accept_missing_guid.dts b/tools/binman/test/321_capsule_accept_missing_guid.dts
new file mode 100644
index 0000000000..a0088b174c
--- /dev/null
+++ b/tools/binman/test/321_capsule_accept_missing_guid.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		efi-empty-capsule {
+			capsule-type = "accept";
+		};
+	};
+};
diff --git a/tools/binman/test/322_empty_capsule_type_missing.dts b/tools/binman/test/322_empty_capsule_type_missing.dts
new file mode 100644
index 0000000000..d356168e77
--- /dev/null
+++ b/tools/binman/test/322_empty_capsule_type_missing.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		efi-empty-capsule {
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+		};
+	};
+};
diff --git a/tools/binman/test/323_capsule_accept_revert_missing.dts b/tools/binman/test/323_capsule_accept_revert_missing.dts
new file mode 100644
index 0000000000..31268b20b8
--- /dev/null
+++ b/tools/binman/test/323_capsule_accept_revert_missing.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		efi-empty-capsule {
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+			capsule-type = "foo";
+		};
+	};
+};
-- 
2.34.1

