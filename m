Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CABC369A1
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 07:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D9488B13;
	Wed, 25 Sep 2024 09:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZDaU+fi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C2188B5F; Wed, 25 Sep 2024 09:04:12 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B6C88B13
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 09:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3f96I1C7fN1EkK4ychIUmyTu2Aqev2RomU145LVqsyVSqUrHqqRE9zZ+ZpMQ8YM22jw0Gbocv2q65X2Kds7QjO7j+RYBID66wFxRxf3tolM+x2NbNlDhKSBcUPWpDyKAJNgwtFyJjEkcnwgSVqUru6sb44UocX7mFnt/gK7wVLGSj6PHeWOk9/pFAwEasO2YShunMlVKAWPHbeY7nuxq184fe7GUmmHMUK8erl93b0++0UxbLt1C8xs2IpmKHNotYDULQ0TSA3/DcTq/ME8gYFhLu6NRUg9cFe+vArrRHV2TZ3tTweMeKoFgXMMST8nuzMv049Jsaog2ISOEV58uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vR75U5XMHrNUE+HcD7SXdDtdEcJ0EBP3l9+mdlkC9A=;
 b=wpTzTkiXCCSEa9DNhVZJ0ldh7H0FATR/urRpFNzFjNsWXAelpvyd9mwXDm/TeausPGhC5JMLJ4DXIMwGzMr6x2EPVFq6wK7jDunniFED1NI7tBo62mRraljfnLj4fyvQO7AWIDQUQIBTATk/5bY/GPehJ9ik0Iyq14YqVOiauPkeMe6i/xG6Ye7ZkSoTRuxn4tMPyzMQVL8oEDtwXk3NfG791cVDn6A5kadcHdioUpVRwT3qGYgkgxZH+BG5MjpgG/uAfGVpyK/mbXD/HcyrHqtTOPy4SzSAhXubHn0CY7Dy926B+N6Tqu9BTbQLueWxTK3QT6sQ9zPdT5Bws3kOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vR75U5XMHrNUE+HcD7SXdDtdEcJ0EBP3l9+mdlkC9A=;
 b=ZDaU+fi9VqdAd0YkY29uFH8u3uS87wuLPwRqeUaPqoL878TuO+ldXzKSq8Ma/KVC/tZpZdVFT6H1r8QYq+TdbbNCTKGvllGFmSsLHO6+ddps+64/fOhYefr8LFAHKCSR75aTouRr/B0T4F6ZQ+6YksISJngJyMdFsY9O/uL04Cg=
