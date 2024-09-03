Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E444CD342F
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 07:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC52088C50;
	Tue,  3 Sep 2024 09:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EOjBqo1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9859B88C53; Tue,  3 Sep 2024 09:48:33 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B5088C4D
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 09:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frCSb4jGgs1nUlUgg0iigAcPUA/ByfCV2cEy8cLki/+8uFJJCJSQgCHn5uDdMZYy1qN9EN7UqPzE1hpi7dkqYqbXr54KCsSvy2To1xYChdPjlmLCYYvRkkbttnj7fkTQ0ly6HfXOdXPv+yj+8aP8i9zA616qE9BRvU3grwSJkmjyhmFYsTLwl5/jCUykvd5hclyDpgF1Xvw94IUgZN9Kio6xxvsdtEgJ5kxUghJ8q0ZTxXSLLfJCHkfAoH9rV+GRuduufiYr6lp7ydfEDF4ej24ETnZo4vRUFfV3ryzoPnxRw53XRwvu7EhNHnURvIAagrn6AqOy4skU743WiL0ktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+jhuOLkQ2T+6CMW83XenNe1WWXld64Lrl4zMH4amrs=;
 b=dQS3owmKU7qylqop/NXEkCOGZDGfzKAXnR1La0jdpVRkfTnxUZOxwbCo3oHy3VFI43rbxuuj+S4fH6ugsrHT7iMYUlESaB2WeJ/bjXS18sBZUHHIGZaeXdlglyv1dj/4hdTbQqwTpXzCiOrq1TIssf5EnT/qCnub1Y7uWdtNCAFJs/6pGFamFSybn//ec3FD5PzuE1RaiibhaxzQxo+jUGXWI9ZXZyXGUrdbiKlbVqVlCjfTI7JgIiYCGHPPU1wskT8oxIK8NjXGivtoCrjc1r3P+qsVQhARR78ynX9vpn0M8JHnPxsxbYzktuCrqWITQJ2dBUuyBybSNDuEvpxtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+jhuOLkQ2T+6CMW83XenNe1WWXld64Lrl4zMH4amrs=;
 b=EOjBqo1RHFbqxYykKMz1k+h5TFn8O0mOREwagFogCS2PiNMXdsI7Jpy4uKHAyPH8nhX6wj7jkgI99IiamrUG5LSe1tWsZSe1ne6X3rorMg8eoHpXsmXZ5iHXyfEmyqYE7+YBCTsVjqcfKO7r83t4wWml/xWdbDjxdBLxQXpdhcw=
