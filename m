Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F88D35173
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 15:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DCF583CE3;
	Wed,  1 Apr 2026 17:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="o5r2C6Ut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E64983CF5; Wed,  1 Apr 2026 17:35:40 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF87180517
 for <u-boot+nodisclaimer@lists.denx.de>; Wed,  1 Apr 2026 17:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjY7/Kc3t2+KgFVV/bcyyMBELcZ2AljYBAlBkyTToGoBzFcjFYQPVSchsWVVTUsmav+UoBoTLVIjXWuOD5y0609+j6iWgMQG/b7nSrSrBzKydSejx8YIhRR+quJBcgEkzkvzyJUQW7itd6ryoT6JdUPBxojrofmfbe5g4iZ7wqXubx4YEpaROvmHvYrDSayfdVVhyZQPF0VV2BWRqAWHOlT0GoOsTfAJGpNtG2K4YYOy1O034C64aNj6yssfUyObJZw1kAkkIExwU1485vn8vPFAVFYHX1bE1YnGNgucbNt4pVopwcpbZF3KrwFCbedLGpkOr36soRm4QOgL4ZXw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zE3h/ehRaNz3k0teU8N6zMmtftfn0Z2lwVGDMSTjcU=;
 b=R+LZofWFP6SKP6UY7v9Dgpy7dx24cXBEx5VEuSJcJS0Q8z8zuDGzaTipBzbLLZlhEAhCWglU9GX5QXbF4YkwF4I1fv/m4hkT4HlAwwQM1gx/mslLVG+htXL71weaZkZvh4JR4HW/r+ZieeYhF4a9i9hIJg7D7fRMtpuN4IFsUbyQjl4zX2S2vaHuF0ILOv37RT6ibwHhmx2QZudEkO935FW6Szy8xcB8kSkZwuA071GQla3L31tPWghQr9USz9HDdAiFN/Qh5Szhg4aI1u12GUJy+rgr8ML1ynvvUJolzvNaPF4ttDj4jJWeEBWVsvjfBu49D3yPiKWZ1JKbCpBrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zE3h/ehRaNz3k0teU8N6zMmtftfn0Z2lwVGDMSTjcU=;
 b=o5r2C6UtMPZ/4S/kWEVAH55VGELmro37TiHWbiIPQRawnSxSQQMfRLNuxdVSa1MNjTSlavC343G0OOLs7kLIy+3c3/TO1d+ElBGLyXH+3thuTIexpHD65662B1baHMMuWdZcdM+jRRegsvcZJ4X64YkxTCEGMY8MPBqsgSGyEuAG9ibzyhnsPQI3ZWpT65mNeJr1vLZ9oDPY8/ZmUCct3TxX3oxyhKLwPB6JL3lRBY6hKQ9bbdTDxIykM17VKtlJ8IkNsMPZRRdA7Lyndwrr2wmS8TdqbdIyvX/9Hpxor1iiwCxQFsXINrZRF2gAHzRGS1JOTerORh4XL4GmmkWKGw==
Received: from PA7P264CA0446.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:398::29)
 by MR1P264MB2657.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 15:35:32 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398:cafe::a3) by PA7P264CA0446.outlook.office365.com
 (2603:10a6:102:398::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 15:35:35 +0000
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
 via Frontend Transport; Wed, 1 Apr 2026 15:35:32 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 67B921FFE9;
 Wed,  1 Apr 2026 17:35:32 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 yan.wang+nodisclaimer@softathome.com, u-boot+nodisclaimer@lists.denx.de,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 1/3] tools: binman: Test signing an encrypted FIT with a
 preload header
