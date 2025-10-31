Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AA1CCF9EE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 07:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8448838E7;
	Fri, 31 Oct 2025 08:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EgyTrwHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8244183946; Fri, 31 Oct 2025 08:38:31 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 600D483936
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QT+thxIO/b923e3URJesY2shzdFg3uxxRdFEHnZmEJqmhHzEgZbhXrbOjTP5fYDy0ik0woLNWzqCYYphPbXpp96JYnyIpbd0PJADzi22p3TXCXHaaHbtcEe7t1rmCpsptZOJAHSBrZHo1mHzoTJaN1XnZraodstfnkbaVG9VLUxLlDm2MufZVMviz5agEYvQxlJI0QRzX9ZOKaUqSi+DEk3Y9j3C4APn5k3Daaj1dsKHMm0ycnIfGngkA/lvW006zTouUgR+hw8xY9g28smeGO8+3TRPiZrGHCTb90bKe7ProL7rUOlwnTll7KGoxkxpUY4ljx8TJbGJclsMlAz29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWMQDJ1rDZUunVZ2JDdwg0hbSm35g+uDuBxaBNpybLo=;
 b=xrF0aAZ9pBwyHMcG/BKe7Dh+eW6LBBwZJV1Ka8qVPrgfOKrnA8aNNYFpSPVbkpCrH7kOZLQB4CL+Uqm1Zu2vYrexer7I8vDKvTOAFm8EG7iPgX6DB0a+dIoJ8BLbf0gcEhL2PviII04wx24myBS9fzFbCvBUcFMdo8A2eXoxKXt5sd747v+t/DlA0eQ8zLlZaoKb6uJT4ft2F1hgJ32YJoBZAd7UiYPk9KguBhXRAgc8ip3yUeDaXbjBnGeWUe/EbMDy034mrHooDXevuFPX8uSwNbLkbwb6drCyBMD869b+uHEdQaFzJ8j48iis32r2l2rHO+tHPtbNXdtDuZUfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWMQDJ1rDZUunVZ2JDdwg0hbSm35g+uDuBxaBNpybLo=;
 b=EgyTrwHShHoXJGXxyujlK8U4/tCYXZZ7Bj737AG1+vxkcZeIJZL3z2VCJbyZrYvz4lATIHDe0KMkYha3Z/uLHe4ARHXHHM4e35FB3lnSn+Ks2K8k28kYDIHgzGM8NeJ5ZgIwYNoxgTRxGTaHEa1QKWlGdrAkAXu50kPFJLqm5Ps=
Received: from PH5P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::15)
 by PH0PR10MB4710.namprd10.prod.outlook.com (2603:10b6:510:3e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Fri, 31 Oct
 2025 07:38:25 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::1) by PH5P220CA0005.outlook.office365.com
 (2603:10b6:510:34a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 07:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 07:38:24 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:19 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 02:38:19 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V7cI963500850;
 Fri, 31 Oct 2025 02:38:18 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v10 7/7] doc: ti: document R5 falcon mode for AM62 platforms
