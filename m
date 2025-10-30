Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55F5CCF9EA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABDA8838E5;
	Thu, 30 Oct 2025 06:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XBLqnELW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5EED838EE; Thu, 30 Oct 2025 06:20:02 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E2EC83887
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:20:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DP1XRXslsWLBiS6th9mWOj91xk/xVzFue1MsJToPxqkucj4s9a1vqxfx/1sCaRELRk7kQat/m6zRIri+ZZpbspsLWnIdKf2D1WSGK0Ivwq0ECRY8dtNuqATamG11JO1O/4PjI0y7zI9Gi+7jfk9gkVfk+Q47sIrQMHXM9LfTgxLm7+w6euXmRzYL5cR1+y3VpAHTKfqoXuA8nyqn9x8tik3PEfmfe0q7nA9SSxHW0hRoPtbYqy0Fhqo8u4CBjKPnLmX+sCl7BBC/4hm6Vkk0Cm+4yuaMjB/alGJ2AcVZWW609fk7TVJGsJG0pMHNo96eOVxEJxhJb2Wn/NadsjiZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiWugIdkjRQHvac0ILG6PETpICznqsxZn0YgqkjgbUQ=;
 b=AYE97un0MUzpSBKn51qsHiiJ2dTlWbHf/47o5F1iXvcpo/mgaZB8SY7PvQXYXGonF9rDkQIprQHL53gZ5iSdRCXYDBK4DMUaZLmsqS2WFHgeD3AlPwc/77M3O1RDeYGxIfsqpLH0UKHwGxsFzkvybTCearXVK99k0ZhSqX/3Tk7WcwDR53aSxhtIFOSdzTtYpIznYx/CA0avGwxVhhK+LyH5ETuPgbRlCzyForFUYO0PHqIqE90P3u/F7yhP1cJx8z801cey/PhOACIESb0kslI7gmVX20zMAwmE4zFnLZmfJo8VimtYRmvyvdk7lUMy5ofSvATbcpPdkBqSX0+LSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiWugIdkjRQHvac0ILG6PETpICznqsxZn0YgqkjgbUQ=;
 b=XBLqnELWHV6qD5BDjTyLfp7Ms623/tmp8UW1rXUPET1kJBnNfiIr0JNyLoveG11ZaLitfP/zSM0VN6LdvdW+qLNbXC4mZG9T4gHnVbjLoqpF0RNG/ab3R1vQg+RU6szwDOxsdXKThGiormtFcWFLM5ZILRva/JQoyVdY0ttU4rs=
Received: from MW3PR05CA0021.namprd05.prod.outlook.com (2603:10b6:303:2b::26)
 by LV3PR10MB7817.namprd10.prod.outlook.com (2603:10b6:408:1b8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Thu, 30 Oct
 2025 05:19:57 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::15) by MW3PR05CA0021.outlook.office365.com
 (2603:10b6:303:2b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Thu,
 30 Oct 2025 05:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 05:19:55 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:44 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 00:19:44 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59U5JgqE1446118;
 Thu, 30 Oct 2025 00:19:43 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v9 2/8] configs: add falcon mode fragment for k3 devices
