Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A831CC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 13:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A008892C;
	Mon,  5 Aug 2024 15:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="hPMbHLlA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D6A788913; Mon,  5 Aug 2024 15:35:42 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 073D88891A
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 15:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nj4LC13wJnXsKj+3dHtG6JpPGGkiwxqIi6/48CW5D2tBlhOqm1HGgXQo2qkyxlRaLGJdqmbqDhYmXzIN+KOWUkDP4Ss7goX6W5kjHxDhkjF1L6rKfTBBBPZGiZB+2MYeDptvk2vb7oKtQPR3zLCuuxMxJu94ZwG/hQd0yb3kRG6U6o8MAVYwQRsr7WM2qUYiMEGJ3YVsgtsqIQvIlbQtmIBorez3ywyDlbdDLAUlWy4pR330jJAlzFALRmS65cbp6Jc4cDyZFBJBQkmNOavG8tcqlgZqFqKTbW9yQj1dld0aTAQWeJAeoeaYDBPuMAFbq6a5AXlvINCwrfSnDXaIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPKaLklXgF7RWOA2TwlSDP7nXTX5CLxBh/ar0BJZv+w=;
 b=pTwa/DMm3aA95q6kv8B6HLM1BGEFvAF5fGZGSK2J8g43B2TKkqt4P7LOPHejQcTYBd8IV6MgVdu/Oth3Lmi8Mw6FUogBLnXygIwLkrZnlzXypJrS762gMVGuePO71JT4Y+NPPwgFYMMuinc4v4d8kswUb399FMQJo+mqa1+BWE8RXfAwDqqPICAJCajXKKgGH9LYuSUbk3pl0LBe+JJI975LwZwIV38rymo2BpHR8pLtv3IECP07SIIwRft9De8QBCdXqkHNjbgvJirgr8k8PrCBmZSR0aFYsY1qewwHYYBsCMqYVxvHOlamAJ6yQkNdKjG+5CK8yc/Kh7r9qmqYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPKaLklXgF7RWOA2TwlSDP7nXTX5CLxBh/ar0BJZv+w=;
 b=hPMbHLlAolJMx0jAY2J7T56HlYTNfpJshWUFBb1auqOlNZyFyYzkqgcc9Rr1jlGcEyu8gJYDDeLkGlxMKaCVrIQF5ArA5jUJYYkEnn3AWyNjDKxDLQqE8Z5qKeVm1pYvFcaK/bDAA4IYrxuc5tRwtIXJoyFANoOs65SQw+YiQCbVCknA/GKxxiIPR9FyN0+G0Q3u2Xo9xA4gWIRj9r+K6qATJvQ/KDgRZyWexhUoNrw66+xbj16fbn3GOoYoCI1WsES3vfI6UZ0GSUwB46yhvwKiHnqN7m1yfr5b0brGrhZOEtiXxv2nrensZWVx0Rp8hmZB5BcrnpOj74TvwBsKWg==
Received: from PR0P264CA0250.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::22) by
 MR0P264MB5448.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:61::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.26; Mon, 5 Aug 2024 13:35:38 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:0:cafe::22) by PR0P264CA0250.outlook.office365.com
 (2603:10a6:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 13:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7849.8
 via Frontend Transport; Mon, 5 Aug 2024 13:35:38 +0000
Received: from sahess08-ThinkPad-T580.home (unknown [192.168.18.10])
 by proxy.softathome.com (Postfix) with ESMTPSA id A5C83201AB;
 Mon,  5 Aug 2024 15:35:37 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org,
	Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 3/3] tools: binman: Add tests for FIT with data encrypted
 by mkimage
