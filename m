Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE53CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D66A836B2;
	Fri, 24 Oct 2025 16:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E165836EE; Fri, 24 Oct 2025 10:59:48 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DEB38331F
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqcLtMqIp880q4tSJWtfNgQ5Y9Ux3kZZn+/+uddXRJIVuZYDisyqVheWd5xCxdhqWsVxP+6wybM4jC2MKoN14XUwxAXoFrEPzMN2H8yRdjbaIwaLT5fUDP9SkpFOcM8lNyX4Tp2QSZUJPmvgIJxVx+djz6a9hf6r9DkawQ4zUavmX+TeMOaxYBBIlEbhGE1PI3YuarP6wNtlKM63a8S+OKpxacJi8688SNTQ0Qe4SLTOGHe+ou8gcgetRG6RDD3QaZlMX0GzSfKcyLjXa8Lyx3V8oZfUk/iio+P0XC61/J/NgmGeYgVc+mfDQyMNFRoDnwoY5C+Bq3Lg2QwL0MqFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn+VmsMeQkF84eqc+qKFAp31hxsQm8n9+8uqzjHRzKI=;
 b=b4SzVYnMvujq2Ky/uVBSNUOw5D2GCu3L/IPIQ5Z/llLTDwolqq5FUulu1w3BH39AYtziw9aFigSUJaQcHc3MWTwJZInmtC3BKJmPiemW0Cdyr+spzN666XKlYJDaI3kCOWmH8AZTTYYYSER6r3/tUbrEAOCa6mV5nXwgl57DlUilnsNaO0Ds08wEdiBwiJGE3CLaQXF/Be2IOveSjpu5CSXd/3EvXN7XSJEG7k2F2fzlUSVh4m181OvwVdoyKOTdczx4JRzW++59JevQbulQnn3NhVz/oqMU6zs+tNyDNX8feQA4n8HrIJH/hkwnpAmBBBU+SyglWq4OGVZBn5KusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1228.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.18; Fri, 24 Oct
 2025 08:59:39 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Fri, 24 Oct 2025
 08:59:39 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/9] Add support for StarFive VisionFive 2 Lite board
