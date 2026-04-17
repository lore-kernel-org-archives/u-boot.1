Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9755BF43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AB91843A4;
	Fri, 17 Apr 2026 15:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="k+DDadeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54F9C842ED; Fri, 17 Apr 2026 15:02:21 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E2E84320
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQfX3+jMc+Wp5IF5BzwfGDCdEwdqlgF84gZAPzBiw9Mv5VtfcbW6A1xc/BvceyO8Yt/3High1aR1BoAw8aDG53D+blzvlV5LpBr2YHvHQ+nA68Z/99wTVMSdxMmlgISI89XEhqdtjpeoERr3hoAqFzm6wvaboxdRyVgC+kVyMrT8bJrCMuLEQa0y3mt3L3TeymvmeNY6LerIkfTgt39SDif09tKYFe1eQdgaAZBoy2Y5sQ0/ra5+cbDDVeEAxpD0/EEsJz+B+fZFnt9y7BPrO/pR49cySF4x9q/ideIWohYqz3P6/wpeEQ7iX2mvfmCJlqst7OsgcuMqVmGzmNoTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLPIIjt9Qva5Q645iFfhCiy7EW2/P+qz+kQCpwOn73M=;
 b=NxsZn9cSFDLujwT6tMryi6XyEy7A7Scc9vsYVGJMpRAjCueVA5RDRKTCUKQ8yhHw2a6/+bxtebJTT3aV1UDZAwQEIodIp9HbFpMHiAHrKOjexKr4Ao1r/HCWWeo0M30LBVJitJwKar/trOYHyBpZlWxlkKS6LfqUpfvkpbq690oxrfWeO0Av/AY1tqEUHAtzbcD8+LkLZMzHpHIH4FI/7Jwl4zH0ojJaQ9/aYiyi0DKdfkrjOF4Y1kv7cVyC89u4leJJnXT0+BR4HZ/DzVjuOGS66fe6HaZgfMDz2tCbz5agaS276FuqvXmyFVyS/CknkfD8DGLihHlOm30ON11y7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLPIIjt9Qva5Q645iFfhCiy7EW2/P+qz+kQCpwOn73M=;
 b=k+DDadeSlMpCnQuUcNfbNrZKBvN1elWUynaUIUWy3yViCiumCtffCNUhu3fScPgQgqYQe7uh8rNa8ZG6vXN5qVC6EQgx2aW+52I9yr8hGrixlC38TuEXRVqCXNTNDM+JEBGIsd8e4viZLnxRdfjIIsz3078ASGwcasFAd47AXUxRqVVuQ6kiEw0X+9Thbrz1ifmIDSO62F4YzKxeZTE7Ih0NNEAnEq9cXa6YgknUfdhu0YNSdiXI21Gt1fJ9472DprUFe25gCUhHYZ/x/UExpJtdr0ABIfScoxFb0oGuIyxBjy7jafd+SAVyfdUp5XcvQTyOBKvIkbj1KqguJoZekg==
Received: from PR1P264CA0047.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cb::8)
 by MRZP264MB1752.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 13:02:10 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb:cafe::52) by PR1P264CA0047.outlook.office365.com
 (2603:10a6:102:2cb::8) with Microsoft SMTP Server (version=TLS1_3,
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
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 13:02:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 2061220ED9;
 Fri, 17 Apr 2026 15:02:10 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 07/14] test: py: vboot: prepare integration test for ecdsa
