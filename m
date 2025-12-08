Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390E8D3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 19:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C775383B21;
	Mon,  8 Dec 2025 20:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jfdrmHT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C8CB83B9B; Mon,  8 Dec 2025 20:06:56 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B9DB83B21
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 20:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSuXAeyd3xKDUY2cpvbycyh5nlGSxvZ7QHtTK5WnB3WzObhETlcoPb18NPA7/GD0lRshio300KboRRxS6JqNOp/T5ItIp+uM6n2jVQO873eLU3zWKT/g7RBOWAMIf9CX60quTcEPTYOdWmJrcjEA5QONYSEg6fM3587anr+ITZ/8iiHwqnmYIrpK8SUYk5MwNfTNELV30MBQzVuamw/RFoOmEh5dgaEKKjS/IytEcAUpplbZOa5wumidlMRf3Sjd8APNxcrHBMnVdkJyimSSp/WcWUVkKgRLkrPOd31R/JrnMwq4Q+rsJhapkkAEk+M/uVj8VKVk55lKRlTOLOhFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSF8U+/bf6C0ItJJkf1DwimBSRHUtU+xpCg85CHUWvw=;
 b=R5ocdEzfSabePDyOwkxYKJ46wYARcT18W1wFsd3KUCMPg/aOlurBASEtkMwU27rJS3n07JI4RDAJNXQW6AqO9OoTMwjVsVlNHYfTeTvaQHUx+iHcXRk1WJc+aBxuAciM7dada8Rgi+BVm+K15b3Exg60rD+7i0czDJd24AWsyWiIIxeKQOLUJEJtjwALFLdX3fLF9u5gFqZLBr3yh18y71d8Q4Kz9q8K47mou43GUNEBq17IS4bBFQLjQuI9GBUU3gpm8pQtabbmZi5zfMdhLgPpBkbtp84824J5ecl7/8Bj9rekE3Jkf+NYiFSpiKmUMr/o/XNxP543mLivuaQWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSF8U+/bf6C0ItJJkf1DwimBSRHUtU+xpCg85CHUWvw=;
 b=jfdrmHT4I7aDnh5jNTaqGQJm/REbSmNV/iXrWPoeXk+gJEqs5SgChkvmlTuz1LgaSHj1VxnXM5TTZdtVRQPy/oBnuCF6x57jfwl7lopcta2gZrNvz7E8GuciAe2ID24Fc5sp6NjjP0/lbQdyuA7qg7dNNTGEVK4noVt84R0tGdU=
Received: from BN0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:e5::9)
 by CY8PR10MB7367.namprd10.prod.outlook.com (2603:10b6:930:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 19:06:46 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::83) by BN0PR02CA0034.outlook.office365.com
 (2603:10b6:408:e5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 19:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 19:06:43 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 13:06:39 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 13:06:39 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 13:06:39 -0600
Received: from lelvem-mr05.itg.ti.com ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B8J6crF4121137;
 Mon, 8 Dec 2025 13:06:39 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 4/4] spl: Kconfig: k3: Set common default for
 SPL_LOAD_FIT(_ADDRESS)
