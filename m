Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F203AC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 11:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B1F8860B;
	Tue, 11 Jun 2024 13:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EhNrrKfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC73C88617; Tue, 11 Jun 2024 13:07:12 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D69628860A
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/oKZuCe9PhxVfDsJ1ErD+C8mrOFHEsZGuiW5xPyuCZ/KgS9W1gQzQkwkYMXtEjWtLWx5OCywaHwAq6ZHcIs1Y6wAeKoe0/Uf912FiI+209Rcb7VIMX+gbU93UHZ5UFSX/U7pWO/IDsGeIwIlLnow4zWuIPPBwuB/VqCoG995gUbqGwDzbnt1L3aWPNPtmzMt0+5mUH49K5HD+lYvpSCeIXqRrjC2/xHAVzMN6rPfXRZxWb+jjpn6KcD8bjK8ia28II6iRKxu9peeGWiGM1d8PKKu095R5CY/Xe4M0tyxuC5wcjHW7ANoj0HD4dmNXS/3vn+jVRxZoan9Mo5+hVlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppPqJd/OIehwZsLuAW0HCuiIyvpZPdd7SR7yryeUJI0=;
 b=bSphtrFz1eeuMTa+VQG/GGT7JZneRh32R7y/kvWX78FnhlxST3DV5vvUIzeLWPgrYw6EDJXJ1zri5d1AUyfacZ6ff/N42y2JENeVU84wm58ySrrBWJSL2/vgAwUi3s3FYUvxaNk/+sCEZbDBCWhyiGBgfIZhXiThZqfJmxBJBmqlfj32dLyeUJNwwLgF6kj9j7FvkJR2nyro38MYupdcdTVKFM11HLmINfGl2Ufpw6F/qN2qnjIhLZA0AFBfuTEbw1Wli9j8yQG7PuOHgrtErCNGxshV7Ib5/5V2ECsSp86aZ+IFu9tVejYuCvaDEgSk0KSAHRrviPNVz9Ghn7h3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppPqJd/OIehwZsLuAW0HCuiIyvpZPdd7SR7yryeUJI0=;
 b=EhNrrKfkvjv3i25ldu8+n43j7AIQoxhvSFAQWuxySOMbV0IZv2AFioMzUcKBDXOnZTstYoNeE8DEKgCYcFQlUUVyBKoBXlKhb7ammVoGbYxFDbh/cok/A+nGxLSbDjC2l4DHch/CkiXrIKcfbn8H04P72u82KYPEYXBXZILGNhM=