Received: from MN2PR22CA0020.namprd22.prod.outlook.com (2603:10b6:208:238::25)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 07:03:21 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::f6) by MN2PR22CA0020.outlook.office365.com
 (2603:10b6:208:238::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 07:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 07:03:21 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 02:03:18 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Paul Alvin <alvin.paulp@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Tom Rini <trini@konsulko.com>, Vishal Patel
 <vishal.patel@amd.com>
Subject: [PATCH] xilinx: Add cap-mmc-hw-reset and no-sd,
 no-sdio property to eMMC
Date: Wed, 25 Sep 2024 09:03:13 +0200
Message-ID: <b31554816a3378365143e9f5c266f6386af0a438.1727247785.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9179; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=yrrh4sSSetONa+6xfYeFrlej7ek4x+PhAtvgMe8Lvyw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTPWzc926Mk8WW7yeka4U7NGLdPxjn5y+Vq5wkvtv3CJ
 XjENHtWRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiI6HaGeRq79Fzv2x1afcfL
 xqMl8or5xzO2Gxjm8D+2/qsXW6cQrr2Uc3bYL+UaT86zAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: f80dacb3-7966-44b8-0347-08dcdd3023f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CvjauUgKL1mVGFHI6/1EzYjslStXyyGPqa88tvT2X7hZcUouUDxeKeUL6wA5?=
 =?us-ascii?Q?5RuDaaTfT8HLFKDP9Lmi+8R/pKj0hVpe/sekUmLh0FX+IzH+LBApoKRFpf7R?=
 =?us-ascii?Q?lQhxgs6BfjmNGF3eUKyWnLgFaXeSYIsNETkq4I4puqLhHgny8smKKFZ8wdJ9?=
 =?us-ascii?Q?sX+7/zTOiGXIFd9G1Y12xZQSmatYoW3pKDRVjvesfTqjz5Y78dXDWJk3tfa+?=
 =?us-ascii?Q?ShbHrmzKLAB42Y58OQQmNCatCz/jnRO/AYL5Gwv6U3OcIIg0izF15/0cLHfs?=
 =?us-ascii?Q?ca9oFM/ruMSAJORgQrhO8JofXffl+/YwHHTmeVyj6988txsP5DanXXsTnJtd?=
 =?us-ascii?Q?JvIrCfI/Q+4igNT1yPm3VPRJ3pTH29sWBGBqcIxU7geki3hGSZTKBb/U5SOW?=
 =?us-ascii?Q?GVEF7AUo09r6WN6GX8kovsCfwyxfsVs/I/1DDxf2gyjd/PjgLiYldOUAZ2wv?=
 =?us-ascii?Q?Fl7bKqojYZh7KFzSNVvb8exaZ6TB2/rxvu87DHFSzLqq2v663DnkYqIhUZ9V?=
 =?us-ascii?Q?qgP2vxarQzXrXuHBXvT+Jvd4CCiI1dH3t/YBKOfDp2yHBk/bAcCMVGpGEUMw?=
 =?us-ascii?Q?EB5uvDoc60HC2zH8c8zYyf9tbz3bwisIXR3VuIhNs0ZwU6MdQJZnXahuVRs9?=
 =?us-ascii?Q?H32PcmPoeQxJGpWL2Fxam+/9m2zklj82oU2ZcCqG7YG6CGnlwYw5lI0ALbEe?=
 =?us-ascii?Q?MjEP79hHT66TUWhNiOWZ7ZLWPg0HJdtydR/c1tlTkNEruEKwrWzzbHHpUYku?=
 =?us-ascii?Q?r3sjwJAkys8zs/pWpq2Rx45ODB1kgCOWBaXtkQWAzZcBy0ScdFN6QNfP74hU?=
 =?us-ascii?Q?0mLWKXrjLymOfSuSuhssrwZTYocRtdYrrokkm+xpYrCUzh/voHn7cSDWP+DU?=
 =?us-ascii?Q?7G7hXrpymOBHQl5yZfv6jFPcuok2hwAlykjJcPGrULEI6ZhMR2tV9aQLm1+r?=
 =?us-ascii?Q?F664FQ9e9meHa6ZSqsbXfNumWs8Jj+2FhbtmwMX1CV5Y4qWRLBEgArmQ1WvY?=
 =?us-ascii?Q?6iLEgyul5XB9Ez8aIqA6Hheb0gde65fzTFAPvIwTOvtbzZhUPZDT8MQ9Xc7C?=
 =?us-ascii?Q?hTg3Hd1egdcCQoIsJiXQoV94VgL7ikaTbLNyPWMPuiqDRt+9bIFk7GCQ/3ic?=
 =?us-ascii?Q?VeVmWuONmzNV2XubULMRX9nFlezl77vi61RtBY+pTo3i1o/u7wxuhZ25hh7a?=
 =?us-ascii?Q?QwWtdkuTU/lsp55qsrVYu2DohtMRNJGr1U3ELksUKRxw18sgT+U1h3HWBizi?=
 =?us-ascii?Q?aQRFBJ2u9NPC0pHaeY+RdBaYOcTzlr4SSiB00/rJon3QF4/bkONnxIrYgIll?=
 =?us-ascii?Q?vhktnom8MYsXgq1jvAZYsLUQyMXi3ghqEnAUJfqnp0ogZp+lwXcgAElYmUph?=
 =?us-ascii?Q?/Bu9l02xDfaW0JjIw0TrC7BJvcV7sH/lUcE1Te8d9AX+xttDluGmrtUQCKNA?=
 =?us-ascii?Q?DovwMAbxCcM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:03:21.0702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80dacb3-7966-44b8-0347-08dcdd3023f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
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

From: Paul Alvin <alvin.paulp@amd.com>

Add "cap-mmc-hw-reset" property to the eMMC DT node to perform the
eMMC device hardware reset.
Also, add "no-sd", "no-sdio" properties to eMMC DT node to skip
unwanted sd, sdio related commands during initialization for eMMC
device as this may lead to unnecessary register dump.

Signed-off-by: Paul Alvin <alvin.paulp@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/versal-mini-emmc0.dts                    | 3 +++
 arch/arm/dts/versal-mini-emmc1.dts                    | 3 +++
 arch/arm/dts/versal-net-mini-emmc.dts                 | 3 +++
 arch/arm/dts/zynq-dlc20-rev1.0.dts                    | 3 +++
 arch/arm/dts/zynq-minized.dts                         | 3 +++
 arch/arm/dts/zynqmp-dlc21-revA.dts                    | 3 +++
 arch/arm/dts/zynqmp-g-a2197-00-revA.dts               | 3 +++
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts               | 3 +++
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts               | 3 +++
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts               | 3 +++
 arch/arm/dts/zynqmp-mini-emmc0.dts                    | 3 +++
 arch/arm/dts/zynqmp-mini-emmc1.dts                    | 3 +++
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts               | 3 +++
 arch/arm/dts/zynqmp-sc-revB.dts                       | 3 +++
 arch/arm/dts/zynqmp-sm-k26-revA.dts                   | 3 +++
 arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts | 3 +++
 arch/arm/dts/zynqmp-vpk120-revA.dts                   | 3 +++
 arch/arm/dts/zynqmp-zcu100-revC.dts                   | 3 +++
 18 files changed, 54 insertions(+)

diff --git a/arch/arm/dts/versal-mini-emmc0.dts b/arch/arm/dts/versal-mini-emmc0.dts
index b98ed16bc5ff..179060c56eee 100644
--- a/arch/arm/dts/versal-mini-emmc0.dts
+++ b/arch/arm/dts/versal-mini-emmc0.dts
@@ -40,6 +40,9 @@
 			status = "okay";
 			non-removable;
 			disable-wp;
+			no-sd;
+			no-sdio;
+			cap-mmc-hw-reset;
 			bus-width = <8>;
 			reg = <0x0 0xf1040000 0x0 0x10000>;
 			clock-names = "clk_xin", "clk_ahb";
diff --git a/arch/arm/dts/versal-mini-emmc1.dts b/arch/arm/dts/versal-mini-emmc1.dts
index e6a5c2b699e0..ffcc33345296 100644
--- a/arch/arm/dts/versal-mini-emmc1.dts
+++ b/arch/arm/dts/versal-mini-emmc1.dts
@@ -40,6 +40,9 @@
 			status = "okay";
 			non-removable;
 			disable-wp;
+			no-sd;
+			no-sdio;
+			cap-mmc-hw-reset;
 			bus-width = <8>;
 			reg = <0x0 0xf1050000 0x0 0x10000>;
 			clock-names = "clk_xin", "clk_ahb";
diff --git a/arch/arm/dts/versal-net-mini-emmc.dts b/arch/arm/dts/versal-net-mini-emmc.dts
index e200fb694c6b..20e4e2994048 100644
--- a/arch/arm/dts/versal-net-mini-emmc.dts
+++ b/arch/arm/dts/versal-net-mini-emmc.dts
@@ -54,6 +54,9 @@
 			status = "okay";
 			non-removable;
 			disable-wp;
+			no-sd;
+			no-sdio;
+			cap-mmc-hw-reset;
 			bus-width = <8>;
 			reg = <0 0xf1050000 0 0x10000>;
 			clock-names = "clk_xin", "clk_ahb";
diff --git a/arch/arm/dts/zynq-dlc20-rev1.0.dts b/arch/arm/dts/zynq-dlc20-rev1.0.dts
index 8d0073780336..8031488d17a5 100644
--- a/arch/arm/dts/zynq-dlc20-rev1.0.dts
+++ b/arch/arm/dts/zynq-dlc20-rev1.0.dts
@@ -83,6 +83,9 @@
 	bootph-all;
 	status = "okay"; /* EMMC MTFC4GACAJCN - MIO40-MIO45 */
 	non-removable;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	bus-width = <4>;
 };
 
