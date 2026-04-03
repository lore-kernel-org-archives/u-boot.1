Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B68AD730B7
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 07:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0795E840F5;
	Fri,  3 Apr 2026 09:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="R9io0mmj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2462A83DC9; Fri,  3 Apr 2026 09:55:47 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3083840ED
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  3 Apr 2026 09:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTZR4m6JsGOhvdR/NDxbCe4U5/CXdymt5HFzuWgRB74yd3sIAjGsB3/IwGclzTyLgYYWCqZkwvaPdoRsuIX3oyKAOS5+2uGRwQln+CV7VJS+jo6/ipD9ct4u1GktMVFyMZQS5NioIObbeMV8aKithN4Tzx8Bq6yWEhtZ+JvXSwy6dyQOPOh5CDR0tifIZKbEu+6Bhy/o77vMy2JU/VzGH4SK/AtCzeppq8vikRV6rMbpALycA/FIy0dOdK3eBBPN6sygngKbdEineHCouUB4vrdqgpholdBRBQses5dtwSkuNpUOWmIT9FtlFVT8TlbMI41DV0KAg3X5QlMlmYQVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHhdRBHyHggAMpXna5M5Z1pGCkq6w+K0SNUZIL8h81o=;
 b=bUTcFusGQwWXIw9t/xDdZtBAEIawgVBI65UgfjVp6vp4owrCT2k//MpzIfUSGKSXW4NSwDZgCDHohY1YPrqaFgmW1hnwb9Az7NFwlxB3M839NMp+G8bRunHhEtAAy6woKWGNEfcPLVXdNIUEfcylzJLrjEMvXchiOEfCPl61cTWLyqpCatccZvA9pr/Y956CTD57/ujrrJoQZG+p3TtDkuWJJ5L7ILKVIUF23i/apz1lbTD0Es9YoqAupVd0995DR7XENQDorv6y8ppPKh9tsHRXIRSDGCTvgoV24hboQ6+lQMZfwbg7NiCovYRIS+tCIBmkHclLEYcuO3m5oPnX7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHhdRBHyHggAMpXna5M5Z1pGCkq6w+K0SNUZIL8h81o=;
 b=R9io0mmjx4hVE1chEfeDTtpwOdbJmdSm+vs9Gn9CRvDILADCVm37XezpTjCfTdaeumBrSMWf/UfW5QMLXxOsKRiY+lld103BAUYfQi/n/cyWrA33uFCpoSbJG2ru5LLxB8dO70T66e8a1/NsXo47tmSgAwgKpF9Xt87hgMIqh4noe2mxrGNzqF1QK+lP5NOgxK/vVEauKzZjmurvWGhHhiDIJNhkjKMz/UP/JYs3qMPB1B3ZF5nrfMUufn6sMHeHuhh7fSwxw/4GrNUdn+1nZ47zXr49d/whZkKqJMcuh+BjZaTsYzOchSVnejGgdFT/EWvVkq+wOXyji/mDXfRjjg==
