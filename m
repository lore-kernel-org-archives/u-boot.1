Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EF4C83030
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 04:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A166D82FD6;
	Mon,  7 Jul 2025 06:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NDX8nfmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1144810EB; Mon,  7 Jul 2025 06:06:27 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFC3281D6A
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 06:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmZzpLzPA6qnwMW2DED9uSkk+zOgWlMWMtLFn7PRXfJxPOvvzkFmc10Z502QZQya+ihoGruz+nDRZPn9HAMm2PsIgF15+p0jcG7QsEP/2Sa3j95AFaPDrcdMKFzndggcPtWVCnXUID9jBmZOrSt5F+A2EE9D5n390NhdENrIxlcYG0Yc4Z2WVu8/6bhcr2JTBeHec+NCE2CzXFayW85gfaiuDjyNJ3K5A38dgWovX9OHumnE5ZdfV7ZYw42wopI7ML3iJAYJv24IONI8aH4p9Lcd8c+fmWWMmeEPH7oJepk9vLKRLG8IzxXuwdVOWGPUSk/BVdjG+SHIn8wudGinXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDEcWXAtzXnDzKQ5ucTwWxrVDvig0VazidAVbz0Fg7E=;
 b=xS1bIb8ptBISflJWxEpTLXOG3NUQ0fvr+q2SzD4ycvo5QVtUlzZ5tGRFwCj8xxDKeySMo7FZxUdnFaWNQx+4iQBsEsq+CPd8hgYZj8xdpOpIZ/wK6OB6VhIdVwN5CAgf4yqJGuOxXDHci9HQXSBuQwbQG1Gv8T/ogOphIcgiFQCfy16nmOqOwigtDr14ADvIp2frUBoM/rWvq/Pm1BB19W6rrOjka/LME7NqnIJz6f0Kasdqyh7ITeF3q78YRvhSvjSP3zASfSA5gmpffKhwKbJv9KOEGvYtDYimMBgrX/O+3w3IgWYIOJgb+otF/E0B+boQBuknFy/9at8sAXjXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDEcWXAtzXnDzKQ5ucTwWxrVDvig0VazidAVbz0Fg7E=;
 b=NDX8nfmT/OltnWQxBtLnyXIAYnMXNRSFWK6EJ/NGx978D4NftF7UJgPxLdlzzoKdG5mjTka+CA5N3Ljw5XFX5Zv3A8eAfES7yIGkoMDyfzvRx6nNi0ocDWJf+I+WNisYEK7GIKtO4dcKSCl+4nnj4za4ZRZv2ptcEFQpZp41SRU=
Received: from PH7PR03CA0017.namprd03.prod.outlook.com (2603:10b6:510:339::32)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Mon, 7 Jul
 2025 04:06:20 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:510:339:cafe::d4) by PH7PR03CA0017.outlook.office365.com
 (2603:10b6:510:339::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 04:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 04:06:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Jul
 2025 23:06:17 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 6 Jul 2025 23:06:16 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH 1/2] arm64: versal2: Enable reset and poweroff via sysreset
 framework
