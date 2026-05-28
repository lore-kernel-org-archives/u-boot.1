Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F067ECD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:20:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ACB08486A;
	Thu, 28 May 2026 10:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="sdjzA188";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA580846B4; Thu, 28 May 2026 10:19:28 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D5B846CA
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iR/9IXNUK7HbZ2kQMMKZ33j3rhjk0yeTZ4/IGojs1gJLPsK5ctkawQLeCBmgVfKhloFRsR/rzwwn75Bg48GvIjuJWL+AK4kRZsp/yrUbKaJJfw5A1SZ6WaV1GvDGED3GjHtcfMOkO+IA0a3uKKayO4fE5BOs6j4OpCHp5sd2CJR4gBJgtFquuPQHBqgRr2pw/B+UHMJRdRlC2jzm1KM4MBMwyvaXTpVnUBmC/lCi5tBz8Lmw6Eeo/JiwSyrMWhnX99XxSaAv29lafuDy47aI577A5702lFLbhQG7pK3BiuMpZ+rmAfDbAlAAcQBkexpjgPhgNwFOXGYUTqmHqQ9eVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgrB6JKkjEOVvPL84N5Pk8PfdYdnDO8i6//gh0J2QBg=;
 b=IXYDEffF1nijbn6eeA9EIIandBAdZ4GwAlJZwSdjgv0aZXdHY4FDlRlRksmpbazkPEC3io6wlHPGe8xTm7bspDGJxYLa2NdZb0W6Ag20P/Sb53RG+CDXVmNnD8raPkB+a4r5K/sWx6BQOSKdYxQplGRCzxRAh9SLEHrxhlt4E3HKjaTgU5tBYosfEzLxY0XGvHSyWXuAQmJpQVg67wSaBSNjailLVHblIlaHiB9sZuo6lkfrflEIm7SD2LKaOttc9MNVUVqA8pHOXYCpWW0dNJgrBBXccKu9imbfy1zPrgTFKz/LKGtx6rlehX+VHm1wgTNIvYJJG1hgcAoRWBE3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgrB6JKkjEOVvPL84N5Pk8PfdYdnDO8i6//gh0J2QBg=;
 b=sdjzA188rQqK5lzH/ZzJhx+GAZfmnYzp58A3EFYCRh750y/KjREZEKvl7U814aC2Rokn6h8DcJKEu+U59aOO/Ru2HUoUK4KmqHZpRHJm7V4ZC6aKjArIBrc5QK4MPboJw7upcp5ZJTmml3u/ExT7odfcI5aSbN25KyxXpYbWpAXe6OuYmAXaQR//t1rsO/sbMy+8twSmCoj7wi1iV/hTK/p0QPpc0u7736VxLacr5qrUrOMpFZrjmrefahzCEgzt3UJJJIWhe25njP8LhhSyRkJs/3aetHIHFIcjeEE7UTGAE4y18mdUVOn6i2KBGpxL0Tam/HIZgobEr9mUHfDmRQ==
Received: from MR1P264CA0144.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:51::8) by
 MR0P264MB7513.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:ab::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Thu, 28 May 2026 08:19:20 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51:cafe::5f) by MR1P264CA0144.outlook.office365.com
 (2603:10a6:501:51::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:19:20 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id E4B8020E34;
 Thu, 28 May 2026 10:19:19 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 15/15] test: py: vboot: add test for global signature with
 ecdsa
Date: Thu, 28 May 2026 10:19:16 +0200
Message-ID: <20260528081916.11355-16-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528081916.11355-1-philippe.reynes@softathome.com>
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|MR0P264MB7513:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8de3f13c-7612-462d-e429-08debc91d165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: aY8SnrsGADIWT0kz8g8JoE/Qty7OYahA6iV6+5Ba3T2F1kWohHrY0vmZvHMyUej5w0lclhvUwxpur9sUfVpFDvOmK0iQzEwIXzPkBnVv2lxjtvyyKuijImaVRMvs8KPaJzn5skA5NGB5XX8FRQcVgctCcpDYnBg+ATEqt8ghLPVcDfWxJKmgtLYcN6bVdNSIzwLGoTLiOh2hbDZISinzLIp8nO5Y2lf91ixndubVpmPjvkXXKdQAs6qtNIkPzjO1AJoQCHyMtpNLK9litYa2Kjry2//rMX/lRdA+JXb8Wa0w7bG8hE05hhXw2KLME7jv+aIK6A+5Y7vWq6H/1hQGNbJ1qmQaiJpR5F/56UxLFRFUuCLTE7LTdPC0/31xruqnTJtIDDYJ8WwuQRiYMEdQKFMjYU1EBlI7nytTtVZwwlWvvlfhox3QCHjLC2GE5g6RCBBQuu5IJKDW9B1DtSUrD826O/1A15pmX/XnksIQUEBhrNHNyigxCBKd5sooxOs8gzL8lEorTwsQzBFO8nkDNk8rxQb/sUJUukkxYJiFo83AUlJcMobvXgVD7Ot5gUAW5cS1XssxwNpV0FZhmlriesDaws3RIOome5P4mK2a74dTKn6Xm0JfSTM3RFJpYFGbw99i10HvDeriBGOFdT3tEPCNs1beP1CE7vkHkXoK9K67lhebM0RpkUXWqwCMFzM+YGpACqPssJRsuepkqMxY+W+v09xntokxc5VVVId6W8w=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U+J548F+ynw3NWhjecUCLqLm1XIW8/GOTV4gmNBRu31AIdCCk8pHg64J/JVGfRuwQzfGkf8xhEf/AI5cjQNdp/2gSi+yqR/qd2iaw4PihGAJ01E2SWsAub6FCL1aqSbc7mWZWW2etFogTbnCJm40gjhjAewGDpxxSuhPoVUYjLYlp5AHgF6hT7i9LuJ1vRscD5x68S4m6qnCODtrgQz59RgTs81G1fgXKT+0x68BNpqf0jcY8I902n33rbHcgQl074pMfPZfclnESL8cNESljB+wNxz0LjjAOVxGJ8/7sxC53KDJUmbIS9hfKrbwQEiI8PAF+nCyQ1zjYPM9tWphj2rDeaHGZaqa+V3WKNq2SxxOrMVQRJNG1VSdW/G/4P5AbHsAAIxgQO36lsJhGgPupkAXV2LiPtMQWld8Y3tXQAAl6dXwcktXW+dDZUDGmMkR
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:19:20.1852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de3f13c-7612-462d-e429-08debc91d165
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB7513
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

