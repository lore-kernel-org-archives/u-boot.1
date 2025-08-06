Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE8AC87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 12:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC778341C;
	Wed,  6 Aug 2025 14:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="EnVvJE0f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7362583496; Wed,  6 Aug 2025 14:45:37 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::72b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BCA5832FE
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 14:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0wXgGN1ls3cGJSa0XMcTdMdPFOC2xQJwjusFlDklgl+dYxuUa63T4dvnOodsNduT9/FI+NmejaGh0FF5/LMM34bcvPV+AjPbIVzhrXstymmtobba+a1Vjj8ac4wTI4ewV9SoLnEUJYHgGp9z2iEte9NAYiAvg3LoKm7MfP3bs1NmvzhV1+hyTTt143Kx5v/Fv5Iau3ZPU7d/y0DqJZ1M4WFkD3nQ4W6rec8tnXxycsZ4gDEqoJl5mAonNP+nAWyc8/nkKFoaI0t048oqSMkMrroIO4/ozOgLhqixrh4qMLpwptx+uv3IIWMkE+na4wKAYqqWEzbITwduarlumvfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6A7j/7StUc9fDyNXH00e7WbU1U1rywI3umJkidvob8=;
 b=RHbdv+pdUxhtLk+NM03oHkbt+P6EUdpd7k5qh3hjF7VJjIdVC8/DE1fXtjFmFXF7QXWgnHzpjAJ2E6eBX5aE91hCfPwmRNx94vQi2g/n8S2fVaHYs+/XP4MtP0C9yAyd74nL+TxF5HsccsDsEmBaJOABwu0ZCTIuolNHsxXSI2q/cLAOjCX/nCM+PtHquX+NVYMINYuo4yOBqcjEjIetewTVVJaInoCEYt6tbk+Dj0HbtYL6d/odkywSy8AsZgVYXZYJdKg2ii5h7o+MfzgR79tJCE4B/1fb+nZJRwSY6E/x7S1cqi1hIAPLwkNwFLAuIPhYcEhgfmWxSbf5NlLHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=nabladev.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6A7j/7StUc9fDyNXH00e7WbU1U1rywI3umJkidvob8=;
 b=EnVvJE0fVOsjo810OCC/QftVtooc8bD6iTO8+VshrMyYAXBnii9KVE9ca+uaKWvQlmx1wiyKu5JheuddiDwRR2DEPTdJ2JlawBxk7DEQ3mrEkh8auO1BO/LUZIYFcwatGSC05cwXEi2omBPr/IZFjUrMOnKr/OME/tXu39+28qesh+6f4FmZDVilyU1cEC/APBFvGR0Uyhr9lj6kaoUq1vvifklSUR1ispBYjFrsIwspzJy3b82bW17vsbIKxy2hLGvSqSbvms7BtCw7bq0rLfoYRBK6STnyR5+O18WG6B9+5BMFex+sh7wu0CHdnylPIJO0msfr8fjIv796C7UNkg==
