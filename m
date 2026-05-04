Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242CCCD3423
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 09:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78ABE845E3;
	Mon,  4 May 2026 11:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="22GhBSVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B2D5845E9; Mon,  4 May 2026 11:26:52 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 793CC80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 11:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnJtFqWxndwlRjw4PVoGpvdNSdEkcgGwD0mjNXJdIBjPTjHZit5i/hG8ZAiN+vGvIWBqpUmz+UxVgwILumeZGHLHD7AePQu1oqe2IbtSHHzaoP9+JVwEx/lZnCnIBO4UMrEucnn5bsKbyfUO53a0vdtv4opLMBB70TvoofPIpfXP/VI5mmK1i+vSq5P9eDdfp/RkCdIL3xF7ScgLnObDPjOZ0DiL/EVM9QZLKDwlA2byKBOBexnRas/7d2CJXyFIlIxHDI3lY9JUmu1xPrrUk3UvQhw4CAMz7d+KbhFXGvEYbB/dxFep15ytCRBVY4++nC7ukrTZbxITBnSo0sWw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Gvju8K2y1lVrasNR0vuse2gp7XAE7leNNv3nzhxl3I=;
 b=t76doOJQrRPuYRVpMEMbA6BU+dZOgRAaDwf4R0waac+9koWG0OeV3kbYpgu0O4XOAW0o2RR1qjFEgwzbC85hHntAcP0T4QcVndaDIWnPv0RiNEIMY15triRmyz30Q6Nv+eEYxqY8r04zmqpwZMATY7aq85aTvqKJsc60OXYXEy2EiFNfgZeg40sQhQcGpt0dkt2DT3ENtRqsodQzH/tWTWmv9gfl7Dmws7oQJ8Uyp2fInnnKFBKBhUlHCXLWe4MbUtGHKOS2N9WA81wv6r/d3VXuOT6Kj9gJDrrzEYLByglVtaCoS0SqVYlT1fYJtTbXqxKt2W99Q1mGBpU3F9nrOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Gvju8K2y1lVrasNR0vuse2gp7XAE7leNNv3nzhxl3I=;
 b=22GhBSVKISjcRaR1ru0/nkA/ZSSN+Jnm1HOGjx+tgqPAdUqInRw05NpYLc5DcS2UdLPfnrojl+wLwKBHx7N/qzod9gSvLPu5G41aWPAdKAGKxV9eTXWpJC395FgTEaU6Uaf2xCXOF87i1NdV1uSz0rBKk3FGmIHvj356aeS+788=
Received: from BY5PR16CA0033.namprd16.prod.outlook.com (2603:10b6:a03:1a0::46)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 09:26:46 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::55) by BY5PR16CA0033.outlook.office365.com
 (2603:10b6:a03:1a0::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 09:26:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 09:26:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 04:26:44 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 4 May 2026 04:26:44 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>, Padmarao Begari
 <padmarao.begari@amd.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH v2 2/2] riscv: Exclude ACLINT for TARGET_XILINX_MBV
