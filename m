Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5CEC87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 12:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F638383A;
	Thu, 31 Jul 2025 14:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="JbOTgQht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530B7838A0; Thu, 31 Jul 2025 14:34:32 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5162834B6
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 14:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQEi2KA/XrzQXiqSBc9xg0jreSvvE8kD8Q8n/g2YOTQAsybqvenFQHwzYdVZ9HThonHEK2RF2Pp+53c/4TdgoS1OXv/GH6OxBJVbZDQxOmXc6qh9NHLfSm9u6wglcu5OKutBZg4hKV8GhHu5Q1EFRZ63FLg4D6aNe55D3Kk1Yc8zwdkhkVZxyoinNZXbmvay+Se6gj1aK1YIIw1fDIGUrbr20+uUgGIv6BKL+Y1v518ozp8LURciWgFgr08pFtmncuVljIAQLWLdurKnjZC178udgAvf7qnAZZBlWXNzAnb8NXwLmSik1pGujSx2d+V2b5Y+TQRCKpsrdx9FT3U/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTfoLe8712WfLWsqJpK2Igr6wVejKR7WEyUKMSItDyo=;
 b=FgNZ9wPkL5RxMSwA9AM+yMmiBiTPHzWvDfnziGb2FtMSREc/YkxyOv5MlUycrTItEMLTQGk92ACQY5FvZKhPYd7vqVgHEOar2U1Bb5DMJzXiVQVGpcKlEUP7/JWpLENYm/dIAD54M3QkASpe44FlfpO4SrHNNdt+rjvJUS81QxVt1bhiH1eftb1B2OFWwtDYpQr4/b5NMgch73eU+lDc//ZTn6qUDeuBflO2R5t4rejrnpK0E47PetSlDkPquFAOH6gQyS/0KpN/CybKTtMSKSNhMuia8qOqaypZW2QWT9gGAfPofgYqWqvn5cQt4sbPvHxjqJaFaVd60GW+sPX2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTfoLe8712WfLWsqJpK2Igr6wVejKR7WEyUKMSItDyo=;
 b=JbOTgQhtherAeZPqFRUPH1dzdWJuikQFcX33HkoDfZ9yzUIojHYzFyvYVDIaYle5EANL49k0KjNiKnSC1j3SlIuSlSynhQe1vDbBF4cFa8CeBnHwC6LYVF7tLYgG7uSNMLNAraRa3TFwCBLj1y9hCZhhPVTWIyHoIIFjO8ElTgac9YIKK/qk2eiAkPWUKZpB0B9PAvkWZMaY5/IBhrmSFgtyLLk5bFUaVWUtD0vr9dgjSpw8IZUwDHZgCyrDOa5WFM5qZxobscQGJRntEF74j1l3udSiPFC7hgV3c0HnBclGhdwWD8mPceWCjHGbgY7UfsWZgWgtum2bSsvv2ASj7Q==
