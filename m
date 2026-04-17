Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA5BF43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2359F84262;
	Fri, 17 Apr 2026 14:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="P/8taQoB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0C81841C2; Fri, 17 Apr 2026 14:23:37 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA7A83EEF
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/xEi/xA3aV7pd8l2wbmrjmldCiUo3dcyWaeOWgOz/UVF7OkbczKO3GJvu2IjozOyMaxDI0QWeb/EJ1NiwFzNV0ABU62kzHvbRoCYqbhMZaB1+11SHTrhPLF8oP+27zttHmokQ+nRhGJ6qkzJvzPPieycFmNiIZHe3OqDTE5oqxz7L5QE7qeHMkJAYlRtIGVa/MIsFPnIeT3FQSO8Vke/8x8x3iRhGdlQL31uNTNM45yDJPOpfe91hN+oz6cQ4Hs1SNaRc5W6zPeGYKAZLgZtkY6qQUnY3wlmRKGQx47XWPmOoq3zY1VIalPCGhnr0GSwUxAsV/wYIipxOlRyWoZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuNnjCD0z40fOT73q/RA+3ES8KJzqi1rBbGBXEZ8ZaA=;
 b=vUM7ciBokABQflr5zLxpRfm6WheC5LB6OtvcIgZtdU5jcd4yTA2KHb/SWwg998wuKh1ChQVLhftFTB+wkWFUPXwzg6lltn3KnTFtz1QJ8acM7Ofeot4KWSGGldOuHkFqHkrNwEhtltwemtvuJ3aOJmyvg8XLQn9ltCy6FyFRVUpZq4T33zZqkpy3RR9USw6kAttM7AMa0DytvyxiK437Lhy6bk+Rvw9izhodvvRNFlunIPaG9HC8tUxFLV6HHCQvuYYw65p87qiqGaQHNGrPNqC+3jM2zIx5Q899LjX4R11f9Fj6ZxMSB0+OI8zU9nlsn0GgtdX1LAy/uvAiTTmHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuNnjCD0z40fOT73q/RA+3ES8KJzqi1rBbGBXEZ8ZaA=;
 b=P/8taQoB2Aoaqi6VxLQ0Lx0X3s4c4OIEnj4MgxfeOd3MMGyxaWj31Dc+9WPnwwGpTtJUcRlztPEflrJq5whjyKbjp05eK7IQWdzQEZNW6F+dUOjwDQBVi1QdgbT3Tx9hRvwx/xBTuv6x1pdiQzPiSJUpUESIaGqrNtg3LXv9i17TwL1/l6xNMjkd/HhlM6EYeMAkDxdbTCjsNthpoY8Hhn2b9TiR+NUQBxQuzi+CrHKhpuQZYuZCibvG2UevhpFdGdvPULp9eiolSZ1VgDan1BlqgZHQZS1P2DeNhaubYH8uQOvLPf3b45A0pPoM2dsWGnGNEvSw1AvHk5Yptr8ROg==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by DU2PR09MB5357.eurprd09.prod.outlook.com (2603:10a6:10:276::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:23:32 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%2]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:23:32 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Uros Stajic
 <uros.stajic@htecgroup.com>
