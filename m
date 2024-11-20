Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AF1D6C289
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D1238966E;
	Wed, 20 Nov 2024 11:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="ns3lEFpK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BFB488F6C; Wed, 20 Nov 2024 11:09:35 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E56895E2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itrUmbfbSLGovDm14K0hfTGBMSsY4th3w5vBBghJ497b+dXFbTEGXqXLcD0DrQ715XDMygc1w2/CKezQ1aT9kHlQKuUTPMK+vXx5vAZZEFWiYAUrn7l2Yh/0OIU/doMhvCP5gsvhhxuq/yeU9emytgPo5NrK075VuLpM8xlt1KftuJbKN9CiGUZJg1XXQ5MBayzKrU9um9nXOFs3cID+g5cw/99DLgT89y1aa1mi3xza+6hj+ykJD9VhpkXQtxejmnsO2eXl5WeMGOdxPZM8iMTWW0tawiELkZWGMbpWd1JcC5zDvNUtfHr3pKzl9ZXfjvrP6uhya0okJeoqaycSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbGi6KXv30rFheyKgjRuHKdl42yL03pY/Hat7HnnTfA=;
 b=PI+m2cpRHsJL+jIv7ejs4xlQJp2VrP888eAaSC5O0UlzgsmLR0Xr8n+JQAnROoQTLugsVHX+GlxWI+JETsbsvDUDU7cDwDDPJ11dWkpBuKtamJhYt65rgWh5PxJG9FPBKS2HyolwgYw5rc6glRApclV+h6NtRbjTduoaVUcZE8KmWd2ANZC42fd0h7olPcmE7W/GyfiL8i1PE3VnL/Z3QQ9NmThEGfCyMDCnH5MeKeFguFHcl2dp74ItOSrKH0FcIYgRLZXJlQmsv8iyEGvPBGPI/MyKY0/a8XAXJT2yUUcyMYatAezwvYemDdfCvL81fE5ioemdob2ZZVX6qJQOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbGi6KXv30rFheyKgjRuHKdl42yL03pY/Hat7HnnTfA=;
 b=ns3lEFpKUHfPLfLjeyqdB5qTIylBLAu1LedKoM9Ko285HST2CEnFPm05vLR6jDou4NLLJ5SnjdLBCf5hI5blF37q44Lrl1+5YZRw/4R9DyJk/KqWOXgGAcOwzKTs7ioiu5nrT7boQlcBPkV8+fKqTamFxKEOxVr57G/mGwwWpaYb5VC8FWvQyY8ytm5MyOrbsbwsQKzE2fgQNLzP/82KxNX4m0rVw3rYDBx1iCUzrbqRFwPqF8DQOPTKCuS7bnDG37IPb8irLZItOkwbErYXme+KK45AYTAPmbM3yr8IDZigolis4z4r6Lyr+XOO2CCU5na4cDIJNivaIVFZvlDemA==
