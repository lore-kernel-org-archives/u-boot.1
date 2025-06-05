Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF084C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 06:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33BFE8091A;
	Thu,  5 Jun 2025 08:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hdBoBq85";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C1B281E25; Thu,  5 Jun 2025 08:17:42 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC548003E
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 08:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8GTqCNj5O1eqlWV28hZi52f9KOd/BGKsw1/PGekucdH6Iido6VFR6lGGhbBJz8J/D7CodFLLucIcs5+LAzcgX84xIbZhtqL487S6PeMyv7gV9PwVxgIN2r4BANONUpsYLTBw17WMCM1rgBgROrP+DNk9bdW3dGMoD37WitQkNudE2lqgE+8Cppd+5tiOqrGXlbJ/N2wQdN6ra6Pbrg9TuQ+gtI8hJ3QGfl7ceN4+YvsSx1TVY7ItbiZr/wNgVEpoK3dSYqZIYVB7/rco/aUpZu8/NjxoyvC9UTXKGaQ+iDg9JNEYO5GcibMsNG8qkmozdspayZkuZvHhgTTqP8P/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FJ4Y38uQE6AIOSjXei3PMLHqLPh94ordZWTQeEViSg=;
 b=QTmKnSZtU0Ftewlf3XmiXhXlxnPmtCklX7sKTFfKakVUA02fh2jEyKnkGVm1fbQlqxnxCt1MB2yg3nxu/2frjHmtPxXvyvJqbl9GAjSYmU99Qg8WyuIgiTeLyGYZ3g4CAIuXGbQcyN4H5jSwgXQqykTOOadslnUIOSb4tQQO1VruHaBE0646rE3I510maYOWNa8IUwPih7ItHpwZS/kLS5sckwUHO6lX94ZwNhOWFf9TsrgcgcLhbPInBWe2eJW/ZqZS7PY1bYmO+2LmIBRz9nihK0OBvP/N7G3xwMG4Yo8VHowa+rR1CzLirJW6yuJ0W9M7yP7TLhCOjIw+ESaAQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FJ4Y38uQE6AIOSjXei3PMLHqLPh94ordZWTQeEViSg=;
 b=hdBoBq85jMdFxFl4D2swbr4kJKdTkbjI/Zzguz5vnxND173wVwY7kyxFsICnvDu8cB0F0LJJqAwjDBtDw2iqrItNPLt0UJzdS7uVBp1/jj+wM0jiupHrMUNgXOPIifvDvm32xvce+UqJFqAfwyZFDP7HMaxabGU2wb91EdhdmI0=
