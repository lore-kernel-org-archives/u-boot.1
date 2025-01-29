Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D39C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:30:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D65481F3A;
	Wed, 29 Jan 2025 11:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="QrymBngF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D16F281F0D; Wed, 29 Jan 2025 11:30:17 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C969380EEF
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8bcgoqV0TAA5Qw9mHfGozlPd1ZZ24gDSB4Ux2iLnR+yQaWYolpAPdlTRHdSsRcMJzoSHjs5/x9FQyg2eBAdMu4s2ZeniYLuwNREblDUNVMYNEmHmVzl2Wb74dqYikkBYra59OgPluxCW/PVtMjg6FR3Gm8wBo7ZUlUzHtWBB7FDzXn0HXuh19VLdMb3nse1mZ0Opf5RlYwoWb8lGV5SY9w1FKjQs+Pho7F3iFT2fxdcHw9he7HyeEEDXgzj8TAAdg2Ke4jZrqcFIx5TxIy/27f0+2190jNsq8AS8xVj9RdHnTC+/vtlPI3YfRHs/SVI5mTbhuX4a6sVEUxOjb1A4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bsm9AOD2+o5CImdnIU6cKyx3s+eDhrR4d8Rk9hguLOg=;
 b=KlMQOQ87zj/cZ+zzXvzv166xCBO+R0QcenxRS4dvbnuup6InlTMyFqmxqQSETx/92QvQwvgDKo6g7YZJPTtkY9ZkaaaOCcPOvSm/ba8QSpWfxjNIEt3wehVsLlABqX13GDq7/aIKQ7X3mpUri8tUQvA1lWwywppLwMnqkBN72drNn+/rELHxDDwLf9EVfS90fKac3m9EY8AqqLsJwR+YcsxiGTaCMHbFn8jyTsePmA31I91vlI1/jzW8aDlRLZJMFRf5MRtimfBaZaqLel2Ag4cz2kRJWlld07pxahioEr6OhHZOOLEudctSdz0599Sr5zQoyjekUpmNQgwAiO/JwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bsm9AOD2+o5CImdnIU6cKyx3s+eDhrR4d8Rk9hguLOg=;
 b=QrymBngFwWITr0VFeOk4uFHuNjLgZrTR/i2GKsS9rnHUHXLzbC0LhA19LJwMvRhzekp/xrjMROFXcIYVq3Ji5YiE64R8bWP9RYbaSFGwPqaNMSxF9RnjIqTTAhvAiTCumqQh6A4GrU81a7pRV19lBrpdZYX1H7nqDofdbyrgkYzMfgo8lQ0+9TAFqFzFL2hyETnMNtmzs6CKw4Q89qx/SEAz+asu02Qvk8Oq9niAFcDpsQN+j8ep25Q34SRw5lWAag49CruMmNmB4BJ+H9FZNu61auZAb3u94jC3FiQXRDxvujYOB3GvgZ+rDFp3OjTjAy5NvE8EOdV9HlN+ylCqEg==
