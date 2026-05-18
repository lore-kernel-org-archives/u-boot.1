Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C347CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 01:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F213084659;
	Mon, 18 May 2026 03:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Q0naZtNI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4074584659; Mon, 18 May 2026 03:13:05 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8FA983AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJKKTV0KMhVoG7464sICRTGu466qjnbIIOGJ8b3+3N1BxCmt09JiLJKf3bsyS+N+B452UsP31cVwmOMRxdzMa0qUJYqg7RcJ3SgEBYfuucoYDXEvRuDaqQRW9A4lT0jBhf8UTA5zzl5ii9FRe464OOaWuOFRSwo7mR6WD0c3gnovRh0kSONXwcmI0dXptJJ5ElPD0Nxc1jmJsqF7Z9GLCbAV153N4R4jHQwwBnEKt86TQHmQRjOc+vyJi2OGHtG/VWHJuhbKO2tjYv84th7wiqeXp8q09tPFUlIxwK0bI2PNCea8LSPsteUPqqGv0c/6drGadh678w14tzLWGerCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPg3VtMxfKNP/UxeaGmHR1tG4gRKoKuHThDR4TN+TV8=;
 b=xGBO/ow21dT+yHJUrfoGZalWzTNS63+A0rYRZIMZ25hl2d3PXbTP3BW9EL9T6/ODHPWnFVUUAQ5jwh+DBEAe3hi4vXHXT8R7JkNBmDsAzB40u/bDJSv+xi+X5ZdlrRq0h2gFrMcC8MgSX6nrmC3gbNZiXA8E1BHFgDKge6Oa6xrwpCXaqsasq9Epdc4DRuYvurDm9GcmEymUnXP8f0ZN0hyT6iMsVFW8lPKRGCQ2hodfNkBQbkmRRM0yehQ4ZWW3I3RjH6cXHjvver8PLVSB/MfRuoShX1r3+sKJ4mHkI5q/J2tVBtr9QEe7tcVDI4MPO+RVgG7P5pZrrqwP0LSkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPg3VtMxfKNP/UxeaGmHR1tG4gRKoKuHThDR4TN+TV8=;
 b=Q0naZtNIhBLLgym595iNpr+Wak5vzC4Ps761aUAUC/tUaOK1lzDVaHoXHh9gfEfJEuRtsj9f+PwWG+W4qdtmCjSLSdNwREYAIvW8CvsVHh79M84zq5FPNYfBxYoA2YgkXoovYgKICmquE+N3ngZ42oR3cOSt0bFIAG+fOcN6Kfu5H0kS/UYADtmyXpUwvlQZe7dEdeoKrMwaKmhVaNXcR/byIjV+kf5OXn6OYx7PQEwiseiqF/9wi8L2WUPP6InwVcwcGksoJRcCAhcP34RnRz/GUYS6bJ2VLlWsWh70hU7lud39ZLvajc1nrGC6m7Y+LT7tcSNSw21eJpt7f/qmGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BLAPR03MB5556.namprd03.prod.outlook.com (2603:10b6:208:297::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 01:12:58 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 01:12:57 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v3 0/9] SoCFPGA: Update Boot Support for Stratix10 in U-Boot
