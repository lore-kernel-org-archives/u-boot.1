Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4AFF94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA48B8437E;
	Tue, 21 Apr 2026 23:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="ipwYeW0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE8638426E; Tue, 21 Apr 2026 23:10:21 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE39842D7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoJGyTkZ5IJ5juVtJYF1/a/f9u/h3C+vyRJ1TS9IArEL8jS1Y8Q2nhJ5Ihy/jCxaStO0zvQ9iOS6GI/+udBLT2SXfqcfJFMKwOaKFYZqLdzcIp/6wwOQcXX7hFQYKTIQI54wr0uCz5B7KWWK/EToeRh505ss7DFuvUvjcsjOyuI4i2djyKQC68PowGIcvVRpzYlzOvW73jCtDsWNN7USGheuOkQlNr9IYY5xodBdTyxG9HQ9wnz3fWLcVCYUZta1J8c2OIb2dEaS8XxubwEafOAhWczLM7lVX6LjW36HHmJGxlNPZ5agQlqWBf0mAy9DmXDI54/7TxJmHK7kaAiORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S18BJQkvOXc0igMZBM1DIMLwJIFRJ0M6OONkrWQzG8s=;
 b=iiOnw8ylpEbkFByx3Bi2c++4A25c8t2fesQmLGdFMze2Xz8gYVc8Zro++343vwjibVNQB7ouHeUht7i4LVpF/2YnuVsEBaMKfHp2hmswzOcHM3agpoO5ADCt7V7zPbu6xTtgWd5Sgojlua4Liur0o9JW+ok5Wq8l+BhU+t5mhJDxzMcCtebJvbGE/0y3ZF8fgy3NgnVnpBIkRC0+Oj2zsMKJZeiH94AB9uBwBrvRQp+OGUc1oBtadbZ+Ylle3VaIhEYd6VHxNfVX5DmCGrNr6wKJQ0GUUvwC6G0pd+0wQkrdpL+R5K94NfB0Pp6mjhq0ypQUuUGft4eeSA6TuycLFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S18BJQkvOXc0igMZBM1DIMLwJIFRJ0M6OONkrWQzG8s=;
 b=ipwYeW0eb/jN5M+AcIakMMKgP25CsELoNZsT8cxIbpOw4cSKH/l0QSOmvX85C+C+JWOfxobzgZRDK4nyKJx28SHu9sU4vLQhw2Kwg8DZzBBl7uxF1K6IqNufpXPHfNZb/p677w9qj2jVmWqR1M2ZwVp9WuMA2eIJj+XTlphjBPVZLcJIpVwFzC9MZylYOZE07PQh6Z1ZAV2381Zzw5JWOCcmuP+4JZv2f2dxdMv1ZauUtvlzUsa/bLIzWL1VKwDKTkaKUgeKpXR/1pjtc9GlWWpocdp2bnluNkbw9LWbZ7vJnDXl4q0zUFE+JiLHKpJLU0Ty/Eja9ukItzBGxpNH4A==
Received: from MR1P264CA0128.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:51::10)
 by PR0P264MB2597.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Tue, 21 Apr
 2026 21:09:58 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51:cafe::c7) by MR1P264CA0128.outlook.office365.com
 (2603:10a6:501:51::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 21:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Tue, 21 Apr 2026 21:09:58 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id D51E12014C;
 Tue, 21 Apr 2026 23:09:57 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 11/15] tools: binman: pre-load: add support of ecdsa
