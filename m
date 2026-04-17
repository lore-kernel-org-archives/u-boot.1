Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ED8F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 635A784378;
	Fri, 17 Apr 2026 15:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="YzjF1srm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D1C84308; Fri, 17 Apr 2026 15:02:20 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FCFD842B7
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maIcvVxi+/p7RPXEGNhUhTIAhHTD8RymsGUfO1xvYza8mZUrG6SU55zF7Xbus+QC10a+LL9WEljVEPDO6Jym3s7UEgeclEcYB68XUkJxZesNJiXOpNvSdg/W+XVe6CK2YVGAfHboHhvhZWdeHMEe0FdnhhRfzvXY7FqB6V157Z24SHM91gS4VdMZpQN0R3vKjSmAxzLWO+b70p3vS05PfwxacUbO5oK6qlETJM+8lJRu02lTxso3VzqJI33b7LZ3+nn6CXzE7FbB56SvFyI/+2zRqTZfQ15saciIIA68D9caSiisomjxD6nVnVyrizHJ5jLQiY9nvU7A3LwA+aIs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tAm+AsaJ9SzxlPx4l6qbq2HBtfLgEHxHCIjPZfqRBs=;
 b=zRtASZifGoDbJvs5tul8RVwtxbnLEUrFQVQmJMgFmwUYNuY31xZajcyAbcMS1zOY23mZJl7EKKffva8LcoE7RLSpC9dgzvpFBsEV2E5C9kQGJ1TQUbvOjoCfjw98EN5G0dhbounKP6nNLXthWxuHGdO9PjYz52/6tR7wmiRC9KJycKC56BJSR5J6sLETfXp5hrHKe9wXhuSmZPrhs/Ll4gpEeMvqgxJ0R7hD3sl8AJQPty2x4FeXSvYtiJUEtTR+H52xRc2PxO1dHtC3P4EzQw5tflVMLxrFXZtdw0qp/TxKaSJgE4Q0zK2AV3bsBgwEjEQadZKZ94VbweuxmO0qtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tAm+AsaJ9SzxlPx4l6qbq2HBtfLgEHxHCIjPZfqRBs=;
 b=YzjF1srmZ9pwVwgOJ7r8dkGZ7d6av6h0QbBWrgccLKn4iWJ5W9gFEed8qYItHoJtbBTsL3awWze2yt9NE/akbLLCgKfgBQzJLK2q8M/+8BDmPhGhW80LwJqZG88p5xVsLNhx+jGW+/1eNqiH4yjOr+cO9TSFfq4K5jVBwAEyjE7vCU+kX2h34H5lUd+6frqF2MORsapzz4TtXxUZa/IOq72iVMQLYWksSYmITo3UfAg+QGWHd1HONKs4lWD2QB5Ts6vMVZ3G4PPs0q45pbwmIQE0O0u780uJ2vfQ4V2wcp/nL0vNj8ZQesvcCD0pR6WDOkQ7rRlm38tWNYdKfU8CDQ==
Received: from PR1P264CA0178.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:344::16)
 by MRYP264MB6139.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:70::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 17 Apr
 2026 13:02:10 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344:cafe::73) by PR1P264CA0178.outlook.office365.com
 (2603:10a6:102:344::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 13:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 13:02:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 61C541FFF4;
 Fri, 17 Apr 2026 15:02:10 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 10/14] tools: binman: pre-load: add support of ecdsa
