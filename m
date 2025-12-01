Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F24D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E1EA83AAE;
	Mon,  1 Dec 2025 12:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xEVhlZ3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83A4C83AB8; Mon,  1 Dec 2025 12:01:17 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E6E383AAC
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXm6h7E1n7LZx8WayuVoNq0QqbCH175nTY/+0A2EhJTSHX1HLcJw1Y/EUa1XFudOQRbdWlwNhLW5uUC8jbq7f+TzHXP6p0wIx8JngWwzEqLEvprrNoFxUu1QziikfqCI3qAHBGa6Pm5Q3tHLJhL0Wp4vk7rcUPHVIiR6rLNxM/EVOe44HfybwKa682Oa0lyAyH3UoRtcGPtacljLyPs6XovcwNeyeGZfK4Ixi4/KDjE1YluwO/zu7RDG0ANoKhxFeMmOqiwdgjvvQ1554WhLaWXu9eukIeQW1sCrikBIm4lyJ/7IZG4/LH8dfiMN9Jg2MkI/SAv4QkGRq7Dg+Dkm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy8nVwd3Knd3DYHJCyLPW1fIccyUS75ta6pp2AS+XM8=;
 b=l9LyPrtcZnqCn6rJWgY2tqIkVKvHjLNrzfFAtOfJA8LnmmjS47w5ct0FS03HiZImQRRpcQzE6HuT+psPLW9KlE4t2hK3j6oAZDmijqKE9VTdtDmVXGoRR3ysZgvgOuW5XLvfId8TJO2eIJKa5ZpU8vQ3Oi5CLRlLVbnZXFWrzQnSzxTzKZ8NuhHtdISeUJRZv7CD6wUspJpusBWEiKEanU/PE9NjhZfoa51hAqGho66a/4W0MNBU3CNLvd2fAyQRUl8yhShTzrbB0BN550JKAhIfcDLnpW6BUhGG09Mohk/RBEoUTOdowjNMRsE7/liDs3fVDIIGZWiyxgjzpqbQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy8nVwd3Knd3DYHJCyLPW1fIccyUS75ta6pp2AS+XM8=;
 b=xEVhlZ3tNQlrUEHEq9Qs90dS01wJevZmgf5SWnqLaxp+t6QamZpvcD6ZYgV1PxKxUzR8p4WAlcRCnFvn5bl2ui1wJFDBZCf6xbf6UZqRbKSM8ClLfrNHw/HFJ7CU+aJ4YEia4x1UIoytqNfzN/1qF+/lc+iyH0Nd1mu4iMg3BfE=
Received: from CH0PR03CA0228.namprd03.prod.outlook.com (2603:10b6:610:e7::23)
 by IA0PR10MB6795.namprd10.prod.outlook.com (2603:10b6:208:439::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:01:11 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::67) by CH0PR03CA0228.outlook.office365.com
 (2603:10b6:610:e7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 11:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 11:01:10 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:09 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:09 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 05:01:08 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1B14qX306512;
 Mon, 1 Dec 2025 05:01:04 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <m-chawdhry@ti.com>,
 <c-vankar@ti.com>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <jm@ti.com>,
 <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v4 00/10] arm: k3: j784s4: Add PCIe boot support
