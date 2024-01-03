Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02787C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 06:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06B4F87933;
	Wed,  3 Jan 2024 07:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Aa3SsEbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A54B687940; Wed,  3 Jan 2024 07:13:36 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE6187929
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 07:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhy7CRAiyTp7OOfLTb+yjTkBLvUMg/cb+M9pydAbl33AQIvGfe6zHy/m42FCw2RMbSqk1Kp7XtVDOam2W8EOm44oZ7BlQxPjYlqISMLSkMuk1mb6ivc3n3zuGmC1NiowLZHOWH0VwKkd7PDU1t5hjaMGHUoZZ8Ub2jBxBQS4vxVQHG0SQ78B6Zp4lFOueH1QIFQ6dCENybpwUG8zzU2hc7gmY8Ej0kNJQlxkipkk1pdEHonDhmZR4rj7/imn13kL7mnS8zsoWWYrCoLuCCxAWWOVzFhggdZNndfkha+0Xt+uWWZRsLWR2wOiHqj7du6Ew+YsLYLPyJVpi2RwR/otZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBc62Elrk3a41brdpd+5pFtExq0x5+OUT1mj0oj8r+E=;
 b=kwHfyO07UCtHD1rEa4pHrAk7LxNYFPXO8Ap3ikBSbCC87y9JKCwGw/kyZSETMpDMtAYIUuGGRLiWDrqNMaAd6Dopqt7xyqMu6YCDkb0NYbOOvUsXaxeTh/0lrX3IwvHeno1MTts6mb3p1YGHht7xCFEcBBJR8yNhLLUKuvuPt2iDkWX2HLHa3n3aI/y/rPSSIXmuzzmvVhtoMaeVMefHpkR4YtG/z2POuoXn6kQn+fvR1HBeAJ9Kx4SBE7srKOpojUsd58BdO34rSOXq9CmYmZpPL812M4kPSueoiVhesfzEuPOwHoHb2sf9dvLxn6KraBm2RPYpIEcpepFwz7N/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBc62Elrk3a41brdpd+5pFtExq0x5+OUT1mj0oj8r+E=;
 b=Aa3SsEbqOQe5IZptUTn8CB41t5r+XTU0AfDCo34YGX66PTO7gdTn9G+YpKXcrgsi2dTsG4q5psJf5KH3wbIuALxyIeT5gpxZnWe7hLCNGhvs/orMEe8mvCtHQz9nVjMs+gtgwd8hEZKsUYLghBWSepKXC24AoZRqz8kpJ2aSUUY=
Received: from MN2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:208:1a0::25)
 by DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:13:31 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::3d) by MN2PR07CA0015.outlook.office365.com
 (2603:10b6:208:1a0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Wed, 3 Jan 2024 06:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 06:13:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 00:13:28 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 00:13:06 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 3 Jan 2024 00:13:05 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>, <git@xilinx.com>
Subject: [PATCH] xilinx: Enable the NFS command by default
Date: Wed, 3 Jan 2024 11:42:58 +0530
Message-ID: <20240103061258.959110-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DM4PR12MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 972b35ec-e785-4f24-6653-08dc0c231bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwVp4YZvJsNe1txpjRkMm4Jp0yPN6O7C6uWi/NZs7LAqydLOBU7vN+m+q+WBckNg99J418Zj0Acjnr334obT+yGbVo1xjBi4nBt+HNLwGGu9BS5Umyh5fyomK/eNlx4TdaT0h0F6tJVPj8rcJxSV3BliaupJ3n/bZsuQOsAFTDIErUwXObpp+AWc0Xj1ml/499Rkx3hkBDJ+r9sCzBP7qc6bp6/qCvt33B0N1zE4fsax4VNnHKVfYMvj8sRnl2A5lJmj7VVBvVY0PX1C6S6V+PWewFvEIGM8qfJO8ZsQfVFilDR/2EQ4ANmakez1bSw1wIW0kQyGCuBjVs8u/ewyglniFquDjwDJL7zhMok1FtRB6iCNWEq+FliqyyS2OmuMU3Vh2a/HTbz2nQAzMHKqlpuvZwdMvhuFHYA8hKiAGh0Djz523gLC+IQpmJSFm8XD+3ODBHMGhJsHepeUjOCIadkhm3vOzml0trlSwme6WaDQ8CNT3/xWQLvvDOTS5k3bHAySW8X/gEjR16Za36aRCzcjoW9/SHFHMSaXNZa1Qu/N0QSbdYw6fTLDRA5tMre4IIG8d3Y5oprsngZKMfn7bnCRaY9AhpGYHT4k8U97JOkY+h6zAbKUo61gDE4FJtl69n6/t5BaYrx9O9Uqr+zywuGEbaccMBbku6hJHeEki2UPRHcFnE3w2P2+hXaAFhLdeI9NzwN16LA53yGBlKADU/h0TLzGR35Z9g1M3vA30LJ0cqYSq3IMpUuLhw/5qLKBwATjQdi3XWbdOiJdYyx2GA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(41300700001)(1076003)(6666004)(47076005)(2616005)(26005)(107886003)(5660300002)(81166007)(316002)(36860700001)(54906003)(8676002)(4326008)(478600001)(2906002)(82740400003)(8936002)(6916009)(70206006)(70586007)(356005)(336012)(426003)(86362001)(103116003)(40480700001)(40460700003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 06:13:30.7757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 972b35ec-e785-4f24-6653-08dc0c231bb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
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

Enabled the default utilization of the NFS command across all
Xilinx platforms to facilitate the booting of images through
the network using the NFS protocol.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 configs/xilinx_versal_net_virt_defconfig | 2 ++
 configs/xilinx_versal_virt_defconfig     | 2 ++
 configs/xilinx_zynq_virt_defconfig       | 2 ++
 configs/xilinx_zynqmp_virt_defconfig     | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 0553ac6b17..3095e402ff 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -46,6 +46,8 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_NFS=y
+CONFIG_NFS_TIMEOUT=2000
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 6a2c03ccdd..080d0b2f34 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -48,6 +48,8 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_NFS=y
+CONFIG_NFS_TIMEOUT=2000
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index c3ee9beaef..7aa278c25f 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -70,6 +70,8 @@ CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_NFS=y
+CONFIG_NFS_TIMEOUT=2000
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 239bb1f5cc..62e37309aa 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -82,6 +82,8 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_NFS=y
+CONFIG_NFS_TIMEOUT=2000
 CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
-- 
2.27.0

