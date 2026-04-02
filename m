Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED91D6AAF8
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 19:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F43F84099;
	Thu,  2 Apr 2026 21:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="n4cR9iP7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 201D784020; Thu,  2 Apr 2026 21:24:47 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B9DA83D8A
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  2 Apr 2026 21:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7/O05zYsCgOgFOF88vhnRb5dvGIGhdMWRCF/0a3Ocut8/JgSWRums5zTxL1A6DdieE/BhIylOzeczQcMXvbznYER3ySwngZAHGI6zE/UWlN1R5HqwSX95+9TFnJN3je8CsXmnNFJuo2FtsLrOwcUAxp+2j6Ur472Np7p3xrvHdFAI/vbY3u4hK48sO44IjsP6l0lTNy8ETOd5O1HHKCENRhmIO3XkwB1sJFRo84jvue7NZhb9l3GvWQK7AQJUX+ieP197KvKgIBMYmft7B2TWcvu5EPL/7blNC8V4Sl+0HNRr9gZrQu6Hb+jRiDaBKMmcfw8eq5ZMG19Z0dDDSdwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYN8SUxj4goAvAF+oZmk6SVmOTyRYRIhpX+29IyP3vs=;
 b=aoY2Q+RNAfGI9CQlDZ4mf62fNbiX/Lnh2CGprRocuSBjcGEHIUTEtXpTOgautWr3XyxO/hBeUnFxZWzAr/zDmnocbok7q+LCXnqYPkyDYKPybhAKyQiCkclUyAKrSvot2vjZCfJSsJaIt89MD1hQEDUA8q6NL0WoYVPI30ndJtHuwItY8E9eoKyNTUfzdny/TFMWYhqYyZkX00Cwp4a9aqZ3Rutdv5LNW7MzU8J+BENpKizj+9Hw4X3JdJLnS/zZ+NjSGRW6VJw53zr4Ffe6G2ocgRc3yBWYK/XKKV4tqRVLWxEsjO9hbwkOgWPXkamjOyvGNKpFXTI007PsnL7HDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYN8SUxj4goAvAF+oZmk6SVmOTyRYRIhpX+29IyP3vs=;
 b=n4cR9iP7nKotMBw2MN8HL1Ph+J0wytHf4/8hXubZC2nExNRKP4+KlpEdIQXTiU/t5p0DjHpUfnk0o4ba4Hty4mrpSFx7M/kUjcDm2j4d0xlTaS6/JOESrWT5RPvCPXhHTeTKhjXbWgb6d8KfeZMQmU+PrpyfyOarauyGzBYCB9z+WL8uMNClZ4G4Yv5yMNB1O9QWtbtuR8kWRM0vO4hdyPLRztPmW/F65pLx5a9it6ThSo6CmZti8uevtoey9ROgNptqnLo4eHdPJeW0HlAw4UAEVAt+AV8jSwfjaT1sU2z99PLWki7xZy8AAIVn5pwQyOv35XmjUx41TceoTMdzUQ==
Received: from MR1P264CA0203.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:57::18)
 by PAZP264MB2622.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 19:24:42 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57:cafe::89) by MR1P264CA0203.outlook.office365.com
 (2603:10a6:501:57::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 19:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Thu, 2 Apr 2026 19:24:42 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 1EA76201BB;
 Thu,  2 Apr 2026 21:24:42 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 1/3] tools: binman: Test signing an encrypted FIT with a
 preload header
Date: Thu,  2 Apr 2026 21:24:29 +0200
Message-Id: <20260402192431.2421155-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|PAZP264MB2622:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cff2c83b-98e4-4c4a-18e3-08de90ed7dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZyAAIW4ez5/vD+fEsAnKsibR35epmvNoyebjPzWMwGKUVUFmEP8SGLk/LRVxYy7k3Q+gMVhsfBLqj7+TyKQZyjcHw915N4WPun6xjOqe5aJvObF9YnhySQNHJQAMxQ/FQ7q1n/gveUZ8M5VpTXkRcFS2N9lyj4zHZwJJxEYDfJ3sjkVZwQoZW32D8zZ/RFZc3oxXfHtyybEDeInQs8iomwXPjNrWG+Z5XK/Df88ViiCeM1Wr1RjybuDDUfVDAOoETvR3WTXH9FtWKJcmeuouYciUX7tre5mLpWfwntNwHCN4UZnp7u6g68AsRC4ALFjWB/4JLd001+TrM+5Ra+nQLzZjfa7HjZs4ZFR5pK/S2pgd+Yhs+QFfROR7KSSbEEZHTd9zBD3OUf+Z6ICa1QDpMx7VS6sraeAmks8rlGDfOU7+6bQwfvlefvU8L+gS2xA4omfC+0qawKcgyAxgb44FcWSuANUOJ2Z9zUZFo+5vjRLeTZ+DrncjPInbJCxUKK23LCU72vx8SsacUiXo9hCzmSb4sBp8X05gEqzBgIAh6JnFZwSC24v4NZTl+hfoqX9dYTT3KTP5aBqaNYzvzfMfbO3AK4szrSvYkloDqNzTkdcoVhVAYdk770j+Y6TXOqxcWjLKEtv8kTo/W9FASJsNgzIx4WBbG1yal7gqA4sblpbKFodrjvqYSkxOINa94yUS9s4T2r49fxqSebNJ9HVxKo5S59CgitkqFHapEB081CmfJwFjrm/GvFwWWPN01h/EfBLDrqYjB/98AcLNBig46w==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vW0ba8dROnsZ5gBGEc13dMFMU/zSNmiFdzbma0H5R3EnnaMUkX0JbCt9alGH3pdnK5Od+YwSEEa3nHnP1W9FvciWY4QjmokrmSyUw05Bg0GowBD41+vtUEZG1d/HJ0bxEzMZf8B8+8SyrXxvp5VjrD8vzOcK4+TWKskpB5GTFGCBXjUc72FVfXOODQX9qcx24kXeGE4l5ku1yyOEKMBDi4WeB8smGFMB4BqiUso1MzeEf3RwUVOBAmKJiuaDCYzXxSWDfj9RR69x3huRRcQI92nLNG7qRzekRk1n+DloZfM78WcyX/EpdKvCAsrGdV5NqLDrPAD0y4AEpHZVk0VVN4npxUTslF1T6IT/DdkVQ4BX4LUzhim4k78yVOMB7Dg6hEJ5L/IkC9E0iVlSJgq0L+5fanTgAbZAHttcoXQwhGbimwjtnx/1kcZe57UOQZID
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:24:42.3794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff2c83b-98e4-4c4a-18e3-08de90ed7dbe
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2622
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

Add a test to verify the preload header correctly signs an encrypted
FIT. This test exercises the case where encryption uses random IVs that
would change between mkimage calls.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
Changes for v2:
- Rename test file as 351_pre_load_fit_encrypted.dts
- Update the commit message according to the remarks made

 tools/binman/ftest.py                         | 17 +++++
 .../test/351_pre_load_fit_encrypted.dts       | 63 +++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 tools/binman/test/351_pre_load_fit_encrypted.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a53e37f31b3..dcfe97f0444 100644
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
+            '351_pre_load_fit_encrypted.dts', entry_args=entry_args,
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
diff --git a/tools/binman/test/351_pre_load_fit_encrypted.dts b/tools/binman/test/351_pre_load_fit_encrypted.dts
new file mode 100644
index 00000000000..f5e9bf9426c
--- /dev/null
+++ b/tools/binman/test/351_pre_load_fit_encrypted.dts
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
2.43.0

