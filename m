Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C486C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A68B182CA0;
	Fri, 13 Jun 2025 14:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Snw6xQq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49E0A807B1; Fri, 13 Jun 2025 14:03:27 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49BE782C30
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 14:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yapYd/kXi+U3vcHC0mv+RX6uuCI78xrd1XzhcTzdnR86/Ngf5sKpmXRI12/VdO8+f3amy9cpzTGKqPm12Kk825Le4vydQKHO0qjbA+SoYuqMjzv1ILnOUPdR8ymvmsk9Tjl5YwPdQgMq/ZHNJa6NyYea1K4ZFxP9d4qYVlML8HlWHUkSRqF99265J7S0nBq4nZ2IhTzHqneiJhAHAQsQUsHS+WMI+oQ8RpJAFm3k6A2mJD8FAy8Ujtzqou9dDnnl4uBhItTZEYLbSZhmtKT2oWLPlh3JMeUsBZSj+kOSGbGupjjXa8K/T305+QcOwZMJRfJ85MedHMekkdrTxLi55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su90elNhHRu0V/n6QOfRwAMAmgSSCe6oDkm9eKd3dTE=;
 b=HoUeIcZKQjKr3CGglg1EoewEgsw2CV4fkgBBCqvraWLmRmJpAOUF3xvCyndXD8I5aLpCk1yLd0Z//DBK4wC1mAxjMfAGn8RByy4ZFzVvfO8e20JKMeT3tdkWDeUq7/mgC4B7VdI7oWzlVz1/stXDY6zqelrvw+PvWKRcz+epTL6HJf/oHUjmv6V2iDtrO1Dj9+wFL0IOmwa83OYaYZJjDTrLlBc4yO0yV7G0/r1WjBnk8Woy/mtVyrYoF4vrUiNXxvlIcOHv27lsFuJ2fTWXPNfP8yd/XtEZNCVBA+54IuqLVzZhwHEX13b51ZcQMHxMDOSMgFHz8e9d+7eYJW3WGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su90elNhHRu0V/n6QOfRwAMAmgSSCe6oDkm9eKd3dTE=;
 b=Snw6xQq3ddphiDI+ByiLDqToVnMm0FePmYgWSdLjIE8Q+ZIzI/3f/mcuWkD90ovY5kRkTqzPSXlJVRh4NDYYIhh5R+iA6flI2Pea16I/J6lhesNTDWAem20S+8b6QTwjTZcN+P82OMPDOcEIT8ZYT/N/Grtfelj8icfovhjfDXbWZ9AjQTDrea3xo4Ihiex84SP5E129r04LDYQa1os4ARDm7EMN5En6BYThwdoM7VfrMPvUm/glrXzRNIIOG/AOVApdo+pq0xhYdEi1RlwwmS2LMRfOQPfDCLnzdA9kXGSBaiTkPlsScB9chX3IwvJ35VS/attaodp25bN5SJxjDA==
