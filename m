Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3965E7BD83
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 10:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B9A1802C1;
	Mon, 16 Feb 2026 11:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ikaU4S32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA3AB80086; Mon, 16 Feb 2026 11:27:46 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6392A80086
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmt8R7YAgFCU7Jtx8dlw/on1nUwB81Qs+d8p4HGucFn9Sebdz8pF4yAjoonwbjBh73apWXsUhOPYDLPMr9wbhhen3vfHDf0l0gvFOPU98O5n2jhyg7A59H/sC9mLTue3UaeCvILDVVQYiH3AN9UhgZ5CcfZWje83grzyoQ97Kp5jQFiNlmTkC8E/cm/C/ze6tvI2V8m4TkToT39ZIwSSkBxIVaxrxx6eZNctcNSA6MruEtfhFrbxiQGTAEhFdHwjKzUu4c3+V0HBEexjoNBeGj0n7hxTXRpSNMaF3EaBS1t1QbC6w53keoyIkPZ3SZCDRSPZXoLypr7a6tXkERVsUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymgR2AmJ4yfnI4u91Y9oi5llnyJX8eoTUFEnrRoQrK8=;
 b=aVIl+IyXBQwD3ZeYNxhtjLHTy9MjBXlaU3NhU1V/rkZRxL5it3RW1sydrHh26ao3DPYDWq9vlauYH0egVDCL686Fsl3Bb8a/dleXReDW3WnDHvzOmLPckIN6BOLiiPgcqlGVaGZRCJ6skbu739boru+kTG9sGFTo9n33UXZEe4hGeGGlRtK/CUVlWMv1o/kgXmE7bydmXPavY6IBiz6zy0p/EB8wDTcUdp+nUM1qyqTGYb558DSUbN0aORTarCG6NLkRBGhxOsP1JM0YcO6W1f5AvB2r1Kv04uQywFAUdIz+HwbGKJJe/CoafHJj5u7YXnGLXVZT53L740fojx673g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymgR2AmJ4yfnI4u91Y9oi5llnyJX8eoTUFEnrRoQrK8=;
 b=ikaU4S32VLjRJoTSYwWej2U0a0kmqGs9Mwq5DE1AQVBTH91jljuz3tq8geRJV8XwO/WKQ7dlDc6t1fq9GHiZ+rwjzMB6x2HkGjHyhelEsh6cVJPs9nSYxIEGbBOVctgGK0SzwIK1WFUY2QBQSrlBr5CgR4OiJfvto9aiAYhphcE=
Received: from SJ0PR05CA0167.namprd05.prod.outlook.com (2603:10b6:a03:339::22)
 by CH3PR10MB7504.namprd10.prod.outlook.com (2603:10b6:610:164::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 10:27:37 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::4e) by SJ0PR05CA0167.outlook.office365.com
 (2603:10b6:a03:339::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 10:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 10:27:36 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:27:35 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:27:35 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 04:27:35 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GARUHZ1147835;
 Mon, 16 Feb 2026 04:27:31 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <neil.armstrong@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <u-kumar1@ti.com>, <j-keerthy@ti.com>, <semen.protsenko@linaro.org>,
 <afd@ti.com>, <anshuld@ti.com>, <peng.fan@nxp.com>, <ahalaney@redhat.com>,
 <mkorpershoek@kernel.org>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 00/10] Add PCIe Boot support for TI J784S4 SoC
