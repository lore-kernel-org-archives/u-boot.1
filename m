Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C7CC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 03:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6772181D27;
	Tue, 25 Mar 2025 04:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="giKN84r9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 283618186D; Tue, 25 Mar 2025 04:58:39 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::72b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74DC481026
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 04:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AK6n6mfbZQAUKDd9h5edeiDLFRxrbJ1qHDhj8UvuoUN1/cB0rbPw8FrAfsyS8qvjmxlr4RomyALNklV1/1JfFM4MFXGVbyC7Toj0efbTgvdToUw1b/EY1OBvosL/Wh2anyq4Y7deRBKqj1U/qGGPBCdDw5bpp4+kbiLFxZrAaE+69AARz+k7ApA0Q+oloc6jw7e5iLvLwbJBF1t8d1353mEYrTbDcAi8f6ZWtHIbgzR65n8MTWUN/ZfOatMTR5gdHWZOh3kfUGRneQ5gOAJtpGBfYhGKmzVY8WnjF3gBfF3oIh2n1R+nVUZEA/QiU36AxNxla2O45oi7R5DdKc4kOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNrThEgK2YiGoyvoVPV1b+9Gm9xzvRa/gx4+JZmT0Sc=;
 b=xHEMG06qyr9KY54A0whSrJaVo9SITc0/GwVv6jjfpRwA2j2DmbTRRb4eao24Mpl/Vra3ovPOT6Ql6BX4SJogfQBSAR/jS/1zDcSWnJaUsRcJg3btCAZT1v6qW/HEDyFiDMQbwrhE0cREGrXWADqDZ66fZt0ooGJEWfkmE3kywAJtD3bIbfIpfdCmUDNDfxaPxORhyAVQHkXpycwWhYyiSON0JxGZL+HdM/qf3pcqlCTPiK7FiAiSh0v7pYpdPMZv7mTOJHhiOVLjAvaTC2KfZfwhADd9Zcn4o1IzhmG+m9mZLVavWHnsN0W5/3+qcYKfIKH8TZqbNb03pAKOjISBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNrThEgK2YiGoyvoVPV1b+9Gm9xzvRa/gx4+JZmT0Sc=;
 b=giKN84r9Kkng9z2o7z4z7e6MHQwWdW/cki/vm4e+iht8srFSa8cyfSQpXQK3Bm6uZoUdDMjZBcyBpUb+FTLz55oIq3iqQ3kQ3SunJGTG6lMZwNgxUrJv47/QtPYb7oTKA21JZU4akwEKkuIDP5OyRwTb2XBv5BT8EktL15Ewv7im0YLRg1HHCSMzr20+ivZIGhfD5okuvC23z9JzO2UQPWbQ2rRvIgXqlU+9RmVadeGgvBjU8uPz/KyMoDXFkMnHDyqiFVC55jP0/YkgTMCQLb1MdpIjw2lJc+304dwQGJjze158St2Bl19/vniqPxCel5OP/PG7giUpZUCBZssiWA==