Received: from AM0PR06CA0138.eurprd06.prod.outlook.com (2603:10a6:208:ab::43)
 by GV2PPFEDB930DC8.EURP195.PROD.OUTLOOK.COM (2603:10a6:158:401::8ea)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 12:03:19 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:208:ab:cafe::d7) by AM0PR06CA0138.outlook.office365.com
 (2603:10a6:208:ab::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 12:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 12:03:19 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Jun
 2025 14:03:17 +0200
Received: from llp-moog.phytec.de (172.25.32.81) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Jun
 2025 14:03:17 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 13 Jun 2025 14:02:44 +0200
Subject: [PATCH v3 5/6] binman: ftest: pass allow_fake_blob to _DoReadFileDtb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250613-binman_faked_optional-v3-5-1e23dd7c41a2@phytec.de>
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
In-Reply-To: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749816196; l=5539;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=SpGoklmnDmRZLn2i94S3Haqbh3GYLISRExBRrrY5tfc=;
 b=aAwTYVhg53P9p6lwa9swmbEe5nrXGWFit+k0nYwAITCqPYdME1al0/YgvnAGbVjuJAX1CwrZ7
 L6J0Uuie5h8ASZARSyS2D1H1m3ADAnHlSLGdv8Q3siOpAk19pii5dyq
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.81]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70B:EE_|GV2PPFEDB930DC8:EE_
X-MS-Office365-Filtering-Correlation-Id: 169e967b-ccab-4f79-db3a-08ddaa7249aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkdqU0tWWVlYVFkrMk13eCtaK2lBRURRWnlORmdocnVSeUVLWmhEVTNHQ2ZQ?=
 =?utf-8?B?MThoR3lDV2U3RWY5bmFiWnczaEdXb21BYlVPSUpzeHdQQ1E4VTBmZG41ejA4?=
 =?utf-8?B?cnBhRC9kY2RvNzE4N2h6TEx1aG9scnRybGsvSG5Kc2FPdzdJYW83SWNEZU9G?=
 =?utf-8?B?dnNPdlVucjJFVU4zbXFZSm5DaWxhLzJMdlVUWU42OUJEclNEemlBZzlhY0k1?=
 =?utf-8?B?M3IvMFZNaDBEVHc3ekl1OUN3V3IwOUl3U2RsQ2lDdEFqVm5NY2VBN1o2UFVl?=
 =?utf-8?B?L1lveGQyN1h6OGVOa0RBaHpmWUJ0K3NIMFV4cFM3c09qd3hIUlpERWp5Q3ZQ?=
 =?utf-8?B?SkRxaVp1NUtldisyQk9zNlQwTC9HMW1zV0ZLYWdGdnYycGhyRFhtVUxVZ3o2?=
 =?utf-8?B?OTY1Tm9iKzlUNTkzZkNKcUp0YXdUSHJNSmpUWUZnMEZYRHY1TCtBWDZEcjZl?=
 =?utf-8?B?dC9iQmlZM0RQelBWMVVlclpwZWZxQ2lkaER0a3JRNHZ4VklIc0wybmpVZ0xV?=
 =?utf-8?B?TkdJSW90UmdtVHB4N3lFc2FTQWxjR24yVlFCamNKZURncjlWU3l1YzlDVW1E?=
 =?utf-8?B?VUIwOWRaOWdCNStGc0lxMERwS3V6c0RndWRBREdtLytuS1RJYzlLWC9wbTli?=
 =?utf-8?B?NUFRWGdtejRtTGxFTEYrbFBNUzZuUVZOVEswUFFmcGVGY1JWY1ozZXUxQUFv?=
 =?utf-8?B?TldVL1NaSlRUbGZINkd4ZEpwdFFRNUxjdVdYVEY5akIxVVV5TEg5Qk1ibENv?=
 =?utf-8?B?akJRUHdmSW9OSWNUUXQ4aUhZQk8xWGt4ek9aTGNqc3lmSmV1ZU5UL28xWWRv?=
 =?utf-8?B?cG9zT0QyUXZPeHNTQmVtTXUzOXM2aHFRZWoxSWpMYVNTVkF4T3RYZXFKTlhi?=
 =?utf-8?B?czNHSnVGMjg1dy8yeUFiS3UxNHZRTTlRMk5yajllQnF3MERRcmQrNy9Sd1RZ?=
 =?utf-8?B?TFU5Q3kvSFVnVzF5dG9wNXpKd0lhcFVqVjBOcWc4WkVJeXJZZFFYZzlwcGJ4?=
 =?utf-8?B?bWdOZjBkUzNUTFF6VG8xMFBmMVJsdDJLWFVDMHpxQWFITWM4ZVNkWkY2azNO?=
 =?utf-8?B?NUp0NllkbzNpYVFTL3RUNDQ5Vy90RzN5WFVQN2lVQkZONGttR3MreVdTM1ll?=
 =?utf-8?B?U2F1L3hJa3ozK2cwZjhQS2x0MmhWSURiVXNrc1o4MURWMkhlcHk4cGtLMzN5?=
 =?utf-8?B?YjFDc0xRbUVCMUVyMlFlU2R1bjhtN0tjaDNpeU83TVdKMjRsc3ZtZS9lRXc1?=
 =?utf-8?B?SDRka1B0N3ZzRkhWNjE1bTJuamN6eFVOSGtnRGd4V1VCUTk3VzFQbzlRaHIy?=
 =?utf-8?B?RzhsRlhjYUtXMkR6OUd2RCt3Z3R0L2Vkb1F2YXplVUt6NVlmYm85bFNqVkU2?=
 =?utf-8?B?aG9RMXVPQ095NmkzMjV6UU1pUUJzR2tab2ZLTGVDV0dncVhzR3lPUFhVZm91?=
 =?utf-8?B?WVhnWTlzOG5DSW0xL0oyQ1lzTWp1NXlSTmxGYWVJUTNEM25TdEJnWXQycE1t?=
 =?utf-8?B?cnBrOFNKbXRMcGlGKzYvUW5mcnRUMXphRUFCNjNJR3BhclRjQm1JeUNOdHlN?=
 =?utf-8?B?ZHliOFhwWHNvTlhOT1Z2WWxHM0NRVlZMZ1Zja1FrelBZR2wvNmxrWjFZS0hj?=
 =?utf-8?B?N1JmSWI1SXNva0YrRTg4TG9tK01yOHdTWEdFcXkzQ212KzFaazI4c1pXemxM?=
 =?utf-8?B?MlNuUVhLOFJ3UTlXODlRZVFNY0VCRnZMYlgvU3FJdXNBQlNkUENKL0x4YlZm?=
 =?utf-8?B?MXFJc0VaUG5QWXZUT0ZjaVIxNzU3cGRoblJSaUs3ajFUdm5xWEdCMm1TM0dS?=
 =?utf-8?B?YVR2LzhVUUVaT3A3b0ZqNk0rTWw5WGRiejBHcEVNdmw3aGwrZ3hLY1BmYTNx?=
 =?utf-8?B?b0c2czZ5YWpBMDR6dTFQM3FlTHFVazRjeXpDWWRySkJ3bUNYejdjT1JraEVX?=
 =?utf-8?B?aTRzMU83c2E0SjBSNmlWcFNEZ1d5T1Vzc1pETkU0bGVGUXZURk55UTEwZ1JE?=
 =?utf-8?B?OUl3Nm9uWjdmTGFDN1IxR09sRWNCY0Ftd09lVWk0WW5KVHVrMGk5N3N4bjF2?=
 =?utf-8?Q?hviI19?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 12:03:19.4954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 169e967b-ccab-4f79-db3a-08ddaa7249aa
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PPFEDB930DC8
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

