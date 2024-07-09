Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BC4C3DA47
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 11:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D46F883FE;
	Tue,  9 Jul 2024 13:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e+Bjwn2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B7AB88498; Tue,  9 Jul 2024 13:51:13 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3593087B77
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 13:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bo0jJrPyHRHEsnwHM1Uq5/ljM7KGBsovihCGFa/8IFxLcaSR8dNfClXw0s9+2Z9/hdo7PMPwloXpcbDphoIMX4cYmS0/l3U22+y5hsOTxXhE7FuwkY/S02TEexUyUTYoU9WW26GbxzKmFzaCc8jhekxpOCPwnwWgJfZI45Bu1YD2AIP3Rau0M5xMDRglYZXABh3cBOg43M3UIQWKsGJoGZQ9ttO7AWNzcdETbQss2jptZP+AvV1wVwmkOqha87T5fih//tOJP8GdMEZkFO1ivhc6ZXJ1IIktZHk6ehUIlh1p8MsuigBq4qaN/7bPtV+IB78B1EytE/fXhfc1o8qMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrFVLvj4eghgdttOpp5G1itZVge5CxV5RJdG40+JkKU=;
 b=XzFF2sJCDWFK3MX/wlbO+XblCpwLEWghUnQWQsJzP3GlFe4VcMxR/3OXOPNAjGjTha9goqmivXk5hUOZ66OUIUSQDmu9pVpIOaAPnYo6jyAOmbDN+RHYuAFWu9bXUiagkknc8u8VbEa6SoxO+cshEVvQQpVCSs6TtcI2Rdeyuj5iNw+MHt2eDHaa9mbcGG45+vdE15jVhdaJOu9ot8DtSXlUp5ZyZQR9Vvfts1NiYgamkpscbnr1jdIHL9clrngbWpkjWdtaRzioInZ01kKRwvaPfEYy4cAdJ16m2Sr6zotekrhkpaVNiXjVgP4L6jvdsQ0f4n5TtJ4SdLhGQYKxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrFVLvj4eghgdttOpp5G1itZVge5CxV5RJdG40+JkKU=;
 b=e+Bjwn2Vofhwe7Z3PAvZXhXUyJXuAyT1246BToHGA/oO0nr9Iy3GeAKT/L/Gw8seuOBdui5tatT4bpwao2ifJVhtKS0v/qPXEHz0LgU2RmP0AG6Xck1xJg0aJTvMfY+I2faGB0SVSw0798TTBcw6hFWUM+75fZDV5WSo98kBGg0=
