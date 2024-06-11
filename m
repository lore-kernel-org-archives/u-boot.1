Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6DEC27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA898874A;
	Tue, 11 Jun 2024 23:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="GP43TVo9";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y+R/ePE3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C3A7887A1; Tue, 11 Jun 2024 23:04:21 +0200 (CEST)
Received: from wfhigh4-smtp.messagingengine.com
 (wfhigh4-smtp.messagingengine.com [64.147.123.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 865B58839F
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.west.internal (Postfix) with ESMTP id 82DE518000AB;
 Tue, 11 Jun 2024 17:04:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 11 Jun 2024 17:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139856;
 x=1718226256; bh=+iIs7Pg1PyiXdlkGiEBcAh8229tt57jdxiwZbO87cGo=; b=
 GP43TVo9FaYjo4bXXFGHm4Sz5E+cdBe6VTO+B6v7xM4TUNSbKIypJ75fHLQELFtw
 U78cFHsc3ZyQoxwffPR0wGWYtHGcY3QnIorjI1Q6H0eBYhsIkWRcLiPc5Kx72g/Q
 4Cg9LGmLfnaoD5oncGXeDvVw124aqpF3cZZvJKkdkWIYAXG6QWAWDKN+rQJd+prB
 4CxVX2pgTVW7F+Mm64c1lMt1F5eSLnwg/KdcxmT2sI8FvI6AIIztp1TWPfXRAxfn
 FscZFmvVcAxpCK7Wzo5BD1hkz2gNRivb6zrC6Ankcuox67tWbQJ+N6g6XqFJ4asy
 GyEkz1TLW1/itApfcK1nYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139856; x=
 1718226256; bh=+iIs7Pg1PyiXdlkGiEBcAh8229tt57jdxiwZbO87cGo=; b=Y
 +R/ePE34ZPoFQ8H5ZLePDCKeHEiLmBgRoB2MgLVO2e3ZWnlOrzxuxEt2yCAqaiog
 CrKCI1MTkHeD2bLE3sNVT9fPdHmSc4gYeAQjXt1DiPenQ8X2DA6i+dlRxy0mefrd
 E8aNFim9qfDUOCBx1UMIp7OO5NYyfjD/3qV7b+DM+3jz7XNHVkBmptlgEiTWh2Mx
 HDyC6vNbo8ub1cW/5u1hN5OWDbY/l3HhSpr9vbNuTfwzL9p/Q+k01AVaAgLT/9Ao
 LfbTzX43VcG0i+qDEJcVL/9r+MU9EAsgOUVJG94vRj+jm18VJuWYL5L/PvU3PH6e
 7kTIdTn27+2SctBXjEEUQ==
X-ME-Sender: <xms:z7toZgWcuHx2V_s1csMpLbrsISMwPMsJNayauwb8QbpsE1bGDL2bIw>
 <xme:z7toZkkIWWlc9bFKbyRHJl7STes-k8qM4zB6iexOVDWl6ZLIEjvL9vW3XUPnrMGBm
 b_T0JQtY1ud-EjfJy0>
X-ME-Received: <xmr:z7toZkZ1BsEitIJm11G7s00-ZVMBXpntJomsqnrf8AM6avsOS46A4oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpeehhfekkefhuedvieeikeegleeiteekuefgheeviedugfeh
 keetfeeluefhkefhgeenucffohhmrghinhepthihphgvrdhinhhtpdgpsghorghrughsrd
 gsuhhilhgupdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hm
X-ME-Proxy: <xmx:z7toZvU-iBIKUxuzSUwOLN_QlXL7bQGAxoy3rZggIO1dMAtAWJpkqw>
 <xmx:0LtoZqmwsggww_Ypo19ewPTYWiJ9WtYh3vOMfL1IpyZzUqrNxc3Lzg>
 <xmx:0LtoZkeqfymGDvnAkq5R-7bK0eTXbNG2VPB0ywgeNrDLXuJ8tq_Kgg>
 <xmx:0LtoZsHbaFxqnY8k7eoijbkV3D5h8Lo4bl30kbfLOEziVfAj6kk44Q>
 <xmx:0LtoZk479arWl76nPKVmCEgqK6wohbG5jAwGGD973gWYALSV-u9lsCzF>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:14 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:00 +0100
Subject: [PATCH 01/20] py: Replace deprecated unittest APIs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-1-51472eb70357@flygoat.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
In-Reply-To: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21938;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=/84OKy6LLDXqFA/D7sv1Hfr/ekGnG8eyKFQRaMLff8M=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3Wev6+5XfaLV+sy2sOWHzf01a6rPH+baramzvzHlR
 6jRmh13O0pZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiP8sY/nBuLzhXEhD+dtma
 BXJMBbmZGpp7FHldZ6xuXbG25hB31SeG/zlrVec7PlX1Nrv6UWY9k1hd4/ab9mtP9Kft6nFyNCu
 V4gAA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

assertEquals -> assertEqual
assertRegexpMatches -> assertRegex

Those APIs were deprecated long ago and being removed
in latest python.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tools/binman/entry_test.py  |  6 ++--
 tools/binman/fdt_test.py    | 48 ++++++++++++++---------------
 tools/binman/ftest.py       | 42 ++++++++++++-------------
 tools/buildman/func_test.py | 74 ++++++++++++++++++++++-----------------------
 tools/buildman/test.py      |  2 +-
 5 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/tools/binman/entry_test.py b/tools/binman/entry_test.py
index ac6582cf86a8..40d74d401a20 100644
--- a/tools/binman/entry_test.py
+++ b/tools/binman/entry_test.py
@@ -103,7 +103,7 @@ class TestEntry(unittest.TestCase):
         ent = entry.Entry.Create(None, self.GetNode(), 'missing',
                                  missing_etype=True)
         self.assertTrue(isinstance(ent, Entry_blob))
-        self.assertEquals('missing', ent.etype)
+        self.assertEqual('missing', ent.etype)
 
     def testDecompressData(self):
         """Test the DecompressData() method of the base class"""
@@ -111,8 +111,8 @@ class TestEntry(unittest.TestCase):
         base.compress = 'lz4'
         bintools = {}
         base.comp_bintool = base.AddBintool(bintools, '_testing')
-        self.assertEquals(tools.get_bytes(0, 1024), base.CompressData(b'abc'))
-        self.assertEquals(tools.get_bytes(0, 1024), base.DecompressData(b'abc'))
+        self.assertEqual(tools.get_bytes(0, 1024), base.CompressData(b'abc'))
+        self.assertEqual(tools.get_bytes(0, 1024), base.DecompressData(b'abc'))
 
     def testLookupOffset(self):
         """Test the lookup_offset() method of the base class"""
diff --git a/tools/binman/fdt_test.py b/tools/binman/fdt_test.py
index 7ef872954630..564c17708207 100644
--- a/tools/binman/fdt_test.py
+++ b/tools/binman/fdt_test.py
@@ -44,43 +44,43 @@ class TestFdt(unittest.TestCase):
         fname = self.GetCompiled('045_prop_test.dts')
         dt = FdtScan(fname)
         node = dt.GetNode('/binman/intel-me')
-        self.assertEquals('intel-me', node.name)
+        self.assertEqual('intel-me', node.name)
         val = fdt_util.GetString(node, 'filename')
-        self.assertEquals(str, type(val))
-        self.assertEquals('me.bin', val)
+        self.assertEqual(str, type(val))
+        self.assertEqual('me.bin', val)
 
         prop = node.props['intval']
-        self.assertEquals(fdt.Type.INT, prop.type)
-        self.assertEquals(3, fdt_util.GetInt(node, 'intval'))
+        self.assertEqual(fdt.Type.INT, prop.type)
+        self.assertEqual(3, fdt_util.GetInt(node, 'intval'))
 
         prop = node.props['intarray']
-        self.assertEquals(fdt.Type.INT, prop.type)
-        self.assertEquals(list, type(prop.value))
-        self.assertEquals(2, len(prop.value))
-        self.assertEquals([5, 6],
+        self.assertEqual(fdt.Type.INT, prop.type)
+        self.assertEqual(list, type(prop.value))
+        self.assertEqual(2, len(prop.value))
+        self.assertEqual([5, 6],
                           [fdt_util.fdt32_to_cpu(val) for val in prop.value])
 
         prop = node.props['byteval']
-        self.assertEquals(fdt.Type.BYTE, prop.type)
-        self.assertEquals(chr(8), prop.value)
+        self.assertEqual(fdt.Type.BYTE, prop.type)
+        self.assertEqual(chr(8), prop.value)
 
         prop = node.props['bytearray']
-        self.assertEquals(fdt.Type.BYTE, prop.type)
-        self.assertEquals(list, type(prop.value))
-        self.assertEquals(str, type(prop.value[0]))
-        self.assertEquals(3, len(prop.value))
-        self.assertEquals([chr(1), '#', '4'], prop.value)
+        self.assertEqual(fdt.Type.BYTE, prop.type)
+        self.assertEqual(list, type(prop.value))
+        self.assertEqual(str, type(prop.value[0]))
+        self.assertEqual(3, len(prop.value))
+        self.assertEqual([chr(1), '#', '4'], prop.value)
 
         prop = node.props['longbytearray']
-        self.assertEquals(fdt.Type.INT, prop.type)
-        self.assertEquals(0x090a0b0c, fdt_util.GetInt(node, 'longbytearray'))
+        self.assertEqual(fdt.Type.INT, prop.type)
+        self.assertEqual(0x090a0b0c, fdt_util.GetInt(node, 'longbytearray'))
 
         prop = node.props['stringval']
-        self.assertEquals(fdt.Type.STRING, prop.type)
-        self.assertEquals('message2', fdt_util.GetString(node, 'stringval'))
+        self.assertEqual(fdt.Type.STRING, prop.type)
+        self.assertEqual('message2', fdt_util.GetString(node, 'stringval'))
 
         prop = node.props['stringarray']
-        self.assertEquals(fdt.Type.STRING, prop.type)
-        self.assertEquals(list, type(prop.value))
-        self.assertEquals(3, len(prop.value))
-        self.assertEquals(['another', 'multi-word', 'message'], prop.value)
+        self.assertEqual(fdt.Type.STRING, prop.type)
+        self.assertEqual(list, type(prop.value))
+        self.assertEqual(3, len(prop.value))
+        self.assertEqual(['another', 'multi-word', 'message'], prop.value)
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8a44bc051b36..567849bbab0f 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -2095,7 +2095,7 @@ class TestFunctional(unittest.TestCase):
         dtb.Scan()
         props = self._GetPropTree(dtb, ['size', 'uncomp-size'])
         orig = self._decompress(data)
-        self.assertEquals(COMPRESS_DATA, orig)
+        self.assertEqual(COMPRESS_DATA, orig)
 
         # Do a sanity check on various fields
         image = control.images['image']
@@ -2809,9 +2809,9 @@ class TestFunctional(unittest.TestCase):
 
         orig_entry = orig_image.GetEntries()['fdtmap']
         entry = image.GetEntries()['fdtmap']
-        self.assertEquals(orig_entry.offset, entry.offset)
-        self.assertEquals(orig_entry.size, entry.size)
-        self.assertEquals(orig_entry.image_pos, entry.image_pos)
+        self.assertEqual(orig_entry.offset, entry.offset)
+        self.assertEqual(orig_entry.size, entry.size)
+        self.assertEqual(orig_entry.image_pos, entry.image_pos)
 
     def testReadImageNoHeader(self):
         """Test accessing an image's FDT map without an image header"""
@@ -3895,7 +3895,7 @@ class TestFunctional(unittest.TestCase):
             mat = re_line.match(line)
             vals[mat.group(1)].append(mat.group(2))
 
-        self.assertEquals('FIT description: test-desc', lines[0])
+        self.assertEqual('FIT description: test-desc', lines[0])
         self.assertIn('Created:', lines[1])
         self.assertIn('Image 0 (kernel)', vals)
         self.assertIn('Hash value', vals)
@@ -4012,7 +4012,7 @@ class TestFunctional(unittest.TestCase):
             fit_pos,
             fdt_util.fdt32_to_cpu(fnode.props['data-position'].value))
 
-        self.assertEquals(expected_size, len(data))
+        self.assertEqual(expected_size, len(data))
         actual_pos = len(U_BOOT_DATA) + fit_pos
         self.assertEqual(U_BOOT_DATA + b'aa',
                          data[actual_pos:actual_pos + external_data_size])
@@ -4431,7 +4431,7 @@ class TestFunctional(unittest.TestCase):
         props = self._GetPropTree(dtb, ['offset', 'image-pos', 'size',
                                         'uncomp-size'])
         orig = self._decompress(data)
-        self.assertEquals(COMPRESS_DATA + U_BOOT_DATA, orig)
+        self.assertEqual(COMPRESS_DATA + U_BOOT_DATA, orig)
 
         # Do a sanity check on various fields
         image = control.images['image']
@@ -4475,7 +4475,7 @@ class TestFunctional(unittest.TestCase):
                                         'uncomp-size'])
         orig = self._decompress(data)
 
