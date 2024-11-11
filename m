Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BA8D12D60
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 755B9892ED;
	Mon, 11 Nov 2024 03:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 618738911A; Mon, 11 Nov 2024 03:09:41 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20719.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A7F8911A
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpU1YBywIpxDV0EcgJkb9bWUdckZE/Br+gGAPzr6CLv+dNNC8ai4SjEEleKrETvL4ox8Pbe7QxIcPF6yIGlI+UUmtvkpvvKIrnonzRCuPYcgJsF9WjrZktj4/z8/u9wouWHXrkPzoqMAzbpu2SLauEFJ1U12ayvfI1xsA697JKa3/st6yNgPeuizfnc8n3orUZpGHXMX8KB7VoDLp2nxYDumEcoI3LWq7foXarG/LOtBZs2HU/4x/sZlgTsytGyVfqvY7GaXKm7teR5nvCNAnAOR2D94E57L0l0Jziv7NMVVl5vQ041sBHtGTqUO42FS6Qx/QeoaotYHzlO2tD3MtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qd1jufExebJ0eieEYaVh40SBD74QztgMN19RVTziYRI=;
 b=ke3tzacOuCjCmow/YsKC4IU4V27/Z8/6Y9n6RNpiGnjPz4YkwDNe2mrjhUjpn0Y0UPTemIj/Gky8S3VwDxtsNLTm2sAHFzvMAvXKchKpRisa+pryEjz9AUF8EBV9tkjlC0Rx4x2Xdlbdka/CAr0Qz81HzJ/vqc6j1X4IsrTG7jlcLtlWraLR6DzJ0YX/MHSPyzAmax6WSCloIv4Rd6+N9ttDbVA7KEHi8or7COlWUDhCeE7or1utfNOaGlIm5Rr+dX0OEUc4/NcZ2c3WX6G3le88o6KW6zkVLYlv5M2+wGWIbMAUqMU7pRRGOIZaQD3u7RLlczdWDYfHpOnw7qAo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 02:09:40 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.035; Mon, 11 Nov 2024
 02:09:40 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v4 00/13] Support OF_UPSTREAM for StarFive JH7110
