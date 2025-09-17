Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF614CA0EE8
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 07:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 148C58344E;
	Wed, 17 Sep 2025 09:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fmu4wqpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A65598334F; Wed, 17 Sep 2025 09:22:56 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF420834D4
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 09:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uF5HBgQJhI7GMuIxRP0STDK8CpgMyEUsuvX+QxlkWQAr3o1NMX8VmiCKuFXQ4ITpURsnslBRpxrHa50UE5EQxlwolae3rvwqu9jdx7SxM+uzZejiOHLccN0cKtJlkohhjHTznhDaTBhjqfx9yvnSIhZ02QGC4beACLc/6ZSTRbFjmwFmx6s14E1HsAV7x8AeyiAyApJCgc659OZfLG91ZG3YlEnZbyyy+iN9EgkNug/rJZeaDfQvY89lBgVQxAIYYkUTBVlPlcQSqKOE3eiqX3lPZs710hti1oQIBlsYe1fTFpjCnH538RcGBmdYZl9ze7qz+++rySiQrSXZ6ROrLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QihzJEeL6QIH6VtEBl2utjh5Sv6EXPLPBYcee9MCRXk=;
 b=XX/7x4xyti7GI3f0QxysmuKVLTmr+6a70UERZKvrUids2rTUp/jefP+9Kis4r02KpTfxNc9+vOsefbWW4MDfVqYbaDg/a16azZ0u6S4uLxHXnxqld7uJ24knV1WaGyJQzbCISO2cBbKZuLG1ncynJqlVjMBL02Fr12osqNLO2XZJGf5DfmGyN+EQYAM9gn7FeZLlYoYYPf4GbI9GY+X2hy+/JLBw/q3uo+MHBftQ1vbU/T3P4lsXnIaggDSz7KVKXEtvHvG3upBOu+yadkumuL0tAesLmIN4s5wXA4B+eE9osry9fb7Ev3oSTxeXKfGkOoeiAOvfNmgJdwq+fkdSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QihzJEeL6QIH6VtEBl2utjh5Sv6EXPLPBYcee9MCRXk=;
 b=Fmu4wqpNv8/V4/LY/9jBB7XNI1pbX+OVcIiYGShoEpOFo26/0QLuswtFEtRDo+RIxiZzRVf+btrewclLa1n6jpZHca3e42OzscIrZ9BboS7EjMaHlsmwdL50cJULZjGjZ+AyBdbq6XympjkHdVoHHiP3/Dk0fDjNPm9vQMwXpqE=
