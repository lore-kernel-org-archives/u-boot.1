Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C60C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 15:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 011FE820EB;
	Mon,  2 Jun 2025 17:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="h7HEvTo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B888006D; Mon,  2 Jun 2025 16:52:42 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E844803DF
 for <u-boot+nodisclaimer@lists.denx.de>; Mon,  2 Jun 2025 16:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRq6UbFwdJRc+gE5BHhVH/u6yhWaZYN6F89YQhfs9/CPIyU3HIwQUBr3F5ojPf/vF8F7K/fxXYIp9hDdPEVWH31VcMGnZYQ+0MzTttYMB/zQ3PO7pxoSwb/quE5pe/U5u/ZV8/DnLpoY1v7E7efyLGAyJvT8AcneYbKsAbLpDoYHGeqOLdyaq2/ZHAqLY2pSMoNA68rfr/bYGDt5kQzR8RDSHC1WLrR3MAv/tdZIXL4l6Uq7M0OR5u4kggYHp9SMrwQdXH2GXClpW71QTAywo8aOYO7BEPx2JbSOkN+xX3pd2+9EcN+dzCNkZO25MbilxNQQP15eJuytZnwjus3V9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN1Z/1qOsjURLvblvyOMCQABw/bc/O88gaVTs8p3M0o=;
 b=F5LaqBfuEib/hgMMxDPpPi4rFmqBRVRamdBhHpl/M5fsiwjFcxvOHS7RWUdkuLRiIfC2mhS2NqCX5qIQfmZX2+rj1EKam9kKoudREFRY3ujiQJPt5g3javMXvNCIACyNBSrSsGlBoXkpzKMTfaGS165o5nWWAbCdoRVnhzWLwmVB5I+ODEn+5oR0s/sOyZVH90b3jfRKDKzLmwhwOeJGWnSaVN3Vrq2JIDsqcdcqvpCAXjSdCByhRFKrD9mVWq5r7JkfxQSythO7HawSzoCJ0377riSt3ujY8w5YbbWoRaH5HpYANZ0WXZDG2uDL9nEtVj4Llj3ezkxpwXyPDirf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN1Z/1qOsjURLvblvyOMCQABw/bc/O88gaVTs8p3M0o=;
 b=h7HEvTo8XaooRBvHxDzAHparCHGzpO22kuASG/2eaIVm4Wioi5VCvCBrUK/YDZPt+yRubqHSxZM5rLQNaoF4Eh020EJEd7hewLNQGwUiW8Ju7cftoZnCu591AsEfg7QFIFcCqhiRJfIax+QXwKCBGRYOq7IR82VIOtYOsXAGvaJhj4tKLUhgcdkQ0+zn+9A2jh975d5Z0tfsGMXGHloxCpAz9XN2xoF4XfczMrwgDYtwpkfWUQRwI3oiLYdJqxAmTLSqzp7lqBHLPoRprooAYzldHzMrvOQNgCQBMWnst5dZX+6aTgseMvA9EPVssBfjmp8MRMyeuf6Jyr7P0iDIfg==
Received: from PA7P264CA0093.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:348::13)
 by PASP264MB4770.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:434::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 14:52:37 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348:cafe::eb) by PA7P264CA0093.outlook.office365.com
 (2603:10a6:102:348::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29 via Frontend Transport; Mon,
 2 Jun 2025 14:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Mon, 2 Jun 2025 14:52:37 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.75.47])
 by proxy.softathome.com (Postfix) with ESMTPSA id C91952024B;
 Mon,  2 Jun 2025 16:52:37 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 1/2] tools: binman: Test signing an encrypted FIT with a
 preload header
