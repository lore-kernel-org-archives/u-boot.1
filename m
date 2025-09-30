Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819CBCAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 07:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 701C18349B;
	Tue, 30 Sep 2025 09:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ecjKiAdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F4F83071; Tue, 30 Sep 2025 09:10:04 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 041C283071
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 09:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WixwZYClhYWWRuRa7jjZECrDsguCwbiIrP6wRRCfxVzRRRYsGELpUnUox6K9vxbLrjy/GTyK8/I+PwOmdWbvhdo6QLnPQaKMXsMJhpov4Nn1gfQ0FqmgHDuBmIjLBwru/2O7ctUfeqrkx5I5HKii14psPy0b8CO+mFG26f2ziIieyySWtlXD2FMaz4i8ARdTPXgqRZvktXT+yZyjwa+nY0MGYh/V7U4mUtgdlIT12z/MwNXtYVCV3IYh/YTSXSTg0D3cvlVun/OEZPzUl5FhXHHflUkC7S+7BD6EHxCxcwmfDGkAo5HogKNwaHCLf2BnUikdDCb0uSI5KfknZ1km4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AgR3DlttYpQNv7B9WFLdUDV1wMjx7E546xsoVLaAs8=;
 b=OXGR1iJYQzuJrRGZC8ECO4BE88FEjQL3RTzKlZag2K+JwIbONwXXJAILg2yOgUSHJWqOxKlN10pJRxtfvuDMIaFEAdVkrjTZfWSy4NfCK92dn09ueRmY+sHb2BqOAxIWSSMUjC6QGVwGP7Nr0pPECofIHdBb5riGo7QQ22ZWTHuHMprW6/A9AC2Swuq7JAdxK0H+PrCNZiH63JIiZC3T+oqBDoTDSdtAjps+KaZyINJWrk3VrjwaD/jQPiYSeXZwNyrowC0xAsd24dpZ8g/24Luos80o10o4YoivcMcUBi+0F0hONo/5Gn/KtJFQZciTCoueDtPusb/kOvSKhnh/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AgR3DlttYpQNv7B9WFLdUDV1wMjx7E546xsoVLaAs8=;
 b=ecjKiAdAtYgk9+v83MBuEH2OwmQ4YOPM0yRUw3ubRohQ2uR5Llt51fwmavKMv24jZgkPbYO9ynpkIDP/suqDXEDei04tEtRLYiPZboHkGtoLz4INOqNqsJuxP9dNFOWFMrPNFO42I2qB3G7FUb2FS9Y1EwtqTNMJKEyqpzVvIDc=