-        self.assertEquals(COMPRESS_DATA + COMPRESS_DATA + U_BOOT_DATA, orig)
+        self.assertEqual(COMPRESS_DATA + COMPRESS_DATA + U_BOOT_DATA, orig)
 
         # Do a sanity check on various fields
         image = control.images['image']
@@ -4519,7 +4519,7 @@ class TestFunctional(unittest.TestCase):
         props = self._GetPropTree(dtb, ['offset', 'image-pos', 'size',
                                         'uncomp-size'])
         orig = self._decompress(data)
-        self.assertEquals(COMPRESS_DATA + U_BOOT_DATA, orig)
+        self.assertEqual(COMPRESS_DATA + U_BOOT_DATA, orig)
         expected = {
             'section/blob:offset': 0,
             'section/blob:size': len(COMPRESS_DATA),
@@ -4545,7 +4545,7 @@ class TestFunctional(unittest.TestCase):
         props = self._GetPropTree(dtb, ['offset', 'image-pos', 'size',
                                         'uncomp-size'])
         orig = self._decompress(data)
-        self.assertEquals(COMPRESS_DATA + U_BOOT_DATA, orig)
+        self.assertEqual(COMPRESS_DATA + U_BOOT_DATA, orig)
         expected = {
             'section/blob:offset': 0,
             'section/blob:size': len(COMPRESS_DATA),
@@ -4580,7 +4580,7 @@ class TestFunctional(unittest.TestCase):
                                         'uncomp-size'])
 
         base = data[len(U_BOOT_DATA):]