Date: Mon, 1 Dec 2025 16:30:53 +0530
Message-ID: <20251201110103.845413-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|IA0PR10MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 25351b56-599e-450a-3001-08de30c8ef68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BEiQVnnOjAdQdi2NhZjvpY3h0qc4M+6Z0OkUkH9beQSo8j6vfD/UKdhdJf8j?=
 =?us-ascii?Q?O2rKRLgFzMZDq9vdWorAcVPX6Cg//aLyjHUlQ5ZE1dyDYlwo5jyRTKeKG4WU?=
 =?us-ascii?Q?kLbxETWR388RV3QbKKrla0XG3iDdSgxFNsLDY7rWXuhaBBRm7q57DIofUERV?=
 =?us-ascii?Q?5yPCF1yLAXl1DgHsqofpOdm9l5yQXEFXkNyy3YJwdNNn+fvfSRUmcX6iYCY0?=
 =?us-ascii?Q?/INXrYehcbYUx4wj2bTh2rsCRkIYgob6eYcpf67CZhh9wH+okWZ8jZEOvrQD?=
 =?us-ascii?Q?bdZh2iMECnwP/NTxfEkcfFbcXcdJdTjsIuiHmWq5K66/j6S6EqNgLYZb6onY?=
 =?us-ascii?Q?XdqTOeE9SHodyLHydy8IovOM8h38xC3ZmKWk8lURAlAr/DyEDJXV69qT3zpk?=
 =?us-ascii?Q?PuWm90H2UulETDwq4HFj3bWkiWHdUATUAkpM133Tokbqgzu9fe1nW/qFGwWo?=
 =?us-ascii?Q?GR7nhU+cyJxU24MP6pCVyqDtRqZSytI7NDYRaxv6zdw5r5JEoS2IM7dTbB4r?=
 =?us-ascii?Q?PID7tHmDewwLSTjkQLDISlsnCDMYqqLrigN1P5Fc7Juk8LWPRnu7UxRAydnu?=
 =?us-ascii?Q?8P2l7xAmd8Cyfyh0ELXRbKiuWa//0PGW0ravAe/5MsvGNwudxJa3z9IzE7K/?=
 =?us-ascii?Q?OoyBVlp4F1+f4Gg/EzVbZ5gngcDPURKMqtxeAA1q1uSTO54mjCHdMVmCkGpX?=
 =?us-ascii?Q?nMaJ4DOx+PfHvNM6bN6E7Sv6KOFi+YsKl74X+4M02JacBL6YcVkw3kqaVfYm?=
 =?us-ascii?Q?wAaocqmTjpHSoIwg10s7sCxEfP9YyInHXTRZk+y3ZxrthSha6RdlhjQAtSDK?=
 =?us-ascii?Q?/Ah3ALCTgIzKeXKXat5jK49D6wZzJzB6zKscexSuwVbmT8JUE79tlMPJQ2Eu?=
 =?us-ascii?Q?gBgiqX0nYtt704ZtKfHaFbAiGVDMAkmvKXUlSqCEZHkvtl+IQmJk77fzQD/k?=
 =?us-ascii?Q?PVq/sScH5lQEqw2C/LWOlRknmhpvHeJtRkfXXVqLjcQV8tJwq9VtkcxPPhoD?=
 =?us-ascii?Q?3UWfwq4LNvqVCiiiVyHtLdz+h21MBEzSZI9aYDQcP1B0BMjUQNgzy7/Y/LiA?=
 =?us-ascii?Q?q24xAfDXHt42oCaUzZLidnXndsBySrC6toSuRITcsSYmtNOf3rP8aPSVO+4N?=
 =?us-ascii?Q?jvqsS0VVea2PEEVZJtU2MxdpwiQupmZPkzFATdAIdJNzRDb5waxD+d3koYd7?=
 =?us-ascii?Q?EZks6EbqVrcKXGLr/HiBb19HK38NhVtgM/BWP5DrX0IVTbzDBnzRqnnOFVr2?=
 =?us-ascii?Q?OLCoA8A9KWbGzEjC6NDM0275BeBfBOneZQpZz9OUB1qxyucat21tRWiVLFqG?=
 =?us-ascii?Q?fNc+GTMzq21+5gW5pQijf70BGX+REjulzEvVJUMTOGKPZjHuXDZZpmZH7tbZ?=
 =?us-ascii?Q?uHJ8Drdy1bfHf2ayTa34GnVYpf1ZyBjk+FhKlV9o2u81fzK/mP1+7J6fHjA0?=
 =?us-ascii?Q?FIqbe0B3BjV+TIARs7idjjaUhqpBf+s1Pb1Eke7Msvj8sDCjYI3tUoVJ5xhY?=
 =?us-ascii?Q?dLTbAHe7iH2Xz3e5hkbDbZPgjJcFPS4eQ9ZO?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:01:10.0442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25351b56-599e-450a-3001-08de30c8ef68
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6795
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

This series adds PCIe endpoint boot support for the TI J784S4 SoC.

PCIe boot allows the device to boot as a PCIe endpoint, where the
bootloader images are loaded by a PCIe host through Device Firmware
Upgrade (DFU) over PCIe.

The J784S4 SoC uses PCIe1 instance with SERDES0 for endpoint boot.
To enable this functionality, the SERDES and PCIe peripherals must be
configured early in the R5 SPL stage before the bootloader images can
be transferred from the host.

This series:
1. Adds the required clock and device data for SERDES0 and PCIe1
2. Enables Cadence Torrent PHY driver at SPL stage
3. Enables J721E WIZ SERDES wrapper driver at SPL stage
4. Enables PCIe boot configs for J784S4 R5 and A72 stage
5. Disables PCIe boot configs for AM69-SK and J742S2-EVM
6. Adds comprehensive PCIe boot documentation

This feature has been tested on J784S4 EVM. Following are the logs
corresponding to this feature.

https://gist.github.com/hrushikesh221/13f2bcad10373f2fb87bc76dd0b906e5

Program used to copy bootloaders from PCIe Root-Complex to Endpoint:

https://gist.github.com/hrushikesh221/94e6042dbd717c74b74a5c9fc8ec5b6c

This series is based on commit:
65a13153107 (origin/next) Merge tag 'u-boot-imx-next-20251129' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next

v3: https://lore.kernel.org/all/20251112064725.1049199-1-h-salunke@ti.com/

Changes in v4:
- Disabled PCIe boot configs for AM69-SK and J742S2-EVM variants
  that share the J784S4 SoC but don't support PCIe boot
- Added comprehensive documentation for PCIe boot including hardware setup,
  configuration details, and step-by-step boot procedure
- Rebased on current next

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

 arch/arm/mach-k3/r5/j784s4/clk-data.c | 184 +++++++++++++++++-
 arch/arm/mach-k3/r5/j784s4/dev-data.c |  43 +++--
 configs/am69_sk_a72_defconfig         |   4 +
 configs/am69_sk_r5_defconfig          |   9 +
 configs/j742s2_evm_a72_defconfig      |   5 +
 configs/j742s2_evm_r5_defconfig       |   9 +
 configs/j784s4_evm_a72_defconfig      |   7 +
 configs/j784s4_evm_r5_defconfig       |  13 ++
 doc/board/ti/j784s4_evm.rst           | 267 ++++++++++++++++++++++++++
 drivers/phy/cadence/Kconfig           |   7 +
 drivers/phy/ti/Kconfig                |  10 +
 11 files changed, 531 insertions(+), 27 deletions(-)

--
2.34.1

