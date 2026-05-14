Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F6FCD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 10:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55DAE8464D;
	Thu, 14 May 2026 12:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZU84cork";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCF1C84671; Thu, 14 May 2026 12:35:21 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B92FD8341A
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 12:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrr7U5j9RA+ZYQD6lt+8QfjUwl9a32dch7+21seCt6TUfhux+qyROlL4Cl+3pZqJmFynpfKaVWqiDBNQPXNpxajlw7/QQ+zynVvSGAQZl1T/0OZLek24UBQyK+ZE79QShesar8C4R28rUQcYpu3MrgzecoesZyOOrhgB88teso/QQd6I395115mryqfx737e0roQ0ufLW0tu7HkXiqc0d6JlLyso2u1FA78nwjKQzT7J4TEpJIHCAajnAbqrYi2m4YXdtZ+dArV2OYWrcNInqhA6ofdPq+D3vajtZMzC1Tp61SpPfIO+vDiV9fy7RBDlQMlfdsnJfOrZaEFE+T77Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG4LZzyrTNmxOY896MbquCaVl7fM8nPRh4erf8Wpk5k=;
 b=Yo86+pL2WCj0CpIFfdqGLXVO/YgNYMtbgA70CwaJFBU2QwOgOjr5v2ky50FpHpMXpACnJchmEWB99qxUT4MVG0FKK1PqKcav9uIPbSkiXtsrB+8IgjyX2KWxi+y0D6cq5+8JhpQY5Ulp7n6hlIOK66fjgQAuDGk4MaGEF7y34RV7zqCRHscIMEhjIJ/483eBmZLjPsmXxEicThse+PrvKPwZgzGjOuR3WpZDcz0K/4nNu0Fe35NdhBS2zqbxe2nN2EhakQ4/FpejJDRnBVffbiX8/oKCerP+BO/3Ia27rmhLQhfU/Qgj5G5p3OYfCtC8fByXl51SxKUNIPHZDfZUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG4LZzyrTNmxOY896MbquCaVl7fM8nPRh4erf8Wpk5k=;
 b=ZU84cork346IAK9J8JOw+kn37P8fP10dVuz6X/njPw2Kcw66HHA+VAmH4MeOlfRab+q6MO01K2FoTYeXmoT3O9HykJ/IDEw/eQteo5k700+OefSZ6RUG+29kWmVQy7JXsI0tkBTFKY/1dT0eUYoGxLdykwtiW22zH5zVL3qsQ3g=
Received: from CH0PR13CA0033.namprd13.prod.outlook.com (2603:10b6:610:b2::8)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 10:35:13 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::87) by CH0PR13CA0033.outlook.office365.com
 (2603:10b6:610:b2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 10:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 10:35:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 14 May
 2026 05:35:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 May
 2026 05:35:08 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 05:35:07 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/7] configs: xilinx: Enable DFU MTD support
Date: Thu, 14 May 2026 15:52:23 +0530
Message-ID: <20260514102601.1759779-7-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514102601.1759779-1-padmarao.begari@amd.com>
References: <20260514102601.1759779-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 05278d1c-5e77-4dab-2b4c-08deb1a47b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: B0fzP0/kOsKq+aXZmtMhY9rQUxjkv4rPe5UJVPYcob83bCD4WEbMPlOEtgfFsBAi4fDDRc7oDguOHCG4udCYzmkEL5MP7WQDrWSlkq+66R2ljxphPUJ8lv5f08MpXPgqYwOkdu77vQNVuS/gACkfYxYsWq1iJmv/hIlKhBuGovu9xYocLURSjSNDjIYILt3XQLIjNL8SrOU5iy6/Dn5JKNfe09ISIXxEp8wFv64eNW1iA/6IHHlcPpPrrcCkyidyCFQgRhwif1APnDiFSFFwBs7Qi44phD6ZJVDPhBU9SEaUisByKIoGDDynVNorS0o0oUxGDRmBJ5BMPWzurKXCO2C+M9gkSgnSE71O9PNvlUwfP8im7wURyAsG/6NEcZ4GWYTH16RmbBj0ch8OW1y008GYQJVu273nL5wIoSOkNgPN/CywMHms7taPjUqTzTNtVxyk3Hqoh8lLzlG3xvcidKeDyIBaDQtRqZJA8ldog8d/FLHtYdiPjPz5PxYLNC9W6sNwQKZqyVymRpLeQAzs+QHMB3n4hxCBeeuUHJJoTYoW4Mq/jjf1s65jHHZt85j2oVCLFlerTokyGB6YTdYqas97hIljkMah95D8w47yDmsYNZPUbz/J+MiItqGXC+qVrPikxvv7kFFvuhPnufqgR2d1j+j0f31dh4qRrEPBdp/+xz7UF7BRbFph0CQHRxrDqq802dtcxdkdETVZtnsjMccgCYCs1mIWSD65sksuq+s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XjMy6MeQ1LYDKcCpd6R25o/Zimkt7WUrfvySLezVd3mk86SominZ5UrYN94skPvPr0BXEmw/uOQUBjdaK6qwf4tkIW+yDjrp8RYwJque4skhgV9NZ7d10YEIkGmMTLtHKIDrCGsxer2nSNQ5ssa8KGgtXh8lRVYFZxaCT2A3duMVOc1VlY+Ti9mcXGGJuMuuipa5zOqHHf6qtJWVi7ng/MitCgDEUYpHKqvQ7WxO0L+8+XikdOxbJk9B46T4RMtaedqSyeQb2gSDjoLmy1V3K2gBpki9WE2wlayp65TMtlWy0012jKchNRzKEr384nfr+jJhY7+8hwHy8PsGGNTndAq0DAyCeXBR+ecDHq1lkIi68gLGqhhS2U+kZPkQTzRzWnGlH/aCuRzR6KgswDiWT/IF7PRjspmjIUiNk9NSPFfb/EACljOjw8XTJnIEbKHs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:35:13.0052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05278d1c-5e77-4dab-2b4c-08deb1a47b0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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

Enable CONFIG_DFU_MTD and CONFIG_DM_MTD to support DFU transfers
over MTD partitions, required for FWU multi-bank update using
NOR flash.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 configs/xilinx_versal_virt_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 7c9b1577875..a94468d9b9b 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -80,6 +80,7 @@ CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
+CONFIG_DFU_MTD=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
@@ -106,6 +107,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
+CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
-- 
2.34.1

