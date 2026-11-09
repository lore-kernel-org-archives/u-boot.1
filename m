Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3962C606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qCHiJPhO;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iUalzFS0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6FD960698;
	Mon,  9 Nov 2026 09:42:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vrI2Y7nPXG7; Mon,  9 Nov 2026 09:42:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BD1EB605F0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794217372;
	b=QDZRFHvtw/Qno9srVR/yaxxmYxOJoppgMkNRi+x4xgysQDMhkFuailK1E7hX2faD9s7V
	 nQI2v6Z7am4W+AYFXBmIfVunEUvG6/16Tn5Dk4k4V+qNpzMATIY2uEK0JevqEO4bwaw8L
	 SkuI5pcvbDvgoo+7fu2Pn7dtIa8HcoYACnxksQmrcCnPiubQ8QxnFxiu+hGYc4chOyF0m
	 DZeUds737rosr8OTUZHcva8SFBJXyij/yiT75VqOSUg0Trl0O+PuJ9tQDAjqqq9V2G3O6
	 DYM1yJ/1pY+zm7YOGyqjVMbzcKv/txTzGKwIJgwxOyqPqoP97Bt1l3hCCtDaHI+kMyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794217372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p//ZJxlIfjRlfuNZfYkUIc4fgDiyvBsLybuTE17VRNk=;
	b=TDDxHqA+aagapsmJa6fsYUFlmbQbPgDLZqzp1p5O1ckxlA4D2mkh5dqB0Yh/Xpmu1vCR
	 ZlFEW+VbgI3zSXDeutFRVLmsSaaeT7g6f/FvGqAlYT1fBEsVqcFrVyBRRquSsnNRwcylV
	 MGV1mK/TwLJVmGZQxTj+hk7kARXuJHv6p4ZuPu194vEEr2H3EYRnXnwXBPrqBmuGw0vQZ
	 ZoKr4NhqbUeJMNq6SepCxm/q97B881W/XE4oJW2NsC1g6PlPKtLY0mnN9qlDUsZ0mcxD/
	 jn4lotUi7dKROfQ6ETVDtV/jgjzwo1MyPdzIE7hAjl8qsfzcucaDRDo+NZKCEvZdUTg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794217372;
	bh=p//ZJxlIfjRlfuNZfYkUIc4fgDiyvBsLybuTE17VRNk=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qCHiJPhOa0u0O9GfL1AkUCs+yMPSi6QsUv+lExGjrs+QiYWx+fx02eDbV49akfJmE
	 zdQyyQEjt5Ii4IXEUsYEZtMsQqj4S+vY3a1AoVtkT+ogOV0F8TMfyuhRK9AbfQnRzr
	 hXeNo7hexUiJcmfPXdhcdF7Ibq2SIT8sSCSY9K0/v+eYaXe4IWhIGURUy4bRxFabMk
	 etTDiKqYpSIbWY17HW3D57e4A2BnxuteZ3KSXWllQxbeq7DgIOihDlfqV7jmLlt5lX
	 wRiDulsKd4rHZc44x+XI9uvUS5swftUEW50XXPgNlfxbzS0ZF0l3z/AhGxn9qGD52l
	 RnzuorCrtLe6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD1EB605F0;
	Mon,  9 Nov 2026 09:42:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 832F0361
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74A4080E1D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:42:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NJU5PN0AHq5W for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 09:42:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 829F880D77
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=iUalzFS0
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 829F880D77
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p//ZJxlIfjRlfuNZfYkUIc4fgDiyvBsLybuTE17VRNk=;
 b=iUalzFS06pmHXIKqRzTYfUq+zSAGEDhBomSjGorWZHpXHBbYAhCMc+gD8bUvy54p0snSNsqAW6sZC+fqK5iVA++xTTOHRo67qFEpiZ9uABtLD+JA86XFJ38lLN+Mdw7XatopGhwEAamoitbkb4Hx2VV5QUl7pXPexn/GHt6173s=
