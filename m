Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C10C83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 12:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A528180E9A;
	Thu,  3 Jul 2025 14:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="HJ0yh36T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E4C82F14; Thu,  3 Jul 2025 14:55:08 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE31D8091A
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  3 Jul 2025 14:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/XblSd/ktEMzPZFFuOlKSKoqaEEiFYr5DzC/DqLcLc2rXUxrf9slRlaQhTEOzrLuZstWi6fX5RhMyVNj5bh8y/SfjqX2NJfoNoPhD8s6k4qql5IwGIMRIdBUWTjKTU3w9VuRXM7/Wha/VKS9hOZVpCyVb6ym8gjBOTe+c2sz3zUOXVedpd+pEaV7uLZCGE+jdroHdyBhG962eBTkiBClSdKiEsRmorXb3Q0Y+noDXwZ1X5AqaGroMvjGTB0U2HHDjriMIEAaMvZJ+GxuWe81U2trx40IF3TPw/cJvTRlxgJs3h7vN3FGbl8nHxYkVID7fV86aD+CyU09x+qKr3zMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRwTa72D/9mapMiheYd1UZQ9zZVSt57lp2X+CaFv/nE=;
 b=i91oiV8iIkovzHif5rlbnMXXydMTpVm4Z3rrWtL4cE3/GrVW0Vf1jXe8v/cHjqaa6VDc+pmnyPJsaFrFE1hngge+rimK7cH5ASGtcRnpyE2CCFyZoViU3b3G7oZV7HzCkY5WbRv7JOmRzZEr7WKI4rPCJURFdKEH6OOZiAd3Zeo2nXPE/W1bHu4uZjsoxOvIqDXg+fo23eoFCLrkGAhBoXVqcrJQqL97aXAd2jA8jvfW3yVS1PIMs7d8wAig0wqBEDumzmO+DE+inAExVCRaGmZrwmD/MgepfFte4f2hUT+BUoAVH8LySi61kckvD7j/9bi5TB0AjQ7EaR3Vt7PnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRwTa72D/9mapMiheYd1UZQ9zZVSt57lp2X+CaFv/nE=;
 b=HJ0yh36T87cdA077S3tF3WD2w55B/uLLowrtu1kyWTaLWY2qCQMOhDoN+agx9Z403fG1lo1ldc9fj9eYzV/Q6Y12ac4fBtJ7HYmrPQA+Ntjpk/k09JMr+QAmdwEAyTvTnVHCqo+nH6Gz89DKjtsTwkLMCS6BPI7EZK0Rrd9w143nF53hI9wh2kFqT7PWKfPnJf9VA3bTy9czkMIZAuYOmphZvp0TXQIZXoNdosLYBp+K5c5UnCdB8/STbn5gjhDA33Z/RPyLl/pQTsM/688++wXSfNDmmBNZ58cNY4Rm9KdezN+M5g67pN8/SK0G5Pktnp/aadIj2rNCbJDd0R1mCA==
Received: from PR0P264CA0194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::14)
 by PAYP264MB3488.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 12:55:03 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f:cafe::5e) by PR0P264CA0194.outlook.office365.com
 (2603:10a6:100:1f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Thu,
 3 Jul 2025 12:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 12:55:03 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 664622018F;
 Thu,  3 Jul 2025 14:55:03 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 3/3] tools: binman: Test signing an encrypted FIT with a
 preload header
