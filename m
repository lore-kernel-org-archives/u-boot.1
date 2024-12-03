Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3C0E6C5F5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64E4D8950E;
	Tue,  3 Dec 2024 04:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89751895F2; Tue,  3 Dec 2024 04:06:03 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20707.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 199A088E32
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIXmRHduaqFRrskey7TZ9L5eD1qgO9KrIXhN1B6pnuoXKwXRFJ7a+PgPtmVbWfZhdx0YAP5yv7yqnP2c1D899r3Vn/9L9KLDK++aplwUS7xhdodPNuaVeX3QqktE3P7QtZacgvm0P7Cvptjhc2rT3hSXI71ZvW9w1fu8DNPtkVBpzy5JM37byOS76AT0pu9DhhwT0ZjEARkSY67zVd2davV5uyJjj9+/12uFeIr6zpDslUzSGeXkK865toqiyTUnTfubkCvxFMm6wQmM3hJp+XnWJfHaJI/+9QrsBeNlzMHPLtjz+Qq+4DyPJ33UcnyQWz9xvS/UHlNSIP+U9uvUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iYGA9BKSWkvHxwfZalpWNesY2z1aKRVdTNyjpKLvXA=;
 b=C3FE7aAT+AeWV20nF2zE6BS4hnPshaF1qIkFiPrR6OoicytsraSVgngFGEcFUz2tdpDux69aqgZuepPmXLMahJZ6Jyj899+fARqUo0Cx9J5lr7ZNE6U4NVrf2xoQZg1MDcGhyNPAqV1khNq2Md1c4XZ74mebtbPnL/AlQ4nppbqartz52i92+ivVDNpskGELkqWQSvDgQfkACxWxNK3hTbotA0Q0XY/j47Y9v+/GvPHdtMvLrS96QTUzH1DQKt2v6AWSLSfcRY+lasbuoDHCiqLj6scNA1oUe5PVB7V94LaelQrddriF2AVE0uHGn71ofX2gjBZ3+089DJJD7nzI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1259.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Tue, 3 Dec
 2024 03:06:18 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 03:06:18 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v7 00/12] Support OF_UPSTREAM for StarFive JH7110
