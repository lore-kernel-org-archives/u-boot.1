Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B36D73087
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 02:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA448382A;
	Fri,  3 Apr 2026 04:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LSH/G1Ux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C613839DF; Fri,  3 Apr 2026 04:25:43 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE0F83693
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 04:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptjJCtvW4xaRroOTJ6PqTGHWHZHYSZA9PosgBRyPn6KoV1P6qo+pdzu9hsa08Rbi4UpPmq+vgyzrcTCBA/aXyDCNwAEqM3godzRPHHJrXaHGMK3bxdQmtM/1+VH1NSymDiAsR5vN+cclbhnY40vQ/O8eUn+CWftcVnsg2GU7EfzR/KS0rnuDT0e2PJaNhFghYUmp3obvUHj5PDy1TjXGQWqv8/TiIrqx6lyLT7I3+bzoeqNX2kKi1lkUV7QmNWHBicX6T07tFs6X8ZS+j4FnNBYF3oFbYHeIrdfg2JuRx0cd7rQiMNXiLa1jvGjq3XRIzTJBtV+d0tHwuVZe3Rg+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kp5Hb+zoP6angejSVZUig4kuiPG/aleEd69ekasPyqE=;
 b=oTa2BgxMcB8u1JN2vs9bKA8LQW+eFGqoNFjfbqvtoGmiiX2r8XkypGi0YAHKwM/8OSYq+Wh4Mwpn6Bt9BK7hydFo5qgzqWtwLiNDtnetvvdfIidOcw41iE5kZ4vl8e2TvzIyRT+X+jkroAS+QKLVE2SKmPK5cOcKiKLnj+a2ZarVStTfxad2wootRlBziE51vN2zTITpcajr6qhwBA0/cp2RHGbKBN1JSwhj3FWal4HHTNpMJqapvWHca9wRLCYji0HSAPuxYH6ZmQOFEuTzXq9daCa4gML+KeJ6mxXCEXdKP8uNtJlP/vsPYLPc38JEhmrBRqt5Z5Xo0YTD+vK79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp5Hb+zoP6angejSVZUig4kuiPG/aleEd69ekasPyqE=;
 b=LSH/G1UxVtSvu/er+7bCP1QQFmI+8QnphoxphQrUHBtvKGb013xktZwEuAD2A/kc6tjY/Ofn/K3Uy9sl1PkEuhnmxxXXJhXr/l5m/8w9OAeyxrZ0yyZ3juFrroFeDjrGUh26dfoeOlCeLuVatJO5bwRSMX5WM+YyE1d5fnPqx0nWr7wwuEZ2adnfNP6Nna233Z2vfV1bbHnf072xRnnVHrjUjCDYgvWDJc6qB6rXEeWAX3dyyTFeKCZzVGnmSR1NiGp0/vhxrigWJXdys8JadGSNB62kh+5M7ZLQMiOqiatb1NCujGy06/I+wloPqXg9D5kSJ28DY5PkS04FuGQPbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB5421.namprd03.prod.outlook.com (2603:10b6:a03:289::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 02:25:37 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9745.025; Fri, 3 Apr 2026
 02:25:37 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 0/9] SoCFPGA: Update Boot Support for Stratix10 in U-Boot