Date: Mon, 4 May 2026 11:26:29 +0200
Message-ID: <7a4d125075572c0a9a87eb34b25628263c0a3cc1.1777886786.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7e80b87009b327aa618117baf223973e10c5b611.1777886786.git.michal.simek@amd.com>
References: <7e80b87009b327aa618117baf223973e10c5b611.1777886786.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=wBiB4b6IxRtu8yeweYLrZPUsPDfHYyNwxRpk8uUw7ME=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT+SPOyK8vV3OgdsdCI/wrLit8aHlmTHFa8v/u7RSlX7
 U3aHm+LjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjI9AWMDGsMSqbm/Ohfuere
 Vb8dr1fMPSQy1d3uiLTOl9y5Ozjra54z/JWdwFNT6dt23d3PinXitPm/3UQDZmpaFLywtnswS6n
 rNgsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f006478-9312-43d3-820b-08dea9bf4351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wa6fCfMcqKdgvcc3j0tei+EtD5oXnhfBl0Cl+wUurqUx3DwofOTklBp/raaU+z01ZGMrSKDT/O8oAp+vQcKQ5pwdDj0G/YhxmMp810cimDaAFnm9R3fkTHY/LEqxriX7LG4rkf0xRm/OXtyAPKDn1Du5zzPZLAstOtcxSJ6WFcefeyPhUqoXQ7K3mQVAZcoJDnBQXhauqQrm8Yv/SB/EVr/g+jtRFUvYbQPpcdDl7YWHLd6R8DsnHiRin1R3Z3KUejnjbtb8HO7i3Q8R4DhYYW0vyElBRp+/S+FPQztavdlbrKPw7mePUkEX6yuyW3A9FSm0Mgz1OaKhPBeR1h9lJvoA9MEkN6z27PwaJqfzzFNoVWKJBSdCAtGx3yY3Y7eN9Mgob6QEkobqBgu+GTYRGOIGJftobhuSxV3X8uXeOVRLszvE0H1xgGlzVIbqVM9h3HPFu1aKyF/88WlN7Ez2IgfguuuTD5+tTPToifMHuGOLsDxIeftBPYlIKfoPi/qwcB7lLUYb28/Dh0Og00iMVQ6g1eO3VlkwdCETcRxG7Uh5nI75a1tAwoaWBAaBTwG1NdUcIOHd5Bju7QrURmA4izP+Ogro9mMg0OUgJkAUHWAcBnCidBNMHqtnLDBB7wzRFfzf/WXcBYB8MGivqLNGYUrrsiqVz38qP9WXYrC3+q4s/fhoknsSm47dIXAhDERN5YjZlAOP2CQ4JXQDLcPIvOntI19w4Qv8P8x/UzaBx1E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZQ8CQKbguDvDdMnT8EkrCw0BgK7sn7FbzBNi5kIFfU8LNXMXLJ4+WScxgzxXEWwxQwFUeWEWERWetS+/BKoa/FQ4aX6w/BknJ8Xm2ogtIi4SyPlrlWIfa6QwSvyJl7wAv/rXSnAgEOsFiaQxvcy78xAmqWKPNDpxFd8+WQ45jNGksp6iIl/BS4+Xj5bPl6WYIGtngA8wLkOuEOlfYWaQdktjgBWR/z/zxhRm/4DKcKe0ANVSQL4SQUNkZ1ZwuXVdmwCJ2mwdKHLvgHRR3u65vKwqjhgsfjiU7ENKdp/WwlwMcXIQIVjGr4PMQ4BnhhoAGb/uI0+ZnfrDT/VCmrwgYupzF3Zoi6mDM2lKjdfV93lO0ycJ8aVXSZdNuZoIjcxf2oe0tpYSoBvCVnYrXp+NBWvcemhANgznAH2JtfFdZ2nUFfL9wdMPP6XHOrSW8YKb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 09:26:46.5365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f006478-9312-43d3-820b-08dea9bf4351
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
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

The Xilinx MicroBlaze V platform does not have an ACLINT (Advanced
Core Local Interruptor) hardware block. The timer functionality is
provided through a different mechanism.

Exclude both RISCV_ACLINT and SPL_RISCV_ACLINT from being implied
for TARGET_XILINX_MBV while keeping the default behavior for other
generic RISC-V targets that do have ACLINT hardware.

   spl/u-boot-spl: all -1382 data -360 rodata -200 text -822

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Separate platform defconfig from core Kconfig

 configs/xilinx_mbv32_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 4ff3bd6b6875..bcfd7cd92353 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -17,6 +17,8 @@ CONFIG_SYS_CLK_FREQ=100000000
 CONFIG_BOOT_SCRIPT_OFFSET=0x0
 CONFIG_TARGET_XILINX_MBV=y
 # CONFIG_RISCV_ISA_F is not set
+# CONFIG_RISCV_ACLINT is not set
+# CONFIG_SPL_RISCV_ACLINT is not set
 # CONFIG_SPL_SMP is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_EFI_LOADER is not set
-- 
2.43.0

base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