Date: Mon,  5 Aug 2024 15:35:20 +0200
Message-Id: <20240805133520.1745316-3-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240805133520.1745316-1-paul.henrys_ext@softathome.com>
References: <20240805133520.1745316-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|MR0P264MB5448:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1c757b0a-d277-486f-7776-08dcb5537e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wXsdWg8Hn2RzSxql5B84WYf50KsHoBrwNnq0QoYyGbYUbUlXPVPbcFqWvETt?=
 =?us-ascii?Q?ievFBPP/6AG4aBIYZW9NGfcCw5z0DaEK61JwpelAeaopC6zuV6v8T1HwwS1B?=
 =?us-ascii?Q?OP0aWz/Udo9FlF2WM9oyWLlBQCOhSWCWyOxIeTbhrZXtoiezDV1wHrqgLv3Z?=
 =?us-ascii?Q?2O3/sXDQ0y0NiOzm03ZgKSz+u0vGCpbRuputdevydsPpxdH5tlc4bOYsGOi7?=
 =?us-ascii?Q?j11O2dnfY7yreky7c2+iyog2EFCGHF3Yv1JzTCw8I8XXLhZIKQvrd/c/3/+h?=
 =?us-ascii?Q?YdVwpQ7OT61/+TAKb2kszsZ0sDtoaLknN4CujqCi++8IFplg0mkzPZ+Ua0Rk?=
 =?us-ascii?Q?rA6sszqxr0k4vYyYqPwdEfHPMGqxsal807NYNLRNM0Oci8BwaC4KFhYMI6QC?=
 =?us-ascii?Q?SoDbpoHYpmt92CHQWbNyaJtFIi6GnBIi1yvbEuS/TUWv2tBgqrWLYRjbeD0l?=
 =?us-ascii?Q?7//o4r1fmIaVv+BbLJ0dXNg8gi0slGc9vYleObAw7HHMsdgBOxc6URrhhLmj?=
 =?us-ascii?Q?DyZeK/fuMgMr8dioDAg1Z/t45xELwi0iCj/FhI/WTXo6knkMRNxeSViHcfip?=
 =?us-ascii?Q?Hy0TSHjcdsggptKwLGxLJpOnBArMglFRK7vPPEHzQlZe9RLPW/h95g2Fcf5G?=
 =?us-ascii?Q?y8hklgGUOB2D9iLNTAaeelUhaYQKsx2YOXgZ1AFkvRuIWDTtZXQB4N8O1Yj0?=
 =?us-ascii?Q?uuSOLfMb2ucD2Wyp4s+fMxtEdOUQSppabysZaxnyVkaG8LVgZhY+py1w4s4+?=
 =?us-ascii?Q?1yEtvdwX2BH9scnNdGJk/jfN5YLbwyn9XN7C6Iajdcfv/uyF62nrVGr64a9E?=
 =?us-ascii?Q?ZoSGJ9TWspTgCzCv5vj8A3UB8SFygjtajzuffCAGjmVh9Lqn9Hmqt3SIXJRZ?=
 =?us-ascii?Q?uFUvbq/BMn3LGvPelu0CdwALEOiivI6XezZ4pBPGQqpNU+uxD+SPHWfa9xaR?=
 =?us-ascii?Q?2asO8VZIfLZN/AMv2fbY5RZCUm4WVJXrvfqAu21MDXmuzxUUFI80vnOBmgiZ?=
 =?us-ascii?Q?VI/+or+lzUF4xVHozJPCAbthTKsz34yRZfS7VP7asqxZ0mZHy0pam4fdEgJ7?=
 =?us-ascii?Q?+8YHVIXa7ju7FIH3bp/RpeBCeMhdzKubCIGP8S9Yu+iADS7OT/zhtUdqK0B8?=
 =?us-ascii?Q?/S/jG1VnAzanMb6YNzhhgZmlGXrV/TfKx1ut0JUGAVwhUuCFSdhjYYt2SZFm?=
 =?us-ascii?Q?OQi9EcIHW7GRZ5QaJuVfPQQkdhpP/v+Oa/9xRO8pk17L7OjG9n7TLPOs1FkR?=
 =?us-ascii?Q?wMzm2rgsdutZHgyZewL5jJGzj5Bz7B6M4CAh/gIGMEsboQtXJsJVOK6zWg6i?=
 =?us-ascii?Q?v59uMERQvmVCei1J7YBTY3xBS+fPZ9z3756qAdRyQ/h2slgoFMbMN8X5qD1U?=
 =?us-ascii?Q?Ml1iePwDb5ACxGbM3WR1dmDqGJCHO4S8Og9cwP6J9MCRp/aPYWHD42sC1ILT?=
 =?us-ascii?Q?IjMfWla3jOxLH7NfBZk91NN06u+tWjgj?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 13:35:38.0237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c757b0a-d277-486f-7776-08dcb5537e01
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5448
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
index 93f3d22cf57..64b7d0231de 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7691,5 +7691,44 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             self.assertIsNone(dtb.GetNode('/node/other-node'))
 
 
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