Received: from DUZPR01CA0096.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::19) by AS8P195MB1725.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:521::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 12:45:31 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::17) by DUZPR01CA0096.outlook.office365.com
 (2603:10a6:10:4bb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Wed,
 6 Aug 2025 12:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 12:45:30 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 6 Aug
 2025 14:45:29 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 6 Aug
 2025 14:45:29 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 6 Aug 2025 14:45:19 +0200
Subject: [PATCH v2] dts: imx8m{m,n,p,q}: Make optee packaging optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250806-imx8m-optional-optee-v2-1-5878e6e7cca7@phytec.de>
X-B4-Tracking: v=1; b=H4sIAF5Ok2gC/4WNTQqDMBCFryKzboqTmFa68h7FRdRJHagmJCKK5
 O6NXqC79z3ezwGRAlOEV3FAoJUjuzmDvBXQj2b+kOAhM8hS6vKpUPC01ZNwfslB8z0FkSCLcrA
 aO0UWctUHsrxds+8288hxcWG/XlY83T+DKwoUutNksFLVo7aNH/eF+vtA0KaUflKIRRW4AAAA
X-Change-ID: 20250731-imx8m-optional-optee-ef12df51b3ef
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754484329; l=5152;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=OaAag/0uCFnlhAUdGCXhYdM926i9o8TgmHPDK8TMUqM=;
 b=sdRrd0iLVVcnrn+JV9rvnia8xXro/Py/Dl+9WPtW3JCH0Y3Vq5Gy/OEBFxyD1Z6eb1GTjbCCx
 0f8v6hyPkmpDZyMO1a825CGahBt2MH55JsvW1iMvo5OgCsS/kAKrQjX
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|AS8P195MB1725:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b0bf43-a693-463c-c197-08ddd4e720b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXM1Mk1CZlVERjVOZXdvNjlyODhLTkI2bmhpSkVCSmdBNnJRZ3pzU0JXNW1D?=
 =?utf-8?B?NStZcFVVR0F6OGR5aTB0Vnl1eFMrRE5BYnBHMThFeUprdXloWHlSYWM0RGh1?=
 =?utf-8?B?MTN3d09TN1ovOURVOUd0eWNhRjgvc2hpMkk4cUJGcXFMVmsvR2tWT2N4YnU3?=
 =?utf-8?B?L0RROTRGMHVvb2pGWlZDcFJYNms2Wm9pV2JaTHM2VzFzSklWTTZyV20rQ3Zm?=
 =?utf-8?B?YXBrUm5VNTc4VGVoZXNYR2Fpd1dkU2ZkdkQwekhoYWRlVXdlWDVUSzJFbC9S?=
 =?utf-8?B?TXk3ampPdjFJOUlaWkFLTEZiTFVJdFJxcmlvcnpvcWRMeG1HSG9tQ0w2KzZR?=
 =?utf-8?B?UVZCeXpvd0lCbklWQ3JHeWNsMzdsNXJaR2dlSHZKSURMeWlEQ1hBNy9LVVB5?=
 =?utf-8?B?UmJZL1piN0tobUZwRC9HTTJPMU9XTkRaVTFUalNOVmJTUnV1SWkzN2QxUm1L?=
 =?utf-8?B?bzBacGpCdjlWa3pmRjY1cFB2TEJodHQzaU05QjRJVGgzSFQyY2pCOWRXRTBr?=
 =?utf-8?B?c1hZLzVYSWM1Y0NZZTlFbk0vYS9RcDZNNk9YeDJYclNNVmJhU0NVTkZ4RWZ1?=
 =?utf-8?B?d0lNSGZCZkpFcFZrSmdXVVhZNFlIRE5WaWFHRXBDSjlqK0lHOWJTb1BsS3o4?=
 =?utf-8?B?aG5oMmRqRUNUUlA4bE9ENWMxWmhFTCtIT1grZFV2cXZCUkhrRkpGR2FjcVk1?=
 =?utf-8?B?VnpXOGVsWklUcUdIakVtcWpEMEViNEt0Ky9UVWFvZ0k1NVpLZzB3aFMwa2w2?=
 =?utf-8?B?dk1DMDV0MHVtWE9PWldaYkFaVncxd1dWaTh4UWpuUHBVYkRtM2JFVm9DdGQw?=
 =?utf-8?B?UUtoOTlraVo0VVNCQ2JxV2FYSG5QSHhQRjVyVXpiTDhZektvUU5Jdmx5blp2?=
 =?utf-8?B?WTBmNUF4a3Q2SWZaZTh3WUo4WXBDc0xaclh0N3lNTTNRYytKQk0yOGpuTUx2?=
 =?utf-8?B?djFEc1BBcXRiS1p6UnJqajBiTUxLM283MGdHaWVNMzk2U2J4YzVSQ2NRRzBY?=
 =?utf-8?B?RDcvcUxzNmZhQzhZaERLTjI1Q2FUVWNsalh5VGs0MDAwbjIyazY5MnVtVHBp?=
 =?utf-8?B?U3hTT2tlaUFUNkFtUElqUWU3NVJ3Q3ZLaitYVmNzOFhTazBMRjFZTHp2eXo2?=
 =?utf-8?B?UGFEakZEcG9Qc0dWcmxSSmZqazJlSTl3UGIxZU1ObTVGTFA1N2Q4UzRtZVpk?=
 =?utf-8?B?SlpSelRpbnNTOHhTYkIwdWFadDJmM2dJZUJBVXpVOFNxNmRDRUpsT2pYS0Vw?=
 =?utf-8?B?QTNvMmpkZlZSZlk0QWN2YzYwMW80eElUM0xHUTVlUUpnSGRldHlmYUpXanNx?=
 =?utf-8?B?c3daT2Z1bVNua0V1d1FoYjlXZGJ3NkNwQ2R6OXJheTNKWU9HNGZ5QzN6WkJT?=
 =?utf-8?B?VEN6VXNtVm1lVXdPMGpNWENZenVLcXI2c29YdVdnaVV4eDBxMEV4aFJQcHU4?=
 =?utf-8?B?cTNwYW9JeHZPNVkvNGc5em5ON0x4RGl4V0RqMkYrN080V1FGR0U2WDd3OWhp?=
 =?utf-8?B?VGJnclZUT05odVFkZ2wzOEJoL1BvYkNxY1BKS3lzS0UweUtFcGtmdWR6KzRv?=
 =?utf-8?B?QnFZSmc5ekhkRFNNZlNwRlk0SEI4Zk1ZV3pNbGRGQnNSc3huM2h5L3R1YUZN?=
 =?utf-8?B?aFF3NEFyQmFMbUxBeG9TNjBQUFNMZER4SG56Q01MWTlVYWUwOWJpUXpudyt2?=
 =?utf-8?B?bWZwWEJWblRPWUhGWE80ZURmV05adkt2T2RscGw1QllWQmtROU1mbWZCSkpU?=
 =?utf-8?B?NDBVeE1NT1V5b2RtU2gvS1FkOTRYc3V5bUozNmhwTjJYbGg3WVBkWkxSVWZw?=
 =?utf-8?B?T3o2M2V0enB0NlRaelErby9qUi91NGhMSW1nZkJQNUNPOUJ6TS9lUjc0blFq?=
 =?utf-8?B?eVRSVWtDS29NcE1IWVZqRGp2QytUL2R2Z3RIdFVQaWNlYTR6NTJubzlEQUJr?=
 =?utf-8?B?a3FkVkRDL2NWcExwVmhabHZKMktydXRVeGFZMUwzQTEzbTRPTTVHcXRtNXdo?=
 =?utf-8?B?L1pwZXJYTzk3S3YyMFRvSWpZbENMTTd3aUJxbSthUDY4d0JuUVZIVG03bldh?=
 =?utf-8?B?bEdTa0pqRnhUb1ZabVN6dVJUcDJTTTN1RjQ2UT09?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 12:45:30.6681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b0bf43-a693-463c-c197-08ddd4e720b5
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1725
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

binman can omit packaging an optional blob when it is missing.
This allows us to not bother with config options.
The core challenge is the interaction between tf-a and OP-TEE where
U-Boot/binman does not know whether tf-a was built with SPD=opteed or
without. This is important because tf-a might jump into the void when no
optee_os is present, leading to boot failure. Thus by marking it
optional, user is prompted to recheck (due to the warning message)
whether they really have the right combination of tf-a and optee.

Due to a bug in binman, we had to guard binman tee.bin with OPTEE config
as builds would error when tee.bin was not present in path; Even though
optee_os was marked as optional in the binman tree. Since the bug has
been resolved in
commit d4f61eae2ab7 ("Merge patch series "Fix handling of optional blobs in binman"")
we can mark it optional again without getting build errors.

Note that after this commit a warning will be printed when optee is not
present for a binman build.

Image 'image' is missing optional external blobs but is still functional: tee-os

/binman/section/fit/images/tee/tee-os (tee.bin):
   See the documentation for your board. You may need to build Open Portable
   Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
Changes in v2:
- add cover letter paragraph to commit message for more context
- remove RFC tag
- Link to v1: https://lore.kernel.org/r/20250731-imx8m-optional-optee-v1-1-5b5ea143468f@phytec.de
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 7 +------
 arch/arm/dts/imx8mn-u-boot.dtsi | 7 +------
 arch/arm/dts/imx8mp-u-boot.dtsi | 7 +------
 arch/arm/dts/imx8mq-u-boot.dtsi | 7 +------
 4 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index 59453dc36d3155b8076ac726da074caa0b568051..eb5b95a1fda7c37f8911bf1732d20ee9ede4c198 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -164,7 +164,6 @@
 					};
 #endif
 