Date: Mon,  2 Jun 2025 16:52:27 +0200
Message-Id: <20250602145228.79778-2-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602145228.79778-1-yan.wang@softathome.com>
References: <20250602145228.79778-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|PASP264MB4770:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 842784bb-32ea-46e7-64a5-08dda1e51e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rYcncMM6Pjqiq0cSZVN3jOug6ue903ELCzBoLu1+Nv3v1PAVqipbfiF3/pfd?=
 =?us-ascii?Q?cgx1Ghhu8taNapTOxAPDMMDOPpv4dP9QVtponZ4S4ADbKDyLNmQkQODbaKGW?=
 =?us-ascii?Q?LxDfRh8j2gDF2K+670LW5cWVQmS49pwr3+1ZapP5oSGGLLBSZUYgKEdx8tqU?=
 =?us-ascii?Q?OvgiB+MvL2V7iN0FSvPQet4DvoHcirL1fwctqlPXIeZTRfdteQzTUXfs7Kgl?=
 =?us-ascii?Q?ZhkTbDhCnjPKSJDJL+jIUtEQYQ4YLvPm2sFA0gRbMGe53hkZTFS0f0SPqJad?=
 =?us-ascii?Q?Sn9JR1//5ABKcOUGHat5al66SFFGq0vWR1Bz003KkP2MfuOQXf+k0EqZG4Mc?=
 =?us-ascii?Q?iCAJcgrzMxoiIJjNQ8IUM/uSyUCdLOAGxmP3RiBXGiqr3k6M/mWMlHueH985?=
 =?us-ascii?Q?LGEfuA1uvIuKpdfU44KPeJl0jvu7UXb7diebMjVLMUmEqdGB3CkNdLb5b+sZ?=
 =?us-ascii?Q?4O5IpMmwF6Cjp+1ILGalJnbopwjRJz4WnESIF0+BRs/RP9BV31jV/NGmHH6D?=
 =?us-ascii?Q?dFOaSKn48L7/nszCUvEvwdXMXXnscE3ZBHTxcYzZlZyigIg+xbuLN6u2qhC5?=
 =?us-ascii?Q?U7YaH8GQpBvy0+P5IqlgzVCZbd+kfgXftl9rZezS95Z5q1jkh5wp/PKRUsHj?=
 =?us-ascii?Q?ui5QEcdJ4KAxI6I1jvcr/qHBwCDhJWlPvJF9tz4eQCamZtlagm4Bf8LyzBlf?=
 =?us-ascii?Q?rCu1dDCsl+tFrkRdwbTCHnzdKUjPJqwbUPbO6cpe5uQp/I6nDM70gFLYnYrj?=
 =?us-ascii?Q?giPv78qHOAfSzSNa/UzSTCA6CzZ1wr/kcA9qPHM2zRZGPp6AYTfAvMC5WckH?=
 =?us-ascii?Q?Yi+N1lF4rP+ADQua2DR5QiyOn9dJ8bJizhFte4qQzrUe04UKq8NeEOxeHSWj?=
 =?us-ascii?Q?glK9sFtzAIIuxhslmMdxdB99KL/rsuvpCJ/Ojvrjo9X9d0uR9YeNRkY1R4mW?=
 =?us-ascii?Q?HnYViEdoZ6+558S7+H3zmfcugIBqfEDMZIdeblqexR42V+hyUhj2pJb4vYHn?=
 =?us-ascii?Q?uWoLBCohaEbVDeQRv14QiiNiwv/Lby6vtdFBHTkj2/dKwKyhVJFjt2cpxSFo?=
 =?us-ascii?Q?rGEClASuNyCoyK1Jwc6ZA/5WKdFNv7SM4OzNHibk/Dvj52Cr7viwgko8n1Na?=
 =?us-ascii?Q?FI7vdVq8jCMA4Byc9rTXbHRUxvK6Cvqlu7KKgxAw2CA1Y/CGXkWB3zhMciaO?=
 =?us-ascii?Q?m0vn+KL971rAoPAkZ7jrZqCiOAKKSwCrrtW0JJyH7RtkoegVc8dzak8eS45P?=
 =?us-ascii?Q?X3BoziEA557/fkHqPZ3Mqq8i2yOhHtJKcCRCpq1ho/OSVMZqHDjpgOAIKsCY?=
 =?us-ascii?Q?e+Gi+Re6I8a7PUTtc8KWhmNl47Lkw0OknNdsD8pCHzgYiwdIEIHaEjlOfd1C?=
 =?us-ascii?Q?+iEGMAFYMArnySkCODGeQ6PNJu5tuH2QgRYk4J7P+l2cxRFW6qV67mAI9MBv?=
 =?us-ascii?Q?q4+JiRY9ACNu0M4Dmio7fGcOa/9bnaS9KdFohbH74U6OZvOOb87YrGAIsBel?=
 =?us-ascii?Q?CodiiHpFY9wxH761JbbhnnqHGR8BfKhFQj7v?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 14:52:37.9354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 842784bb-32ea-46e7-64a5-08dda1e51e06
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB4770
X-Mailman-Approved-At: Mon, 02 Jun 2025 17:05:47 +0200
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
index 4670ca7d515..0ca04eda9ac 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5863,6 +5863,23 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
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