Date: Mon, 16 Feb 2026 15:58:28 +0530
Message-ID: <20260216102858.2745657-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CH3PR10MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 125549d3-173c-4387-0174-08de6d460105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ep+/lVt/pKqWJYFSvTojawaVwMjYmpB45ODRu1hq55z4KPk+cW/g3SHknjzq?=
 =?us-ascii?Q?4iKwGHV9huqE+ilVwA+ZXOIwZF7s5zj4tVnhwlgQfe94Zb+K36Zfrb9i4aj5?=
 =?us-ascii?Q?sKkJeNkA6ozmZHAxptU+tL/+Zm+2nr9Rd+zM4Q+/CiRBY7iif9Zo4drSGj3T?=
 =?us-ascii?Q?tClSbslSFn3Rd2nG+F12EzVOVbwK9AKv/ug/GKX4J6D5kTakRtUB8YEzk0zI?=
 =?us-ascii?Q?kZX+aEKFeJlweMqQ+8xzvRkZFgFIduXbIcj9urrh9qSvVAuto3poKAg/BLoh?=
 =?us-ascii?Q?LNaraSIfW50XQKTThZeOB00jpJHGOcvCDiutQhtdmchthHm2xR5C0CA5CQ7W?=
 =?us-ascii?Q?FmNjGcWcBAnAeaaP9Ed0iAsvMxK+oWo1XNVaAPfhTJ27X0SQekF8ozMeG5Pn?=
 =?us-ascii?Q?QBtutM2BqbayCmygzMG9s8T5Kx6fyc9lqR+9/HwBumV/PV9xOPQejyDFdflu?=
 =?us-ascii?Q?g1pPbSyU9HfCrf6cecLofNF8ccPG7YS5QxsPh8vFcjcdolNGjF/HsMmnmeys?=
 =?us-ascii?Q?x2YwEXhriiRgkojzhWpyN35zFzjseITXMimHdawxdWheib9b7SDZqANRc63x?=
 =?us-ascii?Q?/pgep7cUqy//lYYk+LkRy9wd9fKW5+HcTgpLSH8dNsmd4zBzSf+0rgBrd+3z?=
 =?us-ascii?Q?klW71SHbpHSRjP5VInsVzK9/K30GAiPgNC1XOxcIT3bK6Zku2jZhFB7eyc4h?=
 =?us-ascii?Q?62jw9mlH61zBj8f4EWIsuqmep6TzSRpjtmHgMPsYw5pwgkzafFAdq5l5O/Pg?=
 =?us-ascii?Q?3QbqXHusNUGstX5ucJVjZdyb2+HAnYqp7BhJLqwrDef23nRyjCG7p5t8H8We?=
 =?us-ascii?Q?CfOOPcA5+h6zXjNL5DWx3vES8nolOn2DUhB4RKik1s+5w5SND2NIT+9FVBku?=
 =?us-ascii?Q?kUlxK6+ymDOMr7l/8NxxOgIYE/W2Aprf70w2qFZJZqCbpXD3yb55y/c/c3wI?=
 =?us-ascii?Q?loShS5tpD6ymqA3I0tgg/6RDI7O4LONKVSlEKO+wgNaEfEBsbsGUXyhsURo9?=
 =?us-ascii?Q?LsD0MeYUsJg6nITMbv94N6MCzicUkf1k8cO0fRYGi2kOIGJnmhhimG9FzoFc?=
 =?us-ascii?Q?Cfu56/hlfKk5cimawx67XCBSJL3OEB7Q0Fx+YMDQwbcpYlM7KrtzTspFJs8M?=
 =?us-ascii?Q?r80IxrgmgtFKz+nus2X6UygJ9EzOSOQ9QWxwgQYSM20KDLMnRhZObgDfnAVL?=
 =?us-ascii?Q?uuPx96DjRqJ+DR5IzIwRiy4hNZz4hUUda3Dz9DOoO9sFu+Tcg56M9Ni5kywN?=
 =?us-ascii?Q?JoznFNFW5x1o/QIof0WKAh7A+1m4TCeROXkfLlptz14YNw6bmjdtR0GWMS/v?=
 =?us-ascii?Q?SGr2vKlznVAD8Mmh4SzUQOMf45kqBtm2Gx3sc2WWINoeTdhKh4sKjcvf70gh?=
 =?us-ascii?Q?MbL82o0Y9C33m1H8ZAw5uPVTPUA1XD0Avl3Dl3+4YGnqOA32gOBIgPP89Ziq?=
 =?us-ascii?Q?yw4deRHhsAuBEqfyQwNh33J1kWMd7OpS2B22Q4ah/jla9BSVO85PXJEpQ5HC?=
 =?us-ascii?Q?8cuoNg0RyUapcfm2rbVwBTodtScW94cInYjuAObocBDQmrwfpytmFuVJygjk?=
 =?us-ascii?Q?0OIaU8ycV5tQT9GI+Yphbh2QPjxXjADasyLrAeIaal3V2RvYZTyX60s3O6w+?=
 =?us-ascii?Q?R9MmciA9UcjPreRUPaApzkY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WsrO0fQM/UqxVhguY6lT0G8vS5VY3hu+SgoWDYiU6ksdZxUurpPGAO24xrkaaAR4GqXRtgjIennmUj7mu65tPq1YgNtaFhRM4k81/CLeH6XeZoq8Qu7HnWy0QEbRHsoOJXjV6IYW+O+aVJhJoyW1lPj972Tv3PvMimzE6bLah6TqHTGTz9KpeArttXaiElx0hVQc7FlSumccn/m3ThYLDDy+YWMd/HToCt/I2KOoMY8WoW3DAN+iYQzC05YtFPRnGEzFWcFmm/voNGRGG1qkwxAL0xQagv7D936YnNMr4VNG2GqsLIFSSo+figZE4UPOEGXQt1MNnQ/Ujpg7G/iqsgm3+Tb5WTlqGkpddyQDQ/0/kf62eMHUxG18rPAV0Hc8nPJ2jAhdDBDCWAjIiO186kuhz+YS/pFdtt/aApnwXtSuWheiM0m/CrIYPopBaBnR
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:27:36.4111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 125549d3-173c-4387-0174-08de6d460105
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7504
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

