Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC07FF60FF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C998840ED;
	Tue, 31 Mar 2026 12:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="EYH3LY55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FBA2840D8; Tue, 31 Mar 2026 12:01:01 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E051384082
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Axci7T95sEqyN9zxtiGWp3MBZXKTCii0SsMjziyiYfnQGdjnzERLlTn8eB6dMCqPD/ssK5fDA6YzGn1UcZ9yoSEtcv7IjkBRLmVBrf93eqTJBI6qk4yKjXdzTQJqNfP+RuabjixIZnMA5RTQGNnP/D90D4Jb/8L7q0tQr+cKH0ifx7oJojfbWEk2CKsW4o9I/Puc+HsKD5tj6R3OTHGzIxnIJ9x/zJTLwpi5B2+PgWWL2AcB7+7qho7sqimfKXRi/q4rEKcw/P/OoKe+0K+3qVve6/oUOWfPRPmGZZNdej4xdznt3Y7ZFrA9OWpX4H3Bb7Sqj9Lf4MKmalCLa/70fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcjYy0iUs94fBQyc9JbsAbSjhnLTDT/+AiaoT8fiNBs=;
 b=v8x5xY6Yh0jq4NuL8vAz1BeYSPfplrgPTB6Azcxs4xmc7Cc+8JJFqXbfJj+j3dnGRYGK61qOTGy2YYOMcNlALMSsKS3mZrLCYwk6yAQMDn3A5y5uFBfCjkee9h6H2Wi3+nrWFQ53B97ND7nYyCB72PVU7lhLwyYXXQndMeZMfY/hcw6oaY4AZihh+Umtv2+qlCPRnZH7y+ytptzxnGY0pKKQMqe7b/AAK/6nfCX0ULWspSl4+/u2A48h+TECE2UMEW2UytEKtQf6cEW80H3JWXGfTjpAY8uqg4vDDd4ztUHmA3+t24bxYY4VnGwIVpswgZDGWRLFdY3fQwXY/kws9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcjYy0iUs94fBQyc9JbsAbSjhnLTDT/+AiaoT8fiNBs=;
 b=EYH3LY55xyZBklfTI/zv4jv5BIFatLMSl2Q8cd5Y0aoac+N4tOHCzMThlrhzVTkw8Pqavx+YPmYGKjjhYEipGBdHCbFUPcgSttr2fUJWLjQLym63a3o3Fc1d1zxyh7xdhbmd5GEXQXer1ISjuvmI+JMUDIm7ncTnH4d1Vzj+e5szH2hQ9nQcVE/SPeB5BarbsvL1Z/d5YCZg0NlLVt1zJ9FclpEGpAwpUfDZexOt5s2gGuFrtUBYi/RECiRyrn4pyr66VLeRUyRHk1ATh67qFs+aDgwb31MbKuh9NW1ZK25/iX3kAPdlkxP1CcLVM7Yr/4q1ZKwDKkEO8xXEdxhb7w==
Received: from GV0P278CA0022.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::9) by
 MR0P264MB5289.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 10:00:53 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:28:cafe::93) by GV0P278CA0022.outlook.office365.com
 (2603:10a6:710:28::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:53 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 7EF6220933;
 Tue, 31 Mar 2026 12:00:53 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 14/15] test: py: vboot: prepare test for glocal signature
 with ecdsa
Date: Tue, 31 Mar 2026 12:00:46 +0200
Message-ID: <20260331100047.34618-15-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|MR0P264MB5289:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6e5daee6-5f55-4596-3090-08de8f0c656b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vNfXO9arlaTioJUHzKT6y1zyGoLDWN5Vcf2igLzJSRwOchHrlP7wGa3w3epypKkxTJFBIlGxfgrCygclp3G6Sh8/FDcB2T8fus6RZvxZ2cLFzpfOvnWriumekFHxo/lEH85RPvcgzmsGWJwGntThOCkCfJk2HMVTXokqLvxEj4QYyN6K131JZ66MdLG5TOti5IT8hncsE6bID3LHqyXjtWnAvvng/210KdMCEFVf0aqRvLqVftDqboYzpQMurmbG9dT4yciWrLb0PGREvW0UZWXwj/ThQ7rNQqUxK3S+oYBcp5HnucOTYA59ILERB397rjy5LBB+EW9JSx46sNyIYku0gbXLagssK+SSgXR2LvpFMW30wv5pavCuQt74QhgksfK+8pnFlFqoNSDt+k3SztZLzAwa937K10ak8kSyDyn75b6Xnmf86+rFySGGtCW44fQT8fZcjgfgSVOSAYyoi/ejS/89ZMJT1PGs/y/A7579WhNhJoQnmgCm8JesnyI8+EfOE9FBCY1OEnxu33RWcluTWo8hMV2hQ3LNUC0feSngRyzO0QL1GljTTY83wLZjhnWpS3siZDbsESYAqvZ8H/mkzNCwKta+fCt76UZJhHhc+k8lfeNjlDXXkljSlSR9WfbWh3razA6wJUVveL6q7MnVspvVu5la9Wy3C57gUUHITBj9UDpvRJ8WFyFZ1cmeKOY/Zssu0VPkFQ/kW5PzKfQ6Au+GX6roJa6rdynNChJQlwabYuQJ4q9cdyhnCxXXmidwpX4Xt5lH2lZjMyA6Dw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TRjMW6kzNyiF5WCEGMLj5EQNX7vOK8okK1Y89cU4tMeMlAwI1Hkqp/L1Rzm1DLCkOpLb9L4Fu7Xf+9HG/JpfaR4PmmmRlI99UyoEdfDpfiWeOI9pH9s9R9RWstQgdQo7rz9Nbrt8TuHBUoTv4AVlSC5xhlXdtFURAlfQEGpUU1s6Qvi9+Pp+mwghuoEdJ7MMcEsUBM4zYiWxigGAsC1KziV6sdEo3//Pv06JhnqMjdDUOVhUzc6QMZUJ5XL58RpjYDN55PanLWaJU1P5chioMQ+dx4jsCrEJF+7Qu37devBmhvc0xIs/sPZ6+1U9SkeEwHX3FO9UskGXSAVVL9ta8/Krv3YoBW4tY1S2yuVHEHRkc6/9SOmGCNQJKWl6WzBQgSUkwPRRMoLB7z9PZgzg4uYBggOarWGPLSaFSGfud+TGmuttewHg8/jjwYVGQFdT
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:53.6550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5daee6-5f55-4596-3090-08de8f0c656b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5289
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

