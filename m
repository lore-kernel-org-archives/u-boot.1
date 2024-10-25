Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99549D0C602
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13DB888FCB;
	Fri, 25 Oct 2024 13:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GjRX+Bxe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EFAF888EB; Fri, 25 Oct 2024 13:56:39 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9763488FCB
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjFuwfhZj1ibvinqdDuqax8Phn3KjfYkb4tjwiqNZWilldl62kYAHAas7vfpfNYmTS3XqSx4xvOji4e/Zq8NMgMyrEcKEjkAsNNo9M7bpXi8MMEdoLGetygRKwjWcndOBuy/SclpW67ZVG1OgyEceiiTTc973BQQdM8uG2UputnhQSv9f3WQjOGMa0sZQnq0uOVeZ+Ccb1N0EczHH1ayRZ+qUQM6sMUfDrTL3oi01LZ24HJjx/pV2pPNnLyxFsobf3B1S+rKkLLy09jbuE+RJHzu8rjTF4QnXM7sY52BDUVtkcUV9lt0JdE4k8P3L3QR+uL0H/zRySNxrO5Ie6EbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFRFD3Hhtyq1cgzUhsojXosbOdPrGJa8J4zNs6Ta9Nc=;
 b=teTO9LOh0O3qprSLQ6zMjFG/tikpHtxXws5ayrsclY7YwZtS87qExhTYBHr90lDNvJD8oDCDkKO8yAhmPD+zyFTkby5MQdqqfiyvqCukiZTzrXEBgcJPDPZ5V9K3wgAtRlFn+IsymtY5FrxwpviSMUS+6R57UrIZEVySBMeUQiYoAWqYs2IxxuY4TrBvPVMYg/LmisFkgztWdyLEkcea42793XRFM0tz5dPQ67sLJU41VdR/EEeVefe9TH5BfK2uYEew+irl7fFAYyo8mKxFB/u19XS9Pp05Az/dVuhoW9ARenYKAUEhGRJNTG3VAYxZCtis34mkebgLhS1yk55+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFRFD3Hhtyq1cgzUhsojXosbOdPrGJa8J4zNs6Ta9Nc=;
 b=GjRX+BxeOzWnyhClKThAl5muMM8PYUfZD9LYW3XnrlxKp5ht8Vi+l5Bm0Ym2NVdI0SqNMv3sk6gf/G8JL65pLKJouZSu6RCTMpRMeu/Ij9IMJtX1GnSE5shAsGNm5Zu1FnipAqQ/Q7huOFYGD23Vfz9t+S3a4ycfV/vvNnZvR4A=
Received: from MW4PR03CA0286.namprd03.prod.outlook.com (2603:10b6:303:b5::21)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 11:56:22 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::60) by MW4PR03CA0286.outlook.office365.com
 (2603:10b6:303:b5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 11:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:56:21 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:56:19 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 2/2] arm64: versal: Enable capsule update (SD)