Date: Mon, 7 Jul 2025 09:36:06 +0530
Message-ID: <20250707040607.758919-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707040607.758919-1-venkatesh.abbarapu@amd.com>
References: <20250707040607.758919-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f57201-86b3-4d77-988f-08ddbd0ba0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nfickatgxCE6SvpZG2AFk2alrSMieEFbcwsQK5tdTA4Axc5RDKu4DGPrU+pz?=
 =?us-ascii?Q?xEHaJka7hNzUFdkedZVejKXWo6wte1c0R4Pd4jD2+PEMo+vZD9Fj0gJnzhbM?=
 =?us-ascii?Q?iUglTIIu9DQQon5RezKkY+s3f/zj4G54EPj2Tp2x6nH+8Sg/kXpUBiQUdEfy?=
 =?us-ascii?Q?Gh2mG6wSbgTpChySEALfieUuaWXWJi2i/pZg2GWw4bLo1kNlJz+5GlsRRm4u?=
 =?us-ascii?Q?s46APJOcKIhBAnyrYUsHXBJ5ll/HaXsKBVnynQmRXc5qnxjLl+VhQoSojvBt?=
 =?us-ascii?Q?Q8igMRqQKKvUNzdJz/gqFT2b1b+cv7c/B38UiTssnZxC17iotIadKI7L7pl8?=
 =?us-ascii?Q?v7uwyQ/rzotGrMOW82P1GUFIX/e/ZOFTsoyeDDcwSmXMShF85bkKUChUGvjm?=
 =?us-ascii?Q?UZMGVYxVs29mgeyC5g8wVerbdIjGs5uSmjWDWjkW+ftamjaIvpLjJBXN1720?=
 =?us-ascii?Q?oBLyoZuZBawXPUBMekkT/e02ciORKPcy+APGk6yaVO/nZ+nep6TnYnLTi3Ai?=
 =?us-ascii?Q?3RjnzNuJWPL+JvHPujI1yDEpNjE66S44aErasAu3OYSFk+W997twk4cUm71B?=
 =?us-ascii?Q?Jw81hUD6zb1kwAXuS+EM/MZq9Kp3FAH9EmOLLk6+fd2trH8cX6s/nLWqgizh?=
 =?us-ascii?Q?CK4GREckseD60su3t4SO6++nmW+Yaf8M1+tlCKScm7Xkol7X+a6sczhUuHhO?=
 =?us-ascii?Q?cRYPSWfx80To5oLuPuX5T7ElPXpfWZA6fl+0YOFzU9SWRqLzi6ZqvXHULm8s?=
 =?us-ascii?Q?TSIbrPB6kDk4ttJTXZrcKBsbKklQ2PSu+n0cWH1mBVUwpyY5sllS1uJrqisL?=
 =?us-ascii?Q?p0mbipLEXlCY1+tmGcZrhRfKWAgE1P/1y29fgBJ8/YxA0ysTJGEsYFDIANJd?=
 =?us-ascii?Q?FQFO6RR5gGDH2984XadB7bWLSCJMWY2OOMArzhTD9/nC/whBoPWUinJO7X3o?=
 =?us-ascii?Q?kWWpt69BWPumzA/fj8zaJ5QjAK+hLJwKgc5b+Di/u5PN4ReBDpotDqz1ptDn?=
 =?us-ascii?Q?sZpszxg5rjQi8aXNZZ5V1f8YsQvr50cmHpRoqIVjDOcPpfkohTvcijOb+FXn?=
 =?us-ascii?Q?kIsd5a4e+/NwKB0ZoDS5L+h3U2t+1wwoCiqOBcs7AttpjKgt7yR535GDBUmJ?=
 =?us-ascii?Q?0yPyM1rO912JNK3s5n67F5p4tk0HriItSQQM7Su4ye9L0qtP9yMZQ/UpjC2h?=
 =?us-ascii?Q?nawqO7GNSaqK6r7voCzrlOw2386W2CD+35YZwMbn92/PP6ugSsj5dLIg6ahz?=
 =?us-ascii?Q?SQ+/9XL5csgQvCjPYNQdf+UYja84HUAKJgbAPWDo+9YIz5ExADLIFihx5vGA?=
 =?us-ascii?Q?nwGHuV/u4vooUk/6eW4WCt93vt/6nj89anuZIcHxq5qqmwFq3RU8h1aRykAY?=
 =?us-ascii?Q?0wjv1gKB8/xHKVMsWnc7lS1oxpyY7XrGgaCd2d3NgyVY+aTmRWTzabecFf/q?=
 =?us-ascii?Q?CuvTwlZ4V0IROlcxu21OxcGisKW7OX4pSheQAArFkMYtVEmVWEU1xgBLZ0QT?=
 =?us-ascii?Q?fxelUnVng91We0/p4ag8Xgvek+8UJpg57+DP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 04:06:19.6557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f57201-86b3-4d77-988f-08ddbd0ba0e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
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

reset and poweroff are called via hooks in psci driver which is going
around sysreset framework that's why enable sysreset drivers and do
reset and poweroff via this framework.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_virt_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 15ac0211828..5d5cdfb8255 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -43,6 +43,7 @@ CONFIG_CMD_MMC=y
 CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_OPTEE=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_UFS=y
@@ -130,6 +131,8 @@ CONFIG_CADENCE_QSPI=y
 CONFIG_CADENCE_OSPI_VERSAL=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_TPM2_TIS_SPI=y
-- 
2.34.1