Date: Fri, 31 Oct 2025 13:07:57 +0530
Message-ID: <20251031073800.344500-8-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031073800.344500-1-anshuld@ti.com>
References: <20251031073800.344500-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH0PR10MB4710:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b0e404-92ed-463a-a149-08de18507923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|34020700016|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?diBgo+wUrm4WbWcrSPxJREwIDOqQ7Qw8RUbwXQ0oLqOrVoD70kuW0xSL/4CZ?=
 =?us-ascii?Q?tBxv0j5pkE+lzXjDrQWr6g4OMTLNmk5KFcNb5U0zIXj+KAm+mvRdjimiFk4O?=
 =?us-ascii?Q?a3tL/CaS7T153CSPXdys11x3puYuJsaJE5AcqGZwWpyZcHDqdbQY1WCGkmSz?=
 =?us-ascii?Q?9ieWNE96189zoZTv1HtnkEk+94baB/gIKDKjKY1oeMZO+g8cNNJB/V4Ye4a1?=
 =?us-ascii?Q?KmvWmiV1V+/Lf2Y6cQy3otqUMR2c1/9wafDlIZvgKl6ykNm3EG9srN+he4bd?=
 =?us-ascii?Q?eP9guw4kKuuQW89NdyA2aI06QxYh3+eRPNYv2RPKo4siMl2fHs5QuDxpeXzi?=
 =?us-ascii?Q?4cC7G/DMHQmkTOKa5Sw5F1hiBUAFDOU5TipLjOdbhLsvCJcxch5vB6mKuABt?=
 =?us-ascii?Q?3PAmelwO6Xml2u+whV2t5rDGnWPj34+XESKj0VJySxZeiigTzuNImYo2+4Wj?=
 =?us-ascii?Q?x2/LiRmS9A4h0Ven/ukvAFU6H0CcmDUSOM5TT06JBO+a5Db/mFlT55ZpWbOM?=
 =?us-ascii?Q?aVg1TiN6bmxIMO+5Jd47BWPMHtHH8G6yYqFpGU9cAtv1vhXqJyb898tRsQ38?=
 =?us-ascii?Q?CG4SaIlGw0UKggT66Z42QuD2bxwszB9z1evgD4J7fk7kCSlwHf/5s5hX3Tqj?=
 =?us-ascii?Q?vnzXfmGYDSt0MtUfxPihb17cN1sLujhGoNT/dowzOR8mj7uXl3oVIX57jU9k?=
 =?us-ascii?Q?YEhiAUeb8wbvt8FqTLnOJCSHNgF6al4h8eAofQdbBcPjKAbZWPRKoAiPIGtB?=
 =?us-ascii?Q?zuWBrheXhbQabiZYy1PBCwYftKmoD24MF/763ke+vwts96WuGP0Zn/D6zMgX?=
 =?us-ascii?Q?GD8gakLsrYEmxd3OolGst6xtvFDJHeSo0H5x32Ww1U6pVNKLASvboNRLWRAD?=
 =?us-ascii?Q?V1S4Y692X+x6wAidZWypfuywpUlqn7cg/LyI+BGd6HY7zXnn5GkkNDigErPc?=
 =?us-ascii?Q?gy3galyAZkYtX4PSJjnUxD/52LVIcuq0APKE5v9mAZqCFhloAkTC99TnAEco?=
 =?us-ascii?Q?SS9qlezDZddiS8pIkZ0oJsj6pzzkX7BUWCmzFfzdxuXMOVRkzfeQSN0vIDhu?=
 =?us-ascii?Q?+kqQz/M6pXkpsj6+RlFGTY151JeNk9iTyV1AzbZlUd4jyWIsKDAj87p60uUq?=
 =?us-ascii?Q?zLlkeaK5ALO8043j3LuUxRG/GA4ob5apKHADkvlMjiz0Dbt7TCGgFN4UmIcG?=
 =?us-ascii?Q?4nGc2Y9BGP80U6VgWLJ19c1NGHVwhWRLsbK4pxsrqn4ARu/7cdpPNYRR7NaQ?=
 =?us-ascii?Q?+qtEJ00yRbztWlilKKS31+s9dAlrs4oS3DFTWPXovwleolOrOfk9LzucsZii?=
 =?us-ascii?Q?EZPLKC/+M8vnykCaIeqJTYy0atSPbT/Zt6o+nt3P0LrbPX7yGxNJkeKObeKg?=
 =?us-ascii?Q?yT+4iE0ztvz4+TzeSVEBo6xI58lVsORaf/hHcMyVVQHksCzJ1NcjJzV1ohww?=
 =?us-ascii?Q?i+VE3MNxF31yGKkhRwTufpDGvz9xUN6CgSWyIPg+kQzuoJF53G1AwznoTT49?=
 =?us-ascii?Q?UV0Uv3I/STcwUGI47zz/pz/ldwvIfz64jWqd?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(34020700016)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:38:24.1704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b0e404-92ed-463a-a149-08de18507923
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4710
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

This patch adds user documentation for R5 falcon mode for AM62
platforms. The main section is added to am62x_sk.rst and other documents
just include the relevant sections. Steps to build falcon support, usage
and the modified R5 memory map have been documented.

