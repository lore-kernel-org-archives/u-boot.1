Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F511FD3758
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 13:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8645183F2E;
	Wed, 25 Feb 2026 14:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vYtqz6gH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A996883AA9; Wed, 25 Feb 2026 12:25:41 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 001B882A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 12:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-tripathi1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uT9GMA6zimxGP5JeiBAOXQw5FAOLIAu8bdPNY2jPK/6AlYIejNM6rf8uUTgDmkyUz6/Pio1Asee2qRU1jm7MllcMdrRZAIxpQeltm8G2Sc+ReqNZXS+yhJzaukZi56KOaycJFaW0sH47w6/0UimtDaF01HNqknBjSK+RJCYwFSvjN9+K3W4SuY22iCtRPPqTkqfEiL+r5cv5tB87ejiP2cSldSsL2M4hl813xNLdUdRO6LnsdxmgoECFxTcX3X2H1E897OF0Vvw1NnhAax+hv7RwqWQIPlKWJVWJhQTLI/nHk2aSIZrSi1Mh7qNN9/Uvgs1708I9EoHuJfFApt+acg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKo/6bGtBvPzYWqf+DpqHySN4uFOhT7ZVutDvTAh6QI=;
 b=FSjFX/AankbA/NwzsXBQKLvWlz5DydNDToh1L7lCdAS9fWgHshWRmtInwy8ML5PjPSAIMhWZKemHwkH6YGVaKmyDOTaBD3smKNPcUwYIlmCh23KH6qt6Cpk/cMJo+eJANY+cSCPFxegHneVc5ysJeGjfPiq6Eufzv+mAxibiPVv3IimBkRerBwARfYZT/BKeFkwyHgkFedkaPMG0HwkTi03dwmNN6s0sfiVBIbb31d0wAZUWCMV4j1nxIJ4dtPiiDCR24sCZnxpzPkpOKc/9Lp63XihtR6TyIrHqcKe1VU2rp5ks+ZPY6DJldETnJk/1tut1qtfm1qmhhBJMD9MtbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKo/6bGtBvPzYWqf+DpqHySN4uFOhT7ZVutDvTAh6QI=;
 b=vYtqz6gHybKXK4ksVSpasj3MRLEUPe1inM8woHkzShNkqfiW3K/nkOw3qIsHDaIoes0ENeuyNV3B/jfw4L7SwB7UeGYX7LkI4ZNjuxMM8E+JXClZ0buRby973KD+WhFjM6d1STo18sBRuoq06uj77ryKkFZkOC/W34gjqppbHyQ=
