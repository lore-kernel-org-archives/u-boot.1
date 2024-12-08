Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06ADE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 13:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2211189520;
	Sun,  8 Dec 2024 14:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0865189515; Sun,  8 Dec 2024 10:21:19 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09AE5893C4
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 10:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhGKRKjRWHHMRRxaivyoiPrGGYY7jLIJAcjQqqApNCIYaFXb+XjCEcF5BrT7Iye/7kWgpt0M39WiFmE+TYB5nlbes4Wdyg9moBQEE92fkhxMm5XFufWl2XG8UgeQyIWQduEQutWtBxHYDYfMxFQ1sEVQXc6fjcBLwCl0wxmBATzKNUdSfweF7LLH0DGw4OQ7WDzLUgEImMn6lNRQr7FAB6diyLqbWcBnDuydY0/92HUOrZM/KVfgbnAR1wFloLaeHQtBEb5HUIAKvTeeB5J9LKJwbFon+dBnRD+5RwNJBBCp8vT9TMje2SexAWGJPhT9QOM+fz54ftCe3B4K/W+G3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrpVR66ZSRcao0IGSNRES+rgML4WXq2YedmuzvHN9zw=;
 b=gct/v88nqNKxzTBSUJmZr2qI2CmqO/rOeJBEe2VBoQxQVwQcGDhX/JqTg8Nv+xSOk1nsGWG4Vz8aAjWUe6xHhKb0+zyQOZdm3QGBDld8yWgPx625/S+idIebE0cbls6TzlTvQ2Rlt/V1edFU/79E2FBYNQsI+YN0gSMc4gfIg93iDFGYScaQcvwkyehfPUs1JEPaGvKMsezteTUcwIgln5DB7rxHDfrGGXmYo/nIPdOaK4A7P9sVdMYqSeSdNUxvPCxa44c3wE2nbOc2aeGAQSCB85jNpgBYexqkveoYKORzS2lw0PCNqCGbQdGt6nO012mkZJhmsHZmYmiUTQhF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Sun, 8 Dec
 2024 09:21:32 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Sun, 8 Dec 2024
 09:21:32 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v8 00/12] Support OF_UPSTREAM for StarFive JH7110
