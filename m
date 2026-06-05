Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72366CD6E75
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 01:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5210184A09;
	Fri,  5 Jun 2026 03:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Ky4DBdX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E2184A02; Fri,  5 Jun 2026 03:58:22 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA931849EF
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 03:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKxC9SUViw+X18LT7/YHac/tAghAdTdF9ABU5c6vrHeaIK5HQn1K6gdN+40waxHdeWDEHgDEHjdoL2PyIIghnYgk5a3IruYUxxKmAqlKEjSsJeUF8bF0eXjF5ApKe3PRf9/p5e237ChIrqOJBJgDblbENfgvanvM+ETWOWn25hxWFyhoC2YGZhtxNmX5i0Pjq0Vt7srPuDgKLHLMCRpjJcQGpmGCsjdX9elKURV89mFlSQbTN2C5uxz5PSlWGRyQDlAxRFaPjNMqEf3vtFEzrJrTHCqY4WzjEw6d3Rj2nZJlaC95ZNViQu0I3z5YvqA0Zb4DddeFNIIwSfumTT8ejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4rfszm2876yIweMgr2icIS+RWh05d9M3NlTbVV9ylQ=;
 b=Du+7cfd6CYgsOP9oirVMDl8AJYf1mIInsCAyI3U5M5benf1kLxbsqGtxgRpapsqYexkBg5PEK+7jZAmXrf6a0pkVJeebJQUQ8cPUpxrHPJM9GObEudQATOLneJMyTdCULF+f+J3S60XQBQOXOr9QmfsVqNYbp6DwKlQcAPqTpP+P+q76yuaanI5fiTIIuGUU+7UyDeEo/A5lYdoQIu0eTZK7/Nw4F7aaeySYsbmuyCw+UVt6fZc/VF1lWD4V3IBoCEY2x6Rj2uWrB+zDixwB2LElwWfd8iWzYyJxMp/YxXmiwH2SvqPMBSjIgJ5MNhmYu95ZAo7Z2/uspzHW4M4sVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4rfszm2876yIweMgr2icIS+RWh05d9M3NlTbVV9ylQ=;
 b=Ky4DBdX7uB+u3fEmpmwNzKfiteOjpET+pctVVwF5afyEkg93Hfu9PvcQ8Xn7XNLtW3kY+ZjNc86q/xETl96FQOMtYCtc9Xm6ta9hLCVOIZ0lRg2har2r4Ow/ySck2Ck9cE1bwqJwscdptF0lZVNZpw0qb6Q09P/S9pAgQqGxIgoMuwOlBPZjQnvzmy5uvxS/7Xc07Swr4GPnV7yf8tFnTlaIjbWoA+gU3JCYRNfLLHPgktvZXkj/QS1SP3x5k6BXd2AG+kQ24i0SIpqUsdAxRaOjVhf/+DGb1QyrGSq+4qv1uo53fsOOSAHarCCW8Mx8dOkMHu1cDF5OneOdUDFkpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSVPR03MB989315.namprd03.prod.outlook.com (2603:10b6:8:3ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:56:32 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:56:31 +0000
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
Subject: [PATCH v4 0/9] SoCFPGA: Update Boot Support for Stratix10 in U-Boot
Date: Fri,  5 Jun 2026 09:54:54 +0800
Message-ID: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSVPR03MB989315:EE_
X-MS-Office365-Filtering-Correlation-Id: a2998efe-2c4d-4698-8e56-08dec2a5aa4a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|6133799003|11063799006|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: Z5MPEwF6c4kWUWtLqJYf81DtW3gMoRM3J7KevbPxXQB+L0KyvpeB1bPvINAvdpWtFFRn2DbXavrD1jAoDZQ3XWDl/mF3ym8wp4dNdBOtOn1gjCcsopl6SQctcSbdGrCZuR6tGllGbN8dkfo2wN2RRxGIiqNdMnjpkJGV0aSw0Ph4ik3wrfJa1Vi2hm/VKprzFCmTJpWszC5h8hzFIrcmBbPBUZRe9V3SJZhepFWos1GEpgfCS9AIoz98pEBbIDa0bhM/UZ8QfdCWRtzQXiwqENi2vzxgy28aBWXM3ZOrfQV2kHm3n2rlUUTM4GcYPMw5lklewoplEP8VBhYkb6u93KoaSDldFVUzCXs3kjch94z3mvIxe0VmXYEPtboeicgDGtO+eG40g1sfDMpzVY58ePJwKWScXxazDJhzis3fj+vScXVZygRB5tkFEpapwlikzRpVTVa2JSBYYTc+VCVRyW7yVYTVf8koq9fQn+/fhpeTTa4OJ3F3ZOQiZ7QqcZwOHsWbD27Sp7H0BTehyF85DChfI+p+DDq/eZCQ20ZYUTgxne1nY/Leo8GI2dyyDLsLOGtYOcvy07uRu/rXxtg9L2iKP/evVAx9RKCcEIWATR02leLC5STy/tst+KHIFnPvuMzn3x17/8pbRjSvqfbmmPIuGzLF3pIjJiDJqbECcU3RwjeGkqyZVHM5Jd/Mt+Ya
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0hwO0NhqZsJ9npiLEMibwUReLDjyS/5Wf3gt213y1LEZAXGh6A7MkfV4/WXO?=
 =?us-ascii?Q?dysMT08NER0p4l0M5uoacfQTc8nm3kjQVnaYUF6BDNCzBeUMi05a/uKi0gA1?=
 =?us-ascii?Q?Kis6QJe+euEIJzZgvEooLByY81G2/4Cu/IQMQ7OUvumKmJ/equtP9xwDkzRz?=
 =?us-ascii?Q?qtHp96WL+6cf41SEWzTgp4hAoSshhV90ZgS6hgO5ejrZuLgEt+I39TiBRFPy?=
 =?us-ascii?Q?Y0JQFr+RDGgiT/or8uPs7Cgct9BGV8OIGn7WQybjtZeJZAd7+S/1IEHT8hPB?=
 =?us-ascii?Q?pqrwjIPdrOM6oy/uYWu62AgTCjX18p6QAro8a8AZbQEnOrLBF+L49eUH4Vuk?=
 =?us-ascii?Q?D9zl/YSI5xx/6TK7lrpZNJWjA0l3pqCa/nuFgQqsdXEPN7DCW+OYaVugXQ7J?=
 =?us-ascii?Q?JbAnhP9+p6HYqAWGbSdQg8lohXk0/zi9cAFA2ASV0TxVEnODTbXj0wma2fbP?=
 =?us-ascii?Q?ILc6Pg4j1ASTSa5wXiUfBx7F+ou2xu9NPuRh69TTdKFH64cOhacnDNi3cniT?=
 =?us-ascii?Q?H1tRzFk6nGHM7G+ch5Uy0j/r+1qlZS/F8hzZ/1LXx0rT9NG6NDFc7zzou6DE?=
 =?us-ascii?Q?TSunCGvg1fEtvE0R0cNl/ig+gJtvWTyZSwY2ihSKHhnighRl14vndCox6DuD?=
 =?us-ascii?Q?8/h9KFQGL/JV34Pvr0sOuBVQNgnkwTuvTLzNKZJyGj8oD6l/+0wQ6pnJhlie?=
 =?us-ascii?Q?Nn7Y14xxmgoxzSpqELbk7fhqd7xWYzH1c/Q78hO0VxSEuRUK+eIDcxe3ZDBM?=
 =?us-ascii?Q?zhZtHp/Jdp7FNcl83JaIC/IOhyZ7y4ONvME1vHuhp3rWkkEpCE62ZdYiz3Vf?=
 =?us-ascii?Q?h09E8FQ+yTN3RU1eAWyzVQ3A7Rv/zKyOUTNcHHdR8JBHeVZJu7zNwRcvGgKo?=
 =?us-ascii?Q?Ul8/WBqNDB3F9WPpqp0Zb1cS51kWdHA3JR0FcPnuCZ4Wr3qQ2td29RqVP4IZ?=
 =?us-ascii?Q?n9QT6E8tIaVSfBpA19165C/DqjjKJ0DgrK9t6bcRKUv0SlZLaKkwQdOSUKLk?=
 =?us-ascii?Q?g30vPNmIFe34XDiUTSsswxkcy+guiBQbXOve9TASeVoidsfpcyecE+ttEqnB?=
 =?us-ascii?Q?Uehxfnd7leU2y+imMifKej5desS2P/GNvyfdRRppSUTNm6oPtyqWpOV5I9G6?=
 =?us-ascii?Q?SZfmhfDQa1msVX7MlgB6yoMIwIevfAiZfQH/Ump0jMxTTgyp47YHtgIYzUk3?=
 =?us-ascii?Q?B7btBp0NFrP5VfKyNIFfGkDLYeo7DS3s0hSaT/XjYv3Hdkw3M5OD40aquTTh?=
 =?us-ascii?Q?EuoTkMFPlRvQUkHIBlgW9MJ65k0QCeAqQMQD9IsJB0BO1TsyH+FzUXBF/OVu?=
 =?us-ascii?Q?L/L8XbrjTfogYJYNIqxPMv6QxAnwlfD+S0kCTQBPFxzuJSStcFjVhGafVpQT?=
 =?us-ascii?Q?/xW0bYILA8wdiUAdnVYJQepdQAFskoZaW8em5ddwk4DM9tlehfa9gUbpZoze?=
 =?us-ascii?Q?LXZu4XxqPdgc/cpPLj7LOUgMjewA35FCuOHp+MIF+GBE69dn0FOSdGDmbUFI?=
 =?us-ascii?Q?EYQdjPD01MXZMPn8dIZdaR/uVUtxHfZECPQ4hLJrPYCFEllgzvK4Qt/3S5Mm?=
 =?us-ascii?Q?ChG62qpXdr+Njc2TFsroikOvvummig7Hs/XH3Ioi6rqC+oJUFTjOKuOGXJbC?=
 =?us-ascii?Q?JneqK58RQ+IH9+LLBMdDbErM9pvNORgFH+M4/XKtmGsN06xxMOUNZc+fY9I+?=
 =?us-ascii?Q?i8DTzHuOjJoI8Cc0+Sdu+l1InWK3IMLMgb1kdF+g6gwo4FXP6QBBjbYLYg0s?=
 =?us-ascii?Q?uKgHKTFFIknzEJIOMBUsai9YOkQfgpI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2998efe-2c4d-4698-8e56-08dec2a5aa4a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:56:31.9150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RefMZDNTCrUy3QayKnx47u8lBrhNORS/9VzU+77IC1j14jQkZPLKspsExsZ2EFt7OSUO6n9KAoG7J8NdvQvXRx3XjpPLcliu9SCCowqLGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989315
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

Changes in v4:
- Commit message improvement
- Update reset_flag() weak function to take in u32 flag parameter

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

base-commit: 3990ccf24bb4be58338b11bcefe26a9888b5d916
branch: master_s10_v4