-        self.assertEquals(U_BOOT_DATA, base[:len(U_BOOT_DATA)])
+        self.assertEqual(U_BOOT_DATA, base[:len(U_BOOT_DATA)])
         rest = base[len(U_BOOT_DATA):]
 
         # Check compressed data
@@ -4588,22 +4588,22 @@ class TestFunctional(unittest.TestCase):
         expect1 = bintool.compress(COMPRESS_DATA + U_BOOT_DATA)
         data1 = rest[:len(expect1)]
         section1 = self._decompress(data1)
-        self.assertEquals(expect1, data1)
-        self.assertEquals(COMPRESS_DATA + U_BOOT_DATA, section1)
+        self.assertEqual(expect1, data1)
+        self.assertEqual(COMPRESS_DATA + U_BOOT_DATA, section1)
         rest1 = rest[len(expect1):]
 
         expect2 = bintool.compress(COMPRESS_DATA + COMPRESS_DATA)
         data2 = rest1[:len(expect2)]
         section2 = self._decompress(data2)
-        self.assertEquals(expect2, data2)
-        self.assertEquals(COMPRESS_DATA + COMPRESS_DATA, section2)
+        self.assertEqual(expect2, data2)
+        self.assertEqual(COMPRESS_DATA + COMPRESS_DATA, section2)
         rest2 = rest1[len(expect2):]
 
         expect_size = (len(U_BOOT_DATA) + len(U_BOOT_DATA) + len(expect1) +
                        len(expect2) + len(U_BOOT_DATA))