Date: Sun,  8 Dec 2024 17:19:30 +0800
Message-ID: <20241208091942.47298-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1226:EE_
X-MS-Office365-Filtering-Correlation-Id: 36921ce4-1e3f-4c87-2120-08dd1769b453
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: BXzvA0coCKxRUkTCZfYxBsUxuduL+ptTZJrcDIvkmQFyo/fSgSh//8w5Q/pSLvG3jvQ2WpNU478/d+IBstYXhkVp6hTC3w7uvUXwMFPXDUoJBlDCUQxlzCmSa8DkdrpttPiNmDddMxeV8KQSaL4QmAHUzm1OYdGEiIi/WTqnHNuz2HpwzM8sbgI3OIk3khuCx5UHu+9z+StXpOmk0/ZsQrwRl1/5PL5JywJvZW94S2+/X2CBLNH8EmHz123SNbIRaCiCWQJx5TK7srWoyt5XuAiw0DYzZLV4K6Gt6Fy0j02PNqfjZdRGcHkWwx7CxhKy3jrCzImBXJ84Fgb0LvKZly4OuNt6Ks3Z4vrt4OWoEQwkDr8YVYWT3Ej2ewfEvGP8il34fBgvbuAOfbSaERY6m23PCjQ9JHKjmjKRlYHQp5drvbGFDWO4DCQ8Bj9B9HITV+aM472PwdNK9Vscz0o1DkkdLMVvZ2TzifQERxoFVFn/gSyI3OKkl00TKOxQVjEN0ZjSsx9yXmhFJB7/bbk9EMAhjjp1E0OAvtuZPY+Fnp4wOr4C0Xi8ZmsJPvmTbsp28fksalut6IUPw5S4Ilk3inpNqoiYq7BpfcN4D4jPvzVgrwYtTLu/F/2bmMDtgimvuPkV5Mpa/WafNGFaZVAVMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hg/gvIluC5hde/8A8Iij0xUJ9hrKOwc/pkwmuwO/uW64INF7w07Z3I+QQs5Z?=
 =?us-ascii?Q?3Dp3gshuyn+JYz7rQzMq+AhkLyLLAE0nyTjB9+tHuXm++k4AnrZ5Ptkjf1yI?=
 =?us-ascii?Q?beewzNZ4GSoD3ujetoMfeKcvdbdswHWKSC3q89e4a7bBRDiF9YaIxTfJoMld?=
 =?us-ascii?Q?WfQ7sEOa3PoxG/w4XRxEO4TTFycSlSy9iJX2wn10A/I4sgutHwqYVW5+ExQC?=
 =?us-ascii?Q?7B429wpHjjSJ0lyAcZGEmxIifwb+ViPd5jsFhzYPbRuo7I2Ra7imZWXwNv98?=
 =?us-ascii?Q?xeNFuXZN0F7L/ys0p96JQGnBkqm1o4xlTK7Nl8KkvflYbDFvPH0ZNE1Gvpgk?=
 =?us-ascii?Q?E/4zfmNlUp+RZUkETVOA9sGX+U4LMuKJIpb5dptnaGdYRgv9oP/QxeVAIkFP?=
 =?us-ascii?Q?T8NXtLXOV7PBsL9hzWgIefhiU58LGWIoH+mmce3cWzg2ylNgWYLRZP8LBy3i?=
 =?us-ascii?Q?pvXdGeNEeKpcA3EAPUyUhxvYWu7YiVcR8IeDg22JuGJLcDui80HgPIZSpwt+?=
 =?us-ascii?Q?AZxJ25RPHwWF4mAMkl/r4n/kBt4QUw345Y0rMHkEpycd2tcflYZpO3LvlGRF?=
 =?us-ascii?Q?J9kcUdRb2OIsax1Kh61PeCWDJwR0bYhO4Qz6yqbDH0YeAw+dZeBCq5Bw24Z6?=
 =?us-ascii?Q?ZzuF6pmJmTe8OIQwfepfsgx3AXWdfdMscCWVR2y0Y+MVxb2BWOU1/mJ4NI5O?=
 =?us-ascii?Q?a3ROG5VECbjykmyELh3sP690EyeHn+lBT9PIIK5GDyt4ZYN117JsNoTS0+xG?=
 =?us-ascii?Q?V3SMacXjqyExjC6qnQDL5ji3rT26xqFu23c+SkMZxbBdQP8Qdbmw6DsQMrQs?=
 =?us-ascii?Q?RJM4N+/3iUEwJL6oKGQ+rGSUJGm2OXhcUzKmHFGjTKDSoC7KZ1gwPTzLioAT?=
 =?us-ascii?Q?vuptrVw2SYt9NU6slj8/YBjLBQgA9HRV+CivU5IuSR60J1VPqw0pBfT4ouOR?=
 =?us-ascii?Q?e6WkI1fd+zsj9U3a8Fa5qqinYBtEawRsNiEbxULkTsNcl4kHd1DZ58HU0j+z?=
 =?us-ascii?Q?Y9DeFDgHSmG+rs3lgAMNuymb+LxV2vComY5vOxflpFB/zG654SPsfN9zmJcW?=
 =?us-ascii?Q?jXSL1xNJhs65nxggw1T+YPPD7Vr/NHdZ5vyC61wAcRJN7hkqI7RmNn+6JzXE?=
 =?us-ascii?Q?p/bVw9v38QOqmqyC6X1XGgZbayuuA1iNdQa1WY1HxDWskSvjL9XP7fP7xUUR?=
 =?us-ascii?Q?vM57ZwVPtrLdeuwDE06Ax5soUMPVMn/HQzCIJ5tBSyHbTfbG3g4wYH0F1KB8?=
 =?us-ascii?Q?GtjK1jqMRNYfikrX5wcdPukOMJUHMXyuqOMuI0dB+P+cxHPWyWs05iS44EJR?=
 =?us-ascii?Q?GMlCQGwZKC9ehK6P8oL7iqZZlPgGJbseKvCuwT8QxyhCrLGuE02iyfntnb5k?=
 =?us-ascii?Q?Kn8/4FnXHEJko0JEAePX7cz6bRChx/0wLLslM57sZgwwTX+XpwfpirZXbEzK?=
 =?us-ascii?Q?T8WAKwtz9BL2+Z8nII75PwAkZd3nBvSoxo9rU0cXdlBiUymkmjkAm58LCR1g?=
 =?us-ascii?Q?A+OD0mmE0fXK4kvfDBkI/s881QVWFdpp5gP9QR6mE10b4M6A+rmdCh28nwcX?=
 =?us-ascii?Q?4bw4S+7i3b8OlGcfgsVccONU+89KFYuo5YVgG8GH5YgYdPHjoOxUs3OOoByl?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36921ce4-1e3f-4c87-2120-08dd1769b453
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:21:32.1925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBoYyAA2WXW32KKFNnFZrvAtjvOrJh3JArV5mpA/8VTSkgi/jBRV087j1V+hkwfDbT6SG/8VgwHrxe6ABZHV6sGXjpl62pfWppwzSuawfVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1226
X-Mailman-Approved-At: Sun, 08 Dec 2024 14:25:45 +0100
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