Date: Thu,  2 Apr 2026 19:25:04 -0700
Message-ID: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB5421:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be0c21c-543c-44bd-e891-08de91284adf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|55112099003; 
X-Microsoft-Antispam-Message-Info: GIkcXzYBaSz2SoaK6894Jq40AbueakhspXiP3636w/PZyqlyi78G2HinZDYeKpf5cVEyC0nk10Xe629ovS/1Pga+zyfX65nNWLI3kqILrMhFNIyOXqWUedV09Ar4HUw4lEE8GZboRGKahWmK21NZ9QS5idrvIGzf13nhKsGB8u9kERCiZajAKn/nx8Bi73eg60h+Np1pPLwjY2BWYZGXMxlPz0SJHiHlRoc0k8v5M/w8CZmZ9RC+OxWhQRIS4hh4vVQ267eMv8eQipr6lXzxwG0D0p69wwd+3Bap7s6H8PUpJGvISInj02QQovuoVOILAeHH68O2s8c9mNualZKfRDaY4rAzey1Xm3Se2al4EA4cPoaQcYG7B5kpTadBk6kqhfsuZqPTx6U3adf8q/8SoHq7cXWjSZJbqnBdHOa/ORCFfGA6hh2CD5mwjSEuAEGUaSzaKrzhFeovMO+Ktqvd1Qu7ldgY+nDwnR6jEEV6AE6Ka5YovecdGymc8Kj5m4p6VpUiQWXU4kbEygdcQUl7pR6dRfqLmjdWnb8AhTXH99YZQKaEnGFOIZnLDHM9vQZQmY48bAN4HqEnXqpekwuVgm2D3d93iPy++PTqqe7P83z5412uR0BDQEGWV0S1g0pYU5knkRxSr6d2lbHdi8DrgUSYjPn5mfFsNKXLekeKm9Tgi7LH7HgjnPC6C5Lb8RV4RYAejeBvGWfQUgP3x+v+R3Ir7647DIKtscN43Hb6jnQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vl5pqRpaDGXoSK6eCQhhovcnyFwNYlryqNrNYk8TDiHwPzcHmZN60sQxxibH?=
 =?us-ascii?Q?1aWNonIMZFnFxHnTL0matXpxuzD8Rit37FkdqcRrov9syMtZUgOjEhtzimGJ?=
 =?us-ascii?Q?vgR/uK2Laqj/Rpstpn7uZNoEyPhBdO4nU8YRyzO+pURPXRZ7k4tOBcZeu/1J?=
 =?us-ascii?Q?9KXCHH4appj2UtiEDElWdNGvF3VvyQxq1QfefF95RTUYupiDYsZCzWWPPgZW?=
 =?us-ascii?Q?pGcXYplB27Yx+uVOMgqDWQ38Rh5Qz/AhB9PgBqS3okR3GTNXbENBG8z7u19O?=
 =?us-ascii?Q?qRbBf6eP6d+pD6aVm12Y0m31fT/3d4Kw53VjAA5A5CnslWeUAYHAA5jUQq1D?=
 =?us-ascii?Q?oQyCW92wa6iSjP/83utcx91YUywWmVgV9J5iWYi4MW/+purPSIevgwzn7+rG?=
 =?us-ascii?Q?rr0Q5xQBhDocfhm3NaCdqCFxVJra1N97CnUf1EAT48m7wHVD1TGlXwnqjn/F?=
 =?us-ascii?Q?AF/chDSTew4N9As4dF/ux7Dac5sMyAuwP29SUJ2Wd4TEgaR292ci1L0ZN4d/?=
 =?us-ascii?Q?CTP3gtSLQf0aVrVDHu46ICG6J+Ab5BkuRivCtfLppTBkjk+l7UMJLUFSxWdu?=
 =?us-ascii?Q?HzPwZDOxXh/9nOn2rQ62HP2/KgBqusatLoTaHGbX/86EMWRRlbDbgriWtg+l?=
 =?us-ascii?Q?zUwQifFM+qoppeu2+HWTOGhHish1dmmZ2rrkrl1q5L44Mtd6C63MJwEF7Od5?=
 =?us-ascii?Q?qXU/nogG/dWeBair3HoAR9YOr+78I7aKOdx/LBpMQlZ1V+g42a2e0p+Sa46T?=
 =?us-ascii?Q?S/xiFDFtahbU2ZU8Dy9DxOIOgud5109mJ8GCtlLAYFt0huLiq3RnFOi9CD3B?=
 =?us-ascii?Q?1eB2BZO73bbQbWRlpXYaBjwdab2TMxlkr+qc1qnW48bF3PEUdHyJwLjjDIsN?=
 =?us-ascii?Q?lf2PKFxpAypMj/SJev33BBEVmnzAVINgS2of29X9bQsEnhHbIqEsQFOReCGY?=
 =?us-ascii?Q?wYEAtEllXoc1KPuXfTzSOmc1wil45t+ThIQ3y/zwlesup5udiHMzaOQZ1MP4?=
 =?us-ascii?Q?mDqBz90AaNuI/b3yFLZbahg+MAYSW1Xu3YaL505b4JTqgd51ufhFD7ZPl9yI?=
 =?us-ascii?Q?uhDP9t19NlVA5HSw6yVA/gOXLg8AK5EpBqmI9gcorb+0nCJvitcECiCip4QS?=
 =?us-ascii?Q?IclU+/bmmGl+cLUUujg9rK+WEyRW+l+NsFOeuD059JUBJib6M6Gh+zReKN2w?=
 =?us-ascii?Q?iYwFa2bQMw+OeOoXGS4HOqGsEEzIIXIWjpBD1powQ4hLzHn7N1ISJNmSN/i5?=
 =?us-ascii?Q?PZqhMPeLyZDQxWs5vKLib6S9hAz8zo4fZ7Ck5blAP2u9WGiKhLGXP37Cz3rP?=
 =?us-ascii?Q?mpZDE5s4u64asgb5WBuVTgeysOFlBksHl1qYlw++kNHluIk0qFDkNn6bJVUJ?=
 =?us-ascii?Q?CdZ1KlEkMyeHDCnr0VyPaiHln+Re9SQ+g9hiEBW1864sK/Rp/qDybwuxgUwD?=
 =?us-ascii?Q?1DbJ0qs2UMrpyDUFWxFz41OExt3IbJT0VLnsMiiRhNDcdhXQgTTjFSzRs82S?=
 =?us-ascii?Q?LDJqz20pX9Y6fZBC+ygJ9swkwirc/MYZ5EaVrIAGmqljn9xV+l44pmXjke+q?=
 =?us-ascii?Q?zu15B4Krb+8GqXTwvGvDhf6ZzQAZ/eS2Ks8H0NGg9JC2rFNEovWsBv0oITPH?=
 =?us-ascii?Q?DWHWaaxynyxlMkcq74K7Z1SMiJJFA7Pc8FDKKM0yNhTu9Ods0To2W/fTURIa?=
 =?us-ascii?Q?lPJnqF3dH6xKJzbWSW4oQAlNz4d5xynx6L8iPfp78J9TnPdFt0evgN9k42dB?=
 =?us-ascii?Q?DkdoYBVFbtnRg3kiohcy0g6Y9fgvyaY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be0c21c-543c-44bd-e891-08de91284adf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 02:25:37.6301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ax/qKTgzsnCQtgmPIKEpxsOAYqWDs1tsft/PuN9t38Z1tvHfA7rz6PZtMMsD7dDcyFDyrzijaJq5vEJfnlCvu0IBJqOrvNuF57kJuh3j48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5421
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
 arch/arm/dts/socfpga_stratix10-u-boot.dtsi    | 313 ++++++++++
 arch/arm/dts/socfpga_stratix10.dtsi           | 430 -------------
 .../dts/socfpga_stratix10_socdk-u-boot.dtsi   | 149 ++++-
 arch/arm/dts/socfpga_stratix10_socdk.dts      | 143 -----
 arch/arm/mach-socfpga/Kconfig                 |   2 +
 arch/arm/mach-socfpga/Makefile                |   1 +
 arch/arm/mach-socfpga/clock_manager_s10.c     | 449 ++-----------
 .../include/mach/clock_manager_s10.h          | 176 +-----
 arch/arm/mach-socfpga/misc.c                  |   6 +-
 arch/arm/mach-socfpga/spl_s10.c               |  70 ++-
 board/altera/stratix10-socdk/Makefile         |   7 +
 board/altera/stratix10-socdk/socfpga.c        |  12 +
 configs/socfpga_stratix10_atf_defconfig       |  90 ---
 configs/socfpga_stratix10_defconfig           | 103 +--
 drivers/clk/altera/Makefile                   |   1 +
 drivers/clk/altera/clk-s10.c                  | 591 ++++++++++++++++++
 drivers/clk/altera/clk-s10.h                  | 202 ++++++
 drivers/ddr/altera/sdram_s10.c                |  60 +-
 drivers/mmc/socfpga_dw_mmc.c                  |   6 +-
 21 files changed, 1438 insertions(+), 1378 deletions(-)
 delete mode 100644 arch/arm/dts/socfpga_stratix10.dtsi
 delete mode 100644 arch/arm/dts/socfpga_stratix10_socdk.dts
 create mode 100644 board/altera/stratix10-socdk/Makefile
 create mode 100644 board/altera/stratix10-socdk/socfpga.c
 delete mode 100644 configs/socfpga_stratix10_atf_defconfig
 create mode 100644 drivers/clk/altera/clk-s10.c
 create mode 100644 drivers/clk/altera/clk-s10.h

-- 
2.43.7