Date: Fri, 17 Apr 2026 15:02:00 +0200
Message-ID: <20260417130204.49896-11-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|MRYP264MB6139:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ef959989-6904-4681-ba38-08de9c818994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003|17002099007|22082099003;
X-Microsoft-Antispam-Message-Info: ytaWTEwPVaJQesUNUg3UNahm2FEmSN+lO7u6YRmzObnXbOuTpQsUNRjiuU7GAdJJOemUABG5l3vDNzknW1Fldk0DOwS1U9qExTyAQf6rjMjuMU6Onx/k90MGdZy9XEKyylg1fQHpzwStWMIIPuXmNnbUK+tG21FgNeiq4BVMEdIPIQMVILcCTd/o3RDIKuSxPWe+mBU+NzSblWa1E1zAEm/oTSFj9hVLhC2dU0tSm5Q0WtltfUUB+K++Ui0yYDSj07W2BY94U7nZyRDEp1s6u4yWrAsTAZ3Jjh7YUxEbbnMuE7/mfIYQldgus/Fyil3Md20cbRwNbaU3KqoSfWStgm22/CCue1yBGuM7XFcmjCr9+MRWH/urIqfE6L0kaZzXGEevQFfMsV8oNIol8E9WP0l9Zr6bVzBn35jRxqoTGwRrg0x95N29cB2GVw8gVyRrmjJeOnu8mu/bZFf8IFKWgoB4tj/hMJWkgQNP5vs4vWLaUBupMT4A982kbH8iK1pEPXagYMDrTXhiMeiQtODh8a8faFrftzj1nqBu3mtkm6B9DRHC2HhvOF98sgU+4XPKXpmpW88NKlalDhG3wBBD9tGaRVJLgWngkh5O1PS0fvMmMxVCQtoTXlRnEnKWlbt/uv2gqWvVro+YT0dXr8VeYQQcL6AznmGm3WiErk7Fngkz3sNwf6Gr1klq9e5YmvocO7yKuh/ljIFfyVilD2/qI1jQJB0/gRrnO2kzPXxQ1APHGmMVVKgHZAjBa57YEJXkEKpFoB2xkUkjQm/0yubbNA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(17002099007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pLf/OtRFOF1PHZH1URAXoMhza8SiLjjkwifv4aqFeszHGVhJA2ZvqUQ8V2dVSiQJ1tG+w0g6h5clVf7OFLPk4FuqhRmaRbgfaKEKEMNuaBo9J9FQ0d0Vr8afG1d/7X5S44nxGbPODSMmUAF/A2mpqczG6KgsV02111tLF1AtbXWaSN6fGsJ4qIR87sAgiU0a+qrzD+E8IeAOWDl3Q2OLclR6PD9ekAes5JXWDe38xGLeyWPkpeBv/tpfiWK9D4Z8OxMsRz5F5qUhfI3cwimbGRvMyDS34nd8vKtH0mUgjoMXJ4zYtAdtK6dAGsEFtMyVQQWgAFYnmOnnagH1Gg/ibMtmNK9c85+dP3yv9w5YMTPDKk5kvybuNVgyHa3VrgQphx7cwE57Rt9eyqyslJOqbdinhqM8QU+hkeAK8TXuzQW9dn6z1WN+NCJMfcHeG9jy
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:02:10.5642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef959989-6904-4681-ba38-08de9c818994
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRYP264MB6139
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
v4:
- merge patch 11 that was adding test for ecdsa pre-load
- add key size check
- use exc instead of simply e
- rename dts filaneme
- add a test to check key size

 tools/binman/etype/pre_load.py                | 76 +++++++++++++++++--
 tools/binman/ftest.py                         | 50 ++++++++++++
 tools/binman/test/ecdsa521.pem                |  7 ++
 tools/binman/test/security/pre_load_ecdsa.dts | 22 ++++++
 .../security/pre_load_ecdsa_invalid_algo.dts  | 22 ++++++
 .../security/pre_load_ecdsa_invalid_key.dts   | 22 ++++++
 .../security/pre_load_ecdsa_invalid_sha.dts   | 22 ++++++
 7 files changed, 213 insertions(+), 8 deletions(-)
 create mode 100644 tools/binman/test/ecdsa521.pem
 create mode 100644 tools/binman/test/security/pre_load_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 00f1a896767..057422ab0dc 100644
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
+            self.Raise("The key " + self.key_name + " don't have the expected size")
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
index ca5149ee654..bc0fc05a36d 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5895,6 +5895,56 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
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
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFileDtb('security/pre_load_ecdsa_invalid_sha.dts',
+                                entry_args=entry_args)
+        self.assertIn("/binman/pre-load': sha2560 is not supported",
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
+        self.assertIn("Node '/binman/pre-load': The key ecdsa521.pem don't have the expected size",
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