Date: Wed,  1 Apr 2026 17:35:23 +0200
Message-Id: <20260401153525.1541415-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|MR1P264MB2657:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d9f9645b-dd6b-4ba2-3ed8-08de90044fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vtu6TgeEtGWtvOcYwyoaLg8lfbSKXOyQ6L6D5IPSNo13hrmIe6vwBQqXJgoymPIUGxfde5Dz75OOhzddA4TlPoN6NvQTl3qRNscY5+52xLN3/Z6U7py3oLSVoBhJm8qZPEa77xIWs87DpqWN9EytUoHo4w4OfOP7muy9rQqmRUa+M5qgUv8X5OwXX3P/YQqYmb9BdEU8EkM25zm/vyjPk/B4W27Qtsfv7YEdLaK/YUfIKeIgA2n9MP7Tx78uVNQak63BHHKfn8mX+SzIdGBxd+zTe3x+Xdz5innFVxeJAEvcndBFLretrtRu0v+jyQaYG38Z9fhiygVepYwhjgWzwJeUCj55GRDMlg1zpVBEgdi8uPR0iEWp3djcx1hFolWlV1V23njzIAf5b43IT25cPznGaL+0URrQvLLFypvO3WadXnPxgIRlRTzIkT2836NKL+SS0jWtLdeI/sAU8V/YCOzHbmQu7ynZPmvB0vFMzGRvGXoPRl34zhlK1LaSotad17+inC7kw0261b3d2PaweWEm3Jq3qI9cNvgvCxe9H+AQmCXVbbAow9NnNzx0NZUxse7Xgv/0rWc3AI+EIELtbrehbWi8PuzgcEujDhy2tuiQGmEBFrhxNhO0PUKG/yNd/IyHfUI4T5NLmEQUQBjH7H5+RfGRDKxFmh3xZxK3LoT33voP0fR01kyi/k6NrO8fVt/r0AJdu9VUtagG7SjV9ZLWRLUKIFjtqJGXRcBGsyUZzgT++b4d9TrQes54tf1vmwwOl7DlCns3LYTDA+Stvw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TTDH+CEejDJhBonkUNPErEj47D8Qek3gQGwGIZ+ANrIdk8fnJSFNmbaftVH1hiXoA2Llzos56ST0qVFKTEenZHl6Fy4Le3Ln+nnre+TluPpmyK8hJm1FcsislAMr6F2d6iEYY+vxb/qEcuFVD8c4+BEpPF7WHtcAVGyYyOl0lrbHe1C3RrnA1EgQ+nctemzmDproTgg0Au6xBYqJvMJ8bgnrRAnESqHhSnQIsj+cxF/oKVAdAveZ7CkqKxur8firxjo7m1MOJYDVa6ni3M/Lhc5q+Is7WkEI7AlQ9LEckI0CnHrZKhn+nvxmlaJzVSy6ZTSwI8ZvQLjGNPvR2TcjhNfSxVd/vzMP3B/cW+hGOvuBIjrWh9PixH1X/JeUsSNahU73xarO13TU7Ccy4F94SPXawz/vzL6k4c3uhwUXviPdXVN/q+9YzfSF7vrOy5DX
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:35:32.5569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f9645b-dd6b-4ba2-3ed8-08de90044fc9
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2657
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

From: Paul HENRYS <paul.henrys_ext@softathome.com>

This test is added to work on issue currently faced with binman.
Binman calls multiple times mkimage and thus generates the FIT multiple
times and the last call happens after the preload header has been
generated. When encrypting the image with a random IV or if the timestamp
in the FIT has changed between the 2 last calls of mkimage, the preload
header would not sign the correct data leading to a corrupted image.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/binman/ftest.py                         | 17 +++++
 .../test/336_pre_load_fit_encrypted.dts       | 63 +++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 tools/binman/test/336_pre_load_fit_encrypted.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a53e37f31b3..3b5014e1e87 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5894,6 +5894,23 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             data = self._DoReadFileDtb('236_pre_load_invalid_key.dts',
                                        entry_args=entry_args)
 
+    def testPreLoadEncryptedFit(self):
+        """Test an encrypted FIT image with a pre-load header"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        data = self._DoReadFileDtb(
+            '336_pre_load_fit_encrypted.dts', entry_args=entry_args,
+            extra_indirs=[os.path.join(self._binman_dir, 'test')])[0]
+
+        image_fname = tools.get_output_filename('image.bin')
+        is_signed = self._CheckPreload(image_fname, self.TestFile("dev.key"))
+
+        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+        self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
+        self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+        self.assertEqual(is_signed, True)
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/336_pre_load_fit_encrypted.dts b/tools/binman/test/336_pre_load_fit_encrypted.dts
new file mode 100644
index 00000000000..f5e9bf9426c
--- /dev/null
+++ b/tools/binman/test/336_pre_load_fit_encrypted.dts
@@ -0,0 +1,63 @@
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
+			algo-name = "sha256,rsa2048";
+			key-name = "dev.key";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: fit {
+			fit,encrypt;
+			description = "Test a FIT with encrypted data and signed with a preload";
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
+					u-boot-dtb {
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
-- 
2.25.1

