Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE19D13590
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 884D489058;
	Mon, 28 Oct 2024 03:00:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9000288F70; Mon, 28 Oct 2024 02:59:20 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20711.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D74288FE4
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 02:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d32m88JJSWA7PspOFCj8Kgory2K3nl7s/J61BDfzaAsXBEZckK13oUbuDJVQEDr7/hx4hTJ691Oz56mK5kVvwZJ7OcXA70Osbn7WMz42kx1LMr+J3qZzDjzE+Da2OPApA9Nf2dcOTmWjaEIDpzHWNEjsXlVa1CDyuSjzUo8Yikz1sNTTyMy7Tvz6NPMXTriQhYsybydJ2sqUHYnawppUO5LGPikgKoNa8uuebpDT4cWlEsqpaO1zkR/Dg3zWbfEKzISRi2Z/euCaywgIF8YBbeRB40kquQgC2DTU4rbNWJ/HZCfNJujh8m+X5MBpJV4OWvQ1aAKLJrl/Wmfl1cMlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3Xe5GIvD28x96qFzfYMtbaEP1QzBNnOpbeUe+eKR5Q=;
 b=INeoqUy7gyIVK2Pct0Ry626mHwAi8G27k02M72XOZKvVijgExKrzcMaA5gG+hg5ptJll3zM2+v9fHUik4oMSd8/oSXF6Zi4PgrxTwvIYKz34lTb64riCj7bZV8l30GYlZaXTjhd+PQExR3z2l4nPT/2QYFYaLDtdCzt/W14q8+WozxCYOZ+mo/FZYP31qbbmrVkcTti8rFdQavuH8NGIgBWhz1K6C/+qyf9VhPV8usdgTs3OhZBvdPSjAdBB5LW/LTTwA/H59KWz2wJE2HjNpWXDfKiBy7DQRqcmMPJ1fQvDlgWphHYhn+ApTvyAKbVIDqRlkEsLgni5mr8QQlW32Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:59:05 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Mon, 28 Oct 2024
 01:59:05 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 00/14] Support OF_UPSTREAM for StarFive JH7110
