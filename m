Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCC7CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B7D184942;
	Mon,  1 Jun 2026 15:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="S8dkhXtT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D652A84975; Mon,  1 Jun 2026 15:43:23 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A77BA848E2
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xv7ZhmOwCbRq2sAEB4tUYosXW+ApKjjzEuSZ2AdcPrwbYhpV3Qs5Vb2hr0EmvGQkyMOP0Ei+zxdrreDbuQVK6NhzJCIisrySM0Q6I+IpxdVc+MZw/vptcJ+yfFU68Pv/m3m4Xq3XqNwgBUebNZN6OsjC6oBpo8hMq5xTos5r6qYW3xUp+1dJEL7fKEgSt5/qdY1n+rmR+JUnxCDZuOezorRjna4XJuegtsHT3zFhUF+XqDLJ0LkEilNT6XqPyafQmlw6H0Aw6+kMCYrOTLnl9rGerdn05jf94kgESgBFXRpsD7OsWiCC0JFmKNiWA5mJZ0AAN9TBiM1dtHJ73JXd7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mja+K80vo0hZ3viSZujIG7sxz6TK8k795yKkXvQ11qc=;
 b=ppecNZ8SfB7wx5U+SXX+RpnW3HjzDtGXLBSyn/pI6rpuYOq9d5ddPxJCh6nHuBQfzrIZgybhg+8Pl61x/9kNJ4QU5tcTcCInZJzIScnMfAyn5F+tB9dwIEyxfQ4xd0kG6CokptzU00c8uFwlx20vzwPzlXCdgqVbdCmQBQwz8TRUIQmbLcQxbOelC/CI4o862W48sJ7Gg/xZiy7MrHWTcQ4o1uWX1bIoxgKqR3WINMssy5FuFge4c9oV+aN2ez/l+rkiQJYDgpHtj5QaYkRNNgxmkVbb07BWQ2Yw1nKmCbYmLML/Db1+3dSfZ6nLaS/5shBCpANYf0ao3T4deALQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mja+K80vo0hZ3viSZujIG7sxz6TK8k795yKkXvQ11qc=;
 b=S8dkhXtTd8MDY1cqDnWzBfzaFYg7Ke3VVmHBohqGbsoFJAKKrI6SQpi1y3DbFQ0OZ9z9XJGNmp4y3ODC1fBICGIVh3k7k423NXw3X3gm3Hxcw0HbCLGyh6Ggt3ORRjiN7uNkt/2q6lLOSXoJLtRPDrnPy+8NkI4NTVDdxl/1esWg+M4yDI65zni7GpS+GihvyPGP2AF6eAyXO54iEGD8M3Kt2JdVicddfBIAW2dQFlmk/6+VngReRAkeb5BDTgWH31+puJ5rMx003453ZukIfpxPfMKAYpM5OiTNRSYA+Xi0XuB0W9QBUveHNTMchJnF2ToOxNhla3peII8UYyo3Vg==
Received: from PA7P264CA0476.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3dc::8)
 by MR0P264MB4670.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:43:16 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc:cafe::3a) by PA7P264CA0476.outlook.office365.com
 (2603:10a6:102:3dc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 13:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Mon, 1 Jun 2026 13:43:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9B72D2147D;
 Mon,  1 Jun 2026 15:43:15 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 14/15] test: py: vboot: prepare test for global signature
 with ecdsa
Date: Mon,  1 Jun 2026 15:43:09 +0200
Message-ID: <20260601134310.2452454-15-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601134310.2452454-1-philippe.reynes@softathome.com>
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|MR0P264MB4670:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3bc9ddbe-f283-4b6c-4a58-08debfe3bbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: yLShPE+gWeW0YLMjVQpeqvkiQApnNbXG+oKZpLNCsbj7L4UG0rDh0PEAE9UFQTy2rkuHZATwItkJuNAXI3RLBMxJMgKUjrS0yklpUtaWus/OfYihKQCfrhBifumoNOiz8JKPNO415Zs1Xsk3/0mwWtVN4/4ADIWc7839i23JoFnekaBrGd945da+edX0hrv8rMwQM8Bb2FT3bbmhrM6ETNJsHZmsk5rDR0g9aRndztv/kFRKMszTMyu/v4jK6S98jdGSkzBbAcVi3FtWE5TwBWSTa/O1S12K133DZvICZhA21Iqcdk81scREftRrF/a4n7XZDVuClFmJNSLp2ey4g9EO89QuBUHvuEl4rVlPIvEyLi0nPL3k33EvKOT+OudZI05rJ9p17896s1gfbSm22wR/zchmsz2vX2gRDBRF+7JxQ2MKVTZPK5vbIADt/hP7IqRYAWSl8OTQkun2MbVy6O9Fe3USmciv7qDLOgghoua95VmQp4Yb7uTKS3PsQw6x0tiMzFIWLFvzN6J93qw9FrHpHT4raZXNJxZqHpdH0Qrx2AWuii5KrL9wST7oXgKZeUUHthBQb8edd5dpOQ7TpTXCGnemv6lk9XrCWdrzEN1arSSC67NHm76vdd9dFDQ2t0hxRDuCAD16F2JwqyRAEkw9+BapEWAs6vMKLdcdxeud4NANX4au/FGVovH4h4fODQgAwGre5WFfnnSsi6mMzmEqpjkKizACbsIVKXXJM4A=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QjkaHQvbmds1Ev92AIL3kAwZ37Lj9ZmfTD5E5VGtpYQYJDgi5PszYq1KU5r/PY2Bc2PXtd0PjVtHt11mYw6akn/2gZbHuk3DKR24AeAPppgZAYI7uRNXymKQ5Oe++csAH/6oGWLoLEUdglgdqbC49Du0gsSCGKAOb2HbnlLpxlTHYjhqRswa9SssAiqyxyz1l7Yb6uSSoWrU1XFdUTJbeqkdGPSMbYDTGoa2DUl1SWNT1lpSZ8MIwzradICRC9AjfENCjezN2pzcJEpYzi3ZNvixpUPeEL/s4mcJsEdv/FMmBvGILXwMMinPjcmFAQ9AgJoxtvo1JFazB4c3WxH+wD2RaAVZb5iEI0ZnJjWGl4618iyFrBs3ug/XPvXd17iyr5rpbrUMB0XoPKPkXrJ0wqOqUOYLRCpKviF5yJYZDKz9uks5ZX74VfywRz/14c86
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:43:16.4228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc9ddbe-f283-4b6c-4a58-08debfe3bbef
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4670
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
v8:
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

