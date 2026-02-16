Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041FCE7BD88
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 10:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24E7083C72;
	Mon, 16 Feb 2026 11:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CQyIR4xe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3790680086; Mon, 16 Feb 2026 11:28:00 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AEC283CB5
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyGLN2s9ybfzcyHPiHXa0mmulXoRMSSCKELfOcLCSKREuGyXSirR8paBH2PtOxN3/9HBxPJAI8Y2iOWG/5MR9dvZg4YwQJSVyeUp3+UtlYhpQbbESK+CI3KFxNRpye8OCJeovrMZH19sVMZv7TpDYFSIhmWJdJCoXih8jSbgUvdItS2Fpd2gq+C9q/Rj6w1vsqdP6Wjf7dwZzln8xhecwZCaiUz1y5ZDDIdc7j5dGjxN77ZMREhSKQRWBccZGbSLnx6xqyJN+SB1qYuuEdqaYN7ZLeKzAwTdUEgCKegQqovMcN+JebNL3OHGhzntDHmQvpGcMA8IYZkx4OovHNsfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hobm/FQOllzTOEtLOnMJ9LpGBafPu0wUn3Idl794W14=;
 b=MZPbLdD2x39AGNBE2OOcfkpCvnMOR+PnJxjqnerwMNIr9ssIzRLfuM55fYATsi6zM4iJ8YhfGhA5njHYCbIarF9WkXbrN/dltWEo5O8VVEakce7/Qv3OtfGBwPxypBs9D8+P1LRHeCz4DwVh/eLFUozLrhd1XFukW3BeqfYowvUtm7RvN9JJinSGKmHrKkgARewrg7s2e+NF9FJzjodWolgZnqLuyZiaw4g/rlhdtMpSI3FA1049lkwXlURU2OppvKyWg/KkIRVqNKbZ6qO6GGaNqKekO8tQNu1FjDKxDzgb0ZzP5PVCaOEwwPMpy2fHFWQOuXYzhBjv3snzUaNmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hobm/FQOllzTOEtLOnMJ9LpGBafPu0wUn3Idl794W14=;
 b=CQyIR4xejP5WWathu0P/xIsZLOvVAPPE95sCzFD3Ke9of+U5DYgPNDwGjq+xZQAmiv/ikStvtO0R2A2HcAcHyzDuHOsh4x71W1iupE4UtuVqv9EAo4JAzMKUGT92o8yTp7VdQ7T/p5hpanXbVEqPcrbRzReiRHE9dmCFcMID5n0=
Received: from BYAPR11CA0075.namprd11.prod.outlook.com (2603:10b6:a03:f4::16)
 by LV3PR10MB8153.namprd10.prod.outlook.com (2603:10b6:408:287::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 10:27:55 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::e7) by BYAPR11CA0075.outlook.office365.com
 (2603:10b6:a03:f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 10:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 10:27:55 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:27:54 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:27:54 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 04:27:54 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GARUHd1147835;
 Mon, 16 Feb 2026 04:27:50 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <neil.armstrong@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <u-kumar1@ti.com>, <j-keerthy@ti.com>, <semen.protsenko@linaro.org>,
 <afd@ti.com>, <anshuld@ti.com>, <peng.fan@nxp.com>, <ahalaney@redhat.com>,
 <mkorpershoek@kernel.org>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 04/10] configs: j784s4_evm_r5_defconfig: Enable configs for
 PCIe boot
