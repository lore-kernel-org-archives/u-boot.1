Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26416D58D71
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEDA589A5C;
	Mon, 25 Nov 2024 18:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="icQ6657P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B3589A53; Mon, 25 Nov 2024 18:47:30 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA61689A57
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewiBg2TlKm9PXtoB1WbP8HLxFiBc+OlhujxQRYr3lm8nDhII6ws3htctz4oNjkZ2ILeYoKknonuYU8UfgEprpa6YqkzVqzv3SJ4i9hSUXKe54WP5oCznwdumz+CXSm+cigt952OVJV3S+baJHt6YIs4EMLDJVAsG+1RbTV+cfE7DBxeEM8Qsn3rZ+IGEbvh7xpVqelE8E6fY5UuaJFxkGNSWTY2bbuhyLeuXdYpVbiTAblubKiaqTRm3Pith/kYxcGT0/ZrS93eMmvRGDkKaM58tGk5VCkSfs3neP9SaJy4djx6NeRTOhktPlw3wgM8/JUpzxTidR+dFfcQ69C1Cxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3OiqgOlIaiKdjcBxlIS8pe4/zHDI2XoYB0IIN7xBns=;
 b=vTgxfmreLZONFORhjxhnQSdICQ+RuIsGzGBNNSBfMz78vfFnA7yi+c7bu80F5OHGvhNnsz1KSGcNcvvSB3UpVcvsmy+v3Em2e766Fk0qv9vovx+3prtU7XLH7OAGCo3lQ1Cf7kZ87tNxgFeT4p7SZOThmLJ1GP6Fohj5Vw4DCr86/yFvBhD2QNQpFcBvZ7UEK+kNjCyUjrnl6tBDdCXnHYyEvhJR35VSURj1Vtt8naPCCmColuZuC5S5aWY/l+8arAtS0CbEOerCiPgZJSQxDioF0Sm/2fhTZt5uWWRrp/MgvEcmnx+I8wgtpMc6FkWVRF57Lh1xRhfVwwlumMiZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3OiqgOlIaiKdjcBxlIS8pe4/zHDI2XoYB0IIN7xBns=;
 b=icQ6657P+m9wDpxIjkX05VfZ993JWmZRLmNPDOeWfAeEWY1W8CwEzWmZW64YENsL27H7VWIhF70NlWBGvR9P2k8mRpImZHzIMMbh+Rq7DfTVnbS5mnLGYeIqrupfZ0DnvtAoPxuGNjinpceRU9PwYdtH80LegZYbkgU3H5OzbspdxAvbireQvvHySr2CpjpHxruxD0B+MpxvsKAG/F6VjYGZXlBG1bW1cUvdyr+PFQAvvhoQTokcztCTx1HP/KlvazZILcTUrY5R9VKNRqoII1yPoa45pN0wUymPSs4zPNZvXP7fi+NY7P5nry0kE58qgNM793JcHD4mw56Z4KlfGA==
Received: from PAZP264CA0086.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::16)
 by MR0P264MB4525.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:66::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 17:47:25 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa:cafe::40) by PAZP264CA0086.outlook.office365.com
 (2603:10a6:102:1fa::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Mon,
 25 Nov 2024 17:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Mon, 25 Nov 2024 17:47:24 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id 6BB2820323;
 Mon, 25 Nov 2024 18:47:24 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org, al.kochet@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v4 3/3] tools: binman: Add tests for FIT with data encrypted
 by mkimage