Received: from CH0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:610:cd::27)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 07:48:24 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:cd:cafe::51) by CH0PR03CA0112.outlook.office365.com
 (2603:10b6:610:cd::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Tue, 3 Sep 2024 07:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Tue, 3 Sep 2024 07:48:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 02:48:22 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Martyn Welch <martyn.welch@collabora.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Enable SIMPLE_PM_BUS
Date: Tue, 3 Sep 2024 09:48:15 +0200
Message-ID: <b9f4bb85be502616edf3be2b79e52a0e2c03e821.1725349691.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3410; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=mKZ+LeXPdaShzE/FykaPUFa+1x76ryn+it9bl/jSAeM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrRr+x3Y37w1WWVk8KK5zOCcelR+S9WvR598Wh+kNDM/X
 3vniWlaRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIjXyGWcwsxtwZb/ZJKe6U
 OJmQZCU14fJDNYb5TlFnN51JV3YMf7RPsqFw3auuooURAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: c6acb4ae-5bd0-422f-74cb-08dccbecca35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FjTAvQhUE+Vb/W+LUr40KORuwKNQozyEQHx2vVRT1Sv4ef0kTWIS/31Z4lZ/?=
 =?us-ascii?Q?KfOgsmMVRMP7Z20dOfFjOU3di9OMibwF4TacbVwiKVX6XPl/4AlidtmiypFK?=
 =?us-ascii?Q?uc0V71xzjz8aUaxEr12OYXwt4qldCILR8G2GHoc0WsSRTDJrRtCezZPXf0N2?=
 =?us-ascii?Q?1Vv4xE9YJFaNdPJTQYoPSjkkADXDOv57FeDCbOwkua09MObWxWxAW3B14P09?=
 =?us-ascii?Q?7OhUgkderZWxW1XwrA7g0+hoJpxB2MQ0xrHCZxnwKNleLLAyjS8S4jPXHEEG?=
 =?us-ascii?Q?0lzNQYa9KT9RdGGcGFWn/g5QcGVFblTR8yeSIdYdEMVhvNykBo7dLu+fE18n?=
 =?us-ascii?Q?/yovbFum4jlJe7nB+uIplGCjXqPkWfYjwDclhY6PP5qXGMBv3Iou+MGZSJRE?=
 =?us-ascii?Q?SzAx9hNKaED7f35nfPiWhqfqQBJztmgSvRpTKudGowWgjVE26Wzloh2y9b9A?=
 =?us-ascii?Q?eVeKAeddSVrh3RmLMpflR6uPBCYP91JMqzcHn477zP+G43vdQS7e4M1fvDS3?=
 =?us-ascii?Q?HlAB8Ci7368kEnIDeIdwTrUo4oHVTCcpx5pvyhCoY3C052bJ0ANPJFHFkmGR?=
 =?us-ascii?Q?79wL4glfWxOExxmaYcWhepxkTL8LQP9N6p4PYzy1COQOeWj0z5kQtTZRytme?=
 =?us-ascii?Q?vntOFxaSqL/zIj6onNZkwNKtxdEaTXbaHMlYaE6Bf7t8MjK6rMg3ne6eyxjD?=
 =?us-ascii?Q?q4E0BtdKw8xdv+wI/d8JM/6639KR0oFQy62GXt0k+Z448cdS8joXxrX66FBJ?=
 =?us-ascii?Q?NAhPbLkiDkXEf2bBwQiyGnUfK03PrGIObp4w29fbgn7bTZgqXZl1FEeIg3N1?=
 =?us-ascii?Q?TOumApJs4Cs6zHNGJ5bYh7K4CchATS8DkA+e3LUEap8H7RosIuUfseoozVKJ?=
 =?us-ascii?Q?UWHiM0vbUimmD9w4YHQwUnRbkWNOb5ZIyxEVeJIdIc0JG/6L9w4lUvVBMR4A?=
 =?us-ascii?Q?WHfiQZ93MPnRo0TOscCJv8aA3/qFNz7irYHI5Jw7MbI65hn31v0+Zzqk3/60?=
 =?us-ascii?Q?L9ta0+EtEvlUIC8d/54037biIT4s03Eh1gVxfXfVvx8nzcB4cTw6iNMZSrNX?=
 =?us-ascii?Q?4PkfjafennM2pXIhZyu6M85/0jL6hAcgUpf1StYHag2JFzH88KioaYuX56F1?=
 =?us-ascii?Q?w13osIwRMxZtBU6hYMST3cM9bICK3cZliviJxILGz1CkJR8lSQc2mm9S90kF?=
 =?us-ascii?Q?bf5jNbvGgrkApaAydpShoe8BDagpjpEsCLMmxSY1gxfN0Jia+boUW4x7OBuD?=
 =?us-ascii?Q?SDghrNFZLRyC+nGW3Xg94IKPAAOg3KEFyRjh1j2NJNJjtmJjNxqBSqgg8/Zp?=
 =?us-ascii?Q?MdXlV93fQ/lBtRzQ5QTPrB96fxv6Dx4KVl0uBZACbWtCM/lQr0+KihbATp8c?=
 =?us-ascii?Q?/0moWCIN28Mv4QgHaGUrKkXM/YxhmFYUx7vOtG+1dq6iCA1iA1zXEyACC9+C?=
 =?us-ascii?Q?Bs0n4JsaGNCfzGePdrBwE7fPYLT5ZU7X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:48:24.4051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6acb4ae-5bd0-422f-74cb-08dccbecca35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
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

Enable simple-pm-bus driver to handle case where axi bus coming between PS
(fixed) part to PL (programmable) part has own clock or power domain.
That's why enable driver to be ready for this configuration.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig       | 1 +
 configs/xilinx_versal_net_virt_defconfig | 1 +
 configs/xilinx_versal_virt_defconfig     | 1 +
 configs/xilinx_zynq_virt_defconfig       | 2 ++
 configs/xilinx_zynqmp_kria_defconfig     | 1 +
 configs/xilinx_zynqmp_virt_defconfig     | 1 +
 6 files changed, 7 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index c4bf77186cd5..78f6ffcc3a74 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -72,6 +72,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_TFTP_BLOCKSIZE=4096
+CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_DFU_RAM=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 40a9b16b9cf5..776af9ae29fe 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -73,6 +73,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_TFTP_BLOCKSIZE=4096
+CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_RAM=y
 CONFIG_ARM_FFA_TRANSPORT=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index dc1754f6d18a..0d4591411e1e 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -72,6 +72,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_TFTP_BLOCKSIZE=4096
+CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_RAM=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index f8b6a3f1aa2a..b2921df1d0da 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -94,6 +94,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SIMPLE_PM_BUS=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
@@ -138,6 +139,7 @@ CONFIG_PHY_XILINX=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_MII=y
 CONFIG_ZYNQ_GEM=y
+CONFIG_POWER_DOMAIN=y
 CONFIG_ARM_DCC=y
 CONFIG_ZYNQ_SERIAL=y
 CONFIG_ZYNQ_SPI=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 4c66c536d0f6..5a07edf5cd21 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -117,6 +117,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SIMPLE_PM_BUS=y
 CONFIG_SATA=y
 CONFIG_SCSI_AHCI=y
 CONFIG_SATA_CEVA=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 1133134e3fee..491206998da0 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -118,6 +118,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SIMPLE_PM_BUS=y
 CONFIG_SATA=y
 CONFIG_SCSI_AHCI=y
 CONFIG_SATA_CEVA=y
-- 
2.43.0

