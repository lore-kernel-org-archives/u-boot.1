Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E41CCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 06:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C56C83C62;
	Wed, 12 Nov 2025 07:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Fyju/fAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC8AA83C7B; Wed, 12 Nov 2025 07:48:00 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF33983C4B
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 07:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZSxZUPq1VLSdTg3JoQe0LEWHdzdtjjLn3TbauXzo1huwjpguhx1rt1ecmoJwB+cqT7kNYLDxO9rrw94vwDzIaJ7tvs2cAHIBuxLy+M1thXG9Ve9XpXK4Y3wypBVNbp3RU05wKHPvaMMQljBFIZB3ssCNPfQEDjWqQaJ0gZyhjpmhkBVDYxdPCt2jenXmietYjIMcGjtVkIzqzGNBcRIconUTB2MojjnbaJWrhUV8RvElbvFEZCyLTsefa600dMaY7baZ+lefcALe9ngIj/tvVtflcDgxLsSbKXW4FHZriY31lsB+dUk7JjPtk59aOmflLooeaxr2ZpGop6OcDKkJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKNiTjQmcg6e3F8ihFYLpi4asFuAdwHU+4UM55hTixk=;
 b=aE591srE0oonPZHWpaOFSZayxQSRDqvQDgwV5/LhnGokHb0mzEiHcHPhU5ew71svznl5bK1zei0i4S/oq3Q6nQPtYkWSZjPuHqjqWVVUQua9fbaaKRddqPyu5AMdYsq9c8PwiNObuRxgr1xAbH/tnXNVxjYb2D3OjJzhzhfN953GBmh30dAxNNKaZR+O4bi8/4nQeLQSbMEByfEnB76KWBhrWTbBkH5UCmJ0adlJfoK+53J98bKQDWMQtDxeVSm/TfUKO9Azyi9uIg6PpxF20nQMHoRlIPJ+k7tTmQA/HCvOZwlNItZkQNF45LgXinmpFjJ7zw5/IyxS6Czibl6xcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKNiTjQmcg6e3F8ihFYLpi4asFuAdwHU+4UM55hTixk=;
 b=Fyju/fAnUvJgTdyeEEx+fH5IFx3mQHihjPyXWBqtYqqfRztOutCk3WaOFcXanlc86ZUbcCYfDrVS1fYOzuNFV+NhgBJGCqo0rj0LC3UzAZH4ZAWKUqoujpu5pqNjckvZEXjtJob0CxW0V5/ijUasMjGH5LkZDnDKhC/C1rASXTw=
Received: from CH0P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::19)
 by PH0PR10MB7028.namprd10.prod.outlook.com (2603:10b6:510:281::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 06:47:56 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::8a) by CH0P223CA0008.outlook.office365.com
 (2603:10b6:610:116::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 06:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 06:47:54 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:47:45 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:47:45 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 00:47:45 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC6lPoZ2217584;
 Wed, 12 Nov 2025 00:47:41 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <c-vankar@ti.com>, <u-kumar1@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <peng.fan@nxp.com>,
 <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>, <jm@ti.com>,
 <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v3 4/5] configs: j784s4_evm_r5_defconfig: Enable configs for
 PCIe boot
