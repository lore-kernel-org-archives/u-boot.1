Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492EBC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 12:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4F4180326;
	Tue, 21 Jan 2025 13:25:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CvnrBCS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A38805C5; Tue, 21 Jan 2025 13:25:19 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADE7E801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 13:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwIJvsLSnfuzpsefVlwODtadVoYEKzO+V+b89h8C3tXIG+ta+xh1YihyBhPqfECwm6ByvrVYu8/+gJ9typyB7vYFXrxk2yhGpRSPkletk1oqxbDJB1NPT8LzTZriYLTOEUQEWlFG185jj20NNOzNrQoz2AysoK3VzLX7AiuJyjvanNxpAG8PjHSUYEGSAdic1+cvHnks9x1jPlT3AUgPuQzDJwCQoZjHqwSpCskKLfaIKSGNQD2dBDE6d7UiSfPO7X9VeazUpxkP7XhuD6j2VFZyqwBNBGqKho4lhun+OLMiR9lETeqo7MGyg4Efd+9iEQQao2snA1U1C9v7vBV4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMdC0mPYIE3ecRSuekfThxs82lXBhqKmfD9EvKqfGIg=;
 b=mZwglsHJE43mZTTV6HmO9fCBy0Po6J27xprhF2l9Q3PJJyuLQhzk8js3tdIAaPZpZBK/Yid9qTjdYVqarZMfLDxmniociqSptiwDDKWusOiIkZyRxP6FOUBgsFheJdo4dqQ/ae2Mb5x+CWtypUt1tb+EfGrPsdSO3LzOKmguFB1j9sFwGyY0By5lNq4tDny0t0sxI55lXoQVhWiHQIZ8tkRf0jehzjW6k4t7MX+lIOFwUiIDlkXi08RZMgHgQfDFDe1qze2TENmwTQ3lmz8uuJSD21IISipxy/xsAS30K1UKTAGBGBZc7kApXBdXMdoCNehDbjKNzK5texRHNWn+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMdC0mPYIE3ecRSuekfThxs82lXBhqKmfD9EvKqfGIg=;
 b=CvnrBCS343HHCMLPJryH3Cl3nBBJytTS3V0tu8Bkk6rnQHyt85AHT+RgTvGVfwPFPZCjUCRFMdjvOUX5Woe9HwbbgskV7hksqzKNaULP2kPmw2mqN0+HAYZFn8RVXzi7VgUp4nTAk3WpMVFg2EF7Ifgw295NjYMsbvnwKrErOtU=
