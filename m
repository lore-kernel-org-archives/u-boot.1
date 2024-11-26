Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808F7D5A6D9
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 04:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0BA38961E;
	Tue, 26 Nov 2024 05:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5qxgfXFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C8C89BF3; Tue, 26 Nov 2024 05:13:12 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F207C8960B
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 05:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQYaDwCv+qhRy9iDKITjq/PUKxrrpBH2WjwU6OxQugxBljA6YF7UD+Lq+uxT8LqMEcx6Gt32eBopdgw5xx//sNvDF56IKGj+09OBtITjIyzRSsoQmXTutXx/fuUrrCYVy32ebB31lKn+M5NJvQHdNlfrBDH+HgcJSBd6viLxbfJKMFNPuKJA3sbG2JFUUyq0qzWn0rRs2EOqCBvwmANWrlwkrDLsllE9sOAuOzKefDUaQS4skuFNsX7U/Ed5Mi7D6YxyOjGLbPBynGc/QCB5o8ydoWL2lS+4DrG3SPSHBxm0lbJTNXWPeHPxW1Wg54kFzzNy1aQARuR9w2dVwan9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5cNEp5D5vtpx+SOzK26T4QVukzIYhyjIJBhTJY2c9g=;
 b=Xnr6b4UMD5Klw/JD7wLZJcnn5L3d50Q6MEn+bXzcvIJPmzxSShVvCwvcClIddaHcBfkJ+giitWyexCuoXP5TaUzwQX3yTn6Kf4hL0904H34Qf1InfLyeaZQpBwAZYDSN1j229tkKcRp9u3CNXbjNE1GDD+dCoKeDhj6wN6FiOGoTuLynh3uHByQd3/UzTLFA6U4dWFwbIG2fpdbnIPYxYKm872O3mQ4rLGvk37u3Y9wBQaasjdl2NlS2Tqns8NLvuJcnZQ/ZgCZnjpMgbkYLLA4n2mEE9dRS/8O9PVa7Aby3tZV0yaTk3BoVEsRslBNXPb6h4BKtDfxGqmuDyVO76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5cNEp5D5vtpx+SOzK26T4QVukzIYhyjIJBhTJY2c9g=;
 b=5qxgfXFf3QThvgJ1jyZvPYQ36p5uftWIcM5rMe/4qxHLtAmnPnmHGVHL63dLKVp05p/Sf+pcV5itIfhRUJLE+zSEY+/Lf1OcA2BGkSaame+To81Jbapzs6pJoNClroJGtr58zdHwGagwh3CUZ8kynjQ022p/TQLOEvswXiMtEbU=
Received: from SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::22)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 04:13:06 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::b4) by SJ0P220CA0014.outlook.office365.com
 (2603:10b6:a03:41b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend Transport; Tue,
 26 Nov 2024 04:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 04:13:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 22:12:57 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 25 Nov 2024 22:12:45 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] configs: zynqmp_kria: Enable the USB onboard hub