Date: Tue, 21 Apr 2026 23:09:50 +0200
Message-ID: <20260421210954.1170437-12-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|PR0P264MB2597:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 89851696-0f87-4932-442c-08de9fea580e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|22082099003|17002099007|18002099003;
X-Microsoft-Antispam-Message-Info: JzpZ1I5Sw+mYuBCkLsvJE9PvZ3xVkWTyFi25nxDPeLJmsFF8fd8SlSz3dUtDF+ca7y3JqXuO0pM4c+UJrLyNb/0bO0qIHIKOAvDKv4lhPJDRPECYvDn9K4jAkK1DcST2LYy81/1fl/2EqedA6IZxSMwL1ju6j/+Cv4cvT4JyJTLNfhh//X+JUeynGy8KsJz4+JLabsLpPKwpRvWCfO6Zu3WwpqFO/Wq/unbXPApOQKJJUEGJQZohu2Txl6KPlzzw1vIiAeOTD/PPSmp48rcugZRnpW8qezP32OBQmQq+ov9JvtJ7iCvazTAHcDuUe5VHbpSlOa58pAN2WMsobxcuNC5k0amPIXzx5pBeYxAiKNmN0ZMAZnFIAv2cU3WUhGefhu7/eQUkvpvWpYyOnKs25x1F3la4kVhHR+QdBI5xlsWIMEMj8avSLNvjGfSgHfzuytPz83hR3yhgwV0Gnc28qnx81ortKciYhMQ8eWl7ENzLXt7ZXkCwBatkctP//hgrJkQzy7R2ySK+HWKJgZrw2Iz6/KrI0+t3hEwW8Ac7mG3J5ESeLvNZqAgafPjroHYHB8z3XYWerCSNsL7QdCeAtoYE2LkNmiPciYxAy4VDPamNq3JlZAbxJ7WKBpZyCjKQvSWlKhRTjqbIvR/p3WNEh+d3y+AXUtI+/J3hrW38MUJ6RyqEXrQtuK/9FyRk5XpYNcb/z66bYMvBg/k7SkeCY8XkUhByt5LW2BZGUorKn/aNcBPctqZzNqaEtYsYTSefUJwTndddVwjvh9S8bMOzfw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(17002099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yp8Q/DTrgv71veZwya4WfKkhgpqo89Gz7b8a2jkiSYYT23o2VKGw5z55yHTwjVRBNUcZPom1hSK4vRSTrv0VSg9ajXeW6y78aqrkZABPsZkMqXLldoWTCsAgSRxVUqOv/snD3u1TomS7aNbcfA2dao/lYUr1tFvD6JhPC1zL6OAkgpnHnW1Shokiv/vgUiMiwusFEIeNQpFf5ZFu7dAwR8GAD0x9ZM08S4KvvqkYP+JdjwTIMGjSw2fop+M/z9no7YprGLyc0eebYMbVgFYi1xFted32iiun6qQPQz8QkyxEbIXHJCqdk/rHGgz9lf6mv1XIOLv1+bviWWWIOTXsKl6Dq7qn8xb8wkoUYCkjnaeyrI+8kn0257EocDzvD72fsRHbs/GgY4PeYOdmxBFnkBYPy/Q1hx6Mm6LPnnwsNKc0Iw2YLSFX4jSA0KDLATsl
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:09:58.1006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89851696-0f87-4932-442c-08de9fea580e
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2597
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

 tools/binman/etype/pre_load.py                | 78 ++++++++++++++++---
 tools/binman/ftest.py                         | 52 +++++++++++++
 tools/binman/test/ecdsa521.pem                |  7 ++
 tools/binman/test/security/pre_load_ecdsa.dts | 22 ++++++
 .../security/pre_load_ecdsa_invalid_algo.dts  | 22 ++++++
 .../security/pre_load_ecdsa_invalid_key.dts   | 22 ++++++
 .../security/pre_load_ecdsa_invalid_sha.dts   | 22 ++++++
 7 files changed, 216 insertions(+), 9 deletions(-)
 create mode 100644 tools/binman/test/ecdsa521.pem
 create mode 100644 tools/binman/test/security/pre_load_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 00f1a896767..3d4a30391a6 100644
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
         """Obtain a placeholder for the header contents"""
         # wait that the image is available
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index ca5149ee654..5d5bcb5874f 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5895,6 +5895,58 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             data = self._DoReadFileDtb('security/pre_load_invalid_key.dts',
                                        entry_args=entry_args)
 
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