Date: Fri, 25 Oct 2024 13:56:08 +0200
Message-ID: <cede513de764b99560dc3737457dbc8a5cc71d21.1729857366.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8c1a5d6148c5e6c46790b725e8148a4e12d393ba.1729857366.git.michal.simek@amd.com>
References: <8c1a5d6148c5e6c46790b725e8148a4e12d393ba.1729857366.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3166; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=63L4nLxfvmt5hkYFa965kVSbQSGDxoMW6ElJd1qbewc=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnTp9pi3d1fMNHJsK2LpK1nBte7j8bKkmxazlNresP+ds
 GFdrcXHjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRld8Z5pe05O1Y+NRl65nd
 Mt4aX1YlXPW9dJZhftUcviuvv6RbJDDb1u26HDdlXVxoGQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 7533174f-54f6-4722-01b2-08dcf4ec0b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Go+Qw7ZwaqqO3Ca4Ru77vtiEW2Waxvf3ihbS+7WFJp7Cq3R48C+lVx+yhBfn?=
 =?us-ascii?Q?jFrnBbnS9VSFx0MF+ADRSTN8T8GHZlxgQfYWV/Qk0yYYotV+XDW1stW4CED1?=
 =?us-ascii?Q?OfXAr671uonqHDZBstbKAd51wNnc1PU29gs+fn5ujoONvVNRDOgQVP3C0060?=
 =?us-ascii?Q?mQ+Oe+hWQBpBAwbuWh+0ezooKnVLkAg1GUFmAYamYdq3rsFatzySmB9AHA1f?=
 =?us-ascii?Q?3zFcufKsEGMKGEr5bFXI4zGEyl2q3/dcHAx335qGt3+LbeMkdVhzI7ejO08Q?=
 =?us-ascii?Q?5zyEzRCZ4FxSfUbfXLT7T3/1ixlqq5Bfq3u+LmL1tQkNCIrY8Z6/VIgHzFRY?=
 =?us-ascii?Q?AoaUQFAoqp7VHkPKKZdizOES+7rSFMvqWlJ4iqGGhiNWXin09lApj/PxgQP/?=
 =?us-ascii?Q?2lxokpNW9y0UEte3hIqY8bHcCyO+b6BzVo8VfrggfgkUj3zvzO4MthKKiqVI?=
 =?us-ascii?Q?wfzajp0LENDJ55OJ1tbLpr8B2bKtsE2aCQ3/NbVhLmaHxKJ/YmUA4hgYYT8Y?=
 =?us-ascii?Q?LU1ddzyhiJJoc6erKBDK/i7C8fUClmGhM4pKC+W5LxKHQ6Fxi8HfgdW8HOjV?=
 =?us-ascii?Q?3ynPum/8pJ/Sv1Qu9se0Duobb0RzHjwCyMRK9DV+nLnYBcmqKxhy2CJVp44Q?=
 =?us-ascii?Q?8eXQXcwp7HN3aWyYZy3q4L0UM+d3Zxo6Z5mBVwLHxT6Gqxo8wFxw3YDb7FWv?=
 =?us-ascii?Q?0YJniU5GdhCOnhfENCm/R6Tk993P1iXraZrefNTzmd9FSvFvVSMNxv8sw+Y/?=
 =?us-ascii?Q?mzNy6zGMMU/AIaASLpKyhFtAq2+O9RDedsaBKbzZqlKrfpo3zkrTUrlTQ3Ds?=
 =?us-ascii?Q?LODh0mnq1xABODPEZ/he8GquW/PPgNb5h0IYFwgvBaFnjQzHXgQRS+nbE2Ge?=
 =?us-ascii?Q?g8Fh2GXkggCSKbYcz7MIuK5HBTD58sYarUVBg+1d5w/ALTYx0tQG4X9MoV7D?=
 =?us-ascii?Q?J3CFp6uhkUC0dWZ66aeDLI75oh7CIxkNg+O03AGigCeZR2iuh+APGUl6mEgE?=
 =?us-ascii?Q?QoRMhDVRPn6S8YL5h0Xw7ctLiF2R8+6eExG3DUwkZrKbYSp7uQgA9vI1xGfJ?=
 =?us-ascii?Q?8iF/yOBTLA6sGR/YGy+CRWZA3VqO72Qm7tg0v8h47NNhzSAcH49jPngFbBAx?=
 =?us-ascii?Q?s3JgeCfux0u4CdKqMD/wUOFkYmDK9tTbzrIHAZ8jl9qvyms3TaNoa8Q7Rdoa?=
 =?us-ascii?Q?LrBK4F1EWavTYNg+WIzXjqNpp4tKyXyONjIPQvzw/N1sWhDQlH946HzhxcOM?=
 =?us-ascii?Q?+M3o5rcqW7CDEyodzRz6Fn7CpjZ0j+TqWXh8Rmr1cI0nmp2HdoFhSWIOLDWg?=
 =?us-ascii?Q?aKBKhhd4Zw8w+sNnEN9fgOz9zQY4ddhOZrNs3HCiLVXNiVyNQVKzl0dsh99h?=
 =?us-ascii?Q?QLGnE4AdGUYtUY+EImsZ+2Fn3ZNiV0gOc+Ualv7sYBm2rQZFzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:56:21.5178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7533174f-54f6-4722-01b2-08dcf4ec0b32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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

Enable capsule update in SD boot mode. For getting it work there is a need
to generate or setup dfu_alt_info and enable sysreset with DFU_MMC.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/versal/board.c          | 41 ++++++++++++++++++++++++++++
 configs/xilinx_versal_virt_defconfig |  8 ++++++
 2 files changed, 49 insertions(+)

diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 27c1cfc6558a..fd5c6ced7956 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -12,12 +12,15 @@
 #include <env_internal.h>
 #include <log.h>
 #include <malloc.h>
+#include <memalign.h>
+#include <mmc.h>
 #include <time.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/sizes.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <versalpl.h>
@@ -338,3 +341,41 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	}
 }
 #endif
+
+#if defined(CONFIG_SET_DFU_ALT_INFO)
+
+#define DFU_ALT_BUF_LEN		SZ_1K
+
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	int bootseq = 0, len = 0;
+	u32 bootmode = versal_get_bootmode();
+
+	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
+
+	if (env_get("dfu_alt_info"))
+		return;
+
+	memset(buf, 0, sizeof(buf));
+
+	switch (bootmode) {
+	case EMMC_MODE:
+	case SD_MODE:
+	case SD1_LSHFT_MODE:
+	case SD_MODE1:
+		bootseq = mmc_get_env_dev();
+
+		len += snprintf(buf + len, DFU_ALT_BUF_LEN, "mmc %d=boot",
+			       bootseq);
+
+		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".bin fat %d 1",
+			       bootseq);
+		break;
+	default:
+		return;
+	}
+
+	env_set("dfu_alt_info", buf);
+	puts("DFU alt info setting: done\n");
+}
+#endif
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 32c6bcd2078c..72a74f300b2e 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -4,6 +4,7 @@ CONFIG_POSITION_INDEPENDENT=y
 CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_VERSAL=y
 CONFIG_TEXT_BASE=0x8000000
+CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x100000
 CONFIG_NR_DRAM_BANKS=36
 CONFIG_SF_DEFAULT_SPEED=30000000
@@ -18,6 +19,10 @@ CONFIG_DEFINE_TCM_OCM_MMAP=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_ON_DISK_EARLY=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_EFI_HTTP_BOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
@@ -76,6 +81,7 @@ CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_TIMEOUT=y
+CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
 CONFIG_ARM_FFA_TRANSPORT=y
@@ -137,6 +143,8 @@ CONFIG_CQSPI_REF_CLK=200000000
 CONFIG_CADENCE_OSPI_VERSAL=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
-- 
2.43.0

