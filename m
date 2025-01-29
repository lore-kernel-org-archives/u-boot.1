Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BCFC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8FF480FA6;
	Wed, 29 Jan 2025 11:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="LJE9gjOH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DE2381F0D; Wed, 29 Jan 2025 11:30:17 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::71a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6845C80885
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUiot1VwjFDbI1yjBL2c/2mXAvUOnmZyfXzEv6Go7j7Esa5ZgM/u1nnJRylIBtYHN/IZ3gjM96yD7pQfzSXY4cRsyWrbhQgHLTi0jHYfc6HJcS0HuJ3vF/bZiv7+ZgUQlpKlVDqI2o6LCDHysmgfuIz0v2Etiag11RpUyedS4xiuUIdgG9/Yet80usjWUyfFI5g6qu3x/9jmEfQAVH/bXGp/+3HPFYy81/K/ofdcT8YIrk+LZULWQj+JfE7vUjJi0pn9Ai9lC2Zu+Z3Y6hIYNAT+PTF0xbG29MAUcmcXW6OGsLEyumMAghcpNo6cwe7XHws6VzCFfTeZZ4L4tTxSww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4duwki5K7WBBrhwgTCPkgwfZ/OxsMWwHeskLb0n2HY=;
 b=LOqzBM/O9wR7KDAk8Pv+m3Bee+IaNs0uE9IROb7WqqCkdEUG0enVYZXQUa9kcdTO6ca9wNHG6Y95aOhG3MNa7MpQemGIWXvmJtpgRw96gjPOGylspg2BV+WuUP2tJcJRGb8XM6tV+RnWB/uSturFZrwiQbBQ6qAXzvceVsQGQccLrk9Mh6ZkrDdEhOzOpbrfR+irKTtg8HzqJ1DaqlF641EJ/YTepEmJlCX1ZIImGa5vuJxgW8333QsBYR+aJm6iojiYwYJMHG7qgibboRjqa5ZkzXVfjg0S106XJY2svwhwynKMQBRaqSOkkrZe8ys/5urE1gGd07PMn9EdcVCcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4duwki5K7WBBrhwgTCPkgwfZ/OxsMWwHeskLb0n2HY=;
 b=LJE9gjOH78lSDxwmEF9ts22nEkcDuX1CvMjx1kRVmgcQqWEOidSvgpM9PHPa13fe8xzB4i3yttogAb4WreUKWtEfwoFi9ibxf+ClaXU694B9s1J0FpjHiPSjTaMiQwP2VKBEjcG7xBIWYxDHmnEJJP8mF+1myoSDw4KkWBzCeyrMsQ1wgwxjyL3d14rsZaEx9zPXiA9r5TIMha66vKsa+753adzE5J73cavUrKoeos7xVMjHFgvTUBBdoNx0H0n0wMrjgla0lbUIggrXmIMtcBE8ppnKYIFx5CNEi7BwUjwU8oshJPLm2qpODqb2wkHlnceCptAfzk46eA7axgflCQ==
