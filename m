Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF27CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27C388495C;
	Mon,  1 Jun 2026 15:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="UrXxLZM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BCC1848E2; Mon,  1 Jun 2026 15:43:24 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7423E8493A
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e844Zv+tmRoM+BUsPCOd32arWCKqDqi7d6/sWYZwSmjUE07muagnwZlIU3Zd+x/Fnz1UjUkvOYcbH42w0p5Hu0x4d9twAa/q2z34YRkzJl+IOgUUeaqMYLm0jz5nunWKiogtDR4IICZcs98Z5lP6zPnd7YiX5lxETNMxOOnxuHb3p4ZqLCGgp/u9jme7OXwVeNk5UBS4FONk9efmnDpjkJLwn7eGBhACC+S1X6hqNQyC4Iz+gKCmlQxrCxZB5uVArnNZJwNV3sj/lr4AYqRcsOqzlQfFwNa8NT3G1Dzi9O0K6+Zsh/sRpnEHuubMqPH127xuzW7E2FcXFFHMVgnjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfIxuV5VGmLaFpo/tX92wy2bDXv1AB3czpekO/yEopc=;
 b=rgrnGc97xpM6uCkpJHiKhNhDBbfOEd9K0mULzkMs3OqLuK0ML3Mq5kGFrXRg60jGPam4jEYQ23+fEZ2e6e/mfDCUZ/KuAT+oe4qK6mS7Y1NV2whv9FCdtC8IN28pZ9D3cizkIoKWAAUMyuMdHUha9M+1sEkwoCgwb/7gztb6ftgitTKGp7QlmmNFMDb3CqNA9VIscnz749eZqCE4uxNmD2yOhbjHe3tSUm043dEzhaykCOG58+paJB4tuYXUEdsj4EW8tp3fGav9hxCgl0J+AEZ+V5FqXQaTXxoi7dvGmw7MzjhQ9TgR3BqzzmnXn+fNS1mJXcc+/OXC3GAjG6qOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfIxuV5VGmLaFpo/tX92wy2bDXv1AB3czpekO/yEopc=;
 b=UrXxLZM/i4+KchsZ7rA0bJjwimQDjP6/3eFCAvnP7+BFa8MdI8P2HLKpBJ0Ukwvg6B1dNCxwMffuPenSqcGltwn21wUDRP8jNFroGNthrKf7PBvaOGkhSfGLCGk8K+A/cm3jjAqc97xPUUzeieOvKMi4f4O4Sic8xPMdtvtoqGAQqKjC3Nx1bfBjib08keZXm76zK0MygpqT6CnU28xsIu1R9CX/zp696IxFxxOZODh71GXHeJjwc/1fAKopzY8nCX60/H2QmhN62ROOei5IWFqZVgvY7q+0Db8jlDkVWXGklM01RWdCP+o/e9hBerWtdzIkTDVNeE+gAMbA74Yh/Q==
Received: from MR1P264CA0097.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:50::18)
 by PATP264MB6716.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:532::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:43:16 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50:cafe::32) by MR1P264CA0097.outlook.office365.com
 (2603:10a6:501:50::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 13:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Mon, 1 Jun 2026 13:43:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 77CE2213FE;
 Mon,  1 Jun 2026 15:43:15 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 07/15] test: py: vboot: prepare integration test for ecdsa
Date: Mon,  1 Jun 2026 15:43:02 +0200
Message-ID: <20260601134310.2452454-8-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601134310.2452454-1-philippe.reynes@softathome.com>
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|PATP264MB6716:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 46e67fb5-b5b1-43a6-4e90-08debfe3bbc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: SmMcU5V0QnTirCrQzxBEfdLIaG+syfgR+IriyKbuuc7ojuKpp3eJnK9kqIZy3elntc+TGyT3c+kLbdx5L29eM3cBp9kwcRz7p6xGrP9ixnuztubnqqBdzbhPaRzPd/kr6rLFtTwX6xYnhtmZucb+9xNgsIxy2kgT0LVGTFLDFpetTEF+YzFg1HF96SOUCBtSVDyZmOjZMy+GV+EsAoLM9agttJg2UrVShTtBAVnebGPweAEQQW0XhAjPxiIErxiPMVLcxpW+jf4E6oSjMY0ssiOC4dU+JNm2Y5V8U1LfF4TLjpd+G9RE6YiL9iIBiHdgF2oLv6Hm3JgayTVed+GWjc8sDecdia85R4KswRSJFTHdmtQJrP/mdLkxPgsVEqs/PlfHlaOCOQ8tHeqdr5UwSaEraJWgf39Y2+GYYb5NwxK+4+xFrC4swk5LsB8bHZaRCQwn1zNrFV8yriW6mVjqXSlB03thZ6OffhDzlL20rjJEslxGOlgzsVTprAmH07kVIkM2Xt6q3uYi0zo/CujN2Y1Y/HnMh+aiM0urTWJctD+ICJqGulqPLSYu19m7Icp5boxkvxf8QkkA0Wcts76ClabeWNdQlUW+JF2OEule+dix2OnUxcpEUm+0v2sxUQM+xzbqMLk/tR6I3u5o50dhSg5P/Z6kp82TxUbCby54pa23gvfoXZEyaskGhVVLR06u7F70If6e8x15GDXd+rDfbYAgMvlpSlGUmVhhtcmM0Eo=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3JJtO3te3ni5iv5sA8LQp0Z9KMLkdZ8BQdtsKbhZa2UBmP3OWvTlB3WP+OKuMGig1OpEOi7CdOQE0uoTYFmNJv2UkyJZUMWyY8r/+L9sSWJ7KCZRY9khjtGEE9x6L95iCfNrccw6WRrq5ml3XXgl0CGnba0U8de20Dkx6IMzaVApv4Q0q7TjyyXvW90GXi6FhNx0iMUZmUuCF7fJsNyMFfw12Ll2nnLqnjk01AjFbDaKANyfkE63mOTgrESaPburkCQEwgCqFCtRHDWhoXpbdW/nFOA0AgyMUoj/MVCl/hWMO29j/0m4G/+IGNdLhDfNtNDPa26wVN+wCQTCTB1Ki36eFV1vFuCi0erTJ5BHugcyJwnmTnGM/Of39kmBRb8SStIUYfil/7EfoJsbQZIseZFFoIBB8QB8AlG9IcaLBzISwGwzVq4DEN6LSXb53qYP
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:43:16.1325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e67fb5-b5b1-43a6-4e90-08debfe3bbc6
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB6716
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
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- initial version
v3:
- no change
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

