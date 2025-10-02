Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF72CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 08:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F9C5828A2;
	Thu,  2 Oct 2025 10:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AuUeDrvP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68FCF8328F; Thu,  2 Oct 2025 10:20:03 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFDEB80107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 10:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otm5APwxfQDd5upvffVlRwfdcLUhWAm6PV8wUV3MbfExghm+gWawUABGtvFpCh837YvhdhH6G7ZiWz3BV4ndt6K9lHKXvrZDkocqhBr6dq2Duq8/m9/EX8afqH72ntzdNYqX/+CTY1vWhjCFWk8Steq1JowcrglYI0uJY18FjQzI2hjxwyzRwJ3dMYB3jVZbs7z1opP7e87458aDnYCWf9nu9qmeJtlaEKIIHDGcWNWRHc55Domfr3s+NtJa+TdcgRv6ZUP8X5jvPan3Rp53KVoVlADn0WblDsGefjfkQC2pk/+/8l3o9DrYztX2e+YDu21DQ4xEin0AaZcvCFUvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwu9pkdHuRHkV1YM4wK3o8sIZ1DF7enkU8LdqOle1Fc=;
 b=jUpFZ1mkiMMYMjeHtoOZHmZWi1nS7aitOpHuG65j0a1T0GXrb5goaitfc21roClIejxz+qyITohCI4lsk3zkCJGS0afmgX0V+2NeKYB5kLs4IXmUfaoYNTXHZi//41oEb5Qd7UHwaFFzGjRFRQWOXbHFvinb/8/hzx9hvBGT4oVDoJCf8R52oCPA5ANDcmHZHLafSxq8N4vvi8Tc+pd6AhD1unyOB2PSaZJukWvo9E9SbQVxHH2mv73rpYAWMyL9zGX6HFDN8CbboEoj5Q+mVu5+A0eXrznVgwoY1wP1f4hlmxGdCXsH0l1x0j2qtrT1mLaAaJuk4fXnpF63yY2LjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwu9pkdHuRHkV1YM4wK3o8sIZ1DF7enkU8LdqOle1Fc=;
 b=AuUeDrvPq8dP4ZqaC8Zvoo0/n74u20Mk5eBddp1cFKQBJ5y8wdkOqM66RbCpuZ/Ns41Y2WAjYNgJONmizyOAqVLKzPgFnmEWXNvhz7zj8m2vil4qOjnNsyLZBvSBUKSRo7LI3OmamiJagjMCH4EBIa3NOSPmkQFSj8a/Gvmb3v8=
Received: from BN8PR12CA0003.namprd12.prod.outlook.com (2603:10b6:408:60::16)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 08:19:56 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:60:cafe::f8) by BN8PR12CA0003.outlook.office365.com
 (2603:10b6:408:60::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 08:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 08:19:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Oct
 2025 01:19:54 -0700
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Oct 2025 01:19:54 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Martin Herren
 <sputnik@on-the-web.ch>, Padmarao Begari <padmarao.begari@amd.com>, "Prasad
 Kummari" <prasad.kummari@amd.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, Srinivas Goud
 <srinivas.goud@amd.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 2/2] xilinx: Enable SNTP/DATE commands and RTC