Date: Thu,  3 Jul 2025 14:54:54 +0200
Message-Id: <20250703125454.61174-4-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703125454.61174-1-yan.wang@softathome.com>
References: <20250703125454.61174-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|PAYP264MB3488:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e82434c7-f6fa-4152-d9e5-08ddba30d415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HBsR02n1CCMkw8g2DtNPTeSD0dOr3Mj7hs6xHORIXSKJUQ4CIB7lyJyzqcT2?=
 =?us-ascii?Q?/nxZC8PnyPDonDDi9zJGQcjmDXqc6Ol+zwSInIknFmASEHsLmi2hF+PaX01E?=
 =?us-ascii?Q?7HS9qosy8WbiEeGSfJoGMhcrM2mY7Ha2HpENhLny1XCIugo7DOOidV1pN7eW?=
 =?us-ascii?Q?FOWOsAqtC5vGd+NNSwpUCi/5ThL7cfq1JsxzGYZ4qtsQOpNDaL/9IQmgoHhW?=
 =?us-ascii?Q?32oCQuv08h9GnmWfUaN1PBZTvGBrFgrQfm4gfojQBFCbEo8tr5ngFQY+0oul?=
 =?us-ascii?Q?0qqSQ/AZ4GExz3mbedfLOWz/AHV5tAfXNdkxT6iIdUqcv6URZFz1nNGtNoO2?=
 =?us-ascii?Q?ZWEAMEH1yDL2N2oUl47U50y+4rJGpSk33Vh9ywgGE/4cQxw8hyr/OeH0iylU?=
 =?us-ascii?Q?ZAeB9z3myYG0AVFpY4P5vdf0U6G3AMssrpSKpnrIbJCInvZx4IbbVlpIq08R?=
 =?us-ascii?Q?A5G9pHGplX/9XPoeFRUkB5Xs9lZ+BtCXYzCM85+ohrPAplIZFEQjh36KTmUe?=
 =?us-ascii?Q?AqClBYcxdxgjOXfiZyaXjmmurv5+EZ8p5DhFVQybqYhPFjPp2EqJVgtL1M7Y?=
 =?us-ascii?Q?QmqrpZ3cUVxj3y+fhVdPJhJsPbuyOvADSH4xH8t744O5THbWfc2V0Uv7b8Aj?=
 =?us-ascii?Q?6V7zLPCKmIuSZ2HFoopbIlBcxKi9ywrQyX+OJgCWdRCcwh6IiJYkEHklOYAg?=
 =?us-ascii?Q?I5mvHrrqsYUc1bpqRCri0ude5IulVJwh+5P73ciUqDUAU4F6Bmlhn+NEHSSC?=
 =?us-ascii?Q?76TeZjMZxx+iPQyWmX/aWumf1/69c7xCoiPOeOSEPwgVOaLGx75tIquX1l/7?=
 =?us-ascii?Q?vzOHfc8WN6/fETTrnBQAZt7oLhXXl0F+fxPlpvR1hNRb2JQk8h2W7uv/3Om5?=
 =?us-ascii?Q?nOKbcjMDjd8ubt4HvwNF6Du0++JQuk+7Ravm3NXR1ziuO4dLgMTaS5VGEXDp?=
 =?us-ascii?Q?kT8ORBrmbIeFOK33JQbE7DuVpTCq1A7LVYbhX7SdEBc9T1TJq6L1YQkMuA9B?=
 =?us-ascii?Q?ZG9Vyud1li3H1x8KII2Knt/vl138ar2WPFI6wXK0hKMwqs5dcTR2t64Ioud8?=
 =?us-ascii?Q?UJBJwXhHGl+KAWprCJbVpdI/GPKHC3SmVrYFsAMlhwcZzhtZLkmHhefN0kOg?=
 =?us-ascii?Q?2cO4ZNiOI+4ZhS+Ov/6gzNe9DQmqfYBqcIJHcJ183R5rolZY612clsTGkqEh?=
 =?us-ascii?Q?qMaeLPKgTuwSwz61UIQoMY3VVGgZcIZfdrOpPJN0atucAB+BUwF0oafEogBN?=
 =?us-ascii?Q?sHuGbgaNyBTw9tqL0+wc8YKOWP+GtitkegCvhefGjzwKLMr3d8JkHDoK1hLu?=
 =?us-ascii?Q?JR5zY7xlmsRC2VyySaKGgQdLikE+3+D6gbO7mh66cWDIqQQ6VNcdjHxrqBAB?=
 =?us-ascii?Q?SXunVdvHFWXjaU7SZKJ88Dn7yjhvZUTVf0GvR2jLJ15ZJy+v0hP3dsHqxD/e?=
 =?us-ascii?Q?I3krtKFJqFp4bjOx6Xpx56mwCXlJk1i5GjhJZogvq75Why2x9LH119x/mcl2?=
 =?us-ascii?Q?FOWXsDsmbHcHRmaOQQaYlhRuvW3ruzD+tnr+?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 12:55:03.5408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82434c7-f6fa-4152-d9e5-08ddba30d415
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3488
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
index fa174900014..6f3b5dc0d26 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5870,6 +5870,23 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
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

