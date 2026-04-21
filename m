Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8F3F94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38179842B7;
	Tue, 21 Apr 2026 23:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="PMiMo0Um";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59BED84198; Tue, 21 Apr 2026 23:10:13 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D9D842C7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ijf5Br5yLiwFkKhbZRcOP/IPDqhEOr7FSLb6xht2UkLD7uzoW+jc8hVglYlPMzskf6wG+rbg5a2C4/YcfIXyQl6HOptqWF9dCUqkrMa6UCtpX4JYjcKx5PSD9vUPXZAuAz59n7VDFy647WIN7UEiNA7KLfihvzgwi9gzC6+3bSe/TYJwx1xfXgxL2M22agycgqVLFsKX7hEEI3FKkEN8WAlYEp7JmVkU6gTiZ2+xyvEhjCSH/deGbClbBgzJ5aRlHSAGdYGxa5DXMuCocselFf807vdEZKcO0FZfA4wVlixmbhoFkWps48kPqQqrWlrGiAI6V4MhUFERgKdD/zjTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHTYsHxzYJ3yzFLBch2r9BuVuz8BIYsfeRvbDezlHso=;
 b=IfW9/s+3vIkd8fFpfHutpszhHr5jkDNblU624NRRpl8kMv50DMN2R/QA4qgfdDsl/CDUJ++Ui5jyHfWlj9xT+ukmO3yL9sU9dRw2uB275yl5RWWLeiqZn+ENtZrz73U0TSh1N2hiz91WrSU8zeejbLOpVuO8to9pWRHuFmvNJaSzC8CnN7twWng+tOUrBnhp8aiSMGXRBfhcFX9RmSAbq5fMBOSKVLA4RAiislEsswpJICKJK/VB7Wn+Z0AsuYS/ZYX0i8KqQJM4Z7+3PxX3BZuOw9ZGAzmXFj8p/uBTWmIRTShsdTEfVqyDGmmksmzgu580sH0aFhSrOD4UifXI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHTYsHxzYJ3yzFLBch2r9BuVuz8BIYsfeRvbDezlHso=;
 b=PMiMo0UmE4x9Wg27Oze/6g6hl3IwCzsiyvYM/DcBN9cqtB9zR29I47aA7V0t6fWGQ0vSwLGA2JQJzbVKwqpKneXOqkqW1Jxwv91waRpfpzphzxvSGIx46sYDIIHAHuWo464DQWnerUse7eoYZ6SnfCUIdGQjm13pz+sB3YzNs/2IjJiWSPBEnuUtiBvOoFaPAmg4epZYEs9gXKwKSPbXboQ08792HLuop4nFoKKgUhma7E4ddo+C2ycbPl+X0w/sk8wl+rrEi0ukkrbYTfa2eNS1oQHAPTRbzsUjIoF+UfhPu+NkOmpsAIkCvWmBRiv4dqlPYjsq4AKCUQOxyypZbA==
Received: from MR1P264CA0160.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:55::11)
 by PR0P264MB3673.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 21:09:58 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55:cafe::3) by MR1P264CA0160.outlook.office365.com
 (2603:10a6:501:55::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 21:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Tue, 21 Apr 2026 21:09:58 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 4FA32202C3;
 Tue, 21 Apr 2026 23:09:58 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 15/15] test: py: vboot: add test for global signature with
 ecdsa
Date: Tue, 21 Apr 2026 23:09:54 +0200
Message-ID: <20260421210954.1170437-16-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|PR0P264MB3673:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1f15aa51-0e19-4074-9353-08de9fea5854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 30dG3FnZohyZJUCuNGoKXrU/4lMJ0I8qIUq9K7OWm0wqmEvVElz9+CncJMDs1HAe4YPh4wXCy4uVgcex7j43oRVClgQ5+TTBYMz7VGDFJdjGmAXA0KrHS3oFtmPJxd06F3haak1A6M1+V1OXAKfzusMBqMBc+wr1usStYLVE8dPxgr/uZtWVox6TkePHWAL4gbinPCvmQKzE1aM11WLCoFJgwr9H5gtkjaP5H2BJk4V4sxD5hgWC5ZLx2e9ZXvTYrgRl6JqEs1rEeSeHBmliLA+d5d1zZBI3DzdkYqmw4N3F4iR0fAbjfecaeyqORl8rE9nl/k4aYHNpabc7P/fHKapc0xXNc1omciUHieY3cQ8D79iEygeRCsRF3tM2ehsddBZ8JDPbONZTK+jJdVfLu26HECNvxj+kEnXwwU8GZIfGHvFl/wWL5oC3YGRrgy+Ndd5FBbkOJMzxx8X9QRbClnPcZi2tnZk4Eka+1XpxAuDWCR1tfOzHxL1yJyXHI7PiStbSOC+u8jfWM5TTcPziYiyvIA4bhhQXAwTrR44iV0viMee3Si83XJHLNzX4Wtp6VvnqSOY2e7CS5a5b8jdHWDxhgxdKef1oQ/dOIHW0GKMd4KatWT6kOmGi5n4Jee7hG35ZXWX40o9XswI06h5HCLIIJzVMfS3Bl/uDKroHaqpZgpH4YleOgoWqiufIN2G1cMhkwfnDGS4FQRezhyoUptr7G5RjV6Apv2gQX0cKNASHdPhxdZRfN4ys7sy/W8h0TULZKKKptxD2nOtGoBP3VQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KokEEUOYGi71LLOGJbIGL7JX6ya8JVqBOvvU5oPLnL191cQZx6sQascw2vxTbVjygJqJt1fzAQkxXSQAp25kvEJwnWzrO6P3kk15zzQtMJJZ5QI8W4Xz251YfhR90J5WC9OoJ33u8YtM/DUQXwLf63PuuBzpvD28ScPG1ctjFbV/+QczOVDTe+pNc6UEeRx2uD2qZnvC6nkcV+1zRHaDXRKqHdf+WkaZS61kGrDnk0H6RSwgWRMYQDQJS4p+dedjvekOoVXHsAMeFGSbJVqiD+mFqKRFS5Mn4gtAgavWUvajqs9hY1iE3gvLZV4sZsffwWQ4IVo1AibxN1SDHPZUC+fcUFkkLh8fOIgwPOVIIVPXQDV6/vL/UAKEpPr74TN5f3HBjc31TNeDB8iTUfiYWBZPMs40z3+TV+iuUu/t9m/FodIAuddmoUzGNrL3cW0V
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:09:58.5626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f15aa51-0e19-4074-9353-08de9fea5854
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3673
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
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- no change
v5:
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