Received: from SJ0PR03CA0195.namprd03.prod.outlook.com (2603:10b6:a03:2ef::20)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 07:22:49 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a6) by SJ0PR03CA0195.outlook.office365.com
 (2603:10b6:a03:2ef::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 07:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 07:22:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 17 Sep
 2025 00:22:30 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Sep
 2025 02:22:28 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 17 Sep 2025 00:22:28 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Tom Rini <trini@konsulko.com>
CC: Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Disable SPL_OS_BOOT for Zynq and ZynqMP
Date: Wed, 17 Sep 2025 09:22:18 +0200
Message-ID: <6846ac4ca29c1156cd8020c19584bc26c2727d58.1758093736.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3192; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=shwG9pWV0ptlVKJ0c3Ntsol4dC5qOAMYJ4Bxbiwt+GU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWScSlyrdPyxpewmA4scPXMtD9tTWd07+o6fCZhmwdPad
 /yVhwhXRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAExk3xVGhkk/nb+8Yar/EKp3
 XmBdPs+npBWRS9sUT5ft8124ZfFF7xiGf/onnmS8n+PIEyI9R+HTeluG9GyjMq901gstnJpG6/v
 zmQE=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: f5213c2b-887e-419d-275e-08ddf5bb019d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WGgLqnOQAyshszP3cWrx/nIwU/njKbW3/LTMtbes6jp7Uq8a/frBLaglDSMC?=
 =?us-ascii?Q?QcCaDaMJOArR+W/gnbUIaXtED1KdVtyT3Rze6Gh9hFhbKRWlxjPVrEd6QGeW?=
 =?us-ascii?Q?GsoIhDY5JLHICZwTchCvOQcVdPRFDBkfbF37dPWk/igedXijUzEhcDX7u3AK?=
 =?us-ascii?Q?2DiKy5WObabUvO9GwQt6cj9esdnLJc13nxoLdXItbyKFcbcJ02LDjB4BGIKv?=
 =?us-ascii?Q?v4x4VDtaUC4DtBZbyoMiDtpzNniLYt5hUk6mIgGviQPoTKY+OZKRurYlku5h?=
 =?us-ascii?Q?a48AofJmr2yO6dn1rF6MqfdGNGMW79Np0zHU02T8QnwLLRxo0LpDd4xEDtzq?=
 =?us-ascii?Q?ezGWr4kfAmPsBBmHpbJkJFO5moRsQeUD4drxeYdVEPdj9Ip41VxWdRLEhURZ?=
 =?us-ascii?Q?MVlAOH0z6FV5F/xiRdO97pHjr0WC5Qi4rkBYzdXjMvIVaNY7n0Xe/PQFmxgT?=
 =?us-ascii?Q?t1ATy03YiOCMUeZTKVnQCEQdCqKgFo87B7rLd6uHn4x8OgZncDOCb2Tg+5c4?=
 =?us-ascii?Q?muxbASZi8HC3SOggtsPZQubrxnJGPVp+l3SsP3s+Mw3pmHALRX2v4nXsljNC?=
 =?us-ascii?Q?X1XBOxqZHo+NdqTtCKjt0mPhFNvQQ/6vWIpTfhXYVB1QBdk2kYp2FD31e7ai?=
 =?us-ascii?Q?HFF8l8A2bq8Fy5+qLm/0NNVxjiGK5itzBRIg8KI1SLWyWKTltM9dsJ3F9WxS?=
 =?us-ascii?Q?YirWG6V0sJJkWf8+oF1xDThWPvgDg6dU+LecnO3sJ5hXNPEgWvTbi/XKqnpj?=
 =?us-ascii?Q?q+iq67AcwPC1wNSeRa8nRc0wPn9zLVwS7dyRZOB7KX98Yqj1sT7USHvLHSTU?=
 =?us-ascii?Q?74x3pxBT+nwpUCNpoaae5MEDBk8tpIL+LYxNJkhB49olWxOXWqxTkFHMHJok?=
 =?us-ascii?Q?PrPZLSj40/N1UFyqcIRAOF/7MdcQSBkMTiECcQx5HtnXz4zd7cClYsFmdzKg?=
 =?us-ascii?Q?X/YqorHaH6ea+/RfaCZmfk2o47ZKfCN5ghV0rxnfg+NZbmUN9zzoKy4itTHJ?=
 =?us-ascii?Q?iPcDkAlpTRk4H3zq9Du5m1zKtdydgJ3/2E8qtfpNvT4CfZbFXGTeTlK+5WbU?=
 =?us-ascii?Q?WwXILnDtNB4CZ0A0Auxr6Dpo8yEGbdufmAu1OSJOEWKDWyYu7Tdy8W8kGdpb?=
 =?us-ascii?Q?62jhURzF1usGFqy4Jxrf/6JG6nHPOeXoEXVowRzD6WL03Z4l9V/yY5DOmpdO?=
 =?us-ascii?Q?KKTSvfAP76wzFgS26qgroVieQc4Cj/gl7CBIDj0F1P7gnWFXQk/LjobEXCev?=
 =?us-ascii?Q?F+iOavxCJT6NUpg6mE2rQ9RhCxFq1jplTsuf7eZ4n+gXCxK0qK5F8/VzVJQh?=
 =?us-ascii?Q?KXC7zXwf2XySjvNG6B1syqXmYG2nAjGPuf/zmUlPIKAJ6LWvR5LxoIqEG8Up?=
 =?us-ascii?Q?vJpmQCvM5O7xbzsVx/juwrNuWm9jeubaXM+IDCpXhDTBq2uh92eCuXdhOGqb?=
 =?us-ascii?Q?6bbMDq3VCJOCtfaGOdWsKrd4FYF+RknAV3y2XwIrQMiOK7mcsGVZNnvZI083?=
 =?us-ascii?Q?FY24jJSnivG9zCI5oijT7YHZLFE0fxSiMeTu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:22:48.9909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5213c2b-887e-419d-275e-08ddf5bb019d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
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

The commit 210702ae6ce8 ("spl: spi: fix falcon mode for spi boot") fixed
the logic of spl_start_uboot() where 0 means OS boot and 1 means u-boot.
Zynq/ZynqMP enable OS_BOOT by default but it was never really be used
that's why disable it to boot via U-Boot phase all the time.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Tom: This is must have for v2025.10 because above commit caused that U-Boot
SPL is not able to boot TF-A and U-Boot.

Tested on: kv260, zcu102, zc702 and zc706

---
 configs/xilinx_zynq_virt_defconfig   | 6 ------
 configs/xilinx_zynqmp_kria_defconfig | 7 -------
 configs/xilinx_zynqmp_virt_defconfig | 7 -------
 3 files changed, 20 deletions(-)

diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 7a7abf66eb5e..4412f52bbd2e 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -45,15 +45,9 @@ CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x2000000
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
-CONFIG_SPL_FS_LOAD_ARGS_NAME="system.dtb"
 CONFIG_SPL_FPGA=y
-CONFIG_SPL_OS_BOOT=y
-CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x10000000
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
-CONFIG_SYS_SPI_KERNEL_OFFS=0x280000
-CONFIG_SYS_SPI_ARGS_OFFS=0x200000
-CONFIG_SYS_SPI_ARGS_SIZE=0x80000
 CONFIG_SYS_MAXARGS=32
 # CONFIG_BOOTM_NETBSD is not set
 CONFIG_CMD_IMLS=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 3e2ac6144050..332e94011877 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -51,17 +51,10 @@ CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_BINMAN_SYMBOLS is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_FS_LOAD_KERNEL_NAME=""
-CONFIG_SPL_FS_LOAD_ARGS_NAME=""
 CONFIG_SPL_FPGA=y
-CONFIG_SPL_OS_BOOT=y
-CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x8000000
 CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
-CONFIG_SYS_SPI_KERNEL_OFFS=0x80000
-CONFIG_SYS_SPI_ARGS_OFFS=0xa0000
-CONFIG_SYS_SPI_ARGS_SIZE=0xa0000
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_CMD_SMBIOS=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 65c8a4bbaadb..b45ac8063fc3 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -48,17 +48,10 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x20000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
-CONFIG_SPL_FS_LOAD_KERNEL_NAME="atf-uboot.ub"
-CONFIG_SPL_FS_LOAD_ARGS_NAME="u-boot.bin"
 CONFIG_SPL_FPGA=y
-CONFIG_SPL_OS_BOOT=y
-CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x8000000
 CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
-CONFIG_SYS_SPI_KERNEL_OFFS=0x80000
-CONFIG_SYS_SPI_ARGS_OFFS=0xa0000
-CONFIG_SYS_SPI_ARGS_SIZE=0xa0000
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_CMD_SMBIOS=y
-- 
2.43.0

base-commit: 2dbde3f9b08771b8182fcbf0bb0309acaff6c2e1
branch: for-ilias
