Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DE8CD5BD1
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2FFE846CA;
	Thu, 28 May 2026 10:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="djIRGlvN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33DA8484F; Thu, 28 May 2026 10:19:26 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF3C846AA
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXv2twDScL8b54mvdJy3z1bDuPK6Ekb0n7SvpLS0/Y2ZESux4MI5ynS3Ih8eS/y95O3VAc1mvZH5/8cq7h13m0FKi5AKokGVMtJZRDLgkXAy3HnUcunvLIjpd5XVFNLa99voVqYBUW9Pw3EZGhVHtLPheYb56jR/WKNBK9ctaCQKsi94mYMTac8rm5aX34DCcPK/w+d60nE4BCGgivxx5q/bf8crChk37+YmMExwoK/zEYXyX3EdqCuQqQSyLM4oX9mUBz9HzJTs3YUMu/i1aIdsWm+yv0VNnbEforcLMObVnGeq0wjCMpjFbsKBjpT0IgFJ3F/gZuXwGsXhHVsxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mojd3TbAy4nhmppS8vp5LxyocF5YK5lhF6wxUtf6lmU=;
 b=MDOOm/w0GvuDuKFzaL6/bad62uR8gjYg1YRSM1YeBRM9ftIgEcYW5GUOyIE7xpSoO71qdCF1O2R3HhQAJcLj2jHyPHDoAhT2SLAlNsb0VnkIVxall76l+rENkxnKI3NAuYbpl0pkgpexN2yTwPFxKuW4P1+F1E7ZB1FT6BE/AO3UkCDcPNgYsPl67wvPUpq415+KYVCuZ1MLgZHtJDqeyHKBG+0yjtF66UKPyIcVLxHqbuAL0ZiS//jSsZrY9zrqWXUxwwqQkFUZVE0w7K1o4n54RE5xt+ohnUJrBS5am/IIcwqiMYDGUP9kzh1dQXU3vQw8Psz0IlnG+oQoUWAMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mojd3TbAy4nhmppS8vp5LxyocF5YK5lhF6wxUtf6lmU=;
 b=djIRGlvN4iVEaef/s2NfFfGFoioJshqInIZUCH4vMGTjAbqik+QErqET8g4n99Lqycz8fWt3MfNzLN5EACgzYfuaICq2PhMcei3StL2wYezBC1uQEx5Fh8ImQDdG1WROq7qpGcSwChXMIAvryqXUvPFfSi+KVfYVdE7iS/ERcAx6hk4cN+o2kHKicIXosP9B1Xs/w0K5W42efr/h+Yzzr/JPtEuz9dNOXxppM3XYK2ibfQlIy+bmK2rWdAbCL90Xp6oXnzMPRd+Bj4PpMrl5gcy623+Dl5knt1I1H5RSu0mA5SMaWFKXegmKN1+llXgfwedqgWMwth1qPQfEMGjfaw==
Received: from PR3P189CA0001.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::6) by
 MR0P264MB7245.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a5::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Thu, 28 May 2026 08:19:20 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:52:cafe::2b) by PR3P189CA0001.outlook.office365.com
 (2603:10a6:102:52::6) with Microsoft SMTP Server (version=TLS1_3,
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
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:19:19 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id CCD4320737;
 Thu, 28 May 2026 10:19:19 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 14/15] test: py: vboot: prepare test for global signature
 with ecdsa
Date: Thu, 28 May 2026 10:19:15 +0200
Message-ID: <20260528081916.11355-15-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528081916.11355-1-philippe.reynes@softathome.com>
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|MR0P264MB7245:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b83be0e7-2afd-4e60-ba21-08debc91d140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: YmtauZygh3aNhrdL4WWPltpO7bZUfousn/evTHzJk5IEoVN09FmzGuONBUgIcCJ/EMWWrmIo2veExAmfmov/8SXL28nRUk95rl1FsJL43ouIIgapLrHJ1xOVgJjO/lNBWKdFIwLGEw2EL9e+t0NWj1wxvpq0wCjjl5Ece9W3HWhj+5SAFLZR+h/DHD8FhvhYHmqsmDbOUiAqM8lcgtQJsV2dNl5oKjq/BEwNt8hkEo4hWs/g5lJiFVQlfkYG+wQ7b8yE+sUxn2PdXnG0pSR6DRyDLrB59GPiHXpupQvTT5g3mJdYdHV4cHR5rALXMdp3i7+Fp8J9bc32odMNAZecSPBE2Ur3MuFQIfvdG2Z75Nbb5/u+dFmWBpXAaqqa0yhOy5san1P4ALT/fVPatxYqpspylFdhhs7GFtliApW9fuCSMGdtwhXbw2QIlecY2qHQn0E0Fi7f3JvujOFeR2ZZaz6OKNOrds3tm9dwYv0oh86B3MwuUy+2t7NpnSN2jW6ztCCl/l+4MNa88c6862I9u2cM0WoDDSTG71aeR+HlwD2fZwShWQSi/Ip76DsJo4TWbll5+PivsnuhQWdcA6Gopgjo6uccQOQVXCuWgQgZrwpzJoVLRiHWfeu3YOzvGiigVhjXDcjur0wmfUhLwXBEMdn4/TS2vz2xwA4UYoa/GkCMj8RWFIKx183bcv5CPNgFA42L1av9tkvy7LaiD+gZLQG0mV4d6R8qFaMPwG2yU6A=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 64HA8rS9yUpyn7/eXdBIyxIP9tMTVgisxrHae9VFsGBtTC6j0OBepmchxN3ZObqLHYI4WYkeCtMkJsWWF9FqCrk8qUPMekQu98Cn2znJyLVwCAZOFyDb5aKC0BMa3d29nVW06Jjho8XFSHrlhAYDeuX/P5M5iIkQPw7OVV2iWGW4NE97+lOyIA17qwGn2XFMzTih6LkTpD0jDRkFLh34i0zG4+iyHHBNRuf7veALy2D+DNgy0SjvuEz8oDAMS6elkLKoRB4BYB4xtR6t77hHuGs1ObrjniRxAFjQUg8F9Af6PKMC7DodWesmtj5TdzX6MAsiLstcQKL2PG7CkZHQrIsHXWwPYIcvudUJdhUtQyEVVUvn70GltMxQCtD+mduORj3hJvJOoxkoLilPUYRBnix8Qczbdv4cSecnhOz2tr2LOpqPrY5X+9PU/65TuQvU
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:19:19.9662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b83be0e7-2afd-4e60-ba21-08debc91d140
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB7245
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

