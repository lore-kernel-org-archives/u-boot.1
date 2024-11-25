Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B03D3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3F3A895E8;
	Mon, 25 Nov 2024 01:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107EC8976D; Mon, 25 Nov 2024 01:33:39 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20705.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C83948955B
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgkhC2/yMvk4k+JcJXNuNjQYNX2aCd719xcw47wvrj1S9ezpXu1YbBvQ+uizScIkTCMyWUZLZMuA7Ub8njKyWdu+LxaXbUfFrIZPw4wHUMS7fO7emjtZ3EHHaW/e6D9l6MAIHTXjJDxPi7MC9fUaaR0Zylp01Gb46oYbsxqi245zomLLsdPAJ97F6F71os4IbBAX6cu0F7WN8hvomqyuBBXl7uNxKduu3kEd0dkMlEHQx6XzorT6NPo3RfTfbaEnPjPEWac/T/bMMLQhvimMobkBnnCyqA8I4SqItnrAJkFdwMK/JO0/aJs/tUrCBTqG4k2zL7xvSbXibaPkOh5FFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7n/zxcP1gbUd7FWSHYU4ZZESw9kCEo92on6S0vyE90=;
 b=nzsMh1+A5jRNKXfels3ejoyI9JZXQjm0GoB36sAW03j4B12FDguH+mBoyd9SVXe1XRR+a75LMCTi0fG8pUwW8INtXFX6GRYrnn3RWMceVXYUYAapy7mx+bADpQXWcjvbKPkqMU1AaCiyCZEHbLluKz3iHFRd7ZCZJnwxdIcZ6dDybr4wQmPQ3rJH9/0VSlIjmqOHWeqgmyBLTvJicdSQ+T8atXECFl8xgO3yv5JgSBcnN0B6j7vxgbaWCCtFCGDg21OscWxnR9qTPLwjwKbz+7cXeEqsu5IpGRoZoQjO1zuYr0+BoJsZ7tuBVCMK9ZvvHXyFx3nXBSoUtkQ+rduUxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 00:33:51 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 00:33:50 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v6 00/11] Support OF_UPSTREAM for StarFive JH7110