Received: from SJ0PR03CA0374.namprd03.prod.outlook.com (2603:10b6:a03:3a1::19)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 12:25:13 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::85) by SJ0PR03CA0374.outlook.office365.com
 (2603:10b6:a03:3a1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Tue,
 21 Jan 2025 12:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 12:25:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 06:25:09 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: enable u-boot itb generation via binman if SPL
 is enabled
Date: Tue, 21 Jan 2025 13:24:59 +0100
Message-ID: <7cba738ae36dacf7d1b0cfbaf13e0c9b3a0df225.1737462296.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=dt9cAiShwyo5IFNE8a7JJEI6N0ojB9yeiO6a5dD3sUQ=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvT+SXKzdH/uvJ+nccTwyb19O0VX3J3qVDzvpt77NLfyK
 Me1qxgedcSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJbE9gmF877bCbLAs/78s3
 s1vUpO+HF5b95mKYxWS8z03hksbtH7c+xChH9Tw+trnEGQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 5575fc6e-8ae3-4436-95a3-08dd3a16a70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kMdK6p1X+ELaVFErqLD8EJcQQQxUNdS7CWo8VJgW3rXcgOV3+kqh7c2HNM8P?=
 =?us-ascii?Q?ZDbkyitREiSyQzhnBoKPg4z0yloszX3iY1Ao3F4Yk7BF7jREfAKRur93fO2L?=
 =?us-ascii?Q?r4aWAHN0wjYLpZppRqpDhD15SILxyoAE8JxysQ22CawHwjds7pr9PXASbsDy?=
 =?us-ascii?Q?pM+s/Tk9ddXNepWQDuMH1XKVCBT+NlIQg4xoNLV2aGmXJ3RxuT+9qpsuW+4j?=
 =?us-ascii?Q?XIJSgGGInz4GqO+cy5DVMa5DBvbnfWfIAHSQ+/LNVsnLrry25cu6/kIFLyck?=
 =?us-ascii?Q?6VA7XiM416GmcXHkSMONe1HMeV294i/fa53J2G5yF0Kj3j+dWE8CYNV4W5IP?=
 =?us-ascii?Q?PQhKI/lk6nFXxjp9GfTPMWuH1sNuExjx6/XGzv3Tz51j6cPickZKZC/pSWaA?=
 =?us-ascii?Q?SUO/iLCynF5BkIWGxdDG/evrxNd5YZ8+K4g6ir7GfAs1lejQYazPPAbYTX0A?=
 =?us-ascii?Q?KyAXDQnD26yAOw2whSs2SaFG3IEsQgq1rjIXlRQbGcgSEGiB7Thfhg6Dg+L/?=
 =?us-ascii?Q?aobhQztkWZ8RnL5FBlvGMWR1B7Jxc5qBfZNff6mRjTz/l5j8cau91IV3F2i2?=
 =?us-ascii?Q?uiRoh4gRg+ipMCuX3gWmG0dR5T3l9wh2kXgpH2gofcyMfvA2J+VLq5HdGLi6?=
 =?us-ascii?Q?YIEbeZwApFf1idRPlVTWspADIrOv6OeaUgweIcB+TwhrIrsWA4Gmgmo86MPc?=
 =?us-ascii?Q?wnZRy5NXag/CEiW3rq+85nui0/OVJOirTLYp9qp3xn/AfPR86QcX8yPnumOb?=
 =?us-ascii?Q?bDTUUwB1EK3I8yacyJ4yXgkcrln/HjcKyBDdXmHUGbwJhsc13X3kSFl6TW3N?=
 =?us-ascii?Q?h7URF9hnv658kHsrFKWXlmeiB0wXCaV4XRx7i83KztvSct7DiW/fFSZ9wl8P?=
 =?us-ascii?Q?Vi/Qejgz1dinlUGCzooOgCCYPbwo65woOpOXgQKv69ZtXiXg60vf29i8a/Pc?=
 =?us-ascii?Q?WoKt3V9oXE9S2pXudNc16opojLn5a/MR6mPckrk43zhLrVpGlUdLZUm89bXX?=
 =?us-ascii?Q?IUddOCXvMI8aKiITROlPKZGLd7owWr8xrym8GIhHH5uU1rLA/mAgOM4RKb71?=
 =?us-ascii?Q?92urIvL/2qlwQkXLnWq3tNd2QwjvqGny3ChhxbSGlVhb7Eo/unoRxcE13F1V?=
 =?us-ascii?Q?nJQDHfwAAbJIDwzgPk+Q2K+Z4AVKBMiTA4U8bv2zjszmDUfRhWe0TzoQHT0H?=
 =?us-ascii?Q?/SxhEN3kj6BaKVdAVekvVSjue3sT/meRJmr9UED3AFuNJg3n2BsmWriQ1+B4?=
 =?us-ascii?Q?hRFS8LFVXUsuwnJvBKZuNL8h071LF6X1cka1PLU91jRdEaBeMhUB2UOUS8mz?=
 =?us-ascii?Q?OaVEtMxNkbdeox7Az2KFHMv95HecEaFRWOyfuvjDsZtTDLApFxG7N7CmlZUO?=
 =?us-ascii?Q?uP5Tsh5ais5zr0MysJSzOZ5dvhHk0OEkdzIr5GUUPLKq8hWF+hRQxwr/Gdnb?=
 =?us-ascii?Q?EQwHvN+BFo6FNSGLE6PZElHBD5RVJOls7Qci7dbxWb0Nik5MfV1Yxg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 12:25:12.1761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5575fc6e-8ae3-4436-95a3-08dd3a16a70d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516
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

From: Prasad Kummari <prasad.kummari@amd.com>

Output images are generated via Binman only if SPL is enabled, as
there is no consumer for them otherwise. An #ifdef check ensures that
when SPL is enabled, Binman generates the U-Boot ITB. If SPL is disabled,
ITB generation is skipped since the ITB format is supported only by SPL.
Without SPL, generating such an image is unnecessary, as it would not be
used

The second reason is that when a DTB is passed, the current logic cannot
handle it without an additional step in U-Boot to parse an appended FIT
image and enable board-specific code to select the correct DTB config.
The MULTI_DTB_FIT configuration should be used if support for multiple
DTBs is required, but SPL is not being used.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-binman-som.dts | 3 +++
 arch/arm/dts/zynqmp-binman.dts     | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
index 3d9d8476c98e..3ffa06f0c04f 100644
--- a/arch/arm/dts/zynqmp-binman-som.dts
+++ b/arch/arm/dts/zynqmp-binman-som.dts
@@ -13,6 +13,8 @@
 / {
 	binman: binman {
 		multiple-images;
+
+#ifdef CONFIG_SPL
 		fit-dtb.blob {
 			filename = "fit-dtb.blob";
 			pad-byte = <0>;
@@ -220,6 +222,7 @@
 			fdtmap {
 			};
 		};
+#endif
 #endif
 	};
 };
diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
index 675f6bf51ebd..bf3335a3e539 100644
--- a/arch/arm/dts/zynqmp-binman.dts
+++ b/arch/arm/dts/zynqmp-binman.dts
@@ -14,6 +14,7 @@
 	binman: binman {
 		multiple-images;
 
+#ifdef CONFIG_SPL
 		/* u-boot.itb generation in a static way */
 		itb {
 			filename = "u-boot.itb";
@@ -201,6 +202,7 @@
 			fdtmap {
 			};
 		};
+#endif
 #endif
 	};
 };
-- 
2.43.0

