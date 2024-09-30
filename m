Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB0BCE8375
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A9489032;
	Mon, 30 Sep 2024 19:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A37B88F94; Mon, 30 Sep 2024 18:56:27 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070f.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF04788D08
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 18:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYCVM64tiLrhka+ue3TG8xB8/q/KM2oYn8ttS6IgMwnkl2bVVh8qoQiMcYEmfqNnIZzZQFAIju+NJ27Xj0LU+5t0XKtC01xEhwODsuu00kJd3dIi/zxJ0jxunVOIIXk/d2KrQkJGbijwnuSTeiRGpgUjK8bNXgYsvyJOrr/pz5wcOHqbPPPuxk4Z5kEQnpgjaUu29JezWLuPa8DB3R0loYHa2wdZbPx/DbTaiPFK9d6lUKbKHzfClrK9tT0IhE0F5H2oIBh284rlxTlr8chOlLJt6rSbueHjC+Qy/Bs5kCQWMyotfU01WnsF7vDwU6DQqRxrCXcNHD45dCHKYh3B2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuAbTJ4ty9LvTIkXaKjk6ShdDAgXDsrQKYddRLTUbVk=;
 b=a7y/5TAUwf42EhdXu+3mlxuLGkLLkAp3mTJha5MezX8+nYHi8vSRVZRG2npJj88K1tgNJpBTvq4yuprlA+KgOTfXdQoDQlbX1HzrBJ0iECjFf1fGZUSiaRx73h1QmE9y7DC+f8nKTD7K47y1NCUUkFRni28qUnbvVi+bxDYbtOqxVo1HNmY37TPTYLnwbzwY7Tf4MbG+0P13zPdWA7Bd7gs0r5rp3hbZZFtec0KrN9V0ovseCLK5y6FnHpKXWtpLKUJ9Umi36qYGAt+k4po/cLydR3bpOkrY57rX7K4sml+iSR1+60SsSYgfu5P3/zPDTWHFJjk9mKAOxuR4KsKhiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:59:28 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:59:28 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 00/12] Support OF_UPSTREAM for StarFive JH7110
Date: Mon, 30 Sep 2024 23:59:07 +0800
Message-ID: <20240930155919.111738-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1243:EE_
X-MS-Office365-Filtering-Correlation-Id: 932b3751-ea6c-4fe8-fb94-08dce168dcfa
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: 9gTyPQVigm5sePuqnAAMbjNR4yN4WgYNG6St0pn2f+8OOdKJNYGj/n0vQUcl7ilBR5t8DtJqGr4ywadGCbfSSGevimkiFzIFNf4O0IFJoffSdrN82+6xBSNVr9H88AcaDTX+nOhM4Nya9OWNkHSPH9EqltxrnIV6C6zTwh5RyUsC8HbjP+nCAgYWwecdlvFs99+IfLS71ktQpfyeDkKX3e5lDUU4tiDanG5a3Ohd9OjrR8Ml2nu3HZ6AMBGqLl5y+8yEdvAiTAGhAV0E3PkHtyLQ2ewmP2BzLRbR/6xR16h2I9bSLMzGhOj7ubBVWeyQNT0Zqyj8YMAQnwHzVvKKJ8Ffi3zUx95rFOBGnLbJuEAcg0QiazkidRv/DajiIns4fGGMbgcj1qrcykuTrxTBHSm8DBVpJj+oi8kCK38BLaWvAVKPF+g66B8oB9NpgJNgH4HYPgX5g74VSrLduQk2i2rLMbKZlDpAB8TC0YZ/94kTNJjX3vli/SFAhRdt6hJ7dYney6677LNmPMhT8DKlJCS0T4pf9TDexwD6kScBmz/pxhzKyR537eJUxITJMUrmISe125fypSsuKIc/6odhZRH5Z/04ZuKbT5YPHF0dW3AroRVxwMZ4Li3F2Addvvfp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oq72xDvDtFOwpvpRbPKeqXI7AU0YjrAuDhGC1YfQb9Pi4tb393Rn4rIiIxPZ?=
 =?us-ascii?Q?NSkr7pJxK1T871eCy9SSbk5UgTHbtNvCcpsNtCwQpklbncj73YhPTzXpng2T?=
 =?us-ascii?Q?5sHEjMDo6txl0A5iMywCPbCJw4+W4TG17V5bzeDTJU2HzrCSeh3S0ODTjwNi?=
 =?us-ascii?Q?pj91Z+FkiZstPIemNZnQOLIwcAd/Zzhf6l4bdLvByVSWMg2tTx1FYn+Smzbx?=
 =?us-ascii?Q?K50NVgTYLb59ACMsWkkzjOvJyS1zGH8ZAm3ubghBNAvQET0elaj4UZnTFOEV?=
 =?us-ascii?Q?QKc+eLPVJ3sk7+KR36J3qr6KodZsAGkpcABwSXHckgPhItsIPdF5A/lAtFUq?=
 =?us-ascii?Q?G5VDJL0WMjFlekZDLtv9sHUQNGFODeeHz4237yid+8YcOYUPOXsa0+dWR+7k?=
 =?us-ascii?Q?Ov5b9IUgRqYx9DOtlw8sK4G3hvp9q4hxZsc7RK81zmASMxKTRfI2hEIcLUf2?=
 =?us-ascii?Q?p+t6GxJEoRRwkGEpsY5yrDdWNSOKwl8Jvnb62fofgY2pO7bWP0Siad88fH0F?=
 =?us-ascii?Q?YA4pWN7rgbwfsNlNv91bfTRNTr+eFGJrnHJxfEPMQzmbnH7/O+QcYPQpeypv?=
 =?us-ascii?Q?DXPsz03UIgAYeELnWVorsIwjlyRvh8Zt8NHz6oe5MvswdlWLwuhl0qj0ZkUy?=
 =?us-ascii?Q?bCgtwOjFyXpk+KgExVN9tjxspG3FiBrX816Zc9/cVdVmAO6l7Dft3jPRCUlH?=
 =?us-ascii?Q?30kccpH9/u9KXIhbDbYoYwxQvNuS/UKW0hd83OGXY/jPEeE9QPHKJTxHTvPM?=
 =?us-ascii?Q?iIF54/TT5tqGzoo/gQ+cEbvX87VwFRygvsgPi4OyXdtbkdZZz7xMsL79k0bO?=
 =?us-ascii?Q?XRvrSg5mrakewpY3XFBgeb9nLeV4Lf5DsZpgp29+Hw/Uo9oFMSTxYkl1zlwM?=
 =?us-ascii?Q?Rz80rtG8U0wJaiI5D4mPNpWw8UsOU+8FlVy80H0bf5T8SqIxdPeUiYZDv70/?=
 =?us-ascii?Q?5ZZA/n9EFtpDAFtXrNHq3WN+c6tpyID0OCfeKIR1hJH1FAk9fGTRhH65pV/5?=
 =?us-ascii?Q?pBrkruQVNmClSD49EU3maH9Ov7FUeGtun+uLtZ5SN/BQjbIP+tZ1hSuilWur?=
 =?us-ascii?Q?d1Wm0VLOM4WR3Izobh95ock8265+hgX4XuQeHtD2MOFMn2qiIvyCDuj8LhJI?=
 =?us-ascii?Q?AMxJXZk9GkBY/80nviJus4alXEmv0u45wonKhonBgvXCUtwKOzBlcnuRgqW7?=
 =?us-ascii?Q?6txXQobuYXNTTGwVSmnu2xWrHjyM3yIw4ro1siZ+GbR+87BGxDeyTHZNZGF+?=
 =?us-ascii?Q?FrR4qFbyoMYPiTCTaK9w/8qSCSnubM+MowyvcycuhKxSHxiDbsGIP8tL+LX8?=
 =?us-ascii?Q?Qzj0nLk9LP3l5PpwvzFX90fFMQhIHIL356WGso3KsUGGcsQn5NXHF+M7STHI?=
 =?us-ascii?Q?4lCejUrB+ZuvT+MgclnbeVO3a0+0M+E2LxhBS6DydRX1HUO6WRy5FI1PCStO?=
 =?us-ascii?Q?tdBzhAtAeK4iVPFfmF5MoFaBCkXrAUg6YT4aQfCE8ScCO5JQdsxrP2WIQcY6?=
 =?us-ascii?Q?ileFlNbEnD9M2pJDdOlQnXbVqjn4MEyFwV3ZzZnrP5Rhg3UMimW53ZSSeAc3?=
 =?us-ascii?Q?kVXgLxKxZx+dxMhcOEcXRcRqlKFCry4UZs/xjNO5D9JPbryvJNhkLwTn4Igy?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932b3751-ea6c-4fe8-fb94-08dce168dcfa
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:59:28.1964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7rHQvs1vykXE4HVk/l4yVfqBQcAudNTb3TrEqLN+c5sTSp8v7gPz4KxGsD/urU9sx61Qa0McjShNPtLCiMHimDDmJ4I/RnvQNGfC2i4jdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1243
X-Mailman-Approved-At: Mon, 30 Sep 2024 19:03:44 +0200
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
The v1.3b board device tree is set as the default device tree.