Date: Mon, 8 Dec 2025 13:06:35 -0600
Message-ID: <20251208190635.2044082-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251208190635.2044082-1-afd@ti.com>
References: <20251208190635.2044082-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|CY8PR10MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: eb19c94e-0824-4a06-bcec-08de368ced72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ub/fWz5XCCuaVDsj0tJ/6kOz/UV577MuzcYIijZTA25S45468vGJMI52/V9b?=
 =?us-ascii?Q?PXUfqV+lLrSyW5DSGrT5XFl594U6pq5+qiJPyg52z9PdU6NPWDrkw7dzaE16?=
 =?us-ascii?Q?CAIb/tBxmWCwECDV7uKMgdL3d0jutjBMqwPS0tEoAneAidWvzmTkVegplsX4?=
 =?us-ascii?Q?H7NAsLQXMHp8peY+6zcFixbrZwba07XMCyVWkHzTF59G3KQOOWQRhdtpmiCN?=
 =?us-ascii?Q?VBVXZmQXFGkaUJWn5t5dmFz90M1/VFM4qw7NLGRQ69gYxuldh/m8ZVj4MfW+?=
 =?us-ascii?Q?pxJk9ckGmcrKE5Iddcr6mTvBOylcTET0mSnJe1h0L5qpihKvqMuuXFrW96c/?=
 =?us-ascii?Q?svO8EQLCBECiEljVuje6sSM5Y8eWpBPwDSEFsaHa+WBcpxeFiTnWe42jJHbo?=
 =?us-ascii?Q?igN8QvnVUGeu1tFM4FOYSdn8g0jZJWrG29m71iL4p/btiAwHmxoVQZ4NzAkZ?=
 =?us-ascii?Q?TAAcl7fWBs2KKCNp2uKjpdWbLlF4AXnPZNKx/mlIjW2W+GSRdg2uc5aXma3a?=
 =?us-ascii?Q?9iL/n0R+3uj9eBlrntQ7kWdvc0ZXCGyyrY4pt1xvsCP15qIUWbpJ+o/oYaC7?=
 =?us-ascii?Q?pT6Bi/Z3byiEIUREns1v5ms1RWPg9SNv6i6lSC4gnT7gKLnfa+vp51k3GaGC?=
 =?us-ascii?Q?9obtyr6/1iPsbGxq+9DXWbTtXBW9grGIxw7/fo7ChoncT/iWaryntpQbyjAZ?=
 =?us-ascii?Q?r76COQ8Kn4yjamPXBO8XDLmnYKTFfh2XhFlvxqG7dxPIt7elZNdGyiThv+K8?=
 =?us-ascii?Q?qHPIrLXoe0hc6fIveADlAWqjwo/SpUiJxQe/Kim6Vk6s3FGe6fAaiSxiqToc?=
 =?us-ascii?Q?MlsrB/Mn0oFB1FZ6Tfuja6yGujW7z6bvd/l9O+YOv7sTp/1Z/hb46hRug2LF?=
 =?us-ascii?Q?NUoEEi17+m+lP70aVpqn+6avQDyFqRS/VVMyv4GMn7nvMWM43ENXJy1RVOv3?=
 =?us-ascii?Q?Qmx0+yVFniUEVmRn8MqIkkgpd9imMrOwjRTG4kQADZRsQXdI7n0H/KwHa8Hf?=
 =?us-ascii?Q?IAL17dYaxeOFO1C5usyomj4O7ZAUen5G9X1gYIrIO3br6Urzb9Qo6pAq7Iyw?=
 =?us-ascii?Q?XYNUkJ4dy2Pl8S4ow7NlPXQ4ccVa/zPdV0oLBHw64jyrRXM8edh6XiU5YuU6?=
 =?us-ascii?Q?LzZ4ecvvbLP7MDrRBhL7sKVb0O9AIoWiWwe/8kHTjzXyUCT2bjfM2O/v+rCH?=
 =?us-ascii?Q?u4TrdnqkrPpLsc3GQ/gWV9NudnWwcube1bGC4EPXv/FYVXc5EnOiZ3MDg1Xa?=
 =?us-ascii?Q?SCSvRjMxarWpQtwanVo99RZ93aip5YYDhWy4KC2Mt9+tUYaY2UmjgmZVbN76?=
 =?us-ascii?Q?HBn3RrGH/hGB1GCM4xYqGL/LEUx3MTruUOem75rM0Jd7uVzaCWAiKaFQxbSZ?=
 =?us-ascii?Q?+Vx3oz/DK/6UXNmrKyvkT7nOQfvXtoMSTFyiHYDVeF9snxiQ7bDWClhvYmpT?=
 =?us-ascii?Q?IY1cALw4hSEz14PqliLPxP3gF3oI9Wu5kSV9UnzPyJtCkWpfTYzrInIKL2VQ?=
 =?us-ascii?Q?1vMJp2116UXKbtJbupt/hgOIabetrdF1NMPLu4lqLKTdP2hxLRMPIrMQqz47?=
 =?us-ascii?Q?UvmO8YdKqZH2FWg5bFs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 19:06:43.9160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb19c94e-0824-4a06-bcec-08de368ced72
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7367
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