Received: from BL0PR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:91::28)
 by BN3PR12MB9594.namprd12.prod.outlook.com (2603:10b6:408:2cb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 06:17:35 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:208:91:cafe::ef) by BL0PR05CA0018.outlook.office365.com
 (2603:10b6:208:91::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Thu, 5
 Jun 2025 06:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 06:17:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Jun
 2025 01:17:30 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Jun 2025 01:17:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Casey Connolly <casey.connolly@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Kongyang Liu <seashell11234455@gmail.com>,
 "Leo Yu-Chi Liang" <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Yao Zi
 <ziyao@disroot.org>
Subject: [PATCH v2] clk: versal: Fix clock driver dependency
Date: Thu, 5 Jun 2025 08:17:17 +0200
Message-ID: <bd18a4ce3e65411bb956636d4a2ef4b5fbe8b9e1.1749104235.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1879; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=HMFk3959oH/Ugb/hiMONh34/+YZvOTpz9Mv9eSrw56Q=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ4muXx63iI35vS9+9Ng0BQ44uCmX1XHAqSJJ7YpbB6h
 XX9NjLsKGFhEONgkBVTZJnOpOOw5tu1pWLLI/Nh5rAygQxh4OIUgIkYMzEyPEsqmZHocHpu3KuM
 LaX1J2ZMXBN1bnv1hVetPW3aAb8MZzD86Dlybb3wSQbzv8qmGzJWZmzQf597xOyyj+CSWUWWvW0
 MAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|BN3PR12MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: 53832b5d-d067-4f2d-7f41-08dda3f8a874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xnUlVOm/t6FGOLaIMuylJc0L+zVxxEy0WtwDsv2Pv15HBPXMktaCdlRA3XHh?=
 =?us-ascii?Q?B5MVU5UYAZNcic7y3QqdtWHNKV/goqr0eIhDx56gdLanjoA9bwosj7MsTs5E?=
 =?us-ascii?Q?QDh0yL9VeF+BEgUxeJiTBQay+SAkYwIuYXXc1OtwoMq7TvkHwHuizodUe7vB?=
 =?us-ascii?Q?xbDnU7EUqxxIATXDXOlNTBcUVyNLD2/DTfcBX9P377li5z0ciG2yarcIEho4?=
 =?us-ascii?Q?1xbnIKU0A5BqSnzIe8aI6dxlzeijuAh7n+/zaDnX5f+UHcNM3OJajf2ATnjR?=
 =?us-ascii?Q?J6zUhGNG5SCTR4HMv2mZMd10QfI1z6D3VP31czQOr0rVlN384UgSO9000aD0?=
 =?us-ascii?Q?Ulo977NauvSat8XIrjl5rE+g5B8A3Yd+8A4F57iEX9Y04tsxCjksWrj/lSpX?=
 =?us-ascii?Q?dZHasCcVCpSVyAVk2oLrX5PU12xMRA/b6yPscUwQpbkCdiEH84M9mqJDTdCF?=
 =?us-ascii?Q?7WTJNJB/aR2apiIbT0uHSuTVF/6lHugEld3v/72kr7injTFa6D06Pmq7tVj8?=
 =?us-ascii?Q?THvUwe1i4VrbyOaoe43T2yknWmhS+wghTECjIjhDqaP+Waa9XUCiaKCesQ2j?=
 =?us-ascii?Q?+5gKSkXncajJhc8GdNheUlfOchSa7P5J50VZ6N/m5bSzn03j78eor+JBjSZC?=
 =?us-ascii?Q?JKmSZAUD0EC/swvITlGbQb4AVNDutmeUOPNOBkD3l/Qgy4SAkncEQmPQD7Up?=
 =?us-ascii?Q?8981HShzzSb2rNnG1m1QLtWuWsz3q2R1Hf3PLfypNvwxdBQ8rePvpk4GCI8p?=
 =?us-ascii?Q?eO8xVimwhPI1HzK84FH/NuxuGIhrKQ7j0a1B+iYRTCq6ikPgvOMkvoNmu50M?=
 =?us-ascii?Q?7qCtnnihmbl3vz1EzQTY/zuBD3sjPZEjXdAbYDdrCUWi2Zo6Z0CPYn+QfPol?=
 =?us-ascii?Q?OkeWv70VZIS8VhrctIfw9GJjyAXuyLD36btZuhkpZnkQynKhybxuBJw+ZGo9?=
 =?us-ascii?Q?ORFnyi5cC4unm9b4WkgXYJElBFXEjhJBi+QvOrz3XAHIkl4/BM2YF1vemqBv?=
 =?us-ascii?Q?m+opLyjuRdahGkqCQroB8DysfVREybns0Pl+eG9WnUZP5NFrZ/Pd3kqZ7T9A?=
 =?us-ascii?Q?QtnX/G1qNxL8cfjGIVLvp51BsU3Dg/nFq1zkI3DXbObROBqd/P4wGso7Nz0k?=
 =?us-ascii?Q?lToDhBGBmrQqhp+FwI+H4YiNO5x9ZjqQguRrci/6JsV/pxb5zLwJN9/KnaU+?=
 =?us-ascii?Q?KME4H2sxLjApx+CQd0jyIDq5z/8YkyY9RCqDN4ipUX/YymzBOZRr/5cLN25T?=
 =?us-ascii?Q?umM1Yyw2ovmY0rO6g80pWCglNihGz7hyrkBcSHv4OTRuTE8NUeFjuydQ55nk?=
 =?us-ascii?Q?0dlrcLCIgXQ4s8ZkzxGt0OSz4/ueXnpjtERmYG4YfsB59POkYWBQJLpjRUi0?=
 =?us-ascii?Q?tRlm16Kr/h727vp2AkNPoDABapbo0LsFehqTYOzPKevE3nAtnUH3HguBbSBu?=
 =?us-ascii?Q?hpkev+OJKv1tO56oxLhbsrIzCpz5FJPHA+wBoNi9m5pg6OOmf0h0bDnb9k6B?=
 =?us-ascii?Q?U/dB07znX9Bs+9C6REeeoqQWWXamCHMAyB6g?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 06:17:32.9478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53832b5d-d067-4f2d-7f41-08dda3f8a874
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9594
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

Driver fully depends on firmware driver to be present that's why change
imply to depends on to cover it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Also enable firmware node for versal platforms

 configs/xilinx_versal_net_virt_defconfig | 1 +
 configs/xilinx_versal_virt_defconfig     | 1 +
 drivers/clk/Kconfig                      | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index a82ccdc9a0c6..3f2bcd954d24 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -73,6 +73,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_RAM=y
+CONFIG_ZYNQMP_FIRMWARE=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_VERSALPL=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index ba4519ce3037..1c44e4010beb 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -81,6 +81,7 @@ CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
+CONFIG_ZYNQMP_FIRMWARE=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_VERSALPL=y
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 19aa2ffa5396..d4dff571412e 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -214,7 +214,7 @@ config CLK_VERSACLOCK
 config CLK_VERSAL
 	bool "Enable clock driver support for Versal"
 	depends on (ARCH_VERSAL || ARCH_VERSAL_NET)
-	imply ZYNQMP_FIRMWARE
+	depends on ZYNQMP_FIRMWARE
 	help
 	  This clock driver adds support for clock realted settings for
 	  Versal platform.
-- 
2.43.0

base-commit: 77b053502f396e83f6a0ea38d747d6836dc501f0
branch: debian-sent3
