Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51098E7B5F4
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 11:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 949C2874EB;
	Wed,  4 Oct 2023 13:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A76468722D; Wed,  4 Oct 2023 13:27:53 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 55C988722D
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 13:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 713C7DA7;
 Wed,  4 Oct 2023 04:28:27 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F7203F762;
 Wed,  4 Oct 2023 04:27:46 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 3/5] binman: capsule: Use dumped capsule header contents for
 verification
Date: Wed,  4 Oct 2023 16:57:20 +0530
Message-Id: <20231004112722.416877-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004112722.416877-1-sughosh.ganu@linaro.org>
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
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
 tools/binman/ftest.py | 95 ++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8e419645a6..2b8871ab7e 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -121,9 +121,11 @@ COMP_BINTOOLS = ['bzip2', 'gzip', 'lz4', 'lzma_alone', 'lzop', 'xz', 'zstd']
 TEE_ADDR = 0x5678
 
 # Firmware Management Protocol(FMP) GUID
-FW_MGMT_GUID = 'edd5cb6d2de8444cbda17194199ad92a'
+FW_MGMT_GUID = '6DCBD5ED-E82D-4C44-BDA1-7194199AD92A'
 # Image GUID specified in the DTS
-CAPSULE_IMAGE_GUID = '52cfd7092007104791d108469b7fe9c8'
+CAPSULE_IMAGE_GUID = '09D7CF52-0720-4710-91D1-08469B7FE9C8'
+# Windows cert GUID
+WIN_CERT_TYPE_EFI_GUID = '4AAFD29D-68DF-49EE-8AA9-347D375665A7'
 
 class TestFunctional(unittest.TestCase):
     """Functional tests for binman
@@ -7223,52 +7225,63 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertRegex(err,
                          "Image 'image'.*missing bintools.*: bootgen")
 
+    def _GetCapsuleHeaders(self, data):
+        capsule_file = os.path.join(self._indir, 'test.capsule')
+        tools.write_file(capsule_file, data)
+
+        out = tools.run('mkeficapsule', '--dump-capsule', capsule_file)
+        lines = out.splitlines()
+
+        re_line = re.compile(r'^([^:\-\t]*)(?:\t*\s*:\s*(.*))?$')
+        vals = collections.defaultdict(list)
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
 
-        payload_data = EFI_CAPSULE_DATA
+        payload_data_len = len(EFI_CAPSULE_DATA)
 
-        # TODO - Currently, these offsets for capsule fields are hardcoded.
-        # There are plans to add support to the mkeficapsule tool to dump
-        # the capsule contents which can then be used for capsule
-        # verification.
+        hdr = self._GetCapsuleHeaders(data)
 
-        # Firmware Management Protocol(FMP) GUID - offset(0 - 32)
-        self.assertEqual(FW_MGMT_GUID, data.hex()[:32])
-        # Image GUID - offset(96 - 128)
-        self.assertEqual(CAPSULE_IMAGE_GUID, data.hex()[96:128])
+        self.assertEqual(FW_MGMT_GUID, hdr['EFI_CAPSULE_HDR.CAPSULE_GUID'])
+
+        self.assertEqual(CAPSULE_IMAGE_GUID,
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
+            self.assertEqual(WIN_CERT_TYPE_EFI_GUID,
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