Date: Mon, 25 Nov 2024 08:31:54 +0800
Message-ID: <20241125003205.75327-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0033.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::10) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1244:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d80a2ba-7ae2-4fbf-a53c-08dd0ce8d54a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: MnMj1kpw3EgS8gBun6zzRWjpk2t9UcIMb2IPpqrg4rnrTQERL9NHXZYgIBPdkL7mFR56AkCPqalh4QJ9xsEmVlAr6KCPozQ66RgnZPqJ/C7AqTiSWFfos9EPb5dKMrGMRDjLmYkktTw1sVzk8NCEskpLDZBUsXPsJ898uYohwq6nvLwKUOYW8goO2S5CPu1+r8TSdO/3oJHnBd+px0axrIFyXYBSLkFeboBcuy280//98hRSMvOUeuyKlGrh9TEK1qE14phkM0MD2/eysAtvDC3G0WEdNsd+FxRoV7snBSBOzsNpqegPyaZ1JO98ii3CrUCt5WidGtsRDkJAPSpsl7OQtc0S28RDdDwD6Nr+6HvXFaRRL0QqpqX8Xq1a7Agoif9pAxAnyKASL3J+IOWeu7/ctt6Lly1lB2kPf0pu3t6LqI89YCm25Ot6/AgxcloOZoXtUgdF/b5WL0KGNGFQb/GygjuJTFqx+Lg4zQN8bqHPF3xk5pFMsnyH62Y9x4e09RXXATDexpNVHZk3UyNlSsMWzOUcsNZ/vFN+x7zYzxzQ9SW1vc7KHOm+8TZTVflgHTiAiRBfO2zERNQ6cSMOTL4WShr5IriZh8GntIwi927QWOGxqd6rldt38qKd4Jn7aLd1I9/Da4kgqAuG8Q7wKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z6B2qctH6FLGCN6E+xTZc4FeKGu5qApurerptnnI27bHrXGavWzMYMuz19NZ?=
 =?us-ascii?Q?IqnDhEBzEW3J8rcE2vEa1D5DIWMGCD2omn8SBWzLMgGo2z7XZ1n9LBGP3c7t?=
 =?us-ascii?Q?IuW5seamzPPykpfPF70aq2cnwtk2GowtjrAQslsgqRf5fZUyVcfjgUYKxe25?=
 =?us-ascii?Q?VszumR7qT+lHOQ+G9C12tae1r5XN2YmjTHSkLCwScyJNhFCt34oXnKSk3+9t?=
 =?us-ascii?Q?kPvs1hVlmweLwGIPYvq4GvG/JYQpATQPwErDB6DsCVrIQtkjiuH9Tnv6mszB?=
 =?us-ascii?Q?lRN/gnjxa9VFbuwVE9CzxMTwiHA67uH5i4jJFM/TspOZ1iivhbale+uqzjKh?=
 =?us-ascii?Q?mIPoJ2RYAK/7BLN9mF0axOuQwVO49+B6yZrXq/mT38hYYd7SONqBH/0QjPRK?=
 =?us-ascii?Q?kSFwfsm+n9Gk8pQ4XCKRuoO3HLUJQUBbXE8cHRmwBGKgltI6ikdtXtJjC2B+?=
 =?us-ascii?Q?M7FlL35+rDxgztgPHOkv4Cc0U3QTLmGF4g/PlJOXf8lnHE61zyqmOab8VQOa?=
 =?us-ascii?Q?0v+GL7An8+WSthRyDyifJbQpOtm4vzPrzn0FDxrqD2M6+349UkmGrYl0wbDq?=
 =?us-ascii?Q?qNiYZ2rvTLeGcQJTziCghzmDhHvVgzKKpKn/iJbJPVfGaXUQ50MyGVUTyY6C?=
 =?us-ascii?Q?AgaNP7iIJjPlV64waZtRCM2YCod1+LOipUgckueksEM/Uag8pVS4nriuNi4p?=
 =?us-ascii?Q?2qlxFBmLo3gGC1g4ACavmUO0XIMW1+NSI+9pTEVssTV3IDdkmD8GG3RCdFUb?=
 =?us-ascii?Q?U04WPTkjdtPO0teuYP5rHOFiR1NkujySZqcYI/PI1/ZZBSCwoNHVeFnCMlV/?=
 =?us-ascii?Q?ucUazujZ4EUPn/WE+XaNJCWv45AAI/SnSIpFN06Al4x+Sk2hGDObRAB1APSK?=
 =?us-ascii?Q?Y3UcQrHakwLexBaJr9UmLsOAa4w4GhENfvNuw+t6Gzg2BEscyTM0PgNf3VTd?=
 =?us-ascii?Q?s/Yh64eK1wFFyN4hVjqpD7Xfl4tqZY3vCxE0KUdOhlP70pHBYI3t4mM3nCY8?=
 =?us-ascii?Q?/vbPx+5GiV11PRkN/QPr94dJj16PfD0SW3vi/Z0cpbp4JzOYFaml4aQHAoM1?=
 =?us-ascii?Q?YSfB/gajPqFp6FYWNjBrhEen4gMeEZxuf2rk7UVqwqPIYQ2V6WQ5W3loUmYT?=
 =?us-ascii?Q?uXLHOe3fRGnI6DyWT43y2PwUMjC5A3RIAq2SIm9zDshk8yRlP8E+85juYizZ?=
 =?us-ascii?Q?U+R9tCq4KrLtL9bTyfBSXGXR1cydpgmh1YEDnYPPA53I1BMsIU7qurf5HQvp?=
 =?us-ascii?Q?dr0mvHN4r6BGZOZULiY8FLlz74aEvRuRz1elhJdclKTYW/BCgnQ0Xxvikwr+?=
 =?us-ascii?Q?YL/agAph+4g9Oslr4XuAxK207FMaGwAkxdnH/HcbknO3zSCNgIUk0csP77K4?=
 =?us-ascii?Q?8lHtp/UQfSMAZpa8tIqe+KikAK+4FuPd5m7GNdNdO9J+oLXjIdVK6kyEDmde?=
 =?us-ascii?Q?G3xES4779d1xDPUtF5oxIQaXfnxZBckwnOXaEe7mjYR9sb+MUXJoKr/IhSk1?=
 =?us-ascii?Q?Ckvwvnay71Gy0uolntFfLDmokYfveLT7Dz/lFlKq71tmByYk5eFFUgPIq/AA?=
 =?us-ascii?Q?mwHbn27yWPdcYF3XEEJDQSkJLyK1OGkRChGiQq0DDWrnqHPxeDRh/MKvnsVJ?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d80a2ba-7ae2-4fbf-a53c-08dd0ce8d54a
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 00:33:50.8038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrOltNOQK7CD1wC4/hOkm5y1joXzu3eXfCgi+KH2ylISFufUfnP3JG+ZQv/n8FdZgR0RB4MJCqUOXExfvw3qn42AgDTzTtuPMRnl8YG0nFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1244
X-Mailman-Approved-At: Mon, 25 Nov 2024 01:40:37 +0100
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