Received: from DM6PR05CA0043.namprd05.prod.outlook.com (2603:10b6:5:335::12)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Tue, 9 Jul
 2024 11:51:07 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::dd) by DM6PR05CA0043.outlook.office365.com
 (2603:10b6:5:335::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Tue, 9 Jul 2024 11:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 11:51:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 06:51:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 06:51:06 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 9 Jul 2024 06:51:03 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>, <git@xilinx.com>,
 <jagan@amarulasolutions.com>, <n-francis@ti.com>, <d-gole@ti.com>, "Prasad
 Kummari" <prasad.kummari@amd.com>
Subject: [PATCH] amd: Enable the NFS command for Versal2
Date: Tue, 9 Jul 2024 17:21:07 +0530
Message-ID: <20240709115106.936186-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: b584e4ad-bc75-4eba-bc07-08dca00d6b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sjU+mDhGOEgXwUHjNZMnsIWvwoXigrNUKy8172kZ15ZxLGOQW1mx8+gh0oDf?=
 =?us-ascii?Q?xcU++kV0WrIe+ePSkNgkYVrt5pWEmM21tFY26HJy9UsdGkp28Ppl8MYFWBXl?=
 =?us-ascii?Q?bViwWQEtxswuxls2eA0ziOmrD+TScQL3ua2Xw72qwCZjRzfhO608U5nrosgS?=
 =?us-ascii?Q?bQ9/6JZozPhXgI3ssflJ9gbxBkwLFZxSRWFdqsGOpjKwcsyJfINsTnRy05LT?=
 =?us-ascii?Q?8PQilBKiSQ3E6z0RN3VolI6EvpXCgWGxpX3IeWFYPaqPzO8ZdocolCDjRHUm?=
 =?us-ascii?Q?BTGDJqind3wWJ/lOXtiExyc9I93EpVQv/gr+PUq3dX9i32cAJ5CKGJemN6/c?=
 =?us-ascii?Q?W/Q0kYlqn6IkbYpn9hcuWJjnmB+lUzMSB0CN7zXhXaGs36mq5VVurRYdcxtm?=
 =?us-ascii?Q?1N86IIpx5T+pGaSyPBbXYyxXjntZzu6weKrAJbgERSJAH2Md8uVdeHAzZwat?=
 =?us-ascii?Q?5wd4wnTjTTy46BgTMWu/vTV90Tq4da8Fp0XQ5VrW37pjVvyrS+fXqrd6rEhz?=
 =?us-ascii?Q?bEn7HTwyH0W0WDLjI/pJDRFDmqr+wwdEx3InjSuvI7Ap7QSyLAZhd5SCg3Ms?=
 =?us-ascii?Q?aru2ZVBzveAzX1UU3QPkCFh5rSWaYjbsVBn6uSoBcLM+5+vebWkALLXhdxbM?=
 =?us-ascii?Q?n2TWrN9KbeTWjIn2XoF+KPxdg11Usq4BTkdNFXwwP2iomqdCCIFh7Dw0UDrg?=
 =?us-ascii?Q?Ul2X5pq0+mVixYkOo0z7+BWG7eqTRaug2lFAmD2xm6CjKRSH4Jdsl0M140P5?=
 =?us-ascii?Q?apuXoGoJfQK/Cym+5/Wof66UYEQnzeB7NNpZ7RJ5MSnqKznXZZQqCK+iNw5j?=
 =?us-ascii?Q?dxfM2++ktS9jhT7qL1MzbncVx9yQWDoj+bm/4K6EKWa+piPaokU6KRKWASaO?=
 =?us-ascii?Q?x86py6+78U73hCJv0MdUQ6kaELgw7uXozsM4i5x+uppxE9hTEEGtfadaWGJW?=
 =?us-ascii?Q?RPgjXPf6PnvZu5W1yRwMHUgkrhXBBemxoKIvWEiqaDc6yRArVESDNe4pzZO7?=
 =?us-ascii?Q?Y/XaTZyhEcqAsVXoV2bg3fDQAOrCmmfRDBL3Iau2U65Ce4/HFxAHmCJpltFt?=
 =?us-ascii?Q?5Jcx7ly5S3qcWa724p0rGXb6/hNhqxzM9YowpRkodbeMDm+/341xhgjuPm2I?=
 =?us-ascii?Q?tkZ2HA0H0w4YfUHnEi5soL3v0Ysr1vwhvwedPkzNqePXKSNeN5QW5H3TdI+t?=
 =?us-ascii?Q?L9jl4gOVC5wPyFV6UXRtU9/AoTdPXHkQCuQTRzPGA5sK15tzrugWeM7nr3fb?=
 =?us-ascii?Q?dok4dB8CqRA0qocK+wQRUTesdaUQhSog1bAnA3J8g/ZzuyWfi1eFGV/QQi/1?=
 =?us-ascii?Q?VSieQqcZMP1brSuwAJ6szIj1v0ubsBomrXMUeJbIAljFIy2F7zfxGbCrMCAC?=
 =?us-ascii?Q?NhMPRe7WEUbGKcIhrGkfvzu9V/C7FANVdC/vymBPhYDHECMBLW5m/N0eXGP/?=
 =?us-ascii?Q?4Dr1oROVbDrTZ+BmQzskSvNQHyGj5A4E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:51:07.3843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b584e4ad-bc75-4eba-bc07-08dca00d6b49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489
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

Enabled the default utilization of the NFS command on Versal2
platform to facilitate booting images through the network using
the NFS protocol

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 configs/amd_versal2_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 2d611f84cd..bbe7db4fb3 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -46,6 +46,7 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
-- 
2.25.1

