Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518D6CF8577
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 09:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7D70836CE;
	Thu, 20 Nov 2025 10:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P718sgsp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A2FF838FA; Thu, 20 Nov 2025 10:31:42 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC8F82A9E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ja0qZZmgfpGGr6KHAEJFj58ktUo1zci1XoSVSvGkKVOOTGnS96uG0GonM3+4jRP91bgQ/bg6cNLvbg43ofH1P/speSusKbJD88yPB7JBdOxgNByS6jCtujLuALwTvWmol5ghnF0HlBirY60RJ/BWH4LVN+mfN4wfQdtzFV1SdtVuN4Lvd2njEsPIh98D7WparzngHfxaZmr89capoxgV8BJKFSaJs7vcBA2QrFU+K0tct0rcCamp6eUw2uSObwGhLXnWc5uWI8ayc1qsjUj0Fk/MkD7au9nBOnyUyw/uGCSnjXo9cnh2HVnbbLDjFNSqr8MmUOb1wnBXd8MW1MoY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8gydEGvynwyUeWhuu8VU8Jtc6Eh94WsGm+qRio+jM0=;
 b=S/+rmBsr4rDYFND4PRRZ6x27Eh8l2TdbAp+SgKtH3s/xEdd+82ejCGaMfC//REAqTzYEgM4rU8IRk1XCRcP7CaIeM3gGSi6gpdqJlOACWy90jWpLyu8ligsUPXu19SOxHcRGSV4w9DED1+As8ZZ7qxGdshFdOebJ3h+PGtDkUEu5ieWaiRbzokOAuaJk4JqDzhIQI0AMZvR243BaYWaFRFRzjaW9UlQLFeXO6ALitlxdKlaiM/MQZvDiFLhMBGPHrCrLNXkNwNJ+EnYBRl0jpi5LTiXS/RXh6IcT84GXFTNXUDVuwqVTQXN/Np61+p48xObqNkjddi4n+jtfBuf2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8gydEGvynwyUeWhuu8VU8Jtc6Eh94WsGm+qRio+jM0=;
 b=P718sgspyahSniOyaEgEKiBpKkKJPftgr4D3DOCjEX1GAamD3WYML6djXJJVBOD30v2AaUtGgBz2T9D8FDnUiQUlxOEj7gvoh6R9e1h0Os9hym7Le+EtSfvsks/xmkQPxyRO3A5+KN2bKCmUqx990WHllEnwPCwO4ca1+iF9ic8=