This patchset add OF_UPSTREAM support for StarFive JH7110 based boards.
All the JH7110 based boards can use the DT from upstreaming linux kernel.
The v1.3b board device tree is set as the default device tree. Support
CONFIG_MULTI_DTB_FIT and the SPL selects the correct U-Boot dtb using the
EEPROM information.

Note:
1. Mars CM (lite) are missing upstream dts and so are detected but not
supported in this series. Users of Mars CM and Mars CM Lite may stay with
U-Boot v2024.10 until this is resolved.

2. Property values of network phy0/1 for all JH7110 based boards now
follow the upstream dts.

Changes since v5:
- In patch 2, drop the override of rx-internal-delay-ps on phy0 and phy1.
- In patch 5, drop "/delete-property/ motorcomm,tx-clk-10-inverted;" for
  Mars network phy0.
- In patch 8, rename fdt and conf based on the compatible identifier of
  boards.

Changes since v4:
- Merge patch 2, 3, 5 into patch 1, ensuring git bisect works.
- Add a new patch to sort the list of JH7110 imply statements.
- Drop the reparent of clock JH7110_AONCLK_APB_FUNC in patch 4, which is
  unnecessary and will cause errors in gmac0 initialization.

Changes since v3:
- Add detection for Milk-V Mars CM (lite) boards in patch 13.

Changes since v2:
- Drop patch 1, because the riscv of_upstream Makefile is created by Conor
  in commit 239e4705099c.
- Drop phy0 rx delay for milkv u-boot dtsi in patch 9.
- Add a Fixes tag for patch 13.
- In patch 14, the PCB version is only obtained when the product_id is
  VF7110. Improve the commit messages.

Changes since v1:
- Drop patch 12.
- Modify patch 11 and add three new patches to support
  CONFIG_MULTI_DTB_FIT. The SPL selects the correct U-Boot dtb using the
  EEPROM information.

History:
v5: https://lore.kernel.org/all/20241119020425.51989-1-hal.feng@starfivetech.com/
v4: https://lore.kernel.org/all/20241111020808.38974-1-hal.feng@starfivetech.com/
v3: https://lore.kernel.org/all/20241105034328.56439-1-hal.feng@starfivetech.com/
v2: https://lore.kernel.org/all/20241028015847.42344-1-hal.feng@starfivetech.com/
v1: https://lore.kernel.org/all/20240930155919.111738-1-hal.feng@starfivetech.com/

Hal Feng (11):
  dts: starfive: Switch to using upstream DT
  riscv: dts: jh7110: Make u-boot device trees adapting to upstream DT
  pcie: starfive: Make the driver compatible with upstream DT
  riscv: dts: jh7110: Move common code to the new
    jh7110-common-u-boot.dtsi
  riscv: dts: jh7110: Add u-boot device tree for JH7110 based boards
  board: starfive: spl: Drop the unneeded DT modification code
  configs: visionfive2: Enable MULTI_DTB_FIT for JH7110 based board DT
  riscv: dts: jh7110: Support multiple DTBs in a Fit image
  board: starfive: spl: Fix the wrong use of CONFIG_IS_ENABLED()
  board: starfive: spl: Support multiple DTBs for JH7110 based boards
  riscv: cpu: jh7110: Sort the list of imply statements

 arch/riscv/cpu/jh7110/Kconfig                 |  19 +-
 arch/riscv/dts/Makefile                       |   1 -
 arch/riscv/dts/jh7110-common-u-boot.dtsi      | 198 +++++
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |   7 +
 .../dts/jh7110-pine64-star64-u-boot.dtsi      |   6 +
 .../jh7110-starfive-visionfive-2-u-boot.dtsi  | 117 ---
 ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |   6 +
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |   6 +
 .../dts/jh7110-starfive-visionfive-2.dts      |  11 -
 .../dts/jh7110-starfive-visionfive-2.dtsi     | 380 ---------
 arch/riscv/dts/jh7110-u-boot.dtsi             |  36 +-
 arch/riscv/dts/jh7110.dtsi                    | 761 ------------------
 board/starfive/visionfive2/spl.c              | 391 +--------
 configs/starfive_visionfive2_defconfig        |   4 +-
 drivers/clk/starfive/clk-jh7110-pll.c         |   6 +-
 drivers/clk/starfive/clk-jh7110.c             |  44 +-
 drivers/pci/pcie_starfive_jh7110.c            |  59 +-
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -----
 19 files changed, 358 insertions(+), 2135 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dts
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
 delete mode 100644 arch/riscv/dts/jh7110.dtsi
 delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
 delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h


base-commit: 880fcc49eb40a78ed27ff575aa02034d7bd74e80
-- 
2.43.2

