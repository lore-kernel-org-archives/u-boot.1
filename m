Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8A5F4369A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73BC5842D7;
	Fri, 17 Apr 2026 15:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="XvE1JEH7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD42842D7; Fri, 17 Apr 2026 15:02:15 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E50D1841C2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSep+T0QjrPNOLjRXmOkbSCBFNatYGTsO5sHxVy5AkLPI785lofi/p4EaFO3EePQxuCPaAAPpG5ZjR5sdxxcXmEiq8ANbalpgUoKxKiF4/80PGJC7rePyQmc4er2dbBEE0yKQ5bVBXiq/7dD48I8LYRZEL6sZobuD4q0mlOm7z9dRzT+HcwQXx5ZCqSif9xsCcmfUyyd9EtrcMCU1IDJ/o+xZdZD2teUgYGG8VKC7tlONNiEiS3NbayIHnzLXVXs3bA6k4DU290irjYXum5wxx4PNfEYZ4XOQa2xfSASjZLS2JxRUouebm1NOoag/ClxEmbczItZ65Mcalm2mFEG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiKlJEr2OtE8jcC1KTpzOmaQ9b+9X1SIuWPXPpbY1X4=;
 b=MwP9mtjSlQcZHwAoEfGIJO+qAkgLGigprpnVuraoy+RkTikqCQ2hhcyWIgIoqCZ70UiL4ATSX6NFprg9jAexfMmQbf8rhpyOk92Jd9PLFbPGNrtTEQC6skYbS/1+Qq+MElHbLD1CRGN2fpAJNjhJsOLPDPN06J2KVAxLhE0h53EuXN87cgSJt9Y5MOGacLvitdbL4d+qxISGWI6HLMHj5+7jXnFUaDi6pypfc/HcKM049w99Tw86/5TfDOrpANN5vNywWhbYOiFxiGmBwcPJSZnCkNVV6k/kcXvVotgo/rpkCEpmUvrS3cYqjkqX5osxPMn95S+08gomTIcxAcuTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiKlJEr2OtE8jcC1KTpzOmaQ9b+9X1SIuWPXPpbY1X4=;
 b=XvE1JEH7Iyt+kSogEqBH9Vf3y3MQzGFNXa3BSt04KvVcdHydUtnPuIctXWQdcUrEGLltzyPeUbUu25ULSTPN0b7ODPQkQ248Gi5XZIntjOHgdso6xQeukdy5z2LQv5d+7JC230UZwuEbetjnZcHwC2Bb0V/oJH65EwGDB73BoOtHypjwx5EugzQMaJp3QaeQUgapPJHFLXpIcZY3ysMwZmpJ/P+u+UQQDyNnesDJCa6ljndYmKHthcB7vWKpdXaZJhLIwCn9k0I9vJ/y+NFZuOZayAwmyFfKOEo4QnOIrFU8fokrL6IQC7rXQG6a4F/5YFfXL80gOKWk1BetAQAE9Q==
Received: from PR1P264CA0125.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::12)
 by PAZP264MB2942.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 13:02:10 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd:cafe::35) by PR1P264CA0125.outlook.office365.com
 (2603:10a6:102:2cd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 13:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 13:02:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id BE36420E34;
 Fri, 17 Apr 2026 15:02:10 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 14/14] test: py: vboot: add test for global signature with
 ecdsa
Date: Fri, 17 Apr 2026 15:02:04 +0200
Message-ID: <20260417130204.49896-15-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|PAZP264MB2942:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9bdfbb1b-5502-4305-9a17-08de9c8189c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: jh7gWRD7n25/PAmwJzWB0rqYENA+Zc/CgdlWfs8O9jFKJ/3qgo8SaamZq7nEBVHyf5Q5N/rripIfYap38I4G2JNL9TuF8GWXtyGogACenIXl1jL4nC1eJuP2Y7Gs6JWyGyqZXgogP/hwC3/smRmpFnUU2TWIs6XJMNlZrXZwj+4zGYvcXcbbuUb7MGMipRdz34WVEX2TDCzDz07ez5FfBn3TaRS2x5BnwZi0a4LWNNkeNh4sos+YJIq+zvqPM/rtNidGtCR7qpeIyvaKd0S+d4R2jaHCB2GMNY+DsjGZAsJSeL8tlp6MddxbLJsQ7RZx+1r4akLzJRDVafFWLUW9KTk5wK9KQRSymreF8LSVRTG4TwGA4zjfSaeaVf/MzZDWIAlpftNqAIbyaPeWHDY7gYMKZHNkGZW96L2GHvja/rGJOOkjbO1BKk45j0uwpGS9xhsw6Qws7cTCt0lvaWPN0PXCW9L3NpyCAOOgRjPHSAQ9Whu3SGtXjsWXqvnTOxjEHkYveGIMiryhZuCIdiO8nEYjW6RqCogju7wW8lgn+zioge53dqooyz8p0RVDHBThkwhnzAiK/kkDXafXrMHjlUctfNIbkKWvO52TzZaH836dUTWHd03UAI6ByZVmW4XQRzVJcWjWRVVmPHuYQ3nbcjd/EmjWeXRfEJUrlqONQi45oCvxjbswXOkb1YYriiv6Tb3p1dsX9VzZBYKiBprsxs3vz+JDw2r9szBcbO2CKOZEeGeJsufYqt1CDeTZLmAD02uvYh03dSX0hnxYYGONGw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H5yPgL04PY5NXcz0wDnDCZjDgzW7+q+PfvrXFRAIv6Ljl/OfMzhGNgprPaqoyLvO5Sd+SVmUJHrv72gs1SBqkr0HREsRoMaCTDoz3lwm4xENPgEHbbazyQhqhED18YKgd0z2GlgmFa8QzP5TGDHecxf4nn3tRMZBEK3hL1x7A9Mjpo5krym4RuEZiUkgZCHqd6JFc4pFyyFew+WvkXHd+V7wnk5IICA69NqFqpXj4sjuXK8v6TFKPtZH7T5KW6gjHlidRqIlAkjgku5DTtjf0kgfPgodxhNZ9pn6DeRztFi+Tw/6skjCguI6L5XnZjXTkAOfkaA62YGpXUK41J1bI6TyM3M6JNwpl4gBlN/VdohWiDIgmA4En2Y0BRdwFAomubHmNbuLngbWbzDPwtFgbAriTdLTC33kOiAs+3TrO07GT0DsadkO7yl/S6L5ZiYL
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:02:10.8984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdfbb1b-5502-4305-9a17-08de9c8189c7
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2942
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

