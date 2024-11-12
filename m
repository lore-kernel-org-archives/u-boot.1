Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EECBD41D52
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 05:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21CB988B6C;
	Tue, 12 Nov 2024 06:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VyBew56Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75DA7893B5; Tue, 12 Nov 2024 06:13:10 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE77893AB
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWDrUDkdJBDHVYgz6KdedR9IO30avkkXivkZz+tIniWyHOwduNzviirlcUPO6JjAlW8pZHJNYesWYm5o/C+GC5H4kXdZiN2iOyDxCItU7KsUYrxfabEbPDrNOjU/eq7bAikxkBhuBQFP9QbQ5oYTpmZLuEgcxGJbxuK3qbCBXCbtlaWV+DbuETxqa6cOy0gXBNI2eUxCBTZHJoLWJoG3yNqKUKFzxKseAYHiNQz90hlLYzQQWu3Ii6smzjbBMiP+JTP8Qk3Q4o3QTi0VxrK5tD8GrnTWl0kxfLW4OzQh4EAFibTu7LmDHHo9LfsIGz9j+u6BQtMRK2Xl5EC3LAkjIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E14I+3DKXHxigtV4WEeSoiqrnTGOqjxpxEYGBBMtmjw=;
 b=ncA1AoWZm+vJ17USpWtMZhi3jJ8X3rOFaCydECFcpBetYV5SJTTZZhUssFMAxqAqxOGu/jCOoXsHwR2AyXq77F7Q3M70+iCUSCiXp9rO0zW7G74KsJ0ILEzxau7yibpCVaKNYFtXCXLzvE3289f+WCUrQV2L5bs3UwZes0Am+NVv+PasjpwhAHdYsjLc+IPablT4u4OZB1009pMQAZo5E2F3jFbfjm1oxQEpU1t+1dhKF/4aX1e+ofa7/SNg+Rl4HFjU5ye/r6LdxfTJMVRY2arUsvWK/HrjLlbwFasDN1+1Ml1V8wBR1i2GhKN53/j4u8iOWUFiJa7STbgsyq/UpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E14I+3DKXHxigtV4WEeSoiqrnTGOqjxpxEYGBBMtmjw=;
 b=VyBew56Zzi40gedbc0Bay8CVK/AP0Pw31KUX31U2p62YOCKUwI3NTWaMEscC+SfDR6dxYeSP90tCmM3ar0GxroAKk9jHbhEDGj34lkjtVOZzU7j/7WbevShaiPPAOvIyj77b4kHqN4MwLuu7T6FDjj2Wu6MiEn/xK01lAX+voXk=
Received: from BN9PR03CA0180.namprd03.prod.outlook.com (2603:10b6:408:f4::35)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 05:13:03 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::70) by BN9PR03CA0180.outlook.office365.com
 (2603:10b6:408:f4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.30 via Frontend
 Transport; Tue, 12 Nov 2024 05:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 05:13:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:12:21 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:12:18 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 23:12:08 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v11 6/7] configs: zynqmp_kria: Enable the USB onboard hub