Date: Mon, 11 Nov 2024 10:07:55 +0800
Message-ID: <20241111020808.38974-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_
X-MS-Office365-Filtering-Correlation-Id: e79441a3-6185-4223-4df6-08dd01f5e691
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: 1ksAMvBHS4PQld91tT4/TQPnhdn8j+uk2fkNbsPqbJjzF+0ptwFsqhRW59/A9zkOiB8l45dNlqqQfvk0eiS1C83ozWw++xuStP2adKd7UyUJq8XconjBsPF6I4txAWegSRi5psTQ/yZ2XO7OpuObdmyQ9Oe6iHc/7qZxtfiNSexJsYS4schVUM6Kx3sCzg32D7GNcXSCOkBPAQxI+FpM26qfAWYsMob6dQVNKEI63EfG4zh9oIti1ihmjqppgULpzmZp08COBVt82ngToGZj0OTKoeI6aPUp8ItpQKZ+1WuZIZaW+CveLldHPorQPQdSdzZyqdGcTv8tmLWUv1pwd8sMucaGpiR2WdTA7eyrAFqahvC0Mz8imtFoTz2ulIc68GsSEnl4wsTngnrCC95wYArBshJdypWgZ1cxgN+XWZsaZ+XX0xQogrudKeLT5V7DxznYxTRbA/xwIPy0AZ1Kps99Sj4UBSliCUJD9vySOmWEwNfmWetKdPfPXvQ0VR1FYHK4y+IbwLG9Rd5/w03Yn4s4reVxJ1/mdDU2Mh0rbf71cSHe5SmHTkWiOnosDwZSJ63Hq+7cLYNqGqiwORlwvv1GRuKmLS6yrq2oVMJMpDkBEPAfenz55D7+jPclnlvfsrdGUoloAUrCEvSN1hslDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x7cygeBkOdbA0H6OJhFt8Tb2nhKfSYPWkKAPIaUATrFsVoz+bhm4XCHfHrWn?=
 =?us-ascii?Q?ql7IxnNjMzNgItGn27AZ/PpdisFRfFxLPksk9PR/qsrW3YZUV9eGJlYIwxwm?=
 =?us-ascii?Q?fMOSqs4EC8EljUf+NULa8BnHzhRAu0Q2Pkmzk6jicZCPvM3Vqty6LBpS1k/r?=
 =?us-ascii?Q?61Hy2DD3Tj0BrqctNIK2PpB6wSY1D6CKu1/gqlnybBEoRy9WMQxKJtj2Qvgv?=
 =?us-ascii?Q?i14ByE64tgzbFG5am0ajuCoBu8cx+Si5XK58gA9M4d3hNE/S/q/4UVXyAYPN?=
 =?us-ascii?Q?LcKdtDbSFy7nk+g40SL+o7n8GKtzXMn7YmS53vAvqxh+JBCiqa+ogP9jUb34?=
 =?us-ascii?Q?PL6e9Ljw2hiY/GckqKXDBqnxKKajU42hPATa8AS11PE5SWdRJ0qDemYfbvB1?=
 =?us-ascii?Q?ZQRmFaKes3LraKtzZBUiaPdBTuiOTme5RydXQBnJvURtKKJaIZsX18lZwqJ8?=
 =?us-ascii?Q?60YrYn3U6+WSl21OLg4sfDwVrXFN6HSiBsd2KJSTxLnc0QukbGMV8gcmuW2K?=
 =?us-ascii?Q?71S+8+05/bSq+nRWGhXv6+z6AT4pCnBbHQzzQqWetzxdLNTsz+6xFU8jePP3?=
 =?us-ascii?Q?7WUblS7TcVRhKz95iaKeTUpcHKINjpqBaRw8P0Hj3J+TPj8exrn7KjToWSd9?=
 =?us-ascii?Q?vJ3ixIsTE3MQqcN7HjmRxYSVugNaD/h/mgwqnb68nJodxlNKxTJUsB+uqSVm?=
 =?us-ascii?Q?95UVG/jmKPv+jIrEpJXt3S1+sHhqosPfvV0Me2A4FQsA3no9Yv3i2XVyG8Ay?=
 =?us-ascii?Q?6CwzbaleuHDe/hIviDrFLc/80iWJl255Vk4g0DQnEK3L6zHsaGQMQw1lPSd1?=
 =?us-ascii?Q?2taRrGDkyJep/+kNF2UKDSG7NuRQ+AXd6IyjejEiLTDDcNW6Wo/LBaxnOLif?=
 =?us-ascii?Q?GDY0FA6bEPJnsidZGFXjUUYe9/TIHgszctFMxQGnn/zYx5XbtGTkdMIXZUhA?=
 =?us-ascii?Q?qezCB2c2qVEbj9n/zxsHPiFnYGcAHKJ07s1n9AEA3xLFRhGcLFj4Dtu+ULtB?=
 =?us-ascii?Q?+hayuaGcmXtqvbl3g+d687ir+GHvHhL58Kjjw6RM4ThegoFa1fp2jzdTfihf?=
 =?us-ascii?Q?U+MIMVHaNujs1CAFQ+U/oopv+Onwk7QSv2ev42SPS86gMiyzt9T2mpXoF/qK?=
 =?us-ascii?Q?Totgfal6A9y/T9FSWpyDimFcHYrJ4wuwQac4Xfqq/5YonTSHhHhIsmYoPA+H?=
 =?us-ascii?Q?yubJxclwyDN3juh37kaA3Vt7sfsOQT/oS/GHUN2ppMAxvfQNQC0wzbg4Sza5?=
 =?us-ascii?Q?Y7zMQ+xhfahpVnvHRXQkcdzzOmz6VmcDx0Xmo7CW0J43qLqnV56+iMrsnUqg?=
 =?us-ascii?Q?Yn7RQUlJGVI72enmAvasAVdYaXHk7GcIgNfkI2DotuqMah6wN9ROvM8FKO/d?=
 =?us-ascii?Q?xQfPPJnef2KRde2XJ6tmDhWE1TXe7EAILnfQ5JN13NmY2Jcc9GatzUD6nPQa?=
 =?us-ascii?Q?oeoKk6hUCRjPPipfiHyLa3AMxub66fYsr0Lk/CoKlrvLT1qQl225rAx4V55V?=
 =?us-ascii?Q?l59N/EYcCedGptfoGA5K5xkdSz3dw0xjrc1yXmh2NTeF9Lpl9jBa32b/25Hs?=
 =?us-ascii?Q?BFPRt45uZF1X54LWzPHWAXXFoka/hUfiV3Pvycs792fmH/159+ko6+Er785U?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79441a3-6185-4223-4df6-08dd01f5e691
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:09:40.5556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWNC4a0UmQ2alxWgP7NEWC6d2gdnWxBG/xxedfWFmehbkIaHYcOf42u7Fnzmu/AzHQ5wuUuoG6nLf+qMNL35vgAvthY0s6EqWPnBagSCNQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1307
X-Mailman-Approved-At: Mon, 11 Nov 2024 03:23:18 +0100
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
v3: https://lore.kernel.org/all/20241105034328.56439-1-hal.feng@starfivetech.com/
v2: https://lore.kernel.org/all/20241028015847.42344-1-hal.feng@starfivetech.com/
v1: https://lore.kernel.org/all/20240930155919.111738-1-hal.feng@starfivetech.com/

Hal Feng (13):
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
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |  10 +
 .../dts/jh7110-pine64-star64-u-boot.dtsi      |   6 +
 .../jh7110-starfive-visionfive-2-u-boot.dtsi  | 117 ---
 ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |   6 +
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |  14 +
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
 19 files changed, 366 insertions(+), 2126 deletions(-)
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


base-commit: 9c25cd563179cf32cf3b119d5ae78ef8348d0335
-- 
2.43.2

