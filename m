Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7ACC48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 11:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E54B87E23;
	Wed, 14 Feb 2024 12:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oEP6PnHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE23887E23; Wed, 14 Feb 2024 12:52:56 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D5F87E10
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 12:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPz0LqpNzwGoqDPSg+dYEgwG//++XLngjlXR7/PX0vYwW9bWXyprcU7EhfZT89pmDgSrfAAsElM6YbDpdCgyjJwX1JG67UWF0VoJb/yZ0WEgGdetMeSRKC2cu8l1JD23GrrHB+dbO5HGWAT0qs/G7rQTo2mkde/asvYHFVSzQ8ZbJ63sQM77T6iZdJ62kUHI64vsuF9bjmfpl4xgVjScglQKNw6sVssxTlhRMoQ0snbvqsBF54hl8celYQPBXZANBInAYcAvSZXfCPj/JF5kGmqfDyGurKYuTOtww60DiL/wwcHx+yxbQEnf3qC7KhH5huo2uJiBMyyYprr5ctli4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXM+N9SJyRI+y4IAvtxVs+QuZ2QuRp83Neo7WfEHD88=;
 b=U/q0MweIPSRg1OypbFZFC4PEZhdi3AqJ5PfIaW0LxQlaP6PfkvRfAactWrXQUsY/OpCGHKnFHxCU0eTGLY2c3/4VMZjqFmDz0DEFfRswyGCXAIBR4cWSOR+BJa0LCYIT4dCAZNYi9ditEwcyHyhinvvEKLG2ACd1yuG5zywucR63YLUn9rpYFlybpKmUJo7rISfjTHE4A7aLaU3A7KqQCV/MyIEVsbUh64HR/vD4S67666aRBrRz6BT1jjBfBNL5GNKZmNDcjNLuuUsDIrWOGRMxQrg4o/cB4QH58BlDqWX7ySlkQANgRY/+7RuVLniyBqbQ0m4iM7ZAcLC8nzHvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXM+N9SJyRI+y4IAvtxVs+QuZ2QuRp83Neo7WfEHD88=;
 b=oEP6PnHC30fWZR5DWfYMnFO4bIo9NTUmZcmsyOWCHeKZTdVphbQh7ljBWZkJvsRQbDaBr7eoBsfz/D2aELUhLSj6IBh6e1p9FmJ75f1qLg+76pO4r7Dq+MqNHz/zq++8tFkPB3MLbywwG8+8RWNH7rxaYVd1sIiS0M/0PkW8ygc=
Received: from BN9PR03CA0583.namprd03.prod.outlook.com (2603:10b6:408:10d::18)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 11:52:49 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::55) by BN9PR03CA0583.outlook.office365.com
 (2603:10b6:408:10d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 11:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 11:52:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 05:52:47 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>, Padmarao Begari
 <padmarao.begari@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] riscv: mbv: Switch to OF_SEPARATE with fixed address
Date: Wed, 14 Feb 2024 12:52:31 +0100
Message-ID: <a5ad3c8d21be311254dd950e4e322d13cacdc176.1707911544.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1707911544.git.michal.simek@amd.com>
References: <cover.1707911544.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=q9GsDJaPCkjXs19/vdYnkwkCgzxL/p3dnQumzrf4kqs=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQzK+t63DSLHSTswyN2Kad7Ssm/n+8tuC5Fbp/l0TkGp
 RzqBkodsSwMgkwMsmKKLNI2V87srZwxRfjiYTmYOaxMIEMYuDgFYCKGuxjmR/5QEl+2rjTfyuh4
 3UfNo4l35nGsZpgfwpz3uSHhqKi5CseXXU2ffu6bNbMTAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f62a89a-a9b1-4985-98c1-08dc2d5377ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlBy4HPOOmLjCX1K8Br1Djg68qq9lv6j/bniJyKMM65teGOy/BH2JGxtlf+Ux8siigoZY6V8CPLe12QFB8KTXXJ/NqGMo2CbkxndCuwDFv78xGfJcnyKIzGV3nKUacU68MvKsBMVzMKLdoiE8kB9jUpOWG48YxtLHDn3H738toetMeIhJmC0pF7I6RY4TGAuVmRKbTOicW0mRD1jBOa6Eh8WQ/HKeebCokNkHSM7fa/Ljr5Oq8USevm62SxiMucrTH/P/tvxZeL5gQ2hjoMBCEgtSI4lC5fzj3r4OhH3wRrDpBx6XK87LxxXTTa9jRL1tTvqCNLhpeWYSXyfuKdbEiYdeJPl4hTK4a2/97/h8rq7qrGyAsdpZnzGA7DDkSzhG0uNmBfFk8qStoh0XmRPRaOA0dcjHk3+tnR4t6ydTA6BLc83BNhmSa0sdYZb/1VQS5cyG6UyVUFBUwGXxTDmjzRDgKrGHJLIO3wXsnnze5vzuQfPMB2KOW4GbZXPhL/Fq6WnnZBfagtpeLSm6ORMsySthIkMkPIaJx9xQjW0WIkSUwiVvJsR5Z5hPraqxUEbW8j0Z6mTGChLc6eSicpqt7OR/1U7jxCfd9dyiUQqQ+o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(46966006)(36840700001)(6666004)(478600001)(41300700001)(8676002)(4326008)(5660300002)(8936002)(44832011)(2906002)(54906003)(316002)(70206006)(70586007)(110136005)(2616005)(83380400001)(426003)(336012)(86362001)(81166007)(356005)(16526019)(36756003)(82740400003)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 11:52:49.2856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f62a89a-a9b1-4985-98c1-08dc2d5377ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
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

Hardcode DTB address to specific address.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/Kconfig                 | 1 +
 configs/xilinx_mbv32_defconfig       | 1 -
 configs/xilinx_mbv32_smode_defconfig | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/xilinx/Kconfig b/board/xilinx/Kconfig
index 843198fa0da8..5c4ad8f1df9a 100644
--- a/board/xilinx/Kconfig
+++ b/board/xilinx/Kconfig
@@ -45,6 +45,7 @@ config XILINX_OF_BOARD_DTB_ADDR
 	default 0x1000 if ARCH_VERSAL || ARCH_VERSAL_NET
 	default 0x8000 if MICROBLAZE
 	default 0x100000 if ARCH_ZYNQ || ARCH_ZYNQMP
+	default 0x23000000 if TARGET_XILINX_MBV
 	depends on OF_BOARD || OF_SEPARATE
 	help
 	  Offset in the memory where the board configuration DTB is placed.
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 89fb3fbd2fbd..a08a12570d34 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -20,7 +20,6 @@ CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_LATE_INIT is not set
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_TIMER=y
-CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index 844afdecebf5..fd3ef931f6ca 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -20,7 +20,6 @@ CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_LATE_INIT is not set
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_TIMER=y
-CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_DEBUG_UART_UARTLITE=y
-- 
2.36.1

