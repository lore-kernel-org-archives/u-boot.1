Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A1AFD7F9C
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 11:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2136B83EC9;
	Fri, 27 Feb 2026 12:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GplRcpta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D88083E81; Fri, 27 Feb 2026 12:57:40 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D7F283AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 12:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bf0VRHdYPR/iHHXK+ioWa4+e2qoRr+kxvi2TQMVfXGrd5t7ifiRly+sH+TQsH7q7RpD+4Gj6v3untTpspKktka4+XI3R2KnC0HRIB2a/HUenwMzrh4C3UYRgKs+iSl74PULRsMfARDpoq5xTBQFOvzDb/BrGDUuuslCA0XUA1lZU0xNq+gQ1TT/R58XG+kQX0PCAjoAWeZXo++fYsaNUb9JNo0HOCjSS8P/+hO4CLMEdmFhzbVZ155oQyUi8Zl23iaPHkaM9sbf79qIiPbm7KMQQqoWClWR+fg1RhhKSgjqUE7zPwmWxQcmcad3k9aSLDXP0/DIDUnruJn9zGp7eGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O21IH60hmp5jrEhjnijKYolwlRKV9etSqf+y6jgUo20=;
 b=mwy3Z7PvNDk+AknghFigl3M8gadu/ar7O5jZ9BH/A2BkyFLRqUDAMpSNuA7b1UH+xM2p2yR58KSLUdFwRXHE3KlUDzcONvU/kS78AEV9mBmQFtgYJ7jHCW/RXAXLRw1rmdWoSlCN7M2A7v48+FiiKjGrYicxs9AONoXf9jDTg+oytMumm2B9ZYMvg555sRyqPyQ4NEhS+jOEpSXnSKrKQF7npK6mwjG87Y6haeEzFqhOP7UiGxP1ldp1he0yOrt3RgJ7ydA0h0qrmu/2xFpvRwjTZNPaZFwjCd9yTy8LLSLQkS1KrPQq4CqC26bfDeMrYQ1l/prCfIH7EYpcPsZC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O21IH60hmp5jrEhjnijKYolwlRKV9etSqf+y6jgUo20=;
 b=GplRcptaBmAMHLsdAMS4ssyYjFye6ReZIfmhT0vFAQDx1ldqLe3y7DjWjiIuSk6ZBafd00gKPHUCrd3y3Jh99gZHd+Yz1n0Jajkj2huoq72gsqVZwercz3Xswd7gWcroBLiKk3DjXZs44we7UIkfFaYaUar1jblMAe7XL0lCS4U=
Received: from BYAPR07CA0085.namprd07.prod.outlook.com (2603:10b6:a03:12b::26)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 11:57:35 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::ae) by BYAPR07CA0085.outlook.office365.com
 (2603:10b6:a03:12b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 11:57:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 11:57:33 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:31 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:31 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 05:57:31 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RBvApa3689228;
 Fri, 27 Feb 2026 05:57:26 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <anshuld@ti.com>,
 <d-gole@ti.com>, <n-francis@ti.com>, <bb@ti.com>, <jm@ti.com>, <s-k6@ti.com>, 
 <afd@ti.com>, <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <a-dutta@ti.com>, <neil.armstrong@linaro.org>, <semen.protsenko@linaro.org>,
 <peng.fan@nxp.com>, <george.mccollister@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 3/6] configs: {am69_sk,
 j784s4_evm}_a72_defconfig: enable PCIe Root-Complex mode
