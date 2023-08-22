Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34FAEE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 17:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 219F7864C9;
	Tue, 22 Aug 2023 19:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56213864CA; Tue, 22 Aug 2023 19:40:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AF0DC864B3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 19:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 154D61424;
 Tue, 22 Aug 2023 10:41:32 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B71333F762;
 Tue, 22 Aug 2023 10:40:48 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v11 06/15] binman: capsule: Add support for generating EFI
 capsules
Date: Tue, 22 Aug 2023 23:09:59 +0530
Message-Id: <20230822174008.626239-7-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822174008.626239-1-sughosh.ganu@linaro.org>
References: <20230822174008.626239-1-sughosh.ganu@linaro.org>
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

Add support in binman for generating EFI capsules. The capsule
parameters can be specified through the capsule binman entry. Also add
test cases in binman for testing capsule generation.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V10: None

 tools/binman/entries.rst                      |  64 ++++++++
 tools/binman/etype/efi_capsule.py             | 143 ++++++++++++++++++
 tools/binman/ftest.py                         | 118 +++++++++++++++
 tools/binman/test/311_capsule.dts             |  21 +++
 tools/binman/test/312_capsule_signed.dts      |  23 +++
 tools/binman/test/313_capsule_version.dts     |  22 +++
 tools/binman/test/314_capsule_signed_ver.dts  |  24 +++
 tools/binman/test/315_capsule_oemflags.dts    |  22 +++
 tools/binman/test/316_capsule_missing_key.dts |  22 +++
 .../binman/test/317_capsule_missing_index.dts |  20 +++
 .../binman/test/318_capsule_missing_guid.dts  |  19 +++
 11 files changed, 498 insertions(+)
 create mode 100644 tools/binman/etype/efi_capsule.py
 create mode 100644 tools/binman/test/311_capsule.dts
 create mode 100644 tools/binman/test/312_capsule_signed.dts
 create mode 100644 tools/binman/test/313_capsule_version.dts
 create mode 100644 tools/binman/test/314_capsule_signed_ver.dts
 create mode 100644 tools/binman/test/315_capsule_oemflags.dts
 create mode 100644 tools/binman/test/316_capsule_missing_key.dts
 create mode 100644 tools/binman/test/317_capsule_missing_index.dts
 create mode 100644 tools/binman/test/318_capsule_missing_guid.dts

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index e7dfe6b2a3..801bd94674 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -468,6 +468,70 @@ updating the EC on startup via software sync.
 
 
 
+.. _etype_efi_capsule:
+
+Entry: capsule: Entry for generating EFI Capsule files
+------------------------------------------------------
+
+The parameters needed for generation of the capsules can be provided
+as properties in the entry.
+
+Properties / Entry arguments:
+    - image-index: Unique number for identifying corresponding
+      payload image. Number between 1 and descriptor count, i.e.
+      the total number of firmware images that can be updated. Mandatory
+      property.
+    - image-guid: Image GUID which will be used for identifying the
+      updatable image on the board. Mandatory property.
+    - hardware-instance: Optional number for identifying unique
+      hardware instance of a device in the system. Default value of 0
+      for images where value is not to be used.
+    - fw-version: Value of image version that can be put on the capsule
+      through the Firmware Management Protocol(FMP) header.
+    - monotonic-count: Count used when signing an image.
+    - private-key: Path to PEM formatted .key private key file. Mandatory
+      property for generating signed capsules.
+    - public-key-cert: Path to PEM formatted .crt public key certificate
+      file. Mandatory property for generating signed capsules.
+    - oem-flags - OEM flags to be passed through capsule header.
+
+    Since this is a subclass of Entry_section, all properties of the parent
+    class also apply here. Except for the properties stated as mandatory, the
+    rest of the properties are optional.
+
+For more details on the description of the capsule format, and the capsule
+update functionality, refer Section 8.5 and Chapter 23 in the `UEFI
+specification`_.
+
+The capsule parameters like image index and image GUID are passed as
+properties in the entry. The payload to be used in the capsule is to be
+provided as a subnode of the capsule entry.
+
+A typical capsule entry node would then look something like this::
+
+    capsule {
+            type = "efi-capsule";
+            image-index = <0x1>;
+            /* Image GUID for testing capsule update */
+            image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+            hardware-instance = <0x0>;
+            private-key = "path/to/the/private/key";
+            public-key-cert = "path/to/the/public-key-cert";
+            oem-flags = <0x8000>;
+
+            u-boot {
+            };
+    };
+
+In the above example, the capsule payload is the U-Boot image. The
+capsule entry would read the contents of the payload and put them
+into the capsule. Any external file can also be specified as the
+payload using the blob-ext subnode.
+
+.. _`UEFI specification`: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
+
+
+
 .. _etype_encrypted:
 
 Entry: encrypted: Externally built encrypted binary blob
diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
new file mode 100644
index 0000000000..006eb630ad
--- /dev/null
+++ b/tools/binman/etype/efi_capsule.py
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2023 Linaro Limited
+#
+# Entry-type module for producing a EFI capsule
+#
+
+import os
+
+from binman.entry import Entry
+from binman.etype.section import Entry_section
+from dtoc import fdt_util
+from u_boot_pylib import tools
+
+class Entry_efi_capsule(Entry_section):
+    """Generate EFI capsules
+
+    The parameters needed for generation of the capsules can
+    be provided as properties in the entry.
+
+    Properties / Entry arguments:
+    - image-index: Unique number for identifying corresponding
+      payload image. Number between 1 and descriptor count, i.e.
+      the total number of firmware images that can be updated. Mandatory
+      property.
+    - image-guid: Image GUID which will be used for identifying the
+      updatable image on the board. Mandatory property.
+    - hardware-instance: Optional number for identifying unique
+      hardware instance of a device in the system. Default value of 0
+      for images where value is not to be used.
+    - fw-version: Value of image version that can be put on the capsule
+      through the Firmware Management Protocol(FMP) header.
+    - monotonic-count: Count used when signing an image.
+    - private-key: Path to PEM formatted .key private key file. Mandatory
+      property for generating signed capsules.
+    - public-key-cert: Path to PEM formatted .crt public key certificate
+      file. Mandatory property for generating signed capsules.
+    - oem-flags - OEM flags to be passed through capsule header.
+
+    Since this is a subclass of Entry_section, all properties of the parent
+    class also apply here. Except for the properties stated as mandatory, the
+    rest of the properties are optional.
+
+    For more details on the description of the capsule format, and the capsule
+    update functionality, refer Section 8.5 and Chapter 23 in the `UEFI
+    specification`_.
+
+    The capsule parameters like image index and image GUID are passed as
+    properties in the entry. The payload to be used in the capsule is to be
+    provided as a subnode of the capsule entry.
+
+    A typical capsule entry node would then look something like this
+
+    capsule {
+            type = "efi-capsule";
+            image-index = <0x1>;
+            /* Image GUID for testing capsule update */
+            image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+            hardware-instance = <0x0>;
+            private-key = "path/to/the/private/key";
+            public-key-cert = "path/to/the/public-key-cert";
+            oem-flags = <0x8000>;
+
+            u-boot {
+            };
+    };
+
+    In the above example, the capsule payload is the U-Boot image. The
+    capsule entry would read the contents of the payload and put them
+    into the capsule. Any external file can also be specified as the
+    payload using the blob-ext subnode.
+
+    .. _`UEFI specification`: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.required_props = ['image-index', 'image-guid']
+        self.image_index = 0
+        self.image_guid = ''
+        self.hardware_instance = 0
+        self.monotonic_count = 0
+        self.fw_version = 0
+        self.oem_flags = 0
+        self.private_key = ''
+        self.public_key_cert = ''
+        self.auth = 0
+
+    def ReadNode(self):
+        super().ReadNode()
+
+        self.image_index = fdt_util.GetInt(self._node, 'image-index')
+        self.image_guid = fdt_util.GetString(self._node, 'image-guid')
+        self.fw_version = fdt_util.GetInt(self._node, 'fw-version')
+        self.hardware_instance = fdt_util.GetInt(self._node, 'hardware-instance')
+        self.monotonic_count = fdt_util.GetInt(self._node, 'monotonic-count')
+        self.oem_flags = fdt_util.GetInt(self._node, 'oem-flags')
+
+        self.private_key = fdt_util.GetString(self._node, 'private-key')
+        self.public_key_cert = fdt_util.GetString(self._node, 'public-key-cert')
+        if ((self.private_key and not self.public_key_cert) or (self.public_key_cert and not self.private_key)):
+            self.Raise('Both private key and public key certificate need to be provided')
+        elif not (self.private_key and self.public_key_cert):
+            self.auth = 0
+        else:
+            self.auth = 1
+
+    def BuildSectionData(self, required):
+        def get_binman_test_guid(type_str):
+            TYPE_TO_GUID = {
+                'binman-test' : '09d7cf52-0720-4710-91d1-08469b7fe9c8'
+            }
+            return TYPE_TO_GUID[type_str]
+
+        private_key = ''
+        public_key_cert = ''
+        if self.auth:
+            if not os.path.isabs(self.private_key):
+                private_key =  tools.get_input_filename(self.private_key)
+            if not os.path.isabs(self.public_key_cert):
+                public_key_cert = tools.get_input_filename(self.public_key_cert)
+        data, payload, uniq = self.collect_contents_to_file(
+            self._entries.values(), 'capsule_in')
+        outfile = self._filename if self._filename else 'capsule.%s' % uniq
+        capsule_fname = tools.get_output_filename(outfile)
+        guid = self.image_guid
+        if self.image_guid == "binman-test":
+            guid = get_binman_test_guid('binman-test')
+
+        ret = self.mkeficapsule.generate_capsule(self.image_index,
+                                                 guid,
+                                                 self.hardware_instance,
+                                                 payload,
+                                                 capsule_fname,
+                                                 private_key,
+                                                 public_key_cert,
+                                                 self.monotonic_count,
+                                                 self.fw_version,
+                                                 self.oem_flags)
+        if ret is not None:
+            os.remove(payload)
+            return tools.read_file(capsule_fname)
+
+    def AddBintools(self, btools):
+        self.mkeficapsule = self.AddBintool(btools, 'mkeficapsule')
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 1293e9dbf4..8e419645a6 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -48,6 +48,7 @@ U_BOOT_VPL_DATA       = b'vpl76543210fedcbazywxyz_'
 BLOB_DATA             = b'89'
 ME_DATA               = b'0abcd'
 VGA_DATA              = b'vga'
+EFI_CAPSULE_DATA      = b'efi'
 U_BOOT_DTB_DATA       = b'udtb'
 U_BOOT_SPL_DTB_DATA   = b'spldtb'
 U_BOOT_TPL_DTB_DATA   = b'tpldtb'
@@ -119,6 +120,11 @@ COMP_BINTOOLS = ['bzip2', 'gzip', 'lz4', 'lzma_alone', 'lzop', 'xz', 'zstd']
 
 TEE_ADDR = 0x5678
 
+# Firmware Management Protocol(FMP) GUID
+FW_MGMT_GUID = 'edd5cb6d2de8444cbda17194199ad92a'
+# Image GUID specified in the DTS
+CAPSULE_IMAGE_GUID = '52cfd7092007104791d108469b7fe9c8'
+
 class TestFunctional(unittest.TestCase):
     """Functional tests for binman
 