Subject: [PATCH v7 0/7] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v7 0/7] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHczmUBDshfwrxbNU2xVHDfgMJB4A==
Date: Fri, 17 Apr 2026 12:23:32 +0000
Message-ID: <20260417122213.147529-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|DU2PR09MB5357:EE_
x-ms-office365-filtering-correlation-id: f312b0af-1cc9-43d7-862e-08de9c7c23d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003; 
x-microsoft-antispam-message-info: vHwhHg5SVacGRFetFuVQtdd1DDM1kbP2DDAHA+Hy3s7CVbIMJONaL2ntNbeX9mVB+ISQviOD9MsjDAmVMzHioziMyoQ4gvnTlrJ0TXJWoNuYjkizWjDvHmRGZr8Xb1jFXAwK46OMNKY+zXI8G3AUPiIB5qxvefKCTI27U/k/I7W6NaNtad+FZOe64ZtP5zQ/jcKPu55SkE7RL/A2SK+ZfosxP5/HRqTl5P5IuhqysEd98IFQUue8sHqbzi40TkdHFh5hpmaxiwhscNqlPPDEfWVjiwAJA98fYgTrkG1ICkeuPiKLbaXdeBVwPOgoBI/C/yMSTZBOXHTf+RSmfS+IRyeq1Xa9nfO+1AGzXxee3x2vC8HEJFbgP/5Aq6eQXBde5BslWLl1x26Vm1pv22XDo3tCEM/fH3R12mrL3Y+Cwk60CcMpipOS2WT1xXuCSLvcu3YIdT5JwoMoUEDnGrWSta/ThzSdzLrp3oGpTfpR8qSZBo5/U0VeehLTr/URK+c52IjI0CTjJ2Qa4Hi8Wl9pnYtkP4CVz7FkK4LVWnkA5rc08uAMu1NYXf3KuRn57PPDbPnrftGXabbST8tx9PzBjTfinZq8AstX5bvkeHxWBmTgOA/F6wIlwK3FvhtY04FK+LnGdIBDYriJmDAnM7khoazWNNeKYXogLB73UcsBcRQNC5NhYaqAJLgriXAb+lpMy0bmv6bfsYVQvfdxnQAKH3ZM5+I6OR7TfB1H1fOh6xilE21o84L13n4sQJ77HJDzKDwBw1yngBAik0tjHwRtQ0Lok8T0eGARI5xKX9QOZEM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0MWPRU4QAvKbPs/7lyi6E5o54pfbad8aJijc/V0UNj5WssdBLLpy3U1Mi7?=
 =?iso-8859-1?Q?ByQpMax/hx3/XIPB+PQNiITv/uaosSFQki5c+zsE+106zRwCoPqHPSwAyC?=
 =?iso-8859-1?Q?pA/d2+s9loPT/mtJjOlJhB0ZjpqryLQS9AmUnVXhezEGe+HtYojSMxPZmk?=
 =?iso-8859-1?Q?aPa0bcvTLMGhjVv3HHF8pmFHDTjmXRrtTHyDpSgCynF9uNNSxqCHRESdun?=
 =?iso-8859-1?Q?RlSR9Eljn9c0aR+EyYsQPITdonipiNhXuvoDPiUOyer/dbKOSCF3+x+E/L?=
 =?iso-8859-1?Q?pr903UQutZ51D2lgKzjM2KkKz3u1jwpUxP5UCuMJkdReMwwE9Fhbt7Ra1a?=
 =?iso-8859-1?Q?Ja7Z1A0Ja3KrTflQbIAmT9ckzU7vVGN38wFCFcE+PQ4lAPuXl60zgHItUJ?=
 =?iso-8859-1?Q?Z4Ykqsx5c/CT/OqmUqufTPLMmWVzilUsENDBnlLrVDGmTNlQDYEIhF7L53?=
 =?iso-8859-1?Q?ox5JU40wc18OuE1I0q/1BSBN7jCrHa0kVS9ZmjSm7ba/KFTZTsa433q1LO?=
 =?iso-8859-1?Q?s8Efmfp9i+ERmlEfyr80ErAn264J8Dc5B3ANW8D2EC/5OChxFpbAAPTeWP?=
 =?iso-8859-1?Q?yepeBLo2qz7Z95jckd5XxTZyTurAlillm34UWDC+EckFHBXv2UMUjhSmD8?=
 =?iso-8859-1?Q?l11sejlY4LPEgmyx5tCU7Hcoo8Vm2Nx9avgbbElJsm3HPc4FoslwdDTNmY?=
 =?iso-8859-1?Q?gkzctOQjw8d9r+9dsb/hp01ZPp352a9ZPXszMQSW3hqHw8WhY37V5nviJI?=
 =?iso-8859-1?Q?DYPvvwh+gDkpD++w3T56HLtPcX1JfbuITooI2zgsGOLyzIETdWF0ubSt4O?=
 =?iso-8859-1?Q?BvZ3wenJav4HSdR9ZXKmfdTYanNVxUDTry7hXmDxbdzsG1hPQ2eLZuJ0Gl?=
 =?iso-8859-1?Q?nYbRaMVpJSRzYP+OgseD4fShNOsRzkU36FD5EzzuRFxuZy1Dl9YszvjvDG?=
 =?iso-8859-1?Q?BsYSmjBJ553z+wa0mhZ+EfjsVKAYfwEYnmZEQHqZDFBw4qNuR0h+wWPm/+?=
 =?iso-8859-1?Q?yQomkgS2mnwzghDg9TGcJOWAfjqK0Wu2lMDqRIWdb87QGjIjnmFqcNQc1T?=
 =?iso-8859-1?Q?59dfs/HnR7V7qp9V5edyfnx9Xv6i5tVCPPpcfx7rU0bD/sSnZ20kFG+gcr?=
 =?iso-8859-1?Q?lCDYn6Dg79QE90hzZ/twNGHteUwFrY1vzUX/TEJQlqhg4D/Bb63MhSh11u?=
 =?iso-8859-1?Q?ZIkjUN7V72qbQ6uB676TiiXRvgsH4FENf4XI8YfJB8K4rqnXdfN2kfp4ac?=
 =?iso-8859-1?Q?oltnH0gBP65nqXCKZxooLx14ovnNlvDwGyR41/bpJ5d9cvfq60hatoAF+X?=
 =?iso-8859-1?Q?DwqdVzJBryzDsh0BEQb6OsJSXTNkPVtCAEdOmTpnqwTo1ASQaU6mlWvY4v?=
 =?iso-8859-1?Q?xiCqo1zmxX90D9JehxQKMGvoTIPQeZSN99YiDLnztmLB7BNUszGQsCPQmv?=
 =?iso-8859-1?Q?EUjBFQxvmxcaBhMedCEujE7poDVRLk0WKTCbHEEXYW/JQk+7mKysMEh/d3?=
 =?iso-8859-1?Q?/G9L++y/ap96PKrVfi2Y9m4vnQbXgr9nBhLlU//qgjtgwRtUTA3eqb0eRe?=
 =?iso-8859-1?Q?cb0uZkOb6hvRZYZu7l9Lg1bWRy0fGFAdd2dmAPLxZHuWTU9CT+5OSwUpwt?=
 =?iso-8859-1?Q?NV+yvJjnVyONUEdfgJL7PGiZWIEdyJ+07DWCvDRtQa9sQm8U90fgK9+ikM?=
 =?iso-8859-1?Q?lVLpwPy5o3Y7Xo9rErYU+O93PHklhccgu+hN0cQxNesZl6hL4i6gSLRenD?=
 =?iso-8859-1?Q?7mSXLOGM97tj7W7wAKDvXZQaVMZcC3T/Oq7hbYCQlOU32go3lFDmjII4Cb?=
 =?iso-8859-1?Q?Ec3mOhlqRl6vnXTQCR8hi0kxkZnMyww=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f312b0af-1cc9-43d7-862e-08de9c7c23d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 12:23:32.3450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wxKV1j/Ma5pz4eTC3LUuwzkimbe0BNGhkB10kSkAnThfie2HoW+MXdZrBWz40BqnL0ba3LmH4EOWIGP6fxVtytKPetxoEhvf97zd4kpLdzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR09MB5357
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

