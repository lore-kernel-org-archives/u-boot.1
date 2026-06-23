Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF33CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4332A84A63;
	Tue, 23 Jun 2026 08:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="iYst8Na7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB3C849E5; Tue, 23 Jun 2026 04:02:50 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA3E849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 04:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTOppzmDGh75LUmULp4e2kLYMbv12bQd3yqjQbEKmdEmm12Eu0hFwEzsSMd/8d3aniPg+30AycimYEI/Nr41Xw5f6RrOmGmEUH2Ix1ymFy4o4XqSNqZFjO2IPit/BoD0yVZc63svNjq5ppgE7mwlYo3s6OpUDC/xWFSBShW0wp84xG7h0T6pI+qsvmgSZ+7e52MB7BhVWr+TG3TOflmw4bwccK50kxA7dBJ4vOH05O2b5Od9Izw2xfA8p+Ti6aPeMwkari0Ja8o3OHQmwbRM+eJBcIW8jaQsJd2AsvCPUIDR/kEdbYmedilbrL1+e/jO+UDICi/E13159fUDW3rQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bkoj7UzPWhdl6fTSZwrfz3C13FeTtobJuBVCljeqHJQ=;
 b=OsfvoNdt0slvXGTbFql7KfzHbFfh1/pY9WcsHuBJf04XLPsghY93CQKuwHg0HcdXGLAiQLYregcjkmIoml1us+ExDGnUKEKYnl6uvre3nOSygia5dFYwQDyD+2R/1KySgrNRPZcmI4zajHfLw3fLIibOUAfJBeXUbBZvLiYsYH7gZjwJQtdw5zlj9nspmPQUlZHXcG58NIjBwkPK/nCqhyVDmwpD0s0r+wPhQtJ5ieQh/m/NHOJg1ljC75rLXsreCaoeYZbzjWseFoO+0ak5ZUUNBWjIBSOk02yY2Bh8YHHEICPnUc+mFDqaLarda0ahEUuszHIvvxRnHKuqZUumRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bkoj7UzPWhdl6fTSZwrfz3C13FeTtobJuBVCljeqHJQ=;
 b=iYst8Na7ZVFsmeBuT5O4Oqh6PpxAVpcWk/8ljSBuE6n8U5+UGCZYhViJqxzVjdw00JOnKtEnOL/YGxzf+4unHiBQS3C1N4oFKyOPNeoxzvTzR4BFe+a3dwbvHKVdPv16igxOAi6fy6fafl+hDXWkzwCPyVvNBQ5FDGpOV+nUTN8dhxIpOk56u+AtfQlMo4x2HEKxU5IbeRdWsJdVnnU1m4R1jSWJ7KPwI38lY2xi8BYQOsu7qz50JMnhiwx1cx50urdh8LGW2t77wXLEIcTMQsX68TNJskfZN6YKTHHXUU8LoWSnuodfiliY4lrNIzpQGUv+IgH3+x7MWU+waogEnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by CH4PR03MB7627.namprd03.prod.outlook.com (2603:10b6:610:241::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:02:43 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:02:43 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v4 0/7] socfpga: n5x: Update Boot Support for N5X