Received: from DU6P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::6) by
 AS4P195MB1672.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:513::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Tue, 25 Mar 2025 03:58:33 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::79) by DU6P191CA0018.outlook.office365.com
 (2603:10a6:10:540::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 03:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 03:58:32 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:32 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:32 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <afd@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <vigneshr@ti.com>, 
 <s-k6@ti.com>, <dannenberg@ti.com>, <bb@ti.com>
Subject: [PATCH 0/8] *** Add Ethernet boot support for AM62Ax + phyCORE-AM62
 SoMs ***
Date: Tue, 25 Mar 2025 04:58:16 +0100
Message-ID: <20250325035824.2304200-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|AS4P195MB1672:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fe8dda-cbca-43a9-a6d3-08dd6b514f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EDwUwutJdANNp0HRseAfvCcUyWBP9arOn7PT7UY0+4Bl7qdsPo8Rtq5dbI3r?=
 =?us-ascii?Q?sGEu/Rl/Et3mRNh9sQXXvQ9qA/8JjQyvnQVemljBv7u95YJZeIthRMvcAORt?=
 =?us-ascii?Q?v5os6EwmZzzhgkRj0+8t4PLrKx7KS1LUo7gtbo7VJygEuNEacsnUp5KYO6P/?=
 =?us-ascii?Q?AAvZUxiRDmRs6M0axnhxSQCXNf1jmsbqsoqD/tq4qrJ9TcebTzLGn4ITC/p/?=
 =?us-ascii?Q?KeK4LSFDUHp5zPd9m9Sm802bUhE05z2tvfkH2HsTNVYrCaq8353YvTGPqjLo?=
 =?us-ascii?Q?zQcmW8e7n+VvE2OQKw8xJgA16PrhAllxr0U6BjelpzxLFrF2QNvOACAmJ94i?=
 =?us-ascii?Q?j62E/+c58+pIhYpdC3UOX56lLG/erz+syqnCjf8h2/cVbWcK+TQazIsT6QMW?=
 =?us-ascii?Q?cxqMBmq4vjCzBuAXIafW5GgKXpJYbFHzhVSMlNsMr1/rEaZmljQijRwqiv6x?=
 =?us-ascii?Q?1YC2DLxUhwR61f2OUL/sGcL4O/iId1azNrooJ9YyBjeHnbTGE/Etgx0IXFka?=
 =?us-ascii?Q?zGkJOhzXKeDmiaVSowpRq1l9efeCsg0v0XwBE1Kas5H1cm+u0dPUfVvEhTb4?=
 =?us-ascii?Q?l73TLpDGJRjaZpXHIFD3uXWqcmEq73XrRN/hCOaLq7bp2oLDq9C8HV8Np66F?=
 =?us-ascii?Q?WBWhL9hINd6Re9BaR/Yn51x6H84FeLZRXKwHEl6om6inB6Fe+hOnaya2SVw9?=
 =?us-ascii?Q?gPp7p1iIOPQb5QGP91kvlgggYSBArftYxslxmAzuODQsNOngfUhLiMIesGYg?=
 =?us-ascii?Q?HnYa3o5mtFb2jNjvLgVcp8INvrTaq70rixcDBgb8OU90/CPJbVTSMWawCerT?=
 =?us-ascii?Q?TzJqRRhgz9XjtFR3gvsum6GQBFX6oUDWtgXRt/Sn9OoXiVAfsfaDa7Os1uD6?=
 =?us-ascii?Q?VQo3f8zfda6B8lCDH0bpN/cRh1PKdmrZ+SCV0yEwkO1Bax81JBcrqG/ct8d0?=
 =?us-ascii?Q?rZEtZyjTp7h3HT5clN30YF/sjKqXIwlFtpBKaZWyE9daWyhNDZDutMCKYy5z?=
 =?us-ascii?Q?3eo0VVHO6NUXzGfPJzagPJP8NXj/sviUX/PBkmSpvarSlPpxjbPVOIWQHaTp?=
 =?us-ascii?Q?+gdXMLx3BCZLxQbnKIYv1Qw9DIGJHWMEu0j91/8m51pnDSMvbddGC1KQq7Bp?=
 =?us-ascii?Q?cbTivA+1dU2oWuDuiX8bXsT5Qya9yx7hzQuyUyZJ47nVzYKV5F4xitAklxHG?=
 =?us-ascii?Q?8VWIS7nuGrvMdM2EqoBZ1rYOYIiCEP/ILRwxaZWRii4t67jwhYNxv3j/ej+Z?=
 =?us-ascii?Q?E18FN/8776P24YeRG2U99zkcdtqIQY37Hv76nYkOe35KrN1CgIl9tcYBkLdE?=
 =?us-ascii?Q?uh1Y52Y3Q4DcYMPa+p3DYmAHoX6jckgO91BS/vwcD0+kfSVMxUwUvTWuViEf?=
 =?us-ascii?Q?NSDlU7TWcnIQLaWw5NhD2a/V/9CjZTQ10pUHT9Z6ulUA3mezwfJdznkKPpuy?=
 =?us-ascii?Q?vPWi955zK54=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 03:58:32.7614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fe8dda-cbca-43a9-a6d3-08dd6b514f9f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1672
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

Add general ethernet boot support for AM62Ax SoC.
Some of the work is based on TI's downstream u-boot patches found in
[1], patches touching code in mach-k3 and *.yaml board config files.

Also, provide defconfigs and device tree changes for phyCORE-AM62x and
phyCORE-AM62Ax to support booting via ethernet.

[1] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1307981/sk-am62a-lp-rgmii-boot-mode-problem

Andreas Dannenberg (1):
  arch: arm: mach-k3: r5: am62ax: Update SoC auto-gen data to enable
    CPSW boot

Daniel Schultz (1):
  arch: arm: dts: k3-am62a7-phyboard-lyra-rdk-u-boot: Disable Ethernet2

Nathan Morrisson (2):
  arch: arm: mach-k3: am62a7: Probe CPSW NUSS in board_init_f()
  board: phytec: phycore_am62ax: Share ethernet resources with boot r5
    core

Wadim Egorov (4):
  arm: dts: k3-am625-phyboard-lyra-rdk: Add boot phase tag to
    phy_gmii_sel
  configs: Add phycore_am62x_r5_ethboot_defconfig
  configs: phycore_am62x_a53_defconfig: Update for ethernet boot
  configs: Add phycore_am62ax_r5_ethboot_defconfig

 .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    | 14 ++---
 .../k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi   |  2 +-
 arch/arm/mach-k3/am62ax/am62a7_init.c         |  9 ++++
 arch/arm/mach-k3/r5/am62ax/clk-data.c         | 51 ++++++++++++++++++-
 arch/arm/mach-k3/r5/am62ax/dev-data.c         | 29 ++++++-----
 board/phytec/phycore_am62ax/MAINTAINERS       |  1 +
 board/phytec/phycore_am62ax/rm-cfg.yaml       | 10 ++--
 board/phytec/phycore_am62ax/tifs-rm-cfg.yaml  | 48 +++++++++--------
 board/phytec/phycore_am62x/MAINTAINERS        |  1 +
 configs/phycore_am62ax_r5_ethboot_defconfig   | 43 ++++++++++++++++
 configs/phycore_am62x_a53_defconfig           |  9 +++-
 configs/phycore_am62x_r5_ethboot_defconfig    | 43 ++++++++++++++++
 12 files changed, 206 insertions(+), 54 deletions(-)
 create mode 100644 configs/phycore_am62ax_r5_ethboot_defconfig
 create mode 100644 configs/phycore_am62x_r5_ethboot_defconfig

-- 
2.34.1