Date: Fri, 17 Apr 2026 15:01:57 +0200
Message-ID: <20260417130204.49896-8-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|MRZP264MB1752:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 79945d9e-88c3-442a-8cb7-08de9c81897d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: KUxFFKs1ETYEhEQgZNYcGIzTZ5u4XsHDOrjDV/fGSgbfxfO6xdaUmO0jlXm+08Z2SGBStqMg7jwMa4q4foHVeru9hVqUGDO0s4mF7WQ5my/GkRpVQLGuVNOSv0OU8ula/PJsIIkOYFKit8ciuSQoxBZSKX5LkSKy82c5TPnsuStyQ99wOPdozqW9xYHzzQtVIkvjuAiuc+WRZhjviVFmwvC6yQz2nLFKxsHeCWuh6HyLCq/H6g5diit60LUTLvGt+c+k4aI3+JafuXoJRwFhTWkv+6YLQaXu9aSAjJtgQmpEjOQsOgXXet2RIlZTTC6uEg8SyVBIFmg5CHOpUu1cU8TQB0UfkqU8AXAknFJwOsWBglw4YDYF7FCF0QH593ODWicxFOE1pcxUg4SNYV2TNrwJ/4YSkvL05Bf13JZorZXSjCJfD12ZzW7IGsySFhG2lpGPPKcHdc/W/8rr0hNGF1r7l6+w/L5uI9RxPf608VUPdN8sCwte0JMr8SExQd8oSVDVDq9eVM4BOkrc9izN+Wwhk7Otn/NBVKX8x1zltmOLeg5s5Mw8A2TUeO7EcG6shh4sJfUUGy0wmpfUZkBrBmld/rG0qQMrEO2We5rnGfn+HczfaWrzHZrSCadBtDjIqzprOardkHUJrCHyhapx1EItvBwa3aZMpI7Bo/2xGep7gHhVlYWYvNYerNgWPs3vhB+lE6xcZuzuUyX9Apm+Sgyxyiw7nZhkaa48k2sOiEniMQw16G0I6rAjh+gcl49yvnnoo3vVe5LfnKS17FrYBQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +gF8PVd+pBKxOC1KKnSZSn6dZu0t+kNGHAyq3+392XEnWedspQYjo3ajrgjoTAR+Rpm/IXX27vUfVZlTU53cD65BIpn39r7wYLYgBpVklBGaeU4PLu5vDs4Z4Uf7VnXkMrqxxXTU+aPIL+FReZO2Ube5Rr3SoS6gBxcIJWkDulJCIWahWKs3E4NKbjbrCYtrnlSQcWvL36WNqtO3uwLouBNeZDWvcT9AxMzHTXtp59sUzNbIJxTpIOW33pipuEAzabqFtThdmDivPXgzw1iGz2b/pI8hy9Jos1f4dUtLjIYfVb1rBo6/fA8avJQ5vpFHi+FSH1ShqZhkMz0ZRb19Tk53yvH/7vAxOE+dlBY/bah6ka0i8cL9C++aqyc+Y61P9hhqaXib/d7OO8Js9x8sotnzzJYsxSnsxvfwyLtue2g8b/zed2Evbh+QqZrQYFUg
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:02:10.4116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79945d9e-88c3-442a-8cb7-08de9c81897d
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1752
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

The vboot tests only consider rsa algo for signature.
To prepare the integration of ecdsa test, the signature
algo is now explicit.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- initial version
v3:
- no change
v4:
- no change

 test/py/tests/test_fit_ecdsa.py               |  2 +-
 test/py/tests/test_vboot.py                   | 99 ++++++++++---------
 ....its => sign-configs-sha1-rsa2048-pss.its} |  0
 ...sha1.its => sign-configs-sha1-rsa2048.its} |  0
 ... sign-configs-sha256-rsa2048-pss-prod.its} |  0
 ...ts => sign-configs-sha256-rsa2048-pss.its} |  0
 ...56.its => sign-configs-sha256-rsa2048.its} |  0
 ...84.its => sign-configs-sha384-rsa3072.its} |  0
 ...s.its => sign-images-sha1-rsa2048-pss.its} |  0
 ...-sha1.its => sign-images-sha1-rsa2048.its} |  0
 ...its => sign-images-sha256-rsa2048-pss.its} |  0
 ...256.its => sign-images-sha256-rsa2048.its} |  0
 ...384.its => sign-images-sha384-rsa3072.its} |  0
 13 files changed, 51 insertions(+), 50 deletions(-)
 rename test/py/tests/vboot/{sign-configs-sha1-pss.its => sign-configs-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha1.its => sign-configs-sha1-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256-pss-prod.its => sign-configs-sha256-rsa2048-pss-prod.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256-pss.its => sign-configs-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256.its => sign-configs-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha384.its => sign-configs-sha384-rsa3072.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1-pss.its => sign-images-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1.its => sign-images-sha1-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha256-pss.its => sign-images-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha256.its => sign-images-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha384.its => sign-images-sha384-rsa3072.its} (100%)