Received: from AS9PR06CA0180.eurprd06.prod.outlook.com (2603:10a6:20b:45c::27)
 by DB8P195MB0568.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:150::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 10:30:13 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:45c:cafe::9e) by AS9PR06CA0180.outlook.office365.com
 (2603:10a6:20b:45c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 10:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 10:30:12 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:30:10 +0100
Received: from lws-moog.phytec.de (172.25.32.60) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:30:10 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 29 Jan 2025 11:29:48 +0100
Subject: [PATCH RFC 3/6] tools: binman: ftest: fix tests that require
 non-faked ext blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250129-binman_faked_optional-v1-3-a4534bc67cbb@phytec.de>
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
In-Reply-To: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DB8P195MB0568:EE_
X-MS-Office365-Filtering-Correlation-Id: 164ca404-6e7c-4782-fee7-08dd404fe9ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0tTYlhndklYMzdBNndQbXFFTHBlTDE4ZlZkOC9oeW1oaTYwM1lIOXJsMnlS?=
 =?utf-8?B?aDUzYWZzK1dHRGJ5aGFRWFZNYkZnZ0NFQ1ZaWVA4S0J0MDlxMUhDWWJ5ekxE?=
 =?utf-8?B?eEQrN2l0aVhsbVNFRHRJWGVscHhiYWo3cGxHUnl2dnNTOU9HbUQwWEp0empS?=
 =?utf-8?B?d3R1dW4vZEw3R0NJQ08vVUt0VjloNzBQVE1vcDB3SjdUUmtnMm4wbWhUd2g4?=
 =?utf-8?B?UGMvTkF2S0lPaURmT0dqcURmL2k2TjNMSGZPZkRkaHNtRUE2VFVRWk9VclFz?=
 =?utf-8?B?NE5Ea1pvQkVxM0VjbGQ5SVBiWGlneHJEcDZva1htN1hudUx2dTYyU3FwN3hs?=
 =?utf-8?B?MWR6QTJMR2twN1dnc09kaXdMRHVyYUxIT1dTMEdNTmQ3Q0NkNjVRaGhxdmNj?=
 =?utf-8?B?NWRjQWlEQXRrOTVTUCtCUTNPczJYYkN4V2NvRmJLbWptb0VEa21rTHFsSDU4?=
 =?utf-8?B?elFNQTVJQlhyc09FZmgrZG14UWpQa1Fjb0YyL25iR2lXdEtNM0FGaE9nZGpX?=
 =?utf-8?B?ZkFBalF1WG03YjIyNjBLNlBlQnVndytvQVp5bEhDY3Q0clpJNGlpMFNHVmJL?=
 =?utf-8?B?Q20xV2xhNXd5OVZhL1MvQXhPaElTNldiM0E5UTZheE5MWkVzbWpNZHBOQW1q?=
 =?utf-8?B?dlVudG05QVBBaUZDRFpWanJPcktpbllCVm9RVW9ETFgyaTQzaFJESnZOaitL?=
 =?utf-8?B?eVNmMFFKS1JHRHRNcmZQdnpud3lwczlZaXMxSlBmakxEeHNBVHR2c0lKVWtQ?=
 =?utf-8?B?SDJqSVlEbURSQmtpdW0rOEY2QVh1SHlSWEhYcHlQMzdqbkJvdkVxajA5dDBt?=
 =?utf-8?B?RThrdkVFbXI0WUQ5MUN0ZU16S3o3dmVaVFVFclVqbnZtRGZETTFYMWtYM3Vs?=
 =?utf-8?B?Z2Q0TW5SNWJyTnRTY1hNZ1JHc2taRjRJVkFFWHZXckVZUjFUVFBiZXZGeDRU?=
 =?utf-8?B?dHRKU0k5WGpaQnJld3VzbFd0OFFnWjlhcis4elFGVE10S3hIVjNYRnJiV0RC?=
 =?utf-8?B?aE43T25ZUldZcXV0dVNIaE5wSUZYbWxZK2VNU2htVk1wTUtvWGN1cDZEVnJv?=
 =?utf-8?B?WFA2c21TTDB6OU5IN1hYaHVOT3ZueUZ6SFJkeVFjZkl2ZlBrakY1RXVRUHdi?=
 =?utf-8?B?WmVFR21zck9RMmYrWThrNkVxVGN0cEFsMjlrWDhUQ3VSM3A3d2RSZlhNQ0pk?=
 =?utf-8?B?S1V3VHdOR0NHSmhPaVh6OEdvUHRSVlZzanJLWHpseE4vRTFWMjFmcVFQdE52?=
 =?utf-8?B?a2ZWM3ViRDhGVFRqV0ZMc0pWNUpRem1rY2d3UnV5M3daSkJmZ1JJZkJrUGV6?=
 =?utf-8?B?U05VWVg0bzhYelAyOUUxUitST3lRdUZhVlBWRE5Tdi9vdnFydTA5Vjd1WWs2?=
 =?utf-8?B?c2cwcDVmTTBGeXVKby84UmVxWlZZbWF3K2VDR1IzaTVzTW5XeURTaE9rV0RK?=
 =?utf-8?B?YUJ3U2czazF2NmhRMk92UFM2VHpmYUFiSGI0WmJxUFpjc3VRc0Jpck45dFVK?=
 =?utf-8?B?ZmxHaWFnenJhVE9KR1NyaGpGa3EzU3dBNUZRK293UHN4dEF6czJNbFl1MnBp?=
 =?utf-8?B?d2lDZS9sQXdMQnNkNTRueUxVZHhrYVo2Q0Nlc1czaXBHNk9DTU1yRFBTVFhB?=
 =?utf-8?B?WFA3d1RNTGxkdHU0NVNZWm14NDdnZXlsVE9jYXA5Y2VVcFNRTmo3T0JVcWpK?=
 =?utf-8?B?K1lJblJ4QkR0YXZNUzZVRlg1RXk2ZkVLaURueCsxUy9kd0pCcGNTR21PQnZ4?=
 =?utf-8?B?VDI5MWtIOUVWZ2VTRENVNzVQM0JMeng0TE1ETTdFUnFhaHVaVEFxcWhBY29Z?=
 =?utf-8?B?Y0h4ekM3dnB1Z3RwNTV5NWxIaUpOcndMZHNTYWE1Z09SL0YxSXpESjZJcnRj?=
 =?utf-8?B?R3cycG9WTXprb3JqOWpmeGhwZTJCdmNKOXlmTHZ6NmpsdTFBUURUdWwyMXc3?=
 =?utf-8?B?T2dxLzVmWlU2bVFlU0ZxUXM2OU9OU0R3c3doTUN4RW5CM3p2LzVHTG9TVVpk?=
 =?utf-8?Q?TFxNYMbUqcpWCKrf0VbXrN7ZaeKISU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 10:30:12.7226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 164ca404-6e7c-4782-fee7-08dd404fe9ec
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0568
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

By default, external blobs are faked. Some tests care only about more
basic functionality. In those cases no external blobs should be faked.
That would trigger a different (binman) case which is not in scope for
those particular tests.
Thus, disable faked blobs for those test cases.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/ftest.py | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 82f839e33b0..66d1cc240d0 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5188,13 +5188,15 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testExtblobList(self):
         """Test an image with an external blob list"""
-        data = self._DoReadFile('215_blob_ext_list.dts')
-        self.assertEqual(REFCODE_DATA + FSP_M_DATA, data)
+        data = self._DoReadFileDtb('215_blob_ext_list.dts',
+                                   allow_fake_blobs=False)
+        self.assertEqual(REFCODE_DATA + FSP_M_DATA, data[0])
 
     def testExtblobListMissing(self):
         """Test an image with a missing external blob"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('216_blob_ext_list_missing.dts')
+            self._DoReadFileDtb('216_blob_ext_list_missing.dts',
+                                allow_fake_blobs=False)
         self.assertIn("Filename 'missing-file' not found in input path",
                       str(e.exception))
 
@@ -5202,7 +5204,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test an image with an missing external blob that is allowed"""
         with test_util.capture_sys_output() as (stdout, stderr):
             self._DoTestFile('216_blob_ext_list_missing.dts',
-                             allow_missing=True)
+                             allow_missing=True, allow_fake_blobs=False)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing.*: blob-ext")
 
@@ -5739,10 +5741,10 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
 
     def testFitSplitElfMissing(self):
-        """Test an split-elf FIT with a missing ELF file"""
+        """Test an split-elf FIT with a missing ELF file. Don't fake the file."""
         if not elf.ELF_TOOLS:
             self.skipTest('Python elftools not available')
-        out, err = self.checkFitSplitElf(allow_missing=True)
+        out, err = self.checkFitSplitElf(allow_missing=True, allow_fake_blobs=False)
         self.assertRegex(
             err,
             "Image '.*' is missing external blobs and is non-functional: .*")
@@ -6506,7 +6508,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testExtblobOptional(self):
         """Test an image with an external blob that is optional"""
         with test_util.capture_sys_output() as (stdout, stderr):
-            data = self._DoReadFile('266_blob_ext_opt.dts')
+            data = self._DoReadFileDtb('266_blob_ext_opt.dts',
+                                       allow_fake_blobs=False)[0]
+
         self.assertEqual(REFCODE_DATA, data)
         err = stderr.getvalue()
         self.assertRegex(

-- 
2.43.0