Date: Tue, 26 Nov 2024 09:42:38 +0530
Message-ID: <20241126041238.1969723-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd5c135-64a3-44f9-b9f6-08dd0dd0a06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WjmseWZ30anz/58hGhnStqiPa+FlM9NM3u81xYk0NIsowzg0sUdH9bxw5KhL?=
 =?us-ascii?Q?HNdakCDl9BOJY5Odz+/2yIo5iSDi5lQAbrBk7iOTBQ8dHWKFVU3bJw0kV0lu?=
 =?us-ascii?Q?TpZk8oGgYt/bGEVNj+uTupL0KQ7uNj+dyPszDxs1RB0RsKEN4DTXM9jMWKBK?=
 =?us-ascii?Q?4iUYNTjiq2QKm7yt+u1zvZzL4wbY6iZMujjIdAcpV7HinFiRK1thUetbKzk0?=
 =?us-ascii?Q?gWwHWNSFZq0PQV2k9zDuWgKtGp8y7DEhHf9LNZgk6Gz4jbHGX+kBU6u0B+9e?=
 =?us-ascii?Q?2vR5iVEvTqp4O6u6fZoykb2h1CvAKqsGxJcKSX6hiU6qno6IKcaDvfBavx9x?=
 =?us-ascii?Q?H84dQUUJRhDCq9PuD3vjAG1fagFx2A+x6Hx2wIqOF9WNRdZZ0Lu0QiJlSuX3?=
 =?us-ascii?Q?73RtMpQyD8mIA3doXtAoaRQrFC6PlDL6bD5LJhu9YfuQ+WO8tE+sqkceYg0L?=
 =?us-ascii?Q?8zU9Z/Pfs5ko/d5ZYJKp8Pjsz9PvPQ6VHojqWAd9ZEOQy9dV45x6eDyoHg8m?=
 =?us-ascii?Q?eJru2KX2vryphvb4ctZ1t9pTgKbtqG+m0oxsaaQl8iV22+emRR0y12rqrog2?=
 =?us-ascii?Q?Tyd3KSks1l2Hd9lJ5IYfFZXJVw+jFlZo1x3EC6+MDW5oc9zCmVwQhwzO5z15?=
 =?us-ascii?Q?E/OvZv83pazoSeKumzqopSn0HrXxo0RhXB8G86L9boHSw+B/WFsDR4FWxRdc?=
 =?us-ascii?Q?fl8DgnZ7E1Rvspw+jOkDbHNJTjUWhBNp0QK4lvMxavpLSSr3djj+6AnkVrM1?=
 =?us-ascii?Q?Zu9PSK2Wt3VjZpupDVIqVhPfx0oE5+uTjDkvrnSnP0dMlp5kN/t/jKVx9mk7?=
 =?us-ascii?Q?kgMvn89NQVz6eRdxEGiOBuEI+m8+1p4igXvbKcLBHnQ4NFjYuhF0Y523qFP1?=
 =?us-ascii?Q?hmnzfeLhRKQnGIYtNK0kTgBgvMLDLnBw9inZRWgtEwEj1j3fcBO8V0NVvp+6?=
 =?us-ascii?Q?7u3GVv9SngoEeIz5n3sJ915kp2bEhWwQG++IbQ9iC8WR+oxw/afuz3bz/dPK?=
 =?us-ascii?Q?t9gu93Had+VWrOjHPdGVLg5WyXdMgA3OjO2nRO3X4jbN0pwJS2Ea16Zwsql3?=
 =?us-ascii?Q?ozS/0Mub2HCaBeYUUNsSRDpHBx6SSx4uB+sSLlKuj+DOq/89xQa+KXgvA/Op?=
 =?us-ascii?Q?YcTytyrquLMP/3+3Xf5U+2D8liVLPFOqd+DLG2BqPqoTBih2RAdEy9Qfh6Zr?=
 =?us-ascii?Q?g6HpaaXUbMtjPXQBh2fQg8jlQtivKa8jkFLUJBNMNL5GPl8CzZviXYTIDox6?=
 =?us-ascii?Q?6cYw+ZNgxFpZed7yZNklv3Yq4XiPY7wMH/cXq4oXIWtl4s9FPMPfjKYbo5ax?=
 =?us-ascii?Q?2mF5drfLIYPey1dS5vu1wqY79f5eAJLTTxxj6h08RVowcUlySjmX0lYK0sxo?=
 =?us-ascii?Q?o2VFCCYXf0JlPowqYnvsGBArRtZKrgLH8MxHzGG2hHYcacCQAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 04:13:05.0623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd5c135-64a3-44f9-b9f6-08dd0dd0a06a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965
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
NOTE: The usb hub patches are merged.
https://lore.kernel.org/u-boot/20241125041202.980-2-venkatesh.abbarapu@amd.com/
---
 configs/xilinx_zynqmp_kria_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index e5ffc7076f..1707a7ecf9 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -207,6 +207,7 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_ULPI_VIEWPORT=y
 CONFIG_USB_ULPI=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_GADGET=y
-- 
2.25.1