diff --git a/test/py/tests/test_fit_ecdsa.py b/test/py/tests/test_fit_ecdsa.py
index 3e816d68eb6..e59390374af 100644
--- a/test/py/tests/test_fit_ecdsa.py
+++ b/test/py/tests/test_fit_ecdsa.py
@@ -102,7 +102,7 @@ def test_fit_ecdsa(ubman):
     with open(key_file, 'w') as f:
         f.write(key.export_key(format='PEM'))
 
-    assemble_fit_image(fit_file, f'{datadir}/sign-images-sha256.its', tempdir)
+    assemble_fit_image(fit_file, f'{datadir}/sign-images-sha256-rsa2048.its', tempdir)
 
     fit = SignableFitImage(ubman, fit_file)
     nodes = fit.find_signable_image_nodes()
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 55518bed07e..496d314c649 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -84,21 +84,21 @@ def make_fit(its, ubman, mkimage, dtc_args, datadir, fit):
 # Only run the full suite on a few combinations, since it doesn't add any more
 # test coverage.
 TESTDATA_IN = [
-    ['sha1-basic', 'sha1', '', None, False, True, False, False],
-    ['sha1-pad', 'sha1', '', '-E -p 0x10000', False, False, False, False],
-    ['sha1-pss', 'sha1', '-pss', None, False, False, False, False],
-    ['sha1-pss-pad', 'sha1', '-pss', '-E -p 0x10000', False, False, False, False],
-    ['sha256-basic', 'sha256', '', None, False, False, False, False],
-    ['sha256-pad', 'sha256', '', '-E -p 0x10000', False, False, False, False],
-    ['sha256-pss', 'sha256', '-pss', None, False, False, False, False],
-    ['sha256-pss-pad', 'sha256', '-pss', '-E -p 0x10000', False, False, False, False],
-    ['sha256-pss-required', 'sha256', '-pss', None, True, False, False, False],
-    ['sha256-pss-pad-required', 'sha256', '-pss', '-E -p 0x10000', True, True, False, False],
-    ['sha384-basic', 'sha384', '', None, False, False, False, False],
-    ['sha384-pad', 'sha384', '', '-E -p 0x10000', False, False, False, False],
-    ['algo-arg', 'algo-arg', '', '-o sha256,rsa2048', False, False, True, False],
-    ['sha256-global-sign', 'sha256', '', '', False, False, False, True],
-    ['sha256-global-sign-pss', 'sha256', '-pss', '', False, False, False, True],
+    ['sha1-basic', 'sha1', '-rsa2048', '', None, False, True, False, False],
+    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False, False, False, False],
+    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False, False, False, False],
+    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
+    ['sha256-basic', 'sha256', '-rsa2048', '', None, False, False, False, False],
+    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False, False, False, False],
+    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False, False, False, False],
+    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
+    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, False, False, False],
+    ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', True, True, False, False],
+    ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False, False],
+    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, False, False, False],
+    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, True, False],
+    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False, False, False, True],
+    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False, False, False, True],
 ]
 
 # Mark all but the first test as slow, so they are not run with '-k not slow'
@@ -111,9 +111,9 @@ TESTDATA += [pytest.param(*v, marks=pytest.mark.slow) for v in TESTDATA_IN[1:]]
 @pytest.mark.requiredtool('fdtget')
 @pytest.mark.requiredtool('fdtput')
 @pytest.mark.requiredtool('openssl')
-@pytest.mark.parametrize("name,sha_algo,padding,sign_options,required,full_test,algo_arg,global_sign",
+@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,required,full_test,algo_arg,global_sign",
                          TESTDATA)