Date: Mon, 16 Feb 2026 15:58:32 +0530
Message-ID: <20260216102858.2745657-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260216102858.2745657-1-s-vadapalli@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|LV3PR10MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 026afa9e-8e72-4d9b-09cb-08de6d460c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y30ZbjldzwJaSJCeTb3wXxG4UU6I6FY8VWcwuO41tyQh5Zz3lx8/cnuq3JIP?=
 =?us-ascii?Q?BJcrKWKy3oRXeqZVa5NFVy6QPGTSkTTPBN6zapUyP9F7BIY8fKyTzyRjtK3T?=
 =?us-ascii?Q?kYZYpADOY/Z097+UyA/Sv0bws+79RybndntxLSWQo3mwsPHGvOh0PY/tVPfO?=
 =?us-ascii?Q?y0TBx18+LpPTCNaV2qBIqDXETTJxsIgfjxdkK2KY6aJjBqiM3yJJnRRfwk+0?=
 =?us-ascii?Q?dOV2hgrmimaPLN66mAccsu5WCH/igGOFCe+PC6vj7ZAMSfODcg+UXTT+Dh5L?=
 =?us-ascii?Q?7v96dgeRFmIFafzcdIW1AVZ4V/h5cDaI1gu24wUcqGtHUVZBIw2hmAWkkqf3?=
 =?us-ascii?Q?wtAFMmGcJ/lIAARjpf2x2WHyBr6d2q8TNDnYCedkyOPaUa+hVWcuwYPuJzdl?=
 =?us-ascii?Q?SFxELnDQoNx31JtFp/InmKsnItFAw4xRznY7vVZe5NiB567kmLW7sTjChHZV?=
 =?us-ascii?Q?i4NT3vv6sPWUgRCER9+3j0I/9yqsnHA/QQN+CgH8KPcPOQ43rzHnVWgKRILL?=
 =?us-ascii?Q?t19GgH7Rg76Whz/FGz4iMauEtpbw6R5hhf7HtiDdtlUwmt3oWxxi0fHyPzZ2?=
 =?us-ascii?Q?cBZorqqnXEomoCCPv7Ae3IRg/WZyfRQtgov8oJA3vOsrr54oDlDueKGU2gX/?=
 =?us-ascii?Q?kts1ncLKN5AvqXBxd3KxB5R5uYtM6Lud0tAxxZdxVeg4ypFc33b6oQkil0cO?=
 =?us-ascii?Q?M+BDAPgTaeNaElpackDBklzTONTHaMiAdZiYCprgA6nK3EnAFGaOqi+r+0Y/?=
 =?us-ascii?Q?GGeSMZ+xZ/WMiCRxY4pcIdk12wU7ZwPwru459U53/zVNYPAKM+4PEzydkfgD?=
 =?us-ascii?Q?5sm/NLjeGYRI90b8poewKUlsGsA5giUADjAAndBSc13U5U+N1iEIXw8DWKlF?=
 =?us-ascii?Q?99nb2lQq6lPWDrDVEPZ3yyZdUdm6iKMxdqwcv4WVRjBFQUSpDQayOT6O29Au?=
 =?us-ascii?Q?qEZpU/RJwse4mnjdcskdN65G9dc/lBch+t55vbUiRDPtE+fioSvSDk6SET8v?=
 =?us-ascii?Q?NVxEGHj8KPb5zgSzq/Te13yC1CA8QxqnUtHRcbyZZOuGBsPdj6jyLWTUxV1N?=
 =?us-ascii?Q?gXO6O2kHPdO+F5RrU0+qTmpApwDVQdAT7GynQMQL9+GvR3xzRAIPyVgewrYw?=
 =?us-ascii?Q?H9VWLwRxU1P3jJf96qui9cJG0ydgfZz5XFZne1Q6kKIBi/vzpdMuFmhcybpL?=
 =?us-ascii?Q?LDyXiF+4uWKEonTz2z6LjPiJvrXKpPLrsgt/ZUfVPQI5JGFAj1ufgAS/O0Pz?=
 =?us-ascii?Q?Fd1siEdYlyOGhQaAuElLiHCWRG6iYAjeaT3e2Gx3NV82yHYs+XWNQdqdGxpK?=
 =?us-ascii?Q?YYa/msFkLlhlMvrg/gDWJO6NfIybcUe9CTbGaHf8Sep1XJ3mhMw6XSD/jQV0?=
 =?us-ascii?Q?6zs8fJiWWV1aeDuUSD7tHn7jwM4ZGjHX4M8eRkN3xLWH3aTIswPx0bBr48/N?=
 =?us-ascii?Q?FkqQFPAExYgpIksXDfJ0ZKD0MGPl2ttALOIWfm1aJrZh64oaIPvukVOoFnhN?=
 =?us-ascii?Q?rryssIIKVEHdvzqj7LVsnwmouwDz5Qb+mbUJeO3jRT4UM9kuKOfrrA+m7RTt?=
 =?us-ascii?Q?DxLmwQvfsgdumkz069wQBgoGqslZkp20Eh1K7Uzlv06/fl29Bu9icOkGUpKR?=
 =?us-ascii?Q?DyftuFjwXEuENm7JktM2Gh1j6guu7vcVC+Xg2fo9xGiAf7WzRjq4hjNPddIe?=
 =?us-ascii?Q?q9HtZQi5zn809kWivMZa2hZtm4A=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dynRr3aeGecU3Ea4vqKQPneT2mLa2cggAHe1tOw3gVSp5wrjOxpyNWtyb38xlM0AjOz7n4OpqYw2IioLL95WY4QJCU0vMJTinETqx5aXsbQvbktg8zH8ApgFODlYYx8mKEQMvxwSZZXPPR40qi/PnY3rrJkWXSdIGpnqx9pvvxQu9JIAMlEETlPgqwr52uxeMU8rgbyR3EXHOatB68Clji3PAZ8ukq1QFohY5yuPEU/X6c5TjnS5kwpQXOXvYYrSG6c8dUFdqgdg5t/sWozcS6oFZdPslJKmcUroEknClCWG4DGQlJBShX4iTFZLRR9+wCf7mupyu7xJSVHbbDrHlJfAkd2i/DZvb6/DEVd+Yww3Zy2nrW4uFMTkEmKKHINrI8eZpeDQIQrhzJiPNLnKa5Kxj53obkATCbOm4rvpwpJ2BwcyHyi0bmxsMGLIPg0X
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:27:55.2632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026afa9e-8e72-4d9b-09cb-08de6d460c41
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8153
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

From: Hrushikesh Salunke <h-salunke@ti.com>

J784S4 SoC has two instances of PCIe, namely PCIe0 and PCIe1. The
PCIe1 instance is used for PCIe endpoint boot. Enable the configs
required for PCIe boot on the J784S4 platform.

Additionally, enable configs for J721E WIZ SERDES wrapper, Cadence
Torrent PHY, and MMIO multiplexer. These are required to configure
the SERDES lanes at the R5 SPL stage for PCIe endpoint operation.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/j784s4_evm_r5_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index 25ab6f17d17..4462e7530e4 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -50,9 +50,16 @@ CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_PCI_ENDPOINT=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_PCI_DFU=y
+CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x80800000
+CONFIG_SPL_PCI_DFU_BAR_SIZE=0x400000
+CONFIG_SPL_PCI_DFU_VENDOR_ID=0x104c
+CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb012
+CONFIG_SPL_PCI_DFU_BOOT_PHASE="tiboot3.bin"
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -120,6 +127,12 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_MULTIPLEXER=y
+CONFIG_SPL_MUX_MMIO=y
+CONFIG_PCIE_CDNS_TI_EP=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_PHY_CADENCE_TORRENT=y
+CONFIG_SPL_PHY_J721E_WIZ=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
-- 
2.51.1