Date: Thu, 30 Oct 2025 10:49:26 +0530
Message-ID: <20251030051937.3659010-3-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030051937.3659010-1-anshuld@ti.com>
References: <20251030051937.3659010-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|LV3PR10MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 17800d44-8b05-480c-07ad-08de1773f6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|34020700016|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jSfEfXWlLZAqM7HlOmzTy4p7opBoPOu9IVtnIi0RrvZAdM2aQ0T2HRKo5t8K?=
 =?us-ascii?Q?MrAFchz0ZLOeb0dYtVjqBJhC0l6B+JqFvw4ajms2yPMvdES/0F62nmxEQmxC?=
 =?us-ascii?Q?z+zl9GOvhin6X8hiwM6HUNnDcDeyVLfx2ewOC3DqvKKWVfiJq2QXlrlANvR7?=
 =?us-ascii?Q?JnVjksLUbLClFL16yXHsl2LNuHyGX2uVgwy/DwSQ0tIJYF+Basv/i7QHkDY0?=
 =?us-ascii?Q?6BbjBpVqrN2DZuk6mM4czCrJ5+1EverI8lFx/f0vSx2idXnA/15a11V4wu88?=
 =?us-ascii?Q?LN8ooHatwraJfMvpXy/fQkSpTFA5G/i3B0lZwRgdpjET4Bzsdxue9G07ptnX?=
 =?us-ascii?Q?f/wXIf1yAlYAjaHzwcytEm+FMeStneCqJyT9lVeUPvXVkjYcuQwXnVKOsv2A?=
 =?us-ascii?Q?NmAu5ajldlNEnR9M+rOen1qgsx5v5upK8qCFHjXzqzYEHMZkTsToV6adXf56?=
 =?us-ascii?Q?pZW22/ou3UPB168NBL0RqshrDlVpsDcFDmGK8mLOoKtDplI0pnshjq7v7l93?=
 =?us-ascii?Q?8I3gtxkYA+jLZIZ3YlMd++4VmV+PQpMBp5+Out2JW/0tAevHOqBVSpC5J8r3?=
 =?us-ascii?Q?Zj6I3Jw9VJ+Q2GFFKbjWNtVZUaJL1v7kzadrdfUBphqLpJdwgaeItrgJ0q2O?=
 =?us-ascii?Q?zknPCbOw5Cbn/6bsEcFlGZ0EdjAWAcQq0FayJuc7kFPBaDituiMgbpQDFdER?=
 =?us-ascii?Q?V8p8DmfhtMgG9PPAmxfZ3VxzWrQj0xFDhxy9hqhjFJds2iqMnX7Qd2Y+zzil?=
 =?us-ascii?Q?dkcnmxEKVvDhlFKp5I9uhSMmM/RC3r/hRnUN9j+5kQ61OwV3Kuoj3kwIl5Wm?=
 =?us-ascii?Q?ekvoAmZn/Gmqw8DTH7azLq02Z2A0FjCgj13GZkzCj4dS3s5oG1317qNN3LZt?=
 =?us-ascii?Q?9VG4uj1N+8+rr2QYEbBIdxNvUBvFdiTn2PGFwdOjKBNfRwj07wL0IO8+Wjox?=
 =?us-ascii?Q?ybtegzPdD+DcVxrHl40JBx4Up4tj8OxGmeFL9+o7rpaKMsONkv6ypOVgQ93w?=
 =?us-ascii?Q?ltbELsfC3GGz54AFfitoeW6dzg4Im4fYgDKiNYXXy3kBgwuSQkXKSZE+IE7b?=
 =?us-ascii?Q?Wr5eG+voNK+HgkbDYRoQ23hr1UKLNEn2A6bawuN5z1vwXoSjaGCDq4h11ko2?=
 =?us-ascii?Q?3mVuHrLYOWbiPc20gmtxd5LuT9g6teC6CUgMqt3OL3ep9KG0ZLr8+yFvGzl7?=
 =?us-ascii?Q?NE3kW/vwTF5SuPggN3UIpbS3oQGUCPkyIgzlrEmMjvuAvvlYxiIQj+yTnBru?=
 =?us-ascii?Q?9tLFKBPvP/arMoUbLhw8oBtgXo3nXKI3SJ5wseLno/5omWW1FIfK/is6q4hf?=
 =?us-ascii?Q?qJtIZ6OM8B8Nyfo2VV/ba6EOQPV/IUDvkhfNuOvJQlyvSrzh6U2WFJ+wx6Vo?=
 =?us-ascii?Q?ZsHGDy2IzfnerY1fRirVO88mfrbyBP11abAp4s1XnWisjd5U8lMXgkiIu8u5?=
 =?us-ascii?Q?LzVjDFLewBLqeZIdfDFY5KtMkfM+G/DX3nIs+8W4lKalwuCdGkgv+MO/21fl?=
 =?us-ascii?Q?mQSqCZ2wiVllb6J2wYjP/Lc9gWwexEqPLhLWfnLUL5HZ7dSnJK6LsAqI/Cnb?=
 =?us-ascii?Q?8n6EwAyGE3EcCH6adRk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(34020700016)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 05:19:55.8875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17800d44-8b05-480c-07ad-08de1773f6a2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7817
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