-def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
+def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
                full_test, algo_arg, global_sign):
     """Test verified boot signing with mkimage and verification with 'bootm'.
 
@@ -287,7 +287,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.key '
                           '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
 
-    def test_with_algo(sha_algo, padding, sign_options):
+    def test_with_algo(sha_algo, sig_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
 
         This is the main part of the test code. The same procedure is followed
@@ -308,7 +308,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Build the FIT, but don't sign anything yet
         ubman.log.action('%s: Test FIT with signed images' % sha_algo)
-        make_fit('sign-images-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-images-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else 'dev-', True)
 
         # Sign images with our dev keys
@@ -319,7 +319,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
 
         ubman.log.action('%s: Test FIT with signed configuration' % sha_algo)
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         run_bootm(sha_algo, 'unsigned config', '%s+ OK' % ('sha256' if algo_arg else sha_algo), True)
 
         # Sign images with our dev keys
@@ -383,7 +383,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             run_bootm(sha_algo, 'evil clone', 'Bad Data Hash', False, efit)
 
         # Create a new properly signed fit and replace header bytes
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
         bcfg = ubman.config.buildconfig
         max_size = int(bcfg.get('config_fit_signature_max_size', 0x10000000), 0)
@@ -415,7 +415,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             ubman, [fit_check_sign, '-f', fit, '-k', dtb],
             1, 'Failed to verify required signature')
 
-    def test_required_key(sha_algo, padding, sign_options):
+    def test_required_key(sha_algo, sig_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
 
         This function tests if U-Boot rejects an image when a required key isn't
@@ -437,12 +437,12 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Build the FIT with prod key (keys required) and sign it. This puts the
         # signature into sandbox-u-boot.dtb, marked 'required'
-        make_fit('sign-configs-%s%s-prod.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s-prod.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
 
         # Build the FIT with dev key (keys NOT required). This adds the
         # signature into sandbox-u-boot.dtb, NOT marked 'required'.
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit_norequire(sha_algo, sign_options)
 
         # So now sandbox-u-boot.dtb two signatures, for the prod and dev keys.
@@ -454,7 +454,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Build the FIT with dev key (keys required) and sign it. This puts the
         # signature into sandbox-u-boot.dtb, marked 'required'.
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
 
         # Set the required-mode policy to "any".
@@ -534,8 +534,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
     dtb = '%ssandbox-u-boot.dtb' % tmpdir
     sig_node = '/configurations/conf-1/signature'
 
-    create_rsa_pair('dev')
-    create_rsa_pair('prod')
+    if sig_algo == "-rsa2048" or sig_algo == "-rsa3072" or sig_algo == "":
+        create_rsa_pair('dev')
+        create_rsa_pair('prod')
 
     # Create a number kernel image with zeroes
     with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
@@ -554,9 +555,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         if global_sign:
             test_global_sign(sha_algo, padding, sign_options)
         elif required:
-            test_required_key(sha_algo, padding, sign_options)
+            test_required_key(sha_algo, sig_algo, padding, sign_options)
         else:
-            test_with_algo(sha_algo, padding, sign_options)
+            test_with_algo(sha_algo, sig_algo, padding, sign_options)
     finally:
         # Go back to the original U-Boot with the correct dtb.
         ubman.config.dtb = old_dtb
@@ -564,21 +565,21 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
 
 TESTDATA_IN = [
-    ['sha1-basic', 'sha1', '', None, False],
-    ['sha1-pad', 'sha1', '', '-E -p 0x10000', False],
-    ['sha1-pss', 'sha1', '-pss', None, False],
-    ['sha1-pss-pad', 'sha1', '-pss', '-E -p 0x10000', False],
-    ['sha256-basic', 'sha256', '', None, False],
-    ['sha256-pad', 'sha256', '', '-E -p 0x10000', False],
-    ['sha256-pss', 'sha256', '-pss', None, False],
-    ['sha256-pss-pad', 'sha256', '-pss', '-E -p 0x10000', False],
-    ['sha256-pss-required', 'sha256', '-pss', None, False],
-    ['sha256-pss-pad-required', 'sha256', '-pss', '-E -p 0x10000', False],
-    ['sha384-basic', 'sha384', '', None, False],
-    ['sha384-pad', 'sha384', '', '-E -p 0x10000', False],
-    ['algo-arg', 'algo-arg', '', '-o sha256,rsa2048', True],
-    ['sha256-global-sign', 'sha256', '', '', False],
-    ['sha256-global-sign-pss', 'sha256', '-pss', '', False],
+    ['sha1-basic', 'sha1', '-rsa2048', '', None, False],
+    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False],
+    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False],
+    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False],
+    ['sha256-basic', 'sha256', '-rsa2048', '', None, False],
+    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False],
+    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False],
+    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False],
+    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, False],
+    ['sha256-pss-pad-required', 'sha256', '-rsa2048' , '-pss', '-E -p 0x10000', False],
+    ['sha384-basic', 'sha384', '-rsa3072', '', None, False],
+    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False],
+    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', True],
+    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False],
+    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False],
 ]
 
 # Mark all but the first test as slow, so they are not run with '-k not slow'
@@ -589,8 +590,8 @@ TESTDATA += [pytest.param(*v, marks=pytest.mark.slow) for v in TESTDATA_IN[1:]]
 @pytest.mark.buildconfigspec('fit_signature')
 @pytest.mark.requiredtool('dtc')
 @pytest.mark.requiredtool('openssl')
-@pytest.mark.parametrize("name,sha_algo,padding,sign_options,algo_arg", TESTDATA)
-def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
+@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,algo_arg", TESTDATA)
+def test_fdt_add_pubkey(ubman, name, sha_algo, sig_algo, padding, sign_options, algo_arg):
     """Test fdt_add_pubkey utility with bunch of different algo options."""
 
     def sign_fit(sha_algo, options):
@@ -609,7 +610,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
         ubman.log.action('%s: Sign images' % sha_algo)
         utils.run_and_log(ubman, args)
 
-    def test_add_pubkey(sha_algo, padding, sign_options):
+    def test_add_pubkey(sha_algo, sig_algo, padding, sign_options):
         """Test fdt_add_pubkey utility with given hash algorithm and padding.
 
         This function tests if fdt_add_pubkey utility may add public keys into dtb.