-        #self.assertEquals(expect_size, len(data))
+        #self.assertEqual(expect_size, len(data))
 
-        #self.assertEquals(U_BOOT_DATA, rest2)
+        #self.assertEqual(U_BOOT_DATA, rest2)
 
         self.maxDiff = None
         expected = {
@@ -4695,7 +4695,7 @@ class TestFunctional(unittest.TestCase):
 
         u_boot = image.GetEntries()['section'].GetEntries()['u-boot']
 
-        self.assertEquals(U_BOOT_DATA, u_boot.ReadData())
+        self.assertEqual(U_BOOT_DATA, u_boot.ReadData())
 
     def testTplNoDtb(self):
         """Test that an image with tpl/u-boot-tpl-nodtb.bin can be created"""
@@ -5526,7 +5526,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         segments, entry = elf.read_loadable_segments(elf_data)
 
         # We assume there are two segments
-        self.assertEquals(2, len(segments))
+        self.assertEqual(2, len(segments))
 
         atf1 = dtb.GetNode('/images/atf-1')
         _, start, data = segments[0]
@@ -6107,7 +6107,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             data = bintool.compress(COMPRESS_DATA)
             self.assertNotEqual(COMPRESS_DATA, data)
             orig = bintool.decompress(data)
-            self.assertEquals(COMPRESS_DATA, orig)
+            self.assertEqual(COMPRESS_DATA, orig)
 
     def testCompUtilVersions(self):
         """Test tool version of compression algorithms"""
@@ -6125,7 +6125,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             self.assertNotEqual(COMPRESS_DATA, data)
             data += tools.get_bytes(0, 64)
             orig = bintool.decompress(data)
-            self.assertEquals(COMPRESS_DATA, orig)
+            self.assertEqual(COMPRESS_DATA, orig)
 
     def testCompressDtbZstd(self):
         """Test that zstd compress of device-tree files failed"""
diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index 6b88ed815d65..0ac9fc7e44f4 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -807,27 +807,27 @@ CONFIG_LOCALVERSION=y
         params, warnings = self._boards.scan_defconfigs(src, src)
 
         # We should get two boards
-        self.assertEquals(2, len(params))
+        self.assertEqual(2, len(params))
         self.assertFalse(warnings)
         first = 0 if params[0]['target'] == 'board0' else 1
         board0 = params[first]
         board2 = params[1 - first]
 
-        self.assertEquals('arm', board0['arch'])
-        self.assertEquals('armv7', board0['cpu'])
-        self.assertEquals('-', board0['soc'])
-        self.assertEquals('Tester', board0['vendor'])
-        self.assertEquals('ARM Board 0', board0['board'])
-        self.assertEquals('config0', board0['config'])
-        self.assertEquals('board0', board0['target'])
-
-        self.assertEquals('powerpc', board2['arch'])
-        self.assertEquals('ppc', board2['cpu'])
-        self.assertEquals('mpc85xx', board2['soc'])
-        self.assertEquals('Tester', board2['vendor'])
-        self.assertEquals('PowerPC board 1', board2['board'])
-        self.assertEquals('config2', board2['config'])
-        self.assertEquals('board2', board2['target'])
+        self.assertEqual('arm', board0['arch'])
+        self.assertEqual('armv7', board0['cpu'])
+        self.assertEqual('-', board0['soc'])
+        self.assertEqual('Tester', board0['vendor'])
+        self.assertEqual('ARM Board 0', board0['board'])
+        self.assertEqual('config0', board0['config'])
+        self.assertEqual('board0', board0['target'])
+
+        self.assertEqual('powerpc', board2['arch'])
+        self.assertEqual('ppc', board2['cpu'])
+        self.assertEqual('mpc85xx', board2['soc'])
+        self.assertEqual('Tester', board2['vendor'])
+        self.assertEqual('PowerPC board 1', board2['board'])
+        self.assertEqual('config2', board2['config'])
+        self.assertEqual('board2', board2['target'])
 
     def test_output_is_new(self):
         """Test detecting new changes to Kconfig"""
@@ -898,7 +898,7 @@ Active  aarch64     armv8 - armltd total_compute board2
         params_list, warnings = self._boards.build_board_list(config_dir, src)
 
         # There should be two boards no warnings
-        self.assertEquals(2, len(params_list))
+        self.assertEqual(2, len(params_list))
         self.assertFalse(warnings)
 
         # Set an invalid status line in the file
@@ -907,12 +907,12 @@ Active  aarch64     armv8 - armltd total_compute board2
                   for line in orig_data.splitlines(keepends=True)]
         tools.write_file(main, ''.join(lines), binary=False)
         params_list, warnings = self._boards.build_board_list(config_dir, src)
