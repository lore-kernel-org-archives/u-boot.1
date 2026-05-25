Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37ECCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D7D84702;
	Mon, 25 May 2026 15:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="vDKZgWbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5848846A5; Mon, 25 May 2026 15:52:54 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DF45847AF
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8ZvM8neztXL4iBEInkmVmvrg3JLnwHhox8bUCXhx4EZqzdVK4+Ot+9U4tJ5CNufWR/s9f9V4z3VMMmJmFuZG0ZIPz4XmBwfbnpu+8DsPHLtiW68fvfoIhzGT2GUn9tc3VuJmF7sv+0je4XeBfGAQOYrkzegEtrVP0sEsKgolRbv3Io+B98q+3WcmQwec/NPHFkynEMCt+2edv4H/vmbXCRJoGEmtGXG+Q+R5xQVFYwl2UacBN1XgzwIM7uLkBWPc/T1knO4jLuWB+J/jSpoVnbIeRLSTYrwP6WR5WwySMZxuOINStCULO1jlMquQWIYOwSp6af55pwxXIqsK7rE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWSiUuS2KHexgHF4bbdcB2XPb5DyGEB+oBuwnZaikxg=;
 b=U/OOyNOG7hQOSsKtM7gteHGMuRnOW2LBFdYkgRu/mu3NbjK0E2wPguabk1HlF/3O94wIiBa2wFU/j/wBa/5n+U8/0oNAm9Hm0jKCMP2WwC4mZiVKbYViSUDkCl6LUc1H9zGqtesw5bZfxt4IaD9y1Cvbr3ZlujNAf+55WKjr2fx8+4z2BQHPET02LjrtT+5CF2sqsBHQ5xe86HdRHP5QOzslfzzPYtZp+6kD4tQ4351h/MqQVguICbQuq171vxxeO/KcA2GYQfQJdk5c4FBn6oqfMnalsFtQbQu9fpwBLMnw0GmkwCLj1jCT1wKz/u18MaS2SykLDeZ2DBysKc094Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWSiUuS2KHexgHF4bbdcB2XPb5DyGEB+oBuwnZaikxg=;
 b=vDKZgWbubiCZCQkfeLrpAoalf6ITGBU6tTZGilkx3C8/6E8Kch6wK4M4Re96zlTSlZKWPGKQ9zRojU/0sniQg3nFqrPRhEYIztcRk6igMqXfWiE/dygEEZohRhj6Dl5bk+kB5Vg0jvrPUrkSKqh79dWiiyr/GRmBcD+/246IOYgfqviN6PdPTHTOOExi645JeKyAr0oZ/evu1nNicuVksK5YlyoOrOb/c9kjC3JiQeY+PTVI9xkMWX2zyZLeDwQgyE6DGfB9vafpkvpsWkrZd4eJImxO1q0B2tObTYN79Ej1FKkmY+P/B6szOs6k2xnDlN2KqXZ6ZsyV3yGw4vsYIA==
Received: from PAYP264CA0019.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::6)
 by PARP264MB5805.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:52:46 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f:cafe::93) by PAYP264CA0019.outlook.office365.com
 (2603:10a6:102:11f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 13:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Mon, 25 May 2026 13:52:45 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id CB96320433;
 Mon, 25 May 2026 15:52:45 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 11/15] tools: binman: pre-load: add support of ecdsa
Date: Mon, 25 May 2026 15:52:37 +0200
Message-ID: <20260525135241.88348-12-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525135241.88348-1-philippe.reynes@softathome.com>
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|PARP264MB5805:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3290e8d1-a631-4de5-1b68-08deba64e685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|6133799003|3023799007|4133799003|17002099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1XW8i7sbqNEqihVb621Xo7Sz9An0AEtH62Owq4z7hurtGIaypopxWDBw6U9deRcH0iAq8KI7vwBs/J9FXIu1vgiM5IvoXkIxFNm902T9sRzoQ9xklHeg/0/us1SSPY1C+Iaopx9Pa7F10i4IWho5PEGuGpCUb/QKegKWOwzBHBit30jIB9I4dLqU3hIHHDU1qjWosezYOb2YkpgD4HsBd+UXpQf9KeZDvOayLjQRPmvfyRWTQENOD4iHteTEPrHD1LykM/vwPh+xaRlKW6NIe0pQb6NG6B6kIz7oaRIK9yVfgicxvQXq9UhsQhFYOfjUjBDRt58bl/4qfQVyIKD0KnCEcZn6YHmpyKGc+fY/vgtiNEakeHkNEd+OqVdgOnEikv6Kg7a1NcdQWZKcb8o1+xmU0Em8l5boVcrOW5bzt/uvVx5RqGtkwih2AY17H7h/N18Q+gr55jFdq8oFrj0bVZX7/GiLbp8qWE5Us1f9g5CVTUZ9JfGrgum/hxCgtfisAItCEf/GuDAB5vmlEXvU7NMLhudyYMQB0vQ3keqZ6RRz8FIxmKuXjpIHHGXHU9JiNcjXe28N57zH1Jo0SzwQaEf1aQspYorrBszF5Rs2yvuoQR1TEquKM5zI1VOZgiAHhNmqtjOiaBqnJS4mc1n8oBT/nP9aVNMiiytZ2WcSNj7IrWD4F27hrfLS0J9e5o0ivgk2OVg4aDkth1oR/qRC9QW4n3eDDPNXfYB3Ppod3iw=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(3023799007)(4133799003)(17002099007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CPEn8M7iIBQ7MBhBKuVXvLy4UdHVOxnV4WCG/EzhkqBfr7zuzA4ISlkUaLbuxSUqhdT6cQHnei8CgvdKnRHHodmqaPLmgZc/1d1NPynagdBAOViVjlOjWZ2+my0cPE4/nwtAlncGpQC6BoQsa18gUNz2/c53VJF09vdVS0m9Ikt7AZmHzMYbpmtliroQGP/uQT+/1RXYC9pMcRpHtt0OGFjtlFHv3rAxeOv4oYQJ9Sh+wu8vIPqBbCd6KEnTh4rtQH7G8ZK4GpCVeHroB91F4j3ZSXkP8Aj0fWrzCG4wljZGtrqTf5W6BDJvmHqKqMg15lXqH68HSP2EcDNzLucIxeVktlbzFeVoWzzOnDo6BY2XxnegfgkQYDhfMBqGMBKiRb79a0DytbSCGHI92cNw8oL5aPlipkyaIbtCf2bqVTE3sRtPupzNQ4krOvfdXvJF
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:52:45.9720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3290e8d1-a631-4de5-1b68-08deba64e685
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5805
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
v6:
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

