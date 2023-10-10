Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1192FCD68E8
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 09:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E27186E05;
	Tue, 10 Oct 2023 11:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED8E86DA2; Tue, 10 Oct 2023 11:12:10 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5D7D786DDF
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 11:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7572CC15;
 Tue, 10 Oct 2023 02:12:47 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B26B3F762;
 Tue, 10 Oct 2023 02:12:04 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 4/6] binman: capsule: Use dumped capsule header contents
 for verification
Date: Tue, 10 Oct 2023 14:40:57 +0530
Message-Id: <20231010091059.375036-5-sughosh.ganu@linaro.org>
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

The various fields of a generated capsule are currently verified
through hard-coded offsets. Use the dump-capsule feature for dumping
the capsule header contents and use those for capsule verification.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Move the get_binman_test_guid() function outside the
  Entry_efi_capsule class so that it can be called from outside the
  module.
* Use lowercase characters in the GUID values
* Add comments for the _GetCapsuleHeaders() function.
* Use a simple dict in _GetCapsuleHeaders() for storing the capsule
  header values dumped by the mkeficapsule tool.

 tools/binman/etype/efi_capsule.py |  24 +++++--
 tools/binman/ftest.py             | 105 ++++++++++++++++++------------
 2 files changed, 82 insertions(+), 47 deletions(-)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 006eb630ad..e320371782 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -11,6 +11,24 @@ from binman.etype.section import Entry_section
 from dtoc import fdt_util
 from u_boot_pylib import tools
 
+def get_binman_test_guid(type_str):
+    """Get the test image GUID for binman
+
+    Based on the string passed to the function, return
+    the corresponding GUID.
+
+    Args:
+        type_str: Key value of the type of GUID to look for
+
+    Returns:
+        The actual GUID value (str)
+    """
+    TYPE_TO_GUID = {
+        'binman-test' : '09d7cf52-0720-4710-91d1-08469b7fe9c8'
+    }
+
+    return TYPE_TO_GUID[type_str]
+
 class Entry_efi_capsule(Entry_section):
     """Generate EFI capsules
 
@@ -104,12 +122,6 @@ class Entry_efi_capsule(Entry_section):
             self.auth = 1
 
     def BuildSectionData(self, required):
-        def get_binman_test_guid(type_str):
-            TYPE_TO_GUID = {
-                'binman-test' : '09d7cf52-0720-4710-91d1-08469b7fe9c8'
-            }
-            return TYPE_TO_GUID[type_str]
-
         private_key = ''
         public_key_cert = ''
         if self.auth:
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8e419645a6..2ea18d2d08 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -121,9 +121,11 @@ COMP_BINTOOLS = ['bzip2', 'gzip', 'lz4', 'lzma_alone', 'lzop', 'xz', 'zstd']
 TEE_ADDR = 0x5678
 
 # Firmware Management Protocol(FMP) GUID
-FW_MGMT_GUID = 'edd5cb6d2de8444cbda17194199ad92a'
+FW_MGMT_GUID = '6dcbd5ed-e82d-4c44-bda1-7194199ad92a'
 # Image GUID specified in the DTS
-CAPSULE_IMAGE_GUID = '52cfd7092007104791d108469b7fe9c8'
+CAPSULE_IMAGE_GUID = '09d7cf52-0720-4710-91d1-08469b7fe9c8'
+# Windows cert GUID
+WIN_CERT_TYPE_EFI_GUID = '4aafd29d-68df-49ee-8aa9-347d375665a7'
 
 class TestFunctional(unittest.TestCase):
     """Functional tests for binman
@@ -7223,52 +7225,73 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertRegex(err,
                          "Image 'image'.*missing bintools.*: bootgen")
 
+    def _GetCapsuleHeaders(self, data):
+        """Get the capsule header contents
+
+        Args:
+            data: Capsule file contents
+
+        Returns:
+            Dict:
+                key: Capsule Header name (str)
+                value: Header field value (str)
+        """
+        capsule_file = os.path.join(self._indir, 'test.capsule')
+        tools.write_file(capsule_file, data)
+
+        out = tools.run('mkeficapsule', '--dump-capsule', capsule_file)
+        lines = out.splitlines()
+
+        re_line = re.compile(r'^([^:\-\t]*)(?:\t*\s*:\s*(.*))?$')
+        vals = {}
+        for line in lines:
+            mat = re_line.match(line)
+            if mat:
+                vals[mat.group(1)] = mat.group(2)
+
+        return vals
+
     def _CheckCapsule(self, data, signed_capsule=False, version_check=False,
                       capoemflags=False):
