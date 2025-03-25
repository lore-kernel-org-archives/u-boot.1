Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81669C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 03:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D6381DB4;
	Tue, 25 Mar 2025 04:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="hFs2XePH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D785781951; Tue, 25 Mar 2025 04:58:43 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::70a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3163819B1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 04:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvzD7f19rsrHCi0Xj9pXLhn+YHVA6MaPdis3e7AfX3oc3BZKI0ghfdh8L3owc1QFKQoXseQqi0/pm7N503juLiGptAOxEZpEkJ6lFrFqcokh6sHVTlTN6/KgiMjbhc1ZKv1MC60q8jr51LrKlDXF+uwMX5llbn4saXK3IGFQbNEv/ZKL5GD5bFH/gi9OdTjGfGjHLm/92KjsPQX3MkTg4hy+18MnukDRBEv8KXegDG/II8s6uajOiJ8Dgih+ag/yozZRx41xnGORwk5lmP1eVI/c6jC8vp5Uut843yxBFBLag1vCjesJdWC2G0aeGzsxoa32hbh+XMD6phHqBYM4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjgGZMQzl/BFi9Uhc/r6tNi+CClcTxkyGegQZN5tVOw=;
 b=siW9MaK8v8zmmr6ASNboYMWLZQ38+uwsL4VbE26TCBQMWoqE92/fK+GmDy2lF/GJ9758L8ALb7kCB5scl2o/FVG0PJGtZcwlgbabDN73hoD+arDwn3HbcVMxziaUwMrXgdcPY8CrkV14DO5AL4XpbE4EZI7T4SdVfhRKNEhV7YvG0BZamPmjPvekEtrY/QWZaW2RJztAU1orV0Q/Y2tljLyPbC9rerS3jdvsElwkP9IfPfGqQ6XPK0gVUXwXaEEY0vkwNYWOAv6/e4COpF5D226Ta/D3MTBJ8iLRDPugDjz7wrcTg5+KX6Wajtsu5YKKCtJFjtXRbIs5sFvyCLG2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjgGZMQzl/BFi9Uhc/r6tNi+CClcTxkyGegQZN5tVOw=;
 b=hFs2XePHBkktyA1Ubd8FPbk4v3zDyLK9QF/7le66zrgBoKMSmBB1w7TIdc5U8etQQDyEkjErFZotKSAeX8UEumCwOaKINNbFy9gAuBTvg0UA53yhjcxMy1j7rW1+HuWfXhTsPrfu1ej5/UAFymsLibkCd+4wzFYNlt4jVcuVWHURMhlJxsPESJmMujDXO+2qv8KEzhKeiHGySeAPvtVzALWkWlNrO/9RrWq7Vgk76axKqyGoidnWkK5acy+zdWR5PYluPsp88iH8VRZG61u1nR5DEb6N5K0G0wZlXFdby73q31EjrWn7DbW38g3ecSblPwWZv+wrMUY9n0BOrUhnsA==
