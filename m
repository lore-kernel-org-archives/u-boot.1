Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734CCCDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 18:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D66ED84894;
	Thu, 25 Jun 2026 20:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Rbul9b5o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FCAD8495B; Thu, 25 Jun 2026 20:09:02 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73B23847C8
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 20:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfd+VDfN/8TtLwuueLq2KuNecZNiNjNWbkSUxhXpfHqnBc+TqdUBO5FCiLbjH1XAtroka2txKIgRk9Pq/8teRJXl1ie2O6IAmwRRblnp/KahFIJifGO67Pw6DFmw4kbKVJO+jq73ef9KdNqvvmd7aAlkYtTMNEBl5ke1bRd0mxS+lb2hTd7RuV/UqVMTSRuS5jRQOxe6ztpw60jFR6gUHvAs0ZKlkN/tbAekr1OvNSHORwgzsn1Go5NQILxCsyZAL2YM7zZfdgiba6TiZ3ZfOpBXvpeM63mcK2qOwVjhkP1LlpkHR0AUBrUWfSeJjvcAm5YNaWEqlg24VXv/0FscNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu5ZNkgJ9tuCOKS0zM+DrsZ4lhAs0GgHcbE44Vc0QFI=;
 b=uot0sVZYpJdn9A4dupDQmCGABs4KkqE+9Chw2D2kj3B9boEg89T9uwUZpin8kUU4XeP8UgCv8EY/hVwGjKYxz1HNTE03NazRSHQE4vYdhX5JGggdj92d+uB5hDjyHScqrQyP+5ObxfVGYovZ4TDDvxgiWTKpmC0wWnTro0+1zL7EMTeJp16EwTxMnugfYtte3oxgFQGRWog5zgooKb/71rUA0yAL1qOWIL+0WRkqAz/F899cOfpJIOPrKnWFSA8d+DPTVGUgccGvtKCyJZ25U2Xko40wVuHAuW2YvOtCl0iW6v25QkvYb8fNudgKdO8lCOIa2VEnxugSfqIFOsThKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu5ZNkgJ9tuCOKS0zM+DrsZ4lhAs0GgHcbE44Vc0QFI=;
 b=Rbul9b5oTo0L8J32HQmbJGqf/MJZIrzrG0vlP0ZMw0fCa0a2VMtzvThukuwHba6+rxb9K2T63zPd5t/OP/uEf0T2geg+3DcAdAh33D73ufujrmSow5WZZoiJ/cxPmakVZmS9UPQxLhZYi3pZMGZSyoKBNhDs13VWNx7P6H6NVE9obxJF2KElwRnCaOkhKY8gzP0ivT16vRQGE68Bf+i15rzXdfFlzSVhCZDLFs5qwBBT/O8uCnJlFy9rEF688n2uWYQXh74++FTosSBwe9luCd/w/fVxdkd+ANjn16DyCFa08zmeZ33a529UoFwdBO1fnaU2sU6w+2uXK2D7Ghe0DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SN7PR03MB7131.namprd03.prod.outlook.com (2603:10b6:806:322::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 18:08:54 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 18:08:54 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: [PATCH 0/4] arm: socfpga: Add Arria 10 SoCDK QSPI and NAND board
 variants
Date: Fri, 26 Jun 2026 02:08:22 +0800
Message-Id: <cover.1782410782.git.dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SN7PR03MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e08bee-c300-4af5-ef5e-08ded2e4d182
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|11063799006|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: VKam2i4Wk4zNxuLIFteYx4V1ocjYvOiyqgV0cGsARez7l/YQemQoswfJltYqk9sHH5yyhUIrOc8hxhr5L48cncNlAQYgZtvmMBu//N7f6s3ix9BbWwyfEyEk7xtKVeHPI0yLR1UQHA+X1e6BuuIORhJeo/ZCGZ5/7b1odQJAJEegMgu7xYfcm/+zVAgKOIjq7Ovuw2YAq9ZMvnlBTGXG0K3JFMNdCasQA52N07CgVeKmXaf+qGQlhu5PwYKsCGjvJjtVwulkNZE/+vc+e3Q8XnFgJT4/fkpWTIB9QJrJ6VPcx3tMPxN8kPHccI7/vA01tbPiCQCmkSB/PC19qm2Vr1CmEx65uaJMT/atqDa1jNfuRzkeoRxFGifI5YDb2B0hk+ut5IzeSAje72HLsVF82QunHdbEy7tZP9pBQ9ccgPupFYDk9CW75jvXfbBST6KOnqUBtsD1RXpmjXSyC/dMH11ei1w/0+ldRy0xNiKfWtcRwrNkrykcD9ogKvHrltXK61p3GvO6Eac9Ix+LgKH9Psu+y39Jbu0PSLUBHOi8l8F/xW6LePdq47DHEDYZDlbrohFj+iPVkYysGGFn7MxLDlC6VBvQwawpJhwj8WmSldyPpB0yRF1Ixwn/LQ3FAOh7/wuRmys5jGlTscFMF8xirE/5Lhxo1+bQ3Tyq36ITLc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(11063799006)(56012099006)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kcz2KPL5WmSJ+ZEN1vk8xa3VqUc4ge+8dpP2Zx9TyqS7RgdMz8kvAdHryqRS?=
 =?us-ascii?Q?KVjg3B8e1DlhQarsoQhsjoSmNMXiiRLiJrSG3nnQw8F8/Uzo3kODq6jal2uu?=
 =?us-ascii?Q?uag73RyjAha26WUau9lEVcRflVh7RiL+5tuoX6Btuufal5NsudVJ8ydLw7Oo?=
 =?us-ascii?Q?Cxtlp0f1e7j/+GEmGdIXaFtIJXNY58BOFMmkBK4rvGhctHYgrTqrC/MQ3dzu?=
 =?us-ascii?Q?uVL/o4Ek3pTYecyHd75FpgXcXjMCgdlmnyitCQ6/xBCd0RaSY8k5w8h9NGHr?=
 =?us-ascii?Q?BtAT481sbsDnwsIqk9yKlZQyMf3gEKRldgcePTepqypBIPuJO+Im2ZTwSyV4?=
 =?us-ascii?Q?HP14+DkA3nRMEJiyG8Bvy6aTHA9niMAWxIgVRVy+s7ERqJAEWdrj3kdi8DOG?=
 =?us-ascii?Q?R2NraXZfR21nfT+Cq1y+OYc3UV5HZPmAdXrKfGqDh3p24+g4V/wzOrs/SwuZ?=
 =?us-ascii?Q?fXxecAQTT0b93opFm/IC65y3iL3tTCeOXUtEqiKEvy9TMgC+TFtg2DjUPtr0?=
 =?us-ascii?Q?qCiS5fTRWkG9AQGlwhfPyjK5WSxzClVr/2zH78TWOb0OtMCrn2U3OQw8d84x?=
 =?us-ascii?Q?0DvoevBUuTdFgXnOb/hvaLcmtflWQks1NxDj203fV+gSL+XJCeq2fKPlUtYG?=
 =?us-ascii?Q?iCdhJVr1RyDPpKIXt9JoYCR87sCio8l77JKdT12Jp2MoRUco8VT+ec/mgcq4?=
 =?us-ascii?Q?kplhLpuFavoDXO810LCHrq1nACRPZGGvkqPWqH7DpdGLFYHS+c2SYqmXObzI?=
 =?us-ascii?Q?UWuOep3EI5O91XjjK0Er/y9fzZn6S1GJ8uaP63211+nGLhc+LuwC/dKkwEAf?=
 =?us-ascii?Q?T5u8oTrigcJXU8OZx4LDprs9B1gs0iaNgPM/GEQ31bPJuyYhXd0aEw1bYRI5?=
 =?us-ascii?Q?9vzWIGKjPxojq+UHZsEYommotvoH2NOoK+WEC4aSAhi0whLPQJBeW7cNC5sj?=
 =?us-ascii?Q?oxFDITEuF7gdAhfqb9N6bveT9sSVcduvTepIEBa7qxjEZ1hjgtfnPhwWrJF7?=
 =?us-ascii?Q?GOZ+nbsdCtB2f3C4tzIA2jAVckUrI3Arop0RZ3qxItqVRlrnF9DkaEWS4xJ4?=
 =?us-ascii?Q?MiIZ3bXfZdLSO3SzFbYPZImG0gdZH9cWnQjmiqwaW+eI3RlzEeCrBQEjd1fq?=
 =?us-ascii?Q?68NHddwVQte/qpl29bPI9mf2MKTmKYYdUGUC2/CL7PAAutjU9AP8WTaweUNS?=
 =?us-ascii?Q?FCMX2o7GXUvVh1gWej9EUtfwllBdNd4QBQHMdjf977d+52RbV//qnCdwnGeO?=
 =?us-ascii?Q?SdsmwOy22gGjKdACW0rUfgIEMt5i4AXD5tElaRYrgDxlyFgEJUG9fBbMKgI7?=
 =?us-ascii?Q?HQ/PdW8oueQLpg7N9KArPezBsnkvgo/3Gm0S7B5+RMn+BMgaMYnlKjSjsx7d?=
 =?us-ascii?Q?OnP+rQEuQjlihHHpawAz9+1tlKnz0bi0xKlBuRF04K27Lli5N6LhT6fw+B6W?=
 =?us-ascii?Q?SUH1QVCNbU1uwH/4BuVt4mLQDq5a6O6fWCHGVR61Fs+msSPZHP8vh1S3SPE8?=
 =?us-ascii?Q?et2fBF7aVLt+oae0DCgfcVpv+2Z7hnLZ18GuBz606TVr090VD0blcGRjagwR?=
 =?us-ascii?Q?Fv19m7yL1tvFAb8jxHi7NSVMevlAWg3QES76tNbC3YmgSBPvjBG8zRXLE6Cl?=
 =?us-ascii?Q?f6NCazuXS6iH4t9nDtnAYhDRPhrbgxAzd3yR03z6DhoEK/U876bkZEQn77P1?=
 =?us-ascii?Q?+bRYw74ZhG0JJEi3XBD05jEH7bcdot13CGid2lgPAn+gMZ1j4RB6TEr+5RFT?=
 =?us-ascii?Q?R/nfh3dez0Ri4sQczrR3Rg540tTTteY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e08bee-c300-4af5-ef5e-08ded2e4d182
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 18:08:54.5934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4K7TserBmslb+X3vIhSEQlgvT+5Qxh5FPsTX4vqyuaITzk8jqzj4viRyd6+vU0Tij5vuGvAB7FOJLo5aerxPfJV6jriUgYeCDC0bq486uFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7131
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

This series adds U-Boot support for two new Arria 10 SoCDK boot
variants (Cadence QSPI and Denali NAND) and refreshes the matching
U-Boot handoff data so the existing Arria 10 boards keep building
cleanly:

  1/4  arm: dts: socfpga: Update Arria 10 SoCDK U-Boot handoff data
       Refresh the U-Boot-only handoff dtsi and the generated headers,
       and rename the CONFIG_IO_* macros to CFG_IO_* on both the
       producer (qts-filter-a10.sh) and consumer (handoff dtsi /
       Chameleon V3 270_3 and 480_2 headers) sides so the device tree
       compiler stops emitting "Unexpected 'CONFIG_IO_*'" lexical
       errors when building the Arria 10 SoCDK and Chameleon V3 DTBs.

  2/4  ARM: socfpga: Add default FIT images for Arria 10 SoCDK
       Add default FIT image templates for SPL/U-Boot and the Linux
       kernel under board/altera/arria10-socdk/ so the SoCDK can boot
       via a single mkimage-generated FIT.

  3/4  arm: socfpga: Add Arria 10 SoCDK QSPI and NAND boards
       Add the two new in-tree DTS files, the U-Boot dtsi overlays,
       handoff headers, defconfigs and shared board config bits for
       the QSPI (Cadence QSPI) and NAND (Denali NAND) boot variants.
       The boards intentionally stay on the in-tree DTS rather than
       CONFIG_OF_UPSTREAM because the upstream Linux Arria 10 device
       tree does not expose the clkmgr (and related) labels that
       arch/arm/dts/socfpga_arria10-u-boot.dtsi already references.

  4/4  doc: socfpga: Describe Arria 10 SoCDK QSPI U-Boot and SPL build
       flow
       Document how to build SPL + U-Boot, assemble the default FIT
       images and lay them out on QSPI flash.

Hardware tested
---------------
  - Intel Arria 10 SoCDK rev C, Cadence QSPI flash, SPL + U-Boot
  - Intel Arria 10 SoCDK rev C, Denali NAND flash,  SPL + U-Boot

Dependencies
------------
This series depends on three earlier U-Boot NAND prerequisite changes
already posted to the list:

  1) "mtd: nand: raw: Cadence NAND cleanup" series (2 patches)
     https://lore.kernel.org/u-boot/20260304032441.31558-1-dinesh.maniyam@altera.com/

  2) "mtd: rawnand: denali: add NAND_DENALI_SKIP_BBTSCAN_SPL Kconfig"
     https://lore.kernel.org/u-boot/20260625170153.2593-1-dinesh.maniyam@altera.com/

  3) "mtd: rawnand: allow SYS_NAND_BLOCK_SIZE when SPL_NAND_CADENCE
     is set"
     https://lore.kernel.org/u-boot/20260625170223.2963-1-dinesh.maniyam@altera.com/