Received: from AS9PR06CA0179.eurprd06.prod.outlook.com (2603:10a6:20b:45c::9)
 by DB5P195MB2379.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 10:30:12 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:45c:cafe::d4) by AS9PR06CA0179.outlook.office365.com
 (2603:10a6:20b:45c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.19 via Frontend Transport; Wed,
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
Date: Wed, 29 Jan 2025 11:29:47 +0100
Subject: [PATCH RFC 2/6] tools: binman: ftest: pass allow_fake_blob to
 _DoReadFileDtb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250129-binman_faked_optional-v1-2-a4534bc67cbb@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DB5P195MB2379:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b1630c-74bc-482f-2a8f-08dd404fe997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlljSml4TWhWZzlHRnJFeHE0QnRqN1JibmFJWERSVXlDdER0RjRqN29sQ1JH?=
 =?utf-8?B?dDFraUhuTyt5TlprSHhRQ3NNMStLL29CSm16eFFMTHJ0RHlORElTZ0Ewd1hT?=
 =?utf-8?B?cHRsQ2Q1WHI0dCs1QURxcXpydDdVSUowbjFQUXc2aFdTN0dLMGZhcitGNmNw?=
 =?utf-8?B?VjluQXI2eU93WDhaZ3Yvb0tuVE5LcFlONm82aGhHTm13SXc4Y1VQdG91bE5x?=
 =?utf-8?B?ajlOSTNaNEl5Vnk0VkxqRWRWM0Vyd21VbnRVbld4c0J4alpqb0sweldQVW1a?=
 =?utf-8?B?WlF5VHBVTjFYMFg1ZlFwL29SUkRmN25aNUplcGZDYmlOMXVRdU5GdWNWQnBh?=
 =?utf-8?B?aEZXY0dmS3lDMnhxLzRmTTdYVlEzNzk3SGlWUDg4emEwR1VwREhVR3VDeWZZ?=
 =?utf-8?B?NUJOdzN5L1lLcHNHa08ybkY0NDZKK25LUzN1SHdtN2ZpOTh3MXRFWWQ1Q2p6?=
 =?utf-8?B?NjR3UjlBWGJsOEhCUzBwWkdZS3c1cHlXQ1JTT0VPOEVhMGE4ZWRPbUhMNG5Q?=
 =?utf-8?B?UWxVQitDaFl3NTlDOTJ5M0NNMTFmNFRubWU3Z3BGVDdGbEV2SUJJZ21YSHBS?=
 =?utf-8?B?N3VRQ0NyQmRIY3cveUE1dkhiTVlNdkdsQm1EUGpJUXFTWk94SDhLT3pZOGsx?=
 =?utf-8?B?NGNkWjQ3bFE1cDlJT3V4OFZxVTdTa29xRFJ2MVpZWGVOb1F4QTd1T3JmUHJx?=
 =?utf-8?B?b1NaNmgwbGlPUHpRZjI5b044SE9CanB2QjBQY0tOOHM5Y3B0bzlRVXB6dkNz?=
 =?utf-8?B?bjVNTVUweWIrTUpCWC9mcTF6RmIvbFFMTmVDU05iS0dnSzdHMkM5WEcvU255?=
 =?utf-8?B?dmREQ1dnVGwxVFBLSnNKU0s3aG93ZWhBQmV3YldyVFdhRzlHSnF1aklMNnhV?=
 =?utf-8?B?NGpUTURFQlhGdDBZMXpWUGJuLzNaMnIzZkgzeWY5SzVQRmhQQ0dFUzQyOFIx?=
 =?utf-8?B?ejlCM01ZVjdXS08zYjlLdXUwdFljOHd3d3d5REc2Q2tRcEpHd1RZVkN1b2hV?=
 =?utf-8?B?SFk4cC9Za3dHN2pzSkpaa2VRN0NDTmEybXNPMUgrYUJCbTBkd1NHRWxQdmdS?=
 =?utf-8?B?UWFzU3hwWlMxdTcwSWJ2V0JobUxmOTVxMVg4dXJUOE0vc3BMQVFaV2V0aGx0?=
 =?utf-8?B?Qjk5cG53WmVwQmxEU0tSYkJXQmU1ZFJzc21mZzRwdjI5RWpvbGw2d3RHcHZj?=
 =?utf-8?B?V2JIa1NQa0lUbG9EU2xtSHpxcnc1aldzd0d5OXhqMGVjR1Nqc28zVGo1S3VY?=
 =?utf-8?B?TFZnU1JBaFk0Y0l1NjN1clVEMHpSY0JFSmhaVThNY1lKRHo4N09VL0pBbjlQ?=
 =?utf-8?B?dzZBTlhnaHlyQ1A2c2c2Zis0bmYrblU4QUU4bUIxdk55MDJqd0lzOXcrRHZz?=
 =?utf-8?B?RHRCN3NSUmNIMjFxalRBRXNUck1JUGhmS1pEeUtJVTYrTExDT2VBanU2QU1U?=
 =?utf-8?B?cVBGYzkxRVpobmgrQzNIMWljbUVHUkFqTnJLRnlJMksyc0ZMbVJzRUFCcllk?=
 =?utf-8?B?NGxSaDR4RnlIQU0vZXJpbnJjR1hNT0Q0R2Z4WDNpWHJDdnQ1SHZDL0VkU0RZ?=
 =?utf-8?B?KzFYbVBYeUttNlVnZU85Mk40S2ZQWHAvWDBnalpzbWdHbnBZOEVGQVkwUzF6?=
 =?utf-8?B?K1hxZEt5dTdHNTVma1lWL3JwbHZydFQrWDBqZjBhTXlaRFhkSlBnaHNPYndj?=
 =?utf-8?B?RzhXejg0dWNqdTBadDNTckpnZTIxdWI2elJxZHhSMGxBTFVmc2huYzJ6OHhT?=
 =?utf-8?B?S0h0NGFYd1dQSnY2R0gzYTFtWHh4UDQ5cDgvdm8xa1RSYkMxb2ZidzNjdCtT?=
 =?utf-8?B?UVlpcjdqRjRqMmhBNUJaVjFMRVU1V0dkT3BqZzZseFRwWkNhRGt0bFlSUEVz?=
 =?utf-8?B?MHJsdHdCVVdlZnN4NGI5eHhlTk5xSXFBc3VKZTM5MmJqWlJ6TWEvenR1TGZw?=
 =?utf-8?B?TEUyOXBkNUcydjR0VFc1bEpPcmtwU0hEdUo5KzZjNkEwQTM1ejhOenFURldC?=
 =?utf-8?Q?Q/0PMAFt6dYew+/SuOGasjUH8kOGfE=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 10:30:12.1758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b1630c-74bc-482f-2a8f-08dd404fe997
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5P195MB2379
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

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/ftest.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 1f194f9ecae..82f839e33b0 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -505,9 +505,9 @@ class TestFunctional(unittest.TestCase):
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
@@ -525,6 +525,7 @@ class TestFunctional(unittest.TestCase):
             use_expanded: True to use expanded entries where available, e.g.
                 'u-boot-expanded' instead of 'u-boot'
             verbosity: Verbosity level to use (0-3, None=don't set it)
+            allow_fake_blob: whether binman should fake missing ext blobs
             map: True to output map files for the images
             update_dtb: Update the offset and size of each entry in the device
                 tree before packing it into the image
@@ -562,7 +563,7 @@ class TestFunctional(unittest.TestCase):
             retcode = self._DoTestFile(fname, map=map, update_dtb=update_dtb,
                     entry_args=entry_args, use_real_dtb=use_real_dtb,
                     use_expanded=use_expanded, verbosity=verbosity,
-                    extra_indirs=extra_indirs,
+                    allow_fake_blobs=allow_fake_blobs, extra_indirs=extra_indirs,
                     threads=threads)
             self.assertEqual(0, retcode)
             out_dtb_fname = tools.get_output_filename('u-boot.dtb.out')

-- 
2.43.0

