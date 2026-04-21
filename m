Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5F7F94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 732C3842FD;
	Tue, 21 Apr 2026 23:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="lLWlonnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6BD1842C7; Tue, 21 Apr 2026 23:10:13 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B174D8426E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLAFDuqjNIjgVR78qOw1H+fSD1x2VhB9OX5HkdfVI2bZ3yTkUsNJJEaXIU5lD7hDzCQLloOu1QuxWQtjd6Eo5P+6YmgFOOPl1A1Gf1Rz0tlI52pWs5cf23wcdDxDs4MmEvc3/q83MXvy0oW/qrJJJtdFmWQtXA82ziVJ0ZNg5ulmkMe0FiehAFpTk9tX3ahOcIqUeTcqgncANTTRqe0W9Cl9JNFOguVu66Gf7UQR8pez3p7NydJ5ZB7A2INBNMR2rYnC08z0ugW3l/FLhFYkghEJb3iXlSyzxm6XuR1Nr4a3vxaq/kN1UpbXf8aSEG4D0KCVnKIsWppCz2PDzHI/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kzyw7Hu5ZfRUmK95NqsXRvoWO0GXL7EVVIOh1uAXt2o=;
 b=qJxjgSwuJ18OCBbB0N62fRfT46Avc+mTfu3Yi8bG3e1tX5OggtuGxmcQRhFh6fzTGRxqcg41OLtWdEFWlxzAkQphuPSWCthj69kA5kYIAP3I9EWTBr+2X7WI/ximuHPom6P6I7plgSPtHzqxoOkWmxwzow5VFunHlBY6bur+GxTMAQNnq7tfyXlQWAeI7b5SacsGSGJvRVVldYy2SnV36m6JOgvZ1qKgfl6lzWn0Q2JYwQftM7OEiycgKuwpe9WF003a3pYNkBaLfC8alqqw2BJ9CWR8s96GMKlAxYonHsQJ9Qb+Jlesa7+joCPlmAE3tUNMJCq2yAuusQu8ldZf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kzyw7Hu5ZfRUmK95NqsXRvoWO0GXL7EVVIOh1uAXt2o=;
 b=lLWlonnSvnFyV3XKiVG6kA3wAUU18ba5FdnamxM/+bIcwtLRDWSDg3IFGGUReGjFvKUNgjmXmD4IDPLidt+xTfTGwgM8AebRbC6Pt/tXlBeM+iltAonM20ISSolBmVsPhR/3cS2A7pRlnQEETVYGZ5iBfkXVWSUrUMv08RY/yg26VXYIimNOtXeS4t0LCzLDXfBKxyxqg07fDJEwYzrN5LbxHn8i0BiYebsm5Hpz/yJy6J6O9kaQT9WQtuRsrK95tdpy1eulJlUsl+bTq7ko8BeNCGYesfudqhwwpduSg3RVXEO1QY7OniKkD33xsHr27P3xA14YyLtNs85liQfEKA==
Received: from PA7P264CA0300.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:370::12)
 by PAZP264MB3039.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 21:09:58 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370:cafe::cd) by PA7P264CA0300.outlook.office365.com
 (2603:10a6:102:370::12) with Microsoft SMTP Server (version=TLS1_3,
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
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Tue, 21 Apr 2026 21:09:58 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 321771FFF1;
 Tue, 21 Apr 2026 23:09:58 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 14/15] test: py: vboot: prepare test for global signature
 with ecdsa
Date: Tue, 21 Apr 2026 23:09:53 +0200
Message-ID: <20260421210954.1170437-15-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|PAZP264MB3039:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 528ec4ef-0526-408c-8f27-08de9fea582f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2EjwZ71rWJ7qSDAneXquhgWdr9c4OYkHUjBI+Rg5sSeJoSeFtPCI5fAKBWFvvHpahpJgEwUOSYISVhB+tC56w1w2nAJzG48jYTftEYJ88P9Nk/4KCregenSJOraHTDzhfLNNa0GF5As71dU1vxA2sO6tGUw5fsD8C159P7jygQGhnaDs16o7agHCHxXDvKajk+GfN4wivlUVqyfsK3dCsk4TNLldYOJF/PJqfKs3rZLLR7Mu4tlgcsrQotR306sT3cDEvFRgylPPm2HmnUEe/Lh+7Qz3wtqNdbMwQPYqky5FS9sc9uxGJvC4mjORw7b19CQ7WJk/WIiWue8PYmJhUQQX8ayPahynDuKY0WY12BFUGNd6qMYvod8BmhquX3zA0qWcKTgMva6MApqpFgjg3C+xA4h2a5aCUvvyK1B9g8uw7Vqe2XBXGQ5FfAMVfoXWIvgATv2tlfPNsfhkIU3YJk4HPRevb7ZimTm9D+qlamkgaUClpWbewicIH9OPwNPX6DS84FS3pah1HWEUeN7evmK4biBSWfkHqDIU3XDPFqPPYwknAmpNmu66nhjhb8YfwaV7Ox8d3CqTJ2/emwNDq9qRUPcAkjwlV+UnG/vOM9PxL6SVyhBnTJYtYO4PZfZKCbIpz7XhsbYMyxiMCpRAW0oc+1qsYy6RpKzYFxn3PkKKjQ3sZiW9Y/NI1djAfMBT8eh2LBJmMtrOfrItKlE5ZxR9lRu1/asPV1x+VP0sR/eblYXlTaLxGY/YcN+T7UHwBVsIWu1389ucByzS6Opq+A==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ixx3ZUawltmvNgNRI72Edila51GqjyaeeEAVRIUS/v7IKbJf+ShHrXIPUS2DcYhujOVYf0fFB0wNcDnxE9xBTexbnc/2z0TAGUbeAQkeeShpXuFbJ3ZlR5Zg6UEipIR6aPhBTzEkJ8glWD502u59HYYU8gdkciiy3WweB4NMYMho8WrW3l468lQTGjc+7aNCQTZ77/wkBiNDFh4+keOwSKjvOmgkwkEjcy5SHsniDpMwKaDbCofz+BcUGO3jY8WANICvlhXzAtzrKbdxvhR1ymrkmFjiuhH/D7NJo7GwVzTf5eycQaae7R9XTzAwF/8TXA8FhovyDOSpYRu6fyrK6rsMpmJUdXhaeN0HX2Uf6F8JDHD5ZBfNxYiE7W0uTk4nlaDY5Vmwt0H/7lVONrjZyajKdsMpowr+m9FiuD1Toge+Iorjh0sZSQS+CnbnpIUb
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:09:58.3413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528ec4ef-0526-408c-8f27-08de9fea582f
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3039
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