Date: Thu, 2 Oct 2025 10:19:39 +0200
Message-ID: <2605b1618a311efe4f35442c34e7cec973060630.1759393175.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <585f96d85b656803bd382ac25425d68998f24ed5.1759393175.git.michal.simek@amd.com>
References: <585f96d85b656803bd382ac25425d68998f24ed5.1759393175.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5515; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=X/k+uLYqcn13MStFETgNlMn253QGNCgPe3UtFy00fR0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTcM50/6XxMw4kr1192xeRen6X0511g7Oxvqfd+OAsYG
 oSUH53Z3VHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATOTOXkeHU16uFNp+vvZ2V
 HR3pUMVmf//t8S9JxW+9ub83bt8StqGQkeGW26q5si33lk5ZKBFVYK++JfKK067ySatdF17cURZ
 7u40XAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: b77943d1-a0f0-4725-6e4c-08de018c784f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r0sYSE83v1IsJsR1YX+alfokgM5ACEQ/YXh1FvlQlaVznR7Vk1gcIxXzfsDd?=
 =?us-ascii?Q?1J3blmKYABozZNbK0vTH7R7+fp0GcGj7JBQTqKCGCPHIDpp7U4bt1hZ0T/vY?=
 =?us-ascii?Q?KX0yM9eiel/HLOmh3HVM/VNFUbh8NSADzgDS2QGnDyis/Gg7JAneuI+qIJhh?=
 =?us-ascii?Q?r0bZbeYp7m0LEO+yjkW6HBG7+AA34JnXrQ/Rv76pnJmIXDVk7PVeJMboNngm?=
 =?us-ascii?Q?D7dZ4/TkTpvJs5prk+J1LI3FtNDCLujKFpYbkPpjz/d1FpaaT82YH0AXQUjG?=
 =?us-ascii?Q?MNg7BBzsh801m1V2EDtqUbizlWA8hubpIYK7F2VZqnVALQcE2pjAeGan8UWe?=
 =?us-ascii?Q?HH90Zxg+pzZEURPvS1Grc+I54qyp22VNhfmSZMEBDOxEpCnIZM7Eb9sdm4Iy?=
 =?us-ascii?Q?wfQ7X7FgztsY/yNoAcg6mBlhBu6wK56KlKblmOZFbCzbxu5hdR/++QfZ6WCN?=
 =?us-ascii?Q?ZmawXT9W17y1OqnW+OdEJxHSjRnEmtgGgOnxCyJBOwXXrk9AxbTux6W40PA5?=
 =?us-ascii?Q?awiaVVD71REQFM2a/sSJq0+/17Jr3FBsMVjEM2Auia3ZtKAtEZOx2tOBOb3s?=
 =?us-ascii?Q?qg5owvkCFHaeUhxN/jBvDP19LJLWmXc8QcKnhqqG/qTprMm4WJOT42u7C9uZ?=
 =?us-ascii?Q?BUTA+SGnFpRC9u/9AeuZpAgAwbN/3ym3bABNzqilrL+aqpukaTRSotQXYAyL?=
 =?us-ascii?Q?/JHqjnKIul3IIn+/T41AmdTEweh/N/oTH5zMM9WgWaSP8ppWNuP1qdZ5nxPw?=
 =?us-ascii?Q?MslrnKQMkcx5aP+osKIwXx/HraSVRqBhzPuH5z6CpSrb6+gXVsWvlYheP9N9?=
 =?us-ascii?Q?6amW9Jdov37qLMI8p3EV+p9A0HotUZ0WDrkMoK0h1eQRFpTGS2ZEFTxLfwnM?=
 =?us-ascii?Q?IYJIIkKSeRDG16OGb9ceG/Eu3nbBbi1nROH6ZKGmgAZfaNVu5gsIvw57UksD?=
 =?us-ascii?Q?5c9XIao+EKJY6MiVPANKnMCgdt6fLyW40Z333d4BXxKYAdEP6WG5OOP46T/B?=
 =?us-ascii?Q?VIxoZJqqXJQ/EZTFsXi7ZMqEB0CPu13iuhTCBGqhCQhkbImpwjF7hUdpiMO4?=
 =?us-ascii?Q?xqlk8CKHdeE1tt4Kkauf+DzuTDnKthjvQhK6+ZtcJEfkyGKoIsLxntlYUGer?=
 =?us-ascii?Q?4Mf03oxP7+iMLqMXJne6vQtpnENgnOxpXaX9dXFhy5V8dO2ylLee+SpGsNPG?=
 =?us-ascii?Q?T/ihocneDZ6Fq/7hi8qb1b0Mg6QzKu+DUBaDYxZppJ7UQHCnyzWohopZc0+8?=
 =?us-ascii?Q?bgIcYhFyaI8wM5h153/D6VpXcZPFUkGUcfXcPqI7GRCkv/YbHrLpYlcVMTeL?=
 =?us-ascii?Q?0+I6iVWUGfdC1zi7BPvk85dXEtGWIKPuihJHFQ70XlI5eTFO2AWw8tqwKU3n?=
 =?us-ascii?Q?9hh0Q0ggRtcrXeSypN3dcaW1P2QQaEHT9cMgOi1XkiQPdsPAZwKVgc7KaMlW?=
 =?us-ascii?Q?2havhkLRn/fRDxlRpzjhtQVcgbw1Q4J14IP/GQzFmxXHeSo0Yo+atP3/91oT?=
 =?us-ascii?Q?MXv1kkb9p4ohQFQZOWECvJkW9SM09TV3DokrYXAhEzg6A5uPd5BFEbMFUx9c?=
 =?us-ascii?Q?Mih9/VZGo/NvQs3b+3I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 08:19:55.8276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b77943d1-a0f0-4725-6e4c-08de018c784f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
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

