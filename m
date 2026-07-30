Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586CDC54FDF
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 09:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C072A80F41;
	Thu, 30 Jul 2026 09:48:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VW30k3Cpe2-j; Thu, 30 Jul 2026 09:48:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A847E80EF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785404926;
	bh=EWb2e6c/bfsy8XJxivvmdXjo83Vi7GqAmDTqi8zFLw0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mNFlgGRKumlPymwFSHo6CJYEr33ZbZY1KIpEnFhKV53dnlXlnfDRkhEY3IMv0wmIp
	 n5oBlFC5Rl7HduuMYzJRwTbGr6V35oINH5LAuFjTxShJOoEN7c27Kx7yrTSryNmXq+
	 Q843svHHDp5GAsyhoeNpgbNPnTO6rY1Pxu7M36hF1xmWubu4Sap940P/VKJCrU2J6S
	 jKblAgKx98KQrL76SG6DcQmkDfvUWgY+lwgqBZXpcsVBg74SG/2ZEGnYVKUNCUK36U
	 obrBkm9Ap4T4nCdEccuHsTMOKI/pIQuDj8/NtRXboBVXYinb+PocXWWFqjYYMFgm4E
	 pBQ9egc8URLug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A847E80EF7;
	Thu, 30 Jul 2026 09:48:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E02C642D
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1DBC80ED2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wfWgPCuUyCbp for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 09:48:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 277DE80ECD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 277DE80ECD
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 277DE80ECD
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hutd6Tso6o3/vbpqAhNmwRBVRJdEjK3dqkFF2MMoZF5OMS7G8NEnvmVAMgwKKvwCNWNK3kXyUzDIbHLwJj48fA6AUtqhVlql8V6h16f2Y1wN1d6JInNUb89taiTXR7tQIwDm5FBeUC1bajT4LDlVXqZqDUkRd8hJEDLtD1IoPQcCxRsB9JzEyLu42aRs1qo3/yrYfTBp5f7nM1OcBNe0ACy1pNpjvsC4Ft64vwgJ5z//4ALATbQGXmF7bMPvmL1w9YiwJSHoraXMoHfdFf69PG8BF8kLj0xaih/u5KEvnPcSFzfw/4TyEtiQ8XpIhdYe1PSLnpLZ4guOaZ1xlcdE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWb2e6c/bfsy8XJxivvmdXjo83Vi7GqAmDTqi8zFLw0=;
 b=Wlikr8e+riAYf/byE7TAlMSxkEjem/hKUQbQpaS0iLUObKxCN9kYzIxSmin2ggdHGpvjtbq1Fw0Z1wnDwJ81+xvjvjsdJigH5TTZkZnojDodJs4gdqRsEEItFunsv3iI28342PR/cydteh1q0ROpS4fbn6sF0NzL9zvewyO1vaDl9+dAH7/inWOG6jwuC3KECcZBwwGlFh6DysRSJTbWC8ka2Gni52ksCD9lEaXsPEhyhSgPLm5pEoNhEivJxL10KcPyvVJuele8dfvXPrzKDYU9iDgebMcHBAN8EoYL6dmlhZ1fBjmX+zA+R7qSjnPMer5Li1xIauoYbCKLfNIi1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from PH2PEPF0000384F.namprd17.prod.outlook.com (2603:10b6:518:1::71)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 09:48:36 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2a01:111:f403:f90c::) by PH2PEPF0000384F.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 09:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 09:48:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 04:48:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 02:48:33 -0700
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 30 Jul 2026 04:48:32 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 2/3] test: sandbox: enable GPIO_DELAY
Date: Thu, 30 Jul 2026 15:18:16 +0530
Message-ID: <20260730094817.1937340-3-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730094817.1937340-1-pranav.sanwal@amd.com>
References: <20260730094817.1937340-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 6521246c-81a9-48a4-6e22-08deee1fb97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: TJq3Vv1HrL525K55jWuuvSn40V3zCmKNerpPZ32a94X+9TlxpcQeE8rHY4k03xw7Kxmba5fPS2uOVYAeVCqjxt7imBEG7/4sDkJgBECtvh3oJNWEgEbk1bvEaEwbx/8h69Ib27Haz1jhvnp6hMBbZX3u+i3PLiYJO8svrKXQM8Uh0pu0rtUCCWlR1XJl0KGqq4xcduNImLrVvYKSedw0YXikQVMrt6tw/mlBC2TPI05DFFGc6XwqVd3X5/3cwVoVz4ROBV44TkM8GJvix6cyE502XOzQ0YEK3BqRucknA5KbC7vdS334W9viyAPtlT34VSKVH17ryUDskP/XDK3x9cPh2FTUo1yr70Ziep5E77aw6jhj7EnCl4S8Ku6CWziqd4vjulcM4swn6cruevE+tV8uHhFZebM/H2S5IovCog2TVhQqitgvPqM/qyFGEuolG+GVz6X/B34RkaEj5ugTMzTyyDGGuF0iFXWcdeBh9Lt505A43iKdg3me1VBiQivjkbUbLLPxlCHBfC9tCHACykekdbXtIHrySGwQLqKmBIgbH080UCBveDpGGL48/76wLE9izHIVnL6LVY9D22T0X3Xkz+asE/weBCysJJZrnpGXMrYxfyA7Rbj59aHHgbu9M6ZLSbswK1UcrU27Z1pHStA9RldOb0fVAnGroK1PdUWQ116PxwSWgnolSsrlIJiEMxODSIDoPKiC8zNRZGOzIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uEyQzNcLuKL8bqCEgfpNYA3mwv40e6Gsvvgu921EkxEcSm7d9kZIQcoEc6AP5z5/CbLoFSo6dZM+EQeB0D4ndbfPKOiCX1Jfoc7kS6S+qimbFtIJoZxUL64vhFqdsha1x74erWbCEgpG3fDH/dsKSjZg61hQkIT2/wbdhf0U3EAofb2Hvl6MY09OAApKAZ2BbLj3eoZhXm0ekdPDZ42kmDZDEVAJ5NnxtqdtrOyQmaT5HWkPB16QkkUQrPTOgbH7Lvn0db/exKsE8DCZNOAJT9c13NtzSYsduvItkJg0zZqhviJPsIXBiX8QrpA00g3Tk9wgvhHydWqFqr1u5TV2/tcevojhJtKYoC4mUd7Af59TvgBBaCHMvxFZrkafzZpGqRvqNGzt6ggeOBvTbwbFEyLjpMsfwSO59RY8qDyXNip76ylLQV3wfhzqBY0tWISZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 09:48:35.5762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6521246c-81a9-48a4-6e22-08deee1fb97a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWb2e6c/bfsy8XJxivvmdXjo83Vi7GqAmDTqi8zFLw0=;
 b=i1btfGbHh9KiOBnUzCevWZqgVNvKh/NcJFn3i268rj6PNGNq+gpaXEA483x5TRo/pwZGh+9BUscot9gPnRm3XxbZKDNzzcrG2C/9lwwdelbWHuc93R1LRAWTYfJxev287coweBzFy4n/3ZNTpPNKlU0kcvaNo5sKlDVx4amSO08=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=i1btfGbH
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable CONFIG_GPIO_DELAY on sandbox and sandbox64 so the gpio-delay
driver gets sandbox coverage, and add a gpio-delay-test node wrapping
two real GPIO lines (gpio_a 9 and 18), along with test6-gpios and
test7-gpios consumer properties for use by an upcoming test.