@@ -632,7 +633,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
                             'rsa3072' if sha_algo == 'sha384' else 'rsa2048'),
                            '-k', tmpdir, '-n', 'dev', '-r', 'conf', dtb])
 
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
 
         # Sign images with our dev keys
         sign_fit(sha_algo, sign_options)
@@ -654,4 +655,4 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
 
     # keys created in test_vboot test
 
-    test_add_pubkey(sha_algo, padding, sign_options)
+    test_add_pubkey(sha_algo, sig_algo, padding, sign_options)
diff --git a/test/py/tests/vboot/sign-configs-sha1-pss.its b/test/py/tests/vboot/sign-configs-sha1-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha1-pss.its
rename to test/py/tests/vboot/sign-configs-sha1-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-configs-sha1.its b/test/py/tests/vboot/sign-configs-sha1-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha1.its
rename to test/py/tests/vboot/sign-configs-sha1-rsa2048.its
diff --git a/test/py/tests/vboot/sign-configs-sha256-pss-prod.its b/test/py/tests/vboot/sign-configs-sha256-rsa2048-pss-prod.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha256-pss-prod.its
rename to test/py/tests/vboot/sign-configs-sha256-rsa2048-pss-prod.its
diff --git a/test/py/tests/vboot/sign-configs-sha256-pss.its b/test/py/tests/vboot/sign-configs-sha256-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha256-pss.its
rename to test/py/tests/vboot/sign-configs-sha256-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-configs-sha256.its b/test/py/tests/vboot/sign-configs-sha256-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha256.its
rename to test/py/tests/vboot/sign-configs-sha256-rsa2048.its
diff --git a/test/py/tests/vboot/sign-configs-sha384.its b/test/py/tests/vboot/sign-configs-sha384-rsa3072.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha384.its
rename to test/py/tests/vboot/sign-configs-sha384-rsa3072.its
diff --git a/test/py/tests/vboot/sign-images-sha1-pss.its b/test/py/tests/vboot/sign-images-sha1-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha1-pss.its
rename to test/py/tests/vboot/sign-images-sha1-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-images-sha1.its b/test/py/tests/vboot/sign-images-sha1-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha1.its
rename to test/py/tests/vboot/sign-images-sha1-rsa2048.its
diff --git a/test/py/tests/vboot/sign-images-sha256-pss.its b/test/py/tests/vboot/sign-images-sha256-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha256-pss.its
rename to test/py/tests/vboot/sign-images-sha256-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-images-sha256.its b/test/py/tests/vboot/sign-images-sha256-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha256.its
rename to test/py/tests/vboot/sign-images-sha256-rsa2048.its
diff --git a/test/py/tests/vboot/sign-images-sha384.its b/test/py/tests/vboot/sign-images-sha384-rsa3072.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha384.its
rename to test/py/tests/vboot/sign-images-sha384-rsa3072.its
-- 
2.43.0

