Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6959BCCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7311845D8;
	Thu, 30 Apr 2026 14:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HLa3oDti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B31845C8; Thu, 30 Apr 2026 14:04:43 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2F7384119
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJQtB2rRJAM4ZH1hPAtcPILKeMedvHao2tHmYq/PoE+xyMTR0s9HWkawcNFTUJg5VN3S9AweP8ThMJV/l5d1w9y7Z23NoLg9DJkfocxT7ATCL8s+w/IXSR5zCf3+gDCbXviVzrfOp91ybd2uAB07cn/0uk2TzUf4MmdgoUWrXp3HCEqQGXus5SV55yUnll/cFLGHSylBDYW0O7lIQBPcc5B0RbQFpxak99gnK20FfVVrY1hypkRM6Fn9hWagoxlP9j8xRfxxOJcX/niFkt+g5UUmwhafWTNXMFLPMeR2DYSjo5CLN8ShNcXETRHmkBNfykTTdyrEnyB71RO+DMSc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cvdecRQ1057/IWyQ8GJ+F/VklVC0K3cpgyaFA021tE=;
 b=duA3Hq6QMhzXVRscJxH9cyIpC26WLlBvIJEIw5cD1f8+0jvta/gMbd/V+5wTcE0FCfUmIoo9JwRkGopzgQoPmwT2WyJgIxwoLAoXFqhcZLMRudmohPnvfcresaCBFHo35j5s7Tq8cuAEfKnz9fjAbGZ6R4/e3Pi+S26QbkSYXCFAJ/wqrlIO3Kxzc49AA7N4tFB53CRLaVaZWNgrO6UfJztjmPh/dZ2oLwue1kOE66fGlxHkbaQg/ljTfUOmh6T3ZVDpO+BVyVgc/tSmsK460avV5mgGABFpNHu/JN/OttgDo57wxULmZNYaHLpAwY5Bkhw2C/gyc5p/DA8avSZj7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cvdecRQ1057/IWyQ8GJ+F/VklVC0K3cpgyaFA021tE=;
 b=HLa3oDtiRrMhkXVFogWihwTZBbhgsuFHRlqIlAlfWN9yeiFsPeVFZSioz4Vsu2WQWuBb/3pke+X2H5REkyd9NxjLpzJ9cm/q2ytSaUI1eLr/8hXCe4g+HJID4Udb8Nn60E0wiTHpXS7VEGA8XJgyDva10qqW2sOzpLMImENJaHQ=
Received: from CH2PR15CA0006.namprd15.prod.outlook.com (2603:10b6:610:51::16)
 by CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Thu, 30 Apr
 2026 12:04:29 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::c7) by CH2PR15CA0006.outlook.office365.com
 (2603:10b6:610:51::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 12:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Thu, 30 Apr 2026 12:04:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:04:18 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 07:04:17 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>, Padmarao Begari
 <padmarao.begari@amd.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH 1/4] xilinx: mbv: Disable AVAILABLE_HARTS
Date: Thu, 30 Apr 2026 14:03:44 +0200
Message-ID: <511c3c05d29479a4d1410a902cc01963113c4e1a.1777550623.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=vA0Iy0xyOeSHYnE2Dwrw202d1BK3KdfCy1v2yenvSLQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR+drXNvck99+nWroZ5Dqk7PL1OJFgJv75QtHOScOSui
 5/OtXzp6yhlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJePIxMkx57cJ6KI5HVWPL
 ytJpmYkTPAWCTC89c1ic/3/HnjXnlxkw/JU4cWW/7KPkEzOXGcS4vP8dHbiGI271ddvDaVfUb//
 7v5kfAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6f395e-b6b0-4146-71f6-08dea6b0a1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: TEqAdUEgYvQKuzerie81xdZICjrCHnSinwMsKODsNVzWfoyNPVc++1RKB8O6vdF4832WjAUOSoMorjd++A3IUDVLRXGWieiHZPQKRlHPqMzTuR5iiNOlKn7VxbrXwlJvpS+IvBBdyW3je4U5PF72w0M9/aBpaQOwE30TzchIh1W6oM6EWQTppPzt+7d5EbOeWZZiUN+xfLIFJbQbkL87kOqaBPkqsTrEpWGNav0HKToF1iAHiXYq5LtXt/9zJlCPvitToXvHaAe5h7tk9kYtJOVfe87zUjKjeyxljLo6NqzQKIrdGhPzYNNiM9JKx7f7G5m520BbDmb/m6XQmbpe0bk1pPuZ+QGpvk6FTSiqcRURvECeKMXugvIoWeoZnm7HYUzV8ARArNKFefmagfZoCscvEwCp8WqLyhDPImr39EYspYiW2Io8HDdrbx0rTAuAb0QjgdQrKPXVMOEOfk6KpoF7LF2vkS81K20+2U22EBNUzdNJLlX7eR8aua+VZMLIUaGJfUs1/GSJfcKnE8NP93+qzh84CVSDJvnEtUyFe7HvTJ1txNQn7utkAhxLTMRr9AhYOm7CEtBxpv1x1tn1IaztXHhPAmmiAbtPKh8NOEDDEFejX0MpIrH12q/OOaYQ8Gl5Fd3zY7N8h8IIv6upUlLW4hzDohppjfVPGEitpfKWSywHGjTzn4jZ/3diIDTOp1NKxVcuJRCDZfMa7WopV0PfSDnfhHUsfMeLzgXOEZU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5bC2XrVQmYc1Q2rnmhDx3ca4Wtr42eEq20Lu9sLZTAD/6WXA9hioUz8znNKbHBShVGJa5YqPoFWSAMtPiHnvXdEQ1b4a5K5M6pDkIRzO7allJTAfWYk5EXNRKqrMDUeIkBx0ohzqMW13kbvNCzEQyYAtZjfneAbWkE15572rEXw1c7F+fKjMruTxurGVRqfqbNXeCBELdaXvC1CWggI66AYDhK5R9bKPoBuarOIKlYF7xah+ggzrCR+QQazuVI3pz18dgDryhmdppxflduJIh4S6TZBjzD6EVbWA7rtjqV4202dvKKrbnsKHSGNrzCEhPeMY32vk8ubIc4yEBaJo8TgEo07zuL2RKRWpjJ0DFaZPHRnL2pqUvZkRjpE5JYB8NSqddclKjmwkfqQvgTK7EbD9a6MIOh2e3bqmwXEjeNCHMw7JHUltorjTBw7xpL6V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:04:29.4926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6f395e-b6b0-4146-71f6-08dea6b0a1fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625
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

The MicroBlaze V platform has only a single hart, so multi-hart
enumeration support is unnecessary. Disable CONFIG_AVAILABLE_HARTS
to reduce code size.

   all -121 data -12 text -109
   spl/u-boot-spl: all -68 data -4 text -64

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 4ff3bd6b6875..4a61c9eb5e3d 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -18,6 +18,7 @@ CONFIG_BOOT_SCRIPT_OFFSET=0x0
 CONFIG_TARGET_XILINX_MBV=y
 # CONFIG_RISCV_ISA_F is not set
 # CONFIG_SPL_SMP is not set
+# CONFIG_AVAILABLE_HARTS is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
-- 
2.43.0

base-commit: 6ada697cef076eaed1971c4877c402a91ad5cb48
