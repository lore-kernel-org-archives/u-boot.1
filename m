Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8567C25B79
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 11:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A5178865F;
	Fri, 24 May 2024 13:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="lgEWQKYB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2CC0885C5; Fri, 24 May 2024 13:23:32 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDBCD88653
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 13:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAbJ1PZpSTk8+aBtraXYoKO2T37IGO/QT6QBF25MJwOJNRfhxyWIxxbAIrXv++Po/K9NYPWQ8DQSv7chAjR6VugwtmyFLhEtmbr9JbNS8wLGw5KNm/eG4G8GeNLwhGEqAkN32xQVQS2q4VPPkxv2wDOXbxvx9PtQdkI0aNbbfILESvIkg4oyPobtUw/si+ZhR5bFDw2IfhHEvZ6TKGlaXYR+B0ECuaXrrMFv5IpbUEtchtbgBAawC7Ba6VnH9jjpBJ9LxSRYQkP0Duuu8/86TSD48CNaZaZlwTOQOgLhlYmfou5ER/oKYp8Isv2bPT0oN8VXafrjaOdA3+TE62FnbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUnpK4G2Azw2etoDQkSxVxmEkwe6grRGQ/bqs80vFHA=;
 b=n5tCa527shTvZmci/K+T9OVfqonXq5IFnQg+0k93Q1aFxCq/l7xzXGVlqYKzifzf5s00hXs22K9uLUANxxv4cTMYl+LiEjrqRLN3dU/t9isfQBCOURd4fr3v6ZXE9FlAc9oW+SxCuuOe3fnhEVP74DcKm8p9N5sdKXJQuWpXJ8VdLe9hSFbieQ4IlWg3Tx+OtPfC8eq3fb7l0+iUJeVPVkfYAVU/2qDz7IwAwobUhoYJJ5Hrs2vuSpOKusJxYgCKdfPb0aqG08wLIP8VJP4PWh9f8oPbMn/ECFk4us1Busbn3edad1GxxVucqt5TuX8ZW+S1KD61/BynEwpeUQTrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUnpK4G2Azw2etoDQkSxVxmEkwe6grRGQ/bqs80vFHA=;
 b=lgEWQKYBRhm2UyaayzLh5dQ3QYv7ZcK1sgCMz1GsE2G7j2lqU88ovWnCsDzNMmfYVsL6PkVOdgbW6BBXs3bxm0VKcg+8fiT3uzTRHO1iOg1Ib99e4sbH9RZhDabNMP/9vBOIPYa6VZhfl/OaUEApmKSdK8+N2ZcfT2OV6uxk3WRSNbgOhvWqtO3KYgVNRpN+nhePJ6CivwBTwo78UJWeLEekfbV1dxkGPLJaBbnsoJE9LjPe8x3LGpYkpYS1XADbS/Ig05tAsiCVrYPDfGEgc3VEu35tYDmfProhydQSFx4RIW9jjWh7XCzxBzzSvS4Wp1DgCHLNDfBRdePDZGJLQA==
