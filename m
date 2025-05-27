Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E56C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C11A830AF;
	Tue, 27 May 2025 15:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="TWo5alZ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 038528384E; Tue, 27 May 2025 15:24:41 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::703])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EED498383A
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bE0qD0vzga9Joe6QoeCh4Hyn9lOnErJWiLOyFVhCFOyeKIV97pitLq6yMSB+ELhnXt5YECkn0YyvakyFEc6BWWQNJV8lh/xS1zQp8okMNTO5UJa+Qa0UCSA8EMwFv9udK1PEYETyTMwsF3ucqfuYt73H9IfQ0HPf1ADhDRbokWfw7BPDOif61FOrCjmTuWC1JTscJ1Yz6MuI9PHBNbAIkyI9iJ2K811B1cDqLu0jvzGZE3zpSenZTbg5W5Av8WyukHkdfXVOPEFZNfTn0JTXJ2wMrkwzTjS9PFH2cA2L0t3jNZPd+7PBsYViu6FUd65W6uGgQqY0ogjCrZbi1oEzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQaxOqXEewjegX+8FweC8CkvTMp9WEfsv3rSS/u+mBM=;
 b=VvaJiRoezXfFhv7NqfQPJgaJ8ejsp0OrBLMXNNiRXlDUPC7bJYODkUeh7v/30slB4BecrA2TfJzWlCkf+BhC3IYSilWfp+ESrjFZ/p+sqK1hl/qrl9SYKl7BQ48SBH5zJM0Ma3csPSA2BddmoeH9FEVHl22Jy58+2whsFAgDNzKQyw19LlkuIOtBdpAnJNGwdSkwcurYJ1Zvs742N55DKtpfotXjfM4wUh6A8IHJGhB83CeHAvAWrLcSUWX3MrOhb7pWYYk6QK038aD19Je4N6z60iSHsUgcVGjMTa7Vwsxvy4YbTJH8xeU/UURO0m240c5/1QFhFoaw/DmSm4Qv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQaxOqXEewjegX+8FweC8CkvTMp9WEfsv3rSS/u+mBM=;
 b=TWo5alZ5078HCsVd6lV4yQhd2Bc5GqmfL8iQySMfOkB/j/fbxiEx5eWIcF3nC9Q3b2OhbfGQ2L5GeXV3n0P0aKtBRn2VCzcuper1QISsIHs1JRmIUKRJ6WvJssayTzPRqous/+a2VBDSKq37950MIPu5ty2kKjBwIU2Eh/haancgpLUKLLJZ3UMcbx9zS92xuJHguabQI4JWs7qDvbGoAkIsdZlEbqHfHRe+5O1MN7vmiZQDKcVJ5an3H2MDu869pzynnKX9on/kTympR69wYvoIXJCGQjC/3wvtmy4lZUniIBvZMNcXTwehNNOoWyxEx7ytzQn8pXCtdU6rwLEbjw==