These are common for all K3 based boards. Add the common values as
defaults and remove from each board defconfig

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/Kconfig                           | 1 +
 boot/Kconfig                               | 2 ++
 configs/am62ax_evm_a53_defconfig           | 2 --
 configs/am62ax_evm_r5_defconfig            | 2 --
 configs/am62px_evm_a53_defconfig           | 2 --
 configs/am62px_evm_r5_defconfig            | 2 --
 configs/am62x_beagleplay_a53_defconfig     | 2 --
 configs/am62x_beagleplay_r5_defconfig      | 2 --
 configs/am62x_evm_a53_defconfig            | 2 --
 configs/am62x_evm_r5_defconfig             | 2 --
 configs/am64x_evm_a53_defconfig            | 2 --
 configs/am64x_evm_r5_defconfig             | 2 --
 configs/am65x_evm_a53_defconfig            | 2 --
 configs/am65x_evm_r5_defconfig             | 1 -
 configs/am65x_evm_r5_usbdfu_defconfig      | 1 -
 configs/am65x_evm_r5_usbmsc_defconfig      | 1 -
 configs/am67a_beagley_ai_a53_defconfig     | 2 --
 configs/am67a_beagley_ai_r5_defconfig      | 2 --
 configs/j7200_evm_a72_defconfig            | 2 --
 configs/j7200_evm_r5_defconfig             | 2 --
 configs/j721e_beagleboneai64_a72_defconfig | 2 --
 configs/j721e_beagleboneai64_r5_defconfig  | 2 --
 configs/j721e_evm_a72_defconfig            | 2 --
 configs/j721e_evm_r5_defconfig             | 2 --
 configs/j721s2_evm_a72_defconfig           | 2 --
 configs/j721s2_evm_r5_defconfig            | 2 --
 configs/j722s_evm_a53_defconfig            | 2 --
 configs/j722s_evm_r5_defconfig             | 2 --
 configs/j784s4_evm_a72_defconfig           | 2 --
 configs/j784s4_evm_r5_defconfig            | 2 --
 configs/phycore_am62ax_a53_defconfig       | 2 --
 configs/phycore_am62x_a53_defconfig        | 2 --
 configs/phycore_am64x_a53_defconfig        | 2 --
 configs/verdin-am62_a53_defconfig          | 2 --
 configs/verdin-am62p_a53_defconfig         | 2 --
 35 files changed, 3 insertions(+), 63 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3db5474a05b..0485fe78e10 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -835,6 +835,7 @@ config ARCH_K3
 	select FIT_SIGNATURE if ARM64
 	select DMA_ADDR_T_64BIT
 	select LTO
+	select SPL_LOAD_FIT if SPL
 	imply TI_SECURE_DEVICE
 	imply DM_RNG if ARM64
 	imply TEE if ARM64
diff --git a/boot/Kconfig b/boot/Kconfig
index 85f4d468069..14c59ef72f9 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -275,6 +275,8 @@ config SPL_LOAD_FIT_ADDRESS
 	hex "load address of fit image"
 	depends on SPL_LOAD_FIT
 	default 0x44000000 if ARCH_IMX8M
+	default 0x81000000 if ARCH_K3 && ARM64
+	default 0x80080000 if ARCH_K3 && CPU_V7R
 	default 0x0
 	help
 	  Specify the load address of the fit image that will be loaded
diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index 3667a0656ed..167ba7ff8df 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -23,8 +23,6 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 2586f6cd648..31d901a7c65 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -24,8 +24,6 @@ CONFIG_SPL_SIZE_LIMIT=0x3A7F0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_INIT is not set
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index fa857e51137..aa241a73c3f 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -29,8 +29,6 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index c9592d7b6c4..f898e1a4ebc 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -29,8 +29,6 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_INIT is not set
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index 05853317fea..c9bc7cd8d39 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -26,8 +26,6 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
index 223a4ab49e1..a25646633ed 100644
--- a/configs/am62x_beagleplay_r5_defconfig
+++ b/configs/am62x_beagleplay_r5_defconfig
@@ -28,8 +28,6 @@ CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_INIT is not set
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 4da668396d0..281fa3fea15 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -32,8 +32,6 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTCOMMAND="run findfdt; run envboot; bootflow scan -lb"
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index 90be95fd889..22185cee594 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -31,8 +31,6 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_INIT is not set
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index ae261f2fa01..9bd95b82a84 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -33,8 +33,6 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
 # CONFIG_BOARD_INIT is not set
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index 860ce7bebc9..6a5190e5c68 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -29,8 +29,6 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_INIT is not set
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index d1fe27702cb..0012a0f41df 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -31,8 +31,6 @@ CONFIG_SPL_SPI=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_BOOTCOMMAND=y
diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index 510bf306d00..560712a6096 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -30,7 +30,6 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
 CONFIG_USE_BOOTCOMMAND=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_INIT is not set
diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index f9161f1fe11..988ce22480c 100644
--- a/configs/am65x_evm_r5_usbdfu_defconfig
+++ b/configs/am65x_evm_r5_usbdfu_defconfig
@@ -14,7 +14,6 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x41c7effc
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-am654-r5-base-board"
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_CMD_DFU=y
 CONFIG_SYSCON=y