-        self.assertEquals(2, len(params_list))
+        self.assertEqual(2, len(params_list))
         params = params_list[0]
         if params['target'] == 'board2':
             params = params_list[1]
-        self.assertEquals('-', params['status'])
-        self.assertEquals(["WARNING: Other: unknown status for 'board0'"],
+        self.assertEqual('-', params['status'])
+        self.assertEqual(["WARNING: Other: unknown status for 'board0'"],
                           warnings)
 
         # Remove the status line (S:) from a file
@@ -920,39 +920,39 @@ Active  aarch64     armv8 - armltd total_compute board2
                  if not line.startswith('S:')]
         tools.write_file(main, ''.join(lines), binary=False)
         params_list, warnings = self._boards.build_board_list(config_dir, src)
-        self.assertEquals(2, len(params_list))
-        self.assertEquals(["WARNING: -: unknown status for 'board0'"], warnings)
+        self.assertEqual(2, len(params_list))
+        self.assertEqual(["WARNING: -: unknown status for 'board0'"], warnings)
 
         # Remove the configs/ line (F:) from a file - this is the last line
         data = ''.join(orig_data.splitlines(keepends=True)[:-1])
         tools.write_file(main, data, binary=False)
         params_list, warnings = self._boards.build_board_list(config_dir, src)