Received: from CY5PR19CA0033.namprd19.prod.outlook.com (2603:10b6:930:1a::35)
 by CH3PR10MB7235.namprd10.prod.outlook.com (2603:10b6:610:124::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 09:31:35 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::b) by CY5PR19CA0033.outlook.office365.com
 (2603:10b6:930:1a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 09:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 09:31:35 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 03:31:34 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 03:31:33 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 03:31:33 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AK9VWC23398945;
 Thu, 20 Nov 2025 03:31:33 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 20 Nov 2025 15:01:27 +0530
Subject: [PATCH next] configs: am64x, am65x: add CONFIG_DA8XX_GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251120-gpio_fix-v1-1-50ca8963c7cd@ti.com>
X-B4-Tracking: v=1; b=H4sIAO7fHmkC/x2MWwqAIBAAryL7naD27ioRYbrV/mhohBDePelzh
 mFeiBgII0zshYAPRfKugKwYmFO7AznZwqCEaqVUgh8X+XWnxBvTjVuNQ2+1hZJfAYv+VzM4TDc
 sOX8/3ee2YAAAAA==
X-Change-ID: 20251120-gpio_fix-4c69b3e87dad
To: <u-boot@lists.denx.de>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Judith Mendez <jm@ti.com>, "Santhosh
 Kumar K" <s-k6@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof
 <bb@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Protsenko
 <semen.protsenko@linaro.org>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763631092; l=1322;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=VB5u5vh9btCOo3NZiSmkSminK7DArHMe/Gx3ulIh720=;
 b=kikwQ3DopHqYPgS2UACyhczDMfOi5ZZWwHIMT/oAy/dp61ixei0Ot3unBVIXfC8tIabH7Pk6O
 QXPNijv3lDxDAXU2TpeNol9t9EaEGYmGtAdGpmRXuXPBP7vuZmBD9l8
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CH3PR10MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: cf74acdd-8097-49d1-b1b5-08de28179936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFh1b1lYUXVPZ3RPUExKb1JWdDJEZ0xndDNwYWhKM3Brcmo5UDVQd1J2cS9M?=
 =?utf-8?B?R3VMcVh2WTR3aE1LS2pYM1VkRXhJVnlXNE45Z3RCdmR1MndXN0Z1VGVkTnlq?=
 =?utf-8?B?SXpYVWhTQVVDUEZiNEcwbnlSbm9UMEszcnMrQ0R4RFYza2FMeDRwZUMzRjNs?=
 =?utf-8?B?RXRqS0RVWTJ6eStmQ2gwanl1S3prYU9NMTMzcDNhS1FoRWpEM1pSL0Y1ajRk?=
 =?utf-8?B?KzA2TVVya2ZTdStUZFZzUCtqQ0VGOVZMQUxCTTFIdnllUlM5MG1qY2o0d3Zq?=
 =?utf-8?B?WGVlcmNsQlhQMW1yelJGeGNsYktEczBpRlBMcDR2UnhoeGNtNDVpSkU4djhn?=
 =?utf-8?B?NWxTRXgyZy8vNEVJVkhkUythS3VDamhyalhRTlh0eGxDYzNmdFY4bWg2V0Fz?=
 =?utf-8?B?d1JNV1BYSGh0WFYrZ2N4OWx5SjFqTDNJbWYvSDlEMVV5OC8xZ1hXNDB6OGV3?=
 =?utf-8?B?NW9LS1VZL1QwaG9ZZDY0aDhVTnliSTlzUUQvMUwwbnRJSXppWW5rMkpCb0FS?=
 =?utf-8?B?ZlpUazBJV0Nld25ncnJXemhkS01GQ29lNlBsV3lFSWx1NU9kN0MwRVdtU2RI?=
 =?utf-8?B?NEdrWGJQdFVnOVBwSXlTMXEzMXo0K0Q1SHNjVkNHUldEREU3ZGhaSmI1OTdq?=
 =?utf-8?B?OEJKcC81TmFkWUxCazZHUDNqSGZmUFZXTjBZVVJLT1FiYlg1eExWcE12OHR5?=
 =?utf-8?B?TnJlcW5QZEN4Qm0ycVpCUm1vRkNnUlJYK1htRjRoMFoxbUxRZE1jOVU1KzVv?=
 =?utf-8?B?NTIwUmxTcWttd0g1QmVNOHdEbFM1dE9nS21pRFRLYXBrbzVYNERxNjZ0MUFw?=
 =?utf-8?B?NU9neGlOQVEzYnozSCsxUUhOMDh4S2I5ZmN0bksvL05nVmsvVVIxcXd4bE9G?=
 =?utf-8?B?UUhYNWhLN1c3dGZyT1M5cHpBMmk4VXJUL3FjYTFXV1ZVUU9nWndReDBmdFdr?=
 =?utf-8?B?TS9CUmVBNmVoVWJ0T0taRjV2dzBJd0p5S2NTSmxQNkhyWk5NT0cyS1F6MVk0?=
 =?utf-8?B?bit2U3UwSmdDc2JCMmR4SDJobDNPSGI0bk1kNUE3dVgwTlpOQzFwU2dNcy9Z?=
 =?utf-8?B?bENpYytRdjMwOEdVV09iclFzODdBcW9XSGZOWW1RWnNVbkNjQjhOWFpuVlFV?=
 =?utf-8?B?YWsrRkRMKzRMV3JrcFlkV0h5NzFsZURMV3U5YjVaK0c2L2pGNThDdndBOGRU?=
 =?utf-8?B?ZjdjODI4K1laYitFUDlxWWpoWDNQWW4yUHRHN3ZrWWRXaFlVczczZmluTUpK?=
 =?utf-8?B?eWIzd1JUS1lZNSsydVJLL2xxQUNjZmZqYTE1b2ZCcE0xMWFrbVVjV1RjdEpI?=
 =?utf-8?B?REJHVWlMYjZ4dFk3djZ5USttbStYSXlHTS81QUdjTm1nN3RIUzhCUzFvbnl5?=
 =?utf-8?B?WmpRdm5hTCtLNGxtV2wrbWpNajlKbHB5QU5zaUI2MlhHc0FlTnYxVGprMnZU?=
 =?utf-8?B?dGxDMklhTWRoaEZLNVAyTVlrTEpqYnBYbXIyMVR0azU1MU1MUlIxekhXR2dY?=
 =?utf-8?B?UGJZdEIrY05LVGFkMVBhY01EQU9NdlArZWYwZTQrTHc3UTR2b2NYUkhUVXZX?=
 =?utf-8?B?RHhqcmw2Ly9XcGJLcnpRa3VSMVFzRnBZelNDRFFpSjJWbDhWQjVKUTN3QmZF?=
 =?utf-8?B?RkxtL3NKM0ZHdUFRQ2RjaklPSnZjZkhaK2kxUjVxQnhJMHd4RkRIL2krckNn?=
 =?utf-8?B?UGdFTkpnRjdJc0VJbitqMlB6KzRwa1Bnd2Z3YTVQc3ZIaTJJaXh2RkFGZFl1?=
 =?utf-8?B?V1JIWkJSSVoySEVzVzlJQU1lQ0Ntak9aVSsrSGxtTFRpNWczTmVBZ21VT3NU?=
 =?utf-8?B?cW1RTTY4SHFseWU0QnhnTkVzNEFEUFNkNCtzVXIrUERSNHRlVGdYR2pOUVFw?=
 =?utf-8?B?L1pUZC9nNENjOVlLYmp3Wm5lQ1k3S0Z6MExkb2NZVWtLUTJ3dFhieU1rdnZC?=
 =?utf-8?B?NG9taThUcDFEQXRaRnFTT2RMOGI1UFZjdk5qd3cyTkFqaVFhM3h4clBEcVY5?=
 =?utf-8?B?a2Q3czFGdXh5MlBhN1phUDNkczNXZGllN3RtallMbzZCSXVlMkxSbWpFRGx5?=
 =?utf-8?B?aDkxTEttY2ZxZFBZK1B1bHRrMit1SnlISitjQ01jeE1GejhZWnNuN1Q0YldY?=
 =?utf-8?Q?ubsU=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 09:31:35.2736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf74acdd-8097-49d1-b1b5-08de28179936
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7235
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

The DA8xx GPIO driver was not being built as part of the A53 U-Boot
image on AM64x and AM65x. This meant only i2c GPIO expanders were
accessible to the users from the U-Boot prompt.

This patch fixes it by setting CONFIG_DA8XX_GPIO.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 configs/am64x_evm_a53_defconfig | 1 +
 configs/am65x_evm_a53_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index ae261f2fa01..2a678b8513c 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -200,5 +200,6 @@ CONFIG_USB_FUNCTION_MASS_STORAGE=y
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_EFI_SET_TIME=y
+CONFIG_DA8XX_GPIO=y
 
 #include <configs/k3_efi_capsule.config>
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index d1fe27702cb..d2da1818c70 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -166,3 +166,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6162
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_DFU=y
 CONFIG_PHANDLE_CHECK_SEQ=y
+CONFIG_DA8XX_GPIO=y

---
base-commit: b8872deb4450b09586e28550c23d33a71084d94f
change-id: 20251120-gpio_fix-4c69b3e87dad

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

