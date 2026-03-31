Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0522BFF60FF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E914B83F0A;
	Tue, 31 Mar 2026 12:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Pu257zcA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F5218408D; Tue, 31 Mar 2026 12:01:02 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22A1484056
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBYSRJGdTyBPaxzuV2k/YqQys6E8hOEu6hHz9NAxgjZ79vhB7EDEuz2YsUFn1eh9n4AFOxl+ZA6Xt4UKQe/AY1b+ngKeuj5xdVL5MGij/zYubnPtCKuUWUHDLpa4rbLW4TzJAVfOX7nuJz5UfkAEFTOkB8R/veqd7EKwFVtG5s4ICkfgF1DF0y8/Mno8kIuJzFdKsU8+l6h35E48p8pyA7OzPjpl/DeEB2l/i0IojcXgOzBuqFP0FuIZCen399KmC495NN6XoezetQBoI87qozb2MM2sLur5pEKNlznbJ5xE0Q0ip0i84AYLaXkBTKpMe1c/2CG1b8RBlmoZjAuF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7KvSJ9dDinZGl9NueB9Mlzhb+71XFAx1mRydo73Nfg=;
 b=yPfpPadLsne9ljfIVm8o7Cw8GjHNmPQExVFHKYY2d3Cc5dJNeOvb4oVkVtYfFnaqGAe616Tc7nMH59I6Iotf4DHfrzcaV4KhYDNEbsMK4mnaIivDQYp6EgFjl9gzjXRMrLb9QrhFOwqMEVCaJYv80KyNdogsE5UxJAvr+mY4rmPVtEIfCqBgGH6Qpw3UmOlowV/tNRMmXFNqutJCnbtedQ0rg8wQL15C1EMK8dNzbIms6jwpBnAvLVsn523gwsIyk1cyOE4+rc9y3aKbXgp0zQwoYsdMFKt+cXjvL6T/a8OjXro4/gW21TMOQe8hkl4c7HzQ5EwFlqyZlW14+dDtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7KvSJ9dDinZGl9NueB9Mlzhb+71XFAx1mRydo73Nfg=;
 b=Pu257zcANUt+93nDFbggcvAQzuvOec0TDrNL+Y62tkim+iFPyLdaBUQP1Js6JSwpnIxk2kvkh63DYaOp4cFjFzQDx9a+a2cFTXBKa8Q3nDnKghh11hMkdmuyJY5Cy7/SyVxT2PEhj8CTIIbhkOoI/4GSMtWVlye6QpUnZqGQwG89l2G8TiOJmHdevYpV5CdIYwdiEhHvSV+cfz1RORGqrG7iTR9i1+8UgnuXluJmpOIqmku3+zklqAuNj1LoLu+7CvJ2MYpPsUW19O0bmTugxGErFkSx7DJ+KeWdzlxLeht7kg6WbMO5jteGumf4O9oIyZ32rylaSPoF7qaiQXaHDQ==
Received: from PR1P264CA0036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::23)
 by PA3PPFF7FDD5F7F.FRAP264.PROD.OUTLOOK.COM (2603:10a6:108:1::6aa)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Tue, 31 Mar
 2026 10:00:53 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f:cafe::b5) by PR1P264CA0036.outlook.office365.com
 (2603:10a6:102:19f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:53 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 923CB20DAB;
 Tue, 31 Mar 2026 12:00:53 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 15/15] test: py: vboot: add test for global signature with
 ecdsa
Date: Tue, 31 Mar 2026 12:00:47 +0200
Message-ID: <20260331100047.34618-16-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|PA3PPFF7FDD5F7F:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7636079f-1a01-4d01-3381-08de8f0c6574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2qspo4J7a3ptBzEIYjHVRodjkmHNcB0xfu/PJud/A0DuBd51i1dwbdfxiuZ2N26zHjRZjkimTS21bBdjYCZGZ9Ma29p3yOVke8PZ/W1xcWopBs4fB5n5Z4srPvx5V7ywKbNiocE/YV36zHQMScgce5Wdo8gS1ZKNcQX7jT3jSdFYTWGzCrCip1tkodi707A3Eu1XSQFL0RDaUpMsdxMC10oHVOYJ5NIOgtKGzQGta8rsEfgqNzmwL7jMrpING1jchbzqVZpwaQKwx/WSEmsTBnaIgJdV76GvNHYzPPfkTj37UZOIsrGhIqHxuVToet/IH1WU+99miKcE6Dm2813upx2v1NMmWaYQz8G794xQd8btAyqtp0Ig0XHtUl45CB9oxuFb62yk3dlZoJOUWKvatVpyH2jf6EHFGYsksUiXusNl6iU9YTqrPNglxEK5KIRTQe2x1B2iN1DqI8G+wuoM9wSzx3dtmHq85kd3B07ZwjtJs1sUmVx7ns00oaUKRk9QnXJSE9bZZw0eb0V6tVhZ9dIKidrls3OAOgSO0LGNk2m35ADXOn41hO+oLmcxz57vrZ0eD2Re2JplIRmTVCsAh9ew7Y3dEJsRw4YbhwVS4a5KlXi4IDitEEiiIbzEZaxM/Xx1r7yfGseV0LTYv5QV8VI6Fam7NtsQtRIs9duP/kmkeDfXf1tcNVnJSMLgnxNYEbFVx0WJozyXlBRBXd/SlSSs4gNE2wRLaO1y1Ow7ufX0ABon+E6xXgOmUPzeukMFPiqPrOzSpFAPUZiTdb/qpg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UDfwBHyw0YJgQZ+mLiJuVBJebZhMPzA9N7mKDiJZ5xJDfM5wXVLu4UIr9jOaugUvhbMD8F6Wywk9/vIuLVOF1MqcntJWHGK9PwvDwgQnMG5f65Y+g/aSnBrHoI8L/lRZisDNBrC6Zz2gu3IPYqJ0+Luqd+R6FeBGFd7/1j1o+N1KWcZ72Zyc+yBbe5YPgQeUpbtBvbdoErsl0ZfYD+t8SP+9R+ie0Z5XSCWJy0WwZ+2pN21ZQgWKfcDFrkZwMnCbcfkg7HU+hUTjsl3V7urxki94VjGbvouBuoXMZPlZpTSGpu2v4WWgNf7PBmdTXy/64WNW0RR4uU/9yYCKGqoXSkfo0VjrvegNueY+iYeRMG+iKCyzUNkwR4nSsuSlMTOr4NpiJQ1IU5UYRVQJ35HyNOUgKqxgJner9gp3KW5elOErC9eODlfZAIH3on5Fo2qX
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:53.7206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7636079f-1a01-4d01-3381-08de8f0c6574
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PPFF7FDD5F7F
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

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version

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

