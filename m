Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40479F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 186EA843DC;
	Fri, 17 Apr 2026 15:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="e6NDfl2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD2A84319; Fri, 17 Apr 2026 15:02:21 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A09E84347
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHnKufSdSsANXfXPImGAY4MKC5a70Hn0Zl3m5/CG11GSwFT7Ufn1x85xFGU2nep/RlPeenKJ4LV94A2D5P/XRLn4ZDgWVHwIDLjkAVfOK26j1+wO+BgYaNwIM4HhgeuCtd7XhyAjZf8VqUnC3I0kUCEDk9iMbSg+S00C5a4VSGynXpNzhG/nP+TMsCL2JO6Aaln9Jkje0HwY7iw6rt7vMZgPo4a5Q4Jc8JxYQf2qxaggpANp9BQJe4Y8t6danQ7BVMI3aWSPhqVFPqR4+9/X6NPobLAud5o3mVCo25a0dA9aaum7dHiUugTdG84CXt+8J6j5E0Cx9qn5WnL4agETyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQnMRS8Fa8Upq1gqwXpFyyITt9Wx/P4xSvQ7fcX0I5g=;
 b=xsNcnbVd1P+2tT0GT1i6m0KAK3Tkf9BLx+CPGvt+qrBq/Gw2pJKTatA5DvIjf6Lg2NNEjnvbPMJpAvUxyYaWtqT4WhSBGnn/YcQSPzRV8dVvw68cIgasJqYY7GKLC0P/1Qy5afhfL8BGLCr9/EaEPJ8aco8LUHwJA8ysQmCjcX4LK+jwtg4pvzyNZ4pra+dn6moLZKV4Ce2ZceuEnpkvM3jffkCC5M/V0t2Uo9lTZ4NeWiYNV6NiJrNRPGTwCf+kgA5RFICVYD6eekaulrmrZXM1PLFBBolK19NdYz5QkbfEvYZO754XmPHQayBoqlICodv5d1w5VD3ZOknkly1a7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQnMRS8Fa8Upq1gqwXpFyyITt9Wx/P4xSvQ7fcX0I5g=;
 b=e6NDfl2RZ35BAGZX3SW4jyfHkXR/IadBOftrh1MykjfpxkzpJie9++6aueu3/fzvDuM8DYLwjnXJaD/xAjIfZZvGAu4DXW7SnXtVCJpAO5IfouO1lmRlOtrBSZe6Qc6R/O7dnXYVKarPNK1YgKA7rz9LSEfMnyL5wMT81aFECYyAXK2+g6fSctJR+WctwD/RBLSFVsXguO/gb8lOB268afTwsQinMoOAs+ATzbesfHJ6D2GXa3B0cUVBUFY+eR/GX8H4lvLWI6SjHXmHLP2+k9ANqF43/vMvuLXJH39y7n+9nqEkArkb+khqGU6kHMLWHZO0O6k3AVCmYVKk/HRzig==
Received: from PA7P264CA0182.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:376::16)
 by MR1P264MB2724.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:39::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 13:02:10 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376:cafe::1d) by PA7P264CA0182.outlook.office365.com
 (2603:10a6:102:376::16) with Microsoft SMTP Server (version=TLS1_3,
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
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 13:02:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id A996020E61;
 Fri, 17 Apr 2026 15:02:10 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 13/14] test: py: vboot: prepare test for global signature
 with ecdsa
Date: Fri, 17 Apr 2026 15:02:03 +0200
Message-ID: <20260417130204.49896-14-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|MR1P264MB2724:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6dd19c64-a297-43e7-ece0-08de9c8189b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JsfNbq1ufhjS8Inxl8it9O/R6pLmbCr5ygQBhp4a7wVCypI52Uylby4Ft01AC3Ud81+UjPftYf1y7mbGUS1jLjNjslJi5lYbgUxXadSZyFIoOPPaY94pdsITBRhlK3FoPaMNhJMLYERJGcipj1K5k9lM5LTJTNRQHS5DRgpPIGfYxID4Bil8+oqV786d9zx1nSfjP+pmRgMbqPKbAbURQ7EZHh3KNsZ4BkOOlKSKli5eKXD0C+t3nWKjlSpmBq0tuMluyQG5V4iwnoLA+Qw/gVes8ajMwTf7FjG90l/X4SdBERkLL05t3BRncXm5PvqXCxMJoW/a0R1F8RZtiOvC+D1RXal6xJPExYPsjZP713Sj6AqqFfAWuB5tya2ggum4tb+GcjMFprL8u1XEesf/KqQmEQJWC/EauEVnBGoMVYoIbAmNq6M3vAlzK5zQX3bJr9PG5vPkb32c+F2Hce6sqRZFjoTAKecMJ39YZFJ63rDq2iSyQi2tA8U10yVEEWFn7iSGJMoveh41+VRpLz7Ot9/ffSBB8N6JY25uBEwVd78DbghhCUMHN5cq17qwae7qSo0qN7q5DzieIdDjZblbAxyY5CgFqnJf6uC//JzHXx3SG7FgCQgx4YEEzaFrsANljSKjf0/IpgUfU+A/XYmWFFxJN6RJKhIdGDRKK+NWsUCKNKl9CffOYF53bhVb08r+woAvyU8y56u6wfxQu0wg3jUxeQtwf4BlhjBrmbydgKDBPIMcONUwOeDTw0L2oVG5tKoLKn6oSuD+vc/kwdvQWQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B61d3zbcqXBqgW6N7GciI9Fq9K/pW0Rz/wHj+g81fDUkIvyVO5QdKdGHwVkulnlC+J79Puf9rDsimPErosfehpLznoRRrqBPGWIU/eNWtd/KE7H825JYWy/rtSwZpJ140wNYbv2JUUQXwTg4JQda0mRO4SbV2xE4L5T6fzc/x3RVvmWs6rtrv+YfumZtKeR3mQQ0SOgXnxcNnTyes2troc9tVfnZKhtDZS1+G7TI6+8gKevX2Cy+tWkFrYVv4gno8brYojgTESEYsLG6eBQ5ncDRN63IzB8rivJuRjUgske76s7CdzEC5LivfZC50g2VCPwaR1aAHmXrpHDj2eg3fGVpypCtBE8ZzyVHco8+JAq4DUVsF/fw5fxv6FloyZr3ttjFnAJXuY+V4/svqyVRuc2xLANDGJm9PogjUj1/obwdRuTE4Bh41uPumTfTtzAW
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:02:10.8004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd19c64-a297-43e7-ece0-08de9c8189b8
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2724
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

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
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