Date: Tue, 12 Nov 2024 10:37:39 +0530
Message-ID: <20241112050740.15343-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c831f8-4773-4a03-4db3-08dd02d8af13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/BPAoYj2QA4swx/6UrIELxK1W1trtBzFE/rZE5oL7rzlKoJP52zwXIXFxrTi?=
 =?us-ascii?Q?+a1m2cJrwyzMJFiyQHFB1gLuO0nl+BgjGtaTuVwjLxKu/2OUXCD37xD7tRb5?=
 =?us-ascii?Q?nXDvul3qv2cUd+FEGsvyDjKzPn80cnv2MBy77UVMnh9vVYReAjfhJMxj+yVM?=
 =?us-ascii?Q?lQEaGTmmT9UHdW3IilIyOauNIlB4YorGKC+lCqqK2BFKqbMbuOmlrWQYELNE?=
 =?us-ascii?Q?cAeT/uvIkP1aWu9A7OQYfvMnDzRthknrOn6YedLNB53limXq8CLfPWR5nrKR?=
 =?us-ascii?Q?YSooc+GRSct9bDAj5OObFyHabFnn0ZDTVGjhEkcAUGLBwbqWWjqf/uBgXWDi?=
 =?us-ascii?Q?uNMkW6soSxOqPBRsWX+pQIFnBRDFb9OG7czApjS2BvhsFmv3bmwgcNrN6qhh?=
 =?us-ascii?Q?wwk3QF/SBM575n9kxmLg/evTVwVp80VbSwDRF/2qfPnq1OZ29gdRhbiHhhN+?=
 =?us-ascii?Q?xXF40v76CpYlXDOYuoS7ek2r+jFaSgGhN0d2TtexJbVAd4Ih2kD/opVYCQso?=
 =?us-ascii?Q?IUF16xkjCgXf24gXChN9vW8csyUZtTGHjb3qQv5ztXfW9kmslmW6eTlZX/GM?=
 =?us-ascii?Q?97g21ulWhpEzOOrceKmInVM/yTILpkt+HGND/pHys8NYqrIk/obNxW2ChgwG?=
 =?us-ascii?Q?UNS3btpQ6GSRc2zgwevhwj4eJipyBX1530LijEd9/FzuM2BcDpXKqVMv9fqO?=
 =?us-ascii?Q?oTDjUNabUhHHoBRgjYn99hbRAGHrImpE29Dg3a7ecfhBgwZlcKeqBm+evGtK?=
 =?us-ascii?Q?IdfsaL50kOpHz225rWtXQw73bngJ1itc0WYeEOJDziwzfTObxbNXRmfkEOeH?=
 =?us-ascii?Q?7LNoEAHlRecN7bgqqaIwmKTFjZBzgYidJM5E3ea3dzkivswOGz+6a/ggzy2G?=
 =?us-ascii?Q?Jm//A3Mc9U6Bg0yn/vd6gAnwwxolQKzS5lzpdjzQmmCpZX7P9hmCcwSnJ5gz?=
 =?us-ascii?Q?FtaOM1QZKrsk0CJyfXV0fogzYAZyM1FaLkU/tipJyfrnCfL18ELnlYXAiAvX?=
 =?us-ascii?Q?5PMnP6cpH/dLF/zr96t2L+xf0MuEv3oZY3ZruM2a6yacqAFAjeCtB7CNmiG8?=
 =?us-ascii?Q?khRvHBUCJnk91CANF3R5mBntmdXIF/RA+a/NgicXuqhUB6YfADH/NksFeINL?=
 =?us-ascii?Q?9hl7lBbCbJaIlpM0f98hZ9VYNwhrPIsh4mJ+IFduqfAtR5UgVw3uAc94RDh2?=
 =?us-ascii?Q?EyaR+v1TSIHCNIIaaukGaqsCHea2yMy/9hR26zTUwvUGtCSdtBUlpk34G6HA?=
 =?us-ascii?Q?BZnLx6dKouyJI/3KAgYH+ULQst0H7rPg3vX/PPA2ejf+ksdKCCRNRn6R1MiY?=
 =?us-ascii?Q?Or3g5ssyU7r4ZcOLpi1zJGu8Av0fBPpfk8G9yR/7eGcQeJYF1tTAEv0Sl6Pc?=
 =?us-ascii?Q?pecwGO0kPlnNRln0dc3l3nZ8lzy/9DBWgTXPnUeRhqNnsXb+kg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 05:13:02.9322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c831f8-4773-4a03-4db3-08dd02d8af13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
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

USB host support on ZYNQMP KRIA SOM needs onboard USB
hub driver for handling reset GPIO and for i2c initialization
sequence.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
---
 configs/xilinx_zynqmp_kria_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index dd4df0b2da..a1d9aaaeb3 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -117,9 +117,9 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_SATA=y
@@ -208,6 +208,7 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_ULPI_VIEWPORT=y
 CONFIG_USB_ULPI=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_GADGET=y
-- 
2.17.1