Some test cases don't use _DoTestFile directly which accepts
allow_fake_blobs. However, they specifically test functionality that
requires external blobs not to be faked. Extend the _DoReadFileDtb
signature to allow passing that option to _DoTestFile.

Also fix tests that require non-faked ext blobs.
By default, external blobs are faked. Some tests care only about more
basic functionality. In those cases no external blobs should be faked.
That would trigger a different (binman) case which is not in scope for
those particular tests.
Thus, disable faked blobs for those test cases.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/ftest.py | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index d707e2aa555b39316d206a4c170ebb83aa6daf72..32e1e0a14c03c9ebf1d9ce1f8278841959d7e5d8 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -515,9 +515,9 @@ class TestFunctional(unittest.TestCase):
         return dtb.GetContents()
 
     def _DoReadFileDtb(self, fname, use_real_dtb=False, use_expanded=False,
-                       verbosity=None, map=False, update_dtb=False,
-                       entry_args=None, reset_dtbs=True, extra_indirs=None,
-                       threads=None):
+                       verbosity=None, allow_fake_blobs=True, map=False,
+                       update_dtb=False, entry_args=None, reset_dtbs=True,
+                       extra_indirs=None, threads=None):
         """Run binman and return the resulting image
 
         This runs binman with a given test file and then reads the resulting
@@ -535,6 +535,7 @@ class TestFunctional(unittest.TestCase):
             use_expanded: True to use expanded entries where available, e.g.
                 'u-boot-expanded' instead of 'u-boot'
             verbosity: Verbosity level to use (0-3, None=don't set it)
+            allow_fake_blobs: whether binman should fake missing ext blobs
             map: True to output map files for the images
             update_dtb: Update the offset and size of each entry in the device
                 tree before packing it into the image
@@ -572,7 +573,7 @@ class TestFunctional(unittest.TestCase):
             retcode = self._DoTestFile(fname, map=map, update_dtb=update_dtb,
                     entry_args=entry_args, use_real_dtb=use_real_dtb,
                     use_expanded=use_expanded, verbosity=verbosity,
-                    extra_indirs=extra_indirs,
+                    allow_fake_blobs=allow_fake_blobs, extra_indirs=extra_indirs,
                     threads=threads)
             self.assertEqual(0, retcode)
             out_dtb_fname = tools.get_output_filename('u-boot.dtb.out')
@@ -5211,13 +5212,15 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
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
 
@@ -5225,7 +5228,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test an image with an missing external blob that is allowed"""
         with terminal.capture() as (stdout, stderr):
             self._DoTestFile('216_blob_ext_list_missing.dts',
-                             allow_missing=True)
+                             allow_missing=True, allow_fake_blobs=False)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing.*: blob-ext")
 
@@ -5767,10 +5770,10 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
 
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
@@ -6543,7 +6546,8 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testExtblobMissingOptional(self):
         """Test an image with an external blob that is optional"""
         with terminal.capture() as (stdout, stderr):
-            data = self._DoReadFile('266_blob_ext_opt.dts')
+            data = self._DoReadFileDtb('266_blob_ext_opt.dts',
+                                       allow_fake_blobs=False)[0]
         self.assertEqual(REFCODE_DATA, data)
         self.assertNotIn(MISSING_DATA, data)
 

-- 
2.43.0

