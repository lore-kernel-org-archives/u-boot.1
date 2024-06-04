Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDF1C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 16:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 578E888476;
	Tue,  4 Jun 2024 18:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collins.com header.i=@collins.com header.b="awokwYh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CA7B87D46; Tue,  4 Jun 2024 18:16:24 +0200 (CEST)
Received: from mx0b-00105401.pphosted.com (mx0b-00105401.pphosted.com
 [67.231.152.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2049C88476
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 18:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brandon.maier@collins.com
Received: from pps.filterd (m0346905.ppops.net [127.0.0.1])
 by mx0a-00105401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 454D2liM019970; Tue, 4 Jun 2024 16:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=POD051818;
 bh=yTm9pig84UBRcp99XecxZx7SEyj0Tm/HL7sakQLxJf8=;
 b=awokwYh/zJTSguZARxp5nTbvDfMliYjDIxeMUA6DyYpvvSA5396sJZ3T/1UkJFtJ2mXr
 0gFyQ8S+SYA6orikIZ3E5HOWyheN76HM38HpWYdGRX+4AWvly+vyBuEe2ty6InRTn+uo
 iq9OIooIl/rFUVchIinXZ+pptMUebkDWMJLpgBpNYJWhH1MYuS4p5miL8/P8SWYAMKJz
 NsnnDoRAxgoYCQTQ9pu6P3NgOlSHnxbyA2tOAt/qQExegOpSLeW+Oivl2m3fV28eymSH
 K9mBz5g0imITe9gGtbD7cuTlaoSro9zvD+0oR1QuD2dfXxRGJOFwuUs/st1cXMgiV+K4 8g== 
Received: from xusxph009rp050.rtx.com (xusxph009rp050.rtx.com [128.13.125.147])
 by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 3yhk2mj4pg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Jun 2024 16:16:18 +0000
Received: from xusxph009rp020.corp.ray.com ([128.13.125.224])
 by xusxph009rp050.rtx.com (8.17.1.19/8.17.1.19) with ESMTPS id 454GGHom020288
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Jun 2024 16:16:17 GMT
Received: from ciulimr02.rockwellcollins.com
 (snat-utc-mailhub.rockwellcollins.com [10.172.224.19])
 by xusxph009rp020.corp.ray.com (8.17.1.19/8.17.1.19) with ESMTPS id
 454GGHod017194
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 4 Jun 2024 16:16:17 GMT
X-Received: from bspbox.kirk (unknown [10.148.204.208])
 by ciulimr02.rockwellcollins.com (Postfix) with ESMTP id 53B0510029B1;
 Tue,  4 Jun 2024 11:16:17 -0500 (CDT)
From: Brandon Maier <brandon.maier@collins.com>
To: u-boot@lists.denx.de
Cc: Brandon Maier <brandon.maier@collins.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH 1/3] tools: binman: fix deprecated Python unittest methods
Date: Tue,  4 Jun 2024 16:16:05 +0000
Message-ID: <20240604161607.1133032-1-brandon.maier@collins.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040130
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040130
X-Proofpoint-GUID: q0cPhm5ysnbZV5s8MPW3jF0FIyzNSw0w
X-Proofpoint-ORIG-GUID: q0cPhm5ysnbZV5s8MPW3jF0FIyzNSw0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_default_notspam
 policy=outbound_default score=0 bulkscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040130
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

The methods `unittest.assertEquals()` and
`unittest.assertRegexpMatches()` are marked deprecated[1].

In Python 3.12 these aliases have been removed, so do a sed to replace
them with their new names.

[1] https://docs.python.org/3.11/library/unittest.html#deprecated-aliases

Signed-off-by: Brandon Maier <brandon.maier@collins.com>
CC: Simon Glass <sjg@chromium.org>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
 tools/binman/entry_test.py  |  6 +--
 tools/binman/fdt_test.py    | 48 ++++++++++++------------
 tools/binman/ftest.py       | 42 ++++++++++-----------
 tools/buildman/func_test.py | 74 ++++++++++++++++++-------------------
 tools/buildman/test.py      |  2 +-
 5 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/tools/binman/entry_test.py b/tools/binman/entry_test.py
index ac6582cf86a..40d74d401a2 100644
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
index 7ef87295463..564c1770820 100644
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
index 8a44bc051b3..567849bbab0 100644
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
index 6b88ed815d6..0ac9fc7e44f 100644
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
index f92add7a7c5..79164bd1993 100644
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
2.45.1