Date: Tue, 23 Jun 2026 10:02:14 +0800
Message-ID: <20260623020221.32362-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|CH4PR03MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b436e5-5c04-4bd3-81ff-08ded0cb8314
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|3023799007|6133799003|11063799006|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 7O01Ada33C4URnvoLK9aH0IBXWuFP3ORyvtMY4yNV31k40Y2a9hKtg/uEDrqxcb7xpkmDSaYRPwzJggpQmAM45A1HrCyBsfCiaQ0ddkniECdOZLt6Ucewu/scuy9dYYamAnUlcD3vTkPgRWz2Mpyv/ASBweHx/3PTK750u0vyGO09ibw1XPLvZi2VcZwXPmR35TvHhkB5+aFgHZQE4fxsaXCVwiyja0qFHNQ6b60OoEhRRzfb3YUti8prilwUDGAFV2TMB6OgQbu6DCF66TVRntAmnRZo91DcBNN2Q/lbQtiFiL/hKN8xjiKP1T8aagdBrXu9032OAwveAvkNznhOUI/rcwHCjeXZT6pyjdyi3pVRR6FJ2cBby69Dbd96Pe653yNgjTFXA1eKi1YrXGYr3myuNkjVa9QsCxzysKjDqqh7mZ//JS1HNyYRPJ4HQfAd5Rkj4QhJuSUsF6r6G9wY92Lt4z/4oj4wlvrqaKltSPbsVIOX1N93ZFrO3h2/8F6r40piHVKXHRWyRYE/fYSOOS6qW9x/thwU7iYSfSvEdMw9zf8qpYvLSHJqlDyJjOLnBnr+SGbTTlYg8HbX+/yhk08BtjGnE7JATjV6koT+/Sw4ZB876UQqsVEqbWdP+PZMoxqae8H7kgs3BpD1W+QxRksPgxgLCrMZykQ3QXQ4Kc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(3023799007)(6133799003)(11063799006)(56012099006)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X9zuE5TNHTRUjJue8VeBxO2xlSW9tOqFOAsJT5z9nFB8A5YWnGe7MKEhsm8T?=
 =?us-ascii?Q?VxVIrVvG08I0BC0m4ABigondJHQTxakKhcj1XCj3Upm2b9QwGWy2wxb4+y7p?=
 =?us-ascii?Q?2Gt8fP2RtpxaHSNq5mTeeFy5znMzOj9fg+/XFmsqTnMVePwqb/9xzkHjU3Bi?=
 =?us-ascii?Q?bZ69kvMOiSOc5anN7CPIxrVtUue3l3U10rxVZ2zgxBeJ/p0xx2I7OazrvPdW?=
 =?us-ascii?Q?/u6bxMQYM+a5aH4OTeLSNytQfOeDtcJcT+MQLJS21hVoBmJj3exhVP1JLAC+?=
 =?us-ascii?Q?u+i67pC5E/aPI0BQY0x6LqdMRMNnjvFoWBUURL8G/1GgVijghlRomBGZNq+C?=
 =?us-ascii?Q?U+POwiHS+yzXCnQKd3lxFElPLzoJM1KaqrDQYMWqi9MfYn3ZEi/SxRLzl2GX?=
 =?us-ascii?Q?puB+pt7GjzjODRK8ea0c26d9dwToY+tAaU1NlSuxvqeyTWV9sqaydyRqHbWS?=
 =?us-ascii?Q?6GXIPMgk3bhkIErZTwh4WyKlKRsUhWQWNZ4Duj0OV3dLVI4oYD5R7VDuiiz6?=
 =?us-ascii?Q?MuN+dJWcwl3TPFSUquRqBdBCCkxbtXGvvRWER+ASPGmYbIcxi8PLLuz9KuQd?=
 =?us-ascii?Q?CynDDKRtIfBsx76aqh41PLZi0B/K73sDRhS8pmUfTJIgw6RifSu6MSUogp0Q?=
 =?us-ascii?Q?70V//1CRGIm4HciEQsOQCx5x5pvOVCKH+hfNSEQq/TIyweuNvO8JQWpe+fpx?=
 =?us-ascii?Q?0kwhAqfjJx2crtgIGiSo7rU7yaBVH8t4lJWkrKPwgIdhM14iniwlPA7/hO5i?=
 =?us-ascii?Q?kyn5f5tZo7L5wNShdbuD5RdpLEw55BzAFudpS7+k02gzYna+E4A5m5mdBvqa?=
 =?us-ascii?Q?T6B47MRS0EvJjHbBqJAga3Gmz641yuJJkPiJGFRV5bxjosK+J/GFxzEfXf3A?=
 =?us-ascii?Q?wm3l3byWsoSTyS+CG/3pK/K/fTxwwnTt1HXMtXLIhU42x7XUF9dk4y+kHaMY?=
 =?us-ascii?Q?VApye2zmLGjWW72OIZTePb/POHp4UneLugyL+3n2yp2q0AhxDMHPjhxTc55f?=
 =?us-ascii?Q?yuyp0ECl2+bF3o4nfjnsa8+HgHqzyS53+BsodtU8EEKug3OtOUiiWU22NdTK?=
 =?us-ascii?Q?AcYfUeNPW4eVjdiWA0TQXMMnqTcTK/YjxI44bGcwrciGP5GOX6izUGYccKc+?=
 =?us-ascii?Q?07ge0fEJPQzHpTG/ktWuQkNxaegLWiqzWLjeOIb5Cb6e6+ikuB560KuNAEMm?=
 =?us-ascii?Q?k0Ke1DTw/JVdDo6EHLSVlXAbs7aBR3TZIx4ae6vr1AAmgfwd0gPgNTgqBs/f?=
 =?us-ascii?Q?jvJHbK+Fzl+nTLXvS2pgUbKRz6tvD5zuOwnSkWxAvGGP7GDbs0NCSG9APj+8?=
 =?us-ascii?Q?hyfNQfDL4nL9ACOxt/8cngl3EX+F/TmuCY3IwaQrGrl7S9kWtPuRvGFb2YkL?=
 =?us-ascii?Q?CU45btyqMe632bu/tMs6kvkJ7pllH0AlPQMkGKlunZRGOsn5jqy3E7yLnwvq?=
 =?us-ascii?Q?CYShpPvD4+6jKZ0+8vAOSNHQBda7qV24pzWF5X6nVE1qEFXf0eTp/DCDeS4H?=
 =?us-ascii?Q?ig5hE3FJINrAH6SZLLZ8+0QMeQIkpxKW7p/cvkr0G4AuH3eXLY4gAIXEALxd?=
 =?us-ascii?Q?7zCUVfkXwdbAAIglNgS4aUsPlj5xX9zVULv19ugZTwufSAA8C5ts57qIg2OJ?=
 =?us-ascii?Q?Tl/cffcuUOrfY7rBrgs1klf0OvXaj2/VtcyiwZo+5yleonB7iIoiZi/F9p+5?=
 =?us-ascii?Q?rggqQQ5ELnPibrUYGMkJvijukJnUztsi6B6ev8IKbLYso2TYcG5UQ1ImA2JR?=
 =?us-ascii?Q?ERPrN6FnQgvbUaORMjX0oLpFveD+kMk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b436e5-5c04-4bd3-81ff-08ded0cb8314
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:02:43.2243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNd4jq00W4oas49MTgQLJ7e3CXxsZJvKRm9ok+pMqnOlQZHfC6SHIa9tqg7A1YeiMAdIhha85SJrlRCJAz0elaZzU4REby0xwrqMd8hCZnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7627
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:46 +0200
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