Without (1) the SPL Cadence NAND build does not select the right MTD
header and Kconfig dependencies; without (2)/(3) the new Arria 10
NAND defconfig cannot disable the Denali BBT scan in SPL or pick its
own SYS_NAND_BLOCK_SIZE.

Dinesh Maniyam (4):
  arm: dts: socfpga: Update Arria 10 SoCDK U-Boot handoff data
  ARM: socfpga: Add default FIT images for Arria 10 SoCDK
  arm: socfpga: Add Arria 10 SoCDK QSPI and NAND boards
  doc: socfpga: Describe Arria 10 SoCDK QSPI U-Boot and SPL build flow

 arch/arm/dts/socfpga_arria10-handoff.dtsi     |  36 +--
 ...ocfpga_arria10_chameleonv3_270_3_handoff.h | 250 +++++++-------
 ...ocfpga_arria10_chameleonv3_480_2_handoff.h | 250 +++++++-------
 .../socfpga_arria10_socdk_nand-u-boot.dtsi    |  42 +++
 arch/arm/dts/socfpga_arria10_socdk_nand.dts   |  26 ++
 .../dts/socfpga_arria10_socdk_nand_handoff.h  | 305 ++++++++++++++++++
 .../socfpga_arria10_socdk_qspi-u-boot.dtsi    |  48 +++
 arch/arm/dts/socfpga_arria10_socdk_qspi.dts   |  11 +
 .../dts/socfpga_arria10_socdk_qspi_handoff.h  | 305 ++++++++++++++++++
 .../dts/socfpga_arria10_socdk_sdmmc_handoff.h | 262 +++++++--------
 arch/arm/mach-socfpga/qts-filter-a10.sh       |  22 +-
 .../altera/arria10-socdk/fit_kernel_nand.its  |  44 +++
 .../altera/arria10-socdk/fit_kernel_qspi.its  |  44 +++
 board/altera/arria10-socdk/fit_uboot.its      |  43 +++
 configs/socfpga_arria10_nand_defconfig        |  95 ++++++
 configs/socfpga_arria10_qspi_defconfig        |  86 +++++
 doc/README.socfpga_arria10_qspi_socdk         |  56 ++++
 include/configs/socfpga_arria10_socdk.h       |  27 ++
 18 files changed, 1542 insertions(+), 410 deletions(-)
 create mode 100644 arch/arm/dts/socfpga_arria10_socdk_nand-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_arria10_socdk_nand.dts
 create mode 100644 arch/arm/dts/socfpga_arria10_socdk_nand_handoff.h
 create mode 100644 arch/arm/dts/socfpga_arria10_socdk_qspi-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_arria10_socdk_qspi.dts
 create mode 100644 arch/arm/dts/socfpga_arria10_socdk_qspi_handoff.h
 create mode 100644 board/altera/arria10-socdk/fit_kernel_nand.its
 create mode 100644 board/altera/arria10-socdk/fit_kernel_qspi.its
 create mode 100644 board/altera/arria10-socdk/fit_uboot.its
 create mode 100644 configs/socfpga_arria10_nand_defconfig
 create mode 100644 configs/socfpga_arria10_qspi_defconfig
 create mode 100644 doc/README.socfpga_arria10_qspi_socdk

-- 
2.43.7