@@ -215,6 +221,7 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('scp.bin', SCP_DATA)
         TestFunctional._MakeInputFile('rockchip-tpl.bin', ROCKCHIP_TPL_DATA)
         TestFunctional._MakeInputFile('ti_unsecure.bin', TI_UNSECURE_DATA)
+        TestFunctional._MakeInputFile('capsule_input.bin', EFI_CAPSULE_DATA)
 
         # Add a few .dtb files for testing
         TestFunctional._MakeInputFile('%s/test-fdt1.dtb' % TEST_FDT_SUBDIR,
@@ -7216,5 +7223,116 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertRegex(err,
                          "Image 'image'.*missing bintools.*: bootgen")
 
+    def _CheckCapsule(self, data, signed_capsule=False, version_check=False,
+                      capoemflags=False):
+        fmp_signature = "4d535331" # 'M', 'S', 'S', '1'
+        fmp_size = "10"
+        fmp_fw_version = "02"
+        oemflag = "0080"
+
+        payload_data = EFI_CAPSULE_DATA
+
+        # TODO - Currently, these offsets for capsule fields are hardcoded.
+        # There are plans to add support to the mkeficapsule tool to dump
+        # the capsule contents which can then be used for capsule
+        # verification.
+
+        # Firmware Management Protocol(FMP) GUID - offset(0 - 32)
+        self.assertEqual(FW_MGMT_GUID, data.hex()[:32])
+        # Image GUID - offset(96 - 128)
+        self.assertEqual(CAPSULE_IMAGE_GUID, data.hex()[96:128])
+
+        if capoemflags:
+            # OEM Flags - offset(40 - 44)
+            self.assertEqual(oemflag, data.hex()[40:44])
+        if signed_capsule and version_check:
+            # FMP header signature - offset(4770 - 4778)
+            self.assertEqual(fmp_signature, data.hex()[4770:4778])
+            # FMP header size - offset(4778 - 4780)
+            self.assertEqual(fmp_size, data.hex()[4778:4780])
+            # firmware version - offset(4786 - 4788)
+            self.assertEqual(fmp_fw_version, data.hex()[4786:4788])
+            # payload offset signed capsule(4802 - 4808)
+            self.assertEqual(payload_data.hex(), data.hex()[4802:4808])
+        elif signed_capsule:
+            # payload offset signed capsule(4770 - 4776)
+            self.assertEqual(payload_data.hex(), data.hex()[4770:4776])
+        elif version_check:
+            # FMP header signature - offset(184 - 192)
+            self.assertEqual(fmp_signature, data.hex()[184:192])
+            # FMP header size - offset(192 - 194)
+            self.assertEqual(fmp_size, data.hex()[192:194])
+            # firmware version - offset(200 - 202)
+            self.assertEqual(fmp_fw_version, data.hex()[200:202])
+            # payload offset for non-signed capsule with version header(216 - 222)
+            self.assertEqual(payload_data.hex(), data.hex()[216:222])
+        else:
+            # payload offset for non-signed capsule with no version header(184 - 190)
+            self.assertEqual(payload_data.hex(), data.hex()[184:190])
+
+    def testCapsuleGen(self):
+        """Test generation of EFI capsule"""
+        data = self._DoReadFile('311_capsule.dts')
+
+        self._CheckCapsule(data)
+
+    def testSignedCapsuleGen(self):
+        """Test generation of EFI capsule"""
+        data = tools.read_file(self.TestFile("key.key"))
+        self._MakeInputFile("key.key", data)
+        data = tools.read_file(self.TestFile("key.pem"))
+        self._MakeInputFile("key.crt", data)
+
+        data = self._DoReadFile('312_capsule_signed.dts')
+
+        self._CheckCapsule(data, signed_capsule=True)
+
+    def testCapsuleGenVersionSupport(self):
+        """Test generation of EFI capsule with version support"""
+        data = self._DoReadFile('313_capsule_version.dts')
+
+        self._CheckCapsule(data, version_check=True)
+
+    def testCapsuleGenSignedVer(self):
+        """Test generation of signed EFI capsule with version information"""
+        data = tools.read_file(self.TestFile("key.key"))
+        self._MakeInputFile("key.key", data)
+        data = tools.read_file(self.TestFile("key.pem"))
+        self._MakeInputFile("key.crt", data)
+
+        data = self._DoReadFile('314_capsule_signed_ver.dts')
+
+        self._CheckCapsule(data, signed_capsule=True, version_check=True)
+
+    def testCapsuleGenCapOemFlags(self):
+        """Test generation of EFI capsule with OEM Flags set"""
+        data = self._DoReadFile('315_capsule_oemflags.dts')
+
+        self._CheckCapsule(data, capoemflags=True)
+
+    def testCapsuleGenKeyMissing(self):
+        """Test that binman errors out on missing key"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('316_capsule_missing_key.dts')
+
+        self.assertIn("Both private key and public key certificate need to be provided",
+                      str(e.exception))
+
+    def testCapsuleGenIndexMissing(self):
+        """Test that binman errors out on missing image index"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('317_capsule_missing_index.dts')
+
+        self.assertIn("entry is missing properties: image-index",
+                      str(e.exception))
+
+    def testCapsuleGenGuidMissing(self):
+        """Test that binman errors out on missing image GUID"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('318_capsule_missing_guid.dts')
+
+        self.assertIn("entry is missing properties: image-guid",
+                      str(e.exception))
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/311_capsule.dts b/tools/binman/test/311_capsule.dts
new file mode 100644
index 0000000000..8eb4250b14
--- /dev/null
+++ b/tools/binman/test/311_capsule.dts
@@ -0,0 +1,21 @@
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
+			image-index = <0x1>;
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+			hardware-instance = <0x0>;
+
+			blob {
+				filename = "capsule_input.bin";
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/312_capsule_signed.dts b/tools/binman/test/312_capsule_signed.dts
new file mode 100644
index 0000000000..d1c76e269c
--- /dev/null
+++ b/tools/binman/test/312_capsule_signed.dts
@@ -0,0 +1,23 @@
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
+			image-index = <0x1>;
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+			hardware-instance = <0x0>;
+			private-key = "key.key";
+			public-key-cert = "key.crt";
+
+			blob {
+				filename = "capsule_input.bin";
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/313_capsule_version.dts b/tools/binman/test/313_capsule_version.dts
new file mode 100644
index 0000000000..bafef3609e
--- /dev/null
+++ b/tools/binman/test/313_capsule_version.dts
@@ -0,0 +1,22 @@
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
+			image-index = <0x1>;
+			fw-version = <0x2>;
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+			hardware-instance = <0x0>;
+
+			blob {
+				filename = "capsule_input.bin";
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/314_capsule_signed_ver.dts b/tools/binman/test/314_capsule_signed_ver.dts
new file mode 100644
index 0000000000..85c784bba4
--- /dev/null
+++ b/tools/binman/test/314_capsule_signed_ver.dts
@@ -0,0 +1,24 @@
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
+			image-index = <0x1>;
+			fw-version = <0x2>;
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+			hardware-instance = <0x0>;
+			private-key = "key.key";
+			public-key-cert = "key.crt";
+
+			blob {
+				filename = "capsule_input.bin";
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/315_capsule_oemflags.dts b/tools/binman/test/315_capsule_oemflags.dts
new file mode 100644
index 0000000000..f736e8758f
--- /dev/null
+++ b/tools/binman/test/315_capsule_oemflags.dts
@@ -0,0 +1,22 @@
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
+			image-index = <0x1>;
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+			hardware-instance = <0x0>;
+			oem-flags = <0x8000>;
+
+			blob {
+				filename = "capsule_input.bin";
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/316_capsule_missing_key.dts b/tools/binman/test/316_capsule_missing_key.dts
new file mode 100644
index 0000000000..2080b50e3d
--- /dev/null
+++ b/tools/binman/test/316_capsule_missing_key.dts
@@ -0,0 +1,22 @@
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
+			image-index = <0x1>;
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+			hardware-instance = <0x0>;
+			private-key = "tools/binman/test/key.key";
+
+			blob {
+				filename = "capsule_input.bin";
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/317_capsule_missing_index.dts b/tools/binman/test/317_capsule_missing_index.dts
new file mode 100644
index 0000000000..aadb61f647
--- /dev/null
+++ b/tools/binman/test/317_capsule_missing_index.dts
@@ -0,0 +1,20 @@
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
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+			hardware-instance = <0x0>;
+
+			blob {
+				filename = "capsule_input.bin";
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/318_capsule_missing_guid.dts b/tools/binman/test/318_capsule_missing_guid.dts
new file mode 100644
index 0000000000..d76afba853
--- /dev/null
+++ b/tools/binman/test/318_capsule_missing_guid.dts
@@ -0,0 +1,19 @@
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
+			image-index = <0x1>;
+			hardware-instance = <0x0>;
+
+			blob {
+				filename = "capsule_input.bin";
+			};
+		};
+	};
+};
-- 
2.34.1