2. Property values of node phy0/1, gmac0/1, stmmac_axi_setup for all
JH7110 based boards now follow the upstream dts.

3. Set "cdns,read-delay = <2>" for qspi flash@0 and this setting will be
synced to Linux later.

Changes since v7:
- In patch 2, drop "spi-max-frequency" property of qspi, set
  "cdns,read-delay = <2>" for flash@0.
  Drop &stmmac_axi_setup &gmac0 &gmac1 property overrides.
  Drop the redundant &S7_0 { status = "okay"; }.

Changes since v6:
- Drop the "snps,dw-mshc" override of compatible in patch 2, then add
  "starfive,jh7110-mmc" compatible in mmc driver to match upstream DT.
- Delete newline at end of Mars DT file in patch 5.
- Sort OF_LIST in patch 7.
- Sort items of images and configurations in patch 8.

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
v7: https://lore.kernel.org/all/20241203030430.26089-1-hal.feng@starfivetech.com/
v6: https://lore.kernel.org/all/20241125003205.75327-1-hal.feng@starfivetech.com/
v5: https://lore.kernel.org/all/20241119020425.51989-1-hal.feng@starfivetech.com/
v4: https://lore.kernel.org/all/20241111020808.38974-1-hal.feng@starfivetech.com/
v3: https://lore.kernel.org/all/20241105034328.56439-1-hal.feng@starfivetech.com/
v2: https://lore.kernel.org/all/20241028015847.42344-1-hal.feng@starfivetech.com/
v1: https://lore.kernel.org/all/20240930155919.111738-1-hal.feng@starfivetech.com/

Hal Feng (12):
  dts: starfive: Switch to using upstream DT
  riscv: dts: jh7110: Make u-boot device trees adapting to upstream DT
  mmc: dw_mmc: Add "starfive,jh7110-mmc" compatible to match upstream DT
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
 arch/riscv/dts/jh7110-common-u-boot.dtsi      | 195 +++++
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |   6 +
 .../dts/jh7110-pine64-star64-u-boot.dtsi      |   6 +
 .../jh7110-starfive-visionfive-2-u-boot.dtsi  | 117 ---
 ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |   6 +
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |   6 +
 .../dts/jh7110-starfive-visionfive-2.dts      |  11 -
 .../dts/jh7110-starfive-visionfive-2.dtsi     | 380 ---------
 arch/riscv/dts/jh7110-u-boot.dtsi             |  27 +-
 arch/riscv/dts/jh7110.dtsi                    | 761 ------------------
 board/starfive/visionfive2/spl.c              | 391 +--------
 configs/starfive_visionfive2_defconfig        |   4 +-
 drivers/clk/starfive/clk-jh7110-pll.c         |   6 +-
 drivers/clk/starfive/clk-jh7110.c             |  44 +-
 drivers/mmc/snps_dw_mmc.c                     |   1 +
 drivers/pci/pcie_starfive_jh7110.c            |  59 +-
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -----
 20 files changed, 342 insertions(+), 2139 deletions(-)
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


base-commit: 45f05f681224d88d1b170063001b59edc8fc24cf
-- 
2.43.2