Enable SNTP/DATE commands on all Xilinx boards.
Also enable RTC_EMULATION driver for platforms which don't have physical
RTC. Enabling DM_RTC is enabling by default also CMD_DATE.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Enable CMD_DATE via enabling DM_RTC with RTC emulation on boards which
 don't have physical RTC

I will look at moving some options to generic/shared file but not now.

---
 configs/amd_versal2_virt_defconfig       | 3 +++
 configs/microblaze-generic_defconfig     | 3 +++
 configs/xilinx_mbv32_defconfig           | 3 +++
 configs/xilinx_versal_net_virt_defconfig | 3 +++
 configs/xilinx_versal_virt_defconfig     | 3 +++
 configs/xilinx_zynq_virt_defconfig       | 3 +++
 configs/xilinx_zynqmp_kria_defconfig     | 1 +
 configs/xilinx_zynqmp_virt_defconfig     | 1 +
 8 files changed, 20 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 72c53ef5f3aa..caf4aefe898d 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -48,6 +48,7 @@ CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -120,6 +121,8 @@ CONFIG_POWER_DOMAIN=y
 CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_SCMI=y
 CONFIG_RESET_ZYNQMP=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
 CONFIG_SCSI=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-generic_defconfig
index 07612ef5e932..0043aa8a9ab9 100644
--- a/configs/microblaze-generic_defconfig
+++ b/configs/microblaze-generic_defconfig
@@ -49,6 +49,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_SAVES=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
@@ -93,6 +94,8 @@ CONFIG_PHY_VITESSE=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_XILINX_AXIEMAC=y
 CONFIG_XILINX_EMACLITE=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
 CONFIG_SYS_NS16550=y
 CONFIG_XILINX_UARTLITE=y
 CONFIG_XILINX_SPI=y
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index e3341179a682..88d9e5ce6b2b 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -32,10 +32,13 @@ CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 # CONFIG_CMD_MII is not set
+CONFIG_CMD_SNTP=y
 CONFIG_CMD_TIMER=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DM_MTD=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_XILINX_UARTLITE=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index fb031d613190..323b56065660 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -46,6 +46,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -122,6 +123,8 @@ CONFIG_ZYNQ_GEM=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_ZYNQMP=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_SOC_DEVICE=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 39c7bd472ea5..bd6bfb7deacd 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -52,6 +52,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -132,6 +133,8 @@ CONFIG_ZYNQ_GEM=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_ZYNQMP=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_SOC_XILINX_VERSAL=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 4412f52bbd2e..a868e11411d0 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -71,6 +71,7 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND_LOCK_UNLOCK=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
@@ -138,6 +139,8 @@ CONFIG_DM_ETH_PHY=y
 CONFIG_MII=y
 CONFIG_ZYNQ_GEM=y
 CONFIG_POWER_DOMAIN=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
 CONFIG_ARM_DCC=y
 CONFIG_ZYNQ_SERIAL=y
 CONFIG_ZYNQ_SPI=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 332e94011877..8ad05e371892 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -82,6 +82,7 @@ CONFIG_CMD_SDRAM=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 6bb6a8c9e9ea..525744b0f61e 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -81,6 +81,7 @@ CONFIG_CMD_SDRAM=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
-- 
2.43.0

base-commit: b8889ad5d3a625505dca9ac9f0a164e7587baabd
