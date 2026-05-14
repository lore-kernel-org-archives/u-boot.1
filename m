Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E21DCD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 10:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0933839D9;
	Thu, 14 May 2026 12:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qy6nonze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5037D83E81; Thu, 14 May 2026 12:27:31 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F0D8341A
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 12:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJndrdQI+eaaijHd3IkyxNYqlint0Fkj6pBI2egN89ExBZi1kOfw5l5t1+1XBCRWnZ9hXoLCDOwQNelLqkU+r6mcmdXZ01dqYXBSbT0vP++d/9mG2AjnEnUhuDJvAr8V2V+fyFaHaaJwFuRnesCwNkvHCxQAinurA6Y766lBcz9GZPfuWel2trV8E1a+wC4+KPGk97J1no6QjJp1/Fg67s5hiYChl9NI7H4fRgtv4mfm8Kgvwik0ZR8L3R3SW0d4zjMmlgNrX2NivG3RrkmudmpQjxsoBH68Xegnwfda9hX+a5zxw+rZBui55VvN9fObSzz7T4n1JTQpTI8AzxYG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgLH6dEQX9ltgePszsZsNQRAOdV/BFIeQqJmBjdn6bo=;
 b=OGMvuq0y079ii9/cJ9DlcU38aIR4qDgq3hxzQPtVLj7hTJDDlGfmPGuXO/Ws6R/yVXl3U6CnE+9BCV9PqGvPfnGn5uO778jxwYiP3lb347hL65rkWtlxksmhMyPVWo5GQMS+J4HE5hKIeK0n3VyeHSu+70Gpc60NnQup4YlhFFjQVtk9pFQBiY9mNNB3phTwelRzbB8k2P9ybtq9NbT3NW005thaCpNadDWBxpWqHrKB/zvzPwyjY54Ov2mTexyYtg1EYib0mq73K3eltMBbzfnjbtJAL2S6tQlPDZrL4FoZtvJvP2+d5OWrfW9SEErIl+6vlYfrP5a6BSZci4owNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgLH6dEQX9ltgePszsZsNQRAOdV/BFIeQqJmBjdn6bo=;
 b=Qy6nonzeKJnRG3+DHrN1nYJ60UfUMgNADfyuQZLpbg48BxPVcTHobcyBfvIAeGOzzLWsH2eJ2oys7/RSy6JYjjtdg9hCBv1mu6FqdK284kHPZwQNDr1nvlSTKEur+sSVPXT75hGWVYeB78bMMl0rmf0yVyP9Dmd9A8FD87A44g8=