Date: Fri, 24 Oct 2025 16:59:23 +0800
Message-ID: <20251024085932.83596-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1228:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6de63d-2839-4523-7af5-08de12dbaa1c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: bjxuKgR7fibbr/YNbjbGU/AgxPqBj7+VMywylnuCoRM49tBAppRk5DjO47KFOQo3kFh23NI4FVeX65wk2ce5Wc9ZNDcvslgK0381SVg15Dvtf0e3hYxz6PFnCCGMZ/dakbzOXs3RP20R8slM3wqh5LxjNqTSeQnkoJz2J2I8Y1BikTZ3ZzzdqXwFm7tIffHJ0dztLj7NVEAN+Lpws5h9ZtVQ9gR1Sv5xlajskM2jSwy8uHqcdeeSRmr/nrRa1XVvJfZ7JAkjd5iFHPTld392jCQmginiID+WOrTHVziYZP4590OY4pqeFXz5+CfggZzN1toIz+cKPmuTLa5y951rymASkwHpWwcPQApXFQmN+x1P6Nxi5+xSBzq3+hX+4tmqHb5inz9kK7InonCc1r7fTvIv6/RZp4Dz5GdLo0VioT6UXYcxuVB0DkbwCAkP9jQWWJzwo9A/zbMH5CJDzfc+omIi2usqQvlfmpCbVJARO2/441Hm4oRAq+6rOeQT9JfBRasKAcI61K+6QfBH6sTCChkSgg450Hg5ZPiZvBOZqtFmI2Qr4EJTwCqg+ZFmhoTbhlQDL3RZRNzovQiqT+w9QEPeTYZrbtcdvDq9GFFzoYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rr7JpkXfQQIIQCwR5dhu+hCIM5EJXmFQ43f6wPYo4cDhi2+pJxjM30FbIOyD?=
 =?us-ascii?Q?ntNr6eNY6XWTLh01HcHPvGto4+EnJovrNVJoagUPSKa2+Rk02LgEUIpW3ilG?=
 =?us-ascii?Q?f/YM0uvLXt5OaVYYEOSu1Yrjf6pyCVXMZskfwei5PAd7+w8GxOQAYtvWTS0l?=
 =?us-ascii?Q?2lpSSDqZiaEGgkPWwsSjTFgBd74ro8dobP94II+BW+YI/t5jTAxZAb/QjrjS?=
 =?us-ascii?Q?gBUrPI0o+ytFMFiLz5S9mT+KhnRO4qcMpT+M6obR8BTAUngK3glUX+rKdA9S?=
 =?us-ascii?Q?uQxBmTsCwNTLG3QdXO2iH+g07HzhCe1zk8jzsd9cu6KLs1cWBozgTIcRo86o?=
 =?us-ascii?Q?uEId63i5OqGk5pvAQiY/TY9z/s+S5zE0so4M9qxnwTnoRpfz7tMB+mgI7c/J?=
 =?us-ascii?Q?Hrbvr1a3gaElHhcB0dnI0GhlI3KaZZVHfil32nx6DkckQfQJ3Q6Os+RGuI/j?=
 =?us-ascii?Q?SfDnG73aXyl2bMl8tb9sg9e2QToV5zU1MCtMZYVT8MWsF+PGO8WklvpZK9uI?=
 =?us-ascii?Q?PAkSmu5v0aS1gBQewM/kdvkUlgFgCnjvzbqvUKlV5TC4J8BYi0whv2fWh4vB?=
 =?us-ascii?Q?C3fvh+Bgf1snp7dmovEBxR6TxoAUfmmPodj7/JC5GNami7BYWQ4DfRyWJ3VU?=
 =?us-ascii?Q?tSQfKLvHHeuz/yW4io7/XPNM9SVmSEkhNXyA9LutEnY8RR/dxg+DMv5iI8Jv?=
 =?us-ascii?Q?TiOC9DxFWtE8lUzNgHb1Gkov4mZzAGqGwLmbWvasjc9p+sEnrkjpEv4MzCei?=
 =?us-ascii?Q?6U/QooKTdbhYL+Tkc3xbG+D+kHBJt+qoSekO6rwk+wHwnJjxJXaNr5bb4gyF?=
 =?us-ascii?Q?3Uuo/o6dl4iSvAqRbliZS6iqxOCG85bSTs+JzkRPP6QeC7z+k8HU+7bddCDw?=
 =?us-ascii?Q?nOiUugQDLmCk3hqxCFIktBDlfe756V0KaA0yweQCeOuuTQnprRtsHNTNwfZh?=
 =?us-ascii?Q?xqLfT3ol/yPw0rSjGxEATufF41XMKLo0qqzzaO+RvNUfZnEK+v6ItPEdmBWz?=
 =?us-ascii?Q?3KKsMmXrOIIqGxXR46r2M0nv3oipk2SA3KVarp23QEZNbu2/AWp/xcsJ5w8J?=
 =?us-ascii?Q?3DChqTK5x0I2oRypccqp3bPJz5I1CnYQyddAB08lFHk5wW2WG6C5nKh6EqRz?=
 =?us-ascii?Q?aLmFqariZRG4FfrVY/ZNIJyr2vJJPd6pu7089ImG95cL3F+C6jtQ6R2vfXOQ?=
 =?us-ascii?Q?yYZDMx5waI4c5uc4cuZLYS1cG1kxlID29TGGIAOAWEqdEcuSeJasxJFJw7m2?=
 =?us-ascii?Q?pQCvrlufySQwsFPjrEGiWb49zHgqTylcZZrF6p7aKoYj5XcUPDLiF05qrzKd?=
 =?us-ascii?Q?vH10NKiIHusevHtB3y+MMYITf5eQPCNV2dMjyYUKjK4t1AvefPmnKMnLT899?=
 =?us-ascii?Q?q4RjJTdY6V5oMSQHzlLo9H3hl3ELjPfQFlkled9NlOooZeJ8w2ELFFzEBBz7?=
 =?us-ascii?Q?h0T/94Nw/lVrR1b+WU0UqV32tKTuOWhO0PdJ3L4jAmepZckPORxLkF01hNid?=
 =?us-ascii?Q?TDdaKxbqeHDQshI+A2RqEWY3AXGlfuPLAZBnHjau42CAkLa3ik3roRsdzp06?=
 =?us-ascii?Q?t5r+lo997yLgP0DFnnRVJurgv73Qt18FmUGUw7xOSIqIMhd1T4IfbY0r89FK?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6de63d-2839-4523-7af5-08de12dbaa1c
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 08:59:39.5520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZLMxM/V8EjugQ5A26I9tLGgaC92+s3MeK+KCYg8TXt8LAYMMA4vdYV3vfkI/2e/XdWquaPa2eF0tekbpVJmTYoAbGBb6JLOTecm3FTqbtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1228
X-Mailman-Approved-At: Fri, 24 Oct 2025 16:52:55 +0200
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

VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S industrial
SoC which can run at -40~85 degrees centigrade and up to 1.25GHz.

Board features:
- JH7110S SoC
- 4/8 GiB LPDDR4 DRAM
- AXP15060 PMIC
- 40 pin GPIO header
- 1x USB 3.0 host port
- 3x USB 2.0 host port
- 1x M.2 M-Key (size: 2242)
- 1x MicroSD slot (optional non-removable 64GiB eMMC)
- 1x QSPI Flash
- 1x I2C EEPROM
- 1x 1Gbps Ethernet port
- SDIO-based Wi-Fi & UART-based Bluetooth
- 1x HDMI port
- 1x 2-lane DSI
- 1x 2-lane CSI

VisionFive 2 Lite schematics: https://doc-en.rvspace.org/VisionFive2Lite/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/index.html
More documents: https://doc-en.rvspace.org/Doc_Center/visionfive_2_lite.html

Note: Patch 1 and 2 are the kernel device tree picked from [1]. They are
just for test and please ignore them because dts/upstream should be synced
with devicetree-rebasing.

[1] https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfivetech.com/

Changes since RFC:
- Rebase on the latest mainline.
- Improve the commit messages.
- Drop patch 7.
patch 3, 4:
- Return 0 instead of 0xFF if read_eeprom() fails.
patch 5:
- Keep default FORMAT_VERSION 0x2.
- Change wifi_bt field to onboard_module field and use bit 0 to mark
  WIFI/BT.
- Drop all "no_eth0", "no_eth1" configuration.

History:
RFC: https://lore.kernel.org/all/20250829060931.79940-1-hal.feng@starfivetech.com/

Hal Feng (9):
  riscv: dts: starfive: jh7110-common: Move out some nodes to the board
    dts
  riscv: dts: starfive: Add VisionFive 2 Lite board device tree
  eeprom: starfive: Simplify get_ddr_size_from_eeprom()
  eeprom: starfive: Correct get_pcb_revision_from_eeprom()
  eeprom: starfive: Support eeprom data format v3
  pcie: starfive: Add a optional power gpio support
  configs: visionfive2: Add VisionFive 2 Lite DT to OF_LIST
  board: starfive: spl: Support VisionFive 2 Lite
  board: starfive: visionfive2: Add VisionFive 2 Lite fdt selection

 arch/riscv/cpu/jh7110/spl.c                   |   2 +-
 arch/riscv/include/asm/arch-jh7110/eeprom.h   |  13 +-
 board/starfive/visionfive2/spl.c              |   3 +
 .../visionfive2/starfive_visionfive2.c        |   2 +
 .../visionfive2/visionfive2-i2c-eeprom.c      |  64 ++++---
 configs/starfive_visionfive2_defconfig        |   2 +-
 drivers/pci/pcie_starfive_jh7110.c            |   8 +
 .../src/riscv/starfive/jh7110-common.dtsi     |  22 ---
 .../jh7110-deepcomputing-fml13v01.dts         |  49 ++++++
 .../src/riscv/starfive/jh7110-milkv-mars.dts  |  49 ++++++
 .../riscv/starfive/jh7110-pine64-star64.dts   |  49 ++++++
 .../jh7110-starfive-visionfive-2.dtsi         |  46 +++++
 dts/upstream/src/riscv/starfive/jh7110.dtsi   |  16 --
 .../jh7110s-starfive-visionfive-2-lite.dts    | 159 ++++++++++++++++++
 14 files changed, 418 insertions(+), 66 deletions(-)
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts


base-commit: b10c055d4e1b5153a331a61ef82a5b01b5bb4c45
-- 
2.43.2