Verified the existing sandbox test suite (ut dm, pytest) still passes
unchanged with the driver enabled and the new node present.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 arch/sandbox/dts/test.dts   | 10 ++++++++++
 configs/sandbox64_defconfig |  1 +
 configs/sandbox_defconfig   |  1 +
 3 files changed, 12 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index a2c739a2044..7c2c9ed5103 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -331,6 +331,9 @@
 			<&gpio_c 7 (GPIO_ACTIVE_LOW|GPIO_OUT|GPIO_OPEN_SOURCE)>;
 		test4-gpios = <&gpio_a 14>, <&gpio_b 4 1 3 2 1>;
 		test5-gpios = <&gpio_a 19>;
+		test6-gpios = <&gpio_delay 0 10 20>, <&gpio_delay 1 30 40>,
+			      <&gpio_delay 0 50 60>;
+		test7-gpios = <&gpio_delay 5 10 20>;
 
 		bool-value;
 		int8-value = /bits/ 8 <0x12>;
@@ -860,6 +863,13 @@
 			gpio-bank-name = "c";
 			sandbox,gpio-count = <10>;
 		};
+
+		gpio_delay: gpio-delay-test {
+			compatible = "gpio-delay";
+			gpio-controller;
+			#gpio-cells = <3>;
+			gpios = <&gpio_a 9>, <&gpio_a 18>;
+		};
 	};
 
 	i2c@0 {
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index d3fe64c5a83..2b512a599e3 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -144,6 +144,7 @@ CONFIG_DM_DEMO_SHAPE=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_ARM_FFA_TRANSPORT=y
+CONFIG_GPIO_DELAY=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_QCOM_PMIC_GPIO=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 2055321025e..9deeab003c9 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -214,6 +214,7 @@ CONFIG_SYS_FPGA_CHECK_BUSY=y
 CONFIG_SYS_FPGA_CHECK_CTRLC=y
 CONFIG_DM_FPGA=y
 CONFIG_SANDBOX_FPGA=y
+CONFIG_GPIO_DELAY=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_QCOM_PMIC_GPIO=y
-- 
2.43.7