As now u-boot supports pre-load header with ecdsa, we
add some tests to vboot with ecdsa pre-load header.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- no change
v5:
- no change
v6:
- no change
v7:
- no change

 test/py/tests/test_vboot.py                   |  3 +++
 .../tests/vboot/sandbox-binman-ecdsa256.dts   | 24 +++++++++++++++++
 .../tests/vboot/sandbox-binman-ecdsa384.dts   | 24 +++++++++++++++++
 .../tests/vboot/sandbox-binman-ecdsa521.dts   | 24 +++++++++++++++++
 .../vboot/sandbox-u-boot-global-ecdsa256.dts  | 27 +++++++++++++++++++
 .../vboot/sandbox-u-boot-global-ecdsa384.dts  | 27 +++++++++++++++++++
 .../vboot/sandbox-u-boot-global-ecdsa521.dts  | 27 +++++++++++++++++++
 7 files changed, 156 insertions(+)
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa256.dts
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa384.dts
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa521.dts
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 22865f653c5..e0366e06ddb 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -102,6 +102,9 @@ TESTDATA_IN = [
     ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, True, False],
     ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False, False, False, True],
     ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False, False, False, True],
+    ['sha256-global-sign-ecdsa256', 'sha256', '-ecdsa256', '', '', False, False, False, True],
+    ['sha256-global-sign-ecdsa384', 'sha256', '-ecdsa384', '', '', False, False, False, True],
+    ['sha256-global-sign-ecdsa521', 'sha256', '-ecdsa521', '', '', False, False, False, True],
 ]
 
 # Mark all but the first test as slow, so they are not run with '-k not slow'
diff --git a/test/py/tests/vboot/sandbox-binman-ecdsa256.dts b/test/py/tests/vboot/sandbox-binman-ecdsa256.dts
new file mode 100644
index 00000000000..0e84b81078b
--- /dev/null
+++ b/test/py/tests/vboot/sandbox-binman-ecdsa256.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		filename = "sandbox.img";
+
+		pre-load {
+			 content = <&image>;
+			 algo-name = "sha256,ecdsa256";
+			 key-name = "dev.pem";
+			 header-size = <4096>;
+			 version = <1>;
+		};
+
+		image: blob-ext {
+			 filename = "test.fit";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sandbox-binman-ecdsa384.dts b/test/py/tests/vboot/sandbox-binman-ecdsa384.dts
new file mode 100644
index 00000000000..56faf67fe57
--- /dev/null
+++ b/test/py/tests/vboot/sandbox-binman-ecdsa384.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		filename = "sandbox.img";
+
+		pre-load {
+			 content = <&image>;
+			 algo-name = "sha256,ecdsa384";
+			 key-name = "dev.pem";
+			 header-size = <4096>;
+			 version = <1>;
+		};
+
+		image: blob-ext {
+			 filename = "test.fit";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sandbox-binman-ecdsa521.dts b/test/py/tests/vboot/sandbox-binman-ecdsa521.dts
new file mode 100644
index 00000000000..8e2fc3de31d
--- /dev/null
+++ b/test/py/tests/vboot/sandbox-binman-ecdsa521.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		filename = "sandbox.img";
+
+		pre-load {
+			 content = <&image>;
+			 algo-name = "sha256,ecdsa521";
+			 key-name = "dev.pem";
+			 header-size = <4096>;
+			 version = <1>;
+		};
+
+		image: blob-ext {
+			 filename = "test.fit";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
new file mode 100644
index 00000000000..f15ada3987c
--- /dev/null
+++ b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	model = "Sandbox Verified Boot Test";
+	compatible = "sandbox";
+
+	binman {
+	};
+
+	reset@0 {
+		compatible = "sandbox,reset";
+	};
+
+	image {
+		pre-load {
+			sig {
+				algo-name = "sha256,ecdsa256";
+				signature-size = <64>;
+				mandatory = "yes";
+
+				key-name = "dev";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
new file mode 100644
index 00000000000..24540ace249
--- /dev/null
+++ b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	model = "Sandbox Verified Boot Test";
+	compatible = "sandbox";
+
+	binman {
+	};
+
+	reset@0 {
+		compatible = "sandbox,reset";
+	};
+
+	image {
+		pre-load {
+			sig {
+				algo-name = "sha256,ecdsa384";
+				signature-size = <96>;
+				mandatory = "yes";
+
+				key-name = "dev";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts
new file mode 100644
index 00000000000..72fa3b2c790
--- /dev/null
+++ b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	model = "Sandbox Verified Boot Test";
+	compatible = "sandbox";
+
+	binman {
+	};
+
+	reset@0 {
+		compatible = "sandbox,reset";
+	};
+
+	image {
+		pre-load {
+			sig {
+				algo-name = "sha256,ecdsa521";
+				signature-size = <132>;
+				mandatory = "yes";
+
+				key-name = "dev";
+			};
+		};
+	};
+};
-- 
2.43.0