Two svg images have also been added for reference, one for the modified
tifalcon.bin and other for the fitImage format specific to R5 falcon
mode.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 doc/board/ti/am62ax_sk.rst                    |  31 ++
 doc/board/ti/am62px_sk.rst                    |  31 ++
 doc/board/ti/am62x_sk.rst                     | 319 ++++++++++++++++++
 doc/board/ti/img/fitImage_falcon.svg          | 180 ++++++++++
 doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg | 285 ++++++++++++++++
 5 files changed, 846 insertions(+)
 create mode 100644 doc/board/ti/img/fitImage_falcon.svg
 create mode 100644 doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg

diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 4dd998bcce9..8eeb90a271b 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -187,6 +187,37 @@ https://www.ti.com/lit/pdf/spruj16 under the `Boot Mode Pins` section.
 
 For SW2 and SW1, the switch state in the "ON" position = 1.
 
+Falcon Mode
+-----------
+
+Falcon Mode on AM62ax platforms bypasses the A53 SPL and U-Boot with the overall
+boot flow as below:
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_start_boot_flow
+    :end-before: .. am62x_evm_falcon_end_boot_flow
+
+Build Process
+^^^^^^^^^^^^^
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_start_build_process
+    :end-before: .. am62x_evm_falcon_end_build_process
+
+Usage
+^^^^^
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_start_usage
+    :end-before: .. am62x_evm_falcon_end_usage
+
+R5 SPL Memory Map
+^^^^^^^^^^^^^^^^^
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_start_r5_memory_map
+    :end-before: .. am62x_evm_falcon_end_r5_memory_map
+
 Debugging U-Boot
 ----------------
 
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index a07d6a4da45..da70cd58095 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -290,6 +290,37 @@ https://www.ti.com/lit/pdf/spruj83 under the `Boot Mode Pins` section.
 
 For SW2 and SW1, the switch state in the "ON" position = 1.
 
