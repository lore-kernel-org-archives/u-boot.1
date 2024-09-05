Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD31CD4848
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 03:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8060A88C1B;
	Thu,  5 Sep 2024 05:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h/SgfRYE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ED9F88C6D; Thu,  5 Sep 2024 05:23:17 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 650F8880A5
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 05:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPOT3++SjrcxC76eGwF+e7c67OH+NV4Q3g3yX7yvmbGgrIyhc7ngyzK4sJTKZS31SBI9MNcrG38aK78AQN9o9+1lX1FHfgmOiK2ppucps56sDO1gKXIsz0OEtCQJL+VJrCmjzX/dj21jy+pGga5rEH+kKAYQWBh4hhixGeru9KO+LbeZlGCvlouOWlNUwEtOiba+9p4lu0ignQmHNAtxNpcDsNImwiRVtHXLV2LvkKV0LUnfZ3YnboegxVHH2ZhRM6nI7K8qVOcOrdekcuF4oMjAkVtNY4TNF/G2FzrHPWejBus7UPs0nJd2Mgqkqlpw4NLAL6Rw2GlDTeH7mP7AHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kl9rSph8iwpuhaHuhoLv8PXEEUgvUdKr+19lDpHwaSM=;
 b=uxHGglGmq07MCyFWNHllZDEXSxyG3JAlZbyKUBDmyNOFM7iWtXMwKD4AdKmaeVAAq26xyMXulyPR0FXwtLZHO8ycuCsaQlrTemzj3rI61jOKmi/mwzSr3Kf6+uXiz84ir7Dlt16NDGn+iqh80wd+fApjo2pBR/hxThPButfHVLbDp0iaXIjdWfKl3p8D6BUY/8s8MF7KOJZl9zeS1jazdPJmERAy7Mhbx3d86GpuVMpwd+5T6ovt92wIPqS8Mp/mhiXn5VCv8zgkEmGsKWNjIGYR2PbLX/oYfgFHu9IJ8Argk865YJbbP8QU1sf1fQdwRQBdoq29EyUo6Gwdt+0tvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kl9rSph8iwpuhaHuhoLv8PXEEUgvUdKr+19lDpHwaSM=;
 b=h/SgfRYEdVlodq4z9oE70ZUeuo8VSynnzs0nsBMd3o20uxgWe+FKzzpAQAZru1TXFk9D7feWDsLh5xRa0oAp/m8FxbDdl+0fj7BW0jH+uSeh/7eQxGFF0hQQyZbt3SYt4Oh8CAiaDU/bDOG8kw3kAEGGHWPSZ4KQZUGjOdkaPIM=