diff --git a/arch/arm/dts/zynq-minized.dts b/arch/arm/dts/zynq-minized.dts
index 96d2937de8bf..a8f345032eaf 100644
--- a/arch/arm/dts/zynq-minized.dts
+++ b/arch/arm/dts/zynq-minized.dts
@@ -92,6 +92,9 @@
 &sdhci1 {
 	status = "okay";
 	non-removable;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	bus-width = <4>;
 	max-frequency = <12000000>;
 
diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
index 293d8e97b63a..d540f334f511 100644
--- a/arch/arm/dts/zynqmp-dlc21-revA.dts
+++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
@@ -60,6 +60,9 @@
 	status = "okay";
 	non-removable;
 	disable-wp;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	bus-width = <8>;
 	xlnx,mio-bank = <0>;
 };
diff --git a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
index c439f778ca46..6ef8b1462eb2 100644
--- a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
@@ -68,6 +68,9 @@
 	status = "okay";
 	non-removable;
 	disable-wp;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	bus-width = <8>;
 	xlnx,mio-bank = <0>;
 };
diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index d6cd193a4490..c597adb80cb2 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -88,6 +88,9 @@
 	status = "okay";
 	non-removable;
 	disable-wp;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	bus-width = <8>;
 	xlnx,mio-bank = <0>; /* FIXME tap delay */
 };
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index 902fdd4de6cc..eefe5ab61e77 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -84,6 +84,9 @@
 	status = "okay";
 	non-removable;
 	disable-wp;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	bus-width = <8>;
 	xlnx,mio-bank = <0>; /* FIXME tap delay */
 };
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index f3994bca4a08..7ea4eab6a376 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -84,6 +84,9 @@
 	status = "okay";
 	non-removable;
 	disable-wp;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	bus-width = <8>;
 	xlnx,mio-bank = <0>; /* FIXME tap delay */
 };
