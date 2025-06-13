Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DDBC71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAAE582CBB;
	Fri, 13 Jun 2025 14:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="uIjR12Et";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC76782CCF; Fri, 13 Jun 2025 14:03:25 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 860FB82CA0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 14:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wub9AYD6DIkwjam0wIikf+TTs8+71psUdMaFWyriYKhe7YKYnhUVdDQUOMcLBoy24pEM6M5+RFQjNgP/iKRLZmOFloDZyTz/LNBpP6UAqxRoMTJsg2yJLx1KtyFfGltf0jM6TpXg/kWN4Chd5sdeBQLqFQLH1RBt8bQRY4eEtvNQUlhDSx6r/gk6yPoJNAvXAkoWvfWXU3h+De0l/wSVUGxZq1EdJkUf9OGYLPypjz7nrdyQUuIxcpWQ61taej0ZIp79aeFZvAavsH2m3Lp2TlBgpFML+MtbS8kMGTUz3KxV2YcQVJjCpBz7XInXnD8a4MImBN0WI8C7KKPfrvvx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU0MkWnQCHDtLVCZyh/XgsaX63/4ssxrZL7IXWkUD6o=;
 b=fl1BBE9lB1+KWG+l8ZwuHV9bDP7J8HfjqrzPUAD3MfqkF/CfVwGq12/Pwtx4Lt3WTI8V/02kVfD6R25o7nESNF9+MgoQDO0CXEeIxHgbFuFihVUk8flPF6L7p44rsyU9oEgqBclfBbIMn9D4h2fDEAKht64+Y6pBwd8SZrvM6S4hWhP+YKXMEr+RVWnQNusbGE4OPQPSJMP7NeUnbWGr38rXQbsQ9vobmxtWtk41EicfEnbo8UqfjVs6cjXbyuMmlltIF1ZFUxAIQ6nCihmCIwmA82+GOhf2CD4gLu5SkGtmzYOCF4qteAeuf/whFRQsPLuwGa7etfsWaqNvchBtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU0MkWnQCHDtLVCZyh/XgsaX63/4ssxrZL7IXWkUD6o=;
 b=uIjR12Et0ZQ2dvpCDjF+G3dqmGOF+h5wxptGe8GD45OE4l1M+kQWEzA8NXB1Uwpm9LndpjDNBWM0JDJ3EQvJuLg5sgGc7dnfWH/G5AtLf/i3IVLhXKXtzrI5PDKB2f2h+QcdOS0RsBgnxT+eL6AwJtX9Rb27j1GCf1ct+WkQXPmKNuZ5XUy8ZT5e+9SQyTIqhW1KDxQpuqMBw5pSqL8SScLKFcRvpFyc6t5L3CwbWQnfqah94xR2zJ+M7oCBf3+YucLF9jm7pqeDDaL/r0m91ASwEAyJRA+FdHieFH+yHRqS43ZacZPVmFxRgELNYPEJ5HmoxnHiCDI1/Wrt9DDmzQ==