This patch series updates the N5X platform support:
- Consolidate ATF defconfig and simplify VAB defconfig
- Update GMAC nodes and DT register settings
- Enable CMD_MTD for MTD operations from the U-Boot shell
- Enable ISSI SPI flash support
- Migrate firewall setup to driver model and remove legacy code
- Switch to upstream Linux DT configuration
- Update SPL data save and restore implementation

Tested-on: Intel SoCFPGA N5X SoCDK hardware.

Note: This series depends on a concurrent patch series by Alif Zakuan
Yuslaimi that removes the final firewall_setup() call in spl_s10.c.
Please apply that series before this one. See the latest version at:
https://patchwork.ozlabs.org/project/uboot/cover/20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com/

v3->v4:
--------
- Patch 6: Remove the now-unused in-tree vendor
  arch/arm/dts/socfpga_n5x_socdk.dts. Once OF_UPSTREAM is enabled the
  runtime build uses dts/upstream/src/arm64/intel/socfpga_n5x_socdk.dts,
  so the in-tree copy is a stale duplicate (matches the Stratix10
  DT-switch patch). No other patches changed.

v2->v3:
--------
- Drop patch 4/8 (enable required configs for DDR retention): moved
  to a separate series for DDR retention support
- Patch 3: Fix CONFIG_CMD_MTD position in defconfig (between CMD_MMC
  and CMD_SPI per canonical savedefconfig ordering); drop
  CONFIG_SPL_ALTERA_SDRAM (auto-selected by Kconfig for N5X)
- Patch 4 (was 5/8): Fix CONFIG_SPI_FLASH_ISSI position in defconfig
  (before CONFIG_SPI_FLASH_SPANSION per canonical savedefconfig order)
- Patch 5 (was 6/8): Extend to fully remove firewall_setup(): delete
  firewall.c, remove firewall.o from Makefile, remove declaration and
  unused struct/macro definitions from firewall.h, drop stale include
  from spl_n5x.c
- Patch 6 (was 7/8): Fix CONFIG_OF_UPSTREAM position in defconfig
  (after CONFIG_CMD_FS_GENERIC per canonical savedefconfig ordering)

v1->v2:
--------
- Fix patch series submission
- Clean up redundant DTS override

History:
--------
[v1] https://patchwork.ozlabs.org/project/uboot/cover/20260318030034.25889-1-chen.huei.lok@altera.com/
[v2] https://patchwork.ozlabs.org/project/uboot/cover/20260428070017.16807-1-chen.huei.lok@altera.com/
[v3] https://patchwork.ozlabs.org/project/uboot/cover/20260605082709.11709-1-chen.huei.lok@altera.com/

Chen Huei Lok (7):
  configs: socfpga: n5x: consolidate ATF defconfig and simplify VAB
  arm: dts: socfpga: n5x: update GMAC nodes and DT register settings
  configs: socfpga: n5x: enable CMD_MTD
  configs: socfpga: n5x: enable ISSI QSPI
  arm: socfpga: n5x: switch firewall setup to driver model
  arch: arm: dts: n5x: switch to using upstream Linux DT config
  arm: socfpga: n5x: update SPL data save and restore implementation

 arch/arm/dts/Makefile                         |   3 +-
 arch/arm/dts/socfpga_n5x-u-boot.dtsi          |  55 +++++++-
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi    |  18 ++-
 arch/arm/dts/socfpga_n5x_socdk.dts            | 122 ------------------
 arch/arm/mach-socfpga/Makefile                |   1 -
 arch/arm/mach-socfpga/firewall.c              | 107 ---------------
 arch/arm/mach-socfpga/include/mach/firewall.h |  69 ----------
 arch/arm/mach-socfpga/spl_n5x.c               |  31 ++++-
 configs/socfpga_n5x_atf_defconfig             |  89 -------------
 configs/socfpga_n5x_defconfig                 |  26 ++--
 configs/socfpga_n5x_vab_defconfig             |  90 +------------
 11 files changed, 112 insertions(+), 499 deletions(-)
 delete mode 100644 arch/arm/dts/socfpga_n5x_socdk.dts
 delete mode 100644 arch/arm/mach-socfpga/firewall.c
 delete mode 100644 configs/socfpga_n5x_atf_defconfig

-- 
2.43.7