Date: Mon, 18 May 2026 09:12:36 +0800
Message-ID: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BLAPR03MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: 603029aa-eca2-47c8-99f1-08deb47a98cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|11063799003|55112099003;
X-Microsoft-Antispam-Message-Info: dKFiaKEqgIlh/Z2+SIq5pX84jwrUZcgh7f97yRk/erXDH/igb2zrYryk6WF/gTnKAIV9Dnr4BKasswFkPEQngkErM6mCcQfn+Qhrj7AZMYhPewNsrDL71ITPaTqgYzlNXEwJrdAcKAtPzd5rUpcZ9KBfogWSnp5FSFkt7TlK6ZJIsCLO0cYtAbuBhYvYzUkcu4PFD6joPhgvDXev+3o2xpm6cO4uvaTO/10bZA5os04BFHcaZ9g1vQ/70hOvkDZKXhzhKSN8xHyZPcFKclhzUvkPbKUz8ClTxPuy0axU5PGQNgDfN5YLeIrLsv8K5lalDXszN9yLTX69s/HIeHfRuNQhnb00i8QMcLJKHH2CwUGBdSPP6tIRpm3I4DQlGQzeh6d5N9m38nEdceCuw4NnvHcUUwx6+9+7LgLXhoj6Ddps0bdBSIYX3OM7x0fBWsLyQo7eSx+QWluWlmFWIlMSoLMcSOaODtzW5dGD+HtdoiiexbDW+Wm8C3KAVixElzlp20+EE0pvp5/Vt5GH7ZFVuxZqoz4F6jvUREiCuvYMutyXONoAf2UpC3yn3sSRx/fDcSihC71PDgFBTzBCiCLyavB5J3MxRyoCffKArVuZfgr5ZiYCV2wjY5y/kEU/jH7siUbQeep1tkbSSpZZ4qolOIOTCzpdaO93Q7UicWuwMff8w23VJjkGJJ9cZQkQZGPQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(11063799003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WD2BDD7TEMF8Uy3974jZ3lVSCB69aVnm03YAE+tKpfOH13nCQXzoL4t8y9Bb?=
 =?us-ascii?Q?m2O0+iszmN3l13I8YlUcoHiMP04SSlh6PLO2FzVD3xmbK0Dey8Gw3y2gXw/A?=
 =?us-ascii?Q?yWjzHdWhgGGCyl84YpI/L8SgEKAABW3Sk4HOJhUQZjXm3ElaZ7aSR0QlwPmS?=
 =?us-ascii?Q?e+6c4sUp7AemWWEmHa+FVxMxMX32Z/ahUYW5wQR3JhcMFbPHpgfWQWgSojl9?=
 =?us-ascii?Q?rr5VNfdALGIFe7M3x5NuDZGEi4z6QqP3AOOZ7gX2vJjONqhzti9HK+AltwtB?=
 =?us-ascii?Q?QVHVHvod8n7BL6c34OooDsT2UV5ZLDqK/dqsGjdR9veg7StfSUJkFv8hfS5E?=
 =?us-ascii?Q?+5uJNU8qJ8psk5ls6REWngxKIULx5BxJpI6C4De6+cEiGhLq+paAqs5bEL/y?=
 =?us-ascii?Q?R4r0yGiwsVNWUsbYs8odsGln5oXMBNmIcJN154da/Z4a+7NW7c8NuNhCA/yb?=
 =?us-ascii?Q?5r8xTOHf6POz7GpLdPAmO+IVZBUawjtwPxNyhoE0zLXGqrDQoLAy3sGWyBGW?=
 =?us-ascii?Q?AfH9NligZCAdmI4qsoKK9JvUz9kek9AcweNsIRpsURQbCO1h+5vN1CoC3got?=
 =?us-ascii?Q?4SATx/39fqwyLLf8l8UA1wWue0rOW2ViJ9xJpntOyZ0EKpcLC3j7CNJbnK4h?=
 =?us-ascii?Q?sIR/kXQSw9yy0+KCQR4iHrwLS1GBYm5b81Y/mZfFjggZOB0zQHQUl7odwBDH?=
 =?us-ascii?Q?DAeRBQDC5fS6RtWoPaPCNogk37vOBqTEslxujhHdrHQHwhycW3Cphh+H7f05?=
 =?us-ascii?Q?Nktjy+4JFLcRTLuhufZi6pNHfMhThNXo7PvT0AjXnDzLBZm8p4NYHZfP72ic?=
 =?us-ascii?Q?4T1WyGNnsrmnJoO8tMyNli7bfTeXgORTiooYTkP3axM65jQbLG973xq1Dsjn?=
 =?us-ascii?Q?FpcgvynHDHIhxSREsRw4Dl0GhpcY0f2MzkAR02R1CKQjbmRd1FgKexamyzPZ?=
 =?us-ascii?Q?c+rM87TDNLsUwz4FVY1kWXUelhyad2h9amiT2AnN9WUqNEWOCSHeJqDTO8WV?=
 =?us-ascii?Q?BitKL3zejyZ6N8NHFGAGrozyIFuxm6R2LcY43CmTnf73PSXHOUmCqUU6Qd9R?=
 =?us-ascii?Q?hPmSK3V9deOJ2OP1rFiJ4yOrtFtLDuJHXKdSWJNiHVNiEhjRvMBt4sEj0gbt?=
 =?us-ascii?Q?ISz1OJ/2fOE2zN8nIepiwYvmIuYVQP8EQ02GO1GfSv+eIAizf4m/uuxJ4w8V?=
 =?us-ascii?Q?nA2wQ88/ocH4Bk+lastXzDNCG1RAwqsd6lAPO2wrWzXj1PTSbT+Rmrthk57w?=
 =?us-ascii?Q?JnhetbThZWQjdXEf7tX3YdL8dUjDJI59Fe3OwCXBq3izjH1IKItBD/O6u3gz?=
 =?us-ascii?Q?pzN6DOgiG3m9SN7rN/pUNE5Evg3KUylNYi9UtNObbsu7T5MAInE3TbRhJJEa?=
 =?us-ascii?Q?PTMfCOuZiwpFV4dpUrbsHGeAWdzoFWzJMbpLxm+1YSz5N+n+qrkCJ9sO2tGr?=
 =?us-ascii?Q?e900jmx3IZYrW8lHKWpeQLXj2uj5HE/HK/xIdmzyO5LODXu1ZHgmP7PhC4iD?=
 =?us-ascii?Q?KAtnVx8SXPZqTMmVXZeslHCba8HjFwDdcHqassuZm6rpLD81XHr9XKCUqfv/?=
 =?us-ascii?Q?rZh59yAreDAXLfm1YjpmjaIsH86MP2Ky+4TugsruG/riFIf8RJJu8or46otY?=
 =?us-ascii?Q?+tPvjAQmtVEJpQZY5N3FN/YfEvc/nCduskM8p4CnVBZfVVN/+IIxskWyphXt?=
 =?us-ascii?Q?eINwvP8zibiQVZnESe9stXZeLChJzwYBFwA6orx3ajvxQdCybH7WGnA2xvzX?=
 =?us-ascii?Q?Yf7G2BFf9lhaTCPPV+XlQT8i80l4Dz0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603029aa-eca2-47c8-99f1-08deb47a98cf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 01:12:57.8874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: La28kBg+fp7GmIZZy/cR5uAtrvDiGNU68pc43FuX3g+6KrWbPhN7V/FeyquwlZRud2IM5wtXhhWYZJazYABd0W3HOVo5Lb6woaimOU0F/yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5556
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

This patch set updates the boot support for the Altera SoCFPGA Stratix10 platform in U-Boot. The changes include:
        1. Board-specific configurations and setup required to enable Stratix10
           multiboot operation in U-Boot.
        2. Integration of cache coherency unit (CCU) initialization routine,
           including CCU conguration in DT.
        3. Clock, firewall (configured in DT), SMMU, low level initialization
           specific to Stratix10.
        4. Refactor of the Stratix10 clock driver and targeted updates to the
           MMC driver for compatibility with the refactored clock driver.

This patch set has been tested on Stratix10 devkit with QSPI boot (UBI/UBIFS), SDMMC boot and RAM boot (TFTP & ARM DS debugger).

Changes in v3:
- Removed fdt-2 under &images node and board-2 under &board_config node as
  socfpga_stratix10_socdk_emmc.dts is not yet available
- Regenerate defconfig with make savedefconfig
- SPDX-License-Identifier format correction in
  board/altera/stratix10-socdk/Makefile
- Retain Intel Corporation copyright notices
- Add clk_get_l4_main_clk_hz() for STRATIX10_L4_MAIN_CLK clock rate

Changes in v2:
- Cleaned up git merge artifact
- Cleaned up cdns,read-delay parameter for spi node
- Cleaned up duplicated /delete-node/ kernel in binman node
- Implement using real hardware clock source frequency following Agilex
  clock driver
- Commit message improvement

Alif Zakuan Yuslaimi (9):
  arch: arm: dts: stratix10: Switch to using upstream Linux DT config
  configs: stratix10: Combine defconfig for all boot flashes
  arm: socfpga: Move firmware register settings from source code to
    device tree
  arm: socfpga: Update Stratix10 SPL data save and restore
    implementation
  arm: socfpga: s10: Enable system manager driver for Stratix10
  ddr: altera: soc64: Add secure region support for ATF flow
  clk: s10: Refactor S10 clock driver
  mmc: socfpga_dw_mmc: Exclude S10 from legacy clkmgr address retrieval
  spl: s10: Enhance watchdog support in SPL for Stratix 10

 MAINTAINERS                                   |   2 +
 arch/arm/dts/Makefile                         |   3 +-
 arch/arm/dts/socfpga_stratix10-u-boot.dtsi    | 313 +++++++++
 arch/arm/dts/socfpga_stratix10.dtsi           | 430 ------------
 .../dts/socfpga_stratix10_socdk-u-boot.dtsi   | 119 +++-
 arch/arm/dts/socfpga_stratix10_socdk.dts      | 143 ----
 arch/arm/mach-socfpga/Kconfig                 |   2 +
 arch/arm/mach-socfpga/Makefile                |   1 +
 arch/arm/mach-socfpga/clock_manager_s10.c     | 448 ++-----------
 .../include/mach/clock_manager_s10.h          | 175 +----
 arch/arm/mach-socfpga/misc.c                  |   6 +-
 arch/arm/mach-socfpga/spl_s10.c               |  70 +-
 board/altera/stratix10-socdk/Makefile         |   6 +
 board/altera/stratix10-socdk/socfpga.c        |  12 +
 configs/socfpga_stratix10_atf_defconfig       |  90 ---
 configs/socfpga_stratix10_defconfig           |  69 +-
 drivers/clk/altera/Makefile                   |   1 +
 drivers/clk/altera/clk-s10.c                  | 616 ++++++++++++++++++
 drivers/clk/altera/clk-s10.h                  | 203 ++++++
 drivers/ddr/altera/sdram_s10.c                |  60 +-
 drivers/mmc/socfpga_dw_mmc.c                  |   6 +-
 21 files changed, 1408 insertions(+), 1367 deletions(-)
 delete mode 100644 arch/arm/dts/socfpga_stratix10.dtsi
 delete mode 100644 arch/arm/dts/socfpga_stratix10_socdk.dts
 create mode 100644 board/altera/stratix10-socdk/Makefile
 create mode 100644 board/altera/stratix10-socdk/socfpga.c
 delete mode 100644 configs/socfpga_stratix10_atf_defconfig
 create mode 100644 drivers/clk/altera/clk-s10.c
 create mode 100644 drivers/clk/altera/clk-s10.h

-- 
2.43.7

base-commit: 36d4c653580824b16574560b21d4401614d8b68e
branch: master_s10_v3