Date: Tue,  3 Dec 2024 11:04:18 +0800
Message-ID: <20241203030430.26089-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::8) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1259:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c164318-208f-4d0f-d705-08dd13477528
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|366016|41320700013|921020|38350700014;
X-Microsoft-Antispam-Message-Info: WpoWXog2idd1G84NAbvwtKaC5zsFkvt4PSlCzA9TSM07ZW4pO8n9fNdomjpEQ9AUzPLwEQEu6OAUUwGmEYFVtgiZTa03wm5zuXZM3t1ARtpmdAAmMUQft7bGZOuvfruM9/9/g7GZCYjpDwpQY41M2/T2OVjFrRRts4oBOKr7hNtO1xbs/eLzB2KoL5rpHomCbwMFqkkvjCYajt8ole93DWga4sQ5JueFQn2rZtSzwhCETR2TAesjUBYSAPV6QC25HAF8WGiAFHvGl/XJQKbVoqA0800cCdDAiLnlsIqGtdtDeOBX6nxvsNIgI+prq0umUBRmlQbwPESjJpgszRcEgCP31D+7YEQjyIl4kaNzec5kmbRonyz4ifXQHyyAdQ6rCMsOB0jSxvbSiE9ngh6m4Ek3zWMkET8J7WcvDsWMliM9ymV6zV4Dp912H9UjHpVLG/gjgZ5SkbWn9nDXb5BXCZsOGRFsWdupkLqlCfqT5vMji/P19SGfQ+icG4SzB29ZWTOX0VvtD3o54aP2Zam6p+YftAsjHb34HZNb0pYGu152ODpGnc/3lZunIPZbye2PbrTG2szSnUj7T5PUWRhQ84OZmjZ9ahDLMXA95v/m3v9PeB8vl7efEiEil0MaeWV2HnEGB7UeYyLA/53TIiemyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(41320700013)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R/4s2RU7qv4rgHA/RjA5C/WPgHaZtZQeii7byXnWdf10UOSTR804W+FGoXY/?=
 =?us-ascii?Q?tUyokohEvHK9NQZfZus6AmassgAZB8IaOns5BIGTsFoLCNJHxmFSUzv7wofG?=
 =?us-ascii?Q?BYMbQbbbU/btWhDGtwNI3djA//NtvGbOzjX0Uh4bPN2v/kU9ESJXXL9PGxfp?=
 =?us-ascii?Q?Fus3ur+e26eJAD4gIZ08gI7NXea8cd6pI/UaalFSA3rAMNK70JrVy6vIKB4P?=
 =?us-ascii?Q?2Qvd7XOje+moEPpQ/+UsZt/t2/r6cfj71FVNFCtgOef+PDZLuMhucmrtWQwi?=
 =?us-ascii?Q?3kEDoACzetN/7HdwwYXt7NfyHSUtDFq/EOO4hiOkbSfBSiWaxp5Ebb10ttmM?=
 =?us-ascii?Q?JM4TqBaGMnC1/e5FtiBXGIMaVFJCA7I7ij/ur33bgLcBN240JYVltR/JwI1k?=
 =?us-ascii?Q?5YcnE6MEjNdijBcJ99bpaFK5GZBAEXFe/D7YSwUOzOIcNIHu7UZ/kMaLJ+5r?=
 =?us-ascii?Q?GnhLN9g9wHD+kfckXaBjthVqqR7scdL1HJo6varY9CeDFJgONus2UX23pmIW?=
 =?us-ascii?Q?C4zdlcCO41fVt0mtm+0t236CUGj+sTFTROcVHRR4VN6uVeg77EogsVE4R6+M?=
 =?us-ascii?Q?nl+KE+KSF/H6wtS0JY+GSXNk1QB6SEg4QD2uRFq5Bq2UDPkqZ0zTZTOSzO9S?=
 =?us-ascii?Q?zLvp7Q0C5WDQjS0DfACkSmexZWKKa/d/dPoFpHlCq0czeps/LnnRHSq6QfP2?=
 =?us-ascii?Q?39hGjDRke5z78HxJAh72qiJZOGuQntqwo0JRAHLX919ikV9360X68PyJZ0/5?=
 =?us-ascii?Q?hsoO33WJ8maFJkqquubwVyyOODW5Q9HVqFgpZRbjEO8ppNmIr1rIZ4KQ+7vo?=
 =?us-ascii?Q?3WyyfALklBosbBmjZq9yFtcYOA1mdrIyrY9sgPCvmeGxWwVd7lkB+uUTyYzr?=
 =?us-ascii?Q?Qx40lEA60EnQR6mkIElBQL5VG5J3frKjb/WKxGHTxh6QnsjwpKF04cQZJ8x9?=
 =?us-ascii?Q?8TEX96y69kG22+xLU4etn2wLbXys70Yt+FLuXwDg5Z80Z3/ILLltFWHV+wPA?=
 =?us-ascii?Q?3cxzWAYZLsS8VmihHILVL0eaKhx8iXBS2wb2O4kygowNRYpc37pU4yA63aZd?=
 =?us-ascii?Q?OO7nJzdXVDVzFm4vy2tu6+xJZocHpTxDZOZmUBUM3NsFMuU4wf0seoyRoDgN?=
 =?us-ascii?Q?S06K3AKaZzF8UiPwXDhBJxDSLz7d0Td1KhU2CjQZ7bjH7uNYEI+e+ChhQs07?=
 =?us-ascii?Q?GQle/B+2VoedtUpIya427InEMHaeVbqvayOSYBk4Fbfy/i4TgN52pTQKVN2T?=
 =?us-ascii?Q?q76I7GuqwY++8VMRuCDuoc1BmgP9LEkiq+xYb3XRd5QPqoN4nRH3EjOGEJNO?=
 =?us-ascii?Q?3uoGTE5IjDsE6znTu/ECwAs88hliZ5TRP/w/nZEGs+A5zu7ba22YDcGNXiIp?=
 =?us-ascii?Q?cZYFupKNy/rkChcplrndOJKA2o2SCvYKss2VD6j2V/K0Qsg3PAivGjbJsTlt?=
 =?us-ascii?Q?LrslqO1UqyvRJauKgTlA6vpZDMZmQ0oSeDKCg6qYReIMBIM2+fu+JzGgHJ/Y?=
 =?us-ascii?Q?0I0xE7Y3CUpLrMSY4pDg5X3eLGtBGBvDC+WgsLSGRCxeC9utf8lqjTG6+604?=
 =?us-ascii?Q?1Idooi0cZMC7R/upIrwDsusBAnLiyerluP42doe1PfcU6O6OSyBUZddB/SWA?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c164318-208f-4d0f-d705-08dd13477528
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:06:18.7111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giht81Uar4uSCFbOA0u7DtDKOzq4bULfDplj3+vxl5wdPu9hDnxnbp18c2nfIafU/Wtk/kXHhFkHroFR8dK9KJuPlPy9a7uR0doAiYIh1cQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1259
X-Mailman-Approved-At: Tue, 03 Dec 2024 04:11:50 +0100
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
 arch/riscv/dts/jh7110-common-u-boot.dtsi      | 196 +++++
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |   6 +
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
 drivers/mmc/snps_dw_mmc.c                     |   1 +
 drivers/pci/pcie_starfive_jh7110.c            |  59 +-
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -----
 20 files changed, 356 insertions(+), 2135 deletions(-)
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


base-commit: acab6e78aca767ef71470871842e5c090e3672c7
-- 
2.43.2