Received: from PH5P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::8)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 07:09:55 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::ee) by PH5P222CA0012.outlook.office365.com
 (2603:10b6:510:34b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Tue,
 30 Sep 2025 07:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 07:09:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 30 Sep
 2025 00:09:38 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Sep
 2025 02:09:36 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 30 Sep 2025 00:09:36 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Tom Rini <trini@konsulko.com>
CC: Anshul Dalal <anshuld@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Padmarao Begari <padmarao.begari@amd.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Replace PHY_VITESSE by PHY_MSCC
Date: Tue, 30 Sep 2025 09:09:26 +0200
Message-ID: <0a441e488a29bd1c93677a6f63a4a04a3cc1c9f5.1759216164.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2713; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=KrgXd/WuvAlgrePtwoVpEfd6Gw6ri8mndWo4je8MU/0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTcbtLYuHK/vN6RB5q7HlY9CW5euu2Uqk3v79vn3SS3F
 i1T4bxV3FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATWbCIkWHGed/+lZM4cneU
 Pz8W0nz8kB6X5vk3zN8Elb7Mrru8tE6dkeFo28nfB2u2Tj6wf+uqtbvLr3R4Ggufmaj/YJqJzJR
 NO9KZAQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e8134d-e7eb-44c6-8f6b-08ddfff05b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tqpoA47XX++h5mz1mwNuCFVmL0dnkBqt06Lf0Bq3XcvFBd8s0P+dATYKpZxf?=
 =?us-ascii?Q?f1KUVUbKZ1F6Mc1v2lize3EUabKqH62KvndWhpH+qV+Po8Ev+ypzHKST8d9Z?=
 =?us-ascii?Q?zdanqloFpXUKAmOirGPc7q3LKTYqoubpe3XxdPfa9A6oPqIt/SpZn/6RTwh2?=
 =?us-ascii?Q?C7GA4d5trTMWgO5zhKJ2lJMfAZaOuxdYtlJXUCjSD+mSOFJACGcqPrLl8ntN?=
 =?us-ascii?Q?OWbYMn/AufEwL31VZ8Wu9gpedaMMS3cPfgzs/Y61jDkrykberA7fxzD4dFre?=
 =?us-ascii?Q?pqLy+9I/iBKZU+aivKGS9CMhxaOTZl4O5nVR8669aC7pNavJAnVGRL4QaHer?=
 =?us-ascii?Q?c9zm9YdUyk1TEoe8z58/YboVot/vUBWmVZKsKlC1IuUxZLTKGnuFQSfF0t8O?=
 =?us-ascii?Q?Q277FerVAL2vV/Yd6vOwiqnkjV8jyA8W4wvu6aMCI+9Sj9oqDMv2WglPdweh?=
 =?us-ascii?Q?R6psh9Gw09RdiOMdo59XtahVs5WLBeSVgMHb0gs88vk3mlORANhusKYhGujW?=
 =?us-ascii?Q?tGGws8ZoES+B+b+zuhDAy88WnrmGbotp6CNJ2iv8R3Y277H39xEyTy+7mlNh?=
 =?us-ascii?Q?cJPyuKkXq2Ba9Yj2AB6p1S+KssRC2O2/ZQuT322BrBkWEDvmvb48H6tAgays?=
 =?us-ascii?Q?XqPe9fzAIUhu3RbLU1a9RVKdp839+g29c2R4zQmhFgvh2t13W7V455D0TAHC?=
 =?us-ascii?Q?L6RMZnV5q5CPc8qmgFkHWsjArL0FilCOmMAH6sVKkU5jSQiqYUhLEyVeBDga?=
 =?us-ascii?Q?O9D2hEhaxSLNzUE+LMzSHUBHp+sgZ3FWBdrcgWCzm9NuZZhRQ00ZjHhKSNC8?=
 =?us-ascii?Q?cLjwmJDDL+/7Lx6oSsCGII2ESo+C3HTqxFyd9M6ss7zm3RvZs0kY68zMTzJ4?=
 =?us-ascii?Q?/RG0Oh6dLIoC6wjzQnU6gKHzDGBlx99v8m++tpOwhDMrjlJ1XTqtlaZTChBl?=
 =?us-ascii?Q?lcI4fu8HC/uNH2w0jFKaYnom/eX70YFYb1m8m/6WUVcYpWUfS5DYjoOomqQJ?=
 =?us-ascii?Q?SqgqwfaBfqoZsyOJTY8J6FoE77IUX1OAga6Xz1B3e/0TPJ9jVtpzH4LjkDW0?=
 =?us-ascii?Q?2nhJGSebsW2n7ikQNZGb7ARqfuovoOXR16RMDBNrl3/umEwfR6OyWHL7oVa4?=
 =?us-ascii?Q?kVlHVKe8+6EW3TBlc5JB4ACm8Iwl6jIz22+FBRr22NdZpFdKQNdhMuaJTegy?=
 =?us-ascii?Q?3YAO6QJDfGKXP2X3n2StQ4ZG6nRsEtEP+leuaGZGZ3eoSFSX6R577OZfoOkg?=
 =?us-ascii?Q?9lqAcR9RJc6U8tEKSRbjxl7+CLJal4TGkeHmAi1YWHxSNeioamggepOjarFf?=
 =?us-ascii?Q?6q8Q9eagnzrlKncviK7UO2K3Dw4ZoIsQc3EEyXWWfZC3EfXMZC+sVa2urV7J?=
 =?us-ascii?Q?k0vQbNHaWBl9bjRYMaou3Fu/D/gDNKQbZO/vNrjS12oeqn+VDCizrHAAnDCv?=
 =?us-ascii?Q?MJOnSE2rwf3yhyeKz7diKOuPbeYtOaMxYfoYPT8UpA+hTziqaxAikhPh2guP?=
 =?us-ascii?Q?GXH+2dkusDoEy8MJcwjRtGpEQJE7dPRtqM5GlX60DbNd7z44Y/Fbbwn0W2ho?=
 =?us-ascii?Q?1M1ElVQIW9vtVeoGC2M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 07:09:54.9526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e8134d-e7eb-44c6-8f6b-08ddfff05b98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
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

Enable MSCC phy driver instead of VITESSE. Vitesse driver is much older and
is on the way out that's why switch to MSCC driver which covers VSC8531
which is used on one Versal board.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig       | 2 +-
 configs/xilinx_versal_net_virt_defconfig | 2 +-
 configs/xilinx_versal_virt_defconfig     | 2 +-
 configs/xilinx_zynqmp_virt_defconfig     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 4a7bc1951451..aca03ea50f16 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -108,10 +108,10 @@ CONFIG_SPI_FLASH_WINBOND=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_MARVELL=y
+CONFIG_PHY_MSCC=y
 CONFIG_PHY_NATSEMI=y
 CONFIG_PHY_REALTEK=y
 CONFIG_PHY_TI_DP83867=y
-CONFIG_PHY_VITESSE=y
 CONFIG_PHY_FIXED=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 770bd0643c19..192ace8b530c 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -111,10 +111,10 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MARVELL=y
+CONFIG_PHY_MSCC=y
 CONFIG_PHY_NATSEMI=y
 CONFIG_PHY_REALTEK=y
 CONFIG_PHY_TI_DP83867=y
-CONFIG_PHY_VITESSE=y
 CONFIG_PHY_FIXED=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index ac78dea587cd..18b972f8ba46 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -120,10 +120,10 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_ADIN=y
 CONFIG_PHY_MARVELL=y
+CONFIG_PHY_MSCC=y
 CONFIG_PHY_NATSEMI=y
 CONFIG_PHY_REALTEK=y
 CONFIG_PHY_TI_DP83867=y
-CONFIG_PHY_VITESSE=y
 CONFIG_PHY_FIXED=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 6e4ba7269f85..525744b0f61e 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -171,10 +171,10 @@ CONFIG_PHY_ADIN=y
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_PHY_MSCC=y
 CONFIG_PHY_NATSEMI=y
 CONFIG_PHY_REALTEK=y
 CONFIG_PHY_TI_DP83867=y
-CONFIG_PHY_VITESSE=y
 CONFIG_PHY_XILINX=y
 CONFIG_PHY_XILINX_GMII2RGMII=y
 CONFIG_PHY_FIXED=y
-- 
2.43.0

base-commit: 612074dc5d44e5695c30dcdea55e72f4285a4fe6
branch: debian-sent3