-        fmp_signature = "4d535331" # 'M', 'S', 'S', '1'
-        fmp_size = "10"
-        fmp_fw_version = "02"
-        oemflag = "0080"
+        fmp_signature = "3153534D" # 'M', 'S', 'S', '1'
+        fmp_size = "00000010"
+        fmp_fw_version = "00000002"
+        capsule_image_index = "00000001"
+        oemflag = "00018000"
+        auth_hdr_revision = "00000200"
+        auth_hdr_cert_type = "00000EF1"
+
+        payload_data_len = len(EFI_CAPSULE_DATA)
 
-        payload_data = EFI_CAPSULE_DATA
+        hdr = self._GetCapsuleHeaders(data)
 
-        # TODO - Currently, these offsets for capsule fields are hardcoded.
-        # There are plans to add support to the mkeficapsule tool to dump
-        # the capsule contents which can then be used for capsule
-        # verification.
+        self.assertEqual(FW_MGMT_GUID.upper(), hdr['EFI_CAPSULE_HDR.CAPSULE_GUID'])
 
-        # Firmware Management Protocol(FMP) GUID - offset(0 - 32)
-        self.assertEqual(FW_MGMT_GUID, data.hex()[:32])
-        # Image GUID - offset(96 - 128)
-        self.assertEqual(CAPSULE_IMAGE_GUID, data.hex()[96:128])
+        self.assertEqual(CAPSULE_IMAGE_GUID.upper(),
+                         hdr['FMP_CAPSULE_IMAGE_HDR.UPDATE_IMAGE_TYPE_ID'])
+        self.assertEqual(capsule_image_index,
+                         hdr['FMP_CAPSULE_IMAGE_HDR.UPDATE_IMAGE_INDEX'])
 
         if capoemflags:
-            # OEM Flags - offset(40 - 44)
-            self.assertEqual(oemflag, data.hex()[40:44])
-        if signed_capsule and version_check:
-            # FMP header signature - offset(4770 - 4778)
-            self.assertEqual(fmp_signature, data.hex()[4770:4778])
-            # FMP header size - offset(4778 - 4780)
-            self.assertEqual(fmp_size, data.hex()[4778:4780])
-            # firmware version - offset(4786 - 4788)
-            self.assertEqual(fmp_fw_version, data.hex()[4786:4788])
-            # payload offset signed capsule(4802 - 4808)
-            self.assertEqual(payload_data.hex(), data.hex()[4802:4808])
-        elif signed_capsule:
-            # payload offset signed capsule(4770 - 4776)
-            self.assertEqual(payload_data.hex(), data.hex()[4770:4776])
-        elif version_check:
-            # FMP header signature - offset(184 - 192)
-            self.assertEqual(fmp_signature, data.hex()[184:192])
-            # FMP header size - offset(192 - 194)
-            self.assertEqual(fmp_size, data.hex()[192:194])
-            # firmware version - offset(200 - 202)
-            self.assertEqual(fmp_fw_version, data.hex()[200:202])
-            # payload offset for non-signed capsule with version header(216 - 222)
-            self.assertEqual(payload_data.hex(), data.hex()[216:222])
-        else:
-            # payload offset for non-signed capsule with no version header(184 - 190)
-            self.assertEqual(payload_data.hex(), data.hex()[184:190])
+            self.assertEqual(oemflag, hdr['EFI_CAPSULE_HDR.FLAGS'])
+
+        if signed_capsule:
+            self.assertEqual(auth_hdr_revision,
+                             hdr['EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.wREVISION'])
+            self.assertEqual(auth_hdr_cert_type,
+                             hdr['EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.wCERTTYPE'])
+            self.assertEqual(WIN_CERT_TYPE_EFI_GUID.upper(),
+                             hdr['EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.CERT_TYPE'])
+
+        if version_check:
+            self.assertEqual(fmp_signature,
+                             hdr['FMP_PAYLOAD_HDR.SIGNATURE'])
+            self.assertEqual(fmp_size,
+                             hdr['FMP_PAYLOAD_HDR.HEADER_SIZE'])
+            self.assertEqual(fmp_fw_version,
+                             hdr['FMP_PAYLOAD_HDR.FW_VERSION'])
+
+        self.assertEqual(payload_data_len, int(hdr['Payload Image Size']))
 
     def testCapsuleGen(self):
         """Test generation of EFI capsule"""
-- 
2.34.1

