Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DC9C83F22
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 08:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C49DF8334D;
	Thu, 17 Jul 2025 10:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OlGEzuk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82B938338B; Thu, 17 Jul 2025 10:41:51 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 373FD8334A
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 10:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/FlPGMRDpdbbaIBSpJ5u0D6LFCSvoKH7IjGiv5Vy6aNQ8k7y5uz0R9uwoyS9SNKmYGoPSp0NS9oBCwwzUMoslEHjKwVR2KDDmsYcUTth8rNwF7kdeY8vnJgPW2+yl7AmTFrOnVo8MRSE8QwignwUK4/tWIM6qgmFC50WTosknPtGIiGEjiWb1UO0nOowTdZmuItk+hZtFzBtUctSJaSlFIh7L0i6ojaDNlrbWaaHkQo2cdUvMiGBS8GlCKnEZgCXY/hsobQGYfcIXgUnflZfbJ0ohqRh+7Ez605i4hnUUHUjhhlxFE8ixV3mi5d6jutKKaWSnSsX2TG8Z7/vTz9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bFxUZN6FtGVNYOrZ4UNdkuf6ZF59bwta2WivnEH14k=;
 b=Nef6njnwjAL/AbUoeYtW1W48jdmA+nZwirmpWLcInXIfnfGc0EL3tzo6fMnOb31LXihPqvcmZFY0PH+2HHklLz5f+OCC0qqWfCKsw1sr5XtKuUHPdvqTapZGolTjMCM6ef9ZOYqQGE2Cq47Mk5dGLuBXPDBX10Tzo4DO3jXuCj2UFF87vOOQymjqpZNsL90OpHJx9rPOeuKOibaIM3mcbVgXA0scm0KXblQIY5IICojxPvOaj4Xu4nNiNTWMMk+xt0IQiVDrG27GdwbfL+uispecnAPpU9W0snEqaUKOKh3DrH3Uw5bMbDZFcqeavP3GLZlGE1UX0QxD3dXBxRYCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bFxUZN6FtGVNYOrZ4UNdkuf6ZF59bwta2WivnEH14k=;
 b=OlGEzuk2twiitVY9F0CsWB5G07+aLK9Tx9mZ/u4RDk2YP54G3J0Gv36CCEgnJEnN04Wzln+6433DI4NXT9VtBmzmaSggD9LUVY917S9xCtA0dIDxx0Y+9Cb/JIaSI2wWYgdxsf9NWemdKGwbEPuN5hCV8CVIQnOqhFGptNXmf5o=
Received: from BN9PR03CA0561.namprd03.prod.outlook.com (2603:10b6:408:138::26)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 08:41:45 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::63) by BN9PR03CA0561.outlook.office365.com
 (2603:10b6:408:138::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Thu,
 17 Jul 2025 08:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 08:41:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 03:41:43 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 17 Jul 2025 03:41:42 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Casey Connolly <casey.connolly@linaro.org>, Sam Day <me@samcday.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] sysreset: psci: Fix SPL dependency
