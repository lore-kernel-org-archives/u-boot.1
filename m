Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01DFC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 23:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C425487C0A;
	Sat, 16 Dec 2023 00:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JqYbWBwG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56DAA87BDD; Sat, 16 Dec 2023 00:26:13 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A21487C0A
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 00:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CCD0F40100; 
 Fri, 15 Dec 2023 23:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702682770;
 bh=S3+sC0BiU4upeVFnmPK9dOQO4gbqYm4p97lH7swt6Kg=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=JqYbWBwG4iEw4kahGmQ2ks9q8ZYs8X549QdcFRg/k1/MpRenF8aHMjQblCVOIlgmL
 voZOxkA1YXiG5XYWsFkf+JL6aroa/Hb5ms/12IArD1Ku145ZLkdcqH8weg62JiIp8r
 PKsKbWBrxxeq90p107ZR2pFbvO+EJ8UByAeDJjdAZeOMwUOr82e2Cq0kkKVgBbHNQ2
 pjs0KJCzvcxk+yESLpmTiD8wfGhIR5KfszZzyX0AHEWd5PpwvKyAW28HlfhTo6dRWD
 +uiHK4msSTJllUBpoEKZoNx6GnbySqfgteeIY/S1NeW+CaWhUmOxVdRdgMe7NEB7cD
 95YXtS9NcKT3A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] binman: used-before-assignment in ftest.py
Date: Sat, 16 Dec 2023 00:26:04 +0100
Message-Id: <20231215232604.260081-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Pytest 7.4.3 complains if a variable is used in a finally clause without
having been initialized before the try clause.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/binman/ftest.py | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a273120d9f..a4ac520cbb 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -2842,12 +2842,14 @@ class TestFunctional(unittest.TestCase):
         fdt_size = entries['section'].GetEntries()['u-boot-dtb'].size
         fdtmap_offset = entries['fdtmap'].offset
 
+        tmpdir = None
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
             with test_util.capture_sys_output() as (stdout, stderr):
                 self._DoBinman('ls', '-i', updated_fname)
         finally:
-            shutil.rmtree(tmpdir)
+            if tmpdir:
+                shutil.rmtree(tmpdir)
         lines = stdout.getvalue().splitlines()
         expected = [
 'Name              Image-pos  Size  Entry-type    Offset  Uncomp-size',
@@ -2868,12 +2870,14 @@ class TestFunctional(unittest.TestCase):
     def testListCmdFail(self):
         """Test failing to list an image"""
         self._DoReadFile('005_simple.dts')
+        tmpdir = None
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
             with self.assertRaises(ValueError) as e:
                 self._DoBinman('ls', '-i', updated_fname)
         finally:
-            shutil.rmtree(tmpdir)
+            if tmpdir:
+                shutil.rmtree(tmpdir)
         self.assertIn("Cannot find FDT map in image", str(e.exception))
 
     def _RunListCmd(self, paths, expected):
@@ -3002,13 +3006,15 @@ class TestFunctional(unittest.TestCase):
         self._CheckLz4()
         self._DoReadFileRealDtb('130_list_fdtmap.dts')
         fname = os.path.join(self._indir, 'output.extact')
+        tmpdir = None
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
             with test_util.capture_sys_output() as (stdout, stderr):
                 self._DoBinman('extract', '-i', updated_fname, 'u-boot',
                                '-f', fname)
         finally:
-            shutil.rmtree(tmpdir)
+            if tmpdir:
+                shutil.rmtree(tmpdir)
         data = tools.read_file(fname)
         self.assertEqual(U_BOOT_DATA, data)
 
@@ -5185,12 +5191,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         data = self._DoReadFileRealDtb('207_fip_ls.dts')
         hdr, fents = fip_util.decode_fip(data)
 
+        tmpdir = None
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
             with test_util.capture_sys_output() as (stdout, stderr):
                 self._DoBinman('ls', '-i', updated_fname)
         finally:
-            shutil.rmtree(tmpdir)
+            if tmpdir:
+                shutil.rmtree(tmpdir)
         lines = stdout.getvalue().splitlines()
         expected = [
 'Name        Image-pos  Size  Entry-type  Offset  Uncomp-size',
@@ -5395,12 +5403,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             use_real_dtb=True,
             extra_indirs=[os.path.join(self._indir, TEST_FDT_SUBDIR)])
 
+        tmpdir = None
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
             with test_util.capture_sys_output() as (stdout, stderr):
                 self._RunBinman('ls', '-i', updated_fname)
         finally:
-            shutil.rmtree(tmpdir)
+            if tmpdir:
+                shutil.rmtree(tmpdir)
 
     def testFitSubentryUsesBintool(self):
         """Test that binman FIT subentries can use bintools"""
-- 
2.40.1

