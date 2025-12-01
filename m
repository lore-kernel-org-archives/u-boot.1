Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F244AD111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D889E83B86;
	Mon,  1 Dec 2025 12:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CeqGlO4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B544E83AAC; Mon,  1 Dec 2025 12:01:44 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF4883B63
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5GvNq2M108fI7NZvnHI6FV4kqbQlWn2MGFXPYUZAq7x04FKdaT76ELUI7R37NtQKR1fpvy61k3ZJAKu65cLEBVOMQooDhLImBZ2zz3k9iMLPCEmcxUHJ2BpFzMQO2/jPnUQnsFeuluZFBL3hFQ3UnjNBBhnNxH0Xlc15lmSaP6qjV/dpkDsA3jkD/qVX4W0W+ZQpGcjM76w1HNr3nd5nv1gdVcPGrmaXMhKYo6mXyKxRbHKbjvtIyNym/y8YHqNL0EAsXw2b1wc56f6jDw0E8vK1N7cCk2jJtGCmGNtNe5PdCnUCKOODmFA5bs/3BXSiSXGDZdubOImc1aCGEs7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYYYkaI4WDExC8EdMYqKWHeAREpnd/f9+uVzJupYQLY=;
 b=eXU+FKTUigrC7FayJ9rUvsIbvywY0qPaHIjngTxRYKoeFZAJMGXYgkCQFJz95lAunp/AmRQZAycUANin1yzpKTfBS89lQSY7/oObFM52h2JdJvCfCjcxqGdIEzR5Kd0oL300gAlSmxAQxqA+6Fhrg6yjd2PIjI6Gg7ChNxrx3eyWFICfZASAZT5tmMREhLElTDL42ukmriyv36FxHldJFeP2Iw4E0EpH6Z4bbqaiQa+iHprPsFbPd6WcCePU1hFvJPNVX4rGecJcTIrQB3NCQ1UuTWzxzZJjmElcuGL1nSiNFYChAcJEHxZXxAMNBHmwR7FPDygYbjlfwHA7dUk52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYYYkaI4WDExC8EdMYqKWHeAREpnd/f9+uVzJupYQLY=;
 b=CeqGlO4q60fmsFxo9WXQuOWa6gBuZieXDtZ/cXb7UGjcv7a1sQugUzGpu66cqLWP4v5n4dvoMCWqvRv5buL8DrocnSwXHjpeUVH520F9PG0PA2zgLVpSEl7lz6SwEafRbAN4lCcv+aLIm/8HbEFTgEGvzripl2PspbtIg8jnQlc=
Received: from DS7PR05CA0054.namprd05.prod.outlook.com (2603:10b6:8:2f::28) by
 MN6PR10MB8023.namprd10.prod.outlook.com (2603:10b6:208:4fb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:01:38 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::67) by DS7PR05CA0054.outlook.office365.com
 (2603:10b6:8:2f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Mon, 1
 Dec 2025 11:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 11:01:36 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:33 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:32 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 05:01:32 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1B14qc306512;
 Mon, 1 Dec 2025 05:01:27 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <m-chawdhry@ti.com>,
 <c-vankar@ti.com>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <jm@ti.com>,
 <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v4 05/10] configs: j784s4_evm_a72_defconfig: Enable configs
 for PCIe boot