This patchset should be applied after the DT from dts/upstream/ updating
to the latest version.

Hal Feng (12):
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
  configs: visionfive2: Add OF_LIST for JH7110 based board DT
  doc: board: starfive: Update the building guide

 arch/riscv/cpu/jh7110/Kconfig                 |   1 +
 arch/riscv/dts/Makefile                       |   1 -
 ...-u-boot.dtsi => jh7110-common-u-boot.dtsi} |  41 +-
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |  11 +
 .../dts/jh7110-pine64-star64-u-boot.dtsi      |   6 +
 ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |   6 +
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |  14 +
 .../dts/jh7110-starfive-visionfive-2.dts      |  11 -
 .../dts/jh7110-starfive-visionfive-2.dtsi     | 380 ---------
 arch/riscv/dts/jh7110-u-boot.dtsi             |  36 +-
 arch/riscv/dts/jh7110.dtsi                    | 761 ------------------
 board/starfive/visionfive2/spl.c              | 358 --------
 configs/starfive_visionfive2_defconfig        |   3 +-
 doc/board/starfive/milk-v_mars.rst            |   2 +-
 doc/board/starfive/milk-v_mars_cm.rst         |   2 +-
 doc/board/starfive/pine64_star64.rst          |   2 +-
 doc/board/starfive/visionfive2.rst            |  11 +-
 drivers/clk/starfive/clk-jh7110-pll.c         |   6 +-
 drivers/clk/starfive/clk-jh7110.c             |  44 +-
 drivers/pci/pcie_starfive_jh7110.c            |  59 +-
 dts/upstream/src/riscv/Makefile               |  14 +
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -----
 23 files changed, 194 insertions(+), 2016 deletions(-)
 rename arch/riscv/dts/{jh7110-starfive-visionfive-2-u-boot.dtsi => jh7110-common-u-boot.dtsi} (56%)
 create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dts
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
 delete mode 100644 arch/riscv/dts/jh7110.dtsi
 create mode 100644 dts/upstream/src/riscv/Makefile
 delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
 delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h


base-commit: 56b47b8b6a09c777e74fe6c52512c832691169aa
-- 
2.43.2

