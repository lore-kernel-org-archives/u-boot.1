Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F43CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91A4F84849;
	Mon, 25 May 2026 15:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="tKmdk67f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93EC284837; Mon, 25 May 2026 15:52:50 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84041841D7
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOWyAizVQDABW7TsfZxSfgY/h2QQWFWdYXjb7x3DWCXyni04+qUj8yN4HQLvCpUrEtq6mtyQ9lN3M0vHmbz8wkuJyrwJrHHgxdXLQbiH0qCsGPCm51w1PPTmAUEnOp2AFhZGOrlVi/wc9eO8cBCkkH8JtkZECHKx28nCnulWzAhUxK5To4xLUD7hixKAtPu37KU/7+3HYDhzUEKKcBbbkRwJOt1Z88AE7Gf/tT3V/GmQkJ2PTgIjgvmZJwEygYhryX3Y3javXy596h30jqiONa4/hwWCz+A8e6gkr62sBP7eVggTi+JN5Oe6lOINmMxqKtqtUJrf8ThwtFdru7bxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo5iKF7eLqcXxTSoIGzae4kvfaSVTi8dJ6jC1MhdaTc=;
 b=PCtTK8BTkPUWHO5Ft6dKgqiIdQME7sJ7rINh6Cbryac3tAt5XXt9ILb+6xJTVvimRjzLSlKPm9Zw4IfrDZfNdKJE4KSfJLTrkN1C6oSPbntTxiFOQ+g0Q/pEzxCRD6bDSqiyZx3Afj8XSx8ba1DKzv+9O4R8w/Fxfgm61wx2hdsWrZlsSRft0ylWC0pLOUhin6QX98k/XzbxLAVQcREF+e1/8VfmuspXeZMalKm8VBYK1r6m6Cf5VZ4GV0mHY3pmuS8K+RVbCA4LvuBShy5HGVpja+5krPoC/qwPZzLdt7aiGcsxLX1jx0ZoGIb1qYWBXStzu9d+4gz5oxRgbH4pIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo5iKF7eLqcXxTSoIGzae4kvfaSVTi8dJ6jC1MhdaTc=;
 b=tKmdk67fxpVI0FpPtHeZ/70KnxocY9FAzDS3HIsK6Ilz4ic/0uGSiHjM6R/xbqvVn1lJhCtcuR3hEFPSDfux18aZbCIn+tnAkx4NUV5KmdecUPlYICHXL3EeQ4h9btChTYu/EqdkbWLFpkgOCjYKvlCFDHomheQvkTMfW7Ha6YXEKdQSCS8qreIeEzUIeqSQSXFu96JKvuHZPsqLP0pS0+lojYQrZVQyr2MiXTjz6CrNHvfLgrJPS4iSZNyc2d7d4kkpiGDx7/kCrlsJXxlnF7OsLJcEQH0nvu8Bbn/Nnh0Z/I8xDQDA2s6+RGfA2StIltTXIjo6GvKvcYqSVj2EFA==
Received: from PAYP264CA0031.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::18)
 by PA0P264MB7611.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:576::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:52:46 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f:cafe::34) by PAYP264CA0031.outlook.office365.com
 (2603:10a6:102:11f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Mon, 25
 May 2026 13:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Mon, 25 May 2026 13:52:46 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 1866120E7F;
 Mon, 25 May 2026 15:52:46 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 14/15] test: py: vboot: prepare test for global signature
 with ecdsa
Date: Mon, 25 May 2026 15:52:40 +0200
Message-ID: <20260525135241.88348-15-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525135241.88348-1-philippe.reynes@softathome.com>
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|PA0P264MB7611:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9056b06f-64a9-4ca1-1ec3-08deba64e6a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: NR7Y4lYZi59zvy+EMXMSpG3bgDQEjsCZ7Gbonpgy7DQYl44c4qADXLhcO09ON/COKonOczkaVm+oz37n44f6Oup7J7V0Z7xczjdBzsJ5N00ANDOyjGazEp1LUbzz2H9sKuasZu/xh4/iyTCRF3UdlOIXEHyaXw+DUoHZVMXaPVZjEFAq7/rVUJXvky09wl2QgscfmJxAVIWIHpbTmApI2n3xmYkUk5LYWaDWnsD3C7HOw3NGu2vchIhT6G6SgESrE8OIaDUOh6kxUHdP+eTqQMLPA4YFyL+YB83Yi3tPPhEYSZsnpcdHou35x+RDfUEwmr3L9VpmN0+T5ZZ5uMbm2nzU7gpKotEulzlE7Rmhb6QMcnynmQdkEM7GhpfWxmBTcafaG7A38cms8ffZGNvOMx9nGSzvsp2FrPdSDzilux4hii9sOpqYU7KzB1Lk098PZWgo82Osa0LbmCLnH3RLlGPWItVvJRG/9pra6c1ELybAP4ulaZDqjDNkH9Lg/0nC/dE+hS7N7cOUlk4d9T1WchEIQp8xJiVoGcWKrpxn2SwOKaeaf6POzC377HzcGVsac8HrB6Hhp68CPbNVOXxP2ba94TbE/bqJJLUZbPtaw0yBUMWPevsSudJmjhSdOpRMWO9N7ur29yDYpIf/ybFHTSHodorE5IOtyutsag5IBupzY3KIed0k5v0ZSEwNAYssUpAlOAf49vzAce/CKkkaHLLnLNHmGg15z9DkdIvVmZ0=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bxhlnt5Gn1tSAOdU+ZQFgVWZuQvVQW7gWTiRlNw5VbSUeoseroCiPgnhTynwIfhWhNCw/FycN1aH1k6xlanjESm/mw6dxtAeQg3uegpXjRPjc78Ar/ksz3WbG1r9p2yYhks7FUmfmOr9hfhJnYQoxEuENdlJjE2FbPK8xsa+locTF5GkN3X5hZyfohXgyAIZk4Bx7RYxGY2yg0fgU57y0eKQLOaRwVOguYYgpNeEQxs2+68M2p3nqz6SDx4+4JieiICd1bivV2gOgIDQ8yPTu3RXGydUTeSJONTW+gblaVz4NmyqvYhChu4GpnEdRd2Z/mK1em1KzIeIhb1Tk3aBQ/2PGcHK70hOPogil59Jkykf1NU5Dqg37XovZCFV94FTScHUNNWxbGUlw0N3mTzOwDwYO+7rCPQXDaMq0LCBTpVeA1t3+/tjjTA21hIRumIy
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:52:46.2125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9056b06f-64a9-4ca1-1ec3-08deba64e6a4
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA0P264MB7611
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

