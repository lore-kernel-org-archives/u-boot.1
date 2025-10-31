Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDDACCF9EE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 07:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E01CF838CE;
	Fri, 31 Oct 2025 08:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TdUf3hIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3013E838C7; Fri, 31 Oct 2025 08:38:16 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27DF68331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqvfwywgFDZuN4sIaPz2ZsmTn+Ig+vEmPcqOjrX1h6EDkeZiqxDq+FpRBRLUf9Z6VFjucwRl5MnT1WR0kUGnN4Gk28aX6/ewxafJT63NnDr3NYcSKTw9glcQeWS8J/gDyJ87OL+nDznestfi8FuysW3rUWNlgErG5fJ9yYzyIept/YQfiRnjvm193+ekfvdAitwB5jl+LArMiGsBJopvc7f9ApNqi7iRAoBUAZtXLGjdNLWsq6dDZkAiECTUJ3gzze1h65kC54YnQAG23UVr6SwLrumoODMrIn1HNYGBZI1mFCSwqi5N+XUyW+r9EabZpM7ecfZYFaOqTXWdIozzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EGSddeXYDIxzwwfS0DJvLiETRqgsvhn1oAa5S9QXMs=;
 b=gD83QsijclFUOffcocq2BhLNZb3fTXoZToli6H/AwPYj6bHIVYtH+MtFOXSLI0w7mSGuoFz/4qGg2mq4GEEEsX5dpJtrdGsO72meQy31+ep1QkO/yQ6XKqQF19YGn09Iy6SB6WxwTzrvgF373j9GGcAUbiH1+/TqjZozRsVq4/ExdFn8aGFsQd5BLnZdWRkMzyMlRU4ZrAGP39KFzGI/TvJaY8qEavc5d/9Kmaho3+HsJ0/xLya7+4PfYOwhY8hxZk8lE1Rs4B6lLhY7kgv6jvCe5CvVFSTHSvxmtPxmTUmwhB1LXJPuylH10JJh2kgrEH+IOMjioStlAOmRTuoNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EGSddeXYDIxzwwfS0DJvLiETRqgsvhn1oAa5S9QXMs=;
 b=TdUf3hIVb5OUOvcq7c79z+rr1jBlHniBhh8r6qZK0PQEjLVYD5E41jjZsPyoAE3ts3IAqM4FSf6ZljZegPEiQK0mQggEaaNZfDcW6f0PsCpW8GKPC3xFdneM8XPJ4oBQmIBaNQScRbziBX6QRjoV5fXQY5LBaRNGnc3EtwaRe/k=
Received: from SN7PR04CA0037.namprd04.prod.outlook.com (2603:10b6:806:120::12)
 by DM3PPFAA42ED99C.namprd10.prod.outlook.com (2603:10b6:f:fc00::c41)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 07:38:11 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::18) by SN7PR04CA0037.outlook.office365.com
 (2603:10b6:806:120::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 07:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 07:38:11 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:10 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 02:38:10 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V7c9AH3539928;
 Fri, 31 Oct 2025 02:38:09 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v10 2/7] configs: add falcon mode fragment for k3 devices
