Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BCAC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:31:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E33881F71;
	Wed, 29 Jan 2025 11:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Broc2e+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD1D780885; Wed, 29 Jan 2025 11:30:19 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::712])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D9C81EC9
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBga7fuq8+fCrZBedc6m02DjeOTtR9ET22kCykyub/UlGEq1x7axs4XwAvxTKv59OILVROyw1Zq+PgmIcjOCXitfjRIuZmabMJ98hUb3yjFClgUZyeIGP0tSFW9xiQikTzYeEWyJIJSgGNjzgW6/MJQPcT6sxqLrkslH3AzmFsHOyJizFf+D/7yU4zVuz1PUoGnBb8uxIzkurBmhRYicXKLJtPy+9lvPvqAHBG1ZO6YaoxAtd/QCoFDi//Cyfs6Z2+vYFSnGr1gj8FxeKuskIb7iAKQb3HgMRR9ujRkyZJifJq7cdIYepbUMoVda0ASTW3dLYQBtahTR6oHPQlRN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSHbRxumuCmphlyyb4+5K/xPUxkfxagylBf6Aw/Oohk=;
 b=wrizasB/UVtFbCsdJwD1pYMNH+4FvRWoUh5hmMJxCTTDtSdlCpUuF4mBQoB4ZSm2tB3uPqWG5APVKPgZBRGG2l6JNkgswz2t8Y+yQfo012M13pRy6UACdhSd0RNYp6YW0G4JZvSkAXb/aeMpWaIOg8nfViTkIKqDnVV5CnNRtd76DZI6H/xiMzc75YpJahI7JiygtOzog3vSz6ec61AL5AzXbTMAuuTirpkC68qIwg4tmtCCHnKz0nOM8+CG3uCO9KH5J/lf9oc1WOFm5EFX4+8zCwBRitQfm7zY8MiIN6BB7QnX8NsfyZ+F4bN0/kG+QwVOBMzb5Dpq8xyxgTBavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSHbRxumuCmphlyyb4+5K/xPUxkfxagylBf6Aw/Oohk=;
 b=Broc2e+z/ZLdm6XYNYlw/URLOZIvrFjDBj8HJEZ7h2ER4nqmRfjSVsYUCP7/b4HU4OqEP6+P9t34/nLSIEQiOmyPYedss9sypLVuteFqDliyHPLlfGCl7bKy+liS4P/hBWVx/OpNKrAgawYcCeSTitsUEexRLaQ8WUyPNbSuY2iq792gttXOLG6FuJft8YJg5h+I9rlwj5UhFDaZv2FqpD/45Vo0VUipnNNAqVF85lAH3mdf10YV/dApdr6iXBbuluUeTJH/z04EJbYqCmkM7Ve2aSc/wT6j0zGU+jUUbxm8oEpJJMKVRGMX+m10+vew5ydFl2TBARJdbVYSOwzZnw==