Received: from DU6P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::9) by
 VI0P195MB2627.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:252::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Tue, 25 Mar 2025 03:58:36 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::eb) by DU6P191CA0009.outlook.office365.com
 (2603:10a6:10:540::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 03:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 03:58:36 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:33 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:33 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <afd@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <vigneshr@ti.com>, 
 <s-k6@ti.com>, <dannenberg@ti.com>, <bb@ti.com>
Subject: [PATCH 8/8] configs: Add phycore_am62ax_r5_ethboot_defconfig
Date: Tue, 25 Mar 2025 04:58:24 +0100
Message-ID: <20250325035824.2304200-9-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250325035824.2304200-1-w.egorov@phytec.de>
References: <20250325035824.2304200-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|VI0P195MB2627:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf6234c-c3c7-4a79-3d45-08dd6b5151de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lLMgAxiBHMB6EzB/533Cy/wqqcImcin0QrbXk2m5733ruUcZROhLWBhE8DQM?=
 =?us-ascii?Q?xIiBPaGixfFOpkABCjvh0GvqFCFi5PJKMEhGbSNo/gTYb0uQTnqKzAuh8xYm?=
 =?us-ascii?Q?0AC91H3Nm3/R5wXr63NXVSGEG+cQXgPGUgM7Z1LUrdS6/hXpVF9n8xwZuLgi?=
 =?us-ascii?Q?cKbNjf2QnjRSt600em73IfbsXzH4rdBxV4liDio26kICh7RnoIMKzX1cQCxH?=
 =?us-ascii?Q?K4Tpwv+Mu7GpPrBcqY5AJiBuvO1KuXXP1YJ1JEY4CTzDRKqoGPynYAfcjdhC?=
 =?us-ascii?Q?/uHN9mh3eK2F8KKkH3yNTABeV5l9tuSdo1sZnE67H9MXHIIrik9OyXAO9FQr?=
 =?us-ascii?Q?jpyzSs+RAZrKZIp5s5nZBeSwlIkWLUaxPVb/Ku916liNt/SeNbD6zPIFvPKo?=
 =?us-ascii?Q?CEQBxO2MhqK6HOBixSpKvkOk7codqGLk3v0LHmx2qVJRR/o3GK8J4Dfpznhw?=
 =?us-ascii?Q?rHRVwgEQSMMjzibHN+EmEiF96/+LD418pRrweSs4uASCxKCNDtK4HfKTOpJj?=
 =?us-ascii?Q?JIRvkIqd2VHneVtRBOYo/zhXlNU2SmAwW7Kf6fEZPX6ysL9aD9wbb6T8+e/Y?=
 =?us-ascii?Q?A3+MKzu0vRE6DkwXJcelEBMDe0L0s5SKSZlMu3hqgj2hacdPqkmWtdY3Rd+W?=
 =?us-ascii?Q?r0h3xYbfGFMPUcqPNQ7RVHuG5k3kxT46h+H3LWFn2ee5KXAO386tkX64kACw?=
 =?us-ascii?Q?bIbLA6EuIO+nFnGsvjBKslUkelLWoHiYySipyieuGgf54zJahrCeqbiCW3su?=
 =?us-ascii?Q?9HEyAzUBIvMWKcswAfL5DuS995JcWWjBv8eFTEFfEM9BHKdVdiWzJNAnL0SA?=
 =?us-ascii?Q?IldvHTJh1FOC+nJHdONNsgUjHG7jKEPyf2OcYVO9JIQPAfI7XEl2fBPg22nS?=
 =?us-ascii?Q?wOcbpUu4zCVDI9x3ezSBNpwcvX89GUTKLzgq3LhqHr8L6B6q9I0dHAIKBBv6?=
 =?us-ascii?Q?EasAUFVYvHJGgzQb3+d5WuBCnjC/wuM2lDu0qOZoOPO2q16RxFlzB2/8iWaj?=
 =?us-ascii?Q?sjzR10APgOw5BPsh/CvYMLzk7Mm8WfdqBpus9BQ10dskJN8GnYJD5U/vWgXP?=
 =?us-ascii?Q?B935EG0jrZqjL7dAzyq7m75XwIJvP6QIuH2wyso8WyUevvo95DiI2B9zIg3y?=
 =?us-ascii?Q?CdS/xAWTLru/2VQW2AMPKKDqkZM6yy07w5Vjk7ueWD+y7pq92FHf5uuphZEe?=
 =?us-ascii?Q?JjLNZ2g3/Z5rfZQV8ea6KeG7XPefTAxqH2PbgK8w56uLInlUbrInXn84+26j?=
 =?us-ascii?Q?HFJ1cZvaxyOWsPpnoAOcyAMhT7N7XHoNzbl2ZjCcD/S2iAUO51uAUC2tYmqX?=
 =?us-ascii?Q?Rl4anccWxwTfNYG2Hy5LkR5A+00CqgHe4dvOg4U29+UNqNUKY548TdxCQNZp?=
 =?us-ascii?Q?9yRFMzWn/Kd6LOgJbj2xNqS5gaVPve2FsBkQZ48eY1l3bG4l7Z3WF76+GZfl?=
 =?us-ascii?Q?ZmvoHqSjO6raZUsY+yCkd/wkHxwp1IBpsIQCw8lm10OiMvkFvUML5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 03:58:36.5895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf6234c-c3c7-4a79-3d45-08dd6b5151de
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2627
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

Provide a defconfig for booting the phycore-am62ax via Ethernet.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62ax/MAINTAINERS     |  1 +
 configs/phycore_am62ax_r5_ethboot_defconfig | 43 +++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 configs/phycore_am62ax_r5_ethboot_defconfig

diff --git a/board/phytec/phycore_am62ax/MAINTAINERS b/board/phytec/phycore_am62ax/MAINTAINERS
index 3e4e2feff4e..9169651c459 100644
--- a/board/phytec/phycore_am62ax/MAINTAINERS
+++ b/board/phytec/phycore_am62ax/MAINTAINERS
@@ -10,5 +10,6 @@ F:	arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
 F:	board/phytec/phycore_am62ax/
 F:	configs/phycore_am62ax_a53_defconfig
 F:	configs/phycore_am62ax_r5_defconfig
+F:	configs/phycore_am62ax_r5_ethboot_defconfig
 F:	include/configs/phycore_am62ax.h
 F:	doc/board/phytec/phycore-am62ax.rst
diff --git a/configs/phycore_am62ax_r5_ethboot_defconfig b/configs/phycore_am62ax_r5_ethboot_defconfig
new file mode 100644
index 00000000000..81a7f5b0784
--- /dev/null
+++ b/configs/phycore_am62ax_r5_ethboot_defconfig
@@ -0,0 +1,43 @@
+#include <configs/phycore_am62ax_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_AM62A7=y
+CONFIG_TARGET_PHYCORE_AM62AX_R5=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62a7-r5-phycore-som-2gb"
+
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
+CONFIG_SPL_BSS_MAX_SIZE=0x3100
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62AX U-Boot R5 SPL"
+CONFIG_SPL_SYSCON=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_SPL_MMC=n
+CONFIG_SPL_DM_SPI=n
+CONFIG_SPL_MMC=n
+CONFIG_SPL_SPI_FLASH_SUPPORT=n
+CONFIG_SPL_SPI=n
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=n
+CONFIG_SPL_SPI_LOAD=n
+CONFIG_SPL_YMODEM_SUPPORT=n
+CONFIG_DM_SPI_FLASH=n
+CONFIG_SPI_FLASH_SFDP_SUPPORT=n
+CONFIG_SPI_FLASH_SOFT_RESET=n
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=n
+CONFIG_SPI_FLASH_STMICRO=n
+CONFIG_SPI_FLASH_MT35XU=n
+CONFIG_SPI=n
+CONFIG_DM_SPI=n
+CONFIG_CADENCE_QSPI=n
-- 
2.34.1