Received: from CWLP123CA0028.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:58::16)
 by DU0P195MB2954.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:5a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 12:34:26 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:401:58:cafe::1f) by CWLP123CA0028.outlook.office365.com
 (2603:10a6:401:58::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Thu,
 31 Jul 2025 12:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 31 Jul 2025 12:34:26 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 31 Jul
 2025 14:34:25 +0200
Received: from [192.168.2.142] (172.25.39.168) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 31 Jul
 2025 14:34:25 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 31 Jul 2025 14:34:21 +0200
Subject: [PATCH RFC] dts: imx8m{m,n,p,q}: Make optee packaging optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250731-imx8m-optional-optee-v1-1-5b5ea143468f@phytec.de>
X-B4-Tracking: v=1; b=H4sIAMxii2gC/x2MywqAIBREfyXuOiGVKPqVaNFjrAtpoRFC+O9Zu
 3PgzDwU4BmBuuIhj5sDHy6LLAuat9GtELxkJ1Wpumq0FGxja8VxXjkc9w8AASPVYmo5aRjK09P
 DcPxv+yGlF3ynvdNmAAAA
X-Change-ID: 20250731-imx8m-optional-optee-ef12df51b3ef
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753965265; l=5081;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=wzVjfFXIGC5b0CXmocWY0q5vJtmhUFybkjn6ZzLjs4U=;
 b=PQTABj5yr+SuOOM6b94UbC14mjCFeYYnlxhsZ28qftJPA1I+9daL66uYP9IF9PDpas/6CrgMZ
 MjP3cwXpF+6CcPBhvg5D3VhdJGPtfLW2Y1Ab89FbdgCP2msw7wrtcJm
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.39.168]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DU0P195MB2954:EE_
X-MS-Office365-Filtering-Correlation-Id: b3574dd5-991b-4043-eec2-08ddd02e9612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHpodmFNUkMrWkUvRmdYUTFsZHpCWjBzRXJMdXFHZVByUGt3NkF0Tm14Z3lr?=
 =?utf-8?B?M0xRc1FBdHFWakFabnRlNmtMbWZ0eEVpV2tFTXVXaUo2TlFwdS9LWGZQV3h3?=
 =?utf-8?B?Q1ordjN3bVQ3Vk1VR09ZUFc4OGl5U2IycUxKRUFLdGZKUmxrUUdscnNIVHl2?=
 =?utf-8?B?enhCc2h0TXcyZk5QZ1pVK2tBYzNEaUpWcUFRYzJETGZhT3MxQzRaQTRxcVBl?=
 =?utf-8?B?aWluVHVvcUE1WEErQnZ3dy92dkZTdTkvME4vTmhVejdiZHBaUDJJMXhja2lj?=
 =?utf-8?B?U3hvZHg4Z3F5S09HWHhZQW4zZWhMOUZhSjNwWVFPYUZtSGlxZXA2L2MraFhP?=
 =?utf-8?B?cDQ3UFN2a1JWMzRVcE53a0pSdTM0SC9DT25uRmZmVVN0bUZMVUlLZ3NQcjd5?=
 =?utf-8?B?UEloZkIwclNxV2xPd1BJcVU1TmlFUGJHT0k2WDh4ZHZUN1ZhRjhScGVlcmhX?=
 =?utf-8?B?a0xrQ0tBb1orWXFuK2JKQUZoMzMwbHIzK0p1eFZWVzhGY3hCOXE1VlNaK0oy?=
 =?utf-8?B?ditCakdEbWhGbXBHNFB3SFBydUxWeG5xSHNvQ0MreWdCTGJva29qMG0wbWdw?=
 =?utf-8?B?UDlMZmJsa0x3WlBQc1dSdFhObkp0cFlDQm9mdWxKdlZaMFRqdTQ5ZjgxVEVa?=
 =?utf-8?B?RS9jSk0yRkJQeGxDQzRXQmdFU2FUYURTSnpZVFo3SGZtblRsZitjV0tkTFlC?=
 =?utf-8?B?SXVUSm5RTUE5YmZEUURWU0xwZlVFOTJ0Q3VHMEpUblh4aFEzUmZPOVlnbUhy?=
 =?utf-8?B?c0pZU25CVjNiL0NSSkxOcUVMRm5XQzNkRURscGJYU2VlOWErb0lwWHd5Q0ta?=
 =?utf-8?B?Z1dXcElTdGRYdlpIVktJY3YvTW01UGMwc3JUNGMzYWcvdUtpUXdLcFUvVFFP?=
 =?utf-8?B?Qy9TVVNPVFVNTlRiNzBzZ2pBanJOZ3Q1ZU01a2d0VmdIb2R4RXNUeEluWG84?=
 =?utf-8?B?Y0RrOG0zZ3NLcmpEdE1GRS9KMDZ1dnFlNmNJbHhlMXR2NjYxb3g5WEdkaGhn?=
 =?utf-8?B?NCtPVmZDK1crbU5SSStuWVdqcll4WmdwM3Fna0VuNFZiR0Z2ci91VWtYTnEx?=
 =?utf-8?B?YjRCQ1hmcFVPdk9nb3h2bUppWmdyU00yTDlBcTdVd3pWYXRkcVUxSFNodDdv?=
 =?utf-8?B?OUUwTTAwMGpLbWpPbkR2RVg0UUN0WEg2dXllWm5laGlwaXJSekxndVlsTzE4?=
 =?utf-8?B?ZWNhOHp4OE14T0htazIyUEJqYzhCOFZlSm9Sb1czZzBDOFpIR3NoZ0NzTG1K?=
 =?utf-8?B?MVJIYnBWMnNNZi8vQTd5U21VdmQ3cVNpYjRkMlllUTloUFp5dTBwSEM0TVRy?=
 =?utf-8?B?UVZDdGdFcHZST2o4RDNxN3NIdWt5dmIyTXJ1bkt5ZGVaT2Y5MU1PTzhvWFpr?=
 =?utf-8?B?a0ZVOGxkLzZVSTZ4U215UGJjZjBJd29SUGpVcGpGNDc5Q0psb1F1dU5rT2VX?=
 =?utf-8?B?R1p1VkRmaEVCdEMxRnc5Sm9ERXJNd3dVRFFWbFFFY3ZMS3htNDhqMUd0K0xj?=
 =?utf-8?B?d2g3ckVtMTcxM2lDTTNtM0xrRUM2NERocHRiTVJua3VqUXNEbUw0QjdGa3Y2?=
 =?utf-8?B?ZFhicE51eldvdWZuV0pySS9nNzM4UlNyZU5FUXg5RlFLbFppbWVxcVJLZlJE?=
 =?utf-8?B?dk1EOTY3WkJuOXM3NW5DL2dUR2RLY0F6OUZYWGIvVkprVkpTdXlLalA0cnA4?=
 =?utf-8?B?MFFnRG1qNXAwbG8rRDd4eEZNSkpkTUFtYm93NjZkVlEvRERZa3pBY3pWeURL?=
 =?utf-8?B?QkVhSWZFV25nWDFaSDNCY0RPL1dIR1BVMHVyZnFlUVRpYU05QldJdUxnVngv?=
 =?utf-8?B?MWhZa0VEVFp0Rk10UnNBYThobmFpV1NIZE9kcENVVEFvb0lRNml6UHpqOEZw?=
 =?utf-8?B?dEcvYTdGMm9lODg1RlQveU45cDlKT2hWME45Q3RXTU9VN2xlQU9PdzNuRGRr?=
 =?utf-8?B?dERoYVloY0IwUGlLUTBDZ214M3Y0TjA0ZDBmdjk4UGV3aUxVRy8zMmVzcVdG?=
 =?utf-8?B?NDZTdEh1QlZzbmlaZXBJZlI5elg4amhwTXEvSlBLTnpmOVprb0NBSEhWbXpI?=
 =?utf-8?Q?jzOY54?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 12:34:26.0944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3574dd5-991b-4043-eec2-08ddd02e9612
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB2954
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

Note that after this commit a warning will be printed when optee is not
present for a binman build.

Image 'image' is missing optional external blobs but is still functional: tee-os

/binman/section/fit/images/tee/tee-os (tee.bin):
   See the documentation for your board. You may need to build Open Portable
   Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
Due to a bug in binman, we had to guard binman tee.bin with OPTEE config
as builds would error when tee.bin was not present in path; Even though
optee_os was marked as optional in the binman tree.
Since the bug has been resolved in
d4f61eae2ab7 ('Merge patch series "Fix handling of optional blobs in binman"'),
we can mark it optional again without getting build errors.

I remember Fabio disliking that a warning would be emitted in builds, so
I marked this as RFC.

@Fabio what is your opinion now?
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

