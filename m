Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE1CFF60EF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 320A28405B;
	Tue, 31 Mar 2026 12:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="hFbuxVwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 529BD84068; Tue, 31 Mar 2026 12:01:06 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2625084106
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4wstwnoE95ablrZsgk0cGB5fsSYYW4EaASHfNG0mFW4G6Ef04l+YY8OFmKhWynf4aE3/zcGZl/GN3GWcGcJk4Cw0VF77RMOFFUH1wdJNj65+XVhn1vW+FjSMn6/pn0tJkMjnd8PmxeCZE6fAQW5jPjqIuLx9FJCx/fDZE4y7wK4mIAwc2nFefGLD4ewsmkHBLOj1WeLv9ttN0p5b0aF0hnf7o+E6v7pbxATh8q4Di8mz/Jd8rUcdUATtlcERHNpGdkuGt3lgkMJvaycvn96zq0lLGTKQXKL4VZIxlvZPV1CaupN9dXqffkWVovMsiVuPmVr8JNryWsGBDCBaaBAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5od/TcfHGLicSJnL3MyvF/m1F38Mx+Fonko9Nz6Ir0=;
 b=Kmq/gQF2WYstjYqhatlFRfh9tPwyr+02K/kGBKo48JJZVF389tGRDwJLADR/tnXc7HgWYtoqHeoC3/N/+aTlpUocDuB9auFdE9aD+aYLthcgJCMWv7MOVm+5YnuyA2XSkYxinH1CHGyX/ts0OmWa6VoqHqDfwmqzRyt7dYujQMtOva9iyaxSCtcDDaFPnDhf3BLLF4j9c3RTjbkeqRHpmUnlYMomBN0NQPHmFONbwUbh3EpvbEbWUdMvZr/PTC5QN9trIvP5Nbs3Wp640L8GCxyAKjClp/TtRt56PEz/yrkRGR/j9Uw2BO++oMDb5qnawhbYeId++/xvdjNxY3ookQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5od/TcfHGLicSJnL3MyvF/m1F38Mx+Fonko9Nz6Ir0=;
 b=hFbuxVwNOfpBYAn0v78TySBsGhK5BhPw9CekOTN9iHBy5S2vBI8QP9OFu1T/TEE7L1HdUVX2H0jeq6watESyk6nVw7EHpN7PBantG6jT6JS4OfbbUow30IeWgakK/sC6PGlyZ45XMs3KjeTz0d6VYWnZVLWx8xJ7b2qFJTg4Isqy+8/SlTzquPX0/ea4ZJLKq+8MHFQSVlbfdqUaC0PkPMlpbdCzflD+7rclqyXb8HNGDzjiyHuw6t64U/bso5ye0m4TykxiwRC/qucZBn4FmfKqpTlQ9Jd+bsPoNda7gy1cd7+xYYAG09h2Q0fhhF5Q39al66eYydqCjZFbnFI3Hg==
Received: from PR3P192CA0017.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::22)
 by MR0P264MB5115.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.29; Tue, 31 Mar
 2026 10:00:53 +0000
Received: from PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:56:cafe::ca) by PR3P192CA0017.outlook.office365.com
 (2603:10a6:102:56::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019232.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:53 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 30C06202EB;
 Tue, 31 Mar 2026 12:00:53 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 10/15] tools: binman: pre-load: add support of ecdsa