The vboot tests only consider rsa for test with global signature.
To prepare the integration of test with ecdsa test, the signature
algo is now explicit.

Reviewed-by: Simon Glass <sjg@chromium.org>
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

 test/py/tests/test_vboot.py                          | 12 ++++++------
 ...binman-pss.dts => sandbox-binman-rsa2048-pss.dts} |  0
 ...sandbox-binman.dts => sandbox-binman-rsa2048.dts} |  0
 ...pss.dts => sandbox-u-boot-global-rsa2048-pss.dts} |  0
 ...-global.dts => sandbox-u-boot-global-rsa2048.dts} |  0
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename test/py/tests/vboot/{sandbox-binman-pss.dts => sandbox-binman-rsa2048-pss.dts} (100%)
 rename test/py/tests/vboot/{sandbox-binman.dts => sandbox-binman-rsa2048.dts} (100%)
 rename test/py/tests/vboot/{sandbox-u-boot-global-pss.dts => sandbox-u-boot-global-rsa2048-pss.dts} (100%)
 rename test/py/tests/vboot/{sandbox-u-boot-global.dts => sandbox-u-boot-global-rsa2048.dts} (100%)

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 4e4d9529031..22865f653c5 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -503,7 +503,7 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
                           dtb)
         run_bootm(sha_algo, 'multi required key', '', False)
 
-    def test_global_sign(sha_algo, padding, sign_options):
+    def test_global_sign(sha_algo, sig_algo, padding, sign_options):
         """Test global image signature with the given hash algorithm and padding.
 
         Args:
@@ -512,14 +512,14 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
                     rsa signature algorithm.
         """
 
-        dtb = '%ssandbox-u-boot-global%s.dtb' % (tmpdir, padding)
+        dtb = '%ssandbox-u-boot-global%s%s.dtb' % (tmpdir, sig_algo, padding)
         ubman.config.dtb = dtb
 
         # Compile our device tree files for kernel and U-Boot. These are
         # regenerated here since mkimage will modify them (by adding a
         # public key) below.
         dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
-        dtc_options('sandbox-u-boot-global%s.dts' % padding, '-p 1024')
+        dtc_options('sandbox-u-boot-global%s%s.dts' % (sig_algo, padding), '-p 1024')
 
         # Build the FIT with dev key (keys NOT required). This adds the
         # signature into sandbox-u-boot.dtb, NOT marked 'required'.
@@ -528,11 +528,11 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
 
         # Build the dtb for binman that define the pre-load header
         # with the global sigature.
-        dtc('sandbox-binman%s.dts' % padding, ubman, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-binman%s%s.dts' % (sig_algo, padding), ubman, dtc_args, datadir, tmpdir, dtb)
 
         # Run binman to create the final image with the not signed fit
         # and the pre-load header that contains the global signature.
-        run_binman('sandbox-binman%s.dtb' % padding)
+        run_binman('sandbox-binman%s%s.dtb' % (sig_algo, padding))
 
         # Check that the signature is correctly verified by u-boot
         run_bootm(sha_algo, 'global image signature',
@@ -582,7 +582,7 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
     try:
         ubman.config.dtb = dtb
         if global_sign:
-            test_global_sign(sha_algo, padding, sign_options)
+            test_global_sign(sha_algo, sig_algo, padding, sign_options)
         elif required:
             test_required_key(sha_algo, sig_algo, padding, sign_options)
         else:
diff --git a/test/py/tests/vboot/sandbox-binman-pss.dts b/test/py/tests/vboot/sandbox-binman-rsa2048-pss.dts
similarity index 100%
rename from test/py/tests/vboot/sandbox-binman-pss.dts
rename to test/py/tests/vboot/sandbox-binman-rsa2048-pss.dts
diff --git a/test/py/tests/vboot/sandbox-binman.dts b/test/py/tests/vboot/sandbox-binman-rsa2048.dts
similarity index 100%
rename from test/py/tests/vboot/sandbox-binman.dts
rename to test/py/tests/vboot/sandbox-binman-rsa2048.dts
diff --git a/test/py/tests/vboot/sandbox-u-boot-global-pss.dts b/test/py/tests/vboot/sandbox-u-boot-global-rsa2048-pss.dts
similarity index 100%
rename from test/py/tests/vboot/sandbox-u-boot-global-pss.dts
rename to test/py/tests/vboot/sandbox-u-boot-global-rsa2048-pss.dts
diff --git a/test/py/tests/vboot/sandbox-u-boot-global.dts b/test/py/tests/vboot/sandbox-u-boot-global-rsa2048.dts
similarity index 100%
rename from test/py/tests/vboot/sandbox-u-boot-global.dts
rename to test/py/tests/vboot/sandbox-u-boot-global-rsa2048.dts
-- 
2.43.0