Received: from GV0P278CA0068.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2a::19)
 by MR1P264MB3154.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 11:23:27 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:2a:cafe::68) by GV0P278CA0068.outlook.office365.com
 (2603:10a6:710:2a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 11:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7611.14
 via Frontend Transport; Fri, 24 May 2024 11:23:27 +0000
Received: from sahess08-ThinkPad-T580.softathome.com (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id 4323220067;
 Fri, 24 May 2024 13:23:27 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 3/3] tools: binman: Add tests for FIT with data encrypted by
 mkimage
Date: Fri, 24 May 2024 13:23:20 +0200
Message-Id: <20240524112320.103304-4-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240524112320.103304-1-paul.henrys_ext@softathome.com>
References: <20240524112320.103304-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|MR1P264MB3154:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ba439205-7111-44fb-3ccf-08dc7be3eee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lZ/FUsvzJx6ME1GzteOeVE7bgeJT4LZhrhQsqkY3n554v7xKw/tDS0tLQ9jX?=
 =?us-ascii?Q?zV1MWKcvsddmzxbsbOEDFCIhzE/ig0gUtWRsEcmEyFgNAs31oPiVwCi4gRXy?=
 =?us-ascii?Q?kF7HWVpowuuP8Wp4+ATYHQqF1SpPy7yJaEFnL5pcKS8MBGJQ3kHYd6etrlFY?=
 =?us-ascii?Q?UtzXINaZs191F6Y4JRcNvQwigXHurVBNbEiTiLf78HxVQQGjtUYilPDGbYmZ?=
 =?us-ascii?Q?7acNxMuP36UrdlEcJJeC0ivrgXrws5UGd5YjgmTWaUM4cB2aFNQZpXmZtoyQ?=
 =?us-ascii?Q?K0a2YGMOTK0K4L7l4JA1J7GqZ6iB+uEnoh6BfVsBvxV5OXwmNfUEB4dtZs/g?=
 =?us-ascii?Q?zSLdN8OzY5rfdUNT6Kii7mFc7h1+Z72lSS0zCjCSh2RqiZyhBpsWC6F4lhC1?=
 =?us-ascii?Q?QlzWMGitKW88+bjHLut/sfO2ZLEKYEiWwqYmZqrrmS1Wlmsu91r67KVUlVmS?=
 =?us-ascii?Q?KEJ4JA9xMSTJsnnkmEWa34ZkRPkLaaNS5VcfOKsBRHBf0o1EyaLSU4tRsxni?=
 =?us-ascii?Q?0H2Ozg8mLIE3OW4q/lgDkGpz7MkpLrSJ2uYA02TGSfj/3C1+ztDWW99+OG8C?=
 =?us-ascii?Q?9AUiIvO9TzI8FkISpBOTwDW7upLlH5V7R/Nj1U0mk6hCZ/3FhbaGIda7YXlU?=
 =?us-ascii?Q?9hc28Wr0kJ2cW4oz/EXXjhJqE9aOxEbO58hqNq9TJk3r+cVxFmo8YdzivdqX?=
 =?us-ascii?Q?WPRL57dv22Dh7i++W0tu25znIcNRJq0fTPAvkmhqyDtqtH685CgCT+ySKj7s?=
 =?us-ascii?Q?gF95c+F66sITXShh6i4gz9U71kkf6tZNaiD3yFJk8RdprGpk+hwm/ssdlaSy?=
 =?us-ascii?Q?eH2WFGfkS2k5vbI60ErMv6tILlWmzaGFHzwn3DCcIcPiVhkcgxfffiPipDDN?=
 =?us-ascii?Q?AWwx3VqS1cNRO3i7ES0C/Oup669c/9QyK5+Tn3zdBYqX8mw/N1hC+BCcej2Q?=
 =?us-ascii?Q?BMFW9GeRQelyr1UDpS0Bwo9CVto2IdjV7yT/RDoaZKg00VXk+OcJTv2Gmyml?=
 =?us-ascii?Q?62va9fnTGvpxYUrLGlfY6682fGfZUsfrbQHcebglc22hrs7ZAabCFqcZ7N05?=
 =?us-ascii?Q?5E8fCzY4lKJUXJvZXKVJ+8ZzpQkxIS9y3AAWQ/hqsoEHWYNOrvLbPpw+LOfX?=
 =?us-ascii?Q?f8T1ZEVfPiiXHOJrMyZDxW/MHtzpo3vhGZqL/gGCecdAoT7XrrhHfyd3sXJ5?=
 =?us-ascii?Q?UZzsbv72TduVOWc/nMayGhhOz25M9QFHzfyP8OusQYBC5InPplM1oh3BKIzU?=
 =?us-ascii?Q?FoqWw7BXHfyKIeMnikPXxFBGLBifI8G+XVjuzWhglCp9ufVnA01S3AcuZuGZ?=
 =?us-ascii?Q?KlvDZ+PnDcVoaUvBVGk7m0EHoVqgdpyAkt9sAL75tcFLtuf6118NB9fKku+g?=
 =?us-ascii?Q?LSZJftDlTZ4taNJd/S8H+bPI/80q?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 11:23:27.5354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba439205-7111-44fb-3ccf-08dc7be3eee9
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3154
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

Test the property 'fit,keys-directory' which, when a cipher node is
present, encrypts the data stored in the FIT.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/binman/ftest.py                         |  39 +++++++++++++
 tools/binman/test/326_fit_encrypt_data.dts    |  53 ++++++++++++++++++
 .../test/327_fit_encrypt_data_no_key.dts      |  53 ++++++++++++++++++
 tools/binman/test/aes256.bin                  | Bin 0 -> 32 bytes
 4 files changed, 145 insertions(+)
 create mode 100644 tools/binman/test/326_fit_encrypt_data.dts
 create mode 100644 tools/binman/test/327_fit_encrypt_data_no_key.dts
 create mode 100644 tools/binman/test/aes256.bin

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8a44bc051b3..b3110550c01 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7460,5 +7460,44 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         with self.assertRaises(ValueError) as e:
             self._DoReadFile('323_capsule_accept_revert_missing.dts')
 
+    def testSimpleFitEncryptedData(self):
+        """Test an image with a FIT containing data to be encrypted"""
+        data = self._DoReadFile('326_fit_encrypt_data.dts')
+
+        fit = fdt.Fdt.FromData(data)
+        fit.Scan()
+
+        # Extract the encrypted data and the IV from the FIT
+        node = fit.GetNode('/images/u-boot')
+        subnode = fit.GetNode('/images/u-boot/cipher')
+        data_size_unciphered = int.from_bytes(fit.GetProps(node)['data-size-unciphered'].bytes,
+                                              byteorder='big')
+        self.assertEqual(data_size_unciphered, len(U_BOOT_NODTB_DATA))
+
+        # Retrieve the key name from the FIT removing any null byte
+        key_name = fit.GetProps(subnode)['key-name-hint'].bytes.replace(b'\x00', b'')
+        with open(self.TestFile(key_name.decode('ascii') + '.bin'), 'rb') as file:
+            key = file.read()
+        iv = fit.GetProps(subnode)['iv'].bytes.hex()
+        enc_data = fit.GetProps(node)['data'].bytes
+        outdir = tools.get_output_dir()
+        enc_data_file = os.path.join(outdir, 'encrypted_data.bin')
+        tools.write_file(enc_data_file, enc_data)
+        data_file = os.path.join(outdir, 'data.bin')
+
+        # Decrypt the encrypted data from the FIT and compare the data
+        tools.run('openssl', 'enc', '-aes-256-cbc', '-nosalt', '-d', '-in',
+                  enc_data_file, '-out', data_file, '-K', key.hex(), '-iv', iv)
+        with open(data_file, 'r') as file:
+            dec_data = file.read()
+        self.assertEqual(U_BOOT_NODTB_DATA, dec_data.encode('ascii'))
+
+    def testSimpleFitEncryptedDataMissingKey(self):
+        """Test an image with a FIT containing data to be encrypted but with a missing key"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('327_fit_encrypt_data_no_key.dts')
+
+        self.assertIn("Can't open file ./aes256.bin (err=2 => No such file or directory)", str(e.exception))
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/326_fit_encrypt_data.dts b/tools/binman/test/326_fit_encrypt_data.dts
new file mode 100644
index 00000000000..3cd890063cd
--- /dev/null
+++ b/tools/binman/test/326_fit_encrypt_data.dts
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		fit {
+			fit,keys-directory = "tools/binman/test";
+			description = "Test a FIT with encrypted data";
+			#address-cells = <1>;
+
+			images {
+				u-boot {
+					description = "U-Boot";
+					type = "firmware";
+					arch = "arm64";
+					os = "U-Boot";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+					cipher {
+						algo = "aes256";
+						key-name-hint = "aes256";
+					};
+					u-boot-nodtb {
+					};
+				};
+				fdt-1 {
+					description = "Flattened Device Tree blob";
+					type = "flat_dt";
+					arch = "arm64";
+					compression = "none";
+					cipher {
+						algo = "aes256";
+						key-name-hint = "aes256";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-1";
+				conf-1 {
+					description = "Boot U-Boot with FDT blob";
+					firmware = "u-boot";
+					fdt = "fdt-1";
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/327_fit_encrypt_data_no_key.dts b/tools/binman/test/327_fit_encrypt_data_no_key.dts
new file mode 100644
index 00000000000..b92cd2e4bd6
--- /dev/null
+++ b/tools/binman/test/327_fit_encrypt_data_no_key.dts
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		fit {
+			fit,keys-directory = ".";
+			description = "Test a FIT with encrypted data";
+			#address-cells = <1>;
+
+			images {
+				u-boot {
+					description = "U-Boot";
+					type = "firmware";
+					arch = "arm64";
+					os = "U-Boot";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+					cipher {
+						algo = "aes256";
+						key-name-hint = "aes256";
+					};
+					u-boot-nodtb {
+					};
+				};
+				fdt-1 {
+					description = "Flattened Device Tree blob";
+					type = "flat_dt";
+					arch = "arm64";
+					compression = "none";
+					cipher {
+						algo = "aes256";
+						key-name-hint = "aes256";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-1";
+				conf-1 {
+					description = "Boot U-Boot with FDT blob";
+					firmware = "u-boot";
+					fdt = "fdt-1";
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/aes256.bin b/tools/binman/test/aes256.bin
new file mode 100644
index 0000000000000000000000000000000000000000..09b8bf6254ada5c084039f32916bc7d30233bb2c
GIT binary patch
literal 32
ncmXpsGBz<aGq<obNK8sjNli=7$jr*l$<50zC@d;2DJ=s4pC}7U

literal 0
HcmV?d00001

-- 
2.25.1