Received: from SJ0PR05CA0112.namprd05.prod.outlook.com (2603:10b6:a03:334::27)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 03:23:09 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::3d) by SJ0PR05CA0112.outlook.office365.com
 (2603:10b6:a03:334::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 03:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 03:23:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 22:23:03 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Sep 2024 22:23:01 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>
Subject: [PATCH v13 6/8] config: xilinx: Enable the SPI_ADVANCE config option
Date: Thu, 5 Sep 2024 08:51:44 +0530
Message-ID: <20240905032146.2470396-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
References: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: cb962f85-68a4-4184-f424-08dccd5a1103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7qQ0sdwG1aP7qn4ooTG27en2VTa+5iVzA3SQjcFZ4DXkei4eoagcsOFixbfg?=
 =?us-ascii?Q?PhTcHwf/EnR682DXjUj/WsSMXoNKCCyY/B9KWw/Z4EprNX44TDg82D0PgxhX?=
 =?us-ascii?Q?hRwNtZPwGPoYVyCpbWMLFtXzkQZ7Xt1MYpDaxwUt2NBMCg8GRyAsRgWbSbCX?=
 =?us-ascii?Q?GFi8ZAjejTT7293GZmbxUxKH1O2MqiC6hEZ4CD6T1FCoWo4tSjLI6jYtNOwF?=
 =?us-ascii?Q?rK9Zzxqj3dtZ+569SjKCyG5HBc37YIRKT6lHX/cdN9sewoJMbYaPq9+MhqRa?=
 =?us-ascii?Q?lGDPWkNiH+g/41Cn0MztQzXGry5y+WwO/bkJjkoXAj8HMJ+m5c4nYEVJC56u?=
 =?us-ascii?Q?AfQ9KOyFYzgqQO9Rw0Y3u+qGhZQS3gRs3gY4Zuoa2J/xbQT5nduzmPOQQcIC?=
 =?us-ascii?Q?4F0EQ3KM64oASKb8S03YwK0oOZLqIkGmG6YLlVJIrv7uw7q/Yro5e1c30SZe?=
 =?us-ascii?Q?g5UJZVJ7sDYUvxrnzX9R93ebMRZOOTDsFC/vUxyT98ofpeMtuOkynQI+qhXZ?=
 =?us-ascii?Q?1Fv6nszx9ULySpRWMnK+2pR7vC+8RT5mDe6Bo7gPp252Z76W+gvE7G/X2Fka?=
 =?us-ascii?Q?BVpczFP9ugySj4KODMhXxY7/IQJBlvMkBA8E0yWT3MWv3Uej9ivYbsMfclt5?=
 =?us-ascii?Q?/VFspmYku7h5LOL9wpO+h4JdNG5W14NhCWTCzu4dvcEuilni07POHRWt2l+8?=
 =?us-ascii?Q?qLNr6RZ8isC87PAoN61Rv5AbK7Xwcm9efS8SxFAui+3MLdeUhwDrOC1Q/YNy?=
 =?us-ascii?Q?jioiJtbLJZsiSUufrprvN1mHcKlPxT4KYOZjTxIhH6cUkf+9mXYb4EaZi6mN?=
 =?us-ascii?Q?mCovzkQPuT5m5KtixtSTVgRhEX2KIKdocRXuBAxiKyaZC+qdjy6A7jQXvvut?=
 =?us-ascii?Q?O7SCX3nVlT3z/yoq7nnG4FQUr2//0DQLh8V9teKPGtaZ3p1D/RbLHtLmgyyb?=
 =?us-ascii?Q?j4/BcKYg5k2/+DN6wA3e9yQ643Utg+A5hRpuuWJV+yv+jn3JtTgm3pWCqLD8?=
 =?us-ascii?Q?8yiQWnF/TJjBT2D0z45AGfPBjhfHGH5FytYON5gJp8DQx/kX4sn9jE9A7d7A?=
 =?us-ascii?Q?MuWAMsRI5QXnagt9xhcR0vyA1SKEaJqGTIfSS7nl31ejrzOOqqcnZh18Uhxe?=
 =?us-ascii?Q?G8QoDmPxnkNDoNybfX6e/tmr3qYBtY3Mh3SkzKva4fBb9EjgUng8ew7hzFLb?=
 =?us-ascii?Q?iazT0F3FDOZT2ha3cStrq3lfBGufDOy+n6o8zENYrB+BMqnGP7E8Lmwkz8ig?=
 =?us-ascii?Q?ROYBTL5u0Z02yBkgm4SRKk57l+olJVuD6/WmGNjgeVNIyPSDvjU2wZJxDsFn?=
 =?us-ascii?Q?Np1pNRNZE0lZiiWC+dwy/r6HXOwmkWaPBOixzmV321oEUGOUCHF0cal8Sc4n?=
 =?us-ascii?Q?+dn6CmA8BHXm7V9lXKrXAL5eeL+AEbIn8FuElTyIvgtkLxnyvIJ6pseE/Bcm?=
 =?us-ascii?Q?kebSVWo/mpkg/Cg6PsSgQGEYnR9iztJD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:23:09.4271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb962f85-68a4-4184-f424-08dccd5a1103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
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

Enable the SPI_ADVANCE config option for all xilinx platforms, as
this is required for parallel-memories.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_net_virt_defconfig | 1 +
 configs/xilinx_versal_virt_defconfig     | 1 +
 configs/xilinx_zynq_virt_defconfig       | 1 +
 configs/xilinx_zynqmp_virt_defconfig     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 40a9b16b9c..7225839437 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -126,6 +126,7 @@ CONFIG_XILINX_UARTLITE=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SOC_XILINX_VERSAL_NET=y
 CONFIG_SPI=y
+CONFIG_SPI_ADVANCE=y
 CONFIG_DM_SPI=y
 CONFIG_CADENCE_QSPI=y
 CONFIG_CADENCE_OSPI_VERSAL=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index dc1754f6d1..12a2cd03c0 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -127,6 +127,7 @@ CONFIG_PL01X_SERIAL=y
 CONFIG_XILINX_UARTLITE=y
 CONFIG_SOC_XILINX_VERSAL=y
 CONFIG_SPI=y
+CONFIG_SPI_ADVANCE=y
 CONFIG_DM_SPI=y
 CONFIG_CADENCE_QSPI=y
 CONFIG_HAS_CQSPI_REF_CLK=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index f8b6a3f1aa..8e49c3b3b7 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -140,6 +140,7 @@ CONFIG_MII=y
 CONFIG_ZYNQ_GEM=y
 CONFIG_ARM_DCC=y
 CONFIG_ZYNQ_SERIAL=y
+CONFIG_SPI_ADVANCE=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQ_QSPI=y
 CONFIG_USB=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 1133134e3f..9ffc681aba 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -203,6 +203,7 @@ CONFIG_XILINX_UARTLITE=y
 CONFIG_ZYNQ_SERIAL=y
 CONFIG_SOC_XILINX_ZYNQMP=y
 CONFIG_SPI=y
+CONFIG_SPI_ADVANCE=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
 CONFIG_SYSRESET=y
-- 
2.25.1