Received: from PR1P264CA0036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::23)
 by AS8P195MB2385.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:631::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 13:24:36 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:102:19f:cafe::97) by PR1P264CA0036.outlook.office365.com
 (2603:10a6:102:19f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 27 May 2025 13:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 13:24:36 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:31 +0200
Received: from llp-moog.phytec.de (172.25.32.70) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:31 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 27 May 2025 15:24:16 +0200
Subject: [PATCH RFC v2 8/8] binman: test: assert optional blobs don't cause
 non-functionality
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250527-binman_faked_optional-v2-8-3362ab897581@phytec.de>
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
To: Simon Glass <sjg@chromium.org>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748352270; l=2018;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=99mKBPoLKbU6rqxrindGXabDhZXsfhqORpUoPmDQFVg=;
 b=45iTqRv5lZz+mB/NV2BCTbXF0JUz9nUj3eUaLlXgDh8KBi0dWC3kwesPzxbN3PAUOBe+wqqcD
 zYGTIf9bbrsDCzENE07pjgCpDZmDh1jkDIO+49BOMowpl4Ev1a6aGSL
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.70]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|AS8P195MB2385:EE_
X-MS-Office365-Filtering-Correlation-Id: fecfa819-0e56-4bba-7797-08dd9d21d358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjlnRGk0Z044b2dETy9GU2VGUmNHTy9ZcFBlUVR3V1NDZmFFKzJsQTZSL09q?=
 =?utf-8?B?NEFuMXp2UHZFdWVDYmc2YkkwUXdXbWkxVms2UE5rZVpZRW9TZ3JwRVhHWmNF?=
 =?utf-8?B?K2NqZkhnNnRYbjhUbE5pVC9iUVdFUEtPaHZmdzgxNWN2c2dPVk1tUHZhbVBr?=
 =?utf-8?B?ODdvYTVjVEtOSC9JYUp2Q2o2ejFNWHg3UEVhVnJERjhOVER3a244a0E3bzdm?=
 =?utf-8?B?ay84NkNadkdqM2tscjJBbHRrZnZFNFExMTJxdjBvVzUvd2prdVdTSFVGZ3VP?=
 =?utf-8?B?dHR6bVVJVnNkRFlxT0FRdmFzaHVQeTZKVXROa1E2Q1FjS1BKZS95QzNNYzh6?=
 =?utf-8?B?bDZMU204eXlEWXBFck00TUJXR0paVjZkV0xNRFQrbkNhZVRac1Q0eitaS2pK?=
 =?utf-8?B?aC9FTm1FeEVIRWtIVE9kWlRnR1VDcURkbHAwcG5lNnRaektpODNVVWxpZSsw?=
 =?utf-8?B?dDNaS0xhMWlKRUtKSE9QRGpHZllNQ0lFY3k5OWkzWWw4c1JsaEFVTTI2ZDdG?=
 =?utf-8?B?UFUyVzI5QlQ1dS9HOG5YM25ERWNCcDkwb3BNUzZxYmFaUUtLQmJCM0JrK1pm?=
 =?utf-8?B?emtFeE5NbUdyakZKU1hyeFJ5N3FiTHBtR21RZDd6UW1Iais2dHFiUWFVbXN3?=
 =?utf-8?B?dGtWQnN6SDNpOEQzQzg3czFLYjMwdGxmUWMvKy9tdHVEWFVtSDNUd21wTGNJ?=
 =?utf-8?B?ckYydzhWL280dld0Y0kzVHpKRkFZQ0piVnlrQzBZQ0Nybm56amgrVndVeElo?=
 =?utf-8?B?Y3pQZG1OcFlHWHltanBLQTFCZVl5NEluNWtjaUF1b2M2RTluaEMwU3YvaXdv?=
 =?utf-8?B?NzlYdGNldlRkNlZMOENvSDhhQWlFdW1Ib29HRTlOSHlIMnpSUnNCbnY1WHYw?=
 =?utf-8?B?Q29MVWxUNEh4UUtJMXgrUk55a1grWWQrQ1JkYUNjTDNlaWhPR0xGbnNtY0hQ?=
 =?utf-8?B?VEsvUEIwZlJVZ3BweHpmcVNWMWhWckQvVnBVYlp2NDllclphejlXay94K01Y?=
 =?utf-8?B?TzlLOEpTVk5yaEtmR2JrbGlYd2NJNEVoWmtVbjYrejVSaFpHSU11L0IybW1Z?=
 =?utf-8?B?NFdLT1REZVhjZnNPZkZ4VTV0TS9oT016M1BIcUgxcURaOXJId0w1S0hUT0sv?=
 =?utf-8?B?ME5YMFl4WWYwV09yYTVCRGxKRXRXUU9nN1c3K29yRnhDaWdPTlA3STEwT2pl?=
 =?utf-8?B?QUhDSDhGU2RwcGROOENSVEhkSHRsM0JCbWlqQkd4WkQrQUhoRFRlUENKazd6?=
 =?utf-8?B?dG0vY1k4VEZtaFllcUxmYUwweDh6TDI5VUZ6NHpHaGZmZ2NnN3ExQ3JGVGRE?=
 =?utf-8?B?ZEw4MFJxeUNWNnlKdDkzcGRRa1lDNkUvS0tuVWRENFIvN3FPeXJPQTBZb1V0?=
 =?utf-8?B?bTVpZWpCT3pmQ1pacUplTHJKR0xjT1dlQmdzcmpqb1lyUGczK2VQbWl3MkFW?=
 =?utf-8?B?UThPU2JQckx2R01oZ1FVRWt2SHN2TkdIZjhvWUxxczdmRjJnZGhvcHBrTHc4?=
 =?utf-8?B?WHVtVVltQ2E3VHNhTllyL2VsQVZsN0pSUXd4N0ZyTmpOYjB1dC90QU93WDhP?=
 =?utf-8?B?VlBGbGJNR1lvWmhBVjk2U0VMVEc0QWpPQUhLUldRY2NoVTNudjBXSHhCVlAv?=
 =?utf-8?B?NXFFUjNVU01wK3AwVjFsSlFlSUlMSjlpdEN3QUUreW9yaHZIaWRoQ3g0MHlC?=
 =?utf-8?B?Ry9nUGJ2R0JTeXExcEM1dDNTQ2ExYUVDSDBBQjgrNnNxT0Z0K3NuM0FPWDFT?=
 =?utf-8?B?Q21IZktXTjQrNTNRVysrZFFxaXFHNFVvNjdBemxEd2p1aEI5NnBYaGtLS3N3?=
 =?utf-8?B?Z1lIeFdFZVZ4SFkreTIvZC90MzdhUzVNNkhNOUtOb2w3RnFoZDVQOEc0cEpq?=
 =?utf-8?B?L1ZNNlNDRUdXTnRXazZxVDlyQVc1YStPcjVYMmhTcHVjZjBVck4yeTMwc0s0?=
 =?utf-8?B?S0VRMlJ4bDJpOFhWOEtyajBQQVI0WFErd0o1bERkU21mWWp6UDAwR3NKSmxp?=
 =?utf-8?B?UHdnejZHSUpGYjZQV0o3NVptRnNEQ0hZVEFEOURIQnVIYkNSWHF3dGpkZ3FO?=
 =?utf-8?Q?G7dsdU?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:24:36.1335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fecfa819-0e56-4bba-7797-08dd9d21d358
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2385
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/ftest.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index d7deb3e68ce69c9c1a132f8f29cb71638646277a..31083c22bbf9e5898840505b0ffbd4512c61ae80 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -6506,6 +6506,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertRegex(
             err,
             "Image '.*' is missing optional external blobs but is still functional: tee-os")
+        self.assertNotRegex(
+            err,
+            "Image '.*' has faked external blobs and is non-functional: tee-os")
 
     def testFitTeeOsOptionalFitBad(self):
         """Test an image with a FIT with an optional OP-TEE binary"""
@@ -6543,6 +6546,19 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
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