-#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -176,9 +175,9 @@
 
 						tee-os {
 							filename = "tee.bin";
+							optional;
 						};
 					};
-#endif
 
 					binman_fip: fip {
 						arch = "arm64";
@@ -208,11 +207,7 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-#ifdef CONFIG_OPTEE
 						loadables = "atf", "tee";
-#else
-						loadables = "atf";
-#endif
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 96a6df94c6cfdc9fde9dbea59fa2bb8a97243741..4a4498b36b012eb7aa22a3feeb043013068e961f 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -240,7 +240,6 @@
 					};
 #endif
 
-#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -252,9 +251,9 @@
 
 						tee-os {
 							filename = "tee.bin";
+							optional;
 						};
 					};
-#endif
 
 					binman_fip: fip {
 						arch = "arm64";
@@ -284,11 +283,7 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-#ifdef CONFIG_OPTEE
 						loadables = "atf", "tee";
-#else
-						loadables = "atf";
-#endif
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index 6de9ab5d37cf151471707fdb8677754970bae0dd..9ede98a11e42f6279d654443bbb2d7059ad53d81 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -185,7 +185,6 @@
 					};
 #endif
 
-#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -197,9 +196,9 @@
 
 						tee-os {
 							filename = "tee.bin";
+							optional;
 						};
 					};
-#endif
 
 					@fdt-SEQ {
 						description = "NAME";
@@ -220,11 +219,7 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-#ifdef CONFIG_OPTEE
 						loadables = "atf", "tee";
-#else
-						loadables = "atf";
-#endif
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index 8a536b16e8f524b6bfea68991f0ec90d7d626246..93e2ef27f7ced9b3a471e1dc41be4b1861ed0b81 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -144,7 +144,6 @@
 					};
 #endif
 
-#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -156,9 +155,9 @@
 
 						tee-os {
 							filename = "tee.bin";
+							optional;
 						};
 					};
-#endif
 
 					fdt {
 						compression = "none";
@@ -180,11 +179,7 @@
 						fdt = "fdt";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-#ifdef CONFIG_OPTEE
 						loadables = "atf", "tee";
-#else
-						loadables = "atf";
-#endif
 #endif
 					};
 				};

---
base-commit: b40c9b0c22773c23322423e6206f049d8f82c25d
change-id: 20250731-imx8m-optional-optee-ef12df51b3ef

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