Date: Tue, 31 Mar 2026 12:00:42 +0200
Message-ID: <20260331100047.34618-11-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019232:EE_|MR0P264MB5115:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0e9eeda4-3e58-4ae3-7609-08de8f0c6532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099003|17002099007;
X-Microsoft-Antispam-Message-Info: Af8yztjJ0oSJYwBMIOEQFqCfv5+E/U8wjP6uQXorrlbQ/cJ3miEEMnTZddgmDpQaCyqiIGEieROWCcBDyJwkrLapcpoxd6KDiV/C3Wq+fdUGCYpSg51c+nsuWvwy0VmOEizJOw05nb1z30PpAaUNnDDqO+iNnJg99WVofmvouya6H8ZG9DP6BYU/r1llR9qGnSB97MPyan0hEY24jbbT5/odw3FtdbNJ+7iTkmrvYOxbwUd9SMmBDyes1UtTCmVrnuxVV/7RGyleoyXrbSLhJQtu4TizsIY9Q9qKhWNXre840j2X/zLbeXNdC/WHq/LHkGCM6gboVd0vC5rWb9VLyD+PWc86TBMMPHPOBWUQbVVZKt01nA49slTwFBc/V+XgblreZOpefvy1Fs5ZkppOl8KTM0a7RHeWYFTVDBS/XTUwqakfxyEtgDd/Y98GDoMdbFwUbEUrAyvxK/BRCI4FU8XFZmjf9PoKyN5GFFrrnomNGJArfG3vU9McrpNg2KedRHb5vR41ZOWTQOl7u4E2gAdUiS9xRoyWgdM7os2xM62sj5BXQpSfzPDWpwJs3RqqSMvC+AE/oInCykfJZhGyqPiby33P1nixrPL3lEZV5krfctLLVwKizYfrninfCFUfKLg17IgqzSH5RFVpY/zg9wD9lO0jEaO/ncpPHNW92lUJWcZBMIuPwd5S28g9gu1oxSrWXsjyiQkKzb2+PKRL3Io4Iy5J+RrkitLf5tWzVqvA0Kqp57AmIJUHadohL19D1+woPdJkP7Sb6A3UBAP8DQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003)(17002099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cl4XN6H5/hDI2msIHAhEbT8aMKydHMxDIXLXM20ZS8c8FitMxY9r8D/1wwmBSw9Me/+iE0qhU+ovfYsJtG/Sp6Jg8/okq+H+hs+w3mnqBEXNq/ZEgDLQilTGfLUtBVGeXylFyRtRErx+Ml+fWWCfAfqpiMtILUyuO+CymZ734ZBX+p7ek7CIidrIM08DVILCUKuxQ33+BhGF/Xj4aXKRVQMr7SOuMJ46RwatjXcqsjaM2xdfhnx3pJWYcmQivvmf9f55WVjb2T/l3bdDtKqiPzuHBqKLgIZE1P8GMaqTGGpBpfD3T8iw2tu9+Mo/kR4WaTcNStQk38K853NUvQDFfBpzRMLTLIz6nteRuEQfWfa57W8i5P7WNojAg9DZXcY4/8p4ZvuNKWR06r0xtMSiiL1IgXOcEs/oIts1duamdignrLwBkx5+n7EAVdB6X+Pv
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:53.2914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9eeda4-3e58-4ae3-7609-08de8f0c6532
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5115
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

Right now, binman can only create pre-load header
using rsa. We add the support of ecdsa.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version

 tools/binman/etype/pre_load.py | 78 ++++++++++++++++++++++++++++++----
 tools/binman/ftest.py          | 31 ++++++++++++++
 2 files changed, 101 insertions(+), 8 deletions(-)

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 00f1a896767..2a2636403d3 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -16,8 +16,10 @@ from binman.entry import EntryArg
 
 from Cryptodome.Hash import SHA256, SHA384, SHA512
 from Cryptodome.PublicKey import RSA
+from Cryptodome.PublicKey import ECC
 from Cryptodome.Signature import pkcs1_15
 from Cryptodome.Signature import pss
+from Cryptodome.Signature import DSS
 
 PRE_LOAD_MAGIC = b'UBSH'
 
@@ -27,6 +29,12 @@ RSAS = {
     'rsa4096': 4096 / 8
 }
 
+ECDSAS = {
+    'ecdsa256': 256 / 8 * 2,
+    'ecdsa384': 384 / 8 * 2,
+    'ecdsa521': 132
+}
+
 SHAS = {
     'sha256': SHA256,
     'sha384': SHA384,
@@ -86,17 +94,10 @@ class Entry_pre_load(Entry_collection):
         if self.key_path is None:
             self.key_path = ''
 
-    def _CreateHeader(self):
-        """Create a pre load header"""
-        hash_name, sign_name = self.algo_name.split(',')
-        padding_name = self.padding_name
-        key_name = os.path.join(self.key_path, self.key_name)
-
+    def _CreateHeaderRsa(self, hash_name, sign_name, padding_name, key_name):
         # Check hash and signature name/type
         if hash_name not in SHAS:
             self.Raise(hash_name + " is not supported")
-        if sign_name not in RSAS:
-            self.Raise(sign_name + " is not supported")
 
         # Read the key
         key = RSA.import_key(tools.read_file(key_name))
@@ -151,6 +152,67 @@ class Entry_pre_load(Entry_collection):
 
         return data + pad
 
+    def _CreateHeaderEcdsa(self, hash_name, sign_name, padding_name, key_name):
+        # Check hash and signature name/type
+        if hash_name not in SHAS:
+            self.Raise(hash_name + " is not supported")
+
+        # Read the key
+        key = ECC.import_key(tools.read_file(key_name))
+
+        # Check if the key has the expected size
+        # if key.size_in_bytes() != ECDSAS[sign_name]:
+        #    self.Raise("The key " + self.key_name + " don't have the expected size")
+
+        # Compute the hash
+        hash_image = SHAS[hash_name].new()
+        hash_image.update(self.image)
+
+        # Compute the signature
+        signer = DSS.new(key, 'fips-186-3')
+        sig = signer.sign(hash_image)
+
+        # print("len = %d\n", len(sig))
+
+        hash_sig = SHA256.new()
+        hash_sig.update(sig)
+
+        version = self.version
+        header_size = self.header_size
+        image_size = len(self.image)
+        ofs_img_sig = 64 + len(sig)
+        flags = 0
+        reserved0 = 0
+        reserved1 = 0
+
+        first_header = struct.pack('>4sIIIIIII32s', PRE_LOAD_MAGIC,
+                                   version, header_size, image_size,
+                                   ofs_img_sig, flags, reserved0,
+                                   reserved1, hash_sig.digest())
+
+        hash_first_header = SHAS[hash_name].new()
+        hash_first_header.update(first_header)
+        sig_first_header = signer.sign(hash_first_header)
+
+        data = first_header + sig_first_header + sig
+        pad  = bytearray(self.header_size - len(data))
+
+        return data + pad
+
+    def _CreateHeader(self):
+        """Create a pre load header"""
+        hash_name, sign_name = self.algo_name.split(',')
+        padding_name = self.padding_name
+        key_name = os.path.join(self.key_path, self.key_name)
+
+        if sign_name in RSAS:
+            return self._CreateHeaderRsa(hash_name, sign_name, padding_name, key_name)
+
+        if sign_name in ECDSAS:
+            return self._CreateHeaderEcdsa(hash_name, sign_name, padding_name, key_name)
+
+        self.Raise(sign_name + " is not supported")
+
     def ObtainContents(self):
         """Obtain a placeholder for the header contents"""
         # wait that the image is available
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a53e37f31b3..bdb46fbf24f 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5894,6 +5894,37 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             data = self._DoReadFileDtb('236_pre_load_invalid_key.dts',
                                        entry_args=entry_args)
 
+    def testPreLoadEcdsa(self):
+        """Test an image with a pre-load header using ecdsa key"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        data = self._DoReadFileDtb(
+            '351_pre_load_ecdsa.dts', entry_args=entry_args,
+            extra_indirs=[os.path.join(self._binman_dir, 'test')])[0]
+
+        image_fname = tools.get_output_filename('image.bin')
+        is_signed = self._CheckPreload(image_fname, self.TestFile("ecdsa521.pem"), "sha256,ecdsa521")
+
+        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+        self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
+        self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+        self.assertEqual(is_signed, True)
+
+    def testPreLoadEcdsaInvalidSha(self):
+        """Test an image with a pre-load ecdsa header with an invalid hash"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFileDtb('352_pre_load_ecdsa_invalid_sha.dts',
+                                entry_args=entry_args)
+
+    def testPreLoadEcdsaInvalidAlgo(self):
+        """Test an image with a pre-load header with an invalid algo"""
+        with self.assertRaises(ValueError) as e:
+            data = self._DoReadFile('353_pre_load_ecdsa_invalid_algo.dts')
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
-- 
2.43.0