Hello,

This series adds PCIe endpoint boot support for the TI J784S4 SoC.
Series is based on commit
f9ffeec4bdc board: toradex: Make A53 get RAM size from DT in K3 boards
of the master branch of U-Boot.

v4 of this series is at:
https://patchwork.ozlabs.org/project/uboot/cover/20251201110103.845413-1-h-salunke@ti.com/
Changes since v4:
- Addressed Udit's feedback:
  i) Patch 6 has been updated by limiting changes to disabling CONFIG_SPL_PCI_ENDPOINT
     and CONFIG_SPL_PHY (CONFIG_PCIE_CDNS_TI_EP, CONFIG_SPL_PHY_CADENCE_TORRENT and
     CONFIG_SPL_PHY_J721E_WIZ don't need to be disabled as pointed out by Udit).
  ii) Commit message of patch 8 has been updated to indicate that although PCIe Boot
      is supported in Hardware for J742S2 SoC, it is not yet enabled in Software.
  iii) Documentation in patch 10 has been updated with complete set of device-tree
       changes included and the C Program to transfer bootloaders has also been
       simplified and documented with the usage of appropriate variable names.

PCIe Boot Logs (J784S4-EVM running Linux as Root-Complex transfers
bootloaders to another J784S4-EVM configured for PCIe Boot):
https://gist.github.com/Siddharth-Vadapalli-at-TI/2d157003818441fe79a139d0dec1058a

Regards,
Siddharth.

Hrushikesh Salunke (10):
  arm: mach-k3: j784s4: Update SoC autogen data to enable PCIe boot
  phy: cadence: Add config to enable Cadence Torrent PHY at SPL stage
  phy: ti: Add config to enable J721E WIZ SERDES wrapper at SPL stage
  configs: j784s4_evm_r5_defconfig: Enable configs for PCIe boot
  configs: j784s4_evm_a72_defconfig: Enable configs for PCIe boot
  configs: am69_sk_r5_defconfig: Disable PCIe boot configs
  configs: am69_sk_a72_defconfig: Disable PCIe boot configs
  configs: j742s2_evm_r5_defconfig: Disable PCIe boot configs
  configs: j742s2_evm_a72_defconfig: Disable PCIe boot configs
  docs: board: ti: j784s4_evm: Add PCIe boot documentation

 arch/arm/mach-k3/r5/j784s4/clk-data.c | 184 +++++++++++++++-
 arch/arm/mach-k3/r5/j784s4/dev-data.c |  45 ++--
 configs/am69_sk_a72_defconfig         |   3 +
 configs/am69_sk_r5_defconfig          |   6 +
 configs/j742s2_evm_a72_defconfig      |   4 +
 configs/j742s2_evm_r5_defconfig       |   6 +
 configs/j784s4_evm_a72_defconfig      |   7 +
 configs/j784s4_evm_r5_defconfig       |  13 ++
 doc/board/ti/j784s4_evm.rst           | 305 ++++++++++++++++++++++++++
 drivers/phy/cadence/Kconfig           |   7 +
 drivers/phy/ti/Kconfig                |  10 +
 11 files changed, 562 insertions(+), 28 deletions(-)

-- 
2.51.1

