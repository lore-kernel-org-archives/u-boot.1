Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E541BCD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A22518494B;
	Mon,  1 Jun 2026 15:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Db9Lu+in";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CACEB8498B; Mon,  1 Jun 2026 15:43:26 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90CFC848A6
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yz6fpBdVesFNn+aP4zdLmeF7kRwGwtgUoXC/kA/Xese6lJeiP4EV35uAU5+DjsH2RehwfBH9xGBwt3dvs5YtFjtNHstWPnm+ANLSB4x/aVKNud2NDRKIOU9/ySHxuAtiraEvzSIfgot7BpmmaMy+IH4DS8bAwHVg7LOOCJzAyOoT3VrKcW4ZuTPxOlAb0bfwsY3wyuPh3ZlJE3N2cny06abU+u58txLt62mL1+Gzze5H5EqRuffilz5Z/k4gOjdd3g1fhzdwyx8U601JjIjZS/cskBfU/lvkzZNygTzVijY4LJxmhW35xHpPi2lVoc6+rG/H/odtpjPUWorW7seppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4FqRB75clQtcADW8z1/OJ0qTFlcGHMixDuwezds4TQ=;
 b=zKR8jfPyHTGTWm9GTp+tGi9XheeQ8dgZxIoWBkCyrcmmJnKazHaa/G31pk6cUGS4QLtp+uLSTX5rEeHMPQ1M1SDtuy+csS4O1g+TJpp2zJKCr9aJ7PvwnWHKxvV+qpntWFP1eLpJlxSxF+h80siqN7rrGTPha81Ri6TjCeYq18Jj4SK2FCdOg3Ur+LJyegXCwGVYNZp9AWTg8gcu8s7G+KrQ2uQy+VBKHaDOoKo0p0U4Sqvo7qB//UHFpg1Dk0ZhZdPDdBS06lu6f7fkRTLL8p9ZrlfFpRcBsFsjaQqyWdxH80grLejPlHjgV5a5XbesHL/kL3oj0+CNTXHZX+XUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4FqRB75clQtcADW8z1/OJ0qTFlcGHMixDuwezds4TQ=;
 b=Db9Lu+inNU7AMhrpOC/eIXnWY68iHAj8Vbjc2tPsqv5y2kwRjc36L99e24N/GG6MA2xwDJ1A6Cw1r6/bT5tEqN8MdiWh19srR66bW0+2T6ZogpGY/WG9jEBbBBkw/zAZLfCUUdOlmKVOPYPSGbU4TOPzP4ryfdhTwSyVMT8dc80gU/dhuaCbNqIit0Z0lJYSKwckqsqLg9ixL7THknBvQbu3FSIAoHiGTIbAuEOhY3lwhhRQ3d0Lis5Nf6ee9sWrjm0jgngq2G7FIED9Ey3TkusozGXnX2y4MLY23f3oUrnCWM3qowxsUW3bp3PQw84OMCbCCmDjlO2pK9IPr1tbEg==
Received: from PA7P264CA0015.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2d3::19)
 by MR1P264MB3426.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:26::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 13:43:16 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3:cafe::8b) by PA7P264CA0015.outlook.office365.com
 (2603:10a6:102:2d3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 13:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Mon, 1 Jun 2026 13:43:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9171D2142B;
 Mon,  1 Jun 2026 15:43:15 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 11/15] tools: binman: pre-load: add support of ecdsa