diff --git a/arch/arm/dts/zynqmp-mini-emmc0.dts b/arch/arm/dts/zynqmp-mini-emmc0.dts
index cf2219797a58..ad4b3c5f8b1d 100644
--- a/arch/arm/dts/zynqmp-mini-emmc0.dts
+++ b/arch/arm/dts/zynqmp-mini-emmc0.dts
@@ -52,6 +52,9 @@
 			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			non-removable;
+			no-sd;
+			no-sdio;
+			cap-mmc-hw-reset;
 			bus-width = <8>;
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
diff --git a/arch/arm/dts/zynqmp-mini-emmc1.dts b/arch/arm/dts/zynqmp-mini-emmc1.dts
index 4c9f56a80763..fd421b4fe7ed 100644
--- a/arch/arm/dts/zynqmp-mini-emmc1.dts
+++ b/arch/arm/dts/zynqmp-mini-emmc1.dts
@@ -52,6 +52,9 @@
 			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			non-removable;
+			no-sd;
+			no-sdio;
+			cap-mmc-hw-reset;
 			bus-width = <8>;
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
index ae52e8e996a5..f93167c41284 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
@@ -60,6 +60,9 @@
 	status = "okay";
 	non-removable;
 	disable-wp;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	bus-width = <8>;
 	xlnx,mio-bank = <0>;
 };
diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
index 1fcb5bfb9286..1af3f643567e 100644
--- a/arch/arm/dts/zynqmp-sc-revB.dts
+++ b/arch/arm/dts/zynqmp-sc-revB.dts
@@ -288,6 +288,9 @@
 	status = "okay";
 	non-removable;
 	disable-wp;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	bus-width = <8>;
 	xlnx,mio-bank = <0>;
 };
diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index d95a05e21592..8056f6b176ed 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -247,6 +247,9 @@
 	pinctrl-0 = <&pinctrl_sdhci0_default>;
 	non-removable;
 	disable-wp;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	bus-width = <8>;
 	xlnx,mio-bank = <0>;
 	assigned-clock-rates = <187498123>;
diff --git a/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts b/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
index 0d96c6f9f041..2037686b9b45 100644
--- a/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
+++ b/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
@@ -93,6 +93,9 @@
 	status = "okay";
 	non-removable;
 	disable-wp; /* We don't have a write-protect detection */
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	bus-width = <8>;
 	xlnx,mio-bank = <0>;
 };
diff --git a/arch/arm/dts/zynqmp-vpk120-revA.dts b/arch/arm/dts/zynqmp-vpk120-revA.dts
index 4768fac71d02..f281c7fb9fdd 100644
--- a/arch/arm/dts/zynqmp-vpk120-revA.dts
+++ b/arch/arm/dts/zynqmp-vpk120-revA.dts
@@ -105,6 +105,9 @@
 	status = "okay";
 	non-removable;
 	disable-wp;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	bus-width = <8>;
 	xlnx,mio-bank = <0>;
 };
diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zcu100-revC.dts
index c5945067cd57..c9051360931b 100644
--- a/arch/arm/dts/zynqmp-zcu100-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
@@ -509,6 +509,9 @@
 	xlnx,mio-bank = <0>;
 	non-removable;
 	disable-wp;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	cap-power-off-card;
 	mmc-pwrseq = <&sdio_pwrseq>;
 	vqmmc-supply = <&wmmcsdio_fixed>;
-- 
2.43.0