Date: Mon, 1 Dec 2025 16:30:58 +0530
Message-ID: <20251201110103.845413-6-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201110103.845413-1-h-salunke@ti.com>
References: <20251201110103.845413-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|MN6PR10MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 165c9443-43ee-4424-c819-08de30c8ff5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+aHdtcqCE2qcT6Njnvr/H1Y9hp1z9kyDkYJ+Ag4VnD7wfVR0L8Z6DKOolmju?=
 =?us-ascii?Q?uASj8D7Xek7wzj7QLJGz5VE4uncY9jOPYr0wMrc3URZmCthb3EtCNrRmEGDk?=
 =?us-ascii?Q?WSCLb6SWNLYcY57ZJRpul3ydX5gFYWVCP9nuCwfKECFFslPImvd064CsRzRa?=
 =?us-ascii?Q?fMMvp84PExxp2rwbn1zt5qyxVxLgROKrIQ+TPdLCgNmMkJ0TSwGOcjSnEcDR?=
 =?us-ascii?Q?lvageWJg/bCYWpxsdhBL3DWu0b0WNVm5oQabS6fb2eiYNFrhemFiaIk8iiRI?=
 =?us-ascii?Q?pQSNWM+Ihbp9kjbTz998nResBT6U8YG/YfXgLQYddj6ydSgpaRq6XVAlnI8/?=
 =?us-ascii?Q?mGKFtinpicjM/6xn8Z/Sw1KdS2ixgwM/0vCSk23hkY7qRbyRR5QOxps8Ak00?=
 =?us-ascii?Q?GW9OAYYueFZyEixe3DaG62aSI6qPp47aVTXF/3BgV1nrCFQHn+fw+k/V4ubd?=
 =?us-ascii?Q?K6np777U4pL1LLPa8exUb5KFfOg7LM7/NkFN+OIIbggyl37/ySjVfQshlGNm?=
 =?us-ascii?Q?J4/pSEu10SJ9yms1+gvbv+yzQiDScgBbwQPVPMYCWOGGUtR0N6K9Vr2iBZnr?=
 =?us-ascii?Q?QlOvqP4VoQGKrEvsUaz/oTvKpUFjlkSx+b9GUdmSXke34qvPrYGMSkA5sM3F?=
 =?us-ascii?Q?QlYYNNlgMmak2k+EdiHZzQQaPAY5/48zWmFQ+MBpd84XQR6MQ7vtXnkx/Do3?=
 =?us-ascii?Q?5V2Bz0+HDuj0crpReBFE3vNe1unRnfXimyAWuEWqAlZ1lbvSQoM8PSWtYruK?=
 =?us-ascii?Q?AtMWnKoZdk/z4y8rWsXkanzjf0zUtcCIjsH1J+/MVhOKi7KBqbDQ9z5KezWc?=
 =?us-ascii?Q?IBJyUca6SAwWIuJ0xSK51Qh/C8a+tELzUtHTh3nMZ+xyAUe3kuz9e/kNV9bz?=
 =?us-ascii?Q?zutsUpIHdG/P7OCzSCSVMbp8oTwLjD/f4rYCxelTw8teRaJjk1HuBCRH3jMo?=
 =?us-ascii?Q?Ddktio43FgDmdJqpzpg3f+9fQw0s6mzzHV+4NVpxhcWFpKRQqKDC25zOJKH4?=
 =?us-ascii?Q?xcJeuJ420OmKg9DJsqoWUopcEGVx7JWHWLPzbKWtgJ++mpD/tYiee+bHvdDs?=
 =?us-ascii?Q?n79QnIH7P6SdelcOLtnXwNDbPC9Nhx6wctA0tUAC+u/sicAYAuH2EpfmntaW?=
 =?us-ascii?Q?B6dX+9JsgLH/q3RicXIlau+ef/41cXGuHvN5mX0pNhUm/EENmUfw7wL+v3Ye?=
 =?us-ascii?Q?D+8D5UmY/vQMVZHMbLIYLHJVWPKZfQ9G4O30yVvFpoUuPmf7Poba6+F0q6a/?=
 =?us-ascii?Q?zMt6HRxH9EcsKMfKMo0ea/eF3HlpK1Um6Kav2CAap0/gIfjI8xBViC6CS2Xn?=
 =?us-ascii?Q?MI5PBV/9wad9N3QiWxqBYH5p50ARFsomXYoyvgY3vS/C+Rt7yuk636/JZ46p?=
 =?us-ascii?Q?GH0wS5jDMn6NZWPLZ3ROM92Ha3BfclQEQ+/5DTdX263HHnzvhdOjEZ6vimxj?=
 =?us-ascii?Q?W+7Ry4j5cr3qKjq6R99J7JTaO81POD8nZx7Jr1EWo7mkTVEiJp/W/yLLDZrQ?=
 =?us-ascii?Q?M4JC1fgZCpQUVNi8gqPffVQw2vkCYRq+ruORQ/+EpwiWtT7QXmGPEE0RxDTP?=
 =?us-ascii?Q?2uZQp69yhvbHrMyJL9nUxJpFpcWpT6A5yDddFTZM?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:01:36.8497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 165c9443-43ee-4424-c819-08de30c8ff5f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8023
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

J784S4 SoC has two instances of PCIe, namely PCIe0 and PCIe1. The
PCIe1 instance is used for PCIe endpoint boot. Enable the configs
required for PCIe boot on the J784S4 platform.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/j784s4_evm_a72_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index fc7acbae694..face831797b 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -46,9 +46,16 @@ CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_PCI_ENDPOINT=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_PCI_DFU=y
+CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_SPL_PCI_DFU_BAR_SIZE=0x400000
+CONFIG_SPL_PCI_DFU_VENDOR_ID=0x104c
+CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb012
+CONFIG_SPL_PCI_DFU_BOOT_PHASE="tispl.bin"
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
-- 
2.34.1