This patch series adds platform support for the P8700 processor
running on the Boston board.

P8700 is a high-performance RV64GC SoC that supports hardware
multithreading and optional multi-cluster configurations.

----
Changes in v7:
- 01/07 - Move CONFIG_RISCV_CM_BASE from arch/riscv/Kconfig to
          arch/riscv/cpu/p8700/Kconfig

Changes in v6:
- 01/07 - Fix the BOSTON_PLAT_BASE redefinition warning
- 02/07 - Update the DTS compatibles and make minor cleanup changes
- 06/07 - Replace <asm/gpio.h> with <asm-generic/gpio.h>
- Drop the libfdt memreserve alignment patch

Changes in v5:
- 01/08 - Drop p8700_platform_setup.S; move the early init logic to
          harts_early_init()
- 02/08 - Add board_early_init_r() for Boston RISC-V.
- 02/08 - Defconfig/DT: set timebase-frequency to 25MHz, enable PCIe2 node,
          and move bootargs to CONFIG_BOOTARGS
- 02/08 - Set CONFIG_PCI_BRIDGE_MEM_ALIGNMENT to avoid PCI BAR allocation
          failures seen on Boston/P8700
- 02/08 - Drop GD_FLG_COHERENT_DMA; use a platform DMA-coherency check
          instead
- 03/08 - Update eg20t-gpio driver to use the PCI API
- 05/08 - Refine the commit subject/body for the MIPS GIC syscon change
- 08/08 - Add p8700_dma_is_coherent() helper to determine whether DMA
          is coherent
- Drop 'display' command patch
- Drop the 'startharts' command patch.

Changes in v4:
- 02/10 - Use riscv_aclint_timer and update CPU timer settings
- 03/10 - Fixed inconsistent empty line usage in gpio-eg20t driver
- 08/10 - Replaced inline assembly accessors with generic macros
- Dropped AMO instructions emulation patch
- Dropped P8700-specific timer patch

Changes in v3:
- 01/12 - Split original patch into CPU/Board parts
- 02/12 - New patch: extracted board-specific logic from original 01/12
- 01/12 - Relocated object rule for p8700 into p8700-specific Makefile
- 01/12 - Explained .word usage for mcache instruction and replaced it
          with symbolic macro
- 01/12 - Replaced inline assembly lw instruction with readl()
- 01/12 - Removed p8700 code from start.S, moved to harts_early_init()
- 02/12 - Fixed operand spacing in assembly
- 02/12 - Replaced hardcoded address with properly macros
- 02/12 - Switched from riscv,isa to riscv,isa-extensions
- 02/12 - Sorted DT properties properly
=20
Changes in v2:
- 03/11 - Remove redundant pcie_xilinx_probe() and update commit
	  message accordingly.
----