Received: from AM0PR06CA0127.eurprd06.prod.outlook.com (2603:10a6:208:ab::32)
 by GV1P195MB1690.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 12:03:20 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:208:ab:cafe::62) by AM0PR06CA0127.outlook.office365.com
 (2603:10a6:208:ab::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Fri,
 13 Jun 2025 12:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 12:03:20 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Jun
 2025 14:03:17 +0200
Received: from llp-moog.phytec.de (172.25.32.81) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Jun
 2025 14:03:17 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 13 Jun 2025 14:02:45 +0200
Subject: [PATCH v3 6/6] binman: test: assert optional blobs don't cause
 non-functionality
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250613-binman_faked_optional-v3-6-1e23dd7c41a2@phytec.de>
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
In-Reply-To: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749816196; l=1985;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=8B4YpeYqemlW3fuyXQtE6apN2BPu0uSeDci7/PZlBPQ=;
 b=rviS744AUxPY4DhE9s6TWTzObJlme/H7yrcubmoYsVx9qm5zICe6fBNqmJx7MvxzvpgENewI4
 +rzPmWsP69JAwfCmVyS8OcDQ694Yvct8yhHv4ScwQMPrhJGlHzlMHf8
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.81]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70B:EE_|GV1P195MB1690:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5204dc-2a6f-4320-bb8c-08ddaa724a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0hQdndFOGpWOFZlVURxekNzVW1qNWZSMUxpeVUwdG4rTWxiUXJRQkNBWGlp?=
 =?utf-8?B?cW9iUDV1dHFieGJFOEl2WGY2RFhvNjJsc0JsNWdUb1pvZlk4ekE2VWZnMGtI?=
 =?utf-8?B?TExoQU81eEZkVHprRFZTRzM5Uk9LcDhKaXVpTXBDSlhmRHl1NFNReVRYZVNs?=
 =?utf-8?B?eU5ORHpPRUxoTWZoUkRYdGN5RXNOa0FYd2hldmZCc2MzUkhLdHl1cEV3eWpp?=
 =?utf-8?B?L1BhbzZDZWYyWjVqT3FFcXplbDJzNXE0eDdGT2VobThrbG9kMmJvYUVjQVBF?=
 =?utf-8?B?TjZReEl4RFNoSzhacXpiTktsM2JjbW5ReFRBVDZTZkgrZTJMZSt1TFB1K2ht?=
 =?utf-8?B?Z1V2WE1QSHIrRnpWTEk0UnZUQUpjQWpBYllsMHFqaXNoTVNQRDNrU29keUdz?=
 =?utf-8?B?Z3QzL1V5NXlOZzZCeXVvRTBqbFd5NjdYRWlIVTB4MFZ4WVRxbHpkNE40VGFw?=
 =?utf-8?B?K2w1dWhjdzJseWVsOEJHc29FUGR2cUhKVGEzRnJESFNZT3VJbDhYMFhrZUht?=
 =?utf-8?B?VTZOTUFya05jVkdBUEN6d0w4U0FUL1Nra09SUjhPMUVOYm5LcE8xTWFadW1H?=
 =?utf-8?B?RjJwTjM0UmJ5Q2luWm1UcGE2WCsyT0I1b2djaC9GbVZidTdDSHV1SkdnRTVn?=
 =?utf-8?B?eVU4TnYxZlJXWlp5cnJ1a2Mzb0VkeWtLb2hUczBXSy90UHNHQ05WQ0pMeGtK?=
 =?utf-8?B?MUhTSWN0TW1VVENzK2VmNGtmS3NxL1Izbm9jbnVKcTJuMzZCZHh2ZVVRZ21R?=
 =?utf-8?B?R2RKSjJiZEVGSXlwSG1uZ0ZscEtLRytCbFRvODdQUy9jOFFIaGo5Y1MvbWpx?=
 =?utf-8?B?MVlRMTd2NzZTQXQzQVNXZTVDMmgwREJYQ0hpdGRpdjFmRExsTEI4YTNYOVNC?=
 =?utf-8?B?VmxzMldHNmd3Y3pFOTlzQjMyeFd5RGJhU3ZIa2VlREZPemd3SXBZb0VsVjB5?=
 =?utf-8?B?V1k3NGlzWWRKWGNPbVcxVkc2dXNNRU1XazVPdWs3c240SzkwOERqem90K2xk?=
 =?utf-8?B?QnRITG4rTERTUDlwdFlrZFpuQTJGc1FNV09XaUFldWpXZWNiRktSUVBETWJp?=
 =?utf-8?B?SGpMN01PTDVNOWU0eWFMS2hxdEYvNlZwRGZETXVMV3BMU21tSStzcE9ZU09X?=
 =?utf-8?B?RG9TZ2pUeEFWNTA3TzliS3VVVENZZ3c4ZkUyeTZNSUFSenVWb0VpYWRSRkVQ?=
 =?utf-8?B?TE9YVzRzdTJTRitVdkVhZVc1QitBTlNEZUZCOVJVRDZzMFZzWkt5RUpqVm5Z?=
 =?utf-8?B?WkQ5RGZ3SGVsZGZVSTFrMFMyQmVGRlRVVE9IbXdkWENoemtuV243b3k3bm5B?=
 =?utf-8?B?NHN3NFdXcVErSmFlVC8rcml1YWtIMTRQZm1YNG80MVpqM012UExnNHQ3Nm5Z?=
 =?utf-8?B?SWx5b09JRXRYUVNQRDV4TmV6eVRTQjRZVlRFeTQvZ09wUXpiMWRXb1E0ZFJr?=
 =?utf-8?B?ZE9WYWRjSmNLRnQwZmxTNXlTZVBiN3NIUkpDTUlOdkI0d3QzUnNjbnNIUENq?=
 =?utf-8?B?QThkb2dFZjJPYmZYQW9tUW8yWGxSQ3BvbjQ2RVJtOUdUYllZRlRRdWVFcGJU?=
 =?utf-8?B?NmoxcVJUSUJYdFBZdit1RXJkRHQ2bE9LallZc09OdEpiZDIrQzh0NUVEZzNR?=
 =?utf-8?B?NDFWd1lJZ2M4NUJzbFlNU3RZWUFtM05QM3VYUVYrQmhlUmVuLzNsd3Z1WEJY?=
 =?utf-8?B?RVdNTWs1VGlUZWxldzNYclhGYURjZkJKb2h0Ky9mNmFaeU5tejdpWXJuYlJX?=
 =?utf-8?B?QXpXTDFEVzQrTVBmaEhPUWM5NEZwRjRRclhwTm5ZN0JreHpNNzY3ZFFlN0pl?=
 =?utf-8?B?SzNGRnZ1VVFQTE0xelJlQW5vdW5zOHJYOWJRalFOZWtydG9kb3YrTEg0NnZI?=
 =?utf-8?B?UVRKaFdkVW5KTGFEbXdkL1d3ODN3TmUxZHpEMENPbkRNTkNBNzIxRHBSeUhj?=
 =?utf-8?B?N2E2a1owNkNhTHorTVF5STgyV08rWTUzSVZ6c1ZsRGwrODJ1a2sreFVZcXFO?=
 =?utf-8?B?M0tYN004d0U0ZlkvSTlXMitmend2L0pLNmJpQUcwNlc0UWQ1R2xqa05TYVlh?=
 =?utf-8?Q?UfkORS?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 12:03:20.3464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5204dc-2a6f-4320-bb8c-08ddaa724a2c
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1690
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
index 32e1e0a14c03c9ebf1d9ce1f8278841959d7e5d8..bedfcb53c48bd3b73c059fb406ce28ed09112b2d 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -6518,6 +6518,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertRegex(
             err,
             "Image '.*' is missing optional external blobs but is still functional: tee-os")
+        self.assertNotRegex(
+            err,
+            "Image '.*' has faked external blobs and is non-functional: tee-os")
 
     def testFitTeeOsOptionalFitBad(self):
         """Test an image with a FIT with an optional OP-TEE binary"""
@@ -6551,6 +6554,19 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(REFCODE_DATA, data)
         self.assertNotIn(MISSING_DATA, data)
 
+    def testExtblobFakedOptional(self):
+        """Test an image with an external blob that is optional"""
+        with terminal.capture() as (stdout, stderr):
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