Date: Fri, 27 Feb 2026 17:28:31 +0530
Message-ID: <20260227115841.333073-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260227115841.333073-1-s-vadapalli@ti.com>
References: <20260227115841.333073-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: eca2b9d9-7121-4856-e59d-08de75f7644f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|34020700016|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: 39Ly9/MKbq8Pj83vLH42j68ASJpzb5HoyLaJWRiSSH6ZG55WjavbqicI3XrZewaKwgTfF261ZO43a7K3CIQae4IzFXtgTCIW9Q1shH9w0ISdwZy8X/IoHy5hBTea4LBnHV3bQBvwzZLr2OJhokeplDHCt/bSCJprQJJIhqftNSA60DqR0pL9pog+Vu8fimT158VJ8lSnpLKyF1ciEEJv/WDVN9hh/djXRqJ+FRR0DMVgLFHfA1L+/tekYN58gzvHsy40gud3SAxm4QHR4fnK8EUamA+U94gO1gQUf8cc07LRHtfnboq1pg5HqDwwanXTxftHW+lkTjTpZu4I2tZG42ODh4PLyAz4Y906DVLEJAongTDEQftR99FBakVSD/q5m3CIRs5L4HEReTOMcwTMImXz6hub06zT2DildP32yyRyalYNBPHmfO1/wS7bjSbuOCNEktxnTKSuLViw8kuhju5Gda5t+pfbQlAsG7BDphUNGqpnObTS3F4P2DDyOjpkQlST1pM3kUxm3XS3weFmMcTZMl9ybsxbHOVVMhMlE+p/Mw+lRGLLCY8kk6y8OcNF5FsRuyySdcbqK77LAC4jCBl8mtmQzpSf9QEK7laNGvQRbfbtvurBE7icmQTAXYLV1bBUiIW6x4afbCDoncVGCKze8d0R3nQUueM2IRXVQg+v7w9yzUWwMdHQb8KBLgJUWKT8c5WlwtvevEjWukL0FE9J/j2uUlDZ5vfeNZ9VOW0zENz/JLNPsFyTKHQgxJ5Cbrv/387zFvsKjf/IYrgHXHYrZtp+5LLR3nzkFXTbKsEPmRLYBGL0knWcUexltY4glwcGmPkvKfy5sSenf78J/siNWqLuqb3qUPtzXggeDyQ=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(34020700016)(82310400026)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e6SKrFmrOeY7btHDap4WXteSiDVXwqcDc+2zIzE6u/68igk+UgFVtGRC9izfx5FlHlL8Gg70r3D1omqShMteU6ogGwX50ebhg5if863n/m0eyLUnOqTkZJW0hyZQoYn+C/eppwZvdZz+WcgiDIzrO2nwIyj8z5I2qa3TNy3MYpsBxHFQWTqhf4RTLvMnikPZYOSqk3RAbABqSNtUZel+GNf/726alhkYMtRqUWuyX15CB1d5tgDGARIem79GT+mL0qy3QoEuW7aflXzUeTUhEo80q+hg8nPRyn5oRVESN1smqcQoINnGw+NfSkPUm4mOi2J/36eqwKP8VTw1/WVcO9PV7dr1d7SdPmkde6MQ4/3Qj2fh6Ptc3W3Ka+teGaOqS5xr50jq3LGKfsBVvhCc0UDqWW+ep0ENuFmiC80+IWUEJyTX9p2Ey/hllNQIBVXJ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 11:57:33.2162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca2b9d9-7121-4856-e59d-08de75f7644f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
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

The PCIe Controllers on the J784S4 and AM69 SoCs support Root-Complex
mode of operation. PCIe0 instance of PCIe on both of the SoCs is brought
out on the Starter-Kit (AM69) and EVM (J784S4) boards. Hence, enable
the configs required for Root-Complex mode of operation.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/j784s4_evm_a72_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index f440b18c6fc..1d2043aeba0 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -28,6 +28,8 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
+CONFIG_SYS_PCI_64BIT=y
+CONFIG_PCI=y
 CONFIG_EFI_SET_TIME=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
@@ -56,6 +58,7 @@ CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_OF_CONTROL=y
@@ -123,6 +126,9 @@ CONFIG_MUX_MMIO=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_NVME_PCI=y
+CONFIG_PCI_CONFIG_HOST_BRIDGE=y
+CONFIG_PCIE_CDNS_TI=y
 CONFIG_PCI_ENDPOINT=y
 CONFIG_PCIE_CDNS_TI_EP=y
 CONFIG_PHY=y
-- 
2.51.1