Date: Mon, 25 Nov 2024 18:47:17 +0100
Message-ID: <20241125174717.1181452-3-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
References: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|MR0P264MB4525:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5916e319-60e7-4d78-402e-08dd0d79389c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X5IafzbQ6E4I94LVIm2p1YAlNsU5ZW7wI42T4zallbHMdE442b58gxpg38MF?=
 =?us-ascii?Q?9zK/wBwSkxbMPCW9LG+u5f+jFSXFBoJa1f5BtVqIPio0GYtiUqCYMO8xBOVz?=
 =?us-ascii?Q?Pm1fPWJleWbZpR2phdhLzahYTKCExFlwygXm91kG3WEc3qJEqXeUHokAQfbf?=
 =?us-ascii?Q?V+nySUOXYnTcZKRue4LwIC0/AfLyOKzHdqMWqbLgc3le6NyfM9wmiAt+zmDe?=
 =?us-ascii?Q?qKWNFABhBRBswSBEDt2nwnizoQB2WU48cdEo3tCx513XeAiSbf6W1SNk5fPr?=
 =?us-ascii?Q?ojwUdM67lpbUhYyLQ81Hygs99gSS8RK22gzA1og4csoH6i47BOp46LZuhtKi?=
 =?us-ascii?Q?r/Shr8YEEMJGCb9Uc2lxOVFNdLyN3/RZMtOy6MT+Hiaoz6K6HdB/61uCbi52?=
 =?us-ascii?Q?3LKFltQV7dufXJBCg2QOq9xEw5fnSuN1GVLPmk97To8xvfaU5FwMP/fGQJei?=
 =?us-ascii?Q?qXm8K1d2my1NenjiGsn1ZOnC90AuJDjtv3HPs9m7eAqi6bE9yYmOAfdCBOXK?=
 =?us-ascii?Q?Ng8ZGN47qc+7AF1dYTH+igAyvj2x0OvxqCiCTbN4Tg5cMfSVmDpyRZUkzyb9?=
 =?us-ascii?Q?McjtHrk6B71hmDNM12GchsYwaPj4v/vkveb7xKQq11BegabHk/COAiTv+X1Q?=
 =?us-ascii?Q?O/+hfQsawx0I6mDDiW382EwAMzUFhOWlieT4HNpRFsZPpIyj87FrVDkwubvS?=
 =?us-ascii?Q?UG4SpNeJWe+8eITJ3HHXRc5up1VXKeBK2cqnVxoGZXpKPqkKLOot4H+OzLzn?=
 =?us-ascii?Q?nWY+TDwTw/JHeG/qe+9mnn+6n95McqfcMIGzMzkIpCGjuQfMl2ELSa065qKV?=
 =?us-ascii?Q?8uX9pTkXqok80wzlYELdfuTMMEUm9TjA2WCgLBZmlTruvBE0Xi20WARNHU2d?=
 =?us-ascii?Q?KYKwSs0CIZegQ07J4KWNixNbFbzhVh617wlgqTgCAJGZtVu/TodaIn9BSiLd?=
 =?us-ascii?Q?G4jruio175xgn63DcKmfgZPTSo3ZdDLwD+LUePrUEkw6YF6Nlh0eXwMiNAwn?=
 =?us-ascii?Q?OrigQPghLOHMKfonQaaKYxZD8PqfxO3Y4/N2CxPa1Ln6NVgq2J33Smb5Pqf5?=
 =?us-ascii?Q?s5b0IMxBvOeH4zmkAhZWi9j7Y5l390vKWGN/IZwfAqplYyFOkl0VoCFHsUqg?=
 =?us-ascii?Q?IDGjcJxWew1MSJCYEAQ/3o7nKe0ykBFXJC1hV+cFq72el3FQj7nmIcCLhmzR?=
 =?us-ascii?Q?QHzzVCWe/EOyTJLRmPyyVVlLEMQW5LfnqmqKz/25glEjI6k3DlHmEHvmW62R?=
 =?us-ascii?Q?u9CYzEKiFLf0jOk1fFYW/rJa2K+0AZmaOhvFK8gokeqHBudrLD6+prSnnv+X?=
 =?us-ascii?Q?6VeK8pBF1EWREkSLd7GI5KBuQNSXXwbS2mVE7TAV1oIh2kQNCB0ZHcnfX9cw?=
 =?us-ascii?Q?j5cTERkjuitWU5BRMNuRO5ciM5SxmqmiLa0u7n3cDbR4eAtn296SlseCck9U?=
 =?us-ascii?Q?yejybBpioO3caizKUfQXNoQbQhbCUnMv?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:47:24.7977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5916e319-60e7-4d78-402e-08dd0d79389c
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4525
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

Test the property 'fit,encrypt' to encrypt FIT data.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
Changes for v4:
- Update the tests to use 'fit,encrypt'

 tools/binman/ftest.py                         |  45 +++++++++++++++
 tools/binman/test/343_fit_encrypt_data.dts    |  53 ++++++++++++++++++
 .../test/344_fit_encrypt_data_no_key.dts      |  53 ++++++++++++++++++
 tools/binman/test/aes256.bin                  | Bin 0 -> 32 bytes
 4 files changed, 151 insertions(+)
 create mode 100644 tools/binman/test/343_fit_encrypt_data.dts
 create mode 100644 tools/binman/test/344_fit_encrypt_data_no_key.dts
 create mode 100644 tools/binman/test/aes256.bin

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 156567ace7..92c6e59285 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7900,5 +7900,50 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             extra_indirs=[test_subdir])[0]
 
 
+    def testSimpleFitEncryptedData(self):
+        """Test an image with a FIT containing data to be encrypted"""
+        data = tools.read_file(self.TestFile("aes256.bin"))
+        self._MakeInputFile("keys/aes256.bin", data)
+
+        keys_subdir = os.path.join(self._indir, "keys")
+        data = self._DoReadFileDtb(
+            '343_fit_encrypt_data.dts',
+            extra_indirs=[keys_subdir])[0]
+
+        fit = fdt.Fdt.FromData(data)
+        fit.Scan()
+
+        # Extract the encrypted data and the Initialization Vector from the FIT
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
+            self._DoReadFile('344_fit_encrypt_data_no_key.dts')
+
+        self.assertIn("Filename 'aes256.bin' not found in input path", str(e.exception))
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/343_fit_encrypt_data.dts b/tools/binman/test/343_fit_encrypt_data.dts
new file mode 100644
index 0000000000..d70de3426c
--- /dev/null
+++ b/tools/binman/test/343_fit_encrypt_data.dts
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
+			fit,encrypt;
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
diff --git a/tools/binman/test/344_fit_encrypt_data_no_key.dts b/tools/binman/test/344_fit_encrypt_data_no_key.dts
new file mode 100644
index 0000000000..d70de3426c
--- /dev/null
+++ b/tools/binman/test/344_fit_encrypt_data_no_key.dts
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
+			fit,encrypt;
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
2.43.0