-        self.assertEquals(2, len(params_list))
-        self.assertEquals(["WARNING: no maintainers for 'board0'"], warnings)
+        self.assertEqual(2, len(params_list))
+        self.assertEqual(["WARNING: no maintainers for 'board0'"], warnings)
 
         # Mark a board as orphaned - this should give a warning
         lines = ['S: Orphaned' if line.startswith('S') else line
                  for line in orig_data.splitlines(keepends=True)]
         tools.write_file(main, ''.join(lines), binary=False)
         params_list, warnings = self._boards.build_board_list(config_dir, src)
-        self.assertEquals(2, len(params_list))
-        self.assertEquals(["WARNING: no maintainers for 'board0'"], warnings)
+        self.assertEqual(2, len(params_list))
+        self.assertEqual(["WARNING: no maintainers for 'board0'"], warnings)
 
         # Change the maintainer to '-' - this should give a warning
         lines = ['M: -' if line.startswith('M') else line
                  for line in orig_data.splitlines(keepends=True)]
         tools.write_file(main, ''.join(lines), binary=False)
         params_list, warnings = self._boards.build_board_list(config_dir, src)
-        self.assertEquals(2, len(params_list))
-        self.assertEquals(["WARNING: -: unknown status for 'board0'"], warnings)
+        self.assertEqual(2, len(params_list))
+        self.assertEqual(["WARNING: -: unknown status for 'board0'"], warnings)
 
         # Remove the maintainer line (M:) from a file
         lines = [line for line in orig_data.splitlines(keepends=True)
                  if not line.startswith('M:')]
         tools.write_file(main, ''.join(lines), binary=False)
         params_list, warnings = self._boards.build_board_list(config_dir, src)