Received: from PH7PR10CA0018.namprd10.prod.outlook.com (2603:10b6:510:23d::15)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 11:07:07 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::5) by PH7PR10CA0018.outlook.office365.com
 (2603:10b6:510:23d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.26 via Frontend
 Transport; Tue, 11 Jun 2024 11:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 11:07:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 06:07:00 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Martyn Welch
 <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Enable FF-A for all our arm64 SoCs
Date: Tue, 11 Jun 2024 13:06:58 +0200
Message-ID: <5a850b1558fad0f05c61de82110abe4c0e7fd2e4.1718104009.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2632; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=2cP4W3oF1VIPbfQfHddUYAVlpnL0TzT5IWWwyHj9rr8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQM/TMXGmNk0/w4BLvbWqK+1gg3KMTe0TP/ZH6v5kRZ2
 hcv7oCOGBYGQSYGWTFFFmmbK2f2Vs6YInzxsBzMHFYmkCEMXJwCMBHbCwzzXWJNtPXi/drzVm1d
 o+4yk1ej1qqRYXqJOX9L4+WJSbbnit+7i6xe8ffTPwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 766764aa-a631-4ae9-6a7b-08dc8a06a20f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9JMmTTPCCQKIaE2DpJstlyuMTx4ncvL/aPjOC8FCehyi6cR9iiCQtrMDxu/r?=
 =?us-ascii?Q?EycbEAZlRSa5ETyfZkYjcMfBjOqyKJ4Fl+GkJVDEW5z7ATd4oD8T87ltcliJ?=
 =?us-ascii?Q?yQZ+sGPZUgVnJYyBcYgS1fLZnzSg6QGxJ134epu5/II1f864eyGuqzspSA6t?=
 =?us-ascii?Q?gwztd8jYWO/z6OCRdMmC4yF9KITheoaqUI7yNE0TdUhV8f9Fn8mchQMmZkPG?=
 =?us-ascii?Q?jN8fP13NgrtdsaHcW7kx1NH04ubIWOXwt8+a+YphwAWkI2EGOuN2lM4+kgmu?=
 =?us-ascii?Q?DcU+dNVKPcfFEJermXsWc67qRjopQPCQoPERuHyNDTSnaiJ3DqWHSR37cQiV?=
 =?us-ascii?Q?nXTmKH/up5528fJTS/VcmMAHF55pHGStjVVyfrA3fEYBYIG+Cdzh1MfaVGJY?=
 =?us-ascii?Q?vr14NWLTnNiknJcUhAD30cMLKXvdEncV2ZeSuYtdh2fwyKxEVOjbosfTMq30?=
 =?us-ascii?Q?HVqitpDf3Psi7ztYhTuNRHSn1/sPkbdMwaBwxrohX+k95UM8Bacqmm8iF+S8?=
 =?us-ascii?Q?gWcc8g6Ffwontzk/UKAZkFKrKnOEdufZRepzPP4CDcmRIAtXaqD6dEMI8xgJ?=
 =?us-ascii?Q?ZUtk4UjbeNBX0qNsmOrPAH2wD9diOP0STmLV4PWXq2U1kQF9/9uH4iJi9HrG?=
 =?us-ascii?Q?6QSmZIe2+88fsIxysf6BDJeMzBulrIxIV0I9zrZ1ZI2axPf4hZcOWFzvFdqI?=
 =?us-ascii?Q?mmQCQD5UoZaq1mpXWnnNCDCD6l9ePseBxNB3vY1sE6yjgEI5QSBMFnC8D/DI?=
 =?us-ascii?Q?iDsJwffRnFhhgXC2lIJJ8QobHsVe6MKBrWtGOlIYrPwtXs5qxVz26knaDg8+?=
 =?us-ascii?Q?M9FtVcqi6yWDfD0deW6R5AwLt8U/ubSapAo1sJJ2KMfQ+/r4nG3PXIWmCsTT?=
 =?us-ascii?Q?+7FHrIkrIqvnI97do/cjLdYh8SEvYeId9i77Hti+Z0PJS5Za1MovU4BN5z4i?=
 =?us-ascii?Q?7omJuj9I7Lj9PiR85JVsYYT5ajLDZzPfEINQXneIiHaQ6B6iXHGkYe2QiUzW?=
 =?us-ascii?Q?fGje3Che7PE6aizoILgg4T7iKBVl+YylarcqhUMVoDaaLPdl8E93RgBrbyyo?=
 =?us-ascii?Q?4gHfT5vTcjGYzVxhK1IVUTMAJfAPsXDpPQqthW43Pk9owefguF9JMAR4p4Ef?=
 =?us-ascii?Q?7FRBl0fbzOKLG4KIxisK9fbT6iQyLNE3UUrtgUjzUeQnaw0cCjp7nByXoV17?=
 =?us-ascii?Q?oUt4KZ1RpfQWXZ3Ahlq3ZHTInkcHDds/3D6pYIF0tqSpHBSK0RPomRcCvZbX?=
 =?us-ascii?Q?JAsl3n+msSNcbOzXFfWH3bKNY4EuLPOYHlVuPWC+dkfiOA9CNm6I9hEvElSj?=
 =?us-ascii?Q?PFdvm7l1oDFXcuA9/Aa6aSk7BMlVkoYZRs9wG/ac5mLWTRlvx2J97gAESHbg?=
 =?us-ascii?Q?VWNLYAzxzBPsaI+cHr4NWWQt/Y8nSwTp4PIAUg6DI/HpGMDviw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 11:07:07.1874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 766764aa-a631-4ae9-6a7b-08dc8a06a20f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
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

Enable FFA_TRANSPORT which also enable FFA command.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig       | 1 +
 configs/xilinx_versal_net_virt_defconfig | 1 +
 configs/xilinx_versal_virt_defconfig     | 1 +
 configs/xilinx_zynqmp_kria_defconfig     | 1 +
 configs/xilinx_zynqmp_virt_defconfig     | 1 +
 5 files changed, 5 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 6e4adddf2c02..2d611f84cd93 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -73,6 +73,7 @@ CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_DFU_RAM=y
+CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_CADENCE=y
 CONFIG_I2C_MUX=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index d9e2e050ceb6..c869450e119f 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -72,6 +72,7 @@ CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_RAM=y
+CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_ZYNQ_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_CADENCE=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 95a671db363e..5dd5fb1c5477 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -74,6 +74,7 @@ CONFIG_CLK_VERSAL=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_RAM=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
+CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_VERSALPL=y
 CONFIG_DM_I2C=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index ba42f0c78485..69a5468f6fb0 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -134,6 +134,7 @@ CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_ZYNQMPPL=y
 CONFIG_GPIO_HOG=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 9a71fce4c3c4..396bff927dd4 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -134,6 +134,7 @@ CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_ZYNQMPPL=y
 CONFIG_GPIO_HOG=y
-- 
2.40.1

