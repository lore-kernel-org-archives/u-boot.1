Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43E4FF60EF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51ECE84056;
	Tue, 31 Mar 2026 12:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="eZJIi7M5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E88F184113; Tue, 31 Mar 2026 12:01:03 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0936984088
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRD7Q1ODlORF6PrGlDUR/q9E4Z+XrMzJp1dhioNe1ZBpsFWbEib5OvNm1H2xVzDs/xYOY9NVH+IXf+A70axErWbI936WA8jVlL9oxRF95z9PcOkmqgpvIbj9y9EeKgAxlf7zInpfFXusRo5O/IWF79gZALWM3mSkuoK6D1VeJWMrY30v1KGVw3rz6vJv6oAhE5QLTTNJNI5UukCwE+hRMLBR0Mz28YrKVkLF5WiaSuSmNOqfr8XORgq2hDSmrGIzirZ6TFl4cPdgVzYsObjZo11nEFaR/wonqJMVej/DiLwrAiRte6eD6OrvJaLpp5H0XhHWyAO/7Xo77LCj/lKJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUTXwX39HyOIB62iiCcIi65tgnksDJ9dKC+Q1jiVgR4=;
 b=NZsrd61pTwhZB517ujPiOhyi6NC/sjVDRAtZst+QhLLBGdSMKha3bbBlBaWyFUXO1d1cwrgo9kQn0UFTe9k4JGZS65f0ulqHdY7CEIdCI2vhSEW+J7CvtS1I4bEKlBgrEz8DP8KkKFsyTycYzGuzCcI/Hkh0D3j2mJGErMEtKjooRwKFs2VWxfa7DNLHblJmH3rWYky8En75a9R/q8BbdRX4IHsDDMZoZGh4RI6ffw9XPBoTQ+q8PtJi8zyZs5Ohvek9zPwIPZ64ZYNpaXfZHax1yPU1Zz/Wp3PeMp78FIfN+PV4mt9PCSE2NCdIT+N0VR73jxmpOFYkvTaos4zo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUTXwX39HyOIB62iiCcIi65tgnksDJ9dKC+Q1jiVgR4=;
 b=eZJIi7M5EJjuGdMUvzj3nwcO96N7EoODevL/lcLpOqFyi6loCZNeupMETXb6oxa45If5Fsvg+vTSe6PqNp7E98CfdOhPWHT43HRIHs67h1xAWbRsD2bAaK4Symt5gWp2Q26/qUvTAzwNCjPUNW1N+w+yxdWZCj+JOLYV1oLZHipyniEuSK/YVxKThuuRivhhTDYwxF0EQWJKwQIIbPyPYYZat1Vm9V6bu93ahKbZz5j9zMbesC+dwQzm+HTf5q/ORGORDnMC+jqBQeVxqM8dTh8w+E6qaR6M4jty4RgCct4Zrh3AW32LY6YNmbQFaHH3NmX4ZZyQgqZ1cXE0zh+KMA==
Received: from PA7P264CA0341.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39a::26)
 by MR1P264MB2132.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:11::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 10:00:53 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a:cafe::98) by PA7P264CA0341.outlook.office365.com
 (2603:10a6:102:39a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:53 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 4410A20389;
 Tue, 31 Mar 2026 12:00:53 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 11/15] tools: binman: pre-load: add test for ecdsa