+Falcon Mode
+-----------
+
+Falcon Mode on AM62px platforms bypasses the A53 SPL and U-Boot with the overall
+boot flow as below:
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_start_boot_flow
+    :end-before: .. am62x_evm_falcon_end_boot_flow
+
+Build Process
+^^^^^^^^^^^^^
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_start_build_process
+    :end-before: .. am62x_evm_falcon_end_build_process
+
+Usage
+^^^^^
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_start_usage
+    :end-before: .. am62x_evm_falcon_end_usage
+
+R5 SPL Memory Map
+^^^^^^^^^^^^^^^^^
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_start_r5_memory_map
+    :end-before: .. am62x_evm_falcon_end_r5_memory_map
+
 Debugging U-Boot
 ----------------
 
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index dab2970a85c..1a0e5e07c4b 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -526,6 +526,325 @@ Next, based on NET_VCI_STRING string mentioned in respective defconfig file `tib
 fetches `tispl.bin` and then `tispl.bin` fetches `u-boot.img` from TFTP server which
 completes Ethernet boot on the device.
 
+Falcon Mode
+-----------
+
+Falcon Mode on AM62x platforms bypasses the A53 SPL and U-Boot with the overall
+boot flow as below:
+
+.. am62x_evm_falcon_start_boot_flow
+
+**Normal boot flow:**
+
+.. code-block::
+
+             | tiboot3.bin |         tispl.bin          | u-boot.img |  Image  |
+             |-------------+----------------------------+------------+---------|
+    R5 Core  |    SPL      |                            |            |         |
+    ---------|       \     |                            |            |         |
+    A53 Core |        ------> TFA -> OP-TEE -> A53 SPL -->  U-Boot  --> Kernel |
+
+**With falcon mode:**
+
+.. code-block::
+
+             | tiboot3.bin |   tifalcon.bin   | fitImage |
+             |-------------+------------------+----------|
+    R5 Core  |    SPL      |                  |          |
+    ---------|       \     |                  |          |
+    A53 Core |        ------> TFA -> OP-TEE  -->  Kernel |
+
+.. am62x_evm_falcon_end_boot_flow
+
+Build Process
+^^^^^^^^^^^^^
+
+.. am62x_evm_falcon_start_build_process
+
+Enabling falcon mode requires re-building TFA, U-Boot and the kernel
+``fitImage`` as follows:
+
+0. Setup environment variables:
+"""""""""""""""""""""""""""""""
+
+Refer to the build procedure above for setting up the environment variables.
+
+1. Trusted Firmware-A:
+""""""""""""""""""""""
+
+The R5 SPL in falcon mode loads the kernel at ``0x82000000`` and the
+corresponding DTB at ``0x88000000``. Therefore TFA needs to be rebuild with
+changes to the respective addresses.
+
+.. prompt:: bash $
+
+ # Change load addresses for the kernel and DTB
+ export TFA_EXTRA_ARGS="PRELOADED_BL33_BASE=0x82000000 K3_HW_CONFIG_BASE=0x88000000"
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_tfa
+    :end-before: .. k3_rst_include_end_build_steps_tfa
+
+2. U-Boot:
+""""""""""
+
+* **2.1 R5:**
+
+.. prompt:: bash $
+
+ # use the common falcon config fragment for all K3 platforms
+ export $UBOOT_FALCON_CFG_FRAGMENTR="k3_r5_falcon.config"
+ export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} ${UBOOT_FALCON_CFG_FRAGMENTR}"
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* **2.2 A53:**
+
+After rebuilding TFA, the binary needs to be repackaged inside the tispl
+binaries:
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_uboot
+    :end-before: .. k3_rst_include_end_build_steps_uboot
+
+3. fitImage:
+""""""""""""
+
+.. warning::
+
+    The ``fitImage`` available by default under ``boot/fitImage`` in rootfs of
+    the standard SDK release is not compatible with falcon mode.
+
+For authenticated boot in falcon mode, the compute heavy authentication
+required for the ``fitImage`` is offloaded from the slower R5 core to TIFS. This
+requires ``fitImage`` to package the necessary binaries (kernel and dtb) with a
+pre-signed x509 certificate.
+
+**fitImage for falcon mode:**
+
+.. image:: img/fitImage_falcon.svg
+  :alt: fitImage for falcon boot image format
+
+* **Sources**
+
+  * **Core Secdev K3**
+
+    | **source:** https://git.ti.com/cgit/security-development-tools/core-secdev-k3
+    | **branch:** master
+
+**Follow the steps below to create a falcon compatible fitImage:**
+
+**3.1 Environment setup**
+
+.. prompt:: bash $
+
+  export DTB=path/to/dtb
+  export IMAGE=path/to/kernel-image
+
+**3.2 fitImage creation**
+
+  An Image tree source (*its*) file describes the structure and contents of the
+  final image produced by the ``mkimage`` tool.
+
+  To create the ``fitImage`` for falcon mode, create a file ``fitImage.its``
+  with the following contents inside the ``core-secdev-k3`` source directory,:
+
+.. code-block:: dts
+
+    /dts-v1/;
+
+    / {
+        description = "Kernel fitImage";
+        #address-cells = <1>;
+
+        images {
+            kernel-sec {
+                description = "Linux kernel";
+                data = /incbin/("Image.sec");
+                type = "kernel";
+                arch = "arm64";
+                os = "linux";
+                compression = "none";
+                load = <0x82000000>;
+                entry = <0x82000000>;
+            };
+
+            fdt-sec {
+                description = "Flattened Device Tree blob";
+                data = /incbin/("falcon.dtb.sec");
+                type = "flat_dt";
+                arch = "arm64";
+                compression = "none";
+                load = <0x88000000>;
+                entry = <0x88000000>;
+            };
+        };
+
+        configurations {
+            default = "conf-falcon";
+            conf-falcon {
+                description = "Pre-signed Linux kernel, FDT blob";
+                kernel = "kernel-sec";
+                fdt = "fdt-sec";
+            };
+        };
+    };
+
+Sign the kernel and dtb using ``secure-binary-image.sh`` and create the
+``fitImage`` using mkimage:
+
+.. prompt:: bash $
+
+  # inside core-secdev-k3 source
+  cp $IMAGE Image
+  cp $DTB falcon.dtb
+  ./scripts/secure-binary-image.sh Image Image.sec
+  ./scripts/secure-binary-image.sh falcon.dtb falcon.dtb.sec
+  mkimage -f fitImage.its fitImage
+
+.. am62x_evm_falcon_end_build_process
+
+Usage
+^^^^^
+
+.. am62x_evm_falcon_start_usage
+
+Falcon Mode makes use of a cut down variant of the tispl binary called
+``tifalcon.bin`` with lacks the Cortex-A SPL and it's DTBs. This file should
+be present alongside the existing ``tispl.bin`` after building U-Boot for the
+Cortex-A core.
+
+- **tifalcon.bin**
+
+.. image:: img/tifsstub_dm_tifalcon.bin.svg
+  :alt: tifalcon.bin image format
+
+The R5 SPL requires both ``tifalcon.bin`` and the ``fitImage`` (created
+in previous steps) to be present in the second partition of the MMC device
+specified by the ``mmcdev`` environment variable. By default, ``mmcdev`` is
+set to 1, which implies that the SD card is the boot media. Additionally, the
+``bootpart`` environment variable, which defaults to 1:2, specifies that the
+second partition of the SD card should be used as the root file system for the
+kernel.
+
+To use eMMC instead of SD as the boot media, rebuild the R5 SPL with the
+following diff:
+
+.. code-block:: diff
+
+    diff --git a/board/ti/<soc>/<soc>.env b/board/ti/<soc>/<soc>.env
+    index 82b9f0741bb..73d59ac425c 100644
+    --- a/board/ti/<soc>/<soc>.env
+    +++ b/board/ti/<soc>/<soc>.env
+    @@ -17,8 +17,8 @@ run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+
+     boot_targets=mmc1 mmc0 usb pxe dhcp
+     boot=mmc
+    -mmcdev=1
+    -bootpart=1:2
+    +mmcdev=0
+    +bootpart=0:1
+     bootdir=/boot
+     rd_spec=-
+
+**List of files required on SD/eMMC for Falcon Mode:**
+
+.. list-table::
+   :widths: 8 8 8 25
+   :header-rows: 1
+
+   * - File
+     - Copy path on SD/eMMC
+     - Partition
+     - Description
+
+   * - ``tifalcon.bin``
+     - ``/boot/tifalcon.bin``
+     - rootfs (ext4)
+     - tispl binary without SPL for the A core and DTB
+
+   * - ``fitImage``
+     - ``/boot/fitImage``
+     - rootfs (ext4)
+     - kernel and dtb fitImage with pre-signed binaries
+
+.. note::
+
+    Falcon mode requires the boot binaries to be present in the root file system
+    of either eMMC or SD, even when using raw eMMC boot mode to load
+    ``tiboot3.bin``.
+
+.. am62x_evm_falcon_end_usage
+
+R5 SPL Memory Map
+^^^^^^^^^^^^^^^^^
+
+.. am62x_evm_falcon_start_r5_memory_map
+
+Standard Boot:
+""""""""""""""
+
+.. code-block::
+
+    0x80000000 +===============================+ Start of DDR
+      512KiB   |   TFA reserved memory space   | CONFIG_K3_ATF_LOAD_ADDR
+               |                               |
+    0x80080000 +-------------------------------+ PRELOADED_BL33_BASE in TFA
+     29.5MiB   |         A53 SPL + DTB +       | CONFIG_SPL_LOAD_FIT_ADDRESS
+               | Download region for FIT in DFU|
+    0x81e00000 +-------------------------------+
+               |  R5 U-Boot SPL Stack + Heap   |
+        2MiB   |       (size defined by        |
+               | SPL_STACK_R_MALLOC_SIMPLE_LEN)|
+    0x82000000 +-------------------------------+ CONFIG_SPL_STACK_R_ADDR
+      112MiB   |            Unused             |
+    0x89000000 +-------------------------------+
+      331MiB   | Device Manager (DM) Load Addr |
+    0x9db00000 +-------------------------------+
+       12MiB   |          DM Reserved          |
+    0x9e700000 +-------------------------------+
+        1MiB   |            Unused             |
+    0x9e800000 +-------------------------------+ BL32_BASE in TFA
+       24MiB   |             OPTEE             |
+    0xa0000000 +===============================+ End of DDR (512MiB)
+
+Falcon Mode:
+""""""""""""
+
+.. code-block::
+
+    0x80000000 +===============================+ Start of DDR
+      512KiB   |   TFA reserved memory space   | CONFIG_K3_ATF_LOAD_ADDR
+    0x80080000 +-------------------------------+
+     31.5MiB   |            Unused             |
+    0x82000000 +-------------------------------+ PRELOADED_BL33_BASE in TFA
+               |                               | CONFIG_SYS_LOAD_ADDR
+       57MiB   |   Kernel + initramfs Image    | CONFIG_SPL_LOAD_FIT_ADDRESS
+               |                               |
+    0x85900000 +-------------------------------+
+               |                               |
+               |  R5 U-Boot SPL Stack + Heap   |
+       39MiB   |       (size defined by        |
+               | SPL_STACK_R_MALLOC_SIMPLE_LEN)|
+               |                               |
+    0x88000000 +-------------------------------+ CONFIG_SPL_STACK_R_ADDR
+               |                               | K3_HW_CONFIG_BASE in TFA
+       16MiB   |          Kernel DTB           | CONFIG_SPL_PAYLOAD_ARGS_ADDR
+               |                               |
+    0x89000000 +-------------------------------+
+      331MiB   | Device Manager (DM) Load Addr |
+    0x9db00000 +-------------------------------+
+       12MiB   |          DM Reserved          |
+    0x9e700000 +-------------------------------+
+        1MiB   |            Unused             |
+    0x9e800000 +-------------------------------+ BL32_BASE in TFA
+       24MiB   |             OPTEE             |
+    0xa0000000 +===============================+ End of DDR (512MiB)
+
+.. am62x_evm_falcon_end_r5_memory_map
+
 Debugging U-Boot
 ----------------
 
diff --git a/doc/board/ti/img/fitImage_falcon.svg b/doc/board/ti/img/fitImage_falcon.svg
new file mode 100644
index 00000000000..b5f0229397f
--- /dev/null
+++ b/doc/board/ti/img/fitImage_falcon.svg
@@ -0,0 +1,180 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause -->
+
+<!-- Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/ -->
+
+<svg
+   version="1.1"
+   width="231"
+   height="220"
+   viewBox="-0.5 -0.5 231 220"
+   id="svg72"
+   sodipodi:docname="fitImage_falcon.svg"
+   inkscape:version="1.4.1 (93de688d07, 2025-03-30)"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <sodipodi:namedview
+     id="namedview74"
+     pagecolor="#ffffff"
+     bordercolor="#666666"
+     borderopacity="1.0"
+     inkscape:pageshadow="2"
+     inkscape:pageopacity="0.0"
+     inkscape:pagecheckerboard="0"
+     showgrid="false"
+     inkscape:zoom="2.9"
+     inkscape:cx="83.62069"
+     inkscape:cy="131.72414"
+     inkscape:window-width="1918"
+     inkscape:window-height="1078"
+     inkscape:window-x="0"
+     inkscape:window-y="0"
+     inkscape:window-maximized="0"
+     inkscape:current-layer="g62"
+     inkscape:showpageshadow="2"
+     inkscape:deskcolor="#d1d1d1" />
+  <defs
+     id="defs2">
+    <inkscape:perspective
+       sodipodi:type="inkscape:persp3d"
+       inkscape:vp_x="0 : 104.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_z="231 : 104.5 : 1"
+       inkscape:persp3d-origin="115.5 : 46 : 1"
+       id="perspective1" />
+  </defs>
+  <g
+     id="g62">
+    <rect
+       x="-0.06279549"
+       y="-0.062792346"
+       width="230.12561"
+       height="219.12558"
+       rx="34.518837"
+       ry="27.33382"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       pointer-events="all"
+       id="rect4"
+       style="display:inline;fill:#dbe4f4;fill-opacity:1;stroke:#8166b3;stroke-width:0.888796;stroke-dasharray:none;stroke-opacity:1" />
+    <text
+       x="115.15599"
+       y="156.49472"
+       fill="#000000"
+       font-family="Helvetica"
+       font-size="12px"
+       text-anchor="middle"
+       id="text8-8-7-6-6"
+       style="display:inline"
+       inkscape:label="x509 cert">x509 Certificate</text>
+    <text
+       x="115.15598"
+       y="85.615631"
+       fill="#000000"
+       font-family="Helvetica"
+       font-size="12px"
+       text-anchor="middle"
+       id="text8-8-7-6-6-1"
+       style="display:inline"
+       inkscape:label="x509 cert">x509 Certificate</text>
+    <text
+       x="114.532"
+       y="42.263863"
+       fill="#000000"
+       font-family="Helvetica"
+       font-size="12px"
+       text-anchor="middle"
+       id="text8-8-7-6-6-5"
+       style="display:inline"
+       inkscape:label="x509 cert">Fit Header</text>
+    <text
+       x="114.78398"
+       y="106.884"
+       fill="#000000"
+       font-family="Helvetica"
+       font-size="12px"
+       text-anchor="middle"
+       id="text8-8-7-6-6-5-5"
+       style="display:inline"
+       inkscape:label="x509 cert">Kernel Image</text>
+    <rect
+       style="display:none;fill:#000000;fill-opacity:0;stroke:#000000;stroke-width:1.00157;stroke-dasharray:none;stroke-opacity:1"
+       id="rect1"
+       width="171.46796"
+       height="210.89911"
+       x="36.799908"
+       y="21.652758"
+       transform="translate(-7.533886,15.237117)" />
+    <text
+       xml:space="preserve"
+       style="font-size:21.3333px;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:#db8c8c;fill-opacity:1;stroke:#000000;stroke-width:1.13386"
+       x="90.327087"
+       y="177.15775"
+       id="text1"><tspan
+         sodipodi:role="line"
+         id="tspan1"
+         x="90.327087"
+         y="177.15775" /></text>
+    <text
+       xml:space="preserve"
+       style="font-size:21.3333px;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:#db8c8c;fill-opacity:1;stroke:#000000;stroke-width:1.13386"
+       x="106.45526"
+       y="214.93161"
+       id="text2"><tspan
+         sodipodi:role="line"
+         id="tspan2"
+         x="106.45526"
+         y="214.93161" /></text>
+    <g
+       id="g62-6"
+       transform="translate(-5.6022949,-9.676433)">
+      <text
+         x="120.33229"
+         y="188.7475"
+         fill="#000000"
+         font-family="Helvetica"
+         font-size="12px"
+         text-anchor="middle"
+         id="text8-8-7-6-6-5-2"
+         style="display:inline"
+         inkscape:label="x509 cert">DTB</text>
+    </g>
+    <rect
+       style="fill:#db8c8c;fill-opacity:0;stroke:#000000;stroke-width:1.13386"
+       id="rect2"
+       width="82.644012"
+       height="17.6518"
+       x="73.677986"
+       y="94.992081" />
+    <rect
+       style="fill:#db8c8c;fill-opacity:0;stroke:#000000;stroke-width:1.13386;stroke-dasharray:none"
+       id="rect2-7"
+       width="32.336376"
+       height="18.068098"
+       x="98.83181"
+       y="165.66302" />
+    <rect
+       style="fill:#db8c8c;fill-opacity:0;stroke:#000000;stroke-width:1.77036;stroke-dasharray:none"
+       id="rect3"
+       width="152.43475"
+       height="70.500725"
+       x="38.782627"
+       y="127.54861" />
+    <rect
+       style="fill:#db8c8c;fill-opacity:0;stroke:#000000;stroke-width:1.77036;stroke-dasharray:none"
+       id="rect3-9"
+       width="152.43475"
+       height="70.500732"
+       x="38.782623"
+       y="56.777336" />
+    <rect
+       style="fill:#db8c8c;fill-opacity:0;stroke:#000000;stroke-width:1.78506;stroke-dasharray:none"
+       id="rect5"
+       width="152.41736"
+       height="36.60006"
+       x="38.791306"
+       y="20.211617" />
+  </g>
+</svg>
diff --git a/doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg b/doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg
new file mode 100644
index 00000000000..2508923d480
--- /dev/null
+++ b/doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg
@@ -0,0 +1,285 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause -->
+
+<!-- Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/ -->
+
+<svg
+   version="1.1"
+   width="231"
+   height="280"
+   viewBox="-0.5 -0.5 231 280"
+   id="svg72"
+   sodipodi:docname="tifsstub_dm_tifalcon.bin.svg"
+   inkscape:version="1.4.1 (93de688d07, 2025-03-30)"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns:xlink="http://www.w3.org/1999/xlink"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg"
+   xmlns:xhtml="http://www.w3.org/1999/xhtml">
+  <sodipodi:namedview
+     id="namedview74"
+     pagecolor="#ffffff"
+     bordercolor="#666666"
+     borderopacity="1.0"
+     inkscape:pageshadow="2"
+     inkscape:pageopacity="0.0"
+     inkscape:pagecheckerboard="0"
+     showgrid="false"
+     inkscape:zoom="2.3561254"
+     inkscape:cx="175.5"
+     inkscape:cy="151.30774"
+     inkscape:window-width="1920"
+     inkscape:window-height="1080"
+     inkscape:window-x="0"
+     inkscape:window-y="0"
+     inkscape:window-maximized="0"
+     inkscape:current-layer="g62"
+     inkscape:showpageshadow="2"
+     inkscape:deskcolor="#d1d1d1" />
+  <defs
+     id="defs2">
+    <inkscape:perspective
+       sodipodi:type="inkscape:persp3d"
+       inkscape:vp_x="0 : 104.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_z="231 : 104.5 : 1"
+       inkscape:persp3d-origin="115.5 : 46 : 1"
+       id="perspective1" />
+  </defs>
+  <g
+     id="g62">
+    <rect
+       x="-0.0064085587"
+       y="-0.0064054145"
+       width="230.01283"
+       height="278.39682"
+       rx="34.501923"
+       ry="34.727341"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       pointer-events="all"
+       id="rect4"
+       style="stroke-width:1.00331" />
+    <rect
+       x="40"
+       y="30"
+       width="160"
+       height="60"
+       fill="none"
+       stroke="#000000"
+       pointer-events="all"
+       id="rect6" />
+    <g
+       transform="translate(-0.5,-0.5)"
+       id="g12">
+      <switch
+         id="switch10">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 60px; margin-left: 41px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">FIT Header</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="120"
+           y="64"
+           fill="#000000"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text8">FIT Header</text>
+      </switch>
+    </g>
+    <rect
+       x="40"
+       y="160"
+       width="160"
+       height="50"
+       fill="none"
+       stroke="#000000"
+       pointer-events="all"
+       id="rect14" />
+    <g
+       transform="translate(-0.5,-0.5)"
+       id="g20">
+      <switch
+         id="switch18">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 185px; margin-left: 41px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">TIFS Stub<xhtml:br />
+
+(GP, HS-FS, HS-SE)</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="120"
+           y="189"
+           fill="#000000"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text16">TIFS Stub...</text>
+      </switch>
+    </g>
+    <rect
+       x="40"
+       y="90"
+       width="160"
+       height="30"
+       fill="none"
+       stroke="#000000"
+       pointer-events="all"
+       id="rect22" />
+    <g
+       transform="translate(-0.5,-0.5)"
+       id="g28">
+      <switch
+         id="switch26">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 105px; margin-left: 41px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">TF-A</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="120"
+           y="109"
+           fill="#000000"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text24">TF-A</text>
+      </switch>
+    </g>
+    <rect
+       x="40"
+       y="120"
+       width="160"
+       height="40"
+       fill="none"
+       stroke="#000000"
+       pointer-events="all"
+       id="rect30" />
+    <g
+       transform="translate(-0.5,-0.5)"
+       id="g36">
+      <switch
+         id="switch34">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 140px; margin-left: 41px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">OP-TEE</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="120"
+           y="144"
+           fill="#000000"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text32">OP-TEE</text>
+      </switch>
+    </g>
+    <rect
+       x="40"
+       y="210"
+       width="160"
+       height="40"
+       fill="none"
+       stroke="#000000"
+       pointer-events="all"
+       id="rect38" />
+    <g
+       transform="translate(-0.5,-0.5)"
+       id="g44">
+      <switch
+         id="switch42">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 230px; margin-left: 41px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">R5 DM FW</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="120"
+           y="234"
+           fill="#000000"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text40">R5 DM FW</text>
+      </switch>
+    </g>
+  </g>
+  <switch
+     id="switch70">
+    <g
+       requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+       id="g64" />
+    <a
+       transform="translate(0,-5)"
+       xlink:href="https://www.drawio.com/doc/faq/svg-export-text-problems"
+       target="_blank"
+       id="a68">
+      <text
+         text-anchor="middle"
+         font-size="10px"
+         x="50%"
+         y="100%"
+         id="text66">Text is not SVG - cannot display</text>
+    </a>
+  </switch>
+</svg>
-- 
2.51.0