This fragment enables falcon boot for K3 platforms and modifies the
memory map.

To have enough stack and heap space for loading kernel image as
FIT the memory map was modified by expanding stack + heap size, the
PRELOADED_BL33_BASE in TFA has to also be updated to 0x82000000 since
the kernel requires to be loaded at 2MiB aligned address along with
updating K3_HW_CONFIG_BASE to 0x88000000 for the DT passed to kernel.

Modified memory map for R5 SPL (modified addresses marked with *):

0x80000000 +-------------------------------+ Start of DDR
  512KiB   |   TFA reserved memory space   | CONFIG_K3_ATF_LOAD_ADDR*
0x80080000 +-------------------------------+
 31.5MiB   |            Unused             |
0x82000000 +-------------------------------+ PRELOADED_BL33_BASE* in TFA
           |                               | CONFIG_SYS_LOAD_ADDR*
   57MiB   |   Kernel + initramfs Image    | CONFIG_SPL_LOAD_FIT_ADDRESS*
           |                               |
0x85900000 +-------------------------------+
           |                               |
           |  R5 U-Boot SPL Stack + Heap   |
   39MiB   |       (size defined by        |
           |SPL_STACK_R_MALLOC_SIMPLE_LEN*)|
           |                               |
0x88000000 +-------------------------------+ CONFIG_SPL_STACK_R_ADDR*
           |                               | K3_HW_CONFIG_BASE* in TFA
   16MiB   |          Kernel DTB           | CONFIG_SPL_PAYLOAD_ARGS_ADDR*
           |                               |
0x89000000 +-------------------------------+
  331MiB   | Device Manager (DM) Load Addr |
0x9db00000 +-------------------------------+
   12MiB   |          DM Reserved          |
0x9e700000 +-------------------------------+
    1MiB   |            Unused             |
0x9e800000 +-------------------------------+ BL32_BASE in TFA
   24MiB   |             OPTEE             |
0xa0000000 +-------------------------------+ End of DDR (512MiB)

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 configs/k3_r5_falcon.config | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 configs/k3_r5_falcon.config

diff --git a/configs/k3_r5_falcon.config b/configs/k3_r5_falcon.config
new file mode 100644
index 00000000000..9ceda7ce963
--- /dev/null
+++ b/configs/k3_r5_falcon.config
@@ -0,0 +1,39 @@
+# Enable falcon mode
+CONFIG_SPL_OS_BOOT=y
+CONFIG_SPL_OS_BOOT_SECURE=y
+CONFIG_SPL_LOAD_FIT=y
+
+# We use envs for setting bootargs
+CONFIG_SPL_ENV_SUPPORT=y
+
+# Allows for the SPL to detect UUID for kernel's rootfs
+CONFIG_SPL_PARTITION_UUIDS=y
+
+# Perform FDT fixups from SPL
+CONFIG_OF_SYSTEM_SETUP=y
+
+# Disable all non MMC/SD FS boot media to save space
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=n
+CONFIG_SPL_SPI_FLASH_SUPPORT=n
+CONFIG_SPL_YMODEM_SUPPORT=n
+CONFIG_SUPPORT_EMMC_BOOT=n
+CONFIG_SPL_NAND_SUPPORT=n
+CONFIG_SPL_NOR_SUPPORT=n
+CONFIG_SPL_RAM_SUPPORT=n
+
+# Used as the 2MiB aligned load address for kernel
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_SPL_STACK_R_ADDR=0x88000000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
+CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x88000000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2700000
+
+# We use the rootfs (i.e partition 2) for booting which is ext4 not FAT
+CONFIG_SYS_MMCSD_FS_BOOT=y
+CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=2
+CONFIG_SPL_FS_EXT4=y
+CONFIG_SPL_FS_FAT=n
+
+# Loading tifalcon instead of tispl which has FDT and A53 SPL saves time
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="boot/tifalcon.bin"
+CONFIG_SPL_FS_LOAD_KERNEL_NAME="boot/fitImage"
-- 
2.51.0