Date: Tue, 31 Mar 2026 12:00:43 +0200
Message-ID: <20260331100047.34618-12-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|MR1P264MB2132:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4a18d330-5e66-4d4e-5aa6-08de8f0c6545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: FVvc3cfDyAgBtnLNYdSEYKOZe26B0f4/hTZAh+udOZ2aSRNKIF5w8HlxUdsl0me/4FtZJPB1EhgJ101e9RX2Xg+Mw2beHxO3dhHtbY9UuQDU6ltpc3OglL80xUyD63N2xHcZ8AwVkQvbaQu5xnJcu8DCZ30VzYIt0siz8+42q9wVWKuUdE+BDJDsh8ImawGXB0GXL1S/KFjBMK2USoIeOKZGorUeXUyj4hb/Ctwm4Cn5jpmcDunr+raYG4E8zEc1Jxt//lk4nOJIoA9DmnUKs7H3QSgTClRMPaq1hDO1k4XgUCESbb1ppUb//y8Zznya50EVzQ4+vB68VcOjq5rkJCocv6D9h/cS2rPV0Dhis8zoTRcM6KBruRtg8E323bQ86104VeuI3HQ41Amtcgok4Oo/25rhJQ7X5kiY9MXhCvjSOjnJ8RHUVu3dW99lrSMqE8mCn+ugfc9SAQtH9yOyM5rXPtHAYpq4XR56eaRACHbP6sSMgNhAmbzEfwj7ZhtUmhTK55/U0hTh7euPF2FRGYt0qihC3//mnvtfWLddZFx1gAWirtJzL3QyNt3/2u7juuU0LYfRMaKBIRfGHLv5cCf/bOCOOaxntqBEzPSSXTOJukdyEqKiru2yLStGoHvqFsnzOCbp5X9ixLmTiOMLAGZPFLvdzYWgjal4FmM4T2uxBn0yNoY+/Rmsn7SjK5ipifXi/rOVY6fKR5j10VGtV8xGBeNSpIJiv+V3eghoqutxFosjlKbEc1rjRdlRfQRuo8BrMBrbd2/yhq3Cpvhkrg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rc/AUcuFc7GpXspODXTO1cZZZpBpLyauAPz06dgYweLvDePHDlGE8pnJe0aL5zavzJIo1A1hHlawcT1PxC0Slxr4Pc1SpBdQxjN2ZVXs5HbfainHeb3PSdm0gtbmkcuk3xouDrktBHkr1whIeE3Pah8IJ85Ainw/lyFDZ1IZkvhYLpXMFvFd98Cy/fjiXEIiC27ab9ID7t2XsS+GANd+j/LO6GTsDyynhAzjxSBL/MG4Tf/j8lZ78M90taUebrAEncimmY+ozDN6VTw7qtN3weWWDXXgk1j5R/Nue/to/1pmS8WKOhYn+oW17tVsoaChkvIUAlnWT/PBaKos1UkQfYsHJEQ/OTEXGbKDeN10OGFaa7eMWY5bhHOUrAiGSmVQwaNqNIc0oWSWSgvOtX5th6YQaKCDOEZ862tws5TsA9mdR9okYggzHULvWrjBB/K9
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:53.4136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a18d330-5e66-4d4e-5aa6-08de8f0c6545
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2132
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

We add some tests to binman to check the new
support of pre-load header with ecdsa.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version

 tools/binman/test/351_pre_load_ecdsa.dts      | 22 +++++++++++++++++++
 .../test/352_pre_load_ecdsa_invalid_sha.dts   | 22 +++++++++++++++++++
 .../test/353_pre_load_ecdsa_invalid_algo.dts  | 22 +++++++++++++++++++
 tools/binman/test/ecdsa521.pem                |  7 ++++++
 4 files changed, 73 insertions(+)
 create mode 100644 tools/binman/test/351_pre_load_ecdsa.dts
 create mode 100644 tools/binman/test/352_pre_load_ecdsa_invalid_sha.dts
 create mode 100644 tools/binman/test/353_pre_load_ecdsa_invalid_algo.dts
 create mode 100644 tools/binman/test/ecdsa521.pem

diff --git a/tools/binman/test/351_pre_load_ecdsa.dts b/tools/binman/test/351_pre_load_ecdsa.dts
new file mode 100644
index 00000000000..247b85aad4c
--- /dev/null
+++ b/tools/binman/test/351_pre_load_ecdsa.dts
@@ -0,0 +1,22 @@
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
+			algo-name = "sha256,ecdsa521";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/352_pre_load_ecdsa_invalid_sha.dts b/tools/binman/test/352_pre_load_ecdsa_invalid_sha.dts
new file mode 100644
index 00000000000..1017707375e
--- /dev/null
+++ b/tools/binman/test/352_pre_load_ecdsa_invalid_sha.dts
@@ -0,0 +1,22 @@
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
+			algo-name = "sha2560,ecdsa521";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/353_pre_load_ecdsa_invalid_algo.dts b/tools/binman/test/353_pre_load_ecdsa_invalid_algo.dts
new file mode 100644
index 00000000000..be71edbbdcd
--- /dev/null
+++ b/tools/binman/test/353_pre_load_ecdsa_invalid_algo.dts
@@ -0,0 +1,22 @@
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
+			algo-name = "sha256,ecdsa5210";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/ecdsa521.pem b/tools/binman/test/ecdsa521.pem
new file mode 100644
index 00000000000..ac1904d3955
--- /dev/null
+++ b/tools/binman/test/ecdsa521.pem
@@ -0,0 +1,7 @@
+-----BEGIN EC PRIVATE KEY-----
+MIHcAgEBBEIBM+CNnraGci2/mw1wPq44l2HccHnoBbdP3DiU6zqsBOq8IR8uegz2
+FLzWsjxcW7hwROCdEm6tW99wqsyPE25RZ3egBwYFK4EEACOhgYkDgYYABABu5bWV
+aQ4EgnXFjojX9df3gBEBipphEEFAoG87GuoWBdlimFC8UEEXiKNU37w0wlJn4bG0
+8uOKwDqBk3uF+DrmZwB45lCSKkjdRWsJeDt+iEuFe2O/mbXoL4p5D8MM2OsDV5GT
+srUbxhXq+T/i5lV7XXm2+tT/7zU8ZQce6WRufbd9KQ==
+-----END EC PRIVATE KEY-----
-- 
2.43.0