Received: from PH7P220CA0126.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::11)
 by CY1PR12MB9700.namprd12.prod.outlook.com (2603:10b6:930:108::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 10:27:23 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::7) by PH7P220CA0126.outlook.office365.com
 (2603:10b6:510:327::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 10:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 10:27:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 05:27:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 03:27:21 -0700
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 05:27:19 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/7] arm64: xilinx: Add PMC PGGS3 and PGGS4 registers
Date: Thu, 14 May 2026 15:52:18 +0530
Message-ID: <20260514102601.1759779-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514102601.1759779-1-padmarao.begari@amd.com>
References: <20260514102601.1759779-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CY1PR12MB9700:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c5b071-0822-4709-8340-08deb1a362bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|11063799003|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: /Fr92ABmiio1P9eHhxXWv6x4JapOhaibqxTIuXu9ft7twjpUz+wOKjswjGTFp06fMjewfPsclUf3aB3qzuZDMJdG3f7ZpDCdUo/RheVI31ux7eXO94T5d2vuhfVa/5eK2c9n8lrK1Gn8ZOLgsCtzsJKNeMtwv+g2+8wnXZ8wxgYkvfUT6X6ynp0CXiiW4fqXKxO9vOw5tMWJyMzyaAy3TECUoF8rtoyYcPyO7VJTMvMVN5AqN6DRflUUOkVywoSeE5/g+VQsgD0gd4svWg3gqEVtbcVGbhJCyqO7JafmeLVRp9jHyL0dPJXGsp3fcActGP+Cuvmet3jZ/ZwBTkgI4iTEMC1t7QJKD4x3SNiD8o+wJsV4Ercqv/UgOlkozdSgYCMTnx/T1IULhySbXNlkT0+tw+tq4mkg1pA2rEh+BZdNaKO5Upbm0U19D83pTHn06z3BFV+dMEElmKxx/MGYEhWVdRefZptw+CPg55uou2eOb9kcHA/kRu+TfsPiGT4fnwlA4HCFXIzDKEoEhzRIz0GdyniVBrqaOFE8PF/HbSeamXHlHbJ19FzRVTxlSBTVQTKY+aOWhKDmh0vNYA7sncxE8ph7MQqhNWjALEqnDElnkAFKUMmzR9cTCRcGGKHlLw3kMpLqPPODtTxVXtCr+uEp6LeVMYg6brLwF8InReOKmDZsQgFyC0kdPc3H+gC0MWttqBv6bNXyCLyRT5yahla3Ow3bM2MtfNHbLYMwPr4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(11063799003)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JQwmLjQjHRD2xFCFyxPLIMzyXAC1bXCA910gqPTcjzbTJwXc3+G12FFhHBsQkpyAPsLMSFRm4cDnz6dgqldUEtC6ZzYNBlG7QpZWtEx/35nBg8mZf3APD23MnGiW32IwbGd2xQ1AYFn24ywa29z7/kYhZgua00kK7wMVXtXpHhekxC1XFSsMDdk8a8JtGbWB6bPY+mATV4I9FTaTC2e/TWmiAXOe3opbvOa4zIvLJtOUeV6ZL+2TbyEVMhY92HrZ2TcCESeeftvReuFLvM/dOTROmuARR3QisNdF2bqPiRz34AuM1r1r7PrZKUbE4GeXLWZ1zTx+ujnN1oO0NfBcd5Dw7zw7JfIiYzlz8LGmHzo8LC2zdAzpuhrLsXBKA2AuPVLHpzWE2MWTh42GD9XYdpt6Xs8jkde6fIn3y4PoCInKRmuW5kX7DT2bLFlro0T6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:27:22.7056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c5b071-0822-4709-8340-08deb1a362bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9700
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

Add PMC Global PGGS3 and PGGS4 register defines to Versal and
Versal Gen 2 hardware headers. These registers hold boot index
and boot metadata required for FWU multi-bank update support.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 arch/arm/mach-versal/include/mach/hardware.h  | 3 +++
 arch/arm/mach-versal2/include/mach/hardware.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-versal/include/mach/hardware.h b/arch/arm/mach-versal/include/mach/hardware.h
index b5f80a8e3a9..66eca18998a 100644
--- a/arch/arm/mach-versal/include/mach/hardware.h
+++ b/arch/arm/mach-versal/include/mach/hardware.h
@@ -100,3 +100,6 @@ struct crp_regs {
 #define MIO_PIN_12	0xF1060030
 #define BANK0_OUTPUT	0xF1020040
 #define BANK0_TRI	0xF1060200
+
+#define PMC_GLOBAL_PGGS3_REG	0xF111005C
+#define PMC_GLOBAL_PGGS4_REG	0xF1110060
diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
index 81a0df89357..1bebf20910a 100644
--- a/arch/arm/mach-versal2/include/mach/hardware.h
+++ b/arch/arm/mach-versal2/include/mach/hardware.h
@@ -105,3 +105,6 @@ enum versal2_platform {
 #define PMXC_UFS_CAL_1_OFFSET		0xBE8
 #define PMXC_SRAM_CSR			0x4C
 #define PMXC_TX_RX_CFG_RDY		0x54
+
+#define PMC_GLOBAL_PGGS3_REG	0xF111005C
+#define PMC_GLOBAL_PGGS4_REG	0xF1110060
-- 
2.34.1