Date: Thu, 17 Jul 2025 10:41:32 +0200
Message-ID: <9233da992c6bdc0b77e63631da18178ec9d64a99.1752741690.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=EMYs1SPuxDZSoJRDQFSvrmCP/D/IRB3afLVEpeM3lAI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRUbLd3KRG7de++ydd3yatnzHtgUn41t74wSXgjV+WVn
 TP2cd+40FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATsXzLyNDzV/D0ql4h1/8l
 MTt2FN+f2sbwUFRZX3syL8vcGY8vT17EyLAkbmmdcVZck1jz8uSd8QXJqQ7MK3YqRHziS9zxf1e
 eNzMA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 538b78f7-faf5-41ab-1730-08ddc50dc2e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QacQcIfyj0VEP+b0KPeixwAvIvmM/VeCeeUoS59scSH6XRKfjFIQfG0iXCPl?=
 =?us-ascii?Q?1hfOWfo1u/ffiRRdDCT4V8YZYQIUHu5LWrzKGGqe/16WnTMsw1akYFaxcJF3?=
 =?us-ascii?Q?ULqziV4Qb6i+69iH2tdyToJHhKe+0BxPi0UitQPhiyO5aRzsc9RRjnNZ6mxz?=
 =?us-ascii?Q?S/5a5rqrGP1X5qbOa3rykdCaM2zKmULYi+LfGgrcCYV3fGLXNt64Wk4fUueF?=
 =?us-ascii?Q?CLlz4mzwWug8iJvq10OgLvW4XZdVyavRu1qhLXntqOqgQ9AhD71fVSDxE8RT?=
 =?us-ascii?Q?U9xJYOs11F2WTcA3NIuNKFX+tMUTMoSAYJ9tVGidtI9uzNGagLS+Q455Y4Nk?=
 =?us-ascii?Q?jZl7hmJV0QrVrn9ullffy4ChUie5lhWRD8UHODjm3CZnXE5vFtFT1TzO9Too?=
 =?us-ascii?Q?wRfYZoD7ixr4YaEHhvRVPMN3jO6pmoUgcR9nc/ImIHYt0w+NUvjYuVo048Ea?=
 =?us-ascii?Q?xHr/qRNizZGpqRhAc4UDR673G6u8d93uE4f8U5JmcGxdbGIjGg5vPqq5CtzF?=
 =?us-ascii?Q?bhcz7EAGnljI9IP3dGeGw6bRHMqnWwk/xfKSkryR/jelYlcUH8Spx5mZd4CE?=
 =?us-ascii?Q?sbWSCikxtjZsZRJbZBo9s0EB0LCn1Q96OPkSgawg6h1iiavjMofidY2Po032?=
 =?us-ascii?Q?kQHB6cFpu6ARyz1kKJGPuxb9iOn2Di7pGgGcSs2oEme8h3InW3hgHztRu3yO?=
 =?us-ascii?Q?fVm5lXLx7bjPzftINDBUtx89sytk9h4l5od5cCUOFfZBzpWJhgVB2HFW+FGx?=
 =?us-ascii?Q?X3PfZksnJvfA/oDIirHs8Vp/MnszxJj/u9WO+T+hLINLRQHRo3NEs2KiAL7J?=
 =?us-ascii?Q?jggk4rdEn1PhI8XORXl5OfLIHKeQLSRrjK6AApZrHKD4h3WM0Ub9nfsh07cu?=
 =?us-ascii?Q?ZbkotKhNI3fsnGtVOXwWqaK3/sJhSCSPNx4LuMrCQzdvdgYazYqis38wsjxk?=
 =?us-ascii?Q?YNMSDI7t/ZaeaiPj8RqXZWGEKr6rA3PnRLIGhgRjSWEA5M3vTaUHRSyhh1EM?=
 =?us-ascii?Q?TtcfBJxHwvnHqU05rEbt0WBoPj8zo09zbtOiTvdqZQvBBSYkVyb0Bb1wZlKG?=
 =?us-ascii?Q?JjXwpVwhE+j9pIn+IZFUyfInbpDqcNod1XlMa3A+bW5nJMB5A1C3J3V+jK3f?=
 =?us-ascii?Q?YPOx2H0GBItU1beEWiiAZFPa1Xfq0yukE6wHOeKwElJ/gHw/drCoRT3kA2GE?=
 =?us-ascii?Q?nzfV50EjS/X4xERC7UUtD1jP9MXyDNuN9omQO4nJ0BQV28fwdFuhp+NOOvpa?=
 =?us-ascii?Q?ehYwruYk5CdrvyPL/lorUmM2eqwc4n5abNSc05L9s+fhZqwECXwCP1Y5vVxJ?=
 =?us-ascii?Q?CMRG5JwVMnL5Gr8Tj6OrGQFlQ+IPwmPEhtF2hcN6XtiYIAUuxg4l+2A5ojBa?=
 =?us-ascii?Q?n7RUVLzMNQBd0GjialHQhoIv/syiOxBha3beMuLBsQ7qM072P+G3rPjvlA+D?=
 =?us-ascii?Q?U92LDxTQ9btCAOR/hH2APLHcHdIuqem2WVd0dYoQtkQiLXfMrzdmnsESv3hz?=
 =?us-ascii?Q?DArcnso9LRp89mG2SOhvp6/zKFvB9UNxgePN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 08:41:45.0944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 538b78f7-faf5-41ab-1730-08ddc50dc2e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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

SYSRESET_PSCI should select SPL_ARM_PSCI_FW only when SPL_SYSRESET is
enabled/required. This change saves 1.6kB on Xilinx ZynqMP Kria platform.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/sysreset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index aa83073c96a7..67edf004205c 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -176,7 +176,7 @@ config SYSRESET_PALMAS
 config SYSRESET_PSCI
 	bool "Enable support for PSCI System Reset"
 	depends on ARM_PSCI_FW
-	select SPL_ARM_PSCI_FW if SPL
+	select SPL_ARM_PSCI_FW if SPL_SYSRESET
 	help
 	  Enable PSCI SYSTEM_RESET function call.  To use this, PSCI firmware
 	  must be running on your system.
-- 
2.43.0

base-commit: ea9b7094949916938ae6aff345422eb0f125868f