Received: from MN0P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::7)
 by MN6PR10MB7492.namprd10.prod.outlook.com (2603:10b6:208:471::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 11:25:35 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::f2) by MN0P223CA0009.outlook.office365.com
 (2603:10b6:208:52b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Wed,
 25 Feb 2026 11:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 11:25:34 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 05:25:34 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 05:25:34 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 05:25:34 -0600
Received: from HP-Z2-Tower-G9.dhcp.ti.com (hp-z2-tower-g9.dhcp.ti.com
 [10.24.68.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PBPUGt360534;
 Wed, 25 Feb 2026 05:25:30 -0600
From: Shiva Tripathi <s-tripathi1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <k-malarvizhi@ti.com>, <afd@ti.com>,
 <anshuld@ti.com>, <s-tripathi1@ti.com>
Subject: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
Date: Wed, 25 Feb 2026 16:54:38 +0530
Message-ID: <20260225112438.1035185-1-s-tripathi1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|MN6PR10MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6551b1-64ba-4bdf-58f6-08de7460980b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|34070700014|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: xJC33Wam/EnOVsSWwK6Jxyrs7yN3RM05ie5sKXvQtKeUwXdOpqEQbDlrn2jq4HjEKlZBWsdRh5kzSBYGAXasIP5LdwL+cxBh1cwkXp+W5UC7EqK3XBTC8TO4nGLM9a7ntqUdj06QhwjZoX8PCEDRHPCO8oiLkIMYUhT/trWxtyggWzut50lYomeYssIdtXIiZrtcqgKciG8XYJ7DKOil9Yf4a5MQEQTYreUHFPdSxq4U6CSpLFu7JuX2ts7Ysg6Is2aXCPdmyWixQb1o8DWnzjm7D4jpJAxTxbSj6vhWRJFcNp8ARem9KeTzcWeB6R5l5io/OO0LYbSWGROzUy6MbanrbcXVZZN0S4m7B3QQnErecly2C4uPk9r9lXgzk8g7z7uSA5E+p1Hek533p5xfac3H5CktC/HtC8F2psT9kvjrFUQpVbhCqKF8SFtRG363GYtj7LDGoTopNDzVk4UOGcJRvjsXbndM7w4M/hTiV0WCs0099I/uV5X/fysqz288mZYGpEvAc9+xDg+3/Igg5ASsqvpsh0hquKzdMo4aKtn53mLMGTUfXiPEz8WK68rYVqSgul4Q1Cb5S9+F/V+D97k1E12hVlYH3kjmGtQ12US/BwOeuLJdp3qqH85zGh3W/P1mvdsYU/lffrJhTvpd4I3XszTNS/2E27FOPagkJwqtN9WPBbLqlMnMS7gcCWTBBt/1/asmoa8t265FbM1E7M1aUCdIzrMYCECGeKE5wTqAOdhcFL3nRKRpFKA21HF+jsnhMnM+p2p/l2+JRKMSXx8s9a2R/R2dsk7nK7u88aA3Z5izKeOGWBJMiQ8l+79pNE1Xq5EP/Q4MH33a9pxbTg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(34070700014)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w5v3HL/0OT5wj59DBeYQeJRF10HdoyEBl9X97c/7pe8QYnkGluRHNEfu+18UqzeKHsxl68TrLdk2KhmRz2DI0YyB0N2bw9mGfTvusBQ0kRj8WqxhoTwVIUk1TCJBvxKIVc1rRs1azx5dWLLUcZdeX1x98mg9nEOddBwejovMOLTE/RvijXyzrUqoKp2jQp59uVypj+/NnyugafikyaCmuxoDIMRitfFCnXP74WSL4MjAMuFYxDv5qRUZZ/zbcyjcXr3vs+PpqGpe8nHdhroupReTG7PqeMhrYiHmlq8cWVjWklUK/SiURGSzp4dkISjZAO7JiAF6+DYY9+PLoTG1HLbb8ilD5E71qnVTCBuukzB4pMSsqkdzirUocYxAb3etVZbPEwogXK6bnVjaBBtatDc6tdI7h+rg4SL54s6GhomRKnCFJwkuk1flOIHYMixf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:25:34.8562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6551b1-64ba-4bdf-58f6-08de7460980b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7492
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:20:05 +0100
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

Enable firmware TPM (fTPM) support via OP-TEE for K3 platforms with
MMC hardware. This provides TPM 2.0 functionality through
Microsoft's fTPM Trusted Application running in OP-TEE secure world,
using eMMC RPMB as persistent storage.

fTPM support in U-Boot provides the foundation for measured boot
and disk encryption use cases.

The ARM64 condition ensures these apply only to A53/A72 cores and the
MMC condition ensures fTPM is enabled only on platforms with eMMC
hardware support.

Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
---
Changes in v2:
- Moved fTPM enablement from per-board defconfig files to common Kconfig
- Added configs to ARCH_K3 (arch/arm/Kconfig) to enable for all K3 platforms
- Added command configs to TI_COMMON_CMD_OPTIONS (board/ti/common/Kconfig)
- Added MMC dependency to address concern about boards without eMMC hardware
- Link to v1: https://lore.kernel.org/all/20260223091314.586968-1-s-tripathi1@ti.com/

---
 arch/arm/Kconfig        | 3 +++
 board/ti/common/Kconfig | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5508fce796a..eb83b5c35f1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -834,6 +834,9 @@ config ARCH_K3
 	imply DM_RNG if ARM64
 	imply TEE if ARM64
 	imply OPTEE if ARM64
+	imply TPM if ARM64 && MMC
+	imply TPM2_FTPM_TEE if ARM64 && MMC
+	imply SUPPORT_EMMC_RPMB if ARM64 && MMC
 
 config ARCH_OMAP2PLUS
 	bool "TI OMAP2+"
diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index 409454813f3..149909093b3 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -61,4 +61,6 @@ config TI_COMMON_CMD_OPTIONS
 	imply CMD_SPL
 	imply CMD_TIME
 	imply CMD_USB if USB
+	imply CMD_TPM if TPM
+	imply CMD_OPTEE_RPMB if OPTEE && SUPPORT_EMMC_RPMB
 
-- 
2.34.1