diff --git a/configs/am65x_evm_r5_usbmsc_defconfig b/configs/am65x_evm_r5_usbmsc_defconfig
index 64d528351af..377124c9af6 100644
--- a/configs/am65x_evm_r5_usbmsc_defconfig
+++ b/configs/am65x_evm_r5_usbmsc_defconfig
@@ -26,7 +26,6 @@ CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x2000
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
 CONFIG_USE_BOOTCOMMAND=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_INIT is not set
diff --git a/configs/am67a_beagley_ai_a53_defconfig b/configs/am67a_beagley_ai_a53_defconfig
index 2fc5d904fbf..db6a2ed4514 100644
--- a/configs/am67a_beagley_ai_a53_defconfig
+++ b/configs/am67a_beagley_ai_a53_defconfig
@@ -24,8 +24,6 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
diff --git a/configs/am67a_beagley_ai_r5_defconfig b/configs/am67a_beagley_ai_r5_defconfig
index 00c6ba6e2b5..ee3764bdc69 100644
--- a/configs/am67a_beagley_ai_r5_defconfig
+++ b/configs/am67a_beagley_ai_r5_defconfig
@@ -27,8 +27,6 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_INIT is not set
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index 826a2db0805..63c1ac67343 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -32,8 +32,6 @@ CONFIG_SPL_SPI=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index cb87c43311b..893aaafaa9c 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -31,8 +31,6 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
 CONFIG_USE_BOOTCOMMAND=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_INIT is not set
diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
index e7f708a60c5..dc76504eb83 100644
--- a/configs/j721e_beagleboneai64_a72_defconfig
+++ b/configs/j721e_beagleboneai64_a72_defconfig
@@ -27,8 +27,6 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
diff --git a/configs/j721e_beagleboneai64_r5_defconfig b/configs/j721e_beagleboneai64_r5_defconfig
index 7d607469c59..3e2c55b7198 100644
--- a/configs/j721e_beagleboneai64_r5_defconfig
+++ b/configs/j721e_beagleboneai64_r5_defconfig
@@ -28,8 +28,6 @@ CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
 CONFIG_USE_BOOTCOMMAND=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_INIT is not set
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 42e1dd21d0b..c862e9a4880 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -29,8 +29,6 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index 5ca742db90f..4fd20da017c 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -32,8 +32,6 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index e373a9f05b7..5c0d9f9b377 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -30,8 +30,6 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 6cf399ed67c..96e1d397c8a 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -32,8 +32,6 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
 CONFIG_USE_BOOTCOMMAND=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_INIT is not set
diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
index 8639f462c12..74a67da9033 100644
--- a/configs/j722s_evm_a53_defconfig
+++ b/configs/j722s_evm_a53_defconfig
@@ -28,8 +28,6 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
 # CONFIG_BOARD_INIT is not set
diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
index 8e2741c8d42..7ea05f9fee2 100644
--- a/configs/j722s_evm_r5_defconfig
+++ b/configs/j722s_evm_r5_defconfig
@@ -30,8 +30,6 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_INIT is not set
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index fc7acbae694..9282fea66b8 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -29,8 +29,6 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_EFI_SET_TIME=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
 CONFIG_LOGLEVEL=7
diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index cc340a2fe76..25ab6f17d17 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -32,8 +32,6 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
 CONFIG_USE_BOOTCOMMAND=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index 5f185891bf2..ab50545d307 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -35,8 +35,6 @@ CONFIG_SPL_SPI=y
 CONFIG_EFI_SET_TIME=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run start_watchdog; bootflow scan -lb; run ${boot}boot"
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index b89d9c97789..fa5c4466791 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -39,8 +39,6 @@ CONFIG_SPL_SPI=y
 CONFIG_EFI_SET_TIME=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run start_watchdog; bootflow scan -lb; run ${boot}boot"
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 9d6aa9c308c..f5e97e2d730 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -35,8 +35,6 @@ CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run start_watchdog; bootflow scan -lb; run ${boot}boot"
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 31835770d90..f04858099da 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -31,8 +31,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0xB0000000
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_USE_PREBOOT=y
diff --git a/configs/verdin-am62p_a53_defconfig b/configs/verdin-am62p_a53_defconfig
index dd032427987..3dbffa78662 100644
--- a/configs/verdin-am62p_a53_defconfig
+++ b/configs/verdin-am62p_a53_defconfig
@@ -30,8 +30,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0xB0000000
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_BOOTDELAY=1
-- 
2.39.2