Date: Wed, 12 Nov 2025 12:17:24 +0530
Message-ID: <20251112064725.1049199-5-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112064725.1049199-1-h-salunke@ti.com>
References: <20251112064725.1049199-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|PH0PR10MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b142ef-361d-44fd-6f06-08de21b76832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+aFqG638YhMf5aMRfyeWWc/uBXm8G9/ycysdrWEvDGqJqV2jtpT7ejMYZXNO?=
 =?us-ascii?Q?GZLcA3zlVst870CQNcT5NMyU90QX3jbiL3d7gLxTwH0iGNnpZwHvDifj8op9?=
 =?us-ascii?Q?nyDDQRGH1zRKZ1mAoxhBmSR1eiMeNg/c3tHWUhwp5YLTrZb2HuhvBS/iUJAZ?=
 =?us-ascii?Q?PYiJZa6iB+daAVz6+1g4xkVGcy0Zr3vkCpzsFSeEbBO4iO7zTQsjnv9mUNkJ?=
 =?us-ascii?Q?P/ykCd6GsZO0GeS9XiQF3NdFcSWoijtyocSNyYHaUyY6bnDZQnk0wffaHNCf?=
 =?us-ascii?Q?hA41GV/LnDS4yLkSP1MdE7XoYrmLK9VPB1gxag/RafQZlFNSl+EJvoHpETMx?=
 =?us-ascii?Q?8UIGsGa0XnKKAcA8kSZ8Y3RF/1qg+XMGoV42f8OnlBaBP+6I+bdyv/XEsHcp?=
 =?us-ascii?Q?7EdHbF1VMvpO1MZz3arUJFTUZe2MdY4dZYw/eCXa5faV0+b3y77LtVJlTzpd?=
 =?us-ascii?Q?viFYC2Yn/AEwzxozw0OBScHmLLXGA7N7SrTSM/GjVc90fOG+ZKUgcNehGqjB?=
 =?us-ascii?Q?Ko8wZhFn0OJrSnItNSwrtpOleT9FJFBRTwUOBsB+vqPMR/vQcryiydS9XI+9?=
 =?us-ascii?Q?SeBelkFc7bOnwHKQPZTwBI8s0Ep+bR+iUc8NLkRAsZNoc9LfbzErWAGT5pTB?=
 =?us-ascii?Q?Q2nTZ/TNMjD9wjR87ysievTV0J2jtGWavDNjfq8DRYJJsIgwFXSXxV1HgYjn?=
 =?us-ascii?Q?FfOfMXbjF3JJhsrk9mw2+GhL5oiXMJ3+flCv/i0Qtso7tzPebsUZU4XWgxFz?=
 =?us-ascii?Q?r0CrGK3a7cN4Lt0Y4oaHiHpkPIAXoq86C9gJ02yrfxp89gewN3NxoE/i9uQX?=
 =?us-ascii?Q?ll4w/xPLkW6pQIwWOwwVicn/DozrPKalpxOa1DrU+OcUkoLEd2E8FG0arntc?=
 =?us-ascii?Q?IM1jR2LNo9Oj81g564WeJKULeAxStqIxsWXlzkjU0FJI8V0Ss16cwMeuhN8e?=
 =?us-ascii?Q?1iJ2NVWONHaYLIL73akmIX3kit4FQ/NEuMQCXFCj6lw1LU/Z/tYIEW6PmwjY?=
 =?us-ascii?Q?Uto0KZEyuvNOD5BHqzvWlS6rnMQkIGqvTvhMIYwqZrSKzVRu0cb7UR22O4pw?=
 =?us-ascii?Q?/G4UgIDP7s3TnurHbTNBxGyKFCjinRTMDWAwV/7pWTwC3ATIG1K8sVHReO7U?=
 =?us-ascii?Q?gnx+VpaJE+AVo3QmH0ErSV+vUY+tBaUKwuefE4rEf3lCJ3SL4qdts8tiGKf2?=
 =?us-ascii?Q?yNoe29yQwdSQ9ovu+4Him00fhxLaokmaz/Yub3BUfbfTjIePGeraL8cEmYZp?=
 =?us-ascii?Q?IfEt7fJydKI1+ezHGXib1hnB8YUJBm3Zh2rFBjCjc0kj1XMdkrc3NvBMWgp4?=
 =?us-ascii?Q?EHLY/BnDXGbTpwvndKwblz1VMMdvAvmv3qmKwR8qPuV9riyjsnABYRqtVpkh?=
 =?us-ascii?Q?c3c3GRnnoe+CmNfnMO+jVKI/J2b7eivSwlg4XobvuGuVvM7gfzOCuIoYxV1U?=
 =?us-ascii?Q?hdIjlKe6b7LwXBAELUAgWjqGzJ/X/pjSsKFqXZ3sT77Y2b8ieUP1cRhBv3VA?=
 =?us-ascii?Q?OP1dY3B71/CJPgUKcPDkx5ZLc5Wl5QgpY95f1DLk86L+DQMXmM0pzbBtHIvz?=
 =?us-ascii?Q?3AblVaq9jgbq7qdzeLyf7yBf5HC8tGZfS7vslFx1?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:47:54.2886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b142ef-361d-44fd-6f06-08de21b76832
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7028
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

J784S4 SoC has two instances of PCIe, namely PCIe0 and PCIe1. The
PCIe1 instance is used for PCIe endpoint boot. Enable the configs
required for PCIe boot on the J784S4 platform.

Additionally, enable configs for J721E WIZ SERDES wrapper, Cadence
Torrent PHY, and MMIO multiplexer. These are required to configure
the SERDES lanes at the R5 SPL stage for PCIe endpoint operation.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/j784s4_evm_r5_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index cc340a2fe76..a69a253ad12 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -52,9 +52,16 @@ CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_PCI_ENDPOINT=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_PCI_DFU=y
+CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x80800000
+CONFIG_SPL_PCI_DFU_BAR_SIZE=0x400000
+CONFIG_SPL_PCI_DFU_VENDOR_ID=0x104c
+CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb012
+CONFIG_SPL_PCI_DFU_BOOT_PHASE="tiboot3.bin"
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -122,6 +129,12 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_MULTIPLEXER=y
+CONFIG_SPL_MUX_MMIO=y
+CONFIG_PCIE_CDNS_TI_EP=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_PHY_CADENCE_TORRENT=y
+CONFIG_SPL_PHY_J721E_WIZ=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
-- 
2.34.1