Date: Mon,  1 Jun 2026 15:43:06 +0200
Message-ID: <20260601134310.2452454-12-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601134310.2452454-1-philippe.reynes@softathome.com>
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|MR1P264MB3426:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 626aba10-0cd4-4a94-7122-08debfe3bbea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|17002099007|18002099003|4133799003|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: AxkT2veepNlIeXJhoi9z+RTKmD4fZ/r65d5RINj5coF0SDNmJz81EVBfH3Iae6ecF0QGo3l6HclcsSLml+rxF02d58M2K0LnBH2f7Nbc12/ZJvLlgYFhOq0oQcZWWQJcoXK2qeWBeSL5LdPFpPwXmdNJyiVMSZLczTBh5Jdt9VP3iglv/a2ISs3lgCVG9DDupsMtlAn1qt9n23kAWg5bSyE/tsW8NcCbVe4yMUcakAYd602L7+K2XKrq/Y6rmO0FY8kO/hSdVGOtvGxnoItTV1uFo2eQPOBjscVLrkmUuyLDoWg4AuB5aGj7gT48DufgZoYIisnBFE1AYufJATzaiLl/xjhp1LiJFAywwKz4Uo+mk9mar6yyE4mNSwYF3yR2XVajHcdrvXhjE0rHViwGK46JeuRHoVdOEkL1KoMXqfMN1GyR8OCpg/7YazDgUQc8M6NHE/1gyqS4kZrvH/Br1tLESnbS4tnEBJOteFcSlHIZ3zQVgpnzUCurpuAVtyrv/85tAaXkaYphRS3VQqHkANnXWbR4i0kF6Hp6bqS0+tyGNVjqsYihUXiUZjvO1DzwRN9nrIBAuhMwWNzip8qHuv8OIyEXVo49Kc8WzcKLZUTXY7dQXxGBfFboRPuJhAyt3myYVRAxJ/vSZ/MyrDmeDw3WVTPVus1LfiEeDKKxjLhIrsCiyAZmgBEkgJaqMIWLkRx6QIyd4OActXRzXXi9romuBD72JodTHqanCGmQT3w=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(17002099007)(18002099003)(4133799003)(56012099006)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9ch98ovftzsOvzWxxaoPn1aE2h3ty3t5qbV5jjIlCCuEhuy7/wJDxHotpi/2bj1BVo4qovaoTzdJdl1qx1EvKb8LtJlOxIRjaGO42mWz8michhefsJbK544lixPMr06NsJv/jTNsWTmoOPH+bYSC8Nfrr6rnJLh6jbj5BuPmC6/wvS7rJ8sOzFB3GO3FYSKiJQf/ehkSK5jEYKmdDnXAccVdLHQW96uro8r7hddmnnf1BC4mRSAysxwf3fJ0eJIcvxLngjUauAdKOHJtn4XU/n0Ap53oirMUWASwGai4cgcu0J+OXq4EbAAu/rLm93d6B4kGxy3ymv1QwGSQVWoOyABTQPDvY/OQqAWEIj+lCHMLtcNWEErhXZ2JedWcm73dhwpYQqcsUIY5BchDzH8Y8SKTqjuc7N3GSC0n8JSiz86d2n88+1rd8ABlPLHGJzZ1
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:43:16.3910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 626aba10-0cd4-4a94-7122-08debfe3bbea
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3426
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- merge patch 11 that was adding test for ecdsa pre-load
- add key size check
- use exc instead of simply e
- rename dts filaneme
- add a test to check key size
v5:
- compute ecdsa521 sig instead of using hardcoded value 132
- fix english: don't -> doesn't
- avoid line too long
v6:
- no change
v7:
- no change
v8:
- no change

 tools/binman/etype/pre_load.py                | 78 ++++++++++++++++---
 tools/binman/ftest.py                         | 50 ++++++++++++
 tools/binman/test/ecdsa521.pem                |  7 ++
 tools/binman/test/security/pre_load_ecdsa.dts | 22 ++++++
 .../security/pre_load_ecdsa_invalid_algo.dts  | 22 ++++++
 .../security/pre_load_ecdsa_invalid_key.dts   | 22 ++++++
 .../security/pre_load_ecdsa_invalid_sha.dts   | 22 ++++++
 7 files changed, 214 insertions(+), 9 deletions(-)
 create mode 100644 tools/binman/test/ecdsa521.pem
 create mode 100644 tools/binman/test/security/pre_load_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 0d953cb258e..7890c1c62a8 100644
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
+    'ecdsa521': (521 + 7) / 8 * 2
+}
+
 SHAS = {
     'sha256': SHA256,
     'sha384': SHA384,
@@ -86,24 +94,17 @@ class Entry_pre_load(Entry_collection):
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
 
         # Check if the key has the expected size
         if key.size_in_bytes() != RSAS[sign_name]:
-            self.Raise("The key " + self.key_name + " don't have the expected size")
+            self.Raise("The key " + self.key_name + " doesn't have the expected size")
 
         # Compute the hash
         hash_image = SHAS[hash_name].new()
@@ -151,6 +152,65 @@ class Entry_pre_load(Entry_collection):
 
         return data + pad
 
+    def _CreateHeaderEcdsa(self, hash_name, sign_name, key_name):
+        # Check hash and signature name/type
+        if hash_name not in SHAS:
+            self.Raise(hash_name + " is not supported")
+
+        # Read the key
+        key = ECC.import_key(tools.read_file(key_name))
+
+        # Check if the key has the expected size
+        if key.pointQ.size_in_bytes() * 2 != ECDSAS[sign_name]:
+            self.Raise("The key " + self.key_name + " doesn't have the expected size")
+
+        # Compute the hash
+        hash_image = SHAS[hash_name].new()
+        hash_image.update(self.image)
+
+        # Compute the signature
+        signer = DSS.new(key, 'fips-186-3')
+        sig = signer.sign(hash_image)
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
+            return self._CreateHeaderEcdsa(hash_name, sign_name, key_name)
+
+        self.Raise(sign_name + " is not supported")
+
     def ObtainContents(self):
         """Create a placeholder for the header"""
         self.SetContents(tools.get_bytes(0, self.header_size))
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 9a3811c1732..5c88bec9b46 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5910,12 +5910,62 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         image_fname = tools.get_output_filename('image.bin')
         is_signed = self._CheckPreload(image_fname, self.TestFile("dev.key"))
+        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+        self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
+        self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+        self.assertEqual(is_signed, True)
 
+    def testPreLoadEcdsa(self):
+        """Test an image with a pre-load header using ecdsa key"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        data = self._DoReadFileDtb(
+            'security/pre_load_ecdsa.dts', entry_args=entry_args,
+            extra_indirs=[os.path.join(self._binman_dir, 'test')])[0]
+
+        image_fname = tools.get_output_filename('image.bin')
+        is_signed = self._CheckPreload(image_fname,
+                                       self.TestFile('ecdsa521.pem'),
+                                       'sha256,ecdsa521')
         self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
         self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
         self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
         self.assertEqual(is_signed, True)
 
+    def testPreLoadEcdsaInvalidSha(self):
+        """Test an image with a pre-load ecdsa header with an invalid hash"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFileDtb('security/pre_load_ecdsa_invalid_sha.dts',
+                                entry_args=entry_args)
+        self.assertIn("Node '/binman/pre-load': sha2560 is not supported",
+                      str(exc.exception))
+
+    def testPreLoadEcdsaInvalidAlgo(self):
+        """Test an image with a pre-load header with an invalid algo"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            data = self._DoReadFileDtb('security/pre_load_ecdsa_invalid_algo.dts',
+                                       entry_args=entry_args)
+        self.assertIn("Node '/binman/pre-load': ecdsa5210 is not supported",
+                      str(exc.exception))
+
+    def testPreLoadEcdsaInvalidKey(self):
+        """Test an image with a pre-load header with an invalid key size"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            data = self._DoReadFileDtb('security/pre_load_ecdsa_invalid_key.dts',
+                                       entry_args=entry_args)
+        self.assertIn("Node '/binman/pre-load': The key ecdsa521.pem doesn't have the expected size",
+                      str(exc.exception))
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/ecdsa521.pem b/tools/binman/test/ecdsa521.pem
new file mode 100644
index 00000000000..ac1904d3955
--- /dev/null
+++ b/tools/binman/test/ecdsa521.pem
@@ -0,0 +1,7 @@
+-----BEGIN EC PRIVATE KEY-----
+MIHcAgEBBEIBM+CNnraGci2/mw1wPq44l2HccHnoBbdP3DiU6zqsBOq8IR8uegz2
+FLzWsjxcW7hwROCdEm6tW99wqsyPE25RZ3egBwYFK4EEACOhgYkDgYYABABu5bWV
+aQ4EgnXFjojX9df3gBEBipphEEFAoG87GuoWBdlimFC8UEEXiKNU37w0wlJn4bG0
+8uOKwDqBk3uF+DrmZwB45lCSKkjdRWsJeDt+iEuFe2O/mbXoL4p5D8MM2OsDV5GT
+srUbxhXq+T/i5lV7XXm2+tT/7zU8ZQce6WRufbd9KQ==
+-----END EC PRIVATE KEY-----
diff --git a/tools/binman/test/security/pre_load_ecdsa.dts b/tools/binman/test/security/pre_load_ecdsa.dts
new file mode 100644
index 00000000000..247b85aad4c
--- /dev/null
+++ b/tools/binman/test/security/pre_load_ecdsa.dts
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
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,ecdsa521";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts b/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
new file mode 100644
index 00000000000..be71edbbdcd
--- /dev/null
+++ b/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
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
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,ecdsa5210";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_key.dts b/tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
new file mode 100644
index 00000000000..15d71cf0324
--- /dev/null
+++ b/tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
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
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,ecdsa384";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts b/tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts
new file mode 100644
index 00000000000..1017707375e
--- /dev/null
+++ b/tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts
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
+		pre-load {
+			content = <&image>;
+			algo-name = "sha2560,ecdsa521";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
-- 
2.43.0