Date: Fri, 31 Oct 2025 13:07:52 +0530
Message-ID: <20251031073800.344500-3-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031073800.344500-1-anshuld@ti.com>
References: <20251031073800.344500-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM3PPFAA42ED99C:EE_
X-MS-Office365-Filtering-Correlation-Id: cd773b54-c660-41cb-f209-08de18507185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zS7S8PSR0js35DB9dfoNyfEQMOsegaHcvXyPz5I7EbOJQ9a/gFM08aayybFA?=
 =?us-ascii?Q?G3RsWvq3vCjJ4o7brYAF3M3spsK0Wv7190si8gTFFIGD6mqAwxzW71uFlv1n?=
 =?us-ascii?Q?SeNH0GIP7fZ97iwvyh+sz/OofXc/5JjgeFvs30QTxDRrKWZ6YlZH6FXaRd6p?=
 =?us-ascii?Q?XUYGwOtzI6GfnfKRickzX7EDPqmC+I8syx+dfEDGxGIbt3YCHDdYjCHY2RSt?=
 =?us-ascii?Q?Yp2j7qz7m9iA2H+7V+TQQTn/AAQGvQq5+2YBILwD9ybeh61rWaawvNltRmEf?=
 =?us-ascii?Q?FoBGDoovt4+biQ6F4ZvpzHDVlY06BGTTltQzVoSb1ukqDBu6W5hCcauI61sK?=
 =?us-ascii?Q?Ca9vfPLONk76c7YL9/I7OTshOUTmKmgMDvxZ7nuXF2izyY4qah8hPwKutpDv?=
 =?us-ascii?Q?pXfK4v/GHH0o2xPsiMfMBB3jVgU/AcXaZgwvHSLM00rRTrN8PkouLIaa45Yz?=
 =?us-ascii?Q?jbr1oIv3A+T9jHAS3P481Gvj1Ah4HOXpCdPZqDyqgoGcaTSpBAr7tn3ayMH3?=
 =?us-ascii?Q?S6bAprZbi83nH8e1/iNoW1BXw37jkHpNaUMHLRqmPeGzPdwpfGNVoJ7+4hxT?=
 =?us-ascii?Q?QawkvNTN764AD3UlILHgCgsqHvu8r0iwqYLb4eYoOqK+qXsvyGi/g0+zQFc0?=
 =?us-ascii?Q?+IvphJbybe+nx16tm0T15EMPen1EL00C09ihtBazVZJ/ctOgNzFqqqSA5TnM?=
 =?us-ascii?Q?o+stiNqtAohfksV0yy5BX2h3PXTkVO7PO19fnAyEglPjghWqwEa4AGZ4Wdgk?=
 =?us-ascii?Q?sh+ksdGagYQbIttcxsI2PDszob49oFsJHFFqcwBWkpJN74o93HdNXdhu2CHa?=
 =?us-ascii?Q?3u8GZqzQVqQWsPaLjFrByRyuWzP7/6Y1SoofCEgn7wRV2OENDHhzZj5AYhsH?=
 =?us-ascii?Q?JNIj9BBBr/6XBClTM1NIT7eGOeDfDs24+Au1MPh8gyRkBWw6rVzL3Y8EPR4E?=
 =?us-ascii?Q?iHx279KJZpZPM1ioVasT8f/2ZQQGi2s2H0TWGY3qmqjlVlo5nuUp2a7EQlNj?=
 =?us-ascii?Q?1FrXS2V8iv+2vclRLDn2ywTzrjWMhtLNVlWsx541qAeNCeIBkMkEtTiafoaY?=
 =?us-ascii?Q?anGPq9iLOcD7VpWT7sRClCMv7+JdMJPOmyS+E7l3Km0AysPaywzM7JcSO7ER?=
 =?us-ascii?Q?Y43tQnFWJ9/Tfrg+z4QVNxX5Urmf6K9iaEdWnY519cZ+6RpA7Fi9qcmEU8hG?=
 =?us-ascii?Q?5MHEhc0LSpUXmmZeq5xUH7qejTXlggdj9oIcXwMvm/QEtVnG9s6hN4vAoZZP?=
 =?us-ascii?Q?HDMflFoFTaZJG+WDU9YXccmV0Fv9Po+NDyF7jCKYfspneN4grNG4pO1KhYnK?=
 =?us-ascii?Q?T9zfkwfrX4ieWXEs8R97XP3QU6WEBA4zWMd8mbigYdAF5oPAj03Uti8HrpkE?=
 =?us-ascii?Q?QEZkeGa4gCxyb9ZKRVEAihnZoWj8uiRUzclCWCmNqpbbuCFDiPjTJx62SkU6?=
 =?us-ascii?Q?WIy5pHK3hP/hahYJiLoOiRjBi0yUlGX5N+VzT+4aQcIU1nDoGeT8bW03UU4l?=
 =?us-ascii?Q?jjMl7FAyCBYyppzFI9Dsn5VFzXqErttMFSDLDjksVRIjgrPXgYadvrW7Rgoi?=
 =?us-ascii?Q?NX8DKsuTKBf4Fls06hE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:38:11.3795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd773b54-c660-41cb-f209-08de18507185
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFAA42ED99C
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

This fragment enables falcon mode for K3 platforms and modifies the
memory map.

To have enough stack and heap space for loading kernel image as
FIT the memory map was modified by expanding stack + heap size, the
PRELOADED_BL33_BASE in TFA has to also be updated to 0x82000000 since
the kernel needs to be loaded at 2MiB aligned address along with
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
index 00000000000..b6762b35f74
--- /dev/null
+++ b/configs/k3_r5_falcon.config
@@ -0,0 +1,39 @@
+# Enable falcon mode
+CONFIG_SPL_OS_BOOT=y
+CONFIG_SPL_OS_BOOT_SECURE=y
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
+# We use the rootfs (i.e partition 2) for booting which is ext4 not FAT
+CONFIG_SYS_MMCSD_FS_BOOT=y
+CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=2
+CONFIG_SPL_FS_EXT4=y
+
+# Loading tifalcon instead of tispl which has FDT and A53 SPL saves time
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="boot/tifalcon.bin"
+CONFIG_SPL_FS_LOAD_KERNEL_NAME="boot/fitImage"
+CONFIG_SPL_LOAD_FIT=y
+
+# Used as the 2MiB aligned load address for kernel
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_SPL_STACK_R_ADDR=0x88000000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
+CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x88000000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2700000
+
+# Disable all unsupported boot media to save space
+# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
+# CONFIG_SPL_SPI_FLASH_SUPPORT is not set
+# CONFIG_SPL_YMODEM_SUPPORT is not set
+# CONFIG_SUPPORT_EMMC_BOOT is not set
+# CONFIG_SPL_NAND_SUPPORT is not set
+# CONFIG_SPL_NOR_SUPPORT is not set
+# CONFIG_SPL_RAM_DEVICE is not set
+# CONFIG_SPL_FS_FAT is not set
-- 
2.51.0