Received: from PR1P264CA0192.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34d::17)
 by PAZP264MB1432.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:128::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 3 Apr
 2026 07:55:39 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d:cafe::a) by PR1P264CA0192.outlook.office365.com
 (2603:10a6:102:34d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 07:55:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 3 Apr 2026 07:55:38 +0000
Received: from sah2lpt245.. (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id 7EFE21FFF4;
 Fri,  3 Apr 2026 09:55:38 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v4 1/3] tools: binman: Test signing an encrypted FIT with a
 preload header
Date: Fri,  3 Apr 2026 09:55:26 +0200
Message-ID: <20260403075528.1150196-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
References: <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|PAZP264MB1432:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 603999bb-845d-4490-85df-08de91566588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|17002099007|56012099003;
X-Microsoft-Antispam-Message-Info: bire362PGgyoMQLRMbqM+BJq/yHX6pXGkn9K9OfZ+0wC0fnbRWccOwN9yzYrqR+F9JPnqnkgeLF04AMb7NJMleAptVuHNlytPnZjhgWo/QO4OGcsU0AWlfe2hviPeHkse72sW5LVUUr6GV+EMHsn/x8f4QhrdDLsTyFnPKC+gtMRnYYJvNt7j5aAGvdEnwZ+NfOChb7v3Kn8jzsqUIiblBWf6xUXou8YCOXxjS8q8TlnpgBNT3kUyeP7kf5nv1YJDMsigWo2fE92YfnCjT2jEypGkDFGv41MQvKH5wdxt3m1Z1X74hlhO3r6HBGwX2BPjp9KeOIkBV0ZMolcPtUqYJz+f0dKewyotQV7H4YhDDKN1hc+k6EKR4Hk68sYCgaqnj1v9sAfA2rnh4i/Id/uX3k5G6vWrEeSBsOXO//E1PP3bDtgLaw5y54uQ1qZ5ZxX90NeFoexI+KhNovp7/vnEqkeV+5SzrhLriW17eBwIy9/YDk8ImZAJIQANvuAjj6thbnFTQw8+thzAmqfDCl0g8p0QATRGUuBcyMhu4LRL9pctJ02FkkL4jYIo5O549PgGzbP9rxJK/mhxonDT9gwJxxTHbtIPQ+9yqIRwYK73MoJ3pmo3SvrJwekHl1xcLW/+mOVIvpxVgEB9kiDA2ueElzCYI8Bl3JUY0dWjTlP9zoivNYly5XoKO+se26yNy3l6R8TFXpHHqiHD9ComVPFYs29onAPj3z8uQRlBf5IvT3K0khksF3k0Bf0FPL5OEsEmWWeWh64+3ECPHq7GWG58w==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(17002099007)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6maCmXXWJf98Wq74Fu5/nUAgAlBU22qJa/RhAUxpeFs3emQY2poi3XNjr5bKMJlBYueNZ25OrriLpv0uhSONuYFDGahtomiquBxRxvnUXV0PDY5rEGwL3HgWm2wxXESLdK51Q0QzaUf3drXHexUDUrrxdU8s89NxEsjXczZ4OvKPCMubgndH4Oc2NauvajTK6ALfIuRjTqoFa52AX5rOLnJcs48MuTI+2L9/HaPErs2YT8RIA92jMHFLtlTAq8oJpXfXC+9uNmba1dLMpAgtJy5LfEE0G3xHS4DBifWVI/N6A+34VO4KhGw626soSHjSW3n1cINA6EgPZ+iA5SY3qsH2EpJMJtquUi1hmXnAdzBurMw+NBKnQQhGLukfR1bgL6FuPkkF+DifOR3Q/wYVuBilOwAT9hbUXhjER0YYJ6BpK3rkoWAAIF5s7QoSPcIR
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 07:55:38.9380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 603999bb-845d-4490-85df-08de91566588
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB1432
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

Add a test to verify the preload header correctly signs an encrypted
FIT. This test exercises the case where encryption uses random IVs that
would change between mkimage calls.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
Changes for v4:
- Move test in tools/binman/test/security

 tools/binman/ftest.py                         | 21 +++++++
 .../test/security/pre_load_fit_encrypted.dts  | 63 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 tools/binman/test/security/pre_load_fit_encrypted.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index ca5149ee654..da8325f820a 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5895,6 +5895,27 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             data = self._DoReadFileDtb('security/pre_load_invalid_key.dts',
                                        entry_args=entry_args)
 
+    def testPreLoadEncryptedFit(self):
+        """Test an encrypted FIT image with a pre-load header"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        data = tools.read_file(self.TestFile("fit/aes256.bin"))
+        self._MakeInputFile("keys/aes256.bin", data)
+
+        keys_subdir = os.path.join(self._indir, "keys")
+        data = self._DoReadFileDtb(
+            'security/pre_load_fit_encrypted.dts', entry_args=entry_args,
+            extra_indirs=[keys_subdir])[0]
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
diff --git a/tools/binman/test/security/pre_load_fit_encrypted.dts b/tools/binman/test/security/pre_load_fit_encrypted.dts
new file mode 100644
index 00000000000..f5e9bf9426c
--- /dev/null
+++ b/tools/binman/test/security/pre_load_fit_encrypted.dts
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