Received: from AS9PR06CA0160.eurprd06.prod.outlook.com (2603:10a6:20b:45c::23)
 by PR3P195MB0992.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 10:30:13 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:45c:cafe::ab) by AS9PR06CA0160.outlook.office365.com
 (2603:10a6:20b:45c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.28 via Frontend Transport; Wed,
 29 Jan 2025 10:30:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 10:30:13 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:30:11 +0100
Received: from lws-moog.phytec.de (172.25.32.60) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:30:10 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 29 Jan 2025 11:29:50 +0100
Subject: [PATCH RFC 5/6] binman: test: assert optional blobs don't cause
 non-functionality
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250129-binman_faked_optional-v1-5-a4534bc67cbb@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|PR3P195MB0992:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9edf76-71e2-4c86-a82d-08dd404fea98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVkxdVc0bDRUT3JvTG9La0pqL0ExcXhIeDZxdFJQaEZHb2JhRkhkWWlHV3Zu?=
 =?utf-8?B?YkpIN0JKNG10cDBhdEdRdzdlME9tUTVZNDI4TmpMM3dtcTlmOC85UUxzZjRl?=
 =?utf-8?B?Zm5OQ2JuNDY0R1phWThqb1E1NElrMkVHMXBObzlTSkJOakwvUTU0NytYelgx?=
 =?utf-8?B?WjdxdFNITWkwd1orOTVXRy91N3IrMGh0VUM5aG13U3BCTkNEc3RJekM4TzVu?=
 =?utf-8?B?aklmK3ZUR0tsQmVIUVJITEFZbWpEWFcvMVBYY0RmRXF5bEkrSlI4UGdMSkpk?=
 =?utf-8?B?OXFiaU9JWUZlM3N1YXV5OWtTT29IS2NqSDVQUFdiUlNQSzgyK2JaMmtIY2c4?=
 =?utf-8?B?ME9peExkUzFmK1JSVy9xQ2R3amNWWXBlcE9SU2hDSjR1c2laS1ppc1llRExp?=
 =?utf-8?B?STJYZjF1MmtqL2NQbFpWOTZ6c0I5ZDhqWlBaTHRnV2JmVWpMbGsvbnVSSW1q?=
 =?utf-8?B?K2U4L0tBQkt5b2FMR0JrMVROWnVWZzdVamhZWjI0M2dJcVBIa2dHSVQ1RU9E?=
 =?utf-8?B?VmsrcWVuaU0vdVRodStmTWt5NW56dTRncE1GaU9JbURYOVF0dlBRd1RwNWNm?=
 =?utf-8?B?K0kxOWNZY1B4N0M2bWNyRGdISGc4NHZ1cmpNWXVvaTUvWWZVK0dVWGtQQXJo?=
 =?utf-8?B?akdxN01kQ0d0SHl0Z1pYY1BGOWxoR0MzWGtpQXFzZXpEOUx2UzhaaXVxR25V?=
 =?utf-8?B?Tmh5dllBYmx0alYzZWlHWmFGWUgzNEVkZVI3a1UraCtEOENTSEFZUnd6VWhQ?=
 =?utf-8?B?WXlXRENFVW94MmlNMkN0KzlXdVc1cVB2ekNENHdDcmV4ZllEMlRIRXNmSG9k?=
 =?utf-8?B?ZDJHclJBTk9lMWxEYWRVaXdlVUpEcjFsbkcycHA5UytXVEV6Qy9WWEpGWEFN?=
 =?utf-8?B?b0ZqTVRrdklBbVY3QlNYOHdKSW83d2Z1MTZkNlBjNXpCd0J0L0hHTkhMZUxl?=
 =?utf-8?B?SlRrODhuVkZJNS9oRGNwcnpudlEzUCtHc1dlemV3YlZGQzlING5EOEE2SEZm?=
 =?utf-8?B?M1ppUUpWMElRSmNNdkwzRFp4TDhYL2xITjUzZXE5OHdLczJQZGRYUWs1c1ZX?=
 =?utf-8?B?cFR5Vnd5SUlrdFRwZVRLbFhCcklQRnVSTGs0M3p1Zk9GS2xOUll3Z3VNZ1dS?=
 =?utf-8?B?R1NqUFZ2Y2swRncycHU1NUZsU3g2WlExaGxkOHRZUTBXSUZPNjdHOE5Gcmlu?=
 =?utf-8?B?RGhXWFgwMjRJYnBnWWVZZ0F1bW5tdUVnMnhwM3VZMVZqUHZTaURVZzNsSDZF?=
 =?utf-8?B?TUpSL3ZKT1I1Q1JQcXprNzJsM3grQ0VCa1FQeHVuUkI4OHVRZ3grbXY3czdn?=
 =?utf-8?B?amhWSTIzWVhKMnVkY0IwOUFpcDFSMytEaTRXVytEalNQZ2dvci81MytXYWZh?=
 =?utf-8?B?bnU2YXd2RmxmRVhWZHBGOFNyc0tsZUhvL3lSdERFT3pNaG5xKzI0RzJqWWtW?=
 =?utf-8?B?ZWJ1YithMjBsK3g5ZFBFcFYyNnZhdGRLSzdEdllZMXFtVHFKNGVOZHNYb1BL?=
 =?utf-8?B?cDhpRVBmZk9YaDdmRm1HcDZxRXVCaWJVYnRWckkrUjQ1UUcrWEdabzlaSkdp?=
 =?utf-8?B?dVcvbW4zUThBMTVtZENOdzBkYXNhdTdJVlhzYW9xS0ZPUURyQkhtTERiakly?=
 =?utf-8?B?b2R1MWxtdVluQjJ1dTQ0ZWFTQlhCYUxpSmJ6cFlaK1MzRmRiaDcyb1pHY3Ra?=
 =?utf-8?B?dHdtWnlFK1Azd2lVQnByTkszOXdpNDAzYjVham9vQllpTVpCOWppZmQ1NTYv?=
 =?utf-8?B?RkRDWTYxU0FhQkZmN2V0UUsyeW1ZbWV5djdkRkRMTFpiTHBFNWluU0VSdE85?=
 =?utf-8?B?M3ZSb21lME42K2ZDVjFYQjE1am8rcW1sVkZrWWFvakVSaHpLVUZCM0YzdWFP?=
 =?utf-8?B?bjl1QmZZRVNSaHBnREI2NlR0aXdiMHhCMDVMamlDamxGVUZkeFFOMGlmNEZ0?=
 =?utf-8?B?NUJSUHI2T1IxeFJBM3VJYlJGanpTZWR0VFVmc2hFQ1R5ZG9aY3JGK1NzL2lR?=
 =?utf-8?Q?pqOVaDuVeOK+syLNbzi3SC3tcK1dcs=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 10:30:13.8476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9edf76-71e2-4c86-a82d-08dd404fea98
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0992
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

When external blobs are marked optional, they should not cause a
build to fail. Extend the test cases for FitTeeOsOptional and
ExtblobOptional.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/ftest.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 66d1cc240d0..f49c587f36f 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -6480,6 +6480,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertRegex(
             err,
             "Image '.*' is missing optional external blobs but is still functional: tee-os")
+        self.assertNotRegex(
+            err,
+            "Image '.*' has faked external blobs and is non-functional: tee-os")
 
     def testFitTeeOsOptionalFitBad(self):
         """Test an image with a FIT with an optional OP-TEE binary"""
@@ -6517,6 +6520,19 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             err,
             "Image '.*' is missing optional external blobs but is still functional: missing")
 
+    def testExtblobFakedOptional(self):
+        """Test an image with an external blob that is optional"""
+        with test_util.capture_sys_output() as (stdout, stderr):
+            data = self._DoReadFile('266_blob_ext_opt.dts')
+        self.assertEqual(REFCODE_DATA, data)
+        err = stderr.getvalue()
+        self.assertRegex(
+            err,
+            "Image '.*' is missing optional external blobs but is still functional: missing")
+        self.assertNotRegex(
+            err,
+            "Image '.*' has faked external blobs and is non-functional: missing")
+
     def testSectionInner(self):
         """Test an inner section with a size"""
         data = self._DoReadFile('267_section_inner.dts')

-- 
2.43.0