Date: Mon, 28 Oct 2024 09:58:33 +0800
Message-ID: <20241028015847.42344-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: 303b387e-336e-4cc6-3846-08dcf6f41a61
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|366016|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: xX5QkR9xPcnBc7VyNeDuykbS0E1+awMbJ01dPQ3Ul6ITBIWPdDUgci7zlbxMCZ/NU6DvOpa7j/xmkdPacPvJLwFC/r4e4wQwfxmAoMEDMqFj6tcRI923MnwCBuDjNv07Rr60XC5QYAanBwE+WIrtma3ZyKmJSluKGkk1OjU7FNfhjSmvTEEnTHppcTd6TtDDdyGj/iAcMGYp9ENdU2JHde9ukq+OyvJOcIbWZur+Z088/Gvr2l4oy48Ffez65c2jNcoaQmyYk7GRPeWLSM+D14apvb4GYKcy7EwmxdU3l3cT6m3Z3F8hi3yo7z4XUOHGSspiV/KoNb2wtokmcZhaVxYEQI2yp/io4KQ9D9fD5oAgOI9FT1Yue52KjgpbAQU7TpVZM5VUCnI8S/R0u/5IiqOl31RgGy4U3DNbKWTC46sBSOtnNLm+iffUSZ/euAS8z0+7m5QYzmJLiQe32EqCsvJnP0oxpSKLrf4FQdyFT+mWm8YF22XR/bkmEWLUg39nd6h9I3KbVigQ8rej/IkDf1kigLODetyh6RNjlm2oEOw8oB4Ru2FZOzoxo5X/M2XASb2D09DOT3KoK7OMH89MPQ2dr0FpKBQTeU+EFgDldZvW/FN4sNomZyu8tfLyr0KY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(366016)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aTD2Y4gefHbpxYwSraaXBsaNPp86OlOterRbC19MOxe4UXpU/hbWTKXr+h0M?=
 =?us-ascii?Q?BeVeWR5hPSwKI2MLGLL1l4Xoi8rSZUOjvkBHKxjyqa8Lk3F3xPujh8oqjDke?=
 =?us-ascii?Q?RwEZjPKUlI1XdZhF1rcRuhWzgaUFep+f/ZQKt5QwzxviGodg8g51by+/Mtre?=
 =?us-ascii?Q?yVQvhqoqAvtEYG81M4jXTmBez4pFW0GebsfvxKykdK7GR/kerRf/YEIdR+qV?=
 =?us-ascii?Q?7CXuQBlPXSU26ZtUcfrtVNsMIXOUJq8UDIM4v05kgrHOyNs7TxxVkEx9u7Ih?=
 =?us-ascii?Q?fRPLPhBwPRz4aeUtAvps0xGCr2iQsThUkgJjzGzMqclI1aT6942q52MOPPsM?=
 =?us-ascii?Q?4yPL0hjeN43ExsDAOGhNLW32O1DerH94J9g6eF9EAdtP4ndMJbcLRdKeAVqB?=
 =?us-ascii?Q?Wm1R0FZOCBa8dO8Qvi/aBXG8FGTHH/phy69arMp5/PWbLCGW13j4ObKOKD7Y?=
 =?us-ascii?Q?xlLG0EqRfosCzQY+KaoEsNrXS/jhoP/BsPRjAj5q1mhidS8O/vfVyIoBGVqg?=
 =?us-ascii?Q?lt1/rSSnZfUZDP9TMTz3G6fY2EMIc6l8bFXsimk+JgMASWr5yLSC4azr0oU5?=
 =?us-ascii?Q?ATuSEIv2NorZSPvK1ZWMd+TmMUnGe6T0nYhsFmMdjw8QPkk2D8FsVEZQ95eZ?=
 =?us-ascii?Q?zQgJk8eGqavEFg60qr4xVfFjDinE/Bp/EpQK7i9nRkfOdtopvK8uYwmB8v3y?=
 =?us-ascii?Q?x85hQuVA1kKx/xFQF8gm8YVEOF8neZI9WTxAOeHnX1AXzeK9jLfr/XAmkyWg?=
 =?us-ascii?Q?reMMQ8Ai6lArfZ2mcOUs4EOuHfjgvvE5uVqalBWZPr4ulYUThvICGq6qDwTF?=
 =?us-ascii?Q?3A/QQxJ9FeXXVgJB0NCOfN71YohjYHC8qasSOa1xt4Skg7AVvruOGVX13E32?=
 =?us-ascii?Q?4F6nNa3l/H6Rso0zwwbogj+RG6qCAmzQt+PGnMqB+yiuvw5xFzaIrHwYK+I/?=
 =?us-ascii?Q?FlGY+o0GsF3oMwxQ40+iXTn9YKvy8TE7n/iNcuFUSdo7zXx5TGuRqWgO2Ugf?=
 =?us-ascii?Q?z7fNd6RK08DPr4QYtnJOeCbCXP19dq+Xeed13W5tg71E3EGipmR97iyWbF+x?=
 =?us-ascii?Q?B0BsBAuQ33VW4PUSQR1LkSQM/V9/2DALeoMRKEaSHYJ2Qb0xnIjxzPyD6SF8?=
 =?us-ascii?Q?XGNZS62PMmeUdbot0LLCc2jjg/FL6/OB9cKK4MBI0kvGSaEczJb2SjJ9NUnX?=
 =?us-ascii?Q?GbWO1Bm/kRZPIXc3G/3PgK2SobO1gURuo5tmh9CsG7FdDsR1KY9BKBAnfGsg?=
 =?us-ascii?Q?IQgZrI1QFyOp3FnTyrmOjla/d48R99J2aERlKP9o47XRC6ppT+KCtClAgn0S?=
 =?us-ascii?Q?5sIoCX+L7YouzKB/APl3VhW2XMQUmdFupW9b1YYVlufFR3rSGioidMagFFAd?=
 =?us-ascii?Q?7XPh9dUNhaMUAswxyMHW62tBCObJGZywnE1NMPTgSoxPh+jyMohXd3yOsIro?=
 =?us-ascii?Q?C978/APZdrAGuQ+xIzy1Ct84a2bHe05SbgcFjH6dF2d1DTx0SL3Rs2USJe1Y?=
 =?us-ascii?Q?GJBLh+17LHXm/9xyPivLAN9EisEtnDcFEIEaPAbCdd4B9NCilS99F4Y9sxuZ?=
 =?us-ascii?Q?6WXowQJGmZwb3O1AExhdQK5C7mVjB+7XyUZMUAtScuOR1XT3mG2DW0xfk1x9?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303b387e-336e-4cc6-3846-08dcf6f41a61
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:59:05.6614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJ66HYSY3+532wS9PxHfe4vJGneXpwPhzP2wu8DHOqnzKKW2GJqt0POTxpfrGGOjX/By6KeD25iptXXYZlhnzijxcDlBVQ0mBzfb+87AB/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164
X-Mailman-Approved-At: Mon, 28 Oct 2024 03:00:01 +0100
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