-        self.assertEquals(2, len(params_list))
-        self.assertEquals(["WARNING: no maintainers for 'board0'"], warnings)
+        self.assertEqual(2, len(params_list))
+        self.assertEqual(["WARNING: no maintainers for 'board0'"], warnings)
 
         # Move the contents of the second file into this one, removing the
         # second file, to check multiple records in a single file.
@@ -960,14 +960,14 @@ Active  aarch64     armv8 - armltd total_compute board2
         tools.write_file(main, both_data, binary=False)
         os.remove(other)
         params_list, warnings = self._boards.build_board_list(config_dir, src)
-        self.assertEquals(2, len(params_list))
+        self.assertEqual(2, len(params_list))
         self.assertFalse(warnings)
 
         # Add another record, this should be ignored with a warning
         extra = '\n\nAnother\nM: Fred\nF: configs/board9_defconfig\nS: other\n'
         tools.write_file(main, both_data + extra, binary=False)
         params_list, warnings = self._boards.build_board_list(config_dir, src)
-        self.assertEquals(2, len(params_list))
+        self.assertEqual(2, len(params_list))
         self.assertFalse(warnings)
 
         # Add another TARGET to the Kconfig
@@ -983,8 +983,8 @@ endif
         tools.write_file(kc_file, orig_kc_data + extra)
         params_list, warnings = self._boards.build_board_list(config_dir, src,
                                                               warn_targets=True)
-        self.assertEquals(2, len(params_list))
-        self.assertEquals(
+        self.assertEqual(2, len(params_list))
+        self.assertEqual(
             ['WARNING: board2_defconfig: Duplicate TARGET_xxx: board2 and other'],
              warnings)
 
@@ -994,8 +994,8 @@ endif
         tools.write_file(kc_file, b''.join(lines))
         params_list, warnings = self._boards.build_board_list(config_dir, src,
                                                               warn_targets=True)
-        self.assertEquals(2, len(params_list))
-        self.assertEquals(
+        self.assertEqual(2, len(params_list))
+        self.assertEqual(
             ['WARNING: board2_defconfig: No TARGET_BOARD2 enabled'],
              warnings)
         tools.write_file(kc_file, orig_kc_data)
@@ -1004,7 +1004,7 @@ endif
         data = ''.join(both_data.splitlines(keepends=True)[:-1])
         tools.write_file(main, data + 'N: oa.*2\n', binary=False)
         params_list, warnings = self._boards.build_board_list(config_dir, src)
-        self.assertEquals(2, len(params_list))
+        self.assertEqual(2, len(params_list))
         self.assertFalse(warnings)
 
     def testRegenBoards(self):
diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index f92add7a7c5e..79164bd1993d 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -584,7 +584,7 @@ class TestBuild(unittest.TestCase):
         if use_network:
             with test_util.capture_sys_output() as (stdout, stderr):
                 url = self.toolchains.LocateArchUrl('arm')
-            self.assertRegexpMatches(url, 'https://www.kernel.org/pub/tools/'
+            self.assertRegex(url, 'https://www.kernel.org/pub/tools/'
                     'crosstool/files/bin/x86_64/.*/'
                     'x86_64-gcc-.*-nolibc[-_]arm-.*linux-gnueabi.tar.xz')
 

-- 
2.43.0

