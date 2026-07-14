Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED64C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 02:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E3AE84CC1;
	Tue, 14 Jul 2026 04:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NnJFVQ3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06E6684CC4; Tue, 14 Jul 2026 04:33:08 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1666084B51
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 04:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSaHJkLiU/By6iIep4K5Fr97nn7LsBzF+GD6JIC/inpZzHsvx9zRkPQ448BJY1yXflfBTZCMrFrkdxuOAt4UZwtyoWOpgY1Pg3Ao5jL6DT0iVtHDmG0/38Kd0x8XeptpKuVOh6GW20C2riTtLvGvd9C4xT4eVVERaS4EZ63bKN6wuWpTVnodqCSNcYHCVzFtBKpY1ec85C5R2OTS3dyh/+G/ILf/wG8re1PNgtIRPWsybKo8otWUDa7tJGjWeVArLr02/St5ipwDE2dGvXCNAfnDR9G00RXEkcLaCpqt5XiJts+sPGRnVtSKvXfgq4O/WnuupuOKQw80DAqdfCQo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpU94CkdQaSy1Uwa2qJgk89VrvRwtuX4kHA7aW3kL3Q=;
 b=hlrHQfc8fcr/JLCru10HUSdtq288SuTYFTnK/uIXHQTPoWPaoMLH9fKr9f7UEu6Wg/2kAsjjBKbnygtYWXsmJGeJF0kroUxg6O1fG76CDSXziVAvHKFGruIniYX3/6MWxiY5qvyaz2F2Ajm0WpEsNL7Ds2zwZHGZaiStd+Luu+Qu/7JTOxTEnMkz3tjUEQSeeYjekCZ8Yid/5Qnzpq4fvXeTwhPq4f/Iu0dRIt6TTmbubjtB1+wPdpCIlnHQwGt+zaY6KkRA2/OVIYEgaE622rVVcWRImHT93WEu1YAhmstn/Zbp6gyUvooX0NEPCt6i3u0pkeISFjO4Iuj9xt3yiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpU94CkdQaSy1Uwa2qJgk89VrvRwtuX4kHA7aW3kL3Q=;
 b=NnJFVQ3Le3EdFbZVhx7Uv64fmi+CITK/94I7OmAotuyElOhu5HXwDwOsedfweKLmHMCql6qfX+3SeKFxmr2y+GtQxL4uB9yUFbShRa2EOlDel3PvgEFF0bpuF9F2S9EKcOYm3H3lgHr3C/w483AdejAjIIQ1CwGFiHi/ACXu9JBDvgwaXCSm6d7+Ekgj/7rIR2HUv88+diuJFvVC1MBou/d1nKUpyp2dtInfPNaoxYh5359aHx1CfxbQoHzmVH32IlARuk0xDuHjXF6BiwG64q5/oVA+zvlk+989ozje2KwLFtvBVV4NZl2iW2yFw/z4O228l+UcdwDyy+T+fE7CfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI0PR04MB10688.eurprd04.prod.outlook.com (2603:10a6:800:25c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 02:33:03 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 02:33:03 +0000
Date: Tue, 14 Jul 2026 10:31:31 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Vincent Jardin <vjardin@free.fr>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [GIT PULL] Please pull mmc-for-2026.10-rc1
Message-ID: <alWfg8sSsnypWW5Z@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI0PR04MB10688:EE_
X-MS-Office365-Filtering-Correlation-Id: 1670d4dc-f01f-41f3-6963-08dee1503aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|23010399003|376014|18002099003|56012099006|11063799006|41080700001;
X-Microsoft-Antispam-Message-Info: BIt+TLS+DREEfgBawq5fvcuO1pxnQ022m5FvFaftuXaA9KTtNYiOl06PCjI/wb6Rlr9eYs7PTLGNrSVp50zZsP93e+fFYn0HIEsZWcK/G3KSv25HI04oujx4OsSG/Os/6hqj6dGVRULT8xEUWIpqkCUT/M9Mn29g05YjHtEGzlAANSwKzP2fFVsZUG1aiNMJu8GqCwlkKl9cKHwzJjZXP6bcR9v3i+lzxtaX+DqM+7zuVwgk7xTozi8knc7dKfe+AF2/KcKmgPTqm04GThFl63EajDZgVNk5lV0ibJSvrnq4pFe7c20paNGw3Zh7wybkineS/kPB0SyGlrL6LvHM9BCshLhx9leFjRFg5NdUi/hTHgS97K893kDc+P0Rhz0AFzAG4nosNNjQVa0SNshw/Yvrgn8/Fhgj+w3HVUk4WzQW68rSCJySkJgnRuhd6N5SnlVGUvPol/WXQwdKAR+teoFUp6Lf1uXaWLNS4cOyPJraVs0Q0wjb4rypOGVcqIjysHL0n3G9WVSqMrs2TtQwnZRwGAviRzjfxEY24CLUXbYGtTSRkkIyDqIbghARIb+HLTsQlVOFXjydrCCc9ZxGhkAO4JtdF4CpqgmBDx0djdyLZ5akCpLNX6ASp40pyzVVcFfGrg8bmVtlivDZOo5TlgVkxHhZ5FEN5RVls/ehFcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(376014)(18002099003)(56012099006)(11063799006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vh3GZVoUcmWsst7HsSUP68m94I7Nw14OFYziH89WwtJ9mxZW0dEFYEyX7HoY?=
 =?us-ascii?Q?NmRcNOZxcZj3i13ts25GPRiSrWFI+VwZ2gRw96+lE+at+FdcTy3B3RDZXCB8?=
 =?us-ascii?Q?JxdCZYhwxmwrtIfsq+pBj/Ho1caHd6MjEtgd1k2qGw1R4WDsXBRq1W8qAmn2?=
 =?us-ascii?Q?Uzido6xBADUTQlARJSIrL+q5oblP8sN1+n041KKzhkB1+YAmfapuvkkCEykl?=
 =?us-ascii?Q?L/BuGAM0Zc+FoQP5rnU9XNnUcYQMKjicK362w/sEkNlNLJg0WfP50HK3+rJL?=
 =?us-ascii?Q?Q+XmzdtzUWy1KI+fjXw56kGstJ2I4gYWwVHO5Bw2UMdyzvP926Gi5BrCIMTd?=
 =?us-ascii?Q?rvi5CRBWw6bLQWT6oWryybYfbt9JdLfBwmotUXsDyq4+iRz9uWIJq+NiAms5?=
 =?us-ascii?Q?uQNLXeUnDWtCMzxZ1KJwmSJLkwRiTNIMBc3T3rQ20NQg0uV7z27uqS++bd7Z?=
 =?us-ascii?Q?DkkiVXFQ57lPMupWYreJgT7mI2peeTuSuC9DNu8WlXthCIrGrs6d9Qa192F2?=
 =?us-ascii?Q?zvfwovf73XEmY3tT67fHkOR3TCtM2RdcXNBw0VdZZ/EhXrm/ymaqlcC0R0OO?=
 =?us-ascii?Q?/d1qCGP+A0+fjLyXMM63/Nq7XNZzDekZhb9b2OlNfDTzFIA+CQtUPNyS/KPw?=
 =?us-ascii?Q?vWR/7MDPkyv7XF4iEOUgsXRKCEZ68zp8yLwdzQk3HddC90VjAGbt5aiebuwS?=
 =?us-ascii?Q?xnssBbrG5gBsVpnbzjfSvmzhmrLYNHj2BGgU+J0S8ZfTX/66EFeAX30VWvKj?=
 =?us-ascii?Q?3f7rpAxf7Lk4810TWsLwNdfrqdzXviHMrv4OM8U9yreov3BO+xITJqltgtx+?=
 =?us-ascii?Q?ICHGobXPPMcwdHKYa7fmnbwzjB8TzPNKokPDM3s9kh+Y0cxTD7BRoBLXwBMg?=
 =?us-ascii?Q?eYaRRJNImtsEgGooMvofissjKSBnM2Wa2v+g+K4z+G+MfvYQM8rV5xVJYpOK?=
 =?us-ascii?Q?TlGbtMJSPHn0tzbvbY+L5nr86MIgCOf4HP3IyyWkb5CUuEV5wSvonakLOAew?=
 =?us-ascii?Q?hTWK7eCCWX1AaZgahLOzIlVcCLSBfmVw0cF2IFK9BY8hjTPzszUo/gLSHj1s?=
 =?us-ascii?Q?De87dd+RVmLfOoEFXMd642sDnAP93KU/T6mMCIToeiElmf8/32m5zYP06LnD?=
 =?us-ascii?Q?WPmdmHTRYyFY+x1neBnsUV5svv2sR/UIz5SGx8HGGMg9oendOs17Ga4XL7K6?=
 =?us-ascii?Q?1GfOlo5Izh/mYAgtqVY1tuz9OHQxZ4fb4YIlYzOW+e8ojf78uwK7IqJBEukn?=
 =?us-ascii?Q?4tIR+ve7lNSxhZ4t7lgWY96sjKnKsm/ySnRVqjAWkgdpKBTbeVK7w1fmXZvu?=
 =?us-ascii?Q?01mPPOkw7bq0cjr2yCYv1kBTP+xRlyBzSXsIZhYJuTryV6ZJGyQaS4u8kBY7?=
 =?us-ascii?Q?5Top8q45G/E5xzOZvOYwBpDyeZwIfB1kK7xAkxtvnw/LDJXYKeV/sqrED3gy?=
 =?us-ascii?Q?WiTB2rJrEgxqV9QPvNW+Yo//LsUxLHL3uOMV+IuGZLis7oQSkgYvJr30qdFk?=
 =?us-ascii?Q?EBJvmSU3nACHXKRvi0oCYgJADNQ4rHKfReNJuecTmSccCnOFBT5XE3lzdNFP?=
 =?us-ascii?Q?pFndPZWr9IVj7WWqSZtD+kKByzVNCz70KLxvkTy4dEPGEzvdhrB3CaRS3BW9?=
 =?us-ascii?Q?HaKJX5F/ovjDC/0bwxB2yojc8cPBM4jUI+2pZmM8fv0H5yKnc/MB+c/RBnN1?=
 =?us-ascii?Q?bVfpqsrztq3vbocAnNG/shpHJ+mFr7+Qgm4B+QeSmhryamEszuG2yZaef/fz?=
 =?us-ascii?Q?hEuUVJstxJ5pJCL2yr3hubCYs9oaNLpsrZbl2EZNBXYr4JdeyE28?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1670d4dc-f01f-41f3-6963-08dee1503aab
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:33:03.2984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjuUJIGHP3H8zQvt7w0yPhdP7ixXcXMlNCtUHLUZQljPbAlU/wsdHFjCy6pUAbOgwzuenAi/g6W2mMsx4kxr/13fnifJyyd83fS1EBzXZa8DDRFVYLmY5s5LBmMt8T6p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10688
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

Hi Tom,

Please pull mmc-for-2026.10-rc1

----------------------------------------------------------------
Add PMBUS regulator, thermal and test
Add regulator helper to set voltage within an acceptable range
Update dw_mmc to use in-spec voltage range for vqmmc
Fix regulator_enable/disable() macros
Clear LPUART OR STAT in tstc to avoid hang
Add MAINTAINERS entry for SDHCI
----------------------------------------------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc/-/pipelines/614

Thanks,
Peng

The following changes since commit 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c:

  Merge patch series "fs: btrfs: add support for readdir" (2026-07-10 15:55:23 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc.git tags/mmc-for-2026.10-rc1

for you to fetch changes up to 722a82278752f4b9e6cf052a67e722508503f2c7:

  test: dm: pmbus: test pmbus command and framework (2026-07-13 11:24:45 +0800)

----------------------------------------------------------------
Jonas Karlman (5):
      power: regulator: Add helper to set voltage within an acceptable range
      test: dm: regulator: Add regulator_set_value_clamp() tests
      mmc: dw_mmc: Allow use of in-spec voltage range for vqmmc-supply
      mmc: sdhci: Use CONFIG_IS_ENABLED for MMC_IO_VOLTAGE
      power: regulator: Fix regulator_enable/disable() macros

Marek Vasut (1):
      serial: lpuart: Clear the OR STAT in tstc to prevent hang

Tanmay Kathpalia (1):
      MAINTAINERS: add entry for SDHCI Cadence driver

Vincent Jardin (7):
      pmbus: add PMBus 1.x framework, CLI, and binding
      power: regulator: add generic PMBus UCLASS_REGULATOR adapter
      power: regulator: add MPS MPQ8785 PMBus regulator driver
      board: nxp: vid: introduce PMBus framework support
      thermal: pmbus: add PMBus die-temp driver
      test: dm: pmbus: add a sandbox PMBus chip emulator
      test: dm: pmbus: test pmbus command and framework

 MAINTAINERS                                |  20 +
 arch/Kconfig.nxp                           |   4 +
 arch/sandbox/dts/sandbox_pmic.dtsi         |   6 +
 arch/sandbox/dts/test.dts                  |  10 +
 board/nxp/common/vid.c                     | 110 ++--
 board/nxp/common/vid.h                     |  15 +-
 board/nxp/ls1088a/ls1088a.c                |  11 +-
 cmd/Kconfig                                |  14 +
 cmd/Makefile                               |   1 +
 cmd/pmbus.c                                | 814 ++++++++++++++++++++++++++
 configs/sandbox_defconfig                  |   6 +
 doc/develop/index.rst                      |   1 +
 doc/develop/pmbus.rst                      | 637 +++++++++++++++++++++
 doc/usage/cmd/dm.rst                       |   3 +-
 drivers/mmc/dw_mmc.c                       |   6 +-
 drivers/mmc/sdhci.c                        |   2 +-
 drivers/power/regulator/Kconfig            |  43 ++
 drivers/power/regulator/Makefile           |   4 +
 drivers/power/regulator/mpq8785.c          | 494 ++++++++++++++++
 drivers/power/regulator/pmbus_generic.c    |  90 +++
 drivers/power/regulator/pmbus_helper.c     | 315 +++++++++++
 drivers/power/regulator/pmbus_helper.h     |  90 +++
 drivers/power/regulator/regulator-uclass.c |  27 +
 drivers/power/regulator/sandbox.c          |  11 +-
 drivers/power/regulator/sandbox_pmbus.c    | 171 ++++++
 drivers/serial/serial_lpuart.c             |   6 +-
 drivers/thermal/Kconfig                    |   8 +
 drivers/thermal/Makefile                   |   1 +
 drivers/thermal/pmbus_thermal.c            |  33 ++
 include/pmbus.h                            | 667 ++++++++++++++++++++++
 include/power/regulator.h                  |  24 +-
 include/power/sandbox_pmic.h               |  15 +-
 lib/Kconfig                                |  16 +
 lib/Makefile                               |   1 +
 lib/pmbus.c                                | 877 +++++++++++++++++++++++++++++
 test/dm/Makefile                           |   1 +
 test/dm/pmbus.c                            | 242 ++++++++
 test/dm/regulator.c                        |  38 ++
 38 files changed, 4759 insertions(+), 75 deletions(-)
 create mode 100644 cmd/pmbus.c
 create mode 100644 doc/develop/pmbus.rst
 create mode 100644 drivers/power/regulator/mpq8785.c
 create mode 100644 drivers/power/regulator/pmbus_generic.c
 create mode 100644 drivers/power/regulator/pmbus_helper.c
 create mode 100644 drivers/power/regulator/pmbus_helper.h
 create mode 100644 drivers/power/regulator/sandbox_pmbus.c
 create mode 100644 drivers/thermal/pmbus_thermal.c
 create mode 100644 include/pmbus.h
 create mode 100644 lib/pmbus.c
 create mode 100644 test/dm/pmbus.c