This patchset add OF_STREAM support for StarFive JH7110 based boards.
All the JH7110 based boards can use the DT from upstreaming linux kernel.
The v1.3b board device tree is set as the default device tree. Support
CONFIG_MULTI_DTB_FIT and the SPL selects the correct U-Boot dtb using the
EEPROM information.

Changes since v1:
- Drop patch 12.
- Modify patch 11 and add three new patches to support
  CONFIG_MULTI_DTB_FIT. The SPL selects the correct U-Boot dtb using the
  EEPROM information.

Hal Feng (14):
  Makefile: Add OF_UPSTREAM Makefile for RISC-V
  dts: starfive: Switch to using upstream DT
  riscv: dts: jh7110: Drop redundant devicetree files
  dt-bindings: Remove StarFive JH7110 clock and reset definitions
  riscv: dts: jh7110: Make u-boot device trees adapting to upstream DT
  clk: starfive: jh7110: Sync clock definitions with upstream
    dt-bindings
  pcie: starfive: Make the driver compatible with upstream DT
  riscv: dts: jh7110: Move common code to the new
    jh7110-common-u-boot.dtsi
  riscv: dts: jh7110: Add u-boot device tree for JH7110 based boards
  board: starfive: spl: Drop the unneeded DT modification code
  configs: visionfive2: Enable MULTI_DTB_FIT for JH7110 based board DT
  riscv: dts: jh7110: Support multiple DTBs in a Fit image
  board: starfive: spl: Fix the wrong use of CONFIG_IS_ENABLED()
  board: starfive: spl: Support multiple DTBs for JH7110 based boards

 arch/riscv/cpu/jh7110/Kconfig                 |   1 +
 arch/riscv/dts/Makefile                       |   1 -
 arch/riscv/dts/jh7110-common-u-boot.dtsi      | 204 +++++
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |  11 +
 .../dts/jh7110-pine64-star64-u-boot.dtsi      |   6 +
 .../jh7110-starfive-visionfive-2-u-boot.dtsi  | 117 ---
 ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |   6 +
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |  14 +
 .../dts/jh7110-starfive-visionfive-2.dts      |  11 -
 .../dts/jh7110-starfive-visionfive-2.dtsi     | 380 ---------
 arch/riscv/dts/jh7110-u-boot.dtsi             |  36 +-
 arch/riscv/dts/jh7110.dtsi                    | 761 ------------------
 board/starfive/visionfive2/spl.c              | 385 +--------
 configs/starfive_visionfive2_defconfig        |   4 +-
 drivers/clk/starfive/clk-jh7110-pll.c         |   6 +-
 drivers/clk/starfive/clk-jh7110.c             |  44 +-
 drivers/pci/pcie_starfive_jh7110.c            |  59 +-
 dts/upstream/src/riscv/Makefile               |  14 +
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -----
 20 files changed, 373 insertions(+), 2128 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dts
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
 delete mode 100644 arch/riscv/dts/jh7110.dtsi
 create mode 100644 dts/upstream/src/riscv/Makefile
 delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
 delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h


base-commit: deafcdc8e014dc83f154cc448cf8cf6a24b29136
-- 
2.43.2