Received: from PR3P251CA0004.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:b5::16)
 by PARP264MB5533.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 10:09:31 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:b5:cafe::80) by PR3P251CA0004.outlook.office365.com
 (2603:10a6:102:b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Wed, 20 Nov 2024 10:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.16
 via Frontend Transport; Wed, 20 Nov 2024 10:09:31 +0000
Received: from sah2lpt245.. (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id B7D682009E;
 Wed, 20 Nov 2024 11:09:30 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, al.kochet@gmail.com, paul.henrysd@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v3 3/3] tools: binman: Add tests for FIT with data encrypted
 by mkimage
Date: Wed, 20 Nov 2024 11:09:11 +0100
Message-ID: <20241120100911.885418-3-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120100911.885418-1-paul.henrys_ext@softathome.com>
References: <20241120100911.885418-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|PARP264MB5533:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eee5f1c9-6868-4b2c-76aa-08dd094b6cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Wqz7uShCfT4iQ1yLhwV5wQyqxwdkx4rKduPcraJ15rFXjEqc5pHPlx7vZLz?=
 =?us-ascii?Q?JdtNeAvS7gbxHKZZhl5kJujwkw4G8x+MlZu8v/fjDJ6WjRP3wamK/FuBUd0C?=
 =?us-ascii?Q?0kQJlDmW0e3ETsObBhDQ05r7ASwtPUGJxXxO9nhy7ywW231GqNmFdRGeUiBF?=
 =?us-ascii?Q?ZfgaJ47kTmVxSyB7kcpILVzzJlw4GXyty6nyiNGbls012+OdLiRiGPJ0KEgp?=
 =?us-ascii?Q?yvwfDxTQBvkRHH85DoFdvykC05qBJXWQjHLvrrsUETkl6Z7RNB2neJM2pj2P?=
 =?us-ascii?Q?a+KpNM/MJtT1VW4gavuDWMX7+f35Z3X/FVDiO+TPBmOzUQY7LqrO7DVY3OPC?=
 =?us-ascii?Q?ENmx0LfykefU1yid7MxZpxA1ghF3BXo7nIq0e3hln4k6Ar0YYJ9IuxhHW3TX?=
 =?us-ascii?Q?iC6vptGNPxFY2oafyV9GW3ABJacHM0BhB5QFLp9Fkp7Vxo58go7bJAqLofvN?=
 =?us-ascii?Q?TDhC4jP+7madeLASdCUgowKOjKubMSmlmsqJdLt0ne4qYcPLsjtyn43YiCZv?=
 =?us-ascii?Q?8U2icEL2SFSB4IFL59rujxBEs5OX8UBG9hnY3N9tiHrbU4GXXfW9DGkGv4ZM?=
 =?us-ascii?Q?Zmr8s1yAimc6+qSuHdNjxZbbePYFaSFLNayPPpuhA5tlZoeKUuBgj4q5o5oQ?=
 =?us-ascii?Q?sVh56Uah9QR63XlQjKh/vOT+jGGmYo8mMAt0tOabfgfgpa2gFwK30zVdJTPB?=
 =?us-ascii?Q?N41nP0+vqQamwL7nJaoZ5AlU/XcASrShylNTwxyMwTOhNJPIzx1g+GOEAAEk?=
 =?us-ascii?Q?cTZZIxOnNTalTBtsHUgKtPegz9DUtbxAr4SYJBnLLS0mw/FlELUnRymQGDAo?=
 =?us-ascii?Q?zodnHE7hOju2B+n2BXljsh6oQh1R+EOP0PyNm1t1J8/vf2kHil52HXfXbm56?=
 =?us-ascii?Q?iss/4u13v1q6Gx3D47Oby1VX8utr7ZEWGEAlThVjbF7RmTwEvDzra6sW7hU5?=
 =?us-ascii?Q?H99HYl6Usotls5VSc5yvCiCMUBdgIT+RyyEcFhytgAYfht4mCoPBPCIhI4Vf?=
 =?us-ascii?Q?uoWXC6VOQxNYbfSDpOE4UISHZ8oOCDvCwuossaF++iUm79zmjzIDBu+5Qpen?=
 =?us-ascii?Q?Sku+Cc/8Zqw35aqq62i2Dkb20c1Kqs3cqn5PcW/adi4glZ1TPRnbHf0Xvw+D?=
 =?us-ascii?Q?UmXHIFvqDLjHE06q1kCVtYBM4jPSNj/nKXShWu1B3IpDtzF9Yo3CblgLPH+6?=
 =?us-ascii?Q?1r060nNVl3Y2qgZusoIvTzc2JNryLpS7jUA7ef7JufLoklSNI+ofMtzs28Gj?=
 =?us-ascii?Q?SaadCeVbJ2EMZpufQFYilH7VvFHcchmHP5bX05BThNuTPPmGdI9slUHvHisu?=
 =?us-ascii?Q?wbxzavzHMe4uOHOjTbCDI4fZnFMJa3FbGPEdoxtDeNozA5SW9DoI8MQ1kxMK?=
 =?us-ascii?Q?SmhqPMFugl7PngYu0wN/DNBMr7kadqxYqs1Knbdfi5nUs3qUjQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:09:31.1691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee5f1c9-6868-4b2c-76aa-08dd094b6cfc
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5533
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
Changes for v3:
 - Write out IV in full for clarity as requested
 - Do not replace the null byte but use fdt_util.GetString() instead
 - Adapt the tests for the FIT data encryption to create a file with the content
   of the AES key in the working directory and pass the path to binman

 tools/binman/ftest.py                         |  45 +++++++++++++++
 tools/binman/test/343_fit_encrypt_data.dts    |  53 ++++++++++++++++++
 .../test/344_fit_encrypt_data_no_key.dts      |  53 ++++++++++++++++++
 tools/binman/test/aes256.bin                  | Bin 0 -> 32 bytes
 4 files changed, 151 insertions(+)
 create mode 100644 tools/binman/test/343_fit_encrypt_data.dts
 create mode 100644 tools/binman/test/344_fit_encrypt_data_no_key.dts
 create mode 100644 tools/binman/test/aes256.bin

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index adab65e579..b19b0cc5b3 100644
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
index 0000000000..90e504979b
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
+			fit,keys-directory;
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
index 0000000000..90e504979b
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
+			fit,keys-directory;
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