Chao-ying Fu (7):
  riscv: Add initial support for P8700 SoC
  board: boston-riscv: Add initial support for P8700 Boston board
  gpio: Add GPIO driver for Intel EG20T
  pci: xilinx: Avoid writing memory base/limit for root bridge
  riscv: Add syscon driver for MIPS GIC block
  net: pch_gbe: Add PHY reset and MAC address fallback for RISC-V
  riscv: p8700: Add Coherence Manager (CM) and IOCU support

 arch/riscv/Kconfig                        |  23 ++
 arch/riscv/cpu/p8700/Kconfig              |  21 ++
 arch/riscv/cpu/p8700/Makefile             |  10 +
 arch/riscv/cpu/p8700/cache.c              |  99 ++++++++
 arch/riscv/cpu/p8700/cm-iocu.c            |  75 ++++++
 arch/riscv/cpu/p8700/cm.c                 |  92 ++++++++
 arch/riscv/cpu/p8700/cpu.c                | 105 +++++++++
 arch/riscv/cpu/p8700/dram.c               |  37 +++
 arch/riscv/cpu/p8700/p8700.c              |  14 ++
 arch/riscv/dts/Makefile                   |   1 +
 arch/riscv/dts/boston-p8700.dts           | 264 ++++++++++++++++++++++
 arch/riscv/include/asm/arch-p8700/cm.h    |  61 +++++
 arch/riscv/include/asm/arch-p8700/p8700.h | 133 +++++++++++
 arch/riscv/include/asm/global_data.h      |   4 +
 arch/riscv/lib/Makefile                   |   1 +
 arch/riscv/lib/mips_gic.c                 |  47 ++++
 board/mips/boston-riscv/Kconfig           |  47 ++++
 board/mips/boston-riscv/MAINTAINERS       |  11 +
 board/mips/boston-riscv/Makefile          |   9 +
 board/mips/boston-riscv/boston-lcd.h      |  20 ++
 board/mips/boston-riscv/boston-regs.h     |  42 ++++
 board/mips/boston-riscv/boston-riscv.c    |  59 +++++
 board/mips/boston-riscv/checkboard.c      |  43 ++++
 board/mips/boston-riscv/config.mk         |  15 ++
 board/mips/boston-riscv/iocu.c            | 102 +++++++++
 board/mips/boston-riscv/lowlevel_init.S   |  18 ++
 board/mips/boston-riscv/reset.c           |  15 ++
 configs/boston-p8700_defconfig            |  98 ++++++++
 drivers/clk/Kconfig                       |   2 +-
 drivers/gpio/Kconfig                      |   7 +
 drivers/gpio/Makefile                     |   1 +
 drivers/gpio/eg20t-gpio.c                 | 141 ++++++++++++
 drivers/net/pch_gbe.c                     |  37 ++-
 drivers/net/pch_gbe.h                     |   1 +
 drivers/pci/pcie_xilinx.c                 |   9 +
 include/configs/boston-riscv.h            |   9 +
 36 files changed, 1670 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/cpu/p8700/Kconfig
 create mode 100644 arch/riscv/cpu/p8700/Makefile
 create mode 100644 arch/riscv/cpu/p8700/cache.c
 create mode 100644 arch/riscv/cpu/p8700/cm-iocu.c
 create mode 100644 arch/riscv/cpu/p8700/cm.c
 create mode 100644 arch/riscv/cpu/p8700/cpu.c
 create mode 100644 arch/riscv/cpu/p8700/dram.c
 create mode 100644 arch/riscv/cpu/p8700/p8700.c
 create mode 100644 arch/riscv/dts/boston-p8700.dts
 create mode 100644 arch/riscv/include/asm/arch-p8700/cm.h
 create mode 100644 arch/riscv/include/asm/arch-p8700/p8700.h
 create mode 100644 arch/riscv/lib/mips_gic.c
 create mode 100644 board/mips/boston-riscv/Kconfig
 create mode 100644 board/mips/boston-riscv/MAINTAINERS
 create mode 100644 board/mips/boston-riscv/Makefile
 create mode 100644 board/mips/boston-riscv/boston-lcd.h
 create mode 100644 board/mips/boston-riscv/boston-regs.h
 create mode 100644 board/mips/boston-riscv/boston-riscv.c
 create mode 100644 board/mips/boston-riscv/checkboard.c
 create mode 100644 board/mips/boston-riscv/config.mk
 create mode 100644 board/mips/boston-riscv/iocu.c
 create mode 100644 board/mips/boston-riscv/lowlevel_init.S
 create mode 100644 board/mips/boston-riscv/reset.c
 create mode 100644 configs/boston-p8700_defconfig
 create mode 100644 drivers/gpio/eg20t-gpio.c
 create mode 100644 include/configs/boston-riscv.h

--=20
2.34.1