Received: from CH3P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::9)
 by SN7PR12MB7881.namprd12.prod.outlook.com (2603:10b6:806:34a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 09:40:42 +0000
Received: from CH2PEPF000166C3.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::44) by CH3P221CA0007.outlook.office365.com
 (2603:10b6:610:1e7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 09:40:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C3.mail.protection.outlook.com (10.167.244.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 09:40:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 03:40:40 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 03:40:40 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, <pbrobinson@gmail.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Pranav Sanwal
 <pranav.sanwal@amd.com>, Prasad Kummari <prasad.kummari@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2] xilinx: Remove CMD_NFS support on AMD/Xilinx platforms
Date: Mon, 9 Nov 2026 10:40:28 +0100
Message-ID: <3a4de5cab4546449ad0b057c3d9f3ff913b61fc2.1794217226.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=UDwkuh2+cW/VXfIPrPOgm2/pX9loZGo0zbxyZJXwbbE=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR9nCqk3fdF+/TbxE8mbqYBO2xetc0M2u1eV+h1esVVE
 3sv2fchHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjARL15Ghm+fF1r8llrQY21j
 z3px7WX163snXP2f8CBZuelR+1UXk2OMDFf+aJa+YI87VJhcKnvj2XyV6Hv9zMnPTBqT1jUG/5B
 YwA0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C3:EE_|SN7PR12MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f0d63b-87a1-402f-cb71-08df3e458542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|11063799006|56012099006|261021123027099003|261009223027099003|261026121527099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: sNjXab6hy8z3D8Ub3u2KNB+Nv6fSQVvngqZDJ9c7MQeOZ52VnmYDJp1GYJBPaP7KNvO1UMNbgTCePuuRES/f9cuV5a9iqqvdpm86h/Hr+Ny5zEfb4t4HsNnmCdlY5DYMNWUFc0rEkKF8H8w7PkLXRPxu1wLhQSn2Je41IxLZVsCSBDEZLnEEcau6YRyJbZk/25iQCuRXDC2gV166VE3Vp6rJDG6j6o9PsuienlgWPWyOO+QNRy9kjmRWs2tk3vaYH2lr+jtDhTtoz+TE/8aIdWO6SBrRDk6w96HJPMszIEizFKvHttgEVLc9CrF5aubtfNfVMhG4o/UBAA1TOg3NlnSc5Ii853OAKNTMnuiSjYJJutqKqVxWAAy0TcIhcEkephoJ4K6jcCKRT1Smys1tazYBShJgikvDVq2anAqDQjctElXJPy/Ghg3gLOq6lDcMpw4r9pUWiUX4j4xSMfMGWZxE1n+ICtQf+VkhyuR8eslb8JizWYkLMHf8aWXkzBll0VFDjCVnfApJMwPc8QL4veu42R58KHZFuCh8dxM7M3zOIpD9gV2+E5R9R+cDqVhJ4SB0cJJ2Cxbvl6y8f/NeoKNqHzVAWqU/kZLIMW/uppQusBf3gyUlTrKGXp8WOhuGTJT0fzW+9Yug7tjqC9X8I/lYe012tgs+jy10dGvuRxllIHZtGaxHyyQIsGFi+GEfaWpQq/8OUVxH/5xPyM+NoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261026121527099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fLUgIzLEPZG9pa6nXJ+fCfjgDz72MFXSSwl7McXoBA8AnEZ4l7cURnhr8LgpeKcL7m0w6xWqpCx5l8wQpMkyGsRmPwhGO9zuGukgSCYTc1V3E2zXUQ7SZgFmkFjW2Eo5jmyyCrbB5721HhLOre9In/c8uxGKJxsNGk2kV8tPBsqAtf1xFVs/5CRu+9sKgB7TySE9lPI5jcqhiYDJoMTV14Udp4yAJbxzy85LOXdHB338RmUMkWHMx2oEv1tfbxTDUiEr7YPgjHURzKSdID6p1tDhygeuhL5wmdESgx/jWfDn8ws+9VhgJGzTRkzXbas9TEGp7URTLQ+E2wSc7VbQZbc0HdbGtiB0LbCg7zAi+4Ja/MtAGpwKtKs/qoN2fJLaviC/1WZwGswFAagtLlGwuYOhbh3oJCTV9eg66F/1EDArpAtblfuv96i9iHnmfpDo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:40:41.8994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f0d63b-87a1-402f-cb71-08df3e458542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7881
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do not enable ancient NFS support by default.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Remove NFS instead of enabling it everywhere.

 configs/amd_versal2_virt_defconfig       | 1 -
 configs/xilinx_versal_net_virt_defconfig | 1 -
 configs/xilinx_versal_virt_defconfig     | 1 -
 configs/xilinx_zynqmp_virt_defconfig     | 1 -
 4 files changed, 4 deletions(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index b138d58adea8..cd3814ca1a32 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -58,7 +58,6 @@ CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
-CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index c9e62a85543d..cb73237f5807 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -46,7 +46,6 @@ CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
-CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 647e0455f854..3c3fbb77cc6f 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -55,7 +55,6 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
-CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index ed5d7cd55174..751f73ffcd2b 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -83,7 +83,6 @@ CONFIG_CMD_SDRAM=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
-CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BMP=y
---
base-commit: 934995f642a21ca7f35fa9aed5f061394fcba243

-- 
2.43.0

