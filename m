Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9309EFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF4A84106;
	Tue, 28 Apr 2026 05:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PTC0VoE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21EE1842CE; Tue, 28 Apr 2026 05:48:35 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F8483A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFC1/+OHSX53dVIGKs3oxs1EZ/GzerBntPKF47d/73HCdtHMuSA06Q5xtgrVCwLnhd/wBH7rjb1gs5NbVxVAg36OYJpocl4ZScOv9vEbl2VrQnWJ36ngUIdAnv7jZ0c2l4eSK18NsrQ150f3struoaP2S1zLkr8Y3fnfRnDJkhjhKo7FfUoOXWUcIGGzpyliW2XFDj92P0Chd1jzd8ODnVK6KeYrbnWp7FaKP3hBZ69NNSz2lKB9kFgDyZ4vAIz6j8eWUDYHcZ9jBofX2FyPpNgHr3soCYZaXrAmEv/uNv781tao1HA8XG0yEa0PRnvFyYvnJYc4pdhXMlPK1tg98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhi+o+tpn1ujQie3aVvbHzNTlpHrHqmfcpUV3Ba20dE=;
 b=oTDaxCtcIDQB5aWjzFjXU6sbKg6k+HKiPeh7yoxNq1XEvk6iB7MQ8hR+/tI/L2aronRz1bCHtqmC9yfh4u/1wkpnbBfINPNKBbF4ismrquKsXsGo/cZb+gyd3IR7LfQqtTLVamOrBV3ijeSUFeiWyQwrbXKgh9XmHjFI2HKKvbXKzUIL3OXd2UJdE6fh6Y3BpnE6dX6LoeDJZAJfzDrKGvH0nMAh43gj0aGgQebBjccRTJN2nYQv70sVIpAqNAobQgcJFxb8lh92XmFoc4kAtWbYaGxiCFdt1DZdVOrsBmYh2krWI2Rs3sYENdR/OVqW0E6ORQOiVsfxWRxvalbKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhi+o+tpn1ujQie3aVvbHzNTlpHrHqmfcpUV3Ba20dE=;
 b=PTC0VoE5KsbUPq8AKrAMJlpgKLT8+gp48ugrLBNkwnf5q0ZpBCf4iS/Q903edzwps7JkESB4EkCplzsUSog1R94FmfLfLVERxGqCotNFZWPVR9fQuAO6eOelsCua51wR/xSx+ZHrtMjDGaZ+cczLOgI+5Anm60Puezxs1R2zEd05I/UIi9wtPbTUrtusttSZFqpyEX95EmNpEH01Rxuf8b+MEbRx4mkWzKFv6M0t4TtPa9+M7UiV47ZdZMpTgXtDLCKea4xY+BXsDljfAK4PT+7/fcnA3hjXz6GnvtT6vzeqaNgAXIQF01eybSpVe+64SzgfBEd9xrFPkmQXEhAkYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ2PR03MB7403.namprd03.prod.outlook.com (2603:10b6:a03:55a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:48:26 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:48:26 +0000
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
Subject: [PATCH v2 0/9] SoCFPGA: Update Boot Support for Stratix10 in U-Boot
Date: Mon, 27 Apr 2026 20:48:13 -0700
Message-ID: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ2PR03MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 573e2dda-cf30-470c-8c67-08dea4d90086
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: /EJxlbScHplF/Ohr/86ew3pgA3l2lI1Q8k81Li7+LU0M38obnpiDaKq0DhYwBgccnMPKURZ9BnzwuHAYBenxTw24DXRC9maVHzK4mn1m+hFEq1HeTFWNLw0l6HwZsx/KNPAppGKgz5WsS38p+utnjsrVHHMAEZnqFq8ruKomaeedK9DxCFUaysa1SW29jIFpkB0vts3pvgDfPO/qCJYATmh2NFkRXsLbkRmYo4uGANH3eTeb9CEPMZ4051N20T3q7JRvKdl3oqoNsqsruF2iMapXbUAh32sWVKXY7rdiNtmHCdMibqP9A6Zz2vWUewTF/xKYW7AWnFPQ8xk7qdkVHFSfuwpgG3JpstGpGCCYO0OEQ8sWbwnoDt2b/EtSBt4Xr8PhRWySTuMeyA+Z9d4vcIzxQg5XYGUyj2nI6h2P/HBGSE7N9SfgwHnQw/V1Fit5Wpc6s7RZlXNtxna8I35vgjrU1sjTAd9nEYNGrjBVUb8w9B4cAl5FL/9a3j/Dp7lzBNdkS+8DFhe917wc9/jGw5Tuz+1F9TecO4wWmunB7wB1oBCvDamLSOoexbHO2Lhz6WTJlUR+Mv9RJuvINzm8KwA+FMYGw3NFLSZuyZozCxZmxc4X9j/ryHJyImMfi29T6Dnn8LboUqSJa+7mIqEdfEffX8jmtqzGbtyEI0epgLP4967ZG/M7do8aYJ0dxcxJ8g2dBHM2kiFnKG2WeSq7ahLsZJQzHMKg6EePiR+JzY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5wSPydseWhPWVMWkG8UhpMAtyPLSVOvReUJ38mHcJ0O6qfaDZg6gVh9YToei?=
 =?us-ascii?Q?jTqPgvvEX9cEhgKZBbiWrgNTSuOCUsCLEf7PkfB0W0HZqspE/R5m3EXc6iIW?=
 =?us-ascii?Q?cdPfo73G7nqtIottCx/VEpjXAZhAirjC5V6d31NKXxJhs8pcdHrytNhQgzPp?=
 =?us-ascii?Q?+CTVkJHVandiVNOu0HR0iHKG2VarWGTtPEJX1+WAy5jfZ2eZ+45iN+4Gvdsl?=
 =?us-ascii?Q?yY+OvFQw6jgdLEx+TXJcEG8qAPcdpEfi3cstiTxtf9G8PIjQNwrODOGseTjg?=
 =?us-ascii?Q?qw65OZB42CpRa2ArSF/g/kZSFG6fJ+NJpck81be2RBirhNNiSaT1q8iJT+wq?=
 =?us-ascii?Q?NkrvAvbVE1UFoxvmJ+VQ4iWL/7nXAR38zboIwBOX6TSrVX78os8Se7cfL+aQ?=
 =?us-ascii?Q?x3/ffLspbL3yLoEWk7qAdBi3zu/u9Vj/3fdNYoomQZhNTYEHwH3GVMAHpXHO?=
 =?us-ascii?Q?z3NBgfqHzXdll9i8fZKLa96rvIpDjCDwA84RKPxNIZRyUtx+dcIIp/5xcaju?=
 =?us-ascii?Q?uQrTNDUUnmVDNPw3lGBApmQvDDSxCfSLKea7bmGVxR5OKr37J9bHGKAUfiy9?=
 =?us-ascii?Q?jWuLNAneZNZGKpT8Qoe1cZEam3NiSQaY4ctFttg86XKGtflIy/0qG9EQApND?=
 =?us-ascii?Q?o6t1/2/ZUBgwUQ15JwLlCXkHBW6q+Rpc3TGhZ5FkRs07k/N3F8s9x/0TF2aG?=
 =?us-ascii?Q?3GzMLUs94CTb5CF1UXSdOrbgkDjlaKJUJPNtV3varOPAslEOEt+9rfPS//vm?=
 =?us-ascii?Q?DcMjwdfSft3nyYBljwG6HmzY20EOIr6Oq2EPr51J+zp8kxRsBY+nFGGXYkPG?=
 =?us-ascii?Q?dsci4EwplyShym23Jo0V0gCe2NLoMG32ctsIx/rU9CyoZhD1sNO7TmT/Upah?=
 =?us-ascii?Q?UwWaLafsQT+ga/CuYqFMgrCEuYJg6oTUcBMbKKY8l+ZSgSXC22CqOKv0LboZ?=
 =?us-ascii?Q?egeuZTZZnEGR3lCC8QY3aimce4sG5XFiu/7OTxTdNz482bRmGb7AUAGbIU+0?=
 =?us-ascii?Q?rxreo9bupzS2ZCcKzpRRSu5wSD/jj+g7e/aP1Z3aOcevQ61YesYtkWTLnNOT?=
 =?us-ascii?Q?tdBj9xS+8/hJX45eG0xlaNtllEx0S5RpkwhZwcltZQNPqSatQCRy3mMjxMgY?=
 =?us-ascii?Q?oMa3kcMNdkgXOtIOXjV1cmz7H8sBW1059tfMGGKx/0c3TLHTqwmhZ5nqvmMv?=
 =?us-ascii?Q?3EI1A0RvONI7zOig7fO2AChRITWsXeA40rK8Wjw7GUw6NiuGswfqCQKeWOiV?=
 =?us-ascii?Q?s8+wcySFLLDATrgOsYd9GEcDqtL9fj+DvGey4WBwDhSx6LLNDkCddMZPsJcq?=
 =?us-ascii?Q?DE0tdW6bihx8MUf7aDhnSLWS9O6KVgoAyctmiRNy4pE4Vdq5KxSTvtcLerD/?=
 =?us-ascii?Q?00F7SOEUiEC+C60Xph4uyJI4B+OI7wFYALkWQd3okmcneJSewsbcthUsofdg?=
 =?us-ascii?Q?9qHoNcU+el8llyuDjP0no4Cv30o1no27p37wg22MJpGRKwOIe5b3HJDuK5s/?=
 =?us-ascii?Q?jVIH9gnG+zPVj1jG9Vwmlg8zOg6+EFsmpfw2AHZLJSLV/tBctm/NuiyWCyTM?=
 =?us-ascii?Q?RTwz1Ro1YZ560b9XO0p7LjAUxHP4KmsAq0LyViiwhCiS4on3NFJ6yHjS257q?=
 =?us-ascii?Q?sQPuXfOMtigSKaoAA7xFRCMYJSMp96QRjmlToCzRr3dlIwt+mxmbnaLXPrHF?=
 =?us-ascii?Q?wQAl7wdXwjYbX5JsFQ+f/cdyCgoM9bwvtSEdHHCyZ5Lum9k2470sZsnXLekF?=
 =?us-ascii?Q?V9GNimqS2Fbrh3PTHttDvyV6upw/CA0w5LYpkAmoPHfjZYdKMi3i?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573e2dda-cf30-470c-8c67-08dea4d90086
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:48:26.4616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbGelEkDsjUY7vkzSVnc8NV3u35GeBTdXbA/1u81fz7wnfsoXoHC71y3DN4LDTtX2bigU2Kc6EtQC12mXesLAHOVTK7m8u2pSLBziB6lnWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7403
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

v1->v2:
--------
Patch 1
- Cleaned up git merge artifact
- Cleaned up cdns,read-delay parameter for spi node
- Cleaned up duplicated /delete-node/ kernel in binman node

Patch 7
- Implement using real hardware clock source frequency following Agilex clock driver

Patch 9
- Commit message improvement

History:
--------
[v1]: https://patchwork.ozlabs.org/project/uboot/cover/20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com/

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
 arch/arm/dts/socfpga_stratix10.dtsi           | 430 -------------
 .../dts/socfpga_stratix10_socdk-u-boot.dtsi   | 143 ++++-
 arch/arm/dts/socfpga_stratix10_socdk.dts      | 143 -----
 arch/arm/mach-socfpga/Kconfig                 |   2 +
 arch/arm/mach-socfpga/Makefile                |   1 +
 arch/arm/mach-socfpga/clock_manager_s10.c     | 449 ++-----------
 .../include/mach/clock_manager_s10.h          | 176 +----
 arch/arm/mach-socfpga/misc.c                  |   6 +-
 arch/arm/mach-socfpga/spl_s10.c               |  70 +-
 board/altera/stratix10-socdk/Makefile         |   7 +
 board/altera/stratix10-socdk/socfpga.c        |  12 +
 configs/socfpga_stratix10_atf_defconfig       |  90 ---
 configs/socfpga_stratix10_defconfig           | 103 +--
 drivers/clk/altera/Makefile                   |   1 +
 drivers/clk/altera/clk-s10.c                  | 603 ++++++++++++++++++
 drivers/clk/altera/clk-s10.h                  | 202 ++++++
 drivers/ddr/altera/sdram_s10.c                |  60 +-
 drivers/mmc/socfpga_dw_mmc.c                  |   6 +-
 21 files changed, 1444 insertions(+), 1378 deletions(-)
 delete mode 100644 arch/arm/dts/socfpga_stratix10.dtsi
 delete mode 100644 arch/arm/dts/socfpga_stratix10_socdk.dts
 create mode 100644 board/altera/stratix10-socdk/Makefile
 create mode 100644 board/altera/stratix10-socdk/socfpga.c
 delete mode 100644 configs/socfpga_stratix10_atf_defconfig
 create mode 100644 drivers/clk/altera/clk-s10.c
 create mode 100644 drivers/clk/altera/clk-s10.h

-- 
2.43.7

